import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/models/amessage_option_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data and Get Data From AMessage ', () async {
    // final file = File('lib/api/amessage/amessage.json');
    // final json = jsonDecode(await file.readAsString());
    final jsonString =
        await File("lib/api/amessage/amessage.json").readAsString();
    final contacts = json.decode(jsonString)["Content"];
    dynamic outputFromjson = contacts[0];
    dynamic content = Content(
      id: '1',
      messageNp: 'hi np',
      messageEn: 'hi en',
      linktype: 'typeone',
      link: 'www.google.com.np',
      stdate: DateTime(2021, 06, 2),
      expiry: '30-06-2121',
      aflag: 'hi flag',
      pin: '2222',
      enable: 'yes',
      options: AMessageOption(
        footer_action_text: 'hi',
        image: 'hello.png',
        thumbnail: 'thumbnail.png',
        subtitle: Title(en: 'en'),
        title: Title(en: 'en'),
      ),
      dorder: 'hi dorder',
      cancelled: 0,
    );
    List<Content> contents = [content];
    // dynamic contents = [contacts];
    await dbHelper.insertOrUpdateAMessages(contents);
    var actualOutput = await dbHelper.getFromMessage('1');
    var expectedOuput = outputFromjson;
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });

  test("Update From Table AMessage", () async {
    // var updatemessage = Content.fromJson("")
    // var expetedMesage = Content.fromJson("")
    Content updatedmessage = Content(
        id: '1',
        messageNp: 'hello nepali',
        messageEn: 'hello english ad',
        linktype: 'typeone',
        link: 'www.google.com.np',
        stdate: DateTime(2021, 06, 2),
        expiry: '30-06-2121',
        aflag: 'hi flag',
        pin: '2222',
        enable: 'yes');
    await dbHelper.updateMessageTable(updatedmessage);
    dynamic expectedOuput = Content(
        id: '1',
        messageNp: 'hello nepali',
        messageEn: 'hello english ad',
        linktype: 'typeone',
        link: 'www.google.com.np',
        stdate: DateTime(2021, 06, 2),
        expiry: '30-06-2121',
        aflag: 'hi flag',
        pin: '2222',
        enable: 'yes',
        options: AMessageOption(
          footer_action_text: 'hi',
          image: 'hello.png',
          thumbnail: 'thumbnail.png',
          subtitle: Title(en: 'en'),
          title: Title(
            en: 'en',
          ),
        ),
        dorder: 'hi dorder',
        cancelled: 0);
    var actualOutput = await dbHelper.getFromMessage('1');
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });

  test("getAmessages", () async {
    dynamic expectedOuput = [
      Content(
        id: '1',
        messageNp: 'hello nepali',
        messageEn: 'hello english ad',
        linktype: 'typeone',
        link: 'www.google.com.np',
        stdate: DateTime(2021, 06, 2),
        expiry: '30-06-2121',
        aflag: 'hi flag',
        pin: '2222',
        enable: 'yes',
        options: AMessageOption(
          footer_action_text: 'hi',
          image: 'hello.png',
          thumbnail: 'thumbnail.png',
          subtitle: Title(en: 'en'),
          title: Title(en: 'en'),
        ),
        dorder: 'hi dorder',
        cancelled: 0,
      )
    ];
    var actualOutput = await dbHelper.getAmessages();
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });
  test("getAMessage By Id", () async {
    dynamic expectedOutput = Content(
        id: '1',
        messageNp: 'hello nepali',
        messageEn: 'hello english ad',
        linktype: 'typeone',
        link: 'www.google.com.np',
        stdate: DateTime(2021, 06, 2),
        expiry: '30-06-2121',
        aflag: 'hi flag',
        pin: '2222',
        enable: 'yes',
        options: AMessageOption(
          footer_action_text: 'hi',
          image: 'hello.png',
          thumbnail: 'thumbnail.png',
          subtitle: Title(en: 'en'),
          title: Title(en: 'en'),
        ),
        dorder: 'hi dorder',
        cancelled: 0);
    var actualOutput = await dbHelper.getAmessageById('1');
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("Deleted From Table AMessage", () async {
    var result = await dbHelper.deleteFromTableMessage();
    expect(result, null);
  });
}
