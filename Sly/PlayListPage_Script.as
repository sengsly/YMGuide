var ResultP=new Array();
var ResultD=new Array();

TopBar._visible=false;
eval(TrackName)._visible=false;
BackAlbumPic._visible=false;
BackPlayList._visible=false;
ButtonTooltip._visible=false;
SmallIcon._visible=false;
BBigIcon._visible=false;
BigIcon._visible=false;
SmallIcons._visible=false;
BBigIcons._visible=false;
BigIcons._visible=false;

ArrowBar._visible=false;
BackPlayList1._visible=false;
//BackPlayList.BackListD._visible=false;
BackListP._visible=false;
MenuMode._visible=false;
VolBar._visible=false;
SortMaster._visible=false;
PurchaseCDMode._visible=false;
var SplAllCountrys=new Array();
var SaveAlbumInfo="";
_root.onEnterFrame = function() {
	if(OpenFade=="true"){
			ExecFade ();
	}
	if (Key.isDown(Key.ESCAPE)) {
		Escape();
	}
}
function msgbox (st) {
	fscommand("reply",st);
}
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

			//.............
			if(MainLevel==1 && resultP.length>0){
				FirstDisplayMovie(ResultP.length,ResultP);
			}
			else if(MainLevel==3 && VolBar._visible ){
				if(PlaylistMode=="Artist"){
					FirstDisplayMovie(resultArtist.length,resultArtist);
				}
				SplitResultVol(parseInt(resultAlbum.length, 10), NumMovie);
				FirstDisplayVol(resultSearchVol.length);
				VolBar.Button0.onRelease();
				eval(NameAlbum+".Button0").onRollOver();
			}
			else if(MainLevel==2 && ArrowBar._visible){
				FirstDisplayMovie(resultArtist.length,resultArtist);
			}
			
		}
}
//......................
function GetValue(){};
_root.addProperty("OpenFrame",_root.GetValue,_root.GetValueOpenFrame);
_root.addProperty("SetAlbumNum",_root.GetValue,_root.GetAlbumNum);
function GetValueOpenFrame(Value){
	if (Value == "true") {
		if(GetArtistTrackInfo.length>0){
			SplitResult(GetArtistTrackInfo);
			FirstDisplayTrack(resultSearch.length);
			eval(TrackName).fileType.AvailableType	=	PlayFileFrom
			eval(TrackName).fileType.setfileType(eval(TrackName).fileType.searchForDefault())					//Show large medium small
			delete(GetArtistTrackInfo);

			var stringIDs= new Array();
			var loc_LanName=resultSearch[0].Lan;
			for(var i=0;i<resultSearch.length;i++){stringIDs.push(resultSearch[i].trackID);}
			fscommand("clients","requestTrackAvailable&&&"+stringIDs + "&&&" + loc_LanName);
			fscommand("servers","requestTrackAvailable&&&"+stringIDs + "&&&" + loc_LanName);
		}
		if(getSplitSt.length>0){
			var spl_Countries = StAllCountrys.split("%%");
			var country_Name;
			for (i=0; i<spl_Countries.length; i++) {
				var eachPath = new Object();
				spl_Each = spl_Countries[i].split("%");
				country_Name = spl_Each[1];
				eachPath.DBPath = spl_Each[0];
				eachPath.IMPath = spl_Each[2];
				SplAllCountrys[country_Name]= eachPath;
			}
			/*
			var st=StAllCountrys.split("%%");
			for(var j=0;j<st.length;j++){
				var st1=st[j].split("%");
				SplAllCountrys[st1[1]]=st1[0]
				SplAllCountrys[st1[1]+"_img"]=st1[2]
				SplAllCountrys[st1[st1.length-1]]=st[j];
			}
			
			SplAllCountrys.length=0;
			var st=StAllCountrys.split(";");
			for(var j=0;j<st.length;j++){
				var st1=st[j].split("\\");
				SplAllCountrys[st1[st1.length-1]]=st[j];
			}
*/			
			LoadXmlLanguage(getSplitSt);
			getSplitSt="";
			delete(getSplitSt);
			LoadPlayListPath(AppPath);
			if(parseInt(UnloadIndex,10)>0){
				fscommand("UnloadSwf",UnloadIndex);
			}
		}
		else if(CheckTrackAva.length>0){
			LoadTrackByPlayListName(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
			delete(CheckTrackAva);
		}
		else if(CheckTrackRating.length>0){
			if(PlayListMode=="TrackTitle"){
				LoadTrackByPlayListName(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml");
			}
			delete(CheckTrackRating);
		}
		else if(ShowLoading.length>0){
			var spl=ShowLoading.split("%~%");
//			if(!LoadBar._visible)LoadBar._visible = true;
			LoadBar.showProgressBar();
			LoadBar.txt.text="Downloading... "+ spl[0]+ " cover arts"
			delete(ShowLoading);
		}
		else if(RefreshPicAlbum.length>0){
			var AlbumID="";
			var index1=IndexAlbumForDownLoad;
			StorePathPic="";
			resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
			if(resultAlbum.length>0 && PlayListMode!="TrackTitle"){
				AlbumID=resultSearch[index1].AlbumID;
				for(var j=0;j<resultAlbum.length;j++){
					if(AlbumID==resultAlbum[j].id){
						resultAlbum[j].ReservePath=resultAlbum[j].PicPath;
						var index=j%nPlayList
						if(IndexShowP+index==j){
							if(eval("BackListP.Pic"+Index)._alpha<=0)eval("BackListP.PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
							else eval("BackListP.Pic"+Index).loadMovie(resultAlbum[j].PicPath)
						}
						var index=j%NumMovie
						if(StoreIndexVol1+index==RecordIndexAlbum){
							if(eval(NameAlbum+".Pic"+index)._alpha<=0)eval(NameAlbum+".PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
							else eval(NameAlbum+".Pic"+index).loadMovie(resultAlbum[j].PicPath)
						}
						break;
					}
				}
			}
			DisplayAlbumPictrueInfo(index1);
			delete(IndexAlbumForDownLoad);
			delete(RefreshPicAlbum);
		}
		else if(RefreshPicAlbumRip.length>0){
			var AlbumID="";
			var index1=0;
			StorePathPic="";
			if(resultSearch[index1].PathPic==RefreshPicAlbumRip){
				resultSearch[index1].ReservePath=resultSearch[index1].PathPic;
				if(resultAlbum.length>0 && PlayListMode!="TrackTitle"){
					AlbumID=resultSearch[index1].AlbumID;
					for(var j=0;j<resultAlbum.length;j++){
						if(AlbumID==resultAlbum[j].id){
							resultAlbum[j].ReservePath=resultAlbum[j].PicPath;
							var index=j%nPlayList
							if(IndexShowP+index==j){
								if(eval("BackListP.Pic"+Index)._alpha<=0)eval("BackListP.PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
								else eval("BackListP.Pic"+Index).loadMovie(resultAlbum[j].PicPath)
							}
							var index=j%NumMovie
							if(StoreIndexVol1+index==RecordIndexAlbum){
								if(eval(NameAlbum+".Pic"+index)._alpha<=0)eval(NameAlbum+".PicFade"+Index).loadMovie(resultAlbum[j].PicPath)
								else eval(NameAlbum+".Pic"+index).loadMovie(resultAlbum[j].PicPath)
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
		else if(ShowPurchaseBox.length>0){
			VisibleChecked(ShowPurchaseBox);
			delete(ShowPurchaseBox);
		}
		else if(SetAlbumCover.length>0){
			if(MainLevel==1){
				DisplayMovieArtistItem(NameAlbum, IndexShowArrow, CountArrow, resultP);
			}
			else if(MainLevel==2){
				DisplayMovieArtistItem(NameAlbum, IndexShowArrow, CountArrow, resultArtist);
			}
			else if(MainLevel==3){
				DisplayMovieArtistItem(NameAlbum, StoreIndexVol1, StoreCountVol1, resultAlbum);
			}
			delete(SetAlbumCover);
		}
		else if (GetArtistAlbum.length>0) {
			if(GetArtistAlbum=="Non"){
				
			}
			else{
				ArtistMode._visible=false;
				ArtistSorted._visible=false;
				FirstDisplayP(resultArtist.length,RecordIndexArtist);
						
				MainLevel=3;
				ArrowBar._visible=false;
				VolBar._visible=true;
				SplitResultVol(parseInt(ArtistLength, 10), NumMovie);
				FirstDisplayVol(resultSearchVol.length);
				SplitResultArtistName(GetArtistAlbum);
				GetArtistAlbum = "";
				delete(GetArtistAlbum);
				VolBar.Button0.onRelease();
				eval(NameAlbum+".Button0").onRollOver();
			}
		}
		else if(NewFolderPlaylist.length>0){
			var spl=NewFolderPlaylist.split("\\");
			ImgPath1[ImgPath1.length]=PathFolderPlaylist;
			SlyPath1[SlyPath1.length]=NewFolderPlaylist;
			resultP1[resultP1.length]=spl[spl.length-1];
			FirstDisplaySortMaster(resultP1.length);
			DisplayPictrueSortMaster(SlyPath1.length);
			SaveChangePlayList();//...try testing..
			delete(PathFolderPlaylist);
			delete(NewFolderPlaylist);
		}
		else if(NewDirSortMaster.length>0){
				ImgPath1[ImgPath1.length]=NewDirSortMaster;
				SlyPath1[SlyPath1.length]=NewDirSortMaster+"\\folder.jpg";
				resultP1[resultP1.length]=CreateNew.Text.text;
				FirstDisplaySortMaster(resultP1.length);
				DisplayPictrueSortMaster(SlyPath1.length);
				SaveChangePlayList();
				delete(NewDirSortMaster);
		}
		else if(ImgPlayList.length>0){
			if(eval(NameAlbum+".Pic"+IndexPlayList)._alpha>10){
				eval(NameAlbum+".Pic"+IndexPlayList).loadMovie(ImgPlayList);
			}
			else if(eval(NameAlbum+".PicFade"+IndexPlayList)._alpha>10){
				eval(NameAlbum+".PicFade"+IndexPlayList).loadMovie(ImgPlayList);
			}
			ImgPath[RecordIndexP]=ImgPlayList;
			ImgPlayList="";
			delete(ImgPlayList);
		}
		 else if (GetArtistAlbumInfo.length>0) {
			SaveAlbumInfo=GetArtistAlbumInfo;
			ChangeAlbumInfoFont(ChangeLan, SaveAlbumInfo);
			GetArtistAlbumInfo = "";
			delete(GetArtistAlbumInfo);
		}
		else if(DelTrack.length>0){
			FirstLoadTrack=true;
			LoadTrackByPlayListName(BackPlayList.TextD.text+"\\PlayLists\\"+resultP[RecordIndexP]+".xml");
			DelTrack="";
			delete(DelTrack);
		}
		else if(SortMasterImg.length>0){
			if(!OpenPlayList)SlyPath1[SelectSel]=SortMasterImg;
			else Imgpath1[SelectSel]=SortMasterImg;
			DisplayPictrueSortMaster(SelectSel);
			delete(SortMasterImg);
			SaveChangePlayList();
		}
		else if(SortMasterSlide.length>0){
			SlyPath1[RecordIndexShowSortMaster]=SortMasterSlide;
			SortMaster.TextPath.text="SlideShow Path\n"+SortMasterSlide;
			SaveChangePlayList();
			delete(SortMasterSlide);
		}
		else if(EditSlyShow.length>0){
			SlyPath[RecordIndexP]=EditSlyShow;
			delete(EditSlyShow);
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
function VisibleSlyIcon(value){
	for(var j=0;j<NumMovie;j++){
		if(eval(NameAlbum+".Movie"+j)._visible)	eval(NameAlbum+".Logo"+j)._visible=value;
	}
	for(var j=0;j<nList;j++){
		if(eval("BackListP"+".Movie"+j)._visible)eval("BackListP"+".Logo"+j)._visible=value;
		if(eval("BackPlayList.BackListD"+".Movie"+j)._visible)eval("BackPlayList.BackListD"+".Logo"+j)._visible=value;
	}
	BackAlbumPic.Logo._visible=value;
}

function changeAvailable (changeList,fromComName) {
	var boolavailableChanged=false;
	changeList=changeList.split(",");
	for(i=0;i<changeList.length;i++){
		for(j=0;j<resultSearch.length;j++){
			if (changeList[i]==resultSearch[j].trackID and resultSearch[j].Ava==0){
				boolavailableChanged=true;
				resultSearch[j].Ava=3;		//3 download from server
				resultSearch[j].ComName=fromComName;
			}
		}
	}
	if(boolavailableChanged){
		DisplayItemTrack (TrackName,eval("IndexShow"+TrackObj),eval("Count"+TrackObj),nTrack);	
	}
	if(clientType == serverMode){
		var available_array= new Array();
		for(var i=0;i<resultSearch.length;i++){
			if(resultSearch[i].Ava!=0 or resultSearch[i].ComName<>ComName){
				available_array.push(resultSearch[i].trackID);
			}
		}
		fscommand("servers","refreshTrackAvailable&&&"+available_array);
	}
	delete(boolavailableChanged);
	delete(available_array);
}