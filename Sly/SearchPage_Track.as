var TrackName = "ListBar";
var TrackObj = "List";
var IndexTrack = 0;

function DisplayItemTrack(Obj, Index, Count, nItem) {
	EngTextFormat.font = EngFont;
	EngTextFormat.size = EngSize;
	EngTextFormat.bold = false;
	UniTextFormat.font = UniFont;
	UniTextFormat.size = UniSize;
	UniTextFormat.bold = false;
	var strTrackInfo,strTrackInfoUnicode;		//for display name under track title

	for (var j = 0; j<nItem; j++) {
		objMovie = eval(Obj+".Movie"+j);
		objButton = eval(Obj+".Button"+j);
		objText = eval(Obj+".Text"+j);
		objDo = eval(Obj+".Do"+j);
		objArtist = eval(Obj+".Artist"+j); 
		objPic = eval(Obj+".Pic"+j);
		objCart = eval(Obj+".Cart"+j);
		objSam = eval(Obj+".Sam"+j);
		objSingType =   eval(Obj+".Singer"+j);
	
		if (j<Count) {
			objMovie._visible = true;
			objButton._visible = true;
			objText._visible = true;
			objDo._visible = true;
			objArtist._visible = true;
			objSingType._visible = true;
			//.............SAMPLE.................
			if (DisplayFromSearch==1) {
				var k = j;
			} else {
				k = Index+j;
			}

			if(iShowUnderTrackTitle==0){
				strTrackInfo	=String(resultSearch[k].Artist)
				strTrackInfoUnicode	=String(resultSearch[k].unicodeArtist)
			}else{
				strTrackInfo	=String(resultSearch[k].Production)
				strTrackInfoUnicode	=String(resultSearch[k].unicodeProduction)
			}
			if (resultSearch[k].Ava == 0) {
				//...........Purchase.....................
				if (resultSearch[k].ShoppingID.length>0 && NoInternetConnected == "0") {
					objCart._visible = true;
				} else {
					objCart._visible = false;
				}
				//........Samplie
				if (resultSearch[k].walMart_Ava == "0") {
					objSam._visible = false;
				} else {
					if (NoInternetConnected == "0") {
						eval(Obj+".Sam"+j+".Sample")._visible = true;
						eval(Obj+".Sam"+j+".Music")._visible = false;
						objSam._visible = true;
					} else {
						objSam._visible = false;
					}
				}
			} else {
				
				objCart._visible = false;
				objSam.setMusicNote(resultSearch[k].Ava);
			}
			//...........................................
			if (resultSearch[k].Rating == 4 || resultSearch[k].Rating == 5) {
				objText.textColor = ColorRating;
				eval(TrackName+".Do"+j).textColor = ColorRating;
			} else {
				objText.textColor = FontColor;
				eval(TrackName+".Do"+j).textColor = FontColor;
			}
			objArtist.textColor = SelectColorValue;
			objSingType.ShowSinger(resultSearch[k].SingType);
			
			
			//.................................
			//============================================
			objPic.Index = Index;
			var loadImagePath;
			//assign it index
			if (String(resultSearch[k].ReservePath)==""){
				objPic.ID		=	resultSearch[k].PathPic;
				loadImagePath	=	resultSearch[k].PathPic;
				fscommand("SearchPathImage",loadImagePath+"%~%"+"Chapter"+"%~%"+k+"%~%"+resultSearch[k].AlbumID+"%~%"+LanName);
				resultSearch[k].ReservePath=loadImagePath;
			}else{
				loadImagePath	=	resultSearch[k].ReservePath;
			}
			if (loadImagePath<>"") {
				objPic.loadFadeImage(loadImagePath);
			}
			var eng_boo = true;
			if (ChangeLan == "Eng") {
				boolEnglishFont = (strTrackInfo<>"");
				if (DisplayFromSearch==1) {
					objText.wordWrap = true;
					var tmpTrack_str = "";
					if (resultSearch[k].trackTitle == "") {
						eng_boo = false;
					}
					if (eng_boo == true) {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].trackTitle;
						objDo.text = "...";
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
						objDo.setTextFormat(EngTextFormat);
						objText.setTextFormat(EngTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Eng";
					} else {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].unicodeTrackTitle;
						objDo.text = "...";
						if (iKhmer!="1" ) {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						} else {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						}
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Uni";
					}
					objDo.autoSize = true;
					objDo._x = objText._x+objText.textWidth;
				} else {
					objText.wordWrap = true;
					var tmpTrack_str = "";
					var eng_boo = true;
					if (resultSearch[k].trackTitle == "") {
						eng_boo = false;
					}
					if (eng_boo == true) {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].trackTitle;
						objDo.text = "...";
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
						//,EngFont,EngSize);
						objDo.setTextFormat(EngTextFormat);
						objText.setTextFormat(EngTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Eng";
					} else {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].unicodeTrackTitle;
						objDo.text = "...";
						if (iKhmer!="1" ) {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						} else {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						}
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Uni";
					}
					objDo.autoSize = true;
					objDo._x = objText._x+objText.textWidth;
				}
			} else {
				eng_boo=false;
				boolEnglishFont = (strTrackInfoUnicode == "");
				if (DisplayFromSearch==1) {
					objText.wordWrap = true;
					var tmpTrack_str = "";
					if (resultSearch[k].unicodeTrackTitle == "") {
						eng_boo=true;
					}
					if (eng_boo == false) {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].unicodeTrackTitle;
						objDo.text = "...";
						if (iKhmer!="1" ) {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						} else {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						}
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Uni";
					} else {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].trackTitle;
						objDo.text = "...";
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
						//,EngFont,EngSize);
						objDo.setTextFormat(EngTextFormat);
						objText.setTextFormat(EngTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Eng";
					}
					objDo.autoSize = true;
					objDo._x = objText._x+objText.textWidth;
				} else {
					//					boolEnglishFont=(resultSearchTrack)
					objText.wordWrap = true;
					var tmpTrack_str = "";
					eng_boo=false;
					if (resultSearch[k].unicodeTrackTitle == "") {
						eng_boo=true;
					}
					if (eng_boo == false) {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].unicodeTrackTitle;
						objDo.text = "...";
						if (iKhmer!="1" ) {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						} else {
							objText.text = getTextOneLine(objText, tmpTrack_str, objDo, UniTextFormat);
						}
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Uni";
					} else {
						tmpTrack_str = (Index+j+1)+"."+resultSearch[k].trackTitle;
						objDo.text = "...";
						objText.text = getTextOneLine(objText, tmpTrack_str, objDo, EngTextFormat);
						//,EngFont,EngSize);
						objDo.setTextFormat(EngTextFormat);
						objText.setTextFormat(EngTextFormat);
						objMovie.storeText = tmpTrack_str;
						objMovie.storeLan = "Eng";
					}
					objDo.autoSize = true;
					objDo._x = objText._x+objText.textWidth;
				}
			}
			if(eng_boo){
				objText._y = yTrack[j]+parseInt(TrackPosEng, 10);				
			}else{
				objText._y = yTrack[j]+parseInt(TrackPosUni, 10);
			}
			objDo._y = objText._y;
			/////////Artist//////////			
			var objFont = new TextFormat();
			if (boolEnglishFont) {
				objArtist.text = strTrackInfo;
				objFont.font = EngTextFormat.font;
				objFont.size = FontEnglish;
			} else {
				objArtist.text =strTrackInfoUnicode;
				if (iKhmer=="1" ) {
					objFont.size = FontUnicodeKhmer;
					objFont.font = UniTextFormat.font;
				} else {
					objFont.size = FontUnicodeEnglish;
					objFont.font = UniTextFormat.font;
				}
			}
			objArtist.setTextFormat(objFont);
			delete (objFont);
			/////////Artist//////////				
		} else {
			objMovie._visible = false;
			objButton._visible = false;
			objText._visible = false;
			objDo._visible = false;
			objSam._visible = false;
			objCart._visible = false;
			objArtist._visible = false;
			objSingType._visible = false;
			objPic.unloadFadeImage();
		}
	}
	ChangeTrackFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
}
var SelectMode = "";
function FirstDisplayTrack(n) {
	//nTrack=eval(TrackName).CountTrack;
	eval(TrackName).FlagGroup.ShowFlag(resultSearchArtistAlbum[RecordIndexArtistAlbum].FlagID);
	ReloadTrackPage();

	if (Isregistered == "False") {
		BackAlbumPic.Logo._visible = true;
	} else {
		BackAlbumPic.Logo._visible = false;
	}
	if (n>0) {
		eval(TrackName)._visible = true;
		BackAlbumPic._visible = true;
		//eval(TrackName).ShowPlayer._visible=true;
		DisplayAlbumPictrueInfo();
		FirstDisplay(TrackObj, n, nTrack);
		eval(TrackName).PlusIcon._visible = false;
		if (DisplayFromSearch==1) {
			eval(TrackName).ButtonPlay._visible = true;
			eval(TrackName).Sadow._visible = true;
			VisiblePlay(false);
			eval(TrackName).CDIcon._visible = false;
			eval(TrackName).Rank._visible = false;
		} else {
			//eval(TrackName).PlusIcon._visible = true;
			if (resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav == "1") {
				eval(TrackName).PlusIcon.Selected._visible = true;
				eval(TrackName).Rank._visible = true;
			} else {
				eval(TrackName).PlusIcon.Selected._visible = false;
				eval(TrackName).Rank._visible = false;
			}
			if (resultSearchArtistAlbum[RecordIndexArtistAlbum].Ava == "1") {
				eval(TrackName).CDIcon._visible = true;
			} else {
				eval(TrackName).CDIcon._visible = false;
			}
			eval(TrackName).Rank.Text.text = resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank;
			VisiblePlay(true);
			eval(TrackName).ButtonPlay._visible = false;
			eval(TrackName).Sadow._visible = false;
		}
		DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);		
	} else {
		eval(TrackName)._visible = false;
		BackAlbumPic._visible = false;
		VisiblePlay(false);
	}
    eval(TrackName).DD._visible= (resultSearchArtistAlbum[RecordIndexArtistAlbum].AudioID.indexOf(";1;")>=0)  //and  (NumCover == "Yes")
	eval(TrackName).DTS.Available=(resultSearchArtistAlbum[RecordIndexArtistAlbum].AudioID.indexOf(";3;")>=0);
    eval(TrackName).DTS._visible=eval(TrackName).DTS.Available;
	
	
}
function VisibleInfo(Value) {
	VisibleIconAlbum(boolShowCoverIcon)
	if(boolShowCoverIcon){
		DisplayToolTipStar(true)
	}
/*
	if (Value == "true") {
		var b = true;
		//DisplayToolTipStar(true);
		DisplayToolTipTrack(b);
	} else {
		var b = false;
	}
	eval(TrackName).CoverTrackInfo._visible = b;
	eval(TrackName).TrackLen._visible = b;
	eval(TrackName).Mood._visible = b;
	//Album 
	eval(TrackName).Dance._visible = b;
	// Total result
	eval(TrackName).Artist._visible = b;
	eval(TrackName).Year._visible = b;
*/
}
function FadeTooltipTrack() {
	clr += 10;
	if (clr>=50) {
		eval(TrackName+".Button"+IndexTrack).onRollOut();
		VisibleInfo(false);
		clearInterval(clearToolTip1);
	}
}
function ToolTip(St, X, Y, Index) {
	eval(TrackName).TextToolTip._visible = false;
	eval(TrackName).TextToolTip.text = St;
	eval(TrackName).TextToolTip._width = eval(TrackBar+".Movie"+Index)._width-(eval(TrackName).TextToolTip._x-eval(TrackBar+".Movie"+Index)._x);
	eval(TrackName).TextToolTip._height = eval(TrackName+".Text"+Index)._height;
	eval(TrackName).TextToolTip.wordWrap = true;
	eval(TrackName).TextToolTip.autoSize = true;
	if (eval(TrackName+".Movie"+Index).storeLan == "Eng") {
		eval(TrackName).TextToolTip.setTextFormat(EngTextFormat);
	} else {
		eval(TrackName).TextToolTip.setTextFormat(UniTextFormat);
	}
	//	if (eval(TrackName).TextToolTip._width>eval(TrackName+".Text"+Index)._width) {
	if (eval(TrackName+".Do"+Index)._visible == true && eval(TrackName+".Do"+Index).text != "") {
		displayTwoLine_boo = true;
		eval(TrackName).TextToolTip._x = X;
		eval(TrackName).TextToolTip._y = Y;
		eval(TrackName).TextToolTip._visible = true;
		//eval(TrackName+".Text"+Index)._visible = false;
		//eval(TrackName+".Do"+Index)._visible = false;
		//eval(TrackName+".Movie"+Index)._width = eval(TrackName).TextToolTip._width+65;
		//eval(TrackName+".Button"+Index)._width = eval(TrackName).TextToolTip._width+65;
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
//	DisplayToolTipStar(true);
}
function TrackInfo(Index) {
	VisibleInfo("true");
	RecordIndexTrack	=Index;
	eval(TrackName).TrackLen.text = resultSearch[Index].Length;
	eval(TrackName).offset.txt.text = resultSearch[Index].SeekOffset;
	
	VisibleStar(parseInt(resultSearch[Index].Rating, 10));

	if (ChangeLan == "Eng") {
		eval(TrackName).Artist.text = resultSearch[Index].Artist;
	} else {
		eval(TrackName).Artist.text = resultSearch[Index].unicodeArtist;
	}
	if (DisplayFromSearch==1) {
		eval(TrackName).PlusIcon._visible = false;
		textUnicode= resultSearch[Index].unicodeAlbum
		textEnglish  = resultSearch[Index].Album
		eval(TrackName).Year.text = " Results Found: "+eval("Num"+TrackObj)+"\n"+resultSearch[Index].YearTrack+"   "+resultSearch[Index].LanTrack;
	} else {
		textUnicode= resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist
		textEnglish  = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist
		eval(TrackName).Year.text = resultSearch[Index].Length+"   "+resultSearchArtistAlbum[RecordIndexArtistAlbum].Year+"\n"+resultSearch[Index].LanTrack;
	}

	var lanAlbum = "Eng",lanArtist="Eng"
	var fontFormat = new TextFormat();
	if (ChangeLan=="Eng") {
		if (textEnglish==""){
			lanAlbum="Uni"
		}else{
			lanAlbum="Eng"
		}
		if(resultSearch[Index].Artist ==""){
			lanArtist="Uni"
		}else{
			lanArtist="Eng"
		}
	} else {
		if(textUnicode==""){
			lanAlbum="Eng"
		}else{
			lanAlbum="Uni"
		}
		if(resultSearch[Index].unicodeArtist == ""){
			lanArtist="Eng"
		}else{
			lanArtist="Uni"
		}
	}
	eval(TrackName).Mood.text   = (lanAlbum  == "Eng" ) ? textEnglish 			: textUnicode;
	eval(TrackName).Artist.text = (lanArtist == "Eng" ) ? resultSearch[Index].Artist 	: resultSearch[Index].unicodeArtist;

	fontFormat = getFontFormat(EngFont, UniFont, EngSize, UniSize, lanArtist)		
	eval(TrackName).Artist.setTextFormat(fontFormat);

	fontFormat = getFontFormat(EngFont, UniFont, EngSize, UniSize, lanAlbum )
	eval(TrackName).Mood.setTextFormat(fontFormat);

	ChangeTrackInfoFont(EngFont, UniFont, EngSize, UniSize, "Eng");
}
var ModeTrack = "Internal";
function FuncPlayOne(Index,doc_xml) {
	if(resultSearch[Index].Ava!=0 or MusicNote=="true"){// or resultSearchTrack[Index].ComName<>ComName or (resultSearchTrack[Index].walMart_Ava<>0 and NoInternetConnected=="0")){
		var album	=	resultSearch[Index].Album;
		var albumu	=	resultSearch[Index].unicodeAlbum;
		var tt		=	resultSearch[Index].trackTitle;//album//resultSearch[Index].trackTitle;
		var tu		=	resultSearch[Index].unicodeTrackTitle;//albumu///resultSearch[Index].unicodeTrackTitle;
		var art		=	resultSearch[Index].Artist;
		var artu		=	resultSearch[Index].unicodeArtist;
		var Md		=	"";//resultSearchTrack[Index].Mood;
		var UniMd		=	"";//resultSearchTrack[Index].unicodeMood;
		var Dan		=	"";//resultSearchTrack[Index].danceStyle;
		var UniDan	=	"";//resultSearchTrack[Index].unicodeDanceStyle;
		var Gen		=	"";//resultSearchTrack[Index].Genre;
		var UniGen	=	"";//resultSearchTrack[Index].unicodeGenre;
		var ShoppingID	=	"";//resultSearchTrack[Index].ShoppingID;
		var walMart_Ava	=	0;//resultSearchTrack[Index].walMart_Ava;
		var Lan1		=	LanName;//Language of that Movie
		var ComName1	=	resultSearch[Index].ComName;//ComName;//resultSearchTrack[Index].ComName;
		var LanTrack	=	resultSearch[Index].LanTrack;//LanName;//resultSearchTrack[Index].LanTrack;
		var Rat		=	resultSearch[Index].Rank;
		var Tid		=	resultSearch[Index].TrackID;//resultSearchTrack[Index].trackID;
		var Pic		=	resultSearch[Index].StringPath;
		var LanPath1	=	resultSearch[Index].AlbumID;
		var YearTrack	=	resultSearch[Index].Year;
		var TrackAva	=	resultSearch[Index].Ava;
		var bookMarkType	=	(playchapterfile=="False")? 4:0; 
		var AudioChannel	=	(databaseType==8) ? playAudioChannel:0;
		fscommand("PlayTrack",Tid+"~"+resultSearch[Index].AlbumID+"~"+resultSearch[Index].NoTrack+"~"+LanName+"~"+resultSearch[Index].walMart_Ava);
		if(offsetEnabled){
			var seekOffset=resultSearch[Index].seekOffset;
		}else{
			var seekOffset=0;
		}
		if (clientType==serverMode or clientType==independentMode){
			fscommand("SendPathPic",resultSearch[Index].PathPic);
			fscommand("SaveInPlayer",tt+StOr+tu+StPer+album+StOr+albumu+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
			fscommand("SaveInPlayList",new Array(album,albumu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,ModeTrack,Tid,Pic,Lan1,
												 ComName1,LanPath1,LanTrack,YearTrack,TrackAva,walMart_Ava,ShoppingID,0,0,
												 0 ,bookMarkType,0,0,0,0,0,AudioChannel,seekOffset,0).join("%%"));
		}else{
			doc_xml.appendChild(createTrackXml(Index,bookMarkType,AudioChannel,seekOffset,0));
		}
	}
}
function FuncPlayAll(Index,PlayOne) {
	if (clientType==serverMode or clientType==independentMode){
		fscommand("saveOldTrackCount");
	}else{
		var track_xml = new XML();
		var root_xml;
		root_xml=track_xml.createElement("PlayList");
	}
	if (PlayOne==true){
		FuncPlayOne(Index,root_xml);
	} else{
		for (var j = Index; j<eval("Count"+TrackObj); j++) {
			FuncPlayOne(j,root_xml);
		}
		for (var j = 0; j<Index; j++) {
			FuncPlayOne(j,root_xml);
		}
	}
	if (clientType==serverMode or clientType==independentMode){
		fscommand("saveServerPlaylist");
	}else{
		track_xml.appendChild(root_xml);
		fscommand("savePlayTrack",track_xml);
		delete(track_xml);
	}
}
function FuncPlayOneAlbum(Index,doc_xml) {
	var tt		=	resultSearch[Index].trackTitle;
	var tu		=	resultSearch[Index].unicodeTrackTitle;
	var art		=	resultSearch[Index].Artist;
	var artu		=	resultSearch[Index].unicodeArtist;
	var album		=	resultSearch[Index].Album;
	var albumu	=	resultSearch[Index].UniAlbum;
	var Md		=	"";//resultSearchTrack[Index].Mood;
	var UniMd		=	"";//resultSearchTrack[Index].unicodeMood;
	var Dan		=	"";//resultSearchTrack[Index].danceStyle;
	var UniDan	=	"";//resultSearchTrack[Index].unicodeDanceStyle;
	var Gen		=	"";//resultSearchTrack[Index].Genre;
	var UniGen	=	"";//resultSearchTrack[Index].unicodeGenre;
	var ShoppingID	=	"";//resultSearchTrack[Index].ShoppingID;
	var walMart_Ava	=	0;//resultSearchTrack[Index].walMart_Ava;
	var Lan1		=	LanName;//Language of that Movie
	var ComName1	=	resultSearch[Index].ComName;//resultSearchTrack[Index].ComName;
	var LanTrack	=	LanName;//resultSearchTrack[Index].LanTrack;
	var Rat		=	resultSearch[Index].Rating;//resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank;//resultSearchTrack[Index].Rating;
	var Tid		=	resultSearch[Index].trackID;
	var Pic		=	resultSearch[Index].StringPath;
	var LanPath1	=	resultSearchArtistAlbum[RecordIndexArtistAlbum].id;
	var YearTrack	=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Year;
	var TrackAva	=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Ava;
	var bookMarkType	=	(playchapterfile=="False" and databaseType==8)? 4:0 ;
	var AudioChannel	=	(databaseType==8) ? playAudioChannel:0;
	var trackNo	=	resultSearch[Index].trackno;
	if(offsetEnabled){
		var seekOffset=resultSearch[Index].seekOffset;
	}else{
		var seekOffset=0;
	}
	if (clientType==serverMode or clientType==independentMode){
		fscommand("PlayTrack",resultSearch[Index].trackID+"~"+resultSearch[Index].AlbumID+"~"+trackNo+"~"+LanName+"~"+resultSearch[Index].walMart_Ava);
		fscommand("SendPathPic",resultSearchArtistAlbum[RecordIndexArtistAlbum].Path);
		fscommand("SaveInPlayer",tt+StOr+tu+StPer+album+StOr+album+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
		fscommand("SaveInPlayList",new Array(StoreAlbum,StoreUniAlbum,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,ModeTrack,Tid,Pic,Lan1,
												 ComName1,LanPath1,LanTrack,YearTrack,TrackAva,walMart_Ava,ShoppingID,0,0,
												 0 ,bookMarkType,0,0,0,0,0,AudioChannel,seekOffset,0).join("%%"));
	}else{
		doc_xml.appendChild(createTrackXml(Index,bookMarkType,AudioChannel,seekOffset,0));
	}
}
function FuncPlayAllAlbum(Index,PlayOne) {
	if (clientType==serverMode or clientType==independentMode){
		fscommand("saveOldTrackCount");
	}else{
		var track_xml = new XML();
		var root_xml;
		root_xml=track_xml.createElement("PlayList");
	}
//	if (PlayOne==true){
		FuncPlayOneAlbum(Index,root_xml);		//play only start from that chapter
//	} else{
//		for (var j = Index; j<resultSearch.length; j++) {
//			FuncPlayOneAlbum(j,root_xml);
//		}
//		for (var j = 0; j<Index; j++) {
//			FuncPlayOneAlbum(j,root_xml);
//		}
//	}
	if (clientType==serverMode or clientType==independentMode){
		fscommand("saveServerPlaylist");
	}else{
		track_xml.appendChild(root_xml);
		fscommand("savePlayTrack",track_xml);
		delete(track_xml);
	}
	
}
//..........................BACK ALBUMPIC..............................
var StorePathPic = "";
function DisplayAlbumPictrueInfo(Index) {
	IndexAlbumForDownLoad = RecordIndexArtistAlbum;
	AlbumPicClick = "folder";
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	if (DisplayFromSearch==1) {
		if (StorePathPic != resultSearch[Index].PathPic) {
			//PicName[0] = resultSearch[Index].PathPic;
			PicName[0] = resultSearch[Index].ReservePath;
			Reset(1);
		}
		StorePathPic = resultSearch[Index].PathPic;
	} else {
		//PicName[0] = resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
		PicName[0] = resultSearchArtistAlbum[RecordIndexArtistAlbum].ReservePath;
		Reset(1);
	}
}

DisplayAlbumBarInfo = function(textEng,textUni){
	var sDisplayUnicode="Eng";
	if (ChangeLan == "Eng"){
		if(textEng==""){
			sDisplayUnicode="Uni"
		}else{
			sDisplayUnicode="Eng"
		}
	}else {
		if(textUni==""){
			sDisplayUnicode="Eng"
		}else{
			sDisplayUnicode="Uni"
		}
	}
	if(sDisplayUnicode=="Eng"){
		popup_tooltip("TextTip:ButtonTip",textEng);
	}else{
		popup_tooltip("TextTip:ButtonTip",textUni);
	}
	ChangeProTitleFont("TextTip", EngFont, UniFont, EngSize, UniSize, sDisplayUnicode);
}

var AlbumPicClick = "folder";

BackAlbumPic.Button.onRollOver = function() {
	var textUnicode,textEnglish;
	HideTooltip("txtTooltip");
	//VisibleInfo("false");
	SelectButton("BackAlbumPic.Movie");
	SelectLevel = 3;
	if (DisplayFromSearch==0) {
		textUnicode= resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist
		textEnglish  = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist
	} else {
		textUnicode = resultSearch[IndexTrack].unicodeAlbum
		textEnglish   = resultSearch[IndexTrack].Album
	}
	DisplayAlbumBarInfo(textEnglish,textUnicode)
	ButtonTip._width = TextTip._width+10;
	if (!ButtonTip._visible) {
		ButtonTip._visible = true;
		TextTip._visible = true;
	}
};
BackAlbumPic.Button.onRelease = function() {
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	var stPath1 = "";
	if (DisplayFromSearch==1) {
		//stPath1=resultSearch[IndexTrack].PathPic;
		stPath1 = resultSearch[IndexTrack].ReservePath;
	} else {
		//stPath1= resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
		stPath1 = resultSearchArtistAlbum[RecordIndexArtistAlbum].ReservePath;
	}
	if (AlbumPicClick == "folder") {
		if (NoInternetConnected == "0") {
			if (DisplayFromSearch==1) {
				IndexAlbumForDownLoad = IndexTrack;
				fscommand("DownLoadPic", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+LanName);
			} else {
				IndexAlbumForDownLoad = RecordIndexArtistAlbum;
				fscommand("DownLoadPic", resultSearchArtistAlbum[RecordIndexArtistAlbum].Path+"%~%"+resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"%~%"+LanName);
			}
		}
		AlbumPicClick = "back";
		PicName[0] = substring(stPath1, 0, stPath1.length-10)+"back.jpg";
	} else {
		AlbumPicClick = "folder";
		PicName[0] = stPath1;
	}
	Reset(1);
};
var yTrack = new Array();
var yNext;
//............
function ReloadTrackPage() {
	for (var j = 0; j<nTrack; j++) {
		if (nTrack == 12) {
			yTrack[j] = eval(TrackName+".Movie"+j)._y-6;
		} else {
			yTrack[j] = eval(TrackName+".Movie"+j)._y-6-TrackNameOffset;
		}
	}
	ChangeColor(TrackName + ".PlayTrailer.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".BrowseTrailer.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".AddToPlay.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".AudioChannel.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".fileType.Movie", SetColorValue, ButtonAlpha);
	eval(TrackName).fileType.Button.onRollOver = function()
	{
		SelectButton( TrackName+".fileType.Movie");
		SelectLevel = 9;
	}
	eval(TrackName).fileType.Button.onMouseMove = function()
	{
		if (eval(TrackName).fileType._visible)
		{	DisplayTooltip(this, "txtTooltip", "Set File Type Path", SHTT, -(117.3/2)+50, 25);}	
	}
	yNext = eval(TrackName).MovieRight._y-6;
	eval(TrackName).RefreshCoverArt.Button.onRollOver = function() {
//		DisplayToolTipStar(true);
		SelectButton(TrackName+".RefreshCoverArt.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Refresh Cover Art", SHTT, -(117.3/2)-70, 30);
	};
	eval(TrackName).MovieRollOver.useHandCursor = false;
	eval(TrackName).MovieRollOver.onRollOut = function() {
		VisibleInfo("false");
	};
	for (var j = 0; j<nTrack; j++) {
		//...............Shopping Cart...................
		eval(TrackName+".Cart"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Cart"+j).onRollOver = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			if (resultSearch[IndexTrack].ShoppingID.length>0 && NoInternetConnected == "0") {
				DisplayTooltip(this, "txtTooltip", "Purchase Track Available", SHTT, -(117.3/2)+50, 20);
			} else {
				DisplayTooltip(this, "txtTooltip", "Purchase Track Not Available", SHTT, -(117.3/2)+50, 20);
			}
		};
		eval(TrackName+".Cart"+j).onRelease = function() {
			if (resultSearch[IndexTrack].ShoppingID.length>0 && NoInternetConnected == "0") {
				fscommand("PurchaseTrack", resultSearch[IndexTrack].ShoppingID);
			}
		};
		//...............SAMPLE SONG ....................
		eval(TrackName+".Sam"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Sam"+j).onRelease = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRelease();
		};
		eval(TrackName+".Sam"+j).onRollOver = function() {
			var Index = GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			if (resultSearch[IndexTrack].Ava == 1) {
				DisplayTooltip(this, "txtTooltip", "Track Available", SHTT, -(117.3/2)+50, 20);
			} else {
				if (resultSearch[IndexTrack].walMart_Ava == 0) {
					DisplayTooltip(this, "txtTooltip", "Sample Song Not Available", SHTT, -(117.3/2)+50, 20);
				} else {
					if (NoInternetConnected == "0") {
						DisplayTooltip(this, "txtTooltip", "Sample Song Available", SHTT, -(117.3/2)+50, 20);
					} else {
						DisplayTooltip(this, "txtTooltip", "Sample Song Not Available", SHTT, -(117.3/2)+50, 20);
					}
				}
			}
		};
		//.....................
		eval(TrackName+".Button"+j).onRollOut = function() {
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
			/*	if(eval(TrackName+".Button"+k)._visible){
				eval(TrackName+".Text"+k)._visible = true;
				eval(TrackName+".Do"+k)._visible=true;
				}
				eval(TrackName+".Movie"+k)._width = TrackTitleWidth;
				eval(TrackName+".Button"+k)._width = TrackTitleWidth;
				eval(TrackName).TextToolTip._visible = false;
										
			*/
		};
		eval(TrackName+".Button"+j).onRollOver = function() {
			eval(TrackName+".Button"+IndexTrack).onRollOut();
			SelectLevel = 3;
			var k = GetNumber(this._name);
			if (DisplayFromSearch==1) {
				IndexTrack = k;
			} else {
				IndexTrack = eval("IndexShow"+TrackObj)+k;
			}
			TrackInfo(IndexTrack);
			if (DisplayFromSearch==1) {
				DisplayAlbumPictrueInfo(IndexTrack);
				eval(TrackName).Rank._visible = false;
			}
			SelectButton(TrackName+".Movie"+k);
			var st = eval(TrackName+".Movie"+k).storeText;
			ToolTip(st, eval(TrackName+".Text"+k)._x, eval(TrackName+".Text"+k)._y, k);
		};
		eval(TrackName+".Button"+j).onRelease = function() {
			click_tracks(GetNumber(this._name));
		};
		
	}
	eval(TrackName).BackStars.Back.onRollOut = function() {
		VisibleStar(parseInt(resultSearch[RecordIndexTrack].Rating, 10));
	};
	for (var j = 1; j<=5; j++) {
		eval(TrackName+".BackStars.Button"+j).onRollOver = function() {
			var k = GetNumber(this._name);
			SelectButton(TrackName+".BackStars.Movie"+k);
			SelectLevel = 9;
			VisibleStar(k);
		};
		eval(TrackName+".BackStars.Button"+j).onRelease = function() {
			if (send_event("normal&&&Click||" + this + "||2",false)){
		      		return;
	        		}
			var k = GetNumber(this._name);
			resultSearch[IndexTrack].Rating = k;
			fscommand("SetRating", resultSearch[IndexTrack].trackID+"~"+k);
			if (k == 4 || k == 5) {
				eval(TrackName+".Text"+IndexTrack%nTrack).textColor = ColorRating;
			} else {
				eval(TrackName+".Text"+IndexTrack%nTrack).textColor = FontColor;
			}
		};
	}
	eval(TrackName).ButtonRight.onRollOver = function() {
		
		SelectButton(TrackName+".MovieRight");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonLeft.onRollOver = function() {
		SelectButton(TrackName+".MovieLeft");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonPlay.Button.onRollOver = function() {
		if (eval(TrackName).ButtonPlay.Icon2._visible) {
			DisplayTooltip(this, "txtTooltip", "Play One Page"+"(A)", SHTT, -(97/2)+5, 20);
		} else {
			DisplayTooltip(this, "txtTooltip", "Play One Track"+"(A)", SHTT, -(97/2)+5, 20);
		}
		SelectButton(TrackName+".ButtonPlay.Movie");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonRight.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
			return;
		}
		ClickRight(TrackObj);
		if (DisplayFromSearch==1) {
			fscommand("getNextResult", eval("IndexShow"+TrackObj));
		} else {
			DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
		}
	};
	eval(TrackName).ButtonLeft.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
			return;
		}
		
		ClickLeft(TrackObj);
		if (DisplayFromSearch==1) {
			fscommand("getNextResult", eval("IndexShow"+TrackObj));
		} else {
			DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
		}
	};
	eval(TrackName).ButtonPlay.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).ButtonPlay.Button.onRelease = function() {
	if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
		eval(TrackName).SearchArtist.MovieSel._visible = false;
		if (PlayMode == "Play One Track") {
			PlayMode = "Play One Page";
			eval(TrackName).ButtonPlay.Icon1._visible = true;
			eval(TrackName).ButtonPlay.Icon2._visible = true;
		} else {
			PlayMode = "Play One Track";
			eval(TrackName).ButtonPlay.Icon1._visible = true;
			eval(TrackName).ButtonPlay.Icon2._visible = false;
		}
		eval(TrackName).ButtonPlay.Text.text = PlayMode;
		fscommand("PlayModeSearch", PlayMode);
	};
	eval(TrackName).PlusIcon.Button.onRollOver = function() {
//		DisplayToolTipStar(true);
		SelectButton(TrackName+".PlusIcon.Movie");
		eval(TrackName).PlusIcon.Selected._visible = true;
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Set Favorite", SHTT, -(117.3/2)+50, 50);
	};
	eval(TrackName).MainTitle.onMouseMove = function() {
		if(this._visible)DisplayTooltip(this, "txtTooltip", "Set Movie MainTitle", SHTT, -(117.3/2)+50, 25);
	};
	
	eval(TrackName).offset.onMouseMove = function() {
		if(this._visible)DisplayTooltip(this, "txtTooltip", "Set Chapter Offset", SHTT, -(117.3/2)+50, 25);
	};
	eval(TrackName).PlusIcon.Button.onRollOut = function() {
		if (resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav == "1") {
			eval(TrackName).PlusIcon.Selected._visible = true;
		} else {
			eval(TrackName).PlusIcon.Selected._visible = false;
		}
		HideTooltip("txtTooltip");
	};
	eval(TrackName).PlusIcon.Button.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	    }
		var Index = RecordIndexArtistAlbum%NumMovie;
		if (resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav == "1") {
			eval(TrackName).Rank._visible = false;
			resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav = "0";
			eval(TrackName).PlusIcon.Available=false;
			eval(TrackName).PlusIcon.Selected._visible = false;
			fscommand("SetAlbumFavorite", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+0);
			eval(NameAlbum+".Plus"+Index+".Selected")._visible = false;
			eval(NameAlbum+".Rank"+Index)._visible = false;
		} else {
			eval(TrackName).Rank._visible = true;
			eval(TrackName).PlusIcon.Available=true;
			resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav = "1";
			eval(TrackName).PlusIcon.Selected._visible = true;
			fscommand("SetAlbumFavorite", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+1);
			eval(NameAlbum+".Plus"+Index+".Selected")._visible = true;
			eval(NameAlbum+".Rank"+Index)._visible = true;
		}
	};
	//..............Rank Artist...............
	eval(TrackName+".Rank.Button").onRelease = function() {
		selection.setFocus(eval(TrackName).Rank.Text);
	};
	eval(TrackName).Rank.Text.onChanged = function() {
//		DisplayToolTipStar(true);
		var Index = RecordIndexArtistAlbum%NumMovie;
		eval(NameAlbum+".Rank"+Index+".Text").text = eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank = eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	};
	eval(TrackName).Rank.ButtonLeft.onRelease = function() {
//		DisplayToolTipStar(true);
		var Index = RecordIndexArtistAlbum%NumMovie;
		eval(TrackName).Rank.Text.text = int(eval(TrackName).Rank.Text.text)-1;
		if (int(eval(TrackName).Rank.Text.text)<0) {
			eval(TrackName).Rank.Text.text = 0;
		}
		eval(NameAlbum+".Rank"+Index+".Text").text = eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank = eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	};
	eval(TrackName).Rank.ButtonRight.onRelease = function() {
//		DisplayToolTipStar(true);
		var Index = RecordIndexArtistAlbum%NumMovie;
		eval(TrackName).Rank.Text.text = int(eval(TrackName).Rank.Text.text)+1;
		eval(NameAlbum+".Rank"+Index+".Text").text = eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank = eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	};
	eval(TrackName).ShowPlayer.Button.onRollOver = function() {
		DisplayTooltip(this, "txtTooltip", "Player Page (Ctrl+"+chr(KeyPlayer)+")", SHTT, -(139.15/2)+5, 20);
		SelectButton(TrackName+".ShowPlayer.Movie");
		SelectLevel = 3;
	};
	eval(TrackName).ShowPlayer.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).ShowPlayer.Button.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
		eval(TrackName).SearchArtist.MovieSel._visible = false;
		fscommand("ShowPlayListPlayer");
	};
	eval(TrackName).ShowRip.Button.onRollOver = function() {
		DisplayTooltip(this, "txtTooltip", "Rip CD (Ctrl+R)", SHTT, -(107.9/2)+5, 20);
		SelectButton(TrackName+".ShowRip.Movie");
		SelectLevel = 3;
	};
	eval(TrackName).ShowRip.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).ShowRip.Button.onRelease = function() {
		eval(TrackName).SearchArtist.MovieSel._visible = false;
		if (MainLevel == 4 && DisplayFromSearch==0) {
			fscommand("ShowRipCD", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~TrackPage");
		} else {
			fscommand("ShowRipCD", 0);
		}
	};
	//......
	eval(TrackName).SearchArtist.Button.onRollOver = function() {
		if (eval(TrackName).SearchArtist.Text.text == "Search Artist") {
			DisplayTooltip(this, "txtTooltip", "Search For Artist(S)", SHTT, -(107.9/2)+5, 20);
		} else {
			DisplayTooltip(this, "txtTooltip", "Search For Album(S)", SHTT, -(107.9/2)+5, 20);
		}
		SelectButton(TrackName+".SearchArtist.Movie");
		SelectLevel = 3;
	};
	eval(TrackName).SearchArtist.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).SearchArtist.Button.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
		
		if (!eval(TrackName).SearchArtist.MovieSel._visible) {
			eval(TrackName).SearchArtist.MovieSel._visible = true;
		} else {
			if (eval(TrackName).SearchArtist.Text.text == "Search Artist") {
				if (DisplayFromSearch==1) {
					eval(TrackName).SearchArtist.Text.text = "Search Album";
					eval(TrackName).SearchArtist.IconArtist._visible = false;
					eval(TrackName).SearchArtist.IconAlbum._visible = true;
				}
			} else {
				eval(TrackName).SearchArtist.Text.text = "Search Artist";
				eval(TrackName).SearchArtist.IconArtist._visible = true;
				eval(TrackName).SearchArtist.IconAlbum._visible = false;
			}
		}
	};
	//......
	eval(TrackName).MusicNote.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).MusicNote.Button.onRollOver = function() {
//		DisplayToolTipStar(true);
		SelectButton(TrackName+".MusicNote.Movie");
		SelectLevel = 9;
		if (eval(TrackName).MusicNote.RedLine._visible) {
			DisplayTooltip(this, "txtTooltip", "Add Track Not Available", SHTT, -(117.3/2)-70, 30);
		} else {
			DisplayTooltip(this, "txtTooltip", "Add Track Available", SHTT, -(117.3/2)-70, 30);
		}
	};
	eval(TrackName).MusicNote.Button.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
			return;
		}
		if (eval(TrackName).MusicNote.RedLine._visible) {
			eval(TrackName).MusicNote.RedLine._visible = false;
		} else {
			eval(TrackName).MusicNote.RedLine._visible = true;
		}
		fscommand("MusicNote", eval(TrackName).MusicNote.RedLine._visible);
	};
	//................
	eval(TrackName+".Rank.Button").onRollOver = function() {
//		DisplayToolTipStar(true);
		eval(TrackName).Rank.ButtonLeft._visible = true;
		eval(TrackName).Rank.ButtonRight._visible = true;
		DisplayTooltip(this, "txtTooltip", "Set Favorite Ranking", SHTT, -(117.3/2)-50, -50);
	};
	eval(TrackName+".Rank.Button").onRollOut = function() {
		eval(TrackName).Rank.ButtonLeft._visible = false;
		eval(TrackName).Rank.ButtonRight._visible = false;
		HideTooltip("txtTooltip");
	};
	eval(TrackName).Rank.ButtonLeft.onRollOver = function() {
		eval(TrackName).Rank.ButtonLeft._visible = true;
		eval(TrackName).Rank.ButtonRight._visible = true;
	};
	eval(TrackName).Rank.ButtonRight.onRollOver = function() {
		eval(TrackName).Rank.ButtonLeft._visible = true;
		eval(TrackName).Rank.ButtonRight._visible = true;
	};
	eval(TrackName).Rank.ButtonLeft.onRollOut = function() {
		eval(TrackName).Rank.ButtonLeft._visible = false;
		eval(TrackName).Rank.ButtonRight._visible = false;
	};
	eval(TrackName).Rank.ButtonRight.onRollOut = function() {
		eval(TrackName).Rank.ButtonLeft._visible = false;
		eval(TrackName).Rank.ButtonRight._visible = false;
	};
	eval(TrackName).RefreshCoverArt.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).RefreshCoverArt.Button.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	    }
		if (NoInternetConnected == "0") {
			if (DisplayFromSearch==1) {
				IndexAlbumForDownLoad = IndexTrack;
				fscommand("RefreshCoverArt", resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+LanName);
			} else {
				IndexAlbumForDownLoad = RecordIndexArtistAlbum;
				fscommand("RefreshCoverArt", resultSearchArtistAlbum[RecordIndexArtistAlbum].Path+"%~%"+resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"%~%"+LanName);
			}
		}
	};
	//=========
	eval(TrackName).PathSlideshow.Button.onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval(TrackName).PathSlideshow.Button.onRollOver = function() {
	//	DisplayToolTipStar(true);
		SelectButton(TrackName+".PathSlideshow.Movie");
		SelectLevel = 9;
		DisplayTooltip(this, "txtTooltip", "Browse Slideshow Path", SHTT, -(117.3/2)-70, 30);
	};
	eval(TrackName).PathSlideshow.Button.onRelease = function() {
		if (DisplayFromSearch==1) {
			fscommand("PathSlideshowAlbum", resultSearch[IndexTrack].AlbumID+"%~%"+LanName);
		} else {
			fscommand("PathSlideshowAlbum", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"%~%"+LanName);
		}
	};
		//=========== PathChapter 
	
	eval(TrackName).PathChapter.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).PathChapter.Button.onRollOver=function(){
	//	DisplayToolTipStar(true);
		SelectButton(TrackName + ".PathChapter.Movie");
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Browse Chapter Path",SHTT,-(117.3/2)-70,30);
	}
	eval(TrackName).PathChapter.Button.onRelease=function(){
		//Send2Server("client","0&&&Click||"+this,true);
		//fscommand("PathChapter",resultSearchArtistAlbum[RecordIndexArtistAlbum].Id+"%~%"+LanName);
		//SelectButton(TrackName + ".PathChapter.Movie");
		var ChapterObject=eval(TrackName).PathChapter;
		ChapterObject.setState(!ChapterObject.getState())
		delete(ChapterObject);
		
	}
}
/*
function createTrackXmlAlbum (val_index,trackbookmark,trackAudioChannel,trackseekOffset,trackPlayFrom) {
	var s_xml = new XML();
	var e_xml=s_xml.createElement("Track");
	
	with(resultSearch[val_index]){
		e_xml.attributes.Album=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
		e_xml.attributes.UniAlbum=resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
		e_xml.attributes.Track=trackTitle;
		e_xml.attributes.UniTrack=unicodeTrackTitle;
		e_xml.attributes.Artist=Artist;
		e_xml.attributes.UniArtist=unicodeArtist;
		e_xml.attributes.Mood=Mood;
		e_xml.attributes.UniMood=unicodeMood;
		e_xml.attributes.DanceStyle=danceStyle;
		e_xml.attributes.UniDanceStyle=unicodeDanceStyle;
		e_xml.attributes.Rating=Rating;
		e_xml.attributes.Genre=Genre;
		e_xml.attributes.UniGenre=unicodeGenre;
		e_xml.attributes.language=LanName;
		e_xml.attributes.Mode=0;
		e_xml.attributes.TrackID=trackID;
		e_xml.attributes.picPath=resultSearchArtistAlbum[RecordIndexArtistAlbum].StringPath;
		e_xml.attributes.AlbumID=AlbumID;
		e_xml.attributes.LanTrack=LanName;
		e_xml.attributes.ComName=ComName;
		e_xml.attributes.TrackYear=resultSearchArtistAlbum[RecordIndexArtistAlbum].Year;
		e_xml.attributes.TrackAva=Ava;
		e_xml.attributes.TrackPath="";
		e_xml.attributes.Actor="";		e_xml.attributes.Director="";
		e_xml.attributes.BookmarkTitle="";	e_xml.attributes.BookmarkTime="";
		e_xml.attributes.ZoomLevel="";		e_xml.attributes.BlankTop="";
		e_xml.attributes.BlankBottom="";	e_xml.attributes.BookmarkLength="";
		e_xml.attributes.BookmarkChapter="";	e_xml.attributes.MainTitle="";
		e_xml.attributes.walMartAva=walMart_Ava;
		e_xml.attributes.ShoppingID=ShoppingID;
		e_xml.attributes.NoTrack=NoTrack;
		e_xml.attributes.TrackIndex=0;
		e_xml.attributes.StPlayer=trackTitle+StOr+unicodeTrackTitle+StPer+resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist+StOr+UniAlbumTitle+StPer+Artist+StOr+unicodeArtist+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle +StWave+UniPro+StWave+UniAlbumTitle;
		e_xml.attributes.AudioChannel=trackAudioChannel;
		e_xml.attributes.IsBookmark=trackbookmark;
		e_xml.attributes.SeekOffset=trackseekOffset;
		e_xml.attributes.PlayTrackFrom=trackPlayFrom;
	}
	return e_xml;
}
*/
function createTrackXml (val_index,trackbookmark,trackAudioChannel,trackseekOffset,trackPlayFrom) {
	
	var s_xml = new XML();
	var e_xml=s_xml.createElement("Track");
	
	with(resultSearch[val_index]){
		e_xml.attributes.Album=Album;
		e_xml.attributes.UniAlbum=unicodeAlbum;
		e_xml.attributes.Track=trackTitle;
		e_xml.attributes.UniTrack=unicodeTrackTitle;
		e_xml.attributes.Artist=Artist;
		e_xml.attributes.UniArtist=unicodeArtist;
		e_xml.attributes.Mood=Mood;
		e_xml.attributes.UniMood=unicodeMood;
		e_xml.attributes.DanceStyle=danceStyle;
		e_xml.attributes.UniDanceStyle=unicodeDanceStyle;
		e_xml.attributes.Rating=Rating;
		e_xml.attributes.Genre=Genre;
		e_xml.attributes.UniGenre=unicodeGenre;
		e_xml.attributes.language=LanName;
		e_xml.attributes.Mode=0;
		e_xml.attributes.TrackID=trackID;
		e_xml.attributes.picPath=StringPath;
		e_xml.attributes.AlbumID=AlbumID;
		e_xml.attributes.LanTrack=LanName;
		e_xml.attributes.ComName=ComName;
		e_xml.attributes.TrackYear=YearTrack;
		e_xml.attributes.TrackAva=Ava;
		e_xml.attributes.TrackPath="";
		e_xml.attributes.walMartAva=walMart_Ava;
		e_xml.attributes.ShoppingID=ShoppingID;
		e_xml.attributes.NoTrack=NoTrack;
		e_xml.attributes.TrackIndex=0;
		e_xml.attributes.StPlayer=trackTitle+StOr+unicodeTrackTitle+StPer+Album+StOr+unicodeAlbum+StPer+Artist+StOr+unicodeArtist+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+unicodeTrackTitle +StWave+UniPro+StWave+unicodeAlbum;
		e_xml.attributes.AudioChannel=trackAudioChannel;
		e_xml.attributes.IsBookmark=trackbookmark;
		e_xml.attributes.SeekOffset=trackseekOffset;
		e_xml.attributes.PlayTrackFrom=trackPlayFrom;

	}
	return e_xml;
}

