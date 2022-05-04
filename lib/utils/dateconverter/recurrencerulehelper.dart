// ignore_for_file: prefer_typing_uninitialized_variables, constant_identifier_names, prefer_initializing_formals, unnecessary_null_comparison, unrelated_type_equality_checks

import 'dart:core';

// import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/singleton/singleTonAbstractClass.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/bsdate.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/datemapping.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/nsdate.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';

// import 'package:nepalipatro/singleton/singleTonAbstractClass.dart';
// import 'package:nepalipatro/utils/constants.dart';
// import 'package:nepalipatro/utils/dateconverter/bsdate.dart';
// import 'package:nepalipatro/utils/dateconverter/calendarutils.dart';
// import 'package:nepalipatro/utils/dateconverter/datemapping.dart';
// import 'package:nepalipatro/utils/utils.dart';

// import 'nsdate.dart';

const String RRULE_FREQUENCY = "FREQ";
const String RRULE_INTERVAL = "INTERVAL";
const String RRULE_COUNT = "COUNT";
const String RRULE_BYMONTH = "BYMONTH";
const String RRULE_BYDAY = "BYDAY";
const String RRULE_BYMONTHDAY = "BYMONTHDAY";
const String RRULE_UNTIL = "UNTIL";

const String FREQ_DAILY = "DAILY";
const String FREQ_WEEKLY = "WEEKLY";
const String FREQ_MONTHLY = "MONTHLY";
const FREQ_YEARLY = "YEARLY";

var fromCount = 0, toCount = 0;

class RecurrenceRuleHelper {
  var freq = "",
      count = "",
      interval = "1",
      until = "",
      bymonth = "",
      bymonthday = "";
  List<int> byday = [];
  var rRule = "";
  var baseDate, tempDate;
  DateTime? startDate;
  DateTime? mRecurrenceEndDate;
  DATE_TYPE? mDateType;
  DateTime? dateCounter;
//  NsMapping _nsMapping;
  SingleTonAbstractClass singleTonAbstractClass = NsMappingState();
  var _dateMapping;

  RecurrenceRuleHelper(String rrule, dynamic eventDate, DateTime startDate,
      DateTime recurrenceEndDate, DATE_TYPE type) {
    rRule = rrule;
    baseDate = eventDate;
//    this.startDate = eventDate;
    this.startDate = startDate;
//    if(rrule.contains("COUNT")||!rrule.contains("INTERVAL=1")){
//      this.startDate = eventDate;
//    }
    mRecurrenceEndDate = recurrenceEndDate;
    mDateType = type;
//    _nsMapping = NsMapping(); //INITIALIZES NS-AD/AD-NS CONVERSION MAPPING FILE.
    _dateMapping = DateMapping(); //INITIALIZED AD-BS/BS TO AD CONVERSION
    _initRules(); //INITIALIZES RRULE.
    _initCalendar(); //
  }

  void _initCalendar() {
    baseDate = baseDate as DateTime;
    tempDate =
        DateTime(baseDate.year, baseDate.month, baseDate.day, baseDate.hour);
    if (interval == "1" && count.isEmpty) {
      tempDate =
          DateTime(startDate!.year - 1, startDate!.month, startDate!.day);
    }
    dateCounter = tempDate;
  }

  List<dynamic> calculateEvents() {
//    List<dynamic> recurrenceDates = List();
    if (freq.isNotEmpty) {
      if (freq == FREQ_DAILY) {
        return _getDailyRepetition(1);
      } else if (freq == FREQ_WEEKLY) {
        return _getWeeklyRepetition(7);
      } else if (freq == FREQ_MONTHLY) {
        if (mDateType == DATE_TYPE.NS) {
          return _getNsMonthlyRepetitions();
        } else if (mDateType == DATE_TYPE.AD) {
          return _getMonthlyRepetition();
        } else {
          return _getMonthlyBsRepetition();
        }
      } else {
        if (mDateType == DATE_TYPE.NS) {
          return _getNsYearlyRepetitions();
        } else if (mDateType == DATE_TYPE.AD) {
          return _getYearlyRepetition();
        } else {
          return _getYearlyBsRepetition();
        }
      }
    }
    return [];
  }

