// ignore_for_file: prefer_const_declarations

library nepali_patro_sql_package;

import 'dart:io';
import 'package:nepali_patro_sql_package/database/database_tables.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/models/blog_model.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/models/deleteReminderModel.dart';
import 'package:nepali_patro_sql_package/models/forexmodel.dart';
import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/models/remindersmodel.dart';
import 'package:nepali_patro_sql_package/querys/blog_querys.dart';
import 'package:nepali_patro_sql_package/querys/cachedb_querys.dart';
import 'package:nepali_patro_sql_package/querys/calendar_querys.dart';
import 'package:nepali_patro_sql_package/querys/events/deleted_event.dart';
import 'package:nepali_patro_sql_package/querys/events/event_exception_query.dart';
import 'package:nepali_patro_sql_package/querys/events/events_querys.dart';
import 'package:nepali_patro_sql_package/querys/forex/forex_querys.dart';
import 'package:nepali_patro_sql_package/querys/holidays_querys.dart';
import 'package:nepali_patro_sql_package/querys/amessage_querys.dart';
import 'package:nepali_patro_sql_package/querys/panchangadb_querys.dart';
import 'package:nepali_patro_sql_package/querys/rashifal_querys.dart';
import 'package:nepali_patro_sql_package/querys/reminders/reminders_querys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;

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
    var theDB = await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        onOpen: (db) {},
        onCreate: onCreatetable,
        onUpgrade: onUpgrade,
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
  }

  Future<void> onUpgrade(Database db, int oldv, int newv) async {}
  initializeTimeZone() async {
    tz.initializeTimeZones();
  }
