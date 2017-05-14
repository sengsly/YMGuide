Attribute VB_Name = "API_Module"

Option Explicit

Public Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesW" (ByVal lpFileName As Long) As Long
Private Declare Function gethostbyname Lib "WSOCK32.DLL" (ByVal hostname$) As Long
Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Public Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function WNetAddConnection Lib "mpr.dll" Alias "WNetAddConnectionA" (ByVal lpszNetPath As String, ByVal lpszPassword As String, ByVal lpszLocalName As String) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public Declare Function PathIsNetworkPath Lib "shlwapi.dll" Alias "PathIsNetworkPathA" (ByVal pszPath As String) As Long
Public Declare Function CopyFile Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Long) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function ShowCursor Lib "user32" (ByVal bShow As Long) As Long
Public Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long
Private Declare Function ShellExecuteEx Lib "shell32.dll" Alias "ShellExecuteExA" (lpExecInfo As SHELLEXECUTEINFO) As Long
Public Declare Function SetActiveWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SetCursorPos Lib "user32" (ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Long
Public Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Public Declare Function apiSetPriorityClass Lib "kernel32" Alias "SetPriorityClass" (ByVal hProcess As Long, ByVal dwPriorityClass As Long) As Long
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Private Declare Function WNetGetUniversalName Lib "mpr" Alias "WNetGetUniversalNameA" (ByVal lpLocalPath As String, ByVal dwInfoLevel As Long, lpBuffer As UNIVERSAL_NAME_INFO, lpBufferSize As Long) As Long
Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyW" (ByVal lpszDest As String, ByVal lpszSrc As Long) As Long
Private Declare Function lstrlen Lib "kernel32" Alias "lstrlenW" (ByVal lpString As Long) As Long
Private Declare Function NetApiBufferFree Lib "netapi32.dll" (ByVal lpBuffer As Long) As Long
Private Declare Function GetDriveType Lib "kernel32" Alias "GetDriveTypeA" (ByVal nDrive As String) As Long
Private Declare Sub RtlMoveMemory Lib "kernel32" (hpvDest As Any, ByVal hpvSource&, ByVal cbCopy&)
Private Const DRIVE_REMOTE = 4

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, ByVal Source As Long, ByVal Length As Long)
Public Declare Function NetShareEnum Lib "netapi32.dll" (ByVal serverName As String, ByVal level As Long, BufPtr As Long, ByVal prefmaxlen As Long, entriesread As Long, totalentries As Long, resume_handle As Long) As Long
Public Declare Function GetFileSize Lib "kernel32" (ByVal hFile As Long, lpFileSizeHigh As Long) As Long
Public Declare Function GetForegroundWindow Lib "user32" () As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Public Declare Function GetActiveWindow Lib "user32" () As Long
Public Declare Sub ReleaseCapture Lib "user32" ()
Public Declare Function GetCurrentProcess Lib "kernel32" () As Long
Public Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Long) As Boolean
Public Declare Function IsWindowEnabled Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function DragFinish Lib "shell32.dll" (ByVal HDROP As Long) As Long
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Public Declare Function CreateThread Lib "kernel32" (lpThreadAttributes As Any, ByVal dwStackSize As Long, ByVal lpStartAddress As Long, lpParameter As Any, ByVal dwCreationFlags As Long, lpThreadID As Long) As Long
Public Declare Function TerminateThread Lib "kernel32" (ByVal hThread As Long, ByVal dwExitCode As Long) As Long
Public Declare Function SHCreateThread Lib "shlwapi.dll" (ByVal pfnThreadProc As Long, pData As Any, ByVal dwFlags As Long, ByVal pfnCallback As Long) As Long
Public Declare Function GetWindow Lib "User32.dll" (ByVal hwnd As Long, ByVal wCmd As Long) As Long
Public Declare Function SuspendThread Lib "kernel32" (ByVal hThread As Long) As Long
Public Declare Function ResumeThread Lib "kernel32" (ByVal hThread As Long) As Long
Public Declare Function CoInitializeEx Lib "ole32" (ByVal lpvoid As Any, ByVal coInit As Long) As Long  'alway call before using COM object in thread (Use in each thread)
Public Declare Sub CoUninitialize Lib "ole32" () 'clear coInitialize


Private Const INVALID_HANDLE_VALUE = -1
Private Const WM_DISPLAYCHANGE = &H7E           'For refresh the count of monitor extended
Private Const KEYEVENTF_KEYUP = &H2
Private Const VK_LMENU = &HA4
Private Const VK_LCONTROL = &HA2
Private Const VK_SHIFT = &H10
Public Const WM_COPY = &H301
Public Const CTF_COINIT = &H8
Public Const CTF_INSIST = &H1
Public Const CTF_PROCESS_REF = &H4
Public Const CTF_THREAD_REF = &H2


Public hThread As Long
Public threadID As Long
Public lpSeekPosition As Double

Private Const NERR_Success As Long = 0&
Private Type HOSTENT
    hName As Long
    hAliases As Long
    hAddrType As Integer
    hLength As Integer
    hAddrList As Long
End Type
Private Type ACL
        AclRevision As Byte
        Sbz1 As Byte
        AclSize As Integer
        AceCount As Integer
        Sbz2 As Integer
End Type
Private Type SECURITY_DESCRIPTOR
        Revision As Byte
        Sbz1 As Byte
        Control As Long
        Owner As Long
        Group As Long
        Sacl As ACL
        Dacl As ACL
