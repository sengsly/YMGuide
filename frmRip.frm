VERSION 5.00
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Begin VB.Form frmRip 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SlyCDGuide - Rip CD"
   ClientHeight    =   6750
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7485
   Icon            =   "frmRip.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6750
   ScaleWidth      =   7485
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin VB.Timer tmrRipComplete 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   0
      Top             =   5280
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfRip 
      Height          =   4815
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5055
      _cx             =   8916
      _cy             =   8493
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
   Begin WMPLibCtl.WindowsMediaPlayer Wmp 
      Height          =   795
      Left            =   1320
      TabIndex        =   1
      Top             =   5340
      Width           =   1095
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
      _cx             =   1931
      _cy             =   1402
   End
End
Attribute VB_Name = "frmRip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents EncodeCD As RipCD
Attribute EncodeCD.VB_VarHelpID = -1

' Variable for rip CD
Dim ripString() As String
Dim encodeAlbumID As Integer
Dim TrackCount As Integer, AlbumID As Long
Dim bout As Boolean
Dim bback As Boolean
Dim CD As New AudioCD
Dim currentList As AlbumType
Dim currentAlbum As New Albums

Private Function GetAllCDCountry() As String
   Dim i As Integer
   Dim loc_List As String
   For i = 0 To UBound(CountriesList)
      With CountriesList(i)
         If .ID = 16 Then
            If loc_List = "" Then
               loc_List = .path & "%" & .Name
            Else
               loc_List = loc_List & "%%" & .path & "%" & .Name
            End If
         End If
      End With
   Next
   GetAllCDCountry = loc_List
End Function
'*****************************************************************************'
'*****************************************************************************'
'FOR ENCODE CD FUNCTIONS
'*****************************************************************************'
'*****************************************************************************'
Public Sub LoadEncodeCD(ind As Integer, Optional args As String)
   Me.Hide
    On Error Resume Next
    SetBitRateValue
       
    ripString = Split(args, "~")
    encodeAlbumID = 0
    bback = False
    If args <> "" Then
        If ripString(1) = "TrackPage" Then encodeAlbumID = ripString(0)
    End If
       
       
    EncodeCD.RipPlayer = ripMusicWith
    If (EncodeCD.TrackCount <= 0) Then
        Exit Sub
    Else
          AlbumID = val(args)            ' modified at this part
          oldStatus = DisplayMini
          If boolStartPressed Then Exit Sub
          If WinMode = "Window Mode" Then
            If IsRegistered = True Then
               frmRip.Caption = reged & " - Rip CD"
            Else
               frmRip.Caption = unReg & " - Rip CD"
            End If
         End If
          If ScreenType = "Normal" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeNS.sly", swfRip
          ElseIf ScreenType = "wideScreen" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeWS.sly", swfRip
          ElseIf ScreenType = "mediumWideScreen" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeWSM.sly", swfRip
          ElseIf ScreenType = "mediumLargeWideScreen" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeWSH.sly", swfRip
          ElseIf ScreenType = "smallWideScreen" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeWSS.sly", swfRip
          ElseIf ScreenType = "largeWideScreen" Then
            FrmMain.LoadSwfFile App.path & "\sly\" & "EncodeWSL.sly", swfRip
          End If
          
          sendToFlash swfRip, "Lame_Path", Lame_Path
          sendToFlash swfRip, "FLAC_Path", FLAC_Path
          sendToFlash swfRip, "APE_Path", APE_Path
          sendToFlash swfRip, "getFormatList", GetEncodeFormatList
          sendToFlash swfRip, "ripWith", CStr(ripMusicWith)
          
          sendVariable2Flash swfRip, "Drives", GetDriveList
          sendVariable2Flash swfRip, "getDrive", "true"
          sendVariable2Flash swfRip, "strSHTT", b_tooltip
          sendVariable2Flash swfRip, "op", True
         
          Dim fd As DOMDocument
          Dim ft As IXMLDOMElement
          Set fd = New DOMDocument
          fd.Load FrmMain.CountryPath & "\Language.xml"
          Set ft = fd.firstChild.childNodes(0)
         
   '     cdroomError = False
         'Set curList = wmp.cdromCollection.Item(currentCDIndex).Playlist
         sendVariable2Flash swfRip, "UnloadIndex", ind
         sendVariable2Flash swfRip, "Languages", GetAllCDCountry
         sendVariable2Flash swfRip, "currentCountry", currentCountry
         sendVariable2Flash swfRip, "get_value_theme", SplitColor
         sendVariable2Flash swfRip, "ripfont", ft.getAttribute("FontEng")
         sendVariable2Flash swfRip, "load_encode", "true"
         sendVariable2Flash swfRip, "strLanguage", currentCountry
         sendVariable2Flash swfRip, "setLanguage", "true"
         
         sendVariable2Flash swfRip, "syn_volume", CStr(syn_vol)
         sendVariable2Flash swfRip, "syn_volume_change", CStr(change_vol)
         
         If WinMode = "FullScreen Mode" Then
           frmRip.Move FrmMain.left, FrmMain.top
           SetBorderStyle hwnd, True
           frmRip.WindowState = 2
         Else
              SetBorderStyle hwnd, False
              frmRip.WindowState = 0
              frmRip.Move FrmMain.left, FrmMain.top, formWidth + wborder, formHeight + hborder
         End If
         swfRip.Width = formWidth
         swfRip.Height = formHeight
         swfRip.top = 0
         swfRip.left = 0
         
         sendToFlash swfRip, "ripType", CStr(ripMusicWith)
         sendToFlash swfRip, "itunesInstalled", CStr(IsItunesInstalled)
         
         FrmMain.current_status swfRip
         
         Me.Show              ' test
         swfRip.SetFocus      ' test
    End If
