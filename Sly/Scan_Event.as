selectaleObj=[["topBar.MovieB","topBar.MovieX"],["SelectLanguage.Movie","scan.Movie"],["Path.MovieHis","Path.BrowseFolder.Movie","Path.DeleteFolder.Movie"],["scanBy.optFileName.Movie"],["scanBy.optFileHint.Movie","Exit.chkExit.Movie"]];
selectMinAndExit=[["Menu.Player.Movie"],["Menu.Exit.Movie"]];
selectMenuMinAndExit=[["topbar.MovieX"],["Menu.Player.Movie"],["Menu.Exit.Movie"]];
_root.onEnterFrame = function() {
	if (Key.isDown(Key.ESCAPE)) {
		if (!scanProcess._visible) {
			if (Menu._visible == true) {
				topBar.ButtonX.onRollOver();
				Menu._visible = false;
			} else if (SelectLanguage.SelectLan._visible == true) {
				SelectLanguage.Button.onRollOver();
				SelectLanguage.SelectLan._visible = false;
			} else if (Path.historyFolders._visible == true) {
				Path.historyFolders._visible = false;
				Path.ButtonHis.onRollOver();
			} else {
				topBar.ButtonB.onRelease();
			}
		}
	}
	if (openframe == "true") {
		delete (openframe);
		if (getThemes == "true") {
			delete (getThemes);
			strspl = new Array();
			strspl = String(get_val_Theme).split("~");
			var HideMouse = strspl[27];
			button_color = strspl[6];
			button_alpha = strspl[7];
			button_color_selected = strspl[8];
			button_alpha_selected = strspl[9];
			background_color = strspl[0];
			font_color = strspl[10];
			font_name = "Arial";
			f = new TextFormat();
			f.color = font_color;
			f.font = font_name;
			d = new Color(bg);
			d.setRGB(background_color);
			if (HideMouse == "true") {
				Mouse.hide();
			} else {
				Mouse.show();
			}
			TrackShow.setTrackDisplayTheme(font_color, strspl[23]);
			ChangeColorAlpha("SelectLanguage.SelectLan.bg", strspl[23], 100);
			ChangeColorAlpha("Path.historyFolders.bg", strspl[23], 100);
			ChangeColorAlpha("topBar.Bar", strspl[23], 100);
			ChangeColorAlpha("Menu.Bar", strspl[23], 100);
			ChangeColorAlpha("Menu.Player.bg", strspl[23], 100);
			ChangeColorAlpha("Menu.Exit.bg", strspl[23], 100);
			ChangeColorAlpha("topBar.MovieB", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieM", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieS", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieP", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieC", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieL", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieO", button_color, button_alpha);
			ChangeColorAlpha("topBar.MovieX", button_color, button_alpha);
			ChangeColorAlpha("correctFile.volumebar.Movie", button_color, button_alpha);
			ChangeColorAlpha("correctFile.seekbar.MovieSeek", button_color, button_alpha);
			ChangeColorAlpha("itemMatch.volumebar.Movie", button_color, button_alpha);
			ChangeColorAlpha("itemMatch.seekbar.MovieSeek", button_color, button_alpha);
			ChangeColorNoAlpha("topBar.lbl", button_color_selected);
			var fmenu = new TextFormat();
			fmenu.font = font_name;
			fmenu.size = 30;
			ChangeColorAlpha("Menu.Player.Movie", button_color, button_alpha);
			Menu.Player.Text.text = "Minimize";
			Menu.Player.Text.textColor = font_color;
			Menu.Player.Text.setTextFormat(fmenu);
			ChangeColorAlpha("Menu.Exit.Movie", button_color, button_alpha);
			Menu.Exit.Text.text = "Exit";
			Menu.Exit.Text.textColor = font_color;
			Menu.Exit.Text.setTextFormat(fmenu);
			//Path.txt.setTextFormat(f)
			ChangeColorAlpha("Path.BrowseFolder.Movie", button_color, button_alpha);
			ChangeColorAlpha("Path.DeleteFolder.Movie", button_color, button_alpha);
			for (var i = 0; i<5; i++) {
				eval("Folders.Text"+i).setTextFormat(f);
				ChangeColorAlpha("Path.historyFolders.Movie"+i, button_color, button_alpha);
			}
			ChangeColorAlpha("Path.historyFolders.MovieUp", button_color, button_alpha);
			ChangeColorAlpha("Path.historyFolders.MovieDown", button_color, button_alpha);
			ChangeColorAlpha("Path.MovieHis", button_color, button_alpha);
			//SelectLanguage.txtDisplay.setTextFormat(f)
			ChangeColorAlpha("SelectLanguage.Movie", button_color, button_alpha);
			ChangeColorAlpha("SelectLanguage.SelectLan.MovieUp", button_color, button_alpha);
			ChangeColorAlpha("SelectLanguage.SelectLan.MovieDown", button_color, button_alpha);
			for (i=0; i<4; i++) {
				eval("SelectLanguage.SelectLan.Text"+i).setTextFormat(f);
				ChangeColorAlpha("SelectLanguage.SelectLan.Movie"+i, button_color, button_alpha);
			}
			ChangeColorAlpha("scanBy.optFileName.Movie", button_color, button_alpha);
			ChangeColorAlpha("scanBy.optFileHint.Movie", button_color, button_alpha);
			scanBy.lblFileName.setTextFormat(f);
			scanBy.lblFileHint.setTextFormat(f);
			ChangeColorAlpha("scanBy.optTime.Movie", button_color, button_alpha);
			scanBy.lblTime.setTextFormat(f);
			ChangeColorAlpha("scan.Movie", button_color, button_alpha);
			ChangeColorAlpha("Option.File.optFileName.Movie", button_color, button_alpha);
			Option.File.lblFileName.setTextFormat(f);
			ChangeColorAlpha("Option.File.optID.Movie", button_color, button_alpha);
			Option.File.lblID.setTextFormat(f);
			ChangeColorAlpha("Option.TimeFile.optFileName.Movie", button_color, button_alpha);
			Option.TimeFile.lblFileName.setTextFormat(f);
			ChangeColorAlpha("Option.TimeFile.optID.Movie", button_color, button_alpha);
			Option.TimeFile.lblID.setTextFormat(f);
			/// Folder				
			/*	for (var i=0;i<4;i++){
														eval("Folders.Text"+i).setTextFormat(f);
														ChangeColorAlpha("Folders.MoviePath"+i, button_color, button_alpha);
													}
													ChangeColorAlpha("Folders.ButtonBar", button_color, 100);
													ChangeColorAlpha("Folders.MovieFolder", button_color, button_alpha);
													ChangeColorAlpha("Folders.MovieDelete", button_color, button_alpha);
													ChangeColorAlpha("Folders.MovieClose", button_color, button_alpha);
													ChangeColorAlpha("Folders.MovieUp", button_color, button_alpha);
													ChangeColorAlpha("Folders.MovieDown", button_color, button_alpha);
													ChangeColorAlpha("Folders.MovieSel", button_color_selected, button_alpha_selected);
												*/
			///
			ChangeColorAlpha("Option.Time.chkArtist.Movie", button_color, button_alpha);
			Option.Time.lblArtist.setTextFormat(f);
			ChangeColorAlpha("Option.Time.chkTitle.Movie", button_color, button_alpha);
			Option.Time.lblTitle.setTextFormat(f);
			Option.Time.txtProduct.setTextFormat(f);
			Option.Time.txtAlbum.setTextFormat(f);
			ChangeColorAlpha("Option.After.chkRename.Movie", button_color, button_alpha);
			Option.After.lblRename.setTextFormat(f);
			ChangeColorAlpha("Option.After.chkProduct.Movie", button_color, button_alpha);
			Option.After.lblProduct.setTextFormat(f);
			ChangeColorAlpha("Option.After.chkAlbum.Movie", button_color, button_alpha);
			Option.After.lblAlbum.setTextFormat(f);
			ChangeColorAlpha("Option.After.chkTrack.Movie", button_color, button_alpha);
			Option.After.lblTrack.setTextFormat(f);
			ChangeColorAlpha("Option.After.chkEdit.Movie", button_color, button_alpha);
			Option.After.lblEdit.setTextFormat(f);
			ChangeColorAlpha("Exit.chkExit.Movie", button_color, button_alpha);
			Exit.lbl.setTextFormat(f);
			ChangeColorAlpha("itemMatch.OK.Movie", button_color, button_alpha);
			ChangeColorAlpha("itemMatch.cancel.Movie", button_color, button_alpha);
			ChangeColorAlpha("itemMatch.item.MovieUp", button_color, button_alpha);
			ChangeColorAlpha("itemMatch.item.MovieDown", button_color, button_alpha);
			for (i=0; i<12; i++) {
				ChangeColorAlpha("itemMatch.item.Movie"+i, button_color, button_alpha);
			}
			ChangeColorAlpha("correctFile.OK.Movie", button_color, button_alpha);
			ChangeColorAlpha("correctFile.cancel.Movie", button_color, button_alpha);
			ChangeColorAlpha("correctFile.item.MovieUp", button_color, button_alpha);
			ChangeColorAlpha("correctFile.item.MovieDown", button_color, button_alpha);
			for (i=0; i<12; i++) {
				ChangeColorAlpha("correctFile.item.Movie"+i, button_color, button_alpha);
			}
			oldPath = "";
			//oldScanby = "File";

			oldScanby = 2;
			fscommand("ScanBy", oldScanby);

			oldFile = "ID";
			oldArtist = "0";
			oldProduct = "0";
			oldTitle = "0";
			oldAlbum = "0";
			oldReName = "0";
			oldEdit = "0";
			oldAddProduct = "0";
			oldAddAlbum = "0";
			oldAddTrack = "0";
			//			Path.txt.text=oldPath
			//			Path.txt.setTextFormat(f)
			//			fscommand("Path",oldPath)
			//enableFile(oldFile);
			Option.Time.chkArtist.check._visible = Boolean(oldArtist);
			Option.Time.txtProduct.text = oldProduct;
			Option.Time.chkTitle.check._visible = Boolean(oldTitle);
			Option.Time.txtAlbum.text = oldAlbum;
			Option.After.chkRename.check._visible = Boolean(oldRename);
			Option.After.chkProduct.check._visible = Boolean(oldAddProduct);
			Option.After.chkAlbum.check._visible = Boolean(oldAddAlbum);
			Option.After.chkTrack.check._visible = Boolean(oldAddTrack);
			Option.After.chkEdit.check._visible = Boolean(oldEdit);
			if (strspl[25] == "true") {
				Exit.chkExit.check._visible = true;
			} else {
				Exit.chkExit.check._visible = false;
			}
			enabledCheckBox(Boolean(oldRename));
//enableScanby

			//optGroupEnabled (optScanList,eval("scanBy.optFileName"));

			enableScanby(oldScanby);
			bg._visible = true;
			topBar._visible = true;
			Path._visible = true;
			SelectLanguage._visible = true;
			scanBy._visible = true;
			scan._visible = true;
			//Option._visible = true;
			Exit._visible = true;
			topBar.ButtonB.onRollOver();
			changeColorCheck();
		}
		//----
		if (sendappPath == "true") {
			delete (sendappPath);
			appPath = strappPath;
			delete (strappPath);
		}
		//----
		if (sendCountry == "true") {
			delete (sendCountry);
			var lp = new Array();
			var l = new Array();
			var p = new Array();
			lp = String(strCountry).split("\\\\//");
			l = String(lp[0]).split(sp);
			p = String(lp[1]).split(";");
			for (i=0; i<l.length; i++) {
				arrLan[i] = new setLanguages(l[i], p[i], false);
			}
			iLanguageIndex=0;
			for(i=0;i<arrLan.length;i++){
				if (arrLan[i].Name==LanName){
					iLanguageIndex=i;
					break;
				}
			}
			tmpLanLocation = arrLan[iLanguageIndex].Path;
			defaultScanPath(arrLan[iLanguageIndex].Path);
			fscommand("Language", arrLan[iLanguageIndex].Name);
			SelectLanguage.txtDisplay.text = arrLan[iLanguageIndex].Name;
			FirstDisplayLanguageItem(arrLan.length);
			delete (lp);
			delete (l);
			delete (p);
			delete (strCountry);
		}
		//----
		if (strSHTT != undefined) {
			if (strSHTT == "True") {
				SHTT = "true";
			} else {
				SHTT = "false";
			}
			delete (strSHTT);
		}
		//----
		if (sendPath == "true") {
			delete (sendPath);
			delete (strPath);
			defaultScanPath(tmpLanLocation);
			//sendPath = "false";
			//Path.txt.text = strPath;
		}
		//----
		if (sendScanning == "true") {
			sendScanning = "false";
			scanProcess._visible = true;
			bgenabled._visible = true;
			Scanning(int(strScanning));
		}
		//----
		if (sendClose == "true") {
			sendClose = "false";
			scanProcess._visible = false;
			bgenabled._visible = false;
		}
		//----
		if (sendlblTitle == "true") {
			sendlblTitle = "false";
			scanProcess.txtTitle.text = strlblTitle;
			scanProcess.txtTitle.autoSize = true;
		}
		//----
		if (sendItem == "true") {
			sendItem = "false";
			itemMatch._visible = true;
			//strItem="A^^b^^c^^g^^d^^A^^b^^c^^g^^d^^A^^b^^c^^g^^d"
			VolumeSet("itemMatch.volumebar", 136/2);
			arrItem = String(strItem).split(sp);
			FirstDisplayItemMatch(arrItem.length);
		}
		//----
		if (sendCorrectPath == "true") {
			sendCorrectPath = "false";
			correctFile.txtTitle.text = strTitle;
			scanProcess.txtTitle.autoSize = true;
			correctFile._visible = true;
			VolumeSet("correctFile.volumebar", 136/2);
			arrCorrectPath = String(strCorrectPath).split(sp);
			FirstDisplayPath(arrCorrectPath.length);
		}
	}
};
//////////////
/// onRelease
//////////////
topBar.ButtonB.onRelease = function() {
	fscommand("Back", "true");
};
/*
topBar.ButtonS.onRelease=function(){
	fscommand("Search",true)
}
topBar.ButtonP.onRelease=function(){
	fscommand("Playlist",true)
}
topBar.ButtonC.onRelease=function(){
	fscommand("Country",true)
}
topBar.ButtonO.onRelease=function(){
	fscommand("Setting",true)
}*/
topBar.ButtonX.onRelease = function() {
	Menu._visible = (Menu._visible) ? false : true;
	if (Menu._visible == true) {
		Menu.Player.Button.onRollOver();
	} else {
		topBar.ButtonX.onRollOver();
	}
};
Menu.Player.Button.onRelease = function() {
	Menu._visible = false;
	fscommand("Minimize", true);
};
Menu.Exit.Button.onRelease = function() {
	Menu._visible = false;
	fscommand("Exit", true);
};
Path.BrowseFolder.Button.onRelease = function() {
	if (Path.historyFolders._visible == true) {
		Path.historyFolders._visible = false;
	}
	fscommand("Browse", Path.txt.text+"||"+tmpLanLocation);
};
Path.DeleteFolder.Button.onRelease = function() {
	if (historyPath.length != 0) {
		if (Path.historyFolders._visible == true) {
			Path.historyFolders._visible = false;
		}
		fscommand("removeHistoryPath", tmpLanLocation);
	}
	//	FirstDisplayHistoryItem(historyPath.length)
	//	Folders._visible = true;
	//	enbFolders._visible = true;
};
Path.ButtonHis.onRelease = function() {
	if (historyPath.length != 0) {
		if (Path.historyFolders._visible == false) {
			defaultScanPath(tmpLanLocation);
			Path.historyFolders._visible = true;
			Path.historyFolders.Button0.onRollOver();
		} else {
			Path.historyFolders._visible = false;
		}
	}
};
for (var i = 0; i<5; i++) {
	eval("Path.historyFolders.Button"+i).onRelease = function() {
		ii = String(this._name).substr(6);
		Path.txt.text = historyPath[int(eval("Path.historyFolders.ind"+ii).text)];
		Path.historyFolders._visible = false;
		if (ii != 0) {
			arrLan[val_select].Scan = false;
			scan.Button.enabled = true;
			fscommand("SelectFolder", (int(eval("Path.historyFolders.ind"+ii).text)-1)+"%%"+historyPath[int(eval("Path.historyFolders.ind"+ii).text)]+"%%"+historyPath[0]+"%%"+tmpLanLocation);
		}
		Path.ButtonHis.onRollOver();
	};
}
Path.historyFolders.ButtonUp.onRelease = function() {
	ClickHistoryUp();
};
Path.historyFolders.ButtonDown.onRelease = function() {
	ClickHistoryDown();
};
//----------------------
SelectLanguage.Button.onRelease = function() {
	SelectLanguage.SelectLan._visible = (SelectLanguage.SelectLan._visible) ? false : true;
	if (SelectLanguage.SelectLan._visible == true) {
		SelectLanguage.SelectLan.Button0.onRollOver();
	} else {
		SelectLanguage.Button.onRollOver();
	}
};
SelectLanguage.SelectLan.ButtonUp.onRelease = function() {
	ClickLanUp();
};
SelectLanguage.SelectLan.ButtonDown.onRelease = function() {
	ClickLanDown();
};
for (i=0; i<4; i++) {
	eval("SelectLanguage.SelectLan.Button"+i).onRelease = function() {
		SelectLanguage.SelectLan._visible = false;
		ii = String(this._name).substr(6);
		var LanguageID = eval("SelectLanguage.SelectLan.Text"+ii).text;
		for(var i=0;i<arrLan.length;i++){
			if(arrLan[i].Name==LanguageID){
				val_select=i;
				SelectLanguage.txtDisplay.text =LanguageID;
				Path.historyFolders._visible=false;
				tmpLanLocation = arrLan[i].Path;
				defaultScanPath(arrLan[i].Path);
				SelectLanguage.Button.onRollOver();
				fscommand("Language", LanguageID);
				break;
			}
		}
//		ii = eval("SelectLanguage.SelectLan.ind"+ii).text;
//		tmpLanLocation = arrLan[ii].Path;
//		defaultScanPath(arrLan[ii].Path);
/*
		if (val_select != ii) {
			arrLan[val_select].Scan = false;
			val_select = ii;
			scan.Button.enabled = true;
		}
*/		
	};
}
scan.Button.onRelease = function() {
//	if (arrLan[val_select].Scan == false) {
//		scan.Button.enabled = false;
		arrLan[val_select].Scan = true;
		fscommand("Start", Path.txt.text);
//	}
};

