// ignore_for_file: prefer_const_declarations

library nepali_patro_sql_package;

import 'dart:io';
import 'package:nepali_patro_sql_package/database/database_tables.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/models/blog_model.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/querys/blog_querys.dart';
import 'package:nepali_patro_sql_package/querys/cachedb_querys.dart';
import 'package:nepali_patro_sql_package/querys/calendar_querys.dart';
import 'package:nepali_patro_sql_package/querys/events/deleted_event.dart';
import 'package:nepali_patro_sql_package/querys/events/events_querys.dart';
import 'package:nepali_patro_sql_package/querys/exceptions_querys.dart';
import 'package:nepali_patro_sql_package/querys/forex/forex_details_querys.dart';
import 'package:nepali_patro_sql_package/querys/forex/forex_querys.dart';
import 'package:nepali_patro_sql_package/querys/holidays_querys.dart';
import 'package:nepali_patro_sql_package/querys/message_querys.dart';
import 'package:nepali_patro_sql_package/querys/panchangadb_querys.dart';
import 'package:nepali_patro_sql_package/querys/rasifal_querys.dart';
import 'package:nepali_patro_sql_package/querys/reminders/deleted_reminder_querys.dart';
import 'package:nepali_patro_sql_package/querys/reminders/reminders_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/bookmark_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/categories_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/feeds_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/related_feeds_querys.dart';
import 'package:nepali_patro_sql_package/querys/timesofnepal/sources_querys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    String dbPath = join(Platform.script.toFilePath(), dbName);
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String dbPath = join(documentsDirectory.path, dbName);
    var theDB = await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        onOpen: (db) {},
        onCreate: onCreatetable,
        // onUpgrade: onUpgrade,
        version: dbVersion,
      ),
    );
    return theDB;
  }

  close() async {
    await _database?.close();
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

//  .........................simple Test example ...............
  String reverseString(String initial) {
    return initial.split('').reversed.join();
  }
  //..........................Rasifal..............................//

  insertRasifal(List<Np> model) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.insertRashifal(model);
  }

  insertOnRasifalTable(parameter) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.insertDataOnRasifalTable(parameter);
  }

  Future<Np?> getFromRasifal(String tag) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.getRashifalByTag(tag);
  }

  deleteFromtableRasifal(String tag) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.deleteFromTableRashifal(tag);
  }

  //.................................Blog..................................................//

  insertOnBlogTable(model) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.insertBlog(model);
  }

  updateBlogTable(BlogModel blogs, int id) async {
    BlogQuerys sql = BlogQuerys();
    await sql.updateBlog(blogs, id);
  }

  getFromBlogTable(id) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.getBlogById(id);
  }

  deleteFromTableBlog() async {
    BlogQuerys sql = BlogQuerys();
    return await sql.deleteFromTableBlog();
  }

  getBlogDateTime(bool latest) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.getBlogDateTime(latest);
  }

  loadBlogs(id) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.loadBlogs(id);
  }

  loadDailyBlog(id) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.loadDailyBlog(id);
  }

  loadAllBlogs() async {
    BlogQuerys sql = BlogQuerys();
    return await sql.loadAllBlogs();
  }

  setBlogAsRead(blogItem) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.setBlogAsRead(blogItem);
  }

  getSearchBlog(String text) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.getSearchBlog(text);
  }

  //...................................Message ......................................//
  insertOrUpdateAMessages(List<Content> content) async {
    MessageQuerys sql = MessageQuerys();
    await sql.insertAmessages(content);
  }

  updateMessageTable(Content updatedmessage) async {
    MessageQuerys sql = MessageQuerys();
    await sql.updateAmessage(updatedmessage);
  }

  deleteFromTableMessage() async {
    MessageQuerys sql = MessageQuerys();
    await sql.deleteFromTableMessage();
  }

  Future<Content?> getFromMessage(String id) async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getAmessageById(id);
  }

  Future<List<Content?>> getAmessages() async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getAmessages();
  }

  getAmessageById(id) async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getAmessageById(id);
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

  insertEvents(List<dynamic> events, forceUpdate, needEncryption) async {
    EventsQuerys sql = EventsQuerys();
    await sql.insertEvents(events, forceUpdate, needEncryption: needEncryption);
  }

  getCalendarEventbyId(String id) async {
    EventsQuerys sql = EventsQuerys();
    return await sql.getCalendarEventbyId(id);
  }

  deleteFromTableEvents() async {
    EventsQuerys sql = EventsQuerys();
    await sql.deleteFromTableEvents();
  }

  getEvents() async {
    EventsQuerys sql = EventsQuerys();
    return await sql.getEvents();
  }

  getEventByIdWithDate(id, date) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getEventByIdWithDate(id, date);
  }

  getEventToday(DateTime time) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getEventToday(time);
  }

  disableUserEvent(Event event) async {
    EventsQuerys sql = EventsQuerys();
    return sql.disableUserEvent(event);
  }

  deleteuserEventById(id) async {
    EventsQuerys sql = EventsQuerys();
    return sql.deleteuserEventById(id);
  }

  updateUserEventsAuthority(prevId, newId) async {
    EventsQuerys sql = EventsQuerys();
    return sql.updateUserEventsAuthority(prevId, newId);
  }

  getUserevents(userId, {status, calendarId}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getUserevents(userId, status: status, calendarId: calendarId);
  }

  getCalendarEventsByIds(String ids) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getCalendarEventsByIds(ids);
  }

  getExpiredNonRepeatingEvents({calendarId, status}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getExpiredNonRepeatingEvents(
        calendarId: calendarId, status: status);
  }

  getActiveNonRepeatingEvents({calendarId, status}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getActiveNonRepeatingEvents(
        calendarId: calendarId, status: status);
  }

  getExpiredEvents({calendarId, status}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getExpiredEvents(calendarId: calendarId, status: status);
  }

  getActiveEvents({calendarId, status}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getActiveEvents(calendarId: calendarId, status: status);
  }

  getSearchEvents(keyword) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getSearchEvents(keyword);
  }

  getAllUserEvents() async {
    EventsQuerys sql = EventsQuerys();
    return sql.getAllUserEvents();
  }

  getSyncPendingEvents() async {
    EventsQuerys sql = EventsQuerys();
    return sql.getSyncPendingEvents();
  }

  getEventsbetweenDates(startDate, endDate) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getEventsbetweenDates(startDate, endDate);
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

  insertPanchangaData(
      String np, String en, String ddNp, String ddEn, String date,
      {id}) async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    await sql.insertPanchangaData(np, en, ddNp, ddEn, date);
  }

  deleteFromTablePanchangaDb() async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    await sql.deleteFromTablePanchangaDb();
  }

  getPanchangaByDate(String date) async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    return await sql.getPanchangaByDate('date');
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
