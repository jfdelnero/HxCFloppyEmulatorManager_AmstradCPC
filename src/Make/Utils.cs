using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Make
{
    public static class Utils
    {
        static public string GetRootDirectory()
        {
            var path = Environment.CurrentDirectory + "\\..\\..\\..\\..\\";
            return path;
        }

        static public string ToZ80Folder(string relativePathInZ80)
        {
            var path = GetRootDirectory() + "src/Z80/" + relativePathInZ80;

            path = path.Replace("\\", "/");
            if (Environment.OSVersion.Platform != PlatformID.Unix)
            {
                path = path.Replace("/", "\\");
            }

            return path;
        }

        static public string ToToolsFolder(string relativePathInTools)
        {
            var path = GetRootDirectory() + "tools/" + relativePathInTools;

            path = path.Replace("\\", "/");
            if (Environment.OSVersion.Platform != PlatformID.Unix)
            {
                path = path.Replace("/", "\\");
            }

            return path;
        }

        static public bool StartProcess(string filename, string arguments, out string output)
        {
            return StartProcess(GetRootDirectory(), filename, arguments, out output);
        }

        static public void WriteLine(string line)
        {
            Console.WriteLine(line);
            Debug.WriteLine(line);
        }

        static public bool StartProcess(string workingDirectory, string filename, string arguments, out string output)
        {
            output = String.Empty;

            var startInfo = new ProcessStartInfo();
            startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = false;
            startInfo.WorkingDirectory = workingDirectory;
            startInfo.FileName = filename;
            startInfo.Arguments = arguments;
            startInfo.RedirectStandardError = true;
            try
            {
                using (Process exeProcess = Process.Start(startInfo))
                {
                    var standardError = exeProcess.StandardError.ReadToEnd();
                    output += standardError;

                    exeProcess.WaitForExit();
                }
            }
            catch (Exception exception)
            {
                WriteLine(exception.ToString());
                return false;
            }

            return true;
        }
    }
}
