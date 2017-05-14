function ChangeAdsValues(value){
	if(value=="false"){
		BackTheme.ButtonAds.Selected._visible=false;
	}
	else{
		BackTheme.ButtonAds.Selected._visible=true;
	}
}
_root.addProperty("ChangeAdsValue",GetVb1,ChangeAdsValues);
var WhiteColor=0xFFFFFF;
var BlueColor=random(255);
var ClickM=0;
var SHTT = "true";
Bar._visible=false;
Bg._visible=false;

TopBar._visible=false;
TopBar.ButtonM.onRollOver = function() {
	if(Menu._visible)HideMenu()
	DisplayTooltip(this,"txtTooltip","Menu (Ctrl+M)",SHTT,-(96.2/2)+5,20);
	LevelSelect = 1;
	SelectMovieClip("TopBar.MovieM",SelectButtonColorValue,ButtonColorValue);
};
TopBar.ButtonM.onRelease = function() {
ShowHideOptionButtonM(ClickM);
};
function ShowHideOptionButtonM(val){
	
	if (send_event("normal&&&function||ShowHideOptionButtonM|~|" + val + "||6",false)){
		return;
	}
	if(int(val)==0){
		Bar._visible=true;
		ClickM=1;
	}
	else{
		ClickM=0;
		Bar._visible=false;
	}
}


TopBar.ButtonB.onRollOver = function() {
	if(Menu._visible)HideMenu()
	DisplayTooltip(this,"txtTooltip","Back (backspace)",SHTT,0,20);
	SelectMovieClip("TopBar.MovieB");
	LevelSelect = 1;
}
TopBar.ButtonB.onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	fscommand("Back");
}
TopBar.ButtonS.onRollOver = function() {
	if(Menu._visible)HideMenu()
	DisplayTooltip(this,"txtTooltip","Search (Ctrl+S)",SHTT,-(105.55/2)+5,20);
	SelectMovieClip("TopBar.MovieS");
	LevelSelect = 1;
}
TopBar.ButtonS.onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	fscommand("ShowSearch");
}
TopBar.ButtonP.onRollOver = function() {
	if(Menu._visible)HideMenu()
	DisplayTooltip(this,"txtTooltip","Playlist (Ctrl+P)",SHTT,-(104.8/2)+5,20);
	SelectMovieClip("TopBar.MovieP");
	LevelSelect = 1;
}
TopBar.ButtonC.onRollOver = function() {
	if(Menu._visible)HideMenu()
	DisplayTooltip(this,"txtTooltip","Language (Ctrl+"+chr(KeyLanguage)+")",SHTT,-(123.55/2)+5,20);
	SelectMovieClip("TopBar.MovieC");
	LevelSelect = 1;	
}

TopBar.ButtonL.onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Unicode/English (Ctrl+E)",SHTT,-(165.75/2)+5,20);
	SelectMovieClip("TopBar.MovieL");
	LevelSelect = 1;	
}
TopBar.ButtonO.onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Option (Ctrl+O)",SHTT,-(104/2)+5,20);
	SelectMovieClip("TopBar.MovieO");
	LevelSelect = 1;
}
TopBar.ButtonX.onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Drop down menu (Ctrl+D)",SHTT,-173.55+5,20);
	SelectMovieClip("TopBar.MovieX");
	LevelSelect = 1;
}
TopBar.ButtonP.onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	fscommand("ShowPlayList");
}
TopBar.ButtonC.onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	fscommand("ShowCountry");
}

Bar.ButtonTheme.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	Visible("BackTheme");
	Bar._visible=false;
	ClickM=0;
	BackTheme.ButtonColor.onRollOver();
}
Bar.ButtonRipAndPlay.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	Visible("BackRipAndPlay");
	Bar._visible=false;
	ClickM=0;
	BackRipAndPlay.ButtonMicro.onRollOver();	
}
Bar.ButtonSlideShow.onRelease=function(){
	if(this.enabled){
		if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}
		Visible("BackSlideShow");
		Bar._visible=false;
		ClickM=0;
		BackSlideShow.ButtonDir.onRollOver();
	}
}
TopBar.ButtonX.onRelease = function() {
	ShowHideOptionButtonX(!(Menu._visible));
};
function ShowHideOptionButtonX(val){

    if (send_event("normal&&&function||ShowHideOptionButtonX|~|" + val + "||6",false)){
		return;
	}
	if(String(val)=="false"){
		HideMenu()
	}
	else{
		Menu._visible=true;
	}
	
}
//................................Menu.......................
Menu._visible = false;
Menu.Exit.Text.text = "Exit";
Menu.Min.Text.text = "Minimize";
Menu.Scan.Text.text = "Scan File";
Menu.RipCD.Text.text = "Rip CD";
eval("Menu.AboutSly.Button").onRelease = function() {
	HideMenu();
	ClickMenu = 0;
	fscommand("ShowAboutSly",0);
};
eval("Menu.AboutSly.Button").onRollOver = function() {
	MenuMISC._visible=false;
	LevelSelect = 6;
	MenuLevel = 0;
	SelectMovieClip("Menu.AboutSly.Movie");
};

eval("Menu.Exit.Button").onRollOver = function() {
	MenuMISC._visible=false;
	LevelSelect = 6;
	MenuLevel = 0;
	SelectMovieClip("Menu.Exit.Movie");
};
eval("Menu.Exit.Button").onRelease = function() {
	HideMenu()
	fscommand("Exit");
}
eval("Menu.Min.Button").onRollOver = function() {
	MenuMISC._visible=false;
	LevelSelect = 6;
	MenuLevel = 0;
	SelectMovieClip("Menu.Min.Movie");
};
eval("Menu.Min.Button").onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	HideMenu()
	fscommand("Minimize");
	CtrlKey=false;
	TopBar.ButtonM.onRollOver();	
}
eval("Menu.Scan.Button").onRollOver = function() {
	MenuMISC._visible=false;
	LevelSelect = 6;
	MenuLevel = 0;
	SelectMovieClip("Menu.Scan.Movie");
};
eval("Menu.Scan.Button").onRelease = function() {
	HideMenu()
	fscommand("ShowScan");
}


function Visible(Name){
	BackTheme._visible=false;
	BackPlayList._visible=false;
	BackSlideShow._visible=false;
	BackAlbum._visible=false;
	BackRipAndPlay._visible = false;
	BackCountry._visible=false;
	eval(Name)._visible=true;
	fscommand("DisplayPage",Name);
}
Visible("");

Bar.ButtonProFile.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	Visible("BackPlayList");
	Bar._visible=false;
	ClickM=0;
	BackPlayList.ButtonDir.onRollOver();
	if(ResultD.length==0){
		var Xml = new XML();
		Xml.load(MusicPath+"\\Sly\\PlayListPaths.xml");
		Xml.onLoad=function(){
			NumD=Xml.childNodes[0].childNodes.length;
			for(var j=0;j<NumD;j++){
				ResultD[j]=Xml.childNodes[0].childNodes[j].childNodes[0].nodeValue;
			}
			//BackPlayList.TextD.text=ResultD[0];
			FirstDisplayListItemD(ResultD.length);
			BackPlayList.BackListD.Button0.onRelease();
			//fscommand("reply",CurPlayList);
			//LoadCurPlayList(CurPlayList);
//			delete(Xml);
		}
	}
}

/// THEME ///

var ColorValue;
var AlbumNum;
var CoverNum;
var CoverPlus;
var CDType;
var IndexAblumNum=0;
var CoverAlbum="No";
var ButtonColorValue,SelectButtonColorValue;
var ButtonAlphaValue=80;
var SelectButtonAlphaValue=80;
var DisplayKeyBoard="No";
var FontColorValue;

///	SLIDESHOW ///
var ImageSlidePath="";
var TimeSlideValue;
var SetSlideValue;
var DelaySlideValue;
var ImageSlideSize;
var StretchValue;
var ShowValue;
var EffectValue;
var ScrollValue;

/// 	PROFILE  ..............
var PathPic1,PathPic2,CurPlayList;

function ChangeColorAlpha(Na,ColorValue1,AlphaValue1){
		myColor = new Color(Na);
		myColor.setRGB(ColorValue1);
		eval(Na)._alpha=AlphaValue1;
}
function ChangeColorNoAlpha(Na,ColorValue1){
	
		myColor = new Color(Na);
		myColor.setRGB(ColorValue1);
}
///..................

