Attribute VB_Name = "Maincode"
Option Explicit
Public bf As New Shell
Public fItem As FolderItem
Public MainPath As String
Public MainPathImage As String
Public MainSettingXML As String

Public xmlTrack As DOMDocument
Public xmlTrackRoot As IXMLDOMElement
Public xmlTrackName As IXMLDOMElement

Public xmlPlaylist As DOMDocument
Public xmlPlaylistRoot As IXMLDOMElement
Public xmlPlaylistName As IXMLDOMElement

Public StPlayer As String
Public StrPathPic As String
Public NoTrack As Integer

Public mod_IndexSwf As Integer
Public mod_CountImage As Integer
'...........Download
'''Public Completing As Boolean
Public namePlayList As String
Public Const StWaveSpl = "%~%"
Public LogPath As String
Public BrowseQuery As New cLanguage
Public CSearch As New cLanguage

'...Slideshow value

Dim TempArr() As Tracks

Public fso As New FileSystemObject
Public cdl As New cCommonDialog
Public Log As New cLog
Public cDownload As New cIEDownload
Public CBrowse As New cLanguage
Public JSON As New CJSON
Public AWS As New AWSS3Heper
'Public CWmp As WindowsMediaPlayer
Public CPlayer As Player

Public CUserLogin As New classUserLogin
Public clsKeyboard As New clsKeyboardLayout
Public IndexPlayTrack  As Integer


Public Sub AddNewPath(path As String, Folder As String, Optional DefaultName As String = "Default")
   On Error GoTo ErrRe
   Dim f As Boolean
   Dim i As Long
   Dim fullPath As String
   f = False
   Set xmlPlaylist = New DOMDocument
   fullPath = path & "\PlayListPaths.xml"
   If Not isFileExist(fullPath) Then
        CreateNewFile path, "PlayListPaths", "PlayListPath"
   End If
   
   xmlPlaylist.Load fullPath
   Set xmlPlaylistRoot = xmlPlaylist.firstChild
   For i = 0 To xmlPlaylistRoot.childNodes.Length - 1
     If LCase(Folder) = LCase(xmlPlaylistRoot.childNodes(i).Text) Then
         f = True
         Exit For
     End If
   Next
ErrRe:
   If f = False Then
      Set xmlPlaylistName = xmlPlaylist.createElement("PlayListPath")
      xmlPlaylistName.Text = Folder
      xmlPlaylistName.setAttribute "Name", DefaultName
      xmlPlaylistName.setAttribute "ImpPath", Folder & "\folder.jpg"
      xmlPlaylistRoot.appendChild xmlPlaylistName
   End If
   xmlPlaylist.Save fullPath
End Sub
Public Sub DeletePath(pathName As String, Name As String)
   On Error GoTo Error
   Dim xmlnode As IXMLDOMElement
   Set xmlPlaylist = New DOMDocument
   xmlPlaylist.Load (pathName & "\PlayListPaths.xml")
   Set xmlnode = xmlPlaylist.selectSingleNode("PlayListPaths/PlayListPath[@Name='" & Name & "']")
   If Not xmlnode Is Nothing Then
      xmlPlaylist.firstChild.removeChild xmlnode
      xmlPlaylist.Save pathName & "\PlayListPaths.xml"
   End If
   Exit Sub
Error:
   WriteEvent "DeletePath", Err.Description, Err.Source
End Sub
Public Sub AddNewPlayList(path As String, Y As String, Sp As String, ImgPath As String, first As Boolean)
   On Error GoTo Error
         If isFileExist(ImgPath) = False Then ImgPath = App.path & "\sly\PlaylistIcon.sly"
         If IndexSwf = 3 Then sendVariable2Flash FrmMain.Swf(3), "PathFolderPlaylist", ImgPath
         If fso.FolderExists(path & "\PlayLists") Then
            If isFileExist(path & "\PlayLists\PlayLists.xml") = False Then
              CreateNewFile path & "\PlayLists\", "PlayLists", "PlayList"
            End If
         Else
            fso.CreateFolder path & "\PlayLists"
            CreateNewFile path & "\PlayLists\", "PlayLists", "PlayList"
         End If
            'slide show edit
            ' EditRegistrySlide ImageDir, Sp
            Set xmlPlaylist = New DOMDocument
            xmlPlaylist.Load path & "\PlayLists\PlayLists.xml"
            Set xmlPlaylistRoot = xmlPlaylist.firstChild
            
            Set xmlPlaylistName = xmlPlaylist.createElement("PlayList")
            xmlPlaylistName.setAttribute "SlidePath", Sp
            xmlPlaylistName.setAttribute "ImgPath", ImgPath
            xmlPlaylistName.Text = Y
            xmlPlaylistRoot.appendChild xmlPlaylistName
            xmlPlaylist.Save path & "\PlayLists\PlayLists.xml"
            If first Then
               CreateNewFile path & "\PlayLists\", Y, "Track"
            End If
         Exit Sub
      
   Exit Sub
Error:
   WriteEvent "AddNewPlayList", Err.Description, Err.Source
End Sub
Public Sub RenamePlayList(pathName As String, newName As String, OldName As String)
   On Error GoTo Error
        If LCase(OldName) <> LCase(newName) Then
         fso.CopyFile pathName & "\PlayLists\" & OldName & ".xml", pathName & "\PlayLists\" & newName & ".xml", True
         fso.DeleteFile pathName & "\PlayLists\" & OldName & ".xml", True
        End If
        
   Exit Sub
Error:
   WriteEvent "RenamePlayList", Err.Description, Err.Source
End Sub
Public Sub DeletePlayList(pathName As String, index As Integer, Name As String)
   On Error GoTo Error
       '   PathName = Replace(PathName, "/", "\")
        Dim t As IXMLDOMElement
        Set xmlPlaylist = New DOMDocument
        xmlPlaylist.Load (pathName & "\PlayLists\PlayLists.xml")
        Set t = xmlPlaylist.firstChild
        
        t.removeChild t.childNodes(index)
        xmlPlaylist.Save pathName & "\PlayLists\PlayLists.xml"
        
        fso.DeleteFile pathName & "\PlayLists\" & Name & ".xml", True
        
   Exit Sub
Error:
   WriteEvent "DeletePlayList", Err.Description, Err.Source
End Sub


Public Sub CreateNewFile(path As String, nameFile As String, NodeName As String)
   On Error GoTo Error
        Set xmlPlaylist = New DOMDocument
        Set xmlPlaylistRoot = xmlPlaylist.createElement(NodeName & "s")
        Set xmlPlaylistName = xmlPlaylist.createElement(NodeName)
        xmlPlaylistRoot.setAttribute "DisplayMode", "TrackTitle"
        xmlPlaylist.appendChild xmlPlaylistRoot
        xmlPlaylist.Save path & "\" & Trim(nameFile) & ".xml"
   Exit Sub
Error:
   WriteEvent "CreateNewFile", Err.Description, Err.Source
End Sub
Public Sub CreateNewFilePlaylist(path As String)
   On Error GoTo Error
            
            If Not fso.FolderExists(path & "\PlayLists") Then
              fso.CreateFolder (path & "\PlayLists")
           
              Set xmlPlaylist = New DOMDocument
              Set xmlPlaylistRoot = xmlPlaylist.createElement("PlayLists")
              Set xmlPlaylistName = xmlPlaylist.createElement("PlayList")
              
              xmlPlaylistName.Text = "Default"
              xmlPlaylistRoot.appendChild xmlPlaylistName
              
              xmlPlaylist.appendChild xmlPlaylistRoot
              xmlPlaylist.Save path & "\PlayLists\PlayLists.xml"
              CreateNewFile path, "Default", "Track"
            End If
   Exit Sub
Error:
   WriteEvent "CreateNewFilePlaylist", Err.Description, Err.Source
End Sub
Public Function ExistPlayList(path As String, Y As String, Optional SlidePath As String) As Boolean
   On Error GoTo Err
   Dim f As Boolean
   Dim xmlnode As IXMLDOMElement
   Dim i As Long
   f = False
   xmlPlaylist.Load path
   Set xmlPlaylistRoot = xmlPlaylist.firstChild
   For i = 0 To xmlPlaylistRoot.childNodes.Length - 1
       Set xmlnode = xmlPlaylistRoot.childNodes(i)
       If LCase(Y) = LCase(xmlnode.Text) Then
           xmlnode.setAttribute "SlidePath", SlidePath
           f = True
           xmlPlaylist.Save path
           Exit For
       End If
   Next
Err:
   ExistPlayList = f
End Function
Public Sub AddBookMark2Default(BookMarkPath As String, PlayListName As String, SlidePath As String, StoreName As String, OverWrite As Boolean, BookMarkName As String, ByVal BookmarkTitle As Integer, ByVal BookmarkTime As Long, ByVal BookmarkLength As String, ByVal BookmarkType As Integer, ByVal BookmarkChapter As Integer)
   On Error GoTo Error

   Dim loc_PlayListPath As String
   Dim loc_DefaultPath As String                   'Add bookmark to default playlist name
   Dim loc_Path As String
   
   If int_track_count > 0 And int_current_index < int_track_count Then
      Set xmlTrack = New DOMDocument
      'BookMarkType         As Integer                '>0  it is bookmark,1 Play Till End,2 PlayTill Next Track,3 Play For amount of seconds
      
      If Not fso.FolderExists(BookMarkPath) Then fso.CreateFolder (BookMarkPath)
      AddNewPath App.path & "\Sly", BookMarkPath
      If ExistPlayList(BookMarkPath & "\PlayLists\PlayLists.xml", PlayListName, SlidePath) = False Then
         AddNewPlayList BookMarkPath, PlayListName, SlidePath, BookMarkPath & "\Folder.jpg", True
      Else
         If OverWrite = True Then CreateNewFile BookMarkPath & "\PlayLists\", PlayListName, "Track"
      End If
      Set xmlTrack = New DOMDocument
      loc_DefaultPath = BookMarkPath & "\PlayLists\" & PlayListName & ".xml"
      xmlTrack.Load loc_DefaultPath
      Set xmlTrackRoot = xmlTrack.firstChild
      xmlTrackRoot.setAttribute "DisplayMode", "TrackTitle"                      'Default
      xmlTrackRoot.setAttribute "StoreName", StoreName
      
      If BookmarkType = 3 Then           'Play For amount of seconds
         BookmarkLength = BookmarkTime + val(BookmarkLength)
         'If val(BookmarkLength) > getMovieDuration Then BookmarkLength = getMovieDuration
         If val(BookmarkLength) > CPlayer.Duration Then BookmarkLength = CPlayer.Duration
      End If

      Set xmlTrackName = savePlayInfo2Xml(int_current_index, "Track")
      xmlTrackName.setAttribute "Track", BookMarkName                            'Change the track name to bookmark title
      xmlTrackName.setAttribute "BookmarkTitle", BookmarkTitle                   'title of the bookmark
      xmlTrackName.setAttribute "BookmarkChapter", BookmarkChapter               'Chapter of the bookmark in the title
      xmlTrackName.setAttribute "BookmarkTime", BookmarkTime                     'goto time
      xmlTrackName.setAttribute "BookmarkLength", val(BookmarkLength)     'in seconds
      xmlTrackName.setAttribute "IsBookmark", BookmarkType
      
      xmlTrackRoot.appendChild xmlTrackName
      xmlTrack.Save loc_DefaultPath
   End If
   Exit Sub
Error:
   'Writelog
   Writelog "AddBookMark2Default", "ERROR", Err.Description, "BookMarkPath = " & BookMarkPath & ", PlayListName= " & PlayListName & ", SlidePath = " & SlidePath & ", StoreName " & StoreName & ", BookmarkTitle = " & BookmarkTitle
   'WriteEvent "AddBookMark2Default", Err.Description, Err.Source
End Sub
Public Sub SaveTracks(path As String, Name As String, Slide As String, OverWrite As String, Mode As String)
   On Error GoTo Error
   Dim i As Integer
   If Not fso.FolderExists(path) Then
         fso.CreateFolder (path)
   End If
   ' AddNewPath App.path & "\Sly", path
   AddNewPath path, path
   If ExistPlayList(path & "\PlayLists\PlayLists.xml", Name, Slide) = False Then
      AddNewPlayList path, Name, Slide, path & "\Folder.jpg", True
   Else
      'EditRegistrySlide ImageDir, Slide
      If OverWrite = "true" Then CreateNewFile path & "\PlayLists\", Name, "Track"
   End If
   Set xmlTrack = New DOMDocument
   xmlTrack.Load path & "\PlayLists\" & Name & ".xml"
   Set xmlTrackRoot = xmlTrack.firstChild
   xmlTrackRoot.setAttribute "DisplayMode", Mode
   For i = 0 To UBound(PlayTrackInfo)
      Set xmlTrackName = savePlayInfo2Xml(i, "Track")
      xmlTrackRoot.appendChild xmlTrackName
   Next
   xmlTrack.Save path & "\PlayLists\" & Name & ".xml"
   Exit Sub
Error:
   Writelog "SaveTracks", "ERROR", Err.Description, "Path = " & path & ", Name= " & Name & ", Slide = " & Slide & ", Overwrite " & OverWrite & ", Mode = " & Mode
   'WriteEvent "SaveTracks", Err.Description, Err.Source
End Sub
Public Sub EditSetting(path As String, index As Long, Name As String, Value As String)
  On Error GoTo Error
  Dim t As IXMLDOMElement
  Dim doc As DOMDocument
  If (Name = "SetSlideShow") Then
    SlideShowValue = Value
    If IndexSwf <> 0 Then
        sendVariable2Flash FrmMain.Swf(0), "SlideShowValue", SlideShowValue
        sendVariable2Flash FrmMain.Swf(IndexSwf), "SlideShowValue", SlideShowValue
    Else
        sendVariable2Flash FrmMain.Swf(0), "SlideShowValue", SlideShowValue
    End If
  End If
  Set doc = New DOMDocument
   doc.Load path
   Set t = doc.childNodes(0).childNodes(index)
   t.setAttribute Name, Value
   doc.Save path
      
   Exit Sub
Error:
   WriteEvent "EditSetting", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   LoadSettingXML
' Description       :   Load settings from setting.xml
' Return Values     :   NONE
' Input Parameter   :   NONE
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             03-08-2006           New
'*******************************************************************************
Public Sub LoadLanguageXml()
   Dim XmlDoc As New DOMDocument
   Dim xmlSettings As IXMLDOMElement
   Dim xmlFont As IXMLDOMElement
   Dim xmlSlideShow As IXMLDOMElement
   Dim xmlPlayer As IXMLDOMElement
   XmlDoc.Load MainPath & "\Language.xml"
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlFont = XmlDoc.firstChild.childNodes(0)
      With xmlFont
         Settings.i_SearchTrackFromArtist = Null2Value(.getAttribute("SearchTrackFromArtist"))
      End With
   End If
End Sub
Public Sub LoadBannerXML()
   Dim XmlDoc As New DOMDocument
   Dim xmlBanners As IXMLDOMElement
   Dim xmlBanner As IXMLDOMElement
   Dim BannerCount As Integer
   Dim i As Integer
   
   XmlDoc.Load App.path & "\Sly\Banner.xml"
   ReDim Banners(-1 To -1)
   BannerIndex = 0
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlBanners = XmlDoc.firstChild
      BannerShuffle = (xmlBanners.getAttribute("ShowType") = "Shuffle")
      BannerCount = xmlBanners.childNodes.Length
      BannerHeight = xmlBanners.getAttribute("Height")
      
      ReDim Banners(-1 To BannerCount - 1)
      ReDim BannerList(-1 To BannerCount - 1)
      For i = 0 To BannerCount - 1
         Set xmlBanner = xmlBanners.childNodes.item(i)
         Banners(i).filename = xmlBanner.Text
         Banners(i).Length = val(xmlBanner.getAttribute("Length"))
         Banners(i).start = val(xmlBanner.getAttribute("Start"))
'''         Banners(i).Played = False
         BannerList(i) = (i)
      Next
      ReOrderBanner BannerShuffle
   End If
