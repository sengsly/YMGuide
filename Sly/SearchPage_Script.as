var ResultArtist=new Array();
var ResultMood=new Array();
var ResultCountries=new Array();
var ResultGenre=new Array();
var ResultDance=new Array();

TopBar._visible=false;
BackAdvance._visible=false;
BackNormal._visible=false;
eval(TrackName)._visible=false;
BackAlbumPic._visible=false;
VolBar._visible=false;
eval(TrackName)._visible=false;
SmallIcon._visible=false;
BBigIcon._visible=false;
BigIcon._visible=false;
SmallIcons._visible=false;
BBigIcons._visible=false;
BigIcons._visible=false;

ArrowBar._visible=false;
ButtonTip._visible=false;
PurchaseCDMode._visible=false;
function VisiblePlay(value) {
	PlayAll._visible = value;
	AlbumInfo._visible = value;
	PreAlbum._visible = value;
	NextAlbum._visible = value;
	ButtonCD._visible=value;
	BackAlbumInfo._visible=false;
}
VisiblePlay(false);
function ListAdvance(Obj){
	BackAdvance.BackListArtist._visible=false;
	BackAdvance.BackListMood._visible=false;
	BackAdvance.BackListDance._visible=false;
	BackAdvance.BackListRating._visible=false;
	BackAdvance.BackListGenre._visible=false;
	BackAdvance.BackListTrack._visible=false;
	eval(Obj)._visible=true;
}
ListAdvance(" ");
var SplAllCountrys=new Array();
var SplAllNames=new Array();
function GetAlbumNum(value){
		if(value.length>0){
			eval(NameAlbum)._visible=false;
			for(var j=0;j<NumMovie;j++){
				eval(NameAlbum+".Pic"+j).unloadMovie();
				eval(NameAlbum+".Picfade"+j).unloadMovie();
			}
			if(DisplayAlbumLong=="true"){//display album as Long Icon......
				if (value == "Small") {
					NumMovie=nSmall;
					NameAlbum = "SmallIcon";
					ScaleW=ScaleSmall;
				} else if (value == "Medium") {
					NumMovie=nMedium;
					NameAlbum = "BigIcon";
					ScaleW=ScaleMedium;
				} else {
					NumMovie = nLarge;
					NameAlbum = "BBigIcon";
					ScaleW=ScaleLarge;
				}
			}
			else{//display album as Short Icon......
				if (value == "Small") {
					NumMovie=nSmalls;
					NameAlbum = "SmallIcons";
					ScaleW=ScaleSmalls;
				} else if (value == "Medium") {
					NumMovie=nMediums;
					NameAlbum = "BigIcons";
					ScaleW=ScaleMediums;
				} else {
					NumMovie = nLarges;
					NameAlbum = "BBigIcons";
					ScaleW=ScaleLarges;
				}
			}
			PicX.length=0;
			PicY.length=0;
			PicX=GetXYcor(NameAlbum,"x");
			PicY=GetXYcor(NameAlbum,"y");
			ActiveButtonAlbum(NameAlbum);
			for(var j=0;j<NumMovie;j++){
				ChangeColor(NameAlbum+".Movie"+j,SetColorValue, ButtonAlpha);
				eval(NameAlbum+".Year"+j).textColor=SelectColorValue;
				eval(NameAlbum+".Artist"+j).textColor=SelectColorValue;
				eval(NameAlbum+".Num"+j).textColor=SelectColorValue;
				eval(NameAlbum+".Letter"+j).textColor=FontColor;
			}

			///.............
			if(MainLevel==3 && VolBar._visible ){
				if(SelectMode=="Artist"){
					resultSearchArrow.length=0;
					resultSearchArrow=SplitResultVol(resultSearchArtistName.length, NumMovie);
					FirstDisplayVol(resultSearchArrow.length,"Arrow");
					ArrowBar.Button0.onRelease();	
				}
				//var Temp=resultSearchArtistAlbum.length;
				//resultSearchArtistAlbum.length=0;
				//resultSearchArtistAlbum.length=Temp;
				resultSearchVol.length=0;
				resultSearchVol=SplitResultVol(resultSearchArtistAlbum.length,NumMovie);
				FirstDisplayVol(resultSearchVol.length,"Vol");
				VolBar.Button0.onRelease();
			}
			else if(MainLevel==2 && ArrowBar._visible){
				resultSearchArrow.length=0;
				resultSearchArrow=SplitResultVol(resultSearchArtistName.length, NumMovie);
				FirstDisplayVol(resultSearchArrow.length,"Arrow");
				ArrowBar.Button0.onRelease();
			}
			
		}
}
//.....................ENTERFRAME.......................................
var SaveAlbumInfo=""
_root.onEnterFrame = function() {
	if(OpenFade=="true")ExecFade ();
	if (Key.isDown(Key.ESCAPE) )Escape();
}
//.............ADD Property.............
function GetValue(){};
_root.addProperty("OpenFrame",_root.GetValue,_root.GetValueOpenFrame);
_root.addProperty("SetAlbumNum",_root.GetValue,_root.GetAlbumNum);
function GetValueOpenFrame(Value){
	if (Value == "true") {
		if(getSplitSt.length>0){
			SplAllCountrys.length=0;
			SplAllNames.length=0;
			var st=StAllCountrys.split("%%");
			for(var j=0;j<st.length;j++){
				var st1=st[j].split("%");
				SplAllCountrys[j]=st1[0];
				SplAllNames[j]=st1[1];
				
			}
			LoadXmlLanguage(getSplitSt);
			getSplitSt="";
			delete(getSplitSt);
			if(parseInt(UnloadIndex,10)>0){
				fscommand("UnloadSwf",UnloadIndex)
			}
		}
		else if(ShowPurchaseBox.length>0){
			VisibleChecked(ShowPurchaseBox);
			delete(ShowPurchaseBox);
		}
		else if(ShowLoading.length>0){
			var spl=ShowLoading.split("%~%");
    		LoadBar.showProgressBar();
//			if(!LoadBar._visible)LoadBar._visible = true;
			LoadBar.txt.text="Downloading... "+ spl[0]+ " cover arts"
			delete(ShowLoading);
		}
		else if(RefreshPicAlbum.length>0){
			var index1=IndexAlbumForDownLoad;
			if(DisplayFromSearch==1){
				StorePathPic="";
				resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
			}
			else{
				var index=index1%NumMovie
				resultSearchArtistAlbum[index1].ReservePath=resultSearchArtistAlbum[index1].Path;
				if(StoreIndexVol1+index==index1){
					if(eval(NameAlbum+".Pic"+Index)._alpha<=0)eval(NameAlbum+".PicFade"+Index).loadMovie(resultSearchArtistAlbum[index1].Path)
					else eval(NameAlbum+".Pic"+Index).loadMovie(resultSearchArtistAlbum[index1].Path)
				}
			}
			delete(IndexAlbumForDownLoad);
			DisplayAlbumPictrueInfo(index1);
			delete(RefreshPicAlbum);
		}
		else if(RefreshPicAlbumRip.length>0){
			var index1=IndexAlbumForDownLoad;
			if(resultSearch[index1].PathPic==RefreshPicAlbumRip){
				if(DisplayFromSearch==1){
					StorePathPic="";
					resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
				}
				else{
					var index=index1%NumMovie
					resultSearchArtistAlbum[index1].ReservePath=resultSearchArtistAlbum[index1].Path;
					if(StoreIndexVol1+index==index1){
						if(eval(NameAlbum+".Pic"+Index)._alpha<=0)eval(NameAlbum+".PicFade"+Index).loadMovie(resultSearchArtistAlbum[index1].Path)
						else eval(NameAlbum+".Pic"+Index).loadMovie(resultSearchArtistAlbum[index1].Path)
					}
				}
				DisplayAlbumPictrueInfo(index1);
			}
			delete(IndexAlbumForDownLoad);
			delete(RefreshPicAlbumRip);
		}
		else if(SetAlbumCover.length>0){
			if(MainLevel==3 || MainLevel==4 ){
				DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
			}
			else if(MainLevel==2){
				//DisplayMovieArtistItem(NameAlbum, IndexShowArrow, CountArrow, resultSearchArtistName);
				DisplayMovieArtistItem(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
			}
			delete(SetAlbumCover);
		}
		else if (getTextSearch.length>0){			
			start_searchs(getTextSearch,SelectMode0,ChangeLan,LanName);			
			delete (getTextSearch);
											
		}
		else if(StartSearch.length>0){
			if(BackNormal._visible)BackNormal.ButtonSearch.onRelease();
			else if(BackAdvance._visible)BackAdvance.ButtonSearch.onRelease();
			StartSearch="";
			delete(StartSearch);
			}
			
		else if(GetArtistName.length>0){
			ResultArtist=SplitString(GetArtistName);
			FirstDisplayArtist(ResultArtist.length);
			GetArtistName="";
			delete(GetArtistName);
			
		}
		else if(GetMood.length>0){
			ResultMood=SplitString(GetMood);
			FirstDisplayMood(ResultMood.length);
			GetMood="";
			delete(GetMood);
		}
		else if(GetGenre.length>0){
			ResultGenre=SplitGenre(GetGenre);
			FirstDisplayGenre(ResultGenre.length);
			GetGenre="";
			delete(GetGenre);
		}
		else if(RequestCountry.length>0){
			ResultCountries=SplitCountries(RequestCountry);
			FirstDisplayCountries(ResultCountries.length);
			delete(RequestCountry);
		}
		else if(GetDance.length>0){
			ResultDance=SplitString(GetDance);
			FirstDisplayDance(ResultDance.length);
			GetDance="";
			delete(GetDance);
		}
		else if(StResult.length>0){
			SearchingBox._visible=false;
			ButtonHideMouse._visible=false;
//			SelectMode="Song";
			ArrowBar._visible=false;
			VolBar._visible=false;
			eval(NameAlbum)._visible=false;
			if(StResult=="Found0"){
				FirstDisplayTrack(0);
			}
			else{
				MainLevel=4;
				DisplayFromSearch=1;
//				resultSearchArtistName.length=0;
//				resultSearchArtistAlbum.length=0
				resultSearch.length=0;
				if(parseInt(LenRe,10)>0){
					TopBar.ButtonM.onRollOver();
					SplitResult(StResult); 
				    	FirstDisplayTrack(parseInt(LenRe,10))
					eval(TrackName + ".chkDisplay").visibleIcon(boolShowCoverIcon);
					LenRe=0;
				}
				else{
					SplitResult(StResult);
					DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
				}
				if(BackNormal._visible || BackAdvance._visible){
					BackNormal._visible=false;
					BackAdvance._visible=false;
//					InputText._visible=false;
					fscommand("ShowTextSearch","no");
				}
				KeyBoard._visible=false;
				//Request track availale yellow color from server			
				var stringIDs= new Array();
				for(var i=0;i<resultSearch.length;i++){stringIDs.push(resultSearch[i].trackID);}
				if(clientType<>serverMode){
					fscommand("clients","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
				}else{
					fscommand("servers","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
				}
				delete(stringIDs);
				//----------------------------------------------
			}
			delete(StResult);
		}
		else if (GetArtistNameSearch.length>0) {
			if(GetArtistNameSearch=="Found0"){
				ArrowBar._visible=false;
				VolBar._visible=false;
				eval(TrackName)._visible=false;
				BackAlbumPic._visible=false;
				eval(NameAlbum)._visible=false;
				VisiblePlay(false);
				GetArtistNameSearch = "";
				delete(GetArtistNameSearch);
			}
			else{
				resultSearchArtistAlbum.length=0
				resultSearch.length=0;
//				SelectMode="Artist";
				MainLevel=2;
				VolBar._visible=false;
				eval(TrackName)._visible=false;
				BackAlbumPic._visible=false;
				VisiblePlay(false);
				resultSearchArrow.length=0;
				SplitResultArtistName(GetArtistNameSearch, "");
				//FirstDisplayMovie(resultSearchArtistName.length);
				resultSearchArrow=SplitResultVol(resultSearchArtistName.length, NumMovie);
				FirstDisplayVol(resultSearchArrow.length,"Arrow");
				
				ArrowBar.Button0.onRelease();
				//........................
				delete(GetArtistNameSearch);
				BackNormal._visible=false;
				BackAdvance._visible=false;
//				InputText._visible=false;
				KeyBoard._visible=false;
				TopBar.ButtonM.onRollOver();
				if(resultSearchArtistName.length==1){
					eval(NameAlbum+".Button0").onRelease();
					ArrowBar._visible=false;
				}
				else ArrowBar._visible=true;
			}
		}
		else if (GetAlbumSearch.length>0) {
			ArrowBar._visible=false;
			eval(TrackName)._visible=false;
			BackAlbumPic._visible=false;
			VisiblePlay(false);
			MainLevel=3;
				
			if(GetAlbumSearch=="Found0" ){
				resultSearchVol.length=0;
				FirstDisplayVol(resultSearchVol.length,"Vol");
				eval(NameAlbum)._visible=false;
				delete(GetAlbumSearch);
			}
			else{
				resultSearch.length=0;
				MainLevel=3;
				VolBar._visible=true;
				resultSearchVol.length=0;
				NumAlbum=parseInt(AlbumLengthSearch, 10);
				resultSearchVol=SplitResultVol(NumAlbum, NumMovie);
				FirstDisplayVol(resultSearchVol.length,"Vol");
				resultSearchArtistAlbum.length=0;
				resultSearchArtistAlbum.length=NumAlbum;
				delete(GetAlbumSearch);
				VolBar.Button0.onRelease();
				eval(NameAlbum+".Button0").onRollOver();
				BackNormal._visible=false;
				BackAdvance._visible=false;
//				InputText._visible=false;
				KeyBoard._visible=false;
			}
		}
		else if(ResultAlbumName.length>0){
			SplitResultArtistName(ResultAlbumName,"Yes",StoreAlbumByIndex);
			if(ShowAlbumPic=="Yes"){
				ShowMovieArtist(NameAlbum, StoreAlbumByIndex, StoreAlbumByCount, resultSearchArtistAlbum);
				requestAlbumAvailable(StoreAlbumByIndex,StoreAlbumByCount);
			}
			else{
				StoreAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
				StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
				if(ChangeLan=="Eng"){
					//TextTip.text = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
					popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist);
				}else{
					//TextTip.text = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
					popup_tooltip("TextTip:ButtonTip",resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist);
				}
				ChangeProTitleFont("TextTip",EngFont, UniFont, EngSize, UniSize, ChangeLan);
				ButtonTip._width=TextTip._width+10;
				if(!ButtonTip._visible){
					ButtonTip._visible=true;
					TextTip._visible=true;
				}
				fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
			}
			delete(ShowAlbumPic);
			delete(ResultAlbumName);
		}
		else if (GetArtistTrackInfo!=undefined) {
			eval(NameAlbum)._visible = false;
			MainLevel = 4;
			VolBar._visible=false;
			if (GetArtistTrackInfo!=""){
				SplitResultTrack(GetArtistTrackInfo);
			}else{
				resultSearch.length=0;
			}
			DisplayFromSearch=0;
			FirstDisplayTrack(resultSearch.length);
			//Request track availale yellow color from server			
			var stringIDs= new Array();
			for(var i=0;i<resultSearch.length;i++){stringIDs.push(resultSearch[i].trackID);}
			if(clientType<>serverMode){
				fscommand("clients","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
			}else{
				fscommand("servers","requestTrackAvailable&&&"+stringIDs + "&&&" + LanName);
			}
			eval(TrackName).PlayTrailer._visible = (GetTrailerAvailable==1)			//Show play trailer button
			eval(TrackName).fileType.AvailableType	=	PlayFileFrom
			eval(TrackName).fileType.setfileType(eval(TrackName).fileType.searchForDefault())					//Show large medium small
			eval(TrackName).PlusIcon.Available=(resultSearchArtistAlbum[RecordIndexArtistAlbum].MyFav == "1");
			eval(TrackName + ".chkDisplay").visibleIcon(boolShowCoverIcon);
			
			delete(stringIDs);
			//----------------------------------------------
			
			delete(GetArtistTrackInfo);
		}
		else if (GetArtistAlbumInfo.length>0) {
			SaveAlbumInfo=GetArtistAlbumInfo;
			if(iKhmer=="1"){
				ChangeAlbumInfoFont(EngFont, UniFont, EngSize, StaticFontKhmerSize, ChangeLan, SaveAlbumInfo);
			}
			else ChangeAlbumInfoFont(EngFont, UniFont, EngSize, UniSize, ChangeLan,SaveAlbumInfo);
			GetArtistAlbumInfo = "";
			delete(GetArtistAlbumInfo);
		}
		else if(ShowLogo.length>0){
			if(Isregistered=="False")VisibleSlyIcon(true);
			delete(ShowLogo);
		}
		else if (DatabasePath.length>0) {
			if(UpdateDB._visible)UpdateDB.Text.text = DatabasePath;
			else if(BackUpDB._visible)BackUpDB.Path.text=DatabasePath;
			else if(RestoreDB._visible)RestoreDB.Path.text=DatabasePath;
			else if(CopyMusic._visible)CopyMusic.Text1.text=DatabasePath;
			delete(DatabasePath);
		}
		else if(CopyMusicDes.length>0){
			CopyMusic.Text2.text=CopyMusicDes;
			delete(CopyMusicDes);
		}
		else if(CompleteDownloadScreen.length>0){
			delete(CompleteDownloadScreen);
			AddNewScreens._visible=false;
			AddNewScreens.LoadBar._visible = false;
			ButtonHideMouse._visible=false;
			TopBar.ButtonX.onRollOver();
		}
		else if(ProUpdate.length>0){
			if(CopyMusic._visible){
				Running("CopyMusic.Progess",int(ProUpdate));
				if(int(ProUpDate)>=100){
					CopyMusic._visible=false;
					ButtonHideMouse._visible=false;
					Running("CopyMusic.Progess",0);
					CopyMusic.Progess._visible=false;
					TopBar.ButtonX.onRollOver();
				}
			}
			delete(ProUpdate);
		}
		/*else if(CompletedUpdate.length>0){
			UpdateDB.LoadBar._visible=false;
			UpdateDB.ButtonOk.enabled=true;
			UpdateDB.ButtonCancel.enabled=true;
			UpdateDB.PatientText._visible=false;
			UpdateDB._visible=false;
			TopBar.ButtonM.onRollOver();
			ButtonHideMouse._visible=false;
			delete(CompletedUpdate);
			fscommand("CompleteUpdate");
		}*/
		else if(openCover.length>0){
			TopBar.ButtonX.onRollOver();
			ButtonHideMouse._visible=false;
			delete(openCover);
		}
	}
}
function msgbox (st) {
	fscommand("reply",st);
}

function ExecFade () {
	if (Gom) {
		for (var jReset = 0; jReset<Numfade; jReset++) {
			eval(Name1+jReset)._alpha -= Alpha;
			eval(Name+jReset)._alpha += Alpha;
		}
		if (eval(Name1+0)._alpha<40) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name1+jReset).unloadMovie();
			}
		}
		if (eval(Name+0)._alpha>=100) {
			Gom = false;
		}
	} else if (Gom1) {
		for (var jReset = 0; jReset<Numfade; jReset++) {
			eval(Name1+jReset)._alpha += Alpha;
			eval(Name+jReset)._alpha -= Alpha;
		}
		if (eval(Name+0)._alpha<40) {
			for (var jReset = 0; jReset<Numfade; jReset++) {
				eval(Name+jReset).unloadMovie();
			}
		}
		if (eval(Name1+0)._alpha>=100) {
			Gom1 = false;
		}
	}
	
}
var Name;
var Name1;
var NameFade;
var Gom = false;
var Gom1 = false;
var PicName = new Array();
var Numfade = 0;
var Alpha = 40;
function Reset(n) {
	Numfade = n;
	OpenFade="true";
	if (eval(Name+0)._alpha<=0) {
		FadeTrue=false;
		for (var jReset = 0; jReset<n; jReset++) {
			eval(Name+jReset)._alpha = 0;
			eval(Name1+jReset)._alpha = 100;
			eval(Name+jReset)._visible = true;
			eval(NameFade+jReset)._visible = true;
			//eval(Name+jReset).unloadMovie();
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
			//eval(Name1+jReset).unloadMovie();
			eval(Name1+jReset).loadMovie(PicName[jReset]);
		}
		Gom1 = true;
		Gom = false;
	}
}
///	 END FUNCTION RESET()		\\\
var PicX=new Array();
var PicY=new Array();
var RecordIndexArtistAlbum=0;
var NumAlbum=0;

