VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cJSONScript"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim dictVars As New Dictionary
Dim plNestCount As Long


Public Function Eval(sJSON As String) As String
   Dim SB As New cStringBuilder
   Dim o As Object
   Dim c As Object
   Dim i As Long
   
   Set o = JSON.parse(sJSON)
   If (JSON.GetParserErrors = "") And Not (o Is Nothing) Then
      For i = 1 To o.count
         Select Case VarType(o.item(i))
         Case vbNull
            SB.Append "null"
         Case vbDate
            SB.Append CStr(o.item(i))
         Case vbString
            SB.Append CStr(o.item(i))
         Case Else
            Set c = o.item(i)
            SB.Append ExecCommand(c)
         End Select
      Next
   Else
      MsgBox JSON.GetParserErrors, vbExclamation, "Parser Error"
   End If
   Eval = SB.toString
End Function

Public Function ExecCommand(ByRef obj As Variant) As String
   Dim SB As New cStringBuilder
   
   If plNestCount > 40 Then
      ExecCommand = "ERROR: Nesting level exceeded."
   Else
      plNestCount = plNestCount + 1
      
      Select Case VarType(obj)
         Case vbNull
            SB.Append "null"
         Case vbDate
            SB.Append CStr(obj)
         Case vbString
            SB.Append CStr(obj)
         Case vbObject
            
            Dim i As Long
            Dim j As Long
            Dim this As Object
            Dim key
            Dim paramKeys
            
            If typeName(obj) = "Dictionary" Then
               Dim sOut As String
               Dim sRet As String
   
               Dim keys
               keys = obj.keys
               For i = 0 To obj.count - 1
                  sRet = ""
             
                  key = keys(i)
                  If VarType(obj.item(key)) = vbString Then
                     sRet = obj.item(key)
                  Else
                     Set this = obj.item(key)
                  End If
                  
                  ' command implementation
                  Select Case LCase(key)
                  Case "alert":
                     MsgBox ExecCommand(this.item("message")), vbInformation, ExecCommand(this.item("title"))
                     
                  Case "input":
                     SB.Append InputBox(ExecCommand(this.item("prompt")), ExecCommand(this.item("title")), ExecCommand(this.item("default")))
                     
                  Case "switch"
                     sOut = ExecCommand(this.item("default"))
                     sRet = LCase(ExecCommand(this.item("case")))
                     For j = 0 To this.item("items").count - 1
                        If LCase(this.item("items").item(j + 1).item("case")) = sRet Then
                           sOut = ExecCommand(this.item("items").item(j + 1).item("return"))
                           Exit For
                        End If
                     Next
                     SB.Append sOut
                  
                  Case "set":
                     If dictVars.Exists(this.item("name")) Then
                        dictVars.item(this.item("name")) = ExecCommand(this.item("value"))
                     Else
                        dictVars.Add this.item("name"), ExecCommand(this.item("value"))
                     End If
                     
                  Case "get":
                     sRet = ExecCommand(dictVars(CStr(this.item("name"))))
                     If sRet = "" Then
                        sRet = ExecCommand(this.item("default"))
                     End If
                     
                     SB.Append sRet
                     
                  Case "if"
                     Dim val1 As String
                     Dim val2 As String
                     Dim bRes As Boolean
                     val1 = ExecCommand(this.item("value1"))
                     val2 = ExecCommand(this.item("value2"))
                     
                     bRes = False
                     Select Case LCase(this.item("type"))
                     Case "eq" ' =
                        If LCase(val1) = LCase(val2) Then
                           bRes = True
                        End If
                        
                     Case "gt" ' >
                        If val1 > val2 Then
                           bRes = True
                        End If
                     
                     Case "lt" ' <
                        If val1 < val2 Then
                           bRes = True
                        End If
                     
                     Case "gte" ' >=
                        If val1 >= val2 Then
                           bRes = True
                        End If
                     
                     Case "lte" ' <=
                        If val1 <= val2 Then
                           bRes = True
                        End If
                     
                     End Select
                     
                     If bRes Then
                        SB.Append ExecCommand(this.item("true"))
                     Else
                        SB.Append ExecCommand(this.item("false"))
                     End If
                     
                  Case "return"
                     SB.Append obj.item(key)
                  
                     
                  Case Else
                     If typeName(this) = "Dictionary" Then
                        paramKeys = this.keys
                        For j = 0 To this.count - 1
                           If j > 0 Then
                              sRet = sRet & ","
                           End If
                           sRet = sRet & CStr(this.item(paramKeys(j)))
                        Next
                     End If
                     
                     
                     SB.Append "<%" & UCase(key) & "(" & sRet & ")%>"
                     
                  End Select
               Next i
               
            ElseIf typeName(obj) = "Collection" Then
   
               Dim Value
               For Each Value In obj
                  SB.Append ExecCommand(Value)
               Next Value
               
            End If
            Set this = Nothing
   
         Case vbBoolean
            If obj Then SB.Append "true" Else SB.Append "false"
         
         Case vbVariant, vbArray, vbArray + vbVariant
         
         Case Else
            SB.Append Replace(obj, ",", ".")
      End Select
      plNestCount = plNestCount - 1
   End If
   
   ExecCommand = SB.toString
   Set SB = Nothing
   
End Function






