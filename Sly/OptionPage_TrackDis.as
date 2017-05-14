//====================
var tmpTrackInfo = "";
var	WindowMedia = 0;
var	Winamp = 1;
var	nero = 2;
var	VideoLan = 3;
var	MediaPlayer = 4;
var	PlayNone = 5;
var	PowerDVD=6;

function setVB(val) {
	var spl = new Array();
	spl = String(val).split("|%|");
	click_self = false;

	switch (spl[0]) {
	case "AdvPath" :
		BackRipAndPlay.TextMainPath.text =spl[1];
		break;
	case "LinkingPlaylistPath" :
		BackCountry.remote.BrowsePath.remotePlaylistPath.text=spl[1];
	 	break;
	case "isFirstClient":
	     
             BackCountry.remote._visible =(spl[2]=="true");
	     BackCountry.remote.first_remote.txtNum.text = spl[1];
	     BackCountry.remote.first_remote._visible = (spl[2]=="true");
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
		if ((clientType == serverMode)and(arg_spl[0] == "mini")){
			var vvvv = new Array();
			vvvv = String(arg_spl[1]).split("|:|");
			send_event("mini&&&fscommand||mini|~|"+ arg_spl[1] + "||" + vvvv[0] + "||"+ vvvv[1],true);
		}else if ((clientType == serverMode)and((arg_spl[0] == "KeyPressed")or(arg_spl[0] == "Key"))){
			send_event("mini&&&fscommand||KeyPressed|~|"+ arg_spl[1],true);
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
		_global.boolMouseDown = true;
		eval(spl[1]).onRelease();
		break;
	case "clientType" :
		clientType = spl[1];
		BackCountry.remote.BrowsePath._visible= (clientType == serverMode);
		BackCountry.remote._visible= (clientType == serverMode);
		break;
	case "ShowPopupInfo":
		if(Boolean(spl[1])){
			set_popupinfo_type(0);
		}else{
			set_popupinfo_type(1);
		}
		break;
	case "setOffsetEnabled": //changed
		BackRipAndPlay.ButtonOffset.Selected._visible=(spl[1].toLowerCase()=="true");
		break;
	case "TrackShow" :
		TrackShow.setTrackShow(spl[1]);
		break;
	case "default" :
		tmpTrackInfo = spl[1];
		break;
	case "VLCExtension":
		BackRipAndPlay.txtVLCExtension.text=spl[1];
		break;
	case "PowerDVDExtension":
		BackRipAndPlay.txtPowerDVDExtension.text=spl[1];
		break;
	case "DaemonDrive":
		BackRipAndPlay.txtDaemonDrive.text=spl[1];
		break;
	case "ripWith" :
		if (spl[1] == "1") {
			BackRipAndPlay.ButtonRipWmp.Selected._visible = false;
			BackRipAndPlay.ButtonRipiTunes.Selected._visible = true;
			BackRipAndPlay.ButtonRipWmp.enabled = true;
			BackRipAndPlay.ButtonRipiTunes.enabled = false;
		} else {
			BackRipAndPlay.ButtonRipWmp.Selected._visible = true;
			BackRipAndPlay.ButtonRipiTunes.Selected._visible = false;
			BackRipAndPlay.ButtonRipWmp.enabled = false;
			BackRipAndPlay.ButtonRipiTunes.enabled = true;
		}
		break;
	case "DVDControlType":
	//	if(spl[1]==0){
			//BackRipAndPlay.ButtonTop.onRelease();
		//	set_dvdcontrol_type(0)
		//}else{
//			BackRipAndPlay.ButtonBottom.onRelease();
//			set_dvdcontrol_type(1)
			set_dvdcontrol_type(spl[1]);
	//	}
		break;
	case "Popupinfo":
	  	if(spl[1]==0){
			BackRipAndPlay.ButtonTurnOff.onRelease();
		}else{
			BackRipAndPlay.ButtonTurnOn.onRelease();
		}
		break;
	case "streamType" :
		BackCountry.fileType.setFileType(spl[1]);
		break;
	case "AutoPlay" :
		BackRipAndPlay.ButtonAutoplay.Selected._visible = (spl[1].toLowerCase()=="true");
		break;
	case "AutoPlayMPC" :
		BackRipAndPlay.ButtonAutoplayMPC.Selected._visible = (spl[1].toLowerCase()=="true");
		break;
	case "AutoPlayPowerDVD" :
		BackRipAndPlay.ButtonAutoplayPowerDVD.Selected._visible = (spl[1].toLowerCase()=="true");
		break;
	case "SingerSong" :
		BackRipAndPlay.ButtonSingerSong.Selected._visible = (spl[1].toLowerCase()=="true");
		break;
	case "playWith" :
		if (spl[1] == MediaPlayer) {
			BackRipAndPlay.ButtonWinamp.Selected._visible = true;
			BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
			BackRipAndPlay.ButtonWmp.Selected._visible = false;
			BackRipAndPlay.ButtonShowtime.Selected._visible = false;
			
			hide_show_monitor_checkbox(false);
		} else if(spl[1]== WindowMedia ){
			
			BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
			BackRipAndPlay.ButtonWmp.Selected._visible = true;
			BackRipAndPlay.ButtonWinamp.Selected._visible = false;
			BackRipAndPlay.ButtonShowtime.Selected._visible = false;
			hide_show_monitor_checkbox(true);
		} else if(spl[1]== PowerDVD ){
			BackRipAndPlay.ButtonPowerDVD.Selected._visible = true;
			BackRipAndPlay.ButtonWmp.Selected._visible = false;
			BackRipAndPlay.ButtonWinamp.Selected._visible = false;
			BackRipAndPlay.ButtonShowtime.Selected._visible = false;
			hide_show_monitor_checkbox(true);
		}
		else{
			BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
			BackRipAndPlay.ButtonWmp.Selected._visible = false;
			BackRipAndPlay.ButtonWinamp.Selected._visible = false;
			BackRipAndPlay.ButtonShowtime.Selected._visible = true;
			hide_show_monitor_checkbox(true);
		}
		break;
	case "setExternalPowerDVD":
		BackRipAndPlay.ButtonExternalPowerDVD.Selected._visible = spl[1] == "True"
		break;
	case "setBrowseByFolder":
		BackRipAndPlay.ButtonBrowseFolder.Selected._visible = spl[1] == "True"
		break;
	case "setDownloadAll" :
		BackRipAndPlay.ButtonDownloadAll.selected._visible = (spl[1] == "True");
		break;
	case "setReencode" :
		BackRipAndPlay.ButtonReEncode.selected._visible = (spl[1] == "True");
		break;
	case "clone_display" :
		BackRipAndPlay.ButtonCloneAndDisplay.Selected._visible = (spl[1] == "True");
		break;
	case "clone_playback" :
		BackRipAndPlay.ButtonCloneOnly.Selected._visible = (spl[1] == "True");
		break;
	case "clone_independent" :
		BackRipAndPlay.ButtonIndependent.Selected._visible = (spl[1] == "True");
		break;
	case "Remotecontrol":
		BackRipAndPlay.ButtonremoteControl.Selected._visible = (spl[1] == "True");
		break;
	case "friend_playlist" :
//=================8 New
   	case "allow_connection" :
		BackCountry.ButtonAllow.Selected._visible  = (spl[1] == "True");
		break;
	case "allow_connection_by_manual" :
		BackCountry.ButtonAllow.Selected._visible  = (spl[1] == "True");
		break;	
	case "deny_all_connection" :
		BackCountry.ButtonDeny.Selected._visible  = (spl[1] == "True");
		break;
	case "clone_display_and_playback" :
		BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible  = (spl[1] == "True");
		break;
    	case "clone_play_back_only" :		
		BackCountry.ButtonClonePlaybackOnly.Selected._visible  = (spl[1] == "True");
		break;
	case "independent" :	
		BackCountry.ButtonIndependent.Selected._visible  = (spl[1] == "True");
		break;
	case"syn_volume" :
		BackCountry.ButtonSynVolume.Selected._visible  = (spl[1] == "True");
		break;
	case"copy_slideshow" :
		BackCountry.ButtonCopySlideshow.Selected._visible  = (spl[1] == "True");
		break;
	case"syn_slideshow" :
        		BackCountry.ButtonSynSlideshow.Selected._visible  = (spl[1] == "True");
		break;
		//=================
	case "localLink" :
		BackCountry.ButtonLocalLink.Selected._visible  = (spl[1] == "True");
		BackCountry.fileType._visible  = (spl[1] == "True");
		break;
	case "access_password" :
		BackCountry.ButtonAccessPassword.Selected._visible  = (spl[1] == "True");
		break;
	case "syn_vol" :
		BackRipAndPlay.ButtonSyn_vol.Selected._visible = (spl[1] == "True");
		break;
	case "ChangeTrackTitleStyle"	:
		if(spl[1]==1){
			BackRipAndPlay.TextTrackTitleStyle.text="Production"
		}else{
			BackRipAndPlay.TextTrackTitleStyle.text="Artist"
		}
		break;
	case "Change_vol" :
		BackRipAndPlay.ButtonSyn_vol.Selected._visible = (spl[1] == "True");
		break;
	case "allow_slideshow" :
		BackSlideShow.ButtonAllowSlideshow.chk._visible = (spl[1] == "True");
		break;
	case "syn" :
		BackSlideShow.ButtonSyn.chk._visible = (spl[1] == "True");
		break;
	case "AutoClientConnection" :
		//0(Disable),1,2,3,4''cloneDisplay,remotePlaylist,remoteControl,independentMode
		if(spl[1] > 0){
			BackCountry.ButtonAutoClientConnect.Selected._visible  = true;
			BackCountry.ButtonAutoDisplayAndPlayback.Selected._visible  = (spl[1] == 1);
			BackCountry.ButtonAutoPlayback.Selected._visible  = (spl[1] == 2);
			BackCountry.ButtonAutoIndependent.Selected._visible  =(spl[1] == 4);
			BackCountry.ButtonAutoRemoteControl.Selected._visible  = (spl[1] == 3);
		}else{
			//Default one
			BackCountry.ButtonAutoClientConnect.Selected._visible  = false;
			BackCountry.ButtonAutoRemoteControl.Selected._visible  = true;
			BackCountry.ButtonAutoDisplayAndPlayback.Selected._visible  = false;
			BackCountry.ButtonAutoPlayback.Selected._visible  = false;
			BackCountry.ButtonAutoIndependent.Selected._visible  =false;
		}
		Break;
	case "ResizeFromServer":
		BackRipAndPlay.ButtonResize.Selected._visible = (spl[1] == "True");
		break;
	case "resize_image_server" :
		BackSlideShow.ButtonResize.chk._visible = (spl[1] == "True");
		break;
	case "microStyle" :
		set_micro_style(int(spl[1]));
		break;
	case "monitor" :
		turnMonitor = spl[1];
		setMonitor(turnMonitor);
		break;
	case "MonitorCount" :
	          	MonitorCount = spl[1];
		break;
	case "SlyMonitor" :
		BackripAndPlay.TextProgram.text = spl[1];
		break;
	case "VideoMonitor" :
		BackripAndPlay.TextVideo.text = spl[1];
		break;
	case "trackType" :
		set_track_type(int(spl[1]));
		break;
	case "priorityExtension" :
		set_priority_scan(spl[1]);
		break;
	case "priorityMplayer":
	    	set_priority_Mplayer(spl[1]);
		break;
	case "PicPath" :
		MainPathImage = spl[1];
		BackCountry.picPath_txt.text = MainPathImage;
		break;
	case "MPlayer" :
		MPlayerPath	  = spl[1];
		BackCountry.mplayerpart_txt.text = MPlayerPath;
		break;
	case "resize_image" :		
		resizeImage = int(spl[1]);
		set_resize_image(resizeImage);
		break;
	case "streamFile" :
		set_stream(spl[1]);
		break;
	case "playchapterFile" :
		set_chapter(spl[1]);
		break;
	case "setSlidePath" :
		ImageSlidePath = spl[1];
		BackSlideShow.txtImage.text = ImageSlidePath;
		break;
	case "popup_exit" :
		BackTheme.ButtonPopupExit.Selected._visible = (spl[1] == "True");
		break;
	case "change_vol" :
		BackRipAndPlay.ButtonChange_vol.Selected._visible = (spl[1] == "True");
		break;
	case "auto_new_database":
		BackAlbum.ButtonCheckDatabase.Selected._visible = (spl[1] == "True");
		break;
	case "Rating":
		BackAlbum.ButtonCheckDatabase.Selected._visible = (spl[1] == "True");
		break;
	case "popup_connect" :
		popup_connect.shows(spl[1]);
		break;
	case "permission" :
		str_permission = spl[1];
		break;
	case "default_per" :
		if (spl[1] == "true"){
			BackCountry.ButtonAllow.Selected._visible = true;
			BackCountry.ButtonAllowByManual.Selected._visible = false;
			BackCountry.ButtonDeny.Selected._visible = false;
			display_permission(str_permission);
		} else {
			BackCountry.ButtonAllow.Selected._visible = false;
			BackCountry.ButtonAllowByManual.Selected._visible = true;
			BackCountry.ButtonDeny.Selected._visible = false;
		}
		break;
	case "deny" :
		if (spl[1] == "true"){
			BackCountry.ButtonAllow.Selected._visible = false;
			BackCountry.ButtonAllowByManual.Selected._visible = false;
			BackCountry.ButtonDeny.Selected._visible = true;
		} else {
			BackCountry.ButtonDeny.Selected._visible = false;
		}
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
function getvb() {
}
this.addProperty("vb", getvb, setVB);
