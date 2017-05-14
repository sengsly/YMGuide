VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classNero"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Implements IPlayer

Private Type Rect
   left As Long
   top As Long
   right As Long
   bottom As Long
End Type
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long

Private Type MENUITEMINFO
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

Private playerObject As Object
Private playerSource As Player
Private WithEvents playerTimer As Timer
Attribute playerTimer.VB_VarHelpID = -1
Private PlayerTask As EnumTimerTask
Private ply_hParent As Long
Private ply_iVolume As Single
Private ply_bMute  As Boolean
Private ply_bSubtitle  As Boolean
Private ply_hNewParent As Long
Private ply_iAudioIndex As Integer
Private Const SW_SHOWNOACTIVATE = 4
Private Const GWL_STYLE = (-16)
Private Const WS_DISABLED = &H8000000

Private Const MIIM_STATE = &H1
Private Const BM_CLICK = &HF5
Private Const WM_SETREDRAW = &HB
Private Const WM_TIMER = &H113
Private Const SWP_NOZORDER = &H4
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202
Private Const MK_LBUTTON = &H1
Private Const GW_HWNDNEXT = 2

Private Declare Function IsWindowEnabled Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Private Declare Function GetMenu Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Long, ByVal wFlag As Long) As Long
Private Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function EnableWindow Lib "user32" (ByVal hwnd As Long, ByVal fEnable As Long) As Long
Private Declare Function AttachThreadInput Lib "user32" (ByVal idAttach As Long, ByVal idAttachTo As Long, ByVal fAttach As Long) As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function MoveWindow Lib "user32" (ByVal hwnd As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal bRepaint As Long) As Long
Private Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SendDlgItemMessage Lib "user32" Alias "SendDlgItemMessageA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function GetDlgItem Lib "user32" (ByVal hDlg As Long, ByVal nIDDlgItem As Long) As Long
Private Declare Function GetDlgItemText Lib "user32" Alias "GetDlgItemTextA" (ByVal hDlg As Long, ByVal nIDDlgItem As Long, ByVal lpString As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetForegroundWindow Lib "user32" () As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SendMessageString Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long

Private hPlayerVideo_Temp As Long

'============================Function============================================
Private WithEvents PlayerThread As Timer
Attribute PlayerThread.VB_VarHelpID = -1
Public Event SeekChange(ByVal seekTime As Long, ByVal maxTime As Long)
Public Event PlayFinished()
'================================Variable========================================
Public boolBookmarkPlayed As Boolean
Private oldSeekTime As Long
Private oldDuration As Long
Private startScale As Boolean
Private PlayerPath As String
Private ply_OldDuration As Single
Private ply_bHidden As Boolean
'Private oldFocusWindow As Long
Private bTDu As Boolean 'if start new file skip find duration until seektime start
Private oldVdeoHwnd As Long
Private oldFilePath As String
'=============================constant===========================================
 Private Const WM_COMMAND = &H111
 Private Const WM_SETTEXT = &HC
 Private Const BN_CLICKED = 0
 Private Const WM_KEYDOWN = &H100
 Private Const WM_KEYUP = &H101
 Private Const WM_GETTEXT = &HD
 Private Const GWL_ID = (-12)
 Private Const MK_RBUTTON = &H2
 Private Const WM_RBUTTONDOWN = &H204
 Private Const WM_RBUTTONUP = &H205

 Private Const Nero_Class = "DvdControlerDlg"
 Private Const Nero_OpenFile_ControlID = &H1E02
 Private Const Nero_Vdeo_Class = "VideoRenderer"
 Private Const Nero_Vdeo_Text = "ActiveMovie Window"
 Private Const Nero_VdeoParent_Class = "SkinableControlClass"
 Private Const Nero_VdeoParent_Text = "Nero ShowTime"
 Private Const Nero_SliderVolume_Text = "VolumeSlider"
 '================================================================================
 Public Enum NeroShortcut
   T_Play = vbKeyReturn
   T_Stop = vbKeyS
   T_Pause = vbKeySpace
   T_Previouse = vbKeyP
   T_Next = vbKeyN
   T_SeekTime = vbKeyControl + vbKeyG
   T_ChangeAudioLanguage = vbKeyH
   T_ChangeSubTitle = vbKeyU
   T_MuteSound = vbKeyQ
   T_OnOffSubtitle = vbKeyControl + vbKeyU
 End Enum
 Public Enum NeroControlID
   M_GotoRootMenu = 60602
   M_StartPlayTrackID = &H1F40
   C_CurrentTitle = &H100A
   C_CurrentChapter = &H1004
   C_VolumeSllider = &H100D
   C_ChapterSlider = &HFCC
   C_SeekTime = &H1009
   C_GotoTime = &H800E
   D_GotoTime = &HB6
   C_FileName = &H1005
   C_Hour = &H44F
   C_Minute = &H450
   C_Second = &H451
   C_NextChapter = &HFA4
   C_OK = &H1
   C_Cancel = &H2
   C_StaticDuration = &H455
   C_DisplaySubTitle = &H1C98
   C_MenuSubtile = &HFA9
   C_MenuSubtitleOnOff = 7320
 End Enum
''''''===================================Runtime Variable===============================================
'''Private boolTrackIsChanged As Boolean           'when track changed
Public p_iTitleCount As Integer                'when play file set clear these variable
Private p_iChaptersCount As Integer
Private p_iCurrentTitle As Integer
Private p_aChapters() As Integer
Private p_playingExtension As String                  'playing file extension
Dim VideoWndRect As Rect

Private Property Get currentTitle() As Integer
   currentTitle = val(GetDlgText(neroHwnd, C_CurrentTitle))
End Property
Private Property Get NeroVideoHwnd() As Long
   Dim hwndNeroExternal As Long
   hwndNeroExternal = FindWindow(Nero_VdeoParent_Class, vbNullString)
   If hwndNeroExternal = 0 Then
      hwndNeroExternal = FindWindowEx(ply_hParent, 0, Nero_VdeoParent_Class, vbNullString)
   End If
   If hwndNeroExternal <> 0 Then
      hPlayerVideo_Temp = hwndNeroExternal
      NeroVideoHwnd = hwndNeroExternal
   ElseIf hwndNeroExternal = 0 And hPlayerVideo_Temp <> 0 Then
      NeroVideoHwnd = hPlayerVideo_Temp
   End If
   
End Property
Private Property Get neroHwnd() As Long
   Dim hwndNeroExternal As Long
   hwndNeroExternal = FindWindow(Nero_Class, vbNullString)
   neroHwnd = hwndNeroExternal
End Property

Public Property Get neroVdeoHwnd() As Long
'''   On Error GoTo Error
'''   Dim hVdeo As Long
'''
'''   hVdeo = FindWindowEx(videoParent, 0, Nero_Vdeo_Class, vbNullString)
'''   If hVdeo = 0 Then hVdeo = FindWindowEx(FrmMain.picwmp.hwnd, 0, Nero_Vdeo_Class, vbNullString)
'''   neroVdeoHwnd = hVdeo
'''
'''
'''   Exit Property
'''Error:
'''   WriteEvent "Get neroVdeoHwnd", Err.Description, Err.Source
End Property

Private Sub ProcessNeroShortCut(Keys As NeroShortcut)
   On Error GoTo Error
   PostMessage neroHwnd, WM_KEYDOWN, Keys, &H0 '&H310001
   PostMessage neroHwnd, WM_KEYUP, Keys, &H0 '&HC310001
   Exit Sub
Error:
   WriteEvent "ProcessNeroShortCut", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   PostControlID
' Description       :   Send command to control
' Return Values     :   None
' Input Parameter   :   ControlID
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             12-12-2005           New
'*******************************************************************************
Private Sub PostControlID(controlID As Long)
   On Error GoTo Error
   Dim dlgItemHwnd As Long
   dlgItemHwnd = GetDlgItem(neroHwnd, controlID)
   PostMessage neroHwnd, WM_COMMAND, controlID, dlgItemHwnd
   Exit Sub
Error:
   WriteEvent "PostControlID", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   SendControlID
' Description       :   Send command to control
' Return Values     :   None
' Input Parameter   :   ControlID
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             12-13-2005           New
'*******************************************************************************
Public Sub SendControlID(controlID As Long)
   On Error GoTo Error
   'Doesn't not return until it processes
   Dim dlgItemHwnd As Long
   dlgItemHwnd = GetDlgItem(neroHwnd, controlID)
   SendMessage neroHwnd, WM_COMMAND, controlID, dlgItemHwnd
   Exit Sub
Error:
   WriteEvent "SendControlID", Err.Description, Err.Source
End Sub
Public Property Get GetDlgText(hwndDlg As Long, ID As Long) As String
   On Error GoTo Error
   Dim lpBuffer As String * 255, nLen As Long

   nLen = GetDlgItemText(hwndDlg, ID, lpBuffer, Len(lpBuffer))
   GetDlgText = left(lpBuffer, nLen)
   Exit Property
Error:
   WriteEvent "Get GetDlgText", Err.Description, Err.Source
End Property
'''''
Private Sub Class_Initialize()
   On Error GoTo Error
   Dim loc_tmpPath As String
   'loc_tmpPath = GetKeyValue(HKEY_CLASSES_ROOT, "Applications\showtime.exe\shell\play\command", "", REG_SZ)
   loc_tmpPath = GetKeyValue(HKEY_CLASSES_ROOT, "Applications\SlyDVD.exe\shell\play\command", "", REG_SZ)
   If loc_tmpPath <> "" Then
      PlayerPath = mID(loc_tmpPath, 2, InStr(2, loc_tmpPath, """") - 2)
   Else
      PlayerPath = vbNullString
   End If
   Exit Sub
Error:
   WriteEvent "Class_Initialize", Err.Description, Err.Source
End Sub

Private Property Let IPlayer_AudioLanguageIndex(RHS As Integer)
'
End Property

Private Property Get IPlayer_AudioLanguageIndex() As Integer
'
End Property

Private Property Get IPlayer_ChapterCount() As Integer
'
   IPlayer_ChapterCount = p_iChaptersCount
End Property

Private Sub IPlayer_ClearPlayList()
'
End Sub

Private Function IPlayer_CurrentChapter() As Long
On Error GoTo Error
   IPlayer_CurrentChapter = val(GetDlgText(neroHwnd, C_CurrentChapter))
   Exit Function
Error:
End Function

Private Property Get IPlayer_duration() As Single
   On Error GoTo Error
   Static staticLooping As Boolean
   Dim hForeground As Long
   Dim hSeekTime As Long
   Dim i As Long
   Dim str As String
   Dim hCancel As Long
   Dim arr() As String
   If IPlayer_Seeks > 0 And NeroVideoHwnd <> 0 Then
      If ply_OldDuration > 0 Then
         IPlayer_duration = ply_OldDuration
      Else
         hSeekTime = FindWindow("#32770", "Seek to time")
         If hSeekTime <> 0 Then
            'don't make it open 2 times
            hCancel = GetDlgItem(hSeekTime, C_Cancel)
            PostMessage hSeekTime, WM_COMMAND, C_Cancel, hCancel
         End If
      
         If staticLooping Then Exit Property
         staticLooping = True
         hForeground = GetForegroundWindow
         If hSeekTime = 0 Then
            'don't make it open 2 times
            PostControlID C_GotoTime               'post to open dlg
         End If
      DoEvents
      Sleep 100
   '''      For i = 0 To 100000
   '''         If bExitingProgram Then Exit Property
   '''         DoEvents
   '''         hSeekTime = FindWindow("#32770", "Seek to time")
   '''         If hSeekTime <> 0 Or bExitingProgram Then Exit For
   '''      Next
         For i = 0 To 100000
            If bExitingProgram Then Exit Property
            DoEvents
            hSeekTime = FindWindow("#32770", "Seek to time")
            If hSeekTime <> 0 Or bExitingProgram Then Exit For
         Next
         
         MoveWindow hSeekTime, Screen.Width / Screen.TwipsPerPixelX, Screen.Height / Screen.TwipsPerPixelY, 100, 100, True
         ShowWindow hSeekTime, False
         hCancel = GetDlgItem(hSeekTime, C_Cancel)
         str = GetDlgText(hSeekTime, C_StaticDuration)
          PostMessage hSeekTime, WM_COMMAND, C_Cancel, hCancel
          If Len(str) > 0 Then
            str = Trim(right(left(str, Len(str) - 1), Len("00:00:00")))
         End If
         staticLooping = False
         arr() = Split(str, ":")
         If UBound(arr) = 2 Then ply_OldDuration = val(arr(0)) * 3600 + val(arr(1)) * 60 + val(arr(2))
         IPlayer_duration = ply_OldDuration
         SetForegroundToWindow hForeground
      End If
   Else
   End If
   Exit Property
Error:
   WriteEvent "Get duration", Err.Description, Err.Source
End Property
'''''Public Sub JumpTo(ChapterNumber As Long)
'''''   On Error Resume Next
'''''   '&H1F40  Start index of it
'''''   Dim iNewControlID As Long
'''''   Dim i As Integer
'''''
'''''   If p_iTitleCount >= p_iCurrentTitle And p_iTitleCount > 0 Then
'''''      iNewControlID = M_StartPlayTrackID
'''''      For i = 1 To p_iCurrentTitle - 1
'''''         iNewControlID = iNewControlID + p_aChapters(i - 1)
'''''      Next
'''''      iNewControlID = iNewControlID + ChapterNumber - 1
'''''
'''''      'SendControlID iNewControlID
'''''      initSubMenuPopup
'''''      'Sleep 500
'''''      PostMessage neroHwnd, WM_COMMAND, iNewControlID, 0
'''''   ElseIf p_playingExtension = "mp4" Then
'''''      initSubMenuPopup
'''''      PostMessage neroHwnd, WM_COMMAND, M_StartPlayTrackID + ChapterNumber, 0
'''''   End If
'''''   'p_iCurrentTitle
'''''''   Dim arr() As String
'''''''   Dim loc_Index As Long
'''''''   Dim i As Long
'''''''   arr = titleAndChapter
'''''''   For i = 0 To UBound(arr)
'''''''      If InStr(1, arr(i), "Chapter", vbTextCompare) = 1 Then
'''''''         loc_Index = i
'''''''         Exit For
'''''''      End If
'''''''   Next
'''''''   If loc_Index <> 0 Then
'''''''      loc_Index = 33400 + (loc_Index + ChapterNumber - 1)
'''''''      SendMessageLong hMedia, WM_COMMAND, MakeLongs(loc_Index, 0), 0
'''''''   End If
'''''End Sub
'''''
'''''Public Function JumpToTitle(ByVal titleNumber As Long) As Boolean
'''''   On Error Resume Next
'''''''   Dim arr() As String
'''''''   Dim loc_Index As Long
'''''''   Dim i As Long
'''''''   If titleNumber > 0 Then
'''''''      arr = titleAndChapter
'''''''      For i = 0 To UBound(arr)
'''''''         If InStr(1, arr(i), "Title", vbTextCompare) = 1 Then     'not found title
'''''''            loc_Index = i + 1
'''''''            If loc_Index = titleNumber Then
'''''''               JumpToTitle = SendMessageLong(hMedia, WM_COMMAND, MakeLongs(33400 + i, 0), 0)
'''''''               'JumpToTitle = True
'''''''               Exit For
'''''''            End If
'''''''         Else
'''''''            Exit For
'''''''         End If
'''''''      Next
'''''''   End If
'''''''   Sleep 100
'''''
'''''End Function
'''''Private Sub PlayerThread_Timer()
'''''   On Error GoTo Error
'''''    Dim InputSeekStart As Long
'''''    Dim inputSeekEnd As Long
'''''    Dim iSeekLength As Long
'''''    Dim iSeekPosition As Long
'''''    Dim du As Long
'''''
'''''    If b_play Then
'''''    'zoomVdeo
'''''
''''''    If GetHwndCaption(GetFocus) = "Nero ShowTime" Then
''''''      '#32770
''''''      '
'''''''      If FindWindow("#32770", "Seek to time") <> 0 Then
'''''''         'SendDlgItemMessage FindWindow("#32770", "Seek to time"), C_Cancel, BM_CLICK, 0, 0
'''''''         Debug.Print "close"
'''''''      End If
''''''         'PostMessage FindWindow("#32770", "Seek to time"), &H10, 0, 0
''''''      SetFocus FrmMain.hwnd
''''''      SetForegroundWindow FrmMain.hwnd
''''''      SetActiveWindow FrmMain.hwnd
''''''
''''''      'dsf
''''''    End If
'''''   'Debug.Print GetHwndCaption(GetForegroundWindow)
''''''   If GetHwndCaption(GetForegroundWindow) = "Nero ShowTime" Then
''''''      SetForegroundToWindow FrmMain.hwnd
''''''   End If
'''''    If isWindowVideoChanged Then zoomVdeo
'''''    du = duration
'''''     If p_playingExtension = "ifo" And boolTrackIsChanged Then
'''''         If movieStatus = Playing Then
'''''            'JumpTo 1
'''''            boolTrackIsChanged = False
'''''         End If
'''''      End If
'''''      If oldSeekTime <> seekTime Then
''''''====================================do once
'''''        ''  If GetParent(neroVdeoHwnd) <> FrmMain.picwmp.hwnd And seekTime > 0 Then
'''''            If boolBookmarkPlayed = False Then
'''''               'If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then initSubMenuPopup
'''''               playBookmark
'''''               boolBookmarkPlayed = True
'''''               bTDu = True
'''''            End If
'''''            If startScale <> 0 And (neroVdeoHwnd <> oldVdeoHwnd And neroVdeoHwnd <> 0) Then
'''''               scaleVdeo
'''''               zoomVdeo
'''''               oldVdeoHwnd = neroVdeoHwnd
'''''               startScale = False
'''''            End If
'''''         'End If
''''''================================end do once
'''''          oldSeekTime = seekTime
'''''          GetTrackSeekStart_End InputSeekStart, inputSeekEnd, du          'retrieve the seek value
'''''          iSeekLength = inputSeekEnd - InputSeekStart
'''''          iSeekPosition = oldSeekTime - InputSeekStart
'''''          iSeekLength = IIf(iSeekLength <= 0, 1, iSeekLength)
'''''          iSeekPosition = IIf(iSeekPosition < 0, 0, iSeekPosition)
'''''         RaiseEvent SeekChange(oldSeekTime, du)
'''''      End If 'end oldseek<>Seektime
'''''   '==================
'''''      If iSeekPosition + 3 >= iSeekLength And iSeekLength > 0 And du > 0 Then
'''''         oldSeekTime = 0
'''''         PlayerThread.Enabled = False
'''''         bTDu = False
'''''         RaiseEvent PlayFinished
'''''      End If
'''''   Else
'''''      PlayerThread.Enabled = False
'''''   End If
''''''   End If
'''''   Exit Sub
'''''Error:
'''''   WriteEvent "PlayerThread_Timer", Err.Description, Err.Source
'''''End Sub
Private Function videoParent() As Long
'''   On Error GoTo Error
'''   Dim loc_hwndParent As Long
'''   loc_hwndParent = FindWindow(Nero_VdeoParent_Class, vbNullString)
'''   If loc_hwndParent = 0 Then
'''      loc_hwndParent = FindWindowEx(FrmMain.Picture1.hwnd, 0, Nero_VdeoParent_Class, vbNullString)
'''   Else
'''      RemoveShowTimeParent loc_hwndParent
'''   End If
'''   videoParent = loc_hwndParent
'''   Exit Function
'''Error:
'''   WriteEvent "videoParent", Err.Description, Err.Source
End Function
'''''Public Sub scaleVdeo()
'''''   On Error GoTo Error
'''''   Dim i As Long
''''''   Debug.Print Timer
''''''   For i = 0 To 1000000
''''''      DoEvents
''''''      Debug.Print i
''''''      If neroVdeoHwnd <> 0 Then Exit For
''''''   Next
''''''   Debug.Print Timer
'''''   'Debug.Print neroVdeoHwnd
'''''   Dim hwndForegroundWindow As Long
'''''''   Dim hwndFocusWindow As Long
'''''''   Dim hwndActiveWindow As Long
'''''
'''''   hwndForegroundWindow = GetForegroundWindow
'''''   If neroVdeoHwnd > 0 Then
'''''
''''''=====================
'''''''      hwndFocusWindow = GetFocus
'''''''      hwndActiveWindow = GetActiveWindow
'''''
'''''      ShowWindow neroVdeoHwnd, SW_HIDE
'''''      SetParent neroVdeoHwnd, FrmMain.picwmp.hwnd
'''''      MoveWindow neroVdeoHwnd, 0, 0, FrmMain.picwmp.Width / Screen.TwipsPerPixelX, FrmMain.picwmp.Height / Screen.TwipsPerPixelY, True
'''''      Sleep 10
'''''      ShowWindow neroVdeoHwnd, SW_NORMAL
'''''
'''''      'Debug.Print FrmMain.picwmp.Width / Screen.TwipsPerPixelX, FrmMain.picwmp.Height / Screen.TwipsPerPixelY
'''''      EnableWindow neroVdeoHwnd, False
'''''      'resize videoParent to the size of picwmp other it refresh vdeo to videoPrent size when ner chapter begin
'''''      MoveWindow videoParent, 0, 0, FrmMain.picwmp.Width / Screen.TwipsPerPixelX, FrmMain.picwmp.Height / Screen.TwipsPerPixelY, True
'''''''      ShowWindow videoParent, SW_HIDE
'''''      'SetWindowPos videoParent, 0, ScreenX, 0, 0, 0, SWP_NOACTIVATE Or SWP_NOSIZE
''''''===============
'''''''      SetActiveWindow hwndActiveWindow
'''''''      SetForegroundWindow hwndForegroundWindow
'''''''      SetFocus hwndFocusWindow
'''''   End If
''''''   RemoveShowTimeParent
'''''   SetForegroundToWindow hwndForegroundWindow
'''''   Exit Sub
'''''Error:
'''''   WriteEvent "scaleVdeo", Err.Description, Err.Source
'''''End Sub
Private Sub refreshVdeo()
   'SetParent ply_hParent, 0
   SetNewParent ply_hParent, 0
   ShowWindow ply_hParent, False
   'SetParent neroVdeoHwnd, ply_hParent
   SetNewParent NeroVideoHwnd, ply_hParent
End Sub
'''''Private Sub initSubMenuPopup()
'''''   PostMessage neroHwnd, WM_RBUTTONDOWN, MK_RBUTTON, &H150212
'''''   PostMessage neroHwnd, WM_RBUTTONUP, 0, &H150212
'''''   PostMessage neroHwnd, WM_RBUTTONDOWN, MK_RBUTTON, &H150212
'''''End Sub
'''''Private Sub playBookmark()
'''''   On Error GoTo Error
'''''   ''>0  it is bookmark,1 Play Till End,2 PlayTill Next Track,3 Play For amount of seconds,4 Like number 2 but it is jump to chapter not second for karaoke or music              'Index 27
'''''   Dim i As Long
'''''   Dim i_OldSeektime As Long
'''''   Dim i_OldValue As Long
'''''   If int_track_count > 0 Then
'''''      If Infos(int_current_index).trackExternal Then
'''''         Select Case PlayTrackInfo(int_current_index).BookmarkType
'''''            Case 0   ' normal not a bookmark
'''''               If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''''                   Sleep 1000
'''''                   'initSubMenuPopup
'''''                   JumpTo 1
'''''               Else ' if not IFO
'''''                  If run_LoadingLastMusic = False Then ProcessNeroShortCut T_Play: seekTime = 0
'''''               End If  ' if IFO of case 0
'''''
'''''            Case 1, 3 'play till end : specific time
'''''                If run_LoadingLastMusic = False Then seekTime = PlayTrackInfo(int_current_index).BookmarkTime
'''''            Case 2   'PlayTill Next Track
'''''
''''''            Case 3   'Play For amount of seconds
''''''               seekTime = PlayTrackInfo(int_current_index).BookmarkTime
'''''            Case 4   'Like number 2 but it is jump to chapter not second for karaoke or music
'''''         End Select  ' end BookmarkType =0
'''''      Else 'track internal
'''''         Select Case PlayTrackInfo(int_current_index).BookmarkType
'''''            Case 0   ' normal not a bookmark
'''''               If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''''
'''''                  JumpTo CLng(PlayTrackInfo(int_current_index).NoTrack)
'''''                  For i = 0 To 10000
'''''                     If bExitingProgram Then Exit Sub
'''''                     If Not b_pause And Not b_play Then Exit Sub
'''''                     If int_track_count <= 0 Then Exit Sub
'''''                     DoEvents
'''''                     If seekTime > 2 Then Exit For
'''''                  Next
'''''                  seekTime = seekTime + PlayTrackInfo(int_current_index).seekOffset
'''''               Else ' if not IFO
'''''
'''''               End If  ' if IFO of case 0
'''''               i_OldSeektime = seekTime
'''''               For i = 0 To 10000
'''''                  If bExitingProgram Then Exit Sub
'''''                  If Not b_pause And Not b_play Then Exit Sub
'''''                  If int_track_count <= 0 Then Exit Sub
'''''                  DoEvents
'''''                  If seekTime <> i_OldSeektime Then Exit For
'''''               Next
'''''               'Debug.Print seekTime + PlayTrackInfo(int_current_index).SeekOffset
'''''            Case 1, 3 'play till end : specific time
'''''               seekTime = PlayTrackInfo(int_current_index).BookmarkTime
'''''            Case 2   'PlayTill Next Track
''''''            Case 3   'Play For amount of seconds
''''''               seekTime = PlayTrackInfo(int_current_index).BookmarkTime
'''''            Case 4   'Like number 2 but it is jump to chapter not second for karaoke or music
'''''               If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''''                  If PlayTrackInfo(int_current_index).TrackLength <= 0 Then
'''''                     i_OldValue = seekTime
'''''                     JumpTo CLng(PlayTrackInfo(int_current_index).NoTrack + 1)
'''''                     For i = 0 To 100000
'''''                        If bExitingProgram Then Exit Sub
'''''                        If Not b_pause And Not b_play Then Exit Sub
'''''                        If int_track_count <= 0 Then Exit Sub
'''''                        If Abs(i_OldValue - seekTime) > 2 Then Exit For
'''''                        DoEvents
'''''                     Next
'''''                     PlayTrackInfo(int_current_index).BookmarkLength = seekTime
'''''                  End If
'''''                  i_OldValue = seekTime
'''''                  JumpTo CLng(PlayTrackInfo(int_current_index).NoTrack)
'''''                  For i = 0 To 100000
'''''                     If bExitingProgram Then Exit Sub
'''''                     If Not b_pause And Not b_play Then Exit Sub
'''''                     If int_track_count <= 0 Then Exit Sub
'''''                     If Abs(i_OldValue - seekTime) > 2 Then Exit For
'''''                     DoEvents
'''''                  Next
'''''                  PlayTrackInfo(int_current_index).BookmarkTime = seekTime
'''''               Else ' if not IFO
'''''
'''''               End If  ' if IFO of case 0
'''''
'''''               If PlayTrackInfo(int_current_index).TrackLength > 0 Then
'''''                  PlayTrackInfo(int_current_index).BookmarkLength = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).TrackLength
'''''               End If
'''''
'''''               'Debug.Print "Play Ifo", PlayTrackInfo(int_current_index).BookmarkTime, PlayTrackInfo(int_current_index).BookmarkLength
'''''
'''''         End Select  ' end select BookmarkType
'''''      End If ' end track external
'''''   End If ' end int_track_count
'''''   Exit Sub
'''''Error:
'''''   WriteEvent "playBookmark", Err.Description, Err.Source
'''''End Sub
'''''Public Property Get CurrentChapter() As Integer
'''''   On Error GoTo Error
'''''   CurrentChapter = val(GetDlgText(neroHwnd, C_CurrentChapter))
'''''   Exit Property
'''''Error:
'''''   WriteEvent "Get currentChapter", Err.Description, Err.Source
'''''End Property
'''''Public Sub zoomVdeo()
'''''   On Error GoTo Error
'''''  Dim W As Long
'''''  Dim h As Long
'''''
'''''   If int_track_count > 0 Then
'''''      'ShowWindow neroVdeoHwnd, SW_HIDE
'''''      If PlayTrackInfo(int_current_index).ZoomLevel < -30 Then PlayTrackInfo(int_current_index).ZoomLevel = -30      'prevent from make width negative
'''''      W = ((FrmMain.picwmp.Width * (PlayTrackInfo(int_current_index).ZoomLevel * 0.026 + 1)))
'''''      h = ((FrmMain.picwmp.Height * (PlayTrackInfo(int_current_index).ZoomLevel * 0.026 + 1)))
'''''      MoveWindow neroVdeoHwnd, ((FrmMain.picwmp.Width - W) / 2) / Screen.TwipsPerPixelX, ((FrmMain.picwmp.Height - h) / 2) / Screen.TwipsPerPixelY, W / Screen.TwipsPerPixelX, h / Screen.TwipsPerPixelY, True
'''''      'ShowWindow neroVdeoHwnd, SW_SHOWNOACTIVATE
'''''      'FrmMain.picwmp.Visible = True
'''''   End If
'''''   Exit Sub
'''''Error:
'''''   WriteEvent "zoomVdeo", Err.Description, Err.Source
'''''End Sub
'''''Public Function isWindowVideoChanged() As Boolean
'''''   On Error GoTo Error
'''''   Dim lpRect As Rect
'''''   'VideoWndRect
'''''   Call GetWindowRect(neroVdeoHwnd, lpRect)
'''''   isWindowVideoChanged = (VideoWndRect.top <> lpRect.top) And (VideoWndRect.top <> lpRect.top) And _
'''''                          (VideoWndRect.bottom <> lpRect.bottom) And (VideoWndRect.right <> lpRect.right)
'''''   VideoWndRect = lpRect
'''''   'isWindowVideoChanged =
'''''   Exit Function
'''''Error:
'''''   WriteEvent "isWindowVideoChanged", Err.Description, Err.Source
'''''End Function






Private Property Get IPlayer_getBitrateSong() As String
'
End Property

Private Function IPlayer_GotoRootMenu() As Boolean
'
End Function

Private Property Get IPlayer_HasVideo() As Boolean
   IPlayer_HasVideo = True
End Property

Private Function IPlayer_hVideo(ByVal hSource As Long) As Long
'
   Dim lhwnd As Long
   lhwnd = FindWindowEx(hSource, 0, Nero_VdeoParent_Class, vbNullString)
   IPlayer_hVideo = lhwnd
End Function

Private Property Get IPlayer_isInMenuMode() As Boolean
'
End Property

Private Property Get IPlayer_MediaIsnothing() As Boolean
'
End Property

Private Sub IPlayer_Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
   MoveWindow NeroVideoHwnd, left / Screen.TwipsPerPixelX, top / Screen.TwipsPerPixelY, Width / Screen.TwipsPerPixelX, Height / Screen.TwipsPerPixelY, True
End Sub

Private Property Get IPlayer_Mute() As Boolean
   IPlayer_Mute = ply_bMute
End Property

Private Property Let IPlayer_Mute(ByVal RHS As Boolean)
   ply_bMute = RHS
   If ply_bMute Then PlayerVolume 0 Else PlayerVolume ply_iVolume
End Property

Private Function IPlayer_NextChapter() As Boolean
   '
End Function
Private Function IPlayer_PreviousChapter() As Boolean
   '
End Function


Private Sub IPlayer_object(wmpObject As Object, wmpTimer As Timer, SourcePlayer As Player)
   '
   Set playerObject = wmpObject
   Set playerTimer = wmpTimer
   Set playerSource = SourcePlayer
   ply_hParent = wmpObject.hwnd  'playerObject.Container.hwnd
   TimerTask = TaskNone
   'In this section we start a new player if it wasn't created
   
End Sub

Private Sub IPlayer_Pause()
   ProcessNeroShortCut T_Pause
End Sub

Private Sub IPlayer_Play()
   ProcessNeroShortCut T_Play
End Sub

Private Function IPlayer_playState() As Integer
   '
   If IsWindowEnabled(GetDlgItem(neroHwnd, &HFA4)) = 0 Then IPlayer_playState = 2
End Function


Private Sub IPlayer_RestoreParent()
'
End Sub

Private Property Let IPlayer_Seeks(RHS As Single)
   On Error GoTo Error
   Dim i As Long, hwndDlgSeekTime As Long
   Dim loc_iHour As Integer, loc_iMinute As Integer, loc_iSecond As Integer
   Dim loc_bDisable As Boolean, hButtonOK As Long
   Dim boolSlyOnForeground As Boolean
   Dim fgHwnd As Long

   fgHwnd = GetForegroundWindow()
   SetNeroFocus2Sly
   If FindWindow("#32770", "Seek to time") = 0 Then
      'don't make it open 2 times
      PostControlID C_GotoTime               'post to open dlg
   End If

   For i = 0 To 100000
      If bExitingProgram Then Exit Property
      DoEvents
      hwndDlgSeekTime = FindWindow("#32770", "Seek to time")
      If hwndDlgSeekTime <> 0 Then Exit For
   Next
   ShowWindow hwndDlgSeekTime, False
   If hwndDlgSeekTime <> 0 Then
      loc_iHour = RHS \ 3600
      loc_iMinute = (RHS Mod 3600) \ 60
      loc_iSecond = (RHS Mod 3600) Mod 60
      For i = 0 To 10000
         If bExitingProgram Then Exit Property
         DoEvents
         hButtonOK = GetDlgItem(hwndDlgSeekTime, C_OK)
         If hButtonOK <> 0 Then           'Find the button OK
            SendMessageString GetDlgItem(hwndDlgSeekTime, C_Hour), WM_SETTEXT, 0, loc_iHour
            SendMessageString GetDlgItem(hwndDlgSeekTime, C_Minute), WM_SETTEXT, 0, loc_iMinute
            SendMessageString GetDlgItem(hwndDlgSeekTime, C_Second), WM_SETTEXT, 0, loc_iSecond
            loc_bDisable = (GetWindowLong(GetDlgItem(hwndDlgSeekTime, C_OK), GWL_STYLE) And WS_DISABLED) = WS_DISABLED
            If loc_bDisable Then
               'Press the cacel
               SendDlgItemMessage hwndDlgSeekTime, C_Cancel, BM_CLICK, 0, 0
            Else
               PostMessage hwndDlgSeekTime, WM_COMMAND, &H1, hButtonOK
            End If
            Exit For
         End If
      Next
   SetForegroundWindow fgHwnd
   SetNeroFocus2Sly
   End If
   Exit Property
Error:
   WriteEvent "Let seekTime", Err.Description, Err.Source
End Property

Private Property Get IPlayer_Seeks() As Single
  'On Error GoTo Error

  Dim MovieTime() As String
  Dim arr_Time() As String
  Dim loc_Time As String

  loc_Time = GetDlgText(neroHwnd, C_SeekTime)

  arr_Time = Split(loc_Time, ":")
  If loc_Time <> "" Then
      If UBound(arr_Time) > 1 Then
         IPlayer_Seeks = CInt(arr_Time(0)) * 3600 + CInt(arr_Time(1)) * 60 + CInt(arr_Time(2))
      End If
   End If
End Property

Private Function IPlayer_SelectChapter(ByVal iChapter As Integer) As Boolean
'
'''   Debug.Print GetChapterParent
   PlayerChapter iChapter
End Function

Private Function IPlayer_SelectTitle(ByVal iTitle As Integer) As Boolean
'

End Function

Private Sub IPlayer_SetNewParent(ByVal hNewParent As Long)
'
   If SetParent(IPlayer_hVideo(ply_hParent), hNewParent) <> 0 Then
      ply_hNewParent = hNewParent
   Else
      ply_hNewParent = 0
   End If
   
End Sub
Private Property Let Turnsubtitle(bValue As Boolean)
   'initSubMenuPopup
   initSubMenuPopup
   Dim i As Boolean
   Dim hMenu As Long
   hMenu = GetMenu(neroHwnd)
   'for i=0 to
   'GetSubMenu
   Debug.Print
   'iNewControlID = M_StartPlayTrackID
   'For i = 1 To p_iCurrentTitle - 1
   'iNewControlID = iNewControlID + p_aChapters(i - 1)
   'Next
   'iNewControlID = iNewControlID + Value '- 1
         
End Property
Private Property Get IPlayer_Status() As String
'
End Property

Private Sub IPlayer_Stops()
   ProcessNeroShortCut T_Stop
End Sub

Private Property Let IPlayer_stretchToFit(RHS As Boolean)
'
End Property

Private Function IPlayer_SwitchAudio(Optional iChannel As Integer = -1) As Integer
   'if PlayTrackInfo(int_current_index).
   'ProcessNeroShortCut T_ChangeAudioLanguage
   
   Dim iNewChannel As Integer
   On Error Resume Next
   If iChannel = -1 Then
      'Switch only for external
      'iNewChannel = ((playerObject.Controls.currentAudioLanguageIndex + 1) Mod playerObject.Controls.audioLanguageCount) '+ 1
'''      iNewChannel = (playerObject.Controls.currentAudioLanguageIndex + 1)
'''      If iNewChannel > playerObject.Controls.audioLanguageCount Then
'''         iNewChannel = 1
'''      End If
   '   ProcessNeroShortCut T_ChangeAudioLanguage
  '    IPlayer_SwitchAudio = 1
   Else
      ' ply_iAudioIndex=
'
'''      If iChannel < playerObject.Controls.audioLanguageCount Then
'''         iNewChannel = (iChannel + 1)        'Start from 1
'''      Else
'''         iNewChannel = 1
'''      End If

   End If
'''   playerObject.Controls.currentAudioLanguageIndex = iNewChannel: DoEvents
   'Error if can't change audio channel
   'DoEvents
'''   IPlayer_SwitchAudio = playerObject.Controls.currentAudioLanguageIndex
      ProcessNeroShortCut T_ChangeAudioLanguage

   On Error GoTo 0
   
End Function

Private Function IPlayer_SwitchSubtitle(Optional iSubtitle As Integer = -1) As Integer
''   If PlayTrackInfo(int_current_index).SubTitle Then
''      If ply_bSubtitle = False Then
''         ply_bSubtitle = True
''         'ProcessNeroShortCut T_OnOffSubtitle
''         'ProcessKeyShortCut
''          'initSubMenuPopup
''         SendControlID C_MenuSubtitleOnOff
''      End If
''   Else
''      If ply_bSubtitle = True Then
''          'ProcessNeroShortCut T_OnOffSubtitle
''          'initSubMenuPopup
''         SendControlID C_MenuSubtitleOnOff
''         ply_bSubtitle = False
''      End If
''   End If
   
End Function

Private Property Get IPlayer_TitleCount() As Integer
'
End Property

Private Property Let IPlayer_UiMode(RHS As String)
'
End Property

Private Property Get IPlayer_UiMode() As String
'
End Property

Private Property Let IPlayer_url(ByVal RHS As String)
'
   Dim hProcess As Long
   ply_OldDuration = 0
   ply_bHidden = False
   ply_iAudioIndex = 0
   If PlayerPath <> vbNullString Then
      If playerSource.UrlExtension = "ifo" Then p_iChaptersCount = GetChapterCountFromIFO(RHS, 1) Else p_iChaptersCount = 0
      hProcess = ExecuteFile(PlayerPath, """" & RHS & """", SW_SHOWNOACTIVATE)
   Else
      p_iChaptersCount = 0
   End If
   If hProcess <> 0 Then TimerTask = TaskWaitForLoaded
   hPlayerVideo_Temp = 0

End Property

Private Property Let IPlayer_Visible(RHS As Boolean)
   If RHS Then
      ShowWindow NeroVideoHwnd, SW_SHOWNOACTIVATE
   Else
      ShowWindow NeroVideoHwnd, SW_HIDE
   End If
End Property

Private Property Get IPlayer_Visible() As Boolean
   IPlayer_Visible = (IsWindowVisible(NeroVideoHwnd) = SW_NORMAL)
End Property

Private Property Let IPlayer_Volume(ByVal RHS As Single)
   If RHS > 100 Then RHS = 100 Else If RHS < 0 Then RHS = 0
   If RHS > ply_iVolume Then ply_bMute = False
   ply_iVolume = RHS
   If ply_bMute = False Then PlayerVolume RHS Else PlayerVolume 0
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

Private Sub HideNeroProgram()
   If ply_bHidden = False Then
      ply_bHidden = True
      ShowWindow NeroVideoHwnd, SW_HIDE
      SetNewParent NeroVideoHwnd, ply_hParent
      DoEvents
      Sleep 1000
      'MoveWindow NeroVideoHwnd, 0, 0, 100, 100, True
      ShowWindow NeroVideoHwnd, SW_SHOWNOACTIVATE
      EnableWindow NeroVideoHwnd, False
      ShowWindow neroHwnd, SW_HIDE
      SetNeroFocus2Sly
   End If
End Sub

Private Property Let IPlayer_ZoomLevel(RHS As Integer)
'
End Property

Private Function IPlayer_ZoomReset() As Boolean
'
End Function

Private Sub playerTimer_Timer()
   If PlayerTask = TaskWaitForLoaded Then
      If NeroVideoHwnd <> 0 Then
         HideNeroProgram
         If IPlayer_Status = "Playing (Menu)" Then
            PlayerTask = TaskNone
            playerSource.Event_LoadInDVDMenu
         ElseIf IPlayer_Seeks > 2 Then
            PlayerTask = TaskNone
            playerSource.Event_Played (0)
         Else
            'When playing ifo files with only one chapter error (stops) ex. Khmer Karaoke\RSS
            'IPlayer_Play
         End If
      End If
   End If
End Sub

Public Function SetNeroFocus2Sly()
   'Force Nerofocus to goto SlyGuide player program,don't make it lost focus while clicking on nero video
   AttachThreadInput GetWindowThreadProcessId(NeroVideoHwnd, 0), App.threadID, True
End Function


Sub SetNewParent(hWndChild As Long, hwndParent As Long)
   If GetParent(hWndChild) <> hwndParent Then
      SetParent hWndChild, hwndParent
   End If

End Sub
Private Function SetForegroundToWindow(hwndActive As Long)
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


Private Sub PlayerChapter(ByVal Value As Integer)
   On Error Resume Next
   '&H1F40  Start index of it
   Dim iNewControlID As Long
   Dim i As Integer
   
'''   If p_iTitleCount >= p_iCurrentTitle And p_iTitleCount > 0 Then
'''      iNewControlID = M_StartPlayTrackID
'''      For i = 1 To p_iCurrentTitle - 1
'''         iNewControlID = iNewControlID + p_aChapters(i - 1)
'''      Next
'''      iNewControlID = iNewControlID + Value - 1
'''
'''      'SendControlID iNewControlID
'''      initSubMenuPopup
'''      'Sleep 500
'''      PostMessage neroHwnd, WM_COMMAND, iNewControlID, 0
   If playerSource.UrlExtension = "mp4" Then
      initSubMenuPopup
      PostMessage neroHwnd, WM_COMMAND, M_StartPlayTrackID + Value, 0
   Else
      iNewControlID = M_StartPlayTrackID
      'For i = 1 To p_iCurrentTitle - 1
         'iNewControlID = iNewControlID + p_aChapters(i - 1)
      'Next
      iNewControlID = iNewControlID + Value '- 1
      
      'SendControlID iNewControlID
      initSubMenuPopup
      'Sleep 500
      PostMessage neroHwnd, WM_COMMAND, iNewControlID, 0
   End If

'''   Dim iValue As Long
'''   Dim hwndSlider As Long
'''   Dim rc As Rect
'''   Dim iMaxWidth As Long
'''
'''   If p_iChaptersCount > 0 Then
'''      hwndSlider = GetChapterParent
'''      GetWindowRect hwndSlider, rc  'Get the position of slider
'''      iMaxWidth = 130 '(rc.right - rc.left) - 20
'''      iValue = MakeLongs((Value) / p_iChaptersCount * iMaxWidth + 10, 2)
'''      SendMessageLong hwndSlider, WM_LBUTTONDOWN, MK_LBUTTON, iValue
'''      SendMessageLong hwndSlider, WM_LBUTTONUP, 0, 0
'''   End If
End Sub

Private Sub PlayerVolume(ByVal Value As Single)
   Dim iValue As Long
   Dim hwndSlider As Long
   Dim rc As Rect
   Dim iMaxHeight As Long
   
   hwndSlider = GetSliderParent
   
   GetWindowRect hwndSlider, rc  'Get the position of slider
   iMaxHeight = (rc.bottom - rc.top)
   iValue = MakeLongs(2, (100 - Value) / 100 * iMaxHeight)
   SendMessageLong hwndSlider, WM_LBUTTONDOWN, MK_LBUTTON, iValue
   SendMessageLong hwndSlider, WM_LBUTTONUP, 0, 0
End Sub
Private Function GetSlider() As Long
   GetSlider = GetDlgItem(neroHwnd, C_VolumeSllider) 'FindWindowEx(neroHwnd, 0, Nero_VdeoParent_Class, Nero_SliderVolume_Text)
End Function


'''   On Error GoTo Error
'''   Dim lhwnd As Long
'''   lhwnd = FindWindowEx(hSource, 0, "WMPVideoWindow", vbNullString)
'''   If lhwnd = 0 Then lhwnd = FindWindowEx(hSource, 0, "VideoRenderer", vbNullString)
'''   IPlayer_hVideo = lhwnd
'''   Exit Function
'''Error:
'''   WriteEvent "IPlayer_hVideo", Err.Description, Err.Source

Private Function GetSliderParent() As Long
   Dim iValue As Long
   Dim hwndSlider As Long
   Dim rc As Rect
   Dim iMaxHeight As Long
   'Find the first volume slider
   hwndSlider = GetSlider
   'Find the next slider, this is the coorect one
   hwndSlider = GetNextWindow(hwndSlider, GW_HWNDNEXT)
   GetSliderParent = hwndSlider
End Function

Private Property Get GetChapter() As Long
   GetChapter = GetDlgItem(neroHwnd, C_ChapterSlider)
End Property
Private Function IsMenuChecked() As Boolean
'''    Dim handle As Long
'''    Dim info As MENUITEMINFO
'''    InitSubMenu mPlay
'''    handle = GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5)
'''    SendMessageLong hMedia, WM_INITMENUPOPUP, handle, MakeLongs(2, 0)
'''    info.cbSize = Len(info)
'''    info.fMask = MIIM_STATE
'''    GetMenuItemInfo handle, 2, True, info
'''    isFirstChecked = info.fState = 8
End Function
Private Function GetChapterParent() As Long
   Dim iValue As Long
   Dim hwndSlider As Long
   Dim rc As Rect
   Dim iMaxHeight As Long
   'Find the first volume slider
   hwndSlider = GetChapter
   'Find the next slider, this is the coorect one
   hwndSlider = GetNextWindow(hwndSlider, GW_HWNDNEXT)
   GetChapterParent = hwndSlider
End Function

Private Sub initSubMenuPopup()
   PostMessage neroHwnd, WM_RBUTTONDOWN, MK_RBUTTON, &H150212
   PostMessage neroHwnd, WM_RBUTTONUP, 0, &H150212
   PostMessage neroHwnd, WM_RBUTTONDOWN, MK_RBUTTON, &H150212
End Sub