scanBy.optFileName.Button.onRelease = function() {
	optGroupEnabled(optScanList,this._parent)
	fscommand("ScanBy", 0);
	scanBy.optFileName.Button.onRollOver();
};
scanBy.optFileHint.Button.onRelease = function() {
	optGroupEnabled(optScanList,this._parent)
	fscommand("ScanBy", 2);
	//enableScanby("Hint");
	scanBy.optFileHint.Button.onRollOver();
};
/*scanBy.optTime.Button.onRelease = function() {
	enableScanby("Time");
	scanBy.optFileName.Button.onRollOver();
};
*/
/*scanBy.drop.Button.onRelease = function(){
	scanBy.list._visible = not(scanBy.list._visible);
};
for (var init=0; init<3; init++){
	eval("scanBy.list.Button" + init + ".Button").onRelease = function(){
		fscommand("scanType",substring(this._parent._name,6));
	}
};*/
Option.File.optFileName.Button.onRelease = function() {
	enableFile("File");
	Option.File.optID.Button.onRollOver();
};
Option.File.optID.Button.onRelease = function() {
	enableFile("ID");
	Option.File.optFileName.Button.onRollOver();
};
Option.TimeFile.optFileName.Button.onRelease = function() {
	enableOptionScaneByTimeTrackNumber("File");
	Option.TimeFile.optID.Button.onRollOver();
};
Option.TimeFile.optID.Button.onRelease = function() {
	enableOptionScaneByTimeTrackNumber("ID");
	Option.TimeFile.optFileName.Button.onRollOver();
};
Option.Time.chkArtist.Button.onRelease = function() {
	if (Option.Time.chkArtist.check._visible == true) {
		Option.Time.ButtonProduct._visible = true;
		Option.Time.txtProduct.type = "dynamic";
		Option.Time.txtProduct.selectable = false;
		newArtist = 0;
		Option.Time.chkArtist.check._visible = false;
		fscommand("Artist", 0);
		fscommand("ArtistProduct", Option.Time.txtProduct.text);
	} else {
		Option.Time.ButtonProduct._visible = true;
		//		Option.Time.txtProduct.type = "input";
		//		Option.Time.txtProduct.selectable = true;
		newArtist = 1;
		Option.Time.chkArtist.check._visible = true;
		fscommand("Artist", 1);
		fscommand("ArtistProduct", Option.Time.txtProduct.text);
	}
};
Option.Time.chkTitle.Button.onRelease = function() {
	if (Option.Time.chkTitle.check._visible == true) {
		Option.Time.ButtonAlbum._visible = true;
		Option.Time.txtAlbum.type = "dynamic";
		Option.Time.txtAlbum.selectable = false;
		newTitle = 0;
		Option.Time.chkTitle.check._visible = false;
		fscommand("Title", 0);
		fscommand("TitleAlbum", Option.Time.txtAlbum.text);
	} else {
		//		Option.Time.txtAlbum.type = "input";
		//		Option.Time.txtAlbum.selectable = true;
		newTitle = 1;
		Option.Time.chkTitle.check._visible = true;
		fscommand("Title", 1);
		fscommand("TitleAlbum", Option.Time.txtAlbum.text);
	}
};
Option.After.chkRename.Button.onRelease = function() {
	if (Option.After.chkRename.check._visible == true) {
		newRename = 0;
		enabledCheckBox(false);
		Option.After.chkProduct.check._visible = false;
		Option.After.chkAlbum.check._visible = false;
		Option.After.chkTrack.check._visible = false;
		fscommand("Rename", 0);
	} else {
		newRename = 1;
		enabledCheckBox(true);
		fscommand("Rename", 1);
	}
};
Option.After.chkProduct.Button.onRelease = function() {
	if (Option.After.chkProduct.check._visible == true) {
		newAddProduct = 0;
		Option.After.chkProduct.check._visible = false;
		fscommand("AddProduct", 0);
	} else {
		newAddProduct = 1;
		Option.After.chkProduct.check._visible = true;
		fscommand("AddProduct", 1);
	}
};
Option.After.chkAlbum.Button.onRelease = function() {
	if (Option.After.chkAlbum.check._visible == true) {
		newAddAlbum = 0;
		Option.After.chkAlbum.check._visible = false;
		fscommand("AddAlbum", 0);
	} else {
		newAddAlbum = 1;
		Option.After.chkAlbum.check._visible = true;
		fscommand("AddAlbum", 1);
	}
};
Option.After.chkTrack.Button.onRelease = function() {
	if (Option.After.chkTrack.check._visible == true) {
		newAddTrack = 0;
		Option.After.chkTrack.check._visible = false;
		fscommand("AddTrack", 0);
	} else {
		newAddTrack = 1;
		Option.After.chkTrack.check._visible = true;
		fscommand("AddTrack", 1);
	}
};
Option.After.chkEdit.Button.onRelease = function() {
	if (Option.After.chkEdit.check._visible == true) {
		newEdit = 0;
		Option.After.chkEdit.check._visible = false;
		fscommand("Edit", 0);
	} else {
		newEdit = 1;
		Option.After.chkEdit.check._visible = true;
		fscommand("Edit", 1);
	}
};
Exit.chkExit.Button.onRelease = function() {
	if (Exit.chkExit.check._visible == true) {
		Exit.chkExit.check._visible = false;
		fscommand("ScanComplete", false);
	} else {
		Exit.chkExit.check._visible = true;
		fscommand("ScanComplete", true);
	}
};
itemMatch.seekbar.ButtonSeek.onRelease = function() {
	seekSelect("itemMatch.seekbar", this._xmouse);
};
itemMatch.volumebar.Button.onRelease = function() {
	VolumeSet("itemMatch.volumebar", this._xmouse);
};
itemMatch.Ok.Button.onRelease = function() {
	itemMatch._visible = false;
	fscommand("OKItem", valItem);
};
itemMatch.cancel.Button.onRelease = function() {
	itemMatch._visible = false;
	fscommand("cancelItem", -1);
};
itemMatch.item.ButtonDown.onRelease = function() {
	ClickItemDown();
};
itemMatch.item.ButtonUp.onRelease = function() {
	ClickItemUp();
};
for (i=0; i<12; i++) {
	eval("itemMatch.item.Button"+i).onRelease = function() {
		deselect("itemMatch.item.");
		ii = String(this._name).substr(6);
		eval("itemMatch.item.sel"+ii)._visible = true;
		fscommand("ItemMatch", eval("itemMatch.item.Text"+ii).text);
		ii = eval("itemMatch.item.ind"+ii).text;
		valItem = ii;
	};
}
correctFile.seekbar.ButtonSeek.onRelease = function() {
	seekSelect("correctFile.seekbar", this._xmouse);
};
correctFile.volumebar.Button.onRelease = function() {
	VolumeSet("correctFile.volumebar", this._xmouse);
};
correctFile.Ok.Button.onRelease = function() {
	correctFile._visible = false;
	fscommand("OKItem", valFile);
};
correctFile.cancel.Button.onRelease = function() {
	correctFile._visible = false;
	fscommand("cancelItem", -1);
};
correctFile.item.ButtonDown.onRelease = function() {
	ClickPathDown();
};
correctFile.item.ButtonUp.onRelease = function() {
	ClickPathUp();
};
for (i=0; i<12; i++) {
	eval("correctFile.item.Button"+i).onRelease = function() {
		deselect("correctFile.item.");
		ii = String(this._name).substr(6);
		eval("correctFile.item.sel"+ii)._visible = true;
		fscommand("CorrectFile", eval("correctFile.item.Text"+ii).text);
		ii = eval("correctFile.item.ind"+ii).text;
		valFile = ii;
	};
}
/// Folder
/*
for (var i = 0;i<4;i++){
	eval("Folders.ButtonPath"+i).onRelease = function() {
		ii = String(this._name).substr(10);

	}
}
Folders.ButtonUp.onRelease = function(){
	SelectMovieClip("Folders.MovieUp");
}
Folders.ButtonDown.onRelease = function(){
	SelectMovieClip("Folders.MovieDown");
}

Folders.ButtonDelete.onRelease = function(){
	SelectMovieClip("Folders.MovieDelete");
}

Folders.ButtonClose.onRelease = function(){
	Folders._visible = false;
	enbFolders._visible = false;
}
*/
///////////////
/// onRollOver
///////////////
topBar.ButtonB.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Back", SHTT, -10, 20);
	SelectMovieClip("topBar.MovieB");
	levelSelected = 0;
};
topBar.ButtonB.onRollOut = function() {
	HideTooltip("txtTooltip");
};
/*
topBar.ButtonM.onRollOver=function(){
	SelectMovieClip(topBar.MovieM)
}
topBar.ButtonS.onRollOver=function(){
	SelectMovieClip(topBar.MovieS)
}
topBar.ButtonP.onRollOver=function(){
	SelectMovieClip(topBar.MovieP)
}
topBar.ButtonC.onRollOver=function(){
	SelectMovieClip(topBar.MovieC)
}
topBar.ButtonL.onRollOver=function(){
	SelectMovieClip(topBar.MovieL)
}
topBar.ButtonO.onRollOver=function(){
	SelectMovieClip(topBar.MovieO)
}*/
topBar.ButtonX.onRollOver = function() {
	SelectMovieClip("topBar.MovieX");
	levelSelected = 0;
};
Menu.Player.Button.onRollOver = function() {
	SelectMovieClip("Menu.Player.Movie");
	levelSelected = 1;
	//	Fade("Menu.Player.ff","Over")
};
Menu.Exit.Button.onRollOver = function() {
	SelectMovieClip("Menu.Exit.Movie");
	levelSelected = 1;
	//	Fade("Menu.Exit.ff","Over")
};
Path.BrowseFolder.Button.onRollOver = function() {
	SelectMovieClip("Path.BrowseFolder.Movie");
	levelSelected = 2;
};
Path.DeleteFolder.Button.onRollOver = function() {
	SelectMovieClip("Path.DeleteFolder.Movie");
	levelSelected = 2;
};
Path.ButtonHis.onRollOver = function() {
	SelectMovieClip("Path.MovieHis");
	levelSelected = 2;
};
for (var i = 0; i<5; i++) {
	eval("Path.historyFolders.Button"+i).onRollOver = function() {
		ii = String(this._name).substr(6);
		SelectMovieClip("Path.historyFolders.Movie"+ii);
		levelSelected = 4;
	};
}
Path.historyFolders.ButtonUp.onRollOver = function() {
	SelectMovieClip("Path.historyFolders.MovieUp");
};
Path.historyFolders.ButtonDown.onRollOver = function() {
	SelectMovieClip("Path.historyFolders.MovieDown");
};
//-------------
SelectLanguage.Button.onRollOver = function() {
	SelectMovieClip("SelectLanguage.Movie");
	levelSelected = 2;
};
SelectLanguage.SelectLan.ButtonUp.onRollOver = function() {
	SelectMovieClip("SelectLanguage.SelectLan.MovieUp");
	levelSelected = 3;
};
SelectLanguage.SelectLan.ButtonDown.onRollOver = function() {
	SelectMovieClip("SelectLanguage.SelectLan.MovieDown");
	levelSelected = 3;
};
for (i=0; i<4; i++) {
	eval("SelectLanguage.SelectLan.Button"+i).onRollOver = function() {
		ii = String(this._name).substr(6);
		SelectMovieClip("SelectLanguage.SelectLan.Movie"+ii);
		levelSelected = 3;
	};
}
scan.Button.onRollOver = function() {
	SelectMovieClip("scan.Movie");
	levelSelected = 2;
};
scanBy.optFileName.Button.onRollOver = function() {
	SelectMovieClip("scanBy.optFileName.Movie");
	levelSelected = 2;
};
scanBy.optFileHint.Button.onRollOver = function() {
	SelectMovieClip("scanBy.optFileHint.Movie");
	levelSelected = 2;
};
scanBy.optTime.Button.onRollOver = function() {
	SelectMovieClip("scanBy.optTime.Movie");
	levelSelected = 2;
};
Option.File.optFileName.Button.onRollOver = function() {
	SelectMovieClip("Option.File.optFileName.Movie");
	levelSelected = 2;
};
Option.File.optID.Button.onRollOver = function() {
	SelectMovieClip("Option.File.optID.Movie");
	levelSelected = 2;
};
Option.TimeFile.optFileName.Button.onRollOver = function() {
	SelectMovieClip("Option.TimeFile.optFileName.Movie");
	levelSelected = 2;
};
Option.TimeFile.optID.Button.onRollOver = function() {
	SelectMovieClip("Option.TimeFile.optID.Movie");
	levelSelected = 2;
};
Option.Time.chkArtist.Button.onRollOver = function() {
	SelectMovieClip("Option.Time.chkArtist.Movie");
	levelSelected = 2;
};
Option.Time.chkTitle.Button.onRollOver = function() {
	SelectMovieClip("Option.Time.chkTitle.Movie");
	levelSelected = 2;
};
Option.After.chkRename.Button.onRollOver = function() {
	SelectMovieClip("Option.After.chkRename.Movie");
	levelSelected = 2;
};
Option.After.chkProduct.Button.onRollOver = function() {
	SelectMovieClip("Option.After.chkProduct.Movie");
	levelSelected = 2;
};
Option.After.chkAlbum.Button.onRollOver = function() {
	SelectMovieClip("Option.After.chkAlbum.Movie");
	levelSelected = 2;
};
Option.After.chkTrack.Button.onRollOver = function() {
	SelectMovieClip("Option.After.chkTrack.Movie");
	levelSelected = 2;
};
Option.After.chkEdit.Button.onRollOver = function() {
	SelectMovieClip("Option.After.chkEdit.Movie");
	levelSelected = 2;
};
Exit.chkExit.Button.onRollOver = function() {
	SelectMovieClip("Exit.chkExit.Movie");
	levelSelected = 2;
};
itemMatch.OK.Button.onRollOver = function() {
	SelectMovieClip("itemMatch.OK.Movie");
};
itemMatch.cancel.Button.onRollOver = function() {
	SelectMovieClip("itemMatch.cancel.Movie");
};
for (i=0; i<12; i++) {
	eval("itemMatch.item.Button"+i).onRollOver = function() {
		ii = String(this._name).substr(6);
		SelectMovieClip("itemMatch.item.Movie"+ii);
	};
}
itemMatch.item.ButtonUp.onRollOver = function() {
	SelectMovieClip("itemMatch.item.MovieUp");
};
itemMatch.item.ButtonDown.onRollOver = function() {
	SelectMovieClip("itemMatch.item.MovieDown");
};
correctFile.OK.Button.onRollOver = function() {
	SelectMovieClip("correctFile.OK.Movie");
};
for (i=0; i<12; i++) {
	eval("correctFile.item.Button"+i).onRollOver = function() {
		ii = String(this._name).substr(6);
		SelectMovieClip("correctFile.item.Movie"+ii);
	};
}
correctFile.item.ButtonUp.onRollOver = function() {
	SelectMovieClip("correctFile.item.MovieUp");
};
correctFile.item.ButtonDown.onRollOver = function() {
	SelectMovieClip("correctFile.item.MovieDown");
};
correctFile.cancel.Button.onRollOver = function() {
	SelectMovieClip("correctFile.cancel.Movie");
};
/// Folder
/*for (var i = 0;i<4;i++){
	eval("Folders.ButtonPath"+i).onRollOver = function() {
		ii = String(this._name).substr(10);
		SelectMovieClip("Folders.MoviePath"+ii);
	}
}
Folders.ButtonUp.onRollOver = function(){
	SelectMovieClip("Folders.MovieUp");
}
Folders.ButtonDown.onRollOver = function(){
	SelectMovieClip("Folders.MovieDown");
}

Folders.ButtonDelete.onRollOver = function(){
	SelectMovieClip("Folders.MovieDelete");
}

Folders.ButtonClose.onRollOver = function(){
	SelectMovieClip("Folders.MovieClose");
}
*/
///
//////////////
/// onRollOut
//////////////
Menu.Player.Button.onRollOut = function() {
	Fade("Menu.Player.ff", "Out");
};
Menu.Exit.Button.onRollOut = function() {
	Fade("Menu.Exit.ff", "Out");
};
/////////////
/// onChange
/////////////
Option.Time.txtProduct.onChanged = function() {
	if (Option.Time.txtProduct.text != "") {
		fscommand("ArtistProduct", Option.Time.txtProduct.text);
	}
};
Option.Time.txtAlbum.onChanged = function() {
	if (Option.Time.txtAlbum.text != "") {
		fscommand("TitleAlbum", Option.Time.txtAlbum.text);
	}
};
////////
/// Key
////////
var CtrlKey = false;
upCtrl = new Object();
upCtrl.onKeyUp = function() {
	if (Key.getCode() == 17) {
		CtrlKey = false;
	}
};
Key.addListener(upCtrl);
myListener = new Object();
myListener.onKeyDown = function() {
	if (!scanProcess._visible) {
		fscommand("clearTimeSlideshow", true);
		if (Key.getCode() == 17) {
			CtrlKey = true;
		}
		if (Key.getCode() == key_rightArrow || Key.getCode() == key_upArrow || Key.getCode() == key_leftArrow || Key.getCode() == key_downArrow) {
			CtrlKey = false;
		}
		if (CtrlKey == true) {
			combindKey(Key.getCode());
		} else {
			PressKeyCount(Key.getCode());
		}
	}
};
Key.addListener(myListener);
var SelectLevel = 1;
function combindKey(KeyCode) {
	if (KeyCode == key_changeWindow) {
		// change window stage
		fscommand("changeWindow", true);
	} else if (KeyCode == key_hideMouse) {
		// hide or show mouse
		if (Mouse.hide() == 0) {
			Mouse.show();
			fscommand("setHideMouse", false);
		} else {
			Mouse.hide();
			fscommand("setHideMouse", true);
		}
	} else if (KeyCode == key_minimize) {
		CtrlKey = false;
		fscommand("Minimize", true);
	} else if (KeyCode == key_visualization) {
		fscommand("Visualization", true);
	} else if (KeyCode == key_slideShow) {
		fscommand("setSlideShow", true);
	}
}
function PressKeyCount(KeyCode) {
	if (KeyCode == key_backspace) {
		if ((bgenabled._visible == false) and (editting == false)) {
			TopBar.ButtonB.onRollOver();
			TopBar.ButtonB.onRelease();
		}
	} else if (KeyCode == key_tab) {
		if (editting == false) {
			// tab in
			if ((Option.Time.chkArtist.check._visible == true) and (Option.Time.ButtonProduct._visible == true)) {
				Option.Time.ButtonProduct._visible = false;
				Option.Time.txtProduct.type = "input";
				Option.Time.txtProduct.selectable = true;
				editting = true;
				tmpsel = StoreNameSelected;
				StoreNameSelected = "ButtonProduct";
			} else if ((Option.Time.chkTitle.check._visible == true) and (Option.Time.ButtonAlbum._visible == true)) {
				Option.Time.ButtonAlbum._visible = false;
				Option.Time.txtAlbum.type = "input";
				Option.Time.txtAlbum.selectable = true;
				editting = true;
				tmpsel = StoreNameSelected;
				StoreNameSelected = "ButtonAlbum";
			}
		} else {
			// tab out
			if (Option.Time.ButtonProduct._visible == false) {
				Option.Time.ButtonProduct._visible = true;
				Option.Time.txtProduct.type = "dynamic";
				Option.Time.txtProduct.selectable = false;
				editting = false;
				StoreNameSelected = tmpsel;
				if (Option.Time.txtProduct.text == "") {
					Option.Time.txtProduct.text = 0;
				} else {
					Option.Time.txtProduct.text = int(Option.Time.txtProduct.text);
				}
				if (Option.Time.chkTitle.check._visible == true) {
					Option.Time.ButtonAlbum._visible = false;
					Option.Time.txtAlbum.type = "input";
					Option.Time.txtAlbum.selectable = true;
					editting = true;
					tmpsel = StoreNameSelected;
					StoreNameSelected = "ButtonAlbum";
				}
			} else if (Option.Time.ButtonAlbum._visible == false) {
				Option.Time.ButtonAlbum._visible = true;
				Option.Time.txtAlbum.type = "dynamic";
				Option.Time.txtAlbum.selectable = false;
				editting = false;
				StoreNameSelected = tmpsel;
				if (Option.Time.txtAlbum.text == "") {
					Option.Time.txtAlbum.text = 0;
				} else {
					Option.Time.txtAlbum.text = int(Option.Time.txtAlbum.text);
				}
			}
		}
	} else if ((KeyCode == key_rightArrow) and (editting == false)) {
		fscommand("offScreen", true);
		GoRight();
		//dynamicMove(selectaleObj,StoreNameSelected, "Right");
	} else if ((keyCode == key_leftArrow) and (editting == false)) {
		fscommand("offScreen", true);
		//dynamicMove(selectaleObj,StoreNameSelected, "Right");
		GoLeft();
	} else if ((KeyCode == key_upArrow) and (editting == false)) {
		fscommand("offScreen", true);
		GoUp();
	} else if ((keyCode == key_downArrow) and (editting == false)) {
		fscommand("offScreen", true);
		GoDown();
	} else if ((keyCode == 33) || (keyCode == 34) || (keyCode == 82) || (keyCode == 83) || (keyCode == 88) || (keyCode == 67) || (keyCode == 86) || (keyCode == 66) || (keyCode == 90)) {
		if ((bgenabled._visible == false) and (editting == false)) {
			fscommand("Key", keyCode);
		}
	} else if (keyCode == 187 || keyCode == 189 || keyCode == 77) {
		if ((bgenabled._visible == false) and (editting == false)) {
			control_syncronize("volume", "Key", keyCode);
		}
	} else if (KeyCode == key_enter) {
		if (StoreNameSelected == "ButtonProduct") {
			StoreNameSelected = tmpsel;
			editting = false;
			Option.Time.ButtonProduct._visible = true;
			Option.Time.txtProduct.type = "dynamic";
			Option.Time.txtProduct.selectable = false;
			if (Option.Time.txtProduct.text == "") {
				Option.Time.txtProduct.text = 0;
			} else {
				Option.Time.txtProduct.text = int(Option.Time.txtProduct.text);
			}
		} else if (StoreNameSelected == "ButtonAlbum") {
			StoreNameSelected = tmpsel;
			editting = false;
			Option.Time.ButtonAlbum._visible = true;
			Option.Time.txtAlbum.type = "dynamic";
			Option.Time.txtAlbum.selectable = false;
			if (Option.Time.txtAlbum.text == "") {
				Option.Time.txtAlbum.text = 0;
			} else {
				Option.Time.txtAlbum.text = int(Option.Time.txtAlbum.text);
			}
		} else {
			eval(Replace(StoreNameSelected, "Movie", "Button")).onRelease();
		}
		//} else if (KeyCode == key_space) {
		//	Splace();
	} else if (KeyCode == Key_space) {
		fscommand("popup", true);
		/*if (TrackShow._visible == false and tmpTrackInfo != ""){
					TrackShow.setTrackShow(tmpTrackInfo);
				}*/
	}
	function GoRight() {
	//	if(levelSelected==0){
		dynamicMove(selectaleObj,StoreNameSelected, "Right");
	//	}else if (levelSelected==2){

	//	}
		/*
		if (levelSelected == 0) {
			StaticMove("topBar.MovieB,topBar.MovieX", StoreNameSelected, "Right");
		} else if (levelSelected == 2) {
			if (scanBy.optTime.Button.enabled == true) {
				if (Option.File.optFileName.Button.enabled == true) {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.File.optFileName.Movie", StoreNameSelected, "Right");
				} else {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.File.optID.Movie", StoreNameSelected, "Right");
				}
			} else {
				if (StoreNameSelected == "Exit.chkExit.Movie") {
					if (Option.TimeFile.optFileName.Button.enabled == true) {
						Option.TimeFile.optFileName.Button.onRollOver();
					} else {
						Option.TimeFile.optID.Button.onRollOver();
					}
				} else {
					if (StoreNameSelected == "Option.TimeFile.optFileName.Movie") {
						if (Option.After.chkRename.check._visible == true) {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
						} else {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
						}
					} else {
						if (Option.After.chkRename.check._visible == true) {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
						} else {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
						}
					}
				}
			}
		}
		*/
	}
	function GoLeft() {
		switch(levelSelected){
		case 0:
		case 2:
			dynamicMove(selectaleObj,StoreNameSelected, "Left");

			break;
		}
		/*
		if (levelSelected == 0) {
			StaticMove("topBar.MovieB,topBar.MovieX", StoreNameSelected, "Left");
		} else if (levelSelected == 2) {
			if (scanBy.optTime.Button.enabled == true) {
				if (Option.File.optFileName.Button.enabled == true) {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,Exit.chkExit.Movie,Option.File.optFileName.Movie", StoreNameSelected, "Left");
				} else {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,Exit.chkExit.Movie,Option.File.optID.Movie", StoreNameSelected, "Left");
				}
			} else {
				if ((StoreNameSelected == "Option.TimeFile.optFileName.Movie") or (StoreNameSelected == "Option.TimeFile.optID.Movie")) {
					Exit.chkExit.Button.onRollOver();
				} else if (StoreNameSelected == "Option.Time.chkArtist.Movie") {
					if (Option.TimeFile.optFileName.Button.enabled == true) {
						Option.TimeFile.optFileName.Button.onRollOver();
					} else {
						Option.TimeFile.optID.Button.onRollOver();
					}
				} else {
					if (StoreNameSelected == "Option.TimeFile.optFileName.Movie") {
						if (Option.After.chkRename.check._visible == true) {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
						} else {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
						}
					} else {
						if (Option.After.chkRename.check._visible == true) {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
						} else {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
						}
					}
				}
			}
		}
		*/
	}
	function GoUp() {
		switch(levelSelected){
		case 1:

			dynamicMove(selectMenuMinAndExit,StoreNameSelected, "Up");
			if(StoreNameSelected=="topBar.MovieX") {
				Menu._visible = false;
			}
			break;
		case 0:
		case 2:
			dynamicMove(selectaleObj,StoreNameSelected, "Up");
			break;
		case 3:
			if (StoreNameSelected == "SelectLanguage.SelectLan.Movie0") {
				if (SelectLanguage.SelectLan.ButtonUp.enabled) {
					SelectLanguage.SelectLan.ButtonUp.onRelease();
				}
			}
			var TotalIndex = CountLabel_Language;
			SelecteListItemUp(StoreNameSelected, TotalIndex);
			break;
		case 4:
			if (StoreNameSelected == "Path.historyFolders.Movie0") {
				if (Path.historyFolders.ButtonUp.enabled) {
					Path.historyFolders.ButtonUp.onRelease();
				}
			}
			var TotalIndex = CountLabel_historyPath;
			SelecteListItemUp(StoreNameSelected, TotalIndex);		
			break;
		}
		/*
		if (levelSelected == 1) {
			if (StoreNameSelected == "Menu.Player.Movie") {
				Menu._visible = false;
				topbar.ButtonX.onRollOver();
			} else {
				Menu.Player.Button.onRollOver();
			}
		} else if (levelSelected == 2) {
			if (StoreNameSelected == "scan.Movie" || StoreNameSelected == "SelectLanguage.Movie") {
				topBar.ButtonB.onRollOver();
			} else {
				if (scanBy.optTime.Button.enabled == true) {
					if (Option.File.optFileName.Button.enabled == true) {
						StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,Exit.chkExit.Movie,Option.File.optFileName.Movie", StoreNameSelected, "Left");
					} else {
						StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,Exit.chkExit.Movie,Option.File.optID.Movie", StoreNameSelected, "Left");
					}
				} else {
					if ((StoreNameSelected == "Option.TimeFile.optFileName.Movie") or (StoreNameSelected == "Option.TimeFile.optID.Movie")) {
						Exit.chkExit.Button.onRollOver();
					} else if (StoreNameSelected == "Option.Time.chkArtist.Movie") {
						if (Option.TimeFile.optFileName.Button.enabled == true) {
							Option.TimeFile.optFileName.Button.onRollOver();
						} else {
							Option.TimeFile.optID.Button.onRollOver();
						}
					} else {
						if (StoreNameSelected == "Option.TimeFile.optFileName.Movie") {
							if (Option.After.chkRename.check._visible == true) {
								StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
							} else {
								StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
							}
						} else {
							if (Option.After.chkRename.check._visible == true) {
								StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
							} else {
								StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Left");
							}
						}
					}
				}
			}
		} else if (levelSelected == 3) {
			if (StoreNameSelected == "SelectLanguage.SelectLan.Movie0") {
				if (SelectLanguage.SelectLan.ButtonUp.enabled) {
					SelectLanguage.SelectLan.ButtonUp.onRelease();
				}
			}
			var TotalIndex = CountLabel_Language;
			SelecteListItemUp(StoreNameSelected, TotalIndex);
		} else if (levelSelected == 4) {
			if (StoreNameSelected == "Path.historyFolders.Movie0") {
				if (Path.historyFolders.ButtonUp.enabled) {
					Path.historyFolders.ButtonUp.onRelease();
				}
			}
			var TotalIndex = CountLabel_historyPath;
			SelecteListItemUp(StoreNameSelected, TotalIndex);
		}
		*/
	}
	function GoDown() {
		switch(levelSelected){
			case 1:
				dynamicMove(selectMinAndExit,StoreNameSelected, "Down");
				break;
			case 0:
			case 2:
				dynamicMove(selectaleObj,StoreNameSelected, "Down");
				break;
			case 3:
				var TotalIndex = CountLabel_Language;
				if (StoreNameSelected == "SelectLanguage.SelectLan.Movie"+(TotalIndex-1)) {
					if (SelectLanguage.SelectLan.ButtonDown.enabled) {
						SelectLanguage.SelectLan.ButtonDown.onRelease();
					}
				}
				SelecteListItemDown(StoreNameSelected, TotalIndex);
				break;
			case 4:
				var TotalIndex = CountLabel_historyPath;
				if (StoreNameSelected == "Path.historyFolders.Movie"+(TotalIndex-1)) {
					if (Path.historyFolders.ButtonDown.enabled) {
						Path.historyFolders.ButtonDown.onRelease();
					}
				}
				SelecteListItemDown(StoreNameSelected, TotalIndex);
		}

		/*
		if (levelSelected == 0) {
			SelectLanguage.Button.onRollOver();
		} else if (levelSelected == 1) {
			StaticMove("Menu.Player.Movie,Menu.Exit.Movie", StoreNameSelected, "Right");
		} else if (levelSelected == 2) {
			if (scanBy.optTime.Button.enabled == true) {
				if (Option.File.optFileName.Button.enabled == true) {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.File.optFileName.Movie", StoreNameSelected, "Right");
				} else {
					StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optTime.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.File.optID.Movie", StoreNameSelected, "Right");
				}
			} else {
				if (StoreNameSelected == "Exit.chkExit.Movie") {
					if (Option.TimeFile.optFileName.Button.enabled == true) {
						Option.TimeFile.optFileName.Button.onRollOver();
					} else {
						Option.TimeFile.optID.Button.onRollOver();
					}
				} else {
					if (StoreNameSelected == "Option.TimeFile.optFileName.Movie") {
						if (Option.After.chkRename.check._visible == true) {
							//StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie", StoreNameSelected, "Right");
						} else {
							//StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.TimeFile.optFileName.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
 							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie", StoreNameSelected, "Right");
						}
					} else {
						if (Option.After.chkRename.check._visible == true) {
							//StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkProduct.Movie,Option.After.chkAlbum.Movie,Option.After.chkTrack.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie", StoreNameSelected, "Right");
						} else {
							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie", StoreNameSelected, "Right");
//							StaticMove("SelectLanguage.Movie,scan.Movie,Path.MovieHis,Path.BrowseFolder.Movie,Path.DeleteFolder.Movie,scanBy.optFileName.Movie,scanBy.optFileHint.Movie,Exit.chkExit.Movie,Option.TimeFile.optID.Movie,Option.Time.chkArtist.Movie,Option.Time.chkTitle.Movie,Option.After.chkRename.Movie,Option.After.chkEdit.Movie", StoreNameSelected, "Right");
						}
					}
				}
			}
		} else if (levelSelected == 3) {
			var TotalIndex = CountLabel_Language;
			if (StoreNameSelected == "SelectLanguage.SelectLan.Movie"+(TotalIndex-1)) {
				if (SelectLanguage.SelectLan.ButtonDown.enabled) {
					SelectLanguage.SelectLan.ButtonDown.onRelease();
				}
			}
			SelecteListItemDown(StoreNameSelected, TotalIndex);
		} else if (levelSelected == 4) {
			var TotalIndex = CountLabel_historyPath;
			if (StoreNameSelected == "Path.historyFolders.Movie"+(TotalIndex-1)) {
				if (Path.historyFolders.ButtonDown.enabled) {
					Path.historyFolders.ButtonDown.onRelease();
				}
			}
			SelecteListItemDown(StoreNameSelected, TotalIndex);
		}
		*/
	}
}
function Splace() {
	if (editting == false) {
		eval(Replace(StoreNameSelected, "Movie", "Button")).onRelease();
	}
}
//----------- FUNCTION OF KEY ---------------------
function SelecteListItemUp(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index>0) {
		SelectMovieClip(Str+(Index-1));
	} else {
		SelectMovieClip(Str+(TotalIndex-1));
	}
}
function SelecteListItemDown(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index<TotalIndex-1) {
		SelectMovieClip(Str+(Index+1));
	} else {
		SelectMovieClip(Str+"0");
	}
}
// get values  from VB
//====================
function setVB(val) {
	var spl = new Array();
	spl = String(val).split("|%|");
	switch (spl[0]) {
	case "slideShow" :
		if (spl[1] == "True") {
			DisplayTooltip(topBar.ButtonB, "txtTooltip", "slideshow (ON)", SHTT, 100, 100, true);
		} else if (spl[1] == "False") {
			DisplayTooltip(topBar.ButtonB, "txtTooltip", "slideshow (OFF)", SHTT, 100, 100, true);
		}
		break;
	case "TrackShow" :
		TrackShow.setTrackShow(spl[1]);
		break;
	case "default" :
		tmpTrackInfo = spl[1];
		break;
	case "seekbar" :
		var arr_seek = new Array();
		arr_seek = String(spl[1]).split("~");
		if (correctFile._visible == true) {
			seekSet("correctFile.seekBar", arr_seek[0], arr_seek[1], arr_seek[2], arr_seek[3]);
		} else if (itemMatch._visible == true) {
			seekSet("itemMatch.seekBar", arr_seek[0], arr_seek[1], arr_seek[2], arr_seek[3]);
		}
		break;
	}
}
function getvb() {
}
this.addProperty("vb", getvb, setVB);
