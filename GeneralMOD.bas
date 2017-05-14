Attribute VB_Name = "GeneralMOD"
Option Explicit


Const RAR_SKIP = 0
Const RAR_TEST = 1
Const RAR_EXTRACT = 2
Const RAR_OM_LIST = 0
Const RAR_OM_EXTRACT = 1

Private Const MAX_READ = 10240                      '10kb
Private fileReadHandle As Integer
Private fileWriteHandle As Integer
Public boolCopying As Boolean
Public bExitingProgram As Boolean                                  'if the program exist =true
Public collectionCommand As New Collection               'collect for execute any command
Private boolReadProgress As Boolean
Private readBuffer As String
Private nReadBytes As Long

Public stored_Language As String
Public stored_TrackPath As String
Public stored_TrackID As String
Public stored_oldTrackPath As String
Public stored_oldTrackID As String
Public stored_oldIndex As Long

Public Type DownloadMusicType                    'For download from Server
   Language As String
   ToTrackPath As String
   TrackID As String
   FromTrackPath As String
   RemoteServer As String
   TrackTitle As String
End Type


Public DownloadMusicQueue() As DownloadMusicType
Public DownloadingMusic As DownloadMusicType
Public TimeStartSlyMultimedia As Variant                    'Time when the machine run

Public DLIndex As Integer 'Downloading index
Private Type RARHeaderData
    ArcName As String * 260
    filename As String * 260
    flags As Long
    PackSize As Long
    UnpSize As Long
    HostOS As Long
    FileCRC As Long
    FileTime As Long
    UnpVer As Long
    Method As Long
    FileAttr As Long
    CmtBuf As String
    CmtBufSize As Long
    CmtSize As Long
    CmtState As Long
End Type
 
Private Type RAROpenArchiveData
    ArcName As String
    OpenMode As Long
    OpenResult As Long
    CmtBuf As String
    CmtBufSize As Long
    CmtSize As Long
    CmtState As Long
End Type
Public Enum ShowEnum
   SW_HIDE = 0
   SW_NORMAL = 1
End Enum

Enum RarOperations
    OP_EXTRACT = 0
    OP_TEST = 1
    OP_LIST = 2
End Enum
 
 
'' Store all countries path in sly
Public CountriesList() As CountryType
Public allCountry As String
Public countriesListNet() As CountryType
'Private countriesListClient() As CountryType
 
Private Declare Function RAROpenArchive Lib "unrar.dll" (ByRef ArchiveData As RAROpenArchiveData) As Long
Private Declare Function RARCloseArchive Lib "unrar.dll" (ByVal hArcData As Long) As Long
Private Declare Function RARReadHeader Lib "unrar.dll" (ByVal hArcData As Long, ByRef HeaderData As RARHeaderData) As Long
Private Declare Function RARProcessFile Lib "unrar.dll" (ByVal hArcData As Long, ByVal Operation As Long, ByVal destPath As String, ByVal DestName As String) As Long
Private Declare Sub RARSetChangeVolProc Lib "unrar.dll" (ByVal hArcData As Long, ByVal Mode As Long)
Private Declare Sub RARSetPassword Lib "unrar.dll" (ByVal hArcData As Long, ByVal Password As String)


