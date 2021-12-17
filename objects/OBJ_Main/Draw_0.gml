/// @description draw what's currently going on

//draw title bar
draw_set_font(FNT_Styled);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(7,7,titleText);

if (status == "welcome") {
	mainText = 
	@"We are currently checking your system information";
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_sprite(SPR_Logo,0,75,80)
	draw_text(320,280,mainText);
} else if (status == "computerGood") {
	mainText = 
	"Highly modded Minecraft requires more than 4GB of RAM. Standalone Java can\n" +
	"sometimes be required, as well.\n\n" +
	
	"We detect " + string(userRam) + "GB of RAM on this PC, " + (needsJava ? (userRam > 4 ? "but " : "and ") + "do not " : "and ") + "detect a version\n" +
	"of Java already installed" + (needsJava || userRam <= 4 ? ".\n\n" : ": \n\n" + 
	
	"Java Version: " + javaVersion + "\n\n") +
	
	(userRam <= 4 ? "Your PC does not meet the RAM requirements. You can still install these mods, but you\n" +
	"may not have the best experience.\n\n" : "") +
	(needsJava ? "You can choose to skip a Java installation, but we would highly\n" +
	"recommend installing Java 17 LTS.\n\n" : 
	"You can continue the installation, but if it's been a while since you\n" + 
	"installed Java / Minecraft, you may consider installing Java 17 LTS.");
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "installChoice") {
	mainText = 
	"Are you trying to install these mods on a client or server?\n\n" +
	
	"If you are trying to PLAY THE GAME with these mods, or are trying to connect to a\n" +
	"modded server, or are unsure which option to choose, click CLIENT.\n\n" + 
	
	"If you are trying to CREATE A MODDED SERVER using this modpack, choose SERVER.\n\n" +
	
	"If you are needing to update, but want to keep previous files and settings, choose\n" + 
	"UPDATE CLIENT. This is not recommended unless you are debugging.";
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "installJava") {
	mainText = 
	"Installer is downloading Java 17 LTS from Microsoft and will start Java\n" +
	"installation momentarily.\n\n" +
	
	"After Java is installed, please press Continue...";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "clientInstallStart") {
	mainText = 
	"Installer will install mods into the following directory:\n\n" +
	
	clientInstallFolder + "\n\n" +
	
	"This folder will contain all files such as worlds, player data, screenshots, etc. If\n" +
	"any mods or data already exists in this directory, this installer will entirely\n" + 
	"overwrite and delete all data in it!\n\n" +
	
	"When you are ready to begin installation, press INSTALL.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "clientInstallBat") {
	mainText = 
	"Installing the fabric mod loader and unzipping required mod files...";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "clientInstallProfile") {
	mainText = 
	"Installing a profile into the official Minecraft Launcher...";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "clientInstallFinish") {
	mainText = 
	"Finished installing modpack. To use, open the official Minecraft Launcher and select\n" +
	"the Vanilla+ Definitive option from the versions list. First launch will be very slow!\n\n\n\n\n\n\n\n\n" +
	
	"For more info on the mods, their developers, & controls click the MORE INFO button.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
	
	draw_set_font(FNT_Styled);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(320,170,"->");
	draw_sprite_ext(SPR_Step1, 0, 175, 120, 0.45, 0.45, 0, c_white, 1);
	draw_sprite_ext(SPR_Step2, 0, 360, 120, 0.45, 0.47, 0, c_white, 1);
} else if (status == "serverInstallStart") {
	mainText = 
	"This installation will install all files required to create a Minecraft Server\n" +
	"that other players can connect to. If you are simply trying to play modded\n" +
	"minecraft, press BACK and choose CLIENT!\n\n" +
	
	"You will be required to provide a folder for installation and specify how much\n" +
	"RAM you will allocate to Minecraft Server processes.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "serverInstallPath") {
	mainText = 
	"Please specify a folder in which the Minecraft Server files will be stored.\n\n" +
	
	"Folder: " + serverInstallFolder + "\n\n";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "serverInstallRam") {
	mainText = 
	"Please specify how much RAM will be allocated to Minecraft Server processes. It\n" +
	"is recommended you leave at least 2GB of memory free for the operating system\n" +
	"and other processes. So if your server has 8GB of RAM, specify 6GB here.\n\n" + 
	
	"RAM: " + string(serverRam) + "GB\n\n" +
	
	"You should not run these mods with less than 6GB of RAM, and 8GB or more is\n" + 
	"highly recommended!\n\n" + 
	
	"Alternatively, if you intend to move these files to a server host such as Apex,\n" +
	"Shockbyte, etc. then those services will likely ignore this setting.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "serverInstallBat") {
	mainText = 
	"Installing the fabric mod loader and unzipping required mod files...";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "serverInstallFinish") {
	mainText = 
	"Finished installing modpack. To use, double-click the startup.bat file in\n" +
	serverInstallFolder + ".\n\n" +
	
	"For more info on the mods, their developers, & controls click the MORE INFO button.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
} else if (status == "installerUpdateAvailable") {
	mainText = 
	"There appears to be an update available for this installer! See below:\n\n" +
	
	"Current Version: " + version + "\n" +
	"Update Version: " + currentVersion + "\n\n" +
	
	"It is highly recommended that you click UPDATE to be taken to the release page,\n" + 
	"where you can download the latest ZIP file containing the newest installer!\n\n" + 
	
	"Alternatively, you can click CONTINUE to keep using this version.";
	
	draw_set_font(FNT_Default);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(38,64,mainText);
}