  //RRULE CONSISTS OF INTERVAL,FREQ,COUNT,BYDAY,BYMONTH,BYMONTHDAY,UNTIL.
  void _initRules() {
    List<String> rules = rRule.toString().split(";");
    for (String ruleItem in rules) {
      var ruleKeyList = ruleItem.toString().split("=");
      var ruleKey = ruleKeyList[0];
      if (ruleKey.isNotEmpty) {
        switch (ruleKey) {
          case RRULE_FREQUENCY:
            freq = ruleKeyList[1];
            break;
          case RRULE_COUNT:
            count = ruleKeyList[1];
            break;
          case RRULE_BYDAY:
            var weeklyRule = ruleKeyList[1];
            var rulesLists = [];
            if (weeklyRule.contains(",")) {
              rulesLists = weeklyRule.split(",");
            } else {
              rulesLists.add(weeklyRule);
            }
            for (int i = 0; i < rulesLists.length; i++) {
              var dayOfWeek =
                  CalendarUtils.getRecurrenceRuleWeekofDay(rulesLists[i]);
              byday.add(dayOfWeek);
            }
            break;
          case RRULE_BYMONTH:
            bymonth = ruleKeyList[1];
            break;
          case RRULE_BYMONTHDAY:
            bymonthday = ruleKeyList[1];
            break;
          case RRULE_INTERVAL:
            interval = ruleKeyList[1];
            break;
          case RRULE_UNTIL:
            until = ruleKeyList[1].replaceAll("z", "");
            break;
        }
      }
    }
  }

  //AD DAILY REPETITION // donot touch this code
  /* This method returns the list of date and times
  * params :- interval factor i.e events repetition after interval days .
  * for eg. if interval count is 2, repeats events after 2 days*/
  //AD DAILY REPETITION
  _getDailyRepetition(int intervalfactor) {
    //todo changes in ios
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;
    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
    }

