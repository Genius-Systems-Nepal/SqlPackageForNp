import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class DeletedReminderQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnDeletedReminderTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_DELETE_REMINDERS, parameter);
  }

  Future deleteFromTableDeletedReminder() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_DELETE_REMINDERS');
  }

  Future<int?> updateForTableDeletedReminder() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_DELETE_REMINDERS SET event_id="event_id test" WHERE event_id ="event_id"');
  }

  Future<List<Map<String, dynamic>>?> getFromDeletedReminder() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_DELETE_REMINDERS);
  }
}
