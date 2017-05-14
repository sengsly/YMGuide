//.........................		VARIABLE DECLEARATION.................
var UniPro = "";
var UniAlbumTitle = "";
var UniRating = "";
var UniAlbumLength = "";
var UniReleaseDate = "";
var UniPreTrack, UniNextTrack = "";
var BgColorValue, NumMovie, AlbumCover, NumCover, ChangeLang, EngFont, UniFont, EngSize, UniSize, TrackPosUni, TrackPosEng;
var SelectColorValue, SetColorValue, ButtonAlpha, ButtonSelAlpha, FontColor, BrowseBy, MyFavAlbum, MyAlbum, MyFavArtist, DisplayAlbum, UniNoSelect, AlbumNumber, Rank, PlusCover;
var PlayMode, ScaleW;
var PicFolderName = "";
var KhmerFont, KhmerSize = "";
var StoreYear = 0;
var StoreNameSelected = "";
var flashFocus = 0;
//=====================================================================
var grouping_str = "";
var Grouping = "";
function showPopupGrouping(val_group) {
	if (val_group == "-1") {
		grouping_str = "Grouping OFF";
	} else {
		grouping_str = "Grouping ON";
	}
	popupGrouping.setTrackShow(grouping_str);
	if (BrowseShow._visible == true) {
		popupGrouping._y = BrowseShow._y+(BrowseShow._height/2)+(popupGrouping._height)/2+5;
	}
}
//=====================================================================
//.......................................XXXX...........................
//...........................LOAD XML...................................
function LoadXmlLanguage(St) {
	var SettingXml = new XML();
	fscommand("ValuePlayer", MainLevel);
	TopBar.Flag.loadMovie(MainPathImage+"\\Folder.jpg");
	SettingXml.load(GetPath+"\\Language.xml");
	SettingXml.onLoad = function() {
		databaseType = Number(SettingXml.childNodes[0].attributes.databaseType);
		EngFont = SettingXml.childNodes[0].childNodes[0].attributes.FontEng;
		UniFont = SettingXml.childNodes[0].childNodes[0].attributes.FontUni;
		if (WideScreen == "Normal" or WideScreen == "smallWideScreen" or WideScreen == "largeWideScreen") {
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSize, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSize, 10);
		} else {
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSizeWide, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSizeWide, 10);
		}
		TrackPosEng = SettingXml.childNodes[0].childNodes[0].attributes.TrackPos;
		TrackPosUni = SettingXml.childNodes[0].childNodes[0].attributes.TrackPosUni;
		UniPro = SettingXml.childNodes[0].childNodes[1].attributes.UniPro;
		UniAlbumTitle = SettingXml.childNodes[0].childNodes[1].attributes.UniAlbumTitle;
		UniPreTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniPreTrack;
		UniNextTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniNextTrack;
		UniTrackTitle = SettingXml.childNodes[0].childNodes[1].attributes.UniTrackTitle;
		UniNoSelect = "Select All";
		BrowseBy = SettingXml.childNodes[0].childNodes[0].attributes.BrowseBy;
		MyFavAlbum = SettingXml.childNodes[0].childNodes[0].attributes.MyFavAlbum;
		MyAlbum = SettingXml.childNodes[0].childNodes[0].attributes.MyAlbum;
		MyFavArtist = SettingXml.childNodes[0].childNodes[0].attributes.MyFavArtist;
		DisplayAlbum = SettingXml.childNodes[0].childNodes[0].attributes.DisplayAlbum;
		AvaValue = SettingXml.childNodes[0].childNodes[0].attributes.AvaValue;
		Grouping = SettingXml.childNodes[0].childNodes[0].attributes.Grouping;
		i_SearchTrackFromArtist = int(SettingXml.childNodes[0].childNodes[0].attributes.SearchTrackFromArtist);
		//MenuBrowse.FavArtist.Text.text = "  MyFavArtists";			//change to 	TVSeries		
		var StrFont = EngFont+"~"+UniFont+"~"+EngSize+"~"+UniSize+"~"+TrackPosEng+"~"+TrackPosUni+"~"+BrowseBy+"~"+MyFavAlbum+"~"+MyFavArtist+"~"+DisplayAlbum+"~"+MyAlbum;
		fscommand("databaseType", databaseType);
		fscommand("StrFont", StrFont+"%%"+Grouping);
		LoadSetting(St);
		TopBar.ButtonM.onRollOver();
		TopBar._visible = true;
		//(1 Movie,2 TVSeries,4 Music,8 Karaoke)
		//EDID:2005.10.20
		if ((databaseType & 2) == 2 or (databaseType & 1) == 1) {
			//TV Series
			MenuBrowse.FavArtist.Text.text = "  TV Series";
			//change to 	TVSeries
		} else {
			MenuBrowse.FavArtist.Text.text = "  MyFavArtists";
			//change to MyFavArtists
		}
		RecordIndexGenre = 0;
		//...............
		if (DisplayAlbum == "Browse") {
			if (BrowseBy == "ReleaseDate") {
				BrowseShow.setTrackShow("Browsing By Release Date"+"||Sorting By "+SortedNameGenre);
			} else {
				BrowseShow.setTrackShow("Browsing By "+BrowseBy+"||Sorting By "+SortedNameGenre);
			}
		} else if (DisplayAlbum == "MyFavAlbum") {
			BrowseShow.setTrackShow("Browsing By My Favorite Albums"+"||Sorting By "+SortedNameFavAlbum);
		} else if (DisplayAlbum == "MyAlbum") {
			BrowseShow.setTrackShow("Browsing By My Albums"+"||Sorting By "+SortedNameMyAlbum);
		} else if (DisplayAlbum == "MyFavArtist") {
			if (MenuBrowse.FavArtist.Text.text == "  MyFavArtists") {
				BrowseShow.setTrackShow("Browsing By My Favorite Artists"+"||Sorting By "+SortedNameFavArtist);
			} else {
				BrowseShow.setTrackShow("Browsing By TV Series"+"||Sorting By "+SortedNameFavArtist);
			}
		}
		if (clientType<>clonePlayBack) {
			//or BrowseNameList[6]==0 or BrowseNameList[6]==undefined) {
			showPopupGrouping(Grouping);
			SuiteAction.StoredProcedure = "loadDefault";
			RefreshBrowse();
		} else {
			Send2Server("other", "requestBrowse", true);
		}
	};
}
///..............................XXXX.................................................
var ColorRating = "";
var HideMouse = "false";
function LoadSetting(St) {
	var SplitSt = St.split("~");
	BgColorValue = SplitSt[0];
	var StNumMovie = SplitSt[1];
	ChangeColorNoAlpha("Bg", BgColorValue);
	if (DisplayAlbumLong == "true") {
		if (StNumMovie == "Small") {
			NameAlbum = "SmallIcon";
			ScaleW = ScaleSmall;
			NumMovie = nSmall;
		} else if (StNumMovie == "Medium") {
			NameAlbum = "BigIcon";
			ScaleW = ScaleMedium;
			NumMovie = nMedium;
		} else {
			NameAlbum = "BBigIcon";
			NumMovie = nLarge;
			ScaleW = ScaleLarge;
		}
	} else {
		//Display Album as short Icon......
		if (StNumMovie == "Small") {
			NameAlbum = "SmallIcons";
			ScaleW = ScaleSmalls;
			NumMovie = nSmalls;
		} else if (StNumMovie == "Medium") {
			NameAlbum = "BigIcons";
			ScaleW = ScaleMediums;
			NumMovie = nMediums;
		} else {
			NameAlbum = "BBigIcons";
			NumMovie = nLarges;
			ScaleW = ScaleLarges;
		}
	}
	PicX = GetXYcor(NameAlbum, "x");
	PicY = GetXYcor(NameAlbum, "y");
	ActiveButtonAlbum(NameAlbum);
	AlbumCover = SplitSt[2];
	NumCover = SplitSt[3];
	SortedValue = SplitSt[4];
	SetColorValue = SplitSt[6];
	ButtonAlpha = SplitSt[7];
	SelectColorValue = SplitSt[8];
	ButtonSelAlpha = SplitSt[9];
	FontColor = SplitSt[10];
	ChangeLan = SplitSt[13];
	AlbumNumber = SplitSt[18];
	Rank = SplitSt[19];
	PlusCover = SplitSt[20];
	var CDType = SplitSt[21];
	fscommand("DefineCDType", CDType);
	PlayMode = SplitSt[14];
	//Make default to play only one track 
	PlayAll.Text.text = "One";			
	PlayAll.Icon2._visible = false;				
	//============================
//	PlayAll.Text.text = PlayMode;
//	if (PlayAll.Text.text == "One") {
//		PlayAll.Icon2._visible = false;
//	}
	ChangeColorBar(SplitSt[23]);
	ColorRating = SplitSt[26];
	HideMouse = SplitSt[27];
	if (HideMouse == "true") {
		Mouse.hide();
	}
	ChangeColorAndAlpha(SetColorValue, ButtonAlpha);
	SetFontColor(FontColor);
	changeColorButton();
	// change colo mini player
}
function ChangeColorBar(Value) {
	TrackShow.setTrackDisplayTheme(FontColor, Value);
	BrowseShow.setTrackDisplayTheme(FontColor, Value);
	popupGrouping.setTrackDisplayTheme(FontColor, Value);
	ChangeColor("TopBar.Bar", Value, 100);
	ChangeColor("MenuFavAlbum.Bar", Value, 100);
	ChangeColor("MenuMyAlbum.Bar", Value, 100);
	ChangeColor("MenuFavArtist.Bar", Value, 100);
	ChangeColor("MenuSorted1.Bar", Value, 100);
	ChangeColor("MenuSortedReleaseDate.Bar", Value, 100);
	ChangeColor("MenuSorted.Bar", Value, 100);
	ChangeColor("MenuAva.Bar", Value, 100);
	ChangeColor("MenuBrowse.Bar", Value, 100);
	ChangeColor("MenuMISC.Bar", Value, 100);
	ChangeColor("Menu.Bar", Value, 100);
	ChangeColor("GenreBar.Bar", Value, 100);
	ChangeColor("ArrowBar.Bar", Value, 100);
	ChangeColor("VolBar.Bar", Value, 100);
	ChangeColor("AlbumBar.Bar", Value, 100);
	ChangeColor("ArtistNameBar.Bar", Value, 100);
	ChangeColor("CharBar.Bar", Value, 100);
	ChangeColor("RatingBar.Bar", Value, 100);
	ChangeColor("ButtonTip", Value, 100);
}
///...........................XXXX..........................
function RefreshBrowse() {
	//	hidePlayer();									if it connected it hide the video area
	OpenSortMaster = "false";
	FirstLoadCountry = "false";
	/* Invisible all Object		*/
	VolBar._visible = false;
	ArrowBar._visible = false;
	BackAlbumPic._visible = false;
	/* button command */
	PlayAll._visible = false;
	SearchArtist._visible = false;
	AlbumInfo._visible = false;
	Cart._visible = false;
	PreAlbum._visible = false;
	NextAlbum._visible = false;
	/////////////////////////////
	eval(NameAlbum)._visible = false;
	mainLetter_mc._visible = false;
	//All AlbumBar
	eval(TrackName)._visible = false;
	//Track Bar
	////////////////////////////////////////////////////////////
	if (DisplayAlbum == "Browse") {
		MainLevel = 1;
		if (BrowseBy == "Genre" || BrowseBy == "Artist") {
			fscommand("GetGenre", "Genre");
			PicFolderName = "GenrePic";
			SelectColorMenuBrowse("MenuBrowse.Genre.Text");
		} else if (BrowseBy == "Production") {
			SelectColorMenuBrowse("MenuBrowse.Production.Text");
			fscommand("GetGenre", "Production");
		} else if (BrowseBy == "ReleaseDate") {
			FirstLoadYear = true;
			fscommand("SetAvatoSetting", AvaValue+"~"+SortedValue);
			SelectColorMenuBrowse("MenuBrowse.ReleaseDate.Text");
			fscommand("GetGenre", "ReleaseDate");
		} else if (BrowseBy == "Rating") {
			BackLetter._visible = true;
			SelectColorMenuBrowse("MenuBrowse.Rating.Text");
			if (SuiteAction.StoredProcedure == "RequestNextArtist" and SuiteAction.GotoLevels>MainLevel) {
				selectCharBar(SuiteAction.RecordLetter);
			}
		} else if (BrowseBy == "Alphabet") {
			mainLetter_mc._visible = true;
			if (ChangeLan == "Uni") {
				mainLetter_mc.readXmlLetter(GetPath+"\\alphabetUnicode.xml");
			} else {
				mainLetter_mc.readXmlLetter(GetPath+"\\alphabet.xml");
			}
			fscommand("ValuePlayer", MainLevel);
			SelectColorMenuBrowse("MenuBrowse.Alphabet.Text");
		}
	} else if (DisplayAlbum == "MyFavAlbum") {
		MainLevel = 3;
		fscommand("SetAvatoSetting", AvaValue+"~"+SortedValue);
		fscommand("GetMyFavAlbum", MyFavAlbum);
		SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
		//DisibleClick("MyFavAlbum")
	} else if (DisplayAlbum == "MyAlbum") {
		MainLevel = 3;
		fscommand("GetMyAlbum", MyAlbum);
		SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
		//DisibleClick("MyAlbum")
	} else if (DisplayAlbum == "MyFavArtist") {
		MainLevel = 2;
		fscommand("SetAvatoSetting", AvaValue+"~"+SortedValue);
		//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
		if (databaseType == 1 or databaseType == 2) {
			//Movie and TVSeries
			fscommand("GetTVSeries");
		} else {
			//Music and Karaoke
			fscommand("GetMyFavArtist", MyFavArtist);
		}
		SelectColorMenuBrowse("MenuBrowse.FavArtist.Text");
		//DisibleClick("MyFavArtist")
	}
}
//............................XXXX.....................................
///..........................SET COLOR OR FONT...............
function SelectColorMenuBrowse(Obj) {
	MenuBrowse.Genre.Text.textColor = FontColor;
	MenuBrowse.Genre.Arrow.textColor = FontColor;
	MenuBrowse.Production.Text.textColor = FontColor;
	MenuBrowse.Production.Arrow.textColor = FontColor;
	MenuBrowse.ReleaseDate.Arrow.textColor = FontColor;
	MenuBrowse.Rating.Text.textColor = FontColor;
	if (databaseType == 4 or databaseType == 8) {
		//only available for karaoke
		MenuBrowse.Alphabet.Text.textColor = FontColor;
		MenuBrowse.Alphabet.Button.enabled = true;
	} else {
		MenuBrowse.Alphabet.Button.enabled = false;
		MenuBrowse.Alphabet.Text.textColor = COLOR_DISABLED;
	}
	MenuBrowse.FavAlbum.Text.textColor = FontColor;
	MenuBrowse.FavAlbum.Arrow.textColor = FontColor;
	MenuBrowse.MyAlbum.Text.textColor = FontColor;
	MenuBrowse.MyAlbum.Arrow.textColor = FontColor;
	MenuBrowse.ReleaseDate.Text.textColor = FontColor;
	if (databaseType == 1) {
		MenuBrowse.FavArtist.Text.textColor = COLOR_DISABLED;
		MenuBrowse.FavArtist.Button.enabled = false;
	} else {
		MenuBrowse.FavArtist.Text.textColor = FontColor;
		MenuBrowse.FavArtist.Button.enabled = true;
	}
	MenuBrowse.FavArtist.Arrow.textColor = FontColor;
	eval(Obj).textColor = SelectColorValue;
}
function ChangeColorTextSelected(Obj, Obj1) {
	var spl = Obj.split(",");
	for (var j = 0; j<spl.length; j++) {
		eval(spl[j]).textColor = FontColor;
	}
	eval(Obj1).textColor = SelectColorValue;
}
function SelectColorMenuFavAlbum(Obj) {
	MenuFavAlbum.Genre.Text.textColor = FontColor;
	MenuFavAlbum.Production.Text.textColor = FontColor;
	MenuFavAlbum.Rating.Text.textColor = FontColor;
	MenuFavAlbum.Rank.Text.textColor = FontColor;
	eval(Obj).textColor = SelectColorValue;
}
function SelectColorMenuMyAlbum(Obj) {
	MenuMyAlbum.Genre.Text.textColor = FontColor;
	MenuMyAlbum.Production.Text.textColor = FontColor;
	MenuMyAlbum.Rating.Text.textColor = FontColor;
	MenuMyAlbum.Rank.Text.textColor = FontColor;
	eval(Obj).textColor = SelectColorValue;
}
function SelectColorMenuFavArtist(Obj) {
	MenuFavArtist.Genre.Text.textColor = FontColor;
	MenuFavArtist.Production.Text.textColor = FontColor;
	MenuFavArtist.Rating.Text.textColor = FontColor;
	eval(Obj).textColor = SelectColorValue;
}
function SetFontColor(FontColor1) {
	Menu.Ava.Arrow._visible = true;
	Menu.BrowseBy.Arrow._visible = true;
	MenuBrowse.Genre.Arrow._visible = true;
	MenuBrowse.Production.Arrow._visible = true;
	MenuBrowse.ReleaseDate.Arrow._visible = true;
	MenuBrowse.FavArtist.Arrow._visible = true;
	MenuBrowse.FavAlbum.Arrow._visible = true;
	MenuBrowse.MyAlbum.Arrow._visible = true;
	Menu.MISC.Arrow._visible = true;
	AlbumInfo.Text.textColor = FontColor1;
	var FormatFont1 = new TextFormat();
	FormatFont1.font = EngFont;
	FormatFont1.size = EngSize;
	FormatFont1.bold = true;
	for (var j = 0; j<nLetter; j++) {
		eval("BackLetter.Letter"+j+".Text")._visible = false;
	}
	ChangeColorNoAlpha("BackLetter.CoverLetter1", FontColor1);
	ChangeColorNoAlpha("BackLetter.BackAll.LetterAll", FontColor1);
	ChangeColorNoAlpha("CharBar.L6.LetterAll", FontColor1);
	ChangeFontLetter(EngFont);
	for (var j = 0; j<nGenre; j++) {
		eval("GenreBar.Text"+j).textColor = FontColor1;
		eval("PurchaseCDMode.Text"+j).textColor = FontColor1;
		eval("PurchaseCDMode.TextCart"+j).textColor = FontColor1;
		ChangeColorNoAlpha("CharBar.L"+(j+1), FontColor1);
		eval("VolBar.Text"+j).textColor = FontColor1;
		eval("ArrowBar.Text"+j).textColor = FontColor1;
		eval("ArtistNameBar.Text"+j).textColor = FontColor;
	}
	ChangeColorNoAlpha("CharBar.L"+(6), FontColor1);
	//.........................
	SortMaster.TextLeft.textColor = FontColor1;
	SortMaster.TextRight.textColor = FontColor1;
	SortMaster.TextInfo.textColor = FontColor1;
	//save dialogbox
	Save.txtTitle.textColor = FontColor1;
	Save.txtDes.textColor = FontColor1;
	Save.txtPath.textColor = FontColor1;
	Save.txtApp.textColor = FontColor1;
	Save.txtOver.textColor = FontColor1;
	Save.txtSaver.textColor = FontColor1;
	Save.txtKey.textColor = FontColor1;
	Save.txtOk.textColor = FontColor1;
	Save.txtCancel.textColor = FontColor1;
	//end save dialogbox
	eval(TrackName).TextLeft.textColor = FontColor1;
	eval(TrackName).TextRight.textColor = FontColor1;
	eval(TrackName).TrackLen.textColor = FontColor1;
	eval(TrackName).Mood.textColor = FontColor1;
	eval(TrackName).Dance.textColor = FontColor1;
	eval(TrackName).Artist.textColor = FontColor1;
	eval(TrackName).TextToolTip.textColor = FontColor1;
	eval(TrackName).Year.textColor = FontColor1;
	for (var j = 0; j<12; j++) {
		eval("SortMaster.Text"+j).textColor = FontColor1;
	}
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Letter"+j).textColor = FontColor1;
		eval(NameAlbum+".Artist"+j).textColor = SelectColorValue;
		eval(NameAlbum+".Num"+j).textColor = SelectColorValue;
	}
	TextTip.textColor = SelectColorValue;
	//PlayAll.Text.setTextFormat(FormatFont1);
	AlbumInfo.Text.setTextFormat(FormatFont1);
	PreAlbum.Text.setTextFormat(FormatFont1);
	NextAlbum.Text.setTextFormat(FormatFont1);
	ArrowBar.Text.textColor = SelectColorValue;
	//PlayAll.Text.textColor = FontColor1;
	AlbumInfo.Text.textColor = FontColor1;
	PreAlbum.Text.textColor = FontColor1;
	NextAlbum.Text.textColor = FontColor1;
	MenuSorted.NameSorted.Text.textColor = FontColor1;
	MenuSorted.DateSorted.Text.textColor = FontColor1;
	MenuSorted1.NameSorted.Text.textColor = FontColor1;
	MenuSorted1.DateSorted.Text.textColor = FontColor1;
	MenuSortedReleaseDate.NameSorted.Text.textColor = FontColor1;
	MenuSortedReleaseDate.DateSorted.Text.textColor = FontColor1;
	MenuAva.YesAva.Text.textColor = FontColor1;
	MenuAva.NotAva.Text.textColor = FontColor1;
	MenuAva.AllAva.Text.textColor = FontColor1;
	Menu.Sorted.Text.textColor = FontColor1;
	Menu.Ava.Text.textColor = FontColor1;
	Menu.Ava.Arrow.textColor = FontColor1;
	Menu.Exit.Text.textColor = FontColor1;
	Menu.Min.Text.textColor = FontColor1;
	Menu.RipCD.Text.textColor = FontColor1;
	Menu.BrowseBy.Text.textColor = FontColor1;
	Menu.BrowseBy.Arrow.textColor = FontColor1;
	Menu.Player.Text.textColor = FontColor1;
	//..............
	Menu.MISC.Text.textColor = FontColor1;
	Menu.MISC.Arrow.textColor = FontColor1;
	MenuMISC.UpdateDB.Text.textColor = FontColor1;
	UpdateDB.Text.text = "";
	MenuMISC.RestoreDB.Text.textColor = FontColor1;
	MenuMISC.InputBox.Text.textColor = FontColor1;
	MenuMISC.BackUpDB.Text.textColor = FontColor1;
	MenuMISC.CopyFolder.Text.textColor = FontColor1;
	MenuMISC.AddNewScreen.Text.textColor = FontColor1;
	//..............
	Menu.Scan.Text.textColor = FontColor1;
	FormatFont1.font = "Arial";
	FormatFont1.size = StaticFontSize-8;
	MenuAva.NotAva.Text.setTextFormat(FormatFont1);
	ChangeColorSubMenus();
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
function SelectButton(Obj) {
	if (eval(TrackName)._visible && eval(TrackName).TextToolTip._visible) {
		eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
	}
	ChangeColor(StoreNameSelected, SetColorValue, ButtonAlpha);
	ChangeColor(Obj, SelectColorValue, ButtonSelAlpha);
	StoreNameSelected = Obj;
	if (flashFocus == 0) {
		flashFocus = 1;
		fscommand("onFocus", true);
	}
}
function ChangeColorAndAlpha(ColorValue1, Alpha1) {
	ChangeColor("TopBar.MovieM", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieB", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieS", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieP", ColorValue1, Alpha1);
	//	ChangeColor("TopBar.MovieRip", ColorValue1, Alpha1);
	//	ChangeColor("TopBar.MovieScan", ColorValue1, Alpha1);
	ChangeColor("TopBar.MoviePlayer", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieFull", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieC", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieL", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieO", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieX", ColorValue1, Alpha1);
	ChangeColor("BackLetter.BackAll.MovieAll", ColorValue1, Alpha1);
	for (var j = 0; j<nLetter; j++) {
		ChangeColor("BackLetter.Letter"+j+".Movie", ColorValue1, Alpha1);
	}
	ChangeColor("GenreBar.MovieOpt", ColorValue1, Alpha1);
	ChangeColor("GenreBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("GenreBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("AlbumBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("AlbumBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("CharBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("CharBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("CharBar.Movie1Left", ColorValue1, Alpha1);
	ChangeColor("CharBar.Movie1Right", ColorValue1, Alpha1);
	ChangeColor("ArtistNameBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("ArtistNameBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieArrowLeft", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieArrowRight", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieArrowRight", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieArrowLeft", ColorValue1, Alpha1);
	ChangeColor("TrackBar.ScanAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("ListBar.ScanAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".MusicNote.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".RefreshCoverArt.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".PathSlideshow.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".PathChapter.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".PlusIcon.Movie", ColorValue1, Alpha1);
	for (var j = 0; j<nGenre; j++) {
		ChangeColor("GenreBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("AlbumBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("CharBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("ArtistNameBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("VolBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("ArrowBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("RatingBar.Movie"+(j+1), ColorValue1, Alpha1);
		ChangeColor(TrackName+".BackStars.Movie"+(j+1), ColorValue1, Alpha1);
		ChangeColor("BackAlbumInfo.BackStars.Movie"+(j+1), ColorValue1, Alpha1);
		ChangeColor("PurchaseCDMode.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("PurchaseCDMode.MovieCart"+j, ColorValue1, Alpha1);
	}
	ChangeColor("PurchaseCDMode.MovieClose", ColorValue1, Alpha1);
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Year"+j).textColor = SelectColorValue;
		ChangeColor(NameAlbum+".Movie"+j, ColorValue1, Alpha1);
	}
	//save dialog box
	ChangeColor("Save.Bar", ColorValue1, Alpha1);
	ChangeColor("Save.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("Save.MovieOk", ColorValue1, Alpha1);
	ChangeColor("Save.Moviekey", ColorValue1, Alpha1);
	ChangeColor("Save.MovieAppand", ColorValue1, Alpha1);
	ChangeColor("Save.MovieEnd", ColorValue1, Alpha1);
	ChangeColor("Save.MovieTime", ColorValue1, Alpha1);
	ChangeColor("Save.MovieNextChapter", ColorValue1, Alpha1);
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
	//end save dialogbox	
	ChangeColor(TrackName+".MovieRight", ColorValue1, Alpha1);
	ChangeColor("BackAlbumPic.Movie", ColorValue1, Alpha1);
	for (var j = 0; j<12; j++) {
		ChangeColor(TrackName+".Movie"+j, ColorValue1, Alpha1);
		ChangeColor("SortMaster.Movie"+j, ColorValue1, Alpha1);
	}
	ChangeColor("SortMaster.MovieRight", ColorValue1, Alpha1);
	ChangeColor("SortMaster.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("SortMaster.BackAlbumPic.Movie", ColorValue1, Alpha1);
	ChangeColor("SortMaster.ButtonUp.Movie", ColorValue1, Alpha1);
	ChangeColor("SortMaster.ButtonDown.Movie", ColorValue1, Alpha1);
	ChangeColor("SortMaster.ButtonImg.Movie", ColorValue1, Alpha1);
	ChangeColor("SortMaster.ButtonDesImg.Movie", ColorValue1, Alpha1);
	ChangeColor("SortMaster.ButtonUp.MovieSel", SelectColorValue, Alpha1);
	ChangeColor("SortMaster.ButtonDown.MovieSel", SelectColorValue, Alpha1);
	ChangeColor("SortMaster.ButtonImg.MovieSel", SelectColorValue, Alpha1);
	ChangeColor("SortMaster.ButtonDesImg.MovieSel", SelectColorValue, Alpha1);
	ChangeColor("PlayAll.Movie", ColorValue1, Alpha1);
	ChangeColor("SearchArtist.Movie", ColorValue1, Alpha1);
	ChangeColor("chkVisibleIcon.Movie", ColorValue1, Alpha1);
	ChangeColor("SearchArtist.MovieSel", SelectColorValue, Alpha1);
	ChangeColor("AlbumInfo.Movie", ColorValue1, Alpha1);
	ChangeColor("Cart.Movie", ColorValue1, Alpha1);
	ChangeColor("AlbumInfo.Movie", ColorValue1, Alpha1);
	ChangeColor("PreAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("NextAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSorted.NameSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSorted.DateSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSorted1.NameSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSorted1.DateSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSortedReleaseDate.NameSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuSortedReleaseDate.DateSorted.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuAva.YesAva.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuAva.NotAva.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuAva.AllAva.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Sorted.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Ava.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Exit.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Min.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.RipCD.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Player.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.MISC.Movie", ColorValue1, Alpha1);
	//..........
	ChangeColor("MenuMISC.UpDateDB.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMISC.RestoreDB.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMISC.InputBox.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMISC.BackUpDB.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMISC.CopyFolder.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMISC.AddNewScreen.Movie", ColorValue1, Alpha1);
	//............
	ChangeColor("UpDateDB.Bar", ColorValue1, Alpha1);
	ChangeColor("BackUpDB.Bar", ColorValue1, Alpha1);
	ChangeColor("RestoreDB.Bar", ColorValue1, Alpha1);
	ChangeColor("InputBox.Bar", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.Bar", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.Bar", ColorValue1, Alpha1);
	ChangeColor("Menu.Scan.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.FavAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.MyAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.ReleaseDate.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.FavArtist.Movie", ColorValue1, Alpha1);
	//,,,,,,,,,,,,,
	for (var j = 0; j<nScreen; j++) {
		ChangeColor("AddNewScreens.Button"+j+".chk", ColorValue1, Alpha1);
		ChangeColor("AddNewScreens.Movie"+j, ColorValue1, Alpha1);
	}
	ChangeColor("AddNewScreens.MovieOk", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieRight", ColorValue1, Alpha1);
	//,,,,,,,,,,,,,,
	ChangeColor("Menu.BrowseBy.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.Genre.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.Production.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.Rating.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuBrowse.Alphabet.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavAlbum.Genre.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavAlbum.Production.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavAlbum.Rating.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavAlbum.Rank.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMyAlbum.Genre.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMyAlbum.Production.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMyAlbum.Rating.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuMyAlbum.Rank.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavArtist.Genre.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavArtist.Production.Movie", ColorValue1, Alpha1);
	ChangeColor("MenuFavArtist.Rating.Movie", ColorValue1, Alpha1);
	ChangeColor("UpdateDB.MovieOk", ColorValue1, Alpha1);
	ChangeColor("UpdateDB.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("UpdateDB.MovieBrowseDB", ColorValue1, Alpha1);
	ChangeColor("UpdateDB.MovieDownLoad", ColorValue1, Alpha1);
	ChangeColor("BackUpDB.MovieOk", ColorValue1, Alpha1);
	ChangeColor("BackUpDB.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("BackUpDB.MovieBrowseDB", ColorValue1, Alpha1);
	ChangeColor("RestoreDB.MovieOk", ColorValue1, Alpha1);
	ChangeColor("RestoreDB.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("RestoreDB.MovieBrowseDB", ColorValue1, Alpha1);
	ChangeColor("InputBox.MovieOk", ColorValue1, Alpha1);
	ChangeColor("InputBox.MovieCancel", ColorValue1, Alpha1);
	///Warning......
	ChangeColor("WarningUpdate.Bar", ColorValue1, Alpha1);
	ChangeColor("WarningUpdate.MovieOk", ColorValue1, Alpha1);
	ChangeColor("WarningUpdate.MovieCancel", ColorValue1, Alpha1);
	//..........
	ChangeColor("CopyMusic.MovieOk", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieBrowse1", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieBrowse2", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieCheck1", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieCheck2", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.MovieCheck3", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.ButtonCheck3.chk", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.ButtonCheck2.chk", ColorValue1, Alpha1);
	ChangeColor("CopyMusic.ButtonCheck1.chk", ColorValue1, Alpha1);
	//--------------------------Add Track By Code ID------------------------------------
	ChangeColor("AddTrackBox.MovieK", ColorValue1, Alpha1);
	ChangeColor("AddTrackBox.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("AddTrackBox.MovieOK", ColorValue1, Alpha1);
	if (DisplayAlbum == "Browse") {
		if (BrowseBy == "Genre" || BrowseBy == "Artist") {
			SelectColorMenuBrowse("MenuBrowse.Genre.Text");
		} else if (BrowseBy == "Production") {
			SelectColorMenuBrowse("MenuBrowse.Production.Text");
		} else if (BrowseBy == "ReleaseDate") {
			SelectColorMenuBrowse("MenuBrowse.ReleaseDate.Text");
		} else if (BrowseBy == "Rating") {
			SelectColorMenuBrowse("MenuBrowse.Rating.Text");
		} else if (BrowseBy == "Alphabet") {
			SelectColorMenuBrowse("MenuBrowse.Alphabet.Text");
		}
	} else if (DisplayAlbum == "MyFavAlbum") {
		SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
	} else if (DisplayAlbum == "MyAlbum") {
		SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
	} else if (DisplayAlbum == "MyFavArtist") {
		SelectColorMenuBrowse("MenuBrowse.FavArtist.Text");
	}
}
//.....................XXXX............................................
var SortedNameGenre, SortedNameFavAlbum, SortedNameFavArtist, SortedNameMyAlbum = "";
function ChangeColorSubMenus() {
	if (SortedValue == 1) {
		MenuSorted.NameSorted.Text.textColor = SelectColorValue;
		MenuSorted1.NameSorted.Text.textColor = SelectColorValue;
		MenuSortedReleaseDate.NameSorted.Text.textColor = SelectColorValue;
		SortedNameGenre = "Alphabet";
	} else {
		SortedNameGenre = "Release Date";
		MenuSorted.DateSorted.Text.textColor = SelectColorValue;
		MenuSorted1.DateSorted.Text.textColor = SelectColorValue;
		MenuSortedReleaseDate.DateSorted.Text.textColor = SelectColorValue;
	}
	if (AvaValue == 1) {
		MenuAva.YesAva.Text.textColor = SelectColorValue;
	} else if (AvaValue == 0) {
		MenuAva.NotAva.Text.textColor = SelectColorValue;
	} else {
		MenuAva.AllAva.Text.textColor = SelectColorValue;
	}
	//...............
	if (MyFavAlbum == "MyFavorite") {
		SortedNameFavAlbum = "Alphabet";
		SelectColorMenuFavAlbum("MenuFavAlbum.Genre.Text");
	} else if (MyFavAlbum == "ReleaseDate") {
		SortedNameFavAlbum = "Release Date";
		SelectColorMenuFavAlbum("MenuFavAlbum.Production.Text");
	} else if (MyFavAlbum == "Rating") {
		SortedNameFavAlbum = "Rating";
		SelectColorMenuFavAlbum("MenuFavAlbum.Rating.Text");
	} else if (MyFavAlbum == "Rank") {
		SortedNameFavAlbum = "Rank";
		SelectColorMenuFavAlbum("MenuFavAlbum.Rank.Text");
	} else {
		SortedNameFavAlbum = "Alphabet";
		MyFavAlbum = "MyFavorite";
		SelectColorMenuFavAlbum("MenuFavAlbum.Genre.Text");
	}
	///..............
	if (MyAlbum == "MyFavorite") {
		SortedNameMyAlbum = "Alphabet";
		SelectColorMenuMyAlbum("MenuMyAlbum.Genre.Text");
	} else if (MyAlbum == "ReleaseDate") {
		SortedNameMyAlbum = "Release Date";
		SelectColorMenuMyAlbum("MenuMyAlbum.Production.Text");
	} else if (MyAlbum == "Rating") {
		SortedNameMyAlbum = "Rating";
		SelectColorMenuMyAlbum("MenuMyAlbum.Rating.Text");
	} else if (MyAlbum == "Rank") {
		SortedNameMyAlbum = "Rank";
		SelectColorMenuMyAlbum("MenuMyAlbum.Rank.Text");
	} else {
		SortedNameMyAlbum = "Alphabet";
		MyAlbum = "MyFavorite";
		SelectColorMenuMyAlbum("MenuMyAlbum.Genre.Text");
	}
	//...........
	if (MyFavArtist == "MyFavorite") {
		SortedNameFavArtist = "Alphabet";
		SelectColorMenuFavArtist("MenuFavArtist.Genre.Text");
	} else if (MyFavArtist == "ReleaseDate") {
		SortedNameFavArtist = "Release Date";
		SelectColorMenuFavArtist("MenuFavArtist.Production.Text");
	} else if (MyFavArtist == "Rank") {
		SortedNameFavArtist = "Rank";
		SelectColorMenuFavArtist("MenuFavArtist.Rating.Text");
	} else {
		SortedNameFavArtist = "Alphabet";
		MyFavArtist == "MyFavorite";
		SelectColorMenuFavArtist("MenuFavArtist.Genre.Text");
	}
}
function GetAlbumNum(value) {
	if (value.length>0) {
		eval(NameAlbum)._visible = false;
		for (var j = 0; j<NumMovie; j++) {
			eval(NameAlbum+".Pic"+j).unloadMovie();
			eval(NameAlbum+".Picfade"+j).unloadMovie();
		}
		if (DisplayAlbumLong == "true") {
			//display album as Long Icon......
			if (value == "Small") {
				NumMovie = nSmall;
				NameAlbum = "SmallIcon";
				ScaleW = ScaleSmall;
			} else if (value == "Medium") {
				NumMovie = nMedium;
				NameAlbum = "BigIcon";
				ScaleW = ScaleMedium;
			} else {
				NumMovie = nLarge;
				NameAlbum = "BBigIcon";
				ScaleW = ScaleLarge;
			}
		} else {
			//display album as Short Icon......
			if (value == "Small") {
				NumMovie = nSmalls;
				NameAlbum = "SmallIcons";
				ScaleW = ScaleSmalls;
			} else if (value == "Medium") {
				NumMovie = nMediums;
				NameAlbum = "BigIcons";
				ScaleW = ScaleMediums;
			} else {
				NumMovie = nLarges;
				NameAlbum = "BBigIcons";
				ScaleW = ScaleLarges;
			}
		}
		PicX.length = 0;
		PicY.length = 0;
		PicX = GetXYcor(NameAlbum, "x");
		PicY = GetXYcor(NameAlbum, "y");
		ActiveButtonAlbum(NameAlbum);
		for (var j = 0; j<NumMovie; j++) {
			ChangeColor(NameAlbum+".Movie"+j, SetColorValue, ButtonAlpha);
			eval(NameAlbum+".Year"+j).textColor = SelectColorValue;
			eval(NameAlbum+".Artist"+j).textColor = SelectColorValue;
			eval(NameAlbum+".Num"+j).textColor = SelectColorValue;
			eval(NameAlbum+".Letter"+j).textColor = FontColor;
		}
		if (MainLevel == 2 && ArrowBar._visible) {
			//FirstDisplayMovie(resultSearchArtistName.length);
			eval(NameAlbum)._visible = true;
			var ArtistLength = resultSearchArtistName.length;
			resultSearchArrow.length = 0;
			resultSearchArrow = SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
			FirstDisplayArrow(resultSearchArrow.length);
			ArrowBar.Button0.onRelease();
		} else if (MainLevel == 3 && VolBar._visible) {
			if (DisplayAlbum == "MyFavArtist" || (DisplayAlbum == "Browse" && BrowseBy == "Genre")) {
				var ArtistLength = resultSearchArtistName.length;
				resultSearchArrow.length = 0;
				resultSearchArrow = SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
				FirstDisplayArrow(resultSearchArrow.length);
				ArrowBar.Button0.onRelease();
				//FirstDisplayMovie(resultSearchArtistName.length);
			}
			eval(NameAlbum)._visible = true;
			resultSearchVol.length = 0;
			resultSearchVol = SplitResultVol(resultSearchArtistAlbum.length, NumMovie);
			FirstDisplayVol(resultSearchVol.length);
			VolBar.Button0.onRelease();
		} else if (MainLevel == 4) {
			if (DisplayAlbum == "MyFavArtist" || (DisplayAlbum == "Browse" && BrowseBy == "Genre")) {
				var ArtistLength = resultSearchArtistName.length;
				resultSearchArrow.length = 0;
				resultSearchArrow = SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
				FirstDisplayArrow(resultSearchArrow.length);
				ArrowBar.Button0.onRelease();
				//FirstDisplayMovie(resultSearchArtistName.length);
			}
			resultSearchVol.length = 0;
			resultSearchVol = SplitResultVol(resultSearchArtistAlbum.length, NumMovie);
			FirstDisplayVol(resultSearchVol.length);
			VolBar.Button0.onRelease();
			eval(NameAlbum)._visible = false;
			TopBar.ButtonB.onRelease();
		}
	}
}
function loadTempImage(MObj, ind) {
	var Obj = new Object();
	var objPic = new Object();
	var Path = new String();
	var fileExten = new String();
	var fileNames = new String();
	var fileArtist = new String();
	Obj = TrackName;
	Path = "";
	if (eval(MObj+".Pic"+ind)._alpha == 100) {
		Path = eval(MObj+".Pic"+ind)._url;
	}
	if (eval(MObj+".Picfade"+ind)._alpha == 100) {
		Path = eval(MObj+".Picfade"+ind)._url;
	}
	Path = substring(Path, 8, -1);
	fileExten = substring(Path, (length(Path)-4)+1, -1).toUpperCase();
	fileNames = substring(Path, length(Path)-9, -1).toUpperCase();
	fileArtist = substring(Path, length(Path)-13, -1).toUpperCase();
	if (fileArtist != "ARTISTICON.SLY") {
		if ((fileExten != ".JPG") && (fileNames != "CDICON.SLY")) {
//			TopBar.ButtonM.onRollOver();			//2007-01-17 Seng Can't rollover album cover art
		}
		if ((fileExten == ".JPG") || (fileNames == "CDICON.SLY")) {
			for (var j = 0; j<nTrack; j++) {
				objPic = eval(Obj+".Pic"+j);
				objPic._visible = true;
				objPic.loadFadeImage(Path);
			}
			BackAlbumPic.loadFadeImage(Path);
			BackAlbumPic._visible = false;
		}
	}
}
function ActiveButtonAlbum(Obj) {
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Button"+j).onRollOver = function() {
			var IndexAlbum = GetNumber(this._name);
			SelectButton(NameAlbum+".Movie"+IndexAlbum);
			if (DisplayAlbumLong == "true") {
				//TextTip.text=eval(NameAlbum+".Letter"+IndexAlbum).valText;//eval(NameAlbum+".Letter"+IndexAlbum).text;
				popup_tooltip("TextTip:ButtonTip", eval(NameAlbum+".Letter"+IndexAlbum).valText);
			} else {
				//TextTip.text=eval(NameAlbum+".Letter"+IndexAlbum).text;
				popup_tooltip("TextTip:ButtonTip", eval(NameAlbum+".Letter"+IndexAlbum).text);
			}
			if (resultSearchArtistAlbum[IndexAlbum+storeindexvol1].uniArtist != "") {
				ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
			}
			ButtonTipChange();
			if (!TextTip._visible) {
				ButtonTip._visible = true;
				ButtonTip._y = 48;
				TextTip._visible = true;
				TextTip._y = 26;
			}
			SelectLevel = 3;
			DefineClickArtist = "true";
			TextTip._y = ButtonTip._y-Math.abs((TextTip._height-ButtonTip._height)/2);
			// Seng 2006-11-11		Can slect button when rollover Artist name in Browse by Genre
			loadTempImage(this._parent, substring(this._name, 7, -1));
		};
		eval(NameAlbum+".Button"+j).onRelease = function() {
			var si = 0;
			if (MainLevel == 2) {
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+GetNumber(this._name);
				si = clickArrowIndex;
			} else if (MainLevel == 3) {
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+GetNumber(this._name);
				si = clickVolIndex;
			}
			click_Albums(Index);
			//eval(NameAlbum+".Button"+0).onRollOver();
		};
		//.........................MyFavorite..............
		eval(NameAlbum+".Plus"+j).onRollOver = function() {
			var k = GetNumber(this._name);
			eval(NameAlbum+".Plus"+k+".Selected")._visible = true;
			DisplayTooltip(this, "txtTooltip", "Set Favorite", SHTT, -(117.3/2)+50, 50);
		};
		eval(NameAlbum+".Plus"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
			var k = GetNumber(this._name);
			if (MainLevel == 2) {
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if (resultSearchArtistName[Index].MyFav == "1") {
					eval(NameAlbum+".Plus"+k+".Selected")._visible = true;
				} else {
					eval(NameAlbum+".Plus"+k+".Selected")._visible = false;
				}
			} else if (MainLevel == 3) {
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if (resultSearchArtistAlbum[Index].MyFav == "1") {
					eval(NameAlbum+".Plus"+k+".Selected")._visible = true;
				} else {
					eval(NameAlbum+".Plus"+k+".Selected")._visible = false;
				}
			}
		};
		eval(NameAlbum+".Plus"+j).onRelease = function(myFav) {
			var k = GetNumber(this._name);
			if (String(myFav) == "") {
				if (MainLevel == 2) {
					var spl = resultSearchArrow[RecordIndexArrow].split(":");
					Index = (parseInt(spl[0], 10)-1)+k;
					var myFav = resultSearchArtistName[Index].MyFav;
				} else if (Mainlevel == 3) {
					var spl = resultSearchVol[RecordIndexVol].split(":");
					Index = (parseInt(spl[0], 10)-1)+k;
					var myFav = resultSearchArtistAlbum[Index].MyFav;
				}
			}
			if (send_event("normal&&&Click||"+this+"|~|"+myFav+"||0", false)) {
				return;
			}
			if (MainLevel == 2) {
				if (myFav == 1) {
					eval(NameAlbum+".Rank"+k)._visible = false;
					resultSearchArtistName[Index].MyFav = "0";
					eval(NameAlbum+".Plus"+k+".Selected")._visible = false;
					fscommand("SetArtistFavorite", resultSearchArtistName[Index].id+"~"+0);
				} else {
					eval(NameAlbum+".Rank"+k)._visible = true;
					resultSearchArtistName[Index].MyFav = "1";
					eval(NameAlbum+".Plus"+k+".Selected")._visible = true;
					fscommand("SetArtistFavorite", resultSearchArtistName[Index].id+"~"+1);
				}
			} else if (MainLevel == 3) {
				if (myFav == 1) {
					eval(NameAlbum+".Rank"+k)._visible = false;
					resultSearchArtistAlbum[Index].MyFav = "0";
					eval(NameAlbum+".Plus"+k+".Selected")._visible = false;
					fscommand("SetAlbumFavorite", resultSearchArtistAlbum[Index].id+"~"+0);
				} else {
					eval(NameAlbum+".Rank"+k)._visible = true;
					resultSearchArtistAlbum[Index].MyFav = "1";
					eval(NameAlbum+".Plus"+k+".Selected")._visible = true;
					fscommand("SetAlbumFavorite", resultSearchArtistAlbum[Index].id+"~"+1);
				}
			}
		};
		//...............RankArtist.................
		eval(NameAlbum+".Rank"+j+".Button").onRollOver = function() {
			var k = GetNumber(String(this._parent));
			if (!eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible) {
				eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = true;
				eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = true;
			}
			DisplayTooltip(this, "txtTooltip", "Set Favorite Ranking", SHTT, -(117.3/2)-50, 50);
		};
		eval(NameAlbum+".Rank"+j+".Button").onRollOut = function() {
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = false;
			HideTooltip("txtTooltip");
		};
		eval(NameAlbum+".Rank"+j+".Button").onRelease = function() {
			Send2Server("client", "0&&&Click||"+this, true);
			var k = GetNumber(String(this._parent));
			selection.setFocus(eval(NameAlbum+".Rank"+k+".Text"));
		};
		eval(NameAlbum+".Rank"+j+".Text").onChanged = function() {
			var k = GetNumber(String(this._parent));
			if (MainLevel == 2) {
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue", resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			} else if (MainLevel == 3) {
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		};
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRollOver = function() {
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = true;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = true;
		};
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRollOut = function() {
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = false;
		};
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRollOver = function() {
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = true;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = true;
		};
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRollOut = function() {
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible = false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible = false;
		};
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRelease = function() {
			Send2Server("client", "0&&&Click||"+this, true);
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".Text").text = int(eval(NameAlbum+".Rank"+k+".Text").text)-1;
			if (eval(NameAlbum+".Rank"+k+".Text").text<0) {
				eval(NameAlbum+".Rank"+k+".Text").text = 0;
			}
			if (MainLevel == 2) {
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue", resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			} else if (MainLevel == 3) {
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		};
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRelease = function() {
			Send2Server("client", "0&&&Click||"+this, true);
			var k = GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".Text").text = int(eval(NameAlbum+".Rank"+k+".Text").text)+1;
			if (MainLevel == 2) {
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue", resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			} else if (MainLevel == 3) {
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank = eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		};
	}
}