VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Winamp_Control"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Type tagFlash
  cbSize As Long
  hwnd As Long
  dwFlags As Long
  uCount As Long
  dwTimeout As Long
End Type


Dim Player_Path As String  '= "C:\Program Files\Winamp\winamp.exe"
Dim hwndVideo As Long      'Store visualization handle
Dim oldOpenFileName As String          'Store old path that was open from file name

Private boolStopCalled As Boolean
Private boolPlaying As Boolean
Private boolRegisteredTimer As Boolean
Private boolVisualizationRunning As Boolean
'Public boolTrackIsChanged As Boolean
Private oldWind As Long
Private oldMedia As Long

Public WithEvents MediaTimer As Timer
Attribute MediaTimer.VB_VarHelpID = -1

'-----------------Store Value----------------------------
Dim old_currentTrackPosition As Long

Dim hwndVisualUsing As Long
Public hwndVisualParent As Long                     'For start visualization
Dim visualizationOldRect As Rect

'------------------------------------------------------
Private Const WM_COPYDATA = &H4A
Private Const ID_VIS_NEXT = 40382
Private Const ID_VIS_PREV = 40383
Private Const ID_VIS_RANDOM = 40384
Private Const ID_VIS_FS = 40389
Private Const IPC_SETVISWND = 611
'============================
Private Const FLASHW_STOP = 0
Private Const WM_SYSCOMMAND = &H112
Private Const SC_MINIMIZE = &HF020&
Private Const SC_RESTORE = &HF120&
'=================================
Private Const ID_VIS_CFG = 40390
Private Const ID_VIS_MENU = 40391

Private Type COPYDATASTRUCT
   dwData As Long
   cbData As Long
   lpData As Long
End Type

Public Enum StatusEnum
   Stopping = 0
   Playing = 1
   Pausing = 3
   Opening = 5
   FileNotFound = 4
End Enum

Public Enum FileInfoEnum
   SampleRate = 0
   bitRate = 1
   Channels = 2
End Enum

Private Const IPC_GETVISWND = 612
Private Const WA_PREVTRACK = 40044
Private Const WA_NEXTTRACK = 40048
Private Const WA_PLAY = 40045
Private Const WA_PAUSE = 40046
Private Const WA_STOP = 40047
Private Const WA_FADEOUTSTOP = 40147
Private Const WA_STOPAFTERTRACK = 40157
Private Const WA_FASTFORWARD = 40148                 '5 secs
Private Const WA_FASTREWIND = 40144                  '5 secs
Private Const WA_PLAYLISTHOME = 40154
Private Const WA_PLAYLISTEND = 40158
Private Const WA_DIALOGOPENFILE = 40029
Private Const WA_DIALOGOPENURL = 40155
Private Const WA_DIALOGFILEINFO = 40188
Private Const WA_TIMEDISPLAYELAPSED = 40037
Private Const WA_TIMEDISPLAYREMAINING = 40038
Private Const WA_TOGGLEPREFERENCES = 40012
Private Const WA_DIALOGVISUALOPTIONS = 40190
Private Const WA_DIALOGVISUALPLUGINOPTIONS = 40191
Private Const WA_STARTVISUALPLUGIN = 40192
Private Const WA_TOGGLEABOUT = 40041
Private Const WA_TOGGLEAUTOSCROLL = 40189
Private Const WA_TOGGLEALWAYSONTOP = 40019
Private Const WA_TOGGLEWINDOWSHADE = 40064
Private Const WA_TOGGLEPLAYLISTWINDOWSHADE = 40266
Private Const WA_TOGGLEDOUBLESIZE = 40165
Private Const WA_TOGGLEEQ = 40036
Private Const WA_TOGGLEPLAYLIST = 40040
Private Const WA_TOGGLEMAINWINDOW = 40258
Private Const WA_TOGGLEMINIBROWSER = 40298
Private Const WA_TOGGLEEASYMOVE = 40186
Private Const WA_TOGGLEREPEAT = 40022
Private Const WA_TOGGLESHUFFLE = 40023
Private Const WA_DIALOGJUMPTOTIME = 40193
Private Const WA_DIALOGJUMPTOFILE = 40194
Private Const WA_DIALOGSKINSELECTOR = 40219
Private Const WA_DIALOGCONFIGUREVISUALPLUGIN = 40221
Private Const WA_RELOADSKIN = 40291
Private Const WA_CLOSE = 40001


