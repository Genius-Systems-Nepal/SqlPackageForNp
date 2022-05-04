// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, unnecessary_string_escapes, curly_braces_in_flow_control_structures

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/bsdate.dart';
import 'package:nepali_patro_sql_package/utils/remoteconfigconstants.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import '../utils.dart';

class DateMapping {
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  var _startAdDate;
  int? _startBsYear;
  String _mapping = "";
  var bsDayCountsArray;
  var timezone = Timezone().curDateTimeByZone("NPT").timeZoneOffset;

  DateMapping._privateConstructor();

  static final DateMapping _instance = DateMapping._privateConstructor();

  factory DateMapping() {
    return _instance;
  }

  /*Mapping data for converting AD to BS and viceversa*/
  void setMapping(mappingData) {
    _mapping = mappingData;
  }

  /*Converts AD date to BS Date
  * Uses the date mapping string.
  * a.First counts the total days between the _startAdDate and the date to be converted.
  * b.Then the mapping string is added one at a time in a loop until the sum becomes greater or equal to the total days from a.
  * c. Then we add the startbsyear with the sum from b and divide it by 12 to get the BS Year.
  * d.Modulus dividing the result from b. and adding +1 will return BS month.
  * e.
  * */
  BsDate getBs(DateTime adDate, {DateTime? startAdDate}) {
    int? diff =
        CalendarUtils.getDaysBetween(startAdDate ?? _startAdDate, adDate, true);
    int cumulativeCount = 0;
    int index = 0;
    int indexValue = 0;
    for (int i = 0; i < bsDayCountsArray.toString().length; i++) {
      indexValue = int.tryParse(bsDayCountsArray[i].toString())!;
      cumulativeCount = cumulativeCount + 28 + indexValue;
      if (diff! < cumulativeCount) {
        break;
      }
      index++;
    }
    int year = _startBsYear! + index ~/ 12;
    int month = (index % 12) + 1;
    int day = int.parse(
        ((28 + indexValue) - (cumulativeCount - diff!) + 1).toString());
    return BsDate(year, month, day);
  }

  /*Returns Ad date from BS date.
  * Params:
  *   BsDate->Takes model Bsdate
  *
  * */
  DateTime getAd(BsDate bsDate) {
    int year = bsDate.getYear() - _startBsYear;
    int month = bsDate.getMonth();
    int day = bsDate.getDay();
    int indexPointer = ((year * 12) + month) - 1;
    int indexCurrent = 0;
    int indexValue = 0;
    int cumulativeCount = 0;

    for (int i = 0; i < bsDayCountsArray.toString().length; i++) {
      if (indexCurrent >= indexPointer) {
        break;
      }
      indexValue = int.tryParse(bsDayCountsArray[i].toString())!;
      cumulativeCount = cumulativeCount + (indexValue + 28);
      indexCurrent++;
    }
    cumulativeCount = cumulativeCount + day - 1;
    return CalendarUtils.addDays(_startAdDate, cumulativeCount);
  }

  int numberOfDaysInBsMonth(int year, int month) {
    int indexPointer = (((year - _startBsYear!) * 12) + month) - 1;
    var result = int.tryParse((bsDayCountsArray[indexPointer]));
    return result! + 28;
  }

  /*Adds number of month in bsdate.
  * Params:
  * BsDate: Bsdate in which month to be added./
  * counter: Number of months to be added.
  * */
  BsDate addMonthInBs(BsDate date, int counter) {
    var monthCounter = counter;
    var month = date.month;
    var year = date.year;
    var day = date.day;
    if ((month! + monthCounter) > 12) {
      var tempYear = (month + monthCounter - 1) / 12;
      var tempMonth = (month + monthCounter) % 12;
      month = tempMonth == 0 ? 12 : tempMonth;
      year = (year! + tempYear.toInt());
    } else {
      month = month + monthCounter;
    }
    var maxDays = numberOfDaysInBsMonth(year!, month);
    if (day! > maxDays) {
      day = 1;
      if ((month + 1) > 12) {
        month = 1;
        year = year + 1;
      } else {
        month = month + 1;
      }
    }
    var bsDate = BsDate(year, month, day);
    return bsDate;
  }

  /*Converts a single digit number to double digit and returns */
  static String pad(int n) {
    if (n <= 9)
      return "0" + n.toString();
    else
      return n.toString();
  }

