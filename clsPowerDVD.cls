VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classPowerDVD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'============================================='
'                                             '
' Works with PowerDVD     7.03.3104 only                ' Notice will be different in other version (class name,object ID,memory address)
'                                             '
'============================================='
 

Implements IPlayer
Const PlayerPath = "C:\mplayerc.exe"
'Const DaemonPath = "C:\Program files\D-Tools\daemon.exe"
Private WithEvents playerTimer As Timer
Attribute playerTimer.VB_VarHelpID = -1
Private Const PlayerClass = "MediaPlayerClassicW"
Private lpPrevWndProc As Long
Private Const VideoClass = "VideoRenderer"
Private Const videoParent = "ATL:004BA270"
Private Const PlayerTitle = "CyberLink PowerDVD"
Private PlayerTask As EnumTimerTask
Private ply_hParent As Long
Private ply_hVideoParent As Long
Private ply_hVideo As Long
Private playerSource As Player
Private ply_Subtitle As Boolean
Private ply_TitleCount As Integer
Private ply_ChapterStartID As Long
Private ply_ChapterCount As Integer
Private ply_iVolume As Single
Private ply_VideoWidth As Long
Private ply_VideoHeight As Long
Private ply_ProcessID As Long
Private ply_bPlayISO As Boolean
Private ply_zoomLevel As Integer

Private ply_LastMove As Rect
Private ply_hNewParent As Long
Private ply_PlayingFolder As Boolean
Private ply_bWaitPlayFolder As Boolean
Private ply_State  As WMPPlayState
Private ply_bExternalState As Boolean
Private hMediaClassic As Long
Private Const WM_USER = &H400

Private Const ID_SubVideoClass = &HE900&
Private Const ID_CloseFile = 804
Private Const ID_StartTitle = 2400
Private Const ID_StartAudio = 2500
Private Const ID_StartChapter = 4300
Private Const ID_Time = &H2EFB&
Private Const ID_Status = &H2EFA&
Private Const ID_Dialog = &H2725&
Private Const ID_Information = &H2724&
Private Const ID_ScrollBar = &H2726&
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202
Private Const MK_LBUTTON = &H1
Private Const ID_Exit = 816
Private Const ID_PausePlay = 889
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
Private Const ADDRESS_SeekTime = &H4B6BB4
' Private Const ID_JumpTo = 65535
Private Const KEY_VolumeDown = 45
Private Const KEY_VolumeUP = 43
Private Const KEY_Pause = 32
Private Const KEY_Play = 13


Private Const WM_NULL = &H0
Private Const SMTO_BLOCK = &H1
Private Const SMTO_ABORTIFHUNG = &H2
Private Declare Function IsWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SendMessageTimeout Lib "user32" Alias "SendMessageTimeoutA" (ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long, ByVal fuFlags As Long, ByVal uTimeout As Long, lpdwResult As Long) As Long
Private Declare Function VirtualQueryEx& Lib "kernel32" (ByVal hProcess As Long, lpAddress As Any, lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Long)
Private Declare Function UpdateWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetFocus Lib "user32" () As Long
Private Declare Function GetForegroundWindow Lib "user32" () As Long
Private Declare Function LockWindowUpdate Lib "user32" (ByVal hwndLock As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long
Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Private Declare Function GetCurrentProcessId Lib "kernel32" () As Long
Private Declare Function GetWindow Lib "user32" (ByVal hwnd As Long, ByVal wCmd As Long) As Long
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
'Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function LockSetForegroundWindow Lib "user32" (ByVal uLockCode As Long) As Long
Private Declare Function AllowSetForegroundWindow Lib "user32" (ByVal dwProcessId As Long) As Long
Private Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Function FlashWindowEx Lib "user32" (pfwi As FLASHWINFO) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Const KEYEVENTF_KEYUP = &H2
Private Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)


Private Type MEMORY_BASIC_INFORMATION
     BaseAddress As Long
     AllocationBase As Long
     AllocationProtect As Long
     RegionSize As Long
     State As Long
     Protect As Long
     lType As Long
End Type
Private Type SYSTEM_INFO
        dwOemID As Long
        dwPageSize As Long
        lpMinimumApplicationAddress As Long
        lpMaximumApplicationAddress As Long
        dwActiveProcessorMask As Long
        dwNumberOrfProcessors As Long
        dwProcessorType As Long
        dwAllocationGranularity As Long
        dwReserved As Long
End Type

Const PROCESS_VM_READ = (&H10)
Const PROCESS_VM_WRITE = (&H20)
Const PROCESS_VM_OPERATION = (&H8)
Const PROCESS_QUERY_INFORMATION = (&H400)
Const PROCESS_READ_WRITE_QUERY = PROCESS_VM_READ + PROCESS_VM_WRITE + PROCESS_VM_OPERATION + PROCESS_QUERY_INFORMATION



