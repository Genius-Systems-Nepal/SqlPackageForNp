import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('InsertPanchanga ', () async {
    String np = 'np';
    String en = 'en';
    String ddNp = 'ddnp';
    String ddEn = 'dden';
    String date = 'date';
    await dbHelper.insertPanchangaData(np, en, ddNp, ddEn, date);
    List<Map<dynamic, dynamic>> expectedOutput = [
      {
        PanchangaDb.date: 'date',
        PanchangaDb.text_np: 'np',
        PanchangaDb.text_en: 'en',
        PanchangaDb.text_ddnp: 'ddnp',
        PanchangaDb.text_dden: 'dden'
      }
    ];

    var actualOutput = await dbHelper.getPanchangaByDate('date');
    actualOutput = actualOutput.map((panchanga) => {
          PanchangaDb.date: panchanga[PanchangaDb.date],
          PanchangaDb.text_np: panchanga[PanchangaDb.text_np],
          PanchangaDb.text_en: panchanga[PanchangaDb.text_en],
          PanchangaDb.text_ddnp: panchanga[PanchangaDb.text_ddnp],
          PanchangaDb.text_dden: panchanga[PanchangaDb.text_dden],
        });
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getPanchangaByDate", () async {
    var actualOutput = await dbHelper.getPanchangaByDate('date');
    var expectedOutput = [
      {
        PanchangaDb.date: 'date',
        PanchangaDb.text_np: 'np',
        PanchangaDb.text_en: 'en',
        PanchangaDb.text_ddnp: 'ddnp',
        PanchangaDb.text_dden: 'dden'
      }
    ];
    actualOutput = actualOutput.map((panchanga) => {
          PanchangaDb.date: panchanga[PanchangaDb.date],
          PanchangaDb.text_np: panchanga[PanchangaDb.text_np],
          PanchangaDb.text_en: panchanga[PanchangaDb.text_en],
          PanchangaDb.text_ddnp: panchanga[PanchangaDb.text_ddnp],
          PanchangaDb.text_dden: panchanga[PanchangaDb.text_dden],
        });
    expect(actualOutput, expectedOutput);

    await dbHelper.close();
  });

  test("deleteFromTablePanchangaDb", () async {
    var actualOutput = await dbHelper.deleteFromTablePanchangaDb();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
  });
}