function SetColorMisc(Value,Alpha){
	ChangeColorAlpha("Menu.RipCD.Movie", Value, Alpha);
	ChangeColorAlpha("Menu.AboutSly.Movie", Value, Alpha);
	ChangeColorAlpha("Menu.MISC.Movie", Value, Alpha);
	
	ChangeColorAlpha("MenuMISC.UpDateDB.Movie", Value, Alpha);
	ChangeColorAlpha("MenuMISC.RestoreDB.Movie", Value, Alpha);
	ChangeColorAlpha("MenuMISC.BackUpDB.Movie", Value, Alpha);
	ChangeColorAlpha("MenuMISC.CopyFolder.Movie", Value, Alpha);
	ChangeColorAlpha("MenuMISC.AddNewScreen.Movie", Value, Alpha);
	//............
	ChangeColorAlpha("UpDateDB.Bar", Value, Alpha);
	ChangeColorAlpha("BackUpDB.Bar", Value, Alpha);
	ChangeColorAlpha("RestoreDB.Bar", Value, Alpha);
	ChangeColorAlpha("CopyMusic.Bar", Value, Alpha);
	//..............
	ChangeColorAlpha("WarningUpdate.Bar", Value, Alpha);
	ChangeColorAlpha("WarningUpdate.MovieOk", Value, Alpha);
	ChangeColorAlpha("WarningUpdate.MovieCancel", Value, Alpha);
	//..............
	ChangeColorAlpha("UpdateDB.MovieOk", Value, Alpha);
	ChangeColorAlpha("UpdateDB.MovieCancel", Value, Alpha);
	ChangeColorAlpha("UpdateDB.MovieBrowseDB", Value, Alpha);
	ChangeColorAlpha("UpdateDB.MovieDownLoad", Value, Alpha);
	ChangeColorAlpha("UpdateDB.MovieCheckDatabase", Value, Alpha);
	//..................
	ChangeColorAlpha("BackUpDB.MovieOk", Value, Alpha);
	ChangeColorAlpha("BackUpDB.MovieCancel", Value, Alpha);
	ChangeColorAlpha("BackUpDB.MovieBrowseDB", Value, Alpha);
	//...................
	ChangeColorAlpha("RestoreDB.MovieOk", Value, Alpha);
	ChangeColorAlpha("RestoreDB.MovieCancel",Value, Alpha);
	ChangeColorAlpha("RestoreDB.MovieBrowseDB", Value, Alpha);
	//.................
	ChangeColorAlpha("CopyMusic.MovieOk", Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieCancel", Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieBrowse1", Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieBrowse2", Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieCheck1",Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieCheck2", Value, Alpha);
	ChangeColorAlpha("CopyMusic.MovieCheck3", Value, Alpha);
	//...................
	//................
	ChangeColorAlpha("AddNewScreens.Bar", Value, Alpha);
	for(var j=0;j<nScreen;j++){
		ChangeColorAlpha("AddNewScreens.Button"+j+".chk",Value, Alpha);
		ChangeColorAlpha("AddNewScreens.Movie"+j, Value, Alpha);
	}
	ChangeColorAlpha("AddNewScreens.MovieLeft",Value, Alpha);
	ChangeColorAlpha("AddNewScreens.MovieRight",Value, Alpha);
	ChangeColorAlpha("AddNewScreens.MovieOk",Value, Alpha);
	ChangeColorAlpha("AddNewScreens.MovieCancel",Value, Alpha);

}
function ChangeColorCheck(Value,Alpha){
	
	ChangeColorAlpha("BackCountry.ButtonOptDefault.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptCountry.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptLogin.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptPlaylist.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptSearch.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptPlayer.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptFullScreen.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonOptMicro.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonPlay.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonFriendPlaylist.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackCountry.ButtonAllow.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonDeny.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonCloneDisplayAndPlayback.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonClonePlaybackOnly.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonIndependent.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonSynVolume.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonCopySlideshow.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonSynSlideshow.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonAllowByManual.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackCountry.ButtonLocalLink.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonAccessPassword.Selected",Value, Alpha);
	ChangeColorAlpha("BackCountry.ButtonShowPlayer.Selected",Value, Alpha);

	ChangeColorAlpha("BackCountry.ButtonOptAutoClientConnect.Selected",Value, Alpha);

	ChangeColorAlpha("BackAlbum.ButtonImage.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonInternet.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonDownload.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonCheckDatabase.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonRating.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonCover.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonCoverNum.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonCoverPlus.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonAllCD.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonAlbumList.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.subList.Button_subList_production",Value,Alpha);
	ChangeColorAlpha("BackAlbum.subList.Button_subList_actor",Value,Alpha);
	ChangeColorAlpha("BackAlbum.subList.Button_subList_director",Value,Alpha);
	
	
	ChangeColorAlpha("BackAlbum.ButtonAlbumIcon.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonClean.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonExp.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonAllAlbumType.Selected",Value, Alpha);
	ChangeColorAlpha("BackAlbum.ButtonGroupAlbumType.Selected",Value, Alpha);
    
	ChangeColorAlpha("BackTheme.ButtonAds.Selected",Value, Alpha);
	ChangeColorAlpha("BackTheme.ButtonTooltip.Selected",Value, Alpha);	
	ChangeColorAlpha("BackTheme.ButtonMouse.Selected",Value, Alpha);
	ChangeColorAlpha("BackTheme.ButtonMonitor.Selected",Value, Alpha);
	ChangeColorAlpha("BackTheme.ButtonPopupExit.Selected",Value, Alpha);

	ChangeColorAlpha("BackSlideShow.ButtonInSlide.Selected",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonExSlide.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackSlideShow.ButtonSyn.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonResize.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonAllowSlideshow.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonSetSlideShow.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonStretch.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonShow.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonEffect.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonScroll.chk",Value, Alpha);
	ChangeColorAlpha("BackSlideShow.ButtonRandom.chk",Value, Alpha);
	
	
	ChangeColorAlpha("CopyMusic.ButtonCheck3.chk", Value, Alpha);
	ChangeColorAlpha("CopyMusic.ButtonCheck2.chk", Value, Alpha);
	ChangeColorAlpha("CopyMusic.ButtonCheck1.chk", Value, Alpha);
	
	ChangeColorAlpha("BackRipAndPlay.ButtonDownloadAll.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonReEncode.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonMicro.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonResize.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonOnly.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonSyn_vol.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonChange_vol.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonCloneOnly.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonCloneAndDisplay.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonIndependent.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonremoteControl.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonDualVideo.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonScroll.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonOld.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonNew.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonWmp.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonShowtime.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackRipAndPlay.ButtonOffset.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonAutoPlay.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonAutoPlayMPC.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonSingerSong.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackRipAndPlay.ButtonSmall.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonLarge.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonTop.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonBottom.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackRipAndPlay.ButtonTurnOff.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonTurnOn.Selected",Value, Alpha);
	
	ChangeColorAlpha("BackRipAndPlay.ButtonWinamp.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonPowerDVD.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonBrowseFolder.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonExternalPowerDVD.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonRipiTunes.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonRipWmp.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonMP3.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonWMA.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonMP4.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonFLAC.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonAPE.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonLocal.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonStream.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.Buttonchaptertrack.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.Buttonendtrack.Selected",Value, Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonRealTime.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonHigh.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonAboveNormal.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonNormal.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonBelowNormal.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonLow.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonPopup.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.GDI.ButtonGDI.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.GDI.ButtonNOGDI.Selected",Value,Alpha);
	ChangeColorAlpha("BackRipAndPlay.ButtonScanAlbum.Selected",Value,Alpha);

}
function ChangeColorMovie(ColorVal,AlphaVal){
	SetColorMisc(ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieB",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieM",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieS",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieP",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieC",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieO",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieL",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.MovieX",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.fileType.Movie",ColorVal, AlphaVal);
	
	ChangeColorAlpha("Bar.MovieTheme",ColorVal,AlphaVal);
	ChangeColorAlpha("Bar.MovieSlideShow",ColorVal,AlphaVal);
	ChangeColorAlpha("Bar.MovieProFile",ColorVal,AlphaVal);
	ChangeColorAlpha("Bar.MovieAlbum",ColorVal,AlphaVal);
	ChangeColorAlpha("Bar.MovieCountry",ColorVal,AlphaVal);
	ChangeColorAlpha("Bar.MovieRipAndPlay",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackPlayList.MovieDir",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.MovieAdd",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.MovieRemove",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.MovieImage1",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.MovieImage2",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.BackListD.MovieUp",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.BackListD.MovieDown",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackRipAndPlay.MovieLocal",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieStream",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.Moviechaptertrack",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.Movieendtrack",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieMicro",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieResize",ColorVal,AlphaVal);

	ChangeColorAlpha("BackRipAndPlay.MovieReEncode",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieDownloadAll",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieOnly",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieSyn_vol",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieChange_vol",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieCloneOnly",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieCloneAndDisplay",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieIndependent",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieremoteControl",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieProgram",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieVideo",ColorVal,AlphaVal);

	ChangeColorAlpha("BackRipAndPlay.MovieMicroScale",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieTrackTitleStyle",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieOld",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieNew",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieSmall",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieLarge",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieTop",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieBottom",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackRipAndPlay.MovieTurnOff",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieTurnOn",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieWmp",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieBrowseFolder",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieExternalPowerDVD",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MoviePowerDVD",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieShowtime",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieOffset",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieAutoPlay",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieAutoPlayMPC",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieAutoPlayPowerDVD",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieSingerSong",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieWinamp",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieRipWmp",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieRipiTunes",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieMP3",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieWMA",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieMP4",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieFLAC",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieAPE",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MoviePopup",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.GDI.MovieGDI",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.GDI.MovieNOGDI",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackRipAndPlay.MovieRealTime",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieHigh",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieAboveNormal",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieNormal",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieBelowNormal",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieLow",ColorVal,AlphaVal)
	ChangeColorAlpha("BackRipAndPlay.MovieScanAlbum",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieBrowseAdv",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MovieMainPath",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackAlbum.MovieImage",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieEngFont",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieUniFont",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieAlbumNum",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieInternet",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieDownload",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieCheckDatabase",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieRating",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieAlbumList",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.subList.Movie_subList_production",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.subList.Movie_subList_actor",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.subList.Movie_subList_director",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieAlbumIcon",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieAlphaValue",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieSelAlphaValue",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackTheme.MovieAlphaValue1",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieSelAlphaValue1",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieColorBar",ColorBar,100);
	ChangeColorAlpha("BackTheme.MovieColorRating",ColorRating,100);
	ChangeColorNoAlpha("TopBar.Bar",ColorBar);
	ChangeColorNoAlpha("Bar.Bar",ColorBar);
	ChangeColorNoAlpha("Menu.Bar",ColorBar);
	ChangeColorNoAlpha("MenuMISC.Bar", ColorBar);
	
	ChangeColorAlpha("BackAlbum.MovieCover",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieCoverNum",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieBrowse",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieFavAlbum",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieAllCD",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieClean",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieExp",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MovieAlbumType",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieAllAlbumType",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieGroupAlbumType",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.Movie0",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.Movie1",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.Movie2",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.Movie3",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.Movie4",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.MovieLeft",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackAlbum.MenuAlbumType.MovieRight",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackCountry.MovieOptDefault",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptCountry",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptLogin",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptPlaylist",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptSearch",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptPlayer",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptFullScreen",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieOptMicro",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieCountry",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.Movie0",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.Movie1",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.Movie2",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.Movie3",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.Movie4",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.MovieLeft",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MenuCountry.MovieRight",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieMainPath",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieMainPathMplayer",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieMainPathCoverArt",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieBrowse",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieBrowseCoverArt",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieBrowseMplayer",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieSave",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MoviePlay",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieShowPlayer",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieFriendPlaylist",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackCountry.MovieAllow",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieAllowByManual",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieDeny",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieCloneDisplayAndPlayback",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieClonePlaybackOnly",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieIndependent",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieSynVolume",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieCopySlideshow",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.MovieSynSlideshow",ColorVal,AlphaVal);
		
	ChangeColorAlpha("BackCountry.MovieLocalLink",ColorVal,AlphaVal);	
	ChangeColorAlpha("BackCountry.MovieAccessPassword",ColorVal,AlphaVal);

	ChangeColorAlpha("BackCountry.remote.BrowsePath.MovieBrowse",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.remote.first_remote.MovieTxt",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.remote.BrowsePath.MoviePath",ColorVal,AlphaVal);
	ChangeColorAlpha("BackCountry.remote.first_remote.MovieSet",ColorVal,AlphaVal);

	
	ChangeColorAlpha("BackCountry.MovieOptAutoClientConnect",ColorVal,AlphaVal);

	ChangeColorAlpha("BackTheme.MovieTooltip",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MoviePopupExit",ColorVal,AlphaVal);
	ChangeColorAlpha("BackRipAndPlay.MoviePopup",ColorVal,AlpjaVal);
	ChangeColorAlpha("BackRipAndPlay.GDI.MovieGDI",ColorVal,AlpjaVal);
	ChangeColorAlpha("BackRipAndPlay.GDI.MovieNOGDI",ColorVal,AlpjaVal);
	
	
	ChangeColorAlpha("BackRipAndPlay.MovieScroll",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieMouse",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieAds",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieWinMode",ColorVal,AlphaVal);
	ChangeColorAlpha("BackTheme.MovieMonitor",ColorVal,AlphaVal);
	ChangeColorAlpha("BackAlbum.MovieCoverPlus",ColorVal,AlphaVal);
	
	
	//ChangeColorAlpha("BackTheme.BorderColor",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackTheme.BorderFontColor",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackTheme.BorderFrame",ColorVal,AlphaVal);
	//ChangeColorAlpha("BackTheme.BorderSelFrame",ColorVal,AlphaVal);
	
	ChangeColorAlpha("BackSlideShow.MovieInSlide",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieExSlide",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieEffect",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieSetSlideShow",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieShow",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieStretch",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieScroll",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieRandom",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieSyn",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieResize",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieAllowSlideshow",ColorVal,AlphaVal);

	//--------------------------Add Track By Code ID------------------------------------
	ChangeColorAlpha("AddTrackBox.MovieK", ColorVal,AlphaVal);
	ChangeColorAlpha("AddTrackBox.MovieCancel", ColorVal,AlphaVal);
	ChangeColorAlpha("AddTrackBox.MovieOK", ColorVal,AlphaVal);		
	
	ChangeColorAlpha("BackSlideShow.MovieDir",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieTime",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieDelay",ColorVal,AlphaVal);
	ChangeColorAlpha("BackSlideShow.MovieImageSize",ColorVal,AlphaVal);
	ChangeColorAlpha("BackPlayList.BackListD.MovieScrollBar",ColorVal,AlphaVal);
	for(var j=0;j<nList;j++){

		ChangeColorAlpha("BackPlayList.BackListD.Movie"+j,ColorVal,AlphaVal);
	}
	
	
	ChangeColorAlpha("Menu.Min.Movie",ColorVal,AlphaVal);
	ChangeColorAlpha("Menu.Scan.Movie",ColorVal,AlphaVal);
	ChangeColorAlpha("Menu.Exit.Movie",ColorVal,AlphaVal);
	ChangeColorAlpha("TopBar.Letter.Movie", SelectButtonColorValue, AlphaVal);
	ChangeColorCheck(SelectButtonColorValue, SelectButtonAlphaValue);
}

var MusicPath;

var EnglishFont;
var UnicodeFont;
var EngFontSize;
var UniFontSize;
var HideMouse="false";
function SetFont(Text,FontName,FontSize,Bold){
	var setFont=new TextFormat();
	setFont.font=FontName;
	setFont.size=FontSize;
	setFont.bold=Bold;
	eval(Text).setTextFormat(setFont);
}
var SortedValue,MyFavAlbumValue,MyFavAlbumValue1,MyFavArtistValue,MyAlbum,MyAlbum1,MyFavArtistValue1,BrowseByValue,DisplayAlbumValue,ColorBar,ColorRating;
function OpenXml(PathName){
	var Xml=new XML();
	Xml.load(PathName);
	Xml.onLoad=function(){
		/// theme ///
		if(Unregistered=="True"){
			BackTheme.ButtonAds._visible=true;
			BackTheme.MovieAds._visible=true;
		}
		var SplFont=StrFont.split("~");
		EnglishFont=SplFont[0];
		UnicodeFont=SplFont[1];
		EngFontSize=SplFont[2];
		UniFontSize=SplFont[3];
		BackTheme.TextEngFont.text=EnglishFont;
		BackTheme.TextUniFont.text=UnicodeFont;
		SetFont("BackTheme.TextEngFont",EnglishFont,EngFontSize,false);
		SetFont("BackTheme.TextUniFont",UnicodeFont,UniFontSize,true);
		
		ColorBar=Xml.childNodes[0].childNodes[0].attributes.ColorBar;
		ColorRating=Xml.childNodes[0].childNodes[0].attributes.ColorRating;
		ColorValue=Xml.childNodes[0].childNodes[0].attributes.ColorBg;
		ChangeColorNoAlpha("BackTheme.MovieColor",ColorValue);
		ChangeColorNoAlpha("Bg",ColorValue);
		//BackTheme.TextPos.text=Xml.childNodes[0].childNodes[0].attributes.TrackPos;
		//BackTheme.TextPos1.text=Xml.childNodes[0].childNodes[0].attributes.TrackPosUni;
		BackTheme.TextPos.text=SplFont[4];
		BackTheme.TextPos1.text=SplFont[5];
		BackTheme.TextEngFont._y += parseInt(BackTheme.TextPos.text,10);
		BackTheme.TextUniFont._y += parseInt(BackTheme.TextPos1.text,10);
		
		BrowseByValue=SplFont[6];
		MyFavAlbumValue=SplFont[7];
		MyFavAlbumValue1=MyFavAlbumValue;
		MyFavArtistValue=SplFont[8];
		MyAlbum=SplFont[10];
		MyFavArtistValue1=MyFavArtistValue;
		if(MyAlbum=="MyFavorite")MyAlbum="Alphabet";
		if(MyFavAlbumValue=="MyFavorite")MyFavAlbumValue="Alphabet";
		if(MyFavArtistValue=="MyFavorite")MyFavArtistValue="Alphabet";
		DisplayAlbumValue=SplFont[9];
		switch(SplFont[9]){
			case "Browse": 
				BackAlbum.TextBrowse.text=SplFont[6];
				if(BackAlbum.TextBrowse.text=="Rating" ){
					BackAlbum.TextFavAlbum.text="Alphabet";
				}
				else if( BackAlbum.TextBrowse.text=="ReleaseDate"){
					SortedValue=Xml.childNodes[0].childNodes[0].attributes.SortedValue;
					if(SortedValue==1)BackAlbum.TextFavAlbum.text="Alphabet";
					else BackAlbum.TextFavAlbum.text="ReleaseDate"
				}
				else{
					SortedValue=Xml.childNodes[0].childNodes[0].attributes.SortedValue;
					if(SortedValue==1)BackAlbum.TextFavAlbum.text="Alphabet";
					else BackAlbum.TextFavAlbum.text="ReleaseDate"
				}
				break;
			case "MyFavAlbum":
				BackAlbum.TextBrowse.text="MyFavoriteAlbum";
				BackAlbum.TextFavAlbum.text=MyFavAlbumValue;
				break;
			case "MyFavArtist":
				BackAlbum.TextBrowse.text="MyFavoriteArtist";
				BackAlbum.TextFavAlbum.text=MyFavArtistValue;
				break;
			case "MyAlbum":
				BackAlbum.TextBrowse.text="MyAlbum";
				BackAlbum.TextFavAlbum.text=MyAlbum;
				break;
		}
		AlbumNum=Xml.childNodes[0].childNodes[0].attributes.AlbumNum;
		BackAlbum.TextAlbumNum.text=AlbumNum;
		
		if(NoInternetConnected=="0")BackAlbum.ButtonInternet.Selected._visible=false;
		else BackAlbum.ButtonInternet.Selected._visible=true;
		
		if(AutoDownload=="0")	BackAlbum.ButtonDownload.Selected._visible=false;
		else BackAlbum.ButtonDownload.Selected._visible=true;
		
		CoverAlbum=Xml.childNodes[0].childNodes[0].attributes.AlbumCover;
		CoverNum=Xml.childNodes[0].childNodes[0].attributes.NumCover;
		CoverPlus=Xml.childNodes[0].childNodes[0].attributes.PlusCover;
		CDType=Xml.childNodes[0].childNodes[0].attributes.CDType;
		CDTypeSelect(CDType);
		if(CoverAlbum=="No"){
			BackAlbum.ButtonCover.Selected._visible=false;
		}
		if(CoverNum=="No"){
			BackAlbum.ButtonCoverNum.Selected._visible=false;
		}
		if(CoverPlus=="No"){
			BackAlbum.ButtonCoverPlus.Selected._visible=false;
		}
		ButtonColorValue=Xml.childNodes[0].childNodes[0].attributes.ButtonColor;
		SelectButtonColorValue=Xml.childNodes[0].childNodes[0].attributes.SelectButton;
		ButtonAlphaValue=Xml.childNodes[0].childNodes[0].attributes.ButtonAlpha;
		SelectButtonAlphaValue=Xml.childNodes[0].childNodes[0].attributes.SelectButtonAlpha;
		ChangeColorAlpha("BackTheme.MovieFrame",ButtonColorValue,ButtonAlphaValue);
		ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);
		ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
		BackTheme.TextAlphaValue.text=ButtonAlphaValue;
		BackTheme.TextSelAlphaValue.text=SelectButtonAlphaValue;
		DisplayKeyBoard=Xml.childNodes[0].childNodes[0].attributes.Manually;
		BackTheme.TextWinMode.text=Xml.childNodes[0].childNodes[0].attributes.FormMode;
		HideMouse=Xml.childNodes[0].childNodes[0].attributes.HideMouse;
		if(HideMouse=="false")BackTheme.ButtonMouse.Selected._visible=false;
		else {
			Mouse.hide();
//			ButtonHideMouse._visible=true;
		}
		if(DisplayKeyBoard=="Yes"){
			BackTheme.ButtonManual.Selected._visible=false;
			BackTheme.ButtonAutomatic.Selected._visible=true;
		}
		else{
			BackTheme.ButtonManual.Selected._visible=true;
			BackTheme.ButtonAutomatic.Selected._visible=false;
		}
		FontColorValue=Xml.childNodes[0].childNodes[0].attributes.FontColor;
		TrackShow.setTrackDisplayTheme(FontColorValue,ColorBar);
		ChangeColorText(FontColorValue);
		WhiteColor=FontColorValue;
		ChangeColorNoAlpha("BackTheme.MovieFontColor",FontColorValue);
		SetFontColor(FontColorValue);
		FirstLoad=Xml.childNodes[0].childNodes[0].attributes.FirstLoad;
		AutoConnect=Xml.childNodes[0].childNodes[0].attributes.AutoConnect;
		BackCountry.TextCountry.text=Xml.childNodes[0].childNodes[0].attributes.CountryLoad;
		BackCountry.TextMainPath.text	=	MainPathDB;
		BackCountry.picPath_txt.text	=	MainPathImage;
		BackCountry.mplayerpart_txt.text =  MPlayerPath;
		
		
		if(LoadPlayMusic=="true")BackCountry.ButtonPlay.Selected._visible=true;
		else BackCountry.ButtonPlay.Selected._visible=false;
		delete(LoadPlayMusic);
		
		//=================================================================
		if(ShowPlayerOnLoad=="true")BackCountry.ButtonShowPlayer.Selected._visible = true;
		else BackCountry.ButtonShowPlayer.Selected._visible = false;
		delete(ShowPlayerOnLoad);
		
		if(Xml.childNodes[0].childNodes[0].attributes.ScanComplete=="true"){
			BackTheme.ButtonExit.Selected._visible=true;
		}else{
			BackTheme.ButtonExit.Selected._visible=false;
		}
		
		/// SlideShow ///		
		ImageSlidePath=Xml.childNodes[0].childNodes[1].attributes.ImagePath;
		BackSlideShow.txtImage.text=ImageSlidePath;
		TimeSlideValue=Xml.childNodes[0].childNodes[1].attributes.Time;
		SlideMode=Xml.childNodes[0].childNodes[1].attributes.SlideShowMode;
		fscommand("ChangeInterval",TimeSlideValue);
		BackSlideShow.txtTime.text=TimeSlideValue;
		SetSlideValue=Xml.childNodes[0].childNodes[1].attributes.SetSlideShow;
		
		if (SetSlideValue=="Yes")	BackSlideShow.ButtonSetSlideShow.chk._visible=true;
		else  BackSlideShow.ButtonSetSlideShow.chk._visible=false;
		
		DelaySlideValue=Xml.childNodes[0].childNodes[1].attributes.Delay;
		BackSlideShow.txtDelay.text=DelaySlideValue;
		
		ImageSlideSize=Xml.childNodes[0].childNodes[1].attributes.ImageSize;
		BackSlideShow.txtImageSize.text=ImageSlideSize;
		
		StretchValue=Xml.childNodes[0].childNodes[1].attributes.Stretch;
		if(StretchValue=="Yes")BackSlideShow.ButtonStretch.chk._visible=true;
		else BackSlideShow.ButtonStretch.chk._visible=false;
		
		ShowValue=Xml.childNodes[0].childNodes[1].attributes.ShowFileName;
		if(ShowValue=="Yes")BackSlideShow.ButtonShow.chk._visible=true;
		else BackSlideShow.ButtonShow.chk._visible=false;
		
		EffectValue=Xml.childNodes[0].childNodes[1].attributes.Effect;
		Random=Xml.childNodes[0].childNodes[1].attributes.Random;
		if(EffectValue=="Yes")BackSlideShow.ButtonEffect.chk._visible=true;
		else BackSlideShow.ButtonEffect.chk._visible=false;
		
		ScrollValue=Xml.childNodes[0].childNodes[1].attributes.Scrolling;
		if(ScrollValue=="Yes")BackSlideShow.ButtonScroll.chk._visible=true;
		else BackSlideShow.ButtonScroll.chk._visible=false;
		if(Random=="Yes")BackSlideShow.ButtonRandom.chk._visible=true;
		else BackSlideShow.ButtonRandom.chk._visible=false;
		if(SlideMode=="Internal"){
			BackSlideShow.ButtonInSlide.Selected._visible=true;
			BackSlideShow.ButtonExSlide.Selected._visible=false;
		}
		else{
			BackSlideShow.ButtonInSlide.Selected._visible=false;
			BackSlideShow.ButtonExSlide.Selected._visible=true;
			BackSlideShow.ButtonRandom.chk._visible=true;
			fscommand("request_slideshow_path",true);
		}
			//.........ProFile...............
			if (Xml.childNodes[0].childNodes[2].attributes.MicroScale == "640 x 480"){
				BackRipAndPlay.TextMicroScale.text = "Large";
			}else if (Xml.childNodes[0].childNodes[2].attributes.MicroScale == "800 x 600"){
				BackRipAndPlay.TextMicroScale.text = "Medium";
			}else if (Xml.childNodes[0].childNodes[2].attributes.MicroScale == "1024 x 768"){
				BackRipAndPlay.TextMicroScale.text = "Small";
			}
		//BackTheme.TextMicroScale.text=Xml.childNodes[0].childNodes[2].attributes.MicroScale;
		if(Xml.childNodes[0].childNodes[2].attributes.Micro=="true"){
			BackRipAndPlay.ButtonMicro.selected._visible=true;
		}else{
			BackRipAndPlay.ButtonMicro.selected._visible=false;
		}
		if(Xml.childNodes[0].childNodes[2].attributes.clone_only=="true"){
			BackRipAndPlay.ButtonOnly.selected._visible=true;
		}else{
			BackRipAndPlay.ButtonOnly.selected._visible=false;
		}
		if(Xml.childNodes[0].childNodes[2].attributes.Tooltip=="true"){
			BackTheme.ButtonTooltip.Selected._visible=true;
		}else{
			BackTheme.ButtonTooltip.Selected._visible=false;
		}
		if(Xml.childNodes[0].childNodes[2].attributes.TextScroll=="true"){
			BackRipAndPlay.ButtonScroll.Selected._visible=true;
			
		}else{
			BackRipAndPlay.ButtonScroll.Selected._visible=false;
		}
		if(Xml.childNodes[0].childNodes[2].attributes.Ads=="true"){
			BackTheme.ButtonAds.Selected._visible=true;
			
		}else{
			BackTheme.ButtonAds.Selected._visible=false;
		}
		Bg._visible=true;
		TopBar._visible=true;
		if(DisplayPage=="BackAlbum") 					Bar.ButtonAlbum.onRelease();
		else if(DisplayPage=="BackSlideShow" and clientType==serverMode)Bar.ButtonSlideShow.onRelease();
		else if(DisplayPage=="BackPlayList") 				Bar.ButtonProFile.onRelease();
		else if(DisplayPage=="BackCountry") 				Bar.ButtonCountry.onRelease();
		else if(DisplayPage=="BackTheme") 				Bar.ButtonTheme.onRelease();
		else if(DisplayPage=="BackRipAndPlay") 				Bar.ButtonRipAndPlay.onRelease();
		else 								Bar.ButtonAlbum.onRelease();
		Bar.ButtonSlideShow.enabled = (clientType==serverMode);		//Enable only in Servermode
		TopBar.ButtonM.onRollOver();
//		delete(Xml);
	}
}

//OpenXml(MusicPath+"/Setting.xml");
function SetFontColor(Value){
	var FormatFont1 = new TextFormat();
	FormatFont1.font = EnglishFont;
	FormatFont1.size = EngFontSize;
	FormatFont1.bold = true;
	//for(var j=0;j<nList;j++){
	//	eval("BackPlayList.BackListD.Text"+j).textColor=Value;
	//}
	
	for (var init=0;init<5;init++){
		eval("BackCountry.MenuCountry.Text"+init).textColor = Value;
		eval("BackPlayList.BackListD.Text"+init).textColor = Value;
	}
	
	Menu.Exit.Text.textColor=Value;
	Menu.Min.Text.textColor=Value;
	Menu.Scan.Text.textColor=Value;
	Menu.RipCD.Text.textColor=Value;
	
	Menu.AboutSly.Text.textColor=Value;
	Menu.MISC.Text.textColor=Value;
	Menu.MISC.Arrow.textColor=Value;
	Menu.MISC.Arrow._visible=true;
	MenuMISC.UpDateDB.Text.textColor=Value;
	MenuMISC.RestoreDB.Text.textColor=Value;
	MenuMISC.BackUpDB.Text.textColor=Value;
	MenuMISC.CopyFolder.Text.textColor=Value;
	MenuMISC.AddNewScreen.Text.textColor=Value;
	
	//Menu.Exit.Text.setTextFormat(FormatFont1);
	//Menu.Min.Text.setTextFormat(FormatFont1);
	//Menu.Scan.Text.setTextFormat(FormatFont1);
	
	
	//BackCountry.TextCountry.textColor=Value;
}

////		THEME ACTION 		\\\
YTrack=BackTheme.TextEngFont._y;
BackTheme.TextPos.onChanged=function(){
	BackTheme.TextEngFont._y=YTrack+parseInt(BackTheme.TextPos.text,10);
	fscommand("ChangeTrackPos",parseInt(BackTheme.TextPos.text,10));
}
YTrack1=BackTheme.TextUniFont._y;
BackTheme.TextPos1.onChanged=function(){
	BackTheme.TextUniFont._y=YTrack1+parseInt(BackTheme.TextPos1.text,10);
	fscommand("ChangeTrackPosUni",parseInt(BackTheme.TextPos1.text,10));
}
BackTheme.ButtonTooltip.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieTooltip",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=3;
}
BackTheme.ButtonTooltip.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	
	var Value="";
	if(BackTheme.ButtonTooltip.Selected._visible){
		BackTheme.ButtonTooltip.Selected._visible=false;
		Value="false";
	}

	else{
		BackTheme.ButtonTooltip.Selected._visible=true;
		Value="true";
	}
	fscommand("Tooltip",Value);	
}
//---------------------------------------------

BackTheme.ButtonPopupExit.onRollOver=function(){
	SelectMovieClip("BackTheme.MoviePopupExit",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=3;
}
BackTheme.ButtonPopupExit.onRelease=function(){
   if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackTheme.ButtonPopupExit.Selected._visible = !(BackTheme.ButtonPopupExit.Selected._visible);
	fscommand("popup_exit",BackTheme.ButtonPopupExit.Selected._visible);
}

//---------------------------------------------
BackTheme.ButtonWinMode.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Display Mode (Ctrl+W)",SHTT,-(153/2)+5,-20);
	SelectMovieClip("BackTheme.MovieWinMode",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=3;
}
BackTheme.ButtonWinMode.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackTheme.ButtonWinMode.onRelease=function(){
	switch(BackTheme.TextWinMode.text){
		case "FullScreen Mode":
			BackTheme.TextWinMode.text="Window Mode";
			fscommand("SlyMode","Window Mode");
			break;
		case "Window Mode":
			BackTheme.TextWinMode.text="FullScreen Mode";
			fscommand("SlyMode","FullScreen Mode");
			break;
	}
}
BackRipAndPlay.ButtonScroll.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieScroll",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonScroll.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	var Value="false";
	if(BackRipAndPlay.ButtonScroll.Selected._visible){
		BackRipAndPlay.ButtonScroll.Selected._visible=false;
		Value="false";
	}
	else{
		BackRipAndPlay.ButtonScroll.Selected._visible=true;
		Value="true";
	}
	fscommand("textScroll",Value);
}
BackRipAndPlay.ButtonSyn_vol.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieSyn_vol",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}

BackRipAndPlay.txtDaemonDrive.onKillFocus = function (newFocus) {
	fscommand("DaemonDrive",BackRipAndPlay.txtDaemonDrive.text);
}; 
//---------------
BackRipAndPlay.txtVLCExtension.onKillFocus = function (newFocus) {
	fscommand("VLCExtension",BackRipAndPlay.txtVLCExtension.text);
}; 
//----------------
BackRipAndPlay.txtPowerDVDExtension.onKillFocus = function (newFocus) {
	fscommand("PowerDVDExtension",BackRipAndPlay.txtPowerDVDExtension.text);
}; 
//---------
BackRipAndPlay.ButtonSyn_vol.onRelease=function(){
	if ((user_sign_in_index == "")||(clientType == serverMode)){
		if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}
		BackRipAndPlay.ButtonSyn_vol.Selected._visible = !(BackRipAndPlay.ButtonSyn_vol.Selected._visible);
		fscommand("syn_vol",BackRipAndPlay.ButtonSyn_vol.Selected._visible);
	}
}
//----------------------------------------------------------------------------------------------------
BackRipAndPlay.ButtonChange_vol.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieChange_vol",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonChange_vol.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonChange_vol.Selected._visible = !(BackRipAndPlay.ButtonChange_vol.Selected._visible);
	fscommand("change_vol",BackRipAndPlay.ButtonChange_vol.Selected._visible);
}
//--------------------------------------------------------
BackRipAndPlay.ButtonPopup.onRollOver=function(){
   if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	SelectMovieClip("BackRipAndPlay.MoviePopup",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonPopup.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonPopup.Selected._visible = !(BackRipAndPlay.ButtonPopup.Selected._visible);
	BackRipAndPlay.GDI._visible = 	BackRipAndPlay.ButtonPopup.Selected._visible;
	fscommand("Popup",BackRipAndPlay.ButtonPopup.Selected._visible)
//-----------------------------------------------------------
BackRipAndPlay.GDI.ButtonGDI.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.GDI.MovieGDI",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.GDI.ButtonNOGDI.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.GDI.MovieNOGDI",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}

	
/*    if(BackRipAndPlay.MoviePopup._visible=true){
		BackRipAndPlay.GDI._visible=true;
		fscommand("mb",BackRipAndPlay.GDI._visible);
		}
	else{
		BackRipAndPlay.GDI._visible=false;
		fscommand("mb",BackRipAndPlay._visible);
		}
		
		
	fscommand("GDI",BackRipAndPlay.ButtonPopup.Selected._visible);*/
}

//--------------------------------------------------------
BackRipAndPlay.ButtonCloneOnly.onRollOver=function(){
	
	SelectMovieClip("BackRipAndPlay.MovieCloneOnly",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonCloneOnly.onRelease=function(){	
   if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonCloneOnly.Selected._visible = !(BackRipAndPlay.ButtonCloneOnly.Selected._visible);
	fscommand("clone_playback",BackRipAndPlay.ButtonCloneOnly.Selected._visible);
}
//--------------------------------------------------------
BackRipAndPlay.ButtonCloneAndDisplay.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieCloneAndDisplay",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonCloneAndDisplay.onRelease=function(){	
    if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonCloneAndDisplay.Selected._visible = !(BackRipAndPlay.ButtonCloneAndDisplay.Selected._visible);
	fscommand("clone_display",BackRipAndPlay.ButtonCloneAndDisplay.Selected._visible);
}
//--------------------------------------------------------
BackRipAndPlay.ButtonIndependent.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieIndependent",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
    BackRipAndPlay.ButtonIndependent.onRelease=function(){	
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonIndependent.Selected._visible = !(BackRipAndPlay.ButtonIndependent.Selected._visible);
	fscommand("independent",BackRipAndPlay.ButtonIndependent.Selected._visible);
}
//--------------------------------------------------------
BackRipAndPlay.ButtonremoteControl.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieremoteControl",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
    BackRipAndPlay.ButtonremoteControl.onRelease=function(){	
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonremoteControl.Selected._visible = !(BackRipAndPlay.ButtonremoteControl.Selected._visible);
	fscommand("Remotecontrol",BackRipAndPlay.ButtonremoteControl.Selected._visible);
}
//--------------------------------------------------------
BackRipAndPlay.ButtonDualVideo.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieDualVideo",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
    BackRipAndPlay.ButtonDualVideo.onRelease=function(){	
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonDualVideo.Selected._visible = !(BackRipAndPlay.ButtonDualVideo.Selected._visible);
	fscommand("DualVideo",BackRipAndPlay.ButtonDualVideo.Selected._visible);
}
//--------------------------------------------------------

BackTheme.ButtonMouse.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Show/Hide Mouse (Ctrl+F3)",SHTT,0,20);
	SelectMovieClip("BackTheme.MovieMouse",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=3;
}
BackTheme.ButtonMouse.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	
	if(BackTheme.ButtonMouse.Selected._visible){
		BackTheme.ButtonMouse.Selected._visible=false;
		HideMouse="false";
		Mouse.show();
//		ButtonHideMouse._visible=false;
	}
	else{
		BackTheme.ButtonMouse.Selected._visible=true;
		HideMouse="true";
		Mouse.hide();
//		ButtonHideMouse._visible=true;
	}
	fscommand("HideMouse",HideMouse);
}


BackTheme.ButtonAds.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieAds",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=3;
}
BackTheme.ButtonAds.onRelease=function(){
	var Value="false";
	if(BackTheme.ButtonAds.Selected._visible){
		BackTheme.ButtonAds.Selected._visible=false;
		Value="false";
	}
	else{
		BackTheme.ButtonAds.Selected._visible=true;
		Value="true";
	}
	fscommand("AdsValue",Value);
}

BackTheme.ButtonColorBar.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieColorBar");
	LevelSelect = 3;
}
BackTheme.ButtonColorBar.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="ColorBar";
	//fscommand("ShowColorBarBox",ColorBar);
}
BackTheme.ButtonColorRating.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieColorRating");
	LevelSelect = 3;
}
BackTheme.ButtonColorRating.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="ColorRating";
	

}