End Type
Private Type SHARE_INFO_502
    shi502_netname As String
    shi502_type As Long
    shi502_remark As String
    shi502_permissions As Long
    shi502_max_uses As Long
    shi502_current_uses As Long
    shi502_path As String
    shi502_passwd As String
    shi502_reserved As Long
    shi502_security_descriptor As SECURITY_DESCRIPTOR
End Type
Private Const STYPE_DISKTREE As Long = 0
Private Const ACCESS_READ As Long = &H1
Private Declare Function NetShareAdd Lib "netapi32.dll" (ByVal serverName As Any, ByVal slevel As Long, buf As SHARE_INFO_502, ByVal cbbuf As Long) As Long
Private Declare Function NetShareDel Lib "netapi32.dll" (ByVal serverName As Any, ByVal netName As String, ByVal reserved As Long) As Long
Private Const ERROR_SUCCESS = &H0


Public Const WM_NCLBUTTONDOWN = &HA1
Public Const HTCAPTION = 2
Const WM_POWERBROADCAST = &H218
Const PBT_APMSUSPEND = &H4



Public Const NORMAL_PRIORITY_CLASS = &H20
Public Const IDLE_PRIORITY_CLASS = &H40                  'low
Public Const HIGH_PRIORITY_CLASS = &H80
Public Const REALTIME_PRIORITY_CLASS = &H100
Public Const BELOW_NORMAL_PRIORITY_CLASS = &H4000
Public Const ABOVE_NORMAL_PRIORITY_CLASS = &H8000


Private Declare Function SHGetSpecialFolderPath Lib "shell32.dll" Alias "SHGetSpecialFolderPathA" (ByVal hwndOwner As Long, ByVal lpszPath As String, ByVal nFolder As Long, ByVal boolCreate As Boolean) As Boolean
Private Const SIZE_SI_2 = 32
Private Const NET_FW_IP_PROTOCOL_UDP = 17
Private Const NET_FW_IP_PROTOCOL_TCP = 6

Private hwndHook As Long
Private Const WH_CBT = 5
Private Const HCBT_SYSCOMMAND = 8
Private Const Monitor_OFF = 2&
Private Const WM_DROPFILES = &H233
Public monitorOff As Boolean

Private Type SHARE_INFO_2
  shi2_netname As Long
  shi2_type As Long
  shi2_remark As Long
  shi2_permissions As Long
  shi2_max_uses As Long
  shi2_current_uses As Long
  shi2_path As Long
  shi2_passwd As Long
End Type
Public Type ShareType
   Name As String
   path As String
End Type
Private Const UNIVERSAL_NAME_INFO_LEVEL = 1
Private Type UNIVERSAL_NAME_INFO
    lpLong As Long
    lpUniversalName As String * 255
End Type


Public oldPos As POINTAPI
Public Type POINTAPI
        X As Long
        Y As Long
End Type

Public cParam As GDIPEncoderParameter
Public cParamList As GDIPEncoderParameterList
Public cCodecList As New GDIPImageEncoderList
Public cCodec As GDIPImageCodec

Public Const MOUSEEVENTF_LEFTDOWN = &H2  '  left button down
Public Const SW_SHOWNOACTIVATE = 4
Public Const SWP_NOACTIVATE = &H10
Public Const SWP_NOZORDER = &H4

Public Const HWND_TOP = 0

Public Const MOUSEEVENTF_LEFTUP = &H4  '  left button up

Public Const HWND_BROADCAST = &HFFFF&

Public Enum enumCopyType
   copyDatabase = 1
   copyXML = 2
   copyNormal = 0
End Enum
Public Enum enumPlayTrack
   playCanPlay = 1
   playCannotPlay = 0
   playRequestingStreamPath = 2
End Enum

Private Type SHELLEXECUTEINFO
        cbSize As Long
        fMask As Long
        hwnd As Long
        lpVerb As String
        lpFile As String
        lpParameters As String
        lpDirectory As String
        nShow As Long
        hInstApp As Long
        '  Optional fields
        lpIDList As Long
        lpClass As String
        hkeyClass As Long
        dwHotKey As Long
        hIcon As Long
        hProcess As Long
End Type
Public bool_microActive As Boolean



Private Const SEE_MASK_NOCLOSEPROCESS = &H40
Private Const GWL_STYLE = (-16)
Private Const WS_CAPTION = &HC00000
Private Const SWP_FRAMECHANGED = &H20
Public Const SWP_NOMOVE = &H2
Public Const SWP_NOSIZE = &H1

Public Const GWL_WNDPROC = (-4)
Public Const GW_HWNDFIRST = 0
Public Const GW_HWNDLAST = 1
Public Const GW_HWNDNEXT = 2
Public Const GW_HWNDPREV = 3
Public Const GW_OWNER = 4
Public Const GW_CHILD = 5
Private Const WM_MOVE = &H3
Private Const WM_MOVING = &H216
Private Const WM_ACTIVATE = &H6
Private Const WM_SYSCOMMAND = &H112
Public Const WM_COPYDATA = &H4A
'Private Const WA_ACTIVE = 1
'Private Const WA_CLICKACTIVE = 2



Private Const SC_MAXIMIZE = &HF030&
Private Const SC_MINIMIZE = &HF020&
Private Const SC_RESTORE = &HF120&

Public Const FileDelimiter = "|"
Private Const WA_CLICKACTIVE = 2
Private Const WA_ACTIVE = 1
Private Const WA_INACTIVE = 0

