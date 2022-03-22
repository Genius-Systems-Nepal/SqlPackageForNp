import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class DeletedEventQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnDeletedEventTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_DELETE_EVENTS, parameter);
  }

  Future deleteFromTableDeletedEvent() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_DELETE_EVENTS');
  }

  Future<int?> updateForTableDeletedEvent() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_DELETE_EVENTS SET calendar_id="calendar_id test" WHERE calendar_id="calendar_id"');
  }

  Future<List<Map<String, dynamic>>?> getFromDeletedEvent() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_DELETE_EVENTS);
  }
}
