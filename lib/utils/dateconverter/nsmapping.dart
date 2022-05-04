// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_if_null_operators

import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/singleton/singleTonAbstractClass.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/nsdate.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import '../prefsutils.dart';

/*NsMapping is used for conversion between AD date to NS(Nepal Sambat) and viceversa.
* Uses TithiMapping which is extracted in the app directory /app_flutter. */
class NsMapping {
  static var tithiData;
  static Map? _tithiMap;
  static var _validStartBsYear = 0;
  static var _validEndBsYear = 0;
  var version;
  DateTime? _startAdDate;

//  var _startNsYear;
  int year = 0;
  String month = "";
  int day = 0;
  var monthMaps;
  var _dataMap;

//  List<String> _mappingData;
  String TITHI_FILE = "tithimap.txt";
  static var timezone = Timezone().curDateTimeByZone("NPT").timeZoneOffset;
  String resourcePath = "resources/assets/tithimap.txt";

  get validEndBsYear => _validEndBsYear;

  NsMapping() {
//    initTithiData();
  }

  /*takes the value 'validity' from the tithimapping file and checks if the given year lies between this range or not.
  * Returns true/false
  * Params:
  *     year: Year in BS date.
  * */
  static isDataValid(year) {
    if (year >= _validStartBsYear && year <= _validEndBsYear) {
      return true;
    }
    return false;
  }

  static setTithiData(String data) {
    tithiData = data;
  }

  /*This method reads data from the tithimap.txt file and initializes variable required for conversion.*/
  /*		Tithimap sample.
	{
   		 "st_ad":"18430412",
  		  "st_ns":"963",
  		  "Validity":"2074-2075",
       "0963.0":"096301.0115000000000000011103~096312.0130111111111111110115~096313.0114111111111111110014~096314.0130111111111121110116”,
            "1014.18474":"101401.0115111111121101111015~101402.0130111111111012110115",
            "1065.37079":"106501.0115111111111101111014~106502.0130111111111111110115",
            "1115.55358":"111501.0115111111011111211015~111502.0114111111111111110014",
            "1165.73607":"116501.0115111211111111111016~116502.0130111110111111110114",
            "1215.91888":"121501.0115111110111111111014~121502.0130111111111111110115"
    }

      St_ad :
      This represents the start of time that the conversion can support.
      This date is provided in AD in the format YYYYMMDD.

      St_ns:
        This represents the start of NS year.963 represents the year.
      Validity:

      This represents BS years range that are manually validated and are safe for users to be shown.
      Dates behind the start and after the end range should show some info * marks in the events lists with some valid information.
*/
  void initTithiData() async {
    try {
      if (tithiData == null || tithiData.toString().isEmpty) {
        tithiData = await Utils.readFile("tithimap");
      }

//      _tithiMap = jsonDecode(tithiData);
      _tithiMap = Utils.decrypt(tithiData);
//      _tithiMap = Utils.decodeDataWithoutIV("9E4mk3Woz7tN8Ic9LRZYG5ipy7971B62egK199a0d+c=", tithiData);
      try {
        version = int.parse(_tithiMap!["version"]);
        await PrefsUtils.putInt(PREF_TITHIMAP_VERSION, version);
      } catch (e) {
        Utils.debugLog(e);
      }
      var adDate = _tithiMap!["st_ad"] ?? "18430415";
//      _startNsYear = _tithiMap["st_ns"] ?? "963";
      _startAdDate = CalendarUtils.getCalendarFromString(adDate);
      var validity =
          _tithiMap!["validity"] == null ? "2075-2077" : _tithiMap!["validity"];
      List<String> validString = validity.toString().split("-");
      _validStartBsYear = int.tryParse(validString[0]) ?? 0;
      _validEndBsYear = int.tryParse(validString[1]) ?? 0;
    } catch (e) {
      Utils.debugLog("TITHIMAPINITIALIZATION->$e");
    }
  }

