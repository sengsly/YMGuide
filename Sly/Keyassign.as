var key_play = 88;			// X
var key_stop = 86;			// V
var key_previous = 90;			// Z
var key_next = 66;			// B
var key_pause = 67;			// C
var key_showPlaylist = 89;		// Y	' not playlist : playlistPlayer
var key_mute = 77;			// M
var key_loop = 82;			// R
var key_shuffle = 83;			// S
var key_slideShow = 79;			// O
var key_volUp = 187;			// volume Up
var key_volDown = 189;			// volume Down
var key_seekUp = 33;			// seek Up
var key_seekDown = 34;			// seek Down
var key_addFile = 70;			// F
var key_changeLanguage = 69;		// E
var key_playlist = 80;			// P
var key_fullscreenplay = 85;		// U
var key_hideMouse = 116;		// F3
var key_changeWindow = 87;		// W
var key_backspace = 8;			// Backspace
//var key_backspaceComma = 188;		// ,
var key_tab = 9;			// Tab
var key_rightArrow = 39;		// Right Arrow
var key_leftArrow = 37;			// Left Arrow
var key_upArrow = 38;			// Up Arrow
var key_downArrow = 40;			// Down Arrow
var key_enter = 13;			// Enter
var key_space = 32;			// Space
var key_ctrl = 17;			// Ctrl
var key_F2 = 113;			// F2
var key_clickPrevious = 188;		// ,
var key_clickNext = 190;		// .
var key_clickPreviousSymbol = 60	// <
var key_clickNextSymbol = 62		// >
var key_application = 70;		// F
var key_quit = 81;			// Q
var key_new = 78;			// N
var key_language = 76;			// L
var key_minimize = 191;			// /
var key_visualization = 84;		// T
var key_one = 49;			// 1
var key_two = 50;			// 2
var key_slideShow = 192;		// ~
var key_login = 79;			// O
var key_switch = 220;			// |
var key_D = 68;				// D
_global.serverMode = 0;
_global.clonePlayBack = 1;
_global.remotePlaylist = 2;
_global.remoteControl = 3;
_global.independentMode=4;
var check_key_press = false;		// this variable use for check user or client press arrow key for mouse off screen
var app_status = 0;			// this variable notice that it has connection or not (0: no connection, 1: connecting)
var syn_vol = false;			// this variable use for syncronize volume and mute for client syncronize
var syn_vol_change = "false";		// this variable use for allow volume and mute change for server allow
var time_popup_connect = 8;		// this variable use for the time to display popup connect & disconnect (second)
var Website=""
// function get event or send event for client to server or from server to client when in option selected syncronize
// =================================================================================================================
function send_event_syncronize(sendCommand){	// for only volume and mute
	if ((clientType == serverMode) && (syn_vol_change == false)){
		if (click_self){
			return false;
		}else{
			return true;
		}
	}else{
		if (clientType != independentMode){
			if (clientType == serverMode){
				fscommand("servers",sendCommand);
				return false;
			}else{
				if (syn_vol == true){
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
		} else {
			if (click_self){
				return false;
			}else{
				return true;
			}
		}
	}
}

// function get event or send event for client to server or from server to client
// ==============================================================================
function send_event(sendCommand, allow_event){
	//fscommand("mb","clientType : " xclientType + ":" + remotePlaylist + " : " + allow_event + " : "  + click_self);
	
	if (clientType != independentMode){
		if (clientType != remotePlaylist and clientType != remoteControl){
			if (clientType == serverMode){
				fscommand("servers",sendCommand);
				return false;
			}else if ((clientType == clonePlayBack)and click_self){
				fscommand("clients",sendCommand);
				return true;
			}
		}else if (clientType == remotePlaylist or clientType == remoteControl){
			if ((allow_event) and (click_self)){
				fscommand("clients",sendCommand);
				return true;		
			} else if ((allow_event) and !(click_self)){
				return false;
			} else if (!(allow_event) and !(click_self)){
				return true;
			}
		}
		return false;
	} else {
		if (click_self){
			return false;
		} else {
			return true;
		}
	}
}

// this function use for all page to controll mini player, fullscreen and microplayer
// ==================================================================================
function control_mini_player(command,args,allow_event){
	if (clientType == serverMode){
		allow_event = "true";
	}
	if (allow_event == "true"){
		var lcommand = String(command).toLowerCase();
		//if  ((lcommand == "play")||(lcommand == "pause")||(lcommand == "stop")||(lcommand == "repeat")||(lcommand == "shuffle")||(lcommand == "mute")||(lcommand == "volume")||(lcommand == "seek")){
		if  ((lcommand == "play")||(lcommand == "pause")||(lcommand == "stop")||(lcommand == "repeat")||(lcommand == "shuffle")||(lcommand == "mute")||(lcommand == "seek")){
			if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			fscommand("mini", command + "|:|" + args);
		} else if (lcommand == "next"){
			if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|false", true)){
				return;
			}
			fscommand("mini", command + "|:|" + args);
		} else if (lcommand == "previous"){
			if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|false", true)){
				return;
			}
			fscommand("mini", command + "|:|" + args);
		} else if ((lcommand == "key")||(lcommand == "keypressed")||(lcommand == "executekey")){
			//if ((int(args) == 66)||(int(args) == 90)||(int(args) == 187)||(int(args) == 189)||(int(args) == 33)||(int(args) == 34)){
			if(!(lcommand=="keypressed"  and int(args)==68)) {		//key d
			if ((int(args) == 66)||(int(args) == 90)||(int(args) == 33)||(int(args) == 34)){
				if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|false", true)){
					check_key_press = true;
					return;
				}
			}else{
				if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
					check_key_press = true;
					return;
				}
			}
			}
			var tmp_args = int(args);
			if ((tmp_args == 37)||(tmp_args == 38)||(tmp_args == 38)||(tmp_args == 40)){
				if (((click_self == false)and(check_key_press == true))||(click_self == true)){
					fscommand("self_key_press",true);
				}
			}			

			fscommand(command, args);
		} else if (lcommand == "changeindex"){
			if (send_event("mini&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|false", true)){
				return;
			}
			fscommand(command, args);
		} else if ((lcommand == "fn_key_changelanguage")){
			if (send_event("fullscreenPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			eval(command)();
		} else if ((lcommand == "fn_key_changewindow")||(lcommand == "fn_key_hidemouse")||(lcommand == "close_fullscreen_player")||(lcommand == "fn_key_minimize")||(lcommand == "fn_key_visualization")){
			if (send_event("fullscreenPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", false)){
				return;
			}
			eval(command)();
		} else if ((lcommand == "fn_maximize")){
			if (send_event("microPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", false)){
				return;
			}
			eval(command)();
		} else if (lcommand == "fn_selecttrack"){			
			if (send_event("microPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			eval(command)(args);
		} else if (lcommand == "seek_micro"){
			if (send_event("microPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			fscommand("seek", args);
		} else if (lcommand == "seek_fullscreen"){
			if (send_event("fullscreenPlayer&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			fscommand("seek", args);
		} else if ((lcommand == "exitslideshow") || (lcommand == "playlist")){
			if (send_event("slideshow&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", false)){
				return;
			}
			fscommand(command, args);
		} else if (lcommand == "seek_vol_slideshow"){
			if (send_event("slideshow&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			fscommand(command, args);
		}else if (lcommand == "seek_slideshow"){
			if (send_event("slideshow&&&function||control_mini_player|~|" + command + "|~|" + args + "|~|true", true)){
				return;
			}
			fscommand("Seek", args);
		}
	}
	fscommand("self_key_press",true);
}

//------------------------------------------------------------------------------------------------------------
function set_syn_volume(val){
	val = String(val).toLowerCase();
	if (val == "true"){
		syn_vol = true;
	}else{
		syn_vol = false;
	}
}
function get_syn_volume(){}
this.addProperty("syn_volume",get_syn_volume,set_syn_volume);
//------------------------------------------------------------------------------------------------------------
function set_syn_volume_change(val){
	val = String(val).toLowerCase();
	if (val == "true"){
		syn_vol_change = true;
	}else{
		syn_vol_change = false;
	}
}
function get_syn_volume_change(){}
this.addProperty("syn_volume_change",get_syn_volume_change,set_syn_volume_change);
//------------------------------------------------------------------------------------------------------------
function control_syncronize(syn_type,command,args){	
	if (syn_type == "volume"){
		if (send_event_syncronize("syn&&&function||control_syncronize|~|" + syn_type + "|~|" + command + "|~|" + args)){
			return;
		}
		fscommand(command, args);
	} else if (syn_type == "Mute"){
		if (send_event_syncronize("syn&&&function||control_syncronize|~|" + syn_type + "|~|" + command + "|~|" + args)){
			return;
		}
		fscommand(command, args);
	}
}
//------------------------------------------------------------------------------------------------------------
var disconnect_xml = new XML();
var response_disconnnect_xml = new XML();
function set_server_sign_out(val) {
/*
	val = String(val);
	var param = "LoginName=" + val + "&submit=Offline";
	disconnect_xml.sendAndLoad("http://www.slymultimedia.com/login.php?" + param, response_disconnnect_xml);
	fscommand("exit_application", "");
*/
	var _arr = new Array();
	_arr = String(val).split("||");
	var param = "LoginName=" + _arr[0] + "&nickName=" + _arr[1] + "&submit=Offline";
	disconnect_xml.sendAndLoad("http://www.slymultimedia.com/login.php?" + param, response_disconnnect_xml);
	fscommand("exit_application", "");
}
function get_server_sign_out() {
}
_root.addProperty("server_sign_out", get_server_sign_out, set_server_sign_out);
//------------------------------------------------------------------------------------------------------------
var request_permission_xml = new XML();
var response_permission_xml = new XML();
response_permission_xml.onLoad = function(){
	clear_waiting();
	var per = response_permission_xml.firstChild.attributes.val;
	var s = "";	// store string split from permisstion number	
	var p_arr = new Array(false,false,false,false,false,false);
	
	for (var init=0; init<length(per); init++){
		s = String(per).substr(init,1);
		p_arr[int(s)-1] = true;
	}	
	fscommand("allow_login_permission",p_arr);
}
function set_client_permission(val) {
	var ids = new Array();
	ids = String(val).split("||");
	var param = "UserId=" + ids[0] + "&ServerId=" + ids[1] + "&submit=Permission"
	request_permission_xml.sendAndLoad("http://www.slymultimedia.com/login.php?" + param, response_permission_xml);
	show_waiting();
}
function get_client_permission() {
}
_root.addProperty("permission_client_login", get_client_permission, set_client_permission);
//----------------------------------------------------------------------------------------------------
//****************************************************************************************************
//************* Special for all swf files display allow client want to connect to server *************
//****************************************************************************************************
function set_request_new_connection(val) {
	new_request.show_mc(val);
}
function get_request_new_connection() {
}
_root.addProperty("request_new_connection", get_request_new_connection, set_request_new_connection);
//----------------------------------------------------------------------------------------------------
var request_new_xml = new XML();
var response_new_xml = new XML();
response_new_xml.onLoad = function(){
	clear_waiting();
	var val_status = response_new_xml.firstChild.attributes.Status;
	if (val_status == "Insert Success"){
		new_request.hide_mc();
		fscommand("start_allow_connect",new_request.str_permission);
	}
}
function set_permission_for_new_request(str) {
	var param = "sss=" + str + "&submit=InsertPermission";
	request_new_xml.sendAndLoad("http://www.slymultimedia.com/login.php?" + param, response_new_xml);
	show_waiting();
}
//----------------------------------------------------------------------------------------------------
function set_server_deny(val) {
	if (val == "True"){
		search.hide_mc();
	}
}
function get_server_deny() {
}
_root.addProperty("server_deny", get_server_deny, set_server_deny);
//****************************************************************************************************
//----------------------------------------------------------------------------------------------------
function show_waiting(){
	ID_waiting = setInterval(clear_waiting,1000*60);
	enabled_waiting._visible = true;
	wait._visible = true;
	wait.gotoAndPlay(2);
}
//----------------------------------------------------------------------------------------------------
function clear_waiting(){
	clearInterval(ID_waiting);
	enabled_waiting._visible = false;
	wait._visible = false;
	wait.gotoAndPlay(1);
}
//----------------------------------------------------------------------------------------------------
var request_set_xml = new XML();
var response_set_xml = new XML();
response_set_xml.onLoad = function(){
//	clear_waiting();
}
function set_permission_connect(val) {
	var _arr = new Array();
	_arr = String(val).split("||");
	r = _arr[0] + "^" + _arr[1] + "~" + _arr[2];
	var param = "sss=" + r + "&submit=InsertPermission";
	request_set_xml.sendAndLoad("http://www.slymultimedia.com/login.php?" + param, response_set_xml);
//	show_waiting();
}
function get_permission_connect() {
}
_root.addProperty("set_permission_connect", get_permission_connect, set_permission_connect);
//----------------------------------------------------------------------------------------------------
function set_combind_key_Unicode() {
	TopBar.ButtonL.onRelease();
}
function get_combind_key_Unicode() {
}
_root.addProperty("combind_key_Unicode", get_combind_key_Unicode, set_combind_key_Unicode);

_global.KeyMovement=function (LeftArrow,RightArrow,UpArrow,DownArrow) {
	//maybe not use
	this.LeftArrow=LeftArrow;
	this.RightArrow=RightArrow;
	this.UpArrow=UpArrow;
	this.DownArrow=DownArrow;
}//for keymovement here

_global.MoveSelection=function (Direction,ObjName) {
	//maybe not use
	switch(Direction){
		case "Right":
			var ObjSelectNew=eval(ObjName).Selections;
			selectobj( ObjSelectNew.RightArrow);
			break;
		case "Left":
			var ObjSelectNew=eval(ObjName).Selections;
			selectobj( ObjSelectNew.LeftArrow);
			break;
	}
}
function MoveKey(Direction, ObjArray, SelectedObj) {
	var loc_objArray = new Array();
	var max_length = 555555,max_Tangan=555555;//make it high
	var max_Object;
	var point1 = new Object();
	var point2 = new Object();
	SelectedObj = eval(SelectedObj);
	point1= SelectedObj.getBounds(_root);
	point1.x = point1.xMin;
	point1.y = point1.yMin;
	switch (Direction) {
	case key_leftArrow :
		if (String(SelectedObj) == "_level0.previous_mc"  || String(SelectedObj ) == "_level0.add_mc"  || String(SelectedObj)  == "_level0.outScreenPlayer" ) // from mini to track list
		{
			fscommand("moveToShowInterface", "Movie");
			return 0;
		}
		for (var i = 0; i<ObjArray.length; i++) {
			point2=ObjArray[i].getBounds(_root);
			point2.x = point2.xMin;
			point2.y = point2.yMin;
			if (point2.x<point1.x and ObjArray[i]._visible and ObjArray[i].enabled) {
				ObjArray[i].bInBound =	isInBound(point1.yMin,point2.yMin,point2.yMax) or isInBound(point1.yMax,point2.yMin,point2.yMax) or
										isInBound(point2.yMin,point1.yMin,point1.yMax) or isInBound(point2.yMax,point1.yMin,point1.yMax);
				
				//if there is items to the left so add to the array
				loc_objArray.push(ObjArray[i]);
			}
		}
		
		break;
	case key_RightArrow :
		for (var i = 0; i<ObjArray.length; i++) {
			point2=ObjArray[i].getBounds(_root);
			point2.x = point2.xMin;
			point2.y = point2.yMin;
			if (point2.x>point1.x and ObjArray[i]._visible and ObjArray[i].enabled) {
				ObjArray[i].bInBound =	isInBound(point1.yMin,point2.yMin,point2.yMax) or isInBound(point1.yMax,point2.yMin,point2.yMax) or
										isInBound(point2.yMin,point1.yMin,point1.yMax) or isInBound(point2.yMax,point1.yMin,point1.yMax);
				//if there is items to the left so add to the array
				loc_objArray.push(ObjArray[i]);
			}
		}
		break;
	case key_UpArrow :
		for (var i = 0; i<ObjArray.length; i++) {
			point2=ObjArray[i].getBounds(_root);
			point2.x = point2.xMin;
			point2.y = point2.yMin;
			if (point2.y<point1.y and ObjArray[i]._visible and ObjArray[i].enabled) {
				ObjArray[i].bInBound =	isInBound(point1.xMin,point2.xMin,point2.xMax) or isInBound(point1.xMax,point2.xMin,point2.xMax) or
										isInBound(point2.xMin,point1.xMin,point1.xMax) or isInBound(point2.xMax,point1.xMin,point1.xMax);
				//if there is items to the left so add to the array
				loc_objArray.push(ObjArray[i]);
			}
		}
		break;
	case key_DownArrow :
		for (var i = 0; i<ObjArray.length; i++) {
			point2=ObjArray[i].getBounds(_root);
			point2.x = point2.xMin;
			point2.y = point2.yMin;
			if (point2.y>point1.y and ObjArray[i]._visible and ObjArray[i].enabled) {
				ObjArray[i].bInBound =	isInBound(point1.xMin,point2.xMin,point2.xMax) or isInBound(point1.xMax,point2.xMin,point2.xMax) or
										isInBound(point2.xMin,point1.xMin,point1.xMax) or isInBound(point2.xMax,point1.xMin,point1.xMax);
				
				//if there is items to the left so add to the array
				loc_objArray.push(ObjArray[i]);
			}
		}
		break;
	}
	var max_InBound=false;
	for (var i = 0; i<loc_objArray.length; i++) {
		point2=loc_objArray[i].getBounds(_root);
		point2.x = point2.xMin;
		point2.y = point2.yMin;
		objLength = Math.pow(point1.x-point2.x,2)+Math.pow(point1.y-point2.y,2);
		objTangan = loc_objArray[i].Tangan;
		objInBound= loc_objArray[i].bInBound;
		if(objInBound){
			if(max_InBound==false){
				max_length = objLength;
				max_Object = loc_objArray[i];
				max_InBound=true;
			}else{
				if(objLength<max_Length){
					max_length = objLength;
					max_Object = loc_objArray[i];
					max_InBound=true;
				}
			}
		}else{
			if(max_InBound==false and objLength<max_Length){
				max_length = objLength;
				max_Object = loc_objArray[i];
			}
		}
	}
	return (max_Object);
}
_global.SetConnectColor=function(obj,iVal){
	var con_color = new Color(obj);	
	var rColor;
	iVal=int(iVal);
	
	if (iVal == 0){
		//not connected
		rColor= "0xFFFFFF";
	}else if(iVal==1){
		//not connected
		rColor= "0x00FF00";
	}else if (iVal==2){
		//not connected
		rColor= "0xFFCC00";
	}else{
		rColor= "0xFF0000";
	}
	con_color.setRGB(rColor);
}
function isInBound (iValue,iMin,iMax) {
	return ((iValue>=iMin) and( iValue<=iMax)) or ((iValue<=iMin) and( iValue>=iMax));
}
//============================================================


//============================================================
