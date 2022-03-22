import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class HolidaysQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnHolidaysTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_HOLIDAYS, parameter);
  }

  Future deleteFromTableHolidays() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_HOLIDAYS');
  }

  Future<int?> updateForTableHolidays() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_HOLIDAYS SET status=1 WHERE status=0');
  }

  Future<List<Map<String, dynamic>>?> getFromHolidays() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_HOLIDAYS);
  }
}
