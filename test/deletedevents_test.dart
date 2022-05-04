import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/deleteEventModel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';
import 'test_parameter.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Deleted Events Table ', () async {
    dynamic events = Event(
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
        guests: const [],
        rsvp: null,
        note: 'note one',
        eventPermission: const [],
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
    await dbHelper.insertDeleteEvents(events);

    dynamic expectedOutput = [
      {
        'event_id': '1',
        'calendar_id': '1',
      }
    ];

    var actualOutput = await dbHelper.getFromDeletedEvent();
    actualOutput = actualOutput
        .map((deletedEventItem) => {
              DeleteEventsDB.event_id:
                  deletedEventItem[DeleteEventsDB.event_id],
              DeleteEventsDB.calendar_id:
                  deletedEventItem[DeleteEventsDB.calendar_id],
            })
        .toList();
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getSyncDeletedEvents", () async {
    List<DeletedEvents> getsyncdeletedEvent =
        await dbHelper.getSyncDeletedEvents(loadAll: true);
    var actualOutput = getsyncdeletedEvent[0].toJson();
    actualOutput.remove("id");
    actualOutput.remove("created_at");
    actualOutput.remove("updated_at");
    dynamic expectedOutput = {
      DeleteEventsDB.event_id: '1',
      DeleteEventsDB.calendar_id: '1',
    };
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getSyncPendingDeletedEvents", () async {
    await dbHelper.insertEventException(eventexception);
    var actualOutput = await dbHelper.getSyncPendingDeletedEvents(
        loadAll: false, synctimestamps: "2020-10-03");
    dynamic expectedOutput = [
      {
        EventsExcDb.id: '1',
        EventsExcDb.exception_date: '2011-10-03 05:45:00',
        EventsExcDb.new_date: '2011-10-03',
        EventsExcDb.event_id: '1',
        EventsExcDb.created_at: '2011-10-03 05:45:00',
        EventsExcDb.updated_at: '2011-10-03 05:45:00'
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.deleteFromTableExceptions();
    await dbHelper.close();
  });

  test("Deleted From Table Deleted Events", () async {
    var result = await dbHelper.deleteFromTableDeletedEvent();
    expect(result, null);
  });
}
