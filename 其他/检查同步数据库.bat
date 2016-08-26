@echo off

@REM mysql命令内容
set mysqlCmd=%mysqlCmd% use test; 
set mysqlCmd=%mysqlCmd% select count(*) from t_update_db where update_flag = 1;
set mysqlCmd=%mysqlCmd% delete from t_update_db where update_flag = 1;

@REM mysql执行命令，并返回结果
for /f "delims=" %%i in ('mysql -h 192.168.9.131 -uroot -plh123root -e "%mysqlCmd%"') do (
set isUpdateDb=%%i
)

@REM 结果标识为1，则同步数据库
if %isUpdateDb% == 1 (
 @echo on
 call 同步数据库.bat
 @echo off
)

pause