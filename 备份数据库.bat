@echo off

set BASE_NAME=dazhuzai
set VERSION=_1.0.0.6

set FROM_IP1=192.168.9.44
set FROM_IP2=192.168.9.42
set TO_IP=192.168.9.220


echo %BASE_NAME%%VERSION%

@REM 备份3个数据库 => SQL文件
mysqldump --opt %BASE_NAME% -h %FROM_IP1% -uroot -plh123root > %BASE_NAME%.sql
mysqldump --opt %BASE_NAME%_config -h %FROM_IP2% -uroot -plh123root > %BASE_NAME%_config.sql
mysqldump --opt -d %BASE_NAME%_log -h %FROM_IP2% -uroot -plh123root > %BASE_NAME%_log.sql

@REM 创建3个数据库
echo create database `%BASE_NAME%%VERSION%` default character set utf8; > createDb.sql
echo create database `%BASE_NAME%_config%VERSION%` default character set utf8; >> createDb.sql
echo create database `%BASE_NAME%_log%VERSION%` default character set utf8; >> createDb.sql

@REM 导入SQL文件 => 新数据库
mysql -h %TO_IP% -uroot -plh123root < createDb.sql
mysql %BASE_NAME%%VERSION% -h %TO_IP% -uroot -plh123root < %BASE_NAME%.sql
mysql %BASE_NAME%_config%VERSION% -h %TO_IP% -uroot -plh123root < %BASE_NAME%_config.sql
mysql %BASE_NAME%_log%VERSION% -h %TO_IP% -uroot -plh123root < %BASE_NAME%_log.sql

@REM 清除临时文件
del createDb.sql
del %BASE_NAME%.sql
del %BASE_NAME%_config.sql
del %BASE_NAME%_log.sql

pause