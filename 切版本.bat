@echo off

@REM ********* 最近的3个版本号 *********

set VERSIONS=%VERSIONS%  1.0.0.8_20160612_1
set VERSIONS=%VERSIONS%  1.0.0.9_20160625_1
set VERSIONS=%VERSIONS%  1.0.1.0_20160704_1


for /f "tokens=1,2,3 delims= " %%i in ("%VERSIONS%") do ( 
set VER_OLD=%%i
set VER_NOW=%%j
set VER_NEW=%%k
)


set PATH_FILE=D:\
set PATH_NEW=svn://svn.dazhuzai.com:3695/dazhuzai/branches/%VER_NEW:~0,3%/%VER_NEW:~0,5%/



@REM ********* svn到本地 *********
cd /d %PATH_FILE%

if exist %VER_NEW% (
echo [错误]版本已存在
pause
goto :eof
)

if exist %VER_OLD% (
  ren %VER_OLD% %VER_NEW%
  if exist %VER_NEW% (
  svn switch %PATH_NEW%%VER_NEW%/src %VER_NEW%
  ) else (
  svn co %PATH_NEW%%VER_NEW%/src %VER_NEW%
  )
) else (
  svn co %PATH_NEW%%VER_NEW%/src %VER_NEW%
)

@REM ********* 创建桌面快捷方式 *********
del %USERPROFILE%\DeskTop\runnable.lnk
del %USERPROFILE%\DeskTop\incBuild.lnk
call :CreateShort "%PATH_FILE%%VER_NEW%\Server\GameEngineProject\runnable" "" "runnable.lnk"
call :CreateShort "%PATH_FILE%%VER_NEW%\Server\GameEngineProject\runnable\incBuild.bat" "" "incBuild.lnk"


@REM ********* 编译程序 *********
cd /d %PATH_FILE%%VER_NEW%\Server\GameEngineProject\runnable
call incBuild.bat

goto :eof

:CreateShort
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""DeskTop"") & ""\%~3""):b.TargetPath=""%~1"":b.WorkingDirectory=""%~dp1"":b.Arguments=""%~2"":b.Save:close")
