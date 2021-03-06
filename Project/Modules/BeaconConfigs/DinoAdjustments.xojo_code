#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class DinoAdjustments
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  
		  Var Behaviors() As Beacon.CreatureBehavior = Self.All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    If Behavior.TargetCreature.ValidForMods(SourceDocument.Mods) = False Then
		      Continue
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "NPCReplacements", "(FromClassName=""" + Behavior.TargetClass + """,ToClassName="""")"))
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "NPCReplacements", "(FromClassName=""" + Behavior.TargetClass + """,ToClassName=""" + Behavior.ReplacementCreature.ClassString + """)"))
		    Else
		      If Behavior.DamageMultiplier <> 1.0 Then
		        Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "DinoClassDamageMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.DamageMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.ResistanceMultiplier <> 1.0 Then
		        Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "DinoClassResistanceMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.ResistanceMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.TamedDamageMultiplier <> 1.0 Then
		        Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "TamedDinoClassDamageMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.TamedDamageMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.TamedResistanceMultiplier <> 1.0 Then
		        Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "TamedDinoClassResistanceMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.TamedResistanceMultiplier.PrettyText + ")"))
		      End If
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Self.mBehaviors = New Dictionary
		  
		  If Not Dict.HasKey("Creatures") Then
		    Return
		  End If
		  
		  Var Dicts() As Variant = Dict.Value("Creatures")
		  For Each CreatureDict As Dictionary In Dicts
		    Var Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior.FromDictionary(CreatureDict)
		    If Behavior = Nil Then
		      Return
		    End If
		    
		    Self.mBehaviors.Value(Behavior.TargetCreature.Path) = Behavior
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Dicts() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
		    Dicts.AddRow(Behavior.ToDictionary)
		  Next
		  
		  Dict.Value("Creatures") = Dicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Behavior As Beacon.CreatureBehavior)
		  Self.Behavior(Behavior.TargetCreature) = Behavior
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function All() As Beacon.CreatureBehavior()
		  Var Behaviors() As Beacon.CreatureBehavior
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
		    Behaviors.AddRow(New Beacon.CreatureBehavior(Behavior))
		  Next
		  Return Behaviors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behavior(Creature As Beacon.Creature) As Beacon.CreatureBehavior
		  If Not Self.mBehaviors.HasKey(Creature.Path) Then
		    Return Nil
		  End If
		  
		  Var Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior(Self.mBehaviors.Value(Creature.Path))
		  Return New Beacon.CreatureBehavior(Behavior)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Behavior(Creature As Beacon.Creature, Assigns Behavior As Beacon.CreatureBehavior)
		  Self.mBehaviors.Value(Creature.Path) = New Beacon.CreatureBehavior(Behavior)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "DinoAdjustments"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mBehaviors = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.DinoAdjustments
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var Config As New BeaconConfigs.DinoAdjustments()
		  
		  Var Replacements() As Variant = ParsedData.AutoArrayValue("NPCReplacements")
		  For Each Entry As Variant In Replacements
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("FromClassName") = False Or Dict.HasKey("ToClassName") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("FromClassName")
		      Var ReplacementClass As String = Dict.Value("ToClassName")
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      If ReplacementClass = "" Then
		        Behavior.ProhibitSpawning = True
		      Else
		        Var Replacement As Beacon.Creature = Beacon.Data.GetCreatureByClass(ReplacementClass)
		        If IsNull(Replacement) Then
		          Replacement = Beacon.Creature.CreateFromClass(ReplacementClass)
		        End If
		        Behavior.ReplacementCreature = Replacement
		      End If
		      Config.Add(Behavior)
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Var WildDamageMultipliers() As Variant = ParsedData.AutoArrayValue("DinoClassDamageMultipliers")
		  For Each Entry As Variant In WildDamageMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.DamageMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Var WildResistanceMultipliers() As Variant = ParsedData.AutoArrayValue("DinoClassResistanceMultipliers")
		  For Each Entry As Variant In WildResistanceMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.ResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Var TamedDamageMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassDamageMultipliers")
		  For Each Entry As Variant In TamedDamageMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.TamedDamageMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Var TamedResistanceMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassResistanceMultipliers")
		  For Each Entry As Variant In TamedResistanceMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.TamedResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
		    If Behavior.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For Each Entry As DictionaryEntry In Self.mBehaviors
		      Var Behavior As Beacon.CreatureBehavior = Entry.Value
		      Behavior.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As BeaconConfigs.DinoAdjustments, Creature As Beacon.Creature) As Beacon.MutableCreatureBehavior
		  Var Behavior As Beacon.CreatureBehavior = Config.Behavior(Creature)
		  If Behavior <> Nil Then
		    Return New Beacon.MutableCreatureBehavior(Behavior)
		  Else
		    Return New Beacon.MutableCreatureBehavior(Creature)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As BeaconConfigs.DinoAdjustments, ClassString As String) As Beacon.MutableCreatureBehavior
		  Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByClass(ClassString)
		  If IsNull(Creature) Then
		    Creature = Beacon.Creature.CreateFromClass(ClassString)
		  End If
		  Return MutableBehavior(Config, Creature)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(Creature As Beacon.Creature)
		  If Self.mBehaviors.HasKey(Creature.Path) Then
		    Self.mBehaviors.Remove(Creature.Path)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBehaviors As Dictionary
	#tag EndProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
