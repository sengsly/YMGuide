//BackCountry.MovieAutoClientConnect,BackCountry.MovieAutoDisplayAndPlayback,BackCountry.MovieAutoPlayback,BackCountry.MovieAutoIndependent,BackCountry.MovieAutoRemoteControl
someListenerKeyUp = new Object();
someListenerKeyUp.onKeyUp = function() {
  if (Key.getCode() == 17) {
    CtrlKey = false;
  }
};
Key.removeListener(someListenerKeyUp);
Key.addListener(someListenerKeyUp);
//...................
Option_Listener = new Object();
Option_Listener.onMouseDown = function() {
  fscommand("KeyPressed", "MouseDown");
};
Mouse.removeListener(Option_Listener);
Mouse.addListener(Option_Listener);
//...........................
someListener1 = new Object();
someListener1.onKeyDown = function() {
  if (selection.getFocus() == null || String(selection.getFocus()) == "_level0.GetFocus") {
    if (UpdateDB._visible || RestoreDB._visible || CopyMusic._visible || BackUpDB._visible || AddNewScreens._visible || WarningUpdate._visible) {
      fscommand("KeyPressed");
      if (Key.getCode() == 39) {
        if (WarningUpdate._visible) {
          StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel", StoreNameSelected, "Right");
        }else if (UpdateDB._visible) {
          if (updateDB.txtCancel.text == "No") {
            StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel", StoreNameSelected, "Right");
          }
        } else if (AddNewScreens._visible) {
          ArrowKeyScreen("Right");
        } else if (RestoreDB._visible) {
          StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Right");
        } else if (CopyMusic._visible) {
          StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Right");
        } else if (BackUpDB._visible) {
          StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Right");
        }
      } else if (Key.getCode() == 37) {
        if (WarningUpdate._visible) {
          StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel", StoreNameSelected, "Left");
        } else if (UpdateDB._visible) {
          if (updateDB.txtCancel.text == "No") {
            StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel", StoreNameSelected, "Left");
          }
        } else if (AddNewScreens._visible) {
          ArrowKeyScreen("Left");
        } else if (RestoreDB._visible) {
          StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Left");
        } else if (CopyMusic._visible) {
          StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Left");
        } else if (BackUpDB._visible) {
          StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Left");
        }
      } else if (Key.getCode() == 38) {
        if (RestoreDB._visible) {
          StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Left");
        } else if (AddNewScreens._visible) {
          ArrowKeyScreen("Left");
        } else if (CopyMusic._visible) {
          StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Left");
        } else if (BackUpDB._visible) {
          StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Left");
        }
      } else if (Key.getCode() == 40) {
        if (RestoreDB._visible) {
          StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Right");
        } else if (AddNewScreens._visible) {
          ArrowKeyScreen("Right");
        } else if (CopyMusic._visible) {
          StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Right");
        } else if (BackUpDB._visible) {
          StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Right");
        }
      } else if (Key.getCode() == 13) {
        PressKeyBoard(Key.getCode());
      }
    } else {
      PressKeyBoard(Key.getCode());
    }
  } else {
    if(Selection.getFocus()!=null){
      if (Key.isDown(Key.ENTER)){
        Selection.setFocus(null);
      }
    }
  }
};

function press_space_bar(){
  if (send_event("normal&&&function||press_space_bar||6",false)){
    return;
  }
  fscommand("popup",true);
}

