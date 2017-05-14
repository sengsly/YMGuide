VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "RipCD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Private boolLame_  As Boolean
'Dim wmp As WindowsMediaPlayer

Public currentAlbumInfo As AlbumType
Private saveApeFileInfo As String
Public WithEvents Wmp As WindowsMediaPlayer
Attribute Wmp.VB_VarHelpID = -1
Dim WithEvents tmrInterval As Timer
Attribute tmrInterval.VB_VarHelpID = -1
Dim audioPlaylistWMP As IWMPPlaylist



Dim RipTrack As New Collection
Dim audioCDDdriveIndex() As Long
Dim boolRipping As Boolean
Dim RippingTrackIndex As Long
Dim audioCDDriveRipping As Long
Dim hWindowMediaProcess As Long

Public DestinationFolder As String
Public Extension As String
Public ExtensionNew As String                               'For wav only

Private ExternalEncoder_ As enumExternalEncoder

Public Enum enumRippApplication
   WindowMediaPlayer = 0
   iTunesPlayer = 1
End Enum

Public Enum enumExternalEncoder
   NoneEncoder = 0
   LameEncoder = 1
   FlacEncoder = 2
   MonkeyAudio = 3
End Enum

Private Type SHELLEXECUTEINFO
        cbSize As Long
        fMask As Long
        hwnd As Long
        lpVerb As String
        lpFile As String
        lpParameters As String
        lpDirectory As String
        nShow As Long
        hInstApp As Long
        '  Optional fields
        lpIDList As Long
        lpClass As String
        hkeyClass As Long
        dwHotKey As Long
        hIcon As Long
        hProcess As Long
End Type
Private Const SEE_MASK_NOCLOSEPROCESS = &H40

'============================API declaration============================================
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function ShellExecuteEx Lib "shell32.dll" Alias "ShellExecuteExA" (lpExecInfo As SHELLEXECUTEINFO) As Long
Private Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long

'''Public Enum ShowEnum
'''   SW_HIDE = 0
'''   SW_NORMAL = 1
'''End Enum

