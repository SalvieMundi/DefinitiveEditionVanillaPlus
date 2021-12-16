/// @description interact with mouse

if (self.visible) {
	if (mouse_x > self.x && mouse_x < self.x + self.sprite_width) {
		if (mouse_y > self.y && mouse_y < self.y + self.sprite_height) {
			self.image_index = 1;
			if (mouse_check_button_pressed(mb_left)) {
				OBJ_Main.status = self.goToStatus;
			}
		} else {
			self.image_index = 0;
		}
	} else {
		self.image_index = 0;
	}
}