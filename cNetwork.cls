VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cNetwork"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents UDP_Client As Winsock
Attribute UDP_Client.VB_VarHelpID = -1
Dim WithEvents UDP_Server As Winsock
Attribute UDP_Server.VB_VarHelpID = -1

Event ServerFound(pIP As String, pName As String, pPort As Long)

   
Const MAX_IP = 20 'To make a buffer... i dont think you have more than 10 ip on your pc..
Const DiscoveryPort = 8888
Const ResponsePort = DiscoveryPort + 1
'''Const DiscoveryPort = 49215
'''Const ResponsePort = DiscoveryPort + 1

Private Type IPINFO
    dwAddr As Long ' IP address
    dwIndex As Long ' interface index
    dwMask As Long ' subnet mask
    dwBCastAddr As Long ' broadcast address
    dwReasmSize As Long ' assembly size
    unused1 As Integer ' not currently used
    unused2 As Integer '; not currently used
End Type


Private Type MIB_IPADDRTABLE
    dEntrys As Long 'number of entries in the table
    mIPInfo(MAX_IP) As IPINFO 'array of IP address entries
End Type

Private Type IP_Array
    mBuffer As MIB_IPADDRTABLE
    BufferLen As Long
End Type

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function GetIpAddrTable Lib "IPHlpApi" (pIPAdrTable As Byte, pdwSize As Long, ByVal Sort As Long) As Long


Private Function getipRange(lpIP As String, lpMask As String, rStartIP() As Byte, rEndIP() As Byte) As Boolean
    Dim bSplit As Variant
    Dim bIP(3) As Byte
    Dim bMask(3) As Byte
    Dim BNET(3) As Byte
    Dim BCAST(3) As Byte
    
  
    
    bSplit = Split(lpIP, ".")
    bIP(0) = val(bSplit(0))
    bIP(1) = val(bSplit(1))
    bIP(2) = val(bSplit(2))
    bIP(3) = val(bSplit(3))
    
    bSplit = Split(lpMask, ".")
    bMask(0) = val(bSplit(0))
    bMask(1) = val(bSplit(1))
    bMask(2) = val(bSplit(2))
    bMask(3) = val(bSplit(3))
    
    BNET(0) = bIP(0) And bMask(0)
    BNET(1) = bIP(1) And bMask(1)
    BNET(2) = bIP(2) And bMask(2)
    BNET(3) = bIP(3) And bMask(3)
    
    
    BCAST(0) = BNET(0) Or (Not bMask(0))
    BCAST(1) = BNET(1) Or (Not bMask(1))
    BCAST(2) = BNET(2) Or (Not bMask(2))
    BCAST(3) = BNET(3) Or (Not bMask(3))
    
    rStartIP = BNET
    rEndIP = BCAST

    
End Function



Private Function convertDecToIP(ip0, ip1, ip2, ip3) As Long
   convertDecToIP = val("&H" & Format(Hex(ip0), "00") & Format(Hex(ip1), "00") & Format(Hex(ip2), "00") + Format(Hex(ip3), "00"))
End Function



'converts a Long to a string
Private Function ConvertAddressToString(longAddr As Long) As String
    Dim myByte(3) As Byte
    Dim Cnt As Long
    CopyMemory myByte(0), longAddr, 4
    For Cnt = 0 To 3
        ConvertAddressToString = ConvertAddressToString + CStr(myByte(Cnt)) + "."
    Next Cnt
    ConvertAddressToString = left$(ConvertAddressToString, Len(ConvertAddressToString) - 1)
End Function
Public Function InitializeSocket(sckClient As Winsock, sckServer As Winsock) As Boolean
   Set UDP_Client = sckClient
   Set UDP_Server = sckServer
End Function

Public Function ClientScanServer(IP As String) As Boolean
   
   With UDP_Client
      .Close
      DoEvents          ' let have time to response
      '.SendData "RequestServer;" & .LocalHostName
      sendRequest IP, MakeSendString(WS_REQUESTING, "RequestServer" & de_Record & ComputerName & de_Record & ComputerIP)
   End With
