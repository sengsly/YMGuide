Attribute VB_Name = "FindFileMOD"
Option Explicit
Private Const Attributes = vbDirectory Or vbHidden Or vbReadOnly Or vbSystem
'Public cnn As New Connection
'Public rst As Recordset

Public Type MusicProperty
  filename As String
  Length As String
  ARTIST As String
  Title As String
  ALBUM As String
  TRACK As Integer
End Type

Public Type Mp3SubType
  Name As String
  tracknumber As Integer
  Production As String
  ALBUM As String
  albumID As Long
  TableIndex() As Long
End Type
Public Enum MusicFileENUM
  Mp3File = 1
  WMAFile = 2
End Enum

Public Type Mp3FileType
  Mp3PathName As String
  Mp3Length As String
  Mp3Track As Integer
  Mp3Artist As String
  Mp3Title As String
  MusicType As MusicFileENUM
  intTableIndex As Integer
  intTitleIndexChoosen As Integer
  bolChoosen As Boolean
  strTrackTitle As String
  strOldTrackTitle As String
  Title() As Mp3SubType
End Type
Public Mp3List() As Mp3FileType

'FindFolder "C:\Seng Test Search","mp3"
Public Function Mp3CompareType(SMp3 As MusicProperty, DMp3 As MusicProperty) As Integer
   On Error GoTo Error
  Dim bMatch(3) As Boolean, i As Integer
  Dim bMatched As Boolean, intFarLike As Integer
'
  For i = 0 To UBound(bMatch)
    bMatch(i) = True
  Next

  'intFarLike = Mp3Compare(SMp3.Length, DMp3.Length, 15)
  intFarLike = Mp3Compare(SMp3.Length, DMp3.Length, 1)
  
  If intFarLike >= 0 Then
    If SMp3.ALBUM <> "" Then
      bMatch(0) = (LCase(DMp3.ALBUM) Like "*" + LCase(SMp3.ALBUM) + "*")
'      If bMatch(0) = False Then intFarLike = -1
    End If
    If SMp3.Title <> "" Then
      bMatch(1) = (LCase(SMp3.Title) Like "*" + LCase(DMp3.Title) + "*")
    End If
    If DMp3.TRACK > 0 Then
      bMatch(2) = (SMp3.TRACK = DMp3.TRACK)
    End If
    If SMp3.ARTIST <> "" Then
      bMatch(3) = (LCase(SMp3.ARTIST) Like "*" + LCase(DMp3.ARTIST) + "*")
    End If
    
    bMatched = True
    For i = 0 To UBound(bMatch)
      If bMatch(i) = False Then intFarLike = -1
'      If bMatch(i) Then intFarLike = intFarLike - 5
'      bMatched = bMatched And bMatch(i)
    Next
  End If
  Mp3CompareType = intFarLike
  'if Mp3Type.FileName
   Exit Function
Error:
   WriteEvent "Mp3CompareType", Err.Description, Err.Source
End Function

Public Function Mp3Compare(SourceDuration As String, WithDuration As String, intDifferent As Integer) As Integer
   On Error GoTo Error
  Dim i As Single
  Dim MainTime(1) As String, intMilisecond(1) As Integer
  
   'set default value to -1
  Mp3Compare = -1
  
  If Len(SourceDuration) = 8 And Len(WithDuration) = 8 Then
    i = GetTimeDifferent(SourceDuration, WithDuration)
  '  MainTime(0) = left(SourceDuration, 5): intMilisecond(0) = Int(Right(SourceDuration, 2))
'    MainTime(1) = left(WithDuration, 5): intMilisecond(1) = Int(Right(WithDuration, 2))
    
    'If (MainTime(0) = MainTime(1)) Then
     ' i = Abs(intMilisecond(0) - intMilisecond(1))
      If i <= intDifferent Then
        Mp3Compare = 100 - intDifferent + i
      End If
'    End If
  End If
   Exit Function
Error:
   WriteEvent "Mp3Compare", Err.Description, Err.Source
