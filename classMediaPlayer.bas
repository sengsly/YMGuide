Attribute VB_Name = "classMediaPlayer"
Option Explicit
'= = = = = = = = = = = = = = = = = = = = = = ='
'                                             '
'            Working with Media               '
'                                             '
'= = = = = = = = = = = = = = = = = = = = = = ='
Private staticHwnd As Long 'Handle of Static class (Time)
'Public  movieDuration As Long 'Movie Duration

Private Function menuItemI(subIndex As Integer, index As Integer) As Long  'Identifier to Play Menu item by index
  menuItemI = GetMenuItemID(hSubMenu(subIndex), index)
End Function
Private Function getSubSubMenuItemID(submenuIndex As Integer, menuItemIndex As Integer, ItemIndex As Integer) As Long
  getSubSubMenuItemID = GetMenuItemID(GetSubMenu(hSubMenu(submenuIndex), menuItemIndex), ItemIndex)
End Function
'= = = = = = = = = = = Play Menu = = = = = = = = = = = =
Public Sub Volume(index As IVolume)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mPlay, 13, CInt(index)), 0), 0
End Sub
Public Sub SwitchAudio(index As IKaraoke)
Dim a As Long
  a = GetMenuItemID(GetSubMenu(GetSubMenu(hSubMenu(mPlay), 8), 5), index)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(a, 0), 0
End Sub
'= = = = = = = = = = = All Menu Command = = = = = = = = = = =
Private Sub MenuCommand(submenuIndex As Integer, menuItemIndex As Integer)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(menuItemI(CInt(submenuIndex), CInt(menuItemIndex)), 0), 0
End Sub
Public Sub ViewMenuCommand(index As ViewSubItemIndex)
  MenuCommand mView, CInt(index)
End Sub
Public Sub PlayMenu(index As PlayMenuSubItemIndex)
  MenuCommand mPlay, CInt(index)
End Sub
Public Sub NavigateMenu(index As NavigateSubItemIndex)
  MenuCommand mNavigate, CInt(index)
End Sub
''View
Public Sub Zoom(index As IZoom)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mView, ViewZoom, CInt(index)), 0), 0
End Sub
Public Sub Presets(index As IPreset)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mView, ViewPresets, CInt(index)), 0), 0
End Sub
Public Sub VdeoFrame(index As IVdeoFram)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mView, ViewVdeoFrame, CInt(index)), 0), 0
End Sub
Public Sub PanScan(index As IPanScan)
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mView, viewPanScan, CInt(index)), 0), 0
End Sub
'-------------------------Navigate Menu-------------------------
Public Sub JumpTo(index As Long)
  On Error Resume Next
  If index <> 0 Then
    index = 33400 + (index - 1)
  End If
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(index, 0), 0
End Sub
Public Sub AudioLanguage(index As Integer)
  On Error Resume Next
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naAudioLanguage, index), 0), 0
End Sub
Public Sub subTitle(index As Integer)
On Error Resume Next
  SendMessageLong hMedia, WM_COMMAND, MakeLongs(getSubSubMenuItemID(mNavigate, naSubTitleLanguage, index), 0), 0
End Sub
Private Sub Class_Initialize()
  getHWND
End Sub
Private Function MakeLongs(ByVal a As Long, ByVal b As Long) As Long
  Dim Longs As LongType
  Dim Ints As Inter2Type
   
  Ints.MyInt1 = CInt("&H" & Hex(a))
  Ints.MyInt2 = CInt("&H" & Hex(b))
  LSet Longs = Ints
  MakeLongs = Longs.MyLong