BackTheme.ButtonColor.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieColor");
	LevelSelect = 3;
}
BackTheme.ButtonColor.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="Bg";
	//fscommand("ShowColorBox",ColorValue);
}
var ObjColor;
function ChooseColor(){
	if(ObjColor=="Bg"){
		ColorValue=ColorPicker.getCol();
		ChangeColorNoAlpha("BackTheme.MovieColor",ColorValue);
		ChangeColorNoAlpha("Bg",ColorValue);
		fscommand("ShowColorBox",ColorValue);
	}
	else if(ObjColor=="FontColor"){
		FontColorValue=ColorPicker.getCol();
		ChangeColorText(FontColorValue);
		ChangeColorNoAlpha("BackTheme.MovieFontColor",FontColorValue);
		fscommand("ChangeColorFont",FontColorValue)
	}
	else if(ObjColor=="FrameColor"){
		ButtonColorValue=ColorPicker.getCol();
		ChangeColorAlpha("BackTheme.MovieFrame",ButtonColorValue,ButtonAlphaValue);
		ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
		fscommand("ChangeButtonColor",ButtonColorValue);
	}
	else if(ObjColor=="SelFrameColor"){
		SelectButtonColorValue=ColorPicker.getCol();
		ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);
		ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
		fscommand("ChangeSelButtonColor",SelectButtonColorValue);
	}
	else if(ObjColor=="ColorBar"){
		TrackShow.setTrackDisplayTheme(FontColorValue,ColorBar);
		ColorBar=ColorPicker.getCol();
		ChangeColorNoAlpha("BackTheme.MovieColorBar",ColorBar);
		ChangeColorNoAlpha("TopBar.Bar",ColorBar);
		ChangeColorNoAlpha("Bar.Bar",ColorBar);
		ChangeColorNoAlpha("Menu.Bar",ColorBar);

		ChangeColorNoAlpha("MenuMISC.Bar", ColorBar);
		fscommand("ShowColorBarBox",ColorBar);
	}
	else if(ObjColor=="ColorRating"){
		ColorRating=ColorPicker.getCol();
		ChangeColorNoAlpha("BackTheme.MovieColorRating",ColorRating);
		fscommand("ShowColorRatingBox",ColorRating);
	}
	hideColorPicker();
}
BackAlbum.ButtonCover.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","enable/disable (Ctrl+1)",SHTT,0,17);
	SelectMovieClip("BackAlbum.MovieCover");
	LevelSelect = 7;
}
BackAlbum.ButtonCover.onRollOut=function(){
	HideTooltip("txtTooltip");
}

