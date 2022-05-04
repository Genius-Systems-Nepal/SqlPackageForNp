// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_null_comparison, curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls, prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nepali_patro_sql_package/custom/npcachemanager.dart';
import 'package:nepali_patro_sql_package/localization/localehelper.dart';
import 'package:nepali_patro_sql_package/models/NsData.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/models/deleteEventModel.dart';
import 'package:nepali_patro_sql_package/models/deleteReminderModel.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/models/eventsyncmodel.dart';
import 'package:nepali_patro_sql_package/models/homeeventscopedmodel.dart';
import 'package:nepali_patro_sql_package/models/localcalendarmodel.dart';
import 'package:nepali_patro_sql_package/models/npscopemodel.dart';
import 'package:nepali_patro_sql_package/models/remindersmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/apiconstants.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/channelpluginhelper.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:scoped_model/scoped_model.dart';

Dio? _dio;
DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

/*This class contains all the required methods service calls required for calendars such as calendar create,edit,delete,sync calendar/events etc*/
class CalendarLoader {
  NpScopedModel? _scopedModel;
  BuildContext _context;
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

//  var directory;
//  File calendarFile;
  String CALENDAR_FILE = "calDb.txt";

//  String resourcePath = "resources/assets/caldb.txt";
  String resourcePath = "resources/assets/caldb.bin";
  var authToken = "";
  HomeEventsScopedModel? homeEventsScopedModel;
  var stringFileData = "";

  CalendarLoader(this._context) {
    if (_context != null) {
      _scopedModel = ScopedModel.of<NpScopedModel>(_context);
      homeEventsScopedModel = ScopedModel.of<HomeEventsScopedModel>(_context);
    }
    // _dbHelper = DbHelper();
    initData();
//    _dio = Dio();
//    _dio.options = BaseOptions(
//        connectTimeout: DEF_TIMEOUT, receiveTimeout: DEF_RECEIVETIMEOUT);
//    _dio.options = BaseOptions(
//        receiveTimeout: DEF_RECEIVETIMEOUT, connectTimeout: DEF_TIMEOUT);
  }

  /*Returns list of all the local calendars lists that are available to the users for search and
  * subscribe to them.*/
  Future<List<LocalCalendarModel>?> getLocalCalendars(context) async {
    try {
      var response = await _dio!.get(LOCAL_CALENDARS_LISTS_API);
      if (response.statusCode == 200) {
        var data = response.data;
        var localCalModel = List<LocalCalendarModel>.from(
            data.map((x) => LocalCalendarModel.fromJson(x)));
        return localCalModel;
      } else {
        return null;
      }
    } on DioError {
      return throw ErrorDescription(
          LocaleHelper.getlocaleString("networkproblem_message", context));
    } catch (e) {
      return throw Exception(
          LocaleHelper.getlocaleString("somethingwentwrong", context));
    }
  }