End Sub
Public Sub ReOrderBanner(bShuffle As Boolean)
      '====Shuffle the list
      Dim iIndex As Integer
      Dim iPreviousIndex As Integer
      Dim BannerCount As Integer
      Dim i As Integer
      
      BannerCount = UBound(Banners) + 1
      Randomize Timer
      For i = 1 To BannerCount
         If BannerShuffle Then
            iIndex = Rnd * (BannerCount + 1)
            If iIndex <= (BannerCount - 1) Then
               iPreviousIndex = BannerList(0)
               BannerList(0) = BannerList(iIndex)
               BannerList(iIndex) = iPreviousIndex
            End If
         Else
            BannerList(i - 1) = i - 1
         End If
      Next
      '==================
End Sub

Public Sub SaveSettingXML()
   Dim XmlDoc As New DOMDocument
   Dim xmlSettings As IXMLDOMElement
   Dim xmlTheme As IXMLDOMElement
   Dim xmlSlideShow As IXMLDOMElement
   Dim xmlPlayer As IXMLDOMElement
   Dim loc_StrVariable As String
   
   XmlDoc.Load MainSettingXML
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlSettings = XmlDoc.firstChild
      Set xmlTheme = xmlSettings.childNodes(0)
      Set xmlSlideShow = xmlSettings.childNodes(1)
      Set xmlPlayer = xmlSettings.childNodes(2)
      With xmlTheme
         .setAttribute "ShowFormVideo", LCase(Settings.run_FormVideoLoaded)
         .setAttribute "MusicNote", LCase(Settings.MusicNoteValue)
         .setAttribute "FormMode", WinMode
         
