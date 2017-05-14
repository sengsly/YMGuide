var numTrack;
//.....................ENTERFRAME.......................................
//var nTrack=12;
TopBar._visible=false;
eval(TrackName)._visible=false;
BackAlbumPic._visible=false;
//Save._visible=false;
DelAll._visible=false;
PurchaseCDMode._visible=false;
var ChangeCurIndexTrack="";
var SaveAlbumInfo="";
var SplAllCountrys=new Array();
_root.onEnterFrame = function() {
	imgFade();
	if(OpenFade=="true"){
		ExecFade ();
	}
	if (Key.isDown(Key.BACKSPACE) and (Selection.getFocus()==null)){
		Escape();
	}
	if (Key.isDown(Key.ESCAPE)) {
		Escape();
	}
}
//......................
function GetValue(){};
_root.addProperty("OpenFrame",_root.GetValue,_root.GetValueOpenFrame);
function GetValueOpenFrame(Value){
	if (Value == "true") {
		if(SetFocus.length>0){
			SelectButton(StoreNameSelected);
			if(int(SetFocus)>0){
				PressKeyPlayListPlayer(int(SetFocus));
			}
			delete(SetFocus);
		}
		else if(openCover.length>0){
			TopBar.ButtonX.onRollOver();
			ButtonHideMouse._visible=false;
			delete(openCover);
		}
		else if(getSplitSt.length>0){
			//First load playlist player page in here
			SplAllCountrys.length=0;
			SplitCountries(StAllCountrys);
			
			
			resultSearch.length=parseInt(PassTrackInfoLen,10);
			SplitResult(PassTrackInfo);
			LoadXmlLanguage(getSplitSt);
			if(parseInt(UnloadIndex,10)>0){
				fscommand("UnloadSwf",UnloadIndex)
			}
			fscommand("requestDownloadState");
			delete(getSplitSt);
			delete(PassTrackInfo);			
		}
		else if(ShowPurchaseBox.length>0){
			VisibleChecked(ShowPurchaseBox);
			delete(ShowPurchaseBox);
		}
		else if(ShowLoading.length>0){
			var spl=ShowLoading.split("%~%");
//			if(!LoadBar._visible)LoadBar._visible = true;
			LoadBar.showProgressBar();
			LoadBar.txt.text="Downloading... "+ spl[0]+ " cover arts";
			delete(ShowLoading);
		}
		else if(RefreshPicAlbum.length>0){
			var AlbumID="";
			var index1=IndexAlbumForDownLoad;
			StorePathPic="";
			resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
//			fscommand("reply",resultAlbum.length);
			
			if(resultAlbum.length>0){

				if(ClickAlbum)AlbumID=resultSearch[index1].AlbumID;
				else AlbumID=resultSearch[index1].LanPath;
				for(var j=0;j<resultAlbum.length;j++){
//					eval(TrackName).Pic
					
					if(AlbumID==resultAlbum[j].ID){
						resultAlbum[j].ReservePath=resultAlbum[j].PicPath;
						var index=j%nAlbum
						if(IndexShowAlbum+index==j){
							if(eval("AlbumBar.Pic"+Index)._alpha<=0)eval("AlbumBar.PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
							else eval("AlbumBar.Pic"+Index).loadMovie(resultAlbum[j].PicPath)
						}
						break;
					}
				}
			}
			
			delete(IndexAlbumForDownLoad);
			DisplayAlbumPictrueInfo(index1);
			delete(RefreshPicAlbum);
		}
		else if(RefreshPicAlbumRip.length>0){
			var AlbumID="";
			var index1=0;
			StorePathPic="";
			if(resultSearch[index1].PathPic==RefreshPicAlbumRip){
				resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
			
				if(resultAlbum.length>0){
					if(ClickAlbum)AlbumID=resultSearch[index1].AlbumID;
					else AlbumID=resultSearch[index1].LanPath;
					for(var j=0;j<resultAlbum.length;j++){
						if(AlbumID==resultAlbum[j].ID){
							resultAlbum[j].ReservePath=resultAlbum[j].PicPath;
							var index=j%nAlbum
							if(IndexShowAlbum+index==j){
								if(eval("AlbumBar.Pic"+Index)._alpha<=0)eval("AlbumBar.PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
								else eval("AlbumBar.Pic"+Index).loadMovie(resultAlbum[j].PicPath)
							}
							break;
						}
					}
				}
				DisplayAlbumPictrueInfo(index1);
				delete(IndexAlbumForDownLoad);
				delete(RefreshPicAlbumRip);
			}
		}
		else if(RefreshAvaTrack.length>0){
			var Index =int(RefreshAvaTrack)
			resultSearch[Index].Ava="1";
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			delete(RefreshAvaTrack);
		}
		else if(PassChangeCurIndexTrack.length>0){
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			delete(PassChangeCurIndexTrack);
		}
		else if(GetArtistTrackInfo.length>0){
			resultSearch.length=0;
			SplitResultAlbum(GetArtistTrackInfo);
			FirstDisplayTrack(resultSearch.length);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			var stringIDs= new Array();
			for(var i=0;i<resultSearch.length;i++){stringIDs.push(resultSearch[i].trackID);}
			if(clientType<>serverMode){
				fscommand("clients","requestTrackAvailable&&&"+stringIDs + "&&&" + resultSearch[0].Lan);
			}else{
				fscommand("servers","requestTrackAvailable&&&"+stringIDs + "&&&" + resultSearch[0].Lan);
			}
			delete(stringIDs);
			delete(GetArtistTrackInfo);
			TrackName.Button0.onRollOver();
		}
		else if(GetNextTrackInfo.length){
			SplitResult(GetNextTrackInfo);
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			if (BackAlbumPic.PicFade0._alpha==0 and BackAlbumPic.Pic0._alpha==0){
				//if load the first time then
				eval(TrackName+".Button0").onRollOver();//StoreNameSelected
			}
			delete(GetNextTrackInfo);
		}
		else if (GetListed.length){
//			IndexStore=0;
			SplitSearchResult(GetListed)
//			fscommand(GetListed.length)
//			GetNextTrackInfo
//			resultSearch=GetListed;
//			DisplayItemSearch ("SearchBox.ListResult",0,5,5);
			DisplayItemSearch ("SearchBox.ListResult",IndexShowSearchList,CountSearchList,nListSearch);
//			IndexShowSearchList,CountSearchList,nListSearch
			delete(GetListed);
		}else if (getTextSearch.length>0){ //2006-08-07 Seng
			KeyBoard._visible=false
			SearchByTrack(getTextSearch,ChangeLanRe=="Uni");
			delete(getTextSearch);
		}
		else if(GetSearchTracks.length){
			IndexStore=0;
			ResultForSearch=GetSearchTracks.split("&&&")
			//FirstDisplayAlbum(GettingAlbums())
			//commented by seng
			if(ValueSerchByTrack==true){
				ValueSerchByTrack=false;
				StoreSearchByTrack(StoreSearchTitle,StoreSearchTitleUni);
			}
			else{
				if(resultAlbum.length>0){
					AlbumBar._visible=true;
				}
				if(StoreStSearch.length>0){
					AlbumBar._visible=false;
					SearchByAlbum(StoreStSearch,StoreUni);
					StoreStSearch="";
				}
			}
			delete(GetSearchTracks)
		}
		else if(GetAllTracks.length){
			IndexStore=0;
//			SplitResult(GetAllTracks);
//			FirstDisplayAlbum(GettingAlbums())
			FirstDisplayAlbum(GettingAlbums_xml(GetAllTracks))
				
			if(ValueSerchByTrack==true){
				ValueSerchByTrack=false;
				StoreSearchByTrack(StoreSearchTitle,StoreSearchTitleUni);
			}
			else{
				if(resultAlbum.length>0){
					AlbumBar._visible=true;
				}
				if(StoreStSearch.length>0){
					AlbumBar._visible=false;
					SearchByAlbum(StoreStSearch,StoreUni);
					StoreStSearch="";
				}
			}			
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			delete(GetAllTracks);
		}
		else if (PassTrackLenRefresh.length>0){
//			resultSearch.length=0;
//			resultSearch.length=Number(PassTrackLenRefresh);
//			set("Count"+TrackObj, 15);
//			set("n"+TrackObj,15);
//			FirstDisplayTrack(PassTrackInfoLen);
			setPlayerTrackAndPlayIndex(15,0,"false");
//			DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack);
			delete(PassTrackLenRefresh);			
		}
		else if(PassTrackInfoLen.length>0){
			numTrack=PassTrackInfoLen;
			IndexStore=0;
			resultSearch.length=0;
			FirstLoadAlbum=true;
			PassTrackInfoLen=Number(PassTrackInfoLen);
			resultSearch.length=PassTrackInfoLen;
//			ClickAlbum=false;
			setPlayerTrackAndPlayIndex(PassTrackInfoLen,ChangeCurIndexTrack);
			delete(PassTrackInfoLen);			
			delete(PassTrackInfo);
		}
		else if (GetArtistAlbumInfo.length>0) {
			SaveAlbumInfo=GetArtistAlbumInfo;
			ChangeAlbumInfoFont(ChangeLan, SaveAlbumInfo);
			GetArtistAlbumInfo = "";
			delete(GetArtistAlbumInfo);
		}
		else if(PassSlidePathValue.length>0){
			Save.Text.text=PassSlidePathValue;
			PassSlidePathValue="";
			delete(PassSlidePathValue);
		}
		else if(SetAlbumCover.length>0){
			DisplayTextAlbum("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum);
			delete(SetAlbumCover);
		}
		else if(ShowLogo.length>0){		
			Unregistered=Isregistered;
			if(Isregistered=="False"){
				VisibleSlyIcon(true);
			}
			delete(ShowLogo);
		}
		else if(ChangeLanguage.length>0){
			if (ChangeLan == "Uni") ChangeLan = "Eng";
			else ChangeLan = "Uni";
			DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);
			DisplayTextAlbum("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum);
			delete(ChangeLanguage);
		}
		else if(RefreshRating.length){
			var spl=RefreshRating.split("||");
			resultSearch[int(spl[1])].Rating=spl[0];
			delete(RefreshRating);
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
			Cover._visible = false;
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
	}
	//DisplayNext_Pre(numTrack);
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
	//////.............................................
	if (GomC) {
		for (var jReset = 0; jReset<NumfadeC; jReset++) {
			eval(Name1C+jReset)._alpha -= Alpha;
			eval(NameC+jReset)._alpha += Alpha;
		}
		if (eval(Name1C+0)._alpha<40) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(Name1C+jReset).unloadMovie();
			}
		}
		if (eval(NameC+0)._alpha>=100) {
			GomC = false;
		}
	} else if (Gom1C) {
		for (var jReset = 0; jReset<NumfadeC; jReset++) {
			eval(Name1C+jReset)._alpha += Alpha;
			eval(NameC+jReset)._alpha -= Alpha;
		}
		if (eval(NameC+0)._alpha<40) {
			for (var jReset = 0; jReset<NumfadeC; jReset++) {
				eval(NameC+jReset).unMovie();
			}
		}
		if (eval(Name1C+0)._alpha>=100) {
			Gom1C = false;
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
var AccessFade=false;
function Reset(n) {
	Numfade = n;
	OpenFade="true";
	if (eval(Name+0)._alpha<=0) {
		for (var jReset = 0; jReset<n; jReset++) {
			eval(Name+jReset)._alpha = 0;
			eval(Name1+jReset)._alpha = 100;
			eval(Name+jReset)._visible = true;
			eval(NameFade+jReset)._visible = true;
			eval(Name+jReset).loadMovie(PicName[jReset]);
			AccessFade=false;
		}
		Gom = true;
		Gom1 = false;		
	} else {
		for (var jReset = 0; jReset<n; jReset++) {
			eval(Name+jReset)._alpha = 100;
			eval(Name1+jReset)._alpha = 0;
			eval(Name1+jReset)._visible = true;
			eval(NameFade+jReset)._visible = true;
			//eval(Name1+jReset).unloadMovie();
			eval(Name1+jReset).loadMovie(PicName[jReset]);
			AccessFade=true;
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
function ReturnLevel(Num,nItem){
	if (Num%nItem == 0) {
		return int(Num/nItem);
	} else {
		return int(Num/nItem)+1;
	}
}
function VisibleSlyIcon(value){
	mini.Register._visible = value;
	BackAlbumPic.Logo._visible=value;
	for(var j=0;j<nAlbum;j++){
		if(eval("AlbumBar"+".Movie"+j)._visible)eval("AlbumBar"+".Logo"+j)._visible=value;
	}
}
function SplitCountries (Lists) {
	var spl_Countries = Lists.split("%%");
	var spl_Each;
	var country_Name;
	for (i=0; i<spl_Countries.length; i++) {
		var eachPath = new Object();
		spl_Each = spl_Countries[i].split("%");
		country_Name = spl_Each[1];
		eachPath.DBPath = spl_Each[0];
		eachPath.IMPath = spl_Each[2];
		eachPath.databaseType=spl_Each[3];
		SplAllCountrys[country_Name]= eachPath;
	}
}
