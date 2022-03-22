import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Rasifal ', () async {
    Map<String, dynamic> parameter = {
      'type': 'HelloDevp',
      'title': 'heloTest',
      'author': 'Test author',
      'lang': 'en',
      'aries': 'aries',
    };
    await dbHelper.insertOnRasifalTable(parameter);
    dynamic getvalue = [
      {
        'type': 'HelloDevp',
        'title': 'heloTest',
        'author': 'Test author',
        'lang': 'en',
        'aries': 'aries',
        'taurus': null,
        'gemini': null,
        'cancer': null,
        'leo': null,
        'virgo': null,
        'libra': null,
        'scorpio': null,
        'sagittarius': null,
        'capricorn': null,
        'aquarius': null,
        'pisces': null,
        'todate': null
      }
    ];

    var result = await dbHelper.getFromRasifal();
    expect(result, getvalue);
    await db.close();
  });
  test("Update From Table Rasifal", () async {
    await dbHelper.updateRasifal();
    dynamic updatedvalue = [
      {
        'type': 'Hello',
        'title': 'heloTest',
        'author': 'Test author',
        'lang': 'en',
        'aries': 'aries',
        'taurus': null,
        'gemini': null,
        'cancer': null,
        'leo': null,
        'virgo': null,
        'libra': null,
        'scorpio': null,
        'sagittarius': null,
        'capricorn': null,
        'aquarius': null,
        'pisces': null,
        'todate': null
      }
    ];
    var result = await dbHelper.getFromRasifal();
    expect(result, updatedvalue);
  });

  test("Deleted From Table Rasifal", () async {
    var result = await dbHelper.deleteFromtableRasifal();
    expect(result, null);
  });
}
