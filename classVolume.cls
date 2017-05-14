VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "classVolume"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function mixerSetControlDetails Lib "winmm.dll" (ByVal hmxobj As Long, pmxcd As MIXERCONTROLDETAILS, ByVal fdwDetails As Long) As Long
Private Declare Function mixerOpen Lib "winmm.dll" (phmx As Long, ByVal uMxId As Long, ByVal dwCallback As Long, ByVal dwInstance As Long, ByVal fdwOpen As Long) As Long
Private Declare Function mixerClose Lib "winmm.dll" (ByVal hmx As Long) As Long
Private Declare Function waveOutSetVolume Lib "winmm.dll" (ByVal uDeviceID As Long, ByVal dwVolume As Long) As Long
Private Declare Function mixerGetLineInfo Lib "winmm.dll" Alias "mixerGetLineInfoA" (ByVal hmxobj As Long, pmxl As MIXERLINE, ByVal fdwInfo As Long) As Long
Private Declare Function mixerGetLineControls Lib "winmm.dll" Alias "mixerGetLineControlsA" (ByVal hmxobj As Long, pmxlc As MIXERLINECONTROLS, ByVal fdwControls As Long) As Long

Private Const MAXPNAMELEN = 32
Private Const MIXER_SHORT_NAME_CHARS = 16
Private Const MIXER_LONG_NAME_CHARS = 64
Private Const MIXER_SETCONTROLDETAILSF_VALUE = &H0&
Private Const MM_MIXM_CONTROL_CHANGE = &H3D1       'mixer control change notify
Private Const MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT = &H1000& + 8
Private Const MIXER_GETLINEINFOF_COMPONENTTYPE = &H3&

Private Const MIXER_GETLINECONTROLSF_ONEBYTYPE = &H2&
Private Const MIXERCONTROL_CT_CLASS_FADER = &H50000000
Private Const MIXERCONTROL_CT_UNITS_UNSIGNED = &H30000
Private Const MIXERCONTROL_CONTROLTYPE_FADER = (MIXERCONTROL_CT_CLASS_FADER Or MIXERCONTROL_CT_UNITS_UNSIGNED)
Private Const MIXERCONTROL_CONTROLTYPE_VOLUME = (MIXERCONTROL_CONTROLTYPE_FADER + 1)

Private Type MIXERLINECONTROLS
     cbStruct As Long         '  size in Byte of MIXERLINECONTROLS
     dwLineID As Long         '  line id (from MIXERLINE.dwLineID)
     dwControl As Long        '  MIXER_GETLINECONTROLSF_ONEBYTYPE or MIXER_GETLINECONTROLSF_ONEBYID
     cControls As Long        '  count of controls pmxctrl points to
     cbmxctrl As Long         '  size in Byte of _one_ MIXERCONTROL
     pamxctrl As Long         '  pointer to first MIXERCONTROL array
End Type
Private Type Target
     dwType As Long                    '  MIXERLINE_TARGETTYPE_xxxx
     dwDeviceID As Long                '  target device ID of device type
     wMid As Integer                   '  of target device
     wPid As Integer                   '       "
     vDriverVersion As Long            '       "
     szPname As String * MAXPNAMELEN
End Type

Private Type MIXERCONTROLDETAILS
     cbStruct As Long       '  size in Byte of MIXERCONTROLDETAILS
     dwControlID As Long    '  control id to get/set details on
     cChannels As Long      '  number of channels in paDetails array
     item As Long           '  hwndOwner or cMultipleItems
     cbDetails As Long      '  size of _one_ details_XX struct
     paDetails As Long      '  pointer to array of details_XX structs
End Type
Private Type MIXERCONTROLDETAILS_UNSIGNED
     dwValue As Long
End Type
Private Type MIXERLINE
     cbStruct As Long                  '  size of MIXERLINE structure
     dwDestination As Long             ' zero based destination index
     dwSource As Long                  '  zero based source index (if source)
     dwLineID As Long                  '  unique line id for mixer device
     fdwLine As Long                   '  state/information about line
     dwUser As Long                    '  driver specific information
     dwComponentType As Long           '  component type line connects to
     cChannels As Long                 '  number of channels line supports
     cConnections As Long              '  number of connections (possible)
     cControls As Long                 '  number of controls at this line
     szShortName As String * MIXER_SHORT_NAME_CHARS
     szName As String * MIXER_LONG_NAME_CHARS
     lpTarget As Target
