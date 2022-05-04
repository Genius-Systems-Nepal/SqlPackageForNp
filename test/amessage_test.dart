import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/models/amessage_option_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';
import 'test_parameter.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('insertAmessages ', () async {
    Content content = messagecontent;
    List<Content> contents = [content];
    await dbHelper.insertAmessages(contents);
    var actualOutput = await dbHelper.getAmessageById('1');
    var expectedOuput = actualOutput;
    expect(expectedOuput == actualOutput, true);
    await dbHelper.close();
  });

  test("updateMessageTable", () async {
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
    await dbHelper.updateAmessage(updatedmessage);
    Content expectedOuput = Content(
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
    var actualOutput = await dbHelper.getAmessageById('1');
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });

  test("getAmessages", () async {
    List<Content> expectedOuput = [
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
  test("getAmessageById", () async {
    Content expectedOutput = Content(
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
  test("cancelAmessage", () async {
    Content amessage = Content(
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
    var actualOutput = await dbHelper.cancelAmessage(amessage);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("parseAmessage", () async {
    List<Map<dynamic, dynamic>> arg = [
      {
        AMessageDb.id: "1",
        AMessageDb.linktype: 'typeone',
        AMessageDb.link: 'www.google.com.np',
        AMessageDb.expiry: '30-06-2121',
        AMessageDb.aflag: 'hi flag',
        AMessageDb.pin: '2222',
        AMessageDb.enable: 'yes',
      }
    ];
    var actualOutput = await dbHelper.parseAmessage(arg);
    List<Content> expectedOutput = [
      Content(
          id: '1',
          messageEn: null,
          messageNp: null,
          linktype: 'typeone',
          link: 'www.google.com.np',
          stdate: null,
          expiry: '30-06-2121',
          aflag: 'hi flag',
          pin: '2222',
          enable: 'yes',
          options: null,
          dorder: null,
          cancelled: 0)
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("DeletedAMessage", () async {
    var result = await dbHelper.deleteFromTableMessage();
    expect(result, null);
  });
}
