import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Panchanga ', () async {
    String np = 'np';
    String en = 'en';
    String ddNp = 'ddnp';
    String ddEn = 'dden';
    String date = 'date';

    await dbHelper.insertPanchangaData(np, en, ddNp, ddEn, date);
    dynamic expectedOutput = [
      {
        'id': 1,
        'date': 'date',
        'text_np': 'np',
        'text_en': 'en',
        'text_ddnp': 'ddnp',
        'text_dden': 'dden'
      }
    ];

    var actualOutput = await dbHelper.getPanchangaByDate(
      'date',
    );
    // expectedOutput["id"] = actualOutput["id"];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Get Panchanga By Date", () async {
    var actualOutput = await dbHelper.getPanchangaByDate('date');
    dynamic expectedOutput = [
      {
        'id': 1,
        'date': 'date',
        'text_np': 'np',
        'text_en': 'en',
        'text_ddnp': 'ddnp',
        'text_dden': 'dden'
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Deleted From Table PanchangaDb", () async {
    var result = await dbHelper.deleteFromTablePanchangaDb();
    expect(result, null);
  });
}
