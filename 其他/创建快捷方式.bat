::创建exe文件的lnk快捷方式
@echo off
set "SrcFile=%SystemRoot%\system32\shutdown.exe"
set "Args=-s -t 2"
set "LnkFile=关机.LNK"
call :CreateShort "%SrcFile%" "%Args%" "%LnkFile%"
pause & goto :eof

::Arguments              目标程序参数
::Description            快捷方式备注
::FullName               返回快捷方式完整路径
::Hotkey                 快捷方式快捷键
::IconLocation           快捷方式图标，不设则使用默认图标
::TargetPath             目标
::WindowStyle            窗口启动状态
::WorkingDirectory       起始位置

:CreateShort
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""DeskTop"") & ""\%~3""):b.TargetPath=""%~1"":b.WorkingDirectory=""%~dp1"":b.Arguments=""%~2"":b.Save:close")