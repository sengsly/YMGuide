var TrackName="TrackBar";
var TrackObj ="Track";
var IndexTrack=0;

eval(TrackName).TextLeft._visible=false;
eval(TrackName).MovieLeft._visible=false;
eval(TrackName).ButtonLeft._visible=false;

eval(TrackName).TextRight._visible=false;
eval(TrackName).MovieRight._visible=false;
eval(TrackName).ButtonRight._visible=false;
function VisiblePlay(value,value1){
	BackAlbumInfo._visible=false;
	PlayAll._visible=value;
	DelOne._visible=value;
	DelAll._visible=value;
	SlyShow._visible=value;
	ShowPlayer._visible=value;
	Refresh._visible=value;
	ButtonUp._visible=value;
	ButtonDown._visible=value;
	ButtonPre._visible=false;
	ButtonNext._visible=false;
	ButtonBurch._visible=false;
	ButtonCD._visible=false;
	if(value && value1){
		ButtonPre._visible=true;
		ButtonNext._visible=true;
		ButtonBurch._visible=true;
		ButtonCD._visible=true;
		DelAll._visible=false;
		DelOne._visible=false;
		ButtonUp._visible=false;
		ButtonDown._visible=false;
		//SlyShow._visible=false;
		//ShowPlayer._visible=false;
	}
}
VisiblePlay(false);
function DisplayItemTrack (Obj,Index,Count,nItem,boolNoreturn) {
	var nonAvailableArray= new Array();
	EngTextFormat.font = EngFont;
	EngTextFormat.size = TrackNameEnglish;
	EngTextFormat.bold = false;
	UniTextFormat.font = UniFont;
	UniTextFormat.size = UniSize;
	UniTextFormat.bold = false;	
	KhmTextFormat.font = FontKhmer;
	KhmTextFormat.size = SizeKhmer;
	KhmTextFormat.bold = false;
	var textArtistUnicode="";
	var textArtistName="";
	
	Nolist=false;
	fscommand("CountImageToDownload",Count);
	for (var j=0;j<nItem;j++ ){
		objMovie	=	eval(Obj+".Movie"+j);
		objButton	=	eval(Obj+".Button"+j);
		objText		=	eval(Obj+".Text"+j);
		objDo		=	eval(Obj+".Do"+j);
		objArtist	=	eval(Obj+".Artist"+j);
		objPic		=	eval(Obj+".Pic"+j);
		objCart		=	eval(Obj+".Cart"+j);
		objSam		=	eval(Obj+".Sam"+j);
		objSingType =   eval(Obj+".Singer"+j);
		
		if(Index<resultSearch.length){
		//if(j<Count){

			objMovie._visible=true;
			objButton._visible=true;
			objText._visible=true;
			objDo._visible=true;
			objArtist._visible=true;
			objSingType._visible=true;
			Nolist=true;
			
			//.........walmart...........
			if(resultSearch[Index].Ava==0){
					//...........Purchase.....................
					if(resultSearch[Index].ShoppingID.length>0 && NoInternetConnected=="0"){
						objCart._visible=true;
					}
					else{
						objCart._visible=false;
					}
					//........Samplie
					if(resultSearch[Index].walMart_Ava=="0"){
						objSam._visible=false;
					}
					else {
						if(NoInternetConnected=="0"){
							eval(Obj+".Sam"+j+".Sample")._visible=true;
							eval(Obj+".Sam"+j+".Music")._visible=false;
							objSam._visible=true;
						}
						else{
							objSam._visible=false;
						}
					}
			}
			else{
				objCart._visible=false;
				objSam.setMusicNote(resultSearch[Index].Ava);
			}
			//...........................
			if(resultSearch[Index].Rating==4 || resultSearch[Index].Rating==5){
			   objText.textColor=ColorRating;
			   objDo.textColor = ColorRating;
			}
			else{
				 objText.textColor=FontColor;				 
				 objDo.textColor = FontColor;
			}
			objArtist.textColor = SelectColorValue;
//=========================================================
			objPic.ID=resultSearch[Index].PathPic;				//assign the ID for it
			objPic.Index=Index;									//assign it index
			var loadImagePath;
			objPic.unloadFadeImage();
			if(resultSearch[Index].SingType>0){
				textArtistName=resultSearch[Index].Artist;
				textArtistUnicode=resultSearch[Index].unicodeArtist;
			}else{
				textArtistName=resultSearch[Index].Album;
				textArtistUnicode=resultSearch[Index].unicodeAlbum;
			}
			textArtistUnicode
			if (PlayListMode=="TrackTitle"){
				if (!boolNoreturn){
					nonAvailableArray.push(resultSearch[Index].trackID+"*"+resultSearch[Index].AlbumID+"*"+resultSearch[Index].lan+"*"+resultSearch[Index].ComName+"*"+Index);
				}
				if(resultSearch[Index].ReservePath<>""){
					loadImagePath=resultSearch[Index].ReservePath;
				}else{
					loadImagePath=resultSearch[Index].PathPic;
				}
			}else{
				loadImagePath=resultSearch[Index].PathPic;//resultAlbum[RecordIndexAlbum].ReservePath;
			}
			objPic.loadFadeImage(loadImagePath);
			uni_boo=false;
			if(ChangeLan=="Eng"){
				boolEnglishFont=(textArtistName<>"")

				objText.wordWrap = true;
				var tmpTrack_str = "";
				
				var eng_boo = true;					
				if (resultSearch[Index].trackTitle == ""){
					eng_boo = false;
				}
				
				if (eng_boo== true){
					tmpTrack_str = (Index+1) + "." + resultSearch[Index].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText,tmpTrack_str,objDo,EngTextFormat);//,EngFont,EngSize);
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
					
				}else{
					tmpTrack_str = (Index+1) + "." + resultSearch[Index].unicodeTrackTitle;
					objDo.text = "...";
					
					if (getKhmerCountry(resultSearch[Index].Lan) != "1"){
						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat);
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
					}else{
						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,KhmTextFormat);
						if(getKhmerCountry(resultSearch[Index].Lan)=="1" && FontKhmer.length<=0 && KhmTextFormat.font == ""){
							var spl1=resultSearch[Index].StPlayer.split("%%");
							var spl2=spl1[2].split(StWaveSpl);
							var spl3=spl2[1].split("||");
							FontKhmer=spl3[1];
							KhmTextFormat.font = FontKhmer;
						}						
						
						objDo.setTextFormat(KhmTextFormat);
						objText.setTextFormat(KhmTextFormat);
						
					}
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";
					
				}
				
				objDo.autoSize = true;
				objDo._x = objText._x + objText.textWidth;
				objDo._y = objText._y;
				
			}
			else {
				boolEnglishFont=(textArtistUnicode=="");
				
				objText.wordWrap = true;
				var tmpTrack_str = "";			
				
				var uni_boo = true;				
				if (resultSearch[Index].unicodeTrackTitle == ""){
					uni_boo = false;
				}
				
				if (uni_boo == true){
					tmpTrack_str = (Index+1) + "." + resultSearch[Index].unicodeTrackTitle;
					objDo.text = "...";
					if (getKhmerCountry(resultSearch[Index].Lan) != "1"){
						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat);//,UniFont,UniSize);
						
						objDo.setTextFormat(UniTextFormat);
						objText.setTextFormat(UniTextFormat);
						
					}else{
						objText.text =  getTextOneLine(objText,tmpTrack_str,objDo,KhmTextFormat)//,UniFont,UniSize);
						
						if(getKhmerCountry(resultSearch[Index].Lan)=="1" && FontKhmer.length<=0 && KhmTextFormat.font == ""){
							var spl1=resultSearch[Index].StPlayer.split("%%");
							var spl2=spl1[2].split(StWaveSpl);
							var spl3=spl2[1].split("||");
							FontKhmer=spl3[1];
							KhmTextFormat.font = FontKhmer;
						}
						objDo.setTextFormat(KhmTextFormat);
						objText.setTextFormat(KhmTextFormat);
					
					}
										
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";
					
				}else{
					
					tmpTrack_str = (Index+1) + "." + resultSearch[Index].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText,tmpTrack_str,objDo,EngTextFormat);//,EngFont,EngSize);
					
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
					
				}
				objDo.autoSize = true;
				objDo._x = objText._x + objText.textWidth;
				objDo._y = objText._y;
			}
			if (uni_boo and getKhmerCountry(resultSearch[Index].Lan)=="1"){
				objText._y = yTrack[j]+parseInt(TrackPosUni, 10);
			}else{
				objText._y = yTrack[j]+parseInt(TrackPosEng, 10);				
				
			}
