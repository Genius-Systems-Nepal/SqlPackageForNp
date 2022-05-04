// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:nepali_patro_sql_package/models/NsData.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/models/deleteEventModel.dart';
import 'package:nepali_patro_sql_package/models/deleteReminderModel.dart';
import 'package:nepali_patro_sql_package/models/eventexceptionmodel.dart';
import 'package:nepali_patro_sql_package/models/remindersmodel.dart';
import 'calendareventsmodel.dart' as calendarEvent;

class SyncModel {
  List<calendarEvent.Event>? events;
  List<EventExceptionModel>? exceptions;
  List<RemindersModel>? reminders;
  List<Calendar>? calendars;
  List<Calendar>? deletedCalendar;
  List<DeletedEvents>? deletedEvents;
  List<DeleteReminderModel>? deletedReminder;
  NsData? nsData;
  DateTime? fromDate;
  int? version;

  SyncModel({this.events,
    this.exceptions,
    this.reminders,
    this.calendars,
    this.deletedCalendar,
    this.deletedEvents, this.deletedReminder, this.nsData,this.version,this.fromDate});

  factory SyncModel.fromJson(Map<String, dynamic> json) {
    return SyncModel(
        version: json["version"] == null ? null : int.parse(json["version"]),
        fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
        events: json["events"] == null
            ? null
            : List<calendarEvent.Event>.from(
            json["events"].map((x) =>
                calendarEvent.Event.fromJsonEncrypted(x))),
        exceptions: json["exceptions"] == null
            ? null
            : List<EventExceptionModel>.from(
            json["exceptions"].map((x) => EventExceptionModel.fromJson(x))),
        reminders: json["reminders"] == null
            ? null

            : List<RemindersModel>.from(
            json["reminders"].map((x) => RemindersModel.fromJson(x))),
        calendars: json["calendars"] == null
            ? null
            : List<Calendar>.from(
            json["calendars"].map((x) => Calendar.fromEncryptedJson(x))),
        deletedCalendar: json["deleted_calendar"] == null
            ? null
            : List<Calendar>.from(
            json["deleted_calendar"].map((x) => Calendar.fromJson(x))),
        deletedEvents: json["deleted_events"] == null
            ? null
            : List<DeletedEvents>.from(
            json["deleted_events"].map((x) => DeletedEvents.fromJson(x))),
        nsData: json["ns_data"] == null ? null : NsData.fromJson(jsonEncode(json["ns_data"])),
        deletedReminder: json["deleted_reminders"] == null
            ? null
            : List<DeleteReminderModel>.from(
            json["deleted_reminders"].map((x) =>
                DeleteReminderModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() =>
      {
        "events": events == null
            ? null
            : List<dynamic>.from(events!.map((x) => x.toJson())),
        "exceptions": exceptions == null
            ? null
            : List<dynamic>.from(exceptions!.map((x) => x.toJson())),
        "reminders": reminders == null
            ? null
            : List<dynamic>.from(reminders!.map((x) => x.toJson())),
        "calendars": calendars == null
            ? null
            : List<dynamic>.from(calendars!.map((x) => x.toJson())),
        "deleted_calendar": deletedCalendar == null
            ? null
            : List<dynamic>.from(deletedCalendar!.map((x) => x.toJson())),
        "deleted_events": deletedEvents == null
            ? null
            : List<dynamic>.from(deletedEvents!.map((x) => x.toJson())),
        "ns_data": nsData,
        "version":version,
        "from_date" : fromDate,
        "deleted_reminders": deletedReminder == null
            ? null
            : List<dynamic>.from(deletedReminder!.map((x) => x.toJson())),
      };
}
