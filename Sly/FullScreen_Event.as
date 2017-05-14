#include "GeneralFunction.as"
Key.removeListener(upCtrl);
Key.removeListener(myListener2);
pathAlbum = "Null";
_global.i = 0;
_global.yRandom = 0;
var SHT = false;
var VSHT = false;
var tf;		// time fade
setProperty(tools.ButtonPlay, _visible, false);
setProperty(tools.ButtonMuteFalse, _visible, false);
setProperty(tools, _visible, false);
setProperty(More, _visible, false);
getvalseek = false;
getvalfade = false;
_root.bgColor = "true";
_global.BackgroundColor = "";
noNext._visible = false;
var text_color = "";
var bc;		// background color
var tc;		// tool color			
var tec;	// text color
var SSS;	// set slide show
var SHTT;	// show or hide toll tip
var tmpVimg = "";
var tmpNPimg = "";
var tmpNCimg = "";
var tmpNNimg = "";
var img1 = "";
var img2 = "";
var SHType = "";	// store type of fullscreen
var valLoop;		// store boolean
var valShuffle;		// store boolean
var currentTrack;	// track playing
var allTrack;		// all track in playlist
var sflnp = new TextFormat();
var ddAl;
var ddAr;
var NNB = false;	// none next track as boolean
var NPB = false;	// noen previouse track as boolean
var isRegistered = false;
var valreg = "";
PicP1.loadMovie(" ");
PicP2.loadMovie(" ");
PicC1.loadMovie(" ");
PicC2.loadMovie(" ");
PicN1.loadMovie(" ");
PicN2.loadMovie(" ");
PicV1.loadMovie(" ");
PicV2.loadMovie(" ");
PicP1.unloadMovie();
PicP2.unloadMovie();
PicC1.unloadMovie();
PicC2.unloadMovie();
PicN1.unloadMovie();
PicN2.unloadMovie();
PicV1.unloadMovie();
PicV2.unloadMovie();
VNRC._visible = false;
NNRC._visible = false;
NNRP._visible = false;
NNRN._visible = false;
//--------------------
var scfn = "";		// scroll caption font name
var scfs = "";		// scroll caption font size
var scti = "";		// scroll caption title
var scar = "";		// scroll caption artist
var scal = "";		// scroll caption album
var tsfnti = "";	// text scroll font name title
var tsfsti = "";	// text scroll font size title
var tsti = "";		// text scroll title
var tsfnar = "";	// text scroll font name artist
var tsfsar = "";	// text scroll font size artist
var tsar = "";		// text scroll title
var tsfnal = "";	// text scroll font name album
var tsfsal = "";	// text scroll font size album
var tsal = "";		// text scroll title
var set_fc = new TextFormat();		// set font caption
var set_fti = new TextFormat();		// set font title
var set_far = new TextFormat();		// set font artist
var set_fal = new TextFormat();		// set font album
var sym = "//\\\\";
var sss = "\\\\//";
//var y_title = 47.5;
//var y_album = 595;
//var y_artist = 694.9;
//var limon_font_size = 85;
//var other_font_size = 75;
var show_mouse = true;
var show_x = true;

//--------------------
// onMouseMove
_root.onMouseMove = function() {
	b_move = true;
	if (int(_ymouse)>350) {
		MouseMove();
	}
	showX();
};
function hideX(){
	X._visible = false;
	clearInterval(ID_hideX);
	Mouse.hide();
}
function showX(){
	if (show_x){
		clearInterval(ID_hideX);
		ID_hideX = setInterval(hideX,1000*5);	
		X._visible = true;
		if (show_mouse){
			Mouse.show();
		}else{
			Mouse.hide();
		}
	}
}

