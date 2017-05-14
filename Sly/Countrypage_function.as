var Website=""
var addPageButtons =  [addNewPage.new_server,addNewPage.scan_server, addNewPage.new_application, addNewPage.edit_application, 
						addNewPage.new_language, addNewPage.download_language, addNewPage.edit_language,
						addNewPage.deleted, addNewPage.move_up, addNewPage.move_down];
var addPageServer =  		[573.4, 663.6, null , null ,null  ,null  ,null  ,753.9 , 844.1 ,  934.5];
var addPageCountry =  		[null , null, null  , null , 571.5,644.5 , 717.5,790.5 , 863.5 ,  936.5];
var addPageApplication =  	[null , null,571.5 , 662.8, null ,null  , null ,754.0  ,845.3 ,  936.5];





function check_internet_connection(){
	var accept_xml = new XML();
	accept_xml.load("http://www.slymultimedia.com");
	accept_xml.onLoad = function(success){
		accept_internet = success;
	}
}
//----------------------------------------------------------------------------------------------------
function allLanguageUpdates(LName,LStringUpdate,LBoolUpdate){
	this.LName = LName;
	this.LStringUpdate = LStringUpdate;
	this.LBoolUpdate = LBoolUpdate;
}
//----------------------------------------------------------------------------------------------------
function languageServers(LServer,LDBServer,LImgServer){
	this.LServer = LServer;
	this.LDBServer = LDBServer;
	this.LImgServer = LImgServer;
}
//----------------------------------------------------------------------------------------------------
function sign_ups(UpID,UpName,permission,changed,online){
	this.id = UpID;
	this.SUName = UpName;
	this.permission = permission;
	this.changed = changed;
	this.online = online;
}
//----------------------------------------------------------------------------------------------------
function searchs(sName,sID,sIP,sEmail,pass,sUserName){
	this.sName = sName;
	this.sID = sID;
	this.sIP = sIP;
	this.sEmail = sEmail;
	this.spass = pass;
	this.sUserName=sUserName;
}
//----------------------------------------------------------------------------------------------------
function offline_connects(cName,cID,cPer,online){
	this.cName = cName;
	this.cID = cID;
	this.cPer = cPer;
	this.online = online;
}
//----------------------------------------------------------------------------------------------------
function getServerLink(){
	var sxml = new XML();
	sxml.load("http://www.slymultimedia.com/cds/cdxml.xml");
	//sxml.load("C:\\cdxml.xml");		// get server
	sxml.onLoad = function(success){
		if (success){
			var l = new Array();
			var cn = "";
			var is = "";
			var dbs = "";
			l = sxml.firstChild.childNodes;
			for (var i=0; i<l.length; i++){
				cn = l[i].attributes.countryName;
				is = l[i].attributes.imageServer;
				dbs = l[i].attributes.dbServer;
				server_array[i] = new languageServers(cn,dbs,is);				
			}
			getDateUpdate();
		}
	}
}
//----------------------------------------------------------------------------------------------------
function getDateUpdate(){
	var sxml = new XML();
	sxml.load("http://www.slymultimedia.com/cds/countries.xml");
	//sxml.load("C:\\countries.xml");		// get date
	sxml.onLoad = function(success){
		if (success){
			var l = new Array();
			var ln = "";			// languageName;
			var ld = "";			// lastDownload
			var lu = "";			// lastUpdate
			var is = "";			// imageServer
			var dbs = "";			// dbServer
			l = sxml.firstChild.childNodes;
			for (var i=0; i<l.length; i++){
				ln = l[i].childNodes[0].nodeValue;
				ld = l[i].attributes.lastDownload;
				lu = l[i].attributes.lastUpdate;				
				for (var j = 0; j < server_array.length; j++){
					if (ln == server_array[j].LServer){
						is = server_array[j].LDBServer;
						dbs = server_array[j].LImgServer;
					}
				}
				all_update_array[i] = new allLanguageUpdates(ln,ld + "||" + lu + "||" + ln + "||" + dbs + "||" + is,false);
			}			
			get_current_language();
		}
	}
}
//----------------------------------------------------------------------------------------------------
function get_current_language(){
	var a = 0;
	var l_array = new Array();
	var AL = "";
	l_array = String(str_languageNames).split("~");
	for (var i = 0; i < l_array.length; i++){
		for (var jj = 0; jj < all_update_array.length; jj++){
			if (l_array[i] == all_update_array[jj].LName){
				//fscommand("check_update_ava",all_update_array[jj].LStringUpdate);
				//current_update_array[a] = new allLanguageUpdates(all_update_array[jj].LName,all_update_array[jj].LStringUpdate,false);				
				if (AL == ""){
					AL = all_update_array[jj].LStringUpdate;









				} else {
					AL = AL + "%%" + all_update_array[jj].LStringUpdate;
				}
				jj = all_update_array.length;
			}
		}
		a++;
	}



	fscommand("check_update_ava",AL);
}
//----------------------------------------------------------------------------------------------------
function fn_start_auto_update_DB(){
	var dl = new Array();
	if (ind_language < language_need_to_update_array.length){
		dl = String(language_need_to_update_array[ind_language]).split("||");
		CurrentCountry = dl[2];

		UpdateDB.PatientText.text = "Please be patient, now updating " + CurrentCountry + " database...";
		UpdateDB._visible = true;
		enabled_all._visible = true;
		fscommand("start_update_db", language_need_to_update_array[ind_language]);
		
		ind_language++;
		if (ind_language == language_need_to_update_array.length){
			ind_language = 0;
			language_need_to_update_array.length = 0;
		}
	}
}

//----------------------------------------------------------------------------------------------------
function set_color(obj, col, alpha) {	
	var tmp_obj_color = new Color(obj);
	tmp_obj_color.setRGB(col);
	obj._alpha = alpha;
}
function set_selected(obj) {
	fn_tooltip();
	set_color(selectedObject, btn_color, btn_alpha);
	set_color(obj, btn_color_selected, btn_alpha_selected);
	selectedObject = obj;
}

function set_selected1(obj) {
	/*if (send_event("normal&&&Over||" + obj + "||1",false)){
		return;
	}*/
	fn_tooltip();
	set_color(selectedObject, btn_color, btn_alpha);
	set_color(obj, btn_color_selected, btn_alpha_selected);
	selectedObject = obj;
}

// function show tooltip
//=====================================================
function fn_tooltip(obj,str_tip){
	var xm = int(_xmouse);
	var tw = 0;
	var sw = Stage.width;
	var str = "";
	var mp = (obj._xmouse >= obj._x)and(obj._ymouse >= obj._y)and(obj._xmouse <= (obj._x + obj._width))and(obj._ymouse <= (obj._y + obj._height));	
	if (obj._parent.tip != undefined){
		str = obj._parent.tip;
	}else{
		str = str_tip;
	}
	if ((obj != undefined)and(showTooltip == true)and mp){
		
		clearInterval(ID_tooltip);
		tooltip._visible = false;
		
		tooltip.textColor = "0x000000";
		tooltip.background = true;
		tooltip.backgroundColor = "0xFCEEB6";
		tooltip.border = true;
		tooltip.borderColor = "0x000000";
		
		tooltip.text = str;
		tooltip.autoSize = true;
		tooltip._y = _ymouse + 25;
		tw = int(tooltip.textWidth);
		if ((xm + tw) > sw){
			if ((xm + (tw/2)) > sw){
				tooltip._x = xm - tw;
			}else{
				tooltip._x = xm - (tw/2);
			}		
		}else{
			tooltip._x = xm;
		}
		tooltip._visible = true;
		ID_tooltip = setInterval(clear_tooltip,2000);
	}else{
		clearInterval(ID_tooltip);
		tooltip._visible = false;
	}
}
function clear_tooltip(){
	clearInterval(ID_tooltip);
	tooltip._visible = false;
}

