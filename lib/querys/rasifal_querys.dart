import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class RasifalQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnRasifalTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_RASHIFAL, parameter);
  }

  Future deleteFromTableRasifal() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_RASHIFAL');
  }

  Future<int?> updateForTableRasifal() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_RASHIFAL SET type="Hello" WHERE type="HelloDevp"');
  }

  Future<List<Map<String, dynamic>>?> getFromRasifal() async {
    Database? db = await databaseHelper.database;
    return await db?.rawQuery("Select * From $DB_TABLE_RASHIFAL");
  }
}
