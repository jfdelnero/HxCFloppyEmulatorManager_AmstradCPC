using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Make
{
    class Make
    {
        public void Run()
        {
            if (!CompileC())
            {
                Console.WriteLine("Failed to compile C files");
                return;
            }

            if (!PackAssets())
            {
                Console.WriteLine("Failed to pack assets");
                return;
            }

            if (!CompileASM_Core())
            {
                Console.WriteLine("Failed to compile ASM files");
                return;
            }

            string dskFullName;
            if (!Create_DSK_DiscImage(out dskFullName))
            {
                Console.WriteLine("Failed to create DSK disc image");
                return;
            }

            if (!Create_Disc_Version(dskFullName))
            {
                Console.WriteLine("Failed to create disc version");
                return;
            }

            if (!Create_ROM_Version(dskFullName))
            {
                Console.WriteLine("Failed to create ROM version");
                return;
            }

            if (!Create_HFE_DiscImage(dskFullName))
            {
                Console.WriteLine("Failed to create HFE disc image");
                return;
            }
        }

        public bool CompileC()
        {
            string[] files = {
                "crt/_divulong.c",
                "crt/_memcpy.c",
                "crt/_memset.c",
                "crt/_mullong.c",
                "crt/_strcmp.c",
                "crt/_strcpy.c",
                "crt/_strlen.c",
                "crt/_uitoa.c",
                "fat_io_lib/fat_access.c",
                "fat_io_lib/fat_cache.c",
                "fat_io_lib/fat_filelib.c",
                "fat_io_lib/fat_misc.c",
                "fat_io_lib/fat_string.c",
                "fat_io_lib/fat_table.c",
                "fat_io_lib/fat_write.c",
                "hxc/hxc_attach.c",
                "hxc/hxc_config.c",
                "hxc/hxc_error.c",
                "hxc/hxc_init.c",
                "hxc/hxc_io.c",
                "platform/bios.c",
                "platform/firmware.c",
                "ui/ui_browse.c",
                "ui/ui_buzzer.c",
                "ui/ui_dirFlush.c",
                "ui/ui_element.c",
                "ui/ui_font.c",
                "ui/ui_global.c",
                "ui/ui_help.c",
                "ui/ui_init.c",
                "ui/ui_main.c",
                "ui/ui_navigate.c",
                "ui/ui_pathSlotBar.c",
                "ui/ui_quit.c",
                "ui/ui_select.c",
                "ui/ui_slot.c"
            };

            foreach(var file in files)
            {
                Utils.WriteLine(file);

                var fileInfo = new FileInfo(Utils.ToZ80Folder(file));

                var path1 = new Uri(fileInfo.Directory.FullName);
                var path2 = new Uri(fileInfo.Directory.FullName.Substring(0, fileInfo.Directory.FullName.IndexOf("Z80\\")));
                var includePath = path1.MakeRelativeUri(path2).OriginalString;
                includePath = includePath.Substring(0, includePath.Length - 1);

                var asmFilename = fileInfo.Name.Replace(".c", ".asm");
                var asmFullPathFilename = fileInfo.Directory.FullName + "\\" + asmFilename;
                if (File.Exists(asmFullPathFilename))
                {
                    File.Delete(asmFullPathFilename);
                }

                var arguments = "-mz80 -S --no-std-crt0 \"" + fileInfo.Name + "\" -I" + includePath + "";

                string output;
                if (!Utils.StartProcess(fileInfo.Directory.FullName, "sdcc.exe", arguments, out output))
                {
                    Utils.WriteLine("Error: failed to start process (sdcc.exe " + arguments + ")");
                    return false;
                }

                if (!File.Exists(asmFullPathFilename))
                {
                    Utils.WriteLine(output);
                    return false;
                }

                asmFullPathFilename = asmFullPathFilename.Replace("/", "\\");

                var maxamFilename = asmFullPathFilename + ".maxam";
                arguments = "" + asmFullPathFilename + " " + maxamFilename;
                if (!Utils.StartProcess(fileInfo.Directory.FullName, Utils.ToToolsFolder("sdcc2pasmo.exe"), arguments, out output))
                {
                    Utils.WriteLine("Error: failed to start process (sdcc2pasmo.exe " + arguments + ")");
                    return false;
                }

                if (!File.Exists(maxamFilename))
                {
                    Utils.WriteLine("Failed to use sdcc2pasmo on " + maxamFilename);
                    return false;
                }

                File.Delete(asmFullPathFilename);
                File.Move(maxamFilename, asmFullPathFilename);
            }

            return true;
        }

        public bool PackAssets()
        {
            string[] files = {
                "assets/background.bmp.sprRawData1",
                "assets/regularFont.bmp.font",
                "assets/tinyFont.bmp.font"
            };

            foreach(var file in files)
            {
                var fileInfo = new FileInfo(Utils.ToZ80Folder(file));

                var binFullName = fileInfo.FullName;

                var binName = fileInfo.Name;
                string packedFullName;
                Utils.WriteLine(binName);
                if (!PackBin(binFullName, out packedFullName))
                {
                    Utils.WriteLine("Failed to pack " + binName);
                    return false;
                }

                Utils.WriteLine(new FileInfo(packedFullName).Name);
            }

            return true;
        }

        public bool CompileASM_Core()
        {
            var file = "core.asm";

            string binFullName;
            Utils.WriteLine(file);
            if (!CompileASM(Utils.ToZ80Folder(file), out binFullName))
            {
                Utils.WriteLine("Failed to compile " + file);
                return false;
            }

            var binName = new FileInfo(binFullName).Name;
            string packedFullName;
            Utils.WriteLine(binName);
            if (!PackBin(binFullName, out packedFullName))
            {
                Utils.WriteLine("Failed to pack " + binName);
                return false;
            }

            var pckName = new FileInfo(packedFullName).Name;
            Utils.WriteLine(pckName);
            return true;
        }

        public bool Create_DSK_DiscImage(out string dskFullName)
        {
            var dskName = "hxc_v35.dsk";
            Utils.WriteLine(dskName);
            var exeDirectory = new FileInfo(System.Reflection.Assembly.GetExecutingAssembly().FullName).Directory.FullName;
            var emptyDskFullName = exeDirectory + "\\empty.dsk";
            dskFullName = GetBinDirectory() + dskName;

            if (File.Exists(dskFullName))
            {
                File.Delete(dskFullName);
            }
            File.Copy(emptyDskFullName, dskFullName);

            return true;
        }

        public bool Create_Disc_Version(string dskFullName)
        {
            var file = "disc.asm";

            string binFullName;
            Utils.WriteLine(file);
            if (!CompileASM(Utils.ToZ80Folder(file), out binFullName))
            {
                Utils.WriteLine("Failed to compile " + file);
                return false;
            }

            var binName = new FileInfo(binFullName).Name;
            Utils.WriteLine(binName);

            var amsdosFilename = "HXC.";
            if (!InjectBasicIntoDSK(dskFullName, binFullName, amsdosFilename))
            {
                Utils.WriteLine("Failed to inject " + amsdosFilename);
                return false;
            }
            
            return true;
        }

        public bool Create_ROM_Version(string dskFullName)
        {
            var file = "rom.asm";

            string binFullName;
            Utils.WriteLine(file);
            if (!CompileASM(Utils.ToZ80Folder(file), out binFullName))
            {
                Utils.WriteLine("Failed to compile " + file);
                return false;
            }

            var binName = new FileInfo(binFullName).Name;
            
            var romFile = "HXC35.ROM";
            Utils.WriteLine(romFile);
            var romFullName = GetBinDirectory() + romFile;
            if(File.Exists(romFullName))
            {
                File.Delete(romFullName);
            }
            File.Copy(binFullName, romFullName);

            var amsdosFilename = "HXC35.ROM";
            if (!InjectBinIntoDSK(dskFullName, binFullName, amsdosFilename, 0xC000, 0x0000 ))
            {
                Utils.WriteLine("Failed to inject " + amsdosFilename);
                return false;
            }

            return true;
        }

        public bool Create_HFE_DiscImage(string dskFullName)
        {
            var dskFileInfo = new FileInfo(dskFullName);

            var hfeName = dskFileInfo.Name.Replace(".dsk", ".hfe");
            Utils.WriteLine(hfeName);

            var hfeFullName = new FileInfo(dskFullName).Directory.FullName + "\\" + hfeName;
            if (File.Exists(hfeFullName))
            {
                File.Delete(hfeFullName);
            }

            var arguments = GetBinDirectory() + " " + GetBinDirectory();
            string output;
            if (!Utils.StartProcess(dskFileInfo.Directory.FullName, Utils.ToToolsFolder("flopimage_convert.exe"), arguments, out output))
            {
                Utils.WriteLine("Error: failed to start process (flopimage_convert.exe " + arguments + ")");
                return false;
            }

            var flopImageConvertHFEName = dskFileInfo.Name.Replace(".dsk", "_dsk") + ".hfe";
            var flopImageConvertHFEFullName = new FileInfo(dskFullName).Directory.FullName + "\\" + flopImageConvertHFEName;
            File.Move(flopImageConvertHFEFullName, hfeFullName);

            return true;
        }

        private string GetBinDirectory()
        {
            var exeDirectory = new FileInfo(System.Reflection.Assembly.GetExecutingAssembly().FullName).Directory.FullName;
            var rootDirectory = exeDirectory.Substring(0, exeDirectory.IndexOf("src\\"));
            var binDirectory = rootDirectory + "build\\";
            return binDirectory;
        }

        private bool InjectBasicIntoDSK(string dskFullName, string basicFullName, string amsdosFilename)
        {
            string arguments = "-L\"" + dskFullName + "\" ";
            arguments += "-I\"" + basicFullName + "\"";
            arguments += "/" + amsdosFilename;
            arguments += "/BAS/368";

            arguments += " ";
            arguments += "-S\"" + dskFullName + "\"";

            string output;
            if (!Utils.StartProcess(new FileInfo(dskFullName).Directory.FullName, Utils.ToToolsFolder("ManageDsk.exe"), arguments, out output))
            {
                Utils.WriteLine("Error: failed to start process (ManageDsk.exe " + arguments + ")");
                return false;
            }

            return true;
        }

        private bool InjectBinIntoDSK(string dskFullName, string binFullName, string amsdosFilename, ushort loadAddress, ushort execAddress)
        {
            string arguments = "-L\"" + dskFullName + "\" ";
            arguments += "-I\"" + binFullName + "\"";
            arguments += "/" + amsdosFilename;
            arguments += "/BIN";
            arguments += "/" + loadAddress;
            arguments += "/" + execAddress;

            arguments += " ";
            arguments += "-S\"" + dskFullName + "\"";

            string output;
            if (!Utils.StartProcess(new FileInfo(dskFullName).Directory.FullName, Utils.ToToolsFolder("ManageDsk.exe"), arguments, out output))
            {
                Utils.WriteLine("Error: failed to start process (ManageDsk.exe " + arguments + ")");
                return false;
            }

            return true;
        }

        private bool CompileASM(string asmFilename, out string binFullName)
        {
            var fileInfo = new FileInfo(asmFilename);

            var binName = fileInfo.Name.Replace(".asm", ".bin");
            binFullName = fileInfo.FullName.Replace(".asm", ".bin");

            if (File.Exists(binFullName))
            {
                File.Delete(binFullName);
            }

            var arguments = "--bin " + fileInfo.Name + " " + binName;

            string output;
            if (!Utils.StartProcess(fileInfo.Directory.FullName, Utils.ToToolsFolder("pasmo.exe"), arguments, out output))
            {
                Utils.WriteLine("Error: failed to start process (pasmo.exe " + arguments + ")");
                return false;
            }

            if (!File.Exists(binFullName))
            {
                Utils.WriteLine(output);
                return false;
            }

            return true;
        }

        private bool PackBin(string binFilename, out string packedFullName)
        {
            var fileInfo = new FileInfo(binFilename);

            var pckName = binFilename + ".pck";
            packedFullName = fileInfo.FullName + ".pck";

            if (File.Exists(packedFullName))
            {
                File.Delete(packedFullName);
            }

            var arguments = "" + fileInfo.Name;

            string output;
            if (!Utils.StartProcess(fileInfo.Directory.FullName, Utils.ToToolsFolder("bitbuster.exe"), arguments, out output))
            {
                Utils.WriteLine("Error: failed to start process (bitbuster.exe " + arguments + ")");
                return false;
            }

            if (!File.Exists(packedFullName))
            {
                Utils.WriteLine(output);
                return false;
            }

            return true;
        }
    }
}
