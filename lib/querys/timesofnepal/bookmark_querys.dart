import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnBookMarkTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_BOOKMARKS, parameter);
  }

  Future deleteFromTableBookMark() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_BOOKMARKS');
  }

  Future<int?> updateForTableBookMark() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_BOOKMARKS SET read=1 WHERE read=0');
  }

  Future<List<Map<String, dynamic>>?> getFromBookMark() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_BOOKMARKS);
  }
}
