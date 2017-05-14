VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "AWSS3Heper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private Declare Sub xLiteSha1Hmac Lib "xlitesha1hmac.dll" Alias "sha1hmac" (ByVal sDigest As String, ByRef aByteArray As Byte, ByVal nLength As Long, ByRef aKeyArray As Byte, ByVal nKeyLen As Long)
Private Declare Function xLiteMD5File Lib "xlitesha1hmac.dll" Alias "md5File" (ByVal sfileName As String, ByVal sDigest As String) As Integer
Private Declare Sub xLiteMD5Text Lib "xlitesha1hmac.dll" Alias "md5Text" (ByRef aTextArray As Byte, ByVal nTextLen As Long, ByVal sDigest As String)
Private Declare Function GetTimeZoneInformation Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Long

Private Const AWS_ACCESS_KEY_ID = "AKIAIJNVUAMAOHAQVYFA"
Private Const AWS_SECRET_ACCESS_KEY = "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"
Private Const AWS_URLSymbol = " !@#$%&*()_="
Private Const TIME_ZONE_ID_INVALID& = &HFFFFFFFF
Private Const TIME_ZONE_ID_STANDARD& = 1
Private Const TIME_ZONE_ID_UNKNOWN& = 0
Private Const TIME_ZONE_ID_DAYLIGHT& = 2

Private Const YMGUIDE_URL = "https://s3-us-west-1.amazonaws.com"
Private Const YMGUIDE_ROOT = "/ymg-karaoke/"
''      bucketURL = "/ymg-karaoke/" & Replace(RTrim(mTrack.VideoURL), " ", "+")


Private Type SYSTEMTIME
    wYear As Integer
    wMonth As Integer

    wDayOfWeek As Integer
    wDay As Integer
    wHour As Integer

    wMinute As Integer
    wSecond As Integer
    wMilliseconds As Integer

End Type
Private Type TIME_ZONE_INFORMATION
    Bias As Long
    StandardName(31) As Integer
    StandardDate As SYSTEMTIME
    StandardBias As Long
    DaylightName(31) As Integer
    DaylightDate As SYSTEMTIME
    DaylightBias As Long

End Type
Public Function getYMGuideURL(buckName As String) As String
   Dim bucketURL As String
   bucketURL = YMGUIDE_ROOT & Replace(RTrim(buckName), " ", "+")
