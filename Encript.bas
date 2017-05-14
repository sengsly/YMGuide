Attribute VB_Name = "Encript"
Option Explicit
Public Type swfDateType
   days As Byte
   months As Byte
   years As Integer
End Type

Public Function GetScreenDate(screenFile As String) As Date
   On Error GoTo Error
   Dim handleFile As Integer
   Dim swfDate As swfDateType
   
   handleFile = FreeFile
   Open screenFile For Binary As handleFile
      Get handleFile, 1, swfDate
      GetScreenDate = DateSerial(swfDate.years, swfDate.months, swfDate.days)
   Close handleFile
   Exit Function
Error:
   WriteEvent "GetScreenDate", Err.Description, Err.Source
End Function

Public Function EncrypHeaders(filename As String, lensize As Integer, Encrypt As Boolean, EncryptDate As String) As Boolean
   On Error GoTo Error
   Dim handleFile As Integer
   Dim stringRead As String
   Dim swfDate As swfDateType
   Dim varChar(3) As Byte

   handleFile = FreeFile
   stringRead = String(lensize, 0)

   Open filename For Binary As handleFile
      Get handleFile, 5, stringRead
      stringRead = EncryptString(stringRead, Encrypt)
      Put handleFile, 5, stringRead
      If Encrypt = True Then
         Put handleFile, 1, EncryptDate
      Else
         EncryptDate = String(4, 0)
         Get handleFile, 1, EncryptDate
         varChar(0) = &H43
         varChar(1) = &H57
         varChar(2) = &H53
         varChar(3) = &H6
         Put handleFile, 1, varChar
      End If
   Close handleFile
   Exit Function
Error:
   WriteEvent "EncrypHeaders", Err.Description, Err.Source
End Function

Public Function EncryptString(StringSource As String, Encrypt As Boolean) As String
   On Error GoTo Error
   Dim i As Integer
   Dim stringChange As String
   Dim character As String
   Dim characterAscii As Integer
   Dim intIncrease As Integer
   
   If Encrypt Then intIncrease = 1 Else intIncrease = -1
   For i = 1 To Len(StringSource)
      characterAscii = Asc(Mid(StringSource, i, 1))
      characterAscii = characterAscii + intIncrease
      If characterAscii < 0 Then characterAscii = 256 + characterAscii
      If characterAscii > 255 Then characterAscii = characterAscii Mod 256
      character = Chr(characterAscii)
      stringChange = stringChange & character
   Next
   EncryptString = stringChange
   Exit Function
Error:
   WriteEvent "EncryptString", Err.Description, Err.Source
End Function
Public Sub LoadSwf(object As ShockwaveFlashObjectsCtl.ShockwaveFlash, filename As String)
   On Error GoTo Error
   Dim stringDate As String
   EncrypHeaders filename, 30, False, stringDate
   object.Movie = filename
   EncrypHeaders filename, 30, True, stringDate
   sendToFlash object, "default", str_infoPopup
   run_TimeHidePassed = 0
   Exit Sub
Error:
   WriteEvent "LoadSwf", Err.Description, Err.Source
End Sub

Public Function EncrypHeader(filename As String, lensize As Integer, Encrypt As Boolean) As Boolean
   On Error GoTo Error
   Dim handleFile As Integer
   Dim stringRead As String

   handleFile = FreeFile
   stringRead = String(lensize, 0)

   Open filename For Binary As handleFile
      Get handleFile, 1, stringRead
      stringRead = EncryptString(stringRead, Encrypt)
      Put handleFile, 1, stringRead
   Close handleFile
   Exit Function
Error:
   WriteEvent "EncrypHeader", Err.Description, Err.Source
End Function

Public Function ConvertToArray(strArray As String) As Byte()
   On Error GoTo Error
   ConvertToArray = strArray
   Exit Function
Error:
   WriteEvent "ConvertToArray", Err.Description, Err.Source
End Function


