VERSION 5.00
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Internalplayer 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3660
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6945
   Icon            =   "Internalplayer.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3660
   ScaleWidth      =   6945
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfAds 
      Height          =   675
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Visible         =   0   'False
      Width           =   1500
      _cx             =   2646
      _cy             =   1191
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
      MovieData       =   ""
   End
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   0
      Top             =   960
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfMicro 
      Height          =   675
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Visible         =   0   'False
      Width           =   2175
      _cx             =   3836
      _cy             =   1191
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
      MovieData       =   ""
   End
   Begin VB.Timer tmr1 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   450
      Top             =   0
   End
   Begin VB.Timer tmr 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   0
      Top             =   0
   End
   Begin MSComDlg.CommonDialog cdl 
      Left            =   0
      Top             =   480
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      Orientation     =   2
   End
   Begin VB.PictureBox picInternalPlay 
      BackColor       =   &H80000007&
      BorderStyle     =   0  'None
      Height          =   3180
      Left            =   0
      ScaleHeight     =   3180
      ScaleWidth      =   7005
      TabIndex        =   1
      Top             =   0
      Width           =   7005
      Begin VB.CommandButton cmdFull 
         Height          =   390
         Left            =   6480
         Picture         =   "Internalplayer.frx":08CA
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   2640
         Width           =   390
      End
      Begin VB.PictureBox frm 
         Appearance      =   0  'Flat
         BackColor       =   &H80000007&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2225
         Index           =   0
         Left            =   4670
         ScaleHeight     =   2220
         ScaleWidth      =   2220
         TabIndex        =   4
         Top             =   840
         Width           =   2225
         Begin WMPLibCtl.WindowsMediaPlayer wmp 
            Height          =   2230
            Left            =   0
            TabIndex        =   5
            Top             =   0
            Width           =   2230
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
            volume          =   75
            mute            =   0   'False
            uiMode          =   "none"
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
            _cx             =   3942
            _cy             =   3942
         End
      End
      Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfInternalPlay 
         Height          =   3135
         Left            =   0
         TabIndex        =   2
         Top             =   0
         Width           =   6930
         _cx             =   12224
         _cy             =   5530
         FlashVars       =   ""
         Movie           =   " "
         Src             =   " "
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
         MovieData       =   ""
      End
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfFull 
      Height          =   1995
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1995
      _cx             =   3528
      _cy             =   3528
      FlashVars       =   ""
      Movie           =   " "
      Src             =   " "
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
      MovieData       =   ""
   End
End
Attribute VB_Name = "Internalplayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Play As Boolean
Dim i As Integer
Dim SSHN As Boolean
Dim LSHN As Boolean

Dim typeFull As String
Public Resize As Boolean
Dim strScrollFull As String     ' For return string when click fullscreen
Dim DVolume As Integer
Dim tmpWidth As Integer         ' store temp width interplayer
Dim tmpHeight As Integer        ' store temp height interplayer
Dim tmpTop As Integer           ' store temp top interplayer
Dim tmpLeft As Integer          ' store temp left interplayer
Dim tmpHF As Integer
Dim tmpWF As Integer
Dim STP As Boolean              ' return index track playing for selected playlist
Dim CL As String                ' for change language for fullscreen
Dim Sp() As String
Dim NC As Boolean
Dim enTimer As String           ' store for permit timer open or not
Dim ret As Long

Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOSIZE = &H1
Dim ScrVal As Integer
Public vi As Boolean

' variable for micro-player
Dim boolLooping As Boolean

Private Sub Command1_Click()
    MsgBox wmp.Status
End Sub

Private Sub Form_Deactivate()
    ShowPlayer
End Sub

Private Sub Form_GotFocus()
'    FrmMain.SetFocus
End Sub

