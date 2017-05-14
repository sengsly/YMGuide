VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmSlideShow 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   4755
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7050
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   4755
   ScaleWidth      =   7050
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog cdl 
      Left            =   3240
      Top             =   2160
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Timer CloseSlide 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   360
      Top             =   2640
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   360
      Top             =   2160
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash SlideShow 
      Height          =   4815
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      _cx             =   9128
      _cy             =   8493
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
Attribute VB_Name = "frmSlideShow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public server_image_slideshow_paths As String


Private Sub Form_Activate()
   On Error GoTo Error
   Call SetWindowPos(hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
   Exit Sub
Error:
   WriteEvent "Form_Activate", Err.Description, Err.Source
End Sub

Private Sub Form_Load()
   On Error GoTo Error

   LoadSlideshow = True
   SlideShow.Height = ScreenY * Screen.TwipsPerPixelY
   SlideShow.Width = ScreenX * Screen.TwipsPerPixelX
   
   SlideShow.top = 0
   SlideShow.left = 0
   
   LoadSideShow
   CloseSlide.Enabled = True
   eventMouseClick
   #If debugging = 0 Then
      oldSlideShowFormAddress = SetWindowLong(hwnd, GWL_WNDPROC, AddressOf SlideShowWndProc)
   #End If
   
'''   If playMusicWith = WindowMedia And b_play = True Then
      FrmMain.wmp.UiMode = "Invisible"
      CPlayer.Visible = False
'''   End If
   'SlideShow.left = ((ScreenX * 15) - SlideShow.Width) / 2
   Exit Sub
Error:
   WriteEvent "Form_Load", Err.Description, Err.Source
End Sub
Sub LoadSideShow()
On Error GoTo Error
   Dim path As String
   If ScreenType = "Normal" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowNS.sly"
   ElseIf ScreenType = "mediumWideScreen" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowWSM.sly"
   ElseIf ScreenType = "wideScreen" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowWS.sly"
   ElseIf ScreenType = "mediumLargeWideScreen" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowWSH.sly"
   ElseIf ScreenType = "smallWideScreen" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowWSS.sly"
   ElseIf ScreenType = "largeWideScreen" Then
      LoadSwf SlideShow, App.path & "\sly\SlideShowWSL.sly"
   End If
        
   sendVariable2Flash SlideShow, "FontColor", FrmMain.GetAttSetting(0, "FontColor")
   sendVariable2Flash SlideShow, "BgColor", FrmMain.GetAttSetting(0, "ColorBg")
   sendVariable2Flash SlideShow, "ColorBar", FrmMain.GetAttSetting(0, "ColorBar")
   sendVariable2Flash SlideShow, "ShowFileName", FrmMain.GetAttSetting(1, "ShowFileName")
   sendVariable2Flash SlideShow, "Scrolling", FrmMain.GetAttSetting(1, "Scrolling")
   sendVariable2Flash SlideShow, "DelayImage", FrmMain.GetAttSetting(1, "Delay")
   sendVariable2Flash SlideShow, "PerImage", FrmMain.GetAttSetting(1, "ImageSize")
   sendVariable2Flash SlideShow, "Effect", FrmMain.GetAttSetting(1, "Effect")
   sendVariable2Flash SlideShow, "Stretch", FrmMain.GetAttSetting(1, "Stretch")
   sendVariable2Flash SlideShow, "Random", SlideShowRandom
   
   sendToFlash SlideShow, "clientType", CWinsock.LoggedType
   sendToFlash SlideShow, "karaoke_voice", CStr(b_karaoke_voice)
   If CWinsock.LoggedAs(remoteControl) Then
      ShowPlayState2Flash (run_PlayState = 1) 'Playing
   Else
      sendToFlash SlideShow, "Play", CStr(b_play)
   End If
   sendToFlash SlideShow, "Loop", CStr(b_loop)
   sendToFlash SlideShow, "Shuffle", CStr(b_shuffle)
   sendToFlash SlideShow, "Mute", CStr(b_mute)
   sendToFlash SlideShow, "SlideShow", CStr(b_slideshow)
   sendToFlash SlideShow, "Volume", CStr(WaveVolume)
   sendToFlash SlideShow, "tooltip", CStr(b_tooltip)
   sendToFlash SlideShow, "Color", s_button_color
   sendToFlash SlideShow, "Alpha", s_button_color_alpha
   sendToFlash SlideShow, "SelectedColor", s_button_color_selected
   sendToFlash SlideShow, "SelectedAlpha", s_button_color_selected_alpha
   sendToFlash SlideShow, "TrackShow", str_infoPopup
   sendToFlash SlideShow, "default", str_infoPopup
   sendToFlash SlideShow, "ads", CStr(b_ads)
   sendToFlash SlideShow, "reg", CStr(b_reg)
   sendToFlash SlideShow, "rotate", CStr(b_rotate)
   sendVariable2Flash SlideShow, "syn", LCase(syn)
   sendVariable2Flash SlideShow, "syn_volume", CStr(syn_vol)
   sendVariable2Flash SlideShow, "syn_volume_change", CStr(change_vol)
   sendToFlash SlideShow, "server_allow_slideshow", CStr(b_AllowSlideshow)
   sendToFlash SlideShow, "server_loadSlideshow", LCase(server_loadSlideshow)
   
   FrmMain.current_status SlideShow
   
   FrmMain.display_seek_in_player
   
   CWinsock.Send2Client WS_COMMAND, 0, "server_loadSlideshow&&&" & LoadSlideshow
   
   GetSlideshowPath LanSlide, AlbumIDSlide
   Exit Sub
Error:
   WriteEvent "LoadSlideshow", Err.Description, Err.Source
End Sub
Function getStrPathSlideShow(path As String) As String
On Error GoTo Error
   On Error Resume Next
   Dim fs, f, f1, sf
    GetImage (path)
    'Set fs = CreateObject("Scripting.FileSystemObject")
    Set f = fso.GetFolder(path)
    Set sf = f.SubFolders
    For Each f1 In sf
        getStrPathSlideShow (path & "\" & f1.Name)
    Next
   getStrPathSlideShow = StringPathSlide
   Exit Function
Error:
   WriteEvent "getStrPathSlideShow", Err.Description, Err.Source
End Function
Function GetImage(path As String) As String
On Error GoTo Error
   Dim filename As String
   sepSlide = "%~%"
   
   filename = Dir(path & "\*.jpg")
   While filename <> ""
      If LCase(right$(filename, 4)) = LCase(".jpg") Then
         If StringPathSlide = "" Then
            StringPathSlide = path & "\" & filename
         Else
            StringPathSlide = StringPathSlide + sepSlide + path & "\" & filename
         End If
      End If
      filename = Dir()
   Wend
   Exit Function
Error:
   WriteEvent "GetImage", Err.Description, Err.Source
End Function


Public Sub SlideShow_FSCommand(ByVal command As String, ByVal args As String)
On Error GoTo Error
   Select Case command
        Case "new_request_permission"
            str_permission = args
            EditSetting MainSettingXML, 0, "permission", str_permission
        Case "not_show_again"
            b_default_permission = True
            EditSetting MainSettingXML, 0, "default_per", LCase(b_default_permission)
            b_deny = False
            EditSetting MainSettingXML, 0, "deny", LCase(b_deny)
            
        Case "auto_allow"
            FrmMain.start_allow_client_connect str_permission
        Case "deny"
            FrmMain.server_deny
        Case "start_allow_connect"
            FrmMain.start_allow_client_connect args
        Case "allow_login_permission"
            FrmMain.receive_permission_from_PHP args
            FrmMain.send_login_type_to_client
        Case "popup"
            popUp True
        Case "mini"
           handleMinicommand args
           ' miniCommand args
           Exit Sub
        Case "clients"
           If CWinsock.LoggedType <> ServerMode Then
              CWinsock.Send2Server WS_COMMAND, args
           End If
        Case "getServerData"
           If CWinsock.LoggedType <> ServerMode Then
              CWinsock.Send2Server WS_COMMAND, command & de_Record & args
           End If
        Case "other"
           If CWinsock.LoggedType <> ServerMode Then
              CWinsock.Send2Server WS_COMMAND, command & de_Record & args
           End If
        Case "servers", "Command"
           If CWinsock.LoggedType = ServerMode Then
              CWinsock.Send2Client WS_COMMAND, 0, args
           End If
    End Select
    
   If command = "ExitSlideShow" Or command = "seek_vol_slideshow" Then
      exit_slideshow args
   ElseIf command = "setRotate" Then
      b_rotate = args = "true"
      EditSetting MainSettingXML, 1, "rotate", LCase(b_rotate)
   ElseIf command = "createTempImage" Then
       If current_copy_image_slideshow_path <> args Then
           Dim tempPathImage As String
           tempPathImage = fso.GetParentFolderName(args)
           If Dir(App.path & "\Sly\tmp_pic.jpg") <> "" Then fso.DeleteFile App.path & "\Sly\tmp_pic.jpg", True
           create_new_image args, App.path & "\Sly\tmp_pic.jpg"
           sendToFlash SlideShow, "loadTempImage", App.path & "\Sly\tmp_pic.jpg"
       Else
           sendToFlash SlideShow, "loadTempImage", "None"
       End If
   ElseIf command = "SendKeyNum" Then
        numKeyPress args
   ElseIf command = "BrowseSlidePath" Then
        
        Call SetWindowPos(frmSlideShow.hwnd, -2, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
        Dim tttt() As String
        Dim tmpFolderName As String
        tttt = Split(FrmMain.SplitSly, "~")
        LoadBrowseInSlideshow = True
        tmpFolderName = BrowseForFolder(tttt(0), frmSlideShow.hwnd)
        LoadBrowseInSlideshow = False
        Call SetWindowPos(frmSlideShow.hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
        If tmpFolderName = "" Then tmpFolderName = tttt(0)
        
        If IndexSwf = 6 Then
            sendVariable2Flash FrmMain.Swf(6), "PassSlidePathValue", tmpFolderName  'fItem.path
            sendVariable2Flash FrmMain.Swf(6), "GetColorReady", "true"
        End If
        
        EditSetting MainSettingXML, 1, "ImagePath", tmpFolderName 'fItem.path
        internal_slideshow_path = tmpFolderName
        FrmMain.set_slideshow_path
        'FrmMain.SplitSly = ReplaceStrSpl(FrmMain.SplitSly, 0, tmpFolderName, "~")
        EditRegistrySlide ImageDir, tmpFolderName 'fItem.path
        
        If int_track_count > 0 Then
            Dim cur_id As Long
            
            cur_id = int_current_index
            
            AlbumIDSlide = Infos(cur_id).trackAlbumID
            LanSlide = Infos(cur_id).TrackLan
            If LoadSlideshow = True And StoreAlbumIDSlide <> AlbumIDSlide Then
                GetSlideshowPath LanSlide, AlbumIDSlide
                StoreAlbumIDSlide = AlbumIDSlide
            Else
                GetSlideshowPath LanSlide, AlbumIDSlide
                StoreAlbumIDSlide = AlbumIDSlide
            End If
        Else
            GetSlideshowPath "", ""
            StoreAlbumIDSlide = ""
        End If
        
'exitsub:
'    frmSlideShow.Enabled = True
'    Call SetWindowPos(frmSlideShow.hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
   ElseIf command = "Previous" Then
        miniCommand "Previous|:|True"
   ElseIf command = "Play" Then
        miniCommand "Play|:|True"
   ElseIf command = "Pause" Then
        miniCommand "Pause|:|True"
   ElseIf command = "Mute" Then
        miniCommand "Mute|:|" & args
   ElseIf command = "Stop" Then
        miniCommand "Stop|:|True"
   ElseIf command = "Next" Then
        miniCommand "Next|:|True"
   ElseIf command = "SlideShow" Then
        LoadSlideshow = False
        Timer1.Enabled = True
        FrmMain.swf_FSCommand 0, "setSlideShow", True
        If IndexSwf = 6 Then
            sendVariable2Flash FrmMain.Swf(6), "SetSlideValue", "No"
            sendVariable2Flash FrmMain.Swf(6), "BackSlideShow.ButtonSetSlideShow.chk._visible", "0"
        End If
   ElseIf command = "Shuffle" Then
        miniCommand "Shuffle|:|" & args
   ElseIf command = "Repeat" Then
        miniCommand "Repeat|:|" & args
   ElseIf command = "Playlist" Then
       If str_swfNames = "Fullscreen" Then
            'FrmMain.Fullscreen False
            FrmMain.swf_FSCommand IndexSwf, "ShowPlayListPlayer", ""
            LoadSlideshow = False
            Timer1.Enabled = True
            Exit Sub
       ElseIf str_swfNames = "Micro" Then
            FrmMain.SWF_FMA_FSCommand 2, "Maximize", True
            If str_swfNames = "Fullscreen" Then
                FrmMain.SWF_FMA_FSCommand 1, "SHFull", True
                FrmMain.SWF_FMA_FSCommand 1, "Playlist", True
                LoadSlideshow = False
                Timer1.Enabled = True
                Exit Sub
            End If
            
       End If
       '............
       If IndexSwf = 1 Or IndexSwf = 7 Or IndexSwf = 8 Or IndexSwf = 10 Then
             FrmMain.Swf(IndexSwf).Visible = False
             FrmMain.swf_FSCommand -1, "showPlaylistPlayer", str(IndexSwf)
       ElseIf IndexSwf <> 4 Then
             If IndexSwf <> 0 Then
                 FrmMain.Swf(IndexSwf).Visible = False
                 FrmMain.LoadSwfPlayListPlayerPage str(IndexSwf)
                 FrmMain.ShowOrHidePlayer True
             Else
                 FrmMain.swf_FSCommand 0, "ShowPlayListPlayer", ""
             End If
       End If
       LoadSlideshow = False
       Timer1.Enabled = True
   ElseIf command = "redownload" Then
      If UBound(arr_redownload) = -1 Then
         ReDim Preserve arr_redownload(-1 To 0)
         arr_redownload(0) = CInt(args)
         redownload_slideshow
      Else
         Dim ii As Integer
         Dim e As Boolean
         For ii = 0 To UBound(arr_redownload)
            If CInt(arr_redownload(ii)) = CInt(args) Then
                e = True
            End If
         Next ii
         If e = False Then
            Dim m As Integer
            m = UBound(arr_redownload) + 1
            ReDim Preserve arr_redownload(-1 To m)
            arr_redownload(m) = CInt(args)
         End If
      End If
   ElseIf command = "Seek" Then
        miniCommand "seek" & "|:|" & args 'temp_array(2)
   ElseIf command = "server_slideshow_index" Then
       CWinsock.Send2Client WS_COMMAND, 0, "server_slideshow_index&&&" & args
   ElseIf command = "AddFile" Then
      Call SetWindowPos(frmSlideShow.hwnd, -2, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
         miniCommand "AddMusic" & "|:|" & "False"
      Call SetWindowPos(frmSlideShow.hwnd, -1, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
   ElseIf command = "Volume" Then
        miniCommand "Volume|:|" & args
   ElseIf command = "reply" Then
      Debug.Print args
   End If
   Exit Sub
Error:
   WriteEvent "SlideShow_FSCommand", Err.Description, Err.Source
End Sub
Public Sub exit_slideshow(args As String)
On Error GoTo Error
   If args = "Close" Then
      LoadSlideshow = False
      Timer1.Enabled = True
      FrmMain.wmp.UiMode = "none"
      popUp
   Else
      If args = "90" Or args = "88" Or args = "67" Or args = "86" Or args = "66" Or args = "77" Or args = "83" Or args = "82" Or args = "187" Or args = "189" Or args = "33" Or args = "34" Then
         If args = 33 Or args = 34 Then
            If LoadSlideshow = True Then sendToFlash SlideShow, "showSeek", "True"
         ElseIf args = 189 Or args = 187 Then
            If LoadSlideshow = True Then sendToFlash SlideShow, "showVolume", "True"
         End If
         handleShortCutKey CLng(args)
      Else
         LoadSlideshow = False
         Timer1.Enabled = True
      End If
   End If
   Exit Sub
Error:
   WriteEvent "exit_slideshow", Err.Description, Err.Source
End Sub

Sub delete_file_image_slideshow_copying_not_completed(FN As String)
On Error GoTo Error
    If FN <> "" Then
        If Dir(FN) <> "" Then fso.DeleteFile FN, True
    End If
    Exit Sub
Error:
   WriteEvent "delete_file_image_slideshow_copying_not_completed", Err.Description, Err.Source
End Sub
Private Sub Timer1_Timer()
On Error GoTo Error
    If frmSlideShow.Enabled = True Then
        If Dir(App.path & "\Sly\tmp_pic.jpg") <> "" Then
            fso.DeleteFile (App.path & "\Sly\tmp_pic.jpg")
        End If
        current_copy_image_slideshow_path = ""
        interValCount = 0
        Me.Visible = False
        currentSlideShowPath = ""
        LoadSlideshow = False
        StringPathSlide = ""
        'Call SetWindowPos(hwnd, -2, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
        SetWindowLong hwnd, GWL_WNDPROC, oldSlideShowFormAddress
        CWinsock.Send2Client WS_COMMAND, 0, "slideshow&&&function||retimer"
        'FrmMain.SetFocus
        Unload Me
        CWinsock.Send2Client WS_COMMAND, 0, "server_loadSlideshow&&&" & LoadSlideshow
        If str_swfNames = "Micro" Then
            Call SetWindowPos(FrmMain.hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE)
        Else
            If b_play = True And FrmMain.picwmp.Visible = True Then
               FrmMain.wmp.UiMode = "None"
               CPlayer.Visible = True
            End If
            Call SetWindowPos(FrmMain.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE)
        End If
    End If
    Exit Sub
Error:
   WriteEvent "Timer1_Timer", Err.Description, Err.Source
End Sub

