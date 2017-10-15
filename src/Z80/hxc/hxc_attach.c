
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "platform\bios.h"
#include "hxc\hxc_struct.h"
#include "hxc\hxc_define.h"
#include "fat_io_lib\fat_filelib.h"
#include "hxc\hxc_io.h"

// ----------------------------------------------------------------------------
char HxC_Attach(char *errorCode)
{
	MediaInit();

#ifdef USE_CPCEMU
#else
	if ( fl_attach_media( MediaRead, MediaWrite ) != FAT_INIT_OK )
	{
		*errorCode = HXCERROR_ATTACHMEDIAFAILED;
		return OPERATIONRESULT_ERROR;
	}
#endif

	*errorCode = HXCERROR_OK;
	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
char HxC_Detach(char *errorCode)
{
	if (!MediaQuit())
	{
		*errorCode = HXCERROR_CMDSETTRACKPOS;
		return OPERATIONRESULT_ERROR;
	}

	*errorCode = HXCERROR_OK;
	return OPERATIONRESULT_SUCCESS;
}
