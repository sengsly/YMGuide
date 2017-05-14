Attribute VB_Name = "RightClilck"
Option Explicit

Public Declare Function CallNextHookEx Lib "user32" (ByVal hHook As Long, ByVal ncode As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function UnhookWindowsHookEx Lib "user32" (ByVal hHook As Long) As Long
Public Declare Function SetWindowsHookEx Lib "user32" Alias "SetWindowsHookExA" (ByVal idHook As Long, ByVal lpfn As Long, ByVal hmod As Long, ByVal dwThreadId As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Private setIntervalCount As Long

'mouse constant
Private Const WH_MOUSE = 7

Private Const WM_RBUTTONDOWN = &H204
Private Const WM_RBUTTONUP = &H205
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202
Private Const WM_LBUTTONDBLCLK = &H203
Private Const WM_MOUSELEAVE = &H2A3 'change -10-11-05
Dim hMouseHook As Long

'keyboard constant
Private Const WH_KEYBOARD = 2
Private Const HC_ACTION = 0
Private Const VK_CONTROL = &H11
Private Const KBH_MASK_ALT = &H20000000
Private Const VK_APPS = &H5D
'Private hHook As Long
 
Dim hKeyboardHook As Long
Private keySent As Boolean


'type structure

Private Type POINTAPI
        X As Long
        Y As Long
End Type

Private Type MOUSEHOOKSTRUCT
        pt As POINTAPI
        hwnd As Long
        wHitTestCode As Long
        dwExtraInfo As Long
End Type
Private Type MOUSEHOOKSTRUCTEx
    hooStruct As MOUSEHOOKSTRUCT
    lData As Long
End Type
Private Type LongType
    HiLow As Long
End Type
Public Type HiLowType
    Hi As Integer
    Low As Integer
End Type


Private Function KeyboardProc(ByVal ncode As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
   Dim returnValue As Long
   Dim boolAction As Boolean
   'HC_ACTION
'   #If debugging = 0 Then
'      boolAction = ncode >= HC_ACTION
'   #Else
'      boolAction = ncode = HC_ACTION
'   #End If
   boolAction = ncode = HC_ACTION
   If boolAction Then
      If monitorOff = True Then
         monitorOff = False
         FrmMain.tmrSlideShow.Enabled = True
         interValCount = 0
      End If
      'If (lParam And &H80000000) <> 0 Then
         returnValue = useKey(wParam, lParam)
      'End If
      If returnValue = 1 Then
         KeyboardProc = 1
         Exit Function
      End If
      
   End If
   KeyboardProc = CallNextHookEx(hKeyboardHook, ncode, wParam, lParam)
   Exit Function
Error:
   WriteEvent "KeyboardProc", Err.Description, Err.Source
End Function

Private Function MouseProc(ByVal ncode As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
   Dim mouseHookTag As MOUSEHOOKSTRUCTEx
   Dim HiLow As HiLowType, HiLong As LongType
   Static oldMousePT As POINTAPI
   Static bMouseDown As Boolean
   If ncode = HC_ACTION Then
      CopyMemory mouseHookTag, ByVal lParam, Len(mouseHookTag)       'Debug.Print wParam, mouseHookTag.hwnd
      Select Case wParam
      Case WM_LBUTTONDBLCLK
         If str_swfNames = "Fullscreen" Then
            'FrmMain.loadFlashFullScreen False
         End If
      Case WM_MOUSEMOVE
         If oldMousePT.X <> mouseHookTag.hooStruct.pt.X Or oldMousePT.Y <> mouseHookTag.hooStruct.pt.Y Then
            ShowMouse = True
         End If
         If monitorOff Then
            interValCount = 0
            monitorOff = False
            FrmMain.tmrSlideShow.Enabled = True
         End If
         oldMousePT = mouseHookTag.hooStruct.pt
      Case WM_RBUTTONDOWN
         bMouseDown = True
         MouseProc = 1
         Exit Function
      Case WM_RBUTTONUP
         If getWndClass(GetActiveWindow) <> "#32770" And bMouseDown Then   'if not browse file dialog
             Call ReleaseCapture                               'Seng 2005-12-02 Make it release the mouse
             If LoadSlideshow = True Then
                 frmSlideShow.Timer1.Enabled = True
             ElseIf str_swfNames = "Fullscreen" Then
                 'FrmMain.Fullscreen False
                 FrmMain.loadFlashFullScreen False
             ElseIf str_swfNames = "Micro" Then
                'FrmMain.cmd_max_Click
                handleMinicommand "Micro2Normal|:|true"
             ElseIf str_swfNames <> "Micro" And bool_full_vis Then
                'scaleMicroByHeight
               ' FrmMain.scale_visualization_to_fullscreen True
                 FrmMain.SWF_FMA_FSCommand 1, "mini", "FullScreen|:|false"
             Else
                 FrmMain.picDVD.Visible = False
                 FrmMain.picPopup.Visible = False
                 sendVariable2Flash FrmMain.swf(IndexSwf), "RightClick", "true"
             End If
         End If
         bMouseDown = False
         'MouseProc = 1
         'Exit Function
      Case 522                   'scroll
         HiLong.HiLow = mouseHookTag.lData
         LSet HiLow = HiLong
         If LoadSlideshow = True Then
             sendVariable2Flash frmSlideShow.SlideShow, "MousePro", HiLow.Low
         Else
            If bool_full_vis Then
               If HiLow.Low > 0 Then
                  handleMinicommand "Volume|:|" & (WaveVolume + 5)
               
               Else
                  handleMinicommand "Volume|:|" & (WaveVolume - 5)
               End If
            Else
            'Change from reversed scroll to normal scroll (2006-07-19) Seng
                sendVariable2Flash FrmMain.swf(IndexSwf), "MousePro", HiLow.Low * (-1)
            End If
             interValCount = 0
         End If
         MouseProc = 1
         Exit Function
      End Select
   End If
   MouseProc = CallNextHookEx(hMouseHook, ncode, wParam, lParam)
   Exit Function
Error:
   WriteEvent "MouseProc", Err.Description, Err.Source
End Function


Public Sub DisableRightClick()
   On Error GoTo Error
   hKeyboardHook = SetWindowsHookEx(WH_KEYBOARD, AddressOf KeyboardProc, 0&, App.threadID)
   hMouseHook = SetWindowsHookEx(WH_MOUSE, AddressOf MouseProc, 0&, App.threadID)
   Exit Sub
Error:
   WriteEvent "DisableRightClick", Err.Description, Err.Source
End Sub

Public Sub EnableRightClick()
   On Error GoTo Error
   Call UnhookWindowsHookEx(hKeyboardHook)
   Call UnhookWindowsHookEx(hMouseHook)
   Exit Sub
Error:
   WriteEvent "EnableRightClick", Err.Description, Err.Source
End Sub

Public Property Get interValCount() As Long
   On Error GoTo Error
    interValCount = setIntervalCount
   Exit Property
Error:
   WriteEvent "Get interValCount", Err.Description, Err.Source
End Property

Public Property Let interValCount(ByVal vNewValue As Long)
   On Error GoTo Error
    setIntervalCount = vNewValue
    FrmMain.tmrSlideShow.Enabled = False
    FrmMain.tmrSlideShow.Enabled = True
   Exit Property
Error:
   WriteEvent "Let interValCount", Err.Description, Err.Source
End Property
Private Function useKey(ByVal wParam As Long, ByVal lParam As Long) As Long
   On Error GoTo Error
   Dim bCtrl As Boolean
   Dim bAlt As Boolean
   Dim bShift As Boolean
   Dim loc_Selection As String
   Dim loc_OldStateBrowse As Boolean
    
   If wParam = VK_APPS Then
      useKey = 1
   Else
      keySent = Not keySent
      If keySent Then
         bCtrl = (GetKeyState(VK_CONTROL) And &HF00) '00000
         bShift = (GetKeyState(16) And &HF00) ' key shift down
         bAlt = (lParam And &H20000000) = &H20000000 'find bit
         
         ' =========== popup addtrack ======================= - sith 21-12-06
         If run_bShowingInputCode Then
            If ((bCtrl And wParam = vbKeyI) Or (Not bCtrl And wParam = vbKeyEscape)) And Not bAlt And Not bShift Then
                  'if showing then close
                  FrmMain.swfAddTrack.SetVariable "ShowForm", "0"
                  FrmMain.swf(IndexSwf).SetFocus
            End If
               useKey = 0
               Exit Function
         End If
         '================= end popup addtrack ==============
        
         ' ==========Ctrl + Plus=============================
         If Not bAlt And Not bShift And bCtrl Then
            If (wParam = 221) Then  ' Ctrl + }
               If CWinsock.LoggedAs(remoteControl) Then
                  CWinsock.Send2Server WS_COMMAND, "ServerVideoZoomIn"
               Else
                  miniCommand "VideoZoomIn|:|false"
               End If
               useKey = 1
            ElseIf (wParam = 219) Then ' Ctrl + {
               If CWinsock.LoggedAs(remoteControl) Then
                  CWinsock.Send2Server WS_COMMAND, "ServerVideoZoomOut"
               Else
                  miniCommand "VideoZoomOut|:|false"
               End If
               useKey = 1
            ElseIf wParam = vbKeyB Then   ' Ctrl + B
               loc_OldStateBrowse = b_BrowseByFolder
               b_BrowseByFolder = True
               If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                   sendVariable2Flash FrmMain.SWF_FMA(1), "clickMoreFile", "true"
                   sendVariable2Flash FrmMain.SWF_FMA(1), "clickEvent", "true"
               Else
                   miniCommand "AddMusic|:|True"
               End If
               b_BrowseByFolder = loc_OldStateBrowse
            ElseIf wParam = vbKeyA Then   ' Ctrl + A
               b_BrowseByFolder = Not b_BrowseByFolder
               sendInfoControllPlayer "Browse By " & IIf(b_BrowseByFolder, "Folder", "File")
               If IndexSwf = 6 Then
                  'if it's in OptionPage then refresh the option in Option Page
                  sendToFlash FrmMain.swf(6), "setBrowseByFolder", CStr(b_BrowseByFolder)
               End If
            ElseIf wParam = vbKeyR Then   ' Ctrl + R
               If show_hide_player Then
                  If CWinsock.LoggedAs(remoteControl) Then
                     CWinsock.Send2Server WS_COMMAND, "Minicommand&&&ResetVdeo|:|true"
                  Else
                     miniCommand "ResetVdeo|:|true"
                  End If
               End If
            ElseIf wParam = vbKeyUp Then 'Ctrl + ArrowUp
               If bool_full_vis Then
                  If close_player_top > 0 Then
                     close_player_top = close_player_top - 1
                     FrmMain.BlankingTop close_player_top
                     useKey = 1
                  End If
               End If
            ElseIf wParam = vbKeyDown Then  'Ctrl + ArrowDown
               If bool_full_vis Then
                  close_player_top = close_player_top + 1
                  FrmMain.BlankingTop close_player_top
                  useKey = 1
               End If
            ElseIf wParam = vbKeyW Then
            'If FrmMain.swfDVDControl.Visible Or bool_full_vis And str_swfNames <> "Micro" Then
               If str_swfNames <> "Micro" Then
                   If IndexSwf = 4 Or IndexSwf = 2 Then
                     FrmMain.txtSearchUnicode.Visible = False
                  End If
                  FrmMain.KeyCtrlPlus "W~0"
                  If IndexSwf = 4 Then
                     DoEvents
                     sendToFlash FrmMain.swf(IndexSwf), "RequestSize", "true"
                  ElseIf IndexSwf = 2 Then
                     DoEvents
                     sendToFlash FrmMain.swf(IndexSwf), "RequestSize", "true"
                  End If
               End If
            ElseIf wParam = vbKeyI Then
               If run_bShowingInputCode Then
                  'if showing then close
                  FrmMain.swfAddTrack.SetVariable "ShowForm", "0"
                  FrmMain.swf(IndexSwf).SetFocus
               Else
                  FrmMain.LoadSwfAddTrack
               End If
            ElseIf wParam = 191 Then               'Ctrl + /      ,VK_OEM_2
'               If bool_full_vis And str_swfNames = "" Then             'minimize in fullscreen Key /
                  handleMinicommand "Minimize|:|true"
'               End If
            End If ' ctrl + key
            
         End If ' not balt
         ' ==========End Ctrl + Plus========================
         ' ============Alt + Plus===========================
         If Not bCtrl And Not bShift And bAlt Then
            If wParam = vbKeyUp Then ' Alt + ArrowUp
               If bool_full_vis Then
                  close_player_buttom = close_player_buttom + 1
                  FrmMain.BlankingBottom close_player_buttom
               End If
            ElseIf wParam = vbKeyDown Then ' Alt + ArrowDown
               If bool_full_vis Then
                  If close_player_buttom > 0 Then
                     close_player_buttom = close_player_buttom - 1
                     FrmMain.BlankingBottom close_player_buttom
                  End If
               End If
            ElseIf wParam = 13 Then ' Alt + Enter
               If str_swfNames <> "Micro" Then
                  handleMinicommand "FullScreen|:|true"
                  useKey = 1
               End If
            ElseIf wParam = vbKeyM Then
               handleMinicommand "GotoRootMenu|:|false"
            End If ' balt + key
         End If ' not bctrl
         ' =========
         ' === Key ===
         If Not bAlt And Not bCtrl And Not bShift And getWndClass(GetActiveWindow) <> "#32770" Then
            If wParam = vbKeyW Or wParam = vbKeyA Or wParam = vbKeyQ Or wParam = 222 Or wParam = 186 Or wParam = vbKeyS Or _
               wParam = vbKeyB Or wParam = vbKeyZ Or wParam = vbKeyC Or wParam = vbKeyX Or wParam = 82 Or wParam = 83 Or _
               wParam = 88 Or wParam = 67 Or wParam = 86 Or wParam = 70 Or wParam = 68 Or wParam = 90 Or wParam = 69 Or _
               wParam = 79 Or wParam = 81 Or wParam = 85 Or wParam = 84 Or wParam = 119 Or wParam = 117 Or wParam = 37 Or _
               wParam = 38 Or wParam = 39 Or wParam = 40 Or wParam = 77 Or wParam = vbKeyPageDown Or wParam = vbKeyPageUp Or _
               wParam = 118 Or wParam = 187 Or wParam = 189 Or wParam = 107 Or wParam = 109 Or wParam = vbKeySpace Then
               loc_Selection = CallFlashFunction(FrmMain.swf(IndexSwf), "selectionGetfocus")
               If loc_Selection = "" Then loc_Selection = CallFlashFunction(FrmMain.swf(IndexSwf), "Selection.getFocus")
'''               If GetClass(GetActiveWindow) = "#32770" Then
'''                  'prevent process key from the open dialogbox
'''                  Exit Function
'''               End If
               If IndexSwf = 0 Then
                  If (GetFlashVar(FrmMain.swf(IndexSwf), "Mainlevel") = "2" Or GetFlashVar(FrmMain.swf(IndexSwf), "Mainlevel") = "3" Or GetFlashVar(FrmMain.swf(IndexSwf), "Mainlevel") = "1") And Not bool_full_vis And str_swfNames <> "Micro" Then
                     Exit Function
                  End If
               End If
               If (loc_Selection = "" Or loc_Selection = "null") And Not b_TextBoxGetFocus And Not bCtrl And Not bAlt Then
                  'if it is not in the TextField
                  Select Case wParam
                     Case vbKeyE, vbKeyO, 37, 38, 39, 40
                        handleShortCutKey wParam
                     Case vbKeyV
                        handleMinicommand "Stop|:|true"
                     Case vbKeyS
                        handleMinicommand "Shuffle|:|" & LCase(Not b_shuffle)
                     Case vbKeyR
                        handleMinicommand "Repeat|:|" & LCase(Not b_loop)
                     Case vbKeyB
                        GotoTrack True
                     Case vbKeyZ
                        GotoTrack False
                     Case vbKeyF     'f
                        If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                            sendVariable2Flash FrmMain.SWF_FMA(1), "clickMoreFile", "true"
                            sendVariable2Flash FrmMain.SWF_FMA(1), "clickEvent", "true"
                        Else
                            miniCommand "AddMusic|:|True"
                        End If
                     Case vbKeyF6       'f6         set volume to 0
                        handleMinicommand "Volume|:|0"
                     Case vbKeyF7       'f7         set volume to 50%
                        handleMinicommand "Volume|:|50"
                     Case vbKeyF8        'f8         set volume to 100%
                        handleMinicommand "Volume|:|100"
                     Case vbKeyM     'm
                        handleMinicommand "Mute|:|" & LCase(Not b_mute)         'm
                     Case vbKeyX                                               'x
                        handleMinicommand "Play|:|true"
                     Case vbKeyC                                               'c
                        handleMinicommand "Pause|:|true"
                     Case vbKeySpace
                        If (IndexSwf <> 4 Or bool_full_vis = True) And Settings.b_ShowPopupInfo Then
                           popUp
                           useKey = 1
                        End If
                     Case vbKeyW
                        If int_track_count > 0 And int_current_index >= 0 Then
                           If Not boolPress Then setSubTitleWMP
                        End If
                     Case vbKeyA
                        handleMinicommand "karaoke_voice|:|" & LCase(Not b_karaoke_voice)
                     Case vbKeyQ
                        If int_current_index >= 0 And int_track_count > 0 Then
                            miniCommand "enabled_subtitle|:|" & LCase(Not PlayTrackInfo(int_current_index).SubTitle)
                        End If
                    Case 222  'next chapter '
                        'If show_hide_player Then
                        handleMinicommand "NextChapter|:|false"
                        'If FrmMain.picwmp.Visible Then handleMinicommand "NextChapter|:|false"
                    Case 186   'prev chapter ;
                        'If show_hide_player Then
                        handleMinicommand "PreviousChapter|:|false"
                    Case vbKeyPageDown
                        handleMinicommand "seekdown|:|true"
                    Case vbKeyPageUp
                        handleMinicommand "seekup|:|true"
                    Case 187, 107
                        handleMinicommand "Volume|:|" & (WaveVolume + 5)        '-
                    Case 189, 109
                        handleMinicommand "Volume|:|" & (WaveVolume - 5)          '+
                  
                  End Select
               End If
            ElseIf wParam = vbKeyDelete Then
               If IndexSwf = 4 Or IndexSwf = 3 Then
                  sendToFlash FrmMain.swf(IndexSwf), "DeleteTrack", "true"
               End If
            ElseIf wParam = vbKeyEscape Then
               If run_bShowingInputCode Then FrmMain.swfAddTrack.SetVariable "ShowForm", "0"
               If Not bool_full_vis Then FrmMain.swf(IndexSwf).SetFocus Else FrmMain.picwmp.SetFocus
            ElseIf wParam = vbKeyPageDown Or wParam = vbKeyPageUp Then
               If FrmMain.picMovieBackground.Visible Then
                  handleShortCutKey wParam
                  If str_swfNames <> "Micro" And bool_full_vis Then
                     'if in the fullscreen video show the control while using the pageup or page down
                     FrmMain.LoadSwfDvdControl
                  End If
               End If
            Else
'''               ElseIf wParam = vbKeyEscape Then
'''                  sendVariable2Flash FrmMain.swf(IndexSwf), "vb", "closeAddBox|%|"
'''               Else
            
               ProcessKeyShortCut bCtrl, bAlt, wParam
            End If
         End If
         ' === end key ===
      End If 'end ncode
   End If
   
   Exit Function
Error:
   WriteEvent "useKey", Err.Description, Err.Source
End Function
Public Sub GotoRootMenu()
   On Error GoTo Error
   If int_track_count > 0 Then
      If bool_full_vis = True Or IndexSwf = 4 Or IndexSwf = 0 Then
         If LCase(fso.GetExtensionName(str_current_Track)) = "ifo" Then
            CPlayer.GotoRootMenu
            run_PreviousRootMenu = True
'''            If playMusicWith = Winamp Then
'''               CMediaPlayer.NavigateMenu naRootMenu
'''               run_PreviousRootMenu = True
'''            ElseIf playMusicWith = nero Then
'''               FrmMain.NSPlayer.SendControlID M_GotoRootMenu
'''            Else
'''               CWmp.dvd.topMenu
'''               run_PreviousRootMenu = True
'''            End If
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "gotoRootMenu", Err.Description, Err.Source
End Sub
