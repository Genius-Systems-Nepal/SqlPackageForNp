import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class RemindersQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnRemindersTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_REMINDERS, parameter);
  }

  Future deleteFromTableReminders() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_REMINDERS');
  }

  Future<int?> updateForTableReminders() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_REMINDERS SET days=20 WHERE days=2');
  }

  Future<List<Map<String, dynamic>>?> getFromReminders() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_REMINDERS);
  }
}