Private Const MEM_PRIVATE& = &H20000
Private Const MEM_COMMIT& = &H1000
Private Const PROCESS_ALL_ACCESS = &H1F0FFF
Private Const FLASHW_STOP = 0
Private Const WM_CLOSE = &H10
Private Const WM_COMMAND = &H111
Private Const WM_INITMENUPOPUP = &H117
Private Const WM_KEYDOWN = &H100
Private Const WM_KEYUP = &H101
Private Const SWP_NOMOVE = &H2
Private Const HWND_BOTTOM = 1
Private Const SW_HIDE = 0
Private Const SW_SHOW = 5
Private Const LSFW_LOCK = 1
Private Const LSFW_UNLOCK = 0
Private Const GW_CHILD = 5
Private Const DockedSeekLeft = 140
Private Const DockedSeekTop = 20          'Count from Bottom
Private Const DockedSeekRight = 208       'Count from Right
Private Const DockedSeekHeight = 11
Private Const WM_CHAR = &H102



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
Private Type FLASHWINFO
  cbSize As Long
  hwnd As Long
  dwFlags As Long
  uCount As Long
  dwTimeout As Long
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

Const SeekRight = 210
Const SeekLeft = 140
Const SeekBottom = 17
Private Enum PlayOption
   PlayFromBeginning = 1
   PlayResumeFromLast = 2
   PlayAstkPrompt = 3
End Enum

Private LoopingSeekTime As Boolean
Private SeekAddress() As Long
Private SeekStartCounter As Single
Private SeekTimes() As Long
Private SeekFoundAddress As Long
Private SeekMaxDuration As Long

'''Sub TerminateWindows(lpHwnd As Long)
'''   Dim lpResult As Long
'''   Dim lpProcessID As Long
'''   Dim lngProcessID As Long
'''   lpResult = GetWindowThreadProcessId(lpHwnd, lpProcessID)
'''   lngProcessID = OpenProcess(PROCESS_ALL_ACCESS, 0&, lpProcessID)
'''   TerminateProcess lngProcessID, 0&
'''End Sub

Sub TerminateProcessID(lpProcessID As Long)
   Dim lpResult As Long
   Dim hProcess As Long
   hProcess = OpenProcess(PROCESS_ALL_ACCESS, 0&, lpProcessID)
   TerminateProcess hProcess, 0&
   CloseHandle hProcess
End Sub

Private Sub Class_Initialize()
   ply_iVolume = -1
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
'
End Property

Private Property Get IPlayer_ChapterCount() As Integer
   IPlayer_ChapterCount = ply_ChapterCount
End Property

Private Sub IPlayer_ClearPlayList()
'
End Sub

Private Function IPlayer_CurrentChapter() As Long
'
End Function

Private Property Get IPlayer_duration() As Single
   
   If VideoHwnd <> 0 Then
      IPlayer_duration = 100
   End If
'''   Dim loc_Str As String
'''   Dim loc_TimeSeek As String
'''   Dim loc_TimeTotal As String
'''   If SeekFoundAddress <> 0 Then
'''      If SeekMaxDuration >= 0 Then
'''         IPlayer_duration = SeekMaxDuration
'''      Else
'''         loc_Str = ReadStrProcess(ply_ProcessID, SeekFoundAddress)
'''         If loc_Str <> "" Then
'''            If SplitTimeNDuration(loc_Str, loc_TimeSeek, loc_TimeTotal) Then
'''               SeekMaxDuration = Time2Second(loc_TimeTotal)
'''               IPlayer_duration = SeekMaxDuration
'''            End If
'''         End If
'''      End If
'''   End If
   
'''   If playerSource.UrlExtension = "mp4" Or playerSource.UrlExtension = "evo" Or playerSource.UrlExtension = "m2ts" Then
'''      IPlayer_duration = 7200
'''   Else
'''      IPlayer_duration = 1000
'''   End If
End Property
Private Property Get IPlayer_getBitrateSong() As String
'
End Property

Private Function IPlayer_GotoRootMenu() As Boolean
   SendMessageLong PlayerHwnd, WM_COMMAND, ID_RootMenuDVD, 0&
End Function

Private Property Get IPlayer_HasVideo() As Boolean
   IPlayer_HasVideo = True
'''   Dim hSub As Long
'''   Dim hVideo As Long
'''   hSub = GetDlgItem(PlayerHwnd, ID_Information)
'''   If hSub <> 0 Then
'''      hVideo = FindWindowEx(hSub, 0, vbNullString, LabelFrameRate)
'''      IPlayer_HasVideo = hVideo <> 0
'''    End If
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
   
   hwndDialog = GetDlgItem(PlayerHwnd, ID_Information)              'first one with ID =ID_Information
   hwndDialog = GetNextWindow(hwndDialog, 2)                           'There are 2 Dialog with the same ID
   IPlayer_isInMenuMode = FindWindowEx(hwndDialog, 0, vbNullString, "Video Title Set Menu") <> 0

