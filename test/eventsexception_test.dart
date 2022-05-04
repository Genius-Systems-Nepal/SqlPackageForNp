// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insertEventException", () async {
    List<dynamic> parameter = [
      {
        EventsExcDb.id: '1',
        EventsExcDb.exception_date: "2011-10-03",
        EventsExcDb.new_date: "2011-10-03",
        EventsExcDb.event_id: '1',
        EventsExcDb.created_at: "2011-10-03",
        EventsExcDb.updated_at: "2011-10-03",
        EventsExcDb.calendar_id: '1'
      }
    ];
    await dbHelper.insertEventException(parameter);
    var actualOutput = await dbHelper.getEventExceptionById(1);
    var expectedOutput = {
      EventsExcDb.id: '1',
      EventsExcDb.exception_date: '2011-10-03',
      EventsExcDb.new_date: '2011-10-03',
      EventsExcDb.event_id: '1',
      EventsExcDb.created_at: '2011-10-03',
      EventsExcDb.updated_at: '2011-10-03',
      EventsExcDb.calendar_id: '1'
    };
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getEventExceptionById", () async {
    var actualOutput = await dbHelper.getEventExceptionById(1);
    var expectedOutput = {
      EventsExcDb.id: '1',
      EventsExcDb.exception_date: '2011-10-03',
      EventsExcDb.new_date: '2011-10-03',
      EventsExcDb.event_id: '1',
      EventsExcDb.created_at: '2011-10-03',
      EventsExcDb.updated_at: '2011-10-03',
      EventsExcDb.calendar_id: '1'
    };
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteUserEvent", () async {
    Event event = Event(
        id: '1',
        parentEventId: '1',
        title: 'hi title ',
        description: Utils.decryptData(
            "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
        startDate: DateTime.parse("2019-10-30"),
        endDate: DateTime.parse("2019-10-30"),
        isFullDayEvent: 0,
        recurringEndDate: DateTime.parse("2019-10-30"),
        isRecurring: 1,
        createdBy: 'developer',
        hasReminder: 0,
        location: 'ktm',
        guests: const [],
        rsvp: 'hello rsvp',
        note: 'note one',
        eventPermission: null,
        visibility: 'visibility',
        privacy: 'privacy',
        status: 0,
        duration: 1,
        gh: 1,
        imp: 1,
        rrule: 'rule',
        deletedAt: "2019-10-30",
        createdAt: DateTime.parse("2019-10-30"),
        updatedAt: DateTime.now(),
        calendar_id: '1',
        basedOn: "user",
        rsvpStats: RsvpStats(guests: null),
        formattedRrule: FormattedRrule(),
        rsstart: DateTime.parse("2019-10-30"),
        origid: 22);
    var actualOutput = await dbHelper.deleteUserEvent(event);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteRemindersWithEventid", () async {
    await dbHelper.deleteRemindersWithEventid('1');
    dynamic actualOutput;
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("insertDeleteEvents", () async {
    Event event = Event(
        id: '1',
        parentEventId: '1',
        title: 'hi title ',
        description: Utils.decryptData(
            "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
        startDate: DateTime.parse("2019-10-30"),
        endDate: DateTime.parse("2019-10-30"),
        isFullDayEvent: 0,
        recurringEndDate: DateTime.parse("2019-10-30"),
        isRecurring: 1,
        createdBy: 'developer',
        hasReminder: 0,
        location: 'ktm',
        guests: [],
        rsvp: 'hello rsvp',
        note: 'note one',
        eventPermission: null,
        visibility: 'visibility',
        privacy: 'privacy',
        status: 0,
        duration: 1,
        gh: 1,
        imp: 1,
        rrule: 'rule',
        deletedAt: "2019-10-30",
        createdAt: DateTime.parse("2019-10-30"),
        updatedAt: DateTime.now(),
        calendar_id: '1',
        basedOn: "user",
        rsvpStats: RsvpStats(guests: null),
        formattedRrule: FormattedRrule(),
        rsstart: DateTime.parse("2019-10-30"),
        origid: 22);
    var actualOutput = await dbHelper.insertDeleteEvents(event);
    bool isInsertedRow = (actualOutput % 1) == 0;
    bool expectedOutput = true;
    expect(isInsertedRow, expectedOutput);
    await dbHelper.close();
  });
  test("deleteSingleDateFromCache", () async {
    var actualOutput =
        await dbHelper.deleteSingleDateFromCache('1', DateTime(2022));
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteuserEventById", () async {
    var actualOutput = await dbHelper.deleteuserEventById(1);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getCacheByEventId", () async {
    List<Map> actualOutput = await dbHelper.getCacheByEventId(1, "2011-10-03");
    actualOutput = actualOutput
        .map((cache) => {
              Cache.date: cache[Cache.date],
              Cache.event_id: cache[Cache.event_id]
            })
        .toList();
    dynamic expectedOutput = [
      {
        Cache.date: "2011-10-03",
        Cache.event_id: '1',
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("Deleted From Table Events Exception", () async {
    var result = await dbHelper.deleteFromTableExceptions();
    expect(result, null);
  });
}
