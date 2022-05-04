// ignore_for_file: unnecessary_null_comparison, unused_local_variable, non_constant_identifier_names, avoid_types_as_parameter_names, constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/bsdate.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';

import 'package:path_provider/path_provider.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/datemapping.dart';

const DIRECTORY_CACHE = "temp_cache";

/*This cache manager caches default calendar events that are generated whenever a cache does not exist in cache db.
* The first time cache is generated when the app is opened for the very first time in splashpresenter.
* The cache manager is simply a database where all the generated default events from recurrence rule helper are inserted into db.
* These reoccured events are then queried according to the requirements in each page.
*   For example :
*   The home page request cached data from today to end of Bs year .i.e Chaitra 30.
*   The Calendar page request cached data for a single Bs month only which is currently being showed.. i.e Baisakh 1- Baisakh 30
*   Day detail page request cached data for a single day only.
*
*   Note:The cached data are stored with its event date in english date only therefore while querying the cache table, we need to
*   give date ranges in AD date only.
* */
class NpCacheManager {
//  NsMapping? _nsMapping;
  Directory? _directory;
  DateTime? startTime, endTime;
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();

  NpCacheManager._privateConstructor();

  static final NpCacheManager _instance = NpCacheManager._privateConstructor();

  factory NpCacheManager() {
    return _instance;
  }

  initData() {
    databaseHelper;
  }

  generateCache(List<Event> eventsLists, DateTime lastDate) async {
    try {
      // startTime = Timezone().curDateTimeByZone("NPT");
      await databaseHelper.insertCache(eventsLists);
      // endTime = Timezone().curDateTimeByZone("NPT");
      // var diff = endTime.difference(startTime);
      // Utils.debugLog("CACHEINSERT->>${diff.inMilliseconds}");
      return true;
    } catch (e) {
      // Print(e);
    }
    return false;
  }

  getEventForDate(DateTime time) async {
    List<Event> eventLists = [];
    try {
      _directory = await getApplicationDocumentsDirectory();
      var year = time.year;
      var month = time.month;

      var day = Utils.pad(time.day);
      var rootDirectoryPath =
          "${_directory?.path}/$DIRECTORY_CACHE/${year.toString()}/${Utils.pad(month)}";
      var file = File(rootDirectoryPath);
      var fileExists = await file.exists();
      if (fileExists) {
        var data = await file.readAsString();
        Map jsonData = jsonDecode(data);
        if (jsonData.containsKey(day)) {
          List<String> dayData = jsonData[day].toString().split("~");
          var query = StringBuffer();
          for (int i = 0; i < dayData.length; i++) {
            var dayItem = dayData[i];
            if (i == dayData.length - 1) {
              query.write("'$dayItem'");
            } else {
              var tempdata = query.toString();
              query.write("'$dayItem',");
            }
          }
          eventLists =
              await databaseHelper.getCalendarEventsByIds(query.toString());
          return eventLists;
        } else {
          return eventLists;
        }
      } else {
        var lastDate = DateTime(time.year, time.month + 1, 0);
        eventLists = await databaseHelper.getRepetitionEventsforMonth(
            DateTime(time.year, time.month, 01), lastDate);
        generateCache(eventLists, lastDate);
      }
      return eventLists;
    } catch (e) {
      return eventLists;
    }
  }

  // only nepali patro event
  /*Used for getting default events that are cached in the DB.
  * First invalidates cache so that no missing events cases might occur.
  * Then after, it queries the DB for the cache within the given time frame.
  * */
  Future<List<Event>?> getCachedEventsBetweenDates(DateTime from, DateTime to,
      {calendarId = "", impOnly = false, isBackground = true}) async {
    try {
      await invalidateCache(from, to, isBackground: isBackground);
      var cachedEvents = await databaseHelper.getCachebetweenDates(from, to,
          calendarIds: calendarId,
          impOnly: impOnly,
          isBackground: isBackground);
      return cachedEvents;
    } catch (e) {
      return null;
    }
  }

