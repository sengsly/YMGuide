Attribute VB_Name = "WMASetInfo"
Option Explicit

Private Const hRootKey = HKEY_CURRENT_USER
Public Const StrRegKey = "Software\Microsoft\MediaPlayer\Preferences"


Public Type WMPSettingType
  
  CDRecordPath            As String   ' ---> D:\KhmerMP3
  CDRecordFileDetail      As String  ' ---> *Album;*TrackNumber;*SongTitle;Artist;Genre;Bitrate
  CDRecordFileSeparator   As String ' --->  -
  FileExtension           As String
  
  CDRecordMode            As Long          ' ---> 0
  CDRecordMP3             As Long          ' ---> 0
  WMARecordRate           As Long          ' ---> 192000;160000;128000;96000;64000
  WMARecordQuality        As Long          ' ---> 98,90,70,50
  MP3RecordRate           As Long

End Type



Private currentFormat As Integer
Private prv_OutPutTitle As String
Private prv_Directory As String
Private prv_Delimiter As String


Public WMPSetting As WMPSettingType
Public Bitrates(2, 5) As Long
Public Enum FormatEnum
   WMP0Audio = 0        'Index 0
   WMP2VBR = 2          'Index 1
   WMP3LossLess = 3     'Index 2
   MP3CBR = 1           'Index 3
End Enum

Public Sub SetBitRateValue()
   On Error GoTo Error
  Bitrates(0, 0) = 48000: Bitrates(0, 1) = 64000
  Bitrates(0, 2) = 96000: Bitrates(0, 3) = 128000
  Bitrates(0, 4) = 160000: Bitrates(0, 5) = 192000
  
  Bitrates(1, 0) = 25: Bitrates(1, 1) = 50
  Bitrates(1, 2) = 75: Bitrates(1, 3) = 90
  Bitrates(1, 4) = 98
  
  Bitrates(2, 0) = 128000: Bitrates(2, 1) = 160000
  Bitrates(2, 2) = 192000: Bitrates(2, 3) = 256000
  Bitrates(2, 4) = 320000
  
   Exit Sub
Error:
   WriteEvent "SetBitRateValue", Err.Description, Err.Source
End Sub

Public Sub SetRegistry()
   On Error GoTo Error
  With WMPSetting
  
    SetKeyValue hRootKey, StrRegKey, "CDRecordPath", .CDRecordPath, REG_SZ
    SetKeyValue hRootKey, StrRegKey, "CDRecordFileDetail", .CDRecordFileDetail, REG_SZ
    SetKeyValue hRootKey, StrRegKey, "CDRecordFileSeparator", .CDRecordFileSeparator, REG_SZ
    
    SetKeyValue hRootKey, StrRegKey, "CDRecordMode", .CDRecordMode, REG_DWORD
    SetKeyValue hRootKey, StrRegKey, "CDRecordMP3", .CDRecordMP3, REG_DWORD
    SetKeyValue hRootKey, StrRegKey, "WMARecordRate", .WMARecordRate, REG_DWORD
    SetKeyValue hRootKey, StrRegKey, "WMARecordQuality", .WMARecordQuality, REG_DWORD
    SetKeyValue hRootKey, StrRegKey, "MP3RecordRate", .MP3RecordRate, REG_DWORD
    
    
  End With
  
   Exit Sub
Error:
   WriteEvent "SetRegistry", Err.Description, Err.Source
End Sub
Sub SetIt()
   On Error GoTo Error
  With WMPSetting
    .CDRecordPath = "D:\KhmerMP3"
    .CDRecordFileDetail = "*Artist;*Album;*TrackNumber;*SongTitle;Genre;Bitrate"
    .CDRecordFileSeparator = " - "
    
    .CDRecordMode = 2
    .CDRecordMP3 = 0
    .WMARecordRate = 0
    .WMARecordQuality = 75
  End With
  SetRegistry
   Exit Sub
Error:
   WriteEvent "SetIt", Err.Description, Err.Source
