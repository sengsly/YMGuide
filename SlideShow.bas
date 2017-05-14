Attribute VB_Name = "Settings"
 Option Explicit

Public server_display_page As String
Public server_display_language As String
Public boolDeleting As Boolean
Public IndexSearchToLoad As Integer
Public IndexPlaylistToLoad As Integer
Public IndexPlayerToLoad As Integer
Public IndexOptionToLoad As Integer
Public indexSwf2Unload As String                     '-1 equal to none
Public ValuePlayer As Integer
Public ChangeIcon As String
Public SplitColor As String
Private DaemonPath As String



Public LoadSlideshow As Boolean
Public LoadBrowseInSlideshow As Boolean
Public AlbumIDSlide  As String
Public LanSlide As String
Public StoreAlbumIDSlide As String
Public StringPathSlide As String
Public sepSlide As String
Public type_login_display As Boolean
Public type_login_playback As Boolean
Public type_login_independent As Boolean
Public type_login_remoteControl As Boolean
Public ShowVisualization As Boolean
Public MusicNoteValue As String
Public playMusicWith As playerEnum
Public b_BrowseByFolder As Boolean
Public b_ExternalPowerDVD As Boolean   '                                'Use external player of PowerDVD if it's true


'Global vriable
Public StoreQsearch As String                   'store when open search page again
Public StoreSearchTrack As String               'store when open search page again



'Sly Setting store here
'Store in language xml
Public i_SearchTrackFromArtist As Integer             '0 Display Album, 1 Display Search Track
'==========================================================================================
'Store in setting xml(global)
Public Const DefaultMaxRemoteControl As Integer = 1
Public Const DefaultMaxClientConnect As Integer = 50        'Default to 50
Public AutoPlayEnabled As Boolean                           'Auto play mp4 with VLC Player
Public AutoPlayMPC As Boolean                           'Auto play Mp4 with MPC
Public AutoPlayPowerDVD As Boolean                          'Auto play file type with PowerDVD
Public b_EncoderInstalled As Boolean
Public b_ShowControlInPlayer As Boolean
Public b_karaoke_voice As Boolean
Public b_ShowCoverIcon As Boolean                     ' Show icon in track page
Public b_slideshow As Boolean
Public s_DriveMount As String
'More than one monitor only(extended)
Public i_SlyMonitor As Integer                    'For main form             'EDID:2006-07-31
Public i_VideoMonitor As Integer                  'For fullscreen video      'EDID:2006-07-31
Public Language As String       ' When change language                  'Uni or Eng
Public i_MaxRemoteControl As Integer      'for indepdent server mode only
Public i_MaxClientConnect As Integer      'for server mode allow number of client connect
Public server_nick_name As String       'Name defined by client
Public InitDir As String
Public b_local_link As Boolean
Public boolDownloadAll As Boolean                           'Download all remote file from friend
Public b_hideMouse As Boolean
Public b_ReEncode As Boolean
Public b_ShowPopupInfo As Boolean                     'true if show popup info false hide it
Public i_ShowUnderTrackTitle As Integer               '0 for Artist,1 for Production(Karaoke,Music only)
Public i_AutoConnected As Integer                     'for connection type
Public WinMode As String                              '"FullScreen Mode","Window Mode"
Public b_AutoConnect As Boolean                       'for auto connect(true,false)
Public s_LastServerName As String                     'last connected server name
Public b_ShowFormVideo As Boolean                     'show form video on another monitor
Public b_SimpleInterface As Boolean


Public s_FitsLoad As String                           'store first load type
Public server_name As String
Public b_GetZoomLevelFromServer As Boolean            'Tell if want to get the zoom level from server
'Public server_loginName As String
'-----------Slide Show-------------------------------
Public SlideShowRandom As String
Public LastLanguage As String                         'Last country when exiting SlyGuide (For Load to Player Page)
'-----------End   Show-------------------------------
'0(Disable),1,2,3,4''cloneDisplay,remotePlaylist,remoteControl,independentMode

'slide show
Public SlideSecond As Integer                         'show slideshow in seconds
Public SlideShowValue As String                       'show slideshow or not (No,Yes)
Public AutoDownload As Integer                        '0 ,1
Public NoInternetConnected As Integer                 '0 ,1

