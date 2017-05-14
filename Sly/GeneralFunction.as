var KeyPreAlbum=188;
var KeyNextAlbum=190;
var keyHideMouse = 114;
var KeyMin=191;	// - Use Ctrl + / to Minimize software to taskbar
var KeySlide=192;
var KeyBMyAlbum=48	// - Use Ctrl + 0, to set Browse by MyAlbums
var KeyAlbumCover=49;	//- Use Ctrl + 1, to set AlbumCover 
var KeyNumCover=50;	//- Use Ctrl + 2, to set NumCover 
var KeyPlusCover=51;	//- Use Ctrl + 3, to set PlusCover 
var KeyBGenre=52;	 	//- Use Ctrl + 4, to set Browse by Genre
var KeyBProduction=53; 	//- Use Ctrl + 5, to set Browse by Production
var KeyBRating=54		// - Use Ctrl + 6, to set Browse by Rating
var KeyBReleaseDate=55	// - Use Ctrl + 7, to set Browse by Release Date
var KeyBMyFavAlbum=56	// - Use Ctrl + 8, to set Browse by MyFavAlbums
var KeyBMyFavArtist=57	// - Use Ctrl + 9, to set Browse by MyFavArtists
var KeyPlayer=89;
var KeyLanguage=76;
var client_receive = "true";
var clientType = "";
var COLOR_DISABLED=0x999999;
//var   serverWebsite="http://www.slymultimedia.com"
//var serverWebsite="http://192.168.100.136/slymultimedia"

//.....................................
function GetFirstLetter(str){
	if(parseInt(substring(str,0,1),10)>0 || substring(str,0,1)=="0"){
		return "#";
	}
	else{
		return substring(str,0,1);
	}
}

function ScalePicture(XMax,YMax,x1,y1,w,h,NamePic){
		
		var ScaleArtist;
		eval(NamePic)._x=x1;
		eval(NamePic)._y=y1;
		var Y = w;
  	    	var X = w * (XMax / YMax);

		if(XMax>YMax)ScaleArtist="Width";
		else ScaleArtist="Height";
		if(ScaleArtist=="Height"){
			

			eval(NamePic)._height = int(Y);
         			eval(NamePic)._width = int(X);
			//msgbox(NamePic+","+Y+","+X);
			if (X < w){
   				var x2 = (w- X) / 2
		    		eval(NamePic)._x=x1+x2;
			}
		 }
		else{
			 X=w;
			 Y=w*YMax/XMax;
			 eval(NamePic)._height =int(Y);			 
			eval(NamePic)._width= int(X);
			//msgbox(NamePic+","+Y+","+X);		
			 
			 if (Y <w){
   				var y2 = (w - Y) / 2
		    		eval(NamePic)._y=y1+y2;
			 }
		 }
}
//..................................USING KEY.................
function MoveLeftRight(Obj,Str,Count,Move){
	if(Move=="Right"){

		if(Str==Obj+".MovieLeft"){
			eval(Obj+".Button0").onRollOver();
		}
		else if(Str==Obj+".MovieRight"){
			eval(Obj+".ButtonLeft").onRollOver();
		}
		else {
			var Index=GetNumber(Str)+1;
			if(Index<Count){
				eval(Obj+".Button"+Index).onRollOver();
			}
			else{
				if(eval(Obj+".ButtonRight")._visible) eval(Obj+".ButtonRight").onRollOver();
				else eval(Obj+".Button"+0).onRollOver();
			}
		}
	}
	else{
		if(Str==Obj+".MovieLeft"){
			eval(Obj+".ButtonRight").onRollOver();
		}
		else if(Str==Obj+".MovieRight"){
			eval(Obj+".Button"+(Count-1)).onRollOver();
		}
		else {
			var Index=GetNumber(Str)-1;
			if(Index>=0){
				eval(Obj+".Button"+Index).onRollOver();
			}
			else{
				if(eval(Obj+".ButtonLeft")._visible) eval(Obj+".ButtonLeft").onRollOver();
				else eval(Obj+".Button"+(Count-1)).onRollOver();
			}
		}
	}
}

