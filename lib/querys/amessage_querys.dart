import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class MessageQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<dynamic> insertAmessages(List<Content> amessages) async {
    try {
      Database? db = await databaseHelper.database;
      List<String?> ids = [];
      for (Content content in amessages) {
        ids.add(content.id);
        var amessage = await getAmessageById(content.id);
        if (amessage != null) {
          updateAmessage(content);
        } else {
          await db?.insert(DB_TABLE_AMESSAGE, content.toJson(),
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      }
      String query =
          "DELETE FROM $DB_TABLE_AMESSAGE where id not in ( ${ids.join(" , ")} )";
      await db?.rawQuery(query);
    } catch (e) {
      Utils.debugLog(e);
      return;
    }
  }

  Future<int> updateAmessage(Content newAMessage) async {
    var oldAMessageMap = (await getAmessageById(newAMessage.id))?.toJson();
    if (oldAMessageMap == null) {
      return 0;
    }
    try {
      Database? db = await databaseHelper.database;
      for (var item in newAMessage.toJson().entries) {
        if (item.value != null) {
          oldAMessageMap[item.key] = item.value;
        }
      }
      var result = await db?.update(DB_TABLE_AMESSAGE, oldAMessageMap);
      return result ?? 0;
    } catch (e) {
      Utils.debugLog(e);
    }
    return 0;
  }

  Future<dynamic> getAmessageById(id) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_AMESSAGE WHERE id=$id";
      List<Map<String, Object?>> results = await db!.rawQuery(query);

      var amessageList =
          results.map((var model) => Content.fromDbJson(model)).toList();

      if (amessageList.isNotEmpty) {
        return amessageList[0];
      } else {
        return null;
      }
    } catch (e) {
      Utils.debugLog(e);
      return null;
    }
  }

  Future<List<Content>> getAmessages() async {
    Database? db = await databaseHelper.database;
    var query = "SELECT * FROM $DB_TABLE_AMESSAGE";
    List<Content> finalAmessages = [];
    List<Map> results = await db!.rawQuery(query);
    try {
      finalAmessages = await compute(parseAmessage, results);
    } catch (e) {
      Utils.debugLog(e);
    }
    return finalAmessages;
  }

  Future<bool> cancelAmessage(Content amessage) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "UPDATE $DB_TABLE_AMESSAGE SET message_np=?,message_en=?,"
          "linktype=?,link=?,stdate=?,expiry=?,aflag=?,pin=?,"
          "createdAt=?,enable=?,options=?,dorder=?,cancelled=? WHERE id='${amessage.id}'";
      await db?.rawQuery(query, [
        amessage.messageNp,
        amessage.messageEn,
        amessage.linktype,
        amessage.link,
        amessage.stdate?.toIso8601String(),
        amessage.expiry,
        amessage.aflag,
        amessage.pin,
        "",
        amessage.enable,
        jsonEncode(amessage.options),
        amessage.dorder,
        amessage.cancelled
      ]);
      return true;
    } catch (e) {
      Utils.debugLog(e);
      return false;
    }
  }

  Future<List<Content>> parseAmessage(List<Map> args) async {
    List<Content> amessages =
        args.map((Map model) => Content.fromDbJson(model.cast())).toList();
    return amessages;
  }

  Future deleteFromTableMessage() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_AMESSAGE');
  }
}