//=====================================================
function changeColorObj() {	

	set_color(menu.bg, colorBar, 100);
	
	set_color(menu.sign_up.mc, btn_color, btn_alpha);
	set_color(menu.sign_out.mc, btn_color, btn_alpha);
	//set_color(menu.online.mc, btn_color, btn_alpha);
	//set_color(menu.offline.mc, btn_color, btn_alpha);
	set_color(menu.permission.mc, btn_color, btn_alpha);
	set_color(menu.minimize.mc, btn_color, btn_alpha);
	set_color(menu.exit.mc, btn_color, btn_alpha);
	menu.sign_up.Caption.textColor = text_color;
	menu.sign_out.Caption.textColor = text_color;
	menu.permission.Caption.textColor = text_color;
	menu.minimize.Caption.textColor = text_color;	
	menu.exit.Caption.textColor = text_color;
	//====================================================
	set_color(ButtonMovie.UnChecked, btn_color, btn_alpha);
	set_color(ButtonTV.UnChecked, btn_color, btn_alpha);
	set_color(ButtonKaraoke.UnChecked, btn_color, btn_alpha);
	set_color(ButtonMusic.UnChecked, btn_color, btn_alpha);
	set_color(ButtonCD.UnChecked, btn_color, btn_alpha);
	
 	set_color(UpdateDB.bar, colorBar, 100);
	set_color(bg, bg_color, 100);
	set_color(addNewPage.bg, bg_color, 100);
	set_color(addNewPage.bar, colorBar, 100);
	set_color(exit.mc, btn_color, btn_alpha);
	set_color(previous.mc, btn_color, btn_alpha);
	set_color(next.mc, btn_color, btn_alpha);
	set_color(application.mc, btn_color, btn_alpha);
	set_color(playlist.mc, btn_color, btn_alpha);
	set_color(login.mc, btn_color, btn_alpha);
	set_color(switchMode.mc, btn_color, btn_alpha);
	set_color(addLanguage.mc, btn_color, btn_alpha);
	set_color(languagePage.mc, btn_color, btn_alpha);
	set_color(addNewPage.client_img.mc, btn_color, btn_alpha);
	set_color(addNewPage.Back.mc, btn_color, btn_alpha);
	set_color(addNewPage.previous.mc, btn_color, btn_alpha);
	set_color(addNewPage.next.mc, btn_color, btn_alpha);
	set_color(addNewPage.new_server.mc, btn_color, btn_alpha);
	set_color(addNewPage.scan_server.mc, btn_color, btn_alpha);
	set_color(addNewPage.new_application.mc, btn_color, btn_alpha);
	set_color(addNewPage.edit_application.mc, btn_color, btn_alpha);
	set_color(addNewPage.edit_application.selected, btn_color_selected, btn_alpha);
	set_color(addNewPage.deleted.mc, btn_color, btn_alpha);
	set_color(addNewPage.deleted.selected, btn_color_selected, btn_alpha);
	set_color(addNewPage.move_up.mc, btn_color, btn_alpha);
	set_color(addNewPage.move_up.selected, btn_color_selected, btn_alpha);
	set_color(addNewPage.move_down.mc, btn_color, btn_alpha);
	set_color(addNewPage.move_down.selected, btn_color_selected, btn_alpha);
	set_color(addNewPage.new_language.mc, btn_color, btn_alpha);
	set_color(addNewPage.download_language.mc, btn_color, btn_alpha);
	set_color(addNewPage.edit_language.mc, btn_color, btn_alpha);
	set_color(addNewPage.edit_language.selected, btn_color_selected, btn_alpha);
	set_color(sly_name_mc.ok.mc, btn_color, btn_alpha);
	set_color(sly_name_mc.cancel.mc, btn_color, btn_alpha);
	set_color(alert.ok.mc, btn_color, btn_alpha);
	set_color(alert.cancel.mc, btn_color, btn_alpha);
	set_color(input.ok.mc, btn_color, btn_alpha);
	set_color(input.cancel.mc, btn_color, btn_alpha);
	set_color(loginType.closed.mc, btn_color, btn_alpha);
	set_color(loginType.mode1.mc, btn_color, btn_alpha);
	set_color(loginType.mode2.mc, btn_color, btn_alpha);
	set_color(loginType.mode3.mc, btn_color, btn_alpha);
	set_color(loginType.mode4.mc, btn_color, btn_alpha);
	set_color(loginType.mode5.mc, btn_color, btn_alpha);
	set_color(loginType.remote_mode.mc, btn_color, btn_alpha);
	set_color(loginType.bar, colorBar, 100);
	loginType.title_txt.textColor = text_color;
	set_color(download.next.mc, btn_color, btn_alpha);
	set_color(download.previous.mc, btn_color, btn_alpha);
	set_color(download.ok.mc, btn_color, btn_alpha);
	set_color(download.cancel.mc, btn_color, btn_alpha);
	set_color(edit.ok.mc, btn_color, btn_alpha);
	set_color(Signup_mc.submit_btn.mc,btn_color,btn_alpha);
	set_color(Signup_mc.Cancel_btn.mc,btn_color,btn_alpha);
	
	set_color(edit.cancel.mc, btn_color, btn_alpha);
	set_color(edit.folder.mc, btn_color, btn_alpha);
	set_color(dlgServer.ok.mc, btn_color, btn_alpha);
	set_color(dlgServer.cancel.mc, btn_color, btn_alpha);
	set_color(dlgServer.bar, colorBar, 100);
	dlgServer.title_txt.textColor = text_color;
	dlgServer.ok.Caption.textColor = text_color;
	dlgServer.cancel.Caption.textColor = text_color;
	
	set_color(sign_up_new_mc.bar, colorBar, 100);
	sign_up_new_mc.title_txt.textColor = text_color;
	sign_up_new_mc.ok.Caption.textColor = text_color;
	sign_up_new_mc.cancel.Caption.textColor = text_color;
	set_color(sign_up_new_mc.opt_male.mc, btn_color, btn_alpha);
	//set_color(sign_up_new_mc.opt_male.chk, btn_color_selected, btn_alpha);
	set_color(sign_up_new_mc.opt_female.mc, btn_color, btn_alpha);
	//set_color(sign_up_new_mc.opt_female.chk, btn_color_selected, btn_alpha);
	set_color(sign_up_new_mc.drop_country.mc, btn_color, btn_alpha);
	set_color(sign_up_new_mc.ok.mc, btn_color, btn_alpha);
	set_color(sign_up_new_mc.cancel.mc, btn_color, btn_alpha);
	set_color(sign_up_new_mc.countries.next.mc, btn_color, btn_alpha);
	set_color(sign_up_new_mc.countries.previous.mc, btn_color, btn_alpha);
	for (var init = 0; init<sign_up_new_mc.countries.country_list.num_obj; init++) {
		set_color(eval("sign_up_new_mc.countries.country_list.list"+init+".mc"), btn_color, btn_alpha);
	}
	
	set_color(change_pass_mc.bar, colorBar, 100);
	change_pass_mc.title_txt.textColor = text_color;

	set_color(change_pass_mc.ok.mc, btn_color, btn_alpha);

	set_color(change_pass_mc.cancel.mc, btn_color, btn_alpha);
	
	set_color(sign_mc.bar, colorBar, 100);
	sign_mc.title_txt.textColor = text_color;
	set_color(sign_mc.chk_auto.mc, btn_color, btn_alpha);
	//set_color(sign_mc.chk_auto.chk_mc, btn_color_selected, btn_alpha);
	set_color(sign_mc.chk_rem.mc, btn_color, btn_alpha);

	//set_color(sign_mc.chk_rem.chk_mc, btn_color_selected, btn_alpha);
	set_color(sign_mc.chk_server.mc, btn_color, btn_alpha);
	set_color(sign_mc.sign_up.mc, btn_color, btn_alpha);
	set_color(sign_mc.ButtonKeyboard.mc,btn_color,btn_alpha);
	set_color(sign_up_new_mc.ButtonKeyboard.mc,btn_color,btn_alpha);
	set_color(change_pass_mc.ButtonKeyboard.mc,btn_color,btn_alpha);
	set_color(sign_mc.sign_in.mc, btn_color, btn_alpha);
	set_color(sign_mc.cancel.mc, btn_color, btn_alpha);
	set_color(sign_mc.change_pass.mc, btn_color, btn_alpha);
	
	sly_name_mc.ok.Caption.textColor = text_color;
	sly_name_mc.cancel.Caption.textColor = text_color;
	alert.ok.Caption.textColor = text_color;
	alert.cancel.Caption.textColor = text_color;
	input.ok.Caption.textColor = text_color;
	input.cancel.Caption.textColor = text_color;
	download.ok.Caption.textColor = text_color;
	download.cancel.Caption.textColor = text_color;
	edit.ok.Caption.textColor = text_color;
	edit.cancel.Caption.textColor = text_color;
    Signup_mc.submit_btn.Caption.textColor=text_color;
	Signup_mc.Cancel_btn.Caption.textColor=text_color;
	
	loginType.mode1.Caption.textColor = text_color;
	loginType.mode2.Caption.textColor = text_color;
	loginType.mode3.Caption.textColor = text_color;
	loginType.mode4.Caption.textColor = text_color;
	addNewPage.next.Caption.textColor = text_color;
	addNewPage.previous.Caption.textColor = text_color;
	
	set_color(addNewPage.title, btn_color_selected, 100);
	set_color(title, btn_color_selected, 100);
	//title.set_title_color(btn_color_selected);

	set_color(download.bar, colorBar, 100);
	download.title_txt.textColor = text_color;
	set_color(sly_name_mc.bar, colorBar, 100);
	sly_name_mc.title_txt.textColor = text_color;
	set_color(input.bar, colorBar, 100);
	input.title_txt.textColor = text_color;
	set_color(edit.bar, colorBar, 100);
	edit.title_txt.textColor = text_color;
	set_color(alert.bar, colorBar, 100);
	alert.title_txt.textColor = text_color;
	
	for (var init = 0; init<list_language.num_obj; init++) {
		set_color(eval("list_language.list"+init+".mc"), btn_color, btn_alpha);
	}
	for (var init = 0; init<addNewPage.client_list.num_obj; init++) {
		set_color(eval("addNewPage.client_list.list"+init+".mc"), btn_color, btn_alpha);
		set_color(eval("addNewPage.client_list.list"+init+".sel_mc"), btn_color_selected, btn_alpha_selected);
	}
	for (var init = 0; init<download.download_list.num_obj; init++) {
		set_color(eval("download.download_list.list"+init+".mc"), btn_color, btn_alpha);
		set_color(eval("download.download_list.list"+init+".chk"), btn_color_selected, btn_alpha);
	}
	playlist._visible = true;
	addLanguage._visible = true;
	exit._visible = true;
	switchMode._visible = true;

	for (var init = 0; init<permission.drop_list.num_obj; init++){
		set_color(eval("permission.drop_list.list" + init + ".mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk1_mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk2_mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk3_mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk4_mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk5_mc"), btn_color, btn_alpha);
		set_color(eval("permission.drop_list.list" + init + ".chk6_mc"), btn_color, btn_alpha);
	}
	set_color(eval("permission.ok.mc"), btn_color, btn_alpha);
	set_color(eval("permission.cancel.mc"), btn_color, btn_alpha);
	set_color(eval("permission.previous.mc"), btn_color, btn_alpha);
	set_color(eval("permission.next.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_displayAndPlayback.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_playbackOnly.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_independent.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_synVol.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_copySlideshow.mc"), btn_color, btn_alpha);
	set_color(eval("permission.chk_synSlideshow.mc"), btn_color, btn_alpha);
	
	set_color(search.bar, colorBar, 100);
	search.title_txt.textColor = text_color;
	set_color(search.ok.mc, btn_color, btn_alpha);
	set_color(search.cancel.mc, btn_color, btn_alpha);
	set_color(search.chk_login.mc, btn_color, btn_alpha);
	set_color(search.chk_real.mc, btn_color, btn_alpha);
	set_color(search.chk_email.mc, btn_color, btn_alpha);
	search.cancel.Caption.textColor = text_color;
	set_color(search.next.mc, btn_color, btn_alpha);
	set_color(search.previous.mc, btn_color, btn_alpha);
	for (var init = 0; init<search.server_list.num_obj; init++){
		set_color(eval("search.server_list.list" + init + ".mc"), btn_color, btn_alpha);
	}
	
	set_color(request_offline.bar, colorBar, 100);
	request_offline.title_txt.textColor = text_color;
	set_color(request_offline.ok.mc, btn_color, btn_alpha);
	set_color(request_offline.cancel.mc, btn_color, btn_alpha);
	set_color(request_offline.next.mc, btn_color, btn_alpha);
	set_color(request_offline.previous.mc, btn_color, btn_alpha);
	for (var init = 0; init<request_offline.offline_list.num_obj; init++){
		set_color(eval("request_offline.offline_list.list" + init + ".mc"), btn_color, btn_alpha);
		for (jinit=1; jinit<=6; jinit++){
			set_color(eval("request_offline.offline_list.list" + init + ".P" + jinit + ".mc"), btn_color, btn_alpha);
		}
	}
	
	set_color(access_pass.bar, colorBar, 100);
	access_pass.title_txt.textColor = text_color;
	set_color(access_pass.ok.mc, btn_color, btn_alpha);
	set_color(access_pass.cancel.mc, btn_color, btn_alpha);
	
	set_color(access.bar, colorBar, 100);
	access.title_txt.textColor = text_color;
	set_color(access.pass.mc, btn_color, btn_alpha);
	set_color(access.normal.mc, btn_color, btn_alpha);
	set_color(access.cancel.mc, btn_color, btn_alpha);
}
//----------------------------------------------------------------------------------------------------
function setSetting(val) {
	var _xml = new XML();
	_xml.load(val+"\\Setting.xml");
	_xml.onLoad = function() {
		fscommand("num_display",num_display);
		ColorBg1 = _xml.firstChild.childNodes[0].attributes.ColorBg;
		bg_color = ColorBg1;
		AlbumNum1 = _xml.firstChild.childNodes[0].attributes.AlbumNum;
		AlbumCover1 = _xml.firstChild.childNodes[0].attributes.AlbumCover;
		defaultDatabaseType=_xml.firstChild.childNodes[0].attributes.defaultDatabaseType;
		VisibleIconAlbum=_xml.firstChild.childNodes[0].attributes.VisibleIconAlbum;
		display_cover = (AlbumCover1 == "Yes");
		NumCover1 = _xml.firstChild.childNodes[0].attributes.NumCover;
		display_num = (NumCover1 == "Yes");
		SortedValue1 = _xml.firstChild.childNodes[0].attributes.SortedValue;
		AvaValue = _xml.firstChild.childNodes[0].attributes.AvaValue;
		ButtonColor1 = _xml.firstChild.childNodes[0].attributes.ButtonColor;
		btn_color = ButtonColor1;
		ButtonAlpha1 = _xml.firstChild.childNodes[0].attributes.ButtonAlpha;
		btn_alpha = ButtonAlpha1;
		colorBar = _xml.firstChild.childNodes[0].attributes.ColorBar;
		ColorRating = _xml.firstChild.childNodes[0].attributes.ColorRating;
		ChangeColorAndAlpha(ButtonColor1, ButtonAlpha1);
		SelectButton1 = _xml.firstChild.childNodes[0].attributes.SelectButton;
		btn_color_selected = SelectButton1;
		SelectButtonAlpha1 = _xml.firstChild.childNodes[0].attributes.SelectButtonAlpha;
		btn_alpha_selected = SelectButtonAlpha1;
		FontColor1 = _xml.firstChild.childNodes[0].attributes.FontColor;
		text_color = FontColor1;
		playChapterType=_xml.firstChild.childNodes[0].attributes.playchapterFile;
		Manually1 = _xml.firstChild.childNodes[0].attributes.Manually;
		AdvSearch1 = _xml.firstChild.childNodes[0].attributes.AdvSearch;
		Language1 = _xml.firstChild.childNodes[0].attributes.Language;
		PlayMode1 = _xml.firstChild.childNodes[0].attributes.PlayMode;
		PlayModeSearch1 = _xml.firstChild.childNodes[0].attributes.PlayModeSearch;
		PlayModePlayList1 = _xml.firstChild.childNodes[0].attributes.PlayModePlayList;
		ModeSearch1 = _xml.firstChild.childNodes[0].attributes.ModeSearch;
		MusicNoteValue = _xml.firstChild.childNodes[0].attributes.MusicNote;
		ScanComplete = _xml.firstChild.childNodes[0].attributes.ScanComplete;
		FirstLoad = _xml.firstChild.childNodes[0].attributes.FirstLoad;
		CountryLoad = _xml.firstChild.childNodes[0].attributes.CountryLoad;
		AlbumNumber = _xml.firstChild.childNodes[0].attributes.AlbumNumber;
		Rank = _xml.firstChild.childNodes[0].attributes.Rank;
		PlusCover = _xml.firstChild.childNodes[0].attributes.PlusCover;
		CDType = _xml.firstChild.childNodes[0].attributes.CDType;
		HideMouse = _xml.firstChild.childNodes[0].attributes.HideMouse;
		PlayListMode = _xml.firstChild.childNodes[0].attributes.PlayListMode;
		friend_playlist = _xml.firstChild.childNodes[0].attributes.share_playlist;
		has_internet = (String(_xml.firstChild.childNodes[0].attributes.NoInternet) == 0);
		online = _xml.firstChild.childNodes[0].attributes.online;
		ImagePath1 = _xml.firstChild.childNodes[1].attributes.ImagePath;
		SetSlideShow1 = _xml.firstChild.childNodes[1].attributes.SetSlideShow;
		syn = _xml.firstChild.childNodes[1].attributes.syn;
		resize = _xml.firstChild.childNodes[1].attributes.resize;
		rotate = _xml.firstChild.childNodes[1].attributes.rotate;
		Time1 = _xml.firstChild.childNodes[1].attributes.Time;
		Stretch1 = _xml.firstChild.childNodes[1].attributes.Stretch;
		ShowFile1 = _xml.firstChild.childNodes[1].attributes.ShowFileName;
		Effect1 = _xml.firstChild.childNodes[1].attributes.Effect;
		Scrolling1 = _xml.firstChild.childNodes[1].attributes.Scrolling;
		Delay1 = _xml.firstChild.childNodes[1].attributes.Delay;
		ImageSize1 = _xml.firstChild.childNodes[1].attributes.ImageSize;
		Vol1 = _xml.firstChild.childNodes[2].attributes.Vol;
		syn_vols = _xml.firstChild.childNodes[2].attributes.syn;
		Repeat1 = _xml.firstChild.childNodes[2].attributes.Repeat;
		Shuffle1 = _xml.firstChild.childNodes[2].attributes.Shuffle;
		TypeFull1 = _xml.firstChild.childNodes[2].attributes.TypeFull;
		TypeFull1 = "Visual";
		Tooltip1 = _xml.firstChild.childNodes[2].attributes.Tooltip;
		showTooltip = (Tooltip1 == "true");
		TextScroll = _xml.firstChild.childNodes[2].attributes.TextScroll;
		Micro = _xml.firstChild.childNodes[2].attributes.Micro;
		InitDir = _xml.firstChild.childNodes[2].attributes.InitDir;
		Adv = _xml.firstChild.childNodes[2].attributes.MicroScale;
		Ads = _xml.firstChild.childNodes[2].attributes.Ads;
		MicroScale = _xml.firstChild.childNodes[2].attributes.MicroScale;
		streamFile = (_xml.firstChild.childNodes[0].attributes.streamFile == "True");
		b_delete = (_xml.firstChild.childNodes[0].attributes.del == "true");
		enableSeek= _xml.firstChild.childNodes[0].attributes.EnableSeek;
		LastServerName= _xml.firstChild.childNodes[0].attributes.LastServerName;
		LastUserOnline= _xml.firstChild.childNodes[0].attributes.LastUserOnline;
		LinkingPlaylistPath = _xml.firstChild.childNodes[0].attributes.LinkingPlaylistPath;

		
		AutoClientConnection= _xml.firstChild.childNodes[0].attributes.AutoClientConnection;
		AutoConnect = _xml.firstChild.childNodes[0].attributes.AutoConnect;
		
		fscommand("color_popup",colorBar + "%%" + btn_color + "%%" + text_color + "%%" + btn_alpha + "%%" + btn_color_selected + "%%" + btn_color_selected);
		fscommand("default_per",_xml.firstChild.childNodes[0].attributes.default_per);
		fscommand("streamType",_xml.firstChild.childNodes[0].attributes.streamType);
		fscommand("deny_connect",_xml.firstChild.childNodes[0].attributes.deny);
		fscommand("permission",_xml.firstChild.childNodes[0].attributes.permission);
		fscommand("setDownloadAll",_xml.firstChild.childNodes[0].attributes.downloadAll);
		fscommand("priorityMplayer",_xml.firstChild.childNodes[0].attributes.priorityMplayer);
		fscommand("StringsubList",_xml.firstChild.childNodes[0].attributes.subList);
		fscommand("DVDControlType",_xml.firstChild.childNodes[0].attributes.DVDControlType);
		fscommand("ShowPopupinfo",_xml.firstChild.childNodes[0].attributes.ShowPopupinfo);
		fscommand("setReencode",_xml.firstChild.childNodes[0].attributes.reencode);
		fscommand("SlideShowMode",_xml.firstChild.childNodes[1].attributes.SlideShowMode);
		fscommand("playchapterFile",playChapterType);
		fscommand("internal_slide_path",ImagePath1);
		fscommand("streamFile",streamFile);
		fscommand("EnableSeek",enableSeek);
		fscommand("Lame_Path", _xml.firstChild.childNodes[0].attributes.LamePath);
		fscommand("FLAC_Path", _xml.firstChild.childNodes[0].attributes.FLACPath);
		fscommand("APE_Path", _xml.firstChild.childNodes[0].attributes.APEPath);
		fscommand("priorityExtension", _xml.firstChild.childNodes[0].attributes.priorityExtension);
		fscommand("trackType", _xml.firstChild.childNodes[0].attributes.trackType);
		fscommand("scanAlbumPath", _xml.firstChild.childNodes[0].attributes.scanAlbumPath);
		fscommand("ripWith", _xml.firstChild.childNodes[2].attributes.ripWith);
		fscommand("playWith", _xml.firstChild.childNodes[2].attributes.playWith);
		fscommand("microStyle", _xml.firstChild.childNodes[2].attributes.microStyle);
		fscommand("browse_folder_music", _xml.firstChild.childNodes[2].attributes.browse_folder);
		fscommand("monitor", _xml.firstChild.childNodes[0].attributes.monitor);
		fscommand("browse_slideshow", _xml.firstChild.childNodes[0].attributes.browse_slideshow);
		fscommand("browse_new_playlist_folder", _xml.firstChild.childNodes[0].attributes.browse_new_playlist_folder);
		fscommand("browse_slideshow_album", _xml.firstChild.childNodes[0].attributes.browse_slideshow_album);
		fscommand("browse_slideshow_playlist", _xml.firstChild.childNodes[0].attributes.browse_slideshow_playlist);
		fscommand("browse_import_playlist", _xml.firstChild.childNodes[0].attributes.browse_import_playlist);
		fscommand("resize_image", _xml.firstChild.childNodes[0].attributes.resizeImage);
		fscommand("microLocation", _xml.firstChild.childNodes[2].attributes.microLocation);
		fscommand("popupLocation", _xml.firstChild.childNodes[2].attributes.trackLocation);
		fscommand("allow_slideshow", _xml.firstChild.childNodes[1].attributes.allow_slideshow);
		fscommand("clone_display", _xml.firstChild.childNodes[0].attributes.clone_display);
		fscommand("clone_playback", _xml.firstChild.childNodes[0].attributes.clone_playback);
		fscommand("independent", _xml.firstChild.childNodes[0].attributes.independent);
		fscommand("localLink", _xml.firstChild.childNodes[0].attributes.local_link);
		fscommand("Remotecontrol", _xml.firstChild.childNodes[0].attributes.remotecontrol);
		fscommand("ChangeTrackTitleStyle", _xml.firstChild.childNodes[0].attributes.ShowUnderTrackTitle);
		fscommand("AutoClientConnection", AutoClientConnection);
		fscommand("InitDir", InitDir);
		fscommand("KaraokeVoice", _xml.firstChild.childNodes[2].attributes.karaoke_voice);
		fscommand("syn",syn);		
		fscommand("resize_image_server",resize);		
		fscommand("rotate",rotate);
		fscommand("syn_vol",syn_vols);
		fscommand("friend_playlist",friend_playlist);
		fscommand("popup_exit",_xml.firstChild.childNodes[0].attributes.popup_exit);
		fscommand("syn_vol_change",_xml.firstChild.childNodes[2].attributes.syn_vol_change);
		fscommand("VisibleIconAlbum",VisibleIconAlbum);
		fscommand("LinkingPlaylistPath",LinkingPlaylistPath);
		syn_volume = syn_vols;
		var SplitSt = ColorBg1+"~"+AlbumNum1+"~"+AlbumCover1+"~"+NumCover1+"~"+SortedValue1+"~"+AvaValue+"~"+ButtonColor1+"~"+ButtonAlpha1+"~"+SelectButton1+"~"+SelectButtonAlpha1+"~"+FontColor1+"~"+Manually1+"~"+AdvSearch1+"~"+Language1+"~"+PlayMode1+"~"+PlayModeSearch1+"~"+PlayModePlayList1+"~"+ModeSearch1+"~"+AlbumNumber+"~"+Rank+"~"+PlusCover+"~"+CDType+"~"+PlayListMode+"~"+colorBar+"~"+MusicNoteValue+"~"+ScanComplete+"~"+ColorRating+"~"+HideMouse;
		var SplitSt1 = ImagePath1+"~"+SetSlideShow1+"~"+Time1+"~"+Stretch1+"~"+ShowFile1+"~"+Effect1+"~"+Scrolling1+"~"+Delay1+"~"+ImageSize1;
		var SplitSt2 = Vol1+"~"+Repeat1+"~"+Shuffle1+"~"+TypeFull1+"~"+Tooltip1+"~"+TextScroll+"~"+Micro+"~"+Ads+"~"+MicroScale;
		fscommand("SplitSt", SplitSt+"&&"+SplitSt1+"&&"+SplitSt2);
		fscommand("ChangeLan", Language1);
		changeColorObj();
//		openLanguage = appPath;
		//EDID:2005.10.29 (1 Movie,2 TVSeries,4 Music,8 Karaoke)		
		if(defaultDatabaseType==8){
			ButtonKaraoke.onRelease();
		}else if(defaultDatabaseType==4){
			ButtonMusic.onRelease();
		}else if(defaultDatabaseType==2){
			ButtonTv.onRelease();
		}else if(defaultDatabaseType==16){
			ButtonCD.onRelease ();
		}else{
			ButtonMovie.onRelease();
		}
		var dd = new Color(CountryLetter);
		dd.setRGB(SelectButton1);
		var dd = new Color(bgMenu);
		dd.setRGB(colorBar);
		bgMenu._visible = true;
		// Hide Mouse
		if (HideMouse == "true") {
			Mouse.hide();
		} else {
			Mouse.show();
		}
		TrackShow.setTrackDisplayTheme(FontColor1, colorBar);
		
		auto_update_db = (_xml.firstChild.childNodes[0].attributes.auto_new_database == "true");
		fscommand("auto_new_database",auto_update_db);
		
	};
}
function getSetting() {
}
_root.addProperty("openSetting", getSetting, setSetting);
//----------------------------------------------------------------------------------------------------
function list_previous(obj) {	
	displayList(obj, obj.stored_index-obj.num_obj);
}
//----------------------------------------------------------------------------------------------------
function list_next(obj) {
	displayList(obj, obj.stored_index+obj.num_obj);
}
//----------------------------------------------------------------------------------------------------
function languages(Path, imagePath, Default, Name, pass, nickName, userOnline) {
	this.Path = Path;
	this.imagePath = imagePath;
	this.Default = Default;
	this.Name = Name;
	this.pass = pass;	// server password
	this.nickName = nickName;
	this.userOnline = userOnline;
}
//----------------------------------------------------------------------------------------------------
var loadLanguagePath;
function setLanguage(val) {
	//App_Check=false;
	var _xml = new XML();
	_xml.load(val+"\\Countries.xml");
	_xml.onLoad = function(success) {
		loadLanguagePath=val;
		if (success) {			
			restore_connecting_icon();
			workingPage = "country";
			title.set_title(workingPage);
			list_language.count = 0;
			list_language.list_array.length = 0;
			addNewPage.client_list.count = 0;
			addNewPage.client_list.list_array.length = 0;
			str_allLanguageNames = "";
			str_allLanguagePaths = "";
			allCountry="";
			allPath="";
			
			application._visible = true;
			languagePage._visible = false;
			login._visible = (int(getStatus())==0); //not connected
			languagePage._x = login._x;
			show_icon();
			var l = new Array();
			l = _xml.firstChild.childNodes;
			main_path_download = getPathToDownloadNewLanguage(l[0].attributes.Path);
			if (l.length>0) {
				
				set_key_press(application, exit, playlist, application, ButtonMovie);
				set_key_press(playlist, application, login, playlist, ButtonMovie);
				set_key_press(login, playlist, switchMode, login, ButtonMovie);
				set_key_press(switchMode, login, addLanguage, switchMode, ButtonMovie);
				set_key_press(addLanguage, switchMode, exit, addLanguage, ButtonMovie);
//				set_key_press(exit, addLanguage, application, exit, list_language.list0);
				set_key_press(exit, addLanguage, application, exit, application);
				list_language._visible = true;
				for (var init = 0; init<l.length; init++) {
					var path1 = _xml.childNodes[0].childNodes[init].attributes.Path;
					var imgpath1 = _xml.childNodes[0].childNodes[init].attributes.imagePath;
					var default1 = _xml.childNodes[0].childNodes[init].attributes.Default;
					var name1 = _xml.childNodes[0].childNodes[init].attributes.Name;
					var LanguageID = _xml.childNodes[0].childNodes[init].childNodes[0].nodeValue;					    
					var dbType = _xml.childNodes[0].childNodes[init].attributes.DatabaseType;
					var list_add=new languages(path1, imgpath1, default1, name1, "", "", "");
					list_add.LanguageID=LanguageID;
					list_add.DatabaseType=dbType;
					//EDID:2006.05.15============================
					if(dbType==DatabaseType){  //filter out to get only that database that is require to display
						if (showAddPage == false) {
							list_language.list_array.push( list_add);
						} else {
							if (name1 == "English") {
								main_path_download = getPathToDownloadNewLanguage(path1);
							}
							addNewPage.client_list.list_array.push(list_add);
						}
					}
					//===============EDID:2006.05.15=============
					if (str_allLanguageNames == ""){
						str_allLanguageNames = name1;
						str_languageNames = name1;
					}else{
						str_allLanguageNames = str_allLanguageNames + " " + name1;
						str_languageNames = str_languageNames + "~" + name1;
					}
					if (str_allLanguagePaths == ""){
						str_allLanguagePaths = path1;
					}else{
						str_allLanguagePaths = str_allLanguagePaths + "|" + path1;
					}
					//EDID 2005.11.01
					allCountry = allCountry+"%%"+path1+"%"+LanguageID+"%"+imgpath1+"%"+dbType;
					allPath = allPath+";"+path1;
				}
				
				if (showAddPage == true) {
					addNewPage.client_list._visible = true;
					addNewPage.client_list.count = addNewPage.client_list.list_array.length;
					addNewPage.client_img._visible = true;
					addNewPage.client_img.img.load_image(addNewPage.client_list.list_array[0].imagePath);
					displayList(addNewPage.client_list, addNewPage.client_list.stored_index);
					set_key_press(addNewPage.Back, "", "", "", addNewPage.client_list.list0);
					set_key_press(addNewPage.client_img, addNewPage.client_list.list0, "", addNewPage.Back, addNewPage.new_language);
					set_key_press(addNewPage.new_language, addNewPage.client_list.list0, addNewPage.download_language, addNewPage.client_img, "");
					set_key_press(addNewPage.download_language, addNewPage.new_language, addNewPage.edit_language, addNewPage.client_img, "");
					set_key_press(addNewPage.edit_language, addNewPage.download_language, addNewPage.deleted, addNewPage.client_img, "");
					set_key_press(addNewPage.deleted, addNewPage.edit_language, addNewPage.move_up, addNewPage.client_img, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.client_img, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_language, addNewPage.client_img, "");
					if ((str_allLanguageNames != "") and (str_allLanguagePaths != "")) {
						fscommand("setRegister", str_allLanguageNames+"|~|"+str_allLanguagePaths);
					}
					if (click_event == "" ){
						addNewPage.Back.btn.onRollOver();
					}
					enableMouse._visible = false;
					return;
				}else{	
					if(App_Check==true){
						application.btn.onRollOver();
					}
				}
				
				set_key_press(next, ButtonCD, application, exit, list_language.list0);
				set_key_press(ButtonCD, ButtonMusic, Next, exit, list_language.list0);
				set_key_press( ButtonMusic, ButtonKaraoke,ButtonCD, exit, list_language.list0);
				set_key_press(ButtonMovie, previous, ButtonTV, addLanguage, list_language.list0);
				set_key_press(ButtonTV, ButtonMovie, ButtonKaraoke, addLanguage, list_language.list0);
				set_key_press(ButtonKaraoke, ButtonTV, ButtonMusic, addLanguage, list_language.list0);
//				set_key_press(ButtonMusic, ButtonKaraoke, next, addLanguage, list_language.list0);
				
				
				set_key_press(next, ButtonMCD, previous, addLanguage, list_language.list0);
				set_key_press(previous, next, ButtonCD, playlist, list_language.list0);
				
				fscommand("MainPathImage", list_language.list_array[0].imagePath);
//				fscommand("allCountry", allCountry);
//				fscommand("AllPathCountry", allPath);
				fscommand("LoadPlayMusicPlayer","");
				fscommand("DefaultFirst", _xml.childNodes[0].childNodes[0].childNodes[0].nodeValue);
				list_language.count = list_language.list_array.length;
				if (ReLoad == "true") {
					if (start_defautl_load){
						Bg._visible = true;
						recall_langauge = true;
						auto_display_sign_in();						
						return;
					} else {
						recall_langauge = false;
						if (FirstLoad == "Country") {
							var PathCountry1 = "";
							for (var j = 0; j<list_language.list_array.length; j++) {
								allCountry = allCountry+"%%"+list_language.list_array[j].Path+"%"+list_language.list_array[j].LanguageID +"%"+list_language.list_array[j].DatabaseType;
								allPath = allPath+";"+list_language.list_array[j].Path;
								if (CountryLoad == list_language.list_array[j].LanguageID) {
									databaseType=list_language.list_array[j].databaseType;
									fscommand("MainPathImage", list_language.list_array[j].imagePath);
									PathCountry1 = list_language.list_array[j].Path;
								}
							}
							allPath = allPath.substr(1);
							fscommand("LoadCountry", CountryLoad);
						} else if (FirstLoad == "Playlist") {
							playlist.btn.onRelease();
						} else if (FirstLoad == "Login"){
							login.btn.onRelease();
						} else if (FirstLoad == "Search") {
							fscommand("Load", "Search");
						} else if (FirstLoad == "Player") {
							fscommand("showPlaylistPlayer", 1);
						} else if (FirstLoad == "FullScreen") {
							fscommand("FullScreenPlayer", true);
							displayList(list_language, list_language.stored_index);
							Bg._visible = true;
						} else if (FirstLoad == "Micro") {
							fscommand("mini","Minimize|:|false");
							displayList(list_language, list_language.stored_index);
							Bg._visible = true;
//						} else if (FirstLoad == "AutoClientConnect") {
//							if(AutoClientConnection>0 and LastServerName!="" ){
//								fscommand("requestAutoConnect",LastServerName + "|~|" + LastUserOnline  + "|~|" + _root.login_name);
//							}
//							Bg._visible = true;
//							recall_langauge = true;
//							auto_display_sign_in();
						} else {
							displayList(list_language, list_language.stored_index);
							Bg._visible = true;
						}
						if(AutoConnect=="true"){
							if(AutoClientConnection>0 and LastServerName!="" ){
								fscommand("requestAutoConnect",LastServerName + "|~|" + LastUserOnline  + "|~|" + _root.login_name);
							}
							Bg._visible = true;
							recall_langauge = true;
							auto_display_sign_in();


						}
					}
				} else {
					displayList(list_language, list_language.stored_index);
					Bg._visible = true;
				}
				ReLoad = false;
				
				if (start_refresh == true){
					fscommand("refreshLikeServer",OpenList);
					start_refresh = false;
				}
								
				fscommand("check_language_for_auto_update",str_languageNames);
				
				if (b_delete){
					fscommand("delete_myAlbum",true);
				}else{
					fscommand("delete_myAlbum",false);
				}
				
			} else {
				
				set_key_press(application, exit, playlist, application, application);
				set_key_press(playlist, application, login, playlist, playlist);
				set_key_press(login, playlist, switchMode, login, login);
				set_key_press(switchMode, login, addLanguage, switchMode, switchMode);
				set_key_press(addLanguage, switchMode, exit, addLanguage, addLanguage);
				set_key_press(exit, addLanguage, application, exit, exit);
				
				addNewPage.client_list._visible = false;
				list_language._visible = false;
				next._visible = false;
				previous._visible = false;
				fscommand("DefaultFirst", "||");
				fscommand("allCountry");
				fscommand("AllPathCountry");
				Bg._visible = true;
				if (addNewPage._visible == true){
					addNewPage.client_img._visible = false;
					addNewPage.Back.btn.onRollOver();					
					set_key_press(addNewPage.Back, "", "", "", addNewPage.new_language);					
					set_key_press(addNewPage.new_language, addNewPage.move_down, addNewPage.download_language, addNewPage.Back, "");
					set_key_press(addNewPage.download_language, addNewPage.new_language, addNewPage.edit_language, addNewPage.Back, "");
					set_key_press(addNewPage.edit_language, addNewPage.download_language, addNewPage.deleted, addNewPage.Back, "");
					set_key_press(addNewPage.deleted, addNewPage.edit_language, addNewPage.move_up, addNewPage.Back, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.Back, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_language, addNewPage.Back, "");
				}else{
					application.btn.onRollOver();
				}
			}
			// call it after user logon server
			if (startLogon == true){
				var tvSplit = new Array();				
				tvSplit = String(server_display).split("%%%");				
				switch (tvSplit[0]){						
					case "Search":
						fscommand("server_display","TopBar.ButtonS");
						break;
					case "Player":
						fscommand("server_display","TopBar.ButtonPlayer");
						break;
					case "Option":
						fscommand("server_display","TopBar.ButtonO");
						break;
					case "Playlist":
						fscommand("server_display","TopBar.ButtonP");
						break;
				}
				
				if (tvSplit.length <= 3){		

					if (tvSplit[1] == "Micro"){
						fscommand("server_display_micro",true);
					}else if (tvSplit[1] == "Fullscreen"){
						fscommand("server_display_fullscreen",true);
						if (tvSplit.length == 3){
							fscommand("server_display_micro",true);
						}
					}
				}
				startLogon = false;
			} else {
				fscommand("get_sly_name","get");
			}
			enableMouse._visible = false;
		}
	};
}
function getLanguage() {
	return loadLanguagePath;
}
_root.addProperty("openLanguage", getLanguage, setLanguage);
//----------------------------------------------------------------------------------------------------
function setServer(val) {
	var _xml = new XML();
	_xml.load(val+"\\Server.xml");
	_xml.onLoad = function(success) {
		if (success) {
			
			login_name = "";
			user_sign_in_index = "";
			selected_server_id = "";
			store_user_login_name = undefined;
			store_user_login_pass = undefined;
			online_id = "";
			
			restore_connecting_icon();
			workingPage = "server";
			title.set_title(workingPage);
			list_language.count = 0;
			list_language.list_array.length = 0;
			addNewPage.client_list.count = 0;
			addNewPage.client_list.list_array.length = 0;
			application._visible = true;
			languagePage._visible = true;
			languagePage._x = login._x;
			login._visible = false;
			show_icon();
			var l = new Array();
			l = _xml.firstChild.childNodes;
			if (l.length>0) {				
				set_key_press(application, exit, playlist, application, list_language.list0);
				set_key_press(playlist, application, languagePage, playlist, list_language.list0);
				set_key_press(languagePage, playlist, switchMode, languagePage, list_language.list0);
				set_key_press(switchMode, languagePage, addLanguage, switchMode, list_language.list0);
				set_key_press(AddLanguage, switchMode, exit, addLanguage, list_language.list0);
				set_key_press(exit, addLanguage, application, exit, list_language.list0);
				
				list_language._visible = true;
				for (var init = 0; init<l.length; init++) {
					var path1 = _xml.childNodes[0].childNodes[init].attributes.Path;
					var imgpath1 = _xml.childNodes[0].childNodes[init].attributes.imagePath;
					var default1 = _xml.childNodes[0].childNodes[init].attributes.Default;
					//var pass1 = _xml.childNodes[0].childNodes[init].attributes.Password;					
					var pass1 = "";
					var nick_name1 = _xml.childNodes[0].childNodes[init].attributes.nick_name;
					var name1 = _xml.childNodes[0].childNodes[init].childNodes[0].nodeValue;					
					if (showAddPage == false) {
						list_language.list_array[init] = new languages(path1, imgpath1, default1, name1, pass1, nick_name1, "");
					} else {
						addNewPage.client_list.list_array[init] = new languages(path1, imgpath1, default1, name1, pass1, nick_name1, "");
					}
				}
				if (showAddPage == false) {
					list_language.count = list_language.list_array.length;
					set_key_press(next, previous, previous, addLanguage, list_language.list0);
					set_key_press(previous, next, next, playlist, list_language.list0);
					displayList(list_language, 0);
					application.btn.onRollOver();
				} else {
					addNewPage.client_list._visible = true;
					addNewPage.client_list.count = addNewPage.client_list.list_array.length;
					addNewPage.client_img._visible = true;
					addNewPage.client_img.img.load_image(addNewPage.client_list.list_array[0].imagePath);
					displayList(addNewPage.client_list, addNewPage.client_list.stored_index);
					set_key_press(addNewPage.Back, "", "", "", addNewPage.client_list.list0);
					set_key_press(addNewPage.client_img, addNewPage.client_list.list0, "",addNewPage.Back, addNewPage.new_server);
					set_key_press(addNewPage.new_server, addNewPage.client_list.list0, addNewPage.scan_server, addNewPage.client_img, "");
					set_key_press(addNewPage.scan_server, addNewPage.new_server, addNewPage.deleted, addNewPage.client_img, "");
					set_key_press(addNewPage.deleted, addNewPage.scan_server, addNewPage.move_up, addNewPage.client_img, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.client_img, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_server, addNewPage.client_img, "");
					if (click_event == "" ){
						addNewPage.Back.btn.onRollOver();
					}
				}
			} else {
				
				set_key_press(application, exit, playlist, application, application);
				set_key_press(playlist, application, languagePage, playlist, playlist);
				set_key_press(languagePage, playlist, switchMode, languagePage, languagePage);
				set_key_press(switchMode, languagePage, addLanguage, switchMode, switchMode);
				set_key_press(AddLanguage, switchMode, exit, addLanguage, AddLanguage);
				set_key_press(exit, addLanguage, application, exit, exit);
				
				addNewPage.client_list._visible = false;
				list_language._visible = false;
				next._visible = false;
				previous._visible = false;
				if (addNewPage._visible == true){
					addNewPage.client_img._visible = false;
					addNewPage.Back.btn.onRollOver();
					set_key_press(addNewPage.Back, "", "", "", addNewPage.new_server);
					set_key_press(addNewPage.new_server, addNewPage.move_down, addNewPage.deleted, addNewPage.Back, "");
					set_key_press(addNewPage.deleted, addNewPage.new_server, addNewPage.move_up, addNewPage.Back, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.Back, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_server, addNewPage.Back, "");
				}else{
					application.btn.onRollOver();
				}
			}
			enableMouse._visible = false;
		}
	};
}
function getServer() {
}
_root.addProperty("openServer", getServer, setServer);
//----------------------------------------------------------------------------------------------------
function setApplication(val) {
	var _xml = new XML();
	_xml.load(val+"\\Applications.xml");
	_xml.onLoad = function(success) {
		if (success) {
			
			restore_connecting_icon();
			workingPage = "application";
			title.set_title(workingPage);
			list_language.count = 0;
			list_language.list_array.length = 0;
			addNewPage.client_list.count = 0;
			addNewPage.client_list.list_array.length = 0;
			application._visible = false;
			languagePage._x = application._x;
			languagePage._visible = true;
			login._visible = true;
			var l = new Array();
			l = _xml.firstChild.childNodes;
			if (l.length>0) {
				
				set_key_press(languagePage, exit, playlist, languagePage, list_language.list0);
				set_key_press(playlist, languagePage, login, playlist, list_language.list0);
				set_key_press(login, playlist, switchMode, login, list_language.list0);
				set_key_press(switchMode, login, addLanguage, switchMode, list_language.list0);
				set_key_press(addLanguage, switchMode, exit, addLanguage, list_language.list0);
				set_key_press(exit, addLanguage, languagePage, exit, list_language.list0);
				
				list_language._visible = true;
				for (var init = 0; init<l.length; init++) {
					var path1 = _xml.childNodes[0].childNodes[init].attributes.Path;
					var imgpath1 = _xml.childNodes[0].childNodes[init].attributes.imagePath;
					var default1 = _xml.childNodes[0].childNodes[init].attributes.Default;
					var name1 = _xml.childNodes[0].childNodes[init].childNodes[0].nodeValue;					
					if (showAddPage == false) {
						list_language.list_array[init] = new languages(path1, imgpath1, default1, name1, "", "", "");
					} else {
						addNewPage.client_list.list_array[init] = new languages(path1, imgpath1, default1, name1, "", "", "");
					}
				}
				
				if (showAddPage == false) {
					list_language.count = list_language.list_array.length;
					set_key_press(next, previous, previous, addLanguage, list_language.list0);
					set_key_press(previous, next, next, playlist, list_language.list0);
					displayList(list_language, 0);
					languagePage.onRollOver();
				} else {
					addNewPage.client_list._visible = true;
					addNewPage.client_list.count = addNewPage.client_list.list_array.length;
					addNewPage.client_img._visible = true;
					addNewPage.client_img.img.load_image(addNewPage.client_list.list_array[0].imagePath);
					displayList(addNewPage.client_list, addNewPage.client_list.stored_index);
					set_key_press(addNewPage.Back, "", "", "", addNewPage.client_list.list0);
					set_key_press(addNewPage.client_img, addNewPage.client_list.list0, "", addNewPage.Back, addNewPage.new_application);
					set_key_press(addNewPage.new_application, addNewPage.client_list.list0, addNewPage.edit_application, addNewPage.client_img, "");
					set_key_press(addNewPage.edit_application, addNewPage.new_application, addNewPage.deleted, addNewPage.client_img, "");
					set_key_press(addNewPage.deleted, addNewPage.edit_application, addNewPage.move_up, addNewPage.client_img, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.client_img, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_application, addNewPage.client_img, "");
					if (click_event == "" ){
						addNewPage.Back.btn.onRollOver();
					}
				}
			} else {
				
				set_key_press(languagePage, exit, playlist, languagePage, languagePage);
				set_key_press(playlist, languagePage, login, playlist, playlist);
				set_key_press(login, playlist, switchMode, login, login);
				set_key_press(switchMode, login, addLanguage, switchMode, switchMode);
				set_key_press(addLanguage, switchMode, exit, addLanguage, addLanguage);
				set_key_press(exit, addLanguage, languagePage, exit, exit);
				
				addNewPage.client_list._visible = false;
				list_language._visible = false;
				next._visible = false;
				previous._visible = false;
				if (addNewPage._visible == true){
					addNewPage.client_img._visible = false;
					addNewPage.Back.btn.onRollOver();
					set_key_press(addNewPage.Back, "", "", "", addNewPage.new_application);
					set_key_press(addNewPage.new_application, addNewPage.move_down, addNewPage.edit_application, addNewPage.Back, "");
					set_key_press(addNewPage.edit_application, addNewPage.new_application, addNewPage.deleted, addNewPage.Back, "");
					set_key_press(addNewPage.deleted, addNewPage.edit_application, addNewPage.move_up, addNewPage.Back, "");
					set_key_press(addNewPage.move_up, addNewPage.deleted, addNewPage.move_down, addNewPage.Back, "");
					set_key_press(addNewPage.move_down, addNewPage.move_up, addNewPage.new_application, addNewPage.Back, "");
				}else{
					languagePage.btn.onRollOver();
				}
			}
			enableMouse._visible = false;
		}
	};
}
function getApplication() {
}
_root.addProperty("openApplication", getApplication, setApplication);
//----------------------------------------------------------------------------------------------------
function displayList(obj, startIndex) {
	var tmpInd = 0;
	if (obj.num_obj<obj.count) {
		obj._parent.next._visible = true;
		obj._parent.previous._visible = true;
	} else {
		obj._parent.next._visible = false;
		obj._parent.previous._visible = false;
	}

	if (startIndex<0) {
		startIndex = obj.count-((obj.count)%obj.num_obj);
		if (startIndex == obj.count) {
			startIndex = obj.count-obj.num_obj;
		}
	} else if ((startIndex>=obj.count) or (startIndex == 0)) {
		startIndex = 0;
	}
	
	for (var init = startIndex; init<startIndex+obj.num_obj; init++) {
		var currentobj = eval(obj+".list"+tmpInd);
		currentobj.Index = init;
		currentobj.objIndex = tmpInd;
		if (init<obj.count) {
			currentobj.Caption.textColor = text_color;
			currentobj._visible = true;
			obj.showObject(currentobj, init);
		} else {
			currentobj._visible = false;
		}
		tmpInd++;
	}
	obj.stored_index = startIndex;	
	fscommand("store_list_index",obj.stored_index);
}
function set_key_press(obj, l, r, u, d) {
	obj.right = r;
	obj.left = l;
	obj.up = u;
	obj.down = d;
}
//----------------------------------------------------------------------------------------------------
function press_key_number() {
	clearInterval(ID_press_key_number);
	key_num -= 1;
	if (key_num<list_language.count) {
		list_language.list_Release(key_num,workingPage,list_language.list_array[key_num].Name);
	}
	key_num = "";
}
//----------------------------------------------------------------------------------------------------
function add_new_page(val_work) {
	if (send_event("normal&&&function||add_new_page|~|" + val_work + "||1",false)){
		return;
	}
	workingPage = val_work;
	showAddPage = true;
	//	addPageButtons
	//addPageApplication

	//=====================================
	switch(workingPage){
		case "server":
			openServer = appPath;
			pageObject=addPageServer;
			break;
		case "country":
			openLanguage=appPath;
			pageObject=addPageCountry;
			break;
		case "application":
			openApplication=appPath;
			pageObject=addPageApplication;
			break;
	}

	for(var i=0;i<addPageButtons.length;i++){
		iObject=addPageButtons[i];
		if(pageObject[i]==null){
			iObject._visible=false;
		}else{
			iObject._visible=true;
			iObject._x=pageObject[i];
		}
	}
	addNewPage._visible = true;
	addNewPage.title.set_title(workingPage);
	//=====================================
	/*			comment out by KIMSENG 20150504 for adding scanning server
	if (workingPage == "server") {
		fscommand("mb","Working page="+ workingPage)
		openServer = appPath;
		addNewPage.new_application._visible = false;
		addNewPage.edit_application._visible = false;
		addNewPage.new_language._visible = false;
		addNewPage.download_language._visible = false;
		addNewPage.edit_language._visible = false;

		addNewPage.new_server._x = 606.5;
		addNewPage.new_server._visible = true;
		addNewPage.deleted._x = 704.8;
		addNewPage.deleted._visible = true;
		addNewPage.move_up._x = 803.1;
		addNewPage.move_up._visible = true;
		addNewPage.move_down._x = 901.4;
		addNewPage.move_down._visible = true;
		addNewPage._visible = true;
	} else if (workingPage == "country") {
		//fscommand("Load", "AddCountry");
		openLanguage = appPath;
		addNewPage.new_application._visible = false;
		addNewPage.edit_application._visible = false;
		addNewPage.new_server._visible = false;
		addNewPage.new_language._x = 571.5;
		addNewPage.new_language._visible = true;
		addNewPage.download_language._x = 644.5;
		addNewPage.download_language._visible = true;
		addNewPage.edit_language._x = 717.5;
		addNewPage.edit_language._visible = true;
		addNewPage.deleted._x = 790.5;
		addNewPage.deleted._visible = true;
		addNewPage.move_up._x = 863.5;
		addNewPage.move_up._visible = true;
		addNewPage.move_down._x = 936.5;
		addNewPage.move_down._visible = true;
		addNewPage._visible = true;		
	} else if (workingPage == "application") {
		openApplication = appPath;
		addNewPage.new_server._visible = false;
		addNewPage.new_language._visible = false;
		addNewPage.download_language._visible = false;
		addNewPage.edit_language._visible = false;
		addNewPage.new_application._x = 571.5;
		addNewPage.new_application._visible = true;
		addNewPage.edit_application._x = 662.8;
		addNewPage.edit_application._visible = true;
		addNewPage.deleted._x = 754;
		addNewPage.deleted._visible = true;
		addNewPage.move_up._x = 845.3;
		addNewPage.move_up._visible = true;
		addNewPage.move_down._x = 936.5;
		addNewPage.move_down._visible = true;
		addNewPage._visible = true;
	}
	addNewPage.title.set_title(workingPage);
	*/
}
//----------------------------------------------------------------------------------------------------
function key_press(key_code) {
	key_code = int(key_code);
	var obj = selectedObject._parent;
	var n = int(key_code);
	if (Selection.getFocus()== null){
		if ((n == 82) || (n == 83) || (n == 88) || (n == 67) || (n == 86) || (n == 66) || (n == 90)) {//(n == 33) || (n == 34) ||
//			control_mini_player("Key",n,"true"); //test
			return;
		} else if (n == 187 || n == 189) {
//			control_syncronize("volume", "Key", n);
		}
	}
	switch (key_code) {
	case key_clickPrevious :
		previous.btn.onRelease();
		break;
	case key_clickNext :
		next.btn.onRelease();
		break;
	case key_leftArrow :
		fscommand("offScreen", true);
		if (Selection.getFocus()== null){
			if (obj.list == true) {
				if ((obj._parent.col>1) && (obj._parent.row>1)) {
					var objIndex = obj.objIndex-1;
					if (eval(obj._parent+".list"+objIndex)._visible == true) {
						eval(obj._parent+".list"+objIndex+".btn").onRollOver();
					} else {
						if (next._visible) {
							previous.btn.onRelease();
						}
						eval(obj._parent+".list"+0+".btn").onRollOver();
					}
				} else if ((obj._parent.col == 1) && (obj._parent.row>1)) {
					if (enableMouse._visible == false){
						
					}else if (download._visible == true){
						download.next.btn.onRollOver();
					}

				}
			} else {
				if(obj.left._visible==false){obj=obj.left;};//skip first invisible button
				obj.left.btn.onRollOver();
			}
		}
		break;
	case key_upArrow :
		fscommand("offScreen", true);
		if (Selection.getFocus()== null){
			if (obj.list == true) {
				if ((obj._parent.col>1) && (obj._parent.row>1)) {
					var objIndex = obj.objIndex-obj._parent.col;				
					if (objIndex<0) {
						if (next._visible) {
							obj._parent._parent.previous.btn.onRollOver();
						} else {
							obj._parent._parent.playlist.btn.onRollOver();
						}
						return;
					}
				} else if ((obj._parent.col == 1) && (obj._parent.row>1)) {
					var objIndex = obj.objIndex-1;
					if(download._visible == false){
						if (objIndex < 0){
							obj._parent._parent.Back.btn.onRollOver();
							return;
						}
					}else if(download._visible == true){
						if (objIndex < 0){
							obj._parent._parent.previous.btn.onRollOver();

							return;
						}
					}
				}
				if (eval(obj._parent+".list"+objIndex)._visible == true) {
					eval(obj._parent+".list"+objIndex+".btn").onRollOver();
				}
			} else {
				obj.up.btn.onRollOver();
			}
		}else{
			fscommand("mb","Key up");
			Selection.setFocus(null);	

			eval(Selection.getFocus())._parent.ok.btn.onRollOver();
		}
		break;
	case key_rightArrow :
		fscommand("offScreen", true);
		if (Selection.getFocus()== null){
			if (obj.list == true) {
				if ((obj._parent.col>1) && (obj._parent.row>1)) {
					var objIndex = int(obj.objIndex+1);
					if (eval(obj._parent+".list"+objIndex)._visible == true) {
						eval(obj._parent+".list"+objIndex+".btn").onRollOver();
					} else {
						if (next._visible) {
							next.btn.onRelease();
						}
						eval(obj._parent+".list"+0+".btn").onRollOver();
					}
				} else if ((obj._parent.col == 1) && (obj._parent.row>1)) {
					if (enableMouse._visible == false){
						if (workingPage == "server"){
							addNewPage.new_server.btn.onRollOver();
						}else if (workingPage == "application"){
							addNewPage.new_application.btn.onRollOver();
						}else if (workingPage == "country"){
							addNewPage.new_language.btn.onRollOver();
						}
					}else if (download._visible == true){
						if (download.download_list.count > download.download_list.num_obj){
							download.next.btn.onRollOver();
						}
					}
				}
			} else {
				if(obj.right._visible==false){obj=obj.right;};//skip first invisible button
				obj.right.btn.onRollOver();
			}
		}
		break;
	case key_downArrow :
		fscommand("offScreen", true);
		if (Selection.getFocus()== null){
			if (obj.list == true) {
				if ((obj._parent.col>1) && (obj._parent.row>1)) {
					var objIndex = obj.objIndex+obj._parent.col;
				} else if ((obj._parent.col == 1) && (obj._parent.row>1)) {					
					var objIndex = obj.objIndex + 1;
					if (enableMouse._visible == false){
						if (((eval(obj._parent+".list"+objIndex)._visible == undefined)or(eval(obj._parent+".list"+objIndex)._visible == false))and(obj._parent._parent.next._visible == true)) {
							obj._parent._parent.next.btn.onRollOver();
							return;
						}else if (((eval(obj._parent+".list"+objIndex)._visible == undefined)or(eval(obj._parent+".list"+objIndex)._visible == false))and(obj._parent._parent.next._visible == false)) {
							eval(obj._parent+".list"+0+".btn").onRollOver();
							return;
						}
					}else if (download._visible == true){						
						if (((eval(obj._parent+".list"+objIndex)._visible == undefined)or(eval(obj._parent+".list"+objIndex)._visible == false))and(obj._parent._parent.next._visible == true)) {
							obj._parent._parent.next.btn.onRollOver();
							return;
						}else if (((eval(obj._parent+".list"+objIndex)._visible == undefined)or(eval(obj._parent+".list"+objIndex)._visible == false))and(obj._parent._parent.next._visible == false)) {
							obj._parent._parent.ok.btn.onRollOver();
							return;
						}
					}
				}
				if (eval(obj._parent+".list"+objIndex)._visible == true) {
					eval(obj._parent+".list"+objIndex+".btn").onRollOver();
				}
			} else {
				obj.down.btn.onRollOver();
			}
		}else{			
			eval(Selection.getFocus())._parent.ok.btn.onRollOver();			
		}
		break;
	case key_enter :
		if (Selection.getFocus()== null){
			obj.btn.onRelease();
		}else{
			//eval(Selection.getFocus())._parent.ok.btn.onRelease();			
			eval(selectedObject._parent).btn.onRelease();
		}
		break;
	case key_space :
		if(!dlgServer._visible){
			if ((input._visible == false) && (sly_name_mc._visible == false)) {			
				if (send_event("normal&&&function||key_press|~|" + key_code  + "||1",false)){
					return;
				}
				fscommand("popup",true);
			}
		}

		/*if (TrackShow._visible == false and tmpTrackInfo != "") {
			TrackShow.setTrackShow(tmpTrackInfo);
		}*/
		break;
	case key_backspace :			
		if (Selection.getFocus()== null){
			if (str_obj_name != ""){
				eval(str_obj_name).btn.onRelease();
				str_obj_name = "";				
			}else{
				if (addNewPage._visible == true){					
					addNewPage.Back.btn.onRollOver();
					addNewPage.Back.btn.onRelease();
				}
			}			
		}
		break;
	}
}
//----------------------------------------------------------------------------------------------------
function combine_key(k) {
	k = int(k);
	if ((k != key_quit) && (k != 17)){
		if (send_event("normal&&&function||combine_key|~|" + k + "||1",false)){
			return;
		}
	}
	if (k == 17){
		return;
	}
	switch (k) {
	case key_switch :		
		switchMode.btn.onRollOver();
		switchMode.btn.onRelease();
		break;
	case key_playlist :
		// P: Playlist
		CtrlKey = false;
		playlist.btn.onRollOver();
		playlist.btn.onRelease();
		break;
	case key_login :
		// O: Computer
		if (login._visible == true) {
			login.btn.onRollOver();
			login.btn.onRelease();
		}
		break;
	case key_application :
		// F: Application
		if (application._visible == true) {
			application.btn.onRollOver();
			application.btn.onRelease();
		}
		break;
	case key_quit :
		// Q: Exit
		fscommand("Exit", "True");
		break;
	case key_D :
		// D: click Drop Menu
		exit.btn.onRelease();
		break;
	case key_new :
		// N: New Country
		addLanguage.btn.onRollOver();
		addLanguage.btn.onRelease();
		break;
	case key_language :
		// L: Language Page
		if (languagePage._visible == true) {
			languagePage.btn.onRollOver();
			languagePage.btn.onRelease();
		}
		break;
/*	case key_changeWindow :
		// change window stage
//		fscommand("changeWindow", true);
		break;*/
	case key_hideMouse :
		// hide or show mouse
		if (Mouse.hide() == 0) {
			Mouse.show();
			fscommand("setHideMouse", false);
		} else {
			Mouse.hide();
			fscommand("setHideMouse", true);
		}
		break;
	case key_minimize :
		CtrlKey = false;
//		fscommand("mini","Minimize|:|false");
		
		break;
	case key_visualization :
		fscommand("Visualization", true);
		break;
	case key_one :
		if (addNewPage._visible == false) {
			if (AlbumCover1 == "Yes") {
				AlbumCover1 = "No";
			} else {
				AlbumCover1 = "Yes";
			}
			display_cover = (AlbumCover1 == "Yes");
			displayList(list_language, list_language.stored_index);
			fscommand("CoverAlbum", AlbumCover1);
		}
		break;
	case key_two :
		if (addNewPage._visible == false) {
			if (NumCover1 == "Yes") {
				NumCover1 = "No";
			} else {
				NumCover1 = "Yes";
			}
			display_num = (NumCover1 == "Yes");
			displayList(list_language, list_language.stored_index);
			fscommand("NumAlbum", NumCover1);
		}
		break;
	case key_fullscreenplay :
		fscommand("FullScreenPlayer", true);
		break;
	case key_showPlaylist :
		fscommand("showPlaylistPlayer", 1);
		break;
	case key_slideShow :
		fscommand("setSlideShow", true);
		break;
	}
}
//----------------------------------------------------------------------------------------------------
// get values  from VB
//====================
function setVB(val) {
	var spl = new Array();
	spl = String(val).split("|%|");
	click_self = false;
	switch (spl[0]) {
	case "store_list_index" :
		list_language.stored_index = int(spl[1]);
		break;
	case "server_page":
		display_page_as_server(spl[1]);
		break;
	case "UnloadSwf" :
		UnloadItSelf("upCtrl,keyObj");
	case "new_server_found":

	case "new_server" :
		if (spl[1] == "fail"){
			dlgServer.password_txt.text = "";
		}else{
			dlgServer.cancel.btn.onRelease();
		}
		break;
	case "Variable" :		
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		set(arg_spl[0], arg_spl[1]);		
		break;
	case "fscommand" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		fscommand(arg_spl[0], arg_spl[1]);
		break;
	case "function" :
		// call function receive from client
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		eval(arg_spl.shift()).apply(null, arg_spl);
		break;
	case "select" :
		list_language.stored_index = Number(spl[1]);
		displayList(list_language, list_language.stored_index);
		//login._visible = false;
		break;
	case "Click" :
		eval(spl[1]).onRelease();
		break;
	case "Over" :
		set_selected(eval(spl[1]));
		break;
	case "clientType" :
		clientType = spl[1];
		break;
	case "OpenXml" :
		appPath = spl[1];
		openSetting = appPath;
	case "UnloadSWF" :
		if (parseInt(spl[1], 10)>0) {
			fscommand("UnloadSwf", spl[1]);
		}
		break;
	case "ReloadErr" :
		if (list_language._visible) {
			return;
		}
		displayList(list_language, list_language.list_array.length);
		bg._visible = true;
		break;
	case "slideShow" :
		if (spl[1] == "True") {
			fn_tooltip(_root,"slideshow (ON)");
			tooltip._x = 100;
			tooltip._y = 100;
		} else if (spl[1] == "False") {
			fn_tooltip(_root,"slideshow (OFF)");
			tooltip._x = 100;
			tooltip._y = 100;
		}
		break;
	case "TrackShow" :
		TrackShow.setTrackShow(spl[1]);
		break;
	case "default" :
		tmpTrackInfo = spl[1];
		break;


	case "connected" :
//		if(requestAutoConnect==1 and AutoClientConnection>0){
			//fscommand("requestConnect", AutoClientConnection);			
//		}else{
			if (click_switch_mode == false){
				restore_connecting_icon();
				loginType.mode4._visible = false;
			}
			loginType.display_login_type();
			click_switch_mode = false;
//		}
		break;
	case "success" :		
		OpenList=spl[1];
		if (clientType == clonePlayBack){
			list_language.stored_index = int(temp_store_list_index);
		}else{
			//Show these button on the top of language page
			_root.ButtonMovie._visible=true;
			_root.ButtonTv._visible=true;
			_root.ButtonKaraoke._visible=true;
			_root.ButtonMusic._visible=true;
			_root.ButtonCD._visible = true;
			//=============================================
			openLanguage = appPath;
		}
		if(clientType != independentMode){
			fscommand("other","requestTrackCount");
			fscommand("requestFirstPlay","");
		}
		fscommand("copy_friend_playlist",true);
		current_status = 1;
		if (_root.login_name != ""){
			disconnect_from_online();
		}
		break;
	case "DownloadCompleted" :
		str_obj_name = "";
		enabled_all._visible = false;
		enableMouse._visible = false;
		download._visible = false;
		download.progress._txt.text = "";
		download.progress._visible = false;
		download.ok._visible = true;
		download.cancel._visible = true;
		break;
	case "StringDownload" :
		enabled_all._visible = true;
		download.progress._txt.text = spl[1];
		download.progress._visible = true;
		break;
	case "getPath" :
		edit.path_txt.text = spl[1];
		break;
	case "not_connected" :
		enableMouse._visible = false;
		clearInterval(notAvailableID);
		list_language.connecting._txt.text = "Server Not Available";
		notAvailableID = setInterval(restore_connecting_icon,2000);
		if ((server_login_name != undefined) and (server_login_name != "")){
			disconnect_server_not_available(server_login_name, server_nick_name, server_ip);
		}
		break;
	case "sly_name" :
		if (spl[1] == ""){
			sly_name_mc.set_sly_name("Type user name");
		}else{
			sly_name_mc.set_sly_name("This user name already used");
		}
		break;
	case "autoUpdate" :
		getServerLink();
		break;
	case "auto_update_DB" :
		language_need_to_update_array = String(spl[1]).split("%%");
		if (language_need_to_update_array.length > 1){
			alert.show_alert("New Database Available","You have " + language_need_to_update_array.length + " databases to update.\n   Do you want to update now?");
		}else{
			var dd = new Array();
			dd = String(language_need_to_update_array[0]).split("||");
			alert.show_alert("New Database Available","You have " + dd[2] + " database to update.\n   Do you want to update now?");
		}		
		break;
	case "not_yet" :
		sign_mc.show_mc();
		break;
	case "connected_already" :
	
		break;
	case "popup_connect" :
		popup_connect.shows(spl[1]);
		break;
	}
	click_self = true;
}
function getvb() {
}
this.addProperty("vb", getvb, setVB);
//----------------------------
// Key Event
//----------------------------
//var CtrlKey = false;
//upCtrl = new Object();
//upCtrl.onKeyUp = function() {
//	if (enabled_all._visible == false){
//		if (Key.getCode() == key_ctrl) {
//			CtrlKey = false;
//		}
//	}
//};
//Key.addListener(upCtrl);
var keyObj = new Object();
keyObj.onKeyDown = function() {
	if (((enableMouse._visible == false) and (enabled_all._visible == false) and (Selection.getFocus()== null)) or (Key.getCode() == 13)){
		fscommand("clearTimeSlideshow",true);
		if (!UpdateDB._visible) {
			//fscommand("clearTimeSlideshow", true);
			Ctrlkey=Key.isDown(key_ctrl);
//			if (Key.getCode() == key_ctrl) {
//				CtrlKey = true;
//			}
			if (Key.getCode() == key_rightArrow || Key.getCode() == key_upArrow || Key.getCode() == key_leftArrow || Key.getCode() == key_downArrow) {
				CtrlKey = false;
			}			
			if (CtrlKey == true) {
				combine_key(Key.getCode());
			} else {
				if ((addNewPage._visible == false) && (sly_name_mc._visible == false) && !(enabled_sign._visible)) {
					var nn = int(Key.getAscii());
				}				
				if ((48<=nn) and (nn<=57)) {
					if (enableMouse._visible == false){
						clearInterval(ID_press_key_number);
						key_num = int(String(key_num)+chr(nn));
						ID_press_key_number = setInterval(press_key_number, 500);
						nn = 0;
					}
				} else {
					key_press(Key.getCode());
				}
			}
		}
	}
	else if  (loginType._visible){
		if (Key.getCode() == key_rightArrow || Key.getCode() == key_upArrow || Key.getCode() == key_leftArrow || Key.getCode() == key_downArrow) 
		{
			key_press(Key.getCode());			//Kill focus for selected Text box
		}
	}
	if(Key.getCode()==key_downArrow and Selection.getFocus()!=null){
		if(change_pass_mc._visible){						//Change password
			if(Selection.getFocus()=="_level0.change_pass_mc.txt_confirm_pass"){
				Selection.setFocus(null);
			}
		}
		if(sign_mc._visible){							//sign in
			if(Selection.getFocus()=="_level0.sign_mc.txt_password"){
				Selection.setFocus(null);
			}
		}
		if(sign_up_new_mc._visible){							//sign up
			if(Selection.getFocus()=="_level0.sign_up_new_mc.txt_email"){
				Selection.setFocus(null);
				sign_up_new_mc.ok.btn.onRollOver();
			}
		}
	}
};
Key.addListener(keyObj);
//----------------------------------------------------------------------------------------------------
function send_to_client(strCommand, strEvent, strValue, skipIfNoControl) {
	if (!((clientType != remotePlaylist) and skipIfNoControl)) {
		fscommand(strCommand, strEvent+strValue);
	}
}
//----------------------------------------------------------------------------------------------------
function getPathToDownloadNewLanguage(str_path) {
	//str_path = "//Patricia/D/CDs/Japanese";
	var str_length = String(str_path).length;
	var get_str = "";
	for (var init = str_length; init>0; init--) {
		get_str = String(str_path).substr(init, 1);
		if (get_str == "/" || get_str == "\\") {
			return String(str_path).substr(0, init);
		}
	}
}