    var counter = 0;
    do {
      DateTime date = tempDate.add(Duration(
          days: counter *
              intervalCount *
              intervalfactor)); // added days with interval
      if (date.isAfter(mRecurrenceEndDate!)) {
        return dailyRepetition;
      }
      if (count.isNotEmpty) {
        var numberOfrecurrences = int.tryParse(count);
        if (counter >= numberOfrecurrences!) {
          return dailyRepetition;
        }
      } else if (untilRecurrenceDate != null) {
        if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
            !dateCounter!.isBefore(untilRecurrenceDate)) {
          return dailyRepetition;
        }
      }
      if (_shouldAddevent(date, startDate!, endDate: untilRecurrenceDate)) {
        dailyRepetition.add(date);
      }
      dateCounter = date;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /* This method returns the list of date and times
  * params :- interval factor i.e events repetition after interval week .
  * for eg. if interval count is 2, repeats events after 2 weeks*/
  //AD WEEKLY REPETITION
  _getWeeklyRepetition(int intervalfactor) {
    //todo changes in ios
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;
    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
//      untilRecurrenceDate = untilRecurrenceDate.add(Duration(days: 8));
    }
    var counter = 0;
    var additionalCounter = 0;
    mRecurrenceEndDate = mRecurrenceEndDate?.add(const Duration(
        days: 8)); // added 1 week beacause last week of month were ignored
    do {
      DateTime tempEndDate = tempDate
          .add(Duration(days: counter * intervalCount * intervalfactor));
      DateTime date = tempDate
          .add(Duration(days: counter * intervalCount * intervalfactor));

      byday.sort();
      for (int i = 0; i < byday.length; i++) {
//        var eventsAdded = false;
        var weekOfDay = byday[i];
//        if(weekOfDay == 0) weekOfDay = 7;
        if (weekOfDay >= 0) {
          var weekDay = tempEndDate.weekday;
          var diff = weekDay - weekOfDay;
          date = tempEndDate.add(Duration(days: -diff));
        }
        if (date.isAfter(mRecurrenceEndDate!)) {
          return dailyRepetition;
        }
        if (count.isNotEmpty) {
          var numberOfrecurrences = int.tryParse(count);
          if (additionalCounter >= numberOfrecurrences!) {
            return dailyRepetition;
          }
        } else if (untilRecurrenceDate != null) {
          if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
              !dateCounter!.isBefore(untilRecurrenceDate)) {
            return dailyRepetition;
          }
        }
        if (_shouldAddevent(date, baseDate,
            validateDay: false, endDate: untilRecurrenceDate)) {
          dailyRepetition.add(date);
          additionalCounter++;
        }
      }
      dateCounter = date;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /* This method returns the list of date and times
  * params :- interval factor i.e events repetition after interval mothns.
  * for eg. if interval count is 2, repeats events after 2 months*/
  //MONTHLY AD REPETITIOON // do not touch this code
  _getMonthlyRepetition() {
    //todo changes in ios
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;
    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
    }
    var counter = 0;
    DateTime date;
    do {
      /*DateTime temporyDate = _addMonth(tempDate, counter * intervalCount);  // delete because if we create event of 30 dec and reptition every 2 interval even create on march 30 which is wrong
      date = DateTime(
          temporyDate.year, temporyDate.month, int.tryParse(bymonthday));*/
      date = _addMonth(baseDate, counter * intervalCount);
      if (until.isNotEmpty) {
        if (dateCounter!.difference(untilRecurrenceDate).inDays != 0 &&
            date.isAfter(mRecurrenceEndDate!)) {
          return dailyRepetition;
        }
      } else {
        if (date.isAfter(mRecurrenceEndDate!)) {
          return dailyRepetition;
        }
      }
      if (count.isNotEmpty) {
        var numberOfrecurrences = int.tryParse(count);
        if (dailyRepetition.length >= numberOfrecurrences!) {
          // counter change to dailyreptition.length because if event is not created on that month counter is counted
          return dailyRepetition;
        }
      } else if (untilRecurrenceDate != null) {
        if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
            !dateCounter!.isBefore(untilRecurrenceDate)) {
          return dailyRepetition;
        }
      }
      if (_shouldAddevent(date, count.isNotEmpty ? baseDate : startDate,
          // count.isNotEmpty ? baseDate : startDate because if count is there event should need to counted on every month event added
          endDate: untilRecurrenceDate)) dailyRepetition.add(date);
      dateCounter = date;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /* This method returns the list of date and times in ad with corresponding BSDate
  * params :- interval factor i.e events repetition after interval months in BSDate .
  * for eg. if interval count is 2, repeats events after 2 months in BSDate*/
  //MONTHLY BS REPETITION
  _getMonthlyBsRepetition() {
    //todo changes in ios
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;
    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
    }

