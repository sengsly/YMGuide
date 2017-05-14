ArtistName="ArtistNameBar";
AlbumName="AlbumBar";
GenreName="GenreBar";
var TrackName="ListBar"; //or TrackBar // ListBar;								//Modified
var TrackObj;
var boolWaitForNextDelete=false;
var valueIntervalID;

var ModeTrack="Internal";
var PicFolderName="";
var i_SearchTrackFromArtist=0

function VisibleChar (index1) {
	for (var j=1;j<=LevelChar;j++) {
		eval("CharBar.L"+j)._visible=false;
		eval("CharBar.CL"+j)._visible=false;
	}
	eval("CharBar.L"+index1)._visible=true;
	eval("CharBar.CL"+index1)._visible=true;
}
function VisiblePlay(value) {
	PlayAll._visible = value;
	SearchArtist._visible=value;
	AlbumInfo._visible = value;
	PreAlbum._visible = value;
	NextAlbum._visible = value;
	Cart._visible=value;
	chkVisibleIcon._visible=value;
}
TopBar._visible=false;
function Invisible () {
//	LoadBar._visible=false;
	FirstLoadCountry="false";
	SortMaster._visible=false;
	UpdateDB._visible=false;
	RatingBar._visible=false;
	GenreBar._visible=false;
	BackLetter._visible=false;
	CharBar._visible=false;
	ArtistNameBar._visible=false;
	AlbumBar._visible=false;
	eval(TrackName)._visible=false;
	BackAlbumPic._visible=false;
	BackAlbumInfo._visible=false;
	
	SmallIcon._visible=false;
	BBigIcon._visible=false;
	BigIcon._visible=false;
	SmallIcons._visible=false;
	BBigIcons._visible=false;
	BigIcons._visible=false;
	
	ArrowBar._visible=false;
	VolBar._visible=false;
	VisiblePlay(false);
	//TopBar.Flag.unloadMovie();
	TextTip._visible=false;
	ButtonTip._visible=false;
	for(var j=0;j<NumMovie;j++){
		eval(NameAlbum+".Pic"+j).unloadMovie();
		eval(NameAlbum+".PicFade"+j).unloadMovie();
	}
	resultSearchVol.length=0;
	resultSearchArtistName.length=0;
	resultSearchArtistAlbum.length=0;
	for(var j=0;j<nGenre;j++){
		eval("GenreBar.Pic"+j).unloadMovie();
		eval("GenreBar.PicFade"+j).unloadMovie();
		eval("GenreBar.Text"+j).text="";
	}
	PurchaseCDMode._visible=false;
	TopBar.ButtonM.onRollOver();
}
Invisible ();
function DisplayItemGenre (Obj,Index,Count,nItem) {
	NameC= "GenreBar.Pic";
	Name1C = "GenreBar.PicFade";
	NameFadeC = "GenreBar.Movie";
	PicNameC.length = 0;
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			if(Isregistered=="False")eval(Obj+".Logo"+j)._visible=true;
			else eval(Obj+".Logo"+j)._visible=false;
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;
			eval(Obj+".Cover"+j)._visible=true;
			PicNameC[j]=resultSearchGenre[Index+j].Pic;
		}
		else{
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Pic"+j)._visible=false;
			eval(Obj+".Pic"+j).unloadMovie();
			eval(Obj+".PicFade"+j).unloadMovie();
			eval(Obj+".Text"+j)._visible=false;
			eval(Obj+".Cover"+j)._visible=false;
			eval(Obj+".Logo"+j)._visible=false;
		}
	}
	ResetC(Count);
	DisplayTextGenre(Obj,Index,Count,nItem);
	DeselectedItem(Obj,Index,RecordIndexGenre,nItem);
}
function DisplayTextGenre(Obj,Index,Count,nItem){
	//EDID:2006.05.09 Seng   Error display font in GenreBar/MainLevel 1
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			if(ChangeLan=="Uni"){
				if(resultSearchGenre[Index+j].uniGenre=="")	{
					eval(Obj+".Text"+j).text=resultSearchGenre[Index+j].Genre;
					varUnicode="Eng";
				}else{
					eval(Obj+".Text"+j).text=resultSearchGenre[Index+j].uniGenre;
					varUnicode="Uni";
				}
			}
			else {
				eval(Obj+".Text"+j).text=resultSearchGenre[Index+j].Genre;
				varUnicode="Eng";
			}
			ChangeFontGenreBar(EngFont, UniFont, EngSize, UniSize, varUnicode,resultSearchGenre[Index+j].idLan,j);
		}
	}
}
///............................FUNCTION DISPLAYGENREBAR......................
var RecordIndexGenre=0;
function FirstDisplayGenre(n){
	FirstDisplay("Genre",n,nGenre);
	DisplayItemGenre ("GenreBar",IndexShowGenre,CountGenre,nGenre);
}
//FirstDisplayGenre(7);
GenreBar.ButtonLeft.onRollOver=function(){
	SelectLevel=2;
	SelectButton("GenreBar.MovieLeft");
}
GenreBar.ButtonRight.onRollOver=function(){
	SelectLevel=2;
	SelectButton("GenreBar.MovieRight");
}
GenreBar.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||"+this+ "||0", false)) {
		return;
	}
	
//	Send2Server("client","0&&&Click||"+this,true);
	ClickLeft("Genre");
	DisplayItemGenre ("GenreBar",IndexShowGenre,CountGenre,nGenre);
}
GenreBar.ButtonRight.onRelease=function(){
//	Send2Server("client","0&&&Click||"+this,true);
	if (send_event("normal&&&Click||"+this+ "||0", false)) {
		return;
	}

	ClickRight("Genre");
	DisplayItemGenre ("GenreBar",IndexShowGenre,CountGenre,nGenre);
}
//..............................Add Track By Code ID...........................................
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

var PicXBar=new Array();
var PicYBar=new Array();
var PicXBarAlbum=new Array();
var PicYBarAlbum=new Array();

