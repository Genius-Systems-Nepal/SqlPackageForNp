import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnCategoriesTable(
      Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_CATEGORIES, parameter);
  }

  Future deleteFromTableCategories() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_CATEGORIES');
  }

  Future<int?> updateForTableCategories() async {
    Database? db = await databaseHelper.database;
    return await db?.rawUpdate(
        'UPDATE $DB_TABLE_CATEGORIES SET enable="false" WHERE enable="true"');
  }

  Future<List<Map<String, dynamic>>?> getFromCategories() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_CATEGORIES);
  }
}
