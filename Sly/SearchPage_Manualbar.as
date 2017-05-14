var StWave1="~";
var LanName="";
var SelectMode0="";
var SelGender=0;

BackNormal.BackListTrack._visible=false;
BackNormal.DispalyArtistMode._visible=false;
BackNormal.BackListCountries._visible=false;
//..........................NORMAL SEARCH...............f.........................
BackNormal.ButtonSearch.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieSearch");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonRating.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieRating");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonSorted.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieSorted");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonTrack.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieTrack");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonCountries.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieCountries");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonGender.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieGender");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonArtist.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieArtist");
	BackNormal.DispalyArtistMode._visible=true;
};
BackNormal.ButtonAlbum.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieAlbum");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.ButtonSong.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.MovieSong");
	BackNormal.DispalyArtistMode._visible=false;
};
BackNormal.DispalyArtistMode.ButtonAlbums.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.DispalyArtistMode.MovieAlbums");
}
BackNormal.DispalyArtistMode.ButtonTracks.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackNormal.DispalyArtistMode.MovieTracks");
}
BackNormal.BackListCountries.ButtonLeft.onRollOver=function(){
	SelectButton("BackNormal.BackListCountries.MovieLeft");
}
BackNormal.BackListCountries.ButtonRight.onRollOver=function(){
	SelectButton("BackNormal.BackListCountries.MovieRight");
}

BackNormal.BackListCountries.ButtonLeft.onRelease=function(){
	ClickLeft("Countries");
	DisplayItem ("BackNormal.BackListCountries",IndexShowCountries,CountCountries,nList,ResultCountries,"Countries");
}
BackNormal.BackListCountries.ButtonRight.onRelease=function(){
	ClickRight("Countries");
	DisplayItem ("BackNormal.BackListCountries",IndexShowCountries,CountCountries,nList,ResultCountries,"Countries");
}
//..............................NORMAL ONRELEASE............................

function ClickOptNormal(Obj){
	invisibleDropDown();
	BackNormal.ButtonArtist.Selected._visible=false;
	BackNormal.ButtonAlbum.Selected._visible=false;
	BackNormal.ButtonSong.Selected._visible=false;
	eval(Obj+".Selected")._visible=true;
}
ClickOptNormal("BackNormal.ButtonSong");
BackNormal.ButtonArtist.onRelease = function() {
	
	if (send_event("normal&&&Click||"+this+"||2", false)) {// 170205
		return;
	}
	var b=false;
	b=!BackNormal.displayType._visible;
	ClickOptNormal("BackNormal.ButtonArtist");
 	if (databaseType == 4 || databaseType == 8 || databaseType == 16)
	{	BackNormal.displayType._visible = b; }
	BackNormal.displayType.Text0.textColor=FontColor
	BackNormal.displayType.Text1.textColor=FontColor
	eval("BackNormal.displayType.Text"+DisplayArtistMode).textColor=SelectColorValue
	SelectMode0="Artist";
	SelectMode="Artist";
	fscommand("ModeSearch","Artist");
}
BackNormal.ButtonAlbum.onRelease = function() {

	if (send_event("normal&&&Click||"+this+"||2", false)) {// 170205
		return;
	}

	ClickOptNormal("BackNormal.ButtonAlbum");
	SelectMode="Album";
	SelectMode0="Album";
	fscommand("ModeSearch","Album");
}