Public auto_new_database As Boolean                   'auto download new database

Public LoadPlayMusic As String
Public ShowPlayerOnLoad As String                     '"true","false"

Public currentSlideShowPath As String
Public setServer As String

'display album type
Public DisplayAlbumLong As String
Public DisplayAlbumLongSearch As String
Public DisplayAlbumLongPlaylist As String
Public MPlayerPath As String



Public StringsubList As String ' director  production  actor
Public setMonitor As String     '0: Monitor OFF; 1: Monitor ON
Public setDisplayTrackType  As String   '0: Small; 1: Large
Public setDisplayDvdContol As String    '0: Top; 1:Bottom
Public setEnableSeekOfsset As Boolean     'For enable offset
Public setStreamType As Integer           '1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath


Public Const int_Time2HideDVD As Long = 2                        'time to hide dvd control in seconds
Public Const int_Time2HideMouse As Integer = 10                         'time to hide mouse in seconds
Public Const int_MaxPlayCount As Integer = 3

'Show advertising on video screen
Public Type BannerType
   filename As String
   Length As Long
   start As Long
'''   Played As Boolean
End Type
Public BannerShuffle As Boolean
Public BannerHeight As Single
Public Banners() As BannerType
Public BannerList() As Integer
Public BannerIndex As Integer                      'Current Loading banner
Public BannerDisplayed As Boolean
Public BannerCurrent As BannerType
'=========================================================================


'===========================================================================================================
'Variable to store at run time
Public run_bShowingInputCode As Boolean
Public run_bRequestConnecting As Boolean             'requestconnecting
Public run_TimeHidePassed As Integer                 'time in seconds that passed with no action to the mouse or keyboard to hide dvd control
Public run_TimeHideMouse As Integer
Public run_iOldZoomLevel As Integer                   'store the zoom level of the previous video_ts.ifo to set it the same
Public run_MiniScalePercent As Single
Public run_DVDScalePercent As Single
Public run_bShowControl As Boolean
Public run_iGlobalAudioChannel As Integer                       '0 left ,1 right
Public run_LoadingLastMusic As Boolean
Public run_ShowingBookmark As Boolean                             'showing saving bookmark dialogbox
Public run_FakeTime As String
Public run_Region() As Byte
Public run_RegionFull() As Byte
Public run_PreviousRootMenu As Boolean                        'decide whether previous is in root menu mode
Public run_stringDefaultPlayListPath As String
Public run_RestoreRECT As RECTM                                  'In normal mode(Not in micro)
Public run_FormVideoLoaded As Boolean
Public run_ShowLoading As Boolean
Public run_loading As Boolean
Public run_DelayRefreshPopup As Integer
Public run_iDelayPopup As Integer               'Time for hide popup
Public run_iVolumeLevel As Integer                    'Volume Level
Public run_bVolumeMuted As Boolean                  'For unregistered user(change volume to mute)
Public run_iPlayTrackCount As Long
Public run_bUpdating As Boolean
Public run_bServerImageFolderExist As Boolean
Public run_bDisplayingDVDControl As Boolean                 'DVD Control is displayed
'===============Fake time====================
   Public run_FakeSeekTime As Long
   Public run_FakeSeekMax As Long
   Public run_PlayState As Integer
'==============================
'===============Waiting====================
   Public run_WaitingMode As Boolean
   Public run_WaitingMinute As Long                    'time has been waited
'==============================
Public b_TextBoxGetFocus As Boolean
Public b_DefaultLoadType    As Integer                      '1  =  FullScreenPlayer
Public b_DefaultAutoConnect As Boolean                      'true=AutoConnection
Public s_DefaultParameter    As String                      'DefaultLoad parameters for autoconnection
Public s_DefaultVLCExtension As String
Public s_DefaultPowerDVDExtension As String

Public playChapterType As String                   ' "True" , "False"    to make it play only one chapter or all chapter from that IFO
'===========================================================================================================
Public Const RegPath = "Software\VB and VBA Program Settings\SlyDVD\Folder"
''Public boolNoPlayBackWithCloneDisplay As Boolean                  'Don't make client play song just control only

'''Public Property Let MplayerPath(vNewValue As String)
'''   On Error GoTo Error
'''   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, RegPath, "WinampPath", vNewValue, REG_SZ
'''   Exit Property
'''Error:
'''   WriteEvent "Let MPlayerPath", Err.Description, Err.Source
'''End Property
'''Public Property Get MplayerPath() As String
'''   On Error GoTo Error
'''   MplayerPath = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, RegPath, "WinampPath", REG_SZ)
'''   Exit Property
'''Error:
'''   WriteEvent "Get MPlayerPath", Err.Description, Err.Source
'''End Property
Public Property Get AdvPath() As String
   On Error GoTo errDesc:
   AdvPath = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, RegPath, "AdvPath", REG_SZ)
errDesc:
End Property
Public Property Let AdvPath(path As String)
   On Error GoTo errDesc:
   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, RegPath, "AdvPath", path, REG_SZ
errDesc:
End Property
Public Sub repeatOneMplayer()
   On Error GoTo Error
   'for mplayerc only
   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Software\Gabest\Media Player Classic\Settings", "Loop", 0, REG_DWORD
   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Software\Gabest\Media Player Classic\Settings", "LoopNum", 1, REG_DWORD
   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Software\Gabest\Media Player Classic\Settings", "DefaultVideoFrame", 4, REG_DWORD        'Touch window from inside
   
   Exit Sub
Error:
   WriteEvent "repeatOneMplayer", Err.Description, Err.Source
End Sub
Public Sub RefreshAutoPlay()
   'Restore to default play with vlc
   s_DefaultVLCExtension = "mp4"
   AutoPlayEnabled = True
End Sub

Public Function MountDaemonISO(lpFileName As String) As Boolean
On Error GoTo Error:
   DaemonPath = CPlayer.DaemonPath
   Shell DaemonPath & " -mount 0, " & """" & lpFileName & """"
   ' Sleep 3000
   Exit Function
Error:
   WriteEvent "MountDaemonISO", Err.Description & " Path = " & CPlayer.DaemonPath, Err.Source
End Function

Public Function UnMountDaemonISO() As Boolean
   On Error GoTo Error:
   Shell DaemonPath & " -unmount 0 "
Error:
End Function

Public Function SetToISOMode(lpFileName As String) As Boolean
   'UIModeFlag
   '
   Dim iDrive As Integer
   If s_DriveMount <> "" Then
      iDrive = Asc(LCase(s_DriveMount)) - 97
   Else
      iDrive = -1
   End If
   If iDrive >= 0 And iDrive < 26 Then
'''      SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIFocusCDDrive", iDrive, REG_DWORD
'''      SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIModeFlag", 1, REG_DWORD
'''      SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIFileMode", 0, REG_DWORD
      UnMountDaemonISO
      Sleep 1000
      MountDaemonISO lpFileName
      SetToISOMode = True
   End If
End Function

'playerObject.url = s_DriveMount & ":\VIDEO_TS\VIDEO_TS.IFO"



Public Property Get IsISOIFO(lpPath As String) As Boolean
   'VIDEO_TS
   If isFolderExist(lpPath) Then
      If isFileExist(fso.BuildPath(lpPath, "VIDEO_TS\VIDEO_TS.IFO")) Then
         IsISOIFO = True
      End If
      'isFolderExist
   End If
   
End Property
Public Property Get IsHD_DVD(lpPath As String) As Boolean
'''Blue HD DVD Structure
'''BDMV\MovieObject.bdmv
'''
'''==========================
'''HD dvd
'''HVDVD_TS\HVDVD_TS\BLACK.EVO
   If isFolderExist(lpPath) Then
      If isFileExist(fso.BuildPath(lpPath, "HVDVD_TS\BLACK.EVO")) Then
         IsHD_DVD = True
      End If
      'isFolderExist
   End If
   
End Property
Public Property Get IsBLURAY(lpPath As String) As Boolean
   If isFolderExist(lpPath) Then
      If isFileExist(fso.BuildPath(lpPath, "BDMV\MovieObject.bdmv")) Then
         IsBLURAY = True
      End If
      'isFolderExist
   End If
End Property


