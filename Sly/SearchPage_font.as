function ChangeProTitleFont(Obj,EngFont1, UniFont1, EngSize1, UniSize1, Lan,idLan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	eval(Obj).setTextFormat(FormatFont1);
}
function ChangeTextSearchingBox(Obj,EngFont1, UniFont1, EngSize1, UniSize1, Lan,idLan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize-8;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize-8;
		else UniSize1=StaticFontKhmerSize-8;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	eval(Obj).setTextFormat(FormatFont1);
}
function changeGenreListFont(EngFont1, UniFont1, EngSize1, UniSize1, Lan,Obj)
{
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	eval(Obj).setTextFormat(FormatFont1);

}

function getFontFormat(EngFont1, UniFont1, EngSize1, UniSize1, Lan){
	var FormatFont1 = new TextFormat();
	EngSize1=StaticFontSize;
	if (Lan == "Eng") {
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	return FormatFont1;
}
function ChangeTrackInfoFont(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	EngSize1=StaticFontSize;
/*
	if (Lan == "Eng") {
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	eval(TrackName).Mood.setTextFormat(FormatFont1);
	eval(TrackName).Dance.setTextFormat(FormatFont1);
	eval(TrackName).Artist.setTextFormat(FormatFont1);
*/
	FormatFont1.font = EngFont1;
	FormatFont1.size = EngSize1;
	FormatFont1.bold = true;
	eval(TrackName).TrackLen.setTextFormat(FormatFont1);
	eval(TrackName).Year.setTextFormat(FormatFont1);
	
}
function ChangeTrackFont(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
		eval(TrackName).TextLeft.text = "Previous";
		eval(TrackName).TextRight.text = "Next";
		eval(TrackName).TextRight._y=yNext+parseInt(TrackPosEng, 10);
		eval(TrackName).TextLeft._y=yNext+parseInt(TrackPosEng, 10);
/*		for (var j = 0; j<nTrack; j++) {
			eval(TrackName+".Text"+j).setTextFormat(FormatFont1);
			eval(TrackName+".Text"+j)._y = yTrack[j]+parseInt(TrackPosEng, 10);
			eval(TrackName).TextToolTip.text=eval(TrackName+".Text"+j).text;
			eval(TrackName).TextToolTip.setTextFormat(FormatFont1);
			if (int(eval(TrackName).TextToolTip._width)>int(eval(TrackName+".Text"+j)._width)) {
				eval(TrackName+".Do"+j).text="...";
			}
			else {
				eval(TrackName+".Do"+j).text=" ";
			}
		}*/
	} else {
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
		eval(TrackName).TextLeft.text = UniPreTrack;
		eval(TrackName).TextRight.text = UniNextTrack;
		eval(TrackName).TextRight._y=yNext+parseInt(TrackPosUni, 10);
		eval(TrackName).TextLeft._y=yNext+parseInt(TrackPosUni, 10);
/*		for (var j = 0; j<nTrack; j++) {
			eval(TrackName+".Text"+j).setTextFormat(FormatFont1);
			eval(TrackName+".Text"+j)._y = yTrack[j]+parseInt(TrackPosUni, 10);
			eval(TrackName).TextToolTip.text=eval(TrackName+".Text"+j).text;
			eval(TrackName).TextToolTip.setTextFormat(FormatFont1);
			if (int(eval(TrackName).TextToolTip._width)>int(eval(TrackName+".Text"+j)._width)) {
				eval(TrackName+".Do"+j).text="...";
			}
			else {
				eval(TrackName+".Do"+j).text=" ";
			}
		}*/
	}
	eval(TrackName).TextLeft.setTextFormat(FormatFont1);
	eval(TrackName).TextRight.setTextFormat(FormatFont1);
}
function ChangeInputText(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	InputText.setNewTextFormat(FormatFont1);
	InputText.setTextFormat(FormatFont1);
}
function ChangeTextButton(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	//sith 27/10/06 // always english for english
	Lan=(LanName.subString(0,3) == "Eng") ? "Eng" :  Lan; 
	changeLan=Lan;
	//
	BackNormal.displaytype.text0.autoSize=true;
	BackNormal.displaytype.text1.autoSize=true;
	BackNormal.BackListTrack.text0.autoSize=true;
	BackNormal.BackListTrack.text1.autoSize=true;
	BackNormal.BackListTrack.text2.autoSize=true;
	BackNormal.BackListGender.text0.autoSize=true;
	BackNormal.BackListGender.text1.autoSize=true;
	BackNormal.BackListGender.text2.autoSize=true;
	BackNormal.BackListGender.text3.autoSize=true;	
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
		BackAdvance.TextNormal.text	= 	EngNormal;
		BackAdvance.TextArtist.text		=	EngPro;
		BackAdvance.TextMood.text		=	EngMood;
		BackNormal.BackListRating.Text1.text	=	EngNonSelected;
		BackAdvance.TextTrack.text		=	EngTrack;
		BackAdvance.TextDance.text		=	EngDance;
		BackAdvance.TextGenre.text		=	EngGenre;
		BackAdvance.TextReset.text		=	EngReset;
		BackAdvance.BackListTrack.text0.text	=	EngAll;
		BackAdvance.BackListTrack.text1.text	=	EngTrackAva;
		BackAdvance.BackListTrack.text2.text	=	EngTrackNotAva;
	
		BackNormal.TextRating.text		=	EngRating;
		BackNormal.TextAdvance.text	=	EngAdvance;
		BackNormal.BackListTrack.text0.text	=	EngAll;
		BackNormal.BackListTrack.text1.text	=	EngTrackAva;
		BackNormal.BackListTrack.text2.text	=	EngTrackNotAva;
		BackNormal.BackListGender.text0.text	=	EngAll;
		BackNormal.BackListGender.text1.text	=	EngBoth;
		BackNormal.BackListGender.text2.text	=	EngMale;
		BackNormal.BackListGender.text3.text	=	EngFemale;
		BackNormal.TextAlbum.text		=	EngAlbumTitle;

		BackNormal.displaytype.text0.text 	= 	EngDisplayTypeA;
		BackNormal.displaytype.text1.text 	= 	EngDisplayTypeT;

		BackNormal.TextTrack.text		=	EngTrack;
		BackNormal.TextGender.text		=	EngGender;
		BackNormal.txtCountries.text		=	EngCountry;
		
		if(Grouping=="False")BackNormal.TextSorted.text=EngReleaseDate; else BackNormal.TextSorted.text=EngAlphabet;
		BackNormal.TextArtist.text=(databaseType ==4 or databaseType==8 or databaseType==16) ? EngSinger : EngActor;
		BackNormal.TextSong.text=(databaseType ==4 or databaseType==8 or databaseType==16) ? EngTrackTitle : EngDirector;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
		BackAdvance.TextNormal.text=UniNormal;
		BackAdvance.TextArtist.text=UniArtist;
		BackAdvance.TextMood.text=UniMood;
		BackNormal.BackListRating.Text1.text=UniNonSelected;
		BackAdvance.TextTrack.text=UniTrack;
		BackAdvance.TextDance.text=UniDance;
		BackAdvance.TextGenre.text=UniGenre;
		BackAdvance.TextReset.text=UniReset;
		BackNormal.TextRating.text=UniRating;
		BackNormal.TextAdvance.text=UniAdvance;
		
		
		BackNormal.BackListTrack.text0.text=UniNonSelected;
		BackNormal.BackListTrack.text1.text=UniTrackAva;
		BackNormal.BackListTrack.text2.text=UniTrackNotAva;
		
		BackNormal.BackListGender.text0.text=UniNonSelected;
		BackNormal.BackListGender.text1.text=UniBoth;
		BackNormal.BackListGender.text2.text=UniMale;
		BackNormal.BackListGender.text3.text=UniFemale;
		
		BackAdvance.BackListTrack.text0.text=UniNonSelected;
		BackAdvance.BackListTrack.text1.text=UniTrackAva;
		BackAdvance.BackListTrack.text2.text=UniTrackNotAva;

		BackNormal.displaytype.text0.text =( UniDisplayTypeA.length >0) ? UniDisplayTypeA  : EngDisplayTypeA ;
		BackNormal.displaytype.text1.text = (UniDisplayTypeT.length > 0) ? UniDisplayTypeT : EngDisplayTypeT ;
	
		BackNormal.TextArtist.text=UniArtist;
		BackNormal.TextAlbum.text=UniAlbumTitle;
		BackNormal.TextSong.text=UniTrackTitle;
		BackNormal.TextTrack.text=UniTrack;
		BackNormal.TextGender.text=UniGender;
		BackNormal.txtCountries.text=(UniCountry.length>0) ? UniCountry : EngCountry;
		if(Grouping=="False")BackNormal.TextSorted.text=UniReleaseDate;
		else BackNormal.TextSorted.text=UniAlphabet;
	}
	BackNormal.BackListRating.Text1.setTextFormat(FormatFont1);
	BackAdvance.TextNormal.setTextFormat(FormatFont1);
	BackAdvance.TextArtist.setTextFormat(FormatFont1);
	BackAdvance.TextMood.setTextFormat(FormatFont1);
	BackAdvance.TextRating.setTextFormat(FormatFont1);
	BackAdvance.TextTrack.setTextFormat(FormatFont1);
	BackAdvance.TextDance.setTextFormat(FormatFont1);
	BackAdvance.TextGenre.setTextFormat(FormatFont1);
	BackNormal.TextRating.setTextFormat(FormatFont1);
	BackNormal.txtCountries.setTextFormat(FormatFont1);
	
	BackNormal.BackListTrack.text0.setTextFormat(FormatFont1);
	BackNormal.BackListTrack.text1.setTextFormat(FormatFont1);
	BackNormal.BackListTrack.text2.setTextFormat(FormatFont1);
	BackAdvance.BackListTrack.text0.setTextFormat(FormatFont1);
	BackAdvance.BackListTrack.text1.setTextFormat(FormatFont1);
	BackAdvance.BackListTrack.text2.setTextFormat(FormatFont1);
	
	BackNormal.BackListGender.text0.setTextFormat(FormatFont1);
	BackNormal.BackListGender.text1.setTextFormat(FormatFont1);
	BackNormal.BackListGender.text2.setTextFormat(FormatFont1);
	BackNormal.BackListGender.text3.setTextFormat(FormatFont1);	

	BackNormal.displaytype.text0.setTextFormat(FormatFont1);
	BackNormal.displaytype.text1.setTextFormat(FormatFont1);
	
	BackNormal.TextArtist.setTextFormat(FormatFont1);
	BackNormal.TextAlbum.setTextFormat(FormatFont1);
	BackNormal.TextSong.setTextFormat(FormatFont1);
	BackNormal.TextTrack.setTextFormat(FormatFont1);
	BackNormal.TextGender.setTextFormat(FormatFont1);
	BackNormal.TextSorted.setTextFormat(FormatFont1);
	BackAdvance.TextReset.setTextFormat(FormatFont1);

	BackNormal.displaytype.text0._y =(BackNormal.displaytype.Movie0._height - BackNormal.displaytype.text0._height )/2+ BackNormal.displaytype.Movie0._y;
	BackNormal.displaytype.text1._y =(BackNormal.displaytype.Movie1._height - BackNormal.displaytype.text1._height )/2+ BackNormal.displaytype.Movie1._y;
	BackNormal.displaytype.text0._x =(BackNormal.displaytype.Movie0._width - BackNormal.displaytype.text0._width )/2+ BackNormal.displaytype.Movie0._x;
	BackNormal.displaytype.text1._x =(BackNormal.displaytype.Movie1._width - BackNormal.displaytype.text1._width )/2+ BackNormal.displaytype.Movie1._x;
	
	BackNormal.BackListTrack.text0._y =(BackNormal.BackListTrack.Movie0._height - BackNormal.BackListTrack.text0._height )/2+ BackNormal.BackListTrack.Movie0._y;
	BackNormal.BackListTrack.text1._y =(BackNormal.BackListTrack.Movie1._height - BackNormal.BackListTrack.text1._height )/2+ BackNormal.BackListTrack.Movie1._y;
	BackNormal.BackListTrack.text2._y =(BackNormal.BackListTrack.Movie2._height - BackNormal.BackListTrack.text2._height )/2+ BackNormal.BackListTrack.Movie2._y;

	BackNormal.BackListGender.text0._y =(BackNormal.BackListGender.Movie0._height - BackNormal.BackListGender.text0._height )/2+ BackNormal.BackListGender.Movie0._y;
	BackNormal.BackListGender.text1._y =(BackNormal.BackListGender.Movie1._height - BackNormal.BackListGender.text1._height )/2+ BackNormal.BackListGender.Movie1._y;
	BackNormal.BackListGender.text2._y =(BackNormal.BackListGender.Movie2._height - BackNormal.BackListGender.text2._height )/2+ BackNormal.BackListGender.Movie2._y;
	BackNormal.BackListGender.text3._y =(BackNormal.BackListGender.Movie3._height - BackNormal.BackListGender.text3._height )/2+ BackNormal.BackListGender.Movie3._y;

	BackNormal.BackListTrack.text0._x =(BackNormal.BackListTrack.Movie0._width - BackNormal.BackListTrack.text0._width )/2+ BackNormal.BackListTrack.Movie0._x;
	BackNormal.BackListTrack.text1._x =(BackNormal.BackListTrack.Movie1._width - BackNormal.BackListTrack.text1._width )/2+ BackNormal.BackListTrack.Movie1._x;
	BackNormal.BackListTrack.text2._x =(BackNormal.BackListTrack.Movie2._width - BackNormal.BackListTrack.text2._width )/2+ BackNormal.BackListTrack.Movie2._x;

	BackNormal.BackListGender.text0._x =(BackNormal.BackListGender.Movie0._width - BackNormal.BackListGender.text0._width )/2+ BackNormal.BackListGender.Movie0._x;
	BackNormal.BackListGender.text1._x =(BackNormal.BackListGender.Movie1._width - BackNormal.BackListGender.text1._width )/2+ BackNormal.BackListGender.Movie1._x;
	BackNormal.BackListGender.text2._x =(BackNormal.BackListGender.Movie2._width - BackNormal.BackListGender.text2._width )/2+ BackNormal.BackListGender.Movie2._x;
	BackNormal.BackListGender.text3._x =(BackNormal.BackListGender.Movie3._width - BackNormal.BackListGender.text3._width )/2+ BackNormal.BackListGender.Movie3._x;
}
function ChangeTextList(EngFont1, UniFont1, EngSize1, UniSize1, Lan,Obj) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	if(Obj!="All"){
		for(var j=0;j<nList;j++){
			eval(Obj+".Text"+j).setTextFormat(FormatFont1);
		}
	}
	else{
		for(var j=0;j<nList;j++){
			eval("BackAdvance.BackListArtist.Text"+j).setTextFormat(FormatFont1);
			eval("BackAdvance.BackListMood.Text"+j).setTextFormat(FormatFont1);
			eval("BackAdvance.BackListGenre.Text"+j).setTextFormat(FormatFont1);
			eval("BackAdvance.BackListDance.Text"+j).setTextFormat(FormatFont1);
			eval("BackAdvance.BackListTrack.Text"+j).setTextFormat(FormatFont1);
			eval("BackNormal.BackListTrack.Text"+j).setTextFormat(FormatFont1);
			eval("BackNormal.BackListGender.Text"+j).setTextFormat(FormatFont1);
		}
	}
}