Private Sub Form_Load()
  wmp.EnableContextMenu = False
  Me.swfInternalPlay.Movie = App.path & "\swf\Internalplay.swf"
  Me.swfFull.Movie = App.path & "\swf\FullScreen.swf"
  swfMicro.Movie = App.path & "\swf\Micro.swf"
  swfAds.Movie = App.path & "\swf\Ads.swf"
  ret = SetWindowPos(hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
  ScrVal = 1
  vi = True
  
End Sub


Private Sub Form_Paint()
    If swfMicro.Visible = True Then
        Resize_Form formWidth, formHeight
    End If
End Sub

Private Sub swfAds_FSCommand(ByVal command As String, ByVal args As String)
   'if command
End Sub

Public Sub swfFull_FSCommand(ByVal command As String, ByVal args As String)
    ' cmdCloseFullScreen
    
      
    If command = "SHFull" Then
        Me.swfFull.Visible = False
        Me.swfInternalPlay.Visible = True
        ret = SetWindowPos(hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
        Resize_Form formWidth, formHeight
        picInternalPlay.Visible = True
        cmdFull.Visible = True
        FrmMain.Form_Paint
        
        If Mode = "FullMode" Then
            Internalplayer.left = formWidth - Internalplayer.Width
            Internalplayer.Top = formHeight - Internalplayer.Height
        Else
            Internalplayer.left = (FrmMain.left + FrmMain.Width) - Internalplayer.Width - 45 'formWidth  - Internalplayer.Width
            Internalplayer.Top = (FrmMain.Top + FrmMain.Height) - Internalplayer.Height - 45 'formHeight - Internalplayer.Height
        End If
        
    ' cmdNext
    ElseIf command = "Next" Then
        swfInternalPlay_FSCommand "Next", args
      
    ' cmdPrevious
    ElseIf command = "Previous" Then
        swfInternalPlay_FSCommand "Previous", args
        
    ' Pause
    ElseIf command = "Pause" Then
    swfInternalPlay_FSCommand "Pause", args

    ' Play
    ElseIf command = "Play" Then
        swfInternalPlay_FSCommand "Play", args
        
    ' Stop
    ElseIf command = "Stop" Then
        swfInternalPlay_FSCommand "Stop", args

    ' Loop
    ElseIf command = "Loop" Then
        'swfInternalPlay_FSCommand "Loop", args
        Me.swfInternalPlay.SetVariable "setLoop", args
        Me.swfInternalPlay.SetVariable "LoopStop", "true"
        
    ' Shuffle
    ElseIf command = "Shuffle" Then
        'swfInternalPlay_FSCommand "Shuffle", args
        Me.swfInternalPlay.SetVariable "setShuffle", args
        Me.swfInternalPlay.SetVariable "ShuffleStop", "true"
        
    ' Mute
    ElseIf command = "Mute" Then
        swfInternalPlay_FSCommand "Mute", args
        Me.swfInternalPlay.SetVariable "setMute", args
        Me.swfInternalPlay.SetVariable "MuteStop", "true"

    ' seek
    ElseIf command = "seek" Then
        swfInternalPlay_FSCommand "seek", args

    ' Volume
    ElseIf command = "Volume" Then
        Me.swfInternalPlay.SetVariable "defaultVol", args
        Me.swfInternalPlay.SetVariable "refreshVolume", "true"
    ' Finish
    ElseIf command = "Finish" Then
    
    ' Scann file
    ElseIf command = "ScanFile" Then
        If (Dir(args) <> "") Then
            sendVariables swfFull, "openScanFile", "strScanFile", "true"
        Else
            sendVariables swfFull, "openScanFile", "strScanFile", "false"
        End If
'' Playlist
  ElseIf command = "Playlist" Then
    swfInternalPlay_FSCommand "Playlist", "True"
'' Add More file
  ElseIf command = "MoreFile" Then
    swfInternalPlay_FSCommand "MoreFile", "True"

'' SetSlideShow
  ElseIf command = "SetSlideShow" Then
    If args = "Yes" Then
        FrmMain.Timer1.Interval = 1000
    Else
         FrmMain.Timer1.Interval = 0
    End If
    sendVariables swfMicro, "openSlideShow", "strSlideShow", args
    EditSetting App.path & "\Swf\setting.xml", 1, "SetSlideShow", args
    FrmMain.SplitSly = ReplaceStrSpl(FrmMain.SplitSly, 1, args, "~")
    If IndexSwf = 6 Then
      FrmMain.Swf(6).SetVariable "GetColorReady", "true"
      FrmMain.Swf(6).SetVariable "SetSlideShowValue", "true"
      FrmMain.Swf(6).SetVariable "OpenFrame", "true"
    End If
    ElseIf command = "ChangeLanguage" Then
      If language = "Eng" Then
        FrmMain.Swf_FSCommand 0, "ChangeLanguage", "Uni"
        sendVariables swfFull, "openInfo", "strInfo", infoFullscreen("Uni", Me.wmp.currentMedia.getItemInfo("track") - 1)
      Else
         FrmMain.Swf_FSCommand 0, "ChangeLanguage", "Eng"
         sendVariables swfFull, "openInfo", "strInfo", infoFullscreen("Eng", Me.wmp.currentMedia.getItemInfo("track") - 1)
      End If
      
        Me.swfFull.SetVariable "Info", "True"
        'FrmMain.SetFocus
  ElseIf command = "mb" Then
    MsgBox "MsgBox :  " & args
  End If
End Sub

Private Sub swfMicro_FSCommand(ByVal command As String, ByVal args As String)
    Select Case command
        Case "Play"
            swfFull_FSCommand "Play", args
        Case "Pause"
            swfFull_FSCommand "Pause", args
        Case "Stop"
            swfFull_FSCommand "Stop", args
        Case "Previous"
            swfFull_FSCommand "Previous", args
        Case "Next"
            swfFull_FSCommand "Next", args
        Case "SlideShow"
            swfFull_FSCommand "SetSlideShow", args
        Case "Loop"
            swfFull_FSCommand "Loop", args
        Case "Shuffle"
            swfFull_FSCommand "Shuffle", args
        Case "Mute"
            swfFull_FSCommand "Mute", args
        Case "Volume"
            swfFull_FSCommand "Volume", args
        Case "Seek"
            If wmp.currentPlaylist.count > 0 Then
                args = (Me.wmp.currentMedia.Duration * args) / 95
                Me.wmp.Controls.CurrentPosition = args
            End If
        Case "MouseOver"
'            MouseMove
            boolLooping = True
        Case "Maximize"
            If minimizeInScan = True Then
               minimizeInScan = False
                If DisplayMini = 1 Then
                    CScan = True
                    DisplayMini = 0
                End If
                If Mode = "FullMode" Then
                    FrmMain.WindowState = 2
                Else
                    FrmMain.WindowState = 0
                End If
                frmScan.Visible = True
            Else
                If Mode = "FullMode" Then
                    FrmMain.WindowState = 2
                Else
                    FrmMain.WindowState = 0
                End If
            End If
            swfAds.Visible = False
        Case "mb"
            MsgBox args
    End Select
End Sub

Private Sub Timer1_Timer()
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
'case micro show
   Dim xy As POINTAPI, pt As POINTAPI, out As Boolean
   Dim ptLeft As Integer, ptTop As Integer, ptHeight As Integer, ptWidth As Integer
   
   
'   boolLooping = True
'   Do
   If boolLooping Then
      ptLeft = left / 15: ptTop = Top / 15: ptWidth = Width / 15: ptHeight = Height / 15
      GetCursorPos xy
      out = (ptLeft > xy.X Or ptLeft + ptWidth < xy.X) Or (ptTop > xy.y Or ptTop + ptHeight < xy.y)
      If out Then
         boolLooping = False
         sendVariables swfMicro, "openMouseOut", "strMouseOut", "true"
      End If
   End If
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
'this section for lost focus
      Dim myHwnd As Long
      If boolInside And (FrmMain.WindowState <> vbMinimized) Then
         myHwnd = GetForegroundWindow()
         If (myHwnd <> hwnd) And (myHwnd <> FrmMain.hwnd) Then
            If swfFull.Visible = True Then
                swfFull_FSCommand "SHFull", True
            End If
            Me.Visible = False
            boolInside = False
            AltTab = True
         End If
      End If
   'end-----------------------------------------
End Sub

Private Sub tmr_Timer()
      
      
    If wmp.Status = "Stopped" Or wmp.Status = "Ready" Then
        swfInternalPlay_FSCommand "Stop", True
    End If
    
    On Error Resume Next
    If Play = True Then
  
        If ScrVal = 0 Then
            If Me.wmp.fullScreen = False Then
                Me.swfInternalPlay.SetFocus
                ScrVal = 1
            End If
        End If
        
    '***************
    'fullscreen show
    '***************
        If Me.swfFull.Visible = True Then
            Me.swfFull.SetVariable "vseek", (300 * Me.wmp.Controls.CurrentPosition) / Me.wmp.currentMedia.Duration   ' return seek
            Me.swfFull.SetVariable "timeString", "/" & Me.wmp.currentMedia.durationString     ' return time media
            Me.swfFull.SetVariable "time", Me.wmp.Controls.currentPositionString              ' return time media playing
            
            '* send text scrolling to fullscreen when end of music*'
            If tmpTrack <> Me.wmp.currentMedia.getItemInfo("track") - 1 Then
                
                If Me.wmp.currentPlaylist.count <> 0 Then
                    sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
                    Me.nextTrack
                    STP = True
                End If
                    
                cutString TRACK(Int(Me.wmp.currentMedia.getItemInfo("track")) - 1).trackPath
                
                tmpTrack = Me.wmp.currentMedia.getItemInfo("track") - 1
                
                FrmMain.Swf(4).SetVariable "ChangeTrack", tmpTrack
                FrmMain.Swf(4).SetVariable "OpenFrame", "true"
                
                sendVariables swfFull, "openInfo", "strInfo", infoFullscreen(language, Me.wmp.currentMedia.getItemInfo("track") - 1)
                'sendTrackInfoNextAndPreviouse
            End If
    
    '***************
    'Internal show
    '***************
        ElseIf swfInternalPlay.Visible = True Then
            Me.swfInternalPlay.SetVariable "time", Me.wmp.Controls.currentPositionString              ' return time media playing
            Me.swfInternalPlay.SetVariable "timeString", "/" & Me.wmp.currentMedia.durationString     ' return time media
            Me.swfInternalPlay.SetVariable "vseek", (300 * Me.wmp.Controls.CurrentPosition) / Me.wmp.currentMedia.Duration   ' return seek
            Me.swfInternalPlay.SetVariable "Volume", "false"
            
            '* send text scrolling to fullscreen when end of music *'
            If tmpTrack <> Me.wmp.currentMedia.getItemInfo("track") - 1 Then
                If Me.wmp.currentPlaylist.count <> 0 Then
                    sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
                    Me.nextTrack
                End If
                
                cutString TRACK(Int(Me.wmp.currentMedia.getItemInfo("track")) - 1).trackPath
                
                tmpTrack = Me.wmp.currentMedia.getItemInfo("track") - 1
                
                FrmMain.Swf(4).SetVariable "ChangeTrack", tmpTrack
                FrmMain.Swf(4).SetVariable "OpenFrame1", "true"
                
            End If
    '***************
    'Micro Show
    '***************
        ElseIf swfMicro.Visible = True Then
            Me.swfMicro.SetVariable "vseek", (95 * Me.wmp.Controls.CurrentPosition) / Me.wmp.currentMedia.Duration   ' return seek
            Me.swfMicro.SetVariable "time", Me.wmp.Controls.currentPositionString              ' return time media playing
            
            If tmpMTrack <> Me.wmp.currentMedia.getItemInfo("track") - 1 Then
                sendVariables swfMicro, "openTimeString", "strTimeString", Me.wmp.currentMedia.durationString            ' return time media

                If Me.wmp.currentPlaylist.count <> 0 Then
                    sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
                    Me.nextTrack
                End If
                
                cutString TRACK(Int(Me.wmp.currentMedia.getItemInfo("track")) - 1).trackPath
                
                tmpMTrack = Me.wmp.currentMedia.getItemInfo("track") - 1
                
                Dim Ar() As String
                Dim j As Integer
                Dim strImg As String
                Ar = Split(wmp.currentMedia.sourceURL, "\")
                For j = LBound(Ar) To UBound(Ar) - 1
                    strImg = strImg + "\" + Ar(j)
                Next j
                strImg = Right(strImg, Len(strImg) - 1) & "\folder.jpg"
                If (Dir(strImg) <> "") Then
                    sendVariables swfMicro, "openImage", "strImage", strImg
                    sendVariables swfAds, "openPath", "strPath", strImg
                Else
                    sendVariables swfMicro, "openImage", "strImage", "N"
                    sendVariables swfAds, "openPath", "strPath", ""
                End If
            End If
        End If
    End If
End Sub

Public Sub swfInternalPlay_FSCommand(ByVal command As String, ByVal args As String)

    'On Error GoTo Out
    ' Play
    If command = "KeyPressed" Then
         interValCount = 0
         FrmMain.SetFocus
         
    ElseIf command = "Play" Then
        If wmp.currentPlaylist.count > 0 Then
            Play = True
            Me.wmp.Controls.Play
            Me.tmr.Enabled = True
            sendVariables swfMicro, "openPlay", "strPlay", "true"
            sendVariables swfFull, "openPlay", "strPlay", "true"
            Me.swfInternalPlay.SetVariable "seeks", "true"
            interValCount = 0
            FrmMain.SetFocus
        
            If enTimer = "tmr1" Then
                enTimer = ""
                tmr1.Enabled = True
            ElseIf enTimer = "tmr" Then
                If wmp.currentPlaylist.count > 0 Then
                    sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
                    nextTrack
                    enTimer = ""
                    tmr.Enabled = True
                End If
            End If
        
            If Internalplayer.Visible = False Then
                Internalplayer.Visible = True
                FrmMain.SetFocus
            End If
        
            If Me.wmp.currentPlaylist.count < 3 Then
                On Error Resume Next
                sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
                nextTrack
            End If
            If Me.wmp.currentPlaylist.count > 0 Then
                If Me.wmp.currentMedia.getItemInfo("track") + 1 = Me.wmp.currentPlaylist.count Then nextTrack
            End If
            
        Else
            sendVariables swfMicro, "openStop", "strStop", True
            sendVariables swfFull, "openStop", "strStop", True
        End If
            
    ElseIf command = "Visible" Then
         Me.Visible = False
    ' Pause
    ElseIf command = "Pause" Then
        Me.tmr.Enabled = False
        Me.wmp.Controls.Pause
        Me.swfInternalPlay.SetVariable "seeks", "false"
        sendVariables swfMicro, "openPause", "strPause", True
        sendVariables swfFull, "openPause", "strPause", True
        FrmMain.SetFocus
        interValCount = 0
        
        If tmr1.Enabled = True Then
            tmr1.Enabled = False
            enTimer = "tmr1"
        ElseIf tmr.Enabled = False Then
            tmr.Enabled = False
            enTimer = "tmr"
        End If
    ' Stop
    ElseIf command = "Stop" Then
        Play = False
        Me.wmp.Controls.Stop
        Me.tmr.Enabled = False
        Me.swfInternalPlay.SetVariable "seeks", "false"
        sendVariables swfMicro, "openStop", "strStop", True
        sendVariables swfFull, "openStop", "strStop", True
        FrmMain.SetFocus
        interValCount = 0
        
        If tmr1.Enabled = True Then
            tmr1.Enabled = False
            enTimer = "tmr1"
        ElseIf tmr.Enabled = False Then
            tmr.Enabled = False
            enTimer = "tmr"
        End If
    ' Next
    ElseIf command = "Next" Then
      'On Error Resume Next
        Me.wmp.Controls.Next
        ' sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
        ' nextTrack
        ' cutString TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath
        interValCount = 0
        FrmMain.SetFocus
        'sendVariables swfFull, "openSH", "strSH", ""
    ' Previous
    ElseIf command = "Previous" Then
      ' On Error Resume Next
        Me.wmp.Controls.Previous
        ' sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")
        ' nextTrack
        ' cutString TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath
        interValCount = 0
        FrmMain.SetFocus
        'sendVariables swfFull, "openSH", "strSH", ""
    ' Shuffle
    ElseIf command = "Shuffle" Then
        interValCount = 0
        FrmMain.SetFocus
        Me.wmp.settings.setMode "shuffle", args
        sendVariables swfFull, "openShuffle", "strShuffle", args
        If args = "false" Then
            nextTrack
            EditXML App.path & "\swf\Setting.xml", 2, "Shuffle", "No"
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 2, "No", "~")
        Else
            nextTrack
            EditXML App.path & "\swf\Setting.xml", 2, "Shuffle", "Yes"
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 2, "Yes", "~")
        End If
        If wmp.currentPlaylist.count > 0 Then
            'sendVariables swfFull, "openCurrentTrack", "strCurrentTrack", wmp.currentMedia.getItemInfo("track") - 1
            'sendVariables swfFull, "openAllTrack", "strAllTrack", Me.wmp.currentPlaylist.count
            sendImagePathToFullScreen
        End If
    ' Loop
    ElseIf command = "Loop" Then
        Me.wmp.settings.setMode "loop", args
        sendVariables swfFull, "openLoop", "strLoop", args
        interValCount = 0
        FrmMain.SetFocus
        If args = "true" Then
            LSHN = True
            If Me.wmp.currentPlaylist.count > 0 Then
                nextTrack
            End If
                nextTrack
                EditXML App.path & "\swf\Setting.xml", 2, "Repeat", "Yes"
                FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 1, "Yes", "~")
        Else
            LSHN = False
            nextTrack
            
            EditXML App.path & "\swf\Setting.xml", 2, "Repeat", "No"
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 1, "No", "~")
        End If
        If wmp.currentPlaylist.count > 0 Then
            'sendVariables swfFull, "openCurrentTrack", "strCurrentTrack", wmp.currentMedia.getItemInfo("track") - 1
            'sendVariables swfFull, "openAllTrack", "strAllTrack", Me.wmp.currentPlaylist.count
            sendImagePathToFullScreen
        End If
    ' Mute
    ElseIf command = "Mute" Then
        interValCount = 0
        FrmMain.SetFocus
        'Me.swfFull.SetVariable "setMute", args
        'Me.swfFull.SetVariable "MuteStop", "true"
        sendVariables swfFull, "openMute", "strMute", args
        sendVariables swfMicro, "openMute", "strMute", args
        If args = "true" Then
            Me.wmp.settings.Mute = True
        Else
            Me.wmp.settings.Mute = False
        End If
        
    ' Volume
    ElseIf command = "Volume" Then
        interValCount = 0
        FrmMain.SetFocus
        Me.wmp.settings.Volume = args
        DVolume = args
        EditXML App.path & "\swf\Setting.xml", 2, "Vol", args
        FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 0, args, "~")
    ' Seek
    ElseIf command = "seek" Then
        
        If wmp.currentPlaylist.count > 0 Then
            interValCount = 0
            FrmMain.SetFocus
            On Error GoTo out
            args = (Me.wmp.currentMedia.Duration * args) / 300
            Me.wmp.Controls.CurrentPosition = args
            Exit Sub
        End If
        
    ' Visualization or image album
    ElseIf command = "ImageType" Then
        If args = "Image" Then
            typeFull = "Visual"
            sendVariables swfFull, "openTypeFullScreen", "strTypeFullScreen", "Normal"
        Else
            typeFull = "Image"
            sendVariables swfFull, "openTypeFullScreen", "strTypeFullScreen", "Visualization"
        End If
        
        typeFull = args
        SHFull

    ElseIf command = "FullScreen" Then
        imgAlbum_Click
    
