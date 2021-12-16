// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function setButtons(leftText, leftStatus, middleText, middleStatus, rightText, rightStatus){
	with (OBJ_Button) {
		if (self.buttonId = "left") {
			self.text = leftText;
			self.goToStatus = leftStatus;
			self.visible = (leftText != "" ? true : false);
		} else if (self.buttonId = "middle") {
			self.text = middleText;
			self.goToStatus = middleStatus;
			self.visible = (middleText != "" ? true : false);
		} else if (self.buttonId = "right") {
			self.text = rightText;
			self.goToStatus = rightStatus;
			self.visible = (rightText != "" ? true : false);
		}
	}
}