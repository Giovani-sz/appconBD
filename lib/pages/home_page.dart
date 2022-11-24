
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/db_admin.dart';

class HomePage extends StatelessWidget{
const HomePage({Key? key}) : super (key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
  title: Text("HomePage"),
  
  ),
  body: FutureBuilder(
future: DBAdmin.db.getTasks(),
builder: (BuildContext contex, AsyncSnapshot snap){
  if(snap.hasData){
    List<Map<String, dynamic>> myTask = snap.data;
return ListView.builder(

itemCount: myTask.length,
itemBuilder: (BuildContext context, int index){
  return ListTile(
    
    title: Text(myTask[index]["title"]),
    subtitle: Text(myTask[index]["description"]),
    trailing: Text(myTask[index]["id"].toString()),
    );
}

);

  }else{

    return Center(child: CircularProgressIndicator(),
    );
  }


},

  )


  );



}
}