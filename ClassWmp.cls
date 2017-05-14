VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClassWmp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Implements IPlayer

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

Private playerObject As WindowsMediaPlayer
Private playerSource As Player
Private WithEvents playerTimer As Timer
Attribute playerTimer.VB_VarHelpID = -1
Private PlayerTask As EnumTimerTask

Private ply_iVolume As Single
Private ply_bMute As Boolean
Private ply_hParent As Long
Private ply_hNewParent As Long
Private ply_bChangingSubtitle As Boolean
Private ply_CurrentPosition As Single                                      'Old Position for changing subtitle
Private ply_CurrentTitle As Integer                                        'Old Title    for changing subtitle

Private Function IPlayer_NextChapter() As Boolean
   '
End Function
Private Function IPlayer_PreviousChapter() As Boolean
   '
End Function

Private Function SetWmpURL(newURL As String) As IWMPMedia
   On Error GoTo Error
   Dim objWmp As IWMPMedia

   Set SetWmpURL = playerObject.newMedia(newURL)
   Exit Function
Error:
End Function

Public Property Get Visible() As Boolean
   Visible = playerObject.Visible
End Property

Public Property Let Visible(iValue As Boolean)
   playerObject.Visible = iValue
End Property


Private Sub Class_Terminate()
   IPlayer_ClearPlayList
End Sub

Private Property Get IPlayer_AudioLanguageIndex() As Integer
   IPlayer_AudioLanguageIndex = playerObject.Controls.currentAudioLanguageIndex
End Property
Private Property Let IPlayer_AudioLanguageIndex(RHS As Integer)
'
End Property

Private Property Get IPlayer_ChapterCount() As Integer
   IPlayer_ChapterCount = playerObject.currentPlaylist.count
End Property

Private Sub IPlayer_ClearPlayList()
   UnMountDaemonISO
   playerObject.currentMedia = SetWmpURL("")
End Sub

Private Function IPlayer_CurrentChapter() As Long
   IPlayer_CurrentChapter = val(playerObject.currentMedia.getItemInfo("chapterNum"))
End Function

Private Property Get IPlayer_duration() As Single
   IPlayer_duration = playerObject.currentMedia.Duration
End Property

Private Property Get IPlayer_getBitrateSong() As String
    Dim ft As String    'file type :wma,mp3
    If IPlayer_MediaIsnothing = False Then
      ft = playerObject.currentMedia.getItemInfo("FileType") & " "
    End If
    IPlayer_getBitrateSong = UCase(ft)
End Property

Private Function IPlayer_GotoRootMenu() As Boolean
   playerObject.dvd.topMenu
End Function

Private Property Get IPlayer_HasVideo() As Boolean
   IPlayer_HasVideo = IPlayer_hVideo(ply_hParent) <> 0
End Property

Private Function IPlayer_hVideo(ByVal hSource As Long) As Long
   On Error GoTo Error
   Dim lhwnd As Long
   lhwnd = FindWindowEx(hSource, 0, "WMPVideoWindow", vbNullString)
   If lhwnd = 0 Then lhwnd = FindWindowEx(hSource, 0, "VideoRenderer", vbNullString)
   IPlayer_hVideo = lhwnd
   Exit Function
Error:
   WriteEvent "IPlayer_hVideo", Err.Description, Err.Source
End Function

Private Property Get IPlayer_isInMenuMode() As Boolean
   IPlayer_isInMenuMode = (playerObject.dvd.isAvailable("resume") And playerObject.Status <> "Finished")
End Property

Private Property Get IPlayer_MediaIsnothing() As Boolean
On Error Resume Next
   IPlayer_MediaIsnothing = True
   IPlayer_MediaIsnothing = (playerObject.currentMedia Is Nothing)
End Property

Private Sub IPlayer_Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
   playerObject.Move left, top, Width, Height
End Sub

Private Property Let IPlayer_Mute(ByVal RHS As Boolean)
   ply_bMute = RHS
   If ply_bMute Then playerObject.Settings.Volume = 0 Else playerObject.Settings.Volume = ply_iVolume
End Property

Private Property Get IPlayer_Mute() As Boolean
   IPlayer_Mute = ply_bMute
End Property

