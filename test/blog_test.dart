import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From Blog ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'date': '2022/11/1',
      'modified': '2022/11/1',
      'url': 'www.google.com.np',
      'title': 'First blog',
      'content': 'nation',
      'excerpt': 'test excerpt',
      'thumbnail': 'thumbnail one',
      'categories': 'xyz',
      'tags': 'hello tag',
      'author': 'me',
      'comments': 'all comments',
      'comment_count': 20,
      'thumbnail_images': "hello.thumnail",
      'readdate': "2022/11/1",
      'isread': 0,
      'ignore': 1,
      'event': 1
    };
    await dbHelper.insertOnBlogTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'date': '2022/11/1',
        'modified': '2022/11/1',
        'url': 'www.google.com.np',
        'title': 'First blog',
        'content': 'nation',
        'excerpt': 'test excerpt',
        'thumbnail': 'thumbnail one',
        'categories': 'xyz',
        'tags': 'hello tag',
        'author': 'me',
        'comments': 'all comments',
        'comment_count': 20,
        'thumbnail_images': "hello.thumnail",
        'readdate': "2022/11/1",
        'isread': 0,
        'ignore': 1,
        'event': 1
      }
    ];

    var result = await dbHelper.getFromBlogTable();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table Blog", () async {
    await dbHelper.updateBlogTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'date': '2022/11/1',
        'modified': '2022/11/1',
        'url': 'www.google.com.np',
        'title': 'First blog',
        'content': 'nation',
        'excerpt': 'test excerpt',
        'thumbnail': 'thumbnail one',
        'categories': 'xyz',
        'tags': 'hello tag',
        'author': 'me',
        'comments': 'all comments',
        'comment_count': 20,
        'thumbnail_images': "hello.thumnail",
        'readdate': "2022/11/1",
        'isread': 1,
        'ignore': 1,
        'event': 1
      }
    ];

    var result = await dbHelper.getFromBlogTable();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table Blog", () async {
    var result = await dbHelper.deleteFromTableBlog();
    expect(result, null);
  });
}
