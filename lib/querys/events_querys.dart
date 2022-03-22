import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class EventsQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnEventsTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_EVENTS, parameter);
  }

  Future deleteFromTableEvents() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_EVENTS ');
  }

  Future<int?> updateForTableEvents() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_EVENTS SET parent_event_id=10 WHERE parent_event_id=1');
  }

  Future<List<Map<String, dynamic>>?> getFromEvents() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_EVENTS);
  }
}
