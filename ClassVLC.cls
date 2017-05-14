VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClassVLC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Implements IPlayer

Private playerObject As Object
Private playerSource As Player
Private WithEvents playerTimer As Timer
Attribute playerTimer.VB_VarHelpID = -1
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Long, ByVal wFlag As Long) As Long
Private Const GW_CHILD = 5

'Variable....................................................................................................................................................
Private PlayerTask As EnumTimerTask
Private vlc_iVolume As Single
Private vlc_bMute As Boolean
Private vlc_Duration As Single
Private vlc_iChannel As Integer
Private vlc_iChapterCount As Integer
Private ply_hHwnd As Long
Private ply_hParent As Long
Private ply_hNewParent As Long
Private ply_State As WMPPlayState
Const VLCInPlace = "VLC Plugin In-Place"
Const VLCVideo = "VLC Plugin Video"
'Variable....................................................................................................................................................

Private Sub Class_Terminate()
   'IPlayer_ClearPlayList
   TimerTask = TaskNone
End Sub
Private Function IPlayer_NextChapter() As Boolean
   GotoNextChapter
End Function
Private Function IPlayer_PreviousChapter() As Boolean
   ''
   GotoPreviousChapter
End Function

Private Property Get IPlayer_ChapterCount() As Integer
   'IPlayer_ChapterCount = playerObject.PlaylistCount
   IPlayer_ChapterCount = vlc_iChapterCount  'playerObject.object.PlaylistCount
End Property

Private Function IPlayer_hVideo(ByVal hSource As Long) As Long
   On Error GoTo Error
   Dim lhwnd As Long
   lhwnd = FindWindowEx(hSource, 0, VLCInPlace, vbNullString)
   IPlayer_hVideo = lhwnd
   Exit Function
Error:
   WriteEvent "IPlayer_hVideo", Err.Description, Err.Source
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

Private Property Let IPlayer_UiMode(RHS As String)
'None
End Property

Private Property Get IPlayer_UiMode() As String
'None
End Property

Public Property Let IPlayer_url(ByVal lpUrl As String)
   'playerObject.playlistClear
   playerObject.object.playlistClear
   If lpUrl <> "" Then
      vlc_iChannel = 1
      ply_State = wmppsStopped
      'playerObject.addTarget lpUrl, Null, 1, 0                                      '1 = CLear Play List
      If playerSource.UrlExtension = "ifo" Then                'Special case for Ifo files
         vlc_iChapterCount = GetChapterCountFromIFO(lpUrl, 1)                       'Get only first title
         lpUrl = fso.GetParentFolderName(lpUrl) & "@1"                           'Go to title 1
      End If
      Sleep 200
      playerObject.object.addTarget lpUrl, Null, 1, 0                                      '1 = CLear Play List
      IPlayer_Play
      TimerTask = TaskWaitForLoaded
   End If
End Property


Public Sub IPlayer_object(vlcObject As Object, vlcTimer As Timer, SourcePlayer As Player)
   Set playerObject = vlcObject
   Set playerTimer = vlcTimer
   Set playerSource = SourcePlayer
   ply_hParent = playerObject.Container.hwnd
   ply_hHwnd = FindWindowEx(ply_hParent, 0, VLCInPlace, vbNullString)
End Sub

Public Sub IPlayer_Play()
   ply_State = wmppsPlaying
   'playerObject.Play
   playerObject.object.Play
End Sub

Public Property Let IPlayer_Seeks(iValue As Single)
   'If IPlayer_duration > 0 Then playerObject.Position = (iValue / IPlayer_duration)
   If IPlayer_duration > 0 Then
      playerObject.object.Position = (iValue / IPlayer_duration)
      playerObject.object.Position = (iValue / IPlayer_duration)
   End If
End Property

Public Property Get IPlayer_Seeks() As Single
   IPlayer_Seeks = (val(playerObject.object.time))
End Property

Private Property Let IPlayer_ZoomLevel(RHS As Integer)
'
End Property

Private Function IPlayer_ZoomReset() As Boolean
'
End Function

