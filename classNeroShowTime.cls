VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classNeroShowTime"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'

Private Const SBM_GETRANGE = &HE3 ' not in win3.1
Private hNerShowTime As Long
'= = = = = = = = = = = = = = = = = = = = = = ='
'                                             '
'            Works with Nero Show Time        '
'                                             '
'= = = = = = = = = = = = = = = = = = = = = = ='
'Private Const WM_USER = &H400
'Private Const TB_ISBUTTONCHECKED = (WM_USER + 10)
'Private Const WA_CLOSE = 40001
Private Const GWL_ID = (-12)
Private bLoopingStartMedia As Boolean
Private Const WM_COMMAND = &H111

Private Const BM_CLICK = &HF5
Private Const SB_HORZ = 0

Private Declare Function GetScrollRange Lib "user32" (ByVal hwnd As Long, ByVal nBar As Long, lpMinPos As Long, lpMaxPos As Long) As Long

Private Declare Function SendDlgItemMessage Lib "user32" Alias "SendDlgItemMessageA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function GetDlgItemText Lib "user32" Alias "GetDlgItemTextA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal lpString As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetDlgItem Lib "user32" (ByVal hDlg As Long, ByVal nIDDlgItem As Long) As Long

Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
Private Declare Function CloseHandle Lib "Kernel32.dll" (ByVal handle As Long) As Long
Private Declare Function OpenProcess Lib "Kernel32.dll" (ByVal dwDesiredAccessas As Long, ByVal bInheritHandle As Long, ByVal dwProcId As Long) As Long
Private Declare Function EnumProcesses Lib "psapi.dll" (ByRef lpidProcess As Long, ByVal cb As Long, ByRef cbNeeded As Long) As Long
Private Declare Function GetModuleFileNameEx Lib "psapi.dll" Alias "GetModuleFileNameExA" (ByVal hProcess As Long, ByVal hModule As Long, ByVal moduleName As String, ByVal nSize As Long) As Long
Private Declare Function EnumProcessModules Lib "psapi.dll" (ByVal hProcess As Long, ByRef lphModule As Long, ByVal cb As Long, ByRef cbNeeded As Long) As Long
Private Const MAX_PATH = 260
Private Const PROCESS_QUERY_INFORMATION = 1024
Private Const PROCESS_VM_READ = 16
Private Const PROCESS_TERMINATE = &H1
Private Const LONG_SIZE = 4
Private Const GWL_EXSTYLE = (-20)
Private Const WS_EX_APPWINDOW = &H40000
Private Const SC_CLOSE = &HF060&
Private Const WM_SYSCOMMAND = &H112
Private Const WM_CLOSE = &H10
Private Const SWP_NOZORDER = &H4

Public npAudio As Integer
'SendMessage hwnd, WM_SYSCOMMAND, SC_CLOSE, 0&


Private staticHwnd As Long 'Handle of Static class (Time)
Public subTitleEnabled As Boolean
'Public  movieDuration As Long 'Movie Duration
Public Enum ToolBarEnum
   ToolPlay = 155
   ToolPause = 156
   ToolStop = 158
End Enum

'PlayMenu ID
Public Enum PlayMode
   PlayPause = 157
   PlayStop = 158
   NavigatePrevious = 164
   NavigateNext = 165
   SwitchAudioOn = 33103
   SwitchAudioOff = 33102
   VolumeUp = 161
   VolumeDown = 162
   VolumeMute = 163
   ViewMinimal = 308
   ViewCompact = 309
   ViewNormals = 310
End Enum

''''''''''JumpTo SubMenu       ID    Start From  33400
''''''''''
''''''''''Audio Language SubMenu  ID Start From   33500
''''''''''SubTitle          ID Start From  33600

