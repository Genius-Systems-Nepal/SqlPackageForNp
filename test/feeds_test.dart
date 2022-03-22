import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Feeds ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'newsId': 'newsId',
      'title': 'hi en',
      'description': 'description',
      'content': 'www.content.com.np',
      'link': 'www.content.com.np',
      'enclosure_url': 'www.youtube.com.np',
      'enclosure_type': 'typeone',
      'source': 'source',
      'category': 'category',
      'author': 'author',
      'image': 'image',
      'uuid': 'uuid',
      'fetchDate': '2022/2/2',
      'pub_date': '2012/2/2',
      'update_date': '2012/2/2',
      'read': 0,
      'bookmarked': 0
    };
    await dbHelper.insertOnFeedsTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'newsId': 'newsId',
        'title': 'hi en',
        'description': 'description',
        'content': 'www.content.com.np',
        'link': 'www.content.com.np',
        'enclosure_url': 'www.youtube.com.np',
        'enclosure_type': 'typeone',
        'source': 'source',
        'category': 'category',
        'author': 'author',
        'image': 'image',
        'uuid': 'uuid',
        'fetchDate': '2022/2/2',
        'pub_date': '2012/2/2',
        'update_date': '2012/2/2',
        'read': 0,
        'bookmarked': 0
      }
    ];

    var result = await dbHelper.getFromFeeds();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table AMessage", () async {
    await dbHelper.updateFeedsTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'newsId': 'newsId',
        'title': 'hi en',
        'description': 'description',
        'content': 'www.content.com.np',
        'link': 'www.content.com.np',
        'enclosure_url': 'www.youtube.com.np',
        'enclosure_type': 'typeone',
        'source': 'source',
        'category': 'category',
        'author': 'author',
        'image': 'image',
        'uuid': 'uuid',
        'fetchDate': '2022/2/2',
        'pub_date': '2012/2/2',
        'update_date': '2012/2/2',
        'read': 1,
        'bookmarked': 0
      }
    ];

    var result = await dbHelper.getFromFeeds();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table AMessage", () async {
    var result = await dbHelper.deleteFromTableFeeds();
    expect(result, null);
  });
}