BackNormal.ButtonSong.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {// 170205
		return;
	}

	ClickOptNormal("BackNormal.ButtonSong");
	SelectMode="Song";
	SelectMode0="Song";
	fscommand("ModeSearch","Song");
	/*if(Grouping!="True"){
		if(ChangeLan=="Uni")BackNormal.TextSorted.text=UniAlphabet;
		else BackNormal.TextSorted.text=EngAlphabet;
		Grouping="True";
		ChangeTextButtonSorted(EngFont, UniFont, EngSize, UniSize, ChangeLan);
		fscommand("SendVaueGrouping",Grouping);
	}*/
}
BackNormal.ButtonSearch.onRelease = function() {
	//received with  "getTextSearch"
	fscommand("getTextSearch");
};
function start_searchs(StrText,val_SelectMode0,val_ChangeLan,val_NameCon){
	if (send_event("normal&&&function||start_searchs|~|" + StrText + "|~|" + val_SelectMode0 + "|~|" + val_ChangeLan + "|~|" + val_NameCon + "||2", false)) {// 170205
		return;
	}
	var txtOldFormat = new TextFormat();
	txtOldFormat=InputText.getTextFormat();
	InputText.text=StrText
	InputText.setTextFormat(txtOldFormat);
	SelectMode0 = val_SelectMode0;
	ChangeLan = val_ChangeLan;
	LanName	= val_NameCon;
	BackNormal.BackListTrack._visible=false;
	
	
	
	var strAvai="";
	var StrSearch="";
	if (StrText.length>0){
		if (RecordIndexAva==1){
			strAvai="&1";
		}else if (RecordIndexAva==2){
			strAvai="&0";
		}else if(RecordIndexAva==0){
			strAvai="&3";
		}			
		if(SelectMode0=="Song"){
			StrSearch = StrText;
			StrSearch += "&"+ResultArtist[RecordIndexArtist].Id;
			StrSearch += "&"+ResultMood[RecordIndexMood].Id;
			StrSearch += "&"+ResultDance[RecordIndexDance].Id;
			StrSearch += "&"+ResultGenre[RecordIndexGenre].Id;
			StrSearch += "&"+RecordIndexRating;
			StrSearch +=         strAvai;
			StrSearch += "&"+ ChangeLan;
			StrSearch +=  "&" + SelGender;
			StrSearch +=  "&0";
			if(databaseType==4 or databaseType==8 or databaseType==16){
				fscommand("StartSearchTrack", StrSearch);
			}else{
				fscommand("StartSearch", StrSearch);
			}
		}
		else if(SelectMode0=="Album"){
			StrSearch = StrText;
			SelectMode="Album";
			fscommand("StartSearchAlbum", StrSearch+strAvai);
		}
		else if(SelectMode0=="Artist"){
			if(ChangeLan=="Uni"){
				StrSearch = StrText;
			}else{
				StrSearch = CutThe(StrText);
			}
			fscommand("StartSearchArtist", StrSearch+strAvai);
		}
	}
}


function CutThe(Str){
	var st=substring(Str,0,"The ".length).toLowerCase();
	if(st=="the "){
		st=substring(Str,5,Str.length);
		return st;
	}
	else{
		return Str;
	}
}
BackNormal.ButtonRating.onRelease = function() {
	var b = false;
	b=!(BackNormal.BackListRating._visible);
	invisibleDropDown();
	ButtonRating_click(b);
};	

BackNormal.ButtonSorted.onRelease = function() {
	invisibleDropDown();
	ButtonSorted_click(Grouping);
};

function ButtonSorted_click(val) // 170205
{	
	if (send_event("normal&&&function||ButtonSorted_click|~|"+val+"||2", false)) {
		return;
	}
	if(val=="False"){
			if(ChangeLan=="Uni")BackNormal.TextSorted.text=UniAlphabet;
			else BackNormal.TextSorted.text=EngAlphabet;
			Grouping="True";
		}
		else{
			if(ChangeLan=="Uni"){
				BackNormal.TextSorted.text=UniReleaseDate;
			}
			else BackNormal.TextSorted.text=EngReleaseDate;
			Grouping="False";
		}
		ChangeTextButtonSorted(EngFont, UniFont, EngSize, UniSize, ChangeLan);
		fscommand("SendVaueGrouping",Grouping);
	//}

}
////
BackNormal.ButtonTrack.onRelease = function() {
	var b = false;
	b=!(BackNormal.BackListTrack._visible);
	invisibleDropDown();
	ButtonTrack_click(b);
};
BackNormal.ButtonCountries.onRelease = function() {
	var b=BackNormal.BackListCountries._visible;
	invisibleDropDown();
	BackNormal.BackListCountries._visible=!b;
	fscommand("RequestCountry");
};
BackNormal.ButtonGender.onRelease = function() {
	var b = false;
	b=!(BackNormal.BackListGender._visible);
	invisibleDropDown();
	ButtonGender_click(b);
};
function ButtonTrack_click(val)
{	if (send_event("normal&&&function||ButtonTrack_click|~|"+val+"||2", false)) {
		return;
	}
	if(String(val)=="true"){
		BackNormal.BackListTrack._visible=true;
	}
	else{
		BackNormal.BackListTrack._visible=false;
	}	
}
function ButtonRating_click(val)
{	if (send_event("normal&&&function||ButtonRating_click|~|"+val+"||2", false)) {
		return;
	}
	if(String(val)=="true"){
		BackNormal.BackListRating._visible=true;
	}
	else{
		BackNormal.BackListRating._visible=false;
	}	
}
function ButtonGender_click(val)
{	if (send_event("normal&&&function||ButtonGender_click|~|"+val+"||2", false)) {
		return;
	}
	if(String(val)=="true"){
		BackNormal.BackListGender._visible=true;
	}
	else{
		BackNormal.BackListGender._visible=false;
	}	
}
////
InputText.onSetFocus=function()
{
	ListAdvance("");	
	invisibleDropDown();
}
//................................ADVANCE SEARCH...............................
BackAdvance.ButtonSearch.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieSearch");
};
BackAdvance.ButtonNormal.onRollOver = function() {	
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieNormal");
};
BackAdvance.ButtonA.onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Show/Hide Keyboard",SHTT,0,20);
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieA");
};
BackNormal.ButtonA.onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Show/Hide Keyboard",SHTT,-(143.05/2)+5,20);
	SelectLevel = 2;
	SelectButton("BackNormal.MovieA");
};
BackAdvance.ButtonA.onRollOut = function() {HideTooltip("txtTooltip");}
BackNormal.ButtonA.onRollOut = function() {HideTooltip("txtTooltip");}