function MouseMove() {
	tmpm = int(_ymouse);
	tools._alpha = 100;
	seek._alpha = 100;
	setProperty("tools", _visible, true);
	SHT = true;
	tf = 0;
	capNArtist._visible = false;
	if (ddArtist._visible == true) {
		ddAr = true;
		ddArtist._visible = false;
	}
	capNAlbum._visible = false;
	if (ddAlbum._visible == true) {
		ddAl = true;
		ddAlbum._visible = false;
	}
}
function fade() {
	if (SHT == true) {
		tf += 1;
		if (tf>50) {
			tools._alpha -= 20;
			seek._alpha -= 20;
			if (seek._alpha<20) {
				seek._alpha = 50;
			}
			if (tools._alpha<0) {
				SHT = false;
				tools._visible = false;
				More._visible = false;
				if (PurchaseCDMode._visible == false) {
					if (MoviePicC._visible == true) {
						ButtonPicC.onRollOver();
					} else {
						ButtonPicV.onRollOver();
					}
				}
				SHT = false;
				capNArtist._visible = true;
				if (ddAr == true) {
					ddArtist._visible = true;
					ddAr = false;
				}
				capNAlbum._visible = true;
				if (ddAl == true) {
					ddAlbum._visible = true;
					ddAl = false;
				}
			}
		}
	}
}
_root.onEnterFrame = function() {
	moveMove();
	if (cur_date_visual._visible == true) {
		cur_date_visual.displayCurrentDateVisual();
	} else {
		currentDate.displayCurrentDate();
	}
	if (Key.isDown(Key.ESCAPE)) {
		if (PurchaseCDMode._visible == true) {
			PurchaseCDMode.ButtonClose.onRelease();
		} else {
			ButtonCloseFullScreen.onPress();
		}
	}
	fade();
	if (sendVar != undefined) {
		delete (sendVar);
		//----
		if (val_infoPopup != undefined) {
			str_infoPopup = val_infoPopup;
			delete (val_infoPopup);
		}
		//----
//		if (val_KeyPressed != undefined) {
//			KeyListener1(val_KeyPressed);
//			delete (val_KeyPressed);
//		}
		//----
		if (val_hideMouse != undefined) {
			if (val_hideMouse == "True") {
				Mouse.hide();
				show_mouse = false;
			} else {
				Mouse.show();
				show_mouse = true;
			}
			delete (val_hidMouse);
		}
		//----
		if (val_unloadFullscreen != undefined) {
			Key.removeListener(upCtrl);
			Key.removeListener(myListener2);
			delete (val_unloadFullscreen);
			ButtonCloseFullScreen.onPress();
		}
		//----
		if (val_display != undefined) {
			if (val_display == "Image") {
				SHType = "Normal";
				SHNormal(true);
				SHVisualization(false);
				SHLNP(true);
				seek._alpha = 30;
				VNRC._visible = false;
			} else {
				seek._alpha = 30;
				SHType = "Visualization";
				SHVisualization(true);
				SHNormal(false);
				SHLNP(false);
				NNRP._visible = false;
				NNRC._visible = false;
				NNRN._visible = false;
			}
			delete (val_display);
		}
		//----
		if (val_reg != undefined) {
			valreg = val_reg;
			if (valreg == "False") {
				if (SHType == "Normal") {
					NNRC._visible = true;
					if (ButtonPicP._visible == true) {
						NNRN._visible = true;
						NNRP._visible = true;
					} else {
						NNRN._visible = false;
						NNRP._visible = false;
					}
					VNRC._visible = false;
				} else {
					VNRC._visible = true;
					NNRC._visible = false;
					NNRN._visible = false;
					NNRP._visible = false;
				}
			} else {
				VNRC._visible = false;
				NNRC._visible = false;
				NNRN._visible = false;
				NNRP._visible = false;
			}
			delete (val_reg);
		}
		//----
		if (val_backgroundColor != undefined) {
			changeColor(bg, val_backgroundColor);
			bg._visible = true;
			delete (val_backgroundColor);
		}
		//----
		if (val_buttonColor != undefined) {
			//if (Key.isToggled(17) == true){
			//	CtrlKey = true;	
			//}
			//			changeColor_alpha(More.bg,val_buttonColor,val_buttonAlpha);
			changeColor_alpha(MovieVisualization, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieVol, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(seek.bg, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(MoviePicP, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(MoviePicC, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(MoviePicN, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(MoviePicV, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(X.MovieX, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MoviePreviouse, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MoviePlay, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MoviePause, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieMuteTrue, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieMuteFalse, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieStop, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieNext, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(tools.MovieMore, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieAddFile, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MoviePlaylist, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieShuffleTrue, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieShuffleFalse, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieLoopTrue, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieLoopFalse, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieSlideShowYes, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(More.MovieSlideShowNo, val_buttonColor, val_buttonAlpha);
			//----------- for purchase
			changeColor_alpha(PurchaseCDMode.MovieClose, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(Cart.Movie, val_buttonColor, val_buttonAlpha);
			for (var init = 0; init<4; init++) {
				changeColor_alpha(eval("PurchaseCDMode.Movie"+init), val_buttonColor, val_buttonAlpha);
				changeColor_alpha(eval("PurchaseCDMode.MovieCart"+init), val_buttonColor, val_buttonAlpha);
			}
			//----------- end purchase
			//----------- for vis
			changeColor_alpha(vis_mc.full_vis.Movie, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(vis_mc.previous_vis.Movie, val_buttonColor, val_buttonAlpha);
			changeColor_alpha(vis_mc.next_vis.Movie, val_buttonColor, val_buttonAlpha);
			//----------- end vis
			
			//delete(val_buttonColor);
			selectObj(StoreName);
		}
		//----
		if (val_textColor != undefined) {
			TrackShow.setTrackDisplayTheme(val_textColor, val_color_bar);
			changeColor(ddTitle, val_textColor);
			changeColor(ddArtist, val_textColor);
			changeColor(ddAlbum, val_textColor);
			tools.vol.txtVol.textColor = val_textColor;
			tools.vol.txtp.textColor = val_textColor;
			seek.txtSeekTime.textColor=val_textColor;
			txtTime.textColor = val_textColor;
			txtstring.textColor = val_textColor;
			capNTitle.caption.textColor = val_textColor;
			capNArtist.caption.textColor = val_textColor;
			capNAlbum.caption.textColor = val_textColor;
			capPT.caption.textColor = val_textColor;
			capNT.caption.textColor = val_textColor;
			//----------- for purchase
			for (var init = 0; init<4; init++) {
				eval("PurchaseCDMode.Text"+init).textColor = val_textColor;
				eval("PurchaseCDMode.TextCart"+init).textColor = val_textColor;
			}
			//----------- end purchase
			text_color = val_textColor;
			delete (val_textColor);
		}
		//----
		if (val_tooltip != undefined) {
			if (val_tooltip == "True") {
				SHTT = "true";
			} else {
				SHTT = "false";
			}
			delete (val_tooltip);
		}
		//----
		if (val_play != undefined) {
			if (val_play == "True") {
				setProperty(tools.ButtonPause, _visible, true);
				setProperty(tools.MoviePause, _visible, true);
				setProperty(tools.ButtonPlay, _visible, false);
				setProperty(tools.MoviePlay, _visible, false);
			} else {
				setProperty(tools.ButtonPause, _visible, false);
				setProperty(tools.MoviePause, _visible, false);
				setProperty(tools.ButtonPlay, _visible, true);
				setProperty(tools.MoviePlay, _visible, true);
			}
delete(val_play);
		}
		//----
		if (val_slideShow != undefined) {
			if (val_slideShow == "True") {
				More.ButtonSlideShowYes._visible = false;
				More.MovieSlideShowYes._visible = false;
				More.ButtonSlideShowNo._visible = true;
				More.MovieSlideShowNo._visible = true;
			} else {
				More.ButtonSlideShowYes._visible = true;
				More.MovieSlideShowYes._visible = true;
				More.ButtonSlideShowNo._visible = false;
				More.MovieSlideShowNo._visible = false;
			}
			delete (val_slideShow);
		}
		//----
		if (val_loop != undefined) {
			if (val_loop == "True") {
				setProperty(More.ButtonLoopTrue, _visible, true);
				setProperty(More.MovieLoopTrue, _visible, true);
				setProperty(More.ButtonLoopFalse, _visible, false);
				setProperty(More.MovieLoopFalse, _visible, false);
			} else {
				setProperty(More.ButtonLoopFalse, _visible, true);
				setProperty(More.MovieLoopFalse, _visible, true);
				setProperty(More.ButtonLoopTrue, _visible, false);
				setProperty(More.MovieLoopTrue, _visible, false);
			}
			delete (val_loop);
		}
		//----
		if (val_shuffle != undefined) {
			if (val_shuffle == "True") {
				More.ButtonShuffleFalse._visible = false;
				More.MovieShuffleFalse._visible = false;
				More.ButtonShuffleTrue._visible = true;
				More.MovieShuffleTrue._visible = true;
			} else {
				More.ButtonShuffleFalse._visible = true;
				More.MovieShuffleFalse._visible = true;
				More.ButtonShuffleTrue._visible = false;
				More.MovieShuffleTrue._visible = false;
			}
			delete (val_shuffle);
		}
		//----
		if (val_mute != undefined) {
			if (val_mute == "True") {
				tools.ButtonMuteFalse.onRollOver();
				setProperty(tools.ButtonMuteFalse, _visible, true);
				setProperty(tools.MovieMuteFalse, _visible, true);
				setProperty(tools.ButtonMuteTrue, _visible, false);
				setProperty(tools.MovieMuteTrue, _visible, false);
			} else {
				tools.ButtonMuteTrue.onRollOver();
				setProperty(tools.ButtonMuteFalse, _visible, false);
				setProperty(tools.MovieMuteFalse, _visible, false);
				setProperty(tools.ButtonMuteTrue, _visible, true);
				setProperty(tools.MovieMuteTrue, _visible, true);
				
			}
			delete (val_mute);
		}
		//----
		if (val_volume != undefined) {
			tools.vol.vol._width = int((int(val_volume)*170)/100);
			tools.vol.txtVol.text = val_volume;
			delete (val_volume);
		}
		//----
		if (val_textDisplay != undefined) {
			//============
			spl = new Array();
			sspl = new Array();
			spl = String(_root.val_textDisplay).split(sym);
			sspl = String(spl[0]).split(sss);
			scti = sspl[0];			// scroll caption title
			scar = sspl[1];			// scroll caption artist
			scal = sspl[2];			// scroll caption album
			scfn = sspl[3];			// scroll caption font name
			scfs = sspl[4];			// scroll caption font size
			// for text caption next and previouse button image
			var cap = new TextFormat();
			cap.font = scfn;
			cap.size = scfs;
			capPT.caption.text = sspl[6];
			capPT.caption.autoSize = true;
			capPT.caption.setTextFormat(cap);
			capNT.caption.text = sspl[5];
			capNT.caption.autoSize = true;
			capNT.caption.setTextFormat(cap);
			if (ButtonPicP._visible == true) {
				SHLNP(true);
			} else {
				SHLNP(false);
			}
			sspl = String(spl[1]).split(sss);
			tsti = sspl[0];			// text scroll title
			tsfnti = sspl[1];		// text scroll font name title
			tsfsti = sspl[2];		// text scroll font size title
			
			sspl = String(spl[2]).split(sss);
			tsar = sspl[0];			// text scroll artist
			tsfnar = sspl[1];		// text scroll font name artist
			tsfsar = sspl[2];		// text scroll font size artist		
			
			sspl = String(spl[3]).split(sss);
			tsal = sspl[0];			// text scroll album
			tsfnal = sspl[1];		// text scroll font name album
			tsfsal = sspl[2];		// text scroll font size album
			//============			
			stTitle = tsti+"**"+tsfnti+"%"+tsfsti;
			stArtist = tsar+"**"+tsfnar+"%"+tsfsar;
			stAlbum = tsal+"**"+tsfnal+"%"+tsfsal;
			SHDot(false);
			//textNLocation("capNTitle",0,stTitle)	// -7
			//textNLocation("capNArtist",424,stArtist)	// int(415)
			//textNLocation("capNAlbum",490,stAlbum)		// int(400+int(capNArtist._height))
			new_capNTitle._visible = false;
			displayTextCurrentInfo("capNTitle", tsti, tsfnti, y_title);
			displayTextCurrentInfo("capNArtist", tsar, tsfnar, y_artist);
			displayTextCurrentInfo("capNAlbum", tsal, tsfnal, y_album);
			if (tools._visible == true) {
				capNArtist._visible = false;
				if (ddArtist._visible == true) {
					ddAr = true;
					ddArtist._visible = false;
				}
				capNAlbum._visible = false;
				if (ddAlbum._visible == true) {
					ddAl = true;
					ddAlbum._visible = false;
				}
			}
			delete (val_textDisplay);
		}
		//----
		if (val_img_current != undefined) {
			if (SHType == "Visualization") {
				ButtonPicV.onRollOver();
				tmpNCimg = "";
				if (val_img_current == "None") {
					tmpVimg = "";
					NV._visible = true;
					PicV1._visible = false;
					PicV2._visible = false;
					PicV1._alpha = 100;
					PicV2._alpha = 0;
					PicV1.unloadMovie();
					PicV2.unloadMovie();
				} else {
					NV._visible = false;
					if (tmpVimg != String(val_img_current).toLowerCase()) {
						fadeimgV1 = false;
						fadeimgV2 = false;
						if (imgV1._alpha>imgV2._alpha) {
							imgV1._alpha = 100;
							imgV2._alpha = 0;
						} else {
							imgV1._alpha = 0;
							imgV2._alpha = 100;
						}
						PicV1._visible = true;
						PicV2._visible = true;
						fadeObjectVisualization(PicV1, PicV2, val_img_current);
						tmpVimg = String(val_img_current).toLowerCase();
					}
				}
			} else {
				ButtonPicC.onRollOver();
				tmpVimg = "";
				if (val_img_current == "None") {
					tmpNCimg = "";
					NC._visible = true;
					PicC1._visible = false;
					PicC2._visible = false;
					PicC1._alpha = 100;
					PicC2._alpha = 0;
					PicC1.unloadMovie();
					PicC2.unloadMovie();
				} else {
					NC._visible = false;
					if (tmpNCimg != String(val_img_current).toLowerCase()) {
						fadeimgC1 = false;
						fadeimgC2 = false;
						if (imgC1._alpha>imgC2._alpha) {
							imgC1._alpha = 100;
							imgC2._alpha = 0;
						} else {
							imgC1._alpha = 0;
							imgC2._alpha = 100;
						}
						PicC1._visible = true;
						PicC2._visible = true;
						fadeObjectCurrent(PicC1, PicC2, val_img_current);
						tmpNCimg = String(val_img_current).toLowerCase();
					}
				}
			}
			browsePopupForm();
			delete (val_img_current);
		}
		//----
		if (val_img_Next != undefined) {
			if (val_img_Next != "") {
				noNext._visible = false;
				coNe._visible = true;
				bdNe._visible = true;
				ButtonPicN._visible = true;
				MoviePicN._visible = true;
				capNT._visible = true;
				if (valreg != "True") {
					NNRN._visible = true;
				}
				if (val_img_Next != "NoNext") {
					if (val_img_Next == "None") {
						tmpNNimg = "";
						NN._visible = true;
						noNext._visible = false;
						PicN1._visible = false;
						PicN2._visible = false;
						PicN1._alpha = 100;
						PicN2._alpha = 0;
						PicN1.unloadMovie();
						PicN2.unloadMovie();
					} else {
						NN._visible = false;
						if (tmpNNimg != String(val_img_Next).toLowerCase()) {
							fadeimgN1 = false;
							fadeimgN2 = false;
							if (imgN1._alpha>imgN2._alpha) {
								imgN1._alpha = 100;
								imgN2._alpha = 0;
							} else {
								imgN1._alpha = 0;
								imgN2._alpha = 100;
							}
							PicN1._visible = true;
							PicN2._visible = true;
							fadeObjectNext(PicN1, PicN2, val_img_Next);
							tmpNNimg = String(val_img_Next).toLowerCase();
						}
					}
				} else {
					tmpNNimg = "";
					noNext._visible = true;
					NN._visible = false;
					PicN1._visible = false;
					PicN2._visible = false;
					PicN1._alpha = 100;
					PicN2._alpha = 0;
					PicN1.unloadMovie();
					PicN2.unloadMovie();
				}
			} else {
				coNe._visible = false;
				bdNe._visible = false;
				tmpNNimg = undefined;
				ButtonPicN._visible = false;
				PicN1._visible = false;
				PicN2._visible = false;
				PicN1.unloadMovie();
				PicN2.unloadMovie();
				NN._visible = false;
				noNext._visible = false;
				MoviePicN._visible = false;
				capNT._visible = false;
				NNRN._visible = false;
			}
			delete (val_img_Next);
		}
		//----
		if (val_img_Previous != undefined) {
			if (val_img_Previous != "") {
				coPr._visible = true;
				bdPr._visible = true;
				ButtonPicP._visible = true;
				MoviePicP._visible = true;
				capPT._visible = true;
				if (valreg != "True") {
					NNRP._visible = true;
				}
				if (val_img_Previous == "None") {
					tmpNPimg = "";
					NP._visible = true;
					PicP1._visible = false;
					PicP2._visible = false;
					PicP1._alpha = 100;
					PicP2._alpha = 0;
					PicP1.unloadMovie();
					PicP2.unloadMovie();
					//NPB = true
				} else {
					NP._visible = false;
					if (tmpNPimg != String(val_img_Previous).toLowerCase()) {
						fadeimgP1 = false;
						fadeimgP2 = false;
						if (imgP1._alpha>imgP2._alpha) {
							imgP1._alpha = 100;
							imgP2._alpha = 0;
						} else {
							imgP1._alpha = 0;
							imgP2._alpha = 100;
						}
						PicP1._visible = true;
						PicP2._visible = true;
						fadeObjectPreviouse(PicP1, PicP2, val_img_Previous);
						tmpNPimg = String(val_img_Previous).toLowerCase();
					}
				}
			} else {
				coPr._visible = false;
				bdPr._visible = false;
				tmpNPimg = undefined;
				ButtonPicP._visible = false;
				PicP1._visible = false;
				PicP2._visible = false;
				PicP1.unloadMovie();
				PicP2.unloadMovie();
				MoviePicP._visible = false;
				NP._visible = false;
				capPT._visible = false;
				NNRP._visible = false;
			}
			delete (val_img_Previous);
		}
		//----
		if (val_img_back != undefined) {
			if (SHType == "Normal") {
				if (val_img_back == "true") {
					fadeObjectCurrent(PicC1, PicC2, tmpNCimg);
				} else {
					lstr = String(tmpNCimg).length;
					ca = String(tmpNCimg).substr((lstr-9));
					tmpNCimg = String(tmpNCimg).substr(0, lstr-8)+"folder.jpg";
				}
			} else {
				if (val_img_back == "true") {
					fadeObjectVisualization(PicV1, PicV2, tmpVimg);
				} else {
					lstr = String(tmpVimg).length;
					ca = String(tmpVimg).substr((lstr-9));
					tmpVimg = String(tmpVimg).substr(0, lstr-8)+"folder.jpg";
				}
			}
			delete (val_img_back);
		}
	}
	//end sendVar
	if (val_play == "True") {
		if (Number(vseek) >= 300){
			seek.knob._width = 300;
		}else{
			seek.knob._width = vseek;
		}
		txtstring.text = timeString;
		txtTime.text = time;
	}
	// For seek bar
	_global.seek = getvalseek;
	if (_global.seek == "true") {
		if (Number(vseek) >= 300){
			seek.knob._width = 300;
		}else{
			seek.knob._width = vseek;
		}			
		txtstring.text = timeString;
		txtTime.text = time;
	}
	imgFadePreviouse();
	// call function for image fade Previouse
	imgFadeCurrent();
	// call function for image fade Current
	imgFadeNext();
	// call function for image fade Next
	imgFadeVisualization();
	// call function for image fade Visualization
};

// Exit Fullscreen slideshow
X.ButtonX.onRelease = function() {
	ButtonCloseFullScreen.onPress();
};
X.ButtonX.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Exit Fullscreen Player", SHTT, -120, 15);
	selectObj("X.MovieX");
//	level = 2;
};
X.ButtonX.onRollOut = function() {
	HideTooltip("txtTooltip");
};

// ButtonPrevious
tools.ButtonPreviouse.onRelease = function() {
	fscommand("NextPrevious","Previous");
//	control_mini_player("Previous","true","true");
	_root.onMouseMove();	
};
tools.ButtonPreviouse.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Previous (Z)", SHTT, -35, 20);
	selectObj("tools.MoviePreviouse");
	level = 2;
};
tools.ButtonPreviouse.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonNext
tools.ButtonNext.onRelease = function() {
//	control_mini_player("Next","true","true");
	fscommand("NextPrevious","Next");
	_root.onMouseMove();		
};
tools.ButtonNext.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Next (B)", SHTT, -25, 20);
	selectObj("tools.MovieNext");
	level = 2;
};
tools.ButtonNext.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonPlay
tools.ButtonPlay.onRelease = function() {
	fscommand("mini", "Play|:|true");
	_root.onMouseMove();	
	tools.ButtonPause.onRollOver();
};
tools.ButtonPlay.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Play (X)", SHTT, -25, 20);
	selectObj("tools.MoviePlay");
	level = 2;
};
tools.ButtonPlay.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonPause
tools.ButtonPause.onRelease = function() {
	fscommand("mini", "Pause|:|true");
	_root.onMouseMove();
	tools.ButtonPlay.onRollOver();	
};
tools.ButtonPause.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Pause (C)", SHTT, -25, 20);
	selectObj("tools.MoviePause");
	level = 2;
};
tools.ButtonPause.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonStop
tools.ButtonStop.onRelease = function() {
	fscommand("mini", "Stop|:|true");
	_root.onMouseMove();	
};
tools.ButtonStop.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Stop (V)", SHTT, -25, 20);
	selectObj("tools.MovieStop");
	level = 2;
};
tools.ButtonStop.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonMore
tools.ButtonMore.onRelease = function() {
	_root.onMouseMove();
	if(More._visible) setProperty(More, _visible, false);
	else setProperty(More, _visible, true);
	More._alpha = 100;
	More.ButtonAddFile.onRollOver();
};
tools.ButtonMore.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "More", SHTT, -10, 20);
	selectObj("tools.MovieMore");
	level = 2;
};
tools.ButtonMore.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonMuteTrue
tools.ButtonMuteTrue.onRelease = function() {
	fscommand("mini", "Mute|:|true");
	_root.onMouseMove();
	tools.ButtonMuteFalse.onRollOver();
};
tools.ButtonMuteTrue.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Mute (M)", SHTT, -25, 20);
	selectObj("tools.MovieMuteTrue");
	level = 2;
};
tools.ButtonMuteTrue.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonMuteFalse
tools.ButtonMuteFalse.onRelease = function() {
	fscommand("mini", "Mute|:|false");
	_root.onMouseMove();	
	tools.ButtonMuteTrue.onRollOver();	
};
tools.ButtonMuteFalse.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Mute (M)", SHTT, -25, 20);
	selectObj("tools.MovieMuteFalse");
	level = 2;
};
tools.ButtonMuteFalse.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonLoopTrue
More.ButtonLoopTrue.onRelease = function() {
	control_mini_player("Repeat","false","true");
	_root.onMouseMove();
	More.ButtonLoopFalse.onRollOver();	
};
More.ButtonLoopTrue.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Repeat (R)", SHTT, -35, 20);
	selectObj("More.MovieLoopTrue");
	level = 2;
};
More.ButtonLoopTrue.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonLoopFalse
More.ButtonLoopFalse.onRelease = function() {
	control_mini_player("Repeat","true","true");
	_root.onMouseMove();
	More.ButtonLoopTrue.onRollOver();
	
};
More.ButtonLoopFalse.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Repeat (R)", SHTT, -35, 20);
	selectObj("More.MovieLoopFalse");
	level = 2;
};
More.ButtonLoopFalse.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonShuffleTrue
More.ButtonShuffleTrue.onRelease = function() {
	control_mini_player("Shuffle","false","true");
	_root.onMouseMove();
	More.ButtonShuffleFalse.onRollOver();		
};
More.ButtonShuffleTrue.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Shuffle (S)", SHTT, -35, 20);
	selectObj("More.MovieShuffleTrue");
	level = 2;
};
More.ButtonShuffleTrue.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonShuffleFalse
More.ButtonShuffleFalse.onRelease = function() {
	control_mini_player("Shuffle","true","true");
	_root.onMouseMove();
	More.ButtonShuffleTrue.onRollOver();
};
More.ButtonShuffleFalse.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Shuffle (S)", SHTT, -35, 20);
	selectObj("More.MovieShuffleFalse");
	level = 2;
};
More.ButtonShuffleFalse.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonAddFile
More.ButtonAddFile.onRelease = function() {
	_root.onMouseMove();
	More._visible = false;
	fscommand("MoreFile", "True");
};
More.ButtonAddFile.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Add More", SHTT, -25, 20);
	selectObj("More.MovieAddFile");
	level = 2;
};
More.ButtonAddFile.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonPlaylist
More.ButtonPlaylist.onRelease = function() {
	ButtonCloseFullScreen.onPress();
	fscommand("Playlist", true);
};
More.ButtonPlaylist.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Playlist", SHTT, -25, 20);
	selectObj("More.MoviePlaylist");
	level = 2;
};
More.ButtonPlaylist.onRollOut = function() {
	HideTooltip("txtTooltip");
};
// ButtonSlideShow
More.ButtonSlideShowNo.onRelease = function() {
	_root.onMouseMove();
	fscommand("SetSlideShow", "No");
	More.ButtonSlideShowYes.onRollOver();
};
More.ButtonSlideShowNo.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Slideshow ON", SHTT, -50, 20);
	selectObj("More.MovieSlideShowNo");
	level = 2;
};
More.ButtonSlideShowNo.onRollOut = function() {
	HideTooltip("txtTooltip");
};
More.ButtonSlideShowYes.onRelease = function() {
	_root.onMouseMove();
	fscommand("SetSlideShow", "Yes");
	More.ButtonSlideShowNo.onRollOver();
};
More.ButtonSlideShowYes.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Slideshow OFF", SHTT, -50, 20);
	selectObj("More.MovieSlideShowYes");
	level = 2;
};
More.ButtonSlideShowYes.onRollOut = function() {
	HideTooltip("txtTooltip");
};
ButtonCloseFullScreen.onPress = function() {
	control_mini_player("close_fullscreen_player","close_fullscreen_player","true");
};

