//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//					        FAT16/32 File IO Library
//								    V2.6
// 	  							 Rob Riglar
//						    Copyright 2003 - 2010
//
//   					  Email: rob@robriglar.com
//
//								License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fat_io_lib\fat_defs.h"
#include "fat_io_lib\fat_access.h"
#include "fat_io_lib\fat_table.h"
#include "fat_io_lib\fat_write.h"
#include "fat_io_lib\fat_misc.h"
#include "fat_io_lib\fat_string.h"
#include "fat_io_lib\fat_filelib.h"
#include "fat_io_lib\fat_cache.h"

void * z80_memset( void *dst, char value, int acount );

//-----------------------------------------------------------------------------
// Locals
//-----------------------------------------------------------------------------
static FL_FILE			_files[FATFS_MAX_OPEN_FILES];

static int				_filelib_init = 0;
static int				_filelib_valid = 0;
struct fatfs		        _fs;
static FL_FILE*			_open_file_list = NULL;
static FL_FILE*			_free_file_list = NULL;
char currentfolder[80];

//-----------------------------------------------------------------------------
// Macros
//-----------------------------------------------------------------------------

// Macro for checking if file lib is initialised
#define CHECK_FL_INIT()		{ if (_filelib_init==0) fl_init(); }

#define FL_LOCK(a)
#define FL_UNLOCK(a)

//-----------------------------------------------------------------------------
// Local Functions
//-----------------------------------------------------------------------------
static void				_fl_init();

//-----------------------------------------------------------------------------
// _allocate_file: Find a slot in the open files buffer for a new file
//-----------------------------------------------------------------------------
static FL_FILE* _allocate_file(void)
{
	// Allocate free file
	FL_FILE* file = _free_file_list;

	if (file)
	{
		_free_file_list = file->next;

		// Add to open list
		file->next = _open_file_list;
		_open_file_list = file;
	}

	return file;
}
//-----------------------------------------------------------------------------
// _check_file_open: Returns true if the file is already open
//-----------------------------------------------------------------------------
/*static int _check_file_open(FL_FILE* file)
{
	FL_FILE* openFile = _open_file_list;

	// Compare open files
	while (openFile)
	{
		// If not the current file
		if (openFile != file)
		{
			// Compare path and name
			if ( (fatfs_compare_names(openFile->path,file->path)) && (fatfs_compare_names(openFile->filename,file->filename)) )
				return 1;
		}

		openFile = openFile->next;
	}

	return 0;
}*/
//-----------------------------------------------------------------------------
// _free_file: Free open file handle
//-----------------------------------------------------------------------------
static void _free_file(FL_FILE* file)
{
	FL_FILE* openFile = _open_file_list;
	FL_FILE* lastFile = NULL;

	// Remove from open list
	while (openFile)
	{
		// If the current file
		if (openFile == file)
		{
			if (lastFile)
				lastFile->next = openFile->next;
			else
				_open_file_list = openFile->next;

			break;
		}

		lastFile = openFile;
		openFile = openFile->next;
	}

	// Add to free list
	file->next = _free_file_list;
	_free_file_list = file;
}

