VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsWinsock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private objWinsock As Object
Private WithEvents objClient As Winsock
Attribute objClient.VB_VarHelpID = -1
Public clientCount As Long
Public socketMaxBound As Long
Public LoggedType As EnumPlayListMode
Public serverMainPath As String
Public StreamFile As Boolean
Public serverName As String             'Name of the server machinePublic streamFile As Boolean
Public serverID As String
Public serverNickName As String
Public waitCommandString As String
Public clientIndex As Integer
Public connectName As String
Public ClientMusicLoaded As Long        'the count of client connected
Public LoginInName As String           'for login when in Remotecontrol

Private m_FirstClientIndex As Integer     ' < 0 = nothing

Private Type SendingQueueType
   Send2All As Boolean
   Index As Integer
   Data2Send As Variant
   boolSend2Client As Boolean
   boolRequesting As Boolean
End Type

Private DataClientQueue() As SendingQueueType
Private DataSendProgress As Boolean
Private DataSendIndex As Integer


Public Enum EnumPlayListMode
   notConnected = -1
   ServerMode = 0
   cloneDisplay = 1
   remotePlaylist = 2
   remoteControl = 3
   independentMode = 4
   independentServer = 32
'''   serverMode = 1
'''   cloneDisplay = 2
'''   remotePlaylist = 4
'''   remoteControl = 8
'''   independentMode = 16

End Enum

Private Type ClientInfo
   ID As String
   NickName As String
   ClientLoggedType As EnumPlayListMode
   timeLogged As Variant
End Type
Private Clients() As ClientInfo
'For download music from server

'=============================================================================
'For downloading file from client
Public Enum WinsockDownloadEnum
   WS_COPYTO = 1
   WS_CLOSESAVEFILE = 2
   WS_TRANSFERDATA = 3
   WS_REQUESTNEXTDATA = 4
   WS_CLOSEOPENFILE = 5
   WS_OPENSAVENAME = 6
   WS_COMMAND = 7
   WS_COPYFROM = 8
   WS_REQUESTSAVE = 9
   WS_COPYNOTFOUND = 10
   WS_REQUESTING = 11
   WS_RESPONSE = 12
End Enum
Public MAXREAD   As Long
Private file_OPEN As Integer
Private file_SAVE As Integer
Private file_COMM As String
'=============================================================================



Public Sub Closes(Index As Integer, Optional errorSending As Boolean)
   On Error GoTo Error
   Dim i As Integer, timeLogged As Variant, firstTime As Variant
   Dim loc_iIndexFirstLogged As Integer
   CBrowse.RemoveClientAvailable CWinsock.ClientID(Index)
   UnloadSocket Index
   If IsClientFirstLogged(Index) Then              'if disconnect socket is first logged one
      For i = 1 To UBound(Clients)
         If ClientType(i) <> notConnected Then
            timeLogged = ClientTimeLogged(Index)
         End If
         If timeLogged <> "" Then
            If (timeLogged < firstTime) Or firstTime = "" Then          'Date-Time compare
               firstTime = timeLogged
               loc_iIndexFirstLogged = i
            End If
         End If
      Next
      m_FirstClientIndex = loc_iIndexFirstLogged
   End If
   If DataSendProgress And DataSendIndex = Index Then SendComplete Index
   Exit Sub
Error:
   WriteEvent "Closes", Err.Description, Err.Source
End Sub

Public Function ReadClientData(Index As Integer) As String
   On Error GoTo Error
   Dim byteRead() As Byte
   ReDim byteRead(objWinsock(Index).BytesReceived - 1)
   
   objWinsock(Index).GetData byteRead, vbByte + vbArray
   ReadClientData = byteRead
   Exit Function
Error:
   WriteEvent "ReadClientData", Err.Description, Err.Source
End Function
Public Function ReadServerData() As String
   On Error GoTo Error
   Dim byteRead() As Byte
   ReDim byteRead(objClient.BytesReceived - 1)
   
   objClient.GetData byteRead, vbByte + vbArray
   ReadServerData = byteRead
   Exit Function
Error:
   WriteEvent "ReadServerData", Err.Description, Err.Source
End Function
Public Sub SendProgress()
   DataSendProgress = True
End Sub
Public Sub ConnectServer(serverName As String)
   On Error GoTo Error
 If objClient.State <> sckConnected And objClient.State <> sckConnecting Then
   objClient.Connect serverName
 Else
     sendToFlash FrmMain.Swf(IndexSwf), "not_connected", "true"
 End If
   Exit Sub
Error:
   WriteEvent "ConnectServer", Err.Description, Err.Source
End Sub

Public Sub SendComplete(Index As Integer)
   On Error GoTo Error
   DataSendProgress = False
   SendDataNow
   Exit Sub
Error:
   WriteEvent "SendComplete", Err.Description, Err.Source
End Sub

Public Sub Error(Index As Integer, ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)

End Sub
Public Sub Initialize(pServer, pClient)
   On Error GoTo Error
   If objWinsock Is Nothing Then Set objWinsock = pServer
   If objClient Is Nothing Then Set objClient = pClient
   ReDim Preserve Clients(-1 To -1)
   ReDim Preserve DownloadMusicQueue(-1 To -1)
   
   Exit Sub
Error:
   WriteEvent "Initialize", Err.Description, Err.Source
End Sub
Public Sub Listen()
   On Error GoTo Error:
   If Not (objWinsock(0).State = sckListening) Then
      objWinsock(0).Listen
   End If
   Exit Sub
Error:
   WriteEvent "Listen", Err.Description, Err.Source & vbTab & Err.Source
End Sub

Public Sub LoadSocket(Index As Integer, requestID As Long)
   On Error GoTo Error
   
   If objWinsock(Index) Is Nothing Then
      Load objWinsock(Index)
   End If
   objWinsock(Index).Accept requestID
   
   Exit Sub
Error:
   WriteEvent "LoadSocket", Err.Description, Err.Source
End Sub
Public Sub ConnectionRequest(ByVal requestID As Long)
   On Error GoTo Error
   Dim newSocket As Long
   newSocket = LoadNextSocket(requestID)
   ReDim Preserve Clients(-1 To socketMaxBound)
   Clients(newSocket).ClientLoggedType = notConnected
   Exit Sub
Error:
   WriteEvent "ConnectionRequest", Err.Description, Err.Source
End Sub
Public Function isValidIndex(Index As Integer) As Boolean
   On Error GoTo Error
   isValidIndex = isValidObject(objWinsock(Index))
   Exit Function
Error:
   WriteEvent "isValidIndex", Err.Description, Err.Source
End Function

Public Sub Send2Client(scCommand As WinsockDownloadEnum, Index As Integer, Data As String)
On Error GoTo ErrorObjNotExist
   Dim addedIndex As Integer
   '(ClientType = serverMode) And
   If clientCount > 0 Then            'send only when it is connected
      addedIndex = AddItemQue(Index, Data, True, scCommand)
      If addedIndex >= 0 And DataSendProgress = False Then SendComplete 0
   End If
ErrorObjNotExist:
End Sub

Public Sub Send2Server(scCommand As WinsockDownloadEnum, Data As String)
On Error GoTo ErrorObjNotExist
   Dim addedIndex As Integer
   If FrmMain.sckClient.State = sckConnected Then            'only send to server if it is connected
      addedIndex = AddItemQue(0, Data, False, scCommand)
      If addedIndex >= 0 And DataSendProgress = False Then SendComplete 0
   End If
ErrorObjNotExist:
End Sub

Public Function SendDirect2Client(Index As Integer, Data As Variant, boolRequesting As Boolean) As Boolean
   On Error GoTo ErrorSend:

   If (isValidIndex(Index) And (ClientType(Index) <> notConnected Or boolRequesting)) Then
      DataSendProgress = True
      FrmMain.sckServer(Index).SendData Data
      DataSendIndex = Index
      SendDirect2Client = True
   Else
      DataSendProgress = False
   End If
   Exit Function
ErrorSend:
   DataSendProgress = False
   SendDirect2Client = False
End Function

Public Function SendDirect2Server(Data As Variant) As Boolean
   On Error GoTo ErrorSend
   DataSendProgress = True
   SendDirect2Server = True
   FrmMain.sckClient.SendData Data
   Exit Function
ErrorSend:
   DataSendProgress = False
   SendDirect2Server = False

End Function

Private Sub UnloadSocket(Index As Integer)
   On Error GoTo Error
   If socketMaxBound >= Index Then
      objWinsock(Index).Close
      Unload objWinsock(Index)
      Clients(Index).ClientLoggedType = notConnected
      clientCount = clientCount - 1
   End If
   
   If Index >= socketMaxBound Then
      socketMaxBound = Index - 1
   End If
   If IndexSwf = 4 Then sendVariable2Flash FrmMain.Swf(4), "clientCount", clientCount
   If clientCount <= 0 Then FrmMain.tmrPlayTrackDelay.Interval = 10 Else FrmMain.tmrPlayTrackDelay.Interval = 800
   Exit Sub
Error:
   WriteEvent "UnloadSocket", Err.Description, Err.Source
End Sub

Public Function LoadNextSocket(requestID As Long) As Long
   On Error GoTo Error
   'return the socket that doesn't used
   Dim i As Integer
   For i = 1 To socketMaxBound
      If Not isValidIndex(i) Then
         Exit For
      End If
   Next
   clientCount = clientCount + 1
   If IndexSwf = 4 Then sendVariable2Flash FrmMain.Swf(4), "clientCount", clientCount
   Load objWinsock(i)
   If i > socketMaxBound Then socketMaxBound = i
   objWinsock(i).Accept requestID
   LoadNextSocket = i
   If clientCount <= 0 Then FrmMain.tmrPlayTrackDelay.Interval = 10 Else FrmMain.tmrPlayTrackDelay.Interval = 800
   Exit Function
Error:
   WriteEvent "LoadNextSocket", Err.Description, Err.Source
End Function

Private Sub Class_Initialize()
   On Error GoTo Error
   MAXREAD = 512
   LoggedType = ServerMode
   ReDim DataClientQueue(-1 To -1)
   Exit Sub
Error:
   WriteEvent "Class_Initialize", Err.Description, Err.Source
End Sub

Private Sub objClient_Close()
   On Error GoTo Error
   If objClient.State = sckClosing Then objClient.Close
   Exit Sub
Error:
   WriteEvent "objClient_Close", Err.Description, Err.Source
End Sub

Private Sub objClient_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
   On Error GoTo Error
   If objClient.State = sckError Then objClient.Close
   Exit Sub
Error:
   WriteEvent "objClient_Error", Err.Description, Err.Source
End Sub
Public Function isValidObject(obj As Object) As Boolean
On Error GoTo ErrorObj:
   Dim Name As String
   Name = obj
   isValidObject = True
   Exit Function
ErrorObj:
   isValidObject = False
End Function
Private Sub SendDataNow()
   On Error GoTo Error
   Dim boolSendSuccess As Boolean
   Dim boolSend2All As Boolean
   Dim boolSend2Client As Boolean
   
   If UBound(DataClientQueue) >= 0 Then
   
      boolSend2All = DataClientQueue(0).Send2All
      boolSend2Client = DataClientQueue(0).boolSend2Client
      
      If boolSend2All Then
         DataClientQueue(0).Index = DataClientQueue(0).Index + 1
      End If
      
      If (DataClientQueue(0).Index > socketMaxBound) Then
         RemoveItemQue 0
         SendDataNow
         Exit Sub
      End If
      
      If boolSend2Client Then
         boolSendSuccess = SendDirect2Client(DataClientQueue(0).Index, DataClientQueue(0).Data2Send, DataClientQueue(0).boolRequesting)
      Else
         boolSendSuccess = SendDirect2Server(DataClientQueue(0).Data2Send)
      End If
      
      If Not boolSend2All Then
         'if reach the maximum of it then remove
         RemoveItemQue 0
      End If

      If Not boolSendSuccess Then
         SendDataNow
      End If

   End If
   Exit Sub
Error:
   WriteEvent "SendDataNow", Err.Description, Err.Source
End Sub

Private Function RemoveItemQue(index2Remove As Long) As Long
   On Error GoTo Error
   Dim i As Long, itemPreserve As SendingQueueType
   'Dim boolMoved As Boolean
   Dim itemsMax As Long
   
   itemsMax = UBound(DataClientQueue)
   If itemsMax >= index2Remove Then
      For i = index2Remove + 1 To itemsMax
         DataClientQueue(i - 1) = DataClientQueue(i)
      Next
      ReDim Preserve DataClientQueue(-1 To itemsMax - 1)
   End If
   Exit Function
Error:
   WriteEvent "RemoveItemQue", Err.Description, Err.Source
End Function

Private Function AddItemQue(Index As Integer, Data As String, boolClient As Boolean, CommandType As WinsockDownloadEnum) As Long
   On Error GoTo Error
   Dim itemsMax As Long

   itemsMax = UBound(DataClientQueue) + 1
   
   ReDim Preserve DataClientQueue(-1 To itemsMax)
   
   
   
   With DataClientQueue(itemsMax)
      ' .Data2Send = Data
      'MakeSendString(scCommand, Data)
      .Data2Send = MakeSendString(CommandType, Data)
      .Index = Index
      .boolRequesting = CommandType = WS_REQUESTING
      .Send2All = (.Index = 0) And (boolClient = True)
      .boolSend2Client = boolClient
   End With
   AddItemQue = itemsMax
   Exit Function
Error:
   WriteEvent "AddItemQue", Err.Description, Err.Source
End Function
Public Property Let ClientID(Index As Integer, newValue As String)
   On Error GoTo Error
   Clients(Index).ID = newValue
   Exit Property
Error:
   WriteEvent "Let ClientID", Err.Description, Err.Source
End Property

Public Property Get ClientID(Index As Integer) As String
   On Error GoTo Error
   ClientID = Clients(Index).ID
   Exit Property
Error:
   WriteEvent "Get ClientID", Err.Description, Err.Source
End Property
Public Property Let ClientNickName(Index As Integer, newValue As String)
   On Error GoTo Error
   Clients(Index).NickName = newValue
   Exit Property
Error:
   WriteEvent "Let ClientNickName", Err.Description, Err.Source
End Property

Public Property Get ClientNickName(Index As Integer) As String
   On Error GoTo Error
   ClientNickName = Clients(Index).NickName
   Exit Property
Error:
   WriteEvent "Get ClientNickName", Err.Description, Err.Source
End Property

Public Property Let ClientType(Index As Integer, newValue As EnumPlayListMode)
   On Error GoTo Error
   Clients(Index).ClientLoggedType = newValue
   Exit Property
Error:
   WriteEvent "Let ClientType", Err.Description, Err.Source
End Property
Public Property Get ClientType(Index As Integer) As EnumPlayListMode
On Error GoTo ErrorReadClient:
   Dim itemValue As EnumPlayListMode
   itemValue = Clients(Index).ClientLoggedType
   'itemValue = FrmMain.sckServer(Index).Tag
   
   'If itemValue = "" Then GoTo ErrorReadClient
   
   ClientType = itemValue
   Exit Property
ErrorReadClient:
   ClientType = notConnected
End Property
Public Sub sendToServerNotConnected(ind As Integer, strSend As String)
   On Error GoTo Error
    Dim bChangeType As Boolean
    If CWinsock.ClientType(ind) = notConnected Then
       CWinsock.ClientType(ind) = remotePlaylist
       bChangeType = True
    End If
    CWinsock.Send2Client WS_COMMAND, ind, strSend
    If bChangeType Then
       bChangeType = False
       CWinsock.ClientType(ind) = notConnected
    End If

   Exit Sub
Error:
   WriteEvent "sendToServerNotConnected", Err.Description, Err.Source
End Sub

Public Function ReadDataFromWinsock(winsockObj As Winsock) As String
   On Error GoTo Error
   Dim readData As String
   winsockObj.GetData readData
   ReadDataFromWinsock = readData
   Exit Function
Error:
   WriteEvent "ReadDataFromWinsock", Err.Description, Err.Source
End Function
Private Sub Send2ClientOrServer(sckCommand As WinsockDownloadEnum, Index As Integer, SendString As String)
   On Error GoTo Error
   If Index = 0 Then
      Send2Server sckCommand, SendString
   Else
      Send2Client sckCommand, Index, SendString
   End If
   Exit Sub
Error:
   WriteEvent "Send2ClientOrServer", Err.Description, Err.Source
End Sub

Public Sub SendCopy(sckCommand As WinsockDownloadEnum, Index As Integer, Optional ByVal Data As String)
   On Error GoTo Error
      'if index=0 mean server
      Dim filename As String
      Dim dataRead As String
      Dim bytesLeft As Long
      Dim data_Split() As String
      Select Case sckCommand
      Case WS_COPYTO
         data_Split = Split(Data, FileDelimiter, 3)
         filename = getQueryString(data_Split(0))  ' getQueryString(data_Split(1))
         
         If isFileExist(filename) Then
            file_OPEN = FreeFile
            Open filename For Binary Access Read As file_OPEN
            Send2ClientOrServer WS_OPENSAVENAME, Index, data_Split(1) & FileDelimiter & file_OPEN & FileDelimiter & data_Split(2)
         Else
            Send2ClientOrServer WS_COMMAND, Index, data_Split(2)
         End If
      Case WS_COPYNOTFOUND
         CopyingSong = False
      Case WS_COPYFROM
         data_Split = Split(Data, FileDelimiter, 3)
         file_COMM = data_Split(2)
         Send2ClientOrServer WS_COPYTO, Index, data_Split(1) & FileDelimiter & data_Split(0) & FileDelimiter & file_COMM
      Case WS_REQUESTSAVE
         data_Split = Split(Data, FileDelimiter, 4)
         file_OPEN = FreeFile
         file_SAVE = data_Split(1)
         file_COMM = data_Split(2)
         filename = SlyVariable(data_Split(0))
         
         Open filename For Binary As file_OPEN
         SendCopy WS_REQUESTNEXTDATA, Index, file_OPEN & FileDelimiter & file_SAVE & FileDelimiter & file_COMM
      Case WS_REQUESTNEXTDATA
         data_Split = Split(Data, FileDelimiter)
         file_OPEN = data_Split(0)
         file_SAVE = data_Split(1)
         file_COMM = data_Split(2)
         
         bytesLeft = LOF(file_OPEN) - Seek(file_OPEN) + 1
         
         If bytesLeft - MAXREAD > 0 Then
            dataRead = String(MAXREAD, 0)
         ElseIf bytesLeft >= 0 Then
            dataRead = String(bytesLeft, 0)
         Else
            dataRead = ""
         End If
         
         Get file_OPEN, , dataRead
         
         dataRead = file_OPEN & FileDelimiter & file_SAVE & FileDelimiter & file_COMM & FileDelimiter & dataRead
         
         If bytesLeft - MAXREAD > 0 Then
            'if there more data to read
            Send2ClientOrServer WS_TRANSFERDATA, Index, dataRead
         Else
            Send2ClientOrServer WS_CLOSESAVEFILE, Index, dataRead
            Close file_OPEN
         End If
      Case WS_OPENSAVENAME
         data_Split = Split(Data, FileDelimiter)
         If UBound(data_Split) = 2 Then 'cause "Data" variable lost string
            filename = getQueryString(data_Split(0))
            
            file_COMM = data_Split(2)
            file_OPEN = data_Split(1)
            
            If filename <> "" Then
            
               DeleteFile filename
               CreateDirectory fso.GetParentFolderName(filename)
               file_SAVE = FreeFile
               
               Open filename For Binary As file_SAVE
               
               Send2ClientOrServer WS_REQUESTNEXTDATA, Index, file_OPEN & FileDelimiter & file_SAVE & FileDelimiter & file_COMM
               'request for next data
            End If
        End If
      Case WS_TRANSFERDATA
         '2 indicate file data to be saved
         data_Split = Split(Data, FileDelimiter, 4)
         
         file_OPEN = data_Split(0)
         file_SAVE = data_Split(1)
         file_COMM = data_Split(2)
         
         Put file_SAVE, , data_Split(3)      '2 equal to data area
         Send2ClientOrServer WS_REQUESTNEXTDATA, Index, file_OPEN & FileDelimiter & file_SAVE & FileDelimiter & file_COMM
      Case WS_CLOSESAVEFILE
         '2 indicate file data to be saved
         data_Split = Split(Data, FileDelimiter, 4)
         
         file_OPEN = data_Split(0)
         file_SAVE = data_Split(1)
         file_COMM = data_Split(2)
         
         
         Put file_SAVE, , data_Split(3)
         Close file_SAVE
         If file_COMM <> "" Then
            If Index = 0 Then
               FrmMain.ReceivedClient WS_COMMAND, file_COMM
            Else
               FrmMain.ReceivedServer Index, WS_COMMAND, file_COMM
            End If
         End If
      End Select
   Exit Sub
Error:
   WriteEvent "SendCopy", Err.Description, Err.Source
End Sub
Public Property Get isServerConnected() As Boolean
   On Error GoTo Error
   isServerConnected = clientCount > 0 And LoggedType = ServerMode
   Exit Property
Error:
   WriteEvent "Get isServerConnected", Err.Description, Err.Source
End Property
Public Function getClonePlayBackCounts() As Integer
   On Error GoTo Error
   Dim iFound As Integer, i As Integer
   
   For i = 1 To socketMaxBound
      '2006-05-27
      If ((ClientType(i) = cloneDisplay) Or (ClientType(i) = remotePlaylist)) And ClientType(i) <> notConnected Then
         'beside independentmode are cloneplayback
         iFound = iFound + 1
      End If
   Next
   getClonePlayBackCounts = iFound
   Exit Function
Error:
   WriteEvent "getClonePlayBackCounts", Err.Description, Err.Source
End Function
Public Property Get getRemoteHostIP(remoteName As String) As String
   On Error GoTo Error
   Dim i As Integer
   If LoggedType = ServerMode Then
      For i = 1 To socketMaxBound
         If isValidIndex(i) Then
            If StrComp(CWinsock.ClientID(i), remoteName, vbTextCompare) = 0 Then
               getRemoteHostIP = FrmMain.sckServer(i).RemoteHostIP
               Exit For
            End If
         End If
      Next
   Else
      getRemoteHostIP = FrmMain.sckClient.RemoteHostIP                 'set to server
   End If
   Exit Property
Error:
   WriteEvent "Get getRemoteHostIP", Err.Description, Err.Source
End Property

Function getIndexServer(serverName As String) As Integer
   On Error GoTo Error
   Dim serverIndex As Long
   Dim i As Integer
   
   serverIndex = -1 'for not found
   If LoggedAs(ServerMode) Or LoggedAs(independentServer) Then
      For i = 1 To socketMaxBound
         If isValidIndex(i) Then
            If CWinsock.ClientID(i) = serverName Then
               serverIndex = i
               Exit For
            End If
         End If
      Next
      If serverName = CWinsock.serverID Then serverIndex = 0                  'set to server
   Else
      If serverName = CWinsock.serverID Then serverIndex = 0                  'set to server
   End If
   getIndexServer = serverIndex
   Exit Function
Error:
   WriteEvent "getIndexServer", Err.Description, Err.Source
End Function
Function getNameServer(serverID As String) As String
   On Error GoTo Error
   Dim serverNick As String
   Dim i As Integer
   
   serverNick = "" 'for not found
   
   If LoggedType = ServerMode Then
      For i = 1 To socketMaxBound
         If isValidIndex(i) Then
            If CWinsock.ClientID(i) = serverID Then
               serverNick = CWinsock.ClientNickName(i)
               Exit For
            End If
         End If
      Next
   Else
      If serverID = CWinsock.serverID Then serverNick = CWinsock.serverName                   'set to server
   End If
   getNameServer = serverNick
   Exit Function
Error:
   WriteEvent "getNameServer", Err.Description, Err.Source
End Function

Public Sub AddMusicDownload(Language As String, TrackID As String, ToTrackPath As String, FromTrackPath As String, RemoteServer As String, TrackTitle As String)
   On Error GoTo Error
   Dim maxDownload As Long, i As Long
   For i = 0 To UBound(DownloadMusicQueue)
      If DownloadMusicQueue(i).Language = Language And DownloadMusicQueue(i).TrackID = TrackID Then
         'if it already exist in download queue then exit sub
         Exit Sub
      End If
   Next
   If CopyingSong And DownloadingMusic.Language = Language And DownloadingMusic.TrackID = TrackID Then Exit Sub
   maxDownload = UBound(DownloadMusicQueue) + 1
   ReDim Preserve DownloadMusicQueue(-1 To maxDownload)
   With DownloadMusicQueue(maxDownload)
      .Language = Language
      .TrackID = TrackID
      .ToTrackPath = ToTrackPath
      .FromTrackPath = FromTrackPath
      .RemoteServer = RemoteServer
      .TrackTitle = TrackTitle
   End With
   If boolCopying = False Then StartDownloadItem False
   Exit Sub
Error:
   WriteEvent "AddMusicDownload", Err.Description, Err.Source
End Sub
Public Sub StartDownloadItem(removeItem As Boolean)
   On Error GoTo Error
   Dim indexFromServer As Integer
   Dim i As Long
   Static loopingTrackCount As Boolean
   
   If UBound(DownloadMusicQueue) >= 0 Then
      
      DownloadingMusic = DownloadMusicQueue(0)
      With DownloadingMusic
         indexFromServer = getIndexServer(.RemoteServer)
         If indexFromServer >= 0 Then
            boolCopying = True
            BackgroundCopyFile .FromTrackPath, .ToTrackPath, .Language, .TrackID, indexFromServer
         Else
            CWinsock.RemoveDownloadingMusic False
         End If
      End With
      FrmMain.tmr_startPlay.Enabled = True                     'Enable to make it play song that is playing
   Else
      'if downloading is finished         ' test to see if there is any track that is available for download
      If Settings.boolDownloadAll And CopyingSong = False And loopingTrackCount = False Then
         loopingTrackCount = True
         For i = 0 To int_track_count - 1
            DoEvents
            If PlayTrackInfo(i).infoNotFilled Then
               CWinsock.Send2Server WS_COMMAND, "requestTrackInfoForDownload&&&" & i
               loopingTrackCount = False
               Exit Sub
            Else
               PlayTrackFromIndex i
            End If
         Next
         loopingTrackCount = False
         trackCountRefreshed = False                     'don't make it try to loop again unless track is changed
      End If
   End If
   Exit Sub
Error:
   WriteEvent "StartDownloadItem", Err.Description, Err.Source
End Sub
Public Sub RemoveDownloadingMusic(removeAll As Boolean)
   On Error GoTo Error
   Dim i As Long, j As Long
   
   If removeAll Then
      ReDim Preserve DownloadMusicQueue(-1 To -1)
   Else
      If UBound(DownloadMusicQueue) >= 0 Then
         For i = 1 To UBound(DownloadMusicQueue)
            DownloadMusicQueue(i - 1) = DownloadMusicQueue(i)
         Next
         ReDim Preserve DownloadMusicQueue(-1 To UBound(DownloadMusicQueue) - 1)
      End If
   End If
   Exit Sub
Error:
   WriteEvent "RemoveDownloadingMusic", Err.Description, Err.Source
End Sub

Public Sub BackgroundCopyFile(Optional pFrom As String, Optional pTo As String, Optional Language As String, Optional ByVal TrackID As String, Optional serverIndex As Integer)
   On Error GoTo Error
   DLIndex = int_current_index
   CopyingSong = True
   Send2ClientOrServer WS_COMMAND, serverIndex, "requestCopyFile&&&" & pFrom & "&&&" & pTo & "&&&" & CInt(b_ReEncode)
   Exit Sub
Error:
   WriteEvent "BackgroundCopyFile", Err.Description, Err.Source
End Sub
Public Function isClientLogged(userName As String) As String
   On Error GoTo Error
   Dim i As Integer
   Dim loggedUsers As String
   Dim boolLogged As Boolean
   
   loggedUsers = SlyNickName
   If StrComp(SlyNickName, userName, vbTextCompare) = 0 Then boolLogged = True      'Compare with server
   For i = 1 To socketMaxBound
      If isValidIndex(i) And ClientType(i) <> notConnected Then
         loggedUsers = loggedUsers & "||" & ClientID(i)
         If StrComp(ClientID(i), userName, vbTextCompare) = 0 Then boolLogged = True
      End If
   Next
   If boolLogged Then isClientLogged = loggedUsers
   Exit Function
Error:
   WriteEvent "isClientLogged", Err.Description, Err.Source
End Function

Public Property Get LoggedAs(enumClientType As EnumPlayListMode) As Boolean
   On Error GoTo Error
   If enumClientType = independentServer Then
      LoggedAs = (LoggedType = independentMode And clientCount > 0)
   Else
      LoggedAs = (LoggedType = enumClientType)
   End If
   Exit Property
Error:
   WriteEvent "Get LoggedAs", Err.Description, Err.Source
End Property
Public Property Get ClientTimeLogged(Index As Integer) As Variant
   ClientTimeLogged = Clients(Index).timeLogged
ErrorGetClientTimeLogged:
End Property
Public Property Let ClientTimeLogged(Index As Integer, vNewValue As Variant)
On Error GoTo ErrorSetClientTimeLogged
   Clients(Index).timeLogged = vNewValue
   If m_FirstClientIndex = 0 Then m_FirstClientIndex = Index               'First client logged
ErrorSetClientTimeLogged:
End Property
Public Property Get IsClientFirstLogged(Index As Integer) As Boolean
   On Error GoTo Error
   If (Index > 0) And (m_FirstClientIndex > 0) Then
      IsClientFirstLogged = (Index = m_FirstClientIndex)
   Else
      IsClientFirstLogged = False
   End If
   Exit Property
Error:
   WriteEvent "Get IsClientFirstLogged", Err.Description, Err.Source
End Property
Public Property Get GetNumberOfConnected() As Integer
   On Error GoTo Error
   'Find number of client(connected) logged to server
   Dim i As Integer, iFoundCount As Integer
   For i = 1 To socketMaxBound
      If Clients(i).ClientLoggedType <> notConnected Then
         iFoundCount = iFoundCount + 1
      End If
   Next
   GetNumberOfConnected = iFoundCount
   Exit Property
Error:
   WriteEvent "Get GetNumberOfConnected", Err.Description, Err.Source
End Property