'''
'''   With UDP_Client
'''      .Close
'''      DoEvents          ' let have time to response
'''      .Protocol = sckUDPProtocol
'''      .RemoteHost = IP
'''      .LocalPort = DiscoveryPort
'''      .RemotePort = ResponsePort
'''      '.SendData "RequestServer;" & .LocalHostName
'''      .SendData MakeSendString(WS_REQUESTING, "RequestServer" & de_Record & ComputerName & de_Record & ComputerIP)
'''   End With
End Function

Public Function ServerListen() As Boolean
   With UDP_Server
        .Close
'''        .Protocol = sckUDPProtocol
'''        .LocalPort = DiscoveryPort
'''        .RemotePort = ResponsePort
'''        .Bind ResponsePort
         .Protocol = sckUDPProtocol
        .Bind DiscoveryPort
   End With
   With UDP_Client
      .Close
      .Protocol = sckUDPProtocol
      .RemotePort = DiscoveryPort
'''      .RemoteHost = IP
'''      .RemotePort = 8086
'''      .SendData txt
   End With
   
End Function
Private Function getIPMask(lpIP As String) As String
    Dim Ret As Long, i As Long
    Dim bBytes() As Byte
    Dim Listing As MIB_IPADDRTABLE
    Dim locIP As String
    Dim locMask As String
    
    On Error GoTo Errors:
    GetIpAddrTable ByVal 0&, Ret, True
    
    If Ret <= 0 Then Exit Function
    ReDim bBytes(0 To Ret - 1) As Byte
    GetIpAddrTable bBytes(0), Ret, False
    
    CopyMemory Listing.dEntrys, bBytes(0), 4
    'MsgBox "IP's found : " & Listing.dEntrys => Founded ip installed on your PC..
    For i = 0 To Listing.dEntrys - 1
        CopyMemory Listing.mIPInfo(i), bBytes(4 + (i * Len(Listing.mIPInfo(0)))), Len(Listing.mIPInfo(i))
        locIP = ConvertAddressToString(Listing.mIPInfo(i).dwAddr)
        If locIP = lpIP Then
            getIPMask = ConvertAddressToString(Listing.mIPInfo(i).dwMask)
            Exit Function
        End If
    Next
    Exit Function
Errors:
    Debug.Print "Error"
End Function

Private Function getIPBroadcast() As String         ' get all the broadcast IP
   Dim Ret As Long, i As Integer
   Dim bBytes() As Byte
   Dim Listing As MIB_IPADDRTABLE
   Dim locBcast As String
   Dim retBroadcast As String
   
   On Error GoTo Errors
   GetIpAddrTable ByVal 0&, Ret, True
   
   If Ret <= 0 Then Exit Function
   ReDim bBytes(0 To Ret - 1) As Byte
   GetIpAddrTable bBytes(0), Ret, False
    
   CopyMemory Listing.dEntrys, bBytes(0), 4
   For i = 0 To Listing.dEntrys - 1
      CopyMemory Listing.mIPInfo(i), bBytes(4 + (i * Len(Listing.mIPInfo(0)))), Len(Listing.mIPInfo(i))
      locBcast = ConvertAddressToString(Listing.mIPInfo(i).dwBCastAddr)
      If retBroadcast = "" Then retBroadcast = locBcast Else retBroadcast = retBroadcast & ";" & locBcast
   Next
   getIPBroadcast = retBroadcast
   Exit Function
Errors:
    Debug.Print "Error"
End Function