Private boolRunning As Boolean
'handle of running process
Private hProcess As Long
'handle of call procedure
Public oldAddress As Long
Public oldAddressWindowMedia As Long
Public oldSlideShowFormAddress As Long
Private sharedDrive() As String
Public Function AddShare(pathName As String, ShareName As String) As Boolean
   On Error GoTo Error
   Dim SI502 As SHARE_INFO_502
   Dim nPath As String
   Dim SharePath As String
   Dim ShareRemark As String
   Dim pwd As String
   Dim Ret As Long
   Dim Security As SECURITY_DESCRIPTOR
   
   nPath = StrConv(ShareName, vbUnicode)
   ShareRemark = StrConv("Sly Share", vbUnicode)
   SharePath = StrConv(pathName, vbUnicode)
   pwd = StrConv("", vbUnicode)
    
   With SI502
      .shi502_current_uses = 0
      .shi502_max_uses = 10
      .shi502_netname = nPath
      .shi502_passwd = pwd
      .shi502_path = SharePath
      .shi502_permissions = ACCESS_READ
      .shi502_remark = ShareRemark
      .shi502_reserved = 0
      .shi502_security_descriptor = Security
      .shi502_type = STYPE_DISKTREE
   End With

   AddShare = (NetShareAdd(0&, 2, SI502, Ret) = NERR_Success)
   Exit Function
Error:
   WriteEvent "AddShare", Err.Description, Err.Source
End Function

Public Function GetApplicationProfileString(lpSection As String, lpKeyName As String, lpFileName As String) As String
   On Error GoTo Error
    Dim nLen As Long
    Dim buffer As String * 255
    nLen = GetPrivateProfileString(lpSection, lpKeyName, "", buffer, Len(buffer), lpFileName)
    GetApplicationProfileString = left(buffer, nLen)
   Exit Function
Error:
   WriteEvent "GetApplicationProfileString", Err.Description, Err.Source
End Function

Public Sub PutApplicationProfileString(lpSection As String, lpKeyName As String, lpString As String, lpFileName As String)
   On Error GoTo Error

    Call WritePrivateProfileString(lpSection, lpKeyName, lpString, lpFileName)
   Exit Sub
Error:
   WriteEvent "PutApplicationProfileString", Err.Description, Err.Source
End Sub


Function SlideShowWndProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
 Dim boolSkip As Boolean
'
   Select Case uMsg
      Case WM_ACTIVATE
         If (wParam = WA_INACTIVE) Then
            If Not (LoadSlideshow And LoadBrowseInSlideshow) Then
               LoadSlideshow = False
               frmSlideShow.Timer1.Enabled = True
            End If
         End If
   End Select
   SlideShowWndProc = CallWindowProc(oldSlideShowFormAddress, hwnd, uMsg, wParam, lParam)
   Exit Function
Error:
   WriteEvent "SlideShowWndProc", Err.Description, Err.Source
End Function

Function MyWndWindowMedia(ByVal hwnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
   If uMsg <> &H203 Then                'left mouse double click
      MyWndWindowMedia = CallWindowProc(oldAddressWindowMedia, hwnd, uMsg, wParam, lParam)
   End If
   Exit Function
Error:
   WriteEvent "MyWndWindowMedia", Err.Description, Err.Source
End Function

Function MyWndProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
   Dim rm As RECTM
   Dim rt As Rect
   Dim lWidth As Long, lHeight As Long
   Dim boolSkip As Boolean
   Select Case uMsg
      Case WM_POWERBROADCAST
         If wParam = PBT_APMSUSPEND Then
'''            If playMusicWith = Winamp Then CMediaPlayer.PlayMenu PlayMiStop
         End If
      Case WM_DISPLAYCHANGE                  'Refresh Monitor Count 'EDID:2006-07-31
         RefreshMonitors                     'Refresh Monitor Count 'EDID:2006-08-01
      Case WM_MOVING
         CopyMemoryRT rt, lParam, Len(rt)
         rm = MonitorRECTM(i_SlyMonitor)
         lWidth = rt.right - rt.left
         lHeight = rt.bottom - rt.top
         
         If rt.left < rm.left Then
            rt.left = rm.left     'x
            boolSkip = True
         End If
         If rt.top < rm.top Then
            rt.top = rm.top     'y
            boolSkip = True
         End If
         If rt.right > rm.left + rm.Width Then
            rt.left = rm.left + rm.Width - lWidth
            boolSkip = True
         End If
         If rt.bottom > rm.top + rm.Height Then
            rt.top = rm.top + rm.Height - lHeight
            boolSkip = True
         End If
         
         If boolSkip Then
            rt.right = rt.left + lWidth
            rt.bottom = rt.top + lHeight
            CopyMemoryRT2Long lParam, rt, Len(rt)
            MyWndProc = True
            Exit Function
         End If
                                                                        'Window Width
      Case WM_SYSCOMMAND
         Select Case wParam
             Case SC_MINIMIZE
                  If str_swfNames = "Micro" Then
                     handleMinicommand "Micro2Normal|:|true"
                     boolSkip = True
                  ElseIf str_swfNames = "Fullscreen" Then
                     If b_micro = True Then
                         sendToFlash FrmMain.SWF_FMA(1), "Minimize", "true"
                     Else
                         FrmMain.WindowState = 1
                     End If
                     boolSkip = True
                 Else
                     handleMinicommand "Minimize|:|true"
                     'FrmMain.click_minimize
                     boolSkip = True
                 End If
             Case SC_RESTORE
             
         End Select
     Case WM_ACTIVATE
         If ((wParam = WA_ACTIVE) Or (wParam = WA_CLICKACTIVE)) Then
               
                If (FrmMain.hwnd = hwnd) And frmPopupBrowse.Visible = True Then
                    Call SetWindowPos(frmPopupBrowse.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
                End If
                boolSkip = True
                bool_microActive = True
        ElseIf wParam = WA_INACTIVE Then
'''            If GetParent(GetForegroundWindow) = CMediaPlayer.hMedia And CMediaPlayer.hMedia > 0 Then
'''               SetForegroundWindow hwnd
'''               SetFocus hwnd
'''            End If
'''            bool_microActive = False
            'boolmacr
         End If
   Case WM_COPYDATA
      Debug.Print "WM_COPYDATA"
    Case WM_DROPFILES
      Dim str As String
      Dim i As Integer
      Dim fCount As Integer
      Dim l As Integer
      Dim filelist As String
      
      fCount = DragQueryFile(wParam, &HFFFFFFFF, str, Len(str))  'count file
      If fCount > 0 Then
         For i = 0 To fCount - 1
            str = String(255, Chr(0))
            l = DragQueryFile(wParam, i, str, Len(str))
            str = left(str, l)
           ' If isMedia(str) Then AddMusicToPlayer str
           If isMedia(str) Then
             If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentMode) Then
                AddMusicToPlayer str
             Else
               filelist = filelist & str & Chr(0)
               If i = fCount - 1 Then
                 filelist = left(filelist, Len(filelist) - 1) 'Trim(filelist)
               End If
             End If
           End If
         Next
         If Not CWinsock.LoggedAs(ServerMode) And Not CWinsock.LoggedAs(independentMode) And filelist <> "" Then
            SaveExternalToXML filelist
         End If
         If Not b_play Then miniCommand "Play|:|True"
         DragFinish wParam 'clear memory store file
      End If
