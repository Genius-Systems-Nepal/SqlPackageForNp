// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, prefer_conditional_assignment, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/custom/npcachemanager.dart';
import 'package:nepali_patro_sql_package/models/eventdescriptionmodel.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/recurrencerulehelper.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/remoteconfigconstants.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;
import 'package:sqflite/sqflite.dart';

class EventsQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<bool> insertEvents(List events, forceUpdate,
      {needEncryption = true}) async {
    try {
      Database? db = await databaseHelper.database;
      var batch = db?.batch();
      for (int i = 0; i < events.length; i++) {
        try {
          prefix0.Event event;
          var gh = "0";
          var imp = "0";
          if (events[i] is prefix0.Event) {
            event = events[i];
          } else {
            event = prefix0.Event.fromJson(events[i]);
          }
          EventDescriptionModel descriptionModel =
              Utils.getEventsDescriptionOnly(event);
          if (descriptionModel != null) {
            gh = descriptionModel.gh ?? "0";
            imp = descriptionModel.importantEvent ?? "0";
          }
          var eventFromDb = await getCalendarEventbyId(event.id!);
          event.gh = int.tryParse(gh) ?? 0;
          event.imp = int.tryParse(imp) ?? 0;
          if (event.calendar_id == null) {
            event.calendar_id = "105";
          }
          if (eventFromDb != null) {
            if (event.updatedAt!.isAfter(eventFromDb.updatedAt!)) {
              try {
                await deleteCache(event.id!);
              } catch (e) {
                Utils.debugLog(e);
              }
              event.updatedAt = Timezone().curDateTimeByZone("NPT");
              if (forceUpdate)
                //  ignore: curly_braces_in_flow_control_structures
                batch?.update(
                    DB_TABLE_EVENTS,
                    needEncryption
                        ? event.toJson()
                        : event.toJsonNoEncryption(),
                    where: 'id = ?',
                    whereArgs: [event.id]);
              else if (event.updatedAt!.isAfter(eventFromDb.updatedAt!)) {
                batch?.update(
                    DB_TABLE_EVENTS,
                    needEncryption
                        ? event.toJson()
                        : event.toJsonNoEncryption(),
                    where: 'id = ?',
                    whereArgs: [event.id]);
              }
            }
          } else {
            batch?.insert(DB_TABLE_EVENTS,
                needEncryption ? event.toJson() : event.toJsonNoEncryption());
          }
        } catch (e) {
          Utils.debugLog(e);
        }
      }
      await batch?.commit(noResult: true);
      return true;
    } catch (e) {
      Utils.debugLog("DBEXCEPTION-$e");
    }
    return false;
  }

  Future<prefix0.Event?> getCalendarEventbyId(String id) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_EVENTS WHERE id='$id'";
      var results = await db!.rawQuery(query);
      List<dynamic> eventLists = results
          .map((Map<String, dynamic> model) => prefix0.Event.fromDbJson(model))
          .toList();
      if (eventLists.isNotEmpty) {
        var resultEvent = eventLists[0];
        return resultEvent;
      }
    } catch (e) {
      Utils.debugLog("DBEXCEPTION-$e");
    }
    return null;
  }

  Future<bool> deleteCache(String eventId) async {
    try {
      Database? db = await databaseHelper.database;
      await db!
          .delete(DB_TABLE_CACHE, where: "event_id = ?", whereArgs: [eventId]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<prefix0.Event>> getEvents() async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_EVENTS";
      var results = await db?.rawQuery(query);
      List<prefix0.Event> eventLists = results!
          .map((Map<String, dynamic> model) => prefix0.Event.fromDbJson(model))
          .toList();
      return eventLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<prefix0.Event?> getEventByIdWithDate(id, date) async {
    try {
      Database? db = await databaseHelper.database;
      var results =
          await db?.query(DB_TABLE_EVENTS, where: "id = ?", whereArgs: [id]);
      prefix0.Event event = prefix0.Event.fromJson(results!.first);
      event.startDate = DateTime.parse(date);
      return event;
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  /*Returns list of events for a single day only.
  * Sets the current date time range from starting of the day to the end of the day i.e 23.59*/
  Future<List<prefix0.Event>> getEventToday(DateTime time) async {
    Database? db = await databaseHelper.database;
    var from =
        DateTime(time.year, time.month, time.day, 0, 0, 0).toIso8601String();
    var to =
        DateTime(time.year, time.month, time.day, 23, 59, 0).toIso8601String();
    List<prefix0.Event> eventsLists = <prefix0.Event>[];
    try {
      // EventsDb.start_date as end_date is added for taking time in conversion_page
      var query =
          "select EventsDb.title,Cache.date as start_date, EventsDb.start_date as end_date, EventsDb.description,EventsDb.calendar_id,EventsDb.id from EventsDb INNER JOIN Cache ON EventsDb.id=Cache.event_id WHERE Cache.date>=? AND Cache.date<=? ORDER BY EventsDb.important_event DESC";
      var results = await db?.rawQuery(query, [from, to]);
      List<prefix0.Event> eventLists = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return eventLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return eventsLists;
  }

  disableUserEvent(prefix0.Event event) async {
    try {
      Database? db = await databaseHelper.database;
      var status = event.status == 1 ? 0 : 1;
      event.status = status;
      await db?.update(DB_TABLE_EVENTS, event.toJson(),
          where: "id=?", whereArgs: [event.id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateUserEventsAuthority(prevId, newId) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "UPDATE $DB_TABLE_EVENTS SET created_by=? WHERE created_by=?";
      await db?.rawQuery(query, [newId, prevId]);
      return true;
    } catch (e) {
      Utils.debugLog(e);
      return false;
    }
  }

  Future<List<prefix0.Event>> getUserevents(userId,
      {status = 1, calendarId}) async {
    List<prefix0.Event> events = [];
    try {
      Database? db = await databaseHelper.database;
      var results;
      if (calendarId == null) {
        results = await db?.query(DB_TABLE_EVENTS,
            where: "created_by=? AND status=?", whereArgs: [userId, status]);
      } else {
        results = await db?.query(DB_TABLE_EVENTS,
            where: "created_by=? AND status=? AND calendar_id = ? ",
            whereArgs: [userId, status, calendarId]);
      }
      // events =
      // results.map((model) => prefix0.Event.fromDbJson(model)).toList();
      for (var model in results) {
        prefix0.Event event = prefix0.Event.fromDbJson(model);
        events.add(event);
      }
      //events =
      //List<prefix0.Event>.from(
      //results.map((Map x) => Event.fromJson(x)\));
      return events;
    } catch (e) {
      Utils.debugLog(e);
      return events;
    }
  }

  Future<List<prefix0.Event>?> getCalendarEventsByIds(String ids) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_EVENTS WHERE id in ($ids)";
      var results = await db?.rawQuery(query);
      List<prefix0.Event> eventLists = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return eventLists;
    } catch (e) {
      Utils.debugLog("DBEXCEPTION-$e");
    }
    return null;
  }

  Future<List<prefix0.Event>> getExpiredNonRepeatingEvents(
      {status = 1, calendarId}) async {
    await databaseHelper.initializeTimeZone();
    var now = DateTime(
        Timezone().curDateTimeByZone("NPT").year,
        Timezone().curDateTimeByZone("NPT").month,
        Timezone().curDateTimeByZone("NPT").day,
        0,
        0,
        0);
    List<prefix0.Event> events = [];
    try {
      Database? db = await databaseHelper.database;
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      var results = await db?.query(DB_TABLE_EVENTS,
          where:
              "start_date < ? AND rrule = '' AND created_by = ? AND status = ? AND calendar_id = ?",
          whereArgs: [now.toIso8601String(), userId, status, calendarId]);
      for (var model in results!) {
        prefix0.Event event = prefix0.Event.fromDbJson(model);
        events.add(event);
      }
      return events;
    } catch (e) {
      Utils.debugLog(e);
      return events;
    }
  }

  Future<List<prefix0.Event>> getActiveNonRepeatingEvents(
      {status = 1, calendarId}) async {
    await databaseHelper.initializeTimeZone();
    var now = DateTime(
        Timezone().curDateTimeByZone("NPT").year,
        Timezone().curDateTimeByZone("NPT").month,
        Timezone().curDateTimeByZone("NPT").day,
        0,
        0,
        0);
    List<prefix0.Event> events = [];
    try {
      Database? db = await databaseHelper.database;
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      var results = await db?.query(DB_TABLE_EVENTS,
          where:
              "start_date >= ? AND rrule = '' AND created_by = ? AND status = ? AND calendar_id = ?",
          whereArgs: [now.toIso8601String(), userId, status, calendarId]);
      for (var model in results!) {
        prefix0.Event event = prefix0.Event.fromDbJson(model);
        events.add(event);
      }
      return events;
    } catch (e) {
      Utils.debugLog(e);
      return events;
    }
  }

  Future<List<prefix0.Event>> getExpiredEvents({status = 1, calendarId}) async {
    await databaseHelper.initializeTimeZone();
    var now = DateTime(
        Timezone().curDateTimeByZone("NPT").year,
        Timezone().curDateTimeByZone("NPT").month,
        Timezone().curDateTimeByZone("NPT").day,
        0,
        0,
        0);
    List<prefix0.Event> events = [];
    try {
      Database? db = await databaseHelper.database;
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      /*var query =
          "SELECT ${DB_TABLE_EVENTS}.* from EventsDb WHERE calendar_id = '${calendarId}' AND status = ${status} AND "
          "created_by = '${userId}' AND( id IN (SELECT event_id FROM cache WHERE date <= '${now
          .toIso8601String()}')"
          "OR recurring_end_date <= '${now.toIso8601String()}')"
          "AND (${DB_TABLE_EVENTS}.id not in ( SELECT EventsDb.id from EventsDb WHERE calendar_id = '${calendarId}' AND status = ${status} AND "
          "created_by = '${userId}' AND (id IN (SELECT event_id FROM cache WHERE date >= '${now
          .toIso8601String()}' ) OR recurring_end_date >= '${now
          .toIso8601String()}')"
          "GROUP BY id ) ) GROUP BY id";*/
      var query =
          "Select * from ( SELECT EventsDb.*,Cache.date FROM EventsDb INNER JOIN Cache on Cache.event_id = EventsDb.id "
          "where Cache.date <= '${now.toIso8601String()}' and EventsDb.created_by = '$userId' and status = $status and EventsDb.calendar_id = '$calendarId' "
          "and ( EventsDb.id not in ( SELECT EventsDb.id FROM EventsDb INNER JOIN Cache on Cache.event_id = EventsDb.id where "
          "Cache.date >= '${now.toIso8601String()}' and status = $status and EventsDb.calendar_id = '$calendarId' and EventsDb.created_by = '$userId' group by EventsDb.id "
          " ) ) order by Cache.date asc ) group by id order by date desc";
      var results = await db?.rawQuery(query);
      for (var model in results!) {
        prefix0.Event event = prefix0.Event.fromDbJson(model);
        events.add(event);
      }
//      var nonRepeatingEvents = await getExpiredNonRepeatingEvents(
//          status: status, calendarId: calendarId);
//      events.addAll(nonRepeatingEvents);
      return events;
    } catch (e) {
      Utils.debugLog(e);
      return events;
    }
  }

  Future<List<prefix0.Event>> getActiveEvents({status = 1, calendarId}) async {
    await databaseHelper.initializeTimeZone();
    var now = DateTime(
        Timezone().curDateTimeByZone("NPT").year,
        Timezone().curDateTimeByZone("NPT").month,
        Timezone().curDateTimeByZone("NPT").day,
        0,
        0,
        0);
    List<prefix0.Event> events = [];
    try {
      Database? db = await databaseHelper.database;
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      var query =
          "Select * from ( SELECT EventsDb.*,Cache.date FROM EventsDb INNER JOIN Cache on Cache.event_id = EventsDb.id where Cache.date >= '${now.toIso8601String()}' and EventsDb.created_by = '$userId'"
          "and EventsDb.status = $status and EventsDb.calendar_id = '$calendarId' order by Cache.date desc) group by id order by date asc";
      var results = await db?.rawQuery(query);
      for (var model in results!) {
        prefix0.Event event = prefix0.Event.fromDbJson(model);
        event.startDate = DateTime.parse(model["date"].toString());
        events.add(event);
      }
//      var nonRepeatingEvents = await getActiveNonRepeatingEvents(
//          status: status, calendarId: calendarId);
//      events.addAll(nonRepeatingEvents);
      return events;
    } catch (e) {
      Utils.debugLog(e);
      return events;
    }
  }

  Future<List<prefix0.Event>?> getSearchEvents(keyword) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "SELECT * FROM $DB_TABLE_EVENTS WHERE title LIKE '%$keyword%' ORDER BY start_date ASC";
      //var query="SELECT * FROM $DB_TABLE_EVENTS";
      var results = await db?.rawQuery(query);
      var calendars = results!
          .map((Map<String, dynamic> model) => prefix0.Event.fromDbJson(model))
          .toList();
      return calendars;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<List<prefix0.Event>> getAllUserEvents() async {
    try {
      Database? db = await databaseHelper.database;
      var userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
      var results = await db!
          .query(DB_TABLE_EVENTS, where: "created_by=?", whereArgs: [userId]);
      var events = results
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return events;
    } catch (e) {
      return [];
    }
  }

  Future<List<prefix0.Event>> getSyncPendingEvents() async {
    Database? db = await databaseHelper.database;
    var timeStamp =
        await PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
    if (timeStamp.isNotEmpty) {
      var results = await db?.query(DB_TABLE_EVENTS,
          where: "updated_at>=?", whereArgs: [timeStamp]);
      var events = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return events;
    }
    return [];
  }

  Future<List<prefix0.Event>?> getEventsbetweenDates(startDate, endDate,
      {isBackground = true}) async {
    try {
      Database? db = await databaseHelper.database;
      var calendarExceptionsLIsts = await databaseHelper.getDisabledCalendars();
      var query =
          "SELECT * FROM $DB_TABLE_EVENTS WHERE ( rrule IS  NULL OR TRIM(rrule,'') = '') AND start_date >='$startDate' AND start_date<='$endDate'"
          "AND status=1 AND calendar_id NOT IN ($calendarExceptionsLIsts) ORDER BY start_date ASC";
      var results = await db!.rawQuery(query);
      if (isBackground) {
        return compute(prefix0.eventsFromJson, results);
      } else {
        return prefix0.eventsFromJson(results);
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<List<prefix0.Event>> loadHomeevents(hasLimit) async {
    try {
      Database? db = await databaseHelper.database;
      var remoteConfig = RemoteConfig.instance;
      var limit = remoteConfig.getString(TODAY_DISPLAY_LIMIT_IMPE);
      String limitText = "";
      if (hasLimit) limitText = " LIMIT $limit ";
      var query =
          "SELECT * FROM $DB_TABLE_EVENTS WHERE start_date>date('now') ORDER BY start_date ASC $limitText";
      var results = await db?.rawQuery(query);
      List<prefix0.Event> eventLists = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return eventLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
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
          RecurrenceRuleHelper helper = RecurrenceRuleHelper(rrule.toString(),
              baseEventDate, startDate, endDate, eventRepetitionType);
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

  Future<List<prefix0.Event>> getRepeatedEvents(
      DateTime startDate, DateTime endDate,
      {impOnly = false, forceDefCal = false, isBackground = true}) async {
    try {
      Database? db = await databaseHelper.database;
      var npCacheManager = NpCacheManager();
      List<prefix0.Event> repeatedEvents = [];

      //GETS DEFAULT CALENDAR IDS.
      var defaultCalendarids = await databaseHelper.getEnabledDefaultCalendars(
          defautlCalendar: true);
      //FETCHES EVENTS FROM CACHED DATA. IF NOT FOUND GENERATES NEW SET OF CACHE AND THEN RETURNS EVENTS.
      if (defaultCalendarids.toString().isNotEmpty || forceDefCal) {
        dynamic defaultCalendarEvents =
            await npCacheManager.getCachedEventsBetweenDates(startDate, endDate,
                calendarId: defaultCalendarids,
                impOnly: impOnly,
                isBackground: isBackground);
        repeatedEvents.addAll(defaultCalendarEvents);
      }

      //GENERATES NORMAL EVENTS USERS' CALENDAR AND OTHER CALENDARS AND USES REPETITION RULE FOR EVENT REPETITION.
      var calendarids = await databaseHelper.getEnabledDefaultCalendars();
      if (calendarids.toString().isNotEmpty) {
        var events = await getRepetitionEventsforMonth(startDate, endDate,
            preCalendarId: calendarids, isBackground: isBackground);
        repeatedEvents.addAll(events);
      }

      return repeatedEvents;
    } catch (e) {
      return [];
    }
  }

  Future deleteFromTableEvents() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_EVENTS ');
  }
}
