//seng
var CountryName = new Array();
function Permission() {
	arr = new Array("BackCountry.ButtonCloneDisplayAndPlayback", "BackCountry.ButtonClonePlaybackOnly", "BackCountry.ButtonIndependent", "BackCountry.ButtonSynVolume", "BackCountry.ButtonCopySlideshow", "BackCountry.ButtonSynSlideshow");
	var p;
	for (var i = 0; i<6; i++) {
		p = (eval(arr[i]).Selected._visible) ? p=p+""+(i+1) : p=p;
	}
	str_permission = p;
	fscommand("Permission", p);
}
var FirstLoad;
function SplCountry(str) {
	CountryName.length = 0;
	var temp1 = str.split("%%");
	for (var j = 0; j<temp1.length; j++) {
		var temp2 = temp1[j].split("%");
		CountryName[CountryName.length] = temp2[1];
	}
	FirstDisplayCountry(CountryName.length);
}
function FirstDisplayCountry(n) {
	if (n<=nMenu) {
		BackCountry.MenuCountry.ButtonLeft.enabled = false;
		BackCountry.MenuCountry.ButtonRight.enabled = false;
	} else {
		BackCountry.MenuCountry.ButtonLeft.enabled = true;
		BackCountry.MenuCountry.ButtonRight.enabled = true;
	}
	if (n>0) {
		FirstDisplay("Country", n, nMenu);
		DisplayItemCountry("BackCountry.MenuCountry", IndexShowCountry, CountCountry, nMenu);
	}
}
function DisplayItemCountry(Obj, Index, Count, nItem) {
	for (var j = 0; j<nItem; j++) {
		if (j<Count) {
			eval(Obj+".Movie"+j)._visible = true;
			eval(Obj+".Button"+j)._visible = true;
			eval(Obj+".Text"+j)._visible = true;
			eval(Obj+".Text"+j).text = CountryName[Index+j];
		} else {
			//eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible = false;
			eval(Obj+".Text"+j)._visible = false;
		}
	}
}
eval("BackCountry.MenuCountry.ButtonLeft").onRollOver = function() {
	//SelectButton("BackCountry.MenuCountry.MovieLeft");
	SelectMovieClip("BackCountry.MenuCountry.MovieLeft", SelectButtonColorValue, ButtonColorValue);
};
eval("BackCountry.MenuCountry.ButtonRight").onRollOver = function() {
	//SelectButton("BackCountry.MenuCountry.MovieRight");
	SelectMovieClip("BackCountry.MenuCountry.MovieRight", SelectButtonColorValue, ButtonColorValue);
};
eval("BackCountry.MenuCountry.ButtonRight").onRelease = function() {
	ClickRight("Country");
	DisplayItemCountry("BackCountry.MenuCountry", IndexShowCountry, CountCountry, nMenu);
};
eval("BackCountry.MenuCountry.ButtonLeft").onRelease = function() {
	ClickLeft("Country");
	DisplayItemCountry("BackCountry.MenuCountry", IndexShowCountry, CountCountry, nMenu);
};
for (var j = 0; j<nMenu; j++) {
	eval("BackCountry.MenuCountry.Button"+j).onRollOver = function() {
		LevelSelect = 8;
		var k = GetNumber(this._name);
		SelectMovieClip("BackCountry.MenuCountry.Movie"+k, SelectButtonColorValue, ButtonColorValue);
	};
	eval("BackCountry.MenuCountry.Button"+j).onRelease = function() {
		var k = GetNumber(this._name);
		BackCountry.TextCountry.text = eval("BackCountry.MenuCountry.Text"+k).text;
		BackCountry.MenuCountry._visible = false;
		BackCountry.ButtonCountry.onRollOver();
		fscommand("CountryLoad", BackCountry.TextCountry.text);
	};
}
//.................................
function SelectItemOption(Name) {
	BackCountry.ButtonOptDefault.Selected._visible = false;
	BackCountry.ButtonOptCountry.Selected._visible = false;
	BackCountry.ButtonOptLogin.Selected._visible = false;
	BackCountry.ButtonOptPlayList.Selected._visible = false;
	BackCountry.ButtonOptSearch.Selected._visible = false;
	BackCountry.ButtonOptPlayer.Selected._visible = false;
	BackCountry.ButtonOptFullScreen.Selected._visible = false;
	BackCountry.ButtonOptMicro.Selected._visible = false;
//	BackCountry.ButtonOptAutoClientConnect.Selected._visible = false;
	eval("BackCountry.ButtonOpt"+Name+".Selected")._visible = true;
	BackCountry.MenuCountry._visible = false;
	if (Name == "Country") {
		BackCountry.ButtonCountry.enabled = true;
	} else {
		BackCountry.ButtonCountry.enabled = false;
	}
	fscommand("FirstLoad", Name);
}
Bar.ButtonCountry.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	ClickM = 0;
	Bar._visible = false;
	Visible("BackCountry");
	SplCountry(AllCountry);
	SelectItemOption(FirstLoad);
	BackCountry.ButtonOptAutoClientConnect.Selected._visible = (AutoConnect=="true")
	BackCountry.ButtonOptDefault.onRollOver();
};
BackCountry.ButtonOptDefault.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptDefault", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptCountry.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptCountry", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptLogin.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptLogin", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptPlaylist.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptPlaylist", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptSearch.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptSearch", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptPlayer.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptPlayer", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptFullScreen.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptFullScreen", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptMicro.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptMicro", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonCountry.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieCountry", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonCountry.onRelease = function() {
	if (BackCountry.ButtonCountry.enabled) {
		if (BackCountry.MenuCountry._visible) {
			BackCountry.MenuCountry._visible = false;
		} else {
			BackCountry.MenuCountry._visible = true;
		}
	}
};
BackCountry.ButtonOptDefault.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Default");
};
BackCountry.ButtonOptCountry.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Country");
};
BackCountry.ButtonOptLogin.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Login");
};
BackCountry.ButtonOptPlaylist.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Playlist");
};
BackCountry.ButtonOptSearch.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Search");
};
BackCountry.ButtonOptPlayer.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Player");
};
BackCountry.ButtonOptFullScreen.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("FullScreen");
};
BackCountry.ButtonOptMicro.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	SelectItemOption("Micro");
};
var MainPathDB = "";
var MainPathImage = "";
function SplitMainPath(str) {
	var spl = str.split("\\");
	var str1 = "";
	str = "";
	for (var j = 0; j<spl.length-1; j++) {
		str = str+str1+spl[j];
		str1 = "\\";
	}
	return str;
}
BackCountry.ButtonBrowse.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieBrowse", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonBrowseMplayer.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieBrowseMplayer", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonBrowseCoverArt.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieBrowseCoverArt", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonSave.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieSave", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonBrowse.onRelease = function() {
	fscommand("BrowseMainPath", "DB"+"|||"+BackCountry.TextMainPath.text);
};
BackCountry.ButtonBrowseMplayer.onRelease = function() {
	fscommand("BrowseMainPath", "MPlayer"+"|||"+BackCountry.mplayerpart_txt.text);
};
BackCountry.ButtonBrowseCoverArt.onRelease = function() {
	fscommand("BrowseMainPath", "Pic"+"|||"+BackCountry.picPath_txt.text);
};
BackCountry.ButtonSave.onRelease = function() {
	fscommand("SaveMainDB", MainPathImage+"%~%"+MainPathDB);
	TopBar.ButtonC.onRelease();
};
BackCountry.ButtonPlay.onRollOver = function() {
	SelectMovieClip("BackCountry.MoviePlay", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonPlay.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonPlay.Selected._visible = !(BackCountry.ButtonPlay.Selected._visible);
	fscommand("LoadPlayMusic", BackCountry.ButtonPlay.Selected._visible);
};
//=====================================================
BackCountry.ButtonShowPlayer.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieShowPlayer", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonShowPlayer.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonShowPlayer.Selected._visible = !(BackCountry.ButtonShowPlayer.Selected._visible);
	fscommand("ShowPlayerOnLoad", BackCountry.ButtonShowPlayer.Selected._visible);
};
//=====================================================
BackCountry.ButtonFriendPlaylist.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieFriendPlaylist", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonFriendPlaylist.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonFriendPlaylist.Selected._visible = !(BackCountry.ButtonFriendPlaylist.Selected._visible);
	fscommand("FriendPlaylist", BackCountry.ButtonFriendPlaylist.Selected._visible);
};
//=====================================================
BackCountry.ButtonAllow.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAllow", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAllow.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonDeny.Selected._visible = false;
	BackCountry.ButtonAllowByManual.Selected._visible = false;
	BackCountry.ButtonAllow.Selected._visible = true;
	if (BackCountry.ButtonAllow.Selected._visible == true) {
		BackCountry.ButtonCloneDisplayAndPlayback.enabled = true;
		BackCountry.ButtonClonePlaybackOnly.enabled = true;
		BackCountry.ButtonIndependent.enabled = true;
		BackCountry.ButtonSynVolume.enabled = true;
		BackCountry.ButtonCopySlideshow.enabled = true;
		BackCountry.ButtonSynSlideshow.enabled = true;
	}
	display_permission(str_permission);
	fscommand("allow_connection", BackCountry.ButtonAllow.Selected._visible);
};
//===========================================================
BackCountry.ButtonAllowByManual.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAllowByManual", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAllowByManual.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonDeny.Selected._visible = false;
	BackCountry.ButtonAllow.Selected._visible = false;
	BackCountry.ButtonAllowByManual.Selected._visible = true;
	if (BackCountry.ButtonAllowByManual.Selected._visible == true) {
		BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible = false;
		BackCountry.ButtonClonePlaybackOnly.Selected._visible = false;
		BackCountry.ButtonIndependent.Selected._visible = false;
		BackCountry.ButtonSynVolume.Selected._visible = false;
		BackCountry.ButtonCopySlideshow.Selected._visible = false;
		BackCountry.ButtonSynSlideshow.Selected._visible = false;
		BackCountry.ButtonAllow.Selected._visible = false;
		BackCountry.ButtonCloneDisplayAndPlayback.enabled = false;
		BackCountry.ButtonClonePlaybackOnly.enabled = false;
		BackCountry.ButtonIndependent.enabled = false;
		BackCountry.ButtonSynVolume.enabled = false;
		BackCountry.ButtonCopySlideshow.enabled = false;
		BackCountry.ButtonSynSlideshow.enabled = false;
	}
	//===========
	fscommand("allow_connection_by_manual", BackCountry.ButtonAllow.Selected._visible);
};
//=====================================================================
BackCountry.ButtonDeny.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieDeny", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonDeny.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonDeny.Selected._visible = true;
	BackCountry.ButtonAllow.Selected._visible = false;
	BackCountry.ButtonAllowByManual.Selected._visible = false;
	if (BackCountry.ButtonDeny.Selected._visible == true) {
		BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible = false;
		BackCountry.ButtonClonePlaybackOnly.Selected._visible = false;
		BackCountry.ButtonIndependent.Selected._visible = false;
		BackCountry.ButtonSynVolume.Selected._visible = false;
		BackCountry.ButtonCopySlideshow.Selected._visible = false;
		BackCountry.ButtonSynSlideshow.Selected._visible = false;
		BackCountry.ButtonAllow.Selected._visible = false;
		BackCountry.ButtonCloneDisplayAndPlayback.enabled = false;
		BackCountry.ButtonClonePlaybackOnly.enabled = false;
		BackCountry.ButtonIndependent.enabled = false;
		BackCountry.ButtonSynVolume.enabled = false;
		BackCountry.ButtonCopySlideshow.enabled = false;
		BackCountry.ButtonSynSlideshow.enabled = false;
	}
	fscommand("deny_all_connection", BackCountry.ButtonDeny.Selected._visible);
};
//=====================================================
BackCountry.ButtonCloneDisplayAndPlayback.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieCloneDisplayAndPlayback", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonCloneDisplayAndPlayback.onRelease = function() {
	if (this.enabled) {
		BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible = !(BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible);
		Permission();
	}
};
//==========================================================
BackCountry.ButtonClonePlaybackOnly.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieClonePlaybackOnly", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonClonePlaybackOnly.onRelease = function() {
	/*if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}*/
	if (this.enabled) {
		//BackCountry.ButtonClonePlaybackOnly.Selected._visible = !(BackCountry.ButtonClonePlaybackOnly.Selected._visible)
		//fscommand("ClonePlaybackOnly",BackCountry.ButtonClonePlaybackOnly.Selected._visible);
		serverClick(this, "ClonePlaybackOnly", !(this.Selected._visible));
		Permission();
	}
};
//===========================================================Independent
BackCountry.ButtonIndependent.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieIndependent", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonIndependent.onRelease = function() {
	/*if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}*/
	if (this.enabled) {
		//BackCountry.ButtonIndependent.Selected._visible = !(BackCountry.ButtonIndependent.Selected._visible)
		//fscommand("Independent",BackCountry.ButtonIndependent.Selected._visible);
		serverClick(this, "Independent", !(this.Selected._visible));
		Permission();
	}
};
//======================================================================
BackCountry.ButtonSynVolume.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieSynVolume", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonSynVolume.onRelease = function() {
	/*if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}*/
	if (this.enabled) {
		//BackCountry.ButtonSynVolume.Selected._visible = !(BackCountry.ButtonSynVolume.Selected._visible)
		//fscommand("SynVolume",BackCountry.ButtonSynVolume.Selected._visible);
		serverClick(this, "SynVolume", !(this.Selected._visible));
		Permission();
	}
};
//=====================================================================CopySlideshow
BackCountry.ButtonCopySlideshow.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieCopySlideshow", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonCopySlideshow.onRelease = function() {
	/*	if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}*/
	if (this.enabled) {
		//BackCountry.ButtonCopySlideshow.Selected._visible = !(BackCountry.ButtonCopySlideshow.Selected._visible)
		//fscommand("CopySlideshow",BackCountry.ButtonCopySlideshow.Selected._visible);
		serverClick(this, "CopySlideshow", !(this.Selected._visible));
		Permission();
	}
};
//=========================================================================
BackCountry.ButtonSynSlideshow.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieSynSlideshow", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonSynSlideshow.onRelease = function() {
	/*if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}*/
	if (this.enabled) {
		//BackCountry.ButtonSynSlideshow.Selected._visible = !(BackCountry.ButtonSynSlideshow.Selected._visible)
		//fscommand("SynSlideshow",BackCountry.ButtonSynSlideshow.Selected._visible);
		serverClick(this, "SynSlideshow", !(this.Selected._visible));
		Permission();
	}
};
//========================================================================
BackCountry.ButtonLocalLink.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieLocalLink", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonLocalLink.onRelease = function() {
	serverClick(this, "localLink", !(this.Selected._visible));
	BackCountry.fileType._visible = (this.Selected._visible);
};
function serverClick(obj, command, value) {
	if (send_event("normal&&&function||serverClick|~|"+obj+"|~|"+command+"|~|"+value+"||6", false)) {
		return;
	}
	eval(obj+".Selected")._visible = (String(value) == "true") ? true : false;
	fscommand(command, eval(obj+".Selected")._visible);
}
//=============================================================================
//AccessPassword
BackCountry.ButtonAccessPassword.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAccessPassword", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAccessPassword.onRelease = function() {
	//if (send_event("normal&&&Click||" + this + "||6",false)){
	//	return;
	//}
	BackCountry.ButtonAccessPassword.Selected._visible = !(BackCountry.ButtonAccessPassword.Selected._visible);
	fscommand("access_password", BackCountry.ButtonAccessPassword.Selected._visible);
};
//----------------------------------------------------------------------------------------------------
//Auto Client Connection
BackCountry.ButtonOptAutoClientConnect.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieOptAutoClientConnect", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonOptAutoClientConnect.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||6", false)) {
		return;
	}
	BackCountry.ButtonOptAutoClientConnect.Selected._visible=!BackCountry.ButtonOptAutoClientConnect.Selected._visible

	fscommand("AutoConnect",BackCountry.ButtonOptAutoClientConnect.Selected._visible);
};
//Display And Playback
BackCountry.ButtonAutoDisplayAndPlayback.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAutoDisplayAndPlayback", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAutoDisplayAndPlayback.onRelease = function() {
	//if (send_event("normal&&&Click||" + this + "||6",false)){
	//	return;
	//}
	selectAutoConnectionObject(BackCountry.ButtonAutoDisplayAndPlayback);
	fscommand("AutoClientConnection", getConnectionType());

};
//Playback
BackCountry.ButtonAutoPlayback.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAutoPlayback", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAutoPlayback.onRelease = function() {
	//if (send_event("normal&&&Click||" + this + "||6",false)){
	//	return;
	//}
	selectAutoConnectionObject(BackCountry.ButtonAutoPlayback);
	fscommand("AutoClientConnection", getConnectionType());
};
//Independent
BackCountry.ButtonAutoIndependent.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAutoIndependent", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAutoIndependent.onRelease = function() {
	//if (send_event("normal&&&Click||" + this + "||6",false)){
	//	return;
	//}
	selectAutoConnectionObject(BackCountry.ButtonAutoIndependent);
	fscommand("AutoClientConnection", getConnectionType());
};
//Remote Control
BackCountry.ButtonAutoRemoteControl.onRollOver = function() {
	SelectMovieClip("BackCountry.MovieAutoRemoteControl", SelectButtonColorValue, ButtonColorValue);
	LevelSelect = 8;
};
BackCountry.ButtonAutoRemoteControl.onRelease = function() {
	//if (send_event("normal&&&Click||" + this + "||6",false)){
	//	return;
	//}
	selectAutoConnectionObject(BackCountry.ButtonAutoRemoteControl);
	fscommand("AutoClientConnection", getConnectionType());
};
//----------------------------------------------------------------------------------------------------
function display_permission(val) {
	BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible = false;
	BackCountry.ButtonClonePlaybackOnly.Selected._visible = false;
	BackCountry.ButtonIndependent.Selected._visible = false;
	BackCountry.ButtonSynVolume.Selected._visible = false;
	BackCountry.ButtonCopySlideshow.Selected._visible = false;
	BackCountry.ButtonSynSlideshow.Selected._visible = false;
	var v = "";
	for (var init = 0; init<length(val); init++) {
		v = String(val).substr(init, 1);
		if (v == 1) {
			BackCountry.ButtonCloneDisplayAndPlayback.Selected._visible = true;
		} else if (v == 2) {
			BackCountry.ButtonClonePlaybackOnly.Selected._visible = true;
		} else if (v == 3) {
			BackCountry.ButtonIndependent.Selected._visible = true;
		} else if (v == 4) {
			BackCountry.ButtonSynVolume.Selected._visible = true;
		} else if (v == 5) {
			BackCountry.ButtonCopySlideshow.Selected._visible = true;
		} else if (v == 6) {
			BackCountry.ButtonSynSlideshow.Selected._visible = true;
		}
	}
}
//----------------------------------------------------------------------------------------------------
function selectAutoConnectionObject(objName){
	BackCountry.ButtonAutoClientConnect.Selected._visible = true;
	BackCountry.ButtonAutoDisplayAndPlayback.selected._visible = false;
	BackCountry.ButtonAutoPlayback.selected._visible = false;
	BackCountry.ButtonAutoIndependent.selected._visible= false;
	BackCountry.ButtonAutoRemoteControl.selected._visible = false;
	objName.selected._visible=true
}
function getConnectionType() {
	//Disable(0),cloneDisplay(1),remotePlaylist(2),remoteControl(3),independentMode(4)
	if(BackCountry.ButtonAutoClientConnect.Selected._visible){
		if (BackCountry.ButtonAutoDisplayAndPlayback.Selected._visible) {
			return 1;
		} else if (BackCountry.ButtonAutoPlayback.selected._visible) {
			return 2;
		} else if (BackCountry.ButtonAutoRemoteControl.selected._visible) {
			return 3;
		} else if (BackCountry.ButtonAutoIndependent.selected._visible) {
			return 4;
		}
	}
	return 0;
}

BackCountry.remote.BrowsePath.ButtonBrowse.onRelease = function()
{
	fscommand("BrowseRemotePlaylistPath",true);
}

BackCountry.remote.BrowsePath.ButtonBrowse.onRollOver = function()
{
	SelectMovieClip("BackCountry.remote.BrowsePath.MovieBrowse", SelectButtonColorValue, ButtonColorValue);
	SelectLevel=8;
}
BackCountry.remote.first_remote.ButtonSet.onRelease = function()
{
	fscommand("SetNumRemoteClient",BackCountry.remote.first_remote.txtNum.text);
}
BackCountry.remote.first_remote.ButtonSet.onRollOver = function()
{
	SelectMovieClip("BackCountry.remote.first_remote.MovieSet", SelectButtonColorValue, ButtonColorValue);
	SelectLevel=8;
}

