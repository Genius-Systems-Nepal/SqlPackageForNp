// import 'package:intl/intl.dart';

// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'package:intl/intl.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/bsdate.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/datemapping.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';

final String CONSTANTS_LOCALE_NEPALI = "ne";
final String CONSTANTS_LOCALE_ENGLISH = "en";

class CalendarUtils {
  static DateTime getCalendarFromStringFormat(String input, String format) {
    DateTime calendar = Timezone().curDateTimeByZone("NPT");
    try {
      String dateWithT = input.substring(0, 8) + 'T' + input.substring(8);
      calendar = DateTime.parse(dateWithT);
      /*DateFormat dateFormat = new DateFormat(format);
      calendar = dateFormat.parse(input);*/
    } catch (e) {
      Utils.debugLog(e);
      try {
        calendar = DateTime(
            int.parse(input.substring(0, 4)),
            int.parse(input.substring(4, 6)),
            int.parse(input.substring(6, 8)),
            int.parse(input.substring(8, 10)),
            int.parse(input.substring(10, 12)),
            int.parse(input.substring(12, 14)));
      } catch (e) {
        Utils.debugLog(e);
      }
    }
    return calendar;
  }

  static String formatCalendar(DateTime calendar, String format) {
    DateFormat df = DateFormat(format);
    return df.format(calendar);
  }

  static DateTime getCalendarFromString(String input, {toUtc = false}) {
    DateTime calendar = Timezone().curDateTimeByZone("NPT");
    try {
      calendar = DateTime.parse(input);
      calendar = Timezone().curDateTimeByZone("npt", dateTime: calendar);
    } catch (e) {
      Utils.debugLog(e);
    }
    return calendar;
  }

  static DATE_TYPE getEventRepetitionType(type) {
    if (type == "AD") {
      return DATE_TYPE.AD;
    } else if (type == "BS") {
      return DATE_TYPE.BS;
    } else {
      return DATE_TYPE.NS;
    }
  }

  static int getDayDiff(DateTime startDate, DateTime endDate) {
    Duration diff;
    endDate = DateTime(endDate.year, endDate.month, endDate.day);
    diff = endDate.difference(startDate);
    return diff.inDays;
  }

  static getRecurrenceRuleWeekofDay(String ruleKeyList) {
    switch (ruleKeyList) {
      case "SU":
        return 0;
      case "MO":
        return 1;
      case "TU":
        return 2;
      case "WE":
        return 3;
      case "TH":
        return 4;
      case "FR":
        return 5;
      case "SA":
        return 6;
    }
    return 0;
  }

  static DateTime addDays(DateTime date, int days) {
//    var resultDate = date.add(Duration(days: days));
    return Timezone().curDateTimeByZone("npt",
        dateTime: DateTime.utc(date.year, date.month, date.day + days));
  }

  static int? getDaysBetween(DateTime? d1, DateTime? d2, bool abs) {
    // d2 = DateTime(d2!.year, d2.month, d2.day);
    if (abs && d1 != null) {
      d1 = DateTime.utc(d1.year, d1.month, d1.day);
      d2 = DateTime.utc(d2!.year, d2.month, d2.day);
      if (d1.isAfter(d2)) {
        // swap dates so that d1 is start and d2 is end
        DateTime? swap = d1;
        d1 = d2;
        d2 = swap;
      }
    }
    // Duration difference = d2.difference(d1!);
    return d2?.difference(d1!).inDays;
    // return difference.inDays;
  }

  static addMonth(DateTime date, int months, {DateTime? startAdDate}) {
    var dateMapping = DateMapping();

    var bsDate = dateMapping.getBs(date, startAdDate: startAdDate);
    var tempBsDate = BsDate(bsDate.year, bsDate.month, 1);
    var addedMonth = DateMapping().addMonthInBs(tempBsDate, months);
    return addedMonth.getAd();
    /*  DateTime calculatedTime =
    new DateTime(date.year, date.month + months, date.day, 1);
    BsDate bsDate = DateMapping().getBs(calculatedTime);
    int maxBsDays =
    DateMapping.numberOfDaysInBsMonth(bsDate.year, bsDate.month);
    if (bsDate.day <=5 || bsDate.day > maxBsDays) {
      calculatedTime = new DateTime(date.year, date.month + months + 1, 01, 1);
    }
    return calculatedTime;*/
  }
}
// class CalendarUtils {
//   static String formatCalendar(DateTime calendar, String format) {
//     DateFormat df = DateFormat(format);
//     return df.format(calendar);
//   }

