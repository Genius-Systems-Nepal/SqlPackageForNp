import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';
import 'test_parameter.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;

  test('Insert Data From Rasifal ', () async {
    List<Np> model = [
      Np(
        type: 'HelloDevp',
        title: 'heloTest',
        author: 'Test author',
        lang: 'en',
        aries: 'aries',
      )
    ];
    await dbHelper.insertRasifal(model);
    Np expectedOuput = rashifal;
    var actualOutput = await dbHelper.getRashifalByTag('HelloDevp');
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });
  test("Get data From Rashifal table", () async {
    var actualOutput = await dbHelper.getRashifalByTag('HelloDevp');
    Np expectedOuput = rashifal;
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });
  test("clearRashifal", () async {
    var actualOutput = await dbHelper.clearRashifal();
    var expectedOutput = 1;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
}