var KeyCode = false;
function PressKeyBoard(KeyCode) {
  if (KeyCode == 39) {
    fscommand("offScreen", true);
    CtrlKey = false;
    GoRight();
    fscommand("KeyPressed");
  } else if (KeyCode == 32) {
    press_space_bar();
  } else if (KeyCode == 37) {
    fscommand("offScreen", true);
    CtrlKey = false;
    GoLeft();
    fscommand("KeyPressed");
  } else if (KeyCode == 40) {
    fscommand("offScreen", true);
    CtrlKey = false;
    GoDown();
    fscommand("KeyPressed");
  } else if (KeyCode == 38) {
    fscommand("offScreen", true);
    CtrlKey = false;
    GoUp();
    fscommand("KeyPressed");
  } else if (KeyCode == 13) {
    fscommand("KeyPressed");
    CtrlKey = false;
    eval(Replace(StoreNameSelected, "Movie", "Button")).onRelease();
  } else if (KeyCode == 17) {
    CtrlKey = true;
    fscommand("KeyPressed");
  } else {
    if (CtrlKey) {
      fscommand("KeyPressed");
      if (KeyCode == 85) {
        //TopBar.ButtonFull.onRollOver();
        fscommand("FullScreenPlayer");
        //U
      } else if (KeyCode == 191) {
        //Menu.Min.Button.onRelease();
      } else if (KeyCode == 192) {
        BackSlideShow.ButtonSetSlideShow.onRelease();
      } else if (KeyCode == 83) {
        TopBar.ButtonS.onRollOver();
        //S
        TopBar.ButtonS.onRelease();
        //S
      } else if (KeyCode == 80) {
        TopBar.ButtonP.onRollOver();
        //P
        TopBar.ButtonP.onRelease();
        //P
      } else if (KeyCode == 77) {
        TopBar.ButtonM.onRollOver();
        TopBar.ButtonM.onRelease();
        //M
      } else if (KeyCode == KeyLanguage) {
        TopBar.ButtonC.onRollOver();
        //y
        TopBar.ButtonC.onRelease();
        //y
      } else if (KeyCode == 79) {
        TopBar.ButtonO.onRollOver();
        //O
        TopBar.ButtonO.onRelease();
        //O
      } else if (KeyCode == 69) {
        TopBar.ButtonL.onRollOver();
        TopBar.ButtonL.onRelease();
        //E
      } else if (KeyCode == 68) {
        TopBar.ButtonX.onRollOver();
        TopBar.ButtonX.onRelease();
        //E
      } else if (KeyCode == 114) {
        BackTheme.ButtonMouse.onRollOver();
        BackTheme.ButtonMouse.onRelease();
      } else if (KeyCode == 49) {
        BackAlbum.ButtonCover.onRollOver();
        BackAlbum.ButtonCover.onRelease();
      } else if (KeyCode == 50) {
        BackAlbum.ButtonCoverNum.onRollOver();
        BackAlbum.ButtonCoverNum.onRelease();
      } else if (KeyCode == 220) {
        if (BackAlbum.ButtonAlbumList.Selected._visible) {
          BackAlbum.ButtonAlbumIcon.onRollOver();
          BackAlbum.ButtonAlbumIcon.onRelease();
        } else {
          BackAlbum.ButtonAlbumList.onRollOver();
          BackAlbum.ButtonAlbumList.onRelease();
        }
      } else if (KeyCode == 51) {
        BackAlbum.ButtonCoverPlus.onRollOver();
        BackAlbum.ButtonCoverPlus.onRelease();
      } else if (KeyCode == 71) {
        //g
        if (BackAlbum.ButtonGroupAlbumType.Selected._visible) {
          BackAlbum.ButtonAllAlbumType.onRollOver();
          BackAlbum.ButtonAllAlbumType.onRelease();
        } else {
          BackAlbum.ButtonGroupAlbumType.onRollOver();
          BackAlbum.ButtonGroupAlbumType.onRelease();
        }
      } else if (KeyCode == 74) {
        //j
        BackAlbum.ButtonAlbumNum.onRollOver();
        BackAlbum.ButtonAlbumNum.onRelease();
      } else if (KeyCode == 75) {
        //k
        BackRipAndPlay.ButtonMicro.onRollOver();
        BackRipAndPlay.ButtonMicro.onRelease();
      }/* else if (KeyCode == 87) {
        //
        BackTheme.ButtonWinMode.onRollOver();
        BackTheme.ButtonWinMode.onRelease();
      } */else if (KeyCode == 84) {
        //k
        fscommand("Visualization");
      }
      //CtrlKey=false;
    } else {
      if ((KeyCode == 188 || KeyCode == 8) && Selection.getFocus() == null) {
        if (ColorPicker._visible == true) {
          hideColorPicker();
          eval(Replace(StoreNameSelected, "Movie", "Button")).onRollOver();
        } else {
          TopBar.ButtonB.onRollOver();
          TopBar.ButtonB.onRelease();
        }
      }
    }
  }
  //........................
  function GoRight() {
    fscommand("mouse_off_screen",true);
    if (LevelSelect == 1) {
      StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX", StoreNameSelected, "Right");
    } else if (LevelSelect == 2) {
      StaticMove("Bar.MovieTheme,Bar.MovieAlbum,Bar.MovieCountry,Bar.MovieSlideShow,Bar.MovieProFile,Bar.MovieRipAndPlay", StoreNameSelected, "Right");
    } else if (LevelSelect == 3) {
      //BackTheme keyboard......
      if (BackTheme.MovieMonitor._visible == true) {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MovieMonitor,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Right");
      } else {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 4) {
      // BackSlideShow..........
      StaticMove("BackSlideShow.MovieDir,BackSlideShow.MovieSetSlideShow,BackSlideShow.MovieSyn,BackSlideShow.MovieResize,BackSlideShow.MovieAllowSlideshow,BackSlideShow.MovieInSlide,BackSlideShow.MovieExSlide,BackSlideShow.MovieStretch,BackSlideShow.MovieShow,BackSlideShow.MovieEffect,BackSlideShow.MovieScroll,BackSlideShow.MovieRandom", StoreNameSelected, "Right");
    } else if (LevelSelect == 5) {
      //BackPlaylist...............
      StaticMove("BackPlayList.MovieDir,BackPlayList.MovieAdd,BackPlayList.MovieRemove,BackPlayList.MovieImage1,BackPlayList.MovieImage2", StoreNameSelected, "Right");
    } else if (LevelSelect == 6) {
      MenuMISC._visible = false;
      Menu.MISC.Button.onRollOver();
    } else if (LevelSelect == 7) {
      //BackAlbum.........
      if(BackAlbum.ButtonAlbumIcon.Selected._visible){
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Right");
      }else{
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.subList.Movie_subList_production,BackAlbum.subList.Movie_subList_actor,BackAlbum.subList.Movie_subList_director,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 8) {
      //Backcountry.........
      StaticMove("BackCountry.MovieOptDefault,BackCountry.MovieOptCountry,BackCountry.MovieCountry,BackCountry.MovieOptLogin,BackCountry.MovieOptPlaylist,BackCountry.MovieOptSearch,BackCountry.MovieOptPlayer,BackCountry.MovieOptFullScreen,BackCountry.MovieOptMicro,BackCountry.MovieOptAutoClientConnect,BackCountry.MoviePlay,BackCountry.MovieShowPlayer,BackCountry.MovieFriendPlaylist,BackCountry.MovieLocalLink,BackCountry.fileType.Movie,BackCountry.MovieBrowse,BackCountry.MovieBrowseCoverArt,BackCountry.MovieBrowseMplayer,BackCountry.MovieSave,BackCountry.remote.BrowsePath.MovieBrowse,BackCountry.remote.first_remote.MovieSet", StoreNameSelected, "Right");
    } else if (LevelSelect == 9) {
      //BackRipAndPlay.........
      StaticMove("BackRipAndPlay.MovieMicro,BackRipAndPlay.MovieOffset,BackRipAndPlay.MovieAutoPlay,BackRipAndPlay.txtVLCExtension,BackRipAndPlay.MovieSingerSong,BackRipAndPlay.MovieAutoPlayMPC,BackRipAndPlay.MovieSyn_vol,BackRipAndPlay.MovieChange_vol,BackRipAndPlay.MovieSmall,BackRipAndPlay.MovieLarge,BackRipAndPlay.MovieTrackTitleStyle,BackRipAndPlay.MovieProgram,BackRipAndPlay.MovieTop,BackRipAndPlay.MovieBottom,BackRipAndPlay.MovieOld,BackRipAndPlay.MovieNew,BackRipAndPlay.MovieMicroScale,BackRipAndPlay.MovieVideo,BackRipAndPlay.MovieTurnOff,BackRipAndPlay.MovieTurnOn,BackRipAndPlay.MovieLocal,BackRipAndPlay.MovieStream,BackRipAndPlay.Moviechaptertrack,BackRipAndPlay.Movieendtrack,BackRipAndPlay.MovieCloneAndDisplay,BackRipAndPlay.MovieCloneOnly,BackRipAndPlay.MovieIndependent,BackRipAndPlay.MovieremoteControl,BackRipAndPlay.MovieWinamp,BackRipAndPlay.MovieWmp,BackRipAndPlay.MoviePowerDVD,BackRipAndPlay.MovieBrowseFolder,BackRipAndPlay.txtDaemonDrive,BackRipAndPlay.MovieResize,BackRipAndPlay.MovieRealTime,BackRipAndPlay.MovieHigh,BackRipAndPlay.MovieAboveNormal,BackRipAndPlay.MovieNormal,BackRipAndPlay.MovieBelowNormal,BackRipAndPlay.MovieLow", StoreNameSelected, "Right");
    }
  }
  function GoLeft() {
    fscommand("mouse_off_screen",true);
    if (LevelSelect == 1) {
      StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX", StoreNameSelected, "Left");
    } else if (LevelSelect == 2) {
      StaticMove("Bar.MovieTheme,Bar.MovieAlbum,Bar.MovieCountry,Bar.MovieSlideShow,Bar.MovieProFile,Bar.MovieRipAndPlay", StoreNameSelected, "Left");
    } else if (LevelSelect == 3) {
      if (BackTheme.MovieMonitor._visible == true) {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MovieMonitor,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Left");
      } else {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 4) {
      StaticMove("BackSlideShow.MovieDir,BackSlideShow.MovieSetSlideShow,BackSlideShow.MovieSyn,BackSlideShow.MovieResize,BackSlideShow.MovieAllowSlideshow,BackSlideShow.MovieInSlide,BackSlideShow.MovieExSlide,BackSlideShow.MovieStretch,BackSlideShow.MovieShow,BackSlideShow.MovieEffect,BackSlideShow.MovieScroll,BackSlideShow.MovieRandom", StoreNameSelected, "Left");
    } else if (LevelSelect == 5) {
      StaticMove("BackPlayList.MovieDir,BackPlayList.MovieAdd,BackPlayList.MovieRemove,BackPlayList.MovieImage1,BackPlayList.MovieImage2", StoreNameSelected, "Left");
    } else if (LevelSelect == 6) {
      if (StoreNameSelected == "Menu.MISC.Movie") {
        MenuMISC.UpdateDB.Button.onRollOver();
      }
    } else if (LevelSelect == 7) {
      //BackAlbum.........
      if(BackAlbum.ButtonAlbumIcon.Selected._visible){
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Left");
      }else{
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.subList.Movie_subList_production,BackAlbum.subList.Movie_subList_actor,BackAlbum.subList.Movie_subList_director,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 8) {
      //Backcountry.........
      StaticMove("BackCountry.MovieOptDefault,BackCountry.MovieOptCountry,BackCountry.MovieCountry,BackCountry.MovieOptLogin,BackCountry.MovieOptPlaylist,BackCountry.MovieOptSearch,BackCountry.MovieOptPlayer,BackCountry.MovieOptFullScreen,BackCountry.MovieOptMicro,BackCountry.MovieOptAutoClientConnect,BackCountry.MoviePlay,BackCountry.MovieShowPlayer,BackCountry.MovieFriendPlaylist,BackCountry.MovieLocalLink,BackCountry.fileType.Movie,BackCountry.MovieBrowse,BackCountry.MovieBrowseCoverArt,BackCountry.MovieBrowseMplayer,BackCountry.MovieSave,BackCountry.remote.BrowsePath.MovieBrowse,BackCountry.remote.first_remote.MovieSet", StoreNameSelected, "Left");
    } else if (LevelSelect == 9) {
      //BackRipAndPlay.........
      StaticMove("BackRipAndPlay.MovieMicro,BackRipAndPlay.MovieOffset,BackRipAndPlay.MovieAutoPlay,BackRipAndPlay.MovieSingerSong,BackRipAndPlay.MovieAutoPlayMPC,BackRipAndPlay.MovieSyn_vol,BackRipAndPlay.MovieChange_vol,BackRipAndPlay.MovieSmall,BackRipAndPlay.MovieLarge,BackRipAndPlay.MovieTrackTitleStyle,BackRipAndPlay.MovieProgram,BackRipAndPlay.MovieTop,BackRipAndPlay.MovieBottom,BackRipAndPlay.MovieOld,BackRipAndPlay.MovieNew,BackRipAndPlay.MovieMicroScale,BackRipAndPlay.MovieVideo,BackRipAndPlay.MovieTurnOff,BackRipAndPlay.MovieTurnOn,BackRipAndPlay.MovieLocal,BackRipAndPlay.MovieStream,BackRipAndPlay.Moviechaptertrack,BackRipAndPlay.Movieendtrack,BackRipAndPlay.MovieCloneAndDisplay,BackRipAndPlay.MovieCloneOnly,BackRipAndPlay.MovieIndependent,BackRipAndPlay.MovieremoteControl,BackRipAndPlay.MovieWinamp,BackRipAndPlay.MovieWmp,BackRipAndPlay.MoviePowerDVD,BackRipAndPlay.MovieBrowseFolder,BackRipAndPlay.txtDaemonDrive,BackRipAndPlay.MovieResize,BackRipAndPlay.MovieRealTime,BackRipAndPlay.MovieHigh,BackRipAndPlay.MovieAboveNormal,BackRipAndPlay.MovieNormal,BackRipAndPlay.MovieBelowNormal,BackRipAndPlay.MovieLow", StoreNameSelected, "Left");
    }
  }
  function GoDown() {
    fscommand("mouse_off_screen",true);
    if (LevelSelect == 6) {
      if (MenuLevel == 1) {
        StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie", StoreNameSelected, "Right");
      } else {
        //StaticMove("Menu.RipCD.Movie,Menu.Scan.Movie,Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Right");
        StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 1) {
      if (StoreNameSelected == "TopBar.MovieX" && Menu._visible) {
        //eval("Menu.RipCD.Button").onRollOver();
          eval("Menu.AboutSly.Button").onRollOver();
      } else if (Bar._visible) {
        Bar.ButtonTheme.onRollOver();
      } else if (Bar._visible) {
        Bar.ButtonPlayAndRip.onRollOver();
      } else if (BackTheme._visible) {
        BackTheme.ButtonColor.onRollOver();
      } else if (BackSlideShow._visible) {
        BackSlideShow.ButtonDir.onRollOver();
      } else if (BackPlayList._visible) {
        BackPlayList.ButtonDir.onRollOver();
      } else if (BackAlbum._visible) {
        BackAlbum.ButtonAlbumNum.onRollOver();
      } else if (BackCountry._visible) {
        BackCountry.ButtonOptDefault.onRollOver();
      } else if (BackRipAndPlay._visible) {
      //  BackRipAndPlay.ButtonScroll.onRollOver();
        BackRipAndPlay.ButtonMicro.onRollOver();


      }
    } else if (LevelSelect == 2) {
      if (BackTheme._visible) {
        BackTheme.ButtonColor.onRollOver();
        Bar._visible = false;
        ClickM = 0;
      } else if (BackSlideShow._visible) {
        BackSlideShow.ButtonDir.onRollOver();
        Bar._visible = false;
        ClickM = 0;
      } else if (BackPlayList._visible) {
        BackPlayList.ButtonDir.onRollOver();
        Bar._visible = false;
        ClickM = 0;
      } else if (BackAlbum._visible) {
        BackAlbum.ButtonAlbumNum.onRollOver();
        Bar._visible = false;
        ClickM = 0;
      } else if (BackCountry._visible) {
        BackCountry.ButtonOptDefault.onRollOver();
        Bar._visible = false;
        ClickM = 0;
      }
    } else if (LevelSelect == 3) {
      if (BackTheme.MovieMonitor._visible == true) {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MovieMonitor,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Right");
      } else {
        StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 4) {
      StaticMove("BackSlideShow.MovieDir,BackSlideShow.MovieSetSlideShow,BackSlideShow.MovieSyn,BackSlideShow.MovieResize,BackSlideShow.MovieAllowSlideshow,BackSlideShow.MovieInSlide,BackSlideShow.MovieExSlide,BackSlideShow.MovieStretch,BackSlideShow.MovieShow,BackSlideShow.MovieEffect,BackSlideShow.MovieScroll,BackSlideShow.MovieRandom", StoreNameSelected, "Right");
    } else if (LevelSelect == 5) {
      if (StoreNameSelected == "BackPlayList.MovieDir" && BackPlayList.BackListD._visible) {
        BackPlayList.BackListD.Button0.onRollOver();
      } else if (substring(StoreNameSelected, 0, "BackPlayList.BackListD".length) == "BackPlayList.BackListD") {
        var TotalIndex = StoreIndexD;
        if (StoreNameSelected == "BackPlayList.BackListD.Movie"+(StoreIndexD-1)) {
          if (BackPlayList.BackListD.ButtonDown.enabled) {
            BackPlayList.BackListD.ButtonDown.onRelease();
          }
        } else {
          SelecteListItemDown(StoreNameSelected, TotalIndex);
        }
      } else {
        StaticMove("BackPlayList.MovieDir,BackPlayList.MovieAdd,BackPlayList.MovieRemove,BackPlayList.MovieImage1,BackPlayList.MovieImage2", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 7) {
      if(BackAlbum.ButtonAlbumIcon.Selected._visible){
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Right");
      }else{
        StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.subList.Movie_subList_production,BackAlbum.subList.Movie_subList_actor,BackAlbum.subList.Movie_subList_director,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 8) {
      //Backcountry.........
      if (StoreNameSelected == "BackCountry.MovieCountry" && BackCountry.MenuCountry._visible) {
        BackCountry.MenuCountry.Button0.onRollOver();
      } else if (substring(StoreNameSelected, 0, "BackCountry.MenuCountry".length) == "BackCountry.MenuCountry") {
        var TotalIndex = CountCountry;
        if (StoreNameSelected == "BackCountry.MenuCountry.Movie"+(CountCountry-1)) {
          if (BackCountry.MenuCountry.ButtonRight.enabled) {
            BackCountry.MenuCountry.ButtonRight.onRelease();
          }
        } else {
          SelecteListItemDown(StoreNameSelected, TotalIndex);
        }
      } else {
        StaticMove("BackCountry.MovieOptDefault,BackCountry.MovieOptCountry,BackCountry.MovieCountry,BackCountry.MovieOptLogin,BackCountry.MovieOptPlaylist,BackCountry.MovieOptSearch,BackCountry.MovieOptPlayer,BackCountry.MovieOptFullScreen,BackCountry.MovieOptMicro,BackCountry.MovieOptAutoClientConnect,BackCountry.MoviePlay,BackCountry.MovieShowPlayer,BackCountry.MovieFriendPlaylist,BackCountry.MovieLocalLink,BackCountry.fileType.Movie,BackCountry.MovieBrowse,BackCountry.MovieBrowseCoverArt,BackCountry.MovieBrowseMplayer,BackCountry.MovieSave,BackCountry.remote.BrowsePath.MovieBrowse,BackCountry.remote.first_remote.MovieSet", StoreNameSelected, "Right");
      }
    } else if (LevelSelect == 9) {
      StaticMove("BackRipAndPlay.MovieMicro,BackRipAndPlay.MovieOffset,BackRipAndPlay.MovieAutoPlay,BackRipAndPlay.MovieSingerSong,BackRipAndPlay.MovieAutoPlayMPC,BackRipAndPlay.MovieSyn_vol,BackRipAndPlay.MovieChange_vol,BackRipAndPlay.MovieSmall,BackRipAndPlay.MovieLarge,BackRipAndPlay.MovieTrackTitleStyle,BackRipAndPlay.MovieProgram,BackRipAndPlay.MovieTop,BackRipAndPlay.MovieBottom,BackRipAndPlay.MovieOld,BackRipAndPlay.MovieNew,BackRipAndPlay.MovieMicroScale,BackRipAndPlay.MovieVideo,BackRipAndPlay.MovieTurnOff,BackRipAndPlay.MovieTurnOn,BackRipAndPlay.MovieLocal,BackRipAndPlay.MovieStream,BackRipAndPlay.Moviechaptertrack,BackRipAndPlay.Movieendtrack,BackRipAndPlay.MovieCloneAndDisplay,BackRipAndPlay.MovieCloneOnly,BackRipAndPlay.MovieIndependent,BackRipAndPlay.MovieremoteControl,BackRipAndPlay.MovieWinamp,BackRipAndPlay.MovieWmp,BackRipAndPlay.MoviePowerDVD,BackRipAndPlay.MovieBrowseFolder,BackRipAndPlay.txtDaemonDrive,BackRipAndPlay.MovieResize,BackRipAndPlay.MovieRealTime,BackRipAndPlay.MovieHigh,BackRipAndPlay.MovieAboveNormal,BackRipAndPlay.MovieNormal,BackRipAndPlay.MovieBelowNormal,BackRipAndPlay.MovieLow", StoreNameSelected, "Right");

    }
  }
  function GoUp() {
    fscommand("mouse_off_screen",true);
    if (LevelSelect == 6) {
      if (MenuLevel == 1) {
        StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie", StoreNameSelected, "Left");
      } else {
        //if (StoreNameSelected == "Menu.RipCD.Movie") {
           if (StoreNameSelected == "Menu.AboutSly.Movie") {
          HideMenu();
          TopBar.ButtonX.onRollOver();
        } else {
          //StaticMove("Menu.RipCD.Movie,Menu.Scan.Movie,Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Left");
          StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Left");
        }
      }
    } else if (LevelSelect == 3) {
      if (StoreNameSelected == "BackTheme.MovieColor") {
        TopBar.ButtonM.onRollOver();
      } else {
        if (BackTheme.MovieMonitor._visible == true) {
          StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MovieMonitor,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Left");
        } else {
          StaticMove("BackTheme.MovieColor,BackTheme.MovieFontColor,BackTheme.MovieColorBar,BackTheme.MovieColorRating,BackTheme.MovieEngFont,BackTheme.MovieUniFont,BackTheme.MovieFrame,BackTheme.MovieSelFrame,BackTheme.MovieTooltip,BackTheme.MovieMouse,BackTheme.MoviePopupExit,BackTheme.MovieWinMode", StoreNameSelected, "Left");
        }
      }
    } else if (LevelSelect == 2) {
      TopBar.ButtonM.onRollOver();
    } else if (LevelSelect == 4) {
      if (StoreNameSelected == "BackSlideShow.MovieDir") {
        TopBar.ButtonM.onRollOver();
      } else {
        StaticMove("BackSlideShow.MovieDir,BackSlideShow.MovieSetSlideShow,BackSlideShow.MovieSyn,BackSlideShow.MovieResize,BackSlideShow.MovieAllowSlideshow,BackSlideShow.MovieInSlide,BackSlideShow.MovieExSlide,BackSlideShow.MovieStretch,BackSlideShow.MovieShow,BackSlideShow.MovieEffect,BackSlideShow.MovieScroll,BackSlideShow.MovieRandom", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 7) {
      if (StoreNameSelected == "BackAlbum.MovieAlbumNum") {
        TopBar.ButtonM.onRollOver();
      } else {
        if(BackAlbum.ButtonAlbumIcon.Selected._visible){
          StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Left");
        }else{
          StaticMove("BackAlbum.MovieAlbumNum,BackAlbum.MovieAlbumList,BackAlbum.MovieAlbumIcon,BackAlbum.subList.Movie_subList_production,BackAlbum.subList.Movie_subList_actor,BackAlbum.subList.Movie_subList_director,BackAlbum.MovieInternet,BackAlbum.MovieDownload,BackAlbum.MovieImage,BackAlbum.MovieCheckDatabase,BackAlbum.MovieCover,BackAlbum.MovieCoverNum,BackAlbum.MovieCoverPlus,BackAlbum.MovieAllCD,BackAlbum.MovieClean,BackAlbum.MovieExp,BackAlbum.MovieBrowse,BackAlbum.MovieFavAlbum,BackAlbum.MovieAllAlbumType,BackAlbum.MovieGroupAlbumType", StoreNameSelected, "Left");
        }
      }
    } else if (LevelSelect == 5) {
      if (StoreNameSelected == "BackPlayList.MovieDir" || StoreNameSelected == "BackPlayList.MovieAdd" || StoreNameSelected == "BackPlayList.MovieRemove") {
        TopBar.ButtonM.onRollOver();
      } else if (substring(StoreNameSelected, 0, "BackPlayList.BackListD".length) == "BackPlayList.BackListD") {
        var TotalIndex = StoreIndexD;
        if (StoreNameSelected == "BackPlayList.BackListD.Movie0") {
          if (BackPlayList.BackListD.ButtonUp.enabled) {
            BackPlayList.BackListD.ButtonUp.onRelease();
            if (LevelIndexD == TotalLevelIndexD) {
              TotalIndex = StoreIndexD;
            } else if (LevelIndexD == TotalLevelIndexD-1) {
              TotalIndex = nList;
            }
          }
        }
        SelecteListItemUp(StoreNameSelected, TotalIndex);
      } else {
        StaticMove("BackPlayList.MovieDir,BackPlayList.MovieAdd,,BackPlayList.MovieRemove,BackPlayList.MovieImage1,BackPlayList.MovieImage2", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 8) {
      if (StoreNameSelected == "BackCountry.MovieOptDefault") {
        TopBar.ButtonM.onRollOver();
      } else if (substring(StoreNameSelected, 0, "BackCountry.MenuCountry".length) == "BackCountry.MenuCountry") {
        var TotalIndex = CountCountry;
        if (StoreNameSelected == "BackCountry.MenuCountry.Movie0") {
          if (BackCountry.MenuCountry.ButtonLeft.enabled) {
            BackCountry.MenuCountry.ButtonLeft.onRelease();
            if (LevelIndexCountry == TotalLevelIndexCountry) {
              TotalIndex = CountCountry;
            } else if (LevelIndexCountry == TotalLevelIndexCountry-1) {
              TotalIndex = nMenu;
            }
          }
        }
        SelecteListItemUp(StoreNameSelected, TotalIndex);
      } else {
        StaticMove("BackCountry.MovieOptDefault,BackCountry.MovieOptCountry,BackCountry.MovieCountry,BackCountry.MovieOptLogin,BackCountry.MovieOptPlaylist,BackCountry.MovieOptSearch,BackCountry.MovieOptPlayer,BackCountry.MovieOptFullScreen,BackCountry.MovieOptMicro,BackCountry.MovieOptAutoClientConnect,BackCountry.MoviePlay,BackCountry.MovieShowPlayer,BackCountry.MovieFriendPlaylist,BackCountry.MovieLocalLink,BackCountry.fileType.Movie,BackCountry.MovieBrowse,BackCountry.MovieBrowseCoverArt,BackCountry.MovieBrowseMplayer,BackCountry.MovieSave,BackCountry.remote.BrowsePath.MovieBrowse,BackCountry.remote.first_remote.MovieSet", StoreNameSelected, "Left");
      }
    } else if (LevelSelect == 9) {
      //BackRipAndPlay.........
      //if (StoreNameSelected == "BackRipAndPlay.MovieScroll") {
        if (StoreNameSelected == "BackRipAndPlay.MovieMicro") {
        TopBar.ButtonM.onRollOver();
      } else {

          StaticMove("BackRipAndPlay.MovieMicro,BackRipAndPlay.MovieOffset,BackRipAndPlay.MovieAutoPlay,BackRipAndPlay.MovieSingerSong,BackRipAndPlay.MovieAutoPlayMPC,BackRipAndPlay.MovieSyn_vol,BackRipAndPlay.MovieChange_vol,BackRipAndPlay.MovieSmall,BackRipAndPlay.MovieLarge,BackRipAndPlay.MovieTrackTitleStyle,BackRipAndPlay.MovieProgram,BackRipAndPlay.MovieTop,BackRipAndPlay.MovieBottom,BackRipAndPlay.MovieOld,BackRipAndPlay.MovieNew,BackRipAndPlay.MovieMicroScale,BackRipAndPlay.MovieVideo,BackRipAndPlay.MovieTurnOff,BackRipAndPlay.MovieTurnOn,BackRipAndPlay.MovieLocal,BackRipAndPlay.MovieStream,BackRipAndPlay.Moviechaptertrack,BackRipAndPlay.Movieendtrack,BackRipAndPlay.MovieCloneAndDisplay,BackRipAndPlay.MovieCloneOnly,BackRipAndPlay.MovieIndependent,BackRipAndPlay.MovieremoteControl,BackRipAndPlay.MovieWinamp,BackRipAndPlay.MovieWmp,BackRipAndPlay.MoviePowerDVD,BackRipAndPlay.MovieBrowseFolder,BackRipAndPlay.txtDaemonDrive,BackRipAndPlay.MovieResize,BackRipAndPlay.MovieRealTime,BackRipAndPlay.MovieHigh,BackRipAndPlay.MovieAboveNormal,BackRipAndPlay.MovieNormal,BackRipAndPlay.MovieBelowNormal,BackRipAndPlay.MovieLow", StoreNameSelected, "left");

      }
    }
  }
}
Key.removeListener(someListener1);
Key.addListener(someListener1);