End Property

Private Property Get IPlayer_MediaIsnothing() As Boolean
'
End Property

Private Sub IPlayer_Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
   'Change the size in Twips
   ply_LastMove.left = (left / Screen.TwipsPerPixelX)
   ply_LastMove.top = (top / Screen.TwipsPerPixelY)
   ply_LastMove.right = (Width / Screen.TwipsPerPixelX)
   ply_LastMove.bottom = (Height / Screen.TwipsPerPixelY)
   
'''   SetWindowPos VideoParentHwnd, 0, ply_LastMove.left, ply_LastMove.top, ply_LastMove.right, ply_LastMove.bottom, SWP_NOACTIVATE Or SWP_NOZORDER
'''   SetWindowPos VideoHwnd, 0, ply_LastMove.left + 4, ply_LastMove.top, ply_LastMove.right, ply_LastMove.bottom, SWP_NOACTIVATE Or SWP_NOZORDER
   Move

End Sub
Private Sub Move()
   On Error GoTo ErrorMove:
   Dim iWidth As Single, iHeight As Single
   Dim iScale As Single
   Dim xScale As Single, yScale As Single
   If ply_bExternalState = False Then
      xScale = ply_LastMove.right / ply_VideoWidth
      yScale = ply_LastMove.bottom / ply_VideoHeight
      
      If ply_VideoHeight * xScale > ply_LastMove.bottom Then
         iScale = yScale
      ElseIf ply_VideoWidth * yScale > ply_LastMove.right Then
         iScale = xScale
      Else
         iScale = xScale
      End If
      iWidth = ply_VideoWidth * iScale
      iHeight = ply_VideoHeight * iScale
      
      SetWindowPos VideoHwnd, 0, ply_LastMove.left + (ply_LastMove.right - iWidth) / 2, ply_LastMove.top + (ply_LastMove.bottom - iHeight) / 2, iWidth, iHeight, SWP_NOACTIVATE Or SWP_NOZORDER
   End If
ErrorMove:

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
   If ply_State <> wmppsPaused Then
         SendKey2Player KEY_Pause
         ply_State = wmppsPaused
'''      Dim rV As Rect, rP As Rect
'''
'''      SendMessageLong PlayerHwnd, WM_COMMAND, ID_PausePlay, 0&
'''      IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY
   End If
End Sub

Private Sub IPlayer_Play()
   'If IPlayer_Status = "Paused" Then
   If ply_State = wmppsPaused Then
   
      SendKey2Player KEY_Play
      IPlayer_Move ply_LastMove.left * Screen.TwipsPerPixelX, ply_LastMove.top * Screen.TwipsPerPixelY, ply_LastMove.right * Screen.TwipsPerPixelX, ply_LastMove.bottom * Screen.TwipsPerPixelY, 0
      
   End If
   ply_State = wmppsPlaying
End Sub

Private Function IPlayer_playState() As Integer
   If ply_State = wmppsPlaying Then
      If VideoHwnd = 0 Then IPlayer_playState = wmppsStopped
   Else
      IPlayer_playState = ply_State
   End If
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
   Dim rc As Rect
   Dim hForeground As Long
   Dim iSeek As Integer, seekWidth As Integer
   Dim seekY As Integer
   
   If RHS <= IPlayer_duration Then
      hForeground = GetForegroundWindow
      GetWindowRect PlayerHwnd, rc
      LockSetForegroundWindow LSFW_LOCK

      seekY = rc.bottom - rc.top - SeekBottom
      seekWidth = rc.right - rc.left - SeekRight - SeekLeft
      iSeek = RHS / IPlayer_duration * seekWidth
      ScrollChange iSeek + SeekLeft, seekY
      LockSetForegroundWindow LSFW_UNLOCK
      Move
      SetForegroundToWindow hForeground
   End If
   
ErrorSeek:
End Property

