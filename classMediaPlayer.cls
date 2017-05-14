VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classMediaPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'
Private hMediaClassic As Long
'= = = = = = = = = = = = = = = = = = = = = = ='
'                                             '
'            Working with Media     6.4.9.0   ' Notice will be different in other version
'                                             '
'= = = = = = = = = = = = = = = = = = = = = = ='
Private Const WM_USER = &H400
Private Const TB_ISBUTTONCHECKED = (WM_USER + 10)
Private Const WA_CLOSE = 40001
Private bLoopingStartMedia As Boolean


Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
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
   navigatePrevious = 164
   navigateNext = 165
   SwitchAudioOn = 33103
   SwitchAudioOff = 33102
   VolumeUp = 161
   VolumeDown = 162
   VolumeMute = 163
   ViewMinimal = 308
   ViewCompact = 309
   ViewNormals = 310
   FileGoto = 222
End Enum

''''''''''JumpTo SubMenu       ID    Start From  33400
''''''''''
''''''''''Audio Language SubMenu  ID Start From   33500
''''''''''SubTitle          ID Start From  33600

Private Function menuItemI(subIndex As Integer, Index As Integer) As Long  'Identifier to Play Menu item by index
  menuItemI = GetMenuItemID(hSubMenu(subIndex), Index)
End Function
Private Function getSubSubMenuItemID(submenuIndex As Integer, menuItemIndex As Integer, itemIndex As Integer) As Long
  getSubSubMenuItemID = GetMenuItemID(GetSubMenu(hSubMenu(submenuIndex), menuItemIndex), itemIndex)
End Function
'= = = = = = = = = = = Play Menu = = = = = = = = = = = =
Public Sub Volume(Index As IVolume)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mPlay, 13, CInt(Index)), 0), 0
End Sub
Public Sub SwitchAudio(Index As IKaraoke)
    If Not LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
        Dim a As Long
        InitSubMenu mPlay
        a = GetMenuItemID(GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5), Index)
        SendMessageLong hMedia, WM_COMMAND, MakeLongs(a, 0), 0
    Else
        If Index = 2 Then
            SendMessageLong hMedia, WM_COMMAND, 98336, 0  'Shift A ID 32800 pre audio
            npAudio = 1
        Else
            SendMessageLong hMedia, WM_COMMAND, 98335, 0  'A ID 32799 next audio
            npAudio = 2
        End If
    End If
End Sub
'= = = = = = = = = = = All Menu Command = = = = = = = = = = =
Private Function PostMenuCommand(submenuIndex As Integer, menuItemIndex As Integer) As Long
  PostMenuCommand = PostMessage(hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(submenuIndex), CInt(menuItemIndex)), 0), 0)
End Function

Private Sub MenuCommand(submenuIndex As Integer, menuItemIndex As Integer)
   Call InitSubMenu(CLng(submenuIndex))
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(submenuIndex), CInt(menuItemIndex)), 0), 0
End Sub
Public Function FileMenuCommand(Index As FileSubItemIndex) As Long
  FileMenuCommand = PostMenuCommand(mFile, CInt(Index))
End Function
Public Sub ViewMenuCommand(Index As ViewSubItemIndex)
  MenuCommand mview, CInt(Index)
End Sub
Public Sub PlayMenu(Index As PlayMenuSubItemIndex)
  MenuCommand mPlay, CInt(Index)
End Sub
Public Sub NavigateMenu(Index As NavigateSubItemIndex)
  MenuCommand mNavigate, CInt(Index)
End Sub
''View
Public Sub Zoom(Index As IZoom)

  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mview, ViewZoom, CInt(Index)), 0), 0
End Sub
Public Sub Presets(Index As IPreset)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(Index, 0), 0
End Sub
Public Sub VdeoFrame(Index As IVdeoFram)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mview, ViewVdeoFrame, CInt(Index)), 0), 0
End Sub
Public Sub PanScan(Index As IPanScan)
   SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mview, viewPanScan, CInt(Index)), 0), 0
End Sub
'-------------------------Navigate Menu-------------------------
Private Sub JumpTo(ChapterNumber As Long)
   On Error Resume Next
   Dim arr() As String
   Dim loc_Index As Long
   Dim i As Long
   
   arr = titleAndChapter
   If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "mp4" Then
      'only for mp4
      If ChapterNumber = 1 Then
         SeeksTime 0                      'first chapter
      Else
         For i = 0 To UBound(arr)
            If getNumberFromRight(arr(i)) = ChapterNumber Then
               SendMessageLong hMedia, WM_COMMAND, MakeLongs(33400 + i, 0), 0
               Exit For
            End If
         Next
      End If
      
   Else
      For i = 0 To UBound(arr)
         If InStr(1, arr(i), "Chapter", vbTextCompare) > 0 Then
            loc_Index = i
            Exit For
         End If
      Next
      If loc_Index <> 0 Then
         loc_Index = 33400 + (loc_Index + ChapterNumber - 1)
         
         SendMessageLong hMedia, WM_COMMAND, MakeLongs(loc_Index, 0), 0
         Sleep 500
      End If
   End If
