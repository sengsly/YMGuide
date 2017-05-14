Attribute VB_Name = "SerialMod"
Option Explicit

Private Declare Function GetVolumeInformation Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Long, lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long) As Long
Public Const AvailableChar = "ZcFxQy3jmsMoeKlraJGNwz9dIb2P6H4uEfSTg8YnvRi0UhWqV5XC1kBtpDOLA7", AllChar = "189A306B7CD2E45F", NewChar = "0123456789ABCDEF"
'Public Const AvailableChar = "cFQ3eKaJGNz9Ib2P6H4uEfST8YvR0UWV5eXC1kBtDA7"
Public Enum RegisterEnum
   NotRegistered = 0
   RegisterAsLinkingServer = 1                     'As Linking server
   RegisterAsRoomServer = 2                        'As Room Server
   RegisterAsRemoteControl = 4                     'As remote control
End Enum
'''Private Function GetSlyDVDDateKey() As String
'''   'HKEY_CLASSES_ROOT\CLSID\{00EFAEAA-BCDA-1EF1-EEDC-00AA006D2EA4}
'''   Dim lpResult As String
'''   Dim lpSerial As String
'''
'''   lpResult = "{00EFAEAA-BCDA-1EF1-EEDC-000000002EA4}"
'''   lpSerial = Hex(GetHardDiskSerial)
'''   Mid(lpResult, 26) = lpSerial
'''   GetSlyDVDDateKey = lpResult
'''End Function
'''Public Function GetSlyDVDInstallDateValue() As Date
'''   Dim loc_Value As String
'''   Dim loc_Path As String
'''   Dim loc_Year As Integer
'''   Dim loc_Month As Integer
'''   Dim loc_Day As Integer
'''
'''   Dim loc_PathDate As String
'''   Dim loc_PathSerial As String
'''
'''   loc_Path = "CLSID\" & GetSlyDVDDateKey
'''   loc_Value = SlyRegedit.GetKeyValue(HKEY_CLASSES_ROOT, loc_Path, "ThreadIDs", REG_SZ)
'''
'''   '' Print GetID("20061028")
'''   If loc_Value = "" Then
'''      loc_Year = Year(Date)
'''      loc_Month = Month(Date)
'''      loc_Day = Day(Date)
'''      'yyyy-hex(mm)-dd
'''      loc_Value = loc_Year & Hex(loc_Month) & Format(loc_Day, "00")
'''      loc_Value = loc_Value & GetID(loc_Value)
'''      SlyRegedit.SetKeyValue HKEY_CLASSES_ROOT, loc_Path, "ThreadIDs", loc_Value, REG_SZ
'''   Else
'''
'''   Else
'''
'''   End If
'''   GetSlyDVDInstallDateValue = DateSerial(loc_Year, loc_Month, loc_Day)
'''End Function

Private Function GetHardDiskSerial() As Long
   On Error GoTo Error
  Dim Name As String * 100, serial As Long
  Dim pathName As String, intSlashPos As Integer
  
   pathName = left(App.path, 3)
   GetVolumeInformation pathName, Name, 100, serial, 0, 0, Name, 100
   GetHardDiskSerial = serial
   Exit Function
Error:
   WriteEvent "GetHardDiskSerial", Err.Description, Err.Source
End Function
Private Function GetDateSerial(dates) As Long
   On Error GoTo Error
  Dim tmp As String
  tmp = Hex(val("&h" & Hex(Year(dates)) & Hex(Month(dates)) & "00") Or Day(dates))
  GetDateSerial = val("&h" & tmp)
   Exit Function
Error:
   WriteEvent "GetDateSerial", Err.Description, Err.Source
End Function
Public Function GetRegisterKeyClients() As Integer
   '10^3=1000
   'sxxxa00000000000000
   'First 1 Indicate server type
   'next
   Dim loc_strKey As String
   Dim loc_First4 As String
   Dim loc_Type As Integer
   Dim RegisterKey As String
   RegisterKey = ReadRegCode
   If Len(RegisterKey) = 22 Then          'Only available for 21
      If IsRegistered(RegisterKey) Then
         'loc_First5 = GetBackNumber(left(RegisterKey, 3))
         loc_First4 = Change(left(RegisterKey, 4), True)
         loc_Type = val(left(loc_First4, 1))
         If loc_Type = RegisterAsLinkingServer Or loc_Type = RegisterAsRoomServer Then
            GetRegisterKeyClients = val("&H" & Mid(loc_First4, 2))
         Else
            GetRegisterKeyClients = -1
         End If
      Else
         GetRegisterKeyClients = -1
      End If
   Else
      GetRegisterKeyClients = -1
   End If
End Function
Public Function GetRegisterKeyType() As RegisterEnum
   '16^3=1000
   'sxxxa00000000000000
   'First 1 Indicate server type
   'next
   Dim loc_strKey As String
   Dim loc_First4 As String
   Dim loc_Type As Integer
   Dim RegisterKey As String
   RegisterKey = ReadRegCode
   If Len(RegisterKey) = 22 Then            'Only available for 20
      If IsRegistered(RegisterKey) Then
         loc_First4 = Change(left(RegisterKey, 4), True)
         loc_Type = val(left(loc_First4, 1))
         GetRegisterKeyType = loc_Type
      Else
         GetRegisterKeyType = NotRegistered
      End If
   Else
      GetRegisterKeyType = NotRegistered
   End If
End Function
Public Function GetCurrentMachineID() As String
   On Error GoTo Error
  Dim i As Integer, tmpHard As String, tmpEncryptHardiskSerial As String
  
   tmpHard = Hex(GetHardDiskSerial)
   If Len(tmpHard) < 8 Then tmpHard = String(8 - Len(tmpHard), "0") & tmpHard
   If tmpHard <> "0" Then
      tmpEncryptHardiskSerial = ShiftChar(tmpHard)
      GetCurrentMachineID = ShiftChar("AEF1" & tmpEncryptHardiskSerial & GetBiosID)
   End If
   Exit Function
Error:
   WriteEvent "GetCurrentMachineID", Err.Description, Err.Source
End Function
Public Function GetID(strHex As String) As String
   On Error GoTo Error
   Dim i As Integer, tmp As String, firstInt  As Integer
   Dim char As String * 1, lastChar As Integer
   If Len(strHex) > 3 Then
      firstInt = SumHex(strHex)
      For i = 1 To Len(strHex)
        char = Mid(strHex, i, 1)
        If i > 1 Then firstInt = lastChar
        lastChar = ((i + firstInt + Asc(char)) Mod (Len(AvailableChar) - 1)) + 1
        tmp = tmp + Mid(AvailableChar, lastChar, 1)
      Next
      'GetID = Change(left(strHex, 3) & tmp, False)
      GetID = Change(left(strHex, 4), False) & tmp
   End If
   Exit Function
Error:
 '   WriteEvent "GetID", Err.Description, Err.Source
End Function
Public Function SumHex(HexValue As String) As Integer
   On Error GoTo Error
   Dim i As Integer, tmpSum As Integer
   Dim iByteChar As Integer
   For i = 1 To Len(HexValue)
      iByteChar = Asc(Mid(HexValue, i, 1))
      If iByteChar >= 48 And iByteChar <= 122 Then
         '0.......To..............z
         iByteChar = iByteChar - 47
      Else
         iByteChar = 0
      End If
      tmpSum = tmpSum + iByteChar + i * 2
   Next
   SumHex = (tmpSum Mod (Len(AvailableChar) - 1)) + 1
   Exit Function
Error:
   WriteEvent "SumHex", Err.Description, Err.Source
End Function

'''Private Function SumHex(HexValue As String) As Integer
'''   On Error GoTo Error
'''  Dim i As Integer, tmpSum As Integer
'''  For i = 1 To Len(HexValue)
'''    tmpSum = tmpSum + val("&H" & Mid(HexValue, i, 1)) * i
'''  Next
'''  SumHex = (tmpSum Mod (Len(AvailableChar) - 1)) + 1
'''   Exit Function
'''Error:
'''   WriteEvent "SumHex", Err.Description, Err.Source
'''End Function
Private Function GetBiosID() As String
   On Error GoTo Error
   Dim dates As String
   dates = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "HARDWARE\DESCRIPTION\System", "SystemBiosDate", REG_SZ)
   If dates = "" Then dates = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "Enum\Root\*PNP0C01\0000", "BiosDate", REG_SZ)
   If dates = "" Then dates = "06/07/2007"
   GetBiosID = Hex(Month(dates) + Day(dates) * 8)
   Exit Function
