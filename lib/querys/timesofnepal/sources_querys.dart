import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class SourcesQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnSourcesTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_SOURCES, parameter);
  }

  Future deleteFromTableSources() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_SOURCES');
  }

  Future<int?> updateForTableSources() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_SOURCES SET ga="gooo" WHERE ga="ga"');
  }

  Future<List<Map<String, dynamic>>?> getFromSources() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_SOURCES);
  }
}
