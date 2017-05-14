VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit


Dim CurrentPlayer As IPlayer
Attribute CurrentPlayer.VB_VarHelpID = -1

Dim ply_PlayWith As playerEnum
Dim ply_Timer As Timer
Dim ply_WmpObject As Object
Dim ply_VlcObject As Object
Dim ply_Url As String
Dim ply_ext As String
Public HidePlayerHwnd As Long

Event Played(iStatus As Integer)
Event StartPlaying()
Event PositionChange(newValue As Single)
Event LoadInDVDMenu()


Public Property Get Duration() As Single
   Duration = CurrentPlayer.Duration
End Property

Public Function SwitchSubtitle(Optional iSubtitle As Integer) As Integer
   SwitchSubtitle = CurrentPlayer.SwitchSubtitle(iSubtitle)
'   CurrentPlayer.SwitchSubtitle
End Function

Public Function SwitchAudio(Optional iChannel As Integer) As Integer
   SwitchAudio = CurrentPlayer.SwitchAudio(iChannel)
End Function

Public Property Get Mute() As Boolean
   Mute = CurrentPlayer.Mute
End Property

Public Property Let Mute(iValue As Boolean)
   CurrentPlayer.Mute = iValue
End Property

Public Sub Pause()
   CurrentPlayer.Pause
End Sub

Public Property Get Seeks() As Single
   Seeks = CurrentPlayer.Seeks
End Property
Public Property Let Seeks(iValue As Single)
   CurrentPlayer.Seeks = iValue
End Property

Public Sub ClearPlayList()
   CurrentPlayer.ClearPlayList
   
End Sub
Public Sub Stops()
   CurrentPlayer.Stops
End Sub

Public Property Let url(ByVal lpUrl As String)
  
   ply_Url = lpUrl
   ply_ext = LCase(fso.GetExtensionName(lpUrl))
   CurrentPlayer.url = lpUrl
End Property

Public Property Let Volume(ByVal iValue As Single)
   CurrentPlayer.Volume = iValue
End Property

Public Property Get Volume() As Single
   Volume = CurrentPlayer.Volume
End Property

Public Property Let TimerObject(iValue As Timer)
   Set ply_Timer = iValue
End Property

Public Sub Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
   CurrentPlayer.Move left, top, Width, Height, ZoomLevel
End Sub

Public Sub SetObjects(ByVal objWmp As WindowsMediaPlayer, ByVal objVlc As Object)
   Set ply_WmpObject = objWmp
   Set ply_VlcObject = objVlc
End Sub
Public Property Get PlayWith() As playerEnum
   PlayWith = ply_PlayWith
End Property
Public Property Let PlayWith(iPlay As playerEnum)
   ply_PlayWith = iPlay
   
   If Not CurrentPlayer Is Nothing Then
      CurrentPlayer.RestoreParent
   End If
   str_previous_Track = ""                          'Clear old track when switch from one player to another player
   If Not CurrentPlayer Is Nothing Then CurrentPlayer.Stops
   If ply_PlayWith = VideoLan Then
      Set CurrentPlayer = New ClassVLC
      ply_VlcObject.Visible = True
      ply_WmpObject.Visible = False
      Call CurrentPlayer.object(ply_VlcObject, ply_Timer, Me)

   ElseIf ply_PlayWith = WindowMedia Then
      Set CurrentPlayer = New ClassWmp
      ply_WmpObject.stretchToFit = True
      ply_WmpObject.Visible = True
      If Not ply_VlcObject Is Nothing Then ply_VlcObject.Visible = False
      Call CurrentPlayer.object(ply_WmpObject, ply_Timer, Me)
   ElseIf ply_PlayWith = nero Then
      Set CurrentPlayer = New classNero
      ply_WmpObject.Visible = False
      Call CurrentPlayer.object(ply_WmpObject.Container, ply_Timer, Me)
   ElseIf ply_PlayWith = MediaPlayer Then
      Set CurrentPlayer = New classMPlayer
      ply_WmpObject.Visible = False
      If Not ply_VlcObject Is Nothing Then ply_VlcObject.Visible = False
      Call CurrentPlayer.object(ply_WmpObject.Container, ply_Timer, Me)
   ElseIf ply_PlayWith = PowerDVD Then
      Set CurrentPlayer = New classPowerDVD
      ply_WmpObject.Visible = False
      If Not ply_VlcObject Is Nothing Then ply_VlcObject.Visible = False
      Call CurrentPlayer.object(ply_WmpObject.Container, ply_Timer, Me)
   End If
End Property

Public Property Get MediaIsnothing() As Boolean
   MediaIsnothing = CurrentPlayer.MediaIsnothing
End Property

Public Property Get getBitrateSong() As String
   getBitrateSong = CurrentPlayer.getBitrateSong
End Property

Public Property Get IsInMenuMode() As Boolean
   IsInMenuMode = CurrentPlayer.IsInMenuMode
End Property

Public Function SelectTitle(ByVal iTitle As Integer) As Boolean
   SelectTitle = CurrentPlayer.SelectTitle(iTitle)
End Function
Public Function NextChapter() As Boolean
   CurrentPlayer.NextChapter
End Function
Public Function PreviousChapter() As Boolean
   CurrentPlayer.PreviousChapter
