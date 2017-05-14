Attribute VB_Name = "BrowseFolder"
Option Explicit

Private Const BIF_RETURNONLYFSDIRS = 1
Private Const BIF_DONTGOBELOWDOMAIN = 2
Private Const BFFM_INITIALIZED = 1
Private Const BFFM_SELCHANGED = 2
Private Const MAX_PATH = 260
Private Const WM_USER = &H400
Private Const BFFM_SETSELECTION = (WM_USER + 102)
Private Const BFFM_SETSTATUSTEXT = (WM_USER + 100)

Private oldFolder As String

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function SHBrowseForFolder Lib "shell32" (lpbi As BrowseInfo) As Long
Private Declare Function SHGetPathFromIDList Lib "shell32" (ByVal pIDList As Long, ByVal lpBuffer As String) As Long
Private Declare Function lstrcat Lib "kernel32" Alias "lstrcatA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)


Private Type BrowseInfo
   hwndOwner      As Long
   pIDLRoot       As Long
   pszDisplayName As Long
   lpszTitle      As Long
   ulFlags        As Long
   lpfnCallback   As Long
   lParam         As Long
   iImage         As Long
End Type

Private Function BrowseCallbackProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal lp As Long, ByVal pData As Long) As Long
   On Error GoTo Error
   Dim szDir As String
   Dim lngDir As Long
   lngDir = lstrcat(oldFolder, "")
   
   Select Case uMsg
      Case BFFM_INITIALIZED
         Call SendMessage(hwnd, BFFM_SETSELECTION, True, lngDir)
   End Select
   Exit Function
Error:
   WriteEvent "BrowseCallbackProc", Err.Description, Err.Source
End Function
Private Function PathFromIDList(pIDList As Long) As String
   On Error GoTo Error
   If pIDList Then
      Dim sBuffer As String
      sBuffer = Space(MAX_PATH)
      SHGetPathFromIDList pIDList, sBuffer
      sBuffer = left(sBuffer, InStr(sBuffer, vbNullChar) - 1)
      PathFromIDList = sBuffer
   End If
   Exit Function
Error:
   WriteEvent "PathFromIDList", Err.Description, Err.Source
End Function

Public Function BrowseForFolder(setOldFolder, Optional hwndOwner As Long) As String
   On Error GoTo Error
'Opens a Treeview control that displays the directories in a computer

   Dim lpIDList As Long
   Dim sBuffer As String
   Dim szTitle() As Byte
   Dim tBrowseInfo As BrowseInfo
   Dim newFolder As String

   With tBrowseInfo
      If setOldFolder <> "" Then oldFolder = setOldFolder
      .hwndOwner = hwndOwner
      '.lpszTitle = VarPtr(szTitle(0))  'lstrcat(szTitle, "")
      '.pszDisplayName = lstrcat(szTitle, "Hello")
      .ulFlags = BIF_RETURNONLYFSDIRS
      .lpfnCallback = s(AddressOf BrowseCallbackProc)
      
   End With
   lpIDList = SHBrowseForFolder(tBrowseInfo)
   BrowseForFolder = PathFromIDList(lpIDList)
   
   Exit Function
Error:
   WriteEvent "getFolder", Err.Description, Err.Source
End Function
Private Function s(functionaddress As Long) As Long
   s = functionaddress
End Function

