var screen = 0;
var storeName = "MoviePicC";
var level = 0;
var str_infoPopup = "";
var tmpStr = "";
var b_ads = true;
_global.serverMode = 0;
_global.clonePlayBack = 1;
_global.remotePlaylist = 2;
_global.remoteControl = 3;
var clientType = serverMode;
var click_self = true;
//========================================
var time_hideSelected = 10;
var tmp_mouse_x = 0;
var tmp_mouse_y = 0;
var b_move = true;
function hideSelected() {
	clearInterval(hideSelectID);
	changeColor_alpha(storeName, val_buttonColor, val_buttonAlpha);
	storeName = "";
}
function resetInterval(){
//	clearInterval(hideSelectID);
//	hideSelectID = setInterval(hideSelected, (1000*time_hideSelected));
}
function moveMove() {
	if ((String(_xmouse)+String(_ymouse) == String(tmp_mouse_x)+String(tmp_mouse_y)) and (b_move == true)) {
		clearInterval(hideSelectID);
		hideSelectID = setInterval(hideSelected, (1000*time_hideSelected));
		b_move = false;
	}
	if (b_move == true) {
		clearInterval(hideSelectID);
	}
	tmp_mouse_x = _xmouse;
	tmp_mouse_y = _ymouse;
}
//========================================
function displayTrackInfoVisual(str) {	
	if(tmpStr!=str){
		var tf = new TextFormat();
		tmpStr = str;
		bg_bitrate._visible = false;
		txtpos_n._visible = false;
		txtbit_n._visible = false;
		
		txtpos_v._visible = false;
		txtbit_v._visible = false;

		clearInterval(timeDelayID);
		var arr_bp = new Array();
		var txt = new Array();
		arr_bp = String(str).split("//\\\\");
		txt = arr_bp[4].split("{|}");
		if(txt[1]=="1")
		{
			tf.font = arr_bp[5];
			tf.size = 40;
		}else
		{
			tf.font = arr_bp[5];
			tf.size = 35;
		}
		if (MoviePicC._visible == false) {
			txtpos_v.text = arr_bp[0];
			txtbit_v.text = txt[0]
			txtpos_v._visible = true;
			txtbit_v._visible = true;
			bg_bitrate._visible = false;
		} else {
			txtpos_n.text = arr_bp[0];		
			txtbit_n.text = txt[0];
			txtpos_n._visible = true;
			txtbit_n._visible = true;
			if (txtbit_n.text != "" && txtbit_n._visible == true) {
				bg_bitrate._visible = true;
			}
			txtbit_n.setTextFormat(tf);
		}
		
		timeDelayID = setInterval(timeDelay, 5000);
	}
}
function timeDelay() {
	txtpos_v.text = "";
	txtbit_v.text = "";
	txtbit_v._visible = false;
	txtpos_v._visible = false;
		
	txtpos_n.text = "";
	txtbit_n.text = "";
	txtbit_n._visible = false;
	txtpos_n._visible = false;		
	bg_bitrate._visible = false;
		
	clearInterval(timeDelayID);
}
//========================================
function mb(str) {
	fscommand("mb", str);
}
function changeColor_alpha(obj, col, alpha) {
	mycol = new Color(obj);
	mycol.setRGB(col);
	eval(obj)._alpha = alpha;
}
function changeColor(obj, col) {
	mycol = new Color(obj);
	mycol.setRGB(col);
}
function selectObj(obj) {
	if (storeName != obj) {
		changeColor_alpha(storeName, val_buttonColor, val_buttonAlpha);
	}
	changeColor_alpha(obj, val_buttonSelectedColor, val_buttonSelectedAlpha);
	storeName = obj;
}
var fadeimg1 = false;
var fadeimg2 = false;
// hide cover art not yet scnanned
NP._visible = false;
NC._visible = false;
NN._visible = false;
NV._visible = false;
//------------------------------------------------------------------------------------------------------------------
// function show and hide dot dot
function SHDot(TF) {
	ddTitle._visible = TF;
	ddArtist._visible = TF;
	ddAlbum._visible = TF;
}
//------------------------------------------------------------------------------------------------------------------
// function show and hide normal
function SHNormal(SH) {
	bg_bitrate._visible = false;
	if (SH == true) {
		SHType = "Normal";
		currentDate._visible = SH;
		cur_date_visual._visible = false;
	} else {
		SHType = "Visualization";
		currentDate._visible = false;
		cur_date_visual._visible = true;
		cur_date_visual._x = coCurrentVisual._x+(coCurrentVisual._width/2);
		cur_date_visual._y = coCurrentVisual._y-(cur_date_visual._height/2)+10;
	}
	coPr._visible = SH;
	coCu._visible = SH;
	coNe._visible = SH;
	bdPr._visible = SH;
	bdCu._visible = SH;
	bdNe._visible = SH;
	MoviePicP._visible = SH;
	MoviePicC._visible = SH;
	MoviePicN._visible = SH;
	ButtonPicP._visible = SH;
	ButtonPicC._visible = SH;
	ButtonPicN._visible = SH;
	ButtonShowTools.enabled = SH;
	PicP1._visible = SH;
	PicC1._visible = SH;
	PicN1._visible = SH;
	PicP2._visible = SH;
	PicC2._visible = SH;
	PicN2._visible = SH;
	capNTitle._visible = SH;
	capNArtist._visible = SH;
	capNAlbum._visible = SH;
	PicP1._alpha = 100;
	PicC1._alpha = 100;
	PicN1._alpha = 100;
	PicP2._alpha = 0;
	PicC2._alpha = 0;
	PicN2._alpha = 0;
	if (val_reg == "True") {
		NNRP._visible = false;
		NNRC._visible = false;
		NNRN._visible = false;
	} else {
		NNRP._visible = SH;
		NNRC._visible = SH;
		NNRN._visible = SH;
	}
}
//------------------------------------------------------------------------------------------------------------------
// function show and hide visualization
function SHVisualization(SH) {
	bg_bitrate._visible = false;
	coCurrentVisual._visible = SH;
	coVisual._visible = SH;
	bdCurrentVisual._visible = SH;
	bdVisual._visible = SH;	
	ButtonPicV._visible = SH;
	MoviePicV._visible = SH;
	PicV1._visible = SH;
	PicV2._visible = SH;
	capVTitle._visible = SH;
	capVArtist._visible = SH;
	capVAlbum._visible = SH;
	PicV1._alpha = 100;
	PicV2._alpha = 0;
	MovieVisualization._visible = SH;
	if (val_reg == "True") {
		VNRC._visible = false;
	} else {
		VNRC._visible = true;
	}
	if (SH == true){
		showVis();
	}
}
//------------------------------------------------------------------------------------------------------------------
// function for change color
function setColor(C) {
	myc = new Color(MoviePicP);
	myc.setRGB(C);
	myc = new Color(MoviePicC);
	myc.setRGB(C);
	myc = new Color(MoviePicN);
	myc.setRGB(C);
	myc = new Color(MoviePicV);
	myc.setRGB(C);
}
//------------------------------------------------------------------------------------------------------------------
// function show and hide for next and previouse album image
function SHNP(SH) {
	if ((PicN1._alpha == 0) and (PicN2._alpha == 0)) {
		PicN1._alpha = 0;
		PicN2._alpha = 100;
		PicN1._visible = true;
		PicN2._visbile = true;
		noNext._visible = false;
		ButtonPicN.enabled = true;
	}
	MoviePicP._visible = SH;
	MoviePicN._visible = SH;
	ButtonPicP._visible = SH;
	ButtonPicN._visible = SH;
	PicP1._visible = SH;
	PicN1._visible = SH;
	PicP2._visible = SH;
	PicN2._visible = SH;
	SHLNP(SH);
}
//------------------------------------------------------------------------------------------------------------------
// function for display label next and previouse album image
function SHLNP(TF) {
	// SHLNP : Show and Hide Label Next and Previous
	// Previouse	
	capPT._x = (MoviePicP._width-capPT.caption.textWidth)/2+MoviePicP._x;
	// 108.85;
	capPT._y = MoviePicP._height+MoviePicP._y-5;
	capPT._visible = TF;
	// Next
	capNT._x = (MoviePicN._width-capNT.caption.textWidth)/2+MoviePicN._x;
	//1001.15;
	capNT._y = MoviePicN._height+MoviePicN._y-5;
	capNT._visible = TF;
}
//------------------------------------------------------------------------------------------------------------------
// function scale location all catption for normal
function textNLocation(obj, val_y, str) {
	// obj: name object display
	nlstr = new Array();
	nlfont = new Array();
	nlstr = String(str).split("**");
	nlfont = String(nlstr[1]).split("%");
	eval(obj)._visible = false;
	delete (sfs);
	sfs = new TextFormat();
	sfs.font = nlfont[0];
	if (String(nlfont[0]).substr(0, 5) == "Limon") {
		sfs.size = 70;
		//int(nlfont[1]) + 20;
	} else {
		sfs.size = 60;
		//int(nlfont[1]) + 20;
	}
	eval(obj+".caption").text = nlstr[0];
	eval(obj+".caption").autoSize = true;
	eval(obj+".caption").setTextFormat(sfs);
	if (eval(obj)._width<800) {
		if (obj == "capNTitle") {
			clearInterval(intervalTextScroll);
			removeMovieClip("new_capNTitle");
		}
		eval(obj)._x = (800-eval(obj)._width)/2;
		if (obj == "capNTitle") {
			if (int(eval(obj)._height)>75) {
				eval(obj)._y = int(val_y)-(int(eval(obj)._height)-75)/2;
			} else {
				eval(obj)._y = int(val_y)+(75-int(eval(obj)._height))/2;
			}
		} else {
			if (int(eval(obj)._height)>66) {
				eval(obj)._y = int(val_y)-(int(eval(obj)._height)-66)/2;
			} else {
				eval(obj)._y = int(val_y)+(66-int(eval(obj)._height))/2;
			}
		}
	} else {
		eval("dd"+String(obj).substr(4))._visible = true;
		eval(obj)._x = 0;
		if (obj == "capNTitle") {
			clearInterval(intervalTextScroll);
			removeMovieClip("new_capNTitle");
			eval(obj+".caption").text = nlstr[0];
			eval(obj+".caption").autoSize = true;
			eval(obj+".caption").setTextFormat(sfs);
			duplicateMovieClip(obj, "new_capNTitle", -9999);
			new_capNTitle.caption.text = nlstr[0];
			new_capNTitle.caption.textColor = eval(obj+".caption").textColor;
			new_capNTitle.caption.autoSize = true;
			new_capNTitle.caption.setTextFormat(sfs);
			new_capNTitle._x = eval(obj)._x+eval(obj)._width+200;
			if (obj == "capNTitle") {
				if (int(eval(obj)._height)>75) {
					eval(obj)._y = int(val_y)-(int(eval(obj)._height)-75)/2;
				} else {
					eval(obj)._y = int(val_y)+(75-int(eval(obj)._height))/2;
				}
				new_capNTitle._y = eval(obj)._y;
			} else {
				if (int(eval(obj)._height)>66) {
					eval(obj)._y = int(val_y)-(int(eval(obj)._height)-66)/2;
				} else {
					eval(obj)._y = int(val_y)+(66-int(eval(obj)._height))/2;
				}
				new_capNTitle._y = eval(obj)._y;
			}
			intervalTextScroll = setInterval(scrollTrackTitle, 70);
		} else {
			eval(obj+".caption").text = cutString(obj, 800, nlstr[0]);
			eval(obj+".caption").autoSize = true;
			eval(obj+".caption").setTextFormat(sfs);
			if (obj == "capNTitle") {
				if (int(eval(obj)._height)>75) {
					eval(obj)._y = int(val_y)-(int(eval(obj)._height)-75)/2;
				} else {
					eval(obj)._y = int(val_y)+(75-int(eval(obj)._height))/2;
				}
			} else {
				if (int(eval(obj)._height)>66) {
					eval(obj)._y = int(val_y)-(int(eval(obj)._height)-66)/2;
				} else {
					eval(obj)._y = int(val_y)+(66-int(eval(obj)._height))/2;
				}
			}
			eval("dd"+String(obj).substr(4))._y = int(eval(obj)._y)+(int(eval(obj)._height)/2)+10;
			eval("dd"+String(obj).substr(4))._x = int(eval(obj)._x+eval(obj)._width);
		}
	}
	eval(obj)._visible = true;
}
//------------------------------------------------------------------------------------------------------------------
// function scale location all catption for normal
function textVLocation(obj, str) {
	nlstr = new Array();
	nlfont = new Array();
	nlstr = String(str).split("**");
	nlfont = String(nlstr[1]).split("%");
	eval(obj)._visible = false;
	sf = new TextFormat();
	sf.font = nlfont[0];
	sf.size = int(int(nlfont[1])+20);
	eval(obj+".caption").text = nlstr[0];
	eval(obj+".caption").setTextFormat(sf);
	eval(obj+".caption").autoSize = true;
	if (eval(obj)._width<570) {
		eval(obj)._x = (570-eval(obj)._width)/2;
		if (String(obj).substr(4) == "Title") {
			capVTitle._y = 28.6;
		} else if (String(obj).substr(4) == "Artist") {
			capVArtist._y = 28.6+((200-capVArtist._height)/2);
		} else if (String(obj).substr(4) == "Album") {
			capVAlbum._y = int(28.6+200)-(capVAlbum._height);
		}
	} else {
		eval("dd"+String(obj).substr(4))._visible = true;
		eval(obj)._x = 0;
		eval(obj+".caption").text = cutString(obj, 570, nlstr[0]);
		eval(obj+".caption").setTextFormat(sf);
		eval(obj+".caption").autoSize = true;
		if (String(obj).substr(4) == "Title") {
			capVTitle._y = 28.6;
		} else if (String(obj).substr(4) == "Artist") {
			capVArtist._y = 28.6+((200-capVArtist._height)/2);
		} else if (String(obj).substr(4) == "Album") {
			capVAlbum._y = int(28.6+200)-(capVAlbum._height);
		}
		eval("dd"+String(obj).substr(4))._y = eval(obj)._y+((eval(obj)._height)/2)+10;
		eval("dd"+String(obj).substr(4))._x = int(eval(obj)._x+eval(obj)._width);
	}
	eval(obj)._visible = true;
}
//------------------------------------------------------------------------------------------------------------------
// this function used for cut string
function cutString(obj, len, str) {
	for (i=1; i<=String(str).length; i++) {
		eval(obj+".caption").text = String(str).substr(0, i);
		eval(obj+".caption").setTextFormat(sfs);
		if ((eval(obj+".caption")._width+36)>=len) {
			return String(str).substr(0, int(i-1));
		}
	}
}
//------------------------------------------------------------------------------------------------------------------
// this function used for scroll when the track title as long as than width screen
function scrollTrackTitle() {
	capNTitle._x -= 2;
	new_capNTitle._x -= 2;
	if (capNTitle._x<-(capNTitle._width)) {
		capNTitle._x = new_capNTitle._x+new_capNTitle._width+200;
	}
	if (new_capNTitle._x<-(new_capNTitle._width)) {
		new_capNTitle._x = capNTitle._x+capNTitle._width+200;
	}
}
//------------------------------------------------------------------------------------------------------------------
// function for change to back cover art album for normal fullscreen
function toBackCoverArtAlbumNormal(strAlb) {
	fadeimgC1 = false;
	fadeimgC2 = false;
	if (imgC1._alpha>=imgC2._alpha) {
		imgC1._alpha = 100;
		imgC2._alpha = 0;
	} else {
		imgC1._alpha = 0;
		imgC2._alpha = 100;
	}
	lstr = String(strAlb).length;
	ca = String(strAlb).substr((lstr-10));
	if (ca == "folder.jpg") {
		tmpNCimg = String(strAlb).substr(0, lstr-10)+"back.jpg";
		fscommand("ScanFile", tmpNCimg);
	} else {
		tmpNCimg = String(strAlb).substr(0, lstr-8)+"folder.jpg";
		PicC1._visible = true;
		PicC2._visible = true;
		fadeObjectCurrent(PicC1, PicC2, tmpNCimg);
	}
}
//------------------------------------------------------------------------------------------------------------------
// function for change to back cover art album for visualization fullscreen
function toBackCoverArtAlbumVisualization(strAlb) {
	fadeimgV1 = false;
	fadeimgV1 = false;
	if (imgV1._alpha>=imgV2._alpha) {
		imgV1._alpha = 100;
		imgV2._alpha = 0;
	} else {
		imgV1._alpha = 0;
		imgV2._alpha = 100;
	}
	lstr = String(strAlb).length;
	ca = String(String(strAlb).substr((lstr-10))).toLowerCase();
	if (ca == "folder.jpg") {
		tmpVimg = String(strAlb).substr(0, lstr-10)+"back.jpg";
		fscommand("ScanFile", tmpVimg);
	} else {
		tmpVimg = String(strAlb).substr(0, lstr-8)+"folder.jpg";
		PicV1._visible = true;
		PicV2._visible = true;
		fadeObjectVisualization(PicV1, PicV2, tmpVimg);
	}
}
//------------------------------------------------------------------------------------------------------------------
// function Unregister
function Registered(SHP, SHC, SHN) {
	if (isRegistered == true) {
		NNRP._visible = false;
		NNRC._visible = false;
		NNRN._visible = false;
	} else {
		NNRP._visible = SHP;
		NNRC._visible = SHC;
		NNRN._visible = SHN;
	}
}
// function close tabEnabled
function tabEnabled() {
	ButtonCloseFullScreen.tabEnabled = false;
	ButtonShowTools.tabEnabled = false;
	ButtonPicP.tabEnabled = false;
	ButtonPicC.tabEnabled = false;
	ButtonPicN.tabEnabled = false;
	ButtonPicV.tabEnabled = false;
	seek.ButtonSeek.tabEnabled = false;
	tools.ButtonPreviouse.tabEnabled = false;
	tools.ButtonNext.tabEnabled = false;
	tools.ButtonPause.tabEnabled = false;
	tools.ButtonPlay.tabEnabled = false;
	tools.ButtonMuteTrue.tabEnabled = false;
	tools.ButtonMuteFalse.tabEnabled = false;
	tools.ButtonStop.tabEnabled = false;
	tools.ButtonMore.tabEnabled = false;
	tools.tabEnabled = false;
	tools.bg.tabEnabled = false;
	tools.vol.ButtonVol.tabEnabled = false;
	More.ButtonSlideShowYes.tabEnabled = false;
	More.ButtonSlideShowNo.tabEnabled = false;
	More.ButtonAddFile.tabEnabled = false;
	More.ButtonPlaylist.tabEnabled = false;
	More.ButtonLoopFalse.tabEnabled = false;
	More.ButtonLoopTrue.tabEnabled = false;
	More.ButtonShuffleFalse.tabEnabled = false;
	More.ButtonShuffleTrue.tabEnabled = false;
}
SHNormal(false);
SHVisualization(false);
bg._visible = false;
SHDot(false);
tabEnabled();
//================================================================================
//================================================================================
// function for image fading Previouse
function fadeObjectPreviouse(obj1, obj2, P) {
	imgP1 = obj1;
	imgP2 = obj2;
	if ((obj1._alpha<20) and (obj2._alpha>80)) {
		obj1._alpha = 0;
		obj2._alpha = 100;
		eval(obj1).loadMovie(P);
		fadeimgP1 = false;
		fadeimgP2 = true;
	} else if ((obj1._alpha>80) and (obj2._alpha<20)) {
		obj1._alpha = 100;
		obj2._alpha = 0;
		eval(obj2).loadMovie(P);
		fadeimgP1 = true;
		fadeimgP2 = false;
	}
}
function imgFadePreviouse() {
	if (fadeimgP1 == true) {
		imgP1._alpha -= 20;
		imgP2._alpha += 20;
		if (allTrack == "1") {
			if ((valLoop == false) and (valShuffle == false)) {
				imgP1._visible = false;
				imgP2._visible = false;
			}
		}
		if (imgP2._alpha>100) {
			imgP1.unloadMovie();
			imgP1._alpha = 0;
			fadeimgP1 = false;
			imgP2._alpha = 100;
		}
	} else if (fadeimgP2 == true) {
		imgP1._alpha += 20;
		imgP2._alpha -= 20;
		if (imgP1._alpha>100) {
			imgP2.unloadMovie();
			imgP2._alpha = 0;
			fadeimgP2 = false;
			imgP1._alpha = 100;
		}
	}
}
//================================================================================
// function for image fading Current
function fadeObjectCurrent(obj1, obj2, P) {
	imgC1 = obj1;
	imgC2 = obj2;
	if ((obj1._alpha<20) and (obj2._alpha>80)) {
		obj1._alpha = 0;
		obj2._alpha = 100;
		eval(obj1).loadMovie(P);
		fadeimgC1 = false;
		fadeimgC2 = true;
	} else if ((obj1._alpha>80) and (obj2._alpha<20)) {
		obj1._alpha = 100;
		obj2._alpha = 0;
		eval(obj2).loadMovie(P);
		fadeimgC1 = true;
		fadeimgC2 = false;
	}
}
function imgFadeCurrent() {
	if (fadeimgC1 == true) {
		imgC1._alpha -= 20;
		imgC2._alpha += 20;
		if (imgC2._alpha>100) {
			imgC1.unloadMovie();
			imgC1._alpha = 0;
			fadeimgC1 = false;
			imgC2._alpha = 100;
		}
	} else if (fadeimgC2 == true) {
		imgC1._alpha += 20;
		imgC2._alpha -= 20;
		if (imgC1._alpha>100) {
			imgC2.unloadMovie();
			imgC2._alpha = 0;
			fadeimgC2 = false;
			imgC1._alpha = 100;
		}
	}
}
//================================================================================
// function for image fading Next
function fadeObjectNext(obj1, obj2, P) {
	imgN1 = obj1;
	imgN2 = obj2;
	if ((obj1._alpha<20) and (obj2._alpha>80)) {
		obj1._alpha = 0;
		obj2._alpha = 100;
		eval(obj1).loadMovie(P);
		fadeimgN1 = false;
		fadeimgN2 = true;
	} else if ((obj1._alpha>80) and (obj2._alpha<20)) {
		obj1._alpha = 100;
		obj2._alpha = 0;
		eval(obj2).loadMovie(P);
		fadeimgN1 = true;
		fadeimgN2 = false;
	}
}
function imgFadeNext() {
	if (fadeimgN1 == true) {
		imgN1._alpha -= 20;
		imgN2._alpha += 20;
		if (allTrack == "1") {
			if ((valLoop == false) and (valShuffle == false)) {
				imgN1._visible = false;
				imgN2._visible = false;
			}
		}
		if (imgN2._alpha>100) {
			imgN1.unloadMovie();
			imgN1._alpha = 0;
			fadeimgN1 = false;
			if (imgN2._visible == true) {
				imgN2._alpha = 100;
			}
		}
	} else if (fadeimgN2 == true) {
		imgN1._alpha += 20;
		imgN2._alpha -= 20;
		if (imgN1._alpha>100) {
			imgN2.unloadMovie();
			imgN2._alpha = 0;
			fadeimgN2 = false;
			imgN1._alpha = 100;
		}
	}
}
//===========================================================================================================
// function for image fading Visualization
function fadeObjectVisualization(obj1, obj2, P) {
	imgV1 = obj1;
	imgV2 = obj2;
	if ((obj1._alpha<20) and (obj2._alpha>80)) {
		obj1._alpha = 0;
		obj2._alpha = 100;
		eval(obj1).loadMovie(P);
		fadeimgV1 = false;
		fadeimgV2 = true;
	} else if ((obj1._alpha>80) and (obj2._alpha<20)) {
		obj1._alpha = 100;
		obj2._alpha = 0;
		eval(obj2).loadMovie(P);
		fadeimgV1 = true;
		fadeimgV2 = false;
	}
}
function imgFadeVisualization() {
	if (fadeimgV1 == true) {
		imgV1._alpha -= 20;
		imgV2._alpha += 20;
		if (imgV2._alpha>100) {
			imgV1.unloadMovie();
			imgV1._alpha = 0;
			fadeimgV1 = false;
			imgV2._alpha = 100;
		}
	} else if (fadeimgV2 == true) {
		imgV1._alpha += 20;
		imgV2._alpha -= 20;
		if (imgV1._alpha>100) {
			imgV2.unloadMovie();
			imgV2._alpha = 0;
			fadeimgV2 = false;
			imgV1._alpha = 100;
		}
	}
}
// Function For Get Button Index
function getindex(n, l) {
	// l : last string like: n0
	i = String(n).substr(String(n).length-2);
	if (String(i).substr(0, 1) == l) {
		i = String(i).substr(1, 1);
	} else {
		i = i;
	}
	return i;
}
function loadWebShopping(val_ind) {
	var URL = "";
	val_ind = int(val_ind);
	if (val_ind == 0) {
		URL = "http://www.amazon.com/gp/cart/view.html";
	} else if (val_ind == 1) {
		URL = "http://www.buy.com/basket/basket.asp";
	} else if (val_ind == 2) {
		URL = "http://www.walmart.com/cart.gsp";
	} else if (val_ind == 3) {
		URL = "http://www.walmart.com/music_downloads/cart.gsp";
	}
	getURL(URL, "_blank");
}
function showIconPurchase(b_purchase) {
	clearInterval(purchaseID);
	tmr_delay = 0;
	if (b_purchase == true) {
		if (MoviePicC._visible == true) {
			Cart._x = MoviePicC._x;
			Cart._y = MoviePicC._y;
		} else if (MoviePicV._visible == true) {
			Cart._x = MoviePicV._x;
			Cart._y = MoviePicV._y;
		}
		Cart._visible = true;
		purchaseID = setInterval(hidePurchaseType, 1000);
	} else {
		Cart._visible = false;
	}
}
function replaceName(Str, FStr, RStr) {
	var n = FStr.length;
	for (var j = 1; j<Str.length; j++) {
		if (substring(Str, j, n) == FStr) {
			return substring(Str, 1, j-1)+RStr+substring(Str, (j+n), -1);
		}
	}
}
//===========================================================================================================
// function scale location all catption for normal
function displayTextCurrentInfo(obj_txt, str_value, str_fontName, co_y) {
	var str_concate = "";
	var obj_textFormat = new TextFormat();
	var tmp_string = "";
	var b_lng_string = false;
	obj_textFormat.font = str_fontName;
	if (String(str_fontName).substr(0, 5) == "Limon") {
		obj_textFormat.size = limon_font_size;
		str_concate = ">>>";
	} else {
		obj_textFormat.size = other_font_size;
		str_concate = "...";
	}
	txt_tmp.text = str_value;
	txt_tmp.autoSize = true;
	txt_tmp.setTextFormat(obj_textFormat);
	txt_tmp._width = txt_tmp._width;
	txt_tmp.autoSize = true;
	if (txt_tmp._width>Stage.width) {
		b_lng_string = true;
		if (obj_txt != "capNTitle") {
			tmp_string = str_value;
			for (var init = 0; init<String(str_value).length; init++) {
				txt_tmp.text = String(str_value).substr(0, init)+str_concate;
				txt_tmp.autoSize = true;
				txt_tmp.setTextFormat(obj_textFormat);
				txt_tmp._width = txt_tmp._width;
				txt_tmp.autoSize = true;
				if (txt_tmp._width>Stage.width) {
					tmp_string = String(str_value).substr(0, (init-1))+str_concate;
					break;
				}
			}
		} else {
			tmp_string = str_value;
		}
	} else {
		b_lng_string = false;
		tmp_string = str_value;
	}
	if (obj_txt != "capNTitle") {
		eval(obj_txt+".caption").text = tmp_string;
		eval(obj_txt+".caption").autoSize = true;
		eval(obj_txt+".caption").setTextFormat(obj_textFormat);
		eval(obj_txt+".caption")._x = 0;
		eval(obj_txt+".caption")._y = -(eval(obj_txt+".caption")._height)/2;
		eval(obj_txt)._x = (Stage.width-eval(obj_txt)._width)/2;
		eval(obj_txt)._y = co_y;
	} else {
		clearInterval(intervalTextScroll);
		removeMovieClip("new_capNTitle");
		eval(obj_txt+".caption").text = tmp_string;
		eval(obj_txt+".caption").autoSize = true;
		eval(obj_txt+".caption").setTextFormat(obj_textFormat);
		eval(obj_txt+".caption")._x = 0;
		eval(obj_txt+".caption")._y = -(eval(obj_txt+".caption")._height)/2;
		if (b_lng_string == true) {
			eval(obj_txt)._x = 0;
			eval(obj_txt)._y = co_y;
			duplicateMovieClip(obj_txt, "new_capNTitle", -9998);
			new_capNTitle.caption.textColor = eval(obj_txt+".caption").textColor;
			new_capNTitle.caption.text = tmp_string;
			new_capNTitle.caption.autoSize = true;
			new_capNTitle.caption.setTextFormat(obj_textFormat);
			new_capNTitle.caption._x = 0;
			new_capNTitle.caption._y = -(new_capNTitle.caption._height)/2;
			new_capNTitle._x = eval(obj_txt)._x+eval(obj_txt)._width+150;
			new_capNTitle._y = co_y;
			new_capNTitle._visible = true;
			intervalTextScroll = setInterval(scrollTrackTitle, 70);
		} else {
			eval(obj_txt)._x = (Stage.width-eval(obj_txt)._width)/2;
			eval(obj_txt)._y = co_y + 10;
		}
	}
	b_lng_string = false;
	eval(obj_txt)._visible = true;
}
//===========================================================================================================
function browseSLY(){
	browsePopup.browseSLY();
}
function browsePopupForm(){
	if (b_ads == true){
		var bars_color = new Color(eval("TrackShow.bgDisplay"));
		var btn_color = new Color(tools.MoviePlay);
		var back_color = new Color(bg);
		if (MoviePicC._visible == true) {
			browsePopup.widthBrowse = MoviePicC._width;//500;//
			browsePopup.heightBrowse = MoviePicC._height - 30;//500-30;//
			browsePopup._x = MoviePicC._x;//(Stage.width-500)/2;//
			browsePopup._y = MoviePicC._y + 30;//((Stage.height-500)/2 )+30;//
		}else{
			//browsePopup.widthBrowse = MoviePicV._width;
			//browsePopup.heightBrowse = MoviePicV._height-30;
			//browsePopup._x = MoviePicV._x;
			//browsePopup._y = MoviePicV._y+30;
			browsePopup.widthBrowse = 290;
			browsePopup.heightBrowse = 290;
			browsePopup._x = 487.5;
			browsePopup._y = 85.1 + 30;
		}
		if (browsePopup._visible == false){
			browsePopup.setColor(bars_color.getRGB(),btn_color.getRGB(),back_color.getRGB());
			browsePopup.showBrowseSLY();
		}
	}else{
		browsePopup.hideBrowseSLY();
	}
}
//===========================================================================================================
function showVis(){
	if (vis_mc._visible == false){
		vis_mc._visible = true;
		clearInterval(ID_showVis);
		ID_showVis = setInterval(hideVis,5000);
	}
}
function hideVis(){
	clearInterval(ID_showVis);
	vis_mc._visible = false;
}
//===========================================================================================================
// function num key press
var keynum = 0;
function keyNumPress(keyAscii) {
	clearInterval(IDKeyPress);
	for (var init = 0; init<10; init++) {
		if (chr(keyAscii) == init) {
			keynum = int(String(keynum)+String(chr(keyAscii)));
			IDKeyPress = setInterval(intervalKeyPress, 500, keynum);
		}
	}
}
function intervalKeyPress(keyAscii) {
	control_mini_player("fn_selectTrack",keyAscii,"true");
	keynum = 0;
	clearInterval(IDKeyPress);
}
function fn_selectTrack(valKey){
	if (valKey != 0) {		
		fscommand("selectTrack",valKey);
	}
	keynum = 0;
	clearInterval(IDKeyPress);
}
function setVolume(val) {
	val = (int(val)>100) ? 100 : int(val);
	//error 105
	tools.vol.txtVol.text = int(val);
	tools.vol.vol._width = int((int(val)*tools.vol.ButtonVol._width)/100);
}
//===========================================================================================================
// get values  from VB
//====================
function setVB(val) {
	var spl = new Array();
	spl = String(val).split("|%|");
	click_self = false;
	switch (spl[0]) {
	case "volume" :
		val_value = spl[1];
		setVolume(val_value);
		break;
	case "play" :
		val_bool = spl[1] == "True";
		setProperty(tools.ButtonPause, _visible, val_bool );
		setProperty(tools.MoviePause, _visible, val_bool );
		setProperty(tools.ButtonPlay, _visible, !val_bool );
		setProperty(tools.MoviePlay, _visible, !val_bool );
		break;
	case "mute" :
		val_bool = spl[1] == "True";
		setProperty(tools.ButtonMuteFalse, _visible, val_bool);
		setProperty(tools.MovieMuteFalse, _visible, val_bool);
		setProperty(tools.ButtonMuteTrue, _visible, !val_bool);
		setProperty(tools.MovieMuteTrue, _visible, !val_bool);

		break;
	case "shuffle" :
		fscommand("mb","flash shuffle");
		val_bool = spl[1] == "True";
		setProperty(More.ButtonShuffleTrue, _visible, val_bool );
		setProperty(More.MovieShuffleTrue, _visible, val_bool );
		setProperty(More.ButtonShuffleFalse, _visible, !val_bool );
		setProperty(More.MovieShuffleFalse, _visible, !val_bool );
		break;
	case "loop" :
		val_bool = spl[1] == "True";
		setProperty(More.ButtonLoopTrue, _visible, val_bool );
		setProperty(More.MovieLoopTrue, _visible, val_bool );
		setProperty(More.ButtonLoopFalse, _visible, !val_bool );
		setProperty(More.MovieLoopFalse, _visible, !val_bool );
		break;
	case "Variable" :		
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		set(arg_spl[0], arg_spl[1]);		
		break;
	case "UnloadSwf" :
		UnloadItSelf(val);
	case "fscommand" :
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		fscommand(arg_spl[0], arg_spl[1]);
		break;
	case "function" :
		// call function receive from client
		var arg_spl = new Array();
		arg_spl = String(spl[1]).split("|~|");
		eval(arg_spl.shift()).apply(null, arg_spl);
		break;
	case "Over" :
		eval(spl[1]).onRollOver();
		break;
	case "Press" :
		eval(spl[1]).onPress();
		break;
	case "Click" :
		eval(spl[1]).onRelease();
		break;
	case "clientType" :	
		clientType = spl[1];
		break;
	case "TrackShow" :
//		browsePopupForm();
		//=====================================
//		str_infoPopup = spl[1];
//		displayTrackInfoVisual(str_infoPopup);
		TrackShow.setTrackShow(spl[1]);

		break;
	case "showShopping" :
		VisibleChecked(spl[1]);
		PurchaseCDMode.ButtonClose.onRollOver();
		if (SHType == "Normal") {
			PurchaseCDMode._x = Stage.width/2;
			PurchaseCDMode._y = Stage.height/2;
		} else {
			PurchaseCDMode._x = Stage.width/2;
			PurchaseCDMode._y = MovieVisualization._y+MovieVisualization._height+(PurchaseCDMode._height/2);
		}
		PurchaseCDMode._visible = true;
		enableMouse._visible = true;
		break;
	case "displayFullscreen" :
		tmpVimg = "";
		tmpNPimg = "";
		tmpNCimg = "";
		tmpNNimg = "";
		bg_bitrate._visible = false;
		NC._visible = false;
		CtrlKey = false;	
		fscommand("displayFullscreen", true);
		break;
	case "Minimize" :
		tmpVimg = "";
		tmpNPimg = "";
		tmpNCimg = "";
		tmpNNimg = "";
		bg_bitrate._visible = false;
		NC._visible = false;
		CtrlKey = false;
		fscommand("Minimize", true);
		break;
	case "ads":
		if (spl[1] == "True"){
			b_ads = true;
		}else{
			b_ads = false;
		}
		break;
	case "show_x" :
		show_x = (spl[1] == "True");
		break;
	case "showVis":		
		showVis();
		break;
	case "visType":
		if (spl[1] == "0"){
			vis_mc.next_vis._visible = false;
			vis_mc.previous_vis._visible = false;
		}else{
			vis_mc.next_vis._visible = true;
			vis_mc.previous_vis._visible = true;
		}
		break;
	case "player_info" :
		var aa = new Array();
		aa = String(spl[1]).split("%%");
		vseek = int(aa[0]);
		time = aa[1];
		timeString = " / " + aa[2];
		seek.knob._width = vseek;
		txtTime.text = time;
		txtstring.text = timeString;
		break;
	case "seek":
		var vseek = Number(spl[1]);
		var timeString = spl[2];

		seek.knob._width = (vseek*seek.ButtonSeek._width<=seek.ButtonSeek._width) ? vseek*seek.ButtonSeek._width : seek.ButtonSeek._width;
		seek.txtSeekTime.text = timeString;
		seek.txtSeekTime._visible = true;
		break;
	case "popup_connect" :
		popup_connect.shows(spl[1]);
		break;
	}
	click_self = true;
}
function getvb() {
}
this.addProperty("vb", getvb, setVB);
//===========================================================================================================
function Send2Server (sendType,sendCommand,skipIfNoControl) {
	if ((clientType != serverMode) and skipIfNoControl and click_self) {
	//if (!((clientType != remoteControl) and skipIfNoControl)) {
		fscommand(sendType, sendCommand);
	}else if ((clientType == serverMode) and skipIfNoControl and click_self) {
		fscommand("server", sendCommand);
	}
}