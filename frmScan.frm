VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "Flash9n.ocx"
Begin VB.Form frmScan 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SlyCDGuide - Scan Music Files"
   ClientHeight    =   4515
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6735
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4515
   ScaleWidth      =   6735
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4560
      Top             =   3840
   End
   Begin VB.Timer tmrExit 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4080
      Top             =   3840
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash swfScan 
      Height          =   4455
      Left            =   300
      TabIndex        =   0
      Top             =   0
      Width           =   6195
      _cx             =   10927
      _cy             =   7858
      FlashVars       =   ""
      Movie           =   " "
      Src             =   " "
      WMode           =   "Window"
      Play            =   "0"
      Loop            =   "0"
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
End
Attribute VB_Name = "frmScan"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
'strLblTitle sendlblTitle                 This for progress bar title
Dim Wmp As WMPLibCtl.WindowsMediaPlayer
Private Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" (ByVal lpFileName As String) As Long

 'Dim swfObject As ShockwaveFlash

'Dim musicfile() As MusicType

Dim pathString As String

Dim currentCountryPath As String
'Dim country() As Variant
Dim ScaningLanguageID As String

Dim boolScanning As Boolean               'test if it is scanning

'Constant for concate string together
Const array_Split = "^^"
Const field_Split = "&&"

'Variable for use with flash
Dim SearchPath As String
Dim ScanBy As Integer
'Dim ScanType As ScanEnum
Dim trackNumberType As TrackNumberEnum
Dim boolEditID3Tag As Boolean
Dim boolRename As Boolean
Dim boolAddAlbum As Boolean
Dim boolAddProduction As Boolean
Dim boolAddTrackNumber As Boolean
Dim intArtistFirst As Integer
Dim intTitleFirst As Integer
Dim boolArtist As Boolean
Dim boolTitle As Boolean


Dim listArray As String
'Variable for popup form
Dim fla_intSelectedIndex As Integer
Dim bout As Boolean

'Variable for receiving ready state from flash
Dim boolReady As Boolean
Dim tblAlbum As New TableCls
Dim tblTitle As New TableCls
Dim tblTrack As New TableCls
Dim tblActor As New TableCls

Private Function BrowseForPath() As String
   On Error GoTo ErrorNext
   Dim sh As New Shell, path As String
   path = sh.BrowseForFolder(hwnd, "Browse Folder", 0).Items.item.path
ErrorNext:
   BrowseForPath = path
End Function
Private Function GetFolderParentDirAndLastDir(ByVal lpFolder As String, lpParentDir As String, lpLastDir As String) As Boolean
   If lpFolder <> "" Then
      lpLastDir = fso.GetBaseName(lpFolder)
      lpParentDir = fso.GetBaseName(fso.GetParentFolderName(lpFolder))
      GetFolderParentDirAndLastDir = True
   Else
      lpLastDir = ""
      lpParentDir = ""
      GetFolderParentDirAndLastDir = False
   End If
End Function
Private Function GetAlbumVolume(filename As String) As Integer
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
   If loc_sNumber <> "" Then GetAlbumVolume = val(loc_sNumber) Else GetAlbumVolume = -1
End Function
Private Function GetMusicList(ByVal lpFolder As String) As Collection
   Dim i As Long
   Dim lpFileName As String
   Dim lpResult As New Collection
   Dim loc_FullPath As String
   Dim loc_Extension As String
   Dim loc_Track As listType
   
   
   lpFileName = Dir(lpFolder & "\*.*", vbNormal + vbHidden)
   While lpFileName <> ""
      loc_FullPath = lpFolder & "\" & lpFileName
      loc_Extension = LCase(fso.GetExtensionName(loc_FullPath))
      If loc_Extension = "wma" Or loc_Extension = "mp3" Or loc_Extension = "dat" Then
         Set loc_Track = New listType
         loc_Track.tracknumber = GetAlbumVolume(fso.GetBaseName(lpFileName))
         loc_Track.path = loc_FullPath
         lpResult.Add loc_Track
      End If
      lpFileName = Dir
   Wend
   Set GetMusicList = lpResult
End Function
Private Function GetTrackFolder(ByVal lpFolder As String) As Collection
   'ifo
   Dim i As Long
   Dim lpFileName As String
   Dim lpResult As New Collection
   Dim loc_FullPath As String
   Dim loc_Track As listType
   Dim loc_TrackNumber As Integer
   
   
   
   lpFileName = Dir(lpFolder & "\*", vbDirectory)
   While lpFileName <> ""
      loc_FullPath = lpFolder & "\" & lpFileName
      If lpFileName <> "." And lpFileName <> ".." And (GetAttr(loc_FullPath) And vbDirectory) = vbDirectory Then
         loc_TrackNumber = GetAlbumVolume(lpFileName)
         If loc_TrackNumber > 0 Then
            Set loc_Track = New listType
            loc_Track.tracknumber = loc_TrackNumber
            loc_Track.path = loc_FullPath & "\VIDEO_TS.IFO"
            lpResult.Add loc_Track
         End If
      End If
      lpFileName = Dir
   Wend
   Set GetTrackFolder = lpResult