function PlayTrailerMovie () {
		var art		=	resultSearchArtistAlbum[RecordIndexArtistAlbum].ArtistName;
		var artu	=	resultSearchArtistAlbum[RecordIndexArtistAlbum].unicodeArtistName;
		var Md		=	"";//resultSearchTrack[Index].Mood;
		var UniMd	=	"";//resultSearchTrack[Index].unicodeMood;
		var Dan		=	"";//resultSearchTrack[Index].danceStyle;
		var UniDan	=	"";//resultSearchTrack[Index].unicodeDanceStyle;
		var Gen		=	"";//resultSearchTrack[Index].Genre;
		var UniGen	=	"";//resultSearchTrack[Index].unicodeGenre;
		var walMart_Ava=0;//resultSearchTrack[Index].walMart_Ava;
		var ShoppingID=	0;//resultSearchTrack[Index].ShoppingID;
		var Lan1	=	LanName;//Language of that Movie
		var ComName1=	ComName;//resultSearchTrack[Index].ComName;
		var LanTrack=	LanName;//resultSearchTrack[Index].LanTrack;
		var Rat		=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank;//resultSearchTrack[Index].Rating;
		var Tid		=	0;
		var Pic		=	resultSearchArtistAlbum[RecordIndexArtistAlbum].StringPath;
		var LanPath1=	resultSearchArtistAlbum[RecordIndexArtistAlbum].id;
		var YearTrack=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Year;
		var TrackAva=	1;		//alway available
		var alb	 	=	StoreAlbum;
		var albu	=	StoreUniAlbum;
		var trackno	=	0;
		var tt		=	alb + " " +"(Trailer)";
		var tu		=	"";
		if(offsetEnabled){
			var seekOffset=resultSearchTrack[Index].seekOffset;
		}else{
			var seekOffset=0;
		}

		if (clientType==serverMode or clientType==independentMode){
			fscommand("PlayTrack",Tid +"~"+LanPath1+"~" + trackno +"~"+LanName+"~"+walMart_Ava+"~"+"6");
			fscommand("SendPathPic",resultSearchArtistAlbum[RecordIndexArtistAlbum].Path);
			fscommand("SaveInPlayer",tt+StOr+tu+StPer+alb+StOr+albu+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
			fscommand("SaveInPlayList",new Array(alb,albu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,ModeTrack,Tid,Pic,Lan1,
												 ComName1,LanPath1,LanTrack,YearTrack,TrackAva,walMart_Ava,ShoppingID,0,0,
												 0 ,0,0,0,0,0,0,0,seekOffset).join("%%"));
		}else{
			//trackTitle,utracktitle,artist,uArtist,mood,umood,dance,udance,Rating,genre,ugenre,language,mode,trackid,picpath,lanpath,lantrack,computername,trackyear,trackava,trackpath,walmartava,shoppingid,notrack,trackindex
			doc_xml.appendChild(createTrackXml(alb,albu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,Lan1,0,Tid,Pic,LanPath1,LanTrack,ComName1,YearTrack,TrackAva,"",walMart_Ava,ShoppingID,trackno,0));		
		}
}

function click_tracks(ind){
	
	
	if (send_event("normal&&&function||click_tracks|~|" + ind + "||2",false)){
		return;
	}
	
	ind=int(ind);
	var k = eval("IndexShow"+TrackObj);
//	IndexTrack = k+ind;
	if (DisplayFromSearch==1) {
		IndexTrack = ind;
	} else {
		IndexTrack = ind+k;
	}
	if(eval(TrackName).PathChapter.getState()==true){
		fscommand("BrowseChapterPath",resultSearch[IndexTrack].trackID+"%~%"+LanName);
	}else{
		if (eval(TrackName).SearchArtist.MovieSel._visible) {
			eval(TrackName).SearchArtist.MovieSel._visible = false;
/*			if (SelectMode0=="Song"){
				IndexTrack=ind;
			}
*/
			if (eval(TrackName).SearchArtist.Text.text == "Search Artist") {
				if(DatabaseType==8 or DatabaseType==4 or DatabaseType==16){
					SelectMode = "Artist";
					SelectMode0 = "Artist";
				}else{
					SelectMode = "Album";
					SelectMode0 = "Album";
				}
				fscommand("SearchArtistByTrack",resultSearch[IndexTrack].albumID+"&&"+resultSearch[IndexTrack].trackID+"&&"+DatabaseType);
				//SearchByProductionOrArtist
			} else {
				SelectMode = "Album";
				StoreQsearch = resultSearch[IndexTrack].Album+"&&3";
				fscommand("StartSearchAlbumByTrack", StoreQsearch);
			}
			return;
		}
		if (DisplayFromSearch==1) {
			if(clientType<>clonePlayBack){
				IndexTrack = ind;
				FuncPlayAll(IndexTrack, true);		//play only one track
			}
	
		} else {
			if(clientType<>clonePlayBack){
				FuncPlayAllAlbum(IndexTrack,true);		//play only one track
			}
		}
	}
}
