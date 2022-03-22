import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class ExceptionsQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnExceptionsTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_EVENTS_EXCEPTION, parameter);
  }

  Future deleteFromTableExceptions() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_EVENTS_EXCEPTION');
  }

  Future<int?> updateForTableExceptions() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_EVENTS_EXCEPTION SET event_id=20 WHERE event_id=10');
  }

  Future<List<Map<String, dynamic>>?> getFromExceptions() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_EVENTS_EXCEPTION);
  }
}
