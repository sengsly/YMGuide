var PicXBarD=new Array();
var PicYBarD=new Array();
var BackListDBar="BackPlayList.BackListD";
var SlyPath=new Array();
var ImgPath=new Array();
Cover._visible=false;
Cover.useHandCursor=false;
Cover.tabEnabled=false;
Rename._visible=false;
Rename.txtDes.text="Please enter a new PlayList Name:"
DeletePlayList._visible=false;
DeletePlayList.txtDes.text="Do you want to delete current PlayList ?"
RemoveAll._visible=false;
RemoveAll.txtDes.text="Do you want to remove all tracks ?"
CreateNew._visible=false;
CreateNew.txtDes.text="Please enter a new PlayList:"

//................................................	ONROLLOVER.................................
Rename.ButtonCancel.onRollOver=function(){
	SelectButton("Rename.MovieCancel");
	//SelectLevel=3;
}
Rename.ButtonOk.onRollOver=function(){
	SelectButton("Rename.MovieOk");
	
}
CreateNew.ButtonCancel.onRollOver=function(){
	SelectButton("CreateNew.MovieCancel");
	
}
CreateNew.ButtonOk.onRollOver=function(){
	SelectButton("CreateNew.MovieOk");
	
}
RemoveAll.ButtonCancel.onRollOver=function(){
	SelectButton("RemoveAll.MovieCancel");
}
RemoveAll.ButtonOk.onRollOver=function(){
	SelectButton("RemoveAll.MovieOk");
}

DeletePlayList.ButtonCancel.onRollOver=function(){
	SelectButton("DeletePlayList.MovieCancel");
	//SelectLevel=3;
}
DeletePlayList.ButtonOk.onRollOver=function(){
	SelectButton("DeletePlayList.MovieOk");
	//SelectLevel=3;
}
//................................................	ONRelease.................................
Rename.Text.onChanged = function(){
	syn_text_Rename(Rename.Text.text);
}
function syn_text_Rename(val){
	var st = new TextFormat();	
	if ((val == "")||(val == "~")){
		val = "~";
		if (send_event("normal&&&function||syn_text_Rename|~|" + val + "||3",false)){
			return;
		}
		Rename.Text.text = "";
		Rename.Text.setTextFormat(Rename.Text.length,st);
	} else {
		if (send_event("normal&&&function||syn_text_Rename|~|" + val + "||3",false)){
			return;
		}
		Rename.Text.text = String(val);
		Rename.Text.setTextFormat(Rename.Text.length,st);
	}
}

Rename.ButtonCancel.onRelease=function(){
	if (Rename._visible == true){
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
		eval("SortMaster.Button" + RecordIndexImgPath1).onRollOver();
		Rename._visible = false;
		Cover._visible = false;
		KeyBoard._visible = false;
	}
}
Rename.ButtonOk.onRelease=function(){
	if (Rename._visible == true){
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
		var f = false;
		var stText = "";
		stText = Rename.Text.text
		if(stText.length > 0){
			for(var j = 0; j < ResultP1.length; j++){
				if(ResultP1[j] == stText){
					f = true;
					break;
				}
			}
			if(f == false){
				var TempText = ResultP1[RecordIndexShowSortMaster];
				var index = (RecordIndexShowSortMaster % sortMasterTrackCount);
				eval("SortMaster.Text" + index).text = (RecordIndexShowSortMaster + 1) + " - " + stText;
				ResultP1[RecordIndexShowSortMaster] = stText;
				Rename._visible = false;
				Cover._visible = false;
				KeyBoard._visible = false;
				eval("SortMaster.Button" + RecordIndexImgPath1).onRollOver();
				SaveChangePlayList();
				if(OpenPlayList) fscommand("RenamePlayList", BackPlayList.TextD.text + StWave + stText + StWave + TempText);
			}
		}
	}
}
CreateNew.ButtonCancel.onRelease=function(){
	if (CreateNew._visible == true){
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
		SortMaster.ButtonNew.Button.onRollOver();
		CreateNew._visible = false;
		Cover._visible = false;
		KeyBoard._visible = false;
	}
}

CreateNew.Text.onChanged = function(){
	send_text_type(CreateNew.Text.text);
}
function send_text_type(val){
	var st = new TextFormat();	
	if ((val == "")||(val == "~")){
		val = "~";
		if (send_event("normal&&&function||syn_text_Rename|~|" + val + "||3",false)){
			return;
		}
		CreateNew.Text.text = "";
		CreateNew.Text.setTextFormat(CreateNew.Text.length,st);
	} else {
		if (send_event("normal&&&function||syn_text_Rename|~|" + val + "||3",false)){
			return;
		}
		CreateNew.Text.text = String(val);
		CreateNew.Text.setTextFormat(CreateNew.Text.length,st);
	}
}

CreateNew.ButtonOk.onRelease=function(){
	if (CreateNew._visible == true){
		if (send_event("normal&&&Click||" + this + "||3",false)){
			return;
		}
		var f = false;
		var stText = "";
		stText = CreateNew.Text.text
		if(stText.length > 0){
			for(var j = 0; j < ResultP.length; j++){
				if(ResultP1[j] == stText){
					f = true;
					break;
				}
			}
			if(f == false){
				if(OpenPlayList){
					fscommand("NewPlayList",stText + StWave + BackPlayList.TextD.text);
					ImgPath1[ResultP1.length] = BackPlayList.TextD.text + "\\Folder.jpg";
					ResultP1[ResultP1.length] = stText;
					SlyPath1[SlyPath1.length] = "";
					FirstDisplaySortMaster(resultP1.length);
					DisplayPictrueSortMaster(SlyPath1.length);
					SaveChangePlayList();
				} else fscommand("SortMasterAddNew");
			}
			SortMaster.ButtonNew.Button.onRollOver();
			CreateNew._visible = false;
			Cover._visible = false;
			KeyBoard._visible = false;
		}
	}
}
DeletePlayList.ButtonCancel.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	eval("SortMaster.Button" + RecordIndexImgPath1).onRollOver();
	DeletePlayList._visible = false;
	Cover._visible = false;
}
DeletePlayList.ButtonOk.onRelease=function(){
	fn_deletePlaylist_buttonOk(RecordIndexShowSortMaster);	
}
function fn_deletePlaylist_buttonOk(val){
	if (send_event("normal&&&function||fn_deletePlaylist_buttonOk|~|" + val + "||3",false)){
		return;
	}
	val = int(val);
	eval("SortMaster.Button" + RecordIndexImgPath1).onRollOver();
	DeletePlayList._visible = false;
	Cover._visible = false;
	FunDelFuncPlay(val);
	SaveChangePlayList();
}

//...........................ASSIGN VALUE TO LISTBOX...................
//..........................................FUNCTION ASSING VALUE .........................
function DisplayItem(Obj,Index,Count,n,Value,Na){
	for(var j=0;j<n;j++){
		if(j<Count){
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;
			eval(Obj+".Cover"+j)._visible=true;
			eval(Obj+".Text"+j).text=Value[Index+j]
			if(IsRegistered=="False")eval(Obj+".Logo"+j)._visible=true;
			else eval(Obj+".Logo"+j)._visible=false;
		}
		else{
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
			eval(Obj+".Cover"+j)._visible=false;
			eval(Obj+".Logo"+j)._visible=false;
		}
	}
	ChangeTextList(ChangeLan,Obj)
	DeselectedItem (Obj,eval("IndexShow"+Na),eval("RecordIndex"+Na),Na);
	DisplayPicPlayListBarD (Obj,Index,Count,n,Value);
}
function DisplayPicPlayListBarD (Obj,Index,Count,nItem,Value) {
	NameC= "BackPlayList.BackListD.Pic";
	Name1C = "BackPlayList.BackListD.PicFade";
	NameFadeC = "BackPlayList.BackListD.Movie";
	PicNameC.length = 0;
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			PicNameC[j]=ResultDPic[Index+j];
		}
		else{
			eval(Obj+".Pic"+j).unloadMovie();
			eval(Obj+".PicFade"+j).unloadMovie();
		}
	}
	ResetC(Count);
}

