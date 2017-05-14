var yTrack = new Array();

function ChangeTrackInfoFont(Lan,Country) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize-4;

	} else {
		if(getKhmerCountry(Country)=="1"){
			FormatFont1.font = FontKhmer;
			FormatFont1.size = SizeKhmer;
			FormatFont1.bold = false;
		}
		else {
			FormatFont1.font = UniFont;
			FormatFont1.size = StaticFontSize-4;
		}

	}
	eval(TrackName).Album.setTextFormat(FormatFont1);
	eval(TrackName).Artist.setTextFormat(FormatFont1);
	FormatFont1.font = EngFont;
	FormatFont1.size = StaticFontSize-4;

	eval(TrackName).TrackLen.setTextFormat(FormatFont1);
	eval(TrackName).TrackNo.setTextFormat(FormatFont1);
}
function ChangeTrackFont(Lan,Country,Index) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		//FormatFont1.font = EngFont;
		//FormatFont1.size = EngSize;

		//eval(TrackName + ".Text"+Index).setTextFormat(FormatFont1);
		//eval(TrackName + ".Text"+Index)._y = yTrack[Index]+parseInt(TrackPosEng, 10);
		//eval(TrackName).TextToolTip.text=eval(TrackName + ".Text"+Index).text;
		//eval(TrackName).TextToolTip.setTextFormat(FormatFont1);
		//if (int(eval(TrackName).TextToolTip._width)>int(eval(TrackName + ".Text"+Index)._width)) {
		//	eval(TrackName + ".Do"+Index).text="...";
		//}
		//else {
		//	eval(TrackName + ".Do"+Index).text=" ";
		//}
	} else {
		//if(Country=="Khmer"){
		//	FormatFont1.font = FontKhmer;
		//	FormatFont1.size = SizeKhmer;
		//	FormatFont1.bold = false;
		//}
		//else {
		//	FormatFont1.font = UniFont;
		//	FormatFont1.size = UniSize;
		//}

		//eval(TrackName + ".Text"+Index).setTextFormat(FormatFont1);
		//eval(TrackName + ".Text"+Index)._y = yTrack[Index]+parseInt(TrackPosUni, 10);
		//eval(TrackName).TextToolTip.text=eval(TrackName + ".Text"+Index).text;
		//eval(TrackName).TextToolTip.setTextFormat(FormatFont1);
		//if (int(eval(TrackName).TextToolTip._width)>int(eval(TrackName + ".Text"+Index)._width)) {
		//	eval(TrackName + ".Do"+Index).text="...";
		//}
		//else {
		//	eval(TrackName + ".Do"+Index).text=" ";
		//}
	}
}

function ChangeTrackFontPreNext(Lan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = EngSize;

		eval(TrackName).TextLeft.text = "Previous";
		eval(TrackName).TextRight.text = "Next";
	} else {
		if(iKhmer=="1"){
			FormatFont1.font = FontKhmer;
			FormatFont1.size = SizeKhmer;
			FormatFont1.bold = false;

		}
		else{
			FormatFont1.font = UniFont;
			FormatFont1.size = UniSize;

		}
		eval(TrackName).TextLeft.text = UniPreTrack;
		eval(TrackName).TextRight.text = UniNextTrack;
	}
	eval(TrackName).TextLeft.setTextFormat(FormatFont1);
	eval(TrackName).TextRight.setTextFormat(FormatFont1);
}


//...........................................
function ChangeProTitleFont(Lan,Country) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize-4;

	} else {
			if(Country=="1"){
				FormatFont1.font = FontKhmer;
				FormatFont1.size = StaticFontSize-4;
				FormatFont1.bold = false;
			}
			else {
				FormatFont1.font = UniFont;
				FormatFont1.size = StaticFontSize-4;

			}
	}
	TextTip.setTextFormat(FormatFont1);
}
function ChangeFontGenreBar(Lan,Country,Index) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize-10;

	} else {
	
			if(Country=="1"){
				FormatFont1.font = FontKhmer;
				FormatFont1.size = StaticFontSize-10;
				FormatFont1.bold = true;
			}
			else {
				FormatFont1.font = UniFont;
				FormatFont1.size = StaticFontSize-10;

			}
	}
	eval("AlbumBar.Text"+Index).setTextFormat(FormatFont1);
}


function ChangeAlbumInfoFont(Lan,RatLen) {
	var Spl1 = RatLen.split(StOr);
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize;
		BackAlbumInfo.ProductionName.text = spl1[2];
		BackAlbumInfo.AlbumTitle.text = resultAlbum[RecordIndexAlbum].Name;
	} else {
		if(spl1[3].length<=0)BackAlbumInfo.ProductionName.text = spl1[2];
		else BackAlbumInfo.ProductionName.text = spl1[3];
		if(resultAlbum[RecordIndexAlbum].UniName.length<=0)BackAlbumInfo.AlbumTitle.text = resultAlbum[RecordIndexAlbum].Name;
		else BackAlbumInfo.AlbumTitle.text = resultAlbum[RecordIndexAlbum].UniName;
		
		if(getKhmerCountry(resultAlbum[RecordIndexAlbum].Language)=="1"){
			FormatFont1.font = FontKhmer;
			FormatFont1.size = SizeKhmer;
			FormatFont1.bold = false;
			
		}
		else{
			FormatFont1.font = UniFont;
			FormatFont1.size = StaticFontSize;

		}
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
	FormatFont1.font = EngFont;
	FormatFont1.size = EngSize;

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
//..............SerachBox..............
function ChangeFontSearchbox(Lan,Language,Index) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize;
	} else {
			if(getKhmerCountry(Language)=="1"){
				FormatFont1.font = FontKhmer;
				FormatFont1.size = SizeKhmer;
				FormatFont1.bold = false;
			}
			else {
				FormatFont1.font = UniFont;
				FormatFont1.size = StaticFontSize;

			}
	}
	eval("SearchBox.ListResult.Text"+Index).setTextFormat(FormatFont1);
}

function ChangeInputText(Lan) {
	var FormatFont1 = new TextFormat();
	if (Lan == "Eng") {
		FormatFont1.font = EngFont;
		FormatFont1.size = StaticFontSize;
	} else {
			if(iKhmer=="1"){
				FormatFont1.font = FontKhmer;
				FormatFont1.size = SizeKhmer;
				FormatFont1.bold = false;
			}
			else {
				FormatFont1.font = UniFont;
				FormatFont1.size = StaticFontSize;

			}
	}
	SearchBox.InputBox.setTextFormat(FormatFont1);
	SearchBox.InputBox.setNewTextFormat(FormatFont1);
}