BackAdvance.ButtonReset.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieReset");
};
BackAdvance.ButtonArtist.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieArtist");	
};

BackAdvance.ButtonMood.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieMood");
};
BackAdvance.ButtonRating.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieRating");
};
BackAdvance.ButtonDance.onRollOver = function() {
	
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieDance");
};
BackAdvance.ButtonTrack.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieTrack");
};
BackAdvance.ButtonGenre.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("BackAdvance.MovieGenre");
};
//.....................................ADVANCE SEARCH ONRELEASE........................
BackAdvance.ButtonSearch.onRelease = function() {
	ListAdvance("");
	var StrText = InputText.text;
//	var StrSearch="";
	invisibleDropDown();	
/*	StrSearch = StrText;
	StrSearch = "&"+ResultArtist[RecordIndexArtist].Id;
	StrSearch += "&"+ResultMood[RecordIndexMood].Id;
	StrSearch += "&"+ResultDance[RecordIndexDance].Id;
	StrSearch += "&"+ResultGenre[RecordIndexGenre].Id;
	StrSearch += "&"+RecordIndexRating;
	StrSearch += "&"+ChangeLan;
	*/
	fscommand("getTextSearch");
	
/*	if (RecordIndexAva==1){
		StrSearch+="&&1";
	}else if (RecordIndexAva==2){
		StrSearch+="&&0";
	}else{
		StrSearch+="&&3";
	}
*/

//	if(StrSearch.length>0){
/*		
		if(substring(StrSearch,0,1)=="&"){
			var StrSearch1=substring(StrSearch,2,StrSearch.length);
			fscommand("StartSearch", StrSearch1);
		}
		else{
			fscommand("StartSearch", StrSearch);
		}
*/		
//		fscommand("StartSearch", StrSearch);
//	}
	/*
	else{
		if(ChangeLan=="Uni"){
			fscommand("StartSearch");
		}
	}
	*/
	
};
BackAdvance.ButtonNormal.onRelease = function() {
	invisibleDropDown();
	if (send_event("normal&&&Click||"+this+"||2", false)) {
	     return;
	}
	ListAdvance("");
	BackAdvance._visible=false;
	BackNormal._visible=true;
	Adv="No";
	BackNormal.ButtonAdvance.onRollOver();
	fscommand("AdvSearch",Adv);
};
BackAdvance.ButtonA.onRelease = function() {
	invisibleDropDown();
	ListAdvance("");
	if(KeyBoard._visible){
		KeyBoard._visible=false;
	}
	else{
		KeyBoard._visible=true;
	}
	//InputText.text="";
	//fscommand("Setfocus");
	textFocus();
};
BackNormal.ButtonA.onRelease = function() {
	invisibleDropDown();
	ListAdvance("");
	if(KeyBoard._visible){
		KeyBoard._visible=false;
	}
	else{
		KeyBoard._visible=true;
	}
	//InputText.text="";
	//fscommand("SetFocus");
	textFocus();
};