var ShowAlbumBar="";
function DisplayItemListP(Obj,Index,Count,n,Value,Na){
	if(ShowAlbumBar=="Album" || ShowAlbumBar=="Artist"){
		for(var j=0;j<n;j++){
			if(j<Count){
				eval(Obj+".Movie"+j)._visible=true;
				eval(Obj+".Button"+j)._visible=true;
				eval(Obj+".Text"+j)._visible=true;
				eval(Obj+".Pic"+j)._visible=true;
				eval(Obj+".PicFade"+j)._visible=true;
				eval(Obj+".Cover"+j)._visible=true;
				if(ShowAlbumBar=="Album")eval(Obj+".Text"+j).text=resultAlbum[Index+j].Artist;
				else eval(Obj+".Text"+j).text=resultArtist[Index+j].Artist;
				if(IsRegistered=="False")eval(Obj+".Logo"+j)._visible=true;
				else eval(Obj+".Logo"+j)._visible=false;
			}
			else{
				eval(Obj+".Cover"+j)._visible=false;
				eval(Obj+".Movie"+j)._visible=false;
				eval(Obj+".Pic"+j)._visible=false;
				eval(Obj+".PicFade"+j)._visible=false;
				eval(Obj+".Button"+j)._visible=false;
				eval(Obj+".Text"+j)._visible=false;
				eval(Obj+".Logo"+j)._visible=false;
			}
		}
		DisplayPicPlayListBar (Obj,Index,Count,n,ImgPath);
		if(ShowAlbumBar=="Album")DeselectedItem (Obj,eval("IndexShow"+Na),RecordIndexAlbum,Na);
		else DeselectedItem (Obj,eval("IndexShow"+Na),RecordIndexArtist,Na);
	}
	else{
		for(var j=0;j<n;j++){
			if(j<Count){
				eval(Obj+".Movie"+j)._visible=true;
				eval(Obj+".Button"+j)._visible=true;
				eval(Obj+".Text"+j)._visible=true;
				eval(Obj+".Pic"+j)._visible=true;
				eval(Obj+".PicFade"+j)._visible=true;
				eval(Obj+".Cover"+j)._visible=true;
				eval(Obj+".Text"+j).text=Value[Index+j]
				if(IsRegistered=="False")eval(Obj+".Logo"+j)._visible=true;
				else eval(Obj+".Logo"+j)._visible=false;
			}
			else{
				eval(Obj+".Cover"+j)._visible=false;
				eval(Obj+".Movie"+j)._visible=false;
				eval(Obj+".Pic"+j)._visible=false;
				eval(Obj+".PicFade"+j)._visible=false;
				eval(Obj+".Button"+j)._visible=false;
				eval(Obj+".Text"+j)._visible=false;
				eval(Obj+".Logo"+j)._visible=false;
			}
		}
		ChangeTextList(ChangeLan,Obj)
		DeselectedItem (Obj,eval("IndexShow"+Na),eval("RecordIndex"+Na),Na);
		DisplayPicPlayListBar (Obj,Index,Count,n,ImgPath);
	}
}
function DisplayPicPlayListBar (Obj,Index,Count,nItem,Value) {
	
	NameC= "BackListP.Pic";
	Name1C = "BackListP.PicFade";
	NameFadeC = "BackListP.Movie";
	PicNameC.length = 0;
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			if(ShowAlbumBar=="Album")PicNameC[j]=resultAlbum[Index+j].ReservePath;
			else if(ShowAlbumBar=="Artist")PicNameC[j]=resultArtist[Index+j].ReservePath;
			else PicNameC[j]=Value[Index+j];
		}
		else{
			eval(Obj+".Pic"+j).unloadMovie();
			eval(Obj+".PicFade"+j).unloadMovie();
		}
	}
	ResetC(Count);
}
function InvisibleArrow1(Obj,n){
	if(n<=nPlayList){
		eval(Obj+".ButtonLeft")._visible=false;
		eval(Obj+".ButtonRight")._visible=false;
		eval(Obj+".MovieLeft")._visible=false;
		eval(Obj+".MovieRight")._visible=false;
	}
	else{
		eval(Obj+".ButtonLeft")._visible=true;
		eval(Obj+".ButtonRight")._visible=true;
		eval(Obj+".MovieLeft")._visible=true;
		eval(Obj+".MovieRight")._visible=true;
	}
}
//		.................FOR DIR.................
function FirstDisplayD(n){
	InvisibleArrow1("BackPlayList.BackListD",n);
	FirstDisplay("D",n,nPlayList);
	DisplayItem ("BackPlayList.BackListD",IndexShowD,CountD,nPlayList,ResultDName,"D");
}
BackPlayList.BackListD.ButtonLeft.onRollOver=function(){
	SelectButton("BackPlayList.BackListD.MovieLeft");
	SelectLevel=2;
}
BackPlayList.BackListD.ButtonRight.onRollOver=function(){
	SelectButton("BackPlayList.BackListD.MovieRight");
	SelectLevel=2;
}
BackPlayList.BackListD.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	ClickLeft("D");
	DisplayItem ("BackPlayList.BackListD",IndexShowD,CountD,nPlayList,ResultDName,"D");
}
BackPlayList.BackListD.ButtonRight.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	ClickRight("D");
	DisplayItem ("BackPlayList.BackListD",IndexShowD,CountD,nPlayList,ResultDName,"D");
}
//................FOR PLAYLIST...................
function ReturnLevel(Num,n){
	if (Num%n== 0) return int(Num/n);
	else return int(Num/n)+1;
}
function ReturnCount(Level,TotalLevel,Num,n){
	var Count=0;
	if(Level==TotalLevel){
		if(Num%n==0) Count=n;
		else Count=Num%n;
	}
	else Count=n;
	return Count;
}


function FirstDisplayP(n,Index){
	InvisibleArrow1("BackListP",n);
	FirstDisplay("P",n,nPlayList);
	
	//var Level=ReturnLevel(RecordIndexP+1 , nPlayList);
	var Level=ReturnLevel(Index+1 , nPlayList);
	IndexShowP=(Level-1) * nPlayList;
	CountP=ReturnCount(Level,TotalLevelIndexP,n,nPlayList)
	LevelIndexP=Level;
	DisplayItemListP ("BackListP",IndexShowP,CountP,nPlayList,ResultP,"P");
}
BackListP.ButtonLeft.onRollOver=function(){
	SelectButton("BackListP.MovieLeft");
}
BackListP.ButtonRight.onRollOver=function(){
	SelectButton("BackListP.MovieRight");
}