BackAlbum.ButtonCover.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	
	if(CoverAlbum=="No"){
		BackAlbum.ButtonCover.Selected._visible=true;
		CoverAlbum="Yes";
	}
	else{
		BackAlbum.ButtonCover.Selected._visible=false;
		CoverAlbum="No";
	}
	fscommand("ChangeCoverAlbum",CoverAlbum);
}
BackAlbum.ButtonCoverNum.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","enable/disable (Ctrl+2)",SHTT,0,17);
	SelectMovieClip("BackAlbum.MovieCoverNum");
	LevelSelect = 7;
}
BackAlbum.ButtonCoverNum.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackAlbum.ButtonCoverNum.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(CoverNum=="No"){
		BackAlbum.ButtonCoverNum.Selected._visible=true;
		CoverNum="Yes";
	}
	else{
		BackAlbum.ButtonCoverNum.Selected._visible=false;
		CoverNum="No";
	}
	fscommand("ChangeCoverNum",CoverNum);
}
BackRipAndPlay.ButtonMicroScale.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieMicroScale");
	LevelSelect = 9;
	
}
BackRipAndPlay.ButtonMicroScale.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	var size = "";
	switch(BackRipAndPlay.TextMicroScale.text){		
		case "Small":
			size = "640 x 480";
			BackRipAndPlay.TextMicroScale.text="Large";
			break;			
		case "Large":
			size = "800 x 600";
			BackRipAndPlay.TextMicroScale.text="Medium";
			break;
		case "Medium":
			size = "1024 x 768";
			BackRipAndPlay.TextMicroScale.text="Small";
			break;
		default:
			size = "640 x 480";
			BackRipAndPlay.TextMicroScale.text="Large";
			break;
	}
	fscommand("ChangeMicroScale",size);//BackTheme.TextMicroScale.text);
}
BackRipAndPlay.ButtonMicro.onRollOver=function(){	
	DisplayTooltip(this,"txtTooltip","enable/disable (Ctrl+K)",SHTT,-(153/2)+5,20);
	SelectMovieClip("BackRipAndPlay.MovieMicro");
	LevelSelect = 9;
}
BackRipAndPlay.ButtonMicro.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackRipAndPlay.ButtonMicro.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(BackRipAndPlay.ButtonMicro.selected._visible){
		BackRipAndPlay.ButtonMicro.selected._visible=false;
	}
	else{
		BackRipAndPlay.ButtonMicro.selected._visible=true;
	}
	fscommand("ChangeMicroPlayer",BackRipAndPlay.ButtonMicro.selected._visible);
}
//-------------------------------------------------
BackRipAndPlay.ButtonResize.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Resize",SHTT,-(153/2)+5,20);
	SelectMovieClip("BackRipAndPlay.MovieResize");
	LevelSelect = 9;
}
BackRipAndPlay.ButtonResize.onRollOut = function(){
	HideTooltip("txtTooltip");
}
BackRipAndPlay.ButtonResize.onRelease = function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonResize.selected._visible = !(BackRipAndPlay.ButtonResize.selected._visible);
	fscommand("ResizeFromServer",BackRipAndPlay.ButtonResize.selected._visible);
}
//-------------------------------------------------
BackRipAndPlay.ButtonReEncode.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Re-encode",SHTT,-(153/2)+5,20);
	SelectMovieClip("BackRipAndPlay.MovieReEncode");
	LevelSelect = 9;
}
BackRipAndPlay.ButtonReEncode.onRollOut = function(){
	HideTooltip("txtTooltip");
}
BackRipAndPlay.ButtonReEncode.onRelease = function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonReEncode.selected._visible = !(BackRipAndPlay.ButtonReEncode.selected._visible);
	fscommand("setReencode",BackRipAndPlay.ButtonReEncode.selected._visible);
}
//-------------------------------------------------
BackRipAndPlay.ButtonDownloadAll.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Download All Track",SHTT,-(153/2)+5,20);
	SelectMovieClip("BackRipAndPlay.MovieDownloadAll");
	LevelSelect = 9;
}
BackRipAndPlay.ButtonDownloadAll.onRollOut=function(){
	HideTooltip("txtTooltip");

}
BackRipAndPlay.ButtonDownloadAll.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonDownloadAll.selected._visible = !(BackRipAndPlay.ButtonDownloadAll.selected._visible);
	fscommand("setDownloadAll",BackRipAndPlay.ButtonDownloadAll.selected._visible);
}
//-------------------------------------------------
BackRipAndPlay.ButtonOnly.onRollOver=function(){	
	DisplayTooltip(this,"txtTooltip","Control Only",SHTT,-(153/2)+5,20);
	SelectMovieClip("BackRipAndPlay.MovieOnly");
	LevelSelect = 9;
}
BackRipAndPlay.ButtonOnly.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackRipAndPlay.ButtonOnly.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(BackRipAndPlay.ButtonOnly.selected._visible){
		BackRipAndPlay.ButtonOnly.selected._visible=false;
	}
	else{
		BackRipAndPlay.ButtonOnly.selected._visible=true;
	}
	fscommand("control_only",BackRipAndPlay.ButtonOnly.selected._visible);
}

BackAlbum.ButtonCoverPlus.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","enable/disable (Ctrl+3)",SHTT,0,17);
	SelectMovieClip("BackAlbum.MovieCoverPlus");
	LevelSelect = 7;	
}
BackAlbum.ButtonCoverPlus.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackAlbum.ButtonCoverPlus.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(CoverPlus=="No"){
		BackAlbum.ButtonCoverPlus.Selected._visible=true;
		CoverPlus="Yes";
	}
	else{
		BackAlbum.ButtonCoverPlus.Selected._visible=false;
		CoverPlus="No";
	}
	fscommand("ChangeCoverPlus",CoverPlus);
}


