// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTable {
  Future createRashifalTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_RASHIFAL (
      ${RasifalTable.type} TEXT PRIMARY KEY,
      ${RasifalTable.title} TEXT,
      ${RasifalTable.author} TEXT,
      ${RasifalTable.lang} TEXT,
      ${RasifalTable.aries} TEXT,
      ${RasifalTable.taurus} TEXT,
      ${RasifalTable.gemini} TEXT,
      ${RasifalTable.cancer} TEXT,
      ${RasifalTable.leo} TEXT,
      ${RasifalTable.virgo} TEXT,
      ${RasifalTable.libra} TEXT,
      ${RasifalTable.scorpio} TEXT,
      ${RasifalTable.sagittarius} TEXT,
      ${RasifalTable.capricorn} TEXT,
      ${RasifalTable.aquarius} TEXT,
      ${RasifalTable.pisces} TEXT,
      ${RasifalTable.todate} TEXT)''');
    } catch (e) {
      return e;
    }
  }

  Future createBlogTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_BLOG(
         ${BlogTable.id} INTEGER PRIMARY KEY,
         ${BlogTable.date} TEXT,
         ${BlogTable.modified} TEXT,
         ${BlogTable.url} TEXT,
         ${BlogTable.title} TEXT,
         ${BlogTable.content} TEXT,
         ${BlogTable.excerpt} TEXT,
         ${BlogTable.thumbnail} TEXT,
         ${BlogTable.categories} TEXT,
         ${BlogTable.tags} TEXT,
         ${BlogTable.author} TEXT,
         ${BlogTable.comments} TEXT,
         ${BlogTable.comment_count} INTEGER,
         ${BlogTable.thumbnail_images} TEXT,
         ${BlogTable.readdate} TEXT,
         ${BlogTable.isread} INTEGER,
         ${BlogTable.ignore} INTEGER,
         ${BlogTable.event} INTEGER )''');
    } catch (e) {
      return e;
    }
  }

  Future createCalendarTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_CALENDAR(
         ${CalendarTable.id} INTEGER PRIMARY KEY,
         ${CalendarTable.name} TEXT,
         ${CalendarTable.status} INTEGER,
         ${CalendarTable.calendar_id} TEXT,
         ${CalendarTable.is_modifiable} INTEGER,
         ${CalendarTable.created_by} TEXT,
         ${CalendarTable.is_default} INTEGER,
         ${CalendarTable.created_at} TEXT,
         ${CalendarTable.updated_at} TEXT,
         ${CalendarTable.color} TEXT DEFAULT ('#E15A00'),
         ${CalendarTable.priority} INTEGER,
         ${CalendarTable.display} INTEGER)''');
    } catch (e) {
      return e;
    }
  }

  Future createAmessageTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_AMESSAGE (
        ${AMessageTable.id} TEXT PRIMARY KEY,
        ${AMessageTable.message_np} TEXT,
        ${AMessageTable.message_en} TEXT,
        ${AMessageTable.linktype} TEXT,
        ${AMessageTable.link} TEXT,
        ${AMessageTable.stdate} TEXT,
        ${AMessageTable.expiry} TEXT,
        ${AMessageTable.aflag} TEXT,
        ${AMessageTable.pin} TEXT,
        ${AMessageTable.createdAt} TEXT,
        ${AMessageTable.enable} TEXT,
        ${AMessageTable.options} TEXT,
        ${AMessageTable.dorder} TEXT,
        ${AMessageTable.cancelled} BOOLEAN
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createEventsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_EVENTS (
        ${EventsTable.id} TEXT PRIMARY KEY,
        ${EventsTable.parent_event_id} INTEGER,
        ${EventsTable.title} TEXT,
        ${EventsTable.description} TEXT,
        ${EventsTable.start_date} TEXT,
        ${EventsTable.end_date} TEXT,
        ${EventsTable.is_full_day_event} TEXT,
        ${EventsTable.recurring_end_date} TEXT,
        ${EventsTable.is_recurring} INTEGER,
        ${EventsTable.created_by} TEXT,
        ${EventsTable.has_reminder} INTEGER,
        ${EventsTable.location} TEXT,
        ${EventsTable.guests} TEXT,
        ${EventsTable.rsvp} TEXT,
        ${EventsTable.note} TEXT,
        ${EventsTable.event_permission} TEXT,
        ${EventsTable.visibility} TEXT,
        ${EventsTable.privacy} TEXT,
        ${EventsTable.status} INTEGER,
        ${EventsTable.duration} INTEGER,
        ${EventsTable.gh} INTEGER,
        ${EventsTable.important_event} INTEGER,
        ${EventsTable.rrule} TEXT,
        ${EventsTable.deleted_at} TEXT,
        ${EventsTable.created_at} TEXT,
        ${EventsTable.updated_at} TEXT,
        ${EventsTable.calendar_id} INTEGER,
        ${EventsTable.based_on} TEXT,
        ${EventsTable.rsvp_stats} TEXT,
        ${EventsTable.formatted_rrule} TEXT,
        ${EventsTable.rsstart} TEXT,
        ${EventsTable.origid} INTEGER
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createHolidaysTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_HOLIDAYS (
        ${HolidaysTable.id} INTEGER PRIMARY KEY,
        ${HolidaysTable.eventId} TEXT,
        ${HolidaysTable.eventDate} TEXT,
        ${HolidaysTable.holidayType} TEXT,
        ${HolidaysTable.status} INTEGER,
        ${HolidaysTable.createdAt} TEXT,
        ${HolidaysTable.updatedAt} TEXT,
        ${HolidaysTable.deletedAt} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createExceptionsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_EVENTS_EXCEPTION (
        ${ExceptionsTable.id} TEXT PRIMARY KEY NOT NULL,
        ${ExceptionsTable.exception_date} TEXT NOT NULL,
        ${ExceptionsTable.new_date} TEXT,
        ${ExceptionsTable.event_id} TEXT,
        ${ExceptionsTable.created_at} TEXT,
        ${ExceptionsTable.updated_at} TEXT,
        ${ExceptionsTable.calendar_id} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createRemindersTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_REMINDERS (
        ${RemindersTable.id} TEXT PRIMARY KEY,
        ${RemindersTable.event_id} TEXT,
        ${RemindersTable.days} INTEGER,
        ${RemindersTable.time} TEXT,
        ${RemindersTable.note} TEXT,
        ${RemindersTable.notification_type} TEXT,
        ${RemindersTable.updated_at} TEXT,
        ${RemindersTable.created_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createForexTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_FOREX (
        ${ForexTable.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${ForexTable.fordate} TEXT,
        ${ForexTable.source} INTEGER,
        ${ForexTable.source_url} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createForexDetailTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_FOREX_DETAIL (
        ${ForexDetailTable.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${ForexDetailTable.pid} INTEGER,
        ${ForexDetailTable.type} TEXT,
        ${ForexDetailTable.code} TEXT,
        ${ForexDetailTable.currency} TEXT,
        ${ForexDetailTable.unit} TEXT,
        ${ForexDetailTable.buying} TEXT,
        ${ForexDetailTable.selling} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createPanchangaDbTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_PANCHANGA (
        ${PanchangaDb.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${PanchangaDb.date} TEXT NOT NULL,
        ${PanchangaDb.text_np} TEXT NOT NULL,
        ${PanchangaDb.text_en} TEXT NOT NULL,
        ${PanchangaDb.text_ddnp} TEXT,
        ${PanchangaDb.text_dden} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createCacheDbTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_CACHE (
        ${CacheDb.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${CacheDb.date} TEXT NOT NULL,
        ${CacheDb.event_id} TEXT,
        ${CacheDb.created_at} TEXT,
        ${CacheDb.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createDeletedEventTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_DELETE_EVENTS (
        ${DeletedEvent.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DeletedEvent.event_id} TEXT,
        ${DeletedEvent.calendar_id} TEXT,
        ${DeletedEvent.created_at} TEXT,
        ${DeletedEvent.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createDeletedReminderTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_DELETE_REMINDERS (
        ${DeletedReminder.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DeletedReminder.reminder_id} TEXT,
        ${DeletedReminder.event_id} TEXT,
        ${DeletedReminder.created_at} TEXT,
        ${DeletedReminder.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

//##...................................Table Of times of Nepal........................##//

  Future createFeedsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_FEEDS (
        ${FeedsTable.id} INTEGER PRIMARY KEY,
        ${FeedsTable.newsId} TEXT,
        ${FeedsTable.title} TEXT,
        ${FeedsTable.description} TEXT,
        ${FeedsTable.content} TEXT,
        ${FeedsTable.link} TEXT,
        ${FeedsTable.enclosure_url} TEXT,
        ${FeedsTable.enclosure_type} TEXT,
        ${FeedsTable.source} TEXT,
        ${FeedsTable.category} TEXT,
        ${FeedsTable.author} TEXT,
        ${FeedsTable.image} TEXT,
        ${FeedsTable.uuid} TEXT,
        ${FeedsTable.fetchDate} TEXT,
        ${FeedsTable.pub_date} TEXT,
        ${FeedsTable.update_date} TEXT,
        ${FeedsTable.read} INTEGER,
        ${FeedsTable.bookmarked} INTEGER
     
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createRelatedFeedsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_RELATED_FEEDS (
        ${RelatedFeedsTable.id} INTEGER PRIMARY KEY,
        ${RelatedFeedsTable.pId} INTEGER,
        ${RelatedFeedsTable.title} TEXT,
        ${RelatedFeedsTable.description} TEXT,
        ${RelatedFeedsTable.content} TEXT,
        ${RelatedFeedsTable.link} TEXT,
        ${RelatedFeedsTable.enclosure_url} TEXT,
        ${RelatedFeedsTable.enclosure_type} TEXT,
        ${RelatedFeedsTable.source} TEXT,
        ${RelatedFeedsTable.category} TEXT,
        ${RelatedFeedsTable.author} TEXT,
        ${RelatedFeedsTable.image} TEXT,
        ${RelatedFeedsTable.uuid} TEXT,
        ${RelatedFeedsTable.fetchDate} TEXT,
        ${RelatedFeedsTable.pub_date} TEXT,
        ${RelatedFeedsTable.update_date} TEXT,
        ${RelatedFeedsTable.read} INTEGER,
        ${RelatedFeedsTable.bookmarked} INTEGER
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createSourcesTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_SOURCES (
        ${SourcesTable.id} INTEGER PRIMARY KEY,
        ${SourcesTable.name} TEXT,
        ${SourcesTable.name_np} TEXT,
        ${SourcesTable.code} TEXT,
        ${SourcesTable.icon} TEXT,
        ${SourcesTable.lang} TEXT,
        ${SourcesTable.priority} INTEGER,
        ${SourcesTable.favicon} TEXT,
        ${SourcesTable.ga} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createCategoriesTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_CATEGORIES (
        ${CategoriesTable.id} INTEGER PRIMARY KEY,
        ${CategoriesTable.name} TEXT,
        ${CategoriesTable.name_np} TEXT,
        ${CategoriesTable.code} TEXT,
        ${CategoriesTable.icon} TEXT,
        ${CategoriesTable.enable} TEXT,
        ${CategoriesTable.priority} INTEGER
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createBookmarkTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_BOOKMARKS (
        ${RelatedFeedsTable.id} INTEGER PRIMARY KEY,
        ${RelatedFeedsTable.pId} INTEGER,
        ${RelatedFeedsTable.title} TEXT,
        ${RelatedFeedsTable.description} TEXT,
        ${RelatedFeedsTable.content} TEXT,
        ${RelatedFeedsTable.link} TEXT,
        ${RelatedFeedsTable.enclosure_url} TEXT,
        ${RelatedFeedsTable.enclosure_type} TEXT,
        ${RelatedFeedsTable.source} TEXT,
        ${RelatedFeedsTable.category} TEXT,
        ${RelatedFeedsTable.author} TEXT,
        ${RelatedFeedsTable.image} TEXT,
        ${RelatedFeedsTable.uuid} TEXT,
        ${RelatedFeedsTable.fetchDate} TEXT,
        ${RelatedFeedsTable.pub_date} TEXT,
        ${RelatedFeedsTable.update_date} TEXT,
        ${RelatedFeedsTable.read} INTEGER,
        ${RelatedFeedsTable.bookmarked} INTEGER    
          )''');
    } catch (e) {
      return e;
    }
  }
}
