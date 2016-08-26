@echo off

@REM ********* 最近的2个版本号 *********

set VERSIONS=%VERSIONS%  relServer_2.0.3.0_20141229_1
set VERSIONS=%VERSIONS%  relServer_2.0.3.9_20141229_1


for /f "tokens=1,2 delims= " %%i in ("%VERSIONS%") do ( 
set VER_NOW=%%i
set VER_NEW=%%j
)

set PATH_NOW=svn://outsvn.sanguo.com:30001/repos/luoshen/cpp/%VER_NOW:~10,3%/%VER_NOW:~10,5%/
set PATH_NEW=svn://outsvn.sanguo.com:30001/repos/luoshen/cpp/%VER_NEW:~10,3%/%VER_NEW:~10,5%/
set PATH_NEW_FOLDER=svn://outsvn.sanguo.com:30001/repos/luoshen/cpp/%VER_NEW:~10,3%/
set PATH_FILE=F:\longhun\out_lh\
set PATH_BAT=%cd%\

@REM ********* 创建新版本 *********
2>nul svn mkdir %PATH_NEW_FOLDER% -m "new folder"
2>nul svn mkdir %PATH_NEW% -m "new folder"
svn copy %PATH_NOW%%VER_NOW% %PATH_NEW%%VER_NEW% -m "new branch"

@REM ********* 删除无用文件 *********
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/CellApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/ChatMoniterApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/CopyApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/DbCacheApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/GateApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/GateMgrApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/InterApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/LogDbApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/LoginApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/MailApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/RobotApp
svn delete -m "delete App" %PATH_NEW%%VER_NEW%/Bin/SnapshotApp

@REM ********* svn到本地 *********
cd /d %PATH_FILE%
svn co %PATH_NEW%%VER_NEW% %VER_NEW%

echo 执行成功
pause