function click_button_album(ind,val_ChangeLan,val_MainLevel){
	
	if (send_event("normal&&&function||click_button_album|~|" + ind + "|~|" + val_ChangeLan + "|~|" + val_MainLevel +"||2", false)) {
		return;
	}
	ind = int(ind);
	ChangeLan = val_ChangeLan;
	MainLevel = val_MainLevel;
	if(ChangeLan=="Uni"){
		if(BackNormal._visible)BackNormal._visible=false;
		if(BackAdvance._visible)BackAdvance._visible=false;
		fscommand("ShowTextSearch","no");		
	}
	if (MainLevel == 2) {
		var spl = resultSearchArrow[RecordIndexArrow].split(":");
		//var Index = (parseInt(spl[0], 10)-1) + GetNumber(this._name);
		var Index = ind;
		var IndexMode;
		StoreArtistName = resultSearchArtistName[Index].Artist;
		StoreUniArtistName = resultSearchArtistName[Index].uniArtist;
		RecordIdArtistName=resultSearchArtistName[Index].id;
		
		if(RecordIndexAva==1){
			IndexMode=1;
		}else if(RecordIndexAva==2){
			IndexMode=0;
		}else {
			IndexMode=3;
		}
		if(SelectMode=="Artist"){
			if(DisplayArtistMode==0){
				fscommand("GetArtistAlbum",RecordIdArtistName+"~"+IndexMode+"~"+RecordIndexRating);
			}else{
				fscommand("GetArtistTrack",RecordIdArtistName+"~"+IndexMode+"~"+RecordIndexRating);
			}
		}else{
			fscommand("GetDirectorAlbum",RecordIdArtistName+"~"+IndexMode);
		}
	} else if (MainLevel == 3) {
		MainLevel=4;
		var spl = resultSearchVol[RecordIndexVol].split(":");
		RecordIndexArtistAlbum = ind;
		StoreAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
		StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
		fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
		eval(TrackName).Button0.onRollOver();
	}
}

