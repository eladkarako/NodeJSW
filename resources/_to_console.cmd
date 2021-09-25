::@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp1"

call copy /b /y "%~1" "%~1.backup" 1>nul 2>nul

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30037\bin\Hostx86\x86\editbin.exe" /NOLOGO /SUBSYSTEM:CONSOLE "%~1"

set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"]  ( goto ERROR_EDITBIN )

echo [INFO] success.

goto END

:ERROR_EDITBIN
  echo [ERROR] editbin failed.  1>&2
  goto END

:END
  echo [INFO] EXIT_CODE: %EXIT_CODE%
  pause
  popd
  exit /b %EXIT_CODE%
