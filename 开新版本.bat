@echo off

@REM ********* 最近的3个版本号 *********

set VERSIONS=%VERSIONS%  1.0.0.5_20160419_1
set VERSIONS=%VERSIONS%  1.0.0.6_20160523_1
set VERSIONS=%VERSIONS%  1.0.0.7_20160530_1


for /f "tokens=1,2,3 delims= " %%i in ("%VERSIONS%") do ( 
set VER_OLD=%%i
set VER_NOW=%%j
set VER_NEW=%%k
)

set PATH_NOW=svn://svn.dazhuzai.com:3695/dazhuzai/branches/%VER_NOW:~0,3%/%VER_NOW:~0,5%/
set PATH_NEW=svn://svn.dazhuzai.com:3695/dazhuzai/branches/%VER_NEW:~0,3%/%VER_NEW:~0,5%/
set PATH_NEW_FOLDER=svn://svn.dazhuzai.com:3695/dazhuzai/branches/%VER_NEW:~0,3%/
set PATH_FILE=D:\

set MAIN_DB_IP=192.168.9.42
set BACK_UP_DB_IP=192.168.9.220

@REM ********* 创建新版本 *********
2>nul svn mkdir %PATH_NEW_FOLDER% -m "new folder"
2>nul svn mkdir %PATH_NEW% -m "new folder"
svn copy %PATH_NOW%%VER_NOW% %PATH_NEW%%VER_NEW% -m "new branch"

@REM ********* svn到本地 *********
cd /d %PATH_FILE%
2>nul ren %VER_OLD% %VER_NEW%
if exist %VER_NEW% (
svn switch %PATH_NEW%%VER_NEW%/src %VER_NEW%
) else (
svn co %PATH_NEW%%VER_NEW%/src %VER_NEW%
)

@REM ********* 修改SetPathCpp.bat *********
cd /d %PATH_FILE%%VER_NOW%\Public\MessageCDL
ren SetPathCpp.bat temp.bat
setlocal enabledelayedexpansion
for /f "tokens=1* delims=:" %%i in ('findstr /n .* temp.bat') do (
set str=%%j
if "!str!"=="set DBIP=%MAIN_DB_IP%" set str=set DBIP=%BACK_UP_DB_IP%
if "!str!"=="set DB_VERSION=" set str=set DB_VERSION=_%VER_NOW:~0,7%
>>SetPathCpp.bat echo.!str!
)
del temp.bat
svn commit SetPathCpp.bat -m "modify path"

@REM ********* 修改code_version.xml *********
cd /d %PATH_FILE%%VER_NEW%\Public\runnable\config
ren code_version.xml temp.xml
setlocal enabledelayedexpansion
for /f "tokens=1* delims=:" %%i in ('findstr /n .* temp.xml') do (
set str=%%j
if not "!str!"=="" set str=!str:%VER_NOW:~0,7%=%VER_NEW:~0,7%!
>>code_version.xml echo.!str!
)
del temp.xml
svn commit code_version.xml -m "modify version"
cd /d %PATH_FILE%%VER_NEW%\Server\GameEngineProject\config
ren code_version.xml temp.xml
setlocal enabledelayedexpansion
for /f "tokens=1* delims=:" %%i in ('findstr /n .* temp.xml') do (
set str=%%j
if not "!str!"=="" set str=!str:%VER_NOW:~0,7%=%VER_NEW:~0,7%!
>>code_version.xml echo.!str!
)
del temp.xml
svn commit code_version.xml -m "modify version"

@REM ********* 创建快捷方式 *********
2>nul del %USERPROFILE%\DeskTop\%VER_NOW%.lnk
call :CreateShort "%PATH_FILE%%VER_NEW%" "" "%VER_NEW%.lnk"

echo 执行成功
pause
goto :eof

:CreateShort
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""DeskTop"") & ""\%~3""):b.TargetPath=""%~1"":b.WorkingDirectory=""%~dp1"":b.Arguments=""%~2"":b.Save:close")
