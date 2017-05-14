Attribute VB_Name = "General"
Option Explicit

'============== sith 30-1-07 ==================================
''Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
''Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
''Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
''Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
''Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
''Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
''Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
''Private Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
'''Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As Rect) As Long
''Private Const COLOR_WINDOW = 5
''Private Const TRANSPARENT = 1
''Public mDC As Long
''Public mBitmap As Long
'===================
Public bool_full_player As Boolean

Public Const get_str = "1234567890ihgfedcba`"
Public Const get_ind = "12345678909876543210"
Public boolPress As Boolean 'make press one time
Public index_selecte_chapter As String
Public int_nextPrevious_index As Long
'=================================Download cover art from network=========================================
'download file
'''Public DownloadQue   As New Collection
'''Public downloadData As cFile
'''Public Downloading As Boolean
Public destinationDirectory As String
Public AlbumIDDownLoadImage As Long
Public LanDownloadImage As String
'=========================================================================================================

'Public str_extension As String
Public all_chapterIFO As Long
Public current_chapter As Long

Public ori_player_top As Long
Public ori_player_left As Long
Public ori_player_width As Long
Public ori_player_height As Long
Public close_player_top As Long
Public close_player_buttom As Long
Public Const close_player_distant = 15
Public old_player_height As Long

' variables use for connect to web
'---------------------------------
' Public Const WinampPlayableFilter = "All Media File|*.MP3;*.MP4;*.IFO;*.VOB;*.DAT;*.WMA;*.AAC;*.WMV;*.MPG;*.MOV;*.AVI"
Public Const WinampPlayableFilter = "All Media File|*.mp3;*.wma;*.vob;*.dat;*.ifo;*tp;*.trp;*.ts;*.wmv;*.asf;*.avi;*.mpg;*.mov;*.mp4;*.m2ts;*.evo;*.iso|All Files|*.*"
' Public Const AllVideoFile = "All Video FIle|*.TS;*.DAT;VIDEO_TS.IFO;*.VOB;*.WMV;*.AVI;*.MPG;*.MOV"         'video file
Public Const PlayerVideoFile = "DAT;IFO;VOB;WMV;AVI;MPG;MOV"
Public connected_already As Boolean
Public connected_userName As String
Public connected_password As String
'---------------------------------
 
Public b_busy As Boolean
 
Public login_name As String
Public user_sign_in_index As String
Public user_online_id As String
Public online_id As String  ' store index for user start sign in to web server
Public b_online As Boolean
Public b_got_permission As Boolean  'this variable note for this user sign in has permission or not
Public b_default_permission As Boolean  'this server allow client get default permission
Public b_deny As Boolean
Public str_permission As String
Public store_user_login_name As String
Public store_user_login_pass As String

Public server_loadSlideshow As Boolean
Public server_slideshow_index As Integer

Public num_display As Integer
Public currentIndex As String
Public Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
Public Const SM_CXSCREEN = 0
Public Const SM_CYSCREEN = 1
Public Const SM_CYCAPTION = 4
Public Const SM_CXEDGE = 45
Public Const SM_CYEDGE = 46

Public Const de_Field = "||"
Public Const de_Record = "&&&"
'..........DanyEdit...........
Public Const ChunkSize = 1024
Public Const passwordKey = "iAkgiPB!@s"
Public Data As String
'.............................
'Flash DLL extension
Public Const StrExtension = ".dll"

