// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function executeBat(batPath){
	execute_shell("\"C:\\Windows\\System32\\explorer.exe\" \"" + OBJ_Main.gameDirectory + batPath + "\"", true);
}