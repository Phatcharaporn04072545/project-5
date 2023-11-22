
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

 class DataHelper {
  
   static Future<Database> database() async {
     final databasePath = await sql.getDatabasesPath();
     return sql.openDatabase(
             path.join(databasePath, 'image2.db'),
       onCreate: (db, version) {
         return db.execute(
           'CREATE TABLE user_image(id INTEGER PRIMARY KEY, image TEXT, title TEXT)',
         );
       },
       version: 1,
     );
   }

   static Future<void> insert(String table, Map<String,Object>data)async{
         final db = await DataHelper.database();
     print(data);
     db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  
   }

   static Future<List<Map<String, dynamic>>> getData(String table) async{

     final db=await DataHelper.database();
     return db.query(table);
   }
 }

