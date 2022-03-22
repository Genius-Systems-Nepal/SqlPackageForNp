import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Deleted Reminders Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'reminder_id': "reminder_id",
      'event_id': "event_id",
      'created_at': '2022/3/21',
      'updated_at': "2022/3/21"
    };
    await dbHelper.insertOnDeletedReminderTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'reminder_id': "reminder_id",
        'event_id': "event_id",
        'created_at': '2022/3/21',
        'updated_at': "2022/3/21"
      }
    ];

    var result = await dbHelper.getFromDeletedReminder();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Deleted Reminders Table", () async {
    await dbHelper.updateDeletedReminderTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'reminder_id': "reminder_id",
        'event_id': "event_id test",
        'created_at': '2022/3/21',
        'updated_at': "2022/3/21"
      }
    ];

    var result = await dbHelper.getFromDeletedReminder();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Deleted Reminders", () async {
    var result = await dbHelper.deleteFromTableDeletedReminder();
    expect(result, null);
  });
}
