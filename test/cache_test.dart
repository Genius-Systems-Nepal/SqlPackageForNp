import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From CacheTable ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'date': '2022/11/1',
      'event_id': '21',
      'created_at': '2022/11/1',
      'updated_at': '2022/11/1',
    };
    await dbHelper.insertOnCacheDbTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'date': '2022/11/1',
        'event_id': '21',
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
      }
    ];

    var result = await dbHelper.getFromCacheDb();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table CacheTable", () async {
    await dbHelper.updateCacheDbTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'date': '2022/11/1',
        'event_id': '20',
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
      }
    ];

    var result = await dbHelper.getFromCacheDb();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table CacheTable", () async {
    var result = await dbHelper.deleteFromTableCacheDb();
    expect(result, null);
  });
}
