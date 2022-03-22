import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class CalendarQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnCalendarTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_CALENDAR, parameter);
  }

  Future deleteFromTableCalendar() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_CALENDAR');
  }

  Future<int?> updateForTableCalendar() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_CALENDAR SET priority=1 WHERE priority=0');
  }

  Future<List<Map<String, dynamic>>?> getFromCalendar() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_CALENDAR);
  }
}
