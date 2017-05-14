var StOr="||";
var StAnd="&&&";
var StWave="~";
var StWaveSpl="%~%";
var StWaveSpl="%~%";
var StPer="%%";

var resultSearch = new Array();
//var StoreSearchImage="";
function con_ResultSearch(Album, unicodeAlbum, trackTitle, unicodeTrackTitle, Artist, unicodeArtist, Mood, unicodeMood, danceStyle, unicodeDanceStyle, Rating, Genre, unicodeGenre,Mode,trackID,PathPic,Lan,ComName,AlbumID,StPlayer,RePathPic,LanTrack,YearTrack,Ava,walMart_Ava,ShoppingID,NoTrack,Index,ZoomLevel,BlankTop,BlankBottom,IsBookMark,BookMarkTitle,BookMarkTime,BookMarkLength,BookMarkChapter) {
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
	this.unicodeGenre = unicodeGenre;
	this.Mode=Mode;
	this.trackID=trackID;
	this.PathPic=PathPic;
	this.Lan=Lan;
	this.ComName=ComName;
	this.AlbumID=AlbumID;
	this.StPlayer=StPlayer;
	this.RePathPic=RePathPic;
	this.LanTrack=LanTrack;
	this.YearTrack=YearTrack;
	this.Ava=Ava;
	if(walMart_Ava.length==0)walMart_Ava=0;
	this.walMart_Ava=walMart_Ava;
	this.ShoppingID=ShoppingID;
	this.NoTrack=NoTrack;
	this.ReservePath="";
	this.ZoomLevel=ZoomLevel;
	this.BlankTop=BlankTop;
	this.BlankBottom=BlankBottom;
	this.IsBookMark=IsBookMark;
	this.BookMarkTitle=BookMarkTitle;
	this.BookMarkTime=BookMarkTime;
	this.BookMarkLength=BookMarkLength;
	this.BookMarkChapter=BookMarkChapter;
}
// fucntion
function SplitResult(tmp3) {
	resultSearch.length = 0;
	tmp2 = tmp3.split(StAnd);
	for (i=0; i<tmp2.length; i++) {
		//4836||7||Bong Pit Srolanh Oun||bgBitRslaj;GUn||Romantic||menaseBa©tna||Slow||YyWt||Preap Sovath||RBab suvtþi||4||03:04.25||
		var tmp1=tmp2[i].split(StOr);
		var Al=resultAlbum[RecordIndexAlbum].Artist;
		var AlU=resultAlbum[RecordIndexAlbum].uniArtist;
		var T=String(tmp1[2]);
		var UT=String(tmp1[3]);
		var Ar=String(tmp1[8]);
		var UAr=String(tmp1[9]);
		if(UAr.length<=0){
			UAr=Ar;
		}
		var Md=String(tmp1[4]);
		var UMd=String(tmp1[5]);
		var Da=String(tmp1[6]);
		var UDa=String(tmp1[7]);
		var Rat=String(tmp1[10]);
		var Ge="";
		var UGe="";
		var Mod="Internal";
		var TId=String(tmp1[0]);
		var Lan1=resultAlbum[RecordIndexAlbum].Nation;
		var ComName1=ComName;
		var AlbumID=resultAlbum[RecordIndexAlbum].id;
		var StPlayer=ReplaceString(resultAlbum[RecordIndexAlbum].StPlayer,"%%",0,T+"||"+UT);
		var RePathPic=resultAlbum[RecordIndexAlbum].RePathPic;
		var NoTrack=(i+1);
//		SplAllCountrys[resultArtist[RecordIndexArtist].Nation].IMPath
		var PathPic1=SplAllCountrys[resultAlbum[RecordIndexAlbum].Nation].IMPath  ; //resultAlbum[RecordIndexAlbum].PicPath;
		PathPic1=PathPic1+"\\"+RePathPic+"\\"+resultAlbum[RecordIndexAlbum].Artist+ChapterName(NoTrack);
		var LanTrack=String(tmp1[12]);
		var Ava=String(tmp1[13]);
		var walMart_Ava=String(tmp1[14]);
		var ShoppingID=String(tmp1[15]);
		var YearTrack=resultAlbum[RecordIndexAlbum].Year;
		resultSearch[i] = new con_ResultSearch(Al,AlU, T, UT, Ar, UAr,  Md, UMd, Da, UDa, Rat, Ge, UGe,Mod,TId,PathPic1,Lan1,ComName1,AlbumID,StPlayer,RePathPic,LanTrack,YearTrack,Ava,walMart_Ava,ShoppingID,NoTrack,i);
		resultSearch[i].SingType=tmp1[16];						//EDID:2005.11.07
		resultSearch[i].SeekOffset=tmp1[17];						//EDID:2005.11.24
	}
	tmp2.length=0;
	tmp1.length=0;
}
/// END FUNCTION SPLIT

var resultArtist = new Array();
var resultAlbum = new Array();
function con_ArtistName(id,Artist, uniArtist, PicPath,Nation,Font,Mode,StPlayer,RePathPic,Ava,Year,SName,Index) {
	this.id=id;
	this.Artist = Artist;
	this.uniArtist = uniArtist;
	this.PicPath = PicPath;
	this.Nation=Nation;
	this.Font=Font;
	this.Mode=Mode;
	this.StPlayer=StPlayer;
	this.RePathPic=RePathPic;
	this.Ava=Ava;
	this.Year=Year;
	if(uniArtist=="" && getKhmerCountry(Nation)!="1"){
		this.uniArtist = Artist;
	}
	this.ReservePath="";
	this.SName=SName;
}