End Function
Public Function ReplaceNewFileName(strOldFilePathName As String, strNewFileName As String) As String
Attribute ReplaceNewFileName.VB_Description = "'Ex Argument   ""C:\\Khmer\\MySong.Mp3"",""NewSong.Mp3""\r\n'Result ""C:\\Khmer\\NewSong.Mp3""\r\n"
   On Error GoTo Error
  Dim strPath As String, strName As String, i As Integer
  Dim strExt As String, lStrAdded As String, j As Integer
  
  i = InStrRev(strOldFilePathName, "\")
  j = InStrRev(strOldFilePathName, ".")
  strPath = left(strOldFilePathName, i)
  strExt = Mid(strOldFilePathName, j)
  strName = strNewFileName
  If LCase(strOldFilePathName) <> LCase(strPath + strNewFileName + strExt) Then
    i = 0
    While isFileExist(strPath + strNewFileName + lStrAdded + strExt)
      i = i + 1
      lStrAdded = Format(i, " 00")
    Wend
  End If
  ReplaceNewFileName = strPath + strNewFileName + lStrAdded + strExt
   Exit Function
Error:
   WriteEvent "ReplaceNewFileName", Err.Description, Err.Source
End Function

Public Function Second2Time(ByVal dblSecond As Double, Optional RemoveLastDigit As Boolean) As String
   On Error GoTo Error
   'edit seng 2005-08-19
  Dim intSecond As Double, lIntSecond As Single
  Dim iniMinute As Single
  Dim strTime As String

  intSecond = GetDecimal(dblSecond)
  lIntSecond = Fix(dblSecond)
  iniMinute = lIntSecond Mod 3600
  strTime = Format(lIntSecond \ 3600, "00") + ":" + Format(iniMinute \ 60, "00") + ":" + Format(iniMinute Mod 60, "00")
  If Not RemoveLastDigit Then strTime = strTime & Format(intSecond - lIntSecond, "#.00")
  Second2Time = strTime
   Exit Function
Error:
   WriteEvent "Second2Time", Err.Description, Err.Source
End Function
Public Function GetTimeDifferent(oldTime As String, newTime As String) As Single
   On Error GoTo Error
   Dim leftTime As Single
   Dim rightTime As Single
   
   leftTime = Time2Second(oldTime)
   rightTime = Time2Second(newTime)
   GetTimeDifferent = Abs(rightTime - leftTime) * 100
   'CompareTime = ((Abs(rightTime - leftTime)) <= differential)
   Exit Function
Error:
   WriteEvent "GetTimeDifferent", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   RoundTo3
' Description       :   Convert from Base 10 to base 3
' Return Values     :   Converted value
' Input Parameter   :   Base 10
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' None             03-09-2006           New
'*******************************************************************************
Public Function RoundTo3(sNumber As Single) As Integer
   On Error GoTo Error
   RoundTo3 = Int((sNumber - Fix(sNumber)) * 3)
   Exit Function
Error:
   WriteEvent "RoundTo3", Err.Description, Err.Source
End Function

Public Function Time2Second(time As String) As Single
   On Error GoTo Error
   'edit seng 2005-08-19
   Dim splitTime() As String
   Dim splitSecs() As String
   Dim intHour As Long
   Dim intMinute As Long
   Dim hundreSecond As Single
   If time <> "" Then
      splitTime = Split(time, ":")
      If UBound(splitTime) > 1 Then
         intHour = splitTime(0)
         intMinute = splitTime(1)
         splitSecs = Split(splitTime(2), ".")
      Else
         intMinute = splitTime(0)
         splitSecs = Split(splitTime(1), ".")
      End If
      If UBound(splitSecs) > 0 Then hundreSecond = splitSecs(1) * 0.01
      Time2Second = hundreSecond + intMinute * 60 + intHour * 3600 + splitSecs(0)
   End If
   Exit Function
Error:
   WriteEvent "Time2Second", Err.Description, Err.Source
   Resume Next
End Function

Public Function GetDecimal(ByVal Value As Double) As Double
   On Error GoTo Error
   Dim myString As String
   Dim decimalPosition As Integer
   myString = CStr(Value)
   decimalPosition = InStrRev(myString, ".")
   If (decimalPosition > 0) And (Len(myString) - decimalPosition > 2) Then
      myString = left(myString, decimalPosition + 2)
   End If
   GetDecimal = CDbl(myString)
   Exit Function
Error:
   WriteEvent "GetDecimal", Err.Description, Err.Source
End Function
Public Function GetRenamedFile(strTrackTitle As String, strProduction As String, intProduction As Boolean, strAlbum As String, intAlbum As Boolean, intTrack As Integer, intTrackValue As Boolean) As String
   On Error GoTo Error
  Dim strTmp As String
  Const Dash = " - "
  If intProduction Then
    strTmp = strProduction + Dash
  End If
  If intAlbum Then
    strTmp = strTmp + strAlbum + Dash
  End If
  If intTrackValue Then
    strTmp = strTmp + Format(intTrack, "00") + Dash
  End If
  GetRenamedFile = strTmp + strTrackTitle
  'if
   Exit Function
Error:
   WriteEvent "GetRenamedFile", Err.Description, Err.Source
End Function

Public Function GetFileName(strFilePathName As String) As String
   On Error GoTo Error
  Dim i As Integer, lStrFileName As String, lStrDir As String
  Dim lStrAdded As String
  i = InStrRev(strFilePathName, "\") + 1
  lStrFileName = Mid(strFilePathName, i)
  lStrDir = left(strFilePathName, i - 1)
  i = 0
  While isFileExist(lStrDir + lStrAdded + lStrFileName)
    i = i + 1
    lStrAdded = Format(i, "00 ")
  Wend
  GetFileName = lStrDir + lStrAdded + lStrFileName
   Exit Function
Error:
   WriteEvent "GetFileName", Err.Description, Err.Source
End Function