  /*Initialized datemapping data
  * Fetches datemapping data from remoteconfig and places it in _mapping variable.
    initializes the _startAdDate,_startBsYear required for conversion
    * DateMapping format.
    * 1900|18430412|334333121222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221123244332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122334432212122343432221123334333121222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122343432221213334333211222334432212122343432221123244332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333212122334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121213334333212122334432212122343432221123334333121222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221123244332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333212122334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122334432212122343432221123334333121222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333212122334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122343432212122343432221123334333211222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122344332221213334333211222334432212122343432221123244333121213334333211222334432212122343432221123334333121213334333211222334432212122343432221123334333121222334333212122334432212122343432221123334333121222334333212122343432212122343432221213334333211222334333212122343432221122343432221213334333211222334333212122343432221122343432221213334333211222334342212122343432221122";
        ->Consists of three values separated by '|'.Splitting them will give three portions
        *  First Portion(1900): This represents the start bs date.
        * Second Portion(18430412):This represent start ad date refrence in the format YYYYMMDD. This is required to calculate the number of days between Ad date for AD to BS Conversion.
        * Third portion(3343331212223343332121223..): This represent the mapping data which consist of extra number of days in each month. We have assumed 27 as base month in each month and add
                                                      the extra number of days from each index to parse date.
  * */

  Future<void> initData() async {
    try {
      var remoteConfig = RemoteConfig.instance;
      if (_mapping.isEmpty) {
        _mapping = remoteConfig.getString(REMOTE_CONFIG_DATE_MAPPING);
      }
      var data = _mapping.split("\|");
      _startBsYear = int.tryParse(data[0]) ?? 1900;
      var adDate = data[1];
      _startAdDate = CalendarUtils.getCalendarFromString(adDate, toUtc: true);
      bsDayCountsArray = data[2];
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  int? getStartBSYear() => _startBsYear;

  dynamic getBSDayCount() => bsDayCountsArray;

  dynamic getStartAdDate() => _startAdDate;

  Future<List<DateTime>> getAdDatesByCompute(List<BsDate> bsDates) {
    var mapping = DateMapping();
    var startBsYear = mapping.getStartBSYear();
    var bsDayCounts = mapping.getBSDayCount();
    var startAdDate = mapping.getStartAdDate();

    return compute(getAdForCompute, {
      "bsdates": bsDates,
      "start_bs_year": startBsYear,
      "bs_day_counts_array": bsDayCounts,
      "start_ad_date": startAdDate,
    });
  }

  Future<List<BsDate>> getBsDatesByCompute(List<DateTime> adDates) {
    var mapping = DateMapping();
    var startBsYear = mapping.getStartBSYear();
    var bsDayCounts = mapping.getBSDayCount();
    var startAdDate = mapping.getStartAdDate();

    return compute(getBsForCompute, {
      "addates": adDates,
      "start_bs_year": startBsYear,
      "bs_day_counts_array": bsDayCounts,
      "start_ad_date": startAdDate,
    });
  }

  List<DateTime> getAdForCompute(Map<String, dynamic> data) {
    databaseHelper.initializeTimeZone();
    List<BsDate> bsDates = data["bsdates"];
    int startBsYear = data["start_bs_year"];
    dynamic bsDayCountsArray = data["bs_day_counts_array"];
    dynamic startAdDate = data["start_ad_date"];

    return bsDates
        .map((bsDate) =>
            getAds(bsDate, startBsYear, bsDayCountsArray, startAdDate))
        .toList();
  }

  DateTime getAds(BsDate bsDate, int startBsYear, dynamic bsDayCountsArray,
      dynamic startAdDate) {
    int year = bsDate.getYear() - startBsYear;
    int month = bsDate.getMonth();
    int day = bsDate.getDay();

    int indexPointer = ((year * 12) + month) - 1;
    int indexCurrent = 0;
    int indexValue = 0;
    int cumulativeCount = 0;

    for (int i = 0; i < bsDayCountsArray.toString().length; i++) {
      if (indexCurrent >= indexPointer) {
        break;
      }
      indexValue = int.parse(bsDayCountsArray[i].toString());
      cumulativeCount = cumulativeCount + (indexValue + 28);
      indexCurrent++;
    }
    cumulativeCount = cumulativeCount + day - 1;
    return CalendarUtils.addDays(startAdDate, cumulativeCount);
  }

  List<BsDate> getBsForCompute(Map<String, dynamic> data) {
    List<DateTime> addates = data["addates"];
    int startBsYear = data["start_bs_year"];
    dynamic bsDayCountsArray = data["bs_day_counts_array"];
    dynamic startAdDate = data["start_ad_date"];

    return addates
        .map((adDate) =>
            getsBs(adDate, startBsYear, bsDayCountsArray, startAdDate))
        .toList();
  }

  BsDate getsBs(DateTime adDate, int startBsYear, dynamic bsDayCountsArray,
      dynamic startAdDate) {
    int? diff = CalendarUtils.getDaysBetween(startAdDate, adDate, true);
    int cumulativeCount = 0;
    int index = 0;
    int indexValue = 0;
    for (int i = 0; i < bsDayCountsArray.toString().length; i++) {
      indexValue = int.parse(bsDayCountsArray[i].toString());
      cumulativeCount = cumulativeCount + 28 + indexValue;
      if (diff! < cumulativeCount) break;
      index++;
    }
    int year = startBsYear + index ~/ 12;
    int month = (index % 12) + 1;
    int day = int.parse(
        ((28 + indexValue) - (cumulativeCount - diff!) + 1).toString());
    return BsDate(year, month, day);
  }
}