End Sub

Public Sub ClearList()
    sendVariable2Flash swfRip, "Tracks", ""
    sendVariable2Flash swfRip, "getTrack", "true"
    
    sendVariable2Flash swfRip, "CD", ""
    sendVariable2Flash swfRip, "getInfo", "true"
    currentList.AlbumID = 0
End Sub

Public Sub ReadBrowseCD()
    FillTrack currentList
    If EncodeCD.TrackCount > 0 Then
        currentList.CDDBDiskID = CurrentCDID
        Call currentAlbum.LoadAlbum(currentList, AlbumID)
        DisplayTracks
        ReadSuccess = True
    Else
        ReadSuccess = False
    End If
End Sub

Public Sub FillTrack(fillObj As AlbumType)
  Dim i As Integer
  
  With fillObj
    .SetTrackCount EncodeCD.TrackCount
    .ALBUM = "Unknown Album"
    .Genre = "Unknown"
    .Year = "2003"
    .AlbumArtist = "Unknown Album Artist"
    .AlbumImagePath = ""
    .AlbumID = 0
  
      For i = 1 To .TrackCount
        .Tracks(i).Title = "Track" & Format(i, " 00")
        .Tracks(i).ARTIST = "Track Artist"
        .Tracks(i).RecordIndex = -1
      Next
  End With
End Sub

Private Function CurrentCDID() As String
   Dim DiskTOC As String
   DiskTOC = EncodeCD.GetToc
   If DiskTOC <> "" Then CurrentCDID = Hex(CD.DiskID(DiskTOC))
End Function

Public Sub DisplayTracks()
   On Error Resume Next
    sendVariable2Flash swfRip, "Tracks", GetTitle
    sendVariable2Flash swfRip, "getTrack", "true"
    
    sendVariable2Flash swfRip, "CD", GetAlbumInfo
    sendVariable2Flash swfRip, "getInfo", "true"
End Sub

Private Function GetAlbumInfo() As String
   GetAlbumInfo = currentList.AlbumArtist + Delimiter + currentList.ALBUM + Delimiter + currentList.Genre + Delimiter + currentList.Year
End Function

Private Sub EncodeCD_cdrommediachange()
  If EncodeCD.TrackCount = 0 Then
    If Not boolStartPressed Then
       TrackClearList
   End If
  End If
End Sub

Private Sub EncodeCD_RipCompleted()
   If boolStartPressed Then
      'occur when windows media windows is closed
      On Error Resume Next
      currentAlbum.SaveAlbumTrackPath currentList
      'ripMusicWith = ripWithiTunes
      boolStartPressed = False
      TrackClearList
      FrmMain.refreshPlaylistPlayer
      Unload Me
   End If
