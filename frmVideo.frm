VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash.ocx"
Begin VB.Form frmVideo 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Sly Video"
   ClientHeight    =   6210
   ClientLeft      =   0
   ClientTop       =   60
   ClientWidth     =   6570
   FillColor       =   &H000000FF&
   Icon            =   "frmVideo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   6570
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox picVideo 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   6195
      Left            =   0
      ScaleHeight     =   6165
      ScaleWidth      =   6585
      TabIndex        =   0
      Top             =   0
      Width           =   6615
      Begin VB.Timer tmrAdv 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   60
         Top             =   5820
      End
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfAdv 
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Top             =   -5000
      Width           =   1635
      _cx             =   2884
      _cy             =   556
      FlashVars       =   ""
      Movie           =   ""
      Src             =   ""
      WMode           =   "Window"
      Play            =   -1  'True
      Loop            =   -1  'True
      Quality         =   "High"
      SAlign          =   ""
      Menu            =   -1  'True
      Base            =   ""
      AllowScriptAccess=   "always"
      Scale           =   "ShowAll"
      DeviceFont      =   0   'False
      EmbedMovie      =   0   'False
      BGColor         =   ""
      SWRemote        =   ""
   End
End
Attribute VB_Name = "frmVideo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim tmpPath As String
Dim tmpTime As Integer
'Dim BannerDuration As Integer                 'Time in second to hide Banner when showing it

Public Sub ResetVideoParent()
'''   SetParent CPlayer.hVideo(FrmMain.picMovieBackground.hwnd), picVideo.hwnd
   CPlayer.SetNewParent picVideo.hwnd
   picVideo.Move 0, 0, Width, Height
   scaleWMPVdeo
   picVideo.Enabled = False
End Sub
Public Sub showMe()
   Dim iLeft As Long, iTop As Long
   Dim rmVideo As RECTM               'Monitor for Sly Video
   Dim rmSly As RECTM            'Monitor for Sly Program
   Dim loc_bDifferenceMonitor As Boolean
   
   
   rmVideo = MonitorRECTM(i_VideoMonitor)
   rmSly = MonitorRECTM(i_SlyMonitor)
   
   'If the one of the monitor coordinate is difference then,the it's on different monitor
   If (rmVideo.left <> rmSly.left Or rmVideo.top <> rmSly.top Or rmVideo.Width <> rmSly.Width Or rmVideo.Height <> rmSly.Height) Then
      loc_bDifferenceMonitor = True
   Else
      loc_bDifferenceMonitor = False
   End If


   If loc_bDifferenceMonitor Then            'Different monitor
      ResizeFormPixel hwnd, rmVideo.Width, rmVideo.Height
      MoveForm2Monitor i_VideoMonitor, hwnd, 0, 0
   Else
      'Set window to normal state show caption
      iLeft = (rmVideo.Width - (Me.Width / Screen.TwipsPerPixelX)) / 2
      iTop = (rmVideo.Height - (Me.Height / Screen.TwipsPerPixelY)) / 2
      MoveForm2Monitor i_VideoMonitor, hwnd, iLeft, iTop
   End If
   
   run_FormVideoLoaded = True
   ResetVideoParent
   moveMinicontrol False
   sendToFlash FrmMain.swfMiniControl, "FullScreenIn", "True"
End Sub

Private Sub Form_GotFocus()
   FrmMain.SetFocus
End Sub

Private Sub Form_Load()
   showMe
End Sub

Private Sub Form_Resize()
   'Resize to Form size
   picVideo.Move 0, 0, Width, Height
   scaleWMPVdeo
End Sub

Private Sub Form_Unload(Cancel As Integer)
   run_FormVideoLoaded = False
'''   SetParent CPlayer.hVideo(picVideo.hwnd), FrmMain.picMovieBackground.hwnd
   CPlayer.RestoreParent
   scaleWMPVdeo
   moveMinicontrol True
End Sub
'== sith 21/10/06
Private Sub moveMinicontrol(value As Boolean)
   If value Then
      FrmMain.picMini.top = FrmMain.picwmp.top - FrmMain.picMini.Height
      FrmMain.picMini.left = FrmMain.picwmp.left
   Else
      FrmMain.picMini.top = FrmMain.picwmp.top
      FrmMain.picMini.left = FrmMain.picwmp.left
   End If
   
   FrmMain.picwmp.Visible = value
End Sub


Public Sub showAdv(bShow As Boolean)
   On Error GoTo errDesc:
   Dim i As Long
   If bShow Then
      tmrAdv.Enabled = False
      'swfAdv.Visible = True
      swfAdv.Movie = BannerCurrent.filename
      swfAdv.ZOrder 0   'Send to front keep last focus
      For i = 0 To 100
        swfAdv.Move 0, 0, Me.Width, (Me.Height * (BannerHeight / 100) * i) / 100
        DoEvents
        Sleep 5
      Next i

       'swfAdv.Movie = AdvPath & "\Banner.swf"
      tmrAdv.Enabled = True
   Else

      For i = 100 To 0 Step -1
         swfAdv.Move 0, 0, Me.Width, (Me.Height * (BannerHeight / 100) * i) / 100
         DoEvents
         Sleep 5
      Next
      'swfAdv.Visible = False
      swfAdv.ZOrder 1            'Send to back keep last focus
      swfAdv.Movie = "None"
      DoEvents
   End If
errDesc:
End Sub

Private Sub tmrAdv_Timer()
   tmpTime = tmpTime + 1
   If tmpTime > BannerCurrent.Length Then
      tmrAdv.Enabled = False
      tmpTime = 0
      showAdv False
   End If
End Sub
