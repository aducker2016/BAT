@echo off

@REM ****** 清空的文档路径 *******

set PATH=D:\每周更新内容记录




cd /d %PATH%
for /f "tokens=*" %%i in ( 'dir /b/a-d "*.txt"' ) do (
cd.>%%i
)

echo 清理成功
pause