Private Sub SetWindowWidth(hWindow As Long, lWidth As Long, lHeight As Long)
   SetWindowPos hWindow, 0, 0, 0, lWidth, lHeight, SWP_NOMOVE
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
   If VideoHwnd <> 0 Then
      IPlayer_Seeks = 1
   Else
      IPlayer_Seeks = 0
   End If
   Dim loc_Str As String
   Dim loc_TimeSeek As String
   Dim loc_TimeTotal As String
   If SeekFoundAddress <> 0 Then
      loc_Str = ReadStrProcess(ply_ProcessID, SeekFoundAddress)
      If SplitTimeNDuration(loc_Str, loc_TimeSeek, loc_TimeTotal) Then
         IPlayer_Seeks = Time2Second(loc_TimeSeek)
      End If
   End If
   'IPlayer_Seeks = IPlayer_duration * GetSeekPercent * 0.0001
End Property

Private Function IPlayer_SelectChapter(ByVal iChapter As Integer) As Boolean
'
   'iChapterIndex (0 base)
''   If IPlayer_ChapterCount > 0 And ply_ChapterStartID > 0 Then
''      SendMessageLong PlayerHwnd, WM_COMMAND, (ply_ChapterStartID + iChapter), 0&
''   End If
   If IPlayer_ChapterCount > 0 Then
      SendMessageLong PlayerHwnd, WM_COMMAND, (ID_StartChapter + iChapter), 0&
   End If
   
End Function

Private Function IPlayer_SelectTitle(ByVal iTitle As Integer) As Boolean
   'Start From 1
   If iTitle > 0 Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_StartTitle + iTitle - 1, 0&
'      RefreshTitle
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
   IPlayer_Status = GetStaticText(ID_Status)
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
   SelectAudioChannel iNewChannel
'''   IPlayer_SwitchAudio = IPlayer_AudioLanguageIndex
   
End Function

Public Property Get AudioLanguageCount() As Integer
'''   Dim n As Integer
'''   If playerSource.UrlExtension = "ifo" Then
'''      InitSubMenu mNavigate, naAudioLanguage
'''      n = GetMenuItemCount(GetMenuLevelHwnd(mNavigate, naAudioLanguage))
'''      AudioLanguageCount = n
'''   Else
'''      AudioLanguageCount = 2
'''   End If
End Property

Private Sub SelectAudioChannel(iIndex As Integer)
   If playerSource.UrlExtension = "ifo" Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_StartAudio + iIndex - 1, 0&
   End If
End Sub

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
   If playerSource.IsPowerDVDInstalled Then
      Debug.Print "Start url..........."
      ply_Subtitle = False
      ply_State = wmppsStopped
      ClosePlayer
      hMediaClassic = 0
      ply_hVideoParent = 0
      ply_hVideo = 0
      LockSetForegroundWindow (LSFW_LOCK)
      SeekMaxDuration = -1
      SeekFoundAddress = 0
      ply_bPlayISO = False
      SeekStartCounter = 0
      
      ' ply_bExternalState = b_ExternalPowerDVD
      ply_bExternalState = True        'Always play externally
      SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIOSDPlayInfo", 1, REG_DWORD              'Turn info on for time
      If isFolderExist(RHS) Then
         ply_PlayingFolder = True
         ply_bWaitPlayFolder = True
         SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "DVD_HDPath", RHS, REG_SZ
         'UI_DVDPlayOption
         ply_ProcessID = Shell(playerSource.PowerDVDPath & "\powerdvd.exe ", vbHide)
      Else
         ply_PlayingFolder = False
         ply_bWaitPlayFolder = False
         If playerSource.UrlExtension = "iso" Then
            If SetToISOMode(RHS) Then
               SetPowerDVDDrive
               ply_ProcessID = Shell(playerSource.PowerDVDPath & "\powerdvd.exe", vbHide)
               ply_bPlayISO = True
            End If
         Else
            ply_ProcessID = Shell(playerSource.PowerDVDPath & "\powerdvd.exe " & """" & RHS & """", vbHide)
         End If
         
      End If
      TimerTask = TaskWaitForLoaded
      Debug.Print "End url..........."
   End If
End Property
Private Sub SetPowerDVDDrive()

   Dim iDrive As Integer
   If s_DriveMount <> "" Then
      iDrive = Asc(LCase(s_DriveMount)) - 97
   Else
      iDrive = -1
   End If
   
   SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIFocusCDDrive", iDrive, REG_DWORD
   SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIModeFlag", 1, REG_DWORD
   SetKeyValue HKEY_CURRENT_USER, "Software\Cyberlink\PowerDVD", "UIFileMode", 0, REG_DWORD

End Sub

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

Private Sub SendKey2hwnd(hwnd As Long, keyChar As Integer)
   SendMessageLong hwnd, WM_CHAR, keyChar, 0
End Sub
Private Sub SendKey2Player(keyChar As Integer)
   SendMessageLong PlayerHwnd, WM_CHAR, keyChar, 0
End Sub
'004B6AD0               volume address with 2 bytes
Private Property Let IPlayer_Volume(ByVal RHS As Single)
   Dim MousePosition As Long
   Dim i As Integer
   If RHS > 100 Then RHS = 100 Else If RHS < 0 Then RHS = 0
   'If ply_iVolume <> RHS Then
      'Decrease the volume until 0 ,coz each keypress it reduce the volume by 2 percent
      For i = 1 To 50
         SendKey2Player KEY_VolumeDown
      Next
      For i = 1 To RHS Step 2
         SendKey2Player KEY_VolumeUP
      Next
   'End If
  ply_iVolume = RHS
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
PlayerHwnd = VideoParentHwnd
'''   Dim hwndNeroExternal As Long
'''   If hMediaClassic = 0 Then
'''      hwndNeroExternal = FindWindow(PlayerClass, vbNullString)
'''      If hwndNeroExternal = 0 Then
'''         'hwndNeroExternal = FindWindowEx(ply_hParent, 0, Nero_VdeoParent_Class, vbNullString)
'''         hMediaClassic = 0
'''      Else
'''         hMediaClassic = hwndNeroExternal
'''         PlayerHwnd = hwndNeroExternal
'''      End If
'''   Else
'''      PlayerHwnd = hMediaClassic
'''   End If
End Property

