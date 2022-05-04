// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/models/holidaysmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;

class HolidaysQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnHolidaysTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_HOLIDAYS, parameter);
  }

  Future deleteFromTableHolidays() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_HOLIDAYS');
  }

  Future<int?> updateForTableHolidays() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_HOLIDAYS SET status=1 WHERE status=0');
  }

  Future<List<Map<String, dynamic>>?> getFromHolidays() async {
    Database? db = await databaseHelper.database;
    return await db?.rawQuery("Select * from $DB_TABLE_HOLIDAYS where id = 1");
  }

  insertHolidays(HolidaysList model) async {
    await deleteHolidays();

    Database? db = await databaseHelper.database;

    for (int i = 0; i < model.holidaysList!.length; i++) {
      try {
        String query =
            "INSERT INTO $DB_TABLE_HOLIDAYS (id,eventId,eventDate,holidayType,status,createdAt,updatedAt,deletedAt) VALUES(?,?,?,?,?,?,?,?)";
        return await db?.rawQuery(
          query,
          [
            model.holidaysList![i].id,
            model.holidaysList![i].eventId ?? "",
            model.holidaysList![i].eventDate?.toIso8601String() ?? "",
            model.holidaysList![i].holidayType ?? "",
            model.holidaysList![i].status ?? "",
            model.holidaysList![i].createdAt?.toIso8601String() ?? "",
            model.holidaysList![i].updatedAt?.toIso8601String() ?? "",
            model.holidaysList![i].deletedAt ?? ""
          ],
        );
      } catch (e) {
        Utils.debugLog(e);
      }
    }
  }

  Future<bool> deleteHolidays() async {
    try {
      Database? db = await databaseHelper.database;
      await db?.rawDelete("DELETE FROM $DB_TABLE_HOLIDAYS");
      return true;
    } catch (e) {
      Utils.debugLog(e);
      return false;
    }
  }

  Future<List<HolidaysModel>> getAllHolidays(
      DateTime? startDate, DateTime? endDate) async {
    Database? db = await databaseHelper.database;
//    DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString)
    try {
      String query =
          "SELECT * FROM $DB_TABLE_HOLIDAYS WHERE eventDate>='${startDate?.toIso8601String()}'";

      if (endDate != null) {
        query += " and eventDate<='${endDate.toIso8601String()}' ";
      } else {
        query += " ORDER BY date(eventDate) ASC";
      }
//          "SELECT * FROM $DB_TABLE_HOLIDAYS";
      final result = await db?.rawQuery(query);
      List<HolidaysModel> list = result!.isNotEmpty
          ? await compute(holidaysModelFromJson, result)
          : [];
//      List<HolidaysModel> list = result.isNotEmpty
//          ? result.map((c) => HolidaysModel.fromJsonView(c)).toList()
//          : [];
      return list;
    } catch (e) {
      return [];
    }
  }

  getGovernmentHolidaysFromWeb(DateTime from, DateTime to) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "select EventsTable.title, CacheTable.date as start_date,EventsTable.important_event,EventsTable.gh,EventsDb.description,EventsTable.calendar_id,EventsTable.id from EventsTable INNER JOIN HolidaysTable ON EventsTable.id=HolidaysTable.eventId WHERE HolidaysTable.eventDate>=? AND HolidaysTable.eventDate<=? AND EventsTable.gh=1 ORDER BY HolidaysTable.eventDate ASC";
      var results = await db
          ?.rawQuery(query, [from.toIso8601String(), to.toIso8601String()]);
      List<dynamic> eventsList = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return eventsList;
    } catch (e) {
      return null;
    }
  }

  /*Gets list of events from the cache with having the flag gh=1 in the events lists.*/
  getGovernmentHolidays(DateTime from, DateTime to) async {
    try {
      Database? db = await databaseHelper.database;
      var query =
          "select EventsTable.title,CacheTable.date as start_date,EventsTable.important_event,EventsTable.gh,EventsTable.description,EventsTable.calendar_id,EventsTable.id from EventsTable INNER JOIN CacheTable ON EventsTable.id=CacheTable.event_id WHERE CacheTable.date>=? AND CacheTable.date<=? AND EventsTable.gh=1 ORDER BY CacheTable.date ASC";
      var results = await db
          ?.rawQuery(query, [from.toIso8601String(), to.toIso8601String()]);
      List<dynamic> eventLists = results!
          .map((Map model) => prefix0.Event.fromDbJson(model.cast()))
          .toList();
      return eventLists;
    } catch (e) {
      return null;
    }
  }
}
