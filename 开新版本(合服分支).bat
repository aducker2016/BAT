@echo off

@REM ********* 最近的2个版本号 *********

set VERSIONS=%VERSIONS%  2.0.3.9
set VERSIONS=%VERSIONS%  2.0.4.0


for /f "tokens=1,2 delims= " %%i in ("%VERSIONS%") do ( 
set VER_NOW=%%i
set VER_NEW=%%j
)

set PATH_SVN=svn://113.106.18.197:30001/repos/luoshen/merge_server/
set PATH_FILE=F:\longhun\lh_hf\
set PATH_BAT=%cd%\

@REM ********* 创建新版本 *********
svn copy %PATH_SVN%%VER_NOW% %PATH_SVN%%VER_NEW% -m "new branch"

@REM ********* svn到本地 *********
cd /d %PATH_FILE%
svn co %PATH_SVN%%VER_NEW% %VER_NEW%

echo 执行成功
pause