Error:
   'WriteEvent "GetBiosID", Err.Description, Err.Source
   Stop
End Function
Private Function ShiftChar(chars As String) As String
   On Error GoTo Error
  Dim i As Integer, n As Byte, strTmp As String
  For i = 1 To Len(chars)
    n = InStr(NewChar, Mid(chars, i, 1))
    strTmp = strTmp + Mid(AllChar, n, 1)
  Next
  ShiftChar = strTmp
   Exit Function
Error:
   WriteEvent "ShiftChar", Err.Description, Err.Source
End Function
Public Function GetFileDate() As String
   On Error GoTo errorOccur
   Dim sysObject As New FileSystemObject
   Dim systemFolder As String
   Dim sysFilePath As String
   Const formatDate = "mm-dd-yyyy"
   
   
   systemFolder = sysObject.GetSpecialFolder(1).path
   sysFilePath = systemFolder & "\" & "winsys.ini"
   
   'reading .EXE file
   'and c:\windows\system\debug.dll date
   'and regedit
   
   Dim oldTime As String, newTime As String, regDate As String
   
'   oldTime = Format(FileDateTime(App.path & "\" & App.EXEName & ".exe"), formatDate)
   
   newTime = Format(FileDateTime(sysFilePath), formatDate)                     'system folder
   
   regDate = Format(ReadRegDate(), formatDate)
   
'   If (oldTime = newTime) And (oldTime = regDate) Then
   If (newTime = regDate) And IsValidDate(sysFilePath) Then
      GetFileDate = regDate
   End If
errorOccur:
End Function
