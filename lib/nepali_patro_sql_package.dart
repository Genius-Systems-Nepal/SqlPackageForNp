// ignore_for_file: prefer_const_declarations

library nepali_patro_sql_package;

import 'dart:io';
import 'package:nepali_patro_sql_package/database/database_tables.dart';
import 'package:nepali_patro_sql_package/querys/blog_querys.dart';
import 'package:nepali_patro_sql_package/querys/cachedb_querys.dart';
import 'package:nepali_patro_sql_package/querys/calendar_querys.dart';
import 'package:nepali_patro_sql_package/querys/deleted_event.dart';
import 'package:nepali_patro_sql_package/querys/deleted_reminder_querys.dart';
import 'package:nepali_patro_sql_package/querys/events_querys.dart';
import 'package:nepali_patro_sql_package/querys/exceptions_querys.dart';
import 'package:nepali_patro_sql_package/querys/forex_details_querys.dart';
import 'package:nepali_patro_sql_package/querys/forex_querys.dart';
import 'package:nepali_patro_sql_package/querys/holidays_querys.dart';
import 'package:nepali_patro_sql_package/querys/message_querys.dart';
import 'package:nepali_patro_sql_package/querys/panchangadb_querys.dart';
import 'package:nepali_patro_sql_package/querys/rasifal_querys.dart';
import 'package:nepali_patro_sql_package/querys/reminders_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/bookmark_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/categories_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/feeds_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/related_feeds_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/sources_querys.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final dbName = 'np.db';
  final dbVersion = 1;
  Database? _database;
  final DatabaseTable _databaseTable = DatabaseTable();
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, dbName);
    var theDB = await openDatabase(
      dbPath,
      version: dbVersion,
      onOpen: (db) {},
      onCreate: onCreatetable,
      onUpgrade: onUpgrade,
    );
    return theDB;
  }

  onCreatetable(Database db, int version) async {
    await _databaseTable.createRashifalTable(db);
    await _databaseTable.createBlogTable(db);
    await _databaseTable.createCalendarTable(db);
    await _databaseTable.createAmessageTable(db);
    await _databaseTable.createEventsTable(db);
    await _databaseTable.createHolidaysTable(db);
    await _databaseTable.createExceptionsTable(db);
    await _databaseTable.createRemindersTable(db);
    await _databaseTable.createForexTable(db);
    await _databaseTable.createForexDetailTable(db);
    await _databaseTable.createPanchangaDbTable(db);
    await _databaseTable.createCacheDbTable(db);
    await _databaseTable.createDeletedEventTable(db);
    await _databaseTable.createDeletedReminderTable(db);

    //................... Times Of Nepal ...................//

    await _databaseTable.createFeedsTable(db);
    await _databaseTable.createRelatedFeedsTable(db);
    await _databaseTable.createSourcesTable(db);
    await _databaseTable.createCategoriesTable(db);
    await _databaseTable.createBookmarkTable(db);
  }

  Future<void> onUpgrade(Database db, int oldv, int newv) async {}

  String reverseString(String initial) {
    return initial.split('').reversed.join();
  }

  //..........................Rasifal..............................//

  insertOnRasifalTable(parameter) async {
    RasifalQuerys sql = RasifalQuerys();
    return await sql.insertDataOnRasifalTable(parameter);
  }

  updateRasifal() async {
    RasifalQuerys sql = RasifalQuerys();
    await sql.updateForTableRasifal();
  }

  getFromRasifal() async {
    RasifalQuerys sql = RasifalQuerys();
    return await sql.getFromRasifal();
  }

  deleteFromtableRasifal() async {
    RasifalQuerys sql = RasifalQuerys();
    return await sql.deleteFromTableRasifal();
  }

  //.................................Blog..................................................//

  insertOnBlogTable(parameter) async {
    BlogQuerys sql = BlogQuerys();
    await sql.insertDataOnBlogTable(parameter);
  }

  updateBlogTable() async {
    BlogQuerys sql = BlogQuerys();
    await sql.updateForTableBlog();
  }

  getFromBlogTable() async {
    BlogQuerys sql = BlogQuerys();
    return await sql.getFromBlog();
  }

  deleteFromTableBlog() async {
    BlogQuerys sql = BlogQuerys();
    return await sql.deleteFromTableBlog();
  }

  //...................................Message ......................................//
  insertOnMessageTable(parameter) async {
    MessageQuerys sql = MessageQuerys();
    await sql.insertDataOnMessageTable(parameter);
  }

  updateMessageTable() async {
    MessageQuerys sql = MessageQuerys();
    await sql.updateForTableMessage();
  }

  deleteFromTableMessage() async {
    MessageQuerys sql = MessageQuerys();
    await sql.deleteFromTableMessage();
  }

  getFromMessage() async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getFromMessage();
  }

  //............................Calendar.......................................//

  insertOnCalendarTable(parameter) async {
    CalendarQuerys sql = CalendarQuerys();
    await sql.insertDataOnCalendarTable(parameter);
  }

  updateCalendarTable() async {
    CalendarQuerys sql = CalendarQuerys();
    await sql.updateForTableCalendar();
  }

  deleteFromTableCalendar() async {
    CalendarQuerys sql = CalendarQuerys();
    await sql.deleteFromTableCalendar();
  }

  getFromCalendar() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getFromCalendar();
  }

  //................................Events..................................................//

  insertOnEventsTable(parameter) async {
    EventsQuerys sql = EventsQuerys();
    await sql.insertDataOnEventsTable(parameter);
  }

  updateEventsTable() async {
    EventsQuerys sql = EventsQuerys();
    await sql.updateForTableEvents();
  }

  deleteFromTableEvents() async {
    EventsQuerys sql = EventsQuerys();
    await sql.deleteFromTableEvents();
  }

  getFromEvents() async {
    EventsQuerys sql = EventsQuerys();
    return await sql.getFromEvents();
  }

  //.....................................Holidays,.....................................//

  insertOnHolidaysTable(parameter) async {
    HolidaysQuerys sql = HolidaysQuerys();
    await sql.insertDataOnHolidaysTable(parameter);
  }

  updateHolidaysTable() async {
    HolidaysQuerys sql = HolidaysQuerys();
    await sql.updateForTableHolidays();
  }

  deleteFromTableHolidays() async {
    HolidaysQuerys sql = HolidaysQuerys();
    await sql.deleteFromTableHolidays();
  }

  getFromHolidays() async {
    HolidaysQuerys sql = HolidaysQuerys();
    return await sql.getFromHolidays();
  }

  //............................................Exceptions..........................................//

  insertOnExceptionsTable(parameter) async {
    ExceptionsQuerys sql = ExceptionsQuerys();
    await sql.insertDataOnExceptionsTable(parameter);
  }

  updateExceptionsTable() async {
    ExceptionsQuerys sql = ExceptionsQuerys();
    await sql.updateForTableExceptions();
  }

  deleteFromTableExceptions() async {
    ExceptionsQuerys sql = ExceptionsQuerys();
    await sql.deleteFromTableExceptions();
  }

  getFromExceptions() async {
    ExceptionsQuerys sql = ExceptionsQuerys();
    return await sql.getFromExceptions();
  }

  //............................................Reminders..........................................//

  insertOnRemindersTable(parameter) async {
    RemindersQuerys sql = RemindersQuerys();
    await sql.insertDataOnRemindersTable(parameter);
  }

  updateRemindersTable() async {
    RemindersQuerys sql = RemindersQuerys();
    await sql.updateForTableReminders();
  }

  deleteFromTableReminders() async {
    RemindersQuerys sql = RemindersQuerys();
    await sql.deleteFromTableReminders();
  }

  getFromReminders() async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.getFromReminders();
  }

  //............................................Forex..........................................//

  insertOnForexTable(parameter) async {
    ForexQuerys sql = ForexQuerys();
    await sql.insertDataOnForexTable(parameter);
  }

  updateForexTable() async {
    ForexQuerys sql = ForexQuerys();
    await sql.updateForTableForex();
  }

  deleteFromTableForex() async {
    ForexQuerys sql = ForexQuerys();
    await sql.deleteFromTableForex();
  }

  getFromForex() async {
    ForexQuerys sql = ForexQuerys();
    return await sql.getFromForex();
  }

  //............................................ForexDetails..........................................//

  insertOnForexDetailsTable(parameter) async {
    ForexDetailsQuerys sql = ForexDetailsQuerys();
    await sql.insertDataOnForexDetailsTable(parameter);
  }

  updateForexDetailsTable() async {
    ForexDetailsQuerys sql = ForexDetailsQuerys();
    await sql.updateForTableForexDetails();
  }

  deleteFromTableForexDetails() async {
    ForexDetailsQuerys sql = ForexDetailsQuerys();
    await sql.deleteFromTableForexDetails();
  }

  getFromForexDetails() async {
    ForexDetailsQuerys sql = ForexDetailsQuerys();
    return await sql.getFromForexDetails();
  }

  //............................................PanchangaDb..........................................//

  insertOnPanchangaDbTable(parameter) async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    await sql.insertDataOnPanchangaDbTable(parameter);
  }

  updatePanchangaDbTable() async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    await sql.updateForTablePanchangaDb();
  }

  deleteFromTablePanchangaDb() async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    await sql.deleteFromTablePanchangaDb();
  }

  getFromPanchangaDb() async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    return await sql.getFromPanchangaDb();
  }

  //............................................CacheDb..........................................//

  insertOnCacheDbTable(parameter) async {
    CacheDbQuerys sql = CacheDbQuerys();
    await sql.insertDataOnCacheDbTable(parameter);
  }

  updateCacheDbTable() async {
    CacheDbQuerys sql = CacheDbQuerys();
    await sql.updateForTableCacheDb();
  }

  deleteFromTableCacheDb() async {
    CacheDbQuerys sql = CacheDbQuerys();
    await sql.deleteFromTableCacheDb();
  }

  getFromCacheDb() async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getFromCacheDb();
  }

  //............................................deletedevent...........................................//

  insertOnDeletedEventTable(parameter) async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    await sql.insertDataOnDeletedEventTable(parameter);
  }

  updateDeletedEventTable() async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    await sql.updateForTableDeletedEvent();
  }

  deleteFromTableDeletedEvent() async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    await sql.deleteFromTableDeletedEvent();
  }

  getFromDeletedEvent() async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    return await sql.getFromDeletedEvent();
  }

  //............................................deletedReminder...........................................//

  insertOnDeletedReminderTable(parameter) async {
    DeletedReminderQuerys sql = DeletedReminderQuerys();
    await sql.insertDataOnDeletedReminderTable(parameter);
  }

  updateDeletedReminderTable() async {
    DeletedReminderQuerys sql = DeletedReminderQuerys();
    await sql.updateForTableDeletedReminder();
  }

  deleteFromTableDeletedReminder() async {
    DeletedReminderQuerys sql = DeletedReminderQuerys();
    await sql.deleteFromTableDeletedReminder();
  }

  getFromDeletedReminder() async {
    DeletedReminderQuerys sql = DeletedReminderQuerys();
    return await sql.getFromDeletedReminder();
  }

  //............................................FeedsTable...........................................//

  insertOnFeedsTable(parameter) async {
    FeedsQuerys sql = FeedsQuerys();
    await sql.insertDataOnFeedsTable(parameter);
  }

  updateFeedsTable() async {
    FeedsQuerys sql = FeedsQuerys();
    await sql.updateForTableFeeds();
  }

  deleteFromTableFeeds() async {
    FeedsQuerys sql = FeedsQuerys();
    await sql.deleteFromTableFeeds();
  }

  getFromFeeds() async {
    FeedsQuerys sql = FeedsQuerys();
    return await sql.getFromFeeds();
  }

  //............................................RelatedFeedsTable...........................................//

  insertOnRelatedFeedsTable(parameter) async {
    RelatedFeedsQuerys sql = RelatedFeedsQuerys();
    await sql.insertDataOnRelatedFeedsTable(parameter);
  }

  updateRelatedFeedsTable() async {
    RelatedFeedsQuerys sql = RelatedFeedsQuerys();
    await sql.updateForTableRelatedFeeds();
  }

  deleteFromTableRelatedFeeds() async {
    RelatedFeedsQuerys sql = RelatedFeedsQuerys();
    await sql.deleteFromTableRelatedFeeds();
  }

  getFromRelatedFeeds() async {
    RelatedFeedsQuerys sql = RelatedFeedsQuerys();
    return await sql.getFromRelatedFeeds();
  }

  //............................................RelatedFeedsTable...........................................//

  insertOnSourcesTable(parameter) async {
    SourcesQuerys sql = SourcesQuerys();
    await sql.insertDataOnSourcesTable(parameter);
  }

  updateSourcesTable() async {
    SourcesQuerys sql = SourcesQuerys();
    await sql.updateForTableSources();
  }

  deleteFromTableSources() async {
    SourcesQuerys sql = SourcesQuerys();
    await sql.deleteFromTableSources();
  }

  getFromSources() async {
    SourcesQuerys sql = SourcesQuerys();
    return await sql.getFromSources();
  }

  //............................................Categories Table...........................................//

  insertOnCategoriesTable(parameter) async {
    CategoriesQuerys sql = CategoriesQuerys();
    await sql.insertDataOnCategoriesTable(parameter);
  }

  updateCategoriesTable() async {
    CategoriesQuerys sql = CategoriesQuerys();
    await sql.updateForTableCategories();
  }

  deleteFromTableCategories() async {
    CategoriesQuerys sql = CategoriesQuerys();
    await sql.deleteFromTableCategories();
  }

  getFromCategories() async {
    CategoriesQuerys sql = CategoriesQuerys();
    return await sql.getFromCategories();
  }
//............................................BookMark Table...........................................//

  insertOnBookMarkTable(parameter) async {
    BookMarkQuerys sql = BookMarkQuerys();
    await sql.insertDataOnBookMarkTable(parameter);
  }

  updateBookMarkTable() async {
    BookMarkQuerys sql = BookMarkQuerys();
    await sql.updateForTableBookMark();
  }

  deleteFromTableBookMark() async {
    BookMarkQuerys sql = BookMarkQuerys();
    await sql.deleteFromTableBookMark();
  }

  getFromBookMark() async {
    BookMarkQuerys sql = BookMarkQuerys();
    return await sql.getFromBookMark();
  }
}
