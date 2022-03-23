import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Holidays ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'eventId': 'testid',
      'eventDate': 'hidate',
      'holidayType': 'vacation',
      'status': 0,
      'createdAt': 'en',
      'updatedAt': 'hi',
      'deletedAt': 'hi'
    };
    await dbHelper.insertOnHolidaysTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'eventId': 'testid',
        'eventDate': 'hidate',
        'holidayType': 'vacation',
        'status': 0,
        'createdAt': 'en',
        'updatedAt': 'hi',
        'deletedAt': 'hi'
      }
    ];

    var result = await dbHelper.getFromHolidays();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Holidays", () async {
    await dbHelper.updateHolidaysTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'eventId': 'testid',
        'eventDate': 'hidate',
        'holidayType': 'vacation',
        'status': 1,
        'createdAt': 'en',
        'updatedAt': 'hi',
        'deletedAt': 'hi'
      }
    ];

    var result = await dbHelper.getFromHolidays();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Holidays", () async {
    var result = await dbHelper.deleteFromTableHolidays();
    expect(result, null);
  });
}