BackAlbum.ButtonAlbumNum.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Display Album (Ctrl+J)",SHTT,-(153/2)+5,17);
	SelectMovieClip("BackAlbum.MovieAlbumNum");
	LevelSelect = 7;
}
BackAlbum.ButtonAlbumNum.onRollOut=function(){
	HideTooltip("txtTooltip");
}
BackAlbum.ButtonAlbumNum.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	switch(BackAlbum.TextAlbumNum.text){
		case "Large": BackAlbum.TextAlbumNum.text="Medium";break;
		case "Medium": BackAlbum.TextAlbumNum.text="Small";break;
		case "Small": BackAlbum.TextAlbumNum.text="Large";break;
		default :BackAlbum.TextAlbumNum.text="Large";break;
	}
	fscommand("ChangeAlbumNum",BackAlbum.TextAlbumNum.text);
}
BackTheme.ButtonFontColor.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieFontColor");
	LevelSelect = 3;
}
BackTheme.ButtonFontColor.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="FontColor";
	//fscommand("ChangeColorFont");	
}
BackTheme.ButtonEngFont.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieEngFont");
	LevelSelect = 3;
}
BackTheme.ButtonEngFont.onRelease=function(){
	fscommand("ChangeEngFont",EnglishFont+","+EngFontSize);
}
BackTheme.ButtonUniFont.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieUniFont");
	LevelSelect = 3;
}
BackTheme.ButtonUniFont.onRelease=function(){
	fscommand("ChangeUniFont",UnicodeFont+","+UniFontSize);
}
BackTheme.ButtonFrame.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieFrame");
	LevelSelect = 3;
}
BackTheme.ButtonFrame.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="FrameColor";
	//fscommand("ChangeButtonColor");
}
BackTheme.ButtonSelFrame.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieSelFrame");
	LevelSelect = 3;
}
BackTheme.ButtonSelFrame.onRelease=function(){
	//ColorPicker._visible=true;
	ShowColorPicker();
	ObjColor="SelFrameColor";
	//fscommand("ChangeSelButtonColor");
}
BackTheme.TextAlphaValue.onChanged=function(){
	if(parseInt(BackTheme.TextAlphaValue.text,10)>100){
		BackTheme.TextAlphaValue.text=100;
	}
	ButtonAlphaValue=parseInt(BackTheme.TextAlphaValue.text,10)
	fscommand("ChangeButtonAlpha",ButtonAlphaValue);
	//ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);
    ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
    ChangeColorAlpha("BackTheme.MovieFrame",ButtonColorValue,ButtonAlphaValue);
}
BackTheme.TextSelAlphaValue.onChanged=function(){
	if(parseInt(BackTheme.TextSelAlphaValue.text,10)>100){
		BackTheme.TextSelAlphaValue.text=100;
	}
	SelectButtonAlphaValue=parseInt(BackTheme.TextSelAlphaValue.text,10);
	fscommand("ChangeSelButtonAlpha",SelectButtonAlphaValue);
	ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);
    ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
}
BackAlbum.ButtonBrowse.onRollOver=function(){
	SelectMovieClip("BackAlbum.MovieBrowse");
	LevelSelect = 7;
}
BackAlbum.ButtonBrowse.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	switch(BackAlbum.TextBrowse.text){
		case "Genre":
			BackAlbum.TextBrowse.text="Production";
			if(SortedValue==1)BackAlbum.TextFavAlbum.text="Alphabet";
			else BackAlbum.TextFavAlbum.text="ReleaseDate";
			fscommand("ChangeBrowse","Browse~Production");
			break;
		case "Production":
			BackAlbum.TextBrowse.text="Rating";
			BackAlbum.TextFavAlbum.text="Alphabet";
			fscommand("ChangeBrowse","Browse~Rating");
			break;
		case "Rating":
			BackAlbum.TextBrowse.text="ReleaseDate";
			if(SortedValue==1)BackAlbum.TextFavAlbum.text="Alphabet";
			else BackAlbum.TextFavAlbum.text="ReleaseDate";
			fscommand("ChangeBrowse","Browse~ReleaseDate");
			break;
		case "ReleaseDate":
			BackAlbum.TextBrowse.text="MyFavoriteAlbum";
			BackAlbum.TextFavAlbum.text=MyFavAlbumValue;
			fscommand("ChangeBrowse","MyFavAlbum"+"~"+MyFavAlbumValue);
			break;
		case "MyFavoriteAlbum":
			BackAlbum.TextBrowse.text="MyFavoriteArtist";
			BackAlbum.TextFavAlbum.text=MyFavArtistValue;
			fscommand("ChangeBrowse","MyFavArtist"+"~"+MyFavArtistValue);
			break;
		case "MyFavoriteArtist":
			BackAlbum.TextBrowse.text="MyAlbum";
			BackAlbum.TextFavAlbum.text=MyAlbum;
			fscommand("ChangeBrowse","MyAlbum"+"~"+MyAlbum);
			break;
		case "MyAlbum":
			BackAlbum.TextBrowse.text="Genre";
			if(SortedValue==1)BackAlbum.TextFavAlbum.text="Alphabet";
			else BackAlbum.TextFavAlbum.text="ReleaseDate";
			fscommand("ChangeBrowse","Browse~Genre");
			break;
	}
}


BackAlbum.ButtonFavAlbum.onRollOver=function(){
	SelectMovieClip("BackAlbum.MovieFavAlbum");
	LevelSelect = 7;
}
BackAlbum.ButtonFavAlbum.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	switch(BackAlbum.TextBrowse.text){
		case "MyFavoriteAlbum":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					MyFavAlbumValue1="ReleaseDate";
					BackAlbum.TextFavAlbum.text="ReleaseDate";
					break;
				case "ReleaseDate":
					MyFavAlbumValue1="Rating";
					BackAlbum.TextFavAlbum.text="Rating";break;
				case "Rating":
					MyFavAlbumValue1="Rank";
					BackAlbum.TextFavAlbum.text="Rank";break;
				case "Rank":
					MyFavAlbumValue1="MyFavorite";
					BackAlbum.TextFavAlbum.text="Alphabet";break;
			}
			fscommand("ChangeSorted","MyFavAlbum~"+MyFavAlbumValue1);
			break;
		case "MyAlbum":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					MyAlbum1="ReleaseDate";
					BackAlbum.TextFavAlbum.text="ReleaseDate";
					break;
				case "ReleaseDate":
					MyAlbum1="Rating";
					BackAlbum.TextFavAlbum.text="Rating";break;
				case "Rating":
					MyAlbum1="Rank";
					BackAlbum.TextFavAlbum.text="Rank";break;
				case "Rank":
					MyAlbum1="MyFavorite";
					BackAlbum.TextFavAlbum.text="Alphabet";break;
			}
			fscommand("ChangeSorted","MyAlbum~"+MyAlbum1);
			break;
		case "MyFavoriteArtist":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					MyFavArtistValue1="ReleaseDate";
					BackAlbum.TextFavAlbum.text="ReleaseDate";break;
				case "ReleaseDate":
					MyFavArtistValue1="Rank";
					BackAlbum.TextFavAlbum.text="Rank";break;
				case "Rank":
					MyFavArtistValue1="MyFavorite";
					BackAlbum.TextFavAlbum.text="Alphabet";break;
			}
			fscommand("ChangeSorted","MyFavArtist~"+MyFavArtistValue1);
			break;
		case "Genre":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					BackAlbum.TextFavAlbum.text="ReleaseDate";
					SortedValue=0;
					break;
				case "ReleaseDate":
					BackAlbum.TextFavAlbum.text="Alphabet";
					SortedValue=1;
					break;
			}
			fscommand("ChangeSorted","Genre~"+SortedValue);
			break;
		case "Production":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					SortedValue=0;
					BackAlbum.TextFavAlbum.text="ReleaseDate";
					break;
				case "ReleaseDate":
					SortedValue=1;
					BackAlbum.TextFavAlbum.text="Alphabet";
					break;
			}
			fscommand("ChangeSorted","Production~"+SortedValue);
			break;
		case "ReleaseDate":
			switch(BackAlbum.TextFavAlbum.text){
				case "Alphabet":
					BackAlbum.TextFavAlbum.text="ReleaseDate";
					SortedValue=0;
					break;
				case "ReleaseDate":
					BackAlbum.TextFavAlbum.text="Alphabet";
					SortedValue=1;
					break;
			}
			fscommand("ChangeSorted","ReleaseDate~"+SortedValue);
			break;
	}
	//fscommand("ChangeMyFavAlbum",BackAlbum.TextFavAlbum.text);
}

BackTheme.ButtonManual.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieManual");
	LevelSelect = 3;
}
BackTheme.ButtonManual.onRelease=function(){
	BackTheme.ButtonManual.Selected._visible=true;
	BackTheme.ButtonAutomatic.Selected._visible=false;
	DisplayKeyBoard="No";
	fscommand("DisplayKeyBoard",DisplayKeyBoard);
}
BackTheme.ButtonAutomatic.onRollOver=function(){
	SelectMovieClip("BackTheme.MovieAutomatic");
	LevelSelect = 3;
}
BackTheme.ButtonAutomatic.onRelease=function(){
	BackTheme.ButtonManual.Selected._visible=false;
	BackTheme.ButtonAutomatic.Selected._visible=true;
	DisplayKeyBoard="Yes";
	fscommand("DisplayKeyBoard",DisplayKeyBoard);
}
///		SLIDESHOW ACTION		///
BackSlideShow.ButtonDir.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieDir");
	LevelSelect = 4;
}
BackSlideShow.ButtonDir.onRelease=function(){
	fscommand("SlidePath",ImageSlidePath);
}
BackSlideShow.ButtonInSlide.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieInSlide");
	LevelSelect = 4;
}
BackSlideShow.ButtonExSlide.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieExSlide");
	LevelSelect = 4;
}
BackSlideShow.ButtonInSlide.onRelease = function(){
	if (send_event("normal&&&Click||" + this + "||6", false)){
		return;
	}
	SlideMode = "Internal";
	BackSlideShow.ButtonInSlide.Selected._visible = true;
	BackSlideShow.ButtonExSlide.Selected._visible = false;
	fscommand("SetSlideMode", SlideMode);
	
	if(Random == "Yes")BackSlideShow.ButtonRandom.chk._visible = true;
	else BackSlideShow.ButtonRandom.chk._visible = false;
}
BackSlideShow.ButtonExSlide.onRelease = function(){
	if (send_event("normal&&&Click||" + this + "||6", false)){
		return;
	}
	SlideMode = "External";
	BackSlideShow.ButtonInSlide.Selected._visible = false;
	BackSlideShow.ButtonExSlide.Selected._visible = true;
	fscommand("SetSlideMode", SlideMode);
	BackSlideShow.ButtonRandom.chk._visible = true;
}
//----------------------------------------------------------------------------------------------------
BackSlideShow.ButtonSetSlideShow.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Set SlideShow (Ctrl+ ~ )" ,SHTT,0,20);
	SelectMovieClip("BackSlideShow.MovieSetSlideShow");
	LevelSelect = 4;
}

BackSlideShow.ButtonSetSlideShow.onRelease=function(){
	fn_set_slideshow(SetSlideValue);	
}
function fn_set_slideshow(val_setSlideValue){	
	if (send_event("normal&&&function||fn_set_slideshow|~|" + val_setSlideValue + "||6",false)){
		return;
	}
	
	if(val_setSlideValue == "Yes"){
		BackSlideShow.ButtonSetSlideShow.chk._visible = false;
		SetSlideValue = "No";
	} else {
		BackSlideShow.ButtonSetSlideShow.chk._visible = true;
		SetSlideValue = "Yes";
	}
	fscommand("SetSlideShow",SetSlideValue + "," + ImageSlidePath);
}
//----------------------------------------------------------------------------------------------------
BackSlideShow.ButtonResize.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Resize From Server" ,SHTT,0,20);
	SelectMovieClip("BackSlideShow.MovieResize");
	LevelSelect = 4;
}

BackSlideShow.ButtonResize.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackSlideShow.ButtonResize.chk._visible = !(BackSlideShow.ButtonResize.chk._visible);
	fscommand("resize_image_server",BackSlideShow.ButtonResize.chk._visible);
}
//----------------------------------------------------------------------------------------------------
BackSlideShow.ButtonAllowSlideshow.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Allow/Deny Slideshow" ,SHTT,0,20);
	SelectMovieClip("BackSlideShow.MovieAllowSlideshow");
	LevelSelect = 4;
}

BackSlideShow.ButtonAllowSlideshow.onRelease=function(){
	if ((user_sign_in_index == "")||(clientType == serverMode)){
		fn_set_allow_slideshow(BackSlideShow.ButtonAllowSlideshow.chk._visible);
	}
}
function fn_set_allow_slideshow(val_a){
	if (send_event("normal&&&function||fn_set_allow_slideshow|~|" + val_a + "||6",false)){
		return;
	}
	val_a = String(val_a);
	val_a = (val_a == "true");
//	if (BackSlideShow.ButtonAllowSlideshow.enabled == true){
//		BackSlideShow.ButtonAllowSlideshow.chk._visible = !(BackSlideShow.ButtonAllowSlideshow.chk._visible);
		BackSlideShow.ButtonAllowSlideshow.chk._visible = !(val_a);
		fscommand("AllowSlideshow",BackSlideShow.ButtonAllowSlideshow.chk._visible);
//	}
}
//----------------------------------------------------------------------------------------------------
BackSlideShow.ButtonSyn.onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Set Syncronize SlideShow " ,SHTT,0,20);
	SelectMovieClip("BackSlideShow.MovieSyn");
	LevelSelect = 4;
}

BackSlideShow.ButtonSyn.onRelease=function(){
	if ((user_sign_in_index == "")||(clientType == serverMode)){
		if (send_event("normal&&&Click||" + this + "||6",false)){
			return;
		}
	//	if (BackSlideShow.ButtonSyn.enabled == true){
			BackSlideShow.ButtonSyn.chk._visible = !(BackSlideShow.ButtonSyn.chk._visible);
			fscommand("syn",BackSlideShow.ButtonSyn.chk._visible);
	//	}
	}
}