  Future<dynamic> extractfile({isBackground = true}) async {
    try {
      var directory = resourcePath;
      ByteData audioByteData =
          await DefaultAssetBundle.of(_context).load(directory);
      if (isBackground) {
        return await compute(decode, audioByteData);
      } else {
        return zipFile(audioByteData);
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  zipFile(ByteData audioByteData) {
    try {
      final bytes = audioByteData.buffer.asUint8List(
          audioByteData.offsetInBytes, audioByteData.lengthInBytes);
      bytes[0] = 0x1f;
      bytes[1] = 0x8b;
      bytes[2] = 0x08;
      bytes[3] = 0x00;
      bytes[4] = 0x00;
      bytes[5] = 0x00;
      bytes[6] = 0x00;
      bytes[7] = 0x00;
      final archive = GZipDecoder().decodeBytes(bytes);
      stringFileData = utf8.decode(archive, allowMalformed: true);
      return stringFileData;
    } on IOException catch (e) {
      Utils.debugLog(e);
    } on ArchiveException catch (e) {
      Utils.debugLog(e);
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  Future<bool?> loadCalendarFromFile(
      {isUser = true, isBackground = true, refreshHome = false}) async {
    try {
      // print("load from file");
      if (stringFileData.isEmpty) {
        stringFileData = await extractfile(isBackground: isBackground);
      }
      var result = jsonDecode(stringFileData);
//      var result = Utils.decrypt(stringFileData);
//      var result = Utils.decodeDataWithoutIV(
//          "9E4mk3Woz7tN8Ic9LRZYG5ipy7971B62egK199a0d+c=", data);
      _scopedModel?.setCalendarData(jsonEncode(result), true);
      await parseData(result, isUser: isUser, refreshHome: refreshHome);
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  /*Calls api service to create user calendar.User need to be logged in order for sync.*/
  Future<bool?> createCalendar(calendarName, color, calendarId,
      {id = ""}) async {
    if (calendarName.toString().isEmpty) {
      return false;
    }
    Map map = {};
    if (id.toString().isNotEmpty) map.putIfAbsent("id", () => id);
    map.putIfAbsent("name", () => calendarName);
    map.putIfAbsent("color", () => color);
    map.putIfAbsent("calendar_id", () => calendarId);
    map.putIfAbsent("is_default", () => 0);

    try {
      await _dio?.post(CALENDAR_URI,
          options: Options(headers: {"Authorization": "Bearer $authToken"}),
          data: jsonEncode(map));
      await Utils.userCrudSyncToWeb();
    } on DioError catch (de) {
      Utils.debugLog(de);
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  /*Api service to delete calendar.*/
  deleteCalendar(Calendar c) async {
    authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, defToken);
    var url = "$CALENDAR_URI/${c.id}";
    try {
      await _dio?.delete(
        url,
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );
      await Utils.userCrudSyncToWeb();
      return true;
    } on DioError catch (de) {
      Utils.debugLog(de);
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  subscribetoCalendar(Map<String, dynamic> calendarMaps) async {
    try {
      List<String> calendarLists = calendarMaps["calendar_ids"];
      calendarLists.forEach((String calendarItem) async {
        Calendar calendarDb =
            await databaseHelper.getCalendarById(calendarItem);
        if (calendarDb != null) {
          calendarDb.status = 1;
        }
        await databaseHelper.updateCalendar(calendarDb);
      });
      authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, defToken);
      var response = await _dio?.post(SUBSCRIBE_TO_CALENDARS,
          options: Options(headers: {"Authorization": "Bearer $authToken"}),
          data: jsonEncode(calendarMaps));
      if (response?.statusCode == 200) {
        await syncCalendars(true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  editCalendar(Calendar c) async {
    if (c == null) {
      return false;
    }
    Map map = {};
    // if (c.id.toString().isNotEmpty) map.putIfAbsent("id", () => c.id);
    map.putIfAbsent("name", () => c.name);
    map.putIfAbsent("color", () => c.color);
    map.putIfAbsent("status", () => c.status);
    var url = "$CALENDAR_URI/${c.id}";
    try {
      await _dio?.put(url,
          options: Options(headers: {"Authorization": "Bearer $authToken"}),
          data: jsonEncode(map));
      await Utils.userCrudSyncToWeb();
      return true;
    } on DioError catch (de) {
      Utils.debugLog(de);
    } catch (e) {
      Utils.debugLog(e);
    }
    return false;
  }

  /*This method syncs any changes in calendar lists when user changes the priority list in the calendar.
  * */
  syncPriority(List<Calendar> priortizedCalendars) async {
    List<Map> calendars = [];
    // ignore: prefer_conditional_assignment
    if (priortizedCalendars == null) {
      priortizedCalendars = await databaseHelper.getAllSortedCalendars();
    }
    for (int j = 1; j <= priortizedCalendars.length; j++) {
      Calendar c = priortizedCalendars[j - 1];
      Map map = {};
      map.putIfAbsent("calendar_id", () => c.id);
      map.putIfAbsent("calendar_name", () => c.name);
      map.putIfAbsent("color", () => c.color);
      map.putIfAbsent("priority", () => j);
      calendars.add(map);
    }
    Map rootMap = {};
    rootMap.putIfAbsent("calendars", () => calendars);
    await _dio?.put(SYNC_CALENDAR_PRIORITY_API,
        data: jsonEncode(rootMap),
        options: Options(headers: {"Authorization": "Bearer $authToken"}));
    await Utils.userCrudSyncToWeb();
  }

  /*This method is used for syncing calendar and its events to server.
  * Parameters:
  *   force-> This parameter force reloads ignoring time to sync constraint.
  *   syncAll-> This parameter will sync all the events ignoring the last sync timestamp.
  *
  * This method will pass a Map which contains arraylist of Events,ExceptionEvents,Calendars and Exception calendars.To get the
       arraylist getEventSyncMap() method is called.
  *
  * */
  Future<bool?> syncCalendars(force,
      {syncAll = false,
      showMessage = false,
      forceCache = false,
      syncToWeb = false,
      isUser = true,
      refreshHome = true}) async {
    try {
      authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, defToken);
      var previousFetchedTimeStamp;
      if (isUser)
        previousFetchedTimeStamp =
            await PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
      else
        previousFetchedTimeStamp =
            await PrefsUtils.getString(PREF_NEP_CALENDAR_SYNC_TIMESTAMP, "");

      if (!force) {
        var ttf = await timeToSync(previousFetchedTimeStamp);
        if (!ttf) {
          return false;
        }
      }
      var map = await getEventSyncMap(previousFetchedTimeStamp,
          syncAll: syncAll, isUser: isUser);
      var response = await _dio?.post(
          authToken.isNotEmpty && isUser
              ? USER_SYNC_CALENDAR_API
              : SYNC_CALENDAR_API,
          data:
              map /*,
          options: authToken.isEmpty
              ? Options()
              : Options(headers: {"Authorization": "Bearer $authToken"}*/
          );

      if (response?.statusCode == 200) {
        try {
          if (syncToWeb) {
            Utils.userCrudSyncToWeb();
          }
          var decryptedResult;
          if (isUser) {
            decryptedResult = response?.data;
          } else {
            decryptedResult = Utils.decrypt(response?.data);
          }
          var result = await parseData(decryptedResult,
              forceCache: forceCache, isUser: isUser, refreshHome: refreshHome);
          if (result) {
            if (isUser)
              await PrefsUtils.putString(PREF_CALENDAR_SYNC_TIMESTAMP,
                  Timezone().curDateTimeByZone("NPT").toIso8601String());
            /* else
              await PrefsUtils.putString(PREF_NEP_CALENDAR_SYNC_TIMESTAMP,
                  Timezone().curDateTimeByZone("NPT").toIso8601String());*/
          }
          if (showMessage) {
            showToast("Successfully Sync",
                duration: const Duration(seconds: 2),
                position: ToastPosition.bottom,
                backgroundColor: Colors.green);
          }
          return result;
        } catch (e) {
          if (showMessage) {
            showToast("Sync Failed. Something Went Wrong Please Try Again",
                duration: const Duration(seconds: 2),
                position: ToastPosition.bottom,
                backgroundColor: Colors.red);
          }
          Utils.debugLog(e);
//          return await loadCalendarFromFile();
        }
      }
    } on DioError catch (de) {
      if (showMessage) {
        showToast("Sync Failed. Something Went Wrong Please Try Again",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.red);
      }
      Utils.debugLog(de);
    } catch (e) {
      if (showMessage) {
        showToast("Sync Failed. Something Went Wrong Please Try Again",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.red);
      }
      Utils.debugLog(e);
    }
    if (!isUser) {
      var lastSync =
          await PrefsUtils.getString(PREF_NEP_CALENDAR_SYNC_TIMESTAMP, "");
      if (lastSync.isEmpty) {
        return await loadCalendarFromFile(
            isUser: isUser, refreshHome: refreshHome);
      }
    }
    return false;
  }

  Future<bool> syncNepaliCalendars(force,
      {syncAll = false,
      showMessage = false,
      forceCache = false,
      syncToWeb = false,
      isUser = true,
      refreshHome = true}) async {
    try {
      var previousFetchedTimeStamp;
      if (isUser)
        previousFetchedTimeStamp =
            await PrefsUtils.getString(PREF_CALENDAR_SYNC_TIMESTAMP, "");
      else
        previousFetchedTimeStamp =
            await PrefsUtils.getString(PREF_NEP_CALENDAR_SYNC_TIMESTAMP, "");

      if (!force) {
        var ttf = await timeToSync(previousFetchedTimeStamp);
        if (!ttf) {
          return false;
        }
      }
      var map = await getEventSyncMap(previousFetchedTimeStamp,
          syncAll: syncAll, isUser: isUser);
      var tempDirectory = await getTemporaryDirectory();
      File tempFile = File(tempDirectory.path + "/caldb.bin");
      if (!await tempFile.exists()) tempFile.create();
      Options options = Options(method: "POST");
      var result = await _dio?.download(
          SYNC_CALENDAR_API, tempDirectory.path + "/caldb.bin",
          data: map, options: options);
      if (result?.statusCode == 200) {
        try {
          stringFileData = await compute(zipDecode, tempFile);
          var result = jsonDecode(stringFileData);
          await parseData(result);
        } catch (e) {
          Utils.debugLog(e);
        }
      }
    } on DioError catch (de) {
      if (showMessage) {
        showToast("Sync Failed. Something Went Wrong Please Try Again",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.red);
      }
      Utils.debugLog(de);
    } catch (e) {
      if (showMessage) {
        showToast("Sync Failed. Something Went Wrong Please Try Again",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.red);
      }
      Utils.debugLog(e);
    }
    if (homeEventsScopedModel != null && refreshHome)
      homeEventsScopedModel?.run(force: true);
    return false;
  }

  Future<bool> timeToSync(previousFetchedTimeStamp) async {
    var now = Timezone().curDateTimeByZone("NPT").millisecondsSinceEpoch;

    int defaultSyncInterval =
        await PrefsUtils.getInt(PREF_EVENT_SYNC_INTERVAL, 3600);
    if (defaultSyncInterval == 0) {
      // if (!kReleaseMode) {
      //   defaultSyncInterval = 600;
      // }
    }
    var lastFetchedTimestamp =
        CalendarUtils.getCalendarFromString(previousFetchedTimeStamp);
    var elapsedTime = lastFetchedTimestamp.millisecondsSinceEpoch +
        (defaultSyncInterval * 1000);
    if (now > elapsedTime)
      return true;
    else
      return false;
  }

  void initData() async {
    authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, defToken);
    /*  var refreshToken =
        await PrefsUtils.getString(PREF_REFRESH_AUTH_TOKEN, "") ?? "";*/
//    print("refresh_token ${refreshToken}");
//    var firstOpen = await PrefsUtils.getBoolean(PREFS_FIRST_INSTALL, true);
    _dio = await Utils.getApiClient(_context, token: authToken);

    /*if first open, the app will create a default calendar inorder to create events for the user.*/
    /*if (firstOpen) {
      await PrefsUtils?.putBoolean(PREFS_FIRST_INSTALL, false);
      var uuid = Uuid();
      var id = (uuid as Uuid).v1();error
      var calendarId = (uuid as Uuid).v1();
      var now = Timezone().curDateTimeByZone("NPT");
      Calendar calendar = Calendar(
          id: id,
          isModifiable: 1,
          calendar_id: calendarId,
          priority: 10000,
          updated_at: now,
          created_at: now,
          name: "Default Calendar",
          status: 1,
          display: 1,
          color: HexColor.colorToHex(Colors.greenAccent));
      List<Calendar> calendarslist = List();
      calendarslist.add(calendar);

      PrefsUtils.putString(PREF_USER_ID, uuid.v1());
      await _dbHelper.insertCalendars(calendarslist);
    }*/
    /*This will list out all the available calendars in the list and put it in scopedmodel.*/
    var calendarsdb = await databaseHelper.getAllSortedCalendars();
    _scopedModel?.setCalendars(calendarsdb, false);
  }

  parseData(Map calendarData,
      {forceCache = false, isUser = true, refreshHome = false}) async {
    try {
      List<Calendar> mCalendarLists = [];
      List<Calendar> deletedCalendarsLists = [];
      List<prefix0.Event> eventsLists = [];
      List<EventExceptionModel> eventExceptionsLists = [];
      var reminderLists = <RemindersModel>[];
      List<DeletedEvents> deletedEvents = [];
      List<DeleteReminderModel> deletedReminder = [];
      NsData? nsData;
//      List<Map<String, dynamic>> nsDataCache = List();

//      if (!isUser) {
//        await _dbHelper.deleteAllDefaultCalCache();
//      }

      SyncModel model = SyncModel.fromJson(calendarData.cast());
      if (model.version != null)
        await PrefsUtils.putInt(PREF_CALDB_VERSION, model.version!);
      mCalendarLists = model.calendars == null ? [] : model.calendars!;
      deletedCalendarsLists =
          model.deletedCalendar == null ? [] : model.deletedCalendar!;
      eventsLists = model.events == null ? [] : model.events!;
      eventExceptionsLists = model.exceptions == null ? [] : model.exceptions!;
      reminderLists = model.reminders == null ? [] : model.reminders!;
      deletedEvents = model.deletedEvents == null ? [] : model.deletedEvents!;
      deletedReminder =
          model.deletedReminder == null ? [] : model.deletedReminder!;
      nsData = model.nsData;
      await databaseHelper.insertCalendars(mCalendarLists);
      /* for (var calendarItem in deletedCalendarsLists) {
        calendarItem.status = 2;
      }
      await _dbHelper?.insertCalendars(deletedCalendarsLists);*/
      for (var calendarItem in deletedCalendarsLists) {
        await databaseHelper.deleteCalendars(calendarItem);
      }
      var calendarsFromDb = await databaseHelper.getsortedCalendar();
      _scopedModel?.setCalendars(calendarsFromDb, true);
      await databaseHelper.insertEvents(eventsLists, false, false);
      await databaseHelper.insertEventException(eventExceptionsLists);
      await databaseHelper.insertRemindersList(reminderLists);
      for (var deleteEvent in deletedEvents) {
        await databaseHelper.deleteuserEventById(deleteEvent.eventId);
      }
      for (var deletedReminderModel in deletedReminder) {
        await databaseHelper.deleteUserRemindersFromReminderId(
            deletedReminderModel.reminderId.toString());
      }
      if (isUser) {
        ChannelPluginHelper.invalidateUserEventsAlarm();
      }
      if (nsData != null) {
        try {
          int key = int.parse(nsData.b.toString());
          var fromDate = DateTime.parse(
              (key + int.parse(nsData.fdt.toString().substring(0, 2)))
                      .toString() +
                  nsData.fdt.toString().substring(2, nsData.fdt!.length));
          var toDate = DateTime.parse(
              (key + int.parse(nsData.tdt.toString().substring(0, 2)))
                      .toString() +
                  nsData.tdt.toString().substring(2, nsData.tdt!.length));
          await PrefsUtils.putString(
              PREFS_FROM_DATE, fromDate.toIso8601String());
          await PrefsUtils.putString(PREFS_TO_DATE, toDate.toIso8601String());
          var nsDataResult = nsData.data;
          await databaseHelper.insertCacheById(nsDataResult, addKey: key);
        } catch (e) {
          Utils.debugLog(e);
        }
      }

      if (!isUser && model.fromDate != null) {
        await PrefsUtils.putString(PREF_NEP_CALENDAR_SYNC_TIMESTAMP,
            model.fromDate!.toIso8601String());
      }

      if (authToken.isNotEmpty) {
        try {
          DateTime dateTime = DateTime.now();
          initData();
          var resultEvents = List<prefix0.Event>.from(calendarData["events"]
              .map((x) => prefix0.Event.fromJsonEncryptedRuleOnly(x)));
          List<prefix0.Event> events =
              await databaseHelper.getRepetitionEventsCache(
                  resultEvents,
                  dateTime.add(const Duration(days: -465)),
                  dateTime.add(const Duration(days: 465)));
          forceCache
              ? await NpCacheManager().generateCache(events, dateTime)
              : NpCacheManager().generateCache(events, dateTime);
        } catch (e) {
          Utils.debugLog(e);
        }
      }
      if (homeEventsScopedModel != null && refreshHome) {
        homeEventsScopedModel?.run(force: true);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /*
  * Return arraylist of events,exception events,calendars lists,exception calendar lists,reminder lists and last sync timestamp.
  *   This last sync timestamp will determines the from where the server should make changes and return data according to date_modified.

  *Parameters:
  *   previousFetchedTimeStamp : The timestamp of last sync.
  *   syncAll: Flag that determines to ignore previous sync timestamp and include all the user reminders,events,calendars.
  *
  * When the app is opened for the very first time or the user is not logged in, this method will return empty arrays for every values.
  * The last sync time ('from_date') might be null and this determines that the user has not logged in and server will return only the
  * default calendars and its events.
  * */
  getEventSyncMap(previousFetchedTimeStamp,
      {syncAll = false, isUser = false}) async {
    List<Map> reminderLists = [];
    List<Map> calendars = [];
    List<Map> eventsMap = [];
    List<Calendar> calendarLists = [];
    List<prefix0.Event> syncPendingEvents = [];
    List<Map> pendingDeletedEvents = [];
    List<DeletedEvents> deletedEvents = [];
    List<DeleteReminderModel> deletedReminder = [];
    Map rootMap = {};
    rootMap.putIfAbsent("syncAll", () => syncAll);
    if (previousFetchedTimeStamp == "") {
      rootMap.putIfAbsent("from_date", () => null);
    } else {
      DateTime time = DateTime.parse(previousFetchedTimeStamp);
//      DateTime time = DateTime.parse(previousFetchedTimeStamp).toUtc();
      rootMap.putIfAbsent("from_date",
          () => CalendarUtils.formatCalendar(time, "yyyy-MM-dd HH:mm:ss"));
    }
    if (!isUser) {
      rootMap.putIfAbsent("calendars", () => []);
      rootMap.putIfAbsent("events", () => []);
      rootMap.putIfAbsent("exceptions", () => []);
      rootMap.putIfAbsent("reminders", () => []);
      rootMap.putIfAbsent("deleted_events", () => []);
      rootMap.putIfAbsent("deleted_reminders", () => []);
      var jsonMap = jsonEncode(rootMap);
      return jsonMap;
    }

    if (authToken.isNotEmpty) {
      if (syncAll) {
        syncPendingEvents = await databaseHelper.getAllUserEvents();
        pendingDeletedEvents =
            await databaseHelper.getSyncPendingDeletedEvents(loadAll: true);
        reminderLists =
            await databaseHelper.getSyncPendingReminders(loadAll: true);
        calendarLists =
            await databaseHelper.getSyncPendingCalendars(loadAll: true);
        deletedEvents =
            await databaseHelper.getSyncDeletedEvents(loadAll: true);
        deletedReminder =
            await databaseHelper.getSyncDeletedReminders(loadAll: true);
      } else {
        syncPendingEvents = await databaseHelper.getSyncPendingEvents();
        pendingDeletedEvents =
            await databaseHelper.getSyncPendingDeletedEvents();
        reminderLists = await databaseHelper.getSyncPendingReminders();
        calendarLists = await databaseHelper.getSyncPendingCalendars();
        deletedEvents = await databaseHelper.getSyncDeletedEvents();
        deletedReminder = await databaseHelper.getSyncDeletedReminders();
      }
      for (int j = 1; j <= calendarLists.length; j++) {
        Calendar c = calendarLists[j - 1];
        calendars.add(c.toNormalDateJson());
      }
      for (prefix0.Event eventItem in syncPendingEvents) {
        eventsMap.add(eventItem.toJsonDecrypt(formatDate: true));
      }
      rootMap.putIfAbsent("calendars", () => calendars);
      rootMap.putIfAbsent("events", () => eventsMap);
      rootMap.putIfAbsent("exceptions", () => pendingDeletedEvents);
      rootMap.putIfAbsent("reminders", () => reminderLists);
      rootMap.putIfAbsent("deleted_events", () => deletedEvents);
      rootMap.putIfAbsent("deleted_reminders", () => deletedReminder);
    } else {
      rootMap.putIfAbsent("calendars", () => []);
      rootMap.putIfAbsent("events", () => []);
      rootMap.putIfAbsent("exceptions", () => []);
      rootMap.putIfAbsent("reminders", () => []);
      rootMap.putIfAbsent("deleted_events", () => deletedEvents);
      rootMap.putIfAbsent("deleted_reminders", () => deletedReminder);
    }
    var jsonMap = jsonEncode(rootMap);
    return jsonMap;
  }
}

String zipDecode(File tempFile) {
  try {
    Uint8List uint8list = tempFile.readAsBytesSync();
    ByteData audioByteData = ByteData.view(uint8list.buffer);
    return decode(audioByteData);
  } catch (e) {
    Utils.debugLog(e);
  }
  return zipDecode(tempFile);
}

String decode(ByteData audioByteData) {
  try {
    final bytes = audioByteData.buffer
        .asUint8List(audioByteData.offsetInBytes, audioByteData.lengthInBytes);
    bytes[0] = 0x1f;
    bytes[1] = 0x8b;
    bytes[2] = 0x08;
    bytes[3] = 0x00;
    bytes[4] = 0x00;
    bytes[5] = 0x00;
    bytes[6] = 0x00;
    bytes[7] = 0x00;
    final archive = GZipDecoder().decodeBytes(bytes);
    var stringFileData = utf8.decode(archive, allowMalformed: true);
    return stringFileData;
  } catch (e) {
    Utils.debugLog(e);
    return "";
  }
}
