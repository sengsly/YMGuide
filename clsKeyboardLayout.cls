VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsKeyboardLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Const KL_NAMELENGTH As Long = 9                      'length of the keyboardbuffer
Const KLF_ACTIVATE  As Long = &H1                     'activate the layout

'the language constants
'00020409
Const LANG_NL_STD As String = "00000413"
Const LANG_EN_US As String = "00020409"          'Changed from     00000409
Const LANG_EN_UIN As String = "00020409"      'Changed from     00000409        'United State International
Const LAN_CA_NIDA As String = "A0000403"
Const LANG_DU_STD As String = "00000407"
Const LANG_FR_STD As String = "0000040C"
Const LANG_CH_PRC As String = "e00e0804"
Const LANG_JP_JPN As String = "00000411"
Const LANG_TH_THA As String = "0000041E"
Const LANG_VI_VET As String = "0000042A"
Const LANG_KO_KOR As String = "00000412"
'HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Keyboard Layouts

'api's to adjust the keyboardlayout
Private Declare Function GetKeyboardLayoutName Lib "user32" Alias "GetKeyboardLayoutNameA" (ByVal pwszKLID As String) As Long
Private Declare Function LoadKeyboardLayout Lib "user32" Alias "LoadKeyboardLayoutA" (ByVal pwszKLID As String, ByVal flags As Long) As Long

Private languageArray As Variant

'KeyboardName
Private Function SetKbLayout(strLocaleId As String) As Boolean
    'Changes the KeyboardLayout
    'Returns TRUE when the KeyboardLayout was adjusted properly, FALSE otherwise
    'If the KeyboardLayout isn't installed, this function will install it for you
    On Error Resume Next
    Dim strLocId As String 'used to retrieve current KeyboardLayout
    Dim strMsg As String   'used as buffer
    Dim lngErrNr As Long   'receives the API-error number

  'create a buffer
  strLocId = String(KL_NAMELENGTH, 0)
  'retrieve the current KeyboardLayout
  GetKeyboardLayoutName strLocId
  'Check whether the current KeyboardLayout and the
  'new one are the same
  If strLocId = (strLocaleId & Chr(0)) Then
    'If they're the same, we return immediately
    SetKbLayout = True
  Else
    'create buffer
    strLocId = String(KL_NAMELENGTH, 0)
    'load and activate the layout for the current thread
    strLocId = LoadKeyboardLayout((strLocaleId & Chr(0)), KLF_ACTIVATE)
    If IsNull(strLocId) Then  'returns NULL when it fails
      SetKbLayout = False
    Else 'check again
      'create buffer
      strLocId = String(KL_NAMELENGTH, 0)
      'retrieve the current layout
      GetKeyboardLayoutName strLocId
      If strLocId = (strLocaleId & Chr(0)) Then
        SetKbLayout = True
      Else
        SetKbLayout = False
      End If
    End If
  End If
End Function

Public Function SetKeyBoardLanguage(ByVal languageName As String) As Boolean
   On Error GoTo Error
   Dim i As Long
   Dim layoutlanguageID As String
   Dim mainLanguageName As String
   Dim splLan() As String
   'change keyboardlaout by name
   
   If languageName <> "" Then
      splLan = Split(languageName, " ")
      mainLanguageName = splLan(0)        'Ex: Khmer Karaoke
   Else
      mainLanguageName = languageName
   End If
   For i = 0 To UBound(languageArray) Step 2
      If StrComp(languageArray(i), mainLanguageName, vbTextCompare) = 0 Then
         layoutlanguageID = languageArray(i + 1)
         SetKbLayout layoutlanguageID
         Exit Function
      End If
   Next
   Exit Function
Error:
   WriteEvent "SetKeyBoardLanguage", Err.Description, Err.Source
End Function

Private Sub Class_Initialize()
   On Error GoTo Error
   languageArray = Array("english", LANG_EN_US, "khmer", LAN_CA_NIDA, "chinese", LANG_CH_PRC, "vietnamese", LANG_VI_VET, "korean", LANG_KO_KOR, "japanese", LANG_JP_JPN, "thai", LANG_TH_THA)
   Exit Sub
Error:
   WriteEvent "Class_Initialize", Err.Description, Err.Source
End Sub
