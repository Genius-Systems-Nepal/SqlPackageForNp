import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class FeedsQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnFeedsTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_FEEDS, parameter);
  }

  Future deleteFromTableFeeds() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_FEEDS');
  }

  Future<int?> updateForTableFeeds() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_FEEDS SET read=1 WHERE read=0');
  }

  Future<List<Map<String, dynamic>>?> getFromFeeds() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_FEEDS);
  }
}
