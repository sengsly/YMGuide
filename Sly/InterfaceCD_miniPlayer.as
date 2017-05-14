var topControl = new Array("PlayAll.Movie","SearchArtist.Movie","AlbumInfo.Movie","Cart.Movie","chkVisibleIcon.Movie","NextAlbum.Movie");
var bObj = new Array("_level0.previous_mc._mc","_level0.PreviouseChapter_mc._mc","_level0.pause_mc._mc","_level0.stop_mc._mc","_level0.NextChapter_mc._mc","_level0.next_mc._mc" );

/*************************************************************************************************************/
/* function
/*************************************************************************************************************/
// function for hide mini player
//====================
function hidePlayer() {
	fscommand("HidePlayer");
	mini._visible = false;
	clearInterval(IDS);
	get_seek = false;
}
// function for show mini player
//====================
function showPlayer() {
	if (mini._visible == false) {
		get_seek = true;
		mini._visible = true;
		if (b_scroll == true) {
			setScrollType("True");
		} else {
			setScrollType("False");
		}
	}
}
// get values  from VB
//============	========
function setVB(val) {
	var spl = new Array();
	click_self = false;
	spl = String(val).split("|%|");
	switch (spl[0]) {
	case "setMusicNote":
		MusicNote=spl[1];
		eval(TrackName).MusicNote.RedLine._visible = MusicNote=="true";
		break;
	case "lostFocus":
		ChangeColor(eval(StoreNameSelected), SetColorValue, ButtonAlpha);
		flashFocus =0;
		break;
	case "setFocus":
		if (spl[1]=="Movie")
		{
			var j=(nTrack >8) ? 9 : 6;
			for(var  i = j ; i> 0 ; i--)
			{
				if (eval(TrackName+".Button"+ i)._visible )
				{
					eval(TrackName+".Button"+i).onRollOver();
					break;					
				}
			}
		}else
		{	SelectLevel = 4;
			SelectButton(topControl[int(spl[1])]);
		}
		break;
	case "changeLanguage":
		ChangeLan=spl[1];
		ChangeUnicode();
		break;
		// changed sith 14-06-06
	case "Variable" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		set(arg_spl[0], arg_spl[1]);
		break;
	case "ChangeTrackTitleStyle":
		iShowUnderTrackTitle=spl[1];
		if(MainLevel==4){
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
		}
		
		break;
	case "SaveBookMark":
		GetPathNane();
		Save.Text0.text =  "Bookmark";//SetPlayListName;
		Save.Text.text = SetPlayListSlidePath;
		Save.DataInput = spl[1];
		Save.ShowSave(true);
		break;
	case "setOffsetEnabled": //change retreive offsetEnabled
		offsetEnabled=(spl[1].toLowerCase()=="true");
		eval(trackName).chkOffset.Selected._visible =offsetEnabled;
		eval(trackName).offset._visible =(eval(trackName).MainTitle._visible) ? offsetEnabled : false;
		break;
	case "VisibleAlbumCover":
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		if(arg_spl[0]=="DVDRating"){
			if(arg_spl[1]=="1"){
			   iAlbumDVDRating=1; 
			}
			else {
			   iAlbumDVDRating=0;
			}
		}
		//
			DisplayArtistNameItem("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
			DisplayArtistNameItem("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
		//
		if(MainLevel==3 || MainLevel==4 ){
			DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
		}
		else if(MainLevel==2){
			DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
		}
		break;
	case "fscommand" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		var vvvv = new Array();
		vvvv = String(arg_spl[1]).split("|:|");
		if ((String(arg_spl[1])).toLowerCase() != "seek") {
			fscommand(arg_spl[0], arg_spl[1]);
			if ((clientType == serverMode) and (arg_spl[0] == "mini")) {
				send_event("mini&&&fscommand||mini|~|"+arg_spl[1]+"||"+vvvv[0]+"||"+vvvv[1], true);
			} else if ((clientType == serverMode) and ((arg_spl[0] == "KeyPressed") or (arg_spl[0] == "Key"))) {
				send_event("mini&&&fscommand||KeyPressed|~|"+arg_spl[1], true);
			}
		}
		break;
	case "function" :
		// call function receive from client
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		eval(arg_spl.shift()).apply(null, arg_spl);
		break;
	case "Over" :
		//SelectButton(eval(spl[1]));			
		eval(spl[1]).onRollOver();
		break;
	case "Click" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		_global.boolMouseDown = true;
		var functName=arg_spl.shift();
		eval(functName+".onRelease").apply(eval(functName), arg_spl);
		break;
	case "clientType" :
		clientType = spl[1];
		break;
	case "RefreshAlbum":
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("~");
		refreshScanAlbum(arg_spl[2],arg_spl[0]);
		selectVolbar (clickVolIndex,true);
		break;
	case "grouping" :
		Grouping = spl[1];
		showPopupGrouping(Grouping);
	case "hideMiniPlayer" :
		clearInterval(IDS);
		get_seek = false;
		break;
	case "showMiniPlayer" :
		if (mini._visible == true) {
			if (mini.PauseMusic._visible == true) {
				get_seek = true;
				mini._visible = true;
				if (b_scroll == true) {
					setScrollType("True");
				} else {
					setScrollType("False");
				}
			}
		}
		break;
	case "+" :
		click_self = true;
		setKeyVolUp();
		break;
	case "-" :
		click_self = true;
		setKeyVolDown();
		break;
	case "P.Up" :
		control_mini_player("seek", int(mini.seekbar.knob._width)+12, "true");
		break;
	case "P.Down" :
		control_mini_player("seek", int(mini.seekbar.knob._width)-12, "true");
		break;
	case "ClearInfo" :
		clearInterval(IDS);
		mini.img1.unloadMovie();
		mini.img2.unloadMovie();
		mini.txtScroll0.txt0.text = "";
		mini.txtScroll0.txt1.text = "";
		mini.txtScroll0.txt2.text = "";
		mini.txtScroll0.txt3.text = "";
		mini.txtScroll0.txt4.text = "";
		mini.txtScroll0.txt5.text = "";
		mini.txtScroll1.txt0.text = "";
		mini.txtScroll1.txt1.text = "";
		mini.txtScroll1.txt2.text = "";
		mini.txtScroll1.txt3.text = "";
		mini.txtScroll1.txt4.text = "";
		mini.txtScroll1.txt5.text = "";
		mini.lblNext.txt0.text = "";
		mini.lblNext.txt1.text = "";
		mini.seekbar.txtCurrent.text = "";
		mini.seekbar.txtLength.text = "";
		mini.seekbar.knob._width = 0;
		tmpImgPath = "";
		tmplblNext = "";
		tmpImg = "";
		break;
	case "AudioChannel":
		playAudioChannel=spl[1];
		eval(TrackName).AudioChannel.setState(playAudioChannel);	//State for play movie
		break;
	case "PlayChapterState":
		playchapterfile=spl[1];
		eval(TrackName).AddToPlay.setState(eval(TrackName).AddToPlay.getState());	//State for play movie
		break;
	case "currentTrack" :
		getInfo(spl[1]);
		break;
	case "LabelNext" :
		getLabelNext(spl[1]);
		break;
	case "nextTrack" :
		setNextTrack(spl[1]);
		break;
	case "currentImage" :
		if (spl[1] == "None") {
			tmpImg = "";
			mini.CD._visible = true;
			mini.img1._visible = false;
			mini.img2._visible = false;
			mini.img1._alpha = 100;
			mini.img2._alpha = 0;
		} else {
			mini.CD._visible = false;
			if (tmpImg != spl[1]) {
				tmpImg = spl[1];
				mini.img1._visible = true;
				mini.img2._visible = true;
				fadeObject(mini.img1, mini.img2, spl[1]);
			}
		}
		break;
	case "Volume" :
		setVolumeDefault(int(spl[1]));
		break;
	case "Seek" :
		if (get_seek == true) {
			mini.seekbar.txtCurrent.text = timeCurrent;
			mini.seekbar.txtLength.text = trackLength;
			if (Number(spl[1])>=seekWidth) {
				mini.seekbar.knob._width = seekWidth;
			} else {
				mini.seekbar.knob._width = Number(spl[1]);
			}
		}
		break;
	case "Play" :
		Played(spl[1] == "True", spl[2]);
		break;
	case "Stop" :
		if (spl[1] == "True") {
			Played(false);
			clearInterval(ID_DisplayInfoTrackPlaying);
		}
		break;
	case "Shuffle" :
		if (spl[1] == "True") {
			Shuffled(true);
		} else {
			Shuffled(false);
		}
		break;
	case "Repeat" :
		if (spl[1] == "True") {
			Repeated(true);
		} else {
			Repeated(false);
		}
		break;
	case "Mute" :
		Muted(spl[1] == "True");
		break;
	case "karaoke_voice" :
		karaokeVoice(spl[1] == "True");
		break;
	case "scroll" :
		setScrollType(spl[1]);
		break;
	case "Register" :
		if (spl[1] == "True") {
			mini.Register._visible = false;
		} else {
			mini.Register._visible = true;
		}
		break;
	case "TrackShow" :
		TrackShow.setTrackShow(spl[1]);
		break;
	case "default" :
		var bbbb = false;
		if (tmpTrackInfo == "") {
			bbbb = true;
		}
		tmpTrackInfo = spl[1];
		if (bbbb == true) {
			bbbb = false;
			displayInfoType_str = "Next";
			displayInfoTrackPlaying();
		}
		break;
	case "PositionTrackShow" :
		var arr_position = new Array();
		arr_position = String(spl[1]).split(":");
		TrackShow.xLocation = arr_position[0];
		TrackShow.yLocation = arr_position[1];
		TrackShow._x = arr_position[0];
		TrackShow._y = arr_position[1];
		break;
	case "player_info" :
		var aa = new Array();
		aa = String(spl[1]).split("%%");
		mini.seekbar.knob._width = int(aa[0]);
		mini.seekbar.txtCurrent.text = aa[1];
		mini.seekbar.txtLength.text = aa[2];
		break;
	case "popup_connect" :
		popup_connect.shows(spl[1]);
		break;
	case "refresh_myalbum" :
		if (DisplayAlbum == "MyAlbum"){
			MenuBrowse.MyAlbum.Button.onRelease();
		}
		break;	
	case "UpdateDatabaseFromServer":
		Msgbox.Show("The database is available for update, do you want to update? ","Update <"+ spl[1] +">",UpdatedatabaseMsgBox,spl[1]+"&&&"+spl[2]);
		break;
	case "I":
		if(AddTrackBox._visible){
			AddTrackBox._visible=false;
		}else{
	     		AddTrackBox._visible=true;
			selection.setFocus(AddTrackBox.InputTrackBox);
		}
	     break;
	case "closeAddBox" :
		AddTrackBox.ButtonCancel.onRelease();
		break;
	}
	click_self = true;
}
var old_TrackName;
this.addProperty("TrackNames", getTrackName, setTrackName);
function getTrackName() {
}
function setTrackName(newValue) {
	if (newValue == "ListBar") {
		TrackObj = "List";
		nTrack = 8;
	} else {
		TrackObj = "Track";
		nTrack = 12;
	}
	TrackName = newValue;
	if (eval(old_TrackName)._visible) {
		eval(newValue)._visible = true;
		eval(old_TrackName)._visible = false;
		ReloadTrackPage();
		FirstDisplayTrack(resultSearchTrack.length);
	}
	old_TrackName = newValue;
}
function getvb() {
}
this.addProperty("vb", getvb, setVB);
// Button controll
//====================
function Shuffled(TF) {
	TF = Boolean(TF);
	mini.ShuffleTrue._visible = TF;
	mini.ShuffleFalse._visible = !TF;
	//TrackShow.setTrackShow(" Shuffled "+(TF ? "ON" : "OFF")+" ");
}
function Repeated(TF) {
	TF = Boolean(TF);
	mini.RepeatTrue._visible = TF;
	mini.RepeatFalse._visible = !TF;
	//TrackShow.setTrackShow(" Repeat "+(TF ? "ON" : "OFF")+" ");
}
function Muted(TF) {
	TF = Boolean(TF);
	mini.MuteTrue._visible = TF;
	mini.MuteFalse._visible = !TF;
	//TrackShow.setTrackShow(" Mute "+(TF ? "ON" : "OFF")+" ");
}
function Played(TF, TFStop) {
	TF = Boolean(TF);
	TFStop = Boolean(TFStop);
	if (TF == true) {
		get_seek = true;
		mini.PlayMusic._visible = false;
		mini.PauseMusic._visible = true;
		if (b_scroll == true) {
			setScrollType("True");
		} else {
			setScrollType("False");
		}
	} else {
		get_seek = false;
		mini.PlayMusic._visible = true;
		mini.PauseMusic._visible = false;
		clearInterval(IDS);
		clearInterval(ID_DisplayInfoTrackPlaying);
	}
	//TrackShow.setTrackShow(TF ? " Play " : ((TFStop == true) ? " Stop " : " Pause "));
}
// function change color
//====================
function changeColors(obj, val_col, val_alpha) {
	ncol = new Color(eval(obj));
	ncol.setRGB(val_col);
	eval(obj)._alpha = val_alpha;
}
// function for change color mini player
//====================
function changeColorButton() {
	changeColors("mini.bgHideScroll0", BgColorValue, 100);
	changeColors("mini.bgHideScroll1", BgColorValue, 100);
	changeColors("mini.bgScroll", BgColorValue, 100);
	changeColors("mini.Background", BgColorValue, 100);
	changeColors("mini.PlayMusic.MoviePlay", SetColorValue, ButtonAlpha);
	changeColors("mini.PauseMusic.MoviePause", SetColorValue, ButtonAlpha);
	changeColors("mini.StopMusic.MovieStop", SetColorValue, ButtonAlpha);
	changeColors("mini.PreviousMusic.MoviePrevious", SetColorValue, ButtonAlpha);
	changeColors("mini.NextMusic.MovieNext", SetColorValue, ButtonAlpha);
	changeColors("mini.AddMusic.MovieAddMusic", SetColorValue, ButtonAlpha);
	changeColors("mini.PlayerPage.MoviePlayerPage", SetColorValue, ButtonAlpha);
	changeColors("mini.ShuffleTrue.MovieShuffle", SetColorValue, ButtonAlpha);
	changeColors("mini.ShuffleFalse.MovieShuffle", SetColorValue, ButtonAlpha);
	changeColors("mini.RepeatTrue.MovieRepeat", SetColorValue, ButtonAlpha);
	changeColors("mini.RepeatFalse.MovieRepeat", SetColorValue, ButtonAlpha);
	changeColors("mini.MuteTrue.MovieMute", SetColorValue, ButtonAlpha);
	changeColors("mini.MuteFalse.MovieMute", SetColorValue, ButtonAlpha);
	changeColors("mini.voice.MovieVoice", SetColorValue, ButtonAlpha);
	changeColors("mini.seekbar.MovieSeek", SetColorValue, ButtonAlpha);
	changeColors("mini.volbar.MovieVol", SetColorValue, ButtonAlpha);
	mini.txtScroll0.txt0.textColor = FontColor;
	mini.txtScroll0.txt1.textColor = FontColor;
	mini.txtScroll0.txt2.textColor = FontColor;
	mini.txtScroll0.txt3.textColor = FontColor;
	mini.txtScroll0.txt4.textColor = FontColor;
	mini.txtScroll0.txt5.textColor = FontColor;
	mini.txtScroll1.txt0.textColor = FontColor;
	mini.txtScroll1.txt1.textColor = FontColor;
	mini.txtScroll1.txt2.textColor = FontColor;
	mini.txtScroll1.txt3.textColor = FontColor;
	mini.txtScroll1.txt4.textColor = FontColor;
	mini.txtScroll1.txt5.textColor = FontColor;
	mini.lblNext.txt0.textColor = FontColor;
	mini.lblNext.txt1.textColor = FontColor;
	mini.seekbar.txtCurrent.textColor = FontColor;
	mini.seekbar.txtSlah.textColor = FontColor;
	mini.seekbar.txtLength.textColor = FontColor;
	mini.volbar.txtVol.textColor = FontColor;
	mini.volbar.txtPer.textColor = FontColor;
	mini.txtInfo.textColor = FontColor;
}
// functin get track information for display in mini player
//====================
function getInfo(str) {
	tmp_textDisplay = str;
	spl = new Array();
	sspl = new Array();
	spl = String(str).split(sym);
	sspl = String(spl[0]).split(sss);
	scti = sspl[0];
	// scroll caption title
	scar = sspl[1];
	// scroll caption artist
	scal = sspl[2];
	// scroll caption album
	scfn = sspl[3];
	// scroll caption font name
	scfs = sspl[4];
	// scroll caption font size
	sspl = String(spl[1]).split(sss);
	tsti = sspl[0];
	// text scroll title
	tsfnti = sspl[1];
	// text scroll font name title
	tsfsti = sspl[2];
	// text scroll font size title
	sspl = String(spl[2]).split(sss);
	tsar = sspl[0];
	// text scroll title
	tsfnar = sspl[1];
	// text scroll font name artist
	tsfsar = sspl[2];
	// text scroll font size artist		
	sspl = String(spl[3]).split(sss);
	tsal = sspl[0];
	// text scroll title
	tsfnal = sspl[1];
	// text scroll font name album
	tsfsal = sspl[2];
	// text scroll font size album
	// font caption
	set_fc.font = scfn;
	//set_fc.size = int(scfs) - 5;
	if ((String(scfn).substr(0, 5)) == "Limon") {
		set_fc.size = font_size_text_scroll_limon;
	} else {
		set_fc.size = font_size_text_scroll_other;
	}
	// font title
	set_fti.font = tsfnti;
	//set_fti.size = int(tsfsti) - 5;
	if ((String(tsfnti).substr(0, 5)) == "Limon") {
		set_fti.size = font_size_text_scroll_limon;
	} else {
		set_fti.size = font_size_text_scroll_other;
	}
	// font artist
	set_far.font = tsfnar;
	//set_far.size = int(tsfsar) - 5;
	if ((String(tsfnar).substr(0, 5)) == "Limon") {
		set_far.size = font_size_text_scroll_limon;
	} else {
		set_far.size = font_size_text_scroll_other;
	}
	// font album
	set_fal.font = tsfnal;
	//set_fal.size = int(tsfsal) - 5;
	if ((String(tsfnal).substr(0, 5)) == "Limon") {
		set_fal.size = font_size_text_scroll_limon;
	} else {
		set_fal.size = font_size_text_scroll_other;
	}
	if (b_scroll == true) {
		setScrollType("True");
	} else {
		setScrollType("False");
	}
}
// None Scroll
//====================
function setInfoOneByOne() {
	mini.txtScroll0.txt2.text = "";
	mini.txtScroll0.txt3.text = "";
	mini.txtScroll0.txt4.text = "";
	mini.txtScroll0.txt5.text = "";
	mini.txtScroll1.txt0.text = "";
	mini.txtScroll1.txt1.text = "";
	mini.txtScroll1.txt2.text = "";
	mini.txtScroll1.txt3.text = "";
	mini.txtScroll1.txt4.text = "";
	mini.txtScroll1.txt5.text = "";
	mini.txtScroll0._x = x_scroll;
	mini.txtScroll0._y = y_scroll;
	mini.txtScroll0.txt0.text = scti;
	mini.txtScroll0.txt0.autoSize = true;
	mini.txtScroll0.txt0.setTextFormat(set_fc);
	mini.txtScroll0.txt0._y = -(int(mini.txtScroll0.txt0.textHeight)/2);
	mini.txtScroll0.txt1.text = tsti;
	mini.txtScroll0.txt1.autoSize = true;
	mini.txtScroll0.txt1.setTextFormat(set_fti);
	mini.txtScroll0.txt1._x = 5+mini.txtScroll0.txt0._x+mini.txtScroll0.txt0.textWidth;
	mini.txtScroll0.txt1._y = -(int(mini.txtScroll0.txt1.textHeight)/2);
	sc = 1;
}
function oneByOne() {
	mini.txtScroll0.txt2.text = "";
	mini.txtScroll0.txt3.text = "";
	mini.txtScroll0.txt4.text = "";
	mini.txtScroll0.txt5.text = "";
	mini.txtScroll1.txt0.text = "";
	mini.txtScroll1.txt1.text = "";
	mini.txtScroll1.txt2.text = "";
	mini.txtScroll1.txt3.text = "";
	mini.txtScroll1.txt4.text = "";
	mini.txtScroll1.txt5.text = "";
	mini.txtScroll0._x = x_scroll;
	mini.txtScroll0._y = y_scroll;
	if (sc == 0) {
		mini.txtScroll0.txt0.text = scti;
		mini.txtScroll0.txt0.autoSize = true;
		mini.txtScroll0.txt0.setTextFormat(set_fc);
		mini.txtScroll0.txt0._y = -(int(mini.txtScroll0.txt0.textHeight)/2);
		mini.txtScroll0.txt1.text = tsti;
		mini.txtScroll0.txt1.autoSize = true;
		mini.txtScroll0.txt1.setTextFormat(set_fti);
		mini.txtScroll0.txt1._x = 5+mini.txtScroll0.txt0._x+mini.txtScroll0.txt0.textWidth;
		mini.txtScroll0.txt1._y = -(int(mini.txtScroll0.txt1.textHeight)/2);
		sc = 1;
	} else if (sc == 1) {
		mini.txtScroll0.txt0.text = scar;
		mini.txtScroll0.txt0.autoSize = true;
		mini.txtScroll0.txt0.setTextFormat(set_fc);
		mini.txtScroll0.txt0._y = -(int(mini.txtScroll0.txt0.textHeight)/2);
		mini.txtScroll0.txt1.text = tsar;
		mini.txtScroll0.txt1.autoSize = true;
		mini.txtScroll0.txt1.setTextFormat(set_far);
		mini.txtScroll0.txt1._x = 5+mini.txtScroll0.txt0._x+mini.txtScroll0.txt0.textWidth;
		mini.txtScroll0.txt1._y = -(int(mini.txtScroll0.txt1.textHeight)/2);
		sc = 2;
	} else {
		mini.txtScroll0.txt0.text = scal;
		mini.txtScroll0.txt0.autoSize = true;
		mini.txtScroll0.txt0.setTextFormat(set_fc);
		mini.txtScroll0.txt0._y = -(int(mini.txtScroll0.txt0.textHeight)/2);
		mini.txtScroll0.txt1.text = tsal;
		mini.txtScroll0.txt1.autoSize = true;
		mini.txtScroll0.txt1.setTextFormat(set_fal);
		mini.txtScroll0.txt1._x = 5+mini.txtScroll0.txt0._x+mini.txtScroll0.txt0.textWidth;
		mini.txtScroll0.txt1._y = -(int(mini.txtScroll0.txt1.textHeight)/2);
		sc = 0;
	}
}
// Scroll
//====================
function setInfoScrol() {
	// Text Scroll 0
	mini.txtScroll0.txt0.text = scti;
	mini.txtScroll0.txt0.autoSize = true;
	mini.txtScroll0.txt0.setTextFormat(set_fc);
	mini.txtScroll0.txt0._y = -(int(mini.txtScroll0.txt0.textHeight)/2);
	mini.txtScroll0.txt1.text = tsti;
	mini.txtScroll0.txt1.autoSize = true;
	mini.txtScroll0.txt1.setTextFormat(set_fti);
	mini.txtScroll0.txt1._x = mini.txtScroll0.txt0._x+mini.txtScroll0.txt0.textWidth+5;
	mini.txtScroll0.txt1._y = -(int(mini.txtScroll0.txt1.textHeight)/2);
	mini.txtScroll0.txt2.text = scar;
	mini.txtScroll0.txt2.autoSize = true;
	mini.txtScroll0.txt2.setTextFormat(set_fc);
	mini.txtScroll0.txt2._x = 20+mini.txtScroll0.txt1._x+mini.txtScroll0.txt1.textWidth;
	mini.txtScroll0.txt2._y = -(int(mini.txtScroll0.txt2.textHeight)/2);
	mini.txtScroll0.txt3.text = tsar;
	mini.txtScroll0.txt3.autoSize = true;
	mini.txtScroll0.txt3.setTextFormat(set_far);
	mini.txtScroll0.txt3._x = mini.txtScroll0.txt2._x+mini.txtScroll0.txt2.textWidth+5;
	mini.txtScroll0.txt3._y = -(int(mini.txtScroll0.txt3.textHeight)/2);
	mini.txtScroll0.txt4.text = scal;
	mini.txtScroll0.txt4.autoSize = true;
	mini.txtScroll0.txt4.setTextFormat(set_fc);
	mini.txtScroll0.txt4._x = 20+mini.txtScroll0.txt3._x+mini.txtScroll0.txt3.textWidth;
	mini.txtScroll0.txt4._y = -(int(mini.txtScroll0.txt4.textHeight)/2);
	mini.txtScroll0.txt5.text = tsal;
	mini.txtScroll0.txt5.autoSize = true;
	mini.txtScroll0.txt5.setTextFormat(set_fal);
	mini.txtScroll0.txt5._x = mini.txtScroll0.txt4._x+mini.txtScroll0.txt4.textWidth+5;
	mini.txtScroll0.txt5._y = -(int(mini.txtScroll0.txt5.textHeight)/2);
	mini.txtScroll0._visible = true;
	mini.txtScroll0._x = x_scroll;
	mini.txtScroll0._y = y_scroll;
	// Text Scroll 1
	mini.txtScroll1.txt0.text = scti;
	mini.txtScroll1.txt0.autoSize = true;
	mini.txtScroll1.txt0.setTextFormat(set_fc);
	mini.txtScroll1.txt0._y = -(int(mini.txtScroll1.txt0.textHeight)/2);
	mini.txtScroll1.txt1.text = tsti;
	mini.txtScroll1.txt1.autoSize = true;
	mini.txtScroll1.txt1.setTextFormat(set_fti);
	mini.txtScroll1.txt1._x = mini.txtScroll1.txt0._x+mini.txtScroll1.txt0.textWidth+5;
	mini.txtScroll1.txt1._y = -(int(mini.txtScroll1.txt1.textHeight)/2);
	mini.txtScroll1.txt2.text = scar;
	mini.txtScroll1.txt2.autoSize = true;
	mini.txtScroll1.txt2.setTextFormat(set_fc);
	mini.txtScroll1.txt2._x = 20+mini.txtScroll1.txt1._x+mini.txtScroll1.txt1.textWidth;
	mini.txtScroll1.txt2._y = -(int(mini.txtScroll1.txt2.textHeight)/2);
	mini.txtScroll1.txt3.text = tsar;
	mini.txtScroll1.txt3.autoSize = true;
	mini.txtScroll1.txt3.setTextFormat(set_far);
	mini.txtScroll1.txt3._x = mini.txtScroll1.txt2._x+mini.txtScroll1.txt2.textWidth+5;
	mini.txtScroll1.txt3._y = -(int(mini.txtScroll1.txt3.textHeight)/2);
	mini.txtScroll1.txt4.text = scal;
	mini.txtScroll1.txt4.autoSize = true;
	mini.txtScroll1.txt4.setTextFormat(set_fc);
	mini.txtScroll1.txt4._x = 20+mini.txtScroll1.txt3._x+mini.txtScroll1.txt3.textWidth;
	mini.txtScroll1.txt4._y = -(int(mini.txtScroll1.txt4.textHeight)/2);
	mini.txtScroll1.txt5.text = tsal;
	mini.txtScroll1.txt5.autoSize = true;
	mini.txtScroll1.txt5.setTextFormat(set_fal);
	mini.txtScroll1.txt5._x = mini.txtScroll1.txt4._x+mini.txtScroll1.txt4.textWidth+5;
	mini.txtScroll1.txt5._y = -(int(mini.txtScroll1.txt5.textHeight)/2);
	mini.txtScroll1._visible = true;
	mini.txtScroll1._x = mini.txtScroll0._x+mini.txtScroll0._width+30;
	mini.txtScroll1._y = y_scroll;
}
function Scrolling() {
	// test scroll 0
	if (mini.txtScroll0._x<(x_scroll-mini.txtScroll0._width)) {
		mini.txtScroll0._x = mini.txtScroll1._x+mini.txtScroll1._width+30;
	} else {
		mini.txtScroll0._x = mini.txtScroll0._x-speedScroll;
	}
	// test scroll 1
	if (mini.txtScroll1._x<(x_scroll-mini.txtScroll1._width)) {
		mini.txtScroll1._x = mini.txtScroll0._x+mini.txtScroll0._width+30;
	} else {
		mini.txtScroll1._x = mini.txtScroll1._x-speedScroll;
	}
}
// function controll type of information
//====================
function setScrollType(TF) {
	if (TF == "True") {
		b_scroll = true;
		clearInterval(IDS);
		setInfoScrol();
		IDS = setInterval(Scrolling, 50);
	} else {
		b_scroll = false;
		clearInterval(IDS);
		setInfoOneByOne();
		IDS = setInterval(oneByOne, 3000);
	}
	if ((mini.txtScroll1.txt0 == "") or (mini.PlayMusic._visible == true) or (mini._visible == false)) {
		clearInterval(IDS);
	}
}
// load current image playing
//====================
function loadImageCurrentTrack(val) {
	if (val != "None") {
		if (tmpImgPath != val) {
			mini.img1.loadMovie(val);
		}
		mini.img1._visible = true;
		mini.CD._visible = false;
		tmpImgPath = val;
	} else {
		tmpImgPath = "";
		mini.img1._visible = false;
		mini.CD._visible = true;
		mini.img1.unloadMovie();
	}
}
function SelectPlayerTrack(newIndex, durationLength) {
	ChangeCurIndexTrack = newIndex;
	if (durationLength != undefined) {
		mini.seekbar.txtLength.text = second2Time(int(durationLength));
		mini.seekbar.durationLength = durationLength;
	}
}
// function get label next
//====================
function getLabelNext(str) {
	aa = new Array();
	aa = String(str).split("//\\\\");
	if (tmplblNext != str) {
		aaa = new TextFormat();
		aaa.font = aa[1];
		aaa.size = int(aa[2])-10;
		if ((String(aa[1]).substr(0, 5)) == "Limon") {
			aaa.size = font_size_next_limon;
		} else {
			aaa.size = font_size_next_other;
		}
		mini.lblNext.txt0.text = aa[0];
		mini.lblNext.txt0.autoSize = true;
		mini.lblNext.txt0.setTextFormat(aaa);
		mini.lblNext.txt0._y = -(int(mini.lblNext.txt0.textHeight)/2);
	}
	tmplblNext = str;
}
// cut string for next track
//====================
function setNextTrack(val) {
	if (val != "") {
		aa = new Array();
		aa = String(val).split("//\\\\");
		get_next_track(aa[0], aa[1], aa[2]);
		mini.lblNext._visible = true;
		mini.lblNext._y = Next_top;
		//displayInfoTrackPlaying();
		clearInterval(ID_DisplayInfoTrackPlaying);
		ID_DisplayInfoTrackPlaying = setInterval(displayInfoTrackPlaying, 1000*5);
		mini.txtInfo._visible = false;
	} else {
		mini.lblNext._visible = false;
		displayInfoType_str = "Next";
		displayInfoTrackPlaying();
	}
}
// cut string for next track
//====================
function get_next_track(strN, strF, strS) {
	var ddd = "";
	if (String(strF).substr(0, 5) == "Limon") {
		ddd = ">>>";
	} else {
		ddd = "...";
	}
	var strTrackNext = strN;
	mini.lblNext._visible = false;
	SText = new TextFormat();
	SText.font = strF;
	if ((String(strF).substr(0, 5)) == "Limon") {
		SText.size = font_size_next_limon;
	} else {
		SText.size = font_size_next_other;
	}
	mini.txtTmpNext.text = strTrackNext;
	mini.txtTmpNext.autoSize = true;
	mini.txtTmpNext.setTextFormat(SText);
	L = nextLeng-int(mini.lblNext.txt0.textWidth);
	if (int(mini.txtTmpNext._width)>int(L)) {
		for (var i = 1; i<=String(strTrackNext).length; i++) {
			mini.txtTmpNext.text = "";
			strtmp = strTrackNext.substr(0, i)+ddd;
			mini.txtTmpNext.text = strtmp;
			mini.txtTmpNext.setTextFormat(SText);
			mini.txtTmpNext.autoSize = true;
			if (int(mini.txtTmpNext._width)>int(L)) {
				mini.lblNext.txt1._x = mini.lblNext.txt0._x+mini.lblNext.txt0.textWidth;
				mini.lblNext.txt1.text = String(strtmp);
				mini.lblNext.txt1.setTextFormat(SText);
				mini.lblNext.txt1.autoSize = true;
				mini.lblNext.txt0._y = -(int(mini.lblNext.txt0.textHeight)/2);
				mini.lblNext.txt1._y = -(int(mini.lblNext.txt1.textHeight)/2);
				break;
			}
		}
	} else {
		mini.lblNext.txt1._x = mini.lblNext.txt0._x+mini.lblNext.txt0.textWidth;
		mini.lblNext.txt1.text = String(strN);
		mini.lblNext.txt1.setTextFormat(SText);
		mini.lblNext.txt1.autoSize = true;
		mini.lblNext.txt0._y = -(int(mini.lblNext.txt0.textHeight)/2);
		mini.lblNext.txt1._y = -(int(mini.lblNext.txt1.textHeight)/2);
	}
}
// Display information of current track playing
//====================
var displayInfoType_str = "Next";
function displayInfoTrackPlaying() {
	var split_array = new Array();
	var sFont = new TextFormat();
	//' 
	sFont.size = font_size_next_other;
	//	'
	split_array = String(tmpTrackInfo).split("//\\\\");
	if (displayInfoType_str == "Next") {
		displayInfoType_str = "Bitrate";
		mini.lblNext._visible = false;
		mini.txtInfo.text = set_dot_dot(eval("mini.txtInfo"), split_array[4], sFont, dot_dot);
		mini.txtInfo._visible = true;
	} else if (displayInfoType_str == "Bitrate") {
		displayInfoType_str = "Position";
		mini.lblNext._visible = false;
		mini.txtInfo.text = set_dot_dot(eval("mini.txtInfo"), "Position: "+split_array[0], sFont, dot_dot);
		mini.txtInfo._visible = true;
	} else if (displayInfoType_str == "Position") {
		if (mini.ShuffleTrue._visible == false) {
			displayInfoType_str = "Next";
			mini.txtInfo._visible = false;
			mini.lblNext._visible = true;
		} else {
			displayInfoType_str = "Bitrate";
			mini.lblNext._visible = false;
			mini.txtInfo.text = set_dot_dot(eval("mini.txtInfo"), split_array[4], sFont, dot_dot);
			mini.txtInfo._visible = true;
		}
	}
	mini.txtInfo.textColor = FontColor;
	mini.txtInfo.setTextFormat(sFont);
	//
	mini.txtInfo._y = Number(next_top)-Number(mini.txtInfo._height/2);
	clearInterval(ID_DisplayInfoTrackPlaying);
	ID_DisplayInfoTrackPlaying = setInterval(displayInfoTrackPlaying, 1000*5);
}
// Volume Bar
//====================
function setVolumeDefault(val) {
	mini.volbar.txtVol.text = val;
	mini.volbar.knob._width = int((int(val)*volWidth)/100);
}
function setVolumeUPDown(val) {
	mini.volbar.knob._width = int(val);
	mini.volbar.txtVol.text = int((int(val)*100)/volWidth);
	return int(mini.volbar.txtVol.text);
}
function setKeyVolUp() {
	m = int(int(mini.volbar.txtVol.text)%5);
	if (m == 0) {
		v = int(mini.volbar.txtVol.text)+5;
	} else {
		v = int(mini.volbar.txtVol.text)+(5-m);
	}
	if (int(v)>=100) {
		v = 100;
	}
	mini.MuteTrue._visible = false;
	mini.MuteFalse._visible = true;
	//control_mini_player("Volume", int(v), "true");
	control_syncronize("volume","mini","Volume|:|" + int(v));
}
function setKeyVolDown() {
	m = int(int(mini.volbar.txtVol.text)%5);
	if (m == 0) {
		v = int(mini.volbar.txtVol.text)-5;
	} else {
		v = int(mini.volbar.txtVol.text)-m;
	}
	if (int(v)<=0) {
		v = 0;
	}
	//control_mini_player("Volume", int(v), "true");
	control_syncronize("volume","mini","Volume|:|" + int(v));
}
// sent to vb
//====================
function command(com, args) {
	fscommand("mini", com+"|:|"+args);
	if (clientType == remotePlaylist or clientType == clonePlayBack) {
		fscommand("client", "0&&&fscommand||mini|~|"+com+"|:|"+args);
	}
}
// function change scroll
//====================
function fn_doubleClick() {
	//trace(db);
	db = 0;
	clearInterval(doubleClick);
}
function ChangeTextScrollInformation() {
	if (b_scroll == true) {
		setScrollType("False");
		sc = 1;
		b_scroll = false;
		command("chageTextScroll", "false");
	} else {
		setScrollType("True");
		b_scroll = true;
		command("chageTextScroll", "true");
	}
}
// function fade image
//====================
function fadeObject(obj1, obj2, P) {
	imgN1 = obj1;
	imgN2 = obj2;
	if ((obj1._alpha<20) and (obj2._alpha>80)) {
		obj1._alpha = 0;
		obj2._alpha = 100;
		eval(obj1).loadMovie(P);
		fadeimgN1 = false;
		fadeimgN2 = true;
	} else if ((obj1._alpha>80) and (obj2._alpha<20)) {
		obj1._alpha = 100;
		obj2._alpha = 0;
		eval(obj2).loadMovie(P);
		fadeimgN1 = true;
		fadeimgN2 = false;
	}
}
function imgFade() {
	if (fadeimgN1 == true) {
		imgN1._alpha -= 20;
		imgN2._alpha += 20;
		if (imgN1._alpha<0) {
			imgN1.unloadMovie();
			imgN1._alpha = 0;
			fadeimgN1 = false;
		}
		if (imgN2._alpha>100) {
			imgN2._alpha = 100;
		}
		
	} else if (fadeimgN2 == true) {
		imgN1._alpha += 20;
		imgN2._alpha -= 20;
		if (imgN2._alpha<0) {
			imgN2.unloadMovie();
			imgN2._alpha = 0;
			fadeimgN2 = false;
		}
		if (imgN1._alpha>100) {
			imgN1._alpha = 100;
		}
	}
}
/*************************************************************************************************************/
/* handle 
/*************************************************************************************************************/
// changeScroll
//====================
var db = 0;
mini.changeScroll.onPress = function() {
	db += 1;
	if (db>1) {
		ChangeTextScrollInformation();
		db = 0;
	} else {
		doubleClick = setInterval(fn_doubleClick, 200);
	}
};
// fullscreen
//====================
mini.fullscreen.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	//command("FullScreen", true);
	fscommand("mini", "FullScreen|:|true");
	//send_event("0&&&fscommand||Click|~|" + this,false);
};
mini.fullscreen.onRollOver = function() {
	mini_out = false;
	DisplayTooltip(this, "txtTooltip", "Fullscreen Player (Ctrl + U)", SHTT, -181, 20);
	fscommand("hide/show_cmdFull",true);
};
mini.fullscreen.onRollOut = function() {
	mini_out = true;
	HideTooltip("txtTooltip");
};
// seekbar
//====================
mini.seekbar.ButtonSeek.onRelease = function() {
	var l = this._width;	
	var m = int(mini.seekbar._xmouse);
	var p = (m*100)/l;
	mini.seekbar.knob._width = m;	
	//control_mini_player("seek", int(mini.seekbar._xmouse), "true");
	control_mini_player("seek", p, "true");
};
mini.seekbar.ButtonSeek.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Seek (P.Down)(P.Up)", SHTT, -145/2, 20);
};
mini.seekbar.ButtonSeek.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// volbar
//====================
mini.volbar.ButtonVol.onRelease = function() {
	var vv = setVolumeUPDown(int(mini.volbar._xmouse));
	ClickVolumeSound(vv, int(mini.volbar._xmouse));
	//	fscommand("client", "0&&&function||ClickVolumeSound|~|"+vv+"|~|"+int(mini.volbar._xmouse));
};
function ClickVolumeSound(int_volume, xmouse) {
	int_volume = int(int_volume);
	if (mini.MuteTrue._visible == true) {
		if (int(xmouse)>int(mini.volbar.knob._width)) {
			mini.MuteTrue._visible = false;
			mini.MuteFalse._visible = true;
		} else {
			mini.MuteTrue._visible = true;
			mini.MuteFalse._visible = false;
		}
	}
	//control_mini_player("Volume", int_volume, "true");
	control_syncronize("volume","mini","Volume|:|" + int_volume);
}
mini.volbar.ButtonVol.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Volume ( - )( + )", SHTT, -107/2, -20);
};
mini.volbar.ButtonVol.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// PlayMusic
//====================
mini.PlayMusic.ButtonPlay.onRelease = function() {
	mini.PauseMusic.ButtonPause.onRollOver();
	control_mini_player("Play", "true", "true");
};
mini.PlayMusic.ButtonPlay.onRollOver = function() {
	SelectButton("mini.PlayMusic.MoviePlay");
	DisplayTooltip(this, "txtTooltip", "Play ( X )", SHTT, -63/2, 20);
};
mini.PlayMusic.ButtonPlay.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// PauseMusic
//====================
mini.PauseMusic.ButtonPause.onRelease = function() {
	mini.PlayMusic.ButtonPlay.onRollOver();
	control_mini_player("Pause", "true", "true");
};
mini.PauseMusic.ButtonPause.onRollOver = function() {
	SelectButton("mini.PauseMusic.MoviePause");
	DisplayTooltip(this, "txtTooltip", "Pause ( C )", SHTT, -79/2, 20);
};
mini.PauseMusic.ButtonPause.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// StopMusic
//====================
mini.StopMusic.ButtonStop.onRelease = function() {
	control_mini_player("Stop", "true", "true");
};
mini.StopMusic.ButtonStop.onRollOver = function() {
	SelectButton("mini.StopMusic.MovieStop");
	DisplayTooltip(this, "txtTooltip", "Stop ( V )", SHTT, -65/2, 20);
};
mini.StopMusic.ButtonStop.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// PreviousMusic
//====================
mini.PreviousMusic.ButtonPrevious.onRelease = function() {
	if (_global.boolMouseDown == false) {
		return;
	}
	_global.boolMouseDown = false;
	control_mini_player("Previous", "true", "true");
};
mini.PreviousMusic.ButtonPrevious.onRollOver = function() {
	SelectButton("mini.PreviousMusic.MoviePrevious");
	DisplayTooltip(this, "txtTooltip", "Previous ( Z )", SHTT, -91/2, 20);
};
mini.PreviousMusic.ButtonPrevious.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// NextMusic
//====================
mini.NextMusic.ButtonNext.onRelease = function() {
	if (_global.boolMouseDown == false) {
		return;
	}
	_global.boolMouseDown = false;
	control_mini_player("Next", "true", "true");
};
mini.NextMusic.ButtonNext.onRollOver = function() {
	SelectButton("mini.NextMusic.MovieNext");
	DisplayTooltip(this, "txtTooltip", "Next ( B )", SHTT, -65/2, 20);
};
mini.NextMusic.ButtonNext.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// AddMusic
//====================
mini.AddMusic.ButtonAddMusic.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	//command("AddMusic", true);
	fscommand("mini", "AddMusic|:|true");
};
mini.AddMusic.ButtonAddMusic.onRollOver = function() {
	SelectButton("mini.AddMusic.MovieAddMusic");
	DisplayTooltip(this, "txtTooltip", "Add File( F )", SHTT, -60/2, 20);
};
mini.AddMusic.ButtonAddMusic.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// PlayerPage
//====================
mini.PlayerPage.ButtonPlayerPage.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	//command("PlayerPage", true);
	fscommand("mini", "PlayerPage|:|true");
};
mini.PlayerPage.ButtonPlayerPage.onRollOver = function() {
	SelectButton("mini.PlayerPage.MoviePlayerPage");
	DisplayTooltip(this, "txtTooltip", "Add Folder(D)", SHTT, -155/2, 20);
};
mini.PlayerPage.ButtonPlayerPage.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ShuffleTrue
//====================
mini.ShuffleTrue.ButtonShuffle.onRelease = function() {
	mini.ShuffleFalse.ButtonShuffle.onRollOver();
	control_mini_player("Shuffle", "false", "true");
};
mini.ShuffleTrue.ButtonShuffle.onRollOver = function() {
	SelectButton("mini.ShuffleTrue.MovieShuffle");
	DisplayTooltip(this, "txtTooltip", "Shuffle ( S )", SHTT, -81/2, -20);
};
mini.ShuffleTrue.ButtonShuffle.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ShuffleFalse
//====================
mini.ShuffleFalse.ButtonShuffle.onRelease = function() {
	mini.ShuffleTrue.ButtonShuffle.onRollOver();
	control_mini_player("Shuffle", "true", "true");
};
mini.ShuffleFalse.ButtonShuffle.onRollOver = function() {
	SelectButton("mini.ShuffleFalse.MovieShuffle");
	DisplayTooltip(this, "txtTooltip", "Shuffle ( S )", SHTT, -81/2, -20);
};
mini.ShuffleFalse.ButtonShuffle.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// RepeatTrue
//====================
mini.RepeatTrue.ButtonRepeat.onRelease = function() {
	mini.RepeatFalse.ButtonRepeat.onRollOver();
	control_mini_player("Repeat", "false", "true");
};
mini.RepeatTrue.ButtonRepeat.onRollOver = function() {
	SelectButton("mini.RepeatTrue.MovieRepeat");
	DisplayTooltip(this, "txtTooltip", "Repeat ( R )", SHTT, -84/2, -20);
};
mini.RepeatTrue.ButtonRepeat.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// RepeatFalse
//====================
mini.RepeatFalse.ButtonRepeat.onRelease = function() {
	mini.RepeatTrue.ButtonRepeat.onRollOver();
	control_mini_player("Repeat", "true", "true");
};
mini.RepeatFalse.ButtonRepeat.onRollOver = function() {
	SelectButton("mini.RepeatFalse.MovieRepeat");
	DisplayTooltip(this, "txtTooltip", "Repeat ( R )", SHTT, -84/2, -20);
};
mini.RepeatFalse.ButtonRepeat.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// MuteTrue
//====================
mini.MuteTrue.ButtonMute.onRelease = function() {
	mini.MuteFalse.ButtonMute.onRollOver();
	//control_mini_player("Mute", "false", "true");
	control_syncronize("Mute","mini","Mute|:|false");
};
mini.MuteTrue.ButtonMute.onRollOver = function() {
	SelectButton("mini.MuteTrue.MovieMute");
	DisplayTooltip(this, "txtTooltip", "Mute ( M )", SHTT, -68/2, -20);
};
mini.MuteTrue.ButtonMute.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// MuteFalse
//====================
mini.MuteFalse.ButtonMute.onRelease = function() {
	mini.MuteTrue.ButtonMute.onRollOver();
	//control_mini_player("Mute", "true", "true");
	control_syncronize("Mute","mini","Mute|:|true");
};
mini.MuteFalse.ButtonMute.onRollOver = function() {
	SelectButton("mini.MuteFalse.MovieMute");
	DisplayTooltip(this, "txtTooltip", "Mute ( M )", SHTT, -68/2, -20);
};
mini.MuteFalse.ButtonMute.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// Voice of singer
//====================
mini.voice.ButtonVoice.onRelease = function() {
	//control_mini_player("Mute", "true", "true");
	karaokeVoice(!(mini.voice.ico_true._visible));
	fscommand("karaoke_voice",mini.voice.ico_true._visible);
};
mini.voice.ButtonVoice.onRollOver = function() {
	SelectButton("mini.voice.MovieVoice");
	DisplayTooltip(this, "txtTooltip", "Karaoke Voice", SHTT, -68/2, -20);
};
mini.voice.ButtonVoice.onRollOut = function() {
	HideTooltip("txtTooltip");
};
function karaokeVoice(str){
	str = String(str);
	if (str == "true"){
		mini.voice.ico_true._visible = true;
		mini.voice.ico_false._visible = false;
	} else {
		mini.voice.ico_true._visible = false;
		mini.voice.ico_false._visible = true;
	}
}
//----------------------------------------------------------------------------------------------------
function setSeekTime(seekValue) {
	var seekSecond = int((Number(seekValue)/mini.seekbar._width)*Number(mini.seekbar.durationLength));
	mini.seekbar.txtCurrent.text = second2Time(seekSecond);
	mini.seekbar.knob._width = Number(seekValue);
	delete (seekSecond);
}
function setDefault(vValue) {
	var bbbb = false;
	bbbb = (tmpTrackInfo == "");
	tmpTrackInfo = vValue;
	if (bbbb == true) {
		bbbb = false;
		displayInfoType_str = "Next";
		displayInfoTrackPlaying();
	}
}
function second2Time(value) {
	value = Number(value);
	valMinute = int(value/60);
	valSecond = value%60;
	if (valMinute<10) {
		valMinute = "0"+valMinute;
	}
	if (valSecond<10) {
		valSecond = "0"+valSecond;
	}
	delete (value);
	return valMinute+":"+valSecond;
}
function setVolumeValue(volumeValue) {
	mini.volbar.txtVol.text = volumeValue;
	mini.volbar.knob._width = int((volumeValue*mini.volbar._width)/100);
	TrackShow.setTrackShow(" Volume "+volumeValue+"% ");
	delete (volumeValue);
}
function setCurrentImage(vValue) {
	if (vValue == "None") {
		tmpImg = "";
		mini.CD._visible = true;
		mini.img1._visible = false;
		mini.img2._visible = false;
		mini.img1._alpha = 100;
		mini.img2._alpha = 0;
	} else {
		mini.CD._visible = false;
		if (tmpImg != vValue) {
			tmpImg = vValue;
			mini.img1._visible = true;
			mini.img2._visible = true;
			fadeObject(mini.img1, mini.img2, vValue);
		}
	}
}
