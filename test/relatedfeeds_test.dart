import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';

import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From relatedFeeds ', () async {
    Map<String, dynamic> parameter = {
      'id': 1,
      'pId': 1,
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
    await dbHelper.insertOnRelatedFeedsTable(parameter);
    dynamic getvalue = [
      {
        'id': 1,
        'pId': 1,
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

    var result = await dbHelper.getFromRelatedFeeds();
    expect(result, getvalue);
    await dbHelper.close();
  });

  test("Update From Table relatedFeeds", () async {
    await dbHelper.updateRelatedFeedsTable();
    dynamic getUpdatedvalue = [
      {
        'id': 1,
        'pId': 1,
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

    var result = await dbHelper.getFromRelatedFeeds();
    expect(result, getUpdatedvalue);
    await dbHelper.close();
  });

  test("Deleted From Table relatedFeeds", () async {
    var result = await dbHelper.deleteFromTableRelatedFeeds();
    expect(result, null);
  });
}
