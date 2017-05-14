var StOr="||";
var StAnd="&&&";
var StWave="%~%";
var StPer="%%";

var resultSearch = new Array();
function con_ResultSearch(Production, unicodeProduction, Album, unicodeAlbum, trackTitle, unicodeTrackTitle, Artist, unicodeArtist, Mood, unicodeMood, danceStyle, unicodeDanceStyle, Rating, Genre, unicodeGenre,trackID,PathPic,idLan,StringPath,AlbumID,LanTrack,YearTrack,Ava,walMart_Ava,ShoppingID,NoTrack,ReservePath) {
	this.Production = Production;
	this.unicodeProduction = unicodeProduction;
	this.trackTitle = trackTitle;
	this.unicodeTrackTitle = unicodeTrackTitle;
	this.Artist = Artist;
	this.unicodeArtist = unicodeArtist;
	this.Album = Album;
	this.unicodeAlbum = unicodeAlbum;
	this.Mood = Mood;
	this.unicodeMood = unicodeMood;
	this.danceStyle = danceStyle;
	this.unicodeDanceStyle = unicodeDanceStyle;
	this.Rating = Rating;
	this.Genre = Genre;
	this.ComName=ComName;
	this.unicodeGenre = unicodeGenre;
	this.trackID=trackID;
	this.PathPic=PathPic;
	this.idLan=idLan;
	this.StringPath=StringPath;
	this.AlbumID=AlbumID;
	this.LanTrack=LanTrack;
	this.YearTrack=YearTrack;
	if(Ava.length==0)Ava=0;
	this.Ava=Ava;
	if(walMart_Ava.length==0)walMart_Ava=0;
	this.walMart_Ava=walMart_Ava;
	this.ShoppingID=ShoppingID;
	this.NoTrack=NoTrack;
	this.ReservePath=ReservePath;
}
// fucntion
function SplitResult(tmp3){
	resultSearch.length = 0;
	tmp2 = tmp3.split(StAnd);
	for (i=0; i<tmp2.length; i++){
		tmp1 = String(tmp2[i]).split(StPer);
		var Pr = String(tmp1[0]).split(StOr);
		var Al = String(tmp1[1]).split(StOr);
		var Tr = String(tmp1[2]).split(StOr);
		var Ar = String(tmp1[3]).split(StOr);
		var Mo = String(tmp1[4]).split(StOr);
		var Da = String(tmp1[5]).split(StOr);
		var Ra = int(tmp1[6]);
		var Ge = String(tmp1[7]).split(StOr);
		var tID=tmp1[8];
		var idLan=parseInt(tmp1[9],10);
		var AlbumID=tmp1[10];
		var LanTrack=tmp1[11];
		var YearTrack=tmp1[12];
		var Ava=tmp1[14];
		var wal_Ava=tmp1[13];
		var ShoppingID=tmp1[15];
		var NoTrack=int(tmp1[16]);
		//var YearTrack=20000;
		if(idLan>0){
			idCountry=idLan;
			var GetPath1=SplAllNames[idCountry-1];
			path=GetPath1+"\\"+GetFirstLetter(Pr[0])+"\\"+Pr[0]+"\\"+Al[0]+"\\folder.jpg";
		}
		else{
			path=MainPathImage+"\\"+GetFirstLetter(Pr[0])+"\\"+Pr[0]+"\\"+Al[0]+"\\folder.jpg";
			var StringPath=GetFirstLetter(Pr[0])+"\\"+Pr[0];
		}
//		var ReservePath=path;
		var ReservePath="";
//		fscommand("SearchPathImage",ReservePath+"%~%"+"Track"+"%~%"+i+"%~%"+AlbumID+"%~%"+LanName);
		resultSearch[i] = new con_ResultSearch(Pr[0], Pr[1],Al[0], Al[1], Tr[0], Tr[1], Ar[0], Ar[1],  Mo[0], Mo[1], Da[0], Da[1], Ra, Ge[0], Ge[1],tID,path,idLan,StringPath,AlbumID,LanTrack,YearTrack,Ava,wal_Ava,ShoppingID,NoTrack,ReservePath);
		resultSearch[i].SingType=tmp1[17];
		resultSearch[i].SeekOffset=tmp1[18];
	}
	tmp2.length = 0;
	tmp1.length = 0;
}
/// END FUNCTION SPLIT
function Con_String(Name,Unicode,Id){
	this.Name=Name;
	this.Unicode=Unicode;
	this.Id=Id;
}
function SplitString(Str){
	var temp1,temp2;
	var SplArr=new Array();
	SplArr.length=0;
	temp1=Str.split(StAnd)
	var i=0;
	var Na="None Selected";
	var Un=UniNonSelected;
	SplArr[i]=new Con_String(Na,Un);
	for(var j=0;j<temp1.length;j++){
		i+=1;
		temp2=temp1[j].split(StOr);
		var Na=temp2[1];
		var Un=temp2[2];
		var id=temp2[0];
		SplArr[i]=new Con_String(Na,Un,id);
	}
	temp1.length=0;
	temp2.length=0;
	return SplArr;
}
function Con_Genre(Name,Unicode,Id){
	this.Name=Name;
	this.Unicode=Unicode;
	this.Id=Id;
}
function SplitCountries(Str){
	var SplCountries = new Array();
	Records = Str.split(StAnd)

	for(var j=0;j<Records.length;j++){
		Fields=Records[j].split(StOr);
		var newField = new Object();
		newField.ID		=Fields[0];
		newField.Name		=Fields[1];
		newField.Unicode		=Fields[2];
		newField.DatabasePath	=Fields[3];
		newField.ImagePath	=Fields[4];
		if(LanName.toLowerCase()==newField.ID.toLowerCase()){
			RecordIndexCountries=j;
		}
		SplCountries.push(newField);
	}
	return SplCountries;
}
function SplitGenre(Str){
	var temp1,temp2;
	var SplArr=new Array();
	SplArr.length=0;
	temp1=Str.split(StAnd)
	var i=0;
	var Na="None Selected";
	var Un=UniNonSelected;
	SplArr[i]=new Con_String(Na,Un);
	for(var j=0;j<temp1.length;j++){
		i+=1;
		temp2=temp1[j].split(StOr);
		var Na=temp2[1];
		var Un=temp2[2];
		var  Id=temp2[0];
		SplArr[i]=new Con_Genre(Na,Un,Id);
	}
	temp1.length=0;
	temp2.length=0;
	return SplArr;
}