Private Sub IPlayer_object(wmpObject As Object, wmpTimer As Timer, SourcePlayer As Player)
   Set playerObject = wmpObject
   Set playerTimer = wmpTimer
   Set playerSource = SourcePlayer
   ply_hParent = playerObject.Container.hwnd
End Sub

Private Sub IPlayer_Pause()
   playerObject.Controls.Pause
End Sub

Private Sub IPlayer_Play()
   playerObject.Controls.Play
End Sub

Private Function IPlayer_playState() As Integer
On Error Resume Next
   IPlayer_playState = playerObject.playState
End Function


Private Property Get IPlayer_Seeks() As Single
   IPlayer_Seeks = playerObject.Controls.currentPosition
End Property

Private Property Let IPlayer_Seeks(RHS As Single)
   playerObject.Controls.Pause
   playerObject.Controls.currentPosition = RHS
   playerObject.Controls.Play
End Property

Private Function IPlayer_SelectChapter(ByVal iChapter As Integer) As Boolean
   playerObject.Controls.playItem playerObject.currentPlaylist.item(iChapter)
End Function

Private Function IPlayer_SelectTitle(ByVal iTitle As Integer) As Boolean
   playerObject.Controls.playItem playerObject.currentPlaylist.item(iTitle)
End Function

Private Sub IPlayer_SetNewParent(ByVal hNewParent As Long)
   If SetParent(IPlayer_hVideo(ply_hParent), hNewParent) <> 0 Then
      ply_hNewParent = hNewParent
   Else
      ply_hNewParent = 0
   End If
End Sub

Private Sub IPlayer_RestoreParent()
   SetParent IPlayer_hVideo(ply_hNewParent), ply_hParent
   ply_hNewParent = 0
End Sub

Private Property Get IPlayer_Status() As String
   IPlayer_Status = playerObject.Status
End Property

Private Sub IPlayer_Stops()
   playerObject.Controls.Stop
End Sub

Private Property Let IPlayer_stretchToFit(RHS As Boolean)
   playerObject.stretchToFit = RHS
End Property

Private Function IPlayer_SwitchAudio(Optional iChannel As Integer = -1) As Integer
   Dim iNewChannel As Integer
   On Error Resume Next
   If iChannel = -1 Then
      'Switch only for external
      'iNewChannel = ((playerObject.Controls.currentAudioLanguageIndex + 1) Mod playerObject.Controls.audioLanguageCount) '+ 1
      iNewChannel = (playerObject.Controls.currentAudioLanguageIndex + 1)
      If iNewChannel > playerObject.Controls.AudioLanguageCount Then
         iNewChannel = 1
      End If
   Else
      If iChannel < playerObject.Controls.AudioLanguageCount Then
         iNewChannel = (iChannel + 1)        'Start from 1
      Else
         iNewChannel = 1
      End If
   End If
   playerObject.Controls.currentAudioLanguageIndex = iNewChannel: DoEvents
   'Error if can't change audio channel
   'DoEvents
   IPlayer_SwitchAudio = playerObject.Controls.currentAudioLanguageIndex
   On Error GoTo 0
End Function


Private Function IPlayer_SwitchSubtitle(Optional iSubtitle As Integer = -1) As Integer
On Error GoTo errDesc:
   Dim oldPos As Long
   Dim i As Integer
   Dim titlenum As Integer

   If ply_bChangingSubtitle Then Exit Function
   ply_bChangingSubtitle = True
   Screen.MousePointer = MousePointerConstants.vbHourglass
   sendToFlash FrmMain.Swf(IndexSwf), "MouseState", True
   If playerSource.UrlExtension = "ifo" Or playerSource.UrlExtension = "mp4" Then
      '(1 Movie,2 TVSeries,4 Music,8 Karaoke)
      If Not Infos(int_current_index).trackExternal Then
         If val((SlyVariable("<" & PlayTrackInfo(int_current_index).Language & "_id>"))) = 8 Then
            'if the track is internal and it is karaoke then don't turn the subtitle on/off
            Screen.MousePointer = MousePointerConstants.vbDefault
            sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
            ply_bChangingSubtitle = False
            Exit Function
         End If
      End If
      If playerSource.UrlExtension = "mp4" Then
         TurnHaaliOnOff PlayTrackInfo(int_current_index).SubTitle
         TurnFFDShowsubTitle = PlayTrackInfo(int_current_index).SubTitle
      Else
         TurnWmpTitleOnOff PlayTrackInfo(int_current_index).SubTitle
      End If
      
      ply_CurrentPosition = IPlayer_Seeks
      OldWMPPos = ply_CurrentPosition
      CurrentFind = subTitled
      startNew = True
      Screen.MousePointer = vbHourglass
      run_loading = True
      DoEvents
      
      IPlayer_url = playerSource.url            'Reload the same track again
      playerSource.Volume = 0
      FrmMain.picMovieBackground.Visible = False
   End If
   SetForegroundWindow FrmMain.hwnd
   Screen.MousePointer = MousePointerConstants.vbDefault
   sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
   ply_bChangingSubtitle = False
   Exit Function
