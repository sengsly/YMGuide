var highlight_col = "0x00FF00";
var obj_mc = this;
obj_mc._visible = false;
bar.tabEnabled = false;
//----------------------------------------------------------------------------------------------------
function shows(val){
	var val_arr = new Array();
	var c_name = "";
	var c_type = "";
	var d_color = new Color(bar);
	var fm = new TextFormat();
	
	val_arr = String(val).split("%%");
	
	d_color.setRGB(val_arr[0]);
	highlight_col = val_arr[1];
	title_txt.textColor = val_arr[2];
	des_txt.textColor = "0x000000";	//val_arr[2];
	
	c_name = val_arr[3];
	c_type = int(val_arr[4]);
	
	if (c_type == 1){
		c_type = "( Clone Display & Playback )";
	} else if (c_type == 2){
		c_type = "( Clone Playback Only )";
	} else if (c_type == 4){
		c_type = "( Independent Playback )";
	} else if (c_type == 3){
		c_type = "( Control Only )";
	}
	fm.color = highlight_col;
	clearInterval(ID_hide_fade);
	clearInterval(ID_hides_popup);
	
	if (val_arr[5] == "True"){
		title_txt.text = "New connection";
		des_txt.text = c_name + " connected to your computer." + "\n" + c_type;
		des_txt.setTextFormat(0, length(c_name), fm);
		des_txt.setTextFormat(28 + length(c_name),des_txt.length, fm);
		ID_hides_popup = setInterval(hides, (1000 * _root.time_popup_connect));

	} else if(val_arr[5] == "False") {
		title_txt.text = "Disconnect";
		des_txt.text = c_name + " disconnected from your computer.";
		des_txt.setTextFormat(0, length(c_name), fm);
		ID_hides_popup = setInterval(hides, (1000 * _root.time_popup_connect));
	}else{
		title_txt.text = c_name;
		des_txt.text = val_arr[4];
		des_txt.setTextFormat(fm);
		ID_hides_popup = setInterval(hides, (1000 * 3));
	}
	
	obj_mc._alpha = 100;
	obj_mc._visible = true;
}
//----------------------------------------------------------------------------------------------------
function hides(){
	clearInterval(ID_hides_popup);
	ID_hide_fade = setInterval(hide_fade, 200);
}
//----------------------------------------------------------------------------------------------------
function hide_fade(){
	if (obj_mc._alpha <= 40){
		obj_mc._visible = false;
		clearInterval(ID_hide_fade);
	} else {
		obj_mc._alpha = obj_mc._alpha - 20;
	}
}