  /*used for fetching government holiday that are cached.*/
  getCachedGovernmentHolidays(DateTime from, DateTime to) async {
    try {
      await invalidateCache(from, to);
      var cachedEvents = await databaseHelper.getGovernmentHolidays(from, to);
      return cachedEvents;
    } catch (e) {
      return null;
    }
  }

  /*This method verifies the integrity of the cache in the cache DB.
  *if the cache between the dates provided is not verified then it automatically generates the required
  * cache for the dates then it will start inserting into the cache.
  * */
  invalidateCache(from, to,
      {isBackground = true, DateTime? startAdDate}) async {
    List<DateTime> invalidCacheData = await databaseHelper
        .getInvalidCache(from, to, startAdDate: startAdDate);
    // Print("INVALIDCACHE DATA-->$invalidCacheData");
    if (invalidCacheData == null) {
      var events = await databaseHelper.getRepetitionEventsforMonth(from, to,
          isBackground: isBackground);
      await generateCache(events, to);
    } else if (invalidCacheData.isNotEmpty) {
      if (invalidCacheData.length == 1) {
        var startDate = invalidCacheData[0];
        var tempStartDate = DateTime(startDate.year, startDate.month, 01);
        var tempEndDate = DateTime(startDate.year, startDate.month + 1, 0);
        var events = await databaseHelper.getRepetitionEventsforMonth(
            tempStartDate, tempEndDate,
            isBackground: isBackground);
        await generateCache(events, tempEndDate);
      } else {
        var startDate = invalidCacheData[0];
        var endDate = invalidCacheData[invalidCacheData.length - 1];
        var tempStartDate = DateTime(startDate.year, startDate.month, 01);
        var tempEndDate = DateTime(endDate.year, endDate.month + 1, 0);
        var events = await databaseHelper.getRepetitionEventsforMonth(
            tempStartDate, tempEndDate,
            isBackground: isBackground);
        await generateCache(events, tempEndDate);
      }
    } else {
      BsDate today, toDate;
      DateTime startDate, endDate;
      DateMapping datemap = DateMapping();
      if (isBackground) {
        var bsDates = await datemap.getBsDatesByCompute([from, to]);
        today = bsDates[0];
        toDate = bsDates[1];

        var adDates = await datemap.getAdDatesByCompute([
          BsDate(today.year!, 01, 01),
          BsDate(toDate.year!, 12,
              DateMapping().numberOfDaysInBsMonth(toDate.year!, 12))
        ]);
        startDate = adDates[0];
        endDate = adDates[1];
      } else {
        today = DateMapping().getBs(from);
        toDate = DateMapping().getBs(to);
        startDate = BsDate(today.year!, 01, 01).getAd();
        endDate = BsDate(toDate.year!, 12,
                DateMapping().numberOfDaysInBsMonth(toDate.year!, 12))
            .getAd();
      }

      List<Event> events = await databaseHelper.getNonCacheEventOfYear(
          startDate, endDate,
          isBackground: isBackground);
      if (events.isNotEmpty) {
        var cacheEvents = await databaseHelper.getRepetitionEventsCache(
            events, startDate, endDate,
            forceGenerate: true);
        await generateCache(cacheEvents, endDate);
      }
    }
  }

  addtoMap(Map dataMap, String eventDate, String eventDetail) {
    if (dataMap.containsKey(eventDate)) {
      var result = dataMap[eventDate];
      if (result.toString().contains("~")) {
        List<String> splitString = result.toString().split("~");
        bool shouldAddEvent = true;
        for (String eventItem in splitString) {
          if (eventItem == eventDetail) {
            shouldAddEvent = false;
          }
        }
        if (shouldAddEvent) {
          result = "$result~$eventDetail";
        }
      } else {
        if (result.toString() != eventDetail) {
          result = "$result~$eventDetail";
        }
      }
      dataMap.update(eventDate, (String) => result);
    } else {
      dataMap.putIfAbsent(eventDate, () => eventDetail);
    }
    return dataMap;
  }
}