  /*Returns NS date from AdDate
  * Steps
  *   1.Days between the _startAdDate and given AD date is calculated first.
  *   2.Then we need to find the correct key value in oder to determine the actual month value.
  *       -> For this we use getRespectiveMap() method which takes the no of days difference calculated in step 1.
  *   3.As we get the key from step 2.(lets say 1065.37079) we split the value to get the cummulative days for the key.
  *   4.Take value from the json object using the key from step2 to get _dataMap;
  *   5.Now we traverse the resulting value one by one on the value from step 4 until we reach the required month data.
  *   6.As we reach to the required data (Lets say:116502.0130111110111111110114).We take certain values using the index.
  *             0-4 characters (0963): This represents the NS year.
                5-8 characters (01.0): This represent the NS month.
                01.0 represents month 1,02.0 represents month 2.
                9-11 characters(115): This part is divided into two parts.
                First 1 character represents the first day of tithi month.
                and 2nd 2 characters represents the end of tithi month.Usually it is 15 and 30 representing purnima and aunsi.
                12-27 characters(111111111211101):This sequence of 16 characters represents the tithi pattern for the given month.Consists of 0 ,1 and 2 representing.
                0 : This value represents that the tithi will not be available in the given position.
                 If 0 is present in 5th position then we assume that panchami is not available.
                  Similarly if 0 is present in 1st position then we assume pratipada is not available.
                  For example: in the given sequence 111111111211101, ) is available at the 14th position this means Chaturdashi is missing in the following month.
                  1: This value represents that the tithi for the given day is available and use it as it is.
                  2: This value represents that the same tithi will be represented twice as soon as it occurs.
                  For Example. 111111111211101 in the given example the value 2 is present at 10th position this means Dashami will repeat twice in this month.
                  The last two characters represents the total number of days in tithi available for that month.
  *
  * */
  NsDate? getNsDate(DateTime adDate) {
    try {
      int? diff = CalendarUtils.getDaysBetween(_startAdDate, adDate, true);
      String key = getRespectiveMap(diff!);
      _dataMap = _tithiMap![key].toString().split("~");
      int cumulativeCount = 0;
      if (key.isNotEmpty && key.contains(".")) {
        cumulativeCount = int.parse(key.split(".")[1]);
      }
      int totalDays = 0;
      var monthMap = "";
      List<int> dayMap = [];
      for (int i = 0; i < _dataMap.length; i++) {
        monthMap = _dataMap[i] ?? "";
        totalDays = int.parse(monthMap.toString().substring(
            monthMap.toString().length - 2, monthMap.toString().length));
        year = int.parse(monthMap.toString().substring(0, 4));
        month = monthMap.toString().substring(4, 8);
        cumulativeCount = cumulativeCount + totalDays;
        if (diff < cumulativeCount) {
          break;
        }
      }
      int dayEnd = int.parse(monthMap.toString().substring(9, 11));
      var daysArray = monthMap.toString().substring(11, 27);
      var counter = 0;
      //STEP 6
      do {
        if (dayMap.length >= totalDays) {
          break;
        }
        if ((counter + 1) <= daysArray.length) {
          var dayItem =
              int.tryParse(daysArray.substring(counter, counter + 1)) ?? 0;
          var prevItem = dayMap.isEmpty ? 0 : dayMap[dayMap.length - 1];
          if (dayItem == 1) {
            var nextDay = prevItem + 1;
            dayMap.add(nextDay);
            counter++;
          } else if (dayItem == 0) {
            dayMap.add((prevItem + 2));
            var cnt = dayMap[dayMap.length - 1];
            counter = cnt;
          } else if (dayItem == 2) {
            var nextDay = prevItem + 1;
            dayMap.add(nextDay);
            dayMap.add(nextDay);
            counter = counter + 1;
          }
        }
      } while (counter < daysArray.length);
      //STEP 6 TILL HERE.
      var dayIndex = (totalDays - (cumulativeCount - diff) + 1);
      var resultingDay;
      if (dayIndex > dayMap.length) {
        resultingDay = dayMap[dayMap.length - 1];
      } else {
        resultingDay = dayMap[dayIndex - 1];
      }
      if (resultingDay == 15 || resultingDay == 16) {
        if (dayEnd == 30) {
          resultingDay = dayEnd;
        }
      }
      day = resultingDay;

      return NsDate(year, month, day);
    } catch (e) {
      // Print(e);
    }
    return null;
  }

