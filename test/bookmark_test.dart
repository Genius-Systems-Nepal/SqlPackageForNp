import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:sqflite/sqflite.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From BookmarkTable ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'pId': 1,
      'title': 'hello title',
      'description': 'desc',
      'content': 'fitsr content',
      'link': 'www.google.com',
      'enclosure_url': 'www.google.com',
      'enclosure_type': 'one',
      'source': 'first source',
      'category': 'book',
      'author': 'me',
      'image': 'this is my image',
      'uuid': '20',
      'fetchDate': '2022/11/1',
      'pub_date': "2022/11/1",
      'update_date': "2022/11/1",
      'read': 0,
      'bookmarked': 1,
    };
    await dbHelper.insertOnBookMarkTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'pId': 1,
        'title': 'hello title',
        'description': 'desc',
        'content': 'fitsr content',
        'link': 'www.google.com',
        'enclosure_url': 'www.google.com',
        'enclosure_type': 'one',
        'source': 'first source',
        'category': 'book',
        'author': 'me',
        'image': 'this is my image',
        'uuid': '20',
        'fetchDate': '2022/11/1',
        'pub_date': "2022/11/1",
        'update_date': "2022/11/1",
        'read': 0,
        'bookmarked': 1,
      }
    ];

    var result = await dbHelper.getFromBookMark();
    expect(result, getvalue);
    await db.close();
  });

  test("Update From Table Blog", () async {
    await dbHelper.updateBookMarkTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'pId': 1,
        'title': 'hello title',
        'description': 'desc',
        'content': 'fitsr content',
        'link': 'www.google.com',
        'enclosure_url': 'www.google.com',
        'enclosure_type': 'one',
        'source': 'first source',
        'category': 'book',
        'author': 'me',
        'image': 'this is my image',
        'uuid': '20',
        'fetchDate': '2022/11/1',
        'pub_date': "2022/11/1",
        'update_date': "2022/11/1",
        'read': 1,
        'bookmarked': 1,
      }
    ];

    var result = await dbHelper.getFromBookMark();
    expect(result, getUpdatedvalue);
    await db.close();
  });

  test("Deleted From Table Message", () async {
    var result = await dbHelper.deleteFromTableBookMark();
    expect(result, null);
  });
}
