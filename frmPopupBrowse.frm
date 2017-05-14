VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Begin VB.Form frmPopupBrowse 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin VB.Timer tmrCloseAds 
      Enabled         =   0   'False
      Interval        =   30000
      Left            =   2880
      Top             =   480
   End
   Begin VB.Timer trmUnloadBrowse 
      Enabled         =   0   'False
      Left            =   2880
      Top             =   0
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfPopupBrowse 
      Height          =   2895
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2895
      _cx             =   5106
      _cy             =   5106
      FlashVars       =   ""
      Movie           =   ""
      Src             =   ""
      WMode           =   "Window"
      Play            =   "-1"
      Loop            =   "-1"
      Quality         =   "High"
      SAlign          =   ""
      Menu            =   "-1"
      Base            =   ""
      AllowScriptAccess=   "always"
      Scale           =   "ShowAll"
      DeviceFont      =   "0"
      EmbedMovie      =   "0"
      BGColor         =   ""
      SWRemote        =   ""
      MovieData       =   ""
      SeamlessTabbing =   "1"
      Profile         =   "0"
      ProfileAddress  =   ""
      ProfilePort     =   "0"
      AllowNetworking =   "all"
      AllowFullScreen =   "false"
   End
End
Attribute VB_Name = "frmPopupBrowse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const WM_COPY = &H301
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Sub ReleaseCapture Lib "user32" ()
Const WM_NCLBUTTONDOWN = &HA1
Const HTCAPTION = 2
Dim tmpTop As Long
Dim tmpLeft As Long
Public browseFirst As Boolean
Dim boolMicroActive As Boolean
Dim mousePositionPopup As POINTAPI
Dim bool_movePopup As Boolean



Private Sub swfPopupBrowse_FSCommand(ByVal command As String, ByVal args As String)
On Error GoTo Error
    Select Case command
        Case "setFocus"
            SetActiveWindow FrmMain.hwnd
        Case "showMe"
            Call SetWindowPos(frmPopupBrowse.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
        Case "loadAgain"
            If bool_movePopup = False Then
                Me.Visible = False
                loadBrowsePopup
            End If
        Case "close"
            If IsRegistered = True Then sendToFlash frmPopupBrowse.swfPopupBrowse, "close", "true"
        Case "Exit"
            If args = "setFocus" Then
                SetActiveWindow FrmMain.hwnd
            End If
            trmUnloadBrowse.Enabled = True
            trmUnloadBrowse.Interval = 1
            frmPopupBrowse.Hide
        Case "moveBrowse"
            bool_movePopup = True
            Call ReleaseCapture
            sendToFlash frmPopupBrowse.swfPopupBrowse, "moveBrowse", CStr(bool_movePopup)
            Call SendMessage(hwnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&)
            
            moveInScreen frmPopupBrowse, frmPopupBrowse.left, frmPopupBrowse.top, ScreenX, ScreenY
            tmpTop = frmPopupBrowse.top
            tmpLeft = frmPopupBrowse.left
            
            SetActiveWindow FrmMain.hwnd
            bool_movePopup = False
            sendToFlash frmPopupBrowse.swfPopupBrowse, "moveBrowse", CStr(bool_movePopup)
        Case "squareBrowse"
            If bool_movePopup = False Then
                loadSquareBrowse args
            End If
            
        Case "showMe"
            ' frmPopupBrowse.Visible = True
        Case "mb"
            Debug.Print args
    End Select
    Exit Sub
Error:
   WriteEvent "swfPopupBrowse_FSCommand", Err.Description, Err.Source
End Sub

Private Sub swfPopupBrowse_GotFocus()
   On Error GoTo Error
    SetActiveWindow FrmMain.hwnd
   Exit Sub
Error:
   WriteEvent "swfPopupBrowse_GotFocus", Err.Description, Err.Source
End Sub

Private Sub tmrCloseAds_Timer()
   On Error GoTo Error
    If IsRegistered = True Then sendToFlash frmPopupBrowse.swfPopupBrowse, "close", "true"
   Exit Sub
Error:
   WriteEvent "tmrCloseAds_Timer", Err.Description, Err.Source
End Sub

Private Sub trmUnloadBrowse_Timer()
   On Error GoTo Error
    tmrCloseAds.Enabled = False
    trmUnloadBrowse.Enabled = False
    trmUnloadBrowse.Interval = 0
    Unload Me
   Exit Sub
Error:
   WriteEvent "trmUnloadBrowse_Timer", Err.Description, Err.Source
End Sub

Public Sub loadBrowsePopup()
On Error GoTo Error
    GetCursorPos tmpMousePositionPopup
    tmrCloseAds.Enabled = True
    bool_microActive = (GetActiveWindow() = FrmMain.hwnd)
    If (frmPopupBrowse.Visible = False And b_ads = True) Or (frmPopupBrowse.Visible = False And IsRegistered = False) Then
        If ScreenType = "Normal" Or ScreenType = "smallWideScreen" Or ScreenType = "largeWideScreen" Then
            LoadSwf swfPopupBrowse, App.path & "\sly\PopupBrowse1024.sly"
        ElseIf ScreenType = "wideScreen" Or ScreenType = "mediumLargeWideScreen" Or ScreenType = "mediumWideScreen" Then
            LoadSwf swfPopupBrowse, CStr(App.path & "\sly\PopupBrowse1280.sly")
        End If
        
        If ScreenType = "Normal" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(650)) / 1024) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(180)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "wideScreen" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(230)) / 720) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumWideScreen" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(230)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumLargeWideScreen" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(230)) / 800) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "smallWideScreen" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(650)) / 1024) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(180)) / 600) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "largeWideScreen" Then
            frmPopupBrowse.Width = ((ScreenX * CLng(650)) / 800) * Screen.TwipsPerPixelX
            frmPopupBrowse.Height = ((ScreenY * CLng(180)) / 640) * Screen.TwipsPerPixelY
        End If
        
        frmPopupBrowse.left = ((ScreenX * Screen.TwipsPerPixelX) - frmPopupBrowse.Width) / 2
        frmPopupBrowse.top = ((ScreenY * Screen.TwipsPerPixelY) - frmPopupBrowse.Height) / 2
        
        swfPopupBrowse.Width = frmPopupBrowse.Width
        swfPopupBrowse.Height = frmPopupBrowse.Height
        swfPopupBrowse.left = 0
        swfPopupBrowse.top = 0
        
        sendToFlash swfPopupBrowse, "Color", s_color_bar & "|~|" & s_background_color & "|~|" & s_button_color & "|~|" & s_button_color_alpha & "|~|" & s_button_color_selected & "|~|" & s_button_color_selected_alpha
        
