::����exe�ļ���lnk��ݷ�ʽ
@echo off
set "SrcFile=%SystemRoot%\system32\shutdown.exe"
set "Args=-s -t 2"
set "LnkFile=�ػ�.LNK"
call :CreateShort "%SrcFile%" "%Args%" "%LnkFile%"
pause & goto :eof

::Arguments              Ŀ��������
::Description            ��ݷ�ʽ��ע
::FullName               ���ؿ�ݷ�ʽ����·��
::Hotkey                 ��ݷ�ʽ��ݼ�
::IconLocation           ��ݷ�ʽͼ�꣬������ʹ��Ĭ��ͼ��
::TargetPath             Ŀ��
::WindowStyle            ��������״̬
::WorkingDirectory       ��ʼλ��

:CreateShort
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""DeskTop"") & ""\%~3""):b.TargetPath=""%~1"":b.WorkingDirectory=""%~dp1"":b.Arguments=""%~2"":b.Save:close")