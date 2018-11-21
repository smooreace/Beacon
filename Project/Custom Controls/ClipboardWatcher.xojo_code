#tag Class
Protected Class ClipboardWatcher
Inherits Timer
	#tag Event
		Sub Action()
		  Dim Board As New Clipboard
		  Dim Hash As String
		  If Not Board.TextAvailable Then
		    Hash = Self.EmptyHash
		  End If
		  
		  Hash = EncodeHex(Crypto.SHA1(Board.Text))
		  If Hash = Self.mLastHash Then
		    Return
		  End If
		  
		  RaiseEvent ClipboardChanged(Board.Text)
		  Self.mLastHash = Hash
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLastHash = Self.EmptyHash
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ClipboardChanged(Content As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mLastHash As String
	#tag EndProperty


	#tag Constant, Name = EmptyHash, Type = String, Dynamic = False, Default = \"da39a3ee5e6b4b0d3255bfef95601890afd80709", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass