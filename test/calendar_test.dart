import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test("insertCalendars", () async {
    var calendarList = [
      Calendar(
        id: '1',
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 0,
        createdBy: 'dillibhai',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    var actualOutput = await dbHelper.insertCalendars(calendarList);
    dynamic expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("updateCalendar", () async {
    Calendar calendar = Calendar(
      id: '1',
      name: "test name",
      status: 1,
      calendar_id: '1',
      isModifiable: 1,
      createdBy: 'dilli bhandari',
      isDefault: 1,
      created_at: DateTime.parse("2020-11-01"),
      updated_at: DateTime.parse("2020-11-01"),
      color: 'white',
      priority: 0,
      display: 1,
    );
    var actualOutput = await dbHelper.updateCalendar(calendar);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getAllSortedCalendars", () async {
    var actualOutput = await dbHelper.getAllSortedCalendars();
    var expectedOutput = [
      Calendar(
        id: '1',
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 1,
        createdBy: 'default_user',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getCalendarUser", () async {
    var actualOutput = await dbHelper.getCalendarUser();
    var expectedOutput = [
      Calendar(
        id: '1',
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 1,
        createdBy: 'default_user',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getsortedCalendar", () async {
    var actualOutput = await dbHelper.getsortedCalendar();
    var expectedOutput = [
      Calendar(
        id: "1",
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 1,
        createdBy: 'default_user',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getCalendarById", () async {
    var actualOutput = await dbHelper.getCalendarById(1);
    var expectedOutput = Calendar(
      id: "1",
      name: "test name",
      status: 1,
      calendar_id: '1',
      isModifiable: 1,
      createdBy: 'default_user',
      isDefault: 1,
      created_at: DateTime.parse("2020-11-01"),
      updated_at: DateTime.parse("2020-11-01"),
      color: 'white',
      priority: 0,
      display: 1,
    );
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getEnabledCalendars", () async {
    var actualOutput = await dbHelper.getEnabledCalendars();
    var expectedOutput = "'1'";
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("getSyncPendingCalendars", () async {
    var actualOutput = await dbHelper.getSyncPendingCalendars(loadAll: true);
    var expectedOutput = [
      Calendar(
        id: "1",
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 1,
        createdBy: 'default_user',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("updateCalendarPriority", () async {
    var calendars = [
      Calendar(
        id: "1",
        name: "test name",
        status: 1,
        calendar_id: '1',
        isModifiable: 1,
        createdBy: 'default_user',
        isDefault: 1,
        created_at: DateTime.parse("2020-11-01"),
        updated_at: DateTime.parse("2020-11-01"),
        color: 'white',
        priority: 0,
        display: 1,
      )
    ];
    var actualOutput = await dbHelper.updateCalendarPriority(calendars);
    var expectedOutput = 1;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getEnabledDefaultCalendars", () async {
    var actualOutput =
        await dbHelper.getEnabledDefaultCalendars(defautlCalendar: true);
    var expectedOutput = "'1'";
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("getDisabledCalendars", () async {
    var actualOutput = await dbHelper.getDisabledCalendars();
    var expectedOutput = "'1'";
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("deleteCalendars", () async {
    Calendar calendarItem = Calendar(
      id: '1',
      name: "test name",
      status: 1,
      calendar_id: '1',
      isModifiable: 0,
      createdBy: 'default_user',
      isDefault: 1,
      created_at: DateTime.parse("2020-11-01"),
      updated_at: DateTime.parse("2020-11-01"),
      color: 'white',
      priority: 0,
      display: 1,
    );
    var actualOutput = await dbHelper.deleteCalendars(calendarItem);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Deleted From Table Calendar", () async {
    var actualOutput = await dbHelper.deleteFromTableCalendar();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
}
