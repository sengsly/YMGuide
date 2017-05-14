// DisplayTooltip(this._xmouse,this._ymouse,30,20,"txtTooltip","Menu",SHTT,0,35);
// HideTooltip("txtTooltip");
var MainLevel = 1;
selection.setFocus(TopBar.MovieM);
TopBar.ButtonB.onRollOver = function() {
	if (Menu._visible) {
		HideMenu();
	}
	DisplayTooltip(this, "txtTooltip", "Back (backspace)", SHTT, 0, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieB");
	ButtonTip._visible = false;
	TextTip._visible = false;
};
TopBar.ButtonB.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	if (SelectMode0 == "Artist") {
		
		if (StoreIndexArrow1 ==0 && StoreCountArrow1 ==0 && resultSearchArtistName.length==0)
		{
			fscommand("GoBack");		
			return 0;
			//sith 21/10/06 do not display blank arrow screen
		}
		if (MainLevel == 4) {
			if(DisplayArtistMode==0){
				eval(TrackName)._visible = false;
				BackAlbumPic._visible = false;
				VisiblePlay(false);
				eval(NameAlbum)._visible = true;
				VolBar._visible = true;
				MainLevel = 3;
			}else if (DisplayArtistMode==1){
				MainLevel = 2;
				eval(TrackName)._visible = false;
				BackAlbumPic._visible = false;
				eval(NameAlbum)._visible = true;
				VolBar._visible = false;
				VisiblePlay(false);
				ShowMovieArtist(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
				ArrowBar._visible = true;
			}
		} else if (MainLevel == 3) {
			MainLevel = 2;
			VolBar._visible = false;
			ShowMovieArtist(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
			ArrowBar._visible = true;
		} else {
			fscommand("GoBack");
			if (RefreshMyFavAlbum == "true") {
				fscommand("RefreshMyFavAlbum");
			}
		}
	} else if(SelectMode0=="Song"){
		fscommand("GoBack");
		if (RefreshMyFavAlbum == "true") {
			fscommand("RefreshMyFavAlbum");
		}
	} else if (SelectMode0 == "Album") {
		if (MainLevel == 4) {
			eval(TrackName)._visible = false;
			BackAlbumPic._visible = false;
			VisiblePlay(false);
			eval(NameAlbum)._visible = true;
			VolBar._visible = true;
			MainLevel = 3;
		} else {
			fscommand("GoBack");
			if (RefreshMyFavAlbum == "true") {
				fscommand("RefreshMyFavAlbum");
			}
		}
	} else {
		fscommand("GoBack");
		if (RefreshMyFavAlbum == "true") {
			fscommand("RefreshMyFavAlbum");
		}
	}
};
TopBar.ButtonM.onRollOver = function() {
	if (Menu._visible) {
		HideMenu();
	}
	DisplayTooltip(this, "txtTooltip", "Menu (Ctrl+M)", SHTT, -(96.2/2)+5, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieM");
	ButtonTip._visible = false;
	TextTip._visible = false;
};
TopBar.ButtonM.onRelease = function() {
	showHideSearch((BackAdvance._visible ),(BackNormal._visible));
};
function showHideSearch(advVisible, normalVisible) {// 170205
	if (send_event("normal&&&function||showHideSearch|~|"+advVisible+"|~|"+ normalVisible+"||2", false)) {
		return;
	}
	if (Adv == "Yes") {
		if (String(advVisible)=="true") {
			BackAdvance._visible = false;
			fscommand("ShowTextSearch", "no");
//			InputText._visible = false;
		} else {
			BackAdvance._visible = true;
//			if (ChangeLan == "Uni") {
				fscommand("ShowTextSearch", "yes");
//			} else {
//				InputText._visible = true;
//			}
		}
	} else {
		if (String(normalVisible)=="true") {
			BackNormal._visible = false;
			fscommand("ShowTextSearch", "no");
//			InputText._visible = false;
		} else {
			if(SelectMode0=="Song"){
				ClickOptNormal("BackNormal.ButtonSong");
				SelectMode="Song";
			}
			else if(SelectMode0=="Album"){
				ClickOptNormal("BackNormal.ButtonAlbum");
				SelectMode="Album";
			}
			else if(SelectMode0=="Artist"){
				ClickOptNormal("BackNormal.ButtonArtist");
				SelectMode="Artist";			//tell that it is in album page
			}
			BackNormal._visible = true;
			fscommand("ShowTextSearch", "yes");
		}
	}
//	if(InputText._visible){
//		Selection.setFocus(InputText)
//	}
}
////
TopBar.ButtonS.onRollOver = function() {
	if (Menu._visible) {
		HideMenu();
	}
	DisplayTooltip(this, "txtTooltip", "Search (Ctrl+S)", SHTT, -(105.55/2)+5, 20);
	ButtonTip._visible = false;
	TextTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieS");
};
TopBar.ButtonS.onRelease = function() {
	TopBar.ButtonM.onRelease();
};
TopBar.ButtonP.onRollOver = function() {
	if (Menu._visible) {
		HideMenu();
	}
	DisplayTooltip(this, "txtTooltip", "Playlist (Ctrl+P)", SHTT, -(104.8/2)+5, 20);
	ButtonTip._visible = false;
	TextTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieP");
};
TopBar.ButtonP.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	fscommand("ShowPlayList");
};
TopBar.ButtonC.onRollOver = function() {
	if (Menu._visible) {
		HideMenu();
	}
	DisplayTooltip(this, "txtTooltip", "Language (Ctrl+"+chr(KeyLanguage)+")", SHTT, -(123.55/2)+5, 20);
	ButtonTip._visible = false;
	TextTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieC");
};
TopBar.ButtonC.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	fscommand("ShowCountry");
};
TopBar.ButtonL.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Unicode/English (Ctrl+E)", SHTT, -(165.75/2)+5, 20);
	ButtonTip._visible = false;
	TextTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieL");
};
TopBar.ButtonL.onRelease = function() {
	ChangeLan = (ChangeLan == "Uni" ) ? "Eng"  : "Uni" ;
	fscommand("ChangeLanguage", ChangeLan);
};
////
function Language_Click(val){// 170205
	if (LanName.indexOf("English")<0) {
		InputText.text = "";
		if (BackNormal._visible || BackAdvance._visible) {
			fscommand("ShowTextSearch", "yes");
		}
		if (MainLevel == 3 || MainLevel == 4) {
			DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
		} else if (MainLevel == 2) {
			// DisplayMovieArtistItem(NameAlbum, IndexShowArrow, CountArrow, resultSearchArtistName);
			DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
		}
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
		ChangeTextButton(EngFont, UniFont, EngSize, UniSize, ChangeLan);
		ChangeInputText(EngFont, UniFont, EngSize, UniSize, ChangeLan);
		DisplayItem("BackAdvance.BackListArtist", IndexShowArtist, CountArtist, nList, ResultArtist, "Artist");
		DisplayItem("BackAdvance.BackListMood", IndexShowMood, CountMood, nList, ResultMood, "Mood");
		DisplayItem("BackAdvance.BackListGenre", IndexShowGenre, CountGenre, nList, ResultGenre, "Genre");
		DisplayItem("BackAdvance.BackListDance", IndexShowDance, CountDance, nList, ResultDance, "Dance");
		StarRating(-1);
	}
//	Selection.setFocus(InputText)
}
////
TopBar.ButtonO.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Option (Ctrl+O)", SHTT, -(104/2)+5, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieO");
	ButtonTip._visible = false;
	TextTip._visible = false;
};
TopBar.ButtonO.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	fscommand("ShowOption");
};
TopBar.ButtonX.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Drop Down Menu (Ctrl+D)", SHTT, -173.55+5, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieX");
	ButtonTip._visible = false;
	TextTip._visible = false;
};
TopBar.ButtonX.onRelease = function() {
	fscommand("HideSearchBox");//Se 03-11-2006 visible Search Box
	showHideMenu(!(Menu._visible));
};
function showHideMenu(TF) // 170205
{
	if (send_event("normal&&&function||showHideMenu|~|"+TF+"||2", false)) {
		return;
	}

	if (String(TF)=="true") {
		Menu._visible = true;				
	} else {
		HideMenu();	
	}
}
// ................................Menu.......................
Menu._visible = false;
Menu.Exit.Text.text = "Exit";
Menu.Min.Text.text = "Minimize";
Menu.Scan.Text.text = "Scan File";
Menu.RipCD.Text.text = "Rip CD";
// Menu.Player.Text.text = "Show Player";
eval("Menu.RipCD.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.RipCD.Movie");
	MenuMISC._visible = false;
};
eval("Menu.RipCD.Button").onRelease = function() {
	if (MainLevel == 4 && DisplayFromSearch==0) {
		HideMenu();
		ClickMenu = 0;
		fscommand("ShowRipCD", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~TrackPage");
	} else {
		fscommand("ShowRipCD", 0);
	}
};
eval("Menu.Player.Button").onRelease = function() {
	HideMenu();
	ClickMenu = 0;
	fscommand("ShowPlayer");
	TopBar.ButtonX.onRollOver();
};
eval("Menu.Player.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Player.Movie");
};
eval("Menu.Exit.Button").onRollOver = function() {
	MenuMISC._visible = false;
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Exit.Movie");
};
eval("Menu.Exit.Button").onRelease = function() {
	HideMenu();
	fscommand("Exit");
};
eval("Menu.Min.Button").onRollOver = function() {
	MenuMISC._visible = false;
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Min.Movie");
};
eval("Menu.Min.Button").onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	HideMenu();
	fscommand("Minimize");
	CtrlKey = false;
	TopBar.ButtonM.onRollOver();
};
eval("Menu.Scan.Button").onRollOver = function() {
	MenuMISC._visible = false;
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Scan.Movie");
};
eval("Menu.Scan.Button").onRelease = function() {
	HideMenu();
	fscommand("ShowScan");
	TopBar.ButtonM.onRollOver();
};
ButtonTip.onRollOver = function() {
	this._visible = false;
	TextTip._visible = false;
};
// onRollOut
TopBar.ButtonB.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonM.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonS.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonP.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonC.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonL.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonO.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonX.onRollOut = function() {
	HideTooltip("txtTooltip");
};
function ChangeUnicode(){
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
	DisplayTextAlbum("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum);
	if (BackAlbumInfo._visible) {
		ChangeAlbumInfoFont(ChangeLan, SaveAlbumInfo);
	}
}