End Function


Private Sub ScanWithPath(lpDatabasefolder As String, lpPath As String)
   Dim folders As New Collection
   Dim Tracks As Collection
  
   Dim sDatabaseFolder As String
   Dim sPath As String
   Dim sFullPath As String
   Dim sRoot As String
   Dim i As Integer, j As Long, k As Integer, l As Integer      'For finding track
   Dim ii As Integer
   Dim iLastSubFolder As Integer
   Dim iTrackNumber As Integer
   Dim iSearchTrackFound As Integer
   Dim iTrackCurrentAlbum As Integer
   Dim iTrackIndex As Long
   Dim sTrackPathName As String
   Dim bFoundAlbum As Boolean
   Dim iFileAttribute As Long
   
   SetVariableToFlash "strLblTitle", "sendlblTitle", "Scanning information"
   'sDatabaseFolder =  get_country_path(ScaningLanguageID) & "\Database"
   sDatabaseFolder = lpDatabasefolder & "\Database"
         
   folders.Add lpPath
   i = 1
   Do
      sRoot = folders.item(i)
      sPath = Dir(sRoot & "\*.*", vbDirectory)
      While sPath <> ""
         sFullPath = sRoot & "\" & sPath
         iFileAttribute = GetFileAttributes(sFullPath)
         If sPath <> "." And sPath <> ".." And ((iFileAttribute And vbDirectory) = vbDirectory) And iFileAttribute <> -1 Then
         'If sPath <> "." And sPath <> ".." And (GetAttr(sFullPath) And vbDirectory) = vbDirectory Then
            folders.Add sFullPath
         End If
         sPath = Dir
      Wend
      i = i + 1
   Loop Until i > folders.count
   'Get only 2 sub level
   Dim sLabel As String
   Dim sAlbum As String
   
   Dim indexLabel As Integer
   Dim indexAlbum As Integer
   Dim indexPath As Integer
   Dim indexPathMedium As Integer
   Dim indexPathSmall As Integer
   Dim indexAvai As Integer
   Dim indexSinger As Integer
   
   
   Dim loc_Label As String
   Dim loc_Album As String
   Dim loc_TrackNumber As Integer
   Dim loc_DirALbum As String
   Dim loc_TitleID As Long
   Dim loc_TrackID As Long
   Dim loc_ListTrackIDs As String
   Dim loc_SingerID As Long
   
   SetDirectory sDatabaseFolder
   
   tblAlbum.Opens "Movie"
   tblTitle.Opens "Title"
   tblTrack.Opens "Track"
   tblActor.Opens "Actor"
   
   indexLabel = tblAlbum.FieldToIndex("Label")
   indexAlbum = tblAlbum.FieldToIndex("Name")
   indexPath = tblAlbum.FieldToIndex("Path")                      'Large link
   indexPathMedium = tblAlbum.FieldToIndex("PathMedium")
   indexPathSmall = tblAlbum.FieldToIndex("PathSmall")
   indexSinger = tblAlbum.FieldToIndex("AlbumArtistID")
   indexAvai = tblAlbum.FieldToIndex("Available")
   'Scan by production
   
   For j = 0 To tblAlbum.RecordCount - 1
      SetVariableToFlash "strScanning", "sendScanning", CStr(((j + 1) / tblAlbum.RecordCount) * 100)
      
      loc_Album = tblAlbum.AbsoluteField(j, indexAlbum)
      loc_SingerID = tblAlbum.AbsoluteField(j, indexSinger)
      DoEvents
      'for
      bFoundAlbum = False
      For ii = 0 To 1
         If ii = 0 Then
            loc_Label = tblAlbum.AbsoluteField(j, indexLabel)
         ElseIf ii = 1 Then
            If loc_SingerID > 0 Then
               loc_Label = GetArtistAlbumName(loc_SingerID)
            Else
               Exit For
            End If
         End If
         If loc_Label <> "" Then
            For i = 1 To folders.count
               sFullPath = folders.item(i)
               'Debug.Print "Full path = " & sFullPath
               If GetFolderParentDirAndLastDir(sFullPath, sLabel, sAlbum) Then
                  If sAlbum <> "" Then
                     If StrComp(loc_Label, sLabel, vbTextCompare) = 0 And StrComp(loc_Album, sAlbum, vbTextCompare) = 0 Then               ' compare
                        If fso.FileExists(sFullPath & "\VIDEO_TS\VIDEO_TS.IFO") Then                         'if dvd files is exist
                           tblAlbum.AbsoluteEdit(j, indexPath) = sFullPath & "\VIDEO_TS\VIDEO_TS.IFO"
                           bFoundAlbum = True
                           tblAlbum.AbsoluteEdit(j, indexAvai) = 1
                           folders.Remove i
                           Exit For
                        Else  'Loop for finding track
                           loc_TitleID = tblAlbum.AbsoluteField(j, "MainTitleID")
                           iSearchTrackFound = 0
                           iTrackCurrentAlbum = 0
                           If tblTitle.Seeks(loc_TitleID) >= 0 Then
                              'loc_ListTrackIDs = Split(tblTitle.Field("TrackIDs"), ";")
                              loc_ListTrackIDs = tblTitle.Field("TrackIDs")
                              Set Tracks = GetMusicList(sFullPath)
                              If Tracks.count = 0 Then
                                 Set Tracks = GetTrackFolder(sFullPath)
                              End If
                              For k = 1 To Len(loc_ListTrackIDs) Step 3
                                 loc_TrackID = Triple2Long(mID(loc_ListTrackIDs, k, 3)) 'Val(loc_ListTrackIDs(k))
                                 If loc_TrackID > 0 Then
                                    iTrackCurrentAlbum = iTrackCurrentAlbum + 1
                                    iTrackIndex = tblTrack.Seeks(loc_TrackID)
                                    If iTrackIndex >= 0 Then
                                       loc_TrackNumber = tblTrack.AbsoluteField(iTrackIndex, "Position")
                                       If loc_TrackNumber > 0 Then
                                          For l = 1 To Tracks.count
                                             iTrackNumber = Tracks(l).tracknumber
                                             If iTrackNumber = loc_TrackNumber Then
                                                sTrackPathName = Tracks(l).path
                                                If fso.FileExists(sTrackPathName) Then
                                                   tblTrack.AbsoluteEdit(iTrackIndex, tblTrack.FieldToIndex("Path")) = sTrackPathName
                                                   tblTrack.AbsoluteEdit(iTrackIndex, tblTrack.FieldToIndex("Available")) = 1
                                                   iSearchTrackFound = iSearchTrackFound + 1
                                                   Exit For
                                                End If
                                             End If
                                          Next
                                       End If
                                    End If
                                 End If
                              Next
                              If iSearchTrackFound > 0 Then
                                 'if all tracks are found then update album available
                                 bFoundAlbum = True
                                 tblAlbum.AbsoluteEdit(j, indexAvai) = 1
                                 'Clear previous album available if track is available
                                 tblAlbum.AbsoluteEdit(j, indexPath) = ""
                                 tblAlbum.AbsoluteEdit(j, indexPathMedium) = ""
                                 tblAlbum.AbsoluteEdit(j, indexPathSmall) = ""
                              End If
                           End If
                           
                        End If
                     End If
                  End If
               End If
            Next
         End If   'loc_Label
      Next
   Next
