#tag Window
Begin BeaconContainer SpawnPointEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   664
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   False
   Visible         =   True
   Width           =   906
   Begin FadedSeparator ColumnSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   664
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   200
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin BeaconToolbar LimitsToolbar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   True
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   2
      BorderTop       =   False
      Caption         =   "Limits"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Resizer         =   "2"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   371
      Transparent     =   False
      Visible         =   True
      Width           =   200
   End
   Begin BeaconToolbar SetsToolbar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   True
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   2
      BorderTop       =   False
      Caption         =   "Spawn Sets"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   "1"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   200
   End
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   664
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   201
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   705
      Begin SpawnPointSetEditor SetEditor
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackgroundColor=   False
         Height          =   664
         InitialParent   =   "Pages"
         Left            =   201
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   705
      End
      Begin LogoFillCanvas LogoCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   664
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   201
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   705
      End
   End
   Begin StatusBar SetsStatusBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Borders         =   3
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   349
      Transparent     =   True
      Visible         =   True
      Width           =   200
   End
   Begin StatusBar LimitsStatusBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   21
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   643
      Transparent     =   True
      Visible         =   True
      Width           =   200
   End
   Begin BeaconListbox SetsList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   308
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconListbox LimitsList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,75"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   231
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   412
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub ContentsChanged()
		  RaiseEvent Changed
		End Sub
	#tag EndEvent

	#tag Event
		Sub EmbeddingFinished()
		  Self.SetsListWidth = Preferences.SpawnPointEditorSetsSplitterPosition
		  Self.LimitsListHeight = Preferences.SpawnPointEditorLimitsSplitterPosition
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Not Self.FinishedEmbedding Then
		    Return
		  End If
		  
		  Self.SetsListWidth = Self.SetsListWidth
		  Self.LimitsListHeight = Self.LimitsListHeight
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Document() As Beacon.Document
		  Return RaiseEvent GetDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentLimitsDialog()
		  Var SelectedCreatures() As Beacon.Creature
		  Self.PresentLimitsDialog(SelectedCreatures)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentLimitsDialog(SelectedCreatures() As Beacon.Creature)
		  Var DefinedCreatures() As Beacon.Creature
		  Var CommonLimit As NullableDouble
		  Var CreatureFilter As New Dictionary
		  
		  For Each Point As Beacon.SpawnPoint In Self.mSpawnPoints
		    Var Limits As Dictionary = Point.Limits
		    For Each Entry As DictionaryEntry In Limits
		      Var Creature As Beacon.Creature = Entry.Key
		      If DefinedCreatures.IndexOf(Creature) = -1 Then
		        DefinedCreatures.AddRow(Creature)
		      End If
		      If SelectedCreatures.IndexOf(Creature) > -1 Then
		        Var CreatureLimit As Double = Entry.Value
		        If CommonLimit = Nil Then
		          CommonLimit = CreatureLimit
		        ElseIf CommonLimit <> -1.0 And CommonLimit <> CreatureLimit Then
		          CommonLimit = -1.0
		        End If
		      End If
		    Next
		    
		    Var Bound As Integer = Point.Count - 1
		    For I As Integer = 0 To Bound
		      Var Set As Beacon.SpawnPointSet = Point.Set(I)
		      Var Entries() As Beacon.SpawnPointSetEntry = Set.Entries
		      For Each Entry As Beacon.SpawnpointSetEntry In Entries
		        Var Creature As Beacon.Creature = Entry.Creature
		        If IsNull(Creature) = False THen
		          CreatureFilter.Value(Creature.Path) = Creature
		        End If
		      Next
		    Next
		  Next
		  
		  Var CreaturesInSpawnPoint() As Beacon.Creature
		  For Each Entry As DictionaryEntry In CreatureFilter
		    CreaturesInSpawnPoint.AddRow(Entry.Value)
		  Next
		  
		  If CommonLimit <> Nil And CommonLimit = -1.0 Then
		    CommonLimit = Nil
		  End If
		  
		  Var Limit As NullableDouble = SpawnPointLimitDialog.Present(Self, Self.Document.Mods, CommonLimit, SelectedCreatures, DefinedCreatures, CreaturesInSpawnPoint)
		  If Limit <> Nil Then
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      For Each Creature As Beacon.Creature In SelectedCreatures
		        Point.Limit(Creature) = Limit
		      Next
		    Next
		    
		    Self.UpdateUI
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPoints() As Beacon.SpawnPoint()
		  Var Points() As Beacon.SpawnPoint
		  Points.ResizeTo(Self.mSpawnPoints.LastRowIndex)
		  For I As Integer = 0 To Self.mSpawnPoints.LastRowIndex
		    Points(I) = New Beacon.SpawnPoint(Self.mSpawnPoints(I))
		  Next
		  Return Points
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnPoints(Assigns Points() As Beacon.SpawnPoint)
		  If Points = Nil Then
		    Self.mSpawnPoints.ResizeTo(-1)
		  Else
		    Self.mSpawnPoints.ResizeTo(Points.LastRowIndex)
		    For I As Integer = 0 To Points.LastRowIndex
		      Self.mSpawnPoints(I) = New Beacon.MutableSpawnPoint(Points(I))
		    Next
		  End If
		  
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLimitsList(SelectCreatures() As Beacon.Creature = Nil)
		  Self.LimitsList.SelectionChangeBlocked = True
		  
		  Const MixedLimitValue = -1.0
		  
		  Var CombinedLimits As Dictionary
		  
		  For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		    Var PointLimits As Dictionary = Point.Limits
		    
		    If CombinedLimits = Nil Then
		      CombinedLimits = New Dictionary
		      For Each Entry As DictionaryEntry In PointLimits
		        Var Creature As Beacon.Creature = Entry.Key
		        Var Limit As Double = Entry.Value
		        CombinedLimits.Value(Creature.Path) = Limit
		      Next
		    Else
		      For Each Entry As DictionaryEntry In PointLimits
		        Var Creature As Beacon.Creature = Entry.Key
		        Var Limit As Double = Entry.Value
		        
		        If CombinedLimits.HasKey(Creature.Path) = False Then
		          CombinedLimits.Value(Creature.Path) = Limit
		        ElseIf CombinedLimits.Value(Creature.Path).DoubleValue <> Limit Then
		          CombinedLimits.Value(Creature.Path) = MixedLimitValue
		        End If
		      Next
		    End If
		  Next
		  
		  If CombinedLimits <> Nil And CombinedLimits.KeyCount > 0 Then
		    Var SelectedCreatures() As String
		    If SelectCreatures <> Nil Then
		      For Each Creature As Beacon.Creature In SelectCreatures
		        SelectedCreatures.AddRow(Creature.Path)
		      Next
		    Else
		      For I As Integer = 0 To Self.LimitsList.RowCount - 1
		        If Self.LimitsList.Selected(I) Then
		          SelectedCreatures.AddRow(Self.LimitsList.RowTagAt(I))
		        End If
		      Next
		    End If
		    
		    Self.LimitsList.RowCount = CombinedLimits.KeyCount
		    For RowIndex As Integer = 0 To CombinedLimits.KeyCount - 1
		      Var Path As String = CombinedLimits.Key(RowIndex)
		      Var Limit As Double = CombinedLimits.Value(Path)
		      
		      Self.LimitsList.CellValueAt(RowIndex, 0) = Beacon.Data.GetCreatureByPath(Path).Label
		      Self.LimitsList.CellValueAt(RowIndex, 1) = If(Limit = MixedLimitValue, "Mixed", Beacon.PrettyText(Limit * 100, 2) + "%")
		      Self.LimitsList.RowTagAt(RowIndex) = Path
		      Self.LimitsList.Selected(RowIndex) = SelectedCreatures.IndexOf(Path) > -1
		    Next
		  Else
		    Self.LimitsList.RowCount = 0
		  End If
		  
		  Self.UpdateLimitsStatus
		  
		  Self.LimitsList.SortingColumn = 0
		  Self.LimitsList.Sort
		  Self.LimitsList.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLimitsStatus()
		  If Self.LimitsList.SelectedRowCount > 0 Then
		    Self.LimitsStatusBar.Caption = Self.LimitsList.SelectedRowCount.ToString + " of " + Language.NounWithQuantity(Self.LimitsList.RowCount, "Limit", "Limits") + " Selected"
		  Else
		    Self.LimitsStatusBar.Caption = Language.NounWithQuantity(Self.LimitsList.RowCount, "Limit", "Limits")
		  End If
		  
		  Self.LimitsToolbar.EditButton.Enabled = Self.LimitsList.SelectedRowCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSetsList(SelectSets() As Beacon.SpawnPointSet = Nil)
		  Self.SetsList.SelectionChangeBlocked = True
		  
		  Var CombinedSets As New Dictionary
		  For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		    For Each Set As Beacon.SpawnPointSet In Point
		      Var Hash As String = Set.Hash
		      Var Organizer As SpawnSetOrganizer
		      If CombinedSets.HasKey(Hash) Then
		        Organizer = CombinedSets.Value(Hash)
		      Else
		        Organizer = New SpawnSetOrganizer(Set)
		        CombinedSets.Value(Hash) = Organizer
		      End If
		      Organizer.Attach(Point, Set)
		    Next
		  Next
		  
		  If CombinedSets <> Nil And CombinedSets.KeyCount > 0 Then
		    Var SelectedSets() As String
		    If SelectSets = Nil Then
		      For I As Integer = 0 To Self.SetsList.RowCount - 1
		        If Self.SetsList.Selected(I) Then
		          SelectedSets.AddRow(SpawnSetOrganizer(Self.SetsList.RowTagAt(I)).Template.ID)
		        End If
		      Next
		    Else
		      For Each Set As Beacon.SpawnPointSet In SelectSets
		        SelectedSets.AddRow(Set.Hash)
		      Next
		    End If
		    
		    Var ExtendedLabels As Boolean = Self.mSpawnPoints.LastRowIndex > 0
		    
		    Self.SetsList.RowCount = CombinedSets.KeyCount
		    Self.SetsList.DefaultRowHeight = If(ExtendedLabels, 34, 26)
		    For RowIndex As Integer = 0 To CombinedSets.KeyCount - 1
		      Var Hash As String = CombinedSets.Key(RowIndex)
		      Var Organizer As SpawnSetOrganizer = CombinedSets.Value(Hash)
		      
		      Self.SetsList.CellValueAt(RowIndex, 0) = Organizer.Label(ExtendedLabels)
		      Self.SetsList.RowTagAt(RowIndex) = Organizer
		      Self.SetsList.Selected(RowIndex) = Organizer.Matches(SelectedSets)
		    Next
		  Else
		    Self.SetsList.RowCount = 0
		  End If
		  
		  Self.UpdateSetsStatus
		  
		  Self.SetsList.SortingColumn = 0
		  Self.SetsList.Sort
		  Self.SetsList.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSetsStatus()
		  If Self.SetsList.SelectedRowCount > 0 Then
		    Self.SetsStatusBar.Caption = Self.SetsList.SelectedRowCount.ToString + " of " + Language.NounWithQuantity(Self.SetsList.RowCount, "Spawn Set", "Spawn Sets") + " Selected"
		  Else
		    Self.SetsStatusBar.Caption = Language.NounWithQuantity(Self.SetsList.RowCount, "Spawn Set", "Spawn Sets")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.UpdateSetsList()
		  Self.UpdateLimitsList()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetDocument() As Beacon.Document
	#tag EndHook


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.Height - Self.LimitsToolbar.Top
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.Height < Self.MinimumHeight Then
			    // Don't compute anything
			    Return
			  End If
			  
			  System.DebugLog("Requested limits height: " + Value.ToString)
			  
			  // Remember, this works BACKWARDS so a value of 100 means 100 from the bottom of the window
			  
			  Const SetsListMinHeight = 200
			  Const LimitsListMinHeight = 150
			  
			  Var MinTop As Integer = SetsListMinHeight
			  Var MaxTop As Integer = Self.Height - LimitsListMinHeight
			  Var Top As Integer = Max(Min(Self.Height - Value, MaxTop), MinTop)
			  Value = Self.Height - Top
			  
			  Self.LimitsToolbar.Top = Top
			  Self.LimitsList.Top = Self.LimitsToolbar.Top + Self.LimitsToolbar.Height
			  Self.LimitsList.Height = Self.LimitsStatusBar.Top - Self.LimitsList.Top
			  
			  Self.SetsStatusBar.Top = Top - Self.SetsStatusBar.Height
			  Self.SetsList.Height = Self.SetsStatusBar.Top - Self.SetsList.Top
			  
			  System.DebugLog("Actual limits height: " + Value.ToString)
			  Preferences.SpawnPointEditorLimitsSplitterPosition = Value
			End Set
		#tag EndSetter
		Private LimitsListHeight As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mSpawnPoints() As Beacon.MutableSpawnPoint
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.SetsList.Width
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.Width < Self.MinimumWidth Then
			    // Don't compute anything
			    Return
			  End If
			  
			  Var AvailableSpace As Integer = Self.Width - Self.ColumnSeparator.Width
			  Var ListWidth As Integer = Min(Max(Value, Self.SetsListMinWidth), AvailableSpace - SpawnPointSetEditor.MinimumWidth)
			  Var EditorWidth As Integer = AvailableSpace - ListWidth
			  
			  Self.SetsList.Width = ListWidth
			  Self.SetsToolbar.Width = ListWidth
			  Self.SetsStatusBar.Width = ListWidth
			  Self.ColumnSeparator.Left = ListWidth
			  Self.LimitsList.Width = ListWidth
			  Self.LimitsToolbar.Width = ListWidth
			  Self.LimitsStatusBar.Width = ListWidth
			  Self.Pages.Left = Self.ColumnSeparator.Left + Self.ColumnSeparator.Width
			  Self.Pages.Width = EditorWidth
			  
			  Preferences.SpawnPointEditorSetsSplitterPosition = ListWidth
			End Set
		#tag EndSetter
		Private SetsListWidth As Integer
	#tag EndComputedProperty


	#tag Constant, Name = kLimitsClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.spawn.limit", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSetsClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.spawn.set", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"911", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSetEditor, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SetsListMinWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events LimitsToolbar
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Self.PresentLimitsDialog()
		  Case "EditButton"
		    Var SelectedCreatures() As Beacon.Creature
		    For I As Integer = 0 To Self.LimitsList.RowCount - 1
		      If Self.LimitsList.Selected(I) Then
		        SelectedCreatures.AddRow(Beacon.Data.GetCreatureByPath(Self.LimitsList.RowTagAt(I).StringValue))
		      End If
		    Next
		    Self.PresentLimitsDialog(SelectedCreatures)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddButton", IconToolbarAdd)
		  AddButton.HelpTag = "Define a new creature limit."
		  Me.LeftItems.Append(AddButton)
		  
		  Var EditButton As New BeaconToolbarItem("EditButton", IconToolbarEdit, False)
		  EditButton.HelpTag = "Edit the selected creature limit or limits."
		  Me.RightItems.Append(EditButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.LimitsListHeight = Self.Height - NewSize
		  NewSize = Self.LimitsListHeight
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetsToolbar
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Var Organizer As New SpawnSetOrganizer
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      Organizer.Attach(Point)
		    Next
		    
		    Self.SetsList.AddRow(Organizer.Label(Self.mSpawnPoints.LastRowIndex > 0))
		    Self.SetsList.RowTagAt(Self.SetsList.LastAddedRowIndex) = Organizer
		    Self.SetsList.SelectedRowIndex = Self.SetsList.LastAddedRowIndex
		    Self.SetsList.Sort
		    Self.SetsList.EnsureSelectionIsVisible
		  Case "WizardButton"
		    Var Organizer As New SpawnSetOrganizer
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      Organizer.Attach(Point)
		    Next
		    
		    If SpawnSetWizard.Present(Self, Organizer, Self.Document.Mods) = False Then
		      Return
		    End If
		    
		    Self.SetsList.AddRow(Organizer.Label(Self.mSpawnPoints.LastRowIndex > 0))
		    Self.SetsList.RowTagAt(Self.SetsList.LastRowIndex) = Organizer
		    Self.SetsList.SelectedRowIndex = Self.SetsList.LastRowIndex
		    Self.SetsList.Sort
		    Self.SetsList.EnsureSelectionIsVisible
		    
		    Self.UpdateLimitsList
		    
		    RaiseEvent Changed
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddButton", IconToolbarAdd)
		  AddButton.HelpTag = "Create a new spawn set."
		  Me.LeftItems.Append(AddButton)
		  
		  Var WizardButton As New BeaconToolbarItem("WizardButton", IconToolbarWizard)
		  WizardButton.HelpTag = "Quickly add a creature to this spawn point using a wizard."
		  Me.LeftItems.Append(WizardButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.SetsListWidth = NewSize
		  NewSize = Self.SetsListWidth
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetEditor
	#tag Event
		Sub Changed()
		  If Self.SetsList.SelectedRowCount <> 1 Then
		    Break
		    Return
		  End If
		  
		  Var Organizer As SpawnSetOrganizer = Self.SetsList.RowTagAt(Self.SetsList.SelectedRowIndex)
		  Organizer.Replicate()
		  
		  Self.SetsList.CellValueAt(Self.SetsList.SelectedRowIndex, 0) = Organizer.Label(Self.mSpawnPoints.LastRowIndex > 0)
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDocument() As Beacon.Document
		  Return Self.Document
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SetsList
	#tag Event
		Sub Change()
		  Self.UpdateSetsStatus()
		  
		  If Me.SelectedRowCount = 1 Then
		    Self.Pages.SelectedPanelIndex = Self.PageSetEditor
		    Self.SetEditor.SpawnSet = SpawnSetOrganizer(Me.RowTagAt(Me.SelectedRowIndex)).Template
		    Return
		  End If
		  
		  Self.SetEditor.SpawnSet = Nil
		  Self.Pages.SelectedPanelIndex = Self.PageNoSelection
		  Self.LogoCanvas.Caption = If(Me.SelectedRowCount = 0, "No Selection", "Multiple Selection")
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Organizers() As SpawnSetOrganizer
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Organizers.AddRow(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Organizers, "spawn set", "spawn sets") = False Then
		    Return
		  End If
		  
		  For Each Organizer As SpawnSetOrganizer In Organizers
		    Var Points() As Beacon.MutableSpawnPoint = Organizer.Points
		    For Each Point As Beacon.MutableSpawnPoint In Points
		      Var Set As Beacon.SpawnPointSet = Organizer.SetForPoint(Point)
		      Point.RemoveSet(Set)
		    Next
		  Next
		  
		  RaiseEvent Changed
		  Self.UpdateSetsList()
		  
		  #if false
		    If Warn Then
		      Var Dialog As New MessageDialog
		      Dialog.Title = ""
		      If Me.SelectedRowCount = 1 Then
		        Dialog.Message = "Are you sure you want to delete the selected spawn set?"
		      Else
		        Dialog.Message = "Are you sure you want to delete these " + Str(Me.SelectedRowCount, "-0") + " spawn sets?"
		      End If
		      Dialog.Explanation = "This action cannot be undone."
		      Dialog.ActionButton.Caption = "Delete"
		      Dialog.CancelButton.Visible = True
		      
		      Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		      If Choice = Dialog.CancelButton Then
		        Return
		      End If
		    End If
		    
		    Me.SelectionChangeBlocked = True
		    For I As Integer = Me.RowCount - 1 DownTo 0
		      If Me.Selected(I) Then
		        Var Organizer As SpawnSetOrganizer = Me.RowTagAt(I)
		        Var Points() As Beacon.MutableSpawnPoint = Organizer.Points
		        For Each Point As Beacon.MutableSpawnPoint In Points
		          Var Set As Beacon.SpawnPointSet = Organizer.SetForPoint(Point)
		          Point.RemoveSet(Set)
		        Next
		        Me.RemoveRowAt(I)
		      End If
		    Next
		    Me.SelectionChangeBlocked = False
		    
		    RaiseEvent Changed
		  #endif
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kSetsClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Type"": ""SpawnPointSet""") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Organizer As SpawnSetOrganizer = Me.RowTagAt(I)
		    Items.AddRow(Organizer.Template.SaveData)
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Items, True)
		  Board.Text = JSON
		  Board.AddRawData(JSON, Self.kSetsClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Me.CanPaste Then
		    Return
		  End If
		  
		  Var Items() As Variant
		  Try
		    If Board.RawDataAvailable(Self.kSetsClipboardType) Then
		      Items = Beacon.ParseJSON(Board.RawData(Self.kSetsClipboardType))
		    Else
		      Items = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var SelectSets() As Beacon.SpawnPointSet
		  For Each Item As Dictionary In Items
		    Var Set As Beacon.SpawnPointSet = Beacon.SpawnPointSet.FromSaveData(Item)
		    If Set = Nil Then
		      Continue
		    End If
		    
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      Point.AddSet(Set)
		    Next
		    
		    SelectSets.AddRow(Set)
		  Next
		  
		  RaiseEvent Changed
		  Self.UpdateSetsList(SelectSets)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LimitsList
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.UpdateLimitsStatus
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Var SelectedCreatures() As Beacon.Creature
		  For I As Integer = 0 To Self.LimitsList.RowCount - 1
		    If Self.LimitsList.Selected(I) Then
		      SelectedCreatures.AddRow(Beacon.Data.GetCreatureByPath(Self.LimitsList.RowTagAt(I).StringValue))
		    End If
		  Next
		  Self.PresentLimitsDialog(SelectedCreatures)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Creatures() As Beacon.Creature
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Me.RowTagAt(I).StringValue)
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Me.RowTagAt(I).StringValue)
		    End If
		    
		    Creatures.AddRow(Creature)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Creatures, "creature limit", "creature limits") = False Then
		    Return
		  End If
		  
		  For Each Creature As Beacon.Creature In Creatures
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      Point.Limit(Creature) = 1.0
		    Next
		  Next
		  
		  RaiseEvent Changed
		  Self.UpdateLimitsList()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kLimitsClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Type"": ""SpawnPointLimit""") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Limits As New Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Var Path As String = Me.RowTagAt(I)
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Path)
		    End If
		    
		    Var CommonLimit As NullableDouble
		    For Each Point As Beacon.SpawnPoint In Self.mSpawnPoints
		      Var Limit As NullableDouble = Point.Limit(Creature)
		      If Limit = Nil Or Limit = 1.0 Then
		        Continue
		      End If
		      
		      If CommonLimit = Nil Then
		        CommonLimit = Limit
		      ElseIf CommonLimit <> Limit Then
		        Continue For I
		      End If
		    Next
		    
		    If CommonLimit <> Nil Then
		      Limits.Value(Creature.Path) = CommonLimit.Value
		    End If
		  Next
		  
		  If Limits.KeyCount = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Limits.Value("Type") = "SpawnPointLimit"
		  
		  Var JSON As String = Beacon.GenerateJSON(Limits, True).Trim
		  Board.Text = JSON
		  Board.AddRawData(JSON, Self.kLimitsClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Dict As Dictionary
		  Try
		    If Board.RawDataAvailable(Self.kLimitsClipboardType) Then
		      Dict = Beacon.ParseJSON(Board.RawData(Self.kLimitsClipboardType))
		    Else
		      Dict = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    System.Beep
		    Return
		  End Try
		  
		  Var SelectCreatures() As Beacon.Creature
		  For Each Entry As DictionaryEntry In Dict
		    If Entry.Key = "SpawnPointLimit" Then
		      Continue
		    End If
		    
		    Var Path As String = Entry.Key
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Path)
		    End If
		    SelectCreatures.AddRow(Creature)
		    
		    Var Limit As Double = Entry.Value
		    For Each Point As Beacon.MutableSpawnPoint In Self.mSpawnPoints
		      Point.Limit(Creature) = Limit
		    Next
		  Next
		  
		  RaiseEvent Changed
		  Self.UpdateLimitsList(SelectCreatures)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