function SplitResultArtistName(tmp3) {
	resultAlbum.length=0;
	tmp2 = tmp3.split(StAnd);
	for (i=0; i<tmp2.length; i++) {		
		tmp1 = String(tmp2[i]).split(StOr);
		var Id = String(tmp1[0]);
		var Art = String(tmp1[1]);
		var uniArt = String(tmp1[2]);
		var ArtPath=String(tmp1[3]);
		var Ava=String(tmp1[5]);
		
		var Nation=resultArtist[RecordIndexArtist].Nation;
		var PicPath = SplAllCountrys[resultArtist[RecordIndexArtist].Nation].IMPath +"\\" + GetFirstLetter(ArtPath)+"\\"+ArtPath+"\\"+Art+"\\folder.jpg";
		var Font=resultArtist[RecordIndexArtist].Font;
		var Mode=resultArtist[RecordIndexArtist].Mode;
		var StPlayer=resultArtist[RecordIndexArtist].StPlayer;
		var RePathPic=GetFirstLetter(ArtPath)+"\\"+ArtPath;
		var Year=String(tmp1[8]);
		resultAlbum[i]=new con_ArtistName(Id, Art, uniArt, PicPath,Nation,Font,Mode,StPlayer,RePathPic,Ava,Year,"Album",i);
		
	}
	tmp2.length = 0;
	tmp1.length = 0;
}
//................
var resultSearchVol = new Array();
function SplitResultVol(Num, n) {
	resultSearchVol.length = 0;
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
		resultSearchVol[i] = f+" : "+f1;
	}
}
/// END FUNCTION SPLIT


function ReplaceString(Str,Sept,Index,ReStr){
	var temp=Str.split(Sept);
	var St="";
	temp[Index]=ReStr;
	St=temp.join(Sept);
	return St;
}



//var FadeTrue=false;
function GetPathImage(value){
	
	var spl=value.split("%~%");
	var Index=int(spl[2]);
	if(spl[1]=="Track"){
		resultSearch[Index].ReservePath=spl[0];
			var Index1;
			var newAlbumIDPath;
			var objPic;
			
			resultSearch[Index].ReservePath=spl[0];
			newAlbumIDPath=resultSearch[Index].PathPic;
			if(BackAlbumPic.Index==Index){
				StorePathPic=undefined;
				DisplayAlbumPictrueInfo(Index);
				//Load Album Mouse rollover
			}
			   
			for(j=0;j<nTrack;j++){
				objPic=eval(TrackName+".Pic"+j);
				objMovie=eval(TrackName+".Movie"+j);
				if(objPic.ID==newAlbumIDPath){
					Index1=objPic.Index;
					resultSearch[Index1].ReservePath=spl[0];
					if(objMovie._visible){
						objPic.loadFadeImage(resultSearch[Index1].ReservePath);
					}
				}
			}
			delete(Index1);
			delete(newAlbumIDPath);
			delete(objPic);
	}else if(spl[1]=="Chapter"){
//		if(MainLevel==4){
			IndexShowChapter=	eval("IndexShow"+TrackObj);
			CountChapter	= 	eval("Count"+TrackObj);
			newAlbumIDPath=resultSearch[Index].PathPic;
			for(j=0;j<nTrack;j++){
				objPic=eval(TrackName+".Pic"+j);
				objMovie=eval(TrackName+".Movie"+j);
				if(objPic.ID==newAlbumIDPath){
					Index1=objPic.Index;
					resultSearch[Index1].ReservePath=spl[0];
					if(objMovie._visible){
						objPic.loadFadeImage(resultSearch[Index1].ReservePath);
					}
				}
			}
			
/*			
			for(var i=0;i<resultSearch.length;i++){
				//Index contains the trackID
				if(resultSearch[i].trackID==Index){
					resultSearch[i].ReservePath=spl[0];		//assign the new path
					if(i>=IndexShowChapter and i< IndexShowChapter+CountChapter){
						objPic		=	eval(TrackName+".Pic"+(i-IndexShowChapter))
						objPic.loadFadeImage(spl[0]);
					}
				}
			}
*/			
//		}
	}else if(spl[1]=="Album" ){
		var Index1=Index%NumMovie;
		resultAlbum[Index].ReservePath=spl[0];
		if(Index<NumMovie && MainLevel==3){
			if(FadeTrue)eval(NameAlbum+".PicFade"+Index1).loadMovie(spl[0])
			else eval(NameAlbum+".Pic"+Index1).loadMovie(spl[0])
		}
	}
	else {
		var Index1=Index%NumMovie;
		resultArtist[Index].ReservePath=spl[0];
		if(Index<NumMovie && MainLevel==2){
			if(FadeTrue)eval(NameAlbum+".PicFade"+Index1).loadMovie(spl[0])
			else eval(NameAlbum+".Pic"+Index1).loadMovie(spl[0])
		}
	}
}
_root.addProperty("SearchPathImage",_root.GetValue,_root.GetPathImage);

function DownLoadAlbumImage(Count,IndexShow,StName,result){
	//***
	//...DownLoad Image.............
	var Index=0;
	fscommand("CountImageToDownload",Count);
	for(var i=0;i<Count;i++){
		Index=IndexShow+i;
		if (result[Index].ReservePath==""){
			result[Index].ReservePath=result[Index].PicPath;
			if(StName=="Artist"){
				fscommand("SearchPathImage",result[Index].ReservePath+"%~%"+StName+"%~%"+Index+"%~%"+result[Index].RePathPic+"%~%"+result[Index].Nation);
			}else{
				fscommand("SearchPathImage",result[Index].ReservePath+"%~%"+"Album"+"%~%"+Index+"%~%"+result[Index].id+"%~%"+result[Index].Nation);
			}
		}
	}
		//.....................
}