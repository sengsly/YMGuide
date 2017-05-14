var StOr="||";
var StAnd="&&&";
var StWave="%~%";
var StPer="%%";
var valueIntervalID=0;
///................................	SPLIT FUNCTION.............................................................
var resultSearchTrack = new Array();
var resultTVSeries= new Array();
var resultSeason= new Array();
//FEDID:2005.10.14.5
function SplitResultTVSeries (lpValue) {
//Split the result that get from VB structure 1||Friends||mitP®k||10
// 										  	  ID,Artist  , uniArtist, SeasonCount
	var eachTVSeries;
	var lpResult = new Array();
	var allTVSeries=lpValue.split("&&&")
	for(var i=0;i<allTVSeries.length;i++){
		var eachTVSeries=allTVSeries[i].split("||");
		lpResult.push({ID:eachTVSeries[0],Artist:eachTVSeries[1],uniArtist:eachTVSeries[2],SeasonCount:eachTVSeries[3]});
	}
	return lpResult;
}
//FEDID:2005.10.14.1
function SplitResultSeason (nLength) {
	var lpResult = new Array();
	var sName;
	for(var i=0;i<=nLength;i++){
		if(i==0){
			sName="All Season";
		}else{
			sName="Season #"+i
		}
		lpResult.push({ID:i,Artist:sName})
	}
	return lpResult;
}
function con_ResultSearchTrack(trackNo, trackTitle, unicodeTrackTitle, Rating, Length, Mood, unicodeMood, danceStyle, unicodeDanceStyle, Artist, unicodeArtist, trackID,LanTrack,Ava,walMart_Ava,ShoppingID,PathPic) {
	this.trackNo = trackNo;
	this.trackTitle = trackTitle;
	this.unicodeTrackTitle = unicodeTrackTitle;
	this.Rating = Rating;
	this.Length = Length;
	this.Mood = Mood;
	this.unicodeMood = unicodeMood;
	this.danceStyle = danceStyle;
	this.unicodeDanceStyle = unicodeDanceStyle;
	this.Artist = Artist;
	this.unicodeArtist = unicodeArtist;
	this.trackID = trackID;
	this.LanTrack=LanTrack;
	this.ComName=ComName;		//ComName	variable from global
	if(Ava.length==0)Ava=0;
	this.Ava=Ava;
	if(walMart_Ava.length==0)walMart_Ava=0;
	this.walMart_Ava=walMart_Ava;
	this.ShoppingID=ShoppingID;
	this.ReservePath	=	"";
	this.PathPic		=	PathPic;
	
}
function SplitResultTrack(tmp3) {
	resultSearchTrack.length = 0;
	if (tmp3.length>0){
		tmp2 = tmp3.split(StAnd);
	}
	var TN, TT, UT, Rating, Length, Mood, UniMood, Dance, UniDance, Artist, UniArtist, tID,LanTrack,Ava,wal_Ava,ShoppingID;
	for (i=0; i<tmp2.length; i++) {
		tmp1 = String(tmp2[i]).split(StOr);
		TN = String(tmp1[1]);
		TT = String(tmp1[2]);
		UT = String(tmp1[3]);
		Rating = String(tmp1[10]);
		Length = String(tmp1[11]);
		Mood = String(tmp1[4]);
		UniMood = String(tmp1[5]);
		Dance = String(tmp1[6]);
		UniDance = String(tmp1[7]);
		Artist = String(tmp1[8]);
		UniArtist = String(tmp1[9]);
		//set each chapter to it own chapter
		PathPic=MainPathImage+"\\"+resultSearchArtistAlbum[RecordIndexArtistAlbum].StringPath+"\\"+resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist+chapterName(TN);
		if(UniArtist.length<=0){
//			UniArtist=Artist;
		}
		tID = String(tmp1[0]);
		LanTrack=String(tmp1[12]);
		Ava=String(tmp1[13]);
		wal_Ava=String(tmp1[14]);
		ShoppingID=String(tmp1[15]);
		resultSearchTrack[i] = new con_ResultSearchTrack(TN, TT, UT, Rating, Length, Mood, UniMood, Dance, UniDance, Artist, UniArtist, tID,LanTrack,Ava,wal_Ava,ShoppingID,PathPic);
		resultSearchTrack[i].SingType=tmp1[16];
		resultSearchTrack[i].SeekOffset=tmp1[17];			//EDID:2006.06.07
		resultSearchTrack[i].Label=tmp1[18];			//EDID:2006.06.07
		resultSearchTrack[i].LabelUnicode=tmp1[19];			//EDID:2006.06.07
	}
	tmp2.length = 0;
	tmp1.length = 0;
}
var resultSearchVol = new Array();
var resultSearchArrow=new Array();
function SplitResultVol(Num, n) {
	var resultSearchVolTemp=new Array();
	if (Num%n == 0) {
		var TotalLevel = int(Num/n);
		var Z = 0;
	} else {
		var TotalLevel = int(Num/n)+1;
		var Z = Num%n;
	}
	var f = 0;
	var f1 = 0;
	for (i=0; i<TotalLevel; i++) {
		f = (n*i)+1;
		f1 = f+(n-1);
		if (i == TotalLevel-1) {
			if (Z>0) {
				f1 = f1-(n-z);
			}
		}
		resultSearchVolTemp[i] = f+" : "+f1;
	}
	return resultSearchVolTemp;
}
/// END FUNCTION SPLIT
var resultSearchArtistName = new Array();
var resultSearchArtistAlbum = new Array();
var resultSearchAlbumSeason = new Array();
function con_ResultSearchArtistName(id, Artist, uniArtist, Path,ArtistName,MyFav,Ava,Rank,idLan,StringPath,Year,ReservePath,SetPic,unicodeArtistName) {
	this.id = id;
	this.Artist = Artist;
	this.uniArtist = uniArtist;
	this.Path = Path;
	this.ArtistName=ArtistName;
	this.unicodeArtistName=unicodeArtistName;
	this.MyFav=MyFav;
	this.Ava=Ava;
	this.Rank=Rank;
	this.idLan=idLan;
	this.StringPath=StringPath;
	this.Year=Year;
	this.ReservePath=ReservePath;
	this.SetPic=SetPic;
}
// fucntion
var SplAllCountrys=new Array();
var SplAllNames=new Array();
function SplitResultArtistName(tmp3, ArtistFolder,Index) {
	//var  tmp2,tmp1;
	if (ArtistFolder.length<=0)resultSearchArtistName.length=0;
	var tmp1,tmp2;
	tmp2 = tmp3.split(StAnd);
	for (i=0; i<tmp2.length; i++) {
		tmp1 = String(tmp2[i]).split(StOr);
		var Id = String(tmp1[0]);
		var Art = String(tmp1[1]);
		var uniArt = String(tmp1[2]);		
		if (ArtistFolder.length>0) {
			var ArtPath=String(tmp1[3]);
			var MyFav=String(tmp1[4]);
			var Ava=String(tmp1[5]);
			var idLan=parseInt(tmp1[6],10);
			var Rank=String(tmp1[7]);
			var Year=String(tmp1[8]);
			var path =MainPathImage +"\\" + GetFirstLetter(ArtPath)+"\\"+ArtPath+"\\"+Art+"\\folder.jpg";
			var ReservePath=path;
			var StringPath=GetFirstLetter(ArtPath)+"\\"+ArtPath;
			var ArtName=ArtPath;
			var unicodeArtName=String(tmp1[9]);
			DefineAlbum="true";
			fscommand("SearchPathImage",ReservePath+"%~%"+"Album"+"%~%"+(int(Index)+i)+"%~%"+Id+"%~%"+LanName);
			resultSearchArtistAlbum[int(Index)+i]=new con_ResultSearchArtistName(Id, Art, uniArt, path,ArtName,MyFav,Ava,Rank,idLan,StringPath,Year,ReservePath,"",unicodeArtName);
			resultSearchArtistAlbum[int(Index)+i].Actor=tmp1[10];
			resultSearchArtistAlbum[int(Index)+i].Director=tmp1[11];
			resultSearchArtistAlbum[int(Index)+i].AudioID=tmp1[12];
			resultSearchArtistAlbum[int(Index)+i].FlagID=tmp1[13];

		} else {
			var idLan=parseInt(tmp1[4],10);
			var path = MainPathImage+"\\" + GetFirstLetter(Art)+"\\"+Art+"\\folder.jpg";
			var ReservePath=Path;
			var SetPic=0;
			var ArtName=Art;
			var MyFav=String(tmp1[3]);
			var Rank=String(tmp1[5]);
			var StringPath=GetFirstLetter(Art)+"\\"+Art+"\\folder.jpg";
			resultSearchArtistName[i]=new con_ResultSearchArtistName(Id, Art, uniArt, path,ArtName,MyFav,Ava,Rank,idLan,StringPath,Year,ReservePath,SetPic);
		}
	}
}
var FadeTrue=false;
var FadeTrueBar=false;
function GetPathImage(value){
	var spl=value.split("%~%");
	var Index=int(spl[2]);
	var Index1=Index%NumMovie;
	var Index2=Index%nAlbum;	
	if(spl[3]==LanName){
		if(spl[1]=="Back"){
			if(MainLevel==4 &&(IndexShowAlbum+Index2)==Index){//display back album
				BackAlbumPic.loadFadeImage(spl[0]);
			}
		}else if(spl[1]=="Album"){
			resultSearchArtistAlbum[Index].ReservePath=spl[0];
			if(MainLevel==3 && (StoreIndexVol1+Index1)==Index){
				if (FadeTrue){
					eval(Name1+Index1).loadMovie(spl[0]);
				}else{
					eval(Name+Index1).loadMovie(spl[0]);
				}
			}else if(MainLevel==4){
				if((IndexShowAlbum+Index2)==Index){			//for top bar album
					if (FadeTrueBar){
						eval(Name1C+Index2).loadMovie(spl[0]);
					}else{
						eval(NameC+Index2).loadMovie(spl[0]);
					}
				}
				if(RecordIndexArtistAlbum==Index){			//for back album
					BackAlbumPic.loadFadeImage(spl[0]);
				}
			}
		}else if(spl[1]=="Chapter"){
			//MainLevel==4 Level of Chapter Page
			if(MainLevel==4){
				IndexShowChapter=	eval("IndexShow"+TrackObj);
				CountChapter	= 	eval("Count"+TrackObj);
				for(var i=0;i<resultSearchTrack.length;i++){
					//Index contains the trackID
					if(resultSearchTrack[i].trackID==Index){
						resultSearchTrack[i].ReservePath=spl[0];		//assign the new path
						if(i>=IndexShowChapter and i< IndexShowChapter+CountChapter){
							objPic		=	eval(TrackName+".Pic"+(i-IndexShowChapter))
							objPic.loadFadeImage(spl[0]);
						}
					}
				}
			}
			
/*
			resultSearchArtistName[Index].ReservePath=spl[0];
			if(MainLevel==2 && (StoreIndexArrow1+Index1)==Index){
				if (FadeTrue){
					eval(Name1+Index1).loadMovie(spl[0]);
				}else{
					eval(Name+Index1).loadMovie(spl[0]);
				}
			}
			else if(MainLevel==3 &&(IndexShowArtistName+Index2)==Index){
				if (FadeTrueBar){
					eval(Name1C+Index2).loadMovie(spl[0]);
				}else{
					eval(NameC+Index2).loadMovie(spl[0]);
				}
			}else i
			}
*/			
		}else{
			resultSearchArtistName[Index].ReservePath=spl[0];
			if(MainLevel==2 && (StoreIndexArrow1+Index1)==Index){
				if (FadeTrue){
					eval(Name1+Index1).loadMovie(spl[0]);
				}else{
					eval(Name+Index1).loadMovie(spl[0]);
				}
			}
			else if(MainLevel==3 &&(IndexShowArtistName+Index2)==Index){
				
				if (FadeTrueBar){
					eval(Name1C+Index2).loadMovie(spl[0]);
				}else{
					eval(NameC+Index2).loadMovie(spl[0]);
				}
			}
		}
	}
	
}
_root.addProperty("SearchPathImage",_root.GetValue,_root.GetPathImage);
/// END FUNCTION SPLIT
var resultSearchGenre = new Array();
function con_ResultSearchGenre(idGenre, Genre, uniGenre,Pic,idLan) {
	this.idGenre = idGenre;
	this.Genre = Genre;
	this.uniGenre = uniGenre;
	this.Pic=Pic;
	this.idLan=idLan;
}
// fucntion
function SplitResultGenre(tmp3,RefreshYear) {
	resultSearchGenre.length = 0;
	if(DisplayAlbum!="Browse"){
		GenreBar.ButtonOpt._visible=false;
		GenreBar.MovieOpt._visible=false;
		GenreBar.IconOpt._visible=false;
		GenreBar.Border._visible=false;
		//tmp2 = tmp3.split(";");
		tmp2 = tmp3.split("%%");
		for (i=0; i<tmp2.length; i++) {
			tmp1=tmp2[i].split("%");
			var id=tmp1[0];
			var Gen=tmp1[1];
			var uniGen=Gen;
			var pic=id+"\\folder.jpg";
			if(Gen==LanName)RecordIndexGenre=i;
/*			
			tmp1 = String(tmp2[i]).split("\\");
			var Id=tmp2[i];
			var Gen = String(tmp1[tmp1.length-1]);
			if(Gen==LanName)RecordIndexGenre=i;
			var uniGen=Gen;
			var pic = tmp2[i]+"\\folder.jpg";
*/			
			resultSearchGenre[i] = new con_ResultSearchGenre(Id, Gen, uniGen,pic,idLan);
			
		}
	}
	else{
		RecordIndexGenre=0;
		GenreBar.ButtonOpt._visible=true;
		GenreBar.MovieOpt._visible=true;
		GenreBar.IconOpt._visible=true;
		GenreBar.Border._visible=true;
		if(BrowseBy=="ReleaseDate"){
			tmp2 = tmp3.split("&&&");
			var j=0;
			for (i=0; i<tmp2.length; i++) {
				var Gen = tmp2[i];
				var uniGen=Gen;
				var Id=Gen;
				var pic = "";
				resultSearchGenre[j] = new con_ResultSearchGenre(Id, Gen, uniGen,pic,idLan);
				j+=1;
			}	
			resultSearchGenre[resultSearchGenre.length] = new con_ResultSearchGenre("0","Select All", UniNoSelect,"","");
			if(RefreshYear.length>0){
				for(var j=0;j<resultSearchGenre.length;j++){
					if(StoreYear==resultSearchGenre[j].Genre){
						RecordIndexGenre=j;
						break;
					}
				}
			}
			else{
				StoreYear=resultSearchGenre[RecordIndexGenre].idGenre;
				fscommand("ReleaseDate",StoreYear);
			}
		}
		else if(BrowseBy=="Production"){
			BackLetter._visible=false;							//2006.05.15 Seng Hide it
			tmp2 = tmp3.split(StAnd);
			for (i=0; i<tmp2.length; i++) {
				tmp1 = String(tmp2[i]).split(StOr);
				var Id = String(tmp1[0]);
				var Gen = String(tmp1[1]);
				var uniGen = String(tmp1[2]);
				var idLan=String(tmp1[3]);
				if(idLan>0){
					idCountry=idLan;
					var GetPath1=SplAllNames[idCountry-1];
					var pic = GetPath1+"\\" + GetFirstLetter(Gen)+"\\"+Gen+"\\folder.jpg";
				}
				else{
					var pic = MainPathImage+"\\" + GetFirstLetter(Gen)+"\\"+Gen+"\\folder.jpg";
				}
				resultSearchGenre[i] = new con_ResultSearchGenre(Id, Gen, uniGen,pic,idLan);
			}
		}
		else{
			BackLetter._visible=true;
			var pic="";
			resultSearchGenre[0]= new con_ResultSearchGenre("0", "Select All", UniNoSelect,pic);
			tmp2 = tmp3.split(StAnd);
			var j=0;
			for (i=0; i<tmp2.length; i++) {
				j+=1;
				tmp1 = String(tmp2[i]).split(StOr);
				var Id = String(tmp1[0]);
				var Gen = String(tmp1[1]);
				var uniGen = String(tmp1[2]);
				var pic="";
				var idLan=String(tmp1[3]);
				resultSearchGenre[j] = new con_ResultSearchGenre(Id, Gen, uniGen,pic,idLan);
			}
		}
		SaveGenre();
	}
	tmp2.length = 0;
	tmp1.length = 0;
}
/// END FUNCTION SPLIT

