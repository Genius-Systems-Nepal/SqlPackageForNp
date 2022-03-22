import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From AMessage ', () async {
    Map<String, dynamic> parameter = {
      'id': '1',
      'message_np': 'hi np',
      'message_en': 'hi en',
      'linktype': 'typeone',
      'link': 'www.google.com.np',
      'stdate': '2022/11/1',
      'expiry': '2024/11/1',
      'aflag': 'hi flag',
      'pin': '2222',
      'createdAt': '2022/3/21',
      'enable': 'yes',
      'options': 'hi option',
      'dorder': 'hi dorder',
      'cancelled': 1
    };
    await dbHelper.insertOnMessageTable(parameter);
    dynamic getvalue = [
      {
        'id': '1',
        'message_np': 'hi np',
        'message_en': 'hi en',
        'linktype': 'typeone',
        'link': 'www.google.com.np',
        'stdate': '2022/11/1',
        'expiry': '2024/11/1',
        'aflag': 'hi flag',
        'pin': '2222',
        'createdAt': '2022/3/21',
        'enable': 'yes',
        'options': 'hi option',
        'dorder': 'hi dorder',
        'cancelled': 1
      }
    ];

    var result = await dbHelper.getFromMessage();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table AMessage", () async {
    await dbHelper.updateMessageTable();
    dynamic getUpdatedvalue = [
      {
        'id': '1',
        'message_np': 'hi np',
        'message_en': 'hi en',
        'linktype': 'typeone',
        'link': 'www.google.com.np',
        'stdate': '2022/11/1',
        'expiry': '2024/11/1',
        'aflag': 'hi flag',
        'pin': '2222',
        'createdAt': '2022/3/21',
        'enable': 'yes',
        'options': 'hi option',
        'dorder': 'hi dorder',
        'cancelled': 0
      }
    ];

    var result = await dbHelper.getFromMessage();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table AMessage", () async {
    var result = await dbHelper.deleteFromTableMessage();
    expect(result, null);
  });
}
