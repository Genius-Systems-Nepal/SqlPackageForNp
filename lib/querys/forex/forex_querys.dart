import 'package:intl/intl.dart';
import 'package:nepali_patro_sql_package/models/forexmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:sqflite/sqflite.dart';

class ForexQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future deleteForexDetails() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_FOREX_DETAIL');
  }

  Future<bool> insertToForexDetail(int id, ForexModel model) async {
    Database? db = await databaseHelper.database;
    try {
      for (Datum forexItem in model.data!) {
        String query =
            "INSERT INTO $DB_TABLE_FOREX_DETAIL (pid, type, code, currency, unit, buying, selling) VALUES(?,?,?,?,?,?,?)";
        await db?.rawQuery(query, [
          id,
          forexItem.type,
          forexItem.code,
          forexItem.currency,
          forexItem.unit,
          forexItem.buying,
          forexItem.selling
        ]);
        ConflictAlgorithm.ignore;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertForex(ForexModel model) async {
    Database? db = await databaseHelper.database;
    try {
      var parsedDate = DateTime.parse(model.date!);
      String formatedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
      await deleteForex(formatedDate);
      var insertForex = await insertToForex(formatedDate, model);
      if (insertForex) {
        String idQuery =
            "SELECT * FROM $DB_TABLE_FOREX WHERE id = (SELECT MAX(id) FROM $DB_TABLE_FOREX)";
        var result = await db?.rawQuery(idQuery);
        dynamic id = result![0]["id"];
        var insertForexDetail = await insertToForexDetail(id, model);
        if (insertForexDetail) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertToForex(String formatedDate, ForexModel model) async {
    Database? db = await databaseHelper.database;
    try {
      String query = "INSERT INTO $DB_TABLE_FOREX  (fordate,source,"
          "source_url) VALUES(?,?,?)";
      await db?.rawQuery(query, [formatedDate, model.source, model.sourceUrl]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteForex(String date) async {
    Database? db = await databaseHelper.database;
    try {
      //Get id of forex data to be deleted
      String getIdQuery =
          "SELECT id FROM $DB_TABLE_FOREX where fordate = '$date'";
      var result = await db?.rawQuery(getIdQuery);
      if (result != null) {
        dynamic forexId = result[0]["id"];
        //Delete from forex detail table
        String forexDelete =
            "DELETE FROM $DB_TABLE_FOREX_DETAIL WHERE pid = '$forexId'";
        await db?.rawQuery(forexDelete);
        //Delete from forex table
        String query = "DELETE FROM $DB_TABLE_FOREX WHERE fordate = '$date'";
        await db?.rawQuery(query);
        return true;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> forexCount() async {
    Database? db = await databaseHelper.database;
    try {
      String query = "SELECT count(*) cnt FROM $DB_TABLE_FOREX";
      var result = await db?.rawQuery(query);
      var countData = result![0]["cnt"];
      return countData;
    } catch (e) {
      return 0;
    }
  }

  Future<List<Map>?> getForex(String forDate) async {
    Database? db = await databaseHelper.database;
    try {
      String query = "SELECT * FROM $DB_TABLE_FOREX WHERE fordate = '$forDate'";
      List<Map> result = await db!.rawQuery(query);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map>?> latestForex() async {
    Database? db = await databaseHelper.database;
    await databaseHelper.initializeTimeZone();
    try {
      DateTime now = Timezone().curDateTimeByZone("NPT");
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      /* String query =
          "SELECT * FROM $DB_TABLE_FOREX WHERE fordate = (select max(fordate) from $DB_TABLE_FOREX)";*/
      String query =
          "SELECT * FROM $DB_TABLE_FOREX WHERE fordate = '${dateFormat.format(now)}'";
      var result = await db?.rawQuery(query);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<Datum>?> getForexDetail(int forexId) async {
    Database? db = await databaseHelper.database;
    await databaseHelper.database;
    try {
      String query =
          "SELECT * FROM $DB_TABLE_FOREX_DETAIL WHERE pid = '$forexId'";
      var result = await db?.rawQuery(query);
      List<Datum> forexList =
          result!.map((Map model) => Datum.fromJson(model.cast())).toList();
      return forexList;
    } catch (e) {
      return null;
    }
  }
}