End Sub

Private Sub Form_Load()
   Set EncodeCD = New RipCD
   Set EncodeCD.wmp = wmp
   Set currentList = New AlbumType
   EncodeCD.Timer = tmrRipComplete
   Set EncodeCD.currentAlbumInfo = currentList
End Sub

Private Sub Form_Unload(Cancel As Integer)
   'if
    Unload Me
End Sub
Private Function GetEncodeFormatList() As String

   Dim i As Long, lpData As Variant
   Dim lpString As String
   lpData = EncodeCD.GetEncoders()
   If Not IsEmpty(lpData) Then
      For i = 0 To UBound(lpData)
         If lpString <> "" Then lpString = lpString & Delimiter & lpData(i) Else lpString = lpData(i)
      Next
   End If
   
   GetEncodeFormatList = lpString
End Function
Private Sub swfRip_FSCommand(ByVal command As String, ByVal args As String)
Dim intTrackNumber As Integer, strTitle As String
    Dim ImgPath As String
    Dim tmpp As String
    Dim spl_PP() As String
    Select Case command
        Case "popup"
            popUp FrmMain.wmp, True
        Case "valProAPE"
            EncodeCD.APEProgramPath = args
        Case "valProLame"
            EncodeCD.LameProgramPath = args
        Case "valProFLAC"
            EncodeCD.FlacProgramPath = args
        Case "valPreset"
            EncodeCD.LamePreset = args
        Case "valLame"
            EncodeCD.ExternalEncoder = args
        Case "set_program_path"
            spl_PP = Split(args, "|~|")
            If EncodeCD.ExternalEncoder = LameEncoder Then
               Lame_Path = spl_PP(0)
               EncodeCD.LameProgramPath = spl_PP(0)
               EditSetting MainSettingXML, 0, "LamePath", spl_PP(0)
            ElseIf EncodeCD.ExternalEncoder = FlacEncoder Then
               FLAC_Path = spl_PP(0)
               EncodeCD.FlacProgramPath = spl_PP(0)
               EditSetting MainSettingXML, 0, "FLACPath", spl_PP(0)
            ElseIf EncodeCD.ExternalEncoder = MonkeyAudio Then
               APE_Path = spl_PP(0)
               EncodeCD.APEProgramPath = spl_PP(0)
               EditSetting MainSettingXML, 0, "APEPath", spl_PP(0)
            End If
        Case "Lame"
            spl_PP = Split(args, "|~|")
            EditSetting spl_PP(1), 2, "convert_wav_extension", UCase(EncodeCD.ExtensionNew)
        Case "preset"
            spl_PP = Split(args, "|~|")
            EncodeCD.LamePreset = spl_PP(0)
            EditSetting spl_PP(1), 2, "lamp_encoder_preset", spl_PP(0)
        Case "ProgramPath"
            spl_PP = Split(args, "|~|")
            
            cdl.flags = 4
            cdl.filter = "Application File|*.exe"
            cdl.filename = ""
            cdl.ShowOpen Me.hwnd
            tmpp = cdl.filename
            
            If tmpp <> "" Then
               sendToFlash swfRip, "programPath", tmpp
            End If
        
        Case "getiTunesInfo"
'            sendToFlash swfRip, "getFormatList", GetEncodeFormatList
'            sendToFlash swfRip, "ripWith", CStr(ripMusicWith)
'            sendToFlash swfRip, "changeRipType", "True"
            
        Case "ripMusicWith"
        
            If args = "ripWithiTunes" Then
               ripMusicWith = ripWithiTunes
            Else
               ripMusicWith = ripWithWindowMedia
            End If
            EncodeCD.RipPlayer = ripMusicWith
            EditSetting MainSettingXML, 2, "ripWith", args
            
            
            sendToFlash swfRip, "getFormatList", GetEncodeFormatList
            sendToFlash swfRip, "ripWith", CStr(ripMusicWith)
            sendToFlash swfRip, "changeRipType", "True"
            
        Case "setSlideShow"
            FrmMain.setSlideShows
            sendToFlash swfRip, "slideShow", CStr(b_slideshow)
        Case "clearTimeSlideshow"
            interValCount = 0
        Case "Visualization"
            'FrmMain.cmdFull_Click
            FrmMain.change_visualization_type
        Case "setHideMouse"
            FrmMain.setHideMouse args
        Case "Key"
            'FrmMain.PressKeyInternalPlayer args
            handleShortCutKey CLng(args)
        Case "changeWindow"
            If WinMode = "FullScreen Mode" Then
                WinMode = "Window Mode"
            Else
                WinMode = "FullScreen Mode"
            End If
        Case "offScreen"
            SetCursorPos ScreenX, ScreenY
        Case "ShowPlayer"
            'Internalplayer.ShowMe
        Case "ShowScan"