errDesc:
  ply_bChangingSubtitle = False
  Screen.MousePointer = MousePointerConstants.vbDefault
  sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
  WriteEvent "setSubTitleWMP", Err.Description, Err.Source
End Function

Private Property Get IPlayer_TitleCount() As Integer
   IPlayer_TitleCount = playerObject.currentPlaylist.count
End Property

Private Property Let IPlayer_UiMode(RHS As String)
   playerObject.UiMode = RHS
End Property

Private Property Get IPlayer_UiMode() As String
   IPlayer_UiMode = playerObject.UiMode
End Property

Private Property Let IPlayer_url(ByVal RHS As String)
   Dim loc_bISO As Boolean
   If playerSource.UrlExtension = "iso" Then
      loc_bISO = True
   End If
   
   Sleep 1000
   IPlayer_Volume = 0
   playerObject.Settings.autoStart = False
   IPlayer_Stops
   playerObject.currentMedia = SetWmpURL("")
   Sleep 250
   IPlayer_Stops
   If loc_bISO And s_DriveMount <> "" Then
      'iDrive = Asc(LCase(s_DriveMount)) - 97
      playerObject.url = s_DriveMount & ":\VIDEO_TS\VIDEO_TS.IFO"
   Else
      playerObject.url = RHS
   End If
   IPlayer_Play
   TimerTask = TaskWaitForLoaded
End Property

Private Property Let IPlayer_Visible(RHS As Boolean)
   playerObject.Visible = RHS
End Property

Private Property Get IPlayer_Visible() As Boolean
   IPlayer_Visible = playerObject.Visible
End Property

Private Property Let IPlayer_Volume(ByVal RHS As Single)
   If RHS > 100 Then RHS = 100 Else If RHS < 0 Then RHS = 0
   If RHS > ply_iVolume Then ply_bMute = False
   ply_iVolume = RHS
   If ply_bMute = False Then playerObject.Settings.Volume = RHS Else playerObject.Settings.Volume = 0
End Property

Private Property Get IPlayer_Volume() As Single
    IPlayer_Volume = ply_iVolume
End Property

Private Property Let TimerTask(iValue As EnumTimerTask)
   PlayerTask = iValue
   playerTimer.Enabled = False
   If iValue <> TaskNone Then playerTimer.Enabled = True
End Property

Private Property Get TimerTask() As EnumTimerTask
   TimerTask = PlayerTask
End Property

Private Property Let IPlayer_ZoomLevel(RHS As Integer)
'
End Property

Private Function IPlayer_ZoomReset() As Boolean
'
End Function

Private Sub playerTimer_Timer()
   If PlayerTask = TaskWaitForLoaded Then
      If IPlayer_Status = "Playing (Menu)" And playerObject.playState = wmppsPlaying Then
         PlayerTask = TaskNone
         playerSource.Event_LoadInDVDMenu
      ElseIf left(IPlayer_Status, 7) = "Playing" And playerObject.playState = wmppsPlaying And IPlayer_Seeks > 1 Then
         PlayerTask = TaskNone
         DoEvents
         Sleep 700            'Take time for processing other things
         playerSource.Event_Played (0)
      ElseIf playerObject.playState = wmppsStopped Or playerObject.playState = wmppsMediaEnded Or playerObject.playState = wmppsReady Then
         'When playing ifo files with only one chapter error (stops) ex. Khmer Karaoke\RSS
         'State Ready for evo extension files Have to play it
         IPlayer_Play
      End If
   End If
End Sub
