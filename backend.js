 var db;
 
 function createDB()
  {
      //  console.log(LocalStorage.offlineStoragePath());
		
	   db = LocalStorage.openDatabaseSync("NotesDB", "1.0", "Yet Another Notes App!", 1000000);
	  db.transaction(
                function(tx) {
                    // Create the database if it doesn't already exist
						 // tx.executeSql('DROP TABLE NotesDB');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS NotesDB(id INTEGER PRIMARY KEY AUTOINCREMENT,modified NUM,titel TEXT, content TEXT)');

                }
            )
	  
  }
  
  
  function insertData(titel, content)
  {
		var date = Date.now();
		var result;
	  db.transaction(function(tx){
			result = tx.executeSql('INSERT INTO NotesDB (modified,titel,content) VALUES(?,?,?)',[date,titel,content])
		})
      return parseInt(result.insertId,10);
  }
  
  function getTitels()
  {
      /**
        * all properties in ELements.qml are initilized first here
        * see note in Elements.qml
        **/
	  var data;
     // console.log("Titles")
	  
      db.transaction( function(tx){
          data = tx.executeSql('SELECT titel, id FROM NotesDB');
      }

      )
	  
      return (data.rows)

  }
 /**
  function getData()
  {
		var data;
		
		db.transaction( function(tx){
								data = tx.executeSql('SELECT * FROM NotesDB');
							}
				
			)
		
		for (var i=0; i<= data.rows.length-1; i++)
		{
			var titel = data.rows.item(i).titel;
			var content = data.rows.item(i).content;
			var id = data.rows.item(i).id;
			
            notesModel.append({"nId": id, "titel": titel, "content": content})

		}

  }
**/
  function initDB()
  {
	  createDB();

  }
  
  
  function updateData(id, titel, content)
  {
	  // console.log(id +" ,"+titel+" ,"+content)
	  var date = Date.now();
	  db.transaction(function(tx){
			tx.executeSql('UPDATE NotesDB SET modified=?, titel=?, content=? WHERE id='+id,[date,titel,content])
		})
	  
  }
  
  function getNoteData(id)
  {
	  var data;
	  db.transaction( function(tx){
								data = tx.executeSql('SELECT * FROM NotesDB WHERE id='+id);
							}
				
			)
	  
	  if (data.rows.length > 0)
	  {
            var noteTxt = data.rows.item(0).content;
            var noteTitel = data.rows.item(0).titel;
          //note.noteId = id;
          return {"name": noteTitel, "content": noteTxt}
	  }
  }
  
  
function deleteNote(id)
{
      initDB();
      db.transaction( function(tx){
          var data = tx.executeSql('DELETE  FROM NotesDB WHERE id= ?',[id]);
        }
      );
}
