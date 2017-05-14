var DocSizeW = Stage.width;
var DocSizeH = Stage.height;

var ShowFileName = "Yes";
var Scrolling = "Yes";
var DelayImage = 5;
var Effect = "Yes";
var Stretch = "Yes";
var ImageSize = 0;
var PerImage = 100;

var PictureArr = new Array();
var SlideMode = "BackAlbumPic1";
var FadeTrue = false;
var bool_click = false;

function send_event_syn(sendCommand){
	if (clientType == serverMode && server_allow_slideshow == false){
		if (click_self){
			return false;
		} else {
			return true;
		}
	} else {
		if (clientType == serverMode){
			fscommand("servers",sendCommand);
			return false;
		}else{
			if (syn == "true"){
				if (click_self){
					fscommand("clients",sendCommand);
					return true;
				}else{
					return false;
				}
			}else{
				if (click_self){
					return false;
				}else{
					return true;
				}
			}
		}
	}
}

function DisplayPicture_form_server(Index){
	DisplayPictrue(Index);
	clearInterval(intervalID);
	intervalID = setInterval(displayImage,int(DelayImage)*1000);
}

function DisplayPictrue(Index) {
	
	Index = int(Index);
	Invalue = Index;
	
	if (b_send_to_server){
		if (send_event_syn("normal&&&function||DisplayPictrue|~|" + Index + "||slideshow")){
			return;
		}
	}
	fscommand("server_slideshow_index",Index);
	b_send_to_server = true;
	
	if (tools.PauseIcon._visible == true){
		clearInterval(IDPauseSlide);
		setNewInterval();
	}else{
		pauseSlide();
	}
	
	PerImage= int(PerImage);
	//ImageSize=(DocSize*Per)/100;
	if(Effect == "Yes"){
		var IndexEffect = random(nEffect+1)
		if(IndexEffect >= nEffect){
			Alpha = 10;
			Name = SlideMode + ".Pic";
			Name1 = SlideMode + ".PicFade";
			NameFade = SlideMode + ".Movie";
			PicName.length = 0;
			PicName[0] = strPath[Index];
			Reset(1);
		} else {
			Alpha = 50;
			Name = SlideMode + ".Pic";
			Name1 = SlideMode + ".PicFade";
			NameFade =SlideMode+".Movie";
			PicName.length = 0;
			PicName[0] = strPath[Index];
			Reset(1);
			StartEffect(IndexEffect)
		}
	} else {
			Alpha = 10;
			Name = SlideMode + ".Pic";
			Name1 = SlideMode + ".PicFade";
			NameFade = SlideMode + ".Movie";
			PicName.length = 0;
			PicName[0] = strPath[Index];
			Reset(1);
	}
	if(ShowFileName == "Yes")FileName._visible = true;
	else FileName._visible = false;
	FileName.text = strPath[Index];
	current_index = int(Index);
}
//var strPath="D:\\Pics\\pic4\\Pics3\\001.jpg" + "%~%" + "D:\\Pics\\pic4\\Pics3\\002.jpg" + "%~%" + "D:\\Pics\\pic4\\Pics3\\003.jpg" + "%~%" + "D:\\Pics\\pic4\\Pics3\\004.jpg";
var InValue=0;

