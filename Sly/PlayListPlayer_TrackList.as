var NumLeftTrack = 0;
var tmrIDPlayTrack="";
var currentIndex = 0;
// start index in playlist
var DLIndex;
var StWave = "%~%";
var StWave1 = "~";
TrackName = "ListBar";
var TrackObj = "List";
var boolWaitForNextDelete = false;
var valueIntervalID = 0;
function VisiblePlay(value) {
	BackPlay._visible = value;
}
VisiblePlay(false);
function CheckAvailableTrack(index) {
	if (resultSearch[index].trackID == undefined and resultSearch.length>Index) {
		return false;
	}
	return true;
}
function DisplayItemTrack(Obj, Index, Count, nItem,dImage) { //dImage used not load image when move up/down
	var ListCount=0;
	if (CheckAvailableTrack(Index) == false) {
		IndexStore = Index;
		fscommand("GetNextTrackInfo", Index+StWave1+Count);
		return;
	}
	NoList = false;
	var strTrackInfo,strTrackInfoUnicode;		//for display name under track title
	EngTextFormat.font = EngFont;
	EngTextFormat.size = EngSize;
	EngTextFormat.bold = false;
	UniTextFormat.font = UniFont;
	UniTextFormat.size = UniSize;
	UniTextFormat.bold = false;
	KhmTextFormat.font = FontKhmer;
	KhmTextFormat.size = SizeKhmer;
	KhmTextFormat.bold = false;
	//Clear rollover item
	eval(TrackName+".over_mc")._visible = false;
	eval(TrackName+".TextToolTip")._visible = false;
	eval(TrackName+".overCover_mc")._visible = false;
	eval(TrackName+".samOver_mc")._visible = false;		
	eval(TrackName+".cartOver_mc")._visible = false;
	//clear

	boolEnglishFont = false;
	for (var j = 0; j<nItem; j++) {
		objMovie = eval(Obj+".Movie"+j);
		objButton = eval(Obj+".Button"+j);
		objText = eval(Obj+".Text"+j);
		objDo = eval(Obj+".Do"+j);
		objArtist = eval(Obj+".Artist"+j);
		objPic = eval(Obj+".Pic"+j);
		objSam = eval(Obj+".Sam"+j);
		objSingType =   eval(Obj+".Singer"+j);
		
		if (Index<resultSearch.length) {
			ListCount+=1;
			objMovie._visible = true;
			objButton._visible = true;
			objText._visible = true;
			objDo._visible = true;
			objArtist._visible = true;
			objSingType._visible=true;
			//.........walmart..........
			databaseType=SplAllCountrys[resultSearch[Index].Lan].databaseType;
//			fscommand("mb", "Track Title =  "+ iShowUnderTrackTitle + ", SingType="+ resultSearch[Index].SingType);
			if(iShowUnderTrackTitle==0 and resultSearch[Index].SingType>=0){
				strTrackInfo	=String(resultSearch[Index].Artist)
				strTrackInfoUnicode=String(resultSearch[Index].unicodeArtist)
			}else{
				strTrackInfo	=String(resultSearch[Index].Album)
				strTrackInfoUnicode=String(resultSearch[Index].unicodeAlbum)
			}
			if (resultSearch[Index].Ava == 0) {
				//...........Purchase.....................
				if (int(resultSearch[Index].ShoppingID)>0 && NoInternetConnected == "0") {
					eval(Obj+".Cart"+j)._visible = true;
				} else {
					eval(Obj+".Cart"+j)._visible = false;
				}
			} else {
				eval(Obj+".Cart"+j)._visible = false;
			}
			objSam.setMusicNote(resultSearch[Index].Ava, resultSearch[Index].walMart_Ava);
			//...........................
			NoList = true;
			objPic.ID = resultSearch[Index].PathPic;
			//assign the ID for it
			objPic.Index = Index;
			//assign it index
//			if (resultSearch[Index].ReservePath<>"") {
//				objPic.loadFadeImage(resultSearch[Index].ReservePath);
//			} else {
//				objPic.loadFadeImage(resultSearch[Index].PathPic);
//			}
			fscommand("SearchPathImage", resultSearch[Index].PathPic+"%~%"+"Track"+"%~%"+Index+"%~%"+resultSearch[Index].LanPath+"%~%"+resultSearch[Index].Lan);
			//======================================================================
			uni_boo = false;
			if (ChangeLan == "Eng") {
				boolEnglishFont = (strTrackInfo<>"");
				objText.wordWrap = true;
				var tmpTrack_str = "";
				//var eng_boo = true;
				if (resultSearch[Index].trackTitle == "") {
					uni_boo = true;
				}
				if (uni_boo == false) {
					tmpTrack_str = (Index+1)+"."+resultSearch[Index].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
					//,EngFont,EngSize);
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
				} else {
					tmpTrack_str = (Index+1)+"."+resultSearch[Index].unicodeTrackTitle;
					objDo.text = "...";
					if (getKhmerCountry(resultSearch[Index].Lan) != "1") {
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
					} else {
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, KhmTextFormat);
						if (getKhmerCountry(resultSearch[Index].Lan) == "1" && FontKhmer.length<=0 && KhmTextFormat.font == "") {
							var spl1 = resultSearch[Index].StPlayer.split("%%");
							var spl2 = spl1[2].split(StWave);
							var spl3 = spl2[1].split("||");
							FontKhmer = spl3[1];
							KhmTextFormat.font = FontKhmer;
						}
						objDo.setTextFormat(KhmTextFormat);
						objText.setTextFormat(KhmTextFormat);
					}
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";
				}
				objDo.autoSize = true;
				objDo._x = objText._x+objText.textWidth;
				objDo._y = objText._y;
			} else {
				boolEnglishFont = (strTrackInfoUnicode == "");
				objText.wordWrap = true;
				var tmpTrack_str = "";
				uni_boo = true;
				if (resultSearch[Index].unicodeTrackTitle == "") {
					uni_boo = false;
				}
				if (uni_boo == true) {
					tmpTrack_str = (Index+1)+"."+resultSearch[Index].unicodeTrackTitle;
					objDo.text = "...";
					if (getKhmerCountry(resultSearch[Index].Lan) != "1") {
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
					} else {
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, KhmTextFormat);
						if (getKhmerCountry(resultSearch[Index].Lan) == "1" && FontKhmer.length<=0 && KhmTextFormat.font == "") {
							var spl1 = resultSearch[Index].StPlayer.split("%%");
							var spl2 = spl1[2].split(StWave);
							var spl3 = spl2[1].split("||");
							FontKhmer = spl3[1];
							KhmTextFormat.font = FontKhmer;
						}
						objDo.setTextFormat(KhmTextFormat);
						objText.setTextFormat(KhmTextFormat);
					}
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";
				} else {
					tmpTrack_str = (Index+1)+"."+resultSearch[Index].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
				}
				objDo.autoSize = true;
				objDo._x = objText._x+objText.textWidth;
				objDo._y = objText._y;
			}
			if (uni_bool) {
				objText._y = yTrack[j]+parseInt(TrackPosUni, 10);
			} else {
				objText._y = yTrack[j]+parseInt(TrackPosEng, 10);
			}
			/////////Artist//////////			
			var objFont = new TextFormat();
			if (boolEnglishFont) {
				//display album title under the Chapter title
				//seng modified 2005-08-30
				objArtist.text = strTrackInfo;
				objFont.font = EngTextFormat.font;
				objFont.size = FontEnglish;
			} else {
				//display album title under the Chapter title
				objArtist.text = strTrackInfoUnicode;
				if (getKhmerCountry(resultSearch[Index].Lan) == "1") {
					objFont.size = FontUnicodeKhmer;
					objFont.font = KhmTextFormat.font;
				} else {
					objFont.size = FontUnicodeEnglish;
					objFont.font = UniTextFormat.font;
				}
			}
			objArtist.setTextFormat(objFont);
			objArtist.textColor = SelectColorValue;
			////////			resultSearch[Index].DownloadFromServer			
			delete (objFont);
			/////////Artist//////////
			var SingType=resultSearch[Index].SingType;
			if(databaseType==16){
				SingType=-1
			}
			objSingType.ShowSinger(SingType);			

			ChangeTrackFont(ChangeLan, resultSearch[Index].Lan, j);
			//...Download Image...
			//***
			if (resultSearch[Index].ReservePath == "") {
				resultSearch[Index].ReservePath = resultSearch[Index].PathPic;
				fscommand("SearchPathImage", resultSearch[Index].ReservePath+"%~%"+"Track"+"%~%"+Index+"%~%"+resultSearch[Index].LanPath+"%~%"+resultSearch[Index].Lan);
			}
			Index += 1;
		} else {
			objMovie._visible = false;
			objButton._visible = false;
			objText._visible = false;
			objDo._visible = false;
			objArtist._visible = false;
			objText.text = "";
			objSingType._visible=false;
			objPic.unloadFadeImage();
			objSam._visible = false;
			eval(Obj+".Cart"+j)._visible = false;
		}
	}
