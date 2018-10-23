#tag Window
Begin Window EngramsUpdateWindow Implements NotificationKit.Receiver
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   124
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   ""
   Visible         =   False
   Width           =   450
   Begin ProgressBar Indicator
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   52
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   410
   End
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Updating Engram Definitions…"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   410
   End
   Begin Timer RevealTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   1
      Period          =   2000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin PushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   185
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, LocalData.Notification_ImportSuccess, LocalData.Notification_ImportFailed)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, LocalData.Notification_ImportSuccess, LocalData.Notification_ImportFailed)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_ImportSuccess, LocalData.Notification_ImportFailed
		    Self.RevealTimer.Mode = Timer.ModeOff
		    
		    Dim Date As Xojo.Core.Date
		    If Notification.UserData <> Nil And Notification.UserData IsA Xojo.Core.Date Then
		      Date = Notification.UserData
		    Else
		      Date = LocalData.SharedInstance.LastSync
		    End If
		    
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Engram definitions have been updated"
		    Dialog.Explanation = "Engrams, loot sources, and presets are current as of " + Date.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Long, Xojo.Core.Date.FormatStyles.Short) + " UTC."
		    Call Dialog.ShowModal
		    
		    Self.Close
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowIfNecessary()
		  Dim Win As New EngramsUpdateWindow
		  // Do not show it, the timer will do that
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events RevealTimer
	#tag Event
		Sub Action()
		  Self.Show()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  // Doesn't really cancel, just dismisses the window
		  
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents