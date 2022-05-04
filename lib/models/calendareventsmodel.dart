// To parse this JSON data, do
//
// final calendarEvents = calendarEventsFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, non_constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';

List<Event> eventsFromJson(List<Map<String, dynamic>> results) => results
    .map((Map<String, dynamic> model) => Event.fromDbJson(model))
    .toList();

CalendarEventsModel calendarEventsFromJson(String str) =>
    CalendarEventsModel.fromJson(json.decode(str));

String calendarEventsToJson(CalendarEventsModel data) =>
    json.encode(data.toJson());

var cal_type = ["BS", "AD", "NS"];

class CalendarEventsModel {
  List<Event>? events;

  CalendarEventsModel({
    this.events,
  });

  factory CalendarEventsModel.fromJson(Map<String, dynamic> json) =>
      CalendarEventsModel(
        events: json["events"] == null
            ? null
            : List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": events == null
            ? null
            : List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class Event extends Equatable {
  String? id;
  String? parentEventId;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? isFullDayEvent;
  DateTime? recurringEndDate;
  int? isRecurring;
  String? createdBy;
  int? hasReminder;
  String? location;
  List<dynamic>? guests;
  dynamic rsvp;
  String? note;
  List<dynamic>? eventPermission;
  String? visibility;
  String? privacy;
  int? status;
  int? duration;
  int? gh;
  int? imp;
  String? rrule;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? calendar_id;
  String? basedOn;
  RsvpStats? rsvpStats;
  FormattedRrule? formattedRrule;
  DateTime? rsstart;
  int? origid;
  Event({
    this.id,
    this.parentEventId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.isFullDayEvent,
    this.recurringEndDate,
    this.isRecurring,
    this.createdBy,
    this.hasReminder,
    this.location,
    this.guests,
    this.rsvp,
    this.note,
    this.eventPermission,
    this.visibility,
    this.privacy,
    this.status,
    this.duration,
    this.gh,
    this.imp,
    this.rrule,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.calendar_id,
    this.basedOn,
    this.rsvpStats,
    this.formattedRrule,
    this.rsstart,
    this.origid,
  });

  factory Event.fromJson(Map<String, dynamic> data) {
    // try {
    var event = Event(
      id: data["id"] == null ? null : data["id"].toString(),
      parentEventId: data["parent_event_id"] == null
          ? ""
          : data["parent_event_id"].toString(),
      title: data["title"],
      description: data["description"],
      startDate: data["start_date"] == null
          ? null
          : DateTime.parse(data["start_date"]),
      endDate:
          data["end_date"] == null ? null : DateTime.parse(data["end_date"]),
      isFullDayEvent: data["is_full_day_event"],
      recurringEndDate: data["recurring_end_date"] == null
          ? null
          : DateTime.parse(data["recurring_end_date"]),
      isRecurring: data["is_recurring"],
      createdBy: data["created_by"],
      hasReminder: data["has_reminder"],
      location: data["location"],
      /*guests: data["guests"] == null
            ? null
            :   List<dynamic>.from(data["guests"].map((x) => x)),*/ // remove because it makes error,
      rsvp: data["rsvp"],
      note: data["note"],
      eventPermission: data["event_permission"] == null
          ? null
          : List<String>.from(
              (json.decode(data["event_permission"]).map((x) => x))),
      visibility: data["visibility"],
      privacy: data["privacy"],
      status: data["status"],
      duration: data["duration"],
      gh: data["gh"] ?? 0,
      imp: data["important_event"] ?? 0,
      rrule: data["rrule"] == null ? null : Utils.decryptData(data["rrule"]),
      deletedAt: data["deleted_at"],
      createdAt: data["created_at"] == null
          ? null
          : DateTime.parse(data["created_at"]),
      updatedAt: data["updated_at"] == null
          ? null
          : DateTime.parse(data["updated_at"]),
      calendar_id:
          data["calendar_id"] == null ? null : data["calendar_id"].toString(),
      basedOn: data["based_on"],
      rsvpStats: data["rsvp_stats"] == null
          ? null
          : RsvpStats.fromJson(data["rsvp_stats"]),
      formattedRrule: data["formatted_rrule"] == null
          ? null
          : data["formatted_rrule"] is! Map
              ? null
              : FormattedRrule.fromJson(data["formatted_rrule"]),
      rsstart: data["rsstart"] == null ? null : DateTime.parse(data["rsstart"]),
      origid: data["origid"] == null
          ? -1
          : (data["origid"] is String)
              ? int.tryParse(data["origid"]) ?? -1
              : data["origid"],
    );
    return event;
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  factory Event.fromJsonEncrypted(Map<String, dynamic> json) {
    // try {
    var event = Event(
      id: json["id"] == null ? null : json["id"].toString(),
      parentEventId: json["jpid"] == null ? null : json["jpid"].toString(),
      title: json["jtl"] ?? "",
      description: json["jds"],
      startDate: json["jsdt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jsdt"], "yyyyMMddHHmmss"),
      endDate: json["jed"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jed"], "yyyyMMddHHmmss"),
      isFullDayEvent: json["jfd"],
      recurringEndDate: json["jred"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jred"], "yyyyMMddHHmmss"),
      isRecurring: json["jir"],
      createdBy: json["jcb"],
      hasReminder: json["jhr"],
      location: json["jlo"],
      /*guests: json["guests"] == null
            ? null
            :   List<dynamic>.from(json["guests"].map((x) => x)),*/ // remove because it makes error,
      rsvp: json["jrsvp"],
      note: json["jnot"],
      eventPermission: json["jep"] == null
          ? null
          : List<String>.from(json["jep"].map((x) => x)),
      visibility: json["jvis"],
      privacy: json["jpr"],
      status: json["jst"],
      duration: json["jdur"],
      gh: json["gh"] ?? 0,
      imp: json["jie"] ?? 0,
      rrule: json["jrrul"],
      deletedAt: json["jda"],
      createdAt: json["jrcdt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jrcdt"], "yyyyMMddHHmmss"),
      updatedAt: json["jrudt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jrudt"], "yyyyMMddHHmmss"),
      calendar_id: json["jci"] == null ? null : json["jci"].toString(),
      basedOn: json["jbo"] == null
          ? null
          : json["jbo"] is int
              ? cal_type[json["jbo"]]
              : json["jbo"],
      rsvpStats: json["rsvp_stats"] == null
          ? null
          : RsvpStats.fromJson(json["rsvp_stats"]),
      formattedRrule: json["jfr"] == null
          ? null
          : json["jfr"] is! Map
              ? null
              : FormattedRrule.fromJson(json["jfr"]),
      rsstart: json["rsstart"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jsdt"], "yyyyMMddHHmmss"),
      origid: json["joid"] == null
          ? -1
          : (json["joid"] is String)
              ? int.tryParse(json["joid"]) ?? -1
              : json["joid"],
    );
    return event;
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  factory Event.fromJsonEncryptedRuleOnly(Map<String, dynamic> json) {
    // try {
    var event = Event(
      id: json["id"] == null ? null : json["id"].toString(),
      parentEventId: json["jpid"] == null ? null : json["jpid"].toString(),
      title: json["jtl"] ?? "",
      description: json["jds"],
      startDate: json["jsdt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jsdt"], "yyyyMMddHHmmss"),
      endDate: json["jed"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jed"], "yyyyMMddHHmmss"),
      isFullDayEvent: json["jfd"],
      recurringEndDate: json["jred"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jred"], "yyyyMMddHHmmss"),
      isRecurring: json["jir"],
      createdBy: json["jcb"],
      hasReminder: json["jhr"],
      location: json["jlo"],
      /*guests: json["guests"] == null
            ? null
            :   List<dynamic>.from(json["guests"].map((x) => x)),*/ // remove because it makes error,
      rsvp: json["jrsvp"],
      note: json["jnot"],
      eventPermission: json["jep"] == null
          ? null
          : List<String>.from(json["jep"].map((x) => x)),
      visibility: json["jvis"],
      privacy: json["jpr"],
      status: json["jst"],
      duration: json["jdur"],
      gh: json["gh"] ?? 0,
      imp: json["jie"] ?? 0,
      rrule: json["jrrul"] == null ? null : Utils.decryptData(json["jrrul"]),
      deletedAt: json["jda"],
      createdAt: json["jrcdt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jrcdt"], "yyyyMMddHHmmss"),
      updatedAt: json["jrudt"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jrudt"], "yyyyMMddHHmmss"),
      calendar_id: json["jci"] == null ? null : json["jci"].toString(),
      basedOn: json["jbo"] == null
          ? null
          : json["jbo"] is int
              ? cal_type[json["jbo"]]
              : json["jbo"],
      rsvpStats: json["rsvp_stats"] == null
          ? null
          : RsvpStats.fromJson(json["rsvp_stats"]),
      formattedRrule: json["jfr"] == null
          ? null
          : json["jfr"] is! Map
              ? null
              : FormattedRrule.fromJson(json["jfr"]),
      rsstart: json["rsstart"] == null
          ? null
          : CalendarUtils.getCalendarFromStringFormat(
              json["jsdt"], "yyyyMMddHHmmss"),
      origid: json["joid"] == null
          ? -1
          : (json["joid"] is String)
              ? int.tryParse(json["joid"]) ?? -1
              : json["joid"],
    );
    return event;
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  factory Event.fromDbJson(Map<String, dynamic> json) {
    // try {
    var event = Event(
      id: json["id"] == null ? null : json["id"].toString(),
      parentEventId: json["parent_event_id"] == null
          ? ""
          : json["parent_event_id"].toString(),
      title: json["title"] ?? "",
      description: json["description"] == null
          ? null
          : Utils.decryptData(json["description"]),
      startDate: json["start_date"] == null
          ? null
          : DateTime.parse(json["start_date"]),
      endDate:
          json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
      isFullDayEvent: json["is_full_day_event"],
      recurringEndDate: json["recurring_end_date"] == null
          ? null
          : DateTime.parse(json["recurring_end_date"]),
      isRecurring: json["is_recurring"],
      createdBy: json["created_by"],
      hasReminder: json["has_reminder"],
      location: json["location"],
      guests: json["guests"] == null
          ? null
          : jsonDecode(json["guests"]) as List<dynamic>,
      note: json["note"],
      eventPermission: json["event_permission"] == null
          ? null
          : jsonDecode((json["event_permission"])),
      visibility: json["visibility"],
      privacy: json["privacy"],
      status: json["status"],
      duration: json["duration"],
      gh: json["gh"] ?? 0,
      imp: json["important_event"] ?? 0,
      rrule: json["rrule"] == null ? null : Utils.decryptData(json["rrule"]),
      deletedAt: json["deleted_at"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      calendar_id:
          json["calendar_id"] == null ? null : json["calendar_id"].toString(),
      basedOn: json["based_on"],
      rsvpStats: json["rsvp_stats"] == null
          ? null
          : RsvpStats.fromJson(jsonDecode(json["rsvp_stats"])),
      formattedRrule: json["formatted_rrule"] == null ? null : null,
      rsstart: json["rsstart"] == null ? null : DateTime.parse(json["rsstart"]),
      origid: json["origid"] == null
          ? -1
          : (json["origid"] is String)
              ? int.tryParse(json["origid"]) ?? -1
              : json["origid"],
    );
    return event;
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  Map<String, dynamic> toJson({formatDate = false}) => {
        "id": id == null ? null : id.toString(),
        "parent_event_id":
            parentEventId == null ? null : parentEventId.toString(),
        "title": title ?? "",
        "description": description,
        "start_date": startDate == null
            ? null
            : !formatDate
                ? startDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    startDate!, "yyyy-MM-dd HH:mm:ss"),
        "end_date": endDate == null
            ? null
            : !formatDate
                ? endDate?.toIso8601String()
                : CalendarUtils.formatCalendar(endDate!, "yyyy-MM-dd HH:mm:ss"),
        "is_full_day_event": isFullDayEvent,
        "recurring_end_date": recurringEndDate == null
            ? null
            : !formatDate
                ? recurringEndDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    recurringEndDate!, "yyyy-MM-dd hh:mm:ss"),
        "is_recurring": isRecurring,
        "created_by": createdBy,
        "has_reminder": hasReminder,
        "location": location,
        "guests": guests == null ? null : jsonEncode(guests),
        //   List<dynamic>.from(guests.map((x) => x)),
        "rsvp": rsvp,
        "note": note,
        "event_permission":
            eventPermission == null ? null : jsonEncode(eventPermission),
        //  List<dynamic>.from(eventPermission.map((x) => x)),
        "visibility": visibility,
        "privacy": privacy,
        "status": status,
        "duration": duration ?? -1,
        "gh": gh ?? 0,
        "important_event": imp ?? 0,
        "rrule": rrule == null ? null : Utils.encrypt(rrule!),
        "deleted_at": deletedAt,
        "created_at": createdAt == null
            ? null
            : !formatDate
                ? createdAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    createdAt!, "yyyy-MM-dd HH:mm:ss"),
        "updated_at": updatedAt == null
            ? null
            : !formatDate
                ? updatedAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    updatedAt!, "yyyy-MM-dd HH:mm:ss"),
        "calendar_id": calendar_id == null ? null : calendar_id.toString(),
        "based_on": basedOn,
        "rsvp_stats": rsvpStats == null ? null : jsonEncode(rsvpStats),
        "formatted_rrule":
            formattedRrule == null ? null : jsonEncode(formattedRrule),
        "rsstart": rsstart == null ? null : rsstart?.toIso8601String(),
        "origid": origid ?? -1,
      };

  Map<String, dynamic> toJsonDecrypt({formatDate = false}) => {
        "id": id == null ? null : id.toString(),
        "parent_event_id":
            parentEventId == null ? null : parentEventId.toString(),
        "title": title ?? "",
        "description": description,
        "start_date": startDate == null
            ? null
            : !formatDate
                ? startDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    startDate!, "yyyy-MM-dd HH:mm:ss"),
        "end_date": endDate == null
            ? null
            : !formatDate
                ? endDate?.toIso8601String()
                : CalendarUtils.formatCalendar(endDate!, "yyyy-MM-dd HH:mm:ss"),
        "is_full_day_event": isFullDayEvent,
        "recurring_end_date": recurringEndDate == null
            ? null
            : !formatDate
                ? recurringEndDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    recurringEndDate!, "yyyy-MM-dd HH:mm:ss"),
        "is_recurring": isRecurring,
        "created_by": createdBy,
        "has_reminder": hasReminder,
        "location": location,
        "guests": guests == null ? null : jsonEncode(guests),
        //   List<dynamic>.from(guests.map((x) => x)),
        "rsvp": rsvp,
        "note": note,
        "event_permission":
            eventPermission == null ? null : jsonEncode(eventPermission),
        //  List<dynamic>.from(eventPermission.map((x) => x)),
        "visibility": visibility,
        "privacy": privacy,
        "status": status,
        "duration": duration ?? -1,
        "gh": gh ?? 0,
        "important_event": imp ?? 0,
        "rrule": rrule,
        "deleted_at": deletedAt,
        "created_at": createdAt == null
            ? null
            : !formatDate
                ? createdAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    createdAt!, "yyyy-MM-dd HH:mm:ss"),
        "updated_at": updatedAt == null
            ? null
            : !formatDate
                ? updatedAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    updatedAt!, "yyyy-MM-dd HH:mm:ss"),
        "calendar_id": calendar_id == null ? null : calendar_id.toString(),
        "based_on": basedOn,
        "rsvp_stats": rsvpStats == null ? null : jsonEncode(rsvpStats),
        "formatted_rrule":
            formattedRrule == null ? null : jsonEncode(formattedRrule),
        "rsstart": rsstart == null ? null : rsstart?.toIso8601String(),
        "origid": origid ?? -1,
      };

  Map<String, dynamic> toJsonNoEncryption({formatDate = false}) => {
        "id": id == null ? null : id.toString(),
        "parent_event_id":
            parentEventId == null ? null : parentEventId.toString(),
        "title": title ?? "",
        "description": description,
        "start_date": startDate == null
            ? null
            : !formatDate
                ? startDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    startDate!, "yyyy-MM-dd HH:mm:ss"),
        "end_date": endDate == null
            ? null
            : !formatDate
                ? endDate?.toIso8601String()
                : CalendarUtils.formatCalendar(endDate!, "yyyy-MM-dd HH:mm:ss"),
        "is_full_day_event": isFullDayEvent,
        "recurring_end_date": recurringEndDate == null
            ? null
            : !formatDate
                ? recurringEndDate?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    recurringEndDate!, "yyyy-MM-dd HH:mm:ss"),
        "is_recurring": isRecurring,
        "created_by": createdBy,
        "has_reminder": hasReminder,
        "location": location,
        "guests": guests == null ? null : jsonEncode(guests),
        //   List<dynamic>.from(guests.map((x) => x)),
        "rsvp": rsvp,
        "note": note,
        "event_permission":
            eventPermission == null ? null : jsonEncode(eventPermission),
        //  List<dynamic>.from(eventPermission.map((x) => x)),
        "visibility": visibility,
        "privacy": privacy,
        "status": status,
        "duration": duration ?? -1,
        "gh": gh ?? 0,
        "important_event": imp ?? 0,
        "rrule": rrule,
        "deleted_at": deletedAt,
        "created_at": createdAt == null
            ? null
            : !formatDate
                ? createdAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    createdAt!, "yyyy-MM-dd HH:mm:ss"),
        "updated_at": updatedAt == null
            ? null
            : !formatDate
                ? updatedAt?.toIso8601String()
                : CalendarUtils.formatCalendar(
                    updatedAt!, "yyyy-MM-dd HH:mm:ss"),
        "calendar_id": calendar_id == null ? null : calendar_id.toString(),
        "based_on": basedOn,
        "rsvp_stats": rsvpStats == null ? null : jsonEncode(rsvpStats),
        "formatted_rrule":
            formattedRrule == null ? null : jsonEncode(formattedRrule),
        "rsstart": rsstart == null ? null : rsstart?.toIso8601String(),
        "origid": origid ?? -1,
      };

  @override
  List<Object?> get props => [
        id,
        parentEventId,
        title,
        description,
        startDate,
        endDate,
        isFullDayEvent,
        recurringEndDate,
        isRecurring,
        createdBy,
        hasReminder,
        location,
        guests,
        rsvp,
        note,
        eventPermission,
        visibility,
        privacy,
        status,
        duration,
        gh,
        imp,
        rrule,
        deletedAt,
        createdAt,
        updatedAt,
        calendar_id,
        basedOn,
        rsvpStats,
        formattedRrule,
        rsstart,
        origid
      ];
}

class FormattedRrule {
  String? humanReadable;
  String? recurringType;
  int? recurringInterval;

  FormattedRrule({
    this.humanReadable,
    this.recurringType,
    this.recurringInterval,
  });

  factory FormattedRrule.fromJson(Map<String, dynamic> json) {
    // try {
    return FormattedRrule(
      humanReadable: json["human_readable"],
      recurringType: json["recurring_type"],
      recurringInterval: json["recurring_interval"],
    );
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  Map<String, dynamic> toJson() => {
        "human_readable": humanReadable,
        "recurring_type": recurringType,
        "recurring_interval": recurringInterval,
      };
}

class RsvpStats {
  int? totalGoing;
  int? totalNotGoing;
  int? totalMaybe;
  int? totalAwaiting;
  List<Guest>? guests;

  RsvpStats({
    this.totalGoing,
    this.totalNotGoing,
    this.totalMaybe,
    this.totalAwaiting,
    this.guests,
  });

  factory RsvpStats.fromJson(Map<String, dynamic> json) => RsvpStats(
        totalGoing: json["total_going"],
        totalNotGoing: json["total_not_going"],
        totalMaybe: json["total_maybe"],
        totalAwaiting: json["total_awaiting"],
        guests: json["guests"] == null
            ? null
            : List<Guest>.from(json["guests"].map((x) => Guest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_going": totalGoing,
        "total_not_going": totalNotGoing,
        "total_maybe": totalMaybe,
        "total_awaiting": totalAwaiting,
        "guests": guests == null
            ? null
            : List<dynamic>.from(guests!.map((x) => x.toJson())),
      };
}

class Guest {
  String? mail;
  dynamic rsvpStatus;

  Guest({
    this.mail,
    this.rsvpStatus,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        mail: json["mail"],
        rsvpStatus: json["rsvp_status"],
      );

  Map<String, dynamic> toJson() => {
        "mail": mail,
        "rsvp_status": rsvpStatus,
      };
}
