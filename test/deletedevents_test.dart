import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Deleted Events Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'event_id': "event_id",
      'calendar_id': "calendar_id",
      'created_at': '2022/3/21',
      'updated_at': "2022/3/21",
    };
    await dbHelper.insertOnDeletedEventTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'event_id': "event_id",
        'calendar_id': "calendar_id",
        'created_at': '2022/3/21',
        'updated_at': "2022/3/21",
      }
    ];

    var result = await dbHelper.getFromDeletedEvent();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Deleted Events", () async {
    await dbHelper.updateDeletedEventTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'event_id': "event_id",
        'calendar_id': "calendar_id test",
        'created_at': '2022/3/21',
        'updated_at': "2022/3/21",
      }
    ];

    var result = await dbHelper.getFromDeletedEvent();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Deleted Events", () async {
    var result = await dbHelper.deleteFromTableDeletedEvent();
    expect(result, null);
  });
}
