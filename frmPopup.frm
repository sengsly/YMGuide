VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Begin VB.Form frmPopup 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   7260
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   10155
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   7260
   ScaleWidth      =   10155
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swf 
      Height          =   2895
      Index           =   0
      Left            =   6960
      TabIndex        =   7
      Top             =   120
      Visible         =   0   'False
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
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   4335
      Left            =   1080
      TabIndex        =   0
      Top             =   360
      Visible         =   0   'False
      Width           =   5655
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         BackColor       =   &H8000000D&
         FillColor       =   &H0080C0FF&
         ForeColor       =   &H000000FF&
         Height          =   3000
         Left            =   0
         ScaleHeight     =   2970
         ScaleWidth      =   2970
         TabIndex        =   1
         Top             =   0
         Width           =   3000
         Begin VB.Image Image1 
            Height          =   2295
            Left            =   0
            Top             =   0
            Width           =   2415
         End
      End
      Begin VB.Label lblArtist 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label5"
         Height          =   195
         Left            =   3120
         TabIndex        =   6
         Top             =   2760
         Width           =   480
      End
      Begin VB.Label lblTitle 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label4"
         Height          =   195
         Left            =   3240
         TabIndex        =   5
         Top             =   2160
         Width           =   480
      End
      Begin VB.Label lblPos 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label3"
         Height          =   195
         Left            =   3240
         TabIndex        =   4
         Top             =   1680
         Width           =   480
      End
      Begin VB.Label lblLen 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label2"
         Height          =   195
         Left            =   3120
         TabIndex        =   3
         Top             =   840
         Width           =   480
      End
      Begin VB.Label lblSample 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label1"
         Height          =   195
         Left            =   3240
         TabIndex        =   2
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   1440
      Top             =   0
   End
End
Attribute VB_Name = "frmPopup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim font_size As Integer
Dim limon_font_size  As Integer
Dim other_font_size As Integer
Dim len_text As Integer
Dim rets As Long


Private Const WM_COPY = &H301
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Sub ReleaseCapture Lib "user32" ()
Const WM_NCLBUTTONDOWN = &HA1
Const HTCAPTION = 2

Private Const WM_GETTEXT = &HD

Dim b_moving As Boolean



Public boolMicroActive As Boolean

Private Sub Form_Initialize()
   On Error GoTo Error
    '---------------------------
    ' load flash controll
    Load frmPopup.swf(1)
    frmPopup.swf(1).Visible = True
    '---------------------------
   Exit Sub
Error:
   WriteEvent "Form_Initialize", Err.Description, Err.Source
End Sub

Private Sub swf_FSCommand(Index As Integer, ByVal command As String, ByVal args As String)
On Error GoTo Error

    If Index = 1 Then
        Select Case command
            Case "movePopup"
                b_moving = True
                Call ReleaseCapture
                Call SendMessage(hwnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&)
                movePopup frmPopup, Me.left, Me.top, ScreenX, ScreenY
                b_moving = False
                FrmMain.SWF_FMA(2).SetFocus
                SetActiveWindow FrmMain.hwnd
                Exit Sub
            Case "buyCD"
               If int_track_count > 0 Then
                  If int_track_count > 0 Then
                     If Infos(int_current_index).trackAlbumID <> "" Then
                        FrmMain.PurchaseCD Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args '
                     End If
                  End If
