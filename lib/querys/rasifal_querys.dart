// ignore_for_file: prefer_is_empty

import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class RashifalQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnRasifalTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_RASHIFAL, parameter);
  }

  Future<dynamic> insertRashifal(List<Np> model) async {
    Database? db = await databaseHelper.database;
    for (Np rashifalItem in model) {
      if (rashifalItem.title != null) {
        var dbRashifal = await getRashifalByTag(rashifalItem.type);
        if (dbRashifal != null) {
          return await db!.update(DB_TABLE_RASHIFAL, rashifalItem.toJson(),
              where: 'type = ?', whereArgs: [dbRashifal.type]);
        } else {
          return await db?.insert(DB_TABLE_RASHIFAL, rashifalItem.toJson());
        }
      }
    }
  }

  Future<Np?> getRashifalByTag(var tag) async {
    Database? db = await databaseHelper.database;
    try {
      var query = "SELECT * FROM $DB_TABLE_RASHIFAL WHERE type='$tag'";
      List<Map<String, dynamic>>? result = await db!.rawQuery(query);
      List<Np>? rashifalLists = result
          .map((Map<String, dynamic> model) => Np.fromJson(model))
          .toList();
      if (rashifalLists.length > 0) {
        return rashifalLists[0];
      } else {
        return null;
      }
    } catch (e) {
      // Utils.debugLog(e);
      return null;
    }
  }

  Future deleteFromTableRashifal(String tag) async {
    Database? db = await databaseHelper.database;
    return await db
        ?.execute("Delete From $DB_TABLE_RASHIFAL where type = '$tag'");
  }
}
