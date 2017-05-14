Attribute VB_Name = "Collections"
Option Explicit

Private Declare Function GetFileTime Lib "kernel32" (ByVal hFile As Long, lpCreationTime As FileTime, lpLastAccessTime As FileTime, lpLastWriteTime As FileTime) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function CompareFileTime Lib "kernel32" (lpFileTime1 As FileTime, lpFileTime2 As FileTime) As Long
Private Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, ByVal lpSecurityAttributes As Long, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long

Private Const OPEN_EXISTING = 3
Private Const GENERIC_READ = &H80000000
Private Const OPEN_ALWAYS = 4
Private Const FILE_ATTRIBUTE_NORMAL = &H80
Private Const GENERIC_WRITE = &H40000000
Private Const INVALID_HANDLE = -1

Private objVariable As New Collection
Public objVDResize As New Collection
'=======================MainTitle==============================================
Public Const DVD_SECTOR = 2048
Public Const DVD_MAX_TITLES = 99
Type typeWORD       '2 byte
   FirstLong(0 To 1) As Byte
End Type
Type typeDWORD      '4 byte
   FirstLong(0 To 3) As Byte
End Type
'// Title Map.
Public Type titleInfo_t
   types As Byte
   numberOfAngles As Byte
   numberOfChaptersWORD As typeWORD
   parentalManagementMask As Integer
   videoTitleSet As Byte
   titleNumber As Byte
   titleSetSector As Long        ';         // Starting sector of a VTS on disc.
End Type
'=======================MainTitle==============================================

'For convert with winsock=======================================================================
Public Type BytesType
   ByteStr(1) As Byte
End Type
Public Type IntergerType
   IntergerVal As Integer
End Type
Public Type CommandType
   Commands As WinsockDownloadEnum
   DataLength As Integer
End Type
'=======================================================================
Private Type FileTime
   dwLowDateTime As Long
   dwHighDateTime As Long
End Type

Public Type CountryType
   Name As String
   path As String
   Image As String
   ID As Integer
   Text As String
   key As String
End Type

'download soft
Public Type DownloadType
   sourceURL As String
   targetPath As String
   targetName As String
End Type
Public Type LanguageType
   Name As String
   path As String
   website As String

End Type
'backup type
Public Type BackupHeaderType
   tableName As String
   fieldNames() As Variant
   FieldData() As Variant
End Type
'link path type
Public Type ServerLinkType
    countryName As String
    imageServer As String
    dbServer As String
End Type
Public Type ServerAdsScreenType
    adsServer As String
    screenServer As String
    website As String
End Type

Public serverLink() As ServerLinkType
Public ServerAdsScreen As ServerAdsScreenType

Public languageServerLink As ServerLinkType
Public downloadSoftData As DownloadType
Public downloadList() As DownloadType
Public downloadIndex As Long
Public boolAllCompleted As Boolean
Public downloadLanguage() As LanguageType
Public lastUpdateDate As String
Public callName As String
Public downloadResultOk As Boolean


' =================Winsock=================================================
   Public CWinsock As New clsWinsock
' =========================================================================

