#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Opening(args() As String)
		  SetupDatabase
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function DBFile() As FolderItem
		  Return SpecialFolder.Desktop.Child("test-db.sqlite")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupDatabase()
		  Var db As New SQLiteDatabase
		  db.DatabaseFile = DBFile
		  db.WriteAheadLogging = True
		  
		  // The file is already there, no need to build it again
		  If db.DatabaseFile.Exists Then
		    Return
		  End If
		  
		  db.CreateDatabase
		  db.Connect
		  db.ExecuteSQL(kDatabaseSetupSQLite)
		End Sub
	#tag EndMethod


	#tag Constant, Name = kDatabaseSetupSQLite, Type = String, Dynamic = False, Default = \"CREATE TABLE things (\n  id    INTEGER PRIMARY KEY AUTOINCREMENT\x2C\n  foo TEXT\x2C\n  bar TEXT\x2C\n  baz TEXT\n);\n\nWITH RECURSIVE cnt(x) AS \n(\n   SELECT\n      1 \n   UNION ALL\n   SELECT\n      x + 1 \n   FROM\n      cnt LIMIT 1000000\n)\nINSERT INTO things (foo\x2C bar\x2C baz)\nSELECT\n    \'foo_\' || x AS foo\x2C\n    \'bar_\' || x  AS bar\x2C\n    \'baz_\' || x AS baz\nFROM cnt;\n\nCREATE INDEX \"idx_foo\" ON things (\n    foo\x2C id\x2C bar\x2C baz\n);\n\nCREATE INDEX \"idx_bar\" ON things (\n    bar\x2C id\x2C foo\x2C baz\n);\n\nCREATE INDEX \"idx_baz\" ON things (\n    baz\x2C id\x2C foo\x2C bar\n);\n\nVACUUM;", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
