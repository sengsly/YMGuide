//............................................	TOPBAR ACTION....................
function VisibleSubBrowse() {
	MenuMISC._visible = false;
	MenuFavAlbum._visible = false;
	MenuFavArtist._visible = false;
	MenuMyAlbum._visible = false;
	MenuSorted._visible = false;
	MenuSorted1._visible = false;
	MenuSortedReleaseDate._visible = false;
}
function VisibleSubMenu() {
	MenuSorted._visible = false;
	MenuSorted1._visible = false;
	MenuSortedReleaseDate._visible = false;
	ClickMenuAva = 0;
	MenuAva._visible = false;
	MenuBrowse._visible = false;
	MenuFavAlbum._visible = false;
	MenuMyAlbum._visible = false;
	MenuFavArtist._visible = false;
	MenuMISC._visible = false;
}
VisibleSubMenu();
Menu._visible = false;
MenuSorted.NameSorted.Text.text = "Alphabet";
MenuSorted.DateSorted.Text.text = "Release Date";
MenuSorted1.NameSorted.Text.text = "Alphabet";
MenuSorted1.DateSorted.Text.text = "Release Date";
MenuSortedReleaseDate.NameSorted.Text.text = "Alphabet";
MenuSortedReleaseDate.DateSorted.Text.text = "Release Date";
MenuAva.YesAva.Text.text = "Album Available";
MenuAva.NotAva.Text.text = "Album Not Available";
MenuAva.AllAva.Text.text = "All Album";
Menu.Sorted.Text.text = "Sorted Album";
Menu.Ava.Text.text = "Available";
Menu.Exit.Text.text = "Exit";
Menu.Min.Text.text = "Minimize";
Menu.RipCD.Text.text = "Rip CD";
Menu.Player.Text.text = "About Sly";
Menu.MISC.Text.text = "MISC";
Menu.Scan.Text.text = "Scan File";
Menu.BrowseBy.Text.text = "Browse By";
MenuMISC.UpdateDB.Text.text = "Update Database";
MenuMISC.RestoreDB.Text.text = "Restore Favorite";
MenuMISC.BackUpDB.Text.text = "BackUp Favorite";
MenuMISC.CopyFolder.Text.text = "Copy Music Folder";
MenuMISC.AddNewScreen.Text.text = "Update Screen";
MenuBrowse.FavAlbum.Text.text = "   MyFavAlbums";
MenuBrowse.MyAlbum.Text.text = "   MyAlbums";
//MenuBrowse.FavArtist.Text.text = "  MyFavArtists";			//change to 	TVSeries
MenuBrowse.FavArtist.Text.text = "  TVSeries";			 
MenuBrowse.ReleaseDate.Text.text = "Release Date";
MenuBrowse.Genre.Text.text = "Genre";
MenuBrowse.Production.Text.text = "Production";
MenuBrowse.Rating.Text.text = "Rating";
MenuBrowse.Alphabet.Text.text = "Alphabet";
MenuFavAlbum.Genre.Text.text = "Alphabet";
MenuFavAlbum.Production.Text.text = "Release Date";
MenuFavAlbum.Rating.Text.text = "Rating";
MenuFavAlbum.Rank.Text.text = "Rank";
MenuMyAlbum.Genre.Text.text = "Alphabet";
MenuMyAlbum.Production.Text.text = "Release Date";
MenuMyAlbum.Rating.Text.text = "Rating";
MenuMyAlbum.Rank.Text.text = "Rank";
MenuFavArtist.Genre.Text.text = "Alphabet";
MenuFavArtist.Production.Text.text = "Release Date";
MenuFavArtist.Rating.Text.text = "Rank";
TopBar.ButtonB.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Back (backspace)", SHTT, 0, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieB");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonB.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonB.onRelease = function() {
	click_back_menu(OpenSortMaster,DisplayAlbum,MainLevel,BrowseBy,int(BackAlbumInfo._visible));
	tipPos(false);
};
TopBar.ButtonM.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Menu (Ctrl+M)", SHTT, -(96/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieM");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonM.onRollOut = function() {
	HideTooltip("txtTooltip");
};
/*
TopBar.ButtonRip.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Rip CD (Ctrl+R)", SHTT, -(108/2)+5, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieRip");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};

TopBar.ButtonRip.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonScan.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Scan File (Ctrl+F)", SHTT, -(120/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieScan");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonScan.onRollOut = function() {
	HideTooltip("txtTooltip");
};
*/
TopBar.ButtonPlayer.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Player Page (Ctrl+"+chr(KeyPlayer)+")", SHTT, -(148/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MoviePlayer");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonPlayer.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonFull.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Fullscreen Player (Ctrl+U)", SHTT, -(172/2)+5, 20);
	SelectLevel = 1;
	SelectButton("TopBar.MovieFull");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonFull.onRollOut = function() {
	HideTooltip("txtTooltip");
};
/*
TopBar.ButtonRip.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	if (MainLevel == 4) {
		fscommand("ShowRipCD", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~TrackPage");
	} else {
		fscommand("ShowRipCD", 0);
	z}
};
TopBar.ButtonScan.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	eval("Menu.Scan.Button").onRelease();
};
*/
TopBar.ButtonPlayer.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	fscommand("ShowPlayListPlayer");
};
TopBar.ButtonFull.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	//if (send_event("normal&&&Click||"+this+"||0", false)) {
	//	return;
	//}
	//fscommand("FullScreenPlayer");
	fscommand("mini","FullScreen|:|false");