' Play in current play list
    ElseIf command = "SelectedPlaylist" Then
        On Error Resume Next
        swfInternalPlay_FSCommand "Play", True
        Me.wmp.Controls.playItem Me.wmp.currentPlaylist.Item(args)
        STP = True

' Remove track one by one in playlist
    ElseIf command = "Remove" Then
        t = t - 1
        Me.wmp.currentPlaylist.RemoveItem Me.wmp.currentPlaylist.Item(args)
        RemoveTrackPlayer Val(args), TRACK
        Me.ChangeIndexPosition
        Me.nextTrack
        Me.wmp.Controls.Play

' Remove all
    ElseIf command = "RemoveAll" Then
        Me.tmr.Enabled = False
        Me.tmr1.Enabled = False
        Me.wmp.currentPlaylist.Clear
        Erase TRACK()
        t = 0
        Play = False
        ClearScroll
        swfFull_FSCommand "Stop", True
' Change position
  ElseIf command = "changePositionTrack" Then
    Dim splitIndex() As String
    splitIndex = Split(args, "~")
    If (splitIndex(1) = 0 And splitIndex(0) = UBound(TRACK)) Then       ' Move Down
      Me.wmp.currentPlaylist.moveItem splitIndex(1), splitIndex(0)
      Me.wmp.currentPlaylist.moveItem UBound(TRACK) - 1, 0
    ElseIf (splitIndex(1) = UBound(TRACK) And splitIndex(0) = 0) Then   ' Move Up
      Me.wmp.currentPlaylist.moveItem 0, UBound(TRACK)
      Me.wmp.currentPlaylist.moveItem UBound(TRACK) - 1, 0
    Else    ' Normal
      Me.wmp.currentPlaylist.moveItem splitIndex(1), splitIndex(0)
    End If
    
    ChangeIndexPositionArrayTrack CInt(splitIndex(1)), CInt(splitIndex(0)), TRACK
    ChangeIndexPosition
    cutString TRACK(Int(Me.wmp.currentMedia.getItemInfo("track")) - 1).trackPath
    Me.nextTrack
    sendTrackInfo Me.wmp.currentMedia.getItemInfo("track")

