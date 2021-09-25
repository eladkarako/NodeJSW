<h1>NodeJSW</h1>
<h2><em>NodeJS without console window ❌⬛.</em></h2>

x64 original: <br/>
<a href="https://nodejs.org/download/nightly/v17.0.0-nightly202109258d83c47029/win-x64/node.exe">https://nodejs.org/download/nightly/v17.0.0-nightly202109258d83c47029/win-x64/node.exe</a>

x64 mod: <br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x64/node.exe.zip" download="node.exe.zip">win-x64/node.exe.zip</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x64/node.exe.md5" download="node.exe.md5">win-x64/node.exe.md5</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x64/node.exe.sha256" download="node.exe.sha256">win-x64/node.exe.sha256</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x64/node.exe.sha512" download="node.exe.sha512">win-x64/node.exe.sha512</a><br/>

x86 original: <br/>
<a href="https://nodejs.org/download/nightly/v17.0.0-nightly202109258d83c47029/win-x86/node.exe">https://nodejs.org/download/nightly/v17.0.0-nightly202109258d83c47029/win-x86/node.exe</a>

x64 mod: <br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x86/node.exe.zip" download="node.exe.zip">win-x86/node.exe.zip</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x86/node.exe.md5" download="node.exe.md5">win-x86/node.exe.md5</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x86/node.exe.sha256" download="node.exe.sha256">win-x86/node.exe.sha256</a><br/>
<a href="https://raw.githubusercontent.com/eladkarako/NodeJSW/master/resources/v17.0.0-nightly202109258d83c47029/win-x86/node.exe.sha512" download="node.exe.sha512">win-x86/node.exe.sha512</a><br/>

<hr/>
notes: <br/>
no code change, <br/>
exe will show invalid signature (obviously, since the exe has been modified..).
you are advised to scan with anti-virus, send to virus total, or follow instructions below, or scripts under resources folder, to do it yourself without downloading anything from this repository...

<hr/>

<details><summary>how/way - TL;DR</summary>

<a href="https://github.com/nodejs/node/issues/556#issuecomment-921471672">https://github.com/nodejs/node/issues/556#issuecomment-921471672</a>

<details><summary>content..</summary>

> execute script without console window showing.

@aleeksunder  

