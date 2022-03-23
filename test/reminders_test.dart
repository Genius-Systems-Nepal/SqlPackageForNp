import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Reminders Table ', () async {
    Map<String, dynamic> parameter = {
      'id': '1',
      'event_id': "event_id",
      'days': 2,
      'time': '2.2',
      'note': 'note',
      'notification_type': "notification_type",
      'updated_at': "updated_at",
      'created_at': "created_at"
    };
    await dbHelper.insertOnRemindersTable(parameter);
    dynamic getvalue = [
      {
        'id': '1',
        'event_id': "event_id",
        'days': 2,
        'time': '2.2',
        'note': 'note',
        'notification_type': "notification_type",
        'updated_at': "updated_at",
        'created_at': "created_at"
      }
    ];

    var result = await dbHelper.getFromReminders();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Reminders Table", () async {
    await dbHelper.updateRemindersTable();
    dynamic getUpdatedvalue = [
      {
        'id': '1',
        'event_id': "event_id",
        'days': 20,
        'time': '2.2',
        'note': 'note',
        'notification_type': "notification_type",
        'updated_at': "updated_at",
        'created_at': "created_at"
      }
    ];

    var result = await dbHelper.getFromReminders();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Reminders", () async {
    var result = await dbHelper.deleteFromTableReminders();
    expect(result, null);
  });
}
