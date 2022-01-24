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
	if (!directory_exists(programFiles + "\\Minecraft Launcher")) {
		programFiles = string_copy(programFiles, 1, 2);
		directory_create(programFiles + "\\Minecraft Launcher");
	}
	clientInstallFolder = string_replace(clientInstallFolder, "[PROGRAMFILES]", programFiles);
	fabricClientFolder = string_replace(fabricClientFolder, "[APPDATA]", appData);
	launcherProfileAppendText = string_replace_all(string_replace(launcherProfileAppendText, "[CLIENTINSTALLFOLDER]", string_replace_all(clientInstallFolder, "\\", "\\\\")), "'", "\"");
	installClientBatContents = string_replace_all(string_replace_all(string_replace_all(string_replace_all(string_replace_all(installClientBatContents, "[FABRICCLIENTFOLDER]", fabricClientFolder), "[CLIENTINSTALLFOLDER]", clientInstallFolder), "[PROGRAMDIRECTORY]", programDirectory), "[GAMEDIRECTORY]", gameDirectory), "'", "\"");
}

function startClientInstall(){
	if (directory_exists(clientInstallFolder) && !notUpdating) {
		directory_destroy(clientInstallFolder + "\\mods");
		directory_destroy(clientInstallFolder + "\\emotes");
		directory_destroy(clientInstallFolder + "\\saves\\world");
	} else if (directory_exists(clientInstallFolder) && notUpdating) {
		directory_destroy(clientInstallFolder);
	}
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
		
		//remove old profile entries
		if (string_count("b5ed351130ba75da77ed8c33976d35a1", profileFileText) > 0) {
			var chars = 655; //original flags
			if (string_count(@":\\Program Files (x86)\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0 && string_count(@"-Daikars.new.flags=true", profileFileText) > 0) chars = 1016; //new flags
			else if (string_count(@":\\Program Files\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0 && string_count(@"-Daikars.new.flags=true", profileFileText) > 0) chars = 1010; //new flags
			else if (string_count(@":\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0) chars = 995; //new flags, new catch for non-program folder launcher installation
			profileFileText = string_delete(profileFileText, string_last_pos("b5ed351130ba75da77ed8c33976d35a1",profileFileText)-8, chars);
		}
		
		//insert new profile entry
		profileFileText = string_replace(profileFileText, profileParsingToken, "    }" + launcherProfileAppendText + @"
  },");
  
		profileFile = file_text_open_write(fabricClientFolder + oldLauncherProfilePath);
		file_text_write_string(profileFile, profileFileText);
		file_text_close(profileFile);
	}
	
	profileFileText = "";
	if (file_exists(fabricClientFolder + newLauncherProfilePath)) {
		profileFile = file_text_open_read(fabricClientFolder + newLauncherProfilePath);
		
		while (!file_text_eof(profileFile)) {
			profileFileText += file_text_readln(profileFile);
		}
		
		file_text_close(profileFile);
		
		//remove old profile entries
		if (string_count("b5ed351130ba75da77ed8c33976d35a1", profileFileText) > 0) {
			var chars = 655; //original flags
			if (string_count(@":\\Program Files (x86)\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0 && string_count(@"-Daikars.new.flags=true", profileFileText) > 0) chars = 1016; //new flags
			else if (string_count(@":\\Program Files\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0 && string_count(@"-Daikars.new.flags=true", profileFileText) > 0) chars = 1010; //new flags
			else if (string_count(@":\\Minecraft Launcher\\Minecraft Definitive Edition", profileFileText) > 0) chars = 995; //new flags, new catch for non-program folder launcher installation
			profileFileText = string_delete(profileFileText, string_last_pos("b5ed351130ba75da77ed8c33976d35a1",profileFileText)-8, chars);
		}
		
		//insert new profile entry
		profileFileText = string_replace(profileFileText, profileParsingToken, "  	}" + launcherProfileAppendText + @"
  },");
  
		profileFile = file_text_open_write(fabricClientFolder + oldLauncherProfilePath);
		file_text_write_string(profileFile, profileFileText);
		file_text_close(profileFile);
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