'  More file
  ElseIf command = "MoreFile" Then
   On Error Resume Next
   Dim strArt As String
   Dim Arg() As String
   Dim Spl() As String
   Dim pathSpl As String
   Dim TT As String
   Dim Al As String
   Dim Ar As String
   Dim stPlayList As String
   Dim pathPic As String
   Dim pathTrack1 As String
   Me.cdl.InitDir = FrmMain.InitDir
   Me.cdl.FileName = ""
   Me.cdl.Flags = cdlOFNAllowMultiselect Or cdlOFNExplorer
   Me.cdl.MaxFileSize = 255 * 100
   Me.cdl.filter = "All Media File |*.mp3;*.wma"
   Me.cdl.ShowOpen
   If Me.cdl.FileName <> "" Then
      Spl = Split(Me.cdl.FileName, Chr(0))
      If UBound(Spl) > 0 Then
         pathSpl = Spl(0)
         Arg = Split(pathSpl, "\")
         strArt = pathSpl & "\"
         For i = 1 To UBound(Spl)
            pathPic = strArt & "folder.jpg"
            pathTrack1 = strArt + Spl(i)
            Al = Arg(UBound(Arg))
            TT = left(Spl(i), Len(Spl(i)) - 4)
            Ar = Arg(UBound(Arg) - 1)
            stPlayList = Al & "%%%%" & TT & "%%%%" & Ar & "%%%%%%%%%%%%%%%%%%External%%" & pathTrack1 & "%%" & pathPic & "%%English%%" & Trim(ComputerName) & "%%"
            'StPlayer = TT & "||%%" & Ar & "||%%" & Al & "||~Arial Black||Arial Unicode Ms~22||24~~~"
            StPlayer = TT & "||%%" & Ar & "||%%" & Al & "||" & StWaveSpl & "Arial Black||Arial Unicode Ms" & StWaveSpl & "22||24" & StWaveSpl & StWaveSpl & StWaveSpl
            Internalplayer.PlayTrackPlayer pathTrack1 & StWaveSpl & StPlayer & StWaveSpl & pathTrack1 & StWaveSpl & "1"
            Internalplayer.swfInternalPlay_FSCommand "Play", "Play"
            FrmMain.SplitInPlayList stPlayList
         Next
      Else
         On Error Resume Next
         Arg = Split(Me.cdl.FileName, "\")
         strArt = left(Me.cdl.FileName, Len(cdl.FileName) - (Len(Arg(UBound(Arg)))))
         pathPic = strArt & "folder.jpg"
         pathTrack1 = Me.cdl.FileName
         Al = Arg(UBound(Arg) - 1)
         TT = left(Arg(UBound(Arg)), Len(Arg(UBound(Arg))) - 4)
         Ar = Arg(UBound(Arg) - 2)
         
         stPlayList = Al & "%%%%" & TT & "%%%%" & Ar & "%%%%%%%%%%%%%%%%%%External%%" & pathTrack1 & "%%" & pathPic & "%%English%%" & Trim(ComputerName) & "%%"
         StPlayer = TT & "||%%" & Ar & "||%%" & Al & "||" & StWaveSpl & "Arial Black||Arial Unicode Ms" & StWaveSpl & "22||24" & StWaveSpl & StWaveSpl & StWaveSpl
         Internalplayer.PlayTrackPlayer pathTrack1 & StWaveSpl & StPlayer & StWaveSpl & pathTrack1 & StWaveSpl & "1"
         Internalplayer.swfInternalPlay_FSCommand "Play", "Play"
         FrmMain.SplitInPlayList stPlayList
         
      End If
      
         'Refresh.......................
         If IndexSwf = 4 Then
            Dim lentrack As Integer
            lentrack = UBound(PlayTrackInfo) + 1
            FrmMain.Swf(4).SetVariable "PassTrackInfoLen", lentrack
            FrmMain.Swf(4).SetVariable "PassTrackInfo", FrmMain.StrPlayTrackInfo(0, Val(lentrack))
            FrmMain.Swf(4).SetVariable "OpenFrame", "true"
         End If
         FrmMain.InitDir = left(strArt, Len(strArt) - 1)
         EditSetting App.path & "\Swf\setting.xml", 2, "InitDir", strArt
   End If
   nextTrack
   FrmMain.SetFocus
' Open playlist
   ElseIf command = "Playlist" Then
      FrmMain.Swf_FSCommand IndexSwf, "ShowPlayListPlayer", ""
' Msgbox
   ElseIf command = "mb" Then
        MsgBox args
        
   End If
out:
    Exit Sub
End Sub


Sub playTrackWithWindowMediaPlayer(trackName As String, Index As Integer)
  Dim iii As IWMPMedia
  On Error GoTo NotTrack
  'If APIFileExist(trackName) Then
    Set iii = Me.wmp.mediaCollection.Add(trackName)
    iii.setItemInfo "track", Index
    Me.wmp.currentPlaylist.appendItem iii
  'End If
    
NotTrack:
  Exit Sub
End Sub

Sub nextTrack()
    On Error Resume Next
    Dim n As Integer
    Dim tTrack As String
    Dim ll As Boolean
    Dim cp() As String
    Dim albl() As String
    albl = Split(FrmMain.StrFont, "~")
    
    cp() = Split(MainPath, "\")
    If (cp(UBound(cp)) = "My Music") Then
        Me.swfInternalPlay.SetVariable "TblN", "My"
        Me.swfInternalPlay.SetVariable "cap_Next", "Next"
    Else
        Me.swfInternalPlay.SetVariable "TblN", "Nor"
        If language = "Uni" Then
            Me.swfInternalPlay.SetVariable "fontNameLabelNextTrack", albl(1)
            Me.swfInternalPlay.SetVariable "fontSizeLabelNextTrack", albl(3)
            Me.swfInternalPlay.SetVariable "cap_Next", label_next_track(FrmMain.countryPath, "Uni")
        Else
            Me.swfInternalPlay.SetVariable "fontNameLabelNextTrack", albl(0)
            Me.swfInternalPlay.SetVariable "fontSizeLabelNextTrack", albl(2)
            Me.swfInternalPlay.SetVariable "cap_Next", label_next_track(FrmMain.countryPath, "Eng")
        End If
    End If
    
    
    
ReloadNext:
    If SSHN = False Then
        n = Me.wmp.currentMedia.getItemInfo("track")
        If Me.wmp.currentPlaylist.count = n Then
            If LSHN = True Then
                If language = "Uni" Then
                    tTrack = TRACK(0).trackUnicode
                    If tTrack = "" Then
                        language = "Eng"
                        ll = True
                        GoTo ReloadNext
                    End If
                    Me.swfInternalPlay.SetVariable "scroll_font", TRACK(0).trackFontUni
                    Me.swfInternalPlay.SetVariable "scroll_size", TRACK(0).trackFontSizeUni
                    Me.swfInternalPlay.SetVariable "trackNext", tTrack
                    Me.swfInternalPlay.SetVariable "totalTrack", Me.wmp.currentPlaylist.count
                    Me.swfInternalPlay.SetVariable "tNext", "True"
                    
                Else
                    tTrack = TRACK(0).TRACK
                    Me.swfInternalPlay.SetVariable "scroll_font", TRACK(0).trackFontEng
                    Me.swfInternalPlay.SetVariable "scroll_size", TRACK(0).trackFontSizeEng
                    Me.swfInternalPlay.SetVariable "trackNext", tTrack
                    Me.swfInternalPlay.SetVariable "totalTrack", Me.wmp.currentPlaylist.count
                    Me.swfInternalPlay.SetVariable "tNext", "True"
                End If
            Else
                Me.swfInternalPlay.SetVariable "trackNext", ""
                Me.swfInternalPlay.SetVariable "totalTrack", Me.wmp.currentPlaylist.count
                Me.swfInternalPlay.SetVariable "tNext", "True"
            End If
        Else
            If language = "Uni" Then
                tTrack = TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackUnicode
                If tTrack = "" Then
                    language = "Eng"
                    ll = True
                    GoTo ReloadNext
                End If
                Me.swfInternalPlay.SetVariable "scroll_font", TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackFontUni
                Me.swfInternalPlay.SetVariable "scroll_size", TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackFontSizeUni
                Me.swfInternalPlay.SetVariable "trackNext", tTrack
                Me.swfInternalPlay.SetVariable "totalTrack", Me.wmp.currentPlaylist.count
                Me.swfInternalPlay.SetVariable "tNext", "True"
            Else
                tTrack = TRACK(Me.wmp.currentMedia.getItemInfo("track")).TRACK
                Me.swfInternalPlay.SetVariable "scroll_font", TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackFontEng
                Me.swfInternalPlay.SetVariable "scroll_size", TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackFontSizeEng
                Me.swfInternalPlay.SetVariable "trackNext", tTrack
                Me.swfInternalPlay.SetVariable "totalTrack", Me.wmp.currentPlaylist.count
                Me.swfInternalPlay.SetVariable "tNext", "True"
            End If
        End If
    End If
  
    If ll = True Then
        ll = False
        language = "Uni"
    End If
End Sub

Sub cutStringForAlubumImage(strTrackPath As String)
  Dim Ar() As String
  Dim j As Integer
  Dim strImg As String
  Ar = Split(strTrackPath, "\")
  For j = LBound(Ar) To UBound(Ar) - 1
    strImg = strImg + "\" + Ar(j)
  Next j
  strImg = Right(strImg, Len(strImg) - 1)
  
  If Me.wmp.currentPlaylist.count = 1 Then
      getAlbumImage (strImg)
  End If
End Sub

Sub cutString(strTrackPath As String)
   Dim Ar() As String
   Dim j As Integer
   Dim strImg As String
   Ar = Split(strTrackPath, "\")
   For j = LBound(Ar) To UBound(Ar) - 1
      strImg = strImg + "\" + Ar(j)
   Next j
   strImg = Right(strImg, Len(strImg) - 1)
   getAlbumImage (strImg)
End Sub

Sub getAlbumImage(strPath As String)
   If tmpstrPath <> strPath Then
    If Dir(strPath & "\folder.jpg") <> "" Then
        If frm(0).Visible = False Then
            Me.swfInternalPlay.SetVariable "imgPath", Replace(strPath, "\", "\\") & "\\folder.jpg"
            Me.swfInternalPlay.SetVariable "CoverArt", "img"
            Me.swfInternalPlay.SetVariable "OpenFrame", "true"
        Else
            frm(0).Visible = True
            Me.swfInternalPlay.SetVariable "imgPath", Replace(strPath, "\", "\\") & "\\folder.jpg"
            Me.swfInternalPlay.SetVariable "CoverArt", "img"
            Me.swfInternalPlay.SetVariable "OpenFrame", "true"
        End If
        NC = True
    Else
        NC = False
        If typeFull = "Visual" Then
            frm(0).Visible = False
            Me.swfInternalPlay.SetVariable "CoverArtNot", "Not"
            Me.swfInternalPlay.SetVariable "OpenFrame", "true"
        Else
            frm(0).Visible = True
            Me.swfInternalPlay.SetVariable "CoverArtNot", "Not"
            Me.swfInternalPlay.SetVariable "OpenFrame", "true"
        End If
    End If
    tmpstrPath = strPath
   End If
   
   Call sendImagePathToFullScreen
   
End Sub

Sub setTrackInfo(strTrackPath As String, strTrack As String, strTrackUnicode As String, strArtist As String, strArtistUnicode As String, strAlbum As String, strAlbumUnicode As String, strFontUni As String, strFontEng As String, strFontSizeUni As String, strFontSizeEng As String, strCap_TrackTitle As String, strCap_Artist As String, strCap_Album As String, strLan_Path As String, strExternal As Integer)
  ReDim Preserve TRACK(t)
  TRACK(t).trackPath = strTrackPath
  TRACK(t).TRACK = strTrack
  TRACK(t).trackUnicode = strTrackUnicode
  TRACK(t).trackArtist = strArtist
  TRACK(t).trackArtistUnicode = strArtistUnicode
  TRACK(t).trackAlbum = strAlbum
  TRACK(t).trackAlbumUnicode = strAlbumUnicode
  TRACK(t).trackFontUni = strFontUni
  TRACK(t).trackFontEng = strFontEng
  TRACK(t).trackFontSizeUni = strFontSizeUni
  TRACK(t).trackFontSizeEng = strFontSizeEng
  TRACK(t).trackCaptionTrackTitle = strCap_TrackTitle
  TRACK(t).trackCaptionArtist = strCap_Artist
  TRACK(t).trackCaptionAlbum = strCap_Album
  TRACK(t).trackLanPath = strLan_Path
  TRACK(t).trackExternal = strExternal
  t = t + 1
  playTrackWithWindowMediaPlayer strTrackPath, t
  Play = True
End Sub

Sub sendTrackInfo(Index As Integer)
    
    
    Dim str_track_scroll As String
    str_track_scroll = Trim(text_track_scroll(Index, language, wmp))
    
    If (language = "Uni") Then
        Me.swfInternalPlay.SetVariable "scroll_font_track", TRACK(Index - 1).trackFontUni
        Me.swfInternalPlay.SetVariable "scroll_size_track", TRACK(Index - 1).trackFontSizeUni
        If swfMicro.Visible = True Then
            sendVariables swfMicro, "openTextFont", "strTextFont", TRACK(Index - 1).trackFontUni & "~" & TRACK(Index - 1).trackFontSizeUni
        End If
    Else
        Me.swfInternalPlay.SetVariable "scroll_font_track", TRACK(Index - 1).trackFontEng
        Me.swfInternalPlay.SetVariable "scroll_size_track", TRACK(Index - 1).trackFontSizeEng
        If swfMicro.Visible = True Then
            sendVariables swfMicro, "openTextFont", "strTextFont", TRACK(Index - 1).trackFontEng & "~" & TRACK(Index - 1).trackFontSizeEng
        End If
    End If
    
    
    Erase Sp
    Sp = Split(FrmMain.SplitPlayer, "~")
    If Sp(5) = "true" Then
        Me.tmr1.Enabled = False
        Me.swfInternalPlay.SetVariable "trackTitle", str_track_scroll
        Me.swfInternalPlay.SetVariable "GetTrackTitle", "True"
        Me.swfInternalPlay.SetVariable "SHScrolling", "true"
        ' return text scroll when click fullscreen
        strScrollFull = str_track_scroll    ' return text scrolling
    Else
        Me.tmr1.Enabled = True
        timeInterval = 0
        tmr1_Timer
        Me.swfInternalPlay.SetVariable "SHScrolling", "false"
    End If
    
    sendVariables swfMicro, "openInfo", "strInfo", str_track_scroll
    cutStringForAlubumImage Me.wmp.currentMedia.sourceURL
    
End Sub

Private Sub imgAlbum_Click()
    sendVariables swfFull, "openRegistered", "strRegistered", IsRegistered
If wmp.currentPlaylist.count > 0 Then
    Call sendImagePathToFullScreen
    
    tmpWidth = Me.Width
    tmpHeight = Me.Height
    tmpTop = Me.Top
    tmpLeft = Me.left
    tmpHF = frm(0).Height
    tmpWF = frm(0).Width
    Me.Hide
    
    Me.swfInternalPlay.SetVariable "startScroll", "false"
    Me.swfInternalPlay.Visible = False
    
    Me.swfFull.SetVariable "getvalseek", "true"
    Me.swfFull.SetVariable "getvalfade", "true"
    sendVariables swfFull, "openSetting", "strSetting", FrmMain.SplitColor & "||" & FrmMain.SplitSly & "||" & FrmMain.SplitPlayer
    
    If typeFull = "Visual" Then
    
        sendVariables swfFull, "openTypeFullScreen", "strTypeFullScreen", "Normal"
        sendVariables swfFull, "openCurrentTrack", "strCurrentTrack", wmp.currentMedia.getItemInfo("track") - 1
        sendVariables swfFull, "openAllTrack", "strAllTrack", Me.wmp.currentPlaylist.count
        sendVariables swfFull, "openNPimg", "strNPimg", imagePathAlbumPrevious
        sendVariables swfFull, "openNCimg", "strNCimg", imagePathAlbumCurrent
        sendVariables swfFull, "openNNimg", "strNNimg", imagePathAlbumNext
        sendVariables swfFull, "openInfo", "strInfo", infoFullscreen(language, Me.wmp.currentMedia.getItemInfo("track") - 1)
        
        picInternalPlay.Visible = False
        
        'sendTrackInfoNextAndPreviouse
        
    Else
        
        sendVariables swfFull, "openTypeFullScreen", "strTypeFullScreen", "Visualization"
        sendVariables swfFull, "openVimg", "strVimg", imagePathAlbumCurrent
        sendVariables swfFull, "openInfo", "strInfo", infoFullscreen(language, Me.wmp.currentMedia.getItemInfo("track") - 1)
        Resize_Visualization formWidth, formHeight
        cmdFull.Visible = False
    End If
    
    sendVariables swfFull, "openVolume", "strVolume", CInt(DVolume)
    
    'Me.swfFull.Width = Me.Width
    'Me.swfFull.Height = Me.Height
    Me.Width = formWidth    'FrmMain.Width
    Me.Height = formHeight  'FrmMain.Height
    
    Me.swfFull.Visible = True
    
    If Mode = "FullMode" Then
        Me.left = 0
        Me.Top = 0
    Else
        Internalplayer.left = (FrmMain.left + FrmMain.Width) - Internalplayer.Width - 45 'formWidth  - Internalplayer.Width
        Internalplayer.Top = (FrmMain.Top + FrmMain.Height) - Internalplayer.Height - 45 'formHeight - Internalplayer.Height
    End If
    
    Me.Show
    
    Exit Sub
End If
Ex:
Exit Sub
  
End Sub


Private Sub tmr1_Timer()
'**********************
' FULLSCREEN
    If Me.swfFull.Visible = True Then
        If language = "Uni" Then
            swfFull.SetVariable "scroll_font_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontUni
            swfFull.SetVariable "scroll_size_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontSizeUni
        Else
            swfFull.SetVariable "scroll_font_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontEng
            swfFull.SetVariable "scroll_size_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontSizeEng
        End If
    
        If timeInterval = 0 Then    ' show track titile
            If language = "Uni" Then
                If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode <> "" Then
                    swfFull.SetVariable "strScroll", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionTrackTitle & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode
                Else
                    swfFull.SetVariable "strScroll", "Track: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).TRACK
                End If
            Else
                swfFull.SetVariable "strScroll", "Track: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).TRACK
            End If
            timeInterval = 1
        ElseIf timeInterval = 1 Then    ' show track artist
            'Me.swfFull.SetVariable "strScroll", Trim(text_track_scroll(Me.wmp.currentMedia.getItemInfo("track"), "Eng"))
            If language = "Uni" Then
                If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode <> "" Then
                    swfFull.SetVariable "strScroll", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionArtist & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode
                Else
                    swfFull.SetVariable "strScroll", "Artist: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtist
                End If
            Else
                swfFull.SetVariable "strScroll", "Artist: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtist
            End If
            timeInterval = 2
        ElseIf timeInterval = 2 Then    ' show track album
            'Me.swfFull.SetVariable "strScroll", Trim(text_track_scroll(Me.wmp.currentMedia.getItemInfo("track"), "Eng"))
            If language = "Uni" Then
                If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode <> "" Then
                    swfFull.SetVariable "strScroll", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionAlbum & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode
                Else
                    swfFull.SetVariable "strScroll", "Album: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbum
                End If
            Else
                swfFull.SetVariable "strScroll", "Album: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbum
            End If
            timeInterval = 0
        End If
        Me.swfFull.SetVariable "Info", "True"
        
'**********************
' INTERNALPLAYER
    Else
        If (language = "Uni") Then
            On Error GoTo Ex
            Me.swfInternalPlay.SetVariable "scroll_font_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontUni
            Me.swfInternalPlay.SetVariable "scroll_size_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontSizeUni
        Else
            On Error GoTo Ex
            Me.swfInternalPlay.SetVariable "scroll_font_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontEng
            Me.swfInternalPlay.SetVariable "scroll_size_track", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackFontSizeEng
        End If
    
        If timeInterval = 0 Then    ' show track titile
            If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackExternal = 0 Then
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionTrackTitle & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).TRACK
                    End If
                Else
                    Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).TRACK
                End If
            Else
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionTrackTitle & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackUnicode
                    Else
                        If wmp.currentMedia.getItemInfo("title") <> "" Then
                            Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & wmp.currentMedia.getItemInfo("title")
                        Else
                            Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & """" & "NA" & """"
                        End If
                    End If
                Else
                    If wmp.currentMedia.getItemInfo("title") <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & wmp.currentMedia.getItemInfo("title")
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Track: " & """" & "NA" & """"
                    End If
                End If
            End If
            timeInterval = 1
        ElseIf timeInterval = 1 Then    ' show track artist
            If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackExternal = 0 Then
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionArtist & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtist
                    End If
                Else
                    Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtist
                End If
            Else
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionArtist & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackArtistUnicode
                    Else
                        If wmp.currentMedia.getItemInfo("artist") <> "" Then
                            Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & wmp.currentMedia.getItemInfo("artist")
                        Else
                            Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & """" & "NA" & """"
                        End If
                    End If
                Else
                    If wmp.currentMedia.getItemInfo("artist") <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & wmp.currentMedia.getItemInfo("artist")
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Artist: " & """" & "NA" & """"
                    End If
                End If
            End If
            timeInterval = 2
        ElseIf timeInterval = 2 Then    ' show track album
            If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackExternal = 0 Then
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionAlbum & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbum
                    End If
                Else
                    Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbum
                End If
            Else
                If language = "Uni" Then
                    If TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackCaptionAlbum & " " & TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackAlbumUnicode
                    Else
                        If wmp.currentMedia.getItemInfo("album") <> "" Then
                            Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & wmp.currentMedia.getItemInfo("album")
                        Else
                            Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & """" & "NA" & """"
                        End If
                    End If
                Else
                    If wmp.currentMedia.getItemInfo("album") <> "" Then
                        Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & wmp.currentMedia.getItemInfo("album")
                    Else
                        Me.swfInternalPlay.SetVariable "trackTitle", "Album: " & """" & "NA" & """"
                    End If
                End If
            End If
            timeInterval = 0
        End If
        Me.swfInternalPlay.SetVariable "GetTrackTitle", "True"
    End If
    Exit Sub
Ex:
End
End Sub

Private Sub wmp_Click(ByVal nButton As Integer, ByVal nShiftState As Integer, ByVal fX As Long, ByVal fY As Long)
'  ScrVal = nShiftState
'  On Error GoTo E
'    Me.wmp.fullScreen = True
'  Exit Sub
'E:
'Exit Sub
    If swfFull.Visible = False Then
        imgAlbum_Click
    End If
End Sub

Public Sub Resize_Form(formWidth As Integer, formHeight As Integer)
    swfInternalPlay.SetVariable "reg", IsRegistered
    swfInternalPlay.SetVariable "OpenFrame", "true"
    If FrmMain.WindowState = 1 Then
        If Micro = "true" Then
            Dim widthMicro As Integer
            Dim heightMicro As Integer
            tmpMTrack = -1
            sendVariables swfMicro, "openRegister", "strRegister", IsRegistered
            sendThemeToMicro
            
            If DisplayAds = 1 Then
               Internalplayer.Width = (((ScreenX) * (245)) / (scaleMicroByWidth)) * 15
               Internalplayer.Height = (((ScreenY) * (45)) / (scaleMicroByHeight)) * 15
               Internalplayer.Top = 0
               Internalplayer.left = (ScreenX * 15) - (Internalplayer.Width + (75 * 15))
               
               
               swfAds.Width = ((ScreenX * 100) / (scaleMicroByWidth)) * 15
               swfAds.Height = Internalplayer.Height
               swfAds.Top = 0
               swfAds.left = 0
               
               swfMicro.Width = Internalplayer.Width - swfAds.Width
               swfMicro.Height = Internalplayer.Height
               swfMicro.Top = 0
               swfMicro.left = swfAds.Width
               
               ShowMe
               HideInter = True
               swfInternalPlay.Visible = False
               swfMicro.Visible = True
               swfAds.Visible = True
            Else
               Internalplayer.Width = (((ScreenX) * (145)) / (scaleMicroByWidth)) * 15
               Internalplayer.Height = (((ScreenY) * (45)) / (scaleMicroByHeight)) * 15
               
               Internalplayer.Top = 0
               Internalplayer.left = (ScreenX * 15) - (Internalplayer.Width + (75 * 15))
               
               swfMicro.Width = Internalplayer.Width
               swfMicro.Height = Internalplayer.Height
               swfMicro.Top = 0
               swfMicro.left = 0
               
               ShowMe
               HideInter = True
               swfInternalPlay.Visible = False
               swfMicro.Visible = True
               swfAds.Visible = False
            End If
        Else
            Internalplayer.Visible = False
            HideInter = False
        End If
    Else
        If HideInter = True Then
            swfMicro.Visible = False
            swfInternalPlay.Visible = True
            HideInter = False
            Internalplayer.Visible = False
            'ShowMe
        Else
            If DisplayMini = 1 Then Internalplayer.Visible = True 'ShowMe
            'this this cause problem
          '  ShowMe
        End If
        Internalplayer.Width = ((6945 / 15 * formWidth / 15) / 1024) * 15
        Internalplayer.Height = ((3135 / 15 * formHeight / 15) / 768) * 15
        
        If Mode = "FullMode" Then
            Internalplayer.left = formWidth - Internalplayer.Width
            Internalplayer.Top = formHeight - Internalplayer.Height
        Else
            Internalplayer.left = (FrmMain.left + FrmMain.Width) - Internalplayer.Width - 45 'formWidth  - Internalplayer.Width
            Internalplayer.Top = (FrmMain.Top + FrmMain.Height) - Internalplayer.Height - 45 'formHeight - Internalplayer.Height
        End If
  
        ' swf Fullscreen
        Me.swfFull.Visible = False
        Me.swfFull.Width = formWidth
        Me.swfFull.Height = formHeight

        Me.picInternalPlay.Width = Internalplayer.Width '(7005 * tmpWidth) / (1024 * 15)
        Me.picInternalPlay.Height = Internalplayer.Height '(3180 * tmpHeight) / (768 * 15)
        Me.picInternalPlay.left = 0
        Me.picInternalPlay.Top = 0

        ' swf
        Me.swfInternalPlay.Width = Me.picInternalPlay.Width '(6930 * Me.picInternalPlay.Width) / 7005
        Me.swfInternalPlay.Height = Me.picInternalPlay.Height '(3135 * Me.picInternalPlay.Height) / 3180

        ' frm
        Me.frm(0).Width = (2260 * Me.picInternalPlay.Width) / 7005
        Me.frm(0).Height = (2275 * Me.picInternalPlay.Height) / 3180
        Me.frm(0).left = (4715 * Me.picInternalPlay.Width) / 7005
        Me.frm(0).Top = (840 * Me.picInternalPlay.Height) / 3180
        Me.wmp.Width = Me.frm(0).Width
        Me.wmp.Height = Me.frm(0).Height

        ' cmdFull
        Me.cmdFull.Width = (390 * Me.picInternalPlay.Width) / 7005
        Me.cmdFull.Height = (390 * Me.picInternalPlay.Height) / 3180
        Me.cmdFull.left = (6570 * Me.picInternalPlay.Width) / 7005
        Me.cmdFull.Top = (2725 * Me.picInternalPlay.Height) / 3180
    End If
End Sub
Sub Resize_Visualization(formWidth As Integer, formHeight As Integer)
    picInternalPlay.Top = ((formHeight / 15 * 104.4)) / (600) * 15
    picInternalPlay.left = ((formWidth / 15 * 55.1) / (800)) * 15
    picInternalPlay.Height = ((formHeight / 15 * 290.9) / (600)) * 15
    picInternalPlay.Width = ((formWidth / 15 * 491.6) / (800)) * 15
    
    frm(0).Top = 0
    frm(0).left = 0
    frm(0).Width = picInternalPlay.Width
    frm(0).Height = picInternalPlay.Height
    
    wmp.Top = 0
    wmp.left = 0
    wmp.Width = frm(0).Width
    wmp.Height = frm(0).Height
    
End Sub


Sub SHFull()
 If typeFull = "Visual" Then
 
    typeFull = "Image"
    frm(0).Visible = True
    Me.wmp.Top = 0
    Me.wmp.left = 0
    Me.wmp.uiMode = "None"
    EditXML App.path & "\swf\Setting.xml", 2, "TypeFull", "Visual"
    
  Else

    typeFull = "Visual"
    frm(0).Visible = False
    Me.wmp.uiMode = "Invisible"
    Me.wmp.Top = 5000
    Me.wmp.left = 5000
    EditXML App.path & "\swf\Setting.xml", 2, "TypeFull", "Image"
    
 End If
  
End Sub

Private Sub cmdFull_Click()
  SHFull
End Sub

Sub PlayTrackPlayer(str As String)
    Dim strSplit() As String
    Dim strInfo() As String
    Dim stPath As String
    Dim stAlbum() As String
    Dim stTrack() As String
    Dim stArtist() As String
    Dim stFont() As String
    Dim stSize() As String
    Dim stLanguage As String
    Dim stCap_TrackTitle As String
    Dim stCap_Artist As String
    Dim stCap_Album As String
    Dim stLanPath As String
    Dim stExternal As Integer
    strSplit = Split(str, StWaveSpl)
    strInfo = Split(strSplit(1), "%%")
    stPath = strSplit(0)
    stTrack = Split(strInfo(0), "||")
    stArtist = Split(strInfo(2), "||")
    stAlbum = Split(strInfo(1), "||")
    stFont = Split(strSplit(2), "||")   ' Split(strInfo(4), "||")
    stSize = Split(strSplit(3), "||")   'Split(strInfo(5), "||")
    stCap_TrackTitle = strSplit(4)
    stCap_Artist = strSplit(5)
    stCap_Album = strSplit(6)
    stLanPath = strSplit(7)
    If UBound(strSplit) = 7 Then
        stExternal = 0
    Else
        stExternal = strSplit(8)
    End If
    setTrackInfo stPath, stTrack(0), stTrack(1), stArtist(0), stArtist(1), stAlbum(0), stAlbum(1), stFont(1), stFont(0), stSize(1), stSize(0), stCap_TrackTitle, stCap_Artist, stCap_Album, stLanPath, stExternal
End Sub

Sub ChangeIndexPosition()
  Dim j As Integer
  For j = 0 To Me.wmp.currentPlaylist.count - 1
    Me.wmp.currentPlaylist.Item(j).setItemInfo "track", j + 1
  Next j
End Sub

Sub SelectedPlaylist()
  ' frmInterPlayer.SwfPlayer.SetVariable "trackPlaying", Me.wmp.currentMedia.getItemInfo("track") - 1
  ' frmInterPlayer.SwfPlayer.SetVariable "NextTrack", "true"
End Sub

Private Sub ScalePic(Img As Image, pathName As String)
  Img.Picture = LoadPicture(pathName)
End Sub


Sub ClearScroll()
    Me.swfInternalPlay.SetVariable "time", ""
    Me.swfInternalPlay.SetVariable "timeString", ""
    Me.swfInternalPlay.SetVariable "vseek", ""
    Me.swfInternalPlay.SetVariable "trackTitle", ""
    Me.swfInternalPlay.SetVariable "trackNext", ""
    Me.swfInternalPlay.SetVariable "totalTrack", 0
    Me.swfInternalPlay.SetVariable "tNext", "True"
    Me.swfInternalPlay.SetVariable "GetTrackTitle", "True"
    Me.swfFull.SetVariable "strScroll", ""
    Me.swfFull.SetVariable "Info", "True"
End Sub


Sub sendImagePathToFullScreen()
    ' MsgBox getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath)
    If wmp.currentPlaylist.count > 0 Then
    Dim imgP As String
    Dim imgC As String
    Dim imgN As String
    Dim strPrevious As String
    Dim strNext As String
    
    If wmp.currentPlaylist.count = 1 Then
        imgP = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        imgC = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        imgN = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        strPrevious = TrackLabel(Me.wmp.currentMedia.getItemInfo("track") - 1)
        strNext = TrackLabel(Me.wmp.currentMedia.getItemInfo("track") - 1)
    ElseIf wmp.currentMedia.getItemInfo("track") = 1 Then
        imgP = checkFile(getLocationTrack(TRACK(Me.wmp.currentPlaylist.count - 1).trackPath))
        imgC = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        imgN = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackPath))
        strPrevious = TrackLabel(Me.wmp.currentMedia.getItemInfo("track") - 1)
        strNext = TrackLabel(Me.wmp.currentMedia.getItemInfo("track"))
    ElseIf wmp.currentPlaylist.count = wmp.currentMedia.getItemInfo("track") Then
        imgP = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 2).trackPath))
        imgC = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        imgN = checkFile(getLocationTrack(TRACK(0).trackPath))
        strPrevious = TrackLabel(Me.wmp.currentMedia.getItemInfo("track") - 2)
        strNext = TrackLabel(0)
    Else
        imgP = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 2).trackPath))
        imgC = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track") - 1).trackPath))
        imgN = checkFile(getLocationTrack(TRACK(Me.wmp.currentMedia.getItemInfo("track")).trackPath))
        strPrevious = TrackLabel(Me.wmp.currentMedia.getItemInfo("track") - 2)
        strNext = TrackLabel(Me.wmp.currentMedia.getItemInfo("track"))
    End If
    
    If swfFull.Visible = True Then
        If typeFull = "Image" Then
            ' For Visualization full screen
            imagePathAlbumPrevious = imgP
            imagePathAlbumCurrent = imgC
            imagePathAlbumNext = imgN
            labelNextTrackForFullscreen = strNext
            labelPreviousTrackFullscreen = strPrevious
            sendVariables swfFull, "openVimg", "strVimg", imgC
        Else
            imagePathAlbumPrevious = imgP
            imagePathAlbumCurrent = imgC
            imagePathAlbumNext = imgN
            labelNextTrackForFullscreen = strNext
            labelPreviousTrackFullscreen = strPrevious
            sendVariables swfFull, "openCurrentTrack", "strCurrentTrack", wmp.currentMedia.getItemInfo("track") - 1
            sendVariables swfFull, "openAllTrack", "strAllTrack", Me.wmp.currentPlaylist.count
            sendVariables swfFull, "openNPimg", "strNPimg", imagePathAlbumPrevious
            sendVariables swfFull, "openNCimg", "strNCimg", imagePathAlbumCurrent
            sendVariables swfFull, "openNNimg", "strNNimg", imagePathAlbumNext
            
        End If
    Else
        imagePathAlbumPrevious = imgP
        imagePathAlbumCurrent = imgC
        imagePathAlbumNext = imgN
    End If