function ActiveButtonAlbum(Obj) {	
	for (var j = 0; j<NumMovie; j++) {
		eval(NameAlbum+".Button"+j).onRollOver = function() {			
				var IndexAlbum = GetNumber(this._name);				
				var tf = new TextFormat();
				var tmpLan="Eng";

				if (DisplayAlbumLong=="true"){
					//TextTip.text = eval(NameAlbum+".Letter"+IndexAlbum).valText;//eval(NameAlbum+".Letter"+IndexAlbum).text;
					displayText=eval(NameAlbum+".Letter"+IndexAlbum).valText
					popup_tooltip("TextTip:ButtonTip",displayText);

				}else{
					//TextTip.text = eval(NameAlbum+".Letter"+IndexAlbum).text;
					displayText=eval(NameAlbum+".Letter"+IndexAlbum).text;
					popup_tooltip("TextTip:ButtonTip",displayText);
				}
				tf= eval(NameAlbum+".Letter"+IndexAlbum).getTextFormat();
				if (tf.font !="Arial")
					tmpLan="Uni";
				
				ChangeProTitleFont("TextTip",EngFont, UniFont, EngSize, UniSize, tmpLan);
				ButtonTip._width=TextTip._width+10;
				if(!ButtonTip._visible){
					ButtonTip._visible=true;
					TextTip._visible=true;
				}
				SelectButton(NameAlbum+".Movie"+IndexAlbum);
				SelectLevel=30;
		};
		eval(NameAlbum+".Button"+j).onRelease = function() {
			click_button_album((parseInt(spl[0], 10)-1)+GetNumber(this._name),ChangeLan,MainLevel);
		}
		//.........................MyFavorite..............
		eval(NameAlbum+".Plus"+j).onRollOver=function(){
			var k=GetNumber(this._name);
			eval(NameAlbum+".Plus"+k+".Selected")._visible=true;
			DisplayTooltip(this,"txtTooltip","Set Favorite",SHTT,-(117.3/2)+50,50);
		}
		eval(NameAlbum+".Plus"+j).onRollOut=function(){
			HideTooltip("txtTooltip");
			var k=GetNumber(this._name);
			if(MainLevel==2){
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if(resultSearchArtistName[Index].MyFav=="1"){
					eval(NameAlbum+".Plus"+k+".Selected")._visible=true;
				}
				else{
					eval(NameAlbum+".Plus"+k+".Selected")._visible=false;
				}
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if(resultSearchArtistAlbum[Index].MyFav=="1"){
					eval(NameAlbum+".Plus"+k+".Selected")._visible=true;
				}
				else{
					eval(NameAlbum+".Plus"+k+".Selected")._visible=false;
				}
			}
		}
		eval(NameAlbum+".Plus"+j).onRelease=function(myFav){
			var k=GetNumber(this._name);
			if(MainLevel==2){
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if(String(myFav)==""){
					MyFav=resultSearchArtistName[Index].MyFav;
				}
				if (send_event("normal&&&Click||" + this +"|~|"+ myFav + "||2", false)) {
					return;
				}
				
				if(MyFav=="1"){
					eval(NameAlbum+".Rank"+k)._visible=false;
					resultSearchArtistName[Index].MyFav="0";
					eval(NameAlbum+".Plus"+k+".Selected")._visible=false;
					fscommand("SetArtistFavorite",resultSearchArtistName[Index].id+"~"+0);
				}
				else{
					eval(NameAlbum+".Rank"+k)._visible=true;
					resultSearchArtistName[Index].MyFav="1";
					eval(NameAlbum+".Plus"+k+".Selected")._visible=true;
					fscommand("SetArtistFavorite",resultSearchArtistName[Index].id+"~"+1);
				}
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				if(String(myFav)==""){
					MyFav=resultSearchArtistAlbum[Index].MyFav;
				}
				if (send_event("normal&&&Click||" + this +"|~|"+ myFav + "||2", false)) {
					return;
				}
				if(MyFav=="1"){
					eval(NameAlbum+".Rank"+k)._visible=false;
					resultSearchArtistAlbum[Index].MyFav="0";
					eval(NameAlbum+".Plus"+k+".Selected")._visible=false;
					fscommand("SetAlbumFavorite",resultSearchArtistAlbum[Index].id+"~"+0);
				}
				else{
					eval(NameAlbum+".Rank"+k)._visible=true;
					resultSearchArtistAlbum[Index].MyFav="1";
					eval(NameAlbum+".Plus"+k+".Selected")._visible=true;
					fscommand("SetAlbumFavorite",resultSearchArtistAlbum[Index].id+"~"+1);
				}
			}
		}
		//...............RankArtist.................
		eval(NameAlbum+".Rank"+j+".Button").onRollOver=function(){
			DisplayTooltip(this,"txtTooltip","Set Favorite Ranking",SHTT,-(117.3/2)+50,50);
			var k=GetNumber(String(this._parent));
			if(!eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible){
				eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=true;
				eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=true;
			}
		}
		eval(NameAlbum+".Rank"+j+".Button").onRollOut=function(){
			HideTooltip("txtTooltip");
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=false;
		}
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRollOver=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=true;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=true;			
		}
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRollOut=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=false;			
		}
		
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRollOver=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=true;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=true;
		}
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRollOut=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".ButtonLeft")._visible=false;
			eval(NameAlbum+".Rank"+k+".ButtonRight")._visible=false;
		}
	//......
		eval(NameAlbum+".Rank"+j+".Button").onRelease=function(){
			var k=GetNumber(String(this._parent));
			selection.setFocus(eval(NameAlbum+".Rank"+k+".Text"));
		}
		eval(NameAlbum+".Rank"+j+".Text").onChanged=function(){
			var k=GetNumber(String(this._parent));
			if(MainLevel==2){ 
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue",resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		}
		eval(NameAlbum+".Rank"+j+".ButtonLeft").onRelease=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".Text").text=int(eval(NameAlbum+".Rank"+k+".Text").text)-1;
			if(eval(NameAlbum+".Rank"+k+".Text").text<0){
				eval(NameAlbum+".Rank"+k+".Text").text=0;
			}
			if(MainLevel==2){ 
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue",resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		}
		eval(NameAlbum+".Rank"+j+".ButtonRight").onRelease=function(){
			var k=GetNumber(String(this._parent));
			eval(NameAlbum+".Rank"+k+".Text").text=int(eval(NameAlbum+".Rank"+k+".Text").text)+1;
			if(MainLevel==2){ 
				var spl = resultSearchArrow[RecordIndexArrow].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistName[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValue",resultSearchArtistName[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
			else if(MainLevel==3){
				var spl = resultSearchVol[RecordIndexVol].split(":");
				var Index = (parseInt(spl[0], 10)-1)+k;
				resultSearchArtistAlbum[Index].Rank=eval(NameAlbum+".Rank"+k+".Text").text;
				fscommand("ChangeRankValueAlbum",resultSearchArtistAlbum[Index].id+"~"+eval(NameAlbum+".Rank"+k+".Text").text);
			}
		}
		
	}
}
//................................DISPLAY ARTISTALBUM..................................
function DisplayItemVol (Obj,Index,Count,nItem,Value) {
	if(Obj=="VolBar")HighLightText ("VolBar",IndexShowVol,RecordIndexVol,nVol);
	else if(Obj=="ArrowBar")HighLightText ("ArrowBar",IndexShowArrow,RecordIndexArrow,nVol);
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

function FirstDisplayVol(n,Obj){
	if(Obj=="Vol"){
		VolBarArrow(n,"VolBar");
		FirstDisplay("Vol",n,nVol);
		DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
		eval("VolBar")._visible=n>0;
	}
	else{
		VolBarArrow(n,"ArrowBar");
		FirstDisplay("Arrow",n,nVol);
		DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
		eval("ArrowBar")._visible=n>0;
	}
	
}
VolBar.ButtonLeft.onRollOver=function(){
	SelectButton("VolBar.MovieLeft");
	SelectLevel=4;
	Buttontip._visible = false;
	TextTip._visible = false;
}
VolBar.ButtonRight.onRollOver=function(){
	SelectButton("VolBar.MovieRight");
	SelectLevel=4;
		Buttontip._visible = false;
     	TextTip._visible = false;
	
}

VolBar.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
	
	ClickLeft("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
}
VolBar.ButtonRight.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
	
	ClickRight("Vol");
	DisplayItemVol ("VolBar",IndexShowVol,CountVol,nVol,resultSearchVol);
}
var StoreIndexVol1=0;
var StoreCountVol1=0;
var IndexNameVol=0;

var IndexNameArrow=0;
var RecordIndexArrow = 0;
var	RecordLevelArrow = 0;
var StoreIndexArrow1=0;
var StoreCountArrow1=0;

var StoreAlbumByIndex=0;
var	StoreAlbumByCount=0;

function click_volbars(ind,noSend){
	if (!noSend)
	{	if (send_event("normal&&&function||click_volbars|~|" + ind + "||2",false)){
			return;
		}
	}
	ind = int(ind);
	var IndexName = ind;
	IndexNameVol=int(IndexName);
	var Index = IndexShowVol+IndexName;
	RecordIndexVol = Index;
	RecordLevelVol = LevelIndexVol;
	//Highlight text........
	HighLightText ("VolBar",IndexShowVol,RecordIndexVol,nVol);
	//............
	spl = resultSearchVol[RecordIndexVol].split(":");
	Index = parseInt(spl[0], 10);
	var count = parseInt(spl[1], 10)-index;
	eval(NameAlbum)._visible = true;
	StoreIndexVol1=Index-1;
	StoreCountVol1=count+1;
	StoreAlbumByIndex=StoreIndexVol1;
	StoreAlbumByCount=StoreCountVol1;
	if(ConfirmIdAlbum(StoreIndexVol1,StoreCountVol1)){
		fscommand("GetAlbumByIndex",StoreIndexVol1+"~"+StoreCountVol1+"~"+"Yes"+"~"+SelectMode);
	}
	else{
		ShowMovieArtist(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
	}
}




for (var j = 0; j<nVol; j++) {
	eval("VolBar.Button"+j).onRollOver = function() {
		var IndexName = GetNumber(this._name);
		SelectButton("VolBar.Movie"+IndexName);
		SelectLevel = 4;
			Buttontip._visible = false;
        	TextTip._visible = false;
	};
	eval("VolBar.Button"+j).onRelease = function() {
		click_volbars(GetNumber(this._name));
	};
	//.......................Arrow....................
	eval("ArrowBar.Button"+j).onRollOver = function() {
		var IndexName = GetNumber(this._name);
		SelectButton("ArrowBar.Movie"+IndexName);
		SelectLevel=40;
	};
	eval("ArrowBar.Button"+j).onRelease = function() {
		var IndexName = GetNumber(this._name);
		IndexNameArrow=int(IndexName);
		var Index = IndexShowArrow+IndexName;
		RecordIndexArrow = Index;
		RecordLevelArrow = LevelIndexArrow;
		HighLightText ("ArrowBar",IndexShowArrow,RecordIndexArrow,nVol);
		spl = resultSearchArrow[RecordIndexArrow].split(":");
		Index = parseInt(spl[0], 10);
		var count = parseInt(spl[1], 10)-index;
		StoreIndexArrow1=Index-1;
		StoreCountArrow1=count+1;
		if(resultSearchArtistName.length==1)eval(NameAlbum)._visible = false;
		else eval(NameAlbum)._visible = true;
		ShowMovieArtist(NameAlbum, StoreIndexArrow1, StoreCountArrow1, resultSearchArtistName);
		for(var i=0;i<StoreCountArrow1;i++){
			//***
			Index=StoreIndexArrow1+i;
			if(resultSearchArtistName[Index].SetPic==0){
				resultSearchArtistName[Index].SetPic=1;
				fscommand("SearchPathImage",resultSearchArtistName[Index].Path+"%~%"+"Artist"+"%~%"+Index+"%~%"+resultSearchArtistName[Index].StringPath+"%~%"+LanName);
			}
		}
	};
}
//............................SHOWMOVIEALBUM..........................
/*function FirstDisplayMovie(n){
	FirstDisplay("Arrow",n,NumMovie);
	ShowMovieArtist(NameAlbum, IndexShowArrow, CountArrow, resultSearchArtistName);
}*/
ArrowBar.ButtonLeft.onRollOver=function(){
	SelectButton("ArrowBar.MovieLeft");
	SelectLevel=40;
}
ArrowBar.ButtonRight.onRollOver=function(){
	SelectButton("ArrowBar.MovieRight");
	SelectLevel=40;
}

ArrowBar.ButtonLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
	ClickLeft("Arrow");
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
	
}
ArrowBar.ButtonRight.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||2",false)){
		return;
	}
	ClickRight("Arrow");
	DisplayItemVol ("ArrowBar",IndexShowArrow,CountArrow,nVol,resultSearchArrow);
}