var StoreIndexShowArrow=0;
var	StoreCountArrow=0;
var StoreLevelIndexArrow=0;
var	SaveIndexNameArrow=0;

var SaveIndexShowVol=0;
var	SaveCountVol=0;
var	SaveLevelIndexVol=0;
var	SaveIndexName=0;
				
function SplitResultGenre1(tmp3) {
	GenreBar.ButtonOpt._visible=true;
	GenreBar.MovieOpt._visible=true;
	GenreBar.IconOpt._visible=true;
	GenreBar.Border._visible=true;
	resultSearchGenre.length=0;
	RecordIndexGenre=0;
	
		var temp=tmp3.split("~");
		tmp2 = temp[0].split(StAnd);
		for (i=0; i<tmp2.length; i++) {
			tmp1 = String(tmp2[i]).split(StOr);
			var Id = String(tmp1[0]);
			var Gen = String(tmp1[1]);
			if(Id=="0") var uniGen = UniNoSelect;
			else var  uniGen = String(tmp1[2]);
			var pic = String(tmp1[3]);
			if(temp[1]==Gen)RecordIndexGenre=i;
			resultSearchGenre[i] = new con_ResultSearchGenre(Id, Gen, uniGen,pic);
		}
		var Index=int(temp[3]);
		var Count=int(temp[4]);
		var LevelIndex=int(temp[5]);
		var AvaValue1=temp[7];
		var NumMovie1=temp[8];
//		if(SuiteAction.StoredProcedure=="loadDefault"){
			RecordLetter=temp[2];
//		}
		if(BrowseBy=="Genre"){
			if(temp[4].length>0 && AvaValue1==AvaValue && NumMovie1==NumMovie and SuiteAction.StoredProcedure=="loadDefault"){
				StoreIndexShowArrow=Index;
				StoreCountArrow=Count;
				StoreLevelIndexArrow=LevelIndex;
				SaveIndexNameArrow=int(temp[6]);
				if(SuiteAction.StoredProcedure=="loadDefault"){
					Browse_mc._visible = true;	
					enabled_browse._visible = true;
					fscommand("GetArtistNameStore", resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+AvaValue);
				}
			}
			else{
				BackLetter._visible=true;
			}
		}
		else if(BrowseBy=="Production"){
			if(temp[4].length>0 && AvaValue1==AvaValue && NumMovie1==NumMovie){
				SaveIndexShowVol=Index;
				SaveCountVol=Count;
				SaveLevelIndexVol=LevelIndex;
				SaveIndexName=int(temp[6]);
				fscommand("GetAlbumByLabel",resultSearchGenre[RecordIndexGenre].idGenre+"~"+RecordLetter+"~"+SortedValue+"~"+AvaValue+"~GetArtistAlbumStore");
			}
			else{
				fscommand("GetAlbumByLabel",resultSearchGenre[RecordIndexGenre].idGenre+"~~"+SortedValue+"~"+AvaValue+"~GetArtistAlbum");					
			}
		}
		else if(BrowseBy=="ReleaseDate"){
			if(temp[4].length>0 && AvaValue1==AvaValue && NumMovie1==NumMovie){
				SaveIndexShowVol=Index;
				SaveCountVol=Count;
				SaveLevelIndexVol=LevelIndex;
				SaveIndexName=int(temp[6]);
				StoreYear=temp[1];
				fscommand("ReleaseDateStore",StoreYear);
			}
			else{
				StoreYear=resultSearchGenre[RecordIndexGenre].idGenre;
				fscommand("ReleaseDate",StoreYear);
			}
		}
	tmp2.length = 0;
	tmp1.length = 0;
}
/// END FUNCTION SPLIT
function DelayFastClick() {
	boolWaitForNextDelete = true;
	valueIntervalID = setInterval(setBoolValue, 800, "boolWaitForNextDelete", false);
}
function setBoolValue(variableName, value) {
	clearInterval(valueIntervalID);
	set(variableName, value);
}
