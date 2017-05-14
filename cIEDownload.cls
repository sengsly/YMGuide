VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cIEDownload"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Event onCompleted(lpFile As cFile, Success As Boolean)
Event onStartDownload()


Private mDownloadFiles As New Collection
Private mDownloadFile As cFile
Private mDownloading As Boolean
Private WithEvents mInet As Inet
Attribute mInet.VB_VarHelpID = -1
Private Const INTERNET_FLAG_NO_CACHE_WRITE = &H4000000
Private Const AD_SAVECREATE_OVERWRITE = &H2
Private Const HTTP_QUERY_CONTENT_LENGTH = 5
Private Const HTTP_QUERY_FLAG_NUMBER = &H20000000
Private Const BUFFER_LENGTH As Long = 255
Private Const DOWNLOAD_BUFFER_SIZE = 512
Private Const HTTP_QUERY_STATUS_CODE = 19
Private mDownloadBytes As Long
Private mDownloadSize As Long

'=================Thread constant
Private Const CTF_COINIT = &H8
Private Const CTF_INSIST = &H1
Private Const CTF_PROCESS_REF = &H4
Private Const CTF_THREAD_REF = &H2


Private Declare Function InternetOpen Lib "wininet.dll" Alias "InternetOpenA" (ByVal lpszAgent As String, ByVal dwAccessType As Long, ByVal lpszProxyName As String, ByVal lpszProxyBypass As String, ByVal dwFlags As Long) As Long
Private Declare Function InternetReadBinaryFile Lib "wininet.dll" Alias "InternetReadFile" (ByVal hFile As Long, ByRef bytearray_firstelement As Byte, ByVal lNumBytesToRead As Long, ByRef lNumberOfBytesRead As Long) As Long
Private Declare Function InternetOpenUrl Lib "wininet.dll" Alias "InternetOpenUrlA" (ByVal hInternetSession As Long, ByVal sUrl As String, ByVal sHeaders As String, ByVal lHeadersLength As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal hInet As Long) As Long
Private Declare Function HttpQueryInfo Lib "wininet.dll" Alias "HttpQueryInfoA" (ByVal hhttpRequest As Long, ByVal lInfoLevel As Long, ByRef sBuffer As Any, ByRef lBufferLength As Long, ByRef lIndex As Long) As Integer
Private Declare Function SHCreateThread Lib "shlwapi.dll" (ByVal pfnThreadProc As Long, pData As Any, ByVal dwFlags As Long, ByVal pfnCallback As Long) As Long

Public Function getDownloadedBytes() As Long
   getDownloadedBytes = mDownloadBytes
End Function
   
Public Function getDownloadSize() As Long
   getDownloadSize = mDownloadSize
End Function
'Open downloadSoftData.targetPath & downloadSoftData.targetName For Binary As fileNumber
Private Sub inetDownload(sUrl As String)
'''Exit Sub
  With mInet
      RaiseEvent onStartDownload
       '.RequestTimeout = 3                 'if the internet is slow it make error occur
       .url = sUrl
       Debug.Print sUrl
      .Execute , "Get"
   End With
   
End Sub
'''Private Sub DownloadBinaryFiles(sUrl As String, filePath As String)
'''   On Error GoTo Error:
'''
'''   Dim hInternet As Long, hSession As Long, lngDataReturned As Long, sBuffer() As Byte, totalRead As Long
'''   Dim lStatusCode As Long
'''   Dim lFreeFile As Integer
'''   Dim iReadFileResult  As Long
'''   ReDim sBuffer(DOWNLOAD_BUFFER_SIZE)
'''
'''   mDownloadBytes = 0
'''   Downloading = True
'''   hSession = InternetOpen("", 0, vbNullString, vbNullString, 0)
'''   If hSession Then hInternet = InternetOpenUrl(hSession, sUrl, vbNullString, 0, INTERNET_FLAG_NO_CACHE_WRITE, 0)
'''
'''   lStatusCode = val(QueryInfoName(hInternet, HTTP_QUERY_STATUS_CODE))
'''   lFreeFile = FreeFile
'''   If hInternet And lStatusCode = 200 Then
'''      DeleteFile filePath
'''      Open filePath For Binary As lFreeFile
'''      iReadFileResult = InternetReadBinaryFile(hInternet, sBuffer(0), UBound(sBuffer) - LBound(sBuffer), lngDataReturned)
'''      ReDim Preserve sBuffer(lngDataReturned - 1)
'''      mDownloadBytes = mDownloadBytes + lngDataReturned
'''      Put lFreeFile, , sBuffer
'''      ReDim sBuffer(DOWNLOAD_BUFFER_SIZE)
'''      totalRead = totalRead + lngDataReturned
'''      DoEvents
'''      Do While lngDataReturned <> 0
'''         If bExitingProgram Then GoTo Error           'if exiting program then exit with error
'''         iReadFileResult = InternetReadBinaryFile(hInternet, sBuffer(0), UBound(sBuffer) - LBound(sBuffer), lngDataReturned)
'''         If lngDataReturned = 0 Then Exit Do
'''         ReDim Preserve sBuffer(lngDataReturned - 1)
'''         Put lFreeFile, , sBuffer
'''         ReDim sBuffer(DOWNLOAD_BUFFER_SIZE)
'''         totalRead = totalRead + lngDataReturned
'''         DoEvents
'''      Loop
'''      Close lFreeFile
'''      CompleteDownload True
'''   Else
'''      CompleteDownload False
'''   End If
'''
'''   Call InternetCloseHandle(hInternet)
'''   Downloading = False
'''   Exit Sub
'''Error:
'''   CompleteDownload False
'''   Downloading = False
'''End Sub
Private Sub CompleteDownload(bSuccess As Boolean)
   RaiseEvent onCompleted(mDownloadFiles.item(1), bSuccess)
   Debug.Print "Remove..."
   mDownloadFiles.Remove (1)
