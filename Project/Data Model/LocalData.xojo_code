#tag Class
Protected Class LocalData
Implements Beacon.DataSource,NotificationKit.Receiver
	#tag Method, Flags = &h21
		Private Function AddBlueprintToDatabase(Category As String, BlueprintData As Dictionary, ExtraValues As Dictionary = Nil) As Boolean
		  Try
		    Dim ObjectID As v4UUID = BlueprintData.Value("id").StringValue
		    Dim Label As String = BlueprintData.Value("label")
		    Dim ModID As v4UUID = Dictionary(BlueprintData.Value("mod")).Value("id").StringValue
		    Dim Availability As Integer = BlueprintData.Value("availability").IntegerValue
		    Dim Path As String = BlueprintData.Value("path").StringValue
		    Dim ClassString As String = BlueprintData.Value("class_string").StringValue
		    Dim TagString, TagStringForSearching As String
		    Try
		      Dim Tags() As String
		      Dim Temp() As Variant = BlueprintData.Value("tags")
		      For Each Tag As String In Temp
		        Tags.AddRow(Tag)
		      Next
		      TagString = Tags.Join(",")
		      Tags.AddRowAt(0, "object")
		      TagStringForSearching = Tags.Join(",")
		    Catch Err As TypeMismatchException
		      
		    End Try
		    
		    // Set the extra values first so our values take priority without
		    // using HasKey, which would cost performance
		    Dim Columns As New Dictionary
		    If ExtraValues <> Nil Then
		      For Each Entry As DictionaryEntry In ExtraValues
		        Columns.Value(Entry.Key) = Entry.Value
		      Next
		    End If
		    Columns.Value("object_id") = ObjectID.StringValue
		    Columns.Value("mod_id") = ModID.StringValue
		    Columns.Value("label") = Label
		    Columns.Value("availability") = Availability
		    Columns.Value("path") = Path
		    Columns.Value("class_string") = ClassString
		    Columns.Value("tags") = TagString
		    
		    Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM " + Category + " WHERE object_id = ?1 OR LOWER(path) = ?2;", ObjectID.StringValue, Path.Lowercase)
		    If Results.RowCount = 1 And ObjectID = Results.Column("object_id").StringValue Then
		      Dim Assignments() As String
		      Dim Values() As Variant
		      Dim NextPlaceholder As Integer = 1
		      Dim WhereClause As String
		      For Each Entry As DictionaryEntry In Columns
		        If Entry.Key = "object_id" Then
		          WhereClause = "object_id = ?" + NextPlaceholder.ToString
		        Else
		          Assignments.AddRow(Entry.Key.StringValue + " = ?" + NextPlaceholder.ToString)
		        End If
		        Values.AddRow(Entry.Value)
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      
		      Self.SQLExecute("UPDATE " + Category + " SET " + Assignments.Join(", ") + " WHERE " + WhereClause + ";", Values)
		      Self.SQLExecute("UPDATE searchable_tags SET tags = ?2 WHERE object_id = ?1 AND source_table = ?3;", ObjectID.StringValue, TagStringForSearching, Category)
		    Else
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("DELETE FROM " + Category + " WHERE object_id = ?1;", Results.Column("object_id").StringValue)
		        Self.SQLExecute("DELETE FROM searchable_tags WHERE object_id = ?1 AND source_table = ?3;", Results.Column("object_id").StringValue, Category)
		      End If
		      
		      Dim ColumnNames(), Placeholders() As String
		      Dim Values() As Variant
		      Dim NextPlaceholder As Integer = 1
		      For Each Entry As DictionaryEntry In Columns
		        ColumnNames.AddRow(Entry.Key.StringValue)
		        Placeholders.AddRow("?" + NextPlaceholder.ToString)
		        Values.AddRow(Entry.Value)
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      
		      Self.SQLExecute("INSERT INTO " + Category + " (" + ColumnNames.Join(", ") + ") VALUES (" + Placeholders.Join(", ") + ");", Values)
		      Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, ?3);", ObjectID.StringValue, TagStringForSearching, Category)
		    End If
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddPresetModifier(Modifier As Beacon.PresetModifier)
		  Self.BeginTransaction()
		  Dim Results As RowSet = Self.SQLSelect("SELECT mod_id FROM preset_modifiers WHERE object_id = ?1;", Modifier.ModifierID)
		  If Results.RowCount = 1 Then
		    If Results.Column("mod_id").StringValue = Self.UserModID Then
		      Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3 WHERE object_id = ?1;", Modifier.ModifierID, Modifier.Label, Modifier.Pattern)
		    End If
		  Else
		    Self.SQLExecute("INSERT INTO preset_modifiers (object_id, mod_id, label, pattern) VALUES (?1, ?2, ?3, ?4);", Modifier.ModifierID, Self.UserModID, Modifier.Label, Modifier.Pattern)
		  End If
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllMods() As Beacon.ModDetails()
		  Dim Mods() As Beacon.ModDetails
		  Dim Results As RowSet = Self.SQLSelect("SELECT mod_id, name, console_safe FROM mods ORDER BY name;")
		  While Not Results.AfterLastRow
		    Mods.AddRow(New Beacon.ModDetails(Results.Column("mod_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue))
		    Results.MoveToNextRow
		  Wend
		  Return Mods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllPresetModifiers() As Beacon.PresetModifier()
		  Dim Results As RowSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers ORDER BY label;")
		  Dim Modifiers() As Beacon.PresetModifier
		  While Not Results.AfterLastRow
		    Dim Dict As New Dictionary
		    Dict.Value("ModifierID") = Results.Column("object_id").StringValue
		    Dict.Value("Pattern") = Results.Column("pattern").StringValue
		    Dict.Value("Label") = Results.Column("label").StringValue
		    
		    Dim Modifier As Beacon.PresetModifier = Beacon.PresetModifier.FromDictionary(Dict)
		    If Modifier <> Nil Then
		      Modifiers.AddRow(Modifier)
		    End If
		    
		    Results.MoveToNextRow
		  Wend
		  Return Modifiers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllTags(Category As String = "") As String()
		  Dim Results As RowSet
		  If Category <> "" Then
		    Results = Self.SQLSelect("SELECT DISTINCT tags FROM searchable_tags WHERE source_table = $1 AND tags != '';", Category)
		  Else
		    Results = Self.SQLSelect("SELECT DISTINCT tags FROM searchable_tags WHERE tags != '';")
		  End If
		  Dim Dict As New Dictionary
		  While Not Results.AfterLastRow
		    Dim Tags() As String = Results.Column("tags").StringValue.Split(",")
		    For Each Tag As String In Tags
		      If Tag <> "object" Then
		        Dict.Value(Tag) = True
		      End If
		    Next
		    Results.MoveToNextRow
		  Wend
		  
		  Dim Keys() As Variant = Dict.Keys
		  Dim Tags() As String
		  For Each Key As String In Keys
		    Tags.AddRow(Key)
		  Next
		  Tags.Sort
		  
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginTransaction()
		  Self.mLock.Enter
		  
		  If Self.mTransactions.LastRowIndex = -1 Then
		    Self.mTransactions.AddRowAt(0, "")
		    Self.SQLExecute("BEGIN TRANSACTION;")
		  Else
		    Dim Savepoint As String = "Savepoint_" + EncodeHex(Crypto.GenerateRandomBytes(4))
		    Self.mTransactions.AddRowAt(0, Savepoint)
		    Self.SQLExecute("SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Dim ModsOnDelete As String
		  #if DebugBuild
		    ModsOnDelete = "RESTRICT"
		  #else
		    ModsOnDelete = "CASCADE"
		  #endif
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("CREATE TABLE variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE mods (mod_id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, console_safe INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_source_icons (icon_id TEXT NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_sources (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT NOT NULL, sort_order INTEGER NOT NULL, icon TEXT NOT NULL REFERENCES loot_source_icons(icon_id) ON UPDATE CASCADE ON DELETE RESTRICT, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, tags TEXT NOT NULL DEFAULT '');")
		  Self.SQLExecute("CREATE TABLE official_presets (object_id TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_presets (user_id TEXT NOT NULL, object_id TEXT NOT NULL, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE preset_modifiers (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT NOT NULL, pattern TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_help (config_name TEXT NOT NULL PRIMARY KEY, title TEXT NOT NULL, body TEXT NOT NULL, detail_url TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE notifications (notification_id TEXT NOT NULL PRIMARY KEY, message TEXT NOT NULL, secondary_message TEXT, user_data TEXT NOT NULL, moment TEXT NOT NULL, read INTEGER NOT NULL, action_url TEXT, deleted INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE creatures (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, tags TEXT NOT NULL DEFAULT '', incubation_time INTEGER, mature_time INTEGER, stats TEXT);")
		  Self.SQLExecute("CREATE TABLE spawn_points (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, tags TEXT NOT NULL DEFAULT '', groups TEXT NOT NULL DEFAULT '[]', limits TEXT NOT NULL DEFAULT '{}');")
		  
		  Self.SQLExecute("CREATE VIRTUAL TABLE searchable_tags USING fts5(tags, object_id, source_table);")
		  
		  Self.SQLExecute("CREATE VIEW blueprints AS SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategoryEngrams + "' AS category FROM engrams UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategoryCreatures + "' AS category FROM creatures UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategorySpawnPoints + "' AS category FROM spawn_points")
		  Dim Categories() As String = Beacon.Categories
		  Dim DeleteStatements() As String
		  For Each Category As String In Categories
		    DeleteStatements.AddRow("DELETE FROM " + Category + " WHERE object_id = OLD.object_id;")
		  Next
		  Self.SQLExecute("CREATE TRIGGER blueprints_delete_trigger INSTEAD OF DELETE ON blueprints FOR EACH ROW BEGIN " + DeleteStatements.Join(" ") + " DELETE FROM searchable_tags WHERE object_id = OLD.object_id; END;")
		  
		  For Each Category As String In Categories
		    Self.SQLExecute("CREATE INDEX " + Category + "_class_string_idx ON " + Category + "(class_string);")
		    Self.SQLExecute("CREATE UNIQUE INDEX " + Category + "_path_idx ON " + Category + "(path);")
		  Next
		  Self.SQLExecute("CREATE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		  Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		  Self.SQLExecute("CREATE UNIQUE INDEX custom_presets_user_id_object_id_idx ON custom_presets(user_id, object_id);")
		  
		  Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe) VALUES (?1, ?2, ?3);", Self.UserModID, Self.UserModName, True)
		  Self.Commit()
		  
		  Self.mBase.UserVersion = Self.SchemaVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForEngramUpdates(ForceRefresh As Boolean = False)
		  If Self.mCheckingForUpdates Then
		    Return
		  End If
		  
		  If Self.mUpdater = Nil Then
		    Self.mUpdater = New URLConnection
		    Self.mUpdater.AllowCertificateValidation = True
		    Self.mUpdater.RequestHeader("Cache-Control") = "no-cache"
		    AddHandler Self.mUpdater.ContentReceived, WeakAddressOf Self.mUpdater_ContentReceived
		    AddHandler Self.mUpdater.Error, WeakAddressOf Self.mUpdater_Error
		  End If
		  
		  Self.mCheckingForUpdates = True
		  Var CheckURL As String = Self.ClassesURL(ForceRefresh)
		  App.Log("Checking for engram updates from " + CheckURL)
		  Self.mUpdater.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ClassesURL(ForceRefresh As Boolean) As String
		  Var Version As Integer = App.BuildNumber
		  Var CheckURL As String = Beacon.WebURL("/download/classes?version=" + Version.ToString)
		  
		  If ForceRefresh = False Then
		    Var LastSync As String = Self.Variable("sync_time")
		    If LastSync <> "" Then
		      CheckURL = CheckURL + "&changes_since=" + EncodeURLComponent(LastSync)
		    End If
		  End If
		  
		  If App.IdentityManager <> Nil And App.IdentityManager.CurrentIdentity <> Nil Then
		    CheckURL = CheckURL + "&user_id=" + EncodeURLComponent(App.IdentityManager.CurrentIdentity.Identifier)
		  End If
		  
		  Return CheckURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  NotificationKit.Ignore(Self, UserCloud.Notification_SyncFinished, IdentityManager.Notification_IdentityChanged)
		  
		  If Self.mBase <> Nil Then
		    Try
		      Self.SQLExecute("PRAGMA optimize;")
		      Self.mBase.Close
		    Catch Err As RuntimeException
		    End Try
		    Self.mBase = Nil
		  End If
		  
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Commit()
		  If Self.mTransactions.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveRowAt(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("COMMIT TRANSACTION;")
		    Self.mLastCommitTime = System.Microseconds
		  Else
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafeMods() As String()
		  Dim Results As RowSet = Self.SQLSelect("SELECT mod_id FROM mods WHERE console_safe = 1;")
		  Dim Mods() As String
		  While Not Results.AfterLastRow
		    Mods.AddRow(Results.Column("mod_id").StringValue)
		    Results.MoveToNextRow
		  Wend
		  Return Mods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  Self.mCreatureCache = New Dictionary
		  Self.mSpawnPointCache = New Dictionary
		  Self.mLock = New CriticalSection
		  Self.mDropsLabelCacheDict = New Dictionary
		  Self.mSpawnLabelCacheDict = New Dictionary
		  
		  Dim AppSupport As FolderItem = App.ApplicationSupport
		  Dim ShouldImportCloud As Boolean
		  
		  Dim LegacyFile As FolderItem = AppSupport.Child("Beacon.sqlite")
		  If LegacyFile.Exists Then
		    LegacyFile.Remove
		  End If
		  
		  Self.mBase = New SQLiteDatabase
		  Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		  
		  If Self.mBase.DatabaseFile.Exists Then
		    If Not Self.mBase.Connect Then
		      Return
		    End If
		  Else
		    Self.mBase.CreateDatabase
		    
		    Self.BuildSchema()
		    ShouldImportCloud = True
		  End If
		  
		  Dim CurrentSchemaVersion As Integer = Self.mBase.UserVersion
		  Dim MigrateFile As FolderItem
		  If CurrentSchemaVersion <> Self.SchemaVersion Then
		    Self.mBase.Close
		    
		    Dim BackupsFolder As FolderItem = AppSupport.Child("Old Libraries")
		    If Not BackupsFolder.Exists Then
		      BackupsFolder.CreateFolder
		    End If
		    
		    // Relocate the current library
		    Dim Counter As Integer = 1
		    Do
		      Dim Destination As FolderItem = BackupsFolder.Child("Library " + Str(CurrentSchemaVersion, "-0") + If(Counter > 1, "-" + Str(Counter, "-0"), "") + ".sqlite")
		      If Destination.Exists Then
		        Counter = Counter + 1
		        Continue
		      End If
		      Self.mBase.DatabaseFile.MoveTo(Destination)
		      MigrateFile = Destination
		      Exit
		    Loop
		    
		    // See if there is already a library, such as if the user went switched backward and forward between versions
		    Dim SearchFolders(1) As FolderItem
		    SearchFolders(0) = BackupsFolder
		    SearchFolders(1) = AppSupport
		    Dim SearchPrefix As String = "Library " + Str(Self.SchemaVersion, "-0")
		    Dim SearchSuffix As String = ".sqlite"
		    For Each SearchFolder As FolderItem In SearchFolders
		      Dim Candidates() As FolderItem
		      Dim Versions() As Integer
		      For I As Integer = 0 To SearchFolder.Count - 1
		        Dim Filename As String = SearchFolder.ChildAt(I).Name
		        If Filename = SearchPrefix + SearchSuffix Then
		          Candidates.AddRow(SearchFolder.ChildAt(I))
		          Versions.AddRow(1)
		        ElseIf Filename.BeginsWith(SearchPrefix) And Filename.EndsWith(SearchSuffix) Then
		          Candidates.AddRow(SearchFolder.ChildAt(I))
		          Versions.AddRow(Integer.FromString(Filename.Middle(SearchPrefix.Length + 1, Filename.Length - (SearchPrefix.Length + SearchSuffix.Length + 1))))
		        End If
		      Next
		      
		      If Candidates.LastRowIndex > -1 Then
		        Versions.SortWith(Candidates)
		        
		        Dim RestoreFile As FolderItem = Candidates(Candidates.LastRowIndex)
		        RestoreFile.MoveTo(AppSupport.Child("Library.sqlite"))
		        
		        Self.mBase = New SQLiteDatabase
		        Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		        Call Self.mBase.Connect
		        Return
		      End If
		    Next
		    
		    Self.mBase = New SQLiteDatabase
		    Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Library.sqlite")
		    Call Self.mBase.CreateDatabase
		    Self.BuildSchema()
		    ShouldImportCloud = True
		  End If
		  
		  Self.mBase.ExecuteSQL("PRAGMA cache_size = -100000;")
		  
		  // Careful removing this, the commit updates the mLastCommitTime property
		  Self.BeginTransaction()
		  Self.SQLExecute("UPDATE mods SET console_safe = ?2 WHERE mod_id = ?1 AND console_safe != ?2;", Self.UserModID, True)
		  Self.Commit()
		  
		  Dim Migrated As Boolean
		  If MigrateFile <> Nil And MigrateFile.Exists And CurrentSchemaVersion < Self.SchemaVersion Then
		    Try
		      Migrated = Self.MigrateData(MigrateFile, CurrentSchemaVersion)
		    Catch Err As RuntimeException
		      Var Message As String = Introspection.GetType(Err).FullName + " " + Err.Message
		      App.Log("Database migration failed: " + Message.Trim)
		    End Try
		  End If
		  If ShouldImportCloud And Migrated = False Then
		    // Per https://github.com/thommcgrath/Beacon/issues/191 cloud data should be imported
		    Self.mNextSyncImportAll = True
		  End If
		  
		  NotificationKit.Watch(Self, UserCloud.Notification_SyncFinished, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprint(Blueprint As Beacon.Blueprint)
		  Dim Arr(0) As Beacon.Blueprint
		  Arr(0) = Blueprint
		  Self.DeleteBlueprints(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprints(Blueprints() As Beacon.Blueprint)
		  Dim ObjectIDs() As String
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    ObjectIDs.AddRow("'" + Blueprint.ObjectID + "'")
		  Next
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM blueprints WHERE mod_id = '" + Self.UserModID + "' AND object_id IN (" + ObjectIDs.Join(",") + ");")
		  Self.Commit()
		  
		  Self.SyncUserEngrams()
		  NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteDataForMod(ModID As String)
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM loot_sources WHERE mod_id = ?1;", ModID)
		  Self.SQLExecute("DELETE FROM blueprints WHERE mod_id = ?1;", ModID)
		  Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id = ?1;", ModID)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteNotification(Notification As Beacon.UserNotification)
		  If Notification = Nil Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("UPDATE notifications SET deleted = 1 WHERE notification_id = ?1;", Notification.Identifier)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeletePreset(Preset As Beacon.Preset)
		  If Not Self.IsPresetCustom(Preset) Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Preset.PresetID)
		  Self.Commit()
		  
		  Call UserCloud.Delete("/Presets/" + Preset.PresetID.Lowercase + BeaconFileTypes.BeaconPreset.PrimaryExtension)
		  
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintByObjectID(ObjectID As v4UUID) As Beacon.Blueprint
		  Var Results As RowSet = Self.SQLSelect("SELECT category FROM blueprints WHERE object_id = ?1;", ObjectID.StringValue)
		  If Results.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Select Case Results.Column("category").StringValue
		  Case Beacon.CategoryEngrams
		    Return Self.GetEngramByID(ObjectID)
		  Case Beacon.CategoryCreatures
		    Return Self.GetCreatureByID(ObjectID)
		  Case Beacon.CategorySpawnPoints
		    Return Self.GetSpawnPointByID(ObjectID)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  Dim Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").BooleanValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigHelp(ConfigName As String, ByRef Title As String, ByRef Body As String, ByRef DetailURL As String) As Boolean
		  Dim Results As RowSet = Self.SQLSelect("SELECT title, body, detail_url FROM config_help WHERE config_name = ?1;", ConfigName.Lowercase)
		  If Results.RowCount <> 1 Then
		    Return False
		  End If
		  
		  Title = Results.Column("title").StringValue
		  Body = Results.Column("body").StringValue
		  DetailURL = If(Results.Column("detail_url").Value <> Nil, Results.Column("detail_url").StringValue, "")
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByClass(ClassString As String) As Beacon.Creature
		  // Part of the Beacon.DataSource interface.
		  
		  If ClassString.Length < 2 Or ClassString.Right(2) <> "_C" Then
		    ClassString = ClassString + "_C"
		  End If
		  
		  If Self.mCreatureCache.HasKey(ClassString) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		      Self.mCreatureCache.Value(Creatures(0).ClassString) = Creatures(0)
		      For Each Creature As Beacon.Creature In Creatures
		        Self.mCreatureCache.Value(Creature.Path) = Creature
		        Self.mCreatureCache.Value(Creature.ObjectID.StringValue) = Creature
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mCreatureCache.Value(ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByID(CreatureID As v4UUID) As Beacon.Creature
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mCreatureCache.HasKey(CreatureID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE object_id = ?1;", CreatureID.StringValue)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		      For Each Creature As Beacon.Creature In Creatures
		        Self.mCreatureCache.Value(Creature.Path) = Creature
		        Self.mCreatureCache.Value(Creature.ObjectID.StringValue) = Creature
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mCreatureCache.Value(CreatureID.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByPath(Path As String) As Beacon.Creature
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mCreatureCache.HasKey(Path) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE LOWER(path) = ?1;", Path.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		      For Each Creature As Beacon.Creature In Creatures
		        Self.mCreatureCache.Value(Creature.Path) = Creature
		        Self.mCreatureCache.Value(Creature.ObjectID.StringValue) = Creature
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mCreatureCache.Value(Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCustomEngrams() As Beacon.Engram()
		  Try
		    Dim RS As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE mods.mod_id = ?1;", Self.UserModID)
		    If RS.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RowSetToEngram(RS)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  Dim Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").DoubleValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByClass(ClassString As String) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If ClassString.Length < 2 Or ClassString.Right(2) <> "_C" Then
		    ClassString = ClassString + "_C"
		  End If
		  
		  If Self.mEngramCache.HasKey(ClassString) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      Self.mEngramCache.Value(Engrams(0).ClassString) = Engrams(0)
		      For Each Engram As Beacon.Engram In Engrams
		        Self.mEngramCache.Value(Engram.Path) = Engram
		        Self.mEngramCache.Value(Engram.ObjectID.StringValue) = Engram
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByID(EngramID As v4UUID) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(EngramID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE object_id = ?1;", EngramID.StringValue)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      For Each Engram As Beacon.Engram In Engrams
		        Self.mEngramCache.Value(Engram.Path) = Engram
		        Self.mEngramCache.Value(Engram.ObjectID.StringValue) = Engram
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(EngramID.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByPath(Path As String) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(Path) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE LOWER(path) = ?1;", Path.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      For Each Engram As Beacon.Engram In Engrams
		        Self.mEngramCache.Value(Engram.Path) = Engram
		        Self.mEngramCache.Value(Engram.ObjectID.StringValue) = Engram
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As String, Default As Integer = 0) As Integer
		  Dim Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").IntegerValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As String) As Beacon.LootSource
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    Dim Results As RowSet = Self.SQLSelect("SELECT " + Self.LootSourcesSelectColumns + " FROM loot_sources WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		    If Results.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Sources() As Beacon.LootSource = Self.RowSetToLootSource(Results)
		    Return Sources(0)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNotifications() As Beacon.UserNotification()
		  Dim Notifications() As Beacon.UserNotification
		  Dim Results As RowSet = Self.SQLSelect("SELECT * FROM notifications WHERE deleted = 0 ORDER BY moment DESC;")
		  While Not Results.AfterLastRow
		    Dim Notification As New Beacon.UserNotification
		    Notification.Message = Results.Column("message").StringValue
		    Notification.SecondaryMessage = Results.Column("secondary_message").StringValue
		    Notification.ActionURL = Results.Column("action_url").StringValue
		    Notification.Read = Results.Column("read").BooleanValue
		    Notification.Timestamp = NewDateFromSQLDateTime(Results.Column("moment").StringValue)
		    Try
		      Notification.UserData = Beacon.ParseJSON(Results.Column("user_data").StringValue)
		    Catch Err As RuntimeException
		    End Try
		    Notifications.AddRow(Notification)
		    
		    Results.MoveToNextRow
		  Wend
		  Return Notifications
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPreset(PresetID As String) As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    If Preset.PresetID = PresetID Then
		      Return Preset
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As String) As Beacon.PresetModifier
		  Dim Results As RowSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers WHERE LOWER(object_id) = LOWER(?1);", ModifierID)
		  If Results.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Dim Dict As New Dictionary
		  Dict.Value("ModifierID") = Results.Column("object_id").StringValue
		  Dict.Value("Pattern") = Results.Column("pattern").StringValue
		  Dict.Value("Label") = Results.Column("label").StringValue
		  Return Beacon.PresetModifier.FromDictionary(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByClass(ClassString As String) As Beacon.SpawnPoint
		  // Part of the Beacon.DataSource interface.
		  
		  If ClassString.Length < 2 Or ClassString.Right(2) <> "_C" Then
		    ClassString = ClassString + "_C"
		  End If
		  
		  If Self.mSpawnPointCache.HasKey(ClassString) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.mSpawnPointCache.Value(SpawnPoints(0).ClassString) = SpawnPoints(0)
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mSpawnPointCache.Value(SpawnPoint.Path) = SpawnPoint
		        Self.mSpawnPointCache.Value(SpawnPoint.ObjectID.StringValue) = SpawnPoint
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByID(SpawnPointID As v4UUID) As Beacon.SpawnPoint
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mSpawnPointCache.HasKey(SpawnPointID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE object_id = ?1;", SpawnPointID.StringValue)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mSpawnPointCache.Value(SpawnPoint.Path) = SpawnPoint
		        Self.mSpawnPointCache.Value(SpawnPoint.ObjectID.StringValue) = SpawnPoint
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(SpawnPointID.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByPath(Path As String) As Beacon.SpawnPoint
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mSpawnPointCache.HasKey(Path) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE LOWER(path) = ?1;", Path.Lowercase)
		      If Results.RowCount = 0 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mSpawnPointCache.Value(SpawnPoint.Path) = SpawnPoint
		        Self.mSpawnPointCache.Value(SpawnPoint.ObjectID.StringValue) = SpawnPoint
		      Next
		    Catch Err As UnsupportedOperationException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As Beacon.Creature, Mods As Beacon.StringList, Tags As String) As Beacon.SpawnPoint()
		  Var Clauses() As String
		  Var Values() As Variant
		  Clauses.AddRow("LOWER(spawn_points.groups) LIKE :placeholder:")
		  Values.AddRow("%" + Creature.Path.Lowercase + "%")
		  
		  Var Blueprints() As Beacon.Blueprint = Self.SearchForBlueprints(Beacon.CategorySpawnPoints, "", Mods, Tags, Clauses, Values)
		  Var SpawnPoints() As Beacon.SpawnPoint
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.SpawnPoint Then
		      SpawnPoints.AddRow(Beacon.SpawnPoint(Blueprint))
		    End If
		  Next
		  
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringVariable(Key As String, Default As String = "") As String
		  Dim Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Dim StringValue As String = Results.Column("value").StringValue
		    If StringValue.Encoding = Nil Then
		      If Encodings.UTF8.IsValidData(StringValue) Then
		        StringValue = StringValue.DefineEncoding(Encodings.UTF8)
		      Else
		        Return Default
		      End If
		    End If
		    Return StringValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasExperimentalLootSources(Mods As Beacon.StringList) As Boolean
		  Try
		    Dim Clauses(0) As String
		    Clauses(0) = "experimental = 1"
		    
		    Dim Values As New Dictionary
		    Dim NextPlaceholder As Integer = 1
		    If Mods.LastRowIndex > -1 Then
		      Dim Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.AddRow("?" + Str(NextPlaceholder))
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.AddRow("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    
		    Dim SQL As String = "SELECT COUNT(loot_sources.object_id) FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id) WHERE (" + Clauses.Join(") AND (") + ");"
		    Dim Results As RowSet
		    If Values.KeyCount > 0 Then
		      Results = Self.SQLSelect(SQL, Values)
		    Else
		      Results = Self.SQLSelect(SQL)
		    End If
		    Return Results.ColumnAt(0).IntegerValue > 0
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IconForLootSource(Source As Beacon.LootSource, BackgroundColor As Color) As Picture
		  Const IncludeExperimentalBadge = False
		  
		  // "Fix" background color to account for opacity. It's not perfect, but it's good.
		  Dim BackgroundOpacity As Double = (255 - BackgroundColor.Alpha) / 255
		  BackgroundColor = SystemColors.UnderPageBackgroundColor.BlendWith(RGB(BackgroundColor.Red, BackgroundColor.Green, BackgroundColor.Blue), BackgroundOpacity)
		  
		  Dim PrimaryColor, AccentColor As Color
		  Dim IconID As String
		  Dim Results As RowSet = Self.SQLSelect("SELECT loot_source_icons.icon_id, loot_source_icons.icon_data, loot_sources.experimental FROM loot_sources INNER JOIN loot_source_icons ON (loot_sources.icon = loot_source_icons.icon_id) WHERE loot_sources.class_string = ?1;", Source.ClassString)
		  Dim SpriteSheet, BadgeSheet As Picture
		  If Results.RowCount = 1 Then
		    SpriteSheet = Results.Column("icon_data").PictureValue
		    If IncludeExperimentalBadge And Results.Column("experimental").BooleanValue Then
		      BadgeSheet = IconExperimentalBadge
		      IconID = IconID + "exp"
		    End If
		    IconID = Results.Column("icon_id").StringValue
		    PrimaryColor = Source.UIColor
		  Else
		    SpriteSheet = IconLootStandard
		    IconID = "3a1f5d12-0b50-4761-9f89-277492dc00e0FFFFFF00"
		    PrimaryColor = &cFFFFFF00
		  End If
		  AccentColor = BackgroundColor
		  
		  Select Case PrimaryColor
		  Case &cFFF02A00
		    PrimaryColor = SystemColors.SystemYellowColor
		  Case &cE6BAFF00
		    PrimaryColor = SystemColors.SystemPurpleColor
		  Case &c00FF0000
		    PrimaryColor = SystemColors.SystemGreenColor
		  Case &cFFBABA00
		    PrimaryColor = SystemColors.SystemRedColor
		  Case &c88C8FF00
		    PrimaryColor = SystemColors.SystemBlueColor
		  End Select
		  
		  IconID = IconID + PrimaryColor.ToHex + BackgroundColor.ToHex
		  If Self.IconCache = Nil Then
		    Self.IconCache = New Dictionary
		  End If
		  If IconCache.HasKey(IconID) Then
		    Return IconCache.Value(IconID)
		  End If
		  
		  PrimaryColor = BeaconUI.FindContrastingColor(BackgroundColor, PrimaryColor)
		  
		  Dim Height As Integer = (SpriteSheet.Height / 2) / 3
		  Dim Width As Integer = (SpriteSheet.Width / 2) / 3
		  
		  If BadgeSheet <> Nil Then
		    Dim BadgesMask As New Picture(BadgeSheet.Width, BadgeSheet.Height)
		    BadgesMask.Graphics.DrawingColor = &cFFFFFF
		    BadgesMask.Graphics.FillRectangle(0, 0, BadgesMask.Width, BadgesMask.Height)
		    BadgesMask.Graphics.DrawPicture(BadgeSheet, 0, 0)
		    
		    Dim Badges As Picture = New Picture(BadgeSheet.Width, BadgeSheet.Height)
		    Badges.Graphics.DrawingColor = &cFFFFFF
		    Badges.Graphics.FillRectangle(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Badges.ApplyMask(BadgesMask)
		    
		    Dim Sprites As Picture = New Picture(SpriteSheet.Width, SpriteSheet.Height, 32)
		    Sprites.Graphics.DrawPicture(SpriteSheet, 0, 0)
		    Sprites.Graphics.DrawPicture(Badges.Piece(0, 0, Width, Height), 0, Height)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width, 0, Width * 2, Height * 2), Width, Height * 2)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width * 3, 0, Width * 3, Height * 3), Width * 3, Height * 3)
		    Badges.Graphics.DrawingColor = &c000000
		    Badges.Graphics.FillRectangle(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Sprites.Graphics.DrawPicture(Badges, 0, 0)
		    
		    SpriteSheet = Sprites
		  End If
		  
		  Dim Highlight1x As Picture = SpriteSheet.Piece(0, 0, Width, Height)
		  Dim Highlight2x As Picture = SpriteSheet.Piece(Width, 0, Width * 2, Height * 2)
		  Dim Highlight3x As Picture = SpriteSheet.Piece(Width * 3, 0, Width * 3, Height * 3)
		  Dim HighlightMask As New Picture(Width, Height, Array(Highlight1x, Highlight2x, Highlight3x))
		  
		  Dim Color1x As Picture = SpriteSheet.Piece(0, Height, Width, Height)
		  Dim Color2x As Picture = SpriteSheet.Piece(Width, Height * 2, Width * 2, Height * 2)
		  Dim Color3x As Picture = SpriteSheet.Piece(Width * 3, Height * 3, Width * 3, Height * 3)
		  Dim ColorMask As New Picture(Width, Height, Array(Color1x, Color2x, Color3x))
		  
		  Dim Highlight As Picture = HighlightMask.WithColor(PrimaryColor)
		  Dim Fill As Picture = ColorMask.WithColor(AccentColor)
		  
		  Dim Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Dim HighlightRep As Picture = Highlight.BestRepresentation(Width, Height, Factor)
		    Dim ColorRep As Picture = Fill.BestRepresentation(Width, Height, Factor)
		    
		    Dim Combined As New Picture(Width * Factor, Width * Factor)
		    Combined.VerticalResolution = 72 * Factor
		    Combined.HorizontalResolution = 72 * Factor
		    Combined.Graphics.DrawPicture(HighlightRep, 0, 0, Combined.Width, Combined.Height, 0, 0, HighlightRep.Width, HighlightRep.Height)
		    Combined.Graphics.DrawPicture(ColorRep, 0, 0, Combined.Width, Combined.Height, 0, 0, ColorRep.Width, ColorRep.Height)
		    
		    Bitmaps.AddRow(Combined)
		  Next
		  
		  Dim Icon As New Picture(Width, Height, Bitmaps)
		  Self.IconCache.Value(IconID) = Icon
		  Return Icon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String)
		  Self.mPendingImports.AddRow(Content)
		  
		  If Self.mImportThread = Nil Then
		    Self.mImportThread = New Thread
		    AddHandler Self.mImportThread.Run, WeakAddressOf Self.mImportThread_Run
		  End If
		  
		  If Self.mImportThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.mImportThread.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportCloudEngrams() As Boolean
		  Dim EngramsUpdated As Boolean = False
		  Dim EngramsContent As MemoryBlock = UserCloud.Read("/Engrams.json")
		  If EngramsContent = Nil Then
		    Return False
		  End If
		  Dim Blueprints() As Variant
		  Try
		    Dim StringContent As String = EngramsContent
		    Blueprints = Beacon.ParseJSON(StringContent.DefineEncoding(Encodings.UTF8))
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  Self.BeginTransaction()
		  Self.DeleteDataForMod(Self.UserModID)
		  For Each Dict As Dictionary In Blueprints
		    Try
		      Dim Category As String = Dict.Value("category")
		      Dim Path As String = Dict.Value("path") 
		      Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM " + Category + " WHERE LOWER(path) = ?1;", Path.Lowercase)
		      If Results.RowCount <> 0 Then
		        Continue
		      End If
		      
		      Dim ObjectID As v4UUID = Dict.Value("object_id").StringValue
		      Dim ClassString As String = Dict.Value("class_string")
		      Dim Label As String = Dict.Value("label")         
		      Dim Availability As UInt64 = Dict.Value("availability")
		      Dim Tags As String = Dict.Value("tags")
		      Self.SQLExecute("INSERT INTO " + Category + " (object_id, class_string, label, path, availability, tags, mod_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);",  ObjectID.StringValue, ClassString, Label, Path, Availability, Tags, Self.UserModID)      
		      Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, ?3);", ObjectID.StringValue, Tags, Category)
		      EngramsUpdated = True
		    Catch Err As RuntimeException
		    End Try
		  Next
		  Self.Commit()
		  Return EngramsUpdated
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCloudFiles()
		  // Import blueprints from disk into the database
		  If Self.ImportCloudEngrams Then
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  
		  // Import presets from disk into the database
		  Self.BeginTransaction()
		  Var PresetPaths() As String = UserCloud.List("/Presets/")
		  For Each RemotePath As String In PresetPaths
		    Dim PresetContents As MemoryBlock = UserCloud.Read(RemotePath)
		    If PresetContents <> Nil Then
		      Call Self.ImportPreset(PresetContents)
		    End If
		  Next
		  Self.Commit()
		  
		  // This reloads presets from the database
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCloudFiles(Actions() As Dictionary)
		  Dim EngramsUpdated, PresetsUpdated As Boolean
		  For Each Action As Dictionary In Actions
		    Dim RemotePath As String = Action.Value("Path")
		    If RemotePath = "/Engrams.json" Then
		      Select Case Action.Value("Action")
		      Case "DELETE"
		        Self.DeleteDataForMod(Self.UserModID)
		        EngramsUpdated = True
		      Case "GET"
		        EngramsUpdated = Self.ImportCloudEngrams() Or EngramsUpdated
		      End Select
		    ElseIf RemotePath.BeginsWith("/Presets") Then
		      Dim PresetID As String = RemotePath.Middle(8, 36)
		      Select Case Action.Value("Action")
		      Case "DELETE"
		        Self.BeginTransaction()
		        Self.SQLExecute("DELETE FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, PresetID.Lowercase)
		        Self.Commit()
		        PresetsUpdated = True
		      Case "GET"
		        Dim PresetContents As MemoryBlock = UserCloud.Read(RemotePath)
		        If PresetContents = Nil Then
		          Continue
		        End If
		        PresetsUpdated = Self.ImportPreset(PresetContents) Or PresetsUpdated
		      End Select
		    End If
		  Next
		  
		  If EngramsUpdated Then      
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  If PresetsUpdated Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportInner(Content As String) As Boolean
		  Dim ChangeDict As Dictionary
		  Try
		    ChangeDict = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.Log("Cannot import classes because the data is not valid JSON.")
		    Return False
		  End Try
		  
		  Dim RequiredKeys() As String = Array("mods", "loot_source_icons", "loot_sources", "engrams", "presets", "preset_modifiers", "timestamp", "is_full", "beacon_version")
		  For Each RequiredKey As String In RequiredKeys
		    If Not ChangeDict.HasKey(RequiredKey) Then
		      App.Log("Cannot import classes because key '" + RequiredKey + "' is missing.")
		      Return False
		    End If
		  Next
		  
		  Dim FileVersion As Integer = ChangeDict.Value("beacon_version")
		  If FileVersion <> 4 Then
		    App.Log("Cannot import classes because file format is not correct for this version. Get correct classes from " + Self.ClassesURL(True))
		    Return False
		  End If
		  
		  Var ShouldTruncate As Boolean = ChangeDict.Value("is_full") = 1
		  Dim PayloadTimestamp As DateTime = NewDateFromSQLDateTime(ChangeDict.Value("timestamp"))
		  Dim LastSync As DateTime = Self.LastSync
		  If ShouldTruncate = False And IsNull(LastSync) = False And LastSync.SecondsFrom1970 >= PayloadTimestamp.SecondsFrom1970 Then
		    Return False
		  End If
		  
		  Try
		    Self.BeginTransaction()
		    
		    Dim EngramsChanged As Boolean
		    
		    // Drop indexes
		    Dim Categories() As String = Beacon.Categories
		    For Each Category As String In Categories
		      Self.SQLExecute("DROP INDEX IF EXISTS " + Category +"_class_string_idx;")
		      Self.SQLExecute("DROP INDEX IF EXISTS " + Category + "_path_idx;")
		    Next
		    Self.SQLExecute("DROP INDEX IF EXISTS loot_sources_sort_order_idx;")
		    Self.SQLExecute("DROP INDEX IF EXISTS loot_sources_path_idx;")
		    
		    If ShouldTruncate Then
		      Self.SQLExecute("DELETE FROM loot_sources WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM blueprints WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM official_presets;")
		      Self.SQLExecute("DELETE FROM mods WHERE mod_id != ?1;", Self.UserModID) // Mods must be deleted last
		    End If
		    
		    // Caution!! This field always contains all mods.
		    Dim Mods() As Variant = ChangeDict.Value("mods")
		    Dim RetainMods() As String
		    RetainMods.AddRow(Self.UserModID)
		    For Each ModData As Dictionary In Mods
		      Dim ModID As String = ModData.Value("mod_id")
		      Dim ModName As String = ModData.Value("name")
		      Dim ConsoleSafe As Boolean = ModData.Value("console_safe")
		      
		      ModID = ModID.Lowercase
		      
		      Dim Results As RowSet = Self.SQLSelect("SELECT name, console_safe FROM mods WHERE mod_id = ?1;", ModID)
		      If Results.RowCount = 1 Then
		        If ModName.Compare(Results.Column("name").StringValue, ComparisonOptions.CaseSensitive) <> 0 Or ConsoleSafe <> Results.Column("console_safe").BooleanValue Then
		          Self.SQLExecute("UPDATE mods SET name = ?2, console_safe = ?3 WHERE mod_id = ?1;", ModID, ModName, ConsoleSafe)
		        End If
		      Else
		        Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe) VALUES (?1, ?2, ?3);", ModID, ModName, ConsoleSafe)
		      End If
		      
		      RetainMods.AddRow(ModID)
		    Next
		    Dim ModResults As RowSet = Self.SQLSelect("SELECT mod_id FROM mods;")
		    While Not ModResults.AfterLastRow
		      Dim ModID As String = ModResults.Column("mod_id").StringValue.Lowercase
		      If RetainMods.IndexOf(ModID) = -1 Then
		        Self.DeleteDataForMod(ModID)
		        Self.SQLExecute("DELETE FROM mods WHERE mod_id = ?1;", ModID)
		      End If
		      ModResults.MoveToNextRow
		    Wend
		    
		    // When deleting, loot_source_icons must be done after loot_sources
		    Dim Deletions() As Variant = ChangeDict.Value("deletions")
		    Dim DeleteIcons() As v4UUID
		    For Each Deletion As Dictionary In Deletions
		      Dim ObjectID As v4UUID = Deletion.Value("object_id").StringValue
		      Select Case Deletion.Value("group")
		      Case "loot_sources"
		        Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", ObjectID.StringValue)
		      Case "loot_source_icons"
		        DeleteIcons.AddRow(ObjectID)
		      Case Beacon.CategoryEngrams, Beacon.CategoryCreatures, Beacon.CategorySpawnPoints
		        Self.SQLExecute("DELETE FROM blueprints WHERE object_id = ?1;", ObjectID.StringValue)
		      Case "presets"
		        Self.SQLExecute("DELETE FROM official_presets WHERE object_id = ?1;", ObjectID.StringValue)
		      End Select
		    Next
		    For Each IconID As v4UUID In DeleteIcons
		      Self.SQLExecute("DELETE FROM loot_source_icons WHERE icon_id = ?1;", IconID.StringValue)
		    Next
		    
		    Dim LootSourceIcons() As Variant = ChangeDict.Value("loot_source_icons")
		    For Each Dict As Dictionary In LootSourceIcons
		      Dim IconID As String = Dict.Value("id")
		      Dim IconData As MemoryBlock = DecodeBase64(Dict.Value("icon_data"))
		      
		      IconID = IconID.Lowercase
		      
		      Dim Results As RowSet = Self.SQLSelect("SELECT icon_id FROM loot_source_icons WHERE icon_id = ?1;", IconID)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE loot_source_icons SET icon_data = ?2 WHERE icon_id = ?1;", IconID, IconData)
		      Else
		        Self.SQLExecute("INSERT INTO loot_source_icons (icon_id, icon_data) VALUES (?1, ?2);", IconID, IconData)
		      End If
		    Next
		    If LootSourceIcons.LastRowIndex > -1 Then
		      Self.IconCache = Nil
		    End If
		    
		    Dim LootSources() As Variant = ChangeDict.Value("loot_sources")
		    For Each Dict As Dictionary In LootSources
		      Dim ObjectID As v4UUID = Dict.Value("id").StringValue
		      Dim Label As String = Dict.Value("label")
		      Dim ModID As v4UUID = Dictionary(Dict.Value("mod")).Value("id").StringValue
		      Dim Availability As Integer = Dict.Value("availability")
		      Dim Path As String = Dict.Value("path")
		      Dim ClassString As String = Dict.Value("class_string")
		      Dim MultiplierMin As Double = Dictionary(Dict.Value("multipliers")).Value("min")
		      Dim MultiplierMax As Double = Dictionary(Dict.Value("multipliers")).Value("max")
		      Dim UIColor As String = Dict.Value("ui_color")
		      Dim SortOrder As Integer = If(Dict.HasKey("sort"), Dict.Value("sort").IntegerValue, Dict.Value("sort_order").IntegerValue)
		      Dim Experimental As Boolean = Dict.Value("experimental")
		      Dim Notes As String = Dict.Value("notes")
		      Dim IconID As v4UUID = Dict.Value("icon").StringValue
		      Dim Requirements As String = Dict.Lookup("requirements", "{}")
		      
		      Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM loot_sources WHERE object_id = ?1 OR LOWER(path) = ?2;", ObjectID.StringValue, Path.Lowercase)
		      If Results.RowCount = 1 And ObjectID = Results.Column("object_id").StringValue Then
		        Self.SQLExecute("UPDATE loot_sources SET mod_id = ?2, label = ?3, availability = ?4, path = ?5, class_string = ?6, multiplier_min = ?7, multiplier_max = ?8, uicolor = ?9, sort_order = ?10, icon = ?11, experimental = ?12, notes = ?13, requirements = ?14 WHERE object_id = ?1;", ObjectID.StringValue, ModID.StringValue, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID.StringValue, Experimental, Notes, Requirements)
		      Else
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", Results.Column("object_id").StringValue)
		        End If
		        Self.SQLExecute("INSERT INTO loot_sources (object_id, mod_id, label, availability, path, class_string, multiplier_min, multiplier_max, uicolor, sort_order, icon, experimental, notes, requirements) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14);", ObjectID.StringValue, ModID.StringValue, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID.StringValue, Experimental, Notes, Requirements)
		      End If
		      EngramsChanged = True
		    Next
		    
		    If ChangeDict.HasKey("engrams") Then
		      Dim Engrams() As Variant = ChangeDict.Value("engrams")
		      For Each Dict As Dictionary In Engrams
		        Dim Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategoryEngrams, Dict)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    If ChangeDict.HasKey("creatures") Then
		      Dim Creatures() As Variant = ChangeDict.Value("creatures")
		      For Each Dict As Dictionary In Creatures
		        Dim ExtraColumns As New Dictionary
		        ExtraColumns.Value("incubation_time") = Dict.Value("incubation_time")
		        ExtraColumns.Value("mature_time") = Dict.Value("mature_time")
		        If IsNull(Dict.Value("stats")) = False Then
		          ExtraColumns.Value("stats") = Beacon.GenerateJSON(Dict.Value("stats"), False)
		        End If
		        
		        Dim Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategoryCreatures, Dict, ExtraColumns)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    If ChangeDict.HasKey("spawn_points") Then
		      Dim SpawnPoints() As Variant = ChangeDict.Value("spawn_points")
		      For Each Dict As Dictionary In SpawnPoints
		        Dim ExtraColumns As New Dictionary
		        If IsNull(Dict.Value("groups")) = False Then
		          ExtraColumns.Value("groups") = Beacon.GenerateJSON(Dict.Value("groups"), False)
		        End If
		        If IsNull(Dict.Value("limits")) = False Then
		          ExtraColumns.Value("limits") = Beacon.GenerateJSON(Dict.Value("limits"), False)
		        End If
		        
		        Dim Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategorySpawnPoints, Dict, ExtraColumns)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    Dim ReloadPresets As Boolean
		    Dim Presets() As Variant = ChangeDict.Value("presets")
		    For Each Dict As Dictionary In Presets
		      Dim ObjectID As v4UUID = Dict.Value("id").StringValue
		      Dim Label As String = Dict.Value("label")
		      Dim Contents As String = Dict.Value("contents")
		      
		      ReloadPresets = True
		      Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM official_presets WHERE object_id = ?1;", ObjectID.StringValue)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE official_presets SET label = ?2, contents = ?3 WHERE object_id = ?1;", ObjectID.StringValue, Label, Contents)
		      Else
		        Self.SQLExecute("INSERT INTO official_presets (object_id, label, contents) VALUES (?1, ?2, ?3);", ObjectID.StringValue, Label, Contents)
		      End If
		    Next
		    
		    Dim PresetModifiers() As Variant = ChangeDict.Value("preset_modifiers")
		    For Each Dict As Dictionary In PresetModifiers
		      Dim ObjectID As v4UUID = Dict.Value("id").StringValue
		      Dim Label As String = Dict.Value("label")
		      Dim Pattern As String = Dict.Value("pattern")
		      Dim ModID As v4UUID = Dictionary(Dict.Value("mod")).Value("id").StringValue
		      
		      ReloadPresets = True
		      Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM preset_modifiers WHERE object_id = ?1;", ObjectID.StringValue)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3, mod_id = ?4 WHERE object_id = ?1;", ObjectID.StringValue, Label, Pattern, ModID.StringValue)
		      Else
		        Self.SQLExecute("INSERT INTO preset_modifiers (object_id, label, pattern, mod_id) VALUES (?1, ?2, ?3, ?4);", ObjectID.StringValue, Label, Pattern, ModID.StringValue)
		      End If
		    Next
		    
		    If ChangeDict.HasKey("help_topics") Then
		      Dim HelpTopics() As Variant = ChangeDict.Value("help_topics")
		      For Each Dict As Dictionary In HelpTopics
		        Dim ConfigName As String = Dict.Value("topic")
		        Dim Title As String = Dict.Value("title")
		        Dim Body As String = Dict.Value("body")
		        Dim DetailURL As String
		        If Dict.Value("detail_url") <> Nil Then
		          DetailURL = Dict.Value("detail_url")
		        End If
		        
		        ConfigName = ConfigName.Lowercase
		        
		        Dim Results As RowSet = Self.SQLSelect("SELECT config_name FROM config_help WHERE config_name = ?1;", ConfigName)
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("UPDATE config_help SET title = ?2, body = ?3, detail_url = ?4 WHERE config_name = ?1;", ConfigName, Title, Body, DetailURL)
		        Else
		          Self.SQLExecute("INSERT INTO config_help (config_name, title, body, detail_url) VALUES (?1, ?2, ?3, ?4);", ConfigName, Title, Body, DetailURL)
		        End If
		      Next
		    End If
		    
		    If ChangeDict.HasKey("game_variables") Then
		      Dim HelpTopics() As Variant = ChangeDict.Value("game_variables")
		      For Each Dict As Dictionary In HelpTopics
		        Dim Key As String = Dict.Value("key")
		        Dim Value As String = Dict.Value("value")
		        
		        Dim Results As RowSet = Self.SQLSelect("SELECT key FROM game_variables WHERE key = ?1;", Key)
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("UPDATE game_variables SET value = ?2 WHERE key = ?1;", Key, Value)
		        Else
		          Self.SQLExecute("INSERT INTO game_variables (key, value) VALUES (?1, ?2);", Key, Value)
		        End If
		      Next
		    End If
		    
		    // Restore Indexes
		    For Each Category As String In Categories
		      Self.SQLExecute("CREATE INDEX " + Category + "_class_string_idx ON " + Category + "(class_string);")
		      Self.SQLExecute("CREATE UNIQUE INDEX " + Category + "_path_idx ON " + Category + "(path);")
		    Next
		    Self.SQLExecute("CREATE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		    Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		    
		    Self.Variable("sync_time") = PayloadTimestamp.SQLDateTimeWithOffset
		    Self.Commit()
		    
		    If ReloadPresets Then
		      Self.LoadPresets()
		    End If
		    
		    App.Log("Imported classes. Engrams date is " + PayloadTimestamp.SQLDateTimeWithOffset)
		    
		    If EngramsChanged Then
		      NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		    End If
		    
		    Return True
		  Catch Err As RuntimeException
		    Self.Rollback()
		    Return False
		  End Try
		  
		  Exception Err As RuntimeException
		    App.Log("Unhabdled exception in LocalData.Import: " + Err.Message)
		    Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportLocalClasses()
		  Dim File As FolderItem = App.ResourcesFolder.Child("Classes.json")
		  If File.Exists Then
		    Dim Content As MemoryBlock = File.Read(Encodings.UTF8)
		    If Content <> Nil Then
		      Self.Import(Content)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportPreset(PresetContents As MemoryBlock) As Boolean
		  Dim Contents As String = DefineEncoding(PresetContents, Encodings.UTF8)
		  Dim Preset As Beacon.Preset
		  Dim PresetID As String
		  Try
		    Dim Dict As Dictionary = Beacon.ParseJSON(Contents)
		    Preset = Beacon.Preset.FromDictionary(Dict)
		    PresetID = Preset.PresetID
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Dim Imported As Boolean
		  Self.BeginTransaction()
		  Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, PresetID)
		  If Results.RowCount = 1 Then
		    Try
		      Var RowsToChange As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2 AND label != ?3 AND contents != ?4;", Self.UserID, PresetID, Preset.Label, Contents)
		      If RowsToChange.RowCount > 0 Then
		        Self.SQLExecute("UPDATE custom_presets SET label = ?3, contents = ?4 WHERE user_id = ?1 AND object_id = ?2 AND label != ?3 AND contents != ?4;", Self.UserID, PresetID, Preset.Label, Contents)
		        Imported = True
		      End If
		    Catch Err As RuntimeException
		      Imported = False
		    End Try
		  Else
		    Self.SQLExecute("INSERT INTO custom_presets (user_id, object_id, label, contents) VALUES (?1, ?2, ?3, ?4);", Self.UserID, PresetID, Preset.Label, Contents)
		    Imported = True
		  End If
		  Self.Commit()
		  Return Imported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim Results As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Preset.PresetID)
		  Return Results.RowCount = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastCommitTime() As Double
		  Return Self.mLastCommitTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastEditTime() As Double
		  Return Self.mLastCommitTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As DateTime
		  Dim LastSync As String = Self.Variable("sync_time")
		  If LastSync = "" Then
		    Return Nil
		  End If
		  
		  Return NewDateFromSQLDateTime(LastSync)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Redim Self.mPresets(-1)
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id = ?1;", Self.UserModID) // Loading the presets will refill all the needed custom modifiers
		  Self.SQLExecute("DELETE FROM custom_presets WHERE LOWER(object_id) != object_id AND LOWER(object_id) IN (SELECT object_id FROM custom_presets);") // To clean up object_id values that are not lowercase
		  Self.SQLExecute("UPDATE custom_presets SET object_id = LOWER(object_id) WHERE LOWER(object_id) != object_id;")
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM official_presets WHERE object_id NOT IN (SELECT object_id FROM custom_presets WHERE user_id = ?1)", Self.UserID), Beacon.Preset.Types.BuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE user_id = ?1 AND object_id IN (SELECT object_id FROM official_presets)", Self.UserID), Beacon.Preset.Types.CustomizedBuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE user_id = ?1 AND object_id NOT IN (SELECT object_id FROM official_presets)", Self.UserID), Beacon.Preset.Types.Custom)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadPresets(Results As RowSet, Type As Beacon.Preset.Types)
		  While Not Results.AfterLastRow
		    Dim Dict As Dictionary = Beacon.ParseJSON(Results.Column("contents").StringValue)
		    Dim Preset As Beacon.Preset = Beacon.Preset.FromDictionary(Dict)
		    If Preset <> Nil Then
		      If Type <> Beacon.Preset.Types.BuiltIn And Preset.PresetID <> Results.Column("object_id").StringValue Then
		        // To work around https://github.com/thommcgrath/Beacon/issues/64
		        Dim Contents As String = Beacon.GenerateJSON(Preset.ToDictionary, False)
		        Self.BeginTransaction()
		        Self.SQLExecute("UPDATE custom_presets SET object_id = ?3, contents = ?4 WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Results.Column("object_id").StringValue, Preset.PresetID, Contents)
		        Self.Commit()
		      End If
		      
		      Preset.Type = Type
		      Self.mPresets.AddRow(Preset)
		    End If
		    Results.MoveToNextRow
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSourceLabels(Availability As UInt64) As Dictionary
		  If Self.mDropsLabelCacheMask <> Availability Then
		    Var Drops() As Beacon.LootSource = Self.SearchForLootSources("", New Beacon.StringList, True)
		    Var Labels() As String
		    Var Dict As New Dictionary
		    Labels.ResizeTo(Drops.LastRowIndex)
		    
		    For I As Integer = 0 To Drops.LastRowIndex
		      If Drops(I).ValidForMask(Availability) = False Then
		        Continue
		      End If
		      
		      Var Label As String = Drops(I).Label
		      Var Idx As Integer = Labels.IndexOf(Label)
		      Labels(I) = Label
		      If Idx > -1 Then
		        Var Filtered As UInt64 = Drops(Idx).Availability And Availability
		        Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Filtered)
		        Dict.Value(Drops(Idx).Path) = Drops(Idx).Label + " (" + Maps.Label + ")"
		        
		        Filtered = Drops(I).Availability And Availability
		        Maps = Beacon.Maps.ForMask(Filtered)
		        Label = Label + " (" + Maps.Label + ")"
		      End If
		      
		      Dict.Value(Drops(I).Path) = Label
		    Next
		    
		    Self.mDropsLabelCacheDict = Dict
		    Self.mDropsLabelCacheMask = Availability
		  End If
		  
		  Return Self.mDropsLabelCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MigrateData(Source As FolderItem, FromSchemaVersion As Integer) As Boolean
		  If Not Self.mBase.AttachDatabase(Source, "legacy") Then
		    App.Log("Unable to attach database " + Source.NativePath)
		    Return False
		  End If
		  
		  App.Log("Migrating data from schema " + Str(FromSchemaVersion, "-0") + " at " + Source.NativePath)
		  
		  Dim MigrateLegacyCustomEngrams As Boolean = FromSchemaVersion <= 5
		  Dim Commands() As String
		  
		  // Mods
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO mods SELECT * FROM legacy.mods WHERE mod_id != '" + Self.UserModID + "';")
		  End If
		  
		  // Loot Sources
		  If FromSchemaVersion >= 8 Then  
		    Commands.AddRow("INSERT INTO loot_source_icons SELECT * FROM legacy.loot_source_icons;")
		    Commands.AddRow("INSERT INTO loot_sources SELECT * FROM legacy.loot_sources;")
		  End If
		  
		  // Engrams
		  If FromSchemaVersion >= 9 Then
		    Commands.AddRow("INSERT INTO engrams SELECT * FROM legacy.engrams;")
		  ElseIf FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO engrams (object_id, mod_id, label, availability, path, class_string, tags) SELECT object_id, mod_id, label, availability, path, class_string, '' AS tags FROM legacy.engrams WHERE mod_id = '" + Self.UserModID + "' AND can_blueprint = 0;")
		    Commands.AddRow("INSERT INTO engrams (object_id, mod_id, label, availability, path, class_string, tags) SELECT object_id, mod_id, label, availability, path, class_string, 'blueprintable' AS tags FROM legacy.engrams WHERE mod_id = '" + Self.UserModID + "' AND can_blueprint = 1;")
		    Commands.AddRow("INSERT INTO searchable_tags (object_id, source_table, tags) SELECT object_id, 'engrams' AS source_table, CASE tags WHEN '' THEN 'object' ELSE 'object,' || tags END tags FROM engrams WHERE mod_id = '" + Self.UserModID + "';")
		  End If
		  
		  // Variables
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO variables SELECT * FROM legacy.variables WHERE LOWER(legacy.variables.key) != 'sync_time';")
		  End If
		  
		  // Official Presets
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO official_presets SELECT * FROM legacy.official_presets;")
		  End If
		  
		  // Notifications
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO notifications SELECT * FROM legacy.notifications;")
		  End If
		  
		  // Config Help
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO config_help (config_name, title, body, detail_url) SELECT LOWER(config_name), title, body, detail_url FROM legacy.config_help;")
		  End If
		  
		  // Preset Modifiers
		  If FromSchemaVersion >= 6 Then
		    Commands.AddRow("INSERT INTO preset_modifiers SELECT * FROM legacy.preset_modifiers")
		  End If
		  
		  // Game Variables
		  If FromSchemaVersion >= 7 Then
		    Commands.AddRow("INSERT INTO game_variables SELECT * FROM legacy.game_variables;")
		  End If
		  
		  // Custom Presets
		  If FromSchemaVersion >= 13 Then
		    Commands.AddRow("INSERT INTO custom_presets SELECT * FROM legacy.custom_presets;")
		  ElseIf FromSchemaVersion >= 3 Then
		    Commands.AddRow("INSERT INTO custom_presets (user_id, object_id, label, contents) SELECT '" + Self.UserID + "' AS user_id, LOWER(object_id), label, contents FROM legacy.custom_presets;")
		  End If
		  
		  // Creatures
		  If FromSchemaVersion >= 10 Then
		    Commands.AddRow("INSERT INTO creatures SELECT * FROM legacy.creatures;")
		  ElseIf FromSchemaVersion >= 9 Then
		    Commands.AddRow("INSERT INTO creatures (object_id, mod_id, label, availability, path, class_string, tags, incubation_time, mature_time) SELECT object_id, mod_id, label, availability, path, class_string, tags, incubation_time, mature_time FROM legacy.creatures;")
		  End If
		  
		  // Spawn Points
		  If FromSchemaVersion >= 12 Then
		    Commands.AddRow("INSERT INTO spawn_points SELECT * FROM legacy.spawn_points;")
		  End If
		  
		  // Searchable Tags
		  If FromSchemaVersion >= 9 Then
		    Commands.AddRow("INSERT INTO searchable_tags SELECT DISTINCT * FROM legacy.searchable_tags;")
		  End If
		  
		  // Sanity checking
		  Commands.AddRow("DELETE FROM loot_sources WHERE mod_id NOT IN (SELECT mod_id FROM mods);")
		  Commands.AddRow("DELETE FROM blueprints WHERE mod_id NOT IN (SELECT mod_id FROM mods);")
		  Commands.AddRow("DELETE FROM preset_modifiers WHERE mod_id NOT IN (SELECT mod_id FROM mods);")
		  
		  If Commands.LastRowIndex > -1 Then
		    Self.BeginTransaction()
		    Try
		      For Each Command As String In Commands
		        Self.SQLExecute(Command)
		      Next
		    Catch Err As UnsupportedOperationException
		      Self.Rollback()
		      Self.mBase.RemoveDatabase("legacy")
		      App.Log("Unable to migrate data: " + Err.Message)
		      Return False
		    End Try
		    
		    If MigrateLegacyCustomEngrams Then
		      Dim Results As RowSet = Self.SQLSelect("SELECT path, class_string, label, availability, can_blueprint FROM legacy.engrams WHERE built_in = 0;")
		      While Not Results.AfterLastRow
		        Try
		          Dim ObjectID As New v4UUID
		          Dim Tags As String = If(Results.Column("can_blueprint").BooleanValue, "object,blueprintable", "object")
		          Self.SQLExecute("INSERT INTO engrams (object_id, mod_id, path, class_string, label, availability, tags) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);", ObjectID.StringValue, Self.UserModID, Results.Column("path").StringValue, Results.Column("class_string").StringValue, Results.Column("label").StringValue, Results.Column("availability").IntegerValue, Tags)
		          Self.SQLExecute("INSERT INTO searchable_tags (object_id, source_table, tags) VALUES (?1, ?2, ?3);", ObjectID.StringValue, "engrams", Tags)
		        Catch Err As UnsupportedOperationException
		          Self.Rollback()
		          Self.mBase.RemoveDatabase("legacy")
		          App.Log("Unable to migrate data: " + Err.Message)
		          Return False
		        End Try
		        
		        Results.MoveToNextRow
		      Wend
		    End If
		    
		    Self.Commit()
		  End If
		  
		  Self.mBase.RemoveDatabase("legacy")
		  
		  If FromSchemaVersion <= 2 Then
		    Dim SupportFolder As FolderItem = App.ApplicationSupport
		    Dim PresetsFolder As FolderItem = SupportFolder.Child("Presets")
		    If PresetsFolder.Exists Then
		      For I As Integer = PresetsFolder.Count - 1 DownTo 0
		        Dim File As FolderItem = PresetsFolder.ChildAt(I)
		        If Not File.IsType(BeaconFileTypes.BeaconPreset) Then
		          File.Remove
		          Continue
		        End If
		        
		        Dim Content As String = File.Read(Encodings.UTF8)
		        
		        Try
		          Dim Dict As Dictionary = Beacon.ParseJSON(Content)
		          Dim PresetID As String = Dict.Value("ID")
		          Dim Label As String = Dict.Value("Label")
		          
		          Self.BeginTransaction()
		          Self.SQLExecute("INSERT OR REPLACE INTO custom_presets (user_id, object_id, label, contents) VALUES (?1, ?2, ?3, ?4);", Self.UserID, PresetID.Lowercase, Label, Content)
		          Self.Commit()
		          
		          File.Remove
		        Catch Err As RuntimeException
		          While Self.mTransactions.LastRowIndex > -1
		            Self.Rollback()
		          Wend
		          Continue
		        End Try
		      Next
		      
		      PresetsFolder.Remove
		    End If
		  End If
		  
		  If FromSchemaVersion < 9 Then
		    Dim Extension As String = BeaconFileTypes.BeaconPreset.PrimaryExtension
		    Dim Results As RowSet = Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE user_id = ?1;", Self.UserID)
		    While Not Results.AfterLastRow
		      Call UserCloud.Write("/Presets/" + Results.Column("object_id").StringValue.Lowercase + Extension, Results.Column("contents").StringValue)
		      Results.MoveToNextRow
		    Wend
		    
		    Self.SyncUserEngrams()
		  End If
		  
		  App.Log("Migration complete")
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If Self.mPendingImports.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim SyncOriginal As DateTime = Self.LastSync
		  Dim Success As Boolean
		  For I As Integer = 0 To Self.mPendingImports.LastRowIndex
		    Dim Content As String = Self.mPendingImports(I)
		    Self.mPendingImports.RemoveRowAt(I)
		    
		    Success = Self.ImportInner(Content) Or Success
		  Next
		  Dim SyncNew As DateTime = Self.LastSync
		  
		  If SyncOriginal <> SyncNew Then
		    NotificationKit.Post(Self.Notification_DatabaseUpdated, SyncNew)
		  End If
		  
		  If Success Then
		    NotificationKit.Post(Self.Notification_ImportSuccess, SyncNew)
		  Else
		    NotificationKit.Post(Self.Notification_ImportFailed, SyncNew)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    App.Log("Engram update returned HTTP " + Str(HTTPStatus, "-0"))
		    NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		    Return
		  End If
		  
		  Dim ExpectedHash As String = Sender.ResponseHeader("Content-MD5")
		  Dim ComputedHash As String = EncodeHex(Crypto.MD5(Content))
		  
		  If ComputedHash <> ExpectedHash Then
		    App.Log("Engram update hash mismatch. Expected " + ExpectedHash + ", computed " + ComputedHash + ".")
		    NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		    Return
		  End If
		  
		  Self.Import(Content)
		  
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_Error(Sender As URLConnection, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log("Engram check error: " + Error.Reason)
		  NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		  
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case UserCloud.Notification_SyncFinished
		    If Self.mNextSyncImportAll Then
		      Self.mNextSyncImportAll = False
		      Self.ImportCloudFiles()
		    Else
		      Dim Actions() As Dictionary = Notification.UserData
		      Self.ImportCloudFiles(Actions)
		    End If
		  Case IdentityManager.Notification_IdentityChanged
		    Self.mNextSyncImportAll = True
		    Self.SyncUserEngrams()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.AddRow(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResolvePathFromClassString(ClassString As String) As String
		  Var Results As RowSet = Self.SQLSelect("SELECT path FROM blueprints WHERE class_string = ?1;", ClassString)
		  If Results.RowCount = 0 Then
		    Return ""
		  End If
		  
		  Return Results.Column("path").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Rollback()
		  If Self.mTransactions.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveRowAt(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("ROLLBACK TRANSACTION;")
		  Else
		    Self.SQLExecute("ROLLBACK TRANSACTION TO SAVEPOINT " + Savepoint + ";")
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToCreature(Results As RowSet) As Beacon.Creature()
		  Dim Creatures() As Beacon.Creature
		  While Not Results.AfterLastRow
		    Dim Creature As New Beacon.MutableCreature(Results.Column("path").StringValue, Results.Column("object_id").StringValue)
		    Creature.Label = Results.Column("label").StringValue
		    Creature.Availability = Results.Column("availability").IntegerValue
		    Creature.TagString = Results.Column("tags").StringValue
		    Creature.ModID = Results.Column("mod_id").StringValue
		    Creature.ModName = Results.Column("mod_name").StringValue
		    If Results.Column("stats").Value <> Nil Then
		      Creature.ConsumeStats(Results.Column("stats").StringValue)
		    End If
		    
		    If Results.Column("incubation_time").Value <> Nil Then
		      Creature.IncubationTime = Results.Column("incubation_time").Value.UInt64Value
		    End If
		    If Results.Column("mature_time").Value <> Nil Then
		      Creature.MatureTime = Results.Column("mature_time").Value.UInt64Value
		    End If
		    
		    Creatures.AddRow(Creature)
		    Results.MoveToNextRow
		  Wend
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToEngram(Results As RowSet) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  While Not Results.AfterLastRow
		    Dim Engram As New Beacon.MutableEngram(Results.Column("path").StringValue, Results.Column("object_id").StringValue)
		    Engram.Label = Results.Column("label").StringValue
		    Engram.Availability = Results.Column("availability").IntegerValue
		    Engram.TagString = Results.Column("tags").StringValue
		    Engram.ModID = Results.Column("mod_id").StringValue
		    Engram.ModName = Results.Column("mod_name").StringValue
		    Engrams.AddRow(Engram)
		    Results.MoveToNextRow
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToLootSource(Results As RowSet) As Beacon.LootSource()
		  Dim Sources() As Beacon.LootSource
		  While Not Results.AfterLastRow
		    Dim HexColor As String = Results.Column("uicolor").StringValue
		    Dim RedHex, GreenHex, BlueHex, AlphaHex As String = "00"
		    If HexColor.Length = 3 Then
		      RedHex = HexColor.Middle(0, 1) + HexColor.Middle(0, 1)
		      GreenHex = HexColor.Middle(1, 1) + HexColor.Middle(1, 1)
		      BlueHex = HexColor.Middle(2, 1) + HexColor.Middle(2, 1)
		    ElseIf HexColor.Length = 4 Then
		      RedHex = HexColor.Middle(0, 1) + HexColor.Middle(0, 1)
		      GreenHex = HexColor.Middle(1, 1) + HexColor.Middle(1, 1)
		      BlueHex = HexColor.Middle(2, 1) + HexColor.Middle(2, 1)
		      AlphaHex = HexColor.Middle(3, 1) + HexColor.Middle(3, 1)
		    ElseIf HexColor.Length = 6 Then
		      RedHex = HexColor.Middle(0, 2)
		      GreenHex = HexColor.Middle(2, 2)
		      BlueHex = HexColor.Middle(4, 2)
		    ElseIf HexColor.Length = 8 Then
		      RedHex = HexColor.Middle(0, 2)
		      GreenHex = HexColor.Middle(2, 2)
		      BlueHex = HexColor.Middle(4, 2)
		      AlphaHex = HexColor.Middle(6, 2)
		    End If
		    
		    Dim Requirements As Dictionary
		    #Pragma BreakOnExceptions Off
		    Try
		      Requirements = Beacon.ParseJSON(Results.Column("requirements").StringValue)
		    Catch Err As RuntimeException
		      
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    Dim Source As New Beacon.MutableLootSource(Results.Column("class_string").StringValue, True)
		    Source.Label = Results.Column("label").StringValue
		    Source.Availability = Results.Column("availability").IntegerValue
		    Source.Multipliers = New Beacon.Range(Results.Column("multiplier_min").DoubleValue, Results.Column("multiplier_max").DoubleValue)
		    Source.UIColor = RGB(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		    Source.SortValue = Results.Column("sort_order").IntegerValue
		    Source.UseBlueprints = False
		    Source.Experimental = Results.Column("experimental").BooleanValue
		    Source.Notes = Results.Column("notes").StringValue
		    
		    If Requirements.HasKey("mandatory_item_sets") Then
		      Dim SetDicts() As Variant = Requirements.Value("mandatory_item_sets")
		      Dim Sets() As Beacon.ItemSet
		      For Each Dict As Dictionary In SetDicts
		        Dim Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromBeacon(Dict)
		        If Set <> Nil Then
		          Sets.AddRow(Set)
		        End If
		      Next
		      Source.MandatoryItemSets = Sets
		    End If
		    
		    If Requirements.HasKey("min_item_sets") Then
		      Source.RequiredItemSets = Requirements.Value("min_item_sets")
		    End If
		    
		    Sources.AddRow(New Beacon.LootSource(Source))
		    Results.MoveToNextRow
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToSpawnPoint(Results As RowSet) As Beacon.SpawnPoint()
		  Dim SpawnPoints() As Beacon.SpawnPoint
		  While Not Results.AfterLastRow
		    Dim Point As New Beacon.MutableSpawnPoint(Results.Column("path").StringValue, Results.Column("object_id").StringValue)
		    Point.Label = Results.Column("label").StringValue
		    Point.Availability = Results.Column("availability").IntegerValue
		    Point.TagString = Results.Column("tags").StringValue
		    Point.ModID = Results.Column("mod_id").StringValue
		    Point.ModName = Results.Column("mod_name").StringValue
		    Point.SetsString = Results.Column("groups").StringValue
		    Point.LimitsString = Results.Column("limits").StringValue
		    Point.Modified = False
		    SpawnPoints.AddRow(New Beacon.SpawnPoint(Point))
		    Results.MoveToNextRow
		  Wend
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveBlueprint(Blueprint As Beacon.Blueprint, Replace As Boolean = True) As Boolean
		  Dim Arr(0) As Beacon.Blueprint
		  Arr(0) = Blueprint
		  Return (Self.SaveBlueprints(Arr, Replace) = 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveBlueprints(Blueprints() As Beacon.Blueprint, Replace As Boolean = True) As Integer
		  Dim CountSaved As Integer
		  
		  Self.BeginTransaction()
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    Try
		      Dim Update As Boolean
		      Dim ObjectID As v4UUID
		      Dim Results As RowSet = Self.SQLSelect("SELECT object_id, mod_id FROM blueprints WHERE object_id = ?1 OR LOWER(path) = ?2;", Blueprint.ObjectID.StringValue, Blueprint.Path.Lowercase)
		      Dim CacheDict As Dictionary
		      If Results.RowCount = 1 Then
		        ObjectID = Results.Column("object_id").StringValue
		        
		        If Replace = False Or ObjectID <> Blueprint.ObjectID Then
		          Continue
		        End If
		        
		        Dim ModID As v4UUID = Results.Column("mod_id").StringValue
		        If ModID <> Self.UserModID Then
		          Continue
		        End If
		        
		        Update = True
		      ElseIf Results.RowCount > 1 Then
		        // What the hell?
		        Continue
		      Else
		        Update = False
		        ObjectID = Blueprint.ObjectID
		      End If
		      
		      Dim Category As String = Blueprint.Category
		      Dim Columns As New Dictionary
		      Columns.Value("object_id") = ObjectID.StringValue
		      Columns.Value("path") = Blueprint.Path
		      Columns.Value("class_string") = Blueprint.ClassString
		      Columns.Value("label") = Blueprint.Label
		      Columns.Value("tags") = Blueprint.TagString
		      Columns.Value("availability") = Blueprint.Availability
		      Columns.Value("mod_id") = Self.UserModID
		      
		      Select Case Blueprint
		      Case IsA Beacon.Creature
		        Dim Creature As Beacon.Creature = Beacon.Creature(Blueprint)
		        If Creature.IncubationTime > 0 And Creature.MatureTime > 0 Then
		          Columns.Value("incubation_time") = Creature.IncubationTime
		          Columns.Value("mature_time") = Creature.MatureTime
		        Else
		          Columns.Value("incubation_time") = Nil
		          Columns.Value("mature_time") = Nil
		        End If
		        CacheDict = Self.mCreatureCache
		      Case IsA Beacon.SpawnPoint
		        Columns.Value("groups") = Beacon.SpawnPoint(Blueprint).SetsString(False)
		        Columns.Value("limits") = Beacon.SpawnPoint(Blueprint).LimitsString(False)
		        CacheDict = Self.mSpawnPointCache
		      Case IsA Beacon.Engram
		        CacheDict = Self.mEngramCache
		      End Select
		      
		      If Update Then
		        Dim Assignments() As String
		        Dim Values() As Variant
		        Dim NextPlaceholder As Integer = 1
		        Dim WhereClause As String
		        For Each Entry As DictionaryEntry In Columns
		          If Entry.Key = "object_id" Then
		            WhereClause = "object_id = ?" + NextPlaceholder.ToString
		          Else
		            Assignments.AddRow(Entry.Key.StringValue + " = ?" + NextPlaceholder.ToString)
		          End If
		          Values.AddRow(Entry.Value)
		          NextPlaceholder = NextPlaceholder + 1
		        Next
		        
		        Self.SQLExecute("UPDATE " + Category + " SET " + Assignments.Join(", ") + " WHERE " + WhereClause + ";", Values)
		        Self.SQLExecute("UPDATE searchable_tags SET tags = ?3 WHERE object_id = ?2 AND source_table = ?1;", Category, ObjectID.StringValue, Blueprint.TagString)
		      Else
		        Dim ColumnNames(), Placeholders() As String
		        Dim Values() As Variant
		        Dim NextPlaceholder As Integer = 1
		        For Each Entry As DictionaryEntry In Columns
		          ColumnNames.AddRow(Entry.Key.StringValue)
		          Placeholders.AddRow("?" + NextPlaceholder.ToString)
		          Values.AddRow(Entry.Value)
		          NextPlaceholder = NextPlaceholder + 1
		        Next
		        
		        Self.SQLExecute("INSERT INTO " + Category + " (" + ColumnNames.Join(", ") + ") VALUES (" + Placeholders.Join(", ") + ");", Values)
		        Self.SQLExecute("INSERT INTO searchable_tags (source_table, object_id, tags) VALUES (?1, ?2, ?3);", Category, ObjectID.StringValue, Blueprint.TagString)
		      End If
		      
		      If CacheDict <> Nil Then
		        If CacheDict.HasKey(Blueprint.ObjectID.StringValue) Then
		          CacheDict.Remove(Blueprint.ObjectID.StringValue)
		        End If
		        If CacheDict.HasKey(Blueprint.Path) Then
		          CacheDict.Remove(Blueprint.Path)
		        End If
		        If CacheDict.HasKey(Blueprint.ClassString) Then
		          CacheDict.Remove(Blueprint.ClassString)
		        End If
		      End If
		      
		      CountSaved = CountSaved + 1
		    Catch Err As RuntimeException
		      Self.Rollback()
		      Return 0
		    End Try
		  Next
		  Self.Commit()
		  
		  If CountSaved > 0 Then
		    Self.SyncUserEngrams()
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  
		  Return CountSaved
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveNotification(Notification As Beacon.UserNotification)
		  If Notification = Nil Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Dim Results As RowSet = Self.SQLSelect("SELECT deleted, read FROM notifications WHERE notification_id = ?1;", Notification.Identifier)
		  Dim Deleted As Boolean = Results.RowCount = 1 And Results.Column("deleted").BooleanValue = True
		  Dim Read As Boolean = Results.RowCount = 1 And Results.Column("read").BooleanValue
		  If Notification.DoNotResurrect And (Deleted Or Read)  Then
		    Self.Rollback
		    Return
		  End If
		  
		  Dim Notify As Boolean = Results.RowCount = 0 Or Deleted Or Read
		  Self.SQLExecute("INSERT OR REPLACE INTO notifications (notification_id, message, secondary_message, moment, read, action_url, user_data, deleted) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, 0);", Notification.Identifier, Notification.Message, Notification.SecondaryMessage, Notification.Timestamp.SQLDateTimeWithOffset, If(Notification.Read Or Notification.Severity = Beacon.UserNotification.Severities.Elevated, 1, 0), Notification.ActionURL, If(Notification.UserData <> Nil, Beacon.GenerateJSON(Notification.UserData, False), "{}"))
		  Self.Commit
		  
		  If Notify Then
		    NotificationKit.Post(Self.Notification_NewAppNotification, Notification)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Self.SavePreset(Preset, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SavePreset(Preset As Beacon.Preset, Reload As Boolean)
		  Dim Content As String = Beacon.GenerateJSON(Preset.ToDictionary, False)
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("INSERT OR REPLACE INTO custom_presets (user_id, object_id, label, contents) VALUES (?1, ?2, ?3, ?4);", Self.UserID, Preset.PresetID, Preset.Label, Content)
		  Self.Commit()
		  
		  Call UserCloud.Write("/Presets/" + Preset.PresetID.Lowercase + BeaconFileTypes.BeaconPreset.PrimaryExtension, Content)
		  
		  If Reload Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Blueprint()
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Return Self.SearchForBlueprints(Category, SearchText, Mods, Tags, ExtraClauses, ExtraValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String, ExtraClauses() As String, ExtraValues() As Variant) As Beacon.Blueprint()
		  Dim Blueprints() As Beacon.Blueprint
		  
		  Try
		    Dim NextPlaceholder As Integer = 1
		    Dim Clauses() As String
		    Dim Values As New Dictionary
		    If SearchText <> "" Then
		      Clauses.AddRow("LOWER(label) LIKE LOWER(?" + Str(NextPlaceholder) + ") OR LOWER(class_string) LIKE LOWER(?" + Str(NextPlaceholder) + ")")
		      Values.Value(NextPlaceholder) = "%" + SearchText + "%"
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    Dim SQL As String
		    Select Case Category
		    Case Beacon.CategoryEngrams
		      SQL = Self.EngramSelectSQL
		    Case Beacon.CategoryCreatures
		      SQL = Self.CreatureSelectSQL
		    Case Beacon.CategorySpawnPoints
		      SQL = Self.SpawnPointSelectSQL
		    Else
		      Return Blueprints
		    End Select
		    
		    If Mods <> Nil And Mods.LastRowIndex > -1 Then
		      Dim Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.AddRow("?" + NextPlaceholder.ToString)
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.AddRow("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    If Tags <> "" Then
		      SQL = SQL.Replace(Category + " INNER JOIN mods", Category + " INNER JOIN searchable_tags ON (searchable_tags.object_id = " + Category + ".object_id AND searchable_tags.source_table = '" + Category + "') INNER JOIN mods")
		      Clauses.AddRow("searchable_tags.tags MATCH ?" + Str(NextPlaceholder, "0"))
		      Values.Value(NextPlaceholder) = Tags
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    If ExtraClauses.LastRowIndex > -1 And ExtraClauses.LastRowIndex = ExtraValues.LastRowIndex Then
		      For I As Integer = 0 To ExtraClauses.LastRowIndex
		        Var Clause As String = ExtraClauses(I).ReplaceAll(":placeholder:", "?" + NextPlaceholder.ToString)
		        Var Value As Variant = ExtraValues(I)
		        Clauses.AddRow(Clause)
		        Values.Value(NextPlaceholder) = Value
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		    End If
		    
		    If Clauses.LastRowIndex > -1 Then
		      SQL = SQL + " WHERE (" + Clauses.Join(") AND (") + ")"
		    End If
		    SQL = SQL + " ORDER BY label;"
		    
		    Dim Results As RowSet
		    If Values.KeyCount = 0 Then
		      Results = Self.SQLSelect(SQL)
		    Else
		      Results = Self.SQLSelect(SQL, Values)
		    End If
		    
		    Select Case Category
		    Case Beacon.CategoryEngrams
		      Dim Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      For Each Engram As Beacon.Engram In Engrams
		        Self.mEngramCache.Value(Engram.Path) = Engram
		        Blueprints.AddRow(Engram)
		      Next
		    Case Beacon.CategoryCreatures
		      Dim Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		      For Each Creature As Beacon.Creature In Creatures
		        Self.mCreatureCache.Value(Creature.Path) = Creature
		        Blueprints.AddRow(Creature)
		      Next
		    Case Beacon.CategorySpawnPoints
		      Dim SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mSpawnPointCache.Value(SpawnPoint.Path) = SpawnPoint
		        Blueprints.AddRow(SpawnPoint)
		      Next
		    End Select
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As String, Mods As Beacon.StringList, IncludeExperimental As Boolean) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Sources() As Beacon.LootSource
		  
		  Try
		    Dim Clauses() As String
		    Dim Values As New Dictionary
		    Dim NextPlaceholder As Integer = 1
		    If Mods.LastRowIndex > -1 Then
		      Dim Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.AddRow("?" + Str(NextPlaceholder))
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.AddRow("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    If SearchText <> "" Then
		      Clauses.AddRow("LOWER(label) LIKE LOWER(?" + Str(NextPlaceholder) + ") OR LOWER(class_string) LIKE LOWER(?" + Str(NextPlaceholder) + ")")
		      Values.Value(NextPlaceholder) = "%" + SearchText + "%"
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    If Not IncludeExperimental Then
		      Clauses.AddRow("experimental = 0")
		    End If
		    
		    Dim SQL As String = "SELECT " + Self.LootSourcesSelectColumns + ", mods.mod_id, mods.name AS mod_name FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id)"
		    If Clauses.LastRowIndex > -1 Then
		      SQL = SQL + " WHERE (" + Clauses.Join(") AND (") + ")"
		    End If
		    SQL = SQL + " ORDER BY sort_order, label;"
		    
		    Dim Results As RowSet
		    If Values.KeyCount > 0 Then
		      Results = Self.SQLSelect(SQL, Values)
		    Else
		      Results = Self.SQLSelect(SQL)
		    End If
		    
		    Sources = Self.RowSetToLootSource(Results)
		  Catch Err As UnsupportedOperationException
		    
		  End Try
		  
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As LocalData
		  If mInstance = Nil And Create = True Then
		    mInstance = New LocalData
		    Beacon.Data = mInstance
		    Dim Results As RowSet = mInstance.SQLSelect("SELECT EXISTS(SELECT 1 FROM blueprints) AS populated;")
		    If Results.Column("populated").BooleanValue = False Then
		      mInstance.ImportLocalClasses()
		    End If
		    If Preferences.OnlineEnabled Then
		      mInstance.CheckForEngramUpdates()
		    End If
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointLabels(Availability As UInt64) As Dictionary
		  If Self.mSpawnLabelCacheMask <> Availability Then
		    Var Points() As Beacon.SpawnPoint = Self.SearchForSpawnPoints("", New Beacon.StringList)
		    Var Labels() As String
		    Var Dict As New Dictionary
		    Labels.ResizeTo(Points.LastRowIndex)
		    
		    For I As Integer = 0 To Points.LastRowIndex
		      If Points(I).ValidForMask(Availability) = False Then
		        Continue
		      End If
		      
		      Var Label As String = Points(I).Label
		      Var Idx As Integer = Labels.IndexOf(Label)
		      Labels(I) = Label
		      If Idx > -1 Then
		        Var Filtered As UInt64 = Points(Idx).Availability And Availability
		        Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Filtered)
		        Dict.Value(Points(Idx).Path) = Points(Idx).Label + " (" + Maps.Label + ")"
		        
		        Filtered = Points(I).Availability And Availability
		        Maps = Beacon.Maps.ForMask(Filtered)
		        Label = Label + " (" + Maps.Label + ")"
		      End If
		      
		      Dict.Value(Points(I).Path) = Label
		    Next
		    
		    Self.mSpawnLabelCacheDict = Dict
		    Self.mSpawnLabelCacheMask = Availability
		  End If
		  
		  Return Self.mSpawnLabelCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(SQLString As String, ParamArray Values() As Variant)
		  Self.mLock.Enter
		  
		  If Values.LastRowIndex = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Dim Dict As Dictionary = Values(0)
		    Redim Values(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.KeyCount
		        Values.AddRow(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Redim Values(-1)
		    End Try
		  ElseIf Values.LastRowIndex = 0 And Values(0).IsArray Then
		    Values = Values(0)
		  End If
		  
		  For I As Integer = 0 To Values.LastRowIndex
		    Dim Value As Variant = Values(I)
		    If Value.Type <> Variant.TypeObject Then
		      Continue
		    End If
		    Select Case Value.ObjectValue
		    Case IsA MemoryBlock
		      Dim Mem As MemoryBlock = Value
		      Values(I) = Mem.StringValue(0, Mem.Size)
		    End Select
		  Next
		  
		  Try
		    Self.mBase.ExecuteSQL(SQLString, Values)
		    Self.mLock.Leave
		  Catch Err As DatabaseException
		    Self.mLock.Leave
		    Dim Cloned As New UnsupportedOperationException
		    Cloned.Message = Err.Message + EndOfLine + SQLString
		    Raise Cloned
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(SQLString As String, ParamArray Values() As Variant) As RowSet
		  Self.mLock.Enter
		  
		  If Values.LastRowIndex = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Dim Dict As Dictionary = Values(0)
		    Redim Values(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.KeyCount
		        Values.AddRow(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Redim Values(-1)
		    End Try
		  End If
		  
		  For I As Integer = 0 To Values.LastRowIndex
		    Dim Value As Variant = Values(I)
		    If Value.Type <> Variant.TypeObject Then
		      Continue
		    End If
		    Select Case Value.ObjectValue
		    Case IsA MemoryBlock
		      Dim Mem As MemoryBlock = Value
		      Values(I) = Mem.StringValue(0, Mem.Size)
		    End Select
		  Next
		  
		  Try
		    Dim Results As RowSet = Self.mBase.SelectSQL(SQLString, Values)
		    Self.mLock.Leave
		    Return Results
		  Catch Err As DatabaseException
		    Self.mLock.Leave
		    Dim Cloned As New UnsupportedOperationException
		    Cloned.Message = Err.Message + EndOfLine + SQLString
		    Raise Cloned
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Start()
		  Call SharedInstance(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncUserEngrams()
		  // This way changing lots of engrams rapidly won't require a write to disk
		  // after each action
		  
		  If Self.mSyncUserEngramsKey <> "" Then
		    CallLater.Cancel(Self.mSyncUserEngramsKey)
		    Self.mSyncUserEngramsKey = ""
		  End If
		  
		  Self.mSyncUserEngramsKey = CallLater.Schedule(250, AddressOf SyncUserEngramsActual)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncUserEngramsActual()
		  Dim Results As RowSet = Self.SQLSelect("SELECT class_string, path, tags, object_id, label, availability, category FROM blueprints WHERE mod_id = ?1;", Self.UserModID)
		  Dim Dicts() As Dictionary
		  While Not Results.AfterLastRow
		    Dim Dict As New Dictionary  
		    Dict.Value("class_string") = Results.Column("class_string").StringValue  
		    Dict.Value("path") = Results.Column("path").StringValue  
		    Dict.Value("tags") = Results.Column("tags").StringValue
		    Dict.Value("object_id") = Results.Column("object_id").StringValue
		    Dict.Value("label") = Results.Column("label").StringValue
		    Dict.Value("availability") = Results.Column("availability").IntegerValue
		    Dict.Value("category") = Results.Column("category").StringValue
		    Dicts.AddRow(Dict)
		    
		    Results.MoveToNextRow()
		  Wend
		  
		  If Dicts.Count > 0 Then
		    Dim Content As String = Beacon.GenerateJSON(Dicts, False)
		    Call UserCloud.Write("Engrams.json", Content)
		  Else
		    Call UserCloud.Delete("Engrams.json")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserID() As String
		  Return App.IdentityManager.CurrentIdentity.Identifier.Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variable(Key As String) As String
		  Try
		    Dim Results As RowSet = Self.SQLSelect("SELECT value FROM variables WHERE LOWER(key) = LOWER(?1);", Key)
		    If Results.RowCount = 1 Then
		      Return Results.Column("value").StringValue
		    End If
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Variable(Key As String, Assigns Value As String)
		  Try
		    Self.BeginTransaction()
		    Self.SQLExecute("INSERT OR REPLACE INTO variables (key, value) VALUES (?1, ?2);", Key, Value)
		    Self.Commit()
		  Catch Err As UnsupportedOperationException
		    Self.Rollback()
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared IconCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBase As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckingForUpdates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatureCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDropsLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDropsLabelCacheMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As LocalData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCommitTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNextSyncImportAll As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnLabelCacheMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnPointCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSyncUserEngramsKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As URLConnection
	#tag EndProperty


	#tag Constant, Name = CreatureSelectSQL, Type = String, Dynamic = False, Default = \"SELECT creatures.object_id\x2C creatures.path\x2C creatures.label\x2C creatures.availability\x2C creatures.tags\x2C creatures.incubation_time\x2C creatures.mature_time\x2C creatures.stats\x2C mods.mod_id\x2C mods.name AS mod_name FROM creatures INNER JOIN mods ON (creatures.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.object_id\x2C engrams.path\x2C engrams.label\x2C engrams.availability\x2C engrams.tags\x2C mods.mod_id\x2C mods.name AS mod_name FROM engrams INNER JOIN mods ON (engrams.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LootSourcesSelectColumns, Type = String, Dynamic = False, Default = \"class_string\x2C label\x2C availability\x2C multiplier_min\x2C multiplier_max\x2C uicolor\x2C sort_order\x2C experimental\x2C notes\x2C requirements", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_DatabaseUpdated, Type = String, Dynamic = False, Default = \"Database Updated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_EngramsChanged, Type = String, Dynamic = False, Default = \"Engrams Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportFailed, Type = String, Dynamic = False, Default = \"Import Failed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportSuccess, Type = String, Dynamic = False, Default = \"Import Success", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_NewAppNotification, Type = String, Dynamic = False, Default = \"New App Notification", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_PresetsChanged, Type = String, Dynamic = False, Default = \"Presets Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SchemaVersion, Type = Double, Dynamic = False, Default = \"13", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SpawnPointSelectSQL, Type = String, Dynamic = False, Default = \"SELECT spawn_points.object_id\x2C spawn_points.path\x2C spawn_points.label\x2C spawn_points.availability\x2C spawn_points.tags\x2C spawn_points.groups\x2C spawn_points.limits\x2C mods.mod_id\x2C mods.name AS mod_name FROM spawn_points INNER JOIN mods ON (spawn_points.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UserModID, Type = String, Dynamic = False, Default = \"23ecf24c-377f-454b-ab2f-d9d8f31a5863", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UserModName, Type = String, Dynamic = False, Default = \"User Blueprints", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