function ChangeButton1(EngFont1, UniFont1, EngSize1, UniSize1, Lan,Obj) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
		
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;
	}
	eval(Obj).setTextFormat(FormatFont1);
}

function ChangeMovieFont(EngFont1, UniFont1, EngSize1, UniSize1,j, boolEnglish) {
	var FormatFont1 = new TextFormat();
	var fontsize=0;
	if (boolEnglish) {
		FormatFont1.font = EngFont1;
		EngSize1=StaticFontSize
		switch (NameAlbum) {
			case "SmallIcon":fontsize=EngSize1-5;break;//15
			case "BigIcon": fontsize = EngSize1;break;
			case "BBigIcon": fontsize = EngSize1+8;break;
			case "SmallIcons":fontsize=EngSize1-15;break;
			case "BigIcons": fontsize = EngSize1-8;break;
			case "BBigIcons": fontsize = EngSize1-0;break;
			
		}
//		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;
			FormatFont1.bold = true;
			if ((eval(NameAlbum+".Letter"+j).text!="")&&(NameAlbum == "BBigIcon" || NameAlbum == "SmallIcon" || NameAlbum == "BigIcon")){
				var tw = eval(NameAlbum+".Movie"+j)._width - (eval(NameAlbum+".Letter"+j)._x - eval(NameAlbum+".Movie"+j)._x);
				eval(NameAlbum+".Letter"+j).text = set_dot_dot(eval(NameAlbum+".Letter"+j),eval(NameAlbum+".Letter"+j).or_text,FormatFont1,tw);
				eval(NameAlbum+".Letter"+j).autoSize = true;
			}
			eval(NameAlbum+".Letter"+j).setTextFormat(FormatFont1);
			FormatFont1.size=fontsize-6;
			FormatFont1.bold = false;
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Letter"+j)._y=yAlbum[j]+(parseInt(TrackPosEng, 10));
//			}
		}
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		switch (NameAlbum) {
			case "SmallIcon":fontsize=UniSize1-5;break;//15
			case "BigIcon": fontsize = UniSize1;break;
			case "BBigIcon": fontsize = UniSize1+8;break;
			case "SmallIcons":fontsize=UniSize1-15;break;
			case "BigIcons": fontsize = UniSize1-8;break;
			case "BBigIcons": fontsize = UniSize1-0;break;
		}
		FormatFont1.bold = false;
//		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;

			if ((eval(NameAlbum+".Letter"+j).text!="")&&(NameAlbum == "BBigIcon" || NameAlbum == "SmallIcon" || NameAlbum == "BigIcon")){
				var tw = eval(NameAlbum+".Movie"+j)._width - (eval(NameAlbum+".Letter"+j)._x - eval(NameAlbum+".Movie"+j)._x);
				eval(NameAlbum+".Letter"+j).text = set_dot_dot(eval(NameAlbum+".Letter"+j),eval(NameAlbum+".Letter"+j).or_text,FormatFont1,tw);
				eval(NameAlbum+".Letter"+j).autoSize = true;
			}
			eval(NameAlbum+".Letter"+j).setTextFormat(FormatFont1);
			FormatFont1.size=fontsize-6;
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Letter"+j)._y=yAlbum[j]+(parseInt(TrackPosUni, 10));
//			}
		}
	}
}
function ChangeArtistFont(EngFont1, UniFont1, EngSize1, UniSize1,j, boolEnglish) {
	var FormatFont1 = new TextFormat();
	var fontsize=0;
	if (boolEnglish) {
		FormatFont1.font = EngFont1;
		EngSize1=StaticFontSize
		switch (NameAlbum) {
			case "SmallIcon":fontsize=EngSize1-5;break;//15
			case "BigIcon": fontsize = EngSize1;break;
			case "BBigIcon": fontsize = EngSize1+8;break;
			case "SmallIcons":fontsize=EngSize1-15;break;
			case "BigIcons": fontsize = EngSize1-8;break;
			case "BBigIcons": fontsize = EngSize1-0;break;
			
		}
//		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;
			FormatFont1.bold = true;
			FormatFont1.size=fontsize-6;
			FormatFont1.bold = false;
			eval(NameAlbum+".Artist"+j).setTextFormat(FormatFont1);
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Artist"+j)._y=yArtist[j]+(parseInt(TrackPosEng, 10));
			}
//		}
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		switch (NameAlbum) {
			case "SmallIcon":fontsize=UniSize1-5;break;//15
			case "BigIcon": fontsize = UniSize1;break;
			case "BBigIcon": fontsize = UniSize1+8;break;
			case "SmallIcons":fontsize=UniSize1-15;break;
			case "BigIcons": fontsize = UniSize1-8;break;
			case "BBigIcons": fontsize = UniSize1-0;break;
		}
		FormatFont1.bold = false;
//		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;
			FormatFont1.size=fontsize-6;
			eval(NameAlbum+".Artist"+j).setTextFormat(FormatFont1);
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Artist"+j)._y=yArtist[j]+(parseInt(TrackPosUni, 10));
			}