//   static DateTime getCalendarFromStringFormat(String input, String format) {
//     DateTime calendar = Timezone().curDateTimeByZone("NPT");
//     try {
//       String dateWithT = input.substring(0, 8) + 'T' + input.substring(8);
//       calendar = DateTime.parse(dateWithT);
//       /*DateFormat dateFormat = new DateFormat(format);
//       calendar = dateFormat.parse(input);*/
//     } catch (e) {
//       Utils.debugLog(e);
//       try {
//         calendar = DateTime(
//             int.parse(input.substring(0, 4)),
//             int.parse(input.substring(4, 6)),
//             int.parse(input.substring(6, 8)),
//             int.parse(input.substring(8, 10)),
//             int.parse(input.substring(10, 12)),
//             int.parse(input.substring(12, 14)));
//       } catch (e) {
//         Utils.debugLog(e);
//       }
//     }
//     return calendar;
//   }
// }


// // import 'package:flutter/foundation.dart';
// // import 'package:intl/intl.dart';
// // import 'package:nepali_patro_sql_package/utils/utils.dart';
// // // import 'package:nepalipatro/localizations/localehelper.dart';
// // // import 'package:nepalipatro/models/griditem.dart';
// // // import 'package:nepalipatro/utils/timezone.dart';
// // // import 'package:nepalipatro/utils/utils.dart';
// // // import 'package:timezone/data/latest_2015-2025.dart' as tz;

// // // import '../constants.dart';
// // // import '../utils.dart';
// // // import 'bsdate.dart';
// // // import 'datemapping.dart';

// // final String CONSTANTS_LOCALE_NEPALI = "ne";
// // final String CONSTANTS_LOCALE_ENGLISH = "en";

// // class CalendarUtils {
// //   final String CALENDAR_FORMAT_DD_MMM_YYYY = "dd,MMM,yyyy";
// //   final String CALENDAR_FORMAT_MMM_DD_YYY = "MMM dd, yyyy";
// //   final String CALENDAR_FORMAT_MMDDYYYY = "MM-dd-yyyy";

// //   /*Calculates the number of days between two dates.*/
// //   static int getDaysBetween(DateTime? d1, DateTime? d2, bool abs) {
// // //    d2 = DateTime(d2.year,d2.month,d2.day);
// //     if (abs && d1 != null) {
// //       d1 = DateTime.utc(d1.year,d1.month,d1.day);
// //       d2 = DateTime.utc(d2!.year, d2.month, d2.day);
// //       if (d1.isAfter(d2)) {
// //         // swap dates so that d1 is start and d2 is end
// //         DateTime? swap = d1;
// //         d1 = d2;
// //         d2 = swap;
// //       }
// //     }
// // //    Duration difference = d2.difference(d1) ;
// //     return d2!.difference(d1!).inDays;
// // //    return difference.inDays;
// //   }

// //   /*Adds number of days to given date
// //   * params:
// //   *   date: DateTime in which days to be added.
// //   *   days: no of days to be added to given date.
// //   * */
// //   static DateTime addDays(DateTime date, int days) {
// // //    var resultDate = date.add(Duration(days: days));
// //     return Timezone().curDateTimeByZone("npt",
// //         dateTime: DateTime.utc(date.year, date.month, date.day + days));
// //   }

// //   static getRecurrenceRuleWeekofDay(String ruleKeyList) {
// //     switch (ruleKeyList) {
// //       case "SU":
// //         return 0;
// //       case "MO":
// //         return 1;
// //       case "TU":
// //         return 2;
// //       case "WE":
// //         return 3;
// //       case "TH":
// //         return 4;
// //       case "FR":
// //         return 5;
// //       case "SA":
// //         return 6;
// //     }
// //     return 0;
// //   }