//Add.............
var resultSearchVol = new Array();
var resultSearchArrow = new Array();
function SplitResultVol(Num, n) {
	var resultSearchVolTemp=new Array();
	resultSearchVolTemp.length = 0;
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
function con_ResultSearchArtistName(id, Artist, uniArtist, Path,ArtistName,MyFav,Ava,idLan,Rank,StringPath,Year,ReservePath,unicodeArtistName) {
	this.id = id;
	this.Artist = Artist;
	this.uniArtist = uniArtist;
	this.Path = Path;
	this.ArtistName=ArtistName;
	this.unicodeArtistName=unicodeArtistName;
	this.MyFav=MyFav;
	this.Ava=Ava;
	this.idLan=idLan;
	this.Rank=Rank;
	this.StringPath=StringPath;
	this.Year=Year;
	this.ReservePath=ReservePath;
	this.SetPic=0;
}
// fucntion
function SplitResultArtistName(tmp3, ArtistFolder,Index) {
	//var resultSearch = new Array();
	if (ArtistFolder.length<=0)resultSearchArtistName.length=0;
	var tmp1,tmp2;
	tmp2 = tmp3.split(StAnd);
	fscommand("CountImageToDownload",tmp2.length);
	for (i=0; i<tmp2.length; i++) {
		//msgbox(tmp1);
		tmp1 = String(tmp2[i]).split(StOr);
		var Id = String(tmp1[0]);
		var Art = String(tmp1[1]);
		var uniArt = String(tmp1[2]);
//		if(uniArt.length<=0){
//			uniArt=Art;
//		}
		if (ArtistFolder.length>0) {
			var ArtPath=String(tmp1[3]);
			var MyFav=String(tmp1[4]);
			var Ava=String(tmp1[5]);
			var idLan=parseInt(tmp1[6],10);
			var Rank=String(tmp1[7]);
			var Year=String(tmp1[8]);
			var path =MainPathImage +"\\" + GetFirstLetter(ArtPath)+"\\"+ArtPath+"\\"+Art+"\\folder.jpg";
			var ReservePath=Path;		
			fscommand("SearchPathImage",ReservePath+"%~%"+"Album"+"%~%"+(Index+i)+"%~%"+Id+"%~%"+LanName);
			var StringPath=GetFirstLetter(ArtPath)+"\\"+ArtPath;
			var ArtName=ArtPath;
			var UniArtistName=String(tmp1[9]);
			resultSearchArtistAlbum[Index+i] = new con_ResultSearchArtistName(Id, Art, uniArt, path,ArtName,MyFav,Ava,idLan,Rank,StringPath,Year,ReservePath,UniArtistName);
			resultSearchArtistAlbum[Index+i].Actor=tmp1[10]
			resultSearchArtistAlbum[Index+i].Director=tmp1[11]
			resultSearchArtistAlbum[(Index)+i].AudioID=tmp1[12];
			resultSearchArtistAlbum[(Index)+i].FlagID=tmp1[13];
		} else {
			var MyFav=String(tmp1[3]);
			var idLan=parseInt(tmp1[4],10);
			var Rank=String(tmp1[5]);
			var path = MainPathImage+"\\" + GetFirstLetter(Art)+"\\"+Art+"\\folder.jpg";
			var ReservePath=Path;
			var StringPath=GetFirstLetter(Art)+"\\"+Art+"\\folder.jpg";
			var ArtName=Art;
			resultSearchArtistName[i] = new con_ResultSearchArtistName(Id, Art, uniArt, path,ArtName,MyFav,Ava,idLan,Rank,StringPath,Year,ReservePath);
		}
	}
}
var FadeTrue=false;
function GetPathImage(value){
	var spl=value.split("%~%");
	var Index=int(spl[2]);
	
//	if(SelectMode=="Song"){
	if(spl[1]=="Track" || spl[1]=="Chapter"){
		if(MainLevel==4){
			resultSearch[Index].ReservePath=spl[0];
			var objPic;
			var newAlbumIDPath=resultSearch[Index].PathPic;
			for(j=0;j<nTrack;j++){
				objPic=eval(TrackName+".Pic"+j);
				objMovie=eval(TrackName+".Movie"+j);
				if(objPic.ID==newAlbumIDPath){
					Index1=objPic.Index;
					if(objMovie._visible){
						objPic.loadFadeImage(spl[0]);
					}
				}
			}
			delete(newAlbumIDPath);
			delete(objPic);
		}
	}else{
		var Index1=Index%NumMovie;
		if(spl[1]=="Album"){
			resultSearchArtistAlbum[Index].ReservePath=spl[0];
			if(MainLevel==3 && (StoreIndexVol1+Index1)==Index){
				if (FadeTrue) eval(Name1+Index1).loadMovie(spl[0]);
				else eval(Name+Index1).loadMovie(spl[0]);
			}
		}else{
			resultSearchArtistName[Index].ReservePath=spl[0];
			if(MainLevel==2 && (StoreIndexArrow1+Index1)==Index){
				if (FadeTrue) eval(Name1+Index1).loadMovie(spl[0]);
				else eval(Name+Index1).loadMovie(spl[0]);
			}
		}
	}
/*	
	if(MainLevel==4){
		resultSearch[Index].ReservePath=spl[0];
		var Index1;
		var newAlbumIDPath;
		var objPic;
		
		newAlbumIDPath=resultSearch[Index].PathPic;
		for(j=0;j<nTrack;j++){
			objPic=eval(TrackName+".Pic"+j);
			objMovie=eval(TrackName+".Movie"+j);
			if(objPic.ID==newAlbumIDPath){
				Index1=objPic.Index;
				resultSearch[j].ReservePath=spl[0];
				if(objMovie._visible){
					objPic.loadFadeImage(resultSearch[j].ReservePath);
				}
			}
		}
		delete(Index1);
		delete(newAlbumIDPath);
		delete(objPic);
		
	}
	else{
		var Index1=Index%NumMovie;
		if(spl[1]=="Album"){
			resultSearchArtistAlbum[Index].ReservePath=spl[0];
			if(MainLevel==3 && (StoreIndexVol1+Index1)==Index){
				if (FadeTrue) eval(Name1+Index1).loadMovie(spl[0]);
				else eval(Name+Index1).loadMovie(spl[0]);
			}
		}
		else{
			resultSearchArtistName[Index].ReservePath=spl[0];
			if(MainLevel==2 && (StoreIndexArrow1+Index1)==Index){
				if (FadeTrue) eval(Name1+Index1).loadMovie(spl[0]);
				else eval(Name+Index1).loadMovie(spl[0]);
			}
		}
	}
*/
}
_root.addProperty("SearchPathImage",_root.GetValue,_root.GetPathImage);

///................................	SPLIT FUNCTION..TRACKINFO FOR SEARCH BY ALBUM...........................................................
function con_ResultSearchTrack(trackNo, trackTitle, unicodeTrackTitle, Rating, Length, Mood, unicodeMood, danceStyle, unicodeDanceStyle, Artist, unicodeArtist, trackID,AlbumID,LanTrack,Ava,walMart_Ava,ShoppingID,NoTrack) {
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
	this.AlbumID=AlbumID;
	this.LanTrack=LanTrack;
	if(Ava.length==0)Ava=0;
	this.Ava=Ava;
	if(walMart_Ava.length==0)walMart_Ava=0;
	this.walMart_Ava=walMart_Ava;
	this.ShoppingID=ShoppingID;
	this.NoTrack=NoTrack;
}
// fucntion
function SplitResultTrack(tmp3) {
	resultSearch.length = 0;
	tmp2 = tmp3.split(StAnd);
	for (i=0; i<tmp2.length; i++) {
		tmp1 = String(tmp2[i]).split(StOr);
		var TN = String(tmp1[1]);
		var TT = String(tmp1[2]);
		var UT = String(tmp1[3]);
		var Rating = String(tmp1[10]);
		var Length = String(tmp1[11]);
		var Mood = String(tmp1[4]);
		var UniMood = String(tmp1[5]);
		var Dance = String(tmp1[6]);
		var UniDance = String(tmp1[7]);
		var Artist = String(tmp1[8]);
		var UniArtist = String(tmp1[9]);
		if(UniArtist.length<=0){
//			UniArtist=Artist;
		}
		var tID = String(tmp1[0]);
		var LanTrack = String(tmp1[12]);
		var Ava=String(tmp1[13]);
		var wal_Ava=String(tmp1[14]);
		var ShoppingID=String(tmp1[15]);
		var AlbumID=resultSearchArtistAlbum[RecordIndexArtistAlbum].id;
		var NoTrack=i+1;
		resultSearch[i] = new con_ResultSearchTrack(TN, TT, UT, Rating, Length, Mood, UniMood, Dance, UniDance, Artist, UniArtist, tID,AlbumID,LanTrack,Ava,wal_Ava,ShoppingID,NoTrack);
		resultSearch[i].Album=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;	
		resultSearch[i].UniAlbum==resultSearchArtistAlbum[RecordIndexArtistAlbum].UniArtist;
		resultSearch[i].StringPath=resultSearchArtistAlbum[RecordIndexArtistAlbum].StringPath;
		resultSearch[i].SingType=tmp1[16];
		resultSearch[i].SeekOffset=tmp1[17];
		resultSearch[i].Production=tmp1[18];
		resultSearch[i].unicodeProduction=tmp1[19];
		
		with(resultSearchArtistAlbum[RecordIndexArtistAlbum]){
			resultSearch[i].PathPic=MainPathImage+"\\"+StringPath+"\\"+Artist+ChapterName(NoTrack+1);
		}
	}
	tmp2.length = 0;
	tmp1.length = 0;
}
