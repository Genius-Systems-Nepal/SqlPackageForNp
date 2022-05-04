// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, unnecessary_null_comparison, prefer_if_null_operators, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/recurrencerulehelper.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;

class CacheDbQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnCacheDbTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_CACHE, parameter);
  }

  Future deleteFromTableCacheDb() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_CACHE');
  }

  insertCacheById(nsDataResult, {int? addKey}) async {
    try {
      Database? db = await databaseHelper.database;
      var batch = db?.batch();
      nsDataResult.forEach((k, v) {
        // print(k);
        var arrayDate = v;
        var timeStamp = Timezone().curDateTimeByZone("NPT").toIso8601String();
        for (int i = 0; i < arrayDate.length; i++) {
          Map<String, dynamic> cacheMap = {};
          String date =
              (addKey! + int.parse(arrayDate[i].toString().substring(0, 2)))
                      .toString() +
                  arrayDate[i].toString().substring(2, arrayDate[i].length);
          DateTime dateTime = CalendarUtils.getCalendarFromString(date);
          cacheMap.putIfAbsent(
              "date",
              () => DateTime(dateTime.year, dateTime.month, dateTime.day)
                  .toIso8601String());
          cacheMap.putIfAbsent("event_id", () => k);
          cacheMap.putIfAbsent("created_at", () => timeStamp);
          cacheMap.putIfAbsent("updated_at", () => timeStamp);
          batch?.insert(DB_TABLE_CACHE, cacheMap);
        }
      });
      await batch?.commit(noResult: true, continueOnError: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertCache(List<prefix0.Event> events) async {
    try {
      Database? db = await databaseHelper.database;
      await databaseHelper.initializeTimeZone();
      var batch = db?.batch();
      for (int i = 0; i < events.length; i++) {
        var eventItem = events[i];
        var startDate = DateTime(eventItem.startDate!.year,
                eventItem.startDate!.month, eventItem.startDate!.day)
            .toIso8601String();
        var id = eventItem.id;
        Map<String, dynamic> cacheMap = {};
        var timeStamp = Timezone().curDateTimeByZone("NPT").toIso8601String();
        var dbEvent = await getCacheByEventId(id, startDate);
        if (dbEvent == null) {
          cacheMap.putIfAbsent("date", () => startDate);
          cacheMap.putIfAbsent("event_id", () => id);
          cacheMap.putIfAbsent("created_at", () => timeStamp);
          cacheMap.putIfAbsent("updated_at", () => timeStamp);
          batch?.insert(DB_TABLE_CACHE, cacheMap,
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      }
      await batch?.commit(noResult: true, continueOnError: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  getCacheByEventId(id, date) async {
    try {
      Database? db = await databaseHelper.database;
      var result = await db!.query(DB_TABLE_CACHE,
          where: "event_id=? AND date=?", whereArgs: [id, date]);
      return result.isNotEmpty ? result : null;
    } catch (e) {
      return null;
    }
  }

  Future<List<prefix0.Event>?> getCachebetweenDates(DateTime from, DateTime to,
      {calendarIds = "", impOnly = false, isBackground = true}) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "select EventsDb.title,Cache.date as start_date,EventsDb.description,EventsDb.based_on,EventsDb.important_event,EventsDb.gh,EventsDb.calendar_id,EventsDb.id from EventsDb INNER JOIN Cache ON EventsDb.id=Cache.event_id WHERE Cache.date>=? AND Cache.date<=? ${impOnly ? 'AND EventsDb.important_event=1 ' : ''}ORDER BY Cache.date ASC";
      if (calendarIds.toString().isNotEmpty) {
        query =
            "select EventsDb.title,Cache.date as start_date,EventsDb.description,EventsDb.based_on,EventsDb.important_event,EventsDb.gh,EventsDb.calendar_id,EventsDb.id from EventsDb INNER JOIN Cache ON EventsDb.id=Cache.event_id WHERE Cache.date>=? AND Cache.date<=? AND EventsDb.calendar_id in ($calendarIds) ${impOnly ? 'AND EventsDb.important_event=1 ' : ''}ORDER BY Cache.date ASC";
      }
      var results = await db!
          .rawQuery(query, [from.toIso8601String(), to.toIso8601String()]);
      if (isBackground) {
        return compute(prefix0.eventsFromJson, results);
      } else {
        return prefix0.eventsFromJson(results);
      }
    } catch (e) {
      return null;
    }
  }

  getCacheCount() async {
    try {
      Database? db = await databaseHelper.database;
      //todo validate cache from now to 3 years
      /* var today = DateTime.now();
      var startDate = DateTime(today.year - 1,to`)*/
      List<Map<String, dynamic>> results = await db!.query(DB_TABLE_CACHE);
      return results;
    } catch (e) {
      return [];
    }
  }

  getCachedYear(String from, String to) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "SELECT strftime('%Y', date) as time from Cache WHERE date>=? AND date<=?  group by strftime('%Y', date) order by date ASC";
      var results = await db!.rawQuery(query, [from, to]);
      return results;
    } catch (e) {
      return null;
    }
  }

  /*This method checks if cache is valid or not.
  Params:
    DateTime from: Begining date of the cache that needs to be verified inside the cache.
    DateTiem to: Last range of the cache that needs to be verified in the cache.


  * When we need to verify if the cache if valid from certain to another,
     it first groups down the available month of cached date and then checks if the given range lies in the grouping date.

     Returns a list of date time with invalid cache dates.
     */
  getInvalidCache(DateTime from, DateTime to, {DateTime? startAdDate}) async {
    try {
      Database? db = await databaseHelper.database;
      await databaseHelper.initializeTimeZone();
      List<DateTime> invalidCacheDates = [];
      var dayDiff = CalendarUtils.getDayDiff(from, to);

      var tempDate = DateTime(from.year, from.month, 01);
      if (dayDiff == 0) {
        from = tempDate;
        to = DateTime(to.year, to.month + 1, 0);
      }
      var query =
          "SELECT strftime('%Y%m01', date) as time from Cache WHERE date>=? AND date<=?  group by strftime('%Y%m01', date) order by date ASC";
      var result = await db!
          .rawQuery(query, [from.toIso8601String(), to.toIso8601String()]);

      if (result.isNotEmpty) {
        do {
          var invalidCacheDate = "";
          var cacheInvalid = false;
          for (Map item in result) {
            var calendarItem = item
                .toString()
                .split(":")[1]
                .replaceAll("}", "")
                .replaceAll(" ", "");
            var cachehYear = calendarItem.substring(0, 4);
            var cacheMonth = calendarItem.substring(4, 6);
            var tempMonth = Utils.pad(tempDate.month);
            var tempYear = tempDate.year.toString();
            if (cacheMonth == tempMonth && cachehYear == tempYear) {
              cacheInvalid = false;
              break;
            } else {
              cacheInvalid = true;
              invalidCacheDate = "$tempYear${tempMonth}01";
            }
          }
          if (cacheInvalid) {
            var calendar =
                CalendarUtils.getCalendarFromString(invalidCacheDate);
            if (!invalidCacheDates.contains(calendar)) {
              invalidCacheDates
                  .add(CalendarUtils.getCalendarFromString(invalidCacheDate));
            }
          }
          tempDate =
              CalendarUtils.addMonth(tempDate, 1, startAdDate: startAdDate);
        } while (tempDate.isBefore(to));
        return invalidCacheDates;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteSingleDateFromCache(
      String eventId, DateTime fromDate) async {
    try {
      Database? db = await databaseHelper.database;
      DateTime endDate = DateTime(
          fromDate.year, fromDate.month, fromDate.day, 23, 59, 59, 999);
      await db?.delete(DB_TABLE_CACHE,
          where: "event_id = ? AND date >= ? AND date <= ?",
          whereArgs: [
            eventId,
            fromDate.toIso8601String(),
            endDate.toIso8601String()
          ]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllDefaultCalCache() async {
    try {
      Database? db = await databaseHelper.database;
      String query =
          "DELETE from $DB_TABLE_CACHE WHERE event_id in ( SELECT EventsDb.id from EventsDb WHERE calendar_id = '105' )";
      await db?.rawQuery(query);
      try {
        await db?.query(DB_TABLE_EVENTS,
            where: "calendar_id = ?", whereArgs: ["105"]);
      } catch (e) {
        Utils.debugLog(e);
      }
      return true;
    } catch (e) {
      Utils.debugLog(e);
      return false;
    }
  }

  Future<bool> deleteFutureDateFromCache(
      String eventId, DateTime fromDate) async {
    try {
      Database? db = await databaseHelper.database;
      await db?.delete(DB_TABLE_CACHE,
          where: "event_id = ? AND date >= ?",
          whereArgs: [eventId, fromDate.toIso8601String()]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCache(String eventId) async {
    try {
      Database? db = await databaseHelper.database;
      await db
          ?.delete(DB_TABLE_CACHE, where: "event_id = ?", whereArgs: [eventId]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNepaliCalendarCache() async {
    try {
      Database? db = await databaseHelper.database;
      String query =
          "Delete from $DB_TABLE_CACHE where event_id in ( select event_id from $DB_TABLE_EVENTS where calendar_id = '105' ) ";
      await db?.rawQuery(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<prefix0.Event>> getRepetitionEventsCache(
      List<prefix0.Event> events, startDate, endDate,
      {forceGenerate = false}) async {
    try {
      Database? db = await databaseHelper.database;
      List<prefix0.Event> tempEventsLists = [];
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      var fromDate = await PrefsUtils.getString(PREFS_FROM_DATE, "");
      var toDate = await PrefsUtils.getString(PREFS_TO_DATE, "");
      var from = CalendarUtils.getCalendarFromString(fromDate);
      var to = CalendarUtils.getCalendarFromString(toDate);
      for (prefix0.Event eventItem in events) {
        if (!(eventItem.calendar_id == "105" &&
            eventItem.basedOn?.toLowerCase() == "ns" &&
            ((from.isBefore(startDate) ||
                    CalendarUtils.getDayDiff(from, startDate) == 0) &&
                (to.isAfter(endDate) ||
                    CalendarUtils.getDayDiff(to, endDate) == 0)))) {
          if (eventItem.createdBy == userId || forceGenerate) {
            try {
              var rrule = eventItem.rrule;
              var eventId = eventItem.id;
              List<Map<String, dynamic>> exceptionsLists = await db!.query(
                  DB_TABLE_EVENTS_EXCEPTION,
                  where: "event_id=?",
                  whereArgs: [eventId]);
              var baseEventDate = eventItem.startDate;
              var eventRepetitionType =
                  CalendarUtils.getEventRepetitionType(eventItem.basedOn);
              if (rrule!.isNotEmpty) {
                RecurrenceRuleHelper helper = RecurrenceRuleHelper(rrule,
                    baseEventDate, startDate, endDate, eventRepetitionType);
                List<dynamic> repetitionDates = [];
                repetitionDates = helper.calculateEvents();
                if (repetitionDates == null) {
                  repetitionDates = [];
                }
                if (exceptionsLists == null) exceptionsLists = [];

                if (exceptionsLists.isNotEmpty) {
                  for (int i = 0; i < repetitionDates.length; i++) {
                    DateTime time = repetitionDates[i];
                    if (!(eventItem.calendar_id == "105" &&
                        eventItem.basedOn?.toLowerCase() == "ns" &&
                        ((from.isBefore(time) ||
                                CalendarUtils.getDayDiff(from, time) == 0) &&
                            (to.isAfter(time) ||
                                CalendarUtils.getDayDiff(to, time) == 0)))) {
                      List<Map<String, dynamic>> expTime = exceptionsLists
                          .where((var d) =>
                              d["exception_date"] == time.toIso8601String())
                          .toList();
                      if (expTime.isEmpty) {
                        prefix0.Event event =
                            prefix0.Event.fromDbJson(eventItem.toJson());
                        event.startDate = time != null ? time : event.startDate;
                        event.endDate = time != null ? time : event.endDate;
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
                  }
                } else {
                  for (int j = 0; j < repetitionDates.length; j++) {
                    DateTime time = repetitionDates[j];
                    if (!(eventItem.calendar_id == "105" &&
                        eventItem.basedOn?.toLowerCase() == "ns" &&
                        ((from.isBefore(time) ||
                                CalendarUtils.getDayDiff(from, time) == 0) &&
                            (to.isAfter(time) ||
                                CalendarUtils.getDayDiff(to, time) == 0)))) {
                      prefix0.Event repetitionEvent =
                          prefix0.Event.fromDbJson(eventItem.toJson());
                      prefix0.Event event = repetitionEvent;
                      event.startDate = time;
                      event.endDate = time;
                      event.parentEventId = eventId;
//                      print(event);
                      /*if (time != eventItem.startDate)*/
                      tempEventsLists.add(event);
                    }
                  }
                }
              } else {
                tempEventsLists.add(eventItem);
              }
            } catch (e) {
              Utils.debugLog(e);
            }
          }
        }
        // print("$startDate-->$rrule--->$repetitionDates");
      }

      return tempEventsLists;
    } catch (e) {
      Utils.debugLog(e);
      return [];
    }
  }

  Future<List<prefix0.Event>?> getNonCacheEventOfYear(
      DateTime startDate, DateTime endDate,
      {isBackground = true}) async {
    try {
      Database? db = await databaseHelper.database;
      startDate = DateTime(startDate.year, startDate.month, startDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day);
      var fromDate = await PrefsUtils.getString(PREFS_FROM_DATE, "");
      var toDate = await PrefsUtils.getString(PREFS_TO_DATE, "");
      var from =
          CalendarUtils.getCalendarFromString(fromDate).add(Duration(days: -1));
      var to =
          CalendarUtils.getCalendarFromString(toDate).add(Duration(days: 1));
      String based_on = "";
      if (from.isBefore(startDate) && endDate.isBefore(to)) {
        based_on = "AND based_on != 'NS'";
      }
      var query =
          "SELECT * FROM EventsDb WHERE id not in (SELECT event_id FROM Cache WHERE date >= '${startDate.toIso8601String()}' AND date <= '${endDate.toIso8601String()}') and recurring_end_date >= '${startDate.toIso8601String()}' and calendar_id = (SELECT calendar_id FROM CalendarDb WHERE is_default = 1) AND rrule != '' " +
              based_on;
      var results = await db!.rawQuery(query);
      if (isBackground) {
        return compute(prefix0.eventsFromJson, results);
      } else {
        return prefix0.eventsFromJson(results);
      }
    } catch (e) {
      return null;
    }
  }
}
