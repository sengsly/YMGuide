VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "listType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Title  As String
Public ARTIST As String
Public Genre As String
Public Year As String
Public Length As String
Public Author As String
Public RecordIndex As Long
Public TrackID As Long

Public AlbumArtist As String
Public ALBUM As String
Public Selected As Boolean
Public Path As String
Public TrackNumber As Integer