<ul>
<li>
<details><summary>normally setting a <a href="https://docs.microsoft.com/en-us/cpp/build/reference/subsystem">subsystem</a> is done by <code>link.exe</code> in the building process, but you can absolutely use <code><a href="https://docs.microsoft.com/en-us/cpp/build/reference/editbin-reference">editbin.exe</a></code> along with <code>/SUBSYSTEM</a>:WINDOWS</code> to change most of VC-compiled exe-s (and it &ast;probably&ast; won't break your exe..) .</summary>

<code>editbin.exe /NOLOGO /SUBSYSTEM:WINDOWS "node.exe"</code> (console'less)  
<code>editbin.exe /NOLOGO /SUBSYSTEM:CONSOLE "node.exe"</code> (bring it back)  

<details><summary>where to find <code>editbin.exe</code>?</summary>  
it comes with all visual studio build tools,  
and you most likely already have it since nodejs installation will install it for you (along with python),  
you'll find it in a similar path to this:  
<code>C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30037\bin\Hostx86\x86\editbin.exe</code> (<code>14.29.30037</code> would probably be something else).  
</details>
</details>
</li>
<li>
<details><summary>get single serve node.exe for your patching experiment</summary> at <a href="https://nodejs.org/download/nightly/">https://nodejs.org/download/nightly/</a>  
for example:  
<a href="https://nodejs.org/download/nightly/v17.0.0-nightly20210916f182b9b29f/win-x86/node.exe">https://nodejs.org/download/nightly/v17.0.0-nightly20210916f182b9b29f/win-x86/node.exe</a>  
which should work perfectly fine on both x86 and amd64. no installation needed and you can move it around or place it in your disk-on-key along with the script. you need to mark it safe once on Windows after downloading it (file properties).
</details>
</li>
<li>
<details><summary>don't forget about logs and errors (and STDOUT/STDERR pipes..)</summary>  
you might want to still be able to log some stuff from your patched node.exe

changing the subsystem to windows means you probably will not be able to redirect the stdout and stderr pipes using something as simple as <code>node.exe myscript.js 1&gt;my_stdout.log 2&gt;my_stderr.log</code> anymore,  
you can try hooking the pipes internally to write to a file but it probably will not work (operation system limits to windows app)  
<a href="https://stackoverflow.com/questions/8393636/node-log-in-a-file-instead-of-the-console">https://stackoverflow.com/questions/8393636/node-log-in-a-file-instead-of-the-console</a>  
and <a href="https://stackoverflow.com/questions/32719923/redirecting-stdout-to-file-nodejs">https://stackoverflow.com/questions/32719923/redirecting-stdout-to-file-nodejs</a>  

(if it works for you you might want to set <code>NODE_DISABLE_COLORS=1</code> to avoid some weird characters in your log files).  

as for unexpected errors and warnings, node has built-in feature to redirect at least some of the information to a file,  
see <code>NODE_REDIRECT_WARNINGS</code> or <code>--redirect-warnings</code>: https://nodejs.org/api/cli.html#cli_node_redirect_warnings_file .  

again, information dumped into the STDOUT and STDERR will likely will not work.

but if it does, you can ignore some known warnings (not advised) with <code>NODE_SKIP_PLATFORM_CHECK=1</code> and <code>NODE_NO_WARNINGS=1</code>.
</details>
</li>
<li>
<details><summary>another approach is to use a "launcher" to launch <code>node.exe</code> hidden, which does not requires any patching..</summary>  

which is a simple exe that runs another exe with arguments and initial state of the window, which may be "hidden". the launcher needs to be written in a language that allows you to set its subsystem more easily,  
for example you can create a simple C# console program, then use the project properties to set it to Windows subsystem,  
the program does not have to be very smart, nor to accept any arguments,
here is a working <code>ShellExecuteExW</code> example (it is a variation of the <code>ShellExecute</code> API that has  Unicode support and some extended features):  

```csharp
  using System.Runtime.InteropServices;

//.....
//.....
//.....

  class Program{
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct SHELLEXECUTEINFO{
      public uint cbSize;
      public uint fMask;
      public IntPtr hwnd;
      [MarshalAs(UnmanagedType.LPTStr)]
      public string lpVerb;
      [MarshalAs(UnmanagedType.LPTStr)]
      public string lpFile;
      [MarshalAs(UnmanagedType.LPTStr)]
      public string lpParameters;
      [MarshalAs(UnmanagedType.LPTStr)]
      public string lpDirectory;
      public int nShow;
      public IntPtr hInstApp;
      public IntPtr lpIDList;
      [MarshalAs(UnmanagedType.LPTStr)]
      public string lpClass;
      public IntPtr hkeyClass;
      public uint dwHotKey;
      public IntPtr hIconOrMonitor;
      public IntPtr hProcess;
    }

    [DllImport("shell32.dll", ExactSpelling = true, CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern bool ShellExecuteExW(ref SHELLEXECUTEINFO lpExecInfo);

    public static void Main(string[] args){
      SHELLEXECUTEINFO shell_execute_info = new SHELLEXECUTEINFO();
      shell_execute_info.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(shell_execute_info);
      //shell_execute_info.fMask = 0x0000000C | 0x00000100;                            // SEE_MASK_INVOKEIDLIST (0x0000000C) | SEE_MASK_NOASYNC (0x00000100)
      //shell_execute_info.fMask = 0x0000000C | 0x00100000;                            // SEE_MASK_INVOKEIDLIST (0x0000000C) | SEE_MASK_ASYNCOK (0x00100000)
      //shell_execute_info.fMask = 0x0000000C | 0x00100000 | 0x00004000;               // SEE_MASK_INVOKEIDLIST (0x0000000C) | SEE_MASK_ASYNCOK (0x00100000) | SEE_MASK_UNICODE (0x00004000)
      //shell_execute_info.fMask = 0x0000000C | 0x00100000 | 0x00004000 | 0x00008000 | 0x00000400;  // SEE_MASK_INVOKEIDLIST (0x0000000C) | SEE_MASK_ASYNCOK (0x00100000) | SEE_MASK_UNICODE (0x00004000) | SEE_MASK_NO_CONSOLE (0x00008000) | SEE_MASK_FLAG_NO_UI (0x00000400)
      //shell_execute_info.fMask = 0x0000000C | 0x00000100 | 0x00004000 | 0x00008000 | 0x00000400;  // SEE_MASK_INVOKEIDLIST (0x0000000C) | SEE_MASK_NOASYNC (0x00000100) | SEE_MASK_UNICODE (0x00004000) | SEE_MASK_NO_CONSOLE (0x00008000) | SEE_MASK_FLAG_NO_UI (0x00000400)
      
      shell_execute_info.lpVerb = "open";
      shell_execute_info.lpFile = @".\node.exe";
      shell_execute_info.lpParameters = @".\" + System.Diagnostics.Process.GetCurrentProcess().ProcessName + ".js";    //  null/"General"/"Security"/"Details"   --tab name (optional)
      
      int SW_HIDE       = 0x00000000;
      //int SW_SHOWNORMAL = 0x00000001;
        
      shell_execute_info.nShow = SW_HIDE;
      
      ShellExecuteExW(ref shell_execute_info);
    }
  }
```

after compilation (remember to set the exe to release instead of debug, and sybsystem to windows instead of console),  
place the exe in the same folder as your <code>node.exe</code> and your javascript main module.  
rename the exe to match the main module name, for example:  
<pre>
node.exe
index.js
index.exe
</pre> 
launch the exe, it will launch <code>node.exe index.js</code>.  

you can obviously modify the code to include any additional arguments passed to <code>index.exe</code>,  
so they would be passed through to <code>node.exe</code> after <code>index.js</code>.  
you can also simply use <code>using System.Diagnostics;</code> and <code>ProcessStartInfo</code> <code>Process.Start</code>.
<br/>
here is a really old example:  
https://github.com/eladkarako/Run---c-application-to-use-shellexecuteexw-to-launch-application-or-file-properties  

(needs some modifying since it is used to display the properties window of a file instead of opening it),  
which I've wrote with my portable SharpDevelop  
https://github.com/eladkarako/SharpDevelop-Mod  
when I write those stuff I tend to use the lowest C# SDK possible, in this case I would like to use a <a href="https://github.com/eladkarako/manifest">manifest</a> in the exe which requires at least C# SDK 3.0 .

</details>
</li>
</ul>

<hr/>
<ul>
<li>
edit:  
the above method using editbin worked well,  
here are the patched (and original) files.<br/>
, 17.0.0-nightly20210916f182b9b29f - x86).<br/>
<img width="200" src="https://user-images.githubusercontent.com/415238/133725482-ba8470d8-8fa5-4cda-ad24-5db76cb6b828.jpg" /><br/>
<a href="https://github.com/nodejs/node/files/7182657/node.exe.subsystem_windows_patched.zip" download="node.exe.subsystem_console_original.zip">node.exe.subsystem_windows_patched.zip</a><br/>
<br/>
running the subsystem-window patched exe won't show you a console.

<br/>
this is the original, for reference.<br/>
<img width="200" src="https://user-images.githubusercontent.com/415238/133725486-52965676-fe50-45af-aa4a-277d9872092b.jpg" /><br/>
<a href="https://github.com/nodejs/node/files/7182652/node.exe.subsystem_console_original.zip" download="node.exe.subsystem_console_original.zip">node.exe.subsystem_console_original.zip</a>
</li>
</ul>

</details>

</details>

<h1><a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" title="you know you want to click here! :]">ℹ</a></h1>