'''Public Enum AlbumEnum
'''   NotAvailable = 0
'''   Available = 1
'''   All = 3
'''End Enum
Public Enum EnumCovertArtType
   CoverDVD = 0
   CoverBlurary = 1
   CoverHDDVD = 2
End Enum
Public Const BackCoverName = "back.jpg"
Public Const DVDCoverName = "folder.jpg"
Public Const HDDVDCoverName = "hddvd.jpg"
Public Const BlurayCoverName = "bluray.jpg"
Public Const SlyGuideFolder = "YMGuide"

''Public Enum SortEnum
''   stDate = 0
''   stName = 1
''   stNone = 3
''End Enum
Public Enum WMPSUB
  sOn = 1
  sOff = 0
End Enum
'const for slideshow
Public Enum RegName
   ImageDir = 0
   ImageSize = 1
   Delay = 2
   Stretch = 3
   ShowFilename = 4
   Scroll = 5
   Effect = 6
End Enum

Public Enum CompareEnum
   Equal = 0
   Greater = 1
   Lower = 2
End Enum
'register constant
Dim boolRegistered As Boolean
'==========================

'Public myMusic As New clsmyMusic
Public currentCountry As String
Public RipCountry As String
Private Const prv_Available = "abcdefghijklmnopqrstuvwxyz"
Private Const strCRC = "Y2GNx6Iy8U:;<=>?@op1JKLkScmgThXMPVwDbR9FA0i[\]^_`HszEn7dOtuWla5CBqef43vQZrj"
Private Const strNor = "0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz"

Public Const SlyServer = "http://www.slymultimedia.com"

Type new_Playlst        'for copy friend playlist
    source_path As String
    destination_path As String
End Type
Public arr_redownload() As String
Public current_copy_image_slideshow_path As String

Function GetBackNumber(valNumber As String) As String
   Const numChar = ")6WHd*03U9a$8ceXf!up2gh@5ijRbk4xrlnFmo7#qOtD%svSy&ACEGBwIJMzZKNPTYV1QL^"
   Dim i As Integer
   Dim iSumChar As Integer
   Dim sChar As String
   Dim sRet As String
   Dim iPos As Integer
   Dim iChar As Integer
      
   iSumChar = InStr(1, numChar, right(valNumber, 1))
   For i = 1 To Len(valNumber) - 1
      sChar = mID(valNumber, i, 1)
      iPos = InStr(1, numChar, sChar)
      iChar = iPos - i - iSumChar
      sRet = sRet & iChar
   Next
   GetBackNumber = sRet
End Function

Function ChangeNumber(valNumber As String) As String
   Const numChar = ")6WHd*03U9a$8ceXf!up2gh@5ijRbk4xrlnFmo7#qOtD%svSy&ACEGBwIJMzZKNPTYV1QL^"
   Dim i As Integer
   Dim iSumChar As Integer
   Dim sChar As String
   Dim sRet As String
   Dim iPos As Integer
   
   For i = 1 To Len(valNumber)
      iSumChar = iSumChar + val(mID(valNumber, i, 1)) + 1
   Next
   For i = 1 To Len(valNumber)
      sChar = mID(valNumber, i, 1)
      iPos = i + iSumChar + val(sChar)
      sRet = sRet & mID(numChar, iPos, 1)
   Next
   ChangeNumber = sRet & mID(numChar, iSumChar, 1)
End Function
Function Change(strSource As String, normal As Boolean) As String
   On Error GoTo Error
  Dim i As Integer, s As String, p As Integer
  Dim charText As String * 1
  
  For i = 1 To Len(strSource)
    charText = mID(strSource, i, 1)
    If normal Then
      p = InStr(strNor, charText)
      If p > 0 Then
        s = s + mID(strCRC, p, 1)
      Else
        s = s + charText
      End If
    Else
      p = InStr(strCRC, charText)
      If p > 0 Then s = s + mID(strNor, p, 1) Else s = s + charText
    End If
  Next
  Change = s
   Exit Function
Error:
   WriteEvent "Change", Err.Description, Err.Source
End Function



Public Function ArrayIn(Arrays As Variant, vValue As Integer) As Boolean
   On Error GoTo Error
   Dim i As Integer
   For i = 0 To UBound(Arrays)
      If Arrays(i) = vValue Then
         ArrayIn = True
         Exit Function
      End If
   Next
   Exit Function
Error:
   WriteEvent "ArrayIn", Err.Description, Err.Source
End Function
Public Function IsCorrectStartLetter(start As String, Data As String) As Boolean
   On Error GoTo Error
   Dim tmpData As String
   tmpData = LCase(left(Data, 1))
   If start = "#" Then
      IsCorrectStartLetter = (InStr(prv_Available, tmpData) = 0)
   ElseIf start = "" Then
      IsCorrectStartLetter = True
   Else
      IsCorrectStartLetter = (tmpData = LCase(start))
   
   End If
   Exit Function
Error:
   WriteEvent "IsCorrectStartLetter", Err.Description, Err.Source
End Function
Public Function GetArtistStartLetter(artistName As String) As String
   On Error GoTo Error
   Dim startLetter As String
   startLetter = left(artistName, 1)
   If InStr(1, "abcdefghijklmnopqrstuvwxyz", startLetter, vbTextCompare) = 0 Then
      startLetter = "#"
   End If
   GetArtistStartLetter = startLetter
   Exit Function
Error:
   WriteEvent "GetArtistStartLetter", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :   ConcateString
' Description       :
' Return Values     :   String concated with delimiter
' Input Parameter   :   Delimiter,Array of string to be concated
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             07-14-2006           New
'*******************************************************************************

Public Function ConcateString(Delimiter As String, ParamArray ParamsString() As Variant) As String
   On Error GoTo Error
   ConcateString = Join(ParamsString, Delimiter)
   Exit Function
Error:
   WriteEvent "ConcateString", Err.Description, Err.Source
End Function
Public Function SpecialSort(Data() As Variant, indexs As Variant, Optional reverse As Boolean = False)
   On Error GoTo Error
'Note: This function arrange this special data with many type
'   myData(0) = Array(5, 2)
'   myData(1) = Array(3, 2)
'   myData(2) = Array(2, 1)
'   myData(3) = Array(4, 1)
'   myData(4) = Array(1, 1)

   Dim i  As Integer, j As Integer, k As Integer
   Dim intSwap As Integer, intOldState As Integer
   Dim varLeft As Variant, varRight As Variant
   Dim intMax As Integer
   Dim Y As Long
   Dim swaps As Boolean
   Dim boolCompare As Boolean
   
   
   intMax = UBound(Data)
   For k = 0 To intMax
      intSwap = 0
      swaps = False
      For i = k + 1 To intMax
'         y = y + 1
         intOldState = 0
         varLeft = Data(k)(0)
'         varRight = data(i)(0)
         
'         If varLeft > varRight Then swap data(k), data(i)

         For j = 0 To UBound(indexs)
            varLeft = Data(k)(indexs(j))
            varRight = Data(i)(indexs(j))
            If IsDate(varRight) Then
               varRight = CDate(varLeft)
               varRight = CDate(varRight)
            End If
            If reverse Then
               boolCompare = varLeft < varRight
            Else
               boolCompare = varLeft > varRight
            End If
            If boolCompare Then
               intSwap = 1
            ElseIf varLeft = varRight Then
               intSwap = 0
            Else
               intSwap = -1
            End If
            If (intSwap = 1) And (intOldState = 0) Then
               swap Data(k), Data(i)
               swaps = True
               Exit For
            End If
            intOldState = intSwap
         Next
      Next i
   Next k
'   Loop Until swaps = False
   Exit Function
Error:
   WriteEvent "SpecialSort", Err.Description, Err.Source
End Function


Private Sub SubQuick(Data() As Variant, lb As Integer, ub As Integer, indices As Variant)
   Dim i As Integer, j As Integer
   Dim dataCompare As CompareEnum
   Dim pivot As Variant
   Dim boolSuccess As Boolean
   If ub > lb Then
      j = lb - 1
      pivot = Data(ub)
      For i = lb To ub
         dataCompare = CompareArray(Data(i), pivot, indices)
         boolSuccess = (dataCompare = Lower)
         
         If (dataCompare = Equal) Or boolSuccess Then
'         If data(i) <= pivot Then
            j = j + 1
            If i <> j Then
               swap Data(i), Data(j)
            End If
         End If
      Next
      SubQuick Data, lb, j - 1, indices
      SubQuick Data, j + 1, ub, indices
   End If
End Sub
Private Sub swap(a, B)
   Dim tmp
   tmp = B
   B = a
   a = tmp
End Sub
Public Function CompareArray(leftVar As Variant, rightVar As Variant, indices As Variant) As CompareEnum
   On Error GoTo Error
   Dim i As Integer, compareRet As Variant
   Dim boolGreater As Boolean, boolLower As Boolean
   Dim retValue As CompareEnum
   Dim Index As Integer
   Dim varLeft As Variant, varRight As Variant
   
   For i = 0 To UBound(indices)
      Index = indices(i)
      varLeft = leftVar(Index)
      varRight = rightVar(Index)
      If IsDate(varLeft) And (IsDate(varRight)) Then
         varLeft = CDate(varLeft)
         varRight = CDate(varRight)
      ElseIf IsNumeric(leftVar(Index)) = False Then
         varLeft = LCase(leftVar(Index))
         varRight = LCase(rightVar(Index))
      End If
      
'      boolGreater = leftVar(index) > rightVar(index)
      boolGreater = varLeft > varRight
      If boolGreater Then
         retValue = Greater
         Exit For
      Else
'         boolLower = leftVar(index) < rightVar(index)
         boolLower = varLeft < varRight
         If boolLower Then
            retValue = Lower
            Exit For
         End If
      End If
   Next
   CompareArray = retValue
   Exit Function
Error:
   WriteEvent "CompareArray", Err.Description, Err.Source
End Function

'*******************************************************************************
' Function Name     :
' Description       :
' Return Values     :
' Input Parameter   :
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             07-14-2006           New
'*******************************************************************************

Public Sub QuickSort(Arrays() As Variant, indices, Optional reverse As Boolean)
   On Error GoTo Error
   Dim i As Integer, count As Integer
   Dim oldData() As Variant
   SubQuick Arrays, 0, UBound(Arrays), indices
   If reverse Then
      oldData = Arrays
      For i = UBound(Arrays) To 0 Step -1
         Arrays(i) = oldData(count)
         count = count + 1
      Next
   End If
   Exit Sub
Error:
   WriteEvent "QuickSort", Err.Description, Err.Source
End Sub
Public Function ReadRegDate() As Date
   Dim readDate As String
   
   readDate = SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\DirectDraw\Compatibility\Bug!", "Version", REG_SZ)
   readDate = Replace(readDate, ".", "")
   ReadRegDate = DateSerial(mID(readDate, 3, 4), left(readDate, 2), mID(readDate, 7, 2))
   ReadRegDate = ReadRegDate
errorOccur:
End Function
Public Sub WriteRegDate(Value As Date)
   On Error GoTo Error
   Dim i As Integer
   Dim stringDate As String
'   stringDate = Format(value, "mm") + Format(value, "yyyy") + Format(value, "dd")
   stringDate = Format(Value, "mmyyyydd")
   stringDate = left(stringDate, 2) + "." + mID(stringDate, 3, 2) + "." + mID(stringDate, 5, 2) + "." + mID(stringDate, 7, 2)
   SlyRegedit.SetKeyValue HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\DirectDraw\Compatibility\Bug!", "Version", stringDate, REG_SZ
   Exit Sub
Error:
   WriteEvent "WriteRegDate", Err.Description, Err.Source
End Sub
'call writeregcode before calling is registered
Public Sub WriteRegCode(code As String)
   SlyRegedit.SetKeyValue HKEY_CURRENT_USER, RegPath, "RegisterKey", code, REG_SZ
End Sub

Public Function ReadRegCode() As String
    ReadRegCode = SlyRegedit.GetKeyValue(HKEY_CURRENT_USER, RegPath, "RegisterKey", REG_SZ)
End Function

Public Function IsRegistered(Optional registerCode As String) As Boolean
   Dim registerID As String
   Dim machineID As String
   Dim bFromRegisterType As Boolean
      
   If registerCode = "" Then
      bFromRegisterType = False
      registerCode = ReadRegCode
   Else
      bFromRegisterType = True
   End If
   registerID = mID(registerCode, 5)
   machineID = GetCurrentMachineID()
   If Len(registerCode) = 22 And machineID <> "" Then             '18 Character
      registerID = mID(registerCode, 5)
      If ((registerCode) = (GetID(Change(left(registerCode, 4), True) & machineID))) Then
         IsRegistered = True
      Else
         IsRegistered = False
      End If
   Else
      IsRegistered = False
   End If
   If bFromRegisterType = False Then
      #If debugging = 1 Then
         IsRegistered = True
      #End If
   End If
End Function

Public Sub SetRegister(registerCode As String)
   On Error GoTo Error
   Dim machineID As String
   'SlyRegedit.classReg.GetKeyValue HKEY_CLASSES_ROOT
   machineID = GetCurrentMachineID()
   If (registerCode <> "") And (machineID <> "") And IsRegistered(registerCode) Then
      boolRegistered = True
   Else
      boolRegistered = False
   End If
   Exit Sub
Error:
   WriteEvent "SetRegister", Err.Description, Err.Source
End Sub

Public Function ScreenX() As Long
    ScreenX = GetSystemMetrics(SM_CXSCREEN)
End Function
Public Function ScreenY() As Long
    ScreenY = GetSystemMetrics(SM_CYSCREEN)
End Function

Public Function ReturnSortArray(ParamArray arrayindex() As Variant)
   On Error GoTo Error
   'Ex...Index,Boolean,Index2,Boolean
   Dim i As Integer, count As Integer, boolSelect As Boolean
   Dim tmpArray As Variant
   tmpArray = Array(0)
   For i = 0 To UBound(arrayindex) Step 2
      boolSelect = arrayindex(i + 1)
      If boolSelect Then
         ReDim Preserve tmpArray(count)
         tmpArray(count) = arrayindex(i)
         count = count + 1
      End If
   Next
   ReturnSortArray = tmpArray
   Exit Function
Error:
   WriteEvent "ReturnSortArray", Err.Description, Err.Source
End Function

Public Function GetFlashVar(obj As ShockwaveFlashObjects.ShockwaveFlash, VarName As String) As Variant
   On Error GoTo errorOccur
   GetFlashVar = obj.GetVariable(VarName)
errorOccur:
End Function
Public Function CallFlashFunction(obj As ShockwaveFlashObjects.ShockwaveFlash, functionName As String, ParamArray params() As Variant) As String
    On Error GoTo errorOccur
    obj.SetVariable "functionName", functionName & Chr(1) & Chr(2) & Join(params, Chr(1) & Chr(2))
    CallFlashFunction = obj.GetVariable("getFunction")
errorOccur:
End Function
Public Function StrReplace(ByVal Source As String, ParamArray argLists() As Variant)
   'Ex replace '%1' with "String new"
   Dim i As Long
   For i = 0 To UBound(argLists)
      argLists(i) = Replace(argLists(i), "<", "&lt;")
      Source = Replace(Source, "'%1'", """" & argLists(i) & """", , 1)
   Next
   StrReplace = Source
End Function

Public Property Get IsItunesInstalled() As Boolean
   IsItunesInstalled = (SlyRegedit.GetKeyValue(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{00FC6799-866E-44A1-A60C-DCF394CF56FD}", "DisplayName", REG_SZ) = "iTunes")
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{00FC6799-866E-44A1-A60C-DCF394CF56FD}
End Property
Function ReturnStringSymbol(ByVal str As String) As String
   
   Dim Foldername As String
   Foldername = Replace(str, " ", "_")
   Foldername = Replace(Foldername, ".", "-")
   Foldername = Replace(Foldername, "'", "-")
   Foldername = Replace(Foldername, "?", "-")
   Foldername = Replace(Foldername, "&", "-")
   Foldername = Replace(Foldername, "(", "-")
   Foldername = Replace(Foldername, ")", "-")
   Foldername = Replace(Foldername, "!", "-")
   Foldername = Replace(Foldername, "`", "-")
   Foldername = Replace(Foldername, "@", "-")
   Foldername = Replace(Foldername, "$", "-")
   Foldername = Replace(Foldername, "%", "-")
   Foldername = Replace(Foldername, "^", "-")
   Foldername = Replace(Foldername, "+", "-")
   Foldername = Replace(Foldername, "[", "-")
   Foldername = Replace(Foldername, "]", "-")
   Foldername = Replace(Foldername, "{", "-")
   Foldername = Replace(Foldername, "}", "-")
   Foldername = Replace(Foldername, "#", "0")
   Foldername = Replace(Foldername, ",", "-")
   Foldername = Replace(Foldername, "º", "-")
   Foldername = Replace(Foldername, ";", "-")
   Foldername = Replace(Foldername, ":", "-")
   Foldername = Replace(Foldername, "~", "-")
   Foldername = Replace(Foldername, "•", "-")
   ReturnStringSymbol = Foldername
   
End Function

Public Function GetCompanyName(ByVal Value As Integer) As String
   Dim Name As String
   Name = "WalMart"                     'Set default to WalMart
   If Name = "WalMart" Then
      If Value = 1 Or Value = 3 Then
         GetCompanyName = "WalMart"
      ElseIf Value = 2 Then
         GetCompanyName = "Amazon"
      End If
   ElseIf Name = "Amazon" Then
      If Value = 2 Then
         GetCompanyName = "Amazon"
      ElseIf Value = 1 Or Value = 3 Then
         GetCompanyName = "WalMart"
      End If
   ElseIf Name = "BuyCom" Then
      If Value = 2 Or Value = 3 Then
         GetCompanyName = "BuyCom"
      ElseIf Value = 1 Then
         GetCompanyName = "WalMart"
      End If
   End If
End Function

Public Function GetStrWalmart(ByVal str As String, Index As String, Optional Company As String = "WalMart") As String
   On Error GoTo Error
   Dim spl() As String
   Dim str1 As String
   Dim CDNum As String
   Dim NoTrack As String
   spl = Split(str, "%%")
   str = spl(0)
   NoTrack = Format(Index, "000")
   CDNum = Format(spl(1), "00")
   
   If Company = "WalMart" Then
      str1 = left(str, 3) & "/" & mID(str, 4, 2) & "/" & mID(str, 6, 2) & "/" & mID(str, 8, 2) & "/" & mID(str, 10, 2) & "/" & mID(str, 12, 2) & "/"
      str1 = "http://music.walmart.com/m/" & str1 & str & ".01." & CDNum & "." & NoTrack & ".mp3"
   ElseIf Company = "BuyCom" Then
      NoTrack = Format(Index, "00")
      str1 = left(str, 3) & "/" & mID(str, 4, 2) & "/" & mID(str, 6, 2) & "/"
      str1 = "mms://mms.content.loudeye.com/600007/p/" & str1 & str & "_" & CDNum & NoTrack & "_00_0691.wma"
   ElseIf Company = "Amazon" Then
      NoTrack = Format(Index, "00")
      str1 = left(str, 3) & "/" & mID(str, 4) & "/" & mID(spl(1), 1, 2) & "/" & mID(spl(1), 3, 2)
      str1 = "http://clip.musicmatch.com/clip/DOD/" & str1 & "/wm9-00.10-C/064-kbps/t" & mID(spl(1), 5) & ".wma"
   End If
   GetStrWalmart = str1
   Exit Function
Error:
   WriteEvent "GetStrWalmart", Err.Description, Err.Source
End Function
Sub SaveUserInfo(str As String)
   On Error GoTo Error
  Dim St() As String
  St = Split(str, "~")
  
  Set xmlPlaylist = New DOMDocument
  Set xmlPlaylistRoot = xmlPlaylist.createElement("UserInfo")
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Name")
  xmlPlaylistName.Text = St(1)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Age")
  xmlPlaylistName.Text = St(2)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Sex")
  xmlPlaylistName.Text = St(3)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Marriage")
  xmlPlaylistName.Text = St(4)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Nationality")
  xmlPlaylistName.Text = St(5)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("MyWebSete")
  xmlPlaylistName.Text = St(6)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Email")
  xmlPlaylistName.Text = St(7)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Artist")
  xmlPlaylistName.Text = St(8)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Song")
  xmlPlaylistName.Text = St(9)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Genre")
  xmlPlaylistName.Text = St(10)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Color")
  xmlPlaylistName.Text = St(11)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Car")
  xmlPlaylistName.Text = St(12)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Place")
  xmlPlaylistName.Text = St(13)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Sport")
  xmlPlaylistName.Text = St(14)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("FavWebsite")
  xmlPlaylistName.Text = St(15)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Picture1")
  xmlPlaylistName.Text = St(16)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  Set xmlPlaylistName = xmlPlaylist.createElement("Picture2")
  xmlPlaylistName.Text = St(17)
  xmlPlaylistRoot.appendChild xmlPlaylistName
  
  xmlPlaylist.appendChild xmlPlaylistRoot
  If Not fso.FolderExists(St(0) & "\PlayLists") Then
     fso.CreateFolder (St(0) & "\PlayLists")
  End If
  xmlPlaylist.Save St(0) & "\PlayLists\UserInfo.xml"
  Exit Sub
Error:
   WriteEvent "SaveUserInfo", Err.Description, Err.Source
End Sub

Sub add_friend_playlistPahtsXML(str_Name As String)
   On Error GoTo Error
    Dim xml_playlist As DOMDocument
    Dim xml_playlistRoot As IXMLDOMElement
    Dim xml_playlistName As IXMLDOMElement
    Dim xml_str_name As IXMLDOMElement
    Dim xml_path As String
    Dim playlist_path As String
    Dim bool_create As Boolean
    Dim jj As Integer
    Dim str_com_name As String   ' can be: server nickname / computer name from server
    
    xml_path = App.path & "\sly\PlayListPaths.xml"
    If server_nick_name = "" Then
      playlist_path = GetMyDocuments & "\Sly's Friends Playlists\" & str_Name
      str_com_name = str_Name
    Else
      playlist_path = GetMyDocuments & "\Sly's Friends Playlists\" & server_nick_name
      str_com_name = server_nick_name
    End If
    
    Set xml_playlist = New DOMDocument
    xml_playlist.Load xml_path
    Set xml_playlistRoot = xml_playlist.firstChild
    
    bool_create = True
    For jj = 0 To xml_playlistRoot.childNodes.Length - 1
        Set xml_str_name = xml_playlist.firstChild.childNodes(jj)
        If xml_str_name.getAttribute("Name") = str_com_name Then
            bool_create = False
            friend_playlist_path = xml_str_name.Text & "\Playlists"
        End If
    Next jj
    
    CreateDirectory playlist_path & "\Playlists"
    
    If bool_create Then
        Set xml_playlistName = xml_playlist.createElement("PlayListPath")
        xml_playlistName.setAttribute "Name", str_com_name
        xml_playlistName.setAttribute "ImgPath", ""
        xml_playlistName.Text = playlist_path
        xml_playlistRoot.appendChild xml_playlistName
        xml_playlist.Save xml_path
        
        friend_playlist_path = playlist_path & "\Playlists"
    End If
   Exit Sub
Error:
   WriteEvent "add_friend_playlistPahtsXML", Err.Description, Err.Source

End Sub

Sub request_friend_playlist()
   On Error GoTo Error
    Dim main_path_playlist As String
    Dim xml_PlayListPaths As DOMDocument
    Dim xml_root_PlayListPaths As IXMLDOMElement
    Dim i As Integer
    Dim j As Integer
    Dim t As Integer
    Dim xml_PlayLists As DOMDocument
    Dim xml_root_PlayLists As IXMLDOMElement
    Dim file_playlist_xml As String
    
'''    On Error GoTo end_function
    
    main_path_playlist = fso.GetSpecialFolder(2) & "\PlayLists.xml"
    
    If Dir(main_path_playlist) <> "" Then remove_chileNodes_playlistsXML main_path_playlist
    
    Set xml_PlayListPaths = New DOMDocument
    Set xml_PlayLists = New DOMDocument
    
    xml_PlayListPaths.Load (App.path & "\Sly\PlayListPaths.xml")
    Set xml_root_PlayListPaths = xml_PlayListPaths.firstChild
    
    If xml_root_PlayListPaths.childNodes.Length > 0 Then
        ReDim Preserve arr_friend_playlist(-1 To -1)
        For i = 0 To xml_root_PlayListPaths.childNodes.Length - 1
            file_playlist_xml = xml_root_PlayListPaths.childNodes(i).Text & "\PlayLists"
            If Dir(file_playlist_xml & "\PlayLists.xml") <> "" Then
                xml_PlayLists.Load (file_playlist_xml & "\PlayLists.xml")
                Set xml_root_PlayLists = xml_PlayLists.firstChild
                For j = 0 To xml_root_PlayLists.childNodes.Length - 1
                    ReDim Preserve arr_friend_playlist(-1 To t)
                    arr_friend_playlist(t).path = file_playlist_xml
                    arr_friend_playlist(t).Name = xml_root_PlayLists.childNodes.item(j).Text
                    create_xml_PlayListsXML main_path_playlist, arr_friend_playlist(t).Name
                    t = t + 1
                Next j
            End If
        Next i
        
        ' Start send friend's playlist to user that request it
        If Dir(main_path_playlist) <> "" Then
            CWinsock.Send2Client WS_COMMAND, 0, "receive_computer_name&&&" & ComputerName
        End If
        
    End If
    Exit Sub