for (var j = 0; j<nGenre; j++) {
	eval("GenreBar.Button"+j).onRollOver = function() {
		var k=GetNumber(this._name);
		var Index= ((LevelIndexGenre-1)*nGenre)+k;
		var tf = new TextFormat();
		var tmpLan ="";
		
		tf= eval("GenreBar.Text"+GetNumber(this._name)).getTextFormat();
		SelectLevel=2;
		SelectButton("GenreBar.Movie"+GetNumber(this._name));
		popup_tooltip("TextTip:ButtonTip",eval("GenreBar.Text"+GetNumber(this._name)).text);
		if(!TextTip._visible){
			ButtonTip._visible = true;
			ButtonTip._y = 25;
			TextTip._visible = true;
			TextTip._y = 3;
		}

		if (tf.font == "Arial")
			tmpLan="Eng";
		else
			tmpLan="Uni";

		if(DisplayAlbum!="Browse")ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, "Eng");
		else ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, tmpLan);
		ButtonTipChange();
	};
	eval("GenreBar.Button"+j).onRelease = function() {		
		var k=GetNumber(this._name);		
		RecordIndexGenre = ((LevelIndexGenre-1)*nGenre)+k;
		
		Send2Server("client","0&&&function||selectGenreBar|~|"+RecordIndexGenre+"|~|"+RecordLetter,true);		
		selectGenreBar(RecordIndexGenre,RecordLetter);
		tipPos(false);
	};
	PicXBar[j]=eval("GenreBar.Pic"+j)._x;
	PicYBar[j]=eval("GenreBar.Pic"+j)._y;
	PicXBarAlbum[j]=eval("AlbumBar.Pic"+j)._x;
	PicYBarAlbum[j]=eval("AlbumBar.Pic"+j)._y;
}
function selectGenreBar(ind,val_RecordLetter){
	if (send_event("normal&&&function||selectGenreBar|~|"+ ind + "|~|" + val_RecordLetter  + "||0", false)) {
		return;
	}
	ind = Number(ind);
	RecordIndexGenre = ind;
	LevelIndexGenre = int(ind/nGenre)+1;
	SelectedItem("GenreBar",ind%nGenre,nGenre);
	RecordLetter= val_RecordLetter;
	
	if(DisplayAlbum=="Browse"){
		if(BrowseBy=="ReleaseDate"){
			fscommand("ReleaseDate",resultSearchGenre[ind].idGenre);
			StoreYear=resultSearchGenre[ind].idGenre;
			GenreBar._visible=false;
			fscommand("ClickGenre",resultSearchGenre[ind].Genre+"~"+RecordLetter+"~"+BrowseBy);
		}else if(BrowseBy=="Production"){
			//2006.05.15  Seng Remove Backletter from browseby Production 
			GenreBar._visible = false;
			BackLetter._visible = false;
			fscommand("GetAlbumByLabel",resultSearchGenre[ind].idGenre+"~~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
			fscommand("ClickGenre",resultSearchGenre[ind].Genre+"~"+RecordLetter+"~"+BrowseBy);
		}else{
			GenreBar._visible = false;
			eval(NameAlbum)._visible = false;
			BackLetter._visible = true;
			eval("BackLetter.Letter0.Button").onRollOver();
			fscommand("ClickGenre",resultSearchGenre[ind].Genre+"~"+RecordLetter+"~"+BrowseBy);
		}
		OpenSortMaster="false";
		SortMaster._visible=false;
	}
	else{
		Invisible();
		fscommand("LoadNewCountry",resultSearchGenre[ind].Genre);
	}
}
//.....................ENTERFRAME.......................................
function Escape(){

	if(enabled_browse._visible)
	{
		fscommand("CancelBrowse",true);
	}
	else if(WarningUpdate._visible){
		WarningUpdate.ButtonCancel.onRelease();
	}
	else if(UpdateDB._visible){
		UpdateDB.ButtonCancel.onRelease();
	}
	else if(PurchaseCDMode._visible){
		PurchaseCDMode.ButtonClose.onRelease();
	}
	else if(RestoreDB._visible){
		RestoreDB.ButtonCancel.onRelease();
	}
	else if(InputBox._visible){
		InputBox.ButtonCancel.onRelease();
		}
	else if(BackupDB._visible){
		BackupDB.ButtonCancel.onRelease();
	}
	else if(CopyMusic._visible){
		CopyMusic.ButtonCancel.onRelease();
	}
	else if(AddNewScreens._visible){
		AddNewScreens.ButtonCancel.onRelease();
	}
}
//....................Enterframe.
_root.onMouseMove = function(){
	if(mini && mini_out){
		fscommand("hide/show_cmdFull",false);
	}
}
_root.onEnterFrame = function() {
	if (Key.isDown(Key.ESCAPE)) {
		Escape();
	}
	imgFade()
	if(OpenFade=="true"){
		ExecFade ();
	}
}
//.............AddProperty..........................
var SaveAlbumInfo;
GetTrackInfoSearch = "";
function GetValue(){};
_root.addProperty("OpenFrame",_root.GetValue,_root.GetValueOpenFrame);
_root.addProperty("SetAlbumNum",_root.GetValue,_root.GetAlbumNum);
function GetValueOpenFrame(Value){

	if (Value == "true") {
		if (GetGenre.length>0) {
			SplitResultGenre(GetGenre);
			FirstDisplayGenre(resultSearchGenre.length);
			if(BrowseBy=="Production" and DisplayAlbum=="Browse"){
				fscommand("GetAlbumByLabel",resultSearchGenre[0].idGenre+"~~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
			}
			delete(GetGenre);
		}
		else if(SetFocus.length){
			SelectButton(StoreNameSelected);
			if(int(SetFocus)>0){
				PressKey(int(SetFocus));
			}
			delete(SetFocus);
		}
		else if(PassSlidePathValue.length>0){
			Save.Text.text=PassSlidePathValue;
			delete(PassSlidePathValue);
		}
		else if(GetGenre1.length>0){
			
			SplitResultGenre1(GetGenre1);
			
			FirstDisplayGenre(resultSearchGenre.length);
			if (SuiteAction.StoredProcedure=="RequestNextArtist" and SuiteAction.GotoLevels>MainLevel) {
				RecordIndexGenre=SuiteAction.RecordIndexGenre;
				RecordLetter=SuiteAction.RecordLetter;
				selectCharBar(SuiteAction.RecordLetter,true);
			}
			GetGenre1 = "";
			delete(GetGenre1);
		}
		else if(CompleteDownloadScreen.length>0){
			delete(CompleteDownloadScreen);
			AddNewScreens._visible=false;
			AddNewScreens.LoadBar._visible = false;
			Cover._visible=false;


			TopBar.ButtonX.onRollOver();
		}
		else if(ProUpdate.length>0){
			if(CopyMusic._visible){
				Running("CopyMusic.Progess",int(ProUpdate));
				if(int(ProUpDate)>=100){
					CopyMusic._visible=false;
					Cover._visible=false;
					Running("CopyMusic.Progess",0);
					CopyMusic.Progess._visible=false;
					TopBar.ButtonX.onRollOver();
				}
			}
			delete(ProUpdate);
		}
		else if(ShowPurchaseBox.length>0){
			VisibleChecked(ShowPurchaseBox);
			delete(ShowPurchaseBox);
		}
		else if(SortMasterImg.length>0){
			resultSearchGenre[RecordIndexImgPath1].Pic=SortMasterImg;
			DisplayPictrueSortMaster(RecordIndexImgPath1);
			FirstDisplayGenre(resultSearchGenre.length);
			SaveGenre();
			SortMasterImg="";
			delete(SortMasterImg);
		}
		else if (DatabasePath.length>0) {
			if(UpdateDB._visible)UpdateDB.Text.text = DatabasePath;
			else if(BackUpDB._visible)BackUpDB.Path.text=DatabasePath;
			else if(RestoreDB._visible)RestoreDB.Path.text=DatabasePath;
			else if(CopyMusic._visible)CopyMusic.Text1.text=DatabasePath;
			delete(DatabasePath);
			UpdateDB.loadbar._visible=false;
		}
		else if(CopyMusicDes.length>0){
			CopyMusic.Text2.text=CopyMusicDes;
			delete(CopyMusicDes);
		}
		else if(GetYears.length>0){
			SplitResultGenre(GetYears);
			FirstDisplayGenre(resultSearchGenre.length);
			delete(GetYears);
		}
		else if(GetYearsRefresh.length>0){
			SplitResultGenre(GetYearsRefresh,"true");
			FirstDisplayGenre(resultSearchGenre.length);
			delete(GetYearsRefresh)
		}
		else if (GetArtistNameStore.length>0) {
			CharBar._visible=false;
			Backletter._visible=false;
			MainLevel=2;
			ArrowBar._visible=true;
			SplitResultArtistName(GetArtistNameStore, "");
			var ArtistLength=resultSearchArtistName.length;
			resultSearchArrow.length=0;
			resultSearchArrow=SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
			//FirstDisplayVol(resultSearchVol.length);
			VolBarArrow(resultSearchArrow.length,"ArrowBar");
			FirstDisplay("Arrow",resultSearchArrow.length,nVol);
			IndexShowArrow=StoreIndexShowArrow;
			CountArrow=StoreCountArrow;
			LevelIndexArrow=StoreLevelIndexArrow;
			if(resultSearchArrow[IndexShowArrow+CountArrow-1].length<=0)FirstDisplay("Arrow",resultSearchArrow.length,nVol);
			DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
			eval("ArrowBar.Button"+SaveIndexNameArrow).onRelease();
			//eval(NameAlbum+".Button0").onRollOver();
			TopBar.ButtonM.onRollOver();
			Browse_mc._visible = false; enabled_browse._visible=false;//123		
			delete(GetArtistNameStore);
		}
		else if(ResultAlbumName.length>0){
			SplitResultArtistName(ResultAlbumName,"Yes",StoreAlbumByIndex);
			if(ShowAlbumPic=="Yes"){
				ShowMovieArtist(NameAlbum, StoreAlbumByIndex, StoreAlbumByCount, resultSearchArtistAlbum);
				requestAlbumAvailable(StoreAlbumByIndex,StoreAlbumByCount);
			}
			else if(ShowAlbumPic=="AlbumBar"){
				ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
			}
			else{
				StoreAlbum=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
				StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
				DisplayToolTipAlbum();
				ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
				fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
			}
			delete(ShowAlbumPic);
			delete(ResultAlbumName);
//			LoadingAlbum=0;
		}
		else if (GetArtistAlbumStore.length>0) {
/*			if(SuiteAction.StoredProcedure=="RequestNextArtist"){
				SaveIndexName=int(SuiteAction.AlbumIndex / NumMovie)
			}
*/			
			if(GetArtistAlbumStore=="Non"){
				MainLevel=3;
				CharBar._visible=false;
				ArtistNameBar._visible=false;
				ArrowBar._visible=false;
				VolBar._visible=false;
				eval(NameAlbum)._visible=false;
				delete(GetArtistAlbumStore);
				resultSearchArtistAlbum.length=0;
			}
			else{
				CharBar._visible=false;
				ArtistNameBar._visible=false;
				MainLevel=3;
				ArrowBar._visible=false;
				VolBar._visible=true;
				resultSearchVol.length=0;
				resultSearchVol=SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
				//resultSearchArtistAlbum = SplitResultArtistName(GetArtistAlbumStore, "Artist");
				resultSearchArtistAlbum.length=0;
				resultSearchArtistAlbum.length=parseInt(ArtistLength, 10);
				VolBarArrow(resultSearchVol.length,"VolBar");
				FirstDisplay("Vol",resultSearchVol.length,nVol);
				IndexShowVol=SaveIndexShowVol;
				CountVol=SaveCountVol;
				LevelIndexVol=SaveLevelIndexVol;
				if(resultSearchVol[IndexShowVol+CountVol-1].length<=0)FirstDisplay("Vol",resultSearchVol.length,nVol);
				DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
				if(SuiteAction.StoredProcedure=="RequestNextArtist"){
					SaveIndexName=int(SuiteAction.AlbumIndex / NumMovie)
					selectVolBar(SaveIndexName,true);
				}else{
					selectVolBar(SaveIndexName+(LevelIndexVol-1)*nVol);

				}					
				//eval(NameAlbum+".Button0").onRollOver();
				TopBar.ButtonM.onRollOver();
				Browse_mc._visible = false; enabled_browse._visible=false;//123
				delete(GetArtistAlbumStore);
			}
			fscommand("ValuePlayer",MainLevel);
		}
		else if (GetArtistName.length>0) {
			if(GetArtistName!="Non"){
				//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
				if(databaseType==1 or databaseType==2){
					//Movie and TVSeries
					resultSearchArtistName=SplitResultTVSeries(GetArtistName);
				}else{
					//Music and Karaoke
					SplitResultArtistName(GetArtistName, "");
				}
			}else{
				resultSearchArtistName.length=0;
			}
			CharBar._visible=false;
			MainLevel=2;
			ArrowBar._visible=true;
			var ArtistLength=resultSearchArtistName.length;
			resultSearchArrow=SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
			/*
			if(GetMyFavXml.length>0){
				var Strspl=GetMyFavXml.split("~");
				if(Strspl[4]==AvaValue && int(Strspl[5])==NumMovie){
					VolBarArrow(resultSearchArrow.length,"ArrowBar");
					FirstDisplay("Arrow",resultSearchArrow.length,nVol);
					IndexShowArrow=int(Strspl[0]);
					CountArrow=int(Strspl[1]);
					LevelIndexArrow=int(Strspl[2]);
					SaveIndexNameArrow=int(Strspl[3]);
					DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
					eval("ArrowBar.Button"+SaveIndexNameArrow).onRelease();
				}
				else{
					FirstDisplayArrow(resultSearchArrow.length);
					ArrowBar.Button0.onRelease();
				}
				delete(GetMyFavXml);
			}
			else{
				FirstDisplayArrow(resultSearchArrow.length);
				if(SuiteAction.StoredProcedure!="RequestNextArtist"){
					ArrowBar.Button0.onRelease();
				}
				TopBar.ButtonM.onRollOver();
			}
			*/
				FirstDisplayArrow(resultSearchArrow.length);
				if(SuiteAction.StoredProcedure!="RequestNextArtist"){
					ArrowBar.Button0.onRelease();
				}
				TopBar.ButtonM.onRollOver();
			
				delete(GetArtistName);
			
			if(SuiteAction.StoredProcedure=="RequestNextArtist"){
				if(SuiteAction.GotoLevels==MainLevel){
					SuiteAction.StoredProcedure="";
					selectArrowBar(int(SuiteAction.ArtistIndex / NumMovie),true);
					
				}else if(SuiteAction.GotoLevels>MainLevel){
					selectNameAlbum(SuiteAction.ArtistIndex,int(SuiteAction.ArtistIndex / NumMovie),true);
				}
			}
			Browse_mc._visible = false; enabled_browse._visible=false;//123	
		}
		else if (GetArtistAlbum.length>0) {
			MainLevel=3;
			CharBar._visible=false;
			BackLetter._visible=false;
			ArtistNameBar._visible=false;
			ArrowBar._visible=false;
			VolBar._visible=false;
			if(GetArtistAlbum=="Non"){
				eval(NameAlbum)._visible=false;
				resultSearchArtistAlbum.length=0;
				TopBar.ButtonM.onRollOver();	//when there is no album found then select the button menu
			}
			else{
				VolBar._visible=true;
				resultSearchVol.length=0;
				resultSearchVol=SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
				resultSearchArtistAlbum.length=0;
				resultSearchArtistAlbum.length=parseInt(ArtistLength, 10);
				if(GetMyFavXml.length>0){
					var Strspl=GetMyFavXml.split("~");
					if(Strspl[4]==AvaValue && int(Strspl[5])==NumMovie){
						VolBarArrow(resultSearchVol.length,"VolBar");
						FirstDisplay("Vol",resultSearchVol.length,nVol);
						IndexShowVol=int(Strspl[0]);
						CountVol=int(Strspl[1]);
						LevelIndexVol=int(Strspl[2]);
						SaveIndexName=int(Strspl[3]);
						if (SaveIndexName>=resultSearchVol.length){
							SaveIndexName=0;
							IndexShowVol=0;
							LevelIndexVol=0;
						}
						DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
						eval("VolBar.Button"+SaveIndexName).onRelease();
					}
					else{
						FirstDisplayVol(resultSearchVol.length);
						VolBar.Button0.onRelease();
					}
					delete(GetMyFavXml);
				}
				else{
					FirstDisplayVol(resultSearchVol.length);
					if(SuiteAction.StoredProcedure!="RequestNextArtist"){
						VolBar.Button0.onRelease();
					}
				}
				TopBar.ButtonM.onRollOver();
			}
			fscommand("ValuePlayer",MainLevel);
			if(SuiteAction.StoredProcedure=="RequestNextArtist" and SuiteAction.GotoLevels>=MainLevel){
				if(SuiteAction.GotoLevels==MainLevel){
					SuiteAction.StoredProcedure="";
				}
				SaveIndexName=int(SuiteAction.AlbumIndex / NumMovie);
				if(BrowseBy!="Production"){
					selectVolBar(int(SuiteAction.AlbumIndex / NumMovie),true);
				}
			}
			delete(GetArtistAlbum);
		}else if (GetArtistTrackInfo!=undefined) {
		
			ReloadTrackPage();

			ArtistNameBar._visible = false;
			eval(NameAlbum)._visible = false;
			MainLevel = 4;
			VolBar._visible=false;
			BrowsingAlbumID=resultSearchArtistAlbum[RecordIndexArtistAlbum].id;
			
			SplitResultTrack(GetArtistTrackInfo);
			FirstDisplayTrack(resultSearchTrack.length);
			eval(TrackName).PathChapter.setState(false);			//clear browse path state
			eval(TrackName).MainTitle.text.text		= 	(GetMainTItle)					//Show Main Title Number EDID:2005.11.02
			eval(TrackName).fileType.AvailableType	=	PlayFileFrom
			eval(TrackName).fileType.setfileType(eval(TrackName).fileType.searchForDefault())					//Show large medium small
			eval(TrackName).CoverArtType.setfileType(CoverType);
			eval(TrackName).DTS.Available=(resultSearchArtistAlbum[RecordIndexArtistAlbum].AudioID.indexOf(";3;")>=0);
    			eval(TrackName).DD.Available  =(resultSearchArtistAlbum[RecordIndexArtistAlbum].AudioID.indexOf(";1;")>=0);
			eval(TrackName).PlusIcon.Available=(resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav=="1");
//			eval(TrackName).PlayTrailer._visible 	= 	(GetTrailerAvailable==1)			//Show play trailer button
			chkVisibleIcon.Selected._visible=Boolean(boolShowCoverIcon);
			VisibleInfo(true);
			fscommand("VisiblePlayer");
			if(FirstLoadDisplayAlbum==false)FirstDisplayAlbum(resultSearchArtistAlbum.length);
			
			if (clientType == serverMode){
				fscommand("server","0&&&Variable||client_receive|~|true" );
			}
			var stringIDs= new Array();
			for(var i=0;i<resultSearchTrack.length;i++){stringIDs.push(resultSearchTrack[i].trackID);}
			//if(clientType<>serverMode){
				fscommand("clients","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
			//}else{
				fscommand("servers","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
			//}
			if(eval(TrackName).Button0._visible){
				eval(TrackName).Button0.onRollOver();
			}else{
				TopBar.ButtonM.onRollOver();
			}
			delete(GetArtistTrackInfo);
			delete(stringIDs);
		} else if (GetArtistAlbumInfo.length>0) {
			SaveAlbumInfo=GetArtistAlbumInfo;
			ChangeAlbumInfoFont(EngFont, UniFont, EngSize, UniSize, ChangeLan, GetArtistAlbumInfo,resultSearchArtistAlbum[RecordIndexArtistAlbum].idLan);
			GetArtistAlbumInfo = "";
			delete(GetArtistAlbumInfo);
		}
		else if(ChangeBrowseBy.length>0){
			Invisible ();
			RefreshBrowse();
			ChangeBrowseBy="";
			ChangeColorSubMenus();
			delete(ChangeBrowseBy);
		}
		else if(ChangeBrowseByOption.length>0){
			if(DisplayAlbum=="Browse"){
				if(BrowseBy=="Genre")MenuBrowse.Genre.Button.onRelease();
				else if(BrowseBy=="Production")MenuBrowse.Production.Button.onRelease();
				else if(BrowseBy=="Rating")MenuBrowse.Rating.Button.onRelease();
				else if(BrowseBy=="Alphabet")MenuBrowse.Alphabet.Button.onRelease();
				else MenuBrowse.ReleaseDate.Button.onRelease();
			}
			else if(DisplayAlbum=="MyFavAlbum")MenuBrowse.FavAlbum.Button.onRelease();
			else if(DisplayAlbum=="MyFavArtist")MenuBrowse.FavArtist.Button.onRelease();
			else if(DisplayAlbum=="MyAlbum")MenuBrowse.MyAlbum.Button.onRelease();
			delete(ChangeBrowseByOption);
		}
		else if(ChangeSorted.length>0){
            //ChangeSorted
			if(DisplayAlbum=="Browse"){
				if(BrowseBy=="Genre"){
					if(ChangeSorted=="0")MenuSorted.DateSorted.Button.onRelease();
					else MenuSorted.NameSorted.Button.onRelease();
				}
				else if(BrowseBy=="Production"){
					if(ChangeSorted=="0")MenuSorted1.DateSorted.Button.onRelease();
					else MenuSorted1.NameSorted.Button.onRelease();
				}
				else if(BrowseBy=="ReleaseDate"){
					if(ChangeSorted=="0")MenuSortedReleaseDate.DateSorted.Button.onRelease();
					else MenuSortedReleaseDate.NameSorted.Button.onRelease();
				}
			}
			else if(DisplayAlbum=="MyFavAlbum"){
				if(ChangeSorted=="ReleaseDate")MenuFavAlbum.Production.Button.onRelease();
				else if(ChangeSorted=="MyFavorite")MenuFavAlbum.Genre.Button.onRelease();
				else if(ChangeSorted=="Rating")MenuFavAlbum.Rating.Button.onRelease();
				else if(ChangeSorted=="Rank")MenuFavAlbum.Rank.Button.onRelease();
			}
			else if(DisplayAlbum=="MyFavArtist"){
				if(ChangeSorted=="ReleaseDate")MenuFavArtist.Production.Button.onRelease();
				else if(ChangeSorted=="MyFavorite")MenuFavArtist.Genre.Button.onRelease();
				else if(ChangeSorted=="Rank")MenuFavArtist.Rating.Button.onRelease();
			}
			else if(DisplayAlbum=="MyAlbum"){
				if(ChangeSorted=="ReleaseDate")MenuMyAlbum.Production.Button.onRelease();
				else if(ChangeSorted=="MyFavorite")MenuMyAlbum.Genre.Button.onRelease();
				else if(ChangeSorted=="Rating")MenuMyAlbum.Rating.Button.onRelease();
				else if(ChangeSorted=="Rank")MenuMyAlbum.Rank.Button.onRelease();
			}
			delete(ChangeSorted);
		}
		else if(FreshXml.length>0){
			LoadXmlLanguage(getSplitSt);
			delete(FreshXml);
		}
		else if(getSplitSt.length>0){
			SplAllCountrys.length=0;
			SplAllNames.length=0;
			var st=StAllCountrys.split("%%");
			for(var j=0;j<st.length;j++){
				var st1=st[j].split("%");
				SplAllCountrys[j]=st1[0];
				SplAllNames[j]=st1[1];
			}
			LoadXmlLanguage(getSplitSt);
			delete(getSplitSt);
			if(parseInt(UnLoadIndex,10)>0){
				fscommand("UnloadSwf",UnLoadIndex);
			}
		}
		else if(SetAlbumCover.length>0){
			if(SetAlbumCover=="1"){
				DisplayArtistNameItem("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
				DisplayArtistNameItem("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
			}
			if(MainLevel==3 || MainLevel==4 ){
				DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
			}
			else if(MainLevel==2){
				DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
			}
			SetAlbumCover="";
			delete(SetAlbumCover);
		}
		else if(RefreshTrackInfo.length>0){
			if(MainLevel==4){
				DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			}
			delete(RefreshTrackInfo);
		}
		else if(SetTrackPos.length>0){
			if(MainLevel==4){
				FirstDisplayTrack(resultSearchTrack.length);
			}
			SetTrackPos="";
			delete(SetTrackPos);
		}
		else if(SetEngUniFont.length){
			if(MainLevel==3 || MainLevel==4 ){
				DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
			}
			else if(MainLevel==2){
				//DisplayMovieArtistItem(NameAlbum, IndexShowArrow, CountArrow, resultSearchArtistName);
				DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
			}
			DisplayArtistNameItem("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			ChangeAlbumInfoFont(EngFont, UniFont, EngSize, UniSize, ChangeLan, SaveAlbumInfo,resultSearchArtistAlbum[RecordIndexArtistAlbum].idLan);
			DisplayTextGenre ("GenreBar",IndexShowGenre,CountGenre,nGenre);
			SetFontColor(FontColor);
			SetEngUniFont="";
			delete(SetEngUniFont);
		}
		else if(openCover.length>0){
			TopBar.ButtonX.onRollOver();
			Cover._visible=false;
			openCover="";
			delete(openCover);
		}
		
		else if(SetNewColorBar.length>0){
			ChangeColorBar(SetNewColorBar);
			SetNewColorBar="";
			delete(SetNewColorBar);
		}
		else if(SetNewColorRating.length>0){
			ColorRating=SetNewColorRating;
			if(MainLevel==4){
				DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			}
			delete(SetNewColorRating);
		}
		else if(SetNewBgColor.length>0){
			ChangeColorNoAlpha("Bg", BgColorValue);
			ChangeColorAndAlpha(SetColorValue, ButtonAlpha);
			SetFontColor(FontColor);
			SetNewBgColor="";
			changeColorButton();	// change colo mini player
			delete(SetNewBgColor);
			if(MainLevel==4){
				DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			}
		}
		else if(ChangeLanguage.length){
			ChangeLan=ChangeLanguage;
			ChangeUnicode();
			delete(ChangeLanguage);
		}
		else if(UnloadEx.length>0){
			fscommand("UnloadSwf",UnloadEx);
			UnloadEx="";
			delete(UnloadEx);
		}
		else if(ShowLoading.length>0){
			var spl=ShowLoading.split("%~%");
//			if(!LoadBar._visible)LoadBar._visible = true;
			LoadBar.showProgressBar();
			LoadBar.txt.text="Downloading... "+ spl[0]+ " cover arts"
			delete(ShowLoading);
		}
		else if(RefreshPicAlbum.length>0){			
			resultSearchArtistAlbum[IndexAlbumForDownLoad].ReservePath=resultSearchArtistAlbum[IndexAlbumForDownLoad].Path;
			var index=IndexAlbumForDownLoad%NumMovie
			if(StoreIndexVol1+index==IndexAlbumForDownLoad){
				if(eval(NameAlbum+".Pic"+Index)._alpha<=0){
					eval(NameAlbum+".PicFade"+Index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
				}else{
					eval(NameAlbum+".Pic"+Index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
				}
			}
			var index=IndexAlbumForDownLoad%nAlbum;
			if(FadeTrueBar){
				eval("AlbumBar"+".PicFade"+index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
			}else{
				eval("AlbumBar"+".Pic"+index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
			}
			
			delete(IndexAlbumForDownLoad);
			DisplayAlbumPictrueInfo();
			delete(RefreshPicAlbum);
		}
		else if(RefreshPicAlbumRip.length>0){
			if(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path==RefreshPicAlbumRip){
				resultSearchArtistAlbum[IndexAlbumForDownLoad].ReservePath=resultSearchArtistAlbum[IndexAlbumForDownLoad].Path;
				var index=IndexAlbumForDownLoad%NumMovie
				if(StoreIndexVol1+index==IndexAlbumForDownLoad){
					if(eval(NameAlbum+".Pic"+Index)._alpha<=0){
						eval(NameAlbum+".PicFade"+Index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
					}else{
						eval(NameAlbum+".Pic"+Index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
					}
				}
				var index=IndexAlbumForDownLoad%nAlbum;
				if(FadeTrueBar){
					eval("AlbumBar"+".PicFade"+index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path)
				}else{
					eval("AlbumBar"+".Pic"+index).loadMovie(resultSearchArtistAlbum[IndexAlbumForDownLoad].Path);
				}
				DisplayAlbumPictrueInfo();
			}
			delete(IndexAlbumForDownLoad);
			delete(RefreshPicAlbumRip);
		}
		else if(RefreshInvisible.length>0){
			Invisible ();
			RefreshInvisible=""
			delete(RefreshInvisible);
		}
		else if(ShowLogo.length>0){
			if(Isregistered=="False")VisibleSlyIcon(true);
			delete(ShowLogo);
		}
		else if(SetHideMouse.length>0){
			HideMouse=SetHideMouse;
			if(HideMouse=="true"){
				Mouse.hide();
			}
			else {
				Mouse.show();
			}
			delete(SetHideMouse);
		}
		else if(RefreshGrouping.length>0){
			if(MainLevel==3){
				var splTemp=StoreReloadGroup.split("&&&");
				fscommand(splTemp[0],splTemp[1]);
			}
			delete(RefreshGrouping);
		}
	}else
	{
		Browse_mc._visible = false; enabled_browse._visible = false;
	}
}
//..........................................LETTER ACTION SCRIPT...................
var nLetter = 28;
var Letters = new Array();
Letters[0] = "#";
for (var j = 1; j<nLetter; j++) {
	Letters[j] = chr(65+(j-1));
}
Letters[27]="All";
function ChangeFontLetter(EngFont1) {
	for (var j = 0; j<nLetter; j++) {
		eval("BackLetter.Letter"+j+".Text").text = Letters[j];
	}
}
var RecordLetter = "All";
var RecordLetterMove="";
BackLetter.BackAll.ButtonAll.onRollOver= function() {
	SelectButton("BackLetter.BackAll.MovieAll");
}
BackLetter.BackAll.ButtonAll.onRelease = function() {
	Send2Server("client","0&&&Click||"+this,true);
	selectCharBar("All");
	tipPos(false);
}
for (var j = 0; j<nLetter; j++) {
	eval("BackLetter.Letter"+j+".Button").onRollOver = function() {
		SelectLevel=3;
		SelectButton(this._parent+".Movie");
		RecordLetterMove = eval((this._parent+".Text")).text;
	};
	eval("BackLetter.Letter"+j+".Button").onRelease = function() {
		Send2Server("client","0&&&Click||"+this,true);
		RecordLetter = eval((this._parent+".Text")).text;
		selectCharBar(RecordLetter);
		tipPos(false);
	};
}
function BrowseAlbum (browseLetter) {
	
	RecordLetter = browseLetter;
	GenreBar._visible=false;
	RatingBar._visible=false;
	BackLetter._visible = false;
	if(BrowseBy=="Genre"){
	   	fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue);
		MainLevel = 2;
		fscommand("SaveLetter",RecordLetter+"~"+BrowseBy);
	}
	else if(BrowseBy=="Artist"){
		fscommand("GetAlbumByLetter", RecordLetter+"~"+SortedValue+"~"+AvaValue);
		MainLevel=3;
	}
	else if(BrowseBy=="Production"){
		fscommand("GetAlbumByLabel",resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
		MainLevel=3;
		fscommand("SaveLetter",RecordLetter+"~"+BrowseBy);
	}
	else if(BrowseBy=="Rating"){
		fscommand("GetAlbumByRating",RatingValue+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue);
		MainLevel=3;
	}
	TopBar.ButtonM.onRollOver();
}

//...............................CHARBAR.....................................
function DisplayItemChar (Obj,Index,Count,nItem) {
	VisibleChar (LevelIndexChar)
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=false;
			eval(Obj+".Text"+j).text=Letters[Index+j];
		}
		else{
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
		}
	}
}
function FirstDisplayChar(n){
	FirstDisplay("Char",n,nChar);	
	DisplayItemChar ("CharBar",IndexShowChar,CountChar,nChar);
}
FirstDisplayChar(Letters.length);
CharBar.ButtonLeft.onRollOver=function(){
	SelectButton("CharBar.MovieLeft");
	SelectLevel=2;
}
CharBar.ButtonRight.onRollOver=function(){
	SelectButton("CharBar.MovieRight");
	SelectLevel=2;
}

CharBar.ButtonLeft.onRelease=function(){
//	Send2Server("client","0&&&Click||"+this,true);
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		return;
	}
	ClickLeft("Char");
	DisplayItemChar ("CharBar",IndexShowChar,CountChar,nChar);
}
CharBar.ButtonRight.onRelease=function(){
	//Send2Server("client","0&&&Click||"+this,true);
		if(send_event("normal&&&Click||"+ this + "||0",false)){
		return;
	}
	ClickRight("Char");
	DisplayItemChar ("CharBar",IndexShowChar,CountChar,nChar);
}
for (var j = 0; j<nChar; j++) {
	eval("CharBar.Button"+j).onRollOver = function() {
		SelectButton("CharBar.Movie"+GetNumber(this._name));
		SelectLevel=2;
	};
	eval("CharBar.Button"+j).onRelease = function() {
	   var charLetter=eval("CharBar.Text"+GetNumber(this._name)).text;
		Send2Server("client","0&&&function||selectCharBar|~|"+charLetter,true);
		selectCharBar(charLetter);
		tipPos(false);
	};
}
function selectCharBar(val_RecordLetter,noSend){
	if(!noSend){
		if (send_event("normal&&&function||selectCharBar|~|" + val_RecordLetter  + "||0", false)) {
			return;
		}
	}

	RecordLetter = val_RecordLetter;
	GenreBar._visible=false;
	RatingBar._visible=false;
	BackLetter._visible = false;
	if(BrowseBy=="Genre"){
		//Seng 2005-09-08 Browse Album By Gerne
		//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
		if(databaseType==1 or databaseType==2){
			//Movie and TVSeries
	  		fscommand("AlbumByGenre" , resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}else{
			//Music and Karaoke
	  		fscommand("GetArtistName", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		}
		
//		fscommand("AlbumByGenre", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue+"~"+SortedValue);
		fscommand("SaveLetter",RecordLetter+"~"+BrowseBy);
	}
	else if(BrowseBy=="Artist"){
		fscommand("GetAlbumByLetter", RecordLetter+"~"+SortedValue+"~"+AvaValue);
	}
	else if(BrowseBy=="Production"){
		
		fscommand("GetAlbumByLabel",resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");
		fscommand("SaveLetter",RecordLetter+"~"+BrowseBy);
	}
	else if(BrowseBy=="Rating"){
		fscommand("GetAlbumByRating",RatingValue+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue);
	}
	TopBar.ButtonM.onRollOver();
}
//............................SHOWMOVIEALBUM..........................
function FirstDisplayArrow(n){
	VolBarArrow(n,"ArrowBar")
	FirstDisplay("Arrow",n,nVol);
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
}
ArrowBar.ButtonLeft.onRollOver=function(){	
	SelectButton("ArrowBar.MovieLeft");
	SelectLevel=4;
}
ArrowBar.ButtonRight.onRollOver=function(){
	SelectButton("ArrowBar.MovieRight");
	SelectLevel=4;
}

ArrowBar.ButtonLeft.onRelease=function(){	
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		return;
	}
	ClickLeft("Arrow");
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);

}
ArrowBar.ButtonRight.onRelease=function(){
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		return;
	}
	ClickRight("Arrow");
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
}
//.........
ArrowBar.ButtonArrowLeft.onRollOver=function(){
	TextTip._visible = false;
	ButtonTip._visible = false;
	SelectButton("ArrowBar.MovieArrowLeft");
	SelectLevel=4;
}
ArrowBar.ButtonArrowRight.onRollOver=function(){
	SelectButton("ArrowBar.MovieArrowRight");
	SelectLevel=4;
	TextTip._visible = false;
	ButtonTip._visible = false;
}
ArrowBar.ButtonArrowLeft.onRelease=function(){
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
	var Index=IndexNameArrow-1;
	if(Index>=0){
		eval("ArrowBar.Button"+Index).onRelease();
	}
	else{
		if(ArrowBar.ButtonLeft._visible){
			ArrowBar.ButtonLeft.onRelease();
			eval("ArrowBar.Button"+(CountArrow-1)).onRelease();
		}
		else eval("ArrowBar.Button"+(CountArrow-1)).onRelease();
	}
}
ArrowBar.ButtonArrowRight.onRelease=function(){
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
	var Index=IndexNameArrow+1;
	if(Index<nVol){
		if(eval("ArrowBar.Button"+Index)._visible){
			eval("ArrowBar.Button"+Index).onRelease();
		}
		else{

			if(ArrowBar.ButtonRight._visible){
				ArrowBar.ButtonRight.onRelease();
				eval("ArrowBar.Button"+0).onRelease();
			}
			else{
				eval("ArrowBar.Button"+0).onRelease();
			}
		}
	}
	else{
		if(ArrowBar.ButtonRight._visible){
			ArrowBar.ButtonRight.onRelease();
			eval("ArrowBar.Button"+0).onRelease();
		}
		else{
			eval("ArrowBar.Button"+0).onRelease();
		}
	}
}


//.........
function ShowMovieArtist(Na1, Index, Count, ValPic) {
	
	var Index1=Index;
	Name = Na1+".Pic";
	Name1 = Na1+".Picfade";
	NameFade = Na1+".Movie";
	eval(Na1)._visible = true;
	PicName.length = 0;
	for (var j = 0; j<NumMovie; j++) {
		if (j<Count) {
			PicName[j] = ValPic[Index1].ReservePath;
			Val1 += 1;
		} 
		Index1 += 1;
	}
	Reset(PicName.length);
	DisplayMovieArtistItem(Na1, Index, Count, ValPic);
}
function DisplayMovieArtistItem(Na1, Index, Count, ValPic) {
	var b = false;
	var varUnicode;
	switch (DisplayAlbum){
		case "Browse" :
			if((BrowseBy == "ReleaseDate" || ((BrowseBy == "Production" || BrowseBy == "Genre") && SortedValue != 1)) && MainLevel == 3){
				b = true;
			}
			break; 
		case "MyFavAlbum" :
			if(MyFavAlbum == "ReleaseDate") b = true;
			break;
		case "MyFavArtist" :
			if(MyFavArtist == "ReleaseDate") b = true;
			break;
		case "MyAlbum" :
			if(MyAlbum == "ReleaseDate") b = true;
			break;
	}
	for (var j = 0; j < NumMovie; j++) {
		var objFlag=eval(Na1+".FlagGroup"+j);
		var objDTS=eval(Na1+".DTS"+j);
		if (Index < ValPic.length) {
			eval(Na1 + ".Movie" + j)._visible = true;
			eval(Na1 + ".Pic" + j)._visible = true;
			eval(Na1 + ".PicFade" + j)._visible = true;
			eval(Na1 + ".Button" + j)._visible = true;

			
			if(Isregistered == "False"){
				eval(Na1 + ".Logo" + j)._visible = true;
			} else{
				eval(Na1 + ".Logo" + j)._visible = false;
			}
			//DD = 1  PCM = 2	DTS = 3
			
			if(PlusCover == "Yes" || DisplayAlbumLong == "true"){
				eval(Na1 + ".Plus" + j)._visible = true;
				eval(Na1 + ".Rank" + j + ".Text").text = ValPic[Index].Rank;
				
				if(ValPic[Index].MyFav == "1"){
					eval(Na1 + ".Rank" + j)._visible = true;
					eval(Na1 + ".Plus" + j + ".Selected")._visible = true;
				} else {
					eval(Na1 + ".Rank" + j)._visible = false;
					eval(Na1 + ".Plus" + j + ".Selected")._visible = false;
				}
				if(MainLevel != 2){			//In album page
					album_status(eval(Na1 + ".CDIcon" + j),ValPic[Index].Ava);
				} else {
					eval(Na1+".CDIcon"+j)._visible = false;
				}				
			} else {
				eval(Na1 + ".Plus" + j)._visible = false;
				eval(Na1 + ".Rank" + j)._visible = false;
				eval(Na1 + ".CDIcon" + j)._visible = false;
			}
			boolLanguageKhmer = false;
			if(StringsubList=="actor"){
				SubDisplayName=ValPic[Index].Actor;
			}else if(StringsubList=="director"){
				SubDisplayName=ValPic[Index].Director;
			}else{//in artist mode
				SubDisplayName=ValPic[Index].ArtistName;
			}
			if (ChangeLan == "Eng") {
				eval(Na1 + ".Letter" + j).text = ValPic[Index].Artist;
				eval(Na1 + ".Artist" + j).text = SubDisplayName;
				varUnicode="Eng";
			} else {
				if(ValPic[Index].uniArtist == ""){
					eval(Na1 + ".Letter" + j).text = ValPic[Index].Artist;
					eval(Na1 + ".Artist" + j).text = SubDisplayName;
					varUnicode="Eng";
				} else {
					boolLanguageKhmer = (iKhmer == "1");
					eval(Na1 + ".Letter" + j).text = ValPic[Index].uniArtist;
					eval(Na1 + ".Artist" + j).text = ValPic[Index].unicodeArtistName;
					varUnicode="Uni";
				}
			}
			if (DisplayAlbumLong == "true"){
				eval(Na1 + ".Letter" + j).text = (Index+1) +  (boolLanguageKhmer ? ">" : "." )  + eval(Na1 + ".Letter" + j).text
			}
			ChangeAlbumFont(EngFont, UniFont, EngSize, UniSize, varUnicode,ValPic[Index].idLan,j);
			if (AlbumCover == "Yes" || DisplayAlbumLong == "true") {
				eval(Na1 + ".Year" + j).text = ValPic[Index].Year;
				eval(Na1 + ".Year" + j)._visible = b;
				eval(Na1 + ".ybg" + j)._visible = b;
				
				eval(Na1 + ".Letter" +j )._visible = true;
				eval(Na1 + ".CoverLetter" + j)._visible = true;
				if(MainLevel!=2){
					eval(Na1 + ".Artist" + j)._visible=true;
				} else {
					eval(Na1 + ".Artist" + j)._visible=false;
				}
			} else {
				eval(Na1 + ".Year" + j)._visible = false;
				eval(Na1 + ".ybg" + j)._visible =  false;
				eval(Na1 + ".Letter" + j)._visible = false;
				eval(Na1 + ".Artist" + j)._visible=false;
				eval(Na1 + ".CoverLetter" + j)._visible = false;
			}
			eval(Na1+".Num"+j).text = Index+1;			
			if (NumCover == "Yes"||DisplayAlbumLong=="true") {
				eval(Na1+".Num"+j)._visible = true;
				eval(Na1+".CoverNum"+j)._visible = true;
			} else {
				eval(Na1+".Num"+j)._visible = false;
				eval(Na1+".CoverNum"+j)._visible = false;
			}
			//MainLevel ==3 Album Page
			objDTS._visible=(ValPic[Index].AudioID.indexOf(';3;')>=0) and (NumCover=="Yes") and MainLevel==3;
			//Turn on or off Rating(G,R,etc...) only for Movie and TVSeries
			objFlag._visible=(NumCover=="Yes") and (databaseType==1 or databaseType==2);
			objFlag.ShowFlag(ValPic[Index].Flagid);
			Val1 += 1;
		} else {
			
			objFlag._visible=false;
			objDTS._visible=false;
			eval(Na1+".Movie"+j)._visible = false;
			eval(Na1+".Pic"+j)._visible = false;
			eval(Na1+".PicFade"+j)._visible = false;
			eval(Na1+".PicFade"+j).unloadMovie();

			eval(Na1+".Pic"+j).unloadMovie();
			eval(Na1+".Button"+j)._visible = false;
			eval(Na1+".Year"+j)._visible = false;
			eval(Na1+".ybg"+j)._visible = false;
			eval(Na1+".Letter"+j)._visible = false;
			eval(Na1+".CoverLetter"+j)._visible = false;
			eval(Na1+".Num"+j)._visible = false;
			eval(Na1+".Plus"+j)._visible = false;
			eval(Na1+".CoverNum"+j)._visible = false;
			eval(Na1+".Rank"+j)._visible=false;
			eval(Na1+".CDIcon"+j)._visible=false;
			eval(Na1+".Logo"+j)._visible=false;
			eval(Na1+".Artist"+j)._visible=false;
		}
		Index += 1;
	}
	if(SuiteAction.StoredProcedure=="RequestNextArtist" and SuiteAction.GotoLevels>MainLevel){
		SuiteAction.StoredProcedure="";
		RecordIndexArtistAlbum=SuiteAction.AlbumIndex;
		selectNameAlbum(SuiteAction.AlbumIndex,int(SuiteAction.AlbumIndex / NumMovie),true);
	}
	
	//ChangeAlbumFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
}
var RecordIndexArtistAlbum = 0;
var StoreAlbum = "";
var	StoreUniAlbum ="";

var PicX=new Array();
var PicY=new Array();
var RecordIndexArtistName=0;
//----
function selectNameAlbum(val_index,val_indexClick,noSend){
	LastAlbumSelected=StoreNameSelected;
	val_index = Number(val_index);
	val_indexClick = Number(val_indexClick);
	GenreBar._visible=false;
	if (MainLevel == 2) {
		selectArrowBar(val_indexClick,noSend);
		RecordIndexArtistName = Number(val_index);
		var Index = RecordIndexArtistName;
		StoreArtistName = resultSearchArtistName[Index].Artist;
		StoreUniArtistName = resultSearchArtistName[Index].uniArtist;
		RecordIdArtistName=resultSearchArtistName[Index].id;
		resultSeason=SplitResultSeason(resultSearchArtistName[Index].SeasonCount);
		RecordIndexSeasonName=0;
		//EDID:2005.10.19 (1 Movie,2 TVSeries,4 Music,8 Karaoke)
		if(databaseType==1 or databaseType==2){
			//Movie and TVSeries
			fscommand("GetAlbumByTVSeries",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue+"~"+resultSeason[RecordIndexSeasonName].id);
		}else{
			//Music and Karaoke
//			fscommand("GetArtistAlbum",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue+"~"+resultSeason[RecordIndexSeasonName].id);
		//Music and Karaoke
		if (i_SearchTrackFromArtist==0){ 
			fscommand("GetArtistAlbum",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue+"~"+resultSeason[RecordIndexSeasonName].id);
		}else{
			fscommand("ShowSearchArtistTrack",";"+RecordIdArtistName+";"+"&&"+databaseType+"&&"+AvaValue);
		}

		}
		
		FirstDisplayArtistName(resultSeason.length);
	} else if (MainLevel == 3) {
		MainLevel=4;
/////////////////////////
//selectVolBar(val_indexClick);     // comand by muny because it change image alpah when click from album page to track page
//		selectVolBar(val_indexClick);
		RecordIndexArtistAlbum = Number(val_index);
		IndexShowAlbum = int(RecordIndexArtistAlbum / nAlbum);
		
		StoreAlbumByIndex=IndexShowAlbum;
		StoreAlbumByCount=5;		
		CountAlbum = 5;
		
		StoreAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
		StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
		//FirstDisplayAlbum(resultSearchArtistAlbum.length);
		//TopBar.ButtonM.onRollOver();
		CharBar._visible=false;
		//...........
		FirstLoadDisplayAlbum=false;
		fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
		selectButton(TrackName+".Movie0");
	}
}
//----
///............................FUNCTION FADE..........................
function ExecFade () {
	if (Gom) {
		for (var jReset = 0; jReset<Numfade; jReset++) {
			eval(Name1+jReset)._alpha -= int(Alpha);
			eval(Name+jReset)._alpha += int(Alpha);
		}
		if (eval(Name1+0)._alpha<=40) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name1+jReset).unloadMovie();
			}
		}
		if (eval(Name+0)._alpha>=100) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name1+jReset)._alpha = 0;
				eval(Name+jReset)._alpha = 100;
			}
			Gom = false;
		}
	} else if (Gom1) {
		for (var jReset = 0; jReset<Numfade; jReset++) {
			eval(Name1+jReset)._alpha += int(Alpha);
			eval(Name+jReset)._alpha -= int(Alpha);
		}
		if (eval(Name+0)._alpha<=40) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name+jReset).unloadMovie();
			}
		}
		if (eval(Name1+0)._alpha>=100) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name1+jReset)._alpha = 100;
				eval(Name+jReset)._alpha = 0;
			}
			Gom1 = false;
		}
	}
	//////.............................................
	if (GomC) {
		for (var jReset = 0; jReset<NumfadeC; jReset++) {
			eval(Name1C+jReset)._alpha -= int(Alpha);
			eval(NameC+jReset)._alpha += int(Alpha);
		}
		if (eval(Name1C+0)._alpha<=40) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(Name1C+jReset).unloadMovie();
			}
		}
		if (eval(NameC+0)._alpha>=100) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(Name1C+jReset)._alpha = 0;
				eval(NameC+jReset)._alpha = 100;
			}
			GomC = false;			
		}
	} else if (Gom1C) {
		for (var jReset = 0; jReset<NumfadeC; jReset++) {
			eval(Name1C+jReset)._alpha += int(Alpha);
			eval(NameC+jReset)._alpha -= int(Alpha);
		}
		if (eval(NameC+0)._alpha<=40) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(NameC+jReset).unMovie();
			}
		}
		if (eval(Name1C+0)._alpha>=100) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(Name1C+jReset)._alpha = 100;
				eval(NameC+jReset)._alpha = 0;
			}
			Gom1C = false;				
		}
	}

	if ((Gom == false)and(Gom1 == false)and(GomC == false)and(Gom1C == false)){
		OpenFade = "false";
	}
}
var Name;
var Name1;
var NameFade;
var Gom = false;
var Gom1 = false;
var GomC = false;
var Gom1C = false;
var PicName = new Array();
var Numfade = 0;
var Alpha = 40;
function Reset(n) {
	Numfade = int(n);
	OpenFade="true";
	if (eval(Name+0)._alpha<=0) {
		FadeTrue=false;
		for (var jReset = 0; jReset<n; jReset++) {
			eval(Name+jReset)._alpha = 0;
			eval(Name1+jReset)._alpha = 100;
			eval(Name+jReset)._visible = true;
			eval(NameFade+jReset)._visible = true;
			eval(Name+jReset).loadMovie(PicName[jReset]);
		}
		Gom = true;
		Gom1 = false;
	} else {
		FadeTrue=true;
		for (var jReset = 0; jReset<n; jReset++) {
			eval(Name+jReset)._alpha = 100;
			eval(Name1+jReset)._alpha = 0;
			eval(Name1+jReset)._visible = true;
			eval(NameFade+jReset)._visible = true;
			eval(Name1+jReset).loadMovie(PicName[jReset]);			
		}
		Gom1 = true;
		Gom = false;
	}
	
}
///	 END FUNCTION RESET()		\\\
var NameC;
var Name1C;
var NameFadeC;
var GomC = false;
var Gom1C = false;
var PicNameC = new Array();
var NumfadeC = 0;
var OpenFade="false";
function ResetC(n) {

	NumfadeC = n;
	OpenFade="true";
	if (eval(NameC+0)._alpha<=0) {
		FadeTrueBar=false;
		for (var jReset = 0; jReset<n; jReset++) {
			eval(NameC+jReset)._alpha = 0;
			eval(Name1C+jReset)._alpha = 100;
			eval(NameC+jReset)._visible = true;
			eval(NameFadeC+jReset)._visible = true;
			//eval(Name+jReset).unloadMovie();
			eval(NameC+jReset).loadMovie(PicNameC[jReset]);
		}
		GomC = true;
		Gom1C = false;
	} else {
		FadeTrueBar=true;
		for (var jReset = 0; jReset<n; jReset++) {
			eval(NameC+jReset)._alpha = 100;
			eval(Name1C+jReset)._alpha = 0;
			eval(Name1C+jReset)._visible = true;
			eval(NameFadeC+jReset)._visible = true;
			//eval(Name1+jReset).unloadMovie();
			eval(Name1C+jReset).loadMovie(PicNameC[jReset]);
		}
		Gom1C = true;
		GomC = false;
	}
}
///	 END FUNCTION RESET()		\\\
//................................DISPLAY ARTISTALBUM..................................
function DisplayItemVol (Obj,Index,Count,nItem,Value) {
	//.........Highlight text...........
	if(Obj=="VolBar") HighLightText("Volbar",IndexShowVol,RecordIndexVol,nVol);
	else if(Obj=="ArrowBar")HighLightText("ArrowBar",IndexShowArrow,RecordIndexArrow,nVol);
	//.........
	for (var j=0;j<nItem;j++ ){
		if(j<Count){
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Text"+j)._visible=true;
			eval(Obj+".Text"+j).text=Value[Index+j];
		}
		else{
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
		}
	}
}

