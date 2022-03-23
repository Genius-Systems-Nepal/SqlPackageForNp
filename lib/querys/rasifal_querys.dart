import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class RashifalQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnRasifalTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_RASHIFAL, parameter);
  }

  Future deleteFromTableRashifal() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_RASHIFAL');
  }

  Future<int?> updateForTableRashifal() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_RASHIFAL SET type="Hello" WHERE type="HelloDevp"');
  }

  Future<List<Map<String, dynamic>>?> getFromRashifal() async {
    Database? db = await databaseHelper.database;
    return await db?.rawQuery("Select * From $DB_TABLE_RASHIFAL");
  }
}
