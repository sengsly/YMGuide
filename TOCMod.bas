Attribute VB_Name = "TOCMod"
Option Explicit

Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Public Type MSFType
  Mins As Integer
  Secs As Integer
  Frames As Integer
End Type
'12+96+416B+7B34+B7AC+1053B+1460E+1882D+1D4D1+21F36+2757E+2B6F1+30142+342F8+38284+3C494+413C5+44F86+49363+4D5F8

Public cdtoc() As MSFType
Public Function FramesToMSF(lngValue As Long) As MSFType
'  Dim tmp As MSFType
  FramesToMSF.Frames = lngValue Mod 75
  lngValue = lngValue \ 75
  FramesToMSF.Secs = lngValue Mod 60
  FramesToMSF.Mins = lngValue \ 60
End Function
Sub Test(a As Long)
  Dim y As MSFType
  y = FramesToMSF(a)
  Debug.Print y.Mins, y.Secs, y.Frames
  
End Sub
Public Function DiskID(strToc As String) As Long
  Dim varSplit As Variant, i As Integer
  Dim tocMSF As MSFType, intUbound As Integer
  Dim lngValue As Long
  If strToc <> "" Then
    varSplit = Split(strToc, "+")
    intUbound = UBound(varSplit)
    ReDim cdtoc(intUbound - 1)
    For i = 1 To intUbound
      lngValue = Val(CLng("&h" & varSplit(i)))
      cdtoc(i - 1) = FramesToMSF(lngValue)
    Next
    DiskID = cddb_discid(cdtoc(), intUbound - 1)
  Else
    
  End If
End Function
'test 150
Public Function cddb_sum(n As Integer) As Integer
  Dim ret As Integer

  ret = 0

  While (n > 0)
    ret = ret + (n Mod 10)
    n = n \ 10
  Wend
  cddb_sum = ret
End Function

Public Function cddb_discid(toc() As MSFType, tot_trks As Integer) As Long
  Dim i As Integer, t As Integer, n As Integer
  
  i = 0
  While (i < tot_trks)
    n = n + cddb_sum((cdtoc(i).Mins * 60) + cdtoc(i).Secs)
    i = i + 1
  Wend

  t = ((cdtoc(tot_trks).Mins * 60) + cdtoc(tot_trks).Secs) - ((cdtoc(0).Mins * 60) + cdtoc(0).Secs)

  i = 0
  Dim MiddleString As String
  MiddleString = Hex((t * 2 ^ 8) Or (tot_trks))
  MiddleString = String(6 - Len(MiddleString), "0") + MiddleString
'  cddb_discid = Val("&h" + Hex((n Mod &HFF)) & Format(Hex((t * 2 ^ 8) Or (tot_trks)), "0000"))
  cddb_discid = Val("&h" + Hex((n Mod &HFF)) & MiddleString)
End Function