Private Sub playerTimer_Timer()
   If TimerTask = TaskWaitForLoaded Then
      'If playerObject.Position > 0 And playerObject.time > 0 Then
      If playerObject.object.Position > 0 And playerObject.object.time > 0 Then
         TimerTask = TaskNone
         'If IPlayer_duration < 40 Then
            'playerSource.Event_LoadInDVDMenu
         'Else
            Dim iCurrentPosPercent As Single
         
            iCurrentPosPercent = playerObject.object.Position
            If iCurrentPosPercent <= 0 Then
               vlc_Duration = -1
            Else
               vlc_Duration = playerObject.object.Length
            End If
         
            playerSource.Event_Played (0)
         'End If
      End If
   End If
End Sub

Private Property Let TimerTask(iValue As EnumTimerTask)
   PlayerTask = iValue
   playerTimer.Enabled = False
   If iValue <> TaskNone Then playerTimer.Enabled = True
End Property

Private Property Get TimerTask() As EnumTimerTask
   TimerTask = PlayerTask
End Property

Public Property Get IPlayer_Volume() As Single
   IPlayer_Volume = vlc_iVolume
End Property

Public Property Let IPlayer_Volume(ByVal vNewValue As Single)
   If vNewValue > 100 Then vNewValue = 100 Else If vNewValue < 0 Then vNewValue = 0
   If vNewValue > vlc_iVolume Then vlc_bMute = False
   vlc_iVolume = vNewValue
'''   If vlc_bMute = False Then playerObject.Volume = vNewValue Else playerObject.Volume = 0
   If vlc_bMute = False Then playerObject.object.Volume = vNewValue Else playerObject.object.Volume = 0
End Property

Public Property Get IPlayer_Mute() As Boolean
   IPlayer_Mute = vlc_bMute
End Property

Public Property Let IPlayer_Mute(ByVal vNewValue As Boolean)
   vlc_bMute = vNewValue
'''   If vlc_bMute Then playerObject.Volume = 0 Else playerObject.Volume = vlc_iVolume
   If vlc_bMute Then playerObject.object.Volume = 0 Else playerObject.object.Volume = vlc_iVolume
End Property

Public Property Get IPlayer_duration() As Single
   IPlayer_duration = vlc_Duration
End Property

Public Function IPlayer_SwitchSubtitle(Optional iSubtitle As Integer = -1) As Integer
'   If iSubtitle < 0 Then
      Dim iKeyValue As Integer
'''      iKeyValue = playerObject.GetVariable("key-subtitle-track")
'''      playerObject.SetVariable "key-pressed", iKeyValue
      iKeyValue = playerObject.object.GetVariable("key-subtitle-track")
      playerObject.object.SetVariable "key-pressed", iKeyValue
'   Else
'   End If
End Function
Public Function IPlayer_SwitchAudio(Optional iChannel As Integer = -1) As Integer
   Dim iNewChannel As Integer
      
   Dim iKeyValue As Integer
   iKeyValue = playerObject.object.GetVariable("key-audio-track")
      
   If iChannel = -1 Then
      iNewChannel = vlc_iChannel + 1
      If iNewChannel > AudioLanguageCount Then iNewChannel = 1
   Else
      If iChannel < AudioLanguageCount Then
         iNewChannel = (iChannel + 1)        'Start from 1
      Else
         iNewChannel = 1
      End If
   End If
   SelectAudioChannel iNewChannel
   IPlayer_SwitchAudio = IPlayer_AudioLanguageIndex
      
End Function
Private Sub SwitchAudio()
   Dim iKeyValue As Integer
   iKeyValue = playerObject.object.GetVariable("key-audio-track")
   playerObject.object.SetVariable "key-pressed", iKeyValue

End Sub
Private Sub SelectAudioChannel(iChannel As Integer)         'iChannel >=1
   'Const ChannelCount = 2
   If vlc_iChannel = 1 And iChannel = 2 Then
      SwitchAudio
      vlc_iChannel = 2
   ElseIf vlc_iChannel = 2 And iChannel = 1 Then
      SwitchAudio
      vlc_iChannel = 1
   End If
