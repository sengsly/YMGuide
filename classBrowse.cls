VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classBrowse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private PV_strBrowseFolder As String
Private PV_fso As New FileSystemObject

Private PV_MovieActor As New DOMDocument
Private PV_MovieLanguage As New DOMDocument
Private PV_MovieGenre As New DOMDocument
'Private PV_MovieSubtitle As New DOMDocument
Private PV_MovieTitle As New DOMDocument
Private PV_MovieTrack As New DOMDocument

Private PV_TableLanguage As New TableCls
Private PV_TableGenre As New TableCls
Private PV_TableSubTitle As New TableCls
Private PV_TableActor As New TableCls


Private Const PC_MovieArtist = "MovieActor.xml"
Private Const PC_MovieLanguage = "MovieLanguage.xml"
Private Const PC_MovieGenre = "MovieGenre.xml"
'Private Const PC_MovieSubtitle = "MovieSubtitle.xml"
Private Const PC_MovieTitle = "MovieTitle.xml"
Private Const PC_MovieTrack = "MovieTrack.xml"

Public Property Let GP_Browse(varValue As String)

   PV_strBrowseFolder = PV_fso.BuildPath(varValue, "\")
   SetDirectory GP_Browse                    'Set default directory for table
   
   PV_MovieActor.Load GP_Browse & PC_MovieArtist
   PV_MovieLanguage.Load GP_Browse & PC_MovieLanguage
   PV_MovieGenre.Load GP_Browse & PC_MovieGenre
   'PV_MovieSubtitle.Load GP_Browse & PC_MovieSubtitle
   PV_MovieTitle.Load GP_Browse & PC_MovieTitle
   PV_MovieTrack.Load GP_Browse & PC_MovieTrack
   
   PV_TableLanguage.Opens "Language"
   PV_TableSubTitle.Opens "Subtitle"
   PV_TableGenre.Opens "Genre"
   PV_TableActor.Opens "Actor"
   
End Property

Public Property Get GP_Browse() As String
   GP_Browse = PV_strBrowseFolder
End Property

Private Sub Class_Initialize()
   GP_Browse = App.path
End Sub

'''''''Public Function MovieGetRole(movieID As Long, actorID As Long) As String
'''''''   'Get Role Name of each movie from the artist ID
'''''''   'Return Role Name as String
'''''''   Dim xmlElement As IXMLDOMElement
'''''''
'''''''   If PV_MovieActor.parseError.ErrorCode = 0 Then
'''''''      Set xmlElement = PV_MovieActor.selectSingleNode("MovieActor/ID[@m='" & movieID & "' and @a='" & actorID & "']")
'''''''      If Not xmlElement Is Nothing Then
'''''''         MovieGetRole = xmlElement.getAttribute("r")      'r=role
'''''''      End If
'''''''   End If
'''''''End Function
''Public Function MovieGetSubTitles(movieID As Long) As Variant
''   Dim xmlList As IXMLDOMNodeList
''   Dim xmlElement As IXMLDOMElement
''   Dim var_Return() As Variant
''   Dim ID As Long
''   Dim i As Long
''
''   ReDim var_Return(-1 To -1)
''   If PV_MovieSubtitle.parseError.ErrorCode = 0 Then
''
''      Set xmlList = PV_MovieSubtitle.selectNodes("MovieSubtitle/ID[@m='" & movieID & "']")
''      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
''      For Each xmlElement In xmlList
''         ID = xmlElement.getAttribute("s")
''         With PV_TableGenre
''            If .Seeks(ID) >= 0 Then
''               var_Return(i) = Array(.Field("Name"), .Field("Unicode"))
''            End If
''         End With
''         i = i + 1
''      Next
''   End If
''   'return 2 dimensional array
''   MovieGetSubTitles = var_Return
''End Function
Public Function MovieGetLanguages(movieID As Long) As Variant
   Dim xmlList As IXMLDOMNodeList
   Dim xmlElement As IXMLDOMElement
   Dim var_Return() As Variant
   Dim ID As Long
   Dim i As Long
   
   ReDim var_Return(-1 To -1)
   If PV_MovieLanguage.parseError.ErrorCode = 0 Then
      
      Set xmlList = PV_MovieLanguage.selectNodes("MovieLanguage/ID[@m='" & movieID & "']")
      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
      For Each xmlElement In xmlList
         ID = xmlElement.getAttribute("l")
         With PV_TableLanguage
            If .Seeks(ID) >= 0 Then
               var_Return(i) = Array(ID, .Field("Name"), .Field("Unicode"))
            End If
         End With
         i = i + 1
      Next
   End If
   'return 2 dimensional array
   MovieGetLanguages = var_Return
End Function

Public Function MovieGetGenres(movieID As Long) As Variant
   Dim xmlList As IXMLDOMNodeList
   Dim xmlElement As IXMLDOMElement
   Dim var_Return() As Variant
   Dim ID As Long
   Dim i As Long
   
   ReDim var_Return(-1 To -1)
   If PV_MovieGenre.parseError.ErrorCode = 0 Then
      
      Set xmlList = PV_MovieGenre.selectNodes("MovieGenre/ID[@m='" & movieID & "']")
      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
      For Each xmlElement In xmlList
         ID = xmlElement.getAttribute("g")
         With PV_TableGenre
            If .Seeks(ID) >= 0 Then
               var_Return(i) = Array(ID, .Field("Name"), .Field("Unicode"))
            End If
         End With
         i = i + 1
      Next
   End If
   'return 2 dimensional array
   MovieGetGenres = var_Return
End Function
'''''''Public Function MovieGetActors(movieID As Long) As Variant
'''''''   Dim xmlList As IXMLDOMNodeList
'''''''   Dim xmlElement As IXMLDOMElement
'''''''   Dim var_Return() As Variant
'''''''   Dim ID As Long
'''''''   Dim i As Long
'''''''
'''''''   ReDim var_Return(-1 To -1)
'''''''   If PV_MovieGenre.parseError.ErrorCode = 0 Then
'''''''      Set xmlList = PV_MovieActor.selectNodes("MovieActor/ID[@m='" & movieID & "']")
'''''''      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
'''''''      For Each xmlElement In xmlList
'''''''         ID = xmlElement.getAttribute("a")
'''''''         With PV_TableActor
'''''''            If .Seeks(ID) >= 0 Then
'''''''               var_Return(i) = Array(ID, .Field("Name"), .Field("Unicode"))
'''''''            End If
'''''''         End With
'''''''         i = i + 1
'''''''      Next
'''''''   End If
'''''''   'return 2 dimensional array
'''''''   MovieGetActors = var_Return
'''''''End Function
Public Function MovieGetTitles(movieID As Long) As Variant
   Dim xmlList As IXMLDOMNodeList
   Dim xmlElement As IXMLDOMElement
   Dim var_Return() As Variant
   Dim ID As Long
   Dim i As Long
   
   ReDim var_Return(-1 To -1)
   If PV_MovieTitle.parseError.ErrorCode = 0 Then
      Set xmlList = PV_MovieTitle.selectNodes("MovieTitle/ID[@m='" & movieID & "']")
      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
      For Each xmlElement In xmlList
         ID = xmlElement.getAttribute("t")
         var_Return(i) = Array(ID, xmlElement.getAttribute("n"), xmlElement.getAttribute("v"))
         i = i + 1
      Next
   End If
   'return 2 dimensional array
   MovieGetTitles = var_Return
End Function
Public Function MovieGetTracks(titleID As Long) As Variant
   Dim xmlList As IXMLDOMNodeList
   Dim xmlElement As IXMLDOMElement
   Dim var_Return() As Variant
   Dim ID As Long
   Dim i As Long
   
   ReDim var_Return(-1 To -1)
   If PV_MovieTrack.parseError.ErrorCode = 0 Then
      Set xmlList = PV_MovieTrack.selectNodes("MovieTrack/ID[@t='" & titleID & "']")
      If xmlList.Length > 0 Then ReDim var_Return(-1 To xmlList.Length - 1)
      For Each xmlElement In xmlList
         ID = xmlElement.getAttribute("r")
         var_Return(i) = Array(ID)
         i = i + 1
      Next
   End If
   'return 2 dimensional array
   MovieGetTracks = var_Return
End Function