// //   static getRecurrenceRuleByWeekDay(int item) {
// //     if (item == 7) {
// //       item = 0;
// //     }
// //     switch (item) {
// //       case 0:
// //         return "SU";
// //       case 1:
// //         return "MO";
// //       case 2:
// //         return "TU";
// //       case 3:
// //         return "WE";
// //       case 4:
// //         return "TH";
// //       case 5:
// //         return "FR";
// //       case 6:
// //         return "SA";
// //     }
// //   }


// //   static DateTime getCalendarFromStringFormat(String input, String format) {
// //     DateTime calendar = Timezone().curDateTimeByZone("NPT");
// //     try {
// //       String dateWithT = input.substring(0, 8) + 'T' + input.substring(8);
// //       calendar = DateTime.parse(dateWithT);
// //       /*DateFormat dateFormat = new DateFormat(format);
// //       calendar = dateFormat.parse(input);*/
// //     } catch (e) {
// //       Utils.debugLog(e);
// //       try {
// //         calendar = DateTime(
// //             int.parse(input.substring(0, 4)),
// //             int.parse(input.substring(4, 6)),
// //             int.parse(input.substring(6, 8)),
// //             int.parse(input.substring(8, 10)),
// //             int.parse(input.substring(10, 12)),
// //             int.parse(input.substring(12, 14)));
// //       } catch (e) {
// //         Utils.debugLog(e);
// //       }
// //     }
// //     return calendar;
// //   }

// //   static String getDateStringfromCalendar(DateTime calendar, String format) {
// //     DateFormat df = new DateFormat(format);
// //     return df.format(calendar);
// //   }

// //   static String formatCalendar(DateTime calendar, String format) {
// //     DateFormat df = DateFormat(format);
// //     return df.format(calendar);
// //   }

// //   /*
// //   * Generates list of GridItem for given BS date
// //   *SHOULD PASS NEPALI YEAR AND NEPALI MONTH
// //   * */
// //   static List<GridItem> getCalendarGrid(bstoday, prefixsuffix, {currentBs}) {
// //     var year = bstoday.year;
// //     var month = bstoday.month;
// //     List<GridItem> gridItems = [];
// //     var npFirstDay = BsDate(year, month, 01);
// //     var currentMonth = false;
// //     var currentDate = false;

// //     DateTime firstDay = DateMapping().getAd(npFirstDay);

// //     var dow = npFirstDay.getDow() == 7 ? 0 : npFirstDay.getDow();
// //     dow += 1;
// //     int maxBsDays =
// //         DateMapping().numberOfDaysInBsMonth(npFirstDay.year!, npFirstDay.month!);
// //     int maxBsIndex = maxBsDays;
// //     //Utils.debugLog("LASTDAY-->$lastDay");
// //     if (prefixsuffix) {
// //       for (int i = dow; i > 0; i--) {
// //         var prevMonthDay = firstDay.add(Duration(days: -i));
// //         prevMonthDay = new Timezone().curDateTimeByZone("npt",
// //             dateTime: DateTime(
// //                 prevMonthDay.year, prevMonthDay.month, prevMonthDay.day, 00));
// //         var npDate = DateMapping().getBs(prevMonthDay);
// //         gridItems.add(GridItem(npDate, prevMonthDay, false, false));
// //       }
// //     }
// //     if (prefixsuffix) maxBsIndex = maxBsDays + gridItems.length;
// //     for (int j = 0; gridItems.length < maxBsIndex; j++) {
// //       var nextDay = firstDay.add(Duration(days: j));
// //       nextDay = new Timezone().curDateTimeByZone("npt",
// //           dateTime: new DateTime(nextDay.year, nextDay.month, nextDay.day, 00));
// //       var npDate = DateMapping().getBs(nextDay);
// //       currentMonth = month == npDate.getMonth();
// //       currentDate =
// //           npDate.getDay() == (bstoday as BsDate).getDay() && currentMonth;
// //       gridItems.add(GridItem(npDate, nextDay, currentMonth, currentDate));
// //     }

