/// @description handle what's currently going on

if (status == "end") {
	game_end();
} else if (status == "installJavaStart") {
	alarm[1] = 450;
	setButtons("", "", "", "", "Continue", "installChoiceStart");
	status = "installJava";
} else if (status == "installChoiceStart") {
	setButtons("SERVER", "serverInstallStart", "UPDATE CLIENT", "clientUpdateStart", "CLIENT", "clientInstallStartNoUpdate");
	status = "installChoice";
} else if (status == "clientInstallStart") {
	if (string_count("[APPDATA]", fabricClientFolder) > 0) replaceClientStrings();
	setButtons("< BACK", "installChoiceStart", "", "", "INSTALL", "clientInstallBat");
} else if (status == "clientInstallStartNoUpdate") {
	notUpdating = true;
	status = "clientInstallStart";
} else if (status == "clientUpdateStart") {
	notUpdating = false;
	status = "clientInstallStart";
} else if (status == "clientInstallBat") {
	setButtons("", "", "", "", "", "");
	startClientInstall();

	while (file_exists(gameDirectory + currentBatPath)) {
		;
	}
	
	status = "clientInstallProfileStart";
} else if (status == "clientInstallProfileStart") {
	startClientProfileInstall();
	alarm[2] = 300;
	status = "clientInstallProfile";
} else if (status == "moreInfo") {
	url_open("https://github.com/SalvieMundi/DefinitiveEditionVanillaPlus");
	status = "clientInstallFinish";
} else if (status == "serverInstallStart") {
	setButtons("< BACK", "installChoiceStart", "", "", "Continue", "serverInstallPath");
} else if (status == "serverInstallPath") {
	setButtons("", "", "Select Folder", "specifyPath", "Continue", "serverInstallRam");
	if (serverInstallFolder = "" || serverInstallFolder = "Please SELECT a folder") {
		with (OBJ_Button) {
			if (self.buttonId == "right") {
				self.visible = false;
			}
		}
	}
} else if (status == "specifyPath") {
	serverInstallFolder = get_directory("");
	status = "serverInstallPath";
} else if (status == "serverInstallRam") {
	setButtons("Add RAM", "addGb", "Subtract RAM", "subtractGb", "Continue", "serverInstallBat");
} else if (status == "addGb") {
	serverRam++;
	status = "serverInstallRam";
} else if (status == "subtractGb") {
	if (serverRam > 6) serverRam--;
	status = "serverInstallRam";
} else if (status == "serverInstallBat") {
	setButtons("", "", "", "", "", "");
	startServerInstall();

	while (file_exists(gameDirectory + currentBatPath)) {
		;
	}
	
	status = "serverInstallFinish";
} else if (status == "serverInstallFinish") {
	setButtons("More Info", "moreInfoServer", "", "", "Finish", "end");
} else if (status == "moreInfoServer") {
	url_open("https://github.com/SalvieMundi/DefinitiveEditionVanillaPlus");
	status = "serverInstallFinish";
}