'''         Settings.NoInternetConnected = .getAttribute("NoInternet")
'''         Settings.AutoDownload = .getAttribute("AutoDownload")
'''         Settings.auto_new_database = .getAttribute("auto_new_database")
'''         Settings.DisplayAlbumLong = .getAttribute("DisplayAlbumList")
'''         Settings.DisplayAlbumLongSearch = .getAttribute("DisplayAlbumListSearch")
'''         Settings.DisplayAlbumLongPlaylist = .getAttribute("DisplayAlbumListPlaylist")
'''         Settings.LoadPlayMusic = .getAttribute("LoadPlayMusic")
'''         Settings.ShowPlayerOnLoad = .getAttribute("ShowPlayerOnLoad")
'''         Settings.b_AutoConnect = Null2Str(.getAttribute("AutoConnect")) = "true"
'''         Settings.i_AutoConnected = Null2Value(.getAttribute("AutoClientConnection"))
'''         Settings.b_GetZoomLevelFromServer = Null2Str(.getAttribute("ResizeFromServer")) = "true"
'''         Settings.b_ShowFormVideo = Null2Str(.getAttribute("ShowFormVideo")) = "true"
      End With
'''      With xmlSlideShow
'''         Settings.SlideShowRandom = .getAttribute("Random")
'''
'''      End With
      With xmlPlayer
         .setAttribute "AutoPlay", LCase(AutoPlayEnabled)
         .setAttribute "AutoPlayPowerDVD", LCase(AutoPlayPowerDVD)
         .setAttribute "AutoPlayMPC", LCase(AutoPlayMPC)
         '.setAttribute "LastLanguage", CBrowse.prv_Country
         .setAttribute "LastLanguage", CBrowse.GetLastLanguage
         .setAttribute "VLCExtension", Settings.s_DefaultVLCExtension
         .setAttribute "PowerDVDExtension", Settings.s_DefaultPowerDVDExtension
         .setAttribute "BrowseByFolder", LCase(Settings.b_BrowseByFolder)
         .setAttribute "ExternalPowerDVD", LCase(Settings.b_ExternalPowerDVD)
         .setAttribute "DaemonDrive", s_DriveMount

         If playMusicWith = WindowMedia Then
            loc_StrVariable = "WindowMedia"
         ElseIf playMusicWith = MediaPlayer Then
            loc_StrVariable = "MediaPlayer"
         ElseIf playMusicWith = PowerDVD Then
            loc_StrVariable = "PowerDVD"
         Else
            loc_StrVariable = "WindowMedia"
         
            
         End If
         .setAttribute "playWith", loc_StrVariable
         .setAttribute "MPlayerPath", MPlayerPath
         
      End With
      XmlDoc.Save MainSettingXML
   End If
End Sub