'Private Function menuItemI(subIndex As Integer, Index As Integer) As Long  'Identifier to Play Menu item by index
'  menuItemI = GetMenuItemID(hSubMenu(subIndex), Index)
'End Function
'Private Function getSubSubMenuItemID(submenuIndex As Integer, menuItemIndex As Integer, itemIndex As Integer) As Long
'  getSubSubMenuItemID = GetMenuItemID(GetSubMenu(hSubMenu(submenuIndex), menuItemIndex), itemIndex)
'End Function
'''Public Sub SwitchAudio(Index As IKaraoke)
'''    If Not LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''        Dim a As Long
'''        InitSubMenu mPlay
'''        a = GetMenuItemID(GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5), Index)
'''        SendMessageLong hMedia, WM_COMMAND, MakeLongs(a, 0), 0
'''    Else
'''        If Index = 2 Then
'''            SendMessageLong hMedia, WM_COMMAND, 98336, 0  'Shift A ID 32800 pre audio
'''            npAudio = 1
'''        Else
'''            SendMessageLong hMedia, WM_COMMAND, 98335, 0  'A ID 32799 next audio
'''            npAudio = 2
'''        End If
'''    End If
'''End Sub
'= = = = = = = = = = = All Menu Command = = = = = = = = = = =
'Private Function PostMenuCommand(submenuIndex As Integer, menuItemIndex As Integer) As Long
'  PostMenuCommand = PostMessage(hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(submenuIndex), CInt(menuItemIndex)), 0), 0)
'End Function

'Private Sub MenuCommand(submenuIndex As Integer, menuItemIndex As Integer)
'   Call InitSubMenu(CLng(submenuIndex))
'  SendMessageLong hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(submenuIndex), CInt(menuItemIndex)), 0), 0
'End Sub
''Public Function FileMenuCommand(Index As FileSubItemIndex) As Long
''  FileMenuCommand = PostMenuCommand(mFile, CInt(Index))
''End Function
''Public Sub ViewMenuCommand(Index As ViewSubItemIndex)
''  MenuCommand mview, CInt(Index)
''End Sub
''Public Sub PlayMenu(Index As PlayMenuSubItemIndex)
''  MenuCommand mPlay, CInt(Index)
''End Sub
''Public Sub NavigateMenu(Index As NavigateSubItemIndex)
''  MenuCommand mNavigate, CInt(Index)
''End Sub
''View
''Public Sub Zoom(Index As IZoom)
''
''  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mview, ViewZoom, CInt(Index)), 0), 0
''End Sub
''Public Sub Presets(Index As IPreset)
''  SendMessageLong hMedia, WM_COMMAND, MakeLongs(Index, 0), 0
''End Sub
''Public Sub PanScan(Index As IPanScan)
''   SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mview, viewPanScan, CInt(Index)), 0), 0
''End Sub
'-------------------------Navigate Menu-------------------------
'Private Sub JumpTo(ChapterNumber As Long)
'   On Error Resume Next
'   Dim arr() As String
'   Dim loc_Index As Long
'   Dim i As Long
'   arr = titleAndChapter
'   For i = 0 To UBound(arr)
'      If InStr(1, arr(i), "Chapter", vbTextCompare) = 1 Then
'         loc_Index = i
'         Exit For
'      End If
'   Next
'   If loc_Index <> 0 Then
'      loc_Index = 33400 + (loc_Index + ChapterNumber - 1)
'      SendMessageLong hMedia, WM_COMMAND, MakeLongs(loc_Index, 0), 0
'   End If
'End Sub
'Public Sub SelectAudioChannel(channel As Integer)
'  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naAudioLanguage, channel), 0), 0
''  sendInfoControllPlayer GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage), channel)
'End Sub
'Public Function switchAudioLanguage() As Integer
'  On Error Resume Next
'  Dim curr As Integer
'
'   curr = currentAudioLanindex
'   If curr = getNumAudioLanguage - 1 Then
'      curr = 0
'   ElseIf curr = -1 Then
'      Exit Function
'   Else
'      curr = curr + 1
'   End If
'   SelectAudioChannel curr
'   switchAudioLanguage = curr                 'return the index
'
'End Function
'Public Sub subTitle(Index As Integer)
'On Error Resume Next
'  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, Index), 0), 0
'End Sub
Private Sub Class_Initialize()
  'getHWND
End Sub
'-----------------------------------------------------
'Public Sub getVDRender(Parenthwnd As Long, left As Single, top As Single, Width As Single, Height As Single)
'  Dim pvd As Long
'
'  'hMedia = FindWindow("MediaPlayerClassicW", vbNullString) 'media handle
'  pvd = getScriptClass
'  vdRender = FindWindowEx(pvd, 0, "VideoRenderer", vbNullString)
'
'  SetParent vdRender, Parenthwnd
'  MoveWindow vdRender, left, top, Width / 15, Height / 15, True
'
'End Sub

'Private Function GetSubMenuText(hOfMenu As Long, submenuIndex As Integer) As String
'  Dim s As String
'  Dim i As Integer
'
'  s = Space(255)
'  GetMenuString hOfMenu, submenuIndex, s, Len(s), MF_BYPOSITION
'  i = InStr(s, Chr(0))
'  s = left(s, i - 1)
'  i = InStr(s, "&")
'  If i = 1 Then
'    s = Right(s, Len(s) - 1)
'  End If
'  GetSubMenuText = s
'End Function

'''''''''''''''''''-------------------------''''''''''''''''
'''''''''''''''''''''''''Seek Bar'''''''''''''''''''''''''
'Public Function Seeks(duration As Long) As Boolean
'   On Error GoTo ErrorSeek:
'   Dim scrollValue As Integer
'   scrollValue = (duration / movieDuration) * getScrollMax
'   ScrollChange scrollValue
'
'   Seeks = True
'   Exit Function
'ErrorSeek:
'End Function
'Public Function SeeksTime(ByVal duration As Long) As Boolean
'   Dim hEdit As Long
'   Dim hButton As Long
'   Dim hDiag As Long
'   Dim i As Long
'   Dim hSys As Long
'   Dim hwndOldFocus As Long
'   Dim hwndOldForeGround As Long
'   Dim hwndOldActive As Long
'   If duration < movieDuration Then
'      'open the dialogbox unless it is not opened
''        Sleep 50
'        hSys = FindWindow("Shell_TrayWnd", vbNullString)
'        hDiag = FindWindow("#32770", "Go To...")
'        'SendMessage CMediaPlayer.hMedia, &H8, 0&, 0&
'        'Debug.Print GetClass(GetParent(GetFocus))
'        hwndOldFocus = GetFocus                 'get the last get focus
'        hwndOldForeGround = GetForegroundWindow
'        hwndOldActive = GetActiveWindow
'        If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then SendMessageLong FrmMain.hwnd, WM_SETREDRAW, False, 0
'        If hDiag = 0 Then hDiag = FindWindowEx(hSys, 0, "#32770", "Go To...")
'        If hDiag = 0 Then
'            PostMessage hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(2), CInt(3)), 0), 0
'            For i = 0 To 100000
'               ' DoEvents
'               hDiag = FindWindow("#32770", "Go To...")
'               If hDiag <> 0 Then Exit For
'            Next
'        End If
'         SetParent hDiag, FrmMain.Picture1.hwnd 'hwndProgram
'         SetBorderStyle hDiag, True
'
'''        MoveWindow hDiag, Screen.Width, Screen.Height, 100, 10, True
'         SetParent hDiag, FrmMain.Picture1.hwnd  'hSys
'''        SetBorderStyle hDiag, True
'         'Sleep 100
'         For i = 0 To 100000
'            'DoEvents
'            hButton = FindWindowEx(hDiag, 0, "Button", vbNullString)
'            If hButton <> 0 Then Exit For
'         Next
'        hEdit = FindWindowEx(hDiag, 0, "Edit", vbNullString)
'        SendMessageString hEdit, WM_SETTEXT, 0, Second2Time(duration)
'        Sleep 50
'        SendMessageLong hButton, BM_CLICK, 0, 0
'        DoEvents
'        If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then
'            SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
'            SendMessageLong FrmMain.hwnd, &HF, 0, 0
'         End If
'        Sleep 100
'        SetActiveWindow hwndOldActive
'        SetFocus hwndOldFocus               'set the focus back
'        SetForegroundWindow hwndOldForeGround
'
'   End If
'End Function
'
'Public Sub ScrollChange(value As Integer)
'  Dim a As Long
'  a = MakeLongs(value, 5)
'  SendMessageLong scrollHwnd, WM_LBUTTONDOWN, MK_LBUTTON, a
'  SendMessageLong scrollHwnd, WM_LBUTTONUP, 0, 0
'End Sub

