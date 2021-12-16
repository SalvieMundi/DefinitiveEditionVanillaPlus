/// @description delete residual files & start
if (file_exists(currentBatPath)) file_delete(currentBatPath);
if (file_exists(systemInfoPath)) file_delete(systemInfoPath);

batFile = file_text_open_write(currentBatPath);
file_text_write_string(batFile, getInfoBatContents);
file_text_close(batFile);

alarm[0] = 300;