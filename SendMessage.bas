Attribute VB_Name = "API"
Option Explicit
''
Public Declare Function DragQueryFile Lib "shell32.dll" Alias "DragQueryFileA" (ByVal HDROP As Long, ByVal UINT As Long, ByVal lpStr As String, ByVal ch As Long) As Long
Public Declare Sub DragAcceptFiles Lib "shell32.dll" (ByVal hwnd As Long, ByVal fAccept As Long)
Public Declare Function EnableWindow Lib "user32" (ByVal hwnd As Long, ByVal fEnable As Long) As Long
'====
Public boolTrackIsChanged As Boolean

Public Enum MenuIndex
   mFile = 0
   mview = 1
   mPlay = 2
   mNavigate = 3
   mFavorite = 4
End Enum
Public Enum NavigateSubItemIndex
   naPrevious = 0
   naNext = 1
   naJumpTo = 2
   naAudioLanguage = 4
   naSubTitleLanguage = 5
   naVdeoAngle = 6
   naTitleMenu = 7
   naRootMenu = 9
End Enum

Public Enum FileSubItemIndex
   FileOpenFile = 0
   FileOpenDVD = 1
End Enum
Public Enum ViewSubItemIndex
   ViewCaption = 0
   ViewSeekBar = 1
   ViewControl = 2
   ViewInformation = 3
   ViewStatistic = 4
   ViewStatus = 5
   ViewSubrysync = 6
   ViewPlayList = 7
   ViewCapture = 8
   ViewPresets = 9
   viewPanScan = 15
   ViewFullScreen = 11
   ViewZoom = 12
   ViewVdeoFrame = 14
End Enum
Public Enum IPanScan
    increaseSize = 0
    decreaseSize = 1
    increaseWidth = 2
    decreasewidth = 3
    increaseHeight = 4
    decreaseHeight = 5
    moveRight = 7
    moveLeft = 8
    moveUp = 9
    moveDown = 10
    moveCenter = 11
End Enum
Public Type LongType
   MyLong As Long
End Type

Public Type Inter2Type
   MyInt1 As Integer
   MyInt2 As Integer
End Type

Public Type TBUTTON
    iBitmap As Integer
    idCommand As Integer
    fsState As Byte
    fsStyle As Byte
    dwData As Long
    iString As Long
End Type

Public Type TBUTTONINFO
    cbSize As Long
    dwMask As Long
    idCommand As Long
    iImage As Long
    fsState As Long
    fsStyle As Long
    cx As Long
    lParam As Long
    pszText As Long
    cchText As Long
End Type

Public Type SIZE
   cx As Long
   cy As Long
End Type

Public Type Rect
   left As Long
   top As Long
   right As Long
   bottom As Long
End Type
Public Declare Sub CopyMemoryRT Lib "kernel32" Alias "RtlMoveMemory" (Destination As Rect, ByVal Source As Long, ByVal Length As Long)
Public Declare Sub CopyMemoryRT2Long Lib "kernel32" Alias "RtlMoveMemory" (ByVal Destination As Long, Source As Rect, ByVal Length As Long)

'= = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Public Enum IVdeoFram
   Half = 0
   normal = 1
   DoubleSize = 2
   StretchToWindow = 3
   TouchWindowFromInside = 4
   TouchWindowFromOutside = 5
End Enum
Public Enum PlayMenuSubItemIndex
   'play
   PlayMiPlay = 0
   PlayMiStop = 1
   DecreaseRate = 5
   IncreaseRate = 6
End Enum

Public Enum IVolume
   up = 0
   down = 1
   Mute = 2
End Enum
Public Enum IZoom
   P50 = 0
   P100 = 1
   P200
End Enum
Public Enum IPreset
   Minimal = 308 'ID
   Compact = 309
   Normals = 310
End Enum

Public Enum IKaraoke
   VoiceOff = 2
   VoiceOn = 3