function close_fullscreen_player(){
	SHNormal(false);
	SHVisualization(false);
	PicP1.unloadMovie();
	PicP1._alpha = 100;
	PicP2.unloadMovie();
	PicP2._alpha = 0;
	PicC1.unloadMovie();
	PicC1._alpha = 100;
	PicC2.unloadMovie();
	PicC2._alpha = 0;
	PicN1.unloadMovie();
	PicN1._alpha = 100;
	PicN2.unloadMovie();
	PicN2._alpha = 0;
	PicV1.unloadMovie();
	PicV1._alpha = 100;
	PicV2.unloadMovie();
	picV2._alpha = 0;
	getvalseek = false;
	getvalfade = false;
	More._alpha = 0;
	NP._visible = false;
	NC._visible = false;
	NN._visible = false;
	NV._visible = false;
	noNext._visible = false;
	Key.removeListener(myListener2);
	Key.removeListener(upCtrl);
	CtrlKey = false;
	fscommand("SHFull", _root.tools.vol.vol._width);
}

/*
// ButtonShowTools
ButtonShowTools.onPress=function(){
	_global.j=0;
	tmpm=int(_ymouse);
	tools._alpha=100;
	seek._alpha=100;
	setProperty("tools",_visible,true);
	_global.i=0;
}*/
// ButtonPicP	 click on previous album image
ButtonPicP.onRelease = function() {
	tools.ButtonPreviouse.onRelease();
};
ButtonPicP.onRollOver = function() {
	level = 0;
	selectObj("MoviePicP");
};
// ButtonPicC	click on current album and change to back cover art
ButtonPicC.onRelease = function() {
	if (tmpNCimg != "") {
		toBackCoverArtAlbumNormal(tmpNCimg);
	}
};
ButtonPicC.onRollOver = function() {
	tmpStr = "";
	showIconPurchase(true);
	level = 0;
	selectObj("MoviePicC");
	displayTrackInfoVisual(str_infoPopup);
};
// ButtonPicN	click on next album image
ButtonPicN.onRelease = function() {
	tools.ButtonNext.onRelease();
};
ButtonPicN.onRollOver = function() {
	level = 0;
	selectObj("MoviePicN");
};
// ButtonPicV clic on album image and change to back cover art for visualization
ButtonPicV.onRelease = function() {
	if (tmpVimg != "") {
		toBackCoverArtAlbumVisualization(tmpVimg);
	}
};
ButtonPicV.onRollOver = function() {
	tmpStr = "";
	showIconPurchase(true);
	level = 1;
	selectObj("MoviePicV");
	displayTrackInfoVisual(str_infoPopup);
};

