//====================
var tmpTrackInfo = "";
function setVB(val) {
	var spl = new Array();
	spl = String(val).split("|%|");
	click_self = false;

	switch (spl[0]) {
	case "RequestSize" :
		if(BackNormal._visible){
		        fscommand("ShowTextSearch","yes");
		}
	break;
	case "reloadSearchPage" : 
		//sith 27/10/06
		LoadXmlLanguage (spl[1]);
		break;
	case "setMusicNote":
		MusicNote=spl[1];
		eval(TrackName).MusicNote.RedLine._visible = MusicNote=="true";
		break;
	case "SetSearchCountry":
		MainLevel=1;			//Clear previous search result
		resultSearch.length=0;		//
		ArrowBar._visible=false;		// invisible arrow
		VolBar._visible=false;		//vol bar
		eval(TrackName)._visible=false;		//track page
		eval(NameAlbum)._visible=false;		//album page
		BackAlbumPic._visible=false;			//coverart album picture
		break;
	case "changeLanguage":
		ChangeLan=spl[1];
		Language_Click(ChangeLan);
		break;
		// changed sith 14-06-06	
	case "hideBack": //sith 21/10/06
		BackNormal._visible = false;
		BackAdvance._visible =false;
		fscommand("ShowTextSearch","no");
		break;
	case "HideMenu": //se 03-11-2006
		if(Menu._visible){
			Topbar.ButtonX.OnRollOver();
			Menu._visible=false;
			MenuMISC._visible=false;
		}
		break;
	case "Variable" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		set(arg_spl[0], arg_spl[1]);
		break;
	case "setOffsetEnabled": //change retreive offsetEnabled
		offsetEnabled=(spl[1].toLowerCase()=="true");
		eval(trackName).chkOffset.Selected._visible =offsetEnabled;
		eval(trackName).offset._visible =(eval(trackName).MainTitle._visible) ? offsetEnabled : false;
		break;
	case "AudioChannel":
		playAudioChannel=spl[1];
		eval(TrackName).AudioChannel._visible=(eval(trackName).MainTitle._visible) ? (databaseType==8 || databaseType==4) : false;//display only in karaoke mode
		eval(TrackName).AudioChannel.setState(playAudioChannel);	//State for play movie
		break;
	case "PlayChapterState":
		playchapterfile=spl[1];
		eval(TrackName).AddToPlay._visible=(eval(trackName).MainTitle._visible) ? (databaseType==8 || databaseType==4) : false;//display only in karaoke mode
		eval(TrackName).AddToPlay.setState(eval(TrackName).AddToPlay.getState());	//State for play movie
		break;
	case "setOffsetEnabled": //change retreive offsetEnabled
		offsetEnabled=(spl[1].toLowerCase()=="true");
		eval(TrackName).chkOffset.Selected._visible =offsetEnabled;
		eval(TrackName).offset._visible =(eval(trackName).MainTitle._visible) ? offsetEnabled : false;
		break;
	case "UnloadSwf" :
		UnloadItSelf(val);
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
	case "fscommand" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		fscommand(arg_spl[0], arg_spl[1]);
		if ((clientType == serverMode)and(arg_spl[0] == "mini")){
			var vvvv = new Array();
			vvvv = String(arg_spl[1]).split("|:|");
			send_event("mini&&&fscommand||mini|~|"+ arg_spl[1] + "||" + vvvv[0] + "||"+ vvvv[1],true);
		}else if ((clientType == serverMode)and((arg_spl[0] == "KeyPressed")or(arg_spl[0] == "Key"))){
			send_event("mini&&&fscommand||KeyPressed|~|"+ arg_spl[1],true);
		}
		break;
	case "clientType" :
		clientType = spl[1];
		break;
	case "RefreshAlbum":
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("~");
		refreshScanAlbum(arg_spl[2],arg_spl[0]);
		click_volbars(IndexNameVol,true);
		break;
	case "TrackShow" :
		TrackShow.setTrackShow(spl[1]);
		break;
	case "default" :
		tmpTrackInfo = spl[1];
		break;
	case "popup_connect" :
		popup_connect.shows(spl[1]);
		break;
	case "I":
		if(AddTrackBox._visible){
			AddTrackBox._visible=false;
			objOnfocus=InputText;
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
function getvb() {
}
this.addProperty("vb", getvb, setVB);
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