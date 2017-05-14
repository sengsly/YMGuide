VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBrowser_tmp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================================================================
'Fixing AlbumByGenreNLetter
'================================================================================================================================================================
Option Explicit
Public currentAlbumLanguagePath As String
Public boolExitLoop As Boolean            'for exit loop
Private var_SearchTrack() As Variant
Private var_Director() As Variant
Private var_Album() As Variant
Private var_SearchAlbum() As Variant
Private var_Artist()  As Variant          'Artist array
Private var_SearchArtist() As Variant     'Used for search
Private var_TrackID() As Long             'Store ID for selected Album
Private var_databaseType As Integer            'Store the type of database like TVSeries,Movie,Music Video,Karaoke
                                          '(1 Movie,2 TVSeries,4 Music,8 Karaoke)
Private var_CurrentAlbumID As Long        'Store ID of albumID
Public collectionSelectList As New Collection
Public boolAlbumChanged As Boolean
Public mSelectAlbumType As AlbumEnum
Public mSelectFlagType As CDTypeEnum
Public mSelectGroupCDType As Integer     'mSelectGroupCDType -1 mean not sort ,0  mean sort by type,>0  mean select  and sort by type
Public bCancelBrowse As Boolean

Dim TypeCDOrder(10) As Integer
Dim FlagCDOrder(10) As Integer
   
'''Public Enum CDTypeEnum
'''   Clean = 2
'''   Explicit = 3
'''   AllCD = 0
'''End Enum

Public prv_Country As String
Public prv_Directory As String
'define va..................
Private currentGroupCDType As Integer
Private fieldGroupCDType As Integer
'variable for use with save and restore country
Dim save_Language As String
Dim save_Directory As String

Public PV_TableLabel As New TableCls
Public PV_TableMovie As New TableCls
Private PV_strBrowseFolder As String
Private PV_TableLanguage As New TableCls
Private PV_TableGenre As New TableCls
Private PV_TableActor As New TableCls
Private PV_TableTrack As New TableCls
Private PV_TableTitleTrack As New TableCls                        'added 2005-08-19 seng
Private PV_TableDirector As New TableCls                          'added 2005-08-22 seng
Private PV_TableTVSeries As New TableCls
'For audio format  DD = 1    PCM = 2   DTS = 3  DTS ES = 4   DD-EX = 5  MPEG Audio Stream = 6   SDDS = 7
Const StPer = "%%"
Const StWave = "%~%"
Const StOr = "||"

Public Property Let InitDatabase(varValue As String)
   On Error GoTo Error
   PV_strBrowseFolder = fso.BuildPath(varValue, "\")
   
   SetDirectory PV_strBrowseFolder                    'Set default directory for table
   'initialize all variables                                       ==============================================
      CloseAllDatabase
   
   
      PV_TableGenre.Opens "Genre"
      PV_TableActor.Opens "Actor"
      PV_TableMovie.Opens "Movie"
      PV_TableLabel.Opens "Label"
      PV_TableTrack.Opens "Track"
      PV_TableLanguage.Opens "Language"
      PV_TableTitleTrack.Opens "Title"
      PV_TableDirector.Opens "Director"                     '2005-08-22
      PV_TableTVSeries.Opens "TVSeries"                     '2005-10-12
      LoadTypeCD
   '=============================================================================================================
   Exit Property
Error:
   Writelog "Let InitDatabase", "ERROR", Err.Description, "varValue = " & varValue & ", PV_strBrowseFolder= " & PV_strBrowseFolder
End Property

'''Public Property Get InitDatabase() As String
'''   On Error GoTo Error
'''   InitDatabase = PV_strBrowseFolder
'''   Exit Property
'''Error:
'''   WriteEvent "Get InitDatabase", Err.Description, Err.Source
'''End Property

Public Function GetGenre() As String
   On Error GoTo Error
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, intIndex As Integer
  Dim i As Long, varData() As Variant
  
   With PV_TableGenre
      If .RecordCount = 0 Then Exit Function
      intIndex = .FieldToIndex("Unicode")
      ReDim varData(.RecordCount - 1)
      For i = 0 To .RecordCount - 1
         varData(i) = Array(.AbsoluteField(i, 0), .AbsoluteField(i, 1), (.AbsoluteField(i, intIndex)))
      Next
   End With
   QuickSort varData, Array(0)
   For i = 0 To i - 1
      strTmp = strTmp + strPlus & Join(varData(i), de_Field)
      strPlus = de_Record
   Next
   GetGenre = strTmp
   Exit Function
Error:
   WriteEvent "GetGenre", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   GetTVSeriesAvailable
' Description       :   Get tvseries from dvds
' Return Values     :   TV series
' Input Parameter   :   None,Global variable(mSelectAlbumType)
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             11-29-2005           New
'*******************************************************************************

Public Function GetTVSeriesAvailable()
   On Error GoTo Error
   Dim i As Long
   Dim loc_TVID As Long
   Dim loc_TVIDs As String
   Dim tvSeriesCount As Long
   Dim varData() As Variant
   Dim strTmp As String, strPlus As String
   Dim loc_AlbumAvailable As Integer
   
   Dim iFieldUnicode As Integer, iFieldSeason As Integer
   
   loc_TVIDs = ";"
   With PV_TableMovie
      For i = 0 To .RecordCount - 1
         loc_TVID = .AbsoluteField(i, "TVID")
         loc_AlbumAvailable = .AbsoluteField(i, "Available")
         If loc_TVID > 0 And (IsCDAvailable(loc_AlbumAvailable, mSelectAlbumType)) Then
            If InStr(1, loc_TVIDs, ";" & loc_TVID & ";") = 0 Then
               loc_TVIDs = loc_TVIDs & loc_TVID & ";"
            End If
         End If
      Next
   End With
   With PV_TableTVSeries
      iFieldUnicode = .FieldToIndex("Unicode")
      iFieldSeason = .FieldToIndex("SeasonCount")
      For i = 0 To .RecordCount - 1
         loc_TVID = .AbsoluteField(i, 0)
         If loc_TVID > 0 Then
            If InStr(1, loc_TVIDs, ";" & loc_TVID & ";") > 0 Then
               ReDim Preserve varData(tvSeriesCount)
               varData(tvSeriesCount) = Array(loc_TVID, .AbsoluteField(i, 1), .AbsoluteField(i, iFieldUnicode), .AbsoluteField(i, iFieldSeason))
               tvSeriesCount = tvSeriesCount + 1
            End If
         End If
      Next
   End With
   If tvSeriesCount > 0 Then
      QuickSort varData, Array(0)
      For i = 0 To tvSeriesCount - 1
         strTmp = strTmp + strPlus & Join(varData(i), de_Field)
         strPlus = de_Record
      Next
   End If
   GetTVSeriesAvailable = strTmp
   Exit Function
Error:
   WriteEvent "GetTVSeriesAvailable", Err.Description, Err.Source
End Function

Public Function AlbumByArtist(ArtistID As Long, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional Favorite As Boolean, Optional CDType As CDTypeEnum = AllCD, Optional SearchPage As Boolean = False) As String
   On Error GoTo Error
   Dim i As Long
   Dim fieldAvailable As Integer
   Dim fieldFlag As Integer
   Dim fieldArtists As Integer
   Dim count As Integer
   Dim SortKey As Integer
   Dim boolSelect As Boolean
   Dim var_tmpAlbum() As Variant
   Dim loc_AlbumID As Long
   
   
   If SearchPage = False Then Erase var_Album
   
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_Artists As String
   
   
   With PV_TableMovie
      fieldAvailable = .FieldToIndex("Available")
      fieldFlag = .FieldToIndex("Flag")
      fieldArtists = .FieldToIndex("ActorID")
      
      
      boolSelect = True
      For i = 0 To .RecordCount - 1
         loc_Flag = FlagCDOrder(.AbsoluteField(i, fieldFlag))
         loc_Artists = .AbsoluteField(i, fieldArtists)
         If InStr(1, loc_Artists, ";" & ArtistID & ";", vbTextCompare) > 0 Then
            loc_AlbumID = .AbsoluteField(i, 0)
            'loc_Available = .AbsoluteField(i, fieldAvailable)
            loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, mSelectFlagType) Then
               ReDim Preserve var_tmpAlbum(count)
               var_tmpAlbum(count) = GetAlbumInfos(i, loc_Available, SortKey, True, loc_Flag)
               count = count + 1
            End If
         End If
         
      Next
   End With
   
   Dim sortIndices As Variant
  
   sortIndices = ReturnSortArray(3, True, 11, True, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
   If count > 0 Then QuickSort var_tmpAlbum, sortIndices, False
   If SearchPage Then var_SearchAlbum = var_tmpAlbum Else var_Album = var_tmpAlbum
   AlbumByArtist = count
   Exit Function
Error:
   WriteEvent "AlbumByArtist", Err.Description, Err.Source
End Function
Public Property Let SetTrackPath(ByVal TrackID As Long, newPath As String)
   On Error GoTo Error
   Dim Index As Long
   Dim MovieID As Long, albumIndex As Long
   
   Index = PV_TableTrack.Seeks(TrackID)
   If Index >= 0 Then
      PV_TableTrack.AbsoluteEdit(Index, PV_TableTrack.FieldToIndex("Path")) = newPath
      PV_TableTrack.AbsoluteEdit(Index, PV_TableTrack.FieldToIndex("Available")) = 1
      MovieID = PV_TableTrack.AbsoluteField(Index, "MovieID")
      
      albumIndex = PV_TableMovie.Seeks(MovieID)
      If albumIndex >= 0 Then PV_TableMovie.AbsoluteEdit(albumIndex, PV_TableMovie.FieldToIndex("Available")) = 1
      boolAlbumChanged = True
   End If
   Exit Property
Error:
   WriteEvent "Let SetTrackPath", Err.Description, Err.Source
End Property
Public Function GetNextAlbum(ByVal startIndex As Integer, Optional ByVal count As Integer = 10, Optional paramSearchAlbums As Boolean = False)
   On Error GoTo ErrorOccure:
   Dim i As Integer, tmp As String, strPlus As String
   
   Dim var_OneAlbum As Variant
   Dim albumAvailable As Long
   Dim albumID As Long
   
   For i = 0 To count - 1
      If Not paramSearchAlbums Then
          On Error Resume Next
          If startIndex + i > UBound(var_Album) Then Exit For
          var_OneAlbum = var_Album(i + startIndex)
      Else
          If startIndex + i > UBound(var_SearchAlbum) Then Exit For
          var_OneAlbum = var_SearchAlbum(i + startIndex)
      End If
      albumAvailable = var_OneAlbum(7)
      albumID = var_OneAlbum(0)
      
      If albumAvailable = 0 And CWinsock.isServerConnected Then
         'if albumavailable is egal to 0 then search available from myalbum
         albumAvailable = getAlbumAvailable(currentCountry, albumID)
      End If
                                                                                                                                                                                                                                                                                                                                                                                                                                 'Flag
                           '   0                      1                             2                          3                             4                             5                             6                          7                                   8                                   9
      tmp = tmp & strPlus & albumID & de_Field & var_OneAlbum(1) & de_Field & var_OneAlbum(2) & de_Field & var_OneAlbum(5) & de_Field & var_OneAlbum(8) & de_Field & albumAvailable & de_Field & var_OneAlbum(9) & de_Field & var_OneAlbum(10) & de_Field & ReverseDate(var_OneAlbum(4)) & de_Field & var_OneAlbum(12) & de_Field & var_OneAlbum(13) & de_Field & var_OneAlbum(14) & de_Field & var_OneAlbum(15) & de_Field & var_OneAlbum(16)
                           'AlbumID                albumName                     albumUnicode, SortKey, AlbumDate, AlbumProduction, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, "", AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
                           'AlbumID , albumName, albumUnicode, SortKey, AlbumDate, AlbumProduction, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, "", AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
                              '0          1           2           3        4              5              6              7              8        9        10       11             12    13             14             15          16
      strPlus = de_Record
   Next
   GetNextAlbum = tmp
   Exit Function
ErrorOccure:
   WriteEvent "GetNextAlbum", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   GetTracksByAlbum
' Description       :   get the tracks info from the current albumid
' Return Values     :   return the album tracks
' Input Parameter   :   albumid,boolshowartist:show artist name under track list
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             11-24-2005           New
'*******************************************************************************

Public Function GetTracksByAlbum(ByVal albumID As Long, boolShowArtist As Boolean) As String
   On Error GoTo Error
   Static boolQuerying As Boolean
   Dim i As Integer, tmp As String, strPlus As String
   Dim Data() As Variant, maxTrack As Long
   Dim LabelName As String, LabelNameUnicode As String
   Dim loc_MovieAvailable As Integer
   Dim loc_Available As Integer, TrackID As Long
   Dim titleID As Long
   Dim joinData() As String
   Dim TrackIDs As String
   Dim stringShowArtist As String
   Dim showArtistUnicode As String
   Dim intTrackLength As Integer
   Dim strTrackLength As String
   Dim showArtists() As String
   
   
   If boolQuerying = True Then Exit Function
      boolQuerying = True
      With PV_TableMovie
         If .Seeks(albumID) >= 0 Then
            titleID = .Field("MainTitleID")
            LabelName = .Field("Label")
            LabelNameUnicode = ""
            loc_MovieAvailable = .Field("Available")
            If .Field("Path") = "" And .Field("PathMedium") = "" And .Field("PathSmall") = "" Then loc_MovieAvailable = 0                         'if the path only available from the chapter then don't make it available all chapter
            If titleID > 0 Then
               With PV_TableTrack
                  If PV_TableTitleTrack.Seeks(titleID) >= 0 Then
                     'TrackIDs = Split(PV_TableTitleTrack.Field("TrackIDs"), ";")
                     TrackIDs = PV_TableTitleTrack.Field("TrackIDs")
                     For i = 1 To Len(TrackIDs) Step 3
                        TrackID = Triple2Long(mID(TrackIDs, i, 3))
                        If PV_TableTrack.Seeks(TrackID) >= 0 Then
                           If boolShowArtist Then
                              showArtists = Split(GetActorName(.Field("SingerIDs"), True), "%%")
                              stringShowArtist = showArtists(0)                  'Name
                              showArtistUnicode = showArtists(1)                   'Unicode
                           Else
                              stringShowArtist = LabelName
                              showArtistUnicode = LabelNameUnicode
                           End If
                           ReDim Preserve Data(maxTrack)
                           'if the movie is available then make all chapters available too
                           intTrackLength = .Field("Length")
                           strTrackLength = IIf(intTrackLength = 0, "", Second2Time(intTrackLength, True))
                           If loc_MovieAvailable = 1 Then loc_Available = 1 Else loc_Available = PV_TableTrack.Field("Available")
                                                 '        0                  1                2                  3       4       5          6            7                 8                 9                10         11        12                       13              14        15  16         17=Artists            18                 19          20
                           Data(maxTrack) = Array(.Field("ID"), .Field("Position"), .Field("Name"), .Field("Unicode"), "Mood", "None", "DanceStyle", "Track Artist", stringShowArtist, showArtistUnicode, .Field("Rating"), strTrackLength, .Field("Language"), loc_Available, 0, "", .Field("SingType"), .Field("SeekOffset"), LabelName, LabelNameUnicode)
                           maxTrack = maxTrack + 1
                        End If
                     Next
                  End If

                  'Next
               End With
            End If
         End If
      End With
      If maxTrack > 0 Then
         QuickSort Data, Array(1)
         For i = 0 To maxTrack - 1
            If tmp = "" Then strPlus = "" Else strPlus = de_Record
            tmp = tmp & strPlus & Join(Data(i), de_Field)
         Next
      End If
      GetTracksByAlbum = tmp
   boolQuerying = False
   Exit Function
Error:
   WriteEvent "GetTracksByAlbum", Err.Description, Err.Source
End Function
Public Function SearchArtistIDInPlayList(Name As String) As Long
   On Error GoTo Error
   Dim i As Long
   With PV_TableActor
      For i = 0 To .RecordCount - 1
         If StrComp(.AbsoluteField(i, 1), Name, vbTextCompare) = 0 Then
            SearchArtistIDInPlayList = .AbsoluteField(i, 0)
            Exit Function
         End If
      Next
'      If .FindFirst("Name=" & Name) Then
'         SearchArtistIDInPlayList = .Field(0)
'      End If
   End With
   Exit Function
Error:
   WriteEvent "SearchArtistIDInPlayList", Err.Description, Err.Source
End Function
Public Function SearchLabelIDInPlayList(Name As String) As Long
   On Error GoTo Error
   With PV_TableLabel
      If .FindFirst("Name=" & Name) Then
         SearchLabelIDInPlayList = .Field(0)
      End If
   End With
   Exit Function
Error:
   WriteEvent "SearchLabelIDInPlayList", Err.Description, Err.Source
End Function
Public Function SearchArtistNameAndAltName(ByVal ArtistNames As String, boolUnicode As Boolean) As Long()
   On Error GoTo Error
   Dim boolFound As Boolean
   Dim i As Long, j As Long
   Dim Name As String
   Dim varArtists() As String
   Dim fieldValue As String
   Dim unicodeSplit As String
   Dim nameField As Integer
   Dim altField As Integer
   Dim nameValue As String
   Dim altNameValue As String
   Dim searchCount As Long
   Dim searchData() As Long
   
   ArtistNames = Replace(ArtistNames, "*", "")
   ReDim Preserve searchData(-1 To -1)          'For not count
   With PV_TableActor
      If boolUnicode Then
         unicodeSplit = " ÷ "
         nameField = .FieldToIndex("Unicode")
         altField = .FieldToIndex("UnicodeAltName")
      Else
         unicodeSplit = " + "
         nameField = .FieldToIndex("Name")
         altField = .FieldToIndex("AltName")
      End If
      For j = 0 To .RecordCount - 1
         varArtists = Split(ArtistNames, unicodeSplit)
         nameValue = .AbsoluteField(j, nameField)
         altNameValue = .AbsoluteField(j, altField)
         For i = 0 To UBound(varArtists)
            boolFound = InStr(1, nameValue, varArtists(i), vbTextCompare) > 0
            'boolFound = boolFound Or InStr(1, altNameValue, varArtists(i), vbTextCompare) > 0        ' skip it now
            If boolFound Then
               ReDim Preserve searchData(-1 To searchCount)
               searchData(searchCount) = .AbsoluteField(j, 0)        ' Return the id only
               searchCount = searchCount + 1
               Exit For
            End If
         Next
      Next
   End With
   SearchArtistNameAndAltName = searchData
   Exit Function
Error:
   WriteEvent "SearchArtistNameAndAltName", Err.Description, Err.Source
End Function

Public Function arraySearch(mainstring As String, string2 As String) As Long()
   On Error GoTo Error
   Dim i As Integer, currentString As String
   Dim varArray As Variant
   Dim count As Integer, tmpArray() As Long
   Dim picked As String
   
   
   varArray = Split(mID(string2, 2, Len(string2) - 2), ";")
   picked = ";"
   ReDim Preserve tmpArray(-1 To -1)
   For i = 0 To UBound(varArray)
      currentString = varArray(i)
      If (InStr(mainstring, ";" & currentString & ";") > 0) And InStr(picked, ";" & currentString & ";") = 0 Then
         ReDim Preserve tmpArray(-1 To count)
         picked = picked & currentString & ";"
         tmpArray(count) = currentString
'         arraySearch = currentString
         count = count + 1
'         Exit For
      End If
   Next
   arraySearch = tmpArray
   Exit Function
Error:
   WriteEvent "arraySearch", Err.Description, Err.Source
End Function

Public Function GetAlbumInfo(albumID As Long, Optional languagePath As String) As String
   On Error GoTo Error
   With PV_TableMovie
      If .Seeks(albumID) >= 0 Then
         GetAlbumInfo = .Field("Rating") & de_Field & .Field("Length") & de_Field & .Field("Label") & de_Field & .Field("LabelUnicode") & de_Field & .Field("Year")
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetAlbumInfo", Err.Description, Err.Source
End Function
Public Function SetCountry(country As String, directory As String, Optional aDatabaseType As Integer = 0) As Boolean
   On Local Error GoTo ErrorCountry
   
   prv_Country = country
   
   'databaseType = aDatabaseType
   If right(directory, 9) <> "\Database" Then
      prv_Directory = directory & "\Database"
   Else
      prv_Directory = directory
   End If
   InitDatabase = prv_Directory
   languageServerLink = getLanguageServer(country)
   var_databaseType = get_country_type(country)
   SetCountry = True
   Exit Function
ErrorCountry:
   SetCountry = False
End Function
Public Property Get databaseType() As Integer
   databaseType = var_databaseType
End Property
Public Sub SetTrackField(TrackID As Long, FieldName As String, Value As Variant)
   On Error GoTo Error
   Dim TrackIndex As Long
   With PV_TableTrack
      TrackIndex = .Seeks(TrackID)
      If TrackIndex >= 0 Then
         .AbsoluteEdit(TrackIndex, .FieldToIndex(FieldName)) = Value
      End If
   End With
   Exit Sub
Error:
   WriteEvent "SetTrackField", Err.Description, Err.Source
End Sub
Public Function GetTrackField(TrackID As Long, FieldName As String) As Variant
   On Error GoTo errDesc: ' test
   Dim fieldIndex As Integer
   Dim Index As Long
   
   
   With PV_TableTrack
      fieldIndex = .FieldToIndex(FieldName)
      Index = .Seeks(TrackID)
      If Index >= 0 Then GetTrackField = .Field(fieldIndex)
   End With
   Exit Function
errDesc:
   WriteEvent "GetTrackField", Err.Description, Err.Source
End Function

Public Function SetTrackNumPlay(albumID As Long, TrackID As Long) As Integer
   On Error GoTo Error
   'EDIT:2006-08-10 Seng
   Dim loc_recordIndex As Long
   Dim loc_NumPlay As Integer
   Dim loc_Rating As Integer
   Dim loc_FieldRating As Integer
   Dim loc_FieldNumPlay As Integer
   
   With PV_TableTrack
      loc_recordIndex = .Seeks(TrackID)
      If loc_recordIndex >= 0 Then
         loc_FieldRating = .FieldToIndex("Rating")
         loc_FieldNumPlay = .FieldToIndex("NumPlay")
         loc_NumPlay = .AbsoluteField(loc_recordIndex, loc_FieldNumPlay)
         loc_Rating = .AbsoluteField(loc_recordIndex, loc_FieldRating)
         If loc_Rating < 5 Then
            If calculateLog(loc_NumPlay) Then
               loc_Rating = loc_Rating + 1
               .AbsoluteEdit(loc_recordIndex, loc_FieldRating) = loc_Rating
               SetTrackNumPlay = loc_Rating
            End If
         End If
         If loc_NumPlay < 9999 Then
            .AbsoluteEdit(loc_recordIndex, loc_FieldNumPlay) = loc_NumPlay + 1
         End If
         
      End If
   End With
   Exit Function
Error:
   WriteEvent "SetTrackNumPlay", Err.Description, Err.Source
End Function
Private Function calculateLog(Value As Integer) As Boolean
   On Error GoTo Error
   Dim i As Integer, nreturn As Integer
   If Value <> 0 Then
      For i = 0 To 13
         nreturn = 12 * 2 ^ i
         If nreturn = Value Then calculateLog = True
         If (nreturn >= Value) Then Exit For
      Next
   End If
   Exit Function
Error:
   WriteEvent "calculateLog", Err.Description, Err.Source
End Function
Public Function SearchAvailableType(ByVal albumID As Long) As Integer
   On Error GoTo Error
   Dim loc_iMovieSeek As Long
   Dim loc_iTrackSeek As Long
   Dim loc_sPath As String
   loc_iMovieSeek = PV_TableMovie.Seeks(albumID)
   If loc_iMovieSeek >= 0 Then
      '1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath
      loc_sPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, PV_TableMovie.FieldToIndex("Path"))
      If loc_sPath <> "" Then SearchAvailableType = 1
      loc_sPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, PV_TableMovie.FieldToIndex("PathMedium"))
      If loc_sPath <> "" Then SearchAvailableType = SearchAvailableType Or 2
      loc_sPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, PV_TableMovie.FieldToIndex("PathSmall"))
      If loc_sPath <> "" Then SearchAvailableType = SearchAvailableType Or 4
   End If
   Exit Function