  /*This method will return the respective key from the tithimapping file.
  *   Params:   diff->This value will be used to find the actual key int the Map.*/
  getRespectiveMap(int diff) {
    List _keys = _tithiMap!.keys.toList();
    for (int i = 0; i < _keys.length; i++) {
      String keyItem = _keys[i];
      String nextKey = "";
      if (i + 1 < _keys.length) {
        nextKey = _keys[i + 1];
      }
      if (keyItem.contains(".") && nextKey.contains(".")) {
        var startWindowDays = int.tryParse(keyItem.split(".")[1]);
        var endWindowDays = int.tryParse(nextKey.split(".")[1]) ?? 0;
        if (diff >= startWindowDays! && diff <= endWindowDays) {
          return keyItem;
        }
      } else if (nextKey.isEmpty) {
        if (keyItem.contains(".")) {
          var startWindowDays = int.tryParse(keyItem.split(".")[1]);
          if (diff >= startWindowDays!) {
            return keyItem;
          }
        }
      }
    }
  }

/*This method will return the respective Map from the tithimapping file.
  *   Params:   nsYear->This value will be used to find the actual Map int the Map.
  * */
  getRespectiveNsMap(int nsYear) {
    List _keys = _tithiMap!.keys.toList();
    for (int i = 0; i < _keys.length; i++) {
      String keyItem = _keys[i];
      String nextKey = "";
      if (i + 1 < _keys.length) {
        nextKey = _keys[i + 1];
      }
      if (keyItem.contains(".") && nextKey.contains(".")) {
        var startWindowDays = int.tryParse(keyItem.split(".")[0]);
        var endWindowDays = int.tryParse(nextKey.split(".")[0]) ?? 0;
        if (nsYear >= startWindowDays! && nsYear < endWindowDays) {
          return keyItem;
        } else if (nsYear == endWindowDays) {
          return nextKey;
        }
      } else if (nextKey.isNotEmpty) {
        var nextKeywindow = int.tryParse(nextKey.split(".")[0]) ?? 0;
        if (nsYear == nextKeywindow) {
          return nextKey;
        }
      } else if (nextKey.isEmpty) {
        if (keyItem.contains(".")) {
          var startWindowDays = int.tryParse(keyItem.split(".")[0]);
          if (nsYear >= startWindowDays!) {
            return keyItem;
          }
        }
      }
    }
  }

  /*Uses tithi map  to find the index of current month in the map and navigate to another month using the next index.
  *
  * */
  addMonthwithEvents(NsDate nsDate, int eventDay, int month) {
    Map nsMap = getRespectiveNsMapWithIndex(nsDate.year, nsDate.month);
    Map resultMap = {};
    var index = nsMap["index"];
    var map = nsMap["mapping"];
    List mapLists = [];
    List<DateTime> dates = [];
    mapLists = map.toString().split("~");
    var newIndex = index + month;
    try {
      if (newIndex < mapLists.length) {
        var monthMap = mapLists[newIndex] ?? "";
        var mYear = int.tryParse(monthMap.toString().substring(0, 4));
        var mMonth = monthMap.toString().substring(4, 8);
        var endDate = monthMap.toString().substring(9, 11);
        var mNsDate = NsDate(mYear!, mMonth, eventDay);
        /*  if(eventDay==16){
          if(endDate=="30"){
            dates = getAdFromNs(NsDate(mYear, mMonth, 30));
          }*/ /*else{
            dates = getAdFromNs(NsDate(mYear, mMonth, 15));
          }*/ /*
        }else {

        }*/
        dates = getAdFromNs(NsDate(mYear, mMonth, eventDay));
        if (dates.isEmpty) {
          if (eventDay == 15) {
            if (endDate == 15) {
              var prevNsDate =
                  NsDate(mNsDate.year, mNsDate.month, eventDay - 1);
              dates = getAdFromNs(prevNsDate);
            } else {
              dates = [];
            }
          } else if (eventDay == 30) {
            if (endDate == 30) {
              var prevNsDate = NsDate(mNsDate.year, mNsDate.month, 14);
              dates = getAdFromNs(prevNsDate);
            } else {
              dates = [];
            }
          } else if (eventDay > 1) {
            var prevNsDate = NsDate(mNsDate.year, mNsDate.month, eventDay - 1);
            dates = getAdFromNs(prevNsDate);
          } else {
            dates = shiftToPreviousdate(mYear, mMonth, 2);
            if (dates.isEmpty) {
              dates = shiftToPreviousdate(mYear, mMonth, 3);
            }
          }
        } else {
          resultMap.putIfAbsent("nsdate", () => mNsDate);
          List<dynamic> date = [];
          DateTime? dateTime;
          for (DateTime dateTimes in dates) {
            if (dateTime != null) {
              if (dateTime.isAfter(dateTimes)) dateTime = dateTimes;
            } else {
              dateTime = dateTimes;
            }
          }
          date.add(dateTime);
          resultMap.putIfAbsent("recurrence", () => date);
          return resultMap;
        }
        resultMap.putIfAbsent("nsdate", () => mNsDate);
      }
      resultMap.putIfAbsent("recurrence", () => dates);
      return resultMap;
    } catch (e) {
      Utils.debugLog(e);
    }
    return resultMap;
  }

