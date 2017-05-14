VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cLanguage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit



'=====================Local Enumeration
Public Enum AlbumEnum
   NotAvailable = 0
   Available = 1
   All = 3
End Enum
Public Enum CDTypeEnum
   Clean = 2
   Explicit = 3
   AllCD = 0
End Enum
Public Enum SortEnum
   stDate = 0
   stName = 1
   stNone = 3
End Enum

Public Enum MediaQualityEnum
   MediaSmall = 1
   MediaMedium = 2
   MediaLarge = 3
End Enum


'=====================Local Constant
Const mRsaKey = "ymguide"

'=====================Local variable
Dim mConnection As cConnection
Dim mCountryPath As String
Dim mOpenSuccess As Boolean
Dim mCountryID As Long
Dim mCountryName As String
Dim mDatabaseType As Integer            'Store the type of database like TVSeries,Movie,Music Video,Karaoke
                                          '(1 Movie,2 TVSeries,4 Music,8 Karaoke)

Public collectionSelectList As New Collection

Public currentCountry As String

Private var_Album() As Variant            'Albuma array
Private var_Artist()  As Variant          'Artist array
Private var_Director() As Variant         'Director array

Private var_SearchArtist() As Variant     'Used for search
Private var_SearchTrack() As Variant     'Used for search
Private var_SearchAlbum() As Variant     'Used for search

'======================Browsing album
Public mSelectAlbumType As AlbumEnum
Public mSelectFlagType As CDTypeEnum
Public mSelectGroupCDType As Integer     'mSelectGroupCDType -1 mean not sort ,0  mean sort by type,>0  mean select  and sort by type
Public boolAlbumChanged As Boolean
Public bCancelBrowse As Boolean
Public boolExitLoop As Boolean            'for exit loop

'===============Constant===========
Private Const StOr = "||"
Private Const StPer = "%%"
Private Const StWave = "%~%"

Private Sub Class_Initialize()
   Set mConnection = Nothing
End Sub


Public Function Initialize(lpFileName As String, Optional aDatabaseType As Integer = 0) As Boolean
   On Error GoTo Error:
   Set mConnection = New cConnection
   'If mConnection.OpenDB(lpFileName, mRsaKey) Then
   If mConnection.OpenDB(lpFileName) Then
      mConnection.Synchronous = False           'Turn of synchronous to speed up update/modify
      mOpenSuccess = True
   Else
      mOpenSuccess = False
   End If
   Initialize = mOpenSuccess
   mSelectAlbumType = All
   mSelectFlagType = AllCD
   mSelectGroupCDType = -1
   
   Exit Function
Error:
   Log.Writelog "Initialize", "ERROR", Err.Description, "lpFileName = " & lpFileName & ", aDatabaseType=" & aDatabaseType
End Function



Public Function GetTracksByAlbum(ByVal albumID As Long, boolShowArtist As Boolean) As String
   'On Error GoTo Error
   Static bQuerying As Boolean
   Dim tmp As String
   Dim Data As Variant
   Dim stringShowArtist As String
   Dim showArtistUnicode As String
   Dim sTrackLength As String
   Dim bAvailable As Boolean
   Dim iAvailable As Long
   
   
'''   SELECT     dbo.sqlite_track.TrackId, dbo.sqlite_track.TrackPosition, dbo.sqlite_track.Name, dbo.sqlite_track.Unicode, dbo.sqlite_track.Rating, dbo.sqlite_track.TrackLength, dbo.sqlite_track.Language,
'''                      dbo.sqlite_track.SingType, dbo.sqlite_label.Name AS Expr1, dbo.sqlite_label.Unicode AS Expr2
'''FROM         dbo.sqlite_label INNER JOIN
'''                      dbo.sqlite_movie ON dbo.sqlite_label.LabelId = dbo.sqlite_movie.LabelId INNER JOIN
'''                      dbo.sqlite_title ON dbo.sqlite_movie.TitleID = dbo.sqlite_title.TitleID INNER JOIN
'''                      dbo.sqlite_track ON dbo.sqlite_title.TrackId = dbo.sqlite_track.TrackId
   
   Dim sqlTracks As cRecordset
   Dim sqlArtist As cRecordset
   Dim sql As String
'''   sql = "SELECT Track.ID, Track.Position, Track.Name, Track.Unicode, Track.Rating, Track.Length, Track.Language, " & _
'''         "Track.SingType, Label.Name AS LabelName, Label.Unicode as LabelUnicode, Actor.Name as ActorName, Actor.Unicode as ActorUnicode, " & _
'''         "Movie.Path As MoviePath, Movie.PathSmall as MoviePathSmall, Movie.PathMedium As MoviePathMedium " & _
'''         "FROM Label " & _
'''         "INNER JOIN Movie ON Label.ID = Movie.LabelID " & _
'''         "INNER JOIN Title ON Movie.MainTitle = Title.ID " & _
'''         "INNER JOIN Track ON Title.TrackID = Track.ID " & _
'''         "LEFT JOIN TrackArtist ON Track.ID = TrackArtist.TrackID " & _
'''         "INNER JOIN Actor ON TrackArtist.ArtistID= Actor.ID " & _
'''         "WHERE Movie.ID=" & albumID & " " & _
'''         "ORDER by Track.Position,Track.ID"
   
   sql = "SELECT Track.ID, Track.Position, Track.Name, Track.Unicode, Track.Rating, Track.Length, Track.Language, " & _
         "Track.SingType, Track.Available, Track.SeekOffset, Label.Name AS LabelName, Label.Unicode as LabelUnicode, " & _
         "Movie.Path As MoviePath, Movie.PathSmall as MoviePathSmall, Movie.PathMedium As MoviePathMedium " & _
         "FROM Track " & _
         "INNER JOIN Movie ON Track.MovieID = Movie.ID " & _
         "INNER JOIN Label ON Label.ID = Movie.LabelID " & _
         "WHERE Movie.ID=" & albumID & " " & _
         "ORDER by Track.Position"
   
   
   If bQuerying = False Then
      bQuerying = True
      
      Set sqlTracks = mConnection.OpenRecordset(sql)
      While Not sqlTracks.EOF
         With sqlTracks
            stringShowArtist = vbNullString
            showArtistUnicode = vbNullString
            If boolShowArtist Then
               Set sqlArtist = mConnection.OpenRecordset("Select Actor.Name, Actor.Unicode from Actor INNER JOIN TrackArtist ON Actor.ID=TrackArtist.ArtistID Where TrackArtist.TrackID=" & .fields("ID"))
               While Not sqlArtist.EOF
                  If stringShowArtist = "" Then stringShowArtist = sqlArtist.fields("Name") Else stringShowArtist = stringShowArtist & "+" & sqlArtist.fields("Name")
                  If showArtistUnicode = "" Then showArtistUnicode = sqlArtist.fields("Unicode") Else showArtistUnicode = showArtistUnicode & "+" & sqlArtist.fields("Unicode")
                  sqlArtist.MoveNext
               Wend
            Else
               stringShowArtist = .fields("LabelName")
               showArtistUnicode = .fields("LabelUnicode")
            End If
            sTrackLength = Second2Time(.fields("Length"), True)
            bAvailable = (.fields("MoviePath")) <> "" Or (.fields("MoviePathSmall") <> "") Or (.fields("MoviePathMedium") <> "") Or (.fields("Available") = 1)
            If bAvailable Then iAvailable = 1 Else iAvailable = 0
            Data = Array(.fields("ID"), .fields("Position"), .fields("Name"), .fields("Unicode"), "Mood", "None", "DanceStyle", "Track Artist", stringShowArtist, showArtistUnicode, .fields("Rating"), sTrackLength, .fields("Language"), iAvailable, 0, "", .fields("SingType"), .fields("SeekOffset"), .fields("LabelName"), .fields("LabelUnicode"))
            If tmp = "" Then tmp = Join(Data, de_Field) Else tmp = tmp & de_Record & Join(Data, de_Field)
            .MoveNext
         End With
      Wend
   End If
   
   Set sqlArtist = Nothing
   Set sqlTracks = Nothing
   bQuerying = False
   GetTracksByAlbum = tmp
   Exit Function
Error:
   Log.Writelog "GetTracksByAlbum", "ERROR", Err.Description, Log.LogPara("albumID", albumID, "boolShowArtist", boolShowArtist)
   'WriteEvent "GetTracksByAlbum", Err.Description, Err.Source
End Function

Public Function GetGenre() As String
   On Error GoTo Error
   
   Dim sqlGenre As cRecordset
   Dim varData As Variant
   Dim strTmp As String
   Dim sql As String
  
   sql = "SELECT ID, Name, Unicode FROM Genre ORDER BY Name, Unicode"
   Set sqlGenre = mConnection.OpenRecordset(sql, True)
   
   While Not sqlGenre.EOF
      varData = Array(sqlGenre.fields("ID"), sqlGenre.fields("Name"), sqlGenre.fields("Unicode"))
      If strTmp = "" Then strTmp = Join(varData, de_Field) Else strTmp = strTmp & de_Record & Join(varData, de_Field)
      sqlGenre.MoveNext
   Wend
   
   GetGenre = strTmp
   Exit Function
Error:
   Log.Writelog "GeGenre", "ERROR", Err.Description, "NULL"
End Function

Public Function GetLabel() As String

   On Error GoTo Error
   Dim sqlLabel As cRecordset
   Dim varData As Variant
   Dim strTmp As String
   Dim sql As String
  
   sql = "SELECT ID, Name, Unicode FROM Label ORDER BY Name, Unicode"
   Set sqlLabel = mConnection.OpenRecordset(sql, True)
   
   While Not sqlLabel.EOF
      varData = Array(sqlLabel.fields("ID"), sqlLabel.fields("Name"), sqlLabel.fields("Unicode"), 0)
      If strTmp = "" Then strTmp = Join(varData, de_Field) Else strTmp = strTmp & de_Record & Join(varData, de_Field)
      sqlLabel.MoveNext
   Wend
   
   GetLabel = strTmp
   Exit Function
Error:
   Log.Writelog "GetLabel", "ERROR", Err.Description, "NULL"
End Function


Public Function GetTVSeriesName(ByVal ID As Long) As String

   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Set sqlQuery = mConnection.OpenRecordset("SELECT Name, Unicode FROM TVSeries WHERE ID=" & ID)
   If Not sqlQuery.EOF Then GetTVSeriesName = sqlQuery.fields("Name")
   
   Set sqlQuery = Nothing
   Exit Function
Error:
   Log.Writelog "GetTVSeriesName", "ERROR", Err.Description, "ID = " & ID
End Function


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

Public Function GetActorName(IDs As String, boolUnicode As Boolean) As String

   On Error GoTo Error
   Dim sQueryID As String
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   Dim mNames As String
   Dim mNameUnicode As String
   Dim mRetName As String
   Dim mRetNameUnicode As String
   
   sQueryID = Trim(Replace(IDs, ";", " "))
   sQueryID = Replace(sQueryID, " ", ",")
   
   
   sQueryString = "SELECT group_concat(CASE WHEN (Name ='' OR Name IS NULL) THEN Unicode ELSE Name END,' + ') as Name, " & _
            "       group_concat(CASE WHEN (Unicode='' OR Unicode IS NULL) THEN Name ELSE Unicode END,' + ') as Unicode  FROM  Actor WHERE ID IN(" & sQueryID & ") " & _
            "ORDER BY Name"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   While Not sqlQuery.EOF
      mNames = sqlQuery.fields("Name").Value
      mNameUnicode = sqlQuery.fields("Unicode").Value
      
      If mRetName = "" Then mRetName = mNames Else mRetName = mRetName & " + " & mNames
      If mRetNameUnicode = "" Then mRetNameUnicode = mNameUnicode Else mRetNameUnicode = mRetNameUnicode & " + " & mNameUnicode
      sqlQuery.MoveNext
   Wend
   
   If boolUnicode Then GetActorName = mNames & "%%" & mNameUnicode Else GetActorName = mNames
   
   Exit Function
Error:
   Log.Writelog "GetActorName", "ERROR", Err.Description, "IDs = " & IDs & " ,boolUnicode=" & boolUnicode

End Function
Public Function GetDirectorName(IDs As String, Optional maxName As Integer = 2) As String

   On Error GoTo Error
   Dim sQueryID As String

   'Dim sDirectorName As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryID = Trim(Replace(IDs, ";", " "))
   sQueryID = Replace(sQueryID, " ", ",")
   sQueryString = "SELECT group_concat(Name,'+') as Name, group_concat(Unicode,' + ') as Unicode FROM Director WHERE ID IN(" & sQueryID & ") ORDER BY Name LIMIT " & maxName
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then GetDirectorName = sqlQuery.fields("Name")
   
   Exit Function
Error:
   Log.Writelog "GetDirectorName", "ERROR", Err.Description, "IDs = " & IDs & " ,maxName=" & maxName & " ,sQueryString=" & sQueryString

End Function

Public Function GetAlbumField(ByVal albumID As Long, FieldName As String) As Variant
   On Error GoTo Error
   

   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryString = "SELECT " & FieldName & " FROM Movie WHERE ID=" & albumID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then GetAlbumField = sqlQuery.fields(FieldName)
   
   Exit Function
Error:
   Log.Writelog "GetAlbumField", "ERROR", Err.Description, "albumID = " & albumID & " ,FieldName=" & FieldName & " ,sQueryString=" & sQueryString
End Function


Public Function GetLabelName(ByVal ID As Long) As String

   On Error GoTo Error
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryString = "SELECT Name FROM Label WHERE ID=" & ID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then GetLabelName = sqlQuery.fields("Name")
   
   Exit Function
Error:
   Log.Writelog "GetLabelName", "ERROR", Err.Description, "ID = " & ID & " ,sQueryString=" & sQueryString

End Function




'''Public Function selectAlbumTypeSQL() As String
'''   If mSelectAlbumType = All Then
'''      selectAlbumTypeSQL = ""
'''   ElseIf mSelectAlbumType = Available Then
'''      selectAlbumTypeSQL = "Available=1"
'''   ElseIf mSelectAlbumType = NotAvailable Then
'''      selectAlbumTypeSQL = "Available=0"
'''   End If
'''End Function

Public Function selectFlagTypeSQL() As String
  
   If mSelectFlagType = AllCD Then
      selectFlagTypeSQL = ""
   ElseIf mSelectFlagType = Clean Then
      selectFlagTypeSQL = "Flag=" & Clean
   ElseIf mSelectFlagType = Explicit Then
      selectFlagTypeSQL = "Flag=" & Explicit
   End If
End Function


Public Function selectGroupTypeSQL() As String
   'selectGroupCDType=-1 mean not sort
   'selectGroupCDType=0  mean sort by type
   'selectGroupCDType>0  mean select  and sort by type
   If (mSelectGroupCDType <= 0) Then
      selectGroupTypeSQL = ""
   Else
      selectGroupTypeSQL = "TypeCDID=" & mSelectGroupCDType
   End If
   'If mSelectGroupCDType = -1 Then mGroupType = 0
End Function


Public Function SQLJoinWhere(ParamArray para() As Variant) As String
   Dim i As Integer
   Dim sQuery As String
   
   For i = 0 To UBound(para)
      If para(i) <> "" Then
         If sQuery = "" Then sQuery = para(i) Else sQuery = sQuery & " AND " & para(i)
      End If
   Next
   
   If sQuery <> "" Then sQuery = " WHERE " & sQuery
   SQLJoinWhere = sQuery
End Function

Public Function SQLMovieFlag() As String
   If mSelectFlagType <> AllCD Then
      SQLMovieFlag = "Movie.Flag = " & mSelectFlagType
   End If
End Function

Public Function SQLTVSeason(nSeason As Integer) As String
   If nSeason <> 0 Then
      SQLTVSeason = "Movie.numSeason = " & nSeason
   End If
End Function
Public Function SQLMovieFavorite(nFavorite As Boolean) As String
   If nFavorite = True Then
      SQLMovieFavorite = "Movie.Favorite = 1"
   End If
End Function

Public Function SQLMovieYears(nYear As Integer) As String
   If nYear <> 0 Then
      SQLMovieYears = "Years = " & nYear
   End If
End Function


Public Function SQLMovieAvailable() As String
   If mSelectAlbumType <> All Then
      SQLMovieAvailable = "Movie.Available = " & mSelectAlbumType
   End If
End Function


Public Function GetTVSeriesAvailable() As String
   On Error GoTo Error
   Dim varData As Variant
   Dim mReturnString As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryString = "SELECT TVSeries.ID, TVSeries.Name, TVSeries.Unicode, TVSeries.Seasoncount " & _
                   "FROM TVSeries INNER JOIN Movie ON TVSeries.ID=Movie.TVID " & _
                   SQLJoinWhere(SQLMovieFlag(), SQLMovieAvailable) & _
                   " ORDER BY TVSeries.Name"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      varData = Array(sqlQuery.fields("ID"), sqlQuery.fields("Name"), sqlQuery.fields("Unicode"), sqlQuery.fields("Seasoncount"))
      If mReturnString = "" Then mReturnString = Join(varData, de_Field) Else mReturnString = mReturnString & de_Record & Join(varData, de_Field)
      sqlQuery.MoveNext
   Wend
   GetTVSeriesAvailable = mReturnString
   Exit Function
Error:
   Log.Writelog "GetTVSeriesAvailable", "ERROR", Err.Description, "sQueryString=" & sQueryString
 
End Function

Public Function AlbumByArtist(ArtistID As Long, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional Favorite As Boolean, Optional CDType As CDTypeEnum = AllCD, Optional SearchPage As Boolean = False) As Integer
   On Error GoTo Error
   
   Dim varData As Variant
   Dim var_tmpAlbum() As Variant
   Dim mReturnString As String
   Dim sQueryString As String
   Dim mAlbumArtist As String
   Dim mAlbumID As Long
   Dim sqlQuery As cRecordset
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_Artists As String
   Dim SortKey As Integer
   Dim count As Long
   
