import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class BlogQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  Future<int?> insertDataOnBlogTable(Map<String, dynamic> parameter) async {
    Database? db = await databaseHelper.database;
    return await db?.insert(DB_TABLE_BLOG, parameter);
  }

  Future deleteFromTableBlog() async {
    Database? db = await databaseHelper.database;
    return await db?.execute('Delete From $DB_TABLE_BLOG');
  }

  Future<int?> updateForTableBlog() async {
    Database? db = await databaseHelper.database;
    return await db
        ?.rawUpdate('UPDATE $DB_TABLE_BLOG SET isread=1 WHERE isread=0');
  }

  Future<List<Map<String, dynamic>>?> getFromBlog() async {
    Database? db = await databaseHelper.database;
    return await db?.query(DB_TABLE_BLOG);
  }
}
