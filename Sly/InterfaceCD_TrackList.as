function ReloadTrackPage () {
	for (var j = 0; j<nTrack; j++) {
		if (nTrack==12){
			yTrack[j] = eval(TrackName + ".Movie"+j)._y;
		}else{
			yTrack[j] = eval(TrackName + ".Movie"+j)._y-TrackNameOffset;
		}
		ChangeColor(TrackName + ".Movie"+j, SetColorValue, ButtonAlpha);
	}
	yNext=eval(TrackName).MovieRight._y-5;
	ChangeColor(TrackName + ".MovieLeft", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".MovieRight", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".MusicNote.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".RefreshCoverArt.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".RipCD.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".PathChapter.Movie",SetColorValue,ButtonAlpha);
	ChangeColor(TrackName + ".PlusIcon.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".PlayTrailer.Movie",SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".BrowseTrailer.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".AddToPlay.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".fileType.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".CoverArtType.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".AudioChannel.Movie", SetColorValue, ButtonAlpha);
	ChangeColor(TrackName + ".chkOffset.Movie", SetColorValue, ButtonAlpha);
	eval(TrackName).CoverArtType.Button.onRollOver = function()
	{
		SelectButton( TrackName+".CoverArtType.Movie");
		SelectLevel = 9;	
	}
	eval(TrackName).CoverArtType.Button.onMouseMove = function()
	{
		if (eval(TrackName).CoverArtType._visible)
		{	
			DisplayTooltip(this, "txtTooltip", "Display Coverart Type", SHTT, -(117.3/2)+50, 25);}
	}
	eval(TrackName).CoverArtType.Button.onRelease = function()
	{
		eval(TrackName).CoverArtType.LoopIndex();
		iCoverType = eval(TrackName).CoverArtType.getCurrentIndex();
		var downloadPicName=resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
		IndexAlbumForDownLoad=RecordIndexArtistAlbum;
		fscommand("reloadcoverart",iCoverType +"%~%"+ resultSearchArtistAlbum[RecordIndexArtistAlbum].Id+"%~%"+LanName)
		fscommand("SearchPathImage",PicName[0] + "%~%"+"Album" +"%~%" + RecordIndexArtistAlbum + "%~%" + resultSearchArtistAlbum[RecordIndexArtistAlbum].Id + "%~%" +LanName);		
	}
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
	eval(TrackName).ButtonLeft.onRollOver = function() {
		SelectButton( TrackName+".MovieLeft");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonRight.onRollOver = function() {
		SelectButton( TrackName+".MovieRight");
		SelectLevel = 3;
	};
	eval(TrackName).ButtonRight.onRelease = function() {
		if (send_event("normal&&&Click||" + this + "||0", false)) {
			return;
		}
		ClickRight(TrackObj);
		DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	};
	
   eval(TrackName).ButtonLeft.onRelease = function() {
		//Send2Server("client","0&&&Click||"+this,true);
		if (send_event("normal&&&Click||" + this + "||0", false)) {
			return;
		}
		ClickLeft(TrackObj);
		DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	};
	
		eval(TrackName).BackStars.Back.onRollOut = function() {
		VisibleStar(parseInt(resultSearchTrack[RecordIndexTrack].Rating, 10));
	};
	
	for (var j = 1; j<=5; j++) {
		eval(TrackName+".BackStars.Button"+j).onRollOver = function() {
			var k = GetNumber(this._name);
			SelectButton(TrackName+".BackStars.Movie"+k);
			SelectLevel=9;
			VisibleStar(k);
		};
		eval(TrackName+".BackStars.Button"+j).onRelease = function() {
			Send2Server("client","0&&&Click||"+this,true);
			var k = GetNumber(this._name);
			resultSearchTrack[RecordIndexTrack].Rating = k;
			fscommand("SetRating", resultSearchTrack[RecordIndexTrack].trackID+"~"+k);
			if(k==4 || k==5){
				eval(TrackName+".Text"+(RecordIndexTrack%nTrack)).textColor=ColorRating;
			}
			else{
				eval(TrackName+".Text"+(RecordIndexTrack%nTrack)).textColor=FontColor;
			}
		};
	}
	
	for (var j = 0; j<nTrack; j++) {
		eval(TrackName+".Button"+j).onRollOut = function() {
			var k=GetNumber(this._name);
			if (displayTwoLine_boo == true){
				displayTwoLine_boo = false;
				
				eval(TrackName).TextToolTip._visible = false;
				if(eval(TrackName+".Movie"+k)._visible){
					eval(TrackName+".Text"+k)._visible = true;
					eval(TrackName+".Do"+k)._visible=true;
				}else{
					eval(TrackName+".Text"+k)._visible = false;
					eval(TrackName+".Do"+k)._visible=false;
				}
				eval(TrackName+".over_mc")._visible = false;
				eval(TrackName+".overCover_mc")._visible = false;
				eval(TrackName+".samOver_mc")._visible = false;		
				eval(TrackName+".cartOver_mc")._visible = false;
			}
		};
		eval(TrackName+".Button"+j).onRollOver = function() {
			SelectLevel = 3;
			var k=GetNumber(this._name);
			SelectButton(TrackName+".Movie"+k);
			IndexTrack = ((eval("LevelIndex"+TrackObj)-1)*nTrack)+parseInt(k, 10);
			RecordIndexTrack = IndexTrack;
			RecordLevelTrack = eval("LevelIndex"+TrackObj);
			TrackInfo(IndexTrack);
			
			//var d_color = new Color(eval(TrackName+".Sam"+k+".music_note"));			
			ChangeColor(TrackName+".over_mc", SelectColorValue,100);// ButtonSelAlpha);
			
			ToolTip(eval(TrackName+".Movie"+k).storeText, eval(TrackName+".Text"+k)._x, eval(TrackName+".Text"+k)._y, k);			
			
		};
		eval(TrackName+".Button"+j).onRelease = function() {
			if (this._name.length == "Button0".length) {
				var k = substring(this._name, this._name.length, -1);
			} else {
				var k = substring(this._name, this._name.length-1, -1);
			}
			IndexTrack = ((eval("LevelIndex"+TrackObj)-1)*nTrack)+parseInt(k, 10);
			if(eval(TrackName).PathChapter.getState()==true){
				fscommand("BrowseChapterPath",resultSearchTrack[IndexTrack].trackID+"%~%"+LanName);
			}else{
				if(clientType==clonePlayBack){
					Send2Server("client", "0&&&function||selectToPlayTrack|~|"+IndexTrack+"|~|"+PlayMode, true);
				} else{
					selectToPlayTrack(IndexTrack,PlayMode);
				}
			}
		};
		//...............Shopping Cart...................
		eval(TrackName+".Cart"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Cart"+j).onRollOver = function() {
			var Index=GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			if(resultSearchTrack[RecordIndexTrack].ShoppingID.length>0 && NoInternetConnected=="0"){
				DisplayTooltip(this,"txtTooltip","Purchase Track Available",SHTT,-(117.3/2)+50,20);
			}
			else{
				DisplayTooltip(this,"txtTooltip","Purchase Track Not Available",SHTT,-(117.3/2)+50,20);
			}
		}
		eval(TrackName+".Cart"+j).onRelease = function() {
			Send2Server("client","0&&&Click||"+this,true);
			if(resultSearchTrack[RecordIndexTrack].ShoppingID.length>0 && NoInternetConnected=="0" ){
				fscommand("PurchaseTrack",resultSearchTrack[RecordIndexTrack].ShoppingID)
			}
		}
		//...............SAMPLE SONG ....................
		eval(TrackName+".Sam"+j).onRollOut = function() {
			HideTooltip("txtTooltip");
		};
		eval(TrackName+".Sam"+j).onRelease = function() {
			Send2Server("client","0&&&Click||"+this,true);
			var Index=GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRelease();
		}
		eval(TrackName+".Sam"+j).onRollOver = function() {
			var Index=GetNumber(this._name);
			eval(TrackName+".Button"+Index).onRollOver();
			
			if(resultSearchTrack[RecordIndexTrack].Ava!=0){
				DisplayTooltip(this,"txtTooltip","Track Available",SHTT,-(117.3/2)+50,20);
			}
			else{
				if(resultSearchTrack[RecordIndexTrack].walMart_Ava==0){
					DisplayTooltip(this,"txtTooltip","Song available over network",SHTT,-(117.3/2)+50,20);
				}
				else{
					if(NoInternetConnected=="0"){
						DisplayTooltip(this,"txtTooltip","Sample Song Available",SHTT,-(117.3/2)+50,20);
					}
					else{
						DisplayTooltip(this,"txtTooltip","Song available over network",SHTT,-(117.3/2)+50,20);
					}
				}
			}
		};
	}

	eval(TrackName).PlusIcon.Button.onRollOver=function(){
		SelectButton(TrackName + ".PlusIcon.Movie");
		eval(TrackName).PlusIcon.Selected._visible=true;
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Set Favorite",SHTT,-(117.3/2)+50,50);
	}
	eval(TrackName).MainTitle.onMouseMove = function() {
		if (this._visible)
		{	DisplayTooltip(this, "txtTooltip", "Set Movie MainTitle", SHTT, -(117.3/2)+50, 25);
		}
	};
	eval(TrackName).offset.onMouseMove = function() {
		if (this._visible)
		{	DisplayTooltip(this, "txtTooltip", "Set Chapter Offset", SHTT, -(117.3/2)+50, 25);}
	};

	eval(TrackName).PlusIcon.Button.onRollOut=function(){
		if(resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav=="1"){
			eval(TrackName).PlusIcon.Available=true;
			eval(TrackName).PlusIcon.Selected._visible=true;
		}
		else{
			eval(TrackName).PlusIcon.Available=false;
		}
		eval(TrackName).PlusIcon.Selected._visible=eval(TrackName).PlusIcon.Available;
		HideTooltip("txtTooltip");
	}
	
	eval(TrackName).PlusIcon.Button.onRelease=function(){
//		Send2Server("client","0&&&Click||"+this,true);
		if (send_event("normal&&&Click||" + this + "||0", false)) {
			return;
		}
		var Index=RecordIndexArtistAlbum%NumMovie;
		if(resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav=="1"){
			eval(TrackName).Rank._visible=false;
			resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav="0";
			eval(TrackName).PlusIcon.Selected._visible=false;
			fscommand("SetAlbumFavorite",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+0);
			
			eval(NameAlbum+".Plus"+Index+".Selected")._visible=false;
			eval(NameAlbum+".Rank"+Index)._visible=false;
		}
		else{
			eval(TrackName).Rank._visible=true;
			resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav="1";
			eval(TrackName).PlusIcon.Selected._visible=true;
			fscommand("SetAlbumFavorite",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+1);
			
			eval(NameAlbum+".Plus"+Index+".Selected")._visible=true;
			eval(NameAlbum+".Rank"+Index)._visible=true;
		}
		
	}
	
	//..............Rank Artist...............
	
	eval(TrackName + ".Rank.Button").onRollOver=function(){
		eval(TrackName).Rank.ButtonLeft._visible=true;
		eval(TrackName).Rank.ButtonRight._visible=true;
		DisplayTooltip(this,"txtTooltip","Set Favorite Ranking",SHTT,-(117.3/2)-50,-50);
	}
	eval(TrackName + ".Rank.Button").onRollOut=function(){
		eval(TrackName).Rank.ButtonLeft._visible=false;
		eval(TrackName).Rank.ButtonRight._visible=false;
		HideTooltip("txtTooltip");
	}
	
	
	eval(TrackName + ".Rank.Button").onRelease=function(){
		Send2Server("client","0&&&Click||"+this,true);
		selection.setFocus(eval(TrackName).Rank.Text);
	}
	eval(TrackName).Rank.ButtonLeft.onRollOver=function(){
		eval(TrackName).Rank.ButtonLeft._visible=true;
		eval(TrackName).Rank.ButtonRight._visible=true;
	}
	eval(TrackName).Rank.ButtonRight.onRollOver=function(){
		eval(TrackName).Rank.ButtonLeft._visible=true;
		eval(TrackName).Rank.ButtonRight._visible=true;
	}
	eval(TrackName).Rank.ButtonLeft.onRollOut=function(){
		eval(TrackName).Rank.ButtonLeft._visible=false;
		eval(TrackName).Rank.ButtonRight._visible=false;
	}
	eval(TrackName).Rank.ButtonRight.onRollOut=function(){
		eval(TrackName).Rank.ButtonLeft._visible=false;
		eval(TrackName).Rank.ButtonRight._visible=false;
	}
	
	eval(TrackName).Rank.Text.onChanged=function(){
		var Index=RecordIndexArtistAlbum%NumMovie;
		eval(NameAlbum+".Rank"+Index+".Text").text=eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank=eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	}
	
	eval(TrackName).Rank.ButtonLeft.onRelease=function(){
		Send2Server("client","0&&&Click||"+this,true);
		var Index=RecordIndexArtistAlbum%NumMovie;
		eval(TrackName).Rank.Text.text=int(eval(TrackName).Rank.Text.text)-1;
		if(int(eval(TrackName).Rank.Text.text)<0)eval(TrackName).Rank.Text.text=0;
		eval(NameAlbum+".Rank"+Index+".Text").text=eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank=eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	}
	
	eval(TrackName).Rank.ButtonRight.onRelease=function(){
		Send2Server("client","0&&&Click||"+this,true);
		var Index=RecordIndexArtistAlbum%NumMovie;
		eval(TrackName).Rank.Text.text=int(eval(TrackName).Rank.Text.text)+1;
		eval(NameAlbum+".Rank"+Index+".Text").text=eval(TrackName).Rank.Text.text;
		resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank=eval(TrackName).Rank.Text.text;
		fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+eval(TrackName).Rank.Text.text);
	}
	
	eval(TrackName).MusicNote.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).MusicNote.Button.onRollOver=function(){
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
		eval(TrackName).MusicNote.RedLine._visible=! eval(TrackName).MusicNote.RedLine._visible;
		fscommand("MusicNote",eval(TrackName).MusicNote.RedLine._visible);
	}
	//..............
	eval(TrackName).RefreshCoverArt.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).RefreshCoverArt.Button.onRollOver=function(){
		SelectButton(TrackName + ".RefreshCoverArt.Movie");
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Refresh Cover Art",SHTT,-(117.3/2)-70,30);
	}
	eval(TrackName).RefreshCoverArt.Button.onRelease=function(){
		if(NoInternetConnected=="0"){
			var downloadPicName=resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
			if(AlbumPicClick<>"folder"){
				var downloadPicName=downloadPicName.substr( 0,downloadPicName.length-10) +"back.jpg";
			}
			BackAlbumPic.unloadFadeImage();
			IndexAlbumForDownLoad=RecordIndexArtistAlbum;
			fscommand("RefreshCoverArt",downloadPicName+"%~%"+resultSearchArtistAlbum[RecordIndexArtistAlbum].Id+"%~%"+LanName)
		}
	}
	
	
	//=========
	eval(TrackName).RipCD.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).RipCD.Button.onRollOver=function(){
		SelectButton(TrackName + ".RipCD.Movie");
		SelectLevel=9;
		DisplayTooltip(this,"txtTooltip","Rip CD",SHTT,-(117.3/2)-70,30);
	}
	eval(TrackName).RipCD.Button.onRelease=function(){
		Send2Server("client","0&&&Click||"+this,true);
		fscommand("ShowRipCD", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~TrackPage");
//		fscommand("PathSlideshowAlbum",resultSearchArtistAlbum[RecordIndexArtistAlbum].Id+"%~%"+LanName);
	}
	//=========== PathChapter 
	
	eval(TrackName).PathChapter.Button.onRollOut=function(){
		HideTooltip("txtTooltip");
	}
	eval(TrackName).PathChapter.Button.onRollOver=function(){
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
	fscommand("RequestChapterTypeAndAudio",0);
}
function DisplayItemTrack (Obj,Index,Count,nItem) {
	var objMovie,objButton,objText,objDo,objSam,objCart,objArtist,objPic;
	var strTrackInfo,strTrackInfoUnicode;		//for display name under track title
	var boolTrackUseUnicode=false;
	var boolArtistUseUnicode=false;

	EngTextFormat.font = EngFont;
	EngTextFormat.size = EngSize;
	EngTextFormat.bold = false;
	UniTextFormat.font = UniFont;
	UniTextFormat.size = UniSize;
	UniTextFormat.bold = false;
	//Clear rollover item
	eval(TrackName+".over_mc")._visible = false;
	eval(TrackName+".overCover_mc")._visible = false;
	eval(TrackName+".samOver_mc")._visible = false;		
	eval(TrackName+".cartOver_mc")._visible = false;
	//clear

	for (var j=0;j<nItem;j++ ){
		objMovie	=	eval(Obj+".Movie"+j);
		objButton	=	eval(Obj+".Button"+j);
		objText		=	eval(Obj+".Text"+j);
		objDo		=	eval(Obj+".Do"+j);
		objSam		=	eval(Obj+".Sam"+j);
		objCart		=	eval(Obj+".Cart"+j);
		objArtist	=	eval(Obj+".Artist"+j);
		objPic		=	eval(Obj+".Pic"+j)
		objSingType =   eval(Obj+".Singer"+j);



		if(j<Count){
			objMovie._visible=true;
			objButton._visible=true;
			objText._visible=true;
			objDo._visible=true;
			objArtist._visible=true;
			objPic._visible=true;
			objSingType._visible=true;

			
			//.............Samplie && Purchase Track.............
			if(iShowUnderTrackTitle==0){
				strTrackInfo	=String(resultSearchTrack[Index+j].Artist)
				strTrackInfoUnicode	=String(resultSearchTrack[Index+j].unicodeArtist)
			}else{
				strTrackInfo	=String(resultSearchTrack[Index+j].Label)
				strTrackInfoUnicode	=String(resultSearchTrack[Index+j].LabelUnicode)
			}
			
			if(resultSearchTrack[Index+j].Ava!=0){
				objCart._visible=false;
			}else{
					//...........Purchase.....................
					if(resultSearchTrack[Index+j].ShoppingID.length>0 && NoInternetConnected=="0"){
						objCart._visible=true;
					}
					else{
						objCart._visible=false;
					}
			}
			objSam.setMusicNote(resultSearchTrack[Index+j].Ava,resultSearchTrack[Index+j].walMart_Ava);//set color according to value
			if(resultSearchTrack[Index+j].Rating==4 || resultSearchTrack[Index+j].Rating==5){
			   objText.textColor=ColorRating;
			   objDo.textColor=ColorRating;
			}
			else{
				 objText.textColor=FontColor;				 
				 objDo.textColor=FontColor;
			}
			objArtist.textColor = SelectColorValue;
			 resultSearchTrack[Index+j].SingerType

			if(resultSearchTrack[Index+j].ReservePath==""){
				resultSearchTrack[Index+j].ReservePath=resultSearchTrack[Index+j].PathPic;
				fscommand("SearchPathImage",resultSearchTrack[Index+j].PathPic+"%~%"+"Chapter"+"%~%"+resultSearchTrack[Index+j].trackID+"%~%"+resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"%~%"+LanName);
			}else{
				//make it load only one time
				objPic.loadFadeImage(resultSearchTrack[Index+j].ReservePath);
			}

	
			var eng_boo = true;
			if(ChangeLan=="Eng"){
				boolEnglishFont=(strTrackInfo<>"")
				//strTrackInfoUnicode
				
				objText.wordWrap = true;
				var tmpTrack_str = "";
				eng_boo=true;
				if (resultSearchTrack[Index+j].trackTitle==""){
					eng_boo = false;
				}
				
				if (eng_boo== true){
					tmpTrack_str = resultSearchTrack[Index+j].trackNo+"."+resultSearchTrack[Index+j].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText,tmpTrack_str,objDo,EngTextFormat);//,EngFont,EngSize);
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
					
				}else{
					
//					if (iKhmer != "1"){
						tmpTrack_str = resultSearchTrack[Index+j].trackNo+"."+resultSearchTrack[Index+j].unicodeTrackTitle;
						objDo.text = "...";
						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat);//,UniFont,UniSize);
//					}else{
//						tmpTrack_str = resultSearchTrack[Index+j].trackNo+">"+resultSearchTrack[Index+j].unicodeTrackTitle;
//						objDo.text = "<<<";
//						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat);//,UniFont,UniSize);
//					}
					
					objDo.setTextFormat(UniTextFormat);
					objText.setTextFormat(UniTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";

				}
				
//				objText._y = yTrack[j]+parseInt(TrackPosEng, 10);				
				objDo.autoSize = true;
				objDo._x = objText._x + objText.textWidth;
//				objDo._y = objText._y;
				
			}
			else {
				boolEnglishFont=(strTrackInfoUnicode=="");
				objText.wordWrap = true;
				var tmpTrack_str = "";			
				eng_boo=false;
//				var uni_boo = true;				
				if (resultSearchTrack[Index+j].unicodeTrackTitle == ""){
					eng_boo=true;
				}
				
				if (eng_boo == false){
					
//					if (iKhmer != "1"){
						tmpTrack_str = resultSearchTrack[Index+j].trackNo + "." + resultSearchTrack[Index+j].unicodeTrackTitle
						objDo.text = "...";
						objText.text = getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat);//,UniFont,UniSize);
//					}else{
//						tmpTrack_str = resultSearchTrack[Index+j].trackNo + ">" + resultSearchTrack[Index+j].unicodeTrackTitle
//						objDo.text = ">>>";
//						objText.text =  getTextOneLine(objText,tmpTrack_str,objDo,UniTextFormat)//,UniFont,UniSize);
//					}
					
					objDo.setTextFormat(UniTextFormat);
					objText.setTextFormat(UniTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Uni";

				}else{
					
					tmpTrack_str = resultSearchTrack[Index+j].trackNo+"."+resultSearchTrack[Index+j].trackTitle;
					objDo.text = "...";
					objText.text = getTextOneLine(objText,tmpTrack_str,objDo,EngTextFormat);//,EngFont,EngSize);
					
					objDo.setTextFormat(EngTextFormat);
					objText.setTextFormat(EngTextFormat);
					
					objMovie.storeText = tmpTrack_str;
					objMovie.storeLan = "Eng";
					
				}
				
//				objText._y = yTrack[j]+parseInt(TrackPosUni, 10);
				objDo.autoSize = true;
				objDo._x = objText._x + objText.textWidth;
//				objDo._y = objText._y;
				
			}
			if(eng_boo==false){
				objText._y = yTrack[j]+parseInt(TrackPosUni, 10);
			}else{
				objText._y = yTrack[j]+parseInt(TrackPosEng, 10);				
			}
			objDo._y = objText._y;
			//- display singer only Karaoke
			if (databaseType == 8 ){	
				 objSingType.ShowSinger(resultSearchTrack[Index+j].SingType);
			}else
			{
				 objSingType.ShowSinger(-1);
			}
			//-----------------------------------------
/////////Artist//////////			
			var objFont= new TextFormat();

			if (boolEnglishFont){
             				objArtist.text=strTrackInfo;				
				objFont.font=EngTextFormat.font;
				objFont.size=FontEnglish;
				offsetArtist=OffsetEnglish;
			}else{
				objArtist.text=strTrackInfoUnicode;
				if (iKhmer == "1"){
					objFont.size=FontUnicodeKhmer;
					objFont.font=UniTextFormat.font;
					offsetArtist=OffsetUnicodeKhmer;
				}else{
					objFont.size=FontUnicodeEnglish;
					objFont.font=UniTextFormat.font;
					offsetArtist=OffsetEnglish;
				}
			}
			objArtist.setTextFormat(objFont);
			objArtist.autoSize=true;
			objArtist._y=yTrack[j] +offsetArtist;

			delete(objFont);
/////////Artist//////////				
				
		}
		else{
			objMovie._visible=false;
			objButton._visible=false;
			objText._visible=false;
			objDo._visible=false;
			objSam._visible=false;
			objCart._visible=false;
			objArtist._visible=false;
			objPic.unloadFadeImage();
			objSingType._visible=false;
		}
	}
	ChangeTrackFont(EngFont, UniFont, EngSize, UniSize, ChangeLan,resultSearchArtistAlbum[RecordIndexArtistAlbum].idLan);
}
function changeAvailable (changeList,fromComName) {
	var boolavailableChanged=false;
	changeList=changeList.split(",");
	for(i=0;i<changeList.length;i++){
		for(j=0;j<resultSearchTrack.length;j++){
			if (changeList[i]==resultSearchTrack[j].trackID and resultSearchTrack[j].Ava==0){
				boolavailableChanged=true;
				resultSearchTrack[j].Ava=3;		//3 download from server
				resultSearchTrack[j].ComName=fromComName;
			}
		}
	}
	if(boolavailableChanged){
		DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	}
	if(clientType == serverMode){
		var available_array= new Array();
		for(var i=0;i<resultSearchTrack.length;i++){
			if(resultSearchTrack[i].Ava!=0 or resultSearchTrack[i].ComName<>ComName){
				available_array.push(resultSearchTrack[i].trackID);
			}
		}
		fscommand("servers","refreshTrackAvailable&&&"+available_array);
	}
	delete(boolavailableChanged);
	delete(available_array);
}
function createTrackXml(album,uAlbum,trackTitle,utracktitle,artist,uArtist,mood,umood,dance,udance,Rating,genre,ugenre,language,mode,trackid,picpath,lanpath,lantrack,computername,trackyear,trackava,trackpath,walmartava,shoppingid,notrack,trackindex,trackbookmark,trackAudioChannel,trackseekOffset,trackPlayFrom) {
	var s_xml = new XML();
	var e_xml=s_xml.createElement("Track");
	e_xml.attributes.Album=album;	e_xml.attributes.UniAlbum=uAlbum;
	e_xml.attributes.Track=trackTitle;	e_xml.attributes.UniTrack=utracktitle;
	e_xml.attributes.Artist=artist;	e_xml.attributes.UniArtist=uArtist;
	e_xml.attributes.Mood=mood;	e_xml.attributes.UniMood=umood;
	e_xml.attributes.DanceStyle=dance;	e_xml.attributes.UniDanceStyle=udance;
	e_xml.attributes.Rating=Rating;	e_xml.attributes.Genre=genre;
	e_xml.attributes.UniGenre=ugenre;	e_xml.attributes.language=language;
	e_xml.attributes.Mode=mode;	e_xml.attributes.TrackID=trackid;
	e_xml.attributes.picPath=picpath;	e_xml.attributes.AlbumID=lanpath;
	e_xml.attributes.LanTrack=lantrack;	e_xml.attributes.ComName=computername;
	e_xml.attributes.TrackYear=trackyear;	e_xml.attributes.TrackAva=trackava;
	e_xml.attributes.TrackPath=trackpath;	e_xml.attributes.walMartAva=walmartava;
	e_xml.attributes.ShoppingID=ShoppingID;	e_xml.attributes.NoTrack=notrack;
	e_xml.attributes.TrackIndex=trackindex;
	e_xml.attributes.StPlayer=trackTitle+StOr+utracktitle+StPer+album+StOr+uAlbum+StPer+artist+StOr+uArtist+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle +StWave+UniPro+StWave+UniAlbumTitle;
	e_xml.attributes.Actor="";
	e_xml.attributes.Director="";
	e_xml.attributes.BookmarkTitle="";
	e_xml.attributes.BookmarkTime="";
	e_xml.attributes.ZoomLevel="";
	e_xml.attributes.BlankTop="";
	e_xml.attributes.BlankBottom="";
	e_xml.attributes.BookmarkLength="";
	e_xml.attributes.BookmarkChapter="";
	e_xml.attributes.MainTitle="";
	e_xml.attributes.AudioChannel=trackAudioChannel;
	e_xml.attributes.IsBookmark=trackbookmark;
	e_xml.attributes.SeekOffset=trackseekOffset;
	e_xml.attributes.PlayTrackFrom=trackPlayFrom;
	return e_xml;
}
//..........................FUNCTION PLAYALL............................
function PlayTrailerMovie (doc_xml) {
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
		
		if (clientType==serverMode or clientType==independentMode){
			fscommand("PlayTrack",Tid +"~"+LanPath1+"~" + trackno +"~"+LanName+"~"+walMart_Ava+"~"+"6");
			fscommand("SendPathPic",resultSearchArtistAlbum[RecordIndexArtistAlbum].Path);
			fscommand("SaveInPlayer",tt+StOr+tu+StPer+alb+StOr+albu+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
			fscommand("SaveInPlayList",alb+"%%"+albu+"%%"+tt+"%%"+tu+"%%"+art+"%%"+artu+"%%"+Md+"%%"+UniMd+"%%"+Dan+"%%"+UniDan+"%%"+Rat+"%%"+Gen+"%%"+UniGen+"%%"+ModeTrack+"%%"+Tid+"%%"+Pic+"%%"+Lan1+"%%"+ComName1+"%%"+LanPath1+"%%"+LanTrack+"%%"+YearTrack+"%%"+TrackAva+"%%"+walMart_Ava+"%%"+ShoppingID+"%%0%%0%%0%%0%%0%%0%%0%%0%%0%%0%%0%%0");
		}else{
			//trackTitle,utracktitle,artist,uArtist,mood,umood,dance,udance,Rating,genre,ugenre,language,mode,trackid,picpath,lanpath,lantrack,computername,trackyear,trackava,trackpath,walmartava,shoppingid,notrack,trackindex
			doc_xml.appendChild(createTrackXml(alb,albu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,Lan1,0,Tid,Pic,LanPath1,LanTrack,ComName1,YearTrack,TrackAva,"",walMart_Ava,ShoppingID,trackno,0,bookMarkType,audioChannel,seekOffset,6));
		}
}

function FuncPlayOne (Index,doc_xml) {
	//sith 18/11/06  allows add track unavailable
	if(resultSearchArtistAlbum[RecordIndexArtistAlbum].Ava!=0 or resultSearchTrack[Index].ComName<>ComName  or MusicNote=="true" ){
		// or resultSearchTrack[Index].ComName<>ComName or (resultSearchTrack[Index].walMart_Ava<>0 and NoInternetConnected=="0")){	
		var tt		=	resultSearchTrack[Index].trackTitle;
		var tu		=	resultSearchTrack[Index].unicodeTrackTitle;
		var art		=	resultSearchArtistAlbum[RecordIndexArtistAlbum].ArtistName;
		var artu	=	resultSearchArtistAlbum[RecordIndexArtistAlbum].unicodeArtistName;
		var Md		=	"";//resultSearchTrack[Index].Mood;
		var UniMd	=	"";//resultSearchTrack[Index].unicodeMood;
		var Dan		=	"";//resultSearchTrack[Index].danceStyle;
		var UniDan	=	"";//resultSearchTrack[Index].unicodeDanceStyle;
		var Gen		=	"";//resultSearchTrack[Index].Genre;
		var UniGen	=	"";//resultSearchTrack[Index].unicodeGenre;
		var walMart_Ava	=	0;//resultSearchTrack[Index].walMart_Ava;
		var ShoppingID	=	0;//resultSearchTrack[Index].ShoppingID;
		var Lan1		=	LanName;//Language of that Movie
		var ComName1	=	resultSearchTrack[Index].ComName;
		var LanTrack=	LanName;//resultSearchTrack[Index].LanTrack;
		var Rat		=	resultSearchTrack[Index].Rating;//resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank;//resultSearchTrack[Index].Rating;
		var Tid		=	resultSearchTrack[Index].trackID;
		var Pic		=	resultSearchArtistAlbum[RecordIndexArtistAlbum].StringPath;
		var LanPath1=	resultSearchArtistAlbum[RecordIndexArtistAlbum].id;
		var YearTrack=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Year;
		var TrackAva=	resultSearchArtistAlbum[RecordIndexArtistAlbum].Ava;
		var alb	 	=	StoreAlbum;
		var albu	=	StoreUniAlbum;
		var trackno	=	resultSearchTrack[Index].trackNo		//Index+1;
		var bookMarkType=(playchapterfile=="False" and (databaseType==8 or databaseType==4 or databaseType==16 ))? 4:0 ; 			//if the track is karaoke or music or CD then make it like bookmark
		var audioChannel=(databaseType==8 or databaseType==4)?playAudioChannel:0;
		if(offsetEnabled){
			var seekOffset=resultSearchTrack[Index].seekOffset;
		}else{
			var seekOffset=0;
		}
		if (clientType==serverMode or clientType==independentMode ){
			fscommand("PlayTrack",Tid +"~"+LanPath1+"~" + trackno +"~"+LanName+"~"+walMart_Ava);
			fscommand("SendPathPic",resultSearchArtistAlbum[RecordIndexArtistAlbum].Path);
			fscommand("SaveInPlayer",tt+StOr+tu+StPer+alb+StOr+albu+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
			fscommand("SaveInPlayList",alb+"%%"+albu+"%%"+tt+"%%"+tu+"%%"+art+"%%"+artu+"%%"+Md+"%%"+UniMd+"%%"+Dan+"%%"+UniDan+"%%"+Rat+"%%"+Gen+"%%"+UniGen+"%%"+ModeTrack+"%%"+Tid+"%%"+Pic+"%%"+Lan1+"%%"+ComName1+"%%"+LanPath1+"%%"+LanTrack+"%%"+YearTrack+"%%"+TrackAva+"%%"+walMart_Ava+"%%"+ShoppingID+"%%0%%0%%0%%"+bookMarkType+"%%0%%0%%0%%0%%0%%"+audioChannel+"%%"+seekOffset+"%%0");
		}else{
			//trackTitle,utracktitle,artist,uArtist,mood,umood,dance,udance,Rating,genre,ugenre,language,mode,trackid,picpath,lanpath,lantrack,computername,trackyear,trackava,trackpath,walmartava,shoppingid,notrack,trackindex,bookmarkType,audioChannel,seekOffset
			doc_xml.appendChild(createTrackXml(alb,albu,tt,tu,art,artu,Md,UniMd,Dan,UniDan,Rat,Gen,UniGen,Lan1,0,Tid,Pic,LanPath1,LanTrack,ComName1,YearTrack,TrackAva,"",walMart_Ava,ShoppingID,trackno,0,bookMarkType,audioChannel,seekOffset,0));
		}
	}
}
function FuncPlayAll(Index,FuncPlayMode) {
	var allTracks=eval( "Num"+TrackObj);
	var j=0;
	if (clientType==serverMode or clientType==independentMode){
		//fscommand("saveOldTrackCount");
	}else{
		var track_xml = new XML();
		var root_xml;
		root_xml=track_xml.createElement("PlayList");
	}
	if(FuncPlayMode=="One" or FuncPlayMode=="All"){
		FuncPlayOne (Index,root_xml);
	}else{//"Trailer"
		PlayTrailerMovie(root_xml);
	}
/*	
	if (FuncPlayMode==true){
		FuncPlayOne (Index,root_xml);
	}else {
		for (var k = Index; k<allTracks+Index; k++) {
			j= (k % allTracks)
			FuncPlayOne (j,root_xml);
		}
	}
*/	
	if (clientType==serverMode or clientType==independentMode){
		//fscommand("saveServerPlaylist");
	}else{
		track_xml.appendChild(root_xml);
		fscommand("savePlayTrack",track_xml);
		delete(track_xml);
	}
}
function ChangeUnicode(){
	if (MainLevel == 3 || MainLevel == 4) {
		DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
		DisplayArtistNameItem("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum, resultSearchArtistAlbum);
	} else if (MainLevel == 2) {
		DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
	} else if (Mainlevel ==1 and BrowseBy=="Alphabet"){
		if (ChangeLan == "Uni"){
			mainLetter_mc.readXmlLetter(GetPath + "\\alphabetUnicode.xml");
		} else {
			mainLetter_mc.readXmlLetter(GetPath + "\\alphabet.xml");
		}
		return
	}
	DisplayArtistNameItem("ArtistNameBar", IndexShowArtistName, CountArtistName, nArtistName, resultSeason);
	DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
	ChangeAlbumInfoFont(EngFont, UniFont, EngSize, UniSize, ChangeLan, SaveAlbumInfo, resultSearchArtistAlbum[RecordIndexArtistAlbum].idLan);
	DisplayTextGenre("GenreBar", IndexShowGenre, CountGenre, nGenre);	
}