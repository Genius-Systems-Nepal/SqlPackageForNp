import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/decoder.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'nepali_patro_sql_package_test.dart';
import 'dart:convert' show utf8;

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Events ', () async {
    // Event.fromJson()
    List<dynamic> events = [
      Event(
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
          guests: [],
          rsvp: null,
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
          updatedAt: DateTime.parse("2019-10-30"),
          calendar_id: '1',
          basedOn: "user",
          rsvpStats: RsvpStats(guests: null),
          formattedRrule: FormattedRrule(),
          rsstart: DateTime.parse("2019-10-30"),
          origid: 22)
    ];
    await dbHelper.insertEvents(events, 'forceUpdate', false);

    dynamic expectedOutput = [
      Event(
          id: '1',
          parentEventId: '1',
          title: 'hi title ',
          description: Utils.decryptData(
              "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
          // description: "{" ":" "}",
          // description:
          //     '{"jnid":"426","jct":"","ne":"\u092d\u0940\u0937\u094d\u092e\u093e\u0937\u094d\u091f\u092e\u0940 \u0935\u094d\u0930\u0924","en":"Bhismastami Brata","jiu":"","jis":"","jbi":"","jie":"","jbd":""}',
          startDate: DateTime.parse("2019-10-30"),
          endDate: DateTime.parse("2019-10-30"),
          isFullDayEvent: 0,
          recurringEndDate: DateTime.parse("2019-10-30"),
          isRecurring: 1,
          createdBy: 'developer',
          hasReminder: 0,
          location: 'ktm',
          guests: [],
          rsvp: null,
          note: 'note one',
          eventPermission: [],
          visibility: 'visibility',
          privacy: 'privacy',
          status: 0,
          duration: 1,
          gh: 1,
          imp: 1,
          rrule: 'rule',
          deletedAt: "2019-10-30",
          createdAt: DateTime.parse("2019-10-30"),
          updatedAt: DateTime.parse("2019-10-30"),
          calendar_id: '1',
          basedOn: "user",
          rsvpStats: RsvpStats(guests: []),
          formattedRrule: FormattedRrule(),
          rsstart: DateTime.parse("2019-10-30"),
          origid: 22)
    ];
    var actualOutput = await dbHelper.getEvents();
    print(actualOutput);
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
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getEvents", () async {
    var actualOutput = await dbHelper.getEvents();
    var expectedOutput = [];
    // var expectedOutput = [
    //        Event(id:"1",
    //  parentEventId: "1",title: "hi title",description: "{jnid:426, jct:"",ne:"\u092d\u0940\u0937\u094d\u092e\u093e\u0937\u094d\u091f\u092e\u0940 \u0935\u094d\u0930\u0924","en":"Bhismastami Brata","jiu":"","jis":"","jbi":"","jie":"","jbd":""}", startDate:DateTime.parse("2019-10-30 00:00:00.000"), endDate:DateTime.parse("2019-10-30 00:00:00.000"),isFullDayEvent: 0,recurringEndDate:DateTime.parse("2019-10-30 00:00:00.000"),isRecurring: 1,createdBy: "developer",hasReminder: 0, location:  "ktm",guests: [],rsvp: null, note: "note one",eventPermission: [],visibility:"visibility",privacy:"privacy",status: 0,duration: 1,gh: 0,imp: 0,rrule: "rule",deletedAt: 2019-10-30,createdAt:DateTime.parse("2019-10-30 00:00:00.000") ,updatedAt:DateTime.parse("2019-10-30 00:00:00.000"),calendar_id:  "1",basedOn: "user",rsvpStats: null,formattedRrule: null, rsstart: DateTime.parse("2019-10-30 00:00:00.000"),origid:22)];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEventByIdWithDate", () async {
    var actualOutput = await dbHelper.getEventByIdWithDate(1, "2022-01-2");
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEventToday", () async {
    var time = DateTime.parse("2022-04-12 00:00:00.000");
    var actualOutput = await dbHelper.getEventToday(time);
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("disableUserEvent", () async {
    var event = Event(
        id: '1',
        parentEventId: '1',
        title: 'hi title ',
        // description:
        //     "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0=",
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
  test("deleteuserEventById", () async {
    var actualOutput = await dbHelper.deleteuserEventById(1);
    var expectedOutput = await dbHelper.getCalendarEventbyId("1");
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("updateUserEventsAuthority", () async {
    var actualOutput = await dbHelper.updateUserEventsAuthority(1, 2);
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getUserevents", () async {
    var actualOutput = await dbHelper.getUserevents(1);
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getCalendarEventsByIds", () async {
    var actualOutput = await dbHelper.getCalendarEventsByIds('1');
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getExpiredNonRepeatingEvents", () async {
    var actualOutput = await dbHelper.getExpiredNonRepeatingEvents(
        status: '1', calendarId: '1');
    var expectOutput;
    expect(actualOutput, expectOutput);
    await dbHelper.close();
  });
  test("getActiveNonRepeatingEvents", () async {
    var actualOutput =
        await dbHelper.getActiveNonRepeatingEvents(calendarId: '1', status: 1);
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getExpiredEvents", () async {
    var actualOutput =
        await dbHelper.getExpiredEvents(calendarId: '1', status: '1');
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getActiveEvents", () async {
    var actualOutput =
        await dbHelper.getActiveEvents(calendarId: '1', status: '1');
    var expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getSearchEvents", () async {
    var actualOutput = await dbHelper.getSearchEvents('hi');
    var expectedOutput;
    expect(actualOutput, expectedOutput);
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