Error:
   WriteEvent "SearchAvailableType", Err.Description, Err.Source
End Function
Public Function GetStreamPath(ByVal albumID As Long, ByVal TrackID As Long, iPlayFrom As Integer) As String
   On Error GoTo Error
   Dim i As Long, iLoopCount As Integer
   Dim loc_iMovieSeek  As Long, loc_iTrackSeek As Long
   Dim loc_sTrackPath  As String, loc_strFieldName As String
   Dim varArrayField As Variant, varArrayIndex As Variant
   
   varArrayField = Array("Path", "Path", "PathMedium", "PathSmall", "Path", "PathMedium")         'first one may not be used
   varArrayIndex = Array(1, 1, 2, 3, 1, 2)                 'first one may not be used
   loc_iMovieSeek = PV_TableMovie.Seeks(albumID)
   If iPlayFrom < 4 Then
      If loc_iMovieSeek >= 0 Then
         For i = iPlayFrom To UBound(varArrayField)           'loop to check first available track
            iLoopCount = iLoopCount + 1
            loc_strFieldName = varArrayField(i)
            iPlayFrom = varArrayIndex(i)
            loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, loc_strFieldName)
            'if found or reach max loop
            If (iLoopCount >= 3) Or loc_sTrackPath <> "" Then Exit For
         Next
      End If
   End If
   If loc_sTrackPath = "" Then                              'if still can't find the path so get from chapter path
      loc_iTrackSeek = PV_TableTrack.Seeks(TrackID)
      If loc_iTrackSeek >= 0 Then
         loc_sTrackPath = PV_TableTrack.AbsoluteField(loc_iTrackSeek, "Path")
         iPlayFrom = 4                 'Track path
      End If

   End If
   GetStreamPath = loc_sTrackPath
   Exit Function
Error:
   WriteEvent "GetStreamPath", Err.Description, Err.Source
End Function
Public Function GetTrackPath(ByVal TrackID As Long, ByVal albumID As Long, Optional iPlayFrom As Integer) As String
   On Error GoTo Error
   Dim loc_TrackID As Long
   Dim loc_iMovieSeek As Long
   Dim loc_MovieID As Long
   Dim loc_sTrackPath As String
   Dim loc_iTrackSeek As Long
   Dim str_Name As String
   With PV_TableTrack
      '1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath
     If iPlayFrom > 0 Then
         If iPlayFrom = 1 Or iPlayFrom = 2 Or iPlayFrom = 3 Or iPlayFrom = 5 Or iPlayFrom = 6 Then
            loc_iMovieSeek = PV_TableMovie.Seeks(albumID)
            If loc_iMovieSeek >= 0 Then
               If iPlayFrom = 1 Then
                  str_Name = "Path"             'Large Link
               ElseIf iPlayFrom = 2 Then        'Medium Link
                  str_Name = "PathMedium"
               ElseIf iPlayFrom = 3 Then           'Small Link
                  str_Name = "PathSmall"
               ElseIf iPlayFrom = 5 Then
                  str_Name = ""
               ElseIf iPlayFrom = 6 Then              'Trailer
                  str_Name = "PathTrailer"
               End If
               loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, str_Name)
            End If
         ElseIf iPlayFrom = 4 Then
            loc_iTrackSeek = .Seeks(TrackID)
            If loc_iTrackSeek >= 0 Then
               loc_sTrackPath = .AbsoluteField(loc_iTrackSeek, "Path")
            End If
         End If
      Else
         If TrackID > 0 Then
            '1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath
            loc_iTrackSeek = .Seeks(TrackID)
            If loc_iTrackSeek >= 0 Then                                        'if the track is is found
               loc_MovieID = albumID                                                            '.AbsoluteField(loc_iTrackSeek, "MovieID")
               loc_iMovieSeek = PV_TableMovie.Seeks(loc_MovieID)                 'seek to the movie
               If loc_MovieID > 0 And loc_iMovieSeek >= 0 Then
                  'search default path for the movie
                  loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, "Path")
                  If loc_sTrackPath <> "" Then iPlayFrom = 1
                  If loc_sTrackPath = "" Then                                       'if there is no track path in the movie then make available from the chapter
                     loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, "PathMedium")
                     If loc_sTrackPath <> "" Then iPlayFrom = 2
                  End If
                  If loc_sTrackPath = "" Then                                       'if there is no track path in the movie then make available from the chapter
                     loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, "PathSmall")
                     If loc_sTrackPath <> "" Then iPlayFrom = 3
                  End If
                  
                  
                  If loc_sTrackPath = "" Then                                       'if there is no track path in the movie then make available from the chapter
                     loc_sTrackPath = .AbsoluteField(loc_iTrackSeek, "Path")
                     If loc_sTrackPath <> "" Then iPlayFrom = 4
                  End If
               End If
            End If
         Else
            If albumID > 0 Then
               'if the there is no track id but it has the albumID,so it is Trialer Movie
               loc_sTrackPath = GetAlbumField(albumID, "PathTrailer")
               If loc_sTrackPath <> "" Then
                   iPlayFrom = 6
               End If
            End If
         End If
      End If
   End With
   GetTrackPath = loc_sTrackPath
   Exit Function
Error:
   WriteEvent "GetTrackPath", Err.Description, Err.Source
End Function
Public Function GetMood() As String
   On Error GoTo Error
  Dim tblArtist As New TableCls, stringData As String
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, intIndex As Integer
  Dim i As Long
  
  Dim varData() As Variant
  GetMood = strTmp
   Exit Function
Error:
   WriteEvent "GetMood", Err.Description, Err.Source
End Function


Public Function GetArtist() As String
   On Error GoTo Error
  Dim stringData As String
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, intIndex As Integer
  Dim i As Long
  
   With PV_TableActor
      intIndex = .FieldToIndex("Unicode")
      ReDim var_SearchArtist(.RecordCount - 1)
      For i = 0 To .RecordCount - 1
         var_SearchArtist(i) = Array(.AbsoluteField(i, 1), .AbsoluteField(i, intIndex), .AbsoluteField(i, 0))
      Next
   End With
   
   QuickSort var_SearchArtist, Array(0)
   
   For i = 0 To i - 1
      strTmp = strTmp + strPlus + Join(var_SearchArtist(i), de_Field)
      strPlus = de_Record
   Next
  GetArtist = strTmp
   Exit Function
Error:
   WriteEvent "GetArtist", Err.Description, Err.Source
End Function
Public Function GetLabel() As String
   On Error GoTo Error
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, intIndex As Integer
  Dim i As Long
  Dim varData() As Variant
  
   With PV_TableLabel
      If .RecordCount = 0 Then Exit Function
      intIndex = .FieldToIndex("Unicode")
      ReDim varData(.RecordCount - 1)
      For i = 0 To .RecordCount - 1
         varData(i) = Array(.AbsoluteField(i, 0), .AbsoluteField(i, 1), (.AbsoluteField(i, intIndex)), 0)
      Next
   
   End With
   QuickSort varData, Array(1)
   For i = 0 To i - 1
      strTmp = strTmp + strPlus & Join(varData(i), de_Field)
      strPlus = de_Record
   Next
  GetLabel = strTmp
   Exit Function
Error:
   WriteEvent "GetLabel", Err.Description, Err.Source
End Function

Public Function SearchAlbumByLabel(ByVal LabelName As String, selectType As AlbumEnum) As String
   On Error GoTo Error
    Dim LabelID As Integer
   LabelID = SearchLabelIDInPlayList(LabelName)
   If LabelID > 0 Then
      SearchAlbumByLabel = AlbumByLabel(LabelID, , selectType, , , True)
   End If
   Exit Function
Error:
   WriteEvent "SearchAlbumByLabel", Err.Description, Err.Source
