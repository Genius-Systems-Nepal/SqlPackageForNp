import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class PanchangaDbQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<bool?> insertPanchangaData(
      String np, String en, String ddNp, String ddEn, String date) async {
    try {
      Database? db = await databaseHelper.database;
      var results = await getPanchangaByDate(date);
      if (results!.isNotEmpty) {
        await db
            ?.delete(DB_TABLE_PANCHANGA, where: 'date=?', whereArgs: [date]);
      }
      var query =
          "INSERT INTO $DB_TABLE_PANCHANGA(date,text_np,text_en,text_ddnp,text_dden) VALUES (?,?,?,?,?)";
      await db?.rawQuery(query, [date, np, en, ddNp, ddEn]);
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<List<Map>?> getPanchangaByDate(String date) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "SELECT * FROM $DB_TABLE_PANCHANGA WHERE date=?";
      var result = await db?.rawQuery(query, [date]);
      return result;
    } catch (e) {
      Utils.debugLog(e);
    }
    return <Map>[];
  }

  Future deleteFromTablePanchangaDb() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_PANCHANGA');
  }
}