End Sub
Public Sub SelectAudioChannel(channel As Integer)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naAudioLanguage, channel), 0), 0
'  sendInfoControllPlayer GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage), channel)
End Sub
Public Function switchAudioLanguage() As Integer
  On Error Resume Next
  Dim curr As Integer
  
   curr = currentAudioLanindex
   If curr = getNumAudioLanguage - 1 Then
      curr = 0
   ElseIf curr = -1 Then
      Exit Function
   Else
      curr = curr + 1
   End If
   SelectAudioChannel curr
   switchAudioLanguage = curr                 'return the index
  
End Function
'Public Sub subTitle(Index As Integer)
'On Error Resume Next
'  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, Index), 0), 0
'End Sub
Private Sub Class_Initialize()
  'getHWND
End Sub
'-----------------------------------------------------
Public Sub getVDRender(Parenthwnd As Long, left As Single, top As Single, Width As Single, Height As Single)
  Dim pvd As Long
  
  'hMedia = FindWindow("MediaPlayerClassicW", vbNullString) 'media handle
  pvd = getScriptClass(hMedia)
  vdRender = FindWindowEx(pvd, 0, "VideoRenderer", vbNullString)
  
  SetParent vdRender, Parenthwnd
  MoveWindow vdRender, left, top, Width / 15, Height / 15, True
  
End Sub

Private Function GetSubMenuText(hOfMenu As Long, submenuIndex As Integer) As String
  Dim s As String
  Dim i As Integer
   
  s = Space(255)
  GetMenuString hOfMenu, submenuIndex, s, Len(s), MF_BYPOSITION
  i = InStr(s, Chr(0))
  s = left(s, i - 1)
  i = InStr(s, "&")
  If i = 1 Then
    s = right(s, Len(s) - 1)
  End If
  GetSubMenuText = s
End Function

'''''''''''''''''''-------------------------''''''''''''''''
'''''''''''''''''''''''''Seek Bar'''''''''''''''''''''''''
Public Function getScrollStart() As Long
  getScrollStart = GetScrollLens(getScrollMax, getStartTime(getStaticText(&H82)))
End Function
''
Public Function SeeksTime(ByVal Duration As Single) As Boolean
   On Error GoTo ErrorSeek:
   Const Multiply = 3
   Dim nLen As Long
   If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then SendMessageLong FrmMain.hwnd, WM_SETREDRAW, False, 0
   nLen = movieDuration * Multiply + 16               'convert to pixel +16  ,8 each side
   SetWindowWidth hScrollBar, nLen, 20
   'Debug.Print duration * Multiply + RoundTo3(duration)
   ScrollChange Fix(Duration) * Multiply + RoundTo3(Duration)
   'repaint
   SendMessageLong hMedia, WM_TIMER, 2, 0&                           '2 = Timer for change time on status bar
   SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
   SendMessageLong FrmMain.hwnd, &HF, 0, 0
ErrorSeek:
End Function
Public Sub SetWindowWidth(hWindow As Long, lWidth As Long, lHeight As Long)
   SetWindowPos hWindow, 0, 0, 0, lWidth, lHeight, SWP_NOMOVE
End Sub

''
''Public Function Seeks(duration As Long) As Boolean
''   On Error GoTo ErrorSeek:
''   Dim scrollValue As Integer
''   scrollValue = (duration / movieDuration) * getScrollMax
''   ScrollChange scrollValue
''
''   Seeks = True
''   Exit Function
''ErrorSeek:
''End Function
'Public Function SeeksTime(ByVal duration As Long) As Boolean
'   Dim hEdit As Long
'   Dim hButton As Long
'   Dim hDiag As Long
'   Dim i As Long
'   Dim hSys As Long
'   Dim hwndOldFocus As Long
'   Dim hwndOldForeGround As Long
'   Dim hwndOldActive As Long
'   'If duration < movieDuration And GetDurationPlay > 0 Then      'don't seek if duration is <=0
'   If duration < movieDuration Then
'      'open the dialogbox unless it is not opened
'        hSys = FindWindow("Shell_TrayWnd", vbNullString)
'        hDiag = FindWindow("#32770", "Go To...")
'        hwndOldFocus = GetFocus                 'get the last get focus
'        hwndOldForeGround = GetForegroundWindow
'        hwndOldActive = GetActiveWindow
'        If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then SendMessageLong FrmMain.hwnd, WM_SETREDRAW, False, 0
'        If hDiag = 0 Then hDiag = FindWindowEx(hSys, 0, "#32770", "Go To...")
'        If hDiag = 0 Then
'            'PostMessage hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(2), CInt(3)), 0), 0
'            PostMessage hMedia, WM_COMMAND, FileGoto, 0  'Shift A ID 32800 pre audio
'            For i = 0 To 100000
'               If boolExit Then Exit Function
'               If int_track_count <= 0 Then Exit Function
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
'            If boolExit Then Exit Function
'            If int_track_count <= 0 Then Exit Function
'            hButton = FindWindowEx(hDiag, 0, "Button", vbNullString)
'            If hButton <> 0 Then Exit For
'         Next
'        hEdit = FindWindowEx(hDiag, 0, "Edit", vbNullString)
'        'If duration < movieDuration Then
'        SendMessageString hEdit, WM_SETTEXT, 0, Second2Time(duration)
'        'SendMessageString hEdit, WM_SETTEXT, 0, Second2Time(duration)
'        'Sleep 50
'        'SendMessageLong hButton, BM_CLICK, 0, 0
'        PostMessage hButton, BM_CLICK, 0, 0
'        If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then
'            SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
'            SendMessageLong FrmMain.hwnd, &HF, 0, 0
'         End If
'        'Sleep 100
'        SetActiveWindow hwndOldActive
'        SetFocus hwndOldFocus               'set the focus back
'        SetForegroundWindow hwndOldForeGround
'
'   End If
'End Function

Public Sub ScrollChange(Value As Long)
  Dim a As Long
  a = MakeLongs(Value + 8, 5)             '8 pixels from left
  SendMessageLong hScrollBar, WM_LBUTTONDOWN, MK_LBUTTON, a
  SendMessageLong hScrollBar, WM_LBUTTONUP, 0, 0
End Sub

Public Function getTimeValue(scrollMax As Integer, Value As Integer) As Long
  getTimeValue = (movieDuration * Value) / scrollMax
End Function

'''get Media ScrollBar Width
Public Function getScrollMax() As Long
  Dim Slider As Rect
  GetWindowRect hScrollBar, Slider
   If hScrollBar <> 0 Then getScrollMax = Slider.right - Slider.left ' - 16 '16  8 left +  8 right  //seng
