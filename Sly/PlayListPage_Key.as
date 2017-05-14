f//...........................FUNCTION PRESS ANY KEY................................\
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
			if(MainLevel==1){
				if(NumIndexKey>=0 && NumIndexKey<resultP.length){
					BackPlayList._visible=false;
					MenuMode._visible=false;
					/*//IndexPlayList=GetNumber(this._name);
					RecordIndexP=NumIndexKey;
					fscommand("SetPlayListName",ResultP[RecordIndexP]+StWave+SlyPath[RecordIndexP]);
					FirstDisplayP(resultP.length,RecordIndexP);
					ClickPlayListByMode();*/
					click_each_playlist(MainLevel,NumIndexKey);
				}
			}
			else if(MainLevel==2){
				if(NumIndexKey>=0 && NumIndexKey<resultArtist.length){
					//ArtistMode._visible=false;
					//ArtistSorted._visible=false;
					ShowAlbumBar="Artist";
					RecordIndexArtist = NumIndexKey;
					//FirstDisplayP(resultArtist.length,RecordIndexArtist);
					if(ArtistMode.Text.text=="Albums in PlayList"){
						ArtistMode._visible=false;
						ArtistSorted._visible=false;
						FirstDisplayP(resultArtist.length,RecordIndexArtist);
						GetAlbumByArtist(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml",resultArtist[RecordIndexArtist].Artist);
						MainLevel=3;
					}
					else{
						if(resultArtist[RecordIndexArtist].Mode!="External"){
							fscommand("BrowseAlbumByArtist","Name="+resultArtist[RecordIndexArtist].Artist+StWave+SplAllCountrys[resultArtist[RecordIndexArtist].Nation]+StWave+ArtistModeValue+StWave+ArtistSortedValue);
						}
						else{
							ArtistMode._visible=false;
							ArtistSorted._visible=false;
							FirstDisplayP(resultArtist.length,RecordIndexArtist);
							GetAlbumByArtist(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml",resultArtist[RecordIndexArtist].Artist);
							MainLevel=3;
						}
					}
				}
			}
			else if(MainLevel==3){
				if(NumIndexKey>=0 && NumIndexKey<resultAlbum.length){
					eval(NameAlbum)._visible=false;
					VolBar._visible=false;
					ShowAlbumBar="Album";
					RecordIndexAlbum = NumIndexKey;
					FirstDisplayP(resultAlbum.length,RecordIndexAlbum);
					StoreAlbum = resultAlbum[RecordIndexAlbum].Artist;
					StoreUniAlbum = resultAlbum[RecordIndexAlbum].uniArtist;
					if(resultAlbum[RecordIndexAlbum].Mode=="External"){
						LoadExternalTrack(BackPlayList.TextD.text+"\\PlayLists\\"+ResultP[RecordIndexP]+".xml",resultAlbum[RecordIndexAlbum].Artist);
					}
					else{
						fscommand("GetArtistTrackInfo", resultAlbum[RecordIndexAlbum].id+StWave+SplAllCountrys[resultAlbum[RecordIndexAlbum].Nation]);
					}
					MainLevel=4;
				}
			}
			else if(MainLevel==4){
				/*	
				if(NumIndexKey>=0 && NumIndexKey<eval("Num"+TrackObj)){
					IndexTrack=NumIndexKey;
					if (PlayAll.Text.text=="One"){
						PutIndexPlayTrack(resultSearch,IndexTrack)
					}
					else if (PlayAll.Text.text=="All"){
						fscommand("SetImageSlide",SlyPath[RecordIndexP]);
						FuncPlayPage(IndexTrack);
					}
					var k=IndexTrack%nTrack;
					var k1=eval("IndexShow"+TrackObj)+k;
					if(IndexTrack==k1){
						eval(TrackName + ".Button"+k).onRollOver();
					}
				}*/
				if(NumIndexKey>=0 && NumIndexKey<eval("Num"+TrackObj)){

				///================ sith changed ========================	
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
					//eval(TrackName + ".Button"+GetNumber(StoreNameSelected)).onRollOut();
					eval(TrackName + ".Button"+(NumIndexKey%nTrack)).onRollOver();
					eval(TrackName + ".Button"+(NumIndexKey%nTrack)).onRelease();
				}

			}
			CombinNum="";
			clearInterval(IntervalKey1);
		}
	}
	
					 },300)
}
//.........................................
someListenerKeyUp = new Object();
someListenerKeyUp.onKeyUp = function () {
	if(Key.getCode()==17){
		CtrlKey=false;
	}
};
Key.addListener(someListenerKeyUp);
Playlist_Listener = new Object();
Playlist_Listener.onMouseDown = function () { 
	_global.boolMouseDown = true;
	fscommand("KeyPressed","MouseDown");
};
Mouse.removeListener(Playlist_Listener);
Mouse.addListener(Playlist_Listener);