End If
End Sub

Function checkFile(str As String)
   If Dir(str & "\folder.jpg") <> "" Then
      checkFile = str & "\folder.jpg"
   Else
      checkFile = "None"
   End If
End Function

Function getLocationTrack(strTrackPath As String)
    Dim Ar() As String
    Dim j As Integer
    Dim strImg As String
    Ar = Split(strTrackPath, "\")
    For j = LBound(Ar) To UBound(Ar) - 1
        strImg = strImg + "\" + Ar(j)
    Next j
    strImg = Right(strImg, Len(strImg) - 1)
    getLocationTrack = strImg
End Function

Function infoFullscreen(strLan As String, strID As Integer) As String
    Dim tmpTitle As String
    Dim tmpArtist As String
    Dim tmpAlbum As String
    Dim symbol As String
    symbol = "**"
    
    If (strLan = "Uni") Then
        If TRACK(strID).trackExternal = 0 Then
            tmpTitle = TRACK(strID).trackUnicode
            tmpArtist = TRACK(strID).trackArtistUnicode
            tmpAlbum = TRACK(strID).trackAlbumUnicode
        Else
            tmpTitle = wmp.currentMedia.getItemInfo("title")
            If tmpTitle = "" Then tmpTitle = "NA"
            tmpArtist = wmp.currentMedia.getItemInfo("artist")
            If tmpArtist = "" Then tmpArtist = "NA"
            tmpAlbum = wmp.currentMedia.getItemInfo("album")
            If tmpAlbum = "" Then tmpAlbum = "NA"
        End If
        
        If (tmpTitle = "") Then
            tmpTitle = TRACK(strID).TRACK & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            If TRACK(strID).trackExternal = 0 Then
                tmpTitle = TRACK(strID).trackUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
            Else
                tmpTitle = tmpTitle & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
            End If
        End If
        
        If (tmpArtist = "") Then
            tmpArtist = TRACK(strID).trackArtist & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            If TRACK(strID).trackExternal = 0 Then
                tmpArtist = TRACK(strID).trackArtistUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
            Else
                tmpArtist = tmpArtist & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
            End If
        End If
        
        If (tmpAlbum = "") Then
            tmpAlbum = TRACK(strID).trackAlbum & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            If TRACK(strID).trackExternal = 0 Then
                tmpAlbum = TRACK(strID).trackAlbumUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
            Else
                tmpAlbum = tmpAlbum & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
            End If
        End If
    Else
        If TRACK(strID).trackExternal = 0 Then
            tmpTitle = TRACK(strID).TRACK
            tmpArtist = TRACK(strID).trackArtist
            tmpAlbum = TRACK(strID).trackAlbum
        Else
            tmpTitle = wmp.currentMedia.getItemInfo("title")
            If tmpTitle = "" Then tmpTitle = "NA"
            tmpArtist = wmp.currentMedia.getItemInfo("artist")
            If tmpArtist = "" Then tmpArtist = "NA"
            tmpAlbum = wmp.currentMedia.getItemInfo("album")
            If tmpAlbum = "" Then tmpAlbum = "NA"
        End If
        
        If (tmpTitle <> "") Then
            tmpTitle = tmpTitle & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            tmpTitle = TRACK(strID).trackUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
        End If
        
        If (tmpArtist <> "") Then
            tmpArtist = tmpArtist & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            tmpArtist = TRACK(strID).trackArtistUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
        End If
        
        If (tmpAlbum <> "") Then
            tmpAlbum = tmpAlbum & symbol & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            tmpAlbum = TRACK(strID).trackAlbumUnicode & symbol & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
        End If
    End If
    
    infoFullscreen = tmpTitle & "|" & tmpArtist & "|" & tmpAlbum
End Function

Function getTrackInfoNextAndPrevious(strLan As String, strID As Integer) As String
    Dim strTemp As String
    strTemp = TRACK(strID).TRACK
    If strLan = "Uni" Then
        If (strTemp <> "") Then
            strTemp = TRACK(strID).trackUnicode & "~" & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
        Else
            strTemp = TRACK(strID).TRACK & "~" & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        End If
    Else
        If (strTemp <> "") Then
            strTemp = TRACK(strID).TRACK & "~" & TRACK(strID).trackFontEng & "%" & TRACK(strID).trackFontSizeEng
        Else
            strTemp = TRACK(strID).trackUnicode & "~" & TRACK(strID).trackFontUni & "%" & TRACK(strID).trackFontSizeUni
        End If
    End If
    getTrackInfoNextAndPrevious = strTemp
End Function
Sub sendTrackInfoNextAndPreviouse()
    If wmp.currentMedia.getItemInfo("track") = 1 Then
        sendVariables swfFull, "openLabelPrevious", "strLabelPrevious", getTrackInfoNextAndPrevious(language, wmp.currentMedia.getItemInfo("track"))
        sendVariables swfFull, "openLabelNext", "strLabelNext", getTrackInfoNextAndPrevious(language, wmp.currentPlaylist.count - 1)
    ElseIf wmp.currentMedia.getItemInfo("track") = wmp.currentPlaylist.count Then
        sendVariables swfFull, "openLabelPrevious", "strLabelPrevious", getTrackInfoNextAndPrevious(language, wmp.currentMedia.getItemInfo("track") - 2)
        sendVariables swfFull, "openLabelNext", "strLabelNext", getTrackInfoNextAndPrevious(language, 0)
    Else
        sendVariables swfFull, "openLabelPrevious", "strLabelPrevious", getTrackInfoNextAndPrevious(language, wmp.currentMedia.getItemInfo("track") - 2)
        sendVariables swfFull, "openLabelNext", "strLabelNext", getTrackInfoNextAndPrevious(language, wmp.currentMedia.getItemInfo("track"))
    End If
End Sub




Public Sub ShowMe(Optional value As Boolean)
  Call SetWindowPos(hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
  Visible = value
'  FrmMain.SetFocus
End Sub

Sub sendThemeToMicro()
    Dim strSetting As String
    strSetting = FrmMain.SplitColor & "&&" & FrmMain.SplitSly & "&&" & FrmMain.SplitPlayer
    sendVariables swfMicro, "openSetting", "strSetting", strSetting
    sendVariables swfAds, "openTheme", "strTheme", FrmMain.SplitColor
End Sub

Private Sub MouseMove()
   Static boolLooping As Boolean
   
   If boolLooping Then Exit Sub
   
   Dim xy As POINTAPI
   Dim pt As POINTAPI
   
   Dim ptLeft As Integer
   Dim ptTop As Integer
   Dim ptHeight As Integer
   Dim ptWidth As Integer
   
   Dim out As Boolean
   ptLeft = left / 15
   ptTop = Top / 15
   ptWidth = Width / 15
   ptHeight = Height / 15
   boolLooping = True
   Do
      GetCursorPos xy
      out = (ptLeft > xy.X Or ptLeft + ptWidth < xy.X) Or (ptTop > xy.y Or ptTop + ptHeight < xy.y)
      DoEvents
   Loop Until out
   'mouse roll out
    sendVariables swfMicro, "openMouseOut", "strMouseOut", "true"
   'end moues roll out
               
   boolLooping = False
End Sub

Public Sub ClickFullScreen()
    If wmp.currentPlaylist.count > 0 Then
        imgAlbum_Click
    End If
End Sub
Public Function TrackLabel(ind As Integer) As String
    
End Function

'------------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------------------------
'
'' sub for controll play new track
'Sub sssetPlayTrack()
'
'End Sub
'
'' sub for send track scrolling to micro and micor player
''Sub sssendTrackForScrolling()
''    If swfMicro.Visible = True Then
''
''    Else
''
''End Sub
'
'' sub for send track infomation to fullscreen
'Public Function sssendTrackInforToFullscreen() As String
'    Dim tmpTitle As String
'    Dim tmpArtist As String
'    Dim tmpAlbum As String
'    Dim tmpTitleEng As String
'    Dim tmpArtistEng As String
'    Dim tmpAlbumEng As String
'    Dim tmpTitleUni As String
'    Dim tmpArtistUni As String
'    Dim tmpAlbumUni As String
'    Dim tmpFontNameUni As String
'    Dim tmpFontSizeUni As String
'    Dim tmpFontNameEng As String
'    Dim tmpFontSizeEng As String
'    Dim tmpExternal As Boolean
'
'    Dim symbol As String
'    symbol = "**"
'    If (strLan = "Uni") Then
'        If tmpExternal = False Then
'            tmpTitle = tmpTitleUni 'TRACK(strID).trackUnicode
'            tmpArtist = tmpArtistUni 'TRACK(strID).trackArtistUnicode
'            tmpAlbum = tmpAlbumUni 'TRACK(strID).trackAlbumUnicode
'        Else
'            tmpTitle = wmp.currentMedia.getItemInfo("title")
'            If tmpTitle = "" Then tmpTitle = "NA"
'            tmpArtist = wmp.currentMedia.getItemInfo("artist")
'            If tmpArtist = "" Then tmpArtist = "NA"
'            tmpAlbumUni = wmp.currentMedia.getItemInfo("album")
'            If tmpAlbum = "" Then tmpAlbum = "NA"
'        End If
'
'        If (tmpTitle = "") Then
'            tmpTitle = tmpTitleEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            If tmpExternal = False Then
'                tmpTitle = tmpTitleUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'            Else
'                tmpTitle = tmpTitleEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'            End If
'        End If
'
'        If (tmpArtist = "") Then
'            tmpArtist = tmpArtistEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            If tmpExternal = False Then
'                tmpArtist = tmpArtistUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'            Else
'                tmpArtist = tmpArtistEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'            End If
'        End If
'
'        If (tmpAlbum = "") Then
'            tmpAlbum = tmpAlbumEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            If tmpExternal = False Then
'                tmpAlbum = tmpAlbumUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'            Else
'                tmpAlbum = tmpAlbumEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'            End If
'        End If
'    Else
'        If tmpExternal = False Then
'            tmpTitle = tmpTitleEng
'            tmpArtist = tmpArtistEng
'            tmpAlbum = tmpAlbumEng
'        Else
'            tmpTitle = wmp.currentMedia.getItemInfo("title")
'            If tmpTitle = "" Then tmpTitle = "NA"
'            tmpArtist = wmp.currentMedia.getItemInfo("artist")
'            If tmpArtist = "" Then tmpArtist = "NA"
'            tmpAlbum = wmp.currentMedia.getItemInfo("album")
'            If tmpAlbum = "" Then tmpAlbum = "NA"
'        End If
'
'        If (tmpTitle <> "") Then
'            tmpTitle = tmpTitleEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            tmpTitle = tmpTitleUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'        End If
'
'        If (tmpArtist <> "") Then
'            tmpArtist = tmpArtistEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            tmpArtist = tmpArtistUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'        End If
'
'        If (tmpAlbum <> "") Then
'            tmpAlbum = tmpAlbumEng & symbol & tmpFontNameEng & "%" & tmpFontSizeEng
'        Else
'            tmpAlbum = tmpAlbumUni & symbol & tmpFontNameUni & "%" & tmpFontSizeUni
'        End If
'    End If
'
'    sssendTrackInforToFullscreen = tmpTitle & "|" & tmpArtist & "|" & tmpAlbum
'End Function
'
''------------------------------------------------------------------------------------------------
''------------------------------------------------------------------------------------------------
''------------------------------------------------------------------------------------------------
'
