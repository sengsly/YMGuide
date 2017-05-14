Attribute VB_Name = "internal_player"
'***********************************************************************************'
'
'   text_track_scroll       :   Send text scroll with internalplay
'
'***********************************************************************************'
'HKEY_CLASSES_ROOT\CLSID\{00EFAEAA-BCDA-1EF1-EEDC-00AA006D2EA4}

Option Explicit
Public click_minimize_boolean As Boolean
'xxxxxx changed sith 23-05-06
Public Enum StatusEnum
   Stopping = 0
   Playing = 1
   Pausing = 3
   Opening = 5
   FileNotFound = 4
End Enum

 Public Enum FindEnum
   findnone = 0
   Duration = 1 ' Bookmarklength
   Position = 2 ' BookmarkTime
   callFuntion = 3 ' call function
   clientLoaded = 4
   subTitled = 5
   seekChapter = 6
   seekTime = 7
 End Enum
 Public OldWMPPos As Long ' store old position when start jump for bookmarktype 4
 Public localFind As FindEnum ' what we going to find use for tmrFindTime
 Public lastPlayTime As Long ' for last jump
 Public lastLoadClientIndex As Integer    'index for send seek
 Public boolPausedState As Boolean
 Public stopFakeTime As Boolean
 Public timeVisible As Long 'start Time for visible picmoviebackground sith 5-06-06
 Public tmpIndex As Integer
'xxxxxxxxxxxxx end xxxxxxxxxxxx

Public title_index As Integer
Public startNew As Boolean
'Public MusicLoaded as boole
'Public isFirstLoaded As Boolean
Public current_index_redownload As Integer

Public txtCurrent As String
Public txtLength As String
Public txtSeek As String
Public seekBarpercent As Single
Public seekBarDisplay As String
Public show_hide_player As Boolean

Public main_slideshow_path As String
Public store_list_index As Integer
'------------------
' login type
'------------------
Private loadByCommand As Boolean
Public Declare Function SetProp Lib "user32" Alias "SetPropA" (ByVal hwnd As Long, ByVal lpString As String, ByVal hData As Long) As Long
Public Declare Function GetProp Lib "user32" Alias "GetPropA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
Public Declare Function CloseHandle Lib "kernel32.dll" (ByVal handle As Long) As Long
Private Declare Function OpenProcess Lib "kernel32.dll" (ByVal dwDesiredAccessas As Long, ByVal bInheritHandle As Long, ByVal dwProcId As Long) As Long
Private Declare Function EnumProcesses Lib "psapi.dll" (ByRef lpidProcess As Long, ByVal cb As Long, ByRef cbNeeded As Long) As Long
Private Declare Function GetModuleFileNameEx Lib "psapi.dll" Alias "GetModuleFileNameExA" (ByVal hProcess As Long, ByVal hModule As Long, ByVal moduleName As String, ByVal nSize As Long) As Long
Private Declare Function EnumProcessModules Lib "psapi.dll" (ByVal hProcess As Long, ByRef lphModule As Long, ByVal cb As Long, ByRef cbNeeded As Long) As Long
Private Const MAX_PATH = 260
Private Const PROCESS_QUERY_INFORMATION = 1024
Private Const PROCESS_VM_READ = 16
Private Const PROCESS_TERMINATE = &H1

'------------------
' friend's playlist
'------------------
Public friend_playlist As Boolean
Public friend_playlist_path As String
Type friend_playlists
    path As String
    Name As String
End Type
' new variable for copy friend's playlist
Public FirstLoadPlay As Boolean
Public mydoc_client As String             ' store client mydocument path of client
Public server_name_connected As String    ' store computer name for copy friend playlist
Public arr_PLP() As new_Playlst           ' array store information for PlayListPaths.xml
Public arr_PL() As String                 ' array store information for PlayLists.xml
Public str_main_playlist_path As String   ' store path playlist that copy from connected computer
Public index_path As Integer              ' store index path to copy playlist from server
'------------------

Type playMusicInfoType
   PicturePathPic As String
   InfoPlayer As String
   SaveInPlayList As String
   PlayTrackID As String
   bRequesting As Boolean              'EDIT:2006-08-14
   ModePlay As String
   NameCountryPlay As String
   trackNo As Integer
End Type
Public boolRequestingNexPrev As Boolean
Public Type EncodingQueueType
   serverID As String
   serverNickName As String
   CopyString As String
   SourceFile As String
   TargetFile As String
End Type
Public ItemDelayPlay() As playMusicInfoType
Public EncodingQueue() As EncodingQueueType
Public arr_friend_playlist() As friend_playlists
'------------------

Public busy_copying_slideshow As Boolean
Public str_path_copying_slideshow As String
Public current_slideshow_path As String
Public external_slideshow_path As String
Public internal_slideshow_path As String
Public slideshow_mode As String     ' store mode of slideshow (External/Internal)
Public xml_slideshow_path As String
Public image_index As Integer
Public ExternalMusicPath As String

Public string_image_slideshow As String
Public copy_image_slideshow() As String
Public copying_image_path As String
Public syn As Boolean
Public b_resize As Boolean ' use for download image slideshow from server
Public b_rotate As Boolean ' use for rotate image in slideshow
Public b_AllowSlideshow As Boolean
Public syn_vol As Boolean
Public change_vol As Boolean
Public popup_exit As Boolean


Public b_allow_remove As Boolean

'Public fileSWF As String
Public resize_image As Boolean          ' controll use for resize image after down load completed
Public tmp_browse_folder As String
Public browse_folder_music As String            ' click in mini player for browse folder music file
Public browse_slideshow As String               ' click in save playlist for set browse folder slideshow
Public browse_new_playlist_folder As String     ' click in sort playlist for browse new folder to add new playlist
Public browse_slideshow_album As String         ' click in track page set slideshow for current album select
Public browse_slideshow_playlist As String      ' click in playlist page set slideshow for each playlist name
Public browse_import_playlist As String         ' click in sort playlist for import playlist
Public boolFirstLogged As Boolean
Private run_user_name As String


Public Lame_Path As String
Public FLAC_Path As String
Public APE_Path As String

Public scanAlbumPath As String
Public Type typeScaleVis
    vis_width As Long
    vis_height As Long
    vis_top As Long
    vis_left As Long
End Type
Public scaleVis As typeScaleVis
Public bool_full_vis As Boolean

Public Const unReg = "YMGuide 2007 (Unregistered Version)"
Public Const reged = "YMGuide 2007"
Public Const SlyEncodeProfile = "Sly Profile For downloading.prx"

Public wborder  As Long
Public hborder As Long

Public microStyle As micros
Public Enum micros
    oldStyle = 0
    newStyle = 1
End Enum

Public ripMusicWith As ripEnum
Public Enum ripEnum
   ripWithWindowMedia
   ripWithiTunes
End Enum

Public NoProcessShortCut As String
Public winampMusicDuration As Long
Public seekWidth As Single
Public seekTimeValue As Single
Public seekTimeLength As Single
Public boolSeeked As Boolean
Public boolRequestSeek As Boolean
Public boolTrackChanged As Boolean

Public tmpVolumeMute As Integer
Private private_playMusicWith As playerEnum
Public Enum playerEnum
    WindowMedia
    Winamp
    nero
    VideoLan
    MediaPlayer
    PlayNone
    PowerDVD
End Enum

Public tmpMousePosition As POINTAPI
Public tmpMousePositionPopup As POINTAPI

Public str_downloadBrowse As String
Private Type Browses
    Index As Integer
    filename As String
    fileUpdate As Date
    fileURL As String
End Type

Public str_newLanguageNameDownload As String

Public str_swfNames As String
Public str_unloadSwfName As String
'micro
Public microPosition() As String
Public lng_leftMicro As Long
Public lng_topMicro As Long
Public str_popupType As String
Public b_moveMicro As Boolean

'popup
Public popupPosition() As String
Public lng_leftPopup As Long
Public lng_topPopup As Long

Public str_infoPopup As String
Public b_popUp As Boolean
Public b_loadAlready As Boolean
Public b_addPlayCount As Boolean
Public One As Boolean


''''''''''''''''''''''''''''''Public old_int_track_count As Integer             ' store count of track old

Public tmpMTrack As Integer     ' for micro
Public timeInterval As Integer  ' permit time for change text
Public mainPathTrackPlaylist As String    ' for store path track playlist
Public PTPlaylist As Boolean
Public tmpstrPath As String      ' store temp path for compare image album
Public imagePathAlbumNext As String      ' store path next album
Public imagePathAlbumCurrent As String   ' store path current album
Public imagePathAlbumPrevious As String  ' store path previouse album
Public labelNextTrackForFullscreen As String          ' store track label next
Public labelPreviousTrackFullscreen As String      ' stroe track label previous
Public fontLabelNextTrack As String
Public HideInter As Boolean         ' for control hide inter or not
Public Micro As String              ' for control hide or show Micro Player
Public DisplayMini As Integer       ' for check for show mini player
Public Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Public oldStatus As Integer
Public CScan As Boolean             ' control scan when minimize scan file
Public minimizeInScan As Boolean    ' control when click minimize in scan file
Public scaleMicroByWidth As Integer        ' for micro scale width
Public scaleMicroByHeight As Integer       ' for micor scale height
Public b_displayNewTrack As Boolean         ' store for check to display track
Public Const symSplitString = "//\\"
'Public allPathCountries As String
'Private volume_value As Integer
Public AltTab As Boolean
Public About_Status As String

' for setting player
Public b_loop As Boolean
Public b_shuffle As Boolean
Public b_mute As Boolean
Public b_play As Boolean
Public b_pause As Boolean
Public b_startTime As Boolean    ' is a variable for send duration string for mini player
Public i_volume As Integer
Public s_button_color As String
Public s_button_color_alpha As String
Public s_button_color_selected As String
Public s_button_color_selected_alpha As String
Public s_text_color As String
Public s_background_color As String
Public s_color_bar As String
Public i_scale_by_width As Integer
Public i_scale_by_height As Integer
Public b_micro As Boolean
Public b_ads As Boolean
Public b_scroll As Boolean
Public b_tooltip As Boolean
Public s_display_type As String ' Image : Visual
Public b_reg As Boolean         ' for register
Public b_autoClose As Boolean   ' for scan
Public i_indexNextTrack As Integer  ' of index next track
Private Const LONG_SIZE = 4
' -----------

Public tempNextTrack As String  ' store value next track

'------------------------------
Public formWidth As Long
Public formHeight As Long
Public FirstLoad As Boolean
Public tmpWidth As Integer
Public tmpHeight As Integer
'------------------------------
Public Type Languages
    Eng As String
    Uni As String
End Type
Public Type TrackInfos
    TrackPath As String
    TrackTitle As Languages
    trackArtist As Languages
    trackAlbum As Languages
    trackFontName As Languages
    trackFontsize As Languages
    trackCaptionTitle As String
    trackCaptionArtist As String
    trackCaptionAlbum As String
    TrackLan As String
    trackExternal As Boolean
    trackImagePath As String
    TrackID As String
    trackAlbumID As String
End Type
Public Type Tracks
   ALBUM                As String
   UniAlbum             As String
   TRACK                As String
   UniTrack             As String
   ARTIST               As String
   UniArtist            As String
   Mood                 As String
   UniMood              As String
   DanceStyle           As String
   UniDanceStyle        As String
   Rating               As String
   Genre                As String
   UniGenre             As String
   Language             As String                                    'store the language of the
   Mode                 As String                                                     '.Mode = "Internal"      //External
   TrackID              As String
   picPath              As String
   albumID              As String
   LanTrack             As String                                    'store singing languages
   comName              As String
   Player               As String
   TrackYear            As String
   TrackAva             As String
   walMartAva           As String
   ShoppingID           As String
   NoTrack              As String
   TrackPath            As String
   StrPathPic           As String
   TrackIndex           As Long
   BlankTop             As Integer
   BlankBottom          As Integer
   ZoomLevel            As Integer
   Director             As String
   Actor                As String
   seekOffset           As Integer              'Index second        Index=34 for seek each chapter
   albumAvailable       As Boolean
   MainTitle            As Integer              'Index = 32
   BookmarkType         As Integer              '>0  it is bookmark,1 Play Till End,2 PlayTill Next Track,3 Play For amount of seconds,4 Like number 2 but it is jump to chapter not second for karaoke or music              'Index 27
   BookmarkTitle        As Integer              'title of the chapter
   BookmarkTime         As Long                 'second format
   BookmarkLength       As Long                 'length in second format
   BookmarkChapter      As Integer              'Chapter                Index=31
   AudioChannel         As Integer              'Index = 33 Audio channel 0 for first channel,1 for second channel....,2 for third channel,bit(8)=1 ==> None NonKaraokeChannel else bit(8)=0 =>KaraokeChannel

'''   TrackLength          As String               '00:00:00 Format
'''   TrackJumpTime        As String               '00:00:00 Format time jump for each track
   TrackLength          As Single               'In second
   TrackJumpTime        As Single               'In second
   PlayTrackPlayer      As String
   SingType             As Integer              'tell if the song to sing is for girls(0), guys(1), or duet(2)
   DownloadFromServer   As Boolean
   infoNotFilled        As Boolean
   PlayTrackFrom        As Integer              '(Index 35) 1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath
   NetWorkPath          As String               '36
   SubTitle             As Boolean
   StreamPath           As String               'Path from server to play small or large "",""
   StreamPathRequested  As Boolean
   'Last Index = 36
End Type

Public Infos() As TrackInfos
Public PlayTrackInfo() As Tracks

Public tmpInfos() As TrackInfos
'''Private cVolume As New classVolume                 '2007-03-14
Public tmpTrackInfos() As Tracks
Public b_storePlaylist As Boolean

'public withevents MediaPlayer as
Public pathTrackName As String
Public NameCountryPlay As String
Public ModePlay As String
Public pathTrackID As String
Public ScreenType As String         ' store value type of screen    Normal:Wide
Public fileSetupType As String      ' store value type of setup     Normal:wideScreen:Both

'-------------------------------
'variables for combind miniplayer
Public strCaption As String
Public strCurrent As String
Public strNext As String
Public strPrevious As String
Public LabelNext As String
Public strImgCurrent As String
Public strImgNext As String
Public strImgPrevious As String
Public durationLength As Single

'-one-one---------------------------------
Public int_next_index As Long
Public int_current_index As Long                      'store the index of playlist
Public str_current_Track As String                    'store the current playing track
Public str_previous_Track As String                    'store the played playing track
Public int_previous_index As Long
Public trackCountRefreshed As Boolean                 'for used with client/server
Public boolRequestingTrack As Boolean                 'indicate it is requesting track from server in player page
Public boolRequestingSaveTrack As Boolean                 'indicate it is requesting track from server in player page
'-----------------------------------

Public Function GetPlayerAlbums() As DOMDocument
   On Error GoTo Error
   Dim i As Long
   Dim SearchFilterArray As String
   Dim newAlbumAndLanguage As String
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlnode As IXMLDOMElement
   
   
   SearchFilterArray = ";"
   Set xmlRoot = XmlDoc.createElement("Player")
   For i = 0 To int_track_count - 1
      With PlayTrackInfo(i)
         newAlbumAndLanguage = .albumID & "*" & .Language & "*" & ";"
         If .albumID <> "" Then
            If InStr(1, SearchFilterArray, ";" & newAlbumAndLanguage, vbTextCompare) = 0 Then
               Set xmlnode = XmlDoc.createElement("Source")
               xmlnode.setAttribute "Name", .ALBUM
               xmlnode.setAttribute "UniName", .UniAlbum
               xmlnode.setAttribute "PicPath", ""
               xmlnode.setAttribute "Language", .Language
               xmlnode.setAttribute "AlbumID", .albumID
               xmlnode.setAttribute "StPlayer", .Player
               xmlnode.setAttribute "RePathPic", .picPath
               xmlnode.setAttribute "Year", .TrackYear
               xmlnode.setAttribute "ReservePath", ""
               xmlnode.setAttribute "ID", .albumID
               SearchFilterArray = SearchFilterArray & .albumID & "*" & .Language & "*" & ";"
               xmlRoot.appendChild xmlnode
            End If
         End If
      End With
   Next
   XmlDoc.appendChild xmlRoot
   Set GetPlayerAlbums = XmlDoc
   Exit Function
Error:
   WriteEvent "GetPlayerAlbums", Err.Description, Err.Source
End Function
Public Function StrPlayTrackInfo(Index As Long, count As Long) As String
   On Error GoTo Error
   Dim str As String
   Dim j As Integer
   Dim i As Integer
   For i = Index To int_track_count - 1
      If (j < count) Then
         With PlayTrackInfo(i)
            str = str + .ALBUM + "%%" + .UniAlbum + "%%" + .TRACK + "%%" + .UniTrack + "%%" + .ARTIST + "%%" + .UniArtist + "%%" + .Mood + "%%" + .UniMood + "%%" + .DanceStyle + "%%" + .UniDanceStyle + "%%" + .Rating + "%%" + .Genre + "%%" + .UniGenre + "%%" + .Mode + "%%" + .TrackID + "%%" + .picPath + "%%" + .Language + "%%" + .comName + "%%" + .albumID + "%%" + .LanTrack + "%%" + .TrackYear + "%%" + .TrackAva + "%%" + .walMartAva + "%%" + .ShoppingID + "%%" + .NoTrack + "&&" + .Player & "&&" & .DownloadFromServer & "&&" & .SingType & "&&&"
            j = j + 1
         End With
      Else
         Exit For
      End If
   Next
   If str <> "" Then StrPlayTrackInfo = left(str, Len(str) - 3)         'EDIT:2006-08-10 Seng
   Exit Function
Error:
   WriteEvent "StrPlayTrackInfo", Err.Description, Err.Source
End Function

Public Function ReadSearchTrack(unicode As Boolean) As String
   On Error GoTo Error
   Dim str As String
   Dim i As Integer
   For i = 0 To UBound(PlayTrackInfo)
      If unicode Then
         str = str + PlayTrackInfo(i).UniTrack + "&&&"
      Else
         str = str + PlayTrackInfo(i).TRACK + "&&&"
      End If
   Next
   ReadSearchTrack = left(str, Len(str) - 3)
   Exit Function
Error:
   WriteEvent "ReadSearchTrack", Err.Description, Err.Source
End Function


Public Sub EditXML(str_FullPath As String, int_IndexChildNodes As Double, str_Attribute As String, str_NewValue As String)
   On Error Resume Next
    Dim doc As DOMDocument
    Dim t As IXMLDOMElement
    Set doc = New DOMDocument
    doc.Load str_FullPath
    Set t = doc.childNodes(0).childNodes(int_IndexChildNodes)
    t.setAttribute str_Attribute, str_NewValue
    doc.Save str_FullPath
'''   Exit Sub
'''Error:
'''   WriteEvent "EditXML", Err.Description, Err.Source
End Sub

Public Function read_XML_attributes(str_FullPath As String, int_IndexChildNodes As Double, str_Attribute As String) As String
   On Error Resume Next
    Dim doc As DOMDocument
    Dim t As IXMLDOMElement
    Set doc = New DOMDocument
    doc.Load str_FullPath
    Set t = doc.childNodes(0).childNodes(int_IndexChildNodes)
    read_XML_attributes = t.getAttribute(str_Attribute)
