var json;

function addToList(id, titel)
{
    elementModel.append({"nId": id, "titel": titel})

}

function getList()
{
    request = "liste";
    netWork.getMnotes("/index.php/apps/notes/api/v0.2/notes");
}

function getNote(id)
{
   // console.log("getNote "+id)
    request = "note";
    netWork.getMnotes("/index.php/apps/notes/api/v0.2/notes/"+id)
}

function newNote(content)
{
    var data = JSON.stringify({"content":content});
    var url = "/index.php/apps/notes/api/v0.2/notes" ;
    netWork.newMnote(url,data);
}

function updateNote(id, cat, fav, content)
{
    request = "update";
    if(!cat)
        cat = null

   // var data ={"id": id, "category":cat,"favorite":fav,"modified":Date.now(),"content":content};

    var data =JSON.stringify({"id": id, "content":content});
//    console.log("Content: "+data)
    var url = "/index.php/apps/notes/api/v0.2/notes/" +id;

    netWork.updateMnote(url, data);

}

function delNote(id)
{
    request = "delete";
    var url = "/index.php/apps/notes/api/v0.2/notes/" +id;
    netWork.delMnote(url);

}

function parseJson(result)
{
    // console.log("parseJson: "+ result)
    if (result.length > 0)
    {
        json = JSON.parse(result);
    }else{
        errorDlg.informativeText = "No data available! \nCheck your Server if notes is active."
        errorDlg.open()
    }
    notesBusy.visible = false;

    switch (request)
    {
    case "liste":
        makeList();
        break;
    case "note":
        parseNote();
        break;
    default:
        break;
    }

}

function makeList()
{
    if (elementModel.count > 0)
        elementModel.clear()
    for (var i in json)
    {
      //  console.log(json[i].id)
        elementModel.append({"nId": json[i].id,"name": json[i].title,})
       // if(json[i].category)
       //         elementModel.setProperty(elementModel.count-1,"buttonLabel.category",json[i].category)
        elementModel.setProperty(elementModel.count-1,"buttonLabel.favorite",json[i].favorite)
       // console.log(notesModel.count)

    }
}


function parseNote()
{

     label.text = json.title
     note.textArea.text = json.content

}