'''            frmScan.showMe
        Case "ShowOption"
            FrmMain.LoadSwfSettingPage "5"
'''            FrmMain.NameSwf = "swfrip"
        Case "Minimize"
            'FrmMain.WindowState = 1
            Me.WindowState = 1
            
        Case "Exit"
            tmrRipComplete.Interval = 100
            tmrRipComplete.Enabled = True
            bout = True
        Case "Search"
            On Error Resume Next
            Load FrmMain.Swf(2)
            FrmMain.LoadSwfSearchPage "5"
            
      Case "PlayList"
            On Error Resume Next
            Load FrmMain.Swf(3)
            FrmMain.LoadSwfPlayListPage "5"
         
      Case "SendCountryPath"

            FrmMain.CountryPath = args
         
      Case "Back"
        If bback = True Then
            Me.WindowState = 1
        Else
            tmrRipComplete.Interval = 100
            tmrRipComplete.Enabled = True
            bout = True
        End If
        
      Case "SendDrive"
         'currentCDIndex = args
         EncodeCD.RipIndex = args
         
      Case "SendLanguage"
        If Not boolStartPressed Then
            RipCountry = args
            currentList.AlbumLanguage = args
            currentAlbum.SetLanguage args
            If EncodeCD.TrackCount = 0 Then
               frmRip.ClearList
            Else
               Dim skip As Boolean
               If encodeAlbumID > 0 Then
                   skip = True
                   AlbumID = encodeAlbumID
               Else
                   skip = False
               End If
               frmRip.ReadBrowseCD
            End If
        End If
        
      Case "Refresh"
         frmRip.ReadBrowseCD
            
      Case "ChangeFolder"
        On Error GoTo Ex
        Set fItem = bf.BrowseForFolder(hwnd, "Browse for New PlayList Path", 0).Items.item
        
        sendVariable2Flash swfRip, "Folder", fItem.path
        sendVariable2Flash swfRip, "changeFolder", "true"
      
      Case "SettingPath"
         On Error GoTo Ex
         EditXML FrmMain.CountryPath & "\Language.xml", 2, "Destination", args
      Case "Group"
         EditXML FrmMain.CountryPath & "\Language.xml", 2, "Group", args
            
      Case "SettingFormat"
         On Error GoTo Ex
         If ripMusicWith = ripWithWindowMedia Then
            EncodeCD.Extension = SetCopyCDFormat(val(args))
            EditXML FrmMain.CountryPath & "\Language.xml", 2, "Format", args
         ElseIf ripMusicWith = ripWithiTunes Then
            args = CLng(args)
            If args = 5 Or args = 6 Or args = 7 Then
               EncodeCD.EncodeFormat = 4
            Else
               EncodeCD.EncodeFormat = args
            End If
            EditXML FrmMain.CountryPath & "\Language.xml", 2, "iTunesFormat", CStr(args)
         End If
            
      Case "SettingRate"
         On Error GoTo Ex
         EditXML FrmMain.CountryPath & "\Language.xml", 2, "Quantity", args
         SetBitrate CInt(args)
            
      Case "SettingTitle"
         On Error GoTo Ex
         EditXML FrmMain.CountryPath & "\Language.xml", 2, "FileTitle", args
         SetCDRecordFileDetail args
        
      Case "SettingSeparator"
         EditXML FrmMain.CountryPath & "\Language.xml", 2, "Separator", Trim(args)
         SetSeparator args
      
      Case "RipDestination"
         WMPSetting.CDRecordPath = args
         EncodeCD.DestinationFolder = args + "\" + currentList.AlbumArtist + "\" + currentList.ALBUM
      Case "Start"
         bback = True
         SetRegistry
         If ReadSuccess And (Not boolStartPressed) Then
            boolStartPressed = True
            EncodeCD.StartRip args
         End If
      Case "DownLoadPic"
            If Not isFileExist(args) Then
                sendVariable2Flash swfRip, "RefreshPicAlbum", App.path & "\Sly\CDIcon.sly"
                FrmMain.StartDownload , args & "%~%" & currentList.AlbumID & "%~%" & currentCountry
            End If
      Case "BrowserAlbum"
         
         cdl.flags = 4
         cdl.filter = "*.jpg|*.jpg"
         cdl.ShowOpen Me.hwnd
         ImgPath = cdl.filename
         If (cdl.filename <> "") Then
            sendVariable2Flash swfRip, "imgAlbumPath", cdl.filename
            sendVariable2Flash swfRip, "getAlbum", "true"
         End If
      
      Case "TrackTitle"
         intTrackNumber = left(args, 2)
         strTitle = mID(args, 3)
         currentList.Tracks(intTrackNumber).Title = strTitle
      
      Case "AlbumNum"
        strTitle = currentAlbum.GetAlbumTitle(args, TrackCount, AlbumID)
        sendVariable2Flash swfRip, "AlbumTitles", strTitle
        sendVariable2Flash swfRip, "getAT", "true"
    
      Case "SelectAlbum"
         AlbumID = args
         frmRip.ReadBrowseCD
         
      Case "CopyImageAlbum"
         currentList.AlbumImagePath = CutFile(args)
         
      Case "Artist"
         currentList.AlbumArtist = args
         
      Case "Album"
         currentList.ALBUM = args
         
      Case "Genre"
         currentList.Genre = args
         
      Case "Year"
         currentList.Year = args
         
      Case "Cancel"
         FillTrack currentAlbum
         DisplayTracks

      Case "mb"
         Debug.Print args
       End Select
       