End Sub
Public Function GetTitleName(ARTIST As String, ALBUM As String, TrackNum As Integer, Title As String) As String
   On Error GoTo Error
   '0101             Artist Album TrackNumber TrackTitle
   Dim i As Integer, strTmp As String
   
   If Mid(prv_OutPutTitle, 1, 1) = "1" Then strTmp = ARTIST
   If Mid(prv_OutPutTitle, 2, 1) = "1" Then strTmp = strTmp + prv_Delimiter + ALBUM
   If Mid(prv_OutPutTitle, 3, 1) = "1" Then strTmp = strTmp + prv_Delimiter & TrackNum
   If Mid(prv_OutPutTitle, 4, 1) = "1" Then strTmp = strTmp + prv_Delimiter + Title
   GetTitleName = strTmp
      
   Exit Function
Error:
   WriteEvent "GetTitleName", Err.Description, Err.Source
End Function
Public Function GetDetailFileName(strTitle As String, strAlbum As String, strTrackNumber As Integer, strArtist As String) As String
   On Error GoTo Error
'*Artist;*Album;*TrackNumber;*SongTitle
  Dim varSplit As Variant, i As Integer
  Dim strTmp As String
  Dim varTitle As Variant
  Const Separator As String = " - "
  
  'varSplit = Split(LCase("*Artist;*Album;*TrackNumber;*SongTitle"), ";")
  varSplit = Split(LCase(WMPSetting.CDRecordFileDetail), ";")
  varTitle = Array(strArtist, strAlbum, Format(strTrackNumber, "00"), strTitle)
  
   strTmp = Taken(varSplit(0), varTitle(0))
   For i = 1 To 3
      strTmp = ConcateDetail(strTmp, Taken(varSplit(i), varTitle(i)), WMPSetting.CDRecordFileSeparator)
   Next
   GetDetailFileName = strTmp ''+ ".wma"
   Exit Function
Error:
   WriteEvent "GetDetailFileName", Err.Description, Err.Source
End Function
Private Function TitleValue(strTitle As String, strAlbum As String, strTrackNumber As Integer, strArtist As String, strChoose As String) As String
   On Error GoTo Error
  If strChoose = "*artist" Then TitleValue = strArtist
  If strChoose = "*album" Then TitleValue = strAlbum
  If strChoose = "*tracknumber" Then TitleValue = Format(strTrackNumber, "00")
  If strChoose = "*songtitle" Then TitleValue = strTitle
   Exit Function
Error:
   WriteEvent "TitleValue", Err.Description, Err.Source
End Function

Public Function SetCDRecordFileDetail(binary As String)
   On Error GoTo Error
   '0101
   prv_OutPutTitle = binary
   WMPSetting.CDRecordFileDetail = GetCDRecordFileDetail()
   Exit Function
Error:
   WriteEvent "SetCDRecordFileDetail", Err.Description, Err.Source
End Function
Public Function GetCDRecordFileDetail() As String
   On Error GoTo Error
'      .CDRecordFileDetail
   Dim i As Integer, strDefault As String, strTmp As String
   Dim varList As Variant, binary As String
   
   varList = Array("Artist;", "Album;", "TrackNumber;", "SongTitle;")
   
   'Artist;Album;TrackNumber;*SongTitle;Genre;Bitrate
   binary = prv_OutPutTitle
   For i = 1 To Len(binary)
      strTmp = strTmp + IIf(Mid(binary, i, 1) = "1", "*", "") + varList(i - 1)
   Next
   strTmp = strTmp + "Genre;Bitrate"
   GetCDRecordFileDetail = strTmp
   Exit Function
Error:
   WriteEvent "GetCDRecordFileDetail", Err.Description, Err.Source
End Function

Public Function SetCopyCDFormat(fm As Integer) As String
   On Error GoTo Error
   'return the extension
   Dim tmpFormat As FormatEnum
   
   currentFormat = fm
   If fm = 0 Then tmpFormat = WMP0Audio      'according to the index
   If fm = 1 Then tmpFormat = WMP2VBR
   If fm = 2 Then tmpFormat = WMP3LossLess
   If fm = 3 Then tmpFormat = MP3CBR
   
   With WMPSetting
      .CDRecordMode = tmpFormat
      If tmpFormat = MP3CBR Then
         .CDRecordMP3 = 1
         .FileExtension = ".mp3"
      Else
         .FileExtension = ".wma"
         .CDRecordMP3 = 0
      End If
      SetCopyCDFormat = .FileExtension
   End With
   Exit Function
