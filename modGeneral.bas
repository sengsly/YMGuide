Attribute VB_Name = "modGeneral"
Option Explicit

Public UpdatePercent As Integer
Public pathUpdateDB As String
Private Type fileType
   tableName  As String
   fieldCount As Integer
   maxrecord As Long
End Type

Private Type HeaderType
   Language   As String
   tableCount As Integer
   RecordCount As Long
End Type

Public Type FavoriteType
   ID As Long
   Rank As Long
   Favorite As Integer
   Rating As Integer
End Type

Public Type HeaderTypes
  languageName As String * 20
  ArtistCount As Long
  AlbumCount As Long
  RecordCount As Long
End Type

Private Function LoadUpdateFile(filename As String) As String
   On Error GoTo Error
   Dim hfreefile As Integer
   Dim Header As HeaderType, record As fileType
   Dim i As Long, j As Long, k As Integer
   Dim varData() As Variant
   Dim languagePath As String
   Dim tblAll As New TableCls
   Dim maxLoop As Long
   
   'for progress bar
   Dim UnitPerPercent As Integer
   Dim StartPercent As Integer
   Dim AddedPercent As Integer
   Dim LoopCount  As Long
   Dim iSearchIndex As Long
   
   hfreefile = FreeFile
   UpdatePercent = 0
   
   
   Open filename For Binary As hfreefile
      Get hfreefile, , Header
      LoadUpdateFile = LCase(Header.Language)
      pathUpdateDB = SlyVariable("<" & Header.Language & "_dat>")
      languagePath = pathUpdateDB & "\Database"
      If languagePath <> "" Then
         SetDirectory languagePath
         For i = 0 To Header.tableCount - 1
            Get hfreefile, , record
            tblAll.Opens record.tableName
            ReDim varData(record.fieldCount - 1)
            For j = 1 To record.maxrecord
               LoopCount = LoopCount + 1
               UpdatePercent = (LoopCount / Header.RecordCount) * 99
               sendVariable2Flash FrmMain.swf(IndexSwf), "ProUpdate", UpdatePercent
               sendVariable2Flash FrmMain.swf(IndexSwf), "OpenFrame", "true"
               DoEvents
               Get hfreefile, , varData()
               iSearchIndex = tblAll.Seeks(CLng(varData(0)))
               If iSearchIndex < 0 Then
                  For k = 0 To UBound(varData)
                     If (tblAll.FIELDTYPE(k) = myInteger) Then
                        varData(k) = CInt(varData(k))
                     ElseIf (tblAll.FIELDTYPE(k) = MyLong) Then
                        varData(k) = CLng(varData(k))
                     End If
                  Next
                  tblAll.Add varData()
               Else
                  For k = 1 To UBound(varData)
                     tblAll.AbsoluteEdit(iSearchIndex, k) = varData(k)
'''                     If (tblAll.FIELDTYPE(k) = myInteger) Then
'''                        tblAll.AbsoluteEdit
'''                        varData(k) = CInt(varData(k))
'''                     ElseIf (tblAll.FIELDTYPE(k) = MyLong) Then
'''                        varData(k) = CLng(varData(k))
'''                     End If
                  Next
               End If
            Next
            tblAll.Closes
            Set tblAll = Nothing
         Next
      Else
         MsgBox "Error Getting country path"
      End If
   Close hfreefile
   UpdatePercent = 0
   Exit Function
Error:
   WriteEvent "LoadUpdateFile", Err.Description, Err.Source
End Function

Public Function UpdateDatabase(filename As String)
   On Error GoTo Error
   Dim Language As String
   Static Creating As Boolean
   
   If Creating Then Exit Function
   Creating = True
   If filename <> "" Then
      Language = LoadUpdateFile(filename)
      If Language = vbNullString Then MsgBox "Error reading file"
   End If
   sendVariable2Flash FrmMain.swf(IndexSwf), "CompletedUpdate", "true"
   sendVariable2Flash FrmMain.swf(IndexSwf), "OpenFrame", "true"
   Creating = False
   Exit Function
