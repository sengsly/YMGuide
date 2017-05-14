Attribute VB_Name = "ScanGeneral"
Option Explicit

Private Const Attributes = vbDirectory Or vbHidden Or vbReadOnly Or vbSystem
Public ListPercent As Integer
Public Type MusicType
  Folder As String
  filename As String
  tracknumber As Integer
  TrackID As Integer
  albumID As Long
  ArtistID As Integer
  ALBUM As String
  ARTIST As String
End Type
Public Enum TrackNumberEnum
   filename = 0
   ID3Tag = 1
End Enum

Public Mp3 As New Music
Public stringPriorityEXT As String
Public StringPriorityMplayer As String

'Public Retvalue As Mp3FileType

Public Function FindFolder(ByVal strStartDir As String) As String()
  On Error Resume Next
  Dim DirList() As String
  Dim lStrFile As String, i As Integer
  Dim lStrDir As String, att As VbFileAttribute
  Dim lStrFilePathName As String
  Dim intValue As Integer, intStart As Integer
  If right(strStartDir, 1) = "\" Then strStartDir = left(strStartDir, Len(strStartDir) - 1)
  i = ArrayAdd(DirList, strStartDir)
   While intValue <= i
'    For intValue = 0 To i
      lStrDir = DirList(intValue)
      lStrFile = Dir(lStrDir + "\*.*", Attributes)
'      If intValue = intStart Then intStart = i + 1
      While lStrFile <> vbNullString
        lStrFilePathName = lStrDir + "\" + lStrFile
        att = GetAttr(lStrFilePathName)
        If ((att And vbDirectory) = vbDirectory) And (lStrFile <> "..") And (lStrFile <> ".") Then
          i = ArrayAdd(DirList, lStrFilePathName)
'          Debug.Print lStrFilePathName
        End If
        lStrFile = Dir
      Wend
      intValue = intValue + 1
'    Next
   Wend
  'Loop Until (intStart >= i)
  FindFolder = DirList