Errors:
   tblAlbum.Closes
   tblTrack.Closes
   tblTitle.Closes
   tblActor.Closes
End Sub
Private Function GetFileTime(filename As String, ByRef returnDate As Date) As Boolean

    On Error GoTo Errors
        returnDate = FileDateTime(filename)
        GetFileTime = True
Errors:
    On Error GoTo 0
End Function

Sub ScanTime()
  On Error GoTo Errors:
  Dim lStrFolder As String, i As Long, j As Long
  Dim intFieldLength%, intFieldTrackPos%, intFieldTitle%
  Dim intFieldAlbum%, intFieldProduction%, intFieldPath%
  Dim intFieldAlbumID%, TrackID As Long
  Dim lIntMoreLikely As Integer, lIntDifferent As Integer, lIntIndex As Integer
  Dim intFieldLengthWMA As Integer
  
  Dim lStrPoduction As String, lStrAlbum As String, lIntTrackPos As Integer, lStrLengthWMA As String
  Dim strTrackTitle As String, lStrLength As String, lIntAlbumID As Integer
  
  Dim trackSearch As New TableCls
  Dim AlbumSearch As New TableCls

  Dim sourMusic As MusicProperty, DestMusic As MusicProperty
  Dim lBolFirstFound As Boolean, intTitleCount As Integer
  Dim strNewPathFile As String
  Dim intMatches As Integer, MoreMatches() As Integer, k As Integer
  Dim intSelectIndex As Integer, strOldFile As String
  Dim intRecordCount As Long, intFieldAvailable As Integer
  Dim intFieldAlbumAvailable As Integer
  Dim intAffected As Integer
  Dim percent As Integer
  
  
  lStrFolder = SearchPath
  trackSearch.Opens "Track"
  AlbumSearch.Opens "Album"

  intFieldPath = trackSearch.FieldToIndex("Path")
  intFieldAvailable = trackSearch.FieldToIndex("Available")
  intFieldAlbumAvailable = AlbumSearch.FieldToIndex("Available")
  
  
  
  If lStrFolder <> "" Then
    SetVariableToFlash "strLblTitle", "sendlblTitle", "Scanning files....."
    
    CompareMusicTime lStrFolder, Mp3List, Array("mp3", "wma"), trackNumberType, swfScan