function StrReplace(strSource, strFind, strReplace) {
	//Seng CreateNew to Instead of Replace()[Doesn't work correctly] 2006-07-12
	var iIndex=strSource.indexOf(strFind);
	if(iIndex>=0){
		return substring(strSource,0,iIndex)+strReplace+substring(strSource,iIndex+strFind.length+1);
	}else{
		return strSource;
	}
}
function StaticMove(Obj, Str, Move) {
	//Seng Modified 2006-07-12
	var boolFound = false;
	var iLoopCount;
	var sReturnName;
	var Spl = Obj.toLowerCase().split(",");
	Str=Str.toLowerCase();

	for (var iLoopCount = 0; iLoopCount<2; iLoopCount++) {
		if (Move == "Right") {
			for (var j = 0; j<Spl.length; j++) {
				//Block Start
				if (boolFound){
					if(eval(Spl[j])._visible and eval(Spl[j]).enabled and eval(Spl[j])._parent._visible and eval(Spl[j])._parent.enabled) {
						//skip if parent is not (visible,enable) and itself as well
						sReturnName = Spl[j];
						break;
					
					}
				}
				if (Spl[j] == Str) {
					boolFound = true;
				}
				// Block The same
			}
		} else {
			for (var j = Spl.length-1; j>=0; j--) {
				//Block Start
				if (boolFound){
					if(eval(Spl[j])._visible and eval(Spl[j]).enabled and eval(Spl[j])._parent._visible and eval(Spl[j])._parent.enabled) {
						//skip if parent is not (visible,enable) and itself as well
						sReturnName = Spl[j];
						break;
					}
				}
				if (Spl[j] == Str) {
					boolFound = true;
				}
				// Block The same
			}
		}
		if(sReturnName!=undefined) break;
	}
	if(sReturnName!=undefined){
		if(typeof(eval(sReturnName))=="movieclip"){
			eval(Replace(sReturnName, "movie","Button")).onRollOver();
		}else{
			Selection.setFocus(sReturnName);
		}
	}
}

function Replace(Str, FStr, RStr) {
	var n = FStr.length;
	for (var j = 0; j<Str.length; j++) {
		if (substring(Str, j, n) == FStr) {
			return substring(Str, 0, j-1)+RStr+substring(Str, (j+n), -1);
		}
	}
	return Str;
}
function GetNumber(Str) {
	var str1 = "";
	if (!isNaN(parseInt(substring(Str, Str.length-1, 1), 10))) {
		str1 = str1+substring(Str, Str.length-1, 1);
	}
	if (parseInt(substring(Str, Str.length, -1), 10)>=0) {
		str1 = str1+substring(Str, Str.length, -1);
	}
	return parseInt(str1);
}

///........................................................ClickLeftRight
function VisibleArrow (value,Obj) {
	eval(Obj+".MovieLeft")._visible=value;
	eval(Obj+".ButtonLeft")._visible=value;
	eval(Obj+".TextLeft")._visible=value;
	eval(Obj+".IconLeft")._visible=value;
	
	eval(Obj+".MovieRight")._visible=value;
	eval(Obj+".ButtonRight")._visible=value;
	eval(Obj+".TextRight")._visible=value;
	eval(Obj+".IconRight")._visible=value;
}