Public Function getTimeValue(scrollMax As Integer, value As Integer) As Long
  getTimeValue = (movieDuration * value) / scrollMax
End Function

'''get Media ScrollBar Width
'Public Function getScrollMax() As Long
'  Dim Slider As RECT
'  GetScrollHwnd
'  GetWindowRect scrollHwnd, Slider
'   If scrollHwnd <> 0 Then getScrollMax = Slider.Right - Slider.left ' - 16 '16  8 left +  8 right  //seng
'End Function
'*******************************************************************************
' Function Name     :   ControlHwnd
' Description       :   Get hwnd of the control from it id
' Return Values     :   hwnd of the control
' Input Parameter   :   hwnd parent, and control id
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             09-09-2005           New
'*******************************************************************************

'Public Property Get ControlHwnd(hwndParent As Long, ClassName As String, ID As Long) As Long
'  Dim loc_HwndFound As Long
'  loc_HwndFound = FindWindowEx(hwndParent, 0, ClassName, vbNullString)
'  While loc_HwndFound <> 0
'    If ControlID(loc_HwndFound) = ID Then
'      ControlHwnd = loc_HwndFound
'      Exit Property
'    End If
'    loc_HwndFound = FindWindowEx(hwndParent, loc_HwndFound, ClassName, vbNullString)
'  Wend
'End Property

''''Len to Scroll in seconds
''''
'Public Property Get GetDialogHwnd(Caption As String) As Long
'  Dim loc_HwndFound As Long
'  loc_HwndFound = FindWindowEx(0, 0, "#32770", vbNullString)
'  While loc_HwndFound <> 0
'    If GetHwndCaption(loc_HwndFound) = Caption And GetHwndThreadID(loc_HwndFound) = GetHwndThreadID(hMedia) Then
'
'      GetDialogHwnd = loc_HwndFound
'      Exit Function
'    End If
'    loc_HwndFound = FindWindowEx(0, loc_HwndFound, "#32770", vbNullString)
'  Wend
'End Property

'Private Sub GetScrollHwnd()
'  Dim i As Integer
'  scrollHwnd = FindWindowEx(hMedia, 0, "#32770", vbNullString)
'  While scrollHwnd <> 0
'    ' Debug.Print Hex(scrollHwnd)
'    scrollHwnd = FindWindowEx(hMedia, scrollHwnd, "#32770", vbNullString)
'    If ControlID(scrollHwnd) = &HDA Then
'      Exit Sub
'    End If
'  Wend
'End Sub
Public Property Get GetDlgText(hwndDlg As Long, ID As Long) As String
   Dim lpBuffer As String * 255, nLen As Long
   
   nLen = GetDlgItemText(hwndDlg, ID, lpBuffer, Len(lpBuffer))
   GetDlgText = Left(lpBuffer, nLen)
End Property
'''''Get Vdeo Start Time''''
Private Sub getStaticHwnd(ID As Long)
  Dim i As Long
  Dim j As Long
  i = FindWindowEx(hMedia, 0, "#32770", vbNullString)
  staticHwnd = FindWindowEx(i, 0, "Static", vbNullString)
  While staticHwnd <> 0
    staticHwnd = FindWindowEx(i, staticHwnd, "Static", vbNullString)
    If ControlID(staticHwnd) = ID Then
      Exit Sub
    End If
  Wend
End Sub

Public Function GetDurationPlay() As Long
  Dim MovieTime() As String
  Dim arr_Time() As String
  Dim loc_Time As String

  loc_Time = GetDlgText(hMedia, &H1009)

  arr_Time = Split(loc_Time, ":")
  If loc_Time <> "" Then
      If UBound(arr_Time) > 0 Then
         GetDurationPlay = CInt(arr_Time(0)) * 3600 + CInt(arr_Time(1)) * 60 + CInt(arr_Time(2))
      End If
   End If
End Function

'Private Function getStartTime(s As String) As Long
'  On Error Resume Next
'  Dim sArr() As String
'  Dim MovieTime() As String
'  Dim startTime() As String
'  Dim lens As Integer
'
'  lens = InStr(s, Chr(0))
'  s = left(s, lens - 1)
'  sArr = Split(s, "/")
'
'  '''''''''''Start Time ''''''
'  startTime = Split(sArr(0), ":")
'  If UBound(startTime) = 1 Then '2 element
'     getStartTime = CInt(startTime(0) * 60) + CInt(startTime(1))
'     stime = getStartTime
'  ElseIf UBound(startTime) = 2 Then '3 elements
'     getStartTime = CInt(startTime(0)) * 3600 + CInt(startTime(1)) * 60 + CInt(startTime(2))
'     stime = getStartTime
'  End If
'End Function