Public Sub LoadSettingXML()
   Dim XmlDoc As New DOMDocument
   Dim xmlSettings As IXMLDOMElement
   Dim xmlTheme As IXMLDOMElement
   Dim xmlSlideShow As IXMLDOMElement
   Dim xmlPlayer As IXMLDOMElement
   Dim loc_StrVariable As String
   
   XmlDoc.Load MainSettingXML
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlSettings = XmlDoc.firstChild
      Set xmlTheme = xmlSettings.childNodes(0)
      Set xmlSlideShow = xmlSettings.childNodes(1)
      Set xmlPlayer = xmlSettings.childNodes(2)
      With xmlTheme
         Settings.i_SlyMonitor = Null2Value(.getAttribute("SlyMonitor"))
         Settings.i_VideoMonitor = Null2Value(.getAttribute("VideoMonitor"))
         Settings.WinMode = .getAttribute("FormMode")
         Settings.NoInternetConnected = .getAttribute("NoInternet")
         Settings.AutoDownload = .getAttribute("AutoDownload")
         Settings.auto_new_database = .getAttribute("auto_new_database")
         Settings.DisplayAlbumLong = .getAttribute("DisplayAlbumList")
         Settings.DisplayAlbumLongSearch = .getAttribute("DisplayAlbumListSearch")
         Settings.DisplayAlbumLongPlaylist = .getAttribute("DisplayAlbumListPlaylist")
         Settings.LoadPlayMusic = .getAttribute("LoadPlayMusic")
         Settings.ShowPlayerOnLoad = .getAttribute("ShowPlayerOnLoad")
         Settings.b_AutoConnect = Null2Str(.getAttribute("AutoConnect")) = "true"
         Settings.i_AutoConnected = Null2Value(.getAttribute("AutoClientConnection"))
         Settings.b_GetZoomLevelFromServer = Null2Str(.getAttribute("ResizeFromServer")) = "true"
         Settings.b_ShowFormVideo = Null2Str(.getAttribute("ShowFormVideo")) = "true"
         Settings.MusicNoteValue = Null2Str(.getAttribute("MusicNote"))
         
      End With
      With xmlSlideShow
         Settings.SlideShowRandom = .getAttribute("Random")

      End With
      With xmlPlayer
            AutoPlayEnabled = .getAttribute("AutoPlay") = "true"
            'AutoPlayPowerDVD = Null2Str(.getAttribute("AutoPlayPowerDVD")) = "true"
            AutoPlayPowerDVD = True       'Always true
            
            AutoPlayMPC = Null2Str(.getAttribute("AutoPlayMPC")) = "true"
            LastLanguage = Null2Str(.getAttribute("LastLanguage"))
            s_DefaultVLCExtension = Null2Str(.getAttribute("VLCExtension"))
            s_DefaultPowerDVDExtension = Null2Str(.getAttribute("PowerDVDExtension"))
            loc_StrVariable = Null2Str(.getAttribute("playWith"))
            b_BrowseByFolder = Null2Str(.getAttribute("BrowseByFolder")) = "true"
            b_ExternalPowerDVD = Null2Str(.getAttribute("ExternalPowerDVD")) = "true"
            s_DriveMount = Null2Str(.getAttribute("DaemonDrive"))
            If s_DriveMount = "" Then s_DriveMount = "D"
            MPlayerPath = Null2Str(.getAttribute("MPlayerPath"))
            
            If loc_StrVariable = "WindowMedia" Then
               playMusicWith = WindowMedia
            ElseIf loc_StrVariable = "MediaPlayer" Then
               playMusicWith = MediaPlayer
            ElseIf loc_StrVariable = "PowerDVD" Then
               playMusicWith = PowerDVD
            Else
               playMusicWith = WindowMedia
            End If
      End With
   End If
End Sub

Public Function Null2Str(Value As Variant) As String
   Null2Str = IIf(IsNull(Value), "", Value)
End Function
Public Function Null2Value(Value As Variant) As Double
   Null2Value = val(IIf(IsNull(Value), 0, Value))
End Function
Public Sub removeItem(index As Integer)
On Error GoTo Ended
  Dim TempArr() As Tracks
  Dim TempInfos()  As TrackInfos
  Dim J As Integer
  
  If int_track_count = 1 Then
      int_track_count = 0
  Else
      ReDim Preserve TempArr(UBound(PlayTrackInfo) - 1)
      ReDim Preserve TempInfos(UBound(PlayTrackInfo) - 1)
  
      Dim i As Long
      For i = 0 To UBound(PlayTrackInfo)
         If (i <> index) Then
            TempArr(J) = PlayTrackInfo(i)
            TempInfos(J) = Infos(i)
            J = J + 1
         End If
      Next
         PlayTrackInfo = TempArr
         Infos = TempInfos
         IndexPlayTrack = IndexPlayTrack - 1
      End If
  Exit Sub
  
Ended:
  IndexPlayTrack = 0
End Sub
Public Function GetLanguageLocation(xmlName As String) As String
   GetLanguageLocation = MainPath & "\" & xmlName
End Function
Public Sub EditRegistrySlide(Name As RegName, Value As String)
   On Error GoTo Error
   Dim B As Byte
   Select Case Value
      Case "Yes"
         B = 1
      Case "No"
         B = 0
   End Select
      
   Select Case Name
   Case 0
      If (Len(Value) > 0) Then
         SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "ImageDirectory", Value, REG_SZ
      End If
   Case 1
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "MaxScreenPercent", val(Value), REG_DWORD
   Case 2
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "ChangeInterval", val(Value) * 1000, REG_DWORD
   Case 3
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "AllowStretching", B, REG_DWORD
   Case 4
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "DisplayFilename", B, REG_DWORD
   Case 5
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "AllowKeyboardControl", B, REG_DWORD
   Case 6
      Select Case Value
      Case "Yes"
         B = 0
      Case "No"
         B = 1
      End Select
      SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "Control Panel\Screen Saver.Slideshow", "DisableTransitions", B, REG_DWORD
   End Select
   Exit Sub
Error:
   WriteEvent "EditRegistrySlide", Err.Description, Err.Source
End Sub

Public Property Get IndexSwf() As Integer
   IndexSwf = mod_IndexSwf
End Property
Public Property Let IndexSwf(varNewValue As Integer)
   mod_IndexSwf = varNewValue
