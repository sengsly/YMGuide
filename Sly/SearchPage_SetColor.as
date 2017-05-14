////..............................................COLOR SETTING.....................................
var displayTypeUni=displayTypeUni1=UniArtist=UniMood=UniGenre=UniNormal=UniAdvance=UniRating=UniDance=UniTrack=UniNonSelected=UniTrackNotAva=UniTrackAva=UniReset=UniAlbum=UniReleaseDate=UniAlphabet="";
var UniAlbumTitle = "";
var UniPro="";
var UniPreTrack, UniNextTrack = "";
var BgColorValue,ChangeLang, EngFont, UniFont, EngSize, UniSize, TrackPosUni, TrackPosEng,Adv,Auto;
var SelectColorValue, SetColorValue, ButtonAlpha, ButtonSelAlpha, FontColor;
var PlayMode="Play One Track";
var PlayModeAlbum="";
var KhmerFont,SizeFont;
var StoreNameSelected = "";


var	EngNormal	= "Normal";
var 	EngAdvance	= "Advance";
var	EngArtist	= "Artist";
var	EngPro		= "Production";
var	EngMood		= "Mood";
var	EngRating	= "Rating";
var	EngNonSelected	= "None Selected";
var 	EngTrack	= "Track Types"
var	EngDance	= "Dance Style";
var	EngGenre	= "Genre";
var	EngGender	= "Gender";
var	EngReset	= "Reset";
var 	EngTrackAva	= "Available";
var 	EngTrackNotAva	= "Not Available";
var	EngBoth		= "Both";
var	EngMale		= "Male";
var	EngFemale	= "Female"
var	EngAll		= "All";
var	EngSinger	= "Singer"
var	EngActor	= "Actor";
var	EngAlbumTitle	= "DVD Title"
var	EngDisplayTypeA	= "Display Album"
var	EngDisplayTypeT	= "Display Track"
var	EngTrackTitle	= "Track Title"
var	EngDirector	= "Director"
var	EngReleaseDate	= "By Date"
var	EngAlphabet	= "By Alphabet"
var	EngCountry	= "Countries"




function LoadXmlLanguage(St) {
	var SettingXml = new XML();
	TopBar.Flag.loadMovie(MainPathImage+"\\Folder.jpg");
	SettingXml.load(GetPath+"\\Language.xml");
	SettingXml.onLoad = function() {
		EngFont = SettingXml.childNodes[0].childNodes[0].attributes.FontEng;
		UniFont = SettingXml.childNodes[0].childNodes[0].attributes.FontUni;
		if(WideScreen!="Normal" &&  WideScreen!="smallWideScreen" &&  WideScreen!="largeWideScreen"){
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSizeWide, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSizeWide,10);
		}
		else{
			EngSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontEngSize, 10);
			UniSize = parseInt(SettingXml.childNodes[0].childNodes[0].attributes.FontUniSize,10);
		}
		delete(WideScreen);
		TrackPosEng = SettingXml.childNodes[0].childNodes[0].attributes.TrackPos;
		TrackPosUni = SettingXml.childNodes[0].childNodes[0].attributes.TrackPosUni;
		
		UniPro = SettingXml.childNodes[0].childNodes[1].attributes.UniPro;
		UniAlbumTitle = SettingXml.childNodes[0].childNodes[1].attributes.UniAlbumTitle;
		UniPreTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniPreTrack;
		UniNextTrack = SettingXml.childNodes[0].childNodes[1].attributes.UniNextTrack;


		UniReset=SettingXml.childNodes[0].childNodes[1].attributes.Reset;
		UniReleaseDate=SettingXml.childNodes[0].childNodes[1].attributes.UniReleaseDate;
		UniAlphabet=SettingXml.childNodes[0].childNodes[1].attributes.Alphabet;
		UniTrackTitle=SettingXml.childNodes[0].childNodes[1].attributes.UniTrackTitle;