'''   Dim sAvailableAndFlag As String
   
   If SearchPage = False Then Erase var_Album
   
'''   sAvailableAndFlag = SQLFlagAvailable
'''   If sAvailableAndFlag <> "" Then sAvailableAndFlag = " AND " & sAvailableAndFlag
  

   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Available, Movie.TypeCDID, Movie.Flag " & _
                  " FROM TrackArtist" & _
                  " INNER JOIN Title ON Title.TrackID = TrackArtist.TrackID" & _
                  " INNER JOIN Movie ON Movie.ID= Title.MovieID " & _
                  " INNER JOIN Actor ON TrackArtist.ArtistID= Actor.ID" & _
                  " INNER JOIN Label ON Movie.LabelID=Label.ID " & _
                  " LEFT JOIN Actor As AlbumArtist ON Movie.AlbumArtistID=AlbumArtist.ID " & _
                   SQLJoinWhere("TrackArtist.ArtistID=" & ArtistID, SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ",Movie.Year", "") & ",Movie.Name"
'''                  " WHERE TrackArtist.ArtistID=" & ArtistID &
   
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mAlbumID = sqlQuery.fields("ID").Value
      loc_Available = sqlQuery.fields("Available").Value
      loc_Flag = sqlQuery.fields("Flag").Value
      ReDim Preserve var_tmpAlbum(count)
      var_tmpAlbum(count) = GetAlbumInfosByID(mAlbumID, loc_Available, SortKey, True, loc_Flag)
      count = count + 1
      sqlQuery.MoveNext
   Wend
   If SearchPage Then var_SearchAlbum = var_tmpAlbum Else var_Album = var_tmpAlbum
   AlbumByArtist = count
   Exit Function
Error:
   Log.Writelog "AlbumByArtist", "ERROR", Err.Description, "ArtistID = " & ArtistID & " ,sQueryString=" & sQueryString & " ,selectType=" & selectType & " ,ArrangeBy=" & ArrangeBy
   'WriteEvent "AlbumByArtist", Err.Description, Err.Source
End Function