'        '===============================
'        ' reset forcu on micro player
'        If bool_microActive Then
'            bool_microActive = False
'            FrmMain.SetFocus
'            FrmMain.SWF_FMA(2).SetFocus
'        End If
'        '===============================
        
    End If
    Exit Sub
Error:
   WriteEvent "loadBrowsePopup", Err.Description, Err.Source
End Sub

Sub loadSquareBrowse(ads_str As String)
On Error GoTo Error
    GetCursorPos tmpMousePositionPopup
    bool_microActive = (GetActiveWindow() = FrmMain.hwnd)
    
    LoadSwf swfPopupBrowse, App.path & "\sly\PopupBrowse.sly"
    
    If ScreenType = "Normal" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(400)) / 1024) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(424)) / 768) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "wideScreen" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(400)) / 1280) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(424)) / 720) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "mediumWideScreen" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(400)) / 1280) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(424)) / 768) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "mediumLargeWideScreen" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(400)) / 1280) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(424)) / 800) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "smallWideScreen" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(400)) / 1024) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(424)) / 600) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "largeWideScreen" Then
        frmPopupBrowse.Width = ((ScreenX * CLng(300)) / 800) * Screen.TwipsPerPixelX
        frmPopupBrowse.Height = ((ScreenY * CLng(318)) / 640) * Screen.TwipsPerPixelY
    End If
    frmPopupBrowse.left = (ScreenX * Screen.TwipsPerPixelX - frmPopupBrowse.Width) / 2
    frmPopupBrowse.top = (ScreenY * Screen.TwipsPerPixelY - frmPopupBrowse.Height) / 2
    
    swfPopupBrowse.Width = frmPopupBrowse.Width
    swfPopupBrowse.Height = frmPopupBrowse.Height
    swfPopupBrowse.left = 0
    swfPopupBrowse.top = 0
    
    sendToFlash swfPopupBrowse, "Color", s_color_bar & "|~|" & s_background_color & "|~|" & s_button_color & "|~|" & s_button_color_alpha & "|~|" & s_button_color_selected & "|~|" & s_button_color_selected_alpha
    sendToFlash swfPopupBrowse, "display", ads_str

'    '===============================
'    ' reset forcu on micro player
'    If bool_microActive Then
'        FrmMain.SetFocus
'        bool_microActive = False
'        FrmMain.SWF_FMA(2).SetFocus
'    End If
'    '===============================
   Exit Sub
Error:
   WriteEvent "loadSquareBrowse", Err.Description, Err.Source
End Sub