Public Function IsValidDate(filename As String) As Boolean
   On Error GoTo Error
   Dim hFile As Long, fc As FileTime, fa As FileTime, fw As FileTime
   
   hFile = CreateFile(filename, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
   GetFileTime hFile, fc, fa, fw
   CloseHandle hFile
   IsValidDate = (CompareFileTime(fc, fw) <> 1) And (hFile <> INVALID_HANDLE)
   Exit Function
Error:
   WriteEvent "IsValidDate", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   AddCountryFromXml
' Description       :   Add country from the language.xml path
' Return Values     :   Boolean
' Input Parameter   :   language.mxl path
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-22-2005           New
'*******************************************************************************
Public Function AddCountryFromXml(xmlPath As String) As Boolean
   On Error GoTo Error
   'language xml structure
   '<Languages SetLan="KhmerKaraoke" Name="Khmer Karaoke" DatabaseType="8">
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlDocCountry As New DOMDocument
   
   Dim loc_LanguageID As String
   Dim loc_LanguageName As String
   Dim loc_DatabaseType As String
   Dim loc_CountryPath As String
   Dim i As Integer
   
   XmlDoc.Load xmlPath & "\Language.xml"
   If XmlDoc.parseError.errorCode = 0 Then
      Set xmlRoot = XmlDoc.firstChild
      loc_LanguageID = xmlRoot.getAttribute("SetLan")
      loc_LanguageName = xmlRoot.getAttribute("Name")
      loc_DatabaseType = xmlRoot.getAttribute("databaseType")
      
      loc_CountryPath = App.path & "\sly\Countries.xml"
      XmlDoc.Load loc_CountryPath
      If XmlDoc.parseError.errorCode = 0 Then
         Set xmlRoot = XmlDoc.firstChild
         For i = 0 To xmlRoot.childNodes.Length - 1
             If xmlRoot.childNodes(i).Text = loc_LanguageID Then
                 Exit Function
             End If
         Next i
         AddNewCountry loc_CountryPath, xmlPath, xmlPath, loc_LanguageName, loc_LanguageID, loc_DatabaseType
         AddCountryFromXml = True
      End If
   End If
   Exit Function
Error:
   WriteEvent "AddCountryFromXml", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   AddNewCountry
' Description       :   Add new country from to Contries.xml
' Return Values     :   Boolean
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-21-2005           Seng(2005-10-22)
'*******************************************************************************

Public Function AddNewCountry(PathCountry As String, PathDatabase As String, PathImage As String, languageName As String, LanguageID As String, dbType As String) As Boolean
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlName As IXMLDOMElement
   
   XmlDoc.Load PathCountry                                           'open xml
   Set xmlName = XmlDoc.createElement("Country")
   xmlName.setAttribute "Name", languageName                         'The name that display in country page
   xmlName.setAttribute "Path", PathDatabase                         'path of database
   xmlName.setAttribute "imagePath", PathImage                       'path of image
   xmlName.setAttribute "databaseType", dbType                       'databse type
   xmlName.Text = LanguageID                                         'id for identify each country
   
   XmlDoc.firstChild.appendChild xmlName                             'append child
   XmlDoc.Save PathCountry                                           'save
   Exit Function
Error:
   WriteEvent "AddNewCountry", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   DeleteCountry
' Description       :   Add delete country from to Contries.xml
' Return Values     :   Boolean
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             05-18-2006           Seng(2006-05-18)
'*******************************************************************************
Public Function DeleteCountry(PathCountry As String, LanguageID As String) As Boolean
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlName As IXMLDOMElement
   
   XmlDoc.Load PathCountry                                           'open xml
   If XmlDoc.parseError = 0 Then
      Set xmlRoot = XmlDoc.firstChild
      For Each xmlName In xmlRoot.childNodes
         If StrComp(xmlName.Text, LanguageID, vbTextCompare) = 0 Then
            xmlRoot.removeChild xmlName
            XmlDoc.Save PathCountry                                           'save
            Exit For
         End If
      Next
   End If
   Exit Function
Error:
   WriteEvent "DeleteCountry", Err.Description, Err.Source
End Function
Public Sub AddNewApplication(path As String, strPath As String, strImgPath As String, strName As String)
    Dim xmlApplication As New DOMDocument
    Dim xmlCountryRoot As IXMLDOMElement
    Dim xmlAppElement As IXMLDOMElement

   '<Applications><Application Path='dfdsdf' imagePath="fdsdfsfds" Default="sfdafdsf">Sly multimedia</Application></Applications>
   xmlApplication.Load path
   If xmlApplication.parseError = 0 Then
      Set xmlAppElement = xmlApplication.createElement("Application")
      xmlAppElement.Text = strName
      xmlAppElement.setAttribute "Default", strName
      xmlAppElement.setAttribute "imagePath", App.path & "Sly\" & strImgPath
      xmlAppElement.setAttribute "Path", strPath
      xmlApplication.firstChild.appendChild xmlAppElement
      xmlApplication.Save path
   End If
End Sub
Public Sub AddNewFile(path As String, strPath As String, strImgPath As String, strCountry As String, strElement As String, Optional strLastUpdate As String = "")
   On Error GoTo Error
    Dim xmlCountry As DOMDocument
    Dim xmlCountryRoot As IXMLDOMElement
    Dim xmlCountryName As IXMLDOMElement

    Set xmlCountry = New DOMDocument
    
   '---------------Load xml from downloaded language xml
   Dim xmlLanguage As New DOMDocument
   Dim xmlLanRoot As IXMLDOMElement
   Dim loc_Name As String
   Dim loc_dbType As String
   Dim loc_Key As String
   Dim loc_Text As String

    xmlLanguage.Load strPath & "\Language.xml"
    If xmlLanguage.parseError = 0 Then
      Set xmlLanRoot = xmlLanguage.firstChild
      loc_Name = xmlLanRoot.getAttribute("SetLan")
      loc_dbType = xmlLanRoot.getAttribute("databaseType")
      loc_Key = xmlLanRoot.getAttribute("Key")
      loc_Text = xmlLanRoot.getAttribute("Name")
      
      xmlCountry.Load path
      If xmlCountry.parseError = 0 Then
         Set xmlCountryRoot = xmlCountry.firstChild
         Set xmlCountryName = xmlCountry.createElement(strElement)
         xmlCountryName.setAttribute "Name", loc_Text
         xmlCountryName.setAttribute "Path", strPath
         xmlCountryName.setAttribute "imagePath", strImgPath
         xmlCountryName.setAttribute "databaseType", loc_dbType
         xmlCountryName.setAttribute "Key", loc_Key
         xmlCountryName.Text = loc_Name
         
         xmlLanguage.Load strPath & "\Language.xml"
         
         
         
         
         If strLastUpdate <> "" Then xmlCountryName.setAttribute "lastUpdateDB", strLastUpdate
         
         xmlCountryName.Text = strCountry
         xmlCountryRoot.appendChild xmlCountryName
                 
         xmlCountry.Save path
      End If
   End If

   Exit Sub
Error:
   WriteEvent "AddNewFile", Err.Description, Err.Source
End Sub
Public Sub ReadServerLink(path As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim currentElement As ServerLinkType
   Dim countIndex As Long

   XmlDoc.Load path
   Erase serverLink
   Set xmlRoot = XmlDoc.firstChild
   If xmlRoot.childNodes.Length > 0 Then
      ReDim Preserve serverLink(xmlRoot.childNodes.Length - 1)
      ServerAdsScreen.adsServer = xmlRoot.getAttribute("adsServer")
      ServerAdsScreen.screenServer = xmlRoot.getAttribute("screenServer")
      ServerAdsScreen.website = xmlRoot.getAttribute("webSite")
      For Each xmlElement In xmlRoot.childNodes
          currentElement.countryName = xmlElement.getAttribute("countryName")
          currentElement.dbServer = xmlElement.getAttribute("dbServer")
          currentElement.imageServer = xmlElement.getAttribute("imageServer")
          serverLink(countIndex) = currentElement
          countIndex = countIndex + 1
      Next
    End If
   Exit Sub
Error:
   Writelog "ReadServerLink", "ERROR", Err.Description, "path = " & path
   'WriteEvent "ReadServerLink", Err.Description, Err.Source
End Sub
Public Sub EditServerLinkAdsAndScreen(path As String, attributeString As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim currentElement As ServerLinkType
   Dim countIndex As Long
   Dim Attributes() As String
   
   XmlDoc.Load path
   Set xmlRoot = XmlDoc.firstChild
   Attributes = Split(attributeString, de_Field)
   xmlRoot.setAttribute "adsServer", Attributes(0)
   xmlRoot.setAttribute "screenServer", Attributes(1)
   XmlDoc.Save path
   Exit Sub
Error:
   WriteEvent "EditServerLinkAdsAndScreen", Err.Description, Err.Source
End Sub
Public Property Get GetCDXmlPath() As String
   GetCDXmlPath = App.path & "\sly\cdxml.xml"
End Property

Public Function getXMLAtribute(xml As IXMLDOMElement, attributeName As String) As String
On Error GoTo Errors:
   getXMLAtribute = xml.getAttribute(attributeName)
Errors:
End Function
Public Function Add_New_Server(remoteName As String, remoteDes As String, Optional remoteIP As String) As Boolean
   On Error GoTo Errors:
   Dim i As Integer
   Dim xmlCountry As DOMDocument
   Dim xmlCountryRoot As IXMLDOMElement
   Dim xmlCountryName As IXMLDOMElement
   Dim xmlnode As IXMLDOMNode
   Dim sName As String
   Dim sDesc As String
   Dim sIP As String
   
   If LCase(remoteIP) <> LCase(ComputerIP) Then
      Set xmlCountry = New DOMDocument
      xmlCountry.Load App.path & "\sly\Server.xml"
      Set xmlCountryRoot = xmlCountry.firstChild
      If Not xmlCountryRoot Is Nothing Then
         For i = 0 To xmlCountryRoot.childNodes.Length - 1
            Set xmlCountryName = xmlCountryRoot.childNodes.item(i)
            sName = xmlCountryName.Text
            sDesc = xmlCountryName.getAttribute("nick_name")
            'sIP = xmlCountryName.getAttribute("ip")
            If remoteIP <> "" Then
               sIP = getXMLAtribute(xmlCountryName, "ip")
               If LCase(sName) = LCase(remoteName) And LCase(sIP) = LCase(remoteIP) Then
                  Exit Function
               End If
            End If
         Next
      End If
   
       Set xmlCountryName = xmlCountry.createElement("Server")
       xmlCountryName.setAttribute "imagePath", "Computer.sly"
       xmlCountryName.setAttribute "nick_name", remoteDes
       xmlCountryName.setAttribute "ip", remoteIP
       xmlCountryName.Text = remoteName
       xmlCountryRoot.appendChild xmlCountryName
       
       xmlCountry.Save App.path & "\sly\Server.xml"
       
       'sendToFlash Swf(1), "new_server", "success"
       'sendVariable2Flash Swf(1), "openServer", App.path & "\Sly"
       Add_New_Server = True
   Else
       Add_New_Server = False
   End If
Errors:

End Function


Public Sub AddServerLink(path As String, attributeString As String)
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim currentElement As ServerLinkType
   Dim countIndex As Long
   Dim Attributes() As String
   
   XmlDoc.Load path
   Attributes = Split(attributeString, de_Field)
   Set xmlElement = XmlDoc.selectSingleNode("CDXML/Country[@countryName = '" & Attributes(0) & "']")
   If xmlElement Is Nothing Then
      Set xmlRoot = XmlDoc.firstChild
      Set xmlElement = XmlDoc.createElement("Country")
      xmlRoot.appendChild xmlElement
   End If
   xmlElement.setAttribute "countryName", Attributes(0)
   xmlElement.setAttribute "dbServer", Attributes(1)
   xmlElement.setAttribute "imageServer", Attributes(2)
   XmlDoc.Save path
   ReadServerLink path
   Exit Sub
Error:
   WriteEvent "AddServerLink", Err.Description, Err.Source
End Sub

Public Sub RemoveServerLink(path As String, languageName As String)
   On Error GoTo Error
    Dim XmlDoc As New DOMDocument
    Dim xmlRoot As IXMLDOMElement
    Dim xmlElement As IXMLDOMElement
    Dim currentElement As ServerLinkType
    Dim countIndex As Long
    Dim countryName As String

    XmlDoc.Load path
    Erase serverLink
    Set xmlRoot = XmlDoc.firstChild
    If xmlRoot.childNodes.Length > 0 Then
      ReDim Preserve serverLink(xmlRoot.childNodes.Length - 1)
      For Each xmlElement In xmlRoot.childNodes
          countryName = xmlElement.getAttribute("countryName")
          If StrComp(countryName, languageName, vbTextCompare) = 0 Then
            xmlRoot.removeChild xmlElement
            Exit For
          End If
      Next
    End If
    XmlDoc.Save path
   Exit Sub
Error:
   WriteEvent "RemoveServerLink", Err.Description, Err.Source
End Sub

Public Function getLanguageServer(languageName As String) As ServerLinkType
   On Error GoTo ErrorBound:
   Dim i As Long
   For i = 0 To UBound(serverLink)
      If StrComp(serverLink(i).countryName, languageName, vbTextCompare) = 0 Then
         getLanguageServer = serverLink(i)
         Exit For
      End If
   Next
ErrorBound:
End Function
Public Sub RemoveFile(path As String, Index As Long)
   On Error GoTo Error
    Dim xdoc As IXMLDOMElement
    Dim doc As DOMDocument
    Set doc = New DOMDocument
    doc.Load path
    Set xdoc = doc.firstChild
    xdoc.removeChild xdoc.childNodes(val(Index))
    doc.Save path
   Exit Sub
Error:
   WriteEvent "RemoveFile", Err.Description, Err.Source
End Sub

Public Sub EditFile(path As String, Index As Long, Name As String, Value As String)
   On Error GoTo Error
    Dim xdoc As IXMLDOMElement
    Dim doc As DOMDocument
    Set doc = New DOMDocument
    doc.Load path
    Set xdoc = doc.childNodes(0).childNodes(Index)
    xdoc.setAttribute Name, Value
    doc.Save path
   Exit Sub
Error:
   WriteEvent "EditFile", Err.Description, Err.Source
End Sub

Public Sub EditName(path As String, Index As Long, Value As String)
   On Error GoTo Error
    Dim xdoc As IXMLDOMElement
    Dim doc As DOMDocument
    Set doc = New DOMDocument
    doc.Load path
    Set xdoc = doc.childNodes(0).childNodes(Index)
    xdoc.childNodes(0).nodeValue = Value
    doc.Save path
   Exit Sub
Error:
   WriteEvent "EditName", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   DownloadLocalNetwork
' Description       :   Download database from local network server
' Return Values     :   Boolean(Success,Fail)
' Input Parameter   :   Language,Source(NetworkPath)
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             07-14-2006           New     'Copy 10 files
'*******************************************************************************

Public Function DownloadLocalNetwork(argLanguage As String, argNetworkPath As String) As Boolean
On Error GoTo ErrorCopying
   'Steps
   '1:backup database info
   '2:rename original database to *.tbk
   '3:Copy files from server(networkpath) to language database
   '4:restore database info
   '5:if fail then rollback back the original database
   Dim loc_arrayFiles As Variant, i As Integer, bSuccess As Boolean
   Dim loc_Pathname As String
   Dim loc_TempDirectory As String
   Dim loc_DatabaseFolder As String
   Dim loc_TargetFolder As String
   
   loc_TempDirectory = GetWinTempPath
   loc_DatabaseFolder = fso.BuildPath(get_country_path(argLanguage), "database")
   loc_arrayFiles = Array("Actor", "director", "flag", "Genre", "Label", "Movie", "Title", "Track", "TVSeries", "TypeCD")
   
   '1/ backup database info including available,rating,favorite...............
   If BackupDatabaseInfo(loc_DatabaseFolder, loc_TempDirectory) Then
      For i = 0 To UBound(loc_arrayFiles)
         loc_Pathname = fso.BuildPath(argNetworkPath, "Database\" & loc_arrayFiles(i)) & ".tbl"
         If isFileExist(loc_Pathname) Then                             'if the file exist then copy
            loc_TargetFolder = fso.BuildPath(loc_DatabaseFolder, loc_arrayFiles(i))
            '2/ rename from tbl to tbk
            DeleteFile loc_TargetFolder & ".tbk"
            Name loc_TargetFolder & ".tbl" As loc_TargetFolder & ".tbk"
            '3/ Copy files from server(networkpath) to language database
            fso.CopyFile loc_Pathname, loc_TargetFolder & ".tbl", True
            bSuccess = True
         Else
            bSuccess = False
            Exit For
         End If
      Next
                                 '4/ restore database info
      If bSuccess Then bSuccess = RestoreDatabaseInfo(loc_DatabaseFolder, loc_TempDirectory)
      If bSuccess Then
         For i = 0 To UBound(loc_arrayFiles)
            loc_TargetFolder = fso.BuildPath(loc_DatabaseFolder, loc_arrayFiles(i))
            If isFileExist(loc_TargetFolder & ".tbk") Then
               DeleteFile loc_TargetFolder & ".tbk"                  'Delete old database
            End If
         Next
      Else
         '5:if fail then rollback back the original database
         For i = 0 To UBound(loc_arrayFiles)
            loc_TargetFolder = fso.BuildPath(loc_DatabaseFolder, loc_arrayFiles(i))
            If isFileExist(loc_TargetFolder & ".tbk") Then
               Name loc_TargetFolder & ".tbk" As loc_TargetFolder & ".tbl"          'Rollback the orginal database
            End If
         Next
      End If
      DownloadLocalNetwork = bSuccess
   End If
   Exit Function
ErrorCopying:
   DownloadLocalNetwork = False
End Function
Public Sub DownloadLanguages(args As String)
   On Error GoTo Error
   Dim screenArray As Variant
   Dim filearray As Variant
   Dim i As Long, j As Long
   Dim count As Long
   Dim languageList() As String
   Dim langNamePath() As String
   'Dim downloadServer As String
   
   Erase downloadLanguage
   Erase downloadList()
   If args <> "" Then
      count = 0
      languageList = Split(args, de_Record)
      ReDim downloadList(UBound(languageList))
      ReDim downloadLanguage(UBound(languageList))
      sendToFlash FrmMain.Swf(1), "StringDownload", "Downloading..."
      For i = 0 To UBound(languageList)
         langNamePath = Split(languageList(i), de_Field)
         downloadLanguage(i).Name = langNamePath(0)
         downloadLanguage(i).path = langNamePath(1)
         downloadLanguage(i).website = langNamePath(2)
         'downloadServer = langNamePath(2)
         With downloadList(count)
            .targetName = LCase(langNamePath(0) + ".rar")
            '.targetName = LCase(.targetName)
            '.sourceURL = SlyServer + "/cds/" + LCase(langNamePath(0)) + "/" + .targetName
            .sourceURL = langNamePath(2) + "/dvds/" + ReturnStringSymbol(langNamePath(0)) + "/" + Replace(.targetName, " ", "_")
            .targetPath = langNamePath(1)
            '.targetPath = "C:\Sly"
         End With
         count = count + 1
      Next
      downloadIndex = 0
      callName = "Languages"
      FrmMain.Completed1Download
   End If
   Exit Sub
Error:
   WriteEvent "DownloadLanguages", Err.Description, Err.Source
End Sub
Public Sub DownloadAds(args As String, adsPath As String)
   On Error GoTo Error
   Dim screenArray As Variant
   Dim filearray As Variant
   Dim i As Long, j As Long
   Dim count As Long
   Dim adsList() As String
   
   Erase downloadList()
   If args <> "" Then
      count = 0
      adsList = Split(args, de_Record)
      ReDim downloadList(UBound(adsList))

      For i = 0 To UBound(adsList)
         With downloadList(count)
            .targetName = LCase(adsList(i))
            .sourceURL = ServerAdsScreen.adsServer + "/dvds/browse/" + .targetName
            .targetPath = adsPath
         End With
         count = count + 1
      Next
      downloadIndex = 0
      callName = "AdsDownloaded"
      FrmMain.Completed1Download
   End If
   Exit Sub
Error:
   WriteEvent "DownloadAds", Err.Description, Err.Source
End Sub


Public Sub DownloadUpdateDatabase(LangName As String, updateFile As Boolean)
   On Error GoTo Error
   'args="English||C:\DVDs\English"
   'LangName="Khmer Karaoke"
   'updateFile as boolean
   Dim langNamePath() As String
   Dim ReplacedName As String
   
   Erase downloadLanguage
   ReDim downloadList(0)
   ReplacedName = Replace(LangName, " ", "_")
   With downloadList(0)
      If updateFile = True Then
         .targetName = LCase("upd_" + ReplacedName + ".rar")
         callName = "UpdateDownloaded"       'Function Name called when update downloaded
      Else
                             
         .targetName = LCase(ReplacedName + ".rar")
         callName = "DatabaseDownloaded"     'Function Name called when database downloaded
      End If
                                                                        'Replace " " with "_"
      .sourceURL = LCase(languageServerLink.dbServer + "/dvds/" + ReplacedName + "/" + .targetName)
      .targetPath = get_country_path(currentCountry)
   End With
   downloadIndex = 0

   FrmMain.Completed1Download
   Exit Sub
Error:
   WriteEvent "DownloadUpdateDatabase", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   BackupDatabaseInfo
' Description       :
' Return Values     :
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng                                    07-14-2006
'*******************************************************************************

Public Function BackupDatabaseInfo(path As String, saveTo As String) As Boolean
On Error GoTo ErrorBackup
   Dim tblSource As New TableCls
   Dim newFile() As BackupHeaderType
   Dim fieldList() As Variant
   Dim recordData() As Variant
   Dim i As Long, j As Long, k As Long
   Dim freeHandle As Integer
   Dim savedata() As BackupHeaderType
   
   'initialize the data
      ReDim savedata(2)
      savedata(0).tableName = "Track"
      savedata(0).fieldNames = Array("ID", "Rating", "Available", "Path", "NumPlay", "SeekOffset", "ZoomLevel")
      savedata(1).tableName = "Actor"
      savedata(1).fieldNames = Array("ID", "Rating", "Favorite")
      savedata(2).tableName = "Movie"
      savedata(2).fieldNames = Array("ID", "Rating", "Rank", "Available", "Favorite", "Path", "PathSmall", "PathMedium", "PathTrailer", "BlankTop", "BlankBottom", "MainTitle", "AudioKaraoke")
   'end initialize
   
   freeHandle = FreeFile
   DeleteFile fso.BuildPath(saveTo, "bak.tmp")
   Open fso.BuildPath(saveTo, "bak.tmp") For Binary As freeHandle
      SetDirectory path
      ReDim newFile(UBound(savedata))
      With tblSource
         For k = 0 To UBound(savedata)
            .Opens savedata(k).tableName
               fieldList = savedata(k).fieldNames
               newFile(k).fieldNames = fieldList
               newFile(k).tableName = savedata(k).tableName
               ReDim recordData(UBound(fieldList))
               ReDim newFile(k).FieldData(-1 To .RecordCount - 1)
               
               For i = 0 To .RecordCount - 1
                  DoEvents
                  For j = 0 To UBound(fieldList)
                     recordData(j) = .AbsoluteField(i, fieldList(j))
                  Next
                  newFile(k).FieldData(i) = recordData
               Next
            .Closes
            Set tblSource = Nothing
         Next
         Put freeHandle, , newFile
      End With
   Close freeHandle
   BackupDatabaseInfo = True
   Exit Function
ErrorBackup:
   BackupDatabaseInfo = False
End Function
'*******************************************************************************
' Function Name     :   RestoreDatabaseInfo
' Description       :
' Return Values     :
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng                                    07-14-2006
'*******************************************************************************
Public Function RestoreDatabaseInfo(path As String, openFrom As String) As Boolean
   On Error GoTo ErrorRestore
   Dim tblSource As New TableCls
   Dim newFile() As BackupHeaderType
   Dim fieldList() As Variant
   Dim fieldIndex() As Integer
   Dim fieldIndexBool() As Boolean           'True reset value
   Dim recordData() As Variant
   Dim i As Long, j As Long, k As Long
   Dim freeHandle As Integer
   Dim seekIndex As Long
   Dim seekID As Long
   
   freeHandle = FreeFile
   ReDim newFile(2)
   Open fso.BuildPath(openFrom, "bak.tmp") For Binary As freeHandle
      Get freeHandle, , newFile
      SetDirectory path
      With tblSource
         For k = 0 To UBound(newFile)
            .Opens newFile(k).tableName
               fieldList = newFile(k).fieldNames
               ReDim fieldIndex(UBound(fieldList))
               ReDim fieldIndexBool(UBound(fieldList))
               For j = 0 To UBound(fieldList)
                  fieldIndex(j) = .FieldToIndex(fieldList(j))
                  Select Case LCase(newFile(k).tableName)
                     Case "track"
                        Select Case LCase(fieldList(j))
                           Case "available", "path"
                              fieldIndexBool(j) = True
                        End Select
                     Case "movie"
                        Select Case LCase(fieldList(j))
                           Case "available", "path", "pathsmall", "pathmedium", "pathtrailer"
                              fieldIndexBool(j) = True
                        End Select
                  End Select
               Next
               For i = 0 To .RecordCount - 1
                  DoEvents
                  For j = 1 To UBound(fieldList)
                     If fieldIndexBool(j) = True Then
                        If .FIELDTYPE(fieldIndex(j)) = myInteger Or .FIELDTYPE(fieldIndex(j)) = MyLong Then
                           .AbsoluteEdit(i, fieldIndex(j)) = 0
                        Else
                           .AbsoluteEdit(i, fieldIndex(j)) = ""
                        End If
                     End If
                  Next
               Next
               For i = 0 To UBound(newFile(k).FieldData)
                  DoEvents
                  seekID = newFile(k).FieldData(i)(0)
                  seekIndex = .Seeks(seekID)
                  If seekIndex >= 0 Then
                     For j = 1 To UBound(fieldList)
                        .AbsoluteEdit(i, fieldIndex(j)) = newFile(k).FieldData(i)(j)
                     Next
                  End If
               Next
            .Closes
         Next
      End With
   Close freeHandle
   RestoreDatabaseInfo = True
   Exit Function
ErrorRestore:
   RestoreDatabaseInfo = False
End Function

Public Sub ExtractPackagedDatabase(openFrom As String, toPath As String)
   Unrars openFrom, toPath, "Database\"
End Sub
Public Sub DownloadScreen(args As String)
   On Error GoTo Error
   Dim screenArray() As String
   Dim filearray As Variant
   Dim i As Long, j As Long
   Dim count As Long
   'screenArray = Array("WSS", "WS", "WSM", "WSH", "WSL", "NS")
   filearray = Array("AddApplication", "AddCountry", "Application", "Country", "Encode", "Fullscreen", "InterfaceCD", "Loading", "Option", "PlayListPage", "PlayListPlayer", "Scan", "SearchPage", "SlideShow")
   screenArray = Split(args, ",")
   Erase downloadList()
   For i = 0 To UBound(screenArray)
      'If Dir(App.path + "\Sly\*" & screenArray(i) + ".sly") = "" Then
         For j = 0 To UBound(filearray)
            ReDim Preserve downloadList(count)
            downloadList(count).targetName = filearray(j) + screenArray(i) + ".sly"
            downloadList(count).targetName = LCase(downloadList(count).targetName)
            ' downloadList(count).sourceURL = SlyServer + "/cds/screen/" + (downloadList(count).targetName)
            downloadList(count).sourceURL = ServerAdsScreen.screenServer + "/dvds/screen/" + (downloadList(count).targetName)
            'command to test.........
            downloadList(count).targetPath = App.path + "\Sly"
            'display Processing.............
   '               #If debugging = 1 Then
   '                  downloadList(count).targetPath = "C:\Sly"
   '               #End If
            count = count + 1
         Next
      'End If
   Next
   downloadIndex = 0
   callName = "Screens"
   FrmMain.Completed1Download
   Exit Sub
Error:
   WriteEvent "DownloadScreen", Err.Description, Err.Source
End Sub
 Sub StartBackUp()
   RestoreDatabaseInfo "C:\CDs\English\Database", "C:\a.bak"
 End Sub
 Function getDownloadDate(stringDate As String) As Date
   On Error GoTo Error
   Dim newSDate As String
   'format is "Tue, 06 Jul 2004 12:39:55 GMT"
   If stringDate <> "" Then
      newSDate = mID(stringDate, 6, Len(stringDate) - 9)
      getDownloadDate = Format(CDate(newSDate), "mm/dd/yyyy")
   End If
   Exit Function
Error:
   WriteEvent "getDownloadDate", Err.Description, Err.Source
 End Function
Public Function ChangeFileExtension(inputFile As String, newExtension As String) As String
   On Error GoTo Error
   Dim extensionPosition As Long
   extensionPosition = InStrRev(inputFile, ".")
   ChangeFileExtension = left(inputFile, extensionPosition) + newExtension
   Exit Function
Error:
   WriteEvent "ChangeFileExtension", Err.Description, Err.Source
End Function

Public Sub add_new_element(path As String, strSidePath As String, strImgPath As String, strPlaylistName As String, strElement As String)
   On Error GoTo Error
    Dim xmlPlaylist As DOMDocument
    Dim xmlPlaylistRoot As IXMLDOMElement
    Dim xmlPlaylistName As IXMLDOMElement

    Set xmlPlaylist = New DOMDocument
    xmlPlaylist.Load path
    Set xmlPlaylistRoot = xmlPlaylist.firstChild
    Set xmlPlaylistName = xmlPlaylist.createElement(strElement)
    xmlPlaylistName.setAttribute "SlidePath", strSidePath
    xmlPlaylistName.setAttribute "ImgPath", strImgPath

    xmlPlaylistName.Text = strPlaylistName
    xmlPlaylistRoot.appendChild xmlPlaylistName

    xmlPlaylist.Save path
   Exit Sub
Error:
   WriteEvent "add_new_element", Err.Description, Err.Source
End Sub

Public Sub save_as_JPG(filename As String, destinationfileName As String, Optional swidth As Integer)
   On Error GoTo Error
   Dim picWidth As Integer
   Dim picHeight As Integer
   Dim scaleEdge As Integer
   
   Dim newWidth As Integer
   Dim newHeight As Integer
   Dim scalePercent As Single
   
   With FrmMain.picSource
      .AutoSize = True
      .Picture = LoadPicture(filename)
      picWidth = FrmMain.ScaleX(.Width, FrmMain.ScaleMode, vbPixels)
      picHeight = FrmMain.ScaleX(.Height, FrmMain.ScaleMode, vbPixels)
      If picWidth > picHeight Then scaleEdge = picWidth Else scaleEdge = picHeight
      
      If (scaleEdge > swidth) And (swidth > 0) Then scalePercent = (swidth / scaleEdge) Else scalePercent = 1
      newWidth = picWidth * scalePercent
      newHeight = picHeight * scalePercent
      
      FrmMain.picTarget.Picture = Nothing
      FrmMain.picTarget.Width = FrmMain.ScaleX(newWidth, vbPixels, FrmMain.ScaleMode)
      FrmMain.picTarget.Height = FrmMain.ScaleY(newHeight, vbPixels, FrmMain.ScaleMode)
      FrmMain.picTarget.PaintPicture .Image, 0, 0, newWidth, newHeight, Opcode:=vbSrcCopy
      .Picture = Nothing
      SavePicture FrmMain.picTarget.Image, destinationfileName   'fso.GetParentFolderName(destinationfileName) & "\" & fso.GetBaseName(destinationfileName) & ".jpg"
      create_new_image destinationfileName, destinationfileName
   End With
   Exit Sub
Error:
   'WriteEvent "save_as_JPG", Err.Description, Err.Source
End Sub

' Store sly variable
Public Function getQueryString(inputString As String) As String
   On Error GoTo Error
   '"<Khmer_DB>"
   Dim startBrack As Long, endBrack As Long
   Dim searchPos As Long, queryString As String
   Dim outputString As String
   Dim splitCommand() As String
   Dim languageAndID() As String
   Dim returnToken As String
   searchPos = 0
   outputString = inputString
   Do
      searchPos = InStr(searchPos + 1, inputString, "<")
      If searchPos > 0 Then
         startBrack = searchPos
         searchPos = InStr(searchPos + 1, inputString, ">")
         endBrack = searchPos
         If endBrack > startBrack Then
            queryString = mID(inputString, startBrack + 1, endBrack - startBrack - 1)
            splitCommand = Split(queryString, " ", 2)
            queryString = "<" + queryString + ">"
            If UBound(splitCommand) > 0 And splitCommand(0) = "Path" Or splitCommand(0) = "Name" Then
               languageAndID = Split(splitCommand(1), ",")
               'LanguageAndID         LanguageName,TrackID,AlbumID
               returnToken = GetTrackPath(languageAndID(1), languageAndID(2), languageAndID(0))
               If splitCommand(0) = "Name" Then returnToken = fso.GetFileName(returnToken)
            Else
               returnToken = SlyVariable(queryString)
            End If
            outputString = Replace(outputString, queryString, returnToken, , , vbTextCompare)
         End If
      End If
      
      
   Loop Until searchPos = 0
   getQueryString = outputString
   Exit Function
Error:
   WriteEvent "getQueryString", Err.Description, Err.Source
End Function
'=========================================================================================
Public Property Get VideoVariable(varID As String, varLanguage As String) As String
   On Error GoTo NoVariable:
   Dim strData As String
   strData = "<" & varID & "><" & varLanguage & ">"
   VideoVariable = strData
   VideoVariable = objVDResize.item(strData)
NoVariable:
End Property
Public Property Let VideoVariable(varID As String, varLanguage As String, varValue As String)
   On Error GoTo NoVariable
   Dim Data As Variant
   Dim strData As String
   strData = "<" & varID & "><" & varLanguage & ">"
   Data = objVDResize(strData)
NoVariable:
   If IsEmpty(Data) Then
      objVDResize.Add varValue, strData
   Else
      objVDResize.Remove strData
      objVDResize.Add varValue, strData
   End If
End Property
'=========================================================================================
Public Property Get SlyVariable(varKey As String) As String
   On Error GoTo NoVariable:
   SlyVariable = varKey
   SlyVariable = objVariable.item(varKey)
NoVariable:
End Property
Public Property Let SlyVariable(varKey As String, varValue As String)
   On Error GoTo NoVariable
   Dim Data As Variant
   Data = objVariable(varKey)
NoVariable:
   If IsEmpty(Data) Then
      objVariable.Add varValue, varKey
   Else
      objVariable.Remove varKey
      objVariable.Add varValue, varKey
   End If
End Property
'For winsock==============================================================================
Public Function MakeIntergerStr(inputValue As Integer) As String
   On Error GoTo Error
   'Dim Bytes As BytesType
   'Dim Intergers As IntergerType
   'Intergers.IntergerVal = inputValue
   'LSet Bytes = Intergers
   'MakeIntergerStr = Chr(Bytes.ByteStr(0)) & Chr(Bytes.ByteStr(1))
   MakeIntergerStr = Chr(inputValue Mod 128) & Chr(inputValue \ 128)          'convert to 7 bit integer
   Exit Function
Error:
   WriteEvent "MakeIntergerStr", Err.Description, Err.Source
End Function

Public Function GetInterger(inputStr As String) As Integer
   On Error GoTo Error
   'Dim Bytes As BytesType
   'Dim Intergers As IntergerType
   
   'Bytes.ByteStr(0) = Asc(Mid(inputStr, 1, 1))
   'Bytes.ByteStr(1) = Asc(Mid(inputStr, 2, 1))
   'LSet Intergers = Bytes
   'GetInterger = Intergers.IntergerVal
   GetInterger = Asc(right(inputStr, 1)) * 128 + Asc(left(inputStr, 1))
   Exit Function
Error:
   WriteEvent "GetInterger", Err.Description, Err.Source
End Function
Public Function GetCommandAndDataLength(inputStr As String) As CommandType
   On Error GoTo Error
   Dim tmpReturnType As CommandType
   With tmpReturnType
      .Commands = Asc(left(inputStr, 1))
      .DataLength = GetInterger(mID(inputStr, 2, 2))
   End With
   GetCommandAndDataLength = tmpReturnType
   Exit Function
Error:
   WriteEvent "GetCommandAndDataLength", Err.Description, Err.Source
End Function
Public Function MakeSendString(command As WinsockDownloadEnum, Data As String) As String
   On Error GoTo Error
   Dim t As String
   If command = WS_COMMAND Or command = WS_REQUESTING Or command = WS_RESPONSE Then
      t = StrConv(Data, vbUnicode)
   Else
      t = Data
   End If
   MakeSendString = Chr(command) & MakeIntergerStr(Len(t)) & t
   Exit Function
Error:
   WriteEvent "MakeSendString", Err.Description, Err.Source
End Function
'=================MainTitle=============================================================
Public Function getIfoMainTitle(filename As String) As Integer
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
            If currentChapter > maxChapters Then
               loc_MainTitle = i + 1
               maxChapters = currentChapter
            End If
         Next
      End If
   Close hHandler
   getIfoMainTitle = loc_MainTitle
   Exit Function
Error:
   WriteEvent "getIfoMainTitle", Err.Description, Err.Source
End Function

Public Function MemoryToWord(varDataType As typeWORD) As Long
   'For unsigned integer
   MemoryToWord = varDataType.FirstLong(1) + varDataType.FirstLong(0) * 256
End Function
Public Function MemoryToDWord(varDataType As typeDWORD) As Double
   'For unsigned integer
   MemoryToDWord = varDataType.FirstLong(3) + varDataType.FirstLong(2) * 256 + varDataType.FirstLong(1) * 256 ^ 2 + varDataType.FirstLong(0) * 256 ^ 3
End Function


'=================================================================================
'''Public Sub StartThreadDownloadImage()
'''   On Error GoTo ErrorDownload
'''   CoInitializeEx 0&, &H0 + &H2
'''   cDownload.StartDownload
''''''   If cDownload.DownloadItemCount > 0 Then
''''''      Set downloadData = DownloadQue.item(1)
''''''''''      getDownloadURL
''''''
''''''      DownloadQue.Remove 1
''''''   Else
''''''      sendVariable2Flash FrmMain.Swf(IndexSwf), "", "true"
''''''      Downloading = False
''''''   End If
'''   CoUninitialize
'''   Exit Sub
'''ErrorDownload:


'''End Sub


Public Function ChooseScreen(screenCompare As Single, scr As String)
   On Error GoTo Error
   Dim leftDifference As Single
   Dim rightDiference As Single
   Dim i As Long
   Dim SizeArray As Variant
   Dim max As Long
   Dim SlySwf As String
   On Error GoTo ErrorScreen:
   SlySwf = App.path + "\Sly\"
   If scr = "Both" Then
      SizeArray = ReturnSortArray(Array(20 / 16, "largeWideScreen"), Dir(SlySwf + "*wsl.sly") <> "", Array(4 / 3, "Normal"), Dir(SlySwf + "*ns.sly") <> "", Array(8 / 5, "mediumLargeWideScreen"), Dir(SlySwf + "*WSH.Sly") <> "", Array(5 / 3, "mediumWideScreen"), Dir(SlySwf + "*WSM.Sly") <> "", Array(128 / 75, "smallWideScreen"), Dir(SlySwf + "*WSS.Sly") <> "", Array(16 / 9, "wideScreen"), Dir(SlySwf + "*ws.Sly") <> "")
      
   Else
      SizeArray = ReturnSortArray(Array(20 / 16, "largeWideScreen"), Dir(SlySwf + "*wsl.sly") <> "", Array(16 / 10, "mediumLargeWideScreen"), Dir(SlySwf + "*WSH.Sly") <> "", Array(5 / 3, "mediumWideScreen"), Dir(SlySwf + "*WSM.Sly") <> "", Array(128 / 75, "smallWideScreen"), Dir(SlySwf + "*WSS.Sly") <> "", Array(16 / 9, "wideScreen"), Dir(SlySwf + "*ws.Sly") <> "")
   End If
   
   max = UBound(SizeArray)
   If screenCompare <= SizeArray(0)(0) Then
      ChooseScreen = SizeArray(0)(1)
   ElseIf screenCompare >= SizeArray(max)(0) Then
      ChooseScreen = SizeArray(max)(1)
   Else
      For i = 1 To max
         If (screenCompare >= SizeArray(i - 1)(0)) And (screenCompare <= SizeArray(i)(0)) Then
           rightDiference = SizeArray(i)(0) - screenCompare
           leftDifference = screenCompare - SizeArray(i - 1)(0)
            
            If rightDiference <= leftDifference Then
               ChooseScreen = SizeArray(i)(1)
            Else
               ChooseScreen = SizeArray(i - 1)(1)
            End If
            Exit For
         End If
      Next
   End If
   Exit Function
ErrorScreen:
   ChooseScreen = SizeArray(0)(1)
   Exit Function
Error:
   WriteEvent "ChooseScreen", Err.Description, Err.Source
End Function

Public Function Triple2Long(ByVal lpValue As String) As Long
   Dim FirstByte As Byte
   Dim SecondByte As Byte
   Dim LastByte As Byte
   
   If Len(lpValue) > 3 Then
      lpValue = left(lpValue, 3)
   ElseIf Len(lpValue) < 3 Then
      lpValue = String(3 - Len(lpValue), 0) & lpValue
   End If
   FirstByte = Asc(mID(lpValue, 1, 1))
   SecondByte = Asc(mID(lpValue, 2, 1))
   LastByte = Asc(mID(lpValue, 3, 1))
   
   
   Triple2Long = CLng(FirstByte) * &H10000 + CLng(SecondByte) * &H100 + LastByte
End Function


Public Function Long2Triple(ByVal lpValue As Long) As String
   Dim ValueLeft As Long
   Dim FirstByte As Integer
   Dim SecondByte As Integer
   Dim LastByte As Integer
   If (lpValue <= 16777215 And lpValue >= 0) Then
      ValueLeft = lpValue Mod &H10000
      FirstByte = lpValue \ &H10000
      SecondByte = ValueLeft \ &H100
      LastByte = ValueLeft Mod &H100
      Long2Triple = Chr(FirstByte) & Chr(SecondByte) & Chr(LastByte)
   End If
End Function