'''Get Static Time of Media
'Public Function GetHwndCaption(hwnd As Long) As String
'  Dim s As String
'  Dim nLen As Long
'  s = String(255, Chr(0))
'  'getStaticHwnd (ID)
'  nLen = GetWindowText(hwnd, s, Len(s))
'  GetHwndCaption = left(s, nLen)
'End Function
Private Function getScriptClass() As Long
  getScriptClass = FindWindowEx(hMedia, 0, "DvdControlerDlg", vbNullString)
End Function

'Public Property Get movieStatus() As StatusEnum
'   Dim stringStatus As String
'   stringStatus = getStaticText(&H81)
'   If stringStatus = "Playing" Then
'      movieStatus = Playing
'   ElseIf stringStatus = "Paused" Then
'      movieStatus = Stopping
'   Else
'      movieStatus = -1
'   End If
'End Property

Public Property Get movieDuration() As Long
  Dim MovieTime() As String
  Dim arr_Time() As String
  Dim loc_Time As String

  loc_Time = GetDlgText(hMedia, &H1009)

  arr_Time = Split(loc_Time, ":")
  If loc_Time <> "" Then
      If UBound(arr_Time) > 0 Then
            movieDuration = CInt(arr_Time(0)) * 3600 + CInt(arr_Time(1)) * 60 + CInt(arr_Time(2))
      End If
   End If
End Property
Public Property Get hMedia() As Long
   Dim hReturnMedia As Long
   hReturnMedia = FindWindow("DvdControlerDlg", vbNullString) 'media handle
   If hReturnMedia = 0 Then
      ' hMedia = FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString)
   Else
'''      'If FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString) > 0 Then hMedia = FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString): Exit Sub
'''      'SetParent hReturnMedia, FrmMain.Picture1.hwnd 'hwndProgram
'''      clickStart
      hMedia = hReturnMedia
   End If
End Property

Public Sub TerminateMediaClassic()
   'Call TerminateProcessName("mplayerc.exe")        'terminate process with name mplayerc.exe avoiding duplicated instance
End Sub