'''Public Mp3 As New Music


Public Function ArrayAdd(strList() As String, strText As String) As Integer
  On Error Resume Next
  Dim i As Integer
  i = UBound(strList) + 1
  ReDim Preserve strList(i)
  strList(i) = strText
  ArrayAdd = i
End Function
Public Sub Unrars(RarFile As String, ByVal destinationDirectory As String, Optional extractPath As String)
   On Error GoTo Error
    Dim lHandle As Long, iStatus As Integer
    Dim uRAR As RAROpenArchiveData, uHeader As RARHeaderData
    Dim Ret As Long, rarFlag As Long, namePosition As Long
    Dim extractName As String
     
    uRAR.ArcName = RarFile
    uRAR.CmtBuf = Space(16384)
    uRAR.CmtBufSize = 16384
    
    uRAR.OpenMode = RAR_OM_EXTRACT
    lHandle = RAROpenArchive(uRAR)
    If right(destinationDirectory, 1) <> "\" Then destinationDirectory = destinationDirectory + "\"
    If uRAR.OpenResult = 0 Then
        iStatus = RARReadHeader(lHandle, uHeader)
        Do Until iStatus <> 0
            extractName = left(uHeader.filename, InStr(uHeader.filename, vbNullChar) - 1)
            namePosition = InStrRev(extractName, "\")
            rarFlag = RAR_SKIP
            If (namePosition > 0) And (extractPath <> "") Then
               extractName = left(extractName, namePosition)
               If StrComp(right(extractName, Len(extractPath)), extractPath, vbTextCompare) = 0 Then
                  extractName = extractPath + mID(uHeader.filename, namePosition + 1)
                  rarFlag = RAR_EXTRACT
               End If
            ElseIf extractPath = "" Then
               rarFlag = RAR_EXTRACT
            End If
            Ret = RARProcessFile(lHandle, rarFlag, "", destinationDirectory + extractName)
            iStatus = RARReadHeader(lHandle, uHeader)
        Loop
    End If
    RARCloseArchive lHandle
   Exit Sub
Error:
   WriteEvent "Unrars", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   ReloadCountryFromXML
' Description       :   Reload allcountry path from xml and create my album xml
' Return Values     :   True,false
' Input Parameter   :   Non
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             18-07-2006           New
'*******************************************************************************

Public Function ReloadCountryFromXML() As Boolean
   On Error GoTo ErrorLoadingCountry
   Dim i As Long
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   
   Dim xmlLanguage As New DOMDocument
   Dim xmlLanguageRoot As IXMLDOMElement
   
   Dim inputList() As CountryType
   XmlDoc.Load SlyVariable("<AppPath>") & "\Sly\Countries.xml"
   Set xmlRoot = XmlDoc.firstChild
   
   ReDim Preserve inputList(-1 To xmlRoot.childNodes.Length - 1)
   For i = 0 To xmlRoot.childNodes.Length - 1
      Set xmlElement = xmlRoot.childNodes.item(i)
      With inputList(i)
         .Text = xmlElement.getAttribute("Name")
         .Name = xmlElement.Text
         .path = xmlElement.getAttribute("Path")
         .Image = xmlElement.getAttribute("imagePath")
         
         xmlLanguage.Load (.path & "\" & "Language.xml")
         If xmlLanguage.parseError.errorCode = 0 Then
            Set xmlLanguageRoot = xmlLanguage.firstChild
            .ID = Null2Value(xmlLanguageRoot.getAttribute("databaseType"))
            .key = Null2Str(xmlLanguageRoot.getAttribute("Key"))
         End If
            
         SlyVariable("<" & .Name & "_img>") = .Image
         SlyVariable("<" & .Name & "_dat>") = .path
         SlyVariable("<" & .Name & "_id>") = .ID
         SlyVariable("<" & .Name & "_txt>") = .Text
         SlyVariable("<" & .Name & "_key>") = .key
         If allCountry = "" Then
            allCountry = .path & "%" & .Name & "%" & .Image & "%" & .ID
         Else
            allCountry = allCountry & "%%" & .path & "%" & .Name & "%" & .Image & "%" & .ID
         End If
      End With
   Next
   ReloadCountryFromXML = True
   CountriesList = inputList
   CreateMyAlbumXml SlyNickName
  
   Exit Function
ErrorLoadingCountry:
   WriteEvent "ReloadCountryFromXML", Err.Description, Err.Source
End Function
Public Sub CopyCompleted(languageName As String, TrackID As String, TrackPath As String)
Attribute CopyCompleted.VB_Description = "Occur when download completely from server or client"
   On Error GoTo Error
   Dim TrackIndex As Long
   Dim languagePath As String
   
   If isFileExist(TrackPath) Then
      languagePath = SlyVariable("<" & languageName & "_dat>")
      If (Not CWinsock.StreamFile) And (languagePath <> vbNullString) Then
         TrackIndex = trackIndexFromID(TrackID)
         If TrackIndex >= 0 Then
            If PlayTrackInfo(TrackIndex).Mode <> "External" Then
               SetTrackPath(TrackID, languagePath) = TrackPath
               trackAvailable(languageName, TrackID) = 2
            Else
               ExternalTrackAvailable(PlayTrackInfo(TrackIndex).comName, TrackID) = TrackPath
            End If
            While TrackIndex >= 0
               If PlayTrackInfo(TrackIndex).Mode <> "External" Then
                  PlayTrackInfo(TrackIndex).comName = SlyNickName
               End If
               PlayTrackInfo(TrackIndex).TrackAva = 2
               PlayTrackInfo(TrackIndex).DownloadFromServer = False
               Infos(TrackIndex).TrackPath = TrackPath
               TrackIndex = trackIndexFromID
            Wend
            If IndexSwf = 4 Then Call CallFlashFunction(FrmMain.swf(4), "refreshTrackAvailable", TrackID)
         End If
      End If
   End If
   Exit Sub
Error:
   WriteEvent "CopyCompleted", Err.Description, Err.Source
End Sub

Public Property Let CopyingSong(vNewValue As Boolean)
   On Error GoTo ErrorIndexSwf
   boolCopying = vNewValue
   If IndexSwf = 4 Then
      CallFlashFunction FrmMain.swf(IndexSwf), "ShowBar", CInt(vNewValue)
      CallFlashFunction FrmMain.swf(IndexSwf), "SongN", DownloadingMusic.TrackTitle
      sendVariable2Flash FrmMain.swf(IndexSwf), "DLIndex", DLIndex
   End If
ErrorIndexSwf:
End Property
Public Property Get CopyingSong() As Boolean
   CopyingSong = boolCopying
End Property
Public Sub RefreshAlbumAvailableToServer()
   On Error GoTo Error
   CreateMyAlbumXml SlyNickName
   If CWinsock.LoggedType = ServerMode Then
      CWinsock.Send2Client WS_COMMAND, 0, "refreshClientAlbum&&&"
   Else
      CWinsock.SendCopy WS_COPYTO, 0, SlyVariable("<MyAlbumServer>") & FileDelimiter & "<AlbumPath>" & CWinsock.clientIndex & ".xml" & FileDelimiter & "AlbumFromClient"
   End If
   Exit Sub
Error:
   WriteEvent "RefreshAlbumAvailableToServer", Err.Description, Err.Source
End Sub
Public Sub Writelog(lpFunctionName As String, LOGTYPE As String, errDesc As String, param As String)
   Debug.Print lpFunctionName, LOGTYPE, errDesc, param
   #If Log = 1 Then
      On Error Resume Next
      Dim ts As TextStream
      Dim txtLog As String
      
      'To handle the log file and event loggging
      Set ts = fso.OpenTextFile(LogPath & "\log " & Format(Date, "yyyymm") & ".txt", ForAppending, True)
      '2013-07-02 08:44:33, 351 ERROR [T=577] [com.dd.oms.net.med.util.RequestTask.run() 130] Request timed out, request=[equest owner=NetEco.PM, id=232232, target=[Target host=, Protocol=BINARY], params=class]
      txtLog = Now & vbTab & LOGTYPE & ",[" & lpFunctionName & "] " & errDesc & " [" & param & "]"
      
      ts.WriteLine txtLog
      ts.Close
      If LOGTYPE = "ERROR" Then
         MsgBox txtLog
      End If
   #End If
   
End Sub

Public Function WriteEvent(lpFunctionName As String, Value As String, Title As String)
   On Error Resume Next
   Dim ts As TextStream
   Dim txtLog As String
   
   #If debugging = 1 Then
      
      Debug.Print "Time = " & Now, "["; lpFunctionName; "] "; Value
      
      
      Debug.Assert False
   #Else
      App.LogEvent "Error <" & Title & ">" & vbNewLine & "Function = [" & lpFunctionName & "] " & Value
      MsgBox "Function = " & "" & lpFunctionName & vbNewLine & Value, vbCritical, "Error <" & Title & ">"
   #End If
      Set ts = fso.OpenTextFile(LogPath & "\log " & Format(Date, "yyyymm") & ".txt", ForAppending, True)
      txtLog = Now & vbTab & "Error" & ",[" & lpFunctionName & "] " & Err.Description & " [" & Value & "]"
      ts.WriteLine txtLog
      ts.Close
   
'''   Set ts = fso.OpenTextFile(LogPath & "\ErrorLog.txt", ForAppending, True)
'''   ts.WriteLine ("=====================Consummed : " & DateDiff("n", TimeStartSlyMultimedia, Now) & " minute(s)") & "================"
'''   ts.WriteLine ("=====================Time    " & Now & "=======================")
'''   ts.WriteLine ("Module       = " & UCase(Title))
'''   ts.WriteLine ("Function     = " & lpFunctionName)
'''   ts.WriteLine ("Description = " & Value)
'''   ts.Close
   
