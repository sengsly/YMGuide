VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Begin VB.Form frmOver 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   1800
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3735
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1800
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmr_close_mouse_over 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   0
      Top             =   1320
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfOver 
      Height          =   1350
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3675
      _cx             =   6482
      _cy             =   2381
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
Attribute VB_Name = "frmOver"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim timeFadeOut As Integer

Public Sub showMe()
    On Error GoTo Error
    Dim tmpTheme As String
    Dim tw As Long
    Dim th As Long
    Dim flashWidth As Long, flashHeight As Long
    Dim popupScalePercent As Single
    If int_track_count > 0 Then
      tw = ScreenX * Screen.TwipsPerPixelX
      th = ScreenY * Screen.TwipsPerPixelY
      
      LoadSwf swfOver, App.path & "\sly\micro_old.sly"
      
      flashWidth = GetFlashVar(swfOver, "StageWidth")
      flashHeight = GetFlashVar(swfOver, "StageHeight")
      popupScalePercent = ScaleX(FrmMain.Width, vbTwips, vbPixels) / flashWidth
      Me.Width = FrmMain.Width
      Me.Height = ScaleY(flashHeight * popupScalePercent, vbPixels, vbTwips) '(Me.Width * 90) / 245
      Me.left = FrmMain.left
      If FrmMain.top + FrmMain.Height + Me.Height > th Then
          Me.top = FrmMain.top - Me.Height '- 10
      Else
          Me.top = FrmMain.top + FrmMain.Height ' + 10
      End If
      
      swfOver.Width = Me.Width
      swfOver.Height = Me.Height
      swfOver.left = 0
      swfOver.top = 0
      
            tmpTheme = s_background_color & "::"
            tmpTheme = tmpTheme & s_button_color & "::"
            tmpTheme = tmpTheme & s_button_color_alpha & "::"
            tmpTheme = tmpTheme & s_button_color_selected & "::"
            tmpTheme = tmpTheme & s_button_color_selected_alpha & "::"
            tmpTheme = tmpTheme + s_text_color
            
            sendToFlash swfOver, "setColor", tmpTheme
            sendVariable2Flash swfOver, "playMusic", CStr(b_play)
            sendVariable2Flash swfOver, "loopMusic", CStr(b_loop)
            sendVariable2Flash swfOver, "shuffleMusic", CStr(b_shuffle)
            sendVariable2Flash swfOver, "slideshow", b_slideshow
            sendVariable2Flash swfOver, "volume", WaveVolume
            sendVariable2Flash swfOver, "mute", CStr(b_mute)
            sendToFlash swfOver, "clientType", CWinsock.LoggedType
            sendToFlash swfOver, "textScroll", strCurrent
            sendToFlash swfOver, "KaraokeAudio", CStr(b_karaoke_voice)
            
            
            sendVariable2Flash swfOver, "syn_volume", CStr(syn_vol)
            sendVariable2Flash swfOver, "syn_volume_change", CStr(change_vol)
      
      Call SetWindowPos(hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW Or SWP_NOACTIVATE)
      
   End If
   Exit Sub
Error:
   WriteEvent "showMe", Err.Description, Err.Source
End Sub

Public Sub hideMe()
   tmr_close_mouse_over_Timer
End Sub



Private Sub swfOver_FSCommand(ByVal command As String, ByVal args As String)
 On Error GoTo Error
   Select Case command
      Case "NextPrevious"
         If args = "Next" Then
            GotoTrack True
         ElseIf args = "Previous" Then
            GotoTrack False
         End If
      Case "showMe"
      Case "MoveMicro"
         If CWinsock.LoggedType = remoteControl Then
            Call FrmMain.SWF_FMA_FSCommand(2, command, args)
         End If
      Case "hide"
         tmr_close_mouse_over_Timer
      Case Else
         Call FrmMain.SWF_FMA_FSCommand(2, command, args)
    End Select
    Exit Sub
Error:
   WriteEvent "swfOver_FSCommand", Err.Description, Err.Source
End Sub

Public Sub tmr_close_mouse_over_Timer()
  On Error GoTo Error
  
    frmOver.Visible = False
    tmr_close_mouse_over.Enabled = False
    Exit Sub
Error:
   WriteEvent "tmr_close_mouse_over_Timer", Err.Description, Err.Source
End Sub