//		}
	}
}

function ChangeAlbumFont(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	var fontsize=0;
	if (Lan == "Eng") {
		FormatFont1.font = EngFont1;
		EngSize1=StaticFontSize
		switch (NameAlbum) {
			case "SmallIcon":fontsize=EngSize1-5;break;//15
			case "BigIcon": fontsize = EngSize1;break;
			case "BBigIcon": fontsize = EngSize1+8;break;
			case "SmallIcons":fontsize=EngSize1-15;break;
			case "BigIcons": fontsize = EngSize1-8;break;
			case "BBigIcons": fontsize = EngSize1-0;break;
			
		}
		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;
			FormatFont1.bold = true;
			if ((eval(NameAlbum+".Letter"+j).text!="")&&(NameAlbum == "BBigIcon" || NameAlbum == "SmallIcon" || NameAlbum == "BigIcon")){
				var tw = eval(NameAlbum+".Movie"+j)._width - (eval(NameAlbum+".Letter"+j)._x - eval(NameAlbum+".Movie"+j)._x);
				eval(NameAlbum+".Letter"+j).text = set_dot_dot(eval(NameAlbum+".Letter"+j),eval(NameAlbum+".Letter"+j).or_text,FormatFont1,tw);
				eval(NameAlbum+".Letter"+j).autoSize = true;
			}
			eval(NameAlbum+".Letter"+j).setTextFormat(FormatFont1);
			FormatFont1.size=fontsize-6;
			FormatFont1.bold = false;
			eval(NameAlbum+".Artist"+j).setTextFormat(FormatFont1);
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Letter"+j)._y=yAlbum[j]+(parseInt(TrackPosEng, 10));
				eval(NameAlbum+".Artist"+j)._y=yArtist[j]+(parseInt(TrackPosEng, 10));
			}
		}
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else UniSize1=StaticFontKhmerSize;
		FormatFont1.font = UniFont1;
		switch (NameAlbum) {
			case "SmallIcon":fontsize=UniSize1-5;break;//15
			case "BigIcon": fontsize = UniSize1;break;
			case "BBigIcon": fontsize = UniSize1+8;break;
			case "SmallIcons":fontsize=UniSize1-15;break;
			case "BigIcons": fontsize = UniSize1-8;break;
			case "BBigIcons": fontsize = UniSize1-0;break;
		}
		FormatFont1.bold = false;
		for (var j = 0; j<NumMovie; j++) {
			FormatFont1.size=fontsize;

			if ((eval(NameAlbum+".Letter"+j).text!="")&&(NameAlbum == "BBigIcon" || NameAlbum == "SmallIcon" || NameAlbum == "BigIcon")){
				var tw = eval(NameAlbum+".Movie"+j)._width - (eval(NameAlbum+".Letter"+j)._x - eval(NameAlbum+".Movie"+j)._x);
				eval(NameAlbum+".Letter"+j).text = set_dot_dot(eval(NameAlbum+".Letter"+j),eval(NameAlbum+".Letter"+j).or_text,FormatFont1,tw);
				eval(NameAlbum+".Letter"+j).autoSize = true;
			}
			eval(NameAlbum+".Letter"+j).setTextFormat(FormatFont1);
			FormatFont1.size=fontsize-6;
			eval(NameAlbum+".Artist"+j).setTextFormat(FormatFont1);
			if(DisplayAlbumLong=="true"){
				eval(NameAlbum+".Letter"+j)._y=yAlbum[j]+(parseInt(TrackPosUni, 10));
				eval(NameAlbum+".Artist"+j)._y=yArtist[j]+(parseInt(TrackPosUni, 10));
			}
		}
	}
}