//-----------------------------------------------------------------------------
//								Low Level
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// _open_directory: Cycle through path string to find the start cluster
// address of the highest subdir.
//-----------------------------------------------------------------------------
static int _open_directory(char *path, unsigned long *pathCluster)
{
	int levels;
	int sublevel;
	struct fat_dir_entry sfEntry;
	unsigned long startcluster;

	// Set starting cluster to root cluster
	startcluster = fatfs_get_root_cluster(&_fs);

	// Find number of levels
	levels = fatfs_total_path_levels(path);

	// Cycle through each level and get the start sector
	for (sublevel=0;sublevel<(levels+1);sublevel++)
	{
		if (fatfs_get_substring(path, sublevel, currentfolder, sizeof(currentfolder)) == -1)
			return 0;

		// Find clusteraddress for folder (currentfolder)
		if (fatfs_get_file_entry(&_fs, startcluster, currentfolder,&sfEntry))
		{
			// Check entry is folder
			if (fatfs_entry_is_dir(&sfEntry))
				startcluster = (((unsigned long)ENDIAN_16BIT(sfEntry.FstClusHI))<<16) | ENDIAN_16BIT(sfEntry.FstClusLO);
			else
				return 0;
		}
		else
			return 0;
	}

	*pathCluster = startcluster;
	return 1;
}
//-----------------------------------------------------------------------------
// _open_file: Open a file for reading
//-----------------------------------------------------------------------------
static FL_FILE* _open_file(char *path)
{
	FL_FILE* file;
	struct fat_dir_entry sfEntry;

	// Allocate a new file handle
	file = _allocate_file();
	if (!file)
		return NULL;

	// Clear filename
	//z80_memset(file->path, '\0', sizeof(file->path));
	z80_memset(file->filename, '\0', sizeof(file->filename));

	// Split full path into filename and directory path
	if (fatfs_split_path((char*)path, 0, 0, file->filename, sizeof(file->filename)) == -1)
	{
		_free_file(file);
		return NULL;
	}

	// Check if file already open
/*	if (_check_file_open(file))
	{
		_free_file(file);
		return NULL;
	}*/

        file->parentcluster = fatfs_get_root_cluster(&_fs);

	// If file is in the root dir
	/*if (file->path[0]==0)
		file->parentcluster = fatfs_get_root_cluster(&_fs);
	else
	{
		// Find parent directory start cluster
		if (!_open_directory(file->path, &file->parentcluster))
		{
			_free_file(file);
			return NULL;
		}
	}*/

	// Using dir cluster address search for filename
	if (fatfs_get_file_entry(&_fs, file->parentcluster, file->filename,&sfEntry))
		// Make sure entry is file not dir!
		if (fatfs_entry_is_file(&sfEntry))
		{
			// Initialise file details
			memcpy(file->shortfilename, sfEntry.Name, FAT_SFN_SIZE_FULL);
			file->filelength = ENDIAN_32BIT(sfEntry.FileSize);
			file->bytenum = 0;
			file->startcluster = (((unsigned long)ENDIAN_16BIT(sfEntry.FstClusHI))<<16) + ENDIAN_16BIT(sfEntry.FstClusLO);
			file->file_data.address = 0xFFFFFFFF;
			file->file_data.dirty = 0;
			file->filelength_changed = 0;

			// Quick lookup for next link in the chain
			file->last_fat_lookup.ClusterIdx = 0xFFFFFFFF;
			file->last_fat_lookup.CurrentCluster = 0xFFFFFFFF;

			fatfs_cache_init(&_fs, file);

			fatfs_fat_purge(&_fs);

			return file;
		}

	_free_file(file);
	return NULL;
}
//-----------------------------------------------------------------------------
// _read_sector: Read a sector from disk to file
//-----------------------------------------------------------------------------
static int _read_sector(FL_FILE* file, UINT32 offset)
{
	UINT32 Sector = 0;
	UINT32 ClusterIdx = 0;
	UINT32 Cluster = 0;
	UINT32 i;
	UINT32 lba;

	// Find cluster index within file & sector with cluster
	ClusterIdx = offset / _fs.sectors_per_cluster;
	Sector = offset - (ClusterIdx * _fs.sectors_per_cluster);

	// Quick lookup for next link in the chain
	if (ClusterIdx == file->last_fat_lookup.ClusterIdx)
		Cluster = file->last_fat_lookup.CurrentCluster;
	// Else walk the chain
	else
	{
		// Starting from last recorded cluster?
		if (ClusterIdx && ClusterIdx == file->last_fat_lookup.ClusterIdx + 1)
		{
			i = file->last_fat_lookup.ClusterIdx;
			Cluster = file->last_fat_lookup.CurrentCluster;
		}
		// Start searching from the beginning..
		else
		{
			// Set start of cluster chain to initial value
			i = 0;
			Cluster = file->startcluster;
		}

		// Follow chain to find cluster to read
		for ( ;i<ClusterIdx; i++)
		{
			UINT32 nextCluster;

			// Does the entry exist in the cache?
			if (!fatfs_cache_get_next_cluster(&_fs, file, i, &nextCluster))
			{
				// Scan file linked list to find next entry
				nextCluster = fatfs_find_next_cluster(&_fs, Cluster);

				// Push entry into cache
				fatfs_cache_set_next_cluster(&_fs, file, i, nextCluster);
			}

			Cluster = nextCluster;
		}

		// Record current cluster lookup details (if valid)
		if (Cluster != FAT32_LAST_CLUSTER)
		{
			file->last_fat_lookup.CurrentCluster = Cluster;
			file->last_fat_lookup.ClusterIdx = ClusterIdx;
		}
	}

	// If end of cluster chain then return false
	if (Cluster == FAT32_LAST_CLUSTER)
		return 0;

	// Calculate sector address
	lba = fatfs_lba_of_cluster(&_fs, Cluster) + Sector;

	// Read sector of file
	return fatfs_sector_read(&_fs, lba, file->file_data.sector);
}