End Function
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

Public Property Get ControlHwnd(hwndParent As Long, ClassName As String, ID As Long) As Long
  Dim loc_HwndFound As Long
  loc_HwndFound = FindWindowEx(hwndParent, 0, ClassName, vbNullString)
  While loc_HwndFound <> 0
    If controlID(loc_HwndFound) = ID Then
      ControlHwnd = loc_HwndFound
      Exit Property
    End If
    loc_HwndFound = FindWindowEx(hwndParent, loc_HwndFound, ClassName, vbNullString)
  Wend
End Property

''''Len to Scroll in seconds
Public Function GetScrollLens(scrollMax As Integer, Value As Long) As Long
  On Error Resume Next
  GetScrollLens = (scrollMax * Value) / movieDuration
End Function
''''
Public Property Get GetDialogHwnd(Caption As String) As Long
  Dim loc_HwndFound As Long
  loc_HwndFound = FindWindowEx(0, 0, "#32770", vbNullString)
  While loc_HwndFound <> 0
    If GetHwndCaption(loc_HwndFound) = Caption And GetHwndThreadID(loc_HwndFound) = GetHwndThreadID(hMedia) Then
    
      GetDialogHwnd = loc_HwndFound
      Exit Function
    End If
    loc_HwndFound = FindWindowEx(0, loc_HwndFound, "#32770", vbNullString)
  Wend
End Property
Public Property Get hScrollBar() As Long
   hScrollBar = GetDlgItem(hMedia, &HDA)
End Property

'Private Sub GetScrollHwnd()
'  Dim i As Integer
'  scrollHwnd = FindWindowEx(hMedia, 0, "#32770", vbNullString)
'  While scrollHwnd <> 0
'    ' Debug.Print Hex(scrollHwnd)
'    scrollHwnd = FindWindowEx(hMedia, scrollHwnd, "#32770", vbNullString)
'    If controlID(scrollHwnd) = &HDA Then
'      Exit Sub
'    End If
'  Wend
'End Sub

'''''Get Vdeo Start Time''''
Private Sub getStaticHwnd(ID As Long)
  Dim i As Long
  Dim j As Long
  i = FindWindowEx(hMedia, 0, "#32770", vbNullString)
  staticHwnd = FindWindowEx(i, 0, "Static", vbNullString)
  While staticHwnd <> 0
    staticHwnd = FindWindowEx(i, staticHwnd, "Static", vbNullString)
    If controlID(staticHwnd) = ID Then
      Exit Sub
    End If
  Wend
End Sub

Public Function GetDurationPlay() As Long
   GetDurationPlay = getStartTime(getStaticText(&H82))
End Function

Private Function getStartTime(s As String) As Long
  On Error Resume Next
  Dim sArr() As String
  Dim MovieTime() As String
  Dim startTime() As String
  Dim Lens As Integer
   
  Lens = InStr(s, Chr(0))
  s = left(s, Lens - 1)
  sArr = Split(s, "/")

  '''''''''''Start Time ''''''
  startTime = Split(sArr(0), ":")
  If UBound(startTime) = 1 Then '2 element
     getStartTime = CInt(startTime(0) * 60) + CInt(startTime(1))
     stime = getStartTime
  ElseIf UBound(startTime) = 2 Then '3 elements
     getStartTime = CInt(startTime(0)) * 3600 + CInt(startTime(1)) * 60 + CInt(startTime(2))
     stime = getStartTime
  End If
End Function

'''Get Static Time of Media
Private Function getStaticText(ID As Long) As String
  Dim s As String
  Dim nLen As Long
  Dim hText As Long
  hText = GetDlgItem(GetDlgItem(hMedia, &HD9), ID)
  s = String(255, Chr(0))
  'getStaticHwnd (ID)
  nLen = GetWindowText(hText, s, Len(s))
  'GetDlgItem(GetDlgItem(hMedia, &HD9), &H82)
  getStaticText = left(s, nLen)
