import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Forex Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'fordate': 'fordate',
      'source': 1,
      'source_url': 'www.google.com.np',
    };
    await dbHelper.insertOnForexTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'fordate': 'fordate',
        'source': 1,
        'source_url': 'www.google.com.np',
      }
    ];

    var result = await dbHelper.getFromForex();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Forex", () async {
    await dbHelper.updateForexTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'fordate': 'fordate',
        'source': 10,
        'source_url': 'www.google.com.np',
      }
    ];

    var result = await dbHelper.getFromForex();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Forex", () async {
    var result = await dbHelper.deleteFromTableForex();
    expect(result, null);
  });
}