'    SetVariableToFlash "strLblTitle", "sendlblTitle", "Scanning files....."
    SetVariableToFlash "strLblTitle", "sendlblTitle", "Scanning information"
   
    intFieldLength = trackSearch.FieldToIndex("Length")
    intFieldTrackPos = trackSearch.FieldToIndex("TrackPos")
    intFieldTitle = trackSearch.FieldToIndex("Name")
  '    intFieldProduction = trackTable.FieldToIndex("Production")  'Return Production.Name
    intFieldProduction = trackSearch.FieldToIndex("Artist")
    intFieldAlbum = trackSearch.FieldToIndex("Album")
    intFieldLengthWMA = trackSearch.FieldToIndex("LengthWMA")
    intFieldAlbumID = trackSearch.FieldToIndex("AlbumID")


    intRecordCount = trackSearch.RecordCount
'    lblDescription.Caption = "Scanning Folders..........."
    trackSearch.MoveFirst
    For j = 0 To intRecordCount - 1
      DoEvents
      percent = (j / (intRecordCount - 1)) * 100
'''''''''''''''''''      pgbPercent.value = (j / (intRecordCount - 1)) * 100

      SetVariableToFlash "strScanning", "sendScanning", CStr(percent)
      
'      SetVariableToFlash swfScan, "strScanning"
      lBolFirstFound = False: lIntMoreLikely = -1
      
      lStrPoduction = trackSearch.Field(intFieldProduction)
      lStrAlbum = trackSearch.Field(intFieldAlbum)
      lIntTrackPos = trackSearch.Field(intFieldTrackPos)
      lStrLength = trackSearch.Field(intFieldLength)
      strTrackTitle = trackSearch.Field(intFieldTitle)
      lStrLengthWMA = trackSearch.Field(intFieldLengthWMA)
      lIntAlbumID = trackSearch.Field(intFieldAlbumID)
'      trackTable.MoveNext
      
      If intArtistFirst > 0 Then sourMusic.ARTIST = lStrPoduction
      If intTitleFirst > 0 Then sourMusic.Title = lStrAlbum
      sourMusic.Length = lStrLength
      intMatches = 0
      lIntIndex = -1
      For i = 0 To UBound(Mp3List)
'        If i = 11 Then MsgBox ""
        With Mp3List(i)
          If .MusicType = WMAFile Then sourMusic.Length = lStrLengthWMA Else sourMusic.Length = lStrLength

          If intArtistFirst > 0 Then DestMusic.ARTIST = left(.Mp3Artist, intArtistFirst)
          If intTitleFirst > 0 Then DestMusic.Title = left(.Mp3Title, intTitleFirst)
          If .Mp3Track > 0 Then
            DestMusic.TRACK = .Mp3Track
            sourMusic.TRACK = lIntTrackPos
          Else
            sourMusic.TRACK = 0    'If there is no track do not compare it
          End If
          DestMusic.Length = .Mp3Length
'          DestMusic.FileName

        End With
        'Compare 2 musics property
'        Debug.Assert Len(sourMusic.Length) <> 8
'        If (InStr(strTrackTitle, "Svakum") > 0) And (Mp3List(i).Mp3Title = "Svakum") Then MsgBox "Hello"

        lIntDifferent = Mp3CompareType(sourMusic, DestMusic)
        If Not lBolFirstFound Then
          If lIntDifferent >= 0 Then
            ReDim MoreMatches(0)
            MoreMatches(0) = i
            lIntMoreLikely = lIntDifferent
            lIntIndex = i
            lBolFirstFound = True
          End If
        Else
'          If (lIntDifferent >= 0) And (lIntDifferent >= lIntMoreLikely) Then
          If (lIntDifferent >= 0) Then
            intMatches = intMatches + 1
            ReDim Preserve MoreMatches(intMatches)
            MoreMatches(intMatches) = i
            
            lIntMoreLikely = lIntDifferent
            lIntIndex = i
          End If
        End If
      Next i
      If intMatches > 0 Then                'There are many matches files
         'Work with new form from flash
'        With frmFile
          listArray = ""         'clear old value
'          .lstFile.Clear
          Dim bolChoosen As Boolean
          
'          .lblTitle = strTrackTitle          'Send title
          swfScan.SetVariable "strTitle", strTrackTitle
'          SetVariableToFlash swfScan, "strTitle", "sendCorrectPath", strTrackTitle
          
          fla_intSelectedIndex = -1
          For k = 0 To intMatches
            listArray = listArray & array_Split & Mp3List(MoreMatches(k)).Mp3PathName
'            .lstFile.AddItem Mp3List(MoreMatches(k)).Mp3PathName
            If Mp3List(MoreMatches(k)).bolChoosen Then
              bolChoosen = True
              lIntIndex = MoreMatches(k)
              Exit For
            End If
          Next k
          If Not bolChoosen Then
            listArray = mID(listArray, 3)
            SetVariableToFlash "strCorrectPath", "sendCorrectPath", listArray
            WaitForReady