'Public Sub StartMediaClassic(Program As String, Parameter As String)
'   Dim hwndProgram As Long
'   Dim hwndForegroundWindow As Long
'   Dim hwndFocusWindow As Long
'   Dim hwndActiveWindow As Long
'   Dim hProcess As Long
'   Dim priorityValue As Long
'   Dim d As Long
'
'   If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then SendMessageLong FrmMain.hwnd, WM_SETREDRAW, False, 0
'   hwndForegroundWindow = GetForegroundWindow
'   hwndFocusWindow = GetFocus
'   hwndActiveWindow = GetActiveWindow
'
'  hwndProgram = FindWindow("Shell_TrayWnd", vbNullString)
' If hMedia = 0 Then
'  ' hwndProgram = FindWindow("Progman", vbNullString)
'  'hwndForegroundWindow = GetForegroundWindow()
'   hProcess = ExecuteFile(Program, "", SW_SHOWNOACTIVATE)
'
'   If hProcess <> 0 Then
'      Do
'         DoEvents
'      Loop Until hMenu <> 0 Or boolExit         'boolExit coz while load MediaPlayer and exit sly
'      SetPriority hProcess, StringPriorityMplayer
''      Select Case StringPriorityMplayer
''         Case "Normal"
''            priorityValue = NORMAL_PRIORITY_CLASS
''         Case "AboveNormal"
''            priorityValue = ABOVE_NORMAL_PRIORITY_CLASS
''         Case "RealTime"
''            priorityValue = REALTIME_PRIORITY_CLASS
''         Case "High"
''            priorityValue = HIGH_PRIORITY_CLASS
''         Case "BelowNormal"
''            priorityValue = BELOW_NORMAL_PRIORITY_CLASS
''         Case "Low"
''            priorityValue = IDLE_PRIORITY_CLASS
''      End Select
''      apiSetPriorityClass hProcess, priorityValue    'set priority to real time
'   End If
'    clickStart
'    SetParent hMedia, FrmMain.Picture1.hwnd 'hwndProgram
' End If
'
'   Dim hwndDialog As Long
'   Dim hwndText As Long
'   Dim hwndButton As Long
'   Dim i As Long
'   ' InitSubMenu
'   'bLoopingStartMedia = Not bLoopingStartMedia
'   'Debug.Print openState
'   If openState Then
'      If CMediaPlayer.hMedia <> 0 Then
'         If bLoopingStartMedia Then Exit Sub
'         bLoopingStartMedia = True
'         InitSubMenu mFile
'         hwndDialog = GetDialogHwnd("Open")
'         If hwndDialog = 0 Then Call CMediaPlayer.FileMenuCommand(FileOpenFile)        ' <> 0 Then
'         For i = 0 To 100000
'            'DoEvents
'            hwndDialog = GetDialogHwnd("Open")
'            If hwndDialog <> 0 Then Exit For
'         Next
'''         ShowWindow hwndDialog, False
'         SetParent hwndDialog, FrmMain.Picture1.hwnd 'hwndProgram
'         SetBorderStyle hwndDialog, True
''''         Do
''''            'DoEvents
''''            hwndDialog = GetDialogHwnd("Open")
''''         Loop Until hwndDialog <> 0
'         noSplit 'keep form stay alive
'         Sleep 5
'         'ShowWindow hwndDialog, False
'         For i = 0 To 100000
'            DoEvents
'            hwndButton = CMediaPlayer.ControlHwnd(hwndDialog, "Button", &H1)
'            If hwndButton <> 0 Then Exit For
'         Next
'
''''         Do
''''            'DoEvents
''''            hwndButton = CMediaPlayer.ControlHwnd(hwndDialog, "Button", &H1)
''''         Loop Until hwndButton <> 0
'
'         hwndText = CMediaPlayer.ControlHwnd(hwndDialog, "ComboBox", &H3FA)
'         SendMessage hwndText, WM_SETTEXT, 0&, ByVal Parameter
'         SendMessage hwndDialog, WM_COMMAND, &H1, hwndButton
'''''''            SendDlgItemMessage hwndDialog, &H3FA, WM_SETTEXT, 0&, ByVal Parameter
'''''''            SendDlgItemMessage hwndDialog, &H1, BM_CLICK, 0&, 0&
'''''''            SendMessage hwndDialog, WM_COMMAND, &H1, CMediaPlayer.ControlHwnd(hwndDialog, "Button", &H1)
'
'         'End If
'         'Sleep 1000        'pause 1 second after playing song
'         bLoopingStartMedia = False
'         'Debug.Print "En loop"
'
'      End If
'   End If
'  Sleep 100
'   SetActiveWindow hwndActiveWindow
'   SetForegroundWindow hwndForegroundWindow
'   SetFocus hwndFocusWindow
'   startNew = True
'   If hMedia = 0 Then
'      If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then
'         SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
'         SendMessageLong FrmMain.hwnd, &HF, 0, 0
'      End If
'   End If
' 'FrmMain.MediaPlayer.clearFocus
'End Sub
''Public Property Get GetHwndThreadID(hwnd As Long) As Long
''   GetHwndThreadID = GetWindowThreadProcessId(hwnd, 0&)
''End Property
'Public Property Get hMenu() As Long
'  On Error Resume Next
'  hMenu = GetMenu(hMedia) 'menu handle
'End Property

'Public Property Get hSubMenu(ByVal Index As Long) As Long
'  hSubMenu = GetSubMenu(hMenu, Index)
'End Property

'Public Property Get subTitleText() As String() 'return all available subtitle
'  On Error Resume Next
'  Dim i As Integer
'  Dim n As Integer
'  Dim subTitleString() As String
'
'  ReDim subTitleString(n)
'  InitSubMenu mNavigate
'  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
'  For i = 0 To n - 1
'      subTitleString(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage), i)
'  Next
'  subTitleText = subTitleString
'End Property
'Public Sub SwitchSubTitle()
'   'cycle through the Subtitle enable,english,chinse....disable
'   Dim n  As Long, i As Long
'   Dim hMenuSubtitle As Long
'   Dim indexToChoose As Long
'   Dim bSeparatorFound As Boolean
'   Dim bMenuCheckedFound As Boolean
'   Dim bEnableCheck As Boolean
'   Dim iStartIndex As Integer
'   Dim iNextIndex As Integer
'   Dim iChooseIndex As Integer
'   Dim sSubTitle As String
'
'   InitSubMenu mNavigate
'
'   n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
'   If n > 0 Then
'      hMenuSubtitle = GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage)
'      iStartIndex = -1
'      iNextIndex = -1
'      bEnableCheck = IsMenuChecked(hMenuSubtitle, 0)
'
'      For i = 0 To n - 1
'         If bSeparatorFound And iStartIndex < 0 Then
'            iStartIndex = i
'         End If
'         If Not bSeparatorFound Then bSeparatorFound = IsMenuSeparator(hMenuSubtitle, i)
'
'         If bMenuCheckedFound And iNextIndex < 0 Then
'            iNextIndex = i
'         End If
'         If Not bMenuCheckedFound And bSeparatorFound Then bMenuCheckedFound = IsMenuChecked(hMenuSubtitle, i)
'      Next
'      If bEnableCheck = False Then
'         iChooseIndex = iStartIndex
'      Else
'         If iNextIndex < 0 Then
'            iChooseIndex = 0
'         Else
'            iChooseIndex = iNextIndex
'         End If
'      End If
'      If iChooseIndex >= 0 Then
'         sSubTitle = GetSubMenuText(hMenuSubtitle, iChooseIndex)
'         SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, iChooseIndex), 0), 0
'         If iChooseIndex = 0 Then sSubTitle = "Subtitle Disabled"
'         sendInfoControllPlayer sSubTitle
'      End If
'      'Debug.Print iStartIndex, iNextIndex, bEnableCheck
'   End If
'
'End Sub
'
'Public Sub MediaClassCommand(MenuCommand As ToolBarEnum)
'   Call SendMessageLong(hMedia, WM_COMMAND, MenuCommand, 0)
'End Sub

'Public Sub InitSubMenu(subIndex As Long)
'   'Init display submenu of player     else it will error while using KaraOke
'   SendMessageLong hMedia, WM_INITMENUPOPUP, hSubMenu(subIndex), MakeLongs(subIndex, 0)
'End Sub

'Public Property Let enableSubtitle(enable As Boolean) 'enable or disable subtitle
'  On Error Resume Next
' InitSubMenu mNavigate
'' If Not subTitleEnabled = enable Then
'    SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, 0), 0), 0
'    subTitleEnabled = Not enable
' 'End If
'End Property

'Public Property Get enableSubtitle() As Boolean
'    enableSubtitle = subTitleEnabled
'End Property

'Public Property Get subAudioLanguages() As String() 'return all available audio languages
'  On Error Resume Next
'  Dim i As Integer
'  Dim n As Integer
'  Dim subTitleString() As String
'
'  ReDim Preserve subTitleString(-1 To n - 1)
'  InitSubMenu mNavigate
'  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naAudioLanguage))
'  For i = 0 To n - 1
'      subTitleString(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage), i)
'  Next
'  subAudioLanguages = subTitleString
'End Property
'
'Public Property Get IsInMenuMode() As Boolean
'   'if getstatu
'   If movieStatus = Playing And movieDuration = 0 Then
'      IsInMenuMode = True
'   Else
'      IsInMenuMode = False
'   End If
'End Property

'Public Property Get isKaraokeable() As Boolean
'    On Error Resume Next
'    Dim a As Long
'    InitSubMenu mPlay
'    a = GetMenuItemID(GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5), 3)
'    isKaraokeable = (a = 33103) '33103 ID of enabled voice
'End Property

'''Public Property Get titleAndChapter() As String()
'''  On Error Resume Next
'''  Dim i As Integer
'''  Dim n As Integer
'''  Dim Title() As String
'''
'''  InitSubMenu mNavigate
'''
'''  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naJumpTo))
'''  If n < 0 Then n = 0      'error if n=-1
'''  ReDim Title(-1 To n - 1)
'''  For i = 0 To n - 1
'''      Title(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naJumpTo), i)
'''  Next
'''  titleAndChapter = Title
'''End Property
'''
'''Public Property Get hwndToolBar() As Long
'''   hwndToolBar = FindWindowEx(hMedia, 0, "ToolbarWindow32", vbNullString)
'''End Property
'''
''''terminate process function
''''===============================================================================================
'''Public Function TerminateProcessName(Name As String) As Boolean
'''   Dim ProcessesID(1 To 200) As Long         '200 element
'''   Dim cbNeed As Long
'''   Dim hResult As Long
'''   Dim processCount As Long
'''   Dim i As Long
'''   Dim moduleName As String
'''
'''   On Error GoTo errorOccur:
'''   hResult = EnumProcesses(ProcessesID(1), LONG_SIZE * UBound(ProcessesID), cbNeed)
'''   If hResult <> 0 Then
'''      processCount = cbNeed / LONG_SIZE
'''      For i = 1 To processCount
'''         moduleName = EnumModule(ProcessesID(i))
'''         If moduleName <> vbNullString Then
'''            If StrComp(fso.GetFileName(moduleName), Name, vbTextCompare) = 0 Then
'''                Terminate ProcessesID(i)
'''                TerminateProcessName = True
'''                'TerminateProcessName=
'''               'if it is mplayerc.exe then terminate it now
'''            End If
'''            'RaiseEvent ProcessFound(moduleName, ProcessesID(i))
'''         End If
'''      Next
'''   End If
'''errorOccur:
'''End Function
'''
''Private Function EnumModule(IDProcess As Long) As String
''   Dim cbNeed As Long
''   Dim hResult As Long
''   Dim ProcessModulesID(1 To 100) As Long
''   Dim hProcess As Long
''   Dim buffName As String
''   Dim nReturnSize As Long
''
''   hProcess = OpenProcess(PROCESS_QUERY_INFORMATION Or PROCESS_VM_READ, 0, IDProcess)
''   If hProcess <> 0 Then
''      hResult = EnumProcessModules(hProcess, ProcessModulesID(1), LONG_SIZE * UBound(ProcessModulesID), cbNeed)
''      If hResult <> 0 Then
''         buffName = String(MAX_PATH, vbNullChar)
''         nReturnSize = GetModuleFileNameEx(hProcess, ProcessModulesID(1), buffName, MAX_PATH)
''         EnumModule = left(buffName, nReturnSize)
''      End If
''   End If
''   CloseHandle hProcess
''End Function
'
'Private Function Terminate(IDProcess As Long) As Boolean
'   Dim hProcess As Long
'   hProcess = OpenProcess(PROCESS_TERMINATE, 0, IDProcess)
'   If hProcess <> 0 Then
'      TerminateProcess hProcess, 0
'      Terminate = True
'   End If
'   CloseHandle hProcess
'End Function

