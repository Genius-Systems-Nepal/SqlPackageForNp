import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Details Forex Table ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'pid': 1,
      'type': 'hi type',
      'code': 'typeone',
      'currency': 'www.google.com.np',
      'unit': '2022/11/1',
      'buying': 'hello buying',
      'selling': 'hello selling',
    };
    await dbHelper.insertOnForexDetailsTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'pid': 1,
        'type': 'hi type',
        'code': 'typeone',
        'currency': 'www.google.com.np',
        'unit': '2022/11/1',
        'buying': 'hello buying',
        'selling': 'hello selling',
      }
    ];

    var result = await dbHelper.getFromForexDetails();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Details Forex", () async {
    await dbHelper.updateForexDetailsTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'pid': 10,
        'type': 'hi type',
        'code': 'typeone',
        'currency': 'www.google.com.np',
        'unit': '2022/11/1',
        'buying': 'hello buying',
        'selling': 'hello selling',
      }
    ];

    var result = await dbHelper.getFromForexDetails();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Details Forex", () async {
    var result = await dbHelper.deleteFromTableForexDetails();
    expect(result, null);
  });
}
