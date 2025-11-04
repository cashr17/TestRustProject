@echo off
call Workplace_Updater.bat

set "RUSTSERVER_PATH=rustserver"
if not exist "%RUSTSERVER_PATH%" md "%RUSTSERVER_PATH%"

set "OXIDE_PATH=..\modding\Oxide.Rust\*"
set "OXIDE_PLUGINS_PATH=..\Oxide.Plugins\*.cs"
set "OXIDE_EXT_PATH=..\modding\Oxide.Ext.*.dll"

:: Файлы, которые будут созданы
set "frameworkFile=%RUSTSERVER_PATH%\Frameworks_Installer.bat"
set "pluginFile=%RUSTSERVER_PATH%\Plugin_Loader.bat"
set "serverFile=%RUSTSERVER_PATH%\Server_Launcher.bat"

echo @echo off > %frameworkFile%
echo echo ## MENU ## >> %frameworkFile%
echo echo 1 - Install Oxide >> %frameworkFile%
echo set /p version=Enter your choice (1): >> %frameworkFile%
echo if "%%version%%"=="1" ( >> %frameworkFile%
echo    xcopy "%OXIDE_PATH%" "." /E /I /Y >> %frameworkFile%
echo    xcopy "%OXIDE_EXT_PATH%" "RustDedicated_Data\Managed\" /Y >> %frameworkFile%
echo ) else ( >> %frameworkFile%
echo    echo Invalid choice. Please enter 1. >> %frameworkFile%
echo    exit /b 1 >> %frameworkFile%
echo ) >> %frameworkFile%
echo File created successfully: %frameworkFile%

echo @echo off > %pluginFile%
echo echo ## MENU ## >> %pluginFile%
echo echo 1 - Load Plugins to Oxide >> %pluginFile%
echo set /p version=Enter your choice (1): >> %pluginFile%
echo if "%%version%%"=="1" ( >> %pluginFile%
echo    xcopy "%OXIDE_PLUGINS_PATH%" "oxide\plugins\" /Y >> %pluginFile%
echo ) else ( >> %pluginFile%
echo    echo Invalid choice. Please enter 1. >> %pluginFile%
echo    exit /b 1 >> %pluginFile%
echo ) >> %pluginFile%
echo File created successfully: %pluginFile%

echo @echo off > %serverFile%
echo echo "====== Check For Updates ======" >> %serverFile%
echo "..\steamCMD\steamcmd.exe" +force_install_dir "..\%RUSTSERVER_PATH%" +login anonymous +app_update 258550 validate +quit >> %serverFile%
echo echo "======== Launch Server ========" >> %serverFile%
echo RustDedicated.exe -batchmode ^ >> %serverFile%
echo +server.level "Procedural Map" ^ >> %serverFile%
echo +server.maxplayers 5 ^ >> %serverFile%
echo +server.worldsize 1000 ^ >> %serverFile%
echo +server.seed 123456789 ^ >> %serverFile%
echo +server.hostname "Test Oxide Server" ^ >> %serverFile%
echo +server.description "Test Server description" ^ >> %serverFile%
echo +server.queryport 27017 ^ >> %serverFile%
echo +server.port 28015 ^ >> %serverFile%
echo +rcon.port 28016 ^ >> %serverFile%
echo +app.port 28082 ^ >> %serverFile%
echo +rcon.password somePassword ^ >> %serverFile%
echo +rcon.web 1 >> %serverFile%
echo echo "Server started successfully!" >> %serverFile%
echo pause >> %serverFile%
echo File created successfully: %serverFile%

echo Workplace_Installer completed successfully
exit /b 0
