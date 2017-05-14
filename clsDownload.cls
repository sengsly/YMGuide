VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'''Public str1 As String
'''Public str2 As String
'''Public Name As String
'''Public IndexLoadSwf As Integer


Public Enum DOWNLOADENUM
   DL_ALBUM = 1
   DL_UPDATE = 2
   DL_MEDIA = 3
   DL_PURCHASEMEDIA = 4
   DL_ARTIST = 5
   DL_BACK = 6
End Enum


Public SourceFile As String
Public TemporaryFile As String
Public DesFile As String
Public LanguageID As Long
Public albumID As Long
Public TrackID As Long
Public Data1 As String
Public Data2 As String
Public IndexLoadSwf As Long
Public Language As String
Public DownloadType As DOWNLOADENUM

'Public path As String
'Public Index As String
'Public path As String
'Public Language As String              'Language Name
'Public ToDirectory As String           'Destination directory