End Function
Public Function getScriptClass(hwndParent As Long) As Long
    Const ScriptID = &HE900&
    getScriptClass = GetDlgItem(hwndParent, ScriptID)
  'getScriptClass = FindWindowEx(hwndParent, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
End Function

Public Property Get movieStatus() As StatusEnum
   InitSubMenu mPlay
   If SendMessageLong(hwndToolBar, TB_ISBUTTONCHECKED, ToolPlay, 0) = 1 Then
      movieStatus = Playing
   ElseIf SendMessageLong(hwndToolBar, TB_ISBUTTONCHECKED, ToolPause, 0) = 1 Then
      movieStatus = Pausing
   ElseIf SendMessageLong(hwndToolBar, TB_ISBUTTONCHECKED, ToolStop, 0) = 1 Then
      movieStatus = Stopping
   Else
      Dim stringStatus As String
      stringStatus = getStaticText(&H81)
      Select Case stringStatus
         Case "Failed to render the file", "File not found"
            movieStatus = FileNotFound
         Case Else
            movieStatus = -1
      End Select
   End If

'''   Dim stringStatus As String
'''   stringStatus = getStaticText(&H81)
'''   Select Case stringStatus
'''   Case "Playing"
'''      movieStatus = Playing
'''   Case "Paused"
'''      movieStatus = Pausing
'''   Case "Stopped"
'''      movieStatus = Stopping
'''   Case "Failed to render the file", "File not found"
'''      movieStatus = FileNotFound
'''   Case Else
'''      movieStatus = -1
'''   End Select
End Property

Public Property Get movieDuration() As Long
  Dim MovieTime() As String
  Dim sArr() As String
  Dim s As String
  Dim Lens As Integer

  s = getStaticText(&H82)                       ' GetHwndCaption(GetDlgItem(GetDlgItem(hMedia, &HD9), &H82))
  
  sArr = Split(s, "/")
  If s <> "" Then
      If UBound(sArr) > 0 Then
         MovieTime = Split(sArr(1), ":")
         If UBound(MovieTime) = 1 Then
            movieDuration = MovieTime(0) * 60 + MovieTime(1)
         ElseIf UBound(MovieTime) = 2 Then
            movieDuration = CInt(MovieTime(0)) * 3600 + CInt(MovieTime(1)) * 60 + CInt(MovieTime(2))
         End If
      End If
   End If
End Property


Public Property Get hMedia() As Long
   Dim hReturnMedia As Long
   hReturnMedia = FindWindow("MediaPlayerClassicW", vbNullString) 'media handle
   If hReturnMedia = 0 Then
      hMedia = FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString)
   Else
      If FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString) > 0 Then hMedia = FindWindowEx(FrmMain.Picture1.hwnd, hMediaClassic, "MediaPlayerClassicW", vbNullString): Exit Sub
      SetParent hReturnMedia, FrmMain.Picture1.hwnd 'hwndProgram
      clickStart
      hMedia = hReturnMedia
   End If
End Property

Public Sub TerminateMediaClassic()
   Call TerminateProcessName("mplayerc.exe")        'terminate process with name mplayerc.exe avoiding duplicated instance
End Sub

Public Sub StartMediaClassic(Program As String, Parameter As String)
   Dim hwndProgram As Long
   Dim hProcess As Long
   Dim priorityValue As Long
   Dim hwndDialog As Long
   Dim hwndText As Long
   Dim hwndButton As Long
   Dim i As Long
   Dim hwndForegroundWindow As Long
   
   hwndForegroundWindow = GetForegroundWindow
   If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then SendMessageLong FrmMain.hwnd, WM_SETREDRAW, False, 0
   hwndProgram = FindWindow("Shell_TrayWnd", vbNullString)
   If hMedia = 0 Then
      hProcess = ExecuteFile(Program, "", SW_SHOWNOACTIVATE)
      If hProcess <> 0 Then
         Do
            DoEvents
         Loop Until hMenu <> 0 Or boolExit         'boolExit coz while load MediaPlayer and exit sly
         SetPriority hProcess, StringPriorityMplayer
      End If
      clickStart
      SetParent hMedia, FrmMain.Picture1.hwnd 'hwndProgram
   End If

   If openState Then
      If CMediaPlayer.hMedia <> 0 Then
         If bLoopingStartMedia Then Exit Sub
         bLoopingStartMedia = True
         InitSubMenu mFile
         hwndDialog = GetDialogHwnd("Open")
         If hwndDialog = 0 Then Call CMediaPlayer.FileMenuCommand(FileOpenFile)        ' <> 0 Then
         For i = 0 To 100000
            'DoEvents
            If boolExit Then Exit Sub
            If int_track_count <= 0 Then Exit Sub
            hwndDialog = GetDialogHwnd("Open")
            If hwndDialog <> 0 Then Exit For
         Next
         SetParent hwndDialog, FrmMain.Picture1.hwnd 'hwndProgram
         SetBorderStyle hwndDialog, True
         Sleep 5
         'ShowWindow hwndDialog, False
         For i = 0 To 100000
            DoEvents
            hwndButton = CMediaPlayer.ControlHwnd(hwndDialog, "Button", &H1)
            If hwndButton <> 0 Then Exit For
         Next
         
         hwndText = CMediaPlayer.ControlHwnd(hwndDialog, "ComboBox", &H3FA)
         SendMessage hwndText, WM_SETTEXT, 0&, ByVal Parameter
         SendMessage hwndDialog, WM_COMMAND, &H1, hwndButton
         noSplit 'keep form stay alive
