// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals, unnecessary_brace_in_string_interps, avoid_print, empty_catches

import 'package:intl/intl.dart';
import 'package:nepali_patro_sql_package/localization/localehelper.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import '../utils.dart';
import 'datemapping.dart';

class BsDate {
  int? year;
  int? month;
  int? day;
  Map monthsMap = {
    "Baisakh": "वैशाख",
    "Jestha": "जेठ",
    "Ashar": "असार",
    "Shrawan": "साउन",
    "Bhadra": "भदौ",
    "Ashoj": "असोज",
    "Kartik": "कार्तिक",
    "Mangsir": "मंसिर",
    "Poush": "पुस",
    "Magh": "माघ",
    "Falgun": "फागुन",
    "Chaitra": "चैत"
  };

  Map dayMap = {
    "Monday": "सोमबार",
    "Tuesday": "मंगलबार",
    "Wednesday": "बुधबार",
    "Thursday": "बिहीबार",
    "Friday": "शुक्रबार",
    "Saturday": "शनिबार",
    "Sunday": "आइतबार",
  };

  Map dayMapShort = {
    "Mon": "सोम",
    "Tue": "मंगल",
    "Wed": "बुध",
    "Thu": "बिही",
    "Fri": "शुक्र",
    "Sat": "शनि",
    "Sun": "आइत"
  };

  DateTime? dateTime;

  //returns 08:35 PM
  static String DATETIME_FORMAT_TIME_AM = "'KK:mm a";

  //RETURNS 20:35
  static String DATETIME_FORMAT_TIME = "kk:mm";

  BsDate(int? year, int? month, int? day) {
    this.year = year;
    this.month = month;
    this.day = day;
//    dateTime = Timezone().curDateTimeByZone("NPT");
//    dateTime = now.add(Duration(hours: 5, minutes: 45));
  }

  getTime() {
    dateTime = Timezone().curDateTimeByZone("NPT");
    var formattedDate = DateFormat("hh:mm a 'NST'").format(dateTime!);
    return formattedDate;
  }

  getAd() {
    return DateMapping().getAd(this);
  }

  getYear() => year;

  getMonth() => month;

  getDay() => day;

  getMonthPad() => DateMapping.pad(month!);

  getDayPad() => DateMapping.pad(day!);

  getDayNp() {
    try {
      return LocaleHelper.formatNumber(getDay(), CONSTANTS_LOCALE_NEPALI);
    } catch (e) {
      return getDay();
    }
  }

  getDowShort() {
    var pos = getDow() == 7 ? 6 : getDow();
    return dayMapShort.keys.toList()[pos];
  }

  getDowNpShort() {
    var pos = getDow() == 7 ? 6 : getDow();
    var key = dayMapShort.keys.toList()[pos];
    return dayMapShort[key];
  }

  getDowLong() {
    var pos = getDow() == 7 ? 6 : getDow();
    return dayMap.keys.toList()[pos];
  }

  getDowLongNp() {
    var pos = getDow() == 7 ? 6 : getDow();
    var key = dayMap.keys.toList()[pos];
    return dayMap[key];
  }

  getActualDow() {
    try {
      return (getAd() as DateTime).weekday;
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  getDow() {
    try {
      DateTime ad = getAd();
      return ad.weekday - 1;
    } catch (e) {}
  }

  getDowFromAd(DateTime ad) {
    try {
      return ad.weekday - 1;
    } catch (e) {
      print("generategridsdate: ${e}");
    }
  }

  getMonthLong() {
    return monthsMap.keys.toList()[getMonth() - 1];
  }

  getMonthNpLong() {
    var key = monthsMap.keys.toList()[getMonth() - 1];
    return monthsMap[key];
  }

  getYearNp() {
    return LocaleHelper.formatNumber(getYear(), CONSTANTS_LOCALE_NEPALI);
  }

  getAdMonth(BsDate date) {
    DateTime dateTime = DateMapping().getAd(date);
    dateTime.month;
  }
}
