/// @description Instantiate variables

//MAIN VARIABLES
gameDirectory = game_save_id;
programDirectory = working_directory + "files";
version = "";
currentVersion = "";
updateAvailable = false;
status = "welcome";
titleText = "Minecraft Vanilla+ Definitive Edition Installer";
mainText = "";
appData = "";
programFilesx86 = "";
programFilesx64 = "";
programFiles = "";
needsJava = false;
javaVersion = "";
oldLauncherProfilePath = "\\launcher_profiles.json";
newLauncherProfilePath = "\\launcher_profiles_microsoft_store.json";
clientInstallFolder = @"[PROGRAMFILES]\Minecraft Launcher\Minecraft Definitive Edition";
launcherProfileAppendText = 
@",
    'b5ed351130ba75da77ed8c33976d35a1' : {
      'created' : '1970-01-02T00:00:00.000Z',
      'gameDir' : '[CLIENTINSTALLFOLDER]',
      'icon' : 'Enchanting_Table',
      'javaArgs' : '-Xms4G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -Dlog4j2.formatMsgNoLookups=true',
      'lastUsed' : '1970-01-02T00:00:00.000Z',
      'lastVersionId' : 'fabric-loader-0.11.7-1.17.1',
      'name' : 'Vanilla+ Definitive',
      'type' : 'custom'
    }";
javaLink = @"https://aka.ms/download-jdk/microsoft-jdk-17.0.1.12.1-windows-x64.msi";
serverInstallFolder = "Please SELECT a folder";
serverLink = @"https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar";
userRam = 0;
serverRam = 6;
fabricClientFolder = @"[APPDATA]\.minecraft";
notUpdating = true;

//INTERNAL VARIABLES
currentBatPath = "temp.bat";
systemInfoPath = "info.txt";
versionPath = working_directory + @"files\version.txt";
profileParsingToken = @"    }
  },";

//BATCH WRITEUPS
getInfoBatContents = 
@"cd /d %~dp0
del info.txt
echo %homedrive% >> info.txt
echo %programfiles(x86)% >> info.txt
echo %programfiles% >> info.txt
echo %appdata% >> info.txt
systeminfo | findstr /C:" + "\"Total Physical Memory\"" + @" >> info.txt
powershell -Command (Invoke-WebRequest https://raw.githubusercontent.com/SalvieMundi/DefinitiveEditionVanillaPlus/master/datafiles/files/version.txt -UseBasicParsing).Content >> info.txt
java -version 2>&1 | find " + "\"version\"" + @" >> info.txt
del temp.bat
exit";

installJavaBatContents = 
@"cd /d %~dp0
powershell (new-object System.Net.WebClient).DownloadFile('[JAVALINK]','java.msi')
msiexec /i java.msi INSTALLLEVEL=1
del java.msi
exit";

installClientBatContents = 
@"cd /d '[PROGRAMDIRECTORY]'
java -jar fabric-installer-0.8.0.jar client -dir '[FABRICCLIENTFOLDER]' -mcversion 1.17.1 -loader 0.11.7 -noprofile
echo s | 7za x ServerFiles.7z.001 -o'[CLIENTINSTALLFOLDER]'
echo s | 7za x ClientFiles.7z.001 -o'[CLIENTINSTALLFOLDER]'
cd /d '[CLIENTINSTALLFOLDER]'
del eula.txt
del server-icon.png
cd /d '[GAMEDIRECTORY]'
del temp.bat
exit";

installServerBatContents = 
@"cd /d '[PROGRAMDIRECTORY]'
7za x ServerFiles.7z.001 -o'[SERVERINSTALLFOLDER]'
cd /d '[GAMEDIRECTORY]'
echo F | xcopy 'startup.bat' '[SERVERINSTALLFOLDER]\startup.bat' /C /I /R /Y
del startup.bat
cd /d '[SERVERINSTALLFOLDER]'
powershell (new-object System.Net.WebClient).DownloadFile('[SERVERLINK]','server.jar')
cd /d '[PROGRAMDIRECTORY]'
java -jar fabric-installer-0.8.0.jar server -dir '[SERVERINSTALLFOLDER]' -mcversion 1.17.1 -loader 0.11.7 -noprofile
cd /d '[SERVERINSTALLFOLDER]'
echo y | rmdir /s .fabric-installer
cd /d '[GAMEDIRECTORY]'
del temp.bat
exit";

startupBatContents = 
@"cd /d %~dp0
java -Xms[SERVERRAM]G -Xmx[SERVERRAM]G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dlog4j2.formatMsgNoLookups=true -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar fabric-server-launch.jar --nogui";