'            .Show vbModal
'            If .intIndex < 0 Then lIntMoreLikely = -1 Else lIntIndex = MoreMatches(.intIndex)
            If fla_intSelectedIndex < 0 Then lIntMoreLikely = -1 Else lIntIndex = MoreMatches(fla_intSelectedIndex)
          End If
'        End With
      End If
      If lIntMoreLikely >= 0 Then
        Dim curMp3 As Mp3FileType
        
'        curMp3 = Mp3List(lIntIndex)
        With Mp3List(lIntIndex)
          Dim intTableIndex As Long, intTitlePos As Integer
          intTitleCount = UboundMp3SubType(.Title)
          intTitlePos = TitleExist(.Title, strTrackTitle)
          If intTitlePos < 0 Then
            intTitlePos = UboundMp3SubType(.Title()) + 1
            ReDim Preserve .Title(intTitlePos)
            ReDim Preserve .Title(intTitlePos).TableIndex(0)

            .Title(intTitlePos).TableIndex(0) = j
            .Title(intTitlePos).Name = strTrackTitle
            .Title(intTitlePos).Production = lStrPoduction
            .Title(intTitlePos).Album = lStrAlbum
            .Title(intTitlePos).albumID = lIntAlbumID
            .Title(intTitlePos).tracknumber = lIntTrackPos
            If intMatches > 0 Then .bolChoosen = True
          Else
            intTableIndex = UBound(.Title(intTitlePos).TableIndex()) + 1
            ReDim Preserve .Title(intTitlePos).TableIndex(intTableIndex)
            .Title(intTitlePos).TableIndex(intTableIndex) = j
          End If
        End With
      End If
      trackSearch.MoveNext
    Next j
    
    intRecordCount = UBound(Mp3List)
    For i = 0 To intRecordCount
      With Mp3List(i)

        intTitleCount = UboundMp3SubType(.Title)
        listArray = ""
        fla_intSelectedIndex = -1
        If intTitleCount > 0 Then       'One Files with many titles
          PlayFile .Mp3PathName
          For j = 0 To intTitleCount
            listArray = listArray & array_Split & .Title(j).Name
          Next
          listArray = mID(listArray, 3)
          SetVariableToFlash "strItem", "sendItem", listArray
          WaitForReady
          intSelectIndex = fla_intSelectedIndex
          
        ElseIf intTitleCount = 0 Then
          intSelectIndex = 0
        Else
          intSelectIndex = -1
        End If
        If intSelectIndex >= 0 Then
          strOldFile = .Mp3PathName
          If boolEditID3Tag Then
            Mp3.filename = strOldFile
            Mp3.Album = .Title(intSelectIndex).Album
            Mp3.ARTIST = .Title(intSelectIndex).Production
            Mp3.tracknumber = .Title(intSelectIndex).tracknumber
            Mp3.Title = .Title(intSelectIndex).Name
            Mp3.Update
          End If
          strTrackTitle = GetRenamedFile(.Title(intSelectIndex).Name, .Title(intSelectIndex).Production, boolAddProduction, .Title(intSelectIndex).Album, boolAddAlbum, .Title(intSelectIndex).tracknumber, boolAddTrackNumber)
          
          If boolRename Then
            strNewPathFile = ReplaceNewFileName(.Mp3PathName, strTrackTitle)
            Name strOldFile As strNewPathFile
          Else
            strNewPathFile = strOldFile
          End If
      
      'Update field Path
          Dim absoluteIndex As Long
          For j = 0 To UBound(.Title(intSelectIndex).TableIndex())
            intAffected = intAffected + 1
            absoluteIndex = .Title(intSelectIndex).TableIndex(j)
            'Track Path
            trackSearch.AbsoluteEdit(absoluteIndex, intFieldPath) = strNewPathFile
            TrackID = trackSearch.AbsoluteField(absoluteIndex, 0)
            'Track Available
            
            trackSearch.AbsoluteEdit(absoluteIndex, intFieldAvailable) = 1
'            .Title().trackind
            If AlbumSearch.Seeks(.Title(intSelectIndex).albumID) >= 0 Then
'             ' Album Available
              AlbumSearch.Field(intFieldAlbumAvailable) = 1            ' Album Available
            
              AlbumSearch.Update
            End If
            'myMusic.AddTrack TrackID, LanguageID
'            myMusic.AddTrack 55, 1
          Next j
        End If
      End With
      DoEvents
    Next i
  Else
    MsgBox "Please select a file"
  End If
  
Errors:
    trackSearch.Closes
    AlbumSearch.Closes