BackAdvance.ButtonReset.onRelease = function() {
	invisibleDropDown();
	ListAdvance("");
	ResetValueListItem();
	StarRating(-1);
	ChangeTextButton(EngFont, UniFont, EngSize, UniSize, ChangeLan);
};
BackAdvance.ButtonArtist.onRelease = function() {
	//invisibleDropDown();
	if(BackAdvance.BackListArtist._visible){
		BackAdvance.BackListArtist._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListArtist")
		if(ResultArtist.length==0){
			fscommand("GetArtistName");
		}
	}
};
BackAdvance.ButtonMood.onRelease = function() {
	invisibleDropDown();
	if(BackAdvance.BackListMood._visible){
		BackAdvance.BackListMood._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListMood")
		if(ResultMood.length==0){
			fscommand("GetMood");
		}
	}
};
BackAdvance.ButtonRating.onRelease = function() {
	//invisibleDropDown();
	if(BackAdvance.BackListRating._visible){
		BackAdvance.BackListRating._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListRating")
		SelectedItemMovie("BackAdvance.BackListRating",kRating);
	}
};
BackAdvance.ButtonDance.onRelease = function() {
	invisibleDropDown();	
	if(BackAdvance.BackListDance._visible){
		BackAdvance.BackListDance._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListDance")
		if(ResultDance.length==0){
			fscommand("GetDance");
		}
	}
};
BackAdvance.ButtonTrack.onRelease = function() {
	//invisibleDropDown();
	if(BackAdvance.BackListTrack._visible){
		BackAdvance.BackListTrack._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListTrack")
	}
};
BackAdvance.ButtonGenre.onRelease = function() {
	if(BackAdvance.BackListGenre._visible){
		BackAdvance.BackListGenre._visible=false;
	}
	else{
		ListAdvance("BackAdvance.BackListGenre")
		if(ResultGenre.length==0){
			fscommand("GetGenre");
		}
	}
};
//..........................................FUNCTION ASSING VALUE .........................
function DisplayItem(Obj,Index,Count,n,Value,Na){
	
	for (var i = 0 ; i < n ; i++)
	{
		eval(Obj+".Button"+i)._visible=false;
		eval(Obj+".Text"+i)._visible=false;
		eval(Obj+".Movie"+i)._visible=false;
	}
	for(var j=0;j<Value.length;j++){
		var txt;
		var tmpLan="Eng";
		if(j<Count){

			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;

			if(ChangeLan=="Eng"){
				txt=(Index+j+1)+"-"+Value[Index+j].Name;
				tmpLan="Eng";
			}
			else{
				txt=(Index+j+1)+"-"+Value[Index+j].Unicode;
				tmpLan="Khmer";

				if (Value[Index+j].Unicode=="")
				{
					txt=(Index+j+1)+"-"+Value[Index+j].Name;
					tmpLan="Eng";	
				}
				
			}
			eval(Obj+".Text"+j).text=txt;
		}
		changeGenreListFont(EngFont, UniFont, EngSize, UniSize,tmpLan,eval(Obj+".Text"+j))
	}

	DeselectedItem (Obj,eval("IndexShow"+Na),eval("RecordIndex"+Na),Na);
}
function InvisibleArrow(Obj,n){
	if(n<=nList){
		eval(Obj+".ButtonLeft").enabled=false;
		eval(Obj+".ButtonRight").enabled=false;
		eval(Obj+".BackScrollBar").enabled=false;
		
	}
	else{
		eval(Obj+".ButtonLeft").enabled=true;
		eval(Obj+".ButtonRight").enabled=true;
		eval(Obj+".BackScrollBar").enabled=true;
	}
}
var HighClick=170//BackScrollBar.hight
function ClickListBar(TotalLevel,YMouse,Num){
	var Count=0;
	var CalLevel = int((YMouse*TotalLevel)/HighClick);
	Count=nList;
	if (CalLevel>=TotalLevel) {
		CalLevel = TotalLevel;
		Count=(CalLevel*nList)-Num;
		if(Count==0)Count=nList;
		else Count=nList-Count;
	} else if (CalLevel<=0) {
		CalLevel = 1;
	}
	var Index=(CalLevel-1)*nList
	return Index+StWave1+Count+StWave1+CalLevel;
}
//......................ARTIST LISTITEM....................................................
function FirstDisplayArtist(n){
	InvisibleArrow("BackAdvance.BackListArtist",n);
	FirstDisplay("Artist",n,nList);	
	DisplayItem ("BackAdvance.BackListArtist",IndexShowArtist,CountArtist,nList,ResultArtist,"Artist");
}
BackAdvance.BackListArtist.ButtonLeft.onRollOver=function(){
	SelectButton("BackAdvance.BackListArtist.MovieLeft");
}
BackAdvance.BackListArtist.ButtonRight.onRollOver=function(){
	SelectButton("BackAdvance.BackListArtist.MovieRight");
}
BackAdvance.BackListMood.ButtonLeft.onRollOver=function(){
	SelectButton("BackAdvance.BackListMood.MovieLeft");
}
BackAdvance.BackListMood.ButtonRight.onRollOver=function(){
	SelectButton("BackAdvance.BackListMood.MovieRight");
}
BackAdvance.BackListGenre.ButtonLeft.onRollOver=function(){
	SelectButton("BackAdvance.BackListGenre.MovieLeft");
}
BackAdvance.BackListGenre.ButtonRight.onRollOver=function(){
	SelectButton("BackAdvance.BackListGenre.MovieRight");
}
BackAdvance.BackListDance.ButtonLeft.onRollOver=function(){
	SelectButton("BackAdvance.BackListDance.MovieLeft");
}
BackAdvance.BackListDance.ButtonRight.onRollOver=function(){
	SelectButton("BackAdvance.BackListDance.MovieRight");
}
BackAdvance.BackListArtist.ButtonLeft.onRelease=function(){
	ClickLeft("Artist");
	DisplayItem ("BackAdvance.BackListArtist",IndexShowArtist,CountArtist,nList,ResultArtist,"Artist");
}
BackAdvance.BackListArtist.ButtonRight.onRelease=function(){
	ClickRight("Artist");
	DisplayItem ("BackAdvance.BackListArtist",IndexShowArtist,CountArtist,nList,ResultArtist,"Artist");
}
BackAdvance.BackListArtist.BackScrollBar.onRelease = function() {
	var SplValue=ClickListBar(TotalLevelIndexArtist,this._ymouse,NumArtist).split("~");
	IndexShowArtist=parseInt(SplValue[0],10);
	CountArtist=parseInt(SplValue[1],10);
	LevelIndexArtist=parseInt(SplValue[2],10);
	DisplayItem ("BackAdvance.BackListArtist",IndexShowArtist,CountArtist,nList,ResultArtist,"Artist");
};
//......................Mood LISTITEM....................................................
function FirstDisplayMood(n){
	InvisibleArrow("BackAdvance.BackListMood",n);
	FirstDisplay("Mood",n,nList);	
	DisplayItem("BackAdvance.BackListMood",IndexShowMood,CountMood,nList,ResultMood,"Mood");
}
BackAdvance.BackListMood.ButtonLeft.onRelease=function(){
	ClickLeft("Mood");
	DisplayItem ("BackAdvance.BackListMood",IndexShowMood,CountMood,nList,ResultMood,"Mood");
}
BackAdvance.BackListMood.ButtonRight.onRelease=function(){
	ClickRight("Mood");
	DisplayItem ("BackAdvance.BackListMood",IndexShowMood,CountMood,nList,ResultMood,"Mood");
}
BackAdvance.BackListMood.BackScrollBar.onRelease = function() {
	var SplValue=ClickListBar(TotalLevelIndexMood,this._ymouse,NumMood).split("~");
	IndexShowMood=parseInt(SplValue[0],10);
	CountMood=parseInt(SplValue[1],10);
	LevelIndexMood=parseInt(SplValue[2],10);
	DisplayItem ("BackAdvance.BackListMood",IndexShowMood,CountMood,nList,ResultMood,"Mood");
};
//......................Dance LISTITEM....................................................
function FirstDisplayDance(n){
	InvisibleArrow("BackAdvance.BackListDance",n);
	FirstDisplay("Dance",n,nList);	
	DisplayItem ("BackAdvance.BackListDance",IndexShowDance,CountDance,nList,ResultDance,"Dance");
}
BackAdvance.BackListDance.ButtonLeft.onRelease=function(){
	ClickLeft("Dance");
	DisplayItem ("BackAdvance.BackListDance",IndexShowDance,CountDance,nList,ResultDance,"Dance");
}
BackAdvance.BackListDance.ButtonRight.onRelease=function(){
	ClickRight("Dance");
	DisplayItem ("BackAdvance.BackListDance",IndexShowDance,CountDance,nList,ResultDance,"Dance");
}
BackAdvance.BackListDance.BackScrollBar.onRelease = function() {
	var SplValue=ClickListBar(TotalLevelIndexDance,this._ymouse,NumDance).split("~");
	IndexShowDance=parseInt(SplValue[0],10);
	CountDance=parseInt(SplValue[1],10);
	LevelIndexDance=parseInt(SplValue[2],10);
	DisplayItem ("BackAdvance.BackListDance",IndexShowDance,CountDance,nList,ResultDance,"Dance");
};
//......................Genre LISTITEM....................................................
function FirstDisplayGenre(n){
	InvisibleArrow("BackAdvance.BackListGenre",n);
	FirstDisplay("Genre",n,nList);	
	DisplayItem ("BackAdvance.BackListGenre",IndexShowGenre,CountGenre,nList,ResultGenre,"Genre");
}
function FirstDisplayCountries(n){
	InvisibleArrow("BackNormal.BackListCountries",n);
	FirstDisplay("Countries",n,nList);	
	DisplayItem ("BackNormal.BackListCountries",IndexShowCountries,CountCountries,nList,ResultCountries,"Countries");
}
BackAdvance.BackListGenre.ButtonLeft.onRelease=function(){
	ClickLeft("Genre");
	DisplayItem ("BackAdvance.BackListGenre",IndexShowGenre,CountGenre,nList,ResultGenre,"Genre");
}
BackAdvance.BackListGenre.ButtonRight.onRelease=function(){
	ClickRight("Genre");
	DisplayItem ("BackAdvance.BackListGenre",IndexShowGenre,CountGenre,nList,ResultGenre,"Genre");
}
BackAdvance.BackListGenre.BackScrollBar.onRelease = function() {
	var SplValue=ClickListBar(TotalLevelIndexGenre,this._ymouse,NumGenre).split("~");
	IndexShowGenre=parseInt(SplValue[0],10);
	CountGenre=parseInt(SplValue[1],10);
	LevelIndexGenre=parseInt(SplValue[2],10);
	DisplayItem("BackAdvance.BackListGenre",IndexShowGenre,CountGenre,nList,ResultGenre,"Genre");
	
};

