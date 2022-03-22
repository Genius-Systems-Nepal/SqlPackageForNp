import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Events ', () async {
    Map<String, dynamic> parameter = {
      'id': '1',
      'parent_event_id': 1,
      'title': 'hi title',
      'description': 'typeone',
      'start_date': '2022/11/1',
      'end_date': '2022/11/1',
      'is_full_day_event': '2024/11/1',
      'recurring_end_date': '2022/11/1',
      'is_recurring': 1,
      'created_by': '2022/3/21',
      'has_reminder': 0,
      'location': 'location',
      'guests': 'hi guests',
      'rsvp': 'hi revp',
      'note': "hi note",
      'event_permission': 'event_permission',
      'visibility': 'hi visibility',
      'privacy': 'privacy',
      'status': 0,
      'duration': 1,
      'gh': 1,
      'important_event': 1,
      'rrule': 'rrule',
      'deleted_at': '2022/11/1',
      'created_at': '2022/2/2',
      'updated_at': '2022/2/2',
      'calendar_id': 1,
      'based_on': 'based on',
      'rsvp_stats': 'rsvp_stats',
      'formatted_rrule': 'formatted_rrule',
      'rsstart': 'rsstart',
      'origid': 22
    };
    await dbHelper.insertOnEventsTable(parameter);
    dynamic getvalue = [
      {
        'id': '1',
        'parent_event_id': 1,
        'title': 'hi title',
        'description': 'typeone',
        'start_date': '2022/11/1',
        'end_date': '2022/11/1',
        'is_full_day_event': '2024/11/1',
        'recurring_end_date': '2022/11/1',
        'is_recurring': 1,
        'created_by': '2022/3/21',
        'has_reminder': 0,
        'location': 'location',
        'guests': 'hi guests',
        'rsvp': 'hi revp',
        'note': "hi note",
        'event_permission': 'event_permission',
        'visibility': 'hi visibility',
        'privacy': 'privacy',
        'status': 0,
        'duration': 1,
        'gh': 1,
        'important_event': 1,
        'rrule': 'rrule',
        'deleted_at': '2022/11/1',
        'created_at': '2022/2/2',
        'updated_at': '2022/2/2',
        'calendar_id': 1,
        'based_on': 'based on',
        'rsvp_stats': 'rsvp_stats',
        'formatted_rrule': 'formatted_rrule',
        'rsstart': 'rsstart',
        'origid': 22
      }
    ];

    var result = await dbHelper.getFromEvents();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Events", () async {
    await dbHelper.updateEventsTable();
    dynamic getUpdatedvalue = [
      {
        'id': '1',
        'parent_event_id': 10,
        'title': 'hi title',
        'description': 'typeone',
        'start_date': '2022/11/1',
        'end_date': '2022/11/1',
        'is_full_day_event': '2024/11/1',
        'recurring_end_date': '2022/11/1',
        'is_recurring': 1,
        'created_by': '2022/3/21',
        'has_reminder': 0,
        'location': 'location',
        'guests': 'hi guests',
        'rsvp': 'hi revp',
        'note': "hi note",
        'event_permission': 'event_permission',
        'visibility': 'hi visibility',
        'privacy': 'privacy',
        'status': 0,
        'duration': 1,
        'gh': 1,
        'important_event': 1,
        'rrule': 'rrule',
        'deleted_at': '2022/11/1',
        'created_at': '2022/2/2',
        'updated_at': '2022/2/2',
        'calendar_id': 1,
        'based_on': 'based on',
        'rsvp_stats': 'rsvp_stats',
        'formatted_rrule': 'formatted_rrule',
        'rsstart': 'rsstart',
        'origid': 22
      }
    ];

    var result = await dbHelper.getFromEvents();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Events", () async {
    var result = await dbHelper.deleteFromTableEvents();
    expect(result, null);
  });
}
