VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classMPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'============================================='
'                                             '
' Works with Media Player Classic cinema  1.7.8                 ' Notice will be different in other version (class name,object ID)
'                                             '
'============================================='



Implements IPlayer
Private WithEvents playerTimer As Timer
Attribute playerTimer.VB_VarHelpID = -1
Private Const PlayerClass = "MediaPlayerClassicW"
'Private Const SubVideoClass = "Afx:00400000:b:0001002D:00000006:00000000"
Private Const VideoClass = "Afx:01270000:b:00010003:00000006:00000000"
Private PlayerTask As EnumTimerTask
Private ply_hParent As Long
Private ply_hVideo As Long
Private playerSource As Player
Private ply_Subtitle As Boolean
Private ply_hChapter As Long
Private ply_TitleCount As Integer
Private ply_ChapterStartID As Long
Private ply_ChapterCount As Integer
Private ply_iVolume As Single
Private ply_LastMove As Rect
Private ply_hNewParent As Long
Private ply_lastZoomLevel As Integer

Private ply_State  As WMPPlayState
Private hMediaClassic As Long
Private Const WM_USER = &H400

Private Const ID_SubVideoClass = &HE900&
Private Const ID_CloseFile = 804
Private Const ID_StartTitle = 2400
Private Const ID_StartAudio = 2500
Private Const ID_StartChapter = 4300
Private Const ID_Time = &H2EFB&
Private Const ID_Status = &H2EFA&
Private Const ID_DialogStatus = &H2725&
Private Const ID_InformationNStatistic = &H2724&
Private Const ID_ScrollBar = &H2726&
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202
Private Const MK_LBUTTON = &H1
Private Const ID_Exit = 816
Private Const ID_PausePlay = 889
Private Const ID_Play = 887
Private Const ID_ZoomIn = 862
Private Const ID_ZoomOut = 863
Private Const ID_ZoomReset = 861

Private Const ID_Pause = 888
Private Const ID_Stop = 890
Private Const ID_PreviousChapter = 920
Private Const ID_NextChapter = 921
Private Const ID_NextAudioDVD = 962
Private Const ID_RootMenuDVD = 923
Private Const ID_NextSubtitle = 964
Private Const ID_ToggleSubtitle = 966
Private Const ID_MuteVolume = 909
Private Const ID_ToolBarMute = 909

Private Const TB_ISBUTTONCHECKED = (WM_USER + 10)
Private Const LabelFrameRate = "Frame-rate"
Private Const PlayExternal As Boolean = False

Private Const CMD_SETAUDIOTRACK = &HA0002004
Private Const CMD_INCREASEVOLUME = &HA0004003
Private Const CMD_DECREASEVOLUME = &HA0004004
Private Const CMD_SETPOSITION = &HA0002000