/////........................FUNCTION RETRIEVE VALUE...........................
function RetrieveValue(StText,BaseValue,Lan){
	if(Lan=="Eng"){
		for(var j=0;j<BaseValue.length;j++){
			if(StText.toLowerCase()==substring(BaseValue[j].Name,0,StText.length).toLowerCase()){
				return BaseValue[j].Name+"~"+j;
			}
		}
		return "Non"
	}
	else{
		for(var j=0;j<BaseValue.length;j++){
			if(StText==substring(BaseValue[j].Unicode,0,StText.length)){
				return BaseValue[j].Unicode;
			}
		}
		return "Non"
	}
	
}
function PassIndexAndCount(PassIndex,TotalLevel,Num){
	if (PassIndex%nList == 0) {
		CalLevel=int(PassIndex/nList);
	} else {
		CalLevel=int(PassIndex/nList)+1;
	}
	Count=nList;
	if (CalLevel>=TotalLevel) {
		CalLevel = TotalLevel;
		Count=(CalLevel*nList)-Num;
		if(Count==0)Count=nList;
		else Count=nList-Count;
	} else if (CalLevel<=0) {
		CalLevel = 1;
	}
	var Index=(CalLevel-1)*nList
	return Index+StWave1+Count+StWave1+CalLevel;
}