'''                  If playMusicWith = WindowMedia Then
'''                     If CWmp.currentPlaylist.count > 0 And Infos(int_current_index).trackAlbumID <> "" Then
'''                         FrmMain.PurchaseCD Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args '
'''                     End If
'''                  ElseIf playMusicWith = Winamp Then
'''                     If int_track_count > 0 And Infos(int_current_index).trackAlbumID <> "" Then
'''                         FrmMain.PurchaseCD Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args
'''                     End If
'''                  End If
               End If
            Case "closePurchase"
                Timer1.Enabled = False
                Timer1.Interval = 1
                Timer1.Enabled = True
                frmPopup.Hide
            Case "mb"
                Debug.Print args
        End Select
    End If
    Exit Sub
Error:
   WriteEvent "swf_FSCommand", Err.Description, Err.Source
End Sub

Private Sub swf_GotFocus(Index As Integer)
On Error GoTo Error

    If str_popupType <> "purchasePopup" Then
        SetActiveWindow FrmMain.hwnd
    End If
    Exit Sub
Error:
   WriteEvent "swf_GotFocus", Err.Description, Err.Source
End Sub

Private Sub Timer1_Timer()
On Error GoTo Error
    On Error Resume Next
    If b_moving = False Then
        Timer1.Enabled = False
        If str_popupType = "purchasePopup" Then
            Unload swf(1)
            Load swf(1)
            swf(1).Visible = True
        End If
        str_popupType = ""
        frmPopup.Hide
    End If
    Exit Sub
Error:
   WriteEvent "Timer1_Timer", Err.Description, Err.Source
End Sub

Sub getOther()
On Error GoTo Error
    Dim tmpw As Long
    Dim tmph As Long
    tmpw = ScreenX
    tmph = ScreenY
    If (tmpw / tmph = (1024 / 768)) Then
        font_size = 20
        limon_font_size = 46
        other_font_size = 34
        len_text = 500
    ElseIf (tmpw / tmph = (1280 / 720)) Then
        font_size = 30
        limon_font_size = 56
        other_font_size = 44
        len_text = 900
    ElseIf (tmpw / tmph = (1280 / 768)) Then
        font_size = 30
        limon_font_size = 56
        other_font_size = 44
        len_text = 900
    ElseIf (tmpw / tmph = (1280 / 800)) Then
        font_size = 30
        limon_font_size = 56
        other_font_size = 44
        len_text = 900
    ElseIf (tmpw / tmph = (1024 / 600)) Then
        font_size = 30
        limon_font_size = 56
        other_font_size = 44
        len_text = 500
    End If
Error:
   Exit Sub
   WriteEvent "getOther", Err.Description, Err.Source
End Sub

Private Function convertColor(str_color As String) As Double
On Error GoTo Error
    Dim tmp As String
    tmp = Mid(str_color, 3)
    convertColor = val("&H" & Mid(tmp, 5, 2) & Mid(tmp, 3, 2) & Mid(tmp, 1, 2))
Error:
   Exit Function
   WriteEvent "converColor", Err.Description, Err.Source
End Function

Sub scaleImage(SQuare As Long)
On Error GoTo Error
   Dim newHeight As Long
   Dim newWidth As Long
   Dim oldHeight As Long
   Dim oldWidth As Long
   Dim newLeft As Long
   Dim newTop As Long
   
   Image1.Picture = LoadPicture("C:\square.jpg")
   oldHeight = Image1.Picture.Height
   oldWidth = Image1.Picture.Width
   newWidth = SQuare
   newHeight = SQuare
   If oldWidth > oldHeight Then
      newHeight = (oldHeight / oldWidth) * newWidth
   Else
      newWidth = (oldWidth / oldHeight) * newHeight
   End If
   newLeft = (SQuare - newWidth) / 2
   newTop = (SQuare - newHeight) / 2
   Image1.Move newLeft, newTop, newWidth, newHeight
Error:
   Exit Sub
   WriteEvent "scaleImage", Err.Description, Err.Source
End Sub
'==============================================================================

Public Sub scalePopupInfo(bool_purchase As Boolean)
On Error GoTo Error
    If bool_purchase = True Then
    
        str_popupType = "purchasePopup"
        
        If ScreenType = "Normal" Or ScreenType = "smallWideScreen" Or ScreenType = "largeWideScreen" Then
            LoadSwf swf(1), App.path & "\sly\Popup.sly"
        ElseIf ScreenType = "wideScreen" Or ScreenType = "mediumLargeWideScreen" Or ScreenType = "mediumWideScreen" Then
            LoadSwf swf(1), App.path & "\sly\Popup.sly"
        End If
        
        If ScreenType = "Normal" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 1024) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "wideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 720) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumLargeWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 800) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "smallWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 1024) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 600) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "largeWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(437)) / 800) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(171)) / 640) * Screen.TwipsPerPixelY
        End If
        
        frmPopup.left = ((ScreenX * Screen.TwipsPerPixelX) - frmPopup.Width) / 2
        frmPopup.top = ((ScreenY * Screen.TwipsPerPixelY) - frmPopup.Height) / 2
        
        swf(1).Width = frmPopup.Width
        swf(1).Height = frmPopup.Height
        swf(1).left = 0
        swf(1).top = 0
        
        sendToFlash swf(1), "color", s_text_color & "//\\" & s_button_color & "//\\" & s_button_color_alpha & "//\\" & s_button_color_selected & "//\\" & s_button_color_selected_alpha & "//\\" & s_color_bar
        
        Call SetWindowPos(frmPopup.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
        swf(1).SetFocus
        
    Else
        
        str_popupType = "trackPopup"
        
        If ScreenType = "Normal" Or ScreenType = "smallWideScreen" Or ScreenType = "largeWideScreen" Then
            LoadSwf swf(1), App.path & "\sly\PopupInfo1024.sly"
        ElseIf ScreenType = "wideScreen" Or ScreenType = "mediumLargeWideScreen" Or ScreenType = "mediumWideScreen" Then
            LoadSwf swf(1), App.path & "\sly\PopupInfo1280.sly"
        End If
        
        If ScreenType = "Normal" Then
            frmPopup.Width = ((ScreenX * CLng(650)) / 1024) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(150)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "wideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(200)) / 720) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(200)) / 768) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "mediumLargeWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(866)) / 1280) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(200)) / 800) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "smallWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(650)) / 1024) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(150)) / 600) * Screen.TwipsPerPixelY
        ElseIf ScreenType = "largeWideScreen" Then
            frmPopup.Width = ((ScreenX * CLng(650)) / 800) * Screen.TwipsPerPixelX
            frmPopup.Height = ((ScreenY * CLng(150)) / 640) * Screen.TwipsPerPixelY
        End If
        
        frmPopup.left = ((ScreenX * Screen.TwipsPerPixelX) - frmPopup.Width) / 2
        frmPopup.top = ((ScreenY * Screen.TwipsPerPixelY) - frmPopup.Height) / 2
        
        swf(1).Width = frmPopup.Width
        swf(1).Height = frmPopup.Height
        swf(1).left = 0
        swf(1).top = 0
        
        sendToFlash swf(1), "color", s_text_color & "//\\" & s_button_color & "//\\" & s_button_color_alpha & "//\\" & s_button_color_selected & "//\\" & s_button_color_selected_alpha & "//\\" & s_color_bar
        
        Timer1.Enabled = False
        Timer1.Interval = (10 * 1000)
        Timer1.Enabled = True
        
        Call SetWindowPos(frmPopup.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
        If frmPopupBrowse.Visible = True Then Call SetWindowPos(frmPopupBrowse.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
        
    End If
Error:
   Exit Sub
   WriteEvent "scalePopupInfo", Err.Description, Err.Source
End Sub