BackListP.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	ClickLeft("P");
	DisplayItemListP ("BackListP",IndexShowP,CountP,nPlayList,ResultP,"P");
}
BackListP.ButtonRight.onRelease=function(){
if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}

	ClickRight("P");
	DisplayItemListP ("BackListP",IndexShowP,CountP,nPlayList,ResultP,"P");
}
//...........................Add Track By Code ID...........................................................
AddTrackBox.ButtonK.onRollOver = function(){
	SelectButton("AddTrackBox.MovieK");
}
AddTrackBox.ButtonK.onRelease = function(){
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

//...........................MAKING EVEN ON LISTITEM.............
var RecordIndexD=RecordIndexP=0;
function ResetValueListItem(){
	RecordIndexD=0;
	RecordIndexP=0;
	DeselectedItem ("BackPlayList.BackListD",IndexShowD,RecordIndexD,"D");
	DeselectedItem ("BackListP",IndexShowP,RecordIndexP,"P");
}
var PicXBar=new Array();
var PicYBar=new Array();
var GenreName="BackListP";
for(var j=0;j<nList;j++){
	//.............................listD.........................................................
	eval("BackPlayList.BackListD.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		var k1=IndexShowD+k;
		SelectButton("BackPlayList.BackListD.Movie"+k);
		if(!ButtonTooltip._visible || !TextTip._visible){
			TextTip._visible=true;
			ButtonTooltip._visible=true;
		}
		//TextTip.text=ResultD[k1];
		popup_tooltip("TextTip:ButtonTooltip",ResultD[k1]);
		ChangeTooltip("Eng");
		ButtonToolTip._width=TextTip._width+10;
	}
	eval("BackPlayList.BackListD.Button"+j).onRelease=function(){
		var ind = GetNumber(this._name);
		click_backPlaylist(IndexShowD,ind);
	}
	//.............................ListP........................................................
	eval("BackListP.Button"+j).onRollOver=function(){
		SelectLevel = 2;
		var k=GetNumber(this._name);
		SelectButton("BackListP.Movie"+k);
		var k1=IndexShowP+k;
		if(!ButtonTooltip._visible || !TextTip._visible){
			TextTip._visible=true;
			ButtonTooltip._visible=true;
		}
		if(MainLevel==1 || MainLevel==2){
			//TextTip.text=ResultP[k1];
			popup_tooltip("TextTip:ButtonTooltip",ResultP[k1]);
			ChangeTooltip("Eng");
		}
		else if(MainLevel==3 && PlayListMode=="Artist"){
			if(ChangeLan=="Eng"){
				//TextTip.text=resultArtist[k1].Artist;
				popup_tooltip("TextTip:ButtonTooltip",resultArtist[k1].Artist);
			}else{
				//TextTip.text=resultArtist[k1].uniArtist;
				popup_tooltip("TextTip:ButtonTooltip",resultArtist[k1].uniArtist);
			}
			ChangeTooltip(ChangeLan,resultArtist[k1].Nation);
		}
		else if(MainLevel==3 && PlayListMode=="Album"){
			//TextTip.text=ResultP[k1];
			popup_tooltip("TextTip:ButtonTooltip",ResultP[k1]);
			ChangeTooltip("Eng");
		}
		else if(MainLevel==4 && PlayListMode!="TrackTitle"){
			if(ChangeLan=="Eng"){
				//TextTip.text=resultAlbum[k1].Artist;
				popup_tooltip("TextTip:ButtonTooltip",resultAlbum[k1].Artist);
			}else{
				//TextTip.text=resultAlbum[k1].uniArtist;
				popup_tooltip("TextTip:ButtonTooltip",resultAlbum[k1].uniArtist);
			}
			ChangeTooltip(ChangeLan,resultAlbum[k1].Nation);
		}
		else if(MainLevel==4 && PlayListMode=="TrackTitle"){
			//TextTip.text=ResultP[k1];
			popup_tooltip("TextTip:ButtonTooltip",ResultP[k1]);
			ChangeTooltip("Eng");
		}
		ButtonToolTip._width=TextTip._width+10;
	}
	eval("BackListP.Button"+j).onRelease=function(){
		var val_ind = GetNumber(this._name);
		click_playlist_bar(IndexShowP, val_ind);
	}
	PicXBar[j] = eval("BackListP.Pic" + j)._x;
	PicYBar[j] = eval("BackListP.Pic" + j)._y;
}
//...........................DESELECT FUNCTION
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
	return Index+StWave+Count+StWave+CalLevel;
}
//.....................	LOAD XML.........................

function LoadTrackByPlayListName(StName){
	var Xml=new XML();	
	Xml.load(StName);
	Xml.onLoad=function(){
		resultSearch.length=0;
		
		if(Xml.loaded){
			var n=Xml.childNodes[0].childNodes.length;
			for(var j=0;j<n;j++){
				var Al=Xml.childNodes[0].childNodes[j].attributes.Album;
				var AlU=Xml.childNodes[0].childNodes[j].attributes.UniAlbum;
				var T=Xml.childNodes[0].childNodes[j].attributes.Track;
				var UT=Xml.childNodes[0].childNodes[j].attributes.UniTrack;
				var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
				var UAr=Xml.childNodes[0].childNodes[j].attributes.UniArtist;
				var Md=Xml.childNodes[0].childNodes[j].attributes.Mood;
				var UMd=Xml.childNodes[0].childNodes[j].attributes.UniMood;
				var Da=Xml.childNodes[0].childNodes[j].attributes.Dance;
				var UDa=Xml.childNodes[0].childNodes[j].attributes.UniDance;
				var Rat=Xml.childNodes[0].childNodes[j].attributes.Rating;
				var Ge=Xml.childNodes[0].childNodes[j].attributes.Genre;
				var UGe=Xml.childNodes[0].childNodes[j].attributes.UniGenre;
				var Mod=Xml.childNodes[0].childNodes[j].attributes.Mode;
				var TId=Xml.childNodes[0].childNodes[j].attributes.TrackId;
				var singType=Xml.childNodes[0].childNodes[j].attributes.singType;
				var SeekOffset=Xml.childNodes[0].childNodes[j].attributes.SeekOffset;
				var RePathPic=Xml.childNodes[0].childNodes[j].attributes.PicPath;
				var Lan1=Xml.childNodes[0].childNodes[j].attributes.language;
				var LanTrack=Xml.childNodes[0].childNodes[j].attributes.LanTrack;
				if(Mod=="External"){
					var PathPic1=RePathPic;
					var ShoppingID="";
					var ZoomLevel=Xml.childNodes[0].childNodes[j].attributes.ZoomLevel;
					var BlankTop=Xml.childNodes[0].childNodes[j].attributes.BlankTop;
					var BlankBottom=Xml.childNodes[0].childNodes[j].attributes.BlankBottom;
					var Actor="";
					var Director="";
				}
				else{
					var PathPic1=SplAllCountrys[Lan1].IMPath+"\\"+RePathPic+"\\"+Al+"\\folder.jpg";
					var ShoppingID=Xml.childNodes[0].childNodes[j].attributes.ShoppingID;
					var Actor=Xml.childNodes[0].childNodes[j].attributes.Actor;
					var Director=Xml.childNodes[0].childNodes[j].attributes.Director;
				}
				var ComName1=Xml.childNodes[0].childNodes[j].attributes.ComName;
				var AlbumID=Xml.childNodes[0].childNodes[j].attributes.AlbumID;
				var StPlayer=Xml.childNodes[0].childNodes[j].attributes.StPlayer;
				var YearTrack=Xml.childNodes[0].childNodes[j].attributes.TrackYear;
				var Ava=Xml.childNodes[0].childNodes[j].attributes.TrackAva;
				var walMart_Ava=Xml.childNodes[0].childNodes[j].attributes.walMart_Ava;
				var NoTrack=int(Xml.childNodes[0].childNodes[j].attributes.NoTrack);
				var IsBookMark=int(Xml.childNodes[0].childNodes[j].attributes.IsBookmark);
				var BookMarkTitle=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkTitle);
				var BookMarkTime=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkTime);		//EDID:2005.11.07
				var BookmarkLength=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkLength);
				var BookmarkChapter=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkChapter);
				var MainTitle=int(Xml.childNodes[0].childNodes[j].attributes.MainTitle);
				var AudioChannel=int(Xml.childNodes[0].childNodes[j].attributes.AudioChannel);
				var iPlayFrom = int(Xml.childNodes[0].childNodes[j].attributes.PlayTrackFrom);
				var NetPath = Xml.childNodes[0].childNodes[j].attributes.NetPath;
				
				resultSearch[j] = new con_ResultSearch(Al,AlU, T, UT, Ar, UAr,  Md, UMd, Da, UDa, Rat, Ge, UGe,Mod,TId,PathPic1,Lan1,ComName1,AlbumID,StPlayer,RePathPic,LanTrack,YearTrack,Ava,walMart_Ava,ShoppingID,NoTrack,j,ZoomLevel,BlankTop,BlankBottom,IsBookMark,BookMarkTitle,BookMarkTime,BookmarkLength,BookmarkChapter);
				resultSearch[j].SingType=singType;			//EDID:2005.11.07
				resultSearch[j].SeekOffset=SeekOffset;		//EDID:2005.11.24
				resultSearch[j].MainTitle=MainTitle;		//EDID:2005.11.07
				resultSearch[j].AudioChannel=AudioChannel;	//EDID:2005.11.15
				resultSearch[j].PlayTrackFrom=iPlayFrom;	//EDID:2006.02.04
				resultSearch[j].NetPath=NetPath;			//EDID:2006.04.19
			}
			FirstDisplayTrack(n);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
		}
		else{
			FirstDisplayTrack(0)
		}
	}
}

