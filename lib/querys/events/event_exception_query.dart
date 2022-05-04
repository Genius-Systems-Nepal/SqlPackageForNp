// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:nepali_patro_sql_package/models/deleteEventModel.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/querys/cachedb_querys.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;

class EventExceptionQuery {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<bool> insertEventException(List<dynamic> exceptionLists,
      {force = false}) async {
    await databaseHelper.initializeTimeZone();
    try {
      Database? db = await databaseHelper.database;
      for (int j = 0; j < exceptionLists.length; j++) {
        var item = exceptionLists[j];
        Map exceptionItem;
        if (item is EventExceptionModel) {
          exceptionItem = item.toJson().cast();
        } else {
          exceptionItem = item;
        }
        var dbException = await getEventExceptionById(exceptionItem["id"]);
        if (exceptionItem["id"] == null) {
          var uuid = const Uuid();
          var id = uuid.v1();
          exceptionItem["id"] = id;
        }
        if (dbException == null) {
          await db?.insert(DB_TABLE_EVENTS_EXCEPTION, exceptionItem.cast());
          try {
            await deleteUserEvent(exceptionItem["id"]);
          } catch (e) {
            await deleteuserEventById(exceptionItem["id"]);
            // Utils.debugLog(e);
          }
        } else {
          var updatedAt = CalendarUtils.getCalendarFromString(
              exceptionItem["update_at"].toString());
          var dbUpdatedAt =
              CalendarUtils.getCalendarFromString(dbException["update_at"]);
          if (force) {
            await db?.update(DB_TABLE_EVENTS_EXCEPTION, exceptionItem.cast(),
                where: "id=?", whereArgs: [exceptionItem["id"]]);
          } else if (updatedAt.isAfter(dbUpdatedAt)) {
            await db?.update(DB_TABLE_EVENTS_EXCEPTION, exceptionItem.cast(),
                where: "id=?", whereArgs: [exceptionItem["id"]]);
          }
        }
        try {
          var timeStamp = Timezone().curDateTimeByZone("NPT").toIso8601String();
          CacheDbQuerys cache = CacheDbQuerys();
          var dbEvent = await cache.getCacheByEventId(
              exceptionItem["event_id"], exceptionItem["new_date"]);
          Map<String, dynamic> cacheMap = {};
          if (dbEvent == null) {
            cacheMap.putIfAbsent("date", () => exceptionItem["new_date"]);
            cacheMap.putIfAbsent("event_id", () => exceptionItem["event_id"]);
            cacheMap.putIfAbsent("created_at", () => timeStamp);
            cacheMap.putIfAbsent("updated_at", () => timeStamp);
            try {
              await db?.insert(DB_TABLE_CACHE, cacheMap);
            } catch (e) {
              Utils.debugLog(e);
            }
            await cache.deleteSingleDateFromCache(
                exceptionItem["event_id"].toString(),
                CalendarUtils.getCalendarFromString(
                    exceptionItem["exception_date"].toString()));
          }
        } catch (e) {
          Utils.debugLog(e);
        }
      }
      return true;
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  Future<Map?> getEventExceptionById(id) async {
    try {
      Database? db = await databaseHelper.database;
      List<Map> response = await db!
          .query(DB_TABLE_EVENTS_EXCEPTION, where: "id=?", whereArgs: [id]);
      if (response != null && response.isNotEmpty) {
        return response[0];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  deleteUserEvent(prefix0.Event event) async {
    try {
      await databaseHelper.initializeTimeZone();
      Database? db = await databaseHelper.database;
      await db!.delete(DB_TABLE_EVENTS, where: 'id=?', whereArgs: [event.id]);
      var uuid = Uuid();
      var id = uuid.v1();
      var eventExceptionItem = EventExceptionModel(
          id: id,
          newDate: event.recurringEndDate,
          exceptionDate: event.startDate,
          eventId: event.id,
          createdDate: event.createdAt,
          updatedDate: Timezone().curDateTimeByZone("NPT"),
          calendarId: event.calendar_id);
      List eventExceptionLists = [];
      eventExceptionLists.add(eventExceptionItem);
      await insertEventException(eventExceptionLists);
      await databaseHelper.deleteRemindersWithEventid(event.id);
      await insertDeleteEvents(event);
      return true;
    } catch (e) {
      return false;
    }
  }

  insertDeleteEvents(prefix0.Event event) async {
    Database? db = await databaseHelper.database;
    var deletedEvents = DeletedEvents(
        id: null,
        eventId: event.id,
        calendarId: event.calendar_id,
        createdAt: event.createdAt,
        updatedAt: Timezone().curDateTimeByZone("NPT"));
    await db!.insert(DB_TABLE_DELETE_EVENTS, deletedEvents.toJson());
  }

  deleteuserEventById(id) async {
    try {
      Database? db = await databaseHelper.database;
      await db?.delete(DB_TABLE_EVENTS, where: 'id=?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteFromTableExceptions() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_EVENTS_EXCEPTION');
  }
}
