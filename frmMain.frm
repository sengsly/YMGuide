VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   Caption         =   "Music Magic"
   ClientHeight    =   5385
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7275
   LinkTopic       =   "Form1"
   ScaleHeight     =   5385
   ScaleWidth      =   7275
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "Load Form 2"
      Height          =   375
      Left            =   1680
      TabIndex        =   17
      Top             =   4800
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Frame fraCompare 
      Caption         =   "ID3 Tag"
      Height          =   3615
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   4335
      Begin VB.Frame fraAfterFound 
         Caption         =   "After Found"
         Height          =   1935
         Left            =   240
         TabIndex        =   11
         Top             =   1560
         Width           =   2775
         Begin VB.CheckBox chkAddAlbum 
            Caption         =   "Add Album Name"
            Enabled         =   0   'False
            Height          =   255
            Left            =   480
            TabIndex        =   14
            Top             =   840
            Width           =   1575
         End
         Begin VB.CheckBox chkAddProduction 
            Caption         =   "Add Production name"
            Enabled         =   0   'False
            Height          =   255
            Left            =   480
            TabIndex        =   13
            Top             =   600
            Width           =   2055
         End
         Begin VB.CheckBox chkAddTrack 
            Caption         =   "Add Track Number"
            Enabled         =   0   'False
            Height          =   255
            Left            =   480
            TabIndex        =   15
            Top             =   1080
            Width           =   1935
         End
         Begin VB.CheckBox chkEditID3 
            Caption         =   "Edit ID3 Tag"
            Height          =   255
            Left            =   240
            TabIndex        =   16
            Top             =   1440
            Width           =   1335
         End
         Begin VB.CheckBox chkRename 
            Caption         =   "Rename file"
            Height          =   255
            Left            =   240
            TabIndex        =   12
            Top             =   360
            Width           =   1215
         End
      End
      Begin VB.TextBox txtTitle 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   1
         EndProperty
         Height          =   285
         Left            =   1440
         TabIndex        =   4
         Top             =   1080
         Width           =   1575
      End
      Begin VB.CommandButton cmdCompare 
         Appearance      =   0  'Flat
         Caption         =   "Search"
         Height          =   375
         Left            =   3120
         TabIndex        =   5
         Top             =   2400
         Width           =   975
      End
      Begin VB.TextBox txtArtist 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   1
         EndProperty
         Height          =   315
         Left            =   1410
         TabIndex        =   2
         Top             =   420
         Width           =   1575
      End
      Begin VB.CheckBox chkTitle 
         Caption         =   "Title First"
         Height          =   495
         Left            =   240
         TabIndex        =   3
         Top             =   960
         Width           =   975
      End
      Begin VB.CheckBox chkArtist 
         Caption         =   "Artist First"
         Height          =   495
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Character(s)"
         Height          =   195
         Left            =   3120
         TabIndex        =   10
         Top             =   1125
         Width           =   855
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Character(s)"
         Height          =   195
         Left            =   3120
         TabIndex        =   9
         Top             =   480
         Width           =   855
      End
      Begin VB.Label lblAlbum 
         AutoSize        =   -1  'True
         Caption         =   "Treat as Album"
         Height          =   195
         Left            =   1410
         TabIndex        =   8
         Top             =   840
         Width           =   1065
      End
      Begin VB.Label lblPro 
         AutoSize        =   -1  'True
         Caption         =   "Treat as Production"
         Height          =   195
         Left            =   1410
         TabIndex        =   7
         Top             =   240
         Width           =   1395
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Test It"
      Height          =   375
      Left            =   3360
      TabIndex        =   6
      Top             =   4800
      Visible         =   0   'False
      Width           =   1215
   End
   Begin MSComctlLib.ProgressBar prgComplete 
      Height          =   180
      Left            =   120
      TabIndex        =   18
      ToolTipText     =   "Working....."
      Top             =   4320
      Visible         =   0   'False
      Width           =   6855
      _ExtentX        =   12091
      _ExtentY        =   318
      _Version        =   393216
      BorderStyle     =   1
      Appearance      =   0
      Scrolling       =   1
   End
   Begin VB.Label lblFiles 
      Height          =   195
      Left            =   120
      TabIndex        =   20
      Top             =   4560
      Width           =   6765
   End
   Begin VB.Label lblDescription 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Height          =   195
      Left            =   120
      TabIndex        =   19
      Top             =   3960
      Width           =   45
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sh As New Shell
Dim table As New DataCls
Dim pathString As String
Dim tblTrack_Path As TableCls
Dim trackSearch As TableCls
Dim AlbumSearch As TableCls
Private Const Ext = "mp3"
'Dim currentLanguage As LanguageEnum