End Type
Private Type MIXERCONTROL
     cbStruct As Long                  '  size in Byte of MIXERCONTROL
     dwControlID As Long               '  unique control id for mixer device
     dwControlType As Long             '  MIXERCONTROL_CONTROLTYPE_xxx
     fdwControl As Long                '  MIXERCONTROL_CONTROLF_xxx
     cMultipleItems As Long            '  if MIXERCONTROL_CONTROLF_MULTIPLE set
     szShortName(1 To MIXER_SHORT_NAME_CHARS) As Byte
     szName(1 To MIXER_LONG_NAME_CHARS) As Byte
     Bounds(1 To 6) As Long
     Metrics(1 To 6) As Long
End Type

'MIXER_OBJECTF_WAVEOUT

Private cWaveVolumeID As Long
Private cVolume As Single
Public Property Get Volume() As Single
   Volume = cVolume
End Property
Public Property Let Volume(Value As Single)
   Dim hmx As Long
   Dim lResult As Long
   Dim uDetail As MIXERCONTROLDETAILS
   Dim uUnsigned() As MIXERCONTROLDETAILS_UNSIGNED
   If Value >= 0 And Value <= 100 Then
      cVolume = Value
      lResult = mixerOpen(hmx, 0, 0, 0, 0)
      ' Fill in common values for uDetails
      uDetail.cbStruct = CLng(Len(uDetail))
      uDetail.cChannels = 1
      uDetail.item = 0
      uDetail.dwControlID = cWaveVolumeID          'Audio ID
      uDetail.cbDetails = 4
      
      ReDim uUnsigned(1 To uDetail.cChannels * uDetail.cbDetails) As MIXERCONTROLDETAILS_UNSIGNED
      uDetail.paDetails = VarPtr(uUnsigned(1).dwValue)
      uUnsigned(1).dwValue = (Value / 100) * 65535 '32767.5
      
      lResult = mixerSetControlDetails(hmx, uDetail, MIXER_SETCONTROLDETAILSF_VALUE)
      lResult = mixerClose(hmx)
   End If
End Property
Private Function GetWaveOutID() As Long

' Function returns wave volume ID
' Return master volume control ID in ggiMasterVolumeID (return -1 if error)
' Return master mute control ID in ggiMasterVolumeID (return -1 if error)
   Dim nResult As Long
   Dim iCtrl As Integer, j As Integer
   Dim iDest As Integer
   Dim sMixError As String
   Dim sName As String
   Dim hmx As Long
   Dim uMixerLine As MIXERLINE, uSpeakerLine As MIXERLINE
   Dim uMixerLineControls As MIXERLINECONTROLS
   Dim uMixerControl0 As MIXERCONTROL

   nResult = mixerOpen(hmx, 0, 0, 0, 0)

   ' Initialize MixerLine structure
   uMixerLine.cbStruct = LenB(uMixerLine)
   uMixerLine.dwDestination = iDest
   uMixerLine.dwSource = 0
   uMixerLine.dwComponentType = MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT
   
   nResult = mixerGetLineInfo(hmx, uMixerLine, MIXER_GETLINEINFOF_COMPONENTTYPE)

   'Initialize MIXERLINECONTROLS structure
   uMixerLineControls.cbStruct = CLng(LenB(uMixerLineControls))
   uMixerLineControls.dwLineID = uMixerLine.dwLineID
   uMixerLineControls.dwControl = MIXERCONTROL_CONTROLTYPE_VOLUME
   uMixerLineControls.cControls = uMixerLine.cControls
   uMixerLineControls.cbmxctrl = CLng(LenB(uMixerControl0))

   ' Dimension MIXERCONTROL array to proper size
   Dim uMixerControl(0 To 0) As MIXERCONTROL

   ' Get address of first member of MIXERCONTROL structure
   uMixerLineControls.pamxctrl = VarPtr(uMixerControl(0).cbStruct)
   nResult = mixerGetLineControls(hmx, uMixerLineControls, MIXER_GETLINECONTROLSF_ONEBYTYPE)
   GetWaveOutID = uMixerControl(0).dwControlID
' ----------------------------------------------------------------
End Function


Private Sub Class_Initialize()
   cWaveVolumeID = GetWaveOutID
End Sub