    var counter = 0;
    var additionalCounter = 0;
    do {
      DateTime temporyDate = _addMonth(tempDate, counter * intervalCount);
      if (temporyDate.isAfter(mRecurrenceEndDate!)) {
        return dailyRepetition;
      }
      if (count.isNotEmpty) {
        var numberOfrecurrences = int.tryParse(count);
        /*if (dailyRepetition.length >= numberOfrecurrences) {
          return dailyRepetition;
        }*/
        if (additionalCounter >= numberOfrecurrences!) {
          return dailyRepetition;
        }
      } else if (untilRecurrenceDate != null) {
        if (temporyDate.difference(untilRecurrenceDate).inDays != 0 &&
            !temporyDate.isBefore(untilRecurrenceDate)) {
          return dailyRepetition;
        }
      }
      if (_shouldAddevent(temporyDate, startDate!)) {
        dailyRepetition.add(temporyDate);
        additionalCounter++;
      }
      dateCounter = temporyDate;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /* This method returns the list of date and times
  * params :- interval factor i.e events repetition after interval years .
  * for eg. if interval count is 2, repeats events after 2 years*/
  //GET YEARLY AD REPTITION // do not touch this code
  _getYearlyRepetition() {
    //todo changes in ios
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;

    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
    }

    var counter = 0;
    var additonalCounter = 0;
    DateTime date;
    do {
      DateTime temporyDate = _addYear(tempDate, counter * intervalCount);
      date =
          DateTime(temporyDate.year, int.parse(bymonth), int.parse(bymonthday));
      if (untilRecurrenceDate != null) {
        if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
            date.isAfter(mRecurrenceEndDate!)) {
          return dailyRepetition;
        }
      }
      if (count.isNotEmpty) {
        var numberOfrecurrences = int.tryParse(count);
        if (additonalCounter >= numberOfrecurrences!) {
          return dailyRepetition;
        }
      } else if (untilRecurrenceDate != null) {
        if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
            !dateCounter!.isBefore(untilRecurrenceDate)) {
          return dailyRepetition;
        }
      }
      if (_shouldAddevent(date, startDate!, endDate: untilRecurrenceDate)) {
        dailyRepetition.add(date);
        additonalCounter++;
      }

      dateCounter = date;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /* This method returns the list of date and times in ad with corresponsding bsdate
  * params :- interval factor i.e events repetition after interval years in bsDate .
  * for eg. if interval count is 2, repeats events after 2 years of BSDate*/
  //YEARLY BS REPTITION
  _getYearlyBsRepetition() {
    List<dynamic> dailyRepetition = [];
    var intervalCount = int.tryParse(interval) ?? 1;
    var untilRecurrenceDate;
    if (until.isNotEmpty) {
      untilRecurrenceDate = CalendarUtils.getCalendarFromString(until);
    }

    var counter = 0;
    var additionCounter = 0;
    do {
      DateTime temporyDate = _addYear(tempDate, counter * intervalCount);
      if (temporyDate.isAfter(mRecurrenceEndDate!)) {
        return dailyRepetition;
      }
      if (count.isNotEmpty) {
        //ToDO changes in ios
        var numberOfrecurrences = int.tryParse(count);
        if (additionCounter >= numberOfrecurrences!) {
          return dailyRepetition;
        }
      } else if (untilRecurrenceDate != null) {
        if (dateCounter?.difference(untilRecurrenceDate).inDays != 0 &&
            !dateCounter!.isBefore(untilRecurrenceDate)) {
          return dailyRepetition;
        }
      }
      if (_shouldAddevent(temporyDate, startDate!, //todo changes in ios
          endDate: untilRecurrenceDate)) {
        dailyRepetition.add(temporyDate);
        additionCounter++;
      }
      dateCounter = temporyDate;
      counter++;
    } while (dateCounter!.isBefore(mRecurrenceEndDate!));
    return dailyRepetition;
  }

