VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBackend"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'API Doc
'http://ec2-52-88-252-123.us-west-2.compute.amazonaws.com/apidocs/
Private Const AppID = "774130012706884"  ' 774130012706884
'Private Const mDeviceID = "fe66d0000c1b1a2f"
Private Const mDeviceID = "19B573B6-3CB8-4AF1-9116-CC9A31F004DE"
'19B573B6-3CB8-4AF1-9116-CC9A31F004DE

Private Const URL_Success = "http://ec2-52-88-252-123.us-west-2.compute.amazonaws.com:8080/dvdshop/Success.html"
Private Const URL_JSON = "http://ec2-52-88-252-123.us-west-2.compute.amazonaws.com:8080/dvdshop/api/"
Private WithEvents m_Browse As WebBrowser
Attribute m_Browse.VB_VarHelpID = -1
Private m_LogingForm As frmFBLogin
Private mAccessToken As String
Private mUserID As String
Private mUserName As String
'Private mDeviceID As String
Private mLoggined As Boolean
Private Const MAXREQUEST = 2000

Private Enum TaskEnum
   TaskTaskNon = 0
   TaskWaitForToken = 1
   TaskWaitForUserID = 2
   TaskWaitForLogout = 3
End Enum

Event onFeedback(pAccessToken As String, pUserID As String, pUserName As String, iStatus As Long)

Private m_Task As TaskEnum


Public Function Initialize(mForm As frmFBLogin)
   
   Set m_LogingForm = mForm
   Set m_Browse = m_LogingForm.webLogin
   'mDeviceID = DeviceID
End Function

Public Function Loginfb()
   IsLoggined = False
   m_Task = TaskWaitForToken
   m_LogingForm.Show
   m_Browse.Visible = True
   m_Browse.Navigate "https://www.facebook.com/dialog/oauth?%20client_id=" & AppID & "&redirect_uri=" & URL_Success & "&response_type=token"
End Function

Public Function Logout()
   IsLoggined = False
   m_Task = TaskWaitForLogout
   m_LogingForm.Show
   m_Browse.Visible = True
   m_Browse.Navigate "https://www.facebook.com/help/contact/logout?id=" & UserID
End Function

Private Sub m_Browse_NavigateComplete2(ByVal pDisp As Object, url As Variant)
   On Error GoTo ErrorHandle
   Dim objRegExp As New RegExp
   Dim objMatch As Match
   Dim colMatches   As MatchCollection
   'Dim mUserID As String

   

   If m_Task = TaskWaitForToken Then
      'Debug.Print url
      objRegExp.pattern = "access_token=([^&]+)"
      If (objRegExp.Test(url) = True) Then
         Set colMatches = objRegExp.Execute(url)   ' Execute search.
         Set objMatch = colMatches.item(0)
         mAccessToken = objMatch.SubMatches(0)
         'Debug.Print "Access token = " + objMatch.SubMatches(0)
         m_Task = TaskTaskNon
      
         '===================================
         Dim p As Object
         Set p = JSON.JsonURL("https://graph.facebook.com/v2.2/me?access_token=" & mAccessToken, "GET")
         UserID = p.item("id")
         userName = p.item("name")
         RaiseEvent onFeedback(mAccessToken, UserID, userName, 1)
         IsLoggined = True
         Unload m_LogingForm

      End If
   ElseIf m_Task = TaskWaitForLogout Then
      Debug.Print url
   ElseIf m_Task = TaskWaitForUserID Then
      'Debug.Print url
   End If
   Exit Sub
ErrorHandle:
   mAccessToken = vbNullString
   mUserID = vbNullString
   m_Task = TaskTaskNon
   RaiseEvent onFeedback(mAccessToken, UserID, userName, 0)
End Sub

Public Property Get IsLoggined() As Boolean
   IsLoggined = mLoggined
End Property

Private Property Let IsLoggined(ByVal vNewValue As Boolean)
   mLoggined = vNewValue
End Property

Public Property Get userName() As String
   userName = mUserName
End Property

Private Property Let userName(ByVal vNewValue As String)
   mUserName = vNewValue
