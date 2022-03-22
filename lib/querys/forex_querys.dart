import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class ForexQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnForexTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_FOREX, parameter);
  }

  Future deleteFromTableForex() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_FOREX');
  }

  Future<int?> updateForTableForex() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_FOREX SET source=10 WHERE source=1');
  }

  Future<List<Map<String, dynamic>>?> getFromForex() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_FOREX);
  }
}
