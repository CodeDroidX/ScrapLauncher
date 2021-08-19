cd %~dp0
chcp 65001
chcp 65001
cls
@Echo off
cls
set ver=2.4
title %ver%
echo Scrap Mechanic Лаунчер droidx %ver%
echo.
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
echo Uac - подтверждено. Готов к запуску
echo.
color 6
if exist "%~1" goto s
set /p name=" Введите id из мастерской:"
start "" "explorer.exe" "http://steamworkshop.download/download/view/%name%"
echo Скачайте архив и распакованную папку перетащите на ярлыклаунчера/лаунчер!
goto f
:s
set /p name="Сохранить старые данные для отката? y\n>"
if "%name%" == "y" goto back
:be
echo.
set /p namere="Перезапустить SM автоматически (Лаунчер должен быть в его папке)? y\n>"
echo.
set /p name="Тип файла? mod\blueprint\save\world>"
echo.
set /p namef="Введите имя для установленного дополнения>"
if exist "log.txt" del log.txt
if "%name%" == "mod" goto m
if "%name%" == "blueprint" goto b
if "%name%" == "save" goto s
if "%name%" == "world" goto w
echo Не понял тебя... Что такое (%name%)?
goto f
:m
echo.
echo Отключение SM на всякий случай...
if "%namere%" == "y" taskkill.exe /IM ScrapMechanic.exe /f /t >> log.txt
for /D %%a in ("%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\User\*.*") do echo d | xcopy /E /y "%~1" "%%a\Mods\Mod%namef%" >> log.txt
goto f
:b
echo.
echo Отключение SM на всякий случай...
if "%namere%" == "y" taskkill.exe /IM ScrapMechanic.exe /f /t >> log.txt
for /D %%a in ("%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\User\*.*") do echo d | xcopy /E /y "%~1" "%%a\Blueprints\Blueprint%namef%" >> log.txt
goto f
:s
echo.
echo Отключение SM на всякий случай...
if "%namere%" == "y" taskkill.exe /IM ScrapMechanic.exe /f /t >> log.txt
for /D %%a in ("%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\User\*.*") do echo d | xcopy /E /y "%~1" "%%a\Save\Save%namef%" >> log.txt
goto f
:w
echo.
echo Отключение SM на всякий случай...
if "%namere%" == "y" taskkill.exe /IM ScrapMechanic.exe /f /t >> log.txt
for /D %%a in ("%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\User\*.*") do echo d | xcopy /E /y "%~1" "%%a\Worlds\World%namef%" >> log.txt
goto f
:f
echo.
color 3
if "%namere%" == "y" start Release\ScrapMechanic.exe
echo Работа завершена.
echo Нажмите для выхода и затирания логов!
echo Автоматический выход через 10 сек!
timeout 10 >> nul
if exist "log.txt" del log.txt
exit

:uac
color 4
echo Uac - провалено. Корректность работы под угрозой(
echo Создайте ярлык на лаунчер с параметром "Дополнительно\Запуск от имени администратора" и работайте через него.
timeout 10 >> nul
if exist "log.txt" del log.txt
exit
:back
color 2
echo.
echo Бэкап данных!
Xcopy /y /E /I "%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\User" "%userprofile%\AppData\Roaming\Axolot Games\Scrap Mechanic\UserBackupDataFrom%date%)" >> log.txt
goto be
