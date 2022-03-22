import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Calendar Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'name': "test name",
      'status': 1,
      'calendar_id': '1',
      'is_modifiable': 0,
      'created_by': 'dillibhai',
      'is_default': 1,
      'created_at': '2022/11/1',
      'updated_at': '2022/11/1',
      'color': 'white',
      'priority': 0,
      'display': 1,
    };
    await dbHelper.insertOnCalendarTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'name': "test name",
        'status': 1,
        'calendar_id': '1',
        'is_modifiable': 0,
        'created_by': 'dillibhai',
        'is_default': 1,
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
        'color': 'white',
        'priority': 0,
        'display': 1,
      }
    ];

    var result = await dbHelper.getFromCalendar();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Calendar", () async {
    await dbHelper.updateCalendarTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'name': "test name",
        'status': 1,
        'calendar_id': '1',
        'is_modifiable': 0,
        'created_by': 'dillibhai',
        'is_default': 1,
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
        'color': 'white',
        'priority': 1,
        'display': 1,
      }
    ];

    var result = await dbHelper.getFromCalendar();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Calendar", () async {
    var result = await dbHelper.deleteFromTableCalendar();
    expect(result, null);
  });
}