//LoadPlayList("D:/CDInfo");
function LoadPlayList(StName){
	ResultP.length=0;
	var Xml=new XML();
	Xml.load(StName+"\\PlayLists\\PlayLists.xml");
	SlyPath.length=0;
	ImgPath.length=0;
	Xml.onLoad=function(){
		if(Xml.loaded){
			var n=0;
			n=Xml.childNodes[0].childNodes.length;
			for(var j=0;j<n;j++){
				ResultP[j]=Xml.childNodes[0].childNodes[j].childNodes[0].nodeValue;
				SlyPath[j]=Xml.childNodes[0].childNodes[j].attributes.SlidePath;
				ImgPath[j]=Xml.childNodes[0].childNodes[j].attributes.ImgPath;
				if(ImgPath[j]==""){
					ImgPath[j]=StName+"\\Folder.jpg";
				}
			}
			ArrowBar._visible=true;
			BackPlayList1._visible=true;
			FirstDisplayMovie(ResultP.length,ResultP);
		}
		else{
			FirstDisplayMovie(0);
		}
	}
	
}
var ResultDName=new Array();
var  ResultDPic=new Array();
var StoreLevel="";
var StoreName="";
function LoadPlayListPath(StName){
	var Xml=new XML();	
	//Xml.load(StName+"\\Sly\\PlayListPaths.xml");
	Xml.load(main_path_playlist + "\\PlayListPaths.xml");
	Xml.onLoad=function(){
		ResultD.length=0;
		ResultDName.length=0;
		if(Xml.loaded){
			var n=0;
			n=Xml.childNodes[0].childNodes.length;
			StoreName=Xml.childNodes[0].attributes.StoreName;
			StoreLevel=Xml.childNodes[0].attributes.StoreLevel;
			
			RecordIndexD=0;
			for(var j=0;j<n;j++){
				ResultD[j]=Xml.childNodes[0].childNodes[j].childNodes[0].nodeValue;
				ResultDName[j]=Xml.childNodes[0].childNodes[j].attributes.Name;
				ResultDPic[j]=Xml.childNodes[0].childNodes[j].attributes.ImgPath;
				if(StoreName==ResultDName[j])RecordIndexD=j;
			}
			BackPlayList.TextD.text=ResultD[RecordIndexD];
			fscommand("SetPlayListDir",BackPlayList.TextD.text);
			FirstDisplayD(ResultD.length);
			LoadPlayList(ResultD[RecordIndexD]);
		}
		else{
			BackPlayList.TextD.text=ResultD[0];
			FirstDisplayD(ResultD.length);
		}
	}
}

function LoadExternalTrack(StName,stCom){
	var Xml=new XML();	
	Xml.load(StName);
	Xml.onLoad=function(){
		resultSearch.length=0;
		if(Xml.loaded){
			var n=Xml.childNodes[0].childNodes.length;
			var i=0;
			for(var j=0;j<n;j++){
				var Al=Xml.childNodes[0].childNodes[j].attributes.Album;
				if(stCom==Al+"(External)"){
					var AlU=Al;
					var T=Xml.childNodes[0].childNodes[j].attributes.Track;
					var UT=T;
					var TId=Xml.childNodes[0].childNodes[j].attributes.TrackId;
					var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
					var UAr=Ar;
					var PathPic1=Xml.childNodes[0].childNodes[j].attributes.PicPath;
					var Lan1="English";
					var Mod="External";
					var RePathPic=PathPic1;
					var StPlayer=Xml.childNodes[0].childNodes[j].attributes.StPlayer;
					var ComName1=Xml.childNodes[0].childNodes[j].attributes.ComName;
					var Ava=Xml.childNodes[0].childNodes[j].attributes.TrackAva;
					var Rat=Xml.childNodes[0].childNodes[j].attributes.Rating;
					var ZoomLevel=Xml.childNodes[0].childNodes[j].attributes.ZoomLevel;
					var BlankTop=Xml.childNodes[0].childNodes[j].attributes.BlankTop;
					var BlankBottom=Xml.childNodes[0].childNodes[j].attributes.BlankBottom;
					
					var IsBookMark=int(Xml.childNodes[0].childNodes[j].attributes.IsBookmark);
					var BookMarkTitle=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkTitle);
					var BookMarkTime=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkTime);
					var BookmarkLength=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkLength);
					var BookmarkChapter=int(Xml.childNodes[0].childNodes[j].attributes.BookmarkChapter);
					
					resultSearch[i] = new con_ResultSearch(Al,AlU, T, UT, Ar, UAr,  Md, UMd, Da, UDa, Rat, Ge, UGe,Mod,TId,PathPic1,Lan1,ComName1,LanPath1,StPlayer,RePathPic,"","",Ava,"","","",i,ZoomLevel,BlankTop,BlankBottom,IsBookMark,BookMarkTitle,BookMarkTime,BookmarkLength,BookmarkChapter);
					i+=1;
				}
			}
			FirstDisplayTrack(resultSearch.length);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
		}
		else{
			FirstDisplayTrack(0)
		}
		
	}
}


//..................................................................................................................
function HighLightText (Obj,IndexShow,Index,n) {
		for(var j=0;j<n;j++){
			if((IndexShow+j)==Index){
				eval(Obj+".Text"+j).textColor=SelectColorValue;
			}
			else{
				 eval(Obj+".Text"+j).textColor=FontColor;
			}
		}	
}
function DisplayItemVol (Obj,Index,Count,nItem) {
	if(Obj=="VolBar")HighLightText ("VolBar",IndexShowVol,RecordIndexVol,nVol)
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;
			eval(Obj+".Text"+j).text=resultSearchVol[Index+j];
		}
		else{
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
		}
	}
}

var RecordIndexVol;
var RecordLevelVol;
function FirstDisplayVol(n){
	VolBarArrow(n);
	FirstDisplay("Vol",n,nVol);
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol);
	
}
VolBar.ButtonLeft.onRollOver=function(){	
	SelectButton("VolBar.MovieLeft");
	SelectLevel=3;	
}
VolBar.ButtonRight.onRollOver=function(){
	SelectButton("VolBar.MovieRight");
	SelectLevel=3;
}

