// ignore_for_file: unused_local_variable

import 'package:nepali_patro_sql_package/models/deleteReminderModel.dart';
import 'package:nepali_patro_sql_package/models/remindersmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart' as cm;

class RemindersQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<bool> insertReminders(Map<String, dynamic> reminder) async {
    try {
      Database? db = await databaseHelper.database;
      await db?.insert(DB_TABLE_REMINDERS, reminder,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return true;
    } catch (e) {
      Utils.debugLog("REMINDERSINSERTEXCEPTION--$e");
      return false;
    }
  }

  Future<bool> insertRemindersList(List<RemindersModel> reminderslists,
      {force = false}) async {
    try {
      Database? db = await databaseHelper.database;
      for (int i = 0; i < reminderslists.length; i++) {
        var reminderItem = reminderslists[i];
        var reminderInDb = await getReminderById(reminderItem.id);
        if (reminderInDb != null) {
          if (force) {
            await updateReminder(reminderItem);
          } else if (reminderItem.updatedAt!.isAfter(reminderInDb.updatedAt!)) {
            await updateReminder(reminderItem);
          }
        } else {
          db?.insert(DB_TABLE_REMINDERS, reminderItem.toJson());
        }
      }
      return true;
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  Future<RemindersModel?> getReminderById(reminderId) async {
    Database? db = await databaseHelper.database;
    var results = await db
        ?.query(DB_TABLE_REMINDERS, where: "id=?", whereArgs: [reminderId]);
    var calendarLists = results
        ?.map((Map model) => cm.Calendar.fromJson(model.cast()))
        .toList();
    List<RemindersModel> reminderLists = results!
        .map((Map model) => RemindersModel.fromJson(model.cast()))
        .toList();
    if (reminderLists.isNotEmpty) {
      return reminderLists[0];
    } else {
      return null;
    }
  }

  Future<List<Map<String, Object?>>?> getRemindersByEventId(eventId) async {
    Database? db = await databaseHelper.database;
    var results = await db
        ?.query(DB_TABLE_REMINDERS, where: "event_id=?", whereArgs: [eventId]);
    return results;
  }

  Future<bool> updateReminderWithMap(Map<String, dynamic> reminder) async {
    try {
      Database? db = await databaseHelper.database;
      var reminderModel = await getReminderById(reminder["id"]);
      if (reminderModel == null) {
        await insertReminders(reminder);
        return true;
      } else {
        await db?.update(DB_TABLE_REMINDERS, reminder,
            where: "id=?", whereArgs: [reminder["id"]]);
        return true;
      }
    } catch (e) {
      Utils.debugLog("REMINDERSINSERTEXCEPTION--$e");
      return false;
    }
  }

  Future<bool> updateReminder(RemindersModel reminderItem) async {
    try {
      Database? db = await databaseHelper.database;
      await db?.update(DB_TABLE_REMINDERS, reminderItem.toJson(),
          where: "id=?", whereArgs: [reminderItem.id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DeleteReminderModel>> getSyncDeletedReminders(
      {loadAll = false, String? time}) async {
    try {
      Database? db = await databaseHelper.database;
      var results = <Map<String, dynamic>>[];
      if (!loadAll) {
        var timestamp = time ??
            await PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
        results = await db!.query(DB_TABLE_DELETE_REMINDERS,
            where: "updated_at>=?", whereArgs: [timestamp]);
      } else {
        results = await db!.query(DB_TABLE_DELETE_REMINDERS);
      }
      var deletedReminderList = results
          .map((Map model) => DeleteReminderModel.fromJson(model.cast()))
          .toList();
      return deletedReminderList;
    } catch (e) {
      Utils.debugLog(e);
    }
    return [];
  }

  Future<bool> deleteRemindersWithEventid(String id) async {
    try {
      Database? db = await databaseHelper.database;
      await db
          ?.delete(DB_TABLE_REMINDERS, where: "event_id=?", whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> getSyncPendingReminders(
      {loadAll = false, String? syncTime}) async {
    Database? db = await databaseHelper.database;
    await databaseHelper.initializeTimeZone();
    List<Map> resultLists = [];
    var results = [];
    if (!loadAll) {
      var syncTimeStamp =
          syncTime ?? PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
      results = await db!.query(DB_TABLE_REMINDERS,
          where: "updated_at>=?", whereArgs: [syncTimeStamp]);
    } else {
      results = await db!.query(DB_TABLE_REMINDERS);
    }
    for (Map resultItem in results) {
      Map resultingMap = {};
      resultItem.forEach((key, value) {
        if (key == "updated_at") {
          DateTime updateTime = CalendarUtils.getCalendarFromString(value);
          resultingMap.putIfAbsent(
              key, () => CalendarUtils.formatCalendar(updateTime, DATE_FORMAT));
        } else if (key == "created_at") {
          DateTime createdTime = CalendarUtils.getCalendarFromString(value);
          resultingMap.putIfAbsent(key,
              () => CalendarUtils.formatCalendar(createdTime, DATE_FORMAT));
        } else {
          resultingMap.putIfAbsent(key, () => value);
        }
      });
      resultLists.add(resultingMap);
    }
    return resultLists;
  }

  deleteUserRemindersFromReminderId(String reminderId) async {
    try {
      Database? db = await databaseHelper.database;
      var reminderModel = await getReminderById(reminderId);
      deleteUserReminders(reminderModel!);
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  deleteUserReminders(RemindersModel remindersModel) async {
    Database? db = await databaseHelper.database;
    await databaseHelper.initializeTimeZone();
    try {
      await db?.delete(DB_TABLE_REMINDERS,
          where: "id = ?", whereArgs: [remindersModel.id]);
    } catch (e) {
      Utils.debugLog(e);
    }
    try {
      DeleteReminderModel deleteReminderModel = DeleteReminderModel(
          id: null,
          eventId: remindersModel.eventId,
          reminderId: remindersModel.id,
          createdAt: Timezone().curDateTimeByZone("NPT"),
          updatedAt: Timezone().curDateTimeByZone("NPT"));
      return await db?.insert(
          DB_TABLE_DELETE_REMINDERS, deleteReminderModel.toJson());
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  deleteDeletedReminders() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_DELETE_REMINDERS');
  }
}