//----------------------------------------------------------------------------------------------------
function display_page_as_server(val){
	var valSplit = new Array();
	valSplit = String(val).split("|||");	
	if (valSplit.length == 4){
		workingPage = String(valSplit[2]);
		showAddPage = (String(valSplit[3]) == "true");
		
		if (showAddPage == true){
			addLanguage.btn.onRelease();
		}else{
			if ( workingPage == "application"){
				openApplication = appPath;
			}else if (workingPage == "country"){
				openLanguage = appPath;
			}else if (workingPage == "server"){			
				openServer = appPath;
			}
		}
	}else{
		if (String(valSplit[1]).length > 1){
			server_display = String(valSplit[1]);
			startLogon = true;
		}
		if (String(valSplit[0]).length > 1){
			start_refresh = true;
			CountryLoad = String(valSplit[0]);
			ReLoad = "true";
			FirstLoad = "Country";
			openLanguage = appPath;
		}else{
			openLanguage = appPath;
		}
	}
}
//----------------------------------------------------------------------------------------------------
function unloadFlash() {
	//unload itself from the flash movie
	//array parameter specified the in the argument (Key1,Key2,Key3)
	for (i=0; i<arguments.length; i++) {
		Key.removeListener(eval(arguments[i]));
	}
	unloadMovie(_root);
}
//----------------------------------------------------------------------------------------------------
function UnloadItSelf(vValue) {
	var objList = vValue.split(",");
	unloadFlash.apply(null,objList);
}
//----------------------------------------------------------------------------------------------------
function setStatus(val){
	SetConnectColor(exit.icon_con,val);
	val = int(val);
	varStatus=val;
	if(workingPage=="country"){
		login._visible=(varStatus==0);
	}
}
function getStatus(){return varStatus}
this.addProperty("current_status",getStatus,setStatus);
//----------------------------------------------------------------------------------------------------
function restore_connecting_icon(){
	clearInterval(notAvailableID);
	list_language.connecting.gotoAndStop(1);
}
//----------------------------------------------------------------------------------------------------
function setModes(val){
	var arr = new Array();
	arr = String(val).split("~");
	allow_mode1 = !(arr[0] == "True");
	allow_mode2 = !(arr[1] == "True");
	allow_mode3 = !(arr[2] == "True");
	allow_mode4 = !(arr[4] == "True");
	temp_store_list_index = arr[3];
	if (search._visible){
		search.hide_mc();
	}
}
function getModes(){}
_root.addProperty("allow_modes", getModes, setModes);