function FirstDisplay(Obj,n,nItem) {
	set("n"+Obj,nItem);
	set("LevelIndex"+Obj,1);
	set("TotalLevelIndex"+Obj,0);
	set ("Num"+Obj,n);
	set("IndexShow"+Obj,0);
	
	if(eval("Num"+Obj)>nItem){
		VisibleArrow (true,Obj+"Bar")
		set("Count"+Obj,nItem);
	} else {
		VisibleArrow (false,Obj+"Bar")
		set("Count"+Obj,eval("Num"+Obj));
	}
	if (eval("Num"+Obj)%nItem == 0) {
		set("TotalLevelIndex"+Obj, int(eval("Num"+Obj)/nItem));
	} else {
		set("TotalLevelIndex"+Obj, int(eval("Num"+Obj)/nItem)+1);
	}
}
function ClickLeft(Obj) {
	set("LevelIndex"+Obj,eval("LevelIndex"+Obj)- 1);
	if (eval("LevelIndex"+Obj)<=0) {
		set("LevelIndex"+Obj,eval("TotalLevelIndex"+Obj));
		var VMul =eval("LevelIndex"+Obj)*eval("n"+Obj);
		var VMode = eval("Num"+Obj)%eval("n"+Obj);
		if (VMode == 0) {
			var ValueDec = VMul;
		} else {
			var ValueDec = (VMul-eval("n"+Obj))+VMode;
		}
	} else {
		var VMul = eval("LevelIndex"+Obj)*eval("n"+Obj);
		var ValueDec = VMul;
	}
	var nMode = ValueDec%eval("n"+Obj);
	set("IndexShow"+Obj, (eval("LevelIndex"+Obj)-1)*eval("n"+Obj));
	if (nMode<>0) {
		set("Count"+Obj,nMode);
	} else {
		set("Count"+Obj,eval("n"+Obj));
	}
	
};
function ClickRight(Obj){
	var ValueIn = eval("LevelIndex"+Obj)*eval("n"+Obj);
	set("LevelIndex"+Obj,eval("LevelIndex"+Obj) + 1);
	if (eval("LevelIndex"+Obj)>eval("TotalLevelIndex"+Obj)){
		set("LevelIndex"+Obj,1);
	}
	set("IndexShow"+Obj, (eval("LevelIndex"+Obj)-1)*eval("n"+Obj));
	var Index=0;
	if (eval("Num"+Obj)>ValueIn) {
		for (var j = 0; j<eval("n"+Obj); j++) {
			if (ValueIn<eval("Num"+Obj)) {
				ValueIn += 1;
				Index+=1;
			}
		}
		set("Count"+Obj,Index);
	} else {
		set("Count"+Obj,eval("n"+Obj));
	}
};

//..................................................................................................
//..................................................................................................
//..................................................................................................
// FUNCTION FOR TOOLTIP
function ft_DisplayToolTip(obj, TextTip, x, y, TF, TFTT) {	
	var toolTipBackgroundColor = "0xFFFFE1";//"0xF6EBC0";
	var toolTipBorderColor = "0x000000";
	var toolTipTextColor = "0x000000";
	var toolTipsf = new TextFormat();
	toolTipsf.font = "Arial";
	toolTipsf.size = "15";
	if (TF == true) {
		if(TFTT=="true"){
			eval("_root." + obj)._visible = true;
			eval("_root." + obj).text = TextTip;
			eval("_root." + obj).setTextFormat(toolTipsf);
			eval("_root." + obj).autoSize = true;

//			eval("_root." + obj).text = TextTip + eval("_root." + obj)._width;
//			eval("_root." + obj).setTextFormat(toolTipsf);
//			eval("_root." + obj).autoSize = true;

			eval("_root." + obj).background = true;
			eval("_root." + obj).backgroundColor = toolTipBackgroundColor;
			eval("_root." + obj).border = true;
			eval("_root." + obj).borderColor = toolTipBorderColor;
			eval("_root." + obj).textColor = toolTipTextColor;
			eval("_root." + obj)._x = x;
			eval("_root." + obj)._y = y;
			clr = 0;
			clearInterval(clearToolTip);
			clearToolTip = setInterval(FadeTooltip,300,obj);
		}
	} else {
		eval("_root." + obj).text = "";
		eval("_root." + obj).background = false;
		eval("_root." + obj).border = false;
		eval("_root." + obj)._x = 800;
		eval("_root." + obj)._y = 600;
		clearInterval(clearToolTip)
	}
}
function FadeTooltip(str) {
	clr += 10;
	if (clr>=50) {
		ft_DisplayToolTip(str, "", 0, 0, false, "false");
	}
}