VolBar.ButtonLeft.onRelease=function(){
	ClickLeft("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol);
}
VolBar.ButtonRight.onRelease=function(){
	ClickRight("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol);
}
var IndexNameVol=0;
for (var j = 0; j<nVol; j++) {
	eval("VolBar.Button"+j).onRollOver = function() {
		var IndexName = GetNumber(this._name);
		SelectButton("VolBar.Movie"+IndexName);
		SelectLevel=3;
	};
	eval("VolBar.Button"+j).onRelease = function() {
		var IndexName = GetNumber(this._name);
		var Index = IndexShowVol+IndexName;
		IndexNameVol=int(IndexName);
		RecordIndexVol = Index;
		RecordLevelVol = LevelIndexVol;
		HighLightText ("VolBar",IndexShowVol,RecordIndexVol,nVol)
		var spl = resultSearchVol[RecordIndexVol].split(":");
		Index = parseInt(spl[0], 10);
		var count = parseInt(spl[1], 10)-index;
		StoreIndexVol1=Index-1;
		StoreCountVol1=count+1;
		ShowMovieArtist(NameAlbum, StoreIndexVol1, StoreCountVol1, resultAlbum);
		
	};
}
var StoreIndexVol1=0;
var StoreCountVol1=0;



//////..........................................................
function VolBarArrow(n){
	if(n<=1){
		VolBar.MovieArrowLeft._visible=false;
		VolBar.MovieArrowRight._visible=false;
		VolBar.ButtonArrowLeft._visible=false;
		VolBar.ButtonArrowRight._visible=false;
		VolBar.IconArrowRight._visible=false;
		VolBar.IconArrowLeft._visible=false;
	}
	else{
		VolBar.MovieArrowLeft._visible=true;
		VolBar.MovieArrowRight._visible=true;
		VolBar.ButtonArrowLeft._visible=true;
		VolBar.ButtonArrowRight._visible=true;
		VolBar.IconArrowRight._visible=true;
		VolBar.IconArrowLeft._visible=true;
	}
}
VolBar.ButtonArrowLeft.onRollOver=function(){
	SelectButton("VolBar.MovieArrowLeft");
	SelectLevel=3;
}
VolBar.ButtonArrowRight.onRollOver=function(){
	SelectButton("VolBar.MovieArrowRight");
	SelectLevel=3;
}
VolBar.ButtonArrowLeft.onRelease=function(){
	var Index=IndexNameVol-1;
	if(Index>=0){
		eval("VolBar.Button"+Index).onRelease();
	}
	else{
		if(VolBar.ButtonLeft._visible){
			VolBar.ButtonLeft.onRelease();
			eval("VolBar.Button"+(CountVol-1)).onRelease();
		}
		else eval("VolBar.Button"+(CountVol-1)).onRelease();
	}
}
VolBar.ButtonArrowRight.onRelease=function(){
	var Index=IndexNameVol+1;
	if(Index<nVol){
		if(eval("VolBar.Button"+Index)._visible){
			eval("VolBar.Button"+Index).onRelease();
		}
		else{
			if(VolBar.ButtonRight._visible){
				VolBar.ButtonRight.onRelease();
				eval("VolBar.Button"+0).onRelease();
			}
			else{
				eval("VolBar.Button"+0).onRelease();
			}
		}
	}
	else{
		if(VolBar.ButtonRight._visible){
			VolBar.ButtonRight.onRelease();
			eval("VolBar.Button"+0).onRelease();
		}
		else{
			eval("VolBar.Button"+0).onRelease();
		}
	}
}

//............................
ArtistMode._visible=false;
ArtistSorted._visible=false;
ArtistSorted.Text.text="Sorted By ReleaseDate";
ArtistMode.Button.onRollOver=function(){
	SelectButton("ArtistMode.Movie");
	SelectLevel=3;
}
var ArtistModeValue=3
var ArtistSortedValue=0
ArtistMode.Button.onRelease=function(){
	click_artist_mode(ArtistMode.Text.text);
}
function click_artist_mode(val){
	if (send_event("normal&&&function||click_artist_mode|~|" + val + "||3",false)){
		return;
	}
	if(val == "Albums Available") {
		ArtistMode.Text.text = "Albums In Playlist";
	} else if (val == "Albums In Playlist") {
		ArtistMode.Text.text = "Display All Albums";
		ArtistModeValue = 3;
	} else {
		ArtistModeValue = 1;
		ArtistMode.Text.text = "Albums Available";
	}
}
ArtistSorted.Button.onRollOver=function(){
	SelectButton("ArtistSorted.Movie");
	SelectLevel=3;
}
ArtistSorted.Button.onRelease=function(){
	click_artist_sorted(ArtistSorted.Text.text);
}
function click_artist_sorted(val){
	if (send_event("normal&&&function||click_artist_sorted|~|" + val + "||3",false)){
		return;
	}
	if(val == "Sorted By ReleaseDate"){
		ArtistSorted.Text.text = "Sorted By Alphabet";
		ArtistSortedValue = 1;
		Grouping = "True";
	} else {
		ArtistSorted.Text.text = "Sorted By ReleaseDate";
		ArtistSortedValue = 0;
		Grouping = "False";
	}
	fscommand("SendVaueGrouping",Grouping);
}
//.....................

var PlayListMode="";
//var PlayListMode1="";
MenuMode.Track.Text.text=TrackText;
MenuMode.Album.Text.text=AlbumText;
MenuMode.Artist.Text.text=SingerText;
MenuMode.Default.Text.text="Default";




//		ROLLOVER..........
BackPlayList1.ButtonMode.onRollOver=function(){
	
	SelectButton("BackPlayList1.MovieMode");
	SelectLevel=3;
	if(!ButtonTooltip._visible || !TextTip._visible){
		ButtonTooltip._visible=true;
		TextTip._visible=true;
	}
	//TextTip.text="Playlist Display Mode";
	popup_tooltip("TextTip:ButtonTooltip","Playlist Display Mode");
	ChangeTooltip("Eng");
	ButtonToolTip._width=TextTip._width+10;
}
MenuMode.Track.Button.onRollOver=function(){
	SelectButton("MenuMode.Track.Movie");
	SelectLevel=3;
}
MenuMode.Album.Button.onRollOver=function(){
	SelectButton("MenuMode.Album.Movie");
	SelectLevel=3;
}
MenuMode.Artist.Button.onRollOver=function(){
	SelectButton("MenuMode.Artist.Movie");
	SelectLevel=3;
}
MenuMode.Default.Button.onRollOver=function(){
	SelectButton("MenuMode.Default.Movie");
	SelectLevel=3;
}

///.................RELEASE..............
BackPlayList1.ButtonMode.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	if(MenuMode._visible)MenuMode._visible=false;
	else MenuMode._visible=true;
}
MenuMode.Track.Button.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	PlayListMode = "TrackTitle";
	BackPlayList1.TextMode.text = TrackText;
	fscommand("ChangePlayListMode", PlayListMode);
	ChangeColorTextSelected("MenuMode.Track.Text,MenuMode.Album.Text,MenuMode.Artist.Text,MenuMode.Default.Text","MenuMode.Track.Text");
	MenuMode._visible = false;
	BackPlayList1.ButtonMode.onRollOver();
}
MenuMode.Album.Button.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	PlayListMode = "Album";
	BackPlayList1.TextMode.text = AlbumText;
	fscommand("ChangePlayListMode", PlayListMode);
	ChangeColorTextSelected("MenuMode.Track.Text,MenuMode.Album.Text,MenuMode.Artist.Text,MenuMode.Default.Text","MenuMode.Album.Text");
	MenuMode._visible = false;
	BackPlayList1.ButtonMode.onRollOver();
}
MenuMode.Artist.Button.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	PlayListMode = "Artist";
	BackPlayList1.TextMode.text = SingerText;
	fscommand("ChangePlayListMode", PlayListMode);
	ChangeColorTextSelected("MenuMode.Track.Text,MenuMode.Album.Text,MenuMode.Artist.Text,MenuMode.Default.Text","MenuMode.Artist.Text");
	MenuMode._visible = false;
	BackPlayList1.ButtonMode.onRollOver();
}
MenuMode.Default.Button.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}
	PlayListMode = "Default";
	BackPlayList1.TextMode.text = PlayListMode;
	fscommand("ChangePlayListMode",PlayListMode);
	ChangeColorTextSelected("MenuMode.Track.Text,MenuMode.Album.Text,MenuMode.Artist.Text,MenuMode.Default.Text","MenuMode.Default.Text");
	MenuMode._visible = false;
	BackPlayList1.ButtonMode.onRollOver();
}