BackSlideShow.ButtonStretch.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieStretch");
	LevelSelect = 4;
}
BackSlideShow.ButtonStretch.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(StretchValue=="Yes"){
		BackSlideShow.ButtonStretch.chk._visible=false;
		StretchValue="No";
	}
	else{
		BackSlideShow.ButtonStretch.chk._visible=true;
		StretchValue="Yes";
	}
	fscommand("ChangeStretch",StretchValue);
}
BackSlideShow.ButtonShow.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieShow");
	LevelSelect = 4;
}
BackSlideShow.ButtonShow.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(ShowValue=="Yes"){
		BackSlideShow.ButtonShow.chk._visible=false;
		ShowValue="No";
	}
	else{
		BackSlideShow.ButtonShow.chk._visible=true;

		ShowValue="Yes";
	}
	fscommand("ChangeShow",ShowValue);
}
BackSlideShow.ButtonEffect.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieEffect");
	LevelSelect = 4;
}
BackSlideShow.ButtonEffect.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(EffectValue=="Yes"){
		BackSlideShow.ButtonEffect.chk._visible=false;
		EffectValue="No";
	}
	else{
		BackSlideShow.ButtonEffect.chk._visible=true;
		EffectValue="Yes";
	}
	fscommand("ChangeEffect",EffectValue);
	
}
BackSlideShow.ButtonScroll.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieScroll");
	LevelSelect = 4;
}
BackSlideShow.ButtonScroll.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(ScrollValue=="Yes"){
		BackSlideShow.ButtonScroll.chk._visible=false;
		ScrollValue="No";
	}
	else{
		BackSlideShow.ButtonScroll.chk._visible=true;
		ScrollValue="Yes";
	}
	fscommand("ChangeScroll",ScrollValue);
}
BackSlideShow.ButtonRandom.onRollOver=function(){
	SelectMovieClip("BackSlideShow.MovieRandom");
	LevelSelect = 4;
}
BackSlideShow.ButtonRandom.onRelease=function(){
    if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(!BackSlideShow.ButtonExSlide.Selected._visible){
		if(Random=="Yes"){
			BackSlideShow.ButtonRandom.chk._visible=false;
			Random="No";
		}
		else{
			BackSlideShow.ButtonRandom.chk._visible=true;
			Random="Yes";
		}
		fscommand("Random",Random);
	}
}

//----------------------------------------------------------------------------------------------------
BackSlideShow.txtTime.onChanged = function(){
	TimeSlideValue = parseInt(BackSlideShow.txtTime.text, 10);
	clearInterval(ID_set_time_slideshow);
	if((TimeSlideValue == 0) || (TimeSlideValue == 1) || (BackSlideShow.txtTime.text == "")){		
		TimeSlideValue = 1;
		BackSlideShow.txtTime.text = TimeSlideValue;
		ID_set_time_slideshow = setInterval(set_time_slideshow,3000,TimeSlideValue);
	} else {
		fscommand("ChangeInterval", TimeSlideValue);
	}
}
function set_time_slideshow(val_time){
	clearInterval(ID_set_time_slideshow);
	fscommand("ChangeInterval", val_time);	
}
//----------------------------------------------------------------------------------------------------
BackSlideShow.txtDelay.onChanged=function(){
	DelaySlideValue=parseInt(BackSlideShow.txtDelay.text,10);
	if(DelaySlideValue==0){
		DelaySlideValue=1;
		BackSlideShow.txtDelay.text=1;
	}
	fscommand("ChangeDelay",DelaySlideValue);
}
BackSlideShow.txtImageSize.onChanged=function(){
	ImageSlideSize=parseInt(BackSlideShow.txtImageSize.text,10);
	if(ImageSlideSize==0){
		ImageSlideSize=1
		BackSlideShow.txtImageSize.text=ImageSlideSize;
	}
	fscommand("ChangeImageSize",ImageSlideSize);
}

GetColorReady="false";
FirstAccess="true";
_root.onEnterFrame = function() {
	if (Key.isDown(Key.ESCAPE)) {
		if (ColorPicker._visible == true){
			hideColorPicker();
			eval(Replace(StoreNameSelected, "Movie", "Button")).onRollOver();
		}
		else if(WarningUpdate._visible)WarningUpdate.ButtonCancel.onRelease();
		else if(UpdateDB._visible)UpdateDB.ButtonCancel.onRelease();
		else if(RestoreDB._visible)RestoreDB.ButtonCancel.onRelease();
		else if(BackUpDB._visible)BackUpDB.ButtonCancel.onRelease();
		else if(CopyMusic._visible)CopyMusic.ButtonCancel.onRelease();
		else if(AddNewScreens._visible)AddNewScreens.ButtonCancel.onRelease();
		else if(BackPlayList.BackListD._visible){
			BackPlayList.BackListD._visible=false;
			ValClickD=0
			BackPlayList.ButtonDir.onRollOver();
		}else if(BackCountry.MenuCountry._visible){
			BackCountry.MenuCountry._visible=false;
			BackCountry.ButtonCountry.onRollOver();
		}
	}
	if(GetPath.length>0){
		MusicPath=GetPath;
		TopBar.Flag.loadMovie(CountryPath+"\\Folder.jpg");
		OpenXml(GetPath+"\\Sly\\Setting.xml");
		if(Grouping=="0")BackAlbum.ButtonGroupAlbumType.onRelease();
		else BackAlbum.ButtonAllAlbumType.onRelease();
		GetPath="";
		delete(GetPath);
		if(parseInt(UnloadIndex,10)>0){
			fscommand("UnloadSwf",UnloadIndex);
		}
	}
	if(GetColorReady=="true"){
		GetColorReady="false";
		if(PassBgColorValue.length>0){
			ColorValue=PassBgColorValue;
			ChangeColorNoAlpha("BackTheme.MovieColor",ColorValue);
			ChangeColorNoAlpha("Bg",ColorValue);
			PassBgColorValue="";
			delete(PassBgColorValue);
		}
		else if(PassColorBarValue.length>0){
			TrackShow.setTrackDisplayTheme(FontColorValue,ColorBar);
			ColorBar=PassColorBarValue;
			ChangeColorNoAlpha("BackTheme.MovieColorBar",ColorBar);
			ChangeColorNoAlpha("TopBar.Bar",ColorBar);
			ChangeColorNoAlpha("Bar.Bar",ColorBar);
			ChangeColorNoAlpha("Menu.Bar",ColorBar);
			ChangeColorNoAlpha("MenuMISC.Bar", ColorBar);
			PassColorBarValue="";
			delete(PassColorBarValue);
		}
		else if(PassFontColorValue.length>0){
			FontColorValue=PassFontColorValue;
			ChangeColorText(FontColorValue);
			ChangeColorNoAlpha("BackTheme.MovieFontColor",FontColorValue);
			PassFontColorValue=""
			delete(PassFontColorValue);
		}
		else if(PassFontEngValue.length>0){
			EnglishFont=PassFontEngValue;
			EngFontSize=PassFontEngSize;
			BackTheme.TextEngFont.text=EnglishFont;
			SetFont("BackTheme.TextEngFont",EnglistFont,EngFontSize,false);
			PassFontEngValue="";
			delete(PassFontEngValue);
		}
		else if(PassFontUniValue.length>0){
			UnicodeFont=PassFontUniValue;
			UniFontSize=PassFontUniSize;
			BackTheme.TextUniFont.text=UnicodeFont;
			SetFont("BackTheme.TextUniFont",UnicodeFont,UniFontSize,true);
			PassFontUniValue="";
			delete(PassFontUniValue);
		}
		else if(PassButtonColorValue.length>0){
			ButtonColorValue=PassButtonColorValue;
			ChangeColorAlpha("BackTheme.MovieFrame",ButtonColorValue,ButtonAlphaValue);
			PassButtonColorValue="";
			delete(PassButtonColorValue);
			ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
		}
		else if(PassSelButtonColorValue.length>0){
			SelectButtonColorValue=PassSelButtonColorValue;
			ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);
			PassSelButtonColorValue="";
			delete(PassSelButtonColorValue);
			ChangeColorMovie(ButtonColorValue,ButtonAlphaValue);
		}
		////////...........Slide Action...........
		else if(SetSlideShowValue.length>0){
			BackSlideShow.ButtonSetSlideShow.onRelease();
			delete(SetSlideShowValue);
		}
		else if(PassSlidePathValue.length>0){
			ImageSlidePath=PassSlidePathValue;
			BackSlideShow.txtImage.text = ImageSlidePath;
			PassSlidePathValue="";
			delete(PassSlidePathValue);
		}
		else if(PassSlideValue.length>0){
			SetSlideValue=PassSlideValue;
			if(SetSlideValue=="Yes")BackSlideShow.ButtonSetSlideShow.chk._visible=true;

			else BackSlideShow.ButtonSetSlideShow.chk._visible=false;
			PassSlideValue="";
			delete(PassSlideValue);
		}
		///............ProFile..................
		else if(PassPic1Value.length>0){
			PathPic1=PassPic1Value;
			BackPlayList.Image1.loadMovie(PassPic1Value);
			PassPic1Value="";
			delete(PassPic1Value);
		}
		else if(PassPic2Value.length>0){
			PathPic2=PassPic2Value;
			BackPlayList.Image2.loadMovie(PassPic2Value);
			PassPic2Value="";
			delete(PassPic2Value);
		}
		else if(PassPlayListValue.length>0){
			if(FirstAccess=="true")FirstAccess="false";
			else {
				CurPlayList=PassPlayListValue;
				LoadCurPlayList(CurPlayList);
			}
			PassPlayListValue="";
			delete(PassPlayListValue);
		}
		//.......Default Load.......
		else if(BrowseMainPath.length>0){
			MainPathDB=BrowseMainPath;
			BackCountry.TextMainPath.text=MainPathDB;
			delete(BrowseMainPath);
		}
	}
	if(OpenFrame=="true"){
		OpenFrame="false";
		if (StringsubList.length>0){
			set_sublist(StringsubList);
			delete(StringsubList);
		}
		
		if (SearchTrackFromArtist.length>0){
			//2006-09-19
			BackRipAndPlay.ButtonSingerSong.Selected._visible=(SearchTrackFromArtist==1)
			delete(SearchTrackFromArtist);
		}
		
		if (DatabasePath.length>0) {
			if(UpdateDB._visible)UpdateDB.Text.text = DatabasePath;
			else if(BackUpDB._visible)BackUpDB.Path.text=DatabasePath;
			else if(RestoreDB._visible)RestoreDB.Path.text=DatabasePath;
			else if(CopyMusic._visible)CopyMusic.Text1.text=DatabasePath;
			delete(DatabasePath);
		}
		else if(CopyMusicDes.length>0){
			CopyMusic.Text2.text=CopyMusicDes;
			delete(CopyMusicDes);
		}
		else if(CompleteDownloadScreen.length>0){
			delete(CompleteDownloadScreen);
			AddNewScreens._visible=false;
			AddNewScreens.LoadBar._visible = false;
			ButtonHideMouse._visible=false;
			TopBar.ButtonX.onRollOver();
		}
		else if(ProUpdate.length>0){
			if(CopyMusic._visible){
				Running("CopyMusic.Progess",int(ProUpdate));
				if(int(ProUpDate)>=100){
					CopyMusic._visible=false;
					ButtonHideMouse._visible=false;
					Running("CopyMusic.Progess",0);
					CopyMusic.Progess._visible=false;
					TopBar.ButtonX.onRollOver();
				}
			}
			delete(ProUpdate);
		}
		/*else if(CompletedUpdate.length>0){
			UpdateDB.LoadBar._visible=false;
			UpdateDB.ButtonOk.enabled=true;
			UpdateDB.ButtonCancel.enabled=true;
			UpdateDB.PatientText._visible=false;
			UpdateDB._visible=false;
			TopBar.ButtonM.onRollOver();
			ButtonHideMouse._visible=false;
			delete(CompletedUpdate);
			fscommand("CompleteUpdate");
		}*/
		else if(openCover.length>0){
			TopBar.ButtonX.onRollOver();
			ButtonHideMouse._visible=false;
			delete(openCover);
		}

	}
}
//.................
function MoveLeftRight(Obj, Str, Count, Move) {
	if (Move == "Right") {
		if (Str == Obj+".MovieLeft") {
			eval(Obj+".Button0").onRollOver();
		} else if (Str == Obj+".MovieRight") {
			eval(Obj+".ButtonLeft").onRollOver();
		} else {
			var Index = GetNumber(Str)+1;
			if (Index<Count) {
				eval(Obj+".Button"+Index).onRollOver();
			} else {
				if (eval(Obj+".ButtonRight")._visible ) {
					eval(Obj+".ButtonRight").onRollOver();
				} else {
					eval(Obj+".Button"+0).onRollOver();
				}
			}
		}
	} else {
		if (Str == Obj+".MovieLeft") {
			eval(Obj+".ButtonRight").onRollOver();
		} else if (Str == Obj+".MovieRight") {
			eval(Obj+".Button"+(Count-1)).onRollOver();
		} else {
			var Index = GetNumber(Str)-1;
			if (Index>=0) {
				eval(Obj+".Button"+Index).onRollOver();
			} else {
				if (eval(Obj+".ButtonLeft")._visible ) {
					eval(Obj+".ButtonLeft").onRollOver();
				} else {
					eval(Obj+".Button"+(Count-1)).onRollOver();
				}
			}
		}
	}
}
//..........................ProFile...............

BackPlayList.ButtonAdd.onRollOver=function(){
	SelectMovieClip("BackPlayList.MovieAdd");
	LevelSelect=5;
}
BackPlayList.ButtonAdd.onRelease=function(){
	TopBar.ButtonM.onRollOver();
	fscommand("SaveUserInfo",BackPlayList.TextD.text +"~"+BackPlayList.txtName.text+"~"+BackPlayList.txtAge.text+"~"+BackPlayList.txtSex.text+"~"+BackPlayList.txtMarriage.text+"~"+BackPlayList.txtNationality.text+"~"+BackPlayList.txtWebsite1.text+"~"+BackPlayList.txtEmail.text+"~"+BackPlayList.txtArtist.text+"~"+BackPlayList.txtSong.text+"~"+BackPlayList.txtGenre.text+"~"+BackPlayList.txtColor.text+"~"+BackPlayList.txtCar.text+"~"+BackPlayList.txtPlace.text+"~"+BackPlayList.txtSport.text+"~"+BackPlayList.txtWebsite2.text+"~"+PathPic1+"~"+PathPic2);
}
BackPlayList.ButtonRemove.onRollOver=function(){
	SelectMovieClip("BackPlayList.MovieRemove");
	LevelSelect=5;
}
BackPlayList.ButtonRemove.onRelease=function(){
	TopBar.ButtonM.onRollOver();
	DisplayText("");
	fscommand("RemoveUserInfo",BackPlayList.TextD.text);
}
BackPlayList.ButtonImage1.onRollOver=function(){
	SelectMovieClip("BackPlayList.MovieImage1");
	LevelSelect=5;
}
BackPlayList.ButtonImage1.onRelease=function(){
	fscommand("Picture1");
}
BackPlayList.ButtonImage2.onRollOver=function(){
	SelectMovieClip("BackPlayList.MovieImage2");
	LevelSelect=5;
}
BackPlayList.ButtonImage2.onRelease=function(){
	fscommand("Picture2");
}