' This project must reference MusicLib,DataAccess

'Dim Query As New DataCls

Private Sub chkRename_Click()
  
End Sub

Private Sub Command3_Click()
  With frmFile
    frmFile.strTitle = "Chong Prab Tha Bong Trov Ka .."
    
    frmFile.lstFile.AddItem "E:\1 Search\s\009.mp3"
    frmFile.lstFile.AddItem "E:\1 Search\s\Copy of 009.mp3"
    
    frmFile.Show vbModal
    MsgBox frmFile.intIndex
  End With
End Sub

Private Sub Command4_Click()
  Dim yy As New Music
'  yy.FileName = "D:\My Mp3s\RSK\Album 7 - Kbot Oun Mdech Tov\02 - Svakum - EV Band.wma"
  yy.FileName = "D:\My Mp3s\RSK\Album 7 - Kbot Oun Mdech Tov\02 - Svakum.wma"
'  yy.FileName = "D:\Khmer320\RSK\Album 7 - Kbot Oun Mdech Tov\RSK - Album 7 - Kbot Oun Mdech Tov - 02 - Svakum.mp3"

'  yy.FileName = "D:\Khmer320\RSK\Album 7 - Kbot Oun Mdech Tov\RSK - Album 7 - Kbot Oun Mdech Tov - 01 - Soum Anet.mp3"

  MsgBox yy.Duration
'  MsgBox
End Sub

Private Sub Form_Load()
  On Error GoTo ErrorOccure
'  optLanguage.Item(1).Value = True
  
'  Query.InitializeRelationShip "Track.ArtistID=Artist.ID;Track.ProductionID=Production.ID;Track.AlbumID=Album.ID;Track.MoodID=Mood.ID;Track.DanceStyleID=DanceStyle.ID", "Track.ArtistID=Artist.Name;Track.ProductionID=Production.Name;Track.AlbumID=Album.Title;Track.MoodID=Mood.Mood;Track.DanceStyleID=DanceStyle.DanceStyle"
'Query.InitializeRelationShip "Track.ArtistID=Artist.ID&Track.AlbumID=Album.ID&Track.MoodID=Mood.ID&Track.DanceStyleID=DanceStyle.ID", "Track.ArtistID=Artist.Name&Track.AlbumID=Album.Title&Track.MoodID=Mood.Mood&Track.DanceStyleID=DanceStyle.DanceStyle"
'  Query.InitializeRelationShip "Track.ArtistID=Artist.ID;Track.ProductionID=Production.ID;Track.AlbumID=Album.ID;Track.MoodID=Mood.ID;Track.DanceStyleID=DanceStyle.ID", "Track.ArtistID=Artist.Name;Track.ProductionID=Production.Name;Track.AlbumID=Album.Title;Track.MoodID=Mood.Mood;Track.DanceStyleID=DanceStyle.DanceStyle"
  Exit Sub
ErrorOccure:
  MsgBox "Connection cannot be connected"
End Sub


Private Function GetFolder() As String
  On Error GoTo Errorhandle
  Dim strBrowseDir As String
  strBrowseDir = sh.BrowseForFolder(hWnd, "Browse for folder", 0, "").Items.Item.Path
Errorhandle:
 On Error GoTo 0
  GetFolder = strBrowseDir
End Function
Private Sub cmdCompare_Click()
  Dim lStrFolder As String, i As Integer, j As Integer
  Dim intFieldLength%, intFieldTrackPos%, intFieldTitle%
  Dim intFieldAlbum%, intFieldProduction%, intFieldPath%
  Dim intFieldAlbumID%
  Dim lIntMoreLikely As Integer, lIntDifferent As Integer, lIntIndex As Integer
  Dim intFieldLengthWMA As Integer
  
  Dim lStrPoduction As String, lStrAlbum As String, lIntTrackPos As Integer, lStrLengthWMA As String
  Dim strTrackTitle As String, lStrLength As String, lIntAlbumID As Integer
  
  Dim trackTable As New TableCls       ', trackSearch As New TableCls
'  Dim AlbumSearch As New TableCls
  Dim sourMusic As MusicProperty, DestMusic As MusicProperty
  Dim lBolFirstFound As Boolean, intTitleCount As Integer
  Dim strNewPathFile As String
  Dim intMatches As Integer, MoreMatches() As Integer, k As Integer
  Dim intSelectIndex As Integer, strOldFile As String
  Dim intRecordCount As Integer
  
  
  lStrFolder = GetFolder()
