import 'package:flutter/material.dart';
import 'package:nepali_patro_sql_package/loaders/calendarloader.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart' as cm;

class CalendarQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<bool> insertCalendars(List<cm.Calendar> calendars) async {
    bool syncRequired = false;
    try {
      Database? db = await databaseHelper.database;
      var batch = db?.batch();
      var syncPriortization = await Utils.isUserAuthorized();
      for (cm.Calendar calendar in calendars) {
        calendar.color ??= '#E15A00';
        var calendarDb = await getCalendarById(calendar.calendar_id);
        try {
          if (calendarDb != null) {
            if (calendarDb.status != 2) {
              if (calendar.updated_at!.isAfter(calendarDb.updated_at!)) {
                if (calendar.createdBy == null &&
                    calendar.calendar_id != '105') {
                  var userId =
                      await PrefsUtils.getString(PREF_USER_ID, defUserId);
                  calendar.createdBy = userId;
                }
                if (syncPriortization) {
                  /*  var query =
                      "UPDATE $DB_CALENDAR SET name=?,is_modifiable=?,created_at=?,updated_at=?,color=?,priority=?,status=?,display=? WHERE id=?";*/
                  try {
                    batch?.update(DB_TABLE_CALENDAR, calendar.toJson(),
                        where: "id=?", whereArgs: [calendar.id]);
                  } catch (e) {
                    Utils.debugLog(e);
                  }
                } else {
                  var query =
                      "UPDATE $DB_TABLE_CALENDAR SET name=?,is_modifiable=?,"
                      "created_at=?,updated_at=?,created_by = ?,color=?,status=?,display=? WHERE id=?";
                  try {
                    batch?.rawQuery(query, [
                      calendar.name,
                      calendar.isModifiable,
                      calendar.created_at?.toIso8601String(),
                      calendar.updated_at?.toIso8601String(),
                      calendar.createdBy,
                      calendar.color,
                      calendar.status,
                      calendar.display,
                      calendar.id
                    ]);
                  } catch (e) {
                    Utils.debugLog(e);
                  }
                }
              } else if (calendar.updated_at != calendarDb.updated_at) {
                syncRequired = true;
              }
            }
          } else {
            try {
              var userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
              calendar.createdBy = userId;
              batch?.insert(DB_TABLE_CALENDAR, calendar.toJson());
            } catch (e) {
              Utils.debugLog(e);
            }
          }

          //
        } catch (e) {
          Utils.debugLog("INSERTCALENDARERROR-->$e");
        }
      }
      await batch?.commit(noResult: true);
      if (syncRequired) {
        BuildContext? context;
        // CalendarLoader(null).syncCalendars(false);
        CalendarLoader(context as BuildContext).syncCalendars(false);
      }
      return true;
    } catch (e) {
      Utils.debugLog("INSERTCALENDARERROR-->$e");
      return false;
    }
  }

  Future<bool> updateCalendar(Calendar calendar) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "UPDATE $DB_TABLE_CALENDAR SET name=?,is_modifiable=?,status=?,"
          "created_at=?,updated_at=?,color=? WHERE id=?";
      await db?.rawQuery(query, [
        calendar.name,
        calendar.isModifiable,
        calendar.status,
        calendar.created_at != null
            ? calendar.created_at?.toIso8601String()
            : Timezone().curDateTimeByZone("NPT").toIso8601String(),
        calendar.updated_at?.toIso8601String(),
        calendar.color,
        calendar.id
      ]);
      return true;
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  Future<List<cm.Calendar>> getAllSortedCalendars() async {
    var userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
    try {
      Database? db = await databaseHelper.database;
      var query =
          "SELECT * FROM $DB_TABLE_CALENDAR WHERE status!=2 AND (is_default = 1 OR created_by = '$userId') ORDER BY priority ASC";
      var results = await db?.rawQuery(query);
      var calendarLists = results!
          .map((Map model) => cm.Calendar.fromJson(model.cast()))
          .toList();
      return calendarLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<List<Calendar>> getCalendarUser() async {
    Database? db = await databaseHelper.database;
    List<Calendar> calendarList = [];
    try {
      var userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
      var result = await db!.query(DB_TABLE_CALENDAR,
          where: "created_by = ? AND status != 2", whereArgs: [userId]);
      for (var mapResult in result) {
        Calendar calendar = Calendar.fromJson(mapResult);
        calendarList.add(calendar);
      }
      return calendarList;
    } catch (e) {
      Utils.debugLog(e);
      return calendarList;
    }
  }

  Future<bool> deleteCalendars(Calendar calendarItem) async {
    try {
      Database? db = await databaseHelper.database;
      calendarItem.status = 2;
      await db?.update(DB_TABLE_CALENDAR, calendarItem.toNormalDateJson(),
          where: "id = ?", whereArgs: [calendarItem.calendar_id]);
      await db?.delete(DB_TABLE_EVENTS,
          where: "calendar_id = ?", whereArgs: [calendarItem.calendar_id]);
      return true;
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  Future<List<cm.Calendar>> getsortedCalendar() async {
    var userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
    try {
      Database? db = await databaseHelper.database;
      var query =
          "SELECT * FROM $DB_TABLE_CALENDAR WHERE status!=2 AND ( is_default = 1 or created_by = '$userId' ) ORDER BY priority ASC";
      var results = await db?.rawQuery(query);
      var calendarLists = results!
          .map((Map model) => cm.Calendar.fromJson(model.cast()))
          .toList();
      return calendarLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<cm.Calendar?> getCalendarById(id) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_CALENDAR WHERE calendar_id=?";
      var results = await db?.rawQuery(query, [id]);
      var calendarLists = results!
          .map((Map model) => cm.Calendar.fromJson(model.cast()))
          .toList();
      if (calendarLists.isNotEmpty) {
        return calendarLists[0];
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  getEnabledCalendars() async {
    try {
      Database? db = await databaseHelper.database;
      var disabledCalendarBuffer = StringBuffer();
      var results = await db?.query(DB_TABLE_CALENDAR, where: "display=1");
      var disabledCalendars =
          results!.map((Map model) => Calendar.fromJson(model.cast())).toList();
      for (Calendar c in disabledCalendars) {
        disabledCalendarBuffer.write("'${c.calendar_id}',");
      }
      var disabledCalendarsid = disabledCalendarBuffer.toString();
      var result =
          disabledCalendarsid.substring(0, disabledCalendarsid.length - 1);
      return result;
    } catch (e) {
      Utils.debugLog(e);
    }
    return "";
  }

  Future<List<cm.Calendar>> getSyncPendingCalendars({loadAll = false}) async {
    try {
      Database? db = await databaseHelper.database;
      var results = <Map<String, dynamic>>[];
      if (!loadAll) {
        var timestamp =
            await PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
        results = await db!.query(DB_TABLE_CALENDAR,
            where: "updated_at>=?", whereArgs: [timestamp]);
      } else {
        results = await db!.query(DB_TABLE_CALENDAR);
      }
      var calendarLists = results
          .map((Map model) => cm.Calendar.fromJson(model.cast()))
          .toList();
      return calendarLists;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  getEnabledDefaultCalendars({defautlCalendar = false}) async {
    try {
      Database? db = await databaseHelper.database;
      var disabledCalendarBuffer = StringBuffer();
      dynamic results;
      var userId = await PrefsUtils.getString(PREF_USER_ID, "1");
      if (defautlCalendar) {
        results = await db?.query(DB_TABLE_CALENDAR,
            where: "display=1 and status !=2 ");
      } else {
        results = await db?.query(DB_TABLE_CALENDAR,
            where: "display=1 and status !=2 AND created_by = ?",
            whereArgs: [userId]);
      }
      var disabledCalendars =
          results.map((Map model) => Calendar.fromJson(model.cast())).toList();
      for (Calendar c in disabledCalendars) {
        if (defautlCalendar) {
          if (c.isDefault == 1) {
            disabledCalendarBuffer.write("'${c.calendar_id}',");
          }
        } else {
          if (c.isDefault == 0 || c.isDefault == null) {
            disabledCalendarBuffer.write("'${c.calendar_id}',");
          }
        }
      }
      var disabledCalendarsid = disabledCalendarBuffer.toString();
      var result =
          disabledCalendarsid.substring(0, disabledCalendarsid.length - 1);
      return result;
    } catch (e) {
      Utils.debugLog(e);
    }
    return "";
  }

  Future<dynamic> updateCalendarPriority(List<cm.Calendar> calendars) async {
    try {
      Database? db = await databaseHelper.database;
      await databaseHelper.initializeTimeZone();
      var time = Timezone().curDateTimeByZone("NPT");
//      var isoString = time.toIso8601String();
      for (int j = 1; j <= calendars.length; j++) {
        var calendar = calendars[j - 1];
        calendar.updated_at = time;
        calendar.priority = j;
        var updated = await db?.update(DB_TABLE_CALENDAR, calendar.toJson(),
            where: "id=?", whereArgs: [calendar.id]);
        return updated;
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<String> getDisabledCalendars() async {
    try {
      Database? db = await databaseHelper.database;
      var disabledCalendarBuffer = StringBuffer();
      var userId = await PrefsUtils.getString(PREF_USER_ID, "");
      var results = await db?.query(DB_TABLE_CALENDAR,
          where: "display=0 OR status=2 OR created_by != '$userId'");
      var disabledCalendars =
          results?.map((Map model) => Calendar.fromJson(model.cast())).toList();
      for (Calendar c in disabledCalendars!) {
        disabledCalendarBuffer.write("'${c.calendar_id}'");
      }
      var disabledCalendarsid = disabledCalendarBuffer.toString();
      var result = disabledCalendarsid.substring(0, disabledCalendarsid.length);
      return result;
    } catch (e) {
      Utils.debugLog(e);
    }
    return "";
  }

  Future deleteFromTableCalendar() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_CALENDAR');
  }
}