//-----------------------------------------------------------------------------
//								External API
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// fl_init: Initialise library
//-----------------------------------------------------------------------------
void fl_init(void)
{
	int i;

	// Add all file objects to free list
	for (i=0;i<FATFS_MAX_OPEN_FILES;i++)
	{
		_files[i].next = _free_file_list;
		_free_file_list = &_files[i];
	}

	_filelib_init = 1;
}
//-----------------------------------------------------------------------------
// fl_attach_media:
//-----------------------------------------------------------------------------
int fl_attach_media(fn_diskio_read rd, fn_diskio_write wr)
{
	int res;

	// If first call to library, initialise
	CHECK_FL_INIT();

	_fs.disk_io.read_sector = rd;
	_fs.disk_io.write_sector = wr;

	// Initialise FAT parameters
	if ((res = fatfs_init(&_fs)) != FAT_INIT_OK)
	{
		FAT_PRINTF(("FAT_FS: Error could not load FAT details (%d)!\r\n", res));
		return res;
	}

	_filelib_valid = 1;
	return FAT_INIT_OK;
}
//-----------------------------------------------------------------------------
// fl_shutdown: Call before shutting down system
//-----------------------------------------------------------------------------
void fl_shutdown(void)
{
	// If first call to library, initialise
	CHECK_FL_INIT();

	FL_LOCK(&_fs);
	fatfs_fat_purge(&_fs);
	FL_UNLOCK(&_fs);
}
//-----------------------------------------------------------------------------
// fopen: Open or Create a file for reading or writing
//-----------------------------------------------------------------------------
void* fl_fopen(char *path, const char *mode)
{
	FL_FILE* file;
	unsigned char flags = 0;

	// If first call to library, initialise
	CHECK_FL_INIT();

	if (!_filelib_valid)
		return NULL;

	if (!path || !mode)
		return NULL;

	// Supported Modes:
	// "r" Open a file for reading. The file must exist.
	// "w" Create an empty file for writing. If a file with the same name already exists its content is erased and the file is treated as a new empty file.
	// "a" Append to a file. Writing operations append data at the end of the file. The file is created if it does not exist.
	// "r+" Open a file for update both reading and writing. The file must exist.
	// "w+" Create an empty file for both reading and writing. If a file with the same name already exists its content is erased and the file is treated as a new empty file.
	// "a+" Open a file for reading and appending. All writing operations are performed at the end of the file, protecting the previous content to be overwritten. You can reposition (fseek, rewind) the internal pointer to anywhere in the file for reading, but writing operations will move it back to the end of file. The file is created if it does not exist.

	flags |= FILE_READ;

	file = NULL;

	FL_LOCK(&_fs);

		file = _open_file(path);


	if (file)
		file->flags = flags;

	FL_UNLOCK(&_fs);
	return file;
}
//-----------------------------------------------------------------------------
// _write_sector: Write sector to disk
//-----------------------------------------------------------------------------
#ifdef FATFS_INC_WRITE_SUPPORT
static int _write_sector(FL_FILE* file, UINT32 offset, unsigned char *buf)
{
	UINT32 SectorNumber = 0;
	UINT32 ClusterIdx = 0;
	UINT32 Cluster = 0;
	UINT32 LastCluster = FAT32_LAST_CLUSTER;
	UINT32 i;

	// Find values for Cluster index & sector within cluster
	ClusterIdx = offset / _fs.sectors_per_cluster;
	SectorNumber = offset - (ClusterIdx * _fs.sectors_per_cluster);

	// Quick lookup for next link in the chain
	if (ClusterIdx == file->last_fat_lookup.ClusterIdx)
		Cluster = file->last_fat_lookup.CurrentCluster;
	// Else walk the chain
	else
	{
		// Starting from last recorded cluster?
		if (ClusterIdx && ClusterIdx == file->last_fat_lookup.ClusterIdx + 1)
		{
			i = file->last_fat_lookup.ClusterIdx;
			Cluster = file->last_fat_lookup.CurrentCluster;
		}
		// Start searching from the beginning..
		else
		{
			// Set start of cluster chain to initial value
			i = 0;
			Cluster = file->startcluster;
		}

		// Follow chain to find cluster to read
		for ( ;i<ClusterIdx; i++)
		{
			UINT32 nextCluster;

			// Does the entry exist in the cache?
			if (!fatfs_cache_get_next_cluster(&_fs, file, i, &nextCluster))
			{
				// Scan file linked list to find next entry
				nextCluster = fatfs_find_next_cluster(&_fs, Cluster);

				// Push entry into cache
				fatfs_cache_set_next_cluster(&_fs, file, i, nextCluster);
			}

			LastCluster = Cluster;
			Cluster = nextCluster;

			// Dont keep following a dead end
			if (Cluster == FAT32_LAST_CLUSTER)
				break;
		}

		// If we have reached the end of the chain, allocate more!
		if (Cluster == FAT32_LAST_CLUSTER)
		{
			// Add another cluster to the last good cluster chain
			if (!fatfs_add_free_space(&_fs, &LastCluster))
				return 0;

			Cluster = LastCluster;
		}

		// Record current cluster lookup details
		file->last_fat_lookup.CurrentCluster = Cluster;
		file->last_fat_lookup.ClusterIdx = ClusterIdx;
	}

	return fatfs_write_sector(&_fs, Cluster, SectorNumber, buf);
}
#endif

