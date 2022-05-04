// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable, await_only_futures

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/decoder.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'nepali_patro_sql_package_test.dart';
import 'test_parameter.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Events ', () async {
    List<dynamic> events = [eventsData];
    await dbHelper.insertEvents(events, 'forceUpdate', false);
    List<Event> expectedOutput = [eventsDataWithdecriptDesc];
    List<Event> actualOutput = await dbHelper.getEvents();
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("testDecoder", () async {
    var res =
        await APIResponseDecoder.zipDecode(File("lib/api/calendar/sync.json"));

    assert(true);
  });

  test("getCalendarEventbyId", () async {
    var actualOutput = await dbHelper.getCalendarEventbyId("1");
    dynamic expectedOutput = eventsDataWithdecriptDesc;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getEvents", () async {
    var actualOutput = await dbHelper.getEvents();
    dynamic expectedOutput = [eventsDataWithdecriptDesc];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEventByIdWithDate", () async {
    var actualOutput =
        await dbHelper.getEventByIdWithDate(1, "2019-10-30 00:00:00.000");
    dynamic expectedOutput = Event(
        id: '1',
        parentEventId: '1',
        title: 'hi title ',
        description:
            "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0=",
        startDate: DateTime.parse("2019-10-30"),
        endDate: DateTime.parse("2019-10-30"),
        isFullDayEvent: 0,
        recurringEndDate: DateTime.parse("2019-10-30"),
        isRecurring: 1,
        createdBy: 'developer',
        hasReminder: 0,
        location: 'ktm',
        guests: null,
        rsvp: null,
        note: 'note one',
        eventPermission: [],
        visibility: 'visibility',
        privacy: 'privacy',
        status: 0,
        duration: 1,
        gh: 0,
        imp: 0,
        rrule: 'rule',
        deletedAt: "2019-10-30",
        createdAt: DateTime.parse("2019-10-30"),
        updatedAt: DateTime.parse("2019-10-30"),
        calendar_id: '1',
        basedOn: "user",
        rsvpStats: null,
        formattedRrule: null,
        rsstart: DateTime.parse("2019-10-30"),
        origid: 22);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEventToday", () async {
    await dbHelper.insertCache(cacheparameter);
    var time = DateTime.parse("2019-10-30 00:00:00.000");
    List<Event> actualOutput = await dbHelper.getEventToday(time);
    dynamic expectedOutput = [
      Event(
          id: '1',
          parentEventId: '',
          title: 'hi title ',
          description: Utils.decryptData(
              "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
          startDate: DateTime.parse("2019-10-30"),
          endDate: DateTime.parse("2019-10-30"),
          isFullDayEvent: null,
          recurringEndDate: null,
          isRecurring: null,
          createdBy: null,
          hasReminder: null,
          location: null,
          guests: null,
          rsvp: null,
          note: null,
          eventPermission: null,
          visibility: null,
          privacy: null,
          status: null,
          duration: null,
          gh: 0,
          imp: 0,
          rrule: null,
          deletedAt: null,
          createdAt: null,
          updatedAt: null,
          calendar_id: '1',
          basedOn: null,
          rsvpStats: null,
          formattedRrule: null,
          rsstart: null,
          origid: -1)
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("disableUserEvent", () async {
    var event = Event(
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
    var actualOutput = await dbHelper.disableUserEvent(event);
    dynamic expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("updateUserEventsAuthority", () async {
    var actualOutput = await dbHelper.updateUserEventsAuthority(1, 2);
    bool expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getUserevents", () async {
    var actualOutput =
        await dbHelper.getUserevents(1, status: 1, calendarId: '1');
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getCalendarEventsByIds", () async {
    List<Event> actualOutput = await dbHelper.getCalendarEventsByIds('1');
    var finalOutput = await actualOutput[0].toJson();
    finalOutput.remove("updated_at");
    finalOutput.remove("start_date");
    finalOutput.remove("end_date");
    finalOutput.remove("recurring_end_date");
    finalOutput.remove("created_at");
    finalOutput.remove("guests");
    finalOutput.remove("rsvp_stats");
    finalOutput.remove("rrule");
    finalOutput.remove("rsstart");
    dynamic expectedOutput = {
      EventsDb.id: '1',
      EventsDb.parent_event_id: '1',
      EventsDb.title: 'hi title ',
      EventsDb.description: Utils.decryptData(
          "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
      EventsDb.is_full_day_event: 0,
      EventsDb.is_recurring: 1,
      EventsDb.created_by: 'developer',
      EventsDb.has_reminder: 0,
      EventsDb.location: 'ktm',
      EventsDb.rsvp: null,
      EventsDb.note: 'note one',
      EventsDb.event_permission: null,
      EventsDb.visibility: 'visibility',
      EventsDb.privacy: 'privacy',
      EventsDb.status: 1,
      EventsDb.duration: 1,
      EventsDb.gh: 1,
      EventsDb.important_event: 1,
      EventsDb.deleted_at: "2019-10-30",
      EventsDb.calendar_id: '1',
      EventsDb.based_on: "user",
      EventsDb.formatted_rrule: null,
      EventsDb.origid: 22
    };
    expect(finalOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getExpiredNonRepeatingEvents", () async {
    var actualOutput = await dbHelper.getExpiredNonRepeatingEvents(
        status: '1', calendarId: '1');
    var expectOutput = [];
    expect(actualOutput, expectOutput);
    await dbHelper.close();
  });
  test("getActiveNonRepeatingEvents", () async {
    var actualOutput =
        await dbHelper.getActiveNonRepeatingEvents(calendarId: '1', status: 1);
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getExpiredEvents", () async {
    var actualOutput =
        await dbHelper.getExpiredEvents(calendarId: '1', status: '1');
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getActiveEvents", () async {
    var actualOutput =
        await dbHelper.getActiveEvents(calendarId: '1', status: '1');
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getSearchEvents", () async {
    List<Event> actualOutput = await dbHelper.getSearchEvents('hi');
    var finalOutput = await actualOutput[0].toJson();
    finalOutput.remove("updated_at");
    finalOutput.remove("start_date");
    finalOutput.remove("end_date");
    finalOutput.remove("recurring_end_date");
    finalOutput.remove("created_at");
    finalOutput.remove("guests");
    finalOutput.remove("rsvp_stats");
    finalOutput.remove("rrule");
    finalOutput.remove("rsstart");
    dynamic expectedOutput = {
      EventsDb.id: '1',
      EventsDb.parent_event_id: '1',
      EventsDb.title: 'hi title ',
      EventsDb.description: Utils.decryptData(
          "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
      EventsDb.is_full_day_event: 0,
      EventsDb.is_recurring: 1,
      EventsDb.created_by: 'developer',
      EventsDb.has_reminder: 0,
      EventsDb.location: 'ktm',
      EventsDb.rsvp: null,
      EventsDb.note: 'note one',
      EventsDb.event_permission: null,
      EventsDb.visibility: 'visibility',
      EventsDb.privacy: 'privacy',
      EventsDb.status: 1,
      EventsDb.duration: 1,
      EventsDb.gh: 1,
      EventsDb.important_event: 1,
      EventsDb.deleted_at: "2019-10-30",
      EventsDb.calendar_id: '1',
      EventsDb.based_on: "user",
      EventsDb.formatted_rrule: null,
      EventsDb.origid: 22
    };

    expect(finalOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getAllUserEvents", () async {
    var actualOutput = await dbHelper.getAllUserEvents();
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getSyncPendingEvents", () async {
    var actualOutput = await dbHelper.getSyncPendingEvents();
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEventsbetweenDates", () async {
    var actualOutput =
        await dbHelper.getEventsbetweenDates('2019-01-30', '2019-11-30');
    var expectedOutput = [];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Deleted From Table Events", () async {
    var result = await dbHelper.deleteFromTableEvents();
    expect(result, null);
  });
}