End Function
Public Sub ShowDebug(lpString As String)
   #If debugging = 1 Then
      Debug.Print lpString
   #End If
   'Turn off debugging
'''   Dim ts As TextStream
'''   Set ts = fso.OpenTextFile(App.path & "\PlayDesc.txt", ForAppending, True, TristateTrue)
'''   ts.WriteLine lpString
'''   ts.Close
End Sub
Public Sub DownloadFromLocalNetwork(Destination As String, URL As String)
   On Error GoTo ErrorDownloading
      Dim tempSaveImage As String
      Dim bDone As Boolean
      Dim tempArray() As Byte
      Dim vtData As String
      Dim fileNumber As Integer
      Dim fileNumSource As String
      Dim Foldername As String

      'Start downloading image from local network
      If isFileExist(URL) Then
         destinationDirectory = Destination
         Foldername = fso.GetParentFolderName(destinationDirectory)
         CreateDirectory Foldername
         
         tempSaveImage = fso.BuildPath(GetWinTempPath, "folder.jpg")
         DeleteFile tempSaveImage
         fileNumber = FreeFile
         Open tempSaveImage For Binary As fileNumber         'save to temporary folder
         fileNumSource = FreeFile
         Open URL For Binary Access Read As fileNumSource                'open source directory
         bDone = False
         Do
            If (Seek(fileNumber) + MAX_READ) < LOF(fileNumSource) Then
               vtData = String(MAX_READ, Chr(0))
            Else
               vtData = String(LOF(fileNumSource) - Seek(fileNumber) + 1, Chr(0))
               bDone = True
            End If
            Get fileNumSource, , vtData
            Put fileNumber, , vtData
            DoEvents
         Loop Until bExitingProgram Or bDone
         Close fileNumber
         Close fileNumSource
         'check_image_metric_and_save_as_JPG destinationDirectory, destinationDirectory
         'else it will cause error while exit the soft with GDI+
         If Not bExitingProgram Then
            FrmMain.check_image_metric_and_save_as_JPG tempSaveImage, destinationDirectory
            FrmMain.CloseDownloading AlbumIDDownLoadImage, destinationDirectory, LanDownloadImage
         Else
            DeleteFile destinationDirectory
         End If
      Else