'''   Exit Function
'''Error:
'''   WriteEvent "read_XML_attributes", Err.Description, Err.Source
End Function

Public Sub ChangeIndexPositionArrayTrack(ByRef OldIndex As Integer, ByRef newIndex As Integer, ByRef arr() As TrackInfos)
   On Error GoTo Error
    Dim tmpold() As TrackInfos
    Dim tmpnew() As TrackInfos
    Dim tmp() As TrackInfos
    Dim j As Integer
    ReDim tmpold(0)
    tmpold(0) = arr(OldIndex)
    ReDim tmpnew(0)
    tmpnew(0) = arr(newIndex)
    For j = LBound(arr) To UBound(arr)
        If (j = OldIndex) Then
            ReDim Preserve tmp(j)
            tmp(j) = tmpnew(0)
        ElseIf (j = newIndex) Then
            ReDim Preserve tmp(j)
            tmp(j) = tmpold(0)
        Else
            ReDim Preserve tmp(j)
            tmp(j) = arr(j)
        End If
    Next j
    arr = tmp
   Exit Sub
Error:
   WriteEvent "ChangeIndexPositionArrayTrack", Err.Description, Err.Source
End Sub

Public Sub remove_index_from_array_track_information(Index As Integer, ByRef arr() As Tracks)
   On Error GoTo Error
  Dim temp() As Tracks
  Dim j As Integer
  Dim i As Integer
  For i = LBound(arr) To UBound(arr)
    If i <> Index Then
      ReDim Preserve temp(j)
      temp(j) = arr(i)
      j = j + 1
    End If
  Next
  arr = temp
   Exit Sub
Error:
   WriteEvent "remove_index_from_array_track_information", Err.Description, Err.Source
End Sub


Public Function replacePath(MainPathDrive As String, OriPathDrive As String) As String
   On Error GoTo Error
   Dim tmp0 As String
   Dim tmp1 As String
   Dim tmp2 As String
   Dim strIndex As Integer
   Dim stri As Integer
   tmp0 = mID(MainPathDrive, 1, 2)
   tmp1 = mID(OriPathDrive, 4)
   tmp2 = mID(OriPathDrive, 1, 2)
    If (tmp2 = "\\") Then
        replacePath = OriPathDrive
    Else
        If (tmp0 = "\\") Then
            For strIndex = 1 To Len(MainPathDrive)
                If mID(MainPathDrive, strIndex, 1) = "\" Then
                    stri = stri + 1
                    If (stri = 4) Then
                    replacePath = mID(MainPathDrive, 1, strIndex) & tmp1
                    End If
                End If
            Next strIndex
        Else
            replacePath = OriPathDrive
        End If
    End If
   Exit Function
Error:
   WriteEvent "replacePath", Err.Description, Err.Source
End Function

Sub create_xml_PlayListsXML(file_path As String, str_text_name_playlist As String)
   On Error GoTo Error
    Dim xml_new As DOMDocument
    Dim xml_new_root As IXMLDOMElement
    Dim xml_pl As DOMDocument
    Dim xml_pl_root As IXMLDOMElement
    Dim xml_pl_elem As IXMLDOMElement
    
    If Dir(file_path) = "" Then
        Set xml_new = New DOMDocument
        xml_new.Load file_path
        Set xml_new_root = xml_new.createElement("PlayLists")
        xml_new.appendChild xml_new_root
        xml_new.Save file_path
    End If
    
    Set xml_pl = New DOMDocument
    xml_pl.Load file_path
    Set xml_pl_root = xml_pl.firstChild
    Set xml_pl_elem = xml_pl.createElement("PlayList")
    xml_pl_elem.setAttribute "SlidePath", ""
    xml_pl_elem.setAttribute "ImgPath", ""
    xml_pl_elem.Text = str_text_name_playlist
    xml_pl_root.appendChild xml_pl_elem
    xml_pl.Save file_path
    
   Exit Sub
Error:
   WriteEvent "create_xml_PlayListsXML", Err.Description, Err.Source
End Sub

Public Function label_next_track(strPath As String, Lan As String, scr As String) As String
   On Error GoTo Error
   If strPath <> "Playlist" Then
      Dim ndoc As DOMDocument
      Dim nt As IXMLDOMElement    ' for label next track
      Dim nf As IXMLDOMElement    ' for font name and font size
      Dim l As String
      Dim f As String
      Dim s As String
      
      Set ndoc = New DOMDocument
      ndoc.Load strPath & "\Language.xml"
      If ndoc.parseError = 0 Then
         Set nt = ndoc.childNodes(0).childNodes(1)
         Set nf = ndoc.childNodes(0).childNodes(0)
         If Language = "Uni" Then
             If nt.getAttribute("miniNext") <> "" Then
                 If currentCountry = "English" Then
                     l = "Next:"
                     f = nf.getAttribute("FontUni")
                     If scr = "Normal" Then
                         s = nf.getAttribute("FontUniSize")
                     Else
                         s = nf.getAttribute("FontUniSizeWide")
                     End If
                 Else
                     l = nt.getAttribute("miniNext")
                     
                     If (l = "bTbnÞab;") Then
                         l = l & "³"
                     Else
                         l = l & ":"
                     End If
                     
                     f = nf.getAttribute("FontUni")
                     If scr = "Normal" Then
                         s = nf.getAttribute("FontUniSize")
                     Else
                         s = nf.getAttribute("FontUniSizeWide")
                     End If
                     
                 End If
             Else
                 l = "Next:"
                 f = nf.getAttribute("FontEng")
                 If scr = "Normal" Then
                     s = nf.getAttribute("FontEngSize")
                 Else
                     s = nf.getAttribute("FontEngSizeWide")
                 End If
             End If
         Else
             l = "Next:"
             f = nf.getAttribute("FontEng")
             If scr = "Normal" Then
                 s = nf.getAttribute("FontEngSize")
             Else
                 s = nf.getAttribute("FontEngSizeWide")
             End If
         End If
      End If
    Else
        l = "Next:"
        f = "Arial"
        If scr = "Normal" Then
            s = "25"
        Else
            s = "30"
        End If
    End If
    label_next_track = l & symSplitString & f & symSplitString & s
   Exit Function
Error:
   WriteEvent "label_next_track", Err.Description, Err.Source
End Function

Public Function sendVariables(obj As Object, openStr As String, strName As String, strValue As String)
On Error GoTo ErrorObject
    obj.SetVariable strName, strValue
    obj.SetVariable openStr, "true"
    obj.SetVariable "openFrame", "true"
ErrorObject:
End Function


Public Function ReplaceStrSpl(str As String, Index As Integer, Value As String, Delimiter As String) As String
   On Error GoTo Error
   Dim temp() As String
   temp = Split(str, Delimiter)
   temp(Index) = Value
   ReplaceStrSpl = Join(temp, Delimiter)
   Exit Function
Error:
   WriteEvent "ReplaceStrSpl", Err.Description, Err.Source
End Function
 
Public Function changeLanguagePath(ImagePath As String, databasePath As String)
   On Error GoTo Error
   Dim filePath As String
   Dim iiii As Integer
   Dim strPath As String
   Dim strImagePath As String
   Dim oldMainPath As String
       
   filePath = App.path & "\sly\Countries.xml"
       
   Dim doc As DOMDocument
   Dim t As IXMLDOMElement
   Dim tt As IXMLDOMElement
   Set doc = New DOMDocument
   doc.Load filePath
   Set t = doc.childNodes(0)
   For iiii = 0 To t.childNodes.Length - 1
      Set tt = doc.childNodes(0).childNodes(iiii)
      If StrComp(tt.Text, currentCountry, vbTextCompare) = 0 Then
         tt.setAttribute "Path", databasePath
         tt.setAttribute "imagePath", ImagePath
      End If
   Next iiii
   
   doc.Save filePath
   Exit Function
Error:
   WriteEvent "changeLanguagePath", Err.Description, Err.Source
End Function

 
'===========================================================================================
' function for combind mini player
'===========================================================================================
Public Sub sendToFlash(fileSwf As ShockwaveFlashObjectsCtl.ShockwaveFlash, command As String, args As String)
   On Error GoTo ErrorObject
   fileSwf.SetVariable "vb", command & "|%|" & args
ErrorObject:
End Sub
Public Sub sendVariable2Flash(fileSwf As ShockwaveFlashObjectsCtl.ShockwaveFlash, Name As String, ByVal Value As String)
   On Error GoTo ErrorObject
   fileSwf.SetVariable Name, Value
ErrorObject:
End Sub

Private Function get_Next_Track(cur_Play As Long)
   On Error GoTo Error
    Dim Tr As String
    Dim FN As String
    Dim fs As String
    If cur_Play >= int_track_count Then cur_Play = 0
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
    get_Next_Track = Tr & "//\\" & FN & "//\\" & fs
   Exit Function
Error:
   WriteEvent "get_Next_Track", Err.Description, Err.Source
End Function

Public Sub setPlayCount(ByVal int_trackID As Long, str_countryName As String, ByVal Index As Integer)
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Dim loc_iRating As Integer
   Set cLanguage = GetCountryClass(str_countryName)
   
   loc_iRating = cLanguage.SetTrackNumPlay(0, int_trackID)
   If loc_iRating > 0 Then
      PlayTrackInfo(Index).Rating = loc_iRating
      SetTrackField int_trackID, "Rating", loc_iRating, str_countryName 'assign to database
      If IndexSwf = 4 Then
          sendVariable2Flash FrmMain.swf(4), "PassTrackInfoLen", int_track_count
          sendVariable2Flash FrmMain.swf(4), "RefreshRating", loc_iRating & "||" & Index
          sendVariable2Flash FrmMain.swf(4), "OpenFrame", "true"
      End If
   End If
   
   CWinsock.Send2Client WS_COMMAND, 0, "SetClientRating&&&" & Index & "&&&" & int_trackID
   Exit Sub
Error:
   WriteEvent "setPlayCount", Err.Description, Err.Source
End Sub
Public Function get_country_type(str_countryName As String) As Integer
'(1 Movie,2 TVSeries,4 Music,8 Karaoke,16 CD)
On Error GoTo Error
   get_country_type = val(SlyVariable("<" & str_countryName & "_id>"))
   Exit Function
Error:
   WriteEvent "get_country_path", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   get_country_path
' Description       :   Get country path
' Return Values     :   Country Path
' Input Parameter   :   Country Name
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             07-14-2006           07-14-2006
'*******************************************************************************

Public Function get_country_path(str_countryName As String) As String
   On Error GoTo Error
   get_country_path = SlyVariable("<" & str_countryName & "_dat>")
   Exit Function
Error:
   WriteEvent "get_country_path", Err.Description, Err.Source
End Function

Public Function get_country_image(str_countryName As String) As String
   'Get country image page
   On Error GoTo Error
   get_country_image = SlyVariable("<" & str_countryName & "_img>")
   Exit Function
Error:
   WriteEvent "get_country_image", Err.Description, Err.Source
End Function

Public Sub setTrackLocation(str_location As String)
    On Error Resume Next
    EditSetting MainSettingXML, 2, "trackLocation", str_location
    
    Dim tmparrspl() As String
    tmparrspl = Split(str_location, "-")
    If (ScreenX / ScreenY) = 1024 / 768 Then
       sendToFlash FrmMain.swf(0), "PositionTrackShow", tmparrspl(0)
    ElseIf (ScreenX / ScreenY) = 1280 / 720 Then
        sendToFlash FrmMain.swf(0), "PositionTrackShow", tmparrspl(0)
    ElseIf (ScreenX / ScreenY) = 1280 / 768 Then
        sendToFlash FrmMain.swf(0), "PositionTrackShow", tmparrspl(0)
    ElseIf (ScreenX / ScreenY) = 1280 / 800 Then
        sendToFlash FrmMain.swf(0), "PositionTrackShow", tmparrspl(0)
    ElseIf (ScreenX / ScreenY) = 1024 / 600 Then
        sendToFlash FrmMain.swf(0), "PositionTrackShow", tmparrspl(0)
    End If
    
    Dim tmpArray() As String
    tmpArray = Split(tmparrspl(0), ":")
    lng_leftMicro = CLng(tmpArray(0))
    lng_topMicro = CLng(tmpArray(1))

    popupPosition(0) = tmparrspl(0)
    popupPosition(1) = ScreenX & ":" & ScreenY
    
End Sub

Private Function getCurrentBitrate(str_bitrate As String) As Long
   On Error GoTo Error
    Dim init As Integer
    str_bitrate = mID(str_bitrate, 10)
    For init = 1 To Len(str_bitrate) - 1
        If mID(str_bitrate, init, 1) = " " Then
            getCurrentBitrate = CLng(mID(str_bitrate, 1, init - 1))
            Exit For
        End If
    Next init
   Exit Function
Error:
   WriteEvent "getCurrentBitrate", Err.Description, Err.Source
End Function

Private Function getBitrateSong(obj_wmp As WindowsMediaPlayer) As String
   On Error GoTo Error
    Dim ft As String    'file type :wma,mp3
    Dim br As Long      'bite rate :128,...
    Dim ll As String    'lossless
    Dim vbr As String
    Dim boolErrorFile As Boolean
    boolErrorFile = obj_wmp.currentMedia Is Nothing
    If Not boolErrorFile Then
      ft = obj_wmp.currentMedia.getItemInfo("FileType") & " "
    End If
    getBitrateSong = UCase(ft)
   Exit Function
Error:
   WriteEvent "getBitrateSong", Err.Description, Err.Source
End Function

Public Sub moveMicro(objFrm As Form, lng_microLeft As Long, lng_microTop As Long)
   On Error GoTo Error
   Dim hMonitor As Long
   Dim rt As RECTM
   Dim rm  As RECTM
   'EDIT:2006-08-01     2 Monitors
   'Convert from Twip to pixels
   rm = MonitorRECTM(i_SlyMonitor)
   rt.left = objFrm.left / Screen.TwipsPerPixelX - rm.left
   rt.top = objFrm.top / Screen.TwipsPerPixelY - rm.top
   rt.Width = objFrm.Width / Screen.TwipsPerPixelX
   rt.Height = objFrm.Height / Screen.TwipsPerPixelY
   
   If rt.left < 0 Then rt.left = rm.left                                                  'Test Left
   If rt.top < 0 Then rt.top = rm.top                                                     'Test Top
   If rt.left + rt.Width > rm.Width Then rt.left = rm.Width - rt.Width                    'Test Width
   If rt.top + rt.Height > rm.Height Then rt.top = rm.Height - rt.Height                  'Test Height
   MoveForm2Monitor i_SlyMonitor, objFrm.hwnd, rt.left, rt.top
   microPosition(0) = rt.left & ":" & rt.top
   microPosition(1) = rm.Width & ":" & rm.Height
   EditSetting MainSettingXML, 2, "microLocation", microPosition(0) & "-" & microPosition(1)
   Exit Sub
Error:
   WriteEvent "moveMicro", Err.Description, Err.Source
End Sub

Public Sub movePopup(objFrm As Form, lng_microLeft As Long, lng_microTop As Long, lng_screenWidth As Long, lng_screenHeigh As Long)
   On Error GoTo Error
    If lng_microLeft < 0 Then
        lng_microLeft = 0
    End If
    If lng_microTop < 0 Then
        lng_microTop = 0
    End If
    If objFrm.left + objFrm.Width > lng_screenWidth * Screen.TwipsPerPixelX Then
        lng_microLeft = (lng_screenWidth * Screen.TwipsPerPixelX) - objFrm.Width
    End If
    If objFrm.top + objFrm.Height > lng_screenHeigh * Screen.TwipsPerPixelY Then
        lng_microTop = (lng_screenHeigh * Screen.TwipsPerPixelY) - objFrm.Height
    End If
    objFrm.left = lng_microLeft
    objFrm.top = lng_microTop
    lng_leftMicro = objFrm.left / Screen.TwipsPerPixelX
    lng_topMicro = objFrm.top / Screen.TwipsPerPixelY
    
    popupPosition(0) = objFrm.left & ":" & objFrm.top
    popupPosition(1) = lng_screenWidth & ":" & lng_screenHeigh
    'EditSetting MainSettingXML, 2, "trackLocation", microPosition(0) & "-" & microPosition(1)
    setTrackLocation objFrm.left / Screen.TwipsPerPixelX & ":" & objFrm.top / Screen.TwipsPerPixelY & "-" & popupPosition(1)
   Exit Sub
Error:
   WriteEvent "movePopup", Err.Description, Err.Source
End Sub

Public Sub moveInScreen(objFrm As Form, lng_microLeft As Long, lng_microTop As Long, lng_screenWidth As Long, lng_screenHeigh As Long)
   On Error GoTo Error
    If lng_microLeft < 0 Then
        lng_microLeft = 0
    End If
    If lng_microTop < 0 Then
        lng_microTop = 0
    End If
    If objFrm.left + objFrm.Width > lng_screenWidth * Screen.TwipsPerPixelX Then
        lng_microLeft = (lng_screenWidth * Screen.TwipsPerPixelX) - objFrm.Width
    End If
    If objFrm.top + objFrm.Height > lng_screenHeigh * Screen.TwipsPerPixelY Then
        lng_microTop = (lng_screenHeigh * Screen.TwipsPerPixelY) - objFrm.Height
    End If
    objFrm.left = lng_microLeft
    objFrm.top = lng_microTop
    
   Exit Sub
Error:
   WriteEvent "moveInScreen", Err.Description, Err.Source
End Sub

Public Sub changeImageAlbumPath(lng_AlbumID As Long, str_imagePath As String, str_Language As String)
On Error GoTo Ended
   Dim init As Integer
   For init = 0 To UBound(Infos)
       If CLng(Infos(init).trackAlbumID) = lng_AlbumID And Infos(init).TrackLan = str_Language Then
           Infos(init).trackImagePath = str_imagePath
           If CLng(Infos(int_current_index).trackAlbumID) = lng_AlbumID Then
              get_track_info False
           End If
       End If
   Next init
Ended:
End Sub

Public Function seekPressed(lng_lengTrack As Long, lng_currentPos As Long, b_click_pageUp As Boolean) As Long
    
    If b_click_pageUp = True Then
        seekPressed = lng_currentPos + 10
    Else
        seekPressed = lng_currentPos - 10
    End If
    
    'Me.wmp.Controls.CurrentPosition = seekPressed(wmp.currentMedia.duration, wmp.Controls.CurrentPosition, True)
End Function

Public Sub PurchaseCDAlbum(args As String, str_Language As String)
   On Error GoTo Error
    Dim url As String
    Dim ASIN As String
    Dim spl() As String
    Dim Index As String
    spl = Split(args, "~")
    If spl(1) = "English" Then
            Index = spl(2)
            If Index = "0" Then
               ASIN = GetAlbumField(val(spl(0)), "ASIN", str_Language)
               If ASIN <> "" Then
                  url = "http://www.amazon.com/exec/obidos/ASIN/" & ASIN & Change("/flrzEd3tEn-GY", False)
               End If
            ElseIf Index = "1" Then
               ASIN = GetAlbumField(val(spl(0)), "BuyCom", str_Language)
               If ASIN <> "" Then
                  url = "http://click.linksynergy.com/fs-bin/click?id=lKNL1t4AlxE&offerid=56785." & ASIN & "&type=2&subid=0"
               End If
            ElseIf Index = "2" Then
               ASIN = GetAlbumField(val(spl(0)), "WalmartCom", str_Language)
               If ASIN <> "" Then
                  url = "http://click.linksynergy.com/fs-bin/click?id=lKNL1t4AlxE&offerid=40579." & ASIN & "&type=2&subid=0"
               End If
            ElseIf Index = "3" Then
               ASIN = GetAlbumField(val(spl(0)), "Walmart_DD", str_Language)
               If ASIN <> "" Then
                  url = "http://musicdownloads.walmart.com/catalog/servlet/CartServlet?catitemid=" & ASIN
               End If
            End If
        
    Else
        ASIN = GetAlbumField(spl(0), , str_Language)
        If ASIN <> "" Then
            If spl(1) = "Chinese" Or spl(1) = "Korean" Or spl(1) = "Japanese" Then
               url = "http://us.yesasia.com/assocred.asp?" & Change("9kwAP8Lp", False) & "+http://us.yesasia.com/en/PrdDept.aspx/pid-" & ASIN
            ElseIf spl(1) = "Thai" Then
               url = "http://www.ethaicd.com/show.php?pid=" & ASIN & Change("&HffC=2NYy", False)
            ElseIf spl(1) = "Vietnamese" Then
               url = "http://www.saigoncd.com/ci/ProductDetails.cfm?ProductID=" & ASIN
            End If
        End If
    End If
    If url <> "" Then ShellExecute FrmMain.hwnd, "Open", url, "", "", 1
   Exit Sub
Error:
   WriteEvent "PurchaseCDAlbum", Err.Description, Err.Source
End Sub

'==================================================================================
'==================================================================================
Public Function load_fullscreen_micro_ads(str_swfname As String, int_swfIndex As Integer)
   On Error GoTo Error
    If str_swfname = "Fullscreen" Then
        Dim tmpPath As String
        str_swfNames = str_swfname
        Load FrmMain.SWF_FMA(int_swfIndex)
        If ScreenType = "Normal" Then
            tmpPath = App.path & "\sly\FullScreenNS.sly"
        ElseIf ScreenType = "wideScreen" Then
            tmpPath = App.path & "\sly\FullScreenWS.sly"
        ElseIf ScreenType = "mediumWideScreen" Then
            tmpPath = App.path & "\sly\FullScreenWSM.sly"
        ElseIf ScreenType = "mediumLargeWideScreen" Then
            tmpPath = App.path & "\sly\FullScreenWSH.sly"
        ElseIf ScreenType = "smallWideScreen" Then
            tmpPath = App.path & "\sly\FullScreenWSS.sly"
        ElseIf ScreenType = "largeWideScreen" Then
            tmpPath = App.path & "\sly\FullScreenWSL.sly"
        End If
    ElseIf str_swfname = "Micro" Then
        str_swfNames = str_swfname
        Load FrmMain.SWF_FMA(int_swfIndex)
        If microStyle = oldStyle Then
            tmpPath = App.path & "\sly\Micro_old.sly"
        ElseIf microStyle = newStyle Then
            tmpPath = App.path & "\sly\Micro_old.sly"
        End If
    ElseIf str_swfname = "Ads" Then
        Load FrmMain.SWF_FMA(int_swfIndex)
        tmpPath = App.path & "\sly\Browse.sly"
    End If
    LoadSwf FrmMain.SWF_FMA(int_swfIndex), tmpPath
   Exit Function
Error:
   WriteEvent "load_fullscreen_micro_ads", Err.Description, Err.Source
End Function

Public Function unload_fullscreen_micro_ads(int_swfIndex As Integer)
   On Error GoTo Error
    FrmMain.SWF_FMA(int_swfIndex).Visible = False
    If int_swfIndex = 1 Then
        str_unloadSwfName = "Fullscreen"
        FrmMain.tmrUnloadFull.Interval = 1
        FrmMain.tmrUnloadFull.Enabled = True
    ElseIf int_swfIndex = 2 Then
        str_unloadSwfName = "Micro"
        FrmMain.tmrUnloadMicro.Interval = 1
        FrmMain.tmrUnloadMicro.Enabled = True
    ElseIf int_swfIndex = 3 Then
        Unload FrmMain.SWF_FMA(3)
    End If
    str_swfNames = ""
   Exit Function
Error:
   WriteEvent "unload_fullscreen_micro_ads", Err.Description, Err.Source
End Function

Public Sub sendInfoControllPlayer(str_Control As String)
   On Error GoTo Error
   If LoadSlideshow = True Then
      sendToFlash frmSlideShow.SlideShow, "TrackShow", str_Control
   Else
      If IndexSwf <> 0 Or IndexSwf <> 4 Then
         sendToFlash FrmMain.swf(IndexSwf), "TrackShow", str_Control
      End If
      If str_swfNames = "Fullscreen" Then
         sendToFlash FrmMain.SWF_FMA(1), "TrackShow", str_Control
      End If
   End If
   Exit Sub
Error:
   WriteEvent "sendInfoControllPlayer", Err.Description, Err.Source
End Sub

Public Function numKeyPress(str_value As String)
   On Error GoTo Error
    str_value = (CLng(str_value) - 1)
    If int_track_count > 0 And (CLng(str_value) >= 0 And CLng(str_value) < int_track_count) Then
         b_play = False
         int_current_index = str_value
         miniCommand "Play|:|true"
    End If
   Exit Function
Error:
   WriteEvent "numKeyPress", Err.Description, Err.Source
End Function

Public Sub pressKeyResizeMicro(b_increase As Boolean)
   On Error GoTo Error
    
    Dim arg As String
    Dim tmp_arg As String
    Dim tmpsplit() As String
    
    arg = scaleMicroByWidth & " x " & scaleMicroByHeight
    tmp_arg = arg
    
    If b_increase = True Then
        If arg = "1024 x 768" Then
            arg = "800 x 600"
        ElseIf arg = "800 x 600" Then
            arg = "640 x 480"
        ElseIf arg = "640 x 480" Then
            arg = "640 x 480"
        End If
    Else
        If arg = "640 x 480" Then
            arg = "800 x 600"
        ElseIf arg = "800 x 600" Then
            arg = "1024 x 768"
        ElseIf arg = "1024 x 768" Then
            arg = "1024 x 768"
        End If
    End If
    
    If tmp_arg <> arg Then
        tmpsplit = Split(arg, " x ")
        EditSetting MainSettingXML, 2, "MicroScale", arg
        FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 8, arg, "~")
        scaleMicroByWidth = val(tmpsplit(0))        ' 640 || 800 || 1024
        scaleMicroByHeight = val(tmpsplit(1))       ' 480 || 600 || 768
        FrmMain.MicroAds b_micro, b_ads, CInt(val(tmpsplit(0))), CInt(val(tmpsplit(1))), False
        i_scale_by_width = CInt(scaleMicroByWidth)      ' 640 || 800 || 1024
        i_scale_by_height = CInt(scaleMicroByHeight)    ' 480 || 600 || 768
    End If
   Exit Sub
Error:
   WriteEvent "pressKeyResizeMicro", Err.Description, Err.Source
End Sub


Public Function downloadNewBrowses(str_browse As String) As String
   On Error GoTo Error
    Dim browse_arr() As String
    Dim inter_arr() As Browses
    Dim local_arr() As Browses
    Dim download_arr() As Browses
    Dim i As Integer
    Dim j As Integer
    Dim Index As Integer
    Dim tmp_arr() As String
    Dim tmp_arr1() As String
    Dim tmp_arr2() As String
    Dim new_boo As Boolean
    Dim new1_boo As Boolean
    Dim new2_boo As Boolean
    Dim str_fileName As String
    
    browse_arr = Split(str_browse, "<>")
    
    Index = 0
    tmp_arr = Split(browse_arr(0), "&&&")
    For i = 0 To UBound(tmp_arr)
        tmp_arr1 = Split(tmp_arr(i), "%%%")
        For j = 0 To UBound(tmp_arr1)
            tmp_arr2 = Split(tmp_arr1(j), "|||")
            ReDim Preserve inter_arr(Index)
            inter_arr(Index).Index = CInt(tmp_arr2(0))
            inter_arr(Index).filename = tmp_arr2(1)
            inter_arr(Index).fileUpdate = CDate(tmp_arr2(2))
            inter_arr(Index).fileURL = tmp_arr2(3)
            Index = Index + 1
        Next j
    Next i
    
    Index = 0
    tmp_arr = Split(browse_arr(1), "&&&")
    For i = 0 To UBound(tmp_arr)
        tmp_arr1 = Split(tmp_arr(i), "%%%")
        For j = 0 To UBound(tmp_arr1)
            tmp_arr2 = Split(tmp_arr1(j), "|||")
            ReDim Preserve local_arr(Index)
            local_arr(Index).Index = CInt(tmp_arr2(0))
            local_arr(Index).filename = tmp_arr2(1)
            local_arr(Index).fileUpdate = CDate(tmp_arr2(2))
            local_arr(Index).fileURL = tmp_arr2(3)
            Index = Index + 1
            new2_boo = True
        Next j
    Next i
    
    Index = 0
    For i = 0 To UBound(inter_arr)
        new_boo = True
        If new2_boo = True Then
            For j = 0 To UBound(local_arr)
                If (inter_arr(i).fileUpdate <= local_arr(j).fileUpdate) And (inter_arr(i).filename = local_arr(j).filename) Then
                    new_boo = False
                    Exit For
                End If
            Next j
        End If
        If new_boo = True Then
            new_boo = False
            ReDim Preserve download_arr(Index)
            download_arr(Index).Index = inter_arr(i).Index
            download_arr(Index).filename = inter_arr(i).filename
            download_arr(Index).fileUpdate = inter_arr(i).fileUpdate
            download_arr(Index).fileURL = inter_arr(i).fileURL
            Index = Index + 1
            new1_boo = True
        End If
    Next i
    
    new2_boo = False
    If new1_boo = True Then
        new1_boo = False
        For i = 0 To UBound(download_arr)
            If i < 10 Then
                str_fileName = str_fileName & "&&&" & download_arr(i).filename
                changeXmlBrowse CLng(download_arr(i).Index), download_arr(i).filename, CStr(download_arr(i).fileUpdate), download_arr(i).fileURL
            End If
        Next i
        str_fileName = mID(str_fileName, 4)
        downloadNewBrowses = str_fileName
    Else
        downloadNewBrowses = ""
    End If
   Exit Function
Error:
   WriteEvent "downloadNewBrowses", Err.Description, Err.Source
End Function


Private Sub changeXmlBrowse(lng_index As Long, str_fileName As String, str_fileUpdate As String, str_fileType As String)
   On Error GoTo Error
    Dim jj As Integer
    
    Dim doc As DOMDocument
    Dim t As IXMLDOMElement
    Dim d As IXMLDOMElement
    
    Dim n As IXMLDOMElement
    Dim nn As IXMLDOMElement
    
    Set doc = New DOMDocument
    doc.Load App.path & "\sly\browses.sly"
    Set t = doc.firstChild.childNodes(lng_index)
    For jj = 0 To t.childNodes.Length - 1
        Set d = t.childNodes(jj)
        If d.getAttribute("browseFile") = str_fileName Then
            d.setAttribute "browseUpdate", str_fileUpdate
            doc.Save App.path & "\sly\browses.sly"
            Exit Sub
        End If
    Next jj
    Set n = doc.createElement("browse")
    n.setAttribute "browseFile", str_fileName
    n.setAttribute "browseUpdate", str_fileUpdate
    n.setAttribute "browseType", str_fileType
    t.appendChild n
    doc.Save App.path & "\sly\browses.sly"
   Exit Sub
Error:
   WriteEvent "changeXmlBrowse", Err.Description, Err.Source
End Sub

Public Property Get WaveVolume() As Integer
   WaveVolume = i_volume
End Property
Public Property Get WaveMute() As Boolean
   WaveMute = b_mute
End Property

Public Property Let WaveMute(bValue As Boolean)
   b_mute = bValue
   If b_mute Or run_bVolumeMuted Then
      CPlayer.Volume = 0
   Else
      CPlayer.Volume = WaveVolume
   End If
End Property
Public Property Let WaveVolume(newValue As Integer)
   On Error GoTo Error
   i_volume = newValue
   If i_volume < 0 Then i_volume = 0
   If i_volume > 100 Then i_volume = 100          ' if it is bigger than 100 reduce to 100
   
   If b_mute Or run_bVolumeMuted Then
      CPlayer.Volume = 0
   Else
      CPlayer.Volume = i_volume
   End If
   
   FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 0, CStr(i_volume), "~")
   Exit Property
Error:
   WriteEvent "Let WaveVolume", Err.Description, Err.Source
End Property

Public Sub eventMouseClick()
   On Error GoTo Error
    
    Dim MousePosition As POINTAPI
    GetCursorPos MousePosition
    SetCursorPos MousePosition.X + 1, MousePosition.Y
   
   Exit Sub
Error:
   WriteEvent "eventMouseClick", Err.Description, Err.Source
End Sub

Public Sub SendSeek2Player(ByVal CP As Long, ByVal du As Long, ByVal FakeTime As String)
   On Error GoTo Error
   Dim iExtraTime As Single
   seekTimeValue = CP
   seekTimeLength = du
   
   If ScreenType = "Normal" Then                       'NS
      seekWidth = (229.5 * CP) / du
   ElseIf ScreenType = "wideScreen" Then               'WS
      seekWidth = (388 * CP) / du
   ElseIf ScreenType = "mediumWideScreen" Then         'WSM
      seekWidth = (388 * CP) / du
   ElseIf ScreenType = "mediumLargeWideScreen" Then    'WSH
      seekWidth = (388 * CP) / du
   ElseIf ScreenType = "smallWideScreen" Then          'WSS
      seekWidth = (299 * CP) / du
   ElseIf ScreenType = "largeWideScreen" Then          'WSL
      seekWidth = (229.5 * CP) / du
   End If
   seekWidth = CLng(seekWidth)
   
   txtSeek = seekWidth

   run_FakeTime = FakeTime
      If run_PreviousRootMenu And CPlayer.IsInMenuMode = False Then
         'handleMinicommand "Resume|:|" & getCurrentDuration
         handleMinicommand "Resume|:|" & CPlayer.Seeks
         run_PreviousRootMenu = False
      End If
   If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentServer) Then
      If boolSeeked = False And CP > 1 Then
         CWinsock.Send2Client WS_COMMAND, 0, "setFakeTime&&&" & run_FakeTime & "&&&" & getPlayState
         
         boolSeeked = True
         b_startTime = True
      End If
   ElseIf CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
      '===blank screen before seeks - sith
   End If
   Exit Sub
Error:
   WriteEvent "SendSeek2Player", Err.Description, Err.Source
End Sub
Public Sub RemovePlayerTrack(ByVal TrackIndex As Integer)
   On Error GoTo Error
    b_allow_remove = True
    'removeItem TrackIndex
    If MusicNoteValue <> "true" Then
        miniCommand "Remove" & "|:|" & TrackIndex
    End If
    If CWinsock.LoggedAs(ServerMode) Then
        CWinsock.Send2Client WS_COMMAND, 0, "Command&&&RemoveTrack&&&" & TrackIndex
    End If
    b_allow_remove = False
   Exit Sub
Error:
   WriteEvent "RemovePlayerTrack", Err.Description, Err.Source
End Sub
Public Sub MoveTrack(ByVal moveIndex As Long, moveValue As String)
   On Error GoTo Error
   If int_track_count > 1 Then
      Dim tmpTrack As Tracks
      Dim newIndex As Long
      Dim movement As Integer
      
      If moveValue = "Up" Then movement = -1 Else movement = 1
      tmpTrack = PlayTrackInfo(moveIndex)
      newIndex = (moveIndex + movement)
      
      If newIndex < 0 Then newIndex = (int_track_count - 1)
      If newIndex >= int_track_count Then newIndex = 0
      PlayTrackInfo(moveIndex) = PlayTrackInfo(newIndex)
      PlayTrackInfo(newIndex) = tmpTrack
      
      If IndexSwf = 4 Then
          sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
      End If
      SendRefreshTrack2Clients
   End If
   Exit Sub
Error:
   WriteEvent "MoveTrack", Err.Description, Err.Source
End Sub
Public Sub AddMusicToPlayer(ByVal fileListName As String, Optional varComputerName As String = "")
   On Error GoTo Error
   Dim fileNames() As String
   Dim i As Long
   Dim stringPath As String
   Dim stringPathPicture As String
   Dim stringAlbum As String
   Dim stringArtist As String
   Dim stringTitle As String
   Dim stringNewTrack As String
   Dim stPlayList As String
   Dim stFontSize As String
   Dim stSharePath As String
   
   If fileListName = "" Then Exit Sub
   fileNames = Split(fileListName, Chr(0))
   If UBound(fileNames) = 0 Then
      ReDim Preserve fileNames(1)
      fileNames(1) = fso.GetFileName(fileNames(0))
      fileNames(0) = fso.GetParentFolderName(fileNames(0))
   End If
   If varComputerName <> "" Then
      stringPath = GetUniversalName(fileNames(0), varComputerName)
   Else
      stringPath = fileNames(0)
   End If
   stringPathPicture = fso.BuildPath(stringPath, "folder.jpg")
   stringAlbum = fso.GetBaseName(stringPath)
   stringArtist = fso.GetBaseName(fso.GetParentFolderName(stringPath))
   For i = 1 To UBound(fileNames)
         pathTrackName = fso.BuildPath(stringPath, fileNames(i))
         stSharePath = GetNetworkPath(pathTrackName)
         If InStr(1, fileNames(i), "%") > 0 Then
            stringNewTrack = fso.BuildPath(stringPath, Replace(fileNames(i), "%", "_"))
            Name pathTrackName As stringNewTrack
            pathTrackName = stringNewTrack
         End If
         stringTitle = fso.GetBaseName(fileNames(i))
         stPlayList = stringAlbum & "%%%%" & stringTitle & "%%%%" & stringArtist & "%%%%%%%%%%%%3%%%%%%External%%" & pathTrackName & "%%" & stringPathPicture & "%%English%%" & SlyNickName & "%%" & "%%External%%%%%%0%%%%0%%0%%0%%0%%0%%-1%%%%%%%%%%%%%%" & stSharePath
         If ScreenType = "Normal" Or ScreenType = "largeWideScreen" Then stFontSize = "34||34" Else stFontSize = "42||42"
         StPlayer = stringTitle & "||%%" & stringArtist & "||%%" & stringAlbum & "||" & StWaveSpl & "Arial||Arial" & StWaveSpl & stFontSize & StWaveSpl & StWaveSpl & StWaveSpl
         If SplitInPlayList(stPlayList) Then                            ' add to playlist
         End If
   Next
   If IndexSwf = 4 Then
      sendVariable2Flash FrmMain.swf(IndexSwf), "TrackSel", False
      sendVariable2Flash FrmMain.swf(4), "PassTrackInfoLen", int_track_count
      sendVariable2Flash FrmMain.swf(4), "OpenFrame", "true"
   End If
   If b_BrowseByFolder Then
      InitDir = fileListName
   Else
      InitDir = stringPath ' Left(stringPath, Len(strArt) - 1)
   End If
   EditSetting MainSettingXML, 2, "InitDir", stringPath
   Exit Sub
Error:
   WriteEvent "AddMusicToPlayer", Err.Description, Err.Source
End Sub
Public Sub RemovePlayTrackAll()
   On Error GoTo Error
   Erase PlayTrackInfo()
   IndexPlayTrack = 0
   If MusicNoteValue <> "true" Then
       miniCommand "RemoveAll" & "|:|" & ""
   End If
   SendRefreshTrack2Clients
   
   Exit Sub
Error:
   WriteEvent "RemovePlayTrackAll", Err.Description, Err.Source
End Sub
Public Sub AddTrack2PlayerExternal(filePathName As String)
   On Error GoTo Error
   'Add folder...............(external)
   Dim filename As String
   Dim TrackTitle As String
   Dim artistName As String
   Dim albumName As String
   Dim path As String
   Dim stPlayList  As String

      filename = fso.GetFileName(filePathName)
      TrackTitle = fso.GetBaseName(filename)
      path = fso.GetParentFolderName(filePathName)
      pathTrackName = filePathName
      albumName = fso.GetBaseName(path)
      artistName = fso.GetBaseName(fso.GetParentFolderName(path))
      
      StPlayer = TrackTitle & "||%%" & artistName & "||%%" & albumName & "||%~%Arial||Arial%~%42||42%~%%~%%~%"

      stPlayList = albumName & "%%%%" & TrackTitle & "%%%%" & artistName & "%%%%%%%%%%%%3%%%%%%External%%" & pathTrackName & "%%" & path & "\folder.jpg" & "%%English%%" & SlyNickName & "%%%%External"
      If SplitInPlayList(stPlayList) = True Then
          ' 2006-11-29      Seng Adding external playlist
''         If MusicNoteValue <> "true" Then
''                FrmMain.addTrackToPlayer pathTrackName & StWaveSpl & StPlayer & StWaveSpl & "English" & StWaveSpl & "1" & StWaveSpl & path & "\" & filename & StWaveSpl
''         End If
      End If
   Exit Sub
Error:
   WriteEvent "AddTrack2PlayerExternal", Err.Description, Err.Source
End Sub
Public Sub SaveExternalToXML(ByVal filePath As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlCurrent As IXMLDOMElement
   Dim rootPath As String
   Dim filelist() As String
   Dim i As Long
   
   filelist = Split(filePath, vbNullChar)

      Set xmlRoot = XmlDoc.createElement("PlayList")
      For i = 0 To UBound(filelist)
         Set xmlCurrent = XmlDoc.createElement("Track")
         trackToXmlTrack xmlCurrent, filelist(i), filelist(i)
         xmlRoot.appendChild xmlCurrent
      Next
      
      XmlDoc.appendChild xmlRoot
      XmlDoc.Save SlyVariable("<Player>")  ' CWinsock.serverMainPath + "\Player.xml"
      CWinsock.SendCopy WS_COPYTO, 0, "<Player>|<Player>|other&&&AddInternalTrack"
      
   Exit Sub
Error:
   WriteEvent "SaveExternalToXML", Err.Description, Err.Source
End Sub
Public Sub trackToXmlTrack(e_xml As IXMLDOMElement, TrackPath As String, TrackID As String)
   On Error GoTo Error
   Dim parentFolder As String
   Dim TrackTitle As String
   Dim AlbumTitle As String
   Dim artistName As String
   
   
   parentFolder = fso.GetParentFolderName(TrackPath)
   AlbumTitle = fso.GetBaseName(parentFolder)
   TrackTitle = fso.GetBaseName(fso.GetFileName(TrackPath))
   artistName = fso.GetBaseName(fso.GetParentFolderName(parentFolder))
   
   With e_xml
      .setAttribute "UniAlbum", vbNullString
      .setAttribute "UniTrack", vbNullString
      .setAttribute "UniArtist", vbNullString
      .setAttribute "Mood", vbNullString
      .setAttribute "UniMood", vbNullString
      .setAttribute "DanceStyle", vbNullString
      .setAttribute "UniDanceStyle", vbNullString
      .setAttribute "Genre", vbNullString
      .setAttribute "UniGenre", vbNullString
      .setAttribute "TrackYear", vbNullString
      .setAttribute "AlbumID", vbNullString
      .setAttribute "walMartAva", 0
      .setAttribute "ShoppingID", 0
      .setAttribute "NoTrack", 0
      .setAttribute "TrackIndex", 0
      
      .setAttribute "TrackAva", 1
      .setAttribute "Mode", "External"
      .setAttribute "Rating", 3
      .setAttribute "language", "English"
      .setAttribute "LanTrack", "External"
      .setAttribute "Album", AlbumTitle
      .setAttribute "Track", TrackTitle
      .setAttribute "Artist", artistName
      .setAttribute "TrackID", TrackID
      .setAttribute "TrackPath", TrackPath
      .setAttribute "Actor", ""
      .setAttribute "Director", ""
      .setAttribute "singType", -1
      
      .setAttribute "picPath", fso.BuildPath(parentFolder, "folder.jpg")
      .setAttribute "ComName", SlyNickName
      .setAttribute "NetPath", GetNetworkPath(TrackPath)
      .setAttribute "StPlayer", TrackTitle + de_Field + "%%" + AlbumTitle + de_Field + "%%" + artistName + de_Field + StWaveSpl + "Arial||Arial" & StWaveSpl & "34||34" & StWaveSpl & StWaveSpl & StWaveSpl
   End With
   Exit Sub
Error:
   WriteEvent "trackToXmlTrack", Err.Description, Err.Source
End Sub
Public Function loadPlayInfoFromXml(XMLeLe As IXMLDOMElement) As Tracks
   On Error GoTo Error
   Dim lpType As Tracks
   With lpType
      .ALBUM = XMLeLe.getAttribute("Album")
      .UniAlbum = XMLeLe.getAttribute("UniAlbum")
      .TRACK = XMLeLe.getAttribute("Track")
      .UniTrack = XMLeLe.getAttribute("UniTrack")
      .ARTIST = XMLeLe.getAttribute("Artist")
      .UniArtist = XMLeLe.getAttribute("UniArtist")
      .Mood = XMLeLe.getAttribute("Mood")
      .UniMood = XMLeLe.getAttribute("UniMood")
      .DanceStyle = XMLeLe.getAttribute("DanceStyle")
      .UniDanceStyle = XMLeLe.getAttribute("UniDanceStyle")
      .Rating = Null2Value(XMLeLe.getAttribute("Rating"))
      .Genre = XMLeLe.getAttribute("Genre")
      .UniGenre = XMLeLe.getAttribute("UniGenre")
      .Language = XMLeLe.getAttribute("language")
      .Mode = XMLeLe.getAttribute("Mode")
      .TrackID = XMLeLe.getAttribute("TrackID")
      .picPath = XMLeLe.getAttribute("picPath")
      .albumID = XMLeLe.getAttribute("AlbumID")
      
      .LanTrack = XMLeLe.getAttribute("LanTrack")
      .comName = XMLeLe.getAttribute("ComName")
      .Player = XMLeLe.getAttribute("StPlayer")
      .TrackYear = Null2Value(XMLeLe.getAttribute("TrackYear"))
      .TrackAva = Null2Value(XMLeLe.getAttribute("TrackAva"))
      .TrackPath = Null2Str(XMLeLe.getAttribute("TrackPath"))
      .walMartAva = Null2Value(XMLeLe.getAttribute("walMartAva"))
      .ShoppingID = Null2Str(XMLeLe.getAttribute("ShoppingID"))
      .NoTrack = Null2Value(XMLeLe.getAttribute("NoTrack"))
      .Actor = Null2Str(XMLeLe.getAttribute("Actor"))
      .Director = Null2Str(XMLeLe.getAttribute("Director"))
      .BookmarkTitle = Null2Value(XMLeLe.getAttribute("BookmarkTitle"))
      '.BookmarkTime = Null2Value(XMLeLe.getAttribute("BookmarkTime")) 'IIf(Null2Value(XMLeLe.getAttribute("BookmarkTime")) = 0, -1, Null2Value(XMLeLe.getAttribute("BookmarkTime")))
      'Error adding track from client Seng 2006-11-30
      .BookmarkTime = IIf(Null2Value(XMLeLe.getAttribute("BookmarkTime")) = 0, -1, Null2Value(XMLeLe.getAttribute("BookmarkTime")))
      .SingType = Null2Value(XMLeLe.getAttribute("singType"))
      .ZoomLevel = Null2Value(XMLeLe.getAttribute("ZoomLevel"))
      .BlankTop = Null2Value(XMLeLe.getAttribute("BlankTop"))
      .BlankBottom = Null2Value(XMLeLe.getAttribute("BlankBottom"))
      .BookmarkLength = Null2Value(XMLeLe.getAttribute("BookmarkLength"))
      .AudioChannel = Null2Value(XMLeLe.getAttribute("AudioChannel"))
      .BookmarkChapter = Null2Value(XMLeLe.getAttribute("BookmarkChapter"))
      .MainTitle = Null2Value(XMLeLe.getAttribute("MainTitle"))
      .BookmarkType = Null2Value(XMLeLe.getAttribute("IsBookmark"))
      .PlayTrackFrom = Null2Value(XMLeLe.getAttribute("PlayTrackFrom"))
      .TrackIndex = Null2Value(XMLeLe.getAttribute("TrackIndex"))
      .seekOffset = Null2Value(XMLeLe.getAttribute("SeekOffset"))
      .albumAvailable = Null2Value(XMLeLe.getAttribute("AlbumAva"))
      .NetWorkPath = Null2Str(XMLeLe.getAttribute("NetPath"))
      '.SubTitle = CBool(XMLeLe.getAttribute("SubTitle")) 'Null2Value(XMLeLe.getAttribute("SubTitle"))
      Dim t As String
      Dim Y As Variant
      If IsNull(XMLeLe.getAttribute("SubTitle")) Then
         .SubTitle = False
      Else
         .SubTitle = CBool(XMLeLe.getAttribute("SubTitle"))
      End If
      '.SubTitle = IIf(IsNull(y), CBool(Null2Str(y)), False)
   End With
   loadPlayInfoFromXml = lpType
   Exit Function
Error:
   WriteEvent "loadPlayInfoFromXml", Err.Description, Err.Source
End Function
Public Function savePlayInfo2Xml(ByVal playerIndex As Long, tageName As String) As IXMLDOMElement
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlResult As IXMLDOMElement
   Set xmlResult = XmlDoc.createElement(tageName)
   If playerIndex >= 0 And int_track_count > 0 And playerIndex < int_track_count Then
   With PlayTrackInfo(playerIndex)
   
         xmlResult.setAttribute "Album", .ALBUM
         xmlResult.setAttribute "UniAlbum", .UniAlbum
         xmlResult.setAttribute "Track", .TRACK
         xmlResult.setAttribute "UniTrack", .UniTrack
         xmlResult.setAttribute "Artist", .ARTIST
         xmlResult.setAttribute "UniArtist", .UniArtist
         xmlResult.setAttribute "Mood", .Mood
         xmlResult.setAttribute "UniMood", .UniMood
         xmlResult.setAttribute "DanceStyle", .DanceStyle
         xmlResult.setAttribute "UniDanceStyle", .UniDanceStyle
         xmlResult.setAttribute "Rating", .Rating
         xmlResult.setAttribute "Genre", .Genre
         xmlResult.setAttribute "UniGenre", .UniGenre
         xmlResult.setAttribute "language", .Language
         xmlResult.setAttribute "Mode", .Mode
         xmlResult.setAttribute "TrackID", .TrackID
         xmlResult.setAttribute "picPath", .picPath
         xmlResult.setAttribute "AlbumID", .albumID
         
         xmlResult.setAttribute "LanTrack", .LanTrack
         xmlResult.setAttribute "ComName", .comName
         xmlResult.setAttribute "StPlayer", .Player
         xmlResult.setAttribute "TrackYear", .TrackYear
         xmlResult.setAttribute "TrackAva", .TrackAva
         xmlResult.setAttribute "TrackPath", Infos(playerIndex).TrackPath
         xmlResult.setAttribute "walMartAva", .walMartAva
         xmlResult.setAttribute "ShoppingID", .ShoppingID
         xmlResult.setAttribute "NoTrack", .NoTrack
         xmlResult.setAttribute "Actor", .Actor
         xmlResult.setAttribute "Director", .Director
         xmlResult.setAttribute "BookmarkTitle", .BookmarkTitle
         xmlResult.setAttribute "BookmarkTime", .BookmarkTime
         xmlResult.setAttribute "singType", .SingType
         xmlResult.setAttribute "ZoomLevel", .ZoomLevel
         xmlResult.setAttribute "BlankTop", .BlankTop
         xmlResult.setAttribute "BlankBottom", .BlankBottom
         xmlResult.setAttribute "BookmarkLength", .BookmarkLength
         xmlResult.setAttribute "BookmarkChapter", .BookmarkChapter
         xmlResult.setAttribute "AudioChannel", .AudioChannel
         xmlResult.setAttribute "MainTitle", .MainTitle
         xmlResult.setAttribute "IsBookmark", .BookmarkType
         xmlResult.setAttribute "PlayTrackFrom", .PlayTrackFrom
         xmlResult.setAttribute "TrackIndex", playerIndex
         xmlResult.setAttribute "SeekOffset", .seekOffset
         xmlResult.setAttribute "AlbumAva", .albumAvailable
         xmlResult.setAttribute "NetPath", .NetWorkPath
         xmlResult.setAttribute "SubTitle", Null2Str(.SubTitle)
         
   End With
   End If
   Set savePlayInfo2Xml = xmlResult
   Exit Function
Error:
   WriteEvent "savePlayInfo2Xml", Err.Description, Err.Source
End Function
Public Sub SaveServerPlayList(Savepath As String, Optional ByVal startIndex As Integer, Optional ByVal TrackCount As Long = -1, Optional IndexList As String = "")
   On Error GoTo Error
   Dim i As Long
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim XMLeLe As IXMLDOMElement
   Dim receivedCount As Long
   Dim arrayList() As String
   
   Set xmlRoot = XmlDoc.createElement("PlayList")
   If IndexList <> "" Then
      arrayList = Split(IndexList, ";")
      For i = 0 To UBound(arrayList)
         Set XMLeLe = savePlayInfo2Xml(arrayList(i), "Track")
         xmlRoot.appendChild XMLeLe
      Next
   Else
      If TrackCount < 0 Then TrackCount = int_track_count
      For i = startIndex To int_track_count - 1
         If i - startIndex < TrackCount Then
            receivedCount = receivedCount + 1
            Set XMLeLe = savePlayInfo2Xml(i, "Track")
            xmlRoot.appendChild XMLeLe
         Else
            Exit For
         End If
      Next
   End If
   xmlRoot.setAttribute "StartIndex", startIndex
   xmlRoot.setAttribute "TrackCount", receivedCount
   XmlDoc.appendChild xmlRoot
   XmlDoc.Save Savepath
   Exit Sub
Error:
   WriteEvent "SaveServerPlayList", Err.Description, Err.Source
End Sub
Public Sub SendRefreshTrack2Clients(Optional ByVal startIndex As Long = 0)
   On Error GoTo Error
   CWinsock.Send2Client WS_COMMAND, 0, "RefreshPlayer&&&" & int_track_count & "&&&" & int_current_index & "&&&" & startIndex
   Exit Sub
Error:
   WriteEvent "SendRefreshTrack2Clients", Err.Description, Err.Source
End Sub
Public Sub LoadServerPlayList(loadPath As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim XMLeLe As IXMLDOMElement
   Dim readTracks As Tracks
   
   XmlDoc.Load loadPath
   Set xmlRoot = XmlDoc.childNodes(0)
   If Not xmlRoot Is Nothing Then
      For Each XMLeLe In xmlRoot.childNodes
         readTracks = SaveToArray(XMLeLe)
         PlayFileViaXML readTracks, readTracks.TrackIndex
      Next
      If IndexSwf = 4 Then
         sendVariable2Flash FrmMain.swf(4), "PassTrackInfoLen", int_track_count
         sendVariable2Flash FrmMain.swf(4), "OpenFrame", "true"
      End If
   End If
   Exit Sub
Error:
   WriteEvent "LoadServerPlayList", Err.Description, Err.Source
End Sub
Public Sub PlayFileViaXML(readToPlay As Tracks, TrackIndex As Long)
   On Error GoTo Error
   If int_track_count > 0 Then
      With readToPlay
         ReDim Preserve PlayTrackInfo(int_track_count - 1)
         ReDim Preserve Infos(int_track_count - 1)
         If int_track_count > TrackIndex Then
            PlayTrackInfo(TrackIndex) = readToPlay
            StrPathPic = .StrPathPic
            FrmMain.SetPlayerTrackInfo .PlayTrackPlayer, TrackIndex
         End If
      End With
   End If
   Exit Sub
Error:
   WriteEvent "PlayFileViaXML", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   loadPlayInfoFromXml
' Description       :   loadPlayInfoFromXml load data from xml and save to type
' Return Values     :   Tracks[Type]
' Input Parameter   :   xmlelement
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             11-07-2005           New
'*******************************************************************************

Public Function SaveToArray(XMLeLe As IXMLDOMElement) As Tracks
   On Error GoTo Error
   Dim tmpType As Tracks
   Dim modeExternal As Integer
   Dim newPath As String
   Dim fields() As Variant
   Dim stringSingType As String
   Dim showArtists() As String
   Dim tmpField() As Variant
   tmpType = loadPlayInfoFromXml(XMLeLe)
   With tmpType
   
      .StrPathPic = fso.BuildPath(fso.BuildPath(SlyVariable("<" & .Language & "_img>"), .picPath), .ALBUM) & "\folder.jpg"
      If .Mode = "External" Then
         modeExternal = 1
         .TrackAva = 0
         .SingType = -1
         If isFileExist(.TrackID) Then
            .TrackAva = 1
            .NetWorkPath = GetNetworkPath(.TrackID)
            .DownloadFromServer = False
         ElseIf b_local_link Then
            If Not CWinsock.LoggedAs(remoteControl) Then        'No need to check track from network/with REMOTECONTROLMOTE
               If isFileExist(.NetWorkPath) Then
                  .TrackAva = 3
                  .DownloadFromServer = False
               End If
            Else
               .TrackAva = 3
            End If
         End If
      Else     'Internal track
         newPath = GetTrackPath(val(.TrackID), val(.albumID), .Language, .PlayTrackFrom)
                                                         '0              1          2
         fields = GetAlbumFields(.albumID, .Language, "DirectorIDs", "MainTitle", "ActorID")
         
         .Director = GetDirectorName(fields(0), .Language, 2)
         .MainTitle = fields(1)
         .albumAvailable = newPath <> ""
         
         If val(.TrackID) > 0 Then
            'stringSingType = GetTrackField(.TrackID, "SingType", "JumpTime", "Length", .Language)
            tmpField = GetTrackFields(.TrackID, .Language, "SingType", "JumpTime", "Length", "SingerIDs")
            .SingType = val(tmpField(0))
            If (val(SlyVariable("<" & .Language & "_id>")) = 8 Or val(SlyVariable("<" & .Language & "_id>")) = 4) Then
               'karaoke or music
               'fields = GetTrackFields(.TrackID, .Language, "SingerIDs")

               showArtists = Split(GetActorName(tmpField(3), .Language, True), "%%")
               .ARTIST = showArtists(0)
               .UniArtist = showArtists(1)
            Else
               showArtists = Split(GetActorName(fields(2), .Language, True), "%%")
               .ARTIST = showArtists(0)
               .UniArtist = showArtists(1)
            End If
            .BookmarkTime = tmpField(1)
            If .BookmarkTime > 0 Then .BookmarkLength = .BookmarkTime + tmpField(2)
         Else
            .SingType = -1                'no artist
         End If
         'If IsEmpty(fields(6)) Or val(.TrackID) = 0 Then .singType = -1 Else .singType = fields(6)    'EDID:2005-11-10
         If Not isFileExist(newPath) Then
            If b_local_link Then
               If .comName <> SlyNickName Then
                  .TrackAva = 3
               Else
                  .TrackAva = 0
               End If
            Else
                  If .walMartAva = 0 Then .DownloadFromServer = True Else .DownloadFromServer = False
                  If (.TrackAva = 1 Or .TrackAva = 2) And .TrackPath <> "" Then
                     .TrackAva = 3
                  Else
                     .TrackAva = 0
                  End If
                  newPath = ""
            End If
         Else
            .comName = SlyNickName
            .TrackPath = newPath
            .TrackAva = 1
            .NetWorkPath = GetNetworkPath(.TrackPath)
            'if it is downloaded from server then change the color to orange
            If trackAvailable(.Language, .TrackID) = 2 Then .TrackAva = 2
            .DownloadFromServer = False
         End If
         modeExternal = 0
      End If
      .PlayTrackPlayer = Join(Array(.TrackPath, .Player, .Language, modeExternal, .TrackID, .albumID), StWaveSpl)
   End With
   SaveToArray = tmpType
   Exit Function
Error:
   WriteEvent "SaveToArray", Err.Description, Err.Source
End Function
Public Sub LoadPlayTrackFromXml()
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim readTrack As Tracks
   XmlDoc.Load SlyVariable("<Player>")
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlRoot = XmlDoc.firstChild
      For Each xmlElement In XmlDoc.firstChild.childNodes
         readTrack = SaveToArray(xmlElement)

         int_track_count = int_track_count + 1
         PlayFileViaXML readTrack, int_track_count - 1
      Next
      If IndexSwf = 4 Then
         sendVariable2Flash FrmMain.swf(4), "PassTrackInfoLen", int_track_count
         sendVariable2Flash FrmMain.swf(4), "OpenFrame", "true"
      End If
   End If
   Exit Sub
Error:
   WriteEvent "LoadPlayTrackFromXml", Err.Description, Err.Source
End Sub
Public Sub CreatePlayerXML(savedata As String, path As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim eachElement As IXMLDOMElement
   Dim TrackID As String
   Dim TrackLan As String
   Dim TrackPath As String
   Dim walMartAva  As Long
   Dim albumID As String
   Dim iPlayTrack As Integer
   Dim iAvailable As Integer
   Dim sNetWorkPath As String
   Dim sComName As String
   
   XmlDoc.loadXML savedata
   
   
   For Each eachElement In XmlDoc.firstChild.childNodes
      TrackID = eachElement.getAttribute("TrackID")
      TrackLan = eachElement.getAttribute("language")
      albumID = eachElement.getAttribute("AlbumID")
      walMartAva = eachElement.getAttribute("walMartAva")
      sComName = eachElement.getAttribute("ComName")
      If IsNumeric(TrackID) Then
         TrackPath = getMoviePathAndSample(TrackID & "~" & albumID & "~0~" & TrackLan & "~" & walMartAva, SlyNickName, iPlayTrack)
         sNetWorkPath = GetNetworkPath(TrackPath)
      Else
         If sComName = SlyNickName And isFileExist(TrackID) Then
            'from it self and available
            sNetWorkPath = GetNetworkPath(TrackID)
         Else
            sNetWorkPath = eachElement.getAttribute("NetPath")
            TrackPath = ""
         End If
      End If
      If Not isFileExist(TrackPath) Then
         iAvailable = 0
      Else
         iAvailable = 1
      End If
         
      eachElement.setAttribute "TrackAva", iAvailable
      eachElement.setAttribute "TrackPath", TrackPath
      eachElement.setAttribute "PlayTrackFrom", iPlayTrack
      eachElement.setAttribute "NetPath", sNetWorkPath
      
   Next
   XmlDoc.Save path
   Exit Sub
Error:
   WriteEvent "CreatePlayerXML", Err.Description, Err.Source
End Sub
'----------------------------------------------------------------------------------------------------
' Add One Track To One Player
'----------------------------------------------------------------------------------------------------
Public Sub play_tracks(ByVal ind_track As Long)
   On Error GoTo ErrorPlayTrack
   Dim playState As enumPlayTrack
   Dim iKaraokeChannel As Integer
'   Dim iVolumeNormalize As Integer
   Dim blankField() As Variant
    
   If run_loading Then Exit Sub
   
   run_loading = True
   '=========================================================================
   run_FakeSeekMax = 0                               'reset to zero fake time
   run_FakeSeekTime = 0
   run_FakeTime = 0
   run_WaitingMinute = 0
   run_WaitingMode = False
   '=========================================================================
    
   
   If ind_track < 0 Then ind_track = 0
   If ind_track >= int_track_count Then ind_track = int_track_count - 1
   int_current_index = ind_track
   tmpIndex = int_current_index
   boolSeeked = False
   CWinsock.ClientMusicLoaded = 0                        'reset the loaded music count
find_next_track:
   If (int_track_count > 0) Then
      'Debug.Print ">>>>>Playing Track Index = ", int_current_index, "Title = ", IIf(PlayTrackInfo(int_current_index).TRACK = "", PlayTrackInfo(int_current_index).UniTrack, PlayTrackInfo(int_current_index).TRACK)
      ShowDebug ">>>>>Playing Track Index = " & vbTab & int_current_index & vbTab & "Title = " & vbTab & IIf(PlayTrackInfo(int_current_index).TRACK = "", PlayTrackInfo(int_current_index).UniTrack, PlayTrackInfo(int_current_index).TRACK)
      CPlayer.ZoomReset
      If PlayTrackInfo(ind_track).infoNotFilled = False Then           'if there is info in it
         If CWinsock.LoggedAs(remoteControl) Then
            CWinsock.Send2Server WS_COMMAND, "requestFakeTime&&&" & run_FakeTime
            b_loadAlready = True
            str_previous_Track = ""                         'clear previous play track for remote control only(when disconnect it can't play file)
            FrmMain.swfImagePlaying.Visible = False
         Else
            
            If PlayTrackInfo(int_current_index).BookmarkTime = -1 Then PlayTrackInfo(int_current_index).BookmarkLength = 0
            If PlayTrackInfo(ind_track).Mode = "Internal" Or PlayTrackInfo(ind_track).Mode = "0" Then
               blankField = GetAlbumFields(PlayTrackInfo(ind_track).albumID, PlayTrackInfo(ind_track).Language, "BlankTop", "BlankBottom", "AudioKaraoke", "Volume")
               close_player_top = blankField(0)
               close_player_buttom = blankField(1)
               
               PlayTrackInfo(ind_track).AudioChannel = Null2Value(blankField(2))  'GetNonKaraokeChannel(Null2Value(blankField(2)), b_karaoke_voice)
               run_iVolumeLevel = val(IIf(IsNull(blankField(3)), 100, blankField(3)))
               
            Else
               close_player_top = PlayTrackInfo(ind_track).BlankTop
               close_player_buttom = PlayTrackInfo(ind_track).BlankBottom
               PlayTrackInfo(ind_track).AudioChannel = -1
               run_iVolumeLevel = 100                                 'default to 100% for all external music files
            End If
            run_bVolumeMuted = False
            BannerDisplayed = False
            CWinsock.Send2Client WS_COMMAND, 0, "Minicommand&&&Stop|:|true"         'stop all clients
            'FrmMain.sldWmpVolume.Value = run_iVolumeLevel                           'Volume Level
            'VolNormalizeVol = iVolumeNormalize                        'Volume normalization for all dvds
             
            playState = PlayTrackFromIndex(ind_track)
            str_current_Track = Infos(ind_track).TrackPath
            If isSoundFile(str_current_Track) Then
               Dim tmpPicPath As String
               
               tmpPicPath = IIf(PlayTrackInfo(int_current_index).Mode = "External", PlayTrackInfo(int_current_index).picPath, Infos(int_current_index).trackImagePath)
               If isFileExist(tmpPicPath) Then
                  FrmMain.swfImagePlaying.SetVariable "LoadImage", tmpPicPath
               Else
                  FrmMain.swfImagePlaying.SetVariable "LoadImage", App.path & "\Sly\CDIcon.sly"
               End If
               setTextScrollPlaying
            Else
               FrmMain.swfImagePlaying.SetVariable "unLoadImage", "true"
            End If
            If playState = playCanPlay Then
               seekTimeValue = 0
               If LCase(fso.GetExtensionName(str_current_Track)) = "iso" Then
                  SetToISOMode str_current_Track
               End If
               SelectPlayerViaExtension str_current_Track
               popUp True                                                                    'Load popup before playing new songs 2007-04-03
'''               If CPlayer.IsVLCInstalled And AutoPlayEnabled Then
'''                 If CPlayer.PlayWith <> VideoLan Then CPlayer.PlayWith = VideoLan
'''               Else
'''                 If CPlayer.PlayWith <> WindowMedia Then CPlayer.PlayWith = WindowMedia
'''               End If
               ' get zoomlevel from DB if it's internal track