  addYearwithEvents(NsDate nsDate, int byMonthDay, String byMonth, int year,
      {int? selectedYear}) {
    nsDate = NsDate(nsDate.year + year, byMonth, byMonthDay);
    var dates = getAdFromNs(nsDate,
        igonreAdhikMonth: nsDate.year == selectedYear ? true : false);
    if (dates.isEmpty) {
      if (byMonthDay > 1) {
        var prevNsDate = NsDate(nsDate.year, nsDate.month, byMonthDay - 1);
        dates = getAdFromNs(prevNsDate);
        if (dates.isEmpty) {
          var prevNsDate = NsDate(nsDate.year, nsDate.month, byMonthDay - 2);
          dates = getAdFromNs(prevNsDate);
        }
      } else {
        dates = shiftToPreviousdate(nsDate.year, nsDate.month, 2);
        if (dates.isEmpty) {
          dates = shiftToPreviousdate(nsDate.year, nsDate.month, 3);
        }
      }
    } else {
      List<dynamic> date = [];
      DateTime? dateTime;
      for (DateTime dateTimes in dates) {
        if (dateTime != null) {
          if (dateTime.isAfter(dateTimes)) dateTime = dateTimes;
        } else {
          dateTime = dateTimes;
        }
      }
      date.add(dateTime);
      return date;
    }
    return dates;
  }

  shiftToPreviousdate(mYear, mMonth, count) {
    try {
      var dates = <DateTime>[];
      var tempEventDay = count;
      var daysAhead = count - 1;
      var tempNsDate = NsDate(mYear, mMonth, tempEventDay);
      List<DateTime> tempResultDates = getAdFromNs(tempNsDate);
      var adDate = tempResultDates[0];
      DateTime tempEventAdDate = adDate.add(Duration(days: -daysAhead));
      var newNsDate = getNsDate(tempEventAdDate);
      dates = getAdFromNs(newNsDate!);
      return dates;
    } catch (e) {
      return [];
    }
  }

  getRespectiveNsMapWithIndex(int nsYear, String nsMonth) {
    List _keys = _tithiMap!.keys.toList();
    String keyItem = "";
    String nextKey = "";
    for (int i = 0; i < _keys.length; i++) {
      keyItem = _keys[i];
      nextKey = "";
      if (i + 1 < _keys.length) {
        nextKey = _keys[i + 1];
      }
      if (keyItem.contains(".") && nextKey.contains(".")) {
        var startWindowDays = int.tryParse(keyItem.split(".")[0]);
        var endWindowDays = int.tryParse(nextKey.split(".")[0]) ?? 0;
        if (nsYear >= startWindowDays! && nsYear <= endWindowDays) {
          break;
        }
      } else if (nextKey.isEmpty) {
        if (keyItem.contains(".")) {
          var startWindowDays = int.tryParse(keyItem.split(".")[0]);
          if (nsYear >= startWindowDays!) {
            break;
          }
        }
      }
    }
    var keyMap = _tithiMap![keyItem];
    List<String> mapLists = keyMap.toString().split("~");
    for (int i = 0; i < mapLists.length; i++) {
      var monthMap = mapLists[i];
      var mYear = int.tryParse(monthMap.toString().substring(0, 4));
      var mMonth = monthMap.toString().substring(4, 8);
      if (mYear == nsYear && mMonth == nsMonth) {
        Map map = {};
        map.putIfAbsent("mapping", () => keyMap);
        map.putIfAbsent("index", () => i);
        return map;
      }
    }
  }