Private Property Let IPlayer_ZoomLevel(RHS As Integer)
'
End Property

Private Function IPlayer_ZoomReset() As Boolean
'
End Function

Private Sub playerTimer_Timer()
   Dim loc_Result As Long
   Dim lpResult As Long
   Dim lpwResult As Long
   
   If TimerTask = TaskWaitForLoaded Then
      
      If VideoParentHwnd <> 0 Then
         If FindRegistrationDialogBox <> 0 Then SendMessageLong FindRegistrationDialogBox, WM_CLOSE, 0&, 0&
         If IsWindowVisible(VideoParentHwnd) = 0 Then
            If ply_bExternalState Then
               SetWindowPos PlayerHwnd, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE Or SWP_SHOWWINDOW Or SWP_NOSIZE
            Else
               SetWindowPos PlayerHwnd, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE Or SWP_NOSIZE
            End If
            If b_ExternalPowerDVD = False Then If playerSource.Volume = 0 Then IPlayer_Volume = 0
         End If
         'If ply_bWaitPlayFolder And IsWindowVisible(VideoParentHwnd) Then
         If ply_bWaitPlayFolder Then
            lpResult = SendMessageTimeout(PlayerHwnd, WM_NULL, 0&, 0&, SMTO_ABORTIFHUNG Or SMTO_BLOCK, 2000, lpwResult)
            If lpResult <> 0 Then
               ply_bWaitPlayFolder = False
               SendKey2Player vbKeyO
               SendKey2Player vbKeyO
               SendKey2Player vbKeyO
               'SendKey2Player vbKeyEscape
               Sleep 1000
               OpenFileByFolder
            End If
         ElseIf ply_bPlayISO Then
            SendKey2Player 13
         End If
         If IPlayer_isInMenuMode Then
            HidePlayerProgram
            PlayerTask = TaskNone
            playerSource.Event_LoadInDVDMenu
         Else
            If IPlayer_Seeks > 0 Then
               HidePlayerProgram
               PlayerTask = TaskNone
               playerSource.Event_Played (0)
            End If
            
'''         ElseIf LoopingSeekTime = False Then
'''            If SeekStartCounter = 0 Then
'''               LoopingSeekTime = True
'''               Debug.Print "Timer 1......"
'''               SeekAddress = FindTimeValueAddress(ply_ProcessID, 3)
'''               LoopingSeekTime = False
'''               Debug.Print "Timer 2......"
'''               SaveOldTimeValue
'''               SeekStartCounter = Timer
'''            Else
'''               If Abs(SeekStartCounter - Timer) > 1 Then
'''                  loc_Result = SaveOldTimeValue
'''                  If loc_Result <> 0 Then
'''                     SeekFoundAddress = loc_Result
'''                  Else
'''                     SeekStartCounter = 0       'Start finding again
'''                  End If
'''               End If
'''            End If
'''            If IPlayer_Seeks > 0 Then
'''               HidePlayerProgram
'''               PlayerTask = TaskNone
'''               playerSource.Event_Played (0)
'''            End If
         End If

      End If
   End If

End Sub
Private Property Get VideoHwnd() As Long
   Dim hSub As Long
   Dim hVideo As Long
   If ply_hVideo = 0 Or IsWindow(ply_hVideo) = 0 Then
      
      hVideo = FindWindowEx(VideoParentHwnd, 0, "VideoRenderer", vbNullString)
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
   If ply_hVideoParent = 0 Then
      Do
        hSub = FindWindowEx(0, hSub, vbNullString, PlayerTitle)
         If GetWindow(hSub, GW_CHILD) <> 0 Then
            ply_hVideoParent = hSub
            Exit Do
         End If
      Loop Until hSub = 0
   End If
   VideoParentHwnd = ply_hVideoParent