'=======================================================================================
'Convert from Wav to Mp3 ,Wav to FLAC
Const Quote = """"
Dim hEncodeProcess As Long
Dim boolStartConvert As Boolean
' Public boolLame As Boolean
Dim lngEncodeFileIndex As Long
Public LamePreset As String
''======================================================================================
Public FlacProgramPath As String
Public LameProgramPath As String
Public APEProgramPath As String
'==============================Store Old Value===============================
Private CdDriveCount As Long                 ' variable according to cd
Private currentRipApplication As enumRippApplication

'===========================End Store Old Value===============================

'============================Class Events===============================================
Event RippingProgress(RippingTrackIndex As Long, progress As Long, maxProgress As Long)
Event RipCompleted()
Event cdrommediachange()

'=======================================================================================

Public Property Let RipPlayer(newValue As enumRippApplication)
      
'''   If newValue = WindowMediaPlayer Then
'''      'alway set wmp object because it use in get CDDBDisk id
'''      'If (wmp Is Nothing) Then Set wmp = obj
'''   End If
End Property
Public Property Let Timer(newValue As Timer)
   Set tmrInterval = newValue
   tmrInterval.Interval = 1000
   tmrInterval.Enabled = True
End Property
Public Function AddTrack(TrackIndex As Long) As Boolean
   RipTrack.Add TrackIndex + 1
End Function

Public Sub ClearRipTrack()
   Set RipTrack = New Collection
End Sub

Public Sub StartRip(Optional stringCheck As String)
   
   Dim i As Long
   Set RipTrack = New Collection
   For i = 1 To Len(stringCheck)
      If Mid(stringCheck, i, 1) = "1" Then
         RipTrack.Add i
      End If
   Next
   SaveAlbumInfo
   
   If RipTrack.count > 0 Then
      ReDim RipTrackPathName(TrackCount)
      
      If currentRipApplication = WindowMediaPlayer Then
         Dim RipApplication As String
         Dim RipScript As String
         RipApplication = fso.BuildPath(App.path, "copy.wms")
         RipScript = fso.BuildPath(App.path, "copy.js")
         SaveJavaScriptFile RipScript, stringCheck
         hWindowMediaProcess = ExecuteFile(RipApplication)
         boolRipping = True
      End If
   End If
      
End Sub

Public Function GetEncoders() As Variant
'''   Dim i As Long
'''   Dim lpData() As String
'''   If currentRipApplication = iTunesPlayer Then
'''      ReDim lpData(iTunes.Encoders.count - 1)
'''      For i = 1 To iTunes.Encoders.count
'''         If iTunes.Encoders(i).Name = "AAC Encoder" Then
'''            lpData(i - 1) = iTunes.Encoders(i).Name & " (M4A)"
'''         Else
'''            lpData(i - 1) = iTunes.Encoders(i).Name
'''         End If
'''      Next
'''      GetEncoders = lpData
'''   End If
End Function

Public Property Get TrackCount() As Long
On Error GoTo errorOccur
   '2006-11-03 Seng
   If currentRipApplication = WindowMediaPlayer Then
      TrackCount = Wmp.cdromCollection.Item(audioCDDriveRipping).Playlist.count
   End If
errorOccur:
End Property

Private Sub Class_Initialize()
   FlacProgramPath = "C:\Program Files\Flac\Flac.exe"
   LameProgramPath = "C:\Program Files\Lame\Lame.exe"
   LamePreset = "extreme"
                                 '--preset extreme
End Sub

Public Property Let EncodeFormat(newValue As Long)
'''   If currentRipApplication = iTunesPlayer Then
'''      iTunes.CurrentEncoder = .Encoders(newValue + 1)
'''      Extension = iTunes.CurrentEncoder.Format
'''   End If
End Property
Public Property Get hasCDDrive() As Boolean
   If currentRipApplication = WindowMediaPlayer Then
      hasCDDrive = Wmp.cdromCollection.count > 0
   End If
End Property

Public Property Get AudioDrives() As Variant
   Dim i As Long, j As Long, lpData() As String
   If currentRipApplication = WindowMediaPlayer Then
      If Wmp.cdromCollection.count Then
         ReDim lpData(Wmp.cdromCollection.count - 1)
         For i = 0 To Wmp.cdromCollection.count - 1
            lpData(i) = Wmp.cdromCollection.Item(i).driveSpecifier
         Next
      End If
   End If
   AudioDrives = lpData
End Property
Public Property Get RipperHwnd() As Long
   If currentRipApplication = iTunesPlayer Then
      RipperHwnd = FindWindow("iTunes", vbNullString)
   Else
       If processStillActive(hWindowMediaProcess) Then RipperHwnd = hWindowMediaProcess Else RipperHwnd = 0
   End If
End Property
Private Function processStillActive(hProcessID As Long) As Boolean
    Dim exitCode As Long
    Call GetExitCodeProcess(hProcessID, exitCode)
    processStillActive = (exitCode = 259)
End Function
Public Property Let ShowRippApplication(Show As Boolean)
   If Show Then ShowWindow RipperHwnd, SW_NORMAL Else ShowWindow RipperHwnd, SW_HIDE
End Property

Public Property Let RipIndex(newValue As Long)
   audioCDDriveRipping = newValue
   If currentRipApplication = WindowMediaPlayer Then
      Set audioPlaylistWMP = Wmp.cdromCollection.Item(audioCDDriveRipping).Playlist
   End If
End Property

Public Property Get RipIndex() As Long
   RipIndex = audioCDDriveRipping
End Property
Public Sub SaveAlbumInfo()
   Dim i As Long
   Dim lngTrackNumber As Integer
'   Set currentAlbumInfo = currentList
   
   If currentRipApplication = WindowMediaPlayer Then
      With audioPlaylistWMP
        audioPlaylistWMP.Name = currentAlbumInfo.ALBUM
        Call audioPlaylistWMP.setItemInfo("Genre", currentAlbumInfo.Genre)
        Call audioPlaylistWMP.setItemInfo("Artist", currentAlbumInfo.AlbumArtist)
        For i = 0 To audioPlaylistWMP.count - 1
          lngTrackNumber = audioPlaylistWMP.Item(i).getItemInfo("TrackNumber")
          With audioPlaylistWMP.Item(lngTrackNumber - 1)
              .Name = currentAlbumInfo.Tracks(lngTrackNumber).Title
              Call .setItemInfo("Year", currentAlbumInfo.Year)
              Call .setItemInfo("Artist", currentAlbumInfo.Tracks(lngTrackNumber).ARTIST)
          End With
        Next
      End With
   End If
End Sub
Private Function IsChanged()
   On Error GoTo RemoteServerMachineDoesnotExist
   Dim i As Long, j As Long
   If currentRipApplication = iTunesPlayer Then
   End If
RemoteServerMachineDoesnotExist:
End Function

Private Sub tmrInterval_Timer()
   Dim oldFilePath As String
   Dim newFilePath As String
   Dim TrackIndex As Long
   
   IsChanged
   If boolRipping Then
      If currentRipApplication = WindowMediaPlayer Then
         If RipperHwnd = 0 Then
            Dim i As Long
            boolRipping = False
            With currentAlbumInfo
               For i = 1 To .TrackCount
                  newFilePath = fso.BuildPath(DestinationFolder, GetDetailFileName(.Tracks(i).Title, .ALBUM, i, .Tracks(i).ARTIST)) + Extension
                  currentAlbumInfo.Tracks(i).path = newFilePath
               Next
            End With
            RaiseEvent RipCompleted
         End If
      End If
   End If
   
   Dim wavePath As String
   Dim musicExtensionOld As String
   Dim musicExtensionNew As String
      
   If boolStartConvert Then
      If Not processStillActive(hEncodeProcess) Then
         boolStartConvert = False
         
         If (lngEncodeFileIndex <= 0) And (lngEncodeFileIndex < currentAlbumInfo.TrackCount) Then
            musicExtensionOld = vbNullString
         Else
            musicExtensionOld = currentAlbumInfo.Tracks(lngEncodeFileIndex).path
         End If
         If musicExtensionOld <> vbNullString Then
            musicExtensionNew = ChangeFileExtension(musicExtensionOld, ExtensionNew)
            If Dir(musicExtensionNew) <> vbNullString Then
               If saveApeFileInfo <> "" And ExternalEncoder = MonkeyAudio Then
                  Shell saveApeFileInfo, vbHide
               End If
               currentAlbumInfo.Tracks(lngEncodeFileIndex).path = musicExtensionNew
               DeleteFile musicExtensionOld
            End If
         End If
         If lngEncodeFileIndex < currentAlbumInfo.TrackCount Then
            lngEncodeFileIndex = lngEncodeFileIndex + 1
            With currentAlbumInfo.Tracks(lngEncodeFileIndex)
               wavePath = .path
               boolStartConvert = True
               If wavePath = vbNullString Then            'if there is no path then
                  hEncodeProcess = 0            'start convert next file
               Else
                  If ExternalEncoder = LameEncoder Then
                     hEncodeProcess = EncodeLame(wavePath, .Title, .ARTIST, currentAlbumInfo.ALBUM, Year(currentAlbumInfo.Year), CStr(lngEncodeFileIndex), currentAlbumInfo.Genre)
                  ElseIf ExternalEncoder = FlacEncoder Then
                     hEncodeProcess = EncodeFlac(wavePath, .Title, .ARTIST, currentAlbumInfo.ALBUM, currentAlbumInfo.Year, CStr(lngEncodeFileIndex), currentAlbumInfo.Genre)
                  ElseIf ExternalEncoder = MonkeyAudio Then
                     hEncodeProcess = EncodeAPE(wavePath, .Title, .ARTIST, currentAlbumInfo.ALBUM, currentAlbumInfo.Year, CStr(lngEncodeFileIndex), currentAlbumInfo.Genre)
                  End If
               End If
            End With
         Else
            boolStartConvert = False
            RaiseEvent RipCompleted
         End If
      End If
   End If
End Sub


'============================Windows Media Rip=================================
Public Sub SaveJavaScriptFile(strFilePathName As String, Selected As String)
  Dim hFree As Integer, i As Long

  hFree = FreeFile()
  Open strFilePathName For Output As hFree
    
    Print #hFree, "var isCopyingCD = 0;"
    Print #hFree, "var CDROMIndex  = " & audioCDDriveRipping & ";"
    Print #hFree, "var checklist= """ & Selected & """"
  Close hFree
End Sub
Public Sub OpenRipApplication(Optional stringCheck As String)
   boolRipping = True
   If currentRipApplication = WindowMediaPlayer Then
      Dim RipApplication As String
      Dim RipScript As String
      RipApplication = fso.BuildPath(App.path, "copy.wms")
      RipScript = fso.BuildPath(App.path, "copy.js")
      SaveJavaScriptFile RipScript, stringCheck
      Shell RipApplication
   Else
      StartRip
   End If
End Sub


Private Sub WMP_CdromMediaChange(ByVal CdromNum As Long)
   If currentRipApplication = WindowMediaPlayer Then RaiseEvent cdrommediachange
End Sub

Public Function GetDetailFileName(strTitle As String, strAlbum As String, ByVal strTrackNumber As Integer, strArtist As String) As String
'*Artist;*Album;*TrackNumber;*SongTitle
  Dim varSplit As Variant, i As Integer
  Dim strTmp As String
  Dim varTitle As Variant
  Const Separator As String = " - "
  
  'varSplit = Split(LCase("*Artist;*Album;*TrackNumber;*SongTitle"), ";")
  varSplit = Split(LCase(WMPSetting.CDRecordFileDetail), ";")
  'varSplit = Split(LCase(WMPSetting.CDRecordFileDetail), ";")
  varTitle = Array(strArtist, strAlbum, Format(strTrackNumber, "00"), strTitle)
  
   strTmp = Taken(varSplit(0), varTitle(0))
   For i = 1 To 3
      strTmp = ConcateDetail(strTmp, Taken(varSplit(i), varTitle(i)), WMPSetting.CDRecordFileSeparator)
   Next
   GetDetailFileName = strTmp
End Function

Private Function EncodeFlac(inputFile As String, Optional Title As String, Optional ARTIST As String, Optional ALBUM As String, Optional Year As String, Optional tracknumber As String, Optional Genre As String) As Long
   'Convert Wave into FLAC       -f force to overwrite old file
   EncodeFlac = ExecuteFile(FlacProgramPath, AddStringTag(" --tag=title=", Title) & AddStringTag(" --tag=artist=", ARTIST) & AddStringTag(" --tag=album=", ALBUM) & AddStringTag(" --tag=date=", Year) & AddStringTag(" --tag=tracknumber=", tracknumber) & AddStringTag(" --tag=genre=", Genre) & " -f " & AddQuote(inputFile), SW_HIDE)
End Function
Private Function EncodeAPE(inputFile As String, Optional Title As String, Optional ARTIST As String, Optional ALBUM As String, Optional Year As String, Optional tracknumber As String, Optional Genre As String) As Long
   Dim tagPath As String
   tagPath = fso.GetParentFolderName(FlacProgramPath) & "\tag.exe"
   If Dir(tagPath) <> "" Then
      saveApeFileInfo = tagPath & AddStringTag(" --title ", Title) & AddStringTag(" --artist ", ARTIST) & AddStringTag(" --album ", ALBUM) & AddStringTag(" --year ", Year) & AddStringTag(" --track ", tracknumber) & AddStringTag(" --genre ", Genre) & " " & AddQuote(ChangeFileExtension(inputFile, "ape"))
   Else
      saveApeFileInfo = ""
   End If
   EncodeAPE = ExecuteFile(APEProgramPath, AddQuote(inputFile) & " " & AddQuote(ChangeFileExtension(inputFile, "ape")) + " -c1000", SW_HIDE)
End Function
Private Function EncodeLame(inputFile As String, Optional Title As String, Optional ARTIST As String, Optional ALBUM As String, Optional Year As String, Optional tracknumber As String, Optional Genre As String) As Long
   'Convert Wav into Mp3
   EncodeLame = ExecuteFile(LameProgramPath, "--preset " & LamePreset & AddStringTag(" --tt ", Title) & AddStringTag(" --ta ", ARTIST) & AddStringTag(" --tl ", ALBUM) & AddStringTag(" --ty ", Year) & AddStringTag(" --tn ", tracknumber) & AddStringTag(" --tg ", Genre) & " " & AddQuote(inputFile) & " " & AddQuote(ChangeFileExtension(inputFile, "mp3")), SW_HIDE)
End Function

Private Function ConcateDetail(first As String, second As String, Delimiter As String) As String
   If (first <> "") And (second <> "") Then
      ConcateDetail = first + Delimiter + second
   ElseIf (second = "") Or (first = "") Then
      ConcateDetail = first + second
   End If
End Function
Private Function Taken(ByVal stringAsterisk As String, ByVal value As String) As String
   If left(stringAsterisk, 1) = "*" Then Taken = value
End Function

Public Function GetToc() As String
   On Error Resume Next
   GetToc = Wmp.cdromCollection.Item(audioCDDriveRipping).Playlist.getItemInfo("TOC")
End Function
'Public Property Let boolLame(newValue As Boolean)
'   boolLame_ = newValue
'   If boolLame Then
'      ExtensionNew = "mp3"
'   Else
'      ExtensionNew = "flac"
'   End If
'End Property
'
'Public Property Get boolLame() As Boolean
'   boolLame = boolLame_
'End Property

Public Property Let ExternalEncoder(newValue As enumExternalEncoder)
   ExternalEncoder_ = newValue
   If newValue = FlacEncoder Then
      ExtensionNew = "flac"
   ElseIf newValue = LameEncoder Then
      ExtensionNew = "mp3"
   ElseIf newValue = MonkeyAudio Then
      ExtensionNew = "ape"
   Else
      ExtensionNew = ""
   End If
End Property

Public Property Get ExternalEncoder() As enumExternalEncoder
   ExternalEncoder = ExternalEncoder_
End Property


Private Function AddQuote(inputText As String) As String
   AddQuote = Quote & inputText & Quote
End Function
Private Function AddStringTag(tagName As String, tagValue As String)
   AddStringTag = tagName & AddQuote(tagValue)
End Function


