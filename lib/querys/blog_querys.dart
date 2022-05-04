import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:nepali_patro_sql_package/models/blog_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class BlogQuerys {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  Future<bool?> insertBlog(BlogModel model) async {
    Database? db = await databaseHelper.database;
    try {
      for (int i = 0; i < model.posts!.length; i++) {
        try {
          String query =
              "INSERT INTO $DB_TABLE_BLOG (id,date,modified,url,title,content,excerpt,thumbnail,categories,tags,author,comments,comment_count,thumbnail_images,readdate,isread,ignore,event) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
          await db?.execute(query, [
            model.posts![i].id,
            model.posts![i].date,
            model.posts![i].modified,
            model.posts![i].author!.url,
            model.posts![i].title,
            model.posts![i].content,
            model.posts![i].excerpt,
            model.posts![i].thumbnail,
            "",
            //categories
            jsonEncode(model.posts![i].tags) /*model.posts[i].tags.toString()*/,
            //tags
            jsonEncode(model.posts![i].author),
            "",
            //comments
            model.posts![i].commentCount,
            jsonEncode(model.posts![i].thumbnailImages),
            // jsonDecode(jsonEncode(model.posts![i].thumbnailImages)),
            //thumbnail_images
            "",
            //readdate
            0,
            //isread
            0,
            //ignore
            0,
            //event
          ]);
        } catch (e) {
          Utils.debugLog(e);
        }
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateBlog(BlogModel blogs, int id) async {
    Database? db = await databaseHelper.database;
    try {
      for (int i = 0; i < blogs.count!; i++) {
        String query =
            "UPDATE $DB_TABLE_BLOG SET url = ?, categories = ?, tags = ?, content = ?, comments = ? WHERE id='$id'";
        await db!.rawUpdate(query, [
          blogs.posts![i].url,
          jsonEncode(blogs.posts![i].categories),
          jsonEncode(blogs.posts![i].tags),
          blogs.posts![i].content,
          jsonEncode(blogs.posts![i].comments)
        ]);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List?> getBlogById(id) async {
    Database? db = await databaseHelper.database;
    try {
      String query = "Select * From $DB_TABLE_BLOG where id = $id";
      var result = db?.rawQuery(query);
      return result;
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<String> getBlogDateTime(bool latest) async {
    Database? db = await databaseHelper.database;
    try {
      String query = "";
      if (!latest) {
        query =
            "SELECT modified FROM $DB_TABLE_BLOG ORDER BY modified ASC LIMIT 1";
      } else {
        query =
            "SELECT modified FROM $DB_TABLE_BLOG ORDER BY modified DESC LIMIT 1";
      }
      var result = await db?.rawQuery(query);
      if (result!.isNotEmpty) {
        var parsedDate =
            DateTime.parse(result.toList()[0]["modified"].toString());
        return DateFormat("yyyyMMdd").format(parsedDate);
      }
    } catch (e) {
      return "";
    }
    return "";
  }

  Future<List<Post>?> loadBlogs(int id) async {
    Database? db = await databaseHelper.database;
    try {
      List<Post>? blogLists = <Post>[];
      if (id == 0) {
        String query = "SELECT * FROM $DB_TABLE_BLOG ORDER BY modified DESC";
        var results = await db?.rawQuery(query);
        blogLists =
            results!.map((Map model) => Post.fromDbJson(model.cast())).toList();
      } else {
        String query =
            "SELECT * FROM $DB_TABLE_BLOG WHERE id = '$id' ORDER BY modified DESC";
        var results = await db?.rawQuery(query);
        blogLists = results
            ?.map((Map<String, dynamic> model) => Post.fromDbJson(model))
            .toList();
        return blogLists;
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<List<Post>?> loadDailyBlog(String id) async {
    Database? db = await databaseHelper.database;
    try {
      List<Post> blogLists = <Post>[];
      String query = "SELECT * FROM $DB_TABLE_BLOG WHERE id in ($id) ";
      var results = await db?.rawQuery(query);
      blogLists =
          results!.map((Map model) => Post.fromDbJson(model.cast())).toList();
      return blogLists;
    } catch (e) {
      Utils.debugLog(e);
      return null;
    }
  }

  Future<List<Post>?> loadBlogsByDate(String date) async {
    Database? db = await databaseHelper.database;
    try {
      List<Post> blogLists = <Post>[];
      String query =
          "SELECT * FROM $DB_TABLE_BLOG WHERE modified LIKE '%$date%'";
      var results = await db?.rawQuery(query);
      blogLists =
          results!.map((Map model) => Post.fromDbJson(model.cast())).toList();
      return blogLists;
    } catch (e) {
      return null;
    }
  }

  Future<List?> getSearchBlog(String text) async {
    Database? db = await databaseHelper.database;
    try {
      List blogLists = <Post>[];
      String query = "SELECT * FROM $DB_TABLE_BLOG WHERE tags LIKE '%$text%'";
      var results = await db?.rawQuery(query);
      blogLists = results!
          .map((Map<String, dynamic> model) => Post.fromDbJson(model))
          .toList();
      return blogLists;
    } catch (e) {
      Utils.debugLog(e);
      return null;
    }
  }

  Future<List<List<Post>>?> loadAllBlogs() async {
    Database? db = await databaseHelper.database;
    var query =
        "SELECT * FROM $DB_TABLE_BLOG WHERE isread=0 ORDER BY modified DESC LIMIT 4";
    var results = await db?.rawQuery(query);
    var allblogs =
        results?.map((Map model) => Post.postsFromJson(results).toList());

    return allblogs?.toList();
  }

  Future<bool> setBlogAsRead(Post blogItem) async {
    try {
      Database? db = await databaseHelper.database;
      var query = "UPDATE $DB_TABLE_BLOG SET isread=1 WHERE id=?";
      await db?.rawQuery(query, [blogItem.id]);
      return true;
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  deleteAllBlog() async {
    Database? db = await databaseHelper.database;
    await db?.rawDelete("DELETE FROM $DB_TABLE_BLOG");
  }
}