End Function
Public Sub GetBack2FolderLevel(lpFolder As String, lpProduction As String, lpAlbum As String)
   On Error Resume Next
  Dim lStrTmp As String, lList As Variant, intMax As Integer
  lpProduction = ""
  lpAlbum = ""
  lStrTmp = IIf(right(lpFolder, 1) = "\", left(lpFolder, Len(lpFolder) - 1), lpFolder)
  lList = Split(lStrTmp, "\")
  intMax = UBound(lList)
  lpProduction = lList(intMax - 1)
  lpAlbum = lList(intMax)
End Sub


'''Public Function ListFilesByEXT(strFolders() As String, varExts As Variant, ByVal varTrackEnum As TrackNumberEnum, Optional flashObject As Object)
'''  Dim i As Integer, strFileName As String, strDir As String
'''  Dim filecount As Integer, strFile() As String
'''  Dim j As Integer, tmpMusicList() As Mp3FileType
'''  Dim duration As Double
'''
'''  filecount = 0
'''  For i = 0 To UBound(strFolders)
'''    strDir = strFolders(i)
'''    DoEvents
'''    strFileName = Dir(strDir + "\*.*", vbNormal + vbReadOnly + vbArchive)
'''    ListPercent = (i + 1) / (UBound(strFolders) + 1) * 100
'''    If Not IsNull(flashObject) Then
'''      sendVariable2Flash flashObject, "openframe", "true"
'''      sendVariable2Flash flashObject, "strScanning", CStr(ListPercent)
'''      sendVariable2Flash flashObject, "sendScanning", "true"
'''    End If
'''    While strFileName <> vbNullString
'''      For j = 0 To UBound(varExts)
'''        If right(strFileName, Len(varExts(j))) = varExts(j) Then
'''          ReDim Preserve tmpMusicList(filecount)
'''
'''          Mp3.filename = strDir + "\" + strFileName
'''          With tmpMusicList(filecount)
'''            If LCase(right(strFileName, 3)) = "wma" Then .MusicType = WMAFile Else .MusicType = Mp3File
'''            .Mp3PathName = Mp3.filename
'''            duration = Mp3.duration
'''            If .MusicType = Mp3File Then duration = duration + 1
'''            .Mp3Length = Second2Time(duration)
''''            varTrackEnum
'''            .Mp3Track = GetTrackNumber(.Mp3PathName, Mp3.tracknumber, varTrackEnum = ID3Tag)
'''
''''            .Mp3Track = Mp3.tracknumber
'''            .Mp3Title = Mp3.Title
'''            .Mp3Artist = Mp3.ARTIST
'''
'''          End With
'''          filecount = filecount + 1
'''          Exit For
'''        End If
'''      Next j
'''      strFileName = Dir
'''    Wend
'''  Next
'''   Mp3List = tmpMusicList
'''
'''End Function
'''
'''Public Function ListFilesByEXTs(strFolders() As String, varExts As Variant, ByVal varTrackEnum As TrackNumberEnum, Optional flashObject As Object) As MusicType()
'''  Dim i As Integer, strFileName As String, strDir As String
'''  Dim filecount As Integer, strFile() As String
'''  Dim j As Long, tmpMusicList() As MusicType
'''  Dim foundPriority As Integer               'priority list
'''
'''   filecount = 0
'''   ListPercent = 0
'''   For i = 0 To UBound(strFolders)
'''      strDir = strFolders(i)
'''      ListPercent = (i + 1) / (UBound(strFolders) + 1) * 100
'''      If Not IsNull(flashObject) Then
'''         'special case for flash
'''         sendVariable2Flash flashObject, "openframe", "true"
'''         sendVariable2Flash flashObject, "strScanning", CStr(ListPercent)
'''         sendVariable2Flash flashObject, "sendScanning", "true"
'''      End If
'''      strFileName = Dir(strDir + "\*.*", vbNormal + vbReadOnly + vbArchive)
'''      foundPriority = UBound(varExts) + 1                         'make it lower priority
'''      While strFileName <> vbNullString
'''         DoEvents
'''         For j = 0 To UBound(varExts)
'''            If MaskCompare(strFileName, varExts(j)) And foundPriority > j Then
'''               ReDim Preserve tmpMusicList(filecount)
'''
'''               Mp3.tracknumber = 0       'reset old track number
'''               Mp3.filename = strDir + "\" + strFileName
'''               With tmpMusicList(filecount)
'''                  .Folder = LCase(strDir)
'''                  .ALBUM = fso.GetBaseName(.Folder)
'''                  .filename = strDir + "\" + strFileName
'''
'''                  '.tracknumber = GetTrackNumber(.filename, Mp3.tracknumber, varTrackEnum = ID3Tag)
'''                  'no need track number
'''               End With
'''               filecount = filecount + 1
'''               foundPriority = j                      'make it available only one extension with priority(one folder)
'''               Exit For                               'found then exit this loop
'''            End If
'''         Next j
'''         strFileName = Dir
'''      Wend
'''   Next
'''''''''''  Dim Artist As String, Album As String
'''''''''''  'Dim tableArtist As New TableCls
'''''''''''
'''''''''''   With CBrowse.PV_TableLabel
'''''''''''      For j = 0 To .RecordCount - 1
'''''''''''         For i = 0 To filecount - 1
'''''''''''            With tmpMusicList(i)
'''''''''''               If .AlbumID = 0 Then
'''''''''''                  GetBack2FolderLevel .Folder, Artist, Album
'''''''''''                  .Album = Album
'''''''''''                  .Artist = Artist
'''''''''''                  .AlbumID = -1
'''''''''''               End If
'''''''''''               If (.Artist <> "") And (.Album <> "") And (.ArtistID = 0) Then
'''''''''''                  If CompareAritst(CBrowse.PV_TableLabel.AbsoluteField(j, 1), .Artist) Then
'''''''''''                     .ArtistID = CBrowse.PV_TableLabel.AbsoluteField(j, 0)
'''''''''''                  End If
'''''''''''               End If
'''''''''''            End With
'''''''''''         Next
'''''''''''
'''''''''''      Next
'''''''''''   End With
'''
''''''''''''  tableArtist.Opens "Artist"
''''''''''''   For j = 0 To tableArtist.RecordCount - 1
''''''''''''      For i = 0 To filecount - 1
''''''''''''          With tmpMusicList(i)
''''''''''''            If .AlbumID = 0 Then
''''''''''''               GetBack2FolderLevel .Folder, ARTIST, ALBUM
''''''''''''               .ALBUM = ALBUM
''''''''''''               .ARTIST = ARTIST
''''''''''''               .AlbumID = -1
''''''''''''            End If
''''''''''''            If (.ARTIST <> "") And (.ALBUM <> "") And (.ArtistID = 0) Then
''''''''''''              If CompareAritst(tableArtist.AbsoluteField(j, 1), .ARTIST) Then
''''''''''''                 .ArtistID = tableArtist.AbsoluteField(j, 0)
''''''''''''              End If
''''''''''''            End If
''''''''''''          End With
''''''''''''      Next
''''''''''''   Next
''''  tableArtist.Closes
'''  ListFilesByEXTs = tmpMusicList
'''
'''End Function
'''Public Function GetTrackNumberByName(Name As String) As Integer
'''   On Error GoTo Error
'''   Dim i As Integer, oldFlagIsNumber As Boolean, newFlagIsNumber As Boolean
'''   Dim intStartPos As Integer, intEndPos As Integer
'''   Dim charText As String
'''   For i = 1 To Len(Name)
'''      charText = Mid(Name, i, 1)
'''      newFlagIsNumber = IsNumeric(charText)
'''      If newFlagIsNumber And oldFlagIsNumber = False Then
'''         intStartPos = i
'''      End If
'''      If (oldFlagIsNumber And newFlagIsNumber = False) Or (i = Len(Name) And newFlagIsNumber) Then
'''         If newFlagIsNumber = False Then intEndPos = i - 1 Else intEndPos = i
'''         GetTrackNumberByName = Mid(Name, intStartPos, intEndPos - intStartPos + 1)
'''      End If
'''      oldFlagIsNumber = newFlagIsNumber
'''   Next
'''   Exit Function
'''Error:
'''   WriteEvent "GetTrackNumberByName", Err.Description, Err.Source
'''End Function

Public Function GetCountries(path As String) As Variant()
   On Error GoTo Error
   Dim i As Integer, varTmp() As Variant
   Dim xdoc As New DOMDocument, xele As IXMLDOMElement
   xdoc.Load path & "\Countries.xml"
   
   ReDim varTmp(xdoc.childNodes(0).childNodes.Length - 1)
   
   For i = 0 To xdoc.childNodes(0).childNodes.Length - 1
      Set xele = xdoc.childNodes(0).childNodes(i)
      varTmp(i) = Array(xele.Text, xele.getAttribute("Path"))
   Next
   GetCountries = varTmp
   Set xdoc = Nothing
   Exit Function
Error:
   WriteEvent "GetCountries", Err.Description, Err.Source
End Function
Public Function CompareAritst(ByVal strSource As String, ByVal strDest As String) As Boolean
   On Error GoTo Error
   'convert artist to lower case
   'trim char at the end
   strSource = LCase(strSource)
   strDest = LCase(strDest)
   If right(strSource, 1) = "." Then strSource = left(strSource, Len(strSource) - 1)

   CompareAritst = (strSource = strDest)
   Exit Function
Error:
   WriteEvent "CompareAritst", Err.Description, Err.Source
End Function
Public Function CompareSearch(sourceString As String, compareString As String) As Long
   On Error GoTo Error
   'return 0 if it is most the same
   'return -1 if it is most the same
   'return >0 mean that there are many word different according to the correspond string
   
   
   Dim loc_SourceWords() As String
   Dim loc_CompareWords() As String
   
   Dim i As Long
   Dim j As Long
   Dim sourceCount As Long
   Dim intMatchCount As Long
   Dim strSource As String
   Dim strCompare As String
   
   If StrComp(sourceString, compareString, vbTextCompare) = 0 Then
      CompareSearch = -1                           'exactly the same
   Else
      loc_SourceWords = GetWords(sourceString)
      sourceCount = UBound(loc_SourceWords)       'save word count in source
      
      loc_CompareWords = GetWords(compareString)
      If UBound(loc_SourceWords) > UBound(loc_CompareWords) Then sourceCount = UBound(loc_SourceWords) Else sourceCount = UBound(loc_CompareWords)
      
      For i = 1 To UBound(loc_SourceWords)
         strSource = loc_SourceWords(i)
         For j = 1 To UBound(loc_CompareWords)
            strCompare = loc_CompareWords(j)
            If StrComp(strSource, strCompare, vbTextCompare) = 0 Then
               loc_CompareWords(j) = loc_CompareWords(UBound(loc_CompareWords))
               ReDim Preserve loc_CompareWords(UBound(loc_CompareWords) - 1)
               intMatchCount = intMatchCount + 1
               Exit For
            End If
         Next
      Next
      CompareSearch = sourceCount - intMatchCount
   End If
   Exit Function
Error:
   WriteEvent "CompareSearch", Err.Description, Err.Source
End Function
Public Function GetWords(ByVal inputString As String) As String()
   On Error GoTo Error

   'return words array with delimiter
   Const arrayDelimiter = ";,. "    'including space
   Dim loc_Words() As String
   Dim loc_wordCount As Long
      
   ReDim Preserve loc_Words(0)
   
   Dim i As Long
   Dim intStartWordPosition As Long
   Dim intSearchedPosition As Long
   Dim readingChar As String
   
   intStartWordPosition = 1                  'Set it to 1 defalt
   inputString = inputString & " "           'add space to the end to get the last word too
   For i = 1 To Len(inputString)
      readingChar = Mid(inputString, i, 1)
      intSearchedPosition = InStr(1, arrayDelimiter, readingChar, vbTextCompare)
      If intSearchedPosition > 0 Then
         
         loc_wordCount = loc_wordCount + 1
         ReDim Preserve loc_Words(loc_wordCount)
         loc_Words(loc_wordCount) = Mid(inputString, intStartWordPosition, i - intStartWordPosition)
         intStartWordPosition = i + 1
      End If
   Next
   GetWords = loc_Words
   Exit Function
Error:
   WriteEvent "GetWords", Err.Description, Err.Source
End Function
Public Function ListFilesByEXT(strFolders() As String, varExts As Variant, ByVal varTrackEnum As TrackNumberEnum, Optional flashObject As Object)
  Dim i As Integer, strFileName As String, strDir As String
  Dim filecount As Integer, strFile() As String
  Dim j As Integer, tmpMusicList() As Mp3FileType
  Dim Duration As Double

  filecount = 0
  For i = 0 To UBound(strFolders)
    strDir = strFolders(i)
    DoEvents
    strFileName = Dir(strDir + "\*.*", vbNormal + vbReadOnly + vbArchive)
    ListPercent = (i + 1) / (UBound(strFolders) + 1) * 100
    If Not IsNull(flashObject) Then
      flashObject.SetVariable "openframe", "true"
      flashObject.SetVariable "strScanning", CStr(ListPercent)
      flashObject.SetVariable "sendScanning", "true"
    End If
    While strFileName <> vbNullString
      For j = 0 To UBound(varExts)
        If right(strFileName, Len(varExts(j))) = varExts(j) Then
          ReDim Preserve tmpMusicList(filecount)
          
          Mp3.filename = strDir + "\" + strFileName
          With tmpMusicList(filecount)
            If LCase(right(strFileName, 3)) = "wma" Then .MusicType = WMAFile Else .MusicType = Mp3File
            .Mp3PathName = Mp3.filename
            Duration = Mp3.Duration
            If .MusicType = Mp3File Then Duration = Duration + 1
            .Mp3Length = Second2Time(Duration)
'            varTrackEnum
            .Mp3Track = GetTrackNumber(.Mp3PathName, Mp3.tracknumber, varTrackEnum = ID3Tag)

'            .Mp3Track = Mp3.tracknumber
            .Mp3Title = Mp3.Title
            .Mp3Artist = Mp3.ARTIST
          
          End With
          filecount = filecount + 1
          Exit For
        End If
      Next j
      strFileName = Dir
    Wend
  Next
   Mp3List = tmpMusicList
  
End Function
Public Function GetTrackNumber(filename As String, tracknumber As Integer, useID3Tag As Boolean) As Integer
   Dim newName As String, intTrackNumber As Integer
   
   Dim intExtPos As Integer, intPathPos As Integer
   intExtPos = InStrRev(filename, ".")
   intPathPos = InStrRev(filename, "\")
   
   If (intPathPos <> 0) And (intExtPos <> 0) Then
      newName = Mid(filename, intPathPos + 1, intExtPos - intPathPos - 1)
      intTrackNumber = GetTrackNumberByName(newName)
   End If
   
   If useID3Tag Then
      If tracknumber = 0 Then GetTrackNumber = intTrackNumber Else GetTrackNumber = tracknumber
   Else
      If intTrackNumber = 0 Then GetTrackNumber = tracknumber Else GetTrackNumber = intTrackNumber
   End If
   

End Function
Public Function GetTrackNumberByName(Name As String) As Integer
   Dim i As Integer, oldFlagIsNumber As Boolean, newFlagIsNumber As Boolean
   Dim intStartPos As Integer, intEndPos As Integer
   Dim charText As String
   For i = 1 To Len(Name)
      charText = Mid(Name, i, 1)
      newFlagIsNumber = IsNumeric(charText)
      If newFlagIsNumber And oldFlagIsNumber = False Then
         intStartPos = i
      End If
      If (oldFlagIsNumber And newFlagIsNumber = False) Or (i = Len(Name) And newFlagIsNumber) Then
         If newFlagIsNumber = False Then intEndPos = i - 1 Else intEndPos = i
         GetTrackNumberByName = Mid(Name, intStartPos, intEndPos - intStartPos + 1)
      End If
      oldFlagIsNumber = newFlagIsNumber
   Next
End Function
Public Function ListFilesByEXTs(strFolders() As String, varExts As Variant, ByVal varTrackEnum As TrackNumberEnum, Optional flashObject As Object) As MusicType()
  Dim i As Integer, strFileName As String, strDir As String
  Dim filecount As Integer, strFile() As String
  Dim j As Long, tmpMusicList() As MusicType
  Dim foundPriority As Integer               'priority list

   filecount = 0
   ListPercent = 0
   For i = 0 To UBound(strFolders)
      strDir = strFolders(i)
      ListPercent = (i + 1) / (UBound(strFolders) + 1) * 100
      If Not IsNull(flashObject) Then
         'special case for flash
         flashObject.SetVariable "openframe", "true"
         flashObject.SetVariable "strScanning", CStr(ListPercent)
         flashObject.SetVariable "sendScanning", "true"
      End If
      strFileName = Dir(strDir + "\*.*", vbNormal + vbReadOnly + vbArchive)
      foundPriority = UBound(varExts) + 1                         'make it lower priority
      While strFileName <> vbNullString
         DoEvents
         For j = 0 To UBound(varExts)
            If MaskCompare(strFileName, varExts(j)) And foundPriority > j Then
               ReDim Preserve tmpMusicList(filecount)
             
'''               Mp3.tracknumber = 0       'reset old track number
'''               Mp3.filename = strDir + "\" + strFileName
               With tmpMusicList(filecount)
                  .Folder = LCase(strDir)
                  .ALBUM = fso.GetBaseName(.Folder)
                  .filename = strDir + "\" + strFileName
               
                  '.tracknumber = GetTrackNumber(.filename, Mp3.tracknumber, varTrackEnum = ID3Tag)
                  'no need track number
               End With
               filecount = filecount + 1
               foundPriority = j                      'make it available only one extension with priority(one folder)
               Exit For                               'found then exit this loop
            End If
         Next j
         strFileName = Dir
      Wend
   Next
  ListFilesByEXTs = tmpMusicList
  
End Function

Public Function MaskCompare(StringSource As String, ByVal stringCompare As String) As Boolean
   On Error GoTo Error
   Dim loc_Compare As String
   loc_Compare = Replace(stringCompare, "*", "")  'replace asterisk mark with null only work with *.mp3 or video.* ,on the left or right
   If InStr(1, stringCompare, "*") > 0 Then        'if there is a *
      MaskCompare = InStr(1, StringSource, loc_Compare, vbTextCompare) > 0
   Else
      MaskCompare = StrComp(StringSource, loc_Compare, vbTextCompare) = 0
   End If
   Exit Function
Error:
   WriteEvent "MaskCompare", Err.Description, Err.Source
End Function
Public Sub CompareMusicTime(lpStartFolder As String, typeMp3List() As Mp3FileType, varExts As Variant, trackType As TrackNumberEnum, flashObject As Object)
  Dim filecount As Integer, strFile() As String, j As Integer
  
  filecount = 0
  strFile = FindFolder(lpStartFolder)
  Call ListFilesByEXT(strFile, varExts, trackType, flashObject)
  typeMp3List = Mp3List
End Sub

Public Function TitleExist(TitleList() As Mp3SubType, strTitleName As String) As Integer
   Dim i As Integer
   On Error GoTo ErrorNotFound:
   For i = 0 To UBound(TitleList)
      If LCase(TitleList(i).Name) = LCase(strTitleName) Then
         TitleExist = i
         Exit Function
      End If
   Next
ErrorNotFound:
  TitleExist = -1                 'Return -1 for not found
End Function