/////////Artist//////////			
			var objFont= new TextFormat();
			var offsetTrack;
			if (boolEnglishFont){
				objArtist.text=textArtistName;		//display dvd title under chapter
				
				objFont.font=EngTextFormat.font;
				objFont.size=FontEnglish;
				offsetTrack=OffsetEnglish;
			}else{
				objArtist.text=textArtistUnicode; //dvdtitle
				
				if (getKhmerCountry(resultSearch[Index].Lan)=="1"){
					objFont.size=FontUnicodeKhmer;
					objFont.font=KhmTextFormat.font;					
					offsetTrack= OffsetUnicodeKhmer;
				}else{
					objFont.size=FontUnicodeEnglish;
					objFont.font=UniTextFormat.font;
					offsetTrack=OffsetEnglish;
				}
			}
			objArtist._y=yTrack[j]+offsetTrack;
			objArtist.setTextFormat(objFont);
			delete(objFont);
			objSingType.ShowSinger(resultSearch[Index].SingType);
/////////Artist//////////				

//=========================================================			
			ChangeTrackFont(ChangeLan,resultSearch[Index].Lan,j);
			//DownLoadImage............
			if(PlaylistMode=="TrackTitle"){
				if(resultSearch[Index].ReservePath=="" ){
					resultSearch[Index].ReservePath=resultSearch[Index].PathPic;
					fscommand("SearchPathImage",resultSearch[Index].ReservePath+"%~%"+"Track"+"%~%"+Index+"%~%"+resultSearch[Index].AlbumID+"%~%"+resultSearch[Index].Lan);
				}
			}else {
				resultSearch[Index].ReservePath=resultSearch[Index].PathPic;
				fscommand("SearchPathImage",resultSearch[Index].ReservePath+"%~%"+"Chapter"+"%~%"+Index+"%~%"+resultSearch[Index].AlbumID+"%~%"+resultSearch[Index].Lan);
			}
			//............
			Index+=1;
		}
		else{
			objMovie._visible=false;
			objButton._visible=false;
			objText._visible=false;
			objArtist._visible=false;
			objSingType._visible=false;

			objDo._visible=false;
			objText.text="";
			objPic.unloadFadeImage();
			objSam._visible=false;
			objCart._visible=false;
		}
	}
	if(Nolist==false){
			if(Index>0){
				Index-=nTrack;
//				IndexShowTrack=IndexShowTrack-nTrack;
				set("IndexShow"+TrackObj,eval("IndexShow"+TrackObj)-nTrack);
				NumLeftTrack=NumLeftTrack-nTrack;
				set("LevelIndex"+TrackObj,eval("LevelIndex"+TrackObj)-1);
				DisplayItemTrack (Obj,Index,Count,nItem);
			}
	}
	fscommand("refreshTrackAvailable", nonAvailableArray.join("|"));
	ChangeTrackFontPreNext(ChangeLan);
}
function FirstDisplayTrack(n){
	ReloadTrackPage();
	if(IsRegistered=="False") BackAlbumPic.Logo._visible=true;
	else  BackAlbumPic.Logo._visible=false;
	if(n>0){
		eval(TrackName)._visible=true;
		BackAlbumPic._visible=true;
		if(PlayListMode!="TrackTitle"){
			VisiblePlay(true,true);
			eval(TrackName).offset._visible=(resultAlbum[RecordIndexAlbum].Mode!="External");
			if(resultAlbum[RecordIndexAlbum].Ava=="1")	eval(TrackName).CDIcon._visible=true;
			else eval(TrackName).CDIcon._visible=false;
		}
		else {
			VisiblePlay(true);
			eval(TrackName).offset._visible=false;
			eval(TrackName).CDIcon._visible=false;
		}
		if(IndexTrack==n and n>0){
			if(IndexTrack%ntrack==0) {//fscommand("mb","mod 0");
				eval(TrackName+".Button"+(ntrack-1)).onRollOver();
			}else{
				 eval(TrackName+".Button"+((IndexTrack%ntrack)-1)).onRollOver();
			}
		}else{
			eval(TrackName+".Button"+(IndexTrack%ntrack)).onRollOver();
		}
		DisplayAlbumPictrueInfo(0);
		FirstDisplay(TrackObj,n,nTrack);
		DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
		//clear previous picture and set to onrollover the first track
		StorePathPic=undefined;	
//		fscommand("mb","IndexTrack"+IndexTrack+"::::"+n);	
		
		//eval(TrackName).Button0.onRollOver();
		//============================================================
	}
	else{
		eval(TrackName)._visible=false;
		BackAlbumPic._visible=false;
		VisiblePlay(true);
	}
}
var yTrack = new Array();
var yNext=0;
function ReloadTrackPage () {

	for (var j = 0; j<nTrack; j++) {
		if (nTrack==12){
			yTrack[j] = eval(TrackName + ".Movie"+j)._y-5;
	 		yNext=eval(TrackName).MovieRight._y-5;
		}else{
			yTrack[j] = eval(TrackName + ".Movie"+j)._y-5-TrackNameOffset;
			yNext=eval(TrackName).MovieRight._y-5;
		}
	}
	
	eval(TrackName).ButtonRight.onRollOver = function() {
	SelectButton(TrackName + ".MovieRight");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonRight.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
		ClickRight(TrackObj);
			NumLeftTrack=eval("IndexShow"+TrackObj)
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
		
	};
	eval(TrackName).ButtonLeft.onRollOver = function() {
		SelectButton(TrackName + ".MovieLeft");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonPlay.onRollOver = function() {
		SelectButton(TrackName + ".MoviePlay");
		SelectLevel = 3;
	};
	var NumLeftTrack=0;
	eval(TrackName).ButtonLeft.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
			ClickLeft(TrackObj);
			NumLeftTrack=eval("IndexShow"+TrackObj);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	};
	eval(TrackName).MovieRollOver.useHandCursor = false;
	eval(TrackName).MovieRollOver.onRollOut = function() {
		VisibleInfo("false");
	};
	for (var j = 1; j<=5; j++) {
		eval(TrackName + ".BackStars.Button"+j).onRollOver = function() {
			var k = GetNumber(this._name);
			SelectButton(TrackName + ".BackStars.Movie"+k);
			SelectLevel=9;
			VisibleStar(k);
		};
		eval(TrackName + ".BackStars.Button"+j).onRelease = function() {
			var k = GetNumber(this._name);

			resultSearch[IndexTrack].Rating = k;
			fscommand("SetRating",resultSearch[IndexTrack].trackID+StWave+k+StWave+resultSearch[IndexTrack].Lan+StWave+IndexTrack+StWave+BackPlayList.TextD.text+"\\PlayLists\\"+resultP[RecordIndexP]+".xml"+StWave+PlayListMode);
			if(k==4 || k==5){
				eval(TrackName + ".Text"+(IndexTrack%nTrack)).textColor=ColorRating;
			}
			else eval(TrackName + ".Text"+(IndexTrack%nTrack)).textColor=FontColor;
		};
	}
	for (var j = 0; j<nTrack; j++) {
		//...............Shopping Cart...................
		eval(TrackName + ".Cart"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName + ".Cart"+j).onRollOver = function() {
			var Index=GetNumber(this._name);
			eval(TrackName + ".Button"+Index).onRollOver();
			if(resultSearch[IndexTrack].ShoppingID.length>0 && NoInternetConnected=="0"){
				DisplayTooltip(this,"txtTooltip","Purchase Track Available",SHTT,-(117.3/2)+50,20);
			}
			else{
				DisplayTooltip(this,"txtTooltip","Purchase Track Not Available",SHTT,-(117.3/2)+50,20);
			}
		}
		eval(TrackName + ".Cart"+j).onRelease = function() {
			if(resultSearch[IndexTrack].ShoppingID.length>0 && NoInternetConnected=="0" ){
				fscommand("PurchaseTrack",resultSearch[IndexTrack].ShoppingID)
			}
		}
		//...............SAMPLE SONG ....................
		eval(TrackName + ".Sam"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName + ".Sam"+j).onRelease = function() {
			var Index=GetNumber(this._name);
			eval(TrackName + ".Button"+Index).onRelease();
		}
		eval(TrackName + ".Sam"+j).onRollOver = function() {
			var Index=GetNumber(this._name);
			eval(TrackName + ".Button"+Index).onRollOver();
			
			if(resultSearch[IndexTrack].Ava==1){
				DisplayTooltip(this,"txtTooltip","Track Available",SHTT,-(117.3/2)+50,20);
			}
			else{
				if(resultSearch[IndexTrack].walMart_Ava==0){
					DisplayTooltip(this,"txtTooltip","Sample Song Not Available",SHTT,-(117.3/2)+50,20);
				}
				else{
					if(NoInternetConnected=="0"){
						DisplayTooltip(this,"txtTooltip","Sample Song Available",SHTT,-(117.3/2)+50,20);
					}
					else{
						DisplayTooltip(this,"txtTooltip","Sample Song Not Available",SHTT,-(117.3/2)+50,20);
					}
				}
			}
		};
		//.....................
		eval(TrackName + ".Button"+j).onRollOut = function() {
			//var k =int(GetNumber(this._name));
			if (displayTwoLine_boo == true){
				displayTwoLine_boo = false;
				
				eval(TrackName).TextToolTip._visible = false;
				
				eval(TrackName + ".Text"+k)._visible = true;
				eval(TrackName + ".Do"+k)._visible=true;
				
				eval(TrackName + ".over_mc")._visible = false;
				eval(TrackName + ".overCover_mc")._visible = false;
				
				eval(TrackName + ".samOver_mc")._visible = false;		
				eval(TrackName + ".cartOver_mc")._visible = false;
				
			}
		};
		eval(TrackName + ".Button"+j).onRollOver = function() {
			//eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
			AlbumPicClick = "folder";
			SelectLevel = 3;
			var k =int(GetNumber(this._name));		// get index button
			var k1=eval("IndexShow"+TrackObj)+k;			// index array
			IndexTrack=k1;
//			fscommand("mb","IndexTrack Over:::"+IndexTrack);
			TrackInfo(k,k1);
			if(PlaylistMode=="TrackTitle") DisplayAlbumPictrueInfo(k1);
			SelectButton(TrackName + ".Movie"+k);
			ToolTip(eval(TrackName + ".Movie"+k).storeText, eval(TrackName + ".Text"+k)._x, eval(TrackName + ".Text"+k)._y, k,resultSearch[k1].Lan);
		};
		eval(TrackName + ".Button"+j).onRelease = function() {			
			click_list_track_name(GetNumber(this._name), DelOne.MovieSel._visible, ButtonUp.MovieSel._visible, ButtonDown.MovieSel._visible);
		};
	}
	eval(TrackName).RefreshCoverArt.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).RefreshCoverArt.Button.onRollOver=function(){
		DisplayToolTipStar(true);
		SelectButton(TrackName + ".RefreshCoverArt.Movie");
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Refresh Cover Art",SHTT,-(117.3/2)-70,30);
	}
	eval(TrackName).RefreshCoverArt.Button.onRelease=function(){
		if(NoInternetConnected=="0"){
			IndexAlbumForDownLoad=IndexTrack;
			fscommand("RefreshCoverArt",resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan)
		}
	}
	
	//=========
	eval(TrackName).PathSlideshow.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).PathSlideshow.Button.onRollOver=function(){
		DisplayToolTipStar(true);
		SelectButton(TrackName + ".PathSlideshow.Movie");
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Browse Slideshow Path",SHTT,-(117.3/2)-70,30);
	}
	eval(TrackName).PathSlideshow.Button.onRelease=function(){
		fscommand("PathSlideshowAlbum",resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan);
	}
	eval(TrackName).MusicNote.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).MusicNote.Button.onRollOver=function(){
		DisplayToolTipStar(true);
		SelectButton(TrackName + ".MusicNote.Movie");
		SelectLevel=9;
		if(eval(TrackName).MusicNote.RedLine._visible){
			DisplayTooltip(this,"txtTooltip","Add Track Not Available",SHTT,-(117.3/2)-70,30);
		}
		else{
			DisplayTooltip(this,"txtTooltip","Add Track Available",SHTT,-(117.3/2)-70,30);
		}
	}
	eval(TrackName).MusicNote.Button.onRelease=function(){
		if(eval(TrackName).MusicNote.RedLine._visible){
			eval(TrackName).MusicNote.RedLine._visible=false;
		}
		else{
			eval(TrackName).MusicNote.RedLine._visible=true;
		}
		fscommand("MusicNote",eval(TrackName).MusicNote.RedLine._visible);
	}

}
function VisibleInfo(Value) {
	VisibleIconAlbum(boolShowCoverIcon);
	if(boolShowCoverIcon){
		DisplayToolTipStar(true);
	}
/*
	if (Value == "true") {
		var b = true;
		DisplayToolTipStar(true);
		DisplayToolTipTrack(b);
	} else {
		var b = false;
	}
	eval(TrackName).CoverTrackInfo._visible = b;
	eval(TrackName).TrackLen._visible = b;
	eval(TrackName).TrackNo._visible = b;
	if(resultSearch[IndexTrack].Mode!="Internal") eval(TrackName).TrackNo.text="Track # "+(IndexTrack+1);
	else eval(TrackName).TrackNo.text="Track # "+ (resultSearch[IndexTrack].NoTrack);
	eval(TrackName).Artist._visible = b;
	eval(TrackName).Album._visible = b;
	eval(TrackName).BackStars.Back.onRollOut = function() {
		VisibleStar(parseInt(resultSearch[IndexTrack].Rating, 10));
	};
*/
}
function FadeTooltipTrack() {
	clr += 10;
	if (clr>=50) {
		//eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
		VisibleInfo(false);
		clearInterval(clearToolTip1);
	}
}

