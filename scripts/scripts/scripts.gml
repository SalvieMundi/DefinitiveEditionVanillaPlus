// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function startJavaInstall(){
	if (file_exists(currentBatPath)) file_delete(currentBatPath);
	
	batFile = file_text_open_write(currentBatPath);
	file_text_write_string(batFile, string_replace(installJavaBatContents, "[JAVALINK]", javaLink));
	file_text_close(batFile);
	
	executeBat(currentBatPath);
}

function replaceClientStrings() { 
	clientInstallFolder = string_replace(clientInstallFolder, "[PROGRAMFILES]", programFiles);
	fabricClientFolder = string_replace(fabricClientFolder, "[APPDATA]", appData);
	launcherProfileAppendText = string_replace_all(string_replace(launcherProfileAppendText, "[CLIENTINSTALLFOLDER]", string_replace_all(clientInstallFolder, "\\", "\\\\")), "'", "\"");
	installClientBatContents = string_replace_all(string_replace_all(string_replace_all(string_replace_all(string_replace_all(installClientBatContents, "[FABRICCLIENTFOLDER]", fabricClientFolder), "[CLIENTINSTALLFOLDER]", clientInstallFolder), "[PROGRAMDIRECTORY]", programDirectory), "[GAMEDIRECTORY]", gameDirectory), "'", "\"");
}

function startClientInstall(){
	if (directory_exists(clientInstallFolder)) directory_destroy(clientInstallFolder);
	if (!directory_exists(clientInstallFolder)) directory_create(clientInstallFolder);
	
	if (file_exists(currentBatPath)) file_delete(currentBatPath);
	
	batFile = file_text_open_write(currentBatPath);
	file_text_write_string(batFile, installClientBatContents);
	file_text_close(batFile);
	
	executeBat(currentBatPath);
}

function startClientProfileInstall(){
	profileFileText = "";
	if (file_exists(fabricClientFolder + oldLauncherProfilePath)) {
		profileFile = file_text_open_read(fabricClientFolder + oldLauncherProfilePath);
		
		while (!file_text_eof(profileFile)) {
			profileFileText += file_text_readln(profileFile);
		}
		
		file_text_close(profileFile);
		
		if (string_count("\"gameDir\" : \"C:\\\\Program Files (x86)\\\\Minecraft Launcher\\\\Minecraft Definitive Edition\",", profileFileText) == 0) {
			profileFileText = string_replace(profileFileText, profileParsingToken, "    }" + launcherProfileAppendText + @"
  },");
  
			profileFile = file_text_open_write(fabricClientFolder + oldLauncherProfilePath);
			file_text_write_string(profileFile, profileFileText);
			file_text_close(profileFile);
		}
	}
	
	profileFileText = "";
	if (file_exists(fabricClientFolder + newLauncherProfilePath)) {
		profileFile = file_text_open_read(fabricClientFolder + newLauncherProfilePath);
		
		while (!file_text_eof(profileFile)) {
			profileFileText += file_text_readln(profileFile);
		}
		
		file_text_close(profileFile);
		
		if (string_count("\"gameDir\" : \"C:\\\\Program Files (x86)\\\\Minecraft Launcher\\\\Minecraft Definitive Edition\",", profileFileText) == 0) {
			profileFileText = string_replace(profileFileText, profileParsingToken, "    }" + launcherProfileAppendText + @"
  },");
  
			profileFile = file_text_open_write(fabricClientFolder + newLauncherProfilePath);
			file_text_write_string(profileFile, profileFileText);
			file_text_close(profileFile);
		}
	}
}

function startServerInstall(){
	if (directory_exists(serverInstallFolder)) directory_destroy(serverInstallFolder);
	if (!directory_exists(serverInstallFolder)) directory_create(serverInstallFolder);
	
	if (file_exists(currentBatPath)) file_delete(currentBatPath);
	
	batFile = file_text_open_write("startup.bat");
	file_text_write_string(batFile, string_replace_all(startupBatContents, "[SERVERRAM]", string(serverRam)));
	file_text_close(batFile);
	
	installServerBatContents = string_replace_all(installServerBatContents, "[PROGRAMDIRECTORY]", programDirectory);
	installServerBatContents = string_replace_all(installServerBatContents, "[SERVERINSTALLFOLDER]", string_copy(serverInstallFolder,1,string_length(serverInstallFolder)-1));
	installServerBatContents = string_replace_all(installServerBatContents, "[GAMEDIRECTORY]", gameDirectory);
	installServerBatContents = string_replace_all(installServerBatContents, "'", "\"");
	installServerBatContents = string_replace_all(installServerBatContents, "\"[SERVERLINK]\"", "'" + serverLink + "'");
	installServerBatContents = string_replace_all(installServerBatContents, "\"server.jar\"", "'server.jar'");
	
	batFile = file_text_open_write(currentBatPath);
	file_text_write_string(batFile, installServerBatContents);
	file_text_close(batFile);
	
	executeBat(currentBatPath);
}