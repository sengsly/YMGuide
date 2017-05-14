strNameDisplay = this;				
strNameDisplay._visible = false;

var track_locations = new Array();
var trackXml = new XML();
var new_textFormat = new TextFormat();
var limon_font_size = 0;
var other_font_size = 0;
var xLocation = 0;
var yLocation = 0;
var screen = 0;
var val_img_width = 0;
var val_img_height = 0;
var val_img_x = 0;
var val_img_y = 0;
var tmp_img_album = "";
var text_length = 0;
var text_cut = 30;

//===========================================================================================================
function setTrackShow(str_value){	
	time_ID = 0;
	//str_value = "1/3//\\\\3:38//\\\\Vol 153 - Uy! Yob Menh Khnhom Penh Komloh - 01 - Uy! Yob Menh Khnhom Penh Komloh//\\\\Arial//\\\\Sample Song//\\\\Vol 153 - Uy! Yob Menh Khnhom Penh Komloh//\\\\Times New Roman//\\\\D:\\Folder.jpg";
	img_album._visible = false;
	strNameDisplay._x = xLocation;
	strNameDisplay._y = yLocation;
	stopDrag();
	clearInterval(setID);
	stringDisplay(str_value);
	setID = setInterval(hideTrackShow,1000 * 6);	
}
//===========================================================================================================
function hideTrackShow(){
//	time_ID += 1;
//	if (int(time_ID) == int(3)){		
	strNameDisplay._x = xLocation;
	strNameDisplay._y = yLocation;
	stopDrag();
	strNameDisplay._visible = false;
	clearInterval(setID);		
//	}
}
//===========================================================================================================
function stringDisplay(str_value){
	var num_scale = new Number();
	var arr_str = new Array();
	var trackTextFormat = new TextFormat();
	
	arr_str = String(str_value).split("//\\\\");
	
	if (arr_str.length == 1){
		img_border._visible = false;
		img_alubm._visible = false;
		img_none._visible = false;
		//img_album.unloadMovie();
		
		img_border._width = 1;
		img_border._height = 1;
		img_border._x = 0;
		img_border._y = 0;
		
		img_album._width = 1;
		img_album._height = 1;
		img_album._x = 0;
		img_album._y = 0;
		
		img_none._width = 1;
		img_none._height = 1;
		img_none._x = 0;
		img_none._y = 0;
		
		setText("mc_title",arr_str[0],new_textFormat);
		
		bgDisplay._width = mc_title._width;
		bgDisplay._height = mc_title._height;
		bgDisplay._x = 0;
		bdDisplay._y = 0;
		
		mc_title._x = (0 - (bgDisplay._width/2))+((bgDisplay._width - mc_title._width)/2);
		mc_title._y = (0 - (bgDisplay._height/2))+((bgDisplay._height - mc_title._height)/2);
		
		setText("mc_sample","",new_textFormat);
		mc_sample._x = 0;
		mc_sample._y = 0;
		mc_sample._visible = false;
		
		setText("mc_pos","",new_textFormat);
		mc_pos._x = 0;
		mc_pos._y = 0;
		mc_pos._visible = false;		
		
		setText("mc_len","",new_textFormat);
		mc_len._x = 0;
		mc_len._y = 0;
		mc_len._visible = false;
		
		setText("mc_artist","",new_textFormat);
		mc_artist._x = 0;
		mc_artist._y = 0;
		mc_artist._visible = false;
		
		strNameDisplay._visible = true;
		
		num_scale = 7;
	}else{
		//------
		var fontUnicode=arr_str[5];
		var fontNormal=arr_str[6];
		var displayText;
		setText("mc_pos",arr_str[0],new_textFormat);
		mc_pos._visible = true;
		
		//------
		setText("mc_len","(" + arr_str[1] + ")",new_textFormat);
		mc_len._visible = true;
		
		//------
		displayText=arr_str[3].split("{|}");
		trackTextFormat.font = (displayText[1]==1) ? fontUnicode : fontNormal;
		if (String(trackTextFormat.font).substr(0,5) == "Limon"){
			trackTextFormat.size = limon_font_size;
			cutString("mc_title",trackTextFormat,displayText[0],text_length,">>>")
		}else{
			trackTextFormat.size = other_font_size;
			cutString("mc_title",trackTextFormat,displayText[0],text_length,"...")
		}
		mc_title._visible = true;
		
		
		
		//------
		displayText=arr_str[4].split("{|}");
		trackTextFormat.font = (displayText[1]==1) ? fontUnicode : fontNormal;
		if (String(trackTextFormat.font).substr(0,5) == "Limon"){
			trackTextFormat.size = limon_font_size;
			cutString("mc_artist",trackTextFormat,displayText[0],text_length,">>>")
		}else{
			trackTextFormat.size = other_font_size;
			cutString("mc_artist",trackTextFormat,displayText[0],text_length,"...")
		}
		mc_artist._visible = true;
		
		//------
		displayText=arr_str[2].split("{|}");
		trackTextFormat.font = (displayText[1]==1) ? fontUnicode : fontNormal;
		if (String(trackTextFormat.font).substr(0,5) == "Limon"){
			trackTextFormat.size = limon_font_size;
			cutString("mc_sample",trackTextFormat,displayText[0],text_length,">>>")
		}else{
			trackTextFormat.size = other_font_size;
			cutString("mc_sample",trackTextFormat,displayText[0],text_length,"...")
		}		
		mc_sample._visible = true;
		//------
		// check for width and height of popup track
		bgDisplay._height = mc_sample._height + mc_pos._height + mc_title._height + mc_artist._height;
		var arr_width = new Array(int(mc_sample._width + bgDisplay._height),int(mc_pos._width + mc_len._width + bgDisplay._height),int(mc_title._width + bgDisplay._height),int(mc_artist._width + bgDisplay._height));
		
		// find max width
		var max_width = 0;
		for (var init = 0;init<arr_width.length;init++){
			if (max_width < arr_width[init]){
				max_width = arr_width[init];
			}
		}
		bgDisplay._width = max_width;//arr_width[arr_width.length-1];
		bgDisplay._x = 0;
		bdDisplay._y = 0;
		
		//------
		// set img_album position, width and height
		img_border._width = bgDisplay._height;
		img_border._height = bgDisplay._height;
		img_border._x = 0 - (bgDisplay._width/2);
		img_border._y = 0 - (bgDisplay._height/2);
		val_img_width = img_border._width;
		val_img_height = img_border._height;
		val_img_x = img_border._x;
		val_img_y = img_border._y;
		
		img_none._width = val_img_width;
		img_none._height = val_img_height;
		img_none._x = val_img_x;
		img_none._y = val_img_y;
		
		img_album._width = val_img_width;
		img_album._height = val_img_height;
		img_album._x = val_img_x;
		img_album._y = val_img_y;
		
		if (arr_str[7] != ""){
			if ((tmp_img_album !=  arr_str[7])and(arr_str[7] != "None")){
				img_none._visible = false;
				//img_album.unloadMovie();
				//img_album.loadMovie(arr_str[7]);
				img_album._visible = true;
				img_album.set_load_image(arr_str[7]);
			}else{
				img_none._visible = true;
				img_border._visible = true;
				img_album._visible = false;
			}
			strNameDisplay._visible = true;
		}

		//------
		// set location for each mc_..... and img_album
		var tmp_x = img_border._x + img_border._width;
		var tmp_y = img_border._y;		
		var tmp_w = bgDisplay._width - img_border._width;
		
		mc_sample._x = tmp_x + (tmp_w - mc_sample._width)/2;
		//mc_sample._y = img_border._y;
		mc_sample._y =   bgDisplay._y;
		mc_pos._x = tmp_x;
		mc_pos._y = tmp_y + mc_sample._height+10;
		
		mc_len._x = (bgDisplay._width/2) - mc_len._width;
		mc_len._y = mc_pos._y;
		
		mc_title._x = tmp_x + (tmp_w - mc_title._width)/2;
//		mc_title._y = mc_pos._y + mc_pos._height;
		mc_title._y = img_border._y;

		mc_artist._x = tmp_x + (tmp_w - mc_artist._width)/2;
		mc_artist._y = img_border._y + img_border._height - mc_artist._height;
		
		num_scale = 35;

//		var tmp_height = new Number();
//		tmp_height = _root.TrackShow._height;
//		_root.TrackShow._height = int((num_scale * Stage.height) / 100);
//		_root.TrackShow._width = int((_root.TrackShow._width * _root.TrackShow._height) / tmp_height);
	}
	
  //===============
  // check main position
	// for left
	if ((strNameDisplay._x - (strNameDisplay._width/2))<0){
		
		strNameDisplay._x = strNameDisplay._width/2;
	}else{
		strNameDisplay._x = xLocation;
	}
	// for top
	if ((strNameDisplay._y - (strNameDisplay._height/2))<0){
		strNameDisplay._y = strNameDisplay._height/2;
	}else{
		strNameDisplay._y = yLocation;
	}
	// for right
	if ((strNameDisplay._x + (strNameDisplay._width/2))>Stage.width){
		strNameDisplay._x = Stage.width - (strNameDisplay._width/2);
	}
	// for buttom
	if ((strNameDisplay._y + (strNameDisplay._height/2))>Stage.height){
		strNameDisplay._y = Stage.height - (strNameDisplay._height/2);
	}
  //===============	
}
//===========================================================================================================
function setTrackDisplayTheme(val_textColor,val_background){
	var new_color = new Color(bgDisplay);
	new_color.setRGB(val_background);
	mc_pos.txt.textColor = val_textColor;
	mc_len.txt.textColor = val_textColor;
	mc_title.txt.textColor = val_textColor;
	mc_sample.txt.textColor = val_textColor;
	mc_artist.txt.textColor = val_textColor;
}
//===========================================================================================================
trackXml.load("Setting.xml");
trackXml.onLoad = function(){
	var arr_location = new Array();
	getScreenType();
	track_locations = String(trackXml.firstChild.childNodes[2].attributes.trackLocation).split("-");
	arr_location = String(track_locations[0]).split(":");
	if (track_locations[1] != (Stage.width + ":" + Stage.height)){
		xLocation = Stage.width/2;
		yLocation = Stage.height/2;
		strNameDisplay._x = xLocation;
		strNameDisplay._y = yLocation;
	}else{
		xLocation = arr_location[0];
		yLocation = arr_location[1];
		strNameDisplay._x = xLocation;
		strNameDisplay._y = yLocation;
	}	
	//setTrackShow("TEST");
}
//===========================================================================================================
// Function get screen type;
function getScreenType(){
	var val_s = Stage.width/Stage.height;
	if ((val_s == (1024/768))|| (Math.abs(val_s - (800/640)))<0.001 ){
		text_length = 500;
		text_cut = 30;
		font_size = 25;
		limon_font_size = 46;
		other_font_size = 34;
		screen = 0;
	}else if (val_s == (1280/720)){
		text_length = 900;
		text_cut = 45;
		font_size = 35;
		limon_font_size = 56;
		other_font_size = 44;
		screen = 1;
	}else if (val_s == (1280/768)){
		text_length = 900;
		text_cut = 45;
		font_size = 35;
		limon_font_size = 56;
		other_font_size = 44;
		screen = 2;
	}else if (val_s == (1280/800)){
		text_length = 900;
		text_cut = 45;
		font_size = 35;
		limon_font_size = 56;
		other_font_size = 44;
		screen = 3;
	}else if (val_s == (1024/600)){
		text_length = 500;
		text_cut = 30;
		font_size = 35;
		limon_font_size = 56;
		other_font_size = 44;
		screen = 4;
	}
	new_textFormat.font = "Arial"
	new_textFormat.size = font_size;
}
//===========================================================================================================
function setText(obj,val_str,val_format){
	eval(obj + ".txt").text = val_str;
	eval(obj + ".txt").setTextFormat(val_format);	
	eval(obj + ".txt")._x = 0;
	eval(obj + ".txt")._y = 0;
}
//===========================================================================================================
function changeLocation(objName){
	var concate_string = "";
	xLocation = eval("_root." + objName)._x;
	yLocation = eval("_root." + objName)._y;
	concate_string = xLocation + ":" + yLocation;
	concate_string = concate_string + "-" + Stage.width + ":" + Stage.height;
	fscommand("trackLocation",concate_string);
}

//===========================================================================================================
function cutString(txt_obj,txt_format,str,init_strLength,str_newConcate){
	setText(txt_obj,str,txt_format);
	if (parseInt(eval(txt_obj + ".txt").textWidth) > parseInt(init_strLength)){
		for (var init=0; init<String(str).length; init++){			
			setText(txt_obj,String(str).substr(0,init) + str_newConcate,txt_format);
			if (parseInt(eval(txt_obj + ".txt").textWidth) > parseInt(init_strLength)){
				setText(txt_obj,String(str).substr(0,init-1) + str_newConcate,txt_format);				
				return;
			}
		}
	}
	return;
}