Error:
   WriteEvent "SetCopyCDFormat", Err.Description, Err.Source
End Function

Public Sub SetBitrate(Index As Integer)
   On Error GoTo Error
   With WMPSetting
      
      If .CDRecordMode = WMP0Audio Then
         .WMARecordRate = Bitrates(0, Index)
      ElseIf (.CDRecordMode = WMP2VBR) Then
         'Variable bitrates
         '0       25%
         '1       50%
         '2       75%
         '3       90%
         '4       98%
         .WMARecordQuality = Bitrates(1, Index)
      ElseIf .CDRecordMode = MP3CBR Then
         .MP3RecordRate = Bitrates(2, Index)
         
      End If
   End With
   Exit Sub
Error:
   WriteEvent "SetBitrate", Err.Description, Err.Source
End Sub

Public Sub SetSeparator(Separator As String)
   On Error GoTo Error
   prv_Delimiter = Separator
   WMPSetting.CDRecordFileSeparator = Separator
   Exit Sub
Error:
   WriteEvent "SetSeparator", Err.Description, Err.Source
End Sub
Public Sub SetRecordDirectory(directory As String)
   On Error GoTo Error
   If right(directory, 1) = "\" Then prv_Directory = directory Else prv_Directory = directory + "\"
   WMPSetting.CDRecordPath = prv_Directory
   Exit Sub
Error:
   WriteEvent "SetRecordDirectory", Err.Description, Err.Source
End Sub

Public Sub SaveJavaScriptFile(strFilePathName As String, Selected As String)
   On Error GoTo Error
  Dim hFree As Integer, i As Integer
  hFree = FreeFile()
  Open strFilePathName For Output As hFree
    Print #hFree, "var isCopyingCD = 0;"
    Print #hFree, "var CDROMIndex  = " & currentCDIndex & ";"
    Print #hFree, "var checklist= """ & Selected & """"
  Close hFree
   Exit Sub
Error:
   WriteEvent "SaveJavaScriptFile", Err.Description, Err.Source
End Sub

Public Function DirWMAFile(ByVal Folder As String, ByVal Title As String) As String
   On Error GoTo Error
   'find music file according to the file extension specified by  format
   Dim filename As String
   Dim dotPosition As Integer
   Dim boolFound As Boolean
   Dim fullPath As String
   Dim windowMediachangedFileName As String
   Dim baseName As String
   
   baseName = fso.GetBaseName(Folder)
   dotPosition = InStr(baseName, ".")
   
   If dotPosition > 0 Then
      windowMediachangedFileName = left(baseName, dotPosition - 1) + "." + fso.GetExtensionName(Folder)
      fullPath = fso.BuildPath(fso.GetParentFolderName(Folder), windowMediachangedFileName)
      boolFound = Dir(fullPath) <> ""
   End If
   
   If (dotPosition > 0) And boolFound Then
      Name fullPath As Folder '+ Title + WMPSetting.FileExtension
   End If
   boolFound = Dir(Folder) <> ""
   If boolFound Then DirWMAFile = Folder  '+ Title + WMPSetting.FileExtension
   Exit Function
Error:
   WriteEvent "DirWMAFile", Err.Description, Err.Source
End Function
Public Property Let EnableScreensaver(ByVal vValue As Long)
   On Error GoTo Error
''''(this is to allow the computer to turn off monitor and go into
''''powersaving mode)   0 disable,1 enable
   SetKeyValue hRootKey, StrRegKey, "EnableScreensaver", vValue, REG_DWORD
   Exit Property
Error:
   WriteEvent "Let EnableScreensaver", Err.Description, Err.Source
End Property


'SlyRegedit.SetKeyValue HKEY_CURRENT_USER, "SOFTWARE\MICROSOFT\MEDIAPLAYER\PREFERENCES", "MetadataRetrieval", 0, REG_DWORD
Private Function ConcateDetail(first As String, second As String, Delimiter As String) As String
   If (first <> "") And (second <> "") Then
      ConcateDetail = first + Delimiter + second
   ElseIf (second = "") Or (first = "") Then
      ConcateDetail = first + second
   End If
End Function
Private Function Taken(ByVal stringAsterisk As String, ByVal Value As String) As String
   If left(stringAsterisk, 1) = "*" Then Taken = Value
End Function
