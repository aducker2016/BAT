@echo off

@REM mysql��������
set mysqlCmd=%mysqlCmd% use test; 
set mysqlCmd=%mysqlCmd% select count(*) from t_update_db where update_flag = 1;
set mysqlCmd=%mysqlCmd% delete from t_update_db where update_flag = 1;

@REM mysqlִ����������ؽ��
for /f "delims=" %%i in ('mysql -h 192.168.9.131 -uroot -plh123root -e "%mysqlCmd%"') do (
set isUpdateDb=%%i
)

@REM �����ʶΪ1����ͬ�����ݿ�
if %isUpdateDb% == 1 (
 @echo on
 call ͬ�����ݿ�.bat
 @echo off
)

pause