//    Instant, a time manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...

// ignore_for_file: equal_keys_in_map

import 'package:timezone/timezone.dart';

class Timezone {
  /// All avaible timezones for `dateTimeInZone`.
  ///
  /// Use `dateTimeByOffset` if desired zone isn't listed here.
  Map<String, double> timeZoneOffsets = {
    'LINT': 14,
    'CHADT': 13.75,
    'NZDT': 13,
    'ANAT': 12,
    'AEDT': 11,
    'ACDT': 10.5,
    'AEST': 10,
    'ACST': 9.5,
    'JST': 9,
    'ACWST': 8.75,
    'CST': 8,
    'WIB': 7,
    'MMT': 6.5,
    'BST': 6,
    'NPT': 5.75,
    'IST': 5.5,
    'UZT': 5,
    'AFT': 4.5,
    'GST': 4,
    'IRST': 3.5,
    'MSK': 3,
    'CEST': 2,
    'BST': 1,
    'GMT': 0,
    'UTC': 0,
    'CVT': -1,
    'WGST': -2,
    'NDT': -2.5,
    'ART': -3,
    'EDT': -4,
    'EST': -5,
    'CDT': -5,
    'CST': -6,
    'PDT': -7,
    'PST': -8,
    'AKDT': -8,
    'AKST': -9,
    'MART': -9.5,
    'HST': -10,
    'NUT': -11,
    'AoE': -12
  };

  /// Takes a timezone, and returns the current DateTime adjusted for that timezone.
  ///
  /// See `timeZoneOffsets` for all available time zones.
  DateTime curDateTimeByZone(String zone, {DateTime? dateTime}) {
    var detroit = getLocation('Asia/Kathmandu');
    DateTime utcDateTime = DateTime.now();
    if (dateTime != null) {
//    var now = TZDateTime.now(detroit);
      utcDateTime = DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
    }
    var now = TZDateTime.from(utcDateTime, detroit);
    return DateTime.parse(now.toIso8601String().replaceAll("+0545", ""));
  }

  DateTime curDateTimeByZoneWithTime(String zone, {DateTime? dateTime}) {
    var detroit = getLocation('Asia/Kathmandu');
//    DateTime utcDateTime = DateTime.now();
//    if (dateTime != null) {
////    var now = TZDateTime.now(detroit);
//      utcDateTime =
//          DateTime.utc(dateTime.year, dateTime.month, dateTime.day,dateTime.hour,dateTime.minute,dateTime.second,dateTime.millisecond);
//    }
    var now = TZDateTime.from(dateTime ?? DateTime.now(), detroit);
    return DateTime.parse(now.toIso8601String().replaceAll("+0545", ""));
  }

  /// Takes a UTC offset, and returns the current DateTime adjusted for that offset.
  ///
  /// Generally, dateTimeByZone is preferable for readability purposes, so use
  /// that if possible. Only use this if desired timezone is not listed in
  /// `timeZoneOffsets`.
  DateTime curDateTimeByUtcOffset(double offset) {
    var now = DateTime.now();
    DateTime toUTC = now.toUtc();
    DateTime returner;
    Duration subtr;
    Duration addr;
    if (offset <= 0) {
      subtr = Duration(
          hours: offset.abs().truncate(),
          minutes: ((offset.abs() % 1) * 60).round());
      returner = toUTC.subtract(subtr);
    } else {
      addr = Duration(
          hours: offset.truncate(), minutes: ((offset % 1) * 60).round());
      returner = toUTC.add(addr);
    }
    return returner;
  }

  DateTime parseDateTime(String timeZone, String dateTime) {
    var detroit = getLocation('Asia/Kathmandu');
    return TZDateTime.parse(detroit, dateTime);
  }

  /// Takes a timezone and Datetime.
  ///
  /// Returns the given DateTime adjusted for that timezone.
  ///
  /// See `timeZoneOffsets` for all available time zones.
  DateTime dateTimeToZone(String zone, DateTime datetime) {
    DateTime toUTC = datetime.toUtc();
    DateTime returner;
    Duration subtr;
    Duration addr;
    if (timeZoneOffsets[zone]! <= 0) {
      subtr = Duration(
          hours: timeZoneOffsets[zone]!.abs().truncate(),
          minutes: ((timeZoneOffsets[zone]!.abs() % 1) * 60).round());
      returner = toUTC.subtract(subtr);
    } else {
      addr = Duration(
          hours: timeZoneOffsets[zone]!.truncate(),
          minutes: ((timeZoneOffsets[zone]! % 1) * 60).round());
      returner = toUTC.add(addr);
    }
    return returner;
  }

  /// Takes a UTC offset and DateTime.
  ///
  /// Returns the given DateTime adjusted for that offset.
  ///
  /// Generally, dateTimeByZone is preferable for readability purposes, so use
  /// that if possible. Only use this if desired timezone/offset is not listed in
  /// `timeZoneOffsets`.
  DateTime dateTimeToOffset(double offset, DateTime datetime) {
    DateTime toUTC = datetime.toUtc();
    DateTime returner;
    Duration subtr;
    Duration addr;
    if (offset <= 0) {
      subtr = Duration(
          hours: offset.abs().truncate(),
          minutes: ((offset.abs() % 1) * 60).round());
      returner = toUTC.subtract(subtr);
    } else {
      addr = Duration(
          hours: offset.truncate(), minutes: ((offset % 1) * 60).round());
      returner = toUTC.add(addr);
    }
    return returner;
  }
}