Public Function AlbumByArtistLetter(letter As String, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Integer
   MsgBox "May not be useed Function = AlbumByArtistLetter"
End Function

Public Function AlbumByArtistIDs(ArtistIDs As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As CDTypeEnum = AllCD, Optional searchMode As Boolean) As Long
   On Error GoTo Error
   
   Dim varData As Variant
   Dim var_tmpAlbum() As Variant
   Dim mReturnString As String
   Dim sQueryString As String
   Dim mAlbumArtist As String
   Dim mAlbumID As Long
   Dim sqlQuery As cRecordset
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_Artists As String
   Dim SortKey As Integer
   Dim count As Long
   
'''   Dim sAvailableAndFlag As String
   
   If searchMode = False Then Erase var_Album
   
'''   sAvailableAndFlag = SQLFlagAvailable
'''   If sAvailableAndFlag <> "" Then sAvailableAndFlag = " AND " & sAvailableAndFlag
  
   
   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Available, Movie.TypeCDID, Movie.Flag " & _
                  " FROM TrackArtist" & _
                  " INNER JOIN Title ON Title.TrackID = TrackArtist.TrackID" & _
                  " INNER JOIN Movie ON Movie.ID= Title.MovieID " & _
                  " INNER JOIN Actor ON TrackArtist.ArtistID= Actor.ID" & _
                  " INNER JOIN Label ON Movie.LabelID=Label.ID " & _
                  " LEFT JOIN Actor As AlbumArtist ON Movie.AlbumArtistID=AlbumArtist.ID" & _
                   SQLJoinWhere("TrackArtist.ArtistID IN (" & Replace(Trim(Replace(ArtistIDs, ";", " ")), " ", ",") & ")", SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ",Movie.Year", "") & ",Movie.Name"
   
'''                  " WHERE TrackArtist.ArtistID IN (" & Replace(Trim(Replace(ArtistIDs, ";", " ")), " ", ",") & ")" & _

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mAlbumID = sqlQuery.fields("ID").Value
      loc_Available = sqlQuery.fields("Available").Value
      loc_Flag = sqlQuery.fields("Flag").Value
      ReDim Preserve var_tmpAlbum(count)
      var_tmpAlbum(count) = GetAlbumInfosByID(mAlbumID, loc_Available, SortKey, True, loc_Flag)
      count = count + 1
      sqlQuery.MoveNext
   Wend
   If searchMode Then var_SearchAlbum = var_tmpAlbum Else var_Album = var_tmpAlbum
   AlbumByArtistIDs = count
   Exit Function
Error:
   Log.Writelog "AlbumByArtist", "ERROR", Err.Description, "ArtistIDs = " & ArtistIDs & " ,sQueryString=" & sQueryString & " ,selectType=" & selectType & " ,ArrangeBy=" & ArrangeBy
End Function

Public Function AlbumByDirector(DirectorID As Integer, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Long
   On Error GoTo Error


   Dim sQueryString As String
   Dim mAlbumArtist As String
   Dim mAlbumID As Long
   Dim sqlQuery As cRecordset
   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_Artists As String
   Dim SortKey As Integer
   Dim nCount As Long
   
   Dim sAvailableAndFlag As String
   
   
   Erase var_SearchAlbum
   
'''   sAvailableAndFlag = SQLFlagAvailable
'''   If sAvailableAndFlag <> "" Then sAvailableAndFlag = " AND " & sAvailableAndFlag
   
   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Available, Movie.TypeCDID, Movie.Flag " & _
                  " FROM MovieDirector" & _
                  " INNER JOIN Movie ON Movie.ID= MovieDirector.MovieID " & _
                  SQLJoinWhere("MovieDirector.DirectorID=" & DirectorID, SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID,Movie.Name"
                  '" ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ",Movie.Year", "") & ",Movie.Name"
'''                  " WHERE MovieDirector.DirectorID=" & DirectorID & " " &

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mAlbumID = sqlQuery.fields("ID").Value
      loc_Available = sqlQuery.fields("Available").Value
      loc_Flag = sqlQuery.fields("Flag").Value
      ReDim Preserve var_SearchAlbum(nCount)
      var_SearchAlbum(nCount) = GetAlbumInfosByID(mAlbumID, loc_Available, SortKey, True, loc_Flag)
      nCount = nCount + 1
      sqlQuery.MoveNext
   
   
   Wend
   AlbumByDirector = nCount







'''   Dim i As Long
'''
'''   Dim loc_fieldDirector As Integer, loc_fieldAvailable As Integer, loc_fieldFlag As Integer
'''   Dim loc_Available As Integer, loc_Flag As Integer
'''
'''   Dim loc_DirectorIDs As String
'''   Dim loc_Count As Long
'''
'''   Erase var_SearchAlbum
'''
'''   With PV_TableMovie
'''      loc_fieldDirector = .FieldToIndex("DirectorIDs")
'''      loc_fieldAvailable = .FieldToIndex("Available")
'''      loc_fieldFlag = .FieldToIndex("Flag")
'''      For i = 0 To .RecordCount - 1
'''         loc_DirectorIDs = .AbsoluteField(i, loc_fieldDirector)
'''         loc_Available = .AbsoluteField(i, loc_fieldAvailable)
'''         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
'''         If InStr(1, loc_DirectorIDs, ";" & DirectorID & ";", vbTextCompare) > 0 Then
'''            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
'''               ReDim Preserve var_SearchAlbum(loc_Count)
'''               var_SearchAlbum(loc_Count) = GetAlbumInfos(i, loc_Available, 0, False, loc_Flag)
'''               loc_Count = loc_Count + 1
'''            End If
'''         End If
'''      Next
'''   End With
'''   If loc_Count > 0 Then
'''      'sort by name only
'''      QuickSort var_SearchAlbum, Array(1), False
'''   End If
'''   AlbumByDirector = loc_Count
   Exit Function
Error:
   Log.Writelog "AlbumByDirector", "ERROR", Err.Description, Log.LogPara("DirectorID", DirectorID, "selectType", selectType, "CDType", CDType)

End Function
Public Function GetAlbumActorDirectorAudio(ByVal albumID As String) As String
   
'''
'''   On Error GoTo Error
'''
'''   Dim varData As Variant
'''   Dim mReturnString As String
'''   Dim sQueryString As String
'''   Dim mAlbumArtist As String
'''   Dim mAlbumLabel As String
'''   Dim sqlQuery As cRecordset
'''
'''   Dim sAvailableAndFlag As String
'''
'''   sAvailableAndFlag = SQLFlagAvailable
'''   If sAvailableAndFlag <> "" Then sAvailableAndFlag = " AND " & sAvailableAndFlag
'''
'''
'''
'''   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Name, AlbumArtist.Name As AlbumArtistName, Movie.Unicode, Movie.Year, Label.Name As LabelName, Label.Unicode as LabelUnicode, " & _
'''                  " Movie.Rating, Movie.Available, Movie.Favorite,Movie.Rank, Movie.TypeCDID, Movie.Flag, Movie.numSeason" & _
'''                  " FROM TrackArtist" & _
'''                  " INNER JOIN Title ON Title.TrackID = TrackArtist.TrackID" & _
'''                  " INNER JOIN Movie ON Movie.ID= Title.MovieID " & _
'''                  " INNER JOIN Actor ON TrackArtist.ArtistID= Actor.ID" & _
'''                  " INNER JOIN Label ON Movie.LabelID=Label.ID " & _
'''                  " LEFT JOIN Actor As AlbumArtist ON Movie.AlbumArtistID=AlbumArtist.ID" & _
'''                  " WHERE TrackArtist.ArtistID=" & ArtistID & _
'''                  " ORDER BY Movie.Name"
'''   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
'''   While Not sqlQuery.EOF
'''      mAlbumArtist = sqlQuery.Fields("AlbumArtistName")
'''      mAlbumLabel = sqlQuery.Fields("LabelName")
'''      If mAlbumArtist <> "" Then mAlbumLabel = mAlbumArtist
'''      'GetAlbumInfos(i, loc_Available, SortKey, True, loc_Flag)
'''      varData = Array(sqlQuery.Fields("ID"), sqlQuery.Fields("Name"), sqlQuery.Fields("Unicode"), "", sqlQuery.Fields("Year"), mAlbumLabel, _
'''                     sqlQuery.Fields("Rating"), sqlQuery.Fields("Available"), sqlQuery.Fields("Favorite"), 0, sqlQuery.Fields("Rank"), _
'''                     sqlQuery.Fields("TypeCDID"), sqlQuery.Fields("LabelUnicode"), sqlQuery.Fields("numSeason"), sqlQuery.Fields("Flag"))
'''      'Array(albumID, albumName, albumUnicode, SortKey, AlbumDate, ALbumLabel, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, AlbumActorUnicode, AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
'''      If mReturnString = "" Then mReturnString = Join(varData, de_Field) Else mReturnString = mReturnString & de_Record & Join(varData, de_Field)
'''      sqlQuery.MoveNext
'''   Wend
'''

End Function


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
   
   
   
   Dim sqlQuery As cRecordset
   'Set sqlQuery = mConnection.OpenRecordset("SELECT ID, Name, Unice, Year, Rating, Favorite, Rank, Label, LabelUnicode, TypeCDID, AlbumArtistID, ActorName, TVSeriesName, numSeason, AudioIDs, DirectorID, ActorID FROM Movie WHERE ID=" & ID)
   
   
   
'''   With PV_TableMovie
'''      albumID = .AbsoluteField(Index, "ID")
'''      albumName = .AbsoluteField(Index, "Name")
'''      albumUnicode = .AbsoluteField(Index, "Unicode")
'''      albumYear = .AbsoluteField(Index, "Year")
'''      AlbumRating = .AbsoluteField(Index, "Rating")
'''      AlbumFavorite = .AbsoluteField(Index, "Favorite")
'''      AlbumRank = .AbsoluteField(Index, "Rank")
'''      ALbumLabel = .AbsoluteField(Index, "Label")                   'Use label instead of Singer
'''      AlbumActorUnicode = .AbsoluteField(Index, "LabelUnicode")           'Use label instead of Singer
'''      AlbumGroupCDType = .AbsoluteField(Index, "TypeCDID")               'Use label instead of Singer
'''
'''      AlbumArtistID = .AbsoluteField(Index, "AlbumArtistID")
'''      TVSeriesID = .AbsoluteField(Index, "TVID")
'''      If TVSeriesID > 0 Then
'''         numSeason = .AbsoluteField(Index, "numSeason")
'''         AlbumArtist = GetTVSeriesName(TVSeriesID) & "\Season # " & (numSeason)
'''      ElseIf AlbumArtistID > 0 Then
'''         AlbumArtist = GetActorName(";" & AlbumArtistID & ";", False)
'''      End If
'''
'''      If AlbumArtist <> "" Then ALbumLabel = AlbumArtist
'''      AlbumDate = ChangeDate(albumYear, LeaveYear)
'''      AlbumAudioIDs = .AbsoluteField(Index, "AudioIDs")
'''      ' AlbumFlag=
'''      AlbumDirector = GetDirectorName(.AbsoluteField(Index, "DirectorIDs"), 2)
'''      AlbumActor = GetActorName(.AbsoluteField(Index, "ActorID"), False)
'''      Call isValidGroupType(AlbumGroupCDType)
'''                              '0          1           2           3        4              5              6           7                 8       9     10           11                   12             13          14             15             16
'''      GetAlbumInfos = Array(albumID, albumName, albumUnicode, SortKey, AlbumDate, ALbumLabel, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, AlbumActorUnicode, AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
'''
'''   End With
   Exit Function
Error:
   Log.Writelog "GetAlbumInfos", "ERROR", Err.Description, "Index = " & Index & " ,albumAvailable=" & albumAvailable & " ,SortKey=" & SortKey & " ,LeaveYear=" & LeaveYear & " ,AlbumFlag=" & AlbumFlag
End Function



'Public Function AlbumByTVSeries(TVID As Long, SeasonNumber As Integer, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Long
'
'   On Error GoTo Error
'   Dim i As Long
'
'   Dim loc_fieldTVID As Integer, loc_fieldAvailable As Integer, loc_fieldFlag As Integer, loc_fieldSeasonNum As Integer
'   Dim loc_Available As Integer, loc_Flag As Integer
'
'   Dim loc_TVID As Long, loc_SeasonNumber As Long, loc_Count As Long
'
'   Erase var_Album
'
'   Dim sqlQuery As cRecordset
'
'
'   With PV_TableMovie
'      loc_fieldTVID = .FieldToIndex("TVID")
'      loc_fieldSeasonNum = .FieldToIndex("numSeason")
'      loc_fieldAvailable = .FieldToIndex("Available")
'      loc_fieldFlag = .FieldToIndex("Flag")
'      For i = 0 To .RecordCount - 1
'         loc_TVID = .AbsoluteField(i, loc_fieldTVID)
'         loc_SeasonNumber = .AbsoluteField(i, loc_fieldSeasonNum)
'         loc_Available = .AbsoluteField(i, loc_fieldAvailable)
'         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
''         If loc_TVID <> 0 Then
''            Debug.Assert False
''         End If
'         If loc_TVID = TVID And (SeasonNumber = loc_SeasonNumber Or SeasonNumber = 0) Then
'            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
'               ReDim Preserve var_Album(loc_Count)
'               var_Album(loc_Count) = GetAlbumInfos(i, loc_Available, 0, False, loc_Flag)
'               loc_Count = loc_Count + 1
'            End If
'         End If
'      Next
'   End With
'   If loc_Count > 0 Then
'      'sort by name only
'      QuickSort var_Album, Array(1), False
'   End If
'   AlbumByTVSeries = loc_Count
'   Exit Function
'Error:
'   WriteEvent "AlbumByTVSeries", Err.Description, Err.Source
'End Function
'

'''Public Function getAlbumAvailable(languageName As String, ByVal ID As Long, Optional TrackIDs As Variant) As Long
'''   On Error GoTo Error
'''   Dim xmlDoc As New DOMDocument
'''   Dim xmllst As IXMLDOMElement
'''   Dim albumMachine As String
'''   Dim loc_IDs As Variant
'''
'''   xmlDoc.Load SlyVariable("<MyAlbumServer>")
'''   Set xmllst = xmlDoc.selectSingleNode("//Machines/Machine[@Name='" & SlyNickName & "']/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
'''   If xmllst Is Nothing Then
'''      Set xmllst = xmlDoc.selectSingleNode("//Machines/Machine/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
'''      If xmllst Is Nothing Then
'''         getAlbumAvailable = 0
'''      Else
'''         getAlbumAvailable = 2
'''         '=============Modified 20006-10-13==
'''         If Not IsMissing(TrackIDs) Then
'''            loc_IDs = xmllst.getAttribute("TrackIDs")
'''            If Not IsNull(loc_IDs) Then
'''               TrackIDs = loc_IDs
'''            End If
'''         End If
'''         '===================================
'''      End If
'''   Else
'''      '=============Modified 20006-10-13==
'''      If Not IsMissing(TrackIDs) Then
'''         loc_IDs = xmllst.getAttribute("TrackIDs")
'''         If Not IsNull(loc_IDs) Then
'''            TrackIDs = loc_IDs
'''         End If
'''      End If
'''      '===================================
'''      getAlbumAvailable = 1
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "getAlbumAvailable", Err.Description, Err.Source
'''End Function

Public Sub CloseAllDatabase()
   On Error GoTo Error
   'Do nothing since no close connectio
   Exit Sub
Error:
   Log.Writelog "CloseAllDatabase", "ERROR", Err.Description, ""
End Sub


Public Function GetArtist() As String
'Not using
   On Error GoTo Error
   GetArtist = ""
   Exit Function
Error:
   Log.Writelog "GetArtist", "ERROR", Err.Description, ""
End Function
Public Function GetMood() As String
'Not using
   On Error GoTo Error
   GetMood = ""
   Exit Function
Error:
   Log.Writelog "GetMood", "ERROR", Err.Description, ""
End Function

Public Function FavoriteArtistID() As String
   On Error GoTo Errors
   
   Dim mReturnString As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   
   sQueryString = "SELECT ID FROM ACTOR WHERE Favorite=1"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mReturnString = mReturnString & ";" & sqlQuery.fields("ID")
      sqlQuery.MoveNext
   Wend
   FavoriteArtistID = mReturnString & ";"
   Exit Function
Errors:
   Log.Writelog "FavoriteArtistID", "ERROR", Err.Description, ""
   
End Function

Public Function GetAlbumFields(albumID As Long, fields() As Variant) As Variant()
   On Error GoTo Error
   
   Dim m_Fields  As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mReturn As Variant
   Dim i As Integer
   
   
   m_Fields = Join(fields, ",")
   
   sQueryString = "SELECT " & m_Fields & " FROM Movie WHERE ID=" & albumID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then

      ReDim mReturn(sqlQuery.fields.count - 1)
      For i = 0 To UBound(mReturn)
         mReturn(i) = sqlQuery.fields(i).Value
      Next
   End If
   GetAlbumFields = mReturn
   
   Exit Function
Error:
   Log.Writelog "GetAlbumFields", "ERROR", Err.Description, Log.LogPara("albumID", albumID, "fields", m_Fields)

End Function
Public Function GetAlbumYears() As String
   On Error GoTo Error
  
   Dim m_Fields  As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mReturn As String
   
   
   sQueryString = "SELECT DISTINCT strftime('%Y',Year) As Years FROM Movie ORDER by Years DESC"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      
      If mReturn = "" Then
         mReturn = sqlQuery.fields("Years")
      Else
         mReturn = mReturn & de_Record & sqlQuery.fields("Years")
      End If
      sqlQuery.MoveNext
   Wend
   GetAlbumYears = mReturn
   
   Exit Function
Error:
   Log.Writelog "GetAlbumYears", "ERROR", Err.Description, ""
End Function

'Public Function GetArtistStringIDByLetter(startLetter As String) As String
'No reference

Public Function GetChapterFromMovie(ByVal arg_movieID As String, arg_ChapterCount As Integer) As String
   On Error GoTo Error
   
   Dim m_Fields  As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mReturn As String
   Dim mChapterCount As Integer
   Dim mChapters() As Variant
   Dim i As Integer
   
   
   sQueryString = " SELECT Track.Name,Track.JumpTime,Track.Position FROM Movie" & _
                  " INNER JOIN Title ON Movie.MainTitleID=Title.ID" & _
                  " INNER JOIN Track ON Title.TrackID=Track.ID" & _
                  " WHERE Movie.ID = " & arg_movieID & _
                  " ORDER BY Track.Position"

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      ReDim Preserve mChapters(mChapterCount)
      mChapters(mChapterCount) = Array(sqlQuery.fields("Position").Value, sqlQuery.fields("Name").Value, sqlQuery.fields("JumpTime").Value)
      mChapterCount = mChapterCount + 1
      sqlQuery.MoveNext
   Wend
   If mChapterCount = 0 Then
      mChapterCount = arg_ChapterCount
      ReDim Preserve mChapters(mChapterCount - 1)
      For i = 0 To mChapterCount - 1
         mChapters(i) = Array(i + 1, "Chapter " & Format(i + 1, "00"), vbNullString)
      Next
   End If
   For i = 0 To mChapterCount - 1
      m_Fields = Join(mChapters(i), de_Field)
      If mReturn = "" Then
         mReturn = m_Fields
      Else
         mReturn = mReturn & de_Record & m_Fields
      End If
   Next
   GetChapterFromMovie = mReturn
   Exit Function
Error:
   Log.Writelog "GetChapterFromMovie", "ERROR", Err.Description, Log.LogPara("arg_movieID", arg_movieID, "arg_ChapterCount", arg_ChapterCount)
End Function

Public Function GetChapterTime(ByVal arg_movieID As String, ByVal arg_ChapterNumber As Integer) As String
   On Error GoTo Error
   
   Dim m_Fields  As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mReturn As String
   
   
   sQueryString = " SELECT Track.JumpTime FROM Movie" & _
                  " INNER JOIN Title ON Movie.MainTitleID=Title.ID" & _
                  " INNER JOIN Track ON Title.TrackID=Track.ID" & _
                  " WHERE Movie.ID = " & arg_movieID & " AND Track.Position=" & arg_ChapterNumber

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      mReturn = sqlQuery.fields("JumpTime").Value
   End If
   GetChapterTime = mReturn
   Exit Function
Error:
   Log.Writelog "GetChapterTime", "ERROR", Err.Description, Log.LogPara("arg_movieID", arg_movieID, "arg_ChapterNumber", arg_ChapterNumber)
End Function

Public Function GetDanceStyle() As String
   On Error GoTo Error

   GetDanceStyle = vbNullString ' return nothing with dance style
   Exit Function
Error:
   Log.Writelog "GetDanceStyle", "ERROR", Err.Description, ""
   
End Function

Public Function GetEnableAlbumASIN(ByVal albumID As Long) As String
   On Error GoTo Error
   
   Dim m_Fields  As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mReturn As String
   
   
   sQueryString = " SELECT ASIN, BuyCom FROM MOVIE WHERE ID = " & albumID

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      mReturn = sqlQuery.fields("ASIN").Value & "~" & sqlQuery.fields("BuyCom").Value & "~" & vbNullString & "~" & vbNullString
      '.Field("ASIN") & "~" & .Field("BuyCom") & "~" & .Field("WalmartCom") & "~" & .Field("Walmart_DD")
   Else
      mReturn = "~~~"
   End If
   GetEnableAlbumASIN = mReturn
   
   Exit Function
Error:
   Log.Writelog "GetEnableAlbumASIN", "ERROR", Err.Description, Log.LogPara("albumID", albumID)
End Function

Public Function GetArtistStringIDByLetter(startLetter As String) As String
   On Error GoTo Error
   'No reference
   GetArtistStringIDByLetter = vbNullString
   Exit Function
Error:
   Log.Writelog "GetArtistStringIDByLetter", "ERROR", Err.Description, Log.LogPara("startLetter", startLetter)
End Function

Public Function getItemFromID(colObj As Collection, ByVal key As String) As String
On Error GoTo errorOccur:
   getItemFromID = colObj(key)
errorOccur:
End Function

Public Function IsKeyExist(colObj As Collection, ID As String) As Boolean
   On Error GoTo NoKey
   colObj (ID)
   IsKeyExist = True
NoKey:
End Function

Public Sub SetTrackField(TrackID As Long, FieldName As String, Value As Variant)
   On Error GoTo Error
   Dim mQuote As String
   Dim sQueryString As String
   
   If IsNumeric(Value) Then mQuote = "" Else mQuote = "'"
   
   
   sQueryString = "UPDATE Track SET " & FieldName & "= " & mQuote & Value & mQuote & " WHERE ID= " & TrackID
   Call mConnection.Execute(sQueryString)
   Exit Sub
Error:
   Log.Writelog "SetTrackField", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "FieldName", FieldName, "Value", Value)
End Sub
Public Function GetTrackField(TrackID As Long, FieldName As String) As Variant
   On Error GoTo Error
   Dim mQuote As String
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryString = "SELECT " & FieldName & " FROM Track WHERE ID= " & TrackID

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      GetTrackField = sqlQuery.fields(FieldName).Value
   End If
  
   Exit Function
   
Error:
   Log.Writelog "SetTrackField", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "FieldName", FieldName)
End Function

Public Function SetTrackNumPlay(albumID As Long, TrackID As Long) As Integer
   On Error GoTo Error

   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mNumPlay As Integer
   Dim mRating As Integer
   
   
   sQueryString = " SELECT Rating, NumPlay FROM Track WHERE ID = " & TrackID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      mNumPlay = sqlQuery.fields("NumPlay").Value
      mRating = sqlQuery.fields("Rating").Value
      
      If mRating < 5 Then
         If calculateLog(mNumPlay) Then
            mRating = mRating + 1
            SetTrackNumPlay = mRating
         End If
      End If
      If mNumPlay < 9999 Then
         mNumPlay = mNumPlay + 1
      End If
      'Update the numplay and rating into databse
      sQueryString = " Update Track SET Rating= " & mRating & ", NumPlay= " & mNumPlay & " WHERE ID = " & TrackID
      mConnection.Execute sQueryString
   End If
   SetTrackNumPlay = mRating
   Exit Function
Error:
   Log.Writelog "SetTrackNumPlay", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "sQueryString", sQueryString)
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
   Log.Writelog "SetTrackNumPlay", "ERROR", Err.Description, Log.LogPara("Value", Value)
End Function

Public Property Let SetTrackPath(ByVal TrackID As Long, newPath As String)
   
   On Error GoTo Error

   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   
   sQueryString = "UPDATE Track SET Path='" & newPath & "', Available=1 WHERE ID =" & TrackID
      
   Call mConnection.Execute(sQueryString)
   
   Set sqlQuery = mConnection.OpenRecordset("SELECT Changes() FROM Track")
   If Not sqlQuery.EOF Then
      If sqlQuery.fields(0).Value = 1 Then
         sQueryString = "UPDATE Movie SET Available=1 WHERE ID= (SELECT MovieID FROM Track WHERE ID=" & TrackID & ")"
         Call mConnection.Execute(sQueryString)
      End If
   End If

   Exit Property
Error:
   Log.Writelog "SetTrackPath", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "newPath", newPath, "sQueryString", sQueryString)
End Property

Public Function SetAlbumFavorite(ID As Long, values As Boolean) As Boolean
   On Error GoTo Error
   Dim dataValue As Integer
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   
   dataValue = IIf(values, 1, 0)
   
   sQueryString = "UPDATE Movie SET Favorite=" & dataValue & " WHERE ID =" & ID
      
   Call mConnection.Execute(sQueryString)
   SetAlbumFavorite = True
   Exit Function
Error:
   Log.Writelog "SetAlbumFavorite", "ERROR", Err.Description, Log.LogPara("ID", ID, "values", values, "sQueryString", sQueryString)
End Function

Public Function SetArtistFavorite(ID As Long, values As Boolean) As Boolean
   On Error GoTo Error
   Dim dataValue As Integer
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   
   dataValue = IIf(values, 1, 0)

   sQueryString = "UPDATE Actor SET Favorite=" & dataValue & " WHERE ID =" & ID
      
   Call mConnection.Execute(sQueryString)

   SetArtistFavorite = True
   Exit Function
Error:
   Log.Writelog "SetArtistFavorite", "ERROR", Err.Description, Log.LogPara("ID", ID, "values", values, "sQueryString", sQueryString)
End Function

Public Sub SetArtistRating(ID As Long, values As Integer)
   On Error GoTo Error
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   
   sQueryString = "UPDATE Actor SET Rating=" & values & " WHERE ID =" & ID
      
   Call mConnection.Execute(sQueryString)

   Exit Sub
Error:
   Log.Writelog "SetArtistRating", "ERROR", Err.Description, Log.LogPara("ID", ID, "values", values, "sQueryString", sQueryString)
End Sub

Public Sub SetAlbumRank(ID As Long, values As Integer)
   On Error GoTo Error
   Dim dataValue As Integer
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   
   sQueryString = "UPDATE Movie SET Rank=" & values & " WHERE ID =" & ID
      
   Call mConnection.Execute(sQueryString)
   
   Exit Sub
Error:
   Log.Writelog "SetAlbumRank", "ERROR", Err.Description, Log.LogPara("ID", ID, "values", values, "sQueryString", sQueryString)
End Sub
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

Public Function GetNextArtist(startIndex As Integer, ByVal count As Integer, Optional searchMode As Boolean) As String
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
Private Function ReverseDate(ByVal dates As Date) As Integer
   ReverseDate = Year((#1/1/2200# - dates))
   'ReverseDate = ((#1/1/2200# - dates))
End Function

'''Public Function GetNextAlbum(ByVal startIndex As Integer, Optional ByVal count As Integer = 10, Optional paramSearchAlbums As Boolean = False)
'''   On Error GoTo Error:
'''   Dim i As Integer, tmp As String, strPlus As String
'''
'''   Dim var_OneAlbum As Variant
'''   Dim albumAvailable As Long
'''   Dim albumID As Long
'''
'''
''''''   For i = 0 To count - 1
''''''      If Not paramSearchAlbums Then
''''''          On Error Resume Next
''''''          If startIndex + i > UBound(var_Album) Then Exit For
''''''          var_OneAlbum = var_Album(i + startIndex)
''''''      Else
''''''          If startIndex + i > UBound(var_SearchAlbum) Then Exit For
''''''          var_OneAlbum = var_SearchAlbum(i + startIndex)
''''''      End If
''''''      albumAvailable = var_OneAlbum(7)
''''''      albumID = var_OneAlbum(0)
''''''
''''''      If albumAvailable = 0 And cWinsock.isServerConnected Then
''''''         'if albumavailable is egal to 0 then search available from myalbum
''''''         albumAvailable = getAlbumAvailable(currentCountry, albumID)
''''''      End If
''''''                                                                                                                                                                                                                                                                                                                                                                                                                                 'Flag
''''''                           '   0                      1                             2                          3                             4                             5                             6                          7                                   8                                   9
''''''      tmp = tmp & strPlus & albumID & de_Field & var_OneAlbum(1) & de_Field & var_OneAlbum(2) & de_Field & var_OneAlbum(5) & de_Field & var_OneAlbum(8) & de_Field & albumAvailable & de_Field & var_OneAlbum(9) & de_Field & var_OneAlbum(10) & de_Field & ReverseDate(var_OneAlbum(4)) & de_Field & var_OneAlbum(12) & de_Field & var_OneAlbum(13) & de_Field & var_OneAlbum(14) & de_Field & var_OneAlbum(15) & de_Field & var_OneAlbum(16)
''''''                           'AlbumID                albumName                     albumUnicode, SortKey, AlbumDate, AlbumProduction, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, "", AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
''''''                           'AlbumID , albumName, albumUnicode, SortKey, AlbumDate, AlbumProduction, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, "", AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
''''''                              '0          1           2           3        4              5              6              7              8        9        10       11             12    13             14             15          16
''''''      strPlus = de_Record
''''''   Next
''''''   GetNextAlbum = tmp
'''   Exit Function
'''Error:
'''   Log.Writelog "GetNextAlbum", "ERROR", Err.Description, Log.LogPara("startIndex", startIndex, "count", count, "paramSearchAlbums", paramSearchAlbums)
'''End Function

'''Public Function getAlbumAvailables(albumIDs As String, albumLan As String) As String
'''   On Error GoTo Error
'''   Dim IDList() As String
'''   Dim i As Long
'''   Dim IDString As String
'''   IDList = Split(albumIDs, ",")
'''   For i = 0 To UBound(IDList)
'''      If getAlbumAvailable(albumLan, IDList(i)) > 0 Then
'''         If IDString = "" Then IDString = IDList(i) Else IDString = IDString & "," & IDList(i)
'''      End If
'''   Next
'''   getAlbumAvailables = IDString
'''   Exit Function
'''Error:
'''   Log.Writelog "getAlbumAvailables", "ERROR", Err.Description, Log.LogPara("albumIDs", albumIDs, "albumLan", albumLan)
'''End Function

'''Public Function getAlbumAvailable(languageName As String, ByVal ID As Long, Optional TrackIDs As Variant) As Long
'''   On Error GoTo Error
'''   Dim XmlDoc As New DOMDocument
'''   Dim xmllst As IXMLDOMElement
'''   Dim albumMachine As String
'''   Dim loc_IDs As Variant
'''
'''   XmlDoc.Load SlyVariable("<MyAlbumServer>")
'''   Set xmllst = XmlDoc.selectSingleNode("//Machines/Machine[@Name='" & SlyNickName & "']/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
'''   If xmllst Is Nothing Then
'''      Set xmllst = XmlDoc.selectSingleNode("//Machines/Machine/Language[@Name='" & languageName & "' and @ID='" & ID & "']")
'''      If xmllst Is Nothing Then
'''         getAlbumAvailable = 0
'''      Else
'''         getAlbumAvailable = 2
'''         '=============Modified 2006-10-13==
'''         If Not IsMissing(TrackIDs) Then
'''            loc_IDs = xmllst.getAttribute("TrackIDs")
'''            If Not IsNull(loc_IDs) Then
'''               TrackIDs = loc_IDs
'''            End If
'''         End If
'''         '===================================
'''      End If
'''   Else
'''      '=============Modified 2006-10-13==
'''      If Not IsMissing(TrackIDs) Then
'''         loc_IDs = xmllst.getAttribute("TrackIDs")
'''         If Not IsNull(loc_IDs) Then
'''            TrackIDs = loc_IDs
'''         End If
'''      End If
'''      '===================================
'''      getAlbumAvailable = 1
'''   End If
'''   Exit Function
'''Error:
'''   WriteEvent "getAlbumAvailable", Err.Description, Err.Source
'''End Function



Public Sub CreateMyAlbumXml(MachineName As String)
   On Error GoTo Error:

   Dim loc_ServerName As String
   Dim loc_TrackID As Long
   Dim mAlbumID As Integer
   Dim mPathSmall As String
   Dim mPathMedium As String
   Dim mPath       As String
   Dim sQueryString As String
   Dim sqlMovie As cRecordset
   Dim sqlTrack As cRecordset
   Dim mTrackID As Long
   
   
   
   Call mConnection.Execute("DELETE FROM MyAlbumServer")

'''   XmlDoc.Load SlyVariable("<MyAlbumServer>")
'''   Set rootLanguage = XmlDoc.FirstChild
   If CWinsock.LoggedAs(cloneDisplay) Or CWinsock.LoggedAs(independentMode) Or CWinsock.LoggedAs(remoteControl) Or CWinsock.LoggedAs(remotePlaylist) Then
      loc_ServerName = CWinsock.serverID                                    'sever nick name
   Else
      loc_ServerName = SlyNickName
   End If

         '=========================================================
         Set sqlMovie = mConnection.OpenRecordset("SELECT ID, PathSmall, PathMedium, Path FROM Movie WHERE Available=1")
         While Not sqlMovie.EOF
            mPathSmall = sqlMovie.fields("PathSmall").Value
            mPathMedium = sqlMovie.fields("PathMedium").Value
            mPath = sqlMovie.fields("Path").Value
            mAlbumID = sqlMovie.fields("ID").Value
            
            If mPath = vbNullString And mPathMedium = vbNullString And mPathSmall = vbNullString Then
               'In case tracks available
               sQueryString = "SELECT Track.ID, Track.Path FROM Title" & _
               " INNER JOIN Movie ON Movie.MainTitleID=Title.ID " & _
               " INNER JOIN Track ON Title.TrackID=Track.ID " & _
               " WHERE Track.Available =1 AND Movie.ID=" & mAlbumID
               Set sqlTrack = mConnection.OpenRecordset(sQueryString)
               While Not sqlTrack.EOF
                  'TrackID, AlbumID,  ServerName, ServerDesc, Countryname, CountryID
                  mTrackID = sqlTrack.fields("ID")
                  sQueryString = "INSERT INTO MyAlbumServer (TrackID, AlbumID, Server, Machine, CountryID) VALUES(" & mTrackID & "," & mAlbumID & ",'" & loc_ServerName & "','" & MachineName & "'," & CountryID & ")"
                  mConnection.Execute sQueryString
                  sqlTrack.MoveNext
               Wend
            Else
               'In case album available
               sQueryString = "INSERT INTO MyAlbumServer (TrackID, AlbumID, Server, Machine, CountryID) VALUES(0," & mAlbumID & ",'" & loc_ServerName & "','" & MachineName & "'," & CountryID & ")"
               mConnection.Execute sQueryString
               
            End If
            sqlMovie.MoveNext
         Wend
   Exit Sub
Error:
   Log.Writelog "CreateMyAlbumXml", "ERROR", Err.Description, Log.LogPara("MachineName", MachineName)
End Sub

Public Function AddClientAvailable(loadXmlPath As String) As Boolean
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim mAlbumID As Integer
   Dim mTrackID As Long
   Dim mServer As String
   Dim mMachine As String
   
   
   
   Call mConnection.Execute("DELETE FROM MyAlbumServer")
   
   
   
   Dim xmlDocOpen As New DOMDocument
   Dim xmlQuery As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlFirstNode As IXMLDOMElement
   Dim xmlSelectExisting As IXMLDOMElement
   Dim xmlElement As IXMLDOMElement
   
   xmlDocOpen.Load loadXmlPath
   
   If xmlDocOpen.parseError.errorCode = 0 Then
      Set xmlRoot = xmlDocOpen.firstChild
      Set xmlFirstNode = xmlQuery.firstChild
      sQueryString = "DELETE FROM MyAlbumServer WHERE Machine='" & mMachine & "'"
      mConnection.Execute sQueryString
      For Each xmlElement In xmlDocOpen.firstChild.childNodes
         mMachine = xmlElement.getAttribute("Name")          '
         mAlbumID = xmlElement.getAttribute("AlbumID")         '
         mTrackID = xmlElement.getAttribute("TrackID")         '
         mCountryID = xmlElement.getAttribute("CountryID")         '
         mServer = xmlElement.getAttribute("Server")         '
         sQueryString = "INSERT INTO MyAlbumServer (TrackID, AlbumID, Server, Machine, CountryID) VALUES(" & mTrackID & "," & mAlbumID & ",'" & mServer & "','" & mMachine & "'," & mCountryID & ")"
         mConnection.Execute sQueryString
      Next
   End If
   boolAlbumChanged = True                               'To use this variable for refresh the album
   Exit Function
Error:
   Log.Writelog "AddClientAvailable", "ERROR", Err.Description, Log.LogPara("loadXmlPath", loadXmlPath)
End Function

Public Sub RemoveClientAvailable(MachineName As String)
   On Error GoTo Error
'''   Dim xmlDocOpen As New DOMDocument
'''   Dim xmlQuery As New DOMDocument
'''   Dim xmlRoot As IXMLDOMElement
'''   Dim xmlFirstNode As IXMLDOMElement
'''   Dim xmlSelectExisting As IXMLDOMElement
'''   Dim xmlElement As IXMLDOMElement
'''   Dim xmlNodeList As IXMLDOMNodeList
   Dim sQueryString As String
   
   
   sQueryString = "DELETE FROM MyAlbumServer WHERE Machine='" & MachineName & "' OR Server='" & MachineName & "'"
   mConnection.Execute sQueryString
   boolAlbumChanged = True
   'xmlQuery.Load SlyVariable("<MyAlbumServer>")
   '--------------------remove album available from disconnected server ---------------------------------------
'''      Set xmlSelectExisting = xmlQuery.selectSingleNode("//Machines/Machine[@Name='" & MachineName & "']")
'''      If Not xmlSelectExisting Is Nothing Then
'''        xmlQuery.FirstChild.removeChild xmlSelectExisting
'''         boolAlbumChanged = True
'''         xmlQuery.Save SlyVariable("<MyAlbumServer>")
'''      End If
   
   '--------------------remove album available from client connect to disconnected server ---------------------------------------
'''      Set xmlNodeList = xmlQuery.selectNodes("//Machines/Machine[@Server='" & MachineName & "']")
'''      For Each xmlElement In xmlNodeList
'''         xmlQuery.FirstChild.removeChild xmlElement
'''         boolAlbumChanged = True
'''      Next
      'If boolAlbumChanged Then xmlQuery.Save SlyVariable("<MyAlbumServer>")
   Exit Sub
Error:
   Log.Writelog "RemoveClientAvailable", "ERROR", Err.Description, Log.LogPara("MachineName", MachineName)
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
   Log.Writelog "combineAvailable", "ERROR", Err.Description, Log.LogPara("trackavailableIDs", trackavailableIDs, "albumLan", albumLan)
End Function

Public Property Get CountryID() As Long
   CountryID = mCountryID
End Property
Public Property Let CountryID(ByVal iCountryID As Long)
   mCountryID = iCountryID
End Property
Public Function AddID(objCollection As Collection, Name As String, key As String) As Boolean
On Error GoTo errorOccur:
   objCollection.Add Name, key
   AddID = True
errorOccur:
End Function

Public Function getAlbumAvailable(languageName As String, ByVal ID As Long, Optional TrackIDs As Variant) As Long
   On Error GoTo Error
   Dim XmlDoc As New DOMDocument
   Dim xmllst As IXMLDOMElement
   Dim albumMachine As String
   Dim loc_IDs As Variant
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   Dim mAlbumID As Integer
   Dim mTrackID As Long
   Dim mServer As String
   Dim mMachine As String
   Dim mTrackIDs As String
   
   
   
      sQueryString = "SELECT * FROM MyAlbumServer WHERE Machine='" & SlyNickName & "' AND AlbumID=" & ID & " AND CountryID='" & languageName & "'"
      Set sqlQuery = mConnection.OpenRecordset(sQueryString)
      If sqlQuery.EOF Then
         sQueryString = "SELECT * FROM MyAlbumServer WHERE AlbumID=" & ID & " AND CountryID='" & languageName & "'"
         Set sqlQuery = mConnection.OpenRecordset(sQueryString)
         If sqlQuery.EOF Then
            getAlbumAvailable = 0
         Else
            While Not sqlQuery.EOF
               mTrackID = sqlQuery.fields("TrackID")
               If mTrackIDs = "" Then mTrackIDs = mTrackID Else mTrackIDs = mTrackIDs & ";" & mTrackID
               sqlQuery.MoveNext
            Wend
            TrackIDs = mTrackIDs
            getAlbumAvailable = 2
         End If
      Else
         If Not IsMissing(TrackIDs) Then
            While Not sqlQuery.EOF
               mTrackID = sqlQuery.fields("TrackID")
               If mTrackIDs = "" Then mTrackIDs = mTrackID Else mTrackIDs = mTrackIDs & ";" & mTrackID
               sqlQuery.MoveNext
            Wend
            TrackIDs = mTrackIDs
         End If
         getAlbumAvailable = 1
      End If
   Exit Function
Error:
   Log.Writelog "getAlbumAvailable", "ERROR", Err.Description, Log.LogPara("languageName", languageName, "ID", ID)
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
   Log.Writelog "getAlbumAvailables", "ERROR", Err.Description, Log.LogPara("albumIDs", albumIDs, "albumLan", albumLan)
End Function

Public Function GetAlbumInfo(albumID As Long, Optional languagePath As String) As String
   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT Rating, Length, Label.Name AS LabelName, Label.Unicode AS LabelUnicode, Year FROM Movie INNER JOIN Label ON LabelID=Label.ID WHERE Movie.ID=" & albumID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
         GetAlbumInfo = sqlQuery.fields("Rating") & de_Field & sqlQuery.fields("Length") & de_Field & sqlQuery.fields("LabelName") & de_Field & sqlQuery.fields("LabelUnicode") & de_Field & sqlQuery.fields("Year")
   End If
   Exit Function
Error:
   Log.Writelog "GetAlbumInfo", "ERROR", Err.Description, Log.LogPara("albumID", albumID, "languagePath", languagePath)
End Function


Public Function GetFavoriteAlbum() As Long
   On Error GoTo Error
   Dim mCount As Long
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   Dim mTypeGroup As Integer
   
   sQueryString = "SELECT Movie.ID, Movie.Name, Movie.Unicode, Actor.Name AS Singer, Available, Movie.Favorite, Rank, TypeCDID, Actor.Unicode AS SingerUnicode " & _
                  "FROM Movie LEFT JOIN Actor ON Movie.AlbumArtistID=Actor.ID " & _
                   SQLJoinWhere("Movie.Favorite=1", SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER By Movie.Name"
 
'''                  "WHERE " & JointString(" AND ", "Movie.Favorite=1", selectAlbumTypeSQL(), selectFlagTypeSQL(), selectGroupTypeSQL) & _

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      ReDim Preserve var_Album(mCount)
      If mSelectGroupCDType = -1 Then mTypeGroup = 0 Else mTypeGroup = sqlQuery.fields("TypeCDID")
      var_Album(mCount) = Array(sqlQuery.fields("ID").Value, sqlQuery.fields("Name").Value, sqlQuery.fields("Unicode").Value, 0, 0, sqlQuery.fields("Singer"), 0, sqlQuery.fields("Available"), sqlQuery.fields("Favorite"), 0, sqlQuery.fields("Rank"), mTypeGroup, sqlQuery.fields("SingerUnicode"))
      sqlQuery.MoveNext
      mCount = mCount + 1
   Wend
   
   GetFavoriteAlbum = mCount
   Exit Function
Error:
   Log.Writelog "GetFavoriteAlbum", "ERROR", Err.Description, Log.LogPara("sQueryString", sQueryString)
End Function

Public Function JointString(mDelimiter As String, ParamArray mListing() As Variant) As String
   Dim i As Integer
   Dim mReturn As String
   
   For i = 0 To UBound(mListing)
      If mListing(i) <> "" Then
         If mReturn = "" Then mReturn = mListing(i) Else mReturn = mReturn & mDelimiter & mListing(i)
      End If
   Next
   JointString = mReturn
End Function


Public Function GetFavoriteArtist(getType As Integer, Optional max As Integer = 50) As String
   On Error GoTo Error
'getType = 1 indicate  name
'getType = 5 indicate  rank
'getType = 6 indicate  date
   
   Dim mCount As Long
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   Dim mTypeGroup As Integer
   Dim sOrderBy As String
   
   If getType = 1 Then
      sOrderBy = " ORDER BY Actor.Name"
   ElseIf getType = 5 Then
      sOrderBy = " ORDER BY Actor.Rating"
   ElseIf getType = 6 Then
      'sOrderBy = "ORDER BY Actor.Date"
      sOrderBy = ""        'No date
   End If
   sQueryString = "SELECT DISTINCT ArtistID,Actor.Name, Actor.Unicode,Actor.Favorite,Actor.Rating FROM trackartist " & _
                  " INNER JOIN Title on Trackartist.TrackID=Title.TrackID " & _
                  " INNER JOIN Movie ON Title.ID=Movie.MainTitleID" & _
                  " INNER JOIN Actor ON ArtistID=Actor.ID" & _
                   SQLJoinWhere("Actor.Favorite = 1", SQLMovieFlag(), SQLMovieAvailable()) & _
                  sOrderBy
                  
'''                  " WHERE " & JointString(" AND ", "Actor.Favorite = 1", selectFlagTypeSQL, selectGroupTypeSQL, selectAlbumTypeSQL) &

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      ReDim Preserve var_Artist(mCount)
      var_Artist(mCount) = Array(sqlQuery.fields("ArtistID").Value, sqlQuery.fields("Name").Value, sqlQuery.fields("Unicode").Value, sqlQuery.fields("Favorite").Value, 0, sqlQuery.fields("Rating").Value, 0)
      sqlQuery.MoveNext
      mCount = mCount + 1
   Wend
   bCancelBrowse = False
   If mCount > 0 Then GetFavoriteArtist = GetNextArtist(0, mCount)
   
 
   
   Exit Function
Error:
   Log.Writelog "GetFavoriteArtist", "ERROR", Err.Description, Log.LogPara("getType", getType, "max", max)
End Function

Public Function getMyAlbum(filterMachine As String, languageName As String) As String
   'Not used

   Log.Writelog "getMyAlbum", "ERROR", Err.Description, Log.LogPara("filterMachine", filterMachine, "languageName", languageName)
End Function

Public Function GetNewestYear() As Integer
   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim sQueryString As String


   sQueryString = "SELECT MAX(Year) AS MaxYear FROM Movie"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      GetNewestYear = Year(sqlQuery.fields("MaxYear").Value)
   End If

   Exit Function
Error:
   Log.Writelog "GetNewestYear", "ERROR", Err.Description, Log.LogPara("NULL", "")
End Function

Public Function GetNextAlbum(ByVal startIndex As Integer, Optional ByVal count As Integer = 10, Optional paramSearchAlbums As Boolean = False)
   On Error GoTo Error
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
Error:
   Log.Writelog "GetNextAlbum", "ERROR", Err.Description, Log.LogPara("startIndex", startIndex, "count", count, "paramSearchAlbums", paramSearchAlbums)
End Function


Public Function GetStreamPath(ByVal albumID As Long, ByVal TrackID As Long, iPlayFrom As Integer) As String
   MsgBox "GetStreamPath"
'''   On Error GoTo Error
'''   Dim i As Long, iLoopCount As Integer
'''   Dim loc_iMovieSeek  As Long, loc_iTrackSeek As Long
'''   Dim loc_sTrackPath  As String, loc_strFieldName As String
'''   Dim varArrayField As Variant, varArrayIndex As Variant
'''
'''   varArrayField = Array("Path", "Path", "PathMedium", "PathSmall", "Path", "PathMedium")         'first one may not be used
'''   varArrayIndex = Array(1, 1, 2, 3, 1, 2)                 'first one may not be used
'''   loc_iMovieSeek = PV_TableMovie.Seeks(albumID)
'''   If iPlayFrom < 4 Then
'''      If loc_iMovieSeek >= 0 Then
'''         For i = iPlayFrom To UBound(varArrayField)           'loop to check first available track
'''            iLoopCount = iLoopCount + 1
'''            loc_strFieldName = varArrayField(i)
'''            iPlayFrom = varArrayIndex(i)
'''            loc_sTrackPath = PV_TableMovie.AbsoluteField(loc_iMovieSeek, loc_strFieldName)
'''            'if found or reach max loop
'''            If (iLoopCount >= 3) Or loc_sTrackPath <> "" Then Exit For
'''         Next
'''      End If
'''   End If
'''   If loc_sTrackPath = "" Then                              'if still can't find the path so get from chapter path
'''      loc_iTrackSeek = PV_TableTrack.Seeks(TrackID)
'''      If loc_iTrackSeek >= 0 Then
'''         loc_sTrackPath = PV_TableTrack.AbsoluteField(loc_iTrackSeek, "Path")
'''         iPlayFrom = 4                 'Track path
'''      End If
'''
'''   End If
'''   GetStreamPath = loc_sTrackPath
'''   Exit Function
'''Error:
'''   WriteEvent "GetStreamPath", Err.Description, Err.Source
End Function

Public Function SetCountry(country As String, directory As String, Optional aDatabaseType As Integer = 0) As Boolean
   On Local Error GoTo Error
   
   mCountryName = country
   mCountryPath = directory
   
'''   If Fight(directory, 9) <> "\Database" Then
'''      prv_Directory = directory & "\Database"
'''   Else
'''      prv_Directory = directory
'''   End If
   InitDatabase mCountryPath
   languageServerLink = getLanguageServer(country)
   mDatabaseType = get_country_type(country)
   SetCountry = True
   Exit Function
   
Error:
   SetCountry = False
   Log.Writelog "SetCountry", "ERROR", Err.Description, Log.LogPara("country", country, "directory", directory, "aDatabaseType", aDatabaseType)

End Function


'''Public Property Get InitDatabase() As String
'''   On Error GoTo Error
'''   InitDatabase = PV_strBrowseFolder
'''   Exit Property
'''Error:
'''   Log.Writelog "SetCountry", "ERROR", Err.Description, Log.LogPara("country", country, "directory", directory, "aDatabaseType", aDatabaseType)
'''End Property
Public Function InitDatabase(varValue As String) As Boolean
   On Error GoTo Error
   'PV_strBrowseFolder = fso.BuildPath(varValue, "\")
   
   'SetDirectory InitDatabase        'Set default directory for table
   'initialize all variables                                       ==============================================
      Initialize fso.BuildPath(App.path, "Database\khmer karaoke.sqlite")
      'LoadTypeCD
   '=============================================================================================================
   InitDatabase = True
   Exit Function
Error:
   InitDatabase = False
   Log.Writelog "InitDatabase", "ERROR", Err.Description, Log.LogPara("varValue", varValue)
End Function
Public Function GetLastLanguage() As String
   GetLastLanguage = mCountryName
End Function

Public Sub EditAlbumRating(albumID As Long, Rating As Integer)
   On Error GoTo Error
   SetAlbumField albumID, "Rating", Rating
   Exit Sub
Error:
   Log.Writelog "EditAlbumRating", "ERROR", Err.Description, Log.LogPara("albumID", Rating)
End Sub

Public Function isTrackAvailable(ByVal TrackID As Long) As Boolean
   On Error GoTo Error
  

   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   
   sQueryString = "SELECT Path FROM Track Where Available =1 AND ID=" & TrackID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      isTrackAvailable = True
   Else
      isTrackAvailable = False
   End If
      
   Exit Function
Error:
   Log.Writelog "isTrackAvailable", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID)
End Function


Public Function GetTrackPath(ByVal TrackID As Long, ByVal albumID As Long, Optional iPlayFrom As Integer) As String
   On Error GoTo Error
'''   Dim loc_TrackID As Long
'''   Dim loc_iMovieSeek As Long
'''   Dim loc_MovieID As Long
'''   Dim loc_sTrackPath As String
'''   Dim loc_iTrackSeek As Long
'''   Dim str_Name As String
   
   Dim lMoviePath As String
   Dim lMovieMedium As String
   Dim lMovieSmall As String
   Dim lMoviePathTrailer As String
   Dim lPathReturn As String
   Dim lTrackPath As String
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   
   
   sQueryString = "SELECT Path, PathSmall, PathMedium, PathTrailer FROM Movie WHERE Movie.ID=" & albumID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
         lMoviePath = sqlQuery.fields("Path").Value
         lMovieMedium = sqlQuery.fields("PathMedium").Value
         lMovieSmall = sqlQuery.fields("PathSmall").Value
         lMoviePathTrailer = sqlQuery.fields("PathTrailer").Value
   End If
      
   sQueryString = "SELECT Path FROM Track WHERE ID=" & TrackID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
         lTrackPath = sqlQuery.fields("Path").Value
   End If
      
   
   If iPlayFrom = 1 Then            'Large Link
      lPathReturn = lMoviePath
   ElseIf iPlayFrom = 2 Then        'Medium Link
      lPathReturn = lMovieMedium
   ElseIf iPlayFrom = 3 Then         'Small Link
      lPathReturn = lMovieSmall
   ElseIf iPlayFrom = 5 Then
      GetTrackPath = ""
   ElseIf iPlayFrom = 6 Then              'Trailer
      lPathReturn = lMoviePathTrailer
   ElseIf iPlayFrom = 4 Then           'Play from Track path
      lPathReturn = lTrackPath
   ElseIf iPlayFrom = 0 Then
      If TrackID > 0 Then
         If lMoviePath <> "" Then lPathReturn = lMoviePath: iPlayFrom = 1
         If lMovieMedium <> "" Then lPathReturn = lMovieMedium: iPlayFrom = 2
         If lMovieSmall <> "" Then lPathReturn = lMovieSmall: iPlayFrom = 3
         If lTrackPath <> "" Then lPathReturn = lTrackPath: iPlayFrom = 4
      ElseIf albumID > 0 Then
          If lMoviePathTrailer <> "" Then lPathReturn = lMoviePathTrailer: iPlayFrom = 6
      End If
   End If
   GetTrackPath = lPathReturn

   Exit Function
Error:
   Log.Writelog "GetTrackPath", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "albumID", albumID, "iPlayFrom", iPlayFrom)
End Function


Public Function GetAlbumWalmart(ByVal albumID As Long, Optional Company As String = "WalMart", Optional ByVal path As String) As String
   On Error GoTo Error
   'Seem not use

   GetAlbumWalmart = vbNullString & Delimiter & vbNullString

   Exit Function
Error:
   Log.Writelog "GetAlbumWalmart", "ERROR", Err.Description, Log.LogPara("albumID", albumID, "Company", Company, "path", path)
End Function


Public Function SetAlbumField(ID As Long, FieldName As String, Value As Variant) As Boolean
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim lQuote As String
   
   If IsNumeric(Value) = False Then lQuote = "'" Else lQuote = ""
   
   sQueryString = "UPDATE Movie SET " & FieldName & "=" & lQuote & Value & lQuote & " WHERE ID =" & ID
   Call mConnection.Execute(sQueryString)
   
   SetAlbumField = True
   Exit Function
Error:

   SetAlbumField = False
   Log.Writelog "SetAlbumField", "ERROR", Err.Description, Log.LogPara("ID", ID, "FieldName", FieldName, "Value", Value)

End Function


Public Function GetTrackFields(TrackID As Long, fields() As Variant) As Variant
   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   Dim sJoinQuery As String
   Dim sFields() As Variant
   Dim i As Integer
   
   sJoinQuery = Join(fields, ",")
  
   
   sQueryString = "SELECT " & sJoinQuery & " FROM Track WHERE ID=" & TrackID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      
      ReDim Preserve sFields(UBound(fields))
      For i = 0 To UBound(sFields)
         sFields(i) = sqlQuery.fields(i).Value
      Next
   End If

   GetTrackFields = sFields
   Exit Function
Error:
   Log.Writelog "GetTrackFields", "ERROR", Err.Description, Log.LogPara("TrackID", TrackID, "fields", sJoinQuery)
End Function
Public Function GetMovieAudios(ByVal MovieID As Long) As String

   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT GROUP_CONCAT(MovieAudio.AudioID,';') AudioIDs FROM MovieAudio WHERE MovieAudio.MovieID=" & MovieID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   If sqlQuery.EOF = False Then
      GetMovieAudios = ";" & sqlQuery.fields("AudioIDs").Value & ";"
   End If
   
   Exit Function
ErrorOccure:
   Log.Writelog "GetMovieAudios", "ERROR", Err.Description, Log.LogPara("movieID", MovieID)
End Function
Public Function GetMovieDirectorIDs(ByVal MovieID As Long) As String

   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT GROUP_CONCAT(MovieDirector.DirectorID,';') DirectorIDs FROM MovieDirector WHERE MovieDirector.MovieID=" & MovieID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   If sqlQuery.EOF = False Then
      GetMovieDirectorIDs = ";" & sqlQuery.fields("DirectorIDs").Value & ";"
   End If
   
   Exit Function
ErrorOccure:
   Log.Writelog "GetMovieDirectorIDs", "ERROR", Err.Description, Log.LogPara("movieID", MovieID)
End Function

Public Function GetMovieActorIDs(ByVal MovieID As Long) As String

   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT group_concat( Distinct TrackArtist.ArtistID) AS ActorIDs FROM Track " & _
                  "INNER JOIN Movie ON Track.MovieID=Movie.ID " & _
                  "INNER JOIN TrackArtist ON TrackArtist.TrackID=Track.ID " & _
                  "WHERE Track.movieID = 10"
                  
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   If sqlQuery.EOF = False Then
      GetMovieActorIDs = ";" & Replace(sqlQuery.fields("ActorIDs").Value, ",", ";") & ";"
   End If
   
   Exit Function
ErrorOccure:
   Log.Writelog "GetMovieActorIDs", "ERROR", Err.Description, Log.LogPara("movieID", MovieID)
End Function

Public Function SearchLabelIDInPlayList(Name As String) As Long

   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT ID FROM Label WHERE Name='" & Name & "'"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      
      SearchLabelIDInPlayList = sqlQuery.fields(0).Value
   End If

   Exit Function
Error:
   Log.Writelog "SearchLabelIDInPlayList", "ERROR", Err.Description, Log.LogPara("Name", Name)
End Function

Public Function SearchArtistIDInPlayList(Name As String) As Long
   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim sQueryString As String
   
   sQueryString = "SELECT ID FROM Actor WHERE Name='" & Name & "'"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   If Not sqlQuery.EOF Then
      SearchArtistIDInPlayList = sqlQuery.fields(0).Value
   End If

   Exit Function

Error:
   Log.Writelog "SearchArtistIDInPlayList", "ERROR", Err.Description, Log.LogPara("Name", Name)
End Function

Public Function GetAlbumInfosByID(mAlbumID As Long, albumAvailable As Integer, SortKey As Integer, LeaveYear As Boolean, AlbumFlag As Integer) As Variant
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
   
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   'modified 2005-08-23/seng
   
   sqlString = "SELECT Movie.ID,Movie.Name,Movie.Unicode,Movie.Year, Movie.Rating, Movie.Favorite, Movie.Rank, Label.Name AS LabelName,Label.Unicode AS LabelUnicode," & _
               "Movie.TypeCDID , Movie.AlbumArtistID, Movie.TVID, TVSeries.Name, Movie.numSeason" & _
               " FROM Movie INNER JOIN Label ON Movie.LabelID=Label.ID LEFT JOIN TVSeries ON TVSeries.ID=Movie.TVID" & _
               " WHERE Movie.ID=" & mAlbumID
   
   Set sqlQuery = mConnection.OpenRecordset(sqlString)
   If sqlQuery.EOF = False Then        'if found the record sets
      albumID = sqlQuery.fields("ID").Value
      albumName = sqlQuery.fields("Name").Value
      albumUnicode = sqlQuery.fields("Unicode").Value
      albumYear = sqlQuery.fields("Year").Value
      AlbumRating = sqlQuery.fields("Rating").Value
      AlbumFavorite = sqlQuery.fields("Favorite").Value
      AlbumRank = sqlQuery.fields("Rank").Value
      ALbumLabel = sqlQuery.fields("LabelName").Value                   'Use label instead of Singer
      AlbumActorUnicode = sqlQuery.fields("LabelUnicode").Value           'Use label instead of Singer
      AlbumGroupCDType = sqlQuery.fields("TypeCDID").Value               'Use label instead of Singer
      AlbumArtistID = sqlQuery.fields("AlbumArtistID").Value
      TVSeriesID = sqlQuery.fields("TVID").Value

      If TVSeriesID > 0 Then
         numSeason = sqlQuery.fields("numSeason")
         AlbumArtist = GetTVSeriesName(TVSeriesID) & "\Season # " & (numSeason)
      ElseIf AlbumArtistID > 0 Then
         AlbumArtist = GetActorName(";" & AlbumArtistID & ";", False)
      End If

      If AlbumArtist <> "" Then ALbumLabel = AlbumArtist
      AlbumDate = ChangeDate(albumYear, LeaveYear)
      
      AlbumAudioIDs = GetMovieAudios(albumID)
      AlbumDirector = GetDirectorName(GetMovieDirectorIDs(albumID), 2)
      AlbumActor = GetActorName(GetMovieActorIDs(albumID), False)
      Call isValidGroupType(AlbumGroupCDType)
                              '0          1           2           3        4              5              6           7                 8       9     10           11                   12             13          14             15             16
      GetAlbumInfosByID = Array(albumID, albumName, albumUnicode, SortKey, AlbumDate, ALbumLabel, AlbumRating, albumAvailable, AlbumFavorite, 0, AlbumRank, AlbumGroupCDType, AlbumActorUnicode, AlbumActor, AlbumDirector, AlbumAudioIDs, AlbumFlag)
   End If
   
   Exit Function
Error:
   Log.Writelog "GetAlbumInfos", "ERROR", Err.Description, "mALbumID = " & mAlbumID & " ,albumAvailable=" & albumAvailable & " ,SortKey=" & SortKey & " ,LeaveYear=" & LeaveYear & " ,AlbumFlag=" & AlbumFlag
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
Public Function AlbumByLabel(ByVal LabelID As Integer, Optional letter As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As CDTypeEnum = AllCD, Optional searchMode As Boolean) As Long
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mCount As Integer
   Dim SortKey As Integer
   Dim var_tmpAlbum() As Variant
   
   If searchMode Then Erase var_SearchAlbum Else Erase var_Album
   
   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Available, Movie.TypeCDID, Movie.Flag " & _
                  " FROM Label" & _
                  " INNER JOIN Movie ON Movie.LabelID=Label.ID " & _
                   SQLJoinWhere("Label.ID=" & LabelID, SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ", Movie.Year", "") & ",Movie.Name"

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   While Not sqlQuery.EOF
      mAlbumID = sqlQuery.fields("ID").Value
      mAvailable = sqlQuery.fields("Available").Value
      mFlag = sqlQuery.fields("Flag").Value
      ReDim Preserve var_tmpAlbum(mCount)
      var_tmpAlbum(mCount) = GetAlbumInfosByID(mAlbumID, mAvailable, SortKey, True, mFlag)
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   If searchMode Then var_SearchAlbum = var_tmpAlbum Else var_Album = var_tmpAlbum
   
   AlbumByLabel = mCount

   Exit Function
Error:
   Log.Writelog "AlbumByLabel", "ERROR", Err.Description, Log.LogPara("LabelID", LabelID, "letter", letter, "selectType", selectType, "ArrangeBy", ArrangeBy, "CDType", CDType, "searchMode", searchMode)

End Function

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
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   
   Dim loc_PathTrackID As String, loc_SaveInPlayer As String, loc_SaveInPlayList As String, loc_Font As String
   Dim loc_EngFont As String, loc_UniFont As String, loc_EngSize As Integer, loc_UniSize As Integer
   
   loc_EngFont = "Arial":    loc_EngSize = 11
   loc_UniFont = "Khmer OS": loc_UniSize = 22
   loc_Font = loc_EngFont & "||" & loc_UniFont & "%~%" & loc_EngSize & "||" & loc_UniSize
   
   
   sQueryString = "SELECT ID, Name, Unicode, MovieID, Position,Language, Rating, SeekOffset,Movie.Name, " & _
                  "Movie.Name as MovieName, Movie.Unicode as MovieUnicode, Movie.Year As MovieYear, " & _
                  "Label.Name As LabelName, Label.Unicode As LabelUnicode" & _
                  "FROM Track " & _
                  "INNER JOIN Title ON Title.TrackID=Track.ID " & _
                  "INNER JOIN Movie ON Movie.ID=Title.MovieID " & _
                  "INNER JOIN Label ON Movie.LabelID=Label.ID " & _
                  "WHERE TRACK.ID = " & lpTrackID
                  
                  
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   If Not sqlQuery.EOF Then
      loc_TrackTitle = sqlQuery.fields("Name").Value
      loc_TrackTitleUnicode = sqlQuery.fields("Unicode").Value
      loc_AlbumID = sqlQuery.fields("MovieID").Value
      loc_TrackNo = sqlQuery.fields("Position").Value
      loc_LanTrack = sqlQuery.fields("Language").Value
      loc_Rating = sqlQuery.fields("Rating").Value
      TVSeriesID = sqlQuery.fields("TVID").Value
      numSeason = sqlQuery.fields("numSeason").Value
      AlbumArtistID = sqlQuery.fields("AlbumArtistID").Value
       
       
      If setEnableSeekOfsset Then
         loc_SeekOffset = sqlQuery.fields("SeekOffset").Value
      Else
         loc_SeekOffset = 0
      End If
      
      loc_Album = sqlQuery.fields("MovieName").Value
      loc_AlbumUnicode = sqlQuery.fields("MovieUnicode").Value
      loc_Year = sqlQuery.fields("MovieYear").Value
      loc_LabelID = sqlQuery.fields("LabelID").Value
      
      'Label ID
      
      loc_Artist = sqlQuery.fields("LabelName").Value
      loc_ArtistUnicode = sqlQuery.fields("LabelUnicode").Value
      
      If TVSeriesID > 0 Then
         AlbumArtist = GetTVSeriesName(TVSeriesID) & "\Season # " & (numSeason)
      ElseIf AlbumArtistID > 0 Then
         AlbumArtist = GetActorName(";" & AlbumArtistID & ";", False)
      End If
      
      If AlbumArtist = "" Then AlbumArtist = loc_Artist
      loc_Pic = GetArtistStartLetter(AlbumArtist) & "\" & AlbumArtist
      
      
   Else
      lpIDNotFound = True
   End If
   
 
   loc_walMartAvailable = 0
   loc_ShoppingID = ""
   
   loc_ComName = lpComName
   loc_LanName = GetLastLanguage 'prv_Country
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



Public Function SearchAvailableType(ByVal albumID As Long) As Integer
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim loc_sPath As String
  
   sQueryString = "SELECT Path, PathMedium, PathSmall FROM Movie WHERE ID = " & albumID
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   
   If Not sqlQuery.EOF Then
      '1=From LargeLink,2=MediumLink,3=SmallLink,4=ChapterPath,5=AlbumPath,6=TrialerPath

      loc_sPath = sqlQuery.fields("Path").Value
      If loc_sPath <> "" Then SearchAvailableType = 1
      loc_sPath = sqlQuery.fields("PathMedium").Value
      If loc_sPath <> "" Then SearchAvailableType = SearchAvailableType Or 2
      loc_sPath = sqlQuery.fields("PathSmall").Value
      If loc_sPath <> "" Then SearchAvailableType = SearchAvailableType Or 4
   End If
   

   Exit Function
Error:
   Log.Writelog "SearchAvailableType", "ERROR", Err.Description, Log.LogPara("albumID", albumID)
End Function

Public Function getTrackAvailables(TrackIDs As String, TrackLan As String, returnNonAvailable As String) As String
   On Error GoTo Error
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim loc_sPath As String
   Dim IDList() As String
   Dim IDString As String
   
   Dim mPath As String
   Dim mPathMedium As String
   Dim mPathSmall As String
   Dim mTrackAvailable As Long
   Dim mAlbumAvailable As Long
   Dim nCount As Long
   Dim loc_NotAvailableID As String
   

   sQueryString = "SELECT Path, PathMedium, PathSmall,Movie.Available AS AlbumAvailable, Track.Available AS TrackAvailable FROM Track " & _
                  "INNER JOIN Title ON Title.TrackID=Track.ID " & _
                  "INNER JOIN Movie ON Movie.ID=Title.MovieID " & _
                  "WHERE Track.ID IN (" & Replace(Trim(Replace(TrackIDs, ",", " ")), " ", ",") & ")"
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   
   If Not sqlQuery.EOF Then
      mPath = sqlQuery.fields("Path").Value
      mPathMedium = sqlQuery.fields("PathMedium").Value
      mPathSmall = sqlQuery.fields("PathSmall").Value
   
      mAlbumAvailable = sqlQuery.fields("AlbumAvailable").Value
      If mPath = "" And mPathMedium = "" And mPathSmall = "" Then mAlbumAvailable = 0
      
      If mTrackAvailable = 1 Or mAlbumAvailable > 0 Then
         If IDString = vbNullString Then
            IDString = IDList(nCount)
         Else
            IDString = IDString & "," & IDList(nCount)
         End If
      Else
         If loc_NotAvailableID = vbNullString Then
            loc_NotAvailableID = IDList(nCount)
         Else
            loc_NotAvailableID = loc_NotAvailableID & "," & IDList(nCount)
         End If
      End If
      nCount = nCount + 1
   
   End If

Error:

   Log.Writelog "getTrackAvailables", "ERROR", Err.Description, Log.LogPara("TrackIDs", TrackIDs, "TrackLan", TrackLan, "returnNonAvailable", returnNonAvailable)
End Function



Public Function SelectAlbumsFromList(Optional boolSort As Boolean, Optional ByVal sortIndex As Integer) As Long
   On Error GoTo Error
   Dim i As Long     ', j As Long
   Dim albumID As Long
   Dim newSeekIndex As Long
   Dim AlbumCount As Long
   Dim SortArray As Variant
   Dim albumAvailable As Integer
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim nCount As Long
   
   
   sortIndex = 3 + sortIndex
   
'''   If collectionSelectList.count > 0 Then
'''      With PV_TableMovie
         For i = 1 To collectionSelectList.count
         
                  
            albumID = val(collectionSelectList(i))
            
            If albumID <> 0 Then   ' this statement add by muny because albumID="", so errro 13
               sQueryString = "SELECT Available FROM Movie WHERE ID=" & albumID
               Set sqlQuery = mConnection.OpenRecordset(sQueryString)
                If sqlQuery.EOF = False Then
                   ReDim Preserve var_Album(nCount)
                   albumAvailable = sqlQuery.fields("Available").Value
                   
                   albumAvailable = getAlbumAvailable(currentCountry, albumID)
                   var_Album(nCount) = GetAlbumInfosByID(albumID, albumAvailable, 0, False, 0)
                   nCount = nCount + 1
                End If
            End If
         Next

''''   If j > 0 Then
''''      If boolSort Then
''''         'Sort type >>>Artist>>>Sort Index
''''         SortArray = ReturnSortArray(5, mSelectGroupCDType <> -1, sortIndex, True, 1, sortIndex <> 1)
''''         QuickSort var_Album, SortArray
''''      End If
''''   End If
   SelectAlbumsFromList = nCount
   Exit Function
Error:
   Log.Writelog "SelectAlbumsFromList", "ERROR", Err.Description, Log.LogPara("boolSort", boolSort, "sortIndex", sortIndex)
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
   Dim loc_IDLists() As Long
   Dim iTracNo As Long
   Dim iTrackID As Long
   Dim iFoundCount As Integer
   Dim loc_IDIndex As Long
   
   
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim sqlTrack As cRecordset


   
   If sPlayFrom = "" Then Exit Function
   'Special case for DVD====================================================================================
   
   loc_FileList = SplitFileFromOpenDialog(varPathValue)
   
   If UBound(loc_FileList) > 0 Then
      'Save files to chapters
      ReDim loc_TrackNumber(-1 To UBound(loc_FileList))
      For i = 0 To UBound(loc_FileList)
         loc_TrackNumber(i) = GetTrackNumber(fso.GetBaseName(loc_FileList(i)))
      Next
      sQueryString = "SELECT MainTitleID, MainTitle FROM Movie WHERE Movie.ID=" & var_CurrentAlbumID
      Set sqlQuery = mConnection.OpenRecordset(sQueryString)
      If Not sqlQuery.EOF Then
         iMainTitleID = sqlQuery.fields("MainTitleID").Value
         iMainTitle = sqlQuery.fields("MainTitle").Value
         
         sQueryString = "SELECT TrackID, Position FROM Title INNER JOIN Track ON Track.ID=Title.TrackID WHERE Title.MovieID=" & iMainTitleID
         Set sqlQuery = mConnection.OpenRecordset(sQueryString)
         i = 0
         If Not sqlQuery.EOF Then
            ReDim Preserve loc_IDLists(i)
            iTrackID = sqlQuery.fields("TrackID").Value
            iTracNo = sqlQuery.fields("Position").Value
            
            For j = 0 To UBound(loc_TrackNumber)
               If iTracNo = loc_TrackNumber(j) Then
                  mConnection.Execute "UPDATE Track SET Available=1, Path = '" & loc_FileList(j) & "' WHERE ID=" & iTrackID
                  iFoundCount = iFoundCount + 1
                  Exit For
               End If
            Next
            
            i = i + 1
            sqlQuery.MoveNext
         End If
            
      End If

   ElseIf UBound(loc_FileList) > 0 Then
      'Save files to chapters
      ReDim loc_TrackNumber(-1 To UBound(loc_FileList))
      For i = 0 To UBound(loc_FileList)
         loc_TrackNumber(i) = GetTrackNumber(fso.GetBaseName(loc_FileList(i)))
      Next
         
'''         For i = 1 To UBound(loc_IDLists(i))
''''''            loc_IDIndex = .Seeks(Triple2Long(Mid(loc_TrackIDs, i, 3)))
''''''            If loc_IDIndex >= 0 Then
''''''               iTracNo = val(.AbsoluteField(loc_IDIndex, "Position"))
''''''               For j = 0 To UBound(loc_TrackNumber)
''''''                  If iTracNo = loc_TrackNumber(j) Then
''''''                     .AbsoluteEdit(loc_IDIndex, .FieldToIndex("Path")) = loc_FileList(j)
''''''                     .AbsoluteEdit(loc_IDIndex, .FieldToIndex("Available")) = 1
''''''                     iFoundCount = iFoundCount + 1
''''''                     Exit For
''''''                  End If
''''''               Next
''''''            End If
'''         Next
      If iFoundCount > 0 Then
         mConnection.Execute "UPDATE Movie SET Available=1 WHERE ID=" & var_CurrentAlbumID
'''         With PV_TableMovie
'''            RecordIndex = .Seeks(var_CurrentAlbumID)
'''            If RecordIndex >= 0 Then
'''               .AbsoluteEdit(RecordIndex, .FieldToIndex("Available")) = 1
'''            End If
'''         End With
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
   ElseIf UBound(loc_FileList) = 0 Then
   
      If StrComp(fso.GetExtensionName(varPathValue), "ifo", vbTextCompare) = 0 Then
          ifOTrackCounts = GetChapterCountFromIFO(varPathValue, iMainTitle)
          If iTrackCounts <= 0 Then
            MsgBox "Incorrect chapter from this DVD"
            Exit Function
          End If
      End If
      '========================================================================================================
      If isFileExist(varPathValue) Then
         If sPlayFrom = "0" Then sPlayFrom = "Path"
         If sPlayFrom = "1" Then sPlayFrom = "PathMedium"
         If sPlayFrom = "2" Then sPlayFrom = "PathSmall"
         mConnection.Execute "UPDATE Movie SET Available=1, " & sPlayFrom & "='" & varPathValue & "' WHERE ID=" & var_CurrentAlbumID
         SaveAlbumDirectory = True
         RefreshAlbumAvailableToServer
      End If
   End If
   Exit Function
Error:
   Log.Writelog "SaveAlbumDirectory", "ERROR", Err.Description, Log.LogPara("var_CurrentAlbumID", var_CurrentAlbumID, "sPlayFrom", sPlayFrom, "varPathValue", varPathValue)
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


Public Sub RestoreFavorite(openPathName As String)
   'Should not use
   Log.Writelog "RestoreFavorite", "INFO", Err.Description, Log.LogPara("openPathName", openPathName)
End Sub
Public Sub BackupFavorite(savePathName As String)

   Log.Writelog "BackupFavorite", "INFO", Err.Description, Log.LogPara("savePathName", savePathName)

End Sub

Public Function GetLastUpdate()
   
Error:
   Log.Writelog "BackupFavorite", "INFO", Err.Description, ""
End Function


Public Function ArtistByGenreNletter(GenreID As Integer, Optional letter As String) As String
   On Error GoTo Error
''''   'edited 2005-08-09
''''   'Seng
''''   Dim i As Long
''''   Dim count As Integer
''''   Dim ArtistID As Long
''''
''''   Dim stringActors As String
''''   Dim stringActorsID As String
''''   Dim arrayActor() As String
''''   Dim loc_Available As Integer
''''   Dim loc_Flag As Integer
''''   Dim loc_GenreIDs As String
''''   Dim loc_ArtistName As String
''''   Dim loc_AlbumID As Long
''''   Dim j As Long
''''
''''   With PV_TableMovie
''''      stringActorsID = ";"
''''      For i = 0 To .RecordCount - 1
''''
''''         loc_GenreIDs = .AbsoluteField(i, "GenreIDs")
''''
''''         If IsValidGenre(GenreID, loc_GenreIDs) Then
''''               stringActors = .AbsoluteField(i, "ActorID")
''''               arrayActor = Split(stringActors, ";")
''''               For j = 1 To UBound(arrayActor) - 1
''''                  ArtistID = val(arrayActor(j))
''''                  If InStr(stringActorsID, ";" & ArtistID & ";") = 0 Then 'add to string list
''''                        If PV_TableActor.Seeks(ArtistID) >= 0 Then
''''                           loc_ArtistName = PV_TableActor.Field(1)
''''                           If IsCorrectStartLetter(letter, loc_ArtistName) Then
''''                              loc_AlbumID = .AbsoluteField(i, 0)
''''                              loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
''''                              If IsCDAvailable(loc_Available, mSelectAlbumType) Then
''''                                 ReDim Preserve var_Artist(count)
''''                                 var_Artist(count) = Array(ArtistID, loc_ArtistName, PV_TableActor.Field(2), PV_TableActor.Field("Favorite"), 0, PV_TableActor.Field("Rating"), 0)
''''                                 count = count + 1
''''                                 stringActorsID = stringActorsID & arrayActor(j) & ";"
''''                              End If
''''                           End If
''''                        End If
''''
''''                  End If
''''                  If bCancelBrowse Then Exit For
''''               Next
'''''            End If    'isvalidcdtype
''''         End If
''''         If bCancelBrowse Then Exit For
''''      Next
''''   End With
''''
''''
''''   bCancelBrowse = False
''''   If count > 0 Then
''''     QuickSort var_Artist, Array(1)
''''     ArtistByGenreNletter = GetNextArtist(0, count)
''''   Else
''''      ArtistByGenreNletter = ""
''''   End If

   Dim loc_Available As Integer
   Dim loc_Flag As Integer
   Dim loc_GenreIDs As String
   Dim loc_ArtistName As String
   Dim loc_AlbumID As Long
   Dim loc_ArtistID As Long
   Dim loc_ArtistUnicode As String
   Dim loc_Favorite As Long
   Dim loc_Rating As Long



   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim sqlTrack As cRecordset
   Dim mCondition As String
   
   Dim nCount As Long
   Dim nAlbumID As Long
   Dim nAvailable As Long
   Const mENletterSET = "abcdefghijklmnopqrstuvwxyz"


   If letter = "#" Then
      mCondition = "INSTR('" & mENletterSET & "',LOWER(SUBSTR(Actor.Name,1,1)))=0"
   ElseIf letter = "" Then
      mCondition = ""
   Else
      mCondition = "Actor.Name Like '" & letter & "*'"
   End If

   sQueryString = "SELECT DiSTINCT TrackArtist.ArtistID,Actor.Name,Actor.Unicode,Actor.Favorite,Actor.Rating" & _
                  " FROM Movie " & _
                  "INNER JOIN Title On Title.MovieID=Movie.ID " & _
                  "INNER JOIN Track On Track.ID=Title.TrackID " & _
                  "INNER JOIN TrackArtist ON TrackArtist.TrackID=Title.TrackID " & _
                  "INNER JOIN Actor ON Actor.ID=TrackArtist.ArtistID " & _
                   SQLJoinWhere(mCondition, IIf(GenreID <> 0, "GenreID=" & GenreID, ""), SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER By Actor.Name COLLATE NOCASE"
   
   
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)

   While Not sqlQuery.EOF
      loc_ArtistName = sqlQuery.fields("Name").Value
      loc_ArtistID = sqlQuery.fields("ArtistID").Value
      loc_ArtistUnicode = sqlQuery.fields("Unicode").Value
      loc_Favorite = sqlQuery.fields("Favorite").Value
      loc_Rating = sqlQuery.fields("Rating").Value
      ReDim Preserve var_Artist(nCount)
      var_Artist(nCount) = Array(loc_ArtistID, loc_ArtistName, loc_ArtistUnicode, loc_Favorite, 0, loc_Rating, 0)
      nCount = nCount + 1
      sqlQuery.MoveNext
   Wend



   If nCount > 0 Then
     ArtistByGenreNletter = GetNextArtist(0, nCount)
   Else
      ArtistByGenreNletter = ""
   End If



   Exit Function
Error:
   Log.Writelog "ArtistByGenreNletter", "ERROR", Err.Description, Log.LogPara("GenreID", GenreID, "letter", letter)
   Debug.Print sQueryString
End Function

Public Function AlbumByTVSeries(TVID As Long, SeasonNumber As Integer, Optional selectType As AlbumEnum = All, Optional CDType As CDTypeEnum = AllCD) As Long
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mTVID As Long
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mNumSeason As Integer
   Dim mCount As Integer
   
   
   
   Erase var_Album
   
   sQueryString = "SELECT Movie.ID, Movie.numSeason,Movie.Flag,Movie.Available " & _
                  " FROM Movie" & _
                   SQLJoinWhere("TVID=" & TVID, SQLMovieFlag(), SQLMovieAvailable(), SQLTVSeason(SeasonNumber)) & _
                  " ORDER BY TypeCDID" & ",Movie.Name"

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
  
   
   While Not sqlQuery.EOF
   

         mTVID = sqlQuery.fields("TVID").Value
         mNumSeason = sqlQuery.fields("numSeason").Value
         mAvailable = sqlQuery.fields("Available").Value
         mFlag = sqlQuery.fields("Flag").Value
         mAlbumID = sqlQuery.fields("ID").Value
         
'''
'''         loc_SeasonNumber = .AbsoluteField(i, loc_fieldSeasonNum)
'''         loc_Available = .AbsoluteField(i, loc_fieldAvailable)
'''         loc_Flag = FlagCDOrder(.AbsoluteField(i, loc_fieldFlag))
'''         If loc_TVID = TVID And (SeasonNumber = loc_SeasonNumber Or SeasonNumber = 0) Then
'''            If IsCDAvailable(loc_Available, selectType) And IsValidCDType(loc_Flag, CDType) Then
               ReDim Preserve var_Album(mCount)
               var_Album(mCount) = GetAlbumInfosByID(mAlbumID, mAvailable, 0, False, mFlag)
               mCount = mCount + 1
'''            End If
'''         End If
'''      Next
      sqlQuery.MoveNext
   Wend
   AlbumByTVSeries = mCount
   Exit Function
Error:
   Log.Writelog "AlbumByTVSeries", "ERROR", Err.Description, Log.LogPara("TVID", TVID, "SeasonNumber", SeasonNumber, "selectType", selectType, "CDType", CDType)
End Function


Public Function AlbumByGenre(ByVal GenreID As Integer, letter As String, Optional ByVal selectType As AlbumEnum = All, Optional ByVal CDType As CDTypeEnum = AllCD, Optional ByVal ArrangeBy As SortEnum) As Long
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mAlbumName As String
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mCount As Integer
   
   
   
   
   sQueryString = "SELECT DISTINCT Movie.ID, Movie.Name, Movie.Flag, Movie.Available " & _
                  " FROM Movie" & _
                  " INNER JOIN Title On Title.MovieID=Movie.ID " & _
                  " INNER JOIN Track On Track.ID=Title.TrackID " & _
                   SQLJoinWhere("GenreID=" & GenreID, SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ",Movie.Year", "") & ",Movie.Name"

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
     
   
   

'''
   Erase var_Album
   While Not sqlQuery.EOF
         mAvailable = sqlQuery.fields("Available").Value
         mFlag = sqlQuery.fields("Flag").Value
         mAlbumID = sqlQuery.fields("ID").Value
         mAlbumName = sqlQuery.fields("Name").Value
      
      If letter = "All" Then letter = ""
         
'''         If InStr(1, loc_GenreIDs, ";" & GenreID & ";", vbTextCompare) > 0 Then
'''            loc_AlbumName = .AbsoluteField(i, loc_FieldName)
            If IsCorrectStartLetter(letter, mAlbumName) Then
'''               loc_Available = getAlbumAvailable(prv_Country, loc_AlbumID)
               ReDim Preserve var_Album(mCount)
               var_Album(mCount) = GetAlbumInfosByID(mAlbumID, mAvailable, 0, ArrangeBy = stDate, mFlag)
               mCount = mCount + 1
            End If
   Wend
            
   AlbumByGenre = mCount
   Exit Function
Error:
   Log.Writelog "AlbumByGenre", "ERROR", Err.Description, Log.LogPara("GenreID", GenreID, "letter", letter, "selectType", selectType, "CDType", CDType, "ArrangeBy", ArrangeBy)
End Function


Public Function AlbumByReleaseDate(MyFavorite As Boolean, Optional years As Integer = 0, Optional SortedType As Integer) As Integer
   On Error GoTo Error
   'browse album
   'Years=0 mean all

   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mAlbumName As String
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mCount As Integer
   
   sQueryString = "Movie.ID, Movie.Name, Movie.Flag, Movie.Available,CAST(strftime('%Y', Year) as int) as Years " & _
                  " FROM Movie" & _
                   SQLJoinWhere(SQLMovieYears(years), SQLMovieFavorite(MyFavorite), SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(SortedType = 0, ",Years", "") & ",Movie.Name"

   Set sqlQuery = mConnection.OpenRecordset(sQueryString)

   Erase var_Album
   While Not sqlQuery.EOF
      mAvailable = sqlQuery.fields("Available").Value
      mFlag = sqlQuery.fields("Flag").Value
      mAlbumID = sqlQuery.fields("ID").Value
      mAlbumName = sqlQuery.fields("Name").Value
'''      varAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
      ReDim Preserve var_Album(mCount)
      var_Album(mCount) = GetAlbumInfosByID(mAlbumID, mAvailable, 0, True, mFlag)
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   
   AlbumByReleaseDate = mCount
   'browse the same country with album release date
   Exit Function
Error:
   Log.Writelog "AlbumByReleaseDate", "ERROR", Err.Description, Log.LogPara("MyFavorite", MyFavorite, "years", years, "SortedType", SortedType)
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
   
   
   
 
''''   Dim i As Long
''''   Dim singerID As Long
''''   Dim albumID As Long
''''
''''   Dim fieldUnicodeName As Integer
''''   Dim fieldYear As Integer
''''   Dim fieldFavorite As Integer
''''   Dim fieldRating As Integer
''''   Dim fieldAvailable As Integer
''''   Dim fieldRank As Integer
''''   Dim count As Integer
''''   Dim fields As Variant
''''   Dim fieldFlag As Integer
''''
''''   Dim boolSelectMyFavorite As Boolean
''''   Dim boolSelectAvailable As Boolean
''''   Dim intAvailable As Integer
''''   Dim mainSortIndex As Integer
''''   Dim loc_Flag As Integer
''''   Dim COLAvailable As Collection
''''   'SetFolder
''''   mainSortIndex = 3 + TopType 'for choosing the sort type
''''   With PV_TableMovie
''''         If .RecordCount = 0 Then Exit Function
''''         Set COLAvailable = LoadAvailableToCollection(prv_Country)                '2007-01-11 Seng Increase Browsing Speed
''''
''''         'fieldSinger = .FieldToIndex("Label")
''''         fieldUnicodeName = .FieldToIndex("LabelUnicode")
''''         fieldYear = .FieldToIndex("Year")
''''         fieldFavorite = .FieldToIndex("Favorite")
''''         fieldRating = .FieldToIndex("Rating")
''''         fieldAvailable = .FieldToIndex("Available")
''''         fieldRank = .FieldToIndex("Rank")
''''         fieldGroupCDType = .FieldToIndex("TypeCDID")
''''         fieldFlag = .FieldToIndex("Flag")
''''
''''         For i = 0 To .RecordCount - 1
''''             currentGroupCDType = .AbsoluteField(i, fieldGroupCDType)
''''             'intAvailable = .AbsoluteField(i, fieldAvailable)
''''
''''             albumID = .AbsoluteField(i, 0)
''''             If IsKeyExist(COLAvailable, "ID" & albumID) Then                     '2007-01-11 Seng Increase Browsing Speed
''''               intAvailable = getAlbumAvailable(prv_Country, albumID)
''''             Else                                                                '2007-01-11 Seng Increase Browsing Speed
''''               intAvailable = 0                                                  '2007-01-11 Seng Increase Browsing Speed
''''             End If                                                              '2007-01-11 Seng Increase Browsing Speed
''''             boolSelectMyFavorite = (.AbsoluteField(i, fieldFavorite) = 1)
''''            boolSelectAvailable = IsCDAvailable(intAvailable, mSelectAlbumType)
''''
''''            If selectFromList Then
''''              If getItemFromID(collectionSelectList, albumID) <> "" Then
''''                 boolSelectAvailable = True
''''              End If
''''            End If
''''             If ((selectFavoriteAlbum And boolSelectMyFavorite And boolSelectAvailable) Or ((selectFavoriteAlbum = False) And (intAvailable <> 0))) And isValidGroupType(currentGroupCDType) Then
''''               fields = .fields(i)
''''               loc_Flag = FlagCDOrder(fields(fieldFlag))
''''               ReDim Preserve var_Album(count)
''''
''''               var_Album(count) = GetAlbumInfos(i, intAvailable, 5 - fields(fieldRating), True, loc_Flag)      'modified 2005-08-23 /seng
''''               count = count + 1
''''            End If
''''         Next
''''   End With
''''   ' Artist ===>> CDType ===>> Others
''''   Dim SortArray As Variant
''''   'Modified by seng    '11
''''   'Sort type >>>Artist>>>Sort Index
''''   SortArray = ReturnSortArray(5, mSelectGroupCDType <> -1, mainSortIndex, True, 1, mainSortIndex <> 1)
''''   If count > 0 Then QuickSort var_Album, SortArray
   
   GetTopAlbum = 0
   Exit Function
Error:
   Log.Writelog "GetTopAlbum", "ERROR", Err.Description, Log.LogPara("TopType", TopType, "selectFavoriteAlbum", selectFavoriteAlbum, "selectFromList", selectFromList)
End Function


Public Function AlbumByRating(Rating As Integer, Optional letter As String, Optional selectType As AlbumEnum = All, Optional ArrangeBy As SortEnum = stName, Optional CDType As AlbumEnum = AllCD) As String
   On Error GoTo Error
'''   'browse album              'Last update by Seng 2005-07-26
'''   Dim i As Long
'''   Dim fieldDate As Integer, fieldAvailable As Integer
'''   Dim stringArtist As String
'''   Dim count As Integer
'''   Dim groupArtist As String
'''   Dim SortKey As Integer
'''   Dim dataAvailable As Integer
'''   Dim AlbumArtistID As Integer
'''   Dim fieldUnicodeName As Integer
'''   Dim fieldArtistID As Integer
'''   Dim fieldLabelID As Integer
'''   Dim fieldRating As Integer
'''   Dim fieldFavorite As Integer
'''   Dim loc_Flag As Integer
'''   Dim loc_AlbumID As Long
'''   Dim stringAlbumName As String
'''   Dim stringDate As String
'''   Dim intRating As Integer
'''
'''   Erase var_Album
'''   With PV_TableMovie
'''      fieldDate = .FieldToIndex("Year")
'''      fieldAvailable = .FieldToIndex("Available")
'''      fieldUnicodeName = .FieldToIndex("Unicode")
'''      fieldLabelID = .FieldToIndex("LabelID")
'''      fieldRating = .FieldToIndex("Rating")
'''      fieldFavorite = .FieldToIndex("Favorite")
'''      fieldGroupCDType = .FieldToIndex("TypeCDID")
'''
'''      For i = 0 To .RecordCount - 1
'''         intRating = .AbsoluteField(i, fieldRating)
'''         If intRating = Rating Then
'''            loc_AlbumID = .AbsoluteField(i, 0)
'''            dataAvailable = getAlbumAvailable(prv_Country, loc_AlbumID)
'''            If IsCDAvailable(dataAvailable, selectType) Then
'''               stringAlbumName = .AbsoluteField(i, 1)
'''               If IsCorrectStartLetter(letter, stringAlbumName) Then
'''                  currentGroupCDType = TypeCDOrder(.AbsoluteField(i, fieldGroupCDType))
'''                  loc_Flag = FlagCDOrder(.AbsoluteField(i, "Flag"))
'''                  If IsValidCDType(loc_Flag, CDType) And isValidGroupType(currentGroupCDType) Then
'''                     ReDim Preserve var_Album(count)
'''                     SortKey = 0
'''                     Dim artistgroup As String
'''
'''                     artistgroup = .AbsoluteField(i, "Singer")
'''                     stringDate = .AbsoluteField(i, fieldDate)
'''                     var_Album(count) = GetAlbumInfos(i, dataAvailable, SortKey, False, loc_Flag)
'''                     count = count + 1
'''                  End If
'''               End If
'''            End If
'''         End If
'''      Next
'''   End With
'''   Dim sortIndices As Variant, reverse As Boolean
'''   sortIndices = ReturnSortArray(3, True, 11, True, 1, ArrangeBy = stName, 4, ArrangeBy = stDate)
'''   If count > 0 Then QuickSort var_Album, sortIndices, False
   AlbumByRating = 0
   Exit Function
Error:
   Log.Writelog "AlbumByRating", "ERROR", Err.Description, Log.LogPara("letter", letter, "selectType", selectType, "ArrangeBy", ArrangeBy, "CDType", CDType)
End Function

Public Property Get databaseType() As Integer
   databaseType = mDatabaseType
End Property

Public Function SearchAlbum(ByVal albumName As String, Unicode As Boolean, selectType As AlbumEnum, Optional ArrangeBy As SortEnum = stNone, Optional Favorite As AlbumEnum = All) As Integer
   On Error GoTo Error
'''   Dim stringAvailable As String, i As Long, sortIndices As Variant
'''   Dim stringSearch As String
'''   Dim stringFavorite As String
'''   Dim count As Integer
'''   Dim Increase As Integer
'''   Dim currentTypeCDID As Integer
'''   Dim searchCount As Long
'''
'''   Dim initAvailable As Integer
'''   Dim loc_Flag As Integer
'''   Dim stringAlbumName As String
'''   Dim lngALbumID As Long
'''   Dim iTextCompare As VbCompareMethod
'''
'''
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mAlbumName As String
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mCount As Integer
   Dim mSearchField As String
   
   
'''   boolLanguageKhmer = InStr(1, prv_Country, "khmer", vbTextCompare) > 0
   If InStr(1, GetLastLanguage, "english", vbTextCompare) > 0 Then Unicode = False
   
   Erase var_SearchAlbum
   

   If Unicode Then mSearchField = "Unicode" Else mSearchField = "Name"
   sQueryString = "Movie.ID, Movie.Name, Movie.Flag, Movie.Available,CAST(strftime('%Y', Year) as int) as Years " & _
                  " FROM Movie" & _
                   SQLJoinWhere(mSearchField & " Like '%" & albumName & "%'", SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER BY TypeCDID" & IIf(ArrangeBy = stDate, ",Year", "") & ",Movie.Name"
   
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   
   While Not sqlQuery.EOF
      mAvailable = sqlQuery.fields("Available").Value
      mFlag = sqlQuery.fields("Flag").Value
      mAlbumID = sqlQuery.fields("ID").Value
      mAlbumName = sqlQuery.fields("Name").Value
      
      ReDim Preserve var_SearchAlbum(mCount)
      var_SearchAlbum(mCount) = GetAlbumInfosByID(mAlbumID, mAvailable, 0, False, mFlag)
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   

   SearchAlbum = mCount
   Exit Function
Error:
   Log.Writelog "SearchAlbum", "ERROR", Err.Description, Log.LogPara("albumName", albumName, "unicode", Unicode, "selectType", selectType, "ArrangeBy", ArrangeBy, "Favorite", Favorite)
End Function


Public Function searchDirector(searchDirectorName As String) As Long
   On Error GoTo Error
   '2005-08-2005 Seng
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mID As Long
   Dim mName As String

   Dim mCount As Integer
   
   
   sQueryString = "ID, Name, Unicode " & _
                  " FROM Director" & _
                  " WHERE Name Like '%" & searchDirectorName & "%'" & _
                  " ORDER BY Name"
   
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   Erase var_Director
   
   While Not sqlQuery.EOF
      mID = sqlQuery.fields("ID").Value
      mName = sqlQuery.fields("Name").Value
      ReDim Preserve var_Director(mCount)
      var_Director(mCount) = Array(mID, mName, "", "", "", "", "")
      
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   
   searchDirector = mCount
   Exit Function
Error:
   Log.Writelog "searchDirector", "ERROR", Err.Description, Log.LogPara("searchDirectorName", searchDirectorName)
End Function

Public Function searchTrack(SearchChapterName As String, Optional ProductionID As Long, Optional MoodID As Long, Optional DanceStyleID As Long, Optional GenreID As Long, Optional Rating As Integer, Optional Available As Integer, Optional boolUnicode As Boolean, Optional sortType As Boolean, Optional SingerID As Integer, Optional SingType As Integer = -2, Optional startLetter As Boolean) As Long
   On Error GoTo Error
'''   Dim searchCount As Long
'''   Dim max As Long
'''   Dim boolFound As Boolean
'''   Dim currentStringList As String
'''   Dim boolNewSearch As Boolean
'''   Dim i As Long
'''   Dim MovieID As Long
'''   Dim TrackName As String
'''   Dim fieldTrackName As Integer
'''   Dim fieldMovieID As Integer
'''   Dim movieIndex As Long
'''   Dim iTextCompare As VbCompareMethod
'''   Dim bLanguageKhmer As Boolean
'''   'SingType=0 Girl;SingType=1 Boy;SingType=2 Both
'''   Dim LabelID As Long
'''   Dim albumName As String
'''   Dim albumYear As String
'''   Dim albumUnicode As String
'''   Dim ChapterName As String
'''   Dim ChapterUnicode As String
'''   Dim LabelName As String
'''   Dim LabelUnicode As String
'''   Dim trackRating As Integer
'''   Dim trackArtists() As String
'''   Dim TrackID As Long
'''   Dim FlagID As Integer
'''   Dim trackAvailable As Integer
'''   Dim TrackPosition As Integer
'''   Dim seekOffset As Integer
'''   Dim loc_AlbumID As Long
'''   Dim int_Available As Integer
'''   Dim SingerIDs As String
'''   Dim trackSingType As Integer
'''   Dim RetTrackIDs As String
'''
'''   Static boolSearching As Boolean
'''
'''   max = 12
'''   boolSearching = True
'''   boolExitLoop = False
'''   'StartLetter = True
'''   'boolNewSearch = (stringSearch <> "")
'''
'''   With PV_TableMovie
'''      If boolUnicode Then
'''         fieldTrackName = PV_TableTrack.FieldToIndex("Unicode")
'''         iTextCompare = vbBinaryCompare
'''      Else
'''         fieldTrackName = PV_TableTrack.FieldToIndex("Name")
'''         iTextCompare = vbTextCompare
'''      End If
'''      bLanguageKhmer = InStr(1, prv_Country, "khmer", vbTextCompare) > 0
'''
'''      fieldMovieID = PV_TableTrack.FieldToIndex("MovieID")
'''      For i = 0 To PV_TableTrack.RecordCount - 1
'''         boolFound = False
'''         TrackName = PV_TableTrack.AbsoluteField(i, fieldTrackName)
'''         TrackID = PV_TableTrack.AbsoluteField(i, 0)
'''         DoEvents
'''
'''         'CompareStartLetter
'''         If SearchChapterName = "" Then
'''            boolFound = True
'''         Else
'''            If startLetter Then
'''               boolFound = CompareStartLetter(TrackName, SearchChapterName, prv_Country, boolUnicode)
'''            Else
'''               boolFound = InStr(1, TrackName, SearchChapterName, iTextCompare) > 0
'''            End If
'''         End If

'''         If boolFound Then             ' Found the track is available
'''            MovieID = PV_TableTrack.AbsoluteField(i, fieldMovieID)
'''            movieIndex = .Seeks(MovieID)
'''
'''            If movieIndex >= 0 Then

'''               If ProductionID > 0 Then
'''                  boolFound = .AbsoluteField(movieIndex, "LabelID") = ProductionID
'''               End If
'''               If Rating > 0 Then
'''                  boolFound = boolFound And PV_TableTrack.AbsoluteField(i, "Rating") = Rating
'''               End If
'''               If GenreID > 0 Then
'''                  boolFound = boolFound And InStr(1, .AbsoluteField(movieIndex, "GenreIDs"), ";" & GenreID & ";", vbTextCompare) > 0
'''               End If
'''               If singerID > 0 Then
'''                  SingerIDs = PV_TableTrack.AbsoluteField(i, "SingerIDs")
'''                  boolFound = boolFound And InStr(1, SingerIDs, ";" & singerID & ";", vbTextCompare) > 0
'''               End If
'''               If SingType <> -2 Then
'''                  boolFound = boolFound And (PV_TableTrack.AbsoluteField(i, "SingType") = SingType)
'''               End If
'''               If boolFound Then
'''                  loc_AlbumID = .AbsoluteField(movieIndex, 0)
'''                  int_Available = getAlbumAvailable(prv_Country, loc_AlbumID, RetTrackIDs)
'''                  If RetTrackIDs <> "" And int_Available <> 0 Then
'''                     If RetTrackIDs <> "-1" Then
'''                        If InStr(1, RetTrackIDs, ";" & TrackID & ";") = 0 Then
'''                           int_Available = 0
'''                        End If
'''                     End If
'''                  End If
'''                  RetTrackIDs = ""
'''                  If IsCDAvailable(int_Available, CInt(Available)) Then
'''                     LabelID = .AbsoluteField(movieIndex, "LabelID")
'''                     albumName = .AbsoluteField(movieIndex, "Name")
'''                     albumUnicode = .AbsoluteField(movieIndex, "Unicode")
'''                     ChapterName = PV_TableTrack.AbsoluteField(i, "Name")
'''                     ChapterUnicode = PV_TableTrack.AbsoluteField(i, "Unicode")
'''                     LabelName = .AbsoluteField(movieIndex, "Label")
'''                     LabelUnicode = .AbsoluteField(movieIndex, "LabelUnicode")
'''                     trackRating = PV_TableTrack.AbsoluteField(i, "Rating")
'''                     FlagID = FlagCDOrder(.AbsoluteField(movieIndex, "Flag"))
'''                     albumYear = ChangeDate(.AbsoluteField(movieIndex, "Year"))
'''                     trackAvailable = .AbsoluteField(movieIndex, "Available")
'''                     TrackPosition = PV_TableTrack.AbsoluteField(i, "Position")
'''                     trackSingType = PV_TableTrack.AbsoluteField(i, "SingType")
'''                     seekOffset = PV_TableTrack.AbsoluteField(i, "seekOffset")
'''                     trackArtists = Split(GetActorName(PV_TableTrack.AbsoluteField(i, "SingerIDs"), True), "%%")
'''                     ReDim Preserve var_SearchTrack(searchCount)
'''                     var_SearchTrack(searchCount) = Array(LabelID, albumName, albumUnicode, ChapterName, ChapterUnicode, LabelName, LabelUnicode, "", "", "", "", trackRating, trackArtists(0), trackArtists(1), TrackID, 0, FlagID, MovieID, "", albumYear, 0, trackAvailable, "", TrackPosition, trackSingType, seekOffset)
'''                                                            ' 0      1              2              3           4              5           6        7   8   9  10        11         12                 13             14    15  16       17     18    19       20         21       22      23            24        25
'''                     searchCount = searchCount + 1
'''                     sendVariable2Flash FrmMain.Swf(2), "TrackFound", searchCount
'''                     If searchCount > 200 Then
'''                        If (singerID = 0 And startLetter = False) Then Exit For        'Maximum to 200 tracks
'''                     End If
'''                  End If
'''               End If
'''
'''            End If
'''         End If
'''         ' boolExitLoop
'''         If boolExitLoop Then Exit For                'last line of for-next
'''      Next
'''   End With
'''   If searchCount > 0 Then QuickSort var_SearchTrack, ReturnSortArray(19, sortType, 3, boolUnicode = False, 4, boolUnicode = True)
'''   searchTrack = searchCount



   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mAlbumID As Long
   Dim mAlbumName As String
   Dim mAvailable As Integer
   Dim mFlag As Integer
   Dim mCount As Integer
   Dim mSearchField As String
   Dim mCondition As String
   
   
   
   Dim LabelID As Long
   Dim albumName As String
   Dim albumUnicode        As String
   Dim ChapterName    As String
   Dim ChapterUnicode      As String
   Dim LabelName       As String
   Dim LabelUnicode      As String
   Dim trackRating     As Integer
   Dim FlagID     As Integer
   Dim albumYear As Integer
   Dim trackAvailable As Integer
   Dim TrackPosition     As Integer
   Dim trackSingType As Integer
   Dim seekOffset     As Integer
   Dim ActorsName  As String
   Dim ActorsUnicode As String
   Dim TrackID As Long
   Dim MovieID As Long
   
   
   Erase var_SearchTrack
   
   
   If boolUnicode Then mSearchField = "Track.Unicode" Else mSearchField = "Track.Name"
   If ProductionID > 0 Then mCondition = mCondition & " AND Movie.LabelID=" & LabelID
   If Rating > 0 Then mCondition = mCondition & " AND Track.Rating=" & Rating
   If GenreID > 0 Then mCondition = mCondition & " AND Track.GenreID=" & GenreID
   If SingerID > 0 Then mCondition = mCondition & " AND Actor.ID=" & SingerID
   If SingType <> -2 Then mCondition = mCondition & " AND Track.SingType=" & SingType

   sQueryString = "SELECT Movie.LabelID, Track.Name as TrackName, Track.Unicode as TrackUnicode,  Movie.Name As MovieName, Movie.Unicode As MovieUnicode," & _
                  "Label.Name as LabelName, Label.Unicode as LabelUnicode, Track.Rating, group_concat( Actor.Name,' + ') As ActorsName, group_concat( Actor.Unicode, ' + ') As ActorsUnicode, " & _
                  "Track.ID As TrackID, Movie.Flag, Movie.ID As MovieID, Movie.Year, Movie.Available, Track.Position, Track.SingType, Track.SeekOffset " & _
                  "FROM Movie " & _
                  "INNER JOIN       Title ON Title.MovieID = Movie.ID " & _
                  "INNER JOIN       Track ON Track.ID = Title.TrackID " & _
                  "INNER JOIN       TrackArtist ON TrackArtist.TrackID = Title.TrackID " & _
                  "INNER JOIN       Actor ON Actor.ID = TrackArtist.ArtistID " & _
                  "INNER JOIN       Label ON Label.ID = Movie.LabelID " & _
                   SQLJoinWhere(IIf(SearchChapterName <> "", mSearchField & " LIKE '" & IIf(startLetter, "", "%") & SearchChapterName & "%'", ""), SQLMovieFlag(), SQLMovieAvailable()) & _
                  mCondition & _
                  " Group By Track.ID ORDER By " & mSearchField

     
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   
   
   Do While Not sqlQuery.EOF

         TrackID = sqlQuery.fields("TrackID").Value
         LabelID = sqlQuery.fields("LabelID").Value
         
         albumName = sqlQuery.fields("MovieName").Value
         albumUnicode = sqlQuery.fields("MovieUnicode").Value
         
         ChapterName = sqlQuery.fields("TrackName").Value
         ChapterUnicode = sqlQuery.fields("TrackUnicode").Value
         LabelName = sqlQuery.fields("LabelName").Value
         LabelUnicode = sqlQuery.fields("LabelUnicode").Value
                  
         trackRating = sqlQuery.fields("Rating").Value
         
         FlagID = sqlQuery.fields("Flag").Value
        
         albumYear = Year(sqlQuery.fields("Year").Value)
         
         trackAvailable = sqlQuery.fields("Available").Value
         TrackPosition = sqlQuery.fields("Position").Value
         trackSingType = sqlQuery.fields("SingType").Value
         seekOffset = sqlQuery.fields("SeekOffset").Value
         ActorsName = sqlQuery.fields("ActorsName").Value
         ActorsUnicode = sqlQuery.fields("ActorsUnicode").Value
         MovieID = sqlQuery.fields("MovieID").Value
         
'''         trackArtists = Split(GetActorName(PV_TableTrack.AbsoluteField(i, "SingerIDs"), True), "%%")
         ReDim Preserve var_SearchTrack(mCount)
         var_SearchTrack(mCount) = Array(LabelID, albumName, albumUnicode, ChapterName, ChapterUnicode, LabelName, LabelUnicode, "", "", "", "", trackRating, ActorsName, ActorsUnicode, TrackID, 0, FlagID, MovieID, "", albumYear, 0, trackAvailable, "", TrackPosition, trackSingType, seekOffset)
                                                ' 0      1              2              3           4              5           6        7   8   9  10        11         12                 13             14    15  16       17     18    19       20         21       22      23            24        25
         DoEvents
         mCount = mCount + 1
         sendVariable2Flash FrmMain.swf(2), "TrackFound", mCount
         If mCount > 200 Then
            If (SingerID = 0 And startLetter = False) Then Exit Do        'Maximum to 200 tracks
         End If
         sqlQuery.MoveNext
   Loop
   searchTrack = mCount

   Exit Function
Error:
   Log.Writelog "searchTrack", "ERROR", Err.Description, Log.LogPara("SearchChapterName", SearchChapterName, "ProductionID", ProductionID, "MoodID", MoodID, "DanceStyleID", DanceStyleID, "GenreID", GenreID, "Rating", Rating, "Available", Available, "boolUnicode", boolUnicode, "sortType", sortType, "singerID", SingerID, "SingType", SingType, "startLetter", startLetter)
End Function

Public Function SearchArtist(SearchString As String, Unicode As Boolean, Optional albumAvailable As AlbumEnum = All) As String
   On Error GoTo Error:
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mCount As Integer
   Dim mArtistID As Long
   Dim mArtistName As String
   Dim mArtistUnicode As String
   Dim mRating As Integer
   Dim mFavorite As Integer
   Dim mSearchField As String
   
 
   If InStr(1, GetLastLanguage, "english", vbTextCompare) > 0 Then Unicode = False
   If Unicode Then mSearchField = "Actor.Unicode" Else mSearchField = "Actor.Name"
   
   Erase var_SearchArtist
   
   sQueryString = "SELECT DISTINCT Actor.ID, Actor.Name, Actor.Unicode, Actor.Favorite, Actor.Rating " & _
                  "FROM Movie " & _
                  "INNER JOIN       Title ON Title.MovieID = Movie.ID " & _
                  "INNER JOIN       Track ON Track.ID = Title.TrackID " & _
                  "INNER JOIN       TrackArtist ON TrackArtist.TrackID = Title.TrackID " & _
                  "INNER JOIN       Actor ON Actor.ID = TrackArtist.ArtistID " & _
                   SQLJoinWhere(IIf(SearchString <> "", mSearchField & " Like '%" & SearchString & "%'", ""), SQLMovieFlag(), SQLMovieAvailable()) & _
                  " ORDER By Actor.Name"
   
   mCount = 0
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mArtistID = sqlQuery.fields("ID")
      mArtistName = sqlQuery.fields("Name")
      mArtistUnicode = sqlQuery.fields("Unicode")
      mFavorite = sqlQuery.fields("Favorite")
      mRating = sqlQuery.fields("Rating")
      ReDim Preserve var_SearchArtist(mCount)
      var_SearchArtist(mCount) = Array(mArtistID, mArtistName, mArtistUnicode, mFavorite, 0, mRating, 0)
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   
   SearchArtist = GetNextArtist(0, mCount, True)
   

   Exit Function
Error:
   Log.Writelog "SearchArtist", "ERROR", Err.Description, Log.LogPara("SearchString", SearchString, "unicode", Unicode, "albumAvailable", albumAvailable)
End Function

Public Function SearchArtistByIDs(IDStrings As String, Unicode As Boolean, Optional albumAvailable As AlbumEnum = All) As String
   On Error GoTo Error:
   
   
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   
   Dim mCount As Integer
   Dim mArtistID As Long
   Dim mArtistName As String
   Dim mArtistUnicode As String
   Dim mRating As Integer
   Dim mFavorite As Integer
   Dim mSearchIDs As String
   
   
   Erase var_SearchArtist
   mSearchIDs = Replace(Trim(Replace(IDStrings, ";", " ")), " ", ",")
   sQueryString = "SELECT DISTINCT Actor.ID, Actor.Name, Actor.Unicode, Actor.Favorite, Actor.Rating " & _
                  "FROM Actor " & _
                  " WHERE Acotr.ID IN (" & mSearchIDs & ") " & _
                  " ORDER By Actor.Name"
   
   mCount = 0
   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      mArtistID = sqlQuery.fields("ID")
      mArtistName = sqlQuery.fields("Name")
      mArtistUnicode = sqlQuery.fields("Unicode")
      mFavorite = sqlQuery.fields("Favorite")
      mRating = sqlQuery.fields("Rating")
      ReDim Preserve var_SearchArtist(mCount)
      var_SearchArtist(mCount) = Array(mArtistID, mArtistName, mArtistUnicode, mFavorite, 0, mRating, 0)
      mCount = mCount + 1
      sqlQuery.MoveNext
   Wend
   
   SearchArtistByIDs = GetNextArtist(0, mCount, True)
   Exit Function
Error:
   Log.Writelog "SearchArtistByIDs", "ERROR", Err.Description, Log.LogPara("IDStrings", IDStrings, "unicode", Unicode, "albumAvailable", albumAvailable)
   
   
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
   Log.Writelog "SearchAlbumByLabel", "ERROR", Err.Description, Log.LogPara("LabelName", LabelName, "selectType", selectType)
End Function
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
   
   Dim sQueryString As String
   Dim sqlString As String
   Dim sqlQuery As cRecordset
   Dim mLabelID As Long
   Dim mLabelName As String
   Dim mlabelUnicode As String
   Dim mMovieID As Long
   
   
'   <Productions>
'      <Production hinttags="\bRNM\b|\bReasmey Neak Meas\b" ID="1"></Production>
'   </Productions>
   
   
   filename = Dir(fso.BuildPath(lpScanfolder, "*.*"))
   While filename <> ""
      If (InStr(";mkv;m4v;mp4;", ";" & fso.GetExtensionName(filename) & ";") > 0) Then
         lpFiles.Add fso.BuildPath(lpScanfolder, filename)
      End If
      filename = Dir()
   Wend
   
   xmlFileName = fso.BuildPath(GetLastLanguage(), hinttageXML)
   
   
   sQueryString = "SELECT ID, Name, Unicode FROM Label ORDER BY Name"
   
   If Not fso.FileExists(xmlFileName) Then
      'hintag xml not found so create new template
      Set xmlRoot = XMLDOM.createElement("Productions")
      Set sqlQuery = mConnection.OpenRecordset(sQueryString)
      
      If sqlQuery.EOF Then
         'Writelog "ScanHintTag", "INFO", "Record found is 0", "Country = " & prv_Country & ", Directory= " & prv_Directory
         'MsgBox "Record count is 0"
         CallByName functionObj, funcName, VbMethod, "info", "Record count is 0"
         Exit Function
      Else
         While Not sqlQuery.EOF
            mLabelID = sqlQuery.fields("ID").Value
            mLabelName = sqlQuery.fields("Name").Value
            mlabelUnicode = sqlQuery.fields("Unicode").Value
            
            Set xmlnode = XMLDOM.createElement("Production")
            xmlnode.setAttribute "hinttags", "\b" & mLabelName & "\b"
            xmlnode.setAttribute "Name", mLabelName
            xmlnode.setAttribute "ID", mLabelID
            xmlRoot.appendChild xmlnode
            sqlQuery.MoveNext
         Wend
      End If
      XMLDOM.appendChild xmlRoot
      XMLDOM.Save xmlFileName
      Writelog "ScanHintTag", "INFO", "hintag xml not found so create new template", "Directory= " & GetLastLanguage & ", File Path= " & xmlFileName
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

''''                  Debug.Print "Production ID= " & Pro_ID & "; Name = " & Pro_Name & "; Album = " & AlbumVol
                  Set sqlQuery = mConnection.OpenRecordset("SELECT Movie.ID FROM Movie WHERE LabelID=" & Pro_ID & " AND Movie.Name Like '*" & AlbumVol & "*'")
                  If Not sqlQuery.EOF Then
                     mMovieID = sqlQuery.fields("ID").Value
'''                  If PV_TableMovie.FindFirst("LabelID=" & Pro_ID & "&Name=*" & AlbumVol & "*") Then
                     CallByName functionObj, funcName, VbMethod, "INFO", "File = " & lpFileName & " saved to database"
                     iFound = iFound + 1
                     mConnection.Execute "UPDATE Movie SET Available=1, Path='" & lpFileNamePath & "' WHERE Movie.ID=" & mMovieID
'''                     RecordIndex = PV_TableMovie.GetIndex
'''                     PV_TableMovie.AbsoluteEdit(RecordIndex, PV_TableMovie.FieldToIndex("Available")) = 1
'''                     PV_TableMovie.AbsoluteEdit(RecordIndex, PV_TableMovie.FieldToIndex("Path")) = lpFileNamePath
                     Exit For
                  Else
                  
                     'Writelog "ScanHintTag", "INFO", "Not Found album", "Production= " & pattern(i)(2) & " ;Hint tag= " & pattern(i)(1) & " ;File Name =" & lpFileNamePath & " ; Album =" & AlbumVol
                  End If
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

Public Function GetDatabseFields(sQuery As String) As Variant()
   On Error GoTo Error
   
   Dim sqlQuery As cRecordset
   Dim mReturn As Variant
   Dim i As Long
   
   
   Set sqlQuery = mConnection.OpenRecordset(sQuery)
   If Not sqlQuery.EOF Then
      ReDim mReturn(sqlQuery.fields.count - 1)
      For i = 0 To sqlQuery.fields.count - 1
         mReturn(i) = sqlQuery.fields(i).Value
      Next
   End If
   GetDatabseFields = mReturn
   
   Exit Function
Error:
   Log.Writelog "GetDatabseFields", "ERROR", Err.Description, Log.LogPara("sQuery", sQuery)

End Function

Public Function saveTrackDB(mLanguageID As Long, mAlbumID As Long, mTrackID As Long, mFileName As String) As Boolean
   On Error GoTo Error
   
      
   mConnection.Execute "UPDATE Movie SET Available=1 WHERE Movie.ID=" & mAlbumID
   mConnection.Execute "UPDATE Track SET Available=1, Path='" & mFileName & "' WHERE Track.ID=" & mTrackID
   saveTrackDB = True
   Exit Function
Error:
   Log.Writelog "saveTrackDB", "ERROR", Err.Description, Log.LogPara("mLanguageID", mLanguageID, "mAlbumID", mAlbumID, "mTrackID", mTrackID, "mFileName", mFileName)

End Function


Public Function findDownloadTrackAlbum(pAlbumID As Long) As Collection
   'Find for the track need to download from current album
   On Error GoTo Error
   
   Dim sQueryString As String
   Dim sqlQuery As cRecordset
   Dim mTracks As New Collection
   Dim mTrack As CTrack

   
   sQueryString = " SELECT Track.ID, Track.Name, Track.Unicode, Track.MovieID,Movie.Name As MovieName, Label.Name As LabelName FROM Track  " & _
                  " INNER JOIN Movie on Movie.ID = Track.MovieID" & _
                  " INNER JOIN Label on Movie.LabelID = Label.ID" & _
                  " WHERE Track.Available=0 and Movie.ID=" & pAlbumID


   Set sqlQuery = mConnection.OpenRecordset(sQueryString)
   While Not sqlQuery.EOF
      Set mTrack = New CTrack
      mTrack.ID = sqlQuery.fields("ID").Value
      mTrack.Title = sqlQuery.fields("Name").Value
      mTrack.Unicode = sqlQuery.fields("Unicode").Value
      mTrack.Album.ID = sqlQuery.fields("MovieID").Value
      mTrack.Album.Title = sqlQuery.fields("MovieName").Value
      mTrack.Album.Label.Title = sqlQuery.fields("LabelName").Value
      mTracks.Add mTrack
      sqlQuery.MoveNext
   Wend
   
   Set findDownloadTrackAlbum = mTracks
   Exit Function
Error:
   Log.Writelog "findDownloadTrackAlbum", "ERROR", Err.Description, Log.LogPara("pAlbumID", pAlbumID)

End Function