'''   hSub = FindWindowEx(0, 0, VideoParent, "CyberLink PowerDVD")   'ATL:004BA270
'''   If hSub <> 0 Then
'''      VideoParentHwnd = hSub
'''   Else
'''      VideoParentHwnd = FindWindowEx(ply_hParent, 0, VideoParent, vbNullString)
'''   End If
End Property

Private Sub ShowSubtitle(bOn As Boolean)
   If ply_Subtitle <> bOn Then
      SendMessageLong PlayerHwnd, WM_COMMAND, ID_ToggleSubtitle, 0&
      ply_Subtitle = bOn
   End If
End Sub

Private Sub HidePlayerProgram()
   Dim rc As Rect
   Dim hwndForeground As Long
   Dim hwndFocus As Long
   If ply_bExternalState = False Then
   hwndForeground = GetForegroundWindow
   Sleep 500
   hwndFocus = GetFocus
   GetWindowRect VideoHwnd, rc
   ply_VideoWidth = rc.right - rc.left
   ply_VideoHeight = rc.bottom - rc.top
   
   GetWindowRect PlayerHwnd, rc
   '''UpdateWindow VideoHwnd
'''   Sleep 20
'''   SetNewParent VideoHwnd, ply_hParent
'''   Sleep 20
   SetNewParent PlayerHwnd, FindTrayHwnd
   UpdateWindow VideoHwnd
   Sleep 2000
   SetNewParent VideoHwnd, ply_hParent
   SetForegroundToWindow hwndForeground
   LockSetForegroundWindow (LSFW_UNLOCK)
   End If
   
End Sub


Private Function GetStaticText(ID As Long) As String
  Dim s As String
  Dim nLen As Long
  Dim hText As Long
  hText = GetDlgItem(GetDlgItem(PlayerHwnd, ID_Dialog), ID)
  s = String(255, Chr(0))
  nLen = GetWindowText(hText, s, Len(s))
  GetStaticText = left(s, nLen)
End Function

Private Property Get ScrollBarHwnd() As Long
   ScrollBarHwnd = GetDlgItem(PlayerHwnd, ID_ScrollBar)
End Property





Private Sub ClosePlayer()
   'TerminateWindows PlayerHwnd
   TerminateProcessID ply_ProcessID
   Sleep 2000
   UnMountDaemonISO
   Sleep 200
End Sub
Function SetNewParent(hWndChild As Long, hwndParent As Long) As Integer
   If GetParent(hWndChild) <> hwndParent Then
      Debug.Print "Set new parent = ", SetParent(hWndChild, hwndParent)
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

Private Function GetProcessIDFromWindow(hwnd As Long) As Long
   Dim lpThreadID As Long
   Dim lpProcessID As Long
   
   lpThreadID = GetWindowThreadProcessId(hwnd, lpProcessID)
   If lpThreadID <> 0 Then GetProcessIDFromWindow = lpProcessID
End Function

Private Function GetSeekPercent() As Long
   'Return value from 0 to 10000
   GetSeekPercent = ReadMemoryLocation(VideoHwnd, ADDRESS_SeekTime)
End Function

Private Function ReadMemoryLocation(hwnd As Long, lpAddress As Long) As Long
   Dim ProcessID As Long
   Dim hProcess As Long
   Dim lByteWritten As Long
   Dim lpValue As Long
   Dim lpResult As Long
   Dim lpByteWritten As Long
   
   ProcessID = GetProcessIDFromWindow(hwnd)
   hProcess = OpenProcess(PROCESS_READ_WRITE_QUERY, False, ProcessID)
   If hProcess <> 0 Then
      lpResult = ReadProcessMemory(hProcess, ByVal lpAddress, ByVal VarPtr(lpValue), Len(lpValue), lByteWritten)
      If lpResult <> 0 Then
         ReadMemoryLocation = lpValue
      End If
      CloseHandle hProcess
   End If
   
End Function

