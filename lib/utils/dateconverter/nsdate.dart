// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:nepali_patro_sql_package/localization/localehelper.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';

class NsDate {
  int year;
  String month;
  int tithi;

  int? monthPrefix;
  int? monthSuffix;

  NsDate(this.year, this.month, this.tithi) {
    List<String> monthData = month.split(".");
    monthPrefix = int.tryParse(monthData[0]) ?? 0;
    monthSuffix = int.tryParse(monthData[1]) ?? 0;
  }

  getMonthLong() {
    return month;
  }

  getyear() {
    return year;
  }

  getYearNp() {
    LocaleHelper.formatNumber(year, CONSTANTS_LOCALE_NEPALI);
  }

  getTithi() {
    if (tithi == 16) {
      return 30;
    }
    return tithi;
  }

  getTithiLong(locale) {
    try {
      if (tithi > -1) {
        tithi = tithi == 30 ? tithi = 16 : tithi;
        if (locale == "ne") {
          var result = tithi_array_ne[(tithi > 0 ? tithi - 1 : tithi)];
          return result;
        } else {
          var result = tithi_array_en[(tithi > 0 ? tithi - 1 : tithi)];
          return result;
        }
      } else
        return "";
    } catch (e) {
      return "";
    }
  }

  getMonthSuffix() {
    return monthSuffix;
  }

  getMonthPrefix() {
    return monthPrefix;
  }

  getChandrama(locale) {
    if (locale == "ne") {
      return chandrama_ne[monthPrefix! - 1];
    } else {
      return chandrama_en[monthPrefix! - 1];
    }
  }
}