End Sub
Public Function IPlayer_GotoRootMenu() As Boolean
  Dim iKeyValue As Long
   iKeyValue = playerObject.object.GetVariable("key-disc-menu")
   playerObject.object.SetVariable "key-pressed", iKeyValue
End Function

Public Sub IPlayer_Pause()
   ply_State = wmppsPaused
'''   playerObject.Pause
   playerObject.object.Pause
End Sub

Public Sub IPlayer_Stops()
   ply_State = wmppsStopped
'''   playerObject.Stop
   playerObject.object.Stop
End Sub

Public Sub IPlayer_Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
   playerObject.Move left, top, Width, Height
End Sub

Public Sub IPlayer_ClearPlayList()
'''   playerObject.playlistClear
   playerObject.object.playlistClear
End Sub

Public Property Get IPlayer_MediaIsnothing() As Boolean
   IPlayer_MediaIsnothing = False
End Property

Public Property Get IPlayer_getBitrateSong() As String
   IPlayer_getBitrateSong = ""
End Property

Public Property Get IPlayer_isInMenuMode() As Boolean
   IPlayer_isInMenuMode = False
End Property

Public Function IPlayer_SelectTitle(ByVal iTitle As Integer) As Boolean
   IPlayer_SelectTitle = True
End Function
Private Sub GotoPreviousChapter()
   Dim lKey As Long
   lKey = playerObject.object.GetVariable("key-chapter-prev")
   Call playerObject.object.SetVariable("key-pressed", lKey)
End Sub
Private Sub GotoNextChapter()
   Dim lKey As Long
   lKey = playerObject.object.GetVariable("key-chapter-next")
   Call playerObject.object.SetVariable("key-pressed", lKey)
End Sub
Public Function IPlayer_SelectChapter(ByVal iChapter As Integer) As Boolean
   '
   
   Dim i As Integer
   'Dim lKey As Long
   
   'IPlayer_Play               'If pause then play it before seek
   playerObject.object.Play            'Must player after select chapter
   ResetChapter                  'Set to chapter 1
   'Debug.Print vbTab, "Start............Seek to 0 = " & IPlayer_Seeks, "Chapter " & iChapter
   'Try to press chapter for many times as the chapter
   Sleep 150
   ShowDebug "    Seek to 0  = " & IPlayer_Seeks & "    Chapter = " & (iChapter + 1)
   For i = 1 To iChapter
      Sleep 60                   'Must delay the time else it can't send key well to player
      GotoNextChapter
      DoEvents
   Next
   Sleep 100                   'Must delay the time else it can't send key well to player

   'Debug.Print vbTab, "End.............Seek to 0 = " & IPlayer_Seeks
   IPlayer_SelectChapter = True
End Function

Public Property Get IPlayer_AudioLanguageIndex() As Integer
   IPlayer_AudioLanguageIndex = vlc_iChannel
End Property
Private Property Let IPlayer_AudioLanguageIndex(RHS As Integer)
'
End Property
Public Property Get AudioLanguageCount() As Integer
   AudioLanguageCount = 2
End Property
Public Function IPlayer_CurrentChapter() As Long
   IPlayer_CurrentChapter = -1
End Function

Public Property Get IPlayer_TitleCount() As Integer
   IPlayer_TitleCount = 10
End Property
Public Property Get IPlayer_HasVideo() As Boolean
   Dim hVideo As Long
   hVideo = FindWindowEx(ply_hHwnd, 0&, VLCVideo, vbNullString)            'Find video Handle
 
   IPlayer_HasVideo = (GetNextWindow(hVideo, GW_CHILD) <> 0)
End Property

Public Function IPlayer_playState() As Integer
   IPlayer_playState = ply_State
End Function

Public Property Let IPlayer_stretchToFit(iValue As Boolean)

End Property

Public Property Get IPlayer_Visible() As Boolean
   IPlayer_Visible = playerObject.Visible
End Property

Public Property Let IPlayer_Visible(iValue As Boolean)
   playerObject.Visible = iValue
End Property
Private Property Get IPlayer_Status() As String
'
End Property

Private Sub ResetChapter()
   IPlayer_Seeks = 0
End Sub