function VolBarArrow(n,Obj){
	if(n<=1){
		eval(Obj+".MovieArrowLeft")._visible=false;
		eval(Obj+".MovieArrowRight")._visible=false;
		eval(Obj+".ButtonArrowLeft")._visible=false;
		eval(Obj+".ButtonArrowRight")._visible=false;
		eval(Obj+".IconArrowRight")._visible=false;
		eval(Obj+".IconArrowLeft")._visible=false;
	}
	else{
		eval(Obj+".MovieArrowLeft")._visible=true;
		eval(Obj+".MovieArrowRight")._visible=true;
		eval(Obj+".ButtonArrowLeft")._visible=true;
		eval(Obj+".ButtonArrowRight")._visible=true;
		eval(Obj+".IconArrowRight")._visible=true;
		eval(Obj+".IconArrowLeft")._visible=true;
	}
}
function FirstDisplayVol(n){
	VolBarArrow(n,"VolBar")
	FirstDisplay("Vol",n,nVol);
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
}
VolBar.ButtonArrowLeft.onRollOver=function(){
	SelectButton("VolBar.MovieArrowLeft");
	SelectLevel=4;
	ButtonTip._visible=false;
	TextTip._visible=false;
	//DisplayTooltip(this._xmouse,this._ymouse,27,22,"txtTooltip","Previous Album( [ )",SHTT,50,20);
}
VolBar.ButtonArrowRight.onRollOver=function(){
	SelectButton("VolBar.MovieArrowRight");
	SelectLevel=4;
	ButtonTip._visible=false;
	TextTip._visible=false;
	//DisplayTooltip(this._xmouse,this._ymouse,27,22,"txtTooltip","Next Album( ] )",SHTT,100,20);
}
VolBar.ButtonArrowLeft.onRelease=function(){
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
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
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
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

VolBar.ButtonLeft.onRollOver=function(){
	SelectButton("VolBar.MovieLeft");
	SelectLevel=4;
	ButtonTip._visible=false;
	TextTip._visible=false;
}
VolBar.ButtonRight.onRollOver=function(){
	SelectButton("VolBar.MovieRight");
	SelectLevel=4;
	ButtonTip._visible=false;
	TextTip._visible=false;
}

VolBar.ButtonLeft.onRelease=function(){
	//Send2Server("client","0&&&Click||"+this,true);
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
	ClickLeft("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
}
VolBar.ButtonRight.onRelease=function(){
	//Send2Server("client","0&&&Click||"+this,true);
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
	ClickRight("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);

}
var IndexNameVol=0;
var IndexNameArrow=0;
var StoreIndexArrow1=0;
var	StoreCountArrow1=0;
var RecordIndexArrow = 0;
var RecordLevelArrow = 0;
var StoreAlbumByIndex=0;
var StoreAlbumByCount=0;
for (var j = 0; j<nVol; j++) {
	eval("VolBar.Button"+j).onRollOver = function() {
		var IndexName = GetNumber(this._name);
		SelectButton("VolBar.Movie"+IndexName);
		SelectLevel = 4;
		ButtonTip._visible=false;
		TextTip._visible=false;
	};
	eval("VolBar.Button"+j).onRelease = function() {
		var Indexs = IndexShowVol + GetNumber(this._name);
		Send2Server("client","0&&&function||selectVolbar|~|" + Indexs,true);

		selectVolbar(Indexs);
	};
	//.............Arrow.........................
	eval("ArrowBar.Button"+j).onRollOver = function() {
		var IndexName = GetNumber(this._name);
		SelectButton("ArrowBar.Movie"+IndexName);
		SelectLevel = 4;
		TextTip._visible=false;
		ButtonTip._visible=false;
	};
	eval("ArrowBar.Button"+j).onRelease = function() {
		var Indexs = IndexShowArrow + GetNumber(this._name);
		selectArrowBar(Indexs);
	};
}
//----
function selectVolbar(val_index,noSend){
	if(!noSend){
		if (send_event("normal&&&function||selectVolbar|~|" + val_index  + "||0", false)) {
			return;
		}
	}
	val_index = Number(val_index);
	clickVolIndex = val_index;
	var Index = val_index
	IndexNameVol = Index%nVol;
	IndexName = IndexNameVol;
	IndexShowVol = Index-(Index % nVol);	
	if (resultSearchVol.length-IndexShowVol >= nVol){
		CountVol = nVol;
	}else{
		CountVol = resultSearchVol.length % nVol;		
	}
	LevelIndexVol = int(Index/nVol)+1;
	
	RecordIndexVol = Index;
	RecordLevelVol = LevelIndexVol;
	//.........Highlight text...........	
	HighLightText("VolBar",IndexShowVol,RecordIndexVol,nVol);
	//.........
	var spl = resultSearchVol[RecordIndexVol].split(":");
	Index = parseInt(spl[0], 10);
	var count = parseInt(spl[1], 10)-index;
	StoreIndexVol1=Index-1;
	StoreCountVol1=count+1;
	StoreAlbumByIndex=StoreIndexVol1;
	StoreAlbumByCount=StoreCountVol1;
	
	if(ConfirmIdAlbum(StoreIndexVol1,StoreCountVol1)){
		fscommand("GetAlbumByIndex",StoreIndexVol1+"~"+StoreCountVol1+"~"+"Yes");
	}
	else{
		ShowMovieArtist(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
	}

	if(DisplayAlbum=="Browse"){
		if(BrowseBy!="Genre"){	
			fscommand("SaveIndexAndCount",IndexShowVol+"~"+CountVol+"~"+LevelIndexVol+"~"+IndexName+"~"+AvaValue+"~"+NumMovie+"~"+DisplayAlbum+"~"+BrowseBy);
		}
	}
	else if(DisplayAlbum!="MyFavArtist"){

		fscommand("SaveIndexAndCount",IndexShowVol+"~"+CountVol+"~"+LevelIndexVol+"~"+IndexName+"~"+AvaValue+"~"+NumMovie+"~"+DisplayAlbum+"~"+BrowseBy);
	}
	if(MainLevel!=3){
		eval(NameAlbum)._visible=false;
	}
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
}
//----
function selectArrowBar(val_index,noSend){
	if(!noSend){
		if (send_event("normal&&&function||selectArrowBar|~|" + val_index  + "||0", false)) {
			return;
		}
	}
	val_index = Number(val_index);
	clickArrowIndex = val_index;
	var Index = val_index;	
	var IndexName = Index % nVol;
	IndexNameArrow=int(IndexName);
	IndexShowArrow = Index-(Index % nVol);
	if (resultSearchArrow.length-IndexShowArrow >= nVol){
		CountArrow = nVol;
	}else{
		CountArrow = resultSearchArrow.length % nVol;		
	}
	LevelIndexArrow = int(Index/nVol)+1;	
	
	RecordIndexArrow = Index;
	RecordLevelArrow = LevelIndexArrow;
	//.........Highlight text...........
	HighLightText("ArrowBar",IndexShowArrow,RecordIndexArrow,nVol);
	//.........
	var spl = resultSearchArrow[Index].split(":");
	Index = parseInt(spl[0], 10);
	var count = parseInt(spl[1], 10)-index;
	StoreIndexArrow1=Index-1;
	StoreCountArrow1=count+1;
	ShowMovieArtist(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
	fscommand("SaveIndexAndCount",IndexShowArrow+"~"+CountArrow+"~"+LevelIndexArrow+"~"+IndexName+"~"+AvaValue+"~"+NumMovie+"~"+DisplayAlbum+"~"+BrowseBy);
	for(var i=0;i<StoreCountArrow1;i++){
		Index=StoreIndexArrow1+i;
		if(resultSearchArtistName[Index].SetPic==0){
			resultSearchArtistName[Index].SetPic=1;
			fscommand("SearchPathImage",resultSearchArtistName[Index].Path+"%~%"+"Artist"+"%~%"+Index+"%~%"+resultSearchArtistName[Index].StringPath+"%~%"+LanName);
		}
	}
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);	
}
//----
function ConfirmIdAlbum(Index,Count){
	for(var j=0;j<Count;j++){
		if(resultSearchArtistAlbum[Index+j].id.length<=0){
			return true;
		}
	}
	return false
}
//.........................ARTISTNAMEBAR................................
function ShowMovieBar(Obj, Index, Count,nItem, ValPic) {
	if(Obj=="ArtistNameBar"){
		for(var i=0;iIndex+i<ValPic.length;i++){
			var Index1=Index+i;
			if(int(resultSearchArtistName[Index1].SetPic)==0){
				resultSearchArtistName[Index1].SetPic=1;
				fscommand("SearchPathImage",resultSearchArtistName[Index1].Path+"%~%"+"Artist"+"%~%"+Index1+"%~%"+resultSearchArtistName[Index1].StringPath+"%~%"+LanName);
			}
		}
	}
	NameC = Obj+".Pic";
	Name1C = Obj+".PicFade";
	NameFadeC = Obj+".Movie";
	PicNameC.length = 0;
	for (var j = 0; j<nItem; j++) {
		if(j+Index<ValPic.length){
			eval(Obj+".Movie"+j)._visible=true;
			eval(Obj+".Button"+j)._visible=true;
			eval(Obj+".Pic"+j)._visible=true;
			eval(Obj+".PicFade"+j)._visible=true;
			PicNameC[j] = ValPic[Index+j].ReservePath;
			if(Isregistered=="False")eval(Obj+".Logo"+j)._visible=true;
			else eval(Obj+".Logo"+j)._visible=false;
		}
		else{
			eval(Obj+".Movie"+j)._visible=false;
			eval(Obj+".Button"+j)._visible=false;
			eval(Obj+".Cover"+j)._visible=false;
			eval(Obj+".Text"+j)._visible=false;
			eval(Obj+".Pic"+j).unloadMovie();
			eval(Obj+".PicFade"+j).unloadMovie();
			eval(Obj+".Logo"+j)._visible=false;
		}
	}
	ResetC(PicNameC.length);
	
	DisplayArtistNameItem(Obj, Index, Count,nItem, ValPic);
}

function DisplayArtistNameItem(Obj, Index, Count,nItem, ValPic) {
	var varUnicode;
	for (var j = 0; j<nItem; j++) {
		if(Index+j<ValPic.length){
			if (AlbumCover == "Yes") {
				eval(Obj+".Text"+j)._visible=true;
				eval(Obj+".Cover"+j)._visible=true;
				if (ChangeLan == "Eng") {
					eval(Obj+".Text"+j).text = ValPic[Index+j].Artist;
					varUnicode="Eng";
				} else {
					if(ValPic[Index+j].uniArtist==""){
						eval(Obj+".Text"+j).text = ValPic[Index+j].Artist;
						varUnicode="Eng";
					}else{
						eval(Obj+".Text"+j).text = ValPic[Index+j].uniArtist;
						varUnicode="Uni";
					}
				}
				ChangeArtistNameFont(Obj,EngFont, UniFont, EngSize, UniSize, varUnicode,ValPic[Index+j].idLan,j);
			}
			else {
				eval(Obj+".Cover"+j)._visible=false;
				eval(Obj+".Text"+j)._visible=false;
			}
		}
		
	}
	if(Obj=="AlbumBar"){
		DeselectedItem(Obj,Index,RecordIndexArtistAlbum,nItem);
	}else { 
		DeselectedItem(Obj,Index,RecordIndexSeasonName,nItem);
	}
}
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
function FirstDisplayArtistName(n){
	FirstDisplay("ArtistName",n,nArtistName);
	var Level=ReturnLevel(RecordIndexSeasonName+1 , nArtistName);
	IndexShowArtistName=(Level-1) * nArtistName;
	CountArtistName=ReturnCount(Level,TotalLevelIndexArtistName,n,nArtistName)
	LevelIndexArtistName=Level;
	ShowMovieBar("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
}
ArtistNameBar.ButtonLeft.onRollOver=function(){
	SelectButton("ArtistNameBar.MovieLeft");

	SelectLevel=2;
}
ArtistNameBar.ButtonRight.onRollOver=function(){
	SelectButton("ArtistNameBar.MovieRight");
	SelectLevel=2;
}

ArtistNameBar.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this  + "||0", false)) {
		return;
	}
	ClickLeft("ArtistName");
	ShowMovieBar("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
}
ArtistNameBar.ButtonRight.onRelease=function(){
	if (send_event("normal&&&Click||" + this  + "||0", false)) {
		return;
	}
	ClickRight("ArtistName");
	ShowMovieBar("ArtistNameBar",IndexShowArtistName,CountArtistName,nArtistName,resultSeason);
}
for (var j = 0; j<nArtistName; j++) {
	eval("ArtistNameBar.Button"+j).onRollOver = function() {
		SelectButton("ArtistNameBar.Movie"+GetNumber(this._name));
		var Index = IndexShowArtistName+GetNumber(this._name);
		if (ChangeLan == "Eng") popup_tooltip("TextTip:ButtonTip",resultSeason[Index].Artist);//TextTip.text = resultSearchArtistName[Index].Artist;
		else popup_tooltip("TextTip:ButtonTip",resultSeason[Index].uniArtist);//TextTip.text = resultSearchArtistName[Index].uniArtist;
		if(!TextTip._visible){
			ButtonTip._visible = true;
			ButtonTip._y = 25;
			TextTip._visible = true;
			TextTip._y = 3;
		}
		ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
		ButtonTipChange();
		SelectLevel=2;
	};
	eval("ArtistNameBar.Button"+j).onRelease = function() {
		var Index = IndexShowArtistName + GetNumber(this._name);
		Send2Server("client","0&&&function||selectArtistNameBar|~|" + Index,true);
		selectArtistNameBar(Index);
		tipPos(false);
	};
}
function selectArtistNameBar(val_SeasonIndex){
	if (send_event("normal&&&function||selectArtistNameBar|~|" + val_SeasonIndex  + "||0", false)) {
		return;
	}
	val_SeasonIndex=Number(val_SeasonIndex);
	RecordIndexSeasonName=val_SeasonIndex;
	Index = RecordIndexArtistName;
	IndexShowArtistName = val_SeasonIndex-(val_SeasonIndex%nArtistName);
	if (resultSearchArtistName.length-IndexShowArtistName >= nArtistName){
		CountArtistName = nArtistName;
	}else{
		CountArtistName = resultSearchArtistName.length%nArtistName;		
	}	
	SelectedItem("ArtistNameBar",val_index%nGenre,nGenre);
	StoreArtistName = resultSearchArtistName[Index].Artist;
	StoreUniArtistName = resultSearchArtistName[Index].uniArtist;
	RecordIdArtistName=resultSearchArtistName[Index].id;
	if(databaseType==1 or databaseType==2){
		//Movie and TVSeries
		fscommand("GetAlbumByTVSeries",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue+"~"+resultSeason[RecordIndexSeasonName].id);
	}else{
		//Music and Karaoke
		if (i_SearchTrackFromArtist==0){
			fscommand("GetArtistAlbum",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue+"~"+resultSeason[RecordIndexSeasonName].id);
		}else{
			fscommand("ShowSearchArtistTrack",";"+RecordIdArtistName+";"+"&&"+databaseType+"&&"+AvaValue);
		}
	}
}
//................................TRACKINFO.....................................
function FirstDisplayTrack(n){
	BackAlbumInfo._visible=false;
	if(Isregistered=="False")  eval(TrackName).Logo._visible=true;
	else  eval(TrackName).Logo._visible=false;
	eval(TrackName).FlagGroup.ShowFlag(resultSearchArtistAlbum[RecordIndexArtistAlbum].FlagID);
	if(resultSearchArtistAlbum[RecordIndexArtistAlbum].Ava=="0"){
		eval(TrackName).CDIcon._visible=false;		
	}
	else{
		eval(TrackName).CDIcon._visible=true;
	}
	if(resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav=="1"){
		eval(TrackName).Rank._visible=true;
		eval(TrackName).PlusIcon.Selected._visible=true;
	}
	else{
		eval(TrackName).Rank._visible=false;
		eval(TrackName).PlusIcon.Selected._visible=false;
	}
	eval(TrackName).Rank.Text.text=resultSearchArtistAlbum[RecordIndexArtistAlbum].Rank;
	eval(TrackName)._visible=true;
	BackAlbumPic._visible=true;
	showPlayer();
	VisiblePlay(true);
	DisplayAlbumPictrueInfo();
	FirstDisplay(TrackObj,n,nTrack);
	eval(TrackName)._visible=false;
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
	eval(TrackName)._visible=true;
}
function ClickLeftTrackTittle(val){
	if (send_event("normal&&&function||ClickLeftTrackTittle||0", false)) {
		return;
	}
	if(val==0)	ClickLeft(TrackObj);
	else ClickRight(TrackObj);
	DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	eval(TrackName).Button0.onRollOver();
}
function VisibleInfo(Value) {
	VisibleIconAlbum(boolShowCoverIcon);
	if(boolShowCoverIcon){
		DisplayToolTipStar(true);
	}

/*	if (Value == "true") {
		var b = true;
		DisplayToolTipStar(true);
		DisplayToolTipTrack(b);
	} else {
		var b = false;
	}
	eval(TrackName).CoverTrackInfo._visible = b;
	eval(TrackName).TrackLen._visible = b;
	eval(TrackName).Mood._visible = b;
	eval(TrackName).Dance._visible = b;
	eval(TrackName).Artist._visible = b;
	eval(TrackName).Year._visible=b;
*/
}
eval(TrackName).MovieRollOver.useHandCursor = false;
eval(TrackName).MovieRollOver.onRollOut = function() {
	VisibleInfo("false");
};
function FadeTooltipTrack() {
	clr += 10;
	if (clr>=50) {
		eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
		VisibleInfo(false);
		clearInterval(clearToolTip1);
	}
}
function ToolTip(St, X, Y, Index) {
	
	eval(TrackName).TextToolTip._visible = false;
	eval(TrackName).TextToolTip.text = St;
	eval(TrackName).TextToolTip._width = eval(TrackBar+".Movie"+Index)._width - (eval(TrackName).TextToolTip._x - eval(TrackBar+".Movie"+Index)._x);
	eval(TrackName).TextToolTip._height = eval(TrackName +".Text"+Index)._height;	
	eval(TrackName).TextToolTip.wordWrap = true;	
	
	eval(TrackName).TextToolTip.autoSize = true;
	if (eval( TrackName + ".Movie"+Index).storeLan == "Eng"){
		eval(TrackName).TextToolTip.setTextFormat(EngTextFormat);
	}else{
		eval(TrackName).TextToolTip.setTextFormat(UniTextFormat);
	}
	
//	if (eval(TrackName).TextToolTip._width>eval(TrackName+".Text"+Index)._width) {
	if (eval(TrackName+  ".Do"+Index)._visible == true && eval(TrackName+".Do"+Index).text != ""){
		displayTwoLine_boo = true;
		eval(TrackName).TextToolTip._x = X;
		eval(TrackName).TextToolTip._y = Y;
		eval(TrackName).TextToolTip._visible = true;
		
		var g_color = new Color(eval(TrackName+".Movie"+Index));
		var s_color = new Color(eval(TrackName+".over_mc"));
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
		eval(TrackName+".over_mc")._visible = true;
		
		eval(TrackName+".samOver_mc")._x = eval(TrackName+".Sam"+Index)._x;
		eval(TrackName+".samOver_mc")._y = eval(TrackName+".Sam"+Index)._y;
		if (eval(TrackName+".Sam"+Index)._visible == true){
			var cc = new Color(eval(TrackName+".Sam"+Index) + ".music_note");
			var dd = new Color(eval(TrackName + ".samOver_mc.music_note"));
			dd.setRGB(cc.getRGB());
			if(eval(TrackName+".Sam"+Index+".Sample")._visible == true){
				eval(TrackName+".samOver_mc.Sample")._visible = true;
				eval(TrackName+".samOver_mc.Music")._visible = false;
			}else{
				eval(TrackName+".samOver_mc.Sample")._visible = false;
				eval(TrackName+".samOver_mc.Music")._visible = true;
			}
			eval(TrackName+".samOver_mc")._visible = true;
		}
		
		eval(TrackName+".cartOver_mc")._x = eval(TrackName+".Cart"+Index)._x;
		eval(TrackName+".cartOver_mc")._y = eval(TrackName+".Cart"+Index)._y;
		if (eval(TrackName+".Cart"+Index)._visible == true){eval(TrackName+".cartOver_mc")._visible = true;}
		
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
	//DisplayToolTipStar(true);
}
function TrackInfo(Index) {
	VisibleInfo("true");
	eval(TrackName).TrackLen.text = resultSearchTrack[Index].Length;
	eval(TrackName).offset.txt.text = resultSearchTrack[Index].seekOffset;
	VisibleStar(parseInt(resultSearchTrack[Index].Rating, 10));
	
	
	if (ChangeLan == "Eng") {
		eval(TrackName).Mood.text = resultSearchTrack[Index].Mood;
		eval(TrackName).Dance.text = resultSearchTrack[Index].danceStyle;
		eval(TrackName).Artist.text = resultSearchTrack[Index].Artist;
	} else {
		eval(TrackName).Mood.text = resultSearchTrack[Index].unicodeMood;
		eval(TrackName).Dance.text = resultSearchTrack[Index].unicodedanceStyle;
		eval(TrackName).Artist.text = resultSearchTrack[Index].unicodeArtist;
	}
	eval(TrackName).Year.text =resultSearchTrack[Index].Length+ "   " + resultSearchArtistAlbum[RecordIndexArtistAlbum].Year+"\n" + resultSearchTrack[Index].LanTrack;
	ChangeTrackInfoFont(EngFont, UniFont, EngSize, UniSize, ChangeLan,resultSearchArtistAlbum[RecordIndexArtistAlbum].idLan);
}
//----
function selectToPlayTrack(val_index,str_PlayMode){
	val_index = Number(val_index);
	IndexTrack = val_index;
	PlayMode = str_PlayMode;
	
	if(SearchArtist.MovieSel._visible){
		fscommand("ShowSearch",BrowsingAlbumID + "&&"+resultSearchTrack[IndexTrack].trackID+"&&"+databaseType+"&&"+"3");
		//trackid,all ,databasetype
		//fscommand("ShowSearch",resultSearchTrack[IndexTrack].Artist+"&&3");
		SearchArtist.MovieSel._visible=false;
		return;
	}
	
	FuncPlayAll(IndexTrack,PlayMode);
}
//...............................ALBUMINFO......................................
function DisplayAlbumPictrueInfo() {
	IndexAlbumForDownLoad=RecordIndexArtistAlbum;
	AlbumPicClick = "folder";
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	PicName[0] = resultSearchArtistAlbum[RecordIndexArtistAlbum].ReservePath;
	//BackAlbumPic.loadFadeImage(PicName[0]);
	BackAlbumPic.unloadFadeImage();
	fscommand("SearchPathImage",PicName[0] + "%~%"+"Album" +"%~%" + RecordIndexArtistAlbum + "%~%" + resultSearchArtistAlbum[RecordIndexArtistAlbum].Id + "%~%" +LanName);
}
DisplayAlbumBarInfo=function(Index){
	var sDisplayUnicode="Eng";
	if (ChangeLan == "Eng"){
		if(resultSearchArtistAlbum[Index].Artist==""){
			sDisplayUnicode="Uni"
		}else{
			sDisplayUnicode="Eng"
		}
	}else {
		if(resultSearchArtistAlbum[Index].uniArtist==""){
			sDisplayUnicode="Eng"
		}else{
			sDisplayUnicode="Uni"
		}
	}
	if(sDisplayUnicode=="Eng"){
		popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[Index].Artist);
	}else{
		popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[Index].uniArtist);
	}
	if(!TextTip._visible){
		ButtonTip._visible = true;
		ButtonTip._y = 25;
		TextTip._visible = true;
		TextTip._y = 3;
	}
	ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, sDisplayUnicode);
}

var AlbumPicClick = "folder";
BackAlbumPic.Button.onRollOver = function() {
	HideTooltip("txtTooltip");
//	VisibleInfo("false");
	SelectButton("BackAlbumPic.Movie");
	SelectLevel = 3;
	DisplayAlbumBarInfo(RecordIndexArtistAlbum);

	ButtonTipChange();
	tipPos(true);
};
BackAlbumPic.Button.onRelease = function() {
	if(send_event("normal&&&Click||"+ this + "||0",false)){return;}
	Name = "BackAlbumPic.Pic";
	Name1 = "BackAlbumPic.PicFade";
	NameFade = "BackAlbumPic.Movie";
	PicName.length = 0;
	if (AlbumPicClick == "folder") {
		AlbumPicClick = "back";
		PicName[0] =resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
		PicName[0]=PicName[0].substr( 0,PicName[0].length-10) +"back.jpg";
		var picType="Back";
		//substring(resultSearchArtistAlbum[RecordIndexArtistAlbum].ReservePath,0,resultSearchArtistAlbum[RecordIndexArtistAlbum].ReservePath.length-10)+"back.jpg";
	} else {
		
		PicName[0] = resultSearchArtistAlbum[RecordIndexArtistAlbum].Path;
		var picType="Album";
		AlbumPicClick = "folder";
	}
	fscommand("SearchPathImage",PicName[0] + "%~%"+picType +"%~%" + RecordIndexArtistAlbum + "%~%" + resultSearchArtistAlbum[RecordIndexArtistAlbum].Id + "%~%" +LanName)
	//BackAlbumPic.loadFadeImage(PicName[0]);
};
eval("Cart.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Purchase DVD (G)",SHTT,-(117.3/2)+5,-20);
	SelectButton("Cart.Movie");
	SelectLevel = 4;
};
eval("Cart.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};
eval("Cart.Button").onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	if(send_event("normal&&&Click||"+ this + "||0",false)){
		 return;
	}
	SearchArtist.MovieSel._visible=false;
	if(LanName=="English"){
		PurchaseCDMode._visible=true;
		PurchaseCDMode.Button0.onRollOver();
		Cover._visible=true;
		fscommand("ShowPurchaseBox",resultSearchArtistAlbum[RecordIndexArtistAlbum].id);
	}
	else fscommand("buyCD",resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
	
}
//----------------------------------------------------------------------------------------------------
eval("AlbumInfo.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","DVD Information (I)",SHTT,-(122/2)+5,-20);
	SelectButton("AlbumInfo.Movie");
	SelectLevel = 4;
};
eval("AlbumInfo.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};

eval("AlbumInfo.Button").onRelease = function() {	
	click_AlbumInfo(eval(TrackName)._visible, BackAlbumInfo._visible);	
};
function click_AlbumInfo(val_track,val_back){
	if(send_event("normal&&&function||click_AlbumInfo|~|"+ val_track + "|~|" + val_back + "||0",false)){
		 return;
	}
	val_track = String(val_track);
	val_back = String(val_back);
	SearchArtist.MovieSel._visible=false;
	if(val_track == "true"){
		showPlayer();
		fscommand("GetArtistAlbumInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id);
		eval(TrackName)._visible = false;
		BackAlbumInfo._visible = true;
	} else if(val_back == "true"){
		TopBar.ButtonB.onRelease();
	}
}
//----------------------------------------------------------------------------------------------------
eval("PlayAll.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip",PlayMode+" Track",SHTT,-(122/2)+5,-20);
	SelectButton("PlayAll.Movie");
	SelectLevel = 4;
};
eval("PlayAll.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};
eval("SearchArtist.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Search For Artist",SHTT,-(122/2)+5,-20);
	SelectButton("SearchArtist.Movie");
	SelectLevel = 4;
};
eval("SearchArtist.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};
eval("PlayAll.Button").onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);
	//click_PlayAll_Button(PlayMode);

};
function click_PlayAll_Button(val_PlayMode){
	if(send_event("normal&&&function||click_PlayAll_Button|~|"+ val_PlayMode + "||0",false)){
		 return;
	}
	PlayMode = val_PlayMode;
	SearchArtist.MovieSel._visible=false;
	if (PlayMode == "All") {
		PlayMode = "One";
		PlayAll.Text.text = PlayMode;
		PlayAll.Icon2._visible=false;
		PlayAll.Icon1._visible=true;
	} else {
		PlayMode = "All";
		PlayAll.Text.text = PlayMode;
		PlayAll.Icon2._visible=true;
		PlayAll.Icon1._visible=true;
	}
	fscommand("PlayMode", PlayMode);
}
eval("SearchArtist.Button").onRelease = function() {
	Send2Server("client","0&&&Click||"+this,true);
	if(SearchArtist.MovieSel._visible)SearchArtist.MovieSel._visible=false;
	else SearchArtist.MovieSel._visible=true;
}
//..............................PREALUBM & NEXTALBUM......................................
eval("PreAlbum.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Previous Album (<)",SHTT,-(125.1/2)+5,-20);
	SelectButton("PreAlbum.Movie");
	SelectLevel = 4;
};
eval("PreAlbum.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};


eval("PreAlbum.Button").onRelease = function() {
	//Send2Server("client","0&&&Click||"+this,true);	
	//if(FirstLoadDisplayAlbum==false)FirstDisplayAlbum(resultSearchArtistAlbum.length);
	if (_global.boolMouseDown == false){ 
		return;
	}
	if (send_event("normal&&&Click||"+this+"||0", false)) {return;}
	_global.boolMouseDown = false;
	BackAlbumInfo._visible = false;
	SearchArtist.MovieSel._visible=false;
	RecordIndexArtistAlbum -= 1;
	if (RecordIndexArtistAlbum<0) {
		RecordIndexArtistAlbum = NumAlbum-1;
	}
	StoreAlbum=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
	StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
	//......................
	var k=RecordIndexArtistAlbum%nAlbum;
	SelectedItem("AlbumBar",k,nAlbum);
	var Level=ReturnLevel(RecordIndexArtistAlbum+1 , nAlbum);
	if(Level!=LevelIndexAlbum){
		IndexShowAlbum=(Level-1) * nAlbum;
		CountAlbum=ReturnCount(Level,TotalLevelIndexAlbum,resultSearchArtistAlbum.length,nAlbum)
		LevelIndexAlbum=Level;
		//.......
		StoreAlbumByIndex=IndexShowAlbum;
		StoreAlbumByCount=CountAlbum;
		if(ConfirmIdAlbum(StoreAlbumByIndex,StoreAlbumByCount)){
			fscommand("GetAlbumByIndex",StoreAlbumByIndex+"~"+StoreAlbumByCount+"~"+"No");
		}
		else{
			DisplayToolTipAlbum();
			ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
			fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
		}
	}
	else{
		DisplayToolTipAlbum();
		fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
	}
};
var IndexNextAlbum = 0;
eval("NextAlbum.Button").onRollOver = function() {
	DisplayTooltip(this,"txtTooltip","Next Album (>)",SHTT,-97+5,-20);
	SelectButton("NextAlbum.Movie");
	SelectLevel = 4;
};
eval("NextAlbum.Button").onRollOut = function() {
	HideTooltip("txtTooltip");
};
eval("NextAlbum.Button").onRelease = function() {
	
	if (_global.boolMouseDown == false){ 
		return;
	}
	if (clientType == remoteControl){
		if (client_receive == "true"){						
			client_receive = "false";			
		}else{
			return;
		}
	}	
	if(FirstLoadDisplayAlbum==false)FirstDisplayAlbum(resultSearchArtistAlbum.length);
	if (send_event("normal&&&Click||"+this+"||0", false)) {return;}
//	Send2Server("client","0&&&Click||"+this,true);
	_global.boolMouseDown = false;
	SearchArtist.MovieSel._visible=false;
	BackAlbumInfo._visible = false;
	RecordIndexArtistAlbum += 1;
	if (RecordIndexArtistAlbum>NumAlbum-1) {
		RecordIndexArtistAlbum = 0;
	}
	StoreAlbum=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
	StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
	//...................
	var k=RecordIndexArtistAlbum%nAlbum;
	SelectedItem("AlbumBar",k,nAlbum);
	//var Level=ReturnLevel(RecordIndexArtistAlbum+1 , nAlbum);
	var Level= int(RecordIndexArtistAlbum / nAlbum)+1

	if(Level!=LevelIndexAlbum){
		IndexShowAlbum=(Level-1) * nAlbum;
		CountAlbum=ReturnCount(Level,TotalLevelIndexAlbum,resultSearchArtistAlbum.length,nAlbum)
		LevelIndexAlbum=Level;
		//.......
		StoreAlbumByIndex=IndexShowAlbum;
		StoreAlbumByCount=CountAlbum;
		if(ConfirmIdAlbum(StoreAlbumByIndex,StoreAlbumByCount)){
			fscommand("GetAlbumByIndex",StoreAlbumByIndex+"~"+StoreAlbumByCount+"~"+"No");
		}
		else{
			DisplayToolTipAlbum();
			ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
			fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
		}
	}
	else{
		DisplayToolTipAlbum();
		fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
	}
};
function DisplayToolTipAlbum(){
	if (ChangeLan == "Eng") popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist);//TextTip.text = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
	else {
		if(resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist==""){
			popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist);
		}
		else{
			popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist);
		}
	}
	if(!TextTip._visible){
		ButtonTip._visible = true;
		ButtonTip._y = 48;
		TextTip._visible = true;
		TextTip._y = 26;
	}
	ChangeProTitleFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
	ButtonTipChange();
}
//.........................................ALBUMBAR ACTION SCRIPT..........................................
var FirstLoadDisplayAlbum=false;
function FirstDisplayAlbum(n){		
		FirstLoadDisplayAlbum=true;
		FirstDisplay("Album",n,nAlbum);
		var Level= int(RecordIndexArtistAlbum / nAlbum)+1
		IndexShowAlbum=(Level-1)*nAlbum
		CountAlbum=ReturnCount(Level,TotalLevelIndexAlbum,n,nAlbum)
		LevelIndexAlbum=Level;
		ShowAlbumBar(IndexShowAlbum,CountAlbum);
}