End Property


Public Property Get UserID() As String
   UserID = mUserID
End Property

Private Property Let UserID(ByVal vNewValue As String)
   mUserID = vNewValue
End Property

Public Property Get AccessToken() As String
   AccessToken = mAccessToken
End Property

Public Property Let AccessToken(ByVal vNewValue As String)
   mAccessToken = vNewValue
End Property

Public Property Get DeviceName() As String
   DeviceName = "WindowsAPP"
End Property



Public Property Get DeviceID() As String
   
   DeviceID = mDeviceID
End Property

Public Property Let DeviceID(ByVal vNewValue As String)
   'mDeviceID = vNewValue
End Property


Public Function albumFindByLang(LanguageID As Long) As Collection
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "album/v1/langs/" & LanguageID & "/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
   Set albumFindByLang = serializeAlbums(p)
End Function


Public Function trackFindByAlbum(albumID As Long) As Collection
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "track/v1/albums/" & albumID & "/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
'''    trackFindByAlbum = JSON.toString(p)
   Set trackFindByAlbum = serializeTracks(p)
   'http://ec2-52-88-252-123.us-west-2.compute.amazonaws.com:8080/dvdshop/api/track/v1/albums/1/?access_token=CAALAETBq2EQBAEc53WFmYjIEMZAo2AGMy4ZCNfclBZADBqkbZBBoqzz7dcm62CGIEFDGwZBObOCZB8uScrAC3NavM1YuvOJ5G0vHqviZAtqZAiwMZBJZCLpThB8S15TOnqwG9vCCZCyBiwpYcRmZAu8b0B7Dvn0tjpWR9sCLG5r9GZAIJkAm4OKo0FjmResZCGCo1eA2uZCRqiEPMEifAZDZD&productionId=2&deviceId=3
End Function

Public Function findPurchasedTracks(LanguageID As Long) As Collection
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "track/v1/langs/" & LanguageID & "/purchased/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
    'findPurchasedTracks = JSON.toString(p)
    Set findPurchasedTracks = serializeTracks(p)
End Function
Public Function findPurchasedAlbums(LanguageID As Long) As Collection
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "album/v1/langs/" & LanguageID & "/purchased/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
   Set findPurchasedAlbums = serializeAlbums(p)
   'findTrackAndAlbumDownload ( serializeAlbums(p))
End Function

Public Function loginBackend() As Boolean
On Error GoTo Error:
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "oauth2/v1/token?access_token=" & AccessToken & "&providerId=facebook&providerUserId=" & UserID & "&grant_type=token&deviceId=" & DeviceID & "&deviceName=" & DeviceName, "POST")
   loginBackend = True
   Exit Function
Error:

End Function

Public Function setFavoriteAlbums(albumID As Long) As Boolean
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "album/v1/" & albumID & "/favorite/?favorite=true&access_token=" & AccessToken & "&deviceId=" & DeviceID, "POST")
   'Set getFavoriteAlbums = serializeAlbums(p)
   'findTrackAndAlbumDownload ( serializeAlbums(p))
End Function
'
Public Function getFavoriteAlbums() As Collection
   Dim p As Object

   Set p = JSON.JsonURL(URL_JSON & "album/v1/favorites/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
   Set getFavoriteAlbums = serializeAlbums(p)
   'findTrackAndAlbumDownload ( serializeAlbums(p))
End Function
'


Public Function serializeAlbums(pObject As Object) As Collection
   Dim i As Long
   Dim mAlbums As New Collection
   Dim pAlbums As Collection
   Dim mAlbum As CAlbum
   
   Set pAlbums = pObject.item("items")
   For i = 1 To pAlbums.count
      Set mAlbum = New CAlbum
      Set mAlbum = serializeAlbum(pAlbums.item(i))
      mAlbums.Add mAlbum
   Next
   Set serializeAlbums = mAlbums
End Function


Public Function serializeAlbum(pObject As Object) As CAlbum
   Dim mAlbum As New CAlbum

   mAlbum.ID = pObject.item("id")
   mAlbum.Title = pObject.item("title")
   mAlbum.Favorite = pObject.item("favorite")
   mAlbum.Price = pObject.item("price")
   Set serializeAlbum = mAlbum

End Function

Public Function serializeTracks(pObject As Object) As Collection
   Dim i As Long
   Dim nCount As Long
   Dim mTracks As New Collection
   Dim pTracks As Object
   Dim pTrack As Object
   Dim mTrack As CTrack
   Dim mAlbum As CAlbum
   
   If Not pObject Is Nothing Then
      nCount = pObject.item("total")
      Set pTracks = pObject.item("items")
      For i = 1 To pTracks.count
         Set pTrack = pTracks.item(i)
         Set mTrack = New CTrack
         mTrack.ID = pTrack.item("id")
         mTrack.Title = pTrack.item("title")
         mTrack.Length = pTrack.item("length")
         mTrack.Unicode = pTrack.item("unicode")
         Set mTrack.Artists = serializeArtist(pTrack.item("artists"))
         mTrack.Favorite = pTrack.item("favorite")
         mTrack.Price = pTrack.item("price")
         mTrack.VideoURL = pTrack.item("videoUrl")
         Set mAlbum = serializeAlbum(pTrack.item("album"))
         Set mTrack.Album = mAlbum
          'mTrack.Album = pTrack.Item("album")
         mTracks.Add mTrack
         'mTracks.Add
      Next
      
   End If
   Set serializeTracks = mTracks
End Function

Public Function serializeArtist(pObject As Collection) As Collection
On Error GoTo Error:
   Dim i As Long
   Dim nCount As Long
   Dim pArtists As Object
   Dim pArtist As Object
   Dim mArtists As New Collection
   Dim mArtist As CArtist
   
   nCount = pObject.count
   For i = 1 To nCount
      Set pArtist = pObject.item(i)
      Set mArtist = New CArtist
       mArtist.ID = pArtist.item("id")
       mArtist.Name = pArtist.item("name")
       mArtist.Sex = pArtist.item("sex")
       mArtist.Unicode = pArtist.item("unicode")

       mArtists.Add mArtist
      'mTracks.Add
   Next
Error:
   Set serializeArtist = mArtists
End Function
Public Function findTrackNeedDownload(mAlbumID As Long) As Collection
   'Find track not available based on AlbumID
   Dim mTracks As Collection
   
   
      'Set p = JSON.JsonURL(URL_JSON & "album/v1/langs/" & languageID & "/?access_token=" & AccessToken & "&limit=" & MAXREQUEST & "&deviceId=" & DeviceID, "GET")
   Dim Y As New CTrack
   Y.ID = 10
   mTracks.Add mTracks
   Set findTrackNeedDownload = mTracks
End Function


Public Function findTrackAndAlbumDownload(pAlbum As Collection, pTrack As Collection) As Collection
   'Will download track if current track and album not available
   'return total track count
   Dim i As Long, j As Long
   Dim mAlbum As CAlbum
   Dim mTrack As CTrack
   Dim mTrackFound As Collection
   Dim mTrackPurchased As New Collection
   
   
   For i = 1 To pAlbum.count        'loop through to find track not available and download
      Set mAlbum = pAlbum.item(i)
      Set mTrackFound = trackFindByAlbum(mAlbum.ID)
      'Set mTrackFound = trackFindByAlbum(711)
      
      
      For j = 1 To mTrackFound.count
         Set mTrack = mTrackFound.item(j)
         If Not CBrowse.isTrackAvailable(mTrack.ID) Then
            'if not available so add to purchased download
'''            Debug.Print mTrack.ID, mTrack.Title, mTrack.Unicode
            mTrackPurchased.Add mTrack
         End If
      Next
   Next
   
'''   For i = 1 To pTrack.count
'''      Set mTrack = pTrack.item(i)
'''      If Not CBrowse.isTrackAvailable(mTrack.ID) Then
'''         mTrackPurchased.Add mTrack
'''      End If
'''   Next
'''
   
   
   Set findTrackAndAlbumDownload = mTrackPurchased

End Function


