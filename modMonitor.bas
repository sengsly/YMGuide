Attribute VB_Name = "modMonitor"
Option Explicit
Private Declare Function EnumDisplayMonitors Lib "User32.dll" (ByVal hdc As Long, ByVal lprcClip As Long, ByVal lpfnEnum As Long, ByVal dwData As Long) As Boolean
Private Declare Function GetMonitorInfo Lib "User32.dll" Alias "GetMonitorInfoA" (ByVal hMonitor As Long, lpmi As MONITORINFO) As Boolean
Public Declare Function MonitorFromRect Lib "User32.dll" (Rect As Rect, ByVal dwFlags As Long) As Long

Public Const MONITORINFOF_PRIMARY = 1
Public Const MONITOR_DEFAULTTONULL = &H0
Public Const MONITOR_DEFAULTTOPRIMARY = &H1
Public Const MONITOR_DEFAULTTONEAREST = &H2

Public Enum MonitorEnum
   MonitorStandard = 1
   MonitorWide16x09 = 2
   MonitorWide16x10 = 3
End Enum

Private Type MONITORINFO
    cbSize As Long
    rcMonitor As Rect
    rcWork As Rect
    dwFlags As Long
End Type
Public Type RECTM
   left As Long
   top As Long
   Width As Long
   Height As Long
End Type
Public Type MONITOR
   hMonitor As Long
   isPrimary As Boolean
   rcWork As RECTM
End Type
Private MonitorInfos() As MONITOR
Public Function RefreshMonitors() As Boolean
   ReDim MonitorInfos(-1 To -1)
   RefreshMonitors = EnumDisplayMonitors(0&, 0&, AddressOf MonitorEnumProc, 0&)
End Function
Public Function GetMonitorRect(ByVal iIndex As Integer) As MONITOR
   'RefreshMonitors                           'Refresh Monitor       no need to refresh
   If iIndex <= UBound(MonitorInfos) And iIndex >= 0 Then
      GetMonitorRect = MonitorInfos(iIndex)
   End If
End Function
Private Function MonitorEnumProc(ByVal hMonitor As Long, ByVal hdcMonitor As Long, lprcMonitor As Rect, ByVal dwData As Long) As Boolean
   Dim iMonitor As Long, lpMonitor As MONITORINFO
   
   With lprcMonitor
      lpMonitor.cbSize = Len(lpMonitor)
      If GetMonitorInfo(hMonitor, lpMonitor) Then
         iMonitor = UBound(MonitorInfos) + 1
         ReDim Preserve MonitorInfos(-1 To iMonitor)
         MonitorInfos(iMonitor).hMonitor = hMonitor
         MonitorInfos(iMonitor).rcWork.left = lpMonitor.rcMonitor.left
         MonitorInfos(iMonitor).rcWork.top = lpMonitor.rcMonitor.top
         MonitorInfos(iMonitor).rcWork.Width = lpMonitor.rcMonitor.right - lpMonitor.rcMonitor.left
         MonitorInfos(iMonitor).rcWork.Height = lpMonitor.rcMonitor.bottom - lpMonitor.rcMonitor.top
         MonitorInfos(iMonitor).isPrimary = (lpMonitor.dwFlags = MONITORINFOF_PRIMARY)
      End If
   End With
   MonitorEnumProc = True
End Function
Public Property Get MonitorCount() As Long
   On Error GoTo ErrorMonitor
   'RefreshMonitors                           'Refresh Monitor    'NO need to refresh,refresh when debug=0
   MonitorCount = UBound(MonitorInfos) + 1
ErrorMonitor:
End Property
'======================================================================================================
Public Function MonitorRectMFromHandle(ByVal hMonitor As Long) As RECTM
   Dim lpMonitor As MONITORINFO
   Dim rtM As RECTM
   lpMonitor.cbSize = Len(lpMonitor)
   If GetMonitorInfo(hMonitor, lpMonitor) Then
      rtM.left = lpMonitor.rcWork.left
      rtM.top = lpMonitor.rcWork.top
      rtM.Width = lpMonitor.rcWork.right - lpMonitor.rcWork.left
      rtM.Height = lpMonitor.rcWork.bottom - lpMonitor.rcWork.top
      MonitorRectMFromHandle = rtM
   End If
End Function
Public Function MonitorRECTM(ByVal iMonitor As Integer) As RECTM
   'In pixel
   If iMonitor >= MonitorCount Then iMonitor = 0
   MonitorRECTM = GetMonitorRect(iMonitor).rcWork
End Function
Public Sub MoveForm2Monitor(ByVal iMonitor As Integer, hForm As Long, iLeft As Long, iTop As Long)
   'In pixel
   Dim rt As RECTM
   If iMonitor >= MonitorCount Then iMonitor = 0
   rt = GetMonitorRect(iMonitor).rcWork
   SetWindowPos hForm, 0, rt.left + iLeft, rt.top + iTop, 0, 0, SWP_NOACTIVATE Or SWP_NOZORDER Or SWP_NOSIZE
End Sub
Public Sub ResizeFormPixel(hForm As Long, iWidth As Long, iHeight As Long)
   'In pixel
   SetWindowPos hForm, 0, 0, 0, iWidth, iHeight, SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOZORDER
End Sub
'======================================================================================================

Public Function GetMonitorType(iIndex As Integer) As MonitorEnum
'''   MonitorStandard
   Dim rm As RECTM
   rm = MonitorRECTM(iIndex)
   Select Case ChooseScreen(rm.Width / rm.Height, "Both")
'''largeWideScreen
'''mediumLargeWideScreen
'''mediumWideScreen
'''smallWideScreen
'''wideScreen
      Case "largeWideScreen"
         GetMonitorType = MonitorWide16x09
      Case "mediumWideScreen"
         GetMonitorType = MonitorWide16x09
      Case "smallWideScreen"
         GetMonitorType = MonitorWide16x09
      Case "wideScreen"
         GetMonitorType = MonitorWide16x09
      Case "mediumLargeWideScreen"
         GetMonitorType = MonitorWide16x10
      Case "Normal"
         GetMonitorType = MonitorStandard
      Case Else
         GetMonitorType = MonitorStandard
   End Select
End Function
