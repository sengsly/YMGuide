VERSION 5.00
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "msinet.ocx"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "mswinsck.ocx"
Object = "{7935966C-7928-4E31-99B3-E9DB87FD9E30}#2.0#0"; "UniEditControl.ocx"
Begin VB.Form FrmMain 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SlyDVDGuide"
   ClientHeight    =   12135
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   18900
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   9.75
      Charset         =   222
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   12135
   ScaleWidth      =   18900
   Begin VB.CommandButton cmdLogout 
      Caption         =   "Logout"
      Height          =   495
      Left            =   8400
      TabIndex        =   27
      Top             =   1320
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Login"
      Height          =   495
      Left            =   6960
      TabIndex        =   26
      Top             =   1320
      Width           =   1215
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfAddTrack 
      Height          =   1875
      Left            =   9000
      TabIndex        =   23
      Top             =   2280
      Visible         =   0   'False
      Width           =   4695
      _cx             =   8281
      _cy             =   3307
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
   Begin UniEditControl.ControlEdit txtSearchUnicode 
      Height          =   1095
      Left            =   3240
      TabIndex        =   22
      Top             =   5160
      Visible         =   0   'False
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   1931
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Khmer OS System"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BackColor       =   16777215
      FontSize        =   20.25
   End
   Begin VB.Timer tmrFindTime 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   0
      Top             =   8520
   End
   Begin VB.Timer tmrSlideShow 
      Left            =   3120
      Top             =   8520
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3960
      Top             =   8520
   End
   Begin VB.Timer tmrMouse 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   960
      Top             =   8520
   End
   Begin VB.Timer tmr 
      Enabled         =   0   'False
      Interval        =   400
      Left            =   480
      Top             =   8520
   End
   Begin VB.Timer tmrReg 
      Interval        =   60000
      Left            =   1440
      Top             =   8520
   End
   Begin VB.Timer tmrDownload 
      Interval        =   100
      Left            =   2700
      Top             =   8520
   End
   Begin VB.Timer tmrUnloadFull 
      Enabled         =   0   'False
      Left            =   1800
      Top             =   8520
   End
   Begin VB.Timer tmrUnloadMicro 
      Enabled         =   0   'False
      Left            =   2280
      Top             =   8520
   End
   Begin VB.Timer MediaTimer 
      Interval        =   100
      Left            =   3540
      Tag             =   "Use with Winamp"
      Top             =   8520
   End
   Begin VB.PictureBox picTarget 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   4920
      ScaleHeight     =   73
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   121
      TabIndex        =   16
      TabStop         =   0   'False
      Top             =   120
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.PictureBox picSource 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2775
      Left            =   5880
      ScaleHeight     =   185
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   193
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   2280
      Visible         =   0   'False
      Width           =   2895
   End
   Begin VB.Timer tmr_startPlay 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   4440
      Tag             =   "Play song that is downloading"
      Top             =   8520
   End
   Begin VB.Timer tmrRetryDownload 
      Interval        =   20000
      Left            =   4920
      Tag             =   "Timer for retry download song from server or client for every 10s"
      Top             =   8520
   End
   Begin VB.Timer tmrPlayTrackDelay 
      Interval        =   10
      Left            =   5400
      Tag             =   "For delay play each track"
      Top             =   8520
   End
   Begin VB.Timer tmr_hide_cmdFull 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   5880
      Top             =   8520
   End
   Begin VB.DirListBox Dir1 
      Height          =   360
      Left            =   8040
      TabIndex        =   14
      Top             =   8520
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.FileListBox File1 
      Height          =   330
      Left            =   9240
      TabIndex        =   13
      Top             =   8520
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Timer tmrOneSecond 
      Interval        =   1000
      Left            =   6360
      Tag             =   "1s time interval"
      Top             =   8520
   End
   Begin VB.PictureBox picPopup 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1920
      Left            =   -600
      ScaleHeight     =   1920
      ScaleWidth      =   7500
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   2760
      Visible         =   0   'False
      Width           =   7500
      Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfPopupFullPlayer 
         Height          =   2055
         Left            =   120
         TabIndex        =   12
         TabStop         =   0   'False
         Tag             =   "Set it into this to make only has one parent in finding handle"
         Top             =   -120
         Visible         =   0   'False
         Width           =   3855
         _cx             =   6800
         _cy             =   3625
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
         BGColor         =   "000000"
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
   Begin VB.Timer tmr_press_select_chapter 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   6840
      Top             =   8520
   End
   Begin VB.PictureBox picMini 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   2295
      Left            =   1440
      ScaleHeight     =   2295
      ScaleWidth      =   3975
      TabIndex        =   9
      Tag             =   "Control to hold miniControl"
      Top             =   3960
      Visible         =   0   'False
      Width           =   3975
      Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfMiniControl 
         Height          =   1305
         Left            =   0
         TabIndex        =   10
         Top             =   0
         Width           =   3570
         _cx             =   6297
         _cy             =   2302
         FlashVars       =   ""
         Movie           =   "No"
         Src             =   "No"
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
   Begin VB.PictureBox picDVD 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   6480
      ScaleHeight     =   2055
      ScaleWidth      =   3375
      TabIndex        =   7
      Tag             =   "Control to hold DVDControl"
      Top             =   5880
      Visible         =   0   'False
      Width           =   3375
      Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfDVDControl 
         Height          =   855
         Left            =   960
         TabIndex        =   8
         Tag             =   "Set it into this to make only has one parent in finding handle"
         Top             =   0
         Visible         =   0   'False
         Width           =   4335
         _cx             =   7646
         _cy             =   1508
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
         BGColor         =   "000000"
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
   Begin VB.PictureBox Picture1 
      Height          =   1455
      Left            =   11160
      ScaleHeight     =   1395
      ScaleWidth      =   1395
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1140
      Width           =   1455
   End
   Begin VB.PictureBox picwmp 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5715
      Left            =   10080
      ScaleHeight     =   5715
      ScaleWidth      =   4995
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   4440
      Visible         =   0   'False
      Width           =   4995
      Begin VB.PictureBox picMovieBackground 
         Appearance      =   0  'Flat
         BackColor       =   &H00000000&
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         ForeColor       =   &H80000008&
         Height          =   3855
         Left            =   600
         ScaleHeight     =   3855
         ScaleWidth      =   4095
         TabIndex        =   4
         Top             =   360
         Width           =   4095
         Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfImagePlaying 
            Height          =   1695
            Left            =   780
            TabIndex        =   24
            Top             =   60
            Width           =   2295
            _cx             =   4048
            _cy             =   2990
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
         Begin VB.PictureBox wmp1 
            Enabled         =   0   'False
            Height          =   2835
            Left            =   0
            ScaleHeight     =   2775
            ScaleWidth      =   5775
            TabIndex        =   21
            TabStop         =   0   'False
            Top             =   1320
            Visible         =   0   'False
            Width           =   5835
         End
         Begin WMPLibCtl.WindowsMediaPlayer wmp 
            Height          =   975
            Left            =   1320
            TabIndex        =   25
            Top             =   2880
            Width           =   735
            URL             =   ""
            rate            =   1
            balance         =   0
            currentPosition =   0
            defaultFrame    =   ""
            playCount       =   1
            autoStart       =   -1  'True
            currentMarker   =   0
            invokeURLs      =   -1  'True
            baseURL         =   ""
            volume          =   50
            mute            =   0   'False
            uiMode          =   "full"
            stretchToFit    =   0   'False
            windowlessVideo =   0   'False
            enabled         =   -1  'True
            enableContextMenu=   -1  'True
            fullScreen      =   0   'False
            SAMIStyle       =   ""
            SAMILang        =   ""
            SAMIFilename    =   ""
            captioningID    =   ""
            enableErrorDialogs=   0   'False
            _cx             =   1296
            _cy             =   1720
         End
      End
      Begin VB.CommandButton cmd_max 
         Height          =   360
         Left            =   240
         TabIndex        =   3
         Top             =   5280
         Visible         =   0   'False
         Width           =   360
      End
   End
   Begin VB.PictureBox blank_top 
      Appearance      =   0  'Flat
      BackColor       =   &H80000006&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   480
      ScaleHeight     =   375
      ScaleWidth      =   2295
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.PictureBox blank_buttom 
      Appearance      =   0  'Flat
      BackColor       =   &H80000006&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   480
      ScaleHeight     =   375
      ScaleWidth      =   2295
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   2295
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash pic_time_popup 
      Height          =   975
      Left            =   9000
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   240
      Visible         =   0   'False
      Width           =   2655
      _cx             =   4683
      _cy             =   1720
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
   Begin MSWinsockLib.Winsock sckClient 
      Left            =   4080
      Top             =   2400
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemotePort      =   49210
   End
   Begin MSWinsockLib.Winsock sckUDPClient 
      Left            =   4800
      Top             =   2400
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemotePort      =   49210
   End
   Begin MSWinsockLib.Winsock sckUDPServer 
      Left            =   5960
      Top             =   2400
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemotePort      =   49210
   End
   Begin MSWinsockLib.Winsock sckServer 
      Index           =   0
      Left            =   3480
      Top             =   2400
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      LocalPort       =   49210
   End
   Begin InetCtlsObjects.Inet inetDownload 
      Left            =   1920
      Top             =   2040
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash SWF_FMA 
      Height          =   915
      Index           =   0
      Left            =   4500
      TabIndex        =   17
      Top             =   6840
      Visible         =   0   'False
      Width           =   1155
      _cx             =   2037
      _cy             =   1614
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
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash Saving 
      Height          =   1455
      Left            =   3720
      TabIndex        =   18
      Top             =   3000
      Visible         =   0   'False
      Width           =   8175
      _cx             =   14420
      _cy             =   2566
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
   Begin InetCtlsObjects.Inet ie_Transfer 
      Left            =   1320
      Tag             =   "Download image from internet"
      Top             =   2040
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfAbout 
      Height          =   2895
      Left            =   7080
      TabIndex        =   19
      Top             =   3720
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
      Menu            =   "0"
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
   Begin MSComDlg.CommonDialog cdlFont 
      Left            =   840
      Top             =   3000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash Swf 
      Height          =   2895
      Index           =   0
      Left            =   480
      TabIndex        =   20
      Top             =   5640
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
      Menu            =   "0"
      Base            =   ""
      AllowScriptAccess=   "always"
      Scale           =   "ShowAll"
      DeviceFont      =   "0"
      EmbedMovie      =   "0"
      BGColor         =   "000000"
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
Attribute VB_Name = "FrmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Class for Search page
Dim WithEvents fb As CBackend
Attribute fb.VB_VarHelpID = -1
Dim WithEvents f_cSystray As cSystray
Attribute f_cSystray.VB_VarHelpID = -1

Dim currentAlbumID As String
Dim denyConnection As Boolean
Const permission_access_password = "3" '
Const all_permissions = "123456"
Dim bPopupControlShowed As Boolean
Dim b_delete_myAlbum As Boolean
Dim tmp_type_display_playback As Boolean
Dim tmp_type_playback_only As Boolean
Dim tmp_type_independent As Boolean
Dim tmp_type_remotecontrol As Boolean
Dim tmp_type_syn_volume  As Boolean
Dim tmp_type_copy_slideshow As Boolean
Dim tmp_type_syn_slideshow As Boolean
Dim index_of_client_login As Integer
Dim num_display_client As Integer
Dim vDeo As Long
Dim b_acces_pass As Boolean

Dim pull_out As Boolean
Dim bar_color As String
Dim text_color As String
Dim button_color As String
Dim button_alpha As String
Dim button_color_selected As String
Dim button_alpha_selected As String

Dim load_already As Boolean
Dim click_self As Boolean
Dim temp_type_login As String

'Public WithEvents MediaPlayer As Winamp_Control
Dim vlc As Object
Private boolStartEncoding As Boolean
Private lastBrowseBy As String 'for refresh when disconnect
' =======================================================

Dim GroupingReleaseDate As Boolean
Dim open_form_language As Boolean
Dim b_loading As Boolean
Dim tmpchangeWindow As Boolean
Dim boolLooping As Boolean
Public SplitSly As String
Public SplitPlayer As String
Dim SetPlayListName As String
Dim SetPlayListDir As String
Dim SetPlayListSlidePath  As String
Dim timeReg As String


' Variable for rip CD
Dim ripString() As String
Dim encodeAlbumID As Integer
Public CountryPath As String
'Public LanguageCountry() As String
Dim unl As Boolean
'.........slideshow
Public StrFont As String

' ...........StAllCountrys as string
Dim stAllCountrys As String
Dim DisplayPage As String
Dim Grouping As Integer
Dim SHF As Boolean
Dim selectSortedType As Integer
'Public DialogOpen As CommonDialog
Dim WithEvents EventPlayer As Player
Attribute EventPlayer.VB_VarHelpID = -1
Dim WithEvents cDownload As cIEDownload
Attribute cDownload.VB_VarHelpID = -1
Dim WithEvents CNet As cNetwork
Attribute CNet.VB_VarHelpID = -1
'..............................
Public Sub DownloadFileSoft(index)
   downloadSoftData = downloadList(index)
   inetDownload.Execute downloadSoftData.sourceURL, "get"
End Sub

'-------------------------------Start of Encoder----------------------------------------
Sub StartConvert()
End Sub



Private Sub cDownload_onCompleted(lpFile As cFile, Success As Boolean)
   
   Debug.Print "Source URL= " & lpFile.url, "Status Success= " & Success
   
   If lpFile.DownloadType = DL_ADS Then
   ElseIf lpFile.DownloadType = DL_ALBUM Then
   
   ElseIf lpFile.DownloadType = DL_ARTIST Then
   
   ElseIf lpFile.DownloadType = DL_BACK Then
   
   ElseIf lpFile.DownloadType = DL_DATABASE Then
   
   ElseIf lpFile.DownloadType = DL_LANGUAGES Then
   
   ElseIf lpFile.DownloadType = DL_MEDIA Then
   
   ElseIf lpFile.DownloadType = DL_PURCHASEDALBUM Then
      Debug.Print lpFile.albumID
      Debug.Print lpFile.TrackID
      
   ElseIf lpFile.DownloadType = DL_PURCHASEDTRACK Then
      Debug.Print lpFile.albumID, lpFile.TrackID
      If Success Then
         CBrowse.SetTrackPath(lpFile.TrackID) = lpFile.DesFile
      End If
      
   ElseIf lpFile.DownloadType = DL_SCREEN Then
   
   ElseIf lpFile.DownloadType = DL_UPDATE Then
   
   ElseIf lpFile.DownloadType = DL_UPDATED Then
      
   End If
End Sub

Private Sub cDownload_onStartDownload()
   f_cSystray.BalloonText = "Downloading " & fso.GetBaseName(cDownload.DownloadFile.DesFile)
   f_cSystray.BalloonTitle = "Media Download 1 out of " & cDownload.DownloadItemCount
   f_cSystray.BalloonShow True, 5000
End Sub

Public Sub cmd_max_Click()
   On Error GoTo Error
   If str_swfNames = "Micro" Then
      Dim oldState_FullScreen As Boolean
      picwmp.Visible = False                                             'Seng 2005.12.01 while it return back from micro show a rectangle screen
      frmOver.hideMe
      If frmPopup.Visible = True Then
         frmPopup.Timer1.Enabled = False
         frmPopup.Timer1.Interval = 1
         frmPopup.Timer1.Enabled = True
         frmPopup.Hide
      End If
      oldState_FullScreen = bool_full_vis
      MicroAds False, False, 0, 0
      If oldState_FullScreen Then        'Seng 2006-02-08
         miniCommand "FullScreen|:|true"
      End If
   End If
   Exit Sub
Error:
   WriteEvent "cmd_max_Click", Err.Description, Err.Source
End Sub

Private Sub DownloadAWSPurchased()
   Dim i As Long
   Dim mAlbums As New Collection, mTracks As New Collection
   Dim serverURL As String
   Dim bucketName As String
   Dim awsURL As String
   Dim mFile As cFile
   Dim mTrack As CTrack
   Set mAlbums = fb.getFavoriteAlbums()
   Set mTracks = fb.findTrackAndAlbumDownload(mAlbums, mAlbums)
   Debug.Print "Item counts =  ", mTracks.count
   For i = 1 To mTracks.count
      Set mTrack = mTracks.item(i)
      
      bucketName = mTrack.VideoURL
      
      awsURL = AWS.getYMGuideURL(bucketName)
      
      Debug.Print "AWS URL=", bucketName
      Set mFile = New cFile
      
      With mFile
         .TrackID = mTrack.ID
         .albumID = mTrack.Album.ID
         .DownloadType = DL_PURCHASEDTRACK
         .Language = "Khmer Karaoke"
         .LanguageID = 1
         .url = awsURL
         .DesFile = fso.BuildPath(get_country_path(.Language), fso.GetBaseName(awsURL) & ".mp4")
      End With
      cDownload.AddDownloadItem mFile
      
   Next
End Sub

Private Sub cmdLogout_Click()
   fb.Logout
End Sub

Private Sub Command1_Click()

   fb.Initialize frmFBLogin
   fb.Loginfb
'''   Dim AWS As New AWSS3Heper
'''   Dim Y As Collection
'''   Dim i As Long
'''
'''   Debug.Print AWS.getMediaPath(1, "dsds dsdsdsds dsds", " Hel  33 32329929 ", "RHM")
'''   Set Y = CBrowse.findDownloadTrackAlbum(10)
'''   For i = 1 To Y.count
'''      Debug.Print Y.item(i).ID, Y.item(i).Title, Y.item(i).Album.Title, Y.item(i).Album.Label.Title
'''   Next
'''
'''
'''   Dim serverURL As String
'''   Dim bucketURL  As String
'''   Dim awsURL As String
'''
'''   serverURL = "https://s3-us-west-1.amazonaws.com"
'''   bucketURL = "/ymg-karaoke/khmer/h265/4U/4U+Vol+034+-+T01.mp4"
'''
'''   awsURL = AWS.getSignedURL(serverURL & bucketURL, "GET", "", "", 0, "", bucketURL)
''''   cDownload
'''   Dim mFile As New cFile
'''   With mFile
'''      .TrackID = 9146
'''      .albumID = 433
'''      .DownloadType = DL_PURCHASEDTRACK
'''      .Language = "Khmer Karaoke"
'''      .LanguageID = 1
'''      .url = awsURL
'''      .DesFile = "C:\a.mp4"
'''   End With
'''
'''   cDownload.AddDownloadItem mFile
End Sub


Private Sub CNet_ServerFound(pIP As String, pName As String, pPort As Long)
   
   If Add_New_Server(pName, pName, pIP) Then
      sendToFlash Swf(1), "new_server", "success"
      sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
   Else
      'sendToFlash swf(1), "new_server", "fail"
   End If
   
   Debug.Print "Server found IP = " & pIP & ";Computere Name = " & pName & ";Port = " & pPort
End Sub

Private Sub EventPlayer_LoadInDVDMenu()
   If int_track_count > 0 And int_current_index > -1 Then
      If startNew And CPlayer.UrlExtension = "ifo" Then
            'xxx for 2 processors computer
            startNew = False
            PlayTrackInfo(int_current_index).MainTitle = getMainTitle
            'xxx error when maintitle bigger than 1 xx
            If CPlayer.TitleCount - 1 < getMainTitle Then
               startNew = True
               Exit Sub
            End If
            CPlayer.Volume = 0
            CPlayer.SelectTitle PlayTrackInfo(int_current_index).MainTitle
            If CurrentFind <> subTitled Then
               CurrentFind = callFuntion
            Else
               
            End If
      Else
         CPlayer.Play
         CPlayer.Volume = run_iVolumeLevel
         If CurrentFind <> subTitled Then CurrentFind = callFuntion
      End If 'ifo
   Else
   
   End If
End Sub

Private Sub EventPlayer_Played(iStatus As Integer)
   On Error GoTo Error
   
   Screen.MousePointer = vbDefault
 If CPlayer.MediaIsnothing = False Then
   If int_track_count > 0 And int_current_index > -1 Then
         CPlayer.Play
         'CPlayer.Volume = run_iVolumeLevel
         If CurrentFind <> subTitled Then CurrentFind = callFuntion
       If CPlayer.playState = wmppsWaiting And CurrentFind <> subTitled Then
           OldWMPPos = val(CPlayer.Seeks) + 2
       ElseIf CPlayer.Status = "Playing (Menu)" And Not startNew And seekTimeValue >= PlayTrackInfo(int_current_index).BookmarkLength And PlayTrackInfo(int_current_index).BookmarkLength > 1 And CurrentFind <> subTitled Then
            CPlayer.Stops
            picMovieBackground.Visible = False
            tmr.Enabled = False
       End If
    End If 'int_track_count > 0
   End If 'CWmp.url <> str_previous_track mean loaded new track
   If CPlayer.Status = "Loading media..." Or CPlayer.Status = "Locating codec server..." Then      '=== change mouse icon ====
      Screen.MousePointer = vbHourglass
      picMovieBackground.Visible = False
      CPlayer.Volume = 0
   End If
   Exit Sub
Error:
   WriteEvent "wmp_StatusChange", Err.Description, Err.Source
End Sub

Private Sub f_cSystray_MouseDown(Button As Integer)
   If cDownload.Downloading Then
      f_cSystray.BalloonText = fso.GetBaseName(cDownload.DownloadFile.DesFile)
      f_cSystray.BalloonTitle = "Media Download " & FormatPercent(cDownload.getDownloadedBytes / cDownload.getDownloadSize)
      f_cSystray.BalloonShow True, 5000
   End If
End Sub

Private Sub fb_onFeedback(pAccessToken As String, pUserID As String, pUserName As String, iStatus As Long)
   Dim p As Object
   If iStatus = 1 Then
      Debug.Print "Success ...", pUserID, pUserName, pAccessToken
      'Set p = JSON.JsonURL("http://ec2-52-88-252-123.us-west-2.compute.amazonaws.com:8080/dvdshop/api/oauth2/v1/token?access_token=" & pAccessToken & "&providerId=facebook&providerUserId=" & pUserID & "&grant_type=token&deviceId=" & fb.DeviceID & "&deviceName=" & fb.DeviceID, "POST")
      Debug.Print "Login to REST YMGuide..."
      If fb.loginBackend() Then
         Debug.Print "Login to Backend success"
         Debug.Print "Download purchased album"
         DownloadAWSPurchased
         
      End If
      'Debug.Print p.Item("name")
      

   ElseIf iStatus = 0 Then
      Debug.Print "Failed to login"
   End If
End Sub

Private Sub Form_Initialize()
   On Error Resume Next
   Dim loc_RegisterKeyType As RegisterEnum
   pull_out = False
   fileSetupType = "Both"                      'for standard and widescreen
   int_track_count = 0                         'track counts
   int_current_index = -1                      'not select any index yet for the first start
   int_nextPrevious_index = -1
   TimeStartSlyMultimedia = Now                 'Time Started
   run_Region = LoadRegion2Array(App.path & "\DVDControl.rgn")
   run_RegionFull = LoadRegion2Array(App.path & "\DVDControlFull.rgn")
   ReDim Preserve ItemDelayPlay(-1 To -1)
   ReDim Preserve EncodingQueue(-1 To -1)
   ReDim Preserve DownloadMusicQueue(-1 To -1)
   ReDim Preserve arr_redownload(-1 To -1)
   SlyVariable("<Player>") = App.path & "\Player.xml"                  ' Player XML album
   SlyVariable("<MyAlbum>") = App.path & "\MyAlbum.xml"                ' Album Available of it self
   SlyVariable("<MyAlbumServer>") = App.path & "\MyAlbumServer.xml"          ' Server My Albums
   SlyVariable("<ExternalPath>") = GetMyDocuments & "\Sly's Friends Music\"
   SlyVariable("<PlayerSend>") = App.path & "\PlayerSend.xml"
   SlyVariable("<AlbumPath>") = App.path & "\MyAlbum"
   SlyVariable("<AlbumSend>") = App.path & "\AlbumSend.xml"
   SlyVariable("<AlbumReceived>") = App.path & "\Album.xml"
   SlyVariable("<AppPath>") = App.path
   Set EventPlayer = New Player
   Set cDownload = New cIEDownload
   Set fb = New CBackend
   Set f_cSystray = New cSystray
   Call InitializeSysTray
   Call cDownload.Initialize(inetDownload)
   Set CPlayer = EventPlayer
   Set vlc = Controls.Add("VideoLan.VLCPlugin.1", "VlcControl", picMovieBackground)
   LogPath = App.path & "\log"

   EventPlayer.SetObjects wmp, vlc
   EventPlayer.TimerObject = tmrFindTime
   EventPlayer.PlayWith = WindowMedia
   EventPlayer.HidePlayerHwnd = Picture1.hwnd
   
   ''=================2015-05-09---------------add automatic server discovery
   Set CNet = New cNetwork
   CNet.InitializeSocket sckUDPClient, sckUDPServer
   CNet.ServerListen
   ''========================================================================

   
   'Creating logging folder path
   If Not fso.FolderExists(LogPath) Then
      fso.CreateFolder (LogPath)
   End If
   MainSettingXML = App.path & "\sly\setting.xml"
   hborder = (GetSystemMetrics(SM_CYCAPTION) + 6) '* Screen.TwipsPerPixelY
   wborder = (GetSystemMetrics(SM_CXEDGE) + 4)  '* Screen.TwipsPerPixelY
   loc_RegisterKeyType = GetRegisterKeyClients
   ChangeHaaliLanguage = "eng"                            'Default to english
   TurnFFDEnablesubTitle = True
   'VolNormalizeTurnOn = True
   playMusicWith = WindowMedia
   b_GetZoomLevelFromServer = True
   RefreshMonitors                  'Refresh Monitor Count     'EDIT:2006-07-31
   
   LoadBannerXML
   LoadSettingXML
   
   DeleteFile SlyVariable("<MyAlbum>")
   DeleteFile SlyVariable("<MyAlbumServer>")
   setStreamType = 3                                       'set defualt to small link
   ReadServerLink GetCDXmlPath
   SlyNickName = ComputerName & "(" & ComputerIP & ")"
   ReloadCountryFromXML                      'Reload xml current database
   
   CBrowse.boolAlbumChanged = True
   CWinsock.LoggedType = ServerMode
   Settings.i_MaxRemoteControl = DefaultMaxRemoteControl
   Settings.i_MaxClientConnect = DefaultMaxClientConnect
   
   
   'EventPlayer.PlayWith = WindowMedia
   CUserLogin.UserLoginPath = App.path & "\Sly\UserLogin.xml"
   run_stringDefaultPlayListPath = App.path & "\Sly"
   str_main_playlist_path = run_stringDefaultPlayListPath
   DragAcceptFiles hwnd, True 'accept oleDragDrop
   Form_Loads                    'Call form_loads
   Exit Sub
ErrorEncoder:
    DragAcceptFiles FrmMain.hwnd, True 'accept oleDragDrop
    If Err.Number = 429 Then b_EncoderInstalled = False Else b_EncoderInstalled = True
End Sub

Private Sub InitializeSysTray()
   With f_cSystray
      If .IsBalloonCapable Then
         .BalloonIcon = TTIconInfo
'''         .BalloonText = "Downloading 90%"
'''         .BalloonTitle = "Media Download"
      End If
      .SysTrayIconFromHandle Me.Icon.handle
      .SysTrayToolTip = "YMGuide"
      .SysTrayShow True
'''      If .IsBalloonCapable Then .BalloonShow True, 5000
   End With
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   On Error GoTo Error
    If login_name <> "" Then
        sendVariable2Flash Swf(IndexSwf), "server_sign_out", login_name & "||" & ComputerName
        Cancel = 1
    Else
        GDIPlusDispose
    End If
    If CWinsock.LoggedType <> ServerMode Then
      reinput_to_playlist
    End If
   Exit Sub
Error:
   WriteEvent "Form_QueryUnload", Err.Description, Err.Source
End Sub

Private Sub Form_Terminate()
   SendMessageLong GetDesktopWindow(), WM_SETREDRAW, True, 0
End Sub

Private Sub inetDownload_StateChanged__TMP(ByVal State As Integer)
   On Error GoTo Error
   downloadResultOk = False
   Select Case State
   Case icError
      Completed1Download
   Case icResponseCompleted
      Dim bDone As Boolean
      Dim tempArray() As Byte
      Dim vtData As String
      Dim fileNumber As Integer
      Dim Foldername As String
      Dim boolDoNotDownloadIt As Boolean
      If (inetDownload.GetHeader("Content-Length") > 807) And (boolDoNotDownloadIt = False) And (inetDownload.GetHeader("Content-Type") <> "text/html") Then
                  
         fileNumber = FreeFile
         downloadSoftData.targetPath = IIf(right(downloadSoftData.targetPath, 1) = "\", downloadSoftData.targetPath, downloadSoftData.targetPath + "\")
         CreateDirectory downloadSoftData.targetPath
         DeleteFile downloadSoftData.targetPath & downloadSoftData.targetName
         Open downloadSoftData.targetPath & downloadSoftData.targetName For Binary As fileNumber
         vtData = inetDownload.GetChunk(512, icByteArray)
         DoEvents
         If Len(vtData) = 0 Then bDone = True
         Do While (Not bDone) 'And (Not bExitingProgram)
             tempArray = vtData
             Put fileNumber, , tempArray
             vtData = inetDownload.GetChunk(512, icByteArray)
             DoEvents
             If Len(vtData) = 0 Then bDone = True
         Loop
         Close fileNumber
         downloadResultOk = True
      End If
      Completed1Download
   End Select
   Exit Sub
Error:
   WriteEvent "inetDownload_StateChanged", Err.Description, Err.Source
End Sub
Public Sub Completed1Download()
   On Error GoTo noMoreData
   DownloadFileSoft downloadIndex
   downloadIndex = downloadIndex + 1
   Exit Sub
noMoreData:
   CallByName Me, callName, VbMethod, downloadResultOk
   boolAllCompleted = True
End Sub
Sub UpdateDownloaded(bSuccess As Boolean)                    'Can't be deleted this sub routine
   On Error GoTo Error
   If bSuccess Then
      Dim updateName As String
      
      updateName = downloadSoftData.targetPath + downloadSoftData.targetName
      If isFileExist(updateName) Then
         sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Extracting..."
         Unrars updateName, downloadSoftData.targetPath
      End If
      
      updateName = Replace(updateName, ".rar", ".upd")
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Start update..."
      
      UpdateDatabase updateName
      'CBrowse.SetLastUpdate lastUpdateDate
      SetLastUpdate currentCountry, lastUpdateDate
      
      DeleteFile updateName
   End If
   sendVariable2Flash FrmMain.Swf(IndexSwf), "CompletedUpdate", "true"
   sendVariable2Flash FrmMain.Swf(IndexSwf), "OpenFrame", "true"
   Exit Sub
Error:
   WriteEvent "UpdateDownloaded", Err.Description, Err.Source
End Sub
Sub DatabaseDownloaded(bSuccess As Boolean)                    'Can't be deleted this sub routine
   On Error GoTo Error
   If bSuccess Then
      run_bUpdating = True
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Backing Up Database..."
      BackupDatabaseInfo downloadSoftData.targetPath & "\Database\", GetWinTempPath
      
      
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Extracting Database..."
      ExtractPackagedDatabase downloadSoftData.targetPath & downloadSoftData.targetName, downloadSoftData.targetPath
      
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Restoring Database..."
      RestoreDatabaseInfo downloadSoftData.targetPath & "\Database\", GetWinTempPath
      run_bUpdating = False
   End If
   sendVariable2Flash FrmMain.Swf(IndexSwf), "CompletedUpdate", "true"
   sendVariable2Flash FrmMain.Swf(IndexSwf), "OpenFrame", "true"
   Exit Sub
Error:
   WriteEvent "DatabaseDownloaded", Err.Description, Err.Source
End Sub
Sub Screens()                             'can't be deleted
   sendVariable2Flash FrmMain.Swf(IndexSwf), "CompleteDownloadScreen", "true"
   sendVariable2Flash FrmMain.Swf(IndexSwf), "OpenFrame", "true"
End Sub
Sub AdsDownloaded()                    'can't be deleted
   Debug.Print "Advertisement Downloaded"
   'MsgBox "AdsDownloaded"
End Sub
Sub Languages(bResult As Boolean)            'Can't be deleted
   On Error GoTo ErrorMax
   Dim dirName As String
   Dim languageList As String
   Dim i As Long
   For i = 0 To UBound(downloadLanguage)
      dirName = downloadLanguage(i).path + "\" + downloadLanguage(i).Name + ".rar"
      If Dir(dirName) <> "" Then
         sendToFlash Swf(1), "StringDownload", "Extracting..."
         Unrars dirName, downloadLanguage(i).path
         If languageList = "" Then
            languageList = downloadLanguage(i).Name & "||" & downloadLanguage(i).path & "||" & downloadLanguage(i).website
         Else
            languageList = languageList & "&&&" & downloadLanguage(i).Name & "||" & downloadLanguage(i).path & "||" & downloadLanguage(i).website
         End If
      End If
      DeleteFile dirName
   Next
   sendToFlash Swf(1), "DownloadCompleted", True
   If languageList <> "" Then
      FrmMain.refreshNewLanguage languageList
   End If
   Exit Sub
ErrorMax:
   sendToFlash Swf(1), "DownloadCompleted", True
End Sub
Public Sub DownloadFile(ToDirectory As String, URL1 As String)
On Error GoTo ErrorDownloading:
   With ie_Transfer
       '.RequestTimeout = 3                 'if the internet is slow it make error occur
       .url = URL1
       Debug.Print URL1, ToDirectory
       destinationDirectory = ToDirectory
      .Execute , "Get"
   
   End With
   
   Exit Sub
ErrorDownloading:
'''   Completing = True
   'WriteEvent "DownloadFile", Err.Description, Err.Source
End Sub
Private Sub ie_Transfer_StateChanged(ByVal State As Integer)
On Error GoTo ErrorDownloading:
   Dim tempSaveImage As String
   Select Case State
   Case icError
'''      Completing = True
   Case icResponseCompleted
      Dim bDone As Boolean
      Dim tempArray() As Byte
      Dim vtData As String
      Dim fileNumber As Integer
      Dim Foldername As String

      If (ie_Transfer.GetHeader("Content-Type") <> "text/html") And (ie_Transfer.GetHeader("Content-Length") > 807) Then
         Foldername = fso.GetParentFolderName(destinationDirectory)
         CreateDirectory Foldername
         
         tempSaveImage = fso.BuildPath(GetWinTempPath, "folder.jpg")
         DeleteFile tempSaveImage
         fileNumber = FreeFile
         Open tempSaveImage For Binary As fileNumber        'save to temporary folder
         vtData = ie_Transfer.GetChunk(512, icByteArray)

         If Len(vtData) = 0 Then
            bDone = True
         End If

         Do While (Not bDone) And (Not bExitingProgram)
             tempArray = vtData
             Put fileNumber, , tempArray

             vtData = ie_Transfer.GetChunk(512, icByteArray)
             
             DoEvents
             If Len(vtData) = 0 Then
                 bDone = True
             End If
         Loop
         Close fileNumber
         'check_image_metric_and_save_as_JPG destinationDirectory, destinationDirectory
         'else it will cause error while exit the soft with GDI+
         If Not bExitingProgram Then
            check_image_metric_and_save_as_JPG tempSaveImage, destinationDirectory
            CloseDownloading AlbumIDDownLoadImage, destinationDirectory, LanDownloadImage
         Else
            DeleteFile destinationDirectory
         End If
      Else
'''         Completing = True
      End If
   End Select
   Exit Sub
ErrorDownloading:
   Close fileNumber
'''   Completing = True
   WriteEvent "ie_Transfer_StateChanged", Err.Description, Err.Source
End Sub

Public Sub DownloadURLCompleted()
   Dim mDownloadType As DOWNLOADENUM
            
'''   If mDownloadType = DL_ALBUM Then
'''      check_image_metric_and_save_as_JPG tempSaveImage, destinationDirectory
'''      CloseDownloading AlbumIDDownLoadImage, destinationDirectory, LanDownloadImage
'''   ElseIf mDownloadType = DL_ARTIST Then
'''      check_image_metric_and_save_as_JPG tempSaveImage, destinationDirectory
'''      CloseDownloading AlbumIDDownLoadImage, destinationDirectory, LanDownloadImage
'''   ElseIf mDownloadType = DL_BACK Then
'''      check_image_metric_and_save_as_JPG tempSaveImage, destinationDirectory
'''      CloseDownloading AlbumIDDownLoadImage, destinationDirectory, LanDownloadImage
'''   ElseIf mDownloadType = DL_MEDIA Then
'''
'''   End If
   

End Sub
Public Sub CloseDownloading(albumID As Long, PathImage As String, Lan As String)
   On Error GoTo Error
    Dim str As String
    Dim Value As String
    str = "RefreshPicAlbum"
    Value = "true"
    
    
    'CDownload.DownloadFile.Data1
   If cDownload.DownloadFile.data1 <> "" Then
      If cDownload.DownloadFile.IndexLoadSwf = 0 And IndexSwf <> 0 Then
         sendVariable2Flash Swf(0), "SearchPathImage", cDownload.DownloadFile.data1 & "%~%" & Lan
      Else
         sendVariable2Flash Swf(IndexSwf), "SearchPathImage", cDownload.DownloadFile.data1 & "%~%" & Lan
      End If
   Else
      If cDownload.DownloadFile.IndexLoadSwf = 0 And IndexSwf <> 0 Then
            sendVariable2Flash Swf(0), str, Value
            sendVariable2Flash Swf(0), "OpenFrame", "true"
      Else
            sendVariable2Flash Swf(IndexSwf), str, Value
            sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
      End If
   End If
   changeImageAlbumPath albumID, PathImage, Lan
'''   Completing = True
   Exit Sub
Error:
   WriteEvent "CloseDownloading", Err.Description, Err.Source
End Sub
Public Sub cmdFull_Click()
    If (click_for_chage_visualization("visualization", False)) Then
        Exit Sub
    End If
    change_visualization_type
End Sub

Public Sub change_visualization_type()
   On Error GoTo Error
    's_display_type = "Image"    '2005/08/23 : Muny
    If s_display_type = "Image" Then
        s_display_type = "Visual"
        picwmp.ZOrder 0
        CPlayer.UiMode = "None"
        If (IndexSwf = 0 Or IndexSwf = 4) And DisplayMini = 1 Then
            picwmp.Visible = True
            CPlayer.Visible = True
            Resize_Visualization formWidth, formHeight
        End If

    Else
        picwmp.Visible = False
        CPlayer.Visible = False
        CPlayer.UiMode = "Invisible"
        s_display_type = "Image"
    End If

    SplitPlayer = ReplaceStrSpl(SplitPlayer, 3, s_display_type, "~")
    EditXML MainSettingXML, 2, "TypeFull", s_display_type

    Swf(IndexSwf).SetFocus
    Exit Sub
Error:
   WriteEvent "change_visualization_type", Err.Description, Err.Source
End Sub
Private Sub Form_Loads()                     'Disable form loads even because it will call this function when we've tried to use a object in the form_initialize event
   On Error GoTo Error
   Dim loc_Firstload As String
    If bExitingProgram Then Exit Sub
    click_self = True
    
    AddPort sckServer(0).LocalPort, "SlyCDGuide", True
    CWinsock.Initialize sckServer, sckClient
    xml_slideshow_path = fso.GetSpecialFolder(2) & "\slideshow.xml"
    boolSeeked = True
   'swfImagePlaying.Movie = App.path & "\Sly\PlayingImage.sly"
   LoadSwf swfImagePlaying, App.path & "\Sly\PlayingImage.sly"
      
    '========================================================================
    If Dir(App.path & "\sly\Browse.sly") <> "" Then
        frmPopup.Visible = False
        If b_loading = True Then
                Me.Visible = False
                SlySize
                SetDelimiter "&"

                
                #If debugging = 0 Then
                    oldAddress = SetWindowLong(hwnd, GWL_WNDPROC, AddressOf MyWndProc)
                #End If
                Me.Show
                If IndexSwf = 4 Then ShowOrHidePlayer True
        Else
            If App.PrevInstance Then
                End
            Else
               'EDIT:2006-08-01 Seng
               Randomize Timer
               GDIPlusCreate
               DisableRightClick
               setHook 'monitor off
               Dim mr As RECTM, fr As RECTM
               mr = MonitorRECTM(i_SlyMonitor)                   'Program display
               
               SetBorderStyle hwnd, True
               ScreenType = getScreenType(mr.Width, mr.Height, fileSetupType)

               If ScreenType = "Normal" Then                       'NS
                   fr.Width = ((410 * mr.Width) / 800)
                   fr.Height = ((312 * mr.Height) / 600)
               ElseIf ScreenType = "wideScreen" Then               'WS
                   fr.Width = ((505 * mr.Width) / 1280)
                   fr.Height = ((385 * mr.Height) / 720)
               ElseIf ScreenType = "mediumWideScreen" Then         'WSM
                   fr.Width = ((524 * mr.Width) / 1280)
                   fr.Height = ((399 * mr.Height) / 768)
               ElseIf ScreenType = "mediumLargeWideScreen" Then    'WSH
                   fr.Width = ((546 * mr.Width) / 1280)
                   fr.Height = ((416 * mr.Height) / 800)
               ElseIf ScreenType = "smallWideScreen" Then          'WSS
                   fr.Width = ((410 * mr.Width) / 1024)
                   fr.Height = ((312 * mr.Height) / 600)
               ElseIf ScreenType = "largeWideScreen" Then          'WSL
                   fr.Width = ((436 * mr.Width) / 800)
                   fr.Height = ((332 * mr.Height) / 640)
               End If

               ResizeFormPixel hwnd, fr.Width, fr.Height
               MoveForm2Monitor i_SlyMonitor, hwnd, (mr.Width - fr.Width) / 2, (mr.Height - fr.Height) / 2
               formWidth = Me.Width
               formHeight = Me.Height
               SlyRegedit.SetKeyValue HKEY_CURRENT_USER, StrRegKey, "MetadataRetrieval", 0, REG_DWORD
               'make subttle to default
               SlyRegedit.SetKeyValue HKEY_CURRENT_USER, StrRegKey, "Subtitle_LCID", &HFFFFFFFE, REG_DWORD
                
               If IsRegistered = False Then
                   run_ShowLoading = True
                   Load Swf(12)
                   ReloadFlash "Loading.sly", Swf(12), 12
               Else
               End If
               Me.Hide
               Load Swf(1)
                  
               ReloadFlash "Country.sly", Swf(1), 1
               sendVariable2Flash Swf(1), "Website", ServerAdsScreen.website
               sendVariable2Flash Swf(1), "ReLoad", "true"
               sendVariable2Flash Swf(1), "sly_nick_name", ComputerName
               sendToFlash Swf(1), "OpenXml", App.path & "\sly"
                
                If IsRegistered Then
                     #If Server = 1 Then
                        CWinsock.Listen
                     #End If
                    loc_Firstload = GetAttSetting(0, "FirstLoad")
                    b_reg = True
                    swf_FSCommand 1, "Starting", "true"
                    If Settings.b_ShowFormVideo And MonitorCount > 1 Then
                       frmVideo.Show                    'For registered user only
                       DoEvents
                    End If
                    'while done
                    If loc_Firstload = "FullScreen" Then
                        Call click_for_chage_visualization("fullscreen_visual", False)
                        DoEvents
                        scale_visualization_to_fullscreen (bool_full_vis)
                     End If
                     If b_AutoConnect Then
                        Dim LastServerName As String
                        Dim LastUserOnline As String
                        LastServerName = GetAttSetting(0, "LastServerName")
                        LastUserOnline = GetAttSetting(0, "LastUserOnline")
                        If i_AutoConnected > 0 And LastServerName <> "" Then
                           run_bRequestConnecting = True
                           swf_FSCommand 1, "login", LastServerName & "|~|" & LastUserOnline & "|~|" & ""
                        End If
                     End If
                Else
                    Me.Show
                    b_reg = True
                    sendVariable2Flash Swf(12), "strRegister", "false"
                    sendVariable2Flash Swf(12), "openRegister", "true"
                End If
                
            End If
        End If
    Else
        End
    End If
    Exit Sub
Error:
   WriteEvent "Form_Loads", Err.Description, Err.Source
End Sub

Public Sub Form_Paint()
   'Remove pait events from form_paint          'EDIT:2006-08-01 Seng
   On Error GoTo ErrorSubScript
   If bool_full_vis = False Then
      'EDIT:2006-08-15
      If run_ShowLoading = False Then      'When show loaidng don't resize it
      
         If FirstLoad = False Then
            SlySize
            FirstLoad = True
            tmpWidth = ScreenX
            tmpHeight = ScreenY
            If tmpchangeWindow = True Then
                tmpchangeWindow = False
            End If
         ElseIf tmpWidth <> ScreenX Then
            Dim tmpScreen As String
            tmpScreen = ScreenType
            SlySize
            tmpWidth = ScreenX
            tmpHeight = ScreenY
         End If
         Swf(IndexSwf).Move 0, 0, formWidth, formHeight
         ResizePlayer
      End If
   End If
   Exit Sub
ErrorSubScript:
   'WriteEvent "Form_Paint", Err.Description, Err.Source
End Sub

Private Sub Form_Resize()
   On Error GoTo Error
   If One = False Then
        'Form_Paint
   End If
   Picture1.left = Me.left + Me.Width + 100 'hide this picture
   Picture1.top = Me.Height + Me.top + 100
   Exit Sub
Error:
   WriteEvent "Form_Resize", Err.Description, Err.Source
End Sub

Private Sub Form_Unload(Cancel As Integer)
   On Error GoTo Error
   killInternetTemp
   If b_mute = True Then WaveVolume = WaveVolume
   EditXML MainSettingXML, 2, "Vol", CStr(WaveVolume)
   EditXML MainSettingXML, 0, "online", "false"
   EditXML MainSettingXML, 0, "del", "false"
   AddPort sckServer(0).LocalPort, "SlyCDGuide", False
    'clear all unhook
      unHook
      SetWindowLong hwnd, GWL_WNDPROC, oldAddress
      EnableRightClick
    'end clear unhook
   SavePlayMusicPlayer     'Save music file before the player exit
   SaveSettingXML
   bExitingProgram = True               'Make downloading coverart stops
   
   If CWinsock.LoggedType <> ServerMode Then reinput_to_playlist

   Set CPlayer = Nothing
   Unload frmPopup
   Unload frmPopupBrowse
   Unload frmOver
   Unload frmSlideShow
   Unload frmRip
   Unload frmScan
   Unload frmVideo
   Unload Me
   'Unload Controls("VlcControl")
   
   Exit Sub
Error:
   WriteEvent "Form_Unload", Err.Description, Err.Source
   'must unload all form otherwise it stills running
    'End       'error while debugging=0
End Sub

Private Sub MediaPlayer_CurrentItemChange(TrackIndex As Long)
   If CWinsock.LoggedType <> cloneDisplay And CWinsock.LoggedType <> remotePlaylist Then
      check_track_to_play_after_finish_one_track_with_winamp
      
   End If
      On Error Resume Next
      If Infos(int_current_index).TrackID <> "" And Infos(int_current_index).trackExternal = False Then
         If b_addPlayCount = False Then
            b_addPlayCount = True
            setPlayCount CLng(Infos(int_current_index).TrackID), Infos(int_current_index).TrackLan, CInt(int_current_index)
            
            If ((CWinsock.LoggedType = ServerMode) Or (CWinsock.LoggedType = independentMode)) Then
                'check track ava in database...........
                CheckTrackAvaible int_current_index + 1
                refreshPlaylistPlayer True
            End If
            
         End If
      End If
End Sub



Private Sub picMovieBackground_DblClick()
   On Error GoTo Error
   If str_swfNames = "Micro" Then
        handleMinicommand "Micro2Normal|:|true"
   Else
      If bool_full_vis Then
         'scale_visualization_to_fullscreen True
         handleMinicommand "FullScreen|:|false"
      Else
         handleMinicommand "FullScreen|:|true"
      End If
   End If
   Exit Sub
Error:
   WriteEvent "picMovieBackground_DblClick", Err.Description, Err.Source
End Sub

Private Sub picMovieBackground_GotFocus()
   On Error GoTo Error
'''   On Error Resume Next
   If GetActiveWindow = hwnd Then                        'don't let it set focus while it's not activated
      If run_bShowingInputCode Then
         'swfAddTrack.SetFocus
         LoadSwfAddTrack
      ElseIf swfMiniControl.Visible Then
         swfMiniControl.SetFocus       'setfocus to swfMiniControl
      ElseIf swfDVDControl.Visible Then
         swfDVDControl.SetFocus        'setfocus to swfDVDControl
      ElseIf str_swfNames = "Micro" Then
         SWF_FMA(2).SetFocus
      ElseIf bool_full_vis = False Then
         Swf(IndexSwf).SetFocus        'otherwise it cannot get focus while pression tab key
      End If
   End If
   Exit Sub
Error:
   WriteEvent "picMovieBackground_GotFocus", Err.Description, Err.Source
End Sub

Private Sub picMovieBackground_KeyPress(KeyAscii As Integer)
   On Error GoTo Error
   If str_swfNames <> "Micro" And bool_full_vis Then
      Select Case KeyAscii
         Case vbKeyBack
            handleMinicommand "FullScreen|:|true"
         Case vbKeySpace
            If CWinsock.LoggedType <> remoteControl Then LoadSwfDvdControl
      End Select
   End If
   Exit Sub
Error:
   WriteEvent "picMovieBackground_KeyPress ", Err.Description, Err.Source
End Sub

Private Sub picMovieBackground_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
   On Error GoTo Error
   If str_swfNames = "Micro" Then
      SWF_FMA_FSCommand 2, "MoveMicro", ""
   Else
'      Else
         If (Not (run_FormVideoLoaded)) Then
            If bool_full_vis And (CWinsock.LoggedType <> remoteControl) Then
               run_TimeHideMouse = 0                            'don't make t hide the mouse
               If swfDVDControl.Visible = False Then
                  LoadSwfDvdControl              'Show dvd control
               Else
                  b_ShowControlInPlayer = Not b_ShowControlInPlayer
                  noHideDVDControl
                  ShowHideDVDControl b_ShowControlInPlayer, run_DVDScalePercent, (Settings.setDisplayDvdContol = "0")
               End If
            End If
         End If
'      End If
   End If
   Exit Sub
Error:
   WriteEvent "picMovieBackground_MouseDown", Err.Description, Err.Source
End Sub

Private Sub picMovieBackground_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
   On Error GoTo Error
   Dim getMousePo As POINTAPI
   GetCursorPos getMousePo
   If MousePosition.x <> getMousePo.x And MousePosition.Y <> getMousePo.Y Then
      If bool_full_vis Then

         If str_swfNames <> "Micro" Then   '2005/08/24 : Muny
            run_TimeHideMouse = 0                            'don't make t hide the mouse
            If Not swfDVDControl.Visible Then LoadSwfDvdControl
         End If
      Else
         If show_hide_player Then       'Only show when form main is active
            If Not swfMiniControl.Visible And str_swfNames <> "Micro" And str_swfNames <> "Fullscreen" Then LoadSwfMiniControl
         End If
      End If
      
  
  End If
   noHideDVDControl
   If str_swfNames = "Fullscreen" Then
      sendToFlash SWF_FMA(1), "showVis", CStr(True)
      sendToFlash SWF_FMA(1), "showMouse", CStr(True)
   ElseIf str_swfNames = "Micro" Then
      'cmd_max.Visible = True
      boolLooping = True
      'ShowControlPopup
      'If Me.top + Me.Height > Screen.Height Then Me.top = Screen.Height - Me.Height
      frmOver.showMe
      If frmOver.Visible Then frmOver.SetFocus
   End If
   If CPlayer.IsInMenuMode Then           'if in menu mode and not finished
      'for dvd double click doesn't goto fullscreen(CWmp itself)
      picMovieBackground.Enabled = True            'allow it to click item in root menu
      If run_FormVideoLoaded Then         'Another form is showed
         frmVideo.picVideo.Enabled = True
      End If
   Else
      picMovieBackground.Enabled = False
      If run_FormVideoLoaded Then         'Another form is showed
         frmVideo.picVideo.Enabled = False
      End If
      'DisableWindowMediaVideo picwmp.hwnd, False
   End If
   Exit Sub
Error:
   WriteEvent "picMovieBackground_MouseMove", Err.Description, Err.Source
End Sub
Public Sub HideControlPupup()
On Error GoTo Error
   run_bShowControl = False
   If str_swfNames = "Micro" Then
      If bPopupControlShowed = True Then
         With FrmMain
         Dim a As Long
          a = picwmp.top
            picwmp.top = 0
            
            .Height = .picwmp.Height
            .top = .top + a '.picwmp.top
            'picwmp.top = 0
            SWF_FMA(2).top = Me.Height
            '.ZOrder 0
         End With
      End If
   End If
   bPopupControlShowed = False
   Exit Sub
Error:
   WriteEvent "HideControlPupup", Err.Description, Err.Source
End Sub
Public Sub ShowControlPopup()   'In micro
   On Error GoTo Error
   Dim controlWidth As Long
   Dim controlHeight As Long
   Dim controlScale As Single
   Dim iMicroY As Long
   Dim iPicsY As Long
   If bPopupControlShowed = True Then Exit Sub
   controlWidth = GetFlashVar(SWF_FMA(2), "StageWidth")
   controlHeight = GetFlashVar(SWF_FMA(2), "StageHeight")
   controlScale = ScaleX(FrmMain.Width, vbTwips, vbPixels) / controlWidth
   controlWidth = FrmMain.Width
   controlHeight = ScaleY(controlHeight * controlScale, vbPixels, vbTwips)
   run_bShowControl = True
   
   If FrmMain.top + picwmp.Height + controlHeight > Screen.Height Then
      'Move Control to the top of the screen
      iMicroY = 0
      iPicsY = controlHeight
   Else
      'Move Control to the bottom of the screen
      iMicroY = picwmp.Height
      iPicsY = 0
   End If
   
  SWF_FMA(2).Move 0, iMicroY, controlWidth, controlHeight
   picwmp.Move 0, iPicsY
   FrmMain.Move FrmMain.left, FrmMain.top - iPicsY, FrmMain.Width, picwmp.Height + controlHeight
'   picwmp.Move 0, iPicsY
'   SWF_FMA(2).Move 0, iMicroY, controlWidth, controlHeight
   
   SWF_FMA(2).Visible = True
   bPopupControlShowed = True
   Exit Sub
Error:
   WriteEvent "ShowControlPopup", Err.Description, Err.Source
End Sub

Private Sub picwmp_DblClick()
   picMovieBackground_DblClick
End Sub

Private Sub picwmp_GotFocus()
   picMovieBackground_GotFocus
End Sub

Private Sub picwmp_KeyPress(KeyAscii As Integer)
   picMovieBackground_KeyPress KeyAscii             'send keypress to picmoviebackground
End Sub

Private Sub picwmp_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
   If Button = 1 Then
      picMovieBackground_MouseDown Button, Shift, x, Y
   ElseIf Button = 2 Then
      'rightClickPicWMP
   End If
End Sub

Private Sub picwmp_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
   Static oldX As Single, oldY As Single
   'Due to Windows 7 system even there is no mouse move event, but still sending the mouse move
   If (oldX <> x Or oldY <> Y) Then picMovieBackground_MouseMove Button, Shift, x, Y
   
   oldX = x: oldY = Y
End Sub

Private Sub sckClient_Close()
   On Error GoTo Error
   If sckClient.State = sckConnected Then
       sckClient.Close
   End If
   run_bRequestConnecting = False
   If Not CWinsock.LoggedAs(independentServer) Then
      DeleteFile SlyVariable("<MyAlbumServer>")
   Else
      CBrowse.RemoveClientAvailable CWinsock.serverID
   End If
   If CWinsock.LoggedAs(remoteControl) And show_hide_player Then
      picwmp.Visible = True
      If bool_full_vis Then
         UnloadSwfDvdControl
      Else
        UnloadSwfMiniControl
      End If
   Else
     'refresh browse
     If lastBrowseBy <> "" And IndexSwf = 0 Then swf_FSCommand 0, "BrowseAlbumBy", lastBrowseBy
   End If
   login_name = ""
   CWinsock.LoggedType = ServerMode
   CWinsock.serverID = ""
   CreateMyAlbumXml SlyNickName
   RefreshAlbumAvailableToServer
   sendToFlash Swf(IndexSwf), "not_connected", "true"
   sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
   If IndexSwf = 0 Then
      sendToFlash Swf(0), "clientType", CWinsock.LoggedType
      sendToFlash Swf(0), "not_connected", "true"
   End If
   
   'reinput_to_playlist
   ReDim EncodingQueue(-1 To -1)         ' clear download queue
   check_status
   user_sign_in_index = ""
   If str_swfNames = "Micro" Then MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height, False   'Refresh Micro
   Exit Sub
Error:
   WriteEvent "sckClient_Close", Err.Description, Err.Source
End Sub

Sub reinput_to_playlist()
   On Error GoTo Error
   Dim i As Long
   Dim found_track As Long
   Dim intTrackAvailable As Integer
   Dim PlayIndex As Long
   Dim removePlayingTrack As Boolean
   
   
   str_main_playlist_path = run_stringDefaultPlayListPath        ' restore back playlist path        ' 2006-04-26 Seng

   For i = 0 To int_track_count - 1
      intTrackAvailable = val(PlayTrackInfo(i).TrackAva)
      If (intTrackAvailable <> 1 And CWinsock.getIndexServer(PlayTrackInfo(i).comName) < 0) Or PlayTrackInfo(i).infoNotFilled Then
         If (i = int_current_index) Then removePlayingTrack = True
      Else
   '      If TrackAvailable <> 0 And CWinsock.getIndexServer(PlayTrackInfo(i).comName) < 0 Then
         found_track = found_track + 1
         PlayTrackInfo(i).infoNotFilled = False                      'refresh from server then track is not requested
         PlayTrackInfo(found_track - 1) = PlayTrackInfo(i)
         If (i = int_current_index) Then
            int_current_index = found_track - 1
            removePlayingTrack = False
         End If
         Infos(found_track - 1) = Infos(i)
      End If
   Next i
   If found_track > 0 Then
      ReDim Preserve PlayTrackInfo(found_track - 1)
      ReDim Preserve Infos(found_track - 1)
      If removePlayingTrack Then int_current_index = 0
   Else
      Erase PlayTrackInfo
      Erase Infos
      int_current_index = -1
   End If
   int_track_count = found_track
   If (removePlayingTrack Or b_play = False) And Not bExitingProgram Then
       miniCommand "Stop" & "|:|" & True
       miniCommand "Play" & "|:|" & True
      SendRefreshTrack2Clients
   End If
   If IndexSwf = 4 Then
      sendToFlash Swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
   End If
   Exit Sub
Error:
   WriteEvent "reinput_to_playlist", Err.Description, Err.Source
End Sub


Private Sub sckClient_Connect()
   CWinsock.Send2Server WS_COMMAND, "request_login_type&&&" & num_display & "&&&" & user_sign_in_index & "&&&" & b_got_permission & "&&&" & login_name & "&&&" & CWinsock.connectName & "&&&" & store_user_login_pass & "&&&" & b_acces_pass & "&&&"
End Sub

Sub ReceivedClient(dataCommand As WinsockDownloadEnum, dataReceived As String)
   'this sub procedure is received the events from server
   On Error GoTo ErrorHandler
   Dim temp_array() As String
   Dim tspl() As String
   Dim readCommand() As String
   Dim XmlDoc As New DOMDocument
   Dim readTracks As Tracks
   Dim i As Long
   Dim xmlnode As IXMLDOMElement
   Dim flashCommand() As String
   Dim FileExtension As String
   Dim variableStored As String
   Dim variableReturn As String
   Dim iInteValue As Integer

   'Debug.Print dataReceived
   If dataCommand = WS_COMMAND Or dataCommand = WS_REQUESTING Then
      readCommand = Split(dataReceived, de_Record)          'index >0 parameter
      Select Case readCommand(0)
         Case "Minicommand"
            'miniCommand readCommand(1), True
            miniCommand readCommand(1), ServerMode
         Case "SendPlayState"       'remote control mode
            If CWinsock.LoggedType = remoteControl Then
               run_PlayState = val(readCommand(1))
               ShowPlayState2Flash (run_PlayState = 1)   'Play state
            End If
         Case "StartConvert"
            RemoveEncodeitemQueue 0
            StartConvert
         Case "ServerAlbumRefresh"
            CBrowse.AddClientAvailable SlyVariable("<AlbumPath>") & "ServerGet.xml"
            If CWinsock.LoggedAs(independentServer) Then
               CWinsock.Send2Client WS_COMMAND, 0, "refreshClientAlbum&&&"
               'CWinsock.SendCopy WS_COPYTO, 0, SlyVariable("<MyAlbumServer>") & FileDelimiter & "<AlbumPath>" & CWinsock.clientIndex & ".xml" & FileDelimiter & "AlbumFromClient"
            End If
         Case "responseZoomLevel"                                 '2006-10-05 Seng                          Make changes to zoom level
            If int_track_count > 0 And int_current_index < int_track_count And int_current_index >= 0 Then
               If PlayTrackInfo(int_current_index).TrackID = readCommand(1) And PlayTrackInfo(int_current_index).Language = readCommand(2) Then
                  'if ScreenType
                  ';getScreenType
'                  GetMonitorRect
                  iInteValue = GetMonitorType(i_VideoMonitor)
                  If iInteValue = MonitorWide16x09 Then
                     PlayTrackInfo(int_current_index).ZoomLevel = val(readCommand(3))
                  ElseIf iInteValue = MonitorWide16x10 Then
                     PlayTrackInfo(int_current_index).ZoomLevel = val(readCommand(3))
                  Else                          'If Interaction = MonitorStandard Then
                     PlayTrackInfo(int_current_index).ZoomLevel = 2                             'Just increase 2 pixels if Standard
                  End If
               Else
                  Debug.Print "Response invalid zomlevel"
               End If
            End If
         Case "ResponseUpdateDatabase"                      'CountryName,database's network path
            sendToFlash Swf(IndexSwf), "UpdateDatabaseFromServer", readCommand(1) & "|%|" & readCommand(2)
            'DownloadLocalNetwork readCommand(1), readCommand(2)
         Case "ResponseIsFirstClient"
            Debug.Print "Received from server to enable or disable"
            'return ResponseIsFirstClient,Count,True/False
            sendToFlash Swf(IndexSwf), "isFirstClient", readCommand(1) & "|%|" & LCase(readCommand(2))
         Case "refreshClientAlbum"
            CWinsock.SendCopy WS_COPYFROM, 0, SlyVariable("<AlbumPath>") & "ServerGet.xml" & FileDelimiter & "<MyAlbumServer>" & FileDelimiter & "ServerAlbumRefresh&&&"
         Case "requestCopyFile"
            readCommand(1) = getQueryString(readCommand(1))
            If fso.GetExtensionName(readCommand(2)) = "" Or Len(fso.GetExtensionName(readCommand(2))) > 4 Then readCommand(2) = fso.BuildPath(readCommand(2), fso.GetFileName(readCommand(1)))
            FileExtension = LCase(fso.GetExtensionName(readCommand(1)))
            If (FileExtension = "mp3" Or FileExtension = "wma") And isFileExist(readCommand(1)) And CBool(readCommand(3)) And b_EncoderInstalled Then
               'Save file to temp folder
               variableStored = GetWinTempPath & "Download" & 0 & ".wma"       'Save converted file to this path
               AddEncodeItemQueue CWinsock.serverID, CWinsock.serverName, variableStored & "&&&" & ChangeFileExtension(readCommand(2), "wma"), readCommand(1), variableStored
            Else
               '1 = From ,2= To
               CWinsock.Send2Server WS_COMMAND, "StartCopy&&&" & readCommand(1) & "&&&" & readCommand(2)
            End If
         Case "SetClientRating"
            If CWinsock.LoggedType = cloneDisplay Or CWinsock.LoggedType = remotePlaylist Then
               If int_track_count > readCommand(1) Then
                  If Infos(readCommand(1)).TrackID = readCommand(2) Then
                     setPlayCount readCommand(2), Infos(readCommand(1)).TrackLan, readCommand(1)
                  End If
               End If
            End If
         Case "StartCopy"
            DownloadingMusic.ToTrackPath = readCommand(2)
            DownloadingMusic.FromTrackPath = readCommand(1)
            CWinsock.SendCopy WS_COPYFROM, 0, DownloadingMusic.ToTrackPath & FileDelimiter & DownloadingMusic.FromTrackPath & FileDelimiter & "DownloadSongCompleted"
         Case "changeDownloadInfo"
            DownloadingMusic.ToTrackPath = readCommand(1)
         Case "responseAlbumAvailable"
            'CallFlashFunction swf(IndexSwf), "changeAlbumAvailable", readCommand(1)
         Case "responseAlbumBar"
            XmlDoc.Load SlyVariable("<Player>")
            If XmlDoc.parseError.errorCode = 0 Then
               If IndexSwf = 4 Then
                  sendVariable2Flash Swf(4), "GetAllTracks", XmlDoc.xml
                  sendVariable2Flash Swf(4), "OpenFrame", "true"
               End If
            End If
            boolRequestingTrack = False
         Case "requestTrackPath"
            variableStored = readCommand(1) & "&&&" & GetNetworkPath(getMoviePathAndSample(readCommand(1), , iInteValue))
            CWinsock.Send2Server WS_COMMAND, "responseTrackPath&&&" & variableStored & "&&&" & iInteValue
         Case "requestStreamPath"
            iInteValue = val(readCommand(4))
                                             'AlbumID       'TrackID
            variableStored = GetStreamPath(readCommand(1), readCommand(2), readCommand(3), iInteValue)
            'return back with path available
                                                                        ' AlbumID                  TrackID                 Language                   PlayFrom                       Path
            CWinsock.Send2Server WS_COMMAND, "responseStreamPath&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3) & "&&&" & iInteValue & "&&&" & GetNetworkPath(variableStored)
         Case "responseStreamPath"
            'If UBound(readCommand) > 2 Then
               'Client--->server-->server                   server->cleint->clent
               'CWinsock.Send2Client WS_COMMAND, val(readCommand(3)), "responseStreamPath&&&" & readCommand(1) & "&&&" & readCommand(2)
            'Else
                                                                        ' AlbumID                  TrackID                 Language                   PlayFrom                       Path
               ChangeAllStreamPath readCommand(1), readCommand(2), readCommand(3), readCommand(4), readCommand(5)
            'End If
         Case "responseTrackPath"
            If UBound(readCommand) > 3 Then
               'Client--->server-->server                   server->cleint->clent
               CWinsock.Send2Client WS_COMMAND, val(readCommand(4)), "responseTrackPath&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3)
            Else
               PlayFileFromRemoteMachine readCommand(1), readCommand(2), val(readCommand(3)), CWinsock.serverID
            End If
         Case "responseLogin"
            If UBound(readCommand) = 4 Then    'EDIT:2006-08-31
               CWinsock.Send2Client WS_COMMAND, val(readCommand(4)), readCommand(0) & "&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3)
                                                   'Index            responseLogin              True/False              name:::password        LinkingPath(NetworkPath)
                  '                                                      0                          1                       2                          3
            Else
'''               Debug.Print "Success Login.................= " & readCommand(1)
               If readCommand(1) = "True" Then
                  temp_array = Split(readCommand(2), ":::")    'Name/Password
                  'add playlist to it self
                  login_name = temp_array(0)
                  AddNewPath str_main_playlist_path, fso.BuildPath(readCommand(3), login_name), temp_array(0)
                  sendVariable2Flash Swf(1), "login_name", login_name
               Else
                  login_name = ""
                  sendVariable2Flash Swf(1), "login_name", ""
                  'CWinsock.LoginInName = ""
               End If
               sendVariable2Flash Swf(1), "loginStatus", readCommand(1)
               
            End If
         Case "responseSignup"
            If UBound(readCommand) = 2 Then      'EDIT:2006-08-31
               CWinsock.Send2Client WS_COMMAND, val(readCommand(2)), readCommand(0) & "&&&" & readCommand(1)
            Else
               sendVariable2Flash Swf(1), "loginStatus", readCommand(1)
            End If

         Case "responseBrowseAlbums"
            sendVariable2Flash Swf(0), "ShowAlbumPic", readCommand(1)
            sendVariable2Flash Swf(0), "ResultAlbumName", readCommand(2)
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         Case "requestSeek"
            'CWinsock.Send2Server WS_COMMAND, "setSeekTime&&&" & getCurrentDuration & "&&&" & getPlayState
            CWinsock.Send2Server WS_COMMAND, "setSeekTime&&&" & CPlayer.Seeks & "&&&" & getPlayState
         Case "refreshTrackAvailable"
            CallFlashFunction Swf(0), "changeAvailable", readCommand(1), CWinsock.serverID
         Case "requestTrackAvailable"
            variableStored = CBrowse.getTrackAvailables(readCommand(1), readCommand(2), variableReturn)
'''            If variableStored <> "" Then
'''               CWinsock.Send2Server WS_COMMAND, "responseTrackAvailable&&&" & variableStored & "&&&" & SlyNickName
'''            End If
'''            If variableReturn <> "" Then
'''               If CWinsock.LoggedAs(independentServer) Then          ' Send to all client to get track availables
'''                  CWinsock.Send2Client WS_COMMAND, 0, dataReceived
'''               End If
'''            End If
            CWinsock.Send2Server WS_COMMAND, "responseTrackAvailable&&&" & variableStored & "&&&" & SlyNickName
         Case "responseTrackAvailable"
            If UBound(readCommand) > 2 Then
               If CWinsock.LoggedAs(independentServer) Then
                  CWinsock.Send2Client WS_COMMAND, val(readCommand(3)), "responseTrackAvailable&&&" & readCommand(1) & "&&&" & readCommand(2)
               End If
            Else
               'CallFlashFunction swf(IndexSwf), "changeAvailable", readCommand(1), CWinsock.serverID
               CallFlashFunction Swf(IndexSwf), "changeAvailable", readCommand(1), readCommand(2)
            End If
         Case "responseBrowsingAlbum"
            XmlDoc.Load SlyVariable("<AlbumReceived>")
            If XmlDoc.parseError.errorCode = 0 Then
               Set CBrowse.collectionSelectList = New Collection
               If XmlDoc.parseError.errorCode = 0 Then
                  For i = 0 To XmlDoc.firstChild.childNodes.Length - 1
                     Set xmlnode = XmlDoc.firstChild.childNodes(i)
                     CBrowse.AddID CBrowse.collectionSelectList, xmlnode.getAttribute("ID"), xmlnode.getAttribute("ID")
                  Next
                  i = CBrowse.SelectAlbumsFromList
               End If
                  sendVariable2Flash Swf(0), "StoreReloadGroup", readCommand(2) & "&&&" & readCommand(3)
                  sendVariable2Flash Swf(0), "ArtistLength", i
                  sendVariable2Flash Swf(0), readCommand(1), IIf(i > 0, "Yes", "Non")
                  sendVariable2Flash Swf(0), "OpenFrame", "true"
            End If
            
         Case "responseAlbum"
            If CWinsock.LoggedType = cloneDisplay Then
               XmlDoc.Load SlyVariable("<AlbumReceived>")
               If XmlDoc.parseError.errorCode = 0 Then
                  Set CBrowse.collectionSelectList = New Collection
                  For i = 0 To XmlDoc.firstChild.childNodes.Length - 1
                     Set xmlnode = XmlDoc.firstChild.childNodes(i)
                     CBrowse.AddID CBrowse.collectionSelectList, xmlnode.getAttribute("ID"), xmlnode.getAttribute("ID")
                  Next
                  CBrowse.SelectAlbumsFromList
               End If

            Else                'If CWinsock.LoggedType = independentMode Then
               CBrowse.combineAvailable readCommand(2), currentCountry
               CBrowse.SelectAlbumsFromList True, -2
            End If
            SendAlbum2Swf CBrowse.collectionSelectList.count, "GetMyAlbum&&&" & readCommand(1)
         Case "responseTrackInfo"
            XmlDoc.loadXML readCommand(1)
            If XmlDoc.parseError.errorCode = 0 Then
               If XmlDoc.firstChild.Attributes.Length > 0 Then
                  readTracks = SaveToArray(XmlDoc.firstChild)
                  PlayFileViaXML readTracks, readTracks.TrackIndex
                  get_track_info False
                  CWinsock.Send2Server WS_COMMAND, "other&&&requestTrackIndex"
               End If
            Else
               'Retry sending request again..........
               CWinsock.Send2Server WS_COMMAND, "requestTrackInfo&&&" & int_current_index & "&&&" & 0
            End If
         Case "responseTrackInfoForDownload"
            XmlDoc.loadXML readCommand(1)
            If XmlDoc.parseError.errorCode = 0 Then
               readTracks = SaveToArray(XmlDoc.firstChild)
               PlayFileViaXML readTracks, readTracks.TrackIndex
               PlayTrackFromIndex readTracks.TrackIndex
               '''''''''''CWinsock.Send2Server WS_COMMAND, "other&&&requestTrackIndex"
            End If
         Case "responseSavePlayerTrack"
            XmlDoc.Load SlyVariable("<Player>")
            If XmlDoc.parseError.errorCode = 0 Then
               Set xmlnode = XmlDoc.firstChild
               For i = 0 To xmlnode.childNodes.Length - 1
                  readTracks = SaveToArray(xmlnode.childNodes.item(i))
                  PlayFileViaXML readTracks, readTracks.TrackIndex
               Next
               SavePlaylistPlayer readCommand(1)
            End If
            boolRequestingTrack = False
         Case "responseNextPrev"
            XmlDoc.Load SlyVariable("<AppPath>") & "\PlayerInfo.xml"
            If XmlDoc.parseError.errorCode = 0 Then
               Set xmlnode = XmlDoc.firstChild
               For i = 0 To xmlnode.childNodes.Length - 1
                  If xmlnode.childNodes.item(i).Attributes.Length > 0 Then
                     'prevent from there is no data
                     readTracks = SaveToArray(xmlnode.childNodes.item(i))
                     PlayFileViaXML readTracks, readTracks.TrackIndex
                  End If
               Next
            End If
            boolRequestingNexPrev = False
            get_track_info
         Case "responseTrackInfos"
            XmlDoc.Load SlyVariable("<Player>")
            If XmlDoc.parseError.errorCode = 0 Then
               Set xmlnode = XmlDoc.firstChild
               For i = 0 To xmlnode.childNodes.Length - 1
                  readTracks = SaveToArray(xmlnode.childNodes.item(i))
                  PlayFileViaXML readTracks, readTracks.TrackIndex
               Next
               SendTrack2Player xmlnode.getAttribute("StartIndex"), xmlnode.getAttribute("TrackCount")
            End If
            boolRequestingTrack = False
         Case "DownloadSongCompleted"
            'For DVD Don't try to download file coz it is DVD(Over 2GB)
''            If isFileExist(DownloadingMusic.ToTrackPath) Then
''               Call CopyCompleted(DownloadingMusic.language, DownloadingMusic.TrackID, DownloadingMusic.ToTrackPath)
''               CWinsock.RemoveDownloadingMusic False
''               If int_current_index < int_track_count And int_current_index >= 0 Then
''                  If DownloadingMusic.TrackID = Infos(int_current_index).TrackID And DownloadingMusic.language = Infos(int_current_index).TrackLan Then
''                     b_play = False
''                     miniCommand "Play|:|true"
''                     CWinsock.Send2Server WS_COMMAND, "other&&&requestSeek"
''                  End If
''               End If
''            End If
''            CWinsock.Send2Server WS_COMMAND, "StartConvert"
''            CopyingSong = False
''            CWinsock.StartDownloadItem False
         Case "server"
            If CWinsock.LoggedType <> independentMode Then
               Dim flashIndex() As String
               Dim sendFlashIndex As Integer
               Dim j As Integer
               flashCommand = Split(readCommand(2), de_Field)
               flashIndex = Split(readCommand(1), ";")
               Select Case flashIndex(0)
               Case "IndexList"
                  For j = 1 To UBound(flashIndex)
                     sendFlashIndex = flashIndex(j)
                     If sendFlashIndex = IndexSwf Or sendFlashIndex = 0 Then sendToFlash Swf(sendFlashIndex), flashCommand(0), flashCommand(1)
                  Next
                  sendFlashIndex = IndexSwf
               Case Else
                  If flashIndex(0) = "IndexSwf" Then sendFlashIndex = IndexSwf Else sendFlashIndex = CInt(flashIndex(0))
                  If sendFlashIndex = IndexSwf Then sendToFlash Swf(sendFlashIndex), flashCommand(0), flashCommand(1)
               End Select
            End If
         Case "setFakeTime"
            If UBound(readCommand) = 3 Then
               run_FakeSeekTime = val(readCommand(1))
               'run_FakeTime = val(readCommand(1))
               run_FakeSeekMax = val(readCommand(2))
               stopFakeTime = False
               run_PlayState = val(readCommand(3))
               If CWinsock.LoggedType = remoteControl Then
                  ShowPlayState2Flash (run_PlayState = 1)
                  If bool_full_vis Then popUp
               Else
                  'EDIT:2006-08-15
                  'When in independent mode don't display popup when sending from server
                  If Not CWinsock.LoggedAs(independentMode) Then
                    popUp Settings.b_ShowPopupInfo
                  End If
               End If
            End If
         Case "setSeekTime"
            If Not CWinsock.LoggedAs(independentMode) Then
               seekWidth = readCommand(1)
               If UBound(readCommand) > 3 Then
                  '3 lenghth
                  '4 time
                  run_WaitingMode = False
                  PlayTrackInfo(int_current_index).BookmarkLength = CInt(readCommand(3))
                  PlayTrackInfo(int_current_index).BookmarkTime = CInt(readCommand(4))
               End If
               timeVisible = seekWidth '- PlayTrackInfo(int_current_index).BookmarkTime
               CPlayer.Volume = 0
               CPlayer.Play
               CPlayer.Seeks = seekWidth
               tmr.Enabled = True
               If readCommand(2) = 2 Then miniCommand "Pause" & "|:|True"
               If readCommand(2) = 3 Then miniCommand "Stop" & "|:|True"
               '2006-02-14
               'If b_mute = False Then WaveVolume = WaveVolume               'Turn Volume on again
            End If
         Case "SelectPlayerTrack"
            If CWinsock.LoggedType <> independentMode Then
               int_current_index = readCommand(1)
               If int_current_index < 0 Or int_track_count <= 0 Then Exit Sub
               If PlayTrackInfo(int_current_index).infoNotFilled = True Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackInfo&&&" & int_current_index & "&&&" & 0
               Else
                  str_current_Track = readCommand(2)
                  If IndexSwf = 4 Then
                     sendToFlash FrmMain.Swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
                  End If
                  If int_track_count > 0 Then
                     boolFirstLogged = False
                     
                     'miniCommand "Play|:|true"         'Make it play for the first time
                     'error occur while play to the next song automatically
                     '2006-02-14
                     ''WaveVolume = 0                      'mute the song before playing next song
                     miniCommand "SelectedPlaylist" & "|:|" & readCommand(1)
                  End If
               End If
            End If
         Case "RefreshPlayer"
            'sent from server for refresh tracks count
            'If Not ((CWinsock.LoggedType = serverMode) Or (CWinsock.LoggedAs(independentMode))) Then
            If Not CWinsock.LoggedAs(independentMode) Then
            
               int_current_index = readCommand(2)
               refreshAllPlayerTrack val(readCommand(1))                      'for client/server
               If boolFirstLogged Then
                  If int_track_count > 0 Then
                     CWinsock.Send2Server WS_COMMAND, "requestTrackInfo&&&" & int_current_index & "&&&" & 0
                  End If
               End If
               If IndexSwf = 4 Then          'if in the player page
                  sendToFlash Swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
               End If
               If int_track_count = 0 Then miniCommand "RemoveAll" & "|:|"
            End If
         Case "loadPlayerFile"
            LoadServerPlayList SlyVariable("<Player>")
            If boolFirstLogged Then
               CWinsock.Send2Server WS_COMMAND, "other&&&requestTrackIndex"
            End If
            
         Case "LoadSWF"
            Select Case Int(readCommand(1))
               Case 0
                  LoadSwfInterfaceCD IndexSwf
               Case 1
                  If IndexSwf <> 1 Then
                   Unload Swf(IndexSwf)
                   Load Swf(1)
                  End If
                  ReloadFlash "Country.sly", Swf(1), 1
                  sendVariable2Flash Swf(1), "ReLoad", "false"
                  CWinsock.serverMainPath = readCommand(2)
                  sendToFlash Swf(1), "clientType", CWinsock.LoggedType
                  sendToFlash Swf(1), "OpenXml", readCommand(2) & "\sly"
                  sendToFlash Swf(1), "select", readCommand(3)
            End Select
         Case "Command"
            Select Case readCommand(1)
               Case "ReenterNick"
                  sendToFlash Swf(1), "sly_name", SlyNickName
               Case "Disconnect"
                  'Received from server to disconnect it self(access denied)
                  '1:Remotecontrol can't connect more than the maximum client allowed
                  '2:.........................
                  CWinsock.LoggedType = ServerMode
                  Popup_Dialog "Connection", readCommand(2)
                  sendToFlash Swf(IndexSwf), "not_connected", "true"
                  sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
                  sckClient.Close
               Case "RemoveTrack"
                     If CWinsock.LoggedType = independentMode Then Exit Sub '
                     If int_track_count > 1 Then
                        RemovePlayerTrack readCommand(2)
                        If IndexSwf = 4 Then
                           sendToFlash Swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
                        End If
                     ElseIf int_track_count = 1 Then
                        If IndexSwf = 4 Then
                           sendToFlash Swf(4), "function", "RemoveOneTrack" & "|~|" & readCommand(2)
                        Else
                           RemovePlayTrackAll
                        End If
                     End If
               Case "move"
                  If IndexSwf = 4 Then
                     sendToFlash Swf(4), "function", "SortMasterMoveUpDown|~|" & readCommand(2) & "|~|" & readCommand(3)
                  Else
                     MoveTrack readCommand(2), readCommand(3)
                  End If
            End Select
         Case "other"
            Select Case readCommand(1)
               Case "playMusicWith"
                  FunOptions readCommand(1), readCommand(2), True
            End Select
         
         Case "Success"
            Dim profileTarget As String
            CWinsock.LoggedType = readCommand(1) Or ServerMode                'Server and client mode
            CWinsock.waitCommandString = readCommand(2)
            CWinsock.clientIndex = readCommand(3)
            CWinsock.serverID = readCommand(4)
            CWinsock.serverName = CWinsock.serverNickName & " (" & readCommand(5) & ")"
            login_name = ""
            'CBrowse.CreateMyAlbumXml SlyNickName                  '2006-06-30 Seng
            run_bRequestConnecting = False
            'save last connected success server name
            If (server_name <> "") Then
               'i_AutoConnected = CWinsock.LoggedType
               EditSetting MainSettingXML, 0, "LastServerName", CStr(server_name)
               EditSetting MainSettingXML, 0, "LastUserOnline", CStr(server_nick_name)
               EditSetting MainSettingXML, 0, "AutoClientConnection", CStr(CWinsock.LoggedType)
               'EditSetting MainSettingXML, 0, "LastLoginName", CStr(server_loginName)
            End If
            'Debug.Print "\\" & CWinsock.getRemoteHostIP("")
            profileTarget = SlyVariable("<ExternalPath>") & CWinsock.serverName & "\" & SlyEncodeProfile
            run_bServerImageFolderExist = fso.FolderExists("\\" & CWinsock.getRemoteHostIP("") & "/" & SlyGuideFolder)
            If Not isFileExist(profileTarget) Then
               'this for client connect to server
               'copy default profile to this directory
               CreateDirectory SlyVariable("<ExternalPath>") & CWinsock.serverName
               'no need to copy file anymore 2006-05-27
               'FileCopy fso.BuildPath(App.path, SlyEncodeProfile), profileTarget
            End If
            RefreshAlbumAvailableToServer
            If ((CWinsock.LoggedAs(cloneDisplay)) Or (CWinsock.LoggedAs(remoteControl)) Or (CWinsock.LoggedAs(remotePlaylist))) Then
               RemovePlayTrackAll         'remove all tracks
            End If
            If (CWinsock.LoggedType = independentMode And IsRegistered And MonitorCount > 1) Then
               If Not isSoundFile(str_current_Track) Then
               frmVideo.Show
               SetFocus
               End If
            End If
            sendToFlash Swf(1), "success", ""
            server_nick_name = CWinsock.serverName
        Case "startingPage"
            Dim str() As String
            str = Split(readCommand(2), "|^&|")
            bool_full_vis = CBool(readCommand(1))
            If UBound(str) > 0 Then
               sendToFlash Swf(1), "server_page", str(0)
               currentIndex = str(1)
            Else
               sendToFlash Swf(1), "server_page", readCommand(2)
               If bool_full_vis Then
                  FrmMain.scale_visualization_to_fullscreen (False)
               End If
            End If
        Case "backReload"
            Dim vvSplit() As String
            vvSplit = Split(readCommand(1), "|||")
            
            IndexSearchToLoad = vvSplit(0)
            IndexPlaylistToLoad = vvSplit(1)
            IndexPlayerToLoad = vvSplit(2)
            IndexOptionToLoad = vvSplit(3)
            
        Case "changeXMLSetting"
            start_change_xml_setting_as_server (readCommand(1))
           
        Case "fullscreenPlayer"
            tspl = Split(readCommand(1), "||")
            If str_swfNames = "Fullscreen" Then
                If (left(tspl(1), 45) = "control_mini_player|~|close_fullscreen_player") Then
                    If CWinsock.LoggedType <> independentMode Then sendToFlash SWF_FMA(1), tspl(0), tspl(1)
                Else
                    sendToFlash SWF_FMA(1), tspl(0), tspl(1)
                End If
            Else
                sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
                If (left(tspl(1), 43) = "control_mini_player|~|fn_key_changeLanguage") Then
                    change_language
                ElseIf (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                    temp_array = Split(tspl(1), "|~|")
                    numKeyPress temp_array(2)
                ElseIf (left(tspl(1), 37) = "control_mini_player|~|seek_fullscreen") Then
                    temp_array = Split(tspl(1), "|~|")
                    'seek_fullscreen temp_array(2)
                    miniCommand "seek" & "|:|" & temp_array(2)
                    
                End If
            End If
        Case "microPlayer"
            tspl = Split(readCommand(1), "||")
            If str_swfNames = "Micro" Then
                If (left(tspl(1), 33) = "control_mini_player|~|fn_maximize") Then
                    If CWinsock.LoggedType <> independentMode Then sendToFlash SWF_FMA(2), tspl(0), tspl(1)
                Else
                    sendToFlash SWF_FMA(2), tspl(0), tspl(1)
                End If
            Else
                sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
                If (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                    temp_array = Split(tspl(1), "|~|")
                    numKeyPress temp_array(2)
                ElseIf (left(tspl(1), 32) = "control_mini_player|~|seek_micro") Then
                    temp_array = Split(tspl(1), "|~|")
                    'seek_micro temp_array(2)
                    miniCommand "seek" & "|:|" & temp_array(2) 'args
                    
                ElseIf (left(tspl(1), 32) = "control_mini_player|~|executeKey") Then
                    temp_array = Split(tspl(1), "|~|")
                    handleShortCutKey CLng(temp_array(2))
                End If
'                SWF_FMA_FSCommand 2, tspl(2), tspl(3)
            End If
        Case "slideshow"
            If (readCommand(1) <> "") Then
                tspl = Split(readCommand(1), "||")
                If LoadSlideshow = True Then
                    If (left(tspl(1), 35) = "control_mini_player|~|ExitSlideShow") Then
                        If CWinsock.LoggedType <> independentMode Then sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
                    Else
                        sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
                    End If
                Else
                    sendToFlash FrmMain.Swf(IndexSwf), tspl(0), tspl(1)
                    If (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                        temp_array = Split(tspl(1), "|~|")
                        numKeyPress temp_array(2)
                    ElseIf (left(tspl(1), 36) = "control_mini_player|~|seek_slideshow") Then
                        temp_array = Split(tspl(1), "|~|")
                        'frmSlideShow.seek_slideshow temp_array(2)
                        miniCommand "seek" & "|:|" & temp_array(2)
                    ElseIf (left(tspl(1), 35) = "control_mini_player|~|ExitSlideShow") Or (left(tspl(1), 40) = "control_mini_player|~|seek_vol_slideshow") Then
                        temp_array = Split(tspl(1), "|~|")
                        frmSlideShow.exit_slideshow temp_array(2)
                    End If
                End If
            End If
         Case "mini"
            tspl = Split(readCommand(1), "||")
            sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
            If (left(tspl(1), 32) = "control_mini_player|~|executeKey") Then
                temp_array = Split(tspl(1), "|~|")
                handleShortCutKey CLng(temp_array(2))
                
            End If
         Case "visualization"
             click_self = False
             cmdFull_Click
             click_self = True
         Case "fullscreen"
             click_self = False
             click_self = True
         Case "removeAllTracks"
            If CWinsock.LoggedType = independentMode Then Exit Sub
            tspl = Split(readCommand(1), "||")
            If CInt(tspl(2)) = IndexSwf Then
               sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
            Else
               RemovePlayTrackAll
            End If
         Case "remove_track_one_by_one"
            tspl = Split(readCommand(1), "||")
            If CInt(tspl(2)) = IndexSwf Then
               sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
            Else
               temp_array = Split(tspl(1), "|~|")
               RemovePlayerTrack val(temp_array(1))
            End If
         Case "normal"
            If readCommand(1) <> "" Then
                tspl = Split(readCommand(1), "||")
                If UBound(tspl) = 2 Then    ' this statement protect for readcommand variable lost some string
                  'If CWinsock.LoggedType <> remotePlaylist And CWinsock.LoggedType <> independentMode Then
                    If CWinsock.LoggedType = cloneDisplay Then
                        If Len(tspl(2)) = 1 Then
                            If CInt(tspl(2)) = IndexSwf Then
                                sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
                            End If
                        End If
                    End If
                  
'''                    If CWinsock.LoggedType <> remotePlaylist And CWinsock.LoggedType <> independentMode Then
'''                        If Len(tspl(2)) = 1 Then
'''                            If CInt(tspl(2)) = IndexSwf Then
'''                                sendToFlash swf(CInt(tspl(2))), tspl(0), tspl(1)
'''                            End If
'''                        End If
'''                    End If
                    If LoadSlideshow = True And tspl(2) = "slideshow" Then
                        sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
                    End If
                End If
            End If
         Case "syn"
            If syn_vol = True Then
                tspl = Split(readCommand(1), "||")
                sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
                
                If LoadSlideshow = True Then
                    sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
                ElseIf str_swfNames = "Micro" Then
                    sendToFlash SWF_FMA(2), tspl(0), tspl(1)
                Else
                    Dim d_arr() As String
                    If mID(tspl(1), 1, 43) = "control_syncronize|~|volume|~|ExitSlideShow" Then
                        d_arr = Split(tspl(1), "|~|")
                        frmSlideShow.exit_slideshow d_arr(3)
                    ElseIf mID(tspl(1), 1, 40) = "control_syncronize|~|volume|~|executeKey" Then
                       d_arr = Split(tspl(1), "|~|")
                       handleShortCutKey CLng(d_arr(3))
                    End If
                End If
            End If
        Case "space_slideshow"
            If LoadSlideshow = True Then
                tspl = Split(readCommand(1), "||")
                sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
            Else
                popUp True
            End If
        '-------------------------------------
        ' for slideshow copy image from server
        '-------------------------------------
        Case "copy_xml_slideshow"
            If syn = True And LoadSlideshow = True Then
                CWinsock.Send2Server WS_COMMAND, "start_copy_xml_slideshow&&&" & fso.GetSpecialFolder(2) & "\slideshow.xml"
            End If
            
        Case "completed_copy_xml_slideshow"
            first_copy_image_slideshow_from_server read_xml_image_slideshow_path
            
        Case "completedCopyImageSlideshow"
            busy_copying_slideshow = False
            start_copy_images_for_slideshow
        Case "slideshow_random"
            If syn And LoadSlideshow Then
                sendVariable2Flash frmSlideShow.SlideShow, "Random", readCommand(1)
            End If
        Case "completedRedownload"
            If LoadSlideshow Then
                sendToFlash frmSlideShow.SlideShow, "completedRedownload", CStr(current_index_redownload)
            End If
            redownload_slideshow
        Case "server_loadSlideshow"
            server_loadSlideshow = readCommand(1) = "True"
        Case "server_slideshow_index"
            server_slideshow_index = CInt(readCommand(1))
        '------------------------------
        ' for copy friend's playlist
        '------------------------------
        Case "receive_computer_name"
            add_friend_playlistPahtsXML readCommand(1)
            CWinsock.Send2Server WS_COMMAND, "request_copy_main_playlist&&&" & friend_playlist_path & "\PlayLists.xml"
        Case "completed_copy_playlists"
            CWinsock.Send2Server WS_COMMAND, "request_copy_all_playlists&&&" & friend_playlist_path
            
        Case "pass_computer_name"
            server_name_connected = readCommand(1)
            If server_nick_name <> "" Then
                str_main_playlist_path = GetMyDocuments & "\" & "Sly's Friends Playlists" & "\" & server_nick_name
            Else
                str_main_playlist_path = GetMyDocuments & "\" & "Sly's Friends Playlists" & "\" & SlyNickName
            End If
            CreateDirectory str_main_playlist_path
            CWinsock.Send2Server WS_COMMAND, "request_copy_PlayListPath&&&" & str_main_playlist_path
        Case "completed_copy_PlayListPaths"
            change_playlist_path str_main_playlist_path
        Case "completed_copy_PlayLists"
            copy_Playlists_xml
        Case "completed_copy_each_playlists"
            copy_all_playlist_xmls
            
        Case "request_path_save_playlist"
            If CWinsock.LoggedType = cloneDisplay Then
                CWinsock.Send2Server WS_COMMAND, "copy_save_playlist&&&" & readCommand(3) & "&&&" & save_new_playlist(readCommand(1), readCommand(2))
            End If
        Case "copy_save_playlist"
            CWinsock.SendCopy WS_COPYTO, 0, readCommand(1) & FileDelimiter & readCommand(2) & FileDelimiter & "completed_copy_new_playlist"
        '------------------------------
        Case "receive_login_Type"
            'If IndexSwf = 1 Then
               'sendVariable2Flash swf(1), "allow_modes", readCommand(1)
               'sendToFlash swf(1), "connected", ""
            If run_bRequestConnecting Then
               If i_AutoConnected > 0 Then swf_FSCommand 1, "requestConnect", i_AutoConnected
            ElseIf IndexSwf = 1 Then
               sendVariable2Flash Swf(1), "allow_modes", readCommand(1)
               sendToFlash Swf(1), "connected", ""
            End If
        ' case other
        Case "click_minimize"
            If CWinsock.LoggedType <> independentMode And CWinsock.LoggedType <> remoteControl Then
                click_self = False
                click_minimize
                click_self = True
            End If
        Case "your_permission"
            If UBound(readCommand) = 3 Then
            
                syn_vol = (LCase(CBool(CInt(readCommand(1)))) = "true")
                EditSetting MainSettingXML, 2, "syn", LCase(syn_vol)
                sendVariable2Flash Swf(IndexSwf), "syn_volume", CStr(syn_vol)
                
                syn = (LCase(CBool(CInt(readCommand(2)))) = "true")
                EditSetting MainSettingXML, 1, "syn", LCase(syn)
    
                b_AllowSlideshow = (LCase(CBool(CInt(readCommand(3)))) = "true")
                EditSetting MainSettingXML, 1, "allow_slideshow", LCase(b_AllowSlideshow)
            End If
        Case "send_server_index"
            sendVariable2Flash Swf(IndexSwf), "get_permission_for_client", user_sign_in_index & "||" & readCommand(1)
        Case "receive_allow_from_server"
            sendVariable2Flash Swf(IndexSwf), "receive_allow_from_server", readCommand(1)
        Case "server_deny"
            sckClient.Close
            CWinsock.LoggedType = ServerMode
            sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
        Case "server_busy"
            sckClient.Close
            CWinsock.LoggedType = ServerMode
            sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
            
            If LoadSlideshow = True Then
                sendVariable2Flash frmSlideShow.SlideShow, "server_deny", "True"
            Else
                If str_swfNames = "" Then
                    sendVariable2Flash Swf(IndexSwf), "server_deny", "True"
                ElseIf str_swfNames = "Fullscreen" Then
                    sendVariable2Flash SWF_FMA(1), "server_deny", "True"
                End If
            End If
            Debug.Print "server_busy"
       Case "keyPressed"
            If CWinsock.LoggedType <> independentMode Then
               PressKeyInternalPlayer readCommand(1), True
            End If
       Case "keyShortcut"
            ProcessKeyShortCut False, False, CDbl(readCommand(1))
       End Select
   Else        'For copy files
      CWinsock.SendCopy dataCommand, 0, dataReceived
   End If
   Exit Sub
ErrorHandler:
   
   WriteEvent "ReceivedClient in " & UCase(readCommand(0)), Err.Description, Err.Source
End Sub
Public Sub ReceivedServer(index As Integer, ByVal dataCommand As WinsockDownloadEnum, dataReceived As String)
   'this sub procedure is received the events from clients
   On Error GoTo ErrorHandler
   Dim tspl() As String
   Dim temp_array() As String
   Dim readCommand() As String
   Dim variableStored As String     'For use temporary
   Dim playSave As String
   Dim FileExtension As String
   Dim iLocalValue As Single
   Dim iInteValue As Integer
   Dim variableString As String
   Dim variableReturn As String
   If dataCommand = WS_COMMAND Or dataCommand = WS_REQUESTING Then
      readCommand = Split(dataReceived, de_Record)
      
      Select Case readCommand(0)
         Case "AddTrackByKey"
            AddTrackByKey readCommand(1)
         Case "PreventTimeOut"
            'make connection stay alive
           CWinsock.Send2Client WS_COMMAND, index, "PreventTimeOut"
         Case "ServerFullScreen"
            If str_swfNames <> "Micro" And Not bool_full_vis And str_swfNames <> "Fullscreen" Then miniCommand "FullScreen|:|false", CWinsock.ClientType(index)
         Case "ServerVideoZoomIn"
            miniCommand "VideoZoomIn|:|false"
         Case "ServerVideoZoomOut"
            miniCommand "VideoZoomOut|:|false"
         Case "ServerKaraokeVoice"
            miniCommand "karaoke_voice|:|" & LCase(Not b_karaoke_voice)
         Case "Minicommand"
            If miniCommand(readCommand(1), CWinsock.ClientType(index)) = False Then CWinsock.Send2Client WS_COMMAND, 0, "Minicommand" & de_Record & readCommand(1)
         Case "StartConvert"
            RemoveEncodeitemQueue 0
            StartConvert
         Case "RequestIsFirstClient"
            If CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(independentServer) Then
               CWinsock.Send2Client WS_COMMAND, index, "ResponseIsFirstClient&&&" & Settings.i_MaxRemoteControl & "&&&" & CWinsock.IsClientFirstLogged(index)
               'return ResponseIsFirstClient,Count,True/False
            End If
         Case "RequestUpdateDatabase"                 'CountryName,ClientLastUpdate
            'RequestUpdateDatabase ", currentCountry, CBrowse.GetLastUpdate)     "
            If CDate(GetLastUpdate(readCommand(1))) > CDate(readCommand(2)) Then
               variableStored = GetNetworkPath(get_country_path(readCommand(1)))
               If InStr(variableStored, "\\") > 0 Then                        'if it is the network path
                  'Send      CountryName,database's network path
                  CWinsock.Send2Client WS_COMMAND, index, ConcateString("&&&", "ResponseUpdateDatabase", readCommand(1), variableStored)
                  'Send back the shared database path to client                  '\\192.168.100.109\DVDs\Khmer Karaoke
                  'The current database is newer than client so start updating database........................
               End If
            End If
         Case "RequestChangeMaxRemoteControl"
            'Request from Remotecontrol client to change Max Client connected
            'Only available for the first one logged
            If CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(independentServer) Then
               'only indepdentmode or independent server
               If CWinsock.IsClientFirstLogged(index) Then  'if it is the first one logged to server amoung all
                  If val(readCommand(1)) > CWinsock.GetNumberOfConnected Then       'can't be < the amount of client connecting
                     Settings.i_MaxRemoteControl = val(readCommand(1))
                  Else
                     '
                     Debug.Print "Can't set less than the amount of client connecting"
                  End If
               Else
                  'Not the firsts one logged
                  Debug.Print "Not the first one "
               End If
            End If
         Case "StartCopy"
            DownloadingMusic.ToTrackPath = readCommand(2)
            DownloadingMusic.FromTrackPath = readCommand(1)
            CWinsock.SendCopy WS_COPYFROM, index, DownloadingMusic.ToTrackPath & FileDelimiter & DownloadingMusic.FromTrackPath & FileDelimiter & "DownloadSongCompleted"
         Case "ChangeIndex"
            miniCommand "SelectedPlaylist" & "|:|" & readCommand(1)
            'handleMinicommand "SelectedPlaylist" & "|:|" & readCommand(1)
         Case "requestCopyFile"
            readCommand(1) = getQueryString(readCommand(1))
            If fso.GetExtensionName(readCommand(2)) = "" Or Len(fso.GetExtensionName(readCommand(2))) > 4 Then readCommand(2) = fso.BuildPath(readCommand(2), fso.GetFileName(readCommand(1)))
            FileExtension = LCase(fso.GetExtensionName(readCommand(1)))
            If (FileExtension = "mp3" Or FileExtension = "wma") And isFileExist(readCommand(1)) And CBool(readCommand(3)) And b_EncoderInstalled Then
               'Save file to temp folder
               variableStored = GetWinTempPath & "Download" & index & ".wma"       'Save converted file to this path
               AddEncodeItemQueue CWinsock.ClientID(index), CWinsock.ClientNickName(index), variableStored & "&&&" & ChangeFileExtension(readCommand(2), "wma"), readCommand(1), variableStored
            Else
               '1 = From ,2= To
               CWinsock.Send2Client WS_COMMAND, index, "StartCopy&&&" & readCommand(1) & "&&&" & readCommand(2)
            End If
         Case "RequestNextPrev"
            playSave = fso.BuildPath(App.path, "PlayerInfo" & index & ".xml")
         
            Call SaveServerPlayList(playSave, , , readCommand(1))
            CWinsock.SendCopy WS_COPYTO, index, playSave & FileDelimiter & "<AppPath>\PlayerInfo.xml" & FileDelimiter & "responseNextPrev"
         Case "MusicLoaded"
            'EDID 2006.05.03
            CWinsock.ClientMusicLoaded = CWinsock.ClientMusicLoaded + 1
            If CWinsock.ClientMusicLoaded >= CWinsock.getClonePlayBackCounts Then
               'start play now
'''               iLocalValue = getCurrentDuration
'''               If playMusicWith = WindowMedia Then
'''                  boolPausedState = CWmp.playState = wmppsPaused
'''                  If boolPausedState Then
'''                     Sleep 1000           'sleep 1s to make it sync well
'''                     CWmp.Controls.Play
'''                  End If
'''               ElseIf playMusicWith = Winamp Then
'''                  boolPausedState = CMediaPlayer.movieStatus = Pausing
'''                  If boolPausedState Then CMediaPlayer.MediaClassCommand ToolPlay
'''               End If
'''               CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & (iLocalValue) & "&&&" & getPlayState
'''               If boolPausedState Then
'''                  If playMusicWith = Winamp Then
'''                     CMediaPlayer.SeeksTime iLocalValue
'''                     CMediaPlayer.MuteMedia = False
'''                  ElseIf playMusicWith = WindowMedia Then
'''                     CWmp.Controls.CurrentPosition = iLocalValue '+ 0.01
'''                     CWmp.Settings.Volume = 100         'unmute
'''                  End If
'''               End If
'''               FrmMain.picMovieBackground.Visible = True       'unblank the screen
'''               run_WaitingMode = False
               If boolTrackIsChanged = True And CPlayer.PlayWith = Winamp Then
               Else
                  loadMusicFromWaitng index
               End If
            End If
         Case "DownloadSongCompleted"
            'For DVD Don't try to download file coz it is DVD(Over 2GB)
'            CopyingSong = False
'            If isFileExist(DownloadingMusic.ToTrackPath) Then
'               oldSeek = seekTimeValue
'               Call CopyCompleted(DownloadingMusic.language, DownloadingMusic.TrackID, DownloadingMusic.ToTrackPath)
'               If DownloadingMusic.TrackID = Infos(int_current_index).TrackID And DownloadingMusic.language = Infos(int_current_index).TrackLan Then
'                  b_play = False
'                  miniCommand "Play|:|true"
'                  If playMusicWith = Winamp Then
'                     MediaPlayer.TrackPosition = oldSeek
'                  Else
'                     CWmp.Controls.CurrentPosition = oldSeek
'                  End If
'               End If
'               CWinsock.RemoveDownloadingMusic False
'            End If
'            CWinsock.Send2Client WS_COMMAND, Index, "StartConvert"
'            CWinsock.StartDownloadItem False
         Case "requestZoomLevel"
            '1 TrackID
            '2 Language
            iInteValue = GetTrackField(readCommand(1), "ZoomLevel", readCommand(2))
            CWinsock.Send2Client WS_COMMAND, index, "responseZoomLevel&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & iInteValue
         Case "requestLogin"
            If CWinsock.LoggedAs(independentServer) Then
               CWinsock.Send2Server WS_COMMAND, dataReceived & "&&&" & index        'Send index for sending back
            ElseIf CWinsock.LoggedAs(ServerMode) Then
               temp_array = Split(readCommand(1), ":::")
               variableReturn = CUserLogin.IsUserExist(temp_array(0), temp_array(1))
               If variableReturn = "True" Then
                  variableStored = fso.BuildPath(CUserLogin.LinkingPlayListPath, temp_array(0))
                  If Not fso.FolderExists(variableStored) Then fso.CreateFolder variableStored
               End If
               'True=Success;False=Fail
               If UBound(readCommand) = 2 Then
                  CWinsock.Send2Client WS_COMMAND, index, "responseLogin&&&" & variableReturn & "&&&" & readCommand(1) & "&&&" & GetNetworkPath(CUserLogin.LinkingPlayListPath) & "&&&" & readCommand(2)
               Else
                  CWinsock.Send2Client WS_COMMAND, index, "responseLogin&&&" & variableReturn & "&&&" & readCommand(1) & "&&&" & GetNetworkPath(CUserLogin.LinkingPlayListPath)
               End If
            End If
         Case "requestSignup"
            If CWinsock.LoggedAs(independentServer) Then
               CWinsock.Send2Server WS_COMMAND, dataReceived & "&&&" & index        'Send index for sending back
            ElseIf CWinsock.LoggedAs(ServerMode) Then
               temp_array = Split(readCommand(1), ":::")
               variableStored = CUserLogin.AddUser(temp_array(0), temp_array(1), temp_array(2), temp_array(3), temp_array(4), temp_array(5), temp_array(6))
               'True=Success;False=Fail
               CWinsock.Send2Client WS_COMMAND, index, "responseSignup&&&" & variableStored & "&&&" & readCommand(2)
               If UBound(readCommand) = 2 Then
                  CWinsock.Send2Client WS_COMMAND, index, "responseSignup&&&" & variableStored & "&&&" & readCommand(2)
               Else
                  CWinsock.Send2Client WS_COMMAND, index, "responseSignup&&&" & variableStored
               End If
            End If
         Case "requestAlbumAvailable"
            variableStored = CBrowse.getAlbumAvailables(readCommand(1), readCommand(2))
            If variableStored <> "" Then CWinsock.Send2Client WS_COMMAND, index, "responseAlbumAvailable&&&" & variableStored
         Case "requestTrackAvailable"
            variableStored = CBrowse.getTrackAvailables(readCommand(1), readCommand(2), variableReturn)
            
            If variableReturn <> "" Then
               If (CWinsock.LoggedAs(independentServer)) And (UBound(readCommand) = 2) Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackAvailable&&&" & variableReturn & "&&&" & readCommand(2) & "&&&" & index
               End If
            End If
            '2 level client/server
            'if can't find the path and it is client/server so send to server another server again
            If variableStored <> "" Then
               If UBound(readCommand) > 2 Then
                  CWinsock.Send2Client WS_COMMAND, index, "responseTrackAvailable&&&" & variableStored & "&&&" & SlyNickName & "&&&" & readCommand(3)
               Else
                  CWinsock.Send2Client WS_COMMAND, index, "responseTrackAvailable&&&" & variableStored & "&&&" & SlyNickName
               End If
            End If
         Case "responseTrackAvailable"
            CallFlashFunction Swf(IndexSwf), "changeAvailable", readCommand(1), readCommand(2)
         Case "requestTrackPath"
            variableString = getMoviePathAndSample(readCommand(1), , iInteValue)
            If variableString = "" And CWinsock.LoggedType <> ServerMode And (UBound(readCommand) = 1) Then
               '2 level client/server
               'if can't find the path and it is client/server so send to server another server again
               CWinsock.Send2Server WS_COMMAND, dataReceived & "&&&" & index
            Else
               variableStored = readCommand(1) & "&&&" & GetNetworkPath(variableString)
               If UBound(readCommand) > 1 Then
                  CWinsock.Send2Client WS_COMMAND, index, "responseTrackPath&&&" & variableStored & "&&&" & iInteValue & "&&&" & readCommand(2)
               Else
                  CWinsock.Send2Client WS_COMMAND, index, "responseTrackPath&&&" & variableStored & "&&&" & iInteValue
               End If
            End If
         Case "requestStreamPath"
            iInteValue = val(readCommand(4))
            variableString = GetStreamPath(readCommand(1), readCommand(2), readCommand(3), iInteValue)
            'return iInteValue
            If variableString = "" And Not CWinsock.LoggedAs(ServerMode) And (UBound(readCommand) = 3) Then
               '2 level client/server
               'if can't find the path and it is client/server so send to server another server again
               CWinsock.Send2Server WS_COMMAND, dataReceived & "&&&" & index
            Else
               If UBound(readCommand) > 4 Then
                  'CWinsock.Send2Server WS_COMMAND, "responseStreamPath&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3) & "&&&" & iInteValue & "&&&" & GetNetworkPath(variableStored)
                  'CWinsock.Send2Client WS_COMMAND, Index, "responseStreamPath&&&" & readCommand(1) & "&&&" & GetNetworkPath(variableString) & "&&&" & readCommand(3) & "&&&" & readCommand(4)
                  CWinsock.Send2Client WS_COMMAND, index, "responseStreamPath&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3) & "&&&" & iInteValue & "&&&" & GetNetworkPath(variableString) & readCommand(5)
               Else
                  CWinsock.Send2Client WS_COMMAND, index, "responseStreamPath&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3) & "&&&" & iInteValue & "&&&" & GetNetworkPath(variableString)
               End If
               
            End If
            
         Case "responseStreamPath"
            ChangeAllStreamPath readCommand(1), readCommand(2), readCommand(3), readCommand(4), readCommand(5)
         Case "responseTrackPath"
             PlayFileFromRemoteMachine readCommand(1), readCommand(2), val(readCommand(3)), CWinsock.ClientID(index)
         Case "reuqestBrowseAlbums"
            'arguments 1,2
            CWinsock.Send2Client WS_COMMAND, index, "responseBrowseAlbums&&&" & readCommand(3) & "&&&" & CBrowse.GetNextAlbum(readCommand(1), readCommand(2))
         Case "changeDownloadInfo"
            DownloadingMusic.ToTrackPath = readCommand(1)
         Case "setSeekTime"
            seekWidth = readCommand(1)
            CPlayer.Play
            CPlayer.Seeks = seekWidth

            If readCommand(2) = 2 Then miniCommand "Pause" & "|:|True"
            If readCommand(2) = 3 Then miniCommand "Stop" & "|:|True"
         Case "requestFakeTime"
            CWinsock.Send2Client WS_COMMAND, index, "setFakeTime&&&" & run_FakeTime & "&&&" & getPlayState
         Case "Request"
            Dim requestMode As EnumPlayListMode
            Dim profileTarget As String
            Dim iRegKeyType As RegisterEnum
            Dim iRegKeyClients As Integer
            
            requestMode = readCommand(1)
            iRegKeyType = GetRegisterKeyType
            If iRegKeyType = RegisterAsLinkingServer Or iRegKeyType = RegisterAsRoomServer Then
               If iRegKeyType = RegisterAsRoomServer And requestMode <> remoteControl Then
                  iRegKeyClients = 0
               Else
                  iRegKeyClients = GetRegisterKeyClients
               End If
            ElseIf iRegKeyType = RegisterAsRemoteControl Then
               iRegKeyClients = 0
            ElseIf iRegKeyType = NotRegistered Then         'Unregistered version only 5 user connected
            
               iRegKeyClients = 5            '2015-03-01
            End If
            'If ((CWinsock.LoggedAs(ServerMode) And ((iRegKeyType = RegisterAsLinkingServer) And (iRegKeyClients > CWinsock.GetNumberOfConnected))) Or (CWinsock.LoggedAs(independentMode) And (requestMode = remoteControl) And ((iRegKeyType = RegisterAsRoomServer) And (iRegKeyClients > CWinsock.GetNumberOfConnected) And i_MaxRemoteControl > CWinsock.GetNumberOfConnected))) Then
            
            If ((CWinsock.LoggedAs(ServerMode) Or (CWinsock.LoggedAs(independentServer) And requestMode = remoteControl)) And CWinsock.GetNumberOfConnected < iRegKeyClients) Then
               
               'only allow to connect when it is independent mode or server mode
               If readCommand(3) = "1" Then
                  'switch from one mode to other mode
                  variableStored = ""
               Else
                  'connect first time
                  variableStored = CWinsock.isClientLogged(readCommand(2))
               End If
               If variableStored = vbNullString Then                          'Client successfully connected to server
                     CWinsock.ClientType(index) = requestMode
                     CWinsock.ClientID(index) = readCommand(2)
                     CWinsock.ClientNickName(index) = readCommand(4)
                     CWinsock.ClientTimeLogged(index) = Now    'Set Time logged of the client
                     
                     '============================================================
                     'Create directory name for client connected
                     profileTarget = SlyVariable("<ExternalPath>") & readCommand(4) & "\" & SlyEncodeProfile
                     If Not isFileExist(profileTarget) Then
                        'copy default profile to this directory
                        CreateDirectory SlyVariable("<ExternalPath>") & readCommand(4)
                        FileCopy fso.BuildPath(App.path, SlyEncodeProfile), profileTarget
                     End If
                     '============================================================
                     CWinsock.Send2Client WS_COMMAND, index, "Success&&&" & requestMode & "&&&" & CallFlashFunction(Swf(0), "getBrowse2Path") & "&&&" & index & "&&&" & SlyNickName & "&&&" & ComputerName
                     'send language path from server to Client
                     change_xml_setting_as_server (index)
                     
                     popup_connected CWinsock.ClientNickName(index) & "%%" & CWinsock.ClientType(index), True
                     
                     If requestMode = cloneDisplay Then
                        If IndexSwf = 1 Then
                           If Swf(1).GetVariable("workingPage") <> "country" Or Swf(1).GetVariable("showAddPage") = "true" Then
                              CWinsock.Send2Client WS_COMMAND, index, "startingPage&&&" & bool_full_vis & "&&&" & server_display_language & "|||" & server_display_page & "|||" & Swf(1).GetVariable("workingPage") & "|||" & Swf(1).GetVariable("showAddPage")
                           Else
                              CWinsock.Send2Client WS_COMMAND, index, "startingPage&&&" & bool_full_vis & "&&&" & server_display_language & "|||" & server_display_page
                           End If
                        Else
                            If IndexSwf = 4 Then
                                CWinsock.Send2Client WS_COMMAND, index, "startingPage&&&" & bool_full_vis & "&&&" & server_display_language & "|||" & server_display_page & "|^&|" & Swf(4).GetVariable("NumLeftTrack") & "|^&|" & bool_full_vis 'FullScreenPage
                             Else
                                CWinsock.Send2Client WS_COMMAND, index, "startingPage&&&" & bool_full_vis & "&&&" & server_display_language & "|||" & server_display_page
                            End If
                        End If
                        CWinsock.Send2Client WS_COMMAND, index, "backReload&&&" & IndexSearchToLoad & "|||" & IndexPlaylistToLoad & "|||" & IndexPlayerToLoad & "|||" & IndexOptionToLoad
                     End If
                     check_status                       'remove check status
               Else
                  'To Reenter nick name
                  CWinsock.Send2Client WS_REQUESTING, index, "Command&&&ReenterNick&&&" & variableStored
               End If
            Else
               'Send to client to disconnect from server (maximum client reached)
               denyConnection = True
               CWinsock.Send2Client WS_REQUESTING, index, "Command&&&Disconnect&&&Server Full"
            End If
         Case "requestBrowsingAlbum"
            CBrowse.SaveBrowseAlbum2Xml SlyVariable("<AlbumSend>")
            CWinsock.SendCopy WS_COPYTO, index, SlyVariable("<AlbumSend>") & "|" & "<AlbumReceived>|" & "responseBrowsingAlbum&&&" & readCommand(1) & "&&&" & readCommand(2) & "&&&" & readCommand(3)
         Case "requestMyAlbum"
            If CWinsock.ClientType(index) = cloneDisplay Then
               CBrowse.SaveBrowseAlbum2Xml SlyVariable("<AlbumSend>")
               CWinsock.SendCopy WS_COPYTO, index, SlyVariable("<AlbumSend>") & "|" & "<AlbumReceived>|" & "responseAlbum&&&" & readCommand(1)
            Else         'If CWinsock.ItemType(Index) = independentMode Then
               CWinsock.Send2Client WS_COMMAND, index, "responseAlbum&&&" & readCommand(1) & "&&&" & CBrowse.getMyAlbum("", readCommand(2))
            End If
         Case "AlbumFromClient"
            CBrowse.AddClientAvailable SlyVariable("<AlbumPath>") & index & ".xml"
            If CWinsock.LoggedAs(independentServer) Then
               CWinsock.SendCopy WS_COPYTO, 0, SlyVariable("<MyAlbumServer>") & FileDelimiter & "<AlbumPath>" & CWinsock.clientIndex & ".xml" & FileDelimiter & "AlbumFromClient"
               'CWinsock.Send2Client WS_COMMAND, 0, "refreshClientAlbum&&&"
            Else
               CWinsock.Send2Client WS_COMMAND, 0, "refreshClientAlbum&&&"
            End If
            'CBrowse.boolAlbumChanged = True          ' no needs
            ' Copy to all clients
            'CWinsock.SendCopy WS_COPYTO, 0, SlyVariable("<MyAlbum>") & FileDelimiter & "<MyAlbumServer>" & FileDelimiter & "ServerAlbumRefresh&&&"
         Case "requestAlbumBar"           'For player page
            playSave = fso.BuildPath(App.path, "Player" & index & ".xml")
            GetPlayerAlbums.Save playSave
            CWinsock.SendCopy WS_COPYTO, index, playSave & FileDelimiter & "<Player>" & FileDelimiter & "responseAlbumBar"
         Case "requestTrackInfos"
            playSave = fso.BuildPath(App.path, "Player" & index & ".xml")
            SaveServerPlayList playSave, val(readCommand(1)), val(readCommand(2))
            CWinsock.SendCopy WS_COPYTO, index, playSave & FileDelimiter & "<Player>" & FileDelimiter & "responseTrackInfos"
         Case "SavePlayerTrack"
            playSave = fso.BuildPath(App.path, "Player" & index & ".xml")
            SaveServerPlayList playSave
            CWinsock.SendCopy WS_COPYTO, index, playSave & FileDelimiter & "<Player>" & FileDelimiter & "responseSavePlayerTrack&&&" & readCommand(1)
         Case "requestTrackInfo"
            CWinsock.Send2Client WS_COMMAND, index, "responseTrackInfo&&&" & savePlayInfo2Xml(readCommand(1), "Track").xml
         Case "requestTrackInfoForDownload"
            CWinsock.Send2Client WS_COMMAND, index, "responseTrackInfoForDownload&&&" & savePlayInfo2Xml(readCommand(1), "Track").xml
         Case "other"
            Select Case readCommand(1)
               Case "requestTrackCount"
                  SendRefreshTrack2Clients
               Case "requestSeek"
                  CWinsock.Send2Client WS_COMMAND, index, "setSeekTime&&&" & (CPlayer.Seeks + 0) & "&&&" & getPlayState
               
'''                  If playMusicWith = Winamp Then iLocalValue = 1 Else iLocalValue = 0
'''                  CWinsock.Send2Client WS_COMMAND, Index, "setSeekTime&&&" & (getCurrentDuration + iLocalValue) & "&&&" & getPlayState
               Case "requestTrackIndex"
                  CWinsock.Send2Client WS_COMMAND, index, "SelectPlayerTrack&&&" & int_current_index & "&&&" & str_current_Track
               Case "removeOneTrack"
                  If IndexSwf = 4 Then
                     sendToFlash Swf(4), "function", "RemoveOneTrack" & "|~|" & readCommand(2)
                  Else
                     RemovePlayerTrack val(readCommand(2))
                  End If
               Case "seekTrack"
                  miniCommand "seek|:|" & readCommand(2)
               Case "AddInternalTrack"
                  LoadPlayTrackFromXml
                  If b_play = False Then miniCommand "Play|:|true"
                  SendRefreshTrack2Clients
                  
               Case "removeAllTrack"
                  If IndexSwf = 4 Then
                     sendToFlash Swf(4), "function", "RemovekAllTrack"
                  Else
                     RemovePlayTrackAll
                  End If
                Case "requestBrowse"
                    ' CWinsock.Send2Client WS_COMMAND, Index, ""
                    CWinsock.Send2Client WS_COMMAND, 0, "server&&&0&&&function||StartBrowse|~|" & CallFlashFunction(Swf(0), "getBrowse2Path")
               Case "move"
                  If IndexSwf = 4 Then
                       sendToFlash Swf(4), "function", "move_track|~|" & readCommand(2) & "|~|" & readCommand(3)
                  Else
                     MoveTrack readCommand(2), readCommand(3)
                  End If
               Case "AddTracks"
                  Dim fileLists As String
                  fileLists = Replace(fso.OpenTextFile(SlyVariable("<Player>"), ForReading, False, TristateTrue).ReadAll, "?", Chr(0))
                  AddMusicToPlayer fileLists, readCommand(2)
               Case "AddFolder"
                  Dim ts As TextStream
                  Dim filePathName As String
                  Set ts = fso.OpenTextFile(SlyVariable("<Player>"), ForReading, False, TristateMixed)
                  filePathName = ts.ReadLine
                  While ts.AtEndOfLine = False
                     AddTrack2PlayerExternal filePathName
                     filePathName = ts.ReadLine
                  Wend
                  ts.Close
                  If IndexSwf = 4 Then
                      Dim lentrack As Integer
                      lentrack = UBound(PlayTrackInfo) + 1
                      sendVariable2Flash Swf(4), "PassTrackInfoLen", lentrack
                      sendVariable2Flash Swf(4), "OpenFrame", "true"
                  End If
                  CWinsock.Send2Client WS_COMMAND, 0, "server&&&4&&&function||setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index & "|~|false"
               Case "playMusicWith"
                  FunOptions readCommand(1), readCommand(2)
               End Select
         Case "AddPlayTrack"
            CWinsock.Send2Client WS_COPYTO, index, "<Player>|<Player>|other&&&AddInternalTrack"
         Case "client"
            Dim flashCommand() As String
            Dim flashIndex() As String
            Dim sendFlashIndex As Integer
            Dim j As Integer
            flashCommand = Split(readCommand(2), de_Field)
            flashIndex = Split(readCommand(1), ";")
            Select Case flashIndex(0)
            Case "IndexList"
               For j = 1 To UBound(flashIndex)
                  sendFlashIndex = flashIndex(j)
                  If sendFlashIndex = IndexSwf Or sendFlashIndex = 0 Then sendToFlash Swf(sendFlashIndex), flashCommand(0), flashCommand(1)
               Next
               sendFlashIndex = IndexSwf
            Case Else
               If flashIndex(0) = "IndexSwf" Then sendFlashIndex = IndexSwf Else sendFlashIndex = CInt(flashIndex(0))
               If sendFlashIndex = IndexSwf Or sendFlashIndex = 0 Then sendToFlash Swf(sendFlashIndex), flashCommand(0), flashCommand(1)
            End Select
        Case "fullscreenPlayer"
            tspl = Split(readCommand(1), "||")
            If str_swfNames = "Fullscreen" Then
                sendToFlash SWF_FMA(1), tspl(0), tspl(1)
            Else
                sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
                If (left(tspl(1), 43) = "control_mini_player|~|fn_key_changeLanguage") Then
                    change_language
                ElseIf (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                    temp_array = Split(tspl(1), "|~|")
                    numKeyPress temp_array(2)
                ElseIf (left(tspl(1), 37) = "control_mini_player|~|seek_fullscreen") Then
                    temp_array = Split(tspl(1), "|~|")
                    controllWinamp "seek", temp_array(2)
                End If
            End If
        Case "microPlayer"
            tspl = Split(readCommand(1), "||")
            If str_swfNames = "Micro" Then
                sendToFlash SWF_FMA(2), tspl(0), tspl(1)
            Else
                sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
                If (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                    temp_array = Split(tspl(1), "|~|")
                    numKeyPress temp_array(2)
                ElseIf (left(tspl(1), 32) = "control_mini_player|~|seek_micro") Then
                    temp_array = Split(tspl(1), "|~|")
                    'seek_micro temp_array(2)
                    miniCommand "seek" & "|:|" & temp_array(2)       'args
                End If
            End If
        Case "slideshow"
            tspl = Split(readCommand(1), "||")
            If LoadSlideshow = True Then
                sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
            Else
                sendToFlash FrmMain.Swf(IndexSwf), tspl(0), tspl(1)
                If (left(tspl(1), 36) = "control_mini_player|~|fn_selectTrack") Then
                    temp_array = Split(tspl(1), "|~|")
                    numKeyPress temp_array(2)
                ElseIf (left(tspl(1), 36) = "control_mini_player|~|seek_slideshow") Then
                    temp_array = Split(tspl(1), "|~|")
                    miniCommand "seek" & "|:|" & temp_array(2)
                ElseIf (left(tspl(1), 35) = "control_mini_player|~|ExitSlideShow") Or (left(tspl(1), 40) = "control_mini_player|~|seek_vol_slideshow") Then
                    temp_array = Split(tspl(1), "|~|")
                    frmSlideShow.exit_slideshow temp_array(2)
                End If
            End If
            
         Case "mini"
            tspl = Split(readCommand(1), "||")
            sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
            If (left(tspl(1), 32) = "control_mini_player|~|executeKey") Then
                temp_array = Split(tspl(1), "|~|")
                handleShortCutKey CLng(temp_array(2))
            End If
         Case "visualization"
             click_self = False
             cmdFull_Click
             click_self = True
         Case "fullscreen"
             click_self = False
             click_self = True
         Case "removeAllTracks"
            tspl = Split(readCommand(1), "||")
            If CInt(tspl(2)) = IndexSwf Then
               sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
            Else
               RemovePlayTrackAll
            End If
         Case "remove_track_one_by_one"
            tspl = Split(readCommand(1), "||")
            If CInt(tspl(2)) = IndexSwf Then
               sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
            Else
               temp_array = Split(tspl(1), "|~|")
               RemovePlayerTrack val(temp_array(1))
            End If
         Case "normal"
            tspl = Split(readCommand(1), "||")
            If CWinsock.LoggedType <> remotePlaylist And CWinsock.LoggedType <> independentMode Then
                If Len(tspl(2)) = 1 Then
                    If CInt(tspl(2)) = IndexSwf Then
                        sendToFlash Swf(CInt(tspl(2))), tspl(0), tspl(1)
                    End If
                End If
            End If
            If LoadSlideshow = True And tspl(2) = "slideshow" And b_AllowSlideshow Then
                sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
            ElseIf tspl(2) = "slideshow" Then
                CWinsock.Send2Client WS_COMMAND, 0, "normal&&&" & Replace(readCommand(1), "DisplayPictrue", "DisplayPicture_form_server")
            End If
         Case "syn"
            If change_vol = True Then
               tspl = Split(readCommand(1), "||")
               sendToFlash Swf(IndexSwf), tspl(0), tspl(1)
               
               If LoadSlideshow = True Then
                   'sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
               ElseIf str_swfNames = "Micro" Then
                   'sendToFlash SWF_FMA(2), tspl(0), tspl(1)
               Else
                   Dim d_arr() As String
                   If mID(tspl(1), 1, 43) = "control_syncronize|~|volume|~|ExitSlideShow" Then
                       d_arr = Split(tspl(1), "|~|")
                       frmSlideShow.exit_slideshow d_arr(3)
                       CWinsock.Send2Client WS_COMMAND, 0, "syn&&&" & readCommand(1)
                   ElseIf mID(tspl(1), 1, 40) = "control_syncronize|~|volume|~|executeKey" Then
                       d_arr = Split(tspl(1), "|~|")
                       handleShortCutKey CLng(d_arr(3))
                   End If
               End If
            Else
               CWinsock.Send2Client WS_COMMAND, 0, "syn&&&" & readCommand(1)
            End If
         Case "space_slideshow"
            If LoadSlideshow = True Then
                tspl = Split(readCommand(1), "||")
                sendToFlash frmSlideShow.SlideShow, tspl(0), tspl(1)
            Else
                CWinsock.Send2Client WS_COMMAND, 0, "space_slideshow&&&" & readCommand(1)
            End If
         '-------------------------------------
        ' for slideshow copy image from server
        '-------------------------------------
         Case "request_random"
            If b_AllowSlideshow Then
               CWinsock.Send2Client WS_COMMAND, index, "slideshow_random&&&" & SlideShowRandom
            End If
         Case "start_copy_xml_slideshow"
            If b_AllowSlideshow Then
               CWinsock.Send2Client WS_COMMAND, 0, "slideshow_random&&&" & SlideShowRandom
            End If
            If LoadSlideshow = True Then
                create_xml_image_slideshow_path currentSlideShowPath
            Else
                create_xml_image_slideshow_path get_current_slideshow
            End If
            CWinsock.SendCopy WS_COPYTO, index, xml_slideshow_path & FileDelimiter & readCommand(1) & FileDelimiter & "completed_copy_xml_slideshow"
            
        Case "copy_this_image"
            Dim source_path As String
            Dim destination_path As String
            Dim new_source_path As String
            Dim br As Boolean
            
            source_path = readCommand(1)
            destination_path = readCommand(2)
            br = (readCommand(3) = "True")
            
            If br = True Then
               new_source_path = fso.GetSpecialFolder(2) & "\temp_slideshow.jpg"
               If isFileExist(new_source_path) Then DeleteFile new_source_path
               create_new_image source_path, new_source_path, 50
               source_path = new_source_path
            End If
            
            If UBound(readCommand) = 3 Then
                CWinsock.SendCopy WS_COPYTO, index, source_path & FileDelimiter & destination_path & FileDelimiter & "completedCopyImageSlideshow"
            Else
                CWinsock.SendCopy WS_COPYTO, index, source_path & FileDelimiter & destination_path & FileDelimiter & "completedRedownload"
            End If
        '------------------------------
        ' for copy friend's playlist
        '------------------------------
        Case "request_friend_playlist"
            request_friend_playlist
        Case "request_copy_main_playlist"
            CWinsock.SendCopy WS_COPYTO, index, fso.GetSpecialFolder(2) & "\PlayLists.xml" & FileDelimiter & readCommand(1) & FileDelimiter & "completed_copy_playlists"
        Case "request_copy_all_playlists"
            copy_friend_playlists index, readCommand(1)
            
        Case "request_all_friend_playlists"
            CWinsock.Send2Client WS_COMMAND, index, "pass_computer_name&&&" & SlyNickName
        Case "request_copy_PlayListPath"
            CWinsock.SendCopy WS_COPYTO, index, App.path & "\sly\PlayListPaths.xml" & FileDelimiter & readCommand(1) & "\PlayListPaths.xml" & FileDelimiter & "completed_copy_PlayListPaths"
        Case "request_copy_PlayLists"
            tspl = Split(readCommand(1), "|||")
            CWinsock.SendCopy WS_COPYTO, index, tspl(0) & "\PlayLists.xml" & FileDelimiter & tspl(1) & "\PlayLists.xml" & FileDelimiter & "completed_copy_PlayLists"
        Case "request_copy_each_playlists"
            tspl = Split(readCommand(1), "|||")
            CWinsock.SendCopy WS_COPYTO, index, tspl(0) & FileDelimiter & tspl(1) & FileDelimiter & "completed_copy_each_playlists"
        
        Case "request_path_save_playlist"
            CWinsock.Send2Client WS_COMMAND, 0, "copy_save_playlist&&&" & readCommand(3) & "&&&" & save_new_playlist(readCommand(1), readCommand(2))
        Case "copy_save_playlist"
            CWinsock.SendCopy WS_COPYTO, index, readCommand(1) & FileDelimiter & readCommand(2) & FileDelimiter & "completed_copy_new_playlist"
        '------------------------------
        Case "request_login_type"
            If b_busy = False And b_deny = False Then
                If UBound(readCommand) = 8 Then
                    If user_sign_in_index = "" Or readCommand(2) = "" Then
                        If CInt(readCommand(1)) = CInt(num_display) Then
                            CWinsock.sendToServerNotConnected index, "receive_login_Type&&&" & type_login_display & "~" & type_login_playback & "~" & type_login_independent & "~" & store_list_index & "~" & type_login_remoteControl
                        Else
                            CWinsock.sendToServerNotConnected index, "receive_login_Type&&&" & type_login_display & "~" & type_login_playback & "~" & type_login_independent & "~0~" & type_login_remoteControl
                        End If
                    Else
                        
                        index_of_client_login = CInt(index)
                        num_display_client = CInt(readCommand(1))
                        
                        If readCommand(4) = store_user_login_name And readCommand(6) = store_user_login_pass Then
                            start_allow_client_connect all_permissions
                            sendVariable2Flash Swf(IndexSwf), "set_permission_connect", user_sign_in_index & "||" & user_sign_in_index & "||" & all_permissions
                        ElseIf readCommand(7) = "True" Then ' for used access password
                            start_allow_client_connect permission_access_password
                            sendVariable2Flash Swf(IndexSwf), "set_permission_connect", user_sign_in_index & "||" & readCommand(2) & "||" & permission_access_password
                        ElseIf readCommand(3) = "True" Then
                            CWinsock.sendToServerNotConnected index, "send_server_index&&&" & user_sign_in_index
                        Else
                            If b_default_permission Then
                                start_allow_client_connect str_permission
                            Else
                                display_allow_connect readCommand(2) & "::" & user_sign_in_index & "::" & readCommand(5)
                            End If
                        End If
                    End If
                End If
            Else
                If b_deny = True Then
                    CWinsock.sendToServerNotConnected index, "server_deny&&&true"
                Else
                    CWinsock.sendToServerNotConnected index, "server_busy&&&true"
                End If
            End If
            
        ' case other
        Case "click_minimize"
            click_self = False
            click_minimize
            click_self = True
        Case "keyPressed"
            If Not PressKeyInternalPlayer(readCommand(1), True) Then
               CWinsock.Send2Client WS_COMMAND, 0, "keyPressed" & de_Record & readCommand(1)
            End If
        Case "keyShortcut"
            ProcessKeyShortCut False, False, CDbl(readCommand(1))
            CWinsock.Send2Client WS_COMMAND, 0, "keyPressed" & de_Record & readCommand(1)
'            Debug.Print readCommand(1) & "::::"
        End Select
   Else
      CWinsock.SendCopy dataCommand, index, dataReceived
   End If
   Exit Sub
ErrorHandler:
   'WriteEvent "ReceivedServer in " & UCase(readCommand(0)), Err.Description, Err.Source
   Writelog "ReceivedServer", "ERROR", Err.Description, "Index = " & index & ", dataCommand= " & dataCommand & ", dataReceived = " & dataReceived

End Sub


Private Sub sckClient_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
   On Error GoTo Error
   
   Dim loc_LastMode As EnumPlayListMode
   
   sckClient.Close
   run_bRequestConnecting = False
   loc_LastMode = CWinsock.LoggedType
   CWinsock.LoggedType = ServerMode
   CWinsock.serverID = ""    'Set to nothing
   sendToFlash Swf(IndexSwf), "not_connected", "true"
   sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
   If loc_LastMode <> ServerMode Then reinput_to_playlist
   If IndexSwf = 0 Then
       sendToFlash Swf(0), "not_connected", "true"
       sendToFlash Swf(0), "clientType", CWinsock.LoggedType
   End If
   ReDim EncodingQueue(-1 To -1)         ' clear download queue
   check_status
   user_sign_in_index = ""
   
   Exit Sub
Error:
   WriteEvent "sckClient_Error", Err.Description, Err.Source
End Sub

Private Sub sckClient_SendComplete()
   CWinsock.SendComplete 0
End Sub
Private Sub sckServer_SendComplete(index As Integer)
   CWinsock.SendComplete index
End Sub
Private Sub sckServer_Close(index As Integer)
   On Error GoTo Error
   If CWinsock.ClientType(index) <> notConnected Then       'Only show popup disconnect when client connected to server
      popup_connected CWinsock.ClientNickName(index) & "%%" & CWinsock.ClientType(index), False
   End If
   CWinsock.Closes index
   
   If Not denyConnection Then check_status 'if the disconnect is not a deny connection from server then check
   denyConnection = False
   Exit Sub
Error:
   WriteEvent "sckServer_Close", Err.Description, Err.Source
End Sub

Private Sub sckServer_ConnectionRequest(index As Integer, ByVal requestID As Long)
   Dim iRegKeyType As RegisterEnum
   iRegKeyType = GetRegisterKeyType
   
   'Only available when It's RegisterAsLinkingServer,RegisterAsRemoteControl
   If iRegKeyType = RegisterAsLinkingServer Or iRegKeyType = RegisterAsRoomServer Or iRegKeyType = NotRegistered Then
      CWinsock.ConnectionRequest requestID
   End If
   
'''   If iRegKeyType = RegisterAsLinkingServer Or iRegKeyType = RegisterAsRoomServer Then
'''      CWinsock.ConnectionRequest requestID
'''   End If
End Sub
Private Sub sckClient_DataArrival(ByVal bytesTotal As Long)
   On Error GoTo Error
   Dim dataReceived As String
   Dim eachData As String
   Dim startPos As Integer
   Dim returnDataType As CommandType
   
   dataReceived = CWinsock.ReadDataFromWinsock(sckClient)
   
   
   startPos = 1
   If dataReceived <> vbNullString Then
      Do
        
         If returnDataType.DataLength >= 0 Then  'this statement add by muny
        
            returnDataType = GetCommandAndDataLength(mID(dataReceived, startPos, 3))
            If returnDataType.Commands = WS_COMMAND Or returnDataType.Commands = WS_REQUESTING Then
               eachData = StrConv(mID(dataReceived, startPos + 3, returnDataType.DataLength), vbFromUnicode)
            ElseIf returnDataType.Commands <= WS_COPYNOTFOUND Then
               eachData = mID(dataReceived, startPos + 3, returnDataType.DataLength)
            Else
               Exit Do
            End If
            'Execution to be occurred==================================
               ReceivedClient returnDataType.Commands, eachData
            '==========================================================
            startPos = startPos + returnDataType.DataLength + 3         '  4 equal to header
            
         Else
            Exit Do
         End If
         
      Loop Until startPos >= Len(dataReceived)
   End If
   Exit Sub
Error:
   WriteEvent "sckClient_DataArrival", Err.Description, Err.Source
End Sub
Private Sub sckServer_DataArrival(index As Integer, ByVal bytesTotal As Long)
   Dim dataReceived As String
   Dim eachData As String
   Dim startPos As Integer
   Dim returnDataType As CommandType
   
   dataReceived = CWinsock.ReadDataFromWinsock(sckServer(index))
   
   startPos = 1
   If dataReceived <> vbNullString Then
      Do
      
          If returnDataType.DataLength >= 0 Then  'this statement add by muny
          
             returnDataType = GetCommandAndDataLength(mID(dataReceived, startPos, 3))
             If returnDataType.Commands = WS_COMMAND Or returnDataType.Commands = WS_REQUESTING Then
                eachData = StrConv(mID(dataReceived, startPos + 3, returnDataType.DataLength), vbFromUnicode)
             ElseIf returnDataType.Commands <= WS_COPYNOTFOUND Then
                eachData = mID(dataReceived, startPos + 3, returnDataType.DataLength)
             Else
                Exit Do
             End If
             'Execution to be occurred==================================
    '            Debug.Print eachData
    
                ReceivedServer index, returnDataType.Commands, eachData
             '==========================================================
             startPos = startPos + returnDataType.DataLength + 3         '  4 equal to header
             'DoEvents
        
         Else
            Exit Do
         End If
        
      Loop Until startPos >= Len(dataReceived)
   End If
End Sub

Private Sub sckServer_Error(index As Integer, ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
   If sckServer(index).State = sckError Then
      CWinsock.Closes index, True
      popup_connected CWinsock.ClientNickName(index) & "%%" & CWinsock.ClientType(index), False
   End If
   check_status
   
End Sub



Public Sub SWF_FMA_FSCommand(index As Integer, ByVal command As String, ByVal args As String)
   On Error GoTo Error
   'Debug.Print "SWF_FMA_FSCommand, Command = " & command & " ; args=" & args
   Select Case command
      Case "NextPrevious"
         If args = "Next" Then
            GotoTrack True
         ElseIf args = "Previous" Then
            GotoTrack False
         End If
      Case "BookmarkCurrentTime"
        If b_play Then          'no need to send to server and display the same page
            'sendToFlash FrmMain.Swf(IndexSwf), "SaveBookMark", PlayTrackInfo(int_current_index).MainTitle & de_Field & seekTimeValue & de_Field & Player_GetCurrentChapter
            sendToFlash FrmMain.Swf(IndexSwf), "SaveBookMark", PlayTrackInfo(int_current_index).MainTitle & de_Field & seekTimeValue & de_Field & CPlayer.currentChapter
            If swfMiniControl.Visible Then
               swfMiniControl.SetVariable "vb", "lostFocus"
               Swf(IndexSwf).SetFocus
            End If
            
        End If
      Case "popup"
           popUp True
      Case "mini"
           handleMinicommand args
       Case "clients"
          If CWinsock.LoggedType <> ServerMode Then CWinsock.Send2Server WS_COMMAND, args
       Case "getServerData"
          If CWinsock.LoggedType <> ServerMode Then CWinsock.Send2Server WS_COMMAND, command & de_Record & args
       Case "other"
          If CWinsock.LoggedType <> ServerMode Then CWinsock.Send2Server WS_COMMAND, command & de_Record & args
       Case "servers", "Command"
          If CWinsock.LoggedType = ServerMode Then CWinsock.Send2Client WS_COMMAND, 0, args
      Case "FullScreen"
        Call click_for_chage_visualization("fullscreen_visual", False)
        scale_visualization_to_fullscreen (bool_full_vis)
        Exit Sub
    End Select
    
    Select Case index
        Case 1  'Fullscreen
            If str_swfNames = "Micro" Then
                SWF_FMA(2).SetFocus
                index = 2
            End If
        
            Select Case command
                Case "getAudio"
                    'sendVariable2Flash SWF_FMA(1), "audio", audioString
                    MsgBox "getaudio"
                Case "getSubtitle"
                    'sendVariable2Flash SWF_FMA(1), "subtitle", subTitleString
                    MsgBox "getSubtitle"
                Case "getChapter"
                     If int_track_count > 0 Then
                        sendVariable2Flash SWF_FMA(1), "chapter", GetChapterFromMovie(PlayTrackInfo(int_current_index).TrackID, PlayTrackInfo(int_current_index).Language, CPlayer.chapterCount)
                     End If
                    MsgBox "getChapter"
                
                Case "select_audio"
                    'CMediaPlayer.AudioLanguage CInt(args)
                    MsgBox "Select audio  "
                Case "select_subtitle"
                     AddCommand "miniCommand", args, ""
                Case "keySelectChapter"
                    keySelectChapter args, GetChapterFromMovie(PlayTrackInfo(int_current_index).TrackID, PlayTrackInfo(int_current_index).Language, CPlayer.chapterCount)
                Case "select_chapter"
                  MsgBox "select_chapter"
'''                    Dim splitJump() As String
'''                    splitJump = Split(args, "||")
'''                    If int_track_count > 0 Then
'''                       If StrComp(fso.GetExtensionName(PlayTrackInfo(int_current_index).TrackPath), "ifo", vbTextCompare) = 0 Then
'''                          CMediaPlayer.JumpToChapter splitJump(0), ""
'''                       Else
'''                          CMediaPlayer.JumpToChapter splitJump(0), val(splitJump(1))
'''                       End If
'''                    End If
                Case "karaoke_voice"
                    karaokeVoice
                Case "new_request_permission"
                    str_permission = args
                    EditSetting MainSettingXML, 0, "permission", str_permission
       
                Case "not_show_again"
                    b_default_permission = True
                    EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
                    b_deny = False
                    EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
                    
                Case "auto_allow"
                    start_allow_client_connect str_permission
                Case "deny"
                    FrmMain.server_deny
                Case "start_allow_connect"
                    FrmMain.start_allow_client_connect args
                Case "allow_login_permission"
                    FrmMain.receive_permission_from_PHP args
                    FrmMain.send_login_type_to_client
                Case "vis"
                     MsgBox "vis"
'''                  If args = "next" Then
'''                     MediaPlayer.NextVisualization
'''                  ElseIf args = "previous" Then
'''                     MediaPlayer.PrevVisualizatoin
'''                  ElseIf args = "full" Then
'''                     scale_visualization_to_fullscreen (bool_full_vis)
'''                  End If
                  
                Case "selectTrack"
                    numKeyPress args
                    
                Case "displayFullscreen"
                    
'                    Dim curInd As Long
                    
                    
                    oneByOneTheme SWF_FMA(1), "textDisplay", strCurrent
                    oneByOneTheme SWF_FMA(1), "img_current", strImgCurrent
                    
                    If Infos(int_current_index).TrackLan = "English" Then
                        If (PlayTrackInfo(int_current_index).TrackAva = 0 And PlayTrackInfo(int_current_index).Mode = "Internal") Then
                            sendToFlash SWF_FMA(1), "sampleSong", True
                        Else
                            sendToFlash SWF_FMA(1), "sampleSong", False
                        End If
                    End If
                    
                    If s_display_type = "Visual" Then
                        Resize_Visualization formWidth, formHeight
                        picwmp.ZOrder 0
                        picwmp.Visible = True
                        CPlayer.Visible = True
                        CPlayer.UiMode = "None"
                        
                        oneByOneTheme SWF_FMA(1), "img_Next", ""
                        oneByOneTheme SWF_FMA(1), "img_Previous", ""
                    Else
                        oneByOneTheme SWF_FMA(1), "img_Next", strImgNext
                        oneByOneTheme SWF_FMA(1), "img_Previous", strImgPrevious
                    End If
                    
                    'popUp CWmp
                    'sendToFlash FrmMain.SWF_FMA(1), "TrackShow", str_infoPopup
                    sendToFlash FrmMain.SWF_FMA(1), "default", str_infoPopup
                    sendToFlash SWF_FMA(1), "show_x", CStr(popup_exit)
                    
                    SWF_FMA(1).Visible = True
                    SWF_FMA(1).SetFocus
                    
                    sendToFlash Swf(0), "hideMiniPlayer", True
                    If IndexSwf = 4 Then
                       sendToFlash Swf(4), "hideMiniPlayer", True
                    End If
                    
                    If IsRegistered = False Then
                        If Swf(12).Visible = True Then Swf(12).ZOrder 0
                    End If
                    
                    ''''''''2006-12-16 Seng
                    MovePlayingImage
                Case "trackLocation"
                    setTrackLocation (args)
                    
                Case "buyCD"
                    If int_track_count > 0 Then
                        If Infos(int_current_index).trackAlbumID <> "" Then
                            PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args, Infos(int_current_index).TrackLan
                        End If
'''                        If playMusicWith = WindowMedia Then
'''                           If Infos(int_current_index).trackAlbumID <> "" Then
'''                               PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args, Infos(int_current_index).TrackLan
'''                           End If
'''                        ElseIf playMusicWith = Winamp Then
'''                           If Infos(int_current_index).trackAlbumID <> "" Then
'''                               PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args, Infos(int_current_index).TrackLan
'''                           End If
'''                        End If
                    End If
                Case "showShopping"
                    If int_track_count > 0 Then
                        If Infos(int_current_index).trackAlbumID <> "" Then
                            If Infos(int_current_index).TrackLan = "English" Then
                                sendToFlash SWF_FMA(1), "showShopping", GetEnableAlbumASIN(Infos(int_current_index).trackAlbumID, Infos(int_current_index).TrackLan)
                            ElseIf Infos(int_current_index).trackExternal = False Then
                                PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan, Infos(int_current_index).TrackLan
                            End If
                        End If
                    End If
                Case "timeLocation"
                    EditSetting MainSettingXML, 2, "timeLocation", args
                Case "clearTimeSlideshow"
                    interValCount = 0
                Case "KeyPressed"
                    interValCount = 0
                Case "Visualization"
                '' do not allow change fullscreen - sith 18-12-06
''                    If str_swfNames = "Fullscreen" Then
''                        change_visualization_type
''                        theme SWF_FMA(1)
''                        sendToFlash SWF_FMA(1), "displayFullscreen", "true"
''                    End If
                Case "setHideMouse"
                    setHideMouse args
                Case "changeWindow"
                    bool_full_vis = False
                    If str_swfNames = "Fullscreen" Then
                        If WinMode = "FullScreen Mode" Then
                            WinMode = "Window Mode"
                        Else
                            WinMode = "FullScreen Mode"
                        End If
                        tmpchangeWindow = True
                    End If
                Case "offScreen"
                    SetCursorPos ScreenX, ScreenY / 2
                Case "SHFull"
                    If str_swfNames = "Fullscreen" Then
''                        Dim tt As Boolean
''                        If b_play = False Then
''                            tt = True
''                            b_play = True
''                        End If
''                           sendVariable2Flash swf(IndexSwf), "CtrlKey", "false"
''                        If tt = True Then
''                            tt = False
''                            b_play = False
''                        End If
                        loadFlashFullScreen False
                    End If
                Case "Play"
                    miniCommand "Play" & "|:|" & args
                Case "Pause"
                    miniCommand "Pause" & "|:|" & args
                Case "Stop"
                    miniCommand "Stop" & "|:|" & args
                Case "Previous"
                    miniCommand "Previous" & "|:|" & args
                Case "Next"
                    miniCommand "Next" & "|:|" & args
                Case "SetSlideShow"
                    If args = "Yes" Then
                        tmrSlideShow.Interval = 1000
                        b_slideshow = True
                    Else
                        tmrSlideShow.Interval = 0
                        b_slideshow = False
                    End If
                    
                    If str_swfNames = "Fullscreen" Then
                       oneByOneTheme SWF_FMA(1), "slideShow", CStr(b_slideshow)
                       'sendToFlash swfDVDControl, "slideShow", CStr(b_slideshow)
                    End If
                    If str_swfNames = "Micro" Then sendVariable2Flash SWF_FMA(2), "slideshow", CStr(b_slideshow)
                    
                    EditSetting MainSettingXML, 1, "SetSlideShow", args
                    SplitSly = ReplaceStrSpl(FrmMain.SplitSly, 1, args, "~")
                    If IndexSwf = 6 Then
                        sendVariable2Flash Swf(6), "GetColorReady", "true"
                        sendVariable2Flash Swf(6), "SetSlideShowValue", "true"
                        sendVariable2Flash Swf(6), "OpenFrame", "true"
                    End If
                Case "Loop"
                    miniCommand "Repeat" & "|:|" & args
                Case "Shuffle"
                    miniCommand "Shuffle" & "|:|" & args
                Case "Mute"
                    miniCommand "Mute" & "|:|" & args
                Case "Volume"
                    miniCommand "Volume" & "|:|" & args
                Case "seek"
                    miniCommand "seek" & "|:|" & args ' temp_array(2)
                    'seek_fullscreen args
                Case "ScanFile"
                    If (Dir(args) <> "") Then
                        oneByOneTheme SWF_FMA(1), "img_back", "true"
                    Else
                        oneByOneTheme SWF_FMA(1), "img_back", "false"
                    End If
                Case "Playlist"
                    swf_FSCommand IndexSwf, "ShowPlayListPlayer", ""
                Case "MoreFile"
                    miniCommand "AddMusic" & "|:|" & "True"
                Case "ChangeLanguage"
                    If Language = "Eng" Then
                        Language = "Uni"
                    Else
                        Language = "Eng"
                    End If
                    changeEngUni
                    EditSetting MainSettingXML, 0, "Language", args
                    SplitColor = ReplaceStrSpl(SplitColor, 13, args, "~")
                    sendVariable2Flash Swf(IndexSwf), "combind_key_Unicode", "true"
                Case "Minimize"
                    swf_FSCommand 0, "Minimize", True
                Case "mb"
                    
                    Debug.Print args
            End Select
        Case 2  'Micro
            
            Select Case command
            
                Case "cmd_max"
                    'cmd_max.Visible = args = "true"
                Case "UpSize"
                    frmOver.tmr_close_mouse_over_Timer
                    pressKeyResizeMicro True
                    moveInScreen FrmMain, FrmMain.left, FrmMain.top, ScreenX, ScreenY
                Case "DownSize"
                    frmOver.tmr_close_mouse_over_Timer
                    pressKeyResizeMicro False
                    moveInScreen FrmMain, FrmMain.left, FrmMain.top, ScreenX, ScreenY
                Case "clearTimeSlideshow"
                    interValCount = 0
                Case "selectTrack"
                    numKeyPress args
                Case "executeKey"
                    handleShortCutKey CLng(args)
                Case "buyCD"
                  If CPlayer.chapterCount > 0 Then
                      If Infos(int_current_index).trackAlbumID <> "" Then
                          PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan & "~" & args, Infos(int_current_index).TrackLan
                      End If
                  End If
                Case "showShopping"
                    If int_track_count > 0 Then
                        If Infos(int_current_index).trackAlbumID <> "" Then
                            If Infos(int_current_index).TrackLan = "English" Then
                                frmPopup.scalePopupInfo True
                                frmPopup.Timer1.Enabled = False
                                sendToFlash frmPopup.Swf(1), "showShopping", GetEnableAlbumASIN(Infos(int_current_index).trackAlbumID, Infos(int_current_index).TrackLan)
                            ElseIf Infos(int_current_index).trackExternal = False Then
                                PurchaseCDAlbum Infos(int_current_index).trackAlbumID & "~" & Infos(int_current_index).TrackLan, Infos(int_current_index).TrackLan
                            End If
                        End If
                    End If
                Case "Play"
                    miniCommand "Play" & "|:|" & args
                Case "Pause"
                    miniCommand "Pause" & "|:|" & args
                Case "Stop"
                    miniCommand "Stop" & "|:|" & args
                Case "Previous"
                    miniCommand "Previous" & "|:|" & args
                Case "Next"
                    GetCursorPos tmpMousePosition
                    miniCommand "Next" & "|:|" & args
                Case "SlideShow"
                    SWF_FMA_FSCommand 1, "SetSlideShow", args
                Case "Loop"
                    miniCommand "Repeat" & "|:|" & args
                Case "Shuffle"
                    miniCommand "Shuffle" & "|:|" & args
                Case "Mute"
                    miniCommand "Mute" & "|:|" & args
                Case "Volume"
                    miniCommand "Volume" & "|:|" & args
                Case "seek"
                    'seek_micro args
                    miniCommand "seek" & "|:|" & args
                Case "MouseOver"
                    'boolLooping = True
                    'frmOver.showMe
                Case "Maximize"
                  If str_swfNames = "Micro" Then
                     handleMinicommand "Micro2Normal|:|true"
                  End If
                Case "MoveMicro"
                    frmOver.hideMe
                    Call ReleaseCapture
                    Call SendMessage(hwnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&)
                    If lng_leftMicro <> Me.left Or lng_topMicro <> Me.top Then
                       moveMicro FrmMain, FrmMain.left, FrmMain.top
                       sendToFlash SWF_FMA(2), "Move", True
                    Else
                       sendToFlash SWF_FMA(2), "Move", False
                    End If
                Case "karaoke_voice"
                  karaokeVoice
                Case "mb"
                    Debug.Print args
            End Select
        Case 3  'Ads
            Select Case command
                Case "micro"
                    FrmMain.SetFocus
                    SWF_FMA(2).SetFocus
                Case "mb"
                    Debug.Print args
            End Select
    End Select
    Exit Sub
Error:
   WriteEvent "SWF_FMA_FSCommand Index = " & index & ", Command = " & command & ", Argument = " & args, Err.Description, Err.Source
End Sub
Public Sub swf_FSCommand(index As Integer, ByVal command As String, ByVal args As String)
   On Error GoTo Error
   Dim i As Long
   Dim boolLanguageChanged As Boolean
   Dim SplSearchAlbum2() As String
   Dim val_Local As String
   'Debug.Print "Index = " & Index & "; " & command & args
   'Writelog "swf_FSCommand Index = " & Index, "EVENT", "On Event", "command = " & command & ", args= " & args
If index = 12 Then
    If command = "Starting" Then
         b_loadAlready = True
         #If Server = 1 Then
            CWinsock.Listen
         #End If
        run_ShowLoading = False
        If Swf(12).Visible = True Then
            Swf(12).Visible = False
            swf_FSCommand 1, "Starting", "true"
            If b_DefaultLoadType = 1 Then
               'while done
               Call click_for_chage_visualization("fullscreen_visual", False)
               scale_visualization_to_fullscreen (bool_full_vis)
            End If
            If b_DefaultAutoConnect Then
               run_bRequestConnecting = True
               swf_FSCommand 1, "login", s_DefaultParameter
            End If
            
        End If
    End If
End If
'...........Load country.............................
'If command = "KeyPressed" Then Debug.Print args

' Debug.Print command
  'If command <> "KeyPressed" Then Debug.Print command
   On Error Resume Next
   Dim stSpl() As String
   Dim spl() As String
   Dim strAll As String
   Dim lentrack As Integer
   Dim lenArtist As Integer
   Dim stArtist As String
   Dim lenRe As Variant
   Dim tmpBrowse As String
   
'    Debug.Print command
   
Select Case command
    Case "ShowTextUnicode"
        If args = "No" Then
            txtSearchUnicode.Visible = False
            clsKeyboard.SetKeyBoardLanguage "English"
        ElseIf args = "Yes" Then
            txtSearchUnicode.SetFocus
            clsKeyboard.SetKeyBoardLanguage IIf(Language = "Eng", "English", currentCountry)
        Else
            TextScaleSize txtSearchUnicode, Swf(IndexSwf), args
            clsKeyboard.SetKeyBoardLanguage IIf(Language = "Eng", "English", currentCountry)
        End If
   Case "CodeID"
      If CWinsock.LoggedType = remoteControl Then
         CWinsock.Send2Server WS_COMMAND, "AddTrackByKey&&&" & args
      Else
         AddTrackByKey args
      End If
      Exit Sub
   Case "MusicNote"
      'seng............
      MusicNoteValue = args
      SplitColor = ReplaceStrSpl(SplitColor, 24, args, "~")
      sendToFlash Swf(IndexSwf), "setMusicNote", MusicNoteValue
      sendToFlash Swf(0), "setMusicNote", MusicNoteValue
      Exit Sub
   Case "ShowRipCD"
        frmRip.LoadEncodeCD index, args
        If frmRip.Visible = False Then
            FrmMain.SetFocus
            Swf(IndexSwf).SetFocus
        End If
   Case "onFocus"
      If swfMiniControl.Visible Then swfMiniControl.SetVariable "vb", "lostFocus"
   Case "VisibleIconAlbum"
      b_ShowCoverIcon = CBool(args)
      EditSetting MainSettingXML, 0, "VisibleIconAlbum", LCase(b_ShowCoverIcon)
   Case "AutoPlayEnabled"
      AutoPlayEnabled = LCase(args) = "true"
   Case "AutoPlayMPC"
      AutoPlayMPC = LCase(args) = "true"
   Case "AutoPlayPowerDVD"
      AutoPlayPowerDVD = LCase(args) = "true"
   Case "SearchAvailableType"
      spl = Split(args, "~")
      sendToFlash Swf(index), "SearchAvailableType", SearchAvailableType(spl(0), spl(1))
   Case "setSeekOffset"
      stSpl = Split(args, "~")
      If stSpl(1) <> "" Then SetTrackField stSpl(0), "SeekOffset", stSpl(1), stSpl(2)                         'Save seek offset
      Exit Sub
   Case "ShowScan"
      frmScan.showMe
      Exit Sub
   Case "offsetEnabled"
      setEnableSeekOfsset = LCase(args) = "true"
      EditSetting MainSettingXML, 0, "EnableSeek", LCase(setEnableSeekOfsset)
   Case "BrowseChapterPath"
      spl = Split(args, "%~%")
      With cdl
         .InitDir = InitDir                        'Set to starting directory
         .flags = 4
         .filename = ""
         .filter = WinampPlayableFilter        'IFO is not included
         .ShowOpen Me.hwnd
         If .filename <> "" Then
            SetTrackPath(val(spl(0)), spl(1)) = .filename
            RefreshAlbumAvailableToServer
            InitDir = fso.GetParentFolderName(.filename)             'save last browse folder
         End If
      End With
      Exit Sub
   Case "ChangeTrackTitleStyle"
      i_ShowUnderTrackTitle = val(args)
   Case "playchapterFile"                   'play till end or play only current chapter
      playChapterType = args = "True"
      EditSetting MainSettingXML, 0, "playchapterFile", playChapterType
      If b_loadAlready Then sendToFlash Swf(0), "PlayChapterState", playChapterType
   Case "playAudioChannel"
      run_iGlobalAudioChannel = val(args)
      If b_loadAlready Then sendToFlash Swf(0), "AudioChannel", CStr(run_iGlobalAudioChannel)
      
   Case "databaseType"
      'CBrowse.databaseType = val(args)
   Case "Main Title"
      spl = Split(args, "~")
      If IsNumeric(spl(1)) Then
         If spl(1) <> "" Then SetAlbumField spl(0), "MainTitle", spl(1), spl(2)
      End If
      
   Case "FullScreenPlayer"
      b_DefaultLoadType = 1
      If b_loadAlready Then scale_visualization_to_fullscreen False
   Case "ShowHidePlayer"
      show_hide_player = (args = "true")
   Case "ShowBookmark"
      run_ShowingBookmark = args = "true"
      If show_hide_player = False Then UnloadSwfMiniControl
   Case "flashUpdateFromLocalNetwork"
      spl = Split(args, "&&&")
      swf_FSCommand 0, "UpdateDBLocalGoToLanguagePage", spl(0)
      CBrowse.CloseAllDatabase                  'Close using database
      run_bUpdating = True
      DownloadLocalNetwork spl(0), spl(1)
      run_bUpdating = False
      sendVariable2Flash Swf(1), "CompletedUpdate", "true"
      Exit Sub
   Case "SaveBookMark"
      spl = Split(args, "||")
      AddBookMark2Default spl(0), spl(1), spl(2), spl(5), spl(3) = "true", spl(4), spl(6), spl(7), spl(10), spl(9), spl(8)
   Case "RequestChapterTypeAndAudio"
      sendToFlash Swf(args), "PlayChapterState", playChapterType
      sendToFlash Swf(args), "AudioChannel", CStr(run_iGlobalAudioChannel)
   Case "LoadSwfMiniControl"
      LoadSwfMiniControl
      swfMiniControl.SetFocus
      If args = "_level0.play_mc._mc" Then                  'When pause is not visible must select play button
         If b_pause = False Then args = "_level0.pause_mc._mc"
      ElseIf args = "_level0.pause_mc._mc" Then
         If b_pause = True Or b_play = False Then args = "_level0.play_mc._mc"
      End If
      ' _level0.pause_mc._mc
      If CWinsock.LoggedType = remoteControl Or picMini.Visible Then swfMiniControl.SetVariable "vb", "setFocus|%|" & args
   Case "key_arrow_control"
      LoadSwfDvdControl
   Case "karaoke_voice"
      karaokeVoice
   Case "SetSlideShowPath"
      Dim ttt As String
      If args <> "" Then
         ttt = BrowseForFolder(args, hwnd)
      Else
         ttt = BrowseForFolder(browse_slideshow, hwnd)
      End If
      If ttt <> "" Then
         browse_slideshow = ttt
         EditXML MainSettingXML, 0, "browse_slideshow", browse_slideshow
         sendVariable2Flash Me.Swf(index), "PassSlidePathValue", browse_slideshow
         sendVariable2Flash Me.Swf(index), "OpenFrame", "true"
      Else
         sendVariable2Flash Me.Swf(index), "PassSlidePathValue", args
         sendVariable2Flash Me.Swf(index), "OpenFrame", "true"
      End If
   Case "new_request_permission"
       str_permission = args
       EditSetting MainSettingXML, 0, "permission", str_permission
       
   Case "not_show_again"
       b_default_permission = True
       EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
       b_deny = False
       EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
       
   Case "auto_allow"
       start_allow_client_connect str_permission
   Case "deny"
       server_deny
   Case "start_allow_connect"
        start_allow_client_connect args
   Case "allow_login_permission"
      receive_permission_from_PHP args
      send_login_type_to_client
   Case "exit_application"
      login_name = ""
      miniCommand "Stop" & "|:|" & True
      Timer2.Enabled = True
      bExitingProgram = True
   Case "GetArtistTrackInfo"
      Dim spvar() As Variant
      spl = Split(args, "~")
      spvar = GetAlbumFields(spl(0), spl(1), "MainTitle", "CoverType")
      sendVariable2Flash Swf(index), "GetTrailerAvailable", GetAlbumTrailerAva(spl(0), spl(1))
      sendVariable2Flash Swf(index), "GetMainTitle", spvar(0)          '2005-11-02
      sendVariable2Flash Swf(index), "GetArtistTrackInfo", GetTracksByAlbum(spl(0), spl(1))
      sendVariable2Flash Swf(index), "PlayFileFrom", SearchAvailableType(spl(0), spl(1))
      sendVariable2Flash Swf(index), "CoverType", val(spvar(1))
      If IndexSwf = 4 Then
         sendVariable2Flash Swf(IndexSwf), "databaseType", SlyVariable("<" & spl(1) & "_id>")
      End If
'            PlayFileFrom
      currentAlbumID = spl(0)
      sendVariable2Flash Swf(index), "OpenFrame", "true"
      sendToFlash Swf(index), "PlayChapterState", playChapterType
      sendToFlash Swf(index), "AudioChannel", CStr(run_iGlobalAudioChannel)
      MoveCursorTheSamePos
      Exit Sub
   Case "ChangeLanguage"
      If IndexSwf = 4 And Language <> args Then txtSearchUnicode.Text = ""
      Language = args
      EditSetting MainSettingXML, 0, "Language", args
      SplitColor = ReplaceStrSpl(SplitColor, 13, args, "~")
      If index <> 0 Then
         sendVariable2Flash Swf(0), "ChangeLanguage", args
         sendVariable2Flash Swf(0), "OpenFrame", "true"
      End If
      'miniCommand "changeLanguage|:|" & language
      handleMinicommand "changeLanguage|:|" & Language
      Exit Sub
   Case "PlayTrack"
      pathTrackID = args
      Exit Sub
      'pathTrackName = getMoviePathAndSample(args)  //seng 2005-08-30 useless
   Case "popup"
       popUp True
   Case "mouse_off_screen"
        If IndexSwf <> 2 And Settings.WinMode <> "Window Mode" Then
            SetCursorPos ScreenX, ScreenY / 2
        End If
   Case "self_key_press"
      click_self = args = "true"
   Case "mb"
      Debug.Print args
      Exit Sub
   Case "mini"
      Dim str() As String
      str = Split(args, "|:|")
      If str(0) = "Next" And int_next_index = -1 Then int_next_index = 0
      
      handleMinicommand args
      Exit Sub
   Case "client"
      If CWinsock.LoggedType <> ServerMode Then
         CWinsock.Send2Server WS_COMMAND, command & de_Record & args
      End If
   Case "getServerData"
      If CWinsock.LoggedType <> ServerMode Then
         CWinsock.Send2Server WS_COMMAND, command & de_Record & args
      End If
   Case "requestFirstPlay"
      boolFirstLogged = True
   Case "other"
      If CWinsock.LoggedType <> ServerMode Then
         CWinsock.Send2Server WS_COMMAND, command & de_Record & args
      End If
   Case "server", "Command"
      If CWinsock.LoggedType = ServerMode Then
         CWinsock.Send2Client WS_COMMAND, 0, command & de_Record & args
      End If
   Case "switch_mode"
      '''''''''''''''.................
      If (GetRegisterKeyType = RegisterAsRoomServer And val(args) <> independentMode) Or (GetRegisterKeyType = RegisterAsRemoteControl And val(args) <> remoteControl) Then
         'if it is room server don't connect
         sendToFlash Swf(IndexSwf), "not_connected", "true"
         sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
         Popup_Dialog "Access Denied", "You can't siwtch to this type"

         Exit Sub
      End If
      
      CWinsock.LoggedType = CInt(args)
      CWinsock.Send2Server WS_COMMAND, "Request&&&" & args & "&&&" & SlyNickName & "&&&1&&&" & CWinsock.connectName
      
   Case "server_display"
      sendToFlash Swf(0), "Click", args
   Case "server_display_micro"
      sendToFlash Swf(IndexSwf), "fscommand", "Minimize"
   Case "server_display_fullscreen"
      sendToFlash Swf(IndexSwf), "fscommand", "FullScreenPlayer"
   Case "clients"
      If CWinsock.LoggedType <> ServerMode Then
         CWinsock.Send2Server WS_COMMAND, args
      End If
      Exit Sub
   Case "servers", "Commands"
      If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentServer) Then
         CWinsock.Send2Client WS_COMMAND, 0, args
      End If
      Exit Sub
   Case "displayPopupTrackInfo"
      popUp
      Exit Sub
   Case "requestDownloadState"
      CopyingSong = CopyingSong
   Case "savePlayTrack"
      CreatePlayerXML args, SlyVariable("<PlayerSend>")
      CWinsock.SendCopy WS_COPYTO, 0, "<PlayerSend>|<Player>|other&&&AddInternalTrack"
   Case "saveServerPlaylist"
      SendRefreshTrack2Clients
   Case "browseFolder"
      
      spl = Split(args, "~")            'split with ~
      If b_BrowseByFolder Then
         tmpBrowse = BrowseForFolder(scanAlbumPath)
      Else
         With cdl
            .InitDir = scanAlbumPath
            .filename = ""
            .flags = cdlOFNExplorer Or cdlOFNAllowMultiselect
            .MaxFileSize = 25500
            .filter = WinampPlayableFilter 'video file
            .ShowOpen Me.hwnd
            tmpBrowse = .filename
         End With
      End If
      If tmpBrowse <> "" Then
         sendToFlash Swf(IndexSwf), "browseFolder", tmpBrowse
         If MsgBox("Are you sure to select this folder?", vbYesNo + vbDefaultButton2, "Confirm Scan Album Path") = vbYes Then
            scanAlbumPath = tmpBrowse
            EditXML MainSettingXML, 0, "scanAlbumPath", tmpBrowse
            'Debug.Print CBrowse.SaveAlbumDirectory(spl(0), spl(1), tmpBrowse)
            If CBrowse.SaveAlbumDirectory(spl(0), spl(1), tmpBrowse) Then
               sendToFlash Swf(IndexSwf), "RefreshAlbum", args
               swf_FSCommand IndexSwf, "GetArtistTrackInfo", currentAlbumID & "~" & CBrowse.GetLastLanguage
            End If
               
         End If
      End If
   Case "browseTrailer"
      'Trailer Path
      With cdl
         .InitDir = scanAlbumPath
         .filename = ""
         .flags = cdlOFNAllowMultiselect Or cdlOFNExplorer
         .MaxFileSize = 25500
         .filter = WinampPlayableFilter  'video file
         .ShowOpen Me.hwnd
         tmpBrowse = .filename
      End With
      
      If tmpBrowse <> "" Then
         sendToFlash Swf(IndexSwf), "browseFolder", tmpBrowse
         scanAlbumPath = tmpBrowse
         EditXML MainSettingXML, 0, "scanAlbumPath", tmpBrowse
         Call CBrowse.SetAlbumField(val(args), "PathTrailer", tmpBrowse)                  'save the trailer path to the album
      End If
   Case "player_album"
      If CWinsock.LoggedType = ServerMode Then
         fso.CreateTextFile(SlyVariable("<Player>"), True, True).Write (args)
         CWinsock.Send2Client WS_COMMAND, 0, "server&&&4&&&function||ShowPlayerAlbumBar"
      End If
    Case "ChangeIndex"
        If MusicNoteValue <> "true" Then
            AddCommand "miniCommand", "SelectedPlaylist" & "|:|" & args, "", True
            Exit Sub
        End If
End Select


If command = "UnloadSwf" Then
   indexSwf2Unload = args
   If (indexSwf2Unload <> vbNullString) Then
      On Error Resume Next
      If val(indexSwf2Unload) >= 0 Then
         Unload Swf(val(indexSwf2Unload))
         If val(indexSwf2Unload) = 2 Then
            CSearch.CloseAllDatabase
            Set CSearch = Nothing
            StoreQsearch = ""
             'txtSearchUnicode.Text = ""
            txtSearchUnicode.Visible = False
         End If
      End If
      indexSwf2Unload = vbNullString
   End If
   Exit Sub
ElseIf command = "downloadBrowse" Then
    'str_downloadBrowse = args
    str_downloadBrowse = ""
    Exit Sub
ElseIf command = "DefaultFirst" Then
   If currentCountry = "" And CountryPath = "" Then
      If Settings.LastLanguage <> "" Then
         currentCountry = Settings.LastLanguage                         'Default to last country
      Else
         currentCountry = args
      End If
      CountryPath = SlyVariable("<" & currentCountry & "_dat>")
      CBrowse.SetCountry currentCountry, CountryPath
   End If
    
ElseIf command = "PathSlideshowAlbum" Then
   Dim tmp_slideshow_album_path As String
   tmp_slideshow_album_path = get_currnet_album_slideshow_path(args)
   If tmp_slideshow_album_path <> "" Then
      tmp_browse_folder = BrowseForFolder(tmp_slideshow_album_path, hwnd)
   Else
      tmp_browse_folder = BrowseForFolder(browse_slideshow_album, hwnd)
   End If
   If tmp_browse_folder <> "" Then
      browse_slideshow_album = tmp_browse_folder
      EditXML MainSettingXML, 0, "browse_slideshow_album", browse_slideshow_album
      SaveSlideshowPaths args, browse_slideshow_album
   End If
ElseIf command = "popupLocation" Then
   popupPosition = Split(args, "-")
   Exit Sub
ElseIf command = "microLocation" Then
   microPosition = Split(args, "-")
   Exit Sub
ElseIf command = "Exit" Then
    Timer2.Enabled = True
    bExitingProgram = True
    Exit Sub
ElseIf command = "trackLocation" Then
    setTrackLocation (args)
ElseIf command = "SendPathPic" Then
    StrPathPic = args
ElseIf command = "SaveInPlayList" Then
      Call StartPlayTrack(StrPathPic, StPlayer, args & "%%" & "", pathTrackID, NameCountryPlay, ModePlay)
   Exit Sub
ElseIf command = "Key" Then
    PressKeyInternalPlayer args
    Exit Sub
ElseIf command = "setSlideShow" Then
    setSlideShows
    sendToFlash Swf(IndexSwf), "slideShow", CStr(b_slideshow)
    Exit Sub
ElseIf command = "clearTimeSlideshow" Then
    interValCount = 0
    Exit Sub
ElseIf command = "Visualization" Then
    
    If str_swfNames = "Fullscreen" Then
       change_visualization_type
    End If
    Exit Sub
ElseIf command = "ShowPurchaseBox" Then
   sendVariable2Flash Swf(IndexSwf), "ShowPurchaseBox", CBrowse.GetEnableAlbumASIN(args)
   sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
ElseIf command = "ViewCart" Then
   ViewCart args
ElseIf command = "buyCD" Then
    PurchaseCD (args)
ElseIf command = "PurchaseTrack" Then
    PurchaseTrack (args)
ElseIf command = "setHideMouse" Then
    EditSetting MainSettingXML, 0, "HideMouse", args
    SplitColor = ReplaceStrSpl(SplitColor, 27, args, "~")
    sendVariable2Flash Swf(0), "SetHideMouse", args
    sendVariable2Flash Swf(0), "OpenFrame", "true"
    b_hideMouse = args = "true"
    Exit Sub
ElseIf command = "SetSlideShowOnOff" Then
    If args = "Yes" Then
       tmrSlideShow.Interval = 1000
       b_slideshow = True
    Else
       tmrSlideShow.Interval = 0
       b_slideshow = False
    End If
    EditSetting MainSettingXML, 1, "SetSlideShow", args
    SplitSly = ReplaceStrSpl(SplitSly, 1, args, "~")
ElseIf command = "offScreen" Then
    SetCursorPos ScreenX, ScreenY / 2
ElseIf command = "FullScreenPlayer" Then
   'If str_swfNames = "" Then Fullscreen True
   Exit Sub
ElseIf command = "Minimize" Then
   If run_bShowingInputCode Then
      'if showing then close
      FrmMain.swfAddTrack.SetVariable "ShowForm", "0"
   End If
    If str_swfNames <> "Micro" Then
        MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height
    Else
        SWF_FMA_FSCommand 2, "Maximize", True
    End If
   Exit Sub
ElseIf command = "showPlaylistPlayer" Then
   open_form_language = True
   
   If Settings.LastLanguage <> "" Then
      currentCountry = Settings.LastLanguage
      Settings.LastLanguage = ""                   'Don't make it try to open the same language for the second time
   Else
      If CBrowse.GetLastLanguage <> "" Then
         currentCountry = CBrowse.GetLastLanguage
      Else
         currentCountry = CountriesList(0).Name
      End If
   End If
   MainPath = get_country_path(currentCountry)
   MainPathImage = get_country_image(currentCountry)
   CountryPath = MainPath
   'scale_visualization_to_fullscreen True
   If CBrowse.SetCountry(currentCountry, MainPath) = False Then
      sendVariable2Flash Swf(IndexSwf), "ReLoadErr", "true"
      sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
      Exit Sub
   End If
   
   LoadSwfPlayListPlayerPage ""
   
   LoadSwfInterfaceCD args
   Swf(0).Visible = False
   IndexSwf = 4
   ShowOrHidePlayer True
     
   b_displayNewTrack = False
   
   If IsRegistered = False Then
        If Swf(12).Visible = True Then Swf(12).ZOrder 0
   End If
   open_form_language = False
   Exit Sub
ElseIf command = "ChangeDisplayList" Then
    If index = 0 Then
        If DisplayAlbumLong = "true" Then
            DisplayAlbumLong = "false"
        Else
            DisplayAlbumLong = "true"
        End If
        EditSetting MainSettingXML, 0, "DisplayAlbumList", DisplayAlbumLong
        sendVariable2Flash Swf(IndexSwf), "DisplayAlbumLong", DisplayAlbumLong
        sendVariable2Flash Swf(IndexSwf), "SetAlbumNum", args
    ElseIf index = 2 Then
        If DisplayAlbumLongSearch = "true" Then
            DisplayAlbumLongSearch = "false"
        Else
            DisplayAlbumLongSearch = "true"
        End If
        EditSetting MainSettingXML, 0, "DisplayAlbumListSearch", DisplayAlbumLongSearch
        sendVariable2Flash Swf(2), "DisplayAlbumLong", DisplayAlbumLongSearch
        sendVariable2Flash Swf(2), "SetAlbumNum", args
    ElseIf index = 3 Then
        If DisplayAlbumLongPlaylist = "true" Then
            DisplayAlbumLongPlaylist = "false"
        Else
            DisplayAlbumLongPlaylist = "true"
        End If
        EditSetting MainSettingXML, 0, "DisplayAlbumListPlaylist", DisplayAlbumLongPlaylist
        sendVariable2Flash Swf(IndexSwf), "DisplayAlbumLong", DisplayAlbumLongPlaylist
        sendVariable2Flash Swf(IndexSwf), "SetAlbumNum", args
    End If
ElseIf command = "CtrlPlus" Then
    KeyCtrlPlus args
ElseIf command = "GetArtistAlbumInfo" Then
       spl = Split(args, "~")
       If UBound(spl) > 0 Then
         sendVariable2Flash Swf(IndexSwf), "GetArtistAlbumInfo", " " & CBrowse.GetAlbumInfo(val(spl(0)), spl(1))
       Else
         sendVariable2Flash Swf(IndexSwf), "GetArtistAlbumInfo", " " & CBrowse.GetAlbumInfo(val(spl(0)))
       End If
       sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
ElseIf command = "SetRatingAlbum" Then
       Dim splRating() As String
       splRating = Split(args, "~")
       If UBound(splRating) > 1 Then
         EditAlbumRating val(splRating(0)), val(splRating(1)), splRating(2)
       Else
         EditAlbumRating val(splRating(0)), val(splRating(1))
       End If
'.........................MISC.......................
ElseIf command = "StrArrChecked" Then
      Call SplitScreens(args)
      
ElseIf command = "DownloadScreen" Then
   'args = "WS,WSH,..."
   sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateProcessing", "Dowloading new screens..."
   DownloadScreen args
ElseIf command = "BrowseDB" Then
   On Error Resume Next
   Dim strBrowseDB As String
   If args = "UpdateDB" Then
      cdl.filter = "Sly Update File|*.upd"
      cdl.flags = cdlOFNHideReadOnly
      cdl.ShowOpen Me.hwnd
      strBrowseDB = cdl.filename
   ElseIf args = "RestoreDB" Then
      cdl.filter = "Sly BackUp File|*.Bac"
      cdl.flags = cdlOFNHideReadOnly
      cdl.ShowOpen Me.hwnd
      strBrowseDB = cdl.filename
   ElseIf args = "BackUpDB" Then
      Set fItem = bf.BrowseForFolder(hwnd, "Browse BackUp Path", 0).Items.item
      strBrowseDB = fItem.path
   ElseIf args = "CopyMusicSource" Then
      Set fItem = bf.BrowseForFolder(hwnd, "Browse Copy Music Source Path", 0).Items.item
      strBrowseDB = fItem.path
   ElseIf args = "CopyMusicDestination" Then
      Set fItem = bf.BrowseForFolder(hwnd, "Browse Copy Music Destination Path", 0).Items.item
      strBrowseDB = fItem.path
      sendVariable2Flash Swf(IndexSwf), "CopyMusicDes", strBrowseDB
      sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
      Exit Sub
   End If
   sendVariable2Flash Swf(IndexSwf), "DatabasePath", strBrowseDB
   sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
ElseIf command = "CopyMusicFolder" Then
  Dim Md As Integer
  stSpl = Split(args, "||")
  If stSpl(2) = "false" And stSpl(3) = "false" Then
      Md = 0
  ElseIf stSpl(2) = "true" And stSpl(3) = "false" Then
      Md = 1
  ElseIf stSpl(2) = "false" And stSpl(3) = "true" Then
      Md = 2
  ElseIf stSpl(2) = "true" And stSpl(3) = "true" Then
      Md = 3
  '..........Overwrite folder.jpg "stspl(4)"
  End If
  CopyFolder stSpl(0), stSpl(1), val(Md), stSpl(4) = "true"
ElseIf command = "RestoreDB" Then
   CBrowse.RestoreFavorite args
ElseIf command = "BackUpDB" Then
   CBrowse.BackupFavorite args & ".bac"
ElseIf command = "UpdateDBSendToLanguagePage" Then
   run_bUpdating = True
   CBrowse.CloseAllDatabase                  'Close using database

    DisplayMini = 0
    If IndexSwf = 0 Then
        LoadSwfCountry "", args
    Else
        LoadSwfCountry str(IndexSwf), args
    End If
    ShowOrHidePlayer False
ElseIf command = "UpdateDBLocalGoToLanguagePage" Then
   run_bUpdating = True
    DisplayMini = 0
    If IndexSwf = 0 Then
        LoadSwfCountry "", , args
    Else
        LoadSwfCountry str(IndexSwf), , args
    End If
    ShowOrHidePlayer False
ElseIf command = "CheckUpdateAvailable" Then
    '.......Check Update Available
   Dim dateDownload_Check As Date, dateUpdate_Check As Date
   Dim dateDatabase_Check As Date
   Dim dateDownloadAndUpdate_Check() As String
   dateDownloadAndUpdate_Check = Split(args, de_Field)
   dateDownload_Check = dateDownloadAndUpdate_Check(0)
   dateUpdate_Check = dateDownloadAndUpdate_Check(1)
   
   AddServerLink GetCDXmlPath, dateDownloadAndUpdate_Check(2) & "||" & dateDownloadAndUpdate_Check(3) & "||" & dateDownloadAndUpdate_Check(4)
   languageServerLink = getLanguageServer(dateDownloadAndUpdate_Check(2))
   dateDatabase_Check = CBrowse.GetLastUpdate                           'Get database date from it
   If dateDownload_Check > dateDatabase_Check Then
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateAvailable", "true"
   ElseIf dateUpdate_Check > dateDatabase_Check Then
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateAvailable", "true"
   Else
      sendVariable2Flash FrmMain.Swf(IndexSwf), "UpdateAvailable", "false"
   End If

ElseIf command = "UpdateDB" Then
   ''''''''''' UpdateDatabase args
   Dim dateDownload As Date, dateUpdate As Date
   Dim dateDatabase As Date
   Dim dateDownloadAndUpdate() As String
   dateDownloadAndUpdate = Split(args, de_Field)
   dateDownload = dateDownloadAndUpdate(0)
   dateUpdate = dateDownloadAndUpdate(1)
   dateDatabase = CBrowse.GetLastUpdate
       
   If dateDownload > dateDatabase Then
      DownloadUpdateDatabase currentCountry, False
   ElseIf dateUpdate > dateDatabase Then
      lastUpdateDate = dateUpdate
      DownloadUpdateDatabase currentCountry, True
   Else
     sendVariable2Flash FrmMain.Swf(IndexSwf), "CompletedUpdate", "true"
     sendVariable2Flash FrmMain.Swf(IndexSwf), "OpenFrame", "true"
   End If
ElseIf command = "CompleteUpdate" Then
   DeleteGenresXml pathUpdateDB
   pathUpdateDB = ""
   run_bUpdating = False
'.........................End MISC..................
'........................ABOUT SLY..................
ElseIf command = "ShowAboutSly" Then
   About_Status = "Second"
   ResizeForm swfAbout, App.path & "\sly\About.sly", formWidth, formHeight, SplitColor
   swfAbout.SetFocus
'.......DownLoad Image
ElseIf command = "RefreshCoverArt" Then
   stSpl = Split(args, "%~%")
   If Dir(stSpl(0)) <> "" Then
      fso.DeleteFile stSpl(0)
   End If
   StartDownload , args
ElseIf command = "DownLoadPic" Then
   StartDownload , args
'........SearchIamgePath...............
ElseIf command = "reloadcoverart" Then
'reloadcoverart
   'SearchPathImages args
   SetCoverArtType args
ElseIf command = "SearchPathImage" Then
    SearchPathImages args
'.........................................
ElseIf command = "KeyPressed" Then
      PressKeyInternalPlayer args
ElseIf index = 1 Then
''   Debug.Print command
   Select Case command     'DLP
      Case "RemoteControlRequestLogin"                'Or Independent mode
         CWinsock.Send2Server WS_COMMAND, "requestLogin&&&" & args
      Case "RemoteControlRequestSignup"               'Or Independent mode
         CWinsock.Send2Server WS_COMMAND, "requestSignup&&&" & args
      Case "RemoteControlRequestSignOut"
         DeletePath str_main_playlist_path, login_name
         login_name = ""
         sendVariable2Flash Swf(1), "login_name", login_name
      Case "RemoteControlRequestChange"
          CWinsock.Send2Server WS_COMMAND, "requestChange&&&" & args       'change user password
      Case "requestAutoConnect"
            If Not b_loadAlready Then
               ' b_DefaultLoadType = 2
               b_DefaultAutoConnect = True
               s_DefaultParameter = args
            End If
        Case "VisibleIconAlbum"
            b_ShowCoverIcon = CBool(args)
        Case "defaultDatabaseType"
            EditSetting MainSettingXML, 0, "defaultDatabaseType", args
        Case "blank_top"
            close_player_top = CLng(args)
        Case "blank_top"
            close_player_buttom = CLng(args)
        Case "setServer"
            setServer = args
        Case "delete_myAlbum"
            If args = "true" Then
                If b_delete_myAlbum = False Then
                    delete_myalbum_xml
                    b_delete_myAlbum = True
                End If
            End If
            EditXML MainSettingXML, 0, "del", "true"
        Case "access_pass"
            b_acces_pass = args = "true"
        Case "store_user_login_name"
            If args <> "" Then
               'SlyNickName = args        '& " (" & ComputerName & ")"
            Else
               'SlyNickName = ComputerName
            End If
            store_user_login_name = args
        Case "streamType"
            setStreamType = val(args)
        Case "store_user_login_pass"
            store_user_login_pass = args
        Case "default_per"
            b_default_permission = args = "true"
        Case "deny_connect"
            b_deny = args = "true"
        Case "permission"
            str_permission = args
        Case "got_permission"
            b_got_permission = args = "true"
        Case "p4"
            syn_vol = args = "true"
            EditSetting MainSettingXML, 2, "syn", LCase(syn_vol)
            sendVariable2Flash Swf(IndexSwf), "syn_volume", CStr(syn_vol)
        Case "p5"
            syn = args = "true"
            EditSetting MainSettingXML, 1, "syn", LCase(syn)
        Case "p6"
            b_AllowSlideshow = args = "true"
            EditSetting MainSettingXML, 1, "allow_slideshow", LCase(b_AllowSlideshow)
            
        Case "clearInternetTemp"
            killInternetTemp
        Case "online"
            b_online = args = "true"
            EditXML MainSettingXML, 0, "online", LCase(b_online)
        Case "clear_user_sign_in_index"
            user_sign_in_index = ""
        Case "user_sign_in_index"
            If args <> "" Then user_sign_in_index = args
        Case "user_online_id"
            user_online_id = args
        Case "online_id"
            online_id = args
        Case "login_name"
            login_name = args
        Case "color_popup"
            Dim aa() As String
            aa = Split(args, "%%")
            bar_color = aa(0)
            button_color = aa(1)
            text_color = aa(2)
            button_alpha = aa(3)
            button_color_selected = aa(4)
            button_alpha_selected = aa(5)
        Case "connected_already"
            If connected_already Then
                sendToFlash Swf(1), "connected_already", connected_userName & "||" & connected_password
            Else
                sendToFlash Swf(1), "not_yet", "true"
            End If
        Case "num_display"
            num_display = CInt(args)
        Case "setReencode"
            b_ReEncode = args = "true"
        Case "setDownloadAll"
            boolDownloadAll = args = "true"
        Case "LinkingPlaylistPath"
            CUserLogin.LinkingPlayListPath = args
        Case "start_update_db"
            start_update_db args
        Case "check_update_ava"
             '.......Check Update Available
            Dim date_download_check As Date, date_update_check As Date
            Dim date_database_check As Date
            Dim date_download_and_update_check() As String
            Dim Update_arr() As String
            Dim ij As Integer
            Dim TSTR As String  'temp string
            Dim uStr As String  'Update String
            Dim b_u As Boolean
            If args <> "" Then
                Update_arr = Split(args, "%%")
                For ij = 0 To UBound(Update_arr)
                    TSTR = Update_arr(ij)
                    
                    Dim dl() As String
                    dl = Split(TSTR, "||")
                    CBrowse.SetCountry dl(2), SlyVariable("<" & dl(2) & "_dat>")
                    
                    date_download_and_update_check = Split(TSTR, de_Field)
                    date_download_check = date_download_and_update_check(0)
                    date_update_check = date_download_and_update_check(1)
                    
                    AddServerLink GetCDXmlPath, date_download_and_update_check(2) & "||" & date_download_and_update_check(3) & "||" & date_download_and_update_check(4)
                    languageServerLink = getLanguageServer(date_download_and_update_check(2))
                    date_database_check = CBrowse.GetLastUpdate
                    
                    If date_download_check > date_database_check Then
                        b_u = True
                    ElseIf date_update_check > date_database_check Then
                        b_u = True
                    End If
                    
                    If b_u = True Then
                        b_u = False
                        If uStr = "" Then
                            uStr = TSTR
                        Else
                            uStr = uStr & "%%" & TSTR
                        End If
                    End If
                Next ij
                If uStr <> "" Then sendToFlash Swf(1), "auto_update_DB", uStr
            End If
        Case "check_language_for_auto_update"
            If load_already = False And auto_new_database = True Then
                sendToFlash Swf(1), "autoUpdate", True
            End If
            load_already = True
        Case "get_sly_name"
            If args = "get" Then
               If SlyNickName = "" Then sendToFlash Swf(1), "sly_name", SlyNickName
            Else
               sendToFlash Swf(1), "sly_name", SlyNickName
            End If
        Case "set_sly_name"
            'SlyNickName = args
            CWinsock.connectName = args
            If temp_type_login <> "" Then CWinsock.Send2Server WS_COMMAND, "Request&&&" & temp_type_login & "&&&" & SlyNickName & "&&&0&&&" & CWinsock.connectName
        Case "store_list_index"
            store_list_index = Int(args)
        Case "dir"
            spl = Split(args, "||")
            If fso.GetDriveName(spl(1)) <> "" And Dir(spl(1)) = "" Then
                sendVariable2Flash Swf(1), spl(0) & ".showImage", "None"
            Else
                sendVariable2Flash Swf(1), spl(0) & ".showImage", spl(1)
            End If
        Case "LoadCountry"
            currentCountry = args
            'CountryPath = SlyVariable("<" & currentCountry & "_dat>")
            CountryPath = get_country_path(currentCountry)  ' SlyVariable("<" & currentCountry & "_dat>")
            If CBrowse.SetCountry(currentCountry, CountryPath) = False Then
                sendVariable2Flash Swf(IndexSwf), "ReLoadErr", "true"
                sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
                Exit Sub
            End If
            '===========Start checking for new database from server machine=============
            'Request to update database of current language by sending country name and last update date
            CWinsock.Send2Server WS_COMMAND, ConcateString("&&&", "RequestUpdateDatabase", currentCountry, CBrowse.GetLastUpdate)
            '=====================2006-07-14============================================
            
            MainPath = CountryPath
            MainPathImage = get_country_image(currentCountry)
            LoadSwfInterfaceCD "1"
            If b_play Then get_track_info False
            b_displayNewTrack = False
            If IsRegistered = False Then If Swf(12).Visible = True Then Swf(12).ZOrder 0
        Case "request_switch"
            CWinsock.Send2Server WS_COMMAND, "request_login_type&&&" & num_display & "&&&" & user_sign_in_index & "&&&" & True & "&&&" & store_user_login_name & "&&&" & store_user_login_name & "&&&" & store_user_login_pass & "&&&" & b_acces_pass & "&&&"
        Case "clone_display"
            type_login_display = args = "true"
        Case "clone_playback"
            type_login_playback = args = "true"
        Case "independent"
            type_login_independent = args = "true"
        Case "Remotecontrol"
            type_login_remoteControl = args = "true"
        Case "AutoClientConnection"
            i_AutoConnected = val(args)
        Case "allow_slideshow"
            b_AllowSlideshow = args = "true"
        Case "localLink"
            b_local_link = args = "true"
        Case "SlideShowMode"
            slideshow_mode = args
        Case "internal_slide_path"
            internal_slideshow_path = args
            external_slideshow_path = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "ImageDirectory", REG_SZ)
        Case "copy_friend_playlist"
            If friend_playlist = True Or CWinsock.LoggedType = cloneDisplay Then
                CWinsock.Send2Server WS_COMMAND, "request_all_friend_playlists&&&"
            End If
        Case "friend_playlist"
            friend_playlist = args = "true"
        Case "syn_vol"
            syn_vol = args = "true"
        Case "syn"
            syn = args = "true"
        Case "popup_exit"
            popup_exit = args = "true"
        Case "syn_vol_change"
            change_vol = args = "true"
        Case "auto_new_database"
            auto_new_database = args = "true"
        Case "resize_image_server"
            b_resize = args = "true"
        Case "AllowSlideshow"
            b_AllowSlideshow = args = "true"
        Case "rotate"
            b_rotate = args = "true"
        Case "streamFile"
            CWinsock.StreamFile = args = "true"
        Case "playchapterFile"
            playChapterType = args <> "False"              'EDID:2005.11.05,0
        Case "EnableSeek"
            setEnableSeekOfsset = LCase(args) = "true"
        Case "scan_for_server"
            CNet.ClientScanServer "255.255.255.255"
            'CNet.ClientScanServer "192.168.1.120"
        Case "new_server_name"
            Dim arr_args() As String
            arr_args = Split(args, "|||")
            args = arr_args(0)
            If Add_New_Server(arr_args(0), arr_args(1), "") Then
               sendToFlash Swf(1), "new_server", "success"
               sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
            Else
               sendToFlash Swf(1), "new_server", "fail"
            End If
            
'''            If LCase(args) <> LCase(ComputerIP) Then
'''                sendToFlash Swf(1), "new_server", "success"
'''                Dim xmlCountry As DOMDocument
'''                Dim xmlCountryRoot As IXMLDOMElement
'''                Dim xmlCountryName As IXMLDOMElement
'''
'''                Set xmlCountry = New DOMDocument
'''                xmlCountry.Load App.path & "\sly\Server.xml"
'''                Set xmlCountryRoot = xmlCountry.firstChild
'''
'''                Set xmlCountryName = xmlCountry.createElement("Server")
'''                xmlCountryName.setAttribute "imagePath", "Computer.sly"
'''                xmlCountryName.setAttribute "nick_name", arr_args(1)
'''                xmlCountryName.Text = args
'''                xmlCountryRoot.appendChild xmlCountryName
'''
'''                xmlCountry.Save App.path & "\sly\Server.xml"
'''
'''                sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
'''            Else
'''                sendToFlash Swf(1), "new_server", "fail"
'''            End If
        Case "selecteImage"
            Dim s_spl() As String
            Dim ss As String
            Dim rr As String
            s_spl = Split(args, "%|%")
            
            If s_spl(0) = "server" Then
                ss = "Server.xml"
                rr = "Server"
            ElseIf s_spl(0) = "country" Then
                ss = "Countries.xml"
                rr = "Language"
            ElseIf s_spl(0) = "application" Then
                ss = "Applications.xml"
                rr = "Application"
            End If
            
            cdl.flags = 4
            cdl.filter = "*.jpg | *.jpg"
            cdl.ShowOpen Me.hwnd
            If cdl.filename <> "" Then
                If rr <> "Language" Then
                    EditFile App.path & "\sly\" & ss, val(s_spl(1)), "imagePath", cdl.filename
                Else
                    fso.CopyFile cdl.filename, s_spl(2) & "\folder.jpg"
                End If
            End If
            sendVariable2Flash Swf(1), "open" & rr, App.path & "\Sly"
        Case "change_path_language"
            spl = Split(args, "||")
            
            If Dir(spl(1) & "\Language.xml") <> "" Then
                EditXML App.path & "\Sly\Countries.xml", CInt(spl(0)), "Path", spl(1)
            End If
            
            EditXML App.path & "\Sly\Countries.xml", CInt(spl(0)), "imagePath", spl(1)
            sendVariable2Flash Swf(1), "openLanguage", App.path & "\Sly"
            ReloadCountryFromXML
        Case "folder"
            Dim tp As String
            tp = BrowseForFolder(args, hwnd)
            If tp <> "" Then
                sendToFlash Swf(1), "getPath", tp
            End If
        Case "execute"
            ShellExecute hwnd, "Open", args, "", "", 1
        Case "deleteServer"
            RemoveFile App.path & "\sly\Server.xml", val(args)
            sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
        Case "deleteApplication"
            RemoveFile App.path & "\sly\Applications.xml", val(args)
            sendVariable2Flash Swf(1), "openApplication", App.path & "\Sly"
        Case "deleteCountry"
            DeleteCountry App.path & "\sly\Countries.xml", args
            sendVariable2Flash Swf(1), "openLanguage", App.path & "\Sly"
            RemoveServerLink GetCDXmlPath, args       ' tmp_remove_spl(1)     ''temporary unused //2006.05.18 Seng
            ReloadCountryFromXML
        Case "resize_image"
            resize_image = args = "True"
        Case "move_up_and_down"
            Dim init As Integer
            Dim sub_spl() As String
            spl = Split(args, "%|%")
            
            If spl(0) = "Server" Then
               MoveChildNode App.path & "\sly\" & spl(0) & ".xml", spl(1), spl(2)
               sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
            ElseIf spl(0) = "Applications" Then
               MoveChildNode App.path & "\sly\" & spl(0) & ".xml", spl(1), spl(2)
               sendVariable2Flash Swf(1), "openApplication", App.path & "\Sly"
            ElseIf spl(0) = "Countries" Then    '2005.05.18
               MoveCountry App.path & "\sly\" & spl(0) & ".xml", spl(1), spl(2)
               sendVariable2Flash Swf(1), "openLanguage", App.path & "\Sly"
               ReloadCountryFromXML
            End If
        Case "adsAndScreen"
            EditServerLinkAdsAndScreen GetCDXmlPath, args
        Case "newServerLink"
            AddServerLink GetCDXmlPath, args
        Case "setRegister"
            Dim arr_reg() As String
            arr_reg = Split(args, "|~|")
            SlyRegedit.SetKeyValue HKEY_CURRENT_USER, RegPath, "Languages", arr_reg(0), REG_SZ
            SlyRegedit.SetKeyValue HKEY_CURRENT_USER, RegPath, "LanguagesPath", arr_reg(1), REG_SZ
        Case "DownloadLanguage"
            str_newLanguageNameDownload = args
            DownloadLanguages args
        Case "add_language"
            Dim str_XmlPath As String
            str_XmlPath = BrowseForFolder("", hwnd)
            If str_XmlPath <> "" Then
               If AddCountryFromXml(str_XmlPath) Then
                  sendVariable2Flash Swf(1), "openLanguage", App.path & "\Sly"
                  ReloadCountryFromXML
               End If
            End If
        Case "edit_label_application"
            spl = Split(args, "%%")
            EditName App.path & "\sly\Applications.xml", val(spl(1)), spl(0)
            sendVariable2Flash Swf(1), "openApplication", App.path & "\Sly"
        Case "add_application"
            cdl.flags = 4
            cdl.filter = "All Files | *.*"
            cdl.ShowOpen Me.hwnd
            
            spl = Split(cdl.filename, "\")
            spl = Split(spl(UBound(spl)), ".")
            
            'AddNewFile App.path & "\sly\Applications.xml", cdl.filename, "PlaylistIcon.sly", spl(0), "Application"
            AddNewApplication App.path & "\sly\Applications.xml", cdl.filename, "PlaylistIcon.sly", spl(0)
            
            sendVariable2Flash Swf(1), "openApplication", App.path & "\Sly"
        Case "disconnect_from_server"
            If sckClient.State = sckConnected Then
                sckClient.Close
                
            End If
            sckClient_Close 'call close event
        Case "disconnect"
            sckClient.Close
            CWinsock.LoggedType = ServerMode
            sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
        Case "restore_connection"
            sckClient.Close
        Case "login"
            Dim arr_n() As String
            Dim iRegKeyType As RegisterEnum
            
            arr_n = Split(args, "|~|")
            args = arr_n(0)
            If CWinsock.clientCount = 0 Then
               #If Server = 1 Then
                  If StrComp(args, ComputerIP, vbTextCompare) <> 0 And StrComp(args, ComputerName, vbTextCompare) <> 0 Then
               #Else
                  If True Then
               #End If
                  iRegKeyType = GetRegisterKeyType
'''                  If iRegKeyType = NotRegistered Then
'''                     Popup_Dialog "Connection", "You didn't register yet!"
'''                     sendToFlash FrmMain.swf(IndexSwf), "not_connected", "true"
                  If iRegKeyType = RegisterAsLinkingServer Then
                     Popup_Dialog "Connection", "Linking server can't connect to other server"
                     sendToFlash FrmMain.Swf(IndexSwf), "not_connected", "true"
                  ElseIf iRegKeyType = RegisterAsRemoteControl Or iRegKeyType = RegisterAsRoomServer Or iRegKeyType = NotRegistered Then     'Only available when register key is RegisterAsRemoteControl
                     If sckClient.State = 7 Then sckClient.Close
                        'If sckClient.State = sckConnecting Then sckClient.Close
                        CWinsock.ConnectServer args
                        server_name = args
                        server_nick_name = arr_n(1)
                        CWinsock.serverNickName = server_nick_name ' server_name
                        CWinsock.connectName = arr_n(2) & " (" & ComputerName & ")"
                     Else
                        sendToFlash FrmMain.Swf(IndexSwf), "not_connected", "true"
                     End If
                  Else
                     Popup_Dialog "Connection", "Can't connect to itself"
                     sendToFlash FrmMain.Swf(IndexSwf), "not_connected", "true"
                  End If
            Else
               sendToFlash FrmMain.Swf(IndexSwf), "not_connected", "true"
            End If
        Case "requestConnect"
            If (GetRegisterKeyType = RegisterAsRoomServer And val(args) <> independentMode) Or (GetRegisterKeyType = RegisterAsRemoteControl And val(args) <> remoteControl) Then
               'if it is room server don't connect
               sendToFlash Swf(IndexSwf), "clientType", CWinsock.LoggedType
               sendToFlash Swf(IndexSwf), "not_connected", "true"
               Popup_Dialog "Access Denied", "You can't connect with this type"
               Exit Sub
            End If
            temp_type_login = args
            CWinsock.Send2Server WS_COMMAND, "Request&&&" & args & "&&&" & SlyNickName & "&&&0&&&" & CWinsock.connectName
        Case "Lame_Path"
            Lame_Path = args
        Case "FLAC_Path"
            FLAC_Path = args
        Case "APE_Path"
            APE_Path = args
        Case "MainPathImage"
            'MainPathImage = args
        Case "browse_import_playlist"
            browse_import_playlist = args
        Case "browse_slideshow_playlist"
            browse_slideshow_playlist = args
        Case "browse_slideshow_album"
            browse_slideshow_album = args
        Case "browse_slideshow"
            browse_slideshow = args
        Case "browse_folder_music"
            browse_folder_music = args
        Case "browse_new_playlist_folder"
            browse_new_playlist_folder = args
        Case "priorityExtension"
            stringPriorityEXT = args
        Case "priorityMplayer"
            StringPriorityMplayer = args
        Case "KaraokeVoice"
            b_karaoke_voice = (args = "true")
        Case "trackType"
            setDisplayTrackType = args
        Case "DVDControlType"
            setDisplayDvdContol = args
        Case "ShowPopupinfo"
           Settings.b_ShowPopupInfo = (args = "True")
        Case "StringsubList"
            StringsubList = args
        Case "scanAlbumPath"
            scanAlbumPath = args
        Case "monitor"
            setMonitor = args
            If CPlayer.PlayWith = WindowMedia Then
                EnableScreensaver = args
            Else
                EnableScreensaver = 0
            End If
        Case "microStyle"
            microStyle = CInt(args)
        Case "ripWith"
            If args = "ripWithiTunes" Then
               ripMusicWith = ripWithiTunes
            Else
               ripMusicWith = ripWithWindowMedia
            End If
        Case "playWith"
'''            If args = "WindowMedia" Then
'''                playMusicWith = WindowMedia
'''            ElseIf args = "Winamp" Then
'''                playMusicWith = Winamp
'''            Else
'''               playMusicWith = nero
'''            End If
'''            If playMusicWith = Winamp Then
'''                If MediaPlayer Is Nothing Then Set MediaPlayer = New Winamp_Control
'''                MediaPlayer.IsStart MediaTimer
'''            End If
        Case "Key"
            PressKeyInternalPlayer args
        Case "NumAlbum"
            EditSetting MainSettingXML, 0, "NumCover", args
            SplitColor = ReplaceStrSpl(SplitColor, 3, args, "~")
        Case "CoverAlbum"
            EditSetting MainSettingXML, 0, "AlbumCover", args
            SplitColor = ReplaceStrSpl(SplitColor, 2, args, "~")
        Case "SplitSt"
            Dim splSlide() As String
            Dim mic() As String
            Dim sca() As String
            Dim MicScaleHW() As String
            stSpl = Split(args, "&&")
            
            SplitColor = stSpl(0)
            SplitSly = stSpl(1)
            SplitPlayer = stSpl(2)
            
            mic() = Split(SplitPlayer, "~")
            Micro = mic(6)
            sca() = Split(SplitColor, "~")
            b_autoClose = sca(25) = "true"
            b_hideMouse = sca(27) = "true"
            MicScaleHW = Split(mic(8), " x ")
            scaleMicroByWidth = val(MicScaleHW(0))    ' 640 || 800 || 1024
            scaleMicroByHeight = val(MicScaleHW(1))  ' 480 || 600 || 768
            
            'Open SLIDESHOW........
            splSlide = Split(SplitSly, "~")
            
            'EditRegistrySlide ImageDir, splSlide(0)
            set_slideshow_path
            SlideSecond = val(splSlide(2))
            
            SlideShowValue = splSlide(1)
            If (splSlide(1) = "Yes") Then
                tmrSlideShow.Interval = 1000
                EditRegistrySlide Stretch, splSlide(3)
                EditRegistrySlide ShowFilename, splSlide(4)
                EditRegistrySlide Effect, splSlide(5)
                EditRegistrySlide Scroll, splSlide(6)
                EditRegistrySlide Delay, splSlide(7)
                EditRegistrySlide ImageSize, splSlide(8)
            End If
            
            If load_already = False Then
                splitSetting
            End If
        Case "Starting"
            b_loading = True
            Form_Loads
            
            Swf(1).SetFocus
        Case "About"
            About_Status = "First"
            ResizeForm swfAbout, App.path & "\sly\About.sly", formWidth, formHeight, args
        Case "LoadPlayMusicPlayer"
           AddCommand "LoadPlayMusicPlayer", LoadPlayMusic, ""
        Case "ChangeLan"
            If args = "Eng" Or args = "Uni" Then
               Language = args
            Else
               Language = "Eng"
            End If
        Case "InitDir"
            InitDir = args
        Case "Load"
            If args = "Playlist" Then
               '2006-11-24 Seng Image Path
               currentCountry = CountriesList(0).Name
               MainPath = CountriesList(0).path
               MainPathImage = get_country_image(currentCountry)
               ' FOR STORE VARIABLE FOR ENCODE CD
               'currentAlbum.Countrys = stSpl
               CountryPath = MainPath
               If CBrowse.SetCountry(currentCountry, MainPath) = False Then
                   sendVariable2Flash Swf(IndexSwf), "ReLoadErr", "true"
                   sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
                   Exit Sub
               End If
               Load Swf(3)
               LoadSwfPlayListPage ""
               
               LoadSwfInterfaceCD "1"
               Swf(0).Visible = False
               IndexSwf = 3
               
               
               b_displayNewTrack = False
               If IsRegistered = False Then
                  If Swf(12).Visible = True Then Swf(12).ZOrder 0
               End If
               
               server_display_language = currentCountry
               server_display_page = "Playlist"
            ElseIf args = "Search" Then
                MainPath = CountriesList(0).path
                currentCountry = CountriesList(0).Name
                ' FOR STORE VARIABLE FOR ENCODE CD
'''                currentAlbum.Countrys = stSpl
                CountryPath = MainPath
                
                If CBrowse.SetCountry(currentCountry, MainPath) = False Then
                    sendVariable2Flash Swf(IndexSwf), "ReLoadErr", "true"
                    sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
                    Exit Sub
                End If
                
                Load Swf(2)
                
                LoadSwfSearchPage ""
                
                LoadSwfInterfaceCD "1"
                Swf(0).Visible = False
                IndexSwf = 2
                
                b_displayNewTrack = False
            
                server_display_language = currentCountry
                server_display_page = "Search"
                
            End If
    End Select
    
'...........................CDinterface.............................
 ElseIf index = 0 Then
 '     If Command <> "KeyPressed" Then Debug.Print Command
     
      If command = "Exit" Then
         miniCommand "Stop" & "|:|" & True
         Timer2.Enabled = True
         bExitingProgram = True
      ElseIf command = "RefreshVLCAutoPlay" Then
         RefreshAutoPlay
      ElseIf command = "CancelBrowse" Then
        CBrowse.bCancelBrowse = True
      ElseIf command = "mini" Then
         miniCommand args
      ElseIf command = "LoadNewCountry" Then
            currentCountry = args
            CountryPath = SlyVariable("<" & currentCountry & "_dat>")
            If CBrowse.SetCountry(currentCountry, CountryPath) = False Then
               Exit Sub
            End If
            MainPath = CountryPath
            MainPathImage = CountryPath
            LoadSwfInterfaceCD ""
            b_displayNewTrack = False
      ElseIf command = "Minimize" Then
           FrmMain.WindowState = 1
      ElseIf command = "ShowScan" Then
'''         frmScan.showMe
      ElseIf command = "SetRating" Then
           stSpl = Split(args, "~")
           SetTrackField stSpl(0), "Rating", stSpl(1)
      ElseIf command = "BrowseAlbumBy" Then
           EditSetting MainPath & "\Language.xml", 0, "BrowseBy", args
           EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "Browse"
           StrFont = ReplaceStrSpl(StrFont, 6, args, "~")
           StrFont = ReplaceStrSpl(StrFont, 9, "Browse", "~")
           sendVariable2Flash Swf(0), "BrowseBy", args
           sendVariable2Flash Swf(0), "DisplayAlbum", "Browse"
           sendVariable2Flash Swf(0), "ChangeBrowseBy", "true"
           sendVariable2Flash Swf(0), "OpenFrame", "true"
           If IndexSwf = 0 Then
               'if it called from sckclient_close
               picwmp.Visible = False
               show_hide_player = False
           End If
           lastBrowseBy = args
      ElseIf command = "DisplayAlbum" Then
           EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", args
           StrFont = ReplaceStrSpl(StrFont, 9, args, "~")
           sendVariable2Flash Swf(0), "DisplayAlbum", args
           sendVariable2Flash Swf(0), "ChangeBrowseBy", "true"
           sendVariable2Flash Swf(0), "OpenFrame", "true"
      ElseIf command = "SortMasterImg" Then
         cdl.filename = ""
         cdl.filter = "*.jpg|*.jpg"
         cdl.ShowOpen Me.hwnd
         sendVariable2Flash Swf(0), "SortMasterImg", cdl.filename
         sendVariable2Flash Swf(0), "OpenFrame", "true"
      ElseIf command = "SaveIndexAndCount" Then
         Dim fileName1 As String
         stSpl = Split(args, "~")
         If stSpl(6) = "Browse" Then
            fileName1 = MainPath & "\" & stSpl(7) & "s.xml"
         ElseIf stSpl(6) = "MyFavAlbum" Then
            fileName1 = GetLanguageLocation("MyFavAlbum.xml")
         ElseIf stSpl(6) = "MyFavArtist" Then
            fileName1 = GetLanguageLocation("MyFavArtist.xml")
         ElseIf stSpl(6) = "MyAlbum" Then
            fileName1 = GetLanguageLocation("MyAlbum.xml")
         End If
         SaveIndexAndCount stSpl(0), stSpl(1), stSpl(2), fileName1, stSpl(3), stSpl(4), stSpl(5)
      ElseIf command = "ClickGenre" Then
         ClickGenre args
      ElseIf command = "SaveLetter" Then
         stSpl = Split(args, "~")
         SaveLetter stSpl(0), stSpl(1)
      ElseIf command = "SaveGenre" Then
         SaveGenre args
      ElseIf command = "GetGenre" Then
           Dim StProGen As String
           If args = "Genre" Then
                If isFileExist(GetLanguageLocation("Genres.xml")) Then
                  sendVariable2Flash Swf(0), "GetGenre1", GetGenreOrProduction(GetLanguageLocation("Genres.xml"))
                Else
                  StProGen = CBrowse.GetGenre
                  sendVariable2Flash Swf(0), "GetGenre", StProGen
                End If
           ElseIf args = "Production" Then
                If isFileExist(GetLanguageLocation("Productions.xml")) Then
                  sendVariable2Flash Swf(0), "GetGenre1", GetGenreOrProduction(GetLanguageLocation("Productions.xml"), boolLanguageChanged)
                  If boolLanguageChanged Then
                     sendVariable2Flash Swf(0), "GetGenre", CBrowse.GetLabel
                  End If
                Else
                  sendVariable2Flash Swf(0), "GetGenre", CBrowse.GetLabel
                End If
           ElseIf args = "ReleaseDate" Then
               If isFileExist(GetLanguageLocation("ReleaseDates.xml")) Then
                  sendVariable2Flash Swf(0), "GetGenre1", GetGenreOrProduction(GetLanguageLocation("ReleaseDates.xml"))
               Else
                  sendVariable2Flash Swf(0), "GetYears", CBrowse.GetAlbumYears
               End If
           End If
           sendVariable2Flash Swf(0), "OpenFrame", "true"
''           picwmp.Visible = False
''           show_hide_player = False
      ElseIf command = "GetArtistNameStore" Then
            stSpl = Split(args, "~")
            Dim st11 As String
            If (stSpl(1) = "All") Then stSpl(1) = ""
            CBrowse.mSelectAlbumType = stSpl(2)
            st11 = CBrowse.ArtistByGenreNletter(val(stSpl(0)), LCase(stSpl(1)))
            If (Len(st11) > 0) Then
               sendVariable2Flash Swf(0), "GetArtistNameStore", st11
               sendVariable2Flash Swf(0), "OpenFrame", "true"
            Else
                sendVariable2Flash Swf(0), "OpenFrame", "false"
            End If
      ElseIf command = "GetArtistName" Then
            stSpl = Split(args, "~")
            Dim st As String
            If (stSpl(1) = "All") Then stSpl(1) = ""
            
            CBrowse.mSelectAlbumType = stSpl(2)
            
            st = CBrowse.ArtistByGenreNletter(val(stSpl(0)), LCase(stSpl(1)))
      
            If Len(st) = 0 Then st = "Non"
            sendVariable2Flash Swf(0), "GetArtistName", st
            sendVariable2Flash Swf(0), "OpenFrame", "true"
      ElseIf command = "GetAlbumByTVSeries" Then
         '*******************************************************************************
         ' Function Name     :   GetAlbumByTVSeries
         ' Description       :   Browse album By TVSeries
         ' Return Values     :
         ' Input Parameter   :
         '-------------------------------------------------------------------------------
         ' Written by        Date                Modified Contents
         '-------------------------------------------------------------------------------
         ' None             10-19-2005           New
         '*******************************************************************************
         On Error GoTo 0
         
         If CWinsock.LoggedType = cloneDisplay Then
            CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbum&&&GetArtistAlbum&&&" & args
         Else
            stSpl = Split(args, "~")
            lenArtist = CBrowse.AlbumByTVSeries(val(stSpl(0)), val(stSpl(3)), val(stSpl(2)))
            If (lenArtist > 0) Then
              stArtist = "Yes"
            Else
              stArtist = "Non"
            End If
            
            sendVariable2Flash Swf(0), "StoreReloadGroup", "GetArtistAlbum&&&" & args
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         End If
      ElseIf command = "GetArtistAlbum" Then
               'Edit 1 Gener
         On Error GoTo 0
         
         If CWinsock.LoggedType = cloneDisplay Then
            CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbum&&&GetArtistAlbum&&&" & args
         Else
            stSpl = Split(args, "~")
            'lenArtist = CBrowse.AlbumByArtist(val(stSpl(0)), val(stSpl(2)), val(stSpl(1)))
            lenArtist = CBrowse.AlbumByArtist(val(stSpl(0)), val(stSpl(2)), val(stSpl(1)))
            'GenreID+"~"+StartLetter+"~"+Available+"~"+SortedValue);

            If (lenArtist > 0) Then
              stArtist = "Yes"
            Else
              stArtist = "Non"
            End If
            
            sendVariable2Flash Swf(0), "StoreReloadGroup", "GetArtistAlbum&&&" & args
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         End If
      ElseIf command = "AlbumByGenre" Then
         '*******************************************************************************
         ' Function Name     :   None
         ' Description       :   Browse album by genre
         ' Return Values     :
         ' Input Parameter   :
         '-------------------------------------------------------------------------------
         ' Written by        Date                Modified Contents
         '-------------------------------------------------------------------------------
         ' Seng             09-12-2005           New
         '*******************************************************************************
         On Error GoTo 0
         
         If CWinsock.LoggedType = cloneDisplay Then
            CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbum&&&GetArtistAlbum&&&" & args
         Else
            stSpl = Split(args, "~")
            'lenArtist = CBrowse.AlbumByArtist(val(stSpl(0)), val(stSpl(2)), val(stSpl(1)))
            'GenreID+"~"+StartLetter+"~"+Available+"~"+SortedValue);

            lenArtist = CBrowse.AlbumByGenre(stSpl(0), stSpl(1), stSpl(2), AllCD, stSpl(3))
            'lenArtist = CBrowse.AlbumByGenre(val(stSpl(0)), stSpl(1), all, AllCD, stDate)
            If (lenArtist > 0) Then
              stArtist = "Yes"
            Else
              stArtist = "Non"
            End If
            
            sendVariable2Flash Swf(0), "StoreReloadGroup", "GetArtistAlbum&&&" & args
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         End If
     ElseIf command = "GetAlbumByLetter" Then
            lenArtist = CBrowse.AlbumByArtistLetter(args)
            If (lenArtist > 0) Then
                stArtist = "Yes"
            Else
                stArtist = "Non"
            End If
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
     ElseIf command = "SortValue" Then
            EditSetting MainSettingXML, 0, "SortedValue", args
            SplitColor = ReplaceStrSpl(SplitColor, 4, args, "~")
     ElseIf command = "SetSortedtoSetting" Then
            stSpl = Split(args, "~")
            'EditSetting MainSettingXML, 0, "SortedValue", stSpl(0)
            'SplitColor = ReplaceStrSpl(SplitColor, 4, stSpl(0), "~")
            EditSetting MainPath & "\Language.xml", 0, "BrowseBy", stSpl(1)
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "Browse"
            StrFont = ReplaceStrSpl(StrFont, 6, stSpl(1), "~")
            StrFont = ReplaceStrSpl(StrFont, 9, "Browse", "~")
            
            sendVariable2Flash Swf(0), "BrowseBy", stSpl(1)
            sendVariable2Flash Swf(0), "DisplayAlbum", "Browse"
            sendVariable2Flash Swf(0), "ChangeBrowseBy", "true"
            sendVariable2Flash Swf(0), "OpenFrame", "true"
     ElseIf command = "SetAvatoSetting" Then
            stSpl = Split(args, "~")
            EditSetting MainPath & "\Language.xml", 0, "AvaValue", stSpl(0)
            CBrowse.mSelectAlbumType = CInt(right(stSpl(0), 1))
            selectSortedType = CInt(right(stSpl(1), 1))
            
     ElseIf command = "ShowCountry" Then
            DisplayMini = 0
            LoadSwfCountry ""
            ShowOrHidePlayer False
     ElseIf command = "ShowPlayList" Then
            On Error Resume Next
            Swf(0).Visible = False
            Load Swf(3)
            LoadSwfPlayListPage ""
            ShowOrHidePlayer False
     ElseIf command = "ShowSearch" Then
            spl = Split(args, "&&")
            If val(spl(2)) = 8 Or val(spl(2)) = 4 Or val(spl(2)) = 16 Then
               val_Local = CBrowse.GetTrackField(CLng(spl(1)), "SingerIDs")
            Else
               val_Local = CBrowse.GetAlbumField(CLng(spl(0)), "LabelID")
            End If
            
            Swf(0).Visible = False
            Load Swf(2)
            If Len(args) > 0 Then
               StoreQsearch = val_Local & "&&" & spl(2) & "&&" & spl(3)   'args
               SplitColor = ReplaceStrSpl(SplitColor, 17, "Artist", "~")
            End If
            LoadSwfSearchPage ""
            ShowOrHidePlayer False
     ElseIf command = "ShowSearchArtistTrack" Then
            Dim tmpQsearch As String
            Dim tmp() As String
            
            If Len(args) > 0 Then
               'swf(0).Visible = False
               Load Swf(2)
               'StoreQsearch = args
               SplitColor = ReplaceStrSpl(SplitColor, 17, "Artist", "~")
            End If
            LoadSwfSearchPage ""
            tmp = Split(args, ";")
            tmpQsearch = tmp(1) & "~" & Swf(IndexSwf).GetVariable("iSearchAvailable")
            ShowOrHidePlayer False
            AddCommand "GetArtistTrack", tmpQsearch, "", False
            'sith 21/10/06 flash screen when search
     ElseIf command = "ShowSearchTrackStartLetter" Then

'''         var StartLetter=letter_array[substring(this._parent._name,7)];
'''         fscommand("ShowSearchTrackStartLetter",StartLetter+"&&"+_root.databaseType+"&&"+_root.AvaValue);
     
            If Len(args) > 0 Then
               Swf(0).Visible = False
               Load Swf(2)
               StoreSearchTrack = args
               SplitColor = ReplaceStrSpl(SplitColor, 17, "Artist", "~")
            End If
            LoadSwfSearchPage ""
            ShowOrHidePlayer False
     ElseIf command = "StrFont" Then
            spl = Split(args, "%%")
            StrFont = spl(0)
            Grouping = val(spl(1))
            CBrowse.mSelectAlbumType = All
            CBrowse.mSelectGroupCDType = Grouping               ' 0 mean group,-1 mean not group
     ElseIf command = "ShowOption" Then
            Swf(0).Visible = False
            LoadSwfSettingPage ""
            ShowOrHidePlayer False
     ElseIf command = "DefineCDType" Then
            CBrowse.mSelectFlagType = args
     ElseIf command = "SetAlbumFavorite" Then
            spl = Split(args, "~")
            CBrowse.SetAlbumFavorite val(spl(0)), val(spl(1))
            If Dir(GetLanguageLocation("MyFavAlbum.xml")) <> "" Then
               fso.DeleteFile GetLanguageLocation("MyFavAlbum.xml"), True
            End If
     ElseIf command = "SetArtistFavorite" Then
            spl = Split(args, "~")
            CBrowse.SetArtistFavorite val(spl(0)), val(spl(1))
            If Dir(GetLanguageLocation("MyFavArtist.xml")) <> "" Then
               fso.DeleteFile GetLanguageLocation("MyFavArtist.xml"), True
            End If
     ElseIf command = "ChangeRankValue" Then
            spl = Split(args, "~")
            CBrowse.SetArtistRating val(spl(0)), val(spl(1))

     ElseIf command = "ChangeRankValueAlbum" Then
            spl = Split(args, "~")
            CBrowse.SetAlbumRank val(spl(0)), val(spl(1))
          ElseIf command = "GetYear" Then
          
            If GetNewestReleaseDate(GetLanguageLocation("ReleaseDates.xml")) = True Then
               sendVariable2Flash Swf(0), "GetYearsRefresh", CBrowse.GetAlbumYears
               sendVariable2Flash Swf(0), "OpenFrame", "true"
            End If
    ElseIf command = "GetAlbumByIndex" Then
            spl = Split(args, "~")
            stArtist = CBrowse.GetNextAlbum(val(spl(0)), val(spl(1)))
            ' sendVariable2Flash swf(0), "LoadingAlbum", 1
            sendVariable2Flash Swf(0), "ShowAlbumPic", spl(2)
            sendVariable2Flash Swf(0), "ResultAlbumName", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
            lastBrowseBy = GetFlashVar(Swf(IndexSwf), "BrowseBy")
            'all browse are here
    ElseIf command = "ReleaseDateStore" Then
            'Edit 44 ReleaseDate
            If CWinsock.LoggedType = cloneDisplay Then
               CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbumStore" & "&&&ReleaseDatel&&&" & args
            Else
               lenArtist = CBrowse.AlbumByReleaseDate(False, val(args), selectSortedType)
               If (lenArtist > 0) Then stArtist = "Yes" Else stArtist = "Non"
               sendVariable2Flash Swf(0), "StoreReloadGroup", "ReleaseDate&&&" & args
               sendVariable2Flash Swf(0), "ArtistLength", lenArtist
               sendVariable2Flash Swf(0), "GetArtistAlbumStore", stArtist
               sendVariable2Flash Swf(0), "OpenFrame", "true"
            End If
            
            EditSetting MainPath & "\Language.xml", 0, "BrowseBy", "ReleaseDate"
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "Browse"
            
    ElseIf command = "ReleaseDate" Then
            'Edit 4 Release
         If CWinsock.LoggedType = cloneDisplay Then
            CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbum" & "&&&ReleaseDatel&&&" & args
         Else
            lenArtist = CBrowse.AlbumByReleaseDate(False, val(args), selectSortedType)
            SendAlbum2Swf lenArtist, "ReleaseDate&&&" & args
         End If
            EditSetting MainPath & "\Language.xml", 0, "BrowseBy", "ReleaseDate"
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "Browse"
    ElseIf command = "GetMyFavAlbum" Then
            'Edit 5 FavAlbum
            If Dir(GetLanguageLocation("MyFavAlbum.xml")) <> "" Then
               sendVariable2Flash Swf(0), "GetMyFavXml", GetMyFavXml("MyFavAlbum.xml")
            End If
            If args = "MyFavorite" Then
               lenArtist = CBrowse.GetTopAlbum(-2)
            ElseIf args = "ReleaseDate" Then
               lenArtist = CBrowse.GetTopAlbum(1)
            ElseIf args = "Rating" Then
               lenArtist = CBrowse.GetTopAlbum(0)
            ElseIf args = "Rank" Then
               lenArtist = CBrowse.GetTopAlbum(7)
            End If
            
            If (lenArtist > 0) Then stArtist = "Yes" Else stArtist = "Non"
            sendVariable2Flash Swf(0), "StoreReloadGroup", "GetMyFavAlbum&&&" & args
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "MyFavAlbum"
            EditSetting MainPath & "\Language.xml", 0, "MyFavAlbum", args
            StrFont = ReplaceStrSpl(StrFont, 7, args, "~")
            StrFont = ReplaceStrSpl(StrFont, 9, "MyFavAlbum", "~")
        
     ElseIf command = "GetMyAlbum" Then
            'Edit 6 My Album
            Dim sortAlbumIndex As Integer
            If isFileExist(MainPath & "\MyAlbum.xml") Then
               sendVariable2Flash Swf(0), "GetMyFavXml", GetMyFavXml("MyAlbum.xml")
            End If
           
'''            If CWinsock.LoggedType <> serverMode Then
'''               CBrowse.filterAvailable SlyVariable("<MyAlbumServer>"), currentCountry, ""
'''               lenArtist = CBrowse.SelectAlbumsFromList(True, sortAlbumIndex)
'''            Else
'''               sortAlbumIndex = Switch(args = "MyFavorite", -2, args = "ReleaseDate", 1, args = "Rating", 0, args = "Rank", 7)
'''               If CWinsock.clientCount > 0 Then
'''                  CBrowse.filterAvailable SlyVariable("<MyAlbum>"), currentCountry, ""
'''                  lenArtist = CBrowse.SelectAlbumsFromList(True, sortAlbumIndex)
'''               Else
'''                  lenArtist = CBrowse.GetTopAlbum(sortAlbumIndex, False)
'''
'''               End If
'''            End If
            lenArtist = CBrowse.GetTopAlbum(sortAlbumIndex, False)
            SendAlbum2Swf lenArtist, "GetMyAlbum&&&" & args
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "MyAlbum"
            EditSetting MainPath & "\Language.xml", 0, "MyAlbum", args
            
            StrFont = ReplaceStrSpl(StrFont, 10, args, "~")
            StrFont = ReplaceStrSpl(StrFont, 9, "MyAlbum", "~")
            If IndexSwf = 0 Then
               show_hide_player = False
               picwmp.Visible = False
               picMini.Visible = False 'sith 10-08-06
            End If
      ElseIf command = "GetMyFavArtist" Then
         If isFileExist(GetLanguageLocation("MyFavArtist.xml")) Then
             sendVariable2Flash Swf(0), "GetMyFavXml", GetMyFavXml("MyFavArtist.xml")
         End If
         If args = "MyFavorite" Then
             st = CBrowse.GetFavoriteArtist(1)
         ElseIf args = "ReleaseDate" Then
             st = CBrowse.GetFavoriteArtist(6)
         ElseIf args = "Rank" Then
              st = CBrowse.GetFavoriteArtist(5)
         End If
         
         If Len(st) > 0 Then
            sendVariable2Flash Swf(0), "GetArtistName", st
         Else
            sendVariable2Flash Swf(0), "GetArtistName", "Non"
         End If
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "MyFavArtist"
         EditSetting MainPath & "\Language.xml", 0, "MyFavArtist", args
         StrFont = ReplaceStrSpl(StrFont, 8, args, "~")
         StrFont = ReplaceStrSpl(StrFont, 9, "MyFavArtist", "~")
      ElseIf command = "GetTVSeries" Then
         '*******************************************************************************
         ' Function Name     :   GetTVSeries
         ' Description       :   Get all TV Series
         ' Return Values     :
         ' Input Parameter   :
         '-------------------------------------------------------------------------------
         ' Written by        Date                Modified Contents
         '-------------------------------------------------------------------------------
         ' Seng             10-19-2005           New
         '*******************************************************************************
         st = CBrowse.GetTVSeriesAvailable
         If Len(st) > 0 Then
            sendVariable2Flash Swf(0), "GetArtistName", st
         Else
            sendVariable2Flash Swf(0), "GetArtistName", "Non"
         End If
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", "MyFavArtist"
         EditSetting MainPath & "\Language.xml", 0, "MyFavArtist", args
         StrFont = ReplaceStrSpl(StrFont, 8, args, "~")
         StrFont = ReplaceStrSpl(StrFont, 9, "MyFavArtist", "~")
   ElseIf command = "GetAlbumByLabel" Then
      'Edit 2 Production
      'LabelID,StartingLetter,selectType,ArrangeBy
      Dim splAlbumByLabel() As String
      splAlbumByLabel = Split(args, "~")
      If CWinsock.LoggedType = cloneDisplay Then
         CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & splAlbumByLabel(4) & "&&&GetAlbumByLabel&&&" & args
      Else
         If (splAlbumByLabel(1) = "All") Then splAlbumByLabel(1) = ""
         lenArtist = CBrowse.AlbumByLabel(val(splAlbumByLabel(0)), splAlbumByLabel(1), val(splAlbumByLabel(3)), val(splAlbumByLabel(2)))
         If (lenArtist > 0) Then stArtist = "Yes" Else stArtist = "Non"
         sendVariable2Flash Swf(0), "StoreReloadGroup", "GetAlbumByLabel&&&" & args
         sendVariable2Flash Swf(0), "ArtistLength", lenArtist
         sendVariable2Flash Swf(0), splAlbumByLabel(4), stArtist
         sendVariable2Flash Swf(0), "OpenFrame", "true"
      End If
   ElseIf command = "GetAlbumByRating" Then
            'Edit 3 Rating
            If CWinsock.LoggedType = cloneDisplay Then
               CWinsock.Send2Server WS_COMMAND, "requestBrowsingAlbum&&&" & "GetArtistAlbum" & "&&&GetAlbumByRating&&&" & args
            Else
            
               Dim splAlbumByRating() As String
               splAlbumByRating = Split(args, "~")
               If (splAlbumByRating(1) = "All") Then splAlbumByRating(1) = ""
               lenArtist = CBrowse.AlbumByRating(val(splAlbumByRating(0)), splAlbumByRating(1), val(splAlbumByRating(3)), val(splAlbumByRating(2)))
               If (lenArtist > 0) Then stArtist = "Yes" Else stArtist = "Non"
               sendVariable2Flash Swf(0), "StoreReloadGroup", "GetAlbumByRating&&&" & args
               sendVariable2Flash Swf(0), "ArtistLength", lenArtist
               sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
               sendVariable2Flash Swf(0), "OpenFrame", "true"
            End If
    ElseIf command = "SaveInPlayer" Then
            StPlayer = args
            ModePlay = "0"
            NameCountryPlay = currentCountry
   ElseIf command = "MusicNoteValue" Then
            MusicNoteValue = args
   ElseIf command = "PlayMode" Then
         EditSetting MainSettingXML, 0, "PlayMode", args
         SplitColor = ReplaceStrSpl(SplitColor, 14, args, "~")
   ElseIf command = "HidePlayer" Then              'HidePlayer
        If open_form_language = True Then
            ShowOrHidePlayer True
            DisplayMini = 1
            open_form_language = False
        Else
            ShowOrHidePlayer False
            If picMini.Visible Then picMini.Visible = False
            UnloadSwfMiniControl
            DisplayMini = 0
            
        End If
   ElseIf command = "ValuePlayer" Then
      ValuePlayer = val(args)
   ElseIf command = "VisiblePlayer" Then
        ShowOrHidePlayer True
        DisplayMini = 1
        ValuePlayer = 4
        DoEvents
        swfMiniControl.SetVariable "vb", "lostFocus"
        'swf(IndexSwf).SetVariable "vb", "Over|%|TopBar.ButtonM"
        'DoEvents
        'swf(IndexSwf).SetVariable "vb", "Over|%|" & GetFlashVar(swf(IndexSwf), "TrackName") & ".Button0"
        Swf(IndexSwf).SetFocus
   ElseIf command = "ShowPlayListPlayer" Then
         Swf(0).Visible = False
         LoadSwfPlayListPlayerPage ""
         ShowOrHidePlayer True
         DoEvents
         swfMiniControl.SetVariable "vb", "lostFocus"
        'swf(IndexSwf).SetVariable "vb", "Over|%|TopBar.ButtonM"
        Swf(IndexSwf).SetVariable "vb", "Over|%|" & GetFlashVar(Swf(IndexSwf), "TrackName") & ".Button0"
        Swf(IndexSwf).SetFocus
   End If
ElseIf index = 2 Then                     'Search Page
   SearchPage command, args
ElseIf index = 3 Then
   If command = "refreshTrackAvailable" Then
      'Dim jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
      Dim trackLists() As String
      Dim trackOne() As String
      Dim returnValue As Long
      'Dim i As Long
      
      If args <> "" Then
         trackLists = Split(args, "|")
         For i = 0 To UBound(trackLists)
            trackOne = Split(trackLists(i), "*")
            returnValue = getTrackAvailableType(trackOne(2), trackOne(1), trackOne(3))
            sendVariable2Flash Swf(3), "resultSearch." & trackOne(3) & ".Ava", returnValue
         Next
         CallFlashFunction Swf(3), "redisplayTrack"
      End If
   ElseIf command = "ShowPlayer" Then
       ShowOrHidePlayer True
       FrmMain.SetFocus
   ElseIf command = "ShowCountry" Then
        LoadSwfCountry 3
   ElseIf command = "ChangePlayListMode" Then
            EditSetting MainSettingXML, 0, "PlayListMode", args
            SplitColor = ReplaceStrSpl(SplitColor, 22, args, "~")
   ElseIf command = "CheckTrackRating" Then
        CheckTrackRatingInXmlPlaylist args
   ElseIf command = "ShowOption" Then
        IndexOptionToLoad = 3
        LoadSwfSettingPage "3"
   ElseIf command = "ShowSearch" Then
        On Error Resume Next
        IndexSearchToLoad = 3
        Load Swf(2)
        LoadSwfSearchPage "3"
   ElseIf command = "ShowPlayListPlayer" Then
        IndexPlayerToLoad = 3
        LoadSwfPlayListPlayerPage "3"
        ShowOrHidePlayer True
       ' scale_visualization_to_fullscreen True
   ElseIf command = "Exit" Then
      miniCommand "Stop" & "|:|" & True
      Timer2.Enabled = True
      bExitingProgram = True
         'End
   ElseIf command = "Minimize" Then
         FrmMain.WindowState = 1
   ElseIf command = "NewPlayList" Then
         spl = Split(args, "~")
         AddNewPlayList spl(1), spl(0), "", spl(1) & "\Folder.jpg", True
   ElseIf command = "SortMasterImg" Then
         Dim destinationfileName As String
         Dim sourceFileName As String
         Dim baseName As String
         
         cdl.filename = ""
         cdl.filter = "*.jpg|*.jpg"
         cdl.ShowOpen Me.hwnd

         
         sourceFileName = cdl.filename
         baseName = fso.GetFileName(sourceFileName)
         If baseName <> "" Then
            destinationfileName = fso.BuildPath(args, "\Playlists\") & baseName
            save_as_JPG sourceFileName, destinationfileName, 500
   
            sendVariable2Flash Swf(3), "SortMasterImg", destinationfileName
            sendVariable2Flash Swf(3), "OpenFrame", "true"
         End If
         
   ElseIf command = "SaveIndex" Then
         Set xmlPlaylist = New DOMDocument
         'xmlPlaylist.Load App.path & "\sly\PlayListPaths.xml"
         xmlPlaylist.Load str_main_playlist_path & "\PlayListPaths.xml"
         Set xmlPlaylistRoot = xmlPlaylist.firstChild
         xmlPlaylistRoot.setAttribute "StoreLevel", args
         'xmlPlaylist.Save App.path & "\sly\PlayListPaths.xml"
         xmlPlaylist.Save str_main_playlist_path & "\PlayListPaths.xml"
   ElseIf command = "StoreNamePath" Then
         Set xmlPlaylist = New DOMDocument
         'xmlPlaylist.Load App.path & "\sly\PlayListPaths.xml"
         xmlPlaylist.Load str_main_playlist_path & "\PlayListPaths.xml"
         Set xmlPlaylistRoot = xmlPlaylist.firstChild
         xmlPlaylistRoot.setAttribute "StoreName", args
         'xmlPlaylist.Save App.path & "\sly\PlayListPaths.xml"
         xmlPlaylist.Save str_main_playlist_path & "\PlayListPaths.xml"
   
   ElseIf command = "ImportPlaylist" Then

'  === import only one file xml to playlists.xml ===
      cdl.InitDir = browse_import_playlist
      cdl.filename = ""
      cdl.flags = cdlOFNAllowMultiselect Or cdlOFNExplorer
      cdl.filter = "Playlist Name (*.xml) |*.xml"
      cdl.ShowOpen Me.hwnd
      
'=== import multi select
      Dim arr_spl() As String
      Dim iii As Long
      arr_spl = Split(cdl.filename, Chr(0))
      If UBound(arr_spl) > 0 Then
         browse_import_playlist = arr_spl(0)
         EditXML MainSettingXML, 0, "browse_import_playlist", browse_import_playlist
         For iii = 1 To UBound(arr_spl)
            If (fso.GetBaseName(arr_spl(iii)) <> "PlayLists") And (fso.GetBaseName(arr_spl(iii)) <> "") Then
               import_new_playlist args, arr_spl(0) & "\" & arr_spl(iii)
            End If
         Next iii
      Else
         If (fso.GetBaseName(cdl.filename) <> "PlayLists") And (fso.GetBaseName(cdl.filename) <> "") Then
            browse_import_playlist = fso.GetParentFolderName(cdl.filename)
            EditXML MainSettingXML, 0, "browse_import_playlist", browse_import_playlist
            import_new_playlist args, cdl.filename
         End If
      End If
   
   ElseIf command = "NewFolderPlaylist" Then
      tmp_browse_folder = BrowseForFolder(browse_new_playlist_folder, hwnd)
      If tmp_browse_folder <> "" Then
         browse_new_playlist_folder = tmp_browse_folder
         EditXML MainSettingXML, 0, "browse_new_playlist_folder", browse_new_playlist_folder
         DirFileMP3 args, browse_new_playlist_folder
      End If
   ElseIf command = "SortMasterAddNew" Then
      Set fItem = bf.BrowseForFolder(hwnd, "Create New PlayList Folder", 0).Items.item
      sendVariable2Flash Swf(3), "NewDirSortMaster", fItem.path
      sendVariable2Flash Swf(3), "OpenFrame", "true"
   ElseIf command = "SaveChangeSortMaster1" Then
         Dim PName1() As String
         Dim IPath1() As String
         Dim IPath2() As String
         spl = Split(args, "~")
         If val(spl(1)) = 1 Then
'            SaveSortMaster1 App.path & "\Sly", spl(0), val(spl(1)), spl(2), spl(3), spl(4)
            SaveSortMaster1 str_main_playlist_path, spl(0), val(spl(1)), spl(2), spl(3), spl(4)
         ElseIf val(spl(1)) > 1 Then
            PName1 = Split(spl(0), ",")
            IPath1 = Split(spl(2), ",")
            IPath2 = Split(spl(3), ",")
'            SaveSortMaster1 App.path & "\Sly", PName1, val(spl(1)), IPath1, IPath2, spl(4)
            SaveSortMaster1 str_main_playlist_path, PName1, val(spl(1)), IPath1, IPath2, spl(4)
         ElseIf val(spl(1)) = 0 Then
'            CreateNewFile App.path & "\Sly", "PlayListPaths", "PlayListPath"
            CreateNewFile str_main_playlist_path, "PlayListPaths", "PlayListPath"
         End If
   ElseIf command = "SaveChangeSortMaster" Then
         spl = Split(args, "~")
         Dim pName() As String
         Dim sPath() As String
         Dim IPath() As String
         If val(spl(4)) = 1 Then
            SaveSortMaster spl(0), spl(1), spl(2), spl(3), val(spl(4))
         ElseIf val(spl(4)) > 1 Then
            pName = Split(spl(1), ",")
            sPath = Split(spl(2), ",")
            IPath = Split(spl(3), ",")
            SaveSortMaster spl(0), pName, sPath, IPath, val(spl(4))
         ElseIf val(spl(4)) = 0 Then
            CreateNewFile spl(0) & "\PlayLists\", "PlayLists", "PlayList"
            Set xmlPlaylist = New DOMDocument
            'xmlPlaylist.Load App.path & "\sly\PlayListPaths.xml"
            xmlPlaylist.Load str_main_playlist_path & "\PlayListPaths.xml"
            Set xmlPlaylistRoot = xmlPlaylist.firstChild
            xmlPlaylistRoot.setAttribute "StoreLevel", ""
            'xmlPlaylist.Save App.path & "\sly\PlayListPaths.xml"
            xmlPlaylist.Save str_main_playlist_path & "\PlayListPaths.xml"
         End If
   ElseIf command = "SetImagePlayList" Then

        cdl.filename = ""
        cdl.filter = "*.jpg|*.jpg"
        cdl.ShowOpen Me.hwnd
        If cdl.filename <> "" Then
            spl = Split(args, "~")
            sendVariable2Flash Swf(3), "ImgPlayList", cdl.filename
            sendVariable2Flash Swf(3), "OpenFrame", "true"
        End If
   
   ElseIf command = "RenamePlayList" Then
        spl = Split(args, "~")
        RenamePlayList spl(0), spl(1), spl(2)
   ElseIf command = "DelPlayList" Then
        spl = Split(args, "~")
        DeletePlayList spl(0), val(spl(1)), spl(2)
        sendVariable2Flash Swf(3), "DelPlayList", "true"
        sendVariable2Flash Swf(3), "OpenFrame", "true"
   ElseIf command = "ChangePlayListIndex" Then
        spl = Split(args, "~")
        ChangePlayListIndex spl(0), val(spl(1)), val(spl(2))
   ElseIf command = "DelOneTrack" Then
        spl = Split(args, "~")
        RemoveTrack spl(0), val(spl(1))
   ElseIf command = "DelAllTrack" Then
      
         spl = Split(args, "~")
         'DeleteFile spl(0) & "\" & spl(2) & ".xml"
         'RemoveTrack spl(0) & "\" & "PlayLists.xml", val(spl(1))
         CreateNewFile spl(0), spl(1), "Track"
         
   ElseIf command = "SortMasterSlide" Then
         Set fItem = bf.BrowseForFolder(hwnd, "Browse SlideShow Folder", 0).Items.item
         sendVariable2Flash Swf(3), "SortMasterSlide", fItem.path
         sendVariable2Flash Swf(3), "OpenFrame", "true"
   ElseIf command = "EditSlyShow" Then
          
          spl = Split(args, "~")
          If spl(3) <> "" Then
              tmp_browse_folder = BrowseForFolder(spl(3), hwnd)
          Else
              tmp_browse_folder = BrowseForFolder(browse_slideshow_playlist, hwnd)
          End If
          
          If tmp_browse_folder <> "" Then
              browse_slideshow_playlist = tmp_browse_folder
              EditXML MainSettingXML, 0, "browse_slideshow_playlist", browse_slideshow_playlist
              EditSlyShow spl(0), val(spl(1)), spl(2), browse_slideshow_playlist
              sendVariable2Flash Swf(3), "EditSlyShow", browse_slideshow_playlist
              sendVariable2Flash Swf(3), "OpenFrame", "true"
              SetPlayListSlidePath = browse_slideshow_playlist
          End If

   ElseIf command = "SetImageSlide" Then
         EditRegistrySlide ImageDir, args
   ElseIf command = "GoBack" Then
        'UnloadSwf Swf(3)
        '......Playlist page
        If IndexPlaylistToLoad = 4 Then
            LoadSwfPlayListPlayerPage "3"
            ShowOrHidePlayer True
            IndexPlaylistToLoad = 0
        ElseIf IndexPlaylistToLoad = 2 Then
            Load Swf(2)
            LoadSwfSearchPage "3"
            IndexPlaylistToLoad = 0
        Else
            If ValuePlayer = 4 Then
               ShowOrHidePlayer True
               DisplayMini = 1
            Else
               ShowOrHidePlayer False
               DisplayMini = 0
            End If
            Swf(0).Visible = True
            
            server_display_language = currentCountry
            server_display_page = ""
            IndexSearchToLoad = 0
            IndexPlaylistToLoad = 0
            IndexPlayerToLoad = 0
            IndexOptionToLoad = 0
                
            IndexSwf = 0
            If ChangeIcon <> "" Then
                sendVariable2Flash Swf(0), "DisplayAlbumLong", DisplayAlbumLong
                sendVariable2Flash Swf(0), "SetAlbumNum", ChangeIcon
                ChangeIcon = ""
            End If
            sendVariable2Flash Swf(0), "UnloadEx", 3
            sendVariable2Flash Swf(0), "OpenFrame", "true"
            sendToFlash Swf(0), "showMiniPlayer", True
        End If
   ElseIf command = "SetPlayListName" Then
         spl = Split(args, "~")
         SetPlayListName = spl(0)
         SetPlayListSlidePath = spl(1)
   ElseIf command = "SetPlayListDir" Then
         SetPlayListDir = args
   ElseIf command = "BrowseAlbumByArtist" Then
'         Dim idArtist As Long
         spl = Split(args, "~")
         If Len(spl(1)) = 0 Then Exit Sub
         lenArtist = AlbumByArtistName(spl(0), spl(1), val(spl(2)), val(spl(3)))
         If (lenArtist > 0) Then
            stArtist = BrowseQuery.GetNextAlbum(0, lenArtist)
         Else
             stArtist = "Non"
         End If
         sendVariable2Flash Swf(3), "ArtistLength", lenArtist
         sendVariable2Flash Swf(3), "GetArtistAlbum", stArtist
         sendVariable2Flash Swf(3), "OpenFrame", "true"
         'CBrowse.RestoreCountry
         '...................Playtrack
   ElseIf command = "SaveInPlayer" Then
            spl = Split(args, "&&&")
            StPlayer = spl(0)
            ModePlay = spl(1)
            If ModePlay = "External" Then
               ModePlay = "1"
            Else
                ModePlay = "0"
            End If
            NameCountryPlay = spl(2)
   ElseIf command = "PlayModePlayList" Then
         EditSetting MainSettingXML, 0, "PlayModePlayList", args
         SplitColor = ReplaceStrSpl(SplitColor, 16, args, "~")
   ElseIf command = "HidePlayer" Then
         ShowOrHidePlayer False
   ElseIf command = "VisiblePlayer" Then
         'If IndexPlayTrack > 0 Then
            ShowOrHidePlayer True
            DisplayMini = 1
            'FrmMain.SetFocus
        ' End If
   ElseIf command = "SetRating" Then
            spl = Split(args, "~")
            If val(spl(0)) > 0 Then
               SetTrackField spl(0), "Rating", spl(1), spl(2)
            End If
            If spl(5) = "TrackTitle" Then
               EditSetting spl(4), val(spl(3)), "Rating", val(spl(1))
            End If
   ElseIf command = "SendVaueGrouping" Then
         If args = "False" Then
               GroupingReleaseDate = False
         Else
            GroupingReleaseDate = True
         End If
   End If
   
   
'.................................Endif.......................................
ElseIf index = 4 Then
   If command = "download_song" Then
      boolDownloadAll = args = "true"
   ElseIf command = "DefaultVLC" Then
      RefreshAutoPlay
   ElseIf command = "mini" Then
         miniCommand args
   ElseIf command = "ShowPlayer" Then
         ShowOrHidePlayer True
         'FrmMain.SetFocusz
   ElseIf command = "SetFocusSearchPlayer" Then
        'txtSearchPlayer.SetFocus
   ElseIf command = "ShowTextSearchPlayer" Then
        If args = "Yes" Then
            'txtSearchPlayer.Visible = True
            'txtSearchPlayer.SetFocus
            'txtSearchPlayer.Text = ""
            txtSearchUnicode.SetFocus
            clsKeyboard.SetKeyBoardLanguage currentCountry
        Else
            'txtSearchPlayer.Visible = False
            'clsKeyboard.SetKeyBoardLanguage "English"
        End If
   ElseIf command = "ShowCountry" Then
        LoadSwfCountry 4
        ShowOrHidePlayer False
   ElseIf command = "ShowOption" Then
        IndexOptionToLoad = 4
        LoadSwfSettingPage "4"
        ShowOrHidePlayer False
   ElseIf command = "ShowPlayList" Then
        On Error Resume Next
        IndexPlaylistToLoad = 4
        Load Swf(3)
        LoadSwfPlayListPage "4"
        ShowOrHidePlayer False
   ElseIf command = "ShowSearch" Then
        On Error Resume Next
        IndexSearchToLoad = 4
        Load Swf(2)
        LoadSwfSearchPage "4"
        ShowOrHidePlayer False
   ElseIf command = "Exit" Then
        miniCommand "Stop" & "|:|" & True
        Timer2.Enabled = True
        bExitingProgram = True
   ElseIf command = "Minimize" Then
        FrmMain.WindowState = 1
   ElseIf command = "RestoreResultSearch" Then
         sendVariable2Flash Swf(4), "PassTrackInfoLen", int_track_count
         sendVariable2Flash Swf(4), "OpenFrame", "true"
   ElseIf command = "ReadTrackInfoFromList" Then
      sendVariable2Flash Swf(4), "GetListed", ReadTrackInfoFromList(args)
      sendVariable2Flash Swf(4), "OpenFrame", "true"
   ElseIf command = "getTextSearch" Then
      ' 2006-08-07 Seng
      ' 2006-11-13 Edit
      StoreQsearch = txtSearchUnicode.Text 'swf(4).GetVariable("SearchBox.InputBox.Text")
'      If Language = "Uni" Then
'         If (InStr(1, currentCountry, "Khmer", vbTextCompare) = 0) Then
'            SelTextBox txtSearchPlayer
'            TextBox1.Text = ""
'            Call SendMessage(txtSearchPlayer.hwnd, WM_COPY, 0&, 0&)
'            TextBox1.Paste
'            StoreQsearch = TextBox1
'         End If
'      End If
      sendVariable2Flash Swf(4), "getTextSearch", StoreQsearch
      sendVariable2Flash Swf(4), "OpenFrame", "true"
      StoreQsearch = ""
   ElseIf command = "GetSearchTracks" Then
      sendVariable2Flash Swf(4), "GetSearchTracks", ReadSearchTrack((args = "true"))
      sendVariable2Flash Swf(4), "OpenFrame", "true"
   ElseIf command = "GetAllTracks" Then
      ' modified by seng---------------------------------------------------
      If boolRequestingTrack = False Then
         If CheckTrackForRequest = False Then
            sendVariable2Flash Swf(4), "GetAllTracks", GetPlayerAlbums.xml
            sendVariable2Flash Swf(4), "OpenFrame", "true"
         Else
            boolRequestingTrack = True
            CWinsock.Send2Server WS_COMMAND, "requestAlbumBar"
         End If
      Else
         
      End If
      ' -------------------------------------------------------------------
   ElseIf command = "GetNextTrackInfo" Then
         spl = Split(args, "~")
         If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentMode) Then
            SendTrack2Player spl(0), spl(1)
         Else
            If CheckTrackForRequest(spl(0), spl(1)) = True Then
               If boolRequestingTrack = False Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackInfos&&&" & spl(0) & "&&&" & spl(1)
                  boolRequestingTrack = True
               End If
            Else
               SendTrack2Player spl(0), spl(1)
            End If
         End If
         
   ElseIf command = "GoBack" Then
         'Player page......
         If IndexPlayerToLoad = 3 Then
                Load Swf(3)
                LoadSwfPlayListPage "4"
                ShowOrHidePlayer False
                DisplayMini = 0
                IndexPlayerToLoad = 0
         ElseIf IndexPlayerToLoad = 2 Then
                Load Swf(2)
                LoadSwfSearchPage "4"
                ShowOrHidePlayer False
                DisplayMini = 0
                IndexPlayerToLoad = 0
         Else
            UnloadSwfMiniControl                  'force it to hide minicontrol from player
            If ValuePlayer = 4 Then
                ShowOrHidePlayer True
                DisplayMini = 1
            Else
                ShowOrHidePlayer False
                DisplayMini = 0
            End If
            Swf(0).Visible = True
            
            server_display_language = currentCountry
            server_display_page = ""
            IndexSearchToLoad = 0
            IndexPlaylistToLoad = 0
            IndexPlayerToLoad = 0
            IndexOptionToLoad = 0
            
            IndexSwf = 0
            If ChangeIcon <> "" Then
                sendVariable2Flash Swf(0), "DisplayAlbumLong", DisplayAlbumLong
                sendVariable2Flash Swf(0), "SetAlbumNum", ChangeIcon
                ChangeIcon = ""
            End If
            sendVariable2Flash Swf(0), "UnloadEx", 4
            sendVariable2Flash Swf(0), "OpenFrame", "true"
            sendToFlash Swf(0), "showMiniPlayer", True
            
            display_seek_in_player 0
            Swf(0).SetFocus                                                      '2006-12-07 Seng
            
        End If
        
   ElseIf command = "MoveUp" Then
      'Call MoveTrack(args, "Up")
      AddCommand "MoveTrack", args, "Up"
   ElseIf command = "MoveDown" Then
      'Call MoveTrack(args, "Down")
      AddCommand "MoveTrack", args, "Down"
   ElseIf command = "DLIndex" Then
            DLIndex = CInt(args)
   ElseIf command = "RemoveTrack" Then
         'Delete one track from playlist player
         RemovePlayerTrack val(args)
         SendRefreshTrack2Clients
   ElseIf command = "RemoveAll" Then
      RemovePlayTrackAll
   ElseIf command = "SaveTrack" Then
         On Error GoTo sel
         If boolRequestingTrack = False Then
            If CheckTrackForRequest(0, int_track_count) = False Then
               SavePlaylistPlayer args
            Else
               boolRequestingTrack = True
               CWinsock.Send2Server WS_COMMAND, "SavePlayerTrack&&&" & args
            End If
         End If
sel:
   ElseIf command = "SetRating" Then
        spl = Split(args, "~")
        If val(spl(0)) > 0 Then
            SetTrackField spl(0), "Rating", spl(1), spl(2)
            PlayTrackInfo(val(spl(3))).Rating = val(spl(1))
        Else
            PlayTrackInfo(val(spl(3))).Rating = val(spl(1))
        End If
   ElseIf command = "SaveInPlayer" Then
            spl = Split(args, "&&&")
            StPlayer = spl(0)
            ModePlay = spl(1)
            If ModePlay = "External" Then
               ModePlay = "1"
            Else
                ModePlay = "0"
            End If
            NameCountryPlay = spl(2)
   End If
'.................................Endif.......................................\
ElseIf index = 6 Then
    If command = "playMusicWith" Then                    '2005-10-29
      AddCommand "FunOptions", command, args
    Else
      FunOptions command, args
      splitSetting index
    End If
End If
   Exit Sub
Error:
   WriteEvent "SWF_FMA_FSCommand index = " & index & ", Command = " & command & ", Argument = " & args, Err.Description, Err.Source
End Sub
Public Sub LoadSwfFile(filename As String, Swf As Object)
   LoadSwf Swf, filename
End Sub
Public Sub ReloadFlash(filename As String, Swf As Object, Optional index As Variant)
   On Error GoTo Error
   With Swf
         'If Index <> 0 Then .Movie = "a"
        .Visible = True
        .top = 0
        .left = 0
        .Width = formWidth
        .Height = formHeight
        'swf.Movie = "a"
        If ScreenType = "Normal" Then
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "NS.sly")
        ElseIf ScreenType = "mediumWideScreen" Then
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "WSM.sly")
        ElseIf ScreenType = "wideScreen" Then
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "WS.sly")
        ElseIf ScreenType = "mediumLargeWideScreen" Then
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "WSH.sly")
        ElseIf ScreenType = "smallWideScreen" Then                  '  updates
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "WSS.sly")
        ElseIf ScreenType = "largeWideScreen" Then                  '  updates
            LoadSwf Swf, App.path & "\sly\" & Replace(filename, ".sly", "WSL.sly")
        End If
   End With
   If Not IsMissing(index) Then IndexSwf = index
   eventMouseClick
   Exit Sub
Error:
   WriteEvent "ReloadFlash", Err.Description, Err.Source
End Sub

Private Sub CreatePlayListFolder(stPath As String)
   On Error GoTo Error
   If isFileExist(stPath & "\PlayListPaths.xml") = False Then
      CreateNewFile stPath, "PlayListPaths", "PlayListPath"
   End If
   Exit Sub
Error:
   WriteEvent "CreatePlayListFolder", Err.Description, Err.Source
End Sub

Private Sub RemoveTrack(pathName As String, index As Integer)
   On Error GoTo Error
   Dim t As IXMLDOMElement
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load (pathName)
   
   Set t = xmlPlaylist.firstChild
   t.removeChild t.childNodes(index)
   xmlPlaylist.Save pathName
   Exit Sub
Error:
   WriteEvent "RemoveTrack", Err.Description, Err.Source
End Sub
Private Sub EditSlyShow(pathName As String, OldIndex As Integer, OldName As String, Sp As String)
   On Error GoTo Error
   EditRegistrySlide ImageDir, Sp
   
   Dim t As IXMLDOMElement
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load (pathName & "\PlayLists\PlayLists.xml")
   Set t = xmlPlaylist.childNodes(0).childNodes(OldIndex)
   t.setAttribute "SlidePath", Sp
   xmlPlaylist.Save pathName & "\PlayLists\PlayLists.xml"
   Exit Sub
Error:
   WriteEvent "EditSlyShow", Err.Description, Err.Source
End Sub
Public Function ReadTrackInfoFromList(var_List As String) As String
   On Error GoTo Error
   Dim str As String

   Dim i As Integer
   Dim listIndex As Long
   Dim list_number() As String
   list_number = Split(var_List, ",")
   For i = 0 To UBound(list_number)
      If list_number(i) < int_track_count Then
         With PlayTrackInfo(list_number(i))
            str = str + .Album + "%%" + .UniAlbum + "%%" + .TRACK + "%%" + .UniTrack + "%%" + .ARTIST + "%%" + .UniArtist + "%%" + .Mood + "%%" + .UniMood + "%%" + .DanceStyle + "%%" + .UniDanceStyle + "%%" + .Rating + "%%" + .Genre + "%%" + .UniGenre + "%%" + .Mode + "%%" + .TrackID + "%%" + .picPath + "%%" + .Language + "%%" + .comName + "%%" + .albumID + "%%" + .LanTrack + "%%" + .TrackYear + "%%" + .TrackAva + "%%" + .walMartAva + "%%" + .ShoppingID + "%%" + .NoTrack + "&&" + .Player & "&&" & .DownloadFromServer & "&&&"
         End With
      End If
   Next
   ReadTrackInfoFromList = left(str, Len(str) - 3)
   Exit Function
Error:
   WriteEvent "ReadTrackInfoFromList", Err.Description, Err.Source
End Function

Private Sub swf_GotFocus(index As Integer)
   On Error Resume Next
   If bool_full_vis And str_swfNames <> "Micro" And GetActiveWindow = hwnd Then
      picMovieBackground.SetFocus
   End If
End Sub


Private Sub swfAddTrack_FSCommand(ByVal command As String, ByVal args As String)
   Select Case command
      Case "AddTrackByCode"
         If CWinsock.LoggedType = remoteControl Then
            CWinsock.Send2Server WS_COMMAND, "AddTrackByKey&&&" & args
         Else
            AddTrackByKey args
         End If
      Case "CloseInputBox"
         UnloadSwfAddTrack
   End Select
End Sub

Private Sub swfDVDControl_FSCommand(ByVal command As String, ByVal args As String)
   On Error GoTo Error
   Select Case command
      Case "noHideDVDControl"
         noHideDVDControl
      Case "select_subtitle"
           'miniCommand "select_subtitle|:|0"
           'SWF_FMA_FSCommand 1, "mini", command & "|:|0"                        'flash send 2 times if don't do this
           AddCommand "miniCommand", command & "|:|0", ""                        'flash send 2 times if don't do this
         'SWF_FMA_FSCommand 1, "mini", command & "|:|0"                        'flash send 2 times if don't do this
      Case "ServerFullScreen"
         CWinsock.Send2Server WS_COMMAND, "ServerFullScreen"
      Case "ServerVideoZoomIn"
         CWinsock.Send2Server WS_COMMAND, "ServerVideoZoomIn"
      Case "ServerVideoZoomOut"
         CWinsock.Send2Server WS_COMMAND, "ServerVideoZoomOut"
      Case "ServerKaraokeVoice"
         CWinsock.Send2Server WS_COMMAND, "ServerKaraokeVoice&&&" & LCase(Not b_karaoke_voice)
      Case "NextPrevious"
         If args = "Next" Then
            GotoTrack True
         ElseIf args = "Previous" Then
            GotoTrack False
         End If
      Case "mb"
         Debug.Print args
      Case Else
         SWF_FMA_FSCommand 1, command, args
   End Select
   Exit Sub
Error:
   WriteEvent "swfDVDControl_FSCommand", Err.Description, Err.Source
End Sub

Private Sub swfImagePlaying_FSCommand(ByVal command As String, ByVal args As String)
   If command = "mb" Then
      Debug.Print args
   End If
End Sub


Private Sub swfMiniControl_FSCommand(ByVal command As String, ByVal args As String)
   On Error GoTo Error
   'Debug.Print "Command=" & command, "args=" & args
   'Writelog "swfMiniControl_FSCommand", "EVENT", "On Event", "command = " & command & ", args= " & args
   If command = "mini" Then
      Dim str() As String
      str = Split(args, "|:|")
      If str(0) = "Next" And int_next_index = -1 Then int_next_index = 0
   End If
   
   Select Case command
      Case "NextPrevious"
         If args = "Next" Then
            GotoTrack True
         ElseIf args = "Previous" Then
            GotoTrack False
         End If
      Case "onFocus"
         sendVariable2Flash Swf(IndexSwf), "vb", "lostFocus"
         If swfMiniControl.Visible Then swfMiniControl.SetFocus
      Case "moveToShowInterface"
         If CWinsock.LoggedType <> remoteControl And Not run_FormVideoLoaded Then
            UnloadSwfMiniControl
         End If
         sendVariable2Flash Swf(IndexSwf), "vb", "setFocus|%|" & args
         Swf(IndexSwf).SetFocus
      Case "RightClick"
         If IndexSwf = 4 Then sendVariable2Flash FrmMain.Swf(IndexSwf), "RightClick", "true"
      Case "showOutterScreenPlayer"
         If seekTimeValue > 5 Then 'allow after 5 seconds
            If args = "true" Then
'''               If IsRegistered Then        'For registered user only          2007-03-27 Remove unregister restriction
                  frmVideo.Show
                  DoEvents
                  swfMiniControl.SetFocus
'''               End If
            Else
               Unload frmVideo
            End If
         Else
            sendToFlash FrmMain.swfMiniControl, "FullScreenIn", IIf(args = "true", "False", "true")
         End If
      Case "mb"
         Debug.Print args
      Case Else
         
         SWF_FMA_FSCommand 1, command, args
   End Select
   Exit Sub
Error:
   WriteEvent "swfMiniControl_FSCommand, Command = " & command & ", args = " & args, Err.Description, Err.Source
End Sub

Private Sub swfPopupFullPlayer_FSCommand(ByVal command As String, ByVal args As String)
   On Error GoTo Error
   Dim captionHeight As Integer
   Select Case command
      Case "showPopupInfo"
         If WinMode = "FullScreen Mode" Then
            captionHeight = 0
         Else
            captionHeight = ScaleY(GetSystemMetrics(SM_CYCAPTION) + 6, vbPixels, vbTwips)      'shift by 6 pixel include screen edge
         End If
         If Settings.setDisplayDvdContol = 1 And bool_full_vis = True Then           'Top
             picPopup.Move (Width - picPopup.Width) / 2, 0, picPopup.Width, picPopup.Height
         Else             'Bottom
            picPopup.Move (Width - picPopup.Width) / 2, FrmMain.Height - picPopup.Height - captionHeight, picPopup.Width, picPopup.Height
         End If
         picPopup.Visible = True
         swfPopupFullPlayer.Visible = True
         picPopup.ZOrder 0
         If str_swfNames <> "Micro" And bool_full_vis = False And run_bShowingInputCode = False Then
            On Error Resume Next
            Swf(IndexSwf).SetFocus
            On Error GoTo Error
         End If
      Case "hideTrackShow"
         If Not ((CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded)) Or bool_full_vis = False Then
            picPopup.Visible = False
         End If
         
      Case "mb"
         Debug.Print args
   End Select
   Exit Sub
Error:
   WriteEvent "swfPopupFullPlayer_FSCommand", Err.Description, Err.Source
End Sub

Private Sub swfPopupFullPlayer_GotFocus()
   On Error Resume Next
   If run_bShowingInputCode Then
      'swfAddTrack.SetFocus
      LoadSwfAddTrack
   ElseIf swfDVDControl.Visible Then
      swfDVDControl.SetFocus
   End If
   
End Sub

Private Sub tmr_press_select_chapter_Timer()
   On Error GoTo Error
   If int_nextPrevious_index >= 0 Then
      handleMinicommand "SelectedPlaylist|:|" & int_nextPrevious_index
      int_nextPrevious_index = -1
   Else
      'tmr_press_select_chapter.Enabled = False
'      If LCase(fso.GetExtensionName(str_current_Track)) = "ifo" And (PlayTrackInfo(int_current_index).BookmarkType = 1 Or Infos(int_current_index).trackExternal) Then
         handleMinicommand "selectChapter|:|" & index_selecte_chapter
         index_selecte_chapter = ""
 '     Else
''         handleMinicommand "SelectedPlaylist|:|" & CLng(index_selecte_chapter) - 1
''         index_selecte_chapter = ""
''      End If
   End If
   tmr_press_select_chapter.Enabled = False
   Exit Sub
Error:
   WriteEvent "tmr_press_select_chapter_Timer", Err.Description, Err.Source
   
End Sub

Private Sub tmrFindTime_Timer()
   On Error GoTo Error
 'xx created sith 23-05-06 xxxxxxxxxxxxxxx
 ' used for wait for CWmp currentPosition change
'''    Dim controls As IWMPControls2
'''    Set controls = CWmp.controls
 
'''   If OldWMPPos <> val(CWmp.controls.currentPosition) Then
   Dim iLanguageType As Integer
   If OldWMPPos <> val(CPlayer.Seeks) Then
      If CurrentFind = Duration Then
         If val(CPlayer.Seeks) > 5 Then
            'Sleep 100
            Debug.Print "sleep "
            PlayTrackInfo(int_current_index).BookmarkLength = CPlayer.Seeks
            'Debug.Print "Time get from find Duration = " & PlayTrackInfo(int_current_index).BookmarkLength
            CurrentFind = Position
            
            OldWMPPos = CPlayer.Seeks
            CPlayer.SelectChapter PlayTrackInfo(int_current_index).NoTrack - 1
            'playIFO
         End If
      ElseIf CurrentFind = Position Then
         If int_track_count > int_current_index And int_current_index >= 0 Then
            If (PlayTrackInfo(int_current_index).BookmarkLength - CPlayer.Seeks) > 2 Then
                Sleep 100
                Debug.Print "Sleep"
                PlayTrackInfo(int_current_index).BookmarkTime = CPlayer.Seeks
                CurrentFind = findnone
                
                If PlayTrackInfo(int_current_index).BookmarkLength - PlayTrackInfo(int_current_index).BookmarkTime < 5 Then
                     PlayTrackInfo(int_current_index).BookmarkLength = 0
                     PlayTrackInfo(int_current_index).BookmarkTime = -1
                ElseIf PlayTrackInfo(int_current_index).BookmarkType = 4 Then
                     If PlayTrackInfo(int_current_index).BookmarkLength - PlayTrackInfo(int_current_index).BookmarkTime > 600 Then
                        iLanguageType = get_country_type(PlayTrackInfo(int_current_index).Language)
                        If iLanguageType = 4 Or iLanguageType = 8 Or iLanguageType = 16 Then
                           ShowDebug "    Error checking time" & vbTab & PlayTrackInfo(int_current_index).BookmarkLength & vbTab & PlayTrackInfo(int_current_index).BookmarkTime
                           PlayTrackInfo(int_current_index).BookmarkLength = 0
                           PlayTrackInfo(int_current_index).BookmarkTime = -1
                        End If
                     End If
                End If
                playIFO
            ElseIf OldWMPPos < CPlayer.Seeks Then
               If (PlayTrackInfo(int_current_index).BookmarkLength - CPlayer.Seeks) < 0 Then
                  PlayTrackInfo(int_current_index).BookmarkLength = 0
                  PlayTrackInfo(int_current_index).BookmarkTime = -1
                  playIFO
               End If
            End If
         Else
            CurrentFind = findnone
         End If
       ElseIf CurrentFind = seekTime Then
       End If
   End If
   If Abs(OldWMPPos - CPlayer.Seeks) > 2 And CurrentFind = seekChapter Then
      CurrentFind = findnone
      CWinsock.Send2Client WS_COMMAND, 0, "setFakeTime&&&" & CPlayer.Seeks & "&&&" & CPlayer.Duration & "&&&" & getPlayState
      CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & CPlayer.Seeks & "&&&" & getPlayState
   End If
   If CurrentFind = callFuntion Then
      If CPlayer.MediaIsnothing = False Then
         If CPlayer.Duration > 0 Then
            startNew = False
            CurrentFind = findnone
            playIFO
         End If
      End If
   ElseIf CurrentFind = clientLoaded Then
      Dim iLocalValue As Single
      iLocalValue = CPlayer.Seeks
      'changed sith 23-05-06 client need not load time
      If iLocalValue <> OldWMPPos Then
         CurrentFind = findnone
         If int_track_count > 0 Then
            If run_WaitingMode Then
               iLocalValue = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
               CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & iLocalValue & "&&&" & getPlayState & "&&&" & PlayTrackInfo(int_current_index).BookmarkLength & "&&&" & PlayTrackInfo(int_current_index).BookmarkTime
               CPlayer.Seeks = iLocalValue
               boolPausedState = False
            Else
                iLocalValue = CPlayer.Seeks
                CWinsock.Send2Client WS_COMMAND, lastLoadClientIndex, "setSeekTime&&&" & iLocalValue & "&&&" & getPlayState & "&&&" & PlayTrackInfo(int_current_index).BookmarkLength & "&&&" & PlayTrackInfo(int_current_index).BookmarkTime
            End If 'run_waitingmode
            run_WaitingMode = False
            FrmMain.tmr.Enabled = True
         End If 'track count > 0
      End If 'oldwmpPos <>ilocalvalue
   ElseIf CurrentFind = subTitled Then
      Screen.MousePointer = vbHourglass
      If CPlayer.Seeks > 2 Then
          If left(CPlayer.Status, 7) = "Playing" Or CPlayer.Status = "Finished" Then
             CurrentFind = findnone
             If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentMode) Then
                  CPlayer.Seeks = OldWMPPos
                  If CWinsock.isServerConnected Then
                     Sleep 1000
                     CWinsock.Send2Client WS_COMMAND, 0, "Minicommand&&&enabled_subtitle|:|" & PlayTrackInfo(int_current_index).SubTitle 'once subtitle value was change
                  End If
                  timeVisible = OldWMPPos
                  FrmMain.tmr.Enabled = True
             ElseIf CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
                CWinsock.Send2Server WS_COMMAND, "other&&&requestSeek"
             End If
             run_loading = False
             startNew = False
             Screen.MousePointer = vbDefault
         End If
     End If 'oldwmppos
   End If ' currentfind
   'xxxxxxxxxx end xxxxxxxxxxxxxxxxx
   Exit Sub
Error:
   WriteEvent "tmrFindTime_Timer", Err.Description, Err.Source
End Sub

Private Sub tmrOneSecond_Timer()
   Static iIntervalConnected As Integer
   On Error GoTo Error
   If (CWinsock.LoggedType <> remoteControl) And (Not (run_FormVideoLoaded)) Then
      If run_TimeHidePassed >= int_Time2HideDVD Then
         GetCursorPos MousePosition
         UnloadSwfDvdControl                                'Don't test the condition then hide con
         run_TimeHidePassed = 0
      ElseIf run_bDisplayingDVDControl Then
         run_TimeHidePassed = run_TimeHidePassed + 1  'increase
      End If
   End If 'changed sith 29-05-06
   If bool_full_vis And str_swfNames <> "Micro" Then              'to hide mouse only in fullscreen video mode    /seng 2005-08-22
      If run_TimeHideMouse >= int_Time2HideMouse Then
         run_TimeHideMouse = 0
         ShowMouse = False
      Else
         run_TimeHideMouse = run_TimeHideMouse + 1
      End If
   End If
   If run_DelayRefreshPopup > 0 Then
      If run_DelayRefreshPopup = 1 And bool_full_player Then
         popUp
      End If
      run_DelayRefreshPopup = run_DelayRefreshPopup - 1
   End If
   'Fake time control pla
   If CWinsock.LoggedType = remoteControl Then           'fake times
      If run_PlayState = 1 And int_track_count > 0 Then
         If run_FakeSeekTime < run_FakeSeekMax Then
         'If run_FakeTime < run_FakeSeekMax Then
            run_FakeSeekTime = run_FakeSeekTime + 1
            'run_FakeTime = run_FakeTime + 1
            DisplaySeekBarInfo (run_FakeSeekTime / run_FakeSeekMax) & "|%|" & Second2Time(run_FakeSeekTime, True) & " / " & Second2Time(run_FakeSeekMax, True)
            'DisplaySeekBarInfo (run_FakeTime / run_FakeSeekMax) & "|%|" & Second2Time(run_FakeTime, True) & " / " & Second2Time(run_FakeSeekMax, True)
         End If
      End If
   Else
      If run_PlayState <> 3 And Not b_play And b_pause = False And (CWinsock.LoggedType = cloneDisplay Or CWinsock.LoggedType = remotePlaylist) And run_FakeSeekMax > 0 And int_track_count > 0 Then
         'only use this when client can't play file and in clonedisplay or remotePlaylist
         If run_FakeSeekTime < run_FakeSeekMax Then
         'If run_FakeTime < run_FakeSeekMax Then
            run_FakeSeekTime = run_FakeSeekTime + 1
           ' run_FakeTime = run_FakeTime + 1
            DisplaySeekBarInfo (run_FakeSeekTime / run_FakeSeekMax) & "|%|" & Second2Time(run_FakeSeekTime, True) & " / " & Second2Time(run_FakeSeekMax, True)
            ' DisplaySeekBarInfo (run_FakeTime / run_FakeSeekMax) & "|%|" & Second2Time(run_FakeTime, True) & " / " & Second2Time(run_FakeSeekMax, True)
         End If
      End If
   End If
   If CWinsock.LoggedType <> ServerMode Then          ''EDIT:2006-10-30 Seng
      If iIntervalConnected >= 600 Then
         CWinsock.Send2Server WS_COMMAND, "PreventTimeOut"                 'Send to server every changing track prevent from error time-out
         iIntervalConnected = 0
      Else
         iIntervalConnected = (iIntervalConnected + 1) 'Mod 600
      End If

   End If
   If run_WaitingMode And CWinsock.LoggedType = ServerMode And int_track_count > 0 Then
      run_WaitingMinute = run_WaitingMinute + 1
      If run_WaitingMinute > 30 Then    'if wait  more than 1 minute
         loadMusicFromWaitng 0           'resume from waiting
         run_WaitingMinute = 0
      End If
   End If
'=========================================================================
   Exit Sub
Error:
   WriteEvent "tmrOneSecond_Timer", Err.Description, Err.Source
End Sub
Public Sub UnloadSwfMiniControl()
   On Error GoTo Error
   'swfMiniControl.Visible = False
   'DoEvents          'else it won refresh pic_time_popup(still display)
   picMini.Visible = False
   pic_time_popup.Visible = False
  ' Swf(IndexSwf).SetFocus
   Exit Sub
Error:
   WriteEvent "UnloadSwfMiniControl", Err.Description, Err.Source
End Sub
Private Sub UnloadSwfDvdControl()
   On Error GoTo Error
   picDVD.Visible = False
   Sleep 5
   pic_time_popup.Visible = False
   run_bDisplayingDVDControl = False
   Exit Sub
Error:
   WriteEvent "UnloadSwfDvdControl", Err.Description, Err.Source
End Sub
Public Sub LoadSwfMiniControl()
   On Error GoTo Error
   'EDIT:2006-08-02
   With swfMiniControl
      Dim controlWidth As Long
      Dim controlHeight As Long
      Dim miniWidth As Long
      Dim miniHeight As Long
      Dim seekPercent As Single
      Dim iPositionLeft As Single
      Dim iPositionTop As Single
      Dim iDBType As Integer
      'Dim scalePercent As Single
      If Not picMini.Visible Then                            'Don't display it again if it displays
         LoadSwf swfMiniControl, App.path & "\sly\minicontrol.sly"
         sendVariable2Flash swfMiniControl, "ClientType", CWinsock.LoggedType
         theme swfMiniControl
         b_ShowControlInPlayer = False          'First time don't display control unless click on video area
         
         If CWinsock.LoggedType = remoteControl Then
            sendToFlash swfMiniControl, "play", CStr(run_PlayState = 1)
         Else
            sendToFlash swfMiniControl, "play", CStr(b_play)
         End If
         sendToFlash swfMiniControl, "setColor", "theme"
         sendToFlash swfMiniControl, "mute", CStr(b_mute)
         sendToFlash swfMiniControl, "volume", CStr(WaveVolume)
         sendToFlash swfMiniControl, "loop", CStr(b_loop)
         sendToFlash swfMiniControl, "shuffle", CStr(b_shuffle)
         If int_track_count > 0 And int_current_index >= 0 Then
            iDBType = get_country_type(PlayTrackInfo(int_current_index).Language)
         End If
         sendVariable2Flash swfMiniControl, "databaseType", iDBType
         sendToFlash swfMiniControl, "KaraokeAudio", CStr(b_karaoke_voice)         'Send karaoke channel to voice
         sendToFlash swfMiniControl, "monitor", CStr(MonitorCount)     'Send karaoke channel to voice

         
         setColorMiniControl
         If seekTimeLength = 0 Then seekPercent = 0 Else seekPercent = seekTimeValue / seekTimeLength
   
         '385/800=/100
         
         controlWidth = ScaleX(GetFlashVar(swfMiniControl, "StageWidth"), vbPixels, vbTwips)        'get width from flash with variable StageWidth
         controlHeight = ScaleY(GetFlashVar(swfMiniControl, "StageHeight"), vbPixels, vbTwips)      'get width from flash with variable StageHeight
         If controlWidth <> 0 Then
            run_MiniScalePercent = picwmp.Width / controlWidth 'ScaleX(Swf(IndexSwf).Width, vbTwips, vbPixels) / 2000
            
            controlWidth = controlWidth * run_MiniScalePercent
            controlHeight = controlHeight * run_MiniScalePercent
            .Move 0, 0, controlWidth, controlHeight
            ''2006-05-27
            If ((CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded)) Then
               iPositionLeft = picwmp.left + (picwmp.Width - controlWidth) / 2
               iPositionTop = picwmp.top + (picwmp.Height - controlHeight) / 2
            Else
               iPositionLeft = picwmp.left + (picwmp.Width - controlWidth) / 2
               iPositionTop = picwmp.top - controlHeight
            End If
            picMini.Move iPositionLeft, iPositionTop, controlWidth, controlHeight
            
            picMini.Visible = True
            picMini.ZOrder 0
            .ZOrder 0
            tmrMouse.Enabled = True
            boolLooping = False
            If b_play Then sendToFlash swfMiniControl, "seek", seekBarpercent & "|%|" & seekBarDisplay
            sendToFlash swfMiniControl, "FullScreenIn", CStr(run_FormVideoLoaded)
        End If
      End If
   End With
   Exit Sub
Error:
   WriteEvent "LoadSwfMiniControl", Err.Description, Err.Source
End Sub
Private Sub ShowHideDVDControl(showControl As Boolean, scalePercent As Single, boolFlip As Boolean)
   On Error GoTo Error
   'Show/Hide control in volume bar
   Dim iScaleHeight As Long
   If boolFlip Then iScaleHeight = ScaleY(swfDVDControl.Height, vbTwips, vbPixels) Else iScaleHeight = -1   ' -1 not flip
   
   If showControl = False Then
      'SetWindowRgn picDVD.hwnd, LoadRegionFromFile(App.path & "\DVDControl.rgn", scalePercent, iScaleHeight), True
      SetWindowRgn picDVD.hwnd, ScaleRegion(run_Region, scalePercent, iScaleHeight), True
      
      sendToFlash swfDVDControl, "ShowHideControl", CStr(showControl)
   Else
      SetWindowRgn picDVD.hwnd, ScaleRegion(run_RegionFull, scalePercent, iScaleHeight), True
      sendToFlash swfDVDControl, "ShowHideControl", CStr(showControl)
   End If
   picDVD.ZOrder 0
   picMovieBackground_GotFocus               'setfocus to make again
   Exit Sub
Error:
   WriteEvent "ShowHideDVDControl", Err.Description, Err.Source
End Sub
Public Sub LoadSwfAddTrack()
   On Error GoTo Error
   Dim controlWidth As Single
   Dim controlHeight As Single
   
   Dim newWidth As Single
   Dim newHeight As Single
   Dim scalePercent As Single
   
   swfAddTrack.Movie = "None"
   LoadSwf swfAddTrack, App.path & "\sly\AddTrackByCode.sly"
   
   controlWidth = ScaleX(GetFlashVar(swfAddTrack, "StageWidth"), vbPixels, vbTwips)        'get width from flash with variable StageWidth
   controlHeight = ScaleY(GetFlashVar(swfAddTrack, "StageHeight"), vbPixels, vbTwips)      'get width from flash with variable StageHeight
   'Scale( scalePercent
   'scalePercent = (400 / 800 * Width) / 400 '42000 / Width
   'newWidth = scalePercent * controlWidth
   newWidth = 600 / 800 * Width
   scalePercent = newWidth / controlWidth
   newHeight = scalePercent * controlHeight
   
   swfAddTrack.Move (Width - newWidth) / 2, 100 / 800 * Height, newWidth, newHeight
   swfAddTrack.Visible = True
   swfAddTrack.ZOrder
   swfAddTrack.SetFocus
   clsKeyboard.SetKeyBoardLanguage "English"                      'Reset back to english input
   'LoadSwfAddTrack
   run_bShowingInputCode = True
   swfAddTrack.SetVariable "ShowForm", "1"
Error:
   
End Sub
Private Sub UnloadSwfAddTrack()
   On Error GoTo Error
   swfAddTrack.Visible = False
   run_bShowingInputCode = False
   If str_swfNames = "Fullscreen" Then
      SWF_FMA(1).SetFocus
   Else
   
      If swfDVDControl.Visible Then swfDVDControl.SetFocus
   End If
Error:
   
End Sub

Public Sub LoadSwfDvdControl()
   On Error GoTo Error
   With swfDVDControl
      Dim controlWidth As Long
      Dim controlHeight As Long
      Dim captionHeight As Long
      Dim iBorderThick As Integer
      LoadSwf swfDVDControl, App.path & "\sly\dvdcontrol.sly"
      
      b_ShowControlInPlayer = False          'First time don't display control unless click on video area
      run_bDisplayingDVDControl = True
      
      'send theme
      theme swfDVDControl
      sendToFlash swfDVDControl, "setColor", "theme"
      If WinMode = "FullScreen Mode" Then           'if in full screen mode then dont make space for caption
         
          'iBorderThick = 0
         captionHeight = 0
      Else
         'iBorderThick = ScaleX(GetSystemMetrics(SM_CXEDGE), vbPixels, vbTwips) * 2
         'iBorderThick = ScaleX(50, vbPixels, vbTwips)
         captionHeight = ScaleY(GetSystemMetrics(SM_CYCAPTION) + 6, vbPixels, vbTwips)      'shift by 6 pixel include screen edge
      End If
      iBorderThick = ScaleX(50, vbPixels, vbTwips)
         
      run_DVDScalePercent = ScaleX(Me.Width - iBorderThick, vbTwips, vbPixels) / 1920  '1920 the wide original of the player
      controlWidth = ScaleX(.GetVariable("StageWidth"), vbPixels, vbTwips)        'get width from flash with variable StageWidth
      controlHeight = ScaleY(.GetVariable("StageHeight"), vbPixels, vbTwips)     'get width from flash with variable StageHeight
      controlWidth = controlWidth * run_DVDScalePercent
      controlHeight = controlHeight * run_DVDScalePercent
      
      
      If Settings.setDisplayDvdContol = "1" Then
         'Bottom
         picDVD.Move (Width - controlWidth) / 2, Height - controlHeight - captionHeight, controlWidth, controlHeight
         sendToFlash swfDVDControl, "restoreFlip", ""
      ElseIf Settings.setDisplayDvdContol = "0" Then
         'Top
         picDVD.Move (Width - controlWidth) / 2, 0, controlWidth, controlHeight
         sendToFlash swfDVDControl, "flipVertical", ""
      Else: Exit Sub
      End If
      .Move 0, 0, controlWidth, controlHeight
      displayTimeInPictureBox
      .Visible = False
      .Visible = True
      
      'load region file that was made by program
      'send curring playing dvd control
      ShowHideDVDControl b_ShowControlInPlayer, run_DVDScalePercent, (Settings.setDisplayDvdContol = "0")
      picDVD.Visible = True
      'If b_play Then sendToFlash swfDVDControl, "seek", seekBarpercent & "|%|" & seekBarDisplay
      sendToFlash swfDVDControl, "seek", seekBarpercent & "|%|" & seekBarDisplay
      sendToFlash swfDVDControl, "mute", CStr(b_mute)
      sendToFlash swfDVDControl, "KaraokeAudio", CStr(b_karaoke_voice)         'Send karaoke channel to voice
      
      If CWinsock.LoggedType = remoteControl Then
         ShowPlayState2Flash (run_PlayState = 1) 'Playing
      End If
      
      noHideDVDControl
      If int_current_index > -1 Then
         sendVariable2Flash swfDVDControl, "databaseType", get_country_type(PlayTrackInfo(int_current_index).Language)
      End If
   End With
   Exit Sub
Error:
   WriteEvent "LoadSwfDvdControl", Err.Description, Err.Source
End Sub

Public Function ScaleObjectFlash(SwfFlash As ShockwaveFlashObjectsCtl.ShockwaveFlash)
   On Error GoTo Error
   'EDIT:2006-08-23 Seng
   Dim controlWidth As Long
   Dim controlHeight As Long
   Dim scalePercent As Single
   Dim captionHeight  As Integer
   
   With SwfFlash
      controlWidth = ScaleX(.GetVariable("StageWidth"), vbPixels, vbTwips)        'get width from flash with variable StageWidth
      controlHeight = ScaleY(.GetVariable("StageHeight"), vbPixels, vbTwips)     'get width from flash with variable StageHeight
      
      .Move 0, 0, FrmMain.Width, (controlHeight * FrmMain.Width) / controlWidth
      
      picPopup.Height = .Height
      picPopup.Width = .Width
      If WinMode = "FullScreen Mode" Then           'if in full screen mode then dont make space for caption
         captionHeight = 0
      Else
         captionHeight = ScaleY(GetSystemMetrics(SM_CYCAPTION) + 6, vbPixels, vbTwips)      'shift by 6 pixel include screen edge
      End If
      
      ' 2006-12-28
      ' p-icPopup.top = FrmMain.Height - picPopup.Height - captionHeight
   End With
   Exit Function
Error:
   WriteEvent "ScaleObjectFlash", Err.Description, Err.Source
End Function
Private Sub tmrSlideShow_Timer()
   On Error GoTo Error
  Dim newPos As POINTAPI
  GetCursorPos newPos
   If (GetActiveWindow = hwnd) Then
      If b_play Then
         If isVideoFile(Infos(int_current_index).TrackPath) Or CWinsock.LoggedType = remoteControl Then
            interValCount = 0
            Exit Sub
            'don increase the timer
         End If
      End If
      If (newPos.x = oldPos.x) Then
         interValCount = interValCount + 1
      Else
         interValCount = 0
      End If
      If int_track_count > 0 And int_current_index >= 0 Then
         If isSoundFile(PlayTrackInfo(int_current_index).TrackPath) And CWinsock.LoggedAs(ServerMode) Then
            'Only Load slide show when it in servermode and sound files only
            If interValCount >= SlideSecond Then
               If GetAttSetting(1, "SlideShowMode") = "External" Then
                  ExeSlideShow
               Else
                  frmSlideShow.Show
               End If
               interValCount = 0
            End If
            If interValCount > SlideSecond + 1 Then interValCount = SlideSecond + 1
         End If
      End If
   Else
      interValCount = 0
   End If
  oldPos = newPos
   Exit Sub
Error:
   WriteEvent "tmrSlideShow_Timer", Err.Description, Err.Source
End Sub
Sub ExeSlideShow()
   On Error GoTo Error
    Dim strSlide As String
    strSlide = fso.GetSpecialFolder(1) & "\ssmypics.scr"
    ShellExecute hwnd, "Open", strSlide, "", "", 1
   Exit Sub
Error:
   WriteEvent "ExeSlideShow", Err.Description, Err.Source
End Sub

Private Sub Timer2_Timer()
    If bExitingProgram = True Then
        Unload Me
    End If
End Sub

Private Sub tmr_hide_cmdFull_Timer()
   On Error GoTo Error
   Dim xy As POINTAPI, pt As POINTAPI, Out As Boolean
   Dim ptLeft As Integer, ptTop As Integer, ptHeight As Integer, ptWidth As Integer

   
   ptLeft = left / Screen.TwipsPerPixelX: ptTop = top / Screen.TwipsPerPixelY: ptWidth = Width / Screen.TwipsPerPixelX: ptHeight = Height / Screen.TwipsPerPixelY
   GetCursorPos xy
   Out = (ptLeft > xy.x Or ptLeft + ptWidth < xy.x) Or (ptTop > xy.Y Or ptTop + ptHeight < xy.Y)
   Exit Sub
Error:
   WriteEvent "tmr_hide_cmdFull", Err.Description, Err.Source
End Sub

Private Sub tmr_startPlay_Timer()
   If CopyingSong And int_track_count > 0 And int_current_index <> -1 And int_current_index < int_track_count Then
      If StrComp(DownloadingMusic.TrackID, Infos(int_current_index).TrackID, vbTextCompare) = 0 And DownloadingMusic.Language = Infos(int_current_index).TrackLan Then
         Infos(int_current_index).TrackPath = DownloadingMusic.ToTrackPath
         If GetFileSizes(Infos(int_current_index).TrackPath) > 500000 Then
            b_play = False
            miniCommand "Play|:|true"
            CWinsock.Send2Server WS_COMMAND, "other&&&requestSeek"
            tmr_startPlay = False
         End If
      End If
   End If
'   Debug.Print "inteveal " & cDownload.getDownloadedBytes / 1024 & " KBytes"
End Sub

Private Sub tmr_Timer()
   On Error GoTo Error
    Dim CP As Long
    Dim du As Long
    Static oldPositionDuration As Long
    Dim InputSeekStart As Long
    Dim inputSeekEnd As Long
    Dim iSeekLength As Long
    Dim iSeekPosition As Long
    Dim iLanID As Integer
    Dim iMaxLen As Integer
    
'''    If CWmp.Status = "Stopped" Then
    If CPlayer.playState = wmppsStopped Then
        tmr.Enabled = False
        If b_shuffle = False Then get_next_previouse_index
        If int_next_index = -1 Then
        
            If Infos(int_current_index).TrackID <> "" And Infos(int_current_index).trackExternal = False Then
                If b_addPlayCount = False Then
                    b_addPlayCount = True
                    setPlayCount CLng(Infos(int_current_index).TrackID), Infos(int_current_index).TrackLan, CInt(int_current_index)
                End If
            End If
            
            If ((CWinsock.LoggedAs(ServerMode)) Or (CWinsock.LoggedAs(independentMode))) Then
                miniCommand "Stop|:|true"
            End If
            
        Else
            If int_current_index < int_track_count Then
               If Infos(int_current_index).TrackID <> "" And Infos(int_current_index).trackExternal = False Then
                   If b_addPlayCount = False Then
                       b_addPlayCount = True
                       setPlayCount CLng(Infos(int_current_index).TrackID), Infos(int_current_index).TrackLan, CInt(int_current_index)
                       
                       If ((CWinsock.LoggedAs(ServerMode)) Or (CWinsock.LoggedAs(independentMode))) Then
                           'check track ava in database...........
                           CheckTrackAvaible int_next_index
                           refreshPlaylistPlayer True
                        End If
                       
                   End If
               End If
            End If
            
            If ((CWinsock.LoggedAs(ServerMode)) Or (CWinsock.LoggedAs(independentMode))) Then
               If autoPlayer(int_next_index) Then Exit Sub
                  If (int_current_index = (int_track_count - 1) And int_track_count > 0) Then
                     If b_shuffle = True Or b_loop = True Then
                        tmr.Enabled = False
                        'miniCommand "SelectedPlaylist|:|" & int_next_index
                        handleMinicommand "SelectedPlaylist|:|" & int_next_index
                     Else
                        tmr.Enabled = False
                        miniCommand "Stop|:|true"
                     End If
                  Else
                     'xxx error when play last chapter, client wait for server than it'll play next chapter
                     picMovieBackground.Visible = False
                     CPlayer.Pause
                     'xxx end xxx
                     tmr.Enabled = False
                     'miniCommand "SelectedPlaylist|:|" & int_next_index
                     handleMinicommand "SelectedPlaylist|:|" & int_next_index
                  End If
            End If
            
        End If
    End If
    If CPlayer.MediaIsnothing = False Then
      If CPlayer.playState = wmppsPlaying Or CPlayer.Duration > 0 Then
          CP = CLng(CPlayer.Seeks)
          du = CLng(CPlayer.Duration)
          GetTrackSeekStart_End InputSeekStart, inputSeekEnd, du          'retrieve the seek value
          iSeekLength = inputSeekEnd - InputSeekStart
          iSeekPosition = CP - InputSeekStart
          iSeekLength = IIf(iSeekLength <= 0, 1, iSeekLength)
          iSeekPosition = IIf(iSeekPosition < 0, 0, iSeekPosition)
      End If
   End If
   '==================================================================
   If du <> 0 And b_play And CurrentFind <> subTitled Then
    
      seekBarDisplay = Second2Time(iSeekPosition, True) & " / " & Second2Time(iSeekLength, True)
      seekBarpercent = iSeekPosition / iSeekLength
      DisplaySeekBarInfo seekBarpercent & "|%|" & seekBarDisplay
      Call SendSeek2Player(CP, du, iSeekPosition & "&&&" & iSeekLength)
      'xxx changed sith 25-05-06 xxx
      'If iSeekPosition > 1 Then
      
      iLanID = get_country_type(PlayTrackInfo(int_current_index).Language)
      If iLanID = 1 Or iLanID = 2 Then
         'Movie and TVSeries
         iMaxLen = 900
      Else
         'Karaoke,Music,External
         iMaxLen = 90
      End If
      If iSeekPosition >= BannerCurrent.start And run_FormVideoLoaded And BannerDisplayed = False And UBound(Banners) >= 0 Then
         BannerDisplayed = True
         frmVideo.showAdv True
      End If
      If iSeekPosition >= iMaxLen Then
         'If run_bVolumeMuted = False And run_iPlayTrackCount > int_MaxPlayCount Then
         'Remove the 90 second limit when in client/server mode, so can test client/server '2015-03-01
'''         If run_bVolumeMuted = False And run_iPlayTrackCount > 0 Then
'''            Popup_Dialog Change("9eyrKZbiryrg", True), Change("QAljJr Jjirg", True)
'''            CPlayer.Volume = 0
'''            run_bVolumeMuted = True
'''         End If
      End If
      If (CP > timeVisible + 1) Or CPlayer.PlayWith = PowerDVD Then
         If run_FormVideoLoaded Then
            If CPlayer.hVideo(FrmMain.picMovieBackground.hwnd) <> 0 Then frmVideo.ResetVideoParent
         Else
            If Not FrmMain.picMovieBackground.Visible And picwmp.Visible Then FrmMain.picMovieBackground.Visible = True
         End If
         If int_current_index >= 0 And int_track_count >= 0 Then
            If run_iVolumeLevel > 0 And run_LoadingLastMusic = False Then
               If CPlayer.Volume = 0 And b_mute = False And run_bVolumeMuted = False Then
                  CPlayer.Volume = WaveVolume    'unmute
               End If
            End If
         End If
         timeVisible = 0
         'xxx changed sith 26-05-06 exit slide show if movie file xxxx
         If Not isSoundFile(str_current_Track) Then
            If LoadSlideshow Then
               frmSlideShow.exit_slideshow "Close"
            End If
         End If
         'xxx end xxx
      End If
      ' Do not blink and sound seek
      'xxx end xxx
   End If
   'don't change track while it is in root menu
   'set to 1 sec before ending playing video
   If (iSeekPosition + 2) >= iSeekLength And CPlayer.IsInMenuMode = False And iSeekLength > 0 And run_LoadingLastMusic = False Then
      If b_shuffle = False Then get_next_previouse_index
      If int_current_index >= 0 Then                     '2006-07-17
         If Infos(int_current_index).trackExternal = False Then
            If b_play Then setPlayCount val(Infos(int_current_index).TrackID), Infos(int_current_index).TrackLan, CInt(int_current_index)
         End If
      End If
      If Not autoPlayer(int_next_index) Then
         If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentMode) Then
            If (int_current_index = (int_track_count - 1) And int_track_count > 0) Then
               If b_shuffle = True Or b_loop = True Then
                  tmr.Enabled = False
                  handleMinicommand "SelectedPlaylist|:|" & int_next_index
               Else
                  miniCommand "Stop|:|true"
                  tmr.Enabled = False
               End If
            Else
               'xxx error when play last chapter, client wait for server than it'll play next chapter
               tmr.Enabled = False
               CPlayer.Pause
               picMovieBackground.Visible = False
               handleMinicommand "SelectedPlaylist|:|" & int_next_index
            End If
         Else
            tmr.Enabled = False
            miniCommand "Stop|:|true"           'stop client
         End If
      End If
   End If
   oldPositionDuration = CP
   Exit Sub
Error:
   WriteEvent "tmr_Timer", Err.Description, Err.Source
End Sub

Private Sub tmrDownload_Timer()
   Static boolExecutingCommand As Boolean

   If (Not cDownload.Downloading) Then
      If cDownload.DownloadItemCount > 0 Then
         cDownload.StartDownload
      End If
   Else
'''      Debug.Print "Downloaded " & cDownload.getDownloadedBytes / 1024 & " /" & cDownload.getDownloadSize / 1024
   End If
   If boolExecutingCommand = False Then
      boolExecutingCommand = True
      If collectionCommand.count > 0 Then
         Dim commandClass As clsExecuteCommand
         Set commandClass = collectionCommand.item(1)
         Select Case commandClass.CommandString
            Case "LoadPlayMusicPlayer"
               LoadPlayMusicPlayer (commandClass.ArgumentString)
            Case "miniCommand"
               miniCommand commandClass.ArgumentString
               If commandClass.fromHandleMinicommand And (CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentServer)) Then
                  'if it is server
                  CWinsock.Send2Client WS_COMMAND, 0, "Minicommand" & de_Record & commandClass.ArgumentString
               End If
            Case "FunOptions"
               FunOptions commandClass.ArgumentString, commandClass.ArgumentString2
               splitSetting
            Case "MoveTrack" 'xxx changed sith 6-06-06
               MoveTrack commandClass.ArgumentString, commandClass.ArgumentString2
            Case "GetArtistTrack"
               swf_FSCommand IndexSwf, "GetArtistTrack", commandClass.ArgumentString
               'sith 21/10/06
         End Select
         collectionCommand.Remove 1
      End If
      boolExecutingCommand = False
   End If
End Sub

Private Sub tmrMouse_Timer()
   On Error GoTo Error
   Dim xy As POINTAPI, pt As POINTAPI, Out As Boolean
   Static PointOldMouse As POINTAPI
   Dim ptLeft As Integer, ptTop As Integer, ptHeight As Integer, ptWidth As Integer


   If boolLooping Then
      If str_swfNames = "Micro" Then
         GetCursorPos xy
         xy.x = xy.x * Screen.TwipsPerPixelX: xy.Y = xy.Y * Screen.TwipsPerPixelY
         
         Out = (left > xy.x Or left + Width < xy.x) Or (top > xy.Y Or top + Height < xy.Y)
         If frmOver.Visible And Out = True Then
            Out = ((frmOver.left > xy.x Or frmOver.left + frmOver.Width < xy.x) Or (frmOver.top > xy.Y Or frmOver.top + frmOver.Height < xy.Y))
         End If
         If Out Then
            Dim Change As Boolean
            boolLooping = False
            If (Me.top + Me.Height) = Screen.Height Then Change = True
            sendToFlash SWF_FMA(2), "mouseOut", "True"
            HideControlPupup
            frmOver.hideMe
            If Change Then Me.top = Screen.Height - Me.Height
         End If
      End If
   Else
      GetCursorPos xy
      ScreenToClient hwnd, xy
      xy.x = ScaleX(xy.x, vbPixels, vbTwips)
      xy.Y = ScaleY(xy.Y, vbPixels, vbTwips)
      If picMini.Visible Then
         If Not (CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded)) Then   'EDIT:2006-08-08 Seng
            If xy.x <> PointOldMouse.x Or xy.Y <> PointOldMouse.Y Then
               Out = (picwmp.left > xy.x Or picwmp.left + picwmp.Width < xy.x) Or (picMini.top > xy.Y Or picwmp.top + picwmp.Height < xy.Y)
               If Out Then
                  UnloadSwfMiniControl
               End If
            End If
         End If
      End If
      PointOldMouse = xy
   End If
   Exit Sub
Error:
   WriteEvent "tmrMouse_Timer", Err.Description, Err.Source
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
End Sub

Private Sub tmrPlayTrackDelay_Timer()
   On Error GoTo Error
   Dim splitPlayInfo() As String
   Dim splitPlay() As String
   Dim currentInfo As playMusicInfoType
   Dim indexSend2 As Integer
   Dim remoteIP As String
   Dim isSample As Boolean
   Dim iPlayFrom As Integer
   
   If UBound(ItemDelayPlay) >= 0 Then
      splitPlayInfo = Split(ItemDelayPlay(0).SaveInPlayList, "%%")
      remoteIP = splitPlayInfo(17)
      splitPlay = Split(ItemDelayPlay(0).PlayTrackID, "~")
      If UBound(splitPlay) > 4 Then iPlayFrom = val(splitPlay(5))
      pathTrackName = getMoviePathAndSample(ItemDelayPlay(0).PlayTrackID, remoteIP, iPlayFrom)            'CBrowse.getMoviePathAndSample(ItemDelayPlay(0).PlayTrackID, remoteIP)
      
      If pathTrackName <> "" Then
         NoTrack = ItemDelayPlay(0).trackNo
         StPlayer = ItemDelayPlay(0).InfoPlayer
         StrPathPic = ItemDelayPlay(0).PicturePathPic
         SplitInPlayList ItemDelayPlay(0).SaveInPlayList, , remoteIP, iPlayFrom
         SendRefreshTrack2Clients
         handleMinicommand "Play|:|true"               'to all clients
         RemovePlayitemQueue 0
      Else
         If ItemDelayPlay(0).bRequesting = False Then          'If it is requesting the path don't request again
            indexSend2 = CWinsock.getIndexServer(remoteIP)
            ItemDelayPlay(0).bRequesting = True                '
            If indexSend2 >= 0 Then
               If indexSend2 = 0 Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackPath&&&" & ItemDelayPlay(0).PlayTrackID
               Else
                  CWinsock.Send2Client WS_COMMAND, indexSend2, "requestTrackPath&&&" & ItemDelayPlay(0).PlayTrackID
               End If
            Else
               If CWinsock.LoggedType <> ServerMode Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackPath&&&" & ItemDelayPlay(0).PlayTrackID
               Else
                  'Can't send to server so remove it from delay play track list
                  If MusicNoteValue = "true" Then
                     NoTrack = ItemDelayPlay(0).trackNo
                     StPlayer = ItemDelayPlay(0).InfoPlayer
                     StrPathPic = ItemDelayPlay(0).PicturePathPic
                     SplitInPlayList ItemDelayPlay(0).SaveInPlayList, , remoteIP, iPlayFrom
                     SendRefreshTrack2Clients
                  End If
                  RemovePlayitemQueue 0
               End If
            End If
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "tmrPlayTrackDelay_Timer", Err.Description, Err.Source
End Sub

Private Sub tmrReg_Timer()
   On Error GoTo Error
    timeReg = timeReg & "1"
    'mark
    If timeReg = "111111111111111" Then
    'If timeReg = "1" Then
        tmrReg.Enabled = False
        If IIf(IsRegistered, "true", "false") = "true" Then
             b_reg = True
        Else
             b_reg = False
        End If
        If IndexSwf <> 0 Then
            sendVariable2Flash Swf(0), "Isregistered", b_reg
            sendVariable2Flash Swf(0), "ShowLogo", b_reg
            sendVariable2Flash Swf(0), "OpenFrame", "true"
        End If
        sendVariable2Flash Swf(IndexSwf), "Isregistered", b_reg
        sendVariable2Flash Swf(IndexSwf), "ShowLogo", b_reg
        sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"

        If str_swfNames = "Fullscreen" Then oneByOneTheme SWF_FMA(1), "reg", CStr(b_reg)
        If str_swfNames = "Micro" Then sendVariable2Flash SWF_FMA(2), "reg", CStr(b_reg)
    End If
   Exit Sub
Error:
   WriteEvent "tmrReg_Timer", Err.Description, Err.Source
End Sub

Private Sub tmrRetryDownload_Timer()
   'For DVD Don't try to download file coz it is DVD(Over 2GB)    2005-12-09
   'If CopyingSong = False Then CWinsock.StartDownloadItem False
End Sub

Private Sub tmrUnloadFull_Timer()
   On Error GoTo Error
    Unload SWF_FMA(1)
    tmrUnloadFull.Interval = 0
    tmrUnloadFull.Enabled = False
   Exit Sub
Error:
   WriteEvent "tmrUnloadFull_Timer", Err.Description, Err.Source
End Sub

Private Sub tmrUnloadMicro_Timer()
   On Error GoTo Error
    Unload SWF_FMA(2)
    tmrUnloadMicro.Interval = 0
    tmrUnloadMicro.Enabled = False
   Exit Sub
Error:
   WriteEvent "tmrUnloadMicro_Timer", Err.Description, Err.Source
End Sub
Private Sub txtSearchPlayer_GotFocus()
   b_TextBoxGetFocus = True
End Sub

Private Sub txtSearchPlayer_KeyDown(keyCode As Integer, Shift As Integer)
   On Error GoTo Error
   If keyCode = 13 Then
      sendVariable2Flash Swf(4), "StartSearch", "true"
      Swf(4).SetFocus
   End If
   Exit Sub
Error:
   WriteEvent "txtSearchPlayer", Err.Description, Err.Source
End Sub

Private Sub txtSearchPlayer_LostFocus()
   b_TextBoxGetFocus = False
End Sub


Private Sub txtSearchUnicode_GetFocus()
   sendToFlash Swf(2), "HideMenu", "true"
   b_TextBoxGetFocus = True
   'not need to change  Seng 2006-11-11
'   If Language = "Eng" Then
'      clsKeyboard.SetKeyBoardLanguage "English"
'   Else
'      clsKeyboard.SetKeyBoardLanguage currentCountry
'   End If
   'txtSearchUnicode.Move 0, 0, formWidth, 4000
    ' clsKeyboard.SetKeyBoardLanguage currentCountry
   'If txtSearchUnicode.Text = "" Then txtSearchUnicode.Text = "music search"
'''   txtSearchUnicode.SelStart = 0
'''   txtSearchUnicode.SelLength = Len(txtSearchUnicode.Text)
End Sub
Private Sub txtSearchUnicode_KeyDown(keyCode As Integer, Shift As Integer)
   If keyCode = 13 Then
      If IndexSwf = 2 Or IndexSwf = 4 Then
         sendVariable2Flash Swf(IndexSwf), "StartSearch", "true"
         sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
      End If
   ElseIf keyCode = vbKeyDown Or keyCode = vbKeyUp Then
      Swf(IndexSwf).SetFocus
   End If
End Sub

'................................Code Option.............
Private Sub RemoveUserInfo(path As String)
  If Dir(path & "\PlayLists\UserInfo.xml") <> "" Then
   fso.DeleteFile path & "\PlayLists\UserInfo.xml", True
  End If
End Sub

Private Sub RefreshSwf()
   splitSetting
End Sub

Public Function PressKeyInternalPlayer(keyCode As String, Optional FromWinsock As EnumPlayListMode = notConnected) As Boolean
   On Error GoTo Error
    interValCount = 0
    If str_swfNames = "Fullscreen" Then
        If SWF_FMA(1).Visible Then SWF_FMA(1).SetFocus
        oneByOneTheme SWF_FMA(1), "KeyPressed", keyCode
    End If
    
    If keyCode = "MouseDown" Then
      Exit Function
    End If
    click_self = True

   Select Case val(keyCode)
         Case 32
            If frmPopup.Visible = False Then
               If CWinsock.LoggedType <> remoteControl Then popUp
            End If
         Case 33    'seek up
             If int_track_count > 0 And b_play = True Then
                    CPlayer.Seeks = seekPressed(CPlayer.Duration, CPlayer.Seeks, True)
'''                If playMusicWith = WindowMedia Then
''''''                    Me.CWmp.controls.currentPosition = seekPressed(CWmp.currentMedia.duration, CWmp.controls.currentPosition, True)
''''''                    SeekWindowMedia seekPressed(CWmp.currentMedia.duration, CWmp.controls.currentPosition, True)
'''                    CPlayer.Seeks = seekPressed(CPlayer.duration, CPlayer.Seeks, True)
'''                ElseIf playMusicWith = Winamp Then
'''                    MediaPlayer.TrackPosition = MediaPlayer.TrackPosition + 10
'''                ElseIf playMusicWith = nero Then
'''                    NSPlayer.seekTime = NSPlayer.seekTime + 10
'''                End If
                boolSeeked = False
            End If
         Case 34    'seek down
             If int_track_count > 0 And b_play = True Then
               CPlayer.Seeks = seekPressed(CPlayer.Duration, CPlayer.Seeks, False)
'''                If playMusicWith = WindowMedia Then
'''                    SeekWindowMedia seekPressed(CWmp.currentMedia.duration, CWmp.controls.currentPosition, False)
'''                ElseIf playMusicWith = Winamp Then
'''                    MediaPlayer.TrackPosition = MediaPlayer.TrackPosition - 10
'''                ElseIf playMusicWith = nero Then
'''                    NSPlayer.seekTime = NSPlayer.seekTime - 10
'''                End If
                boolSeeked = False
             End If
         Case 187, vbKeyAdd   'volume up
''            If IsNotReceivable(FromWinsock) Then
''               PressKeyInternalPlayer = True
''               Exit Function
''            End If
            Dim tmpVolUp As Long
            tmpVolUp = WaveVolume + 5
            If tmpVolUp > 100 Then
               tmpVolUp = 100
            End If
            miniCommand "Volume|:|" & tmpVolUp
         Case 189, vbKeySubtract  'volume down
            Dim tmpVolDown As Long
            tmpVolDown = WaveVolume - 5
            If tmpVolDown < 0 Then
               tmpVolDown = 0
            End If
            miniCommand "Volume|:|" & tmpVolDown
         Case 77:   'mute
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickMute", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    If b_mute = True Then
                        miniCommand "Mute|:|false"
                    Else
                        miniCommand "Mute|:|true"
                    End If
                End If
         Case 82:   'loop
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickLoop", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    If b_loop = True Then
                        miniCommand "Repeat|:|false"
                    Else
                        miniCommand "Repeat|:|true"
                    End If
                End If
         Case 83:   'shuffle
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickShuffle", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    If b_shuffle = True Then
                        miniCommand "Shuffle|:|false", FromWinsock
                    Else
                        miniCommand "Shuffle|:|true", FromWinsock
                    End If
                End If
               
         
         Case 88:   'play
            If b_play = False Then
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickPlay", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    miniCommand "Play|:|True"
                End If
            End If
         Case 67:   'pause
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickPause", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    miniCommand "Pause|:|True"
                End If

         Case 86:   'stop
            If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                sendVariable2Flash SWF_FMA(1), "clickStop", "true"
                sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
            Else
                miniCommand "Stop|:|True"
            End If
         Case 70:   'more file
            If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                sendVariable2Flash SWF_FMA(1), "clickMoreFile", "true"
                sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
            Else
                miniCommand "AddMusic|:|True"
            End If
         Case 68:
         Case 66:   'next
               
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickNext", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                     If int_next_index = -1 Then int_next_index = 0
                     miniCommand "Next|:|True"
                End If
               
         Case 90:   'previous
         
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickPrevious", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                Else
                    miniCommand "Previous|:|True"
                End If
         Case 69:   'change language
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickChangeLan", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                End If
                
         Case 79:   'set slide show
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickSlideShow", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                ElseIf str_swfNames = "Micro" Then
                    setSlideShows
                    sendToFlash Swf(IndexSwf), "slideShow", CStr(b_slideshow)
                    sendVariable2Flash SWF_FMA(2), "val_slideShow", b_slideshow
                End If
         Case 81:   'close fullscreen
                If str_swfNames = "Fullscreen" And LoadSlideshow = False Then
                    sendVariable2Flash SWF_FMA(1), "clickCloseFull", "true"
                    sendVariable2Flash SWF_FMA(1), "clickEvent", "true"
                End If
         Case 85:
         Case 84:
         Case 119:
            miniCommand "Volume|:|100"
         Case 118:
            miniCommand "Volume|:|50"
         Case 117:
            miniCommand "Volume|:|0"
         Case 37, 38, 39, 40     'left,up,right,down
            If bool_full_vis Then noHideDVDControl ' LoadSwfDvdControl
      End Select
   Exit Function
Error:
   WriteEvent "PressKeyInternalPlayer", Err.Description, Err.Source
End Function
Public Sub ChangePlayListIndex(pathName As String, index As Integer, index1 As Integer)
   On Error GoTo 0
      Dim t As IXMLDOMElement
      Dim temp As IXMLDOMElement
      Set xmlPlaylist = New DOMDocument
      xmlPlaylist.Load (pathName)
      Set t = xmlPlaylist.childNodes(0)
      Dim i As Integer
      'For i = 0 To 22 - 1
      Dim LengthAr As Integer
      LengthAr = t.childNodes(0).Attributes.Length
      Dim a()  As String
      ReDim a(LengthAr)
      For i = 0 To LengthAr - 1
         a(i) = t.childNodes(index).Attributes(i).Text
         t.childNodes(index).Attributes(i).Text = t.childNodes(index1).Attributes(i).Text
         t.childNodes(index1).Attributes(i).Text = a(i)
      Next
      xmlPlaylist.Save pathName

End Sub
Private Sub DirFileMP3(ByVal path As String, DirPath As String)
   On Error GoTo Error
    Dim spl() As String
    Dim xmlName As String
    Dim strPath As String
    
    If right(DirPath, 2) = ":\" Then
        Exit Sub
    Else
        spl = Split(DirPath, "\")
        xmlName = spl(UBound(spl))
        strPath = DirPath
    End If
    If ExistPlayList(path & "\PlayLists\PlayLists.xml", xmlName, DirPath) = False Then
        AddNewPlayList path, xmlName, DirPath, DirPath & "\Folder.jpg", True
        sendVariable2Flash Swf(3), "NewFolderPlaylist", strPath
        sendVariable2Flash Swf(3), "OpenFrame", "true"
    Else
        Exit Sub
    End If
    
   Set xmlTrack = New DOMDocument
    xmlTrack.Load path & "\PlayLists\" & xmlName & ".xml"
    Set xmlTrackRoot = xmlTrack.firstChild
    '.Exec........
    GetSubFolder DirPath
    
    xmlTrack.Save path & "\PlayLists\" & xmlName & ".xml"
   Exit Sub
Error:
   WriteEvent "DirFileMP3", Err.Description, Err.Source
End Sub

Function GetSubFolder(ByVal path As String) As String
   On Error GoTo Error
    Dim f, f1, sf
    
    SaveInXML path
    
    Set f = fso.GetFolder(path)
    Set sf = f.SubFolders
    For Each f1 In sf
        GetSubFolder (path & "\" & f1.Name)
    Next
   Exit Function
Error:
   WriteEvent "GetSubFolder", Err.Description, Err.Source
End Function
Sub SaveInXML(ByVal path As String)
   On Error GoTo Error
    Dim spl() As String
    Dim albumName As String
    Dim artistName As String
    Dim TrackTitle As String
    Dim filename As String
    Dim fileName1 As String
    Dim StPlayer As String
    Dim fal As Boolean
    Dim fileExt As String
    
    fal = True
    spl = Split(path, "\")
    If UBound(spl) > 0 Then
        albumName = spl(UBound(spl))
        artistName = spl(UBound(spl) - 1)
    Else
        albumName = spl(UBound(spl))
        artistName = spl(UBound(spl))
    End If
    
    If CPlayer.PlayWith = WindowMedia Then
      filename = Dir(path & "\*.wma")
      If filename = "" Then
          filename = Dir(path & "\*.mp3")
          fal = False
      End If
    Else
      filename = Dir(path & "\*.wma")
      fileExt = "mp3"
      If filename = "" Then
          filename = Dir(path & "\*.mp3")
          fileExt = "m4a"
          If filename = "" Then
            filename = Dir(path & "\*.m4a")
            fileExt = "flac"
            If filename = "" Then
               filename = Dir(path & "\*.flac")
               fileExt = "wav"
               If filename = "" Then
                  filename = Dir(path & "\*.wav")
                  fileExt = "mp4"
                  If filename = "" Then
                     filename = Dir(path & "\*.mp4")
                     fileExt = "m4p"
                     If filename = "" Then
                        filename = Dir(path & "\*.m4p")
                        fileExt = "ogg"
                        If filename = "" Then
                           filename = Dir(path & "\*.ogg")
                           fileExt = "ape"
                           If filename = "" Then
                              filename = Dir(path & "\*.ape")
                              fileExt = ""
                           End If
                        End If
                     End If
                  End If
               End If
            End If
          End If
      End If
      
    End If
    While filename <> ""
        '...detect Error % char......
       If InStr(1, filename, "%") > 0 Then
            fileName1 = Replace(filename, "%", "")
            Name path & "\" & filename As path & "\" & fileName1
            filename = fileName1
       End If
       'trackTitle = Left(filename, Len(filename) - 4)
       TrackTitle = fso.GetBaseName(filename)
       StPlayer = TrackTitle & "||%%" & artistName & "||%%" & albumName & "||%~%Arial||Arial%~%42||42%~%%~%%~%"

       Set xmlTrackRoot = xmlTrack.firstChild
       xmlTrackRoot.setAttribute "DisplayMode", "TrackTitle"
       Set xmlTrackName = xmlTrack.createElement("Track")
       xmlTrackName.setAttribute "Album", albumName
       xmlTrackName.setAttribute "UniAlbum", albumName
       xmlTrackName.setAttribute "Track", TrackTitle
       xmlTrackName.setAttribute "UniTrack", TrackTitle
       xmlTrackName.setAttribute "Artist", artistName
       xmlTrackName.setAttribute "UniArtist", artistName
       xmlTrackName.setAttribute "Mood", ""
       xmlTrackName.setAttribute "UniMood", ""
       xmlTrackName.setAttribute "Dance", ""
       xmlTrackName.setAttribute "UniDance", ""
       xmlTrackName.setAttribute "Rating", 3
       xmlTrackName.setAttribute "Genre", ""
       xmlTrackName.setAttribute "UniGenre", ""
       xmlTrackName.setAttribute "Mode", "External"
       xmlTrackName.setAttribute "TrackId", path & "\" & filename
       xmlTrackName.setAttribute "PicPath", path & "\folder.jpg"
       xmlTrackName.setAttribute "Lan", "English"
       xmlTrackName.setAttribute "ComName", ""
       xmlTrackName.setAttribute "AlbumID", ""
       xmlTrackName.setAttribute "LanTrack", "External"
       xmlTrackName.setAttribute "StPlayer", StPlayer
       xmlTrackName.setAttribute "TrackYear", ""
       xmlTrackName.setAttribute "TrackAva", "1"
       xmlTrackName.setAttribute "walMartAva", "0"
       xmlTrackName.setAttribute "ShoppingID", ""
       xmlTrackName.setAttribute "NoTrack", ""
       xmlTrackRoot.appendChild xmlTrackName
        
       filename = Dir
       If CPlayer.PlayWith = WindowMedia Then
            If filename = "" And fal = True Then
                 filename = Dir(path & "\*.mp3")
                 fal = False
            End If
       Else
         If filename = "" Then
            Dim tmpext As String
            While tmpext <> fileExt And filename = ""
               If fileExt = "ape" Then
                  filename = Dir(path & "\*.ape")
                  fileExt = ""
               ElseIf fileExt = "ogg" Then
                  filename = Dir(path & "\*.ogg")
                  fileExt = "ape"
               ElseIf fileExt = "m4p" Then
                  filename = Dir(path & "\*.m4p")
                  fileExt = "ogg"
               ElseIf fileExt = "mp4" Then
                  filename = Dir(path & "\*.mp4")
                  fileExt = "m4p"
               ElseIf fileExt = "wav" Then
                  filename = Dir(path & "\*.wav")
                  fileExt = "mp4"
               ElseIf fileExt = "flac" Then
                  filename = Dir(path & "\*.flac")
                  fileExt = "wav"
               ElseIf fileExt = "m4a" Then
                  filename = Dir(path & "\*.m4a")
                  fileExt = "flac"
               ElseIf fileExt = "mp3" Then
                  filename = Dir(path & "\*.mp3")
                  fileExt = "m4a"
               End If
            Wend
         End If
       End If
       
    Wend
   Exit Sub
Error:
   WriteEvent "SaveInXML", Err.Description, Err.Source
End Sub
Sub AddFolderForPlayer(ByVal path As String)
   On Error GoTo Error
   Dim filearray() As String
   Dim filelist As String
   GetSubFolderPlayer path, filearray
   If Not CWinsock.LoggedType = ServerMode Then
      filelist = Join(filearray, vbNullChar)
      SaveExternalToXML filelist
   End If
    If IndexSwf = 4 Then
        sendVariable2Flash Swf(4), "PassTrackInfoLen", int_track_count
        sendVariable2Flash Swf(4), "OpenFrame", "true"
    End If
   Exit Sub
Error:
   WriteEvent "AddFolderForPlayer", Err.Description, Err.Source
End Sub
Function GetSubFolderPlayer(ByVal path As String, filearray() As String) As String
   On Error GoTo Error
   Dim f1 As Folder
   Dim pathName As String
    
   SaveInPlayerArr path, filearray
   For Each f1 In fso.GetFolder(path).SubFolders
      pathName = fso.BuildPath(path, f1.Name)
      SaveInPlayerArr pathName, filearray
      GetSubFolderPlayer pathName, filearray
   Next
   Exit Function
Error:
   WriteEvent "GetSubFolderPlayer", Err.Description, Err.Source
End Function
Sub SaveInPlayerArr(ByVal path As String, fileArr() As String)
   On Error GoTo Error
   Dim albumName As String
   Dim artistName As String
   Dim TrackTitle As String
   Dim filename As String
   Dim newFileName As String
   Dim stPlayList As String
   Dim filecount As Long
   Dim startBound As Long
   Dim extensionArray As String
   filecount = UBound(fileArr) + 1
   startBound = filecount
   Dim i As Long
      
   albumName = fso.GetBaseName(path)
   artistName = fso.GetBaseName(fso.GetParentFolderName(path))
   If artistName = "" Then artistName = albumName
   If CPlayer.PlayWith = WindowMedia Then
      extensionArray = ";wma;mp3;"
   Else
      extensionArray = ";wma;mp3;m4a;flac;wav;mp4;m4p;ogg;ape;"
   End If
   filename = Dir(path + "\*.*")
   While filename <> ""
      If InStr(1, extensionArray, fso.GetExtensionName(filename), vbTextCompare) > 0 Then
         ReDim Preserve fileArr(filecount)
         '..Detect Error % char
         If InStr(1, filename, "%") > 0 Then
              newFileName = Replace(filename, "%", "_")
              Name fso.BuildPath(path, filename) As fso.BuildPath(path, newFileName)
              filename = newFileName
         End If
         fileArr(filecount) = fso.BuildPath(path, filename)
'         fileArr(filecount) = filename
         filecount = filecount + 1
      End If
      filename = Dir
   Wend
   If CWinsock.LoggedType = ServerMode Then
      For i = startBound To filecount - 1
         AddTrack2PlayerExternal fileArr(i)
      Next
   End If
   Exit Sub
Error:
   WriteEvent "SaveInPlayerArr", Err.Description, Err.Source
   Resume Next
End Sub

Private Sub SaveSortMaster(path As String, pName As Variant, SlyPath As Variant, ImgPath As Variant, Length As Integer)
   On Error GoTo Error
      Dim i As Integer
      CreateNewFile path & "\PlayLists\", "PlayLists", "PlayList"
      
      Set xmlPlaylist = New DOMDocument
      xmlPlaylist.Load path & "\PlayLists\PlayLists.xml"
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      If Length = 1 Then
         Set xmlPlaylistName = xmlPlaylist.createElement("PlayList")
         xmlPlaylistName.setAttribute "SlidePath", SlyPath
         xmlPlaylistName.setAttribute "ImgPath", ImgPath
         xmlPlaylistName.Text = pName
         xmlPlaylistRoot.appendChild xmlPlaylistName
      Else
         For i = 0 To Length - 1
            Set xmlPlaylistName = xmlPlaylist.createElement("PlayList")
            xmlPlaylistName.setAttribute "SlidePath", SlyPath(i)
            xmlPlaylistName.setAttribute "ImgPath", ImgPath(i)
            xmlPlaylistName.Text = pName(i)
            xmlPlaylistRoot.appendChild xmlPlaylistName
         Next
      End If
      xmlPlaylist.Save path & "\PlayLists\PlayLists.xml"
   Exit Sub
Error:
   WriteEvent "SaveSortMaster", Err.Description, Err.Source
End Sub
Private Sub SaveSortMaster1(path As String, pName As Variant, Length As Integer, path1 As Variant, ImgPathPic As Variant, StoreName As String)
   On Error GoTo Error
      Dim i As Integer
      CreateNewFile path, "PlayListPaths", "PlayListPath"

      Set xmlPlaylist = New DOMDocument
      xmlPlaylist.Load path & "\PlayListPaths.xml"
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      xmlPlaylistRoot.setAttribute "StoreName", StoreName
      If Length = 1 Then
         Set xmlPlaylistName = xmlPlaylist.createElement("PlayListPath")
         xmlPlaylistName.Text = path1
         xmlPlaylistName.setAttribute "Name", pName
         xmlPlaylistName.setAttribute "ImgPath", ImgPathPic
         xmlPlaylistRoot.appendChild xmlPlaylistName
      Else
         For i = 0 To Length - 1
            Set xmlPlaylistName = xmlPlaylist.createElement("PlayListPath")
            xmlPlaylistName.Text = path1(i)
            xmlPlaylistName.setAttribute "Name", pName(i)
            xmlPlaylistName.setAttribute "ImgPath", ImgPathPic(i)
            xmlPlaylistRoot.appendChild xmlPlaylistName
         Next
      End If
      xmlPlaylist.Save path & "\PlayListPaths.xml"
   Exit Sub
Error:
   WriteEvent "SaveSortMaster1", Err.Description, Err.Source
End Sub
Private Sub LoadSwfCountry(UnloadIndex1 As String, Optional StrUpdate As String, Optional argUpdateLocal As String)
   On Error Resume Next
    killInternetTemp
    
    EditXML MainSettingXML, 2, "Vol", CStr(WaveVolume)
    
    DisplayMini = 0
    ValuePlayer = 0
    show_hide_player = False
    Load Swf(1)
    
    ReloadFlash "Country.sly", Swf(1), 1
    'command to update....
    sendToFlash Swf(1), "store_list_index", CStr(store_list_index)
    sendVariable2Flash Swf(1), "online_id", online_id
    sendVariable2Flash Swf(1), "store_user_login_name", store_user_login_name
    sendVariable2Flash Swf(1), "store_user_login_pass", store_user_login_pass
    sendVariable2Flash Swf(1), "set_Server_online", setServer
    sendVariable2Flash Swf(1), "login_name", login_name
    sendVariable2Flash Swf(1), "user_sign_in_index", user_sign_in_index
    sendVariable2Flash Swf(1), "online", LCase(b_online)
    sendVariable2Flash Swf(1), "sly_nick_name", ComputerName
    sendVariable2Flash Swf(1), "CurrentCountry", currentCountry
    sendVariable2Flash Swf(1), "StrUpdate", StrUpdate
    sendVariable2Flash Swf(1), "Website", ServerAdsScreen.website
    sendVariable2Flash Swf(1), "UpdateFromLocal", argUpdateLocal     'update from local server
    
    sendVariable2Flash Swf(1), "LoginName", CWinsock.LoginInName
    sendToFlash Swf(1), "clientType", CWinsock.LoggedType
    sendToFlash Swf(1), "OpenXml", App.path & "\sly"
    sendToFlash Swf(1), "UnloadSWF", UnloadIndex1
    sendVariable2Flash Swf(0), "RefreshInvisible", "true"
    sendVariable2Flash Swf(0), "OpenFrame", "true"
    sendToFlash Swf(0), "default", str_infoPopup
    
    sendVariable2Flash Swf(1), "syn_volume", CStr(syn_vol)
    sendVariable2Flash Swf(1), "syn_volume_change", CStr(change_vol)
    
    current_status Swf(1)
    
    server_display_language = ""
    server_display_page = ""
        
    'eventMouseClick
    Swf(0).Visible = False
    StoreQsearch = ""
    FrmMain.scale_visualization_to_fullscreen True
'''   Exit Sub
'''Error:
'''   WriteEvent "LoadSwfCountry", Err.Description, Err.Source
End Sub
Private Sub LoadSwfInterfaceCD(UnloadIndex1 As String)
   On Error Resume Next
   
   ReloadFlash "InterfaceCD.sly", Swf(0), 0
   sendVariable2Flash Swf(0), "TrackNames", display_track_list_type(setDisplayTrackType)
   sendVariable2Flash Swf(0), "SHTT", LCase(b_tooltip)
   sendVariable2Flash Swf(0), "AllCountryNames", allCountry
   sendVariable2Flash Swf(0), "DisplayAlbumLong", DisplayAlbumLong
   sendVariable2Flash Swf(0), "UnloadIndex", UnloadIndex1
   sendVariable2Flash Swf(0), "LanName", currentCountry
   sendVariable2Flash Swf(0), "iKhmer", getKhmerCountry(currentCountry)         '2005-10-24
   sendVariable2Flash Swf(0), "ComName", SlyNickName
   sendVariable2Flash Swf(0), "ComIP", ComputerIP
   sendVariable2Flash Swf(0), "NoInternetConnected", NoInternetConnected
   sendVariable2Flash Swf(0), "GetPath", MainPath
   sendVariable2Flash Swf(0), "MainPathImage", MainPathImage
   sendVariable2Flash Swf(0), "str_main_path_playlist", str_main_playlist_path
   sendVariable2Flash Swf(0), "SlideShowValue", SlideShowValue
   sendVariable2Flash Swf(0), "WideScreen", ScreenType
   sendVariable2Flash Swf(0), "Isregistered", b_reg
   sendVariable2Flash Swf(0), "StringsubList", StringsubList
   sendVariable2Flash Swf(0), "getSplitSt", SplitColor                                'The start of interfaceCD
   sendVariable2Flash Swf(0), "boolShowCoverIcon", CInt(b_ShowCoverIcon)                                'The start of interfaceCD
   sendVariable2Flash Swf(0), "Website", ServerAdsScreen.website
   sendVariable2Flash Swf(0), "OpenFrame", "true"
   
   sendToFlash Swf(0), "setMusicNote", MusicNoteValue
   sendToFlash Swf(0), "setOffsetEnabled", CStr(setEnableSeekOfsset)
   sendToFlash Swf(0), "default", str_infoPopup
   sendToFlash Swf(0), "clientType", CWinsock.LoggedType
   sendToFlash Swf(0), "streamFile", CInt(CWinsock.StreamFile)
   
   
   
   sendVariable2Flash Swf(0), "syn_volume", CStr(syn_vol)
   sendVariable2Flash Swf(0), "syn_volume_change", CStr(change_vol)
   
   current_status Swf(0)
    
   server_display_language = currentCountry
   server_display_page = ""
   
   'eventMouseClick
   b_displayNewTrack = True
   setMiniPlayer True, 0
   If b_play = True Then get_track_info False
   'swfPopupFullPlayer.Visible = False
   picPopup.Visible = False
   'b_loadAlready = True
   
   If (CWinsock.LoggedType = cloneDisplay Or CWinsock.LoggedType = remoteControl) And CWinsock.LoggedType <> ServerMode Then
      CWinsock.Send2Server WS_COMMAND, "getServerData&&&getShuffleNRepeat"
   End If
   If bool_full_vis Then
      FrmMain.scale_visualization_to_fullscreen False
   End If
   MoveCursorTheSamePos
'''   Exit Sub
'''Error:
'''   WriteEvent "LoadSwfInterfaceCD", Err.Description, Err.Source
End Sub
Public Sub LoadSwfPlayListPage(UnloadIndex1 As String)
   On Error GoTo Error
            ReloadFlash "PlayListPage.sly", Swf(3), 3
            
            sendVariable2Flash Swf(3), "main_path_playlist", str_main_playlist_path
            sendVariable2Flash Swf(3), "TrackNames", display_track_list_type(setDisplayTrackType)
            sendVariable2Flash Swf(3), "SHTT", LCase(b_tooltip)
            sendVariable2Flash Swf(3), "Grouping", GroupingReleaseDate
            sendVariable2Flash Swf(3), "StAllCountrys", allCountry   'allPathCountry
            sendVariable2Flash Swf(3), "ComName", SlyNickName
            
            sendVariable2Flash Swf(3), "UnloadIndex", UnloadIndex1
            sendVariable2Flash Swf(3), "LanName", currentCountry
            sendVariable2Flash Swf(3), "iKhmer", getKhmerCountry(currentCountry)
            sendVariable2Flash Swf(3), "GetPath", MainPath
            sendVariable2Flash Swf(3), "MainPathImage", MainPathImage

            sendVariable2Flash Swf(3), "DisplayAlbumLong", DisplayAlbumLongPlaylist
            sendVariable2Flash Swf(3), "NoInternetConnected", NoInternetConnected
            sendVariable2Flash Swf(3), "SlideShowValue", SlideShowValue
            sendVariable2Flash Swf(3), "AppPath", App.path
            sendVariable2Flash Swf(3), "WideScreen", ScreenType
            sendVariable2Flash Swf(3), "StNumMovie", GetAttSetting(0, "PlayListAlbumNum")
            sendVariable2Flash Swf(3), "getSplitSt", SplitColor
            sendVariable2Flash Swf(3), "IsRegistered", b_reg
            sendVariable2Flash Swf(3), "OpenFrame", "true"
            sendToFlash Swf(3), "default", str_infoPopup
            sendToFlash Swf(3), "clientType", CWinsock.LoggedType
            sendToFlash Swf(3), "setOffsetEnabled", CStr(setEnableSeekOfsset)
            
            sendVariable2Flash Swf(3), "syn_volume", CStr(syn_vol)
            sendVariable2Flash Swf(3), "syn_volume_change", CStr(change_vol)
            
            current_status Swf(3)
            sendToFlash Swf(0), "hideMiniPlayer", True
            
            server_display_language = currentCountry
            server_display_page = "Playlist"
            FrmMain.scale_visualization_to_fullscreen True
   Exit Sub
Error:
   WriteEvent "LoadSwfPlayListPage", Err.Description, Err.Source
End Sub
Public Sub LoadSwfSearchPage(UnloadIndex1 As String)
   On Error GoTo Error
      Dim SearchDisplaySearchMode As Integer
      Dim SaveSearchAvailable As Integer
      Dim SGender As Integer
      Dim val_Local As String

      'txtSearchUnicode.SetFocus
      ReloadFlash "SearchPage.sly", Swf(2), 2
      '=============2006-10-24-Seng
      'SearchPage "SetSearchCountry", currentCountry
      '=============
         val_Local = get_country_path(currentCountry)
         CSearch.SetCountry currentCountry, val_Local
         sendVariable2Flash Swf(2), "LanName", currentCountry
         sendVariable2Flash Swf(2), "iKhmer", getKhmerCountry(currentCountry)
         sendVariable2Flash Swf(2), "GetPath", get_country_path(currentCountry)
         sendVariable2Flash Swf(2), "MainPathImage", get_country_image(currentCountry)
         sendVariable2Flash Swf(2), "databaseType", CSearch.databaseType
         
         
      SGender = Null2Value(read_XML_attributes(MainSettingXML, 0, "Gender"))
      sendVariable2Flash Swf(2), "SearchGender", CStr(SGender)
      sendVariable2Flash Swf(2), "TrackNames", display_track_list_type(setDisplayTrackType)
      sendVariable2Flash Swf(2), "SHTT", LCase(b_tooltip)
      sendVariable2Flash Swf(2), "UnloadIndex", UnloadIndex1
      
      sendVariable2Flash Swf(2), "NoInternetConnected", NoInternetConnected
      sendVariable2Flash Swf(2), "Grouping", GroupingReleaseDate
      sendVariable2Flash Swf(2), "DisplayAlbumLong", DisplayAlbumLongSearch
      sendVariable2Flash Swf(2), "StoreQsearch", StoreQsearch
      sendVariable2Flash Swf(2), "StoreSearchTrack", StoreSearchTrack
      sendVariable2Flash Swf(2), "WideScreen", ScreenType
      sendVariable2Flash Swf(2), "StNumMovie", GetAttSetting(0, "SearchAlbumNum")
      sendVariable2Flash Swf(2), "getSplitSt", SplitColor
      sendVariable2Flash Swf(2), "StringsubList", StringsubList
      sendVariable2Flash Swf(2), "Isregistered", b_reg
      sendVariable2Flash Swf(2), "SlideShowValue", SlideShowValue
      sendVariable2Flash Swf(2), "OpenFrame", "true"
      sendVariable2Flash Swf(2), "ComName", SlyNickName
      sendVariable2Flash Swf(2), "boolShowCoverIcon", CInt(b_ShowCoverIcon)
      sendVariable2Flash Swf(2), "iShowUnderTrackTitle", i_ShowUnderTrackTitle
      sendToFlash Swf(2), "setMusicNote", MusicNoteValue
      sendToFlash Swf(2), "default", str_infoPopup
      sendToFlash Swf(2), "clientType", CWinsock.LoggedType
      sendToFlash Swf(2), "setOffsetEnabled", CStr(setEnableSeekOfsset)
      sendToFlash Swf(2), "PlayChapterState", playChapterType
      SearchDisplaySearchMode = Null2Value(read_XML_attributes(MainSettingXML, 0, "DisplayArtistMode"))
      SaveSearchAvailable = Null2Value(read_XML_attributes(MainSettingXML, 0, "SaveSearchAvailable"))
      sendVariable2Flash Swf(2), "iSearchAvailable", SaveSearchAvailable
      sendVariable2Flash Swf(2), "syn_volume", CStr(syn_vol)
      sendVariable2Flash Swf(2), "syn_volume_change", CStr(change_vol)
      sendVariable2Flash Swf(2), "DisplayArtistMode", CStr(SearchDisplaySearchMode)
      current_status Swf(2)
      
      '''''''''change keyboard layout
      server_display_language = currentCountry
      server_display_page = "Search"
      swfPopupFullPlayer.Visible = False
      
      
      
'''      If Language = "Eng" Then
'''         clsKeyboard.SetKeyBoardLanguage "English"
'''      Else
'''         clsKeyboard.SetKeyBoardLanguage currentCountry
'''      End If
      
      sendToFlash Swf(0), "hideMiniPlayer", True
      StoreSearchTrack = ""                           'Clear this value
   Exit Sub
Error:
   WriteEvent "LoadSwfSearchPage", Err.Description, Err.Source
End Sub
Public Sub LoadSwfPlayListPlayerPage(UnloadIndex1 As String)
   On Error Resume Next
   ''On Error Resume Next
'''''''''         'Dim lentrack As Integer
         
 
    Load Swf(4)
    ReloadFlash "PlayListPlayer.sly", Swf(4)
    sendVariable2Flash Swf(4), "str_main_path_playlist", str_main_playlist_path
    sendVariable2Flash Swf(4), "currentIndex", currentIndex
    currentIndex = ""
    IndexSwf = 4
    boolRequestingTrack = False                     'Reset track
    
    sendVariable2Flash Swf(4), "TrackNames", display_track_list_type(setDisplayTrackType)
    sendVariable2Flash Swf(4), "ChangeCurIndexTrack", int_current_index
    sendVariable2Flash Swf(4), "PassTrackInfoLen", int_track_count
    sendVariable2Flash Swf(4), "SHTT", LCase(b_tooltip)
    sendVariable2Flash Swf(4), "StAllCountrys", allCountry
    sendVariable2Flash Swf(4), "LanName", currentCountry
    sendVariable2Flash Swf(4), "iKhmer", getKhmerCountry(currentCountry)
    sendVariable2Flash Swf(4), "GetPath", MainPath
    sendVariable2Flash Swf(4), "MainPathImage", MainPathImage
    sendVariable2Flash Swf(4), "ComName", SlyNickName
    sendVariable2Flash Swf(4), "SlideShowValue", SlideShowValue
    sendVariable2Flash Swf(4), "AppPath", App.path
    sendVariable2Flash Swf(4), "WideScreen", ScreenType
    sendVariable2Flash Swf(4), "getSplitSt", SplitColor                 'Main variable
    sendVariable2Flash Swf(4), "NoInternetConnected", NoInternetConnected
    sendVariable2Flash Swf(4), "UnloadIndex", UnloadIndex1
    sendVariable2Flash Swf(4), "ChangeTrack", int_current_index
    sendVariable2Flash Swf(4), "OpenFrame", "true"
    
    sendVariable2Flash Swf(4), "syn_volume", CStr(syn_vol)
    sendVariable2Flash Swf(4), "syn_volume_change", CStr(change_vol)
    
    
    current_status Swf(4)
    
    If SetPlayListName = "" Then
       SetPlayListName = "Default"
    End If
    sendVariable2Flash Swf(4), "Unregistered", b_reg
    sendVariable2Flash Swf(4), "SetPlayListDir", SetPlayListDir
    sendVariable2Flash Swf(4), "SetPlayListName", SetPlayListName
    sendVariable2Flash Swf(4), "SetPlayListSlidePath", SetPlayListSlidePath
    sendVariable2Flash Swf(4), "serverMainPath", CWinsock.serverMainPath
    sendVariable2Flash Swf(4), "clientCount", CWinsock.clientCount
    sendVariable2Flash Swf(4), "playchapterFile", playChapterType
    sendVariable2Flash Swf(4), "iShowUnderTrackTitle", i_ShowUnderTrackTitle
    
    sendToFlash Swf(4), "setOffsetEnabled", CStr(setEnableSeekOfsset)
    sendToFlash Swf(4), "clientType", CWinsock.LoggedType
    sendToFlash Swf(4), "streamFile", CInt(CWinsock.StreamFile)
   
    setMiniPlayer True, 4
    get_track_info False
    sendToFlash Swf(0), "hideMiniPlayer", True
    If (CWinsock.LoggedType = cloneDisplay Or CWinsock.LoggedType = remoteControl) And CWinsock.LoggedType <> ServerMode Then
       CWinsock.Send2Server WS_COMMAND, "getServerData&&&getShuffleNRepeat"
    End If
   
    server_display_language = currentCountry
    server_display_page = "Player"
    'scale_visualization_to_fullscreen Not bool_full_vis
    If bool_full_vis Then
       scale_visualization_to_fullscreen False 'Not bool_full_vis
    End If
    Exit Sub
End Sub
Public Sub LoadSwfSettingPage(UnloadIndex1 As String)
   On Error GoTo Error
         Load Swf(6)
         'LoadSwfIndex 6
         ReloadFlash "Option.sly", Swf(6), 6
         LoadLanguageXml
         sendVariable2Flash Swf(6), "user_sign_in_index", user_sign_in_index
         sendVariable2Flash Swf(6), "SHTT", LCase(b_tooltip)
         sendVariable2Flash Swf(6), "NameCon", currentCountry
         sendVariable2Flash Swf(6), "DisplayAlbumLong", DisplayAlbumLong
         sendVariable2Flash Swf(6), "AllCountry", allCountry
         sendVariable2Flash Swf(6), "UnloadIndex", UnloadIndex1
         sendVariable2Flash Swf(6), "GetPath", App.path
         sendVariable2Flash Swf(6), "CountryPath", MainPath
         sendVariable2Flash Swf(6), "CurPlayList", SetPlayListDir
         sendVariable2Flash Swf(6), "DisplayPage", DisplayPage
         sendVariable2Flash Swf(6), "LoadPlayMusic", LoadPlayMusic
         sendVariable2Flash Swf(6), "ShowPlayerOnLoad", ShowPlayerOnLoad
         sendVariable2Flash Swf(6), "MainPathDB", MainPath
         sendVariable2Flash Swf(6), "MainPathImage", MainPathImage
         sendVariable2Flash Swf(6), "MPlayerPath", MPlayerPath
         sendVariable2Flash Swf(6), "NoInternetConnected", NoInternetConnected
         sendVariable2Flash Swf(6), "AutoDownload", AutoDownload
         sendVariable2Flash Swf(6), "StrFont", StrFont
         sendVariable2Flash Swf(6), "Grouping", Grouping
         sendVariable2Flash Swf(6), "StringsubList", StringsubList
         sendVariable2Flash Swf(6), "Unregistered", IsRegistered  'b_reg
         sendToFlash Swf(6), "AdvPath", tmp_browse_folder
         
         sendVariable2Flash Swf(0), "i_SearchTrackFromArtist", CStr(i_SearchTrackFromArtist)
         sendVariable2Flash Swf(6), "SearchTrackFromArtist", CStr(i_SearchTrackFromArtist)
         
         sendVariable2Flash Swf(6), "OpenFrame", "true"
         If CWinsock.LoggedAs(remoteControl) Then CWinsock.Send2Server WS_COMMAND, "RequestIsFirstClient"
         
         sendToFlash Swf(6), "clientType", CWinsock.LoggedType
         sendToFlash Swf(6), "monitor", CStr(setMonitor)
         sendToFlash Swf(6), "trackType", CStr(setDisplayTrackType)
         sendToFlash Swf(6), "DVDControlType", CStr(setDisplayDvdContol)
         sendToFlash Swf(6), "ripWith", CStr(ripMusicWith)
         sendToFlash Swf(6), "ShowPopupInfo", CInt(Settings.b_ShowPopupInfo)
         sendToFlash Swf(6), "playWith", CStr(playMusicWith)
         sendToFlash Swf(6), "microStyle", CStr(microStyle)
         sendToFlash Swf(6), "priorityExtension", stringPriorityEXT
         sendToFlash Swf(6), "priorityMplayer", StringPriorityMplayer
         sendToFlash Swf(6), "resize_image", CStr(Int(resize_image) * Int(resize_image))
         sendToFlash Swf(6), "streamFile", CWinsock.StreamFile
         sendToFlash Swf(6), "syn", CStr(syn)
         sendToFlash Swf(6), "resize_image_server", CStr(b_resize)
         sendToFlash Swf(6), "priorityMplayer", StringPriorityMplayer
         sendToFlash Swf(6), "syn_vol", CStr(syn_vol)
         sendToFlash Swf(6), "friend_playlist", CStr(friend_playlist)
         sendToFlash Swf(6), "allow_slideshow", CStr(b_AllowSlideshow)
         sendToFlash Swf(6), "clone_display", CStr(type_login_display)
         sendToFlash Swf(6), "clone_playback", CStr(type_login_playback)
         sendToFlash Swf(6), "clone_independent", CStr(type_login_independent)
         sendToFlash Swf(6), "Remotecontrol", CStr(type_login_remoteControl)
         sendToFlash Swf(6), "localLink", CStr(b_local_link)
         sendToFlash Swf(6), "auto_new_database", CStr(auto_new_database)
         sendToFlash Swf(6), "popup_exit", CStr(popup_exit)
         sendToFlash Swf(6), "change_vol", CStr(change_vol)
         sendToFlash Swf(6), "setDownloadAll", CStr(boolDownloadAll)
         sendToFlash Swf(6), "setBrowseByFolder", CStr(b_BrowseByFolder)
         sendToFlash Swf(6), "setExternalPowerDVD", CStr(b_ExternalPowerDVD)
         sendToFlash Swf(6), "setReencode", CStr(b_ReEncode)
         sendToFlash Swf(6), "playchapterFile", playChapterType
         sendToFlash Swf(6), "setOffsetEnabled", CStr(setEnableSeekOfsset)
         sendToFlash Swf(6), "permission", str_permission
         sendToFlash Swf(6), "default_per", LCase(b_default_permission)
         sendToFlash Swf(6), "deny", LCase(b_deny)
         sendToFlash Swf(6), "VLCExtension", CStr(Settings.s_DefaultVLCExtension)
         sendToFlash Swf(6), "PowerDVDExtension", CStr(Settings.s_DefaultPowerDVDExtension)
         sendToFlash Swf(6), "DaemonDrive", CStr(Settings.s_DriveMount)
         sendToFlash Swf(6), "AutoPlay", CStr(AutoPlayEnabled)
         sendToFlash Swf(6), "AutoPlayPowerDVD", CStr(AutoPlayPowerDVD)
         sendToFlash Swf(6), "AutoPlayMPC", CStr(AutoPlayMPC)
         sendToFlash Swf(6), "streamType", CStr(setStreamType)
         sendToFlash Swf(6), "ChangeTrackTitleStyle", CStr(i_ShowUnderTrackTitle)        'Send show Style to optionpage
         sendToFlash Swf(6), "LinkingPlaylistPath", CUserLogin.LinkingPlayListPath
         '================Multi monitor support=============================='EDIT:2006-08-03 Seng
         sendToFlash Swf(6), "MonitorCount", CStr(MonitorCount)
         sendToFlash Swf(6), "SlyMonitor", CStr(i_SlyMonitor + 1)
         sendToFlash Swf(6), "VideoMonitor", CStr(i_VideoMonitor + 1)
         '==============================Resize screen from server =====================================
         sendToFlash Swf(6), "ResizeFromServer", CStr(b_GetZoomLevelFromServer)
         '===================================================================
         
         sendVariable2Flash Swf(6), "syn_volume", CStr(syn_vol)
         sendVariable2Flash Swf(6), "syn_volume_change", CStr(change_vol)
         sendToFlash Swf(0), "hideMiniPlayer", True
         MoveCursorTheSamePos
         
         current_status Swf(6)
         
         server_display_language = currentCountry
         server_display_page = "Option"
   Exit Sub
Error:
   WriteEvent "LoadSwfSettingPage", Err.Description, Err.Source
End Sub

Sub ResizeForm(Swfs As Object, strPath As String, Screen_Width As Long, Screen_Height As Long, Setting As String)
   On Error GoTo Error
    Dim regKey As String
    If GetCurrentMachineID <> "" Then
        With Swfs
            LoadSwfFile strPath, Swfs
            .Visible = True
            If ScreenType = "Normal" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 1024) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 768) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            ElseIf ScreenType = "wideScreen" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 1280) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 720) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            ElseIf ScreenType = "mediumWideScreen" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 1280) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 768) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            ElseIf ScreenType = "mediumLargeWideScreen" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 1280) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 800) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            ElseIf ScreenType = "smallWideScreen" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 1024) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 600) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            ElseIf ScreenType = "largeWideScreen" Then
                .Width = ((500 * (Screen_Width / Screen.TwipsPerPixelX)) / 800) * Screen.TwipsPerPixelX
                .left = (Screen_Width - .Width) / 2
                .Height = ((350 * (Screen_Height / Screen.TwipsPerPixelY)) / 640) * Screen.TwipsPerPixelY
                .top = (Screen_Height - .Height) / 2
            End If
            
            sendVariables swfAbout, "openSetting", "strSetting", Setting
            swfAbout.ZOrder 0
            
            sendVariable2Flash swfAbout, "clientType", cloneDisplay
            sendVariables Swfs, "openKey", "ads", CStr(b_ads)
            sendVariables Swfs, "openID", "strID", GetCurrentMachineID
            If IsRegistered Then regKey = ReadRegCode() Else regKey = ""
            sendVariables Swfs, "openKey", "strKey", regKey
            
        End With
    Else
      
      'added by seng  send command exit to flash about control
      Call swfabout_FSCommand("Exit", "")
    End If
   Exit Sub
Error:
   WriteEvent "resizeForm", Err.Description, Err.Source
End Sub


Private Sub swfabout_FSCommand(ByVal command As String, ByVal args As String)
   handleMinicommand command & "|:|" & args
End Sub
Private Sub ClickGenre(Value)
   On Error GoTo Error
        Dim splString() As String
        splString = Split(Value, "~")
        Set xmlPlaylist = New DOMDocument
        If Dir(GetLanguageLocation("\" & splString(2) & "s.xml")) <> "" Then
            xmlPlaylist.Load GetLanguageLocation(splString(2) & "s.xml")
            Set xmlPlaylistRoot = xmlPlaylist.firstChild
            xmlPlaylistRoot.setAttribute "StoreName", splString(0)
            xmlPlaylistRoot.setAttribute "StoreLetter", splString(1)
            If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then
                xmlPlaylistRoot.setAttribute "StoreNormal", ""
            Else
                xmlPlaylistRoot.setAttribute "StoreWidth", ""
            End If
            xmlPlaylist.Save GetLanguageLocation(splString(2) & "s.xml")
        End If
   Exit Sub
Error:
   WriteEvent "ClickGenre", Err.Description, Err.Source
End Sub

Private Sub SaveGenre(Value)
   On Error GoTo Error
        Dim splString() As String
        Dim splId() As String
        Dim splGenre() As String
        Dim splUni() As String
        Dim splPic() As String
        Dim Len1 As Integer
        Dim nameFile As String
        Dim StoreName As String
        Dim StoreLetterIndex As String
        Dim i As Integer
        splString = Split(Value, "~")
        splId = Split(splString(0), ",")
        splGenre = Split(splString(1), ",")
        splUni = Split(splString(2), ",")
        splPic = Split(splString(3), ",")
        Len1 = val(splString(4))
        nameFile = splString(5)
        StoreName = splString(6)
        StoreLetterIndex = splString(7)
       Set xmlPlaylist = New DOMDocument
       Set xmlPlaylistRoot = xmlPlaylist.createElement("Items")
       xmlPlaylistRoot.setAttribute "StoreName", StoreName
       xmlPlaylistRoot.setAttribute "StoreLetter", StoreLetterIndex
       If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then
            xmlPlaylistRoot.setAttribute "StoreNormal", ""
       Else
            xmlPlaylistRoot.setAttribute "StoreWidth", ""
       End If
       For i = 0 To Len1 - 1
           Set xmlPlaylistName = xmlPlaylist.createElement("Item")
           
           xmlPlaylistName.setAttribute "Id", splId(i)
           xmlPlaylistName.setAttribute "Name", splGenre(i)
           xmlPlaylistName.setAttribute "UniName", splUni(i)
           xmlPlaylistName.setAttribute "Pic", splPic(i)
           
           xmlPlaylistRoot.appendChild xmlPlaylistName
           
       Next
       xmlPlaylist.appendChild xmlPlaylistRoot
       If nameFile = "Genre" Then
           xmlPlaylist.Save GetLanguageLocation("Genres.xml")
       ElseIf nameFile = "Production" Then
          xmlPlaylist.Save GetLanguageLocation("Productions.xml")
       Else
          xmlPlaylist.Save GetLanguageLocation("ReleaseDates.xml")
       End If
   
   Exit Sub
Error:
   WriteEvent "SaveGenre", Err.Description, Err.Source
End Sub
Private Function GetGenreOrProduction(path As String, Optional bBrowseChanged As Boolean) As String
   On Error GoTo Error
  ' On Error Resume Next
      Dim str1 As String
      Dim str As String
      Dim sep As String
      Dim i As Integer
      Dim tmp2() As String
      Dim tmp1() As String
      Dim ID As String
      Dim Gen As String
      Dim uniGen As String
      Dim pic As String
      Dim ichildNodeFound As Integer
      Dim lpArrayBrowse() As String
      Dim lpSplitEach() As String
      
      Dim filename As String
      Set xmlPlaylist = New DOMDocument
      filename = fso.GetFileName(path)
      xmlPlaylist.Load path
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      For i = 0 To xmlPlaylistRoot.childNodes.Length - 1
         str = xmlPlaylistRoot.childNodes(i).Attributes(0).Text & "||" & xmlPlaylistRoot.childNodes(i).Attributes(1).Text & "||" & xmlPlaylistRoot.childNodes(i).Attributes(2).Text & "||" & xmlPlaylistRoot.childNodes(i).Attributes(3).Text
         str1 = str1 + sep + str
         sep = "&&&"
         ichildNodeFound = ichildNodeFound + 1
      Next
      str = ""
      If str1 = "" Then
         If filename = "Genres.xml" Then
            str1 = CBrowse.GetGenre
            str1 = "0||Select All||&&&" + str1
         ElseIf filename = "Productions.xml" Then
            str1 = CBrowse.GetLabel
         ElseIf filename = "ReleaseDates.xml" Then
            str1 = CBrowse.GetAlbumYears
         End If
         tmp2 = Split(str1, "&&&")
         str1 = ""
         sep = ""
         For i = 0 To UBound(tmp2)
            tmp1 = Split(tmp2(i), "||")
            ID = tmp1(0)
            Gen = tmp1(1)
            uniGen = tmp1(2)
            pic = fso.GetParentFolderName(path) + "\" + mID(Gen, 1, 1) + "\" + Gen + "\folder.jpg"
            str = ID & "||" & Gen & "||" & uniGen & "||" & pic
            str1 = str1 + sep + str
            sep = "&&&"
         Next
      Else
         sep = ""
         If filename = "Productions.xml" Then         'Refresh production when add new database //2006.05.19
            lpArrayBrowse = Split(CBrowse.GetLabel(), de_Record)
            If (UBound(lpArrayBrowse) + 1) <> (ichildNodeFound) Then
               bBrowseChanged = True
               Exit Function
'''               str1 = ""
'''               For i = 0 To UBound(lpArrayBrowse)
'''                  lpSplitEach = Split(lpArrayBrowse(i), de_Field)
'''                  ID = lpSplitEach(0)
'''                  Gen = lpSplitEach(1)
'''                  uniGen = lpSplitEach(2)
'''                  pic = fso.GetParentFolderName(path) + "\" + left(Gen, 1) + "\" + Gen + "\folder.jpg"
'''                  str1 = str1 + sep + ID & de_Field & Gen & de_Field & uniGen & de_Field & pic
'''                  sep = de_Record
'''               Next
            End If
         End If
      End If
      
      If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then
        str = xmlPlaylistRoot.Attributes(0).Text & "~" & xmlPlaylistRoot.Attributes(1).Text & "~" & xmlPlaylistRoot.getAttribute("StoreNormal")
      Else
        str = xmlPlaylistRoot.Attributes(0).Text & "~" & xmlPlaylistRoot.Attributes(1).Text & "~" & xmlPlaylistRoot.getAttribute("StoreWidth")
      End If
      GetGenreOrProduction = str1 & "~" & str
   Exit Function
Error:
   WriteEvent "GetGenreOrProduction", Err.Description, Err.Source
End Function
Private Function GetMyFavXml(Name As String) As String
   'EDIT:2006-08-10
   On Error GoTo Error
      Dim str As String
      Set xmlPlaylist = New DOMDocument
      xmlPlaylist.Load MainPath & "\" & Name
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then
         str = xmlPlaylistRoot.getAttribute("StoreNormal")
      Else
         str = xmlPlaylistRoot.getAttribute("StoreWidth")
      End If
      GetMyFavXml = str
   'Exit Function
Error:
   'WriteEvent "GetMyFavXml", Err.Description, Err.Source
End Function

Private Sub SaveLetter(Value As String, filename As String)
   On Error GoTo Error
   Set xmlPlaylist = New DOMDocument
   If Dir(GetLanguageLocation(filename & "s.xml")) <> "" Then
      xmlPlaylist.Load GetLanguageLocation(filename & "s.xml")
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      xmlPlaylistRoot.setAttribute "StoreLetter", Value
      xmlPlaylist.Save GetLanguageLocation(filename & "s.xml")
   End If
   Exit Sub
Error:
   WriteEvent "SaveLetter", Err.Description, Err.Source
End Sub
Private Sub SaveIndexAndCount(index As String, count As String, LevelIndex As String, filename As String, Optional IndexName As String, Optional Ava As String, Optional NumMovie As String)
   On Error GoTo Error
         Set xmlPlaylist = New DOMDocument
         Dim saveString As String
         If Dir(filename) = "" Then
            Set xmlPlaylistRoot = xmlPlaylist.createElement("Items")
            xmlPlaylist.appendChild xmlPlaylistRoot
            xmlPlaylist.Save filename
         End If
         
         xmlPlaylist.Load filename
         Set xmlPlaylistRoot = xmlPlaylist.firstChild
         saveString = index & "~" & count & "~" & LevelIndex & "~" & IndexName & "~" & Ava & "~" & NumMovie
         If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then
            xmlPlaylistRoot.setAttribute "StoreNormal", saveString
         Else
            xmlPlaylistRoot.setAttribute "StoreWidth", saveString
         End If
         xmlPlaylist.Save filename
   Exit Sub
Error:
   WriteEvent "SaveIndexAndCount", Err.Description, Err.Source
End Sub

Private Sub DeleteGenresXml(path As String)
   On Error GoTo Error
   If Dir(path & "\Genres.xml") <> "" Then
      fso.DeleteFile path & "\Genres.xml", True
   End If
   If Dir(path & "\Productions.xml") <> "" Then
      fso.DeleteFile path & "\Productions.xml", True
   End If
   If Dir(path & "\ReleaseDates.xml") <> "" Then
      fso.DeleteFile path & "\ReleaseDates.xml", True
   End If
   Exit Sub
Error:
   WriteEvent "DeleteGenresXml", Err.Description, Err.Source
End Sub

Public Sub SlySize()
   On Error GoTo Error
   Dim mr As RECTM, fr As RECTM
   'EDIT:2006-08-01
   mr = MonitorRECTM(i_SlyMonitor)                          'Always in Primary Display
    One = True
    ScreenType = getScreenType(mr.Width, mr.Height, fileSetupType)
        
   If WinMode = "FullScreen Mode" Then
      If str_swfNames <> "Micro" Then
         SetBorderStyle hwnd, True
         fr.Width = mr.Width
         fr.Height = mr.Height
         ResizeFormPixel hwnd, fr.Width, fr.Height
         MoveForm2Monitor i_SlyMonitor, hwnd, 0, 0
         formWidth = FrmMain.Width
         formHeight = FrmMain.Height
      Else
         ResizeMicroAndAds
      End If
    ElseIf WinMode = "Window Mode" Then
      If IsRegistered = True Then FrmMain.Caption = reged Else FrmMain.Caption = unReg
      'All are in pixels
      If ScreenType = "Normal" Then
         fr.Width = ((mr.Width * 800) / 1024)
         fr.Height = ((mr.Height * 600) / 768)
      ElseIf ScreenType = "wideScreen" Then
         fr.Width = ((mr.Width * 1024) / 1280)
         fr.Height = ((mr.Height * 576) / 720)
      ElseIf ScreenType = "mediumWideScreen" Then
         fr.Width = ((mr.Width * 960) / 1280)
         fr.Height = ((mr.Height * 576) / 768)
      ElseIf ScreenType = "mediumLargeWideScreen" Then
         fr.Width = ((mr.Width * 960) / 1280)
         fr.Height = ((mr.Height * 600) / 800)
      ElseIf ScreenType = "smallWideScreen" Then
         fr.Width = ((mr.Width * 768) / 1024)
         fr.Height = ((mr.Height * 450) / 600)
      ElseIf ScreenType = "largeWideScreen" Then
         fr.Width = ((mr.Width * 1024) / 1280)
         fr.Height = ((mr.Height * 819) / 1024)
      End If
      If str_swfNames <> "Micro" Then
         SetBorderStyle hwnd, False
         FrmMain.WindowState = vbBSNone
         formWidth = fr.Width * Screen.TwipsPerPixelX
         formHeight = fr.Height * Screen.TwipsPerPixelY
         ResizeFormPixel hwnd, fr.Width + wborder, fr.Height + hborder
         MoveForm2Monitor i_SlyMonitor, hwnd, (mr.Width - fr.Width) / 2, (mr.Height - fr.Height) / 2
      Else
         ResizeMicroAndAds
      End If
   End If
   'TextBoxSearchPlayer Me.txtSearchPlayer, formWidth, formHeight
   'rescale_visualization_winamp
   One = False
   Exit Sub
Error:
   WriteEvent "SlySize", Err.Description, Err.Source
End Sub

' declaire varialbe
' copy function slysize

' slysize
'   - form_load
'   - form_paint
' replace all screenX & screenY
' replace imgAlbum_Click in InternalPlayer form
' change to formwidth & formheight in InternalPlayer in Close Fullscreen and add controll when close fullscreen must scale miniplayer
' addmore in timer1 function
' in main form change location statement
' and some statement when exit in page scane
   
'----------------------------------------------------------------------------------
'----------------------------------------------------------------------------------
'PLAYER
'----------------------------------------------------------------------------------
'----------------------------------------------------------------------------------

' resize Internalplayer, Micro, Fullscreen, Ads, picwmp, CWmp
Sub ResizePlayer()
   On Error GoTo Error
    Dim W As Long
    Dim h As Long

    W = formWidth
    h = formHeight

    If str_swfNames = "" Then
        Dim tmpPic As Boolean
        tmpPic = picwmp.Visible
        picwmp.Visible = False
        If Not bool_full_vis Then
            resize_visualization_normal
            If int_track_count > 0 And int_current_index >= 0 Then ZoomToLevel PlayTrackInfo(int_current_index).ZoomLevel
        End If
       
        If Not ((CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded)) Then
            'xxx changed sith 29-05-06
            picwmp.Visible = IIf(CWinsock.LoggedType <> remoteControl, show_hide_player, False)
            picMovieBackground.Visible = IIf(Not picwmp.Visible, False, picMovieBackground.Visible)
            'xxx end xxx
         Else
            picwmp.Visible = False
         End If
        'Debug.Print bool_full_vis
        If bool_full_vis Then
            scale_visualization_to_fullscreen True 'False
        End If
    ElseIf bool_full_vis Then
        bool_full_vis = False
        'Fullscreen True
    End If
   Exit Sub
Error:
   WriteEvent "ResizePlayer", Err.Description, Err.Source
End Sub

Public Sub ResizeMicroAndAds()
   On Error GoTo Error
    If scaleMicroByWidth <> 0 Then
        If str_swfNames = "Micro" Then
            MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height, False
        Else
            MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height
        End If
    End If
   Exit Sub
Error:
   WriteEvent "ResizeMicroAndAds", Err.Description, Err.Source
End Sub

' Display Micro and ads when minimize
Sub MicroAds(Min As Boolean, SHAds As Boolean, byWidth As Integer, byHeight As Integer, Optional b_reunload As Boolean = True)
   On Error GoTo Error
   Static dType As String
   Dim microWidth As Long
   Dim microHeight As Long
   Dim iFlashWidth As Single
   Dim iFlashheight As Single
   Dim tmpTheme As String
   Dim ddd() As String
   Dim iMicroLeft As Long
   Dim iMicroTop As Long
   Dim mr As RECTM, fr As RECTM                                ' EDIT:2006-08-01
   
   
   mr = MonitorRECTM(i_SlyMonitor)
   If ScreenType = "Normal" Then
       byWidth = byWidth
       byHeight = byHeight
   ElseIf ScreenType = "wideScreen" Then
       If byWidth = 640 And byHeight = 480 Then
           byWidth = 768
           byHeight = 432
       ElseIf byWidth = 800 And byHeight = 600 Then
           byWidth = 1024
           byHeight = 576
       ElseIf byWidth = 1024 And byHeight = 768 Then
           byWidth = 1280
           byHeight = 720
       End If
   ElseIf ScreenType = "mediumWideScreen" Then
       If byWidth = 640 And byHeight = 480 Then
           byWidth = 640
           byHeight = 384
       ElseIf byWidth = 800 And byHeight = 600 Then
           byWidth = 960
           byHeight = 576
       ElseIf byWidth = 1024 And byHeight = 768 Then
           byWidth = 1280
           byHeight = 768
       End If
   ElseIf ScreenType = "mediumLargeWideScreen" Then
       If byWidth = 640 And byHeight = 480 Then
           byWidth = 640
           byHeight = 400
       ElseIf byWidth = 800 And byHeight = 600 Then
           byWidth = 960
           byHeight = 600
       ElseIf byWidth = 1024 And byHeight = 768 Then
           byWidth = 1280
           byHeight = 800
       End If
   ElseIf ScreenType = "smallWideScreen" Then
       If byWidth = 640 And byHeight = 480 Then
           byWidth = 640
           byHeight = 375
       ElseIf byWidth = 800 And byHeight = 600 Then
           byWidth = 768
           byHeight = 450
       ElseIf byWidth = 1024 And byHeight = 768 Then
           byWidth = 1024
           byHeight = 600
       End If
   ElseIf ScreenType = "largeWideScreen" Then
       If byWidth = 640 And byHeight = 480 Then
           byWidth = 640
           byHeight = 512
       ElseIf byWidth = 800 And byHeight = 600 Then
           byWidth = 960
           byHeight = 768
       ElseIf byWidth = 1024 And byHeight = 768 Then
           byWidth = 1280
           byHeight = 1024
       End If
   End If
   If Min Then
       ddd = Split(server_display_page, "%%%")
       If UBound(ddd) < 2 Then
           dType = server_display_page
           server_display_page = server_display_page & "%%%" & "Micro"
       End If
       
       If picwmp.Visible = True Then
           ShowVisualization = True
       End If
       
       closeTabStop False
       If b_reunload = True Then
         run_RestoreRECT.left = FrmMain.left
         run_RestoreRECT.top = FrmMain.top
         run_RestoreRECT.Width = FrmMain.Width
         run_RestoreRECT.Height = FrmMain.Height
       End If
       If str_swfNames = "Fullscreen" Then SHF = True
       Call SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE)
       tmrMouse.Enabled = True
       '==do not blink screen when no-caption form is display - sith
       FrmMain.Visible = False
       picMovieBackground.Visible = False
       If b_reunload = True Then load_fullscreen_micro_ads "Micro", 2
       SetBorderStyle hwnd, True
       FrmMain.WindowState = 0
       FrmMain.Visible = True 'true to refresh windowstate
       FrmMain.Visible = False
       '=============================================================
       
       If (CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded) Then
          microWidth = 179
          microHeight = 90
       Else
          If microStyle = oldStyle Then
              microWidth = 100
              microHeight = 75
          ElseIf microStyle = newStyle Then
              microWidth = 144
              microHeight = 90
          End If
       End If
       
       tmpTheme = s_background_color & "::" & s_button_color & "::" & s_button_color_alpha & "::"
       tmpTheme = tmpTheme & s_button_color_selected & "::" & s_button_color_selected_alpha & "::"
       tmpTheme = tmpTheme + s_text_color
       
       sendToFlash SWF_FMA(2), "setColor", tmpTheme
       sendVariable2Flash SWF_FMA(2), "playMusic", CStr(b_play Or (CWinsock.LoggedAs(remoteControl) And (run_PlayState = Playing)))
       sendVariable2Flash SWF_FMA(2), "loopMusic", CStr(b_loop)
       sendVariable2Flash SWF_FMA(2), "shuffleMusic", CStr(b_shuffle)
       sendVariable2Flash SWF_FMA(2), "slideshow", b_slideshow
       sendVariable2Flash SWF_FMA(2), "volume", WaveVolume
       sendVariable2Flash SWF_FMA(2), "mute", CStr(b_mute)
       sendVariable2Flash SWF_FMA(2), "syn_volume", CStr(syn_vol)
       sendVariable2Flash SWF_FMA(2), "syn_volume_change", CStr(change_vol)
       
       sendToFlash SWF_FMA(2), "clientType", CWinsock.LoggedType
       sendToFlash SWF_FMA(2), "textScroll", strCurrent
       sendToFlash SWF_FMA(2), "KaraokeAudio", CStr(b_karaoke_voice)
       
       
       ' end send theme to microplayer
       
       boolLooping = True
       If int_track_count > 0 Then
           sendToFlash SWF_FMA(2), "current_image", strImgCurrent
       End If
       sendToFlash SWF_FMA(2), "showRoot", CStr(True)
       If SHAds = True Then
           If b_reunload = True Then load_fullscreen_micro_ads "Ads", 3
           SWF_FMA(3).TabStop = False
           SWF_FMA(3).Width = (((ScreenX) * (microWidth)) / (byWidth)) * Screen.TwipsPerPixelX
           SWF_FMA(3).Height = (((ScreenY) * (microHeight)) / (byHeight)) * Screen.TwipsPerPixelY
           SWF_FMA(3).left = 0
           SWF_FMA(3).top = 0
                       
           FrmMain.Width = (((ScreenX) * (microWidth + 100)) / (byWidth)) * Screen.TwipsPerPixelX
           FrmMain.Height = (((ScreenY) * (microHeight)) / (byHeight)) * Screen.TwipsPerPixelY
           
           Dim tmp() As String
           tmp = Split(microPosition(0), ":")
           
           If microPosition(1) <> ScreenX & ":" & ScreenY Then
               FrmMain.left = (ScreenX * Screen.TwipsPerPixelX) - (FrmMain.Width + (75 * Screen.TwipsPerPixelX))
               FrmMain.top = 0
           Else
               FrmMain.left = CLng(tmp(0))
               FrmMain.top = CLng(tmp(1))
           End If
                          
           
           SWF_FMA(2).left = SWF_FMA(3).Width
           oneByOneTheme SWF_FMA(3), "default", s_background_color
           
           SWF_FMA(3).Visible = True
           SWF_FMA(3).ZOrder 0
       Else
            fr.Width = ((mr.Width * (microWidth)) / (byWidth))        ' Pixels
            fr.Height = ((mr.Height * (microHeight)) / (byHeight))    ' Pixels
           
           tmp = Split(microPosition(0), ":")
           ResizeFormPixel FrmMain.hwnd, fr.Width, fr.Height
           If microPosition(1) <> mr.Width & ":" & mr.Height Then
               iMicroLeft = mr.Width - (FrmMain.Width / Screen.TwipsPerPixelX + 75)       'Make space between micro and screen edge
               iMicroTop = 0
               MoveForm2Monitor i_SlyMonitor, FrmMain.hwnd, iMicroLeft, iMicroTop
           Else
               iMicroLeft = val(tmp(0))
               iMicroTop = val(tmp(1))
               MoveForm2Monitor i_SlyMonitor, FrmMain.hwnd, iMicroLeft, iMicroTop
           End If
           
           SWF_FMA(2).left = 0
           
       End If
                   
       '==do not display control before scale - sith
       SWF_FMA(2).Visible = True
       If (CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded) Then
          SWF_FMA(2).Move 0, 0, FrmMain.Width, FrmMain.Height         'Move to screen
          SWF_FMA(2).ZOrder 0
          picwmp.Visible = False
       Else
          picwmp.left = 0
          picwmp.top = 0
          picwmp.ZOrder 0
       End If
       
       '=====================2006.05.02=============
       blank_top.Visible = False                 'hide blank_top
       blank_buttom.Visible = False              'hide blank_bottom
       picMovieBackground.Visible = False        'blank screen
       '=====================
       FrmMain.Visible = True
       sendToFlash Swf(0), "hideMiniPlayer", True
       If IndexSwf = 4 Then sendToFlash Swf(4), "hideMiniPlayer", True
       lng_leftMicro = Me.left
       lng_topMicro = Me.top
       'EDIT:2006-08-02 Seng error last screen
       'moveInScreen FrmMain, FrmMain.left, FrmMain.top, ScreenX, ScreenY
       If (run_FormVideoLoaded) Or (CWinsock.LoggedType = remoteControl) Then
       Else
          If run_FormVideoLoaded = False Then
            With picwmp
                .left = 0
                .top = 0
                .Width = FrmMain.Width
                .Height = FrmMain.Height
                .Visible = True
                .ZOrder 0
            End With
            picMovieBackground.Move -ScaleX(0, vbPixels, vbTwips), -ScaleY(0, vbPixels, vbTwips), picwmp.Width + ScaleX(7, vbPixels, vbTwips), picwmp.Height + ScaleY(7, vbPixels, vbTwips)
            CPlayer.stretchToFit = True
            CPlayer.UiMode = "None"
            'CPlayer.Move -ScaleX(3, vbPixels, vbTwips), -ScaleY(3, vbPixels, vbTwips), picwmp.Width + ScaleX(7, vbPixels, vbTwips), picwmp.Height + ScaleY(7, vbPixels, vbTwips) 'change
          End If
       End If
       picMovieBackground.Visible = False
       SWF_FMA(2).SetFocus
   Else
       
      bool_full_vis = False
      FrmMain.Visible = False
      server_display_page = dType
      If show_hide_player Then ShowOrHidePlayer True        '2006-08-12 Seng
   
      closeTabStop True
      If frmPopupBrowse.Visible = True Then sendToFlash frmPopupBrowse.swfPopupBrowse, "close", "true"
      
      tmrMouse.Enabled = False
      Call SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE)
      If byWidth = 0 And byHeight = 0 Then
         unload_fullscreen_micro_ads 2
         If b_ads = True Then unload_fullscreen_micro_ads 3
         If SHF = True Then
            SHF = False
            str_swfNames = "Fullscreen"
            get_track_info True
         End If
         FrmMain.Move run_RestoreRECT.left, run_RestoreRECT.top, run_RestoreRECT.Width, run_RestoreRECT.Height              'Restore last position
         SetBorderStyle FrmMain.hwnd, WinMode = "FullScreen Mode"
      Else
          FrmMain.WindowState = vbMinimized
      End If
       
       display_seek_in_player
       If str_swfNames <> "Fullscreen" Then
            sendToFlash Swf(0), "showMiniPlayer", True
            If IndexSwf = 4 Then
               sendToFlash Swf(4), "showMiniPlayer", True
            End If
            
            If ShowVisualization = True Then
                picwmp.Visible = True
                ShowVisualization = False
            Else
                picwmp.Visible = False
            End If
       End If
       '==
       picMovieBackground.Visible = False
       FrmMain.Visible = True
       If str_swfNames = "Fullscreen" Then
           SWF_FMA(1).SetFocus
       Else
           Swf(IndexSwf).SetFocus
       End If
       '===
'''       If b_play And picwmp.Visible And playMusicWith = Winamp Then MediaPlayer.StartVisualization
   End If   'min
   'swfImagePlaying.Move 0, 0, picMovieBackground.Width, picMovieBackground.Height
   'MovePlayingImage
'''   If playMusicWith = WindowMedia And int_current_index >= 0 And Not run_FormVideoLoaded Then
   If int_current_index >= 0 And Not run_FormVideoLoaded Then
      scaleWMPVdeo         '2005-10-31      Show zoom level
   ElseIf str_swfNames = "Micro" Then
      picwmp.Visible = True
   End If
   
'''   If playMusicWith = nero And b_play Then
'''      NSPlayer.scaleVdeo
'''      FrmMain.NSPlayer.zoomVdeo
'''   End If
   FrmMain.Visible = True
   Exit Sub
Error:
   WriteEvent "MicroAds", Err.Description, Err.Source
End Sub
' send track info to mini player ( scrolling )
Function textScroll(ind As Integer) As String
   On Error GoTo Error
    'If CWmp.currentPlaylist.count > 0 Then
    If int_track_count > 0 And ind < int_track_count And b_play = True Then
        Dim Tr As String
        Dim Ar As String
        Dim al As String
          
        Dim cap_Tr As String
        Dim cap_Ar As String
        Dim cap_Al As String
        
        Dim FN As String
        Dim fs As String
        
        Dim strTrack As String
        
        Const strSplit = "//\\"
        Const ss = "\\//"
        
        Dim strC As String
        Dim strTr As String
        Dim strAr As String
        Dim strAl As String
        Dim strFontName As String
        Dim strFontSize As String
        
        strC = readXMLCaption(CountryPath & "\Language.xml", Language, currentCountry, ScreenType)
        
        
        If Infos(ind).trackExternal = False Then
            
            strTr = GTI(Language, ind, ss, "Title")
            strAr = GTI(Language, ind, ss, "Artist")
            strAl = GTI(Language, ind, ss, "Album")
            
        Else
            strFontName = Infos(ind).trackFontName.Eng
            strFontSize = Infos(ind).trackFontsize.Eng
            If CPlayer.MediaIsnothing = False Then
               Tr = Infos(ind).TrackTitle.Eng
               strTr = Tr & ss & strFontName & ss & strFontSize
               Ar = Infos(ind).trackArtist.Eng
               strAr = Ar & ss & strFontName & ss & strFontSize
               al = Infos(ind).trackAlbum.Eng
            End If
            strAl = al & ss & strFontName & ss & strFontSize
        End If
        
        strTrack = strC & strSplit & strTr & strSplit & strAr & strSplit & strAl
        textScroll = strTrack
    End If
   Exit Function
Error:
   WriteEvent "textScroll", Err.Description, Err.Source
End Function

'   -----------------------------------------------------------------------
'   getPathLanguage         03/02/04
'       args:   str_FullPath => path of xml file
'               str_language => "Uni/Eng" value this argument
'               str_currentLanguage => language name
'               str_screen => screen type
'       return: TitleCaption\\//ArtistCaption\\//AlbumCaption\\//fontName\\//fontSize\\//nextCaption\\//previousCaption
'   -----------------------------------------------------------------------
Private Function readXMLCaption(str_FullPath As String, str_Language As String, str_currentLanguage As String, str_screen As String) As String
   On Error GoTo Error
    Dim doc As DOMDocument
    Dim fon As IXMLDOMElement
    Dim cap As IXMLDOMElement
    
    Dim str_Title As String
    Dim str_Artist As String
    Dim str_Album As String
    Dim str_fontName As String
    Dim str_fontSize As String
    Dim str_nextTrack As String
    Dim str_preTrack As String
    
    Dim noXML As Boolean
    
    Set doc = New DOMDocument
    doc.Load str_FullPath
    
    If fon Is Nothing Then
        noXML = True
        GoTo no_XML
    End If
    
    Set fon = doc.firstChild.childNodes(0)
    Set cap = doc.firstChild.childNodes(1)

    If str_Language = "Eng" Then
        str_Title = "Title:"
        str_Artist = "Artist:"
        str_Album = "Album:"
        str_nextTrack = "Next"
        str_preTrack = "Previous"
        str_fontName = fon.getAttribute("FontEng")
        If str_screen <> "Normal" Then
            str_fontSize = fon.getAttribute("FontEngSizeWide")
        Else
            str_fontSize = fon.getAttribute("FontEngSize")
        End If
    Else
        str_Title = cap.getAttribute("miniTitle")
        str_Artist = cap.getAttribute("miniArtist")
        str_Album = cap.getAttribute("miniAlbum")
        str_nextTrack = cap.getAttribute("UniNextTrack")
        str_preTrack = cap.getAttribute("UniPreTrack")
        
        If str_Title = "" Or str_Artist = "" Or str_Album = "" Then
            str_Title = "Title:"
            str_Artist = "Artist:"
            str_Album = "Album:"
            str_nextTrack = "Next"
            str_preTrack = "Previous"
            
            str_fontName = fon.getAttribute("FontEng")
            If str_screen <> "Normal" Then
                str_fontSize = fon.getAttribute("FontEngSizeWide")
            Else
                str_fontSize = fon.getAttribute("FontEngSize")
            End If
        Else
            If str_currentLanguage = "Khmer" Then
                str_Title = str_Title & "�"
                str_Artist = str_Artist & "�"
                str_Album = str_Album & "�"
            Else
                str_Title = str_Title & ":"
                str_Artist = str_Artist & ":"
                str_Album = str_Album & ":"
            End If
            str_fontName = fon.getAttribute("FontUni")
            If str_screen <> "Normal" Then
                str_fontSize = fon.getAttribute("FontUniSizeWide")
            Else
                str_fontSize = fon.getAttribute("FontUniSize")
            End If
        End If
    End If

    readXMLCaption = str_Title & "\\//" & str_Artist & "\\//" & str_Album & "\\//" & str_fontName & "\\//" & str_fontSize & "\\//" & str_nextTrack & "\\//" & str_preTrack
no_XML:
    If noXML = True Then
        str_Title = "Title:"
        str_Artist = "Artist:"
        str_Album = "Album:"
        str_nextTrack = "Next"
        str_preTrack = "Previous"
        str_fontName = "Arial"
        If str_screen <> "Normal" Then
            str_fontSize = 34
        Else
            str_fontSize = 28
        End If
        readXMLCaption = str_Title & "\\//" & str_Artist & "\\//" & str_Album & "\\//" & str_fontName & "\\//" & str_fontSize & "\\//" & str_nextTrack & "\\//" & str_preTrack
    End If
   Exit Function
Error:
   WriteEvent "readXMLCaption", Err.Description, Err.Source
End Function


' test infon
' function get track info from the current playing
Function GTI(stLan As String, stind As Integer, stSpl As String, stType As String) As String
   On Error GoTo Error
    Dim stN As String
    Dim stFN As String
    Dim stFS As String
    If stLan = "Uni" Then
         If stType = "Title" Then
             stN = Infos(stind).TrackTitle.Uni
         ElseIf stType = "Artist" Then
             stN = Infos(stind).trackArtist.Uni
         ElseIf stType = "Album" Then
             stN = Infos(stind).trackAlbum.Uni
         End If
         stFN = Infos(stind).trackFontName.Uni
         stFS = Infos(stind).trackFontsize.Uni
         If stN = "" Then
             If stType = "Title" Then
                 stN = Infos(stind).TrackTitle.Eng
             ElseIf stType = "Artist" Then
                 stN = Infos(stind).trackArtist.Eng
             ElseIf stType = "Album" Then
                 stN = Infos(stind).trackAlbum.Eng
             End If
             stFN = Infos(stind).trackFontName.Eng
             stFS = Infos(stind).trackFontsize.Eng
         End If
    Else
        If stType = "Title" Then
            stN = Infos(stind).TrackTitle.Eng
        ElseIf stType = "Artist" Then
            stN = Infos(stind).trackArtist.Eng
        ElseIf stType = "Album" Then
            stN = Infos(stind).trackAlbum.Eng
        End If
        stFN = Infos(stind).trackFontName.Eng
        stFS = Infos(stind).trackFontsize.Eng
        If stN = "" Then
            If stType = "Title" Then
                stN = Infos(stind).TrackTitle.Uni
            ElseIf stType = "Artist" Then
                stN = Infos(stind).trackArtist.Uni
            ElseIf stType = "Album" Then
                stN = Infos(stind).trackAlbum.Uni
            End If
            stFN = Infos(stind).trackFontName.Uni
            stFS = Infos(stind).trackFontsize.Uni
        End If
    End If
    GTI = stN & stSpl & stFN & stSpl & stFS
   Exit Function
Error:
   WriteEvent "GTI", Err.Description, Err.Source
End Function


' function for test next track
Function str_Next(TF_shuffle As Boolean, TF_loop As Boolean, TF_first As String, TF_middle As String, TF_last As String, cur_Play As Integer) As String
   On Error GoTo Error
    Dim Tr As String
    Dim FN As String
    Dim fs As String
    Dim ncap As String
    
    If TF_shuffle = True Then
        If TF_loop = True Then
            If TF_first = "1" And TF_middle = "0" And TF_last = "0" Then GoTo oneTrack
        End If
    Else
        If TF_loop = True Then
            If TF_first = "1" Or TF_last = "1" Then
                GoTo oneTrack
            ElseIf TF_middle = "1" Then
                GoTo moreTrack
            End If
        Else
            If TF_first = "0" And TF_middle = "1" And TF_last = "0" Then GoTo moreTrack
        End If
    End If
    str_Next = ""
    i_indexNextTrack = -1
    Exit Function
    
oneTrack:
    i_indexNextTrack = 0
    If Infos(0).trackExternal = 1 Or Language = "Eng" Then
        Tr = Infos(0).TrackTitle.Eng
        FN = Infos(0).trackFontName.Eng
        fs = Infos(0).trackFontsize.Eng
        If Tr = "" Then
            Tr = Infos(0).TrackTitle.Uni
            FN = Infos(0).trackFontName.Uni
            fs = Infos(0).trackFontsize.Uni
        End If
    Else
        Tr = Infos(0).TrackTitle.Uni
        If Tr <> "" Then
            FN = Infos(0).trackFontName.Uni
            fs = Infos(0).trackFontsize.Uni
        Else
            Tr = Infos(0).TrackTitle.Eng
            FN = Infos(0).trackFontName.Eng
            fs = Infos(0).trackFontsize.Eng
        End If
    End If
    str_Next = Tr & "//\\" & FN & "//\\" & fs
    Exit Function
    
moreTrack:
    i_indexNextTrack = cur_Play
    If Infos(cur_Play).trackExternal = 1 Or Language = "Eng" Then
        Tr = Infos(cur_Play).TrackTitle.Eng
        FN = Infos(cur_Play).trackFontName.Eng
        fs = Infos(cur_Play).trackFontsize.Eng
        If Tr = "" Then
            Tr = Infos(cur_Play).TrackTitle.Uni
            FN = Infos(cur_Play).trackFontName.Uni
            fs = Infos(cur_Play).trackFontsize.Uni
        End If
    Else
        Tr = Infos(cur_Play).TrackTitle.Uni
        If Tr <> "" Then
            FN = Infos(cur_Play).trackFontName.Uni
            fs = Infos(cur_Play).trackFontsize.Uni
        Else
            Tr = Infos(cur_Play).TrackTitle.Eng
            FN = Infos(cur_Play).trackFontName.Eng
            fs = Infos(cur_Play).trackFontsize.Eng
        End If
    End If
    str_Next = Tr & "//\\" & FN & "//\\" & fs
    Exit Function
   Exit Function
Error:
   WriteEvent "str_Next", Err.Description, Err.Source
End Function


' send all setting
Sub theme(flashMovie As ShockwaveFlashObjectsCtl.ShockwaveFlash)
   On Error GoTo Error
   sendToFlash flashMovie, "clientType", CWinsock.LoggedType
   'sendToFlash flashMovie, "karaoke_voice", CStr(b_karaoke_voice)
   sendVariable2Flash flashMovie, "val_color_bar", s_color_bar
   sendVariable2Flash flashMovie, "val_hideMouse", b_hideMouse
   sendVariable2Flash flashMovie, "val_reg", b_reg
   sendVariable2Flash flashMovie, "val_backgroundColor", s_background_color
   sendVariable2Flash flashMovie, "val_buttonColor", s_button_color
   sendVariable2Flash flashMovie, "val_buttonAlpha", s_button_color_alpha
   sendVariable2Flash flashMovie, "val_buttonSelectedColor", s_button_color_selected
   sendVariable2Flash flashMovie, "val_buttonSelectedAlpha", s_button_color_selected_alpha
   sendVariable2Flash flashMovie, "val_play", b_play
   sendVariable2Flash flashMovie, "val_textColor", s_text_color
   sendVariable2Flash flashMovie, "val_tooltip", b_tooltip
   sendVariable2Flash flashMovie, "val_loop", b_loop
   sendVariable2Flash flashMovie, "val_shuffle", b_shuffle
   sendVariable2Flash flashMovie, "val_mute", b_mute
   sendVariable2Flash flashMovie, "val_slideShow", b_slideshow
   sendVariable2Flash flashMovie, "val_scroll", b_scroll
   sendVariable2Flash flashMovie, "val_display", s_display_type
   sendVariable2Flash flashMovie, "val_volume", WaveVolume
   sendVariable2Flash flashMovie, "sendVar", "true"
   sendVariable2Flash flashMovie, "syn_volume", CStr(syn_vol)
   sendVariable2Flash flashMovie, "syn_volume_change", CStr(change_vol)
   sendVariable2Flash flashMovie, "extension", CPlayer.UrlExtension
   Exit Sub
Error:
   WriteEvent "theme", Err.Description, Err.Source
End Sub

' send one by one setting
Sub oneByOneTheme(SwfFlash As ShockwaveFlashObjectsCtl.ShockwaveFlash, VarName As String, values As String)
   On Error GoTo Error
   Dim strvar As String
   strvar = Trim("val_" & VarName)
   sendVariable2Flash SwfFlash, Trim(strvar), Trim(values)
   sendVariable2Flash SwfFlash, "sendVar", "true"
   Exit Sub
Error:
   WriteEvent "oneByOneTheme", Err.Description, Err.Source
End Sub

' for split all setting color
Sub FunOptions(command, args As String, Optional dontSend2Server As Boolean)
   On Error GoTo Error
      Dim stColor As Long
      Dim stFont As String
      Dim stSplit() As String
      Dim spl() As String
      Dim variableStore As String
      If command = "Back" Then
         If IndexOptionToLoad = 4 Then
                LoadSwfPlayListPlayerPage "6"
                ShowOrHidePlayer True
                IndexOptionToLoad = 0
         ElseIf IndexOptionToLoad = 3 Then
                Load Swf(3)
                LoadSwfPlayListPage "6"
                IndexOptionToLoad = 0
         ElseIf IndexOptionToLoad = "2" Then
                Load Swf(2)
                LoadSwfSearchPage "6"
                IndexOptionToLoad = 0
         Else
            If ChangeIcon <> "" Then
                sendVariable2Flash Swf(0), "DisplayAlbumLong", DisplayAlbumLong
                sendVariable2Flash Swf(0), "SetAlbumNum", ChangeIcon
                ChangeIcon = ""
            End If
            sendVariable2Flash Swf(0), "UnloadEx", 6
            sendVariable2Flash Swf(0), "OpenFrame", "true"
            sendToFlash Swf(0), "setOffsetEnabled", CStr(setEnableSeekOfsset)
            sendToFlash Swf(0), "showMiniPlayer", True
            Swf(0).Visible = True
            
            server_display_language = currentCountry
            server_display_page = ""
            IndexSearchToLoad = 0
            IndexPlaylistToLoad = 0
            IndexPlayerToLoad = 0
            IndexOptionToLoad = 0
            
            IndexSwf = 0
            If ValuePlayer = 4 Then
                ShowOrHidePlayer True
                DisplayMini = 1
            Else
                ShowOrHidePlayer False
                DisplayMini = 0
            End If
         End If
      ElseIf command = "SingerSong" Then
         If args = "true" Then
            i_SearchTrackFromArtist = 1
         Else
            i_SearchTrackFromArtist = 0
         End If
         sendVariable2Flash Swf(0), "i_SearchTrackFromArtist", i_SearchTrackFromArtist
         EditSetting MainPath & "\Language.xml", 0, "SearchTrackFromArtist", LCase(i_SearchTrackFromArtist)
         'sendToFlash
      ElseIf command = "SlyMode" Then
         'mode when changing from Option Page
         FrmMain.KeyCtrlPlus "W~0"
         'WinMode = args
         'If args = "WinMode" Then WinMode = "Window Mode" Else WinMode = "FullScreen Mode"
      ElseIf command = "BrowseRemotePlaylistPath" Then
         variableStore = BrowseForFolder(CUserLogin.LinkingPlayListPath, hwnd)
         If variableStore <> "" Then
            CUserLogin.LinkingPlayListPath = variableStore
            EditSetting MainSettingXML, 0, "LinkingPlaylistPath", CUserLogin.LinkingPlayListPath
            sendToFlash Swf(IndexSwf), "LinkingPlaylistPath", CUserLogin.LinkingPlayListPath
            
         End If
      ElseIf command = "ResizeFromServer" Then
         Settings.b_GetZoomLevelFromServer = (args = "true")
         EditSetting MainSettingXML, 0, "ResizeFromServer", args
      ElseIf command = "SetNumRemoteClient" Then
         CWinsock.Send2Server WS_COMMAND, "RequestChangeMaxRemoteControl&&&" & args       'change user password
      'Multiple monitor==============================================
      ElseIf command = "SlyMonitor" Then
         i_SlyMonitor = val(args) - 1
         EditSetting MainSettingXML, 0, "SlyMonitor", LCase(i_SlyMonitor)
      ElseIf command = "SlyVideo" Then
         i_VideoMonitor = val(args) - 1
         EditSetting MainSettingXML, 0, "VideoMonitor", LCase(i_VideoMonitor)
      '======================EDIT:2006-08-03 Seng====================
      ElseIf command = "allow_connection" Then
          b_default_permission = True
          EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
          b_deny = False
          EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
      ElseIf command = "allow_connection_by_manual" Then
          b_default_permission = False
          EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
          b_deny = False
          EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
      ElseIf command = "deny_all_connection" Then
          b_deny = args = "true"
          EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
          b_default_permission = False
          EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
      ElseIf command = "ShowPopupinfo" Then
          b_ShowPopupInfo = val(args) = 1
          EditSetting MainSettingXML, 0, "ShowPopupinfo", CStr(b_ShowPopupInfo)
      ElseIf command = "streamType" Then
          setStreamType = val(args)
          EditSetting MainSettingXML, 0, "streamType", val(setStreamType)
      ElseIf command = "Permission" Then
          str_permission = args
          EditSetting MainSettingXML, 0, "permission", str_permission
      
      ElseIf command = "control_only" Then
''''''''''         Settings.boolNoPlayBackWithCloneDisplay = (args = "true")
         EditSetting MainSettingXML, 2, "control_only", args
         
      ElseIf command = "request_slideshow_path" Then
          sendToFlash Swf(6), "setSlidePath", current_slideshow_path
         
      ElseIf command = "FriendPlaylist" Then
          friend_playlist = args = "true"
          EditSetting MainSettingXML, 0, "share_playlist", LCase(friend_playlist)
          If (CWinsock.LoggedType <> ServerMode And friend_playlist = True) Or CWinsock.LoggedType = cloneDisplay Then
              'CWinsock.Send2Server WS_COMMAND, "request_friend_playlist&&&"
              CWinsock.Send2Server WS_COMMAND, "request_all_friend_playlists&&&"
          End If
      ElseIf command = "ChangeTrackTitleStyle" Then
         i_ShowUnderTrackTitle = val(args)
         sendToFlash Swf(0), "ChangeTrackTitleStyle", args
         EditSetting MainSettingXML, 0, "ShowUnderTrackTitle", CStr(i_ShowUnderTrackTitle)
      ElseIf command = "syn_vol" Then   'for client when change volume send volume to server change with client
          syn_vol = args = "true"
          EditSetting MainSettingXML, 2, "syn", LCase(syn_vol)
          If IndexSwf <> 0 Then sendVariable2Flash Swf(0), "syn_volume", CStr(syn_vol)
          sendVariable2Flash Swf(IndexSwf), "syn_volume", CStr(syn_vol)
'''          If frmScan.Visible = True Then sendVariable2Flash frmScan.swfScan, "syn_volume", CStr(syn_vol)
'''          If frmRip.Visible = True Then sendVariable2Flash frmRip.swfRip, "syn_volume", CStr(syn_vol)
          
      ElseIf command = "change_vol" Then    'for server allow server change volume in server if client request change volume
          change_vol = args = "true"
          EditSetting MainSettingXML, 2, "syn_vol_change", LCase(change_vol)
          If IndexSwf <> 0 Then sendVariable2Flash Swf(0), "syn_volume_change", CStr(change_vol)
          sendVariable2Flash Swf(IndexSwf), "syn_volume_change", CStr(change_vol)
'''          If frmScan.Visible = True Then sendVariable2Flash frmScan.swfScan, "syn_volume_change", CStr(change_vol)
'''          If frmRip.Visible = True Then sendVariable2Flash frmRip.swfRip, "syn_volume_change", CStr(change_vol)
      
      ElseIf command = "setReencode" Then
          b_ReEncode = args = "true"
          EditSetting MainSettingXML, 0, "reencode", LCase(b_ReEncode)
      ElseIf command = "setBrowseByFolder" Then
         b_BrowseByFolder = args = "true"
      ElseIf command = "setExternalPowerDVD" Then
         b_ExternalPowerDVD = args = "true"
      ElseIf command = "setDownloadAll" Then
          boolDownloadAll = args = "true"
          EditSetting MainSettingXML, 0, "downloadAll", LCase(boolDownloadAll)
      
      
      ElseIf command = "syn" Then   'for slideshow when client load slidehsow
          syn = args = "true"
          EditSetting MainSettingXML, 1, "syn", LCase(syn)
          
      ElseIf command = "popup_exit" Then    ' for display button exit in fullscreen player page
          popup_exit = args = "true"
          EditSetting MainSettingXML, 0, "popup_exit", LCase(popup_exit)
          
      ElseIf command = "resize_image_server" Then
          b_resize = args = "true"
          EditSetting MainSettingXML, 1, "resize", LCase(b_resize)
      
      ElseIf command = "AllowSlideshow" Then    ' for server allow server syncronize change with server
          b_AllowSlideshow = args = "true"
          EditSetting MainSettingXML, 1, "allow_slideshow", LCase(b_AllowSlideshow)
      ElseIf command = "localLink" Then
          b_local_link = args = "true"
          EditSetting MainSettingXML, 0, "local_link", LCase(b_local_link)
          If CWinsock.LoggedType <> ServerMode And CWinsock.LoggedType <> independentMode And b_local_link And Not b_play Then
             miniCommand "Play|:|true", False
          End If
      ElseIf command = "clone_display" Then
          type_login_display = args = "true"
          EditSetting MainSettingXML, 0, "clone_display", LCase(type_login_display)
      ElseIf command = "clone_playback" Then
          type_login_playback = args = "true"
          EditSetting MainSettingXML, 0, "clone_playback", LCase(type_login_playback)
      ElseIf command = "independent" Then
          type_login_independent = args = "true"
          EditSetting MainSettingXML, 0, "independent", LCase(type_login_independent)
      ElseIf command = "Remotecontrol" Then
          type_login_remoteControl = args = "true"
          EditSetting MainSettingXML, 0, "remotecontrol", LCase(type_login_remoteControl)
      ElseIf command = "stream" Then
        CWinsock.StreamFile = args = "true"
        EditSetting MainSettingXML, 0, "streamFile", LCase(CStr(CWinsock.StreamFile))
      ElseIf command = "playchapter" Then
        playChapterType = args = "true"
        EditSetting MainSettingXML, 0, "playchapterFile", playChapterType
        If b_loadAlready Then sendToFlash Swf(0), "PlayChapterState", playChapterType
      ElseIf command = "set_resize_image" Then
        resize_image = CBool(args)
        EditSetting MainSettingXML, 0, "resizeImage", CStr(resize_image)
      ElseIf command = "" Then
        resize_image = CBool(args)
        EditSetting MainSettingXML, 0, "resizeImage", CStr(resize_image)
      ElseIf command = "priorityExtension" Then
          stringPriorityEXT = args
          EditSetting MainSettingXML, 0, "priorityExtension", args
      ElseIf command = "StringsubList" Then
         StringsubList = args
         'Refresh only in interfaceCD (interfaceCd is not unloaded while goto setting page)
         sendVariable2Flash Swf(0), "StringsubList", StringsubList
         sendVariable2Flash Swf(0), "SetAlbumCover", "true"
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         EditSetting MainSettingXML, 0, "subList", args
      ElseIf command = "priorityMplayer" Then
          StringPriorityMplayer = args
          EditSetting MainSettingXML, 0, "priorityMplayer", args
      ElseIf command = "trackType" Then
      
          setDisplayTrackType = args
          EditSetting MainSettingXML, 0, "trackType", args
          
          Dim tmpType As String
          tmpType = display_track_list_type(setDisplayTrackType)
          sendVariable2Flash Swf(0), "TrackNames", tmpType
          sendToFlash Swf(0), "changeDisplayTrackType", tmpType
          sendVariable2Flash Swf(IndexSwf), "TrackNames", tmpType
          
          sendToFlash Swf(IndexSwf), "changeDisplayTrackType", tmpType
         sendToFlash Swf(0), "setMusicNote", MusicNoteValue
      ElseIf command = "DVDControlType" Then
          setDisplayDvdContol = args
          EditSetting MainSettingXML, 0, "DVDControlType", args
      ElseIf command = "turnMonitor" Then
      
          setMonitor = args
          EditSetting MainSettingXML, 0, "monitor", args
          If CPlayer.PlayWith = WindowMedia Then
            EnableScreensaver = args
          End If
          
      ElseIf command = "microStyle" Then
      
        microStyle = CInt(args)
        EditSetting MainSettingXML, 2, "microStyle", args
        
      ElseIf command = "ripMusicWith" Then
         If args = "ripWithiTunes" Then
            ripMusicWith = ripWithiTunes
         Else
            ripMusicWith = ripWithWindowMedia
         End If
         
         EditSetting MainSettingXML, 2, "ripWith", args
         
      ElseIf command = "playMusicWith" Then
         If val(args) = MediaPlayer Then
            playMusicWith = MediaPlayer
         ElseIf val(args) = WindowMedia Then
            playMusicWith = WindowMedia
         ElseIf val(args) = PowerDVD Then
            playMusicWith = PowerDVD
         End If
      ElseIf command = "InternetConnected" Then
         NoInternetConnected = val(args)
         sendVariable2Flash Swf(0), "NoInternetConnected", NoInternetConnected
         sendVariable2Flash Swf(0), "RefreshTrackInfo", "true"
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         EditSetting MainSettingXML, 0, "NoInternet", args
      ElseIf command = "AutoDownload" Then
         AutoDownload = val(args)
         EditSetting MainSettingXML, 0, "AutoDownload", args
      ElseIf command = "auto_new_database" Then
         auto_new_database = args = "true"
         EditSetting MainSettingXML, 0, "auto_new_database", LCase(auto_new_database)
         
      ElseIf command = "BrowseMainPath" Then
         spl = Split(args, "|||")
         If spl(0) = "MPlayer" Then
            On Error Resume Next
            cdl.filter = "Media Player Classic|*.exe"
            cdl.flags = cdlOFNHideReadOnly
            cdl.ShowOpen Me.hwnd
            If cdl.filename <> "" Then
               sendToFlash Swf(6), "MPlayer", cdl.filename
               MPlayerPath = cdl.filename
            End If
            On Error GoTo 0
         Else
            tmp_browse_folder = BrowseForFolder(spl(1), hwnd)
            If tmp_browse_folder <> "" Then
               If spl(0) = "DB" Then
                   sendVariable2Flash Swf(6), "BrowseMainPath", tmp_browse_folder
                   sendVariable2Flash Swf(6), "GetColorReady", "true"
               ElseIf spl(0) = "Pic" Then
                   sendToFlash Swf(6), "PicPath", tmp_browse_folder
               ElseIf spl(0) = "AdvPath" Then
                  sendToFlash Swf(6), "AdvPath", tmp_browse_folder
                  AdvPath = tmp_browse_folder
               End If
            End If
         End If
      ElseIf command = "SaveMainDB" Then
           spl = Split(args, "%~%")
           changeLanguagePath spl(0), spl(1)
           ReloadCountryFromXML
      ElseIf command = "ScanComplete" Then
        EditSetting MainSettingXML, 0, "ScanComplete", args
        SplitColor = ReplaceStrSpl(SplitColor, 25, args, "~")
        b_autoClose = args = "true"
      ElseIf command = "Grouping" Then
        
            spl = Split(args, "~")
            Grouping = val(spl(0))
            EditSetting MainPath & "\Language.xml", 0, "Grouping", spl(0)
            'CBrowse.mSelectAlbumType = all
            CBrowse.mSelectGroupCDType = Grouping              ' 0 mean group,-1 mean not group
            If spl(1) = "true" Then
                sendVariable2Flash Swf(0), "RefreshGrouping", "true"
                sendVariable2Flash Swf(0), "OpenFrame", "true"
            End If
        
      
      ElseIf command = "ShowCountry" Then
         LoadSwfCountry 6
      ElseIf command = "ShowScan" Then
'''         frmScan.showMe
      ElseIf command = "ShowSearch" Then
         IndexSearchToLoad = 6
         Load Swf(2)
         LoadSwfSearchPage "6"
      ElseIf command = "Exit" Then
         miniCommand "Stop" & "|:|" & True
         End
      ElseIf command = "ShowPlayList" Then
         IndexPlaylistToLoad = 6
         Load Swf(3)
         LoadSwfPlayListPage "6"
     ElseIf command = "DisplayPage" Then
         DisplayPage = args
     ElseIf command = "ShowColorBox" Then
            Dim Colorvalue As String
            Colorvalue = args
            s_background_color = Colorvalue
            EditSetting MainSettingXML, 0, "ColorBg", Colorvalue
            SplitColor = ReplaceStrSpl(SplitColor, 0, Colorvalue, "~")
            sendVariable2Flash Swf(0), "SetNewBgColor", "true"
            sendVariable2Flash Swf(0), "BgColorValue", Colorvalue
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         
      ElseIf command = "ShowColorBarBox" Then
            Dim ColorValue1 As String
            ColorValue1 = args
            EditSetting MainSettingXML, 0, "ColorBar", ColorValue1
            SplitColor = ReplaceStrSpl(SplitColor, 23, ColorValue1, "~")
            sendVariable2Flash Swf(0), "SetNewColorBar", ColorValue1
            sendVariable2Flash Swf(0), "OpenFrame", "true"
     
     ElseIf command = "ShowColorRatingBox" Then
            Dim ColorValue2 As String
            ColorValue2 = args
            EditSetting MainSettingXML, 0, "ColorRating", ColorValue2
            SplitColor = ReplaceStrSpl(SplitColor, 26, ColorValue2, "~")
            sendVariable2Flash Swf(0), "SetNewColorRating", ColorValue2
            sendVariable2Flash Swf(0), "OpenFrame", "true"
         
     ElseIf command = "ChangeColorFont" Then
           Dim FontColorValue As String
           FontColorValue = args
           s_text_color = FontColorValue
           EditSetting MainSettingXML, 0, "FontColor", FontColorValue
           SplitColor = ReplaceStrSpl(SplitColor, 10, FontColorValue, "~")
           
           sendVariable2Flash Swf(0), "SetNewBgColor", "true"
           sendVariable2Flash Swf(0), "FontColor", FontColorValue
           sendVariable2Flash Swf(0), "OpenFrame", "true"
           '...color font
           RefreshSwf
         
     ElseIf command = "DisplayAlbumLong" Then
         spl = Split(args, "%~%")
         args = spl(0)
         DisplayAlbumLong = args
         DisplayAlbumLongSearch = args
         DisplayAlbumLongPlaylist = args
         ChangeIcon = spl(1)
         EditSetting MainSettingXML, 0, "DisplayAlbumList", DisplayAlbumLong
         EditSetting MainSettingXML, 0, "DisplayAlbumListSearch", DisplayAlbumLongSearch
         EditSetting MainSettingXML, 0, "DisplayAlbumListPlaylist", DisplayAlbumLongPlaylist
         sendVariable2Flash Swf(0), "DisplayAlbumLong", args
         
     ElseIf command = "ChangeAlbumNum" Then
     '.........album icons davi
       ChangeIcon = args
       EditSetting MainSettingXML, 0, "AlbumNum", args
       SplitColor = ReplaceStrSpl(SplitColor, 1, args, "~")
       
     ElseIf command = "ChangeCoverAlbum" Then
       EditSetting MainSettingXML, 0, "AlbumCover", args
       SplitColor = ReplaceStrSpl(SplitColor, 2, args, "~")
       sendVariable2Flash Swf(0), "AlbumCover", args
       sendVariable2Flash Swf(0), "SetAlbumCover", "true"
       sendVariable2Flash Swf(0), "OpenFrame", "true"
     ElseIf command = "ChangeMicroPlayer" Then
       b_micro = args = "true"
       EditSetting MainSettingXML, 2, "Micro", args
       SplitPlayer = ReplaceStrSpl(SplitPlayer, 6, args, "~")
       Micro = args
     ElseIf command = "ChangeMicroScale" Then
         stSplit = Split(args, " x ")
         EditSetting MainSettingXML, 2, "MicroScale", args
         SplitPlayer = ReplaceStrSpl(SplitPlayer, 8, args, "~")
         scaleMicroByWidth = val(stSplit(0)) ' 640 || 800 || 1024
         scaleMicroByHeight = val(stSplit(1))   ' 480 || 600 || 768
     ElseIf command = "ChangeCoverNum" Then
        EditSetting MainSettingXML, 0, "NumCover", args
        SplitColor = ReplaceStrSpl(SplitColor, 3, args, "~")
        sendVariable2Flash Swf(0), "NumCover", args
        sendVariable2Flash Swf(0), "SetAlbumCover", "true"
        sendVariable2Flash Swf(0), "OpenFrame", "true"
        
     ElseIf command = "ChangeCoverPlus" Then
        EditSetting MainSettingXML, 0, "PlusCover", args
        SplitColor = ReplaceStrSpl(SplitColor, 20, args, "~")
        sendVariable2Flash Swf(0), "PlusCover", args
        sendVariable2Flash Swf(0), "SetAlbumCover", "true"
        sendVariable2Flash Swf(0), "OpenFrame", "true"
        
     ElseIf command = "ChangeTrackPosUni" Then
        EditSetting MainPath & "\Language.xml", 0, "TrackPosUni", args
        StrFont = ReplaceStrSpl(StrFont, 5, args, "~")
        sendVariable2Flash Swf(0), "TrackPosUni", args
        sendVariable2Flash Swf(0), "SetTrackPos", "true"
        sendVariable2Flash Swf(0), "OpenFrame", "true"
     ElseIf command = "ChangeTrackPos" Then
        EditSetting MainPath & "\Language.xml", 0, "TrackPos", args
        StrFont = ReplaceStrSpl(StrFont, 4, args, "~")
        sendVariable2Flash Swf(0), "TrackPosEng", args
        sendVariable2Flash Swf(0), "SetTrackPos", "true"
        sendVariable2Flash Swf(0), "OpenFrame", "true"
        
     ElseIf command = "ChangeEngFont" Then
     On Error GoTo CancelPressed
       stSplit = Split(args, ",")
       cdlFont.FontName = stSplit(0)
       cdlFont.FontSize = val(stSplit(1))
       cdlFont.flags = 1
       cdlFont.ShowFont
       stFont = cdlFont.FontName
       If Len(stFont) > 0 Then
           sendVariable2Flash Me.Swf(6), "PassFontEngValue", stFont
           sendVariable2Flash Me.Swf(6), "PassFontEngSize", cdlFont.FontSize
           sendVariable2Flash Me.Swf(6), "GetColorReady", "true"
           EditSetting MainPath & "\Language.xml", 0, "FontEng", stFont
           If ScreenType = "Normal" Or ScreenType = "smallWideScreen" Or ScreenType = "largeWideScreen" Then
              EditSetting MainPath & "\Language.xml", 0, "FontEngSize", cdlFont.FontSize
           Else
               EditSetting MainPath & "\Language.xml", 0, "FontEngSizeWide", cdlFont.FontSize
           End If
           StrFont = ReplaceStrSpl(StrFont, 0, stFont, "~")
           StrFont = ReplaceStrSpl(StrFont, 2, cdlFont.FontSize, "~")
           sendVariable2Flash Swf(0), "SetEngUniFont", "true"
           sendVariable2Flash Swf(0), "EngFont", stFont
           sendVariable2Flash Swf(0), "EngSize", cdlFont.FontSize
           sendVariable2Flash Swf(0), "OpenFrame", "true"
           change_font_name_and_size_player False, stFont, cdlFont.FontSize
       End If
       
     ElseIf command = "ChangeUniFont" Then
      On Error GoTo CancelPressed
       stSplit = Split(args, ",")
       With cdlFont
         .FontName = stSplit(0)
         .FontSize = val(stSplit(1))
         .flags = 1
         .ShowFont
         stFont = .FontName
       End With
       If Len(stFont) > 0 Then
           sendVariable2Flash Me.Swf(6), "PassFontUniValue", stFont
           sendVariable2Flash Me.Swf(6), "PassFontUniSize", cdlFont.FontSize
           sendVariable2Flash Me.Swf(6), "GetColorReady", "true"
           EditSetting MainPath & "\Language.xml", 0, "FontUni", stFont
           If ScreenType = "Normal" Or ScreenType = "smallWideScreen" Or ScreenType = "largeWideScreen" Then                  '2006-10-04 Seng
               EditSetting MainPath & "\Language.xml", 0, "FontUniSize", cdlFont.FontSize
            Else
               EditSetting MainPath & "\Language.xml", 0, "FontUniSizeWide", cdlFont.FontSize
            End If
            
           
           StrFont = ReplaceStrSpl(StrFont, 1, stFont, "~")
           StrFont = ReplaceStrSpl(StrFont, 3, cdlFont.FontSize, "~")
           sendVariable2Flash Swf(0), "SetEngUniFont", "true"
           sendVariable2Flash Swf(0), "UniFont", stFont
           sendVariable2Flash Swf(0), "UniSize", cdlFont.FontSize
           sendVariable2Flash Swf(0), "OpenFrame", "true"
           change_font_name_and_size_player True, stFont, cdlFont.FontSize
      End If
CancelPressed:
     ElseIf command = "ChangeBrowse" Then
           ValuePlayer = 0          ' temperary
           stSplit = Split(args, "~")
           EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", stSplit(0)
           StrFont = ReplaceStrSpl(StrFont, 9, stSplit(0), "~")
           If stSplit(0) = "Browse" Then
               EditSetting MainPath & "\Language.xml", 0, "BrowseBy", stSplit(1)
               StrFont = ReplaceStrSpl(StrFont, 6, stSplit(1), "~")
               
               sendVariable2Flash Swf(0), "BrowseBy", stSplit(1)
               sendVariable2Flash Swf(0), "DisplayAlbum", "Browse"
               sendVariable2Flash Swf(0), "ChangeBrowseByOption", "true"
               sendVariable2Flash Swf(0), "OpenFrame", "true"
               
           Else
               sendVariable2Flash Swf(0), "DisplayAlbum", stSplit(0)
               sendVariable2Flash Swf(0), "ChangeBrowseByOption", "true"
               sendVariable2Flash Swf(0), "OpenFrame", "true"
           End If
      ElseIf command = "ChangeSorted" Then
           stSplit = Split(args, "~")
           If stSplit(0) = "Genre" Or stSplit(0) = "Production" Or stSplit(0) = "ReleaseDate" Then
               EditSetting MainSettingXML, 0, "SortedValue", stSplit(1)
               SplitColor = ReplaceStrSpl(SplitColor, 4, stSplit(1), "~")
           ElseIf stSplit(0) = "MyFavAlbum" Then
               EditSetting MainPath & "\Language.xml", 0, "MyFavAlbum", stSplit(1)
               StrFont = ReplaceStrSpl(StrFont, 7, stSplit(1), "~")
           ElseIf stSplit(0) = "MyFavArtist" Then
               EditSetting MainPath & "\Language.xml", 0, "MyFavArtist", stSplit(1)
               StrFont = ReplaceStrSpl(StrFont, 8, stSplit(1), "~")
           ElseIf stSplit(0) = "MyAlbum" Then
               EditSetting MainPath & "\Language.xml", 0, "MyAlbum", stSplit(1)
               StrFont = ReplaceStrSpl(StrFont, 10, stSplit(1), "~")
           End If
           sendVariable2Flash Swf(0), "ChangeSorted", stSplit(1)
           sendVariable2Flash Swf(0), "OpenFame", "true"
            
     ElseIf command = "ChangeMyFavAlbum" Then
            EditSetting MainPath & "\Language.xml", 0, "MyFavAlbum", args
            RefreshSwf
     ElseIf command = "ChangeMyFavArtist" Then
            EditSetting MainPath & "\Language.xml", 0, "MyFavArtist", args
            RefreshSwf
     ElseIf command = "ChangeDisplayAlbum" Then
            EditSetting MainPath & "\Language.xml", 0, "DisplayAlbum", args
            RefreshSwf
            
            
     ElseIf command = "ChangeButtonColor" Then
           Dim ButtonColor As String
           ButtonColor = args
           EditSetting MainSettingXML, 0, "ButtonColor", ButtonColor
           SplitColor = ReplaceStrSpl(SplitColor, 6, ButtonColor, "~")
           
           sendVariable2Flash Swf(0), "SetNewBgColor", "true"
           sendVariable2Flash Swf(0), "SetColorValue", ButtonColor
           sendVariable2Flash Swf(0), "OpenFrame", "true"
           '...color button
           RefreshSwf
         
         
     ElseIf command = "ChangeSelButtonColor" Then
          Dim SelButtonColor As String
          SelButtonColor = args
          EditSetting MainSettingXML, 0, "SelectButton", SelButtonColor
          SplitColor = ReplaceStrSpl(SplitColor, 8, SelButtonColor, "~")
            
          sendVariable2Flash Swf(0), "SetNewBgColor", "true"
          sendVariable2Flash Swf(0), "SelectColorValue", SelButtonColor
          sendVariable2Flash Swf(0), "OpenFrame", "true"
         
         
     ElseIf command = "ChangeButtonAlpha" Then
        EditSetting MainSettingXML, 0, "ButtonAlpha", args
        SplitColor = ReplaceStrSpl(SplitColor, 7, args, "~")
        sendVariable2Flash Swf(0), "SetNewBgColor", "true"
        sendVariable2Flash Swf(0), "ButtonAlpha", args
        sendVariable2Flash Swf(0), "OpenFrame", "true"
        
     ElseIf command = "ChangeSelButtonAlpha" Then
        EditSetting MainSettingXML, 0, "SelectButtonAlpha", args
        SplitColor = ReplaceStrSpl(SplitColor, 9, args, "~")
        sendVariable2Flash Swf(0), "SetNewBgColor", "true"
        sendVariable2Flash Swf(0), "ButtonSelAlpha", args
        sendVariable2Flash Swf(0), "OpenFrame", "true"
      
     ElseIf command = "DefineCDType" Then
        EditSetting MainSettingXML, 0, "CDType", args
        CBrowse.mSelectFlagType = args
         
     ElseIf command = "DisplayKeyBoard" Then
     '       EditSetting MainPath, 0, "Manually", args
     '       RefreshSetting
     '....................Country Action...............
     ElseIf command = "FirstLoad" Then
        s_FitsLoad = args
        EditSetting MainSettingXML, 0, "FirstLoad", args
     ElseIf command = "VLCExtension" Then
        s_DefaultVLCExtension = args
     ElseIf command = "PowerDVDExtension" Then
        s_DefaultPowerDVDExtension = args
     ElseIf command = "DaemonDrive" Then
        s_DriveMount = args

     ElseIf command = "AutoConnect" Then
        b_AutoConnect = args = "true"
        EditSetting MainSettingXML, 0, "AutoConnect", LCase(b_AutoConnect)
     ElseIf command = "LoadPlayMusic" Then
        EditSetting MainSettingXML, 0, "LoadPlayMusic", args
        LoadPlayMusic = args
     ElseIf command = "ShowPlayerOnLoad" Then
        EditSetting MainSettingXML, 0, "ShowPlayerOnLoad", args
        ShowPlayerOnLoad = args
     ElseIf command = "CountryLoad" Then
     EditSetting MainSettingXML, 0, "CountryLoad", args
    '...................Slide Action...................
     ElseIf command = "SlidePath" Then
       On Error GoTo Re11
       Dim newSlidePath As String
       'Set fItem = bf.BrowseForFolder(hwnd, "Browse for SlideShow Path", 0).Items.Item
       newSlidePath = BrowseForFolder(args, hwnd)
       If newSlidePath <> "" Then
         If slideshow_mode = "External" Then
            external_slideshow_path = newSlidePath
            EditRegistrySlide ImageDir, newSlidePath
         Else
            internal_slideshow_path = newSlidePath
            EditSetting MainSettingXML, 1, "ImagePath", newSlidePath
         End If
         
         current_slideshow_path = newSlidePath
         
         sendVariable2Flash Me.Swf(6), "PassSlidePathValue", newSlidePath
         sendVariable2Flash Me.Swf(6), "GetColorReady", "true"
         SplitSly = ReplaceStrSpl(SplitSly, 0, newSlidePath, "~")
         
         If CWinsock.LoggedType = ServerMode Then
             CWinsock.Send2Client WS_COMMAND, 0, "copy_xml_slideshow"
         End If
       End If
        
Re11:
     ElseIf command = "SetSlideMode" Then
         slideshow_mode = args
         EditSetting MainSettingXML, 1, "SlideShowMode", args
         set_slideshow_path
         sendToFlash Swf(6), "setSlidePath", current_slideshow_path
     ElseIf command = "SetSlideShow" Then
       stSplit = Split(args, ",")
       If stSplit(0) = "Yes" Then
         tmrSlideShow.Interval = 1000
         EditRegistrySlide ImageDir, stSplit(1)
       Else
         tmrSlideShow.Interval = 0
       End If
       EditSetting MainSettingXML, 1, "SetSlideShow", stSplit(0)
       If slideshow_mode = "Internal" Then EditSetting MainSettingXML, 1, "ImagePath", stSplit(1)
       SplitSly = ReplaceStrSpl(SplitSly, 1, stSplit(0), "~")
       SplitSly = ReplaceStrSpl(SplitSly, 0, stSplit(1), "~")
     ElseIf command = "ChangeInterval" Then
         SlideSecond = val(args)
         EditSetting MainSettingXML, 1, "Time", args
         
     ElseIf command = "ChangeDelay" Then
         SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "ChangeInterval", val(args) * 1000, REG_DWORD
         EditSetting MainSettingXML, 1, "Delay", args
        
     ElseIf command = "ChangeImageSize" Then
         EditSetting MainSettingXML, 1, "ImageSize", args
         EditRegistrySlide ImageSize, args
         
     ElseIf command = "ChangeStretch" Then
         EditSetting MainSettingXML, 1, "Stretch", args
         EditRegistrySlide Stretch, args
         
     ElseIf command = "ChangeShow" Then
         EditSetting MainSettingXML, 1, "ShowFileName", args
         EditRegistrySlide ShowFilename, args
         
     ElseIf command = "ChangeScroll" Then
         EditSetting MainSettingXML, 1, "Scrolling", args
         EditRegistrySlide Scroll, args
     ElseIf command = "Random" Then
         SlideShowRandom = args
         EditSetting MainSettingXML, 1, "Random", args
     ElseIf command = "ChangeEffect" Then
         EditSetting MainSettingXML, 1, "Effect", args
         EditRegistrySlide Effect, args
     ElseIf command = "SaveUserInfo" Then
         SaveUserInfo args
     ElseIf command = "RemoveUserInfo" Then
         RemoveUserInfo args
         
     ElseIf command = "Picture1" Then
       Dim stPic1 As String
       cdl.filter = "*.jpg|*.jpg"
       
       cdl.filename = ""
       cdl.CancelError = False
       cdl.ShowOpen Me.hwnd
       If cdl.filename <> "" Then
         stPic1 = cdl.filename
         sendVariable2Flash Swf(6), "PassPic1Value", stPic1
         sendVariable2Flash Swf(6), "GetColorReady", "true"
       End If
       
     ElseIf command = "Picture2" Then
       Dim stPic2 As String
       cdl.filename = ""
       cdl.CancelError = False
       cdl.filter = "*.jpg|*.jpg"
       
       
       cdl.ShowOpen Me.hwnd
       If (cdl.filename <> "") Then
         stPic2 = cdl.filename
         sendVariable2Flash Swf(6), "PassPic2Value", stPic2
         sendVariable2Flash Swf(6), "GetColorReady", "true"
       End If
     
     ElseIf command = "ShowRipCD" Then
         frmRip.LoadEncodeCD 6, args
         If frmRip.Visible = False Then
            FrmMain.SetFocus
            Swf(IndexSwf).SetFocus
        End If
     ElseIf command = "ShowPlayer" Then
         ShowOrHidePlayer True
         'FrmMain.SetFocus
     ElseIf command = "Exit" Then
         miniCommand "Stop" & "|:|" & True
         Timer2.Enabled = True
         bExitingProgram = True
     ElseIf command = "Minimize" Then
         FrmMain.WindowState = 1
     ElseIf command = "Tooltip" Then
        b_tooltip = args = "true" 'to make it boolean
        
        EditSetting MainSettingXML, 2, "Tooltip", args
        FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 4, args, "~")
        sendVariable2Flash Swf(0), "SHTT", LCase(b_tooltip)
        sendVariable2Flash Swf(6), "SHTT", LCase(b_tooltip)
        RefreshSwf
     
    ElseIf command = "textScroll" Then
         If args = "true" Then
            b_scroll = True
         Else
            b_scroll = False
         End If
         If IndexSwf <> 0 Then sendToFlash Swf(0), "scroll", CStr(b_scroll)
         sendToFlash Swf(IndexSwf), "scroll", CStr(b_scroll)
         If int_track_count > 0 Then
            get_track_info False
         End If
         EditSetting MainSettingXML, 2, "TextScroll", args
         FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 5, args, "~")
         RefreshSwf
     ElseIf command = "HideMouse" Then
         EditSetting MainSettingXML, 0, "HideMouse", args
         SplitColor = ReplaceStrSpl(SplitColor, 27, args, "~")
         sendVariable2Flash Swf(0), "SetHideMouse", args
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         b_hideMouse = args = "true"
     ElseIf command = "AdsValue" Then
         b_ads = args = "true"
         EditSetting MainSettingXML, 2, "Ads", args
         FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 7, args, "~")
     End If
   Exit Sub
Error:
   WriteEvent "FunOptions", Err.Description, Err.Source
End Sub
Sub splitSetting(Optional index As Integer = -1)
   On Error GoTo Error
    Dim splCol() As String
    Dim splSly() As String
    Dim splPlayer() As String
    Dim splscal() As String
    Dim loc_Volume As Integer
    splCol = Split(SplitColor, "~")
    splSly = Split(SplitSly, "~")
    splPlayer = Split(SplitPlayer, "~")
    
    s_background_color = splCol(0)
    s_button_color = splCol(6)
    s_button_color_alpha = splCol(7)
    s_button_color_selected = splCol(8)
    s_button_color_selected_alpha = splCol(9)
    s_text_color = splCol(10)
    s_color_bar = splCol(23)
    
    If splSly(1) = "No" Then
        b_slideshow = False
    Else
        b_slideshow = True
    End If
    If val(splPlayer(0)) >= 0 Then loc_Volume = splPlayer(0) Else loc_Volume = 0
    If b_mute = False Then
         'beside option page
        If index <> 6 Then WaveVolume = loc_Volume
    End If
    If splPlayer(1) = "Yes" Then
        b_loop = True
    Else
        b_loop = False
    End If
    If splPlayer(2) = "Yes" Then
        b_shuffle = True
    Else
        b_shuffle = False
    End If
    s_display_type = splPlayer(3)
    If splPlayer(4) = "true" Then
        b_tooltip = True
    Else
        b_tooltip = False
    End If
    If splPlayer(5) = "true" Then
        b_scroll = True
        
    Else
        b_scroll = False
        
    End If
    
    If splPlayer(6) = "true" Then
        b_micro = True
    Else
        b_micro = False
    End If
    If splPlayer(7) = "true" Then
        b_ads = False
    Else
            b_ads = False
    End If
    splscal = Split(splPlayer(8), "x")
    i_scale_by_width = CInt(splscal(0))
    i_scale_by_height = CInt(splscal(1))
   Exit Sub
Error:
   WriteEvent "splitSetting", Err.Description, Err.Source
End Sub

Private Sub txtSearchUnicode_KeyPress(KeyAscii As Long)
   If KeyAscii = 13 Then KeyAscii = 0
End Sub

Private Sub txtSearchUnicode_KillFocus()
   On Error GoTo Error
   b_TextBoxGetFocus = False        'there is focus
   Swf(IndexSwf).SetFocus
   'clsKeyboard.SetKeyBoardLanguage "English"
   'TextBoxScale txtSearchUnicode, formWidth, formHeight, 382, 65, 76, 295
   'txtSearchUnicode.Visible = False
   Exit Sub
Error:
   'WriteEvent "txtSearchUnicode", Err.Description, Err.Source
End Sub
Public Sub addTrackToPlayer(str As String)
   On Error GoTo Error
   Call SetPlayerTrackInfo(str, int_track_count - 1)
   Exit Sub
Error:
   WriteEvent "AddTrackToPlayer", Err.Description, Err.Source
End Sub
Sub SetPlayerTrackInfo(str As String, index As Long)
   On Error GoTo Error
    Dim strSplit() As String, stAlbum() As String
    Dim stTrack() As String, stArtist() As String
    Dim strInfo() As String, stFont() As String
    Dim stSize() As String
    Dim stPath As String
    Dim stLanPath As String
    Dim stExternal As Integer
    
    strSplit = Split(str, StWaveSpl)
    strInfo = Split(strSplit(1), "%%")
    stPath = strSplit(0)
    stTrack = Split(strInfo(0), "||")
    stArtist = Split(strInfo(2), "||")
    stAlbum = Split(strInfo(1), "||")
    stFont = Split(strSplit(2), "||")
    stSize = Split(strSplit(3), "||")
    stLanPath = strSplit(7)
    
    If strSplit(8) = 0 Then
        'Internal Track
        stExternal = 0
'        StrPathPic = fso.BuildPath(SlyVariable("<" & stLanPath & "_img>"), PlayTrackInfo(Index).picPath & "\" & stAlbum(0)) & "\folder.jpg"
        StrPathPic = dirImage(StrPathPic)
    Else
        'External track
        stExternal = strSplit(8)
        StrPathPic = getImageExternal(strSplit(9))       'user id for external path
    End If
    
   'If Index >= int_track_count Then
   'If Index >= int_track_count Then ReDim Preserve Infos(Index)
   ReDim Preserve Infos(int_track_count - 1)
   
   If stLanPath = "English" Then
        Infos(index).TrackTitle.Eng = stTrack(0)
        Infos(index).TrackTitle.Uni = stTrack(0)
        Infos(index).trackArtist.Eng = stArtist(0)
        Infos(index).trackArtist.Uni = stArtist(0)
        Infos(index).trackAlbum.Eng = stAlbum(0)
        Infos(index).trackAlbum.Uni = stAlbum(0)
    Else
        Infos(index).TrackTitle.Eng = stTrack(0)
        Infos(index).TrackTitle.Uni = stTrack(1)
        Infos(index).trackArtist.Eng = stArtist(0)
        Infos(index).trackArtist.Uni = stArtist(1)
        Infos(index).trackAlbum.Eng = stAlbum(0)
        Infos(index).trackAlbum.Uni = stAlbum(1)
    End If
    Infos(index).TrackPath = stPath
    Infos(index).trackFontName.Eng = stFont(0)
    Infos(index).trackFontName.Uni = stFont(1)
    Infos(index).trackFontsize.Eng = stSize(0)
    Infos(index).trackFontsize.Uni = stSize(1)
    Infos(index).trackCaptionTitle = strSplit(4)
    Infos(index).trackCaptionArtist = strSplit(5)
    Infos(index).trackCaptionAlbum = strSplit(6)
    Infos(index).TrackLan = stLanPath
    Infos(index).trackImagePath = StrPathPic
    Infos(index).trackExternal = (stExternal <> 0)
    Infos(index).TrackID = strSplit(9)
    Infos(index).trackAlbumID = strSplit(10)
    get_next_previouse_index
   Exit Sub
Error:
   WriteEvent "SetPlayerTrackInfo", Err.Description, Err.Source
End Sub

Function getImageExternal(strPath As String) As String
   On Error GoTo Error
    Dim arr_path() As String
    Dim iiii As Integer
    Dim newName As String
    arr_path = Split(strPath, "\")
    For iiii = 0 To UBound(arr_path) - 1
        newName = newName & "\" & arr_path(iiii)
    Next iiii
    getImageExternal = dirImage(mID(newName, 2) & "\Folder.jpg")
   Exit Function
Error:
   WriteEvent "getImageExternal", Err.Description, Err.Source
End Function


' set track info
Sub setTrackInfo(strTrackPath As String, strTrack As String, strTrackUnicode As String, strArtist As String, strArtistUnicode As String, strAlbum As String, strAlbumUnicode As String, strFontUni As String, strFontEng As String, strFontSizeUni As String, strFontSizeEng As String, strCap_TrackTitle As String, strCap_Artist As String, strCap_Album As String, strLan_Path As String, strExternal As Integer, strImgPath As String, strTrackID As String, strAlbumID As String)
   On Error GoTo Error
    ReDim Preserve Infos(int_track_count)
    Infos(int_track_count).TrackPath = strTrackPath
    If strLan_Path = "English" Then
        Infos(int_track_count).TrackTitle.Eng = strTrack
        Infos(int_track_count).TrackTitle.Uni = strTrack
        Infos(int_track_count).trackArtist.Eng = strArtist
        Infos(int_track_count).trackArtist.Uni = strArtist
        Infos(int_track_count).trackAlbum.Eng = strAlbum
        Infos(int_track_count).trackAlbum.Uni = strAlbum
    Else
        Infos(int_track_count).TrackTitle.Eng = strTrack
        Infos(int_track_count).TrackTitle.Uni = strTrackUnicode
        Infos(int_track_count).trackArtist.Eng = strArtist
        Infos(int_track_count).trackArtist.Uni = strArtistUnicode
        Infos(int_track_count).trackAlbum.Eng = strAlbum
        Infos(int_track_count).trackAlbum.Uni = strAlbumUnicode
    End If
    
    Infos(int_track_count).trackFontName.Eng = strFontEng
    Infos(int_track_count).trackFontName.Uni = strFontUni
    Infos(int_track_count).trackFontsize.Eng = strFontSizeEng
    Infos(int_track_count).trackFontsize.Uni = strFontSizeUni
    Infos(int_track_count).trackCaptionTitle = strCap_TrackTitle
    Infos(int_track_count).trackCaptionArtist = strCap_Artist
    Infos(int_track_count).trackCaptionAlbum = strCap_Album
    Infos(int_track_count).TrackLan = strLan_Path
    Infos(int_track_count).trackImagePath = strImgPath
    If strExternal = 0 Then
        Infos(int_track_count).trackExternal = False
    Else
        Infos(int_track_count).trackExternal = True
    End If
    Infos(int_track_count).TrackID = strTrackID
    Infos(int_track_count).trackAlbumID = strAlbumID
    
    get_next_previouse_index
   Exit Sub
Error:
   WriteEvent "setTrackInfo", Err.Description, Err.Source
End Sub

Sub setToWinamp(index2Play As Long)
On Error GoTo ErrorBound
   'Debug.Print
   Dim stringFilePath As String
   If int_track_count > 0 And int_current_index < int_track_count Then
      CPlayer.Stops
      MsgBox "setToWinamp"
'''      MediaPlayer.ClearPlayList
'''      stringFilePath = Infos(index2Play).TrackPath
'''      MediaPlayer.AddToPlaylist2 stringFilePath
'''      MediaPlayer.Play
   End If
ErrorBound:
End Sub
' function for dir file image
Function dirImage(str_path As String) As String
   On Error GoTo Error
    If isFileExist(str_path) Then
        dirImage = str_path
    Else
        dirImage = "None"
    End If
   Exit Function
Error:
   WriteEvent "dirImage", Err.Description, Err.Source
End Function

' Change Position track
'''Sub ChangeIndexPosition()
'''  Dim j As Integer
'''  For j = 0 To CWmp.currentPlaylist.count - 1
'''    CWmp.currentPlaylist.Item(j).setItemInfo "track", j + 1
'''  Next j
'''End Sub

' cut path with file media and replace to folder.jpg and dir file image
Function imagePath_CurrentTrack(strPath As String) As String
   On Error GoTo Error
    Dim Ar() As String
    Dim j As Integer
    Dim strImg As String
    Ar = Split(strPath, "\")
    For j = LBound(Ar) To UBound(Ar) - 1
        strImg = strImg + "\" + Ar(j)
    Next j
    strImg = right(strImg, Len(strImg) - 1) & "\folder.jpg"
    imagePath_CurrentTrack = dirImage(strImg)
   Exit Function
Error:
   WriteEvent "imagePath_CurrentTrack", Err.Description, Err.Source
End Function

' resize visualzation when click fullscreen
Sub Resize_Visualization(formWidth As Long, formHeight As Long)
   On Error GoTo Error
    Dim tmpPic As Boolean
    Dim picLeft As Long, picWidth As Long
    Dim picTop As Long, picHeight As Long
    
    tmpPic = picwmp.Visible
    picwmp.Visible = False
    If ScreenType = "Normal" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 40) / (800)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 130.1)) / (600) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 420) / (800)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 240) / (600)) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "wideScreen" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 100.5) / (1280)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 128.6)) / (720) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 630) / (1280)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 320) / (720)) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "mediumWideScreen" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 105) / (1280)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 132)) / (768) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 640) / (1280)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 370) / (768)) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "mediumLargeWideScreen" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 105) / (1280)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 150) / (800)) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 640) / (1280)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 340) / (800)) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "smallWideScreen" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 105) / (1024)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 112.5) / (600)) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 420) / (1024)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 265) / (600)) * Screen.TwipsPerPixelY
    ElseIf ScreenType = "largeWideScreen" Then
        picLeft = ((formWidth / Screen.TwipsPerPixelX * 45) / (800)) * Screen.TwipsPerPixelX
        picTop = ((formHeight / Screen.TwipsPerPixelY * 145) / (640)) * Screen.TwipsPerPixelY
        picWidth = ((formWidth / Screen.TwipsPerPixelX * 420) / (800)) * Screen.TwipsPerPixelX
        picHeight = ((formHeight / Screen.TwipsPerPixelY * 240) / (640)) * Screen.TwipsPerPixelY
    End If
    
    picwmp.Move picLeft, picTop, picWidth, picHeight
    'picMovieBackground.Move -ScaleX(3, vbPixels, vbTwips), ScaleY(3, vbPixels, vbTwips), picWidth, picHeight
    If run_FormVideoLoaded = False Then
      picMovieBackground.Move -ScaleX(3, vbPixels, vbTwips), -ScaleY(3, vbPixels, vbTwips), picWidth + Screen.TwipsPerPixelX * 7, picHeight + Screen.TwipsPerPixelY * 7
'''      CWmp.Move 0, 0, picWidth, picHeight
      'CPlayer.Move 0, 0, picWidth, picHeight
      'Debug.Print "Resize_Visualization"
    End If
    picwmp.Visible = tmpPic
    storeOriginalLength
    
'''    If playMusicWith = Winamp And s_display_type = "Visual" And picwmp.Visible = True Then
'''        MediaPlayer.ScaleVisualization
'''    End If
    
    closeScreenPlayer       '20050812
   Exit Sub
Error:
   WriteEvent "Resize_Visualization", Err.Description, Err.Source
End Sub
' resize visualzation in normal page
Sub resize_visualization_normal()
   On Error GoTo Error
    Dim picLeft As Long, picWidth As Long
    Dim picTop As Long, picHeight As Long
    If ScreenType = "Normal" Then   'NS
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 355) / 800) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 159) / 600) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
        
    ElseIf ScreenType = "wideScreen" Then    'WS
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 582) / 1280) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 243.3) / 720) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
        
    ElseIf ScreenType = "mediumWideScreen" Then    'WSM
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 582) / 1280) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 243.3) / 768) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
    ElseIf ScreenType = "mediumLargeWideScreen" Then  'WSH
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 582) / 1280) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 243.3) / 800) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
    ElseIf ScreenType = "smallWideScreen" Then  'WSS
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 462.3) / 1024) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 206.5) / 600) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
        
    ElseIf ScreenType = "largeWideScreen" Then  'WSL
        picWidth = (((Swf(IndexSwf).Width / Screen.TwipsPerPixelX) * 362.9) / 800) * Screen.TwipsPerPixelX
        picHeight = (((Swf(IndexSwf).Height / Screen.TwipsPerPixelY) * 169.7) / 640) * Screen.TwipsPerPixelY
        picLeft = Swf(IndexSwf).Width - picWidth - 30
        picTop = Swf(IndexSwf).Height - picHeight - 30
    End If
   picwmp.Move picLeft, picTop, picWidth, picHeight
'''   If playMusicWith = WindowMedia Then
'''      picMovieBackground.Move -ScaleX(0, vbPixels, vbTwips), -ScaleY(0, vbPixels, vbTwips), picWidth + Screen.TwipsPerPixelX * 7, picHeight + Screen.TwipsPerPixelY * 7
'''   Else
'''      picMovieBackground.Move -ScaleX(3, vbPixels, vbTwips), -ScaleY(3, vbPixels, vbTwips), picWidth + Screen.TwipsPerPixelX * 7, picHeight + Screen.TwipsPerPixelY * 7
'''   End If
   picMovieBackground.Move -ScaleX(0, vbPixels, vbTwips), -ScaleY(0, vbPixels, vbTwips), picWidth + Screen.TwipsPerPixelX * 7, picHeight + Screen.TwipsPerPixelY * 7
   If run_FormVideoLoaded = False Then

      'CPlayer.Move picMovieBackground.left, picMovieBackground.top, picMovieBackground.Width, picMovieBackground.Height
   End If
   bool_full_vis = False
   Exit Sub
Error:
   WriteEvent "resize_visualization_normal", Err.Description, Err.Source
End Sub


Public Sub setSlideShows()
   On Error GoTo Error
    interValCount = 0
    Dim args As String
    If b_slideshow = False Then
        tmrSlideShow.Interval = 1000
        b_slideshow = True
        args = "Yes"
    Else
        tmrSlideShow.Interval = 0
        b_slideshow = False
        args = "No"
    End If
            
    If str_swfNames = "Fullscreen" Then oneByOneTheme SWF_FMA(1), "slideShow", CStr(b_slideshow)
    If str_swfNames = "Micro" Then sendVariable2Flash SWF_FMA(2), "slideShow", CStr(b_slideshow)
    
    EditSetting MainSettingXML, 1, "SetSlideShow", args
    SplitSly = ReplaceStrSpl(FrmMain.SplitSly, 1, args, "~")
   Exit Sub
Error:
   WriteEvent "setSlideShows", Err.Description, Err.Source
End Sub


' sub function show and hide player
Sub ShowOrHidePlayer(TF As Boolean)
    'ResizePlayer
   On Error GoTo Error
   If (CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded)) Then
      picwmp.Visible = False
      picMovieBackground.Visible = False
      show_hide_player = TF
      If TF Then
         LoadSwfMiniControl
      Else
         UnloadSwfMiniControl
      End If
   Else
      If TF = True Then
         tmr_hide_cmdFull.Enabled = True
         show_hide_player = True
         DisplayMini = 1
         If s_display_type = "Visual" Then
             picwmp.Visible = IIf(CWinsock.LoggedType <> remoteControl, TF, False)
         Else
             'picwmp.Visible = False
             'picMovieBackground.Visible = False
         End If
         picwmp.ZOrder 0
         'If b_play = True And playMusicWith = Winamp And picwmp.Visible = True Then MediaPlayer.StartVisualization
         display_seek_in_player
      Else
         tmr_hide_cmdFull.Enabled = False
         show_hide_player = False
         UnloadSwfMiniControl
         DisplayMini = 0
         picwmp.Visible = TF
         picwmp.Visible = TF
      ''''''''''2005/08/24 : Muny
      End If
      resize_visualization_normal            '2006-08-12
      If Swf(IndexSwf).Visible Then Swf(IndexSwf).SetFocus
      If IsRegistered = False Then
         On Error Resume Next       'Don't coz error for the next line
         If Swf(12).Visible = True Then Swf(12).ZOrder 0
         On Error GoTo Error
      End If
   End If
   Exit Sub
Error:
   WriteEvent "ShowOrHidePlayer", Err.Description, Err.Source
End Sub

' for show and hide next and previouse image
' clear track info
Sub clearInfoTrack()
   On Error GoTo Error
    If IndexSwf = 0 Or IndexSwf = 4 Then
        sendToFlash Swf(0), "ClearInfo", True
        If IndexSwf = 4 Then sendToFlash Swf(4), "ClearInfo", True
        strNext = ""
        strImgNext = ""
        strCurrent = ""
        strImgCurrent = ""
        strPrevious = ""
        strImgPrevious = ""
    End If
   Exit Sub
Error:
   WriteEvent "clearInfoTrack", Err.Description, Err.Source
End Sub

' change language
Sub setHideMouse(str As String)
   On Error GoTo Error
    EditSetting MainSettingXML, 0, "HideMouse", str
    SplitColor = ReplaceStrSpl(SplitColor, 27, str, "~")
    sendVariable2Flash Swf(0), "SetHideMouse", str
    sendVariable2Flash Swf(0), "OpenFrame", "true"
    b_hideMouse = str = "true"
   Exit Sub
Error:
   WriteEvent "setHideMouse", Err.Description, Err.Source
End Sub


Sub change_font_name_and_size_player(Uni As Boolean, strFontName As String, strFontSize As String)
   On Error GoTo Error
    Dim iiii As Integer
    If int_track_count > 0 Then
        For iiii = 0 To UBound(Infos)
            If Uni = True Then
                If currentCountry = Infos(iiii).TrackLan Then
                     Infos(iiii).trackFontName.Uni = strFontName
                     Infos(iiii).trackFontsize.Uni = strFontSize
                End If
            Else
                If currentCountry = Infos(iiii).TrackLan Then
                     Infos(iiii).trackFontName.Eng = strFontName
                     Infos(iiii).trackFontsize.Eng = strFontSize
                End If
            End If
        Next iiii
        get_track_info False
    End If
   Exit Sub
Error:
   WriteEvent "change_font_name_and_size_player", Err.Description, Err.Source
End Sub
Function GetNewestReleaseDate(str As String) As Boolean
   On Error GoTo Error
   Dim max As Integer
   Dim i As Integer
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load str
   Set xmlPlaylistRoot = xmlPlaylist.firstChild
   For i = 0 To xmlPlaylistRoot.childNodes.Length - 1
      If max < val(xmlPlaylistRoot.childNodes(i).Attributes(0).Text) Then
         max = val(xmlPlaylistRoot.childNodes(i).Attributes(0).Text)
      End If
   Next
   If max < CBrowse.GetNewestYear Then
      GetNewestReleaseDate = True
   End If
   Exit Function
Error:
   WriteEvent "GetNewestReleaseDate", Err.Description, Err.Source
End Function

Private Function getScreenType(sx As Long, sY As Long, setupType As String) As String
   On Error GoTo Error
   'EDIT:2006-08-01 Seng
   If setupType = "Normal" Then
     getScreenType = "Normal"
   Else
     getScreenType = ChooseScreen(sx / sY, setupType)
   End If
   Exit Function
Error:
   WriteEvent "getScreenType", Err.Description, Err.Source
End Function


'==============================================
'function for combin mini player

Sub DisplayInfo2Players()
   repeat_shuffle
   get_track_info False
End Sub

Sub setMiniPlayer(b_value As Boolean, Optional ind As Integer)
   On Error GoTo Error
    If b_value = True Then
        'sendToFlash swf(ind), "karaoke_voice", CStr(b_karaoke_voice)
        sendToFlash Swf(ind), "Shuffle", CStr(b_shuffle)
        sendToFlash Swf(ind), "Repeat", CStr(b_loop)
        sendToFlash Swf(ind), "Mute", CStr(b_mute)
        sendToFlash Swf(ind), "Volume", CStr(WaveVolume)
        sendToFlash Swf(ind), "Register", CStr(b_reg)
        sendToFlash Swf(ind), "scroll", CStr(b_scroll)
        sendToFlash Swf(ind), "LabelNext", label_next_track(CountryPath, Language, ScreenType)
        sendToFlash Swf(ind), "Play", CStr(b_play) '& "|%|" & CInt(false
        If s_display_type = "Image" Then
            picwmp.Visible = False
            CPlayer.UiMode = "Invisible"
        Else
            CPlayer.UiMode = "None"
            picwmp.ZOrder 0
        End If
    Else
        picwmp.Visible = False
    End If
   Exit Sub
Error:
   WriteEvent "setMiniPlayer", Err.Description, Err.Source
End Sub

Sub sendCommand2Player(command As String, val As String)
    If IndexSwf = 0 Or IndexSwf = 4 Then
        sendToFlash Swf(IndexSwf), command, val
        sendToFlash Swf(0), command, val
    ElseIf str_swfNames = "Fullscreen" Then
        sendToFlash Swf(IndexSwf), command, val
    ElseIf str_swfNames = "Micro" Then
        sendToFlash Swf(IndexSwf), command, val
    End If
End Sub

Sub PurchaseTrack(args As String)
      Dim url As String
      url = "http://musicdownloads.walmart.com/catalog/servlet/CartServlet?catitemid=" & args
      ShellExecute hwnd, "Open", url, "", "", 1
End Sub
Sub ViewCart(ByVal index As String)
   Dim url As String
   If index = "0" Then
      url = "http://www.amazon.com/gp/cart/view.html"
   ElseIf index = "1" Then
      url = "http://www.buy.com/basket/basket.asp"
   ElseIf index = "2" Then
      url = "http://www.walmart.com/cart.gsp"
   ElseIf index = "3" Then
      url = "http://www.walmart.com/music_downloads/cart.gsp"
   End If
   ShellExecute hwnd, "Open", url, "", "", 1
End Sub
Function PurchaseCD(args As String)
   On Error GoTo Error
    Dim url As String
    Dim ASIN As String
    Dim spl() As String
    Dim index As String
    Dim AlbumLanguage As String
    spl = Split(args, "~")
    AlbumLanguage = spl(1)
    If AlbumLanguage = "English" Then
            index = spl(2)
            If index = "0" Then
               ASIN = GetAlbumField(val(spl(0)), "ASIN", AlbumLanguage)
               If ASIN <> "" Then
                  url = "http://www.amazon.com/exec/obidos/ASIN/" & ASIN & Change("/flrzEd3tEn-GY", False)
               End If
            ElseIf index = "1" Then
               ASIN = GetAlbumField(val(spl(0)), "BuyCom", AlbumLanguage)
               If ASIN <> "" Then
                  url = "http://click.linksynergy.com/fs-bin/click?id=lKNL1t4AlxE&offerid=56785." & ASIN & "&type=2&subid=0"
               End If
            ElseIf index = "2" Then
               ASIN = GetAlbumField(val(spl(0)), "WalmartCom", AlbumLanguage)
               If ASIN <> "" Then
                  url = "http://click.linksynergy.com/fs-bin/click?id=lKNL1t4AlxE&offerid=40579." & ASIN & "&type=2&subid=0"
               End If
            ElseIf index = "3" Then
               ASIN = GetAlbumField(val(spl(0)), "Walmart_DD", AlbumLanguage)
               If ASIN <> "" Then
                  url = "http://musicdownloads.walmart.com/catalog/servlet/CartServlet?catitemid=" & ASIN
               End If
            End If
        
    Else
        ASIN = GetAlbumField(spl(0), , AlbumLanguage)
        If ASIN <> "" Then
            If AlbumLanguage = "Chinese" Or AlbumLanguage = "Korean" Or AlbumLanguage = "Japanese" Then
               url = "http://us.yesasia.com/assocred.asp?" & Change("9kwAP8Lp", False) & "+http://us.yesasia.com/en/PrdDept.aspx/pid-" & ASIN
            ElseIf AlbumLanguage = "Thai" Then
               url = "http://www.ethaicd.com/show.php?pid=" & ASIN & Change("&HffC=2NYy", False)
            ElseIf AlbumLanguage = "Vietnamese" Then
               url = "http://www.saigoncd.com/ci/ProductDetails.cfm?ProductID=" & ASIN
            End If
        End If
    End If
    If url <> "" Then
        If str_swfNames = "Micro" Then
            sendToFlash frmPopup.Swf(1), "linkURL", url
        Else
            ShellExecute hwnd, "Open", url, "", "", 1
        End If
    End If
   Exit Function
Error:
   WriteEvent "PurchaseCD", Err.Description, Err.Source
End Function
Function GetAttSetting(ByVal index As Integer, ByVal Name As String) As String
   On Error Resume Next
   Dim t As IXMLDOMElement
   Dim doc As DOMDocument
   Set doc = New DOMDocument
   doc.Load MainSettingXML
   Set t = doc.childNodes(0).childNodes(index)
   GetAttSetting = t.getAttribute(Name)
End Function
Sub CheckTrackRatingInXmlPlaylist(path)
   'EDIT:2006-08-15
   On Error GoTo Error
   Dim i As Integer
   Dim ID As String
   Dim namePath As String
   Dim t As IXMLDOMElement
   Dim t1 As IXMLDOMElement
   Dim doc As DOMDocument
   Set doc = New DOMDocument
   Dim albumID As String
   Dim comName As String
   Dim TrackLan As String
   Dim TrackPath As String
   Dim setAvailable As Long
   Dim boolTrackAvailable As Boolean
   doc.Load path
   Set t = doc.childNodes(0)
   
   For i = 0 To t.childNodes.Length - 1
      Set t1 = doc.childNodes(0).childNodes(i)
      ID = t1.getAttribute("TrackID")
      comName = t1.getAttribute("ComName")
      TrackLan = t1.getAttribute("language")
      albumID = t1.getAttribute("AlbumID")
      setAvailable = 0
      If t1.getAttribute("Mode") = "Internal" Then       'Interla
         t1.setAttribute "Rating", GetTrackField(ID, "Rating", TrackLan)
         TrackPath = getMoviePathAndSample(ID & "~" & albumID & "~0~" & TrackLan & "~0", comName)
         If isFileExist(TrackPath) Then
            If trackAvailable(TrackLan, ID) = 2 Then
               setAvailable = 2
            Else
               setAvailable = 1
            End If
         End If
      Else
         If isFileExist(ID) Then
            setAvailable = 1
         Else
            TrackPath = GetExternalTrackPath(comName, ID, boolTrackAvailable)
            If isFileExist(TrackPath) And boolTrackAvailable Then
               setAvailable = 2
            Else
               If CWinsock.getIndexServer(comName) > 0 Then setAvailable = 3
            End If
            
         End If
      End If
      t1.setAttribute "TrackAva", setAvailable
      
   Next
   doc.Save path
   sendVariable2Flash Swf(3), "CheckTrackRating", "true"
   sendVariable2Flash Swf(3), "OpenFrame", "true"
   Exit Sub
Error:
   WriteEvent "CheckTrackRatingInXmlPlaylist", Err.Description, Err.Source
End Sub

Private Sub WindowsMediaPlayer1_OpenStateChange(ByVal NewState As Long)

End Sub

Private Sub wmp_Click(ByVal nButton As Integer, ByVal nShiftState As Integer, ByVal fX As Long, ByVal fY As Long)
   If nButton = 2 Then
      rightClickPicWMP
   End If
End Sub

Private Sub wmp_MediaChange(ByVal item As Object)
   b_addPlayCount = False
End Sub
Sub CheckTrackAvaible(ByVal curIndex As Integer)
   On Error GoTo Error
   Dim strPath As String
   Dim count As Integer
start:
   If (count >= int_track_count) Then Exit Sub
   If curIndex = int_track_count Then
      curIndex = 0
   End If
   If (val(PlayTrackInfo(curIndex).TrackAva) = 0 And PlayTrackInfo(curIndex).Mode = "Internal") Then
      strPath = GetTrackPath(val(Infos(curIndex).TrackID), val(Infos(curIndex).trackAlbumID), PlayTrackInfo(curIndex).Language)
      If (strPath <> "") Then
         PlayTrackInfo(curIndex).TrackAva = "1"
         If IndexSwf = 4 Then
            sendVariable2Flash Swf(4), "RefreshAvaTrack", curIndex
            sendVariable2Flash Swf(4), "OpenFrame", "true"
         End If
         Exit Sub
      End If
   Else
      Exit Sub
   End If
   curIndex = curIndex + 1
   count = count + 1
   GoTo start
   Exit Sub
Error:
   WriteEvent "CheckTrackAvaible", Err.Description, Err.Source
End Sub
Public Sub refreshPlaylistPlayer(Optional refresh As Boolean = False)
   On Error GoTo Error
    If int_track_count > 0 Then
        On Error Resume Next
        
        Static index As Integer
        Static f As Boolean
        Dim i As Integer
        Dim strPath As String
        '.......Refresh One track..........
        If refresh = True Then
            If f = True Then
                f = False
                i = index
                If (PlayTrackInfo(i).TrackAva = 0 And PlayTrackInfo(i).Mode = "Internal") Then
                    strPath = GetTrackPath(val(Infos(i).TrackID), val(Infos(i).trackAlbumID), PlayTrackInfo(i).Language)
                    If (strPath <> "") Then
                        PlayTrackInfo(i).TrackAva = "1"
                        If IndexSwf = 4 Then
                            sendVariable2Flash Swf(4), "RefreshAvaTrack", i
                            sendVariable2Flash Swf(4), "OpenFrame", "true"
                        End If
                        '................
                        If int_track_count > 0 Then
'''                               CWmp.currentPlaylist.moveItem int_track_count - 1, i
'''                               CWmp.currentPlaylist.removeItem CWmp.currentPlaylist.Item(i + 1)
'''                               ChangeIndexPosition
                        Else
'''                               CWmp.currentPlaylist.Clear
'''                               CWmp.controls.Play
                               CPlayer.ClearPlayList
                               CPlayer.Play
                        End If
                    End If
                End If
            End If
            Exit Sub
        End If
        'refresh all track.............
        For i = 0 To UBound(PlayTrackInfo)
             If i <> int_current_index Then
                    If (PlayTrackInfo(i).TrackAva = 0 And PlayTrackInfo(i).Mode = "Internal") Then
                        strPath = GetTrackPath(val(Infos(i).TrackID), val(Infos(i).trackAlbumID), PlayTrackInfo(i).Language)
                        If (strPath <> "") Then
                            PlayTrackInfo(i).TrackAva = "1"
                            If IndexSwf = 4 Then
                                sendVariable2Flash Swf(4), "RefreshAvaTrack", i
                                sendVariable2Flash Swf(4), "OpenFrame", "true"
                            End If
                            '................
'                                setToWindowMendia strPath, int_track_count
'''                                CWmp.currentPlaylist.moveItem int_track_count - 1, i
'''                                CWmp.currentPlaylist.removeItem CWmp.currentPlaylist.Item(i + 1)
'''                                ChangeIndexPosition
                            
                        End If
                    End If
             Else
                index = i
                f = True
             End If
        Next
    End If
   Exit Sub
Error:
   WriteEvent "refreshPlaylistPlayer", Err.Description, Err.Source
End Sub

Public Sub SetCoverArtType(sString As String)
   Dim sSpl() As String
   sSpl = Split(sString, "%~%")
   If val(sSpl(1)) > 0 Then
      SetAlbumField val(sSpl(1)), "CoverType", sSpl(0), sSpl(2)
   End If

End Sub
Sub SearchPathImages(args As String)
   'On Error GoTo Error
   Dim stSpl() As String
   Dim iAlbumID As Long
   Dim iCoverArtType As EnumCovertArtType
   Dim sCoverName As String
   Dim str1 As String, str2 As String, Name As String, index As String, path As String
   
   '..........Pass DVDsIcon and ArtistIcon
   stSpl = Split(args, "%~%")
   
   'If Not isFileExist(stSpl(0)) Then                          'If Dir(stSpl(0)) = "" Then
      '...........DownLoad CoverArt
      
      If stSpl(1) = "Back" Then
         sCoverName = BackCoverName
      Else
         iAlbumID = val(stSpl(3))
         If iAlbumID > 0 Then
            iCoverArtType = GetAlbumField(iAlbumID, "CoverType", stSpl(4))
            If iCoverArtType = CoverBlurary Then
               sCoverName = BlurayCoverName
            ElseIf iCoverArtType = CoverHDDVD Then
               sCoverName = HDDVDCoverName
            Else
               sCoverName = DVDCoverName
            End If
         Else
            sCoverName = DVDCoverName
         End If
      End If
      stSpl(0) = fso.GetParentFolderName(stSpl(0)) & "\" & sCoverName
      If isFileExist(stSpl(0)) Then
         PutImage stSpl(1), stSpl(2), stSpl(0), ""
      Else
         PutImage stSpl(1), stSpl(2), stSpl(0), sCoverName
         If UBound(stSpl) > 2 And iAlbumID > 0 Then
            If (NoInternetConnected = 0 Or CWinsock.LoggedType <> ServerMode) And AutoDownload = 1 Then
               If stSpl(1) = "Artist" Then
                  str1 = stSpl(0) & "%~%" & stSpl(1) & "%~%" & stSpl(2)
                  str2 = stSpl(0) & "%~%" & stSpl(3) & "%~%" & stSpl(4)
                  Name = stSpl(1)
                  index = stSpl(2)
                  path = stSpl(0)
                  StartDownload str1, str2, Name, index, path
               ElseIf stSpl(1) = "Chapter" Then
               Else
                  str1 = stSpl(0) & "%~%" & stSpl(1) & "%~%" & stSpl(2)
                  str2 = stSpl(0) & "%~%" & stSpl(3) & "%~%" & stSpl(4)
                  Name = stSpl(1)
                  index = stSpl(2)
                  path = stSpl(0)
                  StartDownload str1, str2, Name, index, path
               End If
            End If
            
         End If
      End If
         
   'End If
   Exit Sub
Error:
   WriteEvent "SearchPathImages", Err.Description, Err.Source
End Sub
Sub StartDownload(Optional str1 As String, Optional str2 As String, Optional Name As String, Optional index As String, Optional path As String)
   On Error GoTo Error
   Dim newdownloadData As New cFile
   With newdownloadData
      .data1 = str1
      .data2 = str2
      .IndexLoadSwf = IndexSwf
      
      If Name = "Artist" Then
         .DownloadType = DL_ARTIST '      .Name = Name
      ElseIf Name = "Album" Then
         .DownloadType = DL_ALBUM
      ElseIf Name = "Back" Then
         .DownloadType = DL_BACK
      Else
         .DownloadType = DL_MEDIA
      End If
   End With
   
  Set newdownloadData = getDownloadURL(newdownloadData)
  If newdownloadData.url <> "" Then cDownload.AddDownloadItem newdownloadData


'''   DownloadQue.Add newdownloadData
'''   If Not Downloading Then
'''      Completing = False
'''      If cDownload.DownloadItemCount > 0 Then Completing = True
'''      'call by tmrDownload_Timer
'''   End If
   Exit Sub
Error:
   WriteEvent "StartDownload", Err.Description, Err.Source
End Sub
Function PutImage(ByVal Name As String, ByVal index As String, folderPath As String, DVDCover As String) As Boolean
   On Error GoTo Error
   Dim path As String
   If DVDCover = "" Then            'Found
      path = folderPath
   Else
      If Name = "Album" Then
         path = App.path & "\sly\CDIcon.sly"
      ElseIf Name = "Track" Then
         path = App.path & "\sly\CDIcon.sly"
      ElseIf Name = "Chapter" Then
         'if there is no chapter file then use the album folder.jpg instead else use cdicon.sly
         path = fso.BuildPath(fso.GetParentFolderName(folderPath), DVDCover)
         If Not isFileExist(path) Then
            path = App.path & "\sly\CDIcon.sly"
         End If
      ElseIf Name = "Back" Then
         path = App.path & "\sly\CDIcon.sly"
      Else
          path = App.path & "\sly\ArtistIcon.sly"
      End If
   End If
   sendVariable2Flash Swf(IndexSwf), "SearchPathImage", path & "%~%" & Name & "%~%" & index & "%~%" & currentCountry
   Exit Function
Error:
   'Take out on error for loading image files
'''   WriteEvent "PutImage", Err.Description, Err.Source
End Function
Public Sub KeyCtrlPlus(args As String)
   On Error GoTo Error
      Dim stSpl() As String
      stSpl = Split(args, "~")
      args = stSpl(1)
      If stSpl(0) = "1" Then
         EditSetting MainSettingXML, 0, "AlbumCover", args
         SplitColor = ReplaceStrSpl(SplitColor, 2, args, "~")
         sendVariable2Flash Swf(0), "AlbumCover", args
         sendVariable2Flash Swf(0), "SetAlbumCover", "1"
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         If IndexSwf = 2 Then
            sendVariable2Flash Swf(2), "AlbumCover", args
            sendVariable2Flash Swf(2), "SetAlbumCover", args
            sendVariable2Flash Swf(2), "OpenFrame", "true"
         ElseIf IndexSwf = 3 Then
            sendVariable2Flash Swf(3), "AlbumCover", args
            sendVariable2Flash Swf(3), "SetAlbumCover", args
            sendVariable2Flash Swf(3), "OpenFrame", "true"
         ElseIf IndexSwf = 4 Then
            sendVariable2Flash Swf(4), "AlbumCover", args
            sendVariable2Flash Swf(4), "SetAlbumCover", args
            sendVariable2Flash Swf(4), "OpenFrame", "true"
         End If
      ElseIf stSpl(0) = "2" Then
         EditSetting MainSettingXML, 0, "NumCover", args
         SplitColor = ReplaceStrSpl(SplitColor, 3, args, "~")
         sendVariable2Flash Swf(0), "NumCover", args
         sendVariable2Flash Swf(0), "SetAlbumCover", "true"
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         If IndexSwf = 2 Then
            sendVariable2Flash Swf(2), "NumCover", args
            sendVariable2Flash Swf(2), "SetAlbumCover", "true"
            sendVariable2Flash Swf(2), "OpenFrame", "true"
         ElseIf IndexSwf = 3 Then
            sendVariable2Flash Swf(3), "NumCover", args
            sendVariable2Flash Swf(3), "SetAlbumCover", "true"
            sendVariable2Flash Swf(3), "OpenFrame", "true"
         End If
      ElseIf stSpl(0) = "3" Then
         EditSetting MainSettingXML, 0, "PlusCover", args
         SplitColor = ReplaceStrSpl(SplitColor, 20, args, "~")
         sendVariable2Flash Swf(0), "PlusCover", args
         sendVariable2Flash Swf(0), "SetAlbumCover", "true"
         sendVariable2Flash Swf(0), "OpenFrame", "true"
         If IndexSwf = 2 Then
            sendVariable2Flash Swf(2), "PlusCover", args
            sendVariable2Flash Swf(2), "SetAlbumCover", "true"
            sendVariable2Flash Swf(2), "OpenFrame", "true"
         ElseIf IndexSwf = 3 Then
            sendVariable2Flash Swf(3), "PlusCover", args
            sendVariable2Flash Swf(3), "SetAlbumCover", "true"
            sendVariable2Flash Swf(3), "OpenFrame", "true"
         End If
      ElseIf stSpl(0) = "J" Then
         If IndexSwf = 3 Then
            EditSetting MainSettingXML, 0, "PlayListAlbumNum", args
            sendVariable2Flash Swf(3), "SetAlbumNum", args
            
         ElseIf IndexSwf = 2 Then
            EditSetting MainSettingXML, 0, "SearchAlbumNum", args
            sendVariable2Flash Swf(2), "SetAlbumNum", args
            
         Else
            EditSetting MainSettingXML, 0, "AlbumNum", args
            SplitColor = ReplaceStrSpl(SplitColor, 1, args, "~")
            sendVariable2Flash Swf(0), "SetAlbumNum", args
            
         End If
         
      ElseIf stSpl(0) = "G" Then
         If Grouping = 0 Then
            Grouping = -1
         Else
            Grouping = 0
         End If
         sendToFlash Swf(IndexSwf), "grouping", CStr(Grouping)
         EditSetting MainPath & "\Language.xml", 0, "Grouping", str(Grouping)
         'CBrowse.mSelectAlbumType = all
         CBrowse.mSelectGroupCDType = Grouping              ' 0 mean group,-1 mean not group
      ElseIf stSpl(0) = "K" Then
         If Micro = "true" Then
            Micro = "false"
         Else
            Micro = "true"
         End If
         b_micro = Micro = "true"
         EditSetting MainSettingXML, 2, "Micro", Micro
         SplitPlayer = ReplaceStrSpl(SplitPlayer, 6, Micro, "~")
      ElseIf stSpl(0) = "W" Then
         UnloadSwfMiniControl
         UnloadSwfDvdControl

         If WinMode = "FullScreen Mode" Then
            args = "Window Mode"
         Else
            args = "FullScreen Mode"
         End If
         picMovieBackground.Visible = False                    '2007-07-11 RequestSize
         If args = "FullScreen Mode" Then
            WinMode = "FullScreen Mode"
            SlySize
            FirstLoad = False
            'Form_Paint
            Swf(IndexSwf).Height = formHeight
            Swf(IndexSwf).Width = formWidth
            'EditSetting MainSettingXML, 0, "FormMode", "FullScreen Mode"
         Else
            WinMode = "Window Mode"
            SlySize
            FirstLoad = False
            'Form_Paint
            Swf(IndexSwf).Height = formHeight
            Swf(IndexSwf).Width = formWidth
            'EditSetting MainSettingXML, 0, "FormMode", "Window Mode"
         End If
         
         If bool_full_vis Then
            scale_visualization_to_fullscreen False
         ElseIf picwmp.Visible And CPlayer.PlayWith = Winamp And b_play Then
            'MediaPlayer.StartVisualization
            scale_visualization_to_fullscreen True
         End If
         If str_swfNames = "Fullscreen" Then
            SWF_FMA(1).Move 0, 0, formWidth, formHeight
            sendToFlash SWF_FMA(1), "displayFullscreen", "true"
         End If
         'Seng 2006-12-12 Show minicontrol when use key
         If (CWinsock.LoggedType = remoteControl Or run_FormVideoLoaded) And show_hide_player And Not bool_full_vis Then DoEvents: LoadSwfMiniControl
      End If
   Exit Sub
Error:
   WriteEvent "KeyCtrlPlus", Err.Description, Err.Source
End Sub



' Refresh New Language after download completed
Public Sub refreshNewLanguage(str_Language As String)
   On Error GoTo Error
    Dim arr_newLanguage() As String
    Dim arr_one() As String
    Dim init As Integer
    Dim languagePath As String
    arr_newLanguage = Split(str_Language, de_Record)
    For init = 0 To UBound(arr_newLanguage)
        arr_one = Split(arr_newLanguage(init), "||")
        languagePath = arr_one(1) & "\" & arr_one(0)
        AddNewFile App.path & "\sly\Countries.xml", languagePath, arr_one(1) & "\" & arr_one(0), arr_one(0), "Country"
        EditSetting fso.BuildPath(languagePath, "language.xml"), 2, "Destination", languagePath
        EditSetting fso.BuildPath(languagePath, "language.xml"), 3, "Path", languagePath

    Next init
    sendVariable2Flash Swf(1), "openLanguage", App.path & "\sly"
    ReloadCountryFromXML
   Exit Sub
Error:
   WriteEvent "refreshNewLanguage", Err.Description, Err.Source
End Sub
Sub SplitScreens(args As String)
   On Error GoTo Error
   Dim ArrTempScreen() As String
   Dim ArrTempScreen1() As String
   Dim sep As String
   Dim StringScreens As String
   Dim stDate As Date
   Dim i As Integer
   Dim path As String
   ArrTempScreen = Split(args, "&&")
   For i = 0 To UBound(ArrTempScreen)
         ArrTempScreen1 = Split(ArrTempScreen(i), "%")
         path = App.path & "\Sly\Loading" & ArrTempScreen1(1) & ".sly"
         If Dir(path) = "" Then
             StringScreens = StringScreens + sep + ArrTempScreen(i)
             sep = "&&"
         Else
            If GetScreenDate(path) < CDate(ArrTempScreen1(0)) Then
                StringScreens = StringScreens + sep + ArrTempScreen(i)
                sep = "&&"
            End If
         End If
         
   Next
   If StringScreens <> "" Then
        sendVariable2Flash Swf(IndexSwf), "StrArrChecked", StringScreens
    Else
        sendVariable2Flash Swf(IndexSwf), "StrArrChecked", "Non"
   End If
   Exit Sub
Error:
   WriteEvent "SplitScreens", Err.Description, Err.Source
End Sub

Sub closeTabStop(valClose As Boolean)
    Swf(IndexSwf).TabStop = valClose
End Sub


'================================================================================
' Play music with Winamp
'================================================================================
Sub controllWinamp(ByVal command As String, Optional Value As String)
   On Error GoTo Error
    Dim InputSeekStart As Long
    Dim inputSeekEnd As Long
    Dim iSeekLength As Long
    Dim iSeekPosition As Long
'''    Dim controls As IWMPControls3
'''    Set controls = CWmp.controls
   
    Select Case command
        Case "Play"
            CPlayer.Play
'''            MediaPlayer.Play
'''            If picwmp.Visible = True And LoadSlideshow = False And str_swfNames <> "Micro" Then MediaPlayer.StartVisualization
        Case "Pause"
            CPlayer.Pause
'''            MediaPlayer.Pause
        Case "Stop"
'''            MediaPlayer.Stops
            CPlayer.Stops
        Case "Next"
            NextAndPrevious_Winamp "Next"
        Case "Previous"
            NextAndPrevious_Winamp "Previous"
        Case "selectPlaylist"
            
            int_current_index = CLng(Value)
            int_current_index = CInt(int_current_index)
            setToWinamp int_current_index
            
            repeat_shuffle
            get_track_info True
            sendTrackIndex2Player
        Case "seek"
'''            GetTrackSeekStart_End InputSeekStart, inputSeekEnd, getMovieDuration
            GetTrackSeekStart_End InputSeekStart, inputSeekEnd, CPlayer.Duration
            iSeekLength = inputSeekEnd - InputSeekStart
            iSeekPosition = InputSeekStart + val(Value) * iSeekLength
            ' xxx changed sith 26-05-06 xxxxxxxxxxxxxxxxx
            iSeekPosition = IIf(iSeekPosition >= inputSeekEnd - 2, inputSeekEnd - 5, iSeekPosition)
            ' for the last chapter when finish it will goto playing (menu) state
            ' xxx end xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            If CWinsock.LoggedType = ServerMode Then
               CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & iSeekPosition & "&&&" & getPlayState
               boolSeeked = False
            End If
            CPlayer.Seeks = iSeekPosition
'''            If playMusicWith = Winamp Then
'''               If iSeekPosition <= MediaPlayer.duration Then
'''                  CMediaPlayer.SeeksTime iSeekPosition
'''               End If
'''            ElseIf playMusicWith = WindowMedia Then
''''''               If Not CWmp.currentMedia Is Nothing Then
'''               If CPlayer.MediaIsnothing = False Then
''''''                  If iSeekPosition <= CWmp.currentMedia.duration Then
'''                  If iSeekPosition <= CPlayer.duration Then
'''                     SeekWindowMedia iSeekPosition
'''                  End If
'''               End If
'''            Else
'''               If iSeekPosition <= FrmMain.NSPlayer.duration Then FrmMain.NSPlayer.seekTime = iSeekPosition
'''            End If
         b_startTime = True
         'boolSeeked = False                            'don't make it send to client again
        Case "removePlaylist"
            CPlayer.ClearPlayList
'''            MediaPlayer.ClearPlayList
'''            MediaPlayer.Stops
    End Select
   Exit Sub
Error:
   WriteEvent "controllWinamp", Err.Description, Err.Source
End Sub

Sub NextAndPrevious_Winamp(str_event As String)
   On Error GoTo Error
    If int_track_count > 0 Then
        If b_shuffle = True Then
            int_current_index = Int(UBound(Infos) * Rnd())
        Else
            If str_event = "Next" Then
                If int_current_index + 1 > UBound(Infos) Then
                    int_current_index = 0
                Else
                    int_current_index = int_current_index + 1
                End If
            ElseIf str_event = "Previous" Then
                If int_current_index - 1 < 0 Then
                    int_current_index = UBound(Infos)
                Else
                    int_current_index = int_current_index - 1
                End If
            End If
        End If
        setToWinamp int_current_index
        miniCommand "Play" & "|:|" & True
        
        int_current_index = CInt(int_current_index)
        sendTrackIndex2Player
    End If
   Exit Sub
Error:
   WriteEvent "NextAndPrevious_Winamp", Err.Description, Err.Source
End Sub

Sub check_track_to_play_after_finish_one_track_with_winamp()
   On Error GoTo Error
   If int_track_count > 0 Then
      b_play = False
      If int_track_count = 1 Then
          If b_loop = True Then
              miniCommand "Play" & "|:|" & True
          Else
              sendCommand2Player "Stop", CStr(False)
              miniCommand "Stop" & "|:|" & True
          End If
      Else
          If int_current_index = 0 Then
              If b_shuffle = True Then
                  int_current_index = Int(UBound(Infos) * Rnd())
              Else
                  int_current_index = int_current_index + 1
              End If
              GoTo setNewMusic
          ElseIf int_current_index = UBound(Infos) Then
              If b_loop = True Then
                  If b_shuffle = True Then
                      int_current_index = Int(UBound(Infos) * Rnd())
                  Else
                      int_current_index = 0
                  End If
                  GoTo setNewMusic
              Else
                  sendCommand2Player "Stop", CStr(False)
                  miniCommand "Stop" & "|:|" & True
              End If
          Else
              If b_shuffle = True Then
                  int_current_index = Int(UBound(Infos) * Rnd)
              Else
                  int_current_index = int_current_index + 1
              End If
              GoTo setNewMusic
          End If
      End If
   End If
Exit Sub

setNewMusic:

    miniCommand "Play" & "|:|" & True
   Exit Sub
Error:
   WriteEvent "check_track_to_play_after_finish_one_track_with_winamp", Err.Description, Err.Source
End Sub

Sub SwitchPlayer(newPlayer As String, indexPlaying As Long)
   'switch from on player to another player
   On Error GoTo Error
    Dim i_newPlayer As Long
    If newPlayer = "WindowMedia" Then
'''        If Not MediaPlayer Is Nothing Then MediaPlayer.ClearPlayList
        
        tmpTrackInfos = PlayTrackInfo
        tmpInfos = Infos
        
        If int_track_count > 0 Then
            Dim mediaCount As Long
            For i_newPlayer = 0 To UBound(Infos)
                  
                'If UCase(right(Infos(i_newPlayer).TrackPath, 3)) = UCase("dat") Or UCase(right(Infos(i_newPlayer).TrackPath, 3)) = UCase("ifo") Then '22-10-05
                If True Then '05-12-05             'don't make it filter out the unknown extension
                     Infos(mediaCount) = Infos(i_newPlayer)
                     PlayTrackInfo(mediaCount) = PlayTrackInfo(i_newPlayer)
'                     setToWindowMendia Infos(mediaCount).TrackPath, (mediaCount) + 1
                     mediaCount = mediaCount + 1
                Else
                    int_current_index = 0
                    b_storePlaylist = True
                End If
            Next i_newPlayer
            int_track_count = mediaCount
            If int_track_count > 0 Then
               ReDim Preserve Infos(mediaCount - 1)
               ReDim Preserve PlayTrackInfo(mediaCount - 1)
            Else
               Erase Infos
               Erase PlayTrackInfo
            End If
            
            miniCommand "Play|:|true"
        End If
         sendTrackIndex2Player

    ElseIf newPlayer = "Winamp" Then
        
        int_current_index = indexPlaying
        
        If b_storePlaylist = True Then
            b_storePlaylist = False
            PlayTrackInfo = tmpTrackInfos
            Infos = tmpInfos
            int_track_count = UBound(Infos) + 1
            int_current_index = 0
        End If
        Erase tmpTrackInfos
        Erase tmpInfos
'''        CWmp.currentMedia = SetWmpURL("")
         CPlayer.ClearPlayList
        If int_track_count > 0 Then
            miniCommand "Play|:|true"
        End If
        sendTrackIndex2Player
    ElseIf LCase(newPlayer) = "nero" Then
        int_current_index = indexPlaying
        
        If b_storePlaylist = True Then
            b_storePlaylist = False
            PlayTrackInfo = tmpTrackInfos
            Infos = tmpInfos
            int_track_count = UBound(Infos) + 1
            int_current_index = 0
        End If
        Erase tmpTrackInfos
        Erase tmpInfos
'''        CWmp.currentMedia = SetWmpURL("")
         CPlayer.ClearPlayList
        If int_track_count > 0 Then
            miniCommand "Play|:|true"
        End If
        sendTrackIndex2Player
    End If
   Exit Sub
Error:
   WriteEvent "SwitchPlayer", Err.Description, Err.Source
End Sub

'''Public Sub rescale_visualization_winamp()
'''    If picwmp.Visible = True And b_play = True And playMusicWith = Winamp Then
'''        MediaPlayer.ScaleVisualization
'''    End If
'''End Sub

'================================================================================
'================================================================================

Sub scale_visualization_to_fullscreen(bo_scale As Boolean)
   'EDIT:2006-08-02
   On Error GoTo ErrorVisualization
   Dim bOldStateBackVisible As Boolean
   Dim boolShowWmp As Boolean
   
   bOldStateBackVisible = picMovieBackground.Visible
   If run_FormVideoLoaded = False Then picMovieBackground.Visible = False                 'Don't hide it when switching from normal to fullscreen
   If bo_scale = False Then
      'goto full screen video
      'don't the mouse move offscreen while go to the fullscreen video  2005-09-27
      'SetCursorPos ScreenX, ScreenY / 2
      bool_full_vis = True
      'CPlayer.Visible = False
      With scaleVis
         .vis_width = ScaleX(ori_player_width, vbPixels, vbTwips)
         .vis_height = ScaleY(ori_player_height, vbPixels, vbTwips)
         .vis_left = ScaleX(ori_player_left, vbPixels, vbTwips)
         .vis_top = ScaleY(ori_player_top, vbPixels, vbTwips)
      End With
      With picwmp
         .left = 0
         .top = 0
         
         If WinMode = "FullScreen Mode" Then
            .Height = FrmMain.Height
            .Width = FrmMain.Width
         Else
            .Height = FrmMain.Height - ScaleY(GetSystemMetrics(SM_CYCAPTION) - GetSystemMetrics(SM_CYEDGE) * 2, vbPixels, vbTwips)
            .Width = FrmMain.Width - ScaleX(GetSystemMetrics(SM_CXEDGE), vbPixels, vbTwips) * 2
          End If
      End With
      picMovieBackground.Move -ScaleX(3, vbPixels, vbTwips), -ScaleY(3, vbPixels, vbTwips), picwmp.Width + ScaleX(7, vbPixels, vbTwips), picwmp.Height + ScaleY(7, vbPixels, vbTwips)
      CPlayer.stretchToFit = True
      CPlayer.UiMode = "None"
      
      storeOriginalLength
      
      noHideDVDControl                  'don't make it show while goto the fullscreen
      UnloadSwfMiniControl
      closeScreenPlayer
      boolShowWmp = True
      'xxx changed sith 29-05-06 xxx
      ' show DVD all time
      If (CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded)) Then
          LoadSwfDvdControl
          b_ShowControlInPlayer = True
          ShowHideDVDControl b_ShowControlInPlayer, run_DVDScalePercent, (Settings.setDisplayDvdContol = "0")
          
          If (int_track_count > 0 And int_current_index > -1) And (b_play Or b_pause) Then popUp
      End If
        'xxx end xx
    Else
        bool_full_vis = False
        With picwmp
            .Width = scaleVis.vis_width
            .Height = scaleVis.vis_height
            .left = scaleVis.vis_left
            .top = scaleVis.vis_top
        End With
        picMovieBackground.Move -ScaleX(3, vbPixels, vbTwips), -ScaleY(3, vbPixels, vbTwips), scaleVis.vis_width + Screen.TwipsPerPixelX * 7, scaleVis.vis_height + Screen.TwipsPerPixelY * 7
        
        storeOriginalLength
        resize_visualization_normal '2005/08/23 : Muny
        
        UnloadSwfDvdControl
        'xxx changed sith 29-05-06
        If CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded) Then
           If show_hide_player Then
               LoadSwfMiniControl
            Else
               UnloadSwfMiniControl
            End If
        End If
        'xxx end xxx
        If show_hide_player = True Then
            boolShowWmp = True
        End If
    End If
    ''''
   If int_track_count > 0 And int_current_index >= 0 Then ZoomToLevel PlayTrackInfo(int_current_index).ZoomLevel
   If bool_full_vis Then picwmp.ZOrder 0
   blankScreen bool_full_vis
   picwmp.Visible = IIf((CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded)), bool_full_vis, boolShowWmp)
   If (CWinsock.LoggedType = remoteControl) Or (run_FormVideoLoaded) And bool_full_vis = True Then
      popUp True
   End If
   
   'EDIT:2006-08-02                    'Switch from mini to fullscreen video(In root menu) hide video
   'If CPlayer.isInMenuMode Or picwmp.Visible Then picMovieBackground.Visible = True
   picMovieBackground.Visible = bOldStateBackVisible
   '2006-12-16 Seng load playing image
   If bool_full_vis = False Then        'when go back from full screen video make it set focus to current index swf
      Swf(IndexSwf).SetFocus
   Else
      picwmp.SetFocus
      If CWinsock.LoggedType = remoteControl Or (run_FormVideoLoaded) Then
         displayTimeInPictureBox
      End If
   End If
   Exit Sub
ErrorVisualization:
   Debug.Print "Error visualization ", Err.Description, Err.Source
End Sub

Function get_currnet_album_slideshow_path(ID_and_language As String) As String
   On Error Resume Next
   Dim spl_array() As String
   Dim path As String
   Dim t As IXMLDOMElement
   Dim t1 As IXMLDOMElement
   Dim SlidePath As String
   Dim i As Integer
   
   spl_array = Split(ID_and_language, "%~%")
   
   path = get_country_path(spl_array(1))
   If path <> "" And spl_array(0) <> "" And Dir(path & "\Database\" & "SlideshowPaths.xml") <> "" Then
      Set xmlTrack = New DOMDocument
      xmlTrack.Load path & "\Database\" & "SlideshowPaths.xml"
      Set t1 = xmlTrack.selectSingleNode("SlideshowPaths/SlideshowPath[@AlbumId = '" & spl_array(0) & "']")
      If Not t1 Is Nothing Then
         get_currnet_album_slideshow_path = t1.getAttribute("Path")
      End If
   Else
      get_currnet_album_slideshow_path = ""
   End If
'''   Exit Function
'''Error:
'''   WriteEvent "get_currnet_album_slideshow_path", Err.Description, Err.Source
End Function

Public Sub import_new_playlist(str_current_path As String, str_import_path As String)
   On Error GoTo Error
'=== import all file in playlists.xml
'=== import one file
   Dim ii As Long
   Dim xmlPlaylist As DOMDocument
   Dim tmp_playlistName As String
   Dim new_palylistName As String
   Dim bool_rename As Boolean
   new_palylistName = fso.GetBaseName(str_import_path)
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load str_current_path & "\Playlists\Playlists.xml"
   For ii = 0 To xmlPlaylist.firstChild.childNodes.Length - 1
      If xmlPlaylist.firstChild.childNodes(ii).Text = new_palylistName Then
         bool_rename = True
         Exit For
      End If
   Next ii
   If bool_rename = True Then new_palylistName = new_palylistName & " (New)"

   sendVariable2Flash Swf(3), "NewFolderPlaylist", new_palylistName
   sendVariable2Flash Swf(3), "OpenFrame", "true"
   fso.CopyFile str_import_path, str_current_path & "\Playlists\" & new_palylistName & ".xml", True
   add_new_element str_current_path & "\Playlists\Playlists.xml", "", App.path & "\sly\PlaylistIcon.sly", new_palylistName, "Playlist"
   Exit Sub
Error:
   WriteEvent "import_new_playlist", Err.Description, Err.Source
End Sub

Sub change_xml_setting_as_server(indwck As Integer)
   On Error GoTo Error
    Dim valChange As String
    Dim arr() As String
    Dim str_PlayListAlbumNum As String
    Dim str_DisplayAlbumList As String
    Dim str_SearchAlbumNum As String
    Dim str_DisplayAlbumListSearch As String
    Dim str_DisplayAlbumListPlaylist As String
    
    arr = Split(SplitColor, "~")
    
    str_PlayListAlbumNum = read_XML_attributes(MainSettingXML, 0, "PlayListAlbumNum")
    str_DisplayAlbumList = read_XML_attributes(MainSettingXML, 0, "DisplayAlbumList")
    str_SearchAlbumNum = read_XML_attributes(MainSettingXML, 0, "SearchAlbumNum")
    str_DisplayAlbumListSearch = read_XML_attributes(MainSettingXML, 0, "DisplayAlbumListSearch")
    str_DisplayAlbumListPlaylist = read_XML_attributes(MainSettingXML, 0, "DisplayAlbumListPlaylist")
    
    valChange = b_mute & "||" & WaveVolume & "||" & b_loop & "||" & b_shuffle & "||" & b_karaoke_voice & "||" & Language
    valChange = valChange & "||" & b_micro & "||" & microStyle & "||" & b_play & "||" & setDisplayTrackType & "||" & DisplayAlbumLong & "||" & DisplayAlbumLongSearch
    valChange = valChange & "||" & DisplayAlbumLongPlaylist & "||" & ChangeIcon & "||" & SplitSly & "||" & arr(12) & "||" & arr(17) & "||" & arr(1)
    valChange = valChange & "||" & str_PlayListAlbumNum & "||" & str_DisplayAlbumList & "||" & str_SearchAlbumNum & "||" & str_DisplayAlbumListSearch & "||" & str_DisplayAlbumListPlaylist
    'valChange = valChange & "||" & language
    CWinsock.Send2Client WS_COMMAND, indwck, "changeXMLSetting&&&" & valChange
   Exit Sub
Error:
   WriteEvent "change_xml_setting_as_server", Err.Description, Err.Source
    
End Sub

Sub start_change_xml_setting_as_server(str_value As String)
   On Error GoTo Error
    Dim cSplit() As String
    cSplit = Split(str_value, "||")
    
    load_already = False
    If CWinsock.LoggedType <> independentMode Then       'Don't change the other setting if it independent mode
      If syn_vol Then
         miniCommand "Volume|:|" & cSplit(1)
         miniCommand "Mute|:|" & LCase(cSplit(0))                      'mute as server
      End If
      If cSplit(2) = "True" Then
         b_loop = True
         EditXML MainSettingXML, 2, "Repeat", "Yes"
      Else
         b_loop = False
         EditXML MainSettingXML, 2, "Repeat", "No"
      End If
      
      If cSplit(3) = "True" Then
         b_shuffle = True
         EditXML MainSettingXML, 2, "Shuffle", "Yes"
      Else
         b_shuffle = False
         EditXML MainSettingXML, 2, "Shuffle", "No"
      End If
   End If
   b_karaoke_voice = cSplit(4) = "true"               'change from (TypeFull(visualization or image))
   
   'EditXML MainSettingXML, 2, "TypeFull", cSplit(4)
   'language = cSplit(5)          'change from scroll to language
   If Not CWinsock.LoggedAs(independentMode) Then        ' No change language as server when log as independent mode
      Language = cSplit(5)            'change from scroll to language
      miniCommand "changeLanguage|:|" & Language
   End If
   
   EditSetting MainSettingXML, 0, "Language", Language
   b_micro = cSplit(6) = "True"
   EditXML MainSettingXML, 2, "Micro", LCase(cSplit(6))
   microStyle = CInt(cSplit(7))
   EditXML MainSettingXML, 2, "microStyle", cSplit(7)
   miniCommand "changeLanguage|:|" & Language
    
   If cSplit(8) = "False" Then
      If CWinsock.LoggedType <> independentMode Then
          b_play = False
          miniCommand "Stop" & "|:|" & True
      End If
   End If
    
    If CWinsock.LoggedType = cloneDisplay Then
    
        setDisplayTrackType = cSplit(9)
        EditXML MainSettingXML, 0, "trackType", setDisplayTrackType
    
        DisplayAlbumLong = cSplit(10)
        DisplayAlbumLongSearch = cSplit(11)
        DisplayAlbumLongPlaylist = cSplit(12)
        ChangeIcon = cSplit(13)
        EditSetting MainSettingXML, 0, "DisplayAlbumList", DisplayAlbumLong
        EditSetting MainSettingXML, 0, "DisplayAlbumListSearch", DisplayAlbumLongSearch
        EditSetting MainSettingXML, 0, "DisplayAlbumListPlaylist", DisplayAlbumLongPlaylist
        
        
        If syn = True Then
        
            Dim val_slideshow() As String
            val_slideshow = Split(cSplit(14), "~")
            'FunOptions "SetSlideShow", val_slideshow(1) & "," & val_slideshow(0)
            If fso.DriveExists(fso.GetDriveName(val_slideshow(0))) Then
                FunOptions "SetSlideShow", val_slideshow(1) & "," & val_slideshow(0)
            Else
                Dim ff As String
                ff = fso.GetDriveName(App.path) & mID(fso.GetParentFolderName(val_slideshow(0)), 3)
                FunOptions "SetSlideShow", val_slideshow(1) & "," & ff
            End If
            FunOptions "ChangeInterval", val_slideshow(2)
            FunOptions "ChangeDelay", val_slideshow(7)
        End If
        
        EditSetting MainSettingXML, 0, "AdvSearch", cSplit(15)
        SplitColor = ReplaceStrSpl(SplitColor, 12, cSplit(15), "~")
      
        EditSetting MainSettingXML, 0, "ModeSearch", cSplit(16)
        SplitColor = ReplaceStrSpl(SplitColor, 17, cSplit(16), "~")
        
        EditSetting MainSettingXML, 0, "AlbumNum", cSplit(17)
        SplitColor = ReplaceStrSpl(SplitColor, 1, cSplit(17), "~")
        
        EditSetting MainSettingXML, 0, "PlayListAlbumNum", cSplit(18)
        EditSetting MainSettingXML, 0, "DisplayAlbumList", cSplit(19)
        EditSetting MainSettingXML, 0, "SearchAlbumNum", cSplit(20)
        EditSetting MainSettingXML, 0, "DisplayAlbumListSearch", cSplit(21)
        EditSetting MainSettingXML, 0, "DisplayAlbumListPlaylist", cSplit(22)
        
        
    End If
   Exit Sub
Error:
   WriteEvent "start_change_xml_setting_as_server", Err.Description, Err.Source
End Sub

Sub change_language()
   On Error GoTo Error
    Const args = "true"
    If Language = "Eng" Then
       Language = "Uni"
    Else
        Language = "Eng"
    End If
    changeEngUni
    EditSetting MainSettingXML, 0, "Language", args
    SplitColor = ReplaceStrSpl(SplitColor, 13, args, "~")
    sendVariable2Flash Swf(0), "ChangeLanguage", args
    sendVariable2Flash Swf(0), "OpenFrame", "true"
    If IndexSwf <> 0 Then
        sendVariable2Flash Swf(IndexSwf), "ChangeLanguage", args
        sendVariable2Flash Swf(IndexSwf), "OpenFrame", "true"
    End If
   Exit Sub
Error:
   WriteEvent "change_language", Err.Description, Err.Source
End Sub
Public Sub check_image_metric_and_save_as_JPG(filename As String, Destination As String)
   On Error GoTo Error
    Dim c_image As New GDIPImage
    Dim w_image As Long
    Dim h_image As Long
    c_image.FromFile filename
    w_image = c_image.Width
    h_image = c_image.Height
    c_image.Dispose
    
    If resize_image = True Then
        If w_image <= 200 And h_image <= 200 Then
            save_as_JPG filename, Destination
        Else
            save_as_JPG filename, Destination, 200
        End If
    Else
        If w_image <= 500 And h_image <= 500 Then
            save_as_JPG filename, Destination
        Else
            save_as_JPG filename, Destination, 500
        End If
    End If
   Exit Sub
Error:
   WriteEvent "check_image_metric_and_save_as_JPG", Err.Description, Err.Source
End Sub

Function click_for_chage_visualization(SendCommand As String, allow_event As Boolean) As Boolean
   On Error GoTo Error
    If CWinsock.LoggedType <> remotePlaylist Then
        If CWinsock.LoggedType = ServerMode Then
            CWinsock.Send2Client WS_COMMAND, 0, SendCommand
            click_for_chage_visualization = False
        ElseIf (CWinsock.LoggedType = cloneDisplay) And click_self Then
            CWinsock.Send2Server WS_COMMAND, SendCommand
            click_for_chage_visualization = True
        ElseIf CWinsock.LoggedType = independentMode And click_self = False Then
            click_for_chage_visualization = True
        End If
    ElseIf CWinsock.LoggedType = remotePlaylist Then
        If allow_event And click_self Then
            CWinsock.Send2Server WS_COMMAND, SendCommand
            click_for_chage_visualization = True
        ElseIf allow_event And Not (click_self) Then
            click_for_chage_visualization = False
        ElseIf Not (allow_event) And Not (click_self) Then
            click_for_chage_visualization = True
        End If
    End If
   Exit Function
Error:
   WriteEvent "click_for_chage_visualization", Err.Description, Err.Source
End Function

Public Sub first_copy_image_slideshow_from_server(img_p As String)
   On Error GoTo Error
    Dim timg() As String
    Dim jj As Integer
    Dim ss As String
    
    If img_p = "No picture found" Then
        If LoadSlideshow = True Then
            image_index = 0
            currentSlideShowPath = "No picture found"
            sendToFlash frmSlideShow.SlideShow, "stringPath", currentSlideShowPath
        End If
    Else

        timg = Split(img_p, "%~%")
        ss = img_p
        frmSlideShow.server_image_slideshow_paths = string_image_slideshow
                
        If LoadSlideshow = True And syn = True Then
        
            'ss = Replace(ss, fso.GetDriveName(timg(0)), GetMyPictureFolder)
            ss = change_image_slideshow_path_to_new_path(ss)
            str_path_copying_slideshow = ss
            
            If currentSlideShowPath <> ss Then
                image_index = 0
                
                If server_loadSlideshow = True Then
                    sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", CStr(server_slideshow_index)
                Else
                    sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", ""
                End If
                
                currentSlideShowPath = ss
                sendToFlash frmSlideShow.SlideShow, "stringPath", ss
            
                ReDim Preserve copy_image_slideshow(-1 To -1)
                For jj = 0 To UBound(timg)
                    ReDim Preserve copy_image_slideshow(-1 To jj)
                    copy_image_slideshow(jj) = timg(jj)
                Next jj
                start_copy_images_for_slideshow
                
            End If
        End If
    End If
   Exit Sub
Error:
   WriteEvent "first_copy_image_slideshow_from_server", Err.Description, Err.Source
End Sub
Private Function change_image_slideshow_path_to_new_path(strss As String) As String
   On Error GoTo Error
'  change from normal path to MYDOCUMENTS/SLY FRIEND'S PICTURES for slideshow load
   Dim docP As String
   Dim arr_n() As String
   Dim jj As Long
   Dim tmpp As String
   Dim newP As String
   arr_n = Split(strss, "%~%")
   If server_nick_name <> "" Then
      docP = GetMyDocuments & "\Sly's Friends Pictures\" & server_nick_name
   Else
      docP = GetMyDocuments & "\Sly's Friends Pictures"
   End If
   
   For jj = 0 To UBound(arr_n)
'      tmpp = docP & fso.GetFileName(arr_n(jj))
      tmpp = fso.BuildPath(docP, Replace(arr_n(jj), main_slideshow_path, ""))
      If newP <> "" Then
         newP = newP & "%~%" & tmpp
      Else
         newP = tmpp
      End If
   Next jj
   change_image_slideshow_path_to_new_path = newP
   Exit Function
Error:
   WriteEvent "change_image_slideshow_path_to_new_path", Err.Description, Err.Source
End Function

Public Sub create_xml_image_slideshow_path(str_text As String)
   On Error GoTo Error
    Dim sxml As DOMDocument
    Dim exml As IXMLDOMElement
    Dim Sp As String
    Dim mps() As String
    mps = Split(FrmMain.SplitSly, "~")
    
    Sp = xml_slideshow_path
    
    Set sxml = New DOMDocument
    Set exml = sxml.createElement("img")
    exml.setAttribute "slideshow_path", fso.GetParentFolderName(mps(0))
    
    exml.Text = str_text
    sxml.appendChild exml
    
    sxml.Save Sp
   Exit Sub
Error:
   WriteEvent "create_xml_image_slideshow_path", Err.Description, Err.Source
End Sub

Public Function read_xml_image_slideshow_path() As String
   On Error GoTo Error
    Dim sxml As DOMDocument
    Dim exml As IXMLDOMElement
    Dim Sp As String
    
    Sp = xml_slideshow_path
    If Dir(Sp) <> "" Then
        Set sxml = New DOMDocument
        sxml.Load Sp
        Set exml = sxml.firstChild
        main_slideshow_path = exml.getAttribute("slideshow_path")
        read_xml_image_slideshow_path = exml.childNodes(0).Text
    Else
        read_xml_image_slideshow_path = ""
    End If
   Exit Function
Error:
   WriteEvent "read_xml_image_slideshow_path", Err.Description, Err.Source
End Function

Public Function get_current_slideshow() As String
   On Error GoTo Error
    Dim path As String
    Dim t As IXMLDOMElement
    Dim t1 As IXMLDOMElement
    Dim SlidePath As String
    Dim i As Integer
    Dim xmlSlidePath As String
    Dim Lan As String
    Dim albumID As String
    
    Static album_id As Long
    Static album_lan As String
    Static slide_path As String
    
    StringPathSlide = ""
    sepSlide = ""
    
    If b_play = False Then
        SlidePath = GetAttSetting(1, "ImagePath")
        frmSlideShow.getStrPathSlideShow (SlidePath)
    Else
            
        Lan = Infos(int_current_index).TrackLan
        albumID = Infos(int_current_index).trackAlbumID
            
        If str(album_id) = albumID And album_lan = Lan Then
            get_current_slideshow = slide_path
            Exit Function
        End If
        
        xmlSlidePath = path & "\Database\" & "SlideshowPaths.xml"
        path = get_country_path(Lan)
        'path = AllCountryArray(Lan)
        
        If path <> "" And albumID <> "" And Dir(xmlSlidePath) <> "" Then
            Set xmlTrack = New DOMDocument
            xmlTrack.Load xmlSlidePath
            Set t1 = xmlTrack.selectSingleNode("SlideshowPaths/SlideshowPath[@AlbumId = '" & albumID & "']")
            If Not t1 Is Nothing Then
                SlidePath = t1.getAttribute("Path")
            End If
        End If
    
        If SlidePath <> "" Then
            frmSlideShow.getStrPathSlideShow (SlidePath)
        Else
            SlidePath = GetAttSetting(1, "ImagePath")
            frmSlideShow.getStrPathSlideShow (SlidePath)
        End If
        
    End If
    
    If StringPathSlide = "" Then StringPathSlide = "No picture found"
    
    slide_path = StringPathSlide
    get_current_slideshow = slide_path
   Exit Function
Error:
   WriteEvent "get_current_slideshow", Err.Description, Err.Source
End Function
Public Sub SavePlaylistPlayer(args As String)
   On Error GoTo Error
   Dim spl() As String
   spl = Split(args, "~")
   If (spl(0) = "") Then
      Set fItem = bf.BrowseForFolder(hwnd, "Create New PlayList Folder", 0).Items.item
      spl(0) = fItem.path
   End If
   SaveTracks spl(0), spl(1), spl(2), spl(3), spl(4)
   
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load str_main_playlist_path & "\PlayListPaths.xml"
   Set xmlPlaylistRoot = xmlPlaylist.firstChild
   xmlPlaylistRoot.setAttribute "StoreName", spl(5)
   xmlPlaylist.Save str_main_playlist_path & "\PlayListPaths.xml"
   
   If CWinsock.LoggedType = ServerMode Then
       CWinsock.Send2Client WS_COMMAND, 0, "request_path_save_playlist&&&" & spl(1) & "&&&" & spl(5) & "&&&" & spl(0) & "\PlayLists\" & spl(1) & ".xml"
   ElseIf CWinsock.LoggedType = cloneDisplay Then
       CWinsock.Send2Server WS_COMMAND, "request_path_save_playlist&&&" & spl(1) & "&&&" & spl(5) & "&&&" & spl(0) & "\PlayLists\" & spl(1) & ".xml"
   End If
   Exit Sub
Error:
   WriteEvent "SavePlayMusicPlayer", Err.Description, Err.Source
End Sub

Public Sub current_status(obj_Swf As ShockwaveFlashObjectsCtl.ShockwaveFlash)
   On Error GoTo Error
   Dim iStatus As Integer
   If CWinsock.clientCount = 0 Then
      If CWinsock.LoggedAs(ServerMode) Then
         iStatus = 0             'not connected
         pull_out = True
      Else
         iStatus = 1             'connected(client)
      End If
   Else
      If (CWinsock.LoggedAs(ServerMode)) Then
         iStatus = 2                'connected(server)
      Else
         iStatus = 3                   'act as server( with one clients)
      End If
   End If
   sendVariable2Flash obj_Swf, "current_status", iStatus
   Exit Sub
Error:
   WriteEvent "current_status", Err.Description, Err.Source
End Sub

Public Sub check_status()
   On Error GoTo Error
   pull_out = False
   If IndexSwf <> 0 Then current_status Swf(0)
   current_status Swf(IndexSwf)
   If pull_out = True Then
       If LoadSlideshow = True Then
           sendToFlash frmSlideShow.SlideShow, "clientType", CWinsock.LoggedType
           GetSlideshowPath LanSlide, AlbumIDSlide
           sendToFlash frmSlideShow.SlideShow, "visible", "0"
       End If
       If int_track_count > 0 And CWinsock.LoggedType <> ServerMode Then
           b_play = False
           miniCommand "Play|:|true"
       End If
   End If
   
'   delete_myalbum_xml
   
   Dim i As Long
   'CopyingSong = False                   ' hide downloading bar
   If Not boolStartEncoding Then
      If UBound(EncodingQueue) >= 0 Then
         If CWinsock.getIndexServer(EncodingQueue(0).serverID) < 0 Then
            RemoveEncodeitemQueue 0
            StartConvert
         End If
      End If
   End If
   If CopyingSong And CWinsock.getIndexServer(DownloadingMusic.RemoteServer) Then CopyingSong = False
   reinput_to_playlist
   Exit Sub
Error:
   WriteEvent "check_status", Err.Description, Err.Source
End Sub
Public Sub SendAlbum2Swf(ByVal AlbumCount As Long, Parameter As String)
   On Error GoTo Error
   Dim sendYesNo As String
   If AlbumCount > 0 Then sendYesNo = "Yes" Else sendYesNo = "Non"

   sendVariable2Flash Swf(0), "StoreReloadGroup", Parameter
   sendVariable2Flash Swf(0), "ArtistLength", AlbumCount
   sendVariable2Flash Swf(0), "GetArtistAlbum", sendYesNo
   sendVariable2Flash Swf(0), "OpenFrame", "true"
   Exit Sub
Error:
   WriteEvent "SendAlbum2Swf", Err.Description, Err.Source
End Sub

Sub change_path_slideshow_mode()
   On Error GoTo Error
   Dim tmp_path_slide As String
   If slideshow_mode = "External" Then
      tmp_path_slide = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "ImageDirectory", REG_SZ)
   Else
      tmp_path_slide = internal_slideshow_path
   End If
   
   current_slideshow_path = tmp_path_slide
   SplitSly = ReplaceStrSpl(SplitSly, 0, tmp_path_slide, "~")
   
   If IndexSwf = 6 Then sendToFlash Swf(6), "setSlidePath", tmp_path_slide
   
   If CWinsock.LoggedType = ServerMode Then
      CWinsock.Send2Client WS_COMMAND, 0, "copy_xml_slideshow"
   End If
   Exit Sub
Error:
   WriteEvent "change_path_slideshow_mode", Err.Description, Err.Source
End Sub
Public Sub SearchAlbum(SearchString As String, boolUnicode As Boolean)
   On Error GoTo Error
   Dim SplSearchAlbum() As String
   Dim sortType As SortEnum
   Dim lenRe As Long
   Dim strAll  As String
   
   'boolUnicode = IIf(InStr(currentCountry, "Eng") > 0, False, True) ' sith 28/10/06 search only enlish if english
   
   'If InStr(1, currentCountry, "english", vbTextCompare) > 0 Then boolUnicode = False
   
   If GroupingReleaseDate Then sortType = stName Else sortType = stDate
   SplSearchAlbum = Split(SearchString, "&")
   'TextBox1.Text = ""
   lenRe = CSearch.SearchAlbum(Replace(SplSearchAlbum(0), "Track", "Album"), boolUnicode, val(SplSearchAlbum(1)), sortType)
   If lenRe > 0 Then
      strAll = "Yes"
      txtSearchUnicode.Visible = False
   Else
      strAll = "Found0"
      Popup_Dialog "Search", "No results found"
   End If
   
   sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
   sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
   sendVariable2Flash Swf(2), "OpenFrame", "true"
   StoreQsearch = ""
   Exit Sub
Error:
   WriteEvent "SearchAlbum", Err.Description, Err.Source
End Sub
Public Sub set_slideshow_path()
   On Error GoTo Error
    If slideshow_mode = "Internal" Then
        SplitSly = ReplaceStrSpl(SplitSly, 0, internal_slideshow_path, "~")
        current_slideshow_path = internal_slideshow_path
    Else
        SplitSly = ReplaceStrSpl(SplitSly, 0, external_slideshow_path, "~")
        current_slideshow_path = external_slideshow_path
    End If
   Exit Sub
Error:
   WriteEvent "set_slideshow_path", Err.Description, Err.Source
End Sub

Sub start_update_db(args)
   On Error GoTo Error
    Dim date_download_check As Date, date_update_check As Date
    Dim date_database_check As Date
    Dim date_download_and_update_check() As String
    
    Dim dl() As String
    dl = Split(args, "||")
    currentCountry = dl(2)
    CountryPath = get_country_path(dl(2))
    CBrowse.SetCountry currentCountry, CountryPath
    
    date_download_and_update_check = Split(args, de_Field)
    date_download_check = date_download_and_update_check(0)
    date_update_check = date_download_and_update_check(1)
    
    AddServerLink GetCDXmlPath, date_download_and_update_check(2) & "||" & date_download_and_update_check(3) & "||" & date_download_and_update_check(4)
    languageServerLink = getLanguageServer(date_download_and_update_check(2))
    date_database_check = CBrowse.GetLastUpdate
    
    Dim dateDownload As Date, dateUpdate As Date
    Dim dateDatabase As Date
    Dim dateDownloadAndUpdate() As String
    
    dateDownloadAndUpdate = Split(args, de_Field)
    dateDownload = dateDownloadAndUpdate(0)
    dateUpdate = dateDownloadAndUpdate(1)
    dateDatabase = CBrowse.GetLastUpdate
    
    If dateDownload > dateDatabase Then
        DownloadUpdateDatabase currentCountry, False
    ElseIf dateUpdate > dateDatabase Then
        lastUpdateDate = dateUpdate
        DownloadUpdateDatabase currentCountry, True
    Else
        sendVariable2Flash Swf(1), "CompletedUpdate", "true"
    End If
   Exit Sub
Error:
   WriteEvent "start_update_db", Err.Description, Err.Source
End Sub

Public Function click_minimize()
   On Error GoTo Error
    If (click_for_chage_visualization("click_minimize", False)) Then
        Exit Function
    End If
    MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height
    UnloadSwfDvdControl                   'hide dvd control
   Exit Function
Error:
   WriteEvent "click_minimize", Err.Description, Err.Source
End Function

Function save_new_playlist(str_pn, str_dn) As String
   On Error GoTo Error
    Dim doc_p As New DOMDocument
    Dim roo_p As IXMLDOMElement
    Dim ele_p As IXMLDOMElement
    Dim i As Integer
    Dim str_p As String
    Dim B As Boolean
    
    doc_p.Load str_main_playlist_path & "\PlayListPaths.xml"
    Set roo_p = doc_p.firstChild
    For i = 0 To roo_p.childNodes.Length - 1
        Set ele_p = doc_p.firstChild.childNodes(i)
        If LCase(str_dn) = LCase(ele_p.getAttribute("Name")) Then
            str_p = ele_p.Text
        End If
    Next i
    
    doc_p.Load str_p & "\PlayLists\PlayLists.xml"
    Set roo_p = doc_p.firstChild
    For i = 0 To roo_p.childNodes.Length - 1
        Set ele_p = doc_p.firstChild.childNodes(i)
        If LCase(str_pn) = LCase(ele_p.Text) Then
            B = True
        End If
    Next i
    
    If B = False Then
        Set ele_p = doc_p.createElement("PlayList")
        ele_p.setAttribute "SlidePath", ""
        ele_p.setAttribute "ImgPath", "\sly\PlaylistIcon.sly"
        ele_p.Text = str_pn
        roo_p.appendChild ele_p
        doc_p.Save str_p & "\PlayLists\PlayLists.xml"
    End If
    save_new_playlist = str_p & "\PlayLists\" & str_pn & ".xml"
   Exit Function
Error:
   WriteEvent "save_new_playlist", Err.Description, Err.Source
End Function

Public Sub reloadPlaylistPath_xml()
   On Error GoTo Error
    sendVariable2Flash Swf(3), "main_path_playlist", str_main_playlist_path
            
    sendVariable2Flash Swf(3), "TrackNames", display_track_list_type(setDisplayTrackType)
    sendVariable2Flash Swf(3), "SHTT", LCase(b_tooltip)
    sendVariable2Flash Swf(3), "Grouping", GroupingReleaseDate
    sendVariable2Flash Swf(3), "StAllCountrys", allCountry   'allPathCountry
    sendVariable2Flash Swf(3), "ComName", SlyNickName
    
    sendVariable2Flash Swf(3), "NameCon", currentCountry
    sendVariable2Flash Swf(3), "GetPath", MainPath
    sendVariable2Flash Swf(3), "MainPathImage", MainPathImage

    sendVariable2Flash Swf(3), "DisplayAlbumLong", DisplayAlbumLongPlaylist
    sendVariable2Flash Swf(3), "NoInternetConnected", NoInternetConnected
    sendVariable2Flash Swf(3), "SlideShowValue", SlideShowValue
    sendVariable2Flash Swf(3), "AppPath", App.path
    sendVariable2Flash Swf(3), "WideScreen", ScreenType
    sendVariable2Flash Swf(3), "StNumMovie", GetAttSetting(0, "PlayListAlbumNum")
    sendVariable2Flash Swf(3), "getSplitSt", SplitColor
    sendVariable2Flash Swf(3), "IsRegistered", b_reg
    sendVariable2Flash Swf(3), "OpenFrame", "true"
    sendToFlash Swf(3), "default", str_infoPopup
    sendToFlash Swf(3), "clientType", CWinsock.LoggedType
   Exit Sub
Error:
   WriteEvent "reloadPlaylistPath_xml", Err.Description, Err.Source
End Sub

Public Sub display_seek_in_player(Optional swfind As String)
   On Error GoTo Error
    Dim tmp_concate As String
    If txtCurrent = "" Then txtCurrent = "00:00"
    If txtLength = "" Then txtLength = "00:00"
    If txtSeek = "" Then txtSeek = "0"
    tmp_concate = "%%" & txtCurrent & "%%" & txtLength
    
    
   If LoadSlideshow = True Then
      sendToFlash frmSlideShow.SlideShow, "player_info", "Error" & tmp_concate
   Else
      If str_swfNames = "" Then
         If swfind = "" Then
            sendToFlash Swf(IndexSwf), "player_info", txtSeek & tmp_concate
         Else
            sendToFlash Swf(0), "player_info", txtSeek & tmp_concate
         End If
      End If
    End If
   Exit Sub
Error:
   WriteEvent "display_seek_in_player", Err.Description, Err.Source
End Sub
Sub Popup_Dialog(Title As String, Text As String)
   Dim str_Send  As String
   Dim popup_color  As String
   
      popup_color = bar_color & "%%" & button_color & "%%" & text_color & "%%"
      str_Send = popup_color & Title & "%%" & Text & "%%" & "None above"
      If LoadSlideshow = True Then
         sendToFlash frmSlideShow.SlideShow, "popup_connect", str_Send
      Else
         If str_swfNames = "" Then
            sendToFlash Swf(IndexSwf), "popup_connect", str_Send
         ElseIf str_swfNames = "Fullscreen" Then
            sendToFlash SWF_FMA(1), "popup_connect", str_Send
         End If
      End If
End Sub
Sub popup_connected(name_and_type As String, bool_connect As Boolean)
   On Error GoTo Error
   Dim ns() As String
   Dim popup_color As String
   Dim str_Send As String
   
   ns = Split(name_and_type, "%%")
   If ns(0) <> "" Then
      popup_color = bar_color & "%%" & button_color & "%%" & text_color & "%%"
      str_Send = popup_color & name_and_type & "%%" & bool_connect
      
      If LoadSlideshow = True Then
         sendToFlash frmSlideShow.SlideShow, "popup_connect", str_Send
      Else
         If str_swfNames = "" Then
            sendToFlash Swf(IndexSwf), "popup_connect", str_Send
         ElseIf str_swfNames = "Fullscreen" Then
            sendToFlash SWF_FMA(1), "popup_connect", str_Send
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "popup_connected", Err.Description, Err.Source
End Sub

Sub delete_myalbum_xml()
   On Error GoTo Error
   Dim i As Integer
   Dim loc_Path As String
   For i = 0 To UBound(CountriesList)
      loc_Path = CountriesList(i).path & "\MyAlbum.xml"
      If isFileExist(loc_Path) Then DeleteFile loc_Path
   Next
   If IndexSwf <> 1 Then
       sendToFlash Swf(0), "refresh_myalbum", "true"
   End If
   Exit Sub
Error:
   WriteEvent "showPopupFullPlayer", Err.Description, Err.Source
   Resume Next
End Sub

Public Function killInternetTemp()
    On Error Resume Next
    Dim path As String
    Dim i As Integer
    Dim j As Integer
    Dim fso As New FileSystemObject
    
    path = GetTemporaryInternetFilesFolder & "\Content.IE5\"
    Dir1.path = path

    For i = 0 To Dir1.ListCount - 1
      File1.path = Dir1.List(i)
      For j = 0 To File1.ListCount - 1
         fso.DeleteFile File1.path & "\" & File1.List(j)
      Next
    Next
   Exit Function
''''Error:
''''   WriteEvent "killInternetTemp", Err.Description, Err.Source
''''   Resume Next
End Function

Sub send_login_type_to_client()
   On Error GoTo Error
    Dim sss As String
    sss = "receive_login_Type&&&"
    sss = sss & tmp_type_display_playback & "~"
    sss = sss & tmp_type_playback_only & "~"
    sss = sss & tmp_type_independent
    
   If CInt(num_display_client) = CInt(num_display) Then
      sss = sss & store_list_index
   Else
      sss = sss & 0
   End If
   sss = sss & tmp_type_remotecontrol
   CWinsock.sendToServerNotConnected index_of_client_login, sss & "~" & store_list_index
   Exit Sub
Error:
   WriteEvent "send_login_type_to_client", Err.Description, Err.Source
End Sub

Sub receive_permission_from_PHP(sss As String)
   On Error GoTo Error
    Dim p_arr() As String
    p_arr = Split(sss, ",")
    
    tmp_type_display_playback = p_arr(0) = "true"
    tmp_type_playback_only = p_arr(1) = "true"
    tmp_type_independent = p_arr(2) = "true"
    'tmp_type_independent = p_arr(2) = "true"
    tmp_type_syn_volume = p_arr(3) = "true"
    tmp_type_copy_slideshow = p_arr(4) = "true"
    tmp_type_syn_slideshow = p_arr(5) = "true"
   Exit Sub
Error:
   WriteEvent "receive_permission_from_PHP", Err.Description, Err.Source
End Sub

Public Sub start_allow_client_connect(per As String)
   On Error GoTo Error
    Dim index As Integer
    index = index_of_client_login
    b_busy = False
    CWinsock.sendToServerNotConnected index, "receive_allow_from_server&&&" & per
   Exit Sub
Error:
   WriteEvent "start_allow_client_connect", Err.Description, Err.Source
End Sub

Sub display_allow_connect(Value As String)
On Error GoTo Error
    Dim ss As String
    ss = Value
    ss = ss & "::" & bar_color & "::" & text_color & "::" & button_color & "::" & button_alpha
    ss = ss & "::" & button_color_selected & "::" & button_alpha_selected
    
    If LoadSlideshow = True Then
        sendVariable2Flash frmSlideShow.SlideShow, "request_new_connection", ss
    Else
        If str_swfNames = "" Or str_swfNames = "Micro" Then
            sendVariable2Flash Swf(IndexSwf), "request_new_connection", ss
        ElseIf str_swfNames = "Fullscreen" Then
            sendVariable2Flash SWF_FMA(1), "request_new_connection", ss
        End If
    End If
   Exit Sub
Error:
   WriteEvent "display_allow_connect", Err.Description, Err.Source
End Sub

Public Sub server_deny()
   On Error GoTo Error
    Dim index As Integer
    index = index_of_client_login
    CWinsock.sendToServerNotConnected index, "server_deny&&&true"
   Exit Sub
Error:
   WriteEvent "server_deny", Err.Description, Err.Source
End Sub

Public Sub closeScreenPlayer()
   On Error GoTo Error
   Dim loc_CloseTop As Long
   Dim loc_CloseBottom As Long
   
   loc_CloseTop = Abs(ScaleY(close_player_top, vbPixels, vbTwips))
   loc_CloseBottom = Abs(ScaleY(close_player_buttom, vbPixels, vbTwips))
   
   blank_top.Move 0, 0, picwmp.Width, loc_CloseTop
   blank_buttom.Move 0, picwmp.Height - loc_CloseBottom, picwmp.Width, loc_CloseBottom
   blank_top.ZOrder 0
   blank_buttom.ZOrder 0
   If bool_full_vis Then
      blank_buttom.Visible = (loc_CloseBottom > 0)                   'can't set object height to less than 14 twips
      blank_top.Visible = (loc_CloseTop > 0)                         'can't set object height to less than 14 twips
   End If
   If picDVD.Visible Then picDVD.ZOrder 0
   Exit Sub
Error:
   WriteEvent "closeScreenPlayer", Err.Description, Err.Source
End Sub

Function blankScreen(bool As Boolean)
   On Error GoTo Error
    blank_top.Visible = bool And (close_player_top > 0)
    blank_buttom.Visible = bool And (close_player_buttom > 0)
    If bool Then
        blank_top.ZOrder 0
        blank_buttom.ZOrder 0
    End If
    If picDVD.Visible Then picDVD.ZOrder 0
   Exit Function
Error:
   WriteEvent "blankScreen", Err.Description, Err.Source
End Function

Sub storeOriginalLength()
On Error GoTo Error
    ori_player_top = ScaleY(picwmp.top, vbTwips, vbPixels)
    ori_player_left = ScaleX(picwmp.left, vbTwips, vbPixels)
    ori_player_width = ScaleX(picwmp.Width, vbTwips, vbPixels)
    ori_player_height = ScaleY(picwmp.Height, vbTwips, vbPixels)
    If bool_full_vis = False Then old_player_height = ori_player_height
   Exit Sub
Error:
   WriteEvent "storeOriginalLength", Err.Description, Err.Source
End Sub

Sub keySelectChapter(str_ind As String, all_chapter As String)
   On Error GoTo Error
   If Len(str_ind) < 5 Then
      If all_chapter <> "" And CLng(str_ind) <= CPlayer.chapterCount And str_ind > 0 Then
         Dim arr() As String
         Dim chap() As String
         Dim args As String
         arr = Split(all_chapter, "&&&")
         If CInt(str_ind) - 1 <= UBound(arr) Then
             chap = Split(arr(CInt(str_ind) - 1), "||")
             args = chap(0) & "||" & chap(2)
             
             Dim splitJump() As String
             splitJump = Split(args, "||")
             If int_track_count > 0 Then
               MsgBox "keySelectChapter"
'''               If CPlayer.UrlExtension = "ifo" Then
'''                  CMediaPlayer.JumpToChapter splitJump(0), ""
'''               Else
'''                  CMediaPlayer.JumpToChapter splitJump(0), val(splitJump(1))
'''               End If
             End If
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "keySelectChapter", Err.Description, Err.Source
End Sub

Public Sub BlankingTop(args As Long)
   On Error GoTo Error
    If int_track_count > 0 Then
       With PlayTrackInfo(int_current_index)
         .BlankTop = args
         If .Mode = "Internal" Then
            SetAlbumField .albumID, "BlankTop", args, .Language
         End If
      End With
      closeScreenPlayer
      If picDVD.Visible Then picDVD.ZOrder 0
   End If
   Exit Sub
Error:
   WriteEvent "BlankingTop", Err.Description, Err.Source
End Sub
Public Sub BlankingBottom(args As Long)
   On Error GoTo Error
   If int_track_count > 0 Then
      With PlayTrackInfo(int_current_index)
         .BlankBottom = args
         If .Mode = "Internal" Then
            SetAlbumField .albumID, "BlankBottom", args, .Language
         End If
      End With
      close_player_buttom = val(args)
      closeScreenPlayer
      If picDVD.Visible Then picDVD.ZOrder 0
   End If
   Exit Sub
Error:
   WriteEvent "BlankingBottom", Err.Description, Err.Source
End Sub

Sub setColorMiniControl()
On Error GoTo Error
   Dim co As String
   co = s_text_color & "||"
   co = co & s_button_color
   co = co & "||" & s_button_color_alpha
   co = co & "||" & s_button_color_selected
   co = co & "||" & s_button_color_selected_alpha
   co = co & "||" & s_background_color
   sendVariable2Flash swfMiniControl, "mini_theme", co
   Exit Sub
Error:
   WriteEvent "setColorMiniControl", Err.Description, Err.Source
End Sub

Public Sub showPopupFullPlayer(ssss As String)
   On Error GoTo Error
   swfPopupFullPlayer.Movie = "None"
   LoadSwf swfPopupFullPlayer, App.path & "\sly\popupInfoFullPlayer.sly"
   ScaleObjectFlash swfPopupFullPlayer
   sendToFlash swfPopupFullPlayer, "colorTheme", s_text_color & "|%|" & s_color_bar
   sendToFlash swfPopupFullPlayer, "TimeDelay", CStr(run_iDelayPopup)
   sendToFlash swfPopupFullPlayer, "TrackShow", ssss
   sendToFlash swfPopupFullPlayer, "unReg", CStr(b_reg)
   Exit Sub
Error:
   WriteEvent "showPopupFullPlayer", Err.Description, Err.Source
End Sub

Sub displayTimeInPictureBox()
   On Error GoTo Error
   Dim iTop As Long
   Dim iStageWidth As Long
   Dim iStageHeight As Long
   Dim iScalePercent As Single
   Dim iWidth As Long
   Dim iHeight As Long
   LoadSwf pic_time_popup, App.path & "\sly\Time.sly"
   iStageHeight = GetFlashVar(pic_time_popup, "StageHeight")
   iStageWidth = GetFlashVar(pic_time_popup, "StageWidth")
   iScalePercent = Width / 13590
   iWidth = ScaleX(iStageWidth * iScalePercent, vbPixels, vbTwips)
   iHeight = ScaleY(iStageHeight * iScalePercent, vbPixels, vbTwips)
   If Settings.setDisplayDvdContol = "0" Then iTop = picDVD.Height - iHeight Else iTop = 0
   pic_time_popup.Move Me.Width - iWidth, iTop, iWidth, iHeight
   pic_time_popup.Visible = True
   pic_time_popup.ZOrder 0
   Exit Sub
Error:
   WriteEvent "displayTimeInPictureBox", Err.Description, Err.Source
End Sub
Private Sub rightClickPicWMP()
   On Error GoTo Error
      If getWndClass(GetActiveWindow) <> "#32770" Then   'if not browse file dialog
          If LoadSlideshow = True Then
              frmSlideShow.Timer1.Enabled = True
          ElseIf str_swfNames = "Fullscreen" Then
              'FrmMain.Fullscreen False
          ElseIf str_swfNames = "Micro" Then
             FrmMain.cmd_max_Click
          ElseIf str_swfNames <> "Micro" And bool_full_vis Then
             'scaleMicroByHeight
             FrmMain.scale_visualization_to_fullscreen True
          Else
              FrmMain.picDVD.Visible = False
              sendVariable2Flash FrmMain.Swf(IndexSwf), "RightClick", "true"
          End If
      End If
   Exit Sub
Error:
   WriteEvent "rightClickPicWMP", Err.Description, Err.Source
End Sub

Private Sub sendKeyToWMP()
  If vDeo = 0 Then
   vDeo = vDeo = FindWindowEx(picwmp.hwnd, 0, "WMPVideoWindow", vbNullString)
  End If
  Sleep 100
  SendMessageLong vDeo, WM_KEYDOWN, vbKeyEscape, 0
  SendMessageLong vDeo, WM_KEYUP, 0, 0
End Sub


'*******************************************************************************
' Function Name     :   SearchPage
' Description       :   Search page swf function
' Return Values     :   None
' Input Parameter   :   command,arg
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-23-2006           New
'*******************************************************************************
Private Sub SearchPage(command As String, args As String)
'................................search Page................................
   Dim spl() As String
   Dim stArtist As String
   Dim lenArtist As Integer
   Dim lenRe As Variant
   Dim strAll As String
   Dim SplSearchAlbum2() As String
   Dim val_Local As String
   Dim i As Integer
      If command = "StopSearch" Then
         CSearch.boolExitLoop = True
      ElseIf command = "SetSearchCountry" Then
         'Set country for searching
         val_Local = get_country_path(args)
         CSearch.SetCountry args, val_Local
         sendVariable2Flash Swf(2), "LanName", args
         sendVariable2Flash Swf(2), "iKhmer", getKhmerCountry(args)
         sendVariable2Flash Swf(2), "GetPath", get_country_path(args)
         sendVariable2Flash Swf(2), "MainPathImage", get_country_image(args)
         sendVariable2Flash Swf(2), "databaseType", CSearch.databaseType
         sendToFlash Swf(2), "SetSearchCountry", args
         sendToFlash Swf(2), "reloadSearchPage", SplitColor 'sith reload //27/10/06
      ElseIf command = "RequestCountry" Then
         val_Local = GetCountryListString
         sendVariable2Flash Swf(2), "RequestCountry", val_Local
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "DisplayArtistMode" Then
        EditSetting MainSettingXML, 0, "DisplayArtistMode", args
      ElseIf command = "Minimize" Then
         FrmMain.WindowState = 1
      ElseIf command = "SetFocus" Then
         txtSearchUnicode.SetFocus
      ElseIf command = "HideSearchBox" Then
         txtSearchUnicode.Visible = False
      ElseIf command = "RefreshMyFavAlbum" Then
            lenArtist = CBrowse.GetFavoriteAlbum
            If (lenArtist > 0) Then
               stArtist = CBrowse.GetNextAlbum(0, lenArtist)
            Else
               stArtist = "Non"
            End If
            sendVariable2Flash Swf(0), "ArtistLength", lenArtist
            sendVariable2Flash Swf(0), "GetArtistAlbum", stArtist
            sendVariable2Flash Swf(0), "OpenFrame", "true"
      ElseIf command = "ShowCountry" Then
         LoadSwfCountry 2
      ElseIf command = "SendCharToVb" Then
            If txtSearchUnicode.Visible Then txtSearchUnicode.SetFocus
            spl = Split(args, "%%")
            If UBound(spl) > 0 Then
               SendKeyPress spl(0), spl(1) = "true", spl(2) = "true", spl(3) = "true"
             End If
            DoEvents
            Swf(IndexSwf).SetFocus
      ElseIf command = "ShowPlayList" Then
            On Error Resume Next
            IndexPlaylistToLoad = 2
            Load Swf(3)
            LoadSwfPlayListPage "2"
      ElseIf command = "ShowPlayListPlayer" Then
            IndexPlayerToLoad = 2
            LoadSwfPlayListPlayerPage "2"
            ShowOrHidePlayer True
            'scale_visualization_to_fullscreen True
      ElseIf command = "ShowOption" Then
            IndexOptionToLoad = 2
            LoadSwfSettingPage "2"
      ElseIf command = "Exit" Then
         miniCommand "Stop" & "|:|" & True
         Timer2.Enabled = True
         bExitingProgram = True
      ElseIf command = "GetArtistName" Then
         sendVariable2Flash Swf(2), "GetArtistName", CSearch.GetLabel()
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "GetMood" Then
         sendVariable2Flash Swf(2), "GetMood", CSearch.GetMood()
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "GetGenre" Then
         
'''         val_Local = ""
'''         For i = 0 To UBound(CountriesList)
'''            If val_Local = "" Then
'''               val_Local = CountriesList(i).Name & "||" & CountriesList(i).Name & "||" & CountriesList(i).path
'''            Else
'''               val_Local = val_Local & "&&&" & CountriesList(i).Name & "||" & CountriesList(i).Name & "||" & CountriesList(i).path
'''            End If
'''         Next
'''         sendVariable2Flash Swf(2), "GetGenre", val_Local
'''         sendVariable2Flash Swf(2), "OpenFrame", "true"
         sendVariable2Flash Swf(2), "GetGenre", CSearch.GetGenre
         sendVariable2Flash Swf(2), "OpenFrame", "true"
         
      ElseIf command = "GetDance" Then
         sendVariable2Flash Swf(2), "GetDance", CSearch.GetDanceStyle()
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "GoBack" Then
         SearchPageGoBack
      ElseIf command = "ShowTextSearch" Then
         If args = "yes" Then
            TextBoxScale txtSearchUnicode, formWidth, formHeight, 500, 65, 76, 0
            txtSearchUnicode.Visible = True
            txtSearchUnicode.Text = StoreQsearch
            txtSearchUnicode.ZOrder
            txtSearchUnicode.SetFocus
            clsKeyboard.SetKeyBoardLanguage IIf(Language = "Eng", "English", currentCountry)
         Else
             txtSearchUnicode.Visible = False
             clsKeyboard.SetKeyBoardLanguage "English"
             'ChangeLan = "Eng"
         End If
      ElseIf command = "SendVaueGrouping" Then
         If args = "False" Then
               GroupingReleaseDate = False
         Else
            GroupingReleaseDate = True
         End If
      ElseIf command = "StartSearch" Then
         spl = Split(args, "&&&")
         lenRe = CSearch.searchDirector(spl(0))
         lenRe = CSearch.GetNextDirector(0, lenRe)
         If lenRe > 0 Then
            sendVariable2Flash Swf(2), "GetArtistNameSearch", lenRe
            txtSearchUnicode.Visible = False
         Else
            sendVariable2Flash Swf(2), "GetArtistNameSearch", "Found0"
         End If
         sendVariable2Flash Swf(2), "SelectMode", "TrackTitle"
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "StartSearchTrack" Then
         spl = Split(args, "&")
         ' Text,Artist,Mood,Dance,Genre,Rating,Available,Language
         'stSpl = Split(spl(2), "&&")
         ',singtype:=10
         'spl(8) = val(spl(8))
         If spl(8) = 0 Then
            spl(8) = -2
         ElseIf spl(8) = 1 Then
            spl(8) = 2
         ElseIf spl(8) = 2 Then
            spl(8) = 1
         ElseIf spl(8) = 3 Then
            spl(8) = 0
         End If
         Swf(2).SetVariable "ShowSearchingText", spl(0)
         Swf(2).SetVariable "ShowSearchingBox", 1
         Swf(2).SetFocus
         lenRe = CSearch.searchTrack(spl(0), val(spl(1)), 0, 0, val(spl(4)), val(spl(5)), val(spl(6)), spl(7) = "Uni", sortType:=True, SingType:=val(spl(8)), startLetter:=spl(9) = "1")
         If lenRe > 0 Then
            strAll = CSearch.GetNextTrack(0, 12)
            txtSearchUnicode.Visible = False
            sendVariable2Flash Swf(2), "LenRe", lenRe
            sendVariable2Flash Swf(2), "StResult", strAll
            sendVariable2Flash Swf(2), "OpenFrame", "true"
         Else
            Swf(2).SetVariable "ShowSearchingBox", 0
         End If
      ElseIf command = "getTextSearch" Then
         StoreQsearch = txtSearchUnicode.Text
         sendVariable2Flash Swf(2), "getTextSearch", StoreQsearch
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "StartSearchAlbum" Then
         SearchAlbum args, Language = "Uni"
      ElseIf command = "StartSearchAlbumByTrack" Then
            StoreQsearch = args
            SplSearchAlbum2 = Split(StoreQsearch, "&&")
            If GroupingReleaseDate = False Then
               lenRe = CSearch.SearchAlbum(Replace(SplSearchAlbum2(0), "Track", "Album"), False, val(SplSearchAlbum2(1)), stDate)
            Else
               lenRe = CSearch.SearchAlbum(Replace(SplSearchAlbum2(0), "Track", "Album"), False, val(SplSearchAlbum2(1)), stName)
            End If
            If lenRe > 0 Then
                strAll = "Yes"
                sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
                sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
                txtSearchUnicode.Visible = False
            Else
                sendVariable2Flash Swf(2), "AlbumLengthSearch", 0
                sendVariable2Flash Swf(2), "GetAlbumSearch", "Found0"
            End If
            sendVariable2Flash Swf(2), "OpenFrame", "true"
            StoreQsearch = ""
      ElseIf command = "StartSearchArtist" Then
         SplSearchAlbum2 = Split(args, "&")
         StoreQsearch = SplSearchAlbum2(0)               ' Save last search text unicode
         lenRe = CSearch.SearchArtist(SplSearchAlbum2(0), Language = "Uni", val(SplSearchAlbum2(1)))
         'TextBox1.Text = ""
         If Len(lenRe) > 0 Then
             sendVariable2Flash Swf(2), "GetArtistNameSearch", lenRe
             txtSearchUnicode.Visible = False
         Else
            sendVariable2Flash Swf(2), "GetArtistNameSearch", "Found0"
         End If
         sendVariable2Flash Swf(2), "SelectMode", "Artist"
         sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "SearchArtistByTrack" Then 'EDID.2006.10.19 Seng
            StoreQsearch = args
            SplSearchAlbum2 = Split(StoreQsearch, "&&")
            If SplSearchAlbum2(2) = 8 Or SplSearchAlbum2(2) = 4 Then               ' For karaoke track /search artist
               val_Local = CSearch.GetTrackField(CLng(SplSearchAlbum2(1)), "SingerIDs")
               lenRe = CSearch.SearchArtistByIDs(val_Local, Language = "Uni")
               If Len(lenRe) > 0 Then
                   sendVariable2Flash Swf(2), "GetArtistNameSearch", lenRe
                   txtSearchUnicode.Visible = False
               Else
                  sendVariable2Flash Swf(2), "GetArtistNameSearch", "Found0"
               End If
               sendVariable2Flash Swf(2), "SelectMode", "Artist"
               sendVariable2Flash Swf(2), "OpenFrame", "true"
               
            Else                                         ' for non karaoke track/search production
               val_Local = SplSearchAlbum2(0)
               If val(val_Local) > 0 Then
                  lenRe = CSearch.AlbumByLabel(LabelID:=CInt(val_Local), selectType:=All, searchMode:=True)
               Else
                  lenRe = ""
               End If
               If (Len(lenRe) > 0) Then
                  strAll = "Yes"
               Else
                  strAll = "Found0"
               End If
               sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
               sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
               sendVariable2Flash Swf(2), "OpenFrame", "true"
            End If
            
            StoreQsearch = ""
      ElseIf command = "SearchByProductionOrArtist" Then 'EDID.2006.05.10 Seng
            StoreQsearch = args
            SplSearchAlbum2 = Split(StoreQsearch, "&&")
            '2006-10-18
            'EDID:2006-07-31 Seng Error search artist in album page
            If SplSearchAlbum2(1) = 8 Or SplSearchAlbum2(1) = 4 Or SplSearchAlbum2(1) = 16 Then               ' For karaoke track /search artist
               lenRe = CSearch.SearchArtistByIDs(SplSearchAlbum2(0), Language = "Uni")
               If Len(lenRe) > 0 Then
                   sendVariable2Flash Swf(2), "GetArtistNameSearch", lenRe
                   txtSearchUnicode.Visible = False
               Else
                  sendVariable2Flash Swf(2), "GetArtistNameSearch", "Found0"
               End If
               sendVariable2Flash Swf(2), "SelectMode", "Artist"
               sendVariable2Flash Swf(2), "OpenFrame", "true"
               
            Else                                         ' for non karaoke track/search production
               val_Local = SplSearchAlbum2(0)
               If val(val_Local) > 0 Then
                  lenRe = CSearch.AlbumByLabel(LabelID:=CInt(val_Local), selectType:=All, searchMode:=True)
               Else
                  lenRe = ""
               End If
               If (Len(lenRe) > 0) Then
                  strAll = "Yes"
               Else
                  strAll = "Found0"
               End If
               sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
               sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
               sendVariable2Flash Swf(2), "OpenFrame", "true"
            End If
            
            StoreQsearch = ""
      ElseIf command = "StartSearchArtistByTrack" Then
            'change from artist to Album Mode
            StoreQsearch = args
            SplSearchAlbum2 = Split(StoreQsearch, "&&")
            lenRe = CSearch.SearchAlbumByLabel(SplSearchAlbum2(0), val(SplSearchAlbum2(1)))
            
            If (Len(lenRe) > 0) Then
               strAll = "Yes"
            Else
               strAll = "Found0"
            End If
            sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
            sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
            sendVariable2Flash Swf(2), "OpenFrame", "true"
            
            StoreQsearch = ""
      ElseIf command = "SetAlbumFavorite" Then
            spl = Split(args, "~")
            CSearch.SetAlbumFavorite val(spl(0)), val(spl(1))
            If Dir(GetLanguageLocation("MyFavAlbum.xml")) <> "" Then
               fso.DeleteFile GetLanguageLocation("MyFavAlbum.xml"), True
            End If
      ElseIf command = "SetArtistFavorite" Then
            spl = Split(args, "~")
            CSearch.SetArtistFavorite val(spl(0)), val(spl(1))
            If Dir(GetLanguageLocation("MyFavArtist.xml")) <> "" Then
               fso.DeleteFile GetLanguageLocation("MyFavArtist.xml"), True
            End If
      ElseIf command = "ChangeRankValue" Then
            spl = Split(args, "~")
            CSearch.SetArtistRating val(spl(0)), val(spl(1))
      ElseIf command = "ChangeRankValueAlbum" Then
            spl = Split(args, "~")
            CSearch.SetAlbumRank val(spl(0)), val(spl(1))
            
      ElseIf command = "GetArtistAlbum" Or command = "GetDirectorAlbum" Or command = "GetArtistTrack" Then
               spl = Split(args, "~")
               'if sort by release date
               If command = "GetArtistAlbum" Then
                  lenRe = CSearch.AlbumByArtist(val(spl(0)), val(spl(1)), IIf(GroupingReleaseDate, stDate, stName), , , True)
               ElseIf command = "GetArtistTrack" Then
                  sendToFlash Swf(2), "hideBack", "" 'sith
                  SplSearchAlbum2 = Split(CSearch.GetActorName(spl(0), True), "%%")
                  
                 ' val_Local = SplSearchAlbum2(0)
                  If Language = "Uni" Then
                     val_Local = IIf(SplSearchAlbum2(1) <> "", SplSearchAlbum2(1), SplSearchAlbum2(0))
                  Else
                     If SplSearchAlbum2(0) = "" Then val_Local = SplSearchAlbum2(0)
                     val_Local = IIf(SplSearchAlbum2(0) <> "", SplSearchAlbum2(0), SplSearchAlbum2(1))
                  End If
                  Swf(2).SetVariable "ShowSearchingText", val_Local
                  Swf(2).SetVariable "ShowSearchingBox", 1
                  'sith 21/10/06
                  Swf(2).Visible = True
                  Swf(2).ZOrder 0
                  Swf(0).Visible = False
                  '===
                  lenRe = CSearch.searchTrack("", Rating:=val(spl(2)), Available:=val(spl(1)), SingerID:=val(spl(0)))
                  If lenRe > 0 Then
                     strAll = CSearch.GetNextTrack(0, 12)
                     sendVariable2Flash Swf(2), "LenRe", lenRe
                     sendVariable2Flash Swf(2), "StResult", strAll
                     sendVariable2Flash Swf(2), "OpenFrame", "true"
                  End If
                     ' strAll = "Found0"
                  Swf(2).SetVariable "ShowSearchingBox", 0
                  
                  Exit Sub
               End If
               If (Len(lenRe) > 0) Then
                  strAll = "Yes"
               Else
                  strAll = "Found0"
               End If
               sendVariable2Flash Swf(2), "AlbumLengthSearch", lenRe
               sendVariable2Flash Swf(2), "GetAlbumSearch", strAll
               sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "GetAlbumByIndex" Then
            spl = Split(args, "~")
            strAll = CSearch.GetNextAlbum(val(spl(0)), val(spl(1)), True)
            sendVariable2Flash Swf(2), "ShowAlbumPic", spl(2)
            sendVariable2Flash Swf(2), "ResultAlbumName", strAll
            sendVariable2Flash Swf(2), "OpenFrame", "true"
      ElseIf command = "getNextResult" Then
            strAll = CSearch.GetNextTrack(val(args), 12)
            sendVariable2Flash Swf(2), "StResult", strAll
            sendVariable2Flash Swf(2), "OpenFrame", "true"
      '....................PlayTrack..........................
      ElseIf command = "SaveInPlayer" Then
         StPlayer = args
         ModePlay = "0"
         NameCountryPlay = currentCountry
      ElseIf command = "SetRating" Then
         spl = Split(args, "~")
         SetTrackField spl(0), "Rating", spl(1)
      ElseIf command = "AdvSearch" Then
         EditSetting MainSettingXML, 0, "AdvSearch", args
         SplitColor = ReplaceStrSpl(SplitColor, 12, args, "~")
      ElseIf command = "SaveSearchAvailable" Then
         EditSetting MainSettingXML, 0, "SaveSearchAvailable", val(args)
      ElseIf command = "Gender" Then
         EditSetting MainSettingXML, 0, "Gender", val(args)
      ElseIf command = "ModeSearch" Then
         EditSetting MainSettingXML, 0, "ModeSearch", args
         SplitColor = ReplaceStrSpl(SplitColor, 17, args, "~")
      ElseIf command = "PlayModeSearch" Then
         EditSetting MainSettingXML, 0, "PlayModeSearch", args
         SplitColor = ReplaceStrSpl(SplitColor, 15, args, "~")
      End If
      '.................................Endif.......................................
End Sub
'For search page
Private Function GetCountryListString() As String
   Dim i As Integer
   Dim val_Local As String
   Dim Country_List() As Variant
   Dim count As Integer
   For i = 0 To UBound(CountriesList)
      ReDim Preserve Country_List(-1 To count)
      'ID,Name,Unicode,Database Path,Image Path
      Country_List(count) = Array(CountriesList(i).Name, CountriesList(i).Name, "", CountriesList(i).path, CountriesList(i).Image)
      count = count + 1
   Next
   If count > 1 Then
      QuickSort Country_List, Array(0)
   End If
   For i = 0 To count - 1
      If val_Local = "" Then
         val_Local = Join(Country_List(i), "||")
      Else
         val_Local = val_Local & "&&&" & Join(Country_List(i), "||")
      End If
   Next
   GetCountryListString = val_Local
End Function

Public Sub loadFlashFullScreen(bLoad As Boolean)
    Static dfType As String
    If int_track_count > 0 Then
        If bLoad Then
            Dim ddd() As String
            ddd = Split(server_display_page, "%%%")
            If UBound(ddd) < 2 Then
                dfType = server_display_page
                server_display_page = server_display_page & "%%%" & "Fullscreen"
            End If
            
            If str_swfNames <> "Fullscreen" Then load_fullscreen_micro_ads "Fullscreen", 1
            
            get_track_info
            
            SWF_FMA(1).Move 0, 0, formWidth, formHeight
            SWF_FMA(1).ZOrder 0
            
            theme SWF_FMA(1)
            sendToFlash SWF_FMA(1), "visType", CStr(CPlayer.PlayWith)
            sendToFlash SWF_FMA(1), "ads", CStr(b_ads)

            sendToFlash SWF_FMA(1), "displayFullscreen", "true"
            
            
            display_seek_in_player
         Else
            s_display_type = "Visual"
            SWF_FMA(1).Visible = False
            unload_fullscreen_micro_ads 1
            str_swfNames = ""
            scale_visualization_to_fullscreen True
            
         End If 'bLoad
         
   End If 'int_track_count
End Sub