var nList=5;
var ResultD=new Array();
var LevelIndexD= 1;
var TotalLevelIndexD = 0;
var ValueDecD = 0;
var ValueInD = 0;
var NumD=0;
var IndexShowD=0;
var StoreIndexD=0;
var ResultP=new Array();
var ResultD=new Array();
var ValClickD=0;
var RecordIndexD=0;
var	RecordLevelD=0;
for(var j=0;j<nList;j++){
	eval("BackPlayList.BackListD.Button"+j).onRollOver=function(){
		SelectMovieClip("BackPlayList.BackListD.Movie"+substring(this._name,this._name.length),SelectButtonColorValue,ButtonColorValue);
		LevelSelect=5;
	}
	eval("BackPlayList.BackListD.Button"+j).onRelease=function(){
		BackPlayList.ButtonDir.onRollOver();
		IndexD = ((LevelIndexD-1) * nList) + parseInt(substring(this._name, this._name.length), 10);
		var IndexName = parseInt(substring(this._name, this._name.length), 10);
		RecordIndexD = IndexName;
		RecordLevelD = LevelIndexD;
		Release("BackPlayList.BackListD", IndexName);
		BackPlayList.BackListD._visible = false;
		ValClickD = 0;		
		BackPlayList.TextD.text = eval("BackPlayList.BackListD.Text" + IndexName).text;
		ResultP.length = 0;
		var Xml = new XML();
		Xml.load(BackPlayList.TextD.text+"\\PlayLists\\UserInfo.xml");
		//_xml.load("C:\\PerfLogs\\PlayLists\\UserInfo.xml");
		Xml.onLoad = function(){
			//fscommand("mb","Test Load Xml" + true);
			if(Xml.loaded){
				var NumP = Xml.childNodes[0].childNodes.length;
				for(var j=0; j<NumP; j++){
					ResultP[j]=Xml.childNodes[0].childNodes[j].childNodes[0].nodeValue;
				}
				DisplayText(ResultP);
			} else {
				DisplayText("");
			}
//			delete(Xml);
		}
	}
}
BackPlayList.BackListD._visible=false;
BackPlayList.ButtonDir.onRollOver=function(){
	SelectMovieClip("BackPlayList.MovieDir");
	LevelSelect=5;
}
BackPlayList.ButtonDir.onRelease=function(){
	if(ValClickD==0){
		BackPlayList.BackListD._visible=true;
		ValClickD=1
	}
	else{
		BackPlayList.BackListD._visible=false;
		ValClickD=0
	}
}
function DisplayText(Value){
	//trace(Value.length);
	if(Value.length>0){
		BackPlayList.txtName.text=Value[0];
		BackPlayList.txtAge.text=Value[1];
		BackPlayList.txtSex.text=Value[2];
		BackPlayList.txtMarriage.text=Value[3];
		BackPlayList.txtNationality.text=Value[4];
		BackPlayList.txtWebsite1.text=Value[5];
		BackPlayList.txtEmail.text=Value[6];
		BackPlayList.txtArtist.text=Value[7];
		BackPlayList.txtSong.text=Value[8];
		BackPlayList.txtGenre.text=Value[9];
		BackPlayList.txtColor.text=Value[10];
		BackPlayList.txtCar.text=Value[11];
		BackPlayList.txtPlace.text=Value[12];
		BackPlayList.txtSport.text=Value[13];
		BackPlayList.txtWebsite2.text=Value[14];
		PathPic1=Value[15];
		if(PathPic1.length>0){
			BackPlayList.Image1.loadMovie(PathPic1);
		}
		else{
			BackPlayList.Image1.unloadMovie();
		}
		PathPic2=Value[16];
		if(PathPic2.length>0){
			BackPlayList.Image2.loadMovie(PathPic2);
		}
		else{
			BackPlayList.Image2.unloadMovie();
		}
		
	}
	else{
		BackPlayList.txtName.text="";
		BackPlayList.txtAge.text="";
		BackPlayList.txtSex.text="";
		BackPlayList.txtMarriage.text="";
		BackPlayList.txtNationality.text="";
		BackPlayList.txtWebsite1.text="";
		BackPlayList.txtEmail.text="";
		BackPlayList.txtArtist.text="";
		BackPlayList.txtSong.text="";
		BackPlayList.txtGenre.text="";
		BackPlayList.txtColor.text="";
		BackPlayList.txtCar.text="";

		BackPlayList.txtPlace.text="";
		BackPlayList.txtSport.text="";
		BackPlayList.txtWebsite2.text="";
		BackPlayList.Image1.unloadMovie();
		BackPlayList.Image2.unloadMovie();
		PathPic1="";
		PathPic2="";
	}
}
function DisplayListItemD(StartIndex,n){
		if (n<=nList) {
				for (var j = 0; j<nList; j++) {
						if (j<=n-1) {
							eval("BackPlayList.BackListD.Button"+j)._visible = true;
							eval("BackPlayList.BackListD.Text"+j)._visible = true;
							eval("BackPlayList.BackListD.Text"+j).text =ResultD[StartIndex];
							StartIndex+=1;
						} 
						else {
							eval("BackPlayList.BackListD.Button"+j)._visible = false;
							eval("BackPlayList.BackListD.Text"+j)._visible = false;
						}
				}
				
		}
		else {
				
				for (var j = 0; j<nList; j++) {
						eval("BackPlayList.BackListD.Button"+j)._visible = true;
						eval("BackPlayList.BackListD.Text"+j)._visible = true;
						eval("BackPlayList.BackListD.Text"+j).text =ResultD[StartIndex];
						StartIndex+=1;
					
				} 
				
		}
}
function FirstDisplayListItemD(n) {
	NumD = n;
	IndexShowD=(LevelIndexD-1)*nList;
	if(NumD>=nList)StoreIndexD=nList;
	else StoreIndexD=NumD;
	if (NumD%nList == 0)TotalLevelIndexD = int(NumD/nList);
	else TotalLevelIndexD = int(NumD/nList)+1;
	
	if (n<=nList) {
		BackPlayList.BackListD.ButtonUp.enabled=false;
		BackPlayList.BackListD.ButtonDown.enabled=false;
		BackPlayList.BackListD.BackScrollBar.enabled=false;
		for (var j = 0; j<nList; j++) {
				if (j<=n-1) {
					eval("BackPlayList.BackListD.Button"+j)._visible = true;
					eval("BackPlayList.BackListD.Text"+j)._visible = true;
					eval("BackPlayList.BackListD.Text"+j).text =ResultD[j]
					
				}
				else {
					eval("BackPlayList.BackListD.Button"+j)._visible = false;
					eval("BackPlayList.BackListD.Text"+j)._visible = false;
					
				}
		}
	}
	else {
		BackPlayList.BackListD.ButtonUp.enabled=true;
		BackPlayList.BackListD.ButtonDown.enabled=true;
		BackPlayList.BackListD.BackScrollBar.enabled=true;
			for (var j = 0; j<nList; j++) {
				eval("BackPlayList.BackListD.Button"+j)._visible = true;
				eval("BackPlayList.BackListD.Text"+j)._visible = true;
				eval("BackPlayList.BackListD.Text"+j).text =ResultD[j];
			}
	}
	//eval("BackPlayList.BackListD.Text"+0).textColor=BlueColor;
}
BackPlayList.BackListD.ButtonUp.onRollOver = function() {
	SelectMovieClip("BackPlayList.BackListD.MovieUp",SelectButtonColorValue,ButtonColorValue);
}
BackPlayList.BackListD.ButtonDown.onRollOver = function() {
	SelectMovieClip("BackPlayList.BackListD.MovieDown",SelectButtonColorValue,ButtonColorValue);
}
BackPlayList.BackListD.ButtonUp.onRelease = function() {
	StoreIndexD=0;
	IndexShowD=0;
	LevelIndexD -= 1;
	if (LevelIndexD<=0) {
		LevelIndexD = TotalLevelIndexD;
		var VMul = LevelIndexD*nList;
		var VMode = NumD%nList;
		if (VMode == 0)ValueDecD = VMul;
		else ValueDecD = (VMul-nList)+VMode;
	}
	else {
		var VMul = LevelIndexD*nList;
		ValueDecD = VMul;
	}
	var nMode = ValueDecD%nList;
	IndexShowD = (LevelIndexD-1)*nList;
	if (nMode<>0) {
		for (var j = nMode-1; j>=0; j--) {
			ValueDecD -= 1;
			StoreIndexD += 1;
		}
	} 
	else {
		for (var j = nList-1; j>=0; j--) {
			ValueDecD -= 1;
			StoreIndexD += 1;
		}
	}
	Deselected("BackPlayList.BackListD",LevelIndexD,RecordLevelD,RecordIndexD);
	DisplayListItemD(IndexShowD,StoreIndexD);
};
BackPlayList.BackListD.ButtonDown.onRelease = function() {
	StoreIndexD=0;
	IndexShowD = 0;
	ValueInD = LevelIndexD*nList;
	LevelIndexD += 1;

	if (LevelIndexD>TotalLevelIndexD) {
		LevelIndexD= 1;

	}
	IndexShowD = (LevelIndexD-1)*nList;
	if (NumD>ValueInD) {
		for (var j = 0; j<nList; j++) {
			if (ValueInD<NumD) {
				ValueInD += 1;
				StoreIndexD += 1;
			}
		}
	} 
	else {
		ValueInD = 0;
		for (var j = 0; j<nList; j++) {
			ValueInD += 1;
			StoreIndexD += 1;
		}
	}
	Deselected("BackPlayList.BackListD",LevelIndexD,RecordLevelD,RecordIndexD);
	DisplayListItemD(IndexShowD,StoreIndexD);
};