myListener = new Object();
myListener.onKeyDown = function () {
	_global.boolMouseDown = true;
	if(selection.getFocus()==null || String(selection.getFocus())=="_level0.GetFocus" ){
		if(UpdateDB._visible || RestoreDB._visible||CopyMusic._visible||BackUpDB._visible||PurchaseCDMode._visible ||AddNewScreens._visible ||WarningUpdate._visible){	
				fscommand("KeyPressed","");
				if(Key.getCode()==39){
					if(WarningUpdate._visible){
						StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel",StoreNameSelected,"Right")
					}else if (UpdateDB._visible){
						StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Right");
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Right")
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
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Left");
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Left")
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
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Left")
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Left")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Left")
					}
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Left")
					}
				}
				else if(Key.getCode()==40){
					if(PurchaseCDMode._visible){
						MovePurchaseKey(40);
					}
					else if (AddNewScreens._visible){
						ArrowKeyScreen("Right");
					}
					else if (RestoreDB._visible){
						StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel",StoreNameSelected,"Right")
					}
					else if (CopyMusic._visible){
						StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel",StoreNameSelected,"Right")
					}
					else if (BackUpDB._visible){
						StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel",StoreNameSelected,"Right")
					}
				} else if(Key.getCode()==13){
					PressKeyPlayList(Key.getCode());
				}	
		}else{
			PressKeyPlayList(Key.getCode());
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
}
Key.addListener(myListener);
var SelectLevel=1;
var CtrlKey=false;
function PressKeyPlayList(KeyCode,SendArr){
	if(CtrlKey){
		combine_key1();
	} else {
		if(SendArr=="false"){
			fscommand("KeyPressed","");
		}else{
			if (KeyCode == 187 || KeyCode == 189 ){//|| KeyCode == 77){
//				control_syncronize("volume", "KeyPressed", KeyCode);
			} else {
//				control_mini_player("KeyPressed",KeyCode,"true"); //test
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
		CtrlKey=false;
		eval(Replace(StoreNameSelected,"Movie","Button")).onRelease();
	}
	else if(KeyCode==32){
		if(eval(TrackName)._visible){
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
						BackAlbumPic.Button.onRollOver();
					}
					else{
						temp = TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5,";
						temp = temp + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".ScanAlbum.Movie";
						StaticMove(temp,StoreNameSelected,"Right");
					}
				}
			}else{
				press_space_bar();
			}
		}else{
			press_space_bar();
		}
	}
	else if(KeyCode==17){
		CtrlKey=true;
	}
	else{
		 eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
		 if(CtrlKey){
			combine_key2(KeyCode);			
			//CtrlKey=false;
		}//Ctrl=true;
		else{

			if(KeyCode==65 && PlayAll._visible && Selection.getFocus()==null){
				PlayAll.Button.onRollOver();	
				PlayAll.Button.onRelease();	
			}
			else if((KeyCode>=48 && KeyCode<=57 )||(KeyCode>=96 && KeyCode<=105)){
				if(OpenKey=="False")OpenNumKey();
				OpenKey="True";
				CombinNum+=CoverKeyCodeToNum(KeyCode);
			}
			else if(KeyCode==71 && Selection.getFocus()==null){
				if(ButtonBurch._visible){
					ButtonBurch.Button.onRollOver();
					ButtonBurch.Button.onRelease();
				}
			}
			else if(KeyCode==73 && Selection.getFocus()==null){
				if(ButtonCD._visible){
					ButtonCD.Button.onRollOver();
					ButtonCD.Button.onRelease();
				}
			}
			else if(KeyCode==8 && Selection.getFocus()==null){
				TopBar.ButtonB.onRollOver();
				TopBar.ButtonB.onRelease();
			}
			else if(KeyCode==KeyPreAlbum && Selection.getFocus()==null){
				if(ButtonPre._visible){
					ButtonPre.Button.onRollOver();
					ButtonPre.Button.onRelease();
				}
				else if(ArrowBar._visible){
					if(ArrowBar.ButtonLeft._visible){
						ArrowBar.ButtonLeft.onRollOver();
						ArrowBar.ButtonLeft.onRelease();
					}
				}
				else if(VolBar._visible){
					if(VolBar.ButtonArrowLeft._visible){
						VolBar.ButtonArrowLeft.onRollOver();
						VolBar.ButtonArrowLeft.onRelease();
					}
				}
			}
			else if(KeyCode==KeyNextAlbum && Selection.getFocus()==null){
				if(ButtonNext._visible){
					ButtonNext.Button.onRollOver();
					ButtonNext.Button.onRelease();
				}
				else if(ArrowBar._visible){
					if(ArrowBar.ButtonRight._visible){
						ArrowBar.ButtonRight.onRollOver();
						ArrowBar.ButtonRight.onRelease();
					}
				}
				else if(VolBar._visible){
					if(VolBar.ButtonArrowRight._visible){

						VolBar.ButtonArrowRight.onRollOver();
						VolBar.ButtonArrowRight.onRelease();
					}
				}
			}
			else if(keyCode == 219){
				if(VolBar._visible && VolBar.ButtonLeft._visible){
					VolBar.ButtonLeft.onRollOver();
					VolBar.ButtonLeft.onRelease();
				}
				else if (eval(TrackName)._visible && eval(TrackName).ButtonLeft._visible){
					eval(TrackName).ButtonLeft.onRelease();
					eval(TrackName).ButtonLeft.onRollOver();
				}
			}else if(keyCode == 221){
				if(VolBar._visible && VolBar.ButtonRight._visible){
					VolBar.ButtonRight.onRollOver();
					VolBar.ButtonRight.onRelease();
				}
				else if (eval(TrackName)._visible && eval(TrackName).ButtonRight._visible){
					eval(TrackName).ButtonRight.onRelease();
					eval(TrackName).ButtonRight.onRollOver();
				}
			}
			
		}//Ctrl=false;
	}
	//..................
	function GoRight(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			MenuMISC._visible=false;
			Menu.MISC.Button.onRollOver();
			return;
		}
		else if(SelectLevel==1){
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Right");
			return;
		}
		if(MainLevel==1){
			if(SortMaster._visible){
				if(SelectLevel==3){
					if(DeletePlayList._visible){
						StaticMove("DeletePlayList.MovieOk,DeletePlayList.MovieCancel",StoreNameSelected,"Right");
					}
					else if(Rename._visible){
						StaticMove("Rename.MovieKey,Rename.MovieOk,Rename.MovieCancel",StoreNameSelected,"Right");
					}
					else SortMaster.BackAlbumPic.Button.onRollOver();
				}
				else if(SelectLevel==4)SortMaster.ButtonUp.Button.onRollOver();
				else if(SelectLevel==6){
					if(CreateNew._visible){
						StaticMove("CreateNew.MovieKey,CreateNew.MovieOk,CreateNew.MovieCancel",StoreNameSelected,"Right");
					}
					else{
						if(StoreNameSelected=="SortMaster.ButtonReName.Movie"){
							SortMaster.Button0.onRollOver();
						}
						else{
							var temp="SortMaster.ButtonUp.Movie,SortMaster.ButtonDown.Movie,SortMaster.ButtonDel.Movie,SortMaster.ButtonNew.Movie,SortMaster.ButtonReName.Movie";
							StaticMove(temp,StoreNameSelected,"Right");
						}
					}
				}
			}
			else{   
				if(SelectLevel==2){
					var temp="";
					var temp1="";
					if(BackPlayList.BackListD.ButtonLeft._visible){
						for(var j=0;j<CountD;j++){
							temp+=temp1+"BackPlayList.BackListD.Movie"+j;
							temp1=",";
						}
						temp="BackPlayList.BackListD.MovieLeft,"+temp+",BackPlayList.BackListD.MovieRight"+",BackPlayList.MovieOpt";
					
					}
					else{
						for(var j=0;j<CountD;j++){
							temp+=temp1+"BackPlayList.BackListD.Movie"+j;
							temp1=",";
						}
						temp=temp+",BackPlayList.MovieOpt";
					}
					StaticMove(temp,StoreNameSelected,"Right");
				}
				else if(SelectLevel==3){
					var temp="";
					if(ArrowBar.ButtonLeft._visible){
						temp="ArrowBar.MovieLeft,BackPlayList1.MovieMode,BackPlayList1.MovieSort,ArrowBar.MovieRight"
					}
					else{
						temp="BackPlayList1.MovieMode,BackPlayList1.MovieSort"
					}
					StaticMove(temp,StoreNameSelected,"Right");
				}
				else if(SelectLevel==4){
					MoveAlbum("Right","Arrow");
				}
			}
		}
		else if(MainLevel==2){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Right");
			}
			else if(SelectLevel==3){
				if(ArrowBar.ButtonLeft._visible){
					var temp="ArrowBar.MovieLeft,ArtistMode.Movie,ArtistSorted.Movie,ArrowBar.MovieRight";
				}
				else var temp="ArtistMode.Movie,ArtistSorted.Movie";
				StaticMove(temp,StoreNameSelected,"Right");
			}
			else if(SelectLevel==4){
				MoveAlbum("Right","Arrow");
			}
		}
		else if(MainLevel==3){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Right");
			}
			else if(SelectLevel==3){
				var temp1="";
				var temp="";
				for (var j=0;j<CountVol;j++){
					temp+=temp1+"VolBar.Movie"+j;
					temp1=",";
				}
				if(VolBar.ButtonLeft._visible){
					temp="VolBar.MovieLeft,"+temp+",VolBar.MovieRight";
				}
				if(VolBar.ButtonArrowLeft._visible){
					temp="VolBar.MovieArrowLeft,"+temp+",VolBar.MovieArrowRight";
				}
				StaticMove(temp,StoreNameSelected,"Right");
			}
			else if(SelectLevel==4){
				MoveAlbum("Right","Vol");
			}
		}
		else if(MainLevel==4){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Right");
			}
			else if(SelectLevel==3){
				if(StoreNameSelected==String(TrackName + ".MovieLeft")){
					eval(TrackName).ButtonRight.onRollOver();
				}
				else if(StoreNameSelected==String(TrackName + ".MovieRight")){
					eval("BackAlbumPic.Button").onRollOver();
				}
				else if(StoreNameSelected=="BackAlbumPic.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button1.onRollOver();
					else eval(TrackName).BackStars.Button1.onRollOver();
					
				}
				else if(substring(StoreNameSelected,0,String(TrackName + ".Movie").length)==String(TrackName + ".Movie")){
					eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
					eval("BackAlbumPic.Button").onRollOver();
				}
			}
			else if(SelectLevel==4){
				if(RemoveAll._visible){
					StaticMove("RemoveAll.MovieCancel,RemoveAll.MovieOk",StoreNameSelected,"Right");
				}
				else if(StoreNameSelected=="ShowPlayer.Movie"){
					eval(TrackName).Button0.onRollOver();
				}
				else {
					var temp="";
					if(PlayListMode!="TrackTitle"){
						temp="PlayAll.Movie,ButtonPre.Movie,ButtonNext.Movie,ButtonBurch.Movie,ButtonCD.Movie,SlyShow.Movie,Refresh.Movie,ShowPlayer.Movie"
					}
					else{
						temp="PlayAll.Movie,ButtonUp.Movie,ButtonDown.Movie,DelOne.Movie,DelAll.Movie,SlyShow.Movie,Refresh.Movie,ShowPlayer.Movie"
					}
					StaticMove(temp,StoreNameSelected,"Right");
				}
			}
			else if(SelectLevel==9){//Right
				if(StoreNameSelected==TrackName + ".BackStars.Movie5"){
					eval(TrackName).BackStars.Back.onRollOut();
				}
				if(StoreNameSelected==TrackName + ".ScanAlbum.Movie"){
					BackAlbumPic.Button.onRollOver();
				}
				else{
					temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".ScanAlbum.Movie";
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
	function GoLeft(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			if(StoreNameSelected=="Menu.MISC.Movie")MenuMISC.UpdateDB.Button.onRollOver();
			return;
		}
		else if(SelectLevel==1){
			StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX",StoreNameSelected,"Left");
			return;
		}
		if(MainLevel==1){
			if(SortMaster._visible){
				if(SelectLevel==3){
					if(DeletePlayList._visible){
						StaticMove("DeletePlayList.MovieOk,DeletePlayList.MovieCancel",StoreNameSelected,"Left");
					}
					else if(Rename._visible){
						StaticMove("Rename.MovieKey,Rename.MovieOk,Rename.MovieCancel",StoreNameSelected,"Left");
					}
					else SortMaster.ButtonRename.Button.onRollOver();
				}
				else if(SelectLevel==4)SortMaster.Button0.onRollOver();
				else if(SelectLevel==6){
					if(CreateNew._visible){
						StaticMove("CreateNew.MovieKey,CreateNew.MovieOk,CreateNew.MovieCancel",StoreNameSelected,"Left");
					}
					else{
						if(StoreNameSelected=="SortMaster.ButtonUp.Movie"){
							SortMaster.BackAlbumPic.Button.onRollOver();
						}
						else{
							var temp="SortMaster.ButtonUp.Movie,SortMaster.ButtonDown.Movie,SortMaster.ButtonDel.Movie,SortMaster.ButtonNew.Movie,SortMaster.ButtonReName.Movie";
							StaticMove(temp,StoreNameSelected,"Left");
						}
					}
				}
			}
			else{
				if(SelectLevel==2){
					var temp="";
					var temp1="";
					if(BackPlayList.BackListD.ButtonLeft._visible){
						for(var j=0;j<CountD;j++){
							temp+=temp1+"BackPlayList.BackListD.Movie"+j;
							temp1=",";
						}
						temp="BackPlayList.BackListD.MovieLeft,"+temp+",BackPlayList.BackListD.MovieRight"+",BackPlayList.MovieOpt";
					}
					else{
						for(var j=0;j<CountD;j++){
							temp+=temp1+"BackPlayList.BackListD.Movie"+j;
							temp1=",";
						}
						temp=temp+",BackPlayList.MovieOpt";
					}
					StaticMove(temp,StoreNameSelected,"Left");
				}
				else if(SelectLevel==3){
					var temp="";
					if(ArrowBar.ButtonLeft._visible){
						temp="ArrowBar.MovieLeft,BackPlayList1.MovieMode,BackPlayList1.MovieSort,ArrowBar.MovieRight"
					}	
					else{
						temp="BackPlayList1.MovieMode,BackPlayList1.MovieSort"
					}
					StaticMove(temp,StoreNameSelected,"Left");
				}
				else if(SelectLevel==4){
					MoveAlbum("Left","Arrow");
				}
			}
		}
		else if(MainLevel==2){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Left");
			}
			else if(SelectLevel==3){
				if(ArrowBar.ButtonLeft._visible){
					temp="ArrowBar.MovieLeft,ArtistMode.Movie,ArtistSorted.Movie,ArrowBar.MovieRight";
					
				}
				else temp="ArtistMode.Movie,ArtistSorted.Movie";
				StaticMove(temp,StoreNameSelected,"Left");
			}
			else if(SelectLevel==4){
				MoveAlbum("Left","Arrow");
			}
		}
		else if(MainLevel==3){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Left");
			}
			else if(SelectLevel==3){
				var temp1="";
				var temp="";
				for (var j=0;j<CountVol;j++){
					temp+=temp1+"VolBar.Movie"+j;
					temp1=",";
				}
				if(VolBar.ButtonLeft._visible){
					temp="VolBar.MovieLeft,"+temp+",VolBar.MovieRight";
				}
				if(VolBar.ButtonArrowLeft._visible){
					temp="VolBar.MovieArrowLeft,"+temp+",VolBar.MovieArrowRight";
				}
				StaticMove(temp,StoreNameSelected,"Left");

			}
			else if(SelectLevel==4){
				MoveAlbum("Left","Vol");
			}
		}
		else if(MainLevel==4){
			if(SelectLevel==2){
				MoveLeftRight("BackListP",StoreNameSelected,CountP,"Left");
			}
			else if(SelectLevel==3){
				if(StoreNameSelected==String(TrackName + ".MovieLeft")){
					eval(TrackName).ButtonRight.onRollOver();
				}
				else if(StoreNameSelected==String(TrackName + ".MovieRight")){
					eval(TrackName).ButtonLeft.onRollOver();
				}
				else if(StoreNameSelected=="BackAlbumPic.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button5.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}
				else if(substring(StoreNameSelected,0,String(TrackName + ".Movie").length)==String(TrackName + ".Movie")){
					if(eval(TrackName).ButtonRight._visible){
						//eval("BackAlbumPic.Button").onRollOver();
						eval(TrackName + ".Button"+(IndexTrack%nTrack)).onRollOut();
						eval(TrackName).ButtonRight.onRelease();
						eval(TrackName).Button0.onRollOver();
					}
				}
			}
			else if(SelectLevel==4){
				if(RemoveAll._visible){
					StaticMove("RemoveAll.MovieCancel,RemoveAll.MovieOk",StoreNameSelected,"Left");
				}
				else if(StoreNameSelected=="PlayAll.Movie"){
					if(BackAlbumInfo._visible)BackAlbumInfo.BackStars.Button5.onRollOver();
					else eval(TrackName).Button0.onRollOver();
				}
				else {
					var temp="";
					if(PlayListMode!="TrackTitle"){
						temp="PlayAll.Movie,ButtonPre.Movie,ButtonNext.Movie,ButtonBurch.Movie,ButtonCD.Movie,SlyShow.Movie,Refresh.Movie,ShowPlayer.Movie"
					}
					else{
						temp="PlayAll.Movie,ButtonUp.Movie,ButtonDown.Movie,DelOne.Movie,DelAll.Movie,SlyShow.Movie,Refresh.Movie,ShowPlayer.Movie"
					}
					StaticMove(temp,StoreNameSelected,"Left");
				}
			}
			else if(SelectLevel==9){//Left
				if(StoreNameSelected==TrackName + ".BackStars.Movie1"){
					eval(TrackName).BackStars.Back.onRollOut();
					eval(TrackName).Button0.onRollOver();
				}
				else {
					temp=TrackName + ".BackStars.Movie1," + TrackName + ".BackStars.Movie2," + TrackName + ".BackStars.Movie3," + TrackName + ".BackStars.Movie4," + TrackName + ".BackStars.Movie5," + TrackName + ".RefreshCoverArt.Movie," + TrackName + ".PathSlideshow.Movie," + TrackName + ".MusicNote.Movie," + TrackName + ".ScanAlbum.Movie";
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
	function GoUp(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			if(MenuLevel==1){
				//StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Left");
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
			return;
		}
		if(MainLevel==1){
			if(SortMaster._visible){
				if(SelectLevel==3){
					if(StoreNameSelected=="SortMaster.Movie0"){
						TopBar.ButtonM.onRollOver();
					}
					else MoveLeftRight("SortMaster",StoreNameSelected,CountSortMaster,"Left");
				}
				else if(SelectLevel==4){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==6){
					SortMaster.BackAlbumPic.Button.onRollOver();
				}
				
			}
			else{
				if(SelectLevel==2){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="MenuMode.Track.Movie"){
						BackPlayList1.ButtonMode.onRollOver();
						//MenuMode._visible=false;
					}
					else if(substring(StoreNameSelected,0,"MenuMode".length)=="MenuMode"){
						var temp="MenuMode.Track.Movie,MenuMode.Album.Movie,MenuMode.Artist.Movie,MenuMode.Default.Movie";
						StaticMove(temp,StoreNameSelected,"Left");
					}
					else{
						TopBar.ButtonM.onRollOver();
					}
				}	
				else if(SelectLevel==4){
					MoveAlbum("Up","Arrow");
				}
			}
		}
		else if(MainLevel==2){
				if(SelectLevel==2){
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==3) {
					TopBar.ButtonM.onRollOver();
				}
				else if(SelectLevel==4){
					MoveAlbum("Up","Arrow");
				}
		}
		else if(MainLevel==3){
			if(SelectLevel==2){
				TopBar.ButtonM.onRollOver();
			}
			else if(SelectLevel==3) {
				TopBar.ButtonM.onRollOver();
			}
			else if(SelectLevel==4){
				MoveAlbum("Up","Vol");
			}
		}
		else if(MainLevel==4){
			if(SelectLevel==2){
				TopBar.ButtonM.onRollOver();
			}
			if(SelectLevel==3){
				if(StoreNameSelected==TrackName + ".Movie0" || StoreNameSelected=="BackAlbumPic.Movie"){
					eval(TrackName).Button0.onRollOut();
					TopBar.ButtonM.onRollOver();
				}
				else{ 
					eval(TrackName + ".Button"+GetNumber(StoreNameSelected)).onRollOut();
					MoveLeftRight(TrackName,StoreNameSelected,eval("Count"+TrackObj),"Left");
				}
			}
			else if(SelectLevel==4){
				if(!RemoveAll._visible){
					if(StoreNameSelected=="SlyShow.Movie"){
						PlayAll.Button.onRollOver();
					}
					else if(StoreNameSelected=="Refresh.Movie"){
						SlyShow.Button.onRollOver();
					}
					else if(StoreNameSelected=="ShowPlayer.Movie"){
						Refresh.Button.onRollOver();
					}
					else{
						eval("BackAlbumPic.Button").onRollOver();
					}
				}
			}
			else if(SelectLevel==9){
				TopBar.ButtonM.onRollOver();
			}
			else if(SelectLevel==10){
				TopBar.ButtonM.onRollOver();
			}
		}
	}
	function GoDown(){
		fscommand("mouse_off_screen",true);
		if(SelectLevel==5){
			if(MenuLevel==1){
				//StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie",StoreNameSelected,"Right");
				StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie",StoreNameSelected,"Right");
			}
			else StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie",StoreNameSelected,"Right");
			return;
		}
		if(MainLevel==1){
			if(SortMaster._visible){
				if(SelectLevel==1){
					if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
						eval("Menu.AboutSly.Button").onRollOver();
					}
					else if(SortMaster.Button0._visible){
						SortMaster.Button0.onRollOver();
					}
				}
				else if(SelectLevel==3){
					MoveLeftRight("SortMaster",StoreNameSelected,CountSortMaster,"Right");
				}
				else if(SelectLevel==4){
					SortMaster.ButtonUp.Button.onRollOver();
				}
				else if(SelectLevel==6){
					SortMaster.BackAlbumPic.Button.onRollOver();
				}
			}
			else{
				if(SelectLevel==1){
					if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
						eval("Menu.AboutSly.Button").onRollOver();
					}
					else if(BackPlayList._visible){
						if(BackPlayList.BackListD.Button0._visible){
							BackPlayList.BackListD.Button0.onRollOver();
						}
						else{
							BackPlayList.ButtonOpt.onRollOver();
						}
					}
					else{
						if(BackPlayList1.ButtonMode._visible){
							BackPlayList1.ButtonMode.onRollOver();
						}
					}
				}
				else if(SelectLevel==2){
					if(BackPlayList1.ButtonMode._visible){
						BackPlayList._visible=false;
						BackPlayList1.ButtonMode.onRollOver();
					}
				}
				else if(SelectLevel==3){
					if(StoreNameSelected=="BackPlayList1.MovieMode" && MenuMode._visible){
						MenuMode.Track.Button.onRollOver();
					}
					else if(substring(StoreNameSelected,0,"MenuMode".length)=="MenuMode"){
						var temp="MenuMode.Track.Movie,MenuMode.Album.Movie,MenuMode.Artist.Movie,MenuMode.Default.Movie";
						StaticMove(temp,StoreNameSelected,"Right");
					}
					else{
						if(eval(NameAlbum+".Button0")._visible){
							eval(NameAlbum+".Button0").onRollOver();
						}
					}
				}
				else if(SelectLevel==4){
					MoveAlbum("Down","Arrow");
				}
			}
		}	
		else if(MainLevel==2){
			if(SelectLevel==1){
				if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
					eval("Menu.AboutSly.Button").onRollOver();
				}
			}
			if(SelectLevel==1){
					if(BackListP._visible){
						BackListP.Button0.onRollOver();
					}
					else{
						ArtistMode.Button.onRollOver();
					}
			}
			else if(SelectLevel==2){
				BackListP._visible=false;
				ArtistMode.Button.onRollOver();
			}
			else if(SelectLevel==3) {
				if(eval(NameAlbum+".Button0")._visible){
					eval(NameAlbum+".Button0").onRollOver();
				}
			}
			else if(SelectLevel==4){
				MoveAlbum("Down","Arrow");
			}
		}
		else if(MainLevel==3){
			if(SelectLevel==1){
				if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
					eval("Menu.AboutSly.Button").onRollOver();
				}
			}
			if(SelectLevel==1){
					if(BackListP._visible){
						BackListP.Button0.onRollOver();
					}
					else{
						if(VolBar.Button0._visible)VolBar.Button0.onRollOver();
					}
			}
			else if(SelectLevel==2){
				BackListP._visible=false;
				VolBar.Button0.onRollOver();
			}
			else if(SelectLevel==3) {
				if(eval(NameAlbum+".Button0")._visible){
					eval(NameAlbum+".Button0").onRollOver();
				}
			}
			else if(SelectLevel==4){
				MoveAlbum("Down","Vol");
			}
		}
		else if(MainLevel==4){
			if(SelectLevel==1){
				if(StoreNameSelected=="TopBar.MovieX" && Menu._visible){
					eval("Menu.AboutSly.Button").onRollOver();
				}
				else if(!BackListP._visible ){
					if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
						eval(TrackName).Button0.onRollOver();
					}
					else if(BackAlbumInfo._visible){
						BackAlbumInfo.BackStars.Button1.onRollOver();
					}
				}
				else{
					BackListP.Button0.onRollOver();
				}
			}
			else if(SelectLevel==2){
				if(eval(TrackName).Button0._visible && eval(TrackName)._visible){
					eval(TrackName).Button0.onRollOver();
					BackListP._visible=false;
				}
				else if(BackAlbumInfo._visible){
					BackAlbumInfo.BackStars.Button1.onRollOver();
					BackListP._visible=false;
				}
			}
			else if(SelectLevel==3){
				if(StoreNameSelected=="BackAlbumPic.Movie"){
					eval("PlayAll.Button").onRollOver();
				}
				else{
					eval(TrackName + ".Button"+GetNumber(StoreNameSelected)).onRollOut();
					MoveLeftRight(TrackName,StoreNameSelected,eval("Count"+TrackObj),"Right");
				}
			}
			else if(SelectLevel==4){
				if(!RemoveAll._visible){
					if(StoreNameSelected=="SlyShow.Movie"){
						Refresh.Button.onRollOver();
					}
					else if(StoreNameSelected=="Refresh.Movie"){
						ShowPlayer.Button.onRollOver();
					}
					else if(StoreNameSelected=="ShowPlayer.Movie"){
						eval("BackAlbumPic.Button").onRollOver();	
					}
					else{
						SlyShow.Button.onRollOver();
					}
				}
			}
			else if(SelectLevel==9){
				eval("BackAlbumPic.Button").onRollOver();	
			}
		}
	}
	
}

