VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "AlbumType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public CDDBDiskID As String
Public AlbumArtist As String                  'Production
Public AlbumImagePath As String
Public ALBUM As String                        'Album Title
Public albumID As Integer
Public Genre As String
Public TrackCount As Integer
Public Year As String
Public AlbumLanguage As String
Public CountryID As String

Private inv_Tracks As New Collection

Public Property Get Tracks(ByVal Index As Integer) As listType
  Set Tracks = inv_Tracks.item(Index)
End Property
Public Function TrackAdd(tmpList As listType)
  inv_Tracks.Add tmpList
End Function
Public Function TrackRemove(Index As Integer)
  inv_Tracks.Remove Index
End Function
Public Sub SetTrackCount(intCount As Integer)
  Dim i As Integer, tmp As listType
  For i = 1 To intCount
    Set tmp = New listType
    If inv_Tracks.count = intCount Then Exit For
    inv_Tracks.Add tmp
  Next
  TrackCount = intCount
End Sub
Public Sub TrackClear()
  Dim i As Integer
  For i = 1 To inv_Tracks.count
    inv_Tracks.Remove i
  Next
End Sub


