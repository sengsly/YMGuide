SearchBox._visible=false;
var ResultList=new Array();
var ResultForSearch=new Array();
var nListSearch=5;

SearchBox.InputBox.onChanged=function(){
	ChangeInputText(ChangeLan);
}
SearchBox.Null.onSetFocus=function  () {
	Selection.setFocus(Null);
	SelectButton("SearchBox.MovieOk");
}
SearchBox.ButtonOk.onRollOver = function(){
	SelectButton("SearchBox.MovieOk");
}
SearchBox.ButtonCancel.onRollOut = function(){
	HideTooltip("txtTooltip");
}
SearchBox.ButtonL.onRollOut = function(){
	HideTooltip("txtTooltip");
}
SearchBox.ButtonK.onRollOut = function(){
	HideTooltip("txtTooltip");
}
SearchBox.ButtonCancel.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Close",SHTT,-(117/2)+5,20);
	SelectButton("SearchBox.MovieCancel");
}
SearchBox.ButtonL.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Unicode/English",SHTT,-(117/2)+5,20);
	SelectButton("SearchBox.MovieL");
}
SearchBox.ButtonK.onRollOver = function(){
	DisplayTooltip(this,"txtTooltip","Keyboard",SHTT,-(117/2)+5,20);
	SelectButton("SearchBox.MovieK");
}
SearchBox.ButtonK.onRelease = function(){
	TextObject="SearchBox.InputBox";
	KeyBoard._x=Stage.width/2;
	KeyBoard._y=Stage.height/2;
	if(KeyBoard._visible)KeyBoard._visible=false;
	else KeyBoard._visible=true;
}
SearchBox.ButtonL.onRelease = function(){
	KeyBoard._visible=false
	if(ChangeLanRe=="Uni")ChangeLanRe="Eng";
	else ChangeLanRe="Uni";
	TopBar.ButtonL.onRelease();
	VisibleInputBoxSearch();
	GetSearchTrackFromVB(IndexShowSearchList);
}
SearchBox.ButtonOk.onRelease = function(){
	//2006-08-07
	fscommand("getTextSearch");
}
SearchBox.ButtonCancel.onRelease = function(){
	KeyBoard._visible=false
	SearchBox._visible=false;
	ButtonHideMouse._visible=false;
	fscommand("ShowTextUnicode","No");
	//fscommand("ShowTextSearchPlayer","No")
}
SearchBox.ListResult.ButtonLeft.onRollOver=function(){
	SelectButton("SearchBox.ListResult.MovieLeft");
}
SearchBox.ListResult.ButtonRight.onRollOver=function(){
	SelectButton("SearchBox.ListResult.MovieRight");
}
SearchBox.ListResult.ButtonLeft.onRelease=function(){
	ClickLeft("SearchList");
//	DisplayItemSearch ("SearchBox.ListResult",IndexShowSearchList,CountSearchList,nListSearch);
	GetSearchTrackFromVB(IndexShowSearchList);
	//ResultForSearch
}
SearchBox.ListResult.ButtonRight.onRelease=function(){
	ClickRight("SearchList");
	GetSearchTrackFromVB(IndexShowSearchList);
//	DisplayItemSearch ("SearchBox.ListResult",IndexShowSearchList,CountSearchList,nListSearch);
}
var ScaleWSearchPlayer=46;
var PicXSearchPlayer=new Array();
var PicYSearchPlayer=new Array();
for(j=0;j<nListSearch;j++){
	PicXSearchPlayer[j]=eval("SearchBox.ListResult.Pic"+j)._x;
	PicYSearchPlayer[j]=eval("SearchBox.ListResult.Pic"+j)._y;
	eval("SearchBox.ListResult.Button"+j).onRollOver=function(){
		var Index =GetNumber(this._name);
		SelectButton("SearchBox.ListResult.Movie"+Index);
	}
	eval("SearchBox.ListResult.Button"+j).onRelease=function(){
		var Index =GetNumber(this._name);
		var k=IndexShowSearchList+Index;
		RecordIndexTrack=ResultList[k];
		fscommand("mini","SelectedPlaylist|:|"+RecordIndexTrack);
	}
	//...............Shopping Cart...................
	eval("SearchBox.ListResult.Cart"+j).onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval("SearchBox.ListResult.Cart"+j).onRollOver = function() {
		var Index=GetNumber(this._name);
		var k=IndexShowSearchList+Index;
		var k1=ResultList[k];
		eval("SearchBox.ListResult.Button"+Index).onRollOver();
		if(resultSearch[k1].ShoppingID.length>0 && NoInternetConnected=="0"){
			DisplayTooltip(this,"txtTooltip","Purchase Track Available",SHTT,-(117.3/2)+50,20);
		}
		else{
			DisplayTooltip(this,"txtTooltip","Purchase Track Not Available",SHTT,-(117.3/2)+50,20);
		}
	}
	eval("SearchBox.ListResult.Cart"+j).onRelease = function() {
		var Index=GetNumber(this._name);
		var k=IndexShowSearchList+Index;
		var k1=ResultList[k];
		if(resultSearch[k1].ShoppingID.length>0 && NoInternetConnected=="0" ){
			fscommand("PurchaseTrack",resultSearch[k1].ShoppingID)
		}
	}
	//...............SAMPLE SONG ....................
	eval("SearchBox.ListResult.Sam"+j).onRollOut = function() {
		HideTooltip("txtTooltip");
	};
	eval("SearchBox.ListResult.Sam"+j).onRelease = function() {
		var Index=GetNumber(this._name);
		eval("SearchBox.ListResult.Button"+Index).onRelease();
	}
	eval("SearchBox.ListResult.Sam"+j).onRollOver = function() {
		var Index=GetNumber(this._name);
		var k=IndexShowSearchList+Index;
		var k1=ResultList[k];
		eval("SearchBox.ListResult.Button"+Index).onRollOver();
		
		if(resultSearch[k1].Ava!=0){
			DisplayTooltip(this,"txtTooltip","Track Available",SHTT,-(117.3/2)+50,20);
		}
		else{
			if(resultSearch[k1].walMart_Ava==0){
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
	//.....................
	
}

AddTrackBox.ButtonK.onRollOver = function(){
	SelectButton("AddTrackBox.MovieK");
}
AddTrackBox.ButtonK.onRelease = function(){
	TextObject="AddTrackBox.InputBox";
	KeyBoard._x=Stage.width/2;
	KeyBoard._y=Stage.height/2;
	if(KeyBoard._visible)KeyBoard._visible=false;
	else KeyBoard._visible=true;
}
AddTrackBox.ButtonCancel.onRollOver = function(){
	SelectButton("AddTrackBox.MovieCancel");
}
AddTrackBox.ButtonCancel.onRelease=function(){
	KeyBoard._visible=false
	AddTrackBox.InputTrackBox.text=""	
	AddTrackBox._visible=false;
	
}
AddTrackBox.ButtonOK.onRollOver = function(){
	SelectButton("AddTrackBox.MovieOk");
}
AddTrackBox.ButtonOk.onRelease=function(){

	fscommand("CodeID",AddTrackBox.InputTrackBox.text);
	AddTrackBox.InputTrackBox.text="";
	Selection.setFocus(AddTrackBox.InputTrackBox);
//	AddTrackBox._visible=false;
}

//...................
function FirstDisplaySearch(n){
	FirstDisplay("SearchList",n,nListSearch);
	if(n<=nListSearch){
		SearchBox.ListResult.ButtonLeft._visible=false;
		SearchBox.ListResult.ButtonRight._visible=false;
		SearchBox.ListResult.MovieLeft._visible=false;
		SearchBox.ListResult.MovieRight._visible=false;
	}
	else{
		SearchBox.ListResult.ButtonLeft._visible=true;
		SearchBox.ListResult.ButtonRight._visible=true;
		SearchBox.ListResult.MovieLeft._visible=true;
		SearchBox.ListResult.MovieRight._visible=true;
	}
//	fscommand("reply",IndexShowSearchList);
	GetSearchTrackFromVB(IndexShowSearchList);
//	DisplayItemSearch ("SearchBox.ListResult",IndexShowSearchList,CountSearchList,nListSearch);
}
var ChangeLanRe="Eng";
function DisplayItemSearch (Obj,Index,Count,nItem){
	//***
	Name= Obj+".Pic";
	Name1 = Obj+".PicFade";
	NameFade = Obj+".Movie";
	PicName.length = 0;
	var Index1=0;
//	fscommand("reply","Item searched"+j);
	for (var j=0;j<nItem;j++ ){
		objSam= eval(Obj+".Sam"+j);
		if(j<Count){
//			fscommand("reply",listSearch);
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;
			Index1=ResultList[Index+j];
			if(listSearch[j].ReservePath.length<=0 ){
					listSearch[j].ReservePath=listSearch[j].PathPic;
					fscommand("SearchPathImage",listSearch[j].ReservePath+"%~%"+"Track"+"%~%"+(Index+j)+"%~%"+listSearch[j].LanPath+"%~%"+listSearch[j].Lan);
			}
			PicName[j]=listSearch[j].ReservePath;
			//.........walmart...........
			if(listSearch[j].Ava==0){
					//...........Purchase.....................
					if(listSearch[j].ShoppingID.length>0 && NoInternetConnected=="0"){
						eval(Obj+".Cart"+j)._visible=true;
					}
					else{
						eval(Obj+".Cart"+j)._visible=false;
					}
					//........Samplie
					if(listSearch[j].walMart_Ava=="0"){
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
				eval(Obj+".Cart"+j)._visible=false;
				objSam.setMusicNote(listSearch[j].Ava);
			}
			//...........................
			
			
			if (ChangeLanRe == "Uni") {
				if(listSearch[j].unicodeTrackTitle.length<=0){
					eval(Obj+".Text"+j).text=(Index1+1)+"-"+listSearch[j].trackTitle;
					ChangeFontSearchbox("Eng",listSearch[j].lan,j);
				}
				else{
					eval(Obj+".Text"+j).text=(Index1+1)+"-"+listSearch[j].unicodeTrackTitle;
					ChangeFontSearchbox("Uni",listSearch[j].lan,j);
				}
			} else {
				if(listSearch[j].trackTitle.length<=0){
					eval(Obj+".Text"+j).text=(Index1+1)+"-"+listSearch[j].unicodeTrackTitle;
					ChangeFontSearchbox("Uni",listSearch[j].lan,j);
				}
				else{
					//fscommand("reply",listSearch[j].trackTitle);
					eval(Obj+".Text"+j).text=(Index1+1)+"-"+listSearch[j].trackTitle;
					ChangeFontSearchbox("Eng",listSearch[j].lan,j);
				}
			}
			
		}
		else{
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
			eval(Obj+".Cart"+j)._visible=false;
			objSam._visible=false;
			eval(Obj+".Pic"+j)._visible=false;
			eval(Obj+".PicFade"+j)._visible=false;
		}
	}
	Reset(Count);
}
//..........................Search code.......
var StoreSearchTitle="";
var StoreSearchTitleUni="";
var ValueSerchByTrack=false;
function SearchByTrack(Str,Uni){
	ValueSerchByTrack=true;
	StoreSearchTitle=Str;
	StoreSearchTitleUni=Uni;
//	if(FirstLoadAlbum){
//	fscommand("reply","fdsfasdfds");
		fscommand("GetSearchTracks",Uni);
//		FirstLoadAlbum=false;
//		return;
//	}
	StoreSearchByTrack(Str,Uni);
}
FirstDisplaySearch(0);
function StoreSearchByTrack(Str,Uni){
	var i=0;
	var StrTitle="";
	var boolUnicode=(ChangeLanRe=="Uni");
	ResultList.length=0;
	if (!boolUnicode){
		Str=Str.toLowerCase()
	}
//	ResultForSearch.length=
//	fscommand("reply","ChangeLanRe = "+ boolUnicode);
	for(var j=0;j<ResultForSearch.length;j++){
		StrTitle=ResultForSearch[j];
		if (!boolUnicode){
			StrTitle=StrTitle.toLowerCase();
		}
		if (StrTitle.indexOf(Str,0)>=0){
			ResultList[i]=j;
			i+=1;
		}
	}
	FirstDisplaySearch(ResultList.length);
}
function VisibleSearchBox(){
	ChangeLanRe=ChangeLan;
	SearchBox.ButtonOk.onRollOver();
	SearchBox._visible=true;
	ButtonHideMouse._visible=true;
	VisibleInputBoxSearch();
}
function VisibleInputBoxSearch(){
	if(ChangeLanRe=="Uni"){
		if(iKhmer=="1" || LanName=="English"){
			SearchBox.InputBox._visible=true;
			SearchBox.InputBox.text="";
			Selection.setFocus("SearchBox.InputBox");
			//fscommand("ShowTextSearchPlayer","No")
		}
		else{
			SearchBox.InputBox._visible=true;
			SearchBox.InputBox.text="";
			Selection.setFocus("SearchBox.InputBox");
			//SearchBox.InputBox._visible=false;
			//fscommand("ShowTextSearchPlayer","Yes")
		}
	}
	else{
		SearchBox.InputBox.text="";
		SearchBox.InputBox._visible=true;
		Selection.setFocus("SearchBox.InputBox");
		//fscommand("ShowTextSearchPlayer","No")
	}
	ChangeInputText(ChangeLanRe);
}

function ArrowKeySearchBox(Move){
	var Move1="";
	var str="";
	var sep=""
	for(var j=0;j<CountSearchList;j++){
		Str+=sep+ "SearchBox.ListResult.Movie"+j
		sep=",";
	}
	if(SearchBox.ListResult.ButtonLeft._visible){
		Str="SearchBox.MovieL,SearchBox.MovieCancel,SearchBox.MovieOk,SearchBox.ListResult.MovieLeft,SearchBox.ListResult.MovieRight,"+Str;
	}
	else{
		Str="SearchBox.MovieL,SearchBox.MovieCancel,SearchBox.MovieOk,"+Str;
	}
	if(Move==37 || Move==38){
	        if(Move==37 & StoreNameSelected=="SearchBox.MovieOk"){
		SearchBox.Search_mc.onRelease();
	         }else{
		StaticMove(Str,StoreNameSelected,"Left");
	         }
	}
	else if(Move==39 || Move==40)StaticMove(Str,StoreNameSelected,"Right");
}

function StartSearchBox(value){
	SearchBox.ButtonOk.onRollOver();
	SearchBox.ButtonOk.onRelease();
}
function GetSearchTrackFromVB (startIndex) {
	var i=0;
	var getArray= new Array();
	for(i=0;i<nListSearch;i++){
//		fscommand
		if(i+startIndex>=ResultList.length){
			break;
		}else {
			getArray.push(ResultList[i+startIndex]);
		}
	}
	if (getArray.length==0){
		DisplayItemSearch ("SearchBox.ListResult",IndexShowSearchList,CountSearchList,nListSearch);
	}else{
		fscommand("ReadTrackInfoFromList",getArray);
	}
	delete(getArray);
}
_root.addProperty("StartSearch",GetVb1,StartSearchBox);
