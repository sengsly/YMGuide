someListenerKeyUp = new Object();
someListenerKeyUp.onKeyUp = function () {
	if(Key.getCode()==17){
		CtrlKey=false;
	}
};
Key.addListener(someListenerKeyUp);

searchMouseListener = new Object();
searchMouseListener.onMouseDown = function () { 
	_global.boolMouseDown = true;
	fscommand("KeyPressed","MouseDown");
};
Mouse.removeListener(searchMouseListener);
Mouse.addListener(searchMouseListener);

//------------------------------------------------------------------------------------------------------
function press_space_bar_search(){
	if (send_event("normal&&&function||press_space_bar_search||2", false)) {
		return;
	}
	fscommand("popup",true);
}
//------------------------------------------------------------------------------------------------------

myListener = new Object();
myListener.onKeyDown = function () {
	if(!SearchingBox._visible){
		_global.boolMouseDown = true;
		if((Selection.getFocus()+""!="_level0.InputText" && Selection.getFocus()==null) || Selection.getFocus()+""=="_level0.Null" || Selection.getFocus()==null){
			if(UpdateDB._visible || RestoreDB._visible||CopyMusic._visible||BackUpDB._visible||PurchaseCDMode._visible||AddNewScreens._visible||WarningUpdate._visible){
				fscommand("KeyPressed","");
				if(Key.getCode()==39){
					if(WarningUpdate._visible){
						StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel",StoreNameSelected,"Right")
					}else if (UpdateDB._visible){
						StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Right")
					}
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Right");
					}
					
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if(PurchaseCDMode._visible){
						MovePurchaseKey(39);
					}
				}
				else if(Key.getCode()==37){
					if(WarningUpdate._visible){
						StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel",StoreNameSelected,"Left")
					}
					else if (UpdateDB._visible){
						StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Left")
					}
					else if(AddNewScreens._visible){
					    ArrowKeyScreen("Left");
					}
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if(PurchaseCDMode._visible){
						MovePurchaseKey(37);
					}
				}
				else if(Key.getCode()==38){
					if(PurchaseCDMode._visible){
						MovePurchaseKey(38);
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Left")
					}
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Left");
					}
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Left")
					}
				}
				else if(Key.getCode()==40){
					if(PurchaseCDMode._visible){
						MovePurchaseKey(40);
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Right")
					}
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Right");
					}
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Right")
					}
				} else if(Key.getCode()==13){
					PressKey1(Key.getCode());
				}
			} else {
				PressKey1(Key.getCode());
			}
		} else if(Selection.getFocus()+""=="_level0.InputText"){
			if(Key.getCode()==13){
				if(BackNormal._visible)BackNormal.ButtonSearch.onRelease();
				else if(BackAdvance._visible)BackAdvance.ButtonSearch.onRelease();
				Selection.setFocus(Null);
			}else if(Key.getCode()==40){	
				Selection.setFocus(Null);
		
			}
		} else if(Selection.getFocus()+""!="_level0.InputText" && Selection.getFocus()+""!="_level0.Null"){
			if(Key.getCode()==13){
				if(AddTrackBox.InputTrackBox._visible ){
					if(Selection.getFocus()=="_level0.AddTrackBox.InputTrackBox"){
						AddTrackBox.ButtonOk.onRelease();
						return;
					}
				}
				else{	
					Selection.setFocus(Null);
				}
			}
		}
		if(Key.getCode()==9 && ChangeLan=="Uni" && iKhmer!="1" ){
			fscommand("SetFocus");
		}
	} else{

		if(Key.getCode()==13){
			eval(Replace(StoreNameSelected,"Movie","Button")).onRelease();
				
		}
	}
}
Key.addListener(myListener);
var SelectLevel=1;
var CtrlKey=false;
function PressKey1(KeyCode,SendArr){
	if(CtrlKey){
		combine_key1();
	} else {
		if(SendArr=="false"){
			fscommand("KeyPressed","");
		}
	}
	if(KeyCode==39){
		fscommand("offScreen", true);
		CtrlKey=false;
		GoRight();
	}
	else if(keyCode==37){
		fscommand("offScreen", true);
		CtrlKey=false;
		GoLeft();
	}
	else if(KeyCode==38){
		fscommand("offScreen", true);
		CtrlKey=false;
		GoUp();
	}
	else if(keyCode==40){
		fscommand("offScreen", true);
		CtrlKey=false;
		GoDown();
	}
	else if(KeyCode==13){
		CtrlKey=false;
		if(SelectLevel>=51  and SelectLevel<=55){
			eval(StoreNameSelected).onRelease();
		}else{
			eval(Replace(StoreNameSelected,"Movie","Button")).onRelease();
			Selection.setFocus(Null);
		}
	}
	else if(KeyCode==32){
		if(eval(TrackName)._visible){
			if (eval(TrackName).BackStars._visible){
				if(SelectLevel==3){
					eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
					eval(TrackName).BackStars.Button1.onRollOver();
				}
				else if(SelectLevel==9){
					if(StoreNameSelected==TrackName + ".PlayTrailer.Movie"){
						eval(TrackName).PlayTrailer.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
/*					
					if(StoreNameSelected==TrackName + ".BrowseTrailer.Movie"){
						eval(TrackName).BrowseTrailer.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName+".BackStars.Movie5"){
						eval(TrackName).BackStars.Back.onRollOut();
					}
					if(StoreNameSelected==TrackName+".PlusIcon.Movie"){
						eval(TrackName).PlusIcon.Button.onRollOut();
					}
					if(StoreNameSelected==TrackName+".ScanAlbum.Movie"){
						eval(TrackName).ScanAlbum.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName+".PathChapter.Movie"){
						eval(TrackName).PathChapter.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
*/						
					
					else{
						//temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie";
						temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie," + TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," +  TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie,"+ TrackName +".chkOffset.Movie,"+  TrackName + ".fileType.Movie," +  TrackName + ".PlayTrailer.Movie";
						StaticMove(temp,StoreNameSelected,"Right");
					}
				}
			}else{
				press_space_bar_search();
			}
		}else{
			press_space_bar_search();
		}
	}
	else if(KeyCode==17){
		CtrlKey=true;
	}
	else{
		if(CtrlKey){
			combine_key2(KeyCode);
		} else {
			if(KeyCode==83){
				if(eval(TrackName)._visible && eval(TrackName).SearchArtist._visible){
					eval(TrackName).SearchArtist.Button.onRelease();
				}
			} else if((KeyCode>=48 && KeyCode<=57 )||(KeyCode>=96 && KeyCode<=105)){
				if(OpenKey=="False")OpenNumKey();
				OpenKey="True";
				CombinNum+=CoverKeyCodeToNum(KeyCode);
			} else if(KeyCode==65){
				if(PlayAll._visible){
					PlayAll.Button.onRollOver();	
					PlayAll.Button.onRelease();	
				}
				else if(eval(TrackName).ButtonPlay._visible){
					eval(TrackName).ButtonPlay.Button.onRollOver();
					eval(TrackName).ButtonPlay.Button.onRelease();
				}
			} else if(KeyCode==71){
				if(AlbumInfo._visible){
					AlbumInfo.Button.onRollOver();
					AlbumInfo.Button.onRelease();
				}
			} else if(KeyCode==73){
				if(ButtonCD._visible){
					ButtonCD.Button.onRollOver();
					ButtonCD.Button.onRelease();
				}
			} else if(KeyCode==8){
				TopBar.ButtonB.onRollOver();
				TopBar.ButtonB.onRelease();
			} else if(KeyCode==KeyPreAlbum){
				if(PreAlbum._visible){
					PreAlbum.Button.onRollOver();
					PreAlbum.Button.onRelease();
				}
				else if(ArrowBar._visible){
					if(ArrowBar.ButtonArrowLeft._visible){
						ArrowBar.ButtonArrowLeft.onRollOver();
						ArrowBar.ButtonArrowLeft.onRelease();
					}
				}
				else if(VolBar._visible){
					if(VolBar.ButtonArrowLeft._visible){
						VolBar.ButtonArrowLeft.onRollOver();
						VolBar.ButtonArrowLeft.onRelease();
					}
				}
			} else if(KeyCode==KeyNextAlbum){
				if(NextAlbum._visible){
					NextAlbum.Button.onRollOver();
					NextAlbum.Button.onRelease();
				}
				else if(ArrowBar._visible){
					if(ArrowBar.ButtonArrowRight._visible){
						ArrowBar.ButtonArrowRight.onRollOver();
						ArrowBar.ButtonArrowRight.onRelease();
					}
				}
				else if(VolBar._visible){
					if(VolBar.ButtonArrowRight._visible){
						VolBar.ButtonArrowRight.onRollOver();
						VolBar.ButtonArrowRight.onRelease();
					}
				}
			} else if(keyCode == 219){
				if(MainLevel==2){
					if(ArrowBar._visible && ArrowBar.ButtonLeft._visible){
						ArrowBar.ButtonLeft.onRollOver();
						ArrowBar.ButtonLeft.onRelease();
					}
				}
				else if(MainLevel==3){
					if(VolBar._visible && VolBar.ButtonLeft._visible){
						VolBar.ButtonLeft.onRollOver();
						VolBar.ButtonLeft.onRelease();
					}
				}
				else if(MainLevel==4 || MainLevel==1){
					if (eval(TrackName).ButtonLeft._visible ){
						eval(TrackName).ButtonLeft.onRelease();
						eval(TrackName).ButtonLeft.onRollOver();
					}
				}
			} else if(keyCode == 221){
				if(MainLevel==2){
					if(ArrowBar._visible && ArrowBar.ButtonRight._visible){
						ArrowBar.ButtonRight.onRollOver();
						ArrowBar.ButtonRight.onRelease();
					}
				}
				else if(MainLevel==3){
					if(VolBar._visible && VolBar.ButtonRight._visible){
						VolBar.ButtonRight.onRollOver();
						VolBar.ButtonRight.onRelease();
					}
				}
				else if(MainLevel==4 || MainLevel==1){
					if (eval(TrackName).ButtonRight._visible){
						eval(TrackName).ButtonRight.onRelease();
						eval(TrackName).ButtonRight.onRollOver();
					}
				}
			}
		}
	}
	//.................
	function GoRight(){
		fscommand("mouse_off_screen",true);
		var temp1,temp="";
		if(SelectLevel==5){
			MenuMISC._visible=false;
			Menu.MISC.Button.onRollOver();
		}
		else if(SelectLevel==1){
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Right");
		}
		else if(SelectLevel==2){
			if(BackNormal._visible){
				StaticMove("BackNormal.MovieSearch,BackNormal.MovieArtist,BackNormal.MovieAlbum,BackNormal.MovieSong,BackNormal.MovieCountries,BackNormal.MovieSorted,BackNormal.MovieRating,BackNormal.MovieTrack,BackNormal.MovieGender",StoreNameSelected,"Right");
			}
			else if(BackAdvance._visible){
				StaticMove("BackAdvance.MovieA,BackAdvance.MovieReset,BackAdvance.MovieSearch,BackAdvance.MovieNormal,BackAdvance.MovieArtist,BackAdvance.MovieRating,BackAdvance.MovieTrack,BackAdvance.MovieGenre",StoreNameSelected,"Right");
			}
		}
		else if(SelectLevel==3){
				if(StoreNameSelected==String(TrackName+".MovieLeft")){
					eval(TrackName).ButtonRight.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".MovieRight")){
					eval("BackAlbumPic.Button").onRollOver();
				}else if(StoreNameSelected=="BackAlbumPic.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button1.onRollOver();
					else eval(TrackName).BackStars.Button1.onRollOver();
				}else if(StoreNameSelected=="NextAlbum.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button1.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}else if(StoreNameSelected=="PlayAll.Movie" || StoreNameSelected=="AlbumInfo.Movie"||StoreNameSelected=="ButtonCD.Movie" || StoreNameSelected=="PreAlbum.Movie" || StoreNameSelected=="NextAlbum.Movie"){
					StaticMove("PlayAll.Movie,AlbumInfo.Movie,ButtonCD.Movie,PreAlbum.Movie,NextAlbum.Movie",StoreNameSelected,"Right");
				}else if(StoreNameSelected==String(TrackName+".ButtonPlay.Movie")){
					eval(TrackName).SearchArtist.Button.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".ShowPlayer.Movie")){
					eval(TrackName).ShowRip.Button.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".SearchArtist.Movie")){
					eval(TrackName).ShowPlayer.Button.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".ShowRip.Movie")){
					eval(TrackName).chkDisplay.Button.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".chkDisplay.Movie")){
					if(PlayAll._visible)PlayAll.Button.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}else if(substring(StoreNameSelected,0,String(TrackName+".Movie").length)==String(TrackName+".Movie")){
					eval(TrackName+".Button"+IndexTrack).onRollOut();
					eval("BackAlbumPic.Button").onRollOver();
				}
		}
		else if(SelectLevel==9){//Right
				if(StoreNameSelected==TrackName+".PlayTrailer.Movie"){
					eval(TrackName).PlayTrailer.Button.onRollOut();
					BackAlbumPic.Button.onRollOver();
				}
/*				
				if(StoreNameSelected==TrackName+".PlusIcon.Movie"){
					eval(TrackName).PlusIcon.Button.onRollOut();
				} 
				if(StoreNameSelected==TrackName+".ScanAlbum.Movie"){
					eval(TrackName).ScanAlbum.Button.onRollOut();
					BackAlbumPic.Button.onRollOver();
				}
*/				
				else{
					//temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie";
					temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie," + TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," +  TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie," + TrackName +".chkOffset.Movie,"+  TrackName + ".fileType.Movie," +TrackName + ".PlayTrailer.Movie";
					StaticMove(temp,StoreNameSelected,"Right");
				}
		}
		else if(SelectLevel==10){
						if(StoreNameSelected=="BackAlbumInfo.BackStars.Movie5"){
							BackAlbumInfo.BackStars.Back.onRollOut();
							eval("BackAlbumPic.Button").onRollOver();
						}
						else {
							temp="BackAlbumInfo.BackStars.Movie1,BackAlbumInfo.BackStars.Movie2,BackAlbumInfo.BackStars.Movie3,BackAlbumInfo.BackStars.Movie4,BackAlbumInfo.BackStars.Movie5";
							StaticMove(temp,StoreNameSelected,"Right");
						}
		}
		else if(SelectLevel==40){
			//StaticMove("ArrowBar.MovieLeft,ArrowBar.MovieRight",StoreNameSelected,"Right");
			for(var j=0;j<CountArrow;j++){
				temp+=temp1+"ArrowBar.Movie"+j;
				temp1=",";
			}
			if(ArrowBar.ButtonLeft._visible)	temp="ArrowBar.MovieLeft,"+temp+",ArrowBar.MovieRight";
			if(ArrowBar.MovieArrowLeft._visible)temp="ArrowBar.MovieArrowLeft,"+temp+",ArrowBar.MovieArrowRight";
			StaticMove(temp,StoreNameSelected,"Right");
		}
		else if(SelectLevel==4){
			//MoveLeftRight("VolBar",StoreNameSelected,CountVol,"Right");
			for(var j=0;j<CountVol;j++){
				temp+=temp1+"VolBar.Movie"+j;


				temp1=",";
			}
			if(VolBar.ButtonLeft._visible)	temp="VolBar.MovieLeft,"+temp+",VolBar.MovieRight";
			if(VolBar.MovieArrowLeft._visible)temp="VolBar.MovieArrowLeft,"+temp+",VolBar.MovieArrowRight";
			StaticMove(temp,StoreNameSelected,"Right");
		}
		else if(SelectLevel==30){
			MoveAlbum("Right");
		
		}
		else if(SelectLevel==51){
			staticMove("_level0.Keyboard.B1,_level0.Keyboard.B2,_level0.Keyboard.B3,_level0.Keyboard.B4,_level0.Keyboard.B5,_level0.Keyboard.B6,_level0.Keyboard.B7,_level0.Keyboard.B8,_level0.Keyboard.B9,_level0.Keyboard.B10,_level0.Keyboard.B11,_level0.Keyboard.B12,_level0.Keyboard.B13,_level0.Keyboard.B14,_level0.Keyboard.BackSpace", StoreNameSelected, "Right");
		}
		else if(SelectLevel==52){
			staticMove("_level0.Keyboard.B17,_level0.Keyboard.B18,_level0.Keyboard.B19,_level0.Keyboard.B20,_level0.Keyboard.B21,_level0.Keyboard.B22,_level0.Keyboard.B23,_level0.Keyboard.B24,_level0.Keyboard.B25,_level0.Keyboard.B26,_level0.Keyboard.B27,_level0.Keyboard.B28,_level0.Keyboard.B29", StoreNameSelected, "Right");
		}
		else if(SelectLevel==53){
			staticMove("_level0.Keyboard.B31,_level0.Keyboard.B32,_level0.Keyboard.B33,_level0.Keyboard.B34,_level0.Keyboard.B35,_level0.Keyboard.B36,_level0.Keyboard.B37,_level0.Keyboard.B38,_level0.Keyboard.B39,_level0.Keyboard.B40,_level0.Keyboard.B41,_level0.Keyboard.B42", StoreNameSelected, "Right");
		}
		else if(SelectLevel==54){
			staticMove("_level0.Keyboard.LShift,_level0.Keyboard.B43,_level0.Keyboard.B44,_level0.Keyboard.B45,_level0.Keyboard.B46,_level0.Keyboard.B47,_level0.Keyboard.B48,_level0.Keyboard.B49,_level0.Keyboard.B50,_level0.Keyboard.B51,_level0.Keyboard.B52,_level0.Keyboard.RShift", StoreNameSelected, "Right");
		}
		else if(SelectLevel==55){
			staticMove("_level0.Keyboard.LCtrl,_level0.Keyboard.LAlt,_level0.Keyboard.B56", StoreNameSelected, "Right");
		}
	}
	function GoLeft(){
		fscommand("mouse_off_screen",true);
		var temp1="";
		var temp="";
		if(SelectLevel==5){
			if(StoreNameSelected=="Menu.MISC.Movie")MenuMISC.UpdateDB.Button.onRollOver();
		}
		else if(SelectLevel==1){
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Left");
		}
		else if(SelectLevel==2){
			if(BackNormal._visible){
				if(StoreNameSelected=="BackNormal.MovieSearch"){
					BackNormal.search_mc.onRelease();
				}else{
					StaticMove("BackNormal.MovieSearch,BackNormal.MovieArtist,BackNormal.MovieAlbum,BackNormal.MovieSong,BackNormal.MovieCountries,BackNormal.MovieSorted,BackNormal.MovieRating,BackNormal.MovieTrack,BackNormal.MovieGender",StoreNameSelected,"Left");
				}
			}
			else if(BackAdvance._visible){
				if(StoreNameSelected=="BackAdvance.MovieSearch"){
					BackAdvance.search_mc.onRelease();
				}else{
					StaticMove("BackAdvance.MovieA,BackAdvance.MovieReset,BackAdvance.MovieSearch,BackAdvance.MovieNormal,BackAdvance.MovieArtist,BackAdvance.MovieRating,BackAdvance.MovieTrack,BackAdvance.MovieGenre",StoreNameSelected,"Left");
				}
			}
		}
		else if(SelectLevel==9){
			if(StoreNameSelected==TrackName+".BackStars.Movie1"){
				eval(TrackName).BackStars.Back.onRollOut();
			}
                    if(StoreNameSelected==TrackName+".PlusIcon.Movie"){
					eval(TrackName).PlusIcon.Button.onRollOut();
				}
			/*if(StoreNameSelected==TrackName+".ScanAlbum.Movie"){
				eval(TrackName).ScanAlbum.Button.onRollOut();
				eval(TrackName).Button0.onRollOver();
			}*/
			else {
				//temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie";
				temp=TrackName+".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie,"+TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," + TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie," + TrackName +".chkOffset.Movie,"+  TrackName + ".fileType.Movie,"+  TrackName + ".PlayTrailer.Movie";
				StaticMove(temp,StoreNameSelected,"Left");
			}
		}
		else if(SelectLevel==3){
				if(StoreNameSelected==String(TrackName+".ShowPlayer.Movie")){
					eval(TrackName).SearchArtist.Button.onRollOver();
				}
				else if(StoreNameSelected==String(TrackName+".ShowRip.Movie")){
					eval(TrackName).ShowPlayer.Button.onRollOver();
				}
				else if(StoreNameSelected==String(TrackName+".SearchArtist.Movie")){
					if(eval(TrackName).ButtonPlay._visible)eval(TrackName).ButtonPlay.Button.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}
				else if(StoreNameSelected==String(TrackName+".MovieRight")){
					eval(TrackName).ButtonLeft.onRollOver();
				}	
				else if(StoreNameSelected=="BackAlbumPic.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button5.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}
				else if(StoreNameSelected=="PlayAll.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button5.onRollOver();
					else eval(TrackName).chkDisplay.Button.onRollOver();
				}else if(StoreNameSelected==String(TrackName+".chkDisplay.Movie")){
					eval(TrackName + ".ShowRip.Button").onRollover();
				}else if(StoreNameSelected=="PlayAll.Movie" || StoreNameSelected=="AlbumInfo.Movie" || StoreNameSelected=="ButtonCD.Movie"|| StoreNameSelected=="PreAlbum.Movie" || StoreNameSelected=="NextAlbum.Movie"){
					StaticMove("PlayAll.Movie,AlbumInfo.Movie,ButtonCD.Movie,PreAlbum.Movie,NextAlbum.Movie",StoreNameSelected,"Left");
				}
				else if(StoreNameSelected==TrackName+".ButtonPlay.Movie"){
					eval("BackAlbumPic.Button").onRollOver();
				}
				else if(substring(StoreNameSelected,0,String(TrackName+".Movie").length)==String(TrackName+".Movie")){
					//eval("BackAlbumPic.Button").onRollOver();
					eval(TrackName+".Button"+IndexTrack).onRollOut();
					if(eval(TrackName).ButtonRight._visible){
						eval(TrackName).ButtonRight.onRelease();
						eval(TrackName).Button0.onRollOver();
					}
					else{
						eval("BackAlbumPic.Button").onRollOver();
					}
				}
			
		}
		else if(SelectLevel==40){
			//StaticMove("ArrowBar.MovieLeft,ArrowBar.MovieRight",StoreNameSelected,"Left");
			for(var j=0;j<CountArrow;j++){
				temp+=temp1+"ArrowBar.Movie"+j;
				temp1=",";
			}
			if(ArrowBar.ButtonLeft._visible)	temp="ArrowBar.MovieLeft,"+temp+",ArrowBar.MovieRight";
			if(ArrowBar.MovieArrowLeft._visible)temp="ArrowBar.MovieArrowLeft,"+temp+",ArrowBar.MovieArrowRight";
			StaticMove(temp,StoreNameSelected,"Left");
		}
		else if(SelectLevel==4){
			//MoveLeftRight("VolBar",StoreNameSelected,CountVol,"Left");
			for(var j=0;j<CountVol;j++){
				temp+=temp1+"VolBar.Movie"+j;
			   temp1=",";
			}
			if(VolBar.ButtonLeft._visible)	temp="VolBar.MovieLeft,"+temp+",VolBar.MovieRight";
			if(VolBar.MovieArrowLeft._visible)temp="VolBar.MovieArrowLeft,"+temp+",VolBar.MovieArrowRight";
			StaticMove(temp,StoreNameSelected,"Left");
		}
		else if(SelectLevel==30){
			MoveAlbum("Left");
		}
		else if(SelectLevel==10){
					if(StoreNameSelected=="BackAlbumInfo.BackStars.Movie1"){
						BackAlbumInfo.BackStars.Back.onRollOut();
						eval("BackAlbumPic.Button").onRollOver();
					}
					else {
						temp="BackAlbumInfo.BackStars.Movie1,BackAlbumInfo.BackStars.Movie2,BackAlbumInfo.BackStars.Movie3,BackAlbumInfo.BackStars.Movie4,BackAlbumInfo.BackStars.Movie5";
						StaticMove(temp,StoreNameSelected,"Left");
					}
		}
		else if(SelectLevel==51){
			staticMove("_level0.Keyboard.B1,_level0.Keyboard.B2,_level0.Keyboard.B3,_level0.Keyboard.B4,_level0.Keyboard.B5,_level0.Keyboard.B6,_level0.Keyboard.B7,_level0.Keyboard.B8,_level0.Keyboard.B9,_level0.Keyboard.B10,_level0.Keyboard.B11,_level0.Keyboard.B12,_level0.Keyboard.B13,_level0.Keyboard.B14,_level0.Keyboard.BackSpace", StoreNameSelected, "Left");
		}
		else if(SelectLevel==52){
			staticMove("_level0.Keyboard.B17,_level0.Keyboard.B18,_level0.Keyboard.B19,_level0.Keyboard.B20,_level0.Keyboard.B21,_level0.Keyboard.B22,_level0.Keyboard.B23,_level0.Keyboard.B24,_level0.Keyboard.B25,_level0.Keyboard.B26,_level0.Keyboard.B27,_level0.Keyboard.B28,_level0.Keyboard.B29", StoreNameSelected, "Left");
		}
		else if(SelectLevel==53){
			staticMove("_level0.Keyboard.B31,_level0.Keyboard.B32,_level0.Keyboard.B33,_level0.Keyboard.B34,_level0.Keyboard.B35,_level0.Keyboard.B36,_level0.Keyboard.B37,_level0.Keyboard.B38,_level0.Keyboard.B39,_level0.Keyboard.B40,_level0.Keyboard.B41,_level0.Keyboard.B42", StoreNameSelected, "Left");
		}
		else if(SelectLevel==54){
			staticMove("_level0.Keyboard.LShift,_level0.Keyboard.B43,_level0.Keyboard.B44,_level0.Keyboard.B45,_level0.Keyboard.B46,_level0.Keyboard.B47,_level0.Keyboard.B48,_level0.Keyboard.B49,_level0.Keyboard.B50,_level0.Keyboard.B51,_level0.Keyboard.B52,_level0.Keyboard.RShift", StoreNameSelected, "Left");
		}
		else if(SelectLevel==55){
			staticMove("_level0.Keyboard.LCtrl,_level0.Keyboard.LAlt,_level0.Keyboard.B56", StoreNameSelected, "Left");
		}
	}
	function GoUp(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			if(MenuLevel==1){
				StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Left");
			}
			else{
				if(StoreNameSelected=="Menu.AboutSly.Movie"){
					HideMenu();
					TopBar.ButtonX.onRollOver();
				}
				else {
					StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Left");
				}
			}
		}
		if(SelectLevel==2){
			if(BackNormal._visible){
				if(StoreNameSelected=="BackNormal.MovieSearch"||StoreNameSelected=="BackNormal.MovieA"){
					TopBar.ButtonX.onRollOver();
					//TopBar.ButtonM.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieTrack"  or StoreNameSelected=="BackNormal.MovieRating"){
					BackNormal.ButtonAlbum.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieGender"){
					BackNormal.ButtonSong.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieSorted"){
					BackNormal.ButtonArtist.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieCountries"){
					BackNormal.ButtonArtist.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieArtist"){
					BackNormal.ButtonSearch.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieAlbum"){
					//Selection.setFocus(InputText);
					BackNormal.ButtonSearch.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieSong"){
					BackNormal.ButtonSearch.onRollOver();
				}else if (StoreNameSelected == "_root.BackNormal.displayType.Movie0" )
				{
					BackNormal.ButtonArtist.onRollOver();
				}
				else if (StoreNameSelected == "_root.BackNormal.displayType.Movie1" ){
					eval("BackNormal.displayType.Button0").onRollOver();	
				}else if (substring(StoreNameSelected, 0, "BackNormal.BackListTrack.Movie".length) == "BackNormal.BackListTrack.Movie") {
					var TotalIndex = 3;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				//for BacklistGender......................
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListGender.Movie".length) == "BackNormal.BackListGender.Movie") {
					var TotalIndex = 4;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListCountries.Movie".length) == "BackNormal.BackListCountries.Movie") {
					var TotalIndex = 4;
					if(!SelecteListItemUp(StoreNameSelected, TotalIndex)){
						SelectButton("BackNormal.MovieCountries");
					}
				}else if (substring(StoreNameSelected, 0, "BackNormal.BackListRating.Movie".length) == "BackNormal.BackListRating.Movie") {
					var TotalIndex = 6
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
			}
			else if(BackAdvance._visible){
				if(StoreNameSelected=="BackAdvance.MovieA" || StoreNameSelected=="BackAdvance.MovieReset" ||StoreNameSelected=="BackAdvance.MovieSearch" || StoreNameSelected=="BackAdvance.MovieNormal"){
					TopBar.ButtonM.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieArtist"){
					BackAdvance.ButtonReset.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieRating"){
					BackAdvance.ButtonSearch.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieMood"){
					BackAdvance.ButtonNormal.onRollOver();
				}
				
				else if(StoreNameSelected=="BackAdvance.MovieTrack"){
					BackAdvance.ButtonArtist.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieGenre"){
					BackAdvance.ButtonRating.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieDance"){
					BackAdvance.ButtonMood.onRollOver();
				}
				// for BackListArtist................
				if (substring(StoreNameSelected, 0, "BackAdvance.BackListArtist.Movie".length) == "BackAdvance.BackListArtist.Movie") {
					if (StoreNameSelected == "BackAdvance.BackListArtist.Movie0") {
						if (BackAdvance.BackListArtist.ButtonLeft.enabled) {

							BackAdvance.BackListArtist.ButtonLeft.onRelease();
						}
					}
					var TotalIndex = CountArtist;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				if (substring(StoreNameSelected, 0, "BackAdvance.BackListMood.Movie".length) == "BackAdvance.BackListMood.Movie") {
					if (StoreNameSelected == "BackAdvance.BackListMood.Movie0") {
						if (BackAdvance.BackListMood.ButtonLeft.enabled) {
							BackAdvance.BackListMood.ButtonLeft.onRelease();
						}
					}
					var TotalIndex = CountMood;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				// for BackListGenre.................
				if (substring(StoreNameSelected, 0, "BackAdvance.BackListGenre.Movie".length) == "BackAdvance.BackListGenre.Movie") {
					if (StoreNameSelected == "BackAdvance.BackListGenre.Movie0") {
						if (BackAdvance.BackListGenre.ButtonLeft.enabled) {
							BackAdvance.BackListGenre.ButtonLeft.onRelease();
						}
					}
					var TotalIndex = CountGenre;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				// for BackListDance.................
				if (substring(StoreNameSelected, 0, "BackAdvance.BackListDance.Movie".length) == "BackAdvance.BackListDance.Movie") {
					if (StoreNameSelected == "BackAdvance.BackListDance.Movie0") {
						if (BackAdvance.BackListDance.ButtonLeft.enabled) {
							BackAdvance.BackListDance.ButtonLeft.onRelease();
						}
					}
					var TotalIndex = CountDance;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
				// for BackListTrack.................


				if (substring(StoreNameSelected, 0, "BackAdvance.BackListTrack.Movie".length) == "BackAdvance.BackListTrack.Movie") {
					var TotalIndex = 3;
					SelecteListItemUp(StoreNameSelected, TotalIndex);
				}
			}
			
		}
		else if(SelectLevel==3){
			if(StoreNameSelected==TrackName+".ButtonPlay.Movie")eval("BackAlbumPic.Button").onRollOver();
			else if(StoreNameSelected==TrackName+".SearchArtist.Movie"){
				eval("BackAlbumPic.Button").onRollOver();
			}
			else if(StoreNameSelected==TrackName+".ShowPlayer.Movie"){
				eval("BackAlbumPic.Button").onRollOver();
			}
			else if(StoreNameSelected==TrackName+".ShowRip.Movie"){
				eval("BackAlbumPic.Button").onRollOver();
			}
			else if(StoreNameSelected==TrackName+".chkDisplay.Movie"){
				eval("BackAlbumPic.Button").onRollOver();
			}
			else if(StoreNameSelected=="PlayAll.Movie" || StoreNameSelected=="AlbumInfo.Movie" || StoreNameSelected=="ButtonCD.Movie"|| StoreNameSelected=="PreAlbum.Movie" || StoreNameSelected=="NextAlbum.Movie"){
					if(BackAlbumInfo._visible)eval("BackAlbumPic.Button").onRollOver();
					else eval(TrackName).SearchArtist.Button.onRollOver();
			}
			else if(StoreNameSelected==TrackName+".Movie0" || StoreNameSelected=="BackAlbumPic.Movie"){
				eval(TrackName).Button0.onRollOut();
				TopBar.ButtonM.onRollOver();
			}
			else{ 
				eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
				MoveLeftRight(TrackName,StoreNameSelected,eval("Count"+TrackObj),"Left");
			}
		}
		else if(SelectLevel==9){
			if(StoreNameSelected==TrackName+".PlusIcon.Movie")eval(TrackName).BackStars.Button1.onRollOver();
			else TopBar.ButtonM.onRollOver();
		}
		else if(SelectLevel==10){
			BackAlbumInfo.BackStars.Back.onRollOut();
			TopBar.ButtonM.onRollOver();
		}
		else if(SelectLevel==4){
			TopBar.ButtonM.onRollOver();
		}
		else if(SelectLevel==40){
			TopBar.ButtonM.onRollOver();
		}
		else if(SelectLevel==30){
			MoveAlbum("Up");
		}
		else if(SelectLevel==51){
			if(BackNormal._visible){
				BackNormal.ButtonSorted.onRollOver();
			}else{
				BackAdvance.ButtonGenre.onRollOver();
			}
		}
		else if(SelectLevel>51 and SelectLevel<=55){
			var iIndex=getObjIndex (keyBoardArray[SelectLevel-51], StoreNameSelected)
			if (iIndex>=0){
				eval(keyBoardArray[SelectLevel-52][iIndex]).onRollOver();

			}

		}
	}
	function GoDown(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			if(MenuLevel==1){
				StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Right");
			}
			else StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Right");
		}
		else if(SelectLevel==1){
			if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
				//eval("Menu.RipCD.Button").onRollOver();
				  eval("Menu.AboutSly.Button").onRollOver();
			}
			else if(!BackAdvance._visible && !BackNormal._visible){
				if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
					eval(TrackName).Button0.onRollOver();
				}
				else if(BackAlbumInfo._visible){
					BackAlbumInfo.BackStars.Button1.onRollOver();
				}
				else if(VolBar._visible){
					VolBar.Button0.onRollOver();
				}
				else if(ArrowBar._visible){
					//if(ArrowBar.ButtonLeft._visible)ArrowBar.ButtonLeft.onRollOver();
					//else eval(NameAlbum+".Button0").onRollOver();
					ArrowBar.Button0.onRollOver();
				}
			}
			else{
				i
				if(BackAdvance._visible){
					if(StoreNameSelected=="TopBar.MovieX"){
						BackAdvance.ButtonSearch.onRollOver();
					}else{
						BackAdvance.search_mc.onRelease();
					}
				}
				else if(BackNormal._visible){
					if(StoreNameSelected=="TopBar.MovieX"){
						BackNormal.ButtonSearch.onRollOver();
					}else{
						BackNormal.search_mc.onRelease();
					}
				}
			}
		}
		else if(SelectLevel==4 || SelectLevel==40){
			eval(NameAlbum+".Button0").onRollOver();
		}
		else if(SelectLevel==30){
			MoveAlbum("Down");
		}
		else if(SelectLevel==9){
			if(StoreNameSelected==TrackName+".PlusIcon.Movie")eval("BackAlbumPic.Button").onRollOver();
			else eval(TrackName).PlusIcon.Button.onRollOver();
		}
		else if(SelectLevel==3){
				if(StoreNameSelected=="BackAlbumPic.Movie"){
					eval(TrackName).SearchArtist.Button.onRollOver();
					/*if(BackAlbumInfo._visible)PlayAll.Button.onRollOver();
					else{
						if(eval(TrackName).ButtonPlay._visible){
							eval(TrackName).ButtonPlay.Button.onRollOver();
						}
						else if (PlayAll._visible){
							eval(TrackName).SearchArtist.Button.onRollOver();
						}
					}*/
						
				}
				else if(StoreNameSelected==TrackName+".SearchArtist.Movie"){
					if (PlayAll._visible)eval("PlayAll.Button").onRollOver();
				}
				else if(StoreNameSelected==TrackName+".ShowPlayer.Movie"){
					if (PlayAll._visible)eval("PlayAll.Button").onRollOver();
				}
				else if(StoreNameSelected==TrackName+".ShowRip.Movie"){
					if (PlayAll._visible)eval("PlayAll.Button").onRollOver();
				}
				//else if(StoreNameSelected=="PlayAll.Movie" || StoreNameSelected=="AlbumInfo.Movie" || StoreNameSelected=="PreAlbum.Movie" || StoreNameSelected=="NextAlbum.Movie"){
					//eval(TrackName).ShowPlayer.Button.onRollOver();
				//}
				else{
					eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
					MoveLeftRight(TrackName,StoreNameSelected,eval("Count"+TrackObj),"Right");
				}
			
		}
		else if(SelectLevel==2){
			if(BackAdvance._visible){
				if(StoreNameSelected=="BackAdvance.MovieA" ||StoreNameSelected=="BackAdvance.MovieReset"){
					BackAdvance.ButtonArtist.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieSearch"){
					BackAdvance.ButtonRating.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieNormal"){
					BackAdvance.ButtonMood.onRollOver();
				}
				else if(StoreNameSelected=="BackAdvance.MovieArtist"){
					if(BackAdvance.BackListArtist._visible){
						BackAdvance.BackListArtist.Button0.onRollOver();
					}
					else{
						BackAdvance.ButtonTrack.onRollOver();
					}
				}
				else if(StoreNameSelected=="BackAdvance.MovieMood"){
					if(BackAdvance.BackListMood._visible){
						BackAdvance.BackListMood.Button0.onRollOver();
					}
					else{
						BackAdvance.ButtonDance.onRollOver();
					}
				}
				else if(StoreNameSelected=="BackAdvance.MovieTrack"){
					if(BackAdvance.BackListTrack._visible){
						BackAdvance.BackListTrack.Button0.onRollOver();
					}
					else if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
						eval(TrackName).Button0.onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
					else if(eval(NameAlbum)._visible){
						eval(NameAlbum+".Button0").onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
				}
				else if(StoreNameSelected=="BackAdvance.MovieGenre"){
					if(BackAdvance.BackListGenre._visible){
						BackAdvance.BackListGenre.Button0.onRollOver();
					}
					else if(KeyBoard._visible){
						KeyBoard.B1.onRollOver();
					}
					else if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
						eval(TrackName).Button0.onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
					else if(eval(NameAlbum)._visible){
						eval(NameAlbum+".Button0").onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
				}
				else if(StoreNameSelected=="BackAdvance.MovieDance"){
					if(BackAdvance.BackListDance._visible){
						BackAdvance.BackListDance.Button0.onRollOver();
					}
					else if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
						eval(TrackName).Button0.onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
					else if(eval(NameAlbum)._visible){
						eval(NameAlbum+".Button0").onRollOver();
						BackAdvance._visible=false;
						fscommand("ShowTextSearch","no")
					}
				}
				//BackArtistList...............
				else if (substring(StoreNameSelected, 0, "BackAdvance.BackListArtist.Movie".length) == "BackAdvance.BackListArtist.Movie") {
					var TotalIndex = CountArtist;
					if (StoreNameSelected == "BackAdvance.BackListArtist.Movie"+(TotalIndex-1)) {
						if (BackAdvance.BackListArtist.ButtonRight.enabled) {
							BackAdvance.BackListArtist.ButtonRight.onRelease();
						}
					}
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
				//BackArtistMood...............
				else if (substring(StoreNameSelected, 0, "BackAdvance.BackListMood.Movie".length) == "BackAdvance.BackListMood.Movie") {
					var TotalIndex = CountMood;
					if (StoreNameSelected == "BackAdvance.BackListMood.Movie"+(TotalIndex-1)) {
						if (BackAdvance.BackListMood.ButtonRight.enabled) {
							BackAdvance.BackListMood.ButtonRight.onRelease();
						}
					}
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
				//BackArtistGenre...............
				else if (substring(StoreNameSelected, 0, "BackAdvance.BackListGenre.Movie".length) == "BackAdvance.BackListGenre.Movie") {
					var TotalIndex = CountGenre;
					if (StoreNameSelected == "BackAdvance.BackListGenre.Movie"+(TotalIndex-1)) {
						if (BackAdvance.BackListGenre.ButtonRight.enabled) {
							BackAdvance.BackListGenre.ButtonRight.onRelease();
						}
					}
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
				//BackArtistDance...............
				else if (substring(StoreNameSelected, 0, "BackAdvance.BackListDance.Movie".length) == "BackAdvance.BackListDance.Movie") {
					var TotalIndex = CountDance;
					if (StoreNameSelected == "BackAdvance.BackListDance.Movie"+(TotalIndex-1)) {
						if (BackAdvance.BackListDance.ButtonRight.enabled) {
							BackAdvance.BackListDance.ButtonRight.onRelease();
						}
					}
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
				//BackListTrack
				else if (substring(StoreNameSelected, 0, "BackAdvance.BackListTrack.Movie".length) == "BackAdvance.BackListTrack.Movie") {
					var TotalIndex = 3;
					SelecteListItemDown(StoreNameSelected, TotalIndex);


				} 
				
			}
			else if(BackNormal._visible){
				if(StoreNameSelected=="BackNormal.MovieA"){
					BackNormal.ButtonArtist.onRollOver();

				}
				else if(StoreNameSelected=="BackNormal.MovieSearch"){
					BackNormal.ButtonSong.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieAdvance"){
					BackNormal.ButtonSong.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieArtist"){
					if ( eval("BackNormal.displayType")._visible) 
					{
						eval("BackNormal.displayType.Button0").onRollOver();
					}else
					{
						BackNormal.ButtonSorted.onRollOver();
					}	
				}else if (StoreNameSelected == "_root.BackNormal.displayType.Movie0" )
				{
					eval("BackNormal.displayType.Button1").onRollOver();	
				}
				else if (StoreNameSelected=="BackNormal.MovieAlbum" ){
					BackNormal.ButtonTrack.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieSong"){
					BackNormal.ButtonGender.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieSong"){
					BackNormal.ButtonTrack.onRollOver();
				}
				else if(StoreNameSelected=="BackNormal.MovieRating"){
					if(BackNormal.BackListRating._visible){
						BackNormal.BackListRating.Button0.onRollOver();
					}
				}
				else if(StoreNameSelected=="BackNormal.MovieTrack" || StoreNameSelected=="BackNormal.MovieSorted" ){
					if(BackNormal.BackListTrack._visible){
						BackNormal.BackListTrack.Button0.onRollOver();
					}
					else if(KeyBoard._visible){
						KeyBoard.B1.onRollOver();
					}
					else if(eval(TrackName)._visible && eval(TrackName).Button0._visible){
						eval(TrackName).Button0.onRollOver();
						BackNormal._visible=false;
						fscommand("ShowTextSearch","no")
					}
					else if(eval(NameAlbum)._visible){
						eval(NameAlbum+".Button0").onRollOver();
						BackNormal._visible=false;
						fscommand("ShowTextSearch","no")
					}
				}
				else if(StoreNameSelected=="BackNormal.MovieGender"){
					if(BackNormal.BackListGender._visible){
						BackNormal.BackListGender.Button0.onRollOver();
					}
				}
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListTrack.Movie".length) == "BackNormal.BackListTrack.Movie") {
					var TotalIndex = 3;
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListGender.Movie".length) == "BackNormal.BackListGender.Movie") {
					var TotalIndex = 4;
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				}
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListCountries.Movie".length) == "BackNormal.BackListCountries.Movie") {
					var TotalIndex = 4;
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				}else if(StoreNameSelected=="BackNormal.MovieCountries"){
					if(BackNormal.BackListCountries._visible)
					BackNormal.BackListCountries.Button0.onRollOver();
				} 
				//BackArtistRating...............
				else if (substring(StoreNameSelected, 0, "BackNormal.BackListRating.Movie".length) == "BackNormal.BackListRating.Movie") {
					var TotalIndex = 6;
					SelecteListItemDown(StoreNameSelected, TotalIndex);
				} 
			}
			//for BackListArtist............................
			
		}
		else if(SelectLevel>=51 and SelectLevel<=54){
			var iIndex=getObjIndex (keyBoardArray[SelectLevel-51], StoreNameSelected)
			if (iIndex>=0){
				eval(keyBoardArray[SelectLevel-50][iIndex]).onRollOver();

			}

		}
	}
	
}

function SelecteListItemUp(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	var newObject=Str+(Index-1);
	if(eval(newObject)._visible){
		SelectButton(newObject);	
		return true;			//selected
	}else{
		return false;			//there is no more button up
	}
/*
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index>0) {
		SelectButton(Str+(Index-1));
	} else {
		SelectButton(Str+(TotalIndex-1));
	}
*/
}
function SelecteListItemDown(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	var newObject=Str+(Index+1);
	if(eval(newObject)._visible){
		SelectButton(newObject);	
	}else{
		SelectButton(Str+"0");
	}
	/*
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index<TotalIndex-1) {
		SelectButton(Str+(Index+1));
	} else {
		SelectButton(Str+"0");
	}
	*/
}
function Escape(){
	if(WarningUpdate._visible){
		WarningUpdate.ButtonCancel.onRelease();
	}
	else if(UpdateDB._visible){
		UpdateDB.ButtonCancel.onRelease();
	}
	else if(PurchaseCDMode._visible){
		PurchaseCDMode.ButtonClose.onRelease();
	}
	else if(RestoreDB._visible){
		RestoreDB.ButtonCancel.onRelease();
	}
	else if(BackupDB._visible){
		BackupDB.ButtonCancel.onRelease();
	}
	else if(CopyMusic._visible){
		CopyMusic.ButtonCancel.onRelease();
	}
	else if(AddNewScreens._visible){
	    AddNewScreens.ButtonCancel.onRelease();
	}
	else if(BackNormal._visible){
		if(BackNormal.BackListTrack._visible){
			BackNormal.ButtonTrack.onRollOver();
			BackNormal.BackListTrack._visible=false;
		}
	}
	else if(BackAdvance._visible){
		if(BackAdvance.BackListArtist._visible){
			BackAdvance.BackListArtist._visible=false;
			BackAdvance.ButtonArtist.onRollOver();
		}
		else if(BackAdvance.BackListRating._visible){
			BackAdvance.BackListRating._visible=false;
			BackAdvance.ButtonRating.onRollOver();
		}
		else if(BackAdvance.BackListMood._visible){
			BackAdvance.BackListMood._visible=false;
			BackAdvance.ButtonMood.onRollOver();
		}
		else if(BackAdvance.BackListTrack._visible){
			BackAdvance.BackListTrack._visible=false;
			BackAdvance.ButtonTrack.onRollOver();
		}
		else if(BackAdvance.BackListGenre._visible){
			BackAdvance.BackListGenre._visible=false;
			BackAdvance.ButtonGenre.onRollOver();
		}
		else if(BackAdvance.BackListDance._visible){
			BackAdvance.BackListDance._visible=false;
			BackAdvance.ButtonDance.onRollOver();
		}
	}
	
}

function MoveAlbum(Move){
	if(Move=="Right"){
		if(MainLevel==2){
			var Sp=resultSearchArrow[RecordIndexArrow].split(":");
			var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
			var Index=GetNumber(StoreNameSelected)
			if(DisplayAlbumLong=="true"){
				Index+=eval(NameAlbum).rows;
			}else{
				Index+=1;
			}
			if(Index<=Count){
				eval(NameAlbum+".Button"+Index).onRollOver();
			}
			else{
				ArrowBar.ButtonArrowRight.onRelease();
				eval(NameAlbum+".Button"+0).onRollOver();
			}
		}
		else if(MainLevel==3){
			var Sp=resultSearchVol[RecordIndexVol].split(":");
			var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
			var Index=GetNumber(StoreNameSelected)
			if(DisplayAlbumLong=="true"){
				Index+=eval(NameAlbum).rows;
			}else{
				Index+=1;
			}
			if(Index<=Count){
				eval(NameAlbum+".Button"+Index).onRollOver();
			}
			else{
				VolBar.ButtonArrowRight.onRelease();
				eval(NameAlbum+".Button"+0).onRollOver();
			}
		}
	}
	else if(Move=="Left"){
		if(MainLevel==2){
				var Index=GetNumber(StoreNameSelected);
				if(DisplayAlbumLong=="true"){
					Index-=eval(NameAlbum).rows;
				}else{
					Index-=1;
				}
				if(Index>=0){
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					ArrowBar.ButtonArrowLeft.onRelease();
					var Sp=resultSearchArrow[RecordIndexArrow].split(":");
					var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
					eval(NameAlbum+".Button"+Count).onRollOver();
				}
		}
		else if(MainLevel==3){
				var Index=GetNumber(StoreNameSelected);
				if(DisplayAlbumLong=="true"){
					Index-=eval(NameAlbum).rows;
				}else{
					Index-=1;
				}
				if(Index>=0){
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					VolBar.ButtonArrowLeft.onRelease();
					var Sp=resultSearchVol[RecordIndexVol].split(":");
					var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
					eval(NameAlbum+".Button"+Count).onRollOver();
				}
		}
	}
	else if(Move=="Down"){
		if(DisplayAlbumLong=="true"){
			if(MainLevel==2){
				var Sp=resultSearchArrow[RecordIndexArrow].split(":");
				var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
				var Index=GetNumber(StoreNameSelected)
				Index+=1;
				if(Index<=Count){
					eval(NameAlbum+".Button"+Index).onRollOver();
				}	
				else{
					ArrowBar.ButtonArrowRight.onRelease();
					eval(NameAlbum+".Button"+0).onRollOver();
				}
			}
			else if(MainLevel==3){
				var Sp=resultSearchVol[RecordIndexVol].split(":");
				var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
				var Index=GetNumber(StoreNameSelected)
				Index+=1;
				if(Index<=Count){
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					VolBar.ButtonArrowRight.onRelease();
					eval(NameAlbum+".Button"+0).onRollOver();
				}
			}
		}
		else{
			if(NumMovie==nSmalls)InVal=ColSmall;
			else if(NumMovie==nLarges)InVal=ColLarge;
			else InVal=ColMedium;	
			var IndX=GetNumber(StoreNameSelected)+Inval;
			if(eval(NameAlbum+".Movie"+IndX)._visible){
				//SelectButton(NameAlbum+".Movie"+IndX);
				eval(NameAlbum+".Button"+IndX).onRollOver();
			}
			else{
				var IndX=GetNumber(StoreNameSelected)%Inval;
				//SelectButton(NameAlbum+".Movie"+IndX);
				eval(NameAlbum+".Button"+IndX).onRollOver();
			}
		}
	}
	else if(Move=="Up"){
		if(DisplayAlbumLong=="true"){
			if(MainLevel==2){
				var Index=GetNumber(StoreNameSelected);
				Index-=1;
				if(Index>=0){
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					ArrowBar.Button0.onRollOver();
				}
			}
			else if(MainLevel==3){
				var Index=GetNumber(StoreNameSelected);
				Index-=1;
				if(Index>=0){
				eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					VolBar.Button0.onRollOver();
				}
			}	
		}
		else{
			if(NumMovie==nSmalls)InVal=ColSmall;
			else if(NumMovie==nLarges)InVal=ColLarge;
			else InVal=ColMedium;	
			if(GetNumber(StoreNameSelected)>InVal-1){
				var IndX=GetNumber(StoreNameSelected)-Inval;
				if(eval(NameAlbum+".Movie"+IndX)._visible){
					//SelectButton(NameAlbum+".Movie"+IndX);	
					eval(NameAlbum+".Button"+IndX).onRollOver();
				}
			}
			else{
				if(MainLevel==2){
					ArrowBar.Button0.onRollOver();
				}
				else if(MainLevel==3){
					VolBar.Button0.onRollOver();
				}
			}
		}
	}
}


//...........................FUNCTION PRESS ANY KEY................................\
var WaitKeyPress=0;
var CombinNum="";
var OpenKey="False";
var NumIndexKey=0;
var IntervalValue=500;
function CoverKeyCodeToNum(Num){
	if(Num>=96 && Num <=105){
		return Num%96;
	}
	else{
		return Num%48;
	}
}
function OpenNumKey(){
	var IntervalKey1=setInterval(function(){
	if(OpenKey=="True"){
		WaitKeyPress+=1;
		if(WaitKeyPress==3){
			WaitKeyPress=0;
			OpenKey="False";
			NumIndexKey=parseInt(CombinNum,10)-1;
			if(MainLevel==2){
				if(NumIndexKey>=0 && NumIndexKey<resultSearchArtistName.length){
					if(ChangeLan=="Uni"){
						if(BackNormal._visible)BackNormal._visible=false;
						if(BackAdvance._visible)BackAdvance._visible=false;
						fscommand("ShowTextSearch","no");		
					}
					var Index = NumIndexKey;
					StoreArtistName = resultSearchArtistName[Index].Artist;
					StoreUniArtistName = resultSearchArtistName[Index].uniArtist;
					RecordIdArtistName=resultSearchArtistName[Index].id;
					if(RecordIndexTrack==1){
						IndexMode=1;
					}else if(RecordIndexTrack==2){
						IndexMode=0;
					}else {
						IndexMode=3;
					}
					if(SelectMode=="Artist"){
						if(DisplayArtistMode==0){
							fscommand("GetArtistAlbum",RecordIdArtistName+"~"+IndexMode);
						}else{
							fscommand("GetArtistTrack",RecordIdArtistName+"~"+IndexMode);
						}
					}else{
						fscommand("GetDirectorAlbum",RecordIdArtistName+"~"+IndexMode);
					}
				}
			}
			else if(MainLevel==3){
				if(NumIndexKey>=0 && NumIndexKey<resultSearchArtistAlbum.length){
					if(ChangeLan=="Uni"){
						if(BackNormal._visible)BackNormal._visible=false;
						if(BackAdvance._visible)BackAdvance._visible=false;
						fscommand("ShowTextSearch","no");		
					}
					MainLevel=4;
					RecordIndexArtistAlbum = NumIndexKey;
					if(ReturnIndexVol(RecordIndexArtistAlbum+1)){
						StoreAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
						StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
						//FirstDisplayAlbum(resultSearchArtistAlbum.length);
						fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
					}
					eval(TrackName).Button0.onRollOver();
				}
			}
			else if(MainLevel==4){
				if(NumIndexKey>=0 && NumIndexKey<eval("Num"+TrackObj)){
					IndexTrack=NumIndexKey;
					if(SelectMode=="Song"){
						if (PlayMode == "Play One Track") {
							fscommand("PlayTrack",resultSearch[IndexTrack].trackID+"~"+resultSearch[IndexTrack].NoTrack+"~"+resultSearch[IndexTrack].AlbumID+"~"+resultSearch[IndexTrack].walMart_Ava);
							var tt=resultSearch[IndexTrack].trackTitle;
							var tu=resultSearch[IndexTrack].unicodeTrackTitle;
							var art=resultSearch[IndexTrack].Artist;
							var artu=resultSearch[IndexTrack].unicodeArtist;
							var Album=resultSearch[IndexTrack].Album;
							var Albumu=resultSearch[IndexTrack].unicodeAlbum;
				
							var Md=resultSearch[IndexTrack].Mood;
							var UniMd=resultSearch[IndexTrack].unicodeMood;
							var Dan=resultSearch[IndexTrack].danceStyle;
							var UniDan=resultSearch[IndexTrack].unicodeDanceStyle;
							var Rat=resultSearch[IndexTrack].Rating;
							var Gen=resultSearch[IndexTrack].Genre;
							var UniGen=resultSearch[IndexTrack].unicodeGenre;
							var Tid=resultSearch[IndexTrack].trackID;
							var Pic=resultSearch[IndexTrack].StringPath;
							var Lan1=LanName;
							var ComName1=resultSearch[IndexTrack].ComName;
							var LanPath1=resultSearch[IndexTrack].AlbumID;
							var LanTrack=resultSearch[IndexTrack].LanTrack;
							var YearTrack=resultSearch[IndexTrack].YearTrack;
							fscommand("SendPathPic",resultSearch[IndexTrack].PathPic);
							var Ava=resultSearch[IndexTrack].Ava;
							var wal_Ava=resultSearch[IndexTrack].walMart_Ava;
							var ShoppingID=resultSearch[IndexTrack].ShoppingID;
							if(resultSearch[IndexTrack].idLan==1){
								fscommand("SaveInPlayer",tt+StOr+tu+StPer+Album+StOr+Albumu+StPer+art+StOr+artu+StWave+EngFont+StOr+KhmerFont+StWave+EngSize+StOr+KhmerSize+StWave+"bTcMerog³"+StWave+"GkñcMerog"+StWave+"cMNg;eCIgGal;bum³");
								fscommand("SaveInPlayList",Album+"%%"+Albumu+"%%"+tt+"%%"+tu+"%%"+art+"%%"+artu+"%%"+Md+"%%"+UniMd+"%%"+Dan+"%%"+UniDan+"%%"+Rat+"%%"+Gen+"%%"+UniGen+"%%"+ModeTrack+"%%"+Tid+"%%"+Pic+"%%"+"Khmer"+"%%"+ComName1+"%%"+LanPath1+"%%"+LanTrack+"%%"+YearTrack+"%%"+Ava+"%%"+wal_Ava+"%%"+ShoppingID);
							}
							else{
								fscommand("add here");
								fscommand("SaveInPlayer",tt+StOr+tu+StPer+Album+StOr+Albumu+StPer+art+StOr+artu+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle+StWave+UniPro+StWave+UniAlbumTitle);
								fscommand("SaveInPlayList",Album+"%%"+Albumu+"%%"+tt+"%%"+tu+"%%"+art+"%%"+artu+"%%"+Md+"%%"+UniMd+"%%"+Dan+"%%"+UniDan+"%%"+Rat+"%%"+Gen+"%%"+UniGen+"%%"+ModeTrack+"%%"+Tid+"%%"+Pic+"%%"+Lan1+"%%"+ComName1+"%%"+LanPath1+"%%"+LanTrack+"%%"+YearTrack+"%%"+Ava+"%%"+wal_Ava+"%%"+ShoppingID);
							}
						} else {
							FuncPlayAll(IndexTrack);
						}	
					}
					else{
						
						if (PlayModeAlbum == "One") {
							FuncPlayAllAlbum(IndexTrack,true);
						} else {
							FuncPlayAllAlbum(IndexTrack);
						}
					}
					//..........
					var k=IndexTrack%nTrack;
					var k1=eval("IndexShow"+TrackObj)+k;
					if(IndexTrack==k1){
						eval(TrackName+".Button"+k).onRollOver();
					}
				}
			}
			CombinNum="";
			clearInterval(IntervalKey1);
		}
	}
	
					 },300)
}

//------------------------------------------------------------------------------------------------------
function combine_key1(){
	if (send_event("normal&&&function||combine_key1||2", false)) {
		return;
	}
	fscommand("KeyPressed","");
}
//------------------------------------------------------------------------------------------------------
function combine_key2(KeyCode){
	KeyCode = int(KeyCode);
	if (send_event("normal&&&function||combine_key2|~|" + KeyCode + "||2", false)) {
		return;
	}
	if(KeyCode == KeySlide){//~
		if(SlideShowValue == "Yes") {
			DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (OFF)", SHTT, -(96/2) + 5, 20, true);
			SlideShowValue = "No";
		} else {
			DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (ON)", SHTT, -(96/2) + 5, 20, true);
			SlideShowValue = "Yes";
		}
		fscommand("SetSlideShowOnOff", SlideShowValue);
	} else if(KeyCode == 49 || KeyCode == 97) {//1
		var AlbumCover1 = AlbumCover;
		if(AlbumCover1 == "Yes") {
			AlbumCover1 = "No";
		} else {
			AlbumCover1 = "Yes";
		}
		fscommand("CtrlPlus", "1~" + AlbumCover1);
	} else if(KeyCode == KeyMin) {
		HideMenu();
//		fscommand("Minimize");
	}else if(KeyCode == 50 || KeyCode == 98) {//2
		var NumCover1 = NumCover;
		if(NumCover1 == "Yes"){
			NumCover1 = "No";
		} else {
			NumCover1 = "Yes";
		}
		fscommand("CtrlPlus", "2~" + NumCover1);
	} else if(KeyCode == 51 || KeyCode == 99) {//3
		var PlusCover1 = PlusCover;
		if(PlusCover1 == "Yes"){
			PlusCover1 = "No";
		} else {
			PlusCover1 = "Yes";
		}
		fscommand("CtrlPlus", "3~" + PlusCover1);
	} else if(KeyCode == 71) {//G
		fscommand("CtrlPlus", "G~0");
	}/* else if(KeyCode == 87) {//w
		fscommand("CtrlPlus","W~0");
	}*/ else if(KeyCode == 220) {//.....|\
		switch(NumMovie){
			case nLarge :
				temp = "Large";
				break;
			case nMedium :
				temp = "Medium";
				break;
			case nSmall :
				temp = "Small";
				break;
			//...............
			case nLarges :
				temp = "Large";
				break;
			case nMediums :
				temp = "Medium";
				break;
			case nSmalls :
				temp = "Small";
				break;
		}
		fscommand("ChangeDisplayList", temp);
	} else if(KeyCode == 74 && eval(NameAlbum)._visible) {//J
		var temp = "Large";
		switch(NumMovie){
			case nLarge :
				temp = "Medium";
				break;
			case nMedium :
				temp = "Small";
				break;
			case nSmall :
				temp = "Large";
				break;
			//.............						
			case nLarges :
				temp = "Medium";
				break;
			case nMediums :
				temp = "Small";
				break;
			case nSmalls :
				temp = "Large";
				break;
		}
		fscommand("CtrlPlus", "J~" + temp);
	} else if(KeyCode == 75) {//K
		fscommand("CtrlPlus", "K~true");
	} else if(KeyCode==keyHideMouse) {
		if(HideMouse == "true") {
			Mouse.show();
			HideMouse = "false";
		} else {
			Mouse.hide();
			HideMouse = "true";
		}
		fscommand("setHideMouse", HideMouse);
	} else if(KeyCode == 85) {
		fscommand("FullScreenPlayer");//U
	} else if(KeyCode == 83) {
		TopBar.ButtonS.onRollOver();//S
	} else if(KeyCode == 80) {
		TopBar.ButtonP.onRollOver();//P
		TopBar.ButtonP.onRelease();//P
	} else if(KeyCode == 77) {
		TopBar.ButtonM.onRollOver()
		TopBar.ButtonM.onRelease();//M
	} else if(KeyCode == KeyLanguage) {
		TopBar.ButtonC.onRollOver();//y
		TopBar.ButtonC.onRelease();//y
	} else if(KeyCode == 79) {
		TopBar.ButtonO.onRelease();//O
		TopBar.ButtonO.onRelease();//O
	} else if(KeyCode == 69) {
		TopBar.ButtonL.onRollOver()
		TopBar.ButtonL.onRelease();//E
	} else if(KeyCode == 68) {
		TopBar.ButtonX.onRollOver()
		TopBar.ButtonX.onRelease();//E
	} else if(KeyCode == KeyPlayer) {
		eval(TrackName).ShowPlayer.Button.onRelease();//L
	} else if(KeyCode == 82) {
		eval(TrackName).ShowRip.Button.onRollOver();//R
		eval(TrackName).ShowRip.Button.onRelease();
	} else if(KeyCode == 70) {
		Menu.Scan.Button.onRollOver();//C
		Menu.Scan.Button.onRelease();//C
	} else if(KeyCode == 84) {
		fscommand("Visualization");
	}
}