//.........................Rasifal..............................//

  insertRasifal(List<Np> model) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.insertRashifal(model);
  }

  Future<Np?> getRashifalByTag(String tag) async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.getRashifalByTag(tag);
  }

  clearRashifal() async {
    RashifalQuerys sql = RashifalQuerys();
    return await sql.clearRashifal();
  }

  //.................................Blog..................................................//

  insertBlog(BlogModel model) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.insertBlog(model);
  }

  updateBlog(BlogModel blogs, int id) async {
    BlogQuerys sql = BlogQuerys();
    await sql.updateBlog(blogs, id);
  }

  Future<List<dynamic>?> getBlogById(id) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.getBlogById(id);
  }

  deleteAllBlog() async {
    BlogQuerys sql = BlogQuerys();
    return await sql.deleteAllBlog();
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

  loadBlogsByDate(String date) async {
    BlogQuerys sql = BlogQuerys();
    return await sql.loadBlogsByDate(date);
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
  insertAmessages(List<Content> content) async {
    MessageQuerys sql = MessageQuerys();
    await sql.insertAmessages(content);
  }

  updateAmessage(Content updatedmessage) async {
    MessageQuerys sql = MessageQuerys();
    await sql.updateAmessage(updatedmessage);
  }

  deleteFromTableMessage() async {
    MessageQuerys sql = MessageQuerys();
    await sql.deleteFromTableMessage();
  }

  Future<List<Content?>> getAmessages() async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getAmessages();
  }

  Future<Content> getAmessageById(id) async {
    MessageQuerys sql = MessageQuerys();
    return await sql.getAmessageById(id);
  }

  parseAmessage(List<Map<dynamic, dynamic>> args) async {
    MessageQuerys sql = MessageQuerys();
    return await sql.parseAmessage(args);
  }

  cancelAmessage(Content amessage) async {
    MessageQuerys sql = MessageQuerys();
    return await sql.cancelAmessage(amessage);
  }

  //............................Calendar.......................................//

  deleteFromTableCalendar() async {
    CalendarQuerys sql = CalendarQuerys();
    await sql.deleteFromTableCalendar();
  }

  getAllSortedCalendars() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getAllSortedCalendars();
  }

  getCalendarById(id) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getCalendarById(id);
  }

  updateCalendar(Calendar calendar) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.updateCalendar(calendar);
  }

  insertCalendars(List<Calendar> calendars) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.insertCalendars(calendars);
  }

  deleteCalendars(Calendar calendarItem) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.deleteCalendars(calendarItem);
  }

  getsortedCalendar() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getsortedCalendar();
  }

  getSyncPendingCalendars({dynamic loadAll}) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getSyncPendingCalendars(loadAll: loadAll);
  }

  getEnabledDefaultCalendars({defautlCalendar = false}) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getEnabledDefaultCalendars(
        defautlCalendar: defautlCalendar);
  }

  getEnabledCalendars() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getEnabledCalendars();
  }

  getDisabledCalendars() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getDisabledCalendars();
  }

  updateCalendarPriority(List<Calendar> calendars) async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.updateCalendarPriority(calendars);
  }

  getCalendarUser() async {
    CalendarQuerys sql = CalendarQuerys();
    return await sql.getCalendarUser();
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

  disableUserEvent(prefix0.Event event) async {
    EventsQuerys sql = EventsQuerys();
    return sql.disableUserEvent(event);
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

  getEventsbetweenDates(startDate, endDate, {isBackground = true}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getEventsbetweenDates(
      startDate,
      endDate,
      isBackground: isBackground,
    );
  }

  getRepetitionEventsforMonth(startDate, endDate,
      {preCalendarId = "", isBackground = true}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getRepetitionEventsforMonth(startDate, endDate,
        isBackground: isBackground, preCalendarId: preCalendarId);
  }

  getRepeatedEvents(DateTime startDate, DateTime endDate,
      {impOnly = false, forceDefCal = false, isBackground = true}) async {
    EventsQuerys sql = EventsQuerys();
    return sql.getRepeatedEvents(startDate, endDate,
        forceDefCal: forceDefCal, impOnly: impOnly, isBackground: isBackground);
  }
  //.....................................Holidays,.....................................//

  insertHolidays(model) async {
    HolidaysQuerys sql = HolidaysQuerys();
    await sql.insertHolidays(model);
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

  deleteHolidays() async {
    HolidaysQuerys sql = HolidaysQuerys();
    return await sql.deleteHolidays();
  }

  getAllHolidays(DateTime startDate, DateTime endDate) async {
    HolidaysQuerys sql = HolidaysQuerys();
    return await sql.getAllHolidays(startDate, endDate);
  }

  getGovernmentHolidaysFromWeb(DateTime from, DateTime to) async {
    HolidaysQuerys sql = HolidaysQuerys();
    return await sql.getGovernmentHolidaysFromWeb(from, to);
  }

  getGovernmentHolidays(DateTime from, DateTime to) async {
    HolidaysQuerys sql = HolidaysQuerys();
    return await sql.getGovernmentHolidays(from, to);
  }
  //............................................Exceptions..........................................//

  insertEventException(List<dynamic> exceptionLists) async {
    EventExceptionQuery sql = EventExceptionQuery();
    await sql.insertEventException(exceptionLists);
  }

  getEventExceptionById(id) async {
    EventExceptionQuery sql = EventExceptionQuery();
    return await sql.getEventExceptionById(id);
  }

  deleteUserEvent(prefix0.Event event) async {
    EventExceptionQuery sql = EventExceptionQuery();
    return await sql.deleteUserEvent(event);
  }

  deleteuserEventById(id) async {
    EventExceptionQuery sql = EventExceptionQuery();
    return await sql.deleteuserEventById(id);
  }

  deleteFromTableExceptions() async {
    EventExceptionQuery sql = EventExceptionQuery();
    await sql.deleteFromTableExceptions();
  }
  //............................................Reminders..........................................//

  Future<bool> deleteRemindersWithEventid(id) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.deleteRemindersWithEventid(id);
  }

  insertReminders(remender) async {
    RemindersQuerys sql = RemindersQuerys();
    await sql.insertReminders(remender);
  }

  Future<RemindersModel?> getReminderById(reminderId) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.getReminderById(reminderId);
  }

  deleteUserReminders(RemindersModel remindersModel) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.deleteUserReminders(remindersModel);
  }

  insertRemindersList(List<RemindersModel> reminderslists) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.insertRemindersList(reminderslists);
  }

  Future<List<Map<dynamic, dynamic>>?> getRemindersByEventId(eventId) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.getRemindersByEventId(eventId);
  }

  updateReminderWithMap(parameter) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.updateReminderWithMap(parameter);
  }

  udpateReminder(RemindersModel reminderItem) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.updateReminder(reminderItem);
  }

  Future<List<DeleteReminderModel>> getSyncDeletedReminders(
      {loadAll, String? time}) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.getSyncDeletedReminders(loadAll: loadAll, time: time);
  }

  getSyncPendingReminders({loadAll, syncTime}) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.getSyncPendingReminders(
        loadAll: loadAll, syncTime: syncTime);
  }

  deleteUserRemindersFromReminderId(String deleteReminderModel) async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.deleteUserRemindersFromReminderId(deleteReminderModel);
  }

  deleteDeletedReminders() async {
    RemindersQuerys sql = RemindersQuerys();
    return await sql.deleteDeletedReminders();
  }
  //............................................Forex..........................................//

  insertToForexDetail(int id, ForexModel model) async {
    ForexQuerys sql = ForexQuerys();
    return await sql.insertToForexDetail(id, model);
  }

  insertForex(ForexModel model) async {
    ForexQuerys sql = ForexQuerys();
    return await sql.insertForex(model);
  }

  insertToForex(String formatedDate, ForexModel model) async {
    ForexQuerys sql = ForexQuerys();
    return await sql.insertToForex(formatedDate, model);
  }

  deleteForex(String date) async {
    ForexQuerys sql = ForexQuerys();
    return await sql.deleteForex(date);
  }

  deleteForexDetails() async {
    ForexQuerys sql = ForexQuerys();
    return await sql.deleteForexDetails();
  }

  forexCount() async {
    ForexQuerys sql = ForexQuerys();
    return await sql.forexCount();
  }

  getForex() async {
    ForexQuerys sql = ForexQuerys();
    return await sql.forexCount();
  }

  latestForex() async {
    ForexQuerys sql = ForexQuerys();
    return await sql.latestForex();
  }

  getForexDetail(int forexId) async {
    ForexQuerys sql = ForexQuerys();
    return await sql.getForexDetail(forexId);
  }

  //............................................PanchangaDb..........................................//

  insertPanchangaData(
      String np, String en, String ddNp, String ddEn, String date,
      {id}) async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    return await sql.insertPanchangaData(np, en, ddNp, ddEn, date);
  }

  deleteFromTablePanchangaDb() async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    return await sql.deleteFromTablePanchangaDb();
  }

  getPanchangaByDate(String date) async {
    PanchangaDbQuerys sql = PanchangaDbQuerys();
    return await sql.getPanchangaByDate('date');
  }

  //............................................CacheDb..........................................//

  insertCache(parameter) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.insertCache(parameter);
  }

  insertCacheById(dynamic nsDataResult, {int? addKey}) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.insertCacheById(nsDataResult, addKey: addKey);
  }

  deleteFromTableCacheDb() async {
    CacheDbQuerys sql = CacheDbQuerys();
    await sql.deleteFromTableCacheDb();
  }

  Future<List<Map<String, Object?>>> getCacheByEventId(id, date) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getCacheByEventId(id, date);
  }

  getCachebetweenDates(DateTime from, DateTime to,
      {calendarIds = "", impOnly = false, isBackground = true}) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getCachebetweenDates(from, to,
        calendarIds: calendarIds, impOnly: impOnly, isBackground: isBackground);
  }

  getCacheCount() async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getCacheCount();
  }

  getCachedYear(String from, String to) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getCachedYear(from, to);
  }

  getInvalidCache(DateTime from, DateTime to, {DateTime? startAdDate}) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getInvalidCache(from, to, startAdDate: startAdDate);
  }

  deleteSingleDateFromCache(String eventId, DateTime fromDate) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.deleteSingleDateFromCache(eventId, fromDate);
  }

  deleteAllDefaultCalCache() async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.deleteAllDefaultCalCache();
  }

  deleteFutureDateFromCache(String eventId, DateTime fromDate) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.deleteFutureDateFromCache(eventId, fromDate);
  }

  deleteCache(String eventId) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.deleteCache(eventId);
  }

  deleteNepaliCalendarCache() async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.deleteNepaliCalendarCache();
  }

  getRepetitionEventsCache(List<prefix0.Event> events, startDate, endDate,
      {forceGenerate = false}) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getRepetitionEventsCache(events, startDate, endDate,
        forceGenerate: forceGenerate);
  }

  getNonCacheEventOfYear(DateTime startDate, DateTime endDate,
      {isBackground = true}) async {
    CacheDbQuerys sql = CacheDbQuerys();
    return await sql.getNonCacheEventOfYear(startDate, endDate);
  }

  //............................................deletedevent...........................................//

  insertDeleteEvents(events) async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    return await sql.insertDeleteEvents(events);
  }

  deleteFromTableDeletedEvent() async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    await sql.deleteFromTableDeletedEvent();
  }

  getFromDeletedEvent() async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    return await sql.getFromDeletedEvent();
  }

  Future getSyncDeletedEvents({dynamic loadAll, String? synctimestamps}) async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    return await sql.getSyncDeletedEvents(
        loadAll: loadAll, synctimestamps: synctimestamps);
  }

  getSyncPendingDeletedEvents({loadAll, String? synctimestamps}) async {
    DeletedEventQuerys sql = DeletedEventQuerys();
    return await sql.getSyncPendingDeletedEvents(
        loadAll: loadAll, synctimestamps: synctimestamps);
  }
}
