////..............................................COLOR SETTING.....................................
//var UniArtist=UniMood=UniGenre=UniNormal=UniAdvance=UniRating=UniDance=UniTrack=UniNonSelected=UniTrackNotAva=UniTrackAva="";

var UniAlbumTitle = "";
var UniPro="";
var UniPreTrack, UniNextTrack = "";
var BgColorValue,ChangeLang, EngFont, UniFont, EngSize, UniSize, TrackPosUni, TrackPosEng,Adv,Auto;
var SelectColorValue,SetColorValue, ButtonAlpha, ButtonSelAlpha, FontColor;
var PlayMode="One";
function LoadXmlLanguage(St) {
	LoadSetting(St);
	var SettingXml = new XML();
	TopBar.Flag.loadMovie(MainPathImage+"\\Folder.jpg");
	SettingXml.load(GetPath+"\\Language.xml");
	SettingXml.onLoad = function() {
		EngFont = SettingXml.childNodes[0].childNodes[0].attributes.FontEng;
		UniFont = SettingXml.childNodes[0].childNodes[0].attributes.FontUni;
		if(WideScreen!="Normal" && WideScreen!="smallWideScreen" && WideScreen!="largeWideScreen"){
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSizeWide, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSizeWide,10);
		}
		else{
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSize, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSize,10);
		}
		if(iKhmer=="1"){
			FontKhmer=UniFont;
			UniFont=EngFont;
			UniSize=EngSize;
		}
		delete(WideScreen);
		TrackPosEng = SettingXml.childNodes[0].childNodes[0].attributes.TrackPos;
		TrackPosUni = SettingXml.childNodes[0].childNodes[0].attributes.TrackPosUni;
		
		UniPro = SettingXml.childNodes[0].childNodes[1].attributes.UniPro;
		UniAlbumTitle = SettingXml.childNodes[0].childNodes[1].attributes.UniAlbumTitle;
		UniPreTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniPreTrack;
		UniNextTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniNextTrack;
		UniTrackTitle=SettingXml.childNodes[0].childNodes[1].attributes.UniTrackTitle;
		SetFontColor(FontColor);
		FirstDisplayTrack(parseInt(PassTrackInfoLen,10));
		//DeselectedItem (TrackName,eval("IndexShow"+TrackObj),ChangeCurIndexTrack);
	};
}
///............................setting................
Bg._visible=false;
var HideMouse="false";
var ColorRating;
var AlbumCover ;
function LoadSetting(St) {
	var SplitSt=St.split("~");
	BgColorValue = SplitSt[0];
	
	NumMovie=SplitSt[1];
	AlbumCover = SplitSt[2];
	ChangeColorNoAlpha("Bg", BgColorValue);
	Bg._visible=true;
	SetColorValue = SplitSt[6];
	ButtonAlpha = SplitSt[7];
	SelectColorValue = SplitSt[8];
	ButtonSelAlpha =SplitSt[9];
	FontColor = SplitSt[10];
	ChangeLan = SplitSt[13];
	PlayAll.Text.text=SplitSt[16];
	if(PlayAll.Text.text=="One")PlayAll.Icon2._visible=false;
	ChangeColorBar(SplitSt[23]);
	ColorRating=SplitSt[26];
	
	HideMouse=SplitSt[27];
	
	if(HideMouse=="true"){
		Mouse.hide();
//		ButtonHideMouse._visible=true;
	}
	
	//Adv=SplitSt[12];
	//Auto=SplitSt[11];
	//eval(TrackName).TextPlay.text=PlayMode;
	ChangeColorAndAlpha(SetColorValue, ButtonAlpha);
	//SetFontColor(FontColor);
	
	TopBar.ButtonM.onRollOver();
	TopBar._visible=true;
	
	changeColorButton();	// change colo mini player
	
}
function ChangeColorBar(Value){
	TrackShow.setTrackDisplayTheme(FontColor,Value);
	ChangeColor("TopBar.Bar", Value, 100);
	ChangeColor("Menu.Bar", Value, 100);
	ChangeColor("MenuMISC.Bar", Value, 100);
	ChangeColor("ButtonTip", Value, 100);
	ChangeColor("AlbumBar.Bar", Value, 100);
}
function SetFontColor(FontColor1) {
	Menu.AboutSly.Text.textColor=FontColor1;
	Menu.MISC.Text.textColor=FontColor1;
	Menu.MISC.Arrow.textColor=FontColor1;
	Menu.MISC.Arrow._visible=true;
	MenuMISC.UpDateDB.Text.textColor=FontColor1;
	MenuMISC.RestoreDB.Text.textColor=FontColor1;
	MenuMISC.InputBox.Text.textColor=FontColor1;
	MenuMISC.BackUpDB.Text.textColor=FontColor1;
	MenuMISC.CopyFolder.Text.textColor=FontColor1;
	MenuMISC.AddNewScreen.Text.textColor=FontColor1;
	Save.txtTitle.textColor=FontColor1;
	Save.txtDes.textColor=FontColor1;
	Save.txtPath.textColor=FontColor1;
	Save.txtApp.textColor=FontColor1;
	Save.txtOver.textColor=FontColor1;
	Save.txtSaver.textColor=FontColor1;
	Save.txtKey.textColor=FontColor1;
	Save.txtOk.textColor=FontColor1;
	Save.txtCancel.textColor=FontColor1;
	
	DelAll.txtTitle.textColor=FontColor1;
	DelAll.txtDes.textColor=FontColor1;
	DelAll.Text.textColor=FontColor1;
	DelAll.txtOk.textColor=FontColor1;
	DelAll.txtCancel.textColor=FontColor1;

	AlbumInfo.Text.textColor=FontColor1;
	var FormatFont1 = new TextFormat();
	FormatFont1.font = EngFont;
	FormatFont1.size = EngSize;
	FormatFont1.bold = true;
	eval(TrackName).TextLeft.textColor = FontColor1;
	eval(TrackName).TextRight.textColor = FontColor1;
	eval(TrackName).TrackLen.textColor = FontColor1;
	eval(TrackName).TrackNo.textColor = FontColor1;
	eval(TrackName).Mood.textColor = FontColor1;
	eval(TrackName).Dance.textColor = FontColor1;
	eval(TrackName).Artist.textColor = FontColor1;
	eval(TrackName).Album.textColor = FontColor1;
	eval(TrackName).TextToolTip.textColor = FontColor1;
	for (var j = 0; j<4; j++) {
		eval("PurchaseCDMode.Text"+j).textColor = FontColor1;
		eval("PurchaseCDMode.TextCart"+j).textColor = FontColor1;
	}
	TopBar.TextProTitle.textColor = FontColor1;
	
	Menu.Exit.Text.textColor=FontColor1;
	Menu.Min.Text.textColor=FontColor1;
	Menu.AddTrack.Text.textColor=FontColor1;
	
	Menu.RipCD.Text.textColor=FontColor1;
	Menu.Scan.Text.textColor=FontColor1;
	TextTip.textColor=SelectColorValue;
}
function ChangeColor(Obj, ColorValue1, Alpha1) {
	myColor = new Color(Obj);
	myColor.setRGB(ColorValue1);
	eval(Obj)._alpha = Alpha1;
}
function ChangeColorNoAlpha(Obj, ColorValue1) {
	myColor = new Color(Obj);
	myColor.setRGB(ColorValue1);
}
var StoreNameSelected = "";
function SelectButton(Obj) {
	/*if (send_event("normal&&&Over||" + Replace(Obj, "Movie", "Button") + "||4",false)){
		return;
	}*/
	ChangeColor(StoreNameSelected, SetColorValue, ButtonAlpha);
	ChangeColor(Obj, SelectColorValue, ButtonSelAlpha);
	ObjectName = Replace(Obj,"Movie","Button");
	StoreNameSelected = Obj;
	fscommand("onFocus",true);
}
function ChangeColorAndAlpha(ColorValue1, Alpha1) {
	ChangeColor("DelAll.Bar", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieM", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieB", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieS", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieP", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieC", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieL", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieO", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieX", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".MovieRight", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".MovieLeft", ColorValue1, Alpha1);
	ChangeColor("BackAlbumPic.Movie", ColorValue1, Alpha1);
	for (var j = 0; j<nTrack; j++) {
		ChangeColor(TrackName + ".Movie"+j, ColorValue1, Alpha1);
	}
	for (var j = 0; j<nAlbum; j++) {
		ChangeColor("AlbumBar.Movie"+j, ColorValue1, Alpha1);
		eval("AlbumBar.Text"+j).textColor=FontColor;
	}
	for (var j = 0; j<4; j++) {
		ChangeColor("PurchaseCDMode.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("PurchaseCDMode.MovieCart"+j, ColorValue1, Alpha1);
	}
	ChangeColor("PurchaseCDMode.MovieClose", ColorValue1, Alpha1);
	
	ChangeColor("AlbumBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("AlbumBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("PlayAll.Movie", ColorValue1, Alpha1);
	ChangeColor("ButtonPre.Movie", ColorValue1, Alpha1);
	ChangeColor("ButtonNext.Movie", ColorValue1, Alpha1);
	ChangeColor("ButtonBurch.Movie", ColorValue1, Alpha1);
	ChangeColor("ButtonCD.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Min.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.AddTrack.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Exit.Movie", ColorValue1, Alpha1);

	ChangeColor("Menu.RipCD.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Scan.Movie", ColorValue1, Alpha1);
	ChangeColor("Save.Bar", ColorValue1, Alpha1);
	ChangeColor("Save.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("Save.MovieOk", ColorValue1, Alpha1);
	ChangeColor("Save.Moviekey", ColorValue1, Alpha1);
	ChangeColor("Save.MovieAppand", ColorValue1, Alpha1);
	ChangeColor("Save.MovieOverwrite", ColorValue1, Alpha1);
	ChangeColor("Save.MovieSlide", ColorValue1, Alpha1);
	ChangeColor("Save.MovieMode", ColorValue1, Alpha1);
	ChangeColor("Save.MoviePath", ColorValue1, Alpha1);
	ChangeColor("Save.MenuMode.MovieTrack", ColorValue1, Alpha1);
	ChangeColor("Save.MenuMode.MovieAlbum", ColorValue1, Alpha1);
	ChangeColor("Save.MenuMode.MovieArtist", ColorValue1, Alpha1);
	
	ChangeColor("Save.MenuPath.Movie0", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.Movie1", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.Movie2", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.Movie3", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.Movie4", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("Save.MenuPath.MovieRight", ColorValue1, Alpha1);
	
	
	ChangeColor("DelAll.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("DelAll.MovieOk", ColorValue1, Alpha1);
	
	ChangeColor("BackPlay.MovieDelOne", ColorValue1, Alpha1);
	ChangeColor("BackPlay.MovieDelAll", ColorValue1, Alpha1);
	ChangeColor("BackPlay.MovieMoveUp", ColorValue1, Alpha1);
	ChangeColor("BackPlay.MovieMoveDown", ColorValue1, Alpha1);
	ChangeColor("BackPlay.MovieSave", ColorValue1, Alpha1);
	ChangeColor("BackPlay.MovieAlbum", ColorValue1, Alpha1);
	
	ChangeColor("BackPlay.SelectDelOne", SelectColorValue, Alpha1);
	ChangeColor("BackPlay.SelectDelAll", SelectColorValue, Alpha1);
	ChangeColor("BackPlay.SelectMoveUp", SelectColorValue, Alpha1);
	ChangeColor("BackPlay.SelectMoveDown", SelectColorValue, Alpha1);
	ChangeColor("BackPlay.SelectAlbum", SelectColorValue, Alpha1);
	
	ChangeColor("BackPlay.Icon0", FontColor, 80);
	ChangeColor("BackPlay.Icon1", FontColor, 80);
	ChangeColor("BackPlay.Icon2", FontColor, 80);
	ChangeColor("BackPlay.Icon3", FontColor, 80);
	ChangeColor("BackPlay.Icon4", FontColor, 80);
	ChangeColor("TopBar.Letter.Movie", SelectColorValue, Alpha1);
	
	ChangeColor(TrackName + ".RefreshCoverArt.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".DefaultVLC.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".PathSlideshow.Movie", ColorValue1, Alpha1);
	changeColor(TrackName + ".SearchPlayerPage.Movie", Colorvalue1, Alpha1);
	changeColor(TrackName + ".SearchPlayerPage.MovieSel", SelectColorValue, Alpha1);
	changeColor(TrackName + ".download_song.Movie", Colorvalue1, Alpha1);
	changeColor(TrackName + ".download_song.MovieSel", SelectColorValue, Alpha1);
	ChangeColor(TrackName + ".BackStars.Movie1", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".BackStars.Movie2", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".BackStars.Movie3", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".BackStars.Movie4", ColorValue1, Alpha1);
	ChangeColor(TrackName + ".BackStars.Movie5", ColorValue1, Alpha1);
	
	ChangeColor("BackAlbumInfo.BackStars.Movie1", ColorValue1, Alpha1);
	ChangeColor("BackAlbumInfo.BackStars.Movie2", ColorValue1, Alpha1);
	ChangeColor("BackAlbumInfo.BackStars.Movie3", ColorValue1, Alpha1);
	ChangeColor("BackAlbumInfo.BackStars.Movie4", ColorValue1, Alpha1);
	ChangeColor("BackAlbumInfo.BackStars.Movie5", ColorValue1, Alpha1);
	SetColorMisc(ColorValue1, Alpha1);
}



	
function SetColorMisc(Value,Alpha){
	ChangeColor("Menu.AboutSly.Movie", Value, Alpha);
	ChangeColor("Menu.MISC.Movie", Value, Alpha);
	
	ChangeColor("MenuMISC.UpDateDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.RestoreDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.InputBox.Movie",Value,Alpha);
	ChangeColor("MenuMISC.BackUpDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.CopyFolder.Movie", Value, Alpha);
	ChangeColor("MenuMISC.AddNewScreen.Movie", Value, Alpha);
	//............
	ChangeColor("UpDateDB.Bar", Value, Alpha);
	ChangeColor("BackUpDB.Bar", Value, Alpha);
	ChangeColor("RestoreDB.Bar", Value, Alpha);
	ChangeColor("InputBox.Bar",Value,Alpha);
	ChangeColor("CopyMusic.Bar", Value, Alpha);
	//..............
	ChangeColor("WarningUpdate.Bar", Value, Alpha);
	ChangeColor("WarningUpdate.MovieOk", Value, Alpha);
	ChangeColor("WarningUpdate.MovieCancel", Value, Alpha);
	//..............
	ChangeColor("UpdateDB.MovieOk", Value, Alpha);
	ChangeColor("UpdateDB.MovieCancel", Value, Alpha);
	ChangeColor("UpdateDB.MovieBrowseDB", Value, Alpha);
	ChangeColor("UpdateDB.MovieDownLoad", Value, Alpha);
	//..................
	ChangeColor("BackUpDB.MovieOk", Value, Alpha);
	ChangeColor("BackUpDB.MovieCancel", Value, Alpha);
	ChangeColor("BackUpDB.MovieBrowseDB", Value, Alpha);
	//...................
	ChangeColor("RestoreDB.MovieOk", Value, Alpha);
	ChangeColor("RestoreDB.MovieCancel",Value, Alpha);
	ChangeColor("RestoreDB.MovieBrowseDB", Value, Alpha);
	ChangeColor("InputBox.MovieOk", Value, Alpha);
	ChangeColor("InputBox.MovieCancel",Value, Alpha);
	//.................
	ChangeColor("CopyMusic.MovieOk", Value, Alpha);
	ChangeColor("CopyMusic.MovieCancel", Value, Alpha);
	ChangeColor("CopyMusic.MovieBrowse1", Value, Alpha);
	ChangeColor("CopyMusic.MovieBrowse2", Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck1",Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck2", Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck3", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck3.chk", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck2.chk", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck1.chk", Value, Alpha);

	//................
	ChangeColor("AddNewScreens.Bar", Value, Alpha);
	for(var j=0;j<nScreen;j++){
		ChangeColor("AddNewScreens.Button"+j+".chk",Value, Alpha);
		ChangeColor("AddNewScreens.Movie"+j, Value, Alpha);
	}
	ChangeColor("AddNewScreens.MovieLeft",Value, Alpha);
	ChangeColor("AddNewScreens.MovieRight",Value, Alpha);
	ChangeColor("AddNewScreens.MovieOk",Value, Alpha);
	ChangeColor("AddNewScreens.MovieCancel",Value, Alpha);
	//.................Searchbox...
	//................
	ChangeColor("SearchBox.Bar", Value, Alpha);
	for(var j=0;j<nListSearch;j++){
		ChangeColor("SearchBox.ListResult.Movie"+j, Value, Alpha);
	}
	ChangeColor("SearchBox.ListResult.MovieLeft",Value, Alpha);
	ChangeColor("SearchBox.ListResult.MovieRight",Value, Alpha);
	ChangeColor("SearchBox.MovieOk",Value, Alpha);
	ChangeColor("SearchBox.MovieCancel",Value, Alpha);
	ChangeColor("SearchBox.MovieL",Value, Alpha);
	ChangeColor("SearchBox.MovieK",Value, Alpha);
	ChangeColor("AddTrackBox.MovieOk",Value, Alpha);
	ChangeColor("AddTrackBox.MovieK",Value, Alpha);
	ChangeColor("AddTrackBox.MovieCancel",Value, Alpha);
}