// //     if (prefixsuffix) {
// //       for (int k = maxBsDays; k < 42 - (maxBsIndex - maxBsDays); k++) {
// //         var nextDay = firstDay.add(Duration(days: k));
// //         nextDay = new Timezone().curDateTimeByZone("npt",
// //             dateTime:
// //                 new DateTime(nextDay.year, nextDay.month, nextDay.day, 00));
// //         var npDate = DateMapping().getBs(nextDay);
// //         currentMonth = month == npDate.getMonth();
// //         currentDate =
// //             npDate.getDay() == (bstoday as BsDate).getDay() && currentMonth;
// //         gridItems.add(GridItem(npDate, nextDay, currentMonth, currentDate));
// //       }
// //     }
// //     return gridItems;
// //   }

// //   /*returns last day of the month in AD date.
// //   * params:
// //   *   month--> Ad month,
// //   *   year--> Ad year.
// //   * */
// //   static getLastDayofMonth(month, year) {
// // // Find the last day of the month.
// //     var lastDayDateTime = (month < 12)
// //         ? new DateTime(year, month + 1, 0)
// //         : new DateTime(year + 1, 1, 0);

// //     // Print(lastDayDateTime.day);
// //     return lastDayDateTime.day;
// //   }

// //   /*Adds number of month to given date
// //   * params:
// //   *   date: DateTime in which days to be added.
// //   *   months: no of month to be added to given date.
// //   * */
// //   static addMonth(DateTime? date, int months) {
// //     var dateMapping = DateMapping();

// //     var bsDate = dateMapping.getBs(date);
// //     var tempBsDate = BsDate(bsDate.year, bsDate.month, 1);
// //     var addedMonth = DateMapping().addMonthInBs(tempBsDate, months);
// //     return addedMonth.getAd();
// //     /*  DateTime calculatedTime =
// //     new DateTime(date.year, date.month + months, date.day, 1);
// //     BsDate bsDate = DateMapping().getBs(calculatedTime);
// //     int maxBsDays =
// //     DateMapping.numberOfDaysInBsMonth(bsDate.year, bsDate.month);
// //     if (bsDate.day <=5 || bsDate.day > maxBsDays) {
// //       calculatedTime = new DateTime(date.year, date.month + months + 1, 01, 1);
// //     }
// //     return calculatedTime;*/
// //   }

// //   static DATE_TYPE getEventRepetitionType(type) {
// //     if (type == "AD") {
// //       return DATE_TYPE.AD;
// //     } else if (type == "BS") {
// //       return DATE_TYPE.BS;
// //     } else {
// //       return DATE_TYPE.NS;
// //     }
// //   }

// //   static bool isToday(DateTime time) {
// //     var now = Timezone().curDateTimeByZone("NPT");
// //     if (time.day == now.day &&
// //         time.year == now.year &&
// //         time.month == now.month) {
// //       return true;
// //     }
// //     return false;
// //   }

// //   static int getDayDiff(DateTime startDate, DateTime endDate) {
// //     Duration diff;
// //     endDate = DateTime(endDate.year, endDate.month, endDate.day);
// //     diff = endDate.difference(startDate);
// //     return diff.inDays;
// //   }

// //   static bool isSameDate(DateTime d1, DateTime d2) {
// //     if (d1.day == d2.day && d1.year == d2.year && d1.month == d2.month) {
// //       return true;
// //     }
// //     return false;
// //   }

// //   static Future<Map> getEventDetailbyDate(
// //       _bsDate, _npScopedModel, context) async {
// //     try {
// //       Map eventData = _npScopedModel.getCalendarData();
// //       Map yearData = eventData.containsKey(_bsDate.year.toString())
// //           ? eventData[_bsDate.year.toString()]
// //           : null;
// //       var monthData = yearData.containsKey(DateMapping.pad(_bsDate.month))
// //           ? yearData[DateMapping.pad(_bsDate.month)]
// //           : null;
// //       int? tithiPosition = -1;
// //       int? nsMonthPosition = -1;
// //       int? nsYearPosition = -1;
// //       int? chandramaPosition = -1;
// //       var tithi = '';
// //       var nsMonth = "";
// //       var nsYear = "";
// //       var chandrama = "";