'  MsgBox intAffected & " files Affected"
'   SetVariableToFlash "none", "sendClose", "none"
'''''''''''''''''''''''  pgbPercent.value = 0
'''''''''''''''''''  fraTime.Enabled = True
End Sub
Private Function UboundMp3SubType(Arrays() As Mp3SubType) As Integer
  On Error GoTo Errors
  UboundMp3SubType = UBound(Arrays)
  Exit Function
Errors:
  UboundMp3SubType = -1
End Function

Private Sub LoadSetting()
  Dim xmlPath As String
  
  If ScreenType = "Normal" Then
    LoadSwf swfScan, App.path & "\sly\ScanNS.sly"
  ElseIf ScreenType = "wideScreen" Then
    LoadSwf swfScan, App.path & "\sly\ScanWS.sly"
  ElseIf ScreenType = "mediumWideScreen" Then
    LoadSwf swfScan, App.path & "\sly\ScanWSM.sly"
  ElseIf ScreenType = "mediumLargeWideScreen" Then
    LoadSwf swfScan, App.path & "\sly\ScanWSH.sly"
  ElseIf ScreenType = "smallWideScreen" Then
    LoadSwf swfScan, App.path & "\sly\ScanWSS.sly"
  ElseIf ScreenType = "largeWideScreen" Then
    LoadSwf swfScan, App.path & "\sly\ScanWSL.sly"
  End If
  swfScan.SetVariable "get_val_Theme", SplitColor
  swfScan.SetVariable "strSHTT", b_tooltip
  swfScan.SetVariable "openframe", "true"
  swfScan.SetVariable "getThemes", "true"
  swfScan.SetVariable "LanName", currentCountry
  
  swfScan.SetVariable "syn_volume", CStr(syn_vol)
  swfScan.SetVariable "syn_volume_change", CStr(change_vol)
  
   FrmMain.current_status swfScan
  
   SetDelimiter "&"
   xmlPath = App.path
   If xmlPath = "" Then
      MsgBox "No program installed"
      End
   End If
   'Debug.Print "Country list=" & GetCountryList
   SetVariableToFlash "strappPath", "sendappPath", App.path
   'SetVariableToFlash "strCountry", "sendCountry", GetCountryList & "\\//" & allPathCountries
   SetVariableToFlash "strCountry", "sendCountry", GetCountryList
  

End Sub

Public Sub showMe()

   If frmScan.Visible = False Then
      Dim oldPath As String
      oldPath = swfScan.Movie
      swfScan.Movie = "nothing"
      swfScan.Movie = oldPath
      SearchPath = ""

      'Set swfObject = swfScan
      'Show                   ' test
      LoadSetting
      ScaleScane
      If WinMode = "Window Mode" Then
         If IsRegistered = True Then
            frmScan.Caption = reged & " - Scan Music Files"
         Else
            frmScan.Caption = unReg & " - Scan Music Files"
         End If
      End If
   ElseIf frmScan.WindowState = vbMinimized Then
      If WinMode = "FullScreen Mode" Then
         frmScan.WindowState = 2
      Else
         frmScan.WindowState = 0
      End If
   End If
   'FrmMain.Visible = False
   Me.Visible = True          ' test
   swfScan.SetFocus
End Sub

Private Sub Form_Unload(Cancel As Integer)
   RefreshAlbumAvailableToServer
   Unload Me
End Sub

Private Sub swfScan_FSCommand(ByVal command As String, ByVal args As String)
'   Debug.Print "Command = " & command & "; args = " & args
   Select Case LCase(command)
      Case "popup"
          'popUp FrmMain.Wmp, True
          popUp True, True
      Case "seekbar"
        On Error Resume Next
        Wmp.Controls.currentPosition = (CLng(args) * Wmp.currentMedia.Duration) / 100
      Case "setslideshow"
            FrmMain.setSlideShows
            sendToFlash swfScan, "slideShow", CStr(b_slideshow)
      Case "cleartimeslideshow"
         interValCount = 0
      Case "visualization"
         'FrmMain.cmdFull_Click
         FrmMain.change_visualization_type
      Case "selectfolder"
         Dim hisSpl() As String
         Dim tmphispath As String
         hisSpl = Split(args, "%%")
         
         tmphispath = replacePath(App.path, hisSpl(3)) & "\Language.xml"
         
         EditXML tmphispath, 3, "Path", hisSpl(1)
         replaceHistoryPathScan tmphispath, CInt(hisSpl(0)), hisSpl(2)
         
      Case "sethidemouse"
        FrmMain.setHideMouse args
      Case "key"
         'FrmMain.PressKeyInternalPlayer args
         handleShortCutKey CLng(args)
      Case "changewindow"
            If WinMode = "FullScreen Mode" Then
                WinMode = "Window Mode"
            Else
                WinMode = "FullScreen Mode"
            End If
            MsgBox "fdsdfdsaf": ''FrmMain.setWindowStage Mode
      Case "offscreen"
          SetCursorPos ScreenX, ScreenY
      'Case "Minimize": frmScan.WindowState = 1
      Case "setting": FrmMain.swf_FSCommand IndexSwf, "ShowOption", ""
      Case "country": FrmMain.swf_FSCommand IndexSwf, "ShowCountry", ""
      Case "playlist": FrmMain.swf_FSCommand IndexSwf, "ShowPlayList", ""
      Case "search": FrmMain.swf_FSCommand IndexSwf, "ShowSearch", ""
      Case "back":
         
        FrmMain.swf(IndexSwf).SetFocus
        UnloadMe
      Case "rip cd": FrmMain.swf_FSCommand IndexSwf, "ShowRipCD", ""
      Case "minimize"
         Me.WindowState = vbMinimized
      Case "exit"
         UnloadMe
      Case "scanby":          ScanBy = args
      Case "filetype":        trackNumberType = args
      Case "artist":          boolArtist = args
      Case "title":           boolTitle = args
      Case "language":        ScaningLanguageID = args
      Case "edit":            boolEditID3Tag = args
      Case "rename":          boolRename = args
      Case "addproduct":      boolAddProduction = args
      Case "addalbum":        boolAddAlbum = args
      Case "addtrack":        boolAddTrackNumber = args
      Case "scancomplete"
        EditSetting MainSettingXML, 0, "ScanComplete", args
        SplitColor = ReplaceStrSpl(SplitColor, 25, args, "~")
        b_autoClose = args = "true"
      Case "removehistorypath"
         Dim docXmlr  As DOMDocument
         Dim eleXmlr As IXMLDOMElement
         Dim rPath As String
         rPath = replacePath(App.path, args) & "\Language.xml"
         Set docXmlr = New DOMDocument
         docXmlr.Load rPath
         Set eleXmlr = docXmlr.firstChild.childNodes(3)
         eleXmlr.setAttribute "Path", eleXmlr.childNodes(0).Text
         eleXmlr.removeChild docXmlr.firstChild.childNodes(3).childNodes(0)
         docXmlr.Save rPath
         Debug.Print
         SetVariableToFlash "strPath", "sendPath", True
         
      Case "browse"
        Dim tmpp As String
        Dim tmpp_array() As String
        tmpp_array = Split(args, "||")
        tmpp = BrowseForFolder(tmpp_array(0), hwnd)
        If tmpp <> "" Then
        
            Dim tmphispathLan As String
            tmphispathLan = get_country_path(ScaningLanguageID) & "\Language.xml"
            
            Dim docXmld  As DOMDocument
            Dim eleXmld As IXMLDOMElement
            Dim dpath As String
            Set docXmld = New DOMDocument
            docXmld.Load tmphispathLan
            Set eleXmld = docXmld.firstChild.childNodes(3)
            dpath = eleXmld.getAttribute("Path")
            
            EditXML tmphispathLan, 3, "Path", tmpp
            
            Dim docXmln  As DOMDocument
            Dim eleXmlnPath As IXMLDOMElement
            Dim eleXmln As IXMLDOMElement
            Set docXmln = New DOMDocument
            docXmln.Load tmphispathLan
            Set eleXmlnPath = docXmln.firstChild.childNodes(3)
            Set eleXmln = docXmln.createElement("Path")
            eleXmln.Text = dpath
            eleXmlnPath.appendChild eleXmln
            docXmln.Save tmphispathLan
            
            SetVariableToFlash "strPath", "sendPath", True
           
        End If
      Case "artistproduct"
         If boolArtist = False Then intArtistFirst = 0 Else intArtistFirst = args
      Case "titlealbum"
         If boolTitle = False Then intTitleFirst = 0 Else intTitleFirst = args
      Case "start"               'start scan software
         'CBrowse.boolAlbumChanged = True
         SearchPath = args
         Dim scanLanguagePath As String
         'scanLanguagePath = SlyVariable("<" & ScaningLanguageID & "_dat>")           '         GetEachLanguage(currentCountry)
         scanLanguagePath = get_country_path(ScaningLanguageID)
         
         'DeleteFile scanLanguagePath & "\MyAlbum.xml"
         If (boolScanning) Or (SearchPath = "") Then Exit Sub
         boolScanning = True
         'Public musicfile() As MusicType
         'Erase musicfile
         If ScanBy = 0 Then
            'CBrowse.scanhinttag args, Me, "ScanEvent"
            Call ScanWithPath(scanLanguagePath, args)
         ElseIf ScanBy = 1 Then
            ScanTime
         ElseIf ScanBy = 2 Then
            CBrowse.scanhinttag args, Me, "ScanEvent"
         End If
        'SetVariableToFlash "none", "sendClose", "none"
        
        FrmMain.refreshPlaylistPlayer
        
        If b_autoClose = True Then
            UnloadMe
        Else
            SetVariableToFlash "none", "sendClose", "none"
        End If
'         myMusic.ReLink
        boolScanning = False
      Case "okitem"
         fla_intSelectedIndex = args
         boolReady = True
         Wmp.Controls.Stop
         Timer2.Enabled = False
      Case "cancelitem"
         boolReady = True
         fla_intSelectedIndex = -1
         Wmp.Controls.Stop
         Timer2.Enabled = False
      Case "setvolume":    WaveVolume = args 'wmp.settings.volume = args
      Case "correctfile"
         PlayFile args
      Case "mb"
         'MsgBox args
         Debug.Print args
   End Select
End Sub

Private Function WaitForReady()
   boolReady = False
   While Not boolReady
      DoEvents
   Wend
End Function
Private Function GetCountryList() As String
   Dim i As Integer
   Dim loc_Name As String
   Dim loc_Path As String
   For i = 0 To UBound(CountriesList)
      'loc_List = loc_List & ""
      If i = 0 Then
         loc_Name = CountriesList(i).Name
         loc_Path = CountriesList(i).path
      Else
         loc_Name = loc_Name & "^^" & CountriesList(i).Name
         loc_Path = loc_Path & ";" & CountriesList(i).path
      End If
      '\\//
      '\\//
   Next
   GetCountryList = loc_Name & "\\//" & loc_Path
'''   Dim i As Integer, stringTmp As String
'''   For i = 0 To UBound(country)
'''      stringTmp = stringTmp & array_Split & country(i)(0)
'''   Next
'''   GetCountryList = Mid(stringTmp, 3)
End Function
Private Sub SetVariableToFlash(VariableName As String, command As String, Value As String)
   swfScan.SetVariable "openframe", "true"
   swfScan.SetVariable VariableName, Value
   swfScan.SetVariable command, "true"
