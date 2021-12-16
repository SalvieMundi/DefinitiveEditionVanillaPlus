/// @description draw self
draw_self();
draw_set_font(FNT_Styled);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(self.x + self.sprite_width/2,self.y + self.sprite_height/2, text);