// //       var locale = LocaleHelper.getLocaleCode(context);

// //       if (monthData != null)
// //         monthData.forEach((k) {
// //           if (k["day"].toString() == _bsDate.day.toString()) {
// //             Map AdMap = k["AD_date"];
// //             tithiPosition = AdMap.containsKey("tithi") ? AdMap["tithi"] : -1;
// //             nsMonthPosition =
// //                 AdMap.containsKey("ns_month") ? AdMap["ns_month"] : -1;
// //             nsYearPosition =
// //                 AdMap.containsKey("ns_year") ? AdMap["ns_year"] : -1;
// //             chandramaPosition =
// //                 AdMap.containsKey("chandrama") ? AdMap["chandrama"] : -1;
// //           }
// //         });
// //       if (tithiPosition! > 8 - 1) {
// //         tithiPosition =
// //             tithiPosition == 30 ? tithiPosition = 16 : tithiPosition;
// //       }
// //       if (locale == "ne") {
// //         tithi = tithi_array_ne[
// //             (tithiPosition! > 0 ? tithiPosition! - 1 : tithiPosition!)];
// //         nsMonth = ns_month_ne[nsMonthPosition!];
// //         nsYear = nsYearPosition.toString();
// //         chandrama = chandrama_ne[chandramaPosition!];
// //       } else {
// //         tithi = tithi_array_en[
// //             (tithiPosition! > 0 ? tithiPosition! - 1 : tithiPosition!)];
// //         nsMonth = ns_month_en[nsMonthPosition!];
// //         nsYear = nsYearPosition.toString();
// //         chandrama = chandrama_en[chandramaPosition!];
// //       }

// //       Map<String, dynamic> dayDetailsmap = Map();
// //       dayDetailsmap.putIfAbsent("tithi", () => tithi);
// //       dayDetailsmap.putIfAbsent("ns_month", () => nsMonth);
// //       dayDetailsmap.putIfAbsent("ns_year", () => nsYear);
// //       dayDetailsmap.putIfAbsent("chandrama", () => chandrama);
// //       return dayDetailsmap;
// //     } catch (e) {
// //       return Map<String, dynamic>();
// //     }
// //   }

// //   static String getRecurringType(Map<String?, dynamic> eventRepetitionData) {
// //     if (eventRepetitionData.containsValue(EVENT_REPETITION_AD_MONTH) ||
// //         eventRepetitionData.containsValue(EVENT_REPETITION_AD_YEAR)) {
// //       return "AD";
// //     } else if (eventRepetitionData.containsValue(EVENT_REPTITION_BS_MONTH) ||
// //         eventRepetitionData.containsValue(EVENT_REPTITION_BS_YEARLY)) {
// //       return "BS";
// //     } else if (eventRepetitionData.containsValue(EVENT_REPTITION_NS_MONTH)) {
// //       return "NS";
// //     } else {
// //       return "AD";
// //     }
// //   }

// //   static DATE_TYPE? getDateTypeFromCalendarBaseOn(basedOn) {
// //     switch (basedOn.toString()) {
// //       case "AD":
// //         return DATE_TYPE.AD;
// //       case "BS":
// //         return DATE_TYPE.BS;
// //       case "NS":
// //         return DATE_TYPE.NS;
// //       default:
// //         return null;
// //     }
// //   }

// //   static getCalendarBasedOnFromDateType(DATE_TYPE type) {
// //     switch (type) {
// //       case DATE_TYPE.AD:
// //         return "AD";
// //       case DATE_TYPE.BS:
// //         return "BS";
// //       case DATE_TYPE.NS:
// //         return "NS";
// //     }
// //   }