'''               If PlayTrackInfo(ind_track).BookmarkType = 4 And CPlayer.PlayWith = VideoLan Then                              'Clear this out for using with VLC
'''                  PlayTrackInfo(int_current_index).BookmarkLength = 0
'''                  PlayTrackInfo(int_current_index).BookmarkTime = -1
'''               End If
               If Infos(int_current_index).trackExternal = False Then
                  PlayTrackInfo(int_current_index).ZoomLevel = GetTrackField(PlayTrackInfo(int_current_index).TrackID, "ZoomLevel", PlayTrackInfo(int_current_index).Language)
                  If PlayTrackInfo(ind_track).BookmarkType = 4 And CPlayer.PlayWith = VideoLan Then                              'Clear this out for using with VLC
                     PlayTrackInfo(int_current_index).BookmarkLength = 0
                     PlayTrackInfo(int_current_index).BookmarkTime = -1
                  End If
               End If
                '===
                FrmMain.picMovieBackground.Visible = False   'blank screen
                If run_FormVideoLoaded Then frmVideo.picVideo.Visible = True
                '=== changed sith 23-05-06
                  '=================
                   'xxx
                   '====================================================
                   TurnHaaliOnOff PlayTrackInfo(int_current_index).SubTitle           'turn subtitle on or  off
                   TurnWmpTitleOnOff PlayTrackInfo(int_current_index).SubTitle       'turn subtitle on or off //ifo
                   '=====================EDID:2004.05.02 Seng
                   'xxx
                   FrmMain.picMovieBackground.Visible = False
                   FrmMain.tmr.Enabled = False
                   CPlayer.Volume = 0
                   startNew = True
                   CurrentFind = findnone
                   If (str_previous_Track = str_current_Track) And str_current_Track <> "" Then
                      If CPlayer.MediaIsnothing = False Then
                         startNew = False 'not call then change events of CWmp
                         If CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
                            CWinsock.Send2Server WS_COMMAND, "MusicLoaded"
                            run_WaitingMode = True
                            b_play = True
                         Else
                            playIFO
                         End If
                      Else
                          ' add external track
                         CPlayer.url = str_current_Track

                      End If
                   Else
                        CPlayer.url = str_current_Track
                   End If
               b_play = True
                
               get_next_previouse_index
               'get_track_info True
               boolTrackChanged = True
                
               sendToFlash FrmMain.swf(IndexSwf), "Play", CStr(b_play)
               If IndexSwf <> 0 Then sendToFlash FrmMain.swf(0), "Play", CStr(b_play)
               ' run_LoadingLastMusic = False                    ' to make it seek offset as normal if not load last music
               str_previous_Track = str_current_Track
            ElseIf playState = playCannotPlay Then
                  CPlayer.ClearPlayList
                  str_previous_Track = ""
                  seekTimeValue = -1
                  CWinsock.Send2Server WS_COMMAND, "MusicLoaded"
                  CWinsock.Send2Server WS_COMMAND, "requestFakeTime&&&" & run_FakeTime
               get_next_previouse_index
               lastPlayTime = 0
            ElseIf playState = playRequestingStreamPath Then
               miniCommand "Stop|:|true"
               CWinsock.Send2Client WS_COMMAND, 0, "Minicommand&&&Stop|:|true"
            End If
            CWinsock.Send2Client WS_COMMAND, 0, "setFakeTime&&&0&&&0&&&0"
         End If      'remotecontrol
         sendTrackIndex2Player
      End If          'infoNotFilled
