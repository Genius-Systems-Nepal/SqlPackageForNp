// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_this, override_on_non_overriding_member, unnecessary_null_comparison, unnecessary_getters_setters

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart' as model;
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/singleton/singleTonAbstractClass.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/datemapping.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/bsdate.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomeEventsScopedModel extends Model {
  static HomeEventsScopedModel of(BuildContext context) =>
      ScopedModel.of<HomeEventsScopedModel>(context);

  List<model.Event> _homeListOfEvents = [];

  bool _hasEventLimit = true;

  List<model.Event> get homeListOfEvents => _homeListOfEvents;

  SingleTonAbstractClass singleTonAbstractClass = NsMappingState();

  DateTime? _now;
  BsDate? _bsDateToday;
  String _userId = "";

  DateTime get now => _now!;

  set now(DateTime value) {
    _now = value;
  }

  DatabaseHelper _dbHelper = DatabaseHelper.privateConstructor();
  HomeEventImplClass? _homeEventImplClass;
  DateMapping dateMapping = DateMapping();
  HomeEventImplClass get homeEventImplClass => _homeEventImplClass!;

  set homeEventImplClass(HomeEventImplClass value) {
    _homeEventImplClass = value;
  }

  HomeEventsScopedModel() {
    _dbHelper = _dbHelper;
  }

  Future<dynamic> run({bool force = false, isBackground = true}) async {
    try {
      _now = Timezone().curDateTimeByZone("NPT");
      if (isBackground) {
        _bsDateToday = (await dateMapping.getBsDatesByCompute([_now!]))[0];
      } else {
        _bsDateToday = dateMapping.getBs(_now!);
      }
      _userId = await PrefsUtils.getString(PREF_USER_ID, defUserId);
      await _loadListOfEvents(_bsDateToday!,
          force: force, isBackground: isBackground);
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  Future<void> _loadListOfEvents(BsDate bsDateToday,
      {bool force = false, isBackground = false}) async {
    List<model.Event> events = [];
    var validBsYear = singleTonAbstractClass.getNsMapping()?.validEndBsYear;

    DateTime startDate, endDate;
    if (isBackground) {
      // var dates = await dateMapping.getAdDatesByCompute([
      //   BsDate(bsDateToday.year , bsDateToday.month, bsDateToday.day),
      //   BsDate(validBsYear, 12,
      //       DateMapping().numberOfDaysInBsMonth(bsDateToday.year, 12))
      // ]);
      var dates = await dateMapping.getAdDatesByCompute([bsDateToday]);
      startDate = dates[0];
      endDate = dates[1];
    } else {
      startDate =
          BsDate(bsDateToday.year!, bsDateToday.month!, bsDateToday.day!)
              .getAd();
      endDate = BsDate(validBsYear, 12,
              DateMapping().numberOfDaysInBsMonth(bsDateToday.year!, 12))
          .getAd();
    }
//    var _todaysEventsLists = await _dbHelper?.getEventToday(_now);
//    _setHomeEventTodayModel(_todaysEventsLists);

    var repeatedEvents = await _dbHelper.getRepeatedEvents(startDate, endDate,
        impOnly: true, forceDefCal: true, isBackground: isBackground);
    events.addAll(repeatedEvents);

    var nonRepeatingEvents = await _dbHelper
        .getEventsbetweenDates(startDate, endDate, isBackground: isBackground);
    if (nonRepeatingEvents != null) {
      events.addAll(nonRepeatingEvents);
    }
    events.sort((a, b) => (a.startDate)!.compareTo(b.startDate!));

//    await NpCacheManager().generateCache(events, endDate);
    setHomeListOfEvents(events, notify: force, isBackground: isBackground);
  }

  setHomeListOfEvents(List<model.Event> events,
      {bool notify = false, bool isBackground = false}) async {
    try {
      _homeListOfEvents.clear();
      if (isBackground) {
        _homeListOfEvents = await compute(computeEvents, events);
      } else {
        _homeListOfEvents = computeEvents(events);
      }
      if (homeEventImplClass != null) homeEventImplClass.onUpdateData();
      if (notify) notifyListeners();
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  BsDate get bsDateToday => _bsDateToday!;

  set bsDateToday(BsDate value) {
    _bsDateToday = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  @override
  void changeHasEventLimit(value, {bool notify = false}) {
    if (value == null)
      _hasEventLimit = !this.hasEventLimit;
    else
      _hasEventLimit = value;
  }

  @override
  bool get hasEventLimit => _hasEventLimit;
}

List<model.Event> computeEvents(List<model.Event> events) {
  tz.initializeTimeZones();
  List<model.Event> filterEvents = [];
  // ignore: prefer_function_declarations_over_variables
  dynamic resultCompare = (model.Event b, model.Event a) {
    return a.startDate?.compareTo(b.startDate!);
  };

  // ignore: prefer_function_declarations_over_variables
  dynamic resultCompareReverse = (model.Event b, model.Event a) {
    return b.startDate?.compareTo(a.startDate!);
  };

  var nowTime = Timezone().curDateTimeByZone("NPT");
  var todayToThisYear = events
      .where(
        (model.Event e) =>
            (e.startDate!.difference(DateTime.now()).inDays == 0) ||
            e.startDate!.isAfter(
                  DateTime(nowTime.year, nowTime.month, nowTime.day),
                ) &&
                e.startDate!.isBefore(
                  Timezone().curDateTimeByZone("NPT").add(
                        const Duration(days: 365),
                      ),
                ),
      )
      .toList();

  var futureYear = events
      .where(
        (model.Event e) => e.startDate!.isAfter(
          Timezone().curDateTimeByZone("NPT").add(
                const Duration(days: 366),
              ),
        ),
      )
      .toList();

  var pastYear = events
      .where(
        (model.Event e) => e.startDate!.isBefore(
          DateTime(nowTime.year, nowTime.month, nowTime.day),
        ),
      )
      .toList();

  todayToThisYear.sort(resultCompareReverse);
  futureYear.sort(resultCompareReverse);
  pastYear.sort(resultCompare);

  filterEvents.addAll(todayToThisYear);
  filterEvents.addAll(futureYear);
  filterEvents.addAll(pastYear);
  return filterEvents;
}

abstract class HomeEventImplClass {
  void onUpdateData();
}