End Property
'''==================================Global for class=================================================
Public Function GetEnableAlbumASIN(ByVal MovieID As Long, Optional MovieLanguage As String) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(MovieLanguage)
   GetEnableAlbumASIN = cLanguage.GetEnableAlbumASIN(MovieID)
   Exit Function
Error:
   WriteEvent "GetEnableAlbumASIN", Err.Description, Err.Source
End Function
Public Function GetCountryClass(ByVal languageName As String) As cLanguage
   On Error GoTo Error
   Dim clsLoadLanguage As cLanguage
   Dim countryDirectory As String
   If languageName = "" Then languageName = currentCountry
   If languageName = CBrowse.GetLastLanguage Then
      Set clsLoadLanguage = CBrowse
   Else
      Set clsLoadLanguage = New cLanguage
      countryDirectory = SlyVariable("<" & languageName & "_dat>")
      clsLoadLanguage.SetCountry languageName, countryDirectory
   End If
   Set GetCountryClass = clsLoadLanguage
   Exit Function
Error:
   WriteEvent "GetCountryClass", Err.Description, Err.Source
End Function
Public Function GetTrackField(ByVal TrackID As Long, FieldName As String, Optional trackLanguage As String) As Variant
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(trackLanguage)
   GetTrackField = cLanguage.GetTrackField(TrackID, FieldName)
   Exit Function
Error:
   WriteEvent "GetTrackField", Err.Description, Err.Source
End Function
Public Sub SetTrackField(ByVal TrackID As Long, FieldName As String, Value As Variant, Optional trackLanguage As String)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(trackLanguage)
   Call cLanguage.SetTrackField(TrackID, FieldName, Value)
   Exit Sub
Error:
   WriteEvent "SetTrackField", Err.Description, Err.Source
End Sub
Public Sub EditAlbumRating(MovieID As Long, Rating As Integer, Optional MovieLanguage As String)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(MovieLanguage)
   cLanguage.EditAlbumRating MovieID, Rating
   Exit Sub
Error:
   WriteEvent "EditAlbumRating", Err.Description, Err.Source
End Sub
Public Property Get GetStreamPath(ByVal albumID As Long, ByVal TrackID As Long, ByVal trackLanguage As String, iPlayFrom As Integer)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(trackLanguage)
   GetStreamPath = cLanguage.GetStreamPath(albumID, TrackID, iPlayFrom)
   Exit Property
Error:
   WriteEvent "Get GetStreamPath", Err.Description, Err.Source
End Property

Public Property Get GetTrackPath(ByVal TrackID As Long, ByVal albumID As Long, ByVal trackLanguage As String, Optional iPlayFrom As Integer)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(trackLanguage)
   GetTrackPath = cLanguage.GetTrackPath(TrackID, albumID, iPlayFrom)
   Exit Property
Error:
   WriteEvent "Get GetTrackPath", Err.Description, Err.Source
End Property
Public Property Let SetTrackPath(ByVal TrackID As Long, Optional ByVal trackLanguage As String, lpPath As String)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Dim loc_MovieID As Long
   Set cLanguage = GetCountryClass(trackLanguage)
   cLanguage.SetTrackPath(TrackID) = lpPath
   Exit Property
Error:
   WriteEvent "Let SetTrackPath", Err.Description, Err.Source
End Property
Public Function GetAlbumTrailerAva(ByVal albumID As Long, Optional ByVal AlbumLanguage As String) As Integer
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(AlbumLanguage)
   GetAlbumTrailerAva = IIf(cLanguage.GetAlbumField(albumID, "PathTrailer") = "", 0, 1)
   Exit Function
Error:
   WriteEvent "GetAlbumTrailerAva", Err.Description, Err.Source
End Function
Public Function GetTracksByAlbum(ByVal albumID As Long, Optional ByVal AlbumLanguage As String) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage, boolKaraoke As Boolean
   Dim iDatabaseType As Integer
   Set cLanguage = GetCountryClass(AlbumLanguage)
   iDatabaseType = val(SlyVariable("<" & AlbumLanguage & "_id>"))
   boolKaraoke = (iDatabaseType = 8 Or iDatabaseType = 4 Or iDatabaseType = 16) And i_ShowUnderTrackTitle = 0           'if it is karaoke/music then show singers
   GetTracksByAlbum = cLanguage.GetTracksByAlbum(albumID, boolKaraoke)
   Exit Function
Error:
   WriteEvent "GetTracksByAlbum", Err.Description, Err.Source
End Function

Public Function getMoviePathAndSample(args As String, Optional comName As String, Optional iPlayFrom As Integer) As String
   On Error GoTo Error
      Dim stSpl() As String
      Dim SampleValue As Integer
      Dim CompanyName As String
      Dim strwalmart  As String
      Dim stringLanguagePath As String
      Dim currentTrackPath As String
      
      Dim arguments() As String
      Dim trackLanguage As String
      Dim TrackID As Long
      Dim albumID As Long
      Dim TrackIndex As Long
      
      arguments = Split(args, "~")
      
      TrackID = val(arguments(0))
      albumID = val(arguments(1))
      TrackIndex = val(arguments(2))            '#
      trackLanguage = arguments(3)
      SampleValue = val(arguments(4))
      If UBound(arguments) > 4 Then iPlayFrom = val(arguments(5))                'Play track type

      If TrackID = 0 And albumID = 0 Then
         currentTrackPath = arguments(0)
         ' External track get the track id
''         If comName = SlyNickName Then
''            currentTrackPath = arguments(0)
''         Else
''            currentTrackPath = GetExternalTrackPath(comName, arguments(0))
''         End If
      Else
         
         NoTrack = TrackIndex + 1
         If trackLanguage = vbNullString Then trackLanguage = currentCountry
         
         stringLanguagePath = SlyVariable("<" & trackLanguage & "_dat>")
   
         currentTrackPath = GetTrackPath(TrackID, albumID, trackLanguage, iPlayFrom)
         If Not isFileExist(currentTrackPath) Then
            currentTrackPath = ""
         Else
            comName = SlyNickName
         End If
       
       If currentTrackPath = "" And val(SampleValue) > 0 And NoInternetConnected = 0 Then
           CompanyName = GetCompanyName(SampleValue)  'String
           strwalmart = CBrowse.GetAlbumWalmart(albumID, CompanyName, stringLanguagePath)
           If CompanyName = "Amazon" Then
              strwalmart = strwalmart & Delimiter & GetTrackPath(val(TrackID), val(albumID), trackLanguage, iPlayFrom)
           End If
           If strwalmart <> "" Then currentTrackPath = GetStrWalmart(strwalmart, CStr(TrackIndex), CompanyName)
       End If
    End If
    getMoviePathAndSample = currentTrackPath
   Exit Function
Error:
   WriteEvent "getMoviePathAndSample", Err.Description, Err.Source
End Function
Public Sub SetAlbumField(ByVal albumID As Long, FieldName As String, Value As Variant, Optional ByVal AlbumLanguage As String)
   On Error GoTo Error

   If albumID > 0 Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(AlbumLanguage)
      Call cLanguage.SetAlbumField(albumID, FieldName, Value)
   End If
   Exit Sub
Error:
   WriteEvent "SetAlbumField", Err.Description, Err.Source
End Sub

Public Function GetAlbumField(ByVal albumID As Long, Optional Address As String = "ASIN", Optional ByVal AlbumLanguage As String) As Variant
   On Error GoTo Error
   If albumID > 0 Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(AlbumLanguage)
      GetAlbumField = cLanguage.GetAlbumField(albumID, Address)
   End If
   Exit Function
Error:
   WriteEvent "GetAlbumField", Err.Description, Err.Source
End Function
Public Function GetChapterTime(ByVal albumID As String, AlbumLanguage As String, ChapterNumber As Integer) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(AlbumLanguage)
   GetChapterTime = cLanguage.GetChapterTime(albumID, ChapterNumber)
   Exit Function
Error:
   WriteEvent "GetChapterTime", Err.Description, Err.Source
End Function
Public Function SetLastUpdate(argLanguage As String, varDate As String)
   On Error GoTo errorOccur
   Dim tblMovie As New TableCls
   Dim databasePath As String
   
   databasePath = get_country_path(argLanguage) & "\database"
   If fso.FolderExists(databasePath) Then
      SetDirectory databasePath
      tblMovie.Opens "Movie"
      tblMovie.SetDate varDate
      tblMovie.Closes
   End If
errorOccur:
End Function

Public Function GetLastUpdate(argLanguage As String) As String
   On Error GoTo errorOccur
   Dim tblMovie As New TableCls
   Dim databasePath As String
   
   databasePath = get_country_path(argLanguage) & "\database"
   If fso.FolderExists(databasePath) Then
      SetDirectory databasePath
      tblMovie.Opens "Movie"
      GetLastUpdate = tblMovie.GetDate
      tblMovie.Closes
   Else
      GetLastUpdate = "09/01/2002"     'For no update
   End If
errorOccur:
End Function
Public Function GetChapterFromMovie(ByVal albumID As String, AlbumLanguage As String, chapterCount As Integer) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(AlbumLanguage)
   GetChapterFromMovie = cLanguage.GetChapterFromMovie(albumID, chapterCount)
   Exit Function
Error:
   WriteEvent "GetChapterFromMovie", Err.Description, Err.Source
End Function
Public Function GetTrackFields(ByVal TrackID As Long, trackLanguage As String, ParamArray ArrayField() As Variant) As Variant
   On Error GoTo Error
   If TrackID > 0 Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(trackLanguage)
      Dim loc_ArrayField() As Variant
      loc_ArrayField = ArrayField
      GetTrackFields = cLanguage.GetTrackFields(TrackID, loc_ArrayField)
   End If
   Exit Function
Error:
   WriteEvent "GetTrackFields", Err.Description, Err.Source
End Function

'GetDatabseFields

Public Function GetDatabseFields(lplanguage As String, lpQuery As String) As Variant
   On Error GoTo Error
   If lplanguage <> "" Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(lplanguage)
      GetDatabseFields = cLanguage.GetDatabseFields(lpQuery)
   End If
   Exit Function
Error:
   WriteEvent "GetAlbumFields", Err.Description, Err.Source
End Function

Public Function GetAlbumFields(ByVal albumID As Long, AlbumLanguage As String, ParamArray ArrayField() As Variant) As Variant
   On Error GoTo Error
   If albumID > 0 Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(AlbumLanguage)
      Dim loc_ArrayField() As Variant
      loc_ArrayField = ArrayField
      GetAlbumFields = cLanguage.GetAlbumFields(albumID, loc_ArrayField)
   End If
   Exit Function
Error:
   WriteEvent "GetAlbumFields", Err.Description, Err.Source
End Function
Public Function GetDirectorName(ByVal IDs As String, ByVal DirectorLanguage As String, Optional max As Integer = 2) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(DirectorLanguage)
   GetDirectorName = cLanguage.GetDirectorName(IDs, max)
   Exit Function
Error:
   WriteEvent "GetDirectorName", Err.Description, Err.Source
End Function

Public Function GetActorName(ByVal IDs As String, ByVal ActorLanguage As String, Unicode As Boolean) As String
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(ActorLanguage)
   GetActorName = cLanguage.GetActorName(IDs, Unicode)
   Exit Function
Error:
   WriteEvent "GetActorName", Err.Description, Err.Source
End Function
Public Function GetAlbumActor(ByVal MovieID As Long, ByVal AlbumLanguage As String) As String
   On Error GoTo Error
   Dim ActorIDs As String
   Dim ActorName As String
   
   If MovieID > 0 Then
      Dim cLanguage As cLanguage
      Set cLanguage = GetCountryClass(AlbumLanguage)
      ActorIDs = cLanguage.GetAlbumField(MovieID, "ActorID")
      ActorName = cLanguage.GetDirectorName(ActorIDs, 2)
   End If
   GetAlbumActor = ActorName
   Exit Function
Error:
   WriteEvent "GetAlbumActor", Err.Description, Err.Source
End Function
Public Sub CreateMyAlbumXml(MachineName As String)
   On Error GoTo ErrorSubScript:
   Dim tblAlbum As New TableCls
   Dim tblTitle As New TableCls
   Dim tblTrack As New TableCls
   Dim xmlRoot As IXMLDOMElement
   Dim xmlRootSub As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim XmlDoc As New DOMDocument
   Dim rootLanguage As IXMLDOMElement
   Dim xmlRootMachine As IXMLDOMElement
   Dim loc_ServerName As String
   Dim Str_TrackIDs As String                               'track ids of album that only available from track
   Dim loc_AlbumTracks As String
   Dim loc_ListTracks() As String
   Dim loc_TrackID As Long
   
   
   Dim IndexAlbumSmallPath As String
   Dim IndexAlbumMediumPath As String
   Dim IndexAlbumLargePath As String
   
   
   
   
   
   
   Dim albumID As Long
   Dim i As Long, J As Long, k As Integer
   
   XmlDoc.Load SlyVariable("<MyAlbumServer>")
   Set rootLanguage = XmlDoc.firstChild
   If CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(independentMode) Or _
      CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist) Then
      loc_ServerName = CWinsock.serverID                                    'sever nick name
   Else
      loc_ServerName = SlyNickName
   End If

   If rootLanguage Is Nothing Then
      Set rootLanguage = XmlDoc.createElement("Machines")
      
      Set xmlRootMachine = XmlDoc.createElement("Machine")
      xmlRootMachine.setAttribute "Name", MachineName
      
      XmlDoc.appendChild rootLanguage
      rootLanguage.appendChild xmlRootMachine
   Else
      Set xmlRootMachine = XmlDoc.selectSingleNode("//Machines/Machine[@Name='" & MachineName & "']")
      If Not xmlRootMachine Is Nothing Then
         rootLanguage.removeChild xmlRootMachine
      End If
      Set xmlRootMachine = XmlDoc.createElement("Machine")
      xmlRootMachine.setAttribute "Name", MachineName
      rootLanguage.appendChild xmlRootMachine
      
   End If
   xmlRootMachine.setAttribute "Server", loc_ServerName
   For J = 0 To UBound(CountriesList)
      SetDirectory CountriesList(J).path + "\Database"
      tblAlbum.Opens "Movie"
      tblTitle.Opens "Title"                                'New
      tblTrack.Opens "Track"
      
         IndexAlbumSmallPath = tblAlbum.FieldToIndex("PathSmall")
         IndexAlbumMediumPath = tblAlbum.FieldToIndex("PathMedium")
         IndexAlbumLargePath = tblAlbum.FieldToIndex("Path")
         '=========================================================
         For i = 0 To tblAlbum.RecordCount - 1
            If tblAlbum.AbsoluteField(i, "Available") = 1 Then
               albumID = tblAlbum.AbsoluteField(i, "ID")
               Set xmlRoot = XmlDoc.createElement("Language")
               xmlRoot.setAttribute "Name", CountriesList(J).Name
               xmlRoot.setAttribute "ID", albumID
               '==new 2006-10-13 Seng============================================================================================
               If tblAlbum.AbsoluteField(i, IndexAlbumSmallPath) = "" And tblAlbum.AbsoluteField(i, IndexAlbumMediumPath) = "" And tblAlbum.AbsoluteField(i, IndexAlbumLargePath) = "" Then
                  If tblTitle.Seeks(albumID) >= 0 Then
                     Str_TrackIDs = ""
                     loc_AlbumTracks = tblTitle.Field("TrackIDs")
                     If loc_AlbumTracks <> "" Then
                        'loc_ListTracks = Split(loc_AlbumTracks, ";")
                        'For k = 0 To UBound(loc_ListTracks)
                        For k = 1 To Len(loc_AlbumTracks) Step 3
                           'loc_TrackID = val(loc_ListTracks(k))
                           loc_TrackID = Triple2Long(mID(loc_AlbumTracks, k, 3))
                           If loc_TrackID > 0 Then
                              If tblTrack.Seeks(loc_TrackID) >= 0 Then
                                 If tblTrack.Field("Available") = 1 Then
                                    If Str_TrackIDs = "" Then
                                       Str_TrackIDs = loc_TrackID
                                    Else
                                       Str_TrackIDs = Str_TrackIDs & ";" & loc_TrackID
                                    End If
                                 End If
                              End If
                           End If
                        Next
                        xmlRoot.setAttribute "TrackIDs", ";" & Str_TrackIDs & ";"
                     End If
                  End If
               End If
               '==================================================================================================================
               xmlRootMachine.appendChild xmlRoot
               'Str_TrackIDs
            End If
         Next
      tblTrack.Closes
      tblTitle.Closes
      tblAlbum.Closes
   Next
   XmlDoc.Save SlyVariable("<MyAlbumServer>")
   Exit Sub
ErrorSubScript:
   WriteEvent "CreateMyAlbumXml", Err.Description, Err.Source
End Sub

Public Function AlbumByArtistName(artistName As String, ArtistLanguage As String, selectType As AlbumEnum, ArrangeBy As SortEnum) As Long
   On Error GoTo Error
   'artistName=LabelName that is LabelID id
   'BrowseQuery
   Dim browsingDirectory As String
   Dim DatabaseID As Long
   Dim LabelID As Long
   
   Dim cLanguage As cLanguage
   
   Set cLanguage = GetCountryClass(ArtistLanguage)
   Set BrowseQuery = cLanguage
   DatabaseID = get_country_type(ArtistLanguage)
   
   If DatabaseID = 1 Or DatabaseID = 2 Then
      LabelID = BrowseQuery.SearchLabelIDInPlayList(artistName)
      AlbumByArtistName = BrowseQuery.AlbumByLabel(LabelID, , selectType, ArrangeBy)
   Else
      LabelID = BrowseQuery.SearchArtistIDInPlayList(artistName)
      AlbumByArtistName = BrowseQuery.AlbumByArtist(LabelID, selectType, ArrangeBy)
   End If
   'With BrowseQuery
      'browsingDirectory = SlyVariable("<" & ArtistLanguage & "_dat>")
'      .SetCountry ArtistLanguage, browsingDirectory
'''      LabelID = .SearchLabelIDInPlayList(artistName)
'''      AlbumByArtistName = .AlbumByLabel(LabelID, , selectType, ArrangeBy)
   'End With
   Exit Function
Error:
   WriteEvent "AlbumByArtistName", Err.Description, Err.Source
End Function

Public Function AddTrackByKey(key As String) As Boolean

   '  LanguageID=11        '3 char
   '     TrackID=11        '6
   '
   Dim LanguageID As Long
   Dim languageName As String
   Dim SongID As Long
   Dim strID As Long
   Dim loc_TrackIDNotFound As Boolean
   Dim i As Integer
   Dim cLanguage As cLanguage
   Dim loc_FoundLanguage As String
   
   If Len(key) <= 6 Then
      'default to current country
      For i = 0 To UBound(CountriesList)
         If StrComp(CountriesList(i).Name, currentCountry, vbTextCompare) = 0 Then
            LanguageID = val(CountriesList(i).key)
            SongID = val(key)
            Exit For
         End If
      Next
   Else
      LanguageID = val(left(key, Len(key) - 6))
      SongID = val(right(key, 6))
   End If
   
   For i = 0 To UBound(CountriesList)
      strID = val(CountriesList(i).key)
      If strID = LanguageID Then
         languageName = CountriesList(i).Name
         If languageName <> "" Then
            Set cLanguage = GetCountryClass(languageName)
            loc_TrackIDNotFound = False
            If cLanguage.addTrackToPlayer(SongID, SlyNickName, run_iGlobalAudioChannel, 4, loc_TrackIDNotFound) Then
               Exit For
            Else
               If loc_TrackIDNotFound = False Then
                  Exit For
               End If
            End If
         End If
      End If
   Next
  
End Function

Sub TextBoxScale(txt As Object, ValWidth As Long, ValHeight As Long, W As Integer, h As Integer, top As Integer, left As Integer)
   On Error GoTo Error
    Dim newHeight As Single
   Dim posx As Long, posy As Long, poswidth As Long, posHeight As Long
   'WSH=WSM=WS
    If ScreenType = "Normal" Then
      'Verified NS
      posx = 5 / 800 * ValWidth
      poswidth = 690 / 800 * ValWidth
      posy = 53 / 600 * ValHeight
      posHeight = 85 / 600 * ValHeight
    ElseIf ScreenType = "wideScreen" Then
      'verified WS
      posx = 9 / 1280 * ValWidth
      poswidth = 1118 / 1280 * ValWidth
      posy = 70 / 720 * ValHeight
      posHeight = 161 / 720 * ValHeight
    ElseIf ScreenType = "mediumWideScreen" Then
      'WSM testing
      posx = 9 / 1280 * ValWidth
      poswidth = 1118 / 1280 * ValWidth
      posy = 70 / 768 * ValHeight
      posHeight = 161 / 768 * ValHeight
    ElseIf ScreenType = "mediumLargeWideScreen" Then
      'Verified   WSH
      posx = 9 / 1280 * ValWidth
      poswidth = 1118 / 1280 * ValWidth
      posy = 70 / 800 * ValHeight
      posHeight = 161 / 800 * ValHeight
    ElseIf ScreenType = "smallWideScreen" Then
      'testing WSS
      posx = 7 / 1024 * ValWidth
      poswidth = 916 / 1024 * ValWidth
      posy = 57 / 600 * ValHeight
      posHeight = 120 / 600 * ValHeight
    ElseIf ScreenType = "largeWideScreen" Then
      'testing 'WSL
      posx = 5 / 800 * ValWidth
      poswidth = 690 / 800 * ValWidth
      posy = 57.5 / 600 * ValHeight
      posHeight = 75 / 600 * ValHeight
    Else
      posx = 5 / 800 * ValWidth
      poswidth = 690 / 800 * ValWidth
      posy = 53 / 600 * ValHeight
      posHeight = 85 / 600 * ValHeight
    End If
   txt.Move posx, posy, poswidth, posHeight
   FrmMain.txtSearchUnicode.FontSize = 50 / 1770 * posHeight
    Exit Sub
Error:
   WriteEvent "TextBoxScale", Err.Description, Err.Source
End Sub

Public Sub TransferValue(temp As Boolean)
On Error Resume Next
  ' Dim TempArr() As Tracks
   Dim TempStore() As Tracks
  IndexPlayTrack = 0
  
  'sith 18/11/06
  If temp = True Then
''      ReDim TempStore(UBound(PlayTrackInfo)) '(UBound(TempArr))
''      TempStore = TempArr
''
      ReDim TempArr(UBound(PlayTrackInfo))
      TempArr = PlayTrackInfo
      miniCommand "Pause" & "|:|" & True
      'ReDim PlayTrackInfo(UBound(TempStore))
 '     ReDim PlayTrackInfo(-1 To -1)
       PlayTrackInfo = TempStore
      'Erase PlayTrackInfo()
     IndexPlayTrack = UBound(TempStore) + 1
      
      
  Else
      ReDim TempStore(UBound(PlayTrackInfo))
      TempStore = PlayTrackInfo
      
      ReDim PlayTrackInfo(UBound(TempArr))
      PlayTrackInfo = TempArr
      IndexPlayTrack = UBound(TempArr) + 1
      
      miniCommand "Play" & "|:|" & True
      
      ReDim TempArr(UBound(TempStore))
      TempArr = TempStore
      'Erase TempArr()
  End If
Ended:
  
End Sub

Public Sub TextBoxSearchPlayer(txt As Object, frm_Width As Long, frm_Height As Long)
   On Error GoTo Error
'    Dim newHeight As Single
'    ' DIV BY Screen.TwipsPerPixelY FOR GETTING A CURRENT SCREEN
'    If ScreenType = "Normal" Then
'        Txt.left = ((85.2 * frm_Width / Screen.TwipsPerPixelX) / 800) * Screen.TwipsPerPixelX
'        Txt.top = ((117.3 * frm_Height / Screen.TwipsPerPixelY) / 600) * Screen.TwipsPerPixelY
'        Txt.Width = ((536.8 * frm_Width / Screen.TwipsPerPixelX) / 800) * Screen.TwipsPerPixelX
'        Txt.Height = ((51.9 * frm_Height / Screen.TwipsPerPixelY) / 600) * Screen.TwipsPerPixelY
'    ElseIf ScreenType = "wideScreen" Then 'ws
'        Txt.left = ((244.3 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.top = ((120.7 * frm_Height / Screen.TwipsPerPixelY) / 720) * Screen.TwipsPerPixelY
'        Txt.Width = ((678.6 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.Height = ((65.6 * frm_Height / Screen.TwipsPerPixelY) / 720) * Screen.TwipsPerPixelY
'    ElseIf ScreenType = "mediumWideScreen" Then 'wsm
'        Txt.left = ((244.3 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.top = ((120.7 * frm_Height / Screen.TwipsPerPixelY) / 768) * Screen.TwipsPerPixelY
'        Txt.Width = ((678.6 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.Height = ((65.6 * frm_Height / Screen.TwipsPerPixelY) / 768) * Screen.TwipsPerPixelY
'    ElseIf ScreenType = "mediumLargeWideScreen" Then 'wsh
'        Txt.left = ((244.3 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.top = ((122.7 * frm_Height / Screen.TwipsPerPixelY) / 800) * Screen.TwipsPerPixelY
'        Txt.Width = ((678.6 * frm_Width / Screen.TwipsPerPixelX) / 1280) * Screen.TwipsPerPixelX
'        Txt.Height = ((65.6 * frm_Height / Screen.TwipsPerPixelY) / 800) * Screen.TwipsPerPixelY
'    ElseIf ScreenType = "smallWideScreen" Then 'wss
'        Txt.left = ((199.1 * frm_Width / Screen.TwipsPerPixelX) / 1024) * Screen.TwipsPerPixelX
'        Txt.top = ((95.4 * frm_Height / Screen.TwipsPerPixelY) / 600) * Screen.TwipsPerPixelY
'        Txt.Width = ((536.8 * frm_Width / Screen.TwipsPerPixelX) / 1024) * Screen.TwipsPerPixelX
'        Txt.Height = ((51.9 * frm_Height / Screen.TwipsPerPixelY) / 600) * Screen.TwipsPerPixelY
'    ElseIf ScreenType = "largeWideScreen" Then 'wsl
'        Txt.left = ((87.1 * frm_Width / Screen.TwipsPerPixelX) / 800) * Screen.TwipsPerPixelX
'        Txt.top = ((99.4 * frm_Height / Screen.TwipsPerPixelY) / 640) * Screen.TwipsPerPixelY
'        Txt.Width = ((536.8 * frm_Width / Screen.TwipsPerPixelX) / 800) * Screen.TwipsPerPixelX
'        Txt.Height = ((51.9 * frm_Height / Screen.TwipsPerPixelY) / 640) * Screen.TwipsPerPixelY
'    End If
'    newHeight = FrmMain.ScaleY(FrmMain.txtSearchPlayer.Height, FrmMain.ScaleMode, vbPoints) - 10
'    If newHeight > 0 Then FrmMain.txtSearchPlayer.Font.SIZE = newHeight
'    Exit Sub
Error:
   WriteEvent "TextBoxSearchPlayer", Err.Description, Err.Source
End Sub
Public Sub TextScaleSize(TxtObj As Object, Swf As ShockwaveFlashObjectsCtl.ShockwaveFlash, TxtSize As String)
    Dim arr() As String
        
        arr = Split(TxtSize, ":")
        TxtObj.left = ((CInt(arr(0)) * Screen.TwipsPerPixelX) * Swf.Width) / (CDbl(arr(4) * Screen.TwipsPerPixelX))
        TxtObj.top = ((CInt(arr(1)) * Screen.TwipsPerPixelY) * Swf.Height) / (CDbl(arr(5) * Screen.TwipsPerPixelY))
        
        TxtObj.Width = ((CInt(arr(2)) * Screen.TwipsPerPixelX) * Swf.Width) / (CDbl(arr(4) * Screen.TwipsPerPixelX))
        TxtObj.Height = ((CInt(arr(3)) * Screen.TwipsPerPixelY) * Swf.Height) / (CDbl(arr(5) * Screen.TwipsPerPixelY))
        TxtObj.Visible = True
        TxtObj.Text = ""
        TxtObj.SetFocus
        FrmMain.txtSearchUnicode.FontSize = 50 / 1700 * TxtObj.Height
End Sub