End Enum
Public Type MENUITEMINFO
      cbSize As Long
      fMask As Long
      fType As Long
      fState As Long
      wID As Long
      hSubMenu As Long
      hbmpChecked As Long
      hbmpUnchecked As Long
     dwItemData As Long
     dwTypeData As String
     cch As Long
    hbmpItem As Long
End Type

'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Public Const WM_SETTEXT = &HC

Public Declare Function SendDlgItemMessage Lib "user32" Alias "SendDlgItemMessageA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SetDlgItemText Lib "user32" Alias "SetDlgItemTextA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal lpString As String) As Long
Public Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Long, ByVal wFlag As Long) As Long
Public Declare Function GetFocus Lib "user32" () As Long
Public Declare Function SetFocus Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function SendNotifyMessage Lib "user32" Alias "SendNotifyMessageA" (ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SendMessageString Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Public Declare Function SendMessageTBUTTON Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As TBUTTON) As Long
Public Declare Function GetMenu Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetMenuState Lib "user32" (ByVal hMenu As Long, ByVal wID As Long, ByVal wFlags As Long) As Long
Public Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function GetMenuItemID Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function GetMenuItemCount Lib "user32" (ByVal hMenu As Long) As Long
Public Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Public Declare Function MoveWindow Lib "user32" (ByVal hwnd As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal bRepaint As Long) As Long
Public Declare Function GetMenuString Lib "user32" Alias "GetMenuStringA" (ByVal hMenu As Long, ByVal wIDItem As Long, ByVal lpString As String, ByVal nMaxCount As Long, ByVal wFlag As Long) As Long
Public Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function GetMenuItemInfo Lib "user32" Alias "GetMenuItemInfoA" (ByVal hMenu As Long, ByVal un As Long, ByVal B As Boolean, lpMenuItemInfo As MENUITEMINFO) As Long
Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function ExtCreateRegion Lib "gdi32" (lpXform As Any, ByVal nCount As Long, lpRgnData As Any) As Long
Public Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Public Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Public Declare Function GetDesktopWindow Lib "user32" () As Long
Public Declare Function GetDlgItem Lib "user32" (ByVal hDlg As Long, ByVal nIDDlgItem As Long) As Long
Public Declare Function GetDlgItemText Lib "user32" Alias "GetDlgItemTextA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal lpString As String, ByVal nMaxCount As Long) As Long
Public Declare Function GetNextDlgGroupItem Lib "user32" (ByVal hDlg As Long, ByVal hCtl As Long, ByVal bPrevious As Long) As Long
Public Declare Function AttachThreadInput Lib "user32" (ByVal idAttach As Long, ByVal idAttachTo As Long, ByVal fAttach As Long) As Long
Public Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long


Public Type XFORM
        eM11 As Single
        eM12 As Single
        eM21 As Single
        eM22 As Single
        eDx As Single
        eDy As Single
End Type


'= = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Public Const WM_KEYDOWN = &H100
Public Const WM_KEYUP = &H101
Public Const WM_USER = &H400
Public Const WM_COMMAND = &H111
Public Const WM_INITMENUPOPUP = &H117
Public Const HWND_TOPMOST = -1
Public Const HWND_NOTOPMOST = -2
Public Const SWP_SHOWWINDOW = &H40
Public Const MF_BYPOSITION = &H400&
Public Const MF_SEPARATOR = &H800&
Public Const MF_BYCOMMAND = &H0&
Public Const MK_LBUTTON = &H1
Public Const WM_MOUSEMOVE = &H200
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_LBUTTONUP = &H202
Public Const GWL_ID = (-12)
Public Const GWL_STYLE = (-16)
Public Const WS_DISABLED = &H8000000

Public Const MIIM_ID = &H2
Public Const MIIM_STATE = &H1
Public Const MIIM_SUBMENU = &H4
Public Const MIIM_TYPE = &H10
Public Const MIIM_DATA = &H20
Public Const BM_CLICK = &HF5
Public Const WM_SETREDRAW = &HB
Public Const WM_TIMER = &H113
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Public vdRender As Long                ' Handle of Media ActiveMovie Control
'Public scrollHwnd As Long              'Handle of Media ScrollBar
Public stime As Long                   'Video played duration
'Public subTitleText() As String        'Available SubTitle Text
'Public hMedia As Long                  'Handle of Media Classic
'Public hMenu As Long                   'Handle of MenuBar
'Public hSubMenu() As Long              'Handle of Each Menu
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = =

'Public CMediaPlayer As New classMediaPlayer
Public MousePosition As POINTAPI             'store this to save mouse position
Public Function LoadRegion2Array(filename As String) As Byte()
On Error GoTo Error
   Dim byteRead() As Byte
   Dim loc_hFree As Integer
   Dim nLen As Long
   
   loc_hFree = FreeFile
   Open filename For Binary As loc_hFree
      nLen = LOF(1)
      If nLen > 0 Then
         ReDim byteRead(0 To nLen - 1)
         Get loc_hFree, , byteRead
         LoadRegion2Array = byteRead
      End If
   Close loc_hFree
   Exit Function
Error:
   WriteEvent "LoadRegion2Array", Err.Description, Err.Source
End Function
Public Function ScaleRegion(bRegion() As Byte, Optional scalePercent As Single = 1, Optional flipHeight As Long = -1) As Long
   On Error GoTo ErrorBound
   Dim loc_xform As XFORM
   Dim nLen As Long
   
   nLen = UBound(bRegion) + 1
   With loc_xform
      .eM11 = scalePercent
      .eM22 = scalePercent
      If flipHeight >= 0 Then
         .eM22 = -.eM22
         .eDy = flipHeight
      End If
   End With
   ScaleRegion = ExtCreateRegion(loc_xform, nLen, bRegion(0))
ErrorBound:
End Function
Public Function LoadRegionFromFile(filename As String, Optional scalePercent As Single = 1, Optional flipHeight As Long = -1) As Long
   On Error GoTo Error
   Dim byteRead() As Byte
   Dim loc_xform As XFORM
   Dim loc_hFree As Integer
   Dim nLen As Long
   
   loc_hFree = FreeFile
   Open filename For Binary As loc_hFree
      nLen = LOF(1)
      If nLen > 0 Then
      ReDim byteRead(0 To nLen - 1)
      Get loc_hFree, , byteRead
      End If
   Close loc_hFree
   With loc_xform
      .eM11 = scalePercent
      .eM22 = scalePercent
      If flipHeight >= 0 Then
         .eM22 = -.eM22
         .eDy = flipHeight
      End If
   End With
   If nLen > 0 Then LoadRegionFromFile = ExtCreateRegion(loc_xform, nLen, byteRead(0))
   Exit Function
Error:
   WriteEvent "LoadRegionFromFile", Err.Description, Err.Source
End Function

Public Function MakeLongs(ByVal a As Long, ByVal B As Long) As Long
On Error GoTo Error

  Dim Longs As LongType
  Dim Ints As Inter2Type
   
  Ints.MyInt1 = CInt("&H" & Hex(a))
  Ints.MyInt2 = CInt("&H" & Hex(B))
  LSet Longs = Ints
  MakeLongs = Longs.MyLong
   Exit Function
Error:
   WriteEvent "MakeLongs", Err.Description, Err.Source
End Function
Public Property Get controlID(hwnd As Long) As Long
On Error GoTo Error
   controlID = GetWindowLong(hwnd, GWL_ID)
   Exit Property
Error:
   WriteEvent "controlID", Err.Description, Err.Source
End Property

Public Function getWndClass(hwnd As Long) As String
   Dim s As String
   Dim nLen As Long
   s = String(255, Chr(0))
   nLen = GetClassName(hwnd, s, 255)
   getWndClass = left(s, nLen)
End Function

Public Function getWndText(hText As Long) As String
   Dim s As String
   Dim nLen As Long
   s = String(255, Chr(0))
   nLen = GetWindowText(hText, s, Len(s))
   getWndText = left(s, nLen)
End Function

Public Sub noHideDVDControl()
On Error GoTo Error
   GetCursorPos MousePosition
   run_TimeHidePassed = 0 'caused dvdcontrol not to hide
   Exit Sub
