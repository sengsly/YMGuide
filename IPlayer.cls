VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "IPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Enum EnumTimerTask
   TaskNone = 0
   TaskWaitForPlayed = 1
   TaskPositionChange = 2
   TaskWaitForLoaded = 3
End Enum

Public Function ZoomReset() As Boolean
   
End Function

Public Property Get Duration() As Single
End Property

Public Property Let Mute(ByVal RHS As Boolean)
End Property
Public Property Get Mute() As Boolean

End Property
Public Property Get HasVideo() As Boolean

End Property

Public Sub object(wmpObject As Object, wmpTimer As Timer, SourcePlayer As Player)
End Sub

Public Sub Pause()
End Sub

Public Sub Play()
End Sub

Public Property Let Seeks(RHS As Single)
End Property

Public Property Get Seeks() As Single
End Property
Public Sub Stops()
End Sub
Public Function NextChapter() As Boolean

End Function
Public Function PreviousChapter() As Boolean

End Function

Public Function SwitchAudio(Optional iChannel As Integer = -1) As Integer
End Function
Public Function SelectTitle(ByVal iTitle As Integer) As Boolean
End Function

Public Function SelectChapter(ByVal iChapter As Integer) As Boolean
End Function

Public Function SwitchSubtitle(Optional iSubtitle As Integer = -1) As Integer
'
End Function

Public Property Let url(ByVal RHS As String)
End Property
Private Function SetWmpURL(newURL As String) As IWMPMedia
End Function


Public Property Let Volume(ByVal RHS As Single)
End Property
Public Property Get Volume() As Single
End Property

Public Sub Move(ByVal left As Single, ByVal top As Single, ByVal Width As Single, ByVal Height As Single, ByVal ZoomLevel As Integer)
End Sub

Public Sub ClearPlayList()
End Sub

Public Property Let ZoomLevel(iValue As Integer)
End Property

Public Property Get MediaIsnothing() As Boolean
End Property
Public Property Get IsInMenuMode() As Boolean
End Property

'getBitrateSong
Public Property Get getBitrateSong() As String
End Property

Public Property Let AudioLanguageIndex(iValue As Integer)
End Property

Public Property Get AudioLanguageIndex() As Integer
End Property

Public Function currentChapter() As Long
End Function

Public Property Get chapterCount() As Integer
End Property

Public Property Get TitleCount() As Integer
End Property

Public Function playState() As Integer
End Function
Public Property Let stretchToFit(iValue As Boolean)
End Property

Public Property Get Visible() As Boolean
End Property

Public Property Let Visible(iValue As Boolean)
End Property

Public Function GotoRootMenu() As Boolean
End Function
Public Property Get Status() As String

End Property

Public Function hVideo(ByVal hSource As Long) As Long
End Function

Public Property Get UiMode() As String

End Property

Public Property Let UiMode(iValue As String)

End Property

Public Sub SetNewParent(ByVal hNewParent As Long)

End Sub

Public Sub RestoreParent()

End Sub
