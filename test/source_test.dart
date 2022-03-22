import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Source Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'name': "name",
      'name_np': 'name_np',
      'code': 'code',
      'icon': 'icon',
      'lang': "en",
      'priority': 0,
      'favicon': "go",
      'ga': "gaa"
    };
    await dbHelper.insertOnSourcesTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'name': "name",
        'name_np': 'name_np',
        'code': 'code',
        'icon': 'icon',
        'lang': "en",
        'priority': 0,
        'favicon': "go",
        'ga': "gaa"
      }
    ];

    var result = await dbHelper.getFromSources();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Source Table", () async {
    await dbHelper.updateSourcesTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'name': "name",
        'name_np': 'name_np',
        'code': 'code',
        'icon': 'icon',
        'lang': "en",
        'priority': 0,
        'favicon': "go",
        'ga': "gooo"
      }
    ];

    var result = await dbHelper.getFromSources();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Source", () async {
    var result = await dbHelper.deleteFromTableSources();
    expect(result, null);
  });
}