End Select
If boolSkip = False Then MyWndProc = CallWindowProc(oldAddress, hwnd, uMsg, wParam, lParam)
   Exit Function
Error:
   WriteEvent "MyWndProc", Err.Description, Err.Source
End Function

Public Sub SetBorderStyle(hwnd As Long, removeTitlebar As Boolean)
   On Error GoTo Error
   Dim oldStyle As Long
   
   'retrieve old state of window style
   oldStyle = GetWindowLong(hwnd, GWL_STYLE)
   If removeTitlebar Then
      'remove title bar of window
      oldStyle = (oldStyle And Not WS_CAPTION)
   Else
      'show the title bar again
      oldStyle = (oldStyle Or WS_CAPTION)
   End If

   SetWindowLong hwnd, GWL_STYLE, oldStyle
   'have to call this procedure with SWP_FRAMECHANGED as parameter
   'to make change windows effect
   SetWindowPos hwnd, 0, 0, 0, 200, 200, SWP_FRAMECHANGED Or SWP_NOMOVE Or SWP_NOSIZE
   Exit Sub
Error:
   WriteEvent "SetBorderStyle", Err.Description, Err.Source
End Sub

Public Sub CopyFolder(Source As String, ByVal Destination As String, copy As enumCopyType, overwriteFolder As Boolean)
   On Error GoTo Error
   Dim folders() As String
   Dim i As Long
   Dim subPath As String
   Dim newDesPath As String
   Dim filename As String
   Dim sourceFolder As String
   Dim DestinationFolder As String
   Dim percent As Integer
   Dim MaxValue As Long
   Dim subFolderName As String
   Dim boolDatabase As Boolean, boolXML As Boolean, boolNoOverwrite As Boolean
   Dim boolFolderJPG As Boolean
   Dim Extension As String
   
   Dim nextPercent As Single
   Dim amplitude As Single
   Dim dirFolder As Folder
   Dim dirFile As file
   Dim j As Long
   
  

   Dim St As String
   Dim sep As String
   Dim des1() As String
   des1 = Split(Destination, "\")
   For i = 0 To UBound(des1) - 1
    St = St + sep + des1(i)
    sep = "\"
   Next
   St = St & "\"
   Destination = St

   folders = FindFolder(Source)
   
   i = InStrRev(Source, "\")
   If i > 0 Then
      subPath = Mid(Source, i + 1)
      If right(Destination, 1) <> "\" Then
         Destination = Destination + "\" + subPath
      Else
         Destination = Destination + subPath
      End If
   End If
   
   
   MaxValue = UBound(folders)
   amplitude = 1 / (MaxValue + 1) * 100
   
   For i = 0 To MaxValue
      sourceFolder = folders(i) '  + "\"
      newDesPath = Mid(sourceFolder, Len(Source) + 1)
      DestinationFolder = Destination + newDesPath
      percent = (i + 1) / (MaxValue + 1) * 100
      'If Not (((copy And copyDatabase) <> copyDatabase) And LCase(Right(sourceFolder, 8)) = "database") Then
      'filename = Dir(sourceFolder + "\*.*", vbReadOnly + vbArchive + vbHidden + vbNormal)
      Set dirFolder = fso.GetFolder(sourceFolder)
      If fso.FolderExists(DestinationFolder) = False Then fso.CreateFolder DestinationFolder
      j = 0
      For Each dirFile In dirFolder.Files
         DoEvents
         j = j + 1
         nextPercent = (j / dirFolder.Files.count) * amplitude
         sendVariable2Flash FrmMain.Swf(IndexSwf), "ProUpdate", percent + nextPercent
         sendVariable2Flash FrmMain.Swf(IndexSwf), "OpenFrame", "true"
         filename = dirFile.Name
         Extension = LCase(fso.GetExtensionName(filename))
         boolXML = Extension = "xml"
         boolFolderJPG = LCase(filename) = "folder.jpg"
         boolDatabase = (Extension = "tbl") Or (Extension = "rel")
         boolNoOverwrite = Not (boolXML Or boolDatabase Or (boolFolderJPG And overwriteFolder))
         'Debug.Print Not ((((copy And copyDatabase) <> copyDatabase) And boolDatabase) Or ((copy And copyXML) <> copyXML) And boolXML)
         'If Not ((copy And copyXML) <> copyXML) And boolXML Then
         If Not ((((copy And copyDatabase) <> copyDatabase) And boolDatabase) Or ((copy And copyXML) <> copyXML) And boolXML) Then
            '
         
            CopyFile fso.BuildPath(sourceFolder, filename), fso.BuildPath(DestinationFolder, filename), boolNoOverwrite
         End If
      Next
      'End If
   Next
   'Pro.Visible = False
   Exit Sub
Error:
   WriteEvent "CopyFolder", Err.Description, Err.Source
End Sub
Public Sub CreateDirectory(Foldername As String)
   On Error GoTo Error
   Dim i As Long
   Dim subDir As String
   
   If right(Foldername, 1) <> "\" Then Foldername = Foldername & "\"
   i = InStr(1, Foldername, "\")
   While i > 0
      subDir = left(Foldername, i)
      If Not fso.FolderExists(subDir) Then
         fso.CreateFolder (subDir)
      End If
      i = InStr(i + 1, Foldername, "\")
   Wend
   On Error GoTo 0
   Exit Sub
Error:
   WriteEvent "CreateDirectory", Err.Description, Err.Source
   Resume Next
End Sub

Public Function Exec(filePath As String) As Boolean
   On Error GoTo Error
   Dim sx As SHELLEXECUTEINFO
   
   With sx
      .lpFile = filePath
      .cbSize = Len(sx)
      .lpVerb = "open"
      .hwnd = 0
      .nShow = 1           'show state
      .fMask = SEE_MASK_NOCLOSEPROCESS
   End With
   ShellExecuteEx sx
   
   If sx.hProcess <> 0 Then
      hProcess = sx.hProcess
      boolRunning = True
      Exec = True
   Else
      hProcess = 0
      boolRunning = False
   End If
   Exit Function
Error:
   WriteEvent "Exec", Err.Description, Err.Source
End Function
Public Property Get GetWinTempPath() As String
   On Error GoTo Error
   Dim inBuffer As String * 255
   Dim nLen As Integer
   nLen = GetTempPath(Len(inBuffer), inBuffer)
   GetWinTempPath = left(inBuffer, nLen)
   Exit Property
Error:
   WriteEvent "Get GetWinTempPath", Err.Description, Err.Source
End Property
Public Property Get GetNetworkPath(ByVal path As String) As String
   On Error GoTo Error
   If PathIsNetworkPath(path) Then
      GetNetworkPath = path
   Else
      Dim returnPath As String
      returnPath = Local2SharedPath(path)
      If returnPath = vbNullString Then
         GetNetworkPath = path
      Else
         GetNetworkPath = "\\" & ComputerIP & "\" & Local2SharedPath(path)
      End If
   End If
   Exit Property
Error:
   WriteEvent "Get GetNetworkPath", Err.Description, Err.Source
End Property
Public Property Get GetLocalToNetwork(remoteIP As String, path As String) As String
   On Error GoTo Error

   If PathIsNetworkPath(path) Or remoteIP = "" Then
      GetLocalToNetwork = path
      
   Else
      GetLocalToNetwork = "\\" & remoteIP & right(path, Len(path) - 2)    'take out drive letter--test
   End If
   Exit Property
Error:
   WriteEvent "Get GetLocalToNetwork", Err.Description, Err.Source
End Property
Public Function GetUniversalName(drivePath As String, varComputerName As String) As String
   On Error GoTo Error
   Dim DriveLetter As String
   Dim noDrivePath As String
   DriveLetter = fso.GetDriveName(drivePath)
   noDrivePath = Mid(drivePath, Len(DriveLetter) + 2)
   If Len(DriveLetter) > 2 Then
      GetUniversalName = drivePath
   Else
      Dim buffer As UNIVERSAL_NAME_INFO
      Dim nLen As Long
      Dim nullLocation As Long
      nLen = WNetGetUniversalName(DriveLetter, UNIVERSAL_NAME_INFO_LEVEL, buffer, Len(buffer))
      If nLen = 0 Then
         nullLocation = InStr(buffer.lpUniversalName, Chr(0))
         DriveLetter = left(buffer.lpUniversalName, nullLocation - 1)
         GetUniversalName = fso.BuildPath(DriveLetter, noDrivePath)
      Else
         GetUniversalName = fso.BuildPath("\\" + varComputerName + "\" + left(DriveLetter, 1), noDrivePath)
      End If
   End If
   Exit Function
Error:
   WriteEvent "GetUniversalName", Err.Description, Err.Source
End Function


Public Function ComputerIP() As String
   On Error GoTo Error
   Dim hostent_addr As Long
   Dim host As HOSTENT
   Dim hostip_addr As Long
   Dim i As Long
   Dim ip_address As String
   Dim temp_ip_address() As Byte
   
   hostent_addr = gethostbyname(ComputerName)
   If hostent_addr <> 0 Then
      RtlMoveMemory host, hostent_addr, LenB(host)
      RtlMoveMemory hostip_addr, host.hAddrList, 4
   
      ReDim temp_ip_address(1 To host.hLength)
      RtlMoveMemory temp_ip_address(1), hostip_addr, host.hLength
      ip_address = ""
      For i = 1 To host.hLength
          If ip_address = "" Then
             ip_address = temp_ip_address(i)
          Else
             ip_address = ip_address & "." & temp_ip_address(i)
          End If
      Next
   End If

   ComputerIP = ip_address
   Exit Function
Error:
   WriteEvent "Get ComputerIP", Err.Description, Err.Source
   
End Function

'''
'''Public Property Get ComputerIP() As String
'''   On Error GoTo Error
'''   ComputerIP = FrmMain.sckServer(0).LocalIP  'FrmMain.sckClient.LocalIP
'''   Exit Property
'''Error:
'''   WriteEvent "Get ComputerIP", Err.Description, Err.Source
'''End Property
Public Function ComputerName() As String
   On Error GoTo Error
  Dim lpBuf As String * 256
  If GetComputerName(lpBuf, Len(lpBuf)) <> 0 Then
      ComputerName = left(lpBuf, InStr(lpBuf, Chr(0)) - 1)
   End If
   Exit Function
Error:
   WriteEvent "Get ComputerName", Err.Description, Err.Source
End Function

'''Public Property Get ComputerName() As String
'''   On Error GoTo Error
'''   ComputerName = FrmMain.sckClient.LocalHostName
'''   Exit Property
'''Error:
'''   WriteEvent "Get ComputerName", Err.Description, Err.Source
'''End Property

Public Function PointerToString(lpszString As Long) As String
   On Error GoTo Error
    Dim lpszStr1 As String, nRes As Long
    Dim nLen As Long
    
    nLen = lstrlen(lpszString) * 2        'Unicode
    lpszStr1 = String(nLen, "*")
    nRes = lstrcpy(lpszStr1, lpszString)
    PointerToString = (StrConv(lpszStr1, vbFromUnicode))
   Exit Function
Error:
   WriteEvent "PointerToString", Err.Description, Err.Source
 End Function

Public Function GetShareList() As ShareType()
   On Error GoTo Error
   Dim nPrefMaxLen As Long, nEntriesRead As Long, nTotalEntries As Long
   Dim nServerType As Long, nResumeHandle As Long, BufPtr  As Long
   Dim newBuffPtr As Long, nRes As Long, i As Long
   Dim tmpReturn() As ShareType
   Dim te As SHARE_INFO_2
   
   nRes = NetShareEnum("", 2, BufPtr, -1, nEntriesRead, nTotalEntries, nResumeHandle)
   ReDim Preserve tmpReturn(-1 To nEntriesRead - 1)
   If nRes = ERROR_SUCCESS And nTotalEntries > 0 Then
      newBuffPtr = BufPtr
      For i = 1 To nEntriesRead
         CopyMemory te, newBuffPtr, SIZE_SI_2
         With tmpReturn(i - 1)
            .Name = PointerToString(te.shi2_netname)
            .path = PointerToString(te.shi2_path)
         End With
         newBuffPtr = newBuffPtr + SIZE_SI_2
      Next
      NetApiBufferFree BufPtr
   End If
   GetShareList = tmpReturn
   Exit Function
Error:
   WriteEvent "GetShareList", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   Local2SharedPath
' Description       :   For using streaming music over network
' Return Values     :   Shared path
' Input Parameter   :   filename
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             03-21-2006           New
'*******************************************************************************

Public Function Local2SharedPath(filename As String) As String
   On Error GoTo Error
   Dim myList() As ShareType
   Dim pathName As String
   Dim i As Long
   
   myList = GetShareList()
   
   If fso.FolderExists(filename) Then
      pathName = filename               'If it is folder then no need to get parent folder
   Else
      pathName = fso.GetParentFolderName(filename)
   End If
   For i = 0 To UBound(myList)
      With myList(i)
         If .path <> vbNullString And right(.Name, 1) <> "$" Then
            If InStr(1, pathName, .path, vbTextCompare) = 1 Then
               Local2SharedPath = fso.BuildPath(.Name, Mid(filename, Len(.path) + 1))
               Exit Function
            End If
         End If
      End With
   Next
   Exit Function
Error:
   WriteEvent "Local2SharedPath", Err.Description, Err.Source
End Function

Public Function create_new_image(sourceImage As String, destinationImage As String, Optional qualityImage As Long = 75)
   On Error GoTo Error
    Dim d_image As New GDIPImage
    Dim plusImageName As String
    
    
    d_image.FromFile sourceImage
    If StrComp(sourceImage, destinationImage, vbTextCompare) = 0 Then
      plusImageName = ".Temp001"
    Else
      plusImageName = ""
    End If
    Set cCodec = cCodecList.EncoderForExtension("JPG")
    Set cParamList = d_image.EncoderParameterList(cCodec.CodecCLSID)
    Set cParam = cParamList.ParameterForGuid(EncoderQuality)
    cParam.ValueCount = 1
    cParam.Value(1) = qualityImage
    d_image.Save destinationImage + plusImageName, cCodec.CodecCLSID
    d_image.Dispose
    If plusImageName <> "" Then
      DeleteFile destinationImage
      Name destinationImage + plusImageName As destinationImage
    End If
   Exit Function
Error:
   'WriteEvent "create_new_image", Err.Description, Err.Source
End Function

Public Sub AddPort(portNumber As Long, portName As String, bolPort As Boolean)
On Error GoTo Desc:
   Dim fwMgr, Profile, Port, de
   Set fwMgr = CreateObject("HNetCfg.FwMgr")
   Set Port = CreateObject("HNetCfg.FWOpenPort")
   
   Set Profile = fwMgr.LocalPolicy.CurrentProfile

   Port.Name = portName
   Port.Protocol = NET_FW_IP_PROTOCOL_TCP
   Port.Port = portNumber
   Port.Enabled = bolPort
   Profile.GloballyOpenPorts.Add Port
   'Profile.GloballyOpenPorts.Delete Port
   Exit Sub
Desc:
   'MsgBox Err.Description
End Sub
Public Property Get GetFileSizes(file As String) As Long
   On Error GoTo ErrorOpen
   GetFileSizes = FileLen(file)
   
ErrorOpen:
End Property


Public Property Get GetMyPictureFolder() As String
   On Error GoTo Error
   Dim hBuffer As String * 255
   Dim hResult As Boolean

   hResult = SHGetSpecialFolderPath(0, hBuffer, 39, False)
   'false indicate do not create folder if doesn't exist
   '39  my picture constant
   If hResult Then
      GetMyPictureFolder = left(hBuffer, InStr(hBuffer, Chr(0)) - 1)
   End If

   Exit Property
Error:
   WriteEvent "Get GetMyPictureFolder", Err.Description, Err.Source
End Property

Public Property Get GetMyMusicFolder() As String
   On Error GoTo Error
   Dim hBuffer As String * 255
   Dim hResult As Boolean

   hResult = SHGetSpecialFolderPath(0, hBuffer, 13, False)
   'false indicate do not create folder if doesn't exist
   '13  my music constant
   If hResult Then
      GetMyMusicFolder = left(hBuffer, InStr(hBuffer, Chr(0)) - 1)
   End If

   Exit Property
Error:
   WriteEvent "Get GetMyMusicFolder", Err.Description, Err.Source
End Property

Public Property Get GetTemporaryInternetFilesFolder() As String
   On Error GoTo Error
   Dim hBuffer As String * 255
   Dim hResult As Boolean

   hResult = SHGetSpecialFolderPath(0, hBuffer, 32, False)
   'false indicate do not create folder if doesn't exist
   '32  get Temporary Internet Files
   If hResult Then
      GetTemporaryInternetFilesFolder = left(hBuffer, InStr(hBuffer, Chr(0)) - 1)
   End If
   Exit Property
Error:
   WriteEvent "Get GetTemporaryInternetFilesFolder", Err.Description, Err.Source
End Property


Public Property Get isFileExist(filePath As String) As Boolean
   On Error GoTo Error
   If left(filePath, 2) = "\\" Then
      Dim lastSlashPosition As Long
      Dim ipHeader() As String
      lastSlashPosition = InStr(3, filePath, "\")
      If lastSlashPosition > 0 Then
         ipHeader = Split(Mid(filePath, 3, lastSlashPosition - 3), ".")
         If ipHeader(0) = "127" Or ipHeader(0) = "192" Or ipHeader(0) = "172" Or (Not IsNumeric(ipHeader(0))) Then
            'isFileExist = fso.FileExists(filePath)
            GoTo TestExists
         End If
      End If
   Else
TestExists:
      'isFileExist = fso.FileExists(filePath)
      isFileExist = APIFileExist(filePath)        'For support unicode
      If isFileExist = False Then         '2007-08-30 Seng
         isFileExist = fso.FolderExists(filePath)
      End If
   End If
   Exit Property
Error:
   'Take out error dialog box
'''   WriteEvent "Get isFileExist", Err.Description, Err.Source
End Property
Public Property Get APIFileExist(lpFileName As String) As Boolean
   Dim lpReturn As Long
   lpReturn = GetFileAttributes(StrPtr(lpFileName))
   APIFileExist = (lpReturn <> INVALID_HANDLE_VALUE)
End Property

Public Property Get isFolderExist(filePath As String) As Boolean
   On Error GoTo Error
   If left(filePath, 2) = "\\" Then
      Dim lastSlashPosition As Long
      Dim ipHeader() As String
      lastSlashPosition = InStr(3, filePath, "\")
      If lastSlashPosition > 0 Then
         ipHeader = Split(Mid(filePath, 3, lastSlashPosition - 3), ".")
         If ipHeader(0) = "127" Or ipHeader(0) = "192" Or ipHeader(0) = "172" Or (Not IsNumeric(ipHeader(0))) Then
            'isFileExist = fso.FileExists(filePath)
            GoTo TestExists
         End If
      End If
   Else
TestExists:
      isFolderExist = fso.FolderExists(filePath)
   End If
   Exit Property
Error:
   'Take out error dialog box
'''   WriteEvent "Get isFileExist", Err.Description, Err.Source
End Property

Public Property Get GetMyDocuments() As String
   On Error GoTo Error
   Dim hBuffer As String * 255
   Dim hResult As Boolean
   
   hResult = SHGetSpecialFolderPath(0, hBuffer, 5, False)
   'false indicate do not create folder if doesn't exist
   '5  my documents
   If hResult Then
      GetMyDocuments = left(hBuffer, InStr(hBuffer, Chr(0)) - 1)
   End If
   Exit Property
Error:
   WriteEvent "Get GetMyDocuments", Err.Description, Err.Source
End Property

'====================Monitor

Function MSGWnd(ByVal ncode As Integer, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
    If ncode = HCBT_SYSCOMMAND Then
       If lParam = Monitor_OFF Then
          monitorOff = True
          FrmMain.tmrSlideShow.Enabled = False
          If LoadSlideshow = True Then frmSlideShow.exit_slideshow "Close"
         
       End If
    End If
    MSGWnd = CallNextHookEx(hwndHook, ncode, wParam, lParam)
   Exit Function
Error:
   WriteEvent "MSGWnd", Err.Description, Err.Source
End Function
Sub setHook()
    hwndHook = SetWindowsHookEx(WH_CBT, AddressOf MSGWnd, 0&, App.threadID)
End Sub
Sub unHook()
    UnhookWindowsHookEx hwndHook
End Sub

Public Function ExecuteFile(filePath As String, Optional Parameter As String, Optional showState As ShowEnum = SW_NORMAL) As Long
   On Error GoTo Error
   Dim hwndProgram As Long
   Dim sx As SHELLEXECUTEINFO
   With sx
      .lpFile = filePath
      .cbSize = Len(sx)
      .lpVerb = "open"
      .hwnd = 0
      .nShow = showState           'show state
      .lpParameters = Parameter
      .fMask = SEE_MASK_NOCLOSEPROCESS
   End With
   hwndProgram = FindWindow("Progman", vbNullString)
   ShellExecuteEx sx
   ExecuteFile = sx.hProcess
   Exit Function
Error:
   WriteEvent "ExecuteFile", Err.Description, Err.Source
End Function

Public Sub ActivateWindowsForeGround(hwndForeground As Long)
   On Error GoTo Error
   ShowWindow hwndForeground, SW_NORMAL
   SetActiveWindow hwndForeground
   SetForegroundWindow hwndForeground
   Exit Sub
Error:
   WriteEvent "ActivateWindowsForeGround", Err.Description, Err.Source
End Sub
Public Function isMedia(path As String) As Boolean
   On Error GoTo Error
   Select Case LCase(fso.GetExtensionName(path))
      Case "mp4", "mp3", "wmv", "dat", "ifo", "vob", "wma", "aac"
         isMedia = True
      Case Else
         isMedia = False
   End Select
   Exit Function
Error:
   WriteEvent "isMedia", Err.Description, Err.Source
End Function
Public Sub ShareAllSharedDrive()
   On Error GoTo Error
   Dim shareResource() As ShareType
   Dim i As Integer
   Dim str As String
   
   shareResource = GetShareList
   If UBound(shareResource) > -1 Then
      ReDim sharedDrive(0)
      For i = 0 To UBound(shareResource)
         str = fso.GetDriveName(shareResource(i).path)
         If str <> "" Then
            If AddShare(str & "\", left(str, 1)) Then
               sharedDrive(UBound(sharedDrive)) = left(str, 1)
               ReDim Preserve sharedDrive(UBound(sharedDrive) + 1)
            End If
            'add back slash to end of string       'take drive name
         End If
      Next
   End If
   Exit Sub
Error:
   WriteEvent "ShareAllSharedDrive", Err.Description, Err.Source
End Sub
Public Function RegisterServer(DllServerPath As String, bRegister As Boolean) As Boolean
    On Error Resume Next
    Dim lb As Long, pa As Long
    lb = LoadLibrary(DllServerPath)

    If bRegister Then
        pa = GetProcAddress(lb, "DllRegisterServer")
    Else
        pa = GetProcAddress(lb, "DllUnregisterServer")
    End If

    If CallWindowProc(pa, 0, ByVal 0&, ByVal 0&, ByVal 0&) = ERROR_SUCCESS Then
        RegisterServer = True
   Else
        RegisterServer = False
    End If
    'unmap the library's address
    FreeLibrary lb
End Function

Public Function SendKeyPress(ByVal vkKey As Byte, ByVal bCtrl As Boolean, ByVal bAlt As Boolean, ByVal bShift As Boolean)

   If bShift Then
      keybd_event vbKeyShift, 0, 0, 0
   End If
   If bAlt Then
      keybd_event VK_LMENU, 0, 0, 0
   End If
   If bCtrl Then
      keybd_event VK_LCONTROL, 0, 0, 0
   End If
   keybd_event vkKey, 0, 0, 0
   
   
   If bShift Then
      keybd_event vbKeyShift, 0, KEYEVENTF_KEYUP, 0
   End If
   If bAlt Then
      keybd_event VK_LMENU, 0, KEYEVENTF_KEYUP, 0
   End If
   If bCtrl Then
      keybd_event VK_LCONTROL, 0, KEYEVENTF_KEYUP, 0
   End If
   
End Function

Public Function IsNetWorkPath(lpPath As String) As Boolean
   Dim loc_RootDrive As String
   loc_RootDrive = left(lpPath, 2)
   If loc_RootDrive = "\\" Then
      IsNetWorkPath = True
   ElseIf GetDriveType(loc_RootDrive) = DRIVE_REMOTE Then
      IsNetWorkPath = True
   End If
End Function
'*******************************************************************************
' Function Name     :   MoveCursorTheSamePos
' Description       :   Make flash available for clicking again
' Return Values     :   none
' Input Parameter   :   none
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-26-2006           New
'*******************************************************************************

Public Sub MoveCursorTheSamePos()
   Dim pos As POINTAPI
   GetCursorPos pos
   SetCursorPos pos.X + 1, pos.Y
   SetCursorPos pos.X, pos.Y
End Sub