// //   static Future<List<GridItem>> getCalendarGridByCompute(bstoday, prefixsuffix) {
// //     var dateMapping = DateMapping();
// //     var args = {
// //       "bstoday": bstoday,
// //       "prefixsuffix": prefixsuffix,
// //       "start_bs_year": dateMapping.getStartBSYear(),
// //       "bs_day_counts_array": dateMapping.getBSDayCount(),
// //       "start_ad_date": dateMapping.getStartAdDate(),
// //     };

// //     return compute(getCalendarGridForCompute, args);
// //   }
// // }

// // // To be used by compute function
// // List<GridItem> getCalendarGridForCompute(Map<String, dynamic> data) {
// //   return getCalendarGrid(
// //       data["bstoday"],
// //       data["prefixsuffix"],
// //       data["start_bs_year"],
// //       data["bs_day_counts_array"],
// //       data["start_ad_date"]);
// // }


// // List<GridItem> getCalendarGrid(
// //     bstoday, prefixsuffix, startBsYear, bsDayCountsArray, startAdDate) {
// //   // tz.initializeTimeZones();
// //   var year = bstoday.year;
// //   var month = bstoday.month;
// //   List<GridItem> gridItems = [];
// //   var npFirstDay = BsDate(year, month, 01);
// //   var currentMonth = false;
// //   var currentDate = false;

// //   try {
// //     DateTime firstDay =
// //     getAd(npFirstDay, startBsYear, bsDayCountsArray, startAdDate);
// //     var dow = npFirstDay.getDowFromAd(firstDay);
// //     dow = dow == 7 ? 0 : dow;
// //     dow += 1;
// //     int maxBsDays = numberOfDaysInBsMonth(npFirstDay.year!, npFirstDay.month!, startBsYear,bsDayCountsArray);
// //     int maxBsIndex = maxBsDays;
// //     //Utils.debugLog("LASTDAY-->$lastDay");
// //     if (prefixsuffix) {
// //       for (int i = dow; i > 0; i--) {
// //         var prevMonthDay = firstDay.add(Duration(days: -i));
// //         prevMonthDay = Timezone().curDateTimeByZone("npt",dateTime: new DateTime(
// //             prevMonthDay.year, prevMonthDay.month, prevMonthDay.day, 01));
// //         var npDate =
// //         getBs(prevMonthDay, startBsYear, bsDayCountsArray, startAdDate);
// //         gridItems.add(GridItem(npDate, prevMonthDay, false, false));
// //       }
// //     }
// //     if (prefixsuffix) maxBsIndex = maxBsDays + gridItems.length;
// //     for (int j = 0; gridItems.length < maxBsIndex; j++) {
// //       var nextDay = firstDay.add(Duration(days: j));
// //       nextDay = Timezone().curDateTimeByZone("npt",dateTime:new DateTime(nextDay.year, nextDay.month, nextDay.day, 01));
// //       var npDate = getBs(nextDay, startBsYear, bsDayCountsArray, startAdDate);
// //       currentMonth = month == npDate.getMonth();
// //       currentDate =
// //           npDate.getDay() == (bstoday as BsDate).getDay() && currentMonth;
// //       gridItems.add(GridItem(npDate, nextDay, currentMonth, currentDate));
// //     }

// //     if (prefixsuffix) {
// //       for (int k = maxBsDays; k < 42 - (maxBsIndex - maxBsDays); k++) {
// //         var nextDay = firstDay.add(Duration(days: k));
// //         nextDay = Timezone().curDateTimeByZone("npt",dateTime:new DateTime(nextDay.year, nextDay.month, nextDay.day, 01));
// //         var npDate =
// //         getBs(nextDay, startBsYear, bsDayCountsArray, startAdDate);
// //         currentMonth = month == npDate.getMonth();
// //         currentDate =
// //             npDate.getDay() == (bstoday as BsDate).getDay() && currentMonth;
// //         gridItems.add(GridItem(npDate, nextDay, currentMonth, currentDate));
// //       }
// //     }
// //   } catch (e) {
// //     print(e);
// //   }
// //   return gridItems;
// // }
