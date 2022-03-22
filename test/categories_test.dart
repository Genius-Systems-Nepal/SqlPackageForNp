import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Categories Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'name': "test name",
      'name_np': "np name",
      'code': '0hghs',
      'icon': "back",
      'enable': 'true',
      'priority': 0,
    };
    await dbHelper.insertOnCategoriesTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'name': "test name",
        'name_np': "np name",
        'code': '0hghs',
        'icon': "back",
        'enable': 'true',
        'priority': 0,
      }
    ];

    var result = await dbHelper.getFromCategories();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Calendar", () async {
    await dbHelper.updateCategoriesTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'name': "test name",
        'name_np': "np name",
        'code': '0hghs',
        'icon': "back",
        'enable': 'false',
        'priority': 0,
      }
    ];

    var result = await dbHelper.getFromCategories();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Calendar", () async {
    var result = await dbHelper.deleteFromTableCategories();
    expect(result, null);
  });
}