'''      If show_hide_player = True And s_display_type = "Visual" Then
'''         If Not FrmMain.MediaPlayer Is Nothing Then FrmMain.MediaPlayer.StartVisualization
'''      End If
      'str_extension = LCase(fso.GetExtensionName(str_current_Track))
    End If
    run_loading = False
    Exit Sub
ErrorPlayTrack:
   run_loading = False
   Writelog "play_tracks", "ERROR", Err.Description, "int_current_index = " & int_current_index & ", int_track_count= " & int_track_count
   'WriteEvent "play_tracks", "TrackIndex = " & int_current_index & ";TrackCount= " & int_track_count & vbTab & Err.Description, Err.Source
End Sub
Public Sub repeat_shuffle()
   On Error GoTo Error
    get_next_previouse_index
    get_track_info False
   Exit Sub
Error:
   WriteEvent "repeat_shuffle", Err.Description, Err.Source
End Sub
Private Sub LoadNextBanner()
   Dim iIndexLoad As Integer
   Dim iFinding As Integer
   Dim iCountLeft As Integer
   Dim i As Integer
   If UBound(Banners) >= 0 Then
      iIndexLoad = BannerIndex + 1
      If iIndexLoad > UBound(Banners) Then
         If BannerShuffle Then
            ReOrderBanner BannerShuffle
            iIndexLoad = 0
         Else
            iIndexLoad = 0
         End If
      End If
   Else
      iIndexLoad = -1
   End If
   BannerIndex = iIndexLoad
   If iIndexLoad >= 0 And iIndexLoad <= UBound(Banners) Then
      BannerCurrent = Banners(BannerList(BannerIndex))
'      swfAdv.Movie = Banners(BannerList(iIndexLoad)).filename
'      BannerDuration = Banners(iIndexLoad).Length
'      BannerStart = Banners(iIndexLoad).Start
   End If
End Sub
Public Sub get_next_previouse_index()
   On Error GoTo Error
    Randomize Timer
    If int_track_count = 1 Then
        If b_loop Then
            int_previous_index = int_current_index
            int_next_index = int_current_index
        Else
            int_previous_index = -1
            int_next_index = -1
        End If
    ElseIf int_track_count > 1 Then
        Dim T_all As Long
        T_all = UBound(Infos)
        If b_shuffle Then
            int_previous_index = CInt(Rnd() * T_all)
            While int_previous_index = int_current_index
                int_previous_index = CInt(Rnd() * T_all)
            Wend
            int_next_index = CInt(Rnd() * T_all)
            While int_next_index = int_current_index
                int_next_index = CInt(Rnd() * T_all)
            Wend
        Else
            If int_current_index = 0 Then
                int_previous_index = T_all
                int_next_index = 1
            ElseIf int_current_index = T_all Then
                If b_loop Then
                    int_previous_index = int_current_index - 1
                    int_next_index = 0
                Else
                    int_previous_index = int_current_index - 1
                    int_next_index = -1
                End If
            ElseIf (int_current_index > 0) And (int_current_index < T_all) Then
                int_previous_index = int_current_index - 1
                int_next_index = int_current_index + 1
            End If
        End If
    End If
   Exit Sub
Error:
   WriteEvent "get_next_previouse_index", Err.Description, Err.Source
End Sub

Public Sub get_track_info(Optional bool_popup As Boolean = True)
   On Error GoTo Error
    Dim ConcateString As String
    If int_track_count > 0 And int_current_index < int_track_count And int_current_index >= 0 Then
    
        If b_displayNewTrack = False And b_play = True Then
            b_addPlayCount = False
            b_popUp = True
        End If
      
        If int_previous_index = -1 Then
            strPrevious = ""
            strImgPrevious = ""
        Else
            strPrevious = get_Next_Track(int_previous_index)
            strImgPrevious = Infos(int_previous_index).trackImagePath
        End If
        
        strCurrent = FrmMain.textScroll(CInt(int_current_index))
        strImgCurrent = Infos(int_current_index).trackImagePath
        
        If int_next_index = -1 Then
            strNext = ""
            strImgNext = "NoNext"
        Else
            strNext = get_Next_Track(int_next_index)
            strImgNext = Infos(int_next_index).trackImagePath
        End If
      
        Dim curInd As Long
        curInd = int_current_index
      
        AlbumIDSlide = Infos(curInd).trackAlbumID
        LanSlide = Infos(curInd).TrackLan
        If LoadSlideshow = True And StoreAlbumIDSlide <> AlbumIDSlide Then
            GetSlideshowPath LanSlide, AlbumIDSlide
            StoreAlbumIDSlide = AlbumIDSlide
        End If
         If int_previous_index >= 0 Then
            If PlayTrackInfo(int_previous_index).infoNotFilled Then
               ConcateString = int_previous_index
            End If
         End If
         If int_next_index >= 0 And int_next_index < int_track_count Then
            If PlayTrackInfo(int_next_index).infoNotFilled Then
               If ConcateString <> "" Then ConcateString = ConcateString & ";" & int_next_index Else ConcateString = int_next_index
            End If
         End If
         If ConcateString <> "" And boolRequestingNexPrev = False Then
            
            CWinsock.Send2Server WS_COMMAND, "RequestNextPrev&&&" & ConcateString
         End If
         
        If str_swfNames = "" Then
            LabelNext = label_next_track(FrmMain.CountryPath, Language, ScreenType)
            sendToFlash FrmMain.swf(IndexSwf), "LabelNext", LabelNext
            sendToFlash FrmMain.swf(IndexSwf), "currentTrack", strCurrent
            sendToFlash FrmMain.swf(IndexSwf), "currentImage", strImgCurrent
            sendToFlash FrmMain.swf(IndexSwf), "nextTrack", strNext
            sendToFlash FrmMain.swf(IndexSwf), "Register", CStr(b_reg)
            
            If IndexSwf <> 0 Then
                sendToFlash FrmMain.swf(0), "LabelNext", LabelNext
                sendToFlash FrmMain.swf(0), "currentTrack", strCurrent
                sendToFlash FrmMain.swf(0), "currentImage", strImgCurrent
                sendToFlash FrmMain.swf(0), "nextTrack", strNext
                sendToFlash FrmMain.swf(0), "Register", CStr(b_reg)
                sendToFlash FrmMain.swf(0), "Mute", CStr(b_mute)
            End If
        
            If IndexSwf = 4 Or IndexSwf <> 0 Then
                sendToFlash FrmMain.swf(0), "hideMiniPlayer", True
            End If
        Else
            If IndexSwf = 4 Then
                sendToFlash FrmMain.swf(4), "hideMiniPlayer", True
            End If
            sendToFlash FrmMain.swf(0), "hideMiniPlayer", True
        End If
          
        If str_swfNames = "Fullscreen" Then
            sendToFlash FrmMain.swf(0), "LabelNext", label_next_track(FrmMain.CountryPath, Language, ScreenType)
            sendToFlash FrmMain.swf(0), "currentTrack", strCurrent
            sendToFlash FrmMain.swf(0), "currentImage", strImgCurrent
            sendToFlash FrmMain.swf(0), "nextTrack", strNext
            sendToFlash FrmMain.swf(0), "hideMiniPlayer", True
        
            If IndexSwf = 4 Then
                sendToFlash FrmMain.swf(4), "LabelNext", label_next_track(FrmMain.CountryPath, Language, ScreenType)
                sendToFlash FrmMain.swf(4), "currentTrack", strCurrent
                sendToFlash FrmMain.swf(4), "currentImage", strImgCurrent
                sendToFlash FrmMain.swf(4), "nextTrack", strNext
                sendToFlash FrmMain.swf(4), "hideMiniPlayer", True
            End If
        
            FrmMain.oneByOneTheme FrmMain.SWF_FMA(1), "textDisplay", strCurrent
            FrmMain.oneByOneTheme FrmMain.SWF_FMA(1), "img_current", strImgCurrent
            If s_display_type = "Image" Then
                FrmMain.oneByOneTheme FrmMain.SWF_FMA(1), "img_Next", strImgNext
                FrmMain.oneByOneTheme FrmMain.SWF_FMA(1), "img_Previous", strImgPrevious
            End If
            If Infos(curInd).TrackLan = "English" Then
                If (PlayTrackInfo(curInd).TrackAva = 0 And PlayTrackInfo(curInd).Mode = "Internal") Then
                    sendToFlash FrmMain.SWF_FMA(1), "sampleSong", True
                Else
                    sendToFlash FrmMain.SWF_FMA(1), "sampleSong", False
                End If
            End If
        End If
        'Update CHET 09\15\05 close info for Micro
       End If
        
'''''    'popUp CWmp, bool_popup
    sendTrackIndex2Player
   Exit Sub
Error:
   WriteEvent "get_track_info", Err.Description, Err.Source
End Sub

Public Sub popUp(Optional boolShow As Boolean = True, Optional Index As Variant)
   On Error GoTo Error
   Dim sss As String
   Dim time_length As String
   Dim IndexMissing As Boolean
   Dim TrackUni As String
   Dim TrackEng As String
   Dim artistUni As String
   Dim artistEng As String
   Dim trackType As String
   Dim imageAlbumPath As String
   Dim iLanType As Integer
   Dim iTrackTypeUnicode As Integer
   Dim iAlbumUnicode As Integer
   Dim iTrackUnicode As Integer
   Dim bAddNew As Boolean
   Dim iCoverArtType As Integer
   Dim sCoverName As String
   Dim sOriginalPicPath As String

   
      IndexMissing = IsMissing(Index)
      Index = IIf(IndexMissing, int_current_index, Index)
      If int_track_count > 0 And Index < int_track_count And Index > -1 Then
      'EDIT:2006-08-23 Seng          'Sometimes  doesn't display trackinfo
       If (b_play And str_current_Track <> "" And Settings.b_ShowPopupInfo) Or (CWinsock.LoggedType = remoteControl And run_PlayState = Playing) Or (run_FormVideoLoaded) Or IndexMissing = False Then
           
         'If int_current_index = -1 Then Exit Sub
         If run_LoadingLastMusic Then Exit Sub                                         'If loading last music don't show popup
         sss = (Index + 1) & " / " & int_track_count
         If Index = int_current_index Then
            If IsNumeric(PlayTrackInfo(Index).TrackID) Then
               time_length = Format(PlayTrackInfo(Index).TrackID, "000000")
            Else
               time_length = "External"
            End If
         Else
            bAddNew = True
            If IsNumeric(PlayTrackInfo(Index).TrackID) Then
               time_length = Format(PlayTrackInfo(Index).TrackID, "000000")
            Else
               time_length = "Add New"
            End If
         End If
         If CWinsock.LoggedAs(remoteControl) Then time_length = left(Second2Time(run_FakeSeekMax), Len(Second2Time(run_FakeSeekMax)) - 3)
         sss = sss & "//\\" & time_length
                   
           
           
           TrackEng = Infos(Index).TrackTitle.Eng
           TrackUni = Infos(Index).TrackTitle.Uni
           artistEng = Infos(Index).trackAlbum.Eng
           artistUni = Infos(Index).trackAlbum.Uni
           
          'changes 2006-06-12 Seng display popup info
          iLanType = val(SlyVariable("<" & PlayTrackInfo(Index).Language & "_id>"))
           If Infos(Index).trackExternal Then
             trackType = CPlayer.getBitrateSong      '   getBitrateSong(objWmp)         'Al way english
             iTrackTypeUnicode = 0
          Else
           If iLanType = 8 Or iLanType = 4 Then
              'for karaoke only
              If Language = "Uni" And PlayTrackInfo(Index).UniArtist <> "" Then
                 trackType = PlayTrackInfo(Index).UniArtist
                 iTrackTypeUnicode = 1
              Else
                 trackType = PlayTrackInfo(Index).ARTIST
                 iTrackTypeUnicode = 0
              End If
           Else
              If Language = "Uni" And Infos(Index).trackArtist.Uni <> "" Then
                 trackType = PlayTrackInfo(Index).UniArtist
                 iTrackTypeUnicode = 1
              Else
                 trackType = Infos(Index).trackArtist.Eng         'Label
                 iTrackTypeUnicode = 0
              End If
           End If
         End If
         If val(Infos(Index).trackAlbumID) > 0 Then
            iCoverArtType = GetAlbumField(val(Infos(Index).trackAlbumID), "CoverType", PlayTrackInfo(Index).Language)
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
         If Infos(Index).trackExternal Then
            sOriginalPicPath = PlayTrackInfo(Index).picPath
         Else
            sOriginalPicPath = SlyVariable("<" & PlayTrackInfo(Index).Language & "_img>") & "\" & PlayTrackInfo(Index).picPath & "\" & PlayTrackInfo(Index).ALBUM & "\" & sCoverName
         End If
         If isFileExist(sOriginalPicPath) Then
            Infos(Index).trackImagePath = sOriginalPicPath
         Else
            Infos(Index).trackImagePath = App.path & "\sly\CDIcon.sly"
            
         End If
         imageAlbumPath = Infos(Index).trackImagePath
           'EDID:2006-07-29=================Seng===========================      'Error display unicode font of non unicode album title
           
           run_DelayRefreshPopup = 0
           If Language = "Uni" Then
               If trackType = "" Then
                  If Infos(Index).trackArtist.Uni = "" Then
                     trackType = Infos(Index).trackArtist.Eng
                     iTrackTypeUnicode = 0
                  Else
                     trackType = Infos(Index).trackArtist.Uni
                     iTrackTypeUnicode = 1
                  End If
               End If
               If TrackUni = "" Then iTrackUnicode = 0 Else iTrackUnicode = 1
               If artistUni = "" Then iAlbumUnicode = 0 Else iAlbumUnicode = 1
           Else
               If trackType = "" Then
                  If Infos(Index).trackArtist.Eng = "" Then
                     trackType = Infos(Index).trackArtist.Uni
                     iTrackTypeUnicode = 1
                  Else
                     trackType = Infos(Index).trackArtist.Eng
                     iTrackTypeUnicode = 0
                  End If
               End If
               If TrackEng = "" Then iTrackUnicode = 1 Else iTrackUnicode = 0
               If artistEng = "" Then iAlbumUnicode = 1 Else iAlbumUnicode = 0
           End If
           
            sss = sss & "//\\" & trackType & "{|}" & iTrackTypeUnicode
            sss = sss & "//\\" & IIf(iTrackUnicode = 1, TrackUni, TrackEng) & "{|}" & iTrackUnicode
            sss = sss & "//\\" & IIf(iAlbumUnicode = 1, artistUni, artistEng) & "{|}" & iAlbumUnicode
            sss = sss & "//\\" & Infos(Index).trackFontName.Uni
            sss = sss & "//\\" & Infos(Index).trackFontName.Eng
           '===============================================================
           sss = sss & "//\\" & imageAlbumPath
           
           str_infoPopup = sss
           
           
           If boolShow = True Then
               If (bool_full_vis = True And time_length <> "00:00:00" And str_swfNames <> "Micro") Or (ShowPlayerOnLoad = "true" Or frmPopup.Visible = True) Then
                  If bAddNew Then run_DelayRefreshPopup = 10
                  If CPlayer.PlayWith = VideoLan And bAddNew = False Then
                     run_iDelayPopup = 6000
                  Else
                     run_iDelayPopup = 3000
                  End If
                  FrmMain.showPopupFullPlayer sss
               End If
           End If
       End If
      End If
'   End If '<> "Micro"
   Exit Sub
Error:
   WriteEvent "popUp", Err.Description, Err.Source
End Sub
Public Sub refreshAllPlayerTrack(ByVal int_NewTrackCount As Long)
   On Error GoTo Error
   Dim i As Long
   'refresh for client/server
   If int_NewTrackCount > 0 Then
      For i = 0 To int_track_count - 1
         'save all tracks zoom level to variables
         If PlayTrackInfo(i).infoNotFilled = False Then
            VideoVariable(PlayTrackInfo(i).TrackID, PlayTrackInfo(i).Language) = PlayTrackInfo(i).ZoomLevel
         End If
      Next
      int_track_count = int_NewTrackCount                         '2006-04-17
'''      ReDim Preserve PlayTrackInfo(int_NewTrackCount - 1)
'''      ReDim Preserve Infos(int_NewTrackCount - 1)                                                           'error filling set track count
      For i = 0 To int_track_count - 1
         PlayTrackInfo(i).infoNotFilled = True
      Next
   Else
      Set objVDResize = New Collection    'clear all tracks zoom level to variables
      Erase Infos
      Erase PlayTrackInfo
   End If
   Exit Sub
Error:
   WriteEvent "refreshAllPlayerTrack", Err.Description, Err.Source
End Sub

Public Sub start_copy_images_for_slideshow()
   On Error GoTo Error
'    Static image_index As Integer
    Dim fd As String    'file destination
    Dim fs As String    'file source
    Dim pf As String    'parent folder
    If UBound(copy_image_slideshow) <> -1 And LoadSlideshow = True Then
        sendToFlash frmSlideShow.SlideShow, "visible", "1"
        sendToFlash frmSlideShow.SlideShow, "alpha", 50
refind:
        fs = copy_image_slideshow(image_index)
        
        If server_nick_name <> "" Then
            fd = GetMyDocuments & "\Sly's Friends Pictures\" & server_nick_name & "\" & Replace(fs, main_slideshow_path, "")
        Else
            fd = GetMyDocuments & "\Sly's Friends Pictures\" & Replace(fs, main_slideshow_path, "")
        End If
        
        If Dir(fd) <> "" Then
            If image_index = UBound(copy_image_slideshow) Then
                sendToFlash frmSlideShow.SlideShow, "visible", "0"
                copying_image_path = ""
                busy_copying_slideshow = False
                Exit Sub
            Else
                image_index = image_index + 1
            End If
            GoTo refind
        End If
        
        pf = fso.GetParentFolderName(fd)
        
        If fso.FolderExists(pf) = False Then CreateDirectory pf
        
        copying_image_path = fd
        CWinsock.Send2Server WS_COMMAND, "copy_this_image&&&" & fs & "&&&" & fd & "&&&" & b_resize
        
        current_copy_image_slideshow_path = fd
        
        If image_index = UBound(copy_image_slideshow) Then
            'ReDim Preserve copy_image_slideshow(-1 To -1)
            image_index = 0
            copying_image_path = ""
            sendToFlash frmSlideShow.SlideShow, "visible", "0"
            busy_copying_slideshow = False
        Else
            image_index = image_index + 1
            busy_copying_slideshow = True
        End If
        sendToFlash frmSlideShow.SlideShow, "progress", CLng(CLng(250 * CLng(image_index)) / UBound(copy_image_slideshow))
    End If
   Exit Sub
Error:
   WriteEvent "start_copy_images_for_slideshow", Err.Description, Err.Source
End Sub

Public Sub redownload_slideshow()
   On Error GoTo Error
    Static st_index As Integer
    Dim int_index As Integer
    Dim fd As String    'file destination
    Dim fs As String    'file source
    Dim pf As String    'parent folder
    If st_index > UBound(arr_redownload) Then
        ReDim Preserve arr_redownload(-1 To -1)
        st_index = 0
    Else
        int_index = CInt(arr_redownload(st_index))
        current_index_redownload = int_index
        fs = copy_image_slideshow(int_index)
            
        If server_nick_name <> "" Then
            fd = GetMyDocuments & "\Sly's Friends Pictures\" & server_nick_name & "\" & Replace(fs, main_slideshow_path, "")
        Else
            fd = GetMyDocuments & "\Sly's Friends Pictures\" & Replace(fs, main_slideshow_path, "")
        End If
        
        pf = fso.GetParentFolderName(fd)
        
        If fso.FolderExists(pf) = False Then CreateDirectory pf
        
        CWinsock.Send2Server WS_COMMAND, "copy_this_image&&&" & fs & "&&&" & fd & "&&&" & b_resize & "&&&" & True
        st_index = st_index + 1
    End If
   Exit Sub
Error:
   WriteEvent "redownload_slideshow", Err.Description, Err.Source
End Sub

Public Function trackIndexFromID(Optional TrackID As String) As Long
   On Error GoTo Error
   Static oldTrackIndex As Long
   Static oldTrackID As String
   Dim startIndex As Long
   Dim i As Long
   
   If TrackID = vbNullString Then
      startIndex = oldTrackIndex + 1
      TrackID = oldTrackID
   Else
      oldTrackID = TrackID
      startIndex = 0
   End If
   trackIndexFromID = -1                  'default for not found

   For i = startIndex To int_track_count - 1
      'If IsNumeric(PlayTrackInfo(i).TrackID) Then
         If PlayTrackInfo(i).TrackID = TrackID Then
            trackIndexFromID = i
            Exit For
         End If
      'End If
   Next
   oldTrackIndex = i
   Exit Function
Error:
   WriteEvent "trackIndexFromID", Err.Description, Err.Source
End Function
Public Function CheckTrackForRequest(Optional ByVal startIndex As Long = -1, Optional ByVal TrackCount As Long = -1) As Boolean
   On Error GoTo Error
   'return true if track is not requested
   Dim i As Long
   
   If TrackCount = -1 Then TrackCount = int_track_count
   If startIndex = -1 Then startIndex = 0
   
   If int_track_count > 0 Then
      For i = startIndex To int_track_count - 1
         If i - startIndex < TrackCount Then
            If PlayTrackInfo(i).infoNotFilled Then
               CheckTrackForRequest = True
               Exit Function
            End If
         Else
            Exit For
         End If
      Next
   End If
   Exit Function
Error:
   WriteEvent "CheckTrackForRequest", Err.Description, Err.Source
End Function
Public Sub SendTrack2Player(ByVal startIndex As Long, ByVal TrackCount As Long)
On Error GoTo ErrorIndex:
      sendVariable2Flash FrmMain.swf(4), "IndexStore", startIndex
      sendVariable2Flash FrmMain.swf(4), "GetNextTrackInfo", StrPlayTrackInfo(startIndex, TrackCount)
      sendVariable2Flash FrmMain.swf(4), "OpenFrame", "true"