function DisplayTooltip(objn,obj,str,SH,leftX,leftY,force){
	// objn			: object name
	// objx & objy		: object location
	// objw & objh		: object width and height
	// mx & my		: mouse location
	// obj			: text object name
	// str			: text tooltip
	// SH			: show and hide tooltip setting
	// leftX & leftY		: tooltip location	
	
	cs = objn.getBounds(_root);	
	var mx = _root._xmouse;
	var my = _root._ymouse;
	var mxl = cs.xMin; 	//	: mouse x left
	var mxr = cs.xMax;	//	: mouse x right
	var myt = cs.yMin;	//	: mouse y top
	var myb = cs.yMax;	//	: mouse y buttom
	
	//fscommand("reply",(mxl + " < " + mx) + " : " + (mx + " < " + mxr) + " : " + (myt + " < " + my) + " : " + (my + " < " + myb))
	if(force==true){
		ft_DisplayToolTip(obj, str,100,100, true, SH);
		return;
	}
	if((mxl <= mx) and (mx <= mxr) and (myt <= my) and (my <= myb) ){		
		ft_DisplayToolTip(obj, str,mx + int(leftX),my + int(leftY), true, SH);
	}
	
}
function CallTooltip(arg){
	var ss = new Array();
	ss = String(arg).split("~");
	ft_DisplayToolTip(ss[0],ss[1],ss[2],ss[3],true,ss[5]);
	clearInterval(dddd);
	delete(dddd);
}
function HideTooltip(obj){
	clearInterval(dddd);
	delete(dddd);
	ft_DisplayToolTip(obj, "", 800, 600, false, "false");
}
//..................................................................................................
//..................................................................................................
//..................................................................................................
// function for fading
	// - obj 		: name of object
	// - even		: rollOver or rollOut
function fade(obj,event){
	if(event=="Over"){
		eval(obj+".fo")._visible=true
		eval(obj+".fi")._visible=false
		eval(obj+".fo").gotoAndPlay(2)
	}else{
		eval(obj+".fo")._visible=false
		eval(obj+".fi")._visible=true
		eval(obj+".fi").gotoAndPlay(2)
	}	
}
//........................

function DisplayToolTipTrack(TFTT) {	
	if(TFTT){
			clr=0;
			clearInterval(clearToolTip1);
			clearToolTip1 = setInterval(FadeTooltipTrack,300);
	}
	
}


function DisplayToolTipStar(TFTT) {	
	if(TFTT){
//			if(!eval(TrackName).BackStars._visible){
//				VisibleIconAlbum(true);
//			}	
			clr2=0;
			clearInterval(clearToolTip2);
			clearToolTip2 = setInterval(FadeTooltipStar,1000);
	}
	
}

function FadeTooltipStar() {
	clr2 += 1;
	if (clr2>=5) {
		VisibleIconAlbum(false);
		clearInterval(clearToolTip2);
	}
}
function VisibleIconAlbum(b){
	eval(TrackName).BackStars._visible=b;
	eval(TrackName).MusicNote._visible=b;
	eval(TrackName).SearchPlayerPage._visible=b;
	eval(TrackName).RefreshCoverArt._visible=b;
	eval(TrackName).DefaultVLC._visible=b;
              	eval(TrackName).FlagGroup._visible=b;
              	eval(TrackName).chkOffset._visible=b;
	eval(TrackName).CoverArtType._visible=b;
	eval(TrackName).Mood._visible=b;
	eval(TrackName).CoverArtType._visible=b;
	eval(TrackName).Year._visible=b;
	eval(TrackName).Artist._visible=b;
	eval(TrackName).CoverTrackInfo._visible=b;
	eval(TrackName).RIPCD._visible=(b and (databaseType==16));
              	eval(TrackName).ScanAlbum._visible=b;
	eval(TrackName).MainTitle._visible=(b && clientType==serverMode);
	eval(TrackName).fileType._visible =b;
	eval(TrackName).PathChapter._visible=b;
	eval(TrackName).PlusIcon._visible=b and (DisplayFromSearch!=1);
	eval(TrackName).audiochannel._visible=(b and (databaseType==8 or databaseType==4));
	eval(TrackName).offset._visible=(offsetEnabled)? b : false;
              	eval(TrackName).download_song._visible=   (b and current_status==1);
	eval(TrackName).PlayTrailer._visible=(b and GetTrailerAvailable==1) ;
	eval(TrackName).BrowseTrailer._visible=b ;
	eval(TrackName).PathSlideshow._visible=b ;
	eval(TrackName).AddToPlay._visible=(b and (databaseType==8 or databaseType==4));
              	eval(TrackName).DTS._visible=b and eval(TrackName).DTS.Available;

	if(b){
               	eval(TrackName).DD._visible=b and eval(TrackName).DD.Available;
		eval(TrackName).PlusIcon.Selected._visible=eval(TrackName).PlusIcon.Available;
		eval(TrackName).Rank._visible=eval(TrackName).PlusIcon.Selected._visible;
		eval(TrackName).PathSlideshow.Button.enabled=(b && clientType==serverMode);
       		eval(TrackName).ScanAlbum.Button.enabled=(b && clientType==serverMode);
		eval(TrackName).fileType.Button.enabled =(b && clientType==serverMode);
		eval(TrackName).PlayTrailer.Button.enabled =((b and GetTrailerAvailable==1) && clientType==serverMode);
		eval(TrackName).PathChapter.Button.enabled=(b && clientType==serverMode);
		eval(TrackName).BrowseTrailer.Button.enabled=(b && clientType ==serverMode);
		eval(TrackName).PathSlideshow.Movie.enabled=(b && clientType==serverMode);
       		eval(TrackName).ScanAlbum.Movie.enabled=(b && clientType==serverMode);
		eval(TrackName).fileType.Movie.enabled =(b && clientType==serverMode);
		eval(TrackName).PlayTrailer.Movie.enabled =((b and GetTrailerAvailable==1) && clientType==serverMode);
		eval(TrackName).PathChapter.Movie.enabled=(b && clientType==serverMode);
		eval(TrackName).BrowseTrailer.Movie.enabled=(b && clientType ==serverMode);
	}
	else if(!b){
		eval(TrackName).Rank._visible=b;
	}
}