''''''            SendDlgItemMessage hwndDialog, &H3FA, WM_SETTEXT, 0&, ByVal Parameter
''''''            SendDlgItemMessage hwndDialog, &H1, BM_CLICK, 0&, 0&
''''''            SendMessage hwndDialog, WM_COMMAND, &H1, CMediaPlayer.ControlHwnd(hwndDialog, "Button", &H1)
            
         'End If
         'Sleep 1000        'pause 1 second after playing song
         bLoopingStartMedia = False
         'Debug.Print "En loop"
         
      End If
   End If
   SetForegroundWindow hwndForegroundWindow
   startNew = True
   boolTrackIsChanged = True
   
''   SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
''   SendMessageLong FrmMain.hwnd, &HF, 0, 0
'   If hMedia = 0 Then
      If Not (FrmMain.Width >= Screen.Width Or str_swfNames = "Micro") Then
         SendMessageLong FrmMain.hwnd, WM_SETREDRAW, True, 0
         SendMessageLong FrmMain.hwnd, &HF, 0, 0
      End If
 '  End If
 'FrmMain.MediaPlayer.clearFocus
End Sub
Public Property Get GetHwndThreadID(hwnd As Long) As Long
   GetHwndThreadID = GetWindowThreadProcessId(hwnd, 0&)
End Property
Public Property Get hMenu() As Long
  On Error Resume Next
  hMenu = GetMenu(hMedia) 'menu handle
End Property

Public Property Get hSubMenu(ByVal Index As Long) As Long
  hSubMenu = GetSubMenu(hMenu, Index)
End Property

Public Property Get subTitleText() As String() 'return all available subtitle
  On Error Resume Next
  Dim i As Integer
  Dim n As Integer
  Dim subTitleString() As String
  
  ReDim subTitleString(n)
  InitSubMenu mNavigate
  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
  For i = 0 To n - 1
      subTitleString(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage), i)
  Next
  subTitleText = subTitleString
End Property
Public Sub SwitchSubtitle()
   SendMessage hMedia, WM_COMMAND, &H8021, ByVal 0
   'cycle through the Subtitle enable,english,chinse....disable
'Dim currentFileEx As String
'
'   currentFileEx = LCase(fso.GetExtensionName(PlayTrackInfo(int_current_index).TrackPath))
'   If currentFileEx = "ifo" Then
'      Dim n  As Long, i As Long
'      Dim hMenuSubtitle As Long
'      Dim indexToChoose As Long
'      Dim bSeparatorFound As Boolean
'      Dim bMenuCheckedFound As Boolean
'      Dim bEnableCheck As Boolean
'      Dim iStartIndex As Integer
'      Dim iNextIndex As Integer
'      Dim iChooseIndex As Integer
'      Dim sSubTitle As String
'
'      InitSubMenu mNavigate
'
'      n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
'      If n > 0 Then
'         hMenuSubtitle = GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage)
'         iStartIndex = -1
'         iNextIndex = -1
'         bEnableCheck = IsMenuChecked(hMenuSubtitle, 0)
'
'         For i = 0 To n - 1
'            If bSeparatorFound And iStartIndex < 0 Then
'               iStartIndex = i
'            End If
'            If Not bSeparatorFound Then bSeparatorFound = IsMenuSeparator(hMenuSubtitle, i)
'
'            If bMenuCheckedFound And iNextIndex < 0 Then
'               iNextIndex = i
'            End If
'            If Not bMenuCheckedFound And bSeparatorFound Then bMenuCheckedFound = IsMenuChecked(hMenuSubtitle, i)
'         Next
'         If bEnableCheck = False Then
'            iChooseIndex = iStartIndex
'         Else
'            If iNextIndex < 0 Then
'               iChooseIndex = 0
'            Else
'               iChooseIndex = iNextIndex
'            End If
'         End If
'         If iChooseIndex >= 0 Then
'            sSubTitle = GetSubMenuText(hMenuSubtitle, iChooseIndex)
'            SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, iChooseIndex), 0), 0
'            If iChooseIndex = 0 Then sSubTitle = "Subtitle Disabled"
'            sendInfoControllPlayer sSubTitle
'         End If
'         'Debug.Print iStartIndex, iNextIndex, bEnableCheck
'      End If
'   ElseIf currentFileEx = "mp4" Then
'      Dim oldPos As Long
'
'      oldPos = seekTimeValue
'      TurnFFDShowsubTitle = Not TurnFFDShowsubTitle
'      FrmMain.MediaTimer.Enabled = False
'      MenuCommand mPlay, PlayMenuSubItemIndex.PlayMiStop
'      StartMediaClassic "", PlayTrackInfo(int_current_index).TrackPath
'again:
'      For i = 0 To 100000
'        DoEvents
'        If GetDurationPlay > 0 Then Exit For
'      Next
'      SeeksTime oldPos
'      FrmMain.MediaPlayer.ScaleVisualization
'      getVDRender FrmMain.picwmp.hwnd, 0, 0, FrmMain.picwmp.Width, FrmMain.picwmp.Height
'      SetForegroundWindow FrmMain.hwnd
'      FrmMain.MediaTimer.Enabled = True
'   End If
End Sub