End Function
Public Function SearchAlbum(ByVal albumName As String, unicode As Boolean, selectType As AlbumEnum, Optional ArrangeBy As SortEnum = stNone, Optional Favorite As AlbumEnum = All) As Integer
   On Error GoTo Error
   'If (LCase(prv_Country) = "english") Then unicode = False
   If InStr(1, prv_Country, "english", vbTextCompare) > 0 Then unicode = False
   Dim stringAvailable As String, i As Long, sortIndices As Variant
   Dim stringSearch As String
   Dim stringFavorite As String
   Dim count As Integer
   Dim Increase As Integer
   Dim currentTypeCDID As Integer
   Dim boolLanguageKhmer As Boolean
   Dim searchCount As Long
   
   Dim initAvailable As Integer
   Dim loc_Flag As Integer
   Dim stringAlbumName As String
   Dim lngALbumID As Long
   Dim iTextCompare As VbCompareMethod
   
   'albumName = Replace(albumName, "*", "")
   boolLanguageKhmer = InStr(1, prv_Country, "khmer", vbTextCompare) > 0
   
   With PV_TableMovie
      Erase var_SearchAlbum
      For i = 0 To .RecordCount - 1
         If unicode Then
            stringAlbumName = .AbsoluteField(i, "Unicode")
            iTextCompare = vbBinaryCompare
         Else
            stringAlbumName = .AbsoluteField(i, "Name")
            iTextCompare = vbTextCompare
         End If
         ' If unicode And boolLanguageKhmer Then stringAlbumName = CKhmer.GS_WordChange(stringAlbumName)
         If InStr(1, stringAlbumName, albumName, iTextCompare) > 0 And stringAlbumName <> "" Then   'found the desire album
            lngALbumID = .AbsoluteField(i, 0)
            initAvailable = getAlbumAvailable(prv_Country, lngALbumID)
            If IsCDAvailable(initAvailable, selectType) Then
               loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
               ReDim Preserve var_SearchAlbum(searchCount)
               var_SearchAlbum(searchCount) = GetAlbumInfos(i, initAvailable, 0, False, loc_Flag)
               searchCount = searchCount + 1
            End If
         End If
      Next
      If searchCount > 0 Then
         sortIndices = ReturnSortArray(3, True, 11, mSelectGroupCDType <> -1, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
         QuickSort var_SearchAlbum, sortIndices
      End If
      
   End With
   SearchAlbum = searchCount
   Exit Function
Error:
   WriteEvent "SearchAlbum", Err.Description, Err.Source
End Function
Public Function GetNextTrack(intIndex As Long, intCount As Integer) As String
  On Error GoTo ErrorBound
  
  Dim i As Integer, strTmp As String, strPlus As String, Available As Integer
  Dim TrackID As Long
   For i = intIndex To intIndex + intCount
   
      If strTmp = "" Then strPlus = "" Else strPlus = de_Record
      TrackID = var_SearchTrack(i)(14)
      Available = var_SearchTrack(i)(21)
                                       
      strTmp = strTmp & strPlus & var_SearchTrack(i)(5) & de_Field & var_SearchTrack(i)(6) & Delimiter & var_SearchTrack(i)(1) & de_Field & var_SearchTrack(i)(2) & Delimiter & var_SearchTrack(i)(3) & de_Field & var_SearchTrack(i)(4) & Delimiter & var_SearchTrack(i)(12) & de_Field & var_SearchTrack(i)(13) & Delimiter & var_SearchTrack(i)(7) & de_Field & var_SearchTrack(i)(8) & Delimiter & var_SearchTrack(i)(9) & de_Field & var_SearchTrack(i)(0) & Delimiter & var_SearchTrack(i)(11) & Delimiter & var_SearchTrack(i)(0) & de_Field & var_SearchTrack(i)(0) & Delimiter & TrackID & Delimiter & 0 & Delimiter & var_SearchTrack(i)(17) & Delimiter & var_SearchTrack(i)(18) & Delimiter & ReverseDate(var_SearchTrack(i)(19)) & Delimiter & var_SearchTrack(i)(20) & Delimiter & Available & Delimiter & var_SearchTrack(i)(22) & Delimiter & var_SearchTrack(i)(23) & Delimiter & var_SearchTrack(i)(24) & Delimiter & var_SearchTrack(i)(25)
      '                                         0                                                                  1                                                                   2                                                                       3                                                                       4                                                                       5                                                                    6                                     7                                                               8                   9                10                                          11                                        12                                           13                             14                                15                             16                                     17                                     18
   Next
ErrorBound:
  GetNextTrack = strTmp
End Function
Public Function GetDanceStyle() As String
   On Error GoTo Error
  Dim tblArtist As New TableCls, stringData As String
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, intIndex As Integer
  Dim i As Long
  
  Dim varData() As Variant
  GetDanceStyle = strTmp         ' return nothing with dance style
   Exit Function
Error:
   WriteEvent "GetDanceStyle", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   AlbumByArtistIDs
' Description       :
' Return Values     :
' Input Parameter   :   ArtistIDs(;)
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             05-10-2006           New
'*******************************************************************************


Public Function AlbumByArtistIDs(ArtistIDs As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As CDTypeEnum = AllCD, Optional searchMode As Boolean) As Long
   On Error GoTo Error
   Dim i As Long, j As Integer
   Dim fieldAvailable As Integer
   Dim count As Integer
   Dim SortKey As Integer
   Dim dataAvailable As Integer
   Dim boolSelect As Boolean
   Dim fieldArtistIDs As Integer
   Dim arrArtistIDs() As String
   Dim strArtistAlbum As String
   Dim stringAlbumName As String
   Dim stringDate As String
   Dim boolArtistFound As Boolean
   Dim loc_Flag As Integer
   
   
   If searchMode Then Erase var_SearchAlbum Else Erase var_Album
   With PV_TableMovie
      fieldAvailable = .FieldToIndex("Available")
      fieldArtistIDs = .FieldToIndex("ActorID")
      fieldGroupCDType = .FieldToIndex("TypeCDID")
      SortKey = 0
      arrArtistIDs = Split(ArtistIDs, ";")
      
      For i = 0 To .RecordCount - 1
         dataAvailable = .AbsoluteField(i, fieldAvailable)
         If selectType <> All Then
            boolSelect = (dataAvailable = selectType)
         Else
            boolSelect = True
         End If
         stringAlbumName = .AbsoluteField(i, 1)
         strArtistAlbum = .AbsoluteField(i, fieldArtistIDs)
         For j = 1 To UBound(arrArtistIDs) - 1
            boolArtistFound = (InStr(1, strArtistAlbum, ";" & arrArtistIDs(j) & ";") > 0) And (arrArtistIDs(j) <> "")
            If boolArtistFound Then Exit For
         Next
         boolSelect = boolSelect And boolArtistFound
         If boolSelect Then
            currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
            loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
            If IsValidCDType(loc_Flag, CDType) And isValidGroupType(currentGroupCDType) Then
               If searchMode Then
                  ReDim Preserve var_SearchAlbum(count)
                  var_SearchAlbum(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
               Else
                  ReDim Preserve var_Album(count)
                  var_Album(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
               End If
               count = count + 1
            End If
         End If
      Next
   End With
   Dim sortIndices As Variant, reverse As Boolean
   sortIndices = ReturnSortArray(3, True, 11, True, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
   If count > 0 Then
      If searchMode Then
         QuickSort var_SearchAlbum, sortIndices, False
      Else
         QuickSort var_Album, sortIndices, False
      End If
   End If
   AlbumByArtistIDs = count
   Exit Function
Error:
   WriteEvent "AlbumByArtistIDs", Err.Description, Err.Source
End Function

Public Function AlbumByLabel(ByVal LabelID As Integer, Optional letter As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As CDTypeEnum = AllCD, Optional searchMode As Boolean) As Long
   On Error GoTo Error
   'Last Update 2005-07-26       Seng         'Still having problem
   'browse album
   Dim i As Long
   Dim fieldAvailable As Integer
   Dim count As Integer
   Dim SortKey As Integer
   Dim dataAvailable As Integer
   Dim boolSelect As Boolean
   Dim fieldArtistID As Integer
   Dim fieldLabelID As Integer
   Dim stringAlbumName As String
   Dim stringDate As String
   Dim loc_Flag As Integer
   Dim loc_AlbumID As Long
   Dim loc_LabelID As Long
   
   
   If searchMode Then Erase var_SearchAlbum Else Erase var_Album
   With PV_TableMovie
      fieldAvailable = .FieldToIndex("Available")
      fieldLabelID = .FieldToIndex("LabelID")
      fieldGroupCDType = .FieldToIndex("TypeCDID")
      SortKey = 0
      
      
      For i = 0 To .RecordCount - 1
         loc_LabelID = .AbsoluteField(i, fieldLabelID)
         If loc_LabelID = LabelID Then
            loc_AlbumID = .AbsoluteField(i, 0)
            dataAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
            If selectType = All Then
               boolSelect = True
            Else
               boolSelect = IsCDAvailable(dataAvailable, selectType)
            End If
            If boolSelect Then
               stringAlbumName = .AbsoluteField(i, 1)
               If (letter = vbNullString Or IsCorrectStartLetter(letter, stringAlbumName)) Then
                  currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
                  loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
                  If IsValidCDType(loc_Flag, mSelectFlagType) And isValidGroupType(currentGroupCDType) Then
                     If searchMode Then
                        ReDim Preserve var_SearchAlbum(count)
                        var_SearchAlbum(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
                     Else
                        ReDim Preserve var_Album(count)
                        var_Album(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
                     End If
                     count = count + 1
                  End If
               End If
               
            End If
         End If
      
'''         loc_AlbumID = .AbsoluteField(i, 0)
'''         dataAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
'''         boolSelect = IsCDAvailable(dataAvailable, selectType) ' selectType (selectType = all) Or (selectType = NotAvailable And dataAvailable = 0) Or (selectType = Available And dataAvailable <> 0)
'''         stringAlbumName = .AbsoluteField(i, 1)
'''
'''         boolSelect = boolSelect And (.AbsoluteField(i, fieldLabelID) = LabelID)
'''         If boolSelect And (letter = vbNullString Or IsCorrectStartLetter(letter, stringAlbumName)) Then
'''            currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
'''            loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
'''            If IsValidCDType(loc_Flag, mSelectFlagType) And isValidGroupType(currentGroupCDType) Then
'''               If searchMode Then
'''                  ReDim Preserve var_SearchAlbum(count)
'''                  var_SearchAlbum(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
'''               Else
'''                  ReDim Preserve var_Album(count)
'''                  var_Album(count) = GetAlbumInfos(i, dataAvailable, SortKey, True, loc_Flag)
'''               End If
'''               count = count + 1
'''            End If
'''         End If
      Next
   End With
   Dim sortIndices As Variant, reverse As Boolean
   sortIndices = ReturnSortArray(3, True, 11, True, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
   If count > 0 Then
      If searchMode Then
         QuickSort var_SearchAlbum, sortIndices, False
      Else
         QuickSort var_Album, sortIndices, False
      End If
   End If
   AlbumByLabel = count
   Exit Function
Error:
   WriteEvent "AlbumByLabel", Err.Description, Err.Source
End Function


Public Function AlbumByRating(Rating As Integer, Optional letter As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As AlbumEnum = AllCD) As String
   On Error GoTo Error
   'browse album              'Last update by Seng 2005-07-26     Not completed yet
   Dim i As Long
   Dim fieldDate As Integer, fieldAvailable As Integer
   Dim stringArtist As String
   Dim count As Integer
   Dim groupArtist As String
   Dim SortKey As Integer
   Dim dataAvailable As Integer
   Dim AlbumArtistID As Integer
   Dim fieldUnicodeName As Integer
   Dim fieldArtistID As Integer
   Dim fieldLabelID As Integer
   Dim fieldRating As Integer
   Dim fieldFavorite As Integer
   Dim loc_Flag As Integer
   Dim loc_AlbumID As Long
   Dim stringAlbumName As String
   Dim stringDate As String
   Dim intRating As Integer
   
   Erase var_Album
   With PV_TableMovie
      fieldDate = .FieldToIndex("Year")
      fieldAvailable = .FieldToIndex("Available")
      fieldUnicodeName = .FieldToIndex("Unicode")
      fieldLabelID = .FieldToIndex("LabelID")
      fieldRating = .FieldToIndex("Rating")
      fieldFavorite = .FieldToIndex("Favorite")
      fieldGroupCDType = .FieldToIndex("TypeCDID")
      
      For i = 0 To .RecordCount - 1
         intRating = .AbsoluteField(i, fieldRating)
         If intRating = Rating Then
            loc_AlbumID = .AbsoluteField(i, 0)
            dataAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
            If IsCDAvailable(dataAvailable, selectType) Then
               stringAlbumName = .AbsoluteField(i, 1)
               If IsCorrectStartLetter(letter, stringAlbumName) Then
                  currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
                  loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
                  If IsValidCDType(loc_Flag, CDType) And isValidGroupType(currentGroupCDType) Then
                     ReDim Preserve var_Album(count)
                     SortKey = 0
                     Dim artistgroup As String
                     
                     artistgroup = .AbsoluteField(i, "Singer")
                     stringDate = .AbsoluteField(i, fieldDate)
                     var_Album(count) = GetAlbumInfos(i, dataAvailable, SortKey, False, loc_Flag)
                     'var_Album(count) = Array(.AbsoluteField(i, 0), stringAlbumName, .AbsoluteField(i, fieldUnicodeName), SortKey, ChangeDate(stringDate), artistgroup, intRating, dataAvailable, .AbsoluteField(i, fieldFavorite), CurrentlanguageID, .AbsoluteField(i, "Rank"), currentGroupCDType, .AbsoluteField(i, "UnicodeSinger"))
                     '                                0                 1                                      2             3         4         5           6           7                   8                               9                    10
                     count = count + 1
                  End If
               End If
            End If
         End If
      Next
   End With
   Dim sortIndices As Variant, reverse As Boolean
   sortIndices = ReturnSortArray(3, True, 11, True, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
   If count > 0 Then QuickSort var_Album, sortIndices, False
   AlbumByRating = count
   Exit Function
Error:
   WriteEvent "AlbumByRating", Err.Description, Err.Source
End Function
'Public Function AlbumByLetter() As Integer
' may be not used anymore
Public Function GetAlbumInfos(Index As Long, albumAvailable As Integer, SortKey As Integer, LeaveYear As Boolean, AlbumFlag As Integer) As Variant
   On Error GoTo Error
   Dim albumID As Long, albumName As String, albumUnicode As String, albumYear As String
   Dim AlbumRating As Long, AlbumFavorite As Long, AlbumRank As Long
   Dim AlbumActor As String, AlbumActorUnicode As String
   Dim AlbumDirector As String
   Dim ALbumLabel As String
   Dim AlbumArtist  As String
   
   Dim AlbumGroupCDType As Integer
   Dim AlbumDate As Date
   Dim AlbumAudioIDs As String
   Dim AlbumArtistID As Long
   Dim TVSeriesID As Long
   Dim numSeason As Long
   'modified 2005-08-23/seng
   
   With PV_TableMovie
      albumID = .AbsoluteField(Index, "ID")
      albumName = .AbsoluteField(Index, "Name")
      albumUnicode = .AbsoluteField(Index, "Unicode")
      albumYear = .AbsoluteField(Index, "Year")
      AlbumRating = .AbsoluteField(Index, "Rating")
      AlbumFavorite = .AbsoluteField(Index, "Favorite")
      AlbumRank = .AbsoluteField(Index, "Rank")
      ALbumLabel = .AbsoluteField(Index, "Label")                   'Use label instead of Singer
      AlbumActorUnicode = .AbsoluteField(Index, "LabelUnicode")           'Use label instead of Singer
      AlbumGroupCDType = .AbsoluteField(Index, "TypeCDID")               'Use label instead of Singer
      
      AlbumArtistID = .AbsoluteField(Index, "AlbumArtistID")
      TVSeriesID = .AbsoluteField(Index, "TVID")
      If TVSeriesID > 0 Then
         numSeason = .AbsoluteField(Index, "numSeason")
         AlbumArtist = GetTVSeriesName(TVSeriesID) & "\Season # " & (numSeason)
      ElseIf AlbumArtistID > 0 Then
         AlbumArtist = GetActorName(";" & AlbumArtistID & ";", False)
      End If
      
      If AlbumArtist <> "" Then ALbumLabel = AlbumArtist
      AlbumDate = ChangeDate(albumYear, LeaveYear)
      AlbumAudioIDs = .AbsoluteField(Index, "AudioIDs")
      ' AlbumFlag=
      AlbumDirector = GetDirectorName(.AbsoluteField(Index, "DirectorIDs"), 2)
      AlbumActor = GetActorName(.AbsoluteField(Index, "ActorID"), False)
      Call isValidGroupType(AlbumGroupCDType)
                              '0          1           2           3        4              5              6           7                 8       9     10           11                   12             13          14             15             16
      GetAlbumInfos = Array(albumID, albumName, albumUnicode, SortKey, AlbumDate, ALbumLabel, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, AlbumActorUnicode, AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
      
   End With
   Exit Function
Error:
   WriteEvent "GetAlbumInfos", Err.Description, Err.Source
End Function
Public Function AlbumByArtistLetter(letter As String, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Integer
   MsgBox "May not be useed Function = AlbumByArtistLetter"
End Function

Public Sub EditAlbumRating(albumID As Long, Rating As Integer)
   On Error GoTo Error
   SetAlbumField albumID, "Rating", Rating
   Exit Sub
Error:
   WriteEvent "EditAlbumRating", Err.Description, Err.Source
End Sub

Public Function GetArtistStringIDByLetter(startLetter As String) As String
   On Error GoTo Error
  Dim tblArtist As New TableCls, stringData As String
  Dim boolFirst As Boolean, strPlus As String
  Dim strTmp As String, fieldGroupArtist As Integer
  Dim i As Long
  
  'SetFolder
  tblArtist.Opens "Artist"
  fieldGroupArtist = tblArtist.FieldToIndex("GroupArtist")
  For i = 0 To tblArtist.RecordCount - 1
      stringData = tblArtist.AbsoluteField(i, 1)
      If IsCorrectStartLetter(startLetter, stringData) Then
         strTmp = strTmp & tblArtist.AbsoluteField(i, 0) & ";"
      End If
  Next
  strTmp = ";" & strTmp
  GetArtistStringIDByLetter = strTmp
   Exit Function
Error:
   WriteEvent "GetArtistStringIDByLetter", Err.Description, Err.Source
End Function
Public Sub SetAlbumField(ID As Long, FieldName As String, Value As Variant)
   On Error GoTo Error
   Dim searchIndex As Long, fieldIndex As Integer
   
   With PV_TableMovie
      searchIndex = .Seeks(ID)
      If searchIndex >= 0 Then
         fieldIndex = .FieldToIndex(FieldName)
         If fieldIndex >= 0 Then .AbsoluteEdit(searchIndex, fieldIndex) = Value
      End If
   End With
   Exit Sub
Error:
   WriteEvent "SetAlbumField", Err.Description, Err.Source
End Sub
Public Function SetAlbumFavorite(ID As Long, values As Boolean) As Boolean
   On Error GoTo Error
   Dim dataValue As Integer
   dataValue = IIf(values, 1, 0)
   SetAlbumField ID, "Favorite", dataValue
   SetAlbumFavorite = True
   Exit Function
Error:
   WriteEvent "SetAlbumFavorite", Err.Description, Err.Source
End Function

Public Function SetArtistFavorite(ID As Long, values As Boolean) As Boolean
   On Error GoTo Error
   Dim dataValue As Integer
   Dim seekIndex As Long
   
   dataValue = IIf(values, 1, 0)
   With PV_TableActor
      seekIndex = .Seeks(ID)
      If seekIndex >= 0 Then
         .AbsoluteEdit(seekIndex, .FieldToIndex("Favorite")) = dataValue
      End If
   End With
   SetArtistFavorite = True
   Exit Function
Error:
   WriteEvent "SetArtistFavorite", Err.Description, Err.Source
End Function

Public Sub SetArtistRating(ID As Long, values As Integer)
   On Error GoTo Error
   Dim seekIndex As Long
   With PV_TableActor
      seekIndex = .Seeks(ID)
      If seekIndex >= 0 Then
         .AbsoluteEdit(seekIndex, .FieldToIndex("Rating")) = values
      End If
   End With
   Exit Sub
Error:
   WriteEvent "SetArtistRating", Err.Description, Err.Source
End Sub

Public Sub SetAlbumRank(ID As Long, values As Integer)
   On Error GoTo Error
   SetAlbumField ID, "Rank", values
   Exit Sub
Error:
   WriteEvent "SetAlbumRank", Err.Description, Err.Source
End Sub
Public Function GetFavoriteAlbum() As Integer
   On Error GoTo Error
   Dim count As Integer
   Dim intAvailable As Integer
   Dim boolFound As Boolean
   
   With PV_TableMovie
      boolFound = .FindFirst("Favorite=1")
      While boolFound
         intAvailable = .Field("Available")
         If (mSelectAlbumType = All) Or (mSelectAlbumType = intAvailable) Then
            currentGroupCDType = .Field("TypeCDID")

            If IsValidCDType(.Field("Flag"), mSelectFlagType) And isValidGroupType(currentGroupCDType) Then
               ReDim Preserve var_Album(count)
                var_Album(count) = Array(.Field(0), .Field(1), .Field("UnicodeName"), 0, 0, .Field("Singer"), 0, intAvailable, .Field("Favorite"), 0, .Field("Rank"), currentGroupCDType, .AbsoluteField(0, "UnicodeSinger"))
               count = count + 1
            End If
         End If
         boolFound = .FindNext
      Wend
   End With
   If count > 0 Then QuickSort var_Album(), Array(1)
   
   GetFavoriteAlbum = count
   Exit Function
Error:
   WriteEvent "GetFavoriteAlbum", Err.Description, Err.Source
End Function

Public Function GetTopAlbum(TopType As Integer, Optional selectFavoriteAlbum As Boolean = True, Optional selectFromList As Boolean) As Integer
   On Error GoTo Error
   'browse album
   'TopType=-2
   'TopType=0 indicate Relase Date
   'TopType=1 indicate Rating
   'TopType=7 indicate Rank
   
   'TopType=-2
   'TopType=0 indicate Rating
   'TopType=1 indicate Relase Date
   'TopType=7 indicate Rank
   
   
   'selectFavoriteAlbum=true indicate favorite album
   'selectFavoriteAlbum=fales indicate my album
   'selectFromList=true -> select from the collection
   
   Dim i As Long
   Dim tbl As New TableCls
   'Dim ARTIST As Variant
   Dim SingerID As Long
   Dim albumID As Long
   
   'Dim fieldSinger As Integer
   Dim fieldUnicodeName As Integer
   Dim fieldYear As Integer
   Dim fieldFavorite As Integer
   Dim fieldRating As Integer
   Dim fieldAvailable As Integer
   Dim fieldRank As Integer
   Dim count As Integer
   Dim fields As Variant
   Dim fieldFlag As Integer
   
   Dim boolSelectMyFavorite As Boolean
   Dim boolSelectAvailable As Boolean
   Dim intAvailable As Integer
   Dim mainSortIndex As Integer
   Dim loc_Flag As Integer
   Dim COLAvailable As Collection
   'SetFolder
   mainSortIndex = 3 + TopType 'for choosing the sort type
   With PV_TableMovie
         If .RecordCount = 0 Then Exit Function
         Set COLAvailable = LoadAvailableToCollection(prv_Country)                '2007-01-11 Seng Increase Browsing Speed
         
         'fieldSinger = .FieldToIndex("Label")
         fieldUnicodeName = .FieldToIndex("LabelUnicode")
         fieldYear = .FieldToIndex("Year")
         fieldFavorite = .FieldToIndex("Favorite")
         fieldRating = .FieldToIndex("Rating")
         fieldAvailable = .FieldToIndex("Available")
         fieldRank = .FieldToIndex("Rank")
         fieldGroupCDType = .FieldToIndex("TypeCDID")
         fieldFlag = .FieldToIndex("Flag")
         
         For i = 0 To .RecordCount - 1
             currentGroupCDType = .AbsoluteField(i, fieldGroupCDType)
             'intAvailable = .AbsoluteField(i, fieldAvailable)
             
             albumID = .AbsoluteField(i, 0)
             If IsKeyExist(COLAvailable, "ID" & albumID) Then                    '2007-01-11 Seng Increase Browsing Speed
               intAvailable = getAlbumAvailable(prv_Country, albumID)
             Else                                                                '2007-01-11 Seng Increase Browsing Speed
               intAvailable = 0                                                  '2007-01-11 Seng Increase Browsing Speed
             End If                                                              '2007-01-11 Seng Increase Browsing Speed
             boolSelectMyFavorite = (.AbsoluteField(i, fieldFavorite) = 1)
            boolSelectAvailable = IsCDAvailable(intAvailable, mSelectAlbumType)
            
            If selectFromList Then
              If getItemFromID(collectionSelectList, albumID) <> "" Then
                 boolSelectAvailable = True
              End If
            End If
             If ((selectFavoriteAlbum And boolSelectMyFavorite And boolSelectAvailable) Or ((selectFavoriteAlbum = False) And (intAvailable <> 0))) And isValidGroupType(currentGroupCDType) Then
               fields = .fields(i)
               loc_Flag = FlagCDOrder(fields(fieldFlag))
               ReDim Preserve var_Album(count)
               
               var_Album(count) = GetAlbumInfos(i, intAvailable, 5 - fields(fieldRating), True, loc_Flag)      'modified 2005-08-23 /seng
               count = count + 1
            End If
         Next
   End With
   ' Artist ===>> CDType ===>> Others
   
   Dim SortArray As Variant
   'Modified by seng    '11
   'Sort type >>>Artist>>>Sort Index
   SortArray = ReturnSortArray(5, mSelectGroupCDType <> -1, mainSortIndex, True, 1, mainSortIndex <> 1)
   If count > 0 Then QuickSort var_Album, SortArray
   
   GetTopAlbum = count
   Exit Function
Error:
   WriteEvent "GetTopAlbum", Err.Description, Err.Source
End Function
Public Function IsKeyExist(colObj As Collection, ID As String) As Boolean
   On Error GoTo NoKey
   colObj (ID)
   IsKeyExist = True
NoKey:
End Function
Public Function LoadAvailableToCollection(languageName As String) As Collection
   Dim XmlDoc As New DOMDocument
   Dim xml As IXMLDOMNodeList
   Dim xmlElement As IXMLDOMElement
   Dim loc_Collection As New Collection
   Dim loc_ID As String
   
   If XmlDoc.Load(SlyVariable("<MyAlbumServer>")) Then
      Set xml = XmlDoc.selectNodes("//Machines/Machine/Language[@Name='" & languageName & "']")
      For Each xmlElement In xml
         loc_ID = xmlElement.getAttribute("ID")
         If IsKeyExist(loc_Collection, "ID" & loc_ID) = False Then
            loc_Collection.Add loc_ID, "ID" & loc_ID
         End If
      Next
   End If
   Set LoadAvailableToCollection = loc_Collection
End Function
Public Function GetNextArtist(startIndex As Integer, count As Integer, Optional searchMode As Boolean) As String
' ID Name Unicode Favorite LanguageID Rating Release
'  0  1     2       3        4         5        6
   On Error GoTo ErrorOccure:
   Dim i As Integer, tmp As String, strPlus As String
   Dim intMax As Integer
   Dim requestData() As Variant
   
   If searchMode Then requestData = var_SearchArtist Else requestData = var_Artist
   
   intMax = count - 1    'UBound(var_Artist)
   
   For i = startIndex To intMax + startIndex
      If i > intMax Then Exit For
      requestData(i)(4) = 0
      tmp = tmp & strPlus & Join(requestData(i), de_Field)
      strPlus = de_Record
   Next
ErrorOccure:
   GetNextArtist = tmp
End Function
''Public Sub language(ByVal ID As Integer)
''   If ID > 0 Then prv_IsUnicode = (ID > 2)
''End Sub
Private Sub LoadTypeCD()
   On Error GoTo Error
   Dim tbl As New TableCls
   Dim i As Long
   Dim typeName As String
   Dim typeIndex As Long
   'store this array for sorting DVDs in group like movie,video,tv
   ' open flag and arrange the ids
   tbl.Opens "TypeCD"
      For i = 0 To tbl.RecordCount - 1
         typeName = LCase(tbl.Field(1))
         typeIndex = tbl.Field(0)
         Select Case typeName
         Case "movie"
            TypeCDOrder(typeIndex) = 1
         Case "tv"
            TypeCDOrder(typeIndex) = 2
         Case "video"
            TypeCDOrder(typeIndex) = 3
         Case "karaoke"
            TypeCDOrder(typeIndex) = 4
         Case Else
            TypeCDOrder(typeIndex) = 20
         End Select
         tbl.MoveNext
      Next
   tbl.Closes
   tbl.Opens "Flag"
      For i = 0 To tbl.RecordCount - 1
         typeName = tbl.Field("Name")
         typeIndex = tbl.Field("ID")
         Select Case UCase(typeName)
            Case "G"
               FlagCDOrder(typeIndex) = 1
            Case "PG"
               FlagCDOrder(typeIndex) = 2
            Case "PG-13"
               FlagCDOrder(typeIndex) = 3
            Case "R"
               FlagCDOrder(typeIndex) = 4
            Case "NC-17"
               FlagCDOrder(typeIndex) = 5
            Case "ADULT"
               FlagCDOrder(typeIndex) = 6
            Case "NR"
               FlagCDOrder(typeIndex) = 7
            Case Else
               FlagCDOrder(typeIndex) = 20
         End Select
         tbl.MoveNext
         'FlagCDOrder(typeIndex) = i
      Next
   tbl.Closes
   Exit Sub
Error:
   WriteEvent "LoadTypeCD", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   AlbumByGenre
' Description       :   Browse album by genre
' Return Values     :   Number of album found
' Input Parameter   :   GenreID,Start letter......
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             09-08-2005           New
'*******************************************************************************
Public Function AlbumByGenre(ByVal GenreID As Integer, letter As String, Optional ByVal selectType As AlbumEnum = All, Optional ByVal CDType As CDTypeEnum = AllCD, Optional ByVal ArrangeBy As SortEnum) As Long
   On Error GoTo Error
   Dim i As Long, sortIndices As Variant
   Dim loc_fieldGenreID As Integer, loc_fieldAvailable As Integer, loc_fieldFlag As Integer
   Dim loc_Available As Integer, loc_FieldName As Integer
   Dim loc_Count As Long, loc_AlbumName As String, loc_Flag As Integer, loc_GenreIDs As String
   Dim loc_boolLeaveDate As Boolean
   Dim loc_AlbumID As Long
   
   Erase var_Album
   
   With PV_TableMovie
      loc_fieldGenreID = .FieldToIndex("GenreIDs")
      loc_fieldAvailable = .FieldToIndex("Available")
      loc_fieldFlag = .FieldToIndex("Flag")
      loc_FieldName = .FieldToIndex("Name")
      If letter = "All" Then letter = ""
      loc_boolLeaveDate = ArrangeBy = stDate
      For i = 0 To .RecordCount - 1
         If GenreID = 0 Then loc_GenreIDs = ";0;" Else loc_GenreIDs = .AbsoluteField(i, loc_fieldGenreID)
         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
         
         If InStr(1, loc_GenreIDs, ";" & GenreID & ";", vbTextCompare) > 0 Then
            loc_AlbumName = .AbsoluteField(i, loc_FieldName)
            'loc_Available = .AbsoluteField(i, loc_fieldAvailable)
            If IsCorrectStartLetter(letter, loc_AlbumName) Then
               loc_AlbumID = .AbsoluteField(i, 0)           'Album ID
               loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
               If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
                  ReDim Preserve var_Album(loc_Count)
                  var_Album(loc_Count) = GetAlbumInfos(i, loc_Available, 0, loc_boolLeaveDate, loc_Flag)
                  loc_Count = loc_Count + 1
               End If
            End If
         End If
      Next
   End With
   If loc_Count > 0 Then
      'sort by name only
      sortIndices = ReturnSortArray(4, ArrangeBy = stDate, 1, True)
      'sortIndices = ReturnSortArray(4, mSelectGroupCDType = 0, 1, True)
      QuickSort var_Album, sortIndices, False
   End If
   AlbumByGenre = loc_Count
   Exit Function
Error:
   WriteEvent "AlbumByGenre", Err.Description, Err.Source
End Function
Public Function ArtistByGenreNletter(GenreID As Integer, Optional letter As String) As String
   On Error GoTo Error
   'edited 2005-08-09
   'Seng
   Dim i As Long
   Dim count As Integer
   Dim ArtistID As Long
   
   Dim stringActors As String
   Dim stringActorsID As String
   Dim arrayActor() As String
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_GenreIDs As String
   Dim loc_ArtistName As String
   Dim loc_AlbumID As Long
   Dim j As Long
   
   With PV_TableMovie
      stringActorsID = ";"
      For i = 0 To .RecordCount - 1
      
         loc_GenreIDs = .AbsoluteField(i, "GenreIDs")
      
         If IsValidGenre(GenreID, loc_GenreIDs) Then
               stringActors = .AbsoluteField(i, "ActorID")
               arrayActor = Split(stringActors, ";")
               For j = 1 To UBound(arrayActor) - 1
                  ArtistID = val(arrayActor(j))
                  If InStr(stringActorsID, ";" & ArtistID & ";") = 0 Then 'add to string list
                        If PV_TableActor.Seeks(ArtistID) >= 0 Then
                           loc_ArtistName = PV_TableActor.Field(1)
                           If IsCorrectStartLetter(letter, loc_ArtistName) Then
                              loc_AlbumID = .AbsoluteField(i, 0)
                              loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
                              If IsCDAvailable(loc_Available, mSelectAlbumType) Then
                                 ReDim Preserve var_Artist(count)
                                 var_Artist(count) = Array(ArtistID, loc_ArtistName, PV_TableActor.Field(2), PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
                                 count = count + 1
                                 stringActorsID = stringActorsID & arrayActor(j) & ";"
                              End If
                           End If
                        End If
                     
                  End If
                  If bCancelBrowse Then Exit For
               Next
'            End If    'isvalidcdtype
         End If
         If bCancelBrowse Then Exit For
      Next
   End With
 
 
   bCancelBrowse = False
   If count > 0 Then
     QuickSort var_Artist, Array(1)
     ArtistByGenreNletter = GetNextArtist(0, count)
   Else
      ArtistByGenreNletter = ""
   End If
   Exit Function
Error:
   WriteEvent "ArtistByGenreNletter", Err.Description, Err.Source
End Function
Public Function FavoriteArtistID() As String
   On Error GoTo Errors
   Dim i As Long
   Dim returnArtists As String
   Dim returnCount As Long
   Dim varFavorite As Integer

'   ReDim returnArtists(-1 To -1)
   With PV_TableActor
      For i = 0 To .RecordCount - 1
         varFavorite = .AbsoluteField(i, "Favorite")
         If (varFavorite = 1) Then
            returnArtists = returnArtists & ";" & .AbsoluteField(i, 0)
            ''ReDim Preserve returnArtists(-1 To returnCount)
            'returnArtists(returnCount) = .AbsoluteField(i, 0)
            returnCount = returnCount + 1
         End If
      Next
   End With
Errors:
   FavoriteArtistID = returnArtists & ";"
End Function

Public Function GetFavoriteArtist(getType As Integer, Optional max As Integer = 50)
   On Error GoTo Error
'getType = 1 indicate  name
'getType = 5 indicate  rank
'getType = 6 indicate  date
   'edited 2005-08-09
   'Seng
   Dim i As Long
   Dim count As Integer
   Dim ArtistID As Long
   
   Dim stringActors As String
   Dim stringActorsID As String
   Dim arrayActor() As String
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_Favorite As Integer
   Dim loc_Artists As String
   Dim ArtistIDs As String
   Dim loc_allIDs() As Long
   Dim loc_AlbumID As Long
   Dim j As Long
   
   With PV_TableMovie
      ArtistIDs = FavoriteArtistID()
      For i = 0 To .RecordCount - 1
      
         'loc_Available = .AbsoluteField(i, "Available")
         loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
         loc_Artists = .AbsoluteField(i, "ActorID")
         loc_AlbumID = .AbsoluteField(i, 0)
         loc_allIDs = arraySearch(ArtistIDs, loc_Artists)
         loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
         For j = 0 To UBound(loc_allIDs)
            ArtistID = loc_allIDs(j)
            If ArtistID > 0 Then
               If IsValidCDType(loc_Flag, mSelectFlagType) And IsCDAvailable(loc_Available, mSelectAlbumType) Then
                  PV_TableActor.Seeks ArtistID
                  ArtistIDs = Replace(ArtistIDs, ";" & ArtistID & ";", ";")
                  ReDim Preserve var_Artist(count)
                  var_Artist(count) = Array(ArtistID, PV_TableActor.Field(1), PV_TableActor.Field(2), PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
                  count = count + 1
               End If
            End If
         Next
      Next
   End With
   bCancelBrowse = False
   If count > 0 Then
     QuickSort var_Artist, Array(getType)
     GetFavoriteArtist = GetNextArtist(0, count)
   Else
      GetFavoriteArtist = ""
   End If
   Exit Function
Error:
   WriteEvent "GetFavoriteArtist", Err.Description, Err.Source
End Function
Public Function SearchArtistByIDs(IDStrings As String, unicode As Boolean, Optional albumAvailable As AlbumEnum = All) As String
   On Error Resume Next
   
   If (LCase(prv_Country) = "english") Then unicode = False
   Dim i As Long
   Dim ArtistCount As Integer
   Dim ArtistID As Long
   
   Dim stringActors As String
   Dim stringActorsID As String
   Dim arrayActor() As String
   Dim loc_Available As Integer
   Dim loc_ArtistName As String
   Dim j As Long
   
   Dim arrIDs() As String
   arrIDs = Split(IDStrings, ";")
   For j = 1 To UBound(arrIDs) - 1
      ArtistID = val(arrIDs(j))
      If ArtistID > 0 Then
         If PV_TableActor.Seeks(ArtistID) >= 0 Then
            ReDim Preserve var_SearchArtist(ArtistCount)
            var_SearchArtist(ArtistCount) = Array(ArtistID, PV_TableActor.Field(1), PV_TableActor.Field(2), PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
            ArtistCount = ArtistCount + 1
         End If
      End If
   Next
   If ArtistCount > 0 Then
     QuickSort var_SearchArtist, Array(1)
     SearchArtistByIDs = GetNextArtist(0, ArtistCount, True)
   End If
End Function


Public Function SearchArtist(SearchString As String, unicode As Boolean, Optional albumAvailable As AlbumEnum = All) As String
   On Error Resume Next
   
   If InStr(1, prv_Country, "english", vbTextCompare) > 0 Then unicode = False
   Dim i As Long
   Dim ArtistCount As Integer
   Dim ArtistID As Long
   Dim iTextCompare As VbCompareMethod
   
   Dim stringActors As String
   Dim arrayActor() As String
   Dim loc_Available As Integer
   Dim loc_ArtistName As String
   Dim loc_ArtistUnicode As String
   Dim loc_ArtistNormal As String
   Dim loc_ActorList As String
   Dim loc_AlbumID As Long
   Dim j As Long
   Dim indexFieldName As Integer
   Dim indexFound As Long
   loc_ActorList = ";"
   With PV_TableActor
      If unicode Then indexFieldName = .FieldToIndex("Unicode") Else indexFieldName = .FieldToIndex("Name")
      For i = 0 To .RecordCount - 1
         loc_ArtistName = .AbsoluteField(i, indexFieldName)
         If InStr(1, loc_ArtistName, SearchString, vbTextCompare) > 0 Then
            loc_ActorList = loc_ActorList & .AbsoluteField(i, 0) & ";"
         End If
      Next
   End With
   With PV_TableMovie
      For i = 0 To .RecordCount - 1
         stringActors = .AbsoluteField(i, "ActorID")
         arrayActor = Split(stringActors, ";")
         For j = 1 To UBound(arrayActor) - 1
            ArtistID = arrayActor(j)
            indexFound = InStr(1, loc_ActorList, ";" & ArtistID & ";")
            If indexFound > 0 Then
               loc_AlbumID = .AbsoluteField(i, 0)
               loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
               If IsCDAvailable(loc_Available, albumAvailable) Then
                  If PV_TableActor.Seeks(ArtistID) >= 0 Then
                     loc_ArtistNormal = PV_TableActor.Field(1)
                     loc_ArtistUnicode = PV_TableActor.Field(2)
                     
                     ReDim Preserve var_SearchArtist(ArtistCount)
                     var_SearchArtist(ArtistCount) = Array(ArtistID, loc_ArtistNormal, loc_ArtistUnicode, PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
                     ArtistCount = ArtistCount + 1
                     loc_ActorList = left(loc_ActorList, indexFound) & mID(loc_ActorList, indexFound + Len(";" & ArtistID & ";"))
                  End If
               End If
            End If
            If loc_ActorList = ";;" Or loc_ActorList = ";" Or loc_ActorList = "" Then
               GoTo Succeed
            End If
         Next
      Next
Succeed:
   End With
'''         If IsCDAvailable(loc_Available, albumAvailable) Then
'''            stringActors = .AbsoluteField(i, "ActorID")
'''            arrayActor = Split(stringActors, ";")
'''            For j = 1 To UBound(arrayActor) - 1
'''               ArtistID = arrayActor(j)
'''               If InStr(stringActorsID, ";" & ArtistID & ";") = 0 Then 'add to string list
'''                     If PV_TableActor.Seeks(ArtistID) >= 0 Then
'''                        loc_ArtistNormal = PV_TableActor.Field(1)
'''                        loc_ArtistUnicode = PV_TableActor.Field(2)
'''
'''                        If unicode Then
'''                           iTextCompare = vbBinaryCompare
'''                           loc_ArtistName = loc_ArtistUnicode
'''                        Else
'''                           loc_ArtistName = loc_ArtistNormal
'''                           iTextCompare = vbTextCompare
'''                        End If
'''                        If InStr(1, loc_ArtistName, SearchString, iTextCompare) > 0 Then
'''                           ReDim Preserve var_SearchArtist(ArtistCount)
'''                           var_SearchArtist(ArtistCount) = Array(ArtistID, loc_ArtistNormal, loc_ArtistUnicode, PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
'''                           ArtistCount = ArtistCount + 1
'''                        End If
'''                     End If
'''                  stringActorsID = stringActorsID & arrayActor(j) & ";"
'''               End If
'''            Next
'''         End If
   
   If ArtistCount > 0 Then
     QuickSort var_SearchArtist, Array(1)
     SearchArtist = GetNextArtist(0, ArtistCount, True)
   End If
End Function
Public Property Get IsCDAvailable(Value As Integer, AlbumType As AlbumEnum) As Boolean
   'edited 2005-08-09
   IsCDAvailable = ((AlbumType = All) Or (AlbumType = NotAvailable And Value = 0) Or (AlbumType = Available And Value <> 0))
End Property
Public Property Get IsValidGenre(Value As Integer, GenreIDs As String) As Boolean
   'edited 2005-08-09
   IsValidGenre = (Value = 0) Or (InStr(GenreIDs, ";" & Value & ";") > 0)
End Property
Public Property Get IsValidCDType(Value As Integer, AlbumFlag As CDTypeEnum) As Boolean
   'edited 2005-08-09
   IsValidCDType = (Value = AlbumFlag) Or (AlbumFlag = AllCD)
   'IsValidCDType = (mSelectFlagType = 0) Or (InStr(value, ";" & mSelectFlagType & ";") > 0)
End Property

Public Function AlbumByReleaseDate(MyFavorite As Boolean, Optional years As Integer = 0, Optional SortedType As Integer) As Integer
   On Error GoTo Error
   'browse album
   'Years=0 mean all

   Dim i As Long
   Dim boolFound As Boolean, count As Integer
   Dim varFavorite As Integer, varAvailable As Integer, varYear As Integer
   Dim leaveDateMonth As Boolean
   Dim loc_Flag As Integer
   Dim loc_AlbumID As Long
   leaveDateMonth = (SortedType = 0)         '1 alphabet 0 :release date
      With PV_TableMovie
         fieldGroupCDType = .FieldToIndex("TypeCDID")
         For i = 0 To .RecordCount - 1
            varFavorite = .AbsoluteField(i, "Favorite")
            varYear = Year(.AbsoluteField(i, "Year"))
            boolFound = (varYear = years Or years = 0)
            If boolFound Then
               loc_AlbumID = .AbsoluteField(i, 0)
               varAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
               boolFound = IsCDAvailable(varAvailable, mSelectAlbumType)
               boolFound = boolFound And (((MyFavorite = True) And (varFavorite = 1)) Or (MyFavorite = False))
               
               If boolFound Then
                  currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
                  loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
                  If IsValidCDType(loc_Flag, mSelectFlagType) And isValidGroupType(currentGroupCDType) Then
                     ReDim Preserve var_Album(count)
                     var_Album(count) = GetAlbumInfos(i, varAvailable, 0, leaveDateMonth, loc_Flag)
                     count = count + 1
                  End If
               End If
            End If
         Next
      End With
   
   If count > 0 Then
      Dim sortIndices As Variant
      'sortIndices = ReturnSortArray(4, True, 11, mSelectGroupCDType <> -1, 1, True)
      'mean grouping
      sortIndices = ReturnSortArray(4, mSelectGroupCDType = 0, 1, True)
      QuickSort var_Album, sortIndices
   End If
   AlbumByReleaseDate = count
   'browse the same country with album release date
   Exit Function
Error:
   WriteEvent "AlbumByReleaseDate", Err.Description, Err.Source
End Function

Public Function GetAlbumYears() As String
   On Error GoTo Error
   Dim varYears As String
   Dim intYears As Integer
   Dim i As Long
   Dim albumYears() As Variant
   Dim count As Integer
   Dim varPlus As String
'   SetFolder
   With PV_TableMovie
      varYears = de_Record
         For i = 0 To .RecordCount - 1
            intYears = Year(.AbsoluteField(i, "Year"))
            If InStr(varYears, de_Record & intYears & de_Record) = 0 Then
               ReDim Preserve albumYears(count)
               albumYears(count) = Array(intYears)
               varYears = varYears & intYears & de_Record
               count = count + 1
            End If
         Next
   End With
   If count > 0 Then QuickSort albumYears(), Array(0), True
   varYears = ""
   For i = 0 To count - 1
      varYears = varYears & varPlus & albumYears(i)(0)
      varPlus = de_Record
   Next
   GetAlbumYears = varYears
   Exit Function
Error:
   WriteEvent "GetAlbumYears", Err.Description, Err.Source
End Function
Private Function isValidGroupType(groupType As Integer) As Boolean
   'selectGroupCDType=-1 mean not sort
   'selectGroupCDType=0  mean sort by type
   'selectGroupCDType>0  mean select  and sort by type
   isValidGroupType = (mSelectGroupCDType <= 0) Or (groupType = mSelectGroupCDType)
   If mSelectGroupCDType = -1 Then groupType = 0
End Function
Private Function ChangeDate(ByVal oldDate As Date, Optional LeaveYear As Boolean) As Date
   Dim newDate As Date
   
   If Not LeaveYear Then
      ' ChangeDate = CDate(DateSerial(2200 - Year(oldDate), 1, 1))
      ChangeDate = DateSerial(2200, 1, 1) - DateSerial(Year(oldDate), 1, 1)
      'ChangeDate = DateSerial(2200 - Year(oldDate), 1, 1)
   Else
      ChangeDate = DateSerial(2200, 1, 1) - DateSerial(Year(oldDate), Month(oldDate), Day(oldDate))
   End If
   
End Function
Private Function ReverseDate(ByVal dates As Date) As Integer
   ReverseDate = Year((#1/1/2200# - dates))
   'ReverseDate = ((#1/1/2200# - dates))
End Function
Public Function GetTrackFields(TrackID As Long, fields() As Variant) As Variant
   On Error GoTo Error
   Dim i As Long
   Dim loc_Fields() As Variant
   With PV_TableTrack
      ReDim Preserve loc_Fields(UBound(fields))
      If .Seeks(TrackID) >= 0 Then
         For i = 0 To UBound(fields)
            loc_Fields(i) = .Field(fields(i))
         Next
      End If
   End With
   GetTrackFields = loc_Fields
   Exit Function
Error:
   WriteEvent "GetTrackFields", Err.Description, Err.Source
End Function
Public Function GetAlbumFields(albumID As Long, fields() As Variant) As Variant()
   On Error GoTo Error
   Dim i As Long
   Dim loc_Fields() As Variant
   With PV_TableMovie
      ReDim Preserve loc_Fields(UBound(fields))
      If .Seeks(albumID) >= 0 Then
         For i = 0 To UBound(fields)
            loc_Fields(i) = .Field(fields(i))
         Next
      End If
   End With
   GetAlbumFields = loc_Fields
   Exit Function
Error:
   WriteEvent "GetAlbumFields", Err.Description, Err.Source
End Function
Public Function GetAlbumField(ByVal albumID As Long, FieldName As String) As Variant
   On Error GoTo Error
   With PV_TableMovie
      If .Seeks(albumID) >= 0 Then
         GetAlbumField = .Field(FieldName)
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetAlbumField", Err.Description, Err.Source
End Function
Public Function GetEnableAlbumASIN(ByVal albumID As Long) As String
   On Error GoTo Error
   With PV_TableMovie
      If .Seeks(albumID) >= 0 Then
         GetEnableAlbumASIN = .Field("ASIN") & "~" & .Field("BuyCom") & "~" & .Field("WalmartCom") & "~" & .Field("Walmart_DD")
      Else
         GetEnableAlbumASIN = "~~~"
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetEnableAlbumASIN", Err.Description, Err.Source
End Function
Public Function GetAlbumWalmart(ByVal albumID As Long, Optional Company As String = "WalMart", Optional ByVal path As String) As String
   On Error GoTo Error
   Dim Index As Long
   
   If path = "" Then
      SetDirectory currentAlbumLanguagePath
   Else
      SetDirectory path & "\database"
   End If
   
   With PV_TableMovie
      Index = .Seeks(albumID)
      If Index > 0 Then
         If Company = "WalMart" Then
            ' Disable walmart link
            GetAlbumWalmart = .Field("Walmart") & Delimiter & .Field("NumCD")
         Else
            GetAlbumWalmart = .Field("LoudEye")
            'Loud Eye stand for MUSIC_MATCH
         End If
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetAlbumWalmart", Err.Description, Err.Source
End Function

Public Function GetNewestYear() As Integer
   On Error GoTo Error
   Dim maxYears As Integer
   Dim intYears As Integer
   Dim fieldYears As Integer
   Dim i As Long
   With PV_TableMovie
      fieldYears = .FieldToIndex("Year")
         For i = 0 To .RecordCount - 1
            intYears = Year(.AbsoluteField(i, fieldYears))
            If intYears > maxYears Then maxYears = intYears
         Next
   End With
   GetNewestYear = maxYears
   Exit Function
Error:
   WriteEvent "GetNewestYear", Err.Description, Err.Source
End Function
Public Function searchDirector(searchDirectorName As String) As Long
   On Error GoTo Error
   '2005-08-2005 Seng
   Dim i As Long
   Dim loc_FieldName As Integer
   Dim loc_Name As String
   Dim loc_SearchCount As Long
   
   
   Erase var_Director
   With PV_TableDirector
      loc_FieldName = .FieldToIndex("Name")
      For i = 0 To .RecordCount - 1
         loc_Name = .AbsoluteField(i, loc_FieldName)
         If InStr(1, loc_Name, searchDirectorName, vbTextCompare) > 0 Then
            ReDim Preserve var_Director(loc_SearchCount)
            var_Director(loc_SearchCount) = Array(.AbsoluteField(i, 0), .AbsoluteField(i, 1), "", "", "", "", "")
            loc_SearchCount = loc_SearchCount + 1
         End If
      Next
   End With
   If loc_SearchCount > 0 Then
      ' Sort name only
      QuickSort var_Director, Array(1)
   End If
   searchDirector = loc_SearchCount
   Exit Function
Error:
   WriteEvent "searchDirector", Err.Description, Err.Source
End Function
Public Function GetNextDirector(arg_Index As Long, ByVal arg_Count As Long) As String
   ' ID Name
   'Created Seng 2005-09-01
   On Error GoTo ErrorBound
   Dim i As Long, loc_strResult As String, loc_strPlus As String
  
   For i = arg_Index To arg_Index + arg_Count - 1
      If loc_strResult = "" Then loc_strPlus = "" Else loc_strPlus = de_Record
      loc_strResult = loc_strResult & loc_strPlus & Join(var_Director(i), de_Field)
   Next
ErrorBound:
   GetNextDirector = loc_strResult
End Function
Public Function searchTrack(SearchChapterName As String, Optional ProductionID As Long, Optional MoodID As Long, Optional DanceStyleID As Long, Optional GenreID As Long, Optional Rating As Integer, Optional Available As Integer, Optional boolUnicode As Boolean, Optional sortType As Boolean, Optional SingerID As Integer, Optional SingType As Integer = -2, Optional startLetter As Boolean) As Long
   On Error GoTo Error
   Dim searchCount As Long
   Dim max As Long
   Dim boolFound As Boolean
   Dim currentStringList As String
   Dim boolNewSearch As Boolean
   Dim i As Long
   Dim MovieID As Long
   Dim TrackName As String
   Dim fieldTrackName As Integer
   Dim fieldMovieID As Integer
   Dim movieIndex As Long
   Dim iTextCompare As VbCompareMethod
   Dim bLanguageKhmer As Boolean
   'SingType=0 Girl;SingType=1 Boy;SingType=2 Both
   Dim LabelID As Long
   Dim albumName As String
   Dim albumYear As String
   Dim albumUnicode As String
   Dim ChapterName As String
   Dim ChapterUnicode As String
   Dim LabelName As String
   Dim LabelUnicode As String
   Dim trackRating As Integer
   Dim trackArtists() As String
   Dim TrackID As Long
   Dim FlagID As Integer
   Dim trackAvailable As Integer
   Dim TrackPosition As Integer
   Dim seekOffset As Integer
   Dim loc_AlbumID As Long
   Dim int_Available As Integer
   Dim SingerIDs As String
   Dim trackSingType As Integer
   Dim RetTrackIDs As String

   Static boolSearching As Boolean

   max = 12
   boolSearching = True
   boolExitLoop = False
   'StartLetter = True
   'boolNewSearch = (stringSearch <> "")
   
   With PV_TableMovie
      If boolUnicode Then
         fieldTrackName = PV_TableTrack.FieldToIndex("Unicode")
         iTextCompare = vbBinaryCompare
      Else
         fieldTrackName = PV_TableTrack.FieldToIndex("Name")
         iTextCompare = vbTextCompare
      End If
      bLanguageKhmer = InStr(1, prv_Country, "khmer", vbTextCompare) > 0
      
      fieldMovieID = PV_TableTrack.FieldToIndex("MovieID")
      For i = 0 To PV_TableTrack.RecordCount - 1
         boolFound = False
         TrackName = PV_TableTrack.AbsoluteField(i, fieldTrackName)
         TrackID = PV_TableTrack.AbsoluteField(i, 0)
         DoEvents
         
         'CompareStartLetter
         If SearchChapterName = "" Then
            boolFound = True
         Else
            If startLetter Then
               boolFound = CompareStartLetter(TrackName, SearchChapterName, prv_Country, boolUnicode)
            Else
               boolFound = InStr(1, TrackName, SearchChapterName, iTextCompare) > 0
            End If
         End If
         If boolFound Then             ' Found the track is available
            MovieID = PV_TableTrack.AbsoluteField(i, fieldMovieID)
            movieIndex = .Seeks(MovieID)

            If movieIndex >= 0 Then
               If ProductionID > 0 Then
                  boolFound = .AbsoluteField(movieIndex, "LabelID") = ProductionID
               End If
               If Rating > 0 Then
                  boolFound = boolFound And PV_TableTrack.AbsoluteField(i, "Rating") = Rating
               End If
               If GenreID > 0 Then
                  boolFound = boolFound And InStr(1, .AbsoluteField(movieIndex, "GenreIDs"), ";" & GenreID & ";", vbTextCompare) > 0
               End If
               If SingerID > 0 Then
                  SingerIDs = PV_TableTrack.AbsoluteField(i, "SingerIDs")
                  boolFound = boolFound And InStr(1, SingerIDs, ";" & SingerID & ";", vbTextCompare) > 0
               End If
               If SingType <> -2 Then
                  'trackSingType = PV_TableTrack.AbsoluteField(i, "SingType")
                  
                  boolFound = boolFound And (PV_TableTrack.AbsoluteField(i, "SingType") = SingType)
               End If
               If boolFound Then
                  loc_AlbumID = .AbsoluteField(movieIndex, 0)
                  int_Available = getAlbumAvailable(prv_Country, loc_AlbumID, RetTrackIDs)
                  If RetTrackIDs <> "" And int_Available <> 0 Then
                     If RetTrackIDs <> "-1" Then
                        If InStr(1, RetTrackIDs, ";" & TrackID & ";") = 0 Then
                           int_Available = 0
                        End If
                     End If
                  End If
                  RetTrackIDs = ""
                  If IsCDAvailable(int_Available, CInt(Available)) Then
                     LabelID = .AbsoluteField(movieIndex, "LabelID")
                     albumName = .AbsoluteField(movieIndex, "Name")
                     albumUnicode = .AbsoluteField(movieIndex, "Unicode")
                     ChapterName = PV_TableTrack.AbsoluteField(i, "Name")
                     ChapterUnicode = PV_TableTrack.AbsoluteField(i, "Unicode")
                     LabelName = .AbsoluteField(movieIndex, "Label")
                     LabelUnicode = .AbsoluteField(movieIndex, "LabelUnicode")
                     trackRating = PV_TableTrack.AbsoluteField(i, "Rating")
                     FlagID = FlagCDOrder(.AbsoluteField(movieIndex, "Flag"))
                     albumYear = ChangeDate(.AbsoluteField(movieIndex, "Year"))
                     trackAvailable = .AbsoluteField(movieIndex, "Available")
                     TrackPosition = PV_TableTrack.AbsoluteField(i, "Position")
                     trackSingType = PV_TableTrack.AbsoluteField(i, "SingType")
                     seekOffset = PV_TableTrack.AbsoluteField(i, "seekOffset")
                     trackArtists = Split(GetActorName(PV_TableTrack.AbsoluteField(i, "SingerIDs"), True), "%%")
                     ReDim Preserve var_SearchTrack(searchCount)
                     var_SearchTrack(searchCount) = Array(LabelID, albumName, albumUnicode, ChapterName, ChapterUnicode, LabelName, LabelUnicode, "", "", "", "", trackRating, trackArtists(0), trackArtists(1), TrackID, 0, FlagID, MovieID, "", albumYear, 0, trackAvailable, "", TrackPosition, trackSingType, seekOffset)
                                                            ' 0      1              2              3           4              5           6        7   8   9  10        11         12                 13             14    15  16       17     18    19       20         21       22      23            24        25
                     searchCount = searchCount + 1
                     sendVariable2Flash FrmMain.swf(2), "TrackFound", searchCount
                     If searchCount > 200 Then
                        If (SingerID = 0 And startLetter = False) Then Exit For        'Maximum to 200 tracks
                     End If
                  End If
               End If
               
            End If
         End If
         ' boolExitLoop
         If boolExitLoop Then Exit For                'last line of for-next
      Next
   End With
   If searchCount > 0 Then QuickSort var_SearchTrack, ReturnSortArray(19, sortType, 3, boolUnicode = False, 4, boolUnicode = True)
   searchTrack = searchCount
   Exit Function
Error:
   WriteEvent "searchTrack", Err.Description, Err.Source
End Function

Public Function GetLastUpdate()
   On Error GoTo Error
   GetLastUpdate = PV_TableMovie.GetDate
   Exit Function
Error:
   WriteEvent "GetLastUpdate", Err.Description, Err.Source
End Function

Public Function SetLastUpdate(dateToSet As String)
   On Error GoTo Error
   PV_TableMovie.SetDate dateToSet
   Exit Function
Error:
   WriteEvent "SetLastUpdate", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   SaveAlbumDirectory
' Description       :   Save browsed filename to the user database
' Return Values     :   true or false
' Input Parameter   :   albumid,sPlayFrom(0,1,2),path(path to save)
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             02-07-2006           New
'*******************************************************************************

Public Function SaveAlbumDirectory(ByVal var_CurrentAlbumID As Long, sPlayFrom As String, varPathValue As String) As Boolean
   On Error GoTo Error
   Dim RecordIndex As Long, i As Long, j As Long
   Dim iTrackCounts As Integer
   Dim iMainTitleID As Long
   Dim iMainTitle As Integer
   Dim loc_TrackIDs As String
   Dim ifOTrackCounts As Integer
   
   Dim loc_FileList() As String
   Dim loc_TrackNumber() As Integer
   Dim loc_IDLists() As String
   Dim iTracNo As Integer
   Dim iFoundCount As Integer
   Dim loc_IDIndex As Long
   
   If sPlayFrom = "" Then Exit Function
   'Special case for DVD====================================================================================
   '2005-12-03 Seng
   If PV_TableMovie.Seeks(var_CurrentAlbumID) >= 0 Then
      iMainTitleID = PV_TableMovie.Field("MainTitleID")
      iMainTitle = PV_TableMovie.Field("MainTitle")
   End If
   With PV_TableTitleTrack
      If .Seeks(iMainTitleID) >= 0 Then
         loc_TrackIDs = .Field("TrackIDs")
         'loc_IDLists = Split(Mid(loc_TrackIDs, 2, Len(loc_TrackIDs) - 2), ";")
         iTrackCounts = Len(loc_TrackIDs) \ 3 ' UBound(loc_IDLists) + 1
      End If
   End With
   
   
   
   loc_FileList = SplitFileFromOpenDialog(varPathValue)
   If UBound(loc_FileList) > 0 Then
      'Save files to chapters
      ReDim loc_TrackNumber(-1 To UBound(loc_FileList))
      For i = 0 To UBound(loc_FileList)
         loc_TrackNumber(i) = GetTrackNumber(fso.GetBaseName(loc_FileList(i)))
      Next
      With PV_TableTrack
         For i = 1 To Len(loc_TrackIDs) Step 3
            
            'loc_IDIndex = .Seeks(val(loc_IDLists(i)))
            loc_IDIndex = .Seeks(Triple2Long(mID(loc_TrackIDs, i, 3)))
            If loc_IDIndex >= 0 Then
               iTracNo = val(.AbsoluteField(loc_IDIndex, "Position"))
               For j = 0 To UBound(loc_TrackNumber)
                  If iTracNo = loc_TrackNumber(j) Then
                     .AbsoluteEdit(loc_IDIndex, .FieldToIndex("Path")) = loc_FileList(j)
                     .AbsoluteEdit(loc_IDIndex, .FieldToIndex("Available")) = 1
                     iFoundCount = iFoundCount + 1
                     Exit For
                  End If
               Next
            End If
         Next
      End With
      If iFoundCount > 0 Then
         With PV_TableMovie
            RecordIndex = .Seeks(var_CurrentAlbumID)
            If RecordIndex >= 0 Then
               .AbsoluteEdit(RecordIndex, .FieldToIndex("Available")) = 1
            End If
         End With
         If iFoundCount < iTrackCounts Then
            MsgBox "You must re-scan again , track found less than in database", vbInformation
         End If
      Else
         MsgBox "Can't found any track"
      End If
      If iFoundCount > 0 Then
         SaveAlbumDirectory = True
         RefreshAlbumAvailableToServer
      End If
      'iTracNo = GetTrackNumber(loc_FileList(i))
      'SplitFileFromOpenDialog
   ElseIf UBound(loc_FileList) = 0 Then
   
      If StrComp(fso.GetExtensionName(varPathValue), "ifo", vbTextCompare) = 0 Then
          ifOTrackCounts = GetChapterCountFromIFO(varPathValue, iMainTitle)
          'If iTrackCounts <> ifOTrackCounts Or iTrackCounts <= 0 Then  ''Remove out restriction
          If iTrackCounts <= 0 Then
            MsgBox "Incorrect chapter from this DVD"
            Exit Function
          End If
      End If
      '========================================================================================================
      If isFileExist(varPathValue) Then
         With PV_TableMovie
            RecordIndex = .Seeks(var_CurrentAlbumID)
            If RecordIndex >= 0 And sPlayFrom <> "" Then
               .AbsoluteEdit(RecordIndex, .FieldToIndex("Available")) = 1
               If sPlayFrom = "0" Then sPlayFrom = "Path"
               If sPlayFrom = "1" Then sPlayFrom = "PathMedium"
               If sPlayFrom = "2" Then sPlayFrom = "PathSmall"
               .AbsoluteEdit(RecordIndex, .FieldToIndex(sPlayFrom)) = varPathValue
               SaveAlbumDirectory = True                 'available for saved album
            End If
         End With
         RefreshAlbumAvailableToServer
      End If
   End If
   Exit Function
Error:
   WriteEvent "SaveAlbumDirectory", Err.Description, Err.Source
End Function

Public Function getItemFromID(colObj As Collection, ByVal Key As String) As String
On Error GoTo errorOccur:
   getItemFromID = colObj(Key)
errorOccur:
End Function
Public Function AddID(objCollection As Collection, Name As String, Key As String) As Boolean
On Error GoTo errorOccur:
   objCollection.Add Name, Key
   AddID = True
errorOccur:
End Function
Public Function AddClientAvailable(loadXmlPath As String) As Boolean
   On Error GoTo Error
   Dim xmlDocOpen As New DOMDocument
   Dim xmlQuery As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlFirstNode As IXMLDOMElement
   Dim xmlSelectExisting As IXMLDOMElement
   Dim MachineName As String
   Dim albumID As String
   Dim languageName As String
   Dim i As Long
   Dim xmlElement As IXMLDOMElement
   
   xmlDocOpen.Load loadXmlPath
   xmlQuery.Load SlyVariable("<MyAlbumServer>")    'Connected albums
   
   
   If xmlDocOpen.parseError.errorCode = 0 Then
      Set xmlRoot = xmlDocOpen.firstChild
      Set xmlFirstNode = xmlQuery.firstChild
      
''''      If xmlFirstNode Is Nothing Then
''''         Set xmlFirstNode = xmlQuery.createElement("Machines")
''''         xmlQuery.appendChild xmlFirstNode
''''      End If
      For Each xmlElement In xmlDocOpen.firstChild.childNodes
         MachineName = xmlElement.getAttribute("Name")          'Node Mahine
         If MachineName <> SlyNickName Then                                'Don't remove child node of it self
            Set xmlSelectExisting = xmlQuery.selectSingleNode("//Machines/Machine[@Name='" & MachineName & "']")
            If Not xmlSelectExisting Is Nothing Then  'Update new (remove existing
               xmlFirstNode.removeChild xmlSelectExisting
            End If
            xmlFirstNode.appendChild xmlElement
         End If
      Next

'''      Set xmlElement = xmlRoot.firstChild.firstChild
'''      MachineName = xmlElement.getAttribute("Name")          'Node Mahine
'''      Set xmlSelectExisting = xmlQuery.selectSingleNode("//Machines/Machine[@Name='" & MachineName & "']")
'''      If xmlSelectExisting Is Nothing Then
'''        xmlFirstNode.appendChild xmlElement
'''      End If
      xmlQuery.Save SlyVariable("<MyAlbumServer>")
   End If
   boolAlbumChanged = True                               'To use this variable for refresh the album
   Exit Function
Error:
   WriteEvent "AddClientAvailable", Err.Description, Err.Source
End Function
Public Sub RemoveClientAvailable(MachineName As String)
   On Error GoTo Error
   Dim xmlDocOpen As New DOMDocument
   Dim xmlQuery As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlFirstNode As IXMLDOMElement
   Dim xmlSelectExisting As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   Dim xmlNodeList As IXMLDOMNodeList
   
   xmlQuery.Load SlyVariable("<MyAlbumServer>")
   '--------------------remove album available from disconnected server ---------------------------------------
      Set xmlSelectExisting = xmlQuery.selectSingleNode("//Machines/Machine[@Name='" & MachineName & "']")
      If Not xmlSelectExisting Is Nothing Then
        xmlQuery.firstChild.removeChild xmlSelectExisting
         boolAlbumChanged = True
         xmlQuery.Save SlyVariable("<MyAlbumServer>")
      End If
   '--------------------remove album available from disconnected server ---------------------------------------
   
   '--------------------remove album available from client connect to disconnected server ---------------------------------------
      Set xmlNodeList = xmlQuery.selectNodes("//Machines/Machine[@Server='" & MachineName & "']")
      For Each xmlElement In xmlNodeList
         xmlQuery.firstChild.removeChild xmlElement
         boolAlbumChanged = True
      Next
      If boolAlbumChanged Then xmlQuery.Save SlyVariable("<MyAlbumServer>")
   Exit Sub
Error:
   WriteEvent "RemoveClientAvailable", Err.Description, Err.Source
End Sub
Public Function combineAvailable(trackavailableIDs As String, albumLan As String) As Boolean
   On Error GoTo Error
   'split with ";"
   'combine available
   Dim i As Long
   Dim IDs() As String
   Set collectionSelectList = New Collection
   Dim currentMachineAlbums As String
   IDs = Split(trackavailableIDs, ";")
   For i = 0 To UBound(IDs)
      AddID collectionSelectList, IDs(i), IDs(i)
   Next
   Exit Function
Error:
   WriteEvent "combineAvailable", Err.Description, Err.Source
End Function

Public Function filterAvailable(xmlPathName As String, languageName As String, Optional filterMachine As String = "") As Boolean
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmllst As IXMLDOMNodeList
   Dim xmlnode As IXMLDOMElement
   Dim ID As String, Machine As String
   Dim i As Long
   
   XmlDoc.Load xmlPathName                'load from xml
   Set collectionSelectList = New Collection
   If XmlDoc.parseError.errorCode = 0 Then
      If filterMachine = "" Then
         Set xmllst = XmlDoc.selectNodes("Machine/Language[@Name='" & languageName & "']")
      Else
         Set xmllst = XmlDoc.selectNodes("Machine/Language[@Name='" & languageName & "' and @Machine='" & filterMachine & "']")
      End If

      For i = 0 To xmllst.Length - 1
         Set xmlnode = xmllst.item(i)
         ID = xmlnode.getAttribute("ID")
         AddID collectionSelectList, ID, ID
      Next
   End If
   boolAlbumChanged = False
   Exit Function
Error:
   WriteEvent "filterAvailable", Err.Description, Err.Source
End Function
Public Function getMyAlbum(filterMachine As String, languageName As String) As String
   On Error GoTo Error
   
   Dim XmlDoc As New DOMDocument
   Dim xmllst As IXMLDOMNodeList
   Dim xmlnode As IXMLDOMElement
   Dim ID As String, Machine As String
   Dim availableIDs As String
   Dim i As Long
   MsgBox " Get my album"

   XmlDoc.Load SlyVariable("<MyAlbum>")
   'Set collectionSelectList = New Collection
   If XmlDoc.parseError.errorCode = 0 Then
      If filterMachine = "" Then
         Set xmllst = XmlDoc.selectNodes("Machine/Language[@Name='" & languageName & "']")
      Else
         Set xmllst = XmlDoc.selectNodes("Machine/Language[@Name='" & languageName & "' and @Machine='" & filterMachine & "']")
      End If

      For i = 0 To xmllst.Length - 1
         Set xmlnode = xmllst.item(i)
         ID = xmlnode.getAttribute("ID")
         If availableIDs = vbNullString Then
            availableIDs = ID
         Else
            availableIDs = availableIDs & ";" & ID
         End If

      Next
   End If
   boolAlbumChanged = False
   getMyAlbum = availableIDs
   Exit Function
Error:
   WriteEvent "getMyAlbum", Err.Description, Err.Source
End Function

Public Function SelectAlbumsFromList(Optional boolSort As Boolean, Optional ByVal sortIndex As Integer) As Long
   On Error GoTo Error
   Dim i As Long, j As Long
   Dim albumID As String
   Dim newSeekIndex As Long
   Dim AlbumCount As Long
   Dim SortArray As Variant
   Dim albumAvailable As Integer
   
   sortIndex = 3 + sortIndex
   
   If collectionSelectList.count > 0 Then
      With PV_TableMovie
         For i = 1 To collectionSelectList.count
            albumID = collectionSelectList(i)
            If albumID <> "" Then   ' this statement add by muny because albumID="", so errro 13
               newSeekIndex = .Seeks(CLng(albumID))
                If newSeekIndex >= 0 Then
                   ReDim Preserve var_Album(j)
                   albumAvailable = .AbsoluteField(newSeekIndex, .FieldToIndex("Available"))

                   albumAvailable = getAlbumAvailable(currentCountry, albumID)
                   var_Album(j) = GetAlbumInfos(newSeekIndex, albumAvailable, 0, False, 0)
                   'var_Album(j) = Array(AlbumID, .Field("Name"), .Field("UnicodeName"), 0, ChangeDate(.Field("Year"), False), _
                                        .Field("Singer"), .Field("Rating"), .Field("Available"), .Field("Favorite"), 0, .Field("Rank"), _
                                        TypeCDOrder(.Field("TypeCDID")), .Field("UnicodeSinger"))
                   j = j + 1
                End If
            End If
         Next
      End With
   End If
   If j > 0 Then
      If boolSort Then
         'Sort type >>>Artist>>>Sort Index
         SortArray = ReturnSortArray(5, mSelectGroupCDType <> -1, sortIndex, True, 1, sortIndex <> 1)
         QuickSort var_Album, SortArray
      End If
   End If
   SelectAlbumsFromList = j
   Exit Function
Error:
   WriteEvent "SelectAlbumsFromList", Err.Description, Err.Source
End Function
Public Function getAlbumAvailables(albumIDs As String, albumLan As String) As String
   On Error GoTo Error
   Dim IDList() As String
   Dim i As Long
   Dim IDString As String
   IDList = Split(albumIDs, ",")
   For i = 0 To UBound(IDList)
      If getAlbumAvailable(albumLan, IDList(i)) > 0 Then
         If IDString = "" Then IDString = IDList(i) Else IDString = IDString & "," & IDList(i)
      End If
   Next
   getAlbumAvailables = IDString
   Exit Function
Error:
   WriteEvent "getAlbumAvailables", Err.Description, Err.Source
End Function
Public Function getTrackAvailables(TrackIDs As String, TrackLan As String, returnNonAvailable As String) As String
   On Error GoTo ErrorReadNonLanguage
   Dim i As Long
   Dim ID As Long
   Dim IDList() As String
   Dim IDString As String
   Dim tblTrack As New TableCls
   Dim tblAlbum As New TableCls
   Dim loc_AlbumAvailable As Integer
   Dim loc_NotAvailableID As String
   
   If TrackLan <> "" Then
      SetDirectory SlyVariable("<" & TrackLan & "_dat>") + "\Database"
   End If
   tblTrack.Opens "Track"
   tblAlbum.Opens "Movie"
      IDList = Split(TrackIDs, ",")
      For i = 0 To UBound(IDList)
         If tblTrack.Seeks(CLng(IDList(i))) >= 0 Then
            If tblAlbum.Seeks(tblTrack.Field("MovieID")) >= 0 Then
               loc_AlbumAvailable = tblAlbum.Field("Available")
               If tblAlbum.Field("Path") = "" And tblAlbum.Field("PathMedium") = "" And tblAlbum.Field("PathSmall") = "" Then loc_AlbumAvailable = 0
            End If
            If tblTrack.Field("Available") = 1 Or loc_AlbumAvailable > 0 Then
               If IDString = vbNullString Then
                  IDString = IDList(i)
               Else
                  IDString = IDString & "," & IDList(i)
               End If
            Else
               If loc_NotAvailableID = vbNullString Then
                  loc_NotAvailableID = IDList(i)
               Else
                  loc_NotAvailableID = loc_NotAvailableID & "," & IDList(i)
               End If
            End If
         End If
      Next
   tblTrack.Closes
   getTrackAvailables = IDString
   returnNonAvailable = loc_NotAvailableID
ErrorReadNonLanguage:
End Function
Public Sub SaveBrowseAlbum2Xml(Savepath As String)
   On Error GoTo SubScript
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlnode As IXMLDOMElement
   Dim i As Long
   

   Set xmlRoot = XmlDoc.createElement("Albums")
   
   For i = 0 To UBound(var_Album)
      Set xmlnode = XmlDoc.createElement("Album")
      xmlnode.setAttribute "ID", var_Album(i)(0)
      xmlRoot.appendChild xmlnode
   Next
SubScript:
   XmlDoc.appendChild xmlRoot
   XmlDoc.Save Savepath
End Sub
Public Function getAlbumAvailable(languageName As String, ByVal ID As Long, Optional TrackIDs As Variant) As Long
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmllst As IXMLDOMElement
   Dim albumMachine As String
   Dim loc_IDs As Variant
   
   XmlDoc.Load SlyVariable("<MyAlbumServer>")
   Set xmllst = XmlDoc.selectSingleNode("//Machines/Machine[@Name='" & SlyNickName & "']/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
   If xmllst Is Nothing Then
      Set xmllst = XmlDoc.selectSingleNode("//Machines/Machine/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
      If xmllst Is Nothing Then
         getAlbumAvailable = 0
      Else
         getAlbumAvailable = 2
         '=============Modified 20006-10-13==
         If Not IsMissing(TrackIDs) Then
            loc_IDs = xmllst.getAttribute("TrackIDs")
            If Not IsNull(loc_IDs) Then
               TrackIDs = loc_IDs
            End If
         End If
         '===================================
      End If
   Else
      '=============Modified 20006-10-13==
      If Not IsMissing(TrackIDs) Then
         loc_IDs = xmllst.getAttribute("TrackIDs")
         If Not IsNull(loc_IDs) Then
            TrackIDs = loc_IDs
         End If
      End If
      '===================================
      getAlbumAvailable = 1
   End If
   Exit Function
Error:
   WriteEvent "getAlbumAvailable", Err.Description, Err.Source
End Function
Public Function GetChapterTime(ByVal arg_movieID As String, ByVal arg_ChapterNumber As Integer) As String
   On Error GoTo Error
   Dim TrackIDs As String
   Dim i As Integer
   Dim TrackID As Long
   Dim titleID As Long
   Dim stringTrackIDs As String
   Dim loc_MovieID As Long
   Dim loc_ChapterNumber As Integer
   
   
   loc_MovieID = val(arg_movieID)
   If PV_TableMovie.Seeks(loc_MovieID) >= 0 Then
      titleID = PV_TableMovie.Field("MaintitleID")
      If titleID > 0 And PV_TableTitleTrack.Seeks(titleID) >= 0 Then
         'stringTrackIDs = PV_TableTitleTrack.Field("TrackIDs")
         TrackIDs = PV_TableTitleTrack.Field("TrackIDs")
         With PV_TableTrack
            For i = 1 To Len(TrackIDs) Step 3
               TrackID = Triple2Long(mID(TrackIDs, i, 3))   'TrackIDs(i)
               If .Seeks(TrackID) >= 0 Then
                  loc_ChapterNumber = .Field("Position")
                  If loc_ChapterNumber = arg_ChapterNumber Then
                     GetChapterTime = .Field("JumpTime")
                     Exit Function
                  End If
               End If
            Next
         End With
      End If
   End If
   Exit Function
Error:
   WriteEvent "GetChapterTime", Err.Description, Err.Source
End Function

Public Function GetChapterFromMovie(ByVal arg_movieID As String, arg_ChapterCount As Integer) As String
   On Error GoTo Error
   Dim TrackIDs As String
   Dim i As Integer
   Dim TrackID As Long
   Dim titleID As Long
   Dim stringTrackIDs As String
   Dim chapterString As String
   Dim chapterCount As Long
   Dim Tracks() As Variant
   Dim loc_MovieID As Long
   
   loc_MovieID = val(arg_movieID)
   If PV_TableMovie.Seeks(loc_MovieID) >= 0 Then
      titleID = PV_TableMovie.Field("MaintitleID")
      If titleID > 0 And PV_TableTitleTrack.Seeks(titleID) >= 0 Then
'''         stringTrackIDs = PV_TableTitleTrack.Field("TrackIDs")
'''         TrackIDs = Split(stringTrackIDs, ";")
         TrackIDs = PV_TableTitleTrack.Field("TrackIDs")
         With PV_TableTrack
            For i = 1 To Len(TrackIDs) Step 3
               TrackID = Triple2Long(mID(TrackIDs, i, 3))
               If .Seeks(TrackID) >= 0 Then
                  ReDim Preserve Tracks(chapterCount)
                  Tracks(chapterCount) = Array(.Field("Position"), .Field("Name"), .Field("JumpTime"))
               End If
               chapterCount = chapterCount + 1
            Next
         End With
      End If
   End If
   If chapterCount = 0 Then
      For i = 0 To arg_ChapterCount - 1
         ReDim Preserve Tracks(i)
         Tracks(i) = Array(i + 1, "Chapter " & Format(i + 1, "00"), vbNullString)
      Next
      chapterCount = arg_ChapterCount
   End If
   
   If chapterCount > 0 Then
      QuickSort Tracks, Array(0)
   End If
   For i = 0 To chapterCount - 1
      If chapterString = "" Then
         chapterString = Join(Tracks(i), de_Field)
      Else
         chapterString = chapterString & de_Record & Join(Tracks(i), de_Field)
      End If
   Next
   GetChapterFromMovie = chapterString
   Exit Function
Error:
   WriteEvent "GetChapterFromMovie", Err.Description, Err.Source
End Function
Public Function GetLabelName(ByVal ID As Long) As String
   On Error GoTo Error
   With PV_TableLabel
      If .Seeks(ID) >= 0 Then
         GetLabelName = .Field("Name")
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetLabelName", Err.Description, Err.Source
End Function
Public Function GetTVSeriesName(ByVal ID As Long) As String
   On Error GoTo Error
   With PV_TableTVSeries
      If .Seeks(ID) >= 0 Then
         GetTVSeriesName = .Field("Name")
      End If
   End With
   Exit Function
Error:
   WriteEvent "GetTVSeriesName", Err.Description, Err.Source
End Function
Public Function GetActorName(IDs As String, boolUnicode As Boolean) As String
   On Error GoTo Error
   'created 2005-08-22  /seng
   Dim splitName() As String
   Dim i As Long
   Dim loc_DirectorCount As Integer
   Dim loc_DirectorID As Long
   Dim loc_ActorName As String
   Dim loc_ActorNames As String
   Dim loc_ActorNameUnicode As String
   Dim loc_ActorNameUnicodes As String
   Dim loc_FieldName As String
   
   splitName = Split(IDs, ";")
   With PV_TableActor
      For i = 0 To UBound(splitName)
         loc_DirectorID = val(splitName(i))
         If loc_DirectorID > 0 Then
            If .Seeks(loc_DirectorID) >= 0 Then
            
               loc_ActorNameUnicode = .Field("Unicode")
               loc_ActorName = .Field("Name")
               
               If loc_ActorNames = "" Then
                  loc_ActorNames = loc_ActorName
               Else
                  loc_ActorNames = loc_ActorNames & " + " & loc_ActorName
               End If
               
               If loc_ActorNameUnicodes = "" Then
                  loc_ActorNameUnicodes = loc_ActorNameUnicode
               Else
                  loc_ActorNameUnicodes = loc_ActorNameUnicodes & " + " & loc_ActorNameUnicode
               End If
               loc_DirectorCount = loc_DirectorCount + 1
               'If loc_DirectorCount >= maxName Then Exit For      ' only take max director
            End If
         End If
         
      Next
   End With
   'return the directors
   If boolUnicode Then
      GetActorName = loc_ActorNames & "%%" & loc_ActorNameUnicodes
   Else
      GetActorName = loc_ActorNames
   End If
   Exit Function
Error:
   WriteEvent "GetActorName", Err.Description, Err.Source
End Function

Public Function GetDirectorName(IDs As String, Optional maxName As Integer = 2) As String
   On Error GoTo Error
   'created 2005-08-22  /seng
   Dim splitName() As String
   Dim i As Long
   Dim loc_DirectorCount As Integer
   Dim loc_DirectorID As Long
   Dim loc_DirectorName As String
   Dim loc_DirectorNames As String
   
   splitName = Split(IDs, ";")
   With PV_TableDirector
      For i = 0 To UBound(splitName)
         loc_DirectorID = val(splitName(i))
         If loc_DirectorID > 0 Then
            If .Seeks(loc_DirectorID) >= 0 Then
               loc_DirectorName = .Field("Name")
               If loc_DirectorNames = "" Then
                  loc_DirectorNames = loc_DirectorNames & loc_DirectorName
               Else
                  loc_DirectorNames = loc_DirectorNames & "+" & loc_DirectorName
               End If
               loc_DirectorCount = loc_DirectorCount + 1
               If loc_DirectorCount >= maxName Then Exit For      ' only take max director
            End If
         End If
         
      Next
   End With
   
   GetDirectorName = loc_DirectorNames       'return the directors
   Exit Function
Error:
   WriteEvent "GetDirectorName", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   AlbumByTVSeries
' Description       :   Get the album by TVSeries name
' Return Values     :   album count
' Input Parameter   :   TVID,SeasonNumber
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-14-2005           New
'*******************************************************************************
Public Function AlbumByTVSeries(TVID As Long, SeasonNumber As Integer, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Long
   On Error GoTo Error
   Dim i As Long
   
   Dim loc_fieldTVID As Integer, loc_fieldAvailable As Integer, loc_fieldFlag As Integer, loc_fieldSeasonNum As Integer
   Dim loc_Available As Integer, loc_Flag As Integer
   
   Dim loc_TVID As Long, loc_SeasonNumber As Long, loc_Count As Long
   
   Erase var_Album
   
   With PV_TableMovie
      loc_fieldTVID = .FieldToIndex("TVID")
      loc_fieldSeasonNum = .FieldToIndex("numSeason")
      loc_fieldAvailable = .FieldToIndex("Available")
      loc_fieldFlag = .FieldToIndex("Flag")
      For i = 0 To .RecordCount - 1
         loc_TVID = .AbsoluteField(i, loc_fieldTVID)
         loc_SeasonNumber = .AbsoluteField(i, loc_fieldSeasonNum)
         loc_Available = .AbsoluteField(i, loc_fieldAvailable)
         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
'         If loc_TVID <> 0 Then
'            Debug.Assert False
'         End If
         If loc_TVID = TVID And (SeasonNumber = loc_SeasonNumber Or SeasonNumber = 0) Then
            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
               ReDim Preserve var_Album(loc_Count)
               var_Album(loc_Count) = GetAlbumInfos(i, loc_Available, 0, False, loc_Flag)
               loc_Count = loc_Count + 1
            End If
         End If
      Next
   End With
   If loc_Count > 0 Then
      'sort by name only
      QuickSort var_Album, Array(1), False
   End If
   AlbumByTVSeries = loc_Count
   Exit Function
Error:
   WriteEvent "AlbumByTVSeries", Err.Description, Err.Source
End Function

Public Function AlbumByDirector(DirectorID As Integer, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Long
   On Error GoTo Error
   Dim i As Long
   
   Dim loc_fieldDirector As Integer, loc_fieldAvailable As Integer, loc_fieldFlag As Integer
   Dim loc_Available As Integer, loc_Flag As Integer
   
   Dim loc_DirectorIDs As String
   Dim loc_Count As Long
   
   Erase var_SearchAlbum
   
   With PV_TableMovie
      loc_fieldDirector = .FieldToIndex("DirectorIDs")
      loc_fieldAvailable = .FieldToIndex("Available")
      loc_fieldFlag = .FieldToIndex("Flag")
      For i = 0 To .RecordCount - 1
         loc_DirectorIDs = .AbsoluteField(i, loc_fieldDirector)
         loc_Available = .AbsoluteField(i, loc_fieldAvailable)
         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
         If InStr(1, loc_DirectorIDs, ";" & DirectorID & ";", vbTextCompare) > 0 Then
            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
               ReDim Preserve var_SearchAlbum(loc_Count)
               var_SearchAlbum(loc_Count) = GetAlbumInfos(i, loc_Available, 0, False, loc_Flag)
               loc_Count = loc_Count + 1
            End If
         End If
      Next
   End With
   If loc_Count > 0 Then
      'sort by name only
      QuickSort var_SearchAlbum, Array(1), False
   End If
   AlbumByDirector = loc_Count
   Exit Function
Error:
   WriteEvent "AlbumByDirector", Err.Description, Err.Source
End Function
'*******************************************************************************
' Function Name     :   BackupFavorite
' Description       :   Backup Favorite
' Return Values     :   None
' Input Parameter   :   file path with name and extension
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             11-01-2005           New
'*******************************************************************************

Public Sub BackupFavorite(savePathName As String)
   On Error GoTo Error
   Dim Favorite() As FavoriteType
   Dim Header As HeaderTypes
   Dim handleFile As Integer
   Dim i As Long, searchCount As Long
   Dim fieldRating As Integer, fieldFavorite As Integer, fieldRank As Integer
  
  
   With PV_TableActor
     
      fieldRank = .FieldToIndex("Rating")   'Rating refer to Rank
      fieldFavorite = .FieldToIndex("Favorite")
      
      For i = 0 To .RecordCount - 1
         ReDim Preserve Favorite(searchCount)
         Favorite(searchCount).ID = .AbsoluteField(i, 0)
         Favorite(searchCount).Favorite = .AbsoluteField(i, fieldFavorite)
         Favorite(searchCount).Rank = .AbsoluteField(i, fieldRank)
         searchCount = searchCount + 1
      Next
   End With
   Header.ArtistCount = searchCount
   With PV_TableMovie
      fieldRank = .FieldToIndex("Rank")               'Rating refer to Rank
      fieldFavorite = .FieldToIndex("Favorite")
      fieldRating = .FieldToIndex("Rating")
      
      For i = 0 To .RecordCount - 1
         ReDim Preserve Favorite(searchCount)
         Favorite(searchCount).ID = .AbsoluteField(i, 0)
         Favorite(searchCount).Favorite = .AbsoluteField(i, fieldFavorite)
         Favorite(searchCount).Rank = .AbsoluteField(i, fieldRank)
         Favorite(searchCount).Rating = .AbsoluteField(i, fieldRating)
         searchCount = searchCount + 1
      Next
      Header.AlbumCount = searchCount - Header.ArtistCount
      Header.languageName = prv_Country
      Header.RecordCount = searchCount
   End With
  
  handleFile = FreeFile
   Open savePathName For Binary As handleFile
      Put handleFile, , Header
      Put handleFile, , Favorite()
   Close handleFile
   Exit Sub
Error:
   WriteEvent "BackupFavorite", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   RestoreFavorite
' Description       :   Restore Favorite
' Return Values     :   None
' Input Parameter   :   Filepath
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng              11-01-2005           New
'*******************************************************************************

Public Sub RestoreFavorite(openPathName As String)
   On Error GoTo Error
  Dim i As Long, j As Long
  Dim fieldRating As Integer, fieldFavorite As Integer, fieldRank As Integer
  Dim handleFile As Integer
  Dim Header As HeaderTypes
  Dim Favorite() As FavoriteType
  Dim updateIndex As Long
  
  SetDirectory CBrowse.GetLastLanguage
  handleFile = FreeFile
  
   Open openPathName For Binary As handleFile
      Get handleFile, , Header
      ReDim Favorite(Header.RecordCount - 1)
      Get handleFile, , Favorite
   Close handleFile
   Header.languageName = RTrim(Header.languageName)
   If StrComp(RTrim(Header.languageName), prv_Country, vbTextCompare) <> 0 Then Exit Sub
  
  
   With PV_TableActor
      fieldRank = .FieldToIndex("Rating")   'Rating refer to Rank
      fieldFavorite = .FieldToIndex("Favorite")
      For i = 0 To Header.ArtistCount - 1
         updateIndex = .Seeks(Favorite(i).ID)
         If updateIndex >= 0 Then
            .AbsoluteEdit(updateIndex, fieldRank) = Favorite(i).Rank
            .AbsoluteEdit(updateIndex, fieldFavorite) = Favorite(i).Favorite
         End If
      Next
   End With
  
   With PV_TableMovie
      fieldRank = .FieldToIndex("Rank")
      fieldFavorite = .FieldToIndex("Favorite")
      fieldRating = .FieldToIndex("Rating")
      For i = i To Header.RecordCount - 1
         updateIndex = .Seeks(Favorite(i).ID)
         If updateIndex >= 0 Then
            .AbsoluteEdit(updateIndex, fieldFavorite) = Favorite(i).Favorite
            .AbsoluteEdit(updateIndex, fieldRank) = Favorite(i).Rank
            If Favorite(i).Rating > 3 Then .AbsoluteEdit(updateIndex, fieldRating) = Favorite(i).Rating
         End If
      Next
   End With
   Exit Sub
Error:
   WriteEvent "RestoreFavorite", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   AddInternalTrack2Player
' Description       :   Add internal track to player
' Return Values     :   Info string of added track
' Input Parameter   :   albumid,tracid
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' None             11-14-2005           New
'*******************************************************************************

Public Function AddInternalTrack2Player(xmlResult As IXMLDOMElement)
   On Error GoTo Error
   'Argument:AlbumID,TrackID,Language,ComName,playType,AudioType,BookMarkType
   
   Dim loc_TrackID As Long
   Dim loc_AlbumID As Long
   Dim loc_Language As String
   Dim loc_ComName As String
   Dim loc_PlayFrom As Integer
   Dim loc_AudioType As Integer
   Dim loc_BookMarkType As Integer
   Dim loc_StPlayer As String
   Dim xmlResult1 As IXMLDOMElement
   Dim loc_PlayType As String 'test
   Dim args As String
   Dim varSplit() As String
   
   
   Dim TrackTitle As String, trackTitleUnicode As String
   Dim trackMood As String, trackMoodUnicode As String
   Dim trackDanceStyle As String, trackDanceStyleUnicode As String
   Dim trackGenre As String, trackGenreUnicode As String
   Dim trackShoppingID As String
   Dim trackWalmartAvailable As Integer, trackLanguage As String
   Dim trackSingLanguage As String, trackComputerName As String
   Dim trackRating As Integer, TrackID As Long
   Dim trackAvailables As Integer, trackNo As Integer
   Dim trackBookMark As Integer
   Dim albumID As Long
   Dim albumName As String, albumUnicode As String
   Dim albumYear As String
   Dim albumMainTitle As Integer
   Dim trackArtist As String, trackArtistUnicode As String
   Dim playTrackMode  As String
   Dim loc_SaveInPlayList As String
   Dim modeTrack As String
   Dim pic As String
   Dim seekedIndex As Long
   Dim loc_SeekOffset As Long
   Dim trackLabel As String
   Dim trackLabelUnicode As String
   varSplit = Split(args, "||")
   loc_AlbumID = varSplit(0)
   loc_TrackID = varSplit(1)
   loc_Language = varSplit(2)
   loc_ComName = varSplit(3)
   loc_PlayFrom = varSplit(4)
   loc_AudioType = varSplit(5)
   loc_BookMarkType = varSplit(6)
   loc_SeekOffset = varSplit(7)
   'AlbumID=38
   'TrackID=719
   With PV_TableTrack
      seekedIndex = .Seeks(loc_TrackID)
      If seekedIndex >= 0 Then
         TrackTitle = .AbsoluteField(seekedIndex, "Name")
         trackTitleUnicode = .AbsoluteField(seekedIndex, "Unicode")
         trackMood = "":               trackMoodUnicode = ""
         trackDanceStyle = "":         trackDanceStyleUnicode = ""
         trackGenre = "":              trackGenreUnicode = ""
         trackWalmartAvailable = val(.AbsoluteField(seekedIndex, "OnlineLink"))
         trackShoppingID = ""       'For none
         trackLanguage = loc_Language
         trackSingLanguage = .AbsoluteField(seekedIndex, "Language")
         trackComputerName = loc_ComName
         trackRating = val(.AbsoluteField(seekedIndex, "Rating"))
         TrackID = loc_TrackID
         trackAvailables = .AbsoluteField(seekedIndex, "Available")
         trackNo = val(.AbsoluteField(seekedIndex, "Position") - 1)        'Since it starts from 0
      End If
   End With
   With PV_TableMovie
      seekedIndex = .Seeks(loc_AlbumID)
      If seekedIndex >= 0 Then
         albumName = .AbsoluteField(seekedIndex, "Name")
         albumUnicode = .AbsoluteField(seekedIndex, "Unicode")
         albumYear = .AbsoluteField(seekedIndex, "Year")
         albumID = loc_AlbumID
         trackArtist = .AbsoluteField(seekedIndex, "Label")
         albumMainTitle = .AbsoluteField(seekedIndex, "MainTitle")
         trackArtistUnicode = .AbsoluteField(seekedIndex, "LabelUnicode")
      End If
   End With
   playTrackMode = 0
   modeTrack = "Internal"
   trackBookMark = IIf(loc_PlayType = "False", 4, 0)
   pic = GetArtistStartLetter(trackArtist) & "\" & trackArtist
   loc_StPlayer = TrackTitle & de_Field & trackTitleUnicode & "%%" & albumName & de_Field & albumUnicode & "%%" & trackArtist & de_Field & trackArtistUnicode & "%~%" & "%~%" + trackTitleUnicode & "%~%" & trackLabelUnicode & "%~%" & albumUnicode
   'e_xml.attributes.StPlayer=trackTitle+StOr+utracktitle+StPer+album+StOr+uAlbum+StPer+artist+StOr+uArtist+StWave+EngFont+StOr+UniFont+StWave+EngSize+StOr+UniSize+StWave+UniTrackTitle +StWave+UniPro+StWave+UniAlbumTitle;
   StrPathPic = fso.BuildPath(SlyVariable("<" & trackLanguage & "_img>"), pic & "\" & albumName & "\folder.jpg")
   pathTrackID = TrackID & "~" & albumID & "~" & trackNo & "~" & trackLanguage & "~" & trackWalmartAvailable
   Call StartPlayTrack(StrPathPic, StPlayer, loc_SaveInPlayList, pathTrackID, trackLanguage, playTrackMode)
   xmlResult.setAttribute "PlayTrackFrom", loc_PlayType
   xmlResult.setAttribute "SeekOffset", loc_SeekOffset
   xmlResult.setAttribute "IsBookmark", loc_BookMarkType
   xmlResult.setAttribute "AudioChannel", ""
   xmlResult.setAttribute "MainTitle", albumMainTitle
   xmlResult.setAttribute "BookmarkChapter", ""
   xmlResult.setAttribute "BookmarkLength", ""
   xmlResult.setAttribute "BlankBottom", ""
   xmlResult.setAttribute "BlankTop", ""
   xmlResult.setAttribute "ZoomLevel", ""
   xmlResult.setAttribute "BookmarkTime", ""
   xmlResult.setAttribute "BookmarkTitle", ""
   xmlResult.setAttribute "Director", ""
   xmlResult.setAttribute "Actor", ""
   xmlResult.setAttribute "StPlayer", loc_StPlayer
   xmlResult.setAttribute "TrackIndex", 0
   xmlResult.setAttribute "NoTrack", trackNo
   xmlResult.setAttribute "ShoppingID", trackShoppingID
   xmlResult.setAttribute "walMartAva", trackWalmartAvailable
   xmlResult.setAttribute "TrackAva", 0
   xmlResult.setAttribute "TrackYear", albumYear
   xmlResult.setAttribute "ComName", loc_ComName
   xmlResult.setAttribute "LanTrack", trackSingLanguage
   xmlResult.setAttribute "AlbumID", loc_AlbumID
   xmlResult.setAttribute "picPath", ""
   xmlResult.setAttribute "TrackID", loc_TrackID
   xmlResult.setAttribute "Mode", "0"
   xmlResult.setAttribute "language", loc_Language
   xmlResult.setAttribute "Rating", trackRating
   xmlResult.setAttribute "Genre", trackGenre
   xmlResult.setAttribute "UniGenre", trackGenreUnicode
   xmlResult.setAttribute "DanceStyle", trackDanceStyle
   xmlResult.setAttribute "UniDanceStyle", trackDanceStyleUnicode
   xmlResult.setAttribute "Mood", trackMood
   xmlResult.setAttribute "UniMood", trackMoodUnicode
   xmlResult.setAttribute "Artist", trackArtist
   xmlResult.setAttribute "UniArtist", trackArtistUnicode
   xmlResult.setAttribute "Track", TrackTitle
   xmlResult.setAttribute "UniTrack", trackTitleUnicode
   xmlResult.setAttribute "Album", albumName
   xmlResult.setAttribute "UniAlbum", albumUnicode
   xmlResult.setAttribute "NetPath", ""
   
   AddInternalTrack2Player = xmlResult
   Exit Function
Error:
   WriteEvent "AddInternalTrack2Player", Err.Description, Err.Source
End Function


Public Sub CloseAllDatabase()
   On Error GoTo Error
   PV_TableGenre.Closes
   PV_TableActor.Closes
   PV_TableMovie.Closes
   PV_TableLabel.Closes
   PV_TableTrack.Closes
   PV_TableLanguage.Closes
   PV_TableTitleTrack.Closes
   PV_TableDirector.Closes
   PV_TableTVSeries.Closes
   Exit Sub
Error:
   WriteEvent "CloseAllDatabase", Err.Description, Err.Source
End Sub

Public Function addTrackToPlayer(ByVal lpTrackID As Long, ByVal lpComName As String, ByVal lpAudioChannel As Integer, ByVal lpBookMarkType As Integer, lpIDNotFound As Boolean) As Boolean

   Dim loc_TrackTitle As String, loc_TrackTitleUnicode As String           '
   Dim loc_Artist As String, loc_ArtistUnicode As String                   '
   Dim loc_Album As String, loc_AlbumUnicode As String                     '
   Dim loc_Mood As String, loc_MoodUnicode As String
   Dim loc_DanceStyle As String, loc_DanceStyleUnicode As String
   Dim loc_Genre As String, loc_GenreUnicode As String
   Dim loc_walMartAvailable As Integer                   '
   Dim loc_ShoppingID As String                          '
   Dim loc_LanTrack As String                            '
   Dim loc_Rating As Integer                             '
   Dim loc_TrackID As Long                               '
   Dim loc_Pic As String                                 '
   Dim loc_AlbumID As Long                               '
   Dim loc_Year As String                                '
   Dim loc_TrackNo As Integer                            '
   Dim loc_BookMarkType As Integer
   Dim loc_AudioChannel As Integer
   Dim loc_ComName As String
   Dim loc_SeekOffset As Integer
   Dim loc_TrackAvailable As Integer
   Dim loc_LanName As String
   Dim loc_SendPathPic As String
   Dim AlbumArtistID As Long
   Dim AlbumArtist As String
   Dim TVSeriesID As Long
   Dim numSeason As Integer
   
   
   Dim loc_TrackIDIndex As Long
   Dim loc_LabelIDIndex As Long
   Dim loc_AlbumIDIndex As Long
   Dim loc_GenreIDIndex As Long
   Dim loc_LabelID As Long
   Dim loc_SingerIDs As String
   Dim loc_ArtistID As Long
   Dim loc_GenreID As Long
   Dim loc_GrenreIDs As String
   Dim loc_Grens() As String
   
   
   Dim loc_PathTrackID As String, loc_SaveInPlayer As String, loc_SaveInPlayList As String, loc_Font As String
   Dim loc_EngFont As String, loc_UniFont As String, loc_EngSize As Integer, loc_UniSize As Integer
   
   loc_EngFont = "Arial":    loc_EngSize = 11
   loc_UniFont = "Khmer OS": loc_UniSize = 22
   loc_Font = loc_EngFont & "||" & loc_UniFont & "%~%" & loc_EngSize & "||" & loc_UniSize
   
   With PV_TableTrack
      loc_TrackIDIndex = .Seeks(lpTrackID)
      If loc_TrackIDIndex >= 0 Then
         loc_TrackTitle = .AbsoluteField(loc_TrackIDIndex, "Name")
         loc_TrackTitleUnicode = .AbsoluteField(loc_TrackIDIndex, "Unicode")
         loc_AlbumID = .AbsoluteField(loc_TrackIDIndex, "MovieID")
         loc_TrackNo = .AbsoluteField(loc_TrackIDIndex, "Position")
         loc_LanTrack = .AbsoluteField(loc_TrackIDIndex, "Language")
         loc_Rating = .AbsoluteField(loc_TrackIDIndex, "Rating")
         If setEnableSeekOfsset Then
            loc_SeekOffset = .AbsoluteField(loc_TrackIDIndex, "SeekOffset")
         Else
            loc_SeekOffset = 0
         End If
         'loc_SingerIDs = .AbsoluteField(loc_TrackIDIndex, "SingerIDs")
      Else
         lpIDNotFound = True
         Exit Function
      End If
   End With
   With PV_TableMovie
      loc_AlbumIDIndex = .Seeks(loc_AlbumID)
      If loc_AlbumIDIndex >= 0 Then
         loc_Album = .AbsoluteField(loc_AlbumIDIndex, "Name")
         loc_AlbumUnicode = .AbsoluteField(loc_AlbumIDIndex, "Unicode")
         loc_Year = .AbsoluteField(loc_AlbumIDIndex, "Year")
         loc_LabelID = .AbsoluteField(loc_AlbumIDIndex, "LabelID")
      Else
         Exit Function
      End If
   End With
   
   With PV_TableLabel
      loc_LabelIDIndex = .Seeks(loc_LabelID)
      If loc_LabelIDIndex >= 0 Then
         loc_Artist = .AbsoluteField(loc_LabelIDIndex, "Name")
         loc_ArtistUnicode = .AbsoluteField(loc_LabelIDIndex, "Unicode")
         
         
         AlbumArtistID = PV_TableMovie.AbsoluteField(loc_AlbumIDIndex, "AlbumArtistID")
         TVSeriesID = PV_TableMovie.AbsoluteField(loc_LabelIDIndex, "TVID")
         If TVSeriesID > 0 Then
            numSeason = .AbsoluteField(loc_LabelIDIndex, "numSeason")
            AlbumArtist = GetTVSeriesName(TVSeriesID) & "\Season # " & (numSeason)
         ElseIf AlbumArtistID > 0 Then
            AlbumArtist = GetActorName(";" & AlbumArtistID & ";", False)
         End If
         
         If AlbumArtist = "" Then AlbumArtist = loc_Artist
        
         
         loc_Pic = GetArtistStartLetter(AlbumArtist) & "\" & AlbumArtist
      Else
         Exit Function
      End If
   End With
   
   loc_walMartAvailable = 0
   loc_ShoppingID = ""
   
   loc_ComName = lpComName
   loc_LanName = prv_Country
   loc_BookMarkType = lpBookMarkType
   loc_AudioChannel = lpAudioChannel
   loc_TrackID = lpTrackID
   loc_TrackAvailable = 1
   
   loc_PathTrackID = Join(Array(loc_TrackID, loc_AlbumID, loc_TrackNo, loc_LanName, loc_walMartAvailable), "~")
   loc_SendPathPic = fso.BuildPath(SlyVariable("<" & loc_LanName & "_img>"), loc_Pic & "\" & loc_Album & "\folder.jpg")
   loc_SaveInPlayer = loc_TrackTitle & StOr & loc_TrackTitleUnicode & StPer & loc_Album & StOr & loc_AlbumUnicode & StPer & loc_Artist & StOr & loc_ArtistUnicode & StWave & loc_Font & StWave & "" & StWave & "" & StWave & ""
   loc_SaveInPlayList = Join(Array(loc_Album, loc_AlbumUnicode, loc_TrackTitle, loc_TrackTitleUnicode, loc_Artist, loc_ArtistUnicode, loc_Mood, loc_MoodUnicode, loc_DanceStyle, loc_DanceStyleUnicode, loc_Rating, loc_Genre, loc_GenreUnicode, 0, loc_TrackID, loc_Pic, loc_LanName, loc_ComName, loc_AlbumID, loc_LanTrack, loc_Year, loc_TrackAvailable, loc_walMartAvailable, loc_ShoppingID, "0%%0%%0", loc_BookMarkType, "0%%0%%0%%0%%0", loc_AudioChannel, loc_SeekOffset, 0), StPer)
   Call StartPlayTrack(loc_SendPathPic, loc_SaveInPlayer, loc_SaveInPlayList & "%%" & "", loc_PathTrackID, loc_LanName, 0)
   addTrackToPlayer = True
   

  
End Function
Public Function SplitFileFromOpenDialog(strFileList As String) As String()
   Dim loc_ParentDir As String
   Dim loc_List() As String
   Dim loc_Result() As String
   Dim loc_MaxBound As Long
   Dim i As Long
   
   
   
   ReDim loc_Result(-1 To -1)
   loc_List = Split(strFileList, Chr(0))
   loc_MaxBound = UBound(loc_List)
   If loc_MaxBound = 0 Then
      ReDim loc_Result(-1 To 0)
      loc_Result(0) = strFileList
   Else
      loc_ParentDir = loc_List(0)
      ReDim loc_Result(-1 To loc_MaxBound - 1)
      For i = 1 To UBound(loc_List)
         loc_Result(i - 1) = loc_ParentDir & "\" & loc_List(i)
      Next
   End If
   SplitFileFromOpenDialog = loc_Result
End Function

Public Function GetTrackNumber(filename As String) As Integer
   Dim loc_sNumber As String
   Dim loc_Char As String
   Dim i As Integer
   'Get Track Number from Track Search from right to left
   
   For i = Len(filename) To 1 Step -1
      loc_Char = mID(filename, i, 1)
      If InStr(1, "0123456789", loc_Char) > 0 Then
         loc_sNumber = loc_Char & loc_sNumber
      ElseIf loc_sNumber <> "" Then
         Exit For
      End If
      
   Next
   If loc_sNumber <> "" Then GetTrackNumber = val(loc_sNumber) Else GetTrackNumber = -1
End Function

'*******************************************************************************
' Function Name     :   CompareStartLetter
' Description       :   Compare string start letter for each language
' Return Values     :   Boolean value
' Input Parameter   :   Source,Find and language
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             09-26-2006           New
'*******************************************************************************
'Module for compare string
Public Function CompareStartLetter(ByVal Source As String, ByVal Find As String, Langue As String, bUnicode As Boolean) As Boolean
   Dim i As Integer
   Dim sChar As String
   Dim loc_LanArray() As String
   Dim loc_Language As String
   
   
   Source = Trim(Source)
   If Langue <> "" Then
      loc_LanArray = Split(Langue, " ")
      loc_Language = StrConv(loc_LanArray(0), vbProperCase)
   Else
      loc_Language = "English"
   End If
   If bUnicode Then
      If Find = "#" Then
         CompareStartLetter = InStr(ChrW(&H17E0) & ChrW(&H17E1) & ChrW(&H17E2) & ChrW(&H17E3) & ChrW(&H17E4) & ChrW(&H17E5) & ChrW(&H17E6) & ChrW(&H17E7) & ChrW(&H17E8) & ChrW(&H17E9), left(Source, Len(Find))) > 0 And Source <> ""
      Else
         Select Case loc_Language
            Case "Khmer"
               CompareStartLetter = left(Source, Len(Find)) = Find
            Case "English", "Vietnamese"
               CompareStartLetter = StrComp(left(Source, Len(Find)), Find, vbTextCompare) = 0
            Case Else
               CompareStartLetter = StrComp(left(Source, Len(Find)), Find, vbBinaryCompare) = 0
         End Select
      End If
   Else
      If Find = "#" Then
         CompareStartLetter = InStr("0123456789", left(Source, Len(Find))) > 0 And Source <> ""
      Else
         CompareStartLetter = StrComp(left(Source, Len(Find)), Find, vbTextCompare) = 0
      End If
   End If
End Function

Private Sub Class_Terminate()
   CloseAllDatabase
End Sub
Private Sub Class_Initialize()
   SetDelimiter "&"
End Sub
'*******************************************************************************
' Function Name     :   ScanHintTag
' Description       :   Scan ripped MP4;mkv DVD with hint tag into Album, using RegEx pression
' Return Values     :   Album counts found
' Input Parameter   :   File Paths, database folder, functionObj, funcName
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             12-04-2015           New
'*******************************************************************************
'Module for compare string

Public Function scanhinttag(lpScanfolder As String, functionObj As Object, funcName As String) As Integer
     
  Dim hinttag As New Collection
   Dim lpFiles As New Collection
   Dim XMLDOM As New DOMDocument
   Dim xmlnode As IXMLDOMElement
   Dim xmlRoot As IXMLDOMElement
   Dim xmlnodes As IXMLDOMNodeList

   Const hinttageXML = "searchtag.xml"
   Dim Pro_ID As Long
   Dim Pro_Name As String
   Dim AlbumVol As String
   Dim iFound As Long
   
   Dim lpFileNamePath As String
   Dim lpFileName As String
   Dim xmlFileName As String
   Dim pattern() As Variant
   Dim i As Long, j As Long
   
   Dim myRegExp As New RegExp
   Dim myMatches As MatchCollection
   Dim myMatch As Match
   Dim RecordIndex As Long
   Dim bFound As Boolean
   Dim mediaPath As String
   Dim filename As String
   
   
   
'   <Productions>
'      <Production hinttags="\bRNM\b|\bReasmey Neak Meas\b" ID="1"></Production>
'   </Productions>
'   SetDirectory databaseFolder
'   PV_TableLabel.Opens "Label"
'   PV_TableMovie.Opens "Movie"
   'SetDelimiter "&"
   'Loading hintag from XML
   'prv_Directory
   
   
   filename = Dir(fso.BuildPath(lpScanfolder, "*.*"))
   While filename <> ""
      If (InStr(";mkv;m4v;mp4;", ";" & fso.GetExtensionName(filename) & ";") > 0) Then
         lpFiles.Add fso.BuildPath(lpScanfolder, filename)
      End If
      filename = Dir()
   Wend
   
   xmlFileName = fso.BuildPath(prv_Directory, hinttageXML)
   If Not fso.FileExists(xmlFileName) Then
      'hintag xml not found so create new template
      Set xmlRoot = XMLDOM.createElement("Productions")
      With PV_TableLabel
         If .RecordCount = 0 Then
            'Writelog "ScanHintTag", "INFO", "Record found is 0", "Country = " & prv_Country & ", Directory= " & prv_Directory
            'MsgBox "Record count is 0"
            CallByName functionObj, funcName, VbMethod, "info", "Record count is 0"
            Exit Function
         End If
         For i = 0 To .RecordCount - 1
            Set xmlnode = XMLDOM.createElement("Production")
            xmlnode.setAttribute "hinttags", "\b" & .AbsoluteField(i, 1) & "\b"
            xmlnode.setAttribute "Name", .AbsoluteField(i, 1)
            xmlnode.setAttribute "ID", .AbsoluteField(i, 0)
            xmlRoot.appendChild xmlnode
         Next
      End With
      
      XMLDOM.appendChild xmlRoot
      XMLDOM.Save xmlFileName
      Writelog "ScanHintTag", "INFO", "hintag xml not found so create new template", "Directory= " & prv_Directory & ", File Path= " & xmlFileName
      'Exit Function
   End If
   
   If Not XMLDOM.Load(xmlFileName) Then
      CallByName functionObj, funcName, VbMethod, "info", "Record count is 0"
      'Writelog "ScanHintTag", "ERROR", XMLDOM.parseError.reason, "Directory= " & prv_Directory & ", File Path= " & xmlFileName
   Else
      Set xmlRoot = XMLDOM.childNodes(0)
      If Not xmlRoot Is Nothing Then
         ReDim pattern(xmlRoot.childNodes.Length - 1)
         For i = 0 To xmlRoot.childNodes.Length - 1
            Set xmlnode = xmlRoot.childNodes.item(i)
            pattern(i) = Array(xmlnode.getAttribute("ID"), xmlnode.getAttribute("hinttags"), xmlnode.getAttribute("Name"))
         Next
      End If
      
      myRegExp.IgnoreCase = True
      myRegExp.Global = True
      For j = 1 To lpFiles.count
         lpFileNamePath = lpFiles.item(j)
         lpFileName = fso.GetBaseName(lpFileNamePath)
         bFound = False
         For i = 0 To UBound(pattern)
            myRegExp.pattern = pattern(i)(1)
            Set myMatches = myRegExp.Execute(lpFileName)
            If (myMatches.count > 0) Then
               bFound = True
               Writelog "ScanHintTag", "INFO", "Production Found", "Production= " & pattern(i)(2) & " ;Hint tag= " & pattern(i)(1) & " ;File Name =" & lpFileNamePath
               myRegExp.pattern = "\d{3}"
               Set myMatches = myRegExp.Execute(lpFileName)
               If myMatches.count > 0 Then
                  Pro_ID = pattern(i)(0)
                  Pro_Name = pattern(i)(1)
                  AlbumVol = myMatches.item(0).Value

                  Debug.Print "Production ID= " & Pro_ID & "; Name = " & Pro_Name & "; Album = " & AlbumVol
                  If PV_TableMovie.FindFirst("LabelID=" & Pro_ID & "&Name=*" & AlbumVol & "*") Then
                     CallByName functionObj, funcName, VbMethod, "INFO", "File = " & lpFileName & " saved to database"
                     iFound = iFound + 1
                     RecordIndex = PV_TableMovie.GetIndex
                     PV_TableMovie.AbsoluteEdit(RecordIndex, PV_TableMovie.FieldToIndex("Available")) = 1
                     PV_TableMovie.AbsoluteEdit(RecordIndex, PV_TableMovie.FieldToIndex("Path")) = lpFileNamePath
                     Exit For
                  Else
                  
                     'Writelog "ScanHintTag", "INFO", "Not Found album", "Production= " & pattern(i)(2) & " ;Hint tag= " & pattern(i)(1) & " ;File Name =" & lpFileNamePath & " ; Album =" & AlbumVol
                  End If
                     'If RecordIndex >= 0 And sPlayFrom <> "" Then
'''                        If sPlayFrom = "0" Then sPlayFrom = "Path"
'''                        If sPlayFrom = "1" Then sPlayFrom = "PathMedium"
'''                        If sPlayFrom = "2" Then sPlayFrom = "PathSmall"
                        '.AbsoluteEdit(RecordIndex, .FieldToIndex(sPlayFrom)) = varPathValue
                        '= True                 'available for saved album
               Else
               End If
               Exit For
            End If
         Next
            If (bFound = False) Then
               'Writelog "ScanHintTag", "INFO", "Not Found hing tag", "File name = " & lpFileNamePath
            End If
         
      Next
   End If
   CallByName functionObj, funcName, VbMethod, "INFO", iFound & " files saved to database"
   

End Function