End Sub
Private Sub PlayFile(filename As String)
    Timer2.Enabled = True
    Wmp.Settings.autoStart = True
    Wmp.url = filename
End Sub
Public Sub ScaleScane()
    If WinMode = "FullScreen Mode" Then
        SetBorderStyle hwnd, True
        Me.WindowState = 2
        swfScan.Move 0, 0, FrmMain.Width, FrmMain.Height
    Else
        frmScan.Caption = "SlyCDGuide - Scan Music Files"
        SetBorderStyle hwnd, False
        Me.WindowState = 0
        Me.Move FrmMain.left, FrmMain.top, FrmMain.Width, FrmMain.Height
        swfScan.Move 0, 0, FrmMain.swf(IndexSwf).Width, FrmMain.swf(IndexSwf).Height
    End If
End Sub

Sub replaceHistoryPathScan(strPath As String, strind As Integer, strval As String)
   Dim docXml As DOMDocument
   Dim eleXml As IXMLDOMElement
   Set docXml = New DOMDocument
   docXml.Load strPath
   Set eleXml = docXml.firstChild.childNodes(3).childNodes(strind)
   eleXml.Text = strval
   docXml.Save strPath
End Sub


Private Sub Timer2_Timer()
    sendToFlash swfScan, "seekbar", Wmp.Controls.currentPosition & "~" & Wmp.currentMedia.Duration & "~" & Wmp.Controls.currentPositionString & "~" & Wmp.currentMedia.durationString