ErrorIndex:
End Sub
Public Property Get GetExternalTrackPath(comName As String, ByVal TrackID As String, Optional boolIsAvailable As Boolean) As String
   On Error GoTo Error
   Dim TrackName  As String
   Dim rootMusic As String
   Dim stringRemoteNickName As String
   
   TrackName = ExternalTrackAvailable(comName, TrackID)
   'stringRemoteNickName=GetComputerName
   If TrackName = "" Then
      stringRemoteNickName = CWinsock.getNameServer(comName)
      TrackName = fso.GetFileName(TrackID)
      boolIsAvailable = False
      rootMusic = Get2SubFolders(TrackID)
      If rootMusic <> "" Then rootMusic = Replace(rootMusic, "\", " - ") & "_"
   Else
      boolIsAvailable = True                 'Available from EXTERNAL
      stringRemoteNickName = ""
   End If
   'GetExternalTrackPath = fso.BuildPath(SlyVariable("<ExternalPath>") & comName, rootMusic & TrackName)
   GetExternalTrackPath = fso.BuildPath(SlyVariable("<ExternalPath>") & stringRemoteNickName, rootMusic & TrackName)
   
   Exit Property
Error:
   WriteEvent "Get GetExternalTrackPath", Err.Description, Err.Source
End Property

Public Function SplitInPlayList(St As String, Optional SetPlay As String, Optional ByVal SetComName As String, Optional iPlayFrom As Integer) As Boolean
   On Error Resume Next
   SplitInPlayList = True
   Dim valSpl() As String
   Dim PlayTrackID As String
   Dim boolFileExist As Boolean
   Dim fields() As Variant
   Dim showArtists() As String
   Dim loc_SingerIDs As String
   Dim loc_LanID As Integer
   valSpl = Split(St, "%%")
   Dim i As Integer
   i = int_track_count
   boolFileExist = isFileExist(pathTrackName)
   
   iPlayFrom = IIf(boolFileExist And iPlayFrom = 0, 1, iPlayFrom)       ''Error adding track available from server
   If SetComName = "" Or valSpl(13) = "External" Then SetComName = valSpl(17)
   If (SetComName <> SlyNickName And CWinsock.getIndexServer(SetComName) >= 0) Or ((valSpl(22) <> "0" Or boolFileExist Or MusicNoteValue = "true") And SetComName = SlyNickName) Then
      ReDim Preserve PlayTrackInfo(i)
      With PlayTrackInfo(i)
         .ALBUM = valSpl(0)
          '.SubTitle = valSpl(37)
         .UniAlbum = valSpl(1)
         .TRACK = valSpl(2)
         .UniTrack = valSpl(3)
         .Mood = valSpl(6)
         .UniMood = valSpl(7)
         .DanceStyle = valSpl(8)
         .UniDanceStyle = valSpl(9)
         .Rating = valSpl(10)
         .Genre = valSpl(11)
         .UniGenre = valSpl(12)
         .Mode = valSpl(13)
         .TrackID = valSpl(14)
         .picPath = valSpl(15)
         .Language = valSpl(16)
         .comName = SetComName
         .albumID = valSpl(18)
         .LanTrack = valSpl(19)
         .DownloadFromServer = (.comName <> SlyNickName)
         .TrackYear = valSpl(20)
         .TrackPath = pathTrackName
         .PlayTrackFrom = iPlayFrom
         NameCountryPlay = valSpl(16)
         If valSpl(36) = "" Then
            .NetWorkPath = GetNetworkPath(pathTrackName)
         Else
            .NetWorkPath = valSpl(36)
         End If
         .StrPathPic = fso.BuildPath(SlyVariable("<" & valSpl(16) & "_img>"), valSpl(15) & "\" & valSpl(0) & "\folder.jpg")
         PlayTrackID = .TrackID
         If .Mode = "External" Then
            If boolFileExist And .DownloadFromServer Then .TrackAva = "2" Else .TrackAva = "1"
            .ZoomLevel = val(valSpl(24))
            .BlankTop = val(valSpl(25))
            .BlankBottom = val(valSpl(26))
            .MainTitle = val(valSpl(32))
            
            .walMartAva = "0"
            .ShoppingID = ""
            .SingType = -1                            'make it default to no artist for external track
            .ARTIST = valSpl(4)
            .UniArtist = valSpl(5)
            .seekOffset = val(valSpl(34))
            .NoTrack = 0
            
            ModePlay = 1
         Else
            ModePlay = 0
            fields = GetAlbumFields(.albumID, NameCountryPlay, "DirectorIDs", "ActorID", "MainTitle", "Path")
            
            .Director = GetDirectorName(fields(0), NameCountryPlay, 2)
            showArtists = Split(GetActorName(fields(1), NameCountryPlay, True), "%%")
            .Actor = showArtists(0)
            .MainTitle = fields(2)
            .albumAvailable = fields(3) <> ""
            If Not .albumAvailable And StrComp(.comName, SlyNickName) <> 0 Then
               .albumAvailable = CBrowse.getAlbumAvailable(.Language, .albumID)
            End If
            .NoTrack = NoTrack
            
            fields = GetDatabseFields(NameCountryPlay, "SELECT JumpTime , SingType ,Length, group_concat(TrackArtist.ArtistID,',') As SingerIDs from Track INNER JOIN TrackArtist ON Track.ID=TrackArtist.TrackID WHERE Track.ID=" & .TrackID & " GROUP BY Track.ID")
            'fields = GetTrackFields(.TrackID, NameCountryPlay, "JumpTime", "SingType", "Length", "SingerIDs")
            loc_LanID = get_country_type(NameCountryPlay)
            If loc_LanID = 8 Or loc_LanID = 4 Or loc_LanID = 16 Then
               showArtists = Split(GetActorName(fields(3), NameCountryPlay, True), "%%")
               'karaoke or music
               .ARTIST = showArtists(0)
               .UniArtist = showArtists(1)
            Else
               .ARTIST = showArtists(0)
               .UniArtist = showArtists(1)
            End If
            .TrackJumpTime = fields(0)
            .TrackLength = fields(2)
            If IsEmpty(fields(1)) Or val(.TrackID) = 0 Or (loc_LanID <> 8 And loc_LanID <> 16) Then .SingType = -1 Else .SingType = fields(1)  'EDID:2005-11-10 'disply singer only karaoke
            .TrackAva = valSpl(21)
            .walMartAva = val(valSpl(22))
            .ShoppingID = valSpl(23)
         End If
         .BookmarkType = val(valSpl(27))
         .BookmarkTitle = val(valSpl(28))
         .BookmarkTime = IIf(val(valSpl(29)) = 0 And (LCase(fso.GetExtensionName(.TrackPath)) = "ifo" Or .TrackPath = ""), .TrackJumpTime, val(valSpl(29)))      'changed sith 23-05-06
         If .BookmarkTime >= 0 Then
            .BookmarkLength = .BookmarkTime + IIf(val(valSpl(30)) = 0 And (LCase(fso.GetExtensionName(.TrackPath)) = "ifo" Or .TrackPath = ""), .TrackLength, val(valSpl(30)))                 'changed sith 23-05-06
         End If
         .BookmarkLength = val(valSpl(30))
         .BookmarkChapter = val(valSpl(31))
         .AudioChannel = val(valSpl(33))
         .seekOffset = val(valSpl(34))
         .Player = StPlayer
         '.databaseType = val(FrmMain.Swf(IndexSwf).GetVariable("databaseType"))
         '........Internal.......
      End With
      If SetPlay = "" Then FrmMain.addTrackToPlayer pathTrackName & StWaveSpl & StPlayer & StWaveSpl & NameCountryPlay & StWaveSpl & ModePlay & StWaveSpl & PlayTrackID & StWaveSpl & PlayTrackInfo(i).albumID
      IndexPlayTrack = IndexPlayTrack + 1
      If IndexSwf = 4 Then sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
      On Error GoTo errDesc:
      If int_track_count > 0 Then
         If UBound(Infos) >= int_track_count - 1 Then popUp True, int_track_count - 1
      End If
   Else
      SplitInPlayList = False
   End If
errDesc:
'''   Exit Function
'''Error:
'''   WriteEvent "SplitInPlayList", Err.Description, Err.Source
'''   Resume Next
End Function

Public Property Let SlyNickName(Name As String)
   run_user_name = Name
'''   Call SlyRegedit.SetKeyValue(HKEY_CURRENT_USER, RegPath, "user_name", Name, REG_SZ)
End Property
Public Property Get SlyNickName() As String
   SlyNickName = run_user_name
'''   SlyNickName = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, RegPath, "user_name", REG_SZ)
End Property

Public Sub RemoveEncodeitemQueue(index2Remove As Long)
   On Error GoTo Error
   Dim i As Long
   Dim maxBound  As Long

   maxBound = UBound(EncodingQueue)
   If maxBound >= 0 Then
      For i = index2Remove + 1 To maxBound
         EncodingQueue(i - 1) = EncodingQueue(i)
      Next
      ReDim Preserve EncodingQueue(-1 To maxBound - 1)
   End If
   Exit Sub
Error:
   WriteEvent "RemoveEncodeitemQueue", Err.Description, Err.Source
End Sub
Public Sub AddEncodeItemQueue(serverID As String, serverNick As String, CopyString As String, SourceFile As String, TargetFile As String)
On Error GoTo ErrorSubScript
   Dim item As EncodingQueueType
   Dim maxBound As Long
   
   item.serverID = serverID
   item.CopyString = CopyString
   item.SourceFile = SourceFile
   item.TargetFile = TargetFile
   item.serverNickName = serverNick
   
   maxBound = UBound(EncodingQueue) + 1
ErrorSubScript:
   ReDim Preserve EncodingQueue(-1 To maxBound)
   EncodingQueue(maxBound) = item
   If UBound(EncodingQueue) = 0 Then FrmMain.StartConvert
   
End Sub

Public Sub RemovePlayitemQueue(index2Remove As Long)
   On Error GoTo Error
   Dim i As Long, maxBound As Long
   
   
   maxBound = UBound(ItemDelayPlay)
   If maxBound >= 0 Then
      For i = index2Remove + 1 To maxBound
         ItemDelayPlay(i - 1) = ItemDelayPlay(i)
      Next
      ReDim Preserve ItemDelayPlay(-1 To maxBound - 1)
   End If
   Exit Sub
Error:
   WriteEvent "RemovePlayitemQueue", Err.Description, Err.Source
End Sub
Public Sub AddPlayItemQueue(item As playMusicInfoType)
On Error GoTo ErrorSubScript
   Dim maxBound As Long
   maxBound = UBound(ItemDelayPlay) + 1
ErrorSubScript:
   ReDim Preserve ItemDelayPlay(-1 To maxBound)
   ItemDelayPlay(maxBound) = item
End Sub

Public Function StartPlayTrack(Picturepath As String, InfosPlayer As String, info2Play As String, addString As String, Language As String, Mode As String) As String
On Error GoTo Error
   Dim currentInfo As playMusicInfoType
   currentInfo.InfoPlayer = InfosPlayer
   currentInfo.PicturePathPic = Picturepath
   currentInfo.SaveInPlayList = info2Play
   currentInfo.PlayTrackID = addString
   currentInfo.ModePlay = ModePlay
   currentInfo.NameCountryPlay = NameCountryPlay
   currentInfo.trackNo = val(Split(addString, "~")(2)) '+ val(1)
   AddPlayItemQueue currentInfo
   Exit Function
Error:
   WriteEvent "StartPlayTrack", Err.Description, Err.Source
End Function

Function PlayTrackFromIndex(ByVal index2Play As Long) As enumPlayTrack
   On Error GoTo Error
   Dim toPath As String
   Dim trackFromDatabase As String
   Dim trackIsAvailable As Boolean
   Dim copyFrom As String
   Dim track2Play As String
   Dim trackFromArray As String
   Dim comName As String
   Dim boolExternalAvailable As Boolean
   Dim canPlay As Boolean
   Dim int_IndexServer As Integer
   
   comName = PlayTrackInfo(index2Play).comName
   If Infos(index2Play).trackExternal = False Then               'If it is internal track
      trackFromArray = PlayTrackInfo(index2Play).TrackPath
      trackFromDatabase = GetTrackPath(Infos(index2Play).TrackID, Infos(index2Play).trackAlbumID, Infos(index2Play).TrackLan, PlayTrackInfo(index2Play).PlayTrackFrom)
      If b_local_link And trackFromDatabase = "" Then
         'can't find path from database
         If PlayTrackInfo(index2Play).walMartAva = 0 Then
            If PlayTrackInfo(index2Play).StreamPathRequested = False And val(Infos(index2Play).trackAlbumID) <> 0 Then
               If CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(independentServer) Or CWinsock.LoggedAs(independentMode) Then
                  CWinsock.Send2Server WS_COMMAND, "requestStreamPath&&&" & Infos(index2Play).trackAlbumID & "&&&" & Infos(index2Play).TrackID & "&&&" & Infos(index2Play).TrackLan & "&&&" & setStreamType
                  PlayTrackFromIndex = playRequestingStreamPath
                  trackFromArray = ""
                  Exit Function
               ElseIf CWinsock.LoggedAs(ServerMode) Then
                  If Not PlayTrackInfo(index2Play).albumAvailable And PlayTrackInfo(index2Play).TrackAva = 1 Then
                     '== for chapter available only === play from beginning
                     PlayTrackInfo(index2Play).BookmarkType = 0
                  Else
                     int_IndexServer = CWinsock.getIndexServer(PlayTrackInfo(index2Play).comName)
                     'CWinsock.getIndexServer(PlayTrackInfo(0).comName
                     If int_IndexServer > 0 Then
                        CWinsock.Send2Client WS_COMMAND, int_IndexServer, "requestStreamPath&&&" & Infos(index2Play).trackAlbumID & "&&&" & Infos(index2Play).TrackID & "&&&" & Infos(index2Play).TrackLan & "&&&" & setStreamType
                        PlayTrackFromIndex = playRequestingStreamPath
                        Exit Function
                     End If
                     trackFromArray = ""
                  End If
               End If
            Else
               If PlayTrackInfo(index2Play).StreamPathRequested And PlayTrackInfo(index2Play).StreamPath <> "" Then
                  trackFromArray = PlayTrackInfo(index2Play).StreamPath
               Else
                  trackFromArray = PlayTrackInfo(index2Play).NetWorkPath
               End If
            End If
         End If
      Else
         If PlayTrackInfo(index2Play).walMartAva = 0 Then
            trackFromArray = ""
         End If
      End If
      If isFileExist(trackFromDatabase) Then             'if there is path can play from database
         trackIsAvailable = True
         track2Play = trackFromDatabase
      ElseIf isFileExist(trackFromArray) Then                            'if can play from the playlist
         trackIsAvailable = True
         track2Play = trackFromArray
      ElseIf CInt(PlayTrackInfo(index2Play).walMartAva) <> 0 And trackFromArray <> "" And CInt(PlayTrackInfo(index2Play).TrackAva) = 0 Then  'else if it walmart Sample Song
         'for sample song can play but not available
         trackIsAvailable = False
         canPlay = True
         track2Play = trackFromArray
      End If
   Else                             'Track external
      trackFromDatabase = Infos(index2Play).TrackID
      
      If isFileExist(trackFromDatabase) Then                   'if can play from original path then
         track2Play = trackFromDatabase
         trackIsAvailable = True
      ElseIf comName <> SlyNickName Then         'if from remote machine then
         If b_local_link Then trackFromArray = PlayTrackInfo(index2Play).NetWorkPath Else trackFromArray = ""
         
         If isFileExist(trackFromArray) Then
            PlayTrackInfo(index2Play).TrackAva = 2
            trackIsAvailable = True
            track2Play = trackFromArray
         End If
         If trackIsAvailable = False Then
            trackFromDatabase = GetExternalTrackPath(comName, Infos(index2Play).TrackID, boolExternalAvailable)
            If boolExternalAvailable Then
               If isFileExist(trackFromDatabase) Then
                  PlayTrackInfo(index2Play).TrackAva = 2
                  trackIsAvailable = True
                  track2Play = trackFromDatabase
               End If
            End If
         End If
      End If
   End If
   
   If trackIsAvailable = False Then                   'Here start download from here
      
      If Infos(index2Play).trackExternal = True Then
         track2Play = GetExternalTrackPath(comName, Infos(index2Play).TrackID)
         toPath = track2Play ' fso.GetParentFolderName(track2Play)
         copyFrom = Infos(index2Play).TrackID
      ElseIf Infos(index2Play).trackExternal = False Then
         copyFrom = "<Path " & Infos(index2Play).TrackLan & "," & Infos(index2Play).TrackID & "," & Infos(index2Play).trackAlbumID & ">"
         toPath = fso.GetParentFolderName(PlayTrackInfo(index2Play).StrPathPic)
      End If
      PlayTrackInfo(index2Play).DownloadFromServer = True
      'For DVD Don't try to download file coz it is DVD(Over 2GB)
      'If Not CopyingSong Then CWinsock.AddMusicDownload .TrackLan, .TrackID, toPath, copyFrom, comName, .TrackTitle.Eng
   End If
   
   If trackIsAvailable Or canPlay Then
      Infos(index2Play).TrackPath = track2Play
      PlayTrackFromIndex = playCanPlay
   Else
       'Infos(index2Play).TrackPath = ""
      PlayTrackFromIndex = playCannotPlay
   End If
   '================ for available chapter only ==== sith 11-05-06====
   If CWinsock.LoggedAs(independentMode) Then
      If PlayTrackInfo(int_current_index).PlayTrackFrom = 4 Then
         PlayTrackInfo(index2Play).BookmarkType = 0
      End If
   End If
   Exit Function
   '===================================================================
Error:
   WriteEvent "PlayTrackFromIndex", Err.Description, Err.Source
End Function
Public Property Let int_track_count(newValue As Long)
   On Error GoTo Error
   If newValue > 0 Then
      ReDim Preserve PlayTrackInfo(newValue - 1)
      ReDim Preserve Infos(newValue - 1)
   Else
      Erase PlayTrackInfo
      Erase Infos
   End If
   trackCountRefreshed = True
   Exit Property
Error:
   WriteEvent "Let int_track_count", Err.Description, Err.Source
End Property
Public Property Get int_track_count() As Long
   On Error GoTo ErrorBound
   int_track_count = UBound(PlayTrackInfo) + 1 ' pro_track_count
ErrorBound:
End Property

Public Function PlayFileFromRemoteMachine(infoID As String, path2Play As String, ByVal iPlayTrackFrom As Integer, ByVal lpComName As String)
   On Error GoTo Error
   Dim i As Long
   If ItemDelayPlay(0).PlayTrackID = infoID Then
      'And isFileExist(path2Play) Then 'allows add track unavailable sith 18/11/06
      StrPathPic = ItemDelayPlay(0).PicturePathPic
      NoTrack = ItemDelayPlay(0).trackNo
      pathTrackName = path2Play
      ModePlay = ItemDelayPlay(0).ModePlay
      NameCountryPlay = ItemDelayPlay(0).NameCountryPlay
      StPlayer = ItemDelayPlay(0).InfoPlayer
      SplitInPlayList ItemDelayPlay(0).SaveInPlayList, , lpComName, iPlayTrackFrom
      SendRefreshTrack2Clients
   End If
   RemovePlayitemQueue 0
   'If int_current_index = -1 Then miniCommand "Play|:|true"
   'EDIT:2006-08-24
   If int_current_index = -1 Then handleMinicommand "Play|:|true"                '  Error playing the first song in RemoteControl(Popup info blank)
   Exit Function
Error:
   WriteEvent "PlayFileFromRemoteMachine", Err.Description, Err.Source
End Function
Public Function getPlayState() As Long
   If b_play Then
      getPlayState = 1        'Play
   ElseIf b_pause = True Then
      getPlayState = 2        'Pause
   ElseIf b_pause = False Then
      getPlayState = 3        'Stop
   End If
End Function

Public Sub SavePlayMusicPlayer()
   On Error GoTo Ended
   Dim int_TrackIndex As Long
   Dim int_CurrentTrack As Long
   Dim lastSeekTime As Long
   
   DeleteFile (App.path & "\sly\HibernateMusic.xml")
   lastSeekTime = seekTimeValue
   If int_track_count > 0 Then
      Dim Len1 As Long
      Dim i As Long
      Len1 = UBound(PlayTrackInfo)
      If Len1 >= 100 Then
         FrmMain.Saving.left = (FrmMain.swf(IndexSwf).Width - FrmMain.Saving.Width) / 2
         FrmMain.Saving.top = (FrmMain.swf(IndexSwf).Height - FrmMain.Saving.Height) / 2
         FrmMain.Saving.Movie = App.path & "\sly\SaveTrackFile.sly"
         FrmMain.Saving.Visible = True
      End If
      CreateNewFile App.path & "\sly\", "HibernateMusic", "Track"
      Set xmlTrack = New DOMDocument
      xmlTrack.Load App.path & "\sly\HibernateMusic.xml"
      Set xmlTrackRoot = xmlTrack.firstChild
      int_TrackIndex = 0
      int_CurrentTrack = int_current_index
      For i = 0 To Len1
         If Len1 <> 0 Then sendVariable2Flash FrmMain.Saving, "Percent", CLng((i * 100) / Len1)
         DoEvents
         If PlayTrackInfo(i).infoNotFilled = False Then
            
            Set xmlTrackName = savePlayInfo2Xml(i, "Track")
            xmlTrackRoot.appendChild xmlTrackName
            int_TrackIndex = int_TrackIndex + 1
         Else
            lastSeekTime = 0
            int_CurrentTrack = 0
         End If
      Next
      xmlTrackRoot.setAttribute "currentCountry", currentCountry
      xmlTrackRoot.setAttribute "countryPath", FrmMain.CountryPath
      xmlTrackRoot.setAttribute "Index", int_CurrentTrack
      'xmlTrackRoot.setAttribute "LastTitle", CPlayer.currentChapter
      xmlTrackRoot.setAttribute "LastTitle", 1
     
      xmlTrackRoot.setAttribute "LastJumpTime", lastSeekTime
     
      xmlTrack.Save App.path & "\sly\HibernateMusic.xml"
   End If
   Exit Sub
Ended:
   WriteEvent "SavePlayMusicPlayer", Err.Description, Err.Source
End Sub

Public Sub LoadPlayMusicPlayer(ByVal enable As String)
   'Load last music
   On Error GoTo ErrorLastPlay
   If enable = "true" And FirstLoadPlay = False Then
      FirstLoadPlay = True
      Dim i As Integer
      Dim Index As Integer
      Dim args As String
      Dim n As Long
      Dim loc_Tracks As Tracks
      Dim t As IXMLDOMElement
      Dim t1 As IXMLDOMElement
      Dim doc As DOMDocument
'      Dim lastJump As Integer
      
      Set doc = New DOMDocument
      
      doc.Load App.path & "\sly\HibernateMusic.xml"
      If doc.parseError.errorCode <> 0 Then addToPlaylistFromCommand: Exit Sub
      Set t = doc.childNodes(0)
      n = t.childNodes.Length
      
      '.......Set For Player
      currentCountry = CBrowse.GetLastLanguage 't.getAttribute("currentCountry")
      FrmMain.CountryPath = SlyVariable("<" & currentCountry & "_dat>") 't.getAttribute("countryPath")
      Index = Null2Value(t.getAttribute("Index"))
      'lastJump = Null2Value(t.getAttribute("LastJumpTime"))
      lastPlayTime = Null2Value(t.getAttribute("LastJumpTime"))
      b_displayNewTrack = False
      '.......................
      If n > 0 Then
         For i = 0 To n - 1
            Set t1 = t.childNodes(i)
            loc_Tracks = loadPlayInfoFromXml(t1)
            run_LoadingLastMusic = True
            If (loc_Tracks.Mode = "External") Then
               If (StrComp(loc_Tracks.comName, SlyNickName) = 0) Then
                  pathTrackName = loc_Tracks.TrackID
               Else
                  pathTrackName = GetExternalTrackPath(loc_Tracks.comName, loc_Tracks.TrackID)
                  If Not isFileExist(pathTrackName) Then
                     If b_local_link Then       'if use local linking
                        pathTrackName = GetLocalToNetwork(loc_Tracks.comName, loc_Tracks.TrackID)
                     End If
                  End If
                  
               End If
               StrPathPic = loc_Tracks.picPath
               ModePlay = "1"

            Else
               StrPathPic = SlyVariable("<" & loc_Tracks.Language & "_img>") + "\" + loc_Tracks.picPath + "\" + loc_Tracks.ALBUM + "\folder.jpg"
               args = loc_Tracks.TrackID & "~" & loc_Tracks.albumID & "~" & (loc_Tracks.NoTrack - 1) & "~" & loc_Tracks.Language & "~" & loc_Tracks.walMartAva
               pathTrackName = getMoviePathAndSample(args, , loc_Tracks.PlayTrackFrom)  'finish ' test
               ModePlay = "0"
               '========= for chapter available only == sith-12-05-06==
               'Load last music (internal track with not track path )
               'If (pathTrackName = "") And (fso.FileExists(t.childNodes(0).Attributes.getNamedItem("TrackPath").Text)) Then
               If (pathTrackName = "" And loc_Tracks.Mode <> "Internal") And (fso.FileExists(t.childNodes(0).Attributes.getNamedItem("TrackPath").Text)) Then
                  pathTrackName = t.childNodes(0).Attributes.getNamedItem("TrackPath").Text
               End If
               '=======================================================
            End If
            StPlayer = loc_Tracks.Player
            NameCountryPlay = loc_Tracks.Language
            '..........
            With loc_Tracks
            args = Join(Array(.ALBUM, .UniAlbum, .TRACK, .UniTrack, .ARTIST, .UniArtist, .Mood, .UniMood, .DanceStyle, .UniDanceStyle, .Rating, .Genre, _
                              .UniGenre, .Mode, .TrackID, .picPath, .Language, .comName, .albumID, .LanTrack, .TrackYear, .TrackAva, .walMartAva, .ShoppingID, _
                              .ZoomLevel, .BlankTop, .BlankBottom, .BookmarkType, .BookmarkTitle, .BookmarkTime, .BookmarkLength, .BookmarkChapter, .MainTitle, .AudioChannel, .seekOffset, 0, .NetWorkPath, .SubTitle), "%%")
            End With
            If MusicNoteValue = "true" Then
                 SplitInPlayList args, , , loc_Tracks.PlayTrackFrom
            Else
                 If Len(pathTrackName) <> 200 And Len(pathTrackName) <> 0 Then
                    SplitInPlayList args, , , loc_Tracks.PlayTrackFrom
                 End If
             End If
         Next
         'On Error GoTo ind_0
         If Index >= int_track_count Then       '2005-10-26
            int_current_index = 0
         Else
            int_current_index = Index
         End If
         If int_track_count <= 0 Then
            int_current_index = -1
            run_LoadingLastMusic = False
         End If
'''         If int_track_count > 0 Then
'''            run_LoadingLastMusic = True
'''         Else
'''            int_current_index = -1
'''            run_LoadingLastMusic = False
'''         End If
         'Dim oldMute As Boolean
         'oldMute = b_mute
'''         run_LoadingLastMusic = True
       ' If get_country_type(PlayTrackInfo(int_current_index).Language) <> 8 Then
            miniCommand "Play|:|true"
        ' End If
      End If 'n >0
      addToPlaylistFromCommand
   End If 'first if
   Exit Sub
ErrorLastPlay:
   WriteEvent "LoadPlayMusicPlayer", Err.Description, Err.Source
End Sub
Public Function getTrackAvailableType(TrackLan As String, ID As String, comName As String) As Long
   On Error GoTo Error
   Dim localAvailable  As Long
   Dim boolExternalAvailable As Boolean
   Dim TrackPath As String
   Dim intSample As Long
   
   If IsNumeric(ID) Then                     'The track is internal
      TrackPath = getMoviePathAndSample(ID & "~0~0~" & TrackLan & "~" & 0, comName)
      If isFileExist(TrackPath) Then
         localAvailable = 1
         If trackAvailable(TrackLan, ID) = 2 Then localAvailable = 2
      ElseIf CWinsock.getIndexServer(comName) >= 0 Then
         localAvailable = 3
      End If
   Else                                      'The track is external
      If isFileExist(ID) Then                'if it is in the local machine
         localAvailable = 1
      Else                                   'else check for available from external
         TrackPath = GetExternalTrackPath(comName, ID, boolExternalAvailable)
         If boolExternalAvailable And isFileExist(TrackPath) Then
            localAvailable = 2
         Else
            'else according to the computer name of the track find the server of it
            If CWinsock.getIndexServer(comName) >= 0 Then
               localAvailable = 3               'available from friend computer
            End If
         End If
      End If
   End If
   getTrackAvailableType = localAvailable
   Exit Function
Error:
   WriteEvent "getTrackAvailableType", Err.Description, Err.Source
End Function

Public Sub karaokeVoice()
   On Error Resume Next
   Dim loc_NewIndex As Integer
   Dim loc_AudioCount As Integer
   Dim i As Integer
   
   If int_current_index < int_track_count And int_current_index >= 0 Then
      CPlayer.SwitchAudio (PlayTrackInfo(int_current_index).AudioChannel + 1) Mod loc_AudioCount
      PlayTrackInfo(int_current_index).AudioChannel = loc_NewIndex
      sendInfoControllPlayer " Audio Channel "
   End If
End Sub
'''
'''Public Function audioString() As String
'''   On Error GoTo Error
'''   If int_track_count > 0 And int_current_index >= 0 Then
'''    If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''        Dim arr() As String
'''        Dim init As Integer
'''        Dim str As String
'''        arr = CMediaPlayer.subAudioLanguages
'''        For init = 0 To UBound(arr)
'''            If arr(init) <> "" Then
'''                If str = "" Then
'''                    str = arr(init)
'''                Else
'''                    str = str & "||" & arr(init)
'''                End If
'''            End If
'''        Next init
'''        audioString = str
'''    End If
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "audioString", Err.Description, Err.Source
'''End Function

'''Public Function subTitleString() As String
'''   On Error GoTo Error
'''   If int_track_count > 0 And int_current_index >= 0 Then
'''    If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''        Dim arr() As String
'''        Dim init As Integer
'''        Dim str As String
'''        arr = CMediaPlayer.subTitleText
'''        For init = 0 To UBound(arr)
'''            If arr(init) <> "" Then
'''                If str = "" Then
'''                    str = arr(init)
'''                Else
'''                    str = str & "||" & arr(init)
'''                End If
'''            End If
'''        Next init
'''        subTitleString = str
'''    End If
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "subTitleString", Err.Description, Err.Source
'''End Function
'''Public Function chapterString() As String
'''   On Error GoTo Error
'''   If int_track_count > 0 And int_current_index >= 0 Then
'''    If LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath)) = "ifo" Then
'''        Dim arr() As String
'''        Dim init As Integer
'''        Dim str As String
'''        arr = CMediaPlayer.titleAndChapter
'''        title_index = 0
'''        For init = 0 To UBound(arr)
'''            If LCase(Mid(arr(init), 1, 5)) <> "title" Then
'''                If str = "" Then
'''                    str = arr(init)
'''                Else
'''                    str = str & "||" & arr(init)
'''                End If
'''            Else
'''                title_index = title_index + 1
'''            End If
'''        Next init
'''        chapterString = str
'''    End If
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "chapterString", Err.Description, Err.Source
'''End Function
'*******************************************************************************
' Function Name     :
' Description       :
' Return Values     :   true for not send to server
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' None             01-23-2006           New
'*******************************************************************************

Function miniCommand(Commands As String, Optional FromWinsock As EnumPlayListMode = notConnected) As Boolean
   On Error GoTo Error
   Dim splcommand() As String
   Dim command As String
   Dim args As String
   Dim lVariable As Long
   Dim tmpTrack As Tracks
   Dim tmpPlayInfo As TrackInfos
   Dim newIndex As Long
   Dim moveIndex As Long
   Dim i As Long
   Dim stringVariable As Variant
   splcommand = Split(Commands, "|:|")
   command = splcommand(0)
   args = splcommand(1)
   'Debug.Print "Command = " & command & " ; args = " & args
   Select Case command
      '======================================================================================
        Case "ResetVdeo"
            If int_track_count > 0 Then
               PlayTrackInfo(int_current_index).ZoomLevel = 0
               If PlayTrackInfo(int_current_index).Mode = "Internal" Or PlayTrackInfo(int_current_index).Mode = "0" Then Call SetTrackField(PlayTrackInfo(int_current_index).TrackID, "ZoomLevel", PlayTrackInfo(int_current_index).ZoomLevel, PlayTrackInfo(int_current_index).Language)
               run_iOldZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel
               ZoomToLevel 0
            End If
        Case "changeLanguage"
            changeEngUni
            If FromWinsock = notConnected Then
               sendVariable2Flash FrmMain.swf(IndexSwf), "vb", "changeLanguage|%|" & args
            ElseIf Not CWinsock.LoggedAs(independentMode) And Not CWinsock.LoggedAs(remotePlaylist) Then
               sendVariable2Flash FrmMain.swf(IndexSwf), "vb", "changeLanguage|%|" & args
            End If
            miniCommand = True
        Case "Resume"
            If CPlayer.IsInMenuMode Then           'if in menu mode and not finished
               run_PreviousRootMenu = False
               'xx error sometime cannot resume
               'CWmp.DVD.resume
               CPlayer.Volume = 0
               CPlayer.SelectTitle PlayTrackInfo(int_current_index).MainTitle
               For i = 0 To 10000000
                  If CPlayer.IsInMenuMode = False Then Exit For
                  DoEvents
               Next
               CPlayer.Seeks = val(args)
            End If
        Case "VideoZoomIn"
            If int_track_count > 0 Then
               PlayTrackInfo(int_current_index).ZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel + 1
               scaleWMPVdeo
               If PlayTrackInfo(int_current_index).Mode = "Internal" Or PlayTrackInfo(int_current_index).Mode = "0" Then Call SetTrackField(PlayTrackInfo(int_current_index).TrackID, "ZoomLevel", PlayTrackInfo(int_current_index).ZoomLevel, PlayTrackInfo(int_current_index).Language)
               run_iOldZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel
             End If
        Case "VideoZoomOut"
            If int_track_count > 0 Then
               PlayTrackInfo(int_current_index).ZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel - 1
               scaleWMPVdeo
               If PlayTrackInfo(int_current_index).Mode = "Internal" Or PlayTrackInfo(int_current_index).Mode = "0" Then Call SetTrackField(PlayTrackInfo(int_current_index).TrackID, "ZoomLevel", PlayTrackInfo(int_current_index).ZoomLevel, PlayTrackInfo(int_current_index).Language)
               run_iOldZoomLevel = PlayTrackInfo(int_current_index).ZoomLevel
            End If
        Case "AdsValue"
             FrmMain.FunOptions command, args
             If IndexSwf = 6 Then
                sendVariable2Flash FrmMain.swf(IndexSwf), "ChangeAdsValue", args
             End If
         Case "MoveTrackDown"
            If (CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) And FromWinsock = ServerMode Then
               Exit Function
            End If
            If int_track_count > 1 Then
               
               moveIndex = val(args)
               newIndex = (moveIndex + 1)
               
               If newIndex < 0 Then newIndex = (int_track_count - 1)
               If newIndex >= int_track_count Then newIndex = 0
               tmpTrack = PlayTrackInfo(moveIndex)
               PlayTrackInfo(moveIndex) = PlayTrackInfo(newIndex)
               PlayTrackInfo(newIndex) = tmpTrack
               
               tmpPlayInfo = Infos(moveIndex)
               Infos(moveIndex) = Infos(newIndex)
               Infos(newIndex) = tmpPlayInfo
               
               If int_current_index = moveIndex Then
                  int_current_index = newIndex
               ElseIf int_current_index = newIndex Then
                  int_current_index = moveIndex
               End If
               
               If IndexSwf = 4 Then
                   sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
               End If
               get_next_previouse_index
               SendRefreshTrack2Clients
            End If
         Case "MoveTrackUp"
            If (CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) And FromWinsock = ServerMode Then
               'don't process anything /get the track playindex from server
               Exit Function
            End If
            If int_track_count > 1 Then
               
               moveIndex = val(args)
               newIndex = (moveIndex - 1)
               
               If newIndex < 0 Then newIndex = (int_track_count - 1)
               If newIndex >= int_track_count Then newIndex = 0
               tmpTrack = PlayTrackInfo(moveIndex)
               PlayTrackInfo(moveIndex) = PlayTrackInfo(newIndex)
               PlayTrackInfo(newIndex) = tmpTrack
               
               tmpPlayInfo = Infos(moveIndex)
               Infos(moveIndex) = Infos(newIndex)
               Infos(newIndex) = tmpPlayInfo
               
               
               If int_current_index = moveIndex Then
                  int_current_index = newIndex
               ElseIf int_current_index = newIndex Then
                  int_current_index = moveIndex
               End If
               If IndexSwf = 4 Then
                   sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
               End If
               get_next_previouse_index
               SendRefreshTrack2Clients
            End If
        Case "Registerkey"
            WriteRegCode args
            If About_Status = "First" Then
                If IsRegistered = True Then
                    sendVariable2Flash FrmMain.swf(1), "strKey", "true"
                    sendVariable2Flash FrmMain.swf(1), "openKey", "true"
                Else
                    sendVariable2Flash FrmMain.swf(1), "strKey", "false"
                    sendVariable2Flash FrmMain.swf(1), "openKey", "true"
                End If
            Else
               If IndexSwf <> 0 Then
                  sendVariable2Flash FrmMain.swf(0), "Isregistered", b_reg
                  sendVariable2Flash FrmMain.swf(0), "ShowLogo", b_reg
                  sendVariable2Flash FrmMain.swf(0), "OpenFrame", "true"
               End If
               sendVariable2Flash FrmMain.swf(IndexSwf), "Isregistered", b_reg
               sendVariable2Flash FrmMain.swf(IndexSwf), "ShowLogo", b_reg
               sendVariable2Flash FrmMain.swf(IndexSwf), "OpenFrame", "true"
               
                  
                
               sendVariable2Flash FrmMain.swf(IndexSwf), "Isregistered", b_reg
               sendVariable2Flash FrmMain.swf(IndexSwf), "openCover", "true"
               sendVariable2Flash FrmMain.swf(IndexSwf), "OpenFrame", "true"
            End If
            FrmMain.swfAbout.Visible = False
            
            If WinMode = "Window Mode" Then
                If IsRegistered = True Then
                    FrmMain.Caption = reged
                Else
                    FrmMain.Caption = unReg
                End If
            End If
            
            If b_reg = True Then b_ads = False
            
            FrmMain.FunOptions "AdsValue", LCase(CStr(b_ads))
        Case "ExitAbout"
'''            If IsNotReceivable(FromWinsock) Then
'''               miniCommand = True
'''               Exit Function
'''            End If
            If About_Status = "First" Then
                sendVariable2Flash FrmMain.swf(1), "strCancel", "true"
                sendVariable2Flash FrmMain.swf(1), "openCancel", "true"
            Else
                sendVariable2Flash FrmMain.swf(IndexSwf), "openCover", "true"
                sendVariable2Flash FrmMain.swf(IndexSwf), "OpenFrame", "true"
            End If
            FrmMain.swfAbout.Visible = False
      '======================================================================================
        Case "GotoRootMenu"
            If int_current_index >= 0 And int_track_count > 0 Then
               If PlayTrackInfo(int_current_index).Mode <> "Internal" And PlayTrackInfo(int_current_index).BookmarkType = 0 Then
                  GotoRootMenu
               End If
            End If
        Case "NextChapter"
            If (CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl)) Then
               Exit Function
            End If
            If LCase(fso.GetExtensionName(str_current_Track)) = "ifo" Or LCase(fso.GetExtensionName(str_current_Track)) = "mp4" Then
               nextChapterIFO
               CurrentFind = seekChapter
            End If
        Case "PreviousChapter"
            If (CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl)) Then
               Exit Function
            End If
            If LCase(fso.GetExtensionName(str_current_Track)) = "ifo" Or LCase(fso.GetExtensionName(str_current_Track)) = "mp4" Then
               previousChapterIFO
               CurrentFind = seekChapter
            End If
        Case "selectChapter"
            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Or run_loading Then
               Exit Function
            End If
            keyPressForSelectChapter args
            'miniCommand = True 'do not send back to client
            ' do not send seek client process on its own most equal than seek
            '========
        Case "enabled_subtitle" 'enabled subtitle
            '=======================
            If int_current_index >= 0 And int_track_count > 0 Then
               If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Then Exit Function
               If (CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist)) And FromWinsock = notConnected Then
                  CWinsock.Send2Server WS_COMMAND, "Minicommand&&&enabled_subtitle|:|" & args
                  Exit Function
               ElseIf CWinsock.isServerConnected Then
                  miniCommand = True               'don't make it send again to client
               End If
               '=============================
               PlayTrackInfo(int_current_index).SubTitle = CBool(args)
               If b_play Then
'''                  If CPlayer.PlayWith = VideoLan Then
                     CPlayer.SwitchSubtitle