Private Const WA_GETVERSION = 0
Private Const WA_PLAYFILE = 100
Private Const WA_CLEARPLAYLIST = 101
Private Const WA_GETSTATUS = 104
Private Const WA_GETLISTLENGTH = 124
Private Const WA_GETLISTPOS = 125
Private Const WA_SETPLAYLISTPOS = 121
Private Const WA_GETINFO = 126
Private Const WA_TEST = 3002



Private Const WA_GETTRACKPOSITION = 105
Private Const WA_GETTRACKLENGTH = 105
Private Const WA_SEEKTOPOSITION = 106
Private Const WA_SETVOLUME = 122
Private Const WA_SETBALANCE = 123
Private Const WA_SETREPEAT = 253
Private Const WA_GETEQDATA = 127
Private Const WA_SETEQDATA = 128

'--------------------------------------'
'       Winamp User Events             '
'--------------------------------------'
Event SetVolume(Volume As Long)
Event Stops()
Event CurrentItemChange(TrackIndex As Long)
Event TrackSeek(seekIndex As Long, maxSeek As Long)
Event VisualStart()



Private Const SW_HIDE = 0
Private Const SWP_HIDEWINDOW = &H80
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOSIZE = &H1
Private Const SW_MINIMIZE = 6
Private Const SW_NORMAL = 1


'--------------------------------------'
'       Windows API Declarations       '
'--------------------------------------'
Private Declare Function FlashWindowE Lib "user32" Alias "FlashWindowEx" (ByRef flag As tagFlash) As Long
Private Declare Function FlashWindow Lib "user32" (ByVal hwnd As Long, ByVal bInvert As Long) As Long