  /*Similar to AD to NS*/
  List<DateTime> getAdFromNs(NsDate nsDate, {bool igonreAdhikMonth = true}) {
    try {
      var key = getRespectiveNsMap(nsDate.year);
      var tithiData = _tithiMap![key];
      List<String> tithiList = tithiData.toString().split("~");

      var cummulativeCount = 0;
      var dayMap = [];
      if (key.toString().contains(".")) {
        cummulativeCount = int.tryParse(key.toString().split(".")[1]) ?? 0;
      }
      var totalDays = 0;
      var daysArray = "";
      int dayEnd = 0;
      for (int j = 0; j < tithiList.length; j++) {
        var monthMap = tithiList[j];
        totalDays = int.parse(monthMap.toString().substring(
            monthMap.toString().length - 2, monthMap.toString().length));
        year = int.parse(monthMap.toString().substring(0, 4));
        dayEnd = int.parse(monthMap.toString().substring(9, 11));
        month = monthMap.toString().substring(4, 8);
        daysArray =
            monthMap.toString().substring(11, /*26*/ monthMap.length - 2);
        if (!igonreAdhikMonth) {
          var result = nsDate.month.split(".");
          result[1] = "0";
          nsDate.month = '${result[0]}.${result[1]}';
        }
        if (month == nsDate.month && year == nsDate.year) {
          break;
        }
        cummulativeCount = cummulativeCount + totalDays;
      }
//      var counter = 0;
      /*do {
        if (dayMap.length >= totalDays) {
          break;
        }
        if ((counter + 1) <= daysArray.length) {
          var dayItem =
              int.tryParse(daysArray.substring(counter, counter + 1)) ?? 0;
          var prevItem = dayMap.length == 0 ? 0 : dayMap[dayMap.length - 1];
          if (dayItem == 1) {
            var nextDay = prevItem + 1;
            dayMap.add(nextDay);
            counter++;
          } else if (dayItem == 0) {
            var nextDay = prevItem + 2;
            dayMap.add(nextDay);
            var cnt = dayMap[dayMap.length - 1];
            counter = cnt;
            counter = cnt;
          } else if (dayItem == 2) {
            var nextDay = prevItem + 1;
            dayMap.add(nextDay);
            dayMap.add(nextDay);
            counter = counter + 1;
          }
        }
      } while (counter < daysArray.length);*/

      // for loop is added because do while didn't work ( i.e do while loop break when day Item is 0 and next day is 0 or 2
      for (int i = 0; i < daysArray.length; i++) {
        var dayItem = int.tryParse(daysArray.substring(i, i + 1)) ?? 0;
        if (dayItem == 1) {
          dayMap.add(i + 1);
        } else if (dayItem == 2) {
          dayMap.add(i + 1);
          dayMap.add(i + 1);
        }
      }

      List<DateTime> resultingDate = [];
      for (int i = 0; i < dayMap.length; i++) {
        int item = dayMap[i];
        if (item == 16 || item == 15) {
          if (dayEnd == 30) {
            item = 30;
          }
        }
        if (nsDate.tithi == item) {
          var difference = i + 1;
          /*if (nsDate.tithi == 30) {  // is deleted because tithi 30 may repeat twice also
            difference = totalDays;
          }*/
          var dayDiff = cummulativeCount + difference - 1;
          if (dayDiff.isNegative) dayDiff = 0;
          var adDate = DateTime(_startAdDate!.year, _startAdDate!.month,
              _startAdDate!.day, 01, 00);
          var resultDate = adDate.add(Duration(days: dayDiff));
          resultingDate.add(resultDate);
        }
      }
      return resultingDate;
    } catch (e) {
      return [];
    }
  }

  DateTime? getStartAdDate() {
    return _startAdDate;
  }

  Map? getTithiMap() {
    return _tithiMap;
  }
}

// ignore: slash_for_doc_comments
/**
 * To use in compute
 */