Public Sub MediaClassCommand(MenuCommand As ToolBarEnum)
   'Debug.Print "command =", MenuCommand = ToolPlay, "=========="
   Call SendMessageLong(hMedia, WM_COMMAND, MenuCommand, 0)
End Sub

Public Sub InitSubMenu(subIndex As Long)
   'Init display submenu of player     else it will error while using KaraOke
   SendMessageLong hMedia, WM_INITMENUPOPUP, hSubMenu(subIndex), MakeLongs(subIndex, 0)
End Sub

Public Property Let enableSubtitle(enable As Boolean) 'enable or disable subtitle
  On Error Resume Next
 InitSubMenu mNavigate
 If enableSubtitle <> enable Then
    SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, 0), 0), 0
    'subTitleEnabled = enable
 End If
End Property

Public Property Get enableSubtitle() As Boolean
    'enableSubtitle = subTitleEnabled
    Dim handle As Long
    Dim info As MENUITEMINFO
    
    InitSubMenu mNavigate
    
    handle = GetSubMenu(hSubMenu(mNavigate), 5)
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    GetMenuItemInfo handle, 0, True, info
    enableSubtitle = info.fState = 8
End Property

Public Property Get subAudioLanguages() As String() 'return all available audio languages
  On Error Resume Next
  Dim i As Integer
  Dim n As Integer
  Dim subTitleString() As String
  
  ReDim Preserve subTitleString(-1 To n - 1)
  InitSubMenu mNavigate
  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naAudioLanguage))
  For i = 0 To n - 1
      subTitleString(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage), i)
  Next
  subAudioLanguages = subTitleString
End Property

Public Property Get IsInMenuMode() As Boolean
   Dim hwndFirst As Long
   Dim hwndSecond As Long
   Dim hwndReal As Long
   Dim hwndStatus As Long
   hwndFirst = GetDlgItem(hMedia, &HD9)               'first one with ID =&HD9
   hwndSecond = GetNextWindow(hwndFirst, 2)              '2 next window
   hwndReal = GetNextWindow(hwndSecond, 2)               '2 next window the last one
   'if getstatu
   '"Video Title Set Menu" text identify in menu mode
   hwndStatus = FindWindowEx(hwndReal, 0, vbNullString, "Video Title Set Menu")
   IsInMenuMode = hwndStatus <> 0 And movieStatus = Playing
'   If movieStatus = Playing And movieDuration = 0 Then
'      IsInMenuMode = True
'   Else
'      IsInMenuMode = False
'   End If
End Property

Public Property Get isKaraokeable() As Boolean
    On Error Resume Next
    Dim a As Long
    InitSubMenu mPlay
    a = GetMenuItemID(GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5), 3)
    isKaraokeable = (a = 33103) '33103 ID of enabled voice
End Property

Public Property Get titleAndChapter() As String()
  On Error Resume Next
  Dim i As Integer
  Dim n As Integer
  Dim Title() As String
  
  InitSubMenu mNavigate
  
  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naJumpTo))
  If n < 0 Then n = 0      'error if n=-1
  ReDim Title(-1 To n - 1)
  For i = 0 To n - 1
      Title(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naJumpTo), i)
  Next
  titleAndChapter = Title
End Property

Public Property Get hwndToolBar() As Long
   hwndToolBar = FindWindowEx(hMedia, 0, "ToolbarWindow32", vbNullString)
End Property

'terminate process function
Public Property Get isFirstChecked() As Boolean 'check to see if menu 80 is checked
    Dim handle As Long
    Dim info As MENUITEMINFO
    InitSubMenu mPlay
    handle = GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5)
    SendMessageLong hMedia, WM_INITMENUPOPUP, handle, MakeLongs(2, 0)
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    GetMenuItemInfo handle, 2, True, info
    isFirstChecked = info.fState = 8
End Property

Public Sub ResetZoom()
   'MenuCommand
   SendMessageLong hMedia, WM_COMMAND, 152, 0
   SendMessageLong hMedia, WM_COMMAND, 152, 0
   'PanScan moveCenter
'    Dim hwndVideoParent As Long
    
'    hwndVideoParent = getScriptClass(hMedia)
    'Sleep 500
'    PostMessage hwndVideoParent, WM_KEYDOWN, 101, 4980737
'    PostMessage hwndVideoParent, WM_KEYUP, 101, -1068761087
End Sub

