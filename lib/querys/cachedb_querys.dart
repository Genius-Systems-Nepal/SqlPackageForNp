import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class CacheDbQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnCacheDbTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_CACHE, parameter);
  }

  Future deleteFromTableCacheDb() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_CACHE');
  }

  Future<int?> updateForTableCacheDb() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_CACHE SET event_id=20 WHERE event_id=21');
  }

  Future<List<Map<String, dynamic>>?> getFromCacheDb() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_CACHE);
  }
}