function ChangeTextButtonSorted(EngFont1, UniFont1, EngSize1, UniSize1, Lan) {
	var FormatFont1 = new TextFormat();
	FormatFont1.bold = true;
	if (Lan == "Eng") {
		EngSize1=StaticFontSize;
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		
	} else {
		if(iKhmer!="1" )UniSize1=StaticFontSize;
		else {
			UniSize1=StaticFontKhmerSize;
			FormatFont1.bold = false;
		}
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		
	}
	BackNormal.TextSorted.setTextFormat(FormatFont1);
}

function ChangeAlbumInfoFont(EngFont1, UniFont1, EngSize1, UniSize1, Lan, RatLen) {
	var Spl1 = RatLen.split(StOr);
	var FormatFont1 = new TextFormat();
	EngSize1=StaticFontSize;
	if (Lan == "Eng") {
		FormatFont1.font = EngFont1;
		FormatFont1.size = EngSize1;
		FormatFont1.bold = true;
		BackAlbumInfo.ProductionName.text = spl1[2];
		BackAlbumInfo.AlbumTitle.text =resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
	} else {
		if(spl1[3].length<=0)BackAlbumInfo.ProductionName.text = spl1[2];
		else BackAlbumInfo.ProductionName.text = spl1[3];
		if(resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist.length<=0)BackAlbumInfo.AlbumTitle.text = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
		else BackAlbumInfo.AlbumTitle.text =resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
		
		FormatFont1.font = UniFont1;
		FormatFont1.size = UniSize1;
		FormatFont1.bold = false;	
	}
	BackAlbumInfo.AlbumLength.text = Spl1[1];
	BackAlbumInfo.ReleaseDate.text = Spl1[4];
	BackAlbumInfo.AlbumRating.text = Spl1[0];
	BackAlbumInfo.AlbumRating._visible=false;
	VisibleStarAlbumInfo(parseInt(BackAlbumInfo.AlbumRating.text,10));
	BackAlbumInfo.ProductionName.autoSize = "left";
	BackAlbumInfo.AlbumTitle.autoSize = "left";
	BackAlbumInfo.ProductionName.setTextFormat(FormatFont1);
	BackAlbumInfo.AlbumTitle.setTextFormat(FormatFont1);
	//...........
	FormatFont1.font = EngFont1;
	FormatFont1.size = EngSize1;
	FormatFont1.bold = true;
	BackAlbumInfo.ProductionName0.text = "Artist Name/Production";
	BackAlbumInfo.AlbumTitle0.text = "Album Title";
	BackAlbumInfo.AlbumLength0.text = "Length ";
	BackAlbumInfo.ReleaseDate0.text = "Release Date ";
	BackAlbumInfo.AlbumRating0.text = "Rating";
	
	BackAlbumInfo.ProductionName0.setTextFormat(FormatFont1);
	BackAlbumInfo.AlbumTitle0.setTextFormat(FormatFont1);
	BackAlbumInfo.AlbumLength0.setTextFormat(FormatFont1);
	BackAlbumInfo.ReleaseDate0.setTextFormat(FormatFont1);
	BackAlbumInfo.AlbumRating0.setTextFormat(FormatFont1);
	BackAlbumInfo.AlbumLength.setTextFormat(FormatFont1);
	BackAlbumInfo.ReleaseDate.setTextFormat(FormatFont1);
	
}