//----------------------------------------------------------------------------------------------------
function readCDXML (path,currentCountry) {
	var cdXML_xml= new XML();
	var Main=this;
		Main.dbServer=""
		Main.imageServer=""
	
	cdXML_xml.load(path);
	cdXML_xml.onLoad=function (success) {
		if(success){
			var xmlLanguages=cdXML_xml.firstChild.childNodes;
			var xmlElement;
			for (var i=0;i<xmlLanguages.length;i++){
				xmlElement=xmlLanguages[i].attributes;
				country=xmlElement.countryName;
				if(country.toLowerCase()==currentCountry.toLowerCase()){
					Main.imageServer = xmlElement.imageServer;
					Main.dbServer    = xmlElement.dbServer;
					Main.onLoad(success);
					return;
				}
			}
		}
		Main.onLoad(false);
	}	
}

//----------------------------------------------------------------------------------------------------
// load xml from server
var stringDateUpdate = "";
function loadXmlFromServer(str_languageName){
	var ser_xml = new XML();
	var dbServer="",imageServer="";
	
	var sxml= new readCDXML("http://www.slymultimedia.com/cds/cdxml.xml",str_languageName);
	sxml.onLoad=function(success) {		
		dbServer   = this.dbServer   ;
		imageServer= this.imageServer;
		if(success){
			ser_xml.load("http://www.slymultimedia.com/cds/countries.xml");
			ser_xml.onLoad = function(success){
				var l = new Array();
				l = ser_xml.firstChild.childNodes;
				for (var init=0; init<l.length; init++){			
					if (str_languageName == l[init].childNodes[0].nodeValue){				
						stringDateUpdate = l[init].attributes.lastDownload + "||" + l[init].attributes.lastUpdate + "||" + str_languageName +"||" + dbServer + "||" + imageServer;
						fscommand("CheckUpdateAvailable",stringDateUpdate);
						break;
					}
				}
			}
		}
	}
}
//----------------------------------------------------------------------------------------------------
function load_all_countries() {
	var xmlAC = new XML();
	xmlAC.load("CountryNames.xml");
	xmlAC.onLoad = function(success) {
		if (success){
			var l = new Array();
			l = xmlAC.firstChild.childNodes;
			for (var i = 0; i<l.length; i++){
				sign_up_new_mc.countries.country_list.list_array[i] = l[i].attributes.Name;
			}			
		}
	};
}
load_all_countries();
//------------------------------------------------------------------------------------------------------------
function show_icon(){
	if (workingPage == "country"){
		addLanguage.icon_new._visible = true;
		addLanguage.icon_language._visible = true;
		addLanguage.icon_server._visible = false;
		addLanguage.icon_search._visible = false;
	} else {
		addLanguage.icon_language._visible = false;
		addLanguage.icon_server._visible = true;
		if (login_name == ""){
			addLanguage.icon_new._visible = true;			
			addLanguage.icon_search._visible = false;
		} else {
			addLanguage.icon_new._visible = false;
			addLanguage.icon_search._visible = true;
		}
	}
}
function selectionGetfocus() {
	return Selection.getFocus();
}

//----------------------------------------------------------------------------------------------------
function new_line(str){ // str: must be with "()";
	var tstr = "";
	for (var init=0; init<length(str); init++){
		tstr = String(str).substr(init,1);
		if (tstr == "("){
			return String(str).substr(0,init) + "\n" + (String(str).substr(init));
		}
	}
	return str;
}
//----------------------------------------------------------------------------------------------------