'''                  ElseIf CPlayer.PlayWith = WindowMedia Then
'''                     If Not boolPress Then setSubTitleWMP
'''                     Dim currentFileExtension As String
'''                     currentFileExtension = LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath))
'''                  End If
'''                  If playMusicWith = Winamp Then
'''                     CMediaPlayer.enableSubtitle = PlayTrackInfo(int_current_index).SubTitle
'''                  ElseIf playMusicWith = WindowMedia Then
'''                     If Not boolPress Then setSubTitleWMP
'''                       Dim currentFileExtension As String
'''                       currentFileExtension = LCase(fso.GetExtensionName(Infos(int_current_index).TrackPath))
'''                  End If
               Else
                  If CWinsock.LoggedAs(remoteControl) Then
                     CWinsock.Send2Server WS_COMMAND, "requestFakeTime&&&" & run_FakeTime
                  ElseIf CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
                     CWinsock.Send2Server WS_COMMAND, "other&&&requestSeek"
                  End If
               End If
               '===================================
            End If
        Case "select_subtitle" 'loop for next subtitle mplayer only
            If int_current_index >= 0 And int_track_count > 0 Then
               miniCommand "enabled_subtitle|:|" & LCase(Not PlayTrackInfo(int_current_index).SubTitle)
               Exit Function
            End If
        Case "BookmarkCurrentTime"
            If b_play Then
                sendToFlash FrmMain.swf(IndexSwf), "SaveBookMark", PlayTrackInfo(int_current_index).MainTitle & de_Field & seekTimeValue & de_Field & CPlayer.currentChapter
            End If
        Case "karaoke_voice"
            'Debug.Print "miniCommand, Command=" & command & " ; args=" & args
            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Then
               Exit Function
            End If
            If int_current_index >= 0 And int_track_count > 0 And int_current_index < int_track_count Then
               If args = "false" Then
                  b_karaoke_voice = False
               Else
                  b_karaoke_voice = True
               End If
               CPlayer.SwitchAudio GetNonKaraokeChannel(PlayTrackInfo(int_current_index).AudioChannel, b_karaoke_voice)
               If bool_full_vis Then
                  sendToFlash FrmMain.swfDVDControl, "KaraokeAudio", CStr(b_karaoke_voice)         'Send karaoke channel to voice
               End If
               If str_swfNames = "Micro" Then
                  sendToFlash FrmMain.SWF_FMA(2), "KaraokeAudio", CStr(b_karaoke_voice)
                  sendToFlash frmOver.swfOver, "KaraokeAudio", CStr(b_karaoke_voice)
               End If
               sendToFlash FrmMain.swfMiniControl, "KaraokeAudio", CStr(b_karaoke_voice)
               EditSetting MainSettingXML, 2, "karaoke_voice", LCase(b_karaoke_voice)
            End If
            'miniCommand = True
        Case "Micro2Normal"
            If Not CWinsock.LoggedAs(cloneDisplay) And FromWinsock = ServerMode Then
               Exit Function
            End If
            If run_bShowingInputCode Then
               'if showing then close
               FrmMain.swfAddTrack.SetVariable "ShowForm", "0"
            End If
            If run_bShowControl Then
               FrmMain.HideControlPupup
            End If
            FrmMain.cmd_max_Click
            If CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl) Then               'only for remote playlist
               miniCommand = True                                    'return true don't make it send to server
            End If
        Case "Minimize"
            If Not CWinsock.LoggedAs(cloneDisplay) And FromWinsock = ServerMode Then
               Exit Function
            End If
            If str_swfNames = "Fullscreen" Or bool_full_vis Then miniCommand "FullScreen|:|false"
            If str_swfNames <> "Micro" Then
                FrmMain.MicroAds b_micro, b_ads, i_scale_by_width, i_scale_by_height
            Else
                FrmMain.SWF_FMA_FSCommand 2, "Maximize", True
            End If
            If CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl) Then                 'only for remote playlist
               miniCommand = True                                    'return true don't make it send to server
            End If
            
        Case "Play"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Then
               Exit Function
            End If
            If int_track_count > 0 And b_play = False Then
                If b_pause = True Then
                  FrmMain.tmr.Enabled = True
                  CPlayer.Play
                  b_play = True                           '2006-04-01 seng
                Else
                    If autoPlayer(int_current_index) Then Exit Function
                    play_tracks int_current_index
               End If
               If b_pause = False Then get_track_info True
               stopFakeTime = False
               b_pause = False
               ShowPlayState2Flash b_play
                '------
            End If
        Case "Pause"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Then
               Exit Function
            End If
            If b_play = True Then
               b_pause = True
               CPlayer.Pause
               FrmMain.tmr.Enabled = False
'''               If playMusicWith = WindowMedia Then
'''                   CWmp.controls.Pause
'''                   FrmMain.tmr.Enabled = False
'''               ElseIf playMusicWith = Winamp Then
'''                   FrmMain.controllWinamp "Pause"
'''               ElseIf playMusicWith = nero Then
'''                   FrmMain.NSPlayer.commandShortCut T_Pause
'''               End If
               '------
               b_play = False
               ShowPlayState2Flash b_play
               sendInfoControllPlayer " Pause "
            ElseIf run_FakeSeekMax > 0 Then
               stopFakeTime = True
            End If
        Case "Stop"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Then
               Exit Function
            End If
            FrmMain.picMovieBackground.Enabled = False
            FrmMain.picMovieBackground.Visible = False
            If run_FormVideoLoaded Then frmVideo.picVideo.Visible = False
            b_pause = False
            stopFakeTime = True
            CPlayer.Pause
            FrmMain.tmr.Enabled = False
'''            If playMusicWith = WindowMedia Then
'''               CWmp.controls.Pause             'Only pause it
'''               FrmMain.tmr.Enabled = False
'''            ElseIf playMusicWith = Winamp Then
'''                FrmMain.controllWinamp "Stop"
'''            ElseIf playMusicWith = nero Then
'''                If Not FrmMain.NSPlayer Is Nothing Then FrmMain.NSPlayer.commandShortCut T_Stop
'''            End If
            seekBarDisplay = Second2Time(0, True) & " / " & Second2Time(0, True)
            seekBarpercent = 0
            sendToFlash FrmMain.swfMiniControl, "seek", seekBarpercent & "|%|" & seekBarDisplay
            sendToFlash FrmMain.swfDVDControl, "seek", seekBarpercent & "|%|" & seekBarDisplay
            '------
            b_play = False
            ShowPlayState2Flash b_play
            sendInfoControllPlayer " Stop "
            If bool_full_vis Then If FrmMain.picPopup.Visible Then FrmMain.picPopup.Visible = False
            txtCurrent = ""
            txtLength = ""
            txtSeek = ""
        Case "Next"
               GotoTrack True
'''            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Or run_loading Then
'''               Exit Function
'''            End If
'''            If int_track_count > 0 Then
'''               sendInfoControllPlayer " Next Track "
'''               If CWinsock.LoggedAs(remoteControl) Then
'''                  CWinsock.Send2Server WS_COMMAND, "other&&&requestTrackIndex"
'''                  Exit Function
'''               End If
'''               If int_next_index = -1 Then int_next_index = 0
'''               If int_next_index <> -1 Then
'''                     run_LoadingLastMusic = False
'''                     FrmMain.tmr_press_select_chapter.Enabled = False
'''                     If Not b_shuffle Then
'''                          tmpIndex = tmpIndex + 1
'''                          If tmpIndex >= int_track_count Then
'''                              tmpIndex = 0
'''                          End If
'''                     Else
'''                          tmpIndex = int_next_index
'''                          get_next_previouse_index
'''                     End If
'''                    index_selecte_chapter = tmpIndex + 1
'''                    FrmMain.tmr_press_select_chapter.Enabled = True
'''                End If
'''            End If
        Case "Previous"
               GotoTrack False