Error:
   WriteEvent "noHideDVDControl", Err.Description, Err.Source
End Sub
Public Function SetForegroundToWindow(hwndActive As Long)
On Error GoTo Error
   Dim hForeground As Long
   hForeground = GetForegroundWindow
   AttachThreadInput GetWindowThreadProcessId(hForeground, 0), GetWindowThreadProcessId(hwndActive, 0), True
   Call SetForegroundWindow(hwndActive)
   AttachThreadInput GetWindowThreadProcessId(hForeground, 0), GetWindowThreadProcessId(hwndActive, 0), False
   Exit Function
Error:
   WriteEvent "SetForegroundToWindow", Err.Description, Err.Source
End Function

Public Property Let TurnFFDEnablesubTitle(varValue As Boolean)
On Error GoTo Error

   SetKeyValue HKEY_CURRENT_USER, "Software\GNU\ffdshow", "subTextpin", Abs(varValue), REG_DWORD
   Exit Property
Error:
   WriteEvent "TurnFFDEnablesubTitle", Err.Description, Err.Source
End Property
Public Function TurnWmpTitleOnOff(boolOn As Boolean) As Boolean
On Error GoTo Error
   SetKeyValue HKEY_CURRENT_USER, "Software\Microsoft\MediaPlayer\Preferences", "ShowCaptions", IIf(boolOn, 1, 0), REG_DWORD
   Exit Function
Error:
   WriteEvent "TurnWmpTitleOnOff", Err.Description, Err.Source
End Function
Public Property Let ChangeHaaliLanguage(varValue As String)
On Error GoTo Error
   SetKeyValue HKEY_CURRENT_USER, "Software\Haali\Matroska Splitter", "subtitle.languages", varValue, REG_SZ
   Exit Property
Error:
   WriteEvent "ChangeHaaliLanguage", Err.Description, Err.Source
End Property
Public Function TurnHaaliOnOff(boolOn As Boolean) As Boolean
On Error GoTo Error
   'Example:
   'if off then subtitle is not showed,on subtitle is showed
   TurnFFDShowsubTitle = boolOn 'turn on subtitle otherwise not play when register vob
   TurnHaaliOnOff = RegisterServer(GetVSFilterPath, boolOn)
   Exit Function
Error:
   WriteEvent "TurnHaaliOnOff", Err.Description, Err.Source
End Function
Public Property Get GetVSFilterPath() As String
   Dim loc_Directory As String
   'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DirectVobSub
   'GetKeyValue
   loc_Directory = fso.GetParentFolderName(Replace(GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DirectVobSub", "UninstallString", REG_SZ), """", ""))
   GetVSFilterPath = fso.BuildPath(loc_Directory, "vsfilter.dll")
End Property

'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DirectVobSub

Public Property Let TurnFFDShowsubTitle(varValue As Boolean)
   SetKeyValue HKEY_CURRENT_USER, "Software\GNU\ffdshow\default", "isSubtitles", Abs(varValue), REG_DWORD
End Property
Public Property Get TurnFFDShowsubTitle() As Boolean
   TurnFFDShowsubTitle = GetKeyValue(HKEY_CURRENT_USER, "Software\GNU\ffdshow\default", "isSubtitles", REG_DWORD)
End Property
'=======================================Volume normalization===================================================2006-10-04 Seng
Public Property Let VolNormalizeTurnOn(varValue As Boolean)
   SetKeyValue HKEY_CURRENT_USER, "Software\GNU\ffdshow_audio\default", "volNormalize", Abs(varValue), REG_DWORD
End Property

Public Property Let VolNormalizeVol(varValue As Integer)
   'Maximum to 2000
   'Sample Volume normalization is Rasmey Hang Meas Vol 15  (Say good bye) 100%
   'Work with ffdshow
   SetKeyValue HKEY_CURRENT_USER, "Software\GNU\ffdshow_audio\default", "volNormalizeMax", varValue, REG_DWORD
End Property

'=======================================End Volume normalization===================================================



