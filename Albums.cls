VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Albums"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private CountryID As String
Private stringLanguage  As String
Public Function LoadAlbum(retClass As AlbumType, varAlbumID As Long, Optional oldID As Long) As Boolean
   
   Dim loc_TableMovie As New TableCls
   Dim loc_TableArtist As New TableCls
   Dim loc_TableTitle As New TableCls
   Dim loc_TableTrack As New TableCls
   Dim iSeekMovie As Long
   Dim bFound As Boolean
   Dim loc_AlbumID As Long
   Dim loc_CDDBID As String
   Dim loc_MainTitleID As Long
   Dim loc_TrackIDs As String
   Dim loc_TrackID As Long
   Dim loc_TrackName As String
   Dim loc_TrackPos As Integer
   Dim loc_SingerIDs As String
   Dim loc_SingerList() As String
   
   Dim i As Long, j As Long
   
   SetDirectory stringLanguage
   loc_TableMovie.Opens "Movie"
   loc_TableTitle.Opens "Title"
   loc_TableTrack.Opens "Track"
   With loc_TableMovie
      If varAlbumID <= 0 Then
         If retClass.CDDBDiskID <> "" Then
            iSeekMovie = -1
            bFound = .FindFirst("CDDBID=" & retClass.CDDBDiskID)
            If bFound Then
               iSeekMovie = .GetIndex
               loc_AlbumID = .Field(0)
            Else
               iSeekMovie = -1                  'Not found
            End If
         End If
      Else
         iSeekMovie = .Seeks(varAlbumID)
         If iSeekMovie > 0 Then
            .AbsoluteEdit(iSeekMovie, .FieldToIndex("CDDBID")) = retClass.CDDBDiskID
         End If
         loc_AlbumID = varAlbumID
      End If
      If iSeekMovie >= 0 Then
         loc_CDDBID = .Field("CDDBID")
         loc_MainTitleID = .Field("MainTitleID")
         retClass.albumID = loc_AlbumID
         retClass.AlbumArtist = .Field("Label")                         'Production
         retClass.Genre = "Pop"
         retClass.ALBUM = .Field("Name")
         retClass.CountryID = CountryID
         
         If loc_MainTitleID > 0 Then
            With loc_TableTitle
               If .Seeks(loc_MainTitleID) >= 0 Then
                  loc_TrackIDs = .Field("TrackIDs")
                  retClass.SetTrackCount Len(loc_TrackIDs) / 3
                  For i = 1 To Len(loc_TrackIDs) Step 3
                     loc_TrackID = Triple2Long(Mid(loc_TrackIDs, i, 3))
                     If loc_TableTrack.Seeks(loc_TrackID) >= 0 Then
                        loc_TrackName = loc_TableTrack.Field("Name")
                        loc_TrackPos = loc_TableTrack.Field("Position")
                        With retClass.Tracks(loc_TrackPos)
                           If loc_TrackName <> "" Then
                              .Title = loc_TrackName
                           End If
                           .TrackID = loc_TrackID
                           .ARTIST = "Unknown"
                        End With
                     End If
                  Next
               End If
            End With
            LoadAlbum = True
         End If
      End If
   End With
   loc_TableMovie.Closes
   loc_TableTitle.Closes
   loc_TableTrack.Closes
End Function
Public Function SaveAlbumTrackPath(info As AlbumType)
  Dim stringOldDatabasePath As String
  Dim i As Integer, strFullPathName As String, TRACK As listType
  Dim strNewPath As String, availableTrackCount As Integer
  Dim tblAlbum As New TableCls
  Dim tblTrack As New TableCls
  Dim fieldPath As Integer, fieldTrackAvailable As Integer
  Dim fieldAlbumAvailable As Integer
  Dim indexTrackFound As Long
  Dim indexAlbumFound As Long
  Dim destPath As String
  Dim FileTitle As String
  
  
  SetDirectory stringLanguage
  tblAlbum.Opens "Movie"
  tblTrack.Opens "Track"
  
  fieldPath = tblTrack.FieldToIndex("Path")
  fieldTrackAvailable = tblTrack.FieldToIndex("Available")
  fieldAlbumAvailable = tblAlbum.FieldToIndex("Available")
  
  For i = 1 To info.TrackCount
    Set TRACK = info.Tracks(i)
    FileTitle = GetDetailFileName(info.Tracks(i).Title, info.ALBUM, i, info.Tracks(i).ARTIST)
    strFullPathName = TRACK.path
    If strFullPathName <> "" Then
       strFullPathName = DirWMAFile(strFullPathName, FileTitle)
       
       If (TRACK.TrackID >= 0) And (strFullPathName <> "") Then
        indexTrackFound = tblTrack.Seeks(TRACK.TrackID)
        If indexTrackFound >= 0 Then
            availableTrackCount = availableTrackCount + 1
            'Edit Path
            tblTrack.AbsoluteEdit(indexTrackFound, fieldPath) = strFullPathName
            'Edit Track Available fieldTrackAvailable
            tblTrack.AbsoluteEdit(indexTrackFound, fieldTrackAvailable) = 1
        End If
   
       End If
   End If
  Next
   destPath = WMPSetting.CDRecordPath + "\" + info.AlbumArtist + "\" + info.ALBUM + "\folder.jpg"
   If (LCase(info.AlbumImagePath) <> LCase(destPath)) And (info.AlbumImagePath <> "") Then
     CopyFile info.AlbumImagePath, destPath, True
   End If
  
   If availableTrackCount > 0 Then
      indexAlbumFound = tblAlbum.Seeks(info.albumID)
      If indexAlbumFound >= 0 Then
        'Edit album Available
        tblAlbum.AbsoluteEdit(indexAlbumFound, fieldAlbumAvailable) = 1
      End If
   End If
   RefreshAlbumAvailableToServer
   tblTrack.Closes
   tblAlbum.Closes
End Function

'Public Function GetAlbumTitle(strSearch As String, intTracksCount As Integer, intID As Integer, objForm As Form) As String
Public Function GetAlbumTitle(strSearch As String, intTracksCount As Integer, intID As Long) As String
  Dim bFound As Boolean, i As Integer, strOnlyOne As String
  Dim AlbumTitle As String
  Dim tbl_Album As New TableCls, stringList As String
  Dim strPlus As String
  
  SetDirectory stringLanguage
  tbl_Album.Opens "Album"
  
  If intID <> 0 Then
    bFound = tbl_Album.Seeks(intID)
    strOnlyOne = tbl_Album.Field(1)
    GoTo SuccessLoad
  Else
    bFound = False
  End If
  If Not bFound Then
    bFound = tbl_Album.FindFirst("TrackCount=" & intTracksCount & "&Name=*" & strSearch & "*")
  End If
  
  While bFound
    If stringList = "" Then strPlus = "" Else strPlus = Delimiter
    stringList = stringList + strPlus + tbl_Album.Field(1) & de_Field & tbl_Album.Field(0)
    bFound = tbl_Album.FindNext()
    If i < 1 Then strOnlyOne = tbl_Album.Field(1)
    i = i + 1
  Wend
SuccessLoad:
    GetAlbumTitle = stringList
End Function

Private Sub Class_Initialize()
  SetDelimiter "&"
End Sub

Public Sub SetLanguage(ByVal Language As String)
  stringLanguage = get_country_path(Language) & "\Database"
  CountryID = Language
End Sub



