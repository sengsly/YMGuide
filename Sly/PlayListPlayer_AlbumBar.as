AlbumBar._visible = false;
function ShowPlayerAlbumBar() {
	var xml = new XML();
	xml.load(serverMainPath+"\\player.xml");
	xml.onLoad = function(success) {
		if (success) {
			NumAlbum = GettingAlbums_xml(xml);
			FirstDisplayAlbum(NumAlbum);
			if (NumAlbum>0) {
				AlbumBar._visible = true;
			}
		}
		delete (xml);
	};
}
function GettingTracks_xml() {
	var doc_xml = new XML();
	doc_xml.load(serverMainPath+"\\player.xml");
	doc_xml.onLoad = function(success) {
		if (success) {
			var saveIndex = 0;
			for (var i = 0; i<doc_xml.childNodes.length; i++) {
				saveIndex = eval("IndexShow"+TrackObj)+i;
				resultSearch[saveIndex] = doc_xml.childNodes[i].attributes;
				if (resultSearch[saveIndex].Mode == "Internal") {
					resultSearch[saveIndex].PathPic = SplAllCountrys[resultSearch[saveIndex].LanTrack].IMPath+"\\"+resultSearch[saveIndex].RePathPic+"\\"+resultSearch[saveIndex].Album+"\\folder.jpg";
				} else {
					resultSearch[saveIndex].PathPic = resultSearch[saveIndex].RePathPic;
				}
			}
			set("Count"+TrackObj, doc_xml.childNodes.length);
			DisplayItemTrack(TrackName, eval("IndexShow"+TrackObj), eval("Count"+TrackObj), nTrack, true);
			delete (saveIndex);
		}
		delete (doc_xml);
	};
}
function GettingAlbums_xml(xmlSource) {
	var doc_xml = new XML(xmlSource);
	var root_xml;
	resultAlbum.length = 0;
	root_xml = doc_xml.firstChild;
	for (var i = 0; i<root_xml.childNodes.length; i++) {
		resultAlbum[i] = root_xml.childNodes[i].attributes;
		resultAlbum[i].PicPath = SplAllCountrys[resultAlbum[i].Language].IMPath+"\\"+resultAlbum[i].RePathPic+"\\"+resultAlbum[i].Name+"\\folder.jpg";
		resultAlbum[i].LanPath = SplAllCountrys[resultAlbum[i].Language].DBPath;
	}
	delete (doc_xml);
	return resultAlbum.length;
}
function GettingAlbums() {
	var n = resultSearch.length;
	if (n>0) {
		resultAlbum.length = 0;
		var temp = new Array();
		var f = false;
		var ID = "";
		var Al = "";
		var UniAl = "";
		var PicPath = "";
		var LanPath = "";
		var StPlayer = "";
		var RePathPic = "";
		for (var j = 0; j<n; j++) {
			if (resultSearch[j].Mode<>"External") {
				f = false;
				Al = resultSearch[j].Album;
				for (var i = 0; i<temp.length; i++) {
					if (temp[i] == Al) {
						f = true;
						break;
					}
				}
				if (!f) {
					temp[temp.length] = Al;
					ID = resultSearch[j].LanPath;
					//assign ID of Album
					UniAl = resultSearch[j].unicodeAlbum;
					PicPath = resultSearch[j].PathPic;
					LanPath = SplAllCountrys[resultSearch[j].Lan].IMPath;
					//					fscommand(SplAllCountrys[resultSearch[j].Lan]
					StPlayer = resultSearch[j].StPlayer;
					RePathPic = resultSearch[j].RePathPic;
					var YearTrack = resultSearch[j].YearTrack;
					if (getKhmerCountry(resultSearch[j].Lan) == "1" && FontKhmer.length<=0) {
						var spl1 = resultSearch[j].StPlayer.split("%%");
						var spl2 = spl1[2].split(StWave);
						var spl3 = spl2[1].split("||");
						FontKhmer = spl3[1];
					}
					resultAlbum[resultAlbum.length] = new con_ResultAlbum(ID, Al, UniAl, PicPath, resultSearch[j].Lan, LanPath, StPlayer, RePathPic, YearTrack);
				}
			}
		}
		return resultAlbum.length;
	}
}
//.............................
function DisplayItemAlbum(Obj, Index, Count, nItem) {
	Index=int(Index);
	Count=int(Count);
	nItem=int(nItem);
	DownLoadAlbumImage(resultAlbum.length, 0, resultAlbum);
	NameC = "AlbumBar.Pic";
	Name1C = "AlbumBar.PicFade";
	NameFadeC = "AlbumBar.Movie";
	PicNameC.length = 0;
	for (var j = 0; j<nItem; j++) {
		if (j<Count) {
			if (Unregistered == "False") {
				eval(Obj+".Logo"+j)._visible = true;
			} else {
				eval(Obj+".Logo"+j)._visible = false;
			}
			eval(Obj+".Movie"+j)._visible = true;
			eval(Obj+".Button"+j)._visible = true;
			//PicNameC[j]=resultAlbum[Index+j].PicPath;
			PicNameC[j] = resultAlbum[Index+j].ReservePath;
		} else {
			eval(Obj+".Button"+j)._visible = false;
			eval(Obj+".Movie"+j)._visible = false;
			eval(Obj+".Pic"+j)._visible = false;
			eval(Obj+".Pic"+j).unloadMovie();
			eval(Obj+".PicFade"+j).unloadMovie();
			eval(Obj+".Text"+j)._visible = false;
			eval(Obj+".Cover"+j)._visible = false;
			eval(Obj+".Logo"+j)._visible = false;
		}
	}
	ResetC(Count);
	DisplayTextAlbum(Obj, Index, Count, nItem);
	//DeselectedItem(Obj,Index,RecordIndexGenre,nItem);
}
function DisplayTextAlbum(Obj, Index, Count, nItem) {
	for (var j = 0; j<nItem; j++) {
		if (j<Count) {
			var displayUnicode=false;
			if(ChangeLan=="Uni"){
				displayUnicode=(resultAlbum[Index+j].UniName <>"") 
			}else{
				displayUnicode=(resultAlbum[Index+j].Name == "") 
			}
			if (AlbumCover == "No") {
				eval(Obj+".Text"+j)._visible = false;
				eval(Obj+".Cover"+j)._visible = false;
			} else {
				eval(Obj+".Text"+j)._visible = true;
				eval(Obj+".Cover"+j)._visible = true;
			}
			if(displayUnicode){
				eval(Obj+".Text"+j).text = resultAlbum[Index+j].UniName;
			}else{
				eval(Obj+".Text"+j).text = resultAlbum[Index+j].Name;
			}
			ChangeFontGenreBar(displayUnicode ? "Uni":"Eng", getKhmerCountry(resultAlbum[Index+j].Language), j);
		}
	}
}
///............................FUNCTION DISPLAYGENREBAR......................
var RecordIndexAlbum = 0;
function FirstDisplayAlbum(n) {
	FirstDisplay("Album", n, nAlbum);
	DisplayItemAlbum("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum);
}
AlbumBar.ButtonLeft.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("AlbumBar.MovieLeft");
};
AlbumBar.ButtonRight.onRollOver = function() {
	SelectLevel = 2;
	SelectButton("AlbumBar.MovieRight");
};
AlbumBar.ButtonLeft.onRelease = function() {
	if (send_event("normal&&&Click||"+ this+ "||4",false)){
		return; 
	}
	ClickLeft("Album");
	DisplayItemAlbum("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum);
};
AlbumBar.ButtonRight.onRelease = function() {
	if (send_event("normal&&&Click||"+ this+ "||4",false)){
		return; 
	}

	ClickRight("Album");
	DisplayItemAlbum("AlbumBar", IndexShowAlbum, CountAlbum, nAlbum);
};
var PicXBar = new Array();
var PicYBar = new Array();
var ClickAlbum = false;
for (var j = 0; j<nAlbum; j++) {
	eval("AlbumBar.Button"+j).onRollOver = function() {
		var k = GetNumber(this._name);
		var Index = IndexShowAlbum+k;
		var tf = new TextFormat();
		var tmpLan = "";

		tf = eval("AlbumBar.Text"+GetNumber(this._name)).getTextFormat();
		SelectLevel = 2;
		SelectButton("AlbumBar.Movie"+GetNumber(this._name));
		//TextTip.text =eval("AlbumBar.Text"+GetNumber(this._name)).text;
		popup_tooltip("TextTip:ButtonTip", eval("AlbumBar.Text"+GetNumber(this._name)).text);
		if (!TextTip._visible) {
			ButtonTip._visible = true;
			TextTip._visible = true;
		}
		
		if (tf.font == "Arial")
			tmpLan="Eng";
		else
			tmpLan="Uni";

		ChangeProTitleFont(tmpLan, getKhmerCountry(resultAlbum[Index].Language));
		ButtonTipChange();
	};
	eval("AlbumBar.Button"+j).onRelease = function() {
		var index2Click;
		
		index2Click = IndexShowAlbum + GetNumber(this._name);
		clickAlbumBar(index2Click);
		eval(TrackName).Button0.onRollOver();
		
		
/*		
		AlbumBar._visible = false;
		var k = GetNumber(this._name);
		RecordIndexAlbum = IndexShowAlbum+k;
		eval(TrackName).Button0.onRollOver();
		ClickAlbum = true;
		fscommand("GetArtistTrackInfo", resultAlbum[RecordIndexAlbum].ID+"~"+resultAlbum[RecordIndexAlbum].LanPath);
*/		
	};
	PicXBar[j] = eval("AlbumBar.Pic"+j)._x;
	PicYBar[j] = eval("AlbumBar.Pic"+j)._y;
}
var StoreStSearch = "";
var StoreUni = "";
function SearchByAlbum(Str, Uni) {
	StoreStSearch = Str;
	StoreUni = Uni;
	if (FirstLoadAlbum) {
		fscommand("GetAllTracks", resultSearch.length);
		FirstLoadAlbum = false;
		return;
	}
	if (!Uni) {
		for (var j = 0; j<resultAlbum.length; j++) {
			if (Str == resultAlbum[j].Name) {
				AlbumBar._visible = false;
				RecordIndexAlbum = j;
				if (!ClickAlbum) {
					ClickAlbum = true;
				}
				fscommand("GetArtistTrackInfo", resultAlbum[RecordIndexAlbum].ID+"~"+resultAlbum[RecordIndexAlbum].Language);
				return;
			}
		}
	} else {
		for (var j = 0; j<resultAlbum.length; j++) {
			if (Str == resultAlbum[j].UniName) {
				AlbumBar._visible = false;
				RecordIndexAlbum = j;
				if (!ClickAlbum) {
					ClickAlbum = true;
				}
				fscommand("GetArtistTrackInfo", resultAlbum[RecordIndexAlbum].ID+"~"+resultAlbum[RecordIndexAlbum].Language);
				return;
			}
		}
	}
}
function DownLoadAlbumImage(Count, IndexShow, result) {
	//...DownLoad Image.............
	var Index = 0;
	fscommand("CountImageToDownload", Count);
	for (var i = 0; i<Count; i++) {
		Index = IndexShow+i;
		if (result[Index].ReservePath == "") {
			result[Index].ReservePath = result[Index].PicPath;
			fscommand("SearchPathImage", result[Index].ReservePath+"%~%"+"Album"+"%~%"+Index+"%~%"+result[Index].ID+"%~%"+result[Index].Language);
		}
	}
	//.....................
}
function clickAlbumBar (clickIndex) {
	clickIndex = int(clickIndex);
	if (send_event("normal&&&function||clickAlbumBar|~|" + clickIndex + "||4",false)){
		return; 
	}
	
	AlbumBar._visible = false;
	RecordIndexAlbum = clickIndex;
//	eval(TrackName).Button0.onRollOver();
	ClickAlbum = true;
	fscommand("GetArtistTrackInfo", resultAlbum[RecordIndexAlbum].ID+"~"+resultAlbum[RecordIndexAlbum].Language);	
}
