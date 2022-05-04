import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/deleteReminderModel.dart';
import 'package:nepali_patro_sql_package/models/remindersmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insertReminders", () async {
    Map<String, dynamic> reminder = {
      RemindersDb.id: 1,
      RemindersDb.event_id: "1",
      RemindersDb.days: 2,
      RemindersDb.time: '2.2',
      RemindersDb.note: 'note',
      RemindersDb.notification_type: "notification_type",
      RemindersDb.updated_at: "2020-01-01",
      RemindersDb.created_at: "2020-01-01"
    };
    await dbHelper.insertReminders(reminder);
    RemindersModel expectedOutput = RemindersModel(
      id: '1',
      eventId: '1',
      days: 2,
      time: '2.2',
      note: 'note',
      notificationType: 'notification_type',
      updatedAt: DateTime.parse("2020-01-01"),
      createdAt: DateTime.parse("2020-01-01"),
    );
    RemindersModel? actualOutput = await dbHelper.getReminderById(1);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getReminderById", () async {
    RemindersModel? actualOutput = await dbHelper.getReminderById(1);
    RemindersModel expectedOutput = RemindersModel(
      id: '1',
      eventId: '1',
      days: 2,
      time: '2.2',
      note: 'note',
      notificationType: 'notification_type',
      updatedAt: DateTime.parse("2020-01-01"),
      createdAt: DateTime.parse("2020-01-01"),
    );
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("insertRemindersList", () async {
    var parameter = [
      RemindersModel(
        id: '1',
        eventId: '1',
        days: 2,
        time: '2.2',
        note: 'note',
        notificationType: 'notification_type',
        updatedAt: DateTime.parse("2020-01-01"),
        createdAt: DateTime.parse("2020-01-01"),
      )
    ];
    var actualOutput = await dbHelper.insertRemindersList(parameter);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getRemindersByEventId", () async {
    List<Map>? actualOutput = await dbHelper.getRemindersByEventId(1);
    var expectedOutput = [
      {
        RemindersDb.id: '1',
        RemindersDb.event_id: '1',
        RemindersDb.days: 2,
        RemindersDb.time: '2.2',
        RemindersDb.note: 'note',
        RemindersDb.notification_type: 'notification_type',
        RemindersDb.updated_at: '2020-01-01',
        RemindersDb.created_at: '2020-01-01'
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("updateReminderWithMap", () async {
    Map<String, dynamic> parameter = {
      RemindersDb.id: '1',
      RemindersDb.event_id: "1",
      RemindersDb.days: 2,
      RemindersDb.time: '2.2',
      RemindersDb.note: 'note',
      RemindersDb.notification_type: "notification_type",
      RemindersDb.updated_at: "2020-01-01",
      RemindersDb.created_at: "2020-01-01"
    };
    var actualOutput = await dbHelper.updateReminderWithMap(parameter);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("udpateReminder", () async {
    RemindersModel reminderItem = RemindersModel(
      id: '1',
      eventId: '1',
      days: 22,
      time: '2.2',
      note: 'note',
      notificationType: 'notification_type',
      updatedAt: DateTime.parse("2020-01-01"),
      createdAt: DateTime.parse("2020-01-01"),
    );
    await dbHelper.udpateReminder(reminderItem);
    var actualOutput = await dbHelper.getReminderById(1);
    var expectedOutput = RemindersModel(
      id: '1',
      eventId: '1',
      days: 22,
      time: '2.2',
      note: 'note',
      notificationType: 'notification_type',
      updatedAt: DateTime.parse("2020-01-01"),
      createdAt: DateTime.parse("2020-01-01"),
    );

    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getSyncPendingReminders", () async {
    List<dynamic> actualOutput = await dbHelper.getSyncPendingReminders(
        loadAll: false, syncTime: "2020-01-01");
    List<dynamic> expectedOutput = [
      {
        RemindersDb.id: "1",
        RemindersDb.event_id: "1",
        RemindersDb.days: 22,
        RemindersDb.time: "2.2",
        RemindersDb.note: "note",
        RemindersDb.notification_type: "notification_type",
        RemindersDb.updated_at: '2020-01-01 05:45:00',
        RemindersDb.created_at: '2020-01-01 05:45:00'
      }
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteRemindersWithEventid", () async {
    bool actualOutput = await dbHelper.deleteRemindersWithEventid("1");
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteUserReminders", () async {
    var remindersModel = RemindersModel(
      id: '1',
      eventId: '1',
      days: 2,
      time: '2.2',
      note: 'note',
      notificationType: 'notification_type',
      updatedAt: DateTime.parse("2020-01-01"),
      createdAt: DateTime.parse("2020-01-01"),
    );
    var actualOutput = await dbHelper.deleteUserReminders(remindersModel);
    bool isInt = (actualOutput % 1) == 0;
    dynamic expectedOutput = true;
    expect(isInt, expectedOutput);
    await dbHelper.close();
  });
  test("getSyncDeletedReminders", () async {
    List<DeleteReminderModel> syncDeletedReminders = await dbHelper
        .getSyncDeletedReminders(loadAll: false, time: "2020-01-01");
    var actualOutput = syncDeletedReminders[0].toJson();
    actualOutput.remove("id");
    actualOutput.remove("created_at");
    actualOutput.remove("updated_at");
    var expectedOutput = {
      DeleteRemindersDB.event_id: "1",
      DeleteRemindersDB.reminder_id: "1"
    };
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("deleteDeletedReminders", () async {
    var actualOutput = await dbHelper.deleteDeletedReminders();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
}