NsDate? getNsDate(DateTime adDate, DateTime _startAdDate, Map _tithiMap) {
  try {
    int? diff = CalendarUtils.getDaysBetween(_startAdDate, adDate, true);
    String key = getRespectiveMap(diff!, _tithiMap);
    var _dataMap = _tithiMap[key].toString().split("~");
    int cumulativeCount = 0;
    if (key.isNotEmpty && key.contains(".")) {
      cumulativeCount = int.parse(key.split(".")[1]);
    }
    int totalDays = 0;
    var monthMap = "";
    var year = 0;
    var day = 0;
    String month = "";
    List<int> dayMap = [];
    for (int i = 0; i < _dataMap.length; i++) {
      monthMap = _dataMap[i];
      totalDays = int.parse(monthMap.toString().substring(
          monthMap.toString().length - 2, monthMap.toString().length));
      year = int.parse(monthMap.toString().substring(0, 4));
      month = monthMap.toString().substring(4, 8);
      cumulativeCount = cumulativeCount + totalDays;
      if (diff < cumulativeCount) {
        break;
      }
    }
    int dayEnd = int.parse(monthMap.toString().substring(9, 11));
    var daysArray = monthMap.toString().substring(11, 27);
    var counter = 0;
    //STEP 6
    do {
      if (dayMap.length >= totalDays) {
        break;
      }
      if ((counter + 1) <= daysArray.length) {
        var dayItem =
            int.tryParse(daysArray.substring(counter, counter + 1)) ?? 0;
        var prevItem = dayMap.isEmpty ? 0 : dayMap[dayMap.length - 1];
        if (dayItem == 1) {
          var nextDay = prevItem + 1;
          dayMap.add(nextDay);
          counter++;
        } else if (dayItem == 0) {
          dayMap.add((prevItem + 2));
          var cnt = dayMap[dayMap.length - 1];
          counter = cnt;
        } else if (dayItem == 2) {
          var nextDay = prevItem + 1;
          dayMap.add(nextDay);
          dayMap.add(nextDay);
          counter = counter + 1;
        }
      }
    } while (counter < daysArray.length);
    //STEP 6 TILL HERE.
    var dayIndex = (totalDays - (cumulativeCount - diff) + 1);
    var resultingDay;
    if (dayIndex > dayMap.length) {
      resultingDay = dayMap[dayMap.length - 1];
    } else {
      resultingDay = dayMap[dayIndex - 1];
    }
    if (resultingDay == 15 || resultingDay == 16) {
      if (dayEnd == 30) {
        resultingDay = dayEnd;
      }
    }
    day = resultingDay;

    return NsDate(year, month, day);
  } catch (e) {
    // Print(e);
    return null;
  }
}

getRespectiveMap(int diff, Map _tithiMap) {
  List _keys = _tithiMap.keys.toList();
  for (int i = 0; i < _keys.length; i++) {
    String keyItem = _keys[i];
    String nextKey = "";
    if (i + 1 < _keys.length) {
      nextKey = _keys[i + 1];
    }
    if (keyItem.contains(".") && nextKey.contains(".")) {
      var startWindowDays = int.tryParse(keyItem.split(".")[1]);
      var endWindowDays = int.tryParse(nextKey.split(".")[1]) ?? 0;
      if (diff >= startWindowDays! && diff <= endWindowDays) {
        return keyItem;
      }
    } else if (nextKey.isEmpty) {
      if (keyItem.contains(".")) {
        var startWindowDays = int.tryParse(keyItem.split(".")[1]);
        if (diff >= startWindowDays!) {
          return keyItem;
        }
      }
    }
  }
}

Future<NsDate?> getNsDateByCompute(DateTime adDate) {
  var nsMapping = NsMappingState().getNsMapping();
  return compute(
    getNsDateForCompute,
    {
      "ad_date": adDate,
      "start_ad_date": nsMapping?.getStartAdDate(),
      "tithi_map": nsMapping?.getTithiMap(),
    },
  );
}

NsDate? getNsDateForCompute(Map<String, dynamic> data) {
  DateTime adDate = data["ad_date"];
  DateTime startAdDate = data["start_ad_date"];
  Map tithiMap = data["tithi_map"];
  return getNsDate(adDate, startAdDate, tithiMap);
}
