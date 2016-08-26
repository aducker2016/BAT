@echo off

set FROM_IP=192.168.9.42
set TO_IP=127.0.0.1
set DB_BASE=dazhuzai

set USER=root
set PASS=lh123root

cd /d php
php UpdateDB.php %FROM_IP%:3306 %USER% %PASS% %DB_BASE% %TO_IP%:3306 %USER% %PASS% %DB_BASE%
php UpdateDB.php %FROM_IP%:3306 %USER% %PASS% %DB_BASE%_log %TO_IP%:3306 %USER% %PASS% %DB_BASE%_log

pause