Private Const WM_COMMAND = &H111                      'Used in SendMessage call
Private Const WM_USER = &H400                        'Used in SendMessage call
Private Const vbQuote As String = """"               'Used in shelling to WinAMP
Private currentStatus As StatusEnum

Public Function Play() As Boolean
   On Error GoTo Error
   Play = True
   CMediaPlayer.MediaClassCommand ToolPlay
   currentStatus = Playing
   If boolVisualizationRunning Then
      StartVisualization
   End If
   Exit Function
Error:
   WriteEvent "Play", Err.Description, Err.Source
End Function
Public Function duration() As Long
   On Error GoTo Error
    '-------------------------------------------------'
    'Retrieves the length of the current track in secs'
    '-------------------------------------------------'
    duration = CMediaPlayer.movieDuration
     'duration = SendMessage(hwndWinamp, WM_USER, 1, WA_GETTRACKLENGTH)
   Exit Function
Error:
   WriteEvent "duration", Err.Description, Err.Source
End Function

Public Function IsStart(setTimer As Timer) As Boolean
   On Error Resume Next
   '---------------------------------------------------------------'
   'Runs an instance of WinAMP if an instance isn't already running'
   '---------------------------------------------------------------'
   Dim returnValue As Long
   If Not boolRegisteredTimer Then
      Set MediaTimer = setTimer
      MediaTimer.Enabled = True
      boolRegisteredTimer = True
   End If
   hwndVisualParent = FrmMain.picMovieBackground.hwnd
   boolStopCalled = (GetStatus = Stopping)
   boolPlaying = (GetStatus = Playing)
   IsStart = (returnValue <> 0) And (hwndWinamp <> 0)
End Function
Public Property Let Volume(newValue As Long)
   On Error GoTo Error
   SendMessage hwndWinamp, WM_USER, newValue, WA_SETVOLUME
   Exit Property
Error:
   WriteEvent "Let Volume", Err.Description, Err.Source
End Property
Public Property Get TrackPosition() As Long
   On Error GoTo Error
    '---------------------------------------------------'
    'Retrieves the position of the current track in secs'
    '---------------------------------------------------'
    TrackPosition = CMediaPlayer.GetDurationPlay
   Exit Property
Error:
   WriteEvent "Get TrackPosition", Err.Description, Err.Source
End Property
Public Sub DVDKaraok(boolOn As Boolean)
   On Error GoTo Error
   If boolOn Then
      CMediaPlayer.SwitchAudio VoiceOff
   Else
      CMediaPlayer.SwitchAudio VoiceOn
   End If
   Exit Sub
Error:
   WriteEvent "DVDKaraok", Err.Description, Err.Source
End Sub
Public Property Let TrackPosition(PositionInSec As Long)
   On Error GoTo Error
    '----------------------------------------------------'
    'Seeks to the specified position in the current track'
    '----------------------------------------------------'
    CMediaPlayer.SeeksTime PositionInSec
     'SendMessage hwndWinamp, WM_USER, PositionInSec * 1000, WA_SEEKTOPOSITION
   Exit Property
Error:
   WriteEvent "Let TrackPosition", Err.Description, Err.Source
End Property

Public Sub CloseWinamp()
   On Error GoTo Error
   Stops
   CMediaPlayer.TerminateMediaClassic
   MediaTimer.Enabled = False
   Exit Sub
Error:
   WriteEvent "CloseWinamp", Err.Description, Err.Source
End Sub
Public Sub ClearPlayList()
   On Error GoTo Error
   SendMessage hwndWinamp, WM_USER, 0, WA_CLEARPLAYLIST
   Exit Sub
Error:
   WriteEvent "ClearPlayList", Err.Description, Err.Source
End Sub

Public Sub Stops()
   On Error GoTo Error
   CMediaPlayer.MediaClassCommand ToolStop
   SetParent hwndVideo, CMediaPlayer.getScriptClass(CMediaPlayer.hMedia) ' hwndVisualParentOld
   currentStatus = Stopping
   boolPlaying = False
   Exit Sub
Error:
   WriteEvent "Stops", Err.Description, Err.Source
End Sub

Public Sub Pause()
   On Error GoTo Error
   CMediaPlayer.MediaClassCommand ToolPause
   currentStatus = Pausing
   Exit Sub
Error:
   WriteEvent "Pause", Err.Description, Err.Source
End Sub
Public Function GetStatus() As StatusEnum
   On Error GoTo Error
   GetStatus = CMediaPlayer.movieStatus     '  currentStatus   ' SendMessage(hwndWinamp, WM_USER, 0, WA_GETSTATUS)
   Exit Function
Error:
   WriteEvent "GetStatus", Err.Description, Err.Source
End Function
Public Sub AddToPlaylist2(filename As String)
   On Error GoTo Error
   CMediaPlayer.MuteMedia = True

   If filename <> vbNullString Then
      If oldOpenFileName = filename Then        'don't load the same file
         Me.Stops
         Me.Play
      Else
         Call CMediaPlayer.StartMediaClassic(MPlayerPath & "\mplayerc.exe", filename)
      End If
      currentStatus = Playing
      boolTrackIsChanged = True
      old_currentTrackPosition = 0
   End If
   Exit Sub
Error:
   WriteEvent "AddToPlaylist2", Err.Description, Err.Source
End Sub

Private Sub Class_Terminate()
   On Error GoTo Error
   CloseWinamp
   MediaTimer.Enabled = False
   Exit Sub
Error:
   WriteEvent "Class_Terminate", Err.Description, Err.Source
End Sub

Private Sub MediaTimer_Timer()
   On Error GoTo Error
   Dim newTrackPosition As Long
   Dim hwndDetachVisual As Long
   Dim sCurrentExt As String
   Dim iDuration As Single
                                 Dim oldP As Long
                                 Dim j As Long
   
   newTrackPosition = TrackPosition
   If boolTrackIsChanged And GetStatus = Playing And TrackPosition = 0 Then
      If CMediaPlayer.IsRootMenuAvailable Or CMediaPlayer.getTitleCount > 0 Then 'if this line join with the above line it doesn't seek to the next chapter
         ' if there are titles or root menu is available ' EDID:2005-11-15
         'It is playing but in introduction
         newTrackPosition = 1      'make it change to goto root menu
      End If
   End If
   If (newTrackPosition <> old_currentTrackPosition And newTrackPosition <> 0) Then 'Or old_currentTrackPosition = 0 Then
''''''''''''      If startNew Then                 '07/03/06
         'restart play file when change track
        If b_loadAlready And run_LoadingLastMusic = False Then
            '07/03/06==================================================================
            If boolTrackIsChanged Then
               If startNew Then
                  CMediaPlayer.PlayMenu PlayMiStop
                  CMediaPlayer.PlayMenu PlayMiPlay
               End If
            End If ' if BoolTrackIschanged
            '07/03/06==================================================================
        End If
        'end restart play file
''''''''''''      End If
      ' 3 seconds end
      If (currentStatus = Playing And CMediaPlayer.movieStatus = Pausing And newTrackPosition = 0) Or (duration - newTrackPosition < 3 And duration > 0) Then
         RaiseEvent CurrentItemChange(0)
      Else
         If int_track_count > 0 And int_current_index < int_track_count Then
            sCurrentExt = LCase(fso.GetExtensionName(PlayTrackInfo(int_current_index).TrackPath))
            If boolTrackIsChanged And currentStatus = Playing And newTrackPosition > 0 Then
               If sCurrentExt = "ifo" Then
                  Call CMediaPlayer.NavigateMenu(naRootMenu)            'goto root menu first(some dvds require this)
                   If Infos(int_current_index).trackExternal Then
                         PlayTrackInfo(int_current_index).MainTitle = getMainTitle 'play mainTitle
                  End If
                  Call CMediaPlayer.JumpToTitle(PlayTrackInfo(int_current_index).MainTitle)
                  Call CMediaPlayer.JumpToChapter(1, "")
                  
                  If PlayTrackInfo(int_current_index).BookmarkType > 0 Then   'Bookmark >0
                        'EDID 2005-11-02
                        If PlayTrackInfo(int_current_index).Mode <> "Internal" Then
                           If PlayTrackInfo(int_current_index).MainTitle = 0 Then
                               PlayTrackInfo(int_current_index).MainTitle = getMainTitle 'play mainTitle
                           End If
                        End If
                        'Call CMediaPlayer.JumpToTitle(PlayTrackInfo(int_current_index).mainTitle) 'internal and external play mainTitle
                        'CMediaPlayer.JumpToChapter 1, ""
                  Else 'bookmark =0
                     If PlayTrackInfo(int_current_index).Mode <> "Internal" Then
                        CMediaPlayer.JumpToChapter 1, ""
                     Else
                        CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).NoTrack, ""
                     End If
                  End If
               Else
'                  If Not PlayTrackInfo(int_current_index).albumAvailable Then
'                     PlayTrackInfo(int_current_index).BookmarkChapter = 0
'                  Else
'                     PlayTrackInfo(int_current_index).BookmarkChapter = PlayTrackInfo(int_current_index).NoTrack
'                  End If
                  If PlayTrackInfo(int_current_index).albumAvailable And (sCurrentExt = "ifo" Or sCurrentExt = "mp4") Then
                     PlayTrackInfo(int_current_index).BookmarkChapter = PlayTrackInfo(int_current_index).NoTrack
                  Else
                     PlayTrackInfo(int_current_index).BookmarkChapter = 0
                  End If
                  
                  If PlayTrackInfo(int_current_index).Mode = "Internal" Then
                     'if the internal track that was add from that time
                     If PlayTrackInfo(int_current_index).NoTrack > 1 Or PlayTrackInfo(int_current_index).TrackJumpTime = "" Then
                        'don't make it show again 2 times for the first track
                        ' PlayTrackInfo(int_current_index).AlbumAvailable
                        'If IsSeekable(int_current_index) Then
                        If PlayTrackInfo(int_current_index).albumAvailable Then
                           CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).NoTrack, PlayTrackInfo(int_current_index).TrackJumpTime
                        End If
                     End If
                  End If
               End If
               
               If PlayTrackInfo(int_current_index).BookmarkType > 0 Then   'BookMark >0
                  If PlayTrackInfo(int_current_index).BookmarkType = 2 Or PlayTrackInfo(int_current_index).BookmarkType = 4 Then
                     If sCurrentExt = "ifo" Then
                        'Call CMediaPlayer.NavigateMenu(naRootMenu)
                        Call CMediaPlayer.JumpToTitle(PlayTrackInfo(int_current_index).MainTitle)
                        'PlayTrackInfo(int_current_index).TrackLength
'                        If PlayTrackInfo(int_current_index).albumAvailable Then             ' 2006-01-19
                           If PlayTrackInfo(int_current_index).BookmarkType = 4 Then PlayTrackInfo(int_current_index).BookmarkChapter = PlayTrackInfo(int_current_index).NoTrack
                              If PlayTrackInfo(int_current_index).TrackLength > 0 And Not PlayTrackInfo(int_current_index).BookmarkChapter + 1 > CMediaPlayer.getChapterCount Then
                                 PlayTrackInfo(int_current_index).BookmarkLength = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).TrackLength
                              ElseIf PlayTrackInfo(int_current_index).BookmarkChapter + 1 > CMediaPlayer.getChapterCount Then
                                 PlayTrackInfo(int_current_index).BookmarkLength = duration
                              Else
                                 ' PlayTrackInfo(int_current_index).BookmarkLength = Time2Second(PlayTrackInfo(int_current_index).TrackJumpTime)
                                 'get time from database if no then jump to next chapter to get time
                                 If PlayTrackInfo(int_current_index).TrackJumpTime <= 0 Then
                                    oldP = TrackPosition
                                    CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).BookmarkChapter + 1, ""
                                    'Sleep 1000
                                    For j = 0 To 10000000
                                       If boolExit Then Exit Sub
                                       If Not b_pause And Not b_play Then Exit Sub
                                       If int_track_count <= 0 Then Exit Sub
                                       DoEvents
                                       If TrackPosition <> oldP Then Exit For
                                    Next
                                    'Sleep 500                                    'sleep until next chapter time is available
                                    'PlayTrackInfo(int_current_index).BookmarkChapter = 0
                                    PlayTrackInfo(int_current_index).BookmarkLength = TrackPosition      'now BookmarkLength store the end position
                                 End If
                           End If
'                        Else                                                                                     ' 2006-01-19
'                           PlayTrackInfo(int_current_index).BookmarkLength = duration                            ' 2006-01-19
'                           PlayTrackInfo(int_current_index).BookmarkTime = 0                                     ' 2006-01-19
'                           PlayTrackInfo(int_current_index).BookmarkChapter = 0                                  ' 2006-01-19
'
'                        End If                                                                                   ' 2006-01-19
                     Else
                        If Infos(int_current_index).trackExternal = False Then
                           'now BookmarkLength store the end position
                           'GetChapterTime
                           If PlayTrackInfo(int_current_index).BookmarkChapter + 1 > CMediaPlayer.getChapterCount Then
                              PlayTrackInfo(int_current_index).BookmarkLength = duration
                           Else
                              'GetChapterTime Infos(int_current_index).trackAlbumID, PlayTrackInfo(int_current_index).language, PlayTrackInfo(int_current_index).BookmarkChapter + 1
                              PlayTrackInfo(int_current_index).BookmarkLength = Time2Second(GetChapterTime(Infos(int_current_index).trackAlbumID, PlayTrackInfo(int_current_index).Language, PlayTrackInfo(int_current_index).BookmarkChapter + 1))
                              PlayTrackInfo(int_current_index).BookmarkTime = Time2Second(GetChapterTime(Infos(int_current_index).trackAlbumID, PlayTrackInfo(int_current_index).Language, PlayTrackInfo(int_current_index).BookmarkChapter))
                           End If
                        Else
                           PlayTrackInfo(int_current_index).BookmarkChapter = 0
                        
                           PlayTrackInfo(int_current_index).BookmarkLength = duration
                        End If
                     End If
                  End If
                  If PlayTrackInfo(int_current_index).BookmarkType = 4 Then
                     If PlayTrackInfo(int_current_index).BookmarkChapter > 0 Then
                        oldP = TrackPosition
                        CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).BookmarkChapter, ""
                        For j = 0 To 10000000
                           If boolExit Then Exit Sub
                           If Not b_pause And Not b_play Then Exit Sub
                           If int_track_count <= 0 Then Exit Sub
'''                           DoEvents                   '2006-09-14 Seng
                           If TrackPosition <> oldP And TrackPosition > 2 Then Exit For
                        Next
                        PlayTrackInfo(int_current_index).BookmarkTime = TrackPosition
                        
'''                        If Time2Second(PlayTrackInfo(int_current_index).TrackLength) > 0 Then
'''                           PlayTrackInfo(int_current_index).BookmarkLength = PlayTrackInfo(int_current_index).BookmarkTime + Time2Second(PlayTrackInfo(int_current_index).TrackLength)
'''                        Else
'''                           CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).BookmarkChapter + 1, ""
'''                           For j = 0 To 10000000
'''                              If boolExit Then Exit Sub
'''                              If Not b_pause And Not b_play Then Exit Sub
'''                              If int_track_count <= 0 Then Exit Sub
'''                              DoEvents
'''                              If TrackPosition > PlayTrackInfo(int_current_index).BookmarkTime Then Exit For
'''                           Next
'''                           PlayTrackInfo(int_current_index).BookmarkLength = CMediaPlayer.GetDurationPlay
'''                        End If
                        'CMediaPlayer.JumpToChapter PlayTrackInfo(int_current_index).BookmarkChapter, ""
                     Else
                        'PlayTrackInfo(int_current_index).BookmarkTime = duration
                     End If
                  Else
                     CMediaPlayer.SeeksTime (PlayTrackInfo(int_current_index).BookmarkTime)
                  End If
               ElseIf PlayTrackInfo(int_current_index).BookmarkType = 0 Then
                  
               End If
               
'''               If StrComp(oldOpenFileName, Infos(int_current_index).TrackPath, vbTextCompare) = 0 Then
'''                  'if the same dvd
'''                  If StrComp(fso.GetFileName(Infos(int_current_index).TrackPath), "video_ts.ifo", vbTextCompare) = 0 Then
'''                     PlayTrackInfo(int_current_index).ZoomLevel = run_iOldZoomLevel
'''                  End If
'''               End If
               ZoomToLevel PlayTrackInfo(int_current_index).ZoomLevel
               run_iOldZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel
               boolTrackIsChanged = False
               CMediaPlayer.MuteMedia = False
               CMediaPlayer.enableSubtitle = PlayTrackInfo(int_current_index).SubTitle
               CMediaPlayer.SelectAudioChannel PlayTrackInfo(int_current_index).AudioChannel
               oldOpenFileName = Infos(int_current_index).TrackPath
               ' If setEnableSeekOfsset And (PlayTrackInfo(int_current_index).BookmarkType = 0 Or PlayTrackInfo(int_current_index).BookmarkType = 4) And run_LoadingLastMusic = False Then
               If PlayTrackInfo(int_current_index).seekOffset And (PlayTrackInfo(int_current_index).BookmarkType = 0 Or PlayTrackInfo(int_current_index).BookmarkType = 4) And run_LoadingLastMusic = False Then
                  'if it is bookmark then don't seek it and if loading last music don't seek it
                  CMediaPlayer.SeeksTime TrackPosition + PlayTrackInfo(int_current_index).seekOffset
               End If
               '===================  sync =============================
               
               ShowVisualization                                           'always put this line on the bottom of the block
               If CWinsock.isServerConnected Then
                  If CWinsock.ClientMusicLoaded < CWinsock.getClonePlayBackCounts Then
                     CMediaPlayer.MediaClassCommand ToolPause
                     FrmMain.picMovieBackground.Visible = False
                     run_WaitingMode = True
                  Else
                     iDuration = CMediaPlayer.GetDurationPlay
                     CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & iDuration & "&&&" & getPlayState
                     CMediaPlayer.SeeksTime iDuration
                     run_WaitingMode = False
                     'FrmMain.picMovieBackground.Visible = True
                  End If
               ElseIf CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
                  'tell server that it is loaded
                  CMediaPlayer.MediaClassCommand ToolPause
                  FrmMain.picwmp.Visible = False
                  CWinsock.Send2Server WS_COMMAND, "MusicLoaded"
                  run_WaitingMode = True
               Else
                  'FrmMain.picMovieBackground.Visible = True
               End If ' connected
               '=========================================================
               
            End If
            If Not boolTrackIsChanged And PlayTrackInfo(int_current_index).BookmarkType > 0 Then
               Select Case PlayTrackInfo(int_current_index).BookmarkType
                  Case 1      'Play till end
                  Case 2, 4     'Play till next chapter or Play only that chapter (Karaoke or music)
                     '(TrackPosition - PlayTrackInfo(int_current_index).BookmarkLength > 0) or seek
                     If CMediaPlayer.CurrentChapter <> PlayTrackInfo(int_current_index).BookmarkChapter And PlayTrackInfo(int_current_index).BookmarkChapter > 0 And sCurrentExt = "ifo" Or (TrackPosition - PlayTrackInfo(int_current_index).BookmarkLength > 0) Then
                        RaiseEvent CurrentItemChange(0)
                     End If
                  Case 3      'Play amount of time
                     If (newTrackPosition - PlayTrackInfo(int_current_index).BookmarkTime) >= PlayTrackInfo(int_current_index).BookmarkLength Then
                        RaiseEvent CurrentItemChange(0)
                     End If
               End Select
            End If
         End If
         old_currentTrackPosition = newTrackPosition
         RaiseEvent TrackSeek(newTrackPosition, duration)
         If old_currentTrackPosition > 0 And old_currentTrackPosition < 5 Then ScaleVisualization
      End If
      If startNew Then
         startNew = False
         'If Not (bool_full_vis Or str_swfNames = "Micro") Then
            SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
            SendMessageLong FrmMain.hwnd, &HF, 0, 0
         'End If
      End If
   End If
   '=============Clear mplayer focus === - sith
   old_currentTrackPosition = newTrackPosition
    Dim fWnd As Long
    fWnd = GetForegroundWindow()
    If fWnd = CMediaPlayer.hMedia Or fWnd = FrmMain.MediaPlayer.hwndVisual Then
        clearFocus
    Else
        oldWind = fWnd
    End If
    Dim a As tagFlash
    a.cbSize = Len(a)
    a.hwnd = CMediaPlayer.hMedia
    a.dwFlags = FLASHW_STOP
    FlashWindowE a
   '=========================================
   Exit Sub
Error:
   WriteEvent "MediaTimer_Timer", Err.Description, Err.Source
End Sub
Private Sub ShowVisualization()
   On Error GoTo Error
   ScaleVisualization
   SetParent hwndVideo, hwndVisualParent
   Exit Sub
Error:
   WriteEvent "ShowVisualization", Err.Description, Err.Source
End Sub
Public Sub StartVisualization()
   On Error GoTo Error
      'Timer receive this variable
      boolVisualizationRunning = True
      ScaleVisualization
   Exit Sub
Error:
   WriteEvent "StartVisualization", Err.Description, Err.Source
End Sub
Public Property Get hwndWinamp() As Long
   On Error GoTo Error
   hwndWinamp = CMediaPlayer.hMedia
   Exit Property
Error:
   WriteEvent "Get hwndWinamp", Err.Description, Err.Source
End Property

Public Property Get hwndVisual() As Long
   On Error GoTo Error
    Dim hVideoParent As Long
   'hVideoParent = FindWindowEx(hwndWinamp, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
   'FindWindowEx(hwndWinamp, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
   
   hVideoParent = CMediaPlayer.getScriptClass(CMediaPlayer.hMedia)
   hwndVisual = FindWindowEx(hVideoParent, 0, "VideoRenderer", vbNullString)
   If hwndVisual = 0 Then
      hwndVisual = FindWindowEx(FrmMain.picMovieBackground.hwnd, 0, "VideoRenderer", vbNullString)
   End If
   Exit Property
Error:
   WriteEvent "Get hwndVisual", Err.Description, Err.Source
End Property
'Public Property Get hwndVisualParentOld() As Long
'   hwndVisualParentOld = FindWindowEx(hwndWinamp, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
'
'End Property
Public Sub ScaleVisualization()
   On Error GoTo Error
   Dim visualRect As Rect
   If hwndVisual <> 0 Then hwndVisualUsing = hwndVisual
   
   GetWindowRect hwndVisual, visualizationOldRect
   GetWindowRect hwndVisualParent, visualRect
   ScaleVideo2Desire hwndVisualParent, ori_player_top / 15, visualRect.right - visualRect.left, visualRect.bottom - visualRect.top
   FrmMain.closeScreenPlayer
   'SetParent hwndVisual, FrmMain.picMovieBackground.hwnd
   Exit Sub
Error:
   WriteEvent "ScaleVisualization", Err.Description, Err.Source
End Sub
Public Sub NextVisualization()
   On Error GoTo Error
   SendMessage hwndWinamp, WM_COMMAND, ID_VIS_NEXT, 0
   Exit Sub
Error:
   WriteEvent "NextVisualization", Err.Description, Err.Source
End Sub
Public Sub PrevVisualizatoin()
   On Error GoTo Error
   SendMessage hwndWinamp, WM_COMMAND, ID_VIS_PREV, 0
   Exit Sub
Error:
   WriteEvent "PrevVisualizatoin", Err.Description, Err.Source
End Sub
Private Sub Class_Initialize()
   On Error GoTo Error
   'ReadRegCode = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, RegPath, "WinampPath", REG_SZ)
    Player_Path = MPlayerPath  '"C:\Documents and Settings\Administrator.PATRICIA.002\Desktop\mplayerc.exe"
   Exit Sub
Error:
   WriteEvent "Class_Initialize", Err.Description, Err.Source
End Sub
Public Sub ScaleVideo2Desire(hwndParent As Long, wantTop As Long, wantWidth As Long, wantHeight As Long)
   On Error GoTo Error
   Dim hwndMediaClassic As Long
   Dim hwndVideoParent As Long
   Dim loc_hwndVideo As Long
   
   
   'hwndVideoParent = FindWindowEx(CMediaPlayer.hMedia, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
   hwndVideoParent = CMediaPlayer.getScriptClass(CMediaPlayer.hMedia)
   'FindWindowEx(hwndWinamp, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
   
   loc_hwndVideo = FindWindowEx(hwndVideoParent, 0, "VideoRenderer", vbNullString)
   If loc_hwndVideo <> 0 Then hwndVideo = loc_hwndVideo
   MoveWindow CMediaPlayer.hMedia, ScreenX, 0, wantWidth, wantHeight, True
   MoveWindow hwndMediaClassic, 0, 0, wantWidth, wantHeight, True
   MoveWindow hwndVideoParent, 0, wantTop, wantWidth, wantHeight, True
   Exit Sub
Error:
   WriteEvent "ScaleVideo2Desire", Err.Description, Err.Source
End Sub
Public Sub clearFocus()
   On Error GoTo Error
    Dim i As Integer
     SetForegroundWindow oldWind '&H40278
     ShowWindow oldWind, 5
     For i = 0 To 20
        DoEvents
        SendKeys "^", 1
     Next
     FlashWindow oldWind, False
   Exit Sub
Error:
   WriteEvent "clearFocus", Err.Description, Err.Source
End Sub