function ReturnLevel(Num,nItem){
	if (Num%nItem == 0) {
		return int(Num/nItem);
	} else {
		return int(Num/nItem)+1;
	}
}

//..................................................................................................
//..................................................................................................
//..................................................................................................

function set_dot_dot(obj_txt,val_str,fm,text_width){
	var _str = val_str;
	var space_boo = false;
	var multiLine_boo = false;
	var dot_str = "";
	var obj_width = text_width;
	var tmp_str = "";
	var store_str = "";
	
	var afterCut_str = _str;
	var haveLongOne_str = true;	// find a word that long at the first
	var spaceIndex_int = 0;
	var concate_str = "";
	
	fm.bold = false;
	
	if (String(fm.font).substr(0,5)=="Limon"){
		dot_str = ">>>";
	}else{
		dot_str = "...";
	}

	obj_txt.valText = _str;
		
	obj_txt.autoSize = false;
	obj_txt._width = obj_width;

	obj_txt.text = _str;
	obj_txt.wordWrap = true;
	obj_txt.setTextFormat(fm);
	multiLine_boo = obj_txt.maxscroll>1;
	obj_txt.wordWrap = false;
	space_boo = _str.indexOf(" ")>-1;

	if (multiLine_boo == false){
		obj_txt.dot = false;
		return _str;		
	}
	
	if (space_boo == true){
		for (var init=0; init<_str.length; init++){
			// fined space index
			spaceIndex_int = afterCut_str.indexOf(" ");
			// get concate string
			concate_str = afterCut_str.substr(0,spaceIndex_int);
			// cut string start from space index
			afterCut_str = afterCut_str.substr(spaceIndex_int+1);
			// check for the first word to see it longer than text controll or not
			if (haveLongOne_str == true){
				obj_txt.text = concate_str + dot_str;
				obj_txt.autoSize = true;
				obj_txt.setTextFormat(fm)
				obj_txt._width;
				if (obj_txt._width >= obj_width){					
					_str = concate_str;
					for (var init=0; init<_str.length; init++){						
						tmp_str = _str.substr(0,init) + dot_str;						
						obj_txt.text = tmp_str;
						obj_txt.setTextFormat(fm);
						obj_txt.autoSize = true;
						//mb(obj_txt._width + " >= " + obj_width);
						obj_txt._width;
						if (obj_txt._width >= obj_width){
							obj_txt.dot = true;
							return store_str;
						}
						store_str = tmp_str;
						obj_txt.autoSize = false;
					}
				}else{
					obj_txt.autoSize = false;
					obj_txt._width = obj_width;
					haveLongOne_str = false;
				}
			}
			
			// start concate all of string
			if (tmp_str == ""){
				tmp_str = concate_str;
			}else{				
				tmp_str = tmp_str + " " + concate_str;
			}
			obj_txt.text = tmp_str + dot_str;
			obj_txt.autoSize = true;
			obj_txt.setTextFormat(fm);
			obj_txt._width;
			if (obj_txt._width >= obj_width){				
				obj_txt.dot = true;
				return store_str;
			}
			store_str = tmp_str + dot_str;
			obj_txt.autoSize = false;
			
			// set init to space index
			if (afterCut_str.indexOf(" ")==-1){
				init = _str.length;
				obj_txt.dot = true;
				return store_str;
			}else{
				init = spaceIndex_int;
			}			
		}
	}else{
		for (var init=0; init<_str.length; init++){
			tmp_str = _str.substr(0,init) + dot_str;
			obj_txt.text = tmp_str;
			obj_txt.setTextFormat(fm);
			obj_txt.autoSize = true;
			obj_txt._width;
			if (obj_txt._width >= obj_width){
				obj_txt.dot = true;
				return store_str;
			}
			store_str = tmp_str;
			obj_txt.autoSize = false;
		}
	}
}
//==========================================================================
// function popup tooltip
function popup_tooltip(strObj,val){
	var spl_array = new Array();
	spl_array = String(strObj).split(":");
	eval(spl_array[0]).text = val;
	eval(spl_array[0])._visible = true;
	eval(spl_array[1])._visible = true;
	clearInterval(ID_popup_tooltip);
	ID_popup_tooltip=setInterval(hide_popup_tooltip,3000,strObj);
}
function hide_popup_tooltip(strobj){
	var spl_array = new Array();
	spl_array = String(strObj).split(":");
	clearInterval(ID_popup_tooltip);
	eval(spl_array[0])._visible = false;
	eval(spl_array[1])._visible = false;
}
// function download cdxml use this 
//var xml= new readCDXML("http://www.slymultimedia.com/cds/cdxml.xml","English");
//xml.onLoad=function(success) {
//	trace(this.dbServer);
//	trace(this.imageServer);
//}