End Sub
Public Function StartDownload() As Boolean
   Dim mDownloadingFile As cFile
   
   
   
   If Not Downloading And DownloadItemCount > 0 Then       'if not download so start immediately
      Set mDownloadingFile = mDownloadFiles.item(1)
      If mDownloadingFile.LocalDownload Then
         CompleteDownload False
      Else        'Download from Internet
'''         SHCreateThread AddressOf , ByVal 0&, CTF_INSIST, ByVal 0&
'''         DownloadBinaryFile mDownloadingFile.url, mDownloadingFile.DesFile
            Downloading = True
            inetDownload mDownloadingFile.url
      End If
   End If
End Function
Public Sub Initialize(lpINET As Inet)
   Set mInet = lpINET
End Sub
Public Function AddDownloadItem(lpItem As cFile) As Boolean
   mDownloadFiles.Add lpItem
End Function

Public Property Get DownloadItemCount() As Long
   DownloadItemCount = mDownloadFiles.count
End Property

Public Property Get Downloading() As Boolean
   Downloading = mDownloading
End Property
Public Property Let Downloading(vNewValue As Boolean)
   mDownloading = vNewValue
End Property

Public Property Get DownloadFile() As cFile
   Set DownloadFile = mDownloadFiles.item(1)
End Property

Private Function QueryInfoName(hInternet As Long, HTTP_CODE As Long) As String
   Dim strBuffer As String * BUFFER_LENGTH
   Dim intBufferLength As Long
   Dim lngIndex As Long
   Dim intResult As Long

   intBufferLength = BUFFER_LENGTH
   
   If HttpQueryInfo(hInternet, HTTP_CODE, ByVal strBuffer, intBufferLength, lngIndex) <> 0 Then
      QueryInfoName = left(strBuffer, intBufferLength)
   End If
End Function

Private Sub mInet_StateChanged(ByVal State As Integer)
   Dim filePath As String
   Dim lFreeFile As Integer
   Dim vtData As String
   Dim vArray() As Byte
   
On Error GoTo ErrorDownloading:
   Dim tempSaveImage As String
   Select Case State
   Case icError
      CompleteDownload False
      
   Case icResponseCompleted
      If mInet.GetHeader("Content-Type") <> "application/xml" Then
         Set mDownloadFile = mDownloadFiles.item(1)
         mDownloadBytes = 0
         mDownloadSize = mInet.GetHeader("Content-Length")
         lFreeFile = FreeFile
         filePath = mDownloadFile.DesFile
         DeleteFile filePath
         Open filePath For Binary As lFreeFile
         
         vtData = mInet.GetChunk(DOWNLOAD_BUFFER_SIZE, icByteArray)
         Do While (Len(vtData) > 0) And (Not bExitingProgram)
             vArray = vtData
             mDownloadBytes = mDownloadBytes + Len(vtData)
             Put lFreeFile, , vArray
             vtData = mInet.GetChunk(DOWNLOAD_BUFFER_SIZE, icByteArray)
             DoEvents
   
         Loop
         Close lFreeFile
         mDownloadBytes = 0
         If bExitingProgram Then CompleteDownload False Else CompleteDownload True
         Downloading = False
      Else
         mDownloadBytes = 0
         CompleteDownload False
         Downloading = False
      
      End If
      
   End Select
   Exit Sub
ErrorDownloading:
   CompleteDownload False
   Downloading = False

End Sub