  /*This methods returns boolean value.
  * params:- tempdate ->  */
  //CHECKS WHETHER EVENT SHOULD BE ADDED TO RECURRENCE. USUALLY VALID FOR CERTAIN MONTH AND YEAR.
  _shouldAddevent(DateTime tempDate, DateTime startDate,
      {bool validateDay = true, endDate}) {
    // todo changes in ios
    try {
      tempDate = DateTime(tempDate.year, tempDate.month, tempDate.day);
      var tempDate2 = DateTime(baseDate.year, baseDate.month, baseDate.day);
      if (endDate != null) {
        if (tempDate.isAfter(endDate)) return false;
      }
      if (tempDate.toIso8601String() != tempDate2.toIso8601String()) {
        if (tempDate.isBefore(baseDate)) {
          return false;
        }
      }
      if (validateDay) {
        if (bymonthday.isNotEmpty) {
          if (mDateType == DATE_TYPE.BS) {
            BsDate bsDate = _dateMapping.getBs(tempDate);
            if (Utils.pad(bsDate.day!) != Utils.pad(int.parse(bymonthday))) {
              return false;
            }
          } else if (mDateType == DATE_TYPE.AD) {
            if (Utils.pad(tempDate.day) != Utils.pad(int.parse(bymonthday))) {
              return false;
            }
          }
        }
      }

      if (tempDate.day == startDate.day &&
          tempDate.year == startDate.year &&
          tempDate.month == startDate.month) {
        return true;
      } else if (endDate != null) {
        if ((tempDate.isAfter(startDate) && tempDate.isBefore(endDate)) ||
            tempDate == endDate) {
          // or condition is added because if tempdate and enddate are equal event not show on required date
          return true;
        } else {
          return false;
        }
      } else if (tempDate.isAfter(tempDate2) ||
          tempDate.toIso8601String() ==
              tempDate2.toIso8601String() /*tempDate.isAfter(startDate)*/) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //ADDS MONTH FOR AD AND BS.
  _addMonth(DateTime date, int month) {
    if (mDateType == DATE_TYPE.AD) {
      DateTime calculatedTime =
          DateTime(date.year, date.month + month, date.day, date.hour);
      return calculatedTime;
    } else {
      var bsDate = _dateMapping.getBs(date);
      var recurringBsDate;
      if (bsDate.month == 12) {
        recurringBsDate =
            BsDate(bsDate.year, bsDate.month, int.parse(bymonthday));
//        recurringBsDate = BsDate(bsDate.year + 1, 1, int.tryParse(bymonthday));
      } else {
        recurringBsDate =
            BsDate(bsDate.year, bsDate.month, int.parse(bymonthday));
      }
      var calculatedTime =
          DateMapping().addMonthInBs(recurringBsDate, month).getAd();
      return calculatedTime;
    }
  }

  //adds n number of year for given date.
  DateTime _addYear(tempDate, int i) {
    if (mDateType == DATE_TYPE.AD) {
      DateTime calculatedTime = DateTime(
          tempDate.year + i, tempDate.month, tempDate.day, tempDate.hour);
      return calculatedTime;
    } else {
      var bsDate = _dateMapping.getBs(tempDate);
      var recurringBsDate =
          BsDate((bsDate.year + i), int.parse(bymonth), int.parse(bymonthday));
      var calculatedTime = recurringBsDate.getAd();
      return calculatedTime;
    }
  }

  //COMPUTES NS MONTHLY REPTITION. // do not touch this code
  List _getNsMonthlyRepetitions() {
    //todo changes in ios
    if (byday.isNotEmpty) {
      return <DateTime>[];
    }
    List<DateTime> repetitionLists = [];
    try {
      var shouldAddDate;
      shouldAddDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
      var eventNsDate =
          singleTonAbstractClass.getNsMapping()?.getNsDate(shouldAddDate);
      var tempEventDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
      var lastEventDate = tempEventDate;
      var repetitionCountmap = {};
      var counter = 0;
      do {
        var incrementMonth;
        if (counter == 0) {
          incrementMonth = 0;
        } else if (interval.toString() == "1") {
          incrementMonth = counter;
        } else {
          counter = counter;
          incrementMonth = counter;
        }
//        var incrementMonth=counter==0?0:interval=="1"?counter:counter+1;
        var incrementMonth2 = 1;
        if (eventNsDate?.tithi == 30 ||
            eventNsDate?.tithi == 15 ||
            eventNsDate?.tithi == 16) {
          incrementMonth2 = 2;
        } else {
          incrementMonth2 = 1;
        }
        Map resultMap = singleTonAbstractClass
            .getNsMapping()
            ?.addMonthwithEvents(eventNsDate!, int.tryParse(bymonthday) ?? 0,
                incrementMonth * incrementMonth2);
        NsDate nsDate = resultMap["nsdate"];
        var events = resultMap["recurrence"];
        var value = "${nsDate.year}${nsDate.month}";
        if (events != null) {
          for (DateTime time in events) {
            if (time.isAfter(mRecurrenceEndDate!)) {
              return repetitionLists;
            }

            if (count.isNotEmpty) {
              var numberOfrecurrences = int.tryParse(count);
              if (repetitionCountmap.keys.toList().length >=
                  numberOfrecurrences!) {
                return repetitionLists;
              }
            } else if (until.isNotEmpty) {
              DateTime untilRecurrenceDate =
                  CalendarUtils.getCalendarFromString(until);
              if (time.difference(untilRecurrenceDate).inDays != 0 &&
                  !time.isBefore(untilRecurrenceDate)) {
                return repetitionLists;
              }
            }

            if (_shouldAddevent(time, baseDate,
                validateDay: false, endDate: mRecurrenceEndDate)) {
              repetitionLists.add(time);
              if (!repetitionCountmap.containsKey(value)) {
                repetitionCountmap.putIfAbsent(value, () => 1);
              }
            }
          }
        }
        if (repetitionLists.isNotEmpty) {
          lastEventDate = repetitionLists[repetitionLists.length - 1];
        }
        counter = counter + int.parse(interval);
      } while (lastEventDate.isBefore(mRecurrenceEndDate!));
    } catch (e) {
      return repetitionLists;
    }
    return repetitionLists;
  }

  //GET NS YEARLY REPETITION  // donot touch this code
  _getNsYearlyRepetitions() {
    //todo changes in ios

    if (byday.isNotEmpty) {
      return <DateTime>[];
    }

    List<DateTime> repetitionLists = [];
    try {
      var shouldStartDate;

      if (interval == "1" && (count == "0" || count == "" || count == null)) {
        shouldStartDate =
            DateTime(startDate!.year - 1, startDate!.month, startDate!.day);
      } else {
        shouldStartDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
      }
      var eventNsDate =
          singleTonAbstractClass.getNsMapping()?.getNsDate(shouldStartDate);
      var tempEventDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
      var baseEventNsDate =
          singleTonAbstractClass.getNsMapping()?.getNsDate(tempEventDate);
      var lastEventDate = tempEventDate;
      var counter = 0;
      var emptyCounter = 0;
      if (bymonthday == 16) {
        bymonthday = "30";
      }
      do {
        var incrementMonth;
        if (counter == 0) {
          incrementMonth = 0;
        } else if (interval.toString() == "1") {
          incrementMonth = counter;
        } else {
          counter = counter;
          incrementMonth = counter;
        }
        var eventDates = singleTonAbstractClass
            .getNsMapping()
            ?.addYearwithEvents(
                eventNsDate!, int.parse(bymonthday), bymonth, incrementMonth,
                selectedYear: baseEventNsDate?.year);
        for (DateTime eventTime in eventDates) {
          if (emptyCounter > 14) {
            break;
          }
          if (count.isNotEmpty) {
            var numberOfrecurrences = int.tryParse(count);
            if (repetitionLists.length >= numberOfrecurrences!) {
              return repetitionLists;
            }
          } else if (until.isNotEmpty) {
            DateTime untilRecurrenceDate =
                CalendarUtils.getCalendarFromString(until);
            if (eventTime.difference(untilRecurrenceDate).inDays != 0 &&
                !eventTime.isBefore(untilRecurrenceDate)) {
              return repetitionLists;
            }
          }

          if (_shouldAddevent(eventTime, baseDate,
              endDate: mRecurrenceEndDate)) {
            repetitionLists.add(eventTime);
          }
          lastEventDate = eventTime;
        }
        counter = counter + int.parse(interval);
      } while (lastEventDate.isBefore(mRecurrenceEndDate!));
      return repetitionLists;
    } catch (e) {
      Utils.debugLog(e);
      return repetitionLists;
    }
  }
}