AlbumBar.ButtonLeft.onRollOver = function() {
	SelectButton("AlbumBar.MovieLeft");
	SelectLevel = 2;
};
AlbumBar.ButtonLeft.onRelease = function() {
	Send2Server("client","0&&&Click||"+this,true);
	ClickLeft("Album");
	ShowAlbumBar(IndexShowAlbum,CountAlbum);
};
AlbumBar.ButtonRight.onRollOver = function() {
	SelectButton("AlbumBar.MovieRight");
	SelectLevel = 2;
};
AlbumBar.ButtonRight.onRelease = function() {
	Send2Server("client","0&&&Click||"+this,true);
	ClickRight("Album");
	ShowAlbumBar(IndexShowAlbum,CountAlbum);
};
function ShowAlbumBar (intStart,intCount) {
	SuiteAction.StoredProcedure="";	
	if (send_event("normal&&&function||ShowAlbumBar|~|" + intStart + "|~|" + intCount + "||0", false)) {
		return;
	}
	StoreAlbumByIndex=int(intStart);	
	StoreAlbumByCount=int(intCount);	
	IndexShowAlbum=StoreAlbumByIndex;
	CountAlbum=StoreAlbumByCount;
	
	if(ConfirmIdAlbum(StoreAlbumByIndex,StoreAlbumByCount)){
		fscommand("GetAlbumByIndex",StoreAlbumByIndex+"~"+StoreAlbumByCount+"~"+"AlbumBar");
	}
	else{
		ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
	}
}

