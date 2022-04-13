import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

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
    Np expectedOuput = Np(
        type: 'HelloDevp',
        title: 'heloTest',
        author: 'Test author',
        lang: 'en',
        aries: 'aries',
        taurus: null,
        gemini: null,
        cancer: null,
        leo: null,
        virgo: null,
        libra: null,
        scorpio: null,
        sagittarius: null,
        capricorn: null,
        aquarius: null,
        pisces: null,
        todate: null);
    var actualOutput = await dbHelper.getFromRasifal('HelloDevp');
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });
  test("Get data From Rashifal table", () async {
    var actualOutput = await dbHelper.getFromRasifal('HelloDevp');
    Np expectedOuput = Np(
        type: 'HelloDevp',
        title: 'heloTest',
        author: 'Test author',
        lang: 'en',
        aries: 'aries',
        taurus: null,
        gemini: null,
        cancer: null,
        leo: null,
        virgo: null,
        libra: null,
        scorpio: null,
        sagittarius: null,
        capricorn: null,
        aquarius: null,
        pisces: null,
        todate: null);
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });
  test("Deleted From Table Rasifal", () async {
    var actualOutput = await dbHelper.deleteFromtableRasifal("HelloDevp");
    dynamic expectedOuput;
    expect(actualOutput, expectedOuput);
  });
}