End Sub

Public Sub searchscanhinttag()          'scan with hintag
   Dim mediaPath As String
   Dim filename As String
   
'''   Set lpPaths = New Collection
'''   Set shlItem = shlFolder.Self
'''   mediaPath = shlItem.path
'''   fileName = Dir(fso.BuildPath(mediaPath, "*.*"))
'''   While fileName <> ""
'''      If (InStr(";mkv;m4v;mp4;", ";" & fso.GetExtensionName(fileName) & ";") > 0) Then
'''         lpPaths.Add fso.BuildPath(mediaPath, fileName)
'''         lstFiles.AddItem fso.BuildPath(mediaPath, fileName)
'''      End If
'''      fileName = Dir()
'''   Wend
End Sub
'''Private Function SplitAlbumType(lpString As String) As String
'''   'VIP - DVD 001 , or Rasmey Hang Meas - DVD 001
'''   Dim spl() As String
'''   Dim splType() As String
'''   spl = Split(lpString, " - ", 2)
'''
'''   If UBound(spl) > 0 Then
'''      splType = Split(spl(1), " ")
'''      SplitAlbumType = splType(0)
'''   End If
'''End Function


Private Function GetArtistAlbumName(ByVal ID As Long) As String
   If tblActor.Seeks(ID) >= 0 Then
      GetArtistAlbumName = tblActor.Field("Name")
   End If
End Function

Private Sub UnloadMe()
   bout = True
   tmrExit.Enabled = True
End Sub

Private Sub tmrExit_Timer()
   If bout = True Then
      tmrExit.Enabled = False
      Unload Me
   End If
End Sub


Public Function ScanEvent(lpEventName As String, args As String)
   If lpEventName = "INFO" Then
      SetVariableToFlash "strScanning", "sendScanning", args
   End If
   Debug.Print lpEventName, args
End Function