for (var j = 0; j<nAlbum; j++) {
	eval("AlbumBar.Button"+j).onRollOver = function() {
		SelectLevel=2;
		var Index = ((LevelIndexAlbum-1)*nAlbum)+parseInt(substring(this._name, this._name.length, -1), 10);
		SelectButton("AlbumBar.Movie"+GetNumber(this._name));
		DisplayAlbumBarInfo(Index);
		ButtonTipChange();
	};
	eval("AlbumBar.Button"+j).onRelease = function() {		
		var Index = ((LevelIndexAlbum-1)*nAlbum) + GetNumber(this._name);
		Send2Server("client","0&&&function||selectAlbumBar|~|" + Index,true);
		selectAlbumBar(Index);
		fscommand("FirstSelectTrack");
	};
}
function selectAlbumBar(val_index){	
	if (send_event("normal&&&function||selectAlbumBar|~|" + val_index  + "||0", false)) {
		return;
	}
	ResetTrack();
	BackAlbumInfo._visible = false;
	
	Index = Number(val_index);
	IndexShowAlbum = Index-(Index%nAlbum);
	
	if (resultSearchArtistAlbum.length-IndexShowAlbum >= nAlbum){
		CountAlbum = nArtistName;
	}else{
		CountAlbum = resultSearchArtistAlbum.length % nAlbum;
	}
	
	
	StoreAlbum = resultSearchArtistAlbum[Index].Artist;
	StoreUniAlbum = resultSearchArtistAlbum[Index].uniArtist;
	RecordIndexArtistAlbum = Index;	
	fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
	AlbumBar._visible=false;
	TopBar.ButtonM.onRollOver();
	SelectedItem("AlbumBar",Index%nAlbum,nAlbum);
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
		Send2Server("client","0&&&Click||"+this,true);
		var k = GetNumber(this._name);
		BackAlbumInfo.AlbumRating.text = k;
		fscommand("SetRatingAlbum", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+k);
	};
}


