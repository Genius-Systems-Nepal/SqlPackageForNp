// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/utils/string_manager.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTable {
  Future createRashifalTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_RASHIFAL (
      ${Rashifaldb.type} TEXT PRIMARY KEY,
      ${Rashifaldb.title} TEXT,
      ${Rashifaldb.author} TEXT,
      ${Rashifaldb.lang} TEXT,
      ${Rashifaldb.aries} TEXT,
      ${Rashifaldb.taurus} TEXT,
      ${Rashifaldb.gemini} TEXT,
      ${Rashifaldb.cancer} TEXT,
      ${Rashifaldb.leo} TEXT,
      ${Rashifaldb.virgo} TEXT,
      ${Rashifaldb.libra} TEXT,
      ${Rashifaldb.scorpio} TEXT,
      ${Rashifaldb.sagittarius} TEXT,
      ${Rashifaldb.capricorn} TEXT,
      ${Rashifaldb.aquarius} TEXT,
      ${Rashifaldb.pisces} TEXT,
      ${Rashifaldb.todate} TEXT)''');
    } catch (e) {
      return e;
    }
  }

  Future createBlogTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_BLOG(
         ${Blogs.id} INTEGER PRIMARY KEY,
         ${Blogs.date} TEXT,
         ${Blogs.modified} TEXT,
         ${Blogs.url} TEXT,
         ${Blogs.title} TEXT,
         ${Blogs.content} TEXT,
         ${Blogs.excerpt} TEXT,
         ${Blogs.thumbnail} TEXT,
         ${Blogs.categories} TEXT,
         ${Blogs.tags} TEXT,
         ${Blogs.author} TEXT,
         ${Blogs.comments} TEXT,
         ${Blogs.comment_count} INTEGER,
         ${Blogs.thumbnail_images} TEXT,
         ${Blogs.readdate} TEXT,
         ${Blogs.isread} INTEGER,
         ${Blogs.ignore} INTEGER,
         ${Blogs.event} INTEGER )''');
    } catch (e) {
      return e;
    }
  }

  Future createCalendarTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_CALENDAR(
         ${CalendarDb.id} INTEGER PRIMARY KEY,
         ${CalendarDb.name} TEXT,
         ${CalendarDb.status} INTEGER,
         ${CalendarDb.calendar_id} TEXT,
         ${CalendarDb.is_modifiable} INTEGER,
         ${CalendarDb.created_by} TEXT,
         ${CalendarDb.is_default} INTEGER,
         ${CalendarDb.created_at} TEXT,
         ${CalendarDb.updated_at} TEXT,
         ${CalendarDb.color} TEXT DEFAULT ('#E15A00'),
         ${CalendarDb.priority} INTEGER,
         ${CalendarDb.display} INTEGER)''');
    } catch (e) {
      return e;
    }
  }

  Future createAmessageTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_AMESSAGE (
        ${AMessageDb.id} TEXT PRIMARY KEY,
        ${AMessageDb.message_np} TEXT,
        ${AMessageDb.message_en} TEXT,
        ${AMessageDb.linktype} TEXT,
        ${AMessageDb.link} TEXT,
        ${AMessageDb.stdate} TEXT,
        ${AMessageDb.expiry} TEXT,
        ${AMessageDb.aflag} TEXT,
        ${AMessageDb.pin} TEXT,
        ${AMessageDb.createdAt} TEXT,
        ${AMessageDb.enable} TEXT,
        ${AMessageDb.options} TEXT,
        ${AMessageDb.dorder} TEXT,
        ${AMessageDb.cancelled} BOOLEAN
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createEventsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_EVENTS (
        ${EventsDb.id} TEXT PRIMARY KEY,
        ${EventsDb.parent_event_id} INTEGER,
        ${EventsDb.title} TEXT,
        ${EventsDb.description} TEXT,
        ${EventsDb.start_date} TEXT,
        ${EventsDb.end_date} TEXT,
        ${EventsDb.is_full_day_event} INTEGER,
        ${EventsDb.recurring_end_date} TEXT,
        ${EventsDb.is_recurring} INTEGER,
        ${EventsDb.created_by} TEXT,
        ${EventsDb.has_reminder} INTEGER,
        ${EventsDb.location} TEXT,
        ${EventsDb.guests} TEXT,
        ${EventsDb.rsvp} TEXT,
        ${EventsDb.note} TEXT,
        ${EventsDb.event_permission} TEXT,
        ${EventsDb.visibility} TEXT,
        ${EventsDb.privacy} TEXT,
        ${EventsDb.status} INTEGER,
        ${EventsDb.duration} INTEGER,
        ${EventsDb.gh} INTEGER,
        ${EventsDb.important_event} INTEGER,
        ${EventsDb.rrule} TEXT,
        ${EventsDb.deleted_at} TEXT,
        ${EventsDb.created_at} TEXT,
        ${EventsDb.updated_at} TEXT,
        ${EventsDb.calendar_id} INTEGER,
        ${EventsDb.based_on} TEXT,
        ${EventsDb.rsvp_stats} TEXT,
        ${EventsDb.formatted_rrule} TEXT,
        ${EventsDb.rsstart} TEXT,
        ${EventsDb.origid} INTEGER
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createHolidaysTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_HOLIDAYS (
        ${HolidaysDb.id} INTEGER PRIMARY KEY,
        ${HolidaysDb.eventId} TEXT,
        ${HolidaysDb.eventDate} TEXT,
        ${HolidaysDb.holidayType} TEXT,
        ${HolidaysDb.status} INTEGER,
        ${HolidaysDb.createdAt} TEXT,
        ${HolidaysDb.updatedAt} TEXT,
        ${HolidaysDb.deletedAt} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createExceptionsTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_EVENTS_EXCEPTION (
        ${EventsExcDb.id} TEXT PRIMARY KEY NOT NULL,
        ${EventsExcDb.exception_date} TEXT NOT NULL,
        ${EventsExcDb.new_date} TEXT,
        ${EventsExcDb.event_id} TEXT,
        ${EventsExcDb.created_at} TEXT,
        ${EventsExcDb.updated_at} TEXT,
        ${EventsExcDb.calendar_id} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createRemindersTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_REMINDERS (
        ${RemindersDb.id} TEXT PRIMARY KEY,
        ${RemindersDb.event_id} TEXT,
        ${RemindersDb.days} INTEGER,
        ${RemindersDb.time} TEXT,
        ${RemindersDb.note} TEXT,
        ${RemindersDb.notification_type} TEXT,
        ${RemindersDb.updated_at} TEXT,
        ${RemindersDb.created_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createForexTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_FOREX (
        ${Forex.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${Forex.fordate} TEXT,
        ${Forex.source} INTEGER,
        ${Forex.source_url} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createForexDetailTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_FOREX_DETAIL (
        ${ForexDetail.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${ForexDetail.pid} INTEGER,
        ${ForexDetail.type} TEXT,
        ${ForexDetail.code} TEXT,
        ${ForexDetail.currency} TEXT,
        ${ForexDetail.unit} TEXT,
        ${ForexDetail.buying} TEXT,
        ${ForexDetail.selling} TEXT
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
        ${Cache.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${Cache.date} TEXT NOT NULL,
        ${Cache.event_id} TEXT,
        ${Cache.created_at} TEXT,
        ${Cache.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createDeletedEventTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_DELETE_EVENTS (
        ${DeleteEventsDB.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DeleteEventsDB.event_id} TEXT,
        ${DeleteEventsDB.calendar_id} TEXT,
        ${DeleteEventsDB.created_at} TEXT,
        ${DeleteEventsDB.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }

  Future createDeletedReminderTable(Database db) async {
    try {
      db.execute('''CREATE TABLE $DB_TABLE_DELETE_REMINDERS (
        ${DeleteRemindersDB.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DeleteRemindersDB.reminder_id} TEXT,
        ${DeleteRemindersDB.event_id} TEXT,
        ${DeleteRemindersDB.created_at} TEXT,
        ${DeleteRemindersDB.updated_at} TEXT
          )''');
    } catch (e) {
      return e;
    }
  }
}