'''Public Sub ZoomToLevel(level As Integer)
'''   Dim i As Integer
'''   Dim stepIncrease As Integer
'''   Dim stepcommand As IPanScan
'''
'''   If level < 0 Then
'''      stepIncrease = -1
'''      stepcommand = decreaseSize
'''   Else
'''      stepIncrease = 1
'''      stepcommand = increaseSize
'''   End If
'''
'''
'''
'''   If playMusicWith = Winamp Then
'''      ResetZoom
'''      For i = 1 To level Step stepIncrease
'''         PanScan stepcommand
'''      Next
'''   ElseIf playMusicWith = WindowMedia Then
'''      'resetWMPVdeo                                'it coz scale video switching between fullscreen and mini
'''      scaleWMPVdeo True
'''   ElseIf playMusicWith = nero Then
'''      FrmMain.NSPlayer.zoomVdeo
'''   End If
'''
'''End Sub

Public Property Get getChapterCount() As Long
   Dim i As Long
   Dim loc_ChapterCount As Long
   Dim loc_Extension As String
   If int_track_count > 0 And int_current_index >= 0 Then
      loc_Extension = LCase(fso.GetExtensionName(PlayTrackInfo(int_current_index).TrackPath))
      If loc_Extension = "ifo" Or loc_Extension = "mp4" Then
          Dim arr() As String
          arr = titleAndChapter
          For i = 0 To UBound(arr)
            If InStr(1, arr(i), "Chapter", vbTextCompare) > 0 Then
               loc_ChapterCount = loc_ChapterCount + 1
            End If
          Next
          getChapterCount = loc_ChapterCount
      End If
   End If
End Property
Public Property Get getTitleCount() As Long
   Dim i As Long
   Dim loc_TitleCount As Long
    If int_track_count > 0 And int_current_index >= 0 Then
   If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
       Dim arr() As String
       arr = titleAndChapter
       For i = 0 To UBound(arr)
         If StrComp(left(arr(i), 5), "Title", vbTextCompare) = 0 Then
            loc_TitleCount = loc_TitleCount + 1
         End If
       Next
       getTitleCount = loc_TitleCount
   End If
   End If
End Property


Public Function JumpToTitle(ByVal titleNumber As Long) As Boolean
   On Error Resume Next
   Dim arr() As String
   Dim loc_Index As Long
   Dim i As Long
   If titleNumber > 0 Then
      arr = titleAndChapter
      For i = 0 To UBound(arr)
         If InStr(1, arr(i), "Title", vbTextCompare) = 1 Then     'not found title
            loc_Index = i + 1
            If loc_Index = titleNumber Then
               JumpToTitle = SendMessageLong(hMedia, WM_COMMAND, MakeLongs(33400 + i, 0), 0)
               'JumpToTitle = True
               Exit For
            End If
         Else
            Exit For
         End If
      Next
   End If
   Sleep 500

End Function

Public Sub JumpToChapter(ByVal ChapterNumber As Long, JumpTime As Single)
   Dim availableSecond As Long
   
   If JumpTime = "" Then
      JumpTo ChapterNumber
   Else
      availableSecond = JumpTime
      Me.SeeksTime availableSecond
   End If
   
End Sub

Private Property Get IsMenuChecked(hMenuHandle As Long, Index As Long) As Boolean
    Dim info As MENUITEMINFO
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    If GetMenuItemInfo(hMenuHandle, Index, True, info) <> 0 Then
      IsMenuChecked = (info.fState = 8)
   End If
End Property
Private Property Get IsMenuSeparator(hMenuHandle As Long, Index As Long) As Boolean
   
   Const MIIM_FTYPE = &H100
    Dim info As MENUITEMINFO
    info.cbSize = Len(info)
    info.fMask = MIIM_FTYPE
    If GetMenuItemInfo(hMenuHandle, Index, True, info) <> 0 Then
      IsMenuSeparator = (info.fType = MF_SEPARATOR)
   End If
End Property

Public Property Get IsRootMenuAvailable() As Boolean
    Dim info As MENUITEMINFO
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    InitSubMenu mNavigate
    If GetMenuItemInfo(hSubMenu(mNavigate), 9, True, info) <> 0 Then
      IsRootMenuAvailable = (info.fState = 0)
   End If

End Property

Public Property Get currentChapter() As Integer
   Dim numChapter As Long
   Dim i As Long
   Dim info As MENUITEMINFO
   Dim handle As Long
   Dim loc_ChapterString As String
   Dim loc_Fields() As String
   Dim arr() As String
   Dim loc_PreviousTime As Long
   Dim loc_currentTime As Long
   Dim loc_CurrentPosition As Long
   Dim loc_iResult As Long
   Dim loc_Extension As String
   
   If int_track_count > 0 And int_current_index >= 0 Then
      loc_Extension = LCase(fso.GetExtensionName(PlayTrackInfo(int_current_index).TrackPath))
      If loc_Extension = "ifo" Or loc_Extension = "mp4" Then
         arr = titleAndChapter
         'InitSubMenu   na
         numChapter = getChapterCount
         info.cbSize = Len(info)
         info.fMask = MIIM_STATE
         handle = GetSubMenu(hSubMenu(mNavigate), 2)
         For i = (UBound(arr) - numChapter) + 1 To UBound(arr)
            loc_iResult = 1                     'not found for first chapter
            GetMenuItemInfo handle, i, True, info
            If info.fState = 8 Then
               loc_iResult = getNumberFromRight(arr(i))
               Exit For
            End If
         Next
         
      End If
   End If
    
   currentChapter = loc_iResult