//...........................DESELECT FUNCTION

function SelectedItem(Obj,Index,n){
	for(var j=0;j<n;j++){
		eval(Obj+".Text"+j).textColor=FontColor;		
	}
	eval(Obj+".Text"+Index).textColor=SelectColorValue;
}
function DeselectedItem (Obj,IndexShow,Index,n) {
	for(var j=0;j<n;j++){
		if((IndexShow+j)==Index){

			eval(Obj+".Text"+j).textColor=SelectColorValue;
		}
		else{
			eval(Obj+".Text"+j).textColor=FontColor;
		}
	}
}
//...............
function VisibleSlyIcon(value){
	mini.Register._visible = value;
	for(var j=0;j<NumMovie;j++){
		if(eval(NameAlbum+".Movie"+j)._visible)	eval(NameAlbum+".Logo"+j)._visible=value;
	}
	for(var j=0;j<nGenre;j++){
		if(eval("ArtistNameBar"+".Movie"+j)._visible)eval("ArtistNameBar"+".Logo"+j)._visible=value;
		if(eval("AlbumBar"+".Movie"+j)._visible)eval("AlbumBar"+".Logo"+j)._visible=value;
		if(eval("GenreBar"+".Movie"+j)._visible)eval("GenreBar"+".Logo"+j)._visible=value;
	}
	eval(TrackName).Logo._visible=value;	
}
function Send2Server (sendType,sendCommand,skipIfNoControl) {
	if(skipIfNoControl and (clientType != clonePlayBack)){
		return
	}
	fscommand(sendType, sendCommand);
}

function click_albums(clickIndex,fromServer){
	clickIndex=int(clickIndex);
	
	if (send_event("normal&&&function||click_albums|~|" + clickIndex + "|~|true" + "||0", false)) {
		return;
	}
	if(fromServer=="true"){
		SuiteAction.GotoLevels=4;
		SuiteAction.AlbumIndex=clickIndex;
		SuiteAction.StoredProcedure="RequestNextArtist"
		selectVolBar(int(clickIndex / NumMovie),true);
	}else{
		selectNameAlbum(clickIndex,int(clickIndex / NumMovie),true);
	}
}

function UpdatedatabaseMsgBox(bSuccess,objData){
	if(bSuccess){
		fscommand("flashUpdateFromLocalNetwork",objData);
	}
}