//----------------
vis_mc.next_vis.Button.onRelease = function() {
	fscommand("vis","next");
	clearInterval(ID_showVis);
	ID_showVis = setInterval(hideVis,5000);
};
vis_mc.next_vis.Button.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Next visualization", SHTT, -50, 20);
	selectObj("vis_mc.next_vis.Movie");
};
vis_mc.next_vis.Button.onRollOut = function() {
	HideTooltip("txtTooltip");
};
//----------------
vis_mc.previous_vis.Button.onRelease = function() {
	fscommand("vis","previous");
	clearInterval(ID_showVis);
	ID_showVis = setInterval(hideVis,5000);
};
vis_mc.previous_vis.Button.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Previous visualization", SHTT, -50, 20);
	selectObj("vis_mc.previous_vis.Movie");
};
vis_mc.previous_vis.Button.onRollOut = function() {
	HideTooltip("txtTooltip");
};
//----------------
vis_mc.full_vis.Button.onRelease = function() {
	fscommand("vis","full");
};
vis_mc.full_vis.Button.onRollOver = function() {
	DisplayTooltip(this, "txtTooltip", "Full visualization", SHTT, -50, 20);
	selectObj("vis_mc.full_vis.Movie");
};
vis_mc.full_vis.Button.onRollOut = function() {
	HideTooltip("txtTooltip");
};
/***************************************************************************************************************************/
var CtrlKey = false;
var upCtrl = new Object();
upCtrl.onKeyUp = function() {
	if (Key.getCode() == key_ctrl) {
		CtrlKey = false;
	}
};
Key.removeListener(upCtrl);
Key.addListener(upCtrl);
var myListener2 = new Object();
myListener2.onKeyDown = function() {
	fscommand("clearTimeSlideshow", true);
	fscommand("KeyPressed", true);
	if (Key.getCode() == key_ctrl) {
		CtrlKey = true;
	}
	if (Key.getCode() == key_rightArrow || Key.getCode() == key_upArrow || Key.getCode() == key_leftArrow || Key.getCode() == key_downArrow) {
		_root.onMouseMove();
		CtrlKey = false;
	}
	if (CtrlKey == true) {
		combindKey(Key.getCode());
	} else {
		KeyListener1(Key.getCode());
	}
};
Key.removeListener(myListener2);
Key.addListener(myListener2);
// ----
function combindKey(ascii) {
	if (ascii == key_changeWindow) {		
		control_mini_player("fn_key_changeWindow","fn_key_changeWindow","true");
	} else if (ascii == key_hideMouse) {
		control_mini_player("fn_key_hideMouse","fn_key_hideMouse","true");
	} else if (ascii == key_changeLanguage) {
		control_mini_player("fn_key_changeLanguage","fn_key_changeLanguage","true");
	} else if (ascii == key_minimize) {
		//control_mini_player("fn_key_minimize","fn_key_minimize","true");
		//fscommand("mini","Minimize|:|true");
	} else if (ascii == key_visualization) {
		//control_mini_player("fn_key_visualization","fn_key_visualization","true");
	} else if (ascii == key_showPlaylist) {
		// Y	Show Playlist
		More.ButtonPlaylist.onRelease();
	} else if (ascii == key_slideShow) {
		if (More.ButtonSlideShowNo._visible == true) {
			fscommand("SetSlideShow", "No");
			MouseMove();
			More._visible = true;
		} else if (More.ButtonSlideShowYes._visible == true) {
			fscommand("SetSlideShow", "Yes");
			MouseMove();
			More._visible = true;
		}
	}
}
// ----
function KeyListener1(KeyCode) {
	//keyNumPress(Key.getAscii());
	if (KeyCode == key_backspace) {
		if (PurchaseCDMode._visible == true) {
			PurchaseCDMode.ButtonClose.onRelease();
		} else {
			ButtonCloseFullScreen.onPress();
		}
	} else if (KeyCode == key_enter) {
		eval(replaceName(storeName, "Movie", "Button")).onRelease();
	} else if (KeyCode == key_rightArrow) {
		fscommand("offScreen", true);
		if (level == 0) {
			if (storeName == "MoviePicP") {
				ButtonPicC.onRollOver();
			} else if (storeName == "MoviePicC") {
				if (ButtonPicN._visible == true) {
					ButtonPicN.onRollOver();
				}
			} else if (storeName == "MoviePicN") {
				ButtonPicP.onRollOver();
			}
		} else if (level == 1) {
			if (ButtonPicC._visible == true) {
				ButtonPicC.onRollOver();
			} else {
				ButtonPicV.onRollOver();
			}
		} else if (level == 2) {
			moveKeyOnControl("Right");
		} else if (level == 3) {
			MovePurchaseKey(key_rightArrow);
		}
	} else if (KeyCode == key_leftArrow) {
		fscommand("offScreen", true);
		if (level == 0) {
			if (storeName == "MoviePicP") {
				ButtonPicN.onRollOver();
			} else if (storeName == "MoviePicC") {
				if (ButtonPicP._visible == true) {
					ButtonPicP.onRollOver();
				}
			} else if (storeName == "MoviePicN") {
				ButtonPicC.onRollOver();
			}
		} else if (level == 1) {
			if (ButtonPicC._visible == true) {
				ButtonPicC.onRollOver();
			} else {
				ButtonPicV.onRollOver();
			}
		} else if (level == 2) {
			moveKeyOnControl("Left");
		} else if (level == 3) {
			MovePurchaseKey(key_leftArrow);
		}
	} else if (KeyCode == key_upArrow) {
		if ((level == 0) or (level == 1)) {
			if (Cart._visible == true) {
				Cart.Button.onRollOver();
			}
		} else if (level == 2) {
			if (ButtonPicC._visible == true) {
				ButtonPicC.onRollOver();
			} else {
				ButtonPicV.onRollOver();
			}
		} else if (level == 3) {
			MovePurchaseKey(key_upArrow);
		}
	} else if (KeyCode == key_downArrow) {
		if ((level == 0) or (level == 1)) {
			if (tools._visible == true) {
				if (tools.ButtonPlay._visible == true) {
					tools.ButtonPlay.onRollOver();
				} else {
					tools.ButtonPause.onRollOver();
				}
			} else {
				MouseMove();
				if (tools.ButtonPlay._visible == true) {
					tools.ButtonPlay.onRollOver();
				} else {
					tools.ButtonPause.onRollOver();
				}
			}
		} else if (level == 3) {
			MovePurchaseKey(key_downArrow);
		} else if (level == 4) {
			if (MoviePicC._visible == true) {
				ButtonPicC.onRollOver();
			} else {
				ButtonPicV.onRollOver();
			}
		}
	} else if (KeyCode == key_addFile) {
		// f	Add More File
		More.ButtonAddFile.onRelease();
	} else if (KeyCode == key_space) {
		fscommand("popup",true);
		/*tmpStr = "";
		displayTrackInfoVisual(str_infoPopup);*/
	}
}
function moveKeyOnControl(direction) {
	if (More._visible == true) {
		if (tools.ButtonPlay._visible == true) {
			if (tools.ButtonMuteTrue._visible == true) {
				if (More.ButtonSlideShowYes._visible == true) {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				} else {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				}
			} else {
				if (More.ButtonSlideShowYes._visible == true) {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				} else {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				}
			}
		} else {
			if (tools.ButtonMuteTrue._visible == true) {
				if (More.ButtonSlideShowYes._visible == true) {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				} else {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				}
			} else {
				if (More.ButtonSlideShowYes._visible == true) {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowYes,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				} else {
					if (More.ButtonShuffleFalse._visible == true) {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleFalse,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					} else {
						if (More.ButtonLoopFalse._visible == true) {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopFalse,More.MoviePlaylist", storeName, direction);
						} else {
							StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,More.MovieAddFile,More.MovieSlideShowNo,More.MovieShuffleTrue,More.MovieLoopTrue,More.MoviePlaylist", storeName, direction);
						}
					}
				}
			}
		}
	} else {
		if (tools.ButtonPlay._visible == true) {
			if (tools.ButtonMuteTrue._visible == true) {
				StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,tools.MovieMore", storeName, direction);
			} else {
				StaticMove("tools.MoviePreviouse,tools.MoviePlay,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,tools.MovieMore", storeName, direction);
			}
		} else {
			if (tools.ButtonMuteTrue._visible == true) {
				StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteTrue,tools.MovieStop,tools.MovieNext,tools.MovieMore", storeName, direction);
			} else {
				StaticMove("tools.MoviePreviouse,tools.MoviePause,tools.MovieMuteFalse,tools.MovieStop,tools.MovieNext,tools.MovieMore", storeName, direction);
			}
		}
	}
}

