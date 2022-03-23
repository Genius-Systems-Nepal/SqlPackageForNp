import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
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
    await dbHelper.close();
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
    await dbHelper.close();
  });

  test("Deleted From Table Source", () async {
    var result = await dbHelper.deleteFromTableSources();
    expect(result, null);
  });
}