//	eval("Count"+TrackObj)=ListCount;
	set("Count"+TrackObj,ListCount);
	if (Nolist == false) {
		if (Index>0) {
			Index -= nTrack;
			set("IndexShow"+TrackObj, eval("IndexShow"+TrackObj)-nTrack);
			NumLeftTrack = NumLeftTrack-nTrack;
			set("LevelIndex"+TrackObj, eval("LevelIndex"+TrackObj)-1);
			DisplayItemTrack(Obj, Index, nTrack, nItem);
		}
	}
	ChangeTrackFontPreNext(ChangeLan);
	if (ClickAlbum) {
		DeselectedItem(Obj, eval("IndexShow"+TrackObj), -1);
	} else {
		DeselectedItem(Obj, eval("IndexShow"+TrackObj), ChangeCurIndexTrack);
	}
	//130305
	DisplayNext_Pre(resultSearch.length);
	if (ClickAlbum or StorePathPic == "") {
		//if load for the first time aStorePathPic=="" and ClickAlbum is pressed then show image
		DisplayAlbumPictrueInfo(RecordIndexAlbum);
	}
}
function setPlayerTrackAndPlayIndex(val_trackCount, val_PlayIndex) {
	if (!ClickAlbum) {
		var IndexShow = eval("IndexShow"+TrackObj);
		var Level = eval("LevelIndex"+TrackObj);
		ChangeCurIndexTrack = Number(val_PlayIndex);
		resultSearch.length = 0;
		resultSearch.length = Number(val_trackCount);
		Level=int(Level)
		IndexShow = int(IndexShow);
		if(Level<=0){
			Level=1;
		}
		FirstDisplayTrack(val_trackCount, "false");
		set("IndexShow"+TrackObj, IndexShow);
		set("LevelIndex"+TrackObj, Level);
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
	}
}
function FirstDisplayTrack(n, display) {
	FirstDisplaySearch(0);
	if (Unregistered == "False") {
		BackAlbumPic.Logo._visible = true;
	} else {
		BackAlbumPic.Logo._visible = false;
	}
	if (n>0) {
		FirstDisplay(TrackObj, n, nTrack);
		if (display != "false") {
			if (Number(currentIndex)>0) {
				set("IndexShow"+TrackObj, Number(currentIndex));
				set("LevelIndex"+TrackObj, (Number(currentIndex)/nTrack)+1);
				NumLeftTrack = Number(currentIndex);
				currentIndex = 0;
			}
			DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
		}
		//130305
		DisplayNext_Pre(n);
		//
		eval(TrackName)._visible = true;
		BackAlbumPic._visible = true;
		mini._visible = true;
		if (ClickAlbum) {
			VisibleNextPre(true);
			VisiblePlay(false);
		} else {
			VisiblePlay(true);
			VisibleNextPre(false);
		}
	} else {
		eval(TrackName)._visible = false;
		BackAlbumPic._visible = false;
		VisiblePlay(false);
	}
}
function VisibleInfo(Value) {
	if (Value == "true") {
		var b = true;
		eval(TrackName).BackStars._visible = b;
		eval(TrackName).RefreshCoverArt._visible = b;
		eval(TrackName).PathSlideshow._visible = b;
		eval(TrackName).DefaultVLC._visible = b;
		eval(TrackName).SearchPlayerPage._visible = b;
		eval(TrackName).download_song._visible = (current_status == 1);
		//only show when there is computer connected
		DisplayToolTipTrack(b);
	} else {
		var b = false;
	}
	eval(TrackName).CoverTrackInfo._visible = b;
	eval(TrackName).TrackLen._visible = b;
	eval(TrackName).TrackNo._visible = b;
	eval(TrackName).Artist._visible = b;
	eval(TrackName).Album._visible = b;
}
eval(TrackName).MovieRollOver.useHandCursor = false;
eval(TrackName).MovieRollOver.onRollOut = function() {
	VisibleInfo("false");
};
function FadeTooltipTrack() {
	clr += 10;
	if (clr>=50) {
		if(!TrackSel) eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
		VisibleInfo(false);
		clearInterval(clearToolTip1);
	}
}
function ToolTip(St, X, Y, Index, Lan) {
	eval(TrackName).TextToolTip._visible = false;
	eval(TrackName).TextToolTip.text = St;
	eval(TrackName).TextToolTip._width = eval(TrackBar+".Movie"+Index)._width-(eval(TrackName).TextToolTip._x-eval(TrackBar+".Movie"+Index)._x);
	eval(TrackName).TextToolTip._height = eval(TrackName+".Text"+Index)._height;
	eval(TrackName).TextToolTip.wordWrap = true;
	eval(TrackName).TextToolTip.autoSize = true;
	if (eval(TrackName+".Movie"+Index).storeLan == "Eng") {
		eval(TrackName).TextToolTip.setTextFormat(EngTextFormat);
	} else {
		if (getKhmerCountry(Lan) != "1") {
			eval(TrackName).TextToolTip.setTextFormat(UniTextFormat);
		} else {
			eval(TrackName).TextToolTip.setTextFormat(KhmTextFormat);
		}
	}
	if (eval(TrackName+".Do"+Index)._visible == true && eval(TrackName+".Do"+Index).text != "") {
		displayTwoLine_boo = true;
		eval(TrackName).TextToolTip._x = X;
		eval(TrackName).TextToolTip._y = Y;
		eval(TrackName).TextToolTip._visible = true;
		var g_color = new Color(eval(TrackName+".Movie"+Index));
		var s_color = new Color(eval(TrackName+".over_mc"));
		s_color.setRGB(g_color.getRGB());
		if (ListBar._visible == true) {
			eval(TrackName+".over_mc")._width = eval(TrackName+".Movie"+Index)._width-eval(TrackName+".Movie"+Index)._height;
			eval(TrackName+".over_mc")._x = eval(TrackName+".Movie"+Index)._x+eval(TrackName+".Movie"+Index)._height;
		} else {
			eval(TrackName+".over_mc")._width = eval(TrackName+".Movie"+Index)._width;
			eval(TrackName+".over_mc")._x = eval(TrackName+".Movie"+Index)._x;
		}
		eval(TrackName+".over_mc")._height = eval(TrackName).TextToolTip.textHeight+10;
		eval(TrackName+".over_mc")._y = eval(TrackName+".Movie"+Index)._y;
		eval(TrackName+".over_mc")._visible = true;
		eval(TrackName+".samOver_mc")._x = eval(TrackName+".Sam"+Index)._x;
		eval(TrackName+".samOver_mc")._y = eval(TrackName+".Sam"+Index)._y;
		if (eval(TrackName+".Sam"+Index)._visible == true) {
			eval(TrackName+".samOver_mc").setMusicNote(eval(TrackName+".Sam"+Index).getMusicNote);
			if (eval(TrackName+".Sam"+Index+".Sample")._visible == true) {
				eval(TrackName+".samOver_mc.Sample")._visible = true;
				eval(TrackName+".samOver_mc.Music")._visible = false;
			} else {
				eval(TrackName+".samOver_mc.Sample")._visible = false;
				eval(TrackName+".samOver_mc.Music")._visible = true;
			}
			eval(TrackName+".samOver_mc")._visible = true;
		}
		eval(TrackName+".cartOver_mc")._x = eval(TrackName+".Cart"+Index)._x;
		eval(TrackName+".cartOver_mc")._y = eval(TrackName+".Cart"+Index)._y;
		if (eval(TrackName+".Cart"+Index)._visible == true) {
			eval(TrackName+".cartOver_mc")._visible = true;
		}
	}
}
function VisibleStar(Index) {
	for (var j = 1; j<=5; j++) {
		if (j<=Index) {
			eval(TrackName+".BackStars.Star"+j)._visible = true;
		} else {
			eval(TrackName+".BackStars.Star"+j)._visible = false;
		}
	}
	DisplayToolTipStar(true);
}
function TrackInfo(Index) {
	VisibleInfo("true");
	VisibleStar(parseInt(resultSearch[Index].Rating, 10));
	if (ChangeLan == "Eng") {
		eval(TrackName).Artist.text = resultSearch[Index].Artist;
		eval(TrackName).Album.text = resultSearch[Index].Album;
	} else {
		if (getKhmerCountry(resultSearch[Index].Lan) == "0") {
			eval(TrackName).Artist.text = resultSearch[Index].Artist;
			eval(TrackName).Album.text = resultSearch[Index].Album;
		} else {
			eval(TrackName).Artist.text = resultSearch[Index].unicodeArtist;
			eval(TrackName).Album.text = resultSearch[Index].unicodeAlbum;
		}
	}
	eval(TrackName).TrackLen.text = resultSearch[Index].YearTrack+"   "+resultSearch[Index].LanTrack;
	if (resultSearch[Index].Mode == "Internal") {
		eval(TrackName).TrackNo.text = "Track # "+resultSearch[Index].NoTrack;
	} else {
		eval(TrackName).TrackNo.text = "Track # "+(Index+1);
	}
	ChangeTrackInfoFont(ChangeLan, resultSearch[Index].Lan);
}
var IndexTrack = 0;
function ReloadTrackPage() {
	for (var j = 0; j<nTrack; j++) {
		if (nTrack == 12) {
			yTrack[j] = eval(TrackName+".Movie"+j)._y-5;
		} else {
			yTrack[j] = eval(TrackName+".Movie"+j)._y-5-TrackNameOffset;
		}
	}
	eval(TrackName).ButtonRight.onRollOver = function() {
		SelectButton(TrackName+".MovieRight");
		SelectLevel = 3;
	};
	NumLeftTrack = 0;
	eval(TrackName).BackStars.Back.onRollOut = function() {
		VisibleStar(parseInt(resultSearch[RecordIndexTrack].Rating, 10));
	};
	//=========================VLC Default===========
	eval(TrackName).DefaultVLC.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).DefaultVLC.Button.onRollOver = function() {
		DisplayToolTipStar(true);
		SelectButton(TrackName+".DefaultVLC.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Restore setting of VLC", SHTT, -(117.3/2)-70, 30);
	};
	eval(TrackName).DefaultVLC.Button.onRelease = function() {
		fscommand("DefaultVLC","");	
	};

	//======================
	eval(TrackName).RefreshCoverArt.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).RefreshCoverArt.Button.onRollOver = function() {
		DisplayToolTipStar(true);
		SelectButton(TrackName+".RefreshCoverArt.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Refresh Cover Art", SHTT, -(117.3/2)-70, 30);
	};
	eval(TrackName).RefreshCoverArt.Button.onRelease = function() {
		if (NoInternetConnected == "0") {
			IndexAlbumForDownLoad = IndexTrack;
			if (ClickAlbum) {
				fscommand("RefreshCoverArt", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan);
			} else {
				fscommand("RefreshCoverArt", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].LanPath+"%~%"+resultSearch[IndexTrack].Lan);
			}
		}
	};
	//=========
	eval(TrackName).PathSlideshow.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).PathSlideshow.Button.onRollOver = function() {
		DisplayToolTipStar(true);
		SelectButton(TrackName+".PathSlideshow.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Browse Slideshow Path", SHTT, -(117.3/2)-70, 30);
	};
	eval(TrackName).PathSlideshow.Button.onRelease = function() {
		if (ClickAlbum) {
			fscommand("PathSlideshowAlbum", resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan);
		} else {
			fscommand("PathSlideshowAlbum", resultSearch[IndexTrack].LanPath+"%~%"+resultSearch[IndexTrack].Lan);
		}
	};
	//============== Search Player Page
	eval(TrackName).SearchPlayerPage.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).download_song.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).SearchPlayerPage.Button.onRollOver = function() {
		//***
		DisplayToolTipStar(true);
		SelectButton(TrackName+".SearchPlayerPage.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Search Album", SHTT, -(122/2)+5, -20);
	};
	eval(TrackName).download_song.Button.onRollOver = function() {
		//***
		DisplayToolTipStar(true);
		SelectButton(TrackName+".download_song.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Download All Songs In Player", SHTT, -(122/2)-70, -20);
	};
	//=====
	eval(TrackName).SearchPlayerPage.Button.onRelease = function() {
		if(!ClickAlbum){
			show_search_sel(!(eval(TrackName).SearchPlayerPage.MovieSel._visible));
		}
	};
	eval(TrackName).download_song.Button.onRelease = function() {
		fscommand("download_song");
	};
	//===============	
	for (var j = 1; j<=5; j++) {
		eval(TrackName+".BackStars.Button"+j).onRollOver = function() {
			var k = GetNumber(this._name);
			SelectButton(TrackName+".BackStars.Movie"+k);
			SelectLevel = 9;
			VisibleStar(k);
		};
		eval(TrackName+".BackStars.Button"+j).onRelease = function() {
			var k = GetNumber(this._name);
			resultSearch[IndexTrack].Rating = k;
			fscommand("SetRating", resultSearch[IndexTrack].trackID+StWave1+k+StWave1+resultSearch[IndexTrack].Lan+StWave1+IndexTrack);
			if (k == 4 || k == 5) {
				if (!(eval(TrackName+".Text"+(IndexTrack%nTrack)).textColor== SelectColorValue))
					{eval(TrackName+".Text"+(IndexTrack%nTrack)).textColor = ColorRating;}
				eval(TrackName+".Do"+(IndexTrack%nTrack)).textColor = ColorRating;
			} else {
				if (!(eval(TrackName+".Text"+(IndexTrack%nTrack)).textColor== SelectColorValue))
					{eval(TrackName+".Text"+(IndexTrack%nTrack)).textColor = FontColor;}
				eval(TrackName+".Do"+(IndexTrack%nTrack)).textColor = FontColor;
			}
		};
	}
	eval(TrackName).ButtonRight.onRelease = function() {
		if (send_event("normal&&&Click||"+this+"||4", false)) {
			return;
		}
		ClickRight(TrackObj);
		NumLeftTrack = eval("IndexShow"+TrackObj);
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
	};
	eval(TrackName).ButtonLeft.onRollOver = function() {
		SelectButton(TrackName+".MovieLeft");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonPlay.onRollOver = function() {
		SelectButton(TrackName+".MoviePlay");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonLeft.onRelease = function() {
		if (send_event("normal&&&Click||"+this+"||4", false)) {
			return;
		}
		ClickLeft(TrackObj);
		NumLeftTrack = eval("IndexShow"+TrackObj);
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
	};
	for (var j = 0; j<nTrack; j++) {
		//...............Shopping Cart...................
		eval(TrackName+".Cart"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Cart"+j).onRollOver = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			if (int(resultSearch[IndexTrack].ShoppingID)>0 && NoInternetConnected == "0") {
				DisplayTooltip(this, "txtTooltip", "Purchase Track Available", SHTT, -(117.3/2)+50, 20);
			} else {
				DisplayTooltip(this, "txtTooltip", "Purchase Track Not Available", SHTT, -(117.3/2)+50, 20);
			}
		};
		eval(TrackName+".Cart"+j).onRelease = function() {
			if (int(resultSearch[IndexTrack].ShoppingID)>0 && NoInternetConnected == "0") {
				fscommand("PurchaseTrack", resultSearch[IndexTrack].ShoppingID);
			}
		};
		//...............SAMPLE SONG ....................
		eval(TrackName+".Sam"+j).onRollOut = function() {
			//rollover left the selected rollover 2006-12-21 Seng
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOut();
			//
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Sam"+j).onRelease = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRelease();
		};
		eval(TrackName+".Sam"+j).onRollOver = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			if (resultSearch[IndexTrack].Ava != 0) {
				DisplayTooltip(this, "txtTooltip", "Track Available", SHTT, -(117.3/2)+50, 20);
			} else {
				if (resultSearch[IndexTrack].walMart_Ava == 0) {
					DisplayTooltip(this, "txtTooltip", "Song available over network", SHTT, -(117.3/2)+50, 20);
				} else {
					if (NoInternetConnected == "0") {
						DisplayTooltip(this, "txtTooltip", "Sample Song Available", SHTT, -(117.3/2)+50, 20);
					} else {
						DisplayTooltip(this, "txtTooltip", "Song available over network", SHTT, -(117.3/2)+50, 20);
					}
				}
			}
		};
		eval(TrackName+".Pic"+j).onRelease = function(){
			var k = GetNumber(this._name);
			eval(TrackName+".Button"+k).onRollOver();
			
		}
		//.....................
		eval(TrackName+".Button"+j).onRollOut = function() {
			TrackSel=false;
			var k = GetNumber(this._name);
			if (displayTwoLine_boo == true) {
				displayTwoLine_boo = false;
				eval(TrackName).TextToolTip._visible = false;
				eval(TrackName+".Text"+k)._visible = true;
				eval(TrackName+".Do"+k)._visible = true;
				eval(TrackName+".over_mc")._visible = false;
				eval(TrackName+".overCover_mc")._visible = false;
				eval(TrackName+".samOver_mc")._visible = false;
				eval(TrackName+".cartOver_mc")._visible = false;
			}
		};
		eval(TrackName+".Button"+j).onRollOver = function() {
			eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
			TrackSel=true;
			AlbumPicClick = "folder";
			SelectLevel = 3;
			var k = GetNumber(this._name);
			var k1 = eval("IndexShow"+TrackObj)+k;
			IndexTrack = k1;
			TrackInfo(k1);
			if (!ClickAlbum) {
				DisplayAlbumPictrueInfo(k1);
			}
			SelectButton(TrackName+".Movie"+k);
			ToolTip(eval(TrackName+".Movie"+k).storeText, eval(TrackName+".Text"+k)._x, eval(TrackName+".Text"+k)._y, k, resultSearch[k1].Lan);
		};
		eval(TrackName+".Button"+j).onRelease = function() {
			clientCount = Number(clientCount);
			if (this._visible) {
				if (_global.boolMouseDown == false) {
					return;
				}
				_global.boolMouseDown = false;
				//...................
				if ((((clienttype== remotecontrol or clientType == remotePlayList or clientType == clonePlayBack or clientType == independentMode) or (clientType == serverMode and clientCount>0)) and boolWaitForNextDelete == false) or (clientType == serverMode and clientCount<=0)) {
					if (clientCount>0 or clientType == remotePlaylist or clientType == clonePlayBack) {
						DelayFastClick();
					}
					var k = GetNumber(this._name);
					var k1 = int(eval("IndexShow"+TrackObj)+k);
					IndexTrack = k1;
					if (!ClickAlbum) {
						if (BackPlay.SelectMoveUp._visible) {
							eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
							fscommand("mini","MoveTrackUp|:|" + k1);
						} else if (BackPlay.SelectMoveDown._visible) {
							eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
							fscommand("mini","MoveTrackDown|:|" + k1);
						} else if (eval(TrackName).SearchPlayerPage.MovieSel._visible) {
							clickTrackSearch(k1);
						} else if (BackPlay.SelectDelOne._visible) {
							StartDeleteTrack();
							//fscommand("mini","Remove|:|" + k1)
							//eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
						} else {
							clearInterval(tmrIDPlayTrack)
							tmrIDPlayTrack=setInterval(SelectTrackDelay,500,k1);
						}
					} else {
						FuncPlayPage(k1, (PlayAll.Text.text == "One"));
					}
				}
			}
		};
	}
}
function FuncPlayPage(Index, FuncPlayMode) {
	if (clientType == serverMode or clientType == independentMode) {
		fscommand("saveOldTrackCount");
	} else {
		var track_xml = new XML();
		var root_xml;
		root_xml = track_xml.createElement("PlayList");
	}
	//if (FuncPlayMode == true) {
	//play from selected chapter to the end
	PutIndexPlayTrack(resultSearch, Index, root_xml);
	/*	} else {
			for (var k = Index; k<resultSearch.length; k++) {
				PutIndexPlayTrack(resultSearch, k, root_xml);
			}
			for (var k = 0; k<Index; k++) {
				PutIndexPlayTrack(resultSearch, k, root_xml);
			}
		}
		*/
	if (clientType == serverMode or clientType == independentMode) {
		fscommand("saveServerPlaylist");
	} else {
		track_xml.appendChild(root_xml);
		fscommand("savePlayTrack", track_xml);
		delete (track_xml);
	}
}
function PutIndexPlayTrack(result, k, doc_xml) {
	if (clientType == serverMode or clientType == independentMode) {
		var tt = result[k].trackTitle;
		var tu = result[k].unicodeTrackTitle;
		var art = result[k].Artist;
		var artu = result[k].unicodeArtist;
		var Album = result[k].Album;
		var Albumu = result[k].unicodeAlbum;
		var Stplayer = result[k].StPlayer;
		var Lan1 = result[k].Lan;
		var Md = result[k].Mood;
		var UniMd = result[k].unicodeMood;
		var Dan = result[k].danceStyle;
		var UniDan = result[k].unicodeDanceStyle;
		var Rat = result[k].Rating;
		var Gen = result[k].Genre;
		var UniGen = result[k].unicodeGenre;
		var Tid = result[k].trackID;
		var Pic = result[k].RePathPic;
		var ComName1 = result[k].ComName;
		var AlbumID = result[k].AlbumID;
		var ModeTrack = result[k].Mode;
		var LanTrack = result[k].LanTrack;
		var YearTrack = result[k].YearTrack;
		var Ava = result[k].Ava;
		var wal_Ava = result[k].walMart_Ava;
		var ShoppingID = result[k].ShoppingID;
		var trackNo=result[k].NoTrack;
		var bookMarkType=(playchapterfile=="False")? 4:0 ; 			//if the track is karaoke or music then make it like bookmark
		if(offsetEnabled){
			var seekOffset=result[k].seekOffset;
		}else{
			var seekOffset=0;
		}
		fscommand("PlayTrack", Tid+"~"+AlbumID+"~"+trackNo+"~"+Lan1+"~"+wal_Ava);
		fscommand("SendPathPic", result[k].PathPic);
		fscommand("SaveInPlayer", Stplayer+"&&&"+result[k].Mode+"&&&"+Lan1);
		fscommand("SaveInPlayList",new Array(Album,Albumu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,ModeTrack,Tid,Pic,Lan1,
												 ComName1,AlbumID,LanTrack,YearTrack,Ava,wal_Ava,ShoppingID,0,0,
												 0 , bookMarkType,0,0,0,0,0,0,seekOffset,0).join("%%"));
	} else {
		if (result[k].Ava != 0) {
			doc_xml.appendChild(createTrackXml(k));
		}
	}
}
//..........................BACK ALBUMPIC..............................
var StorePathPic = "";
function DisplayAlbumPictrueInfo(Index) {
	AlbumPicClick = "folder";
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	if (!ClickAlbum) {
		if (StorePathPic != resultSearch[Index].PathPic) {
			PicName[0] = resultSearch[Index].ReservePath;
			StorePathPic = PicName[0];
			BackAlbumPic.loadFadeImage(StorePathPic);
			//			Reset(1);
		}
		if (Index != 0) {
			StorePathPic = resultSearch[Index].PathPic;
		}
	} else {
		PicName[0] = resultAlbum[RecordIndexAlbum].ReservePath;
		BackAlbumPic.loadFadeImage(PicName[0]);
		//		Reset(1);
	}
	//
}
var AlbumPicClick = "folder";
BackAlbumPic.Button.onRollOver = function() {
	VisibleInfo("false");
	SelectButton("BackAlbumPic.Movie");
	SelectLevel = 3;
};
BackAlbumPic.Button.onRelease = function() {
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	if (AlbumPicClick == "folder") {
		if (NoInternetConnected == "0") {
			IndexAlbumForDownLoad = IndexTrack;
			if (ClickAlbum) {
				fscommand("DownLoadPic", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan);
			} else {
				fscommand("DownLoadPic", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].LanPath+"%~%"+resultSearch[IndexTrack].Lan);
			}
		}
		AlbumPicClick = "back";
		//PicName[0] =substring(resultSearch[IndexTrack].PathPic,0,resultSearch[IndexTrack].PathPic.length-10)+"back.jpg";
		PicName[0] = substring(resultSearch[IndexTrack].ReservePath, 0, resultSearch[IndexTrack].ReservePath.length-10)+"back.jpg";
	} else {
		AlbumPicClick = "folder";
		//PicName[0] = resultSearch[IndexTrack].PathPic;
		PicName[0] = resultSearch[IndexTrack].ReservePath;
	}
	//Reset(1);
	BackAlbumPic.loadFadeImage(PicName[0]);
};
//........................FUNCTION SELECTED..................
function SelectedItem(Obj, Index, Index1) {
	ChangeCurIndexTrack = Index1;
	for (var j = 0; j<nTrack; j++) {
		eval(Obj+".Text"+j).textColor = FontColor;
	}
	fscommand("reply", "Change here");
	eval(Obj+".Text"+Index).textColor = SelectColorValue;
}
function DeselectedItem(Obj, IndexShow, Index) {
	if (ClickAlbum) {
		for (var j = 0; j<nTrack; j++) {
			if (resultSearch[IndexShow+j].Rating == 4 || resultSearch[IndexShow+j].Rating == 5) {
				eval(Obj+".Text"+j).textColor = ColorRating;
				eval(Obj+".4"+j).textColor = ColorRating;
			} else {
				eval(Obj+".Text"+j).textColor = FontColor;
				eval(Obj+".Do"+j).textColor = FontColor;
			}
		}
	} else {
		for (var j = 0; j<nTrack; j++) {
			if(IndexShow+j<resultSearch.length){			//2006-01-07
				eval(Obj+".Sam"+j).setMusicNote(resultSearch[IndexShow+j].Ava, resultSearch[IndexShow+j].walMart_Ava, (IndexShow+j) == Index);
				if ((IndexShow+j) == Index) {
					eval(Obj+".Text"+j).textColor = SelectColorValue;
					eval(Obj+".Do"+j).textColor = SelectColorValue;
				} else {
					/*				
									if(setMusicNote(resultSearch[IndexShow+j].Ava==0){
									}
					*/
					//				eval(Obj+".Sam"+j).setMusicNote(resultSearch[IndexShow+j].Ava);
					if (resultSearch[IndexShow+j].Rating == 4 || resultSearch[IndexShow+j].Rating == 5) {
						eval(Obj+".Text"+j).textColor = ColorRating;
						eval(Obj+".Do"+j).textColor = ColorRating;
					} else {
						eval(Obj+".Text"+j).textColor = FontColor;
						eval(Obj+".Do"+j).textColor = FontColor;
					}
				}
			}
		}
	}
}
//...........................................BUTTONPLAY........................................
BackPlay.ButtonAlbum.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonAlbum.onRollOver = function() {
	SelectButton("BackPlay.MovieAlbum");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Search Track", SHTT, -(117.3/2)-100, 30);
};
BackPlay.ButtonDelOne.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonDelOne.onRollOver = function() {
	SelectButton("BackPlay.MovieDelOne");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Delete One Track", SHTT, -(122/2)+5, -20);
};
BackPlay.ButtonDelAll.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonDelAll.onRollOver = function() {
	SelectButton("BackPlay.MovieDelAll");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Delete All Tracks", SHTT, -(122/2)+5, -20);
};
BackPlay.ButtonMoveUp.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonMoveUp.onRollOver = function() {
	SelectButton("BackPlay.MovieMoveUp");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Move Up Track", SHTT, -(122/2)+5, -20);
};
BackPlay.ButtonMoveDown.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonMoveDown.onRollOver = function() {
	SelectButton("BackPlay.MovieMoveDown");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Move Down Track", SHTT, -(122/2)+5, -20);
};
BackPlay.ButtonSave.onRollOut = function() {
	HideTooltip("txtTooltip");
};
BackPlay.ButtonSave.onRollOver = function() {
	SelectButton("BackPlay.MovieSave");
	SelectLevel = 4;
	DisplayTooltip(this, "txtTooltip", "Save Playlist", SHTT, -(122/2)+5, -20);
};
//....................release..........................
BackPlay.ButtonAlbum.onRelease = function() {
	//***
	VisibleSearchBox();
	PlaySelected("");
};
BackPlay.ButtonDelOne.onRelease = function() {
	if (BackPlay.SelectDelOne._visible) {
		PlaySelected("");
	} else {
		PlaySelected("BackPlay.SelectDelOne");
	}
};
BackPlay.ButtonDelAll.onRelease = function() {
	PlaySelected("");
	DelAll._visible = true;
	Cover._visible = true;
	DelAll.ButtonOk.onRollOver();
};
BackPlay.ButtonMoveUp.onRelease = function() {
	if (BackPlay.SelectMoveUp._visible) {
		PlaySelected("");
	} else {
		PlaySelected("BackPlay.SelectMoveUp");
	}
};
BackPlay.ButtonMoveDown.onRelease = function() {
	if (BackPlay.SelectMoveDown._visible) {
		PlaySelected("");
	} else {
		PlaySelected("BackPlay.SelectMoveDown");
	}
};
BackPlay.ButtonSave.onRelease = function() {
	GetPathNane();
	Save.Text0.text = "Playlist";		//change to play list in save playlist
	Save.Text.text = SetPlayListSlidePath;
	Save.ShowSave(false);
	Save.ButtonOk.onRollOver();
	Cover._visible = true;
};
Save.ButtonAppand.onRollOver = function() {
	SelectButton("Save.MovieAppand");
};
Save.ButtonOverwrite.onRollOver = function() {
	SelectButton("Save.MovieOverwrite");
};
Save.ButtonOk.onRollOver = function() {
	SelectButton("Save.MovieOk");
};
Save.ButtonCancel.onRollOver = function() {
	SelectButton("Save.MovieCancel");
};
Save.ButtonSlide.onRollOver = function() {
	SelectButton("Save.MovieSlide");
};
Save.ButtonMode.onRollOver = function() {
	SelectButton("Save.MovieMode");
};
Save.MenuMode.ButtonTrack.onRollOver = function() {
	SelectButton("Save.MenuMode.MovieTrack");
};
Save.MenuMode.ButtonAlbum.onRollOver = function() {
	SelectButton("Save.MenuMode.MovieAlbum");
};
Save.MenuMode.ButtonArtist.onRollOver = function() {
	SelectButton("Save.MenuMode.MovieArtist");
};
Save.ButtonSlide.onRelease = function() {
	fscommand("SetSlideShowPath", Save.Text.text);
};
Save.ButtonMode.onRelease = function() {
	if (Save.MenuMode._visible) {
		Save.MenuMode._visible = false;
	} else {
		Save.MenuMode._visible = true;
	}
};
Save.MenuMode.ButtonTrack.onRelease = function() {
	Save.TextMode.text = "TrackTitle";
	Save.ButtonMode.onRollOver();
	Save.MenuMode._visible = false;
};
Save.MenuMode.ButtonAlbum.onRelease = function() {
	Save.TextMode.text = "Album";
	Save.MenuMode._visible = false;
	Save.ButtonMode.onRollOver();
};
Save.MenuMode.ButtonArtist.onRelease = function() {
	Save.TextMode.text = "Artist";
	Save.MenuMode._visible = false;
	Save.ButtonMode.onRollOver();
};
DelAll.ButtonOk.onRollOver = function() {
	SelectButton("DelAll.MovieOk");
};
DelAll.ButtonCancel.onRollOver = function() {
	SelectButton("DelAll.MovieCancel");
};
DelAll.ButtonOk.onRelease = function() {
	//fn_remove_all_tracks();
	fscommand("mini","RemoveAll|:|true");
	DelAll._visible = false;
	Cover._visible = false;
};
function fn_remove_all_tracks() {
//	if (send_event("removeAllTracks&&&function||fn_remove_all_tracks||4", true)) {
//		return;
//	}
	resultSearch.length = 0;
	RemovekAllTrack();
	FirstDisplayTrack(0);
	TopBar.ButtonM.onRollOver();
	AlbumBar._visible = false;
	mini._visible = true;
	for (i=0; i<nTrack; i++) {
		eval(TrackName+".Button"+i)._visible = false;
		eval(TrackName+".sam"+i)._visible = false;
		eval(TrackName+".pic"+i)._visible = false;
		eval(TrackName+".Text"+i)._visible = false;
		eval(TrackName+".Cart"+i)._visible = false;
		eval(TrackName+".Artist"+i)._visible = false;
		eval(TrackName+".Movie"+i)._visible = false;
	}
}
DelAll.ButtonCancel.onRelease = function() {
	DelAll._visible = false;
	Cover._visible = false;
	BackPlay.ButtonDelAll.onRollOver();
};
//..........
var Overwrite = "true";
Save.ButtonAppand.onRelease = function() {
	Save.ButtonAppand.Selected._visible = true;
	Save.ButtonOverwrite.Selected._visible = false;
	Overwrite = "false";
};
Save.ButtonOverwrite.onRelease = function() {
	Save.ButtonAppand.Selected._visible = false;
	Save.ButtonOverwrite.Selected._visible = true;
	Overwrite = "true";
};
Save.ButtonOk.onRelease = function() {
	if (Save.Text0.text.length>0) {
		if(Save.BookMark==false){
			fscommand("SaveTrack",   SetPlayListDir+StWave1+Save.Text0.text+StWave1+Save.Text.text+StWave1+Overwrite+StWave1+Save.TextMode.text+StWave1+Save.TextPath.text);
		}else{
			if(!isNaN(Save.Bookmark_mc.txtTime.text) or Save.BookMarkType!=3 ){
				fscommand("SaveBookMark",SetPlayListDir+"||"+Save.Text0.text+"||"+Save.Text.text+"||"+Overwrite+"||"+Save.TextMode.text+"||"+Save.TextPath.text+"||"+Save.DataInput+"||"+Save.BookMarkType+"||"+Save.Bookmark_mc.txtTime.text);
			}else{
				Selection.setFocus("Save.txtTime");
				Selection.setSelection(0,Save.txtTime.text.length);
				//error time not in secod
				return;
			}
		}
		Save._visible = false;
		Cover._visible = false;
		KeyBoard._visible = false;
		BackPlay.ButtonSave.onRollOver();
		
	}
};
Save.ButtonCancel.onRelease = function() {
	Save._visible = false;
	Cover._visible = false;
	KeyBoard._visible = false;
	BackPlay.ButtonSave.onRollOver();
	fscommand("ShowHidePlayer",true);

};
function PlaySelected(Obj) {
	BackPlay.SelectDelOne._visible = false;
	BackPlay.SelectDelAll._visible = false;
	BackPlay.SelectMoveUp._visible = false;
	BackPlay.SelectMoveDown._visible = false;
	BackPlay.SelectAlbum._visible = false;
	eval(Obj)._visible = true;
}
var RecordIndexTrack = 0;
var RecordLevelTrack = 0;
//........................DISABLED WHEN BOX POPUP.................
Cover._visible = false;
Cover.useHandCursor = false;
Cover.tabEnabled = false;
function SortMasterMoveUpDown(Indexs, Move) {
	var old_Length=resultSearch.length;
	resultSearch.length=0;
	resultSearch.length=old_Length;
	Indexs = int(Indexs);
	if (resultSearch.length<=1) {
		return;
	}
	var tempArr = resultSearch[Indexs];
	if (Move == "Up") {
		var newIndex = int(Indexs-1);
		newIndex = (newIndex<0) ? (resultSearch.length-1) : newIndex;
//		resultSearch[Indexs] = resultSearch[newIndex];
//		resultSearch[newIndex] = tempArr;
		if (RecordIndexTrack == Indexs) {
			RecordIndexTrack == newIndex;
		}
		fscommand("MoveUp", Indexs);
	} else {
		var newIndex = (Indexs+1)%resultSearch.length;
//		resultSearch[Indexs] = resultSearch[newIndex];
//		resultSearch[newIndex] = tempArr;
		if (RecordIndexTrack == Indexs) {
			RecordIndexTrack == newIndex;
		}
		fscommand("MoveDown", Indexs);

	}
	MoveIndex(Indexs, Move);
	delete (tempArr);
	//refresh Display
//	eval(TrackName+".Text"+ Indexs%nTrack).text = resultSearch[Indexs];
	//eval(TrackName+".Text"+ newIndex%nTrack).text = resultSearch[newIndex];
//	fscommand("mb","Reresh track");
	DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack,false);
	//	}
}