Private Function scanMachine(localIP As String, feedbackObj As Object, feedbackFunction As String) As Boolean
   Dim locipMask As String
   Dim bStart() As Byte
   Dim bEnd() As Byte
   Dim i As Long
   Dim ipA As Integer, ipB As Integer, ipC As Integer, ipD As Integer
   
   locipMask = getIPMask(localIP)
   
   If locipMask <> vbNullString Then
      Call getipRange(localIP, locipMask, bStart, bEnd)
      
      
      ipA = bStart(0)
      ipB = bStart(1)
      ipC = bStart(2)
      ipD = bStart(3)
      
      Do
         ipD = ipD + 1
         If ipD > 255 Then
            ipD = 0
            ipC = ipC + 1
         End If
         If ipC > 255 Then
            ipC = 0
            ipB = ipB + 1
         End If
         If ipB > 255 Then
            ipB = 0
            ipA = ipA + 1
         End If
         CallByName feedbackObj, feedbackFunction, VbMethod, ipA & "." & ipB & "." & ipC & "." & ipD
         DoEvents
         If (ipA = bEnd(0)) And ((ipB = bEnd(1)) And (ipC = bEnd(2)) And (ipD = bEnd(3))) Then
            Exit Do
         End If
      Loop While (ipA < 255 And ipA <= bEnd(0))
   End If
End Function



Private Sub UDP_Client_DataArrival(ByVal bytesTotal As Long)
'''   Dim strData As String
'''   Dim returnDataType As CommandType
'''   Dim eachData As String
'''   Dim splData As Variant
'''   Dim lpComputerIP As String
'''   Dim lpComputerName As String
'''   Dim lpComputerPort As Long
'''
'''   UDP_Client.GetData strData
'''   returnDataType = GetCommandAndDataLength(left(strData, 3))
'''   eachData = StrConv(Mid(strData, 4), vbFromUnicode)
'''   If returnDataType.Commands = WS_RESPONSE Then
'''      splData = Split(eachData, de_Record)
'''      Select Case splData(0)
'''         Case "ResponseServer"
'''            lpComputerName = splData(1)
'''            lpComputerIP = splData(2)
'''            lpComputerPort = val(splData(3))
'''            If lpComputerName <> ComputerName Then       'if not own host
'''               RaiseEvent ServerFound(lpComputerIP, lpComputerName, lpComputerPort)
'''            Else
'''               Debug.Print "Received from own broadcast"
'''            End If
'''      End Select
'''   End If
End Sub

Private Function sendRequest(ByVal IP As String, ByVal txt As String) As Boolean
   With UDP_Client
      .Close
      '.Protocol = sckUDPProtocol
      '.RemotePort = DiscoveryPort
      .RemoteHost = IP
      .SendData txt
   End With
End Function

Private Sub UDP_Server_DataArrival(ByVal bytesTotal As Long)
   Dim strData As String
   Dim splData As Variant
   Dim eachData As String
   Dim returnDataType As CommandType
   Dim lpComputerIP As String
   Dim lpComputerName As String
   Dim lpComputerPort As Long
   
   
   UDP_Server.GetData strData
   returnDataType = GetCommandAndDataLength(left(strData, 3))
   eachData = StrConv(Mid(strData, 4), vbFromUnicode)
   splData = Split(eachData, de_Record)
   
   Select Case splData(0)
   Case "RequestServer"
      'sendRequest
      sendRequest splData(2), MakeSendString(WS_RESPONSE, "ResponseServer" & de_Record & ComputerName & de_Record & ComputerIP & de_Record & UDP_Server.LocalPort)
      'UDP_Server.SendData MakeSendString(WS_RESPONSE, "ResponseServer" & de_Record & ComputerName & de_Record & ComputerIP & de_Record & UDP_Server.LocalPort)
      'Debug.Print "Server Data received =" & strData
   Case "ResponseServer"
      lpComputerName = splData(1)
      lpComputerIP = splData(2)
      lpComputerPort = val(splData(3))
      If lpComputerName <> ComputerName Then       'if not own host
         RaiseEvent ServerFound(lpComputerIP, lpComputerName, lpComputerPort)
      Else
         Debug.Print "Received from own broadcast"
      End If
   End Select
End Sub