function Deselected(FirstNode,DLevel,DRecordLevel,DRecordIndex){
	/*for(var j=0;j<nList;j++){
		if(eval(FirstNode+".Text"+j).textColor==BlueColor){
			eval(FirstNode+".Text"+j).textColor=WhiteColor;
		}
	}
	if(DLevel==DRecordLevel){
		eval(FirstNode+".Text"+DRecordIndex).textColor=BlueColor;
	}*/
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\\\
///      FUNCTION SELECT LIST ITEM                            \\\
///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\\\
function Release(FirstNode,RIndex){
	/*for(var j=0;j<nList;j++){
		if(j==RIndex){
			//trace("true");
			eval(FirstNode+".Text"+RIndex).textColor=BlueColor;
		}
		else{
			eval(FirstNode+".Text"+j).textColor=WhiteColor;
		}
	}*/
}
function SelectMovieClip(ObjName) {
	/*if (send_event("normal&&&Over||" + Replace(ObjName, "Movie", "Button") + "||6",false)){
		return;
	}*/
	switch(StoreNameSelected){
		case "BackTheme.MovieColorRating":ChangeColorAlpha("BackTheme.MovieColorRating",ColorRating,100);break;
		case "BackTheme.MovieColorBar":ChangeColorAlpha("BackTheme.MovieColorBar",ColorBar,100);break;
		case "BackTheme.MovieColor": ChangeColorAlpha("BackTheme.MovieColor",ColorValue,100);break;
		case "BackTheme.MovieFontColor": ChangeColorAlpha("BackTheme.MovieFontColor",FontColorValue,100);break;
		case "BackTheme.MovieFrame":ChangeColorAlpha("BackTheme.MovieFrame",ButtonColorValue,ButtonAlphaValue);break;
		case "BackTheme.MovieSelFrame":	ChangeColorAlpha("BackTheme.MovieSelFrame",SelectButtonColorValue,SelectButtonAlphaValue);break;
		default: ChangeColorAlpha(StoreNameSelected,ButtonColorValue,ButtonAlphaValue);
	}
	ChangeColorAlpha(ObjName,SelectButtonColorValue,SelectButtonAlphaValue);
	StoreNameSelected = ObjName;
}
function LoadCurPlayList(St){
	BackPlayList.TextD.text=St;
	ResultP.length=0;
	var Xml1=new XML();
	Xml1.load(BackPlayList.TextD.text+"\\PlayLists\\UserInfo.xml");
	Xml1.onLoad=function(){

		if(Xml1.loaded){
			var NumP=Xml1.childNodes[0].childNodes.length;
			for(var j=0;j<NumP;j++){
				ResultP[j]=Xml1.childNodes[0].childNodes[j].childNodes[0].nodeValue;
			}
			DisplayText(ResultP);
		}
		else{
			DisplayText("");
		}
//		delete(Xml1);
	}
}
//...............Function RollOver..................
Bar.ButtonAlbum.onRollOver=function(){
	SelectMovieClip("Bar.MovieAlbum",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}
Bar.ButtonCountry.onRollOver=function(){
	SelectMovieClip("Bar.MovieCountry",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}

Bar.ButtonTheme.onRollOver=function(){
	SelectMovieClip("Bar.MovieTheme",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}

Bar.ButtonRipAndPlay.onRollOver=function(){
	SelectMovieClip("Bar.MovieRipAndPlay",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}

Bar.ButtonRipAndPlay.onRollOver=function(){
	SelectMovieClip("Bar.MovieRipAndPlay",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}

Bar.ButtonSlideShow.onRollOver=function(){
	SelectMovieClip("Bar.MovieSlideShow",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
}

Bar.ButtonProFile.onRollOver=function(){
	SelectMovieClip("Bar.MovieProFile",SelectButtonColorValue,ButtonColorValue);
	LevelSelect = 2;
	
}

function SelecteListItemDown(Name, TotalIndex) {

	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index<TotalIndex-1) {
		SelectMovieClip(Str+(Index+1), SelectColorValue, SetColorValue);
	} else {
		SelectMovieClip(Str+"0", SelectColorValue, SetColorValue);
	}
}
function SelecteListItemUp(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index>0) {
		SelectMovieClip(Str+(Index-1), SelectColorValue, SetColorValue);
	} else {
		SelectMovieClip(Str+(TotalIndex-1), SelectColorValue, SetColorValue);
	}
}

function CDTypeSelect(Value){
	BackAlbum.ButtonAllCD.Selected._visible=false;
	BackAlbum.ButtonClean.Selected._visible=false;
	BackAlbum.ButtonExp.Selected._visible=false;
	switch(String(Value)){
		case "0":
			BackAlbum.ButtonAllCD.Selected._visible=true;	
			break;
		case "2":
			BackAlbum.ButtonClean.Selected._visible=true;	
			break;
		case "3":
			BackAlbum.ButtonExp.Selected._visible=true;	
			break;

		default:
			BackAlbum.ButtonAllCD.Selected._visible=true;	
			break;
	}
}
BackAlbum.ButtonAllCD.onRollOver=function(){
	SelectMovieClip("BackAlbum.MovieAllCD");
	LevelSelect = 7;
}
BackAlbum.ButtonClean.onRollOver=function(){
	SelectMovieClip("BackAlbum.MovieClean");
	LevelSelect = 7;
}
BackAlbum.ButtonExp.onRollOver=function(){
	SelectMovieClip("BackAlbum.MovieExp");
	LevelSelect = 7;
}

BackAlbum.ButtonAllCD.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	CDType=0;
	CDTypeSelect(CDType);
	fscommand("DefineCDType",CDType);
}
BackAlbum.ButtonClean.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	CDType=2;
	CDTypeSelect(CDType);
	fscommand("DefineCDType",CDType);
}
BackAlbum.ButtonExp.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	CDType=3;
	CDTypeSelect(CDType);
	fscommand("DefineCDType",CDType);
}

function ChangeColorText(FontColor){
	BackAlbum.TextAlbumNum.textColor=FontColor;
	BackTheme.TextPos.textColor=FontColor;
	BackTheme.TextPos1.textColor=FontColor; 
	BackTheme.TextAlphaValue.textColor=FontColor;
    BackTheme.TextSelAlphaValue.textColor=FontColor;
	BackAlbum.TextBrowse.textColor=FontColor;
	BackTheme.TextEngFont.textColor=FontColor;
	BackTheme.TextUniFont.textColor=FontColor;
	BackAlbum.TextFavAlbum.textColor=FontColor;
	BackTheme.TextMonitor.textColor=FontColor;

	BackSlideShow.txtImage.textColor=FontColor;
	BackSlideShow.txtTime.textColor=FontColor;
	BackSlideShow.txtDelay.textColor=FontColor;
	BackSlideShow.txtImageSize.textColor=FontColor;

//	BackPlayList.TextD.textColor=FontColor;
	BackPlayList.TextAdd.textColor=FontColor; 
	BackPlayList.TextRemove.textColor=FontColor;
	/*BackPlayList.txtName.textColor=FontColor;
	BackPlayList.txtSex.textColor=FontColor;
	BackPlayList.txtAge.textColor=FontColor;
	BackPlayList.txtMarriage.textColor=FontColor;
	BackPlayList.txtNationality.textColor=FontColor;
	BackPlayList.txtWebsite1.textColor=FontColor;
	BackPlayList.txtEmail.textColor=FontColor;
	BackPlayList.txtArtist.textColor=FontColor;
	BackPlayList.txtSong.textColor=FontColor;
	BackPlayList.txtGenre.textColor=FontColor;
	BackPlayList.txtColor.textColor=FontColor;
	BackPlayList.txtCar.textColor=FontColor;
	BackPlayList.txtPlace.textColor=FontColor;
	BackPlayList.txtSport.textColor=FontColor;
	BackPlayList.txtWebsite2.textColor=FontColor;*/

}

///--------------------------
/// onRollOut
///--------------------------
TopBar.ButtonM.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonB.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonS.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonP.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonC.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonL.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonO.onRollOut = function(){
	HideTooltip("txtTooltip");
}
TopBar.ButtonX.onRollOut = function(){
	HideTooltip("txtTooltip");
}
function center(obj1,obj2){
	var objx = eval(obj1)._x;
	var objy = eval(obj1)._y;
	
	eval(obj2)._x = objx - eval(obj2).textHeight/2
	eval(obj2)._y = objx - eval(obj2).textWidth/2
}

//===============================
// BackRipAndPlay
function VisiblePlaywith(Name){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
		if (Name=="ButtonWmp"){
			BackRipAndPlay.ButtonWmp.Selected._visible=true;
		 	BackRipAndPlay.ButtonShowtime.Selected._visible=false;
			BackRipAndPlay.ButtonWinamp.Selected._visible=false;
			BackRipAndPlay.ButtonPowerDVD.Selected._visible=false;
			hide_show_monitor_checkbox(true);
			fscommand("playMusicWith", WindowMedia );
		}
	    	else if(Name=="ButtonWinamp"){
			BackRipAndPlay.ButtonWmp.Selected._visible=false;
		 	BackRipAndPlay.ButtonShowtime.Selected._visible=false;
			BackRipAndPlay.ButtonWinamp.Selected._visible=true;
			BackRipAndPlay.ButtonPowerDVD.Selected._visible=false;
			hide_show_monitor_checkbox(true);
			fscommand("playMusicWith", MediaPlayer );
		}	
	    	else if(Name=="ButtonPowerDVD"){
			BackRipAndPlay.ButtonWmp.Selected._visible=false;
		 	BackRipAndPlay.ButtonShowtime.Selected._visible=false;
			BackRipAndPlay.ButtonWinamp.Selected._visible=false;
			BackRipAndPlay.ButtonPowerDVD.Selected._visible=true;
			hide_show_monitor_checkbox(true);
			fscommand("playMusicWith", PowerDVD );
		}	
		else{
			 BackRipAndPlay.ButtonWmp.Selected._visible=false;
			BackRipAndPlay.ButtonShowtime.Selected._visible=true;
			BackRipAndPlay.ButtonWinamp.Selected._visible=false;
			BackRipAndPlay.ButtonPowerDVD.Selected._visible=false;
			hide_show_monitor_checkbox(true);
			fscommand("playMusicWith", Nero );		
		}
	}
	
BackRipAndPlay.ButtonWmp.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieWmp",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonWmp.onRelease=function(){
	//VisiblePlaywith(ButtonWmp);
	
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if (BackRipAndPlay.ButtonWmp.enabled == true){
		BackRipAndPlay.ButtonWinamp.Selected._visible = false;
		//BackRipAndPlay.ButtonWinamp.enabled = false;
		
		BackRipAndPlay.ButtonWmp.Selected._visible = true;
		BackRipAndPlay.ButtonShowtime.Selected._visible = false;
		BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
		hide_show_monitor_checkbox(true);
		fscommand("playMusicWith", WindowMedia );
	}
	
}

//------
BackRipAndPlay.ButtonShowtime.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieShowtime",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
	}
BackRipAndPlay.ButtonShowtime.onRelease=function(){
	//VisiblePlaywith(ButtonShowtime);
	
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if (BackRipAndPlay.ButtonShowtime.enabled == true){
		BackRipAndPlay.ButtonWinamp.Selected._visible = false;
		BackRipAndPlay.ButtonWinamp.enabled = true;
			
		BackRipAndPlay.ButtonWmp.Selected._visible = false;
		BackRipAndPlay.ButtonWmp.enabled = true;
			
		BackRipAndPlay.ButtonShowtime.Selected._visible = true;
		BackRipAndPlay.ButtonShowtime.enabled = false;
		BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
		hide_show_monitor_checkbox(false);2
		fscommand("playMusicWith", Nero);
	}

}	
	
BackRipAndPlay.ButtonWinamp.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieWinamp",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonWinamp.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if (BackRipAndPlay.ButtonWinamp.enabled == true){
		BackRipAndPlay.ButtonWinamp.Selected._visible = true;
		BackRipAndPlay.ButtonWmp.Selected._visible = false;
		BackRipAndPlay.ButtonShowtime.Selected._visible = false;
		BackRipAndPlay.ButtonPowerDVD.Selected._visible = false;
		fscommand("playMusicWith", MediaPlayer);
	}

}
BackRipAndPlay.ButtonPowerDVD.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MoviePowerDVD",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonExternalPowerDVD.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieExternalPowerDVD",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}

BackRipAndPlay.ButtonBrowseFolder.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieBrowseFolder",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonExternalPowerDVD.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonExternalPowerDVD.Selected._visible = !(BackRipAndPlay.ButtonExternalPowerDVD.Selected._visible);

	if (BackRipAndPlay.ButtonExternalPowerDVD.Selected._visible){
		fscommand("setExternalPowerDVD", "true");
	}else{
		fscommand("setExternalPowerDVD", "false");
	}

}

BackRipAndPlay.ButtonBrowseFolder.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	BackRipAndPlay.ButtonBrowseFolder.Selected._visible = !(BackRipAndPlay.ButtonBrowseFolder.Selected._visible);

	if (BackRipAndPlay.ButtonBrowseFolder.Selected._visible){
		fscommand("setBrowseByFolder", "true");
	}else{
		fscommand("setBrowseByFolder", "false");
	}

}
BackRipAndPlay.ButtonPowerDVD.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if (BackRipAndPlay.ButtonPowerDVD.enabled == true){
		BackRipAndPlay.ButtonPowerDVD.Selected._visible = true;
		BackRipAndPlay.ButtonWinamp.Selected._visible = false;
		BackRipAndPlay.ButtonWmp.Selected._visible = false;
		BackRipAndPlay.ButtonShowtime.Selected._visible = false;
		fscommand("playMusicWith", PowerDVD);
	}

}

//------
BackRipAndPlay.ButtonOffset.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieOffset",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonOffset.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
	BackRipAndPlay.ButtonOffset.Selected._visible=!(BackRipAndPlay.ButtonOffset.Selected._visible);
	fscommand("offsetEnabled",BackRipAndPlay.ButtonOffset.Selected._visible); //changed
}
//-----------------------
BackRipAndPlay.ButtonAutoPlayMPC.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieAutoPlayMPC",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonAutoPlayMPC.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
	BackRipAndPlay.ButtonAutoPlayMPC.Selected._visible=!(BackRipAndPlay.ButtonAutoPlayMPC.Selected._visible);
	fscommand("AutoPlayMPC",BackRipAndPlay.ButtonAutoPlayMPC.Selected._visible); //changed
}
//------
BackRipAndPlay.ButtonAutoPlay.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieAutoPlay",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonAutoPlay.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
	BackRipAndPlay.ButtonAutoPlay.Selected._visible=!(BackRipAndPlay.ButtonAutoPlay.Selected._visible);
	fscommand("AutoPlayEnabled",BackRipAndPlay.ButtonAutoPlay.Selected._visible); //changed
}
//------

BackRipAndPlay.ButtonAutoPlayPowerDVD.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieAutoPlayPowerDVD",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonAutoPlayPowerDVD.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
	BackRipAndPlay.ButtonAutoPlayPowerDVD.Selected._visible=!(BackRipAndPlay.ButtonAutoPlayPowerDVD.Selected._visible);
	fscommand("AutoPlayPowerDVD",BackRipAndPlay.ButtonAutoPlayPowerDVD.Selected._visible); //changed
}

//------
BackRipAndPlay.ButtonSingerSong.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieSingerSong",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonSingerSong.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||6",true)){
		return;
	}
	BackRipAndPlay.ButtonSingerSong.Selected._visible=!(BackRipAndPlay.ButtonSingerSong.Selected._visible);
	fscommand("SingerSong",BackRipAndPlay.ButtonSingerSong.Selected._visible); //changed
}
//------
BackRipAndPlay.ButtonRipWmp.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieRipWmp",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonRipWmp.onRelease=function(){
	if (BackRipAndPlay.ButtonRipWmp.enabled == true){
		BackRipAndPlay.ButtonRipWmp.Selected._visible = true;
		BackRipAndPlay.ButtonRipiTunes.Selected._visible = false;
		BackRipAndPlay.ButtonRipWmp.enabled = false;
		BackRipAndPlay.ButtonRipiTunes.enabled = true;
		fscommand("ripMusicWith","ripWithWindowMedia");
	}
}

//------
BackRipAndPlay.ButtonRipiTunes.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieRipiTunes",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonRipiTunes.onRelease=function(){
	if (BackRipAndPlay.ButtonRipiTunes.enabled == true){
		BackRipAndPlay.ButtonRipWmp.Selected._visible = false;
		BackRipAndPlay.ButtonRipiTunes.Selected._visible = true;
		BackRipAndPlay.ButtonRipWmp.enabled = true;
		BackRipAndPlay.ButtonRipiTunes.enabled = false;
		fscommand("ripMusicWith","ripWithiTunes");
	}
}
//---------------------------------------New option--------
BackRipAndPlay.ButtonTrackTitleStyle.onRelease=function(){
	var iStyle=0;
	if (send_event("normal&&&Click||" + this + "||6",false)){
		return;
	}
	if(BackRipAndPlay.ButtonLarge.Selected._visible){
	switch(BackRipAndPlay.TextTrackTitleStyle.text){		
		case "Production":
			BackRipAndPlay.TextTrackTitleStyle.text="Artist";
			iStyle=0;
			break;			
		case "Artist":
			BackRipAndPlay.TextTrackTitleStyle.text="Production";
			iStyle=1;
			break;
		default:
			BackRipAndPlay.TextTrackTitleStyle.text="Production";
			iStyle=1;
			break;
	}
	fscommand("ChangeTrackTitleStyle",iStyle);
}
}
BackRipAndPlay.ButtonTrackTitleStyle.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieTrackTitleStyle");
	LevelSelect = 9;
	
}
BackRipAndPlay.ButtonScanAlbum.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieScanAlbum");
	LevelSelect = 9;	
}
BackRipAndPlay.ButtonScanAlbum.onRelease = function(){
	fscommand("ShowScan",true);

}
BackRipAndPlay.ButtonBrowseAdv.onRollOver=function(){
	SelectMovieClip("BackRipAndPlay.MovieBrowseAdv",SelectButtonColorValue,ButtonColorValue);
	LevelSelect=9;
}
BackRipAndPlay.ButtonBrowseAdv.onRelease=function(){
	fscommand("BrowseMainPath","AdvPath|||" + BackRipAndPlay.TextMainPath.text);
}