//..............................MAKE EVENT ON  BUTTON LISTITEM............................................

var RecordIndexArtist=RecordIndexGenre=RecordIndexDance=RecordIndexMood=RecordIndexRating=RecordIndexTrack=RecordIndexAva=0;
function ResetValueListItem(){
	InputText.text="";
	kRating=0;
	RecordIndexArtist=RecordIndexGenre=RecordIndexDance=RecordIndexMood=RecordIndexRating=RecordIndexTrack=0;
	DeselectedItem ("BackAdvance.BackListArtist",IndexShowArtist,RecordIndexArtist,"Artist");
	DeselectedItem ("BackAdvance.BackListMood",IndexShowMood,RecordIndexMood,"Mood");
	DeselectedItem ("BackAdvance.BackListDance",IndexShowDance,RecordIndexDance,"Dance");
	DeselectedItem ("BackAdvance.BackListGenre",IndexShowGenre,RecordIndexGenre,"Genre");
	DeselectedItem ("BackAdvance.BackListTrack",0,RecordIndexTrack,"Track");
	DeselectedItem ("BackNormal.BackListTrack",0,RecordIndexTrack,"Track");
	//DeselectedItem ("BackNormal.BackListGender",0,RecordIndexTrack,"Gender");
	SelectedItemMovie("BackAdvance.BackListRating",kRating);
	if((iKhmer=="1" ) and (ChangeLan == "Uni")){
		var ddd = new TextFormat();
		ddd.font = UniFont;
		ddd.size = UniSize;
		InputText.text = "";
		InputText.setTextFormat(ddd);
		InputText.setNewTextFormat(ddd);
	}
}
var kRating=0;
for(var j=0;j<nList;j++){
	//.............................Artist.........................................................
	eval("BackAdvance.BackListArtist.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackAdvance.BackListArtist.Movie"+k);
	}
	eval("BackAdvance.BackListArtist.Button"+j).onRelease=function(){

		SelectedItem("BackAdvance.BackListArtist",GetNumber(this._name));
		var k=IndexShowArtist+GetNumber(this._name);
		RecordIndexArtist=k;
		BackAdvance.ButtonArtist.onRollOver();
		BackAdvance.BackListArtist._visible=false;
		if(ChangeLan=="Uni"){
			BackAdvance.TextArtist.text=ResultArtist[RecordIndexArtist].Unicode;
		}
		else{
			BackAdvance.TextArtist.text=ResultArtist[RecordIndexArtist].Name;
		}
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextArtist");
	}
	//.............................Mood........................................................
	eval("BackAdvance.BackListMood.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackAdvance.BackListMood.Movie"+k);
	}
	eval("BackAdvance.BackListMood.Button"+j).onRelease=function(){
		SelectedItem("BackAdvance.BackListMood",GetNumber(this._name));
		var k=IndexShowMood+GetNumber(this._name);
		RecordIndexMood=k;
		BackAdvance.ButtonMood.onRollOver();
		BackAdvance.BackListMood._visible=false;
		if(ChangeLan=="Uni"){
			BackAdvance.TextMood.text=ResultMood[RecordIndexMood].Unicode;
		}
		else{
			BackAdvance.TextMood.text=ResultMood[RecordIndexMood].Name;
		}
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextMood");
	}
	//.............................Artist.........................................................
	eval("BackNormal.BackListCountries.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackNormal.BackListCountries.Movie"+k);
	}
	eval("BackNormal.BackListCountries.Button"+j).onRelease=function(){
		SelectedItem("BackNormal.BackListCountries",GetNumber(this._name));
		var k=IndexShowCountries+GetNumber(this._name);
		RecordIndexCountries=k;
		BackNormal.BackListCountries._visible=false;
		SelectButton("BackNormal.MovieCountries");
		fscommand("SetSearchCountry",ResultCountries[RecordIndexCountries].ID);
//		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextDance");
	}

	eval("BackAdvance.BackListGenre.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackAdvance.BackListGenre.Movie"+k);
	}
	eval("BackAdvance.BackListGenre.Button"+j).onRelease=function(){
		SelectedItem("BackAdvance.BackListGenre",GetNumber(this._name));
		var k=IndexShowGenre+GetNumber(this._name);
		var tmpLan="Eng";

		RecordIndexGenre=k;
		BackAdvance.ButtonGenre.onRollOver();
		BackAdvance.BackListGenre._visible=false;

		if(ChangeLan=="Uni"){
			BackAdvance.TextGenre.text=ResultGenre[RecordIndexGenre].Unicode;
			tmpLan="Khmer";
			if (ResultGenre[RecordIndexGenre].Unicode=="" ) 
			{
				BackAdvance.TextGenre.text=ResultGenre[RecordIndexGenre].Name;	
				tmpLan="Eng";
			}
		}
		else{
			BackAdvance.TextGenre.text=ResultGenre[RecordIndexGenre].Name;
		}

		ChangeButton1(EngFont, UniFont, EngSize, UniSize, tmpLan,"BackAdvance.TextGenre");
	}
	//.............................Dance.........................................................
	eval("BackAdvance.BackListDance.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackAdvance.BackListDance.Movie"+k);
	}
	eval("BackAdvance.BackListDance.Button"+j).onRelease=function(){
		SelectedItem("BackAdvance.BackListDance",GetNumber(this._name));
		var k=IndexShowDance+GetNumber(this._name);
		RecordIndexDance=k;
		BackAdvance.ButtonDance.onRollOver();
		BackAdvance.BackListDance._visible=false;
		if(ChangeLan=="Uni"){
			BackAdvance.TextDance.text=ResultDance[RecordIndexDance].Unicode;
		}
		else{
			BackAdvance.TextDance.text=ResultDance[RecordIndexDance].Name;
		}
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextDance");
	}
	//.............................Rating.........................................................
	eval("BackNormal.BackListRating.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackNormal.BackListRating.Movie"+k);
	}
	eval("BackNormal.BackListRating.Button"+j).onRelease=function(){
		kRating=GetNumber(this._name);
		RecordIndexRating=kRating;
		if(RecordIndexRating==0){
			BackNormal.TextRating._visible=true;
			BackNormal.TextRating.text=BackNormal.BackListRating.Text1.text;
			ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackNormal.TextRating");
			StarRating(-1);
		}
		else{
			BackNormal.TextRating._visible=false;
			switch(RecordIndexRating){
				case 1:
					RecordIndexRating=5;
					break;
				case 2:
					RecordIndexRating=4;
					break;
				case 3:
					RecordIndexRating=3;
					break;
				case 4:
					RecordIndexRating=2;
					break;
				case 5:
					RecordIndexRating=1;
					break;
			}
			SelectedItemMovie("BackNormal.BackListRating",kRating);
			StarRating(RecordIndexRating);
		}
//		StoreNameSelected="";
		BackNormal.ButtonRating.onRollOver();
		BackNormal.BackListRating._visible=false;
		
		
	}
	//.............................Track.........................................................
	eval("BackAdvance.BackListTrack.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackAdvance.BackListTrack.Movie"+k);
	}
	eval("BackAdvance.BackListTrack.Button"+j).onRelease=function(){

		SelectedItem("BackAdvance.BackListTrack",GetNumber(this._name));
		SelectedItem("BackNormal.BackListTrack",GetNumber(this._name));
		var k=GetNumber(this._name);
		RecordIndexAva=k;
		BackAdvance.ButtonTrack.onRollOver();
		BackAdvance.BackListTrack._visible=false;
		BackNormal.TextTrack.text=eval("BackNormal.BackListTrack.Text"+k).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackNormal.TextTrack");
		BackAdvance.TextTrack.text=eval("BackAdvance.BackListTrack.Text"+k).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextTrack");
		fscommand("SaveSearchAvailable",k);
	}
	//.............................Track.........................................................
	eval("BackNormal.BackListTrack.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackNormal.BackListTrack.Movie"+k);
	}
	eval("BackNormal.BackListTrack.Button"+j).onRelease=function(){

		if (send_event("normal&&&Click||"+this+"||2", false)) { // 170205
			return;
		}

		SelectedItem("BackAdvance.BackListTrack",GetNumber(this._name));
		SelectedItem("BackNormal.BackListTrack",GetNumber(this._name));
		var k=GetNumber(this._name);
		RecordIndexAva=k;
		BackNormal.ButtonTrack.onRollOver();
		BackNormal.BackListTrack._visible=false;
		BackNormal.TextTrack.text=eval("BackNormal.BackListTrack.Text"+k).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackNormal.TextTrack");
		BackAdvance.TextTrack.text=eval("BackAdvance.BackListTrack.Text"+k).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackAdvance.TextTrack");
		fscommand("SaveSearchAvailable",k);
	}
	//.............................Gender.........................................................
	eval("BackNormal.BackListGender.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackNormal.BackListGender.Movie"+k);
	}
	eval("BackNormal.BackListGender.Button"+j).onRelease=function(){

		if (send_event("normal&&&Click||"+this+"||2", false)) { // 170205
			return;
		}

		SelectedItem("BackNormal.BackListGender",GetNumber(this._name));
		var k=GetNumber(this._name);
		SelGender=k;
		BackNormal.ButtonGender.onRollOver();
		BackNormal.BackListGender._visible=false;
		BackNormal.TextGender.text=eval("BackNormal.BackListGender.Text"+k).text;
		ChangeButton1(EngFont, UniFont, EngSize, UniSize, ChangeLan,"BackNormal.TextGender");
		fscommand("Gender",k);
	}
}

