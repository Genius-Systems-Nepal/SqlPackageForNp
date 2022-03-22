import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class PanchangaDbQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnPanchangaDbTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_PANCHANGA, parameter);
  }

  Future deleteFromTablePanchangaDb() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_PANCHANGA');
  }

  Future<int?> updateForTablePanchangaDb() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_PANCHANGA SET text_dden="www.org" WHERE text_dden="www"');
  }

  Future<List<Map<String, dynamic>>?> getFromPanchangaDb() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_PANCHANGA);
  }
}