Private Function OpenFileByFolder() As Boolean
   Debug.Print "Start open file by folder"
   Sleep 100
      SendKey2Player vbKeyO
   Sleep 100
      SendKey2hwnd FindPopupMenu, vbKeyO
   Sleep 100
      SendMessageLong FindPopupMenu, WM_KEYDOWN, &HD, 0
   Sleep 100
   Dim sOldTimer As Single
   Dim sNewTimer As Single
   Dim hwndBrowse As Long
   Dim hwndOK As Long
   sOldTimer = Timer
   Do
      hwndBrowse = FindBrowseFolderHwnd
      hwndOK = FindBrowseOKHwnd(hwndBrowse)
      DoEvents
   Loop Until (Timer - sOldTimer >= 5) Or (hwndOK <> 0)
   If hwndOK <> 0 Then        'For long wait with network browse files
      Do
         DoEvents
      Loop Until IsWindowVisible(hwndOK) = 1
   End If
   Debug.Print "Open file by folder.....", "Hwnd Browse =", hwndBrowse, "Hwnd OK =", hwndOK
    
   If isWindowEnable(hwndOK) = False Then
      SendDlgItemMessage hwndBrowse, 2, BM_CLICK, 0, 0
      Debug.Print "Cancel pressed"
   Else
      SendDlgItemMessage hwndBrowse, 1, BM_CLICK, 0, 0
      Debug.Print "OK is pressed"
   End If
End Function
Private Function FindBrowseFolderHwnd() As Long
   Dim hWindow As Long
   Dim lpProcessID As Long
   Do
   hWindow = FindWindowEx(0&, hWindow, "#32770", "Browse for Folder")
   
      If GetWindowThreadProcessId(hWindow, lpProcessID) <> 0 Then
         'Debug.Print lpProcessID
         If lpProcessID = lpProcessID Then
            FindBrowseFolderHwnd = hWindow
            Exit Do
         End If
      End If
   Loop Until hWindow = 0
   
End Function

Private Function FindBrowseOKHwnd(hwndBrowse As Long) As Long
   Dim hWindow As Long
   hWindow = FindWindowEx(hwndBrowse, 0&, "Button", "OK")
   FindBrowseOKHwnd = hWindow
End Function

Private Function FindTrayHwnd() As Long
   Dim hWindow As Long
   hWindow = FindWindowEx(0&, 0&, "Shell_TrayWnd", vbNullString)
   FindTrayHwnd = hWindow
End Function

Private Function isWindowEnable(hwnd) As Boolean
    isWindowEnable = (GetWindowLong(hwnd, GWL_STYLE) And WS_DISABLED) <> WS_DISABLED
End Function

Private Function FindPopupMenu() As Long
';'#32768      Menu handle
   FindPopupMenu = FindWindow("#32768", vbNullString)
End Function

Private Sub ScrollChange(valueX As Integer, valueY As Integer)
  Dim MousePosition As Long
  MousePosition = MakeLongs(valueX, valueY)
  SendMessageLong PlayerHwnd, WM_LBUTTONDOWN, MK_LBUTTON, MousePosition
  SendMessageLong PlayerHwnd, WM_LBUTTONUP, 0, 0
End Sub

'''Private Function MountDaemonISO(lpFileName As String) As Boolean
'''On Error GoTo Error:
'''   Shell playerSource.DaemonPath & " -mount 0, " & """" & lpFileName & """"
'''   ' Sleep 3000
'''   Exit Function
'''Error:
'''   WriteEvent "MountDaemonISO", Err.Description & " Path = " & playerSource.DaemonPath, Err.Source
'''End Function
'''
'''Private Function UnMountDaemonISO() As Boolean
'''   On Error GoTo Error:
'''   Shell playerSource.DaemonPath & " -unmount 0 "
'''Error:
'''End Function

