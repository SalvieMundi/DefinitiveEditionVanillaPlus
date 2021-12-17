/// @description delete residual files & start
versionFile = file_text_open_read(versionPath);
version = file_text_readln(versionFile);
file_text_close(versionFile);

if (file_exists(currentBatPath)) file_delete(currentBatPath);
if (file_exists(systemInfoPath)) file_delete(systemInfoPath);

batFile = file_text_open_write(currentBatPath);
file_text_write_string(batFile, getInfoBatContents);
file_text_close(batFile);

alarm[0] = 300;