//===========================================================================================
function fn_key_changeWindow(){
	tmpVimg = "";
	tmpNPimg = "";
	tmpNCimg = "";
	tmpNNimg = "";
	NP._visible = false;
	NC._visible = false;
	NN._visible = false;
	NV._visible = false;
	bg_bitrate._visible = false;
	NC._visible = false;
	fscommand("changeWindow", true);
}
// --------
function fn_key_hideMouse(){
	if (Mouse.hide() == 0) {		
		Mouse.show();
		fscommand("setHideMouse", false);
	} else {		
		Mouse.hide();
		fscommand("setHideMouse", true);
	}
}
// --------
function fn_key_changeLanguage(){
	setProperty("txtScroll", _visible, false);
	fscommand("ChangeLanguage", "true");
}
// --------
function fn_key_minimize(){
	tmpVimg = "";
	tmpNPimg = "";
	tmpNCimg = "";
	tmpNNimg = "";
	NP._visible = false;
	NC._visible = false;
	NN._visible = false;
	NV._visible = false;
	bg_bitrate._visible = false;
	NC._visible = false;
	CtrlKey = false;
	fscommand("Minimize", true);
}
// --------
function fn_key_visualization(){
	tmpVimg = "";
	tmpNPimg = "";
	tmpNCimg = "";
	tmpNNimg = "";
	NP._visible = false;
	NC._visible = false;
	NN._visible = false;
	NV._visible = false;
	bg_bitrate._visible = false;
	NC._visible = false;
	browsePopup.hideBrowseSLY();
	fscommand("Visualization", true);
}
//===========================================================================================