//		UniReleaseDate=(String(UniReleaseDate)=="") ? BackNormal.TextSorted.text :UniReleaseDate;
//		UniAlphabet =(String(UniAlphabet)=="") ?  "Sort By Alphabet" : 	UniAlphabet;		
//		UniTrackTitle=(String(UniTrackTitle)=="") ? BackNormal.TextSong.text :UniTrackTitle;

		UniArtist=SettingXml.childNodes[0].childNodes[1].attributes.Artist;
		UniMood=SettingXml.childNodes[0].childNodes[1].attributes.Mood;
		UniGenre=SettingXml.childNodes[0].childNodes[1].attributes.Genre;
		UniNormal=SettingXml.childNodes[0].childNodes[1].attributes.Normal;
		UniAdvance=SettingXml.childNodes[0].childNodes[1].attributes.Advance;
		UniRating=SettingXml.childNodes[0].childNodes[1].attributes.Rating;
		UniDance=SettingXml.childNodes[0].childNodes[1].attributes.DanceStyle;
		UniTrack=SettingXml.childNodes[0].childNodes[1].attributes.TrackType;
		UniNonSelected=SettingXml.childNodes[0].childNodes[1].attributes.NoSelect;
		UniTrackNotAva=SettingXml.childNodes[0].childNodes[1].attributes.NotAvaTrack;
		UniTrackAva=SettingXml.childNodes[0].childNodes[1].attributes.AvaTrack;
		UniDisplayTypeA=SettingXml.childNodes[0].childNodes[1].attributes.displayTypeUni;		
		UniDisplayTypeT=SettingXml.childNodes[0].childNodes[1].attributes.displayTypeUni1;
		UniCountry = SettingXml.childNodes[0].childNodes[1].attributes.UniCountry;
		
		UniMale   =	SettingXml.childNodes[0].childNodes[1].attributes.Male;
		UniFemale =	SettingXml.childNodes[0].childNodes[1].attributes.Female;
		UniBoth   =	SettingXml.childNodes[0].childNodes[1].attributes.Both;
		UniGender=	SettingXml.childNodes[0].childNodes[1].attributes.Gender;
		LoadSetting(St);
		ChangeTextButton(EngFont, UniFont, EngSize, UniSize, ChangeLan) ;
		iSearchAvailable=int(iSearchAvailable);				//Get from LoadSwfSearchPage
		if(iSearchAvailable>2){
			iSearchAvailable=2;
		}else if(iSearchAvailable<0){
			iSearchAvailable=0;
		}
		eval("BackAdvance.BackListTrack.Button"+iSearchAvailable).onRelease();
		SelectedItem("BackNormal.BackListGender",SearchGender);
		BackNormal.TextGender.text=eval("BackNormal.BackListGender.Text"+SearchGender).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackNormal.TextGender");
		KeyBoard.ChangeKeyBoardColor();
		SelGender=SearchGender;
		TopBar.ButtonM.onRollover();

	};
}
///............................setting................
Bg._visible=false;
var NumMovie=0;
var PlusCover=0;
var ColorRating="";
var HideMouse="false";
function LoadSetting(St) {
	var SplitSt=St.split("~");
	BgColorValue = SplitSt[0];
	ChangeColorNoAlpha("Bg", BgColorValue);
	Bg._visible=true;
	//var StNumMovie=SplitSt[1];
	if(DisplayAlbumLong=="true"){
		if (StNumMovie == "Small") {
			NameAlbum = "SmallIcon";
			ScaleW=ScaleSmall;
			NumMovie = nSmall;
		} else if (StNumMovie == "Medium") {
			NameAlbum = "BigIcon";
			ScaleW=ScaleMedium;
			NumMovie = nMedium;
		} else {
			NameAlbum = "BBigIcon";
			NumMovie = nLarge;
			ScaleW=ScaleLarge;
		}
	}
	else{ //Display Album as short Icon......
		if (StNumMovie == "Small") {
			NameAlbum = "SmallIcons";
			ScaleW=ScaleSmalls;
			NumMovie = nSmalls;
		} else if (StNumMovie == "Medium") {
			NameAlbum = "BigIcons";
			ScaleW=ScaleMediums;
			NumMovie = nMediums;
		} else {
			NameAlbum = "BBigIcons";
			NumMovie = nLarges;
			ScaleW=ScaleLarges;
		}
	}
	//.........
	PicX=GetXYcor(NameAlbum,"x");
	PicY=GetXYcor(NameAlbum,"y");
	ActiveButtonAlbum(NameAlbum);
	AlbumCover = SplitSt[2];
	NumCover = SplitSt[3];
	//...........
	SetColorValue = SplitSt[6];
	ButtonAlpha = SplitSt[7];
	SelectColorValue = SplitSt[8];
	ButtonSelAlpha =SplitSt[9];
	FontColor = SplitSt[10];
	ChangeLan = SplitSt[13];
//	InputText._visible=false;
	if(LanName=="English"){
		ChangeLan="Eng";
	}
	Adv=SplitSt[12];
//	TopBar.ButtonM.onRelease();   //sith need reload
	showHideSearch(false,false); 
	Auto=SplitSt[11];
	PlayModeAlbum = SplitSt[14];
	PlayAll.Text.text=PlayModeAlbum;
	if(PlayAll.Text.text=="One")PlayAll.Icon2._visible=false;
	PlayMode=SplitSt[15];
	SelectMode=SplitSt[17];
	PlusCover=SplitSt[20];
	ChangeColorBar(SplitSt[23]);
	ColorRating=SplitSt[26];
	HideMouse=SplitSt[27];
	if(HideMouse=="true"){
		Mouse.hide();
	}
	fscommand("RequestCountry");
	if(StoreQSearch.length>0){
		var spl=StoreQSearch.split("&&")
		if(spl[2]==0){
			iSearchAvailable=2;
		}else if(spl[2]==1){
			iSearchAvailable=1;
		}else if(spl[2]==3){
			iSearchAvailable=0;
		}
		BackNormal.displayType.Button1.onRelease();		
		fscommand("SearchByProductionOrArtist",StoreQSearch);
	} else if (StoreSearchTrack.length>0) {
		SelectMode="Song";
		var spl=StoreSearchTrack.split("&&")
		if(spl[2]==0){
			iSearchAvailable=2;
		}else if(spl[2]==1){
			iSearchAvailable=1;
		}else if(spl[2]==3){
			iSearchAvailable=0;
		}
		StrSearch = spl[0];
		StrSearch += "&";
		StrSearch += "&";
		StrSearch += "&";
		StrSearch += "&";
		StrSearch += "&";
		StrSearch += "&" + spl[2];
		StrSearch += "&" + ChangeLan;
		StrSearch +=  "&"+ SearchGender;
		StrSearch +=  "&1";					//Search Start Letter
		if(spl[1]==4 or spl[1]==8){
			fscommand("StartSearchTrack", StrSearch);
		}else{
			fscommand("StartSearch", StrSearch);
		}
//		ClickOptNormal("BackNormal.ButtonSong");
//		SelectMode0="Song";
	}
	if(SelectMode=="Song"){
		
		ClickOptNormal("BackNormal.ButtonSong");
		SelectMode0="Song";
	}
	else if(SelectMode=="Album"){
		ClickOptNormal("BackNormal.ButtonAlbum");
		SelectMode0="Album";
	}
	else if(SelectMode=="Artist"){
		ClickOptNormal("BackNormal.ButtonArtist");
		SelectMode0="Artist";			//tell that it is in album page
	}
	eval(TrackName).ButtonPlay.Text.text=PlayMode;
	if(eval(TrackName).ButtonPlay.Text.text=="Play One Track"){
		eval(TrackName).ButtonPlay.Icon1._visible=true;
		eval(TrackName).ButtonPlay.Icon2._visible=false;
	}
	ChangeColorAndAlpha(SetColorValue, ButtonAlpha);
	SetFontColor(FontColor);
	TopBar.ButtonM.onRollOver();
	TopBar._visible=true;
	ResetValueListItem();
}
function ChangeColorBar(Value){
	TrackShow.setTrackDisplayTheme(FontColor,Value);
	ChangeColor("ButtonTip", Value, 100);
	ChangeColor("BackNormal.Bar", Value, 100);
	ChangeColor("Menu.Bar", Value, 100);
	ChangeColor("MenuMISC.Bar", Value, 100);
	ChangeColor("TopBar.Bar", Value, 100);
	ChangeColor("BackAdvance.Bar", Value, 100);
	ChangeColor("BackAdvance.BackListArtist.Bg", Value, 100);
	ChangeColor("BackAdvance.BackListMood.Bg", Value, 100);
	ChangeColor("BackAdvance.BackListDance.Bg", Value, 100);
	ChangeColor("BackNormal.BackListCountries.Bg", Value, 100);
	ChangeColor("BackAdvance.BackListGenre.Bg", Value, 100);
	ChangeColor("BackNormal.BackListRating.Bg", Value, 100);
	ChangeColor("BackAdvance.BackListTrack.Bg", Value, 100);
	ChangeColor("BackNormal.BackListTrack.Bg", Value, 100);
	ChangeColor("VolBar.Bar", Value, 100);
	ChangeColor("ArrowBar.Bar", Value, 100);
	ChangeColor("SearchingBox.bg", Value, 100);
}
function SetFontColor(FontColor1) {
	Menu.AboutSly.Text.textColor=FontColor1;
	Menu.MISC.Text.textColor=FontColor1;
	Menu.MISC.Arrow.textColor=FontColor1;
	Menu.MISC.Arrow._visible=true;
	MenuMISC.UpDateDB.Text.textColor=FontColor1;
	MenuMISC.RestoreDB.Text.textColor=FontColor1;
	MenuMISC.BackUpDB.Text.textColor=FontColor1;
	MenuMISC.CopyFolder.Text.textColor=FontColor1;
	MenuMISC.AddNewScreen.Text.textColor=FontColor1;
	
	TextTip.textColor=SelectColorValue;
	ArrowBar.Text.textColor=SelectColorValue;
	AlbumInfo.Text.textColor=FontColor1;
	eval(TrackName).ShowPlayer.Text.textColor=FontColor1;
	eval(TrackName).ShowRip.Text.textColor=FontColor1;
	eval(TrackName).SearchArtist.Text.textColor=FontColor1;
	var FormatFont1 = new TextFormat();
	FormatFont1.font = EngFont;
	FormatFont1.size = EngSize;
	FormatFont1.bold = true;
	
	
	eval(TrackName).TextLeft.textColor = FontColor1;
	eval(TrackName).TextRight.textColor = FontColor1;
	eval(TrackName).TrackLen.textColor = FontColor1;
	eval(TrackName).Year.textColor = FontColor1;
	eval(TrackName).Mood.textColor = FontColor1;
	eval(TrackName).Dance.textColor = FontColor1;
	eval(TrackName).Artist.textColor = FontColor1;
	eval(TrackName).TextToolTip.textColor = FontColor1;
	//for (var j = 0; j<nTrack; j++) {
		//eval(TrackName+".Do"+j).textColor = FontColor1;
	//}
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Year"+j).textColor = SelectColorValue;
		eval(NameAlbum+".Letter"+j).textColor = FontColor1;
		eval(NameAlbum+".Artist"+j).textColor = SelectColorValue;
		eval(NameAlbum+".Num"+j).textColor = SelectColorValue;
	}
	for(var j=0;j<nVol;j++){
		eval("VolBar.Text"+j).textColor = FontColor1;
		eval("ArrowBar.Text"+j).textColor = FontColor1;
		eval("PurchaseCDMode.Text"+j).textColor = FontColor1;
		eval("PurchaseCDMode.TextCart"+j).textColor = FontColor1;
	}
	for(var j=0;j<nList;j++){
		eval("BackAdvance.BackListArtist.Text"+j).textColor=FontColor1;
		eval("BackAdvance.BackListMood.Text"+j).textColor=FontColor1;
		eval("BackAdvance.BackListDance.Text"+j).textColor=FontColor1;
		eval("BackAdvance.BackListGenre.Text"+j).textColor=FontColor1;
		eval("BackAdvance.BackListTrack.Text"+j).textColor=FontColor1;
		
		eval("BackNormal.BackListTrack.Text"+j).textColor=FontColor1;
		eval("BackNormal.BackListGender.Text"+j).textColor=FontColor1;
		eval("BackNormal.BackListCountries.Text"+j).textColor=FontColor1;
	}
	
	//PlayAll.Text.textColor = FontColor1;
	AlbumInfo.Text.textColor = FontColor1;
	PreAlbum.Text.textColor = FontColor1;
	NextAlbum.Text.textColor = FontColor1;
	//InputText.textColor=FontColor1;
	Menu.Exit.Text.textColor=FontColor1;
	Menu.Min.Text.textColor=FontColor1;
	Menu.Scan.Text.textColor=FontColor1;
	Menu.RipCD.Text.textColor=FontColor1;
	//Menu.Player.Text.textColor=FontColor1;
	FormatFont1.size =StaticFontSize;
	//Menu.Exit.Text.setTextFormat(FormatFont1);
	//Menu.Min.Text.setTextFormat(FormatFont1);
	//Menu.Scan.Text.setTextFormat(FormatFont1);
	//Menu.RipCD.Text.setTextFormat(FormatFont1);
	//Menu.Player.Text.setTextFormat(FormatFont1);
	
	//BackNormal.TextArtist.setTextFormat(FormatFont1);
	//BackNormal.TextAlbum.setTextFormat(FormatFont1);
	//BackNormal.TextSorted.setTextFormat(FormatFont1);
	//BackNormal.TextSong.setTextFormat(FormatFont1);
	//BackNormal.TextTrack.setTextFormat(FormatFont1);
	
	BackAdvance.TextNormal.textColor=FontColor1;
	BackAdvance.TextGenre.textColor=FontColor1;
	BackAdvance.TextA.textColor=FontColor1;
	BackAdvance.TextArtist.textColor=FontColor1;
	BackAdvance.TextRating.textColor=FontColor1;
	BackAdvance.TextMood.textColor=FontColor1;
	BackAdvance.TextDance.textColor=FontColor1;
	BackAdvance.TextTrack.textColor=FontColor1;
	BackAdvance.TextReset.textColor=FontColor1;
	
	BackNormal.TextA.textColor=FontColor1;
	BackNormal.TextRating.textColor=FontColor1;
	BackNormal.TextTrack.textColor=FontColor1;
	BackNormal.TextGender.textColor=FontColor1;
	BackNormal.TextSorted.textColor=FontColor1;
	BackNormal.txtCountries.textColor=FontColor1;
	BackNormal.TextArtist.textColor=FontColor1;
	BackNormal.TextAlbum.textColor=FontColor1;
	BackNormal.TextSong.textColor=FontColor1;
	
	TopBar.TextProTitle.textColor = FontColor1;
	TopBar.TextProTitle.setTextFormat(FormatFont1);
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
	ChangeColor(StoreNameSelected, SetColorValue, ButtonAlpha);
	ChangeColor(Obj, SelectColorValue, ButtonSelAlpha);
	ObjectName = Replace(Obj,"Movie","Button")
	StoreNameSelected = String(Obj);
}
function ChangeColorAndAlpha(ColorValue1, Alpha1) {
	ChangeColor("TopBar.MovieM", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieB", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieS", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieP", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieC", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieL", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieO", ColorValue1, Alpha1);
	ChangeColor("TopBar.MovieX", ColorValue1, Alpha1);
	
	//ChangeColor(TrackName+".PlusIcon", FontColor, Alpha1);
	//ChangeColor(TrackName+".Rank.ButtonLeft", FontColor, Alpha1);
	//ChangeColor(TrackName+".Rank.ButtonRight", FontColor, Alpha1);
	//ChangeColor(TrackName+".CDIcon", FontColor, Alpha1);
	ChangeColor(TrackName+".MovieRight", ColorValue1, Alpha1);
	ChangeColor(TrackName+".MovieLeft", ColorValue1, Alpha1);
	ChangeColor(TrackName+".ButtonPlay.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".ShowPlayer.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".ShowRip.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".SearchArtist.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".SearchArtist.MovieSel", SelectColorValue, Alpha1);
	ChangeColor(TrackName+".PlusIcon.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".MusicNote.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".PathSlideshow.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".RefreshCoverArt.Movie", ColorValue1, Alpha1);
	ChangeColor(TrackName+".ScanAlbum.Movie",ColorValue1,Alpha1);
	ChangeColor(TrackName+".PathChapter.Movie",ColorValue1,Alpha1);
	ChangeColor(TrackName+".chkOffset.Movie",ColorValue1,Alpha1);
	ChangeColor(TrackName+".BackStars.Movie1", ColorValue1, Alpha1);
	ChangeColor(TrackName+".BackStars.Movie2", ColorValue1, Alpha1);
	ChangeColor(TrackName+".BackStars.Movie3", ColorValue1, Alpha1);
	ChangeColor(TrackName+".BackStars.Movie4", ColorValue1, Alpha1);
	ChangeColor(TrackName+".BackStars.Movie5", ColorValue1, Alpha1);
	ChangeColor(TrackName+".chkDisplay.Movie", ColorValue1, Alpha1);
	ChangeColor("BackAlbumPic.Movie", ColorValue1, Alpha1);
	for (var j = 0; j<nTrack; j++) {
		ChangeColor(TrackName+".Movie"+j, ColorValue1, Alpha1);
	}
	for (var j = 0; j<NumMovie; j++) {
		ChangeColor(NameAlbum+".Movie"+j, ColorValue1, Alpha1);
		//ChangeColor(NameAlbum+".Rank"+j+".ButtonLeft", FontColor, Alpha1);
		//ChangeColor(NameAlbum+".Rank"+j+".ButtonRight", FontColor, Alpha1);
		//ChangeColor(NameAlbum+".Plus"+j+".Selected", FontColor, Alpha1);
		//ChangeColor(NameAlbum+".CDIcon"+j, FontColor, Alpha1);
		//eval(NameAlbum+".Rank"+j+".Text").textColor=FontColor;
	}
	for (var j=0;j<nVol;j++){
		ChangeColor("VolBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("ArrowBar.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("PurchaseCDMode.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("PurchaseCDMode.MovieCart"+j, ColorValue1, Alpha1);
	}
	ChangeColor("PurchaseCDMode.MovieClose", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieArrowLeft", ColorValue1, Alpha1);
	ChangeColor("VolBar.MovieArrowRight", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieRight", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieArrowLeft", ColorValue1, Alpha1);
	ChangeColor("ArrowBar.MovieArrowRight", ColorValue1, Alpha1);
	
	
	ChangeColor("Menu.Exit.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.RipCD.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Min.Movie", ColorValue1, Alpha1);
	ChangeColor("Menu.Scan.Movie", ColorValue1, Alpha1);
	//ChangeColor("Menu.Player.Movie", ColorValue1, Alpha1);
	
	//--------------------------Add Track By Code ID------------------------------------
	ChangeColor("AddTrackBox.MovieK", ColorValue1, Alpha1);
	ChangeColor("AddTrackBox.MovieCancel", ColorValue1, Alpha1);
	ChangeColor("AddTrackBox.MovieOK", ColorValue1, Alpha1);	
	
	var AlphaList=Alpha1;
	for (var j=0;j<nList;j++) {
		ChangeColor("BackAdvance.BackListArtist.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackNormal.BackListRating.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackAdvance.BackListMood.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackAdvance.BackListDance.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackAdvance.BackListGenre.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackAdvance.BackListTrack.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackNormal.BackListTrack.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackNormal.BackListGender.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackNormal.BackListCountries.Movie"+j, ColorValue1, Alpha1);
		ChangeColor("BackAlbumInfo.BackStars.Movie"+(j+1),ColorValue1,Alpha1);

	}
	ChangeColor("BackAdvance.BackListArtist.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("BackAdvance.BackListArtist.MovieRight", ColorValue1, Alpha1);
	ChangeColor("BackAdvance.BackListMood.MovieLeft",ColorValue1,Alpha1);
	ChangeColor("BackAdvance.BackListMood.MovieRight", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.BackListDance.MovieLeft", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.BackListDance.MovieRight", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.BackListGenre.MovieRight", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.BackListGenre.MovieLeft", ColorValue1, AlphaList);
	
	//................
	ChangeColor("AddNewScreens.Bar", ColorValue1, Alpha1);
	for(var j=0;j<nScreen;j++){
		ChangeColor("AddNewScreens.Button"+j+".chk", ColorValue1, Alpha1);
		ChangeColor("AddNewScreens.Movie"+j, ColorValue1, Alpha1);
	}
	ChangeColor("AddNewScreens.MovieLeft", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieRight", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieOk", ColorValue1, Alpha1);
	ChangeColor("AddNewScreens.MovieCancel", ColorValue1, Alpha1);

	///
	
	
	ChangeColor("BackAdvance.MovieSearch", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieNormal", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieRating", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieMood", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieGenre", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieDance", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieTrack", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieReset", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieA", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieText", ColorValue1, AlphaList);
	ChangeColor("BackAdvance.MovieArtist", ColorValue1, AlphaList);
	
	ChangeColor("BackNormal.MovieSearch", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieRating", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieTrack", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieGender", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieSorted", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieCountries", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieArtist", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieAlbum", ColorValue1, AlphaList);
	ChangeColor("BackNormal.displayType.Movie0", ColorValue1, Alpha1);
	ChangeColor("BackNormal.displayType.Movie1", ColorValue1, Alpha1);

	ChangeColor("BackNormal.MovieSong", ColorValue1, AlphaList);
	ChangeColor("BackNormal.MovieA", ColorValue1, AlphaList);
	ChangeColor("BackNormal.ButtonArtist.Selected", SelectColorValue, AlphaList);
	ChangeColor("BackNormal.ButtonAlbum.Selected", SelectColorValue, AlphaList);
	ChangeColor("BackNormal.ButtonSong.Selected", SelectColorValue, AlphaList);
	
	ChangeColor("PlayAll.Movie", ColorValue1, Alpha1);
	ChangeColor("AlbumInfo.Movie", ColorValue1, Alpha1);
	ChangeColor("ButtonCD.Movie", ColorValue1, Alpha1);
	ChangeColor("PreAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("NextAlbum.Movie", ColorValue1, Alpha1);
	ChangeColor("TopBar.Letter.Movie", SelectColorValue, Alpha1);
	ChangeColor("SearchingBox.MovieStop", ColorValue1, Alpha1);
	ChangeColor("SearchingBox.ButtonBar", ColorValue1, Alpha1);
	SetColorMisc(ColorValue1, Alpha1);
}
function SetColorMisc(Value,Alpha){
	ChangeColor("Menu.AboutSly.Movie", Value, Alpha);
	ChangeColor("Menu.MISC.Movie", Value, Alpha);
	
	ChangeColor("MenuMISC.UpDateDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.RestoreDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.BackUpDB.Movie", Value, Alpha);
	ChangeColor("MenuMISC.CopyFolder.Movie", Value, Alpha);
	ChangeColor("MenuMISC.AddNewScreen.Movie", Value, Alpha);
	//............
	ChangeColor("UpDateDB.Bar", Value, Alpha);
	ChangeColor("BackUpDB.Bar", Value, Alpha);
	ChangeColor("RestoreDB.Bar", Value, Alpha);
	ChangeColor("CopyMusic.Bar", Value, Alpha);
	//..............
	ChangeColor("WarningUpdate.Bar", Value, Alpha);
	ChangeColor("WarningUpdate.MovieOk", Value, Alpha);
	ChangeColor("WarningUpdate.MovieCancel", Value, Alpha);
	//.............
	ChangeColor("UpdateDB.MovieOk", Value, Alpha);
	ChangeColor("UpdateDB.MovieCancel", Value, Alpha);
	ChangeColor("UpdateDB.MovieBrowseDB", Value, Alpha);
	ChangeColor("UpdateDB.MovieDownLoad", Value, Alpha);
	//..................
	ChangeColor("BackUpDB.MovieOk", Value, Alpha);
	ChangeColor("BackUpDB.MovieCancel", Value, Alpha);
	ChangeColor("BackUpDB.MovieBrowseDB", Value, Alpha);
	//...................
	ChangeColor("RestoreDB.MovieOk", Value, Alpha);
	ChangeColor("RestoreDB.MovieCancel",Value, Alpha);
	ChangeColor("RestoreDB.MovieBrowseDB", Value, Alpha);
	//.................
	ChangeColor("CopyMusic.MovieOk", Value, Alpha);
	ChangeColor("CopyMusic.MovieCancel", Value, Alpha);
	ChangeColor("CopyMusic.MovieBrowse1", Value, Alpha);
	ChangeColor("CopyMusic.MovieBrowse2", Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck1",Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck2", Value, Alpha);
	ChangeColor("CopyMusic.MovieCheck3", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck3.chk", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck2.chk", Value, Alpha);
	ChangeColor("CopyMusic.ButtonCheck1.chk", Value, Alpha);
	

}
//*****
    