//-----------------------------------------------------------------------------
// fl_fclose: Close an open file
//-----------------------------------------------------------------------------
void fl_fclose(void *f)
{
	FL_FILE *file = (FL_FILE *)f;

	// If first call to library, initialise
	CHECK_FL_INIT();

	if (file)
	{
		FL_LOCK(&_fs);

		// Flush un-written data to file
		//fl_fflush(f);

		// File size changed?
		if (file->filelength_changed)
		{
			file->filelength_changed = 0;
		}

		file->bytenum = 0;
		file->filelength = 0;
		file->startcluster = 0;
		file->file_data.address = 0xFFFFFFFF;
		file->file_data.dirty = 0;
		file->filelength_changed = 0;

		// Free file handle
		_free_file(file);

		fatfs_fat_purge(&_fs);

		FL_UNLOCK(&_fs);
	}
}
//-----------------------------------------------------------------------------
// fl_fread: Read a block of data from the file
//-----------------------------------------------------------------------------
int fl_fread(void * buffer, int size, int length, void *f )
{
	unsigned long sector;
	unsigned long offset;
	int copyCount,c;
	int count = size * length;
	int bytesRead = 0;
	unsigned char *dst;
	unsigned char *src;


	FL_FILE *file = (FL_FILE *)f;

	// If first call to library, initialise
	CHECK_FL_INIT();

	if (buffer==NULL || file==NULL)
		return -1;

	// No read permissions
	if (!(file->flags & FILE_READ))
		return -1;

	// Nothing to be done
	if (!count)
		return 0;

	// Check if read starts past end of file
	if (file->bytenum >= file->filelength)
		return -1;

	// Limit to file size
	if ( (file->bytenum + count) > file->filelength )
		count = file->filelength - file->bytenum;

	// Calculate start sector
	sector = file->bytenum / FAT_SECTOR_SIZE;

	// Offset to start copying data from first sector
	offset = file->bytenum % FAT_SECTOR_SIZE;

	while (bytesRead < count)
	{
		// Do we need to re-read the sector?
		if (file->file_data.address != sector)
		{
			// Flush un-written data to file
			//if (file->file_data.dirty)
			//	fl_fflush(file);

			// Get LBA of sector offset within file
			if (!_read_sector(file, sector))
				// Read failed - out of range (probably)
				break;

			file->file_data.address = sector;
			file->file_data.dirty = 0;
		}

		// We have upto one sector to copy
		copyCount = FAT_SECTOR_SIZE - offset;

		// Only require some of this sector?
		if (copyCount > (count - bytesRead))
			copyCount = (count - bytesRead);

		// Copy to application buffer
 //	dst=(unsigned char*)((unsigned char*)buffer + bytesRead);
///	src=(unsigned char*)(file->file_data.sector + offset);
	//hxc_memcpy( ((unsigned char*)buffer + bytesRead), file->file_data.sector + offset, copyCount);
 	dst=(unsigned char*)((unsigned char*)buffer + bytesRead);
	src=(unsigned char*)(file->file_data.sector + offset);
	c=0;
	do
	{

		dst[c]=src[c];
		c++;
	}while(c<copyCount);

		// Increase total read count
		bytesRead += copyCount;

		// Increment file pointer
		file->bytenum += copyCount;

		// Move onto next sector and reset copy offset
		sector++;
		offset = 0;
	}

	return bytesRead;
}