function LoadXmlDefineMode(StName,PMode){
	FirstPlayListShow = "false";
	var temp = new Array();
	var Xml = new XML();	
	Xml.load(StName);		
	Xml.onLoad=function(){
		if(Xml.loaded){
			var n=Xml.childNodes[0].childNodes.length;
			if(PMode=="Default"){
				PMode=Xml.childNodes[0].attributes.DisplayMode;
			}
			if(PMode=="Album"){
				resultAlbum.length=0;
				for(var j=0;j<n;j++){
					var f=false;
					var Al=Xml.childNodes[0].childNodes[j].attributes.Album;
					var AlumLan=Xml.childNodes[0].childNodes[j].attributes.language;
					//loop to see if it is duplicated
					for(var i=0;i<temp.length;i++){
						if(temp[i]==Al+";"+AlumLan){
							f=true;
							break;
						}
					}
					if(!f){
						temp[temp.length]=Al+";"+AlumLan;
						var Alid=Xml.childNodes[0].childNodes[j].attributes.AlbumID;
						var AlU=Xml.childNodes[0].childNodes[j].attributes.UniAlbum;
						var PicPath=Xml.childNodes[0].childNodes[j].attributes.PicPath;
						var RePathPic=PicPath;
						var Lan=Xml.childNodes[0].childNodes[j].attributes.language;
						var Mode=Xml.childNodes[0].childNodes[j].attributes.Mode;
						var stplayer=Xml.childNodes[0].childNodes[j].attributes.StPlayer;
						var YearTrack=Xml.childNodes[0].childNodes[j].attributes.TrackYear;
						var Actor=Xml.childNodes[0].childNodes[j].attributes.Actor;
						var Director=Xml.childNodes[0].childNodes[j].attributes.Director;
						if(getKhmerCountry(Lan)=="1" && FontKhmer.length<=0){
							var spl1=stplayer.split("%%");
							var spl2=spl1[2].split(StWaveSpl);
							var spl3=spl2[1].split("||");
							var Font=spl3[1];
							FontKhmer=Font;
						}
						if(Mode=="External"){
							var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
							var path=PicPath;
							Al+="(External)";
							AlU=Al;
						}
						else{
							var path=SplAllCountrys[Lan].IMPath+"\\"+PicPath+"\\"+Al+"\\folder.jpg";
						}
						var Index=resultAlbum.length;
						resultAlbum[Index] = new con_ArtistName(Alid,Al,AlU,path,Lan,Font,Mode,stplayer,PicPath,"1",YearTrack,"Album",resultAlbum.length);
						resultAlbum[Index].Actor=Actor;
						resultAlbum[Index].Director=Director;
					}
				}
				ArrowBar._visible=false;
				VolBar._visible=true;
				SplitResultVol(parseInt(resultAlbum.length, 10), NumMovie);
				FirstDisplayVol(resultSearchVol.length);
				VolBar.Button0.onRelease();
				if(eval(NameAlbum+".Button0")._visible){
					eval(NameAlbum+".Button0").onRollOver();
				}else{
					ButtonM.onRollOver();
				}
			}
			else if(PMode=="Artist"){
				resultArtist.length=0;
				var stringSearch="&";
				for(var j=0;j<n;j++){
					var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
					var ArU=Xml.childNodes[0].childNodes[j].attributes.UniArtist;
					var Lan=Xml.childNodes[0].childNodes[j].attributes.language;
					splAr.length=0;
					splArU.length=0;
					splAr=Ar.split(" + ");
					if(getKhmerCountry(Lan)=="1"){
						splArU=ArU.split(" ÷ ");
					}else{
						splArU=ArU.split(" + ");
					}
					for(var i=0;i<splAr.length;i++){
						if (stringSearch.indexOf("&"+splAr[i]+ ";"+ Lan+"&",0)==-1){
							stringSearch=stringSearch + splAr[i]+ ";"+ Lan+ "&"
							var Al=Xml.childNodes[0].childNodes[j].attributes.Album;
							var PicPath=Xml.childNodes[0].childNodes[j].attributes.PicPath;
							var Mode=Xml.childNodes[0].childNodes[j].attributes.Mode;
							var stplayer=Xml.childNodes[0].childNodes[j].attributes.StPlayer;
							if(getKhmerCountry(Lan)=="1" && FontKhmer.length<=0){
								var spl1=stplayer.split("%%");
								var spl2=spl1[2].split(StWaveSpl);
								var spl3=spl2[1].split("||");
								var Font=spl3[1];
								FontKhmer=Font;
							}
							if(Mode=="External"){
								var path=PicPath;
								//Ar+="(External)";
								splArU[i]=splAr[i];
							}
							else{
								var path=SplAllCountrys[Lan].IMPath+"\\"+GetFirstLetter(splAr[i])+"\\"+splAr[i]+"\\folder.jpg";
							}
							var StringPath=GetFirstLetter(splAr[i])+"\\"+splAr[i]+"\\folder.jpg";
							resultArtist[resultArtist.length] = new con_ArtistName("",splAr[i],splArU[i],path,Lan,Font,Mode,stplayer,StringPath,"","","Artist",resultArtist.length);
						
						}//endif
					}//endfor
				}//endfor
				FirstDisplayMovie(resultArtist.length,resultArtist);
			}//endPMode=="Artist"
		}
	}
}

//LoadXmlDefineMode("D:\\testdany\\PlayLists\\Default.xml");

function GetAlbumByArtist(StName,ArtistName){
	FirstPlayListShow="false";
	var temp=new Array();
	var Xml=new XML();	
	Xml.load(StName);		
	Xml.onLoad=function(){
		if(Xml.loaded){
			var n=Xml.childNodes[0].childNodes.length;
			resultAlbum.length=0;
			for(var j=0;j<n;j++){
				var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
				if(Ar.indexOf(ArtistName,0)!=-1){
					var f=false;
					var Al=Xml.childNodes[0].childNodes[j].attributes.Album;
					for(var i=0;i<temp.length;i++){
						if(temp[i]==Al){
							f=true;
							break;
						}
					}
						if(!f){
							temp[temp.length]=Al;
							var Alid=Xml.childNodes[0].childNodes[j].attributes.AlbumID;
							var AlU=Xml.childNodes[0].childNodes[j].attributes.UniAlbum;
							var PicPath=Xml.childNodes[0].childNodes[j].attributes.PicPath;
							var RePathPic=PicPath;
							var Lan=Xml.childNodes[0].childNodes[j].attributes.language;
							var Mode=Xml.childNodes[0].childNodes[j].attributes.Mode;
							var stplayer=Xml.childNodes[0].childNodes[j].attributes.StPlayer;
							var YearTrack=Xml.childNodes[0].childNodes[j].attributes.TrackYear;
							if(getKhmerCountry(Lan)=="1" && FontKhmer.length<=0){
								var spl1=stplayer.split("%%");
								var spl2=spl1[2].split(StWaveSpl);
								var spl3=spl2[1].split("||");
								var Font=spl3[1];
								FontKhmer=Font;
							}
							if(Mode=="External"){
								var Ar=Xml.childNodes[0].childNodes[j].attributes.Artist;
								var path=PicPath;
								Al+="(External)";
								AlU=Al;
							}
							else{
								var path=SplAllCountrys[Lan].IMPath+"\\"+PicPath+"\\"+Al+"\\folder.jpg";
							}
							resultAlbum[resultAlbum.length] = new con_ArtistName(Alid,Al,AlU,path,Lan,Font,Mode,stplayer,RePathPic,"1",YearTrack,"Album",resultAlbum.length);
						}
					}
			}//endfor
			ArrowBar._visible=false;
			VolBar._visible=true;
			SplitResultVol(parseInt(resultAlbum.length, 10), NumMovie);
			FirstDisplayVol(resultSearchVol.length);
			VolBar.Button0.onRelease();
			eval(NameAlbum+".Button0").onRollOver();
			
		}//endif
	}//endxml
}








///	 END FUNCTION RESET()		\\\
var PicX=new Array();
var PicY=new Array();
var RecordIndexArtistAlbum=0;
var NumAlbum=0;
var MainLevel=1;
var IndexPlayList=0;
var RecordIndexArtist=0;
function ActiveButtonAlbum(Obj) {
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Button"+j).onRollOver = function() {
			var IndexAlbum = GetNumber(this._name);
			SelectButton(NameAlbum+".Movie"+IndexAlbum);
			SelectLevel=4;
			if(!ButtonTooltip._visible || !TextTip._visible){
				ButtonTooltip._visible=true;
				TextTip._visible=true;
			}
			if (DisplayAlbumLong=="true"){
				//TextTip.text=eval(NameAlbum+".Letter"+IndexAlbum).valText;//eval(NameAlbum+".Letter"+IndexAlbum).text;
				popup_tooltip("TextTip:ButtonTooltip",eval(NameAlbum+".Letter"+IndexAlbum).valText);
			}else{
				//TextTip.text=eval(NameAlbum+".Letter"+IndexAlbum).text;
				popup_tooltip("TextTip:ButtonTooltip",eval(NameAlbum+".Letter"+IndexAlbum).text);
			}
			if(MainLevel==1){
				ChangeTooltip("Eng");

			}
			else if(MainLevel==2){
				var k=IndexShowArrow+IndexAlbum;
				ChangeTooltip(ChangeLan,resultArtist[k].Nation);
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var k = (parseInt(spl[0], 10)-1)+IndexAlbum;
				ChangeTooltip(ChangeLan,resultAlbum[k].Nation);
			}
			ButtonToolTip._width=TextTip._width+10;
		};
		eval(NameAlbum+".Button"+j).onRelease = function() {
			if (_global.boolMouseDown == false)return;
			_global.boolMouseDown = false;
			//..............
			click_each_playlist(MainLevel,GetNumber(this._name));
		}
	}
}
//............................SHOWMOVIEALBUM..........................
function FirstDisplayMovie(n,Value){
	FirstDisplay("Arrow",n,NumMovie);
	if(MainLevel==1){
		var spl=StoreLevel.split("~");
		if(int(spl[1])>0 && NumMovie==int(spl[3]) && ResultDName[RecordIndexD]==spl[4]){
			LevelIndexArrow=int(spl[0]);
			IndexShowArrow=int(spl[1]);
			//CountArrow=int(spl[2]);
			CountArrow=0;
			for(var j=0;j<NumMovie;j++){
				if(ResultP[IndexShowArrow+j].length>0)CountArrow+=1;
			}
			
		}
	}
	if(ResultP.length>0 && CountArrow==0)FirstDisplay("Arrow",n,NumMovie);
	ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, Value);
}
ArrowBar.ButtonLeft.onRollOver=function(){
	SelectButton("ArrowBar.MovieLeft");
	SelectLevel=3;
	ButtonToolTip._visible=false;
    Texttip._visible=false;
}
ArrowBar.ButtonRight.onRollOver=function(){
	SelectButton("ArrowBar.MovieRight");
	SelectLevel=3;
	ButtonToolTip._visible=false;
    Texttip._visible=false;
}