Save.ButtonPath.onRollOver = function() {
	SelectButton("Save.MoviePath");
};
Save.ButtonPath.onRelease = function() {
	if (Save.MenuPath._visible) {
		Save.MenuPath._visible = false;
	} else {
		Save.MenuPath._visible = true;
	}
};
var nMenu = 5;
function FirstDisplayPath(n) {
	if (n<=nMenu) {
		Save.MenuPath.ButtonLeft._visible = false;
		Save.MenuPath.ButtonRight._visible = false;
		Save.MenuPath.MovieBar._visible = false;
		Save.MenuPath.MovieLeft._visible = false;
		Save.MenuPath.MovieRight._visible = false;
	} else {
		Save.MenuPath.ButtonLeft.enabled = true;
		Save.MenuPath.ButtonRight.enabled = true;
		Save.MenuPath.MovieBar._visible = true;
		Save.MenuPath.MovieLeft._visible = true;
		Save.MenuPath.MovieRight._visible = true;
	}
	if (n>0) {
		FirstDisplay("Path", n, nMenu);
		DisplayItemPath("Save.MenuPath", IndexShowPath, CountPath, nMenu);
	} else {
		for (var j = 0; j<nMenu; j++) {
			eval("Save.MenuPath.Movie"+j)._visible = false;
			eval("Save.MenuPath.Button"+j)._visible = false;
			eval("Save.MenuPath.Text"+j)._visible = false;
		}
		Save.MenuPath.ButtonLeft._visible = false;
		Save.MenuPath.ButtonRight._visible = false;
		Save.MenuPath.MovieBar._visible = false;
		Save.MenuPath.MovieLeft._visible = false;
		Save.MenuPath.MovieRight._visible = false;
	}
}
function DisplayItemPath(Obj, Index, Count, nItem) {
	for (var j = 0; j<nItem; j++) {
		if (j<Count) {
			eval(Obj+".Movie"+j)._visible = true;
			eval(Obj+".Button"+j)._visible = true;
			eval(Obj+".Text"+j)._visible = true;
			eval(Obj+".Text"+j).text = PathNameArr[Index+j];
		} else {
			//eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible = false;
			eval(Obj+".Text"+j)._visible = false;
		}
	}
}
eval("Save.MenuPath.ButtonLeft").onRollOver = function() {
	SelectButton("Save.MenuPath.MovieLeft");
	SelectLevel = 4;
};
eval("Save.MenuPath.ButtonRight").onRollOver = function() {
	SelectButton("Save.MenuPath.MovieRight");
	SelectLevel = 4;
};
eval("Save.MenuPath.ButtonRight").onRelease = function() {
	ClickRight("Path");
	DisplayItemPath("Save.MenuPath", IndexShowPath, CountPath, nMenu);
};
eval("Save.MenuPath.ButtonLeft").onRelease = function() {
	ClickLeft("Path");
	DisplayItemPath("Save.MenuPath", IndexShowPath, CountPath, nMenu);
};
for (var j = 0; j<nMenu; j++) {
	eval("Save.MenuPath.Button"+j).onRollOver = function() {
		var k = GetNumber(this._name);
		SelectButton("Save.MenuPath.Movie"+k);
		SelectLevel = 4;
	};
	eval("Save.MenuPath.Button"+j).onRelease = function() {
		var k = GetNumber(this._name);
		RecordIndexPath = IndexShowPath+k;
		Save.TextPath.text = eval("Save.MenuPath.Text"+k).text;
		Save.MenuPath._visible = false;
		Save.ButtonPath.onRollOver();
		SetPlayListDir = PathDirArr[RecordIndexPath];
	};
}
var PathNameArr = new Array();
var PathDirArr = new Array();
var RecordIndexPath = 0;
var SetPathName = "";
function GetPathNane() {
	var Xml = new XML();
	Xml.load(str_main_path_playlist+"\\PlayListPaths.xml");
	PathNameArr.length = 0;
	PathDirArr.length = 0;
	Xml.onLoad = function() {
		var n = Xml.childNodes[0].childNodes.length;
		for (var j = 0; j<n; j++) {
			PathNameArr[j] = Xml.childNodes[0].childNodes[j].attributes.Name;
			PathDirArr[j] = Xml.childNodes[0].childNodes[j].childNodes[0].nodeValue;
			if (SetPlayListDir.toLowerCase() == PathDirArr[j].toLowerCase()) {
				RecordIndexPath = j;
			}
		}
		SetPlayListDir = PathDirArr[RecordIndexPath];
		SetPathName = PathNameArr[RecordIndexPath];
		Save.TextPath.text = SetPathName;
		FirstDisplayPath(PathNameArr.length);
	};
}
function RemovekAllTrack() {
	fscommand("RemoveAll");
	resultSearch.length = 0;
	FirstDisplay(TrackObj, 0, nTrack);
	FirstDisplayTrack(0);
	DelAll._visible = false;
	Cover._visible = false;
	//BackPlay.ButtonDelAll.onRollOver();
	TopBar.ButtonM.onRollOver();
	AlbumBar._visible = false;
	mini._visible = true;
}
function RemoveOneTrack(removeIndex) {
	removeIndex = parseInt(removeIndex, 10);
	if (resultSearch.length>removeIndex) {
		if (eval("Num"+TrackObj)>1) {
			fscommand("RemoveTrack", removeIndex);
		} else if (eval("Num"+TrackObj) == 1) {
			resultSearch.length = 0;
			fscommand("RemoveAll");
			FirstDisplayTrack(0);
		}
	}
}
//..............
ReloadTrackPage();
function move_track(val_index_track, str_type) {
	var k1 = val_index_track;
	IndexTrack = k1;
	if (str_type == "Up") {
		eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
		SortMasterMoveUpDown(k1, "Up");
	} else {
		eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
		SortMasterMoveUpDown(k1, "Down");
	}
}
function fn_remove_track_one_by_one(index_track) {
	if (send_event("remove_track_one_by_one&&&function||fn_remove_track_one_by_one|~|"+index_track+"||4", true)) {
		return;
	}
	eval(TrackName+".Button"+(index_track%nTrack)).onRollOut();
	RemoveOneTrack(index_track);
}
function DelayFastClick() {
	boolWaitForNextDelete = true;
	valueIntervalID = setInterval(setBoolValue, 700, "boolWaitForNextDelete", false);
}
function setBoolValue(variableName, value) {
	clearInterval(valueIntervalID);
	set(variableName, value);
}
function show_search_sel(val) {
	val = String(val);
	if (send_event("normal&&&function||show_search_sel|~|"+val+"||4", false)) {
		return;
	}
	eval(TrackName).SearchPlayerPage.MovieSel._visible = (val == "true") ? true : false;
}
function clickTrackSearch(index) {
	if (send_event("normal&&&function||clickTrackSearch|~|"+index+"||4", false)) {
		return;
	}
	index = int(index);
	if (resultSearch[index].Album.length>0) {
		SearchByAlbum(resultSearch[index].Album, false);
	} else {
		SearchByAlbum(resultSearch[index].unicodeAlbum, true);
	}
	eval(TrackName).SearchPlayerPage.MovieSel._visible = false;
}
function changeAvailable(changeList, fromComName) {
	var boolavailableChanged = false;
	changeList = changeList.split(",");
	for (i=0; i<changeList.length; i++) {
		for (j=0; j<resultSearch.length; j++) {
			if (changeList[i] == resultSearch[j].trackID and resultSearch[j].Ava == 0) {
				boolavailableChanged = true;
				resultSearch[j].Ava = 3;
				//refer to song download from server
				resultSearch[j].ComName = fromComName;
				resultSearch[j].DownloadFromServer = true;
			}
		}
	}
	if (boolavailableChanged) {
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
	}
	if (clientType == serverMode) {
		var available_array = new Array();
		for (var i = 0; i<resultSearch.length; i++) {
			if (resultSearch[i].Ava != 0 or resultSearch[i].ComName<>ComName) {
				available_array.push(resultSearch[i].trackID);
			}
		}
		fscommand("servers", "refreshTrackAvailable&&&"+available_array);
	}
	delete (boolavailableChanged);
	delete (available_array);
}

function ChangeUnicode(){
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
	DisplayTextAlbum("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum);
	if (BackAlbumInfo._visible) {
		ChangeAlbumInfoFont(ChangeLan, SaveAlbumInfo);
	}
}
function SelectTrackDelay(iIndex){
	fscommand("mini","SelectedPlaylist|:|"+iIndex);
	clearInterval(tmrIDPlayTrack);
}