End Property

Public Property Get currentTitle() As Integer
    Dim numTitle As Long
    Dim i As Long
    Dim info As MENUITEMINFO
    Dim handle As Long
    Dim arr() As String
    
    arr = titleAndChapter
    
    numTitle = UBound(arr) - getChapterCount
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    
    InitSubMenu mNavigate
    handle = GetSubMenu(hSubMenu(mNavigate), 2)
    For i = 0 To numTitle - 1
        GetMenuItemInfo handle, i, True, info
        If info.fState = 8 Then currentTitle = i + 1: Exit Sub
    Next
    currentTitle = 0
End Property
Public Property Get openState() As Boolean
   Dim info As MENUITEMINFO
   Dim handle As Long
   InitSubMenu mFile
   info.cbSize = Len(info)
   info.fMask = MIIM_STATE
   
   GetMenuItemInfo hSubMenu(mFile), 0, True, info
   
   openState = IIf((info.fState = 0), True, False)
End Property
Public Property Get getNumAudioLanguage() As Integer
  InitSubMenu mNavigate
  getNumAudioLanguage = GetMenuItemCount(GetSubMenu(hSubMenu(mNavigate), naAudioLanguage))
End Property
Public Property Get currentAudioLanindex() As Integer
    Dim num As Long
    Dim i As Long
    Dim info As MENUITEMINFO
    Dim handle As Long
    
    
    InitSubMenu mNavigate
    
    num = getNumAudioLanguage
    info.cbSize = Len(info)
    info.fMask = MIIM_STATE
    
    handle = GetSubMenu(hSubMenu(mNavigate), naAudioLanguage)
    For i = 0 To num
        GetMenuItemInfo handle, i, True, info
        If info.fState = 8 Then currentAudioLanindex = i: Exit Sub
    Next
    currentAudioLanindex = -1
End Property
Public Sub AudioLanguage(Index As Integer)
 On Error Resume Next
 SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naAudioLanguage, Index), 0), 0
End Sub
Public Property Let MuteMedia(bValue As Boolean)
   '163
   'If bValue = True Then
   If SendMessageLong(hwndToolBar, TB_ISBUTTONCHECKED, VolumeMute, 0) = 1 Then
      'muted
      If bValue = False Then CMediaPlayer.MediaClassCommand VolumeMute
   Else
      'not muted
      If bValue = True Then CMediaPlayer.MediaClassCommand VolumeMute
   End If
End Property

Private Sub clickStart()
  Presets Normals
  If (Not checkStatus(mview, ViewSubItemIndex.ViewStatus)) Then MenuCommand mview, ViewSubItemIndex.ViewStatus
End Sub
Private Function checkStatus(subMenu As MenuIndex, itemIndex As Integer) As Boolean
   Dim info As MENUITEMINFO
   
   info.cbSize = Len(info)
   info.fMask = MIIM_STATE
   
   InitSubMenu subMenu
   
   GetMenuItemInfo hSubMenu(subMenu), itemIndex, True, info
   If info.fState = 8 Then checkStatus = True: Exit Function Else checkStatus = False
End Function
Public Sub noSplit()
   'Sleep 500
   SetParent hMedia, FrmMain.Picture1.hwnd 'reset parent
   SetWindowPos hMedia, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER Or SWP_NOACTIVATE
   SetWindowPos FrmMain.Picture1.hwnd, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE Or SWP_NOACTIVATE
   SetWindowPos FrmMain.hwnd, HWND_TOP, 0, 0, 100, 100, SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE Or SWP_NOACTIVATE
   
End Sub
'====================
'On or Off Subtitle
'===================
Public Sub onOffSubTitle()
'''   Dim hMenuSubtitle As Long
'''   'Dim isOn As Boolean
'''   Dim n  As Integer
'''
'''   InitSubMenu mNavigate
'''   n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
'''   If n > 0 Then
'''      hMenuSubtitle = GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage)
'''   '   isOn = IsMenuChecked(hMenuSubtitle, 0)
'''      SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, 0), 0), 0
'''   End If
   Dim hMenuSubtitle As Long
   'Dim isOn As Boolean
   Dim n  As Integer
   
  '  InitSubMenu mNavigate
 '  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
   'If n > 0 Then
      'hMenuSubtitle = GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage)
   '   isOn = IsMenuChecked(hMenuSubtitle, 0)
      SendMessageLong hMedia, WM_COMMAND, MakeLongs(&H8031, 0), 0
   'End If

End Sub

Private Function getNumberFromRight(arg_String As String) As String
   Dim i As Long
   i = InStrRev(arg_String, " ")
   If i > 0 Then
      getNumberFromRight = val(Mid(arg_String, i + 1))
   End If
End Function