Error:
   WriteEvent "request_friend_playlist", Err.Description, Err.Source
End Sub

Sub copy_friend_playlists(client_index As Integer, str_destination As String)
   On Error GoTo Error
    Static ind_copy As Integer
    Dim fs As String
    Dim fd As String
    If ind_copy <= UBound(arr_friend_playlist) Then
        
        fs = arr_friend_playlist(ind_copy).path & "\" & arr_friend_playlist(ind_copy).Name & ".xml"
        fd = str_destination & "\" & arr_friend_playlist(ind_copy).Name & ".xml"
        
        CWinsock.SendCopy WS_COPYTO, client_index, fs & FileDelimiter & fd & FileDelimiter & "completed_copy_playlists"
        ind_copy = ind_copy + 1
    Else
        ind_copy = 0
    End If
    Exit Sub
Error:
   WriteEvent "copy_friend_playlists", Err.Description, Err.Source
End Sub

Sub remove_chileNodes_playlistsXML(str_path As String)
   On Error GoTo Error
    Dim xml_root As DOMDocument
    Dim xml_elem As IXMLDOMElement
    Dim ij As Integer
    Set xml_root = New DOMDocument
    xml_root.Load str_path
    Set xml_elem = xml_root.firstChild
    For ij = 0 To xml_elem.childNodes.Length - 1
        RemoveFile str_path, 0
    Next ij
    Exit Sub
