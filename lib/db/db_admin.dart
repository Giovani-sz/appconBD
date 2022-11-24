import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin{


  Database? myDatabase;

  //Singleton
  static final DBAdmin db= DBAdmin._();
  DBAdmin._();

//

  Future <Database?> checkDatabase() async{
if (myDatabase != null){
return myDatabase;
}
myDatabase = await initDatabase();
return myDatabase;
  }

Future <Database>initDatabase() async {
Directory directory = await getApplicationDocumentsDirectory();
String path =join(directory.path, "TaskBD.db");
return await openDatabase(
  path,
  version: 1,
  onOpen: (db){},
  onCreate: (Database dbx, int version) async{
    //crear tabla correspondiente
await dbx.execute(" CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");

  }
);
}
insertRawTask () async {
Database? db = await checkDatabase();
int res = await db!.rawInsert("INSERT INTO TASK(title, description, status) VALUES ('ir de compras','Tenemos que ir a tottus','false')");
print(res);


}
Future<List<Map<String, dynamic>>> getTasks() async{
Database? db = await checkDatabase();
List<Map<String, dynamic>> tasks = await db!.query("Task");
return tasks;
}


updateRawTask() async {
  Database? db = await checkDatabase();
int res= await db!.rawUpdate("UPDATE TASK SET title = 'ir de compras', description = 'comprar comida', status = 'true' WHERE id = 2");
print (res);
}

deleteRawTask() async {
  Database? db = await checkDatabase();

int res = await db!.rawDelete("DELETE FROM TASK WHERE id 2");
print (res);

}


}