Private Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Long, ByVal wFlag As Long) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function GetDlgItem Lib "user32" (ByVal hDlg As Long, ByVal nIDDlgItem As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function GetMenuItemID Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Private Declare Function MoveWindow Lib "user32" (ByVal hwnd As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal bRepaint As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function LockSetForegroundWindow Lib "user32" (ByVal uLockCode As Long) As Long
Private Declare Function AllowSetForegroundWindow Lib "user32" (ByVal dwProcessId As Long) As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Function FlashWindowEx Lib "user32" (pfwi As FLASHWINFO) As Long
Private Declare Function SendMessageCP Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As COPYDATASTRUCT) As Long


'========================For sending message to MPlayer================
Private Const WM_COPYDATA = &H4A
Private Type COPYDATASTRUCT
   dwData As Long ' A long value to pass to other application
   cbData As Long ' The size of the data pointed to by lpData
   lpData As Long ' A pointer to data
End Type
'======================================================================

Private Type FLASHWINFO
  cbSize As Long
  hwnd As Long
  dwFlags As Long
  uCount As Long
  dwTimeout As Long
End Type

Private Const PROCESS_ALL_ACCESS = &H1F0FFF
Private Const FLASHW_STOP = 0
Private Const WM_CLOSE = &H10
Private Const WM_COMMAND = &H111
Private Const WM_INITMENUPOPUP = &H117
Private Const SWP_NOMOVE = &H2
Private Const SW_HIDE = 0
Private Const SW_SHOW = 5
Private Const LSFW_LOCK = 1
Private Const LSFW_UNLOCK = 0



Private Type LongType
   MyLong As Long
End Type
Private Type Rect
   left As Long
   top As Long
   right As Long
   bottom As Long
End Type

Private Type Inter2Type
   MyInt1 As Integer
   MyInt2 As Integer
End Type

Private Enum MenuIndex
   mFile = 0
   mview = 1
   mPlay = 2
   mNavigate = 3
   mFavorite = 4
End Enum
Private Enum NavigateSubItemIndex
   naNone = -1
   naPrevious = 0
   naNext = 1
   naJumpTo = 2
   naAudioLanguage = 4
   naSubTitleLanguage = 5
   naVdeoAngle = 6
   naTitleMenu = 7
   naRootMenu = 9
   naVolume = 15
End Enum


Public Function PanScale(ByVal ZoomLevel As Long) As Boolean
   Dim i As Long
   Dim iLevel As Integer
   Dim iStep As Integer
   Dim iCommand As Long
   'Rese the zoom level
   iLevel = ZoomLevel - ply_lastZoomLevel
   'Debug.Print "ZoomLevel=" & ZoomLevel & ", iLevel = " & iLevel
   If (iLevel < 0) Then
      iStep = -1
      iCommand = ID_ZoomOut
   Else
      iStep = 1
      iCommand = ID_ZoomIn
   End If
   
   For i = 1 To Abs(iLevel) Step 1
      'Debug.Print "loop " & i
   
      SendMessageLong PlayerHwnd, WM_COMMAND, iCommand, 0&
     ' Sleep 100
   Next
   'SendMessageLong PlayerHwnd, WM_COMMAND, ID_ZoomReset, 0&
'''   If ZoomLevel > 0 Then
'''      For i = 0 To ZoomLevel Step 1
'''         SendMessageLong PlayerHwnd, WM_COMMAND, ID_ZoomIn, 0&
'''      Next
'''   Else
'''      For i = 0 To ZoomLevel Step -1
'''         SendMessageLong PlayerHwnd, WM_COMMAND, ID_ZoomOut, 0&
'''      Next
'''   End If
   ply_lastZoomLevel = ZoomLevel
   PanScale = True
End Function

Private Function SendMsgCopyData(ByVal hWndTo As Long, ByVal dwData As Long, ByVal lpData As String) As Long
   Dim locString As String
   Dim tCDS As COPYDATASTRUCT
   
      locString = lpData & Chr(0)
      tCDS.dwData = dwData
      tCDS.cbData = LenB(locString)
      tCDS.lpData = StrPtr(locString)
 
   SendMsgCopyData = SendMessage(hWndTo, WM_COPYDATA, 0, tCDS)

End Function

Sub TerminateWindows(lpHwnd As Long)
   Dim lpResult As Long
   Dim lpProcessID As Long
   Dim lngProcessID As Long
   lpResult = GetWindowThreadProcessId(lpHwnd, lpProcessID)
   lngProcessID = OpenProcess(PROCESS_ALL_ACCESS, 0&, lpProcessID)
   TerminateProcess lngProcessID, 0&
End Sub


Private Sub Class_Terminate()
   'CloseMedia
   'Sleep 200
   'SendMessageLong PlayerHwnd, WM_COMMAND, ID_Exit, 0&                  'Also close proram too
   ClosePlayer
   DoEvents
   Sleep 200
End Sub

Private Property Get IPlayer_AudioLanguageIndex() As Integer
'
   
End Property
Private Property Let IPlayer_AudioLanguageIndex(RHS As Integer)
'Audio Index starting from 0
   If (RHS >= 1) Then
      SendMsgCopyData PlayerHwnd, CMD_SETAUDIOTRACK, RHS - 1
   End If
End Property

Private Property Get IPlayer_ChapterCount() As Integer
   IPlayer_ChapterCount = ply_ChapterCount
End Property

Private Sub IPlayer_ClearPlayList()
'
End Sub

Private Function IPlayer_CurrentChapter() As Long

   IPlayer_CurrentChapter = extractChapterIndex(getWndText(ply_hChapter))
'''   Dim i As Integer
'''   InitSubMenu mNavigate, naJumpTo                    'Refresh the check box
'''   For i = 0 To ply_ChapterCount - 1
'''      If GetSubMenuCheck(PlayerMenu, ply_ChapterStartID + i) Then
'''         IPlayer_CurrentChapter = (i + 1)
'''         Exit Function
'''      End If
'''   Next

End Function

Private Property Get IPlayer_duration() As Single
  Dim MovieTime() As String
  Dim sArr() As String
  Dim StrTimeLength As String
  Dim Lens As Integer

  StrTimeLength = GetStaticText(ID_DialogStatus, ID_Time)
  
  sArr = Split(StrTimeLength, "/")
  If StrTimeLength <> "" Then
      If UBound(sArr) > 0 Then
         MovieTime = Split(sArr(1), ":")
         If UBound(MovieTime) = 1 Then
            IPlayer_duration = MovieTime(0) * 60 + MovieTime(1)
         ElseIf UBound(MovieTime) = 2 Then
            IPlayer_duration = CInt(MovieTime(0)) * 3600 + CInt(MovieTime(1)) * 60 + CInt(MovieTime(2))
         End If
      End If
   End If
End Property

Private Property Get IPlayer_getBitrateSong() As String
'
End Property

Private Function IPlayer_GotoRootMenu() As Boolean
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_RootMenuDVD, 0&
End Function

Private Property Get IPlayer_HasVideo() As Boolean
   Dim hSub As Long
   Dim hVideo As Long
   hSub = GetDlgItem(PlayerHwnd, ID_InformationNStatistic)
   If hSub <> 0 Then
      hVideo = FindWindowEx(hSub, 0, vbNullString, LabelFrameRate)
      IPlayer_HasVideo = hVideo <> 0
    End If
End Property

Private Function IPlayer_hVideo(ByVal hSource As Long) As Long
   Dim lhwnd As Long
      lhwnd = GetDlgItem(hSource, ID_SubVideoClass)
      IPlayer_hVideo = lhwnd
End Function

Private Property Get IPlayer_isInMenuMode() As Boolean
   Dim hwndDialog As Long
   Dim hwndDomain As Long
   Dim hwndDomainText As Long
   Dim hwndStatus As Long
   
   hwndDialog = GetDlgItem(PlayerHwnd, ID_InformationNStatistic)              'first one with ID =ID_Information
   hwndDialog = GetNextWindow(hwndDialog, 2)                           'There are 2 Dialog with the same ID
   IPlayer_isInMenuMode = FindWindowEx(hwndDialog, 0, vbNullString, "Video Title Set Menu") <> 0

End Property

Private Property Get IPlayer_MediaIsnothing() As Boolean
'
End Property

Private Sub IPlayer_Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)

   ply_LastMove.left = (left / Screen.TwipsPerPixelX)
   ply_LastMove.top = (top / Screen.TwipsPerPixelY)
   ply_LastMove.right = (Width / Screen.TwipsPerPixelX)
   ply_LastMove.bottom = (Height / Screen.TwipsPerPixelY)
   'ply_lastZoomLevel = ZoomLevel
   
   If Not PlayExternal Then         'When playing external 2015-02-08
      
      SetWindowPos VideoParentHwnd, 0, ply_LastMove.left, ply_LastMove.top, ply_LastMove.right, ply_LastMove.bottom, SWP_NOACTIVATE Or SWP_NOZORDER
      SetWindowPos VideoHwnd, 0, ply_LastMove.left + 4, ply_LastMove.top, ply_LastMove.right, ply_LastMove.bottom, SWP_NOACTIVATE Or SWP_NOZORDER
      'Debug.Print ply_lastZoomLevel
      PanScale ZoomLevel
   End If
   
End Sub

Private Property Let IPlayer_Mute(ByVal RHS As Boolean)
   If IPlayer_Mute <> RHS Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_MuteVolume, 0&
   End If
End Property

Private Property Get IPlayer_Mute() As Boolean
   If SendMessageLong(PlayerToolBar, TB_ISBUTTONCHECKED, ID_ToolBarMute, 0) = 1 Then
      IPlayer_Mute = True
   Else
      IPlayer_Mute = False
   End If
End Property

Private Function IPlayer_NextChapter() As Boolean
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_NextChapter, 0&
End Function

Private Sub IPlayer_object(wmpObject As Object, wmpTimer As Timer, SourcePlayer As Player)
   Set playerTimer = wmpTimer
   Set playerSource = SourcePlayer

   ply_hParent = wmpObject.hwnd
End Sub

Private Sub IPlayer_Pause()
'''   ply_State = wmppsPaused
'''   If InStr(1, IPlayer_Status, "Paused", VbCompareMethod.vbTextCompare) = 0 Then
'''      Dim rV As Rect, rP As Rect
'''
'''      SendMessageLong PlayerHwnd, WM_COMMAND, ID_PausePlay, 0&
'''      IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY
'''   End If

   ply_State = wmppsPaused
   'If InStr(1, IPlayer_Status, "Paused", VbCompareMethod.vbTextCompare) = 0 Then
      Dim rV As Rect, rP As Rect
      
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_Pause, 0&
      'IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY
   'End If
End Sub

Private Sub IPlayer_Play()
   ply_State = wmppsPlaying
'''   If InStr(1, IPlayer_Status, "Paused", VbCompareMethod.vbTextCompare) > 0 Then
'''      SendMessageLong PlayerHwnd, WM_COMMAND, ID_PausePlay, 0&
'''      IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY
'''
'''   End If
'''   If InStr(1, IPlayer_Status, "Paused", VbCompareMethod.vbTextCompare) > 0 Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_Play, 0&
      'IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY
      
'''   End If
End Sub

Private Function IPlayer_playState() As Integer
   IPlayer_playState = ply_State
End Function

Private Function IPlayer_PreviousChapter() As Boolean
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_PreviousChapter, 0&
End Function

Private Sub IPlayer_RestoreParent()
   SetNewParent IPlayer_hVideo(ply_hNewParent), ply_hParent
   ply_hNewParent = 0
End Sub

Private Property Let IPlayer_Seeks(RHS As Single)
   
   On Error GoTo ErrorSeek:
'   Dim iDuration As Long
'   Const Multiply = 1
'   Dim nLen As Long
'   'IPlayer_Play
'   iDuration = IPlayer_duration
'   nLen = iDuration * Multiply + 16               'convert to pixel +16  ,8 each side
'   SetWindowWidth ScrollBarHwnd, nLen, 20
'   ScrollChange RHS * Multiply  '- 1 '+ RoundTo3(iDuration)
'
   Call SendMsgCopyData(PlayerHwnd, CMD_SETPOSITION, CStr(RHS))
ErrorSeek:
End Property

Private Sub SetWindowWidth(hWindow As Long, lWidth As Long, lHeight As Long)
   SetWindowPos hWindow, 0, 0, 0, lWidth, lHeight, SWP_NOMOVE
End Sub
Private Sub ScrollChange(Value As Long)
  Dim MousePosition As Long
  MousePosition = MakeLongs(Value + 8, 5)             '8 pixels from left
  SendMessageLong ScrollBarHwnd, WM_LBUTTONDOWN, MK_LBUTTON, MousePosition
  SendMessageLong ScrollBarHwnd, WM_LBUTTONUP, 0, 0
End Sub

Private Function MakeLongs(ByVal a As Long, ByVal B As Long) As Long
On Error GoTo Error

   Dim Longs As LongType
   Dim Ints As Inter2Type
   
   Ints.MyInt1 = CInt("&H" & Hex(a))
   Ints.MyInt2 = CInt("&H" & Hex(B))
   LSet Longs = Ints
   MakeLongs = Longs.MyLong
   Exit Function
Error:
End Function

Private Property Get IPlayer_Seeks() As Single
  Dim MovieTime() As String
  Dim sArr() As String
  Dim StrTimeLength As String
  Dim Lens As Integer

  StrTimeLength = GetStaticText(ID_DialogStatus, ID_Time)
  
  sArr = Split(StrTimeLength, "/")
  If StrTimeLength <> "" Then
      If UBound(sArr) > 0 Then
         MovieTime = Split(sArr(0), ":")
         If UBound(MovieTime) = 1 Then
            IPlayer_Seeks = MovieTime(0) * 60 + MovieTime(1)
         ElseIf UBound(MovieTime) = 2 Then
            IPlayer_Seeks = CInt(MovieTime(0)) * 3600 + CInt(MovieTime(1)) * 60 + CInt(MovieTime(2))
         End If
      End If
   End If
End Property

Private Function IPlayer_SelectChapter(ByVal iChapter As Integer) As Boolean
'
   'iChapterIndex (0 base)
   If IPlayer_ChapterCount > 0 Then
      SendMessageLong PlayerHwnd, WM_COMMAND, (ID_StartChapter + iChapter), 0&
   End If
   
End Function

Private Function IPlayer_SelectTitle(ByVal iTitle As Integer) As Boolean
   'Start From 1
   If iTitle > 0 Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_StartTitle + iTitle - 1, 0&
      RefreshTitle
      IPlayer_SelectTitle = True
   Else
      IPlayer_SelectTitle = False
   End If
End Function

Private Sub IPlayer_SetNewParent(ByVal hNewParent As Long)
   If SetNewParent(IPlayer_hVideo(ply_hParent), hNewParent) <> 0 Then
      ply_hNewParent = hNewParent
   Else
      ply_hNewParent = 0
   End If

End Sub

Private Property Get IPlayer_Status() As String
   IPlayer_Status = GetStaticText(ID_DialogStatus, ID_Status)
End Property

Private Sub IPlayer_Stops()
   ply_State = wmppsStopped
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_Stop, 0&
End Sub

Private Property Let IPlayer_stretchToFit(RHS As Boolean)
'
End Property

Private Function IPlayer_SwitchAudio(Optional iChannel As Integer = -1) As Integer
   'SendMessageLong PlayerHwnd, WM_COMMAND, ID_NextAudioDVD, 0&
   Dim iNewChannel As Integer
      
   If iChannel = -1 Then
      Debug.Print AudioLanguageCount
      'iNewChannel = vlc_iChannel + 1
      'If iNewChannel > AudioLanguageCount Then iNewChannel = 1
   Else
      If iChannel < AudioLanguageCount Then
         iNewChannel = (iChannel + 1)        'Start from 1
      Else
         iNewChannel = 1
      End If
   End If
   'SelectAudioChannel iNewChannel
   IPlayer_AudioLanguageIndex = iNewChannel
'''   IPlayer_SwitchAudio = IPlayer_AudioLanguageIndex
   
End Function

Public Property Get AudioLanguageCount() As Integer
   Dim n As Integer
   If playerSource.UrlExtension = "ifo" Then
      InitSubMenu mNavigate, naAudioLanguage
      n = GetMenuItemCount(GetMenuLevelHwnd(mNavigate, naAudioLanguage))
      AudioLanguageCount = n
   Else
      AudioLanguageCount = 2
   End If
End Property

'''Private Sub SelectAudioChannel(iIndex As Integer)
'''   If playerSource.UrlExtension = "ifo" Then
'''      SendMessageLong PlayerHwnd, WM_COMMAND, ID_StartAudio + iIndex - 1, 0&
'''   End If
'''End Sub

Private Function IPlayer_SwitchSubtitle(Optional iSubtitle As Integer = -1) As Integer
'
   ShowSubtitle True
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_NextSubtitle, 0&
End Function

Private Property Get IPlayer_TitleCount() As Integer
   IPlayer_TitleCount = ply_TitleCount
End Property

Private Property Let IPlayer_UiMode(RHS As String)
'
End Property

Private Property Get IPlayer_UiMode() As String
'
End Property

Private Property Let IPlayer_url(ByVal RHS As String)
   Dim loc_bISO As Boolean
   If playerSource.IsMPlayerInstalled Then
      'Debug.Print "URLLLLLL"
      ply_Subtitle = False
      ply_State = wmppsStopped
      'AllowSetForegroundWindow App.threadID
      
      LockSetForegroundWindow (LSFW_LOCK)
      ClosePlayer
      hMediaClassic = 0
      ply_hVideo = 0
      If playerSource.UrlExtension = "iso" Then
         SetToISOMode (RHS)
         loc_bISO = True
      End If
      
      If loc_bISO And s_DriveMount <> "" Then
         Shell playerSource.MediaPlayerPath & " " & """" & s_DriveMount & ":\VIDEO_TS\VIDEO_TS.IFO" & """" & " /slave 12345"
      Else
         Shell playerSource.MediaPlayerPath & " " & """" & RHS & """" & " /slave 12345"
      End If
      'Debug.Print "Reset zoom"
      
      'Shell playerSource.MediaPlayerPath & " " & """" & RHS & """" & " /slave 12345"
      LockSetForegroundWindow LSFW_UNLOCK
      TimerTask = TaskWaitForLoaded
      
   End If
End Property

Private Property Let IPlayer_Visible(RHS As Boolean)
   If RHS Then
      ShowWindow VideoParentHwnd, SW_SHOW
   Else
      ShowWindow VideoParentHwnd, SW_HIDE
   End If
End Property

Private Property Get IPlayer_Visible() As Boolean
   IPlayer_Visible = (IsWindowVisible(VideoParentHwnd) = 1)
End Property

Private Property Let IPlayer_Volume(ByVal RHS As Single)
   Dim i As Integer
   
   If RHS < 0 Then RHS = 0 Else If RHS > 100 Then RHS = 100
     
   For i = 100 To 0 Step -5 'mute the volume
      SendMsgCopyData PlayerHwnd, CMD_DECREASEVOLUME, ""
   Next
   For i = 1 To RHS Step 5
      SendMsgCopyData PlayerHwnd, CMD_INCREASEVOLUME, ""
   Next
   ply_iVolume = RHS
''''  Dim MousePosition As Long
''''  If RHS > 100 Then RHS = 100 Else If RHS < 0 Then RHS = 0
''''  SetWindowWidth PlayerVolume, 100, 20
''''  ply_iVolume = RHS
''''  RHS = (100 - 9 * 2) * RHS / 100
''''  MousePosition = MakeLongs(RHS + 9, 2)              '11 pixels from left
''''  SendMessageLong PlayerVolume, WM_LBUTTONDOWN, MK_LBUTTON, MousePosition
''''  SendMessageLong PlayerVolume, WM_LBUTTONUP, 0, 0
End Property

Private Property Get IPlayer_Volume() As Single
'
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
' hwndToolBar
Private Property Get PlayerToolBar() As Long
   PlayerToolBar = FindWindowEx(PlayerHwnd, 0, "ToolbarWindow32", vbNullString)
End Property

Public Property Get PlayerVolume() As Long
   PlayerVolume = FindWindowEx(PlayerToolBar, 0, "msctls_trackbar32", vbNullString)
End Property

Private Property Get PlayerHwnd() As Long
   Dim hwndNeroExternal As Long
   If hMediaClassic = 0 Then
      hwndNeroExternal = FindWindow(PlayerClass, vbNullString)
      If hwndNeroExternal = 0 Then
         'hwndNeroExternal = FindWindowEx(ply_hParent, 0, Nero_VdeoParent_Class, vbNullString)
         hMediaClassic = 0
      Else
         hMediaClassic = hwndNeroExternal
         PlayerHwnd = hwndNeroExternal
      End If
   Else
      PlayerHwnd = hMediaClassic
   End If
End Property

Private Property Let IPlayer_ZoomLevel(RHS As Integer)
'
End Property

Private Function IPlayer_ZoomReset() As Boolean
   'play
   ply_lastZoomLevel = 0
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_ZoomReset, 0&       'reset video zoom when start
   'Debug.Print "Zoom reset"
End Function

Private Sub playerTimer_Timer()
   If TimerTask = TaskWaitForLoaded Then
      If playerSource.Volume = 0 Then IPlayer_Volume = 0
      If VideoParentHwnd <> 0 Then
         'Debug.Print "PlayerTime_Timer"
         If IPlayer_isInMenuMode Then
            PlayerTask = TaskNone
            playerSource.Event_LoadInDVDMenu
         ElseIf IPlayer_Seeks > 0 Then
            PlayerTask = TaskNone
            playerSource.Event_Played (0)
         Else
            'When playing ifo files with only one chapter error (stops) ex. Khmer Karaoke\RSS
            'IPlayer_Play
         End If
         'InitMenuBar 0
         InitSubMenu mFile, naNone
         RefreshTitle
         HidePlayerProgram
         StopFlashWindow PlayerHwnd
         
      End If
   End If

End Sub
Private Property Get VideoHwnd() As Long
   Dim hSub As Long
   Dim hVideo As Long
   If ply_hVideo = 0 Then
      hVideo = GetDlgItem(PlayerHwnd, ID_SubVideoClass)
      'hVideo = FindWindowEx(PlayerHwnd, 0, "Afx:012A0000:b:00010003:00000006:00000000", vbNullString)
      'hVideo = FindWindowEx(PlayerHwnd, 0, vbNullString, vbNullString)
      If hVideo <> 0 Then
         ply_hVideo = hVideo
      ElseIf hVideo = 0 And IPlayer_HasVideo Then
         ply_hVideo = hSub
      End If
   End If
   VideoHwnd = ply_hVideo
End Property
Private Property Get VideoParentHwnd() As Long
   Dim hSub As Long
   Dim hVideo As Long
   hSub = GetDlgItem(PlayerHwnd, ID_SubVideoClass)
   If hSub <> 0 Then
      VideoParentHwnd = hSub
   Else
      'VideoParentHwnd = FindWindowEx(ply_hParent, 0, VideoClass, vbNullString)
      'hSub = GetDlgItem(ply_hParent, ID_SubVideoClass)
      'VideoParentHwnd = FindWindowEx(ply_hParent, 0, vbNullString, vbNullString)
      VideoParentHwnd = GetDlgItem(ply_hParent, ID_SubVideoClass)
   End If
End Property

Private Sub ShowSubtitle(bOn As Boolean)
   If ply_Subtitle <> bOn Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_ToggleSubtitle, 0&
      ply_Subtitle = bOn
   End If
End Sub

Private Sub HidePlayerProgram()
   If Not PlayExternal Then
      'SetParent PlayerHwnd, playerSource.HidePlayerHwnd
      SetNewParent VideoHwnd, ply_hParent
   End If
End Sub

Private Function GetStaticText(DialogID As Long, ID As Long) As String
  Dim s As String
  Dim nLen As Long
  Dim hText As Long
  hText = GetDlgItem(GetDlgItem(PlayerHwnd, DialogID), ID)
  s = String(255, Chr(0))
  nLen = GetWindowText(hText, s, Len(s))
  GetStaticText = left(s, nLen)
End Function

''Private Function GetStaticText(ID As Long) As String
''  Dim s As String
''  Dim nLen As Long
''  Dim hText As Long
''  hText = GetDlgItem(GetDlgItem(PlayerHwnd, ID_DialogStatus), ID)
''  s = String(255, Chr(0))
''  nLen = GetWindowText(hText, s, Len(s))
''  GetStaticText = left(s, nLen)
''End Function

Private Property Get ScrollBarHwnd() As Long
   ScrollBarHwnd = GetDlgItem(PlayerHwnd, ID_ScrollBar)
End Property

Private Sub InitSubMenu(MenuBarIndex As MenuIndex, SubMenu As NavigateSubItemIndex)
Exit Sub 'Error during initialize the menu 2015-02-21
   If SubMenu = naNone Then
      SendMessageLong PlayerHwnd, WM_INITMENUPOPUP, PlayerMenu, MakeLongs(0, 0)
   Else
      Dim hMenuBar As Long
      hMenuBar = GetSubMenu(PlayerMenu, MenuBarIndex)
      SendMessageLong PlayerHwnd, WM_INITMENUPOPUP, hMenuBar, MakeLongs(SubMenu, 0)
   End If
End Sub
Private Property Get GetMenuLevelHwnd(MenuBarIndex As MenuIndex, SubMenu As NavigateSubItemIndex) As Long
   Dim hMenuBar As Long
   
   hMenuBar = GetSubMenu(PlayerMenu, MenuBarIndex)
   
   If SubMenu <> naNone Then
      hMenuBar = GetSubMenu(hMenuBar, SubMenu)
   End If
   GetMenuLevelHwnd = hMenuBar
End Property

Private Sub RefreshTitle()
  On Error Resume Next
  Dim i As Integer
  Dim n As Integer
  Dim loc_Title As String
  
  InitSubMenu mNavigate, naJumpTo
  n = GetMenuItemCount(GetMenuLevelHwnd(mNavigate, naJumpTo))
  ply_TitleCount = 0
  ply_ChapterCount = 0
  ply_ChapterStartID = 0
  ply_hChapter = 0
  For i = 0 To n - 1
      loc_Title = GetSubMenuText(PlayerMenu, ID_StartTitle + i)
      If InStr(1, loc_Title, "Title ", vbTextCompare) = 1 Then
         ply_TitleCount = ply_TitleCount + 1
      ElseIf InStr(1, loc_Title, "Chapter ", vbTextCompare) = 1 Then
         If ply_ChapterCount = 0 Then ply_ChapterStartID = (ID_StartTitle + i)                  'ID for chapter
         ply_ChapterCount = ply_ChapterCount + 1
      End If
  Next
  If (ply_ChapterCount = 0) Then
      InitPlayerInfomation
  End If
End Sub
Private Function extractChapterIndex(chapterText As String) As Long
   'Sample Chapter:::Chapter 1 (1/8)
   Dim i As Integer
   Dim lString As String
   Dim aString() As String
   
   i = InStr(chapterText, "(")
   lString = Mid(chapterText, i + 1, Len(chapterText) - i - 1)
   aString = Split(lString, "/")
   If UBound(aString) > 0 Then
      extractChapterIndex = val(aString(0))
   End If
End Function

Private Function extractChapterCount(chapterText As String) As Long
   'Sample Chapter:::Chapter 1 (1/8)
   Dim i As Integer
   Dim lString As String
   Dim aString() As String
   
   i = InStr(chapterText, "(")
   lString = Mid(chapterText, i + 1, Len(chapterText) - i - 1)
   aString = Split(lString, "/")
   If UBound(aString) > 0 Then
      extractChapterCount = val(aString(1))
   End If
   'extractChapterCount = aString
End Function
Public Sub InitPlayerInfomation()
   'Dim hPlayer As Long
   Dim hDlg As Long
   Dim hFirstDlg As Long
   Dim hNextDlg As Long
   Dim lpWindowsClass As String
   Dim lpWindowstext As String
   Dim lpWindowsID As Long
   Dim hNextItem As Long
   Dim hFirstItem As Long
   Dim txtText As String
   
   hFirstDlg = GetWindow(PlayerHwnd, GW_CHILD)
   hNextDlg = hFirstDlg
   Do While hNextDlg <> 0
      lpWindowstext = getWndText(hNextDlg)
      lpWindowsClass = getWndClass(hNextDlg)
      lpWindowsID = controlID(hNextDlg)
      If (lpWindowsID = &H2724&) Then
         hFirstItem = GetWindow(hNextDlg, GW_CHILD)
         
         hNextItem = hFirstItem
         Do While hNextItem <> 0
            txtText = getWndText(hNextItem)
            If (InStr(1, txtText, "Chapter", vbTextCompare)) > 0 And (InStr(txtText, "/") > 0) Then
               'Found chapter
               ply_hChapter = hNextItem
               ply_ChapterCount = extractChapterCount(txtText)
               'Debug.Print Mid(txtText, InStr(txtText, "("))
               'Sample Chapter text:::::::::::::::::::::Chapter 1 (1/8)
               'ply_ChapterCount
               'Debug.Print "Found chapter = " & txtText
            End If
            hNextItem = GetWindow(hNextItem, GW_HWNDNEXT)
         Loop
      End If

      hNextDlg = GetWindow(hNextDlg, GW_HWNDNEXT)
      If hNextDlg = hFirstDlg Then Exit Do
   Loop

End Sub

Private Property Get PlayerMenu() As Long
   PlayerMenu = GetMenu(PlayerHwnd)
End Property
Private Sub ClosePlayer()
   'SendMessageLong PlayerHwnd, WM_COMMAND, ID_Exit, 0&
   'SendMessage PlayerHwnd, WM_CLOSE, 0&, 0&
   TerminateWindows PlayerHwnd
   UnMountDaemonISO
End Sub

Private Sub CloseMedia()
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_CloseFile, 0&
End Sub
Function SetNewParent(hWndChild As Long, hwndParent As Long) As Integer
   Dim hwndOldActive As Long
   If GetParent(hWndChild) <> hwndParent Then
      LockSetForegroundWindow LSFW_LOCK
      hwndOldActive = GetForegroundWindow
      SetParent hWndChild, hwndParent
      LockSetForegroundWindow LSFW_UNLOCK
      SetForegroundWindow hwndOldActive
      
      SetNewParent = 1
   Else
      SetNewParent = 1
   End If
End Function

Private Sub StopFlashWindow(hwnd As Long)
   Dim pfwi As FLASHWINFO
   pfwi.cbSize = Len(pfwi)
   pfwi.dwFlags = FLASHW_STOP
   pfwi.hwnd = hwnd
   FlashWindowEx pfwi
End Sub