'''            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Or run_loading Then
'''               Exit Function
'''            End If
'''            If int_track_count > 0 Then
'''               sendInfoControllPlayer " Previous Track "
'''               If int_previous_index <> -1 Then
'''                  If CWinsock.LoggedAs(remoteControl) Then
'''                     CWinsock.Send2Server WS_COMMAND, "other&&&requestTrackIndex"
'''                     Exit Function
'''                  End If
'''
'''                  If ((CWinsock.LoggedAs(ServerMode)) Or (CWinsock.LoggedAs(independentMode))) Then
'''                     run_LoadingLastMusic = False
'''                     FrmMain.tmr_press_select_chapter.Enabled = False
'''                     If Not b_shuffle Then
'''                        tmpIndex = tmpIndex - 1
'''                        If tmpIndex < 0 Then
'''                            tmpIndex = int_track_count - 1
'''                        End If
'''                     Else
'''                         tmpIndex = int_previous_index
'''                     End If
'''                     index_selecte_chapter = tmpIndex + 1
'''                     FrmMain.tmr_press_select_chapter.Enabled = True
'''                  End If
'''               End If
'''            End If
        Case "Shuffle"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Then
               Exit Function
            End If
            b_displayNewTrack = True
            
            b_shuffle = (args = "true")
            EditXML MainSettingXML, 2, "Shuffle", IIf(b_shuffle, "Yes", "No")
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 2, IIf(b_shuffle, "Yes", "No"), "~")
            sendInfoControllPlayer " Shuffle " & IIf(b_shuffle, "ON", "OFF") & " "
            
            sendToFlash FrmMain.swf(IndexSwf), "Shuffle", CStr(b_shuffle)
            sendToFlash FrmMain.swf(0), "Shuffle", CStr(b_shuffle)
            CWinsock.Send2Client WS_COMMAND, 0, "server&&&IndexList;0;4&&&function||Shuffled|~|" & Int(b_shuffle)
            
            If str_swfNames = "Micro" Then
               sendVariable2Flash FrmMain.SWF_FMA(2), "shuffleMusic", CStr(b_shuffle)
               sendVariable2Flash frmOver.swfOver, "shuffleMusic", CStr(b_shuffle)
            ElseIf str_swfNames = "Fullscreen" Then
               sendToFlash FrmMain.SWF_FMA(1), "shuffle", CStr(b_shuffle)
            End If
            sendToFlash FrmMain.swfMiniControl, "shuffle", CStr(b_shuffle)
            If LoadSlideshow = True Then sendToFlash frmSlideShow.SlideShow, "Shuffle", CStr(b_shuffle)
            
            If int_track_count > 0 Then
                repeat_shuffle
            End If
            
            b_displayNewTrack = False
            
        Case "Repeat"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Then
               Exit Function
            End If
            b_displayNewTrack = True
            b_loop = (args = "true")
            EditXML MainSettingXML, 2, "Repeat", IIf(b_loop, "Yes", "No")
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 1, IIf(b_loop, "Yes", "No"), "~")
            sendInfoControllPlayer " Repeat " & IIf(b_loop, "ON", "OFF") & " "
            
            sendToFlash FrmMain.swf(IndexSwf), "Repeat", CStr(b_loop)
            CWinsock.Send2Client WS_COMMAND, 0, "server&&&IndexList;0;4&&&function||Repeated|~|" & Int(b_loop)
                
            If str_swfNames = "Micro" Then
               sendVariable2Flash FrmMain.SWF_FMA(2), "loopMusic", CStr(b_loop)
               sendVariable2Flash frmOver.swfOver, "loopMusic", CStr(b_loop)
            ElseIf str_swfNames = "Fullscreen" Then
               sendToFlash FrmMain.SWF_FMA(1), "loop", CStr(b_loop)
            End If
            sendToFlash FrmMain.swfMiniControl, "loop", CStr(b_loop)
            If LoadSlideshow = True Then sendToFlash frmSlideShow.SlideShow, "Loop", CStr(b_loop)
            
            If int_track_count > 0 Then
                If int_current_index = UBound(Infos) Then
                    repeat_shuffle
                End If
            End If
            
            b_displayNewTrack = False
            
        Case "Mute"
            If CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode Or (Not change_vol) Then
               Exit Function
            End If
            If args = "true" Then
                WaveMute = True
                sendInfoControllPlayer " Mute ON "
            Else
                WaveMute = False
                sendInfoControllPlayer " Mute OFF "
            End If
            sendToFlash FrmMain.swf(IndexSwf), "Mute", CStr(b_mute)
            If str_swfNames = "Micro" Then
               sendVariable2Flash FrmMain.SWF_FMA(2), "mute", CStr(b_mute)
               sendVariable2Flash frmOver.swfOver, "mute", CStr(b_mute)
            End If
            If bool_full_vis Then sendToFlash FrmMain.swfDVDControl, "mute", CStr(b_mute)
            If str_swfNames = "Fullscreen" Then sendToFlash FrmMain.SWF_FMA(1), "mute", CStr(b_mute)
            sendToFlash FrmMain.swfMiniControl, "mute", CStr(b_mute)
            If LoadSlideshow = True Then sendToFlash frmSlideShow.SlideShow, "Mute", CStr(b_mute)
        Case "Volume"
            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Or (Not change_vol) Then
               Exit Function
            End If
            'Dim tmpVol As Integer
            lVariable = WaveVolume              'Save old volume for unmute the volume
            WaveVolume = CInt(args)
            If WaveMute = True And lVariable < WaveVolume Then
               WaveMute = False
               sendToFlash FrmMain.swf(IndexSwf), "Mute", CStr(WaveMute)
               If IndexSwf <> 0 Then sendToFlash FrmMain.swf(0), "Mute", CStr(WaveMute)
               If str_swfNames = "Micro" Then
                  sendVariable2Flash FrmMain.SWF_FMA(2), "mute", CStr(WaveMute)
               ElseIf str_swfNames = "Fullscreen" Then
                  sendToFlash FrmMain.SWF_FMA(1), "mute", CStr(WaveMute)
               End If
               If bool_full_vis Then
                  sendToFlash FrmMain.swfDVDControl, "mute", CStr(WaveMute)
               End If
               If frmOver.swfOver.Visible Then sendVariable2Flash frmOver.swfOver, "mute", CStr(WaveMute)
               If FrmMain.swfMiniControl.Visible Then sendToFlash FrmMain.swfMiniControl, "mute", CStr(WaveMute)
               If LoadSlideshow = True Then sendToFlash frmSlideShow.SlideShow, "Mute", CStr(WaveMute)
            End If
            'FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 0, args, "~")
            If str_swfNames = "Micro" Then
               sendVariable2Flash frmOver.swfOver, "volume", CStr(WaveVolume)
               sendVariable2Flash FrmMain.SWF_FMA(2), "volume", CStr(WaveVolume)
            ElseIf str_swfNames = "Fullscreen" Then
               sendToFlash FrmMain.SWF_FMA(1), "volume", CStr(WaveVolume)
            End If
            If bool_full_vis Then
               sendToFlash FrmMain.swfDVDControl, "volume", CStr(WaveVolume)
            End If
            sendToFlash FrmMain.swfMiniControl, "volume", CStr(WaveVolume)
            
            If LoadSlideshow = True Then
               sendToFlash frmSlideShow.SlideShow, "Volume", CStr(WaveVolume)
            Else
               sendInfoControllPlayer " Volume " & WaveVolume & "% "
            End If
        Case "seekup"
            If (CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) Or (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Then
               Exit Function
            End If
            If int_track_count > 0 Then
               If b_play Then
                  lVariable = CPlayer.Seeks + 10
                  If lVariable < PlayTrackInfo(int_current_index).BookmarkLength - 2 Then
                     CPlayer.Seeks = lVariable
                     If CWinsock.LoggedAs(ServerMode) Then
                        CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & lVariable & "&&&" & getPlayState
                     End If
                  End If
               ElseIf run_PlayState = 1 And CWinsock.LoggedAs(remoteControl) Then
                  miniCommand = False
               End If
            End If
            boolSeeked = False
        Case "seekdown"
            If (CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) Or (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Then
               Exit Function
            End If
            If int_track_count > 0 And b_play = True Then
               lVariable = CPlayer.Seeks - 10
               If lVariable >= PlayTrackInfo(int_current_index).BookmarkTime Then
                  CPlayer.Seeks = lVariable

                  If CWinsock.LoggedAs(ServerMode) Then
                     CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & lVariable & "&&&" & getPlayState
                  End If
               End If
               
            End If
            boolSeeked = False
        Case "seek"
            If seekTimeValue > 2 And CurrentFind = findnone Then
                If (CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) Or (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Then
                   Exit Function
                End If
                If int_track_count > 0 And b_play Then
                   FrmMain.controllWinamp "seek", args
                   boolSeeked = False
                End If
            End If
        Case "SelectedPlaylist"
            If (CWinsock.LoggedAs(independentMode) And FromWinsock = ServerMode) Or run_loading Then
               Exit Function
            End If
            If int_track_count > 0 And CLng(args) >= 0 And CLng(args) < int_track_count Then
               run_LoadingLastMusic = False
               int_current_index = val(args)
               If PlayTrackInfo(int_current_index).infoNotFilled = True Then
                  CWinsock.Send2Server WS_COMMAND, "requestTrackInfo&&&" & int_current_index & "&&&" & 0
               Else
                  If autoPlayer(int_current_index) Then Exit Function        'make it change the current playing index                 Exit Sub
                  play_tracks CLng(args)
               End If
            End If
        Case "chageTextScroll"
            b_scroll = args = "true"
            sendToFlash FrmMain.swf(0), "scroll", CStr(b_scroll)
            EditSetting MainSettingXML, 2, "TextScroll", args
            FrmMain.SplitPlayer = ReplaceStrSpl(FrmMain.SplitPlayer, 5, args, "~")
        Case "FullScreen"
            If Not CWinsock.LoggedAs(cloneDisplay) And FromWinsock = ServerMode Then
               Exit Function
            End If
            
            If args = "change" Then
               If str_swfNames = "Fullscreen" Or bool_full_vis Then
                  If isSoundFile(str_current_Track) And CWinsock.LoggedAs(remoteControl) = False Then
                     s_display_type = "Image"
                     FrmMain.loadFlashFullScreen True
                  Else
                     If str_swfNames = "Fullscreen" Then FrmMain.loadFlashFullScreen False
                     FrmMain.scale_visualization_to_fullscreen False
                  End If
               End If
            Else
               'If FrmMain.swfMiniControl.Visible Then FrmMain.UnloadSwfMiniControl
                  If isSoundFile(str_current_Track) And CWinsock.LoggedAs(remoteControl) = False Then
                     s_display_type = "Image"
                     FrmMain.loadFlashFullScreen str_swfNames <> "Fullscreen"
                  Else
                     'FrmMain.loadFlashFullScreen str_swfNames <> "Fullscreen"
                     FrmMain.scale_visualization_to_fullscreen bool_full_vis
                  End If
            End If 'change
            If CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl) Then               'only for remote playlist
               miniCommand = True                                    'return true don't make it send to server
            End If
        Case "Remove"
            If (CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) And FromWinsock = ServerMode Then
               'don't process anything /get the track playindex from server
               Exit Function
            End If
            If args <= int_track_count Then
               removeItem val(args)
               If int_track_count = 0 Then
                   'CWmp.currentPlaylist.Clear
                   FrmMain.tmr.Enabled = False
                   miniCommand "Stop" & "|:|" & True
                   FrmMain.clearInfoTrack
                   int_current_index = -1
               Else
                   If CInt(args) = int_current_index Then
                       If (Int(args) = 0) Then
                         play_tracks Int(args)
                       Else
                           If UBound(Infos) < CInt(args) Then
                               play_tracks CInt(args) - 1
                           Else
                               play_tracks Int(args)
                           End If
                       End If
                   End If
                   If CLng(args) < int_current_index Then int_current_index = int_current_index - 1
               End If
               'If CLng(args) < int_current_index Then int_current_index = int_current_index - 1
               repeat_shuffle
               get_track_info False
               If IndexSwf = 4 Then
                   sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
               End If
               'get_next_previouse_index
               SendRefreshTrack2Clients
               
            End If
        Case "RemoveAll"
            If (CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist)) And FromWinsock = ServerMode Then
               'don't process anything /get the track playindex from server
               Exit Function
            End If
            int_current_index = -1
            int_track_count = 0
            b_play = False
            FrmMain.tmr.Enabled = False
            Erase Infos
            miniCommand "Stop" & "|:|" & True
            FrmMain.clearInfoTrack
            If IndexSwf = 4 Then
               sendToFlash FrmMain.swf(4), "function", "setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index
            End If
            str_previous_Track = ""
            SendRefreshTrack2Clients
        Case "AddMusic"
            
            On Error GoTo Out
            Dim filesName As String
            'if DialogOpen
            If b_BrowseByFolder Then
               filesName = BrowseForFolder(InitDir)
            Else
               'If LCase(args) = "true" Then Set FrmMain.DialogOpen = FrmMain.cdl Else Set FrmMain.DialogOpen = frmSlideShow.cdl
               With cdl
                  .InitDir = InitDir
                  .filename = ""
                  .flags = cdlOFNAllowMultiselect Or cdlOFNExplorer
                  .MaxFileSize = 25500
                  .filter = WinampPlayableFilter ' "All Media File|*.mp3;*.wma;*.vob;*.dat;*.ifo;*tp;*.trp;*.ts;*.wmv;*.asf;*.avi;*.mpg;*.mov;*.mp4|All Files|*.*"
                  If LCase(args) = "true" Then .ShowOpen FrmMain.hwnd Else .ShowOpen frmSlideShow.hwnd
                  filesName = .filename

''                  FrmMain.DialogOpen.InitDir = InitDir
''                  FrmMain.DialogOpen.filename = ""
''                  FrmMain.DialogOpen.flags = cdlOFNAllowMultiselect Or cdlOFNExplorer
''                  FrmMain.DialogOpen.MaxFileSize = 25500
''                  'Make it open show open all media files or all files              2005-10-29
''                  FrmMain.DialogOpen.filter = WinampPlayableFilter ' "All Media File|*.mp3;*.wma;*.vob;*.dat;*.ifo;*tp;*.trp;*.ts;*.wmv;*.asf;*.avi;*.mpg;*.mov;*.mp4|All Files|*.*"
''
''                  FrmMain.DialogOpen.ShowOpen
''                  filesName = FrmMain.DialogOpen.filename
               End With
            End If
               
            If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentMode) Then
               AddMusicToPlayer filesName
               
            Else
               Dim filelist As String
               Dim dirName As String
               Dim nullPosition As Long
               
               filelist = cdl.filename
               nullPosition = InStr(filelist, vbNullChar)
               If nullPosition > 0 Then
                  dirName = left(filelist, nullPosition - 1) + "\"
                  filelist = mID(filelist, nullPosition + 1)
                  filelist = dirName & Join(Split(filelist, vbNullChar), vbNullChar & dirName)
               End If
               SaveExternalToXML filelist
            End If
         
            If b_play = False And autoPlayer(0) Then Exit Function
            
            'Seng 2006-02-16
            'error remove all track and add track external track(mplayer)
            'If b_play = False Then miniCommand "Play|:|true"
            If b_play = False Then miniCommand "SelectedPlaylist" & "|:|0"
            
            SendRefreshTrack2Clients               'after changing the index send playtrack index to client
        Case "PlayerPage"
            Dim tttt As String
            tttt = BrowseForFolder(browse_folder_music, FrmMain.hwnd)
            If tttt <> "" Then
               browse_folder_music = tttt
               EditXML MainSettingXML, 2, "browse_folder", browse_folder_music
               FrmMain.AddFolderForPlayer browse_folder_music
               'CWinsock.Send2Client WS_COMMAND, 0, "server&&&4&&&function||setPlayerTrackAndPlayIndex|~|" & int_track_count & "|~|" & int_current_index & "|~|false"
               SendRefreshTrack2Clients
            End If
            If b_play = False Then miniCommand "Play|:|true"
        Case "mb"
            Debug.Print args
    End Select
    Exit Function
Error:
   WriteEvent "Minicommand in " & UCase(command), Err.Description, Err.Source
Out:
End Function

Public Function ProcessKeyShortCut(boolControl As Boolean, boolAlt As Boolean, keyCode As Long)
   On Error GoTo Error

   Dim loc_Selection As String
    loc_Selection = CallFlashFunction(FrmMain.swf(IndexSwf), "selectionGetfocus")
    If loc_Selection = "" Then loc_Selection = CallFlashFunction(FrmMain.swf(IndexSwf), "Selection.getFocus")
   If Not boolControl And Not boolAlt Then      'there is no combination key is pressed
         'If show_hide_player Or bool_full_vis Then    'only choose the chapter from FullScreen and The page there is minicontrol
          If ((IndexSwf = 4 Or bool_full_vis) And run_bShowingInputCode = False) Or LoadSlideshow Or str_swfNames = "Micro" Or str_swfNames = "Fullscreen" Then 'in player page or full screen only
            If IndexSwf = 4 And LoadSlideshow = False Then
               If FrmMain.swf(4).GetVariable("clickAlbum") = "true" And Not bool_full_vis Then Exit Function
            End If
            If ((loc_Selection = "" Or loc_Selection = "null") And Not b_TextBoxGetFocus) Or LoadSlideshow = True Or str_swfNames = "Micro" Or str_swfNames = "Fullscreen" Then    'if it is not in the input box
               Dim d As String
               Dim ii As Integer
               ii = CInt(InStr(1, get_str, Chr(keyCode)))
               If ii > 0 Then
                  d = mID(get_ind, ii, 1)
                  FrmMain.tmr_press_select_chapter.Enabled = False
                  If index_selecte_chapter = "" Then
                     index_selecte_chapter = d
                  Else
                     index_selecte_chapter = index_selecte_chapter & d
                  End If
                  FrmMain.tmr_press_select_chapter.Enabled = True
               End If
            End If
         End If
      If (FrmMain.swfMiniControl.Visible Or bool_full_vis And str_swfNames <> "Micro") And _
         getWndClass(GetActiveWindow) <> "#32770" Then
         'don't receive key while frmmain is not active(The Dialog box is active)
         If isKeyNotBlocked(CInt(keyCode)) Then
            handleShortCutKey keyCode
         End If
      End If
   End If
   Exit Function
Error:
   WriteEvent "ProcessKeyShortCut", Err.Description, Err.Source
End Function
Private Function isKeyNotBlocked(keyCode As Integer) As Boolean
   'use global variable       NoProcessShortCut
   'if that is is blocked then don't process the shortcut
   isKeyNotBlocked = InStr(1, NoProcessShortCut, Chr(keyCode), vbTextCompare) = 0
End Function

Public Sub getNumberChapter(str_chapter As String)
   On Error GoTo Error
    Dim arr() As String
    Dim chap() As String
    Dim args As String
    arr = Split(str_chapter, "&&&")
    all_chapterIFO = UBound(arr)
    current_chapter = 1
   Exit Sub
Error:
   WriteEvent "getNumberChapter", Err.Description, Err.Source
End Sub

Public Sub nextChapterIFO()
   On Error GoTo Error
   Dim loc_CurrentChapter As Long
   If int_track_count > 0 And int_current_index >= 0 Then
      If PlayTrackInfo(int_current_index).BookmarkType < 2 Then
         loc_CurrentChapter = CPlayer.currentChapter
         If loc_CurrentChapter = -1 And CPlayer.PlayWith = VideoLan Then
            CPlayer.NextChapter
         ElseIf loc_CurrentChapter > 0 Then
            keyPressForSelectChapter CStr(loc_CurrentChapter + 1)
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "nextChapterIFO", Err.Description, Err.Source
End Sub

Public Sub previousChapterIFO()
   On Error GoTo Error
   Dim loc_CurrentChapter As Long
   If int_track_count > 0 And int_current_index >= 0 Then
      If PlayTrackInfo(int_current_index).BookmarkType < 2 Then
         loc_CurrentChapter = CPlayer.currentChapter 'GetCurrentChapter(getCurrentDuration)
         If loc_CurrentChapter = -1 And CPlayer.PlayWith = VideoLan Then
            CPlayer.PreviousChapter
         ElseIf loc_CurrentChapter > 1 Then
            keyPressForSelectChapter CStr(loc_CurrentChapter - 1)
         End If
      End If
   
   End If
   Exit Sub
Error:
   WriteEvent "previousChapterIFO", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   GetTrackSeekStart_End
' Description       :   Obtain the current playing song in of the start seeks(second) and end seekds(second)
' Return Values     :   pSeekStart,pSeekEnd (contain in seconds)
' Input Parameter   :   pSeekStart(reference),pSeekEnd(reference),i_MaxPosition
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             09-24-2005           New
'*******************************************************************************

Public Function GetTrackSeekStart_End(pSeekStart As Long, pSeekEnd As Long, ByVal i_MaxPosition As Long)
   On Error GoTo Error
   Dim loc_iSeekStart As Long
   Dim loc_iSeekEnd As Long
   Dim loc_iSeekLength As Long
   Dim loc_iSeekPosition As Long
   
   If int_current_index < int_track_count And int_track_count > 0 Then
      Select Case PlayTrackInfo(int_current_index).BookmarkType
         Case 0             'normal track not a bookmark
             loc_iSeekEnd = i_MaxPosition
             loc_iSeekStart = PlayTrackInfo(int_current_index).BookmarkTime
         Case 1            'bookmark play till end
            loc_iSeekStart = PlayTrackInfo(int_current_index).BookmarkTime
            loc_iSeekEnd = i_MaxPosition
         Case 2, 4, 5          'bookmark play till next chapter
            loc_iSeekStart = PlayTrackInfo(int_current_index).BookmarkTime
            loc_iSeekEnd = PlayTrackInfo(int_current_index).BookmarkLength
         Case 3            'bookmark play amount of seconds
            loc_iSeekStart = PlayTrackInfo(int_current_index).BookmarkTime
            loc_iSeekEnd = PlayTrackInfo(int_current_index).BookmarkLength
      End Select
      pSeekStart = loc_iSeekStart
      pSeekEnd = loc_iSeekEnd
   End If
   Exit Function
Error:
   WriteEvent "GetTrackSeekStart_End", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   DisableWindowMediaVideo
' Description       :   To disable clicking on the CWmp video area (prevent from goto full screen while double click)
' Return Values     :   None
' Input Parameter   :   Handle of the source parent
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-28-2005           New
'*******************************************************************************

'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx end xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
'*******************************************************************************
' Function Name     :   AddCommand
' Description       :   add a command que to the time prevent from return back to the calling procedure
' Return Values     :   none
' Input Parameter   :   command,first argument,second argument
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-29-2005           New
'*******************************************************************************
'tmrDownload_Timer
Public Sub AddCommand(command As String, args As String, arg2 As String, Optional fromHandleMinicommand As Boolean)
   On Error GoTo Error
   Dim newClass As New clsExecuteCommand
   newClass.ArgumentString = args
   newClass.ArgumentString2 = arg2
   newClass.CommandString = command
   newClass.fromHandleMinicommand = fromHandleMinicommand
   collectionCommand.Add newClass
   Exit Sub
Error:
   WriteEvent "AddCommand", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   SetPriority
' Description       :   SetPriority
' Return Values     :   None
' Input Parameter   :   handle of the process,priority name(Normal,AboveNormal,RealTime,BelowNormal,Low)
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' None             10-29-2005           New
'*******************************************************************************

Public Sub SetPriority(hProcess As Long, sPriorityName As String)
   Dim loc_PriorityValue As Long
   Select Case sPriorityName
   Case "Normal"
      loc_PriorityValue = NORMAL_PRIORITY_CLASS
   Case "AboveNormal"
      loc_PriorityValue = ABOVE_NORMAL_PRIORITY_CLASS
   Case "RealTime"
      loc_PriorityValue = REALTIME_PRIORITY_CLASS
   Case "High"
      loc_PriorityValue = HIGH_PRIORITY_CLASS
   Case "BelowNormal"
      loc_PriorityValue = BELOW_NORMAL_PRIORITY_CLASS
   Case "Low"
      loc_PriorityValue = IDLE_PRIORITY_CLASS
   End Select
   apiSetPriorityClass hProcess, loc_PriorityValue
End Sub
Public Function GetChapterCountFromIFO(filename As String, MainTitle As Integer) As Integer
   On Error GoTo Error
   Dim hHandler As Integer
   Dim tt_srptDWORD As typeDWORD
   Dim numOfTitleWORD As typeWORD
   Dim tt_srpt As Double
   Dim numOfTitle As Long
   Dim tInfo() As titleInfo_t
   Dim maxChapters As Integer, currentChapter As Integer
   Dim loc_MainTitle As Integer
   Dim chapterCount As Long
   Dim i As Long
   If Not isFileExist(filename) Then Exit Function       'don't try to open if the file is not exist
   hHandler = FreeFile
   
   Open filename For Binary Access Read As hHandler
      Get hHandler, &HC4 + 1, tt_srptDWORD
      tt_srpt = MemoryToDWord(tt_srptDWORD)
      Get hHandler, tt_srpt * DVD_SECTOR + 1, numOfTitleWORD
      numOfTitle = MemoryToWord(numOfTitleWORD)
      If numOfTitle > 0 And numOfTitle <= DVD_MAX_TITLES Then
         ReDim tInfo(numOfTitle - 1)
         Get hHandler, tt_srpt * DVD_SECTOR + 8 + 1, tInfo
         For i = 0 To numOfTitle - 1
            currentChapter = MemoryToWord(tInfo(i).numberOfChaptersWORD)
            If (i = MainTitle - 1) Then
               GetChapterCountFromIFO = currentChapter
               Exit For
            End If
         Next
      End If
   Close hHandler
   Exit Function
Error:
   WriteEvent "GetChapterCountFromIFO", Err.Description, Err.Source
End Function
Public Function GetChapterCountArrayIFO(filename As String) As Integer()
   On Error GoTo Error
   Dim hHandler As Integer
   Dim tt_srptDWORD As typeDWORD
   Dim numOfTitleWORD As typeWORD
   Dim tt_srpt As Double
   Dim numOfTitle As Long
   Dim tInfo() As titleInfo_t
   Dim chapterInfo() As Integer
   Dim maxChapters As Integer, currentChapter As Integer
   Dim loc_MainTitle As Integer
   
   Dim chapterCount As Long
   Dim i As Long
   If Not isFileExist(filename) Then Exit Function       'don't try to open if the file is not exist
   hHandler = FreeFile
   
   Open filename For Binary Access Read As hHandler
      Get hHandler, &HC4 + 1, tt_srptDWORD
      tt_srpt = MemoryToDWord(tt_srptDWORD)
      Get hHandler, tt_srpt * DVD_SECTOR + 1, numOfTitleWORD
      numOfTitle = MemoryToWord(numOfTitleWORD)
      If numOfTitle > 0 And numOfTitle <= DVD_MAX_TITLES Then
         ReDim tInfo(numOfTitle - 1)
         ReDim chapterInfo(-1 To numOfTitle - 1)
         Get hHandler, tt_srpt * DVD_SECTOR + 8 + 1, tInfo
         For i = 0 To numOfTitle - 1
            currentChapter = MemoryToWord(tInfo(i).numberOfChaptersWORD)
            chapterInfo(i) = currentChapter
         Next
      End If
   Close hHandler
   GetChapterCountArrayIFO = chapterInfo
   Exit Function
Error:
   WriteEvent "GetChapterCountArrayIFO", Err.Description, Err.Source
End Function

Public Function getMainTitle() As Integer
On Error GoTo errorDesc:
   If LCase(fso.GetExtensionName(str_current_Track)) = "ifo" Then
      getMainTitle = getIfoMainTitle(str_current_Track)
   End If
Exit Function
errorDesc:
'''   MsgBox Err.Description
   getMainTitle = 0
