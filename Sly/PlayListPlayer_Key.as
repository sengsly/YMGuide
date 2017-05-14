//...........................FUNCTION PRESS ANY KEY................................
var WaitKeyPress = 0;
var CombinNum = "";
var OpenKey = "False";
var NumIndexKey = 0;
var IntervalValue = 500;
function CoverKeyCodeToNum(Num) {
	if (Num>=96 && Num<=105) {
		return Num%96;
	} else {
		return Num%48;
	}
}
Player_Listener = new Object();
Player_Listener.onMouseDown = function() {
	_global.boolMouseDown = true;
	if (Selection.getFocus() == null) {
		fscommand("KeyPressed", "MouseDown");
	}
};
Mouse.removeListener(Player_Listener);
Mouse.addListener(Player_Listener);
myListener = new Object();
myListener.onKeyDown = function() {
	_global.boolMouseDown = true;
	CtrlKey = Key.isDown(17);
	//test whether the control key is down
	if (SearchBox._visible) {
		if (String(selection.getFocus()) == "_level0.SearchBox.InputBox") {
			if (Key.getCode() == 13) {
				selection.setFocus(GetFocus);
				if (SearchBox.InputBox.text.length>0) {
					SearchBox.ButtonOk.onRollOver();
					SearchBox.ButtonOk.onRelease();
				}
				return;
			}
		}
		if (!SearchBox.InputBox._visible) {
			if (Key.getCode() == 9) {
				fscommand("SetFocusSearchPlayer");
				return;
			}
		}
	}
	if (selection.getFocus() == null || String(selection.getFocus()) == "_level0.GetFocus") {
		if (UpdateDB._visible || RestoreDB._visible || InputBox._visible || CopyMusic._visible || BackUpDB._visible || PurchaseCDMode._visible || AddNewScreens._visible || WarningUpdate._visible || SearchBox._visible) {
			fscommand("KeyPressed");
			if (Key.getCode() == 39) {
				if (WarningUpdate._visible) {
					StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel", StoreNameSelected, "Right");
				} else if (UpdateDB._visible) {
					StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel", StoreNameSelected, "Right");
				} else if (AddNewScreens._visible) {
					ArrowKeyScreen("Right");
				} else if (SearchBox._visible) {
					ArrowKeySearchBox(Key.getCode());
				} else if (RestoreDB._visible) {
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Right");
				} else if (InputBox._visible) {
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel", StoreNameSelected, "Right");
				} else if (CopyMusic._visible) {
					StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Right");
				} else if (BackUpDB._visible) {
					StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Right");
				} else if (PurchaseCDMode._visible) {
					MovePurchaseKey(39);
				}
			} else if (Key.getCode() == 37) {
				if (WarningUpdate._visible) {
					StaticMove("WarningUpdate.MovieOk,WarningUpdate.MovieCancel", StoreNameSelected, "Left");
				} else if (UpdateDB._visible) {
					StaticMove("UpdateDB.MovieOk,UpdateDB.MovieCancel", StoreNameSelected, "Left");
				} else if (AddNewScreens._visible) {
					ArrowKeyScreen("Left");
				} else if (SearchBox._visible) {
					ArrowKeySearchBox(Key.getCode());
				} else if (RestoreDB._visible) {
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Left");
				} else if (InputBox._visible) {
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel", StoreNameSelected, "Left");
				} else if (CopyMusic._visible) {
					StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Left");
				} else if (BackUpDB._visible) {
					StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Left");
				} else if (PurchaseCDMode._visible) {
					MovePurchaseKey(37);
				}
			} else if (Key.getCode() == 38) {
				if (PurchaseCDMode._visible) {
					MovePurchaseKey(38);
				} else if (AddNewScreens._visible) {
					ArrowKeyScreen("Left");
				} else if (SearchBox._visible) {
					ArrowKeySearchBox(Key.getCode());
				} else if (RestoreDB._visible) {
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Left");
				} else if (InputBox._visible) {
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel", StoreNameSelected, "Left");
				} else if (CopyMusic._visible) {
					StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Left");
				} else if (BackUpDB._visible) {
					StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Left");
				}
			} else if (Key.getCode() == 40) {
				if (PurchaseCDMode._visible) {
					MovePurchaseKey(40);
				} else if (AddNewScreens._visible) {
					ArrowKeyScreen("Right");
				} else if (SearchBox._visible) {
					ArrowKeySearchBox(Key.getCode());
				} else if (RestoreDB._visible) {
					StaticMove("RestoreDB.MovieBrowseDB,RestoreDB.MovieOk,RestoreDB.MovieCancel", StoreNameSelected, "Right");
				} else if (InputBox._visible) {
					StaticMove("InputBox.MovieOk,InputBox.MovieCancel", StoreNameSelected, "Right");
				} else if (CopyMusic._visible) {
					StaticMove("CopyMusic.MovieCheck1,CopyMusic.MovieCheck2,CopyMusic.MovieCheck3,CopyMusic.MovieBrowse1,CopyMusic.MovieBrowse2,CopyMusic.MovieOk,CopyMusic.MovieCancel", StoreNameSelected, "Right");
				} else if (BackUpDB._visible) {
					StaticMove("BackUpDB.MovieBrowseDB,BackUpDB.MovieOk,BackUpDB.MovieCancel", StoreNameSelected, "Right");
				}
			} else if (Key.getCode() == 13) {
				PressKeyPlayListPlayer(Key.getCode());
			}
		} else {
			PressKeyPlayListPlayer(Key.getCode());
		}
	} else {
		if (Key.getCode() == 13) {
			selection.setFocus(GetFocus);
		}
	}
};
Key.addListener(myListener);
var SelectLevel = 1;
var KeyCode = false;
function PressKeyPlayListPlayer(KeyCode, SendArr) {
	CtrlKey = Key.isDown(17);
	boolAlt = Key.isDown(18);
	bShift = Key.isDown(16);
	KeyCode = int(KeyCode);
	if (KeyCode == 39 and !CtrlKey and !boolAlt and !bShift) {
		fscommand("offScreen", true);
		GoRight();
		if (SendArr == "false") {
			fscommand("KeyPressed");
		} else {
			control_mini_player("KeyPressed", KeyCode, "true");
		}
	} else if (KeyCode == 37 and !CtrlKey and !boolAlt and !bShift) {
		fscommand("offScreen", true);
		GoLeft();
		if (SendArr == "false") {
			fscommand("KeyPressed");
		} else {
			control_mini_player("KeyPressed", KeyCode, "true");
		}
	} else if (KeyCode == 38 and !CtrlKey and !boolAlt and !bShift) {
		fscommand("offScreen", true);
		CtrlKey = false;		
		GoUp();
		if (SendArr == "false") {
			fscommand("KeyPressed");
		} else {
			control_mini_player("KeyPressed", KeyCode, "true");
		}
	} else if (KeyCode == 40 and !CtrlKey and !boolAlt and !bShift) {
		fscommand("offScreen", true);
		GoDown();
		if (SendArr == "false") {
			fscommand("KeyPressed");
		} else {
			control_mini_player("KeyPressed", KeyCode, "true");
		}
	} else if (KeyCode == 13 and !boolAlt and !CtrlKey and !bShift) {
		eval(Replace(StoreNameSelected, "Movie", "Button")).onRelease();
		fscommand("KeyPressed", KeyCode);
	} else if (KeyCode == 17) {
		CtrlKey = true;
		if (!Save._visible) {
			fscommand("KeyPressed");
		}
	} else if (KeyCode == 32 and !CtrlKey and !boolAlt and !bShift) {
		if (eval(TrackName)._visible) {
			if (eval(TrackName).BackStars._visible) {
				if (SelectLevel == 3) {
					eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
					eval(TrackName).BackStars.Button1.onRollOver();
				} else if (SelectLevel == 9) {
					if (StoreNameSelected == TrackName+".BackStars.Movie5") {
						eval(TrackName).BackStars.Back.onRollOut();
					}
					if (StoreNameSelected == TrackName+".SearchPlayerPage.Movie") {
						eval(TrackName).SearChPlayerPage.Button.onRollOut();
						eval(TrackName).BackStars.Button1.onRollOver();
					}
					if (StoreNameSelected == TrackName+".download_song.Movie") {
						eval(TrackName).download_song.Button.onRollOut();
						eval(TrackName).BackStars.Button1.onRollOver();
					} else {
						temp = TrackName+".BackStars.Movie1,"+TrackName+".BackStars.Movie2,"+TrackName+".BackStars.Movie3,"+TrackName+".BackStars.Movie4,"+TrackName+".BackStars.Movie5,"+TrackName+".RefreshCoverArt.Movie,"+TrackName+".PathSlideshow.Movie,"+TrackName+".SearchPlayerPage.Movie,";
						StaticMove(temp, StoreNameSelected, "Right");
					}
				}
			} else {
				press_space_bar();
			}
		} else {
			press_space_bar();
		}
	} else {
		if (CtrlKey and !boolAlt and !bShift) {
			combine_key_player(KeyCode);
		} else if (!CtrlKey and !boolAlt) {
			if (KeyCode == 8 && Selection.getFocus() == null) {
				TopBar.ButtonB.onRollOver();
				TopBar.ButtonB.onRelease();
				if (SearchBox._visible == true && Selection.setFocus() == null) {
					SearchBox.ButtonCancel.onRelease();
				}
			} else if ((KeyCode>=48 && KeyCode<=57) || (KeyCode>=96 && KeyCode<=105)) {
				if (!Save._visible) {
					if (OpenKey == "False") {
						OpenNumKey();
					}
					OpenKey = "True";
					CombinNum += CoverKeyCodeToNum(KeyCode);
				}
			} else if (KeyCode == 71) {
				//G
				if (ButtonBurch._visible) {
					ButtonBurch.Button.onRollOver();
					ButtonBurch.Button.onRelease();
				}
			} else if (KeyCode == 73) {
				//I
				if (ButtonCD._visible) {
					ButtonCD.Button.onRollOver();
					ButtonCD.Button.onRelease();
				}
			} else if (KeyCode == KeyPreAlbum) {
				//<
				if (ButtonPre._visible) {
					ButtonPre.Button.onRollOver();
					ButtonPre.Button.onRelease();
				}
			} else if (KeyCode == KeyNextAlbum) {
				//>
				if (ButtonNext._visible) {
					ButtonNext.Button.onRollOver();
					ButtonNext.Button.onRelease();
				}
			} else if (keyCode == 219) {
				if (eval(TrackName).ButtonLeft._visible == true) {
					eval(TrackName).ButtonLeft.onRelease();
					eval(TrackName).ButtonLeft.onRollOver();
				}
			} else if (keyCode == 221) {
				if (eval(TrackName).ButtonRight._visible == true) {
					eval(TrackName).ButtonRight.onRelease();
					eval(TrackName).ButtonRight.onRollOver();
				}
			}
		}
	}
	//......................................
	function GoRight() {
		fscommand("mouse_off_screen", true);
		if (substring(StoreNameSelected, 0, "mini".length) == "mini") {
			LeftRightPlayer("Right");
		} else {
			if (SelectLevel == 5) {
				MenuMISC._visible = false;
				Menu.MISC.Button.onRollOver();
			} else if (SelectLevel == 1) {
				StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX", StoreNameSelected, "Right");
			} else if (SelectLevel == 2) {
				MoveLeftRight("AlbumBar", StoreNameSelected, CountAlbum, "Right");
			} else if (SelectLevel == 4) {
				if (DelAll._visible) {
					StaticMove("DelAll.MovieCancel,DelAll.MovieOk", StoreNameSelected, "Right");
				} else if (Save._visible) {
					StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieKey,Save.MovieOk,Save.MovieCancel", StoreNameSelected, "Right");
				} else if (StoreNameSelected == "BackPlay.MovieSave") {
					eval(TrackName).Button0.onRollOver();
				} else if (StoreNameSelected == "ButtonBurch.Movie") {
					if (BackAlbumInfo._visible) {
						BackAlbumInfo.BackStars.Button1.onRollOver();
					} else {
						eval(TrackName).Button0.onRollOver();
					}
				} else {
					if (ClickAlbum) {
						StaticMove("PlayAll.Movie,ButtonPre.Movie,ButtonNext.Movie,ButtonCD.Movie,ButtonBurch.Movie", StoreNameSelected, "Right");
					} else {
						StaticMove("BackPlay.MovieAlbum,BackPlay.MovieDelOne,BackPlay.MovieDelAll,BackPlay.MovieMoveUp,BackPlay.MovieMoveDown,BackPlay.MovieSave", StoreNameSelected, "Right");
					}
				}
			} else if (SelectLevel == 3) {
				if (StoreNameSelected == String(TrackName+".MovieLeft")) {
					eval(TrackName).ButtonRight.onRollOver();
				} else if (StoreNameSelected == String(TrackName+".MovieRight")) {
					eval("BackAlbumPic.Button").onRollOver();
				} else if (StoreNameSelected == "BackAlbumPic.Movie") {
					if (BackAlbumInfo._visible) {
						BackAlbumInfo.BackStars.Button1.onRollOver();
					} else {
						eval(TrackName).BackStars.Button1.onRollOver();
					}
				} else if (substring(StoreNameSelected, 0, String(TrackName+".Movie").length) == String(TrackName+".Movie")) {
					if (StoreNameSelected == String(TrackName+".Movie9") || StoreNameSelected == String(TrackName+".Movie10")) {
						vb = "lostFocus";
						fscommand("LoadSwfMiniControl", "_level0.previous_mc._mc");
					} else if (StoreNameSelected == String(TrackName+".Movie11")) {
						vb = "lostFocus";
						fscommand("LoadSwfMiniControl", "_level0.add_mc._mc");
					} else {
						eval(TrackName+".Button"+(IndexTrack%nTrack)).onRollOut();
						eval("BackAlbumPic.Button").onRollOver();
					}
				}
			} else if (SelectLevel == 9) {
				temp = TrackName+".BackStars.Movie1,"+TrackName+".BackStars.Movie2,"+TrackName+".BackStars.Movie3,"+TrackName+".BackStars.Movie4,"+TrackName+".BackStars.Movie5," + TrackName+".DefaultVLC.Movie,"+TrackName+".RefreshCoverArt.Movie,"+TrackName+".PathSlideshow.Movie,"+TrackName+".SearChPlayerPage.Movie";
				StaticMove(temp, StoreNameSelected, "Right");

				/*
				if (StoreNameSelected == TrackName+".BackStars.Movie5") {
					eval(TrackName).BackStars.Back.onRollOut();
					eval(TrackName).RefreshCoverArt.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".RefreshCoverArt.Movie") {
					eval(TrackName).PathSlideshow.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".PathSlideshow.Movie") {
					eval(TrackName).SearchPlayerPage.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".SearchPlayerPage.Movie") {
					eval(TrackName).download_song.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".download_song.Movie") {
					eval("BackAlbumPic.Button").onRollOver();
				} else {
					temp = TrackName+".BackStars.Movie1,"+TrackName+".BackStars.Movie2,"+TrackName+".BackStars.Movie3,"+TrackName+".BackStars.Movie4,"+TrackName+".BackStars.Movie5";
					StaticMove(temp, StoreNameSelected, "Right");
				}*/
			} else if (SelectLevel == 10) {
				if (StoreNameSelected == "BackAlbumInfo.BackStars.Movie5") {
					BackAlbumInfo.BackStars.Back.onRollOut();
					eval("BackAlbumPic.Button").onRollOver();
				} else {
					temp = "BackAlbumInfo.BackStars.Movie1,BackAlbumInfo.BackStars.Movie2,BackAlbumInfo.BackStars.Movie3,BackAlbumInfo.BackStars.Movie4,BackAlbumInfo.BackStars.Movie5";
					StaticMove(temp, StoreNameSelected, "Right");
				}
			}
		}
	}
	function GoLeft() {
		fscommand("mouse_off_screen", true);
		if (substring(StoreNameSelected, 0, "mini".length) == "mini") {
			LeftRightPlayer("Left");
		} else {
			if (SelectLevel == 5) {
				if (StoreNameSelected == "Menu.MISC.Movie") {
					MenuMISC.UpdateDB.Button.onRollOver();
				}
			} else if (SelectLevel == 1) {
				StaticMove("TopBar.MovieB,TopBar.MovieM,TopBar.MovieS,TopBar.MovieP,TopBar.MovieC,TopBar.MovieO,TopBar.MovieL,TopBar.MovieX", StoreNameSelected, "Left");
			} else if (SelectLevel == 2) {
				MoveLeftRight("AlbumBar", StoreNameSelected, CountAlbum, "Left");
			} else if (SelectLevel == 4) {
				if (DelAll._visible) {
					StaticMove("DelAll.MovieCancel,DelAll.MovieOk", StoreNameSelected, "Left");
				} else if (Save._visible) {
					StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieKey,Save.MovieOk,Save.MovieCancel", StoreNameSelected, "Left");
				} else if (StoreNameSelected == "BackPlay.MovieAlbum") {
					eval(TrackName).Button0.onRollOver();
				} else if (StoreNameSelected == "PlayAll.Movie") {
					if (BackAlbumInfo._visible) {
						BackAlbumInfo.BackStars.Button5.onRollOver();
					} else {
						eval(TrackName).Button0.onRollOver();
					}
				} else {
					if (ClickAlbum) {
						StaticMove("PlayAll.Movie,ButtonPre.Movie,ButtonNext.Movie,ButtonCD.Movie,ButtonBurch.Movie", StoreNameSelected, "Left");
					} else {
						StaticMove("BackPlay.MovieAlbum,BackPlay.MovieDelOne,BackPlay.MovieDelAll,BackPlay.MovieMoveUp,BackPlay.MovieMoveDown,BackPlay.MovieSave", StoreNameSelected, "Left");
					}
				}
			} else if (SelectLevel == 3) {
				if (StoreNameSelected == String(TrackName+".MovieLeft")) {
					eval(TrackName).ButtonLeft.onRelease();
				} else if (StoreNameSelected == String(TrackName+".MovieRight")) {
					eval(TrackName).ButtonLeft.onRollOver();
				} else if (StoreNameSelected == "BackAlbumPic.Movie") {
					if (BackAlbumInfo._visible) {
						BackAlbumInfo.BackStars.Button5.onRollOver();
					} else {
						eval(TrackName).Button0.onRollOver();
					}
				} else if (substring(StoreNameSelected, 0, String(TrackName+".Movie").length) == String(TrackName+".Movie")) {
					if (eval(TrackName).ButtonRight._visible) {
						eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
						eval(TrackName).ButtonLeft.onRelease();
						eval(TrackName).Button0.onRollOver();
					}
				}
			} else if (SelectLevel == 9) {
				temp = TrackName+".BackStars.Movie1,"+TrackName+".BackStars.Movie2,"+TrackName+".BackStars.Movie3,"+TrackName+".BackStars.Movie4,"+TrackName+".BackStars.Movie5," + TrackName+".DefaultVLC.Movie,"+TrackName+".RefreshCoverArt.Movie,"+TrackName+".PathSlideshow.Movie,"+TrackName+".SearChPlayerPage.Movie";
				StaticMove(temp, StoreNameSelected, "Left");
			/*
				if (StoreNameSelected == TrackName+".BackStars.Movie1") {
					eval(TrackName).BackStars.Back.onRollOut();
					eval(TrackName).Button0.onRollOver();
				} else if (StoreNameSelected == TrackName+".RefreshCoverArt.Movie") {
					eval(TrackName).BackStars.Button5.onRollOver();
				} else if (StoreNameSelected == TrackName+".PathSlideshow.Movie") {
					eval(TrackName).RefreshCoverArt.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".PathSlideshow.Movie") {
					eval(TrackName).RefreshCoverArt.Button.onRollOver();
				} else if (StoreNameSelected == TrackName+".download_song.Movie") {
					eval(TrackName).SearchPlayerPage.Button.onRollOver();
				} else {
					temp = TrackName+".BackStars.Movie1,"+TrackName+".BackStars.Movie2,"+TrackName+".BackStars.Movie3,"+TrackName+".BackStars.Movie4,"+TrackName+".BackStars.Movie5";
					StaticMove(temp, StoreNameSelected, "Left");
				}
			*/
			} else if (SelectLevel == 10) {
				if (StoreNameSelected == "BackAlbumInfo.BackStars.Movie1") {
					BackAlbumInfo.BackStars.Back.onRollOut();
					eval("BackAlbumPic.Button").onRollOver();
				} else {
					temp = "BackAlbumInfo.BackStars.Movie1,BackAlbumInfo.BackStars.Movie2,BackAlbumInfo.BackStars.Movie3,BackAlbumInfo.BackStars.Movie4,BackAlbumInfo.BackStars.Movie5";
					StaticMove(temp, StoreNameSelected, "Left");
				}
			}
		}
	}
	function GoUp() {
		fscommand("mouse_off_screen", true);
		if (substring(StoreNameSelected, 0, "mini".length) == "mini") {
			LeftRightPlayer("Up");
		} else {
			if (SelectLevel == 5) {
				if (MenuLevel == 1) {
					StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie", StoreNameSelected, "Left");
				} else {
					if (StoreNameSelected == "Menu.AboutSly.Movie") {
						HideMenu();
						TopBar.ButtonX.onRollOver();
					} else {
						StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Left");
					}
				}
			} else if (SelectLevel == 2) {
				TopBar.ButtonM.onRollOver();
			} else if (SelectLevel == 3) {
				if (StoreNameSelected == TrackName+".Movie0") {
					eval(TrackName+".Button0").onRollOut();
					TopBar.ButtonM.onRollOver();
				} else if (StoreNameSelected == "BackAlbumPic.Movie") {
					TopBar.ButtonC.onRollOver();
				} else {
					eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
					MoveLeftRight(TrackName, StoreNameSelected, eval("Count"+TrackObj), "Left");
				}
			} else if (SelectLevel == 9) {
				TopBar.ButtonM.onRollOver();
			} else if (SelectLevel == 10) {
				BackAlbumInfo.BackStars.Back.onRollOut();
				TopBar.ButtonM.onRollOver();
			} else if (SelectLevel == 4) {
				if (!Save._visible && !DelAll._visible) {
					eval("BackAlbumPic.Button").onRollOver();
				} else if (Save._visible) {
					if (substring(StoreNameSelected, 0, "Save.MenuPath".length) == "Save.MenuPath") {
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
					} else if (substring(StoreNameSelected, 0, "Save.MenuMode".length) == "Save.MenuMode") {
						StaticMove("Save.MenuMode.MovieTrack,Save.MenuMode.MovieAlbum,Save.MenuMode.MovieArtist", StoreNameSelected, "Left");
					} else {
						StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieKey,Save.MovieOk,Save.MovieCancel", StoreNameSelected, "Left");
					}
				}
			}
		}
	}
	function GoDown() {
		fscommand("mouse_off_screen", true);
		if (substring(StoreNameSelected, 0, "mini".length) == "mini") {
			LeftRightPlayer("Down");
		} else {
			if (SelectLevel == 5) {
				if (MenuLevel == 1) {
					StaticMove("MenuMISC.UpdateDB.Movie,MenuMISC.RestoreDB.Movie,MenuMISC.BackUpDB.Movie,MenuMISC.CopyFolder.Movie,MenuMISC.AddNewScreen.Movie", StoreNameSelected, "Right");
				} else {
					StaticMove("Menu.AboutSly.Movie,Menu.MISC.Movie,Menu.Min.Movie,Menu.Exit.Movie", StoreNameSelected, "Right");
				}
			} else if (SelectLevel == 1) {
				if (StoreNameSelected == "TopBar.MovieX" && Menu._visible) {
					eval("Menu.AboutSly.Button").onRollOver();
				} else if (AlbumBar._visible) {
					AlbumBar.Button0.onRollOver();
				} else if (StoreNameSelected == "TopBar.MovieC" || StoreNameSelected == "TopBar.MovieO" || StoreNameSelected == "TopBar.MovieL" || StoreNameSelected == "TopBar.MovieX") {
					BackAlbumPic.Button.onRollOver();
				} else if (BackAlbumInfo._visible) {
					BackAlbumInfo.BackStars.Button1.onRollOver();
				} else if (eval(TrackName).Button0._visible && eval(TrackName)._visible) {
					eval(TrackName).Button0.onRollOver();
				} else {
					if (mini.PauseMusic._visible) {
						mini.PauseMusic.ButtonPause.onRollOver();
					} else {
						mini.PlayMusic.ButtonPlay.onRollOver();
					}
				}
			} else if (SelectLevel == 2) {
				AlbumBar._visible = false;
				if (BackAlbumInfo._visible) {
					BackAlbumInfo.BackStars.Button1.onRollOver();
				} else {
					eval(TrackName).Button0.onRollOver();
				}
			} else if (SelectLevel == 3) {
				if (StoreNameSelected == "BackAlbumPic.Movie") {
					if (ClickAlbum) {
						PlayAll.Button.onRollOver();
					} else {
						BackPlay.ButtonAlbum.onRollOver();
					}
				} else {
					eval(TrackName+".Button"+GetNumber(StoreNameSelected)).onRollOut();
					MoveLeftRight(TrackName, StoreNameSelected, eval("Count"+TrackObj), "Right");
				}
			} else if (SelectLevel == 9) {
				BackAlbumPic.Button.onRollOver();
			} else if (SelectLevel == 4) {
				if (!Save._visible && !DelAll._visible) {
					fscommand("LoadSwfMiniControl", getButtomObject());
					ChangeColor(eval(StoreNameSelected), SetColorValue);
				} else if (Save._visible) {
					if (StoreNameSelected == "Save.MovieMode" && Save.MenuMode._visible) {
						Save.MenuMode.ButtonTrack.onRollOver();
					} else if (substring(StoreNameSelected, 0, "Save.MenuMode".length) == "Save.MenuMode") {
						StaticMove("Save.MenuMode.MovieTrack,Save.MenuMode.MovieAlbum,Save.MenuMode.MovieArtist", StoreNameSelected, "Right");
					} else if (StoreNameSelected == "Save.MoviePath" && Save.MenuPath._visible) {
						Save.MenuPath.Button0.onRollOver();
					} else if (substring(StoreNameSelected, 0, "Save.MenuPath".length) == "Save.MenuPath") {
						var TotalIndex = CountPath;
						if (StoreNameSelected == "Save.MenuPath.Movie"+(CountPath-1)) {
							if (Save.MenuPath.ButtonRight._visible) {
								Save.MenuPath.ButtonRight.onRelease();
							}
						} else {
							SelecteListItemDown(StoreNameSelected, TotalIndex);
						}
					} else {
						StaticMove("Save.MoviePath,Save.MovieSlide,Save.MovieMode,Save.MovieAppand,Save.MovieOverwrite,Save.MovieKey,Save.MovieOk,Save.MovieCancel", StoreNameSelected, "Right");
					}
				}
			}
		}
	}
}
function Escape() {
	if (WarningUpdate._visible) {
		WarningUpdate.ButtonCancel.onRelease();
	} else if (UpdateDB._visible) {
		UpdateDB.ButtonCancel.onRelease();
	} else if (PurchaseCDMode._visible) {
		PurchaseCDMode.ButtonClose.onRelease();
	} else if (RestoreDB._visible) {
		RestoreDB.ButtonCancel.onRelease();
	} else if (InputBox._visible) {
		InputBox.ButtonCancel.onRelease();
	} else if (BackupDB._visible) {
		BackupDB.ButtonCancel.onRelease();
	} else if (CopyMusic._visible) {
		CopyMusic.ButtonCancel.onRelease();
	} else if (AddNewScreens._visible) {
		AddNewScreens.ButtonCancel.onRelease();
	} else if (SearchBox._visible) {
		SearchBox.ButtonCancel.onRelease();
	} else if (DelAll._visible) {
		DelAll.ButtonCancel.onRelease();
	} else if (Save._visible) {
		if (Save.MenuPath._visible) {
			Save.MenuPath._visible = false;
			Save.ButtonPath.onRollOver();
		} else if (Save.MenuMode._visible) {
			Save.MenuMode._visible = false;
			Save.ButtonMode.onRollOver();
		} else {
			Save.ButtonCancel.onRelease();
		}
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
function SelecteListItemUp(Name, TotalIndex) {
	var Index = parseInt(substring(Name, Name.length, -1), 10);
	var Str = substring(Name, 0, Name.length-1);
	if (Index>0) {
		SelectButton(Str+(Index-1));
	} else {
		SelectButton(Str+(TotalIndex-1));
	}
}
function LeftRightPlayer(Value) {
	if (Value == "Right") {
		if (StoreNameSelected == "mini.PauseMusic.MoviePause" || StoreNameSelected == "mini.PlayMusic.MoviePlay") {
			mini.StopMusic.ButtonStop.onRollOver();
		} else if (StoreNameSelected == "mini.StopMusic.MovieStop") {
			mini.PreviousMusic.ButtonPrevious.onRollOver();
		} else if (StoreNameSelected == "mini.PreviousMusic.MoviePrevious") {
			mini.NextMusic.ButtonNext.onRollOver();
		} else if (StoreNameSelected == "mini.NextMusic.MovieNext") {
			mini.AddMusic.ButtonAddMusic.onRollOver();
		} else if (StoreNameSelected == "mini.AddMusic.MovieAddMusic") {
			mini.PlayerPage.ButtonPlayerPage.onRollOver();
		} else if (StoreNameSelected == "mini.PlayerPage.MoviePlayerPage") {
			if (mini.RepeatTrue._visible) {
				mini.RepeatTrue.ButtonRepeat.onRollOver();
			} else {
				mini.RepeatFalse.ButtonRepeat.onRollOver();
			}
		} else if (StoreNameSelected == "mini.RepeatTrue.MovieRepeat" || StoreNameSelected == "mini.RepeatFalse.MovieRepeat") {
			if (mini.ShuffleTrue._visible) {
				mini.ShuffleTrue.ButtonShuffle.onRollOver();
			} else {
				mini.ShuffleFalse.ButtonShuffle.onRollOver();
			}
		} else if (StoreNameSelected == "mini.ShuffleTrue.MovieShuffle" || StoreNameSelected == "mini.ShuffleFalse.MovieShuffle") {
			if (mini.MuteTrue._visible) {
				mini.MuteTrue.ButtonMute.onRollOver();
			} else {
				mini.MuteFalse.ButtonMute.onRollOver();
			}
		} else if (StoreNameSelected == "mini.MuteTrue.MovieMute" || StoreNameSelected == "mini.MuteFalse.MovieMute") {
			if (mini.PauseMusic._visible) {
				mini.PauseMusic.ButtonPause.onRollOver();
			} else {
				mini.PlayMusic.ButtonPlay.onRollOver();
			}
		}
	} else if (Value == "Left") {
		if (StoreNameSelected == "mini.PauseMusic.MoviePause" || StoreNameSelected == "mini.PlayMusic.MoviePlay") {
			if (BackAlbumInfo._visible) {
				BackAlbumInfo.BackStars.Button5.onRollOver();
			} else {
				eval(TrackName+".Button"+(eval("Count"+TrackObj)-1)).onRollOver();
			}
		} else if (StoreNameSelected == "mini.StopMusic.MovieStop") {
			if (mini.PauseMusic._visible) {
				mini.PauseMusic.ButtonPause.onRollOver();
			} else {
				mini.PlayMusic.ButtonPlay.onRollOver();
			}
		} else if (StoreNameSelected == "mini.PreviousMusic.MoviePrevious") {
			mini.StopMusic.ButtonStop.onRollOver();
		} else if (StoreNameSelected == "mini.NextMusic.MovieNext") {
			mini.PreviousMusic.ButtonPrevious.onRollOver();
		} else if (StoreNameSelected == "mini.AddMusic.MovieAddMusic") {
			mini.NextMusic.ButtonNext.onRollOver();
		} else if (StoreNameSelected == "mini.PlayerPage.MoviePlayerPage") {
			mini.AddMusic.ButtonAddMusic.onRollOver();
		} else if (StoreNameSelected == "mini.RepeatTrue.MovieRepeat" || StoreNameSelected == "mini.RepeatFalse.MovieRepeat") {
			mini.PlayerPage.ButtonPlayerPage.onRollOver();
		} else if (StoreNameSelected == "mini.ShuffleTrue.MovieShuffle" || StoreNameSelected == "mini.ShuffleFalse.MovieShuffle") {
			if (mini.RepeatTrue._visible) {
				mini.RepeatTrue.ButtonRepeat.onRollOver();
			} else {
				mini.RepeatFalse.ButtonRepeat.onRollOver();
			}
		} else if (StoreNameSelected == "mini.MuteTrue.MovieMute" || StoreNameSelected == "mini.MuteFalse.MovieMute") {
			if (mini.ShuffleTrue._visible) {
				mini.ShuffleTrue.ButtonShuffle.onRollOver();
			} else {
				mini.ShuffleFalse.ButtonShuffle.onRollOver();
			}
		}
	} else if (Value == "Up") {
		if (StoreNameSelected == "mini.MuteTrue.MovieMute" || StoreNameSelected == "mini.MuteFalse.MovieMute" || StoreNameSelected == "mini.ShuffleTrue.MovieShuffle" || StoreNameSelected == "mini.ShuffleFalse.MovieShuffle" || StoreNameSelected == "mini.RepeatTrue.MovieRepeat" || StoreNameSelected == "mini.RepeatFalse.MovieRepeat") {
			if (mini.PauseMusic._visible) {
				mini.PauseMusic.ButtonPause.onRollOver();
			} else {
				mini.PlayMusic.ButtonPlay.onRollOver();
			}
		} else {
			if (BackPlay._visible) {
				BackPlay.ButtonAlbum.onRollOver();
			} else {
				PlayAll.Button.onRollOver();
			}
		}
	} else if (Value == "Down") {
		if (!(StoreNameSelected == "mini.MuteTrue.MovieMute" || StoreNameSelected == "mini.MuteFalse.MovieMute" || StoreNameSelected == "mini.ShuffleTrue.MovieShuffle" || StoreNameSelected == "mini.ShuffleFalse.MovieShuffle" || StoreNameSelected == "mini.RepeatTrue.MovieRepeat" || StoreNameSelected == "mini.RepeatFalse.MovieRepeat")) {
			if (mini.RepeatTrue._visible) {
				mini.RepeatTrue.ButtonRepeat.onRollOver();
			} else {
				mini.RepeatFalse.ButtonRepeat.onRollOver();
			}
		}
	}
}
function combine_key_player(KeyCode) {
	KeyCode = int(KeyCode);
	if (KeyCode == 17) {
		return;
	}
	if (send_event("normal&&&function||combine_key_player|~|"+KeyCode+"||4", false)) {
		return;
	}
	if (!Save._visible) {
		fscommand("KeyPressed");
	}
	if (KeyCode == 85) {
		fscommand("FullScreenPlayer");
		//U
	} else if (KeyCode == KeySlide) {
		//~
		if (SlideShowValue == "Yes") {
			DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (OFF)", SHTT, -(96/2)+5, 20, true);
			SlideShowValue = "No";
		} else {
			DisplayTooltip(eval("TopBar.ButtonM"), "txtTooltip", "Set SlideShow (ON)", SHTT, -(96/2)+5, 20, true);
			SlideShowValue = "Yes";
		}
		fscommand("SetSlideShowOnOff", SlideShowValue);
	} else if (KeyCode == 49 || KeyCode == 97) {
		//1
		var AlbumCover1 = AlbumCover;
		if (AlbumCover1 == "Yes") {
			AlbumCover1 = "No";
		} else {
			AlbumCover1 = "Yes";
		}
		fscommand("CtrlPlus", "1~"+AlbumCover1);
	} else if (KeyCode == KeyMin) {
		HideMenu();
//		fscommand("Minimize");
		TopBar.ButtonM.onRollOver();
//		CtrlKey = false;
	} else if (KeyCode == keyHideMouse) {
		if (HideMouse == "true") {
			Mouse.show();
			HideMouse = "false";
		} else {
			Mouse.hide();
			HideMouse = "true";
		}
		fscommand("setHideMouse", HideMouse);
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
		eval(TrackName+".Button"+getNumber(StoreNameSelected)).onRollOut();
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
	} else if (KeyCode == 75) {
		//K
		fscommand("CtrlPlus", "K~true");
	} else if (KeyCode == 84) {
		fscommand("Visualization");
	}
}
function press_space_bar() {
	if (send_event("normal&&&function||press_space_bar||4", false)) {
		return;
	}
	fscommand("popup", true);
}
