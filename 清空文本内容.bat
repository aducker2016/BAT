@echo off

@REM ****** ��յ��ĵ�·�� *******

set PATH=D:\ÿ�ܸ������ݼ�¼




cd /d %PATH%
for /f "tokens=*" %%i in ( 'dir /b/a-d "*.txt"' ) do (
cd.>%%i
)

echo ����ɹ�
pause