End Function
'''Public Function hWmp() As Long
'''   On Error GoTo Error
'''   Dim lhwnd As Long, hSource As Long
'''   hSource = FrmMain.wmp.Container.hwnd
'''   lhwnd = FindWindowEx(hSource, 0, "WMPVideoWindow", vbNullString)
'''   If lhwnd = 0 Then lhwnd = FindWindowEx(hSource, 0, "VideoRenderer", vbNullString)
'''   hWmp = lhwnd
'''   Exit Function
'''Error:
'''   WriteEvent "hWMP", Err.Description, Err.Source
'''End Function
'==========================================================================================================================
'''Public Function Player_GetCurrentChapter() As Long
'''   On Error GoTo Error
'''   If playMusicWith = Winamp Then
'''      Player_GetCurrentChapter = CMediaPlayer.CurrentChapter
'''   ElseIf playMusicWith = nero Then
'''      Player_GetCurrentChapter = FrmMain.NSPlayer.CurrentChapter
'''   ElseIf playMusicWith = WindowMedia Then
'''      Player_GetCurrentChapter = val(CWmp.currentMedia.getItemInfo("chapterNum"))
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "Player_GetCurrentChapter", Err.Description, Err.Source
'''End Function
'==========================================================================================================================
Public Property Get isShowTimeInstalled() As Boolean
   On Error GoTo Error
   Dim loc_tmpPath As String
   loc_tmpPath = GetKeyValue(HKEY_CLASSES_ROOT, "Applications\showtime.exe\shell\play\command", "", REG_SZ)
   If loc_tmpPath <> "" Then
      loc_tmpPath = mID(loc_tmpPath, 2, InStr(2, loc_tmpPath, """") - 2)
   Else
      loc_tmpPath = ""
   End If

   isShowTimeInstalled = isFileExist(loc_tmpPath)
   
   Exit Property
Error:
   WriteEvent "Get isShowTimeInstalled", Err.Description, Err.Source
End Property

Public Function autoPlayer(ByVal Index As Long) As Boolean
   On Error GoTo Error
'   On Error Resume Next
   If AutoPlayEnabled Then
      'if CPlayer.PlayWith
'''       Index = IIf(Index > -1, Index, 0)
'''       int_current_index = Index
'''      If LCase(fso.GetExtensionName(PlayTrackInfo(Index).TrackPath)) = "mp4" Then
'''         If CPlayer.PlayWith <> VideoLan Then
'''            AddCommand "FunOptions", "playMusicWith", "Winamp"
'''            autoPlayer = True
'''            Exit Function
'''         End If
'''
'''      ElseIf LCase(fso.GetExtensionName(PlayTrackInfo(Index).TrackPath)) = "ifo" Then
'''         If playMusicWith <> WindowMedia Then
'''            AddCommand "FunOptions", "playMusicWith", "WindowMedia"
'''            autoPlayer = True
'''            Exit Function
'''         End If
'''      End If
   End If
   autoPlayer = False
   Exit Function
Error:
   WriteEvent "autoPlayer", Err.Description, Err.Source
End Function

'===============================================================================================
Public Function TerminateProcessName(Name As String) As Boolean
   On Error GoTo Error
   Dim ProcessesID(1 To 200) As Long         '200 element
   Dim cbNeed As Long
   Dim hResult As Long
   Dim processCount As Long
   Dim i As Long
   Dim moduleName As String
   
   On Error GoTo errorOccur:
   hResult = EnumProcesses(ProcessesID(1), LONG_SIZE * UBound(ProcessesID), cbNeed)
   If hResult <> 0 Then
      processCount = cbNeed / LONG_SIZE
      For i = 1 To processCount
         moduleName = EnumModule(ProcessesID(i))
         If moduleName <> vbNullString Then
            If StrComp(fso.GetFileName(moduleName), Name, vbTextCompare) = 0 Then
                Terminate ProcessesID(i)
                TerminateProcessName = True
                'TerminateProcessName=
               'if it is mplayerc.exe then terminate it now
            End If
            'RaiseEvent ProcessFound(moduleName, ProcessesID(i))
         End If
      Next
   End If
errorOccur:
   Exit Function
Error:
   WriteEvent "TerminateProcessName", Err.Description, Err.Source
End Function

Private Function EnumModule(IDProcess As Long) As String
   On Error GoTo Error
   Dim cbNeed As Long
   Dim hResult As Long
   Dim ProcessModulesID(1 To 100) As Long
   Dim hProcess As Long
   Dim buffName As String
   Dim nReturnSize As Long
   
   hProcess = OpenProcess(PROCESS_QUERY_INFORMATION Or PROCESS_VM_READ, 0, IDProcess)
   If hProcess <> 0 Then
      hResult = EnumProcessModules(hProcess, ProcessModulesID(1), LONG_SIZE * UBound(ProcessModulesID), cbNeed)
      If hResult <> 0 Then
         buffName = String(MAX_PATH, vbNullChar)
         nReturnSize = GetModuleFileNameEx(hProcess, ProcessModulesID(1), buffName, MAX_PATH)
         EnumModule = left(buffName, nReturnSize)
      End If
   End If
   CloseHandle hProcess
   Exit Function
Error:
   WriteEvent "EnumModule", Err.Description, Err.Source
End Function

Private Function Terminate(IDProcess As Long) As Boolean
   On Error GoTo Error
   Dim hProcess As Long
   hProcess = OpenProcess(PROCESS_TERMINATE, 0, IDProcess)
   If hProcess <> 0 Then
      TerminateProcess hProcess, 0
      Terminate = True
   End If
   CloseHandle hProcess
   Exit Function
Error:
   WriteEvent "Terminate", Err.Description, Err.Source
End Function

'===============================================================================================
'*******************************************************************************
' Function Name     :   DisplaySeekBarInfo
' Description       :   Display all seek percent
' Return Values     :   None
' Input Parameter   :   Display text
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             01-09-2006           New
'*******************************************************************************

Public Sub DisplaySeekBarInfo(infoText As String)
   On Error GoTo Error
   
   
   If FrmMain.swfMiniControl.Visible Then         'the minicontrol is visible
      sendToFlash FrmMain.swfMiniControl, "seek", infoText
   End If
   If LoadSlideshow = True Then
      sendToFlash frmSlideShow.SlideShow, "seek", infoText
   Else
      If str_swfNames = "Micro" Then
         sendToFlash frmOver.swfOver, "seek", infoText
         sendToFlash FrmMain.SWF_FMA(2), "seek", infoText
      ElseIf str_swfNames = "Fullscreen" Then
         sendToFlash FrmMain.SWF_FMA(1), "seek", infoText
      End If
      If FrmMain.swfDVDControl.Visible Then
         sendToFlash FrmMain.swfDVDControl, "seek", infoText
      End If
   End If
   Exit Sub
Error:
   WriteEvent "DisplaySeekBarInfo", Err.Description, Err.Source
End Sub
Public Function handleMinicommand(Commands As String)
   On Error GoTo Error
   Dim aCommand() As String
   
   If CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(remoteControl) Then
      If miniCommand(Commands) = False Then CWinsock.Send2Server WS_COMMAND, "Minicommand&&&" & Commands
   ElseIf CWinsock.LoggedAs(cloneDisplay) Then
      aCommand = Split(LCase(Commands), "|:|")
      'make it change subtitle too when in clonedisplay
      If ((aCommand(0) = "volume" Or aCommand(0) = "mute") And change_vol = False) Then
         miniCommand Commands
      Else
         CWinsock.Send2Server WS_COMMAND, "Minicommand&&&" & Commands
      End If
   ElseIf CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(ServerMode) Then
      aCommand = Split(LCase(Commands), "|:|")
      If aCommand(0) = "next" Or aCommand(0) = "previous" Or aCommand(0) = "select_subtitle" Or aCommand(0) = "nextchapter" Or aCommand(0) = "previouschapter" Or aCommand(0) = "karaoke_voice" Then
         AddCommand "miniCommand", Commands, "", True           'don't make it goto next file 2 times
      Else
         miniCommand Commands
         If CWinsock.LoggedAs(ServerMode) Or CWinsock.LoggedAs(independentServer) Then CWinsock.Send2Client WS_COMMAND, 0, "Minicommand" & de_Record & Commands
      End If
   End If
   Exit Function
Error:
   WriteEvent "handleMinicommand", Err.Description, Err.Source
End Function

Public Function handleShortCutKey(key As Long)
   On Error GoTo Error
   If CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(ServerMode) Then
      FrmMain.PressKeyInternalPlayer (key)
      CWinsock.Send2Client WS_COMMAND, 0, "keyPressed" & de_Record & key
   Else
      CWinsock.Send2Server WS_COMMAND, "keyPressed" & de_Record & key
   End If

   Exit Function
Error:
   WriteEvent "handleShortCutKey", Err.Description, Err.Source
End Function
Public Function IsNotReceivable(FromWinsock As Boolean) As Boolean
   On Error GoTo Error
   If ((CWinsock.LoggedAs(remotePlaylist) Or CWinsock.LoggedAs(cloneDisplay)) And FromWinsock) Or FromWinsock = False Or CWinsock.LoggedAs(ServerMode) Or (FromWinsock = False And CWinsock.LoggedAs(independentMode)) Then
      IsNotReceivable = False
   Else
      IsNotReceivable = True
   End If
   Exit Function
Error:
   WriteEvent "IsNotReceivable", Err.Description, Err.Source
End Function

Public Function SearchAvailableType(ByVal lng_AlbumID As Long, str_countryName As String) As Integer
   On Error GoTo Error
   Dim cLanguage As cLanguage
   Set cLanguage = GetCountryClass(str_countryName)
   SearchAvailableType = cLanguage.SearchAvailableType(lng_AlbumID)
   Exit Function
Error:
   WriteEvent "SearchAvailableType", Err.Description, Err.Source
End Function
Public Sub keyPressForSelectChapter(ind As String)
   On Error GoTo Error
   Dim loc_allChapterTime As String
   Dim loc_currentExt As String
   Dim loc_chapterTime As Long
   Dim loc_MaxDuration As Long
   Dim i As Long

   If int_track_count > 0 Then
      loc_currentExt = CPlayer.UrlExtension  ' LCase(str_extension)
      If PlayTrackInfo(int_current_index).Mode = "Internal" Then  'Internal only
         loc_allChapterTime = GetChapterFromMovie(PlayTrackInfo(int_current_index).albumID, PlayTrackInfo(int_current_index).Language, CPlayer.chapterCount)
      Else
         loc_allChapterTime = ""
      End If
      If loc_currentExt = "ifo" Then
         If b_pause Then miniCommand "Play|:|true"
         If (val(PlayTrackInfo(int_current_index).NoTrack) <= val(ind) And PlayTrackInfo(int_current_index).BookmarkType = 0) Or (PlayTrackInfo(int_current_index).BookmarkType = 1) Then
            If PlayTrackInfo(int_current_index).BookmarkChapter > val(ind) Then Exit Sub
               If val(ind) <= CPlayer.chapterCount And val(ind) > 0 Then
                  FrmMain.tmr.Enabled = False 'do not visible picmoviebackground back
                  FrmMain.picMovieBackground.Visible = False
                  '===
                  CPlayer.SelectChapter val(ind) - 1
                  'wait untile status changed
                  If CPlayer.playState = wmppsWaiting Then
                     For i = 0 To 10000
                        DoEvents
                        If CPlayer.playState <> wmppsWaiting Then Exit For
                     Next
                 End If
                 CurrentFind = seekChapter
               End If
'            End If 'end playmusicwith = winamp
         Else
              GoTo SelectChapter
         End If 'end bookmarkType <2
      Else 'If loc_currentExt = "mp4" Then
         If PlayTrackInfo(int_current_index).BookmarkChapter < 2 Then
            loc_chapterTime = GetChapterTime(loc_allChapterTime, ind)
            loc_MaxDuration = CPlayer.Duration
            
            If loc_chapterTime >= 0 And loc_chapterTime < loc_MaxDuration Then
               CPlayer.Seeks = loc_chapterTime
               CurrentFind = seekChapter
            Else
               GoTo SelectChapter
            End If
'''            End If
         ElseIf PlayTrackInfo(int_current_index).BookmarkType > 1 Then
            GoTo SelectChapter
         End If
      End If 'end ifo
     're-timer
      Sleep 1000
      timeVisible = 0
      FrmMain.tmr.Enabled = True
   End If 'end  int_track_count >0
   Exit Sub
SelectChapter:
   If val(ind) <= int_track_count And ind <> "" Then
      handleMinicommand "SelectedPlaylist" & "|:|" & val(ind - 1)
   End If
   Exit Sub
Error:
   WriteEvent "keyPressForSelectChapter", Err.Description, Err.Source
   Resume Next
End Sub
Private Function GetChapterTime(arg_ChapterTime As String, ByVal lng_chapter As Long) As Long
   On Error GoTo Error
   Dim i As Integer
   Dim arr_split() As String
   Dim arr_each() As String
   Dim lng_Result As Long
   arr_split = Split(arg_ChapterTime, "&&&")
   lng_Result = -1                                 'can't find any matching chapter
   For i = 0 To UBound(arr_split)
      arr_each = Split(arr_split(i), "||")
      If arr_each(0) = lng_chapter Then
         If arr_each(2) = "" Or arr_each(2) = "-1" Then
            lng_Result = -1
         Else
            lng_Result = Time2Second(arr_each(2))
         End If
         Exit For
      End If
   Next
   GetChapterTime = lng_Result
   Exit Function
Error:
   WriteEvent "GetChapterTime", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   GetCurrentChapter
' Description       :   get current chapter for all types of video file
' Return Values     :   chapter number
' Input Parameter   :   current time position
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             02-06-2006           New
'*******************************************************************************

'''Public Function GetCurrentChapter(Optional arg_currentTime As Long) As Long
'''   On Error GoTo Error
'''   Dim loc_fileExtension As String
'''   Dim loc_ChapterString  As String
'''   Dim loc_arr() As String
'''   Dim loc_Fields() As String
'''   Dim loc_currentTime As Long
'''   Dim i As Long
'''   loc_fileExtension = LCase(fso.GetExtensionName(str_current_Track))
'''   If playMusicWith = Winamp And (loc_fileExtension = "ifo" Or loc_fileExtension = "mp4") Then
'''      GetCurrentChapter = CMediaPlayer.CurrentChapter
'''   ElseIf loc_fileExtension = "ifo" And playMusicWith = WindowMedia Then
'''      GetCurrentChapter = val(CWmp.currentMedia.getItemInfo("chapterNum"))
'''   ElseIf Infos(int_current_index).trackExternal = False Then
'''      loc_ChapterString = GetChapterFromMovie(Infos(int_current_index).trackAlbumID, PlayTrackInfo(int_current_index).language, 0)
'''      loc_arr = Split(loc_ChapterString, de_Record)
'''      For i = UBound(loc_arr) To 0 Step -1
'''         loc_Fields = Split(loc_arr(i), de_Field)
'''         loc_currentTime = Time2Second(loc_Fields(2))          'convert from specific format("00:00:00") to seconds
'''         If loc_currentTime <= arg_currentTime Then
'''            GetCurrentChapter = loc_Fields(0)              'Current chapter
'''            Exit For
'''         End If
'''      Next
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "GetCurrentChapter", Err.Description, Err.Source
'''End Function
'''Public Function getMovieDuration() As Long
'''   On Error Resume Next
'''   If playMusicWith = Winamp Then
'''      getMovieDuration = CMediaPlayer.movieDuration
'''   Else
'''      getMovieDuration = CWmp.currentMedia.duration
'''   End If
''''''   Exit Function
''''''Error:
''''''   WriteEvent "getMovieDuration", Err.Description, Err.Source
'''End Function

'''Public Function getCurrentDuration() As Double
'''   On Error GoTo Error
'''   If playMusicWith = Winamp Then
'''      getCurrentDuration = CMediaPlayer.GetDurationPlay
'''   Else
'''      getCurrentDuration = CWmp.controls.currentPosition
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "getCurrentDuration", Err.Description, Err.Source
'''End Function
'======shareName from path
Private Function getShareNameFromPath(path As String) As String
   On Error Resume Next
   Dim shareResource() As ShareType
   Dim i As Integer
   
   shareResource = GetShareList
   If UBound(shareResource) > -1 Then
      For i = 0 To UBound(shareResource)
         If StrComp(shareResource(i).path, fso.GetParentFolderName(path), vbTextCompare) = 0 Then getShareNameFromPath = shareResource(i).Name: Exit For
      Next
   End If
   Erase shareResource
End Function
Public Function ChangeAllStreamPath(ByVal loc_AlbumID As Long, ByVal loc_TrackID As Long, ByVal LanguageID As String, ByVal iPlayTrackFrom As Integer, loc_Path As String) As String
   On Error GoTo Error
   Dim i As Long
   If (loc_AlbumID > 0) And (loc_TrackID > 0) Then
      For i = 0 To int_track_count - 1
         If (val(PlayTrackInfo(i).albumID) = loc_AlbumID) And (val(PlayTrackInfo(i).TrackID) = loc_TrackID) And (PlayTrackInfo(i).Language = LanguageID) Then
               PlayTrackInfo(i).StreamPath = loc_Path
               If loc_Path <> "" Then PlayTrackInfo(i).PlayTrackFrom = iPlayTrackFrom
               'don't make it try to request path again
               PlayTrackInfo(i).StreamPathRequested = True
         End If
      Next
   End If
   If int_current_index >= 0 And int_track_count > 0 Then
      If b_play = False And PlayTrackInfo(int_current_index).StreamPathRequested Then
         If CWinsock.LoggedAs(ServerMode) Then
            handleMinicommand "SelectedPlaylist" & "|:|" & int_current_index
         Else
            'play it selfs without sending play again to server
            play_tracks int_current_index
         End If
      End If
   Else
      Debug.Assert False
   End If
   Exit Function
Error:
   WriteEvent "ChangeAllStreamPath", Err.Description, Err.Source
End Function
Public Sub ZoomToLevel(level As Integer)
   On Error GoTo Error
   Dim i As Integer
   Dim stepIncrease As Integer
   Dim stepcommand As IPanScan
   
   If level < 0 Then
      stepIncrease = -1
      stepcommand = decreaseSize
   Else
      stepIncrease = 1
      stepcommand = increaseSize
   End If
   scaleWMPVdeo

   Exit Sub
Error:
   WriteEvent "ZoomToLevel", Err.Description, Err.Source
End Sub

'''Public Function SetWmpURL(newURL As String) As IWMPMedia
'''   On Error GoTo Error
'''   Dim objWmp As IWMPMedia
'''
'''   Set SetWmpURL = CWmp.newMedia(newURL)
'''   Exit Function
'''Error:
'''   WriteEvent "SetWmpURL", Err.Description, Err.Source
'''End Function
'''Public Function isInMenuMode() As Boolean
'''   On Error GoTo Error
'''   If playMusicWith = Winamp Then
'''      isInMenuMode = CMediaPlayer.isInMenuMode
'''   Else
'''      isInMenuMode = CWmp.dvd.isAvailable("resume")
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "IsInMenuMode", Err.Description, Err.Source
'''End Function
Public Sub loadMusicFromWaitng(cIndex As Integer)
   On Error GoTo Error
   Dim iLocalValue As Single
'   Dim boolPausedState As Boolean

   boolPausedState = (CPlayer.playState = wmppsPaused)
   If boolPausedState Then
      CPlayer.Play
   End If
   ' xxxxx changed sith 24-05-06
   CurrentFind = clientLoaded
   lastLoadClientIndex = cIndex
   'FrmMain.tmrFindTime.Enabled = True
'xxxxxxxxxx end xxxxxxxxxxxxxxxxxxxxx
   
   
   Exit Sub
Error:
   WriteEvent "loadMusicFromWaitng", Err.Description, Err.Source
End Sub
'xxxxxxxxxxxxxx changed sith 23-05-06 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Public Sub playIFO()
   'Dim loc_CurrentTrack As Tracks
   On Error GoTo ErrorPlayIFO
    If int_track_count > 0 And int_current_index > -1 Then
       '==== if file play once =====
       Dim sCurrentEx As String
       sCurrentEx = CPlayer.UrlExtension '  LCase(fso.GetExtensionName(str_current_Track))
       ' loc_CurrentTrack = PlayTrackInfo(int_current_index)
       ' it is bookmark,1 Play Till End,2 PlayTill Next Track,3 Play For amount of seconds,4 Like number 2 but it is jump to chapter not second for karaoke or music              'Index 27
       ' With loc_CurrentTrack     'Seng 2006-10-25
       
       
check:
            If PlayTrackInfo(int_current_index).BookmarkLength > 0 And PlayTrackInfo(int_current_index).BookmarkTime >= 0 Then
               miniCommand "FullScreen|:|change"
               get_track_info False
               LoadNextBanner
               If (CPlayer.HasVideo = False) Then
                  FrmMain.swfImagePlaying.Visible = True
               Else
                  FrmMain.swfImagePlaying.Visible = False
               End If
                  
                ShowDebug "     Time Received Last = " & vbTab & PlayTrackInfo(int_current_index).BookmarkLength
                ShowDebug "     BookMarkTime       = " & vbTab & PlayTrackInfo(int_current_index).BookmarkTime
                ShowDebug "     -----------------------------"
                ShowDebug "     Different" & vbTab & (PlayTrackInfo(int_current_index).BookmarkLength - PlayTrackInfo(int_current_index).BookmarkTime)
                ShowDebug "========================================================"

               'If b_karaoke_voice Then
'               If run_iPlayTrackCount <= int_MaxPlayCount Then
                  If IsRegistered = False Then
                     'When SlyGuide run as client/server media sound will be muted
                     If CWinsock.LoggedAs(independentMode) = True Or CWinsock.GetNumberOfConnected > 0 Then
                        run_iPlayTrackCount = 1
                     Else
                        run_iPlayTrackCount = 0
                     End If
                   Else
                     run_iPlayTrackCount = 0
                  End If
'               End If
               'If CPlayer.PlayWith <> VideoLan Then
                  'Don't switch the audio if it's MP4       2007-04-18
                  If PlayTrackInfo(int_current_index).AudioChannel = -1 Then
                     CPlayer.SwitchAudio 0
                  Else
                     CPlayer.SwitchAudio GetNonKaraokeChannel(PlayTrackInfo(int_current_index).AudioChannel, b_karaoke_voice)
                  End If
               'End If
               'popUp True
               ShowPlayState2Flash b_play
                If CWinsock.isServerConnected Then
                  'send to all clients /remotecontrol also
                   CWinsock.Send2Client WS_COMMAND, 0, "SelectPlayerTrack&&&" & int_current_index & "&&&" & str_current_Track
                   If CWinsock.ClientMusicLoaded < CWinsock.getClonePlayBackCounts Then
                      'Need to seek time before it wait for clients   2006-05-23
'''                      SeekWindowMedia PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
                      CPlayer.Seeks = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
                      run_WaitingMode = True
                      Dim strTime As String
                      
                      strTime = Second2Time(PlayTrackInfo(int_current_index).BookmarkLength - PlayTrackInfo(int_current_index).BookmarkTime)
                      seekBarDisplay = "00:00:00 / " & left(strTime, InStr(strTime, ".") - 1)
                      seekBarpercent = 0
                      DisplaySeekBarInfo 0 & "|%|" & seekBarDisplay
                      
                      'timeVisible = PlayTrackInfo(int_current_index).seekOffset
                      timeVisible = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
                      
                      Exit Sub
                   End If
               ElseIf CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(remotePlaylist) Then
                  CWinsock.Send2Server WS_COMMAND, "MusicLoaded"
                  run_WaitingMode = True
                  ShowPlayState2Flash b_play
                  Exit Sub
               End If
               If Not run_LoadingLastMusic Then
                  
'''                  If b_pause Or CWmp.Status = "Paused" Or CWmp.Status = "Stopped" Then CWmp.controls.Play
                  If b_pause Or CPlayer.playState = wmppsPaused Or CPlayer.playState = wmppsStopped Then CPlayer.Play
                  'CWmp.controls.currentPosition = .BookmarkTime + .seekOffset
                   DoEvents
'''                  SeekWindowMedia PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
                  CPlayer.Seeks = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
                  timeVisible = PlayTrackInfo(int_current_index).BookmarkTime + PlayTrackInfo(int_current_index).seekOffset
               ElseIf run_LoadingLastMusic Then
                 lastPlayTime = IIf(lastPlayTime < PlayTrackInfo(int_current_index).BookmarkTime, PlayTrackInfo(int_current_index).BookmarkTime, lastPlayTime)
                 DoEvents
                  CPlayer.Seeks = lastPlayTime
                 timeVisible = lastPlayTime
                 lastPlayTime = 0
                 run_LoadingLastMusic = False
               End If
               ZoomToLevel PlayTrackInfo(int_current_index).ZoomLevel
               startNew = False
               FrmMain.tmr.Enabled = True
               sendVariable2Flash FrmMain.swfMiniControl, "databaseType", get_country_type(PlayTrackInfo(int_current_index).Language)  'sith 26/10/06
               'get_country_type (PlayTrackInfo(int_current_index).language)
               sendToFlash FrmMain.swfMiniControl, "KaraokeAudio", CStr(b_karaoke_voice)         'Send karaoke channel to voice
               
               Exit Sub
            End If 'length and time > 0
            '======== not ifo =================
         If CPlayer.Duration > 0 Then
'''      If CWmp.currentMedia.duration > 0 Then
           If sCurrentEx <> "ifo" And CPlayer.chapterCount = 0 Then
               If PlayTrackInfo(int_current_index).BookmarkLength <= 0 Then
                   'PlayTrackInfo(int_current_index).BookmarkLength = CInt(CWmp.currentMedia.duration)
                   PlayTrackInfo(int_current_index).BookmarkLength = CInt(CPlayer.Duration)
               End If
               If PlayTrackInfo(int_current_index).BookmarkTime < 0 Then
                   PlayTrackInfo(int_current_index).BookmarkTime = 0
               End If
               GoTo check:
           End If
           ' ==== ifo ===
           If (sCurrentEx = "ifo") Or (CPlayer.chapterCount > 0) Then
               If PlayTrackInfo(int_current_index).BookmarkLength <= 0 Then
                   'CurrentFind = duration 'tell timer what it's going to find
                   ' find the length of the track first
                   OldWMPPos = CPlayer.Seeks
                   
                   If PlayTrackInfo(int_current_index).BookmarkType = 4 Then ' till next chapter
                      If PlayTrackInfo(int_current_index).NoTrack < CPlayer.chapterCount Then
                           CPlayer.Volume = 0
                           CPlayer.SelectChapter PlayTrackInfo(int_current_index).NoTrack
                           CurrentFind = Duration 'tell timer what it's going to find
                      Else
                          ' last chapter
                           CPlayer.Volume = 0
                           PlayTrackInfo(int_current_index).BookmarkLength = CPlayer.Duration
                           If (PlayTrackInfo(int_current_index).NoTrack - 1) < CPlayer.chapterCount Then
                              CPlayer.SelectChapter PlayTrackInfo(int_current_index).NoTrack - 1
                              CurrentFind = Position 'tell timer what it's going to find
                          Else
                              CurrentFind = Duration 'tell timer what it's going to find
                              GoTo check:
                          End If
                      End If ' notrack = playlist's item count
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 2 Then
                       If PlayTrackInfo(int_current_index).BookmarkChapter < CPlayer.chapterCount Then
                           CPlayer.Volume = 0
                           CPlayer.SelectChapter CInt(PlayTrackInfo(int_current_index).BookmarkChapter)
                           CurrentFind = Duration 'tell timer what it's going to find
                       Else
                          ' last chapter
                          PlayTrackInfo(int_current_index).BookmarkLength = CPlayer.Duration
                          CurrentFind = Duration 'tell timer what it's going to find
                          GoTo check:
                       End If ' notrack = playlist's item count
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 3 Then
                      CurrentFind = Duration 'tell timer what it's going to find
                       ' 1 or 3
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 0 Or PlayTrackInfo(int_current_index).BookmarkType = 1 Then
'''                       PlayTrackInfo(int_current_index).BookmarkLength = CInt(CWmp.currentMedia.duration)
                       PlayTrackInfo(int_current_index).BookmarkLength = CPlayer.Duration
                       'CurrentFind = duration 'tell timer what it's going to find
                       GoTo check:
                   End If 'bookmarktype = 4
                   'FrmMain.tmrFindTime.Enabled = True
                   '=============== end get lenght ============
               ElseIf PlayTrackInfo(int_current_index).BookmarkTime <= 0 Then
                   'fine the start position
                   If PlayTrackInfo(int_current_index).BookmarkType = 4 Then
                      If PlayTrackInfo(int_current_index).PlayTrackFrom <> 4 And CPlayer.chapterCount >= val(PlayTrackInfo(int_current_index).NoTrack) Then
                           CPlayer.Volume = 0
                           CurrentFind = Position 'tell timer what it's going to find
                           CPlayer.SelectChapter (CInt(PlayTrackInfo(int_current_index).NoTrack) - 1)
                      Else
                           PlayTrackInfo(int_current_index).BookmarkTime = 0
                           GoTo check:
                      End If
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 1 Or PlayTrackInfo(int_current_index).BookmarkType = 3 Then
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 2 Then
                   ElseIf PlayTrackInfo(int_current_index).BookmarkType = 0 Then
                     If PlayTrackInfo(int_current_index).PlayTrackFrom > 0 And PlayTrackInfo(int_current_index).PlayTrackFrom < 4 Then
                           If Not Infos(int_current_index).trackExternal Then
                              CurrentFind = Position 'tell timer what it's going to find
                              CPlayer.Volume = 0
                              CPlayer.SelectChapter CInt(PlayTrackInfo(int_current_index).NoTrack) - 1
                           Else
                              PlayTrackInfo(int_current_index).BookmarkTime = 0
                              GoTo check:
                           End If
                       Else
                           PlayTrackInfo(int_current_index).BookmarkTime = 0
                           GoTo check:
                       End If ' albumavailable
                   End If
                   '================ end get Time ============
               End If '==== end file play once =====
           End If ' ifo
         Else
            CurrentFind = callFuntion
         End If 'duration > 0
       ' End With 'with playtrackinfo(int_current_track)
      End If
      Exit Sub
ErrorPlayIFO:
   WriteEvent "PlayIFO", Err.Description, Err.Source
End Sub
'xxxxxxxxxxxxxxxxxxxxxxxxxxxx end xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

'sound with no picture
Public Sub SelectPlayerViaExtension(url As String)
   Dim strEx As String
   Dim bAutoplayerChoosen As Boolean
   Dim PNewPlayer As playerEnum
   strEx = LCase(fso.GetExtensionName(url))
   
   PNewPlayer = playMusicWith               'Default to windows media
   If AutoPlayEnabled And CPlayer.IsVLCInstalled Then
      If InStr(":" & LCase(s_DefaultVLCExtension) & ":", ":" & strEx & ":") > 0 Then
         bAutoplayerChoosen = True
         PNewPlayer = VideoLan
      End If
   End If
   If bAutoplayerChoosen = False Then
      If AutoPlayMPC And CPlayer.IsMPlayerInstalled Then
         If strEx = "mp4" Then
            PNewPlayer = MediaPlayer
            bAutoplayerChoosen = True
         End If
      End If
   End If
   If bAutoplayerChoosen = False Then
   '''If WMP or MPC is selected everything will play with WMP or MPC  but high definition will play with PowerDVD externally.
      If AutoPlayPowerDVD And CPlayer.IsPowerDVDInstalled And (playMusicWith = MediaPlayer Or playMusicWith = WindowMedia) Then
         If IsBLURAY(url) Or IsHD_DVD(url) Then
            bAutoplayerChoosen = True
            PNewPlayer = PowerDVD
         ElseIf strEx = "iso" Then
            If IsBLURAY(s_DriveMount & ":\") Or IsHD_DVD(s_DriveMount & ":\") Then
               Sleep (1000)            'sleep more 1000 second to make it has more time to finish loading files
               bAutoplayerChoosen = True
               PNewPlayer = PowerDVD
            End If
         End If
'''         If InStr(":" & LCase(s_DefaultPowerDVDExtension) & ":", ":" & strEx & ":") > 0 Then
'''            bAutoplayerChoosen = True
'''            PNewPlayer = PowerDVD
'''         End If
      End If
   End If
SelectNew:
   If bAutoplayerChoosen = False Then
      If playMusicWith = MediaPlayer And CPlayer.IsMPlayerInstalled Then PNewPlayer = MediaPlayer
   End If
   
   If CPlayer.PlayWith <> PNewPlayer Then CPlayer.PlayWith = PNewPlayer

End Sub
Public Function isSoundFile(strPath As String) As Boolean
   On Error GoTo Error
   Dim strEx As String
   
   strEx = LCase(fso.GetExtensionName(strPath))
   Select Case strEx
      Case "mp3", "wav", "aac", "wma", "m4a", "flac", "ape", "ogg"
         isSoundFile = True
      Case Else
         isSoundFile = False
   End Select
   Exit Function
Error:
   WriteEvent "isSoundFile", Err.Description, Err.Source
End Function
Public Sub ShowPlayState2Flash(ab_Play As Boolean)
   On Error GoTo Error

   If str_swfNames = "Micro" Then
      sendVariable2Flash FrmMain.SWF_FMA(2), "playMusic", CStr(ab_Play)
      sendVariable2Flash frmOver.swfOver, "playMusic", CStr(ab_Play)
   End If
   If bool_full_vis Then
     sendToFlash FrmMain.swfDVDControl, "play", CStr(ab_Play)
   End If
   sendToFlash FrmMain.swfMiniControl, "play", CStr(ab_Play)
   If LoadSlideshow = True Then sendToFlash frmSlideShow.SlideShow, "Play", CStr(ab_Play)
   If str_swfNames = "Fullscreen" Then sendToFlash FrmMain.SWF_FMA(1), "play", CStr(ab_Play)
   CWinsock.Send2Client WS_COMMAND, 0, "SendPlayState&&&" & getPlayState
   Exit Sub
Error:
   WriteEvent "ShowPlayState2Flash", Err.Description, Err.Source
End Sub

Public Property Let CurrentFind(varValue As FindEnum)
   On Error GoTo Error
   localFind = varValue
   FrmMain.tmrFindTime.Enabled = varValue <> findnone
   Exit Property
Error:
   WriteEvent "Let CurrentFind", Err.Description, Err.Source
End Property
Public Property Get CurrentFind() As FindEnum
   On Error GoTo Error
   CurrentFind = localFind
   Exit Property
Error:
   WriteEvent "Get CurrentFind", Err.Description, Err.Source
End Property

Public Sub sendTrackIndex2Player()
   On Error GoTo Error
   If IndexSwf = 4 And bExitingProgram = False Then
      sendToFlash FrmMain.swf(4), "SetPlayTrackIndex", CStr(int_current_index) & "|%|" & CStr(int_track_count)
   End If
   Exit Sub
Error:
   WriteEvent "sendTrackIndex2Player", Err.Description, Err.Source
End Sub
Public Sub changeEngUni()
''    If int_track_count > 0 Then
''        b_displayNewTrack = True
''        get_track_info False
''    End If
''    b_displayNewTrack = False
   ''If bool_full_vis And FrmMain.picPopup.Visible Then popUp CWmp
End Sub

'*******************************************************************************
' Function Name     :   addToPlaylistFromCommand
' Description       :   add file to playlist from command line
' Return Values     :   Nothing
' Input Parameter   :   Nothing
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ***  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Private Sub addToPlaylistFromCommand()
   On Error GoTo Error
    Dim str() As String
    Dim i As Integer
    Dim fileLine As String
    
    If command <> "" Then
        If InStr(1, command, """") > 0 And InStr(1, command, "\\") > 0 Then 'impossible
            str = Split(command, """")
        ElseIf InStr(1, command, """", vbBinaryCompare) > 0 Then
            str = Split(command, """")
        ElseIf InStr(1, command, "\\") > 0 Or InStr(1, command, """") = 0 Then
            str = Split(command, " ")
        End If
        
        For i = 0 To UBound(str)
            str(i) = Trim(str(i))
            If str(i) <> "" Then
                If isMedia(str(i)) Then
                   'just loaded always server
                    AddMusicToPlayer str(i)
                 End If
            End If '<>""
        Next
        If Not b_play Then miniCommand "Play|:|True"
    End If
   Exit Sub
Error:
   WriteEvent "addToPlaylistFromCommand", Err.Description, Err.Source
End Sub
Public Property Get GetNonKaraokeChannel(ByVal karaokeChannel As Integer, ByVal bKaraoke As Boolean) As Integer
   On Error GoTo Error
   Dim iChannel As Integer

   iChannel = karaokeChannel And 15                   '0100

   If karaokeChannel >= 0 Then
      If (karaokeChannel And 16) = 16 Then
         'The value is karaoke voice
         If bKaraoke Then
            GetNonKaraokeChannel = iChannel
         Else
            If iChannel = 0 Then
               GetNonKaraokeChannel = 1
            Else
               GetNonKaraokeChannel = 0
            End If
         End If
      Else
         'The value is sing voice
         If bKaraoke Then
            If karaokeChannel = 0 Then
               GetNonKaraokeChannel = 1
            Else
               GetNonKaraokeChannel = 0
            End If
         Else
            GetNonKaraokeChannel = iChannel
         End If
      End If
   Else
      GetNonKaraokeChannel = -1
   End If
'''   If karaokeChannel = 0 Then
'''      GetNonKaraokeChannel = 1
'''   Else
'''      GetNonKaraokeChannel = 0
'''   End If
   
   Exit Property
Error:
   WriteEvent "Get GetNonKaraokeChannel", Err.Description, Err.Source
End Property


Public Sub GotoTrack(ByVal bNext As Boolean)
   Dim textDisplay As String
   If int_track_count > 1 Then
      run_LoadingLastMusic = False
      If b_shuffle Then
           int_nextPrevious_index = int_next_index
           get_next_previouse_index
      Else
         If int_nextPrevious_index < 0 Then int_nextPrevious_index = int_current_index
         If bNext Then
            'Next
            int_nextPrevious_index = int_nextPrevious_index + 1
            If int_nextPrevious_index >= int_track_count Then
               int_nextPrevious_index = 0
            End If
         Else
            'Previous
            int_nextPrevious_index = int_nextPrevious_index - 1
            If int_nextPrevious_index < 0 Then
               int_nextPrevious_index = (int_track_count - 1)
            End If
         End If
           tmpIndex = tmpIndex + 1
           If tmpIndex >= int_track_count Then
               tmpIndex = 0
           End If
      End If
      If bNext Then
         textDisplay = "Next Track"
      Else
         textDisplay = "Previous Tracks"
      End If
      sendInfoControllPlayer " " & textDisplay & " " & (int_nextPrevious_index + 1)
      FrmMain.tmr_press_select_chapter.Enabled = False
      FrmMain.tmr_press_select_chapter.Enabled = True
   End If
End Sub

Private Sub setTextScrollPlaying()
   Dim strText As String
   
   With Infos(int_current_index)
   
      strText = Language & "|||" & .trackFontName.Eng & "|&|" & .trackFontName.Uni & "|&|" & 0 & "|&|" & 0 & "|&|"
      strText = strText & "|:|" & .trackAlbum.Eng & "|:|" & .trackAlbum.Uni & "|:|" & .TrackTitle.Eng & "|:|" & .TrackTitle.Uni & "|:|" & .trackArtist.Eng & "|:|" & .trackArtist.Uni
      FrmMain.swfImagePlaying.SetVariable "TextScroll", strText
   End With

End Sub
Public Property Let VolumeMute(bValue As Boolean)

   b_mute = bValue
   'run_bVolumeMuted
   'b_AutoConnect = True
'   b_aut
      
End Property