function ToolTip(St, X, Y, Index,Lan) {
	
	eval(TrackName).TextToolTip._visible = false;
	eval(TrackName).TextToolTip.text = St;
	eval(TrackName).TextToolTip._width = eval(TrackBar+".Movie"+Index)._width - (eval(TrackName).TextToolTip._x - eval(TrackBar+".Movie"+Index)._x);
	eval(TrackName).TextToolTip._height = eval(TrackName + ".Text"+Index)._height;	
	eval(TrackName).TextToolTip.wordWrap = true;	
	eval(TrackName).TextToolTip.autoSize = true;
	
	if (eval(TrackName + ".Movie"+Index).storeLan == "Eng"){
		eval(TrackName).TextToolTip.setTextFormat(EngTextFormat);
	}else{
		if (getKhmerCountry(Lan) != "1"){
			eval(TrackName).TextToolTip.setTextFormat(UniTextFormat);
		}else{
			eval(TrackName).TextToolTip.setTextFormat(KhmTextFormat);
		}
	}
	
//	if (eval(TrackName).TextToolTip._width>eval(TrackName + ".Text"+Index)._width) {
	if (eval(TrackName + ".Do"+Index)._visible == true && eval(TrackName + ".Do"+Index).text != ""){
		displayTwoLine_boo = true;
		eval(TrackName).TextToolTip._x = X;
		eval(TrackName).TextToolTip._y = Y;
		eval(TrackName).TextToolTip._visible = true;
		
		//eval(TrackName + ".Text"+Index)._visible = false;
		//eval(TrackName + ".Do"+Index)._visible = false;
		
		//eval(TrackName + ".Movie"+Index)._width = eval(TrackName).TextToolTip._width+65;
		//eval(TrackName + ".Button"+Index)._width = eval(TrackName).TextToolTip._width+65;
		
		var g_color = new Color(eval(TrackName + ".Movie"+Index));
		var s_color = new Color(eval(TrackName + ".over_mc"));
		s_color.setRGB(g_color.getRGB());
		
		if (ListBar._visible == true){
			eval(TrackName+".over_mc")._width = eval(TrackName+".Movie"+Index)._width - eval(TrackName+".Movie"+Index)._height;
			eval(TrackName+".over_mc")._x = eval(TrackName+".Movie"+Index)._x + eval(TrackName+".Movie"+Index)._height;
		}else{
			eval(TrackName+".over_mc")._width = eval(TrackName+".Movie"+Index)._width;
			eval(TrackName+".over_mc")._x = eval(TrackName+".Movie"+Index)._x;			
		}
		eval(TrackName+".over_mc")._height = eval(TrackName).TextToolTip.textHeight + 10;
		eval(TrackName+".over_mc")._y = eval(TrackName+".Movie"+Index)._y;
		eval(TrackName + ".over_mc")._visible = true;
		
		eval(TrackName + ".samOver_mc")._x = eval(TrackName + ".Sam"+Index)._x;
		eval(TrackName + ".samOver_mc")._y = eval(TrackName + ".Sam"+Index)._y;
		if (eval(TrackName + ".Sam"+Index)._visible == true){
			if(eval(TrackName + ".Sam"+Index+".Sample")._visible == true){
				eval(TrackName + ".samOver_mc.Sample")._visible = true;
				eval(TrackName + ".samOver_mc.Music")._visible = false;
			}else{
				eval(TrackName + ".samOver_mc.Sample")._visible = false;
				eval(TrackName + ".samOver_mc.Music")._visible = true;
			}
			eval(TrackName + ".samOver_mc")._visible = true;
		}
		
		eval(TrackName + ".cartOver_mc")._x = eval(TrackName + ".Cart"+Index)._x;
		eval(TrackName + ".cartOver_mc")._y = eval(TrackName + ".Cart"+Index)._y;
		if (eval(TrackName + ".Cart"+Index)._visible == true){eval(TrackName + ".cartOver_mc")._visible = true;}
		
	}
}
function VisibleStar(Index) {
	for (var j = 1; j<=5; j++) {
		if (j<=Index) {
			eval(TrackName + ".BackStars.Star"+j)._visible = true;
		} else {
			eval(TrackName + ".BackStars.Star"+j)._visible = false;
		}
	}
	DisplayToolTipStar(true);	
}
function TrackInfo(Index,Index1) {
	VisibleInfo("true");
	if(PlayListMode!="TrackTitle"){
		eval(TrackName).offset.txt.text=resultSearch[Index1].seekOffset;
	}
	if(resultSearch[Index1].Mode=="Internal"){
		eval(TrackName).TrackLen.text =resultSearch[Index1].YearTrack +"   "+ resultSearch[Index1].LanTrack;
	}
	else{
		eval(TrackName).TrackLen.text =resultSearch[Index1].Mode;
	}
	VisibleStar(parseInt(resultSearch[Index1].Rating, 10));
	if (ChangeLan == "Eng") {
		//eval(TrackName).Mood.text = resultSearch[Index1].Mood;
		//eval(TrackName).Dance.text = resultSearch[Index1].danceStyle;
		eval(TrackName).Artist.text = resultSearch[Index1].Artist;
		if(PlayListMode=="TrackTitle"){
			eval(TrackName).Album.text = resultSearch[Index1].Album;
		}
		else {
			eval(TrackName).Album.text = resultAlbum[RecordIndexAlbum].Artist;
		}
	} else {
		if(resultSearch[Index1].Lan=="English"){
			//eval(TrackName).Mood.text = resultSearch[Index1].Mood;
			//eval(TrackName).Dance.text = resultSearch[Index1].danceStyle;
			eval(TrackName).Artist.text = resultSearch[Index1].Artist;
			if(PlayListMode=="TrackTitle"){
				eval(TrackName).Album.text = resultSearch[Index1].Album;
			}
			else {
				eval(TrackName).Album.text = resultAlbum[RecordIndexAlbum].Artist;
				
			}
		}
		else{
			//eval(TrackName).Mood.text = resultSearch[Index1].unicodeMood;
			//eval(TrackName).Dance.text = resultSearch[Index1].unicodedanceStyle;
			eval(TrackName).Artist.text = resultSearch[Index1].unicodeArtist;
			if(PlayListMode=="TrackTitle"){
				eval(TrackName).Album.text = resultSearch[Index1].unicodeAlbum;
				
			}
			else {
				eval(TrackName).Album.text = resultAlbum[RecordIndexAlbum].uniArtist;
				
			}
		}
	}
	if(getKhmerCountry(resultSearch[Index1].Lan)=="1"){
		ChangeTrackInfoFont(ChangeLan,resultSearch[Index1].Lan);
	}
	else{
		if(iKhmer=="1"){
			ChangeTrackInfoFont(ChangeLan,resultSearch[Index1].Lan);
		}
		else{
			ChangeTrackInfoFont(ChangeLan,resultSearch[Index1].Lan);
		}
	}
}
function FuncPlayPage (Index,PlayOneMode) {

	if (clientType==serverMode or clientType==independentMode ){
		fscommand("saveOldTrackCount");
	}else{
		var track_xml = new XML();
		var root_xml;
		root_xml=track_xml.createElement("PlayList");
	}

//play all if button all is pressed
	if (PlayOneMode==true){
		
		PutIndexPlayTrack(resultSearch,Index,root_xml);		//Play Only From that chapter seng 2005-08-30
	} else {
		for(var k=Index;k<resultSearch.length;k++){
			PutIndexPlayTrack(resultSearch,k,root_xml);
		}
		for( var k=0;k<Index;k++){
			PutIndexPlayTrack(resultSearch,k,root_xml);
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
function PutIndexPlayTrack(result,k,doc_xml){
	if(result[k].Ava!=0 or (result[k].walMart_Ava!=0 and NoInternetConnected=="0")){
		//EDID:2006.05.04
		var tt=result[k].trackTitle;
		var tu=result[k].unicodeTrackTitle;
		var art=result[k].Artist;
		var artu=result[k].unicodeArtist;
		var Album=result[k].Album;
		var Albumu=result[k].unicodeAlbum;
		var Stplayer=result[k].StPlayer;
		var Lan1=result[k].Lan;
		var Md=result[k].Mood;
		var UniMd=result[k].unicodeMood;
		var Dan=result[k].danceStyle;
		var UniDan=result[k].unicodeDanceStyle;
		var Rat=result[k].Rating;
		var Gen=result[k].Genre;
		var UniGen=result[k].unicodeGenre;
		var Tid=result[k].trackID;
		var Pic=result[k].RePathPic;
		var ComName1=result[k].ComName;
		var AlbumID=result[k].AlbumID;
		var ModeTrack=result[k].Mode;
		var LanTrack=result[k].LanTrack;
		var YearTrack=result[k].YearTrack;
		var Ava=result[k].Ava;
		var walMart_Ava=result[k].walMart_Ava;
		var ShoppingID=result[k].ShoppingID;
		var ZoomLevel=result[k].ZoomLevel;
		var BlankTop=result[k].BlankTop;
		var BlankBottom=result[k].BlankBottom;
		var BookMarkTitle=result[k].BookmarkTitle;
		var BookMarkTime=result[k].BookMarkTime;
		var BookmarkLength=result[k].BookmarkLength;
		var BookmarkChapter=result[k].BookmarkChapter;
		var MainTitle=result[k].MainTitle;
		var seekOffset=result[k].seekOffset;
		if(PlayListMode!="TrackTitle"){
			var AudioChannel=playAudioChannel;
			var IsBookMark=(playchapterfile=="False")? 4:0 ; 			//if the track is karaoke or music then make it like bookmark
			if(!offsetEnabled){seekOffset=0;}
		}else{
			var AudioChannel=result[k].AudioChannel;
			var IsBookMark=result[k].IsBookmark;
		}
		if (clientType==serverMode or clientType==independentMode ){
			
			fscommand("PlayTrack",result[k].trackID+"~"+result[k].AlbumID+"~"+result[k].NoTrack+"~"+result[k].Lan+"~"+result[k].walMart_Ava+"~"+result[k].PlayTrackFrom);
			fscommand("SendPathPic",result[k].PathPic);
			fscommand("SaveInPlayer",Stplayer+"&&&"+result[k].Mode+"&&&"+Lan1);
			fscommand("SaveInPlayList",new Array(Album,Albumu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,ModeTrack,Tid,Pic,Lan1,
												 ComName1,AlbumID,LanTrack,YearTrack,Ava,walMart_Ava,ShoppingID,ZoomLevel,BlankTop,
												 BlankBottom ,IsBookMark,BookMarkTitle,BookMarkTime,BookmarkLength,BookmarkChapter,MainTitle,AudioChannel,seekOffset,0).join("%%"));

		} else {
			doc_xml.appendChild(createTrackXml(k,AudioChannel,IsBookMark));
		}
	}
}

//..........................BACK ALBUMPIC..............................
var StorePathPic="";
function DisplayAlbumPictrueInfo(Index) {
	AlbumPicClick = "folder";
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	
	if(PlaylistMode=="TrackTitle"){
		BackAlbumPic.Index=Index;
		if(StorePathPic!=resultSearch[Index].PathPic){
			PicName[0] = resultSearch[Index].ReservePath;
			if(PicName[0] != undefined){
				StorePathPic = resultSearch[Index].PathPic;
				Reset(1);
			}
		}
	}
	else{
		PicName[0] = resultAlbum[RecordIndexAlbum].ReservePath;
		Reset(1);
	}
	
}
var AlbumPicClick = "folder";
BackAlbumPic.Button.onRollOver = function() {
	VisibleInfo("false");
	SelectButton("BackAlbumPic.Movie");
	SelectLevel = 3;
};
BackAlbumPic.Button.onRelease = function() {
	//fscommand("AddAlbumPic",resultSearch[IndexTrack].PathPic);
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	if (AlbumPicClick == "folder") {
		if(NoInternetConnected=="0"){
			IndexAlbumForDownLoad=IndexTrack;
			fscommand("DownLoadPic",resultSearch[IndexTrack].PathPic+"%~%"+resultSearch[IndexTrack].AlbumID+"%~%"+resultSearch[IndexTrack].Lan)
		}
		AlbumPicClick = "back";
		//PicName[0] =substring(resultSearch[IndexTrack].PathPic,0,resultSearch[IndexTrack].PathPic.length-10)+"back.jpg";
		PicName[0] =substring(resultSearch[IndexTrack].ReservePath,0,resultSearch[IndexTrack].ReservePath.length-10)+"back.jpg";
	} else {
		AlbumPicClick = "folder";
		PicName[0] = resultSearch[IndexTrack].ReservePath;
	}
	Reset(1);
};
//...........................................BUTTONPLAY........................................
eval("ButtonUp.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("ButtonDown.Button").onRollOut=function(){
	HideTooltip("txtTooltip");

}
eval("DelOne.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("DelAll.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("SlyShow.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("Refresh.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}

eval("ShowPlayer.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}

///.............
eval("PlayAll.Button").onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Play "+PlayAll.Text.text+" Track( A )",SHTT,-(122/2)+5,20);
	SelectButton("PlayAll.Movie");
	SelectLevel=4;
}
eval("PlayAll.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("DelOne.Button").onRollOver=function(){
	SelectButton("DelOne.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Delete One Track",SHTT,-(125/2)+5,20);
	
}
eval("DelAll.Button").onRollOver=function(){
	SelectButton("DelAll.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Delete All Tracks",SHTT,-(125/2)+5,20);
	
}
eval("SlyShow.Button").onRollOver=function(){
	SelectButton("SlyShow.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Set SlideShow Path",SHTT,-(125/2)+5,20);
}
eval("Refresh.Button").onRollOver=function(){
	SelectButton("Refresh.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Refresh The Playlist",SHTT,-(125/2)+5,20);
}

eval("ShowPlayer.Button").onRollOver=function(){
	SelectButton("ShowPlayer.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Show Player Page",SHTT,-(125/2)+5,20);
}
//--------------------------------------------------
eval("PlayAll.Button").onRelease=function(){
	click_play_all(PlayAll.Text.text);
}
function click_play_all(val_playAll){
	if (send_event("normal&&&function||click_play_all|~|" + val_playAll + "||3",false)){
		return;
	}
	
	val_sel = String(val_sel);
	val_sel = (val_sel == "true");
//	fscommand("mb",val_playAll);
PlayAll.Icon2._visible = ! PlayAll.Icon2._visible;
/*switch (val_playAll) {

       		
		case "One" :
			//PlayAll.Icon2._visible = false;
			PlayAll.Icon1._visible = true;
			PlayAll.Text.text = "All";



				
			break;
		case "All" :
//			PlayAll.Icon2._visible = true;
			PlayAll.Icon1._visible = true;
			PlayAll.Text.text = "One";
				
			break;
		default :
			PlayAll.Icon2._visible = false;
			PlayAll.Icon1._visible = true;
			PlayAll.Text.text = "One";
	}*/
if(PlayAll.Icon2._visible )
{	PlayAll.Text.text = "All";

}else{
	PlayAll.Text.text = "One";
}
	if(PlayAll.MovieSel._visible)PlayModeSelect("");
	else PlayModeSelect("PlayAll.MovieSel");
	fscommand("PlayModePlayList",PlayAll.Text.text);//val_playAll
}
//--------------------------------------------------
eval("DelOne.Button").onRelease=function(){
	click_del_one(DelOne.MovieSel._visible);
}
function click_del_one(val){
	if (send_event("normal&&&function||click_del_one|~|" + val + "||3",false)){
		return;
	}
	val = String(val);
	val = (val == "true");
	if(val){
		PlayModeSelect("");
	} else {
		PlayModeSelect("DelOne.MovieSel");
	}
}
eval("DelAll.Button").onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3", false)){
		return;
	}
	RemoveAll.Text.text = "PlayList Name: " + resultP[RecordIndexP];
	RemoveAll._visible = true;
	Cover._visible = true;
	PlayModeSelect("");
	RemoveAll.ButtonOk.onRollOver();
}
eval("SlyShow.Button").onRelease=function(){
	fscommand("EditSlyShow",BackPlayList.TextD.text + StWave + RecordIndexP + StWave + resultP[RecordIndexP] + StWave + SlyPath[RecordIndexP]);
	PlayModeSelect("SlyShow.MovieSel");
}
eval("Refresh.Button").onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3", false)){
		return;
	}
	fscommand("CheckTrackRating", BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml");
	PlayModeSelect("Refresh.MovieSel");
}

eval("ShowPlayer.Button").onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	TopBar.ButtonP.onRelease();
}
RemoveAll.ButtonCancel.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	RemoveAll._visible=false;
	Cover._visible=false;
	eval("DelAll.Button").onRollOver();
}
RemoveAll.ButtonOk.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	fscommand("DelAllTrack",BackPlayList.TextD.text + "\\PlayLists"+StWave +resultP[RecordIndexP]);
	FirstDisplayTrack(0);
	RemoveAll._visible = false;
	Cover._visible = false;
	TopBar.ButtonM.onRollOver();
}
function PlayModeSelect(Obj){
	PlayAll.MovieSel._visible=false;
	DelOne.MovieSel._visible=false;
	DelAll.MovieSel._visible=false;
	SlyShow.MovieSel._visible=false;
	ButtonUp.MovieSel._visible=false;
	ButtonDown.MovieSel._visible=false;
	Refresh.MovieSel._visible=false;
	eval(Obj)._visible=true;
}
PlayModeSelect("PlayAll.MovieSel");
eval("ButtonPre.Button").onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Previous Album (<)",SHTT,-(125/2)+5,20);
	SelectButton("ButtonPre.Movie");
	SelectLevel=4;
}
eval("ButtonPre.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}

eval("ButtonNext.Button").onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Next Album (>)",SHTT,-(97/2)+5,20);
	SelectButton("ButtonNext.Movie");
	SelectLevel=4;
}
eval("ButtonNext.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("ButtonBurch.Button").onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","Purchase CD (G)",SHTT,-(117/2)+5,20);
	SelectButton("ButtonBurch.Movie");
	SelectLevel=4;
}
eval("ButtonCD.Button").onRollOver=function(){
	DisplayTooltip(this,"txtTooltip","CD Information(I)",SHTT,-(117/2)+5,20);
	SelectButton("ButtonCD.Movie");
	SelectLevel=4;
}