//FullScreenPlayer
};
var MainLevel = 1;
var FirstGetGenre = "true";
var FirstLoadCountry = "false";
var FirstLoadYear = true;
TopBar.ButtonM.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	//Send2Server("client","0&&&Click||"+this,true);
	VisibleSubMenu();
	Menu._visible = false;
	if (DisplayAlbum == "Browse") {
		if (BrowseBy == "Genre") {
			if (MainLevel == 1) {
				if (GenreBar._visible) {
					GenreBar._visible = false;
					tipPos(false);
				} else {
					DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
					GenreBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 2) {
				if (CharBar._visible) {
					CharBar._visible = false;
					tipPos(false);
				} else {
					CharBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 3) {
				//changed 2005-09-08 seng displaying genre
				if (CharBar._visible) {
					CharBar._visible = false;
					tipPos(false);
				} else {
					CharBar._visible = true;
					tipPos(true);
				}
				
			} else if (MainLevel == 4) {
				if (AlbumBar._visible) {
					AlbumBar._visible = false;
					tipPos(false);
				} else {
					ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
					AlbumBar._visible = true;
					tipPos(true);
				}
			}
		} else if (BrowseBy == "Artist") {
			if (MainLevel == 3) {
				if (CharBar._visible) {
					CharBar._visible = false;
					tipPos(false);
				} else {
					CharBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 4) {
				if (AlbumBar._visible) {
					AlbumBar._visible = false;
					tipPos(false);
				} else {
					AlbumBar._visible = true;
					tipPos(true);
				}
			}
		} else if (BrowseBy == "Production") {
			if (MainLevel == 1) {
				if (GenreBar._visible) {
					GenreBar._visible = false;
					tipPos(false);
				} else {
					DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
					GenreBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 3) {//EDID.2006.05.15 Seng remove BackLetter from Browse by Production
				GenreBar._visible = !GenreBar._visible;
				tipPos(GenreBar._visible);
			} else if (MainLevel == 4) {
				if (AlbumBar._visible) {
					AlbumBar._visible = false;
					tipPos(false);
				} else {
					ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
					AlbumBar._visible = true;
					tipPos(true);
				}
			}
		} else if (BrowseBy == "Rating") {
			if (MainLevel == 1) {
				if (RatingBar._visible) {
					RatingBar._visible = false;
					tipPos(false);
				} else {
					RatingBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 3) {
				if (CharBar._visible) {
					CharBar._visible = false;
					tipPos(fasle);
				} else {
					CharBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 4) {
				if (AlbumBar._visible) {
					AlbumBar._visible = false;
					tipPos(false);
				} else {
					ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
					AlbumBar._visible = true;
					tipPos(true);
				}
			}
		} else if (BrowseBy == "ReleaseDate") {
			if (MainLevel == 3) {
				if (GenreBar._visible) {
					GenreBar._visible = false;
					tipPos(false);
				} else {
					if (FirstLoadYear) {
						fscommand("GetYear");
						FirstLoadYear = false;
					}
					DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
					GenreBar._visible = true;
					tipPos(true);
				}
			} else if (MainLevel == 4) {
				if (AlbumBar._visible) {
					AlbumBar._visible = false;
					tipPos(false);
				} else {
					ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
					AlbumBar._visible = true;
					tipPos(true);
				}
			}
		}
	} else if (DisplayAlbum == "MyFavAlbum") {
		if (MainLevel == 3) {
			if (GenreBar._visible) {
				GenreBar._visible = false;
				tipPos(false);
			} else {
				if (FirstLoadCountry != "true") {
					SplitResultGenre(AllCountryNames);
					FirstDisplayGenre(resultSearchGenre.length);
					FirstLoadCountry = "true";
				}
				DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
				GenreBar._visible = true;
				tipPos(true);
			}
		} else if (MainLevel == 4) {
			if (AlbumBar._visible) {
				AlbumBar._visible = false;
				tipPos(false);
			} else {
				ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
				AlbumBar._visible = true;
				tipPos(true);
			}
		}
	} else if (DisplayAlbum == "MyAlbum") {
		if (MainLevel == 3) {
			if (GenreBar._visible) {
				GenreBar._visible = false;
				tipPos(false);
			} else {
				if (FirstLoadCountry != "true") {
					SplitResultGenre(AllCountryNames);
					FirstDisplayGenre(resultSearchGenre.length);
					FirstLoadCountry = "true";
				}
				DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
				GenreBar._visible = true;
				tipPos(true);
			}
		} else if (MainLevel == 4) {
			if (AlbumBar._visible) {
				AlbumBar._visible = false;
				tipPos(false);
			} else {
				ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
				AlbumBar._visible = true;
				tipPos(true);
			}
		}
	} else if (DisplayAlbum == "MyFavArtist") {
		if (MainLevel == 2) {
			if (GenreBar._visible) {
				GenreBar._visible = false;
				tipPos(false);
			} else {
				if (FirstLoadCountry != "true") {
					SplitResultGenre(AllCountryNames);
					FirstDisplayGenre(resultSearchGenre.length);
					FirstLoadCountry = "true";
				}
				DisplayItemGenre("GenreBar", (LevelIndexGenre-1)*nGenre, CountGenre, nGenre);
				GenreBar._visible = true;
				tipPos(true);
			}
		} else if (MainLevel == 3) {
			if (ArtistNameBar._visible) {
				ArtistNameBar._visible = false;
				tipPos(false);
			} else {
				ShowMovieBar("ArtistNameBar", IndexShowArtistName, CountArtistName, nArtistName, resultSeason);
				ArtistNameBar._visible = true;
				tipPos(true);
			}
		} else if (MainLevel == 4) {
			if (AlbumBar._visible) {
				AlbumBar._visible = false;
				tipPos(false);
			} else {
				ShowMovieBar("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
				AlbumBar._visible = true;
				tipPos(true);
			}
		}
	}
};
TopBar.ButtonS.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Search (Ctrl+S)", SHTT, -(105.55/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieS");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonS.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonS.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	//Send2Server("client","0&&&Click||"+this,true);
	fscommand("ShowSearch");
};
TopBar.ButtonP.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Playlist (Ctrl+P)", SHTT, -(104.8/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieP");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonP.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonP.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	//Send2Server("client","0&&&Click||"+this,true);
	fscommand("ShowPlayList");
};
TopBar.ButtonC.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Language (Ctrl+"+chr(KeyLanguage)+")", SHTT, -(123.55/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieC");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonC.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonC.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	MainLevel = 0;
	//fscommand("ValuePlayer",0);
	fscommand("ShowCountry");
	Invisible();
};
TopBar.ButtonL.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Unicode/English (Ctrl+E)", SHTT, -(165/2)+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieL");
};
TopBar.ButtonL.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonL.onRelease = function(change2Lan) {
	var oldLanguage;
	if (change2Lan == undefined) {
		if (_global.boolMouseDown == false) {
			return;
		}
		_global.boolMouseDown = false;
		ChangeLan = (ChangeLan == "Uni") ? "Eng" : "Uni";
	} else {
		ChangeLan = change2Lan;
	}
	fscommand("ChangeLanguage", ChangeLan);
	/*if(BrowseBy=="Alphabet"){
		if (ChangeLan == "Uni"){
			mainLetter_mc.readXmlLetter(GetPath + "\\alphabetUnicode.xml");
		} else {
			mainLetter_mc.readXmlLetter(GetPath + "\\alphabet.xml");
		}
	}*/
};
TopBar.ButtonO.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Option (Ctrl+O)", SHTT, -50, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieO");
};
TopBar.ButtonO.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonO.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	fscommand("ShowOption");
};
TopBar.ButtonX.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Drop Down Menu (Ctrl+D)", SHTT, -173+5, 20);
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectLevel = 1;
	SelectButton("TopBar.MovieX");
	if (Menu._visible) {
		Menu._visible = false;
		VisibleSubMenu();
	}
};
TopBar.ButtonX.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonX.onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	ShowHideMenuButtonX(!(Menu._visible));
};
function ShowHideMenuButtonX(val){
	if (send_event("normal&&&function||ShowHideMenuButtonX|~|"+val+"||0", false)) {
		return;
	}
	if (String(val)=="true") {
		VisibleSubMenu();
		Menu._visible = true;
	} else {
		Menu._visible = false;
		VisibleSubMenu();
	}
}
//......................
var SortedValue = 1;
var MenuLevel = 0;
eval("MenuSorted.NameSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSorted.NameSorted.Movie");
};
eval("MenuSorted.NameSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	hideplayer();
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 1;
	fscommand("SortValue", SortedValue);
	if (MainLevel == 2 && BrowseBy == "Genre") {
		//may not used
		fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue);
	} else if (MainLevel == 3 && BrowseBy == "Genre") {
		//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
		if(databaseType==1 or databaseType==2){
			//Movie and TVSeries
	  		fscommand("AlbumByGenre" , resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}else{
			//Music and Karaoke
	  		fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}
 	} else {
		fscommand("SetSortedtoSetting", SortedValue+"~"+"Genre");
	}
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.NameSorted.Text");
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.NameSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.NameSorted.Text");
};
eval("MenuSorted.DateSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSorted.DateSorted.Movie");
};
eval("MenuSorted.DateSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	hideplayer();
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 0;
	fscommand("SortValue", SortedValue);
	if (MainLevel == 2 && BrowseBy == "Genre") {
		//may not used
      		fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
	} else if (MainLevel == 3 && BrowseBy == "Genre") {
		//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
		if(databaseType==1 or databaseType==2){
			//Movie and TVSeries
	  		fscommand("AlbumByGenre" , resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}else{
			//Music and Karaoke
	  		fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}
	} else {
		fscommand("SetSortedtoSetting", SortedValue+"~"+"Genre");
	}
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.DateSorted.Text");
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.DateSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.DateSorted.Text");
};
//...............
eval("MenuSorted1.NameSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSorted1.NameSorted.Movie");
};
eval("MenuSorted1.NameSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	hideplayer();
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 1;
	fscommand("SortValue", SortedValue);
	if (MainLevel == 3 && BrowseBy == "Production") {
		fscommand("GetAlbumByLabel", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
	} else {
		fscommand("SetSortedtoSetting", SortedValue+"~"+"Production");
	}
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.NameSorted.Text");
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.NameSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.NameSorted.Text");
};
///.........................
eval("MenuSortedReleaseDate.DateSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSortedReleaseDate.DateSorted.Movie");
};
eval("MenuSortedReleaseDate.DateSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 0;
	fscommand("SortValue", SortedValue);
	fscommand("BrowseAlbumBy", "ReleaseDate");
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.DateSorted.Text");
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.DateSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.DateSorted.Text");
};
eval("MenuSortedReleaseDate.NameSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSortedReleaseDate.NameSorted.Movie");
};
eval("MenuSortedReleaseDate.NameSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 1;
	fscommand("SortValue", SortedValue);
	fscommand("BrowseAlbumBy", "ReleaseDate");
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.NameSorted.Text");
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.NameSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.NameSorted.Text");
};
//......................
eval("MenuSorted1.DateSorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 2;
	SelectButton("MenuSorted1.DateSorted.Movie");
};
eval("MenuSorted1.DateSorted.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	hideplayer();
	VisibleSubMenu();
	Menu._visible = false;
	SortedValue = 0;
	fscommand("SortValue", SortedValue);
	if (MainLevel == 3 && BrowseBy == "Production") {
		fscommand("GetAlbumByLabel", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
	} else {
		fscommand("SetSortedtoSetting", SortedValue+"~"+"Production");
	}
	ChangeColorTextSelected("MenuSorted1.NameSorted.Text,MenuSorted1.DateSorted.Text", "MenuSorted1.DateSorted.Text");
	ChangeColorTextSelected("MenuSorted.NameSorted.Text,MenuSorted.DateSorted.Text", "MenuSorted.DateSorted.Text");
	ChangeColorTextSelected("MenuSortedReleaseDate.NameSorted.Text,MenuSortedReleaseDate.DateSorted.Text", "MenuSortedReleaseDate.DateSorted.Text");
};
//............................
var AvaValue = 1;
eval("MenuAva.YesAva.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuAva.YesAva.Movie");
};
eval("MenuAva.YesAva.Button").onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}

	AvaValue = 1;
	SelectMenu("YesAva");
};
eval("MenuAva.NotAva.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuAva.NotAva.Movie");
};
eval("MenuAva.NotAva.Button").onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}

	AvaValue = 0;
	SelectMenu("NotAva");
};
eval("MenuAva.AllAva.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuAva.AllAva.Movie");
};
eval("MenuAva.AllAva.Button").onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}

	AvaValue = 3;
	SelectMenu("AllAva");
};
function SelectMenu(Obj) {
	MenuAva.YesAva.Text.textColor = FontColor;
	MenuAva.NotAva.Text.textColor = FontColor;
	MenuAva.AllAva.Text.textColor = FontColor;
	eval("MenuAva."+Obj+".Text").textColor = SelectColorValue;
	Menu._visible = false;
	MenuSorted._visible = false;
	MenuAva._visible = false;
	TopBar.ButtonX.onRollOver();
	fscommand("SetAvatoSetting", AvaValue+"~"+SortedValue);
	if (SortMaster._visible) {
		SortMaster._visible = false;
		OpenSortMaster = "false";
	}
	if (DisplayAlbum == "Browse") {
		if (MainLevel == 3) {
			if (BrowseBy == "Genre") {
				fscommand("GetArtistAlbum", RecordIdArtistName+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "Artist") {
				fscommand("GetAlbumByLetter", RecordLetter+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "Production") {
				fscommand("GetAlbumByLabel", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
			} else if (BrowseBy == "Rating") {
				fscommand("GetAlbumByRating", RatingValue+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "ReleaseDate") {
				fscommand("ReleaseDate", StoreYear);
			}
		} else if (MainLevel == 2) {
			if (BrowseBy == "Genre") {
				fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue);
			} else if (BrowseBy == "ReleaseDate") {
				fscommand("ReleaseDate", StoreYear);
			}
		} else if (MainLevel == 4) {
			AlbumBar._visible = false;
			for (var j = 0; j<nAlbum; j++) {
				eval("AlbumBar.Pic"+j).unloadMovie();
				eval("AlbumBar.PicFade"+j).unloadMovie();
			}
			eval(TrackName)._visible = false;
			BackAlbumPic._visible = false;
			BackAlbumPic.Pic0.unloadMovie();
			BackAlbumPic.PicFade0.unloadMovie();
			VisiblePlay(false);
			BackAlbumInfo._visible = false;
			hidePlayer();
			if (BrowseBy == "Genre") {
				fscommand("GetArtistAlbum", RecordIdArtistName+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "Artist") {
				fscommand("GetAlbumByLetter", RecordLetter+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "Production") {
				fscommand("GetAlbumByLabel", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
			} else if (BrowseBy == "Rating") {
				fscommand("GetAlbumByRating", RatingValue+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue);
			} else if (BrowseBy == "ReleaseDate") {
				fscommand("ReleaseDate", StoreYear);
			}
		}
	} else if (DisplayAlbum == "MyFavAlbum") {
		if (MainLevel == 4) {
			hidePlayer();
		}
		eval("MenuBrowse.FavAlbum.Button").onRelease();
	} else if (DisplayAlbum == "MyAlbum") {
		if (MainLevel == 4) {
			hidePlayer();
		}
		eval("MenuBrowse.MyAlbum.Button").onRelease();
	} else if (DisplayAlbum == "MyFavArtist") {
		if (MainLevel == 4) {
			hidePlayer();
		}
		eval("MenuBrowse.FavArtist.Button").onRelease();
	}
}
eval("Menu.Sorted.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Sorted.Movie");
	eval("Menu.Sorted.Button").onRelease();
};
eval("Menu.MISC.Button").onRollOver = function() {
	SelectButton("Menu.MISC.Movie");
	SelectLevel = 5;
	MenuLevel = 0;
	VisibleSubMenu();
	if (!MenuMISC._visible) {
		MenuMISC._visible = true;
	}
};
var ClickMenuAva = 0;
eval("Menu.Ava.Button").onRollOver = function() {
	SelectButton("Menu.Ava.Movie");
	SelectLevel = 5;
	MenuLevel = 0;
	eval("Menu.Ava.Button").onRelease();
};
eval("Menu.Ava.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	if (ClickMenuAva == 0) {
		MenuAva._visible = true;
		ClickMenuAva = 1;
	}
};
eval("Menu.RipCD.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.RipCD.Movie");
	VisibleSubMenu();
};
eval("Menu.RipCD.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	if (MainLevel == 4) {
		VisibleSubMenu();
		Menu._visible = false;
		ClickMenu = 0;
		fscommand("ShowRipCD", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~TrackPage");
		TopBar.ButtonX.onRollOver();
	} else {
		VisibleSubMenu();
		Menu._visible = false;
		ClickMenu = 0;
		TopBar.ButtonX.onRollOver();
		fscommand("ShowRipCD", 0);
	}
};
Cover._visible = false;
Cover.useHandCursor = false;
MenuMISC.UpdateDB.Button.onRelease = function() {
	//Send2Server("client", "0&&&Click||"+this, true);
	loadXmlFromServer(LanName);
	MenuMISC._visible = false;
	Menu._visible = false;
};
MenuMISC.UpdateDB.Button.onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuMISC.UpdateDB.Movie");
};
MenuMISC.RestoreDB.Button.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	MenuMISC._visible = false;
	Menu._visible = false;
	Cover._visible = true;
	ReStoreDB._visible = true;
	RestoreDB.ButtonOk.onRollOver();
};
MenuMISC.RestoreDB.Button.onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuMISC.RestoreDB.Movie");
};
MenuMISC.BackUpDB.Button.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	MenuMISC._visible = false;
	Menu._visible = false;
	Cover._visible = true;
	BackUpDB._visible = true;
	BackUpDB.ButtonOk.onRollOver();
};
MenuMISC.BackUpDB.Button.onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuMISC.BackUpDB.Movie");
};
MenuMISC.CopyFolder.Button.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	MenuMISC._visible = false;
	Menu._visible = false;
	Cover._visible = true;
	CopyMusic._visible = true;
	CopyMusic.ButtonOk.onRollOver();
};
MenuMISC.CopyFolder.Button.onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuMISC.CopyFolder.Movie");
};
MenuMISC.AddNewScreen.Button.onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	if (StringScreens.length<=0) {
		getScreens();
	} else {
		fscommand("StrArrChecked", StringScreens);
	}
	MenuMISC._visible = false;
	Menu._visible = false;
};
MenuMISC.AddNewScreen.Button.onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuMISC.AddNewScreen.Movie");
};
eval("Menu.Player.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	Menu._visible = false;
	Cover._visible = true;
	fscommand("ShowAboutSly");
	SelectButton("");
};
eval("Menu.Player.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Player.Movie");
	VisibleSubMenu();
};
eval("Menu.Scan.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	fscommand("ShowScan");
};
eval("Menu.Scan.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Scan.Movie");
	VisibleSubMenu();
};
eval("Menu.Exit.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Exit.Movie");
	VisibleSubMenu();
};
eval("Menu.Min.Button").onRollOver = function() {
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.Min.Movie");
	VisibleSubMenu();
};
eval("Menu.Exit.Button").onRelease = function() {
	fscommand("Exit");
};
eval("Menu.Min.Button").onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}
	fscommand("Minimize");

	Menu._visible = false;
	VisibleSubMenu();
	CtrlKey = false;
	TopBar.ButtonM.onRollOver();
};
//...............Browse By...................
eval("Menu.BrowseBy.Button").onRollOver = function() {
	VisibleSubMenu();
	MenuBrowse._visible = true;
	SelectLevel = 5;
	MenuLevel = 0;
	SelectButton("Menu.BrowseBy.Movie");
};
eval("MenuBrowse.Genre.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuSorted._visible = true;
	SelectButton("MenuBrowse.Genre.Movie");
	SelectLevel = 5;
	MenuLevel = 1;
};
eval("MenuBrowse.Production.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuSorted1._visible = true;
	SelectButton("MenuBrowse.Production.Movie");
	SelectLevel = 5;
	MenuLevel = 1;
};
eval("MenuBrowse.Rating.Button").onRollOver = function() {
	VisibleSubBrowse();
	SelectButton("MenuBrowse.Rating.Movie");
	SelectLevel = 5;
	MenuLevel = 1;
};
eval("MenuBrowse.Alphabet.Button").onRollOver = function() {
	VisibleSubBrowse();
	SelectButton("MenuBrowse.Alphabet.Movie");
	SelectLevel = 5;
	MenuLevel = 1;
};
eval("MenuBrowse.Genre.Button").onRelease = function(fromServer) {
	SuiteAction.StoredProcedure = undefined;
	//if (fromServer != "true") {
		if (send_event("normal&&&function||MenuBrowse.Genre.Button.onRelease"+"|~|true||0", false)) {
			return;
		}
	//}
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	Menu._visible = false;
	fscommand("BrowseAlbumBy", "Genre");
	tipPos(false);
};
eval("MenuBrowse.Production.Button").onRelease = function() {
	SuiteAction.StoredProcedure = undefined;
	if (fromServer != "true") {
		if (send_event("normal&&&function||MenuBrowse.Production.Button.onRelease"+"|~|true||0", false)) {
			return;
		}
	}
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	Menu._visible = false;
	fscommand("BrowseAlbumBy", "Production");
	tipPos(false);
};
eval("MenuBrowse.Rating.Button").onRelease = function() {
	SuiteAction.StoredProcedure = undefined;
	if (fromServer != "true") {
		if (send_event("normal&&&function||MenuBrowse.Rating.Button.onRelease"+"|~|true||0", false)) {
			return;
		}
	}
	//Send2Server("client", "0&&&Click||"+this, true);
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	Menu._visible = false;
	fscommand("BrowseAlbumBy", "Rating");
	//DisibleClick("");
	tipPos(false);
};
eval("MenuBrowse.Alphabet.Button").onRelease = function() {
	SuiteAction.StoredProcedure = undefined;
	if (fromServer != "true") {
		if (send_event("normal&&&function||MenuBrowse.Alphabet.Button.onRelease"+"|~|true||0", false)) {
			return;
		}
	}
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	Menu._visible = false;
	//mainLetter_mc._visible=true;
	fscommand("BrowseAlbumBy", "Alphabet");
	tipPos(false);
	/*if (ChangeLan == "Uni"){
		mainLetter_mc.readXmlLetter(GetPath + "\\alphabetUnicode.xml");
	} else {
		mainLetter_mc.readXmlLetter(GetPath + "\\alphabet.xml");
	}*/
};
eval("MenuBrowse.ReleaseDate.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuSortedReleaseDate._visible = true;
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuBrowse.ReleaseDate.Movie");
};
eval("MenuBrowse.ReleaseDate.Button").onRelease = function() {
	SuiteAction.StoredProcedure = undefined;
	if (fromServer != "true") {
		if (send_event("normal&&&function||MenuBrowse.ReleaseDate.Button.onRelease"+"|~|true||0", false)) {
			return;
		}
	}
	//	Send2Server("client", "0&&&Click||"+this, true);
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	Menu._visible = false;
	fscommand("BrowseAlbumBy", "ReleaseDate");
	//DisibleClick("");
	tipPos(false);
};
eval("MenuBrowse.FavAlbum.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuFavAlbum._visible = true;
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuBrowse.FavAlbum.Movie");
};
eval("MenuBrowse.FavAlbum.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubBrowse();
	Menu._visible = false;
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubMenu();
	fscommand("DisplayAlbum", "MyFavAlbum");
	//DisibleClick("MyFavAlbum");
	tipPos(false);
};
eval("MenuBrowse.MyAlbum.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuMyAlbum._visible = true;
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuBrowse.MyAlbum.Movie");
};
eval("MenuBrowse.MyAlbum.Button").onRelease = function() {
	
	if (send_event("normal&&&Click||"+this+"||0", false)) {
		return;
	}

	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player	
	VisibleSubBrowse();
	Menu._visible = false;
	VisibleSubMenu();
	fscommand("DisplayAlbum", "MyAlbum");
	tipPos(false);
};
//..................
eval("MenuFavAlbum.Genre.Button").onRollOver = function() {
	SelectButton("MenuFavAlbum.Genre.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavAlbum.Production.Button").onRollOver = function() {
	SelectButton("MenuFavAlbum.Production.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavAlbum.Rating.Button").onRollOver = function() {
	SelectButton("MenuFavAlbum.Rating.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavAlbum.Rank.Button").onRollOver = function() {
	SelectButton("MenuFavAlbum.Rank.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavAlbum.Genre.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();			//EDIT:2006-08-10 Seng Hiding player
	MyFavAlbum = "MyFavorite";
	DisplayAlbum = "MyFavAlbum";
	fscommand("GetMyFavAlbum", "MyFavorite");
	Invisible();
	SelectColorMenuFavAlbum("MenuFavAlbum.Genre.Text");
	SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
};
eval("MenuFavAlbum.Production.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyFavAlbum = "ReleaseDate";
	DisplayAlbum = "MyFavAlbum";
	fscommand("GetMyFavAlbum", "ReleaseDate");
	Invisible();
	SelectColorMenuFavAlbum("MenuFavAlbum.Production.Text");
	SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
};
eval("MenuFavAlbum.Rating.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyFavAlbum = "Rating";
	DisplayAlbum = "MyFavAlbum";
	fscommand("GetMyFavAlbum", "Rating");
	Invisible();
	SelectColorMenuFavAlbum("MenuFavAlbum.Rating.Text");
	SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
};
eval("MenuFavAlbum.Rank.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyFavAlbum = "Rank";
	DisplayAlbum = "MyFavAlbum";
	fscommand("GetMyFavAlbum", "Rank");
	Invisible();
	SelectColorMenuFavAlbum("MenuFavAlbum.Rank.Text");
	SelectColorMenuBrowse("MenuBrowse.FavAlbum.Text");
};
//................MyAlbum..............
eval("MenuMyAlbum.Genre.Button").onRollOver = function() {
	SelectButton("MenuMyAlbum.Genre.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuMyAlbum.Production.Button").onRollOver = function() {
	SelectButton("MenuMyAlbum.Production.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuMyAlbum.Rating.Button").onRollOver = function() {
	SelectButton("MenuMyAlbum.Rating.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuMyAlbum.Rank.Button").onRollOver = function() {
	SelectButton("MenuMyAlbum.Rank.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuMyAlbum.Genre.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyAlbum = "MyFavorite";
	DisplayAlbum = "MyAlbum";
	fscommand("GetMyAlbum", "MyFavorite");
	Invisible();
	SelectColorMenuMyAlbum("MenuMyAlbum.Genre.Text");
	SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
};
eval("MenuMyAlbum.Production.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyAlbum = "ReleaseDate";
	DisplayAlbum = "MyAlbum";
	fscommand("GetMyAlbum", "ReleaseDate");
	Invisible();
	SelectColorMenuMyAlbum("MenuMyAlbum.Production.Text");
	SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
};
eval("MenuMyAlbum.Rating.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyAlbum = "Rating";
	DisplayAlbum = "MyAlbum";
	fscommand("GetMyAlbum", "Rating");
	Invisible();
	SelectColorMenuMyAlbum("MenuMyAlbum.Rating.Text");
	SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
};
eval("MenuMyAlbum.Rank.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	hidePlayer();
	MyAlbum = "Rank";
	DisplayAlbum = "MyAlbum";
	fscommand("GetMyAlbum", "Rank");
	Invisible();
	SelectColorMenuMyAlbum("MenuMyAlbum.Rank.Text");
	SelectColorMenuBrowse("MenuBrowse.MyAlbum.Text");
};
//...............MyFavorite Artist...................
eval("MenuBrowse.FavArtist.Button").onRollOver = function() {
	VisibleSubBrowse();
	MenuFavArtist._visible = true;
	SelectLevel = 5;
	MenuLevel = 1;
	SelectButton("MenuBrowse.FavArtist.Movie");
};
eval("MenuBrowse.FavArtist.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	hideplayer();
	VisibleSubMenu();
	Menu._visible = false;
	VisibleSubBrowse();
	fscommand("DisplayAlbum", "MyFavArtist");
	//DisibleClick("MyFavArtist");
};
eval("MenuFavArtist.Genre.Button").onRollOver = function() {
	SelectButton("MenuFavArtist.Genre.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavArtist.Production.Button").onRollOver = function() {
	SelectButton("MenuFavArtist.Production.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavArtist.Rating.Button").onRollOver = function() {
	SelectButton("MenuFavArtist.Rating.Movie");
	SelectLevel = 5;
	MenuLevel = 2;
};
eval("MenuFavArtist.Genre.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	Invisible();
	hidePlayer();
	MyFavArtist = "MyFavorite";
	DisplayAlbum = "MyFavArtist";
	//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
	if(databaseType==1 or databaseType==2){
		//Movie and TVSeries
		fscommand("GetTVSeries",MyFavArtist);
	}else{
		//Music and Karaoke
		fscommand("GetMyFavArtist", MyFavArtist);
	}
	
	SelectColorMenuFavArtist("MenuFavArtist.Genre.Text");
	SelectColorMenuBrowse("MenuBrowse.FavArtist.Text");
};
eval("MenuFavArtist.Production.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	Invisible();
	hidePlayer();
	MyFavArtist = "ReleaseDate";
	DisplayAlbum = "MyFavArtist";
	
	if(databaseType==1 or databaseType==2){
		//Movie and TVSeries
		fscommand("GetTVSeries","ReleaseDate");
	}else{
		//Music and Karaoke
		fscommand("GetMyFavArtist", "ReleaseDate");
	}
	
	SelectColorMenuFavArtist("MenuFavArtist.Production.Text");
	SelectColorMenuBrowse("MenuBrowse.FavArtist.Text");
};
eval("MenuFavArtist.Rating.Button").onRelease = function() {
	Send2Server("client", "0&&&Click||"+this, true);
	VisibleSubMenu();
	Menu._visible = false;
	Invisible();
	hidePlayer();
	MyFavArtist = "Rank";
	DisplayAlbum = "MyFavArtist";
	if(databaseType==1 or databaseType==2){
		//Movie and TVSeries
		fscommand("GetTVSeries","Rank");
	}else{
		//Music and Karaoke
		fscommand("GetMyFavArtist", "Rank");
	}
	
	SelectColorMenuFavArtist("MenuFavArtist.Rating.Text");
	SelectColorMenuBrowse("MenuBrowse.FavArtist.Text");
};
ButtonTip.onRollOver = function() {
	TextTip._visible = false;
	this._visible = false;
};
function DisibleClick(Obj) {
	MenuFavAlbum.Genre.Button.enabled = false;
	MenuFavAlbum.Production.Button.enabled = false;
	MenuFavAlbum.Rating.Button.enabled = false;
	MenuFavAlbum.Rank.Button.enabled = false;
	MenuMyAlbum.Genre.Button.enabled = false;
	MenuMyAlbum.Production.Button.enabled = false;
	MenuMyAlbum.Rating.Button.enabled = false;
	MenuMyAlbum.Rank.Button.enabled = false;
	MenuFavArtist.Genre.Button.enabled = false;
	MenuFavArtist.Production.Button.enabled = false;
	MenuFavArtist.Rating.Button.enabled = false;
	MenuSorted1.NameSorted.Button.enabled = false;
	MenuSorted1.DateSorted.Button.enabled = false;
	MenuSorted.NameSorted.Button.enabled = false;
	MenuSorted.DateSorted.Button.enabled = false;
	if (Obj == "MyFavArtist") {
		MenuFavArtist.Genre.Button.enabled = true;
		MenuFavArtist.Production.Button.enabled = true;
		MenuFavArtist.Rating.Button.enabled = true;
	} else if (Obj == "MyFavAlbum") {
		MenuFavAlbum.Genre.Button.enabled = true;
		MenuFavAlbum.Production.Button.enabled = true;
		MenuFavAlbum.Rating.Button.enabled = true;
		MenuFavAlbum.Rank.Button.enabled = true;
	} else if (Obj == "MyAlbum") {
		MenuMyAlbum.Genre.Button.enabled = true;
		MenuMyAlbum.Production.Button.enabled = true;
		MenuMyAlbum.Rating.Button.enabled = true;
		MenuMyAlbum.Rank.Button.enabled = true;
	} else if (Obj == "Production") {
		MenuSorted1.NameSorted.Button.enabled = true;
		MenuSorted1.DateSorted.Button.enabled = true;
	} else if (Obj == "Genre") {
		MenuSorted.NameSorted.Button.enabled = true;
		MenuSorted.DateSorted.Button.enabled = true;
	}
}
// on Rollout
//HideTooltip("txtTooltip")
TopBar.ButtonB.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonM.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonRip.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonScan.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonPlayer.onRollOut = function() {
	HideTooltip("txtTooltip");
};
TopBar.ButtonFull.onRollOut = function() {
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
function click_back_menu(val_OpenSortMaster, val_DisplayAlbum, val_MainLevel, val_BrowseBy, val_BackAlbumInfo) {
	if (send_event("normal&&&function||click_back_menu|~|"+val_OpenSortMaster+"|~|"+val_DisplayAlbum+"|~|"+val_MainLevel+"|~|"+val_BrowseBy+"|~|"+val_BackAlbumInfo+"||0", false)) {
		return;
	}
	OpenSortMaster = val_OpenSortMaster;
	DisplayAlbum = val_DisplayAlbum;
	MainLevel = val_MainLevel;
	BrowseBy = val_BrowseBy;
	BackAlbumInfo._visible = Boolean(val_BackAlbumInfo);
	display_back_click();
}
function display_back_click() {	
	mini._visible = false;
	VisibleSubMenu();
	Menu._visible = false;
	if (OpenSortMaster == "true") {
		//FirstDisplayGenre(resultSearchGenre.length);
		OpenSortMaster = "false";
		SortMaster._visible = false;
		SortMaster.BackAlbumPic.Pic0.unloadMovie();
		SortMaster.BackAlbumPic.Picfade0.unloadMovie();
		if (BrowseBy == "ReleaseDate" or BrowseBy == "Production") {
			if (resultSearchArtistAlbum.length>0) {
				VolBar._visible = true;
				eval(NameAlbum)._visible = true;
			}
		} else {
			BackLetter._visible = true;
		}
	} else {
		if (DisplayAlbum == "Browse") {
			if (MainLevel == 4) {
				if (BackAlbumInfo._visible) {
					BackAlbumInfo._visible = false;
					showPlayer();
					eval(TrackName)._visible = true;
				} else {
					AlbumBar._visible = false;
					for (var j = 0; j<nAlbum; j++) {
						eval("AlbumBar.Pic"+j).unloadMovie();
						eval("AlbumBar.PicFade"+j).unloadMovie();
					}
					eval(TrackName)._visible = false;
					unloadTrackPage();
					BackAlbumPic._visible = false;
					//BackAlbumPic.Pic0.unloadMovie();
					//BackAlbumPic.PicFade0.unloadMovie();
					VisiblePlay(false);
					eval(NameAlbum)._visible = true;
					VolBar._visible = true;
					MainLevel = 3;
					hidePlayer();
				}
			} else if (MainLevel == 3) {
				ArtistNameBar._visible = false;
				VolBar._visible = false;
				if (BrowseBy == "Genre") {
					CharBar._visible = false;
					ArrowBar._visible = false;
					eval(NameAlbum)._visible = false;
					for (var j = 0; j<NumMovie; j++) {
						eval(NameAlbum+".Pic"+j).unloadMovie();
						eval(NameAlbum+".PicFade"+j).unloadMovie();
					}
					BackLetter._visible = true;
					MainLevel = 1;
				} else if (BrowseBy == "Production"){//EDID.2006.05.15 Seng Remove Backletter from Browse by production
					fscommand("ShowCountry");
					Invisible();
				} else if (BrowseBy == "Artist" || BrowseBy == "Rating") {
					for (var j = 0; j<NumMovie; j++) {
						eval(NameAlbum+".Pic"+j).unloadMovie();
						eval(NameAlbum+".PicFade"+j).unloadMovie();
					}
					MainLevel = 1;
					eval(NameAlbum)._visible = false;
					CharBar._visible = false;
					BackLetter._visible = true;
				} else if (BrowseBy == "ReleaseDate") {
					fscommand("ShowCountry");
					Invisible();
				}
			} else if (MainLevel == 2) {
				CharBar._visible = false;
				ArrowBar._visible = false;
				eval(NameAlbum)._visible = false;
				for (var j = 0; j<NumMovie; j++) {
					eval(NameAlbum+".Pic"+j).unloadMovie();
					eval(NameAlbum+".PicFade"+j).unloadMovie();
				}
				BackLetter._visible = true;
				MainLevel = 1;
			} else if (MainLevel == 1) {
				fscommand("ShowCountry");
				Invisible();
			}
		} else if (DisplayAlbum == "MyFavAlbum") {
			if (MainLevel == 4) {
				if (BackAlbumInfo._visible) {
					BackAlbumInfo._visible = false;
					showPlayer();
					eval(TrackName)._visible = true;
				} else {
					AlbumBar._visible = false;
					for (var j = 0; j<nAlbum; j++) {
						eval("AlbumBar.Pic"+j).unloadMovie();
						eval("AlbumBar.PicFade"+j).unloadMovie();
					}
					eval(TrackName)._visible = false;
					BackAlbumPic._visible = false;
					BackAlbumPic.Pic0.unloadMovie();
					BackAlbumPic.PicFade0.unloadMovie();
					VisiblePlay(false);
					eval(NameAlbum)._visible = true;
					VolBar._visible = true;
					MainLevel = 3;
					hidePlayer();
				}
			} else if (MainLevel == 3) {
				fscommand("ShowCountry");
				Invisible();
			}
		} else if (DisplayAlbum == "MyFavArtist") {
			if (MainLevel == 4) {
				if (BackAlbumInfo._visible) {
					BackAlbumInfo._visible = false;
					showPlayer();
					eval(TrackName)._visible = true;
				} else {
					AlbumBar._visible = false;
					for (var j = 0; j<nAlbum; j++) {
						eval("AlbumBar.Pic"+j).unloadMovie();
						eval("AlbumBar.PicFade"+j).unloadMovie();
					}
					eval(TrackName)._visible = false;
					BackAlbumPic._visible = false;
					BackAlbumPic.Pic0.unloadMovie();
					BackAlbumPic.PicFade0.unloadMovie();
					VisiblePlay(false);
					eval(NameAlbum)._visible = true;
					VolBar._visible = true;
					MainLevel = 3;
					hidePlayer();
				}
			} else if (MainLevel == 3) {
				ArtistNameBar._visible = false;
				VolBar._visible = false;
				MainLevel = 2;
				ShowMovieArtist(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
				//ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultSearchArtistName);
				//if(NumArrow>NumMovie){
				ArrowBar._visible = true;
				//}
			} else if (MainLevel == 2) {
				fscommand("ShowCountry");
				Invisible();
			}
		} else if (DisplayAlbum == "MyAlbum") {
			if (MainLevel == 4) {
				if (BackAlbumInfo._visible) {
					BackAlbumInfo._visible = false;
					showPlayer();
					eval(TrackName)._visible = true;
				} else {
					AlbumBar._visible = false;
					for (var j = 0; j<nAlbum; j++) {
						eval("AlbumBar.Pic"+j).unloadMovie();
						eval("AlbumBar.PicFade"+j).unloadMovie();
					}
					eval(TrackName)._visible = false;
					BackAlbumPic._visible = false;
					BackAlbumPic.Pic0.unloadMovie();
					BackAlbumPic.PicFade0.unloadMovie();
					VisiblePlay(false);
					eval(NameAlbum)._visible = true;
					VolBar._visible = true;
					MainLevel = 3;
					hidePlayer();
				}
			} else if (MainLevel == 3) {
				fscommand("ShowCountry");
				Invisible();
			}
		} else {
			fscommand("ShowCountry");
			Invisible();
		}
		fscommand("ValuePlayer", MainLevel);
	}
}
function unloadTrackPage(){
//	BackAlbumPic.unloadFadeImage();
//	BackAlbumPic.loadFadeImage(PicName[0]);
	for(var i=0;i<nTrack;i++){
		objPic		=	eval(TrackName+".Pic"+i);
		objPic.unloadFadeImage();
	}
}