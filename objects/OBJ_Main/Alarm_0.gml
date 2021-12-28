/// @description get system info
executeBat(currentBatPath);

while (file_exists(gameDirectory + currentBatPath)) {
	;
}

systemInfoFile = file_text_open_read(systemInfoPath);
file_text_readln(systemInfoFile); //disregard
programFilesx86 = string_replace_all(string_replace_all(file_text_readln(systemInfoFile), "\r", ""), "\n", "");
programFilesx86 = string_copy(programFilesx86,1,string_length(programFilesx86)-1);
programFilesx64 = string_replace_all(string_replace_all(file_text_readln(systemInfoFile), "\r", ""), "\n", "");
programFilesx64 = string_copy(programFilesx64,1,string_length(programFilesx64)-1);
appData = string_replace_all(string_replace_all(file_text_readln(systemInfoFile), "\r", ""), "\n", "");
appData = string_copy(appData,1,string_length(appData)-1);
userRam = ceil((int64(string_replace_all(string_replace_all(string_replace(string_replace(file_text_readln(systemInfoFile),"Total Physical Memory:",""),"MB","")," ",""),",","")) / 1024));
currentVersion = string_replace_all(string_replace_all(file_text_readln(systemInfoFile), "\r", ""), "\n", "");
javaVersion = string_replace_all(string_replace_all(file_text_readln(systemInfoFile), "\r", ""), "\n", "");
needsJava = string_length(javaVersion) <= 1;
if (!needsJava) javaVersion = string_copy(javaVersion,1,string_length(javaVersion)-1);
file_text_close(systemInfoFile);
if (file_exists(gameDirectory + systemInfoPath)) file_delete(gameDirectory + systemInfoPath);

if (directory_exists(programFilesx64 + "\\Minecraft Launcher")) programFiles = programFilesx64;
else programFiles = programFilesx86;

if (version != currentVersion) {
	setButtons("Exit", "end", "Update", "fetchUpdate", "Continue", "systemInfoRelay");
	status = "installerUpdateAvailable";
} else {
	status = "systemInfoRelay";
}