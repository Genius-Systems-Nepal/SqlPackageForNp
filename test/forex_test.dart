import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/forexmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insertToForexDetail", () async {
    ForexModel model = ForexModel(
        date: "2022-01-03",
        source: "intUrl",
        sourceUrl: "www.google.com",
        data: [
          Datum(
              code: "001",
              buying: "200",
              currency: "NPL",
              type: "cash",
              selling: "220",
              unit: '2')
        ]);
    var actualOutput = await dbHelper.insertToForexDetail(1, model);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("insertForex", () async {
    ForexModel model = ForexModel(
        date: "2022-01-03",
        source: "intUrl",
        sourceUrl: "www.google.com",
        data: [
          Datum(
              code: "001",
              buying: "200",
              currency: "NPL",
              type: "cash",
              selling: "220",
              unit: '2')
        ]);
    var actualOutput = await dbHelper.insertForex(model);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("forexCount", () async {
    var actualOutput = await dbHelper.forexCount();
    var expectedOut = 1;
    expect(actualOutput, expectedOut);
    await dbHelper.close();
  });

  test("getForex", () async {
    var actualOutput = await dbHelper.getForex();
    var expecedOutput = 1;
    expect(actualOutput, expecedOutput);
    await dbHelper.close();
  });
  test("latestForex", () async {
    var actualOutput = await dbHelper.latestForex();
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getForexDetail", () async {
    var actualOutput = await dbHelper.getForexDetail(1);
    actualOutput = actualOutput[0];
    var expectedOutput = Datum(
        type: "cash",
        code: '001',
        currency: "NPL",
        unit: '2',
        buying: '200',
        selling: '220');
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteForex", () async {
    var actualOutput = await dbHelper.deleteForex("2022-01-03");
    var expecedOutput = true;
    expect(actualOutput, expecedOutput);
    await dbHelper.close();
  });

  test("DeleteForexDetails", () async {
    var actualOutput = await dbHelper.deleteForexDetails();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
}