function SelecteListItemUp(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index>0) {
		SelectButton(Str+(Index-1));
	} else {
		SelectButton(Str+(TotalIndex-1));
	}
}
function SelecteListItemDown(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index<TotalIndex-1) {
		SelectButton(Str+(Index+1));
	} else {
		SelectButton(Str+"0");
	}
}
function Escape(){
	if(WarningUpdate._visible){
		WarningUpdate.ButtonCancel.onRelease();
	}
	else if(UpdateDB._visible){
		UpdateDB.ButtonCancel.onRelease();
	}
	else if(AddNewScreens._visible){
		AddNewScreens.ButtonCancel.onRelease();
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
	else if(Rename._visible){
		Rename.ButtonCancel.onRelease();
	}
	else if(DeletePlayList._visible){
		DeletePlayList.ButtonCancel.onRelease();
	}
	else if(CreateNew._visible){
		CreateNew.ButtonCancel.onRelease();
	}
	else if(RemoveAll._visible){
		RemoveAll.ButtonCancel.onRelease();
	}
}


function MoveAlbum(Move,Obj){
	if(Move=="Right"){
		var Index=GetNumber(StoreNameSelected)
		if(DisplayAlbumLong=="true"){
			Index+=eval(NameAlbum).rows;
		}else{
			Index+=1;
		}
		
		if(Obj=="Vol")Count=StoreCountVol1;
		else Count=CountArrow;
		if(Index<=Count-1){
			eval(NameAlbum+".Button"+Index).onRollOver();
		}
		else{
			eval(NameAlbum+".Button"+0).onRollOver();
			if(Obj=="Vol"){
				if(VolBar.ButtonArrowRight._visible)VolBar.ButtonArrowRight.onRelease();
			}
			else{
				if(ArrowBar.ButtonRight._visible)ArrowBar.ButtonRight.onRelease();
			}
		}
	}
	else if(Move=="Left"){
				var Index=GetNumber(StoreNameSelected);
				if(DisplayAlbumLong=="true"){
					Index-=eval(NameAlbum).rows;
				}else{
					Index-=1;
				}
				if(Index>=0){
					//SelectButton(NameAlbum+".Movie"+Index);
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					if(Obj=="Vol"){
						if(VolBar.ButtonArrowLeft._visible)VolBar.ButtonArrowLeft.onRelease();
						eval(NameAlbum+".Button"+(StoreCountVol1-1)).onRollOver();
					}
					else{
						if(ArrowBar.ButtonLeft._visible)ArrowBar.ButtonLeft.onRelease();
						eval(NameAlbum+".Button"+(CountArrow-1)).onRollOver();
					}
				}
	}
	else if(Move=="Down"){
		if(DisplayAlbumLong=="true"){
			var Index=GetNumber(StoreNameSelected)
			Index+=1;
			if(Obj=="Vol")Count=StoreCountVol1;
			else Count=CountArrow;
			if(Index<=Count-1){
				//SelectButton(NameAlbum+".Movie"+Index);
				eval(NameAlbum+".Button"+Index).onRollOver();
			}
			else{
				//SelectButton(NameAlbum+".Movie"+0);
				eval(NameAlbum+".Button"+0).onRollOver();
				if(Obj=="Vol"){
					if(VolBar.ButtonArrowRight._visible)VolBar.ButtonArrowRight.onRelease();
				}
				else{
					if(ArrowBar.ButtonRight._visible)ArrowBar.ButtonRight.onRelease();
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
				var Index=GetNumber(StoreNameSelected);
				Index-=1;
				if(Index>=0){
					//SelectButton(NameAlbum+".Movie"+Index);
					eval(NameAlbum+".Button"+Index).onRollOver();
				}
				else{
					if(MainLevel==1){
						BackPlayList1.ButtonMode.onRollOver();
					}
					else if(MainLevel==2){
						ArtistMode.Button.onRollOver();
					}
					else if(MainLevel==3){
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
				if(MainLevel==1){
					BackPlayList1.ButtonMode.onRollOver();
				}
				else if(MainLevel==2){
					ArtistMode.Button.onRollOver();
				}
				else if(MainLevel==3){
					VolBar.Button0.onRollOver();
				}
			}
		}
	}
}
//--------------------------------------------------------------------------------------
function press_space_bar(){
	if (send_event("normal&&&function||press_space_bar||3",false)){
		return;
	}
	fscommand("popup",true);
}
//--------------------------------------------------------------------------------------
function combine_key1(){
	if (send_event("normal&&&function||combine_key1||3",false)){
		return;
	}
	fscommand("KeyPressed","");
}
//--------------------------------------------------------------------------------------
function combine_key2(KeyCode){
	KeyCode = int(KeyCode);
	if (send_event("normal&&&function||combine_key2|~|" +  KeyCode + "||3",false)){
		return;
	}
	if(KeyCode==KeySlide){//~
		if(SlideShowValue=="Yes"){
			DisplayTooltip(eval("TopBar.ButtonM"),"txtTooltip","Set SlideShow (OFF)",SHTT,-(96/2)+5,20,true);
			SlideShowValue="No";
		}
		else{
			DisplayTooltip(eval("TopBar.ButtonM"),"txtTooltip","Set SlideShow (ON)",SHTT,-(96/2)+5,20,true);
			SlideShowValue="Yes";
		}
		fscommand("SetSlideShowOnOff",SlideShowValue);
	}
	else if(KeyCode==KeyAlbumCover ){//1
		var AlbumCover1=AlbumCover;
		if(AlbumCover1=="Yes")AlbumCover1="No";
		else AlbumCover1="Yes";
		fscommand("CtrlPlus","1~"+AlbumCover1);
	}
	else if(KeyCode==KeyMin ){
		HideMenu();
//		fscommand("Minimize");
	}
	else if(KeyCode==KeyNumCover ){//2
		var NumCover1=NumCover;
		if(NumCover1=="Yes")NumCover1="No";
		else NumCover1="Yes";
		fscommand("CtrlPlus","2~"+NumCover1);
	}
	else if(KeyCode==KeyPlusCover ){//3
		var PlusCover1=PlusCover;
		if(PlusCover1=="Yes")PlusCover1="No";
		else PlusCover1="Yes";
		fscommand("CtrlPlus","3~"+PlusCover1);
	}
	else if(KeyCode==71){//G
		fscommand("CtrlPlus","G~0");
	}
	else if(KeyCode==220 ){//.....|\
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
	else if(KeyCode==74 && eval(NameAlbum)._visible){//J
		var temp="Large";
		switch(NumMovie){
			case nLarge:
					temp="Medium";break;
			case nMedium:
					temp="Small";break;
			case nSmall:
					temp="Large";break;
			case nLarges:
					temp="Medium";break;
			case nMediums:
					temp="Small";break;
			case nSmalls:
					temp="Large";break;
		}
		fscommand("CtrlPlus","J~"+temp);
	}
	else if(KeyCode==75){//K
		fscommand("CtrlPlus","K~true");
	}
/*	else if(KeyCode==87){//W
		fscommand("CtrlPlus","W~0");
	}*/
	//.........................................
	else if(KeyCode==keyHideMouse){
		if(HideMouse=="true"){
			Mouse.show();
//					ButtonHideMouse._visible=false;
			HideMouse="false";
		}
		else{
			Mouse.hide();
//					ButtonHideMouse._visible=true;
			HideMouse="true";
		}
		fscommand("setHideMouse",HideMouse);
	}
	else if(KeyCode==85){
		//TopBar.ButtonFull.onRollOver();
		fscommand("FullScreenPlayer");//U
	}
	else if(KeyCode==84){
		fscommand("Visualization");
	}
	else if(KeyCode==83){
		TopBar.ButtonS.onRollOver();//S
		TopBar.ButtonS.onRelease();//S
	}
	else if(KeyCode==KeyPlayer){
		TopBar.ButtonP.onRollOver();//P
		TopBar.ButtonP.onRelease();//P
	}
	else if(KeyCode==77){
		TopBar.ButtonM.onRollOver()
		TopBar.ButtonM.onRelease();//M
	}
	else if(KeyCode==KeyLanguage){
		TopBar.ButtonC.onRollOver();//y
		TopBar.ButtonC.onRelease();//y
	}
	else if(KeyCode==79){
		TopBar.ButtonO.onRollOver();//O
		TopBar.ButtonO.onRelease();//O
	}
	else if(KeyCode==69){
		TopBar.ButtonL.onRollOver()
		TopBar.ButtonL.onRelease();//E
	}
	else if(KeyCode==68){
		TopBar.ButtonX.onRollOver()
		TopBar.ButtonX.onRelease();//E
	}
	else if(KeyCode==72){//playlist/h
		if (MainLevel==1)BackPlayList.ButtonOpt.onRelease();
	}
	else if(KeyCode==78){//dir/n
		if (MainLevel==1)BackPlayList1.ButtonSort.onRelease();
	}
}