function readCDXML (path,currentCountry) {
	var cdXML_xml= new XML();
	var Main=this;
		Main.dbServer=""
		Main.imageServer=""
	
	cdXML_xml.load(path);
	cdXML_xml.onLoad=function (success) {
		if(success){
			var xmlLanguages=cdXML_xml.firstChild.childNodes;
			var xmlElement;
			for (var i=0;i<xmlLanguages.length;i++){
				xmlElement=xmlLanguages[i].attributes;
				country=xmlElement.countryName;
				if(country.toLowerCase()==currentCountry.toLowerCase()){
					Main.imageServer = xmlElement.imageServer;
					Main.dbServer    = xmlElement.dbServer;
					Main.onLoad(success);
					return;
				}
			}
		}
		Main.onLoad(false);
	}	
}
function unloadFlash() {
	//unload itself from the flash movie
	//array parameter specified the in the argument (Key1,Key2,Key3)
	for (i=0; i<arguments.length; i++) {
		Key.removeListener(eval(arguments[i]));
	}
	unloadMovie(_root);
}
function UnloadItSelf(vValue) {
	var objList = vValue.split(",");
	unloadFlash.apply(null,objList);
}

function selectionGetfocus() {
	return Selection.getFocus();
}

var functionName = undefined;
function functionGet() {
	var functs = new Array();
	functs = String(functionName).split(chr(1)+chr(2));
	return eval(functs.shift()).apply(null, functs);
}
function  chapterName(chapterNumber) {
	if(int(chapterNumber)<10){
		chapterNumber="0"+chapterNumber;
	}
	return "\\chpt"+chapterNumber+".jpg";
}
function functionSet(varValue) {
}

addProperty("getFunction", functionGet, functionSet);