Error:
   WriteEvent "remove_chileNodes_playlistsXML", Err.Description, Err.Source
End Sub



Public Property Get ExternalTrackAvailable(ByVal comName As String, ByVal TrackID As String) As String
   On Error GoTo Error
    Dim xmlTrack As New DOMDocument
    Dim xmlElement As IXMLDOMElement
    Dim loadPath As String
    
    loadPath = SlyVariable("<ExternalPath>") & "External.xml"
    
    xmlTrack.Load loadPath
    TrackID = Replace(LCase(TrackID), "\", "/")
    comName = LCase(comName)

    Set xmlElement = xmlTrack.selectSingleNode("Tracks/Track[@TrackID = """ & TrackID & """ and @ComName= """ & comName & """]")
    If Not xmlElement Is Nothing Then ExternalTrackAvailable = xmlElement.getAttribute("Path") & "\" & xmlElement.getAttribute("Name")
   Exit Property
Error:
   WriteEvent "Get ExternalTrackAvailable", Err.Description, Err.Source
End Property

Public Property Let ExternalTrackAvailable(ByVal comName As String, ByVal TrackID As String, newValue As String)
   On Error GoTo Error
   Dim xmlTrack As New DOMDocument
   Dim xmlElement As IXMLDOMElement
   Dim xmlRoot As IXMLDOMElement
   Dim loadPath As String
   Dim filename As String
   Dim parentFolder As String
   
   loadPath = SlyVariable("<ExternalPath>") & "External.xml"
   xmlTrack.Load loadPath
   
   TrackID = Replace(LCase(TrackID), "\", "/")
   comName = LCase(comName)
   filename = LCase(fso.GetFileName(newValue))
   parentFolder = fso.GetBaseName(fso.GetParentFolderName(newValue))
   
   Set xmlElement = xmlTrack.selectSingleNode("Tracks/Track[@TrackID = """ & TrackID & """ and @ComName= """ & comName & """]")
   Set xmlRoot = xmlTrack.firstChild
   
   If xmlRoot Is Nothing Then
      Set xmlRoot = xmlTrack.createElement("Tracks")
      xmlTrack.appendChild xmlRoot
   End If
   
   If xmlElement Is Nothing Then Set xmlElement = xmlTrack.selectSingleNode("Tracks/Track[@ComName= """ & comName & """ and @Name=""" & filename & """]")
   
   If xmlElement Is Nothing Then
      Set xmlElement = xmlTrack.createElement("Track")
      xmlRoot.appendChild xmlElement
   End If
   
   xmlElement.setAttribute "ComName", comName
   xmlElement.setAttribute "TrackID", TrackID
   xmlElement.setAttribute "Name", filename
   xmlElement.setAttribute "Path", parentFolder
     
   xmlTrack.Save loadPath
   Exit Property
Error:
   WriteEvent "Let ExternalTrackAvailable", Err.Description, Err.Source
End Property




Public Property Get trackAvailable(trackLanguage As String, ByVal TrackID As Long) As Long
   On Error GoTo Error
    Dim xmlTrack As New DOMDocument
    Dim xmlElement As IXMLDOMElement
    Dim loadPath As String
    
    loadPath = fso.BuildPath(SlyVariable("<" & trackLanguage & "_dat>"), "Tracks.xml")
    
    xmlTrack.Load loadPath

    Set xmlElement = xmlTrack.selectSingleNode("Tracks/Track[@TrackID = '" & TrackID & "']")
    If Not xmlElement Is Nothing Then trackAvailable = xmlElement.getAttribute("Available")
    Exit Property
Error:
   WriteEvent "get trackAvailable", Err.Description, Err.Source
End Property

Public Property Let trackAvailable(trackLanguage As String, ByVal TrackID As Long, newValue As Long)
   On Error GoTo Error
    Dim xmlTrack As New DOMDocument
    Dim xmlElement As IXMLDOMElement
    Dim xmlRoot As IXMLDOMElement
    Dim loadPath As String
    
    loadPath = fso.BuildPath(SlyVariable("<" & trackLanguage & "_dat>"), "Tracks.xml")
    xmlTrack.Load loadPath

    Set xmlElement = xmlTrack.selectSingleNode("Tracks/Track[@TrackID = '" & TrackID & "']")
    Set xmlRoot = xmlTrack.firstChild
    
    If xmlRoot Is Nothing Then
        Set xmlRoot = xmlTrack.createElement("Tracks")
        xmlTrack.appendChild xmlRoot
    End If
    If xmlElement Is Nothing Then
        Set xmlElement = xmlTrack.createElement("Track")
        xmlElement.setAttribute "TrackID", TrackID
        xmlRoot.appendChild xmlElement
    End If
    xmlElement.setAttribute "Available", newValue
    xmlTrack.Save loadPath
    Exit Property
Error:
   WriteEvent "Let trackAvailable", Err.Description, Err.Source
End Property

'----------------------------------------------------------------------------------------------------
' copy friend playlists
'----------------------------------------------------------------------------------------------------
Public Sub change_playlist_path(str_path As String)
   On Error GoTo Error
    ' read PlayListPaths.xml
    ' store in array
    ' change path of playlist
    Dim doc_PLP As New DOMDocument
    Dim roo_PLP As IXMLDOMElement
    Dim ele_PLP As IXMLDOMElement
    Dim i As Integer
    Dim tp As String 'Temp Path
    
    If isFileExist(str_path & "\PlayListPaths.xml") Then
    
        doc_PLP.Load str_path & "\PlayListPaths.xml"
        Set roo_PLP = doc_PLP.firstChild
        ReDim Preserve arr_PLP(-1 To -1)
        For i = 0 To roo_PLP.childNodes.Length - 1
            Set ele_PLP = doc_PLP.firstChild.childNodes(i)
            ReDim Preserve arr_PLP(-1 To i)
            
            arr_PLP(i).source_path = ele_PLP.Text & "\PlayLists"
            
            tp = str_path & cut_last_folder(ele_PLP.Text)
            arr_PLP(i).destination_path = tp & "\PlayLists"
            
            CreateDirectory arr_PLP(i).destination_path
            
            ele_PLP.Text = tp
            
        Next i
        roo_PLP.appendChild ele_PLP
        doc_PLP.Save str_path & "\PlayListPaths.xml"
        
        copy_Playlists_xml  ' start copy PlayLists.xml from each path
    End If
   Exit Sub
Error:
   WriteEvent "change_playlist_path", Err.Description, Err.Source
End Sub

Function cut_last_folder(str_path As String) As String
   On Error GoTo Error
    Dim tp() As String
    Dim pp As String
    If fso.GetParentFolderName(str_path) <> "" Then
        pp = Replace(str_path, "/", "\")
        tp = Split(pp, "\")
        cut_last_folder = tp(UBound(tp))
    Else
        cut_last_folder = mID(str_path, 1, 1)
    End If
   Exit Function
Error:
   WriteEvent "cut_last_folder", Err.Description, Err.Source
End Function

Public Sub copy_Playlists_xml() 'copy main path of xml playlist
   On Error GoTo Error
    Static aa As Integer
    If aa <= UBound(arr_PLP) Then
        CWinsock.Send2Server WS_COMMAND, "request_copy_PlayLists&&&" & arr_PLP(aa).source_path & "|||" & arr_PLP(aa).destination_path
        aa = aa + 1
    Else
        aa = 0
        read_PlayLists_xml
    End If
    Exit Sub
Error:
   WriteEvent "copy_Playlists_xml", Err.Description, Err.Source
End Sub

Public Sub read_PlayLists_xml()
   On Error GoTo Error
    Static bb As Integer
    Dim doc_p As New DOMDocument
    Dim roo_p As IXMLDOMElement
    Dim ele_p As IXMLDOMElement
    Dim i  As Integer
re:
    If bb <= UBound(arr_PLP) Then
        index_path = bb
        If Dir(arr_PLP(bb).destination_path & "\PlayLists.xml") <> "" Then
            doc_p.Load arr_PLP(bb).destination_path & "\PlayLists.xml"
            If doc_p.parseError = 0 Then
               Set roo_p = doc_p.firstChild
               ReDim Preserve arr_PL(-1 To -1)
               For i = 0 To roo_p.childNodes.Length - 1
                   Set ele_p = doc_p.firstChild.childNodes(i)
                   ReDim Preserve arr_PL(-1 To i)
                   arr_PL(i) = ele_p.Text
               Next i
                     
               If UBound(arr_PL) = -1 Then
                   bb = bb + 1
                   GoTo re
               Else
                   bb = bb + 1
                   copy_all_playlist_xmls
               End If
            End If
       Else
           bb = bb + 1
           GoTo re
       End If
    Else
        bb = 0
        create_all_playlists_for_connected_to
        If IndexSwf = 3 Then
            FrmMain.reloadPlaylistPath_xml
        End If
    End If
   Exit Sub
Error:
   WriteEvent "read_PlayLists_xml", Err.Description, Err.Source
End Sub

Public Sub copy_all_playlist_xmls()
   On Error GoTo Error
    Static cc As Integer
    If cc <= UBound(arr_PL) Then
        CWinsock.Send2Server WS_COMMAND, "request_copy_each_playlists&&&" & arr_PLP(index_path).source_path & "\" & arr_PL(cc) & ".xml" & "|||" & arr_PLP(index_path).destination_path & "\" & arr_PL(cc) & ".xml"
        cc = cc + 1
    Else
        cc = 0
        read_PlayLists_xml
    End If
    Exit Sub
Error:
   WriteEvent "copy_all_playlist_xmls", Err.Description, Err.Source
End Sub

Sub create_all_playlists_for_connected_to()
   On Error GoTo ErrorCopyFile:
    If friend_playlist = True Then
        Dim tp As String, tm As String, TF As String
        Dim doc_c As New DOMDocument
        Dim roo_c As IXMLDOMElement
        Dim ele_c As IXMLDOMElement
        Dim i, j, n, c, ind As Integer
        Dim TN() As String  'Temp Name Playlist
        
        tp = str_main_playlist_path & "\PlayLists\PlayLists.xml"
        
        If isFileExist(tp) Then DeleteFile tp
        CreateDirectory str_main_playlist_path & "\PlayLists"
        doc_c.Load tp
        Set roo_c = doc_c.createElement("PlayLists")
        doc_c.appendChild roo_c
        doc_c.Save tp
        
        ReDim Preserve TN(-1 To -1)
        For i = 0 To UBound(arr_PLP)
            tm = arr_PLP(i).destination_path
            If isFileExist(tm & "PlayLists.xml") Then
                doc_c.Load tm & "PlayLists.xml"
                Set roo_c = doc_c.firstChild
                For j = 0 To roo_c.childNodes.Length - 1
                     DoEvents                               'don't make it crash while copying file
                    Set ele_c = doc_c.firstChild.childNodes(j)
                    TF = ele_c.Text
                    c = 0
                    For n = 0 To UBound(TN)
                        If TF = TN(n) Then c = c + 1
                    Next n
                    
                    ReDim Preserve TN(-1 To ind)
                    If c = 0 Then
                        fso.CopyFile tm & TF & ".xml", str_main_playlist_path & "PlayLists\" & TF & ".xml", True
                        TN(ind) = TF
                    Else
                        fso.CopyFile tm & TF & ".xml", str_main_playlist_path & "PlayLists\" & TF & "-" & c & ".xml", True
                        TN(ind) = TF & "-" & c
                    End If
                    ind = ind + 1
                Next j
            End If
        Next i
        
        doc_c.Load tp
        Set roo_c = doc_c.firstChild
        For i = 0 To UBound(TN)
            Set ele_c = doc_c.createElement("PlayList")
            ele_c.setAttribute "SlidePath", ""
            ele_c.setAttribute "ImgPath", App.path & "\sly\PlaylistIcon.sly"
            ele_c.Text = TN(i)
            roo_c.appendChild ele_c
        Next i
        doc_c.Save tp
        
        Dim B As Boolean
        Dim pn As String
        
        If server_nick_name <> "" Then
            pn = server_nick_name
        Else
            pn = server_name_connected
        End If
        B = False
        doc_c.Load run_stringDefaultPlayListPath & "\PlayListPaths.xml"
        Set roo_c = doc_c.firstChild
        For i = 0 To roo_c.childNodes.Length - 1
            Set ele_c = doc_c.firstChild.childNodes(i)
            If LCase(ele_c.getAttribute("Name")) = LCase(pn) And LCase(ele_c.Text) = LCase(mID(str_main_playlist_path, 1, Len(str_main_playlist_path) - 1)) Then
                B = True
            End If
        Next i
        If B = False Then
            Set ele_c = doc_c.createElement("PlayListPath")
            ele_c.setAttribute "Name", pn
            ele_c.setAttribute "ImgPath", ""
            ele_c.Text = mID(str_main_playlist_path, 1, Len(str_main_playlist_path) - 1)
            roo_c.appendChild ele_c
            'doc_c.Save run_stringDefaultPlayListPath & "\PlayListPaths.xml"
            doc_c.Save str_main_playlist_path & "\PlayListPaths.xml"
        End If
    End If
    Exit Sub
ErrorCopyFile:
   WriteEvent "create_all_playlists_for_connected_to", Err.Description, Err.Source
End Sub
'*******************************************************************************
' Function Name     :   getKhmerCountry
' Description       :   return whether current country is khmer for displaying khmer text in flash
' Return Values     :   0 non-khmer,1 khmer
' Input Parameter   :   Language name("Khmer Music")
'-------------------------------------------------------------------------------
' Written by        Date                Modified Contents
'-------------------------------------------------------------------------------
' Seng             10-24-2005           New
'*******************************************************************************
Public Function getKhmerCountry(lpCountryName As String) As Integer
   If InStr(1, lpCountryName, "Khmer", vbTextCompare) > 0 Then
      getKhmerCountry = 1
   Else
      getKhmerCountry = 0
   End If
End Function
Public Function get_current_playlist_path(str_xmlMainPath As String) As String
   On Error GoTo Error
   Dim doc_x As New DOMDocument
   Dim roo_x As IXMLDOMElement
   Dim ele_x As IXMLDOMElement
   Dim i As Integer
   Dim s As String
   
   doc_x.Load str_xmlMainPath & "\PlayListPaths.xml"
   Set roo_x = doc_x.firstChild
   s = roo_x.getAttribute("StoreName")
   For i = 0 To roo_x.childNodes.Length - 1
      Set ele_x = doc_x.firstChild.childNodes(i)
      If LCase(s) = LCase(ele_x.getAttribute("Name")) Then
         get_current_playlist_path = ele_x.Text
      End If
   Next i
   Exit Function
Error:
   WriteEvent "get_current_playlist_path", Err.Description, Err.Source
End Function

Public Function Get2SubFolders(inputFolder As String) As String
   On Error GoTo Error
   Dim fs As New FileSystemObject
   Dim firstFolder As String
   Dim secondFolder As String
   
   firstFolder = fs.GetParentFolderName(inputFolder)
   secondFolder = fs.GetParentFolderName(fs.GetParentFolderName(inputFolder))
   Get2SubFolders = fs.BuildPath(fs.GetBaseName(secondFolder), fs.GetBaseName(firstFolder))
   Exit Function
Error:
   WriteEvent "Get2SubFolders", Err.Description, Err.Source
End Function

Public Function isVideoFile(filename As String) As Boolean
   isVideoFile = InStr(1, ";" & PlayerVideoFile & ";", ";" & fso.GetExtensionName(filename) & ";", vbTextCompare) > 0
End Function
Public Property Let ShowMouse(bValue As Boolean)
   Static bHided As Boolean
   If bValue = True Then
      If bHided = True Then
         ShowCursor True
         bHided = False
      End If
   Else
      If bHided = False Then
         ShowCursor False
         bHided = True
      End If
   End If
End Property
Public Sub scaleWMPVdeo()
   On Error GoTo Error
   Dim W As Long, h As Long
   Dim objPicture As PictureBox
   
   If run_FormVideoLoaded Then
      Set objPicture = frmVideo.picVideo
   Else
      Set objPicture = FrmMain.picwmp
   End If
   MovePlayingImage
   
   If int_track_count > 0 Then
      If PlayTrackInfo(int_current_index).ZoomLevel < -30 Then PlayTrackInfo(int_current_index).ZoomLevel = -30      'prevent from make width negative
      W = ((objPicture.Width * (PlayTrackInfo(int_current_index).ZoomLevel * 0.026 + 1)))
      h = ((objPicture.Height * (PlayTrackInfo(int_current_index).ZoomLevel * 0.026 + 1)))
      'CPlayer.Move (objPicture.Width - W) / 2, (objPicture.Height - h) / 2, W, h
      CPlayer.Move 0, 0, objPicture.Width, objPicture.Height, PlayTrackInfo(int_current_index).ZoomLevel
      
   End If
  Exit Sub
Error:
   WriteEvent "scaleWMPVdeo", Err.Description, Err.Source
End Sub

Public Sub setSubTitleWMP()
On Error GoTo errDesc:
  'Dim oldStatus As Single
  Dim oldPos As Long
  Dim i As Integer
  Dim titlenum As Integer
  Dim currentFileExtension As String
 ' Dim r As Rect
   
  boolPress = True
  Screen.MousePointer = MousePointerConstants.vbHourglass
  sendToFlash FrmMain.Swf(IndexSwf), "MouseState", True
  currentFileExtension = LCase(fso.GetExtensionName(str_current_Track))
  If currentFileExtension = "ifo" Or currentFileExtension = "mp4" Then
      '(1 Movie,2 TVSeries,4 Music,8 Karaoke)
      If Not Infos(int_current_index).trackExternal Then
         If val((SlyVariable("<" & PlayTrackInfo(int_current_index).Language & "_id>"))) = 8 Then
         'if the track is internal and it is karaoke then don't turn the subtitle on/off
           Screen.MousePointer = MousePointerConstants.vbDefault
           sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
           boolPress = False
            Exit Sub
         End If
      End If
      'PlayTrackInfo(int_current_index).SubTitle = Not PlayTrackInfo(int_current_index).SubTitle
      If currentFileExtension = "mp4" Then
         TurnHaaliOnOff PlayTrackInfo(int_current_index).SubTitle
         TurnFFDShowsubTitle = Not TurnFFDShowsubTitle
      Else
         TurnWmpTitleOnOff PlayTrackInfo(int_current_index).SubTitle
      End If
    'xxx change sith for currentFind = subtitle
    
      '============== sith 30-1-07 =====================
      '=================================================
      OldWMPPos = CPlayer.Seeks
      CurrentFind = subTitled
      startNew = True
      run_loading = True
      Screen.MousePointer = vbHourglass
      DoEvents
      
      CPlayer.url = str_current_Track
      FrmMain.tmr.Enabled = False
      FrmMain.picMovieBackground.Visible = False
      CPlayer.Volume = 0
      
      'FrmMain.tmrFindTime = True
   'xxx end
   End If
   SetForegroundWindow FrmMain.hwnd
   Screen.MousePointer = MousePointerConstants.vbDefault
   sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
   boolPress = False
   Exit Sub
errDesc:
'''   MsgBox Err.Description
  boolPress = False
  Screen.MousePointer = MousePointerConstants.vbDefault
  sendToFlash FrmMain.Swf(IndexSwf), "MouseState", False
  'CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & getCurrentDuration & "&&&" & getPlayState
  CWinsock.Send2Client WS_COMMAND, 0, "setSeekTime&&&" & CPlayer.Seeks & "&&&" & getPlayState
  WriteEvent "setSubTitleWMP", Err.Description, Err.Source
   'MsgBox Err.Description
End Sub
Public Sub MovePlayingImage()
   FrmMain.swfImagePlaying.Move 0, 0, FrmMain.picwmp.Width, FrmMain.picwmp.Height
End Sub