'''      bucketURL = "/ymg-karaoke/" & Replace(RTrim(mTrack.VideoURL), " ", "+")
      getYMGuideURL = Me.getSignedURL(YMGUIDE_URL & bucketURL, "GET", "", "", 0, "", bucketURL)

End Function

Function getSignedURL(inURL As String, inVERB As String, inCONTENT_MD5 As String, inCONTENT_TYPE As String, _
                      inTTLSeconds As Long, inAmzHeaders As String, inResource As String) As String
'
'
' Calculate Signed URL
' ====================
' inURL is the HOST + the Resource
'       e.g.  http://s3.amazonaws.com/bucketname/whatever
'             http://bucketname.s3.amazonaws.com//whatever
'             http://mycname.mydomain.com/whatever
' inResource is the bucket and resource within it
'       e.g.  /bucketname/whatever
'             /mycname.mydomain.com/whatever for CNAMEs
'"Authorization: AWS " + AWSAccessKeyId + ":"  + base64(hmac-sha1(VERB + "\n"
'                                 + CONTENT-MD5 + "\n"
'                                 + CONTENT-TYPE + "\n"
'                                 + DATE + "\n"
'                                 + CanonicalizedAmzHeaders
'                                 + CanonicalizedResource))
'
'

    
Dim GMTDate As Date
Dim epochDate As Long
Dim expireDate As Long
Dim dateTime As String
Dim hash As String
Dim Signature As String
Dim Authorization As String
Dim deURL  As String
Dim deltaTime As Long

' Get GMT date time
GMTDate = GetGmtTime
dateTime = DateToHTTPDate(GMTDate)

' calculate TTL expireDate
epochDate = DateToEpochSeconds(GMTDate)
' assume 5 minutes if 0
If inTTLSeconds = 0 Then
  deltaTime = 60 * 5
Else
  deltaTime = inTTLSeconds
End If
expireDate = epochDate + deltaTime


hash = inVERB & vbLf & inCONTENT_MD5 & vbLf & inCONTENT_TYPE & vbLf & expireDate & vbLf
If inAmzHeaders <> "" Then
  hash = hash & inAmzHeaders & vbLf
End If
hash = hash & inResource


Signature = Sha1Hmac(AWS_SECRET_ACCESS_KEY, hash)

Signature = URLEncode(Signature)
deURL = inURL & "?AWSAccessKeyId=" & AWS_ACCESS_KEY_ID & _
    "&Expires=" & expireDate & "&Signature=" & Signature

getSignedURL = deURL

End Function


Private Function GetGmtTime(Optional StartingDate As Variant) As Date

    'Parameters: StartingDate (Optional).  The function will figure
    'out GMT time based on StartingDate
    'If StartingDate is not provided, the current time will be used
    
    Dim Difference As Long
   
    
    Difference = GetTimeDifference()
    
    If IsMissing(StartingDate) Then
        'use current time
        GetGmtTime = DateAdd("s", -Difference, Now)
    Else
        'use StartingDate

        GetGmtTime = DateAdd("s", -Difference, StartingDate)
    End If
End Function

Private Function DateToHTTPDate(ByVal OleDATE As Date)
    Dim a As String

    DateToHTTPDate = EngWeekDayName(OleDATE) & _
    ", " & right("0" & Day(OleDATE), 2) & " " & EngMonthName(OleDATE) & _
    " " & Year(OleDATE) & " " & right("0" & Hour(OleDATE), 2) & _
    ":" & right("0" & Minute(OleDATE), 2) & ":" & right("0" & second(OleDATE), 2) & " GMT"
    
End Function

Private Function DateToEpochSeconds(ByVal OleDATE As Date) As Long
    Dim epoch As Date
     
    epoch = "01-JAN-1970"
    DateToEpochSeconds = DateDiff("s", epoch, OleDATE)
 
End Function

Private Function Sha1Hmac(key As String, toHash As String) As String
' Wrapper fro sha1hmac from xlitesha1hmac.dll
' return base64 encoded as per S3 requirements

    Dim aBytes() As Byte
    Dim aKey() As Byte
    Dim i As Integer
    Dim nLength As Long, nKeyLen As Long
    Dim sDigest As String * 20

    ' Convert key to byte array
    aKey() = StrConv(key, vbFromUnicode)
    nKeyLen = UBound(aKey) + 1
    ' Convert string to hash to byte array
    aBytes() = StrConv(toHash, vbFromUnicode)
    nLength = UBound(aBytes) + 1
    ' Create SHA1 HMAC digest
    Call xLiteSha1Hmac(sDigest, aBytes(0), nLength, aKey(0), nKeyLen)
    ' returns a hex binary string use HexBinTOHexStr if HEX text required
    Sha1Hmac = Base64Encode(sDigest)
End Function

Private Function URLEncode(ByVal Text As String) As String
' convert a string so that it can be used on a URL query string
'
' Same effect as the Server.URLEncode method in ASP
    Dim i As Integer
    Dim acode As Integer
    Dim Char As String
    
    URLEncode = Text
    
    For i = Len(URLEncode) To 1 Step -1
        acode = Asc(mID$(URLEncode, i, 1))
        Select Case acode
            Case 48 To 57, 65 To 90, 97 To 122
                ' don't touch alphanumeric chars
            Case 32
                ' replace space with "+"
                Mid$(URLEncode, i, 1) = "+"
            Case Else
                ' replace punctuation chars with "%hex"
                URLEncode = left$(URLEncode, i - 1) & "%" & Hex$(acode) & mID$ _
                    (URLEncode, i + 1)
        End Select
    Next
    
End Function


Private Function GetTimeDifference() As Long

    'Returns  the time difference between
    'local & GMT time in seconds.
    'If the  result is negative, your time zone
    'lags behind GMT zone.
    'If the  result is positive, your time zone is ahead.
    
    Dim tz As TIME_ZONE_INFORMATION
    Dim retcode As Long

    Dim Difference As Long
    
    'retrieve the time zone information
    retcode = GetTimeZoneInformation(tz)
    
    'convert to seconds

    Difference = -tz.Bias * 60
    'cache the result

    GetTimeDifference = Difference
    
    'if we are in daylight  saving time, apply the bias.
    If retcode = TIME_ZONE_ID_DAYLIGHT& Then

        If tz.DaylightDate.wMonth <> 0 Then
            'if tz.DaylightDate.wMonth = 0 then the daylight
            'saving time change doesn't occur
            GetTimeDifference = Difference - tz.DaylightBias * 60
        End If

    End If
    
End Function

Private Function EngWeekDayName(dt As Date) As String
    Dim Out As String
    Select Case Weekday(dt, 1)
        Case 1: Out = "Sun"
        Case 2: Out = "Mon"
        Case 3: Out = "Tue"
        Case 4: Out = "Wed"
        Case 5: Out = "Thu"
        Case 6: Out = "Fri"
        Case 7: Out = "Sat"
    End Select
    EngWeekDayName = Out
End Function

Private Function EngMonthName(dt As Date) As String
    Dim Out As String
    Select Case Month(dt)
        Case 1: Out = "Jan"
        Case 2: Out = "Feb"
        Case 3: Out = "Mar"
        Case 4: Out = "Apr"
        Case 5: Out = "May"
        Case 6: Out = "Jun"
        Case 7: Out = "Jul"
        Case 8: Out = "Aug"
        Case 9: Out = "Sep"
        Case 10: Out = "Oct"
        Case 11: Out = "Nov"
        Case 12: Out = "Dec"
    End Select
    EngMonthName = Out
End Function
Private Function Base64Encode(inData As String) As String
' Did you know MSXML2.DOMDocument provided a free bas64 encode/decode method ?
     
        Dim objXML As Object 'MSXML2.DOMDocument
        Dim objNode As Object 'MSXML2.IXMLDOMElement
        Dim inByte() As Byte
        Dim outStr As String

        inByte = StrConv(inData, vbFromUnicode)
        Set objXML = CreateObject("MSXML2.DOMDocument")
       
        ' byte array to base64
        Set objNode = objXML.createElement("b64")
        objNode.dataType = "bin.base64"
        objNode.nodeTypedValue = inByte
        outStr = objNode.Text
        Base64Encode = Replace(outStr, vbLf, "")
        

        Set objNode = Nothing
        Set objXML = Nothing

     

End Function
'''Public Function getMediaPath(pLanguageID As Long, pTrackName As String, pAlbumName As String, pLabelName As String, Optional MediaQuality As String = "h265") As String
''''''   bucketURL = "/ymg-karaoke/khmer/h265/4U/4U+Vol+034+-+T01.mp4"
'''   Dim mPath As String
'''   Dim mLanguageName As String
'''
'''   mLanguageName = "khmer"
'''   'videoURL
'''   mPath = "/ymg-karaoke/" & mLanguageName & "/" & MediaQuality & "/" & pLabelName & "/" & pLabelName & pTrackName & ".mp4"
'''
'''   'getMediaPath = "/ymg-karaoke/khmer/h265/4U/4U+Vol+034+-+T01.mp4"
'''   getMediaPath = Convert2AWSURL(mPath)
'''End Function


Private Function Convert2AWSURL(url As String) As String
   Dim i As Long
   Dim mURL As String
   mURL = url
   For i = 1 To Len(mURL)
      If InStr(AWS_URLSymbol, mID(mURL, i, 1)) > 0 Then Mid(mURL, i, 1) = "+"
   Next
   Convert2AWSURL = mURL
End Function