Error:
   WriteEvent "UpdateDatabase", Err.Description, Err.Source
End Function
Public Function GetFile(dlg As CommonDialog, filter As String) As String
   On Error GoTo Error
   Dim filename As String
'   Const TBL_FILTER = "Update File|*.upd"

   With dlg
      .filter = filter
      .flags = cdlOFNHideReadOnly
      .filename = vbNullString
      .ShowOpen
      GetFile = .filename
   End With
   Exit Function
Error:
   WriteEvent "GetFile", Err.Description, Err.Source
End Function

Sub SaveSlideshowPaths(args As String, SlidePath As String)
   On Error GoTo Error
   Dim spl() As String
   Dim path As String
   Dim albumID As String
   Dim Language As String
   Dim t As IXMLDOMElement
   Dim t1 As IXMLDOMElement
   Dim i As Integer
   spl = Split(args, "%~%")
   albumID = spl(0)
   Language = spl(1)
   'path = FrmMain.AllCountryArray(language) & "\Database"
   path = get_country_path(Language) & "\Database"
    
   If Dir(path & "\" & "SlideshowPaths.xml") = "" Then
      CreateNewFile path, "SlideshowPaths", "SlideshowPath"
   End If
   Set xmlTrack = New DOMDocument
   xmlTrack.Load path & "\" & "SlideshowPaths.xml"
   Set xmlTrackRoot = xmlTrack.firstChild
   '................
   Set t1 = xmlTrack.selectSingleNode("SlideshowPaths/SlideshowPath[@AlbumId = '" & albumID & "']")
   If Not t1 Is Nothing Then
         t1.setAttribute "Path", SlidePath
         xmlTrack.Save path & "\" & "SlideshowPaths.xml"
         Exit Sub
   End If
   '.................
   Set xmlTrackName = xmlTrack.createElement("SlideshowPath")
   xmlTrackName.setAttribute "AlbumId", albumID
   xmlTrackName.setAttribute "Path", SlidePath
   xmlTrackRoot.appendChild xmlTrackName
   xmlTrack.Save path & "\" & "SlideshowPaths.xml"
   Exit Sub
Error:
   WriteEvent "SaveSlideshowPaths", Err.Description, Err.Source
End Sub
Sub GetSlideshowPath(Lan As String, albumID As String)
   On Error GoTo Error
    If syn = False Or CWinsock.LoggedAs(ServerMode) Then
        On Error Resume Next
        Dim path As String
        Dim t As IXMLDOMElement
        Dim t1 As IXMLDOMElement
        Dim SlidePath As String
        Dim i As Integer
'''        path = FrmMain.AllCountryArray(Lan)
        path = get_country_path(Lan)
        If path <> "" And albumID <> "" Then
            Set xmlTrack = New DOMDocument
            xmlTrack.Load path & "\Database\" & "SlideshowPaths.xml"
            Set t1 = xmlTrack.selectSingleNode("SlideshowPaths/SlideshowPath[@AlbumId = '" & albumID & "']")
            If Not t1 Is Nothing Then
                SlidePath = t1.getAttribute("Path")
            End If
        End If
        StringPathSlide = ""
        sepSlide = ""
        If SlidePath <> "" Then
            frmSlideShow.getStrPathSlideShow (SlidePath)
        Else
            SlidePath = FrmMain.GetAttSetting(1, "ImagePath")
            frmSlideShow.getStrPathSlideShow (SlidePath)
        End If
        If StringPathSlide = "" Then StringPathSlide = "No picture found"
        If currentSlideShowPath <> StringPathSlide Then
            currentSlideShowPath = StringPathSlide
            If server_loadSlideshow = True Then
                sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", CStr(server_slideshow_index)
            Else
                sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", ""
            End If
            sendToFlash frmSlideShow.SlideShow, "stringPath", StringPathSlide
            If CWinsock.LoggedAs(ServerMode) Then CWinsock.Send2Client WS_COMMAND, 0, "copy_xml_slideshow"
        End If
    Else
        If busy_copying_slideshow = False Then
            CWinsock.Send2Server WS_COMMAND, "start_copy_xml_slideshow&&&" & fso.GetSpecialFolder(2) & "\slideshow.xml"
        Else
        
            If server_loadSlideshow = True Then
                sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", CStr(server_slideshow_index)
            Else
                sendToFlash frmSlideShow.SlideShow, "server_slideshow_index", ""
            End If
            
            currentSlideShowPath = str_path_copying_slideshow
            sendToFlash frmSlideShow.SlideShow, "stringPath", str_path_copying_slideshow
            sendToFlash frmSlideShow.SlideShow, "progress", CLng(CLng(250 * CLng(image_index)) / UBound(copy_image_slideshow))
            sendToFlash frmSlideShow.SlideShow, "visible", "1"
            sendToFlash frmSlideShow.SlideShow, "alpha", 50
            CWinsock.Send2Server WS_COMMAND, "request_random"
        End If
    End If
   Exit Sub
Error:
   WriteEvent "GetSlideshowPath", Err.Description, Err.Source
End Sub

'*******************************************************************************
' Function Name     :   MoveChildNode
' Description       :   move child node up down with first child
' Return Values     :   None
' Input Parameter   :   filepath,movingindex,lastindex
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             11-09-2005           New
'*******************************************************************************

Public Function MoveChildNode(filePath As String, ByVal movingIndex As Long, ByVal LastIndex As Long)
   On Error GoTo Error
   Dim ixml As New DOMDocument
   Dim ixmlRoot As IXMLDOMElement
   Dim xmlLastIndex As IXMLDOMElement
   Dim xmlMoveIndex As IXMLDOMElement
   ixml.Load (filePath)
   Set ixmlRoot = ixml.firstChild
   
   Set xmlLastIndex = ixmlRoot.childNodes(LastIndex).cloneNode(True)
   Set xmlMoveIndex = ixmlRoot.childNodes(movingIndex).cloneNode(True)

   ixmlRoot.replaceChild xmlLastIndex, ixmlRoot.childNodes(movingIndex)
   ixmlRoot.replaceChild xmlMoveIndex, ixmlRoot.childNodes(LastIndex)
   
   ixml.Save (filePath)
   Exit Function
Error:
   WriteEvent "MoveChildNode", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   MoveCountry
' Description       :   move child node up down with first child
' Return Values     :   boolean
' Input Parameter   :   filepath,movingID,lastID
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             18-05-2006           New
'*******************************************************************************

Public Function MoveCountry(filePath As String, ByVal movingID As String, ByVal lastID As String) As Boolean
   On Error GoTo Error
   Dim ixml As New DOMDocument
   Dim ixmlRoot As IXMLDOMElement
   Dim xmlLastIndex As IXMLDOMElement
   Dim xmlMoveIndex As IXMLDOMElement
   Dim movingIndex As Long
   Dim LastIndex As Long
   Dim i As Long
   Dim xmlName As IXMLDOMElement
   ixml.Load (filePath)
   
   Set ixmlRoot = ixml.firstChild
   For i = 0 To ixmlRoot.childNodes.Length - 1
      Set xmlName = ixmlRoot.childNodes.item(i)
      If StrComp(xmlName.Text, movingID, vbTextCompare) = 0 Then
         Set xmlMoveIndex = xmlName.cloneNode(True) 'ixmlRoot.childNodes(LastIndex).cloneNode(True)
         movingIndex = i
      ElseIf StrComp(xmlName.Text, lastID, vbTextCompare) = 0 Then
         Set xmlLastIndex = xmlName.cloneNode(True) 'ixmlRoot.childNodes(movingIndex).cloneNode(True)
         LastIndex = i
      End If
   Next
   If Not (xmlMoveIndex Is Nothing Or xmlLastIndex Is Nothing) Then
      ixmlRoot.replaceChild xmlLastIndex, ixmlRoot.childNodes(movingIndex)
      ixmlRoot.replaceChild xmlMoveIndex, ixmlRoot.childNodes(LastIndex)
      ixml.Save (filePath)
   End If
   Exit Function
Error:
   WriteEvent "MoveCountry", Err.Description, Err.Source
End Function


Public Function GetHwndCaption(hwnd As Long) As String
   On Error GoTo Error
   Dim s As String
   Dim nLen As Long
   s = String(255, Chr(0))
   'getStaticHwnd (ID)
   nLen = GetWindowText(hwnd, s, Len(s))
   GetHwndCaption = left(s, nLen)
   Exit Function
Error:
   WriteEvent "GetHwndCaption", Err.Description, Err.Source
End Function




'======================Search Page=======================
            'search page...
Public Sub SearchPageGoBack()
   If IndexSearchToLoad = 3 Then
       Load FrmMain.swf(3)
       FrmMain.LoadSwfPlayListPage "2"
       FrmMain.ShowOrHidePlayer False
       DisplayMini = 0
       IndexSearchToLoad = 0
   ElseIf IndexSearchToLoad = 4 Then
       FrmMain.LoadSwfPlayListPlayerPage "2"
       FrmMain.ShowOrHidePlayer True
       IndexSearchToLoad = 0
   Else
       If ValuePlayer = 4 Then
           FrmMain.ShowOrHidePlayer True
           DisplayMini = 1
       Else
           FrmMain.ShowOrHidePlayer False
           DisplayMini = 0
       End If
       FrmMain.swf(0).Visible = True
       
       server_display_language = currentCountry
       server_display_page = ""
       IndexSearchToLoad = 0
       IndexPlaylistToLoad = 0
       IndexPlayerToLoad = 0
       IndexOptionToLoad = 0
       
       
       IndexSwf = 0
       If ChangeIcon <> "" Then
           sendVariable2Flash FrmMain.swf(0), "DisplayAlbumLong", DisplayAlbumLong
           sendVariable2Flash FrmMain.swf(0), "SetAlbumNum", ChangeIcon
           ChangeIcon = ""
       End If
       sendVariable2Flash FrmMain.swf(0), "UnloadEx", 2
       sendVariable2Flash FrmMain.swf(0), "OpenFrame", "true"
       FrmMain.txtSearchUnicode.Visible = False
       sendToFlash FrmMain.swf(0), "showMiniPlayer", True
       
       clsKeyboard.SetKeyBoardLanguage "English"
       
   End If
End Sub

Public Function GetSubMenuCheck(hOfMenu As Long, IDOfMenu As Long) As Boolean
   Dim menuInfo As MENUITEMINFO
   With menuInfo
      .cbSize = Len(menuInfo)   ' 44
      .fMask = MIIM_STATE Or MIIM_DATA Or MIIM_ID
   End With
   If GetMenuItemInfo(hOfMenu, IDOfMenu, False, menuInfo) <> 0 Then
      GetSubMenuCheck = (menuInfo.fState = 8)
   End If
End Function

Public Function GetSubMenuText(hOfMenu As Long, IDOfMenu As Long) As String
   Dim menuInfo As MENUITEMINFO
   With menuInfo
      .cbSize = Len(menuInfo)   ' 44
      .dwTypeData = String(255, 0)
      .cch = Len(.dwTypeData)
      .fMask = MIIM_DATA Or MIIM_ID Or MIIM_TYPE
   End With
   If GetMenuItemInfo(hOfMenu, IDOfMenu, False, menuInfo) <> 0 Then
      GetSubMenuText = left(menuInfo.dwTypeData, menuInfo.cch)
   End If
End Function

