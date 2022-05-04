import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'nepali_patro_sql_package_test.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;

import 'test_parameter.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insert cache table", () async {
    List<prefix0.Event> events = cacheparameter;
    var actualOutput = await dbHelper.insertCache(events);
    dynamic expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getCacheByEventId", () async {
    var actualOutput =
        await dbHelper.getCacheByEventId(1, "2019-10-30T00:00:00.000");
    actualOutput = actualOutput
        .map((cacheItem) => {
              Cache.date: cacheItem[Cache.date],
              Cache.event_id: cacheItem[Cache.event_id]
            })
        .toList();

    var expectedOutput = [
      {
        Cache.date: '2019-10-30T00:00:00.000',
        Cache.event_id: '1',
      }
    ];
    expect(actualOutput, expectedOutput);

    await dbHelper.close();
  });
  test("getCachebetweenDates", () async {
    await dbHelper.insertEvents([eventsData], 'forceUpdate', false);
    var actualOutput = await dbHelper.getCachebetweenDates(
        DateTime.parse("2010-10-30"), DateTime.parse("2049-10-30"));
    dynamic expectedOutput = [
      Event(
          id: '1',
          parentEventId: '',
          title: 'hi title ',
          description: Utils.decryptData(
              "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
          startDate: DateTime.parse("2019-10-30"),
          gh: 0,
          imp: 0,
          calendar_id: '1',
          basedOn: "user",
          origid: -1)
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.deleteFromTableEvents();
    await dbHelper.close();
  });

  test("getCacheCount", () async {
    var actualOutput = await dbHelper.getCacheCount();
    actualOutput = actualOutput
        .map((cacheItem) => {
              Cache.date: cacheItem[Cache.date],
              Cache.event_id: cacheItem[Cache.event_id]
            })
        .toList();
    var expectedOutput = [
      {
        Cache.date: '2019-10-30T00:00:00.000',
        Cache.event_id: '1',
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getCachedYear", () async {
    var actualOutput = await dbHelper.getCachedYear("2010", "2030");
    var expectedOutput = [
      {'time': '2019'}
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getInvalidCache", () async {
    var actualOutput = await dbHelper.getInvalidCache(
        DateTime.parse("2019-09-20"), DateTime.parse("2029-10-30"),
        startAdDate: DateTime.parse("2019-10-30"));
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteSingleDateFromCache", () async {
    var actualOutput = await dbHelper.deleteSingleDateFromCache(
        '1', DateTime.parse("2019-10-30"));
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteAllDefaultCalCache", () async {
    var actualOutput = await dbHelper.deleteAllDefaultCalCache();
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteFutureDateFromCache", () async {
    var actualOutput = await dbHelper.deleteFutureDateFromCache(
        '1', DateTime.parse("2019-10-30"));
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteCache", () async {
    var actualOutput = await dbHelper.deleteCache('1');
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteNepaliCalendarCache", () async {
    var actualOutput = await dbHelper.deleteNepaliCalendarCache();
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Deleted From Table CacheTable", () async {
    var result = await dbHelper.deleteFromTableCacheDb();
    expect(result, null);
  });
}
