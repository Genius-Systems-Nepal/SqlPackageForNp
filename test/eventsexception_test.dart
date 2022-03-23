import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Events Exception Table ', () async {
    Map<String, dynamic> parameter = {
      'id': '1',
      'exception_date': '2022/11/1',
      'new_date': '2022/11/1',
      'event_id': '10',
      'created_at': '2022/11/1',
      'updated_at': '2022/11/1',
      'calendar_id': 'calendarid',
    };
    await dbHelper.insertOnExceptionsTable(parameter);
    dynamic getvalue = [
      {
        'id': '1',
        'exception_date': '2022/11/1',
        'new_date': '2022/11/1',
        'event_id': '10',
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
        'calendar_id': 'calendarid'
      }
    ];

    var result = await dbHelper.getFromExceptions();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Events Exception", () async {
    await dbHelper.updateExceptionsTable();
    dynamic getUpdatedvalue = [
      {
        'id': '1',
        'exception_date': '2022/11/1',
        'new_date': '2022/11/1',
        'event_id': '20',
        'created_at': '2022/11/1',
        'updated_at': '2022/11/1',
        'calendar_id': 'calendarid',
      }
    ];

    var result = await dbHelper.getFromExceptions();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Events Exception", () async {
    var result = await dbHelper.deleteFromTableExceptions();
    expect(result, null);
  });
}
