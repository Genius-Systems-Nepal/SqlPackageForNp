import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Panchanga ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'date': '2022/2/2',
      'text_np': 'text_np',
      'text_en': 'text_en',
      'text_ddnp': 'www.conte',
      'text_dden': 'www',
    };
    await dbHelper.insertOnPanchangaDbTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'date': '2022/2/2',
        'text_np': 'text_np',
        'text_en': 'text_en',
        'text_ddnp': 'www.conte',
        'text_dden': 'www',
      }
    ];

    var result = await dbHelper.getFromPanchangaDb();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table AMessage", () async {
    await dbHelper.updatePanchangaDbTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'date': '2022/2/2',
        'text_np': 'text_np',
        'text_en': 'text_en',
        'text_ddnp': 'www.conte',
        'text_dden': 'www.org',
      }
    ];

    var result = await dbHelper.getFromPanchangaDb();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table AMessage", () async {
    var result = await dbHelper.deleteFromTablePanchangaDb();
    expect(result, null);
  });
}
