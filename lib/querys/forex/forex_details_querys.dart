import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class ForexDetailsQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnForexDetailsTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_FOREX_DETAIL, parameter);
  }

  Future deleteFromTableForexDetails() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_FOREX_DETAIL');
  }

  Future<int?> updateForTableForexDetails() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_FOREX_DETAIL SET pid=10 WHERE pid=1');
  }

  Future<List<Map<String, dynamic>>?> getFromForexDetails() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_FOREX_DETAIL);
  }
}