Ex:
    Exit Sub
End Sub

Private Sub tmrRipComplete_Timer()
   If bout = True Then
      bout = False
      Unload Me
   End If
End Sub

'..........................Muny function..................


'Private Sub lsvTrack_ItemCheck(ByVal item As MSComctlLib.ListItem)
'   currentList.Tracks(item.Index).Selected = item.Checked
'End Sub
Function CutFile(param As String) As String
   If left(param, 7) = "file://" Then
      CutFile = mID(param, 8)
   Else
      CutFile = param
   End If
End Function

Public Sub TrackClearList()
   ReadBrowseCD
   sendVariable2Flash swfRip, "Tracks", ""
   sendVariable2Flash swfRip, "getTrack", "true"
   
   sendVariable2Flash swfRip, "CD", ""
   sendVariable2Flash swfRip, "getInfo", "true"
   currentList.AlbumID = 0
End Sub

' END OF RIP CD FUNCTIONS
'*****************************************************************************'

Public Sub ScaleScane()
    If WinMode = "FullScreen Mode" Then
        SetBorderStyle hwnd, True
        Me.WindowState = 2
    Else
        SetBorderStyle hwnd, False
        Me.WindowState = 0
        Me.Move FrmMain.left, FrmMain.top, FrmMain.Width, FrmMain.Height
    End If
End Sub
Private Function GetTitle() As String
   Dim i As Integer
   Dim strPlus As String
   Dim strRet As String
   For i = 1 To currentList.TrackCount
      If i <> 1 Then strPlus = Delimiter Else strPlus = ""
      strRet = strRet + strPlus + currentList.Tracks(i).Title
   Next
   GetTitle = strRet
End Function
Private Function GetDriveList() As String
   Dim i As Long, lpData As Variant
   Dim strPlus As String
   
   lpData = EncodeCD.AudioDrives()
   If Not IsEmpty(lpData) Then
      For i = 0 To UBound(lpData)
         If i = 0 Then
            strPlus = lpData(i)
         Else
            strPlus = strPlus + Delimiter + lpData(i)
         End If
      Next
   End If
End Function

