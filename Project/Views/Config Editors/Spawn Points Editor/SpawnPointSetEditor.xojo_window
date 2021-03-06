#tag Window
Begin BeaconContainer SpawnPointSetEditor
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
   Height          =   678
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   784
   Begin GroupBox EntriesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creatures"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   304
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   428
      Begin BeaconListbox EntriesList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   34
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   216
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   "1"
         Scope           =   2
         SelectionChangeBlocked=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   98
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   388
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton EntryAddButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton EntryEditButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   132
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton EntryDeleteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   224
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin GroupBox ReplaceGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creature Replacement"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   304
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   460
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   304
      Begin BeaconListbox ReplaceList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   34
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   216
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   480
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   "1"
         Scope           =   2
         SelectionChangeBlocked=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   98
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   264
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton ReplaceAddButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   480
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ReplaceEditButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   572
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ReplaceDeleteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   664
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   326
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UITweaks.ResizedTextField NameField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   103
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   472
   End
   Begin RangeField WeightField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   670
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   "500"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel NameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Name:"
      Visible         =   True
      Width           =   71
   End
   Begin UITweaks.ResizedLabel WeightLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   587
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Weight:"
      Visible         =   True
      Width           =   71
   End
   Begin UpDownArrows WeightStepper
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   751
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin GroupBox AdvancedGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Advanced (Optional)"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   280
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   378
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   744
      Begin UITweaks.ResizedLabel WaterMinHeightLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   584
         Transparent     =   False
         Underline       =   False
         Value           =   "(Water Only) Min Height:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel SpreadRadiusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   550
         Transparent     =   False
         Underline       =   False
         Value           =   "Spread Radius:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel TameDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   516
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Tames Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel StructureDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   482
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Structures Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel PlayerDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   448
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Players Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel OffsetLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   414
         Transparent     =   False
         Underline       =   False
         Value           =   "Offset (X, Y, Z):"
         Visible         =   True
         Width           =   228
      End
      Begin RangeField WaterMinHeightField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   584
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField SpreadRadiusField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   550
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField TameDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   516
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField StructureDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   482
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField PlayerDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   448
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   2
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   464
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   414
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   1
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   372
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   414
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   0
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   414
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin CheckBox OffsetBeforeMultiplierCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Add Level Offset Before Multiplier"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "When enabled, any level multipliers will be applied before adding any level offsets. When disabled, offsets are added first, then the multipliers are used."
         Top             =   618
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   464
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Const ReplaceMinWidth = 304
		  
		  Var AvailableWidth As Integer = Self.Width - 52
		  Var ReplacementsWidth As Integer = Max(AvailableWidth * 0.4, ReplaceMinWidth)
		  Var EntriesWidth As Integer = AvailableWidth - ReplacementsWidth
		  
		  Self.EntriesGroup.Width = EntriesWidth
		  Self.ReplaceGroup.Left = Self.EntriesGroup.Left + Self.EntriesGroup.Width + 12
		  Self.ReplaceGroup.Width = ReplacementsWidth
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Document() As Beacon.Document
		  Return RaiseEvent GetDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnSet() As Beacon.MutableSpawnPointSet
		  If Self.mRef <> Nil And Self.mRef.Value <> Nil Then
		    Return Beacon.MutableSpawnPointSet(Self.mRef.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnSet(Assigns Set As Beacon.MutableSpawnPointSet)
		  If Set = Self.SpawnSet Then
		    Return
		  End If
		  
		  If Set = Nil Then
		    Self.mRef = Nil
		    Self.UpdateUI(New Beacon.MutableSpawnPointSet)
		    Return
		  End If
		  
		  Self.mRef = New WeakRef(Set)
		  Self.UpdateUI(Set)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntriesList(Set As Beacon.SpawnPointSet, SelectEntries() As Beacon.SpawnPointSetEntry = Nil)
		  Var List As BeaconListbox = Self.EntriesList
		  
		  Var SelectedEntries() As String
		  If SelectEntries = Nil Then
		    For I As Integer = 0 To List.RowCount - 1
		      If List.Selected(I) Then
		        Var Entry As Beacon.SpawnPointSetEntry = List.RowTagAt(I)
		        SelectedEntries.AddRow(Entry.ID)
		      End If
		    Next
		  Else
		    For Each Entry As Beacon.SpawnPointSetEntry In SelectEntries
		      SelectedEntries.AddRow(Entry.ID)
		    Next
		  End If
		  
		  Var RowHeight As Integer = BeaconListbox.StandardRowHeight
		  List.SelectionChangeBlocked = True
		  List.RowCount = Set.Count
		  Var Bound As Integer = Set.Count - 1
		  For RowIndex As Integer = 0 To Bound
		    Var Entry As Beacon.SpawnPointSetEntry = Set.Entry(RowIndex)
		    
		    Var Figures() As String
		    If Entry.Offset <> Nil Then
		      Figures.AddRow("Offset: " + Entry.Offset.X.PrettyText + "," + Entry.Offset.Y.PrettyText + "," + Entry.Offset.Z.PrettyText)
		    End If
		    If Entry.SpawnChance <> Nil Then
		      Figures.AddRow("Weight: " + Entry.SpawnChance.Value.PrettyText)
		    End If
		    If Entry.LevelCount > 0 Or Entry.MinLevelOffset <> Nil Or Entry.MaxLevelOffset <> Nil Or Entry.MinLevelMultiplier <> Nil Or Entry.MaxLevelMultiplier <> Nil Then
		      Var Difficulty As Double = Self.Document.DifficultyValue
		      Var LevelRange As Beacon.Range = Entry.LevelRangeForDifficulty(Difficulty, Set.LevelOffsetBeforeMultiplier)
		      Figures.AddRow("Level Range Override: " + LevelRange.Min.PrettyText() + " to " + LevelRange.Max.PrettyText())
		    End If
		    Figures.Sort
		    
		    Var Label As String = Entry.Creature.Label
		    If Figures.LastRowIndex > -1 Then
		      Label = Label + EndOfLine + Figures.Join("   ")
		      RowHeight = BeaconListbox.DoubleLineRowHeight
		    End If
		    
		    List.RowTagAt(RowIndex) = Entry.MutableVersion
		    List.CellValueAt(RowIndex, 0) = Label
		    List.Selected(RowIndex) = SelectedEntries.IndexOf(Entry.ID) > -1
		  Next
		  If List.DefaultRowHeight <> RowHeight Then
		    List.DefaultRowHeight = RowHeight
		  End If
		  List.SortingColumn = 0
		  List.Sort
		  List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateReplacementsList(Set As Beacon.SpawnPointSet, SelectCreatures() As Beacon.Creature = Nil)
		  Var SelectedReplacements() As String
		  If SelectCreatures = Nil Then
		    For I As Integer = 0 To Self.ReplaceList.RowCount - 1
		      If Self.ReplaceList.Selected(I) Then
		        SelectedReplacements.AddRow(Self.ReplaceList.RowTagAt(I))
		      End If
		    Next
		  Else
		    For Each Creature As Beacon.Creature In SelectCreatures
		      SelectedReplacements.AddRow(Creature.Path)
		    Next
		  End If
		  
		  Var ReplacedCreatures() As Beacon.Creature = Set.ReplacedCreatures
		  Self.ReplaceList.SelectionChangeBlocked = True
		  Self.ReplaceList.RowCount = ReplacedCreatures.LastRowIndex + 1
		  For RowIndex As Integer = 0 To ReplacedCreatures.LastRowIndex
		    Var ReplacedCreature As Beacon.Creature = ReplacedCreatures(RowIndex)
		    Var ReplacementCreatures() As Beacon.Creature = Set.ReplacementCreatures(ReplacedCreature)
		    
		    Var TotalWeight As Double
		    For Each ReplacementCreature As Beacon.Creature In ReplacementCreatures
		      Var Weight As NullableDouble = Set.CreatureReplacementWeight(ReplacedCreature, ReplacementCreature)
		      If Weight <> Nil Then
		        TotalWeight = TotalWeight + Weight
		      End If
		    Next
		    
		    Var ReplacementCreatureNames() As String
		    For Each ReplacementCreature As Beacon.Creature In ReplacementCreatures
		      Var Label As String = ReplacementCreature.Label
		      Var Weight As NullableDouble = Set.CreatureReplacementWeight(ReplacedCreature, ReplacementCreature)
		      If Weight <> Nil Then
		        Var Chance As Double = (Weight / TotalWeight) * 100
		        Label = Label + " (" + Chance.PrettyText(2) + "%)"
		      End If
		      ReplacementCreatureNames.AddRow(Label)
		    Next
		    ReplacementCreatureNames.Sort
		    
		    Self.ReplaceList.CellValueAt(RowIndex, 0) = ReplacedCreature.Label + EndOfLine + Language.EnglishOxfordList(ReplacementCreatureNames)
		    Self.ReplaceList.RowTagAt(RowIndex) = ReplacedCreature.Path
		    Self.ReplaceList.Selected(RowIndex) = SelectedReplacements.IndexOf(ReplacedCreature.Path) > -1
		  Next
		  Self.ReplaceList.SortingColumn = 0
		  Self.ReplaceList.Sort
		  Self.ReplaceList.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI(Set As Beacon.SpawnPointSet)
		  Self.mSettingUp = True
		  
		  Self.NameField.Value = Set.Label
		  Self.WeightField.DoubleValue = Set.Weight
		  Self.OffsetBeforeMultiplierCheck.Value = Set.LevelOffsetBeforeMultiplier
		  
		  If Set.GroupOffset <> Nil Then
		    Self.OffsetFields(0).DoubleValue = Set.GroupOffset.X
		    Self.OffsetFields(1).DoubleValue = Set.GroupOffset.Y
		    Self.OffsetFields(2).DoubleValue = Set.GroupOffset.Z
		  Else
		    Self.OffsetFields(0).Clear
		    Self.OffsetFields(1).Clear
		    Self.OffsetFields(2).Clear
		  End If
		  
		  If Set.MinDistanceFromPlayersMultiplier <> Nil Then
		    Self.PlayerDistanceField.DoubleValue = Set.MinDistanceFromPlayersMultiplier
		  Else
		    Self.PlayerDistanceField.Clear
		  End If
		  
		  If Set.MinDistanceFromStructuresMultiplier <> Nil Then
		    Self.StructureDistanceField.DoubleValue = Set.MinDistanceFromStructuresMultiplier
		  Else
		    Self.StructureDistanceField.Clear
		  End If
		  
		  If Set.MinDistanceFromTamedDinosMultiplier <> Nil Then
		    Self.TameDistanceField.DoubleValue = Set.MinDistanceFromTamedDinosMultiplier
		  Else
		    Self.TameDistanceField.Clear
		  End If
		  
		  If Set.SpreadRadius <> Nil Then
		    Self.SpreadRadiusField.DoubleValue = Set.SpreadRadius
		  Else
		    Self.SpreadRadiusField.Clear
		  End If
		  
		  If Set.WaterOnlyMinimumHeight <> Nil Then
		    Self.WaterMinHeightField.DoubleValue = Set.WaterOnlyMinimumHeight
		  Else
		    Self.WaterMinHeightField.Clear
		  End If
		  
		  Self.UpdateEntriesList(Set)
		  Self.UpdateReplacementsList(Set)
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetDocument() As Beacon.Document
	#tag EndHook


	#tag Property, Flags = &h21
		Private mRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = kEntryClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.spawn.entry", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kReplacementClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.spawn.replacement", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"660", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WeightScale, Type = Double, Dynamic = False, Default = \"1.0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events EntriesList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kEntryClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Type"": ""SpawnPointSetEntry""") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.RowCount - 1
		  Var EntriesToDelete() As Beacon.SpawnPointSetEntry
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Var Entry As Beacon.SpawnPointSetEntry = Me.RowTagAt(I)
		    EntriesToDelete.AddRow(Entry)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(EntriesToDelete, "creature", "creatures") = False Then
		    Return
		  End If
		  
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var Changed As Boolean
		  For Each Entry As Beacon.SpawnPointSetEntry In EntriesToDelete
		    Var Idx As Integer = Set.IndexOf(Entry)
		    If Idx > -1 Then
		      Set.Remove(Idx)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    RaiseEvent Changed
		    Self.UpdateEntriesList(Set)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Items.AddRow(Beacon.SpawnPointSetEntry(Me.RowTagAt(I)).SaveData)
		    End If
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Items, True)
		  Board.Text = JSON.Trim
		  Board.AddRawData(JSON, Self.kEntryClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Me.CanPaste Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Items() As Variant
		  Try
		    If Board.RawDataAvailable(Self.kEntryClipboardType) Then
		      Items = Beacon.ParseJSON(Board.RawData(Self.kEntryClipboardType))
		    Else
		      Items = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var SelectEntries() As Beacon.SpawnPointSetEntry
		  For Each Item As Dictionary In Items
		    Var Entry As Beacon.SpawnPointSetEntry = Beacon.SpawnPointSetEntry.FromSaveData(Item)
		    If Entry = Nil Then
		      Continue
		    End If
		    
		    Set.Append(Entry)
		    SelectEntries.AddRow(Entry)
		  Next
		  
		  Self.UpdateEntriesList(Set, SelectEntries)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.EntryDeleteButton.Enabled = Me.CanDelete
		  Self.EntryEditButton.Enabled = Me.CanEdit
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Entries() As Beacon.MutableSpawnPointSetEntry
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Entries.AddRow(Me.RowTagAt(I))
		  Next
		  
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var UpdatedEntries() As Beacon.MutableSpawnPointSetEntry = SpawnPointCreatureDialog.Present(Self, Self.Document, Set, Entries)
		  If UpdatedEntries = Nil Or UpdatedEntries.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  For Each Entry As Beacon.MutableSpawnPointSetEntry In Entries
		    Set.Remove(Entry)
		  Next
		  For Each Entry As Beacon.MutableSpawnPointSetEntry In UpdatedEntries
		    Set.Append(Entry)
		  Next
		  
		  Self.UpdateEntriesList(Set, UpdatedEntries)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryAddButton
	#tag Event
		Sub Action()
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var Entry As Beacon.MutableSpawnPointSetEntry = SpawnPointCreatureDialog.Present(Self, Self.Document, Set)
		  If Entry = Nil Then
		    Return
		  End If
		  
		  Set.Append(Entry)
		  
		  Var Entries(0) As Beacon.MutableSpawnPointSetEntry
		  Entries(0) = Entry
		  Self.UpdateEntriesList(Set, Entries)
		  Self.EntriesList.EnsureSelectionIsVisible()
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryEditButton
	#tag Event
		Sub Action()
		  Self.EntriesList.DoEdit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryDeleteButton
	#tag Event
		Sub Action()
		  Self.EntriesList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kReplacementClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Replacements"": [") > -1 And Board.Text.IndexOf("""Creature"": ""/Game/") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.ReplaceDeleteButton.Enabled = Me.CanDelete
		  Self.ReplaceEditButton.Enabled = Me.CanEdit
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.RowCount - 1
		  Var CreaturesToDelete() As Beacon.Creature
		  For I As Integer = Bound DownTo 0
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Me.RowTagAt(I))
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Me.RowTagAt(I))
		    End If
		    
		    CreaturesToDelete.AddRow(Creature)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(CreaturesToDelete, "creature replacement", "creature replacements") = False Then
		    Return
		  End If
		  
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var Changed As Boolean
		  For Each FromCreature As Beacon.Creature In CreaturesToDelete
		    Var Replacements() As Beacon.Creature = Set.ReplacementCreatures(FromCreature)
		    For Each ToCreature As Beacon.Creature In Replacements
		      If Set.CreatureReplacementWeight(FromCreature, ToCreature) <> Nil Then
		        Set.CreatureReplacementWeight(FromCreature, ToCreature) = Nil
		        Changed = True
		      End If
		    Next
		  Next
		  
		  If Changed Then
		    RaiseEvent Changed
		    Self.UpdateReplacementsList(Set)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items() As Dictionary
		  Var Set As Beacon.SpawnPointSet = Self.SpawnSet
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Path As String = Me.RowTagAt(I)
		    Var FromCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If FromCreature = Nil Then
		      FromCreature = Beacon.Creature.CreateFromPath(Path)
		    End If
		    
		    Var Replacements() As Beacon.Creature = Set.ReplacementCreatures(FromCreature)
		    Var Map As New Dictionary
		    For Each ToCreature As Beacon.Creature In Replacements
		      Var Weight As Double = Set.CreatureReplacementWeight(FromCreature, ToCreature)
		      Map.Value(ToCreature.Path) = Weight
		    Next
		    
		    Var Dict As New Dictionary
		    Dict.Value("Creature") = FromCreature.Path
		    Dict.Value("Replacements") = Map
		    Items.AddRow(Dict)
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Items, True)
		  Board.Text = JSON.Trim
		  Board.AddRawData(Self.kReplacementClipboardType, JSON)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Me.CanPaste Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Items() As Variant
		  Try
		    If Board.RawDataAvailable(Self.kReplacementClipboardType) Then
		      Items = Beacon.ParseJSON(Board.RawData(Self.kEntryClipboardType))
		    Else
		      Items = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Set As Beacon.MutableSpawnPointSet = Self.SpawnSet
		  Var SelectCreatures() As Beacon.Creature
		  For Each Item As Dictionary In Items
		    If Item.HasKey("Creature") = False Or Item.HasKey("Replacements") = False Then
		      Continue
		    End If
		    
		    Var FromPath As String = Item.Value("Creature")
		    Var FromCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(FromPath)
		    If FromCreature = Nil Then
		      FromCreature = Beacon.Creature.CreateFromPath(FromPath)
		    End If
		    
		    Var Maps() As Variant = Item.Value("Replacements")
		    For Each Map As Dictionary In Maps
		      For Each MapEntry As DictionaryEntry In Map
		        Var ToPath As String = MapEntry.Key
		        Var ToCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(ToPath)
		        If ToCreature = Nil Then
		          ToCreature = Beacon.Creature.CreateFromPath(ToPath)
		        End If
		        Var Weight As Double = MapEntry.Value
		        Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		      Next
		    Next
		    
		    SelectCreatures.AddRow(FromCreature)
		  Next
		  
		  Self.UpdateReplacementsList(Set, SelectCreatures)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var TargetPath As String = Self.ReplaceList.RowTagAt(Self.ReplaceList.SelectedRowIndex)
		  Var TargetCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(TargetPath)
		  If TargetCreature = Nil Then
		    TargetCreature = Beacon.Creature.CreateFromPath(TargetPath)
		  End If
		  
		  Var Creature As Beacon.Creature = SpawnPointReplacementsDialog.Present(Self, Self.Document.Mods, Self.SpawnSet, TargetCreature)
		  If Creature <> Nil Then
		    Var Creatures(0) As Beacon.Creature
		    Creatures(0) = Creature
		    Self.UpdateReplacementsList(Self.SpawnSet, Creatures)
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceAddButton
	#tag Event
		Sub Action()
		  Var Creature As Beacon.Creature = SpawnPointReplacementsDialog.Present(Self, Self.Document.Mods, Self.SpawnSet)
		  If Creature = Nil Then
		    Return
		  End If
		  
		  Var Creatures(0) As Beacon.Creature
		  Creatures(0) = Creature
		  Self.UpdateReplacementsList(Self.SpawnSet, Creatures)
		  Self.ReplaceList.EnsureSelectionIsVisible
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceEditButton
	#tag Event
		Sub Action()
		  Self.ReplaceList.DoEdit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceDeleteButton
	#tag Event
		Sub Action()
		  Self.ReplaceList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.Label = Me.Value
		  If Self.SpawnSet.Modified Then
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightField
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Value As Double = Me.DoubleValue
		  If Value = 0 Then
		    Return
		  End If
		  
		  Self.SpawnSet.Weight = Value
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue - (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue + (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaterMinHeightField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Value = "" Then
		    Self.SpawnSet.WaterOnlyMinimumHeight = Nil
		  Else
		    Self.SpawnSet.WaterOnlyMinimumHeight = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SpreadRadiusField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Value = "" Then
		    Self.SpawnSet.SpreadRadius = Nil
		  Else
		    Self.SpawnSet.SpreadRadius = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TameDistanceField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Value = "" Then
		    Self.SpawnSet.MinDistanceFromTamedDinosMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromTamedDinosMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StructureDistanceField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Value = "" Then
		    Self.SpawnSet.MinDistanceFromStructuresMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromStructuresMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PlayerDistanceField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Value = "" Then
		    Self.SpawnSet.MinDistanceFromPlayersMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromPlayersMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OffsetFields
	#tag Event
		Sub GetRange(index as Integer, ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(index as Integer, DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange(index as Integer)
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Offset As Beacon.Point3D
		  If OffsetFields(0).Value = "" Or OffsetFields(1).Value = "" Or OffsetFields(2).Value = "" Then
		    Offset = Nil
		  Else
		    Offset = New Beacon.Point3D(OffsetFields(0).DoubleValue, OffsetFields(1).DoubleValue, OffsetFields(2).DoubleValue)
		  End If
		  
		  If Self.SpawnSet.GroupOffset <> Offset Then
		    Self.SpawnSet.GroupOffset = Offset
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(index as Integer, Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OffsetBeforeMultiplierCheck
	#tag Event
		Sub Action()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.LevelOffsetBeforeMultiplier = Me.Value
		  Self.UpdateEntriesList(Self.SpawnSet)
		  If Self.SpawnSet.Modified Then
		    RaiseEvent Changed
		  End If
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
