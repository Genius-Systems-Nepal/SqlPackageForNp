import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class MessageQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnMessageTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_AMESSAGE, parameter);
  }

  Future deleteFromTableMessage() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_AMESSAGE');
  }

  Future<int?> updateForTableMessage() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_AMESSAGE SET cancelled=0 WHERE cancelled=1');
  }

  Future<List<Map<String, dynamic>>?> getFromMessage() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_AMESSAGE);
  }
}
