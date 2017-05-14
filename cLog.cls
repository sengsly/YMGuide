VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cLog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Sub Writelog(lpFunctionName As String, LOGTYPE As String, errDesc As String, param As String)
   'Debug.Print lpFunctionName, LOGTYPE, errDesc, param
   #If Log = 1 Then
      On Error Resume Next
      Dim ts As TextStream
      Dim txtLog As String
      
      'To handle the log file and event loggging
      Set ts = fso.OpenTextFile(App.Path & "\log " & Format(Date, "yyyymm") & ".txt", ForAppending, True)
      '2013-07-02 08:44:33, 351 ERROR [T=577] [com.dd.oms.net.med.util.RequestTask.run() 130] Request timed out, request=[equest owner=NetEco.PM, id=232232, target=[Target host=, Protocol=BINARY], params=class]
      txtLog = Now & vbTab & LOGTYPE & ",[" & lpFunctionName & "] " & errDesc & " [" & param & "]"
      Debug.Print txtLog
      ts.WriteLine txtLog
      ts.Close
      If LOGTYPE = "ERROR" Then
         'MsgBox txtLog
      End If
   #End If
   
End Sub

Public Function LogPara(ParamArray para() As Variant) As String
   'A pair of paraname and paravalue...ex mLog,10=> mLog=10
   Dim i As Integer
   Dim mRet As String
   If (UBound(para) Mod 2) = 1 Then       'Accept only even arguments with zero index
      For i = 0 To UBound(para) Step 2
         If mRet <> "" Then
            mRet = mRet & ", " & para(i) & " = " & para(i + 1)
         Else
            mRet = para(i) & " = " & para(i + 1)
         End If
      Next
   End If
   LogPara = mRet
End Function
