// ignore_for_file: unnecessary_null_comparison, prefer_conditional_assignment

import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/deleteEventModel.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/recurrencerulehelper.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;
import 'package:uuid/uuid.dart';

class DeletedEventQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future deleteFromTableDeletedEvent() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_DELETE_EVENTS');
  }

  Future<List<Map<String, dynamic>>?> getFromDeletedEvent() async {
    Database? db = await databaseHelper.database;
    var query =
        "select * from $DB_TABLE_DELETE_EVENTS where event_id= '1' limit 0, 1";
    return await db?.rawQuery(query);
  }

  Future<int?> insertDeleteEvents(prefix0.Event event) async {
    Database? db = await databaseHelper.database;
    await databaseHelper.initializeTimeZone();
    var deletedEvents = DeletedEvents(
        id: null,
        eventId: event.id,
        calendarId: event.calendar_id,
        createdAt: event.createdAt,
        updatedAt: Timezone().curDateTimeByZone("NPT"));
    return await db?.insert(DB_TABLE_DELETE_EVENTS, deletedEvents.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  deleteSingleEventOnly(prefix0.Event event) async {
    try {
      Database? db = await databaseHelper.database;
      var uuid = const Uuid();
      var id = uuid.v1();
      var eventExceptionItem = EventExceptionModel(
          id: id,
          exceptionDate: event.startDate,
          eventId: event.id,
          createdDate: event.createdAt,
          updatedDate: Timezone().curDateTimeByZone("NPT"),
          calendarId: event.calendar_id);
      try {
        /*await db.delete(DB_TABLE_CACHE,
            where: "event_id = ? AND date = ?",
            whereArgs: [event.id, event.startDate.toIso8601String()]);*/
        var query =
            "DELETE FROM $DB_TABLE_CACHE WHERE event_id = '${event.id}' and Date(date) = Date('${event.startDate?.toIso8601String()}')";
        await db?.rawQuery(query);
      } catch (e) {
        Utils.debugLog(e);
      }
      await db?.insert(DB_TABLE_EVENTS_EXCEPTION, eventExceptionItem.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DeletedEvents>> getSyncDeletedEvents(
      {loadAll = false, String? synctimestamps}) async {
    try {
      Database? db = await databaseHelper.database;
      var results = <Map<String, dynamic>>[];
      if (!loadAll) {
        var timestamp = synctimestamps ??
            PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
        results = await db!.query(DB_TABLE_DELETE_EVENTS,
            where: "updated_at>=?", whereArgs: [timestamp]);
      } else {
        results = await db!.query(DB_TABLE_DELETE_EVENTS);
      }

      var deletedEventList = results
          .map((Map model) => DeletedEvents.fromJson(model.cast()))
          .toList();
      return deletedEventList;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<List<Map>> getSyncPendingDeletedEvents(
      {loadAll = false, String? synctimestamps}) async {
    try {
      Database? db = await databaseHelper.database;
      await databaseHelper.initializeTimeZone();
      List<Map> resultLists = [];
      if (!loadAll) {
        var timeStamp = synctimestamps ??
            PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
        List<Map> results = [];
        if (timeStamp != null) {
          results = await db!.query(DB_TABLE_EVENTS_EXCEPTION, columns: [
            EventsExcDb.id,
            EventsExcDb.exception_date,
            EventsExcDb.new_date,
            EventsExcDb.event_id,
            EventsExcDb.created_at,
            EventsExcDb.updated_at,
          ]);
        } else {
          results = await db!.query(DB_TABLE_EVENTS_EXCEPTION,
              columns: [
                EventsExcDb.id,
                EventsExcDb.exception_date,
                EventsExcDb.new_date,
                EventsExcDb.event_id,
                EventsExcDb.created_at,
                EventsExcDb.updated_at,
              ],
              where: "updated_at>=?",
              whereArgs: [timeStamp]);
        }
        for (Map resultItem in results) {
          Map resultingMap = {};
          resultItem.forEach((key, value) {
            if (key == "updated_at") {
              DateTime updateTime = CalendarUtils.getCalendarFromString(value);
              resultingMap.putIfAbsent(key,
                  () => CalendarUtils.formatCalendar(updateTime, DATE_FORMAT));
            } else if (key == "created_at") {
              DateTime createdTime = CalendarUtils.getCalendarFromString(value);
              resultingMap.putIfAbsent(key,
                  () => CalendarUtils.formatCalendar(createdTime, DATE_FORMAT));
            } else if (key == "exception_date") {
              DateTime exceptionDate =
                  CalendarUtils.getCalendarFromString(value);
              resultingMap.putIfAbsent(
                  key,
                  () =>
                      CalendarUtils.formatCalendar(exceptionDate, DATE_FORMAT));
            } else {
              resultingMap.putIfAbsent(key, () => value);
            }
          });
          resultLists.add(resultingMap);
        }

        return resultLists;
      }
      return [];
    } catch (e) {
      Utils.debugLog(e);
      return [];
    }
  }

  Future<List<prefix0.Event>> getRepetitionEventsforMonth(startDate, endDate,
      {preCalendarId = "", isBackground = true}) async {
    try {
      Database? db = await databaseHelper.database;
      List<prefix0.Event> tempEventsLists = [];
      List<dynamic> repetitionDates = [];
      var calendarIds = await databaseHelper.getEnabledCalendars();
      if (preCalendarId.toString().isNotEmpty) calendarIds = preCalendarId;

//      var now = Timezone().curDateTimeByZone("NPT");
      var query =
          "SELECT * FROM $DB_TABLE_EVENTS WHERE rrule IS NOT NULL AND TRIM(rrule,' ') != '' "
          "AND calendar_id IN ($calendarIds) AND recurring_end_date>='$startDate' AND status != 0 ORDER BY start_date ASC";
//      var query =
//          "SELECT * FROM $DB_TABLE_EVENTS WHERE rrule IS NOT NULL AND TRIM(rrule,' ') != '' "
//          "AND calendar_id IN ($calendarIds) AND recurring_end_date>='$now' ORDER BY start_date ASC";

      var results = await db!.rawQuery(query);
      var events = isBackground
          ? await compute(prefix0.eventsFromJson, results)
          : prefix0.eventsFromJson(results);
      tempEventsLists = [];
//      int i = 0;
//      print("total size ${events.length}");
      for (prefix0.Event eventItem in events) {
        try {
//        i++;
          var rrule = eventItem.rrule;
          var eventId = eventItem.id;
          List<Map<String, dynamic>> exceptionsLists = await db.query(
              DB_TABLE_EVENTS_EXCEPTION,
              where: "event_id=?",
              whereArgs: [eventId]);
          var baseEventDate = eventItem.startDate;
          var eventRepetitionType =
              CalendarUtils.getEventRepetitionType(eventItem.basedOn);
          RecurrenceRuleHelper helper = RecurrenceRuleHelper(
              rrule!, baseEventDate, startDate, endDate, eventRepetitionType);
          repetitionDates = helper.calculateEvents();
          if (repetitionDates == null) {
            repetitionDates = [];
          }
          if (exceptionsLists == null) exceptionsLists = [];

          if (exceptionsLists.isNotEmpty) {
            for (int i = 0; i < repetitionDates.length; i++) {
              DateTime time = DateTime(repetitionDates[i].year,
                  repetitionDates[i].month, repetitionDates[i].day, 0, 0, 0);
              List<Map<String, dynamic>> expTime =
                  exceptionsLists.where((var d) {
                DateTime dateTime =
                    CalendarUtils.getCalendarFromString(d["exception_date"]);
                DateTime dTime = DateTime(
                    dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
                if (dTime.toIso8601String() == time.toIso8601String()) {
                  return true;
                } else {
                  return false;
                }
              }).toList();
              if (expTime.isEmpty) {
                prefix0.Event event =
                    prefix0.Event.fromDbJson(eventItem.toJson());
                event.startDate = time;
                event.endDate = time;
                event.parentEventId = eventId;
//              if (eventItem.startDate != time) {
                tempEventsLists.add(event);
//              }
              } else {
                EventExceptionModel eventExceptionModel =
                    EventExceptionModel.fromJson(expTime[0]);
                if (eventExceptionModel.newDate != null) {
                  prefix0.Event event =
                      prefix0.Event.fromDbJson(eventItem.toJson());
                  event.startDate = eventExceptionModel.newDate;
                  event.endDate = eventExceptionModel.newDate;
                  event.parentEventId = eventId;
//              if (eventItem.startDate != time) {
                  tempEventsLists.add(event);
                }
              }
            }
          } else {
            for (int j = 0; j < repetitionDates.length; j++) {
              DateTime time = repetitionDates[j];
              if (time.isAfter(startDate) ||
                  CalendarUtils.getDayDiff(startDate, time) == 0) {
                prefix0.Event repetitionEvent =
                    prefix0.Event.fromDbJson(eventItem.toJson());
                prefix0.Event event = repetitionEvent;
                event.startDate = time;
                event.endDate = time;
                event.parentEventId = eventId;
                // print(event);
                /*if (time != eventItem.startDate)*/
                tempEventsLists.add(event);
              }
            }
          }
        } catch (e) {
          Utils.debugLog(e);
        }
        // print("$startDate-->$rrule--->$repetitionDates");
      }
      // tempEventsLists.addAll(events);
      // print(tempEventsLists);
      return tempEventsLists;
    } catch (e) {
      Utils.debugLog("REPETITIONERROR--$e");
    }
    Utils.debugLog("REPETITIONRETURNINGNULL");
    return [];
  }
}
