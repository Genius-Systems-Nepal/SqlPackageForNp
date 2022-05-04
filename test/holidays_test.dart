import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/holidaysmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insertHolidays", () async {
    List<HolidaysModel>? model = [
      HolidaysModel(
        id: 1,
        eventId: '1',
        eventDate: DateTime.parse("2019-09-20"),
        holidayType: "gov",
        status: 1,
        createdAt: DateTime.parse("2019-09-20"),
        updatedAt: DateTime.parse("2020-09-20"),
        deletedAt: null,
      )
    ];
    HolidaysList parameter = HolidaysList(holidaysList: model);
    await dbHelper.insertHolidays(parameter);
    var actualOutput = await dbHelper.getFromHolidays();
    dynamic expectedOutput = [
      {
        HolidaysDb.id: 1,
        HolidaysDb.eventId: '1',
        HolidaysDb.eventDate: '2019-09-20T00:00:00.000',
        HolidaysDb.holidayType: 'gov',
        HolidaysDb.status: 1,
        HolidaysDb.createdAt: '2019-09-20T00:00:00.000',
        HolidaysDb.updatedAt: '2020-09-20T00:00:00.000',
        HolidaysDb.deletedAt: ''
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getAllHolidays", () async {
    var actualOutput = await dbHelper.getAllHolidays(
        DateTime.parse("2011-10-30"), DateTime.parse("2029-10-30"));
    dynamic expectedOutput = [
      HolidaysModel(
          id: 1,
          eventId: "1",
          eventDate: DateTime.parse("2019-09-20"),
          holidayType: "gov",
          status: 1,
          createdAt: DateTime.parse("2019-09-20"),
          updatedAt: DateTime.parse("2020-09-20"),
          deletedAt: '')
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getGovernmentHolidaysFromWeb", () async {
    var actualOutput = await dbHelper.getGovernmentHolidaysFromWeb(
        DateTime.parse("2011-10-30"), DateTime.parse("2029-10-30"));
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getGovernmentHolidays", () async {
    var actualOutput = await dbHelper.getGovernmentHolidays(
        DateTime.parse("2011-10-30"), DateTime.parse("2029-10-30"));
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteHolidays", () async {
    var actualOutput = await dbHelper.deleteHolidays();
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Deleted From Table Holidays", () async {
    var actualOutput = await dbHelper.deleteFromTableHolidays();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
}
