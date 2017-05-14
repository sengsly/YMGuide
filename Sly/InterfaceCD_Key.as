//.............................................................
var LastAlbumSelected = "";
Main_Listener = new Object();
Main_Listener.onMouseDown = function () { 
	_global.boolMouseDown = true;
	fscommand("KeyPressed","MouseDown");
};
Mouse.removeListener(Main_Listener);
Mouse.addListener(Main_Listener);
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
function FirstDisplayAlbumForKey(n,pressIndex){
		if (send_event("normal&&&function||FirstDisplayAlbumForKey|~|" + n + "|~|" + pressIndex + "||0", false)) {
			return;
		}
		n = int(n);
		RecordIndexArtistAlbum = int(pressIndex);
		FirstDisplay("Album",n,nAlbum);
		var Level=ReturnLevel(RecordIndexArtistAlbum+1 , nAlbum);
		IndexShowAlbum=(Level-1) * nAlbum;
		CountAlbum=ReturnCount(Level,TotalLevelIndexAlbum,n,nAlbum)
		LevelIndexAlbum=Level;
		StoreAlbumByIndex=IndexShowAlbum;
		StoreAlbumByCount=CountAlbum;
		if(ConfirmIdAlbum(StoreAlbumByIndex,StoreAlbumByCount)){
			fscommand("GetAlbumByIndex",StoreAlbumByIndex+"~"+StoreAlbumByCount+"~"+"No");
		}
		else{
			StoreAlbum=resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
			StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
			fscommand("GetArtistTrackInfo", resultSearchArtistAlbum[RecordIndexArtistAlbum].id+"~"+LanName);
			ShowMovieBar("AlbumBar",IndexShowAlbum,CountAlbum,nAlbum,resultSearchArtistAlbum);
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
					GenreBar._visible=false;
					RecordIndexArtistName = NumIndexKey;
					var Index=RecordIndexArtistName;
					StoreArtistName = resultSearchArtistName[Index].Artist;
					StoreUniArtistName = resultSearchArtistName[Index].uniArtist;
					RecordIdArtistName=resultSearchArtistName[Index].id;
					fscommand("GetArtistAlbum",RecordIdArtistName+"~"+SortedValue+"~"+AvaValue);
					FirstDisplayArtistName(resultSearchArtistName.length);
				}
			}
			else if(MainLevel==3 && eval(NameAlbum)._visible){
				if(NumIndexKey>=0 && NumIndexKey<resultSearchArtistAlbum.length){
					FirstDisplayAlbumForKey(resultSearchArtistAlbum.length,NumIndexKey);
					//TopBar.ButtonM.onRollOver();
					fscommand("FirstSelectTrack");
					CharBar._visible=false;
				}
			}
			else if(MainLevel==4){
				//RecordIndexArtistAlbum = NumIndexKey;
				//StoreAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].Artist;
				//StoreUniAlbum = resultSearchArtistAlbum[RecordIndexArtistAlbum].uniArtist;
				//FirstDisplayAlbum(resultSearchArtistAlbum.length);
				if(NumIndexKey>=0 && NumIndexKey<eval("Num"+TrackObj)){
					/* == changed sith ====	
					if(eval("LevelIndex"+TrackObj)==1 && NumIndexKey>nTrack-1)eval(TrackName).ButtonRight.onRelease();
					if(eval("LevelIndex"+TrackObj)==2 && NumIndexKey<=nTrack-1)eval(TrackName).ButtonRight.onRelease();
					*/
					//================ sith changed ========================	
					if (NumIndexKey+1 > eval("IndexShow"+TrackObj)+nTrack)
					{
						while( NumIndexKey+1 > eval("IndexShow"+TrackObj)+nTrack )
						{
							 eval(TrackName).ButtonRight.onRelease();
						}
					}elseif  ( NumIndexKey < eval("IndexShow"+TrackObj))
					{
						while( NumIndexKey < eval("IndexShow"+TrackObj))
						{
							 eval(TrackName).ButtonRight.onRelease();
						}
					}
					//====================== change 8-05-06 ====================

					eval(TrackName + ".Button"+(NumIndexKey%nTrack)).onRelease();
					eval(TrackName + ".Button"+(NumIndexKey%nTrack)).onRollOver();
				}
			}
			CombinNum="";
			clearInterval(IntervalKey1);
		}
	}
	
					 },300)
}
myListener = new Object();
myListener.onKeyDown = function () {
	_global.boolMouseDown = true;
	CtrlKey=Key.isDown(17);			//test whether the Ctrl key is down
	if((selection.getFocus()==null || String(selection.getFocus())=="_level0.GetFocus" ) ){
		//if(!UpdateDB._visible && !RestoreDB._visible && !CopyMusic._visible && !BackUpDB._visible && !PurchaseCDMode._visible){
	    if(!UpdateDB._visible && !RestoreDB._visible && !InputBox._visible && !CopyMusic._visible && !BackUpDB._visible && !PurchaseCDMode._visible && !AddNewScreens._visible && !WarningUpdate._visible){		  
			PressKey(Key.getCode());
		}
		else{
			fscommand("KeyPressed","");
			if(Key.getCode()==39){
				if(WarningUpdate._visible){
					StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel",StoreNameSelected,"Right")
				}else if (UpdateDB._visible){
					if (updateDB.txtCancel.text == "No"){
						StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel",StoreNameSelected,"Right")
					}
				}
				else if (RestoreDB._visible){
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Right")
				}
				else if (InputBox._visible){
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel",StoreNameSelected,"Right")
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
					if (updateDB.txtCancel.text == "No"){
						StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel",StoreNameSelected,"Left")
					}
				}
				else if (RestoreDB._visible){
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Left")
				}
				else if (InputBox._visible){
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel",StoreNameSelected,"Left")
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
				else if (InputBox._visible){
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel",StoreNameSelected,"Left")
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
				else if (InputBox._visible){
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel",StoreNameSelected,"Right")
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
			}
			else if(Key.getCode()==13){
				PressKey(Key.getCode());
			}	
		}
	}
	else{
		if(Key.getCode()==13){
			if(AddTrackBox.InputTrackBox._visible ){
					if(Selection.getFocus()=="_level0.AddTrackBox.InputTrackBox"){
						AddTrackBox.ButtonOk.onRelease();
						return;
					}
				}
				else{
					selection.setFocus(GetFocus);
				}	
		}
	}
	//HideMouse=tmpHideMouse;
}
myListener.onKeyUp=function(){
	Comb="false";
}
Key.removeListener(myListener);
Key.addListener(myListener);
var SelectLevel=1;
var Comb="false";
var CtrlKey=false;
function combind_key(){
	if (send_event("normal&&&function||combind_key||0", false)) {
		return;
	}
	fscommand("KeyPressed","");
}

function PressKey(KeyCode){	
	KeyCode = int(KeyCode);
	if(CtrlKey){		
		combind_key();		
	}else{
		if(MainLevel==1){			
			if(KeyCode==33 ||KeyCode==34){
			//	control_mini_player("KeyPressed",KeyCode,"true");
//			} else if (KeyCode == 187 || KeyCode == 189 || KeyCode == 77){		//cause mute in letter
			} else if (KeyCode == 187 || KeyCode == 189){
//				control_syncronize("volume","KeyPressed",KeyCode);
			} else {
				fscommand("KeyPressed","");
			}
		} else {
			if(DisplayAlbum=="Browse" ){
				if(MainLevel==2 && BrowseBy=="Genre"){
					if(KeyCode == 33 ||KeyCode == 34){
					//	control_mini_player("KeyPressed",KeyCode,"true");
//					} else if (KeyCode == 187 || KeyCode == 189 || KeyCode == 77){		//cause mute during browse
					} else if (KeyCode == 187 || KeyCode == 189){
//						control_syncronize("volume","KeyPressed",KeyCode);
					}else{
						fscommand("KeyPressed","");
					}
				}
				else if(MainLevel==3 && BrowseBy=="Production"){
					if(KeyCode==33 || KeyCode==34){
//						control_mini_player("KeyPressed",KeyCode,"true");
					} else if (KeyCode == 187 || KeyCode==189 ){//|| KeyCode == 77){
//						control_syncronize("volume","KeyPressed",KeyCode);
					}else{
						fscommand("KeyPressed","");
					}
				}
				else if(MainLevel==3 && BrowseBy=="Rating"){
					if(KeyCode==33 ||KeyCode==34){
//						control_mini_player("KeyPressed",KeyCode,"true");
					} else if (KeyCode == 187 || KeyCode == 189 ){//|| KeyCode == 77){
//						control_syncronize("volume","KeyPressed",KeyCode);
					}else{
						fscommand("KeyPressed","");
					}
				}else{
					if (KeyCode == 187 || KeyCode == 189 ){//|| KeyCode == 77){
//						control_syncronize("volume","KeyPressed",KeyCode);
					}else if (KeyCode==33 or KeyCode==34){//don't process this key
					} else {
//						control_mini_player("KeyPressed",KeyCode,"true"); //test
					}
				}
			}else{
				if (KeyCode == 187 || KeyCode == 189 ){//|| KeyCode == 77){
//					control_syncronize("volume","KeyPressed",KeyCode);
				}else if (KeyCode==33 or KeyCode==34){//don't process this key
				} else {
					//control_mini_player("KeyPressed",KeyCode,"true"); //test
				}
			}
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
		var objectEnter="";
		CtrlKey=false;
		if(MainLevel==1 && SelectLevel==3){
			if(StoreNameSelected=="BackLetter.BackAll.MovieAll"){
				objectEnter=eval(Replace(StoreNameSelected,"Movie","Button"));
				if(objectEnter.enabled){
					objectEnter.onRelease();	
				}
			}
			else{
				var Index1=parseInt(RecordLetterMove.charCodeAt(0),10);
				if(Index1==35)Index1=64;
				Index1=Index1-64;
				eval("_root.BackLetter.Letter"+(Index1)+".Button").onRelease();
			}
		}else if(Mainlevel==1 && SelectLevel==4){
			mainletter_mc.MoveObject(keyCode);
		}else{
			objectEnter=eval(Replace(StoreNameSelected,"Movie","Button"))
			if(objectEnter.enabled){
				eval(Replace(StoreNameSelected,"Movie","Button")).onRelease();
			}
		}
	}
	else if(KeyCode==32){
		if(MainLevel==4){
			if (eval(TrackName).BackStars._visible){
				if(SelectLevel==3){
					eval(TrackName + ".Button"+GetNumber(StoreNameSelected)).onRollOut();
					eval(TrackName).BackStars.Button1.onRollOver();
				}
				else if(SelectLevel==9){
					if(StoreNameSelected==TrackName + ".BackStars.Movie5"){
						eval(TrackName).BackStars.Back.onRollOut();
					}
					if(StoreNameSelected==TrackName + ".PlusIcon.Movie"){
						eval(TrackName).PlusIcon.Button.onRollOut();
					}				
					if(StoreNameSelected==TrackName + ".ScanAlbum.Movie"){
						eval(TrackName).ScanAlbum.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".PathChapter.Movie"){
						eval(TrackName).PathChapter.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".PlayTrailer.Movie"){
						eval(TrackName).PlayTrailer.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".BrowseTrailer.Movie"){
						eval(TrackName).PlayTrailer.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".audiochannel.Movie"){
						eval(TrackName).audiochannel.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".AddToPlay.Movie"){
						eval(TrackName).AddToPlay.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					if(StoreNameSelected==TrackName + ".chkOffset.Movie"){
						eval(TrackName).chkOffset.Movie.Button.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
					else{
						//temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".RIPCD.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie";
						temp=TrackName + ".BackStars.Movie1,"+ TrackName + ".BackStars.Movie2,"+TrackName+".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".RIPCD.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie," + TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," +  TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie," + TrackName + ".chkOffset.Movie," + TrackName + ".CoverArtType.Movie," + TrackName + ".fileType.Movie," + TrackName + ".PlayTrailer.Movie";
						StaticMove(temp,StoreNameSelected,"Right");
					}
				}
			}else{
				if (send_event("normal&&&function||PressKey|~|" + KeyCode + "||0", false)) {
					return;
				}
				fscommand("popup",true);
				/*if (TrackShow._visible == false and tmpTrackInfo != ""){				
					fscommand("displayPopupTrackInfo",true);
				}*/
			}
		}else{
			if (send_event("normal&&&function||PressKey|~|" + KeyCode + "||0", false)) {
				return;
			}
			fscommand("popup",true);
			/*if (TrackShow._visible == false and tmpTrackInfo != ""){				
				fscommand("displayPopupTrackInfo",true);
			}*/
		}		
	}
	else if(KeyCode==17){
		CtrlKey=true;
	}
	else{
		if(CtrlKey){
			combind_key2(KeyCode);
		}
		else{			
			if((KeyCode>=65 && KeyCode<=90 )){
				if(MainLevel==1 && !SortMaster._visible){
					if(KeyCode==51){
						eval("BackLetter.Letter0.Button").onRelease();
					}
					else{
						eval("BackLetter.Letter"+(KeyCode-64)+".Button").onRelease();
					}
				}
				else if(MainLevel==2 && BrowseBy=="Genre" && DisplayAlbum=="Browse"){
					CharBar._visible=false;
					eval("BackLetter.Letter"+(KeyCode-64)+".Button").onRelease();
				}
				else if(MainLevel==3 && BrowseBy=="Rating" && DisplayAlbum=="Browse") {
					CharBar._visible=false;
					eval("BackLetter.Letter"+(KeyCode-64)+".Button").onRelease();
				}
				else if(MainLevel==3 && BrowseBy=="Production" && DisplayAlbum=="Browse") {
					CharBar._visible=false;
//					eval("BackLetter.Letter"+(KeyCode-64)+".Button").onRelease();
				}
				else if(MainLevel==4){

					if(KeyCode==65){
						//PlayAll.Button.onRollOver();	
						//PlayAll.Button.onRelease();	
					}
					else if(KeyCode==73){
						//AlbumInfo.Button.onRollOver();
						//AlbumInfo.Button.onRelease();
					}
					else if(KeyCode==71){
						Cart.Button.onRollOver();
						Cart.Button.onRelease();
					}
				}
			} else if((KeyCode>=48 && KeyCode<=57 )||(KeyCode>=96 && KeyCode<=105)){
				if(Comb=="true" && KeyCode==51){
					eval("BackLetter.Letter0.Button").onRelease();
				}
				else{
					if(OpenKey=="False")OpenNumKey();
					OpenKey="True";
					CombinNum+=CoverKeyCodeToNum(KeyCode);
				}
			}
			//else if(KeyCode==16){
				//Comb="true";
			//}
			else if(KeyCode==8){
				//TopBar.ButtonB.onRollOver();
				TopBar.ButtonB.onRelease();
				//Seng 2006-11.27 Select Last Album was selected
				SelectButton(LastAlbumSelected);
			}
			else if(KeyCode==KeyPreAlbum){
				if(MainLevel==2){
					if(ArrowBar.ButtonArrowLeft._visible){
						ArrowBar.ButtonArrowLeft.onRollOver();
						ArrowBar.ButtonArrowLeft.onRelease();
					}
				}
				else if(MainLevel==3){
					if(VolBar.ButtonArrowLeft._visible){
						VolBar.ButtonArrowLeft.onRollOver();
						VolBar.ButtonArrowLeft.onRelease();
					}
				}
				else if(MainLevel==4){
					PreAlbum.Button.onRollOver();
					PreAlbum.Button.onRelease();
				}
			}
			else if(KeyCode==KeyNextAlbum){
				if(MainLevel==2){
					if(ArrowBar.ButtonArrowRight._visible){
						ArrowBar.ButtonArrowRight.onRollOver();
						ArrowBar.ButtonArrowRight.onRelease();
					}
				}
				if(MainLevel==3){
					if(VolBar.ButtonArrowRight._visible){
						VolBar.ButtonArrowRight.onRollOver();
						VolBar.ButtonArrowRight.onRelease();
					}
				}
				else if(MainLevel==4){
					NextAlbum.Button.onRollOver();
					NextAlbum.Button.onRelease();
				}
			}
			else if(keyCode == 219){				
				if(MainLevel==2){
					if(ArrowBar.ButtonLeft._visible){
						ArrowBar.ButtonLeft.onRollOver();
						ArrowBar.ButtonLeft.onRelease();
					}
				}
				else if(MainLevel==3){
					if(VolBar.ButtonLeft._visible){
						VolBar.ButtonLeft.onRollOver();
						VolBar.ButtonLeft.onRelease();
					}
				}
				else if(MainLevel==4){
					if (eval(TrackName).ButtonRight._visible == true){
						ClickLeftTrackTittle(0);
						//eval(TrackName).ButtonRight.onRollOver();
					}
				}
			}
			else if(keyCode == 221){
				if(MainLevel==2){
					if(ArrowBar.ButtonRight._visible){
						ArrowBar.ButtonRight.onRollOver();
						ArrowBar.ButtonRight.onRelease();
					}
				}
				else if(MainLevel==3){
					if(VolBar.ButtonRight._visible){
						VolBar.ButtonRight.onRollOver();
						VolBar.ButtonRight.onRelease();
					}
				}
				else if(MainLevel==4){
					if (eval(TrackName).ButtonRight._visible == true){
						ClickLeftTrackTittle(1);
						//eval(TrackName).ButtonRight.onRelease();
						//eval(TrackName).ButtonRight.onRollOver();
					}
				}
			}
			
		}
	}
	///..................
	function GoRight(){
		fscommand("mouse_off_screen",true);
		var temp1="";
		var temp="";
		if(SelectLevel==5){
				if(MenuLevel==1){
					if(MenuBrowse._visible){
						Menu.BrowseBy.Button.onRollOver();
					}
					else if(MenuAva._visible){
						Menu.Ava.Button.onRollOver();
					}
					else if(MenuMISC._visible){
						Menu.MISC.Button.onRollOver();
					}
				}
				else if(MenuLevel==2){
					if(MenuFavAlbum._visible){
						MenuBrowse.FavAlbum.Button.onRollOver();
					}
					else if(MenuMyAlbum._visible){
						MenuBrowse.MyAlbum.Button.onRollOver();
					}
					else if(MenuFavArtist._visible){
						MenuBrowse.FavArtist.Button.onRollOver();
					}
					else if(MenuSorted1._visible){
						MenuBrowse.Production.Button.onRollOver();
					}
					else if(MenuSortedReleaseDate._visible){
						MenuBrowse.ReleaseDate.Button.onRollOver();
					}
					else if(MenuSorted._visible){
						MenuBrowse.Genre.Button.onRollOver();
					}
				}
			return;
		}
		if(SelectLevel==1){
//			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MoviePlayer,TopBar.MovieFull,TopBar.MovieRip,TopBar.MovieScan,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Right");
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MoviePlayer,TopBar.MovieFull,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Right");
			return;		
		}
		if(SortMaster._visible){
			if(SelectLevel==2){
				if(GenreBar._visible){
						for(var j=0;j<CountGenre;j++){

							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Right");
				}
			}
			else if(SelectLevel==3){
				SortMaster.BackAlbumPic.Button.onRollOver();
			}
			else if(SelectLevel==33){
				SortMaster.ButtonUp.Button.onRollOver();
			}
			else if(SelectLevel==4){
				if(StoreNameSelected=="SortMaster.ButtonDesImg.Movie"){
					SortMaster.Button0.onRollOver();
				}
				else{
					temp="SortMaster.ButtonUp.Movie,SortMaster.ButtonDown.Movie,SortMaster.ButtonImg.Movie,SortMaster.ButtonDesImg.Movie";
					StaticMove(temp,StoreNameSelected,"Right");
				}
			}
			return;
		}
		if(MainLevel==1){
				if(SelectLevel==2){
					if(GenreBar._visible){
						var temp1="";
						var temp="";
						for(var j=0;j<CountGenre;j++){
							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Right");
					}
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="_level0.BackLetter.Letter26.Movie"){
						BackLetter.BackAll.ButtonAll.onRollOver();
					}
					else if(StoreNameSelected=="BackLetter.BackAll.MovieAll"){
						eval("_root.BackLetter.Letter"+0+".Button").onRollOver();	
					}
					else{
						var Index1=parseInt(RecordLetterMove.charCodeAt(0),10);
						if(Index1==35)Index1=64;
						else if(Index1==90)Index1=63;
						Index1=Index1-64;
						eval("_root.BackLetter.Letter"+(Index1+1)+".Button").onRollOver();
					}
				}
				else if(SelectLevel==4){
					mainLetter_mc.MoveObject(Key.getCode());
				}
		}
		else if(MainLevel==2){
				if(SelectLevel==2){
					if(CharBar._visible){
						MoveLeftRight("CharBar",StoreNameSelected,CountChar,"Right");
					}
					else if(GenreBar._visible){
						MoveLeftRight("GenreBar",StoreNameSelected,CountGenre,"Right");
					}
				}
				else if(SelectLevel==4){
					//StaticMove("ArrowBar.MovieLeft,ArrowBar.MovieRight",StoreNameSelected,"Right");
					for(var j=0;j<CountArrow;j++){
						temp+=temp1+"ArrowBar.Movie"+j;
						   temp1=",";
					}
					if(ArrowBar.ButtonLeft._visible)	temp="ArrowBar.MovieLeft,"+temp+",ArrowBar.MovieRight";
					if(ArrowBar.MovieArrowLeft._visible)temp="ArrowBar.MovieArrowLeft,"+temp+",ArrowBar.MovieArrowRight";
					StaticMove(temp,StoreNameSelected,"Right");
				}
				else if(SelectLevel==3){
					MoveAlbum("Right");
				}
		}
		else if(MainLevel==3){
				if(SelectLevel==2){
					if(ArtistNameBar._visible){
						MoveLeftRight("ArtistNameBar",StoreNameSelected,CountArtistName,"Right");
					}
					else if(CharBar._visible){
						MoveLeftRight("CharBar",StoreNameSelected,CountChar,"Right");
					}
					else if(GenreBar._visible){
						for(var j=0;j<CountGenre;j++){
							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Right");
					}
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
				else if(SelectLevel==3){
					MoveAlbum("Right");
				}
		}
		else if(MainLevel==4){
				if(substring(StoreNameSelected,0,"mini".length)=="mini"){
					LeftRightPlayer("Right");
				}
				else{
					if(SelectLevel==2){
						MoveLeftRight("AlbumBar",StoreNameSelected,CountAlbum,"Right");
					}
					else if(SelectLevel==3){
						if(StoreNameSelected==TrackName + ".Movie9" || StoreNameSelected==TrackName + ".Movie10"){
							vb="lostFocus";
							fscommand("LoadSwfMiniControl","_level0.previous_mc._mc");
						}else if(StoreNameSelected==TrackName + ".Movie11"){
							vb="lostFocus";
							fscommand("LoadSwfMiniControl","_level0.add_mc._mc");
						}else if(StoreNameSelected=="BackAlbumPic.Movie"){
							if(eval(TrackName)._visible){
								eval(TrackName).BackStars.Button1.onRollOver();
								//eval(TrackName).Button0.onRollOver();
							}
							else{
								BackAlbumInfo.BackStars.Button1.onRollOver();
							}
						}
						else if(StoreNameSelected==TrackName+".MovieLeft"){
							eval(TrackName).ButtonRight.onRollOver();
						}else if(StoreNameSelected==TrackName+".MovieRight"){
							eval("BackAlbumPic.Button").onRollOver();
						}else {
//							eval(TrackName).ButtonRight.onRollOver();
							if(StoreNameSelected==String(TrackName + ".MovieLeft")){
								eval(TrackName).ButtonLeft.onRollOver();
							}else {
								eval("BackAlbumPic.Button").onRollOver();
							}
							}
					
					}
					else if(SelectLevel==4){
						if(Save._visible){
							StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieEnd,Save.MovieNextChapter,Save.MovieTime,Save.MovieKey,Save.MovieOk,Save.MovieCancel",StoreNameSelected,"Right");	
						}else{
							StaticMove("PlayAll.Movie,SearchArtist.Movie,AlbumInfo.Movie,Cart.Movie,chkVisibleIcon.Movie,PreAlbum.Movie,NextAlbum.Movie",StoreNameSelected,"Right");
						}

					}
					else if(SelectLevel==9){
						if(StoreNameSelected==TrackName + ".PlayTrailer.Movie"){
							eval(TrackName).PlayTrailer.Button.onRollOut();
							BackAlbumPic.Button.onRollOver();
						}

						else{
							//temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".RIPCD.Movie," + TrackName + ".PlusIcon.Movie";
						temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".RIPCD.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie," + TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," +  TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie," + TrackName + ".chkOffset.Movie," +TrackName + ".CoverArtType.Movie," + TrackName + ".fileType.Movie," + TrackName + ".PlayTrailer.Movie" ;		
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
				}
		}
		

	}
	function GoLeft(){
		fscommand("mouse_off_screen",true);
		var temp1="";
		var temp="";
		if(SelectLevel==5){
				if(MenuLevel==0){
					if(MenuBrowse._visible){
						MenuBrowse.Genre.Button.onRollOver();
					}
					else if(MenuAva._visible){
						MenuAva.YesAva.Button.onRollOver();
					}
					else if(MenuMISC._visible){
						MenuMISC.UpdateDB.Button.onRollOver();
					}
				}
				else if(MenuLevel==1){
					if(MenuFavAlbum._visible && MenuFavAlbum.Genre.Button.enabled){
						MenuFavAlbum.Genre.Button.onRollOver();
					}
					else if(MenuMyAlbum._visible && MenuMyAlbum.Genre.Button.enabled){
						MenuMyAlbum.Genre.Button.onRollOver();
					}
					else if(MenuFavArtist._visible && MenuFavArtist.Genre.Button.enabled){
						MenuFavArtist.Genre.Button.onRollOver();
					}
					else if(MenuSorted1._visible && MenuSorted1.NameSorted.Button.enabled){
						MenuSorted1.NameSorted.Button.onRollOver();
					}
					else if(MenuSortedReleaseDate._visible && MenuSortedReleaseDate.NameSorted.Button.enabled){
						MenuSortedReleaseDate.NameSorted.Button.onRollOver();
					}
					else if(MenuSorted._visible && MenuSorted.NameSorted.Button.enabled){
						MenuSorted.NameSorted.Button.onRollOver();
					}
				}
				return;
		}
		if(SelectLevel==1){
//			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MoviePlayer,TopBar.MovieFull,TopBar.MovieRip,TopBar.MovieScan,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Left");
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MoviePlayer,TopBar.MovieFull,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Left");
			return;
		}
		if(SortMaster._visible){
			if(SelectLevel==2){
				if(GenreBar._visible){
						for(var j=0;j<CountGenre;j++){
							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Left");
				}
			}
			else if(SelectLevel==3){
				SortMaster.ButtonImg.Button.onRollOver();
			}
			else if(SelectLevel==33){
				SortMaster.Button0.onRollOver();
			}
			else if(SelectLevel==4){
				if(StoreNameSelected=="SortMaster.ButtonUp.Movie"){
					SortMaster.BackAlbumPic.Button.onRollOver();
				}
				else{
					temp="SortMaster.ButtonUp.Movie,SortMaster.ButtonDown.Movie,SortMaster.ButtonImg.Movie,SortMaster.ButtonDesImg.Movie";
					StaticMove(temp,StoreNameSelected,"Left");
				}
			}
			return;
		}
		if(MainLevel==1){
				if(SelectLevel==2){
					if(GenreBar._visible){
						var temp1="";
						var temp="";
						for(var j=0;j<CountGenre;j++){
							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Left");
					}
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="_level0.BackLetter.Letter0.Movie"){
						BackLetter.BackAll.ButtonAll.onRollOver();
					}
					else if(StoreNameSelected=="BackLetter.BackAll.MovieAll"){
						eval("_root.BackLetter.Letter"+26+".Button").onRollOver();	
					}
					else{
						var Index1=parseInt(RecordLetterMove.charCodeAt(0),10);
						if(Index1==35)Index1=91;
						Index1=Index1-64;
						eval("_root.BackLetter.Letter"+(Index1-1)+".Button").onRollOver();
					}
				}
				else if(SelectLevel==4){
					mainLetter_mc.MoveObject(Key.getCode());
				}
		}
		else if(MainLevel==2){
				if(SelectLevel==2){
					if(CharBar._visible){
						MoveLeftRight("CharBar",StoreNameSelected,CountChar,"Left");
					}
					else if(GenreBar._visible){
						MoveLeftRight("GenreBar",StoreNameSelected,CountGenre,"Left");
					}
				}
				else if(SelectLevel==4){
					//StaticMove("ArrowBar.MovieLeft,ArrowBar.MovieRight",StoreNameSelected,"Left");
					for(var j=0;j<CountArrow;j++){
						temp+=temp1+"ArrowBar.Movie"+j;
						temp1=",";
					}
					if(ArrowBar.ButtonLeft._visible)	temp="ArrowBar.MovieLeft,"+temp+",ArrowBar.MovieRight";
					if(ArrowBar.MovieArrowLeft._visible)temp="ArrowBar.MovieArrowLeft,"+temp+",ArrowBar.MovieArrowRight";
					StaticMove(temp,StoreNameSelected,"Left");
				}
				else if(SelectLevel==3){
					MoveAlbum("Left");
				}
		}
		else if(MainLevel==3){
				if(SelectLevel==2){
					if(ArtistNameBar._visible){
						MoveLeftRight("ArtistNameBar",StoreNameSelected,CountArtistName,"Left");
					}
					else if(CharBar._visible){
						MoveLeftRight("CharBar",StoreNameSelected,CountChar,"Left");
					}
					else if(GenreBar._visible){
						
						for(var j=0;j<CountGenre;j++){
							temp+=temp1+"GenreBar.Movie"+j;
						    temp1=",";
						}
						if(GenreBar.ButtonLeft._visible){
							temp="GenreBar.MovieLeft,"+temp+",GenreBar.MovieRight";
						}
						if(GenreBar.MovieOpt._visible)temp=temp+",GenreBar.MovieOpt";
						StaticMove(temp,StoreNameSelected,"Left");
					}
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
				else if(SelectLevel==3){
					MoveAlbum("Left");
				}
		}
		else if(MainLevel==4){
				if(substring(StoreNameSelected,0,"mini".length)=="mini"){
					LeftRightPlayer("Left");
		 		}
				else{
					if(SelectLevel==2){
						MoveLeftRight("AlbumBar",StoreNameSelected,CountAlbum,"Left");
					}
					else if(SelectLevel==3){
						if(StoreNameSelected==String(TrackName + ".MovieRight")){
							eval(TrackName).ButtonLeft.onRollOver();
						}
						else if(substring(StoreNameSelected,0,String(TrackName + ".Movie").length)==String(TrackName + ".Movie")){
							if(eval(TrackName)._visible){
								if(StoreNameSelected=="BackAlbumPic.Movie")eval(TrackName).Button0.onRollOver();
								else if(eval(TrackName).ButtonRight._visible){
									eval(TrackName + ".Button"+GetNumber(StoreNameSelected)).onRollOut();
	//								eval(TrackName).ButtonLeft.onRollOver();
	//								eval(TrackName).ButtonRight.onRelease();
									ClickLeftTrackTittle(1);
								}
							}
							else {
								BackAlbumInfo.BackStars.Button5.onRollOver();
							}
						}else if (StoreNameSelected == "BackAlbumPic.Movie" )
						{
							eval(TrackName+".Button0").onRollOver();
						}
					}
					else if(SelectLevel==4){
						if(Save._visible){
							StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieEnd,Save.MovieNextChapter,Save.MovieTime,Save.MovieKey,Save.MovieOk,Save.MovieCancel",StoreNameSelected,"Left");	
						}else{
							if(StoreNameSelected=="PlayAll.Movie") {
								if(eval(TrackName)._visible)eval(TrackName).Button0.onRollOver();
								else BackAlbumInfo.BackStars.Button5.onRollOver();
							}
							else StaticMove("PlayAll.Movie,SearchArtist.Movie,AlbumInfo.Movie,Cart.Movie,chkVisibleIcon.Movie,PreAlbum.Movie,NextAlbum.Movie",StoreNameSelected,"Left");
						}
					}
					else if(SelectLevel==9){
						if(StoreNameSelected==TrackName + ".BackStars.Movie1"){
							eval(TrackName).BackStars.Back.onRollOut();
						}
						else {
//							temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie";
							temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".RIPCD.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".PlusIcon.Movie," + TrackName + ".audiochannel.Movie," + TrackName + ".AddToPlay.Movie," +  TrackName + ".BrowseTrailer.Movie," +  TrackName + ".PathChapter.Movie," +  TrackName + ".ScanAlbum.Movie," + TrackName + ".chkOffset.Movie," + TrackName + ".CoverArtType.Movie," + TrackName + ".fileType.Movie," + TrackName + ".PlayTrailer.Movie" ;
							StaticMove(temp,StoreNameSelected,"Left");
						}
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
				}
		}
	}
	function GoUp(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
				if(MenuLevel==0){
				//	StaticMove("Menu.Ava.Movie,Menu.BrowseBy.Movie,Menu.RipCD.Movie,Menu.Scan.Movie,Menu.Player.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Left");
					StaticMove("Menu.Ava.Movie,Menu.BrowseBy.Movie,Menu.Player.Movie,Menu.Scan.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Left");
				}
				else if(MenuLevel==1){
					if(MenuAva._visible)StaticMove("MenuAva.YesAva.Movie,MenuAva.NotAva.Movie,MenuAva.AllAva.Movie",StoreNameSelected,"Left");
					else if(MenuBrowse._visible)StaticMove("MenuBrowse.Genre.Movie,MenuBrowse.Production.Movie,MenuBrowse.Alphabet.Movie,MenuBrowse.Rating.Movie,MenuBrowse.ReleaseDate.Movie,MenuBrowse.FavAlbum.Movie,MenuBrowse.FavArtist.Movie,MenuBrowse.MyAlbum.Movie",StoreNameSelected,"Left");
					else if(MenuMISC._visible)StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Left");
				}
				else { 
					if(MenuSorted._visible)StaticMove("MenuSorted.NameSorted.Movie,MenuSorted.DateSorted.Movie",StoreNameSelected,"Left");
					else if(MenuSorted1._visible)StaticMove("MenuSorted1.NameSorted.Movie,MenuSorted1.DateSorted.Movie",StoreNameSelected,"Left");
					else if(MenuSortedReleaseDate._visible)StaticMove("MenuSortedReleaseDate.NameSorted.Movie,MenuSortedReleaseDate.DateSorted.Movie",StoreNameSelected,"Left");
					else if(MenuFavAlbum._visible)StaticMove("MenuFavAlbum.Genre.Movie,MenuFavAlbum.Production.Movie,MenuFavAlbum.Rating.Movie,MenuFavAlbum.Rank.Movie",StoreNameSelected,"Left");
					else if(MenuMyAlbum._visible)StaticMove("MenuMyAlbum.Genre.Movie,MenuMyAlbum.Production.Movie,MenuMyAlbum.Rating.Movie,MenuMyAlbum.Rank.Movie",StoreNameSelected,"Left");
					else if(MenuFavArtist._visible)StaticMove("MenuFavArtist.Genre.Movie,MenuFavArtist.Production.Movie,MenuFavArtist.Rating.Movie",StoreNameSelected,"Left");
				}
				if(StoreNameSelected=="Menu.Exit.Movie"){
					Menu._visible=false;
					MenuAva._visible=false;
					MenuBrowse._visible=false;
					MenuMISC._visible=false;
					TopBar.ButtonX.onRollOver();
				}
				return;
		}
		if(SortMaster._visible){
			if(SelectLevel==2 || SelectLevel==33){
				TopBar.ButtonM.onRollOver();
			}
			else if(SelectLevel==3){
				if(StoreNameSelected=="SortMaster.Movie0"){
					TopBar.ButtonM.onRollOver();
				}
				else{
					MoveLeftRight("SortMaster",StoreNameSelected,CountSortMaster,"Left");
				}
			}
			else if(SelectLevel==4){
				SortMaster.BackAlbumPic.Button.onRollOver();
			}
			return;
		}
		if(MainLevel==1){
				if(SelectLevel==2){
					if(RatingBar._visible){
						if(StoreNameSelected=="RatingBar.Movie5"){
							TopBar.ButtonM.onRollOver();
						}
						else{
							StaticMove("RatingBar.Movie5,RatingBar.Movie4,RatingBar.Movie3,RatingBar.Movie2,RatingBar.Movie1",StoreNameSelected,"Left");
						}
					}
					else{
						TopBar.ButtonM.onRollOver();
					}
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="BackLetter.BackAll.MovieAll"){
						eval("_root.BackLetter.Letter"+(21)+".Button").onRollOver();
					}
					else{
						if((RecordLetterMove.charCodeAt(0)>=65 && RecordLetterMove.charCodeAt(0)<=69 )|| RecordLetterMove.charCodeAt(0)==35 ){
							TopBar.ButtonM.onRollOver();
						}
						else{
							var Index=RecordLetterMove.charCodeAt(0);
							if(Index==70)Index=0
							else {
								Index=Index-6;
								Index=Index-64;
							}
							eval("_root.BackLetter.Letter"+(Index)+".Button").onRollOver();
						}
					}
				}
				else if(SelectLevel==4){
					mainLetter_mc.MoveObject(Key.getCode());
				}
		}
		else if(MainLevel==2 ){
				if(SelectLevel==2){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==4){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==3){
					MoveAlbum("Up");
				}
		}
		else if(MainLevel==3 ){
				if(SelectLevel==2){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==4){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==3){
					MoveAlbum("Up");
				}
		}
		else if(MainLevel==4){
			if(substring(StoreNameSelected,0,"mini".length)=="mini"){
				LeftRightPlayer("Up");
		 	}
			else{
				if(SelectLevel==2)TopBar.ButtonM.onRollOver();
				else if(SelectLevel==3){
					if(StoreNameSelected==TrackName + ".Movie0"){ //|| StoreNameSelected=="BackAlbumPic.Movie"){
						eval(TrackName).Button0.onRollOut();
						TopBar.ButtonM.onRollOver();
					}else if (  StoreNameSelected=="BackAlbumPic.Movie")
					{		
						TopBar.ButtonC.onRollOver();
					}
					else{ 
						if(StoreNameSelected==TrackName + ".MovieLeft"){
							MoveLeftRight(TrackName,  TrackName + ".MovieRight", eval("Count" + TrackObj), "Left");
						}else{
							MoveLeftRight(TrackName,StoreNameSelected,eval("Count"+TrackObj),"Left");
						}
					}
				}	
				else if(SelectLevel==4){
					if(Save._visible){
						if(substring(StoreNameSelected,0,"Save.MenuPath".length)=="Save.MenuPath"){
							var TotalIndex = CountPath;
							if (StoreNameSelected == "Save.MenuPath.Movie0") {
								if (Save.MenuPath.ButtonLeft._visible) {
									Save.MenuPath.ButtonLeft.onRelease();
									if (LevelIndexPath == TotalLevelIndexPath) {
										TotalIndex = CountPath;
									} else if (LevelIndexPath == TotalLevelIndexPath-1) {
										TotalIndex = nMenu;
									}
								}
							}
							SelecteListItemUp(StoreNameSelected, TotalIndex);
						}
						else if (substring(StoreNameSelected,0,"Save.MenuMode".length)=="Save.MenuMode") {
							StaticMove("Save.MenuMode.MovieTrack,Save.MenuMode.MovieAlbum,Save.MenuMode.MovieArtist",StoreNameSelected,"Left");
						}
						else{
							StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieEnd,Save.MovieNextChapter,Save.MovieTime,Save.MovieKey,Save.MovieOk,Save.MovieCancel",StoreNameSelected,"Left");
						}
						
					}else{
						eval("BackAlbumPic.Button").onRollOver();
					}
				}else if(SelectLevel==9){
					if(StoreNameSelected==TrackName + ".PlusIcon.Movie"){
						eval(TrackName).PlusIcon.Button.onRollOut();
						eval(TrackName).BackStars.Button1.onRollOver();
					}else if(StoreNameSelected==TrackName + ".ScanAlbum.Movie"){
						eval(TrackName).ScanAlbum.Button.onRollOut();
						eval(TrackName).MusicNote.Button.onRollOver();
					}else{
						TopBar.ButtonM.onRollOver();
					}
				}
				else if(SelectLevel==10)TopBar.ButtonM.onRollOver();
					
			}
		}
		
	}
	function GoDown(){

		fscommand("mouse_off_screen",true);
		if((SelectLevel==5 || StoreNameSelected=="TopBar.MovieX" )&& Menu._visible){
			if(StoreNameSelected=="TopBar.MovieX")eval(Menu.Ava.Button).onRollOver();
			else if(MenuLevel==0){
				//StaticMove("Menu.Ava.Movie,Menu.BrowseBy.Movie,Menu.RipCD.Movie,Menu.Scan.Movie,Menu.Player.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Right");
				StaticMove("Menu.Ava.Movie,Menu.BrowseBy.Movie,Menu.Player.Movie,Menu.Scan.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Right");
				
			}
			else if(MenuLevel==1){
				if(MenuAva._visible)StaticMove("MenuAva.YesAva.Movie,MenuAva.NotAva.Movie,MenuAva.AllAva.Movie",StoreNameSelected,"Right");
				else if(MenuBrowse._visible)StaticMove("MenuBrowse.Genre.Movie,MenuBrowse.Production.Movie,MenuBrowse.Alphabet.Movie,MenuBrowse.Rating.Movie,MenuBrowse.ReleaseDate.Movie,MenuBrowse.FavAlbum.Movie,MenuBrowse.FavArtist.Movie,MenuBrowse.MyAlbum.Movie",StoreNameSelected,"Right");
				else if(MenuMISC._visible)StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Right");
			}
			else{
				if(MenuSorted._visible)StaticMove("MenuSorted.NameSorted.Movie,MenuSorted.DateSorted.Movie",StoreNameSelected,"Right");
				else if(MenuSorted1._visible)StaticMove("MenuSorted1.NameSorted.Movie,MenuSorted1.DateSorted.Movie",StoreNameSelected,"Right");
				else if(MenuSortedReleaseDate._visible)StaticMove("MenuSortedReleaseDate.NameSorted.Movie,MenuSortedReleaseDate.DateSorted.Movie",StoreNameSelected,"Right");
				else if(MenuFavAlbum._visible)StaticMove("MenuFavAlbum.Genre.Movie,MenuFavAlbum.Production.Movie,MenuFavAlbum.Rating.Movie,MenuFavAlbum.Rank.Movie",StoreNameSelected,"Right");
				else if(MenuMyAlbum._visible)StaticMove("MenuMyAlbum.Genre.Movie,MenuMyAlbum.Production.Movie,MenuMyAlbum.Rating.Movie,MenuMyAlbum.Rank.Movie",StoreNameSelected,"Right");
				else if(MenuFavArtist._visible)StaticMove("MenuFavArtist.Genre.Movie,MenuFavArtist.Production.Movie,MenuFavArtist.Rating.Movie",StoreNameSelected,"Right");
			}
			return;
		}
		if(SortMaster._visible){
			if(SelectLevel==1){
				if(GenreBar._visible){
					GenreBar.Button0.onRollOver();
				}
				else SortMaster.Button0.onRollOver();
			}
			else if(SelectLevel==2){
				GenreBar._visible=false;
				SortMaster.Button0.onRollOver();
			}
			else if(SelectLevel==3){
				MoveLeftRight("SortMaster",StoreNameSelected,CountSortMaster,"Right");
			}
			else if(SelectLevel==33){
				SortMaster.ButtonUp.Button.onRollOver();
			}
			else if(SelectLevel==4){
				SortMaster.BackAlbumPic.Button.onRollOver();
			}
			return;
		}
		if(MainLevel==1){
				if(SelectLevel==1){
					if(GenreBar._visible)GenreBar.Button0.onRollOver();
					else if(RatingBar._visible)RatingBar.Button5.onRollOver();
					else if(mainLetter_mc._visible) mainLetter_mc.letter0._btn.onRollover()				
					else eval("_root.BackLetter.Letter"+0+".Button").onRollOver();
				}
				else if(SelectLevel==2){
					if(GenreBar._visible){
						GenreBar._visible=false;
						eval("_root.BackLetter.Letter"+0+".Button").onRollOver();
					}
					else if(RatingBar._visible){
						if(StoreNameSelected=="RatingBar.Movie1"){
							RatingBar._visible=false;
							eval("_root.BackLetter.Letter"+0+".Button").onRollOver();
						}
						else{
							StaticMove("RatingBar.Movie5,RatingBar.Movie4,RatingBar.Movie3,RatingBar.Movie2,RatingBar.Movie1",StoreNameSelected,"Right");
						}
					}
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="_level0.BackLetter.Letter23.Movie" ||StoreNameSelected=="_level0.BackLetter.Letter22.Movie"||StoreNameSelected=="_level0.BackLetter.Letter21.Movie"){
						BackLetter.BackAll.ButtonAll.onRollOver();
					}
					else{
						var Index=RecordLetterMove.charCodeAt(0);
						if(Index==35)Index=6;
						else {
							Index=Index+6;
							Index=Index-64;
						}
						eval("_root.BackLetter.Letter"+(Index)+".Button").onRollOver();
					}
				}
				else if(SelectLevel==4){
					mainLetter_mc.MoveObject(Key.getCode());
				}
				
		}
		else if(MainLevel==2){
				if(SelectLevel==1){
					if(CharBar._visible)CharBar.Button0.onRollOver();
					else if(GenreBar._visible)GenreBar.Button0.onRollOver();
					else if(ArrowBar._visible)ArrowBar.Button0.onRollOver();
				}
				else if(SelectLevel==2){
					if(ArrowBar._visible){
						CharBar._visible=false;
						ArrowBar.Button0.onRollOver();
					}
				}
				else if(SelectLevel==4){
					if(eval(NameAlbum+".Button0")._visible){
						eval(NameAlbum+".Button0").onRollOver();
					}
				}
				else if(SelectLevel==3){
					MoveAlbum("Down");
				}
		}
		else if(MainLevel==3){
				if(SelectLevel==1){
					if(ArtistNameBar._visible)ArtistNameBar.Button0.onRollOver();
					else if(CharBar._visible)CharBar.Button0.onRollOver();
					else if(GenreBar._visible)GenreBar.Button0.onRollOver();
					else if(VolBar._visible)VolBar.Button0.onRollOver();
				}
				else if(SelectLevel==2){
					if(VolBar._visible){
						ArtistNameBar._visible=false;
						CharBar._visible=false;
						GenreBar._visible=false;
						VolBar.Button0.onRollOver();
					}
				}
				else if(SelectLevel==4){
					if(eval(NameAlbum+".Button0")._visible){
						eval(NameAlbum+".Button0").onRollOver();
					}
				}
				else if(SelectLevel==3){
					MoveAlbum("Down");
				}
		}

		else if(MainLevel==4){
			if(substring(StoreNameSelected,0,"mini".length)=="mini"){
				LeftRightPlayer("Down");
			}
			else{
				if(SelectLevel==1){
					if(AlbumBar._visible)AlbumBar.Button0.onRollOver();
					else if ( StoreNameSelected =="TopBar.MovieC" || StoreNameSelected =="TopBar.MovieO" || StoreNameSelected =="TopBar.MovieL" || StoreNameSelected =="TopBar.MovieX")
					{
						BackAlbumPic.Button.onRollOver();
					}
					else {
						if(eval(TrackName).Button0._visible)eval(TrackName).Button0.onRollOver();
						else eval("BackAlbumPic.Button").onRollOver();
					}
				}
				else if(SelectLevel==2){
					AlbumBar._visible=false;
					if(eval(TrackName)._visible)eval(TrackName).Button0.onRollOver();
					else eval("BackAlbumPic.Button").onRollOver();
				}
				else if(SelectLevel==3){
					if(StoreNameSelected == "BackAlbumPic.Movie") eval("PlayAll.Button").onRollOver();
					else if(StoreNameSelected == TrackName + ".MovieRight") eval(TrackName).ButtonLeft.onRollOver(); //eval(TrackName).Button0.onRollOver();
					else MoveLeftRight(TrackName, StoreNameSelected, eval("Count" + TrackObj), "Right");
				}
				else if(SelectLevel==4){
					if(Save._visible){
						if(StoreNameSelected=="Save.MovieMode" && Save.MenuMode._visible){
							Save.MenuMode.ButtonTrack.onRollOver();
						}
						else if (substring(StoreNameSelected,0,"Save.MenuMode".length)=="Save.MenuMode") {
							StaticMove("Save.MenuMode.MovieTrack,Save.MenuMode.MovieAlbum,Save.MenuMode.MovieArtist",StoreNameSelected,"Right");
						}
						else if(StoreNameSelected=="Save.MoviePath" && Save.MenuPath._visible){
							Save.MenuPath.Button0.onRollOver();
						}
						else if (substring(StoreNameSelected,0,"Save.MenuPath".length)=="Save.MenuPath") {
							var TotalIndex = CountPath;
							if (StoreNameSelected == "Save.MenuPath.Movie"+(CountPath-1)) {
								if (Save.MenuPath.ButtonRight._visible) {
									Save.MenuPath.ButtonRight.onRelease();
								}
							}
							else {
								SelecteListItemDown(StoreNameSelected, TotalIndex);
							}
						}	 
						else{
							StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieEnd,Save.MovieNextChapter,Save.MovieTime,Save.MovieKey,Save.MovieOk,Save.MovieCancel",StoreNameSelected,"Right");
						}
							
					}else{
						vb="lostFocus";
						fscommand("LoadSwfMiniControl",getSelectedIndex());
					}
				}
				else if(SelectLevel==9){
					if(StoreNameSelected==TrackName + ".BackStars.Movie1"||StoreNameSelected==TrackName + ".BackStars.Movie2"||StoreNameSelected==TrackName + ".BackStars.Movie3"||StoreNameSelected==TrackName + ".BackStars.Movie4"||StoreNameSelected==TrackName + ".BackStars.Movie5"){
						eval(TrackName).BackStars.Back.onRollOut();
						eval(TrackName).PlusIcon.Button.onRollOver();
					}else if(StoreNameSelected==TrackName + ".RefreshCoverArt.Movie"||StoreNameSelected==TrackName + ".RIPCD.Movie"||StoreNameSelected==TrackName + ".MusicNote.Movie"){
						eval(Replace(StoreNameSelected,"Movie","Button")).onRollOut();	
						eval(TrackName).ScanAlbum.Button.onRollOver();
					}else{
						eval(TrackName).PlusIcon.Button.onRollOut();
						eval(TrackName).BackStars.Back.onRollOut();
						BackAlbumPic.Button.onRollOver();
					}
				}
			}
		}
	}
}

function MoveAlbum(Move){
	if(Move=="Right"){
		if(MainLevel==2){
			var Sp=resultSearchArrow[RecordIndexArrow].split(":");
			var Count=parseInt(Sp[1],10)-parseInt(Sp[0],10);
			var Index=GetNumber(StoreNameSelected)
//			Index+=1;
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
					
					// in case the Button is hide
					eval(NameAlbum+".Button"+Count)._visible = true;
					eval(NameAlbum+".Movie"+Count)._visible = true;
					eval(NameAlbum+".Button"+Count).onRollOver();
//					SelectLevel=3;
//					SelectButton(NameAlbum+".Movie"+Count);
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

function LeftRightPlayer(Value){
	if(Value=="Right"){
		if(StoreNameSelected=="mini.PauseMusic.MoviePause" ||StoreNameSelected=="mini.PlayMusic.MoviePlay")mini.StopMusic.ButtonStop.onRollOver();
		else if(StoreNameSelected=="mini.StopMusic.MovieStop")mini.PreviousMusic.ButtonPrevious.onRollOver();
		else if(StoreNameSelected=="mini.PreviousMusic.MoviePrevious")mini.NextMusic.ButtonNext.onRollOver();
		else if(StoreNameSelected=="mini.NextMusic.MovieNext")mini.AddMusic.ButtonAddMusic.onRollOver();
		else if(StoreNameSelected=="mini.AddMusic.MovieAddMusic")mini.PlayerPage.ButtonPlayerPage.onRollOver();
		else if(StoreNameSelected=="mini.PlayerPage.MoviePlayerPage"){
			if(mini.RepeatTrue._visible)mini.RepeatTrue.ButtonRepeat.onRollOver();
			else mini.RepeatFalse.ButtonRepeat.onRollOver();
		}
		else if(StoreNameSelected=="mini.RepeatTrue.MovieRepeat"||StoreNameSelected=="mini.RepeatFalse.MovieRepeat"){
			if(mini.ShuffleTrue._visible)mini.ShuffleTrue.ButtonShuffle.onRollOver();
			else mini.ShuffleFalse.ButtonShuffle.onRollOver();
		}
		else if(StoreNameSelected=="mini.ShuffleTrue.MovieShuffle"|| StoreNameSelected=="mini.ShuffleFalse.MovieShuffle"){
			if(mini.MuteTrue._visible)mini.MuteTrue.ButtonMute.onRollOver();
			else mini.MuteFalse.ButtonMute.onRollOver();
		}
		else if(StoreNameSelected=="mini.MuteTrue.MovieMute"||StoreNameSelected=="mini.MuteFalse.MovieMute"){
			if(mini.PauseMusic._visible)mini.PauseMusic.ButtonPause.onRollOver();
			else mini.PlayMusic.ButtonPlay.onRollOver();
		}
	}
	else if(Value=="Left"){
		if(StoreNameSelected=="mini.PauseMusic.MoviePause" ||StoreNameSelected=="mini.PlayMusic.MoviePlay"){
			if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button5.onRollOver();
			else eval(TrackName + ".Button"+(eval("Count"+TrackObj)-1)).onRollOver();
		}
		else if(StoreNameSelected=="mini.StopMusic.MovieStop"){
			if(mini.PauseMusic._visible)mini.PauseMusic.ButtonPause.onRollOver();
			else mini.PlayMusic.ButtonPlay.onRollOver();
		}
		else if(StoreNameSelected=="mini.PreviousMusic.MoviePrevious")mini.StopMusic.ButtonStop.onRollOver();
		else if(StoreNameSelected=="mini.NextMusic.MovieNext")mini.PreviousMusic.ButtonPrevious.onRollOver();
		else if(StoreNameSelected=="mini.AddMusic.MovieAddMusic")mini.NextMusic.ButtonNext.onRollOver();
		else if(StoreNameSelected=="mini.PlayerPage.MoviePlayerPage"){
			//if(mini.RepeatTrue._visible)mini.RepeatTrue.ButtonRepeat.onRollOver();
			//else mini.RepeatFalse.ButtonRepeat.onRollOver();
			mini.AddMusic.ButtonAddMusic.onRollOver();
		}
		else if(StoreNameSelected=="mini.RepeatTrue.MovieRepeat"||StoreNameSelected=="mini.RepeatFalse.MovieRepeat"){
			mini.PlayerPage.ButtonPlayerPage.onRollOver();
		}
		else if(StoreNameSelected=="mini.ShuffleTrue.MovieShuffle"|| StoreNameSelected=="mini.ShuffleFalse.MovieShuffle"){
			if(mini.RepeatTrue._visible)mini.RepeatTrue.ButtonRepeat.onRollOver();
			else mini.RepeatFalse.ButtonRepeat.onRollOver();
			//if(mini.MuteTrue._visible)mini.MuteTrue.ButtonMute.onRollOver();
			//else mini.MuteFalse.ButtonMute.onRollOver();
		}
		else if(StoreNameSelected=="mini.MuteTrue.MovieMute"||StoreNameSelected=="mini.MuteFalse.MovieMute"){
			if(mini.ShuffleTrue._visible)mini.ShuffleTrue.ButtonShuffle.onRollOver();
			else mini.ShuffleFalse.ButtonShuffle.onRollOver();
			//if(mini.PauseMusic._visible)mini.PauseMusic.ButtonPause.onRollOver();
			//else mini.PlayMusic.ButtonPlay.onRollOver();
		}
	}
	else if(Value=="Up"){
		if(StoreNameSelected=="mini.MuteTrue.MovieMute"||StoreNameSelected=="mini.MuteFalse.MovieMute" || StoreNameSelected=="mini.ShuffleTrue.MovieShuffle"|| StoreNameSelected=="mini.ShuffleFalse.MovieShuffle" || StoreNameSelected=="mini.RepeatTrue.MovieRepeat"||StoreNameSelected=="mini.RepeatFalse.MovieRepeat"){
			if(mini.PauseMusic._visible)mini.PauseMusic.ButtonPause.onRollOver();
			else mini.PlayMusic.ButtonPlay.onRollOver();
		}
		else{
			PlayAll.Button.onRollOver();
		}
	}
	else if(Value=="Down"){
		if(!(StoreNameSelected=="mini.MuteTrue.MovieMute"||StoreNameSelected=="mini.MuteFalse.MovieMute" || StoreNameSelected=="mini.ShuffleTrue.MovieShuffle"|| StoreNameSelected=="mini.ShuffleFalse.MovieShuffle" || StoreNameSelected=="mini.RepeatTrue.MovieRepeat"||StoreNameSelected=="mini.RepeatFalse.MovieRepeat")){
			if(mini.RepeatTrue._visible)mini.RepeatTrue.ButtonRepeat.onRollOver();
			else mini.RepeatFalse.ButtonRepeat.onRollOver();
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------
function combind_key2(KeyCode){	
	KeyCode = int(KeyCode);
	if(KeyCode == KeySlide){	//~
		fn_set_slideshow(SlideShowValue);
	} else if(KeyCode == 220 ){		//.....|\
		change_album_display_type();		
	} else if(KeyCode == KeyAlbumCover || KeyCode == 97  ){ //1
		fn_set_album_cover(AlbumCover);
	} else if(KeyCode == KeyNumCover || KeyCode == 98){	//2
		fn_set_num_cover(NumCover);
	} else if(KeyCode == KeyPlusCover || KeyCode == 99){	//3
		fn_set_plus_cover(PlusCover);
	} else if(KeyCode == KeyBGenre || KeyCode == 100){//4
		fn_set_BGenre(SortedNameGenre, Grouping);
	} else if(KeyCode == KeyBProduction || KeyCode == 101){	//5
		fn_set_BProduction(SortedNameGenre, Grouping);
	} else if(KeyCode == KeyBRating || KeyCode == 102){ //6
		fn_set_BRatting(SortedNameGenre, Grouping);
	} else if(KeyCode == KeyBReleaseDate|| KeyCode == 103){ //7
		fn_set_BReleaseDate(SortedNameGenre, Grouping);
	} else if(KeyCode == KeyBMyFavAlbum || KeyCode == 104){ //8
		fn_set_BMyFavAlbum(SortedNameFavAlbum, Grouping);
	} else if(KeyCode == KeyBMyFavArtist|| KeyCode == 105){ //9
		fn_set_BMyFavArtist(SortedNameFavArtist, Grouping);
	} else if(KeyCode == KeyBMyAlbum || KeyCode == 96){ //0
		fn_set_BMyAlbum(SortedNameMyAlbum, Grouping);
	} else if(KeyCode == KeyMin){
//		Menu.Min.Button.onRelease();
	}else if(KeyCode == 71){//G
		Ctrl_G();
	}
	 //else if(KeyCode == 87){//W
	//	Ctrl_W();
	//} 
	else if(KeyCode == 74 && eval(NameAlbum)._visible){//J
		change_display_image_size();
	} else if(KeyCode == 75){//K
		Ctrl_K();
	} else if(KeyCode == 85){
		CtrlKey = false;
		TopBar.ButtonFull.onRollOver();
		TopBar.ButtonFull.onRelease();
		//fscommand("FullScreenPlayer");//U
	} else if(KeyCode == 83){
		CtrlKey = false;
		TopBar.ButtonS.onRollOver();//S
		TopBar.ButtonS.onRelease();//S
	} else if(KeyCode == 80){
		CtrlKey = false;
		TopBar.ButtonP.onRollOver();//P
		TopBar.ButtonP.onRelease();//P
	} else if(KeyCode == KeyPlayer){
		CtrlKey = false;
		TopBar.ButtonPlayer.onRollOver();//L
		TopBar.ButtonPlayer.onRelease();//L
	} 
	/*
	else if(KeyCode == 82){
		CtrlKey = false;
		TopBar.ButtonRip.onRollOver();//R
		TopBar.ButtonRip.onRelease();//R
	}
	
	else if(KeyCode == 70){ //C
		CtrlKey = false;
		TopBar.ButtonScan.onRollOver();
		TopBar.ButtonScan.onRelease();
	}
	*/
	else if(KeyCode == 77){	//M
		TopBar.ButtonM.onRollOver()
		TopBar.ButtonM.onRelease();
	} else if(KeyCode == KeyLanguage){ //Y
		CtrlKey = false;
		TopBar.ButtonC.onRollOver();
		TopBar.ButtonC.onRelease();
	} else if(KeyCode == 79){ //O
		CtrlKey = false;
		TopBar.ButtonO.onRollOver();
		TopBar.ButtonO.onRelease();
	} else if(KeyCode==69){ //E	
		TopBar.ButtonL.onRollOver()
		TopBar.ButtonL.onRelease();
	} else if(KeyCode == 68){ //D
		ShowHideMenuButtonX(!(Menu._visible));
	} else if(KeyCode == keyHideMouse){
		if(HideMouse == "true"){
			Mouse.show();
			HideMouse = "false";
		} else {
			Mouse.hide();
			HideMouse = "true";
		}
		fscommand("setHideMouse",HideMouse);
	} else if(KeyCode == 84){ //T
		change_visualization();
	} else if(KeyCode == 72){
		if(DisplayAlbum == "Browse"){
			if(BrowseBy == "ReleaseDate" && MainLevel == 3){
				GenreBar.ButtonOpt.onRelease();
			} else {
				if(MainLevel == 1){
					GenreBar.ButtonOpt.onRelease();
				}
			}
		}
	}
}

//----------------------------------------------------------------------------------------------------
function change_album_display_type(){
	if (send_event("normal&&&function||change_album_display_type||0", false)) {
		return;
	}
	switch(NumMovie){
		case nLarge:
				temp="Large";break;
		case nMedium:
				temp="Medium";break;
		case nSmall:
				temp="Small";break;
				//...............
		case nLarges:
				temp="Large";break;
		case nMediums:
				temp="Medium";break;
		case nSmalls:
				temp="Small";break;
	}
	fscommand("ChangeDisplayList",temp);
}

//----------------------------------------------------------------------------------------------------
function change_display_image_size(){
	if (send_event("normal&&&function||change_display_image_size||0", false)) {
		return;
	}
	var temp="Large";
	switch(NumMovie){
		case nLarge:
				temp="Medium";break;
		case nMedium:
				temp="Small";break;
		case nSmall:
				temp="Large";break;
				//...............
		case nLarges:
				temp="Medium";break;
		case nMediums:
				temp="Small";break;
		case nSmalls:
				temp="Large";break;
	}
	fscommand("CtrlPlus","J~"+temp);
}

//----------------------------------------------------------------------------------------------------
function change_visualization(){
	if (send_event("normal&&&function||change_visualization||0", false)) {
		return;
	}
	fscommand("Visualization");
}
//----------------------------------------------------------------------------------------------------
function Ctrl_G(){
	if (send_event("normal&&&function||Ctrl_G||0", false)) {
		return;
	}
	fscommand("CtrlPlus","G~0");
	if(MainLevel == 3){
		var splTemp=StoreReloadGroup.split("&&&");
		fscommand(splTemp[0],splTemp[1]);					
	}
}
//----------------------------------------------------------------------------------------------------
function fn_set_slideshow(val_SlideShowValue){
	if (send_event("normal&&&function||fn_set_slideshow|~|" + val_SlideShowValue + "||0", false)) {
		return;
	}
	SlideShowValue = val_SlideShowValue;
	if(SlideShowValue == "Yes"){
		DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (OFF)", SHTT, -(96/2)+5, 20, true);
		SlideShowValue = "No";
	} else {
		DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (ON)", SHTT, -(96/2)+5, 20, true);
		SlideShowValue = "Yes";
	}
	fscommand("SetSlideShowOnOff",SlideShowValue);
}
//----------------------------------------------------------------------------------------------------
function fn_set_album_cover(val_AlbumCover){
	if (send_event("normal&&&function||fn_set_album_cover|~|" + val_AlbumCover + "||0", false)) {
		return;
	}
	var AlbumCover1 = val_AlbumCover;
	if(AlbumCover1 == "Yes"){
		AlbumCover1 = "No";
	} else {
		AlbumCover1 = "Yes";
	}
	fscommand("CtrlPlus","1~" + AlbumCover1);
}
//----------------------------------------------------------------------------------------------------
function fn_set_num_cover(val_NumCover){
	if (send_event("normal&&&function||fn_set_num_cover|~|" + val_NumCover + "||0", false)) {
		return;
	}
	var NumCover1 = val_NumCover;
	if(NumCover1 == "Yes"){
		NumCover1 = "No";
	} else {
		NumCover1 = "Yes";
	}
	fscommand("CtrlPlus","2~" + NumCover1);
}
//----------------------------------------------------------------------------------------------------
function fn_set_plus_cover(val_PlusCover){
	if (send_event("normal&&&function||fn_set_plus_cover|~|" + val_PlusCover + "||0", false)) {
		return;
	}
	var PlusCover1 = val_PlusCover;
	if(PlusCover1 == "Yes"){
		PlusCover1 = "No";
	} else {
		PlusCover1 = "Yes";
	}
	fscommand("CtrlPlus","3~" + PlusCover1);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BGenre(val_SortedNameGenre, val_Grouping){
	if (send_event("normal&&&function||fn_set_BGenre|~|" + val_SortedNameGenre + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.Genre.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By Genre||Sorting By " + val_SortedNameGenre);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BProduction(val_SortedNameGenre, val_Grouping){
	if (send_event("normal&&&function||fn_set_BProduction|~|" + val_SortedNameGenre + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.Production.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By Production||Sorting By " + val_SortedNameGenre);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BRatting(val_SortedNameGenre, val_Grouping){
	if (send_event("normal&&&function||fn_set_BRatting|~|" + val_SortedNameGenre + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	BrowseShow.setTrackShow("Browsing By Rating||Sorting By " + val_SortedNameGenre);
	showPopupGrouping(val_Grouping);
	MenuBrowse.Rating.Button.onRelease();
}
//----------------------------------------------------------------------------------------------------
function fn_set_BAlphabet(val_SortedNameGenre, val_Grouping){
	if (send_event("normal&&&function||fn_set_BRatting|~|" + val_SortedNameGenre + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	BrowseShow.setTrackShow("Browsing By Rating||Sorting By " + val_SortedNameGenre);
	showPopupGrouping(val_Grouping);
	MenuBrowse.Rating.Button.onRelease();
}
//----------------------------------------------------------------------------------------------------
function fn_set_BReleaseDate(val_SortedNameGenre, val_Grouping){
	if (send_event("normal&&&function||fn_set_BReleaseDate|~|" + val_SortedNameGenre + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.ReleaseDate.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By Release Date||Sorting By " + val_SortedNameGenre);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BMyFavAlbum(val_SortedNameFavAlbum, val_Grouping){
	if (send_event("normal&&&function||fn_set_BMyFavAlbum|~|" + val_SortedNameFavAlbum + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.FavAlbum.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By My Favorite Albums" + "||Sorting By " + val_SortedNameFavAlbum);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BMyFavArtist(val_SortedNameFavArtist, val_Grouping){
	if (send_event("normal&&&function||fn_set_BMyFavArtist|~|" + val_SortedNameFavArtist + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.FavArtist.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By My Favorite Artists" + "||Sorting By " + val_SortedNameFavArtist);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
function fn_set_BMyAlbum(val_SortedNameMyAlbum, val_Grouping){
	if (send_event("normal&&&function||fn_set_BMyAlbum|~|" + val_SortedNameMyAlbum + "|~|" + val_Grouping + "||0", false)) {
		return;
	}
	MenuBrowse.MyAlbum.Button.onRelease();
	BrowseShow.setTrackShow("Browsing By My Albums" + "||Sorting By " + val_SortedNameMyAlbum);
	showPopupGrouping(val_Grouping);
}
//----------------------------------------------------------------------------------------------------
/*function Ctrl_W(){
	if (send_event("normal&&&function||Ctrl_W||0", false)) {
		return;
	}
	fscommand("CtrlPlus","W~0");
}*/
//----------------------------------------------------------------------------------------------------
function Ctrl_K(){
	if (send_event("normal&&&function||Ctrl_K||0", false)) {
		return;
	}
	fscommand("CtrlPlus","K~true");
}
function getSelectedIndex() 
{
	for(var i=0 ; i< 6 ; i++)
	{
		if (topControl[i]== StoreNameSelected )
		{
			return bObj[i];
		}	
	}
	return bObj[5];
}