function ShowMovieArtist(Na1, Index, Count, ValPic) {
	var Index1=Index;
	Name = Na1+".Pic";
	Name1 = Na1+".PicFade";
	NameFade = Na1+".Movie";
	PicName.length = 0;
	for (var j = 0; j<NumMovie; j++) {
		if (j<Count) {
			//PicName[j] = ValPic[Index1].Path;
			PicName[j] = ValPic[Index1].ReservePath;
			Val1 += 1;
		} 
		Index1 += 1;
	}
	Reset(PicName.length);
	DisplayMovieArtistItem(Na1, Index, Count, ValPic);

}
function DisplayMovieArtistItem(Na1, Index, Count, ValPic) {
	var boolLanguageKhmer;				//Album Title
	var boolKhmerArtist;				//Artist Name
	for (var j = 0; j<NumMovie; j++) {
		var objFlag=eval(Na1+".FlagGroup"+j);
		var objDTS=eval(Na1+".DTS"+j);
		if (j<Count) {
			eval(Na1+".Movie"+j)._visible = true;
			eval(Na1+".Pic"+j)._visible = true;
			eval(Na1+".PicFade"+j)._visible = true;
			eval(Na1+".Button"+j)._visible = true;
			
			if(Isregistered=="False") eval(Na1+".Logo"+j)._visible = true;
			else eval(Na1+".Logo"+j)._visible = false;
			if(PlusCover=="Yes" || DisplayAlbumLong=="true"){
				eval(Na1+".Plus"+j)._visible = true;
				eval(Na1+".Rank"+j+".Text").text=ValPic[Index].Rank;
				
				if(ValPic[Index].MyFav=="1"){
					eval(Na1+".Rank"+j)._visible=true;
					eval(Na1+".Plus"+j+".Selected")._visible = true;
				}
				else {
					eval(Na1+".Rank"+j)._visible=false;
					eval(Na1+".Plus"+j+".Selected")._visible = false;
				}
				if(MainLevel!=2){
					objFlag.ShowFlag(ValPic[Index].Flagid);
					
					album_status(eval(Na1+".CDIcon"+j),ValPic[Index].Ava)
					eval(Na1+".CDIcon"+j)._visible=ValPic[Index].Ava!=0;
//					if(ValPic[Index].Ava=="1")eval(Na1+".CDIcon"+j)._visible=true;
//					else eval(Na1+".CDIcon"+j)._visible=false;
				}
				else{
					eval(Na1+".CDIcon"+j)._visible=false;
				}
				
			}
			else{
				eval(Na1+".Plus"+j)._visible = false;
				eval(Na1+".Rank"+j)._visible=false;
				eval(Na1+".CDIcon"+j)._visible=false;
			}
			boolLanguageKhmer=false;		//Default to english
			boolKhmerArtist = false;		//Default to english	
			if (ChangeLan == "Eng") {	
				if(StringsubList=="actor"){
					SubDisplayName=ValPic[Index].Actor;
				}else if(StringsubList=="director"){
					SubDisplayName=ValPic[Index].Director;
				}else{//in artist mode
					SubDisplayName=ValPic[Index].ArtistName;
				}

				eval(Na1+".Letter"+j).or_text = ValPic[Index].Artist;
				eval(Na1+".Letter"+j).text = ValPic[Index].Artist;
				eval(Na1+".Artist"+j).text = SubDisplayName;				
			} else {
				if(StringsubList=="actor"){
					SubDisplayName=ValPic[Index].Actor;
				}else if(StringsubList=="director"){
					SubDisplayName=ValPic[Index].Director;
				}else{//in artist mode
					if(ValPic[Index].unicodeArtistName==""){
						SubDisplayName=ValPic[Index].ArtistName;
					}else{
						boolKhmerArtist =true;			//Khmer font
						SubDisplayName=ValPic[Index].unicodeArtistName;
					}
				}
				eval(Na1+".Artist"+j).text = SubDisplayName;

				if(ValPic[Index].uniArtist==""){
					eval(Na1+".Letter"+j).or_text = ValPic[Index].Artist;
					eval(Na1+".Letter"+j).text = ValPic[Index].Artist;
					//eval(Na1+".Artist"+j).text = SubDisplayName;
				}
				else {
					boolLanguageKhmer=(iKhmer=="1");
					eval(Na1+".Letter"+j).or_text = ValPic[Index].uniArtist;
					eval(Na1+".Letter"+j).text = ValPic[Index].uniArtist;
					//eval(Na1+".Artist"+j).text = ValPic[Index].unicodeArtistName;
				}
			}
			if (DisplayAlbumLong=="true"){
				eval(Na1+".Letter"+j).text= (Index+1) +  (boolLanguageKhmer ? ">" : "." )  + eval(Na1+".Letter"+j).text
			}
			
			ChangeMovieFont (EngFont, UniFont, EngSize, UniSize,j,!boolLanguageKhmer);
			ChangeArtistFont(EngFont, UniFont, EngSize, UniSize,j,!boolKhmerArtist);
			eval(Na1+".Year"+j).text=ValPic[Index].Year;
			if (AlbumCover == "Yes" ||DisplayAlbumLong=="true") {
				var boolShowYear=(Grouping=="False") and (SelectMode!="Artist") and MainLevel==3;
				eval(Na1+".Year"+j)._visible = boolShowYear;
				eval(Na1+".ybg"+j)._visible = boolShowYear;
				eval(Na1+".Letter"+j)._visible = true;
				eval(Na1+".CoverLetter"+j)._visible = true;
				if(MainLevel!=2)eval(Na1+".Artist"+j)._visible=true;
				else eval(Na1+".Artist"+j)._visible=false;
			} else {
				eval(Na1+".Year"+j)._visible = false;
				eval(Na1+".ybg"+j)._visible = false;
				eval(Na1+".Letter"+j)._visible = false;
				eval(Na1+".CoverLetter"+j)._visible = false;
				eval(Na1+".Artist"+j)._visible=false;
			}
			eval(Na1+".Num"+j).text = Index+1;
			if (NumCover == "Yes" ||DisplayAlbumLong=="true") {
				eval(Na1+".Num"+j)._visible = true;
				eval(Na1+".CoverNum"+j)._visible = true;
			} else {
				eval(Na1+".Num"+j)._visible = false;
				eval(Na1+".CoverNum"+j)._visible = false;
			}
			//only show when in Music or TVSeries //2006.05.25 Seng
			objFlag._visible=(NumCover=="Yes") and MainLevel==3 and (databaseType==1 or databaseType==2);
			
			objFlag.ShowFlag(resultSearchArtistAlbum[RecordIndexArtistAlbum].FlagID);
			objDTS._visible=(ValPic[Index].AudioID.indexOf(';3;')>=0) and (NumCover=="Yes") and MainLevel==3;
			Val1 += 1;
		} else {
			objFlag._visible=false;
			objDTS._visible=false;
			eval(Na1+".Movie"+j)._visible = false;
			eval(Na1+".Pic"+j)._visible = false;
			eval(Na1+".PicFade"+j)._visible = false;
			eval(Na1+".PicFade"+j).unloadMovie();
			eval(Na1+".PicF"+j).unloadMovie();
			eval(Na1+".Button"+j)._visible = false;
			eval(Na1+".Letter"+j)._visible = false;
			eval(Na1+".CoverLetter"+j)._visible = false;
			eval(Na1+".Num"+j)._visible = false;
			eval(Na1+".Plus"+j)._visible = false;
			eval(Na1+".CoverNum"+j)._visible = false;
			eval(Na1+".Rank"+j)._visible=false;
			eval(Na1+".CDIcon"+j)._visible=false;
			eval(Na1+".Logo"+j)._visible = false;
			eval(Na1+".Year"+j)._visible = false;
			eval(Na1+".ybg"+j)._visible = false;
			eval(Na1+".Artist"+j)._visible = false;
		}
		Index += 1;
	}
//	ChangeAlbumFont(EngFont, UniFont, EngSize, UniSize, ChangeLan);
}

