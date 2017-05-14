VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classUserLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private prv_XmlPath As String
Private prv_XmlServer As String

Public Property Let UserLoginPath(vNewValue As String)
   prv_XmlPath = vNewValue
End Property
Public Property Get UserLoginPath() As String
   UserLoginPath = prv_XmlPath
End Property
Public Property Let LinkingPlayListPath(vNewValue As String)
   prv_XmlServer = vNewValue
End Property
Public Property Get LinkingPlayListPath() As String
   LinkingPlayListPath = prv_XmlServer
End Property
Public Property Get LinkingName() As String
   LinkingName = "SlyLinkingPlayList"
End Property
Public Function AddUser(arg_LoginName As String, arg_Password As String, Optional arg_FirstName As String, Optional arg_LastName As String, _
                        Optional arg_Age As String, Optional arg_Gender As String, Optional arg_Email As String) As Boolean
                           
   On Error GoTo ErrorAddingUser
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlUser As IXMLDOMElement
   Dim loc_PlayList As String
   
   If (arg_LoginName = "" Or UserLoginPath = "") Then Exit Function
   XmlDoc.Load UserLoginPath
      Set xmlRoot = XmlDoc.firstChild
      If xmlRoot Is Nothing Then
         Set xmlRoot = XmlDoc.createElement("Users")
         XmlDoc.appendChild xmlRoot
      End If
      Set xmlUser = XmlDoc.selectSingleNode("Users/User[@LoginName='" & arg_LoginName & "']")
      If xmlUser Is Nothing Then
         Set xmlUser = XmlDoc.createElement("User")
         xmlUser.setAttribute "LoginName", arg_LoginName
         xmlUser.setAttribute "Password", arg_Password
         xmlUser.setAttribute "FirstName", arg_FirstName
         xmlUser.setAttribute "LastName", arg_LastName
         xmlUser.setAttribute "Age", arg_Age
         xmlUser.setAttribute "Gender", arg_Gender
         xmlUser.setAttribute "Email", arg_Email
         xmlRoot.appendChild xmlUser
         loc_PlayList = fso.BuildPath(LinkingPlayListPath, arg_LoginName)
         If Not fso.FolderExists(loc_PlayList) Then fso.CreateFolder loc_PlayList
         'if folder not exist
         XmlDoc.Save UserLoginPath
      Else           'already exist so don't change it return false
         AddUser = False
         Exit Function
      End If
   AddUser = True              'Adding user success
   Exit Function
ErrorAddingUser:
   WriteEvent "AddUser", Err.Description, Err.Source
End Function

Public Function EditUser(arg_LoginName As String, arg_Password As String, Optional arg_FirstName As String, _
                        Optional arg_LastName As String, Optional arg_Age As Integer, _
                        Optional arg_Gender As String, Optional arg_Email As String) As Boolean
   On Error GoTo ErrorAddingUser
   Dim XmlDoc As New DOMDocument
   Dim xmlRoot As IXMLDOMElement
   Dim xmlUser As IXMLDOMElement
   
   If (arg_LoginName = "" Or UserLoginPath = "") Then Exit Function
   XmlDoc.Load UserLoginPath
      Set xmlUser = XmlDoc.selectSingleNode("Users/User[@LoginName='" & arg_LoginName & "']")
      If Not xmlUser Is Nothing Then
         xmlUser.setAttribute "LoginName", arg_LoginName
         xmlUser.setAttribute "Password", arg_Password
         xmlUser.setAttribute "FirstName", arg_FirstName
         xmlUser.setAttribute "LastName", arg_LastName
         xmlUser.setAttribute "Age", arg_Age
         xmlUser.setAttribute "Gender", arg_Gender
         xmlUser.setAttribute "Email", arg_Email
         XmlDoc.Save UserLoginPath
      Else           'already exist so don't change it return false
         
         EditUser = False
         Exit Function
      End If
   EditUser = True               'Adding user success
   Exit Function
ErrorAddingUser:
   Debug.Print "Error adding user name to xml " & vbNewLine & Err.Description
End Function



Public Function IsUserExist(arg_LoginName As String, arg_Password As String) As Boolean
   On Error GoTo ErrorAddingUser
   Dim XmlDoc As New DOMDocument, xmlRoot As IXMLDOMElement, xmlUser As IXMLDOMElement
   Dim loc_PlayListPath As String
   
   If (arg_LoginName = "" Or UserLoginPath = "") Then Exit Function
   XmlDoc.Load UserLoginPath
   Set xmlUser = XmlDoc.selectSingleNode("Users/User[@LoginName='" & arg_LoginName & "' and @Password='" & arg_Password & "']")
   If Not xmlUser Is Nothing Then
      IsUserExist = True
   End If
   Exit Function
ErrorAddingUser:
   Debug.Print "Error adding user name to xml " & vbNewLine & Err.Description
End Function