End Function
Public Function SelectChapter(ByVal iChapter As Integer) As Boolean
   SelectChapter = CurrentPlayer.SelectChapter(iChapter)
End Function
Public Property Get AudioLanguageIndex() As Integer
   AudioLanguageIndex = CurrentPlayer.AudioLanguageIndex
End Property
Public Sub Play()
   CurrentPlayer.Play
End Sub
Public Function currentChapter() As Long
   currentChapter = CurrentPlayer.currentChapter
End Function

Public Property Get chapterCount() As Integer
   chapterCount = CurrentPlayer.chapterCount
End Property
Public Property Get TitleCount() As Integer
   TitleCount = CurrentPlayer.TitleCount
End Property


Public Function playState() As WMPPlayState
   playState = CurrentPlayer.playState
End Function
Public Property Let stretchToFit(iValue As Boolean)
   CurrentPlayer.stretchToFit = iValue
End Property

Public Property Get Visible() As Boolean
   Visible = CurrentPlayer.Visible
End Property
Public Property Let Visible(iValue As Boolean)
   CurrentPlayer.Visible = iValue
End Property

Public Function GotoRootMenu() As Boolean
   CurrentPlayer.GotoRootMenu
End Function
Public Property Get Status() As String
   Status = CurrentPlayer.Status
End Property

Friend Sub Event_Played(iStatus As Integer)
   RaiseEvent Played(iStatus)
End Sub

Friend Sub Event_StartPlaying()
   RaiseEvent StartPlaying
End Sub

Friend Sub Event_PositionChange(newValue As Single)
   RaiseEvent PositionChange(newValue)
End Sub

Friend Sub Event_LoadInDVDMenu()
   RaiseEvent LoadInDVDMenu
End Sub
Public Function hVideo(ByVal hSource As Long) As Long
   hVideo = CurrentPlayer.hVideo(hSource)

End Function
Public Property Get UiMode() As String
   UiMode = CurrentPlayer.UiMode
End Property

Public Property Let UiMode(iValue As String)
   CurrentPlayer.UiMode = iValue
End Property

Public Sub SetNewParent(hNewParent As Long)
   CurrentPlayer.SetNewParent hNewParent
End Sub
Public Sub RestoreParent()
   CurrentPlayer.RestoreParent
   
End Sub

Public Property Get url() As String
   url = ply_Url
End Property
Public Property Get UrlExtension() As String
   UrlExtension = ply_ext
End Property

Public Function ZoomReset() As Boolean
   ZoomReset = CurrentPlayer.ZoomReset
End Function

Private Sub Class_Terminate()
   Set CurrentPlayer = Nothing
   Set ply_VlcObject = Nothing
   Set ply_WmpObject = Nothing
End Sub
Public Property Get IsVLCInstalled() As Boolean
   IsVLCInstalled = Not (ply_VlcObject Is Nothing)
End Property
Public Property Get HasVideo() As Boolean
   HasVideo = CurrentPlayer.HasVideo
End Property
Public Property Get IsPowerDVDInstalled() As Boolean
   IsPowerDVDInstalled = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Classes\Applications\PowerDVD.exe\shell\Open\Command", "", REG_SZ) <> ""
End Property
Public Property Get IsNVIDIAInstalled() As Boolean
'HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}
   Dim loc_DriverDesc As String
   loc_DriverDesc = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000", "DriverDesc", REG_SZ)
   IsNVIDIAInstalled = InStr(1, loc_DriverDesc, "NVIDIA GeForce", vbTextCompare) > 0
End Property
Public Property Get MediaPlayerPath() As String
   MediaPlayerPath = Settings.MPlayerPath
End Property
Public Property Let MediaPlayerPath(vNewValue As String)
   Settings.MPlayerPath = vNewValue
End Property
Public Property Get IsMPlayerInstalled() As Boolean
   IsMPlayerInstalled = isFileExist(MediaPlayerPath)
End Property
Public Property Get DaemonPath() As String
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
   Dim loc_Result As String
   Dim loc_iPos As Integer
   '"C:\Program Files\D-Tools\daemon.exe"  -lang 1033
   loc_Result = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "DAEMON Tools-1033", REG_SZ)
   If loc_Result = "" Then
      loc_Result = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, "SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "DAEMON Tools", REG_SZ)
      If loc_Result = "" Then
         loc_Result = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, "SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "DAEMON Tools Lite", REG_SZ)
      End If
   End If
   loc_iPos = InStr(2, loc_Result, """")
   If loc_iPos > 0 Then
      DaemonPath = Mid(loc_Result, 2, loc_iPos - 2)
   End If
End Property
Public Property Get IsDaemonInstalled() As Boolean
   IsDaemonInstalled = isFileExist(DaemonPath)
End Property
Public Property Get PowerDVDPath() As String
   Dim loc_Result As String
   Dim loc_iSpaceIndex As Long
   loc_Result = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Classes\Applications\PowerDVD.exe\shell\Open\Command", "", REG_SZ)
   If loc_Result <> "" Then
      loc_iSpaceIndex = InStrRev(loc_Result, "\")
      If loc_iSpaceIndex > 0 Then
         PowerDVDPath = Mid(loc_Result, 2, loc_iSpaceIndex - 2)
      End If
   End If
End Property