eval("ButtonBurch.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}
eval("ButtonCD.Button").onRollOut=function(){
	HideTooltip("txtTooltip");
}

eval("ButtonBurch.Button").onRelease=function(){
	if(resultAlbum[RecordIndexAlbum].id.length>0){
		if(resultAlbum[RecordIndexAlbum].Nation=="English"){
			PurchaseCDMode._visible=true;
			PurchaseCDMode.Button0.onRollOver();
			ButtonHideMouse._visible=true;
			fscommand("ShowPurchaseBox",resultAlbum[RecordIndexAlbum].id);
		}
		else fscommand("buyCD",resultAlbum[RecordIndexAlbum].id+"~"+resultAlbum[RecordIndexAlbum].Nation);
	}
}
eval("ButtonCD.Button").onRelease=function(){
	if(BackAlbumInfo._visible){
		BackAlbumInfo._visible=false;
		eval(TrackName)._visible=true;
	}
	else {
		fscommand("GetArtistAlbumInfo",resultAlbum[RecordIndexAlbum].id+"~"+SplAllCountrys[resultAlbum[RecordIndexAlbum].Nation].DBPath);
		eval(TrackName)._visible=false;
		BackAlbumInfo._visible=true;
	}
}
//--------------------------------------------------
eval("ButtonPre.Button").onRelease=function(){
	if (_global.boolMouseDown == false){ 
		return;
	}
	_global.boolMouseDown = false;
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	RecordIndexAlbum -= 1;
	if (RecordIndexAlbum<0) {
		RecordIndexAlbum = resultAlbum.length-1;
	}
	displayEachAlbum();
	if(!ButtonTooltip._visible || !TextTip._visible){
		ButtonTooltip._visible=true;
		TextTip._visible=true;
	}
	if(ChangeLan=="Eng"){
		//TextTip.text=resultAlbum[RecordIndexAlbum].Artist;
		popup_tooltip("TextTip:ButtonTooltip",resultAlbum[RecordIndexAlbum].Artist);
	}else{
		//TextTip.text=resultAlbum[RecordIndexAlbum].uniArtist;
		popup_tooltip("TextTip:ButtonTooltip",resultAlbum[RecordIndexAlbum].uniArtist);
	}
	ChangeTooltip(ChangeLan,resultAlbum[RecordIndexAlbum].Nation);
	ButtonToolTip._width=TextTip._width+10;
	
	DeselectedItem ("BackListP",IndexShowP,RecordIndexAlbum,"P");
	var Level=ReturnLevel(RecordIndexAlbum+1 , nPlayList);
	if(Level!=LevelIndexP){
		IndexShowP=(Level-1) * nPlayList;
		CountP=ReturnCount(Level,TotalLevelIndexP,resultAlbum.length,nPlayList)
		LevelIndexP=Level;
		DisplayItemListP ("BackListP",IndexShowP,CountP,nPlayList,ResultP,"P");
	}
}
//--------------------------------------------------
eval("ButtonNext.Button").onRelease=function(){
	if (_global.boolMouseDown == false){ 
		return;
	}
	_global.boolMouseDown = false;
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	RecordIndexAlbum += 1;
	
	if (RecordIndexAlbum>=resultAlbum.length) {
		RecordIndexAlbum =0;
	}
	displayEachAlbum();
	if(!ButtonTooltip._visible || !TextTip._visible){
		ButtonTooltip._visible=true;
		TextTip._visible=true;
	}
	if(ChangeLan=="Eng"){
		popup_tooltip("TextTip:ButtonTooltip",resultAlbum[RecordIndexAlbum].Artist);
	}else{
		popup_tooltip("TextTip:ButtonTooltip",resultAlbum[RecordIndexAlbum].uniArtist);
	}
	ChangeTooltip(ChangeLan,resultAlbum[RecordIndexAlbum].Nation);
	ButtonToolTip._width=TextTip._width+10;
	
	DeselectedItem ("BackListP",IndexShowP,RecordIndexAlbum,"P");
	var Level=ReturnLevel(RecordIndexAlbum+1 , nPlayList);
	if(Level!=LevelIndexP){
		IndexShowP=(Level-1) * nPlayList;
		CountP=ReturnCount(Level,TotalLevelIndexP,resultAlbum.length,nPlayList)
		LevelIndexP=Level;
		DisplayItemListP ("BackListP",IndexShowP,CountP,nPlayList,ResultP,"P");
	}

}
//----------------------------------------------------------------------------------------------------
eval("ButtonUp.Button").onRollOver=function(){
	SelectButton("ButtonUp.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Move Up Track",SHTT,-(125/2)+5,20);
}

eval("ButtonDown.Button").onRollOver=function(){
	SelectButton("ButtonDown.Movie");
	SelectLevel=4;
	DisplayTooltip(this,"txtTooltip","Move Down Track",SHTT,-(125/2)+5,20);
}

eval("ButtonUp.Button").onRelease=function(){
	click_button_up(ButtonUp.MovieSel._visible);
}
function click_button_up(val){
	if (send_event("normal&&&function||click_button_up|~|" + val + "||3",false)){
		return;
	}
	val = String(val);
	val = (val == "true");
	if(val){
		PlayModeSelect("");
	} else {
		PlayModeSelect("ButtonUp.MovieSel");
	}
}
eval("ButtonDown.Button").onRelease=function(){
	click_button_down(ButtonDown.MovieSel._visible);
}
function click_button_down(val){
	if (send_event("normal&&&function||click_button_down|~|" + val + "||3",false)){
		return;
	}
	val = String(val);
	val = (val == "true");
	if(val){
		PlayModeSelect("");
	} else {
		PlayModeSelect("ButtonDown.MovieSel");
	}
}
//----------------------------------------------------------------------------------------------------
function FuncMoveUpDown(Move,Index,MainIndex){
	var tempArr;
	tempArr=resultSearch[MainIndex];
	if(Move=="Up"){
		if(MainIndex==0){
			resultSearch.splice(MainIndex,1,resultSearch[resultSearch.length-1]);
			resultSearch.splice(resultSearch.length-1,1,tempArr);
			fscommand("ChangePlayListIndex",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml"+StWave+MainIndex+StWave+(resultSearch.length-1));
		}
		else if(MainIndex>0){
			resultSearch.splice(MainIndex,1,resultSearch[MainIndex-1]);
			resultSearch.splice(MainIndex-1,1,tempArr);
			fscommand("ChangePlayListIndex",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml"+StWave+MainIndex+StWave+(MainIndex-1));
		}
	}
	else {
		if(MainIndex==resultSearch.length-1){
			resultSearch.splice(MainIndex,1,resultSearch[0]);
			resultSearch.splice(0,1,tempArr);
			fscommand("ChangePlayListIndex",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml"+StWave+MainIndex+StWave+0);
		}
		else{
			resultSearch.splice(MainIndex,1,resultSearch[MainIndex+1]);
			resultSearch.splice(MainIndex+1,1,tempArr);
			fscommand("ChangePlayListIndex",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml"+StWave+MainIndex+StWave+(MainIndex+1));
		}
	}
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
}

//..........................EDIT ALBUMINFO RATIANG.......................
function VisibleStarAlbumInfo(Index) {
	for (var j = 1; j<=5; j++) {
		if (j<=Index) {
			eval("BackAlbumInfo.BackStars.Star"+j)._visible = true;
		} else {
			eval("BackAlbumInfo.BackStars.Star"+j)._visible = false;
		}
	}
}
BackAlbumInfo.BackStars.Back.onRollOut = function() {
	VisibleStarAlbumInfo(parseInt(BackAlbumInfo.AlbumRating.text,10));
};
for (var j = 1; j<=5; j++) {
	eval("BackAlbumInfo.BackStars.Button"+j).onRollOver = function() {
		var k = GetNumber(this._name);
		SelectLevel=10;
		SelectButton("BackAlbumInfo.BackStars.Movie"+k);
		for (var j1 = 1; j1<=5; j1++) {
			if (j1<=k) {
				eval("BackAlbumInfo.BackStars.Star"+j1)._visible = true;
			} else {
				eval("BackAlbumInfo.BackStars.Star"+j1)._visible = false;
			}
		}
	};
	eval("BackAlbumInfo.BackStars.Button"+j).onRelease = function() {
		var k = GetNumber(this._name);
		BackAlbumInfo.AlbumRating.text = k;
		fscommand("SetRatingAlbum", resultAlbum[RecordIndexAlbum].id+"~"+k+"~"+resultAlbum[RecordIndexAlbum].Nation);
	};
}


function createTrackXml (val_index,val_AudioChannel,val_IsBookmark) {
	
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
		e_xml.attributes.AlbumID=AlbumID;
		e_xml.attributes.Rating=Rating;
		e_xml.attributes.Genre=Genre;
		e_xml.attributes.UniGenre=unicodeGenre;
		e_xml.attributes.language=Lan;
		e_xml.attributes.Mode=Mode;
		e_xml.attributes.TrackID=trackID;
		e_xml.attributes.picPath=RePathPic;
		e_xml.attributes.LanPath=  AlbumID  //resultSearchArtistAlbum[RecordIndexArtistAlbum].Id;  error display menubar album
		e_xml.attributes.LanTrack=LanTrack;
		e_xml.attributes.ComName=ComName;
		e_xml.attributes.TrackYear=resultSearchArtistAlbum[RecordIndexArtistAlbum].Year;
		e_xml.attributes.TrackAva=Ava;
		e_xml.attributes.TrackPath=TrackPath;
		e_xml.attributes.walMartAva=int(walMart_Ava);
		e_xml.attributes.ShoppingID=ShoppingID;
		e_xml.attributes.NoTrack=NoTrack; 
		e_xml.attributes.TrackIndex=0;
		e_xml.attributes.StPlayer=StPlayer;
		e_xml.attributes.NetPath=NetPath;
		e_xml.attributes.Actor="";
		e_xml.attributes.Director="";
		//EDID:2006.05.04 Seng
		e_xml.attributes.BookmarkTitle=BookmarkTitle;
		e_xml.attributes.BookmarkTime=BookMarkTime;
		e_xml.attributes.BookmarkLength=BookmarkLength;
		e_xml.attributes.BookmarkChapter=BookmarkChapter;
		e_xml.attributes.MainTitle=MainTitle;
		e_xml.attributes.SeekOffset=seekOffset;
		e_xml.attributes.AudioChannel=val_AudioChannel;
		e_xml.attributes.IsBookmark=val_IsBookmark;
	}
	return e_xml;
}
ReloadTrackPage();

//----------------------------------------------------------------------------------------------------
function click_list_track_name(val, val_DelOne, val_ButtonUp, val_ButtonDown){
	if (send_event("normal&&&function||click_list_track_name|~|" + val +"|~|"+val_DelOne+"|~|"+ val_ButtonUp+"|~|"+val_ButtonDown+ "||3",false)){
		return;
	}
	if(clientType!=clonePlayBack){
		val_DelOne = String(val_DelOne);
		val_DelOne = (val_DelOne == "true");
		val_ButtonUp = String(val_ButtonUp);
		val_ButtonUp = (val_ButtonUp == "true");
		val_ButtonDown = String(val_ButtonDown);
		val_ButtonDown = (val_ButtonDown == "true");
		
		var k = int(val);
		var k1 = eval("IndexShow" + TrackObj) + k;
		IndexTrack = k1;
		if(val_DelOne){
	/*		//eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
			var Level=eval("LevelIndex"+TrackObj);
			var oldIndexShow=eval("IndexShow"+TrackObj);
			resultSearch.splice(k1,1)
			FirstDisplayTrack(resultSearch.length);
			set("IndexShow"+TrackObj,oldIndexShow);
			set("LevelIndex"+TrackObj,Level);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			fscommand("DelOneTrack",BackPlayList.TextD.text+"\\PlayLists\\"+resultP[RecordIndexP]+".xml"+StWave+K1);*/
			removeOneTrack(k1);
		} else if(val_ButtonUp) {
			eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
			FuncMoveUpDown("Up",k,k1);
		} else if(val_ButtonDown) {
			eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
			FuncMoveUpDown("Down",k,k1);
		} else {
			FuncPlayPage(k1,(PlayAll.Text.text=="One"));
		}
	}
}
function redisplayTrack () {
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack,true);	
}
function ChangeUnicode(){
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
	DisplayTextAlbum("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum);
	if (BackAlbumInfo._visible) {
		ChangeAlbumInfoFont(ChangeLan, SaveAlbumInfo);
	}
};
function removeOneTrack(ind)
{
	var LIndex;
	var tmpObj;
	var Level=eval("LevelIndex"+TrackObj);
	var oldIndexShow=eval("IndexShow"+TrackObj);
	var cObj;
	cObj=eval("Count"+TrackObj);
	//eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
	LIndex=ind - oldIndexShow;
	tmpObj = StoreNameSelected;
	resultSearch.splice(ind,1)
	FirstDisplayTrack(resultSearch.length);
	set("IndexShow"+TrackObj,oldIndexShow);
	set("LevelIndex"+TrackObj,Level);
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
	fscommand("DelOneTrack",BackPlayList.TextD.text+"\\PlayLists\\"+resultP[RecordIndexP]+".xml"+StWave+ind);

	// reselect
	//set("Count"+TrackObj,int(cObj)-1);
	if ((int(LIndex)+OldIndexShow) == resultSearch.length)
	{	if (OldIndexShow ==resultSearch.length)	
		{	tmpObj= tmpObj.substr(0,tmpObj.length-1) +"7";
			set("Count"+TrackObj,8);
		}
		else{
			 tmpObj= tmpObj.substr(0,tmpObj.length-1) +""+ (int(LIndex)-1);
			set("Count"+TrackObj,int(cObj)-1);
		}
	}
	else{
		tmpObj= tmpObj.substr(0,tmpObj.length-1) +""+ LIndex;	
	}
	SelectButton(tmpObj);
}