'===============================================================================================
'Public Property Get isFirstChecked() As Boolean 'check to see if menu 80 is checked
'    Dim handle As Long
'    Dim info As MENUITEMINFO
'    InitSubMenu mPlay
'    handle = GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5)
'    SendMessageLong hMedia, WM_INITMENUPOPUP, handle, MakeLongs(2, 0)
'    info.cbSize = Len(info)
'    info.fMask = MIIM_STATE
'    GetMenuItemInfo handle, 2, True, info
'    isFirstChecked = info.fState = 8
'End Property
'
'Public Sub ResetZoom()
'    Dim hwndVideoParent As Long
'
'    hwndVideoParent = getScriptClass
'    Sleep 500
'    PostMessage hwndVideoParent, WM_KEYDOWN, 101, 4980737
'    PostMessage hwndVideoParent, WM_KEYUP, 101, -1068761087
'End Sub
'
'Public Sub ZoomToLevel(level As Integer)
'   Dim i As Integer
'   Dim stepIncrease As Integer
'   Dim stepcommand As IPanScan
'
'   If level < 0 Then
'      stepIncrease = -1
'      stepcommand = decreaseSize
'   Else
'      stepIncrease = 1
'      stepcommand = increaseSize
'   End If
'
'
'
'   If playMusicWith = Winamp Then
'      ResetZoom
'      For i = 1 To level Step stepIncrease
'         PanScan stepcommand
'      Next
'   Else
'      'resetWMPVdeo                                'it coz scale video switching between fullscreen and mini
'      scaleWMPVdeo True
''      If stepcommand = decreaseSize Then
''         FrmMain.wmp.Width = FrmMain.wmp.Width - (50 * Abs(level))
''         FrmMain.wmp.Height = FrmMain.wmp.Height - (50 * Abs(level))
''         FrmMain.wmp.left = FrmMain.wmp.left + (25 * Abs(level))
''         FrmMain.wmp.top = FrmMain.wmp.top + (25 * Abs(level))
''      Else
''         FrmMain.wmp.Width = FrmMain.wmp.Width + (50 * Abs(level))
''         FrmMain.wmp.Height = FrmMain.wmp.Height + (50 * Abs(level))
''         FrmMain.wmp.left = FrmMain.wmp.left - (25 * Abs(level))
''         FrmMain.wmp.top = FrmMain.wmp.top - (25 * Abs(level))
''      End If
'   End If
'
'End Sub
'
'Public Property Get getChapterCount() As Long
'   Dim i As Long
'   Dim loc_ChapterCount As Long
'    If int_track_count > 0 Then
'   If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'       Dim arr() As String
'       arr = titleAndChapter
'       For i = 0 To UBound(arr)
'         If StrComp(left(arr(i), 7), "Chapter", vbTextCompare) = 0 Then
'            loc_ChapterCount = loc_ChapterCount + 1
'         End If
'       Next
'       getChapterCount = loc_ChapterCount
'   End If
'   End If
'End Property
'Public Property Get getTitleCount() As Long
'   Dim i As Long
'   Dim loc_TitleCount As Long
'    If int_track_count > 0 Then
'   If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'       Dim arr() As String
'       arr = titleAndChapter
'       For i = 0 To UBound(arr)
'         If StrComp(left(arr(i), 5), "Title", vbTextCompare) = 0 Then
'            loc_TitleCount = loc_TitleCount + 1
'         End If
'       Next
'       getTitleCount = loc_TitleCount
'   End If
'   End If
'End Property
'
'
'Public Function JumpToTitle(ByVal titleNumber As Long) As Boolean
'   On Error Resume Next
'   Dim arr() As String
'   Dim loc_Index As Long
'   Dim i As Long
'   If titleNumber > 0 Then
'      arr = titleAndChapter
'      For i = 0 To UBound(arr)
'         If InStr(1, arr(i), "Title", vbTextCompare) = 1 Then     'not found title
'            loc_Index = i + 1
'            If loc_Index = titleNumber Then
'               JumpToTitle = SendMessageLong(hMedia, WM_COMMAND, MakeLongs(33400 + i, 0), 0)
'               'JumpToTitle = True
'               Exit For
'            End If
'         Else
'            Exit For
'         End If
'      Next
'   End If
'   Sleep 100
'
'End Function
'
'Public Sub JumpToChapter(ByVal ChapterNumber As Long, JumpTime As String)
'   Dim availableSecond As Long
'
'   If JumpTime = "" Then
'      JumpTo ChapterNumber
'   Else
'      availableSecond = Time2Second(JumpTime)
'      Me.SeeksTime availableSecond
'   End If
'
'End Sub
'
'Private Property Get IsMenuChecked(hMenuHandle As Long, Index As Long) As Boolean
'    Dim info As MENUITEMINFO
'    info.cbSize = Len(info)
'    info.fMask = MIIM_STATE
'    If GetMenuItemInfo(hMenuHandle, Index, True, info) <> 0 Then
'      IsMenuChecked = (info.fState = 8)
'   End If
'End Property
'Private Property Get IsMenuSeparator(hMenuHandle As Long, Index As Long) As Boolean
'
'   Const MIIM_FTYPE = &H100
'    Dim info As MENUITEMINFO
'    info.cbSize = Len(info)
'    info.fMask = MIIM_FTYPE
'    If GetMenuItemInfo(hMenuHandle, Index, True, info) <> 0 Then
'      IsMenuSeparator = (info.fType = MF_SEPARATOR)
'   End If
'End Property
'
'Public Property Get IsRootMenuAvailable() As Boolean
'    Dim info As MENUITEMINFO
'    info.cbSize = Len(info)
'    info.fMask = MIIM_STATE
'    InitSubMenu mNavigate
'    If GetMenuItemInfo(hSubMenu(mNavigate), 9, True, info) <> 0 Then
'      IsRootMenuAvailable = (info.fState = 0)
'   End If
'
'End Property
'
'Public Property Get currentChapter() As Integer
'   Dim numChapter As Long
'   Dim i As Long
'   Dim info As MENUITEMINFO
'   Dim handle As Long
'   Dim loc_ChapterString As String
'   Dim loc_Fields() As String
'   Dim arr() As String
'   Dim loc_PreviousTime As Long
'   Dim loc_currentTime As Long
'   Dim loc_CurrentPosition As Long
'   Dim loc_iResult As Long
'
'   If int_track_count > 0 And int_current_index >= 0 Then
'      If StrComp(fso.GetExtensionName(Infos(int_current_index).TrackPath), "ifo", vbTextCompare) = 0 Then
'         arr = titleAndChapter
'
'         numChapter = getChapterCount
'         info.cbSize = Len(info)
'         info.fMask = MIIM_STATE
'         For i = (UBound(arr) - numChapter) + 1 To UBound(arr)
'             handle = GetSubMenu(hSubMenu(mNavigate), 2)
'             GetMenuItemInfo handle, i, True, info
'             If info.fState = 8 Then loc_iResult = i - (UBound(arr) - numChapter): Exit For
'
'         Next
'      Else
'         If Not Infos(int_current_index).trackExternal Then             'Track internal
'            loc_CurrentPosition = GetDurationPlay
'            loc_ChapterString = GetChapterFromMovie(Infos(int_current_index).trackAlbumID, PlayTrackInfo(int_current_index).language, getChapterCount)
'            arr = Split(loc_ChapterString, de_Record)
'            For i = 0 To UBound(arr)
'               loc_Fields = Split(arr(i), de_Field)
'               loc_currentTime = Time2Second(loc_Fields(2))          'convert from specific format("00:00:00") to seconds
'               If loc_currentTime <= loc_CurrentPosition Then
'                  loc_iResult = loc_Fields(0)               'Current chapter
'               Else
'                  Exit For
'               End If
'            Next
'
'         End If
'      End If
'   End If
'
'   currentChapter = loc_iResult
'End Property
'
'Public Property Get currentTitle() As Integer
'    Dim numTitle As Long
'    Dim i As Long
'    Dim info As MENUITEMINFO
'    Dim handle As Long
'    Dim arr() As String
'
'    arr = titleAndChapter
'
'    numTitle = UBound(arr) - getChapterCount
'    info.cbSize = Len(info)
'    info.fMask = MIIM_STATE
'
'    InitSubMenu mNavigate
'    For i = 0 To numTitle - 1
'        handle = GetSubMenu(hSubMenu(mNavigate), 2)
'        GetMenuItemInfo handle, i, True, info
'        If info.fState = 8 Then currentTitle = i + 1: Exit Sub
'    Next
'    currentTitle = 0
'End Property
'Public Property Get openState() As Boolean
'   Dim info As MENUITEMINFO
'   Dim handle As Long
'   InitSubMenu mFile
'   info.cbSize = Len(info)
'   info.fMask = MIIM_STATE
'
'   GetMenuItemInfo hSubMenu(mFile), 0, True, info
'
'   openState = IIf((info.fState = 0), True, False)
'End Property
'Public Property Get getNumAudioLanguage() As Integer
'  InitSubMenu mNavigate
'  getNumAudioLanguage = GetMenuItemCount(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage))
'End Property
'Public Property Get currentAudioLanindex() As Integer
'    Dim num As Long
'    Dim i As Long
'    Dim info As MENUITEMINFO
'    Dim handle As Long
'
'
'    InitSubMenu mNavigate
'
'    num = getNumAudioLanguage
'    info.cbSize = Len(info)
'    info.fMask = MIIM_STATE
'
'    handle = GetSubMenu(hSubMenu(mNavigate), naAudioLanguage)
'    For i = 0 To num
'        GetMenuItemInfo handle, i, True, info
'        If info.fState = 8 Then currentAudioLanindex = i: Exit Sub
'    Next
'    currentAudioLanindex = -1
'End Property
'Public Sub AudioLanguage(Index As Integer)
' On Error Resume Next
' SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naAudioLanguage, Index), 0), 0
'End Sub
'Public Property Let MuteMedia(bValue As Boolean)
'   '163
'   'If bValue = True Then
'   If SendMessageLong(hwndToolBar, TB_ISBUTTONCHECKED, VolumeMute, 0) = 1 Then
'      'muted
'      If bValue = False Then CMediaPlayer.MediaClassCommand VolumeMute
'   Else
'      'not muted
'      If bValue = True Then CMediaPlayer.MediaClassCommand VolumeMute
'   End If
'End Property
'
'Private Sub clickStart()
'  Presets Normals
'  If (Not checkStatus(mview, ViewSubItemIndex.ViewStatus)) Then MenuCommand mview, ViewSubItemIndex.ViewStatus
'End Sub
'''Private Function checkStatus(subMenu As MenuIndex, itemIndex As Integer) As Boolean
'''   Dim info As MENUITEMINFO
'''
'''   info.cbSize = Len(info)
'''   info.fMask = MIIM_STATE
'''
'''   InitSubMenu subMenu
'''
'''   GetMenuItemInfo hSubMenu(subMenu), itemIndex, True, info
'''   If info.fState = 8 Then checkStatus = True: Exit Function Else checkStatus = False
'''End Function
'Public Sub noSplit()
'   'Sleep 500
'   SetParent hMedia, FrmMain.Picture1.hwnd 'reset parent
'   SetWindowPos hMedia, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER
'   SetWindowPos FrmMain.Picture1.hwnd, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE
'   SetWindowPos FrmMain.hwnd, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE
'End Sub
''====================
''On or Off Subtitle
''===================
'Public Sub onOffSubTitle()
'   Dim hMenuSubtitle As Long
'   'Dim isOn As Boolean
'   Dim n  As Integer
'
'   InitSubMenu mNavigate
'   n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
'   If n > 0 Then
'      hMenuSubtitle = GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage)
'   '   isOn = IsMenuChecked(hMenuSubtitle, 0)
'      SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, 0), 0), 0
'   End If
'End Sub
'
Public Property Get ControlID(hwnd As Long) As Long
   ControlID = GetWindowLong(hwnd, GWL_ID)
End Property
Public Sub Pause()
   Dim pauseHwnd As Long
   pauseHwnd = GetDlgItem(hMedia, &HFA5)
   SendMessageLong hMedia, WM_COMMAND, &HFA5, pauseHwnd
End Sub
Public Sub Play()
   Dim pauseHwnd As Long
   pauseHwnd = GetDlgItem(hMedia, &HFA5)
   SendMessageLong hMedia, WM_COMMAND, &HFA5, pauseHwnd
End Sub
Public Function GetDurations()
'DvdControlerDlg
   Dim loc_iMin As Long, loc_iMax As Long
   GetScrollRange &HA0438, 1, loc_iMin, loc_iMax
   Debug.Print loc_iMax
End Function