End Function
'-----------------------------------------------------
Public Sub getVDRender(Parenthwnd As Long, left As Single, top As Single, Width As Single, Height As Single)
  Dim pvd As Long
  
  'hMedia = FindWindow("MediaPlayerClassicW", vbNullString) 'media handle
  pvd = FindWindowEx(hMedia, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
  vdRender = FindWindowEx(pvd, 0, "VideoRenderer", vbNullString)
  
  SetParent vdRender, Parenthwnd
  MoveWindow vdRender, left, top, Width / 15, Height / 15, True
  
End Sub
Private Function GetSubMenuText(hOfMenu As Long, submenuIndex As Integer) As String
  Dim s As String
  Dim i As Integer
   
  s = Space(255)
  GetMenuString hOfMenu, submenuIndex, s, Len(s), MF_BYPOSITION
  i = InStr(s, Chr(0))
  s = left(s, i - 1)
  i = InStr(s, "&")
  If i = 1 Then
    s = right(s, Len(s) - 1)
  End If
  GetSubMenuText = s
End Function

'''''''''''''''''''-------------------------''''''''''''''''
'''''''''''''''''''''''''Seek Bar'''''''''''''''''''''''''

Public Function getScrollStart() As Long
  getScrollStart = GetScrollLens(getScrollMax, getStartTime(getStaticText))
End Function
''
Public Sub ScrollChange(value As Integer)
  Dim a As Long
  a = MakeLongs(value, 5)
  SendMessageLong scrollHwnd, WM_LBUTTONDOWN, MK_LBUTTON, a
End Sub
Public Function getTimeValue(scrollMax As Integer, value As Integer) As Long
  getTimeValue = (movieDuration * value) / scrollMax
End Function
'''get Media ScrollBar Width
Public Function getScrollMax() As Long
  Dim Slider As RECT
  GetScrollHwnd
  GetWindowRect scrollHwnd, Slider
  getScrollMax = Slider.right - Slider.left
End Function
''''Len to Scroll in seconds
Public Function GetScrollLens(scrollMax As Integer, value As Long) As Long
  On Error Resume Next
  GetScrollLens = (scrollMax * value) / movieDuration
End Function
''''
Private Sub GetScrollHwnd()
  Dim i As Integer
  scrollHwnd = FindWindowEx(hMedia, 0, "#32770", vbNullString)
  While scrollHwnd <> 0
    ' Debug.Print Hex(scrollHwnd)
    scrollHwnd = FindWindowEx(hMedia, scrollHwnd, "#32770", vbNullString)
    If GetWindowLong(scrollHwnd, GWL_ID) = &HDA Then
      Exit Sub
    End If
  Wend
End Sub
''''
Private Sub getStaticHwnd()
  Dim i As Long
  Dim j As Long
  i = FindWindowEx(hMedia, 0, "#32770", vbNullString)
  staticHwnd = FindWindowEx(i, 0, "Static", vbNullString)
  While staticHwnd <> 0
    staticHwnd = FindWindowEx(i, staticHwnd, "Static", vbNullString)
    If GetWindowLong(staticHwnd, GWL_ID) = &H82 Then
      Exit Sub
    End If
  Wend
End Sub
'''''Get Vdeo Start Time''''
Private Function getStartTime(s As String) As Long
  On Error Resume Next
  Dim sArr() As String
  Dim MovieTime() As String
  Dim startTime() As String
  Dim lens As Integer
   
  lens = InStr(s, Chr(0))
  s = left(s, lens - 1)
  sArr = Split(s, "/")

  '''''''''''Start Time ''''''
  startTime = Split(sArr(0), ":")
  If UBound(startTime) = 1 Then '2 element
     getStartTime = CInt(startTime(0) * 60) + CInt(startTime(1))
     stime = getStartTime
  ElseIf UBound(startTime) = 2 Then '3 elements
     getStartTime = CInt(startTime(0)) * 3600 + CInt(startTime(1)) * 60 + CInt(startTime(2))
     stime = getStartTime
  End If
End Function
'''Get Static Time of Media
Private Function getStaticText() As String
  Dim s As String
  Dim i As Integer
  s = String(255, Chr(0))
  getStaticHwnd
  GetWindowText staticHwnd, s, Len(s)
  getStaticText = s
End Function
Private Function getScriptClass()
    'Afx:00400000:b:0001002D:00000006:00000000
  getScriptClass = FindWindowEx(hMedia, 0, "Afx:00400000:b:0001002D:00000006:00000000", vbNullString)
End Function

Public Property Get movieDuration() As Long
  Dim MovieTime() As String
  Dim sArr() As String
  Dim s As String
  Dim lens As Integer

  s = getStaticText()

  lens = InStr(s, Chr(0))
  s = left(s, lens - 1)
  sArr = Split(s, "/")

  MovieTime = Split(sArr(1), ":")
  If UBound(MovieTime) = 1 Then
     movieDuration = MovieTime(0) * 60 + MovieTime(1)
  ElseIf UBound(MovieTime) = 2 Then
     movieDuration = CInt(MovieTime(0)) * 3600 + CInt(MovieTime(1)) * 60 + CInt(MovieTime(2))
  End If
End Property

Public Property Get hMedia() As Long
  On Error Resume Next
  Dim i As Integer
   'MediaPlayerClassicW
  hMedia = FindWindow("MediaPlayerClassicW", vbNullString) 'media handle
End Property
Public Property Get hMenu() As Long
  On Error Resume Next
  hMenu = GetMenu(hMedia) 'menu handle
End Property
Public Property Get hSubMenu(index As Integer) As Long
  On Error Resume Next
  Dim subMenuH() As Long
  Dim i As Integer
  ReDim subMenuH(GetMenuItemCount(hMenu))
  
  For i = 0 To GetMenuItemCount(hMenu) - 1
    subMenuH(i) = GetSubMenu(hMenu, i) 'submenu handle
  Next
  hSubMenu = subMenuH(index)
End Property
Public Property Get subTitleText() As String()
  On Error Resume Next
  Dim i As Integer
  Dim n As Integer
  Dim subTitleString() As String
  
  n = GetMenuItemCount(GetSubMenu(GetSubMenu(hMenu, mNavigate), naSubTitleLanguage))
  ReDim subTitleString(n)
  For i = 0 To n - 1
      subTitleString(i) = GetSubMenuText(GetSubMenu(hSubMenu(mNavigate), naSubTitleLanguage), i)
  Next
  subTitleText = subTitleString
End Property