'''         Completing = True
      End If
   Exit Sub
ErrorDownloading:
   Close fileNumber
   Close fileNumSource
''''   Completing = True
   WriteEvent "DownloadFromLocalNetwork", Err.Description, Err.Source
End Sub

Public Function getDownloadURL(mFile As cFile) As cFile
   On Error GoTo Error
   Dim stSpl() As String
   Dim URL As String
   Dim NumCd As String
   Dim ASIN As String
   Dim Lan As String
   Dim AlbumID As Long
   Dim iSlyCoverArt As Integer
   Dim iCoverArtType As EnumCovertArtType
   Dim ToDirectory As String
   Dim strArr As String
   Dim imageServer As String
   Dim boolIsBackAlbum As Boolean
   Dim ThreeLast As String
   Dim bDownloadFromLocal As Boolean
   Dim lpFields As Variant
   Dim sCoverName As String
   Dim LanguagePosition As Long
   

   stSpl = Split(mFile.data2, "%~%")
   ToDirectory = stSpl(0)                             'Destination direcotry
   Lan = stSpl(2)                                     'Language downloading
   AlbumID = val(stSpl(1))                            'AlbumID downloading
   
   If (Not isFileExist(ToDirectory)) And (ToDirectory <> "") Then
      boolIsBackAlbum = (StrComp(fso.GetFileName(ToDirectory), BackCoverName, vbTextCompare) = 0)          'if back pic
      If CWinsock.LoggedType <> ServerMode And run_bServerImageFolderExist Then       'force to download from localnetwork if connected and the folder exists
         bDownloadFromLocal = True
         imageServer = "\\" & CWinsock.getRemoteHostIP("")
      Else
         bDownloadFromLocal = False
         imageServer = getLanguageServer(Lan).imageServer
      End If
      If mFile.DownloadType = DL_ARTIST Then
   
          strArr = left(stSpl(1), Len(stSpl(1)) - 10)
          strArr = ReturnStringSymbol(strArr)
          strArr = Replace(strArr, "\", "/")
          URL = imageServer & "/" & SlyGuideFolder & "/" + ReturnStringSymbol(Lan) + "/" + strArr + DVDCoverName
          URL = LCase(URL)
      Else
          lpFields = (GetAlbumFields(AlbumID, Lan, "slycoverart", "coverType"))
          If IsEmpty(lpFields) Then GoTo COMPLETE
          iSlyCoverArt = lpFields(0)
          iCoverArtType = val(lpFields(1))
          If iSlyCoverArt = 1 Or bDownloadFromLocal Then
            LanguagePosition = InStr(1, ToDirectory, Lan, vbTextCompare)
            If LanguagePosition > 0 Then
               strArr = mID(ToDirectory, LanguagePosition)
               'strArr = LCase(left(strArr, Len(strArr) - IIf(boolIsBackAlbum, 8, 10)))
               strArr = fso.GetParentFolderName(strArr)
               If Not bDownloadFromLocal Then
                  strArr = Replace(strArr, "\", "/")
                  strArr = ReturnStringSymbol(strArr)
               End If
               If bDownloadFromLocal Then
                  sCoverName = DVDCoverName           'From local only download the folder.jpg
               Else
                  If iCoverArtType = CoverBlurary Then
                     sCoverName = BlurayCoverName
                  ElseIf iCoverArtType = CoverHDDVD Then
                     sCoverName = HDDVDCoverName
                  Else
                     sCoverName = DVDCoverName
                  End If
               End If
               'Download the Cover for the specified Video Type like , DVD; HDDVD; Bluray
               If bDownloadFromLocal Then
                  URL = fso.BuildPath(imageServer & "\" & SlyGuideFolder & "\" + strArr, IIf(boolIsBackAlbum, BackCoverName, sCoverName))
               Else
                  URL = fso.BuildPath(imageServer & "\dvds\" + strArr, IIf(boolIsBackAlbum, BackCoverName, sCoverName))
               End If
            Else
               URL = vbNullString
            End If
          ElseIf iSlyCoverArt = 0 Then
             If InStr(1, Lan, "Chinese", vbTextCompare) > 0 Then
                  ASIN = GetAlbumField(AlbumID, , Lan)
                  If ASIN <> "" Then
                      URL = "http://i3.yesasia.com/assets/imgs/music/" + right(ASIN, 2) + "/l_p" + ASIN + ".jpg"
                  End If
             ElseIf InStr(1, Lan, "Japanese", vbTextCompare) Then
                  NumCd = GetAlbumField(AlbumID, "NumCD", Lan)
                  If NumCd = "1" Then
                      NumCd = ".09."
                  Else
                      NumCd = ".01."
                  End If
                  ASIN = GetAlbumField(AlbumID, "BuyCom", Lan)
                  If ASIN <> "" Then
                      ASIN = ASIN & NumCd
                      URL = "http://images-jp.amazon.com/images/P/" + ASIN + "LZZZZZZZ.jpg"
                  End If
             Else
                  ASIN = GetAlbumField(AlbumID, "DVDEmpire", Lan)
                  If ASIN <> "" Then
                     '"http://images.dvdempire.com/gen/movies/" & ASIN & "h.jpg"
                     If boolIsBackAlbum Then
                        'back album pic
                        URL = "http://images.dvdempire.com/gen/movies/" & ASIN & "bh.jpg"
                     Else
                        'cover art
                        URL = "http://images.dvdempire.com/gen/movies/" & ASIN & "h.jpg"
                     End If
                  Else
                     ASIN = GetAlbumField(AlbumID, , Lan)
                     If ASIN <> "" Then         'Default to Amazon
                        URL = "http://images.amazon.com/images/P/" + ASIN + ".01.LZZZZZZZ.jpg"
                     Else                       'If there is no image on amazon goto BuyCom
                        ASIN = GetAlbumField(AlbumID, "BuyCom", Lan)
                        If ASIN <> "" Then
                           ThreeLast = right(ASIN, 3)
                           URL = "http://ak.buy.com/db_assets/large_images/" & ThreeLast & "/" & ASIN & ".jpg"
                        End If
                     End If
                  End If
             End If
            
          ElseIf iSlyCoverArt = 2 Then
          End If
      End If
      
      mFile.LocalDownload = bDownloadFromLocal
      mFile.URL = URL
      mFile.AlbumID = AlbumID
      mFile.Language = Lan
      
      'Debug.Print "url <> """
      If URL <> "" Then

'''         AlbumIDDownLoadImage = AlbumID
'''         LanDownloadImage = Lan
'''         If bDownloadFromLocal Then
'''            'Download from server that shared "DVDs"
'''            DownloadFromLocalNetwork ToDirectory, url
'''         Else
'''            FrmMain.DownloadFile ToDirectory, url
'''         End If
            
      Else
'''         Completing = True
      End If
      
   Else
'''       Completing = True
   End If
  
COMPLETE:


   Set getDownloadURL = mFile           'return the URL back
''''   Downloading = True
   Exit Function
Error:
   WriteEvent "getDownloadURL", Err.Description, Err.Source
End Function

Function display_track_list_type(val_Type As String) As String
    If val_Type = 1 Then
        display_track_list_type = "ListBar"
    Else
        display_track_list_type = "TrackBar"
    End If
End Function

Public Function GetWinMode() As String
   On Error GoTo Error
      Dim mode1 As String
      Set xmlPlaylist = New DOMDocument
      xmlPlaylist.Load MainSettingXML
      Set xmlPlaylistRoot = xmlPlaylist.firstChild
      mode1 = xmlPlaylistRoot.childNodes(0).Attributes(26).Text
      If mode1 = "Window Mode" Then
         GetWinMode = "WinMode"
      Else
         GetWinMode = "FullMode"
      End If
   Exit Function
Error:
   WriteEvent "GetWinMode", Err.Description, Err.Source
End Function