function Get(){}
function GetImagePath(value){
	Mousex = _root._xmouse;
	Mousey = _root._ymouse;
	TrackShow.setTrackDisplayTheme(FontColor, ColorBar);
	
	//var obj_col = new Color(eval("Bg"));
	//obj_col.setRGB(BgColor);
	
	strPath.length = 0;
	strPath = value.split("%~%");
	
	if (b_connected){
		if (clientType == serverMode){			
			b_send_to_server = false;
			InValue = random(strPath.length);		
			DisplayPictrue(InValue);	
			setNewInterval();
		} else {		
			if (server_slideshow_index == ""){
				b_send_to_server = true;
				//InValue = random(strPath.length);
				InValue = 0;
				DisplayPictrue(InValue);	
				setNewInterval();
			} else {
				if ((syn == "true") and (server_allow_slideshow == false)){
					b_send_to_server = false;
					InValue = random(strPath.length);		
					DisplayPictrue(InValue);	
					setNewInterval();
				} else {
					b_send_to_server = false;
					InValue = int(server_slideshow_index);
					DisplayPictrue(InValue);
				}
			}
		}
	} else {
		b_send_to_server = false;
		InValue = random(strPath.length);		
		DisplayPictrue(InValue);	
		setNewInterval();
	}
}
_root.addProperty("stringPath",_root.Get,_root.GetImagePath);
var Random="Yes";
function displayImage (Move) {
	var index = 0;
	if(Random == "Yes"){
		index = random(strPath.length-1);
		if(InValue == index){
			if(InValue < strPath.length-1) InValue += 1;
			else InValue -= 1;
		} else {
			InValue = index;
		}
	} else {
		if(Move == "Left"){
			if (InValue > 0) Invalue -= 1;
			else Invalue = strPath.length-1;
		}
		else{
			if(InValue < strPath.length-1) Invalue += 1;
			else Invalue = 0;
		}
	}
	DisplayPictrue(InValue);
}
function setNewInterval () {
	if (tools.PlayIcon._visible == true){
		pauseSlide();
	}else{
		clearInterval(intervalID);
		if ((syn == "false") or (clientType == serverMode) or ((syn == "true") and (server_allow_slideshow == false))){
			intervalID=setInterval(displayImage,int(DelayImage)*1000);
		}else{
			clearInterval(intervalID);
		}
	}
}
myListener = new Object();
myListener.onKeyDown = function () {
	var KeyCode=Key.getCode();
	if (KeyCode == 32){
		press_key_space();
	}else{
		if((KeyCode>=48 && KeyCode<=57 )||(KeyCode>=96 && KeyCode<=105)){
//			keyNumPress(Key.getAscii());
		} else if (keyCode == 65) {
			tools.ButtonRotate.onRelease();
		} else if (KeyCode == 85) {
			tools.ButtonPauseSlide.onRelease();
		} else if (KeyCode == 188) {
			tools.ButtonPreviousSlide.onRelease();
		} else if (KeyCode == 190) {
			tools.ButtonNextSlide.onRelease();
		} else if (KeyCode == 79) {
			tools.ButtonBrowseSlide.onRelease();
		}else if (KeyCode == 70) {
			fscommand("AddFile",false);
		}
		/* else if (KeyCode == key_previous) {
			tools.ButtonPreviouse.onRelease();
		} else if (KeyCode == key_next) {
			tools.ButtonNext.onRelease();
		} else if (KeyCode == key_play) {
			tools.ButtonPlay.onRelease();
		} else if (KeyCode == key_pause) {
			tools.ButtonPause.onRelease();
		} else if (KeyCode == key_stop) {
			tools.ButtonStop.onRelease();
		} else if (KeyCode == key_mute) {
			if (tools.ButtonMuteTrue._visible == true){
				tools.ButtonMuteTrue.onRelease();
			}else{
				tools.ButtonMuteFalse.onRelease();
			}
		} else if (KeyCode == key_loop) {
			if (More.ButtonLoopTrue._visible == true){
				More.ButtonLoopTrue.onRelease();
			}else{
				More.ButtonLoopFalse.onRelease();
			}
		} else if (KeyCode == key_shuffle) {
			if (More.ButtonShuffleTrue._visible == true){
				More.ButtonShuffleTrue.onRelease();
			}else{
				More.ButtonShuffleFalse.onRelease();
			}
		} else if ((KeyCode == key_seekUp)||(KeyCode == key_seekDown)) {
			control_mini_player("seek_vol_slideshow",KeyCode,"true");
		} else if (KeyCode == key_volUp || KeyCode == key_volDown) {
		}*/ else if (KeyCode == 76) {
			tools.ButtonRedownload.onRelease();
		} else {
			if(Scrolling=="Yes"){
				if(KeyCode == 37) {
					setNewInterval();
					DisplayImage("Left");
				} else if(KeyCode == 38) {
					InValue = 0;
					DisplayPictrue(InValue);	
					setNewInterval();
				} else if(KeyCode == 39|| KeyCode == 40) {
					setNewInterval();
					DisplayImage("Right");
				} /*else {
					control_mini_player("ExitSlideShow",KeyCode,"true");
				}*/
			}
			else {
				control_mini_player("ExitSlideShow",KeyCode,"true");
			}
		}
	}
}
Key.removeListener(myListener);
Key.addListener(myListener);


//===========================================================================================================
// press key num
var keynum = 0;
function keyNumPress(keyAscii){
	clearInterval(IDKeyPress);
	for (var init=0; init<10; init++){
		if (chr(keyAscii) == init){
			keynum = int(String(keynum)+String(chr(keyAscii)));
			IDKeyPress = setInterval(intervalKeyPress,1500,keynum);
		}
	}
	
}
function intervalKeyPress(keyAscii){
	control_mini_player("fn_selectTrack",keyAscii,"true");
	keynum = 0;
	clearInterval(IDKeyPress);
}
function fn_selectTrack(valKey){
	fscommand("SendKeyNum",valKey);
	keynum = 0;
	clearInterval(IDKeyPress);
}
//-------------------------------------------------------------------------------------------------------
function press_key_space(){
	if (send_event("space_slideshow&&&function||press_key_space", false)){
		return;
	}
	if (tmpPopupInfo != ""){
		fscommand("popup",true);
		//TrackShow.setTrackShow(tmpPopupInfo);
		b_upControl = false;
		seek._visible = true;
		vol._visible = true;
	}
	tools._visible = false;
	currentDate._visible = true;
	//=======		
	clearInterval(IDPlayControll);
	IDPlayControll = setInterval(hidePlayerControll,timeDelay*2);
}