//..................
ButtonTest.onRelease=function(){
	fscommand("GetArtistNameSearch");
}
ButtonTest1.onRelease=function(){
	fscommand("GetAlbumSearch");
}
//////..........................................................
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
VolBar.ButtonArrowLeft.onRollOver=function(){
	SelectButton("VolBar.MovieArrowLeft");
	SelectLevel=4;
	Buttontip._visible = false;
	TextTip._visible = false;
}
VolBar.ButtonArrowRight.onRollOver=function(){
	SelectButton("VolBar.MovieArrowRight");
	SelectLevel=4;
	Buttontip._visible = false;
	TextTip._visible = false;
}
VolBar.ButtonArrowLeft.onRelease=function(){
	if (send_event("normal&&&Click||" + this + "||2",false)){
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
	if (send_event("normal&&&Click||" + this + "||2",false)){
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

//...............Arrow......................
ArrowBar.ButtonArrowLeft.onRollOver=function(){
	SelectButton("ArrowBar.MovieArrowLeft");
	SelectLevel=40;
}
ArrowBar.ButtonArrowRight.onRollOver=function(){
	SelectButton("ArrowBar.MovieArrowRight");
	SelectLevel=40;
}
ArrowBar.ButtonArrowLeft.onRelease=function(){
	
	if (send_event("normal&&&Click||" + this + "||2",false)){
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
	
	if (send_event("normal&&&Click||" + this + "||2",false)){
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


//................
function VisibleSlyIcon(value){
	for(var j=0;j<NumMovie;j++){
		if(eval(NameAlbum+".Movie"+j)._visible)	eval(NameAlbum+".Logo"+j)._visible=value;
	}
	BackAlbumPic.Logo._visible=value;
}
function ConfirmIdAlbum(Index,Count){
	for(var j=0;j<Count;j++){
		if(resultSearchArtistAlbum[Index+j].id.length<=0){
			return true;
		}
	}
	return false
}
function ReturnIndexVol(Index){
	var Index1=int((Index-1)/NumMovie);
	var spl = resultSearchVol[Index1].split(":");
	var Index = parseInt(spl[0], 10);
	var count = parseInt(spl[1], 10)-index;
	StoreAlbumByIndex=Index-1;
	StoreAlbumByCount=count+1;
	if(resultSearchArtistAlbum[StoreAlbumByIndex].id.length<=0){
		fscommand("GetAlbumByIndex",StoreAlbumByIndex+"~"+StoreAlbumByCount+"~"+"No"+"~"+SelectMode);
	}
	else{
		return true;
	}
}
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
function requestAlbumAvailable(startIndex,loopCount) {
	var boolavailableChanged = false;
	var available_array= new Array();
	if(clientType!=serverMode){
		for (var i=startIndex; i<(startIndex+loopCount); i++) {
			if (resultSearchArtistAlbum[i].Ava==0){
				boolavailableChanged=true;
				available_array.push(resultSearchArtistAlbum[i].ID);
			}
		}
		if (boolavailableChanged) {
			fscommand("clients","requestAlbumAvailable&&&"+available_array+"&&&"+LanName);
		}
	}
	delete (boolavailableChanged);
	delete (available_array);
}
function changeAlbumAvailable(changeList_array) {
	var boolavailableChanged = false;
	var i,j;
	changeList_array=changeList_array.split(",");
	for(i=0;i<resultSearchArtistAlbum.length;i++){
		for(j=0;j<changeList_array.length;j++){
			if (resultSearchArtistAlbum[i].ID==changeList_array[j] and resultSearchArtistAlbum[i].Ava==0){
				boolavailableChanged=true;
				resultSearchArtistAlbum[i].Ava=2;
			}
		}
	}
	if(boolavailableChanged){
		DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultSearchArtistAlbum);
	}
	
}
function album_status(obj, val) {
	var d_color = new Color(obj._mc._mc);
	if(val==0){
		obj._visible=false;
	}else if(val==1){
		d_color.setRGB("0x999999");			//orignal color gray
		obj._visible=true;
	}else if(val==2){
		d_color.setRGB("0xFFFF00");			//friend's computer yellow
		obj._visible=true;
	}
}