'  SetDirectory App.Path + "\CD\"
'  tblTrack_Path.Opens "Track"

  intFieldPath = trackSearch.FieldToIndex("Path")
  
  
  
  fraCompare.Enabled = False
  If lStrFolder <> "" Then
'    myString200
'    CompareMusicTime lStrFolder, Mp3List, Array("mp3", "wma") ,
   
    intFieldLength = trackSearch.FieldToIndex("Length")
    intFieldTrackPos = trackSearch.FieldToIndex("TrackPos")
    intFieldTitle = trackSearch.FieldToIndex("Name")
  '    intFieldProduction = trackTable.FieldToIndex("Production")  'Return Production.Name
    intFieldProduction = trackSearch.FieldToIndex("Artist")
    intFieldAlbum = trackSearch.FieldToIndex("Album")
    intFieldLengthWMA = trackSearch.FieldToIndex("LengthWMA")
    intFieldAlbumID = trackSearch.FieldToIndex("AlbumID")


    intRecordCount = trackSearch.RecordCount
    lblDescription.Caption = "Scanning Folders..........."
    trackSearch.MoveFirst
    For j = 0 To intRecordCount - 1
      DoEvents
'      pgbPercent.Value = (j / (intRecordCount - 1)) * 100
      lBolFirstFound = False: lIntMoreLikely = -1
      
      lStrPoduction = trackSearch.Field(intFieldProduction)
      lStrAlbum = trackSearch.Field(intFieldAlbum)
      lIntTrackPos = trackSearch.Field(intFieldTrackPos)
      lStrLength = trackSearch.Field(intFieldLength)
      strTrackTitle = trackSearch.Field(intFieldTitle)
      lStrLengthWMA = trackSearch.Field(intFieldLengthWMA)
      lIntAlbumID = trackSearch.Field(intFieldAlbumID)
'      trackTable.MoveNext
      
      If chkArtist.Value = vbChecked Then
        sourMusic.Artist = lStrPoduction
      End If
      
      If chkTitle.Value = vbChecked Then
        sourMusic.Title = lStrAlbum 'trackTable(intFieldAlbum)
      End If
'      sourMusic.Track = lIntTrackPos
      sourMusic.Length = lStrLength
      intMatches = 0
      lIntIndex = -1
'      If InStr(strTrackTitle, "Mohitthirith") > 0 Then MsgBox "Found"
      For i = 0 To UBound(Mp3List)
'        If i = 11 Then MsgBox ""
        With Mp3List(i)
          If .MusicType = WMAFile Then sourMusic.Length = lStrLengthWMA Else sourMusic.Length = lStrLength

          If chkArtist.Value = vbChecked Then
            DestMusic.Artist = Left(.Mp3Artist, txtArtist.Text)
          End If
          If chkTitle.Value = vbChecked Then
            DestMusic.Title = Left(.Mp3Title, txtTitle)
          End If
          If .Mp3Track > 0 Then
            DestMusic.Track = .Mp3Track
            sourMusic.Track = lIntTrackPos
          Else
            sourMusic.Track = 0    'If there is no track do not compare it
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
        With frmFile
          .lstFile.Clear
          Dim bolChoosen As Boolean
          .lblTitle = strTrackTitle
          For k = 0 To intMatches
            .lstFile.AddItem Mp3List(MoreMatches(k)).Mp3PathName
            If Mp3List(MoreMatches(k)).bolChoosen Then
              bolChoosen = True
              lIntIndex = MoreMatches(k)
              Exit For
            End If
          Next k
          If Not bolChoosen Then
            .Show vbModal
            If .intIndex < 0 Then lIntMoreLikely = -1 Else lIntIndex = MoreMatches(.intIndex)
          End If
        End With
      End If
      If lIntMoreLikely >= 0 Then
        Dim curMp3 As Mp3FileType
        
'        curMp3 = Mp3List(lIntIndex)
        With Mp3List(lIntIndex)
          Dim intTableIndex As Integer, intTitlePos As Integer
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
            .Title(intTitlePos).AlbumID = lIntAlbumID
            .Title(intTitlePos).TrackNumber = lIntTrackPos
            If intMatches > 0 Then .bolChoosen = True
          Else
            intTableIndex = GetUbound(.Title(intTitlePos).TableIndex()) + 1
            ReDim Preserve .Title(intTitlePos).TableIndex(intTableIndex)
            .Title(intTitlePos).TableIndex(intTableIndex) = j
          End If
        End With
      End If
      trackSearch.MoveNext
    Next j
    lblDescription.Caption = "Writing information to files....."
    intRecordCount = UBound(Mp3List)
    For i = 0 To intRecordCount
      DoEvents