ArrowBar.ButtonLeft.onRelease=function(){
	fn_arrowBar_buttonLeft();
}
function fn_arrowBar_buttonLeft(){
	if (send_event("normal&&&function||fn_arrowBar_buttonLeft|~|" + this + "||3",false)){
		return;
	}
	ClickLeft("Arrow");
	if(MainLevel == 1){
		StoreLevel = LevelIndexArrow + "~" + IndexShowArrow + "~" + CountArrow + "~" + NumMovie + "~" + ResultDName[RecordIndexD];
		fscommand("SaveIndex", StoreLevel);
		ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultP);
	} else {
		ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultArtist);
	}
}
ArrowBar.ButtonRight.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||3",false)){
		return;
	}

ClickRight("Arrow");
	if(MainLevel==1){
		StoreLevel=LevelIndexArrow+"~"+IndexShowArrow+"~"+CountArrow+"~"+NumMovie+"~"+ResultDName[RecordIndexD];
		fscommand("SaveIndex",StoreLevel);
		ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultP);
	}
	else	ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultArtist);
}
function ShowMovieArtist(Na1, Index, Count, ValPic) {
	if(ValPic[Index].SName=="Album"){
		//DownLoadAlbumImage(Count,Index,"Album",resultAlbum);
		DownLoadAlbumImage(resultAlbum.length,0,"Album",resultAlbum);
	}
	else if(ValPic[Index].SName=="Artist"){
		//DownLoadAlbumImage(Count,Index,"Artist",resultArtist);
		DownLoadAlbumImage(resultArtist.length,0,"Artist",resultArtist);
	}
	var Index1=Index;
	Name = Na1+".Pic";
	Name1 = Na1+".PicFade";
	NameFade = Na1+".Movie";
	eval(Na1)._visible = true;
	PicName.length = 0;
	for (var j = 0; j<NumMovie; j++) {
		if (j<Count) {
			if(MainLevel!=1){
				PicName[j]=ValPic[Index1].ReservePath;
			}
			else PicName[j] = ImgPath[Index1];
			Val1 += 1;
		}
		Index1 += 1;
	}
	Reset(PicName.length);
	DisplayMovieArtistItem(Na1, Index, Count, ValPic);
}
var FirstPlayListShow="true";