int fl_fswrite(unsigned char * buffer, int size,int start_sector, void *f)
{
	unsigned long sector;
	int cnt;

	FL_FILE *file = (FL_FILE *)f;

	// If first call to library, initialise
	CHECK_FL_INIT();

	if (buffer==NULL || file==NULL)
		return -1;

	// Check if read starts past end of file
	if (file->bytenum >= file->filelength)
		return -1;

	// Calculate start sector
	sector = start_sector;//file->bytenum / FAT_SECTOR_SIZE;
	cnt=size;
	while (cnt)
	{
                if (!fatfs_write_sector(&_fs, file->startcluster, sector, buffer))
                {   	// Read failed - out of range (probably)
                   return -1;
                }

                buffer=buffer+512;

		// Move onto next sector and reset copy offset
		sector++;
		cnt--;
	}

	return size;
}


//-----------------------------------------------------------------------------
// fl_fseek: Seek to a specific place in the file
//-----------------------------------------------------------------------------
int fl_fseek( void *f, long offset, int origin )
{
	FL_FILE *file = (FL_FILE *)f;
	int res = -1;

	// If first call to library, initialise
	CHECK_FL_INIT();

	if (!file)
		return -1;

	if (origin == SEEK_END && offset != 0)
		return -1;

	FL_LOCK(&_fs);

	// Invalidate file buffer
	file->file_data.address = 0xFFFFFFFF;
	file->file_data.dirty = 0;

	if (origin == SEEK_SET)
	{
		file->bytenum = (unsigned long)offset;

		if (file->bytenum > file->filelength)
			file->bytenum = file->filelength;

		res = 0;
	}
	else if (origin == SEEK_CUR)
	{
		// Positive shift
		if (offset >= 0)
		{
			file->bytenum += offset;

			if (file->bytenum > file->filelength)
				file->bytenum = file->filelength;
		}
		// Negative shift
		else
		{
			// Make shift positive
			offset = -offset;

			// Limit to negative shift to start of file
			if ((unsigned long)offset > file->bytenum)
				file->bytenum = 0;
			else
				file->bytenum-= offset;
		}

		res = 0;
	}
	else if (origin == SEEK_END)
	{
		file->bytenum = file->filelength;
		res = 0;
	}
	else
		res = -1;

	FL_UNLOCK(&_fs);

	return res;
}

//-----------------------------------------------------------------------------
// fl_listdirectory: List a directory based on a path
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// fl_list_opendir: Opens a directory for listing
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fl_list_opendir( char *path, struct fs_dir_list_status *dirls)
{
	int levels;
	UINT32 cluster = FAT32_INVALID_CLUSTER;

	// If first call to library, initialise
	CHECK_FL_INIT();

	FL_LOCK(&_fs);

	levels = fatfs_total_path_levels((char*)path) + 1;

	// If path is in the root dir
	if (levels == 0)
		cluster = fatfs_get_root_cluster(&_fs);
	// Find parent directory start cluster
	else
		_open_directory((char*)path, &cluster);

	fatfs_browse_cache_init(&_fs);

	fatfs_list_directory_start(&_fs, dirls, cluster);

	FL_UNLOCK(&_fs);

	return cluster != FAT32_INVALID_CLUSTER ? 1 : 0;
}
#endif
//-----------------------------------------------------------------------------
// fl_list_readdir: Get next item in directory
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fl_list_readdir(struct fs_dir_list_status *dirls, struct fs_dir_ent *entry)
{
	int res = 0;

	// If first call to library, initialise
	CHECK_FL_INIT();

	FL_LOCK(&_fs);

	res = fatfs_list_directory_next(&_fs, dirls, entry);

	FL_UNLOCK(&_fs);

	return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_is_dir: Is this a directory?
//-----------------------------------------------------------------------------
int fl_is_dir(char *path)
{
	unsigned long cluster = 0;

	if (_open_directory((char*)path, &cluster))
		return 1;
	else
		return 0;
}