'      pgbPercent.Value = (i / intRecordCount) * 100
      lblFiles = Mp3List(i).Mp3PathName
'      MsgBox Mp3List(i).Mp3Length
      With Mp3List(i)

        intTitleCount = UboundMp3SubType(.Title)
        If intTitleCount > 0 Then       'One Files with many titles
          frmChoose.strMusicPathName = .Mp3PathName
          frmChoose.lstTitle.Clear
          For j = 0 To intTitleCount
            frmChoose.lstTitle.AddItem .Title(j).Name
          Next
          frmChoose.Show vbModal
          intSelectIndex = frmChoose.intSelectedIndex
'          MsgBox .Title(frmChoose.intSelectedIndex).Name
        ElseIf intTitleCount = 0 Then
          intSelectIndex = 0
        Else
          intSelectIndex = -1
        End If
        If intSelectIndex >= 0 Then
          strOldFile = .Mp3PathName
          If chkEditID3.Value = vbChecked Then
            Mp3.FileName = strOldFile
            Mp3.Album = .Title(intSelectIndex).Album
            Mp3.Artist = .Title(intSelectIndex).Production
            Mp3.TrackNumber = .Title(intSelectIndex).TrackNumber
            Mp3.Title = .Title(intSelectIndex).Name
            Mp3.Update
          End If
          strTrackTitle = GetRenamedFile(.Title(intSelectIndex).Name, .Title(intSelectIndex).Production, chkAddProduction.Value, .Title(intSelectIndex).Album, chkAddAlbum.Value, .Title(intSelectIndex).TrackNumber, chkAddTrack.Value)
          strNewPathFile = ReplaceNewFileName(.Mp3PathName, strTrackTitle)
          If chkRename.Value = vbChecked Then
'            strTrackTitle = GetRenamedFile(.Title(intSelectIndex).Name + "." + Ext, .Title(intSelectIndex).Production, chkAddProduction.Value, .Title(intSelectIndex).Album, chkAddAlbum.Value, .Title(intSelectIndex).TrackNumber, chkAddTrack.Value)
'            strNewPathFile = GetFileName(strNewPathFile)
            Name strOldFile As strNewPathFile
          End If
      
      'Update field Path
          Dim absoluteIndex As Integer
          For j = 0 To UBound(.Title(intSelectIndex).TableIndex())
            absoluteIndex = .Title(intSelectIndex).TableIndex(j)
            'Track Path
            trackSearch.AbsoluteEdit(absoluteIndex, intFieldPath) = strNewPathFile
            'Track Available
            trackSearch.AbsoluteEdit(absoluteIndex, 17) = 1
            If AlbumSearch.Seeks(.Title(intSelectIndex).AlbumID) Then
'             ' Album Available
              AlbumSearch.Field(10) = 1            ' Album Available
              AlbumSearch.Update
            End If
          Next j
        End If
      End With
    Next i
  Else
    MsgBox "Please select a file"
  End If
'  tblTrack_Path.Closes
  lblDescription = ""
  lblFiles = ""
  fraCompare.Enabled = True
End Sub

Private Sub Command2_Click()
  Dim ss(-99 To -1)
'  Dim i As New clsID3MP3
'  i.FileName = "C:\test.mp3"
'  i.Album = "Vol 140 - Dork Chets"
'  i.Update ID3TT_ALL
  Dim Y()
  MsgBox UBound(ss)
End Sub
Private Sub ProgressBar1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

End Sub

Private Sub lblDescription_Change()
  If lblDescription = "" Then prgComplete.Visible = False Else prgComplete.Visible = True
End Sub

Sub SetLanguage(language As Integer)

'  pathString = App.path + SlyLanguage.SetLanguage(language)
'  currentLanguage = language
  Set trackSearch = New TableCls
  Set AlbumSearch = New TableCls
  Set tblTrack_Path = New TableCls

  SetDirectory pathString         '+ "CD"
'  Call tblTrack_Path.Opens("Track")
'  intFieldPath = tblTrack_Path.FieldToIndex("Path")
  
'  SetDirectory pathString + "SearchTitle"
  trackSearch.Opens "Track"
  AlbumSearch.Opens "Album"


End Sub
