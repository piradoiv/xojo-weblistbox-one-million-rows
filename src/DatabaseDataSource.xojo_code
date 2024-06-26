#tag Class
Protected Class DatabaseDataSource
Implements WebDataSource
	#tag Method, Flags = &h21
		Private Function ColumnData() As WebListboxColumnData()
		  // Part of the WebDataSource interface.
		  
		  Var result() As WebListBoxColumnData
		  result.Add(New WebListBoxColumnData("ID", "id"))
		  result.Add(New WebListBoxColumnData("Foo", "foo"))
		  result.Add(New WebListBoxColumnData("Bar", "bar"))
		  result.Add(New WebListBoxColumnData("Baz", "baz"))
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowCount() As Integer
		  // Part of the WebDataSource interface.
		  
		  Try
		    Var rows As RowSet = Session.Database.SelectSQL("SELECT COUNT(*) AS counter FROM things")
		    Return rows.Column("counter").IntegerValue
		  Catch DatabaseException
		    Return 0
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowData(rowCount As Integer, rowOffset As Integer, sortColumns As String) As WebListboxRowData()
		  // Part of the WebDataSource interface.
		  
		  Var sql As String = "SELECT * FROM things"
		  If sortColumns <> "" Then
		    sql = sql + " ORDER BY " + sortColumns
		  End If
		  sql = sql + " LIMIT " + rowOffset.ToString + ", " + rowCount.ToString
		  
		  Var result() As WebListBoxRowData
		  Var rows As RowSet = Session.Database.SelectSQL(sql)
		  
		  // This isn't needed, it's just to demonstrate how to use cell renderers
		  Var style As New WebStyle
		  style.Bold = True
		  style.BackgroundColor = Color.Teal
		  style.ForegroundColor = Color.White
		  
		  For Each row As DatabaseRow In rows
		    Var newRowData As New WebListBoxRowData
		    newRowData.PrimaryKey = row.Column("id").IntegerValue
		    newRowData.Value("id") = row.Column("id")
		    newRowData.Value("foo") = row.Column("foo")
		    newRowData.Value("bar") = New WebListBoxStyleRenderer(style, row.Column("bar"))
		    newRowData.Value("baz") = row.Column("baz")
		    result.Add(newRowData)
		  Next
		  
		  Return result
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