function DisplayMovieArtistItem(Na1, Index, Count, ValPic) {
	var ChangeLan1="";
	var bAlbumUnicode=false;
	for (var j = 0; j<NumMovie; j++) {
		if (j<Count) {
			eval(Na1+".Movie"+j)._visible = true;
			eval(Na1+".Pic"+j)._visible = true;
			eval(Na1+".PicFade"+j)._visible = true;
			eval(Na1+".Button"+j)._visible = true;
			eval(Na1+".Year"+j).text="";
			if(IsRegistered=="False")	eval(Na1+".Logo"+j)._visible=true;
			else eval(Na1+".Logo"+j)._visible=false;
			if(FirstPlayListShow=="false"){
				if(PlayListMode=="Album" ||PlayListMode=="Artist"){
					ChangeLan1=ChangeLan;
					if(ChangeLan=="Eng"){
						if (ValPic[Index].Artist=="")bAlbumUnicode=true; else bAlbumUnicode=false;
					}else{
						if (ValPic[Index].uniArtist=="")bAlbumUnicode=false; else bAlbumUnicode=true;
					}
					if(bAlbumUnicode){
						eval(Na1+".Letter"+j).text=ValPic[Index].uniArtist;
					}else{
						eval(Na1+".Letter"+j).text=ValPic[Index].Artist;
					}
//					if(ChangeLan=="Eng")eval(Na1+".Letter"+j).text=ValPic[Index].Artist;
//					else eval(Na1+".Letter"+j).text=ValPic[Index].uniArtist;
					boolLanguageKhmer=(getKhmerCountry(ValPic[Index].Nation)=="1" and ChangeLan<>"Eng")
					if (DisplayAlbumLong=="true"){
						eval(Na1+".Letter"+j).text= (Index+1) +  (boolLanguageKhmer ? ">" : "." )  + eval(Na1+".Letter"+j).text
					}
					
					ChangeAlbumFont(ChangeLan1,j,"false",ValPic[Index].Nation);
					if(PlusCover=="Yes" || DisplayAlbumLong=="true"){
						if(ValPic[Index].Ava=="1")eval(Na1+".CDIcon"+j)._visible=true;
						else eval(Na1+".CDIcon"+j)._visible=false;
					}
					else{
						eval(Na1+".CDIcon"+j)._visible=false;
					}
					if(Grouping=="False")eval(Na1+".Year"+j).text=ValPic[Index].Year;
					
				}
			}
			else {
				ChangeLan1="Eng";
				eval(Na1+".Letter"+j).text = ValPic[Index];
				
				//PlusCover
				eval(Na1+".CDIcon"+j)._visible=false;
			}
			if (AlbumCover == "Yes" || DisplayAlbumLong=="true") {
				eval(Na1+".Year"+j)._visible = true;
				eval(Na1+".Letter"+j)._visible = true;
				eval(Na1+".CoverLetter"+j)._visible = true;
			} else {
				eval(Na1+".Letter"+j)._visible = false;
				eval(Na1+".CoverLetter"+j)._visible = false;
				eval(Na1+".Year"+j)._visible = false;
			}
			eval(Na1+".Num"+j).text = Index+1;
			if (NumCover == "Yes" || DisplayAlbumLong=="true") {
				eval(Na1+".Num"+j)._visible = true;
				eval(Na1+".CoverNum"+j)._visible = true;
				
			} else {
				eval(Na1+".Num"+j)._visible = false;
				eval(Na1+".CoverNum"+j)._visible = false;
			}
			eval(Na1+".ybg"+j)._visible=eval(Na1+".Year"+j).text!="";
			Val1 += 1;
		} else {
			eval(Na1+".Movie"+j)._visible = false;
			eval(Na1+".Pic"+j)._visible = false;
			eval(Na1+".PicFade"+j)._visible = false;
			eval(Na1+".PicFade"+j).unloadMovie();
			eval(Na1+".PicF"+j).unloadMovie();
			eval(Na1+".Button"+j)._visible = false;
			eval(Na1+".Letter"+j)._visible = false;
			eval(Na1+".Year"+j)._visible = false;
			eval(Na1+".CoverLetter"+j)._visible = false;
			eval(Na1+".Num"+j)._visible = false;
			eval(Na1+".CoverNum"+j)._visible = false;
			eval(Na1+".Logo"+j)._visible=false;
			eval(Na1+".CDIcon"+j)._visible=false;
			eval(Na1+".ybg"+j)._visible=false;
		}
		Index += 1;
	}
	if(FirstPlayListShow=="true"){
		ChangeAlbumFont(ChangeLan1,0,FirstPlayListShow);
	}
}
function ClickPlayListByMode(){
	ArtistMode._visible=false;
	ArtistSorted._visible=false;
	eval(TrackName).fileType._visible=	(PlayListMode == "Album");			//only show in Album Mode
	if(BackPlayList1.TextMode.text=="Default"){
			var StName=BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml";
			var Xml=new XML();	
			Xml.load(StName);		
			Xml.onLoad=function(){
				if(Xml.loaded){
					PlayListMode=Xml.childNodes[0].attributes.DisplayMode;
					if(PlayListMode=="TrackTitle"){
						PlayListMode="TrackTitle";
						TopBar.ButtonM.onRollOver();
						LoadTrackByPlayListName(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
						//fscommand("CheckTrackAva",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
						eval(NameAlbum)._visible=false;
						ArrowBar._visible=false;
						BackPlayList1._visible=false;
						MainLevel=4;
						BackPlayList._visible=false;
						//fscommand("VisiblePlayer");
					}
					else if(PlayListMode=="Album"){
						ArrowBar._visible=false;
						BackPlayList1._visible=false;
						PlayListMode="Album";
						MainLevel=3;
						LoadXmlDefineMode(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml","Album");
					}
					else if(PlayListMode=="Artist"){
						ArtistMode._visible=true;
						ArtistSorted._visible=true;
						BackPlayList1._visible=false;
						ArrowBar._visible=true;
						PlayListMode="Artist";
						MainLevel=2;
						LoadXmlDefineMode(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml","Artist");
					}//endif
				}//endif
			}//endloadxml
		}//endif
		else if(PlayListMode=="TrackTitle"){
			PlayListMode="TrackTitle";
			TopBar.ButtonM.onRollOver();
			
			LoadTrackByPlayListName(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
			//fscommand("CheckTrackAva",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
			eval(NameAlbum)._visible=false;
			ArrowBar._visible=false;
			BackPlayList1._visible=false;
			MainLevel=4;
			BackPlayList._visible=false;
			//fscommand("VisiblePlayer");
		}
		else if(PlayListMode=="Album"){
			ArrowBar._visible=false;
			BackPlayList1._visible=false;
			PlayListMode="Album";
			MainLevel=3;
			LoadXmlDefineMode(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml","Album");
		}
		else if(PlayListMode=="Artist"){
			ArtistMode._visible=true;
			ArtistSorted._visible=true;
			BackPlayList1._visible=false;
			//ArrowBar._visible=true;
			PlayListMode="Artist";
			MainLevel=2;
			LoadXmlDefineMode(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml","Artist");
		}
}
//----------------------------------------------------------------------------------------------------
function click_playlist_bar(val_IndexShowP, val_ind){
	if (send_event("normal&&&function||click_playlist_bar|~|" + val_IndexShowP + "|~|" + val_ind + "||3",false)){
		return;
	}
	IndexShowP = int(val_IndexShowP);
	SelectedItem("BackListP", int(val_ind));
	var k = IndexShowP + int(val_ind);
	BackListP._visible = false;
	if(BackPlayList1.TextMode.text == "Default" && MainLevel == 4 && PlayListMode == "TrackTitle" ){
		eval(TrackName)._visible = false;
		VisiblePlay(false);
		BackAlbumPic._visible = false;
		BackListP._visible = false;
		ArrowBar._visible = false;
		VolBar._visible = false;
		RecordIndexP = k;
		ClickPlayListByMode();
	} else if(BackPlayList1.TextMode.text == "Default" && MainLevel == 3 && PlayListMode == "Album" ){
		eval(TrackName)._visible = false;
		VisiblePlay(false);
		BackAlbumPic._visible = false;
		BackListP._visible = false;
		ArrowBar._visible = false;
		VolBar._visible=false;
		RecordIndexP = k;
		ClickPlayListByMode();
	} else if(BackPlayList1.TextMode.text == "Default" && MainLevel == 2 && PlayListMode == "Artist" ){
		eval(TrackName)._visible = false;
		VisiblePlay(false);
		BackAlbumPic._visible = false;
		BackListP._visible = false;
		ArrowBar._visible = false;
		VolBar._visible = false;
		RecordIndexP = k;
		ClickPlayListByMode();
	} else {
		if(MainLevel == 4 && PlayListMode == "TrackTitle"){
			RecordIndexP = k;
			fscommand("SetPlayListName",ResultP[k] + StWave + SlyPath[k]);

			LoadTrackByPlayListName(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[k] + ".xml");
			//fscommand("CheckTrackAva",BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[k]+".xml");
		} else if(MainLevel == 2 && PlayListMode == "Artist"){
			RecordIndexP = k;
			//PlayListMode1="Artist";
			LoadXmlDefineMode(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", "Artist");
		} else if(MainLevel == 3 && PlayListMode == "Album"){
			RecordIndexP = k;
			//PlayListMode1="Album";
			LoadXmlDefineMode(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", "Album");
		} else if(MainLevel == 3 && PlayListMode == "Artist"){
			ShowAlbumBar = "Artist";
			RecordIndexArtist = k;
			if(ArtistMode.Text.text == "Albums In Playlist"){
				GetAlbumByArtist(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", resultArtist[RecordIndexArtist].Artist);
			} else {
				if(resultArtist[RecordIndexArtist].Mode != "External"){
					fscommand("BrowseAlbumByArtist",resultArtist[RecordIndexArtist].Artist + StWave + SplAllCountrys[resultArtist[RecordIndexArtist].Nation].DBPath + StWave + ArtistModeValue + StWave + ArtistSortedValue);
				} else {
					GetAlbumByArtist(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", resultArtist[RecordIndexArtist].Artist);
				}
			}
		} else if(MainLevel == 4 && PlayListMode != "TrackTitle") {
			RecordIndexAlbum = k;
			StoreAlbum = resultAlbum[RecordIndexAlbum].Artist;
			StoreUniAlbum = resultAlbum[RecordIndexAlbum].uniArtist;
			displayEachAlbum();
		}
	}
	TopBar.ButtonM.onRollOver();
}
//----------------------------------------------------------------------------------------------------
function click_backPlaylist(val_IndexShowD,ind){
	if (send_event("normal&&&function||click_backPlaylist|~|" + val_IndexShowD + "|~|" + ind + "||3",false)){
		return;
	}
	IndexShowD = int(val_IndexShowD);
	ind = int(ind);
	BackPlayList._visible = false;
	SelectedItem("BackPlayList.BackListD", ind);
	var k = IndexShowD + ind;
	RecordIndexD = k;
	BackPlayList_visible = false;
	BackPlayList.TextD.text = ResultD[k];
	fscommand("SetPlayListDir", BackPlayList.TextD.text);
	ShowAlbumBar = "";
	FirstPlayListShow = "true";
	LoadPlayList(ResultD[k]);
	TopBar.ButtonM.onRollOver();
	fscommand("StoreNamePath", ResultDName[k]);
}
//----------------------------------------------------------------------------------------------------
function click_each_playlist(val_MainLevel ,val_ind){
	if (send_event("normal&&&function||click_each_playlist|~|" + val_MainLevel + "|~|" + val_ind + "||3",false)){
		return;
	}
	
	MainLevel = int(val_MainLevel);
	val_ind = int(val_ind);
	TopBar.ButtonM.onRollOver();
	if(MainLevel == 1){
		BackPlayList._visible = false;
		MenuMode._visible = false;
		IndexPlayList = val_ind;
		RecordIndexP = IndexShowArrow + IndexPlayList;
		fscommand("SetPlayListName", ResultP[RecordIndexP] + StWave + SlyPath[RecordIndexP]);
		//fscommand("SetImageSlide",SlyPath[RecordIndexP]);
		FirstDisplayP(resultP.length, RecordIndexP);
		ClickPlayListByMode();
	} else if(MainLevel == 3) {
		eval(NameAlbum)._visible = false;
		VolBar._visible = false;
		ShowAlbumBar = "Album";
		
		var spl = resultSearchVol[RecordIndexVol].split(":");
		RecordIndexAlbum = (parseInt(spl[0], 10)-1) + val_ind;
		FirstDisplayP(resultAlbum.length, RecordIndexAlbum);
		StoreAlbum = resultAlbum[RecordIndexAlbum].Artist;
		StoreUniAlbum = resultAlbum[RecordIndexAlbum].uniArtist;
		displayEachAlbum();
		MainLevel = 4;
	} else if(MainLevel == 2) {
		//ArtistMode._visible=false;
		//ArtistSorted._visible=false;
		ShowAlbumBar = "Artist";
		RecordIndexArtist = IndexShowArrow + val_ind;
		//FirstDisplayP(resultArtist.length,RecordIndexArtist);
		
		if(ArtistMode.Text.text == "Albums In Playlist"){
			ArtistMode._visible = false;
			ArtistSorted._visible = false;
			FirstDisplayP(resultArtist.length, RecordIndexArtist);
			GetAlbumByArtist(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", resultArtist[RecordIndexArtist].Artist);
			MainLevel = 3;
		} else {
			//2006-11-27
			if(resultArtist[RecordIndexArtist].Mode != "External"){
				fscommand("BrowseAlbumByArtist",resultArtist[RecordIndexArtist].Artist + StWave + resultArtist[RecordIndexArtist].Nation + StWave + ArtistModeValue + StWave + ArtistSortedValue);
			} else {
				ArtistMode._visible = false;
				ArtistSorted._visible = false;
				FirstDisplayP(resultArtist.length, RecordIndexArtist);
				GetAlbumByArtist(BackPlayList.TextD.text + "\\PlayLists\\" + ResultP[RecordIndexP] + ".xml", resultArtist[RecordIndexArtist].Artist);
				MainLevel = 3;
			}
		}
	}
}