Private Function WindowProc(ByVal hw As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    Debug.Print "Message: "; hw, uMsg, wParam, lParam
    WindowProc = CallWindowProc(lpPrevWndProc, hw, _
    uMsg, wParam, lParam)
End Function
'''
'''         2 File(s)        249,856 bytes
'''         6 Dir(s)   1,590,607,872 bytes free
'''
'''gram Files\D-Tools>daemon -mount 0 e:\asiakar
'''
'''gram Files\D-Tools>daemon -mount 0,e:\asiakar
'''
'''gram Files \ d - Tools > daemon - unmount
'''
'''gram Files\D-Tools>daemon -unmount 0
Public Function ReadStrProcess(lpProcessID As Long, lpAddress As Long) As String
   Dim sBuffer As String
   Dim lWritten As Long
   Dim hProcess As Long
   
   hProcess = OpenProcess(PROCESS_READ_WRITE_QUERY, False, lpProcessID)
   
   sBuffer = String(48, 0)
   ReadProcessMemory hProcess, ByVal lpAddress, ByVal sBuffer, Len(sBuffer), lWritten
   CloseHandle hProcess
   ReadStrProcess = StrConv(sBuffer, vbFromUnicode)
End Function

Private Function SplitTimeNDuration(ByVal lpWholeString As String, lpSeekTime As String, lpDuration As String) As Boolean
   Dim loc_String As String
   Dim loc_Split() As String
   If Len(lpWholeString) > 7 Then
      loc_String = Mid(lpWholeString, 6)
      loc_Split = Split(loc_String, " / ")
      If UBound(loc_Split) > 0 Then
         lpSeekTime = loc_Split(0)
         lpDuration = loc_Split(1)
         SplitTimeNDuration = True
      End If
   End If
End Function


Function FindTimeValueAddress(lpProcessID As Long, Optional lpMax As Integer = 5) As Long()
On Error GoTo Finished:
   Dim hProcess As Long
   Dim lpMem As Long, Ret As Long, lLenMBI As Long
   Dim lWritten As Long, CalcAddress As Long, lPos As Long
   Dim sBuffer As String
   Dim mbi As MEMORY_BASIC_INFORMATION
   Dim strID As String
   Dim iFound As Integer
   Dim Result() As Long
   Dim si As SYSTEM_INFO
    
   ReDim Result(-1 To -1)
   strID = "Time:00:"
   strID = StrConv(strID, vbUnicode)
   'If LoopingSeekTime Then GoTo Finished
'''   If IsWindowsNT Then StrID = StrConv(StrID, vbUnicode)
   hProcess = OpenProcess(PROCESS_READ_WRITE_QUERY, False, lpProcessID)
   lLenMBI = Len(mbi)
   Call GetSystemInfo(si)
   Debug.Print "Step 1...........   "
   ''Debug.Print "Starting............................."
   lpMem = si.lpMinimumApplicationAddress
'Scan memory
   Debug.Print "Step 2...........   "
    Do While lpMem < si.lpMaximumApplicationAddress
        mbi.RegionSize = 0
        Ret = VirtualQueryEx(hProcess, ByVal lpMem, mbi, lLenMBI)
        If Ret = lLenMBI Then
            If ((mbi.lType = MEM_PRIVATE) And (mbi.State = MEM_COMMIT)) Then ' this block is In use by this process
               If mbi.RegionSize > 0 Then
                  sBuffer = String(mbi.RegionSize, 0)                     'Read region into string
                  ReadProcessMemory hProcess, ByVal mbi.BaseAddress, ByVal sBuffer, mbi.RegionSize, lWritten
                  lPos = 1
                  Do
                     lPos = InStr(lPos, sBuffer, strID, vbTextCompare)
                     If lPos > 0 Then
                        ReDim Preserve Result(-1 To iFound)
                        Result(iFound) = mbi.BaseAddress + lPos - 1
                        'Debug.Print "Address found at " & Hex(Result(iFound)) & "   " & Mid(sBuffer, lPos, 48)
                        iFound = iFound + 1
                        lPos = lPos + Len(strID)
                        If iFound >= lpMax Then Exit Do
                     End If
                  Loop Until lPos <= 0
               End If
            End If
            'Increase base address for next searching cicle. Last address may overhead max Long value (Windows use 2GB memory, which is near max long value), so add Error checking
            On Error GoTo Finished
            lpMem = mbi.BaseAddress + mbi.RegionSize
            On Error GoTo 0
        Else
            Exit Do
        End If
    Loop
    Debug.Print "Step 3...........   "
Finished:
   CloseHandle hProcess
   FindTimeValueAddress = Result
End Function

Private Function FindRegistrationDialogBox() As Long
   FindRegistrationDialogBox = FindWindow("#32770", "CyberLink Registration")
End Function

Private Function SaveOldTimeValue() As Long
   Dim i As Integer
   Dim loc_TimeSeek As String
   Dim loc_Time As String
   Dim loc_TimeTotal As String
   Dim loc_NewTime As Long
   Dim FoundAddress() As Long
   Dim iCount As Integer
   
   
   ReDim Preserve SeekTimes(-1 To UBound(SeekAddress))
   ReDim FoundAddress(-1 To -1)
   
   For i = 0 To UBound(SeekAddress)
      loc_Time = ReadStrProcess(ply_ProcessID, SeekAddress(i))
      SplitTimeNDuration loc_Time, loc_TimeSeek, loc_TimeTotal
      loc_NewTime = Time2Second(loc_TimeSeek)
      If loc_NewTime > SeekTimes(i) Then
         ReDim Preserve FoundAddress(-1 To iCount)
         FoundAddress(iCount) = SeekAddress(i)
         iCount = iCount + 1
         If iCount > 0 Then
            If i = 1 Then SaveOldTimeValue = SeekAddress(i)
         End If
         'Exit For
      End If
      SeekTimes(i) = loc_NewTime
   Next
   
   'If iCount > 0 Then SeekAddress = FoundAddress
End Function