//........................FUNCTION SELECTED..................
function SelectedItem(Obj,Index){
	for(var j=0;j<nList;j++){
		eval(Obj+".Text"+j).textColor=FontColor;
	}
	eval(Obj+".Text"+Index).textColor=SelectColorValue;
}
function DeselectedItem (Obj,IndexShow,Index,Na) {
	for(var j=0;j<nList;j++){
		if((IndexShow+j)==Index){
			eval(Obj+".Text"+j).textColor=SelectColorValue;
		}
		else{
			eval(Obj+".Text"+j).textColor=FontColor;
		}
	}
}
function SelectedItemMovie(Obj,Index){
	for(var j=0;j<nList;j++){
		ChangeColor(Obj+".Movie"+j, SetColorValue, AlphaList);
	}
	ChangeColor(Obj+".Movie"+Index, SelectColorValue, AlphaList);
}
//..................Star for Rating.............
function StarRating(Index){
	for(var j=0;j<5;j++){
		eval("BackNormal.Star"+j)._visible=false;
	}
	if(Index==1){
		BackNormal.Star2._visible=true;
	}
	else if(Index==2){
		BackNormal.Star1._visible=true;
		BackNormal.Star3._visible=true;
	}
	else if(Index==3){
		BackNormal.Star1._visible=true;
		BackNormal.Star2._visible=true;
		BackNormal.Star3._visible=true;
	}
	else if(Index==4){
		BackNormal.Star0._visible=true;
		BackNormal.Star1._visible=true;
		BackNormal.Star3._visible=true;
		BackNormal.Star4._visible=true;
	}
	else if(Index==5){
		BackNormal.Star0._visible=true;
		BackNormal.Star1._visible=true;
		BackNormal.Star2._visible=true;
		BackNormal.Star3._visible=true;
		BackNormal.Star4._visible=true;
	}
	else if(Index==-1){
		BackNormal.TextRating._visible=true;
	}
}

StarRating(-1);

function invisibleDropDown()
{
	BackNormal.BackListCountries._visible = false;
	BackNormal.displayType._visible = false;
	BackNormal.BackListTrack._visible = false;
	BackNormal.BackListGender._visible = false;
	BackNormal.Menucountry._visible=false;
	BackAdvance.BackListRating._visible = false;
	BackAdvance.BackListArtist._visible = false;
	BackNormal.BackListRating._visible = false;
	BackAdvance.BackListTrack._visible = false;
	BackAdvance.BackListGenre._visible = false;
	
}
	