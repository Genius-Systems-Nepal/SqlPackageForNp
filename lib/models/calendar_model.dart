// ignore_for_file: prefer_null_aware_operators, non_constant_identifier_names, constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:nepali_patro_sql_package/utils/calendarutils.dart';

CalendarModel calendarModelFromJson(String str) =>
    CalendarModel.fromJson(json.decode(str));

String calendarModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
  String? status;
  Data? data;

  CalendarModel({
    this.status,
    this.data,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  List<Calendar>? calendars;
  Events? events;

  Data({
    this.calendars,
    this.events,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        calendars: json["calendars"] == null
            ? null
            : List<Calendar>.from(
                json["calendars"].map((x) => Calendar.fromJson(x))),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
      );

  Map<String, dynamic> toJson() => {
        "calendars": calendars == null
            ? null
            : List<dynamic>.from(calendars!.map((x) => x.toJson())),
        "events": events == null ? null : events?.toJson(),
      };
}

class Calendar extends Equatable {
  String? id;
  String? calendar_id;
  String? name;
  int? status;
  int? isDefault;
  String? createdBy;
  int? isModifiable;
  String? color;
  DateTime? created_at;
  DateTime? updated_at;
  int? priority;
  int? display;

  Calendar(
      {this.id,
      this.calendar_id,
      this.name,
      this.createdBy,
      this.isDefault,
      this.status,
      this.isModifiable,
      this.color,
      this.created_at,
      this.updated_at,
      this.priority,
      this.display});

  factory Calendar.fromJson(Map<String, dynamic> json) {
    // try {
    return Calendar(
        id: json["id"] == null ? null : json["id"].toString(),
        calendar_id:
            json["calendar_id"] == null ? null : json["calendar_id"].toString(),
        name: json["name"],
        createdBy: json["created_by"],
        status: json["status"],
        isModifiable: json["is_modifiable"],
        color: json["color"],
        isDefault: json["is_default"],
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]
                .toString()
                .replaceAll("Z", "")
                .replaceAll("T", " ")),
        priority: json["priority"],
        display: json["display"]);
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  factory Calendar.fromEncryptedJson(Map<String, dynamic> json) {
    // try {
    return Calendar(
        id: json["id"] == null ? null : json["id"].toString(),
        calendar_id: json["cid"] == null ? null : json["cid"].toString(),
        name: json["nm"],
        createdBy: json["cb"],
        status: json["st"],
        isModifiable: json["im"],
        color: json["col"],
        isDefault: json["isd"],
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["ut"] == null
            ? null
            : CalendarUtils.getCalendarFromStringFormat(
                json["ut"], "yyyyMMddHHmmss"),
        priority: json["pr"],
        display: json["dis"]);
    // } catch (e) {
    //   Utils.debugLog(e);
    // }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "calendar_id": calendar_id,
        "name": name,
        "status": status ?? "1",
        "created_by": createdBy,
        "is_default": isDefault,
        "is_modifiable": isModifiable,
        "color": color,
        "created_at": created_at == null ? null : created_at?.toIso8601String(),
        "updated_at": updated_at == null ? null : updated_at?.toIso8601String(),
        "priority": priority,
        "display": display,
      };

  Map<String, dynamic> toNormalDateJson() => {
        "id": id,
        "name": name,
        "calendar_id": calendar_id,
        "status": status,
        "created_by": createdBy,
        "is_modifiable": isModifiable,
        "color": color,
        "created_at": created_at == null
            ? null
            : CalendarUtils.formatCalendar(created_at!, "yyyy-MM-dd HH:mm:ss"),
        "updated_at": updated_at == null
            ? null
            : CalendarUtils.formatCalendar(updated_at!, "yyyy-MM-dd HH:mm:ss"),
        "priority": priority,
        "display": display
      };

  @override
  List<Object?> get props => [
        id,
        name,
        calendar_id,
        status,
        createdBy,
        isModifiable,
        color,
        created_at,
        updated_at,
        priority,
        display
      ];
}

class Events {
  Map<String, List<The2019>>? the2019;

  Events({
    this.the2019,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        the2019: json["2019"] == null
            ? null
            : Map.from(json["2019"]).map((k, v) =>
                MapEntry<String, List<The2019>>(
                    k, List<The2019>.from(v.map((x) => The2019.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "2019": the2019 == null
            ? null
            : Map.from(the2019!).map((k, v) => MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class The2019 {
  int? year;
  int? quarter;
  int? month;
  int? week;
  int? weekDay;
  bool? isToday;
  int? day;
  List<Event>? events;
  BsDate? bsDate;

  The2019({
    this.year,
    this.quarter,
    this.month,
    this.week,
    this.weekDay,
    this.isToday,
    this.day,
    this.events,
    this.bsDate,
  });

  factory The2019.fromJson(Map<String, dynamic> json) => The2019(
        year: json["year"],
        quarter: json["quarter"],
        month: json["month"],
        week: json["week"],
        weekDay: json["week_day"],
        isToday: json["is_today"],
        day: json["day"],
        events: json["events"] == null
            ? null
            : List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        bsDate:
            json["BS_date"] == null ? null : BsDate.fromJson(json["BS_date"]),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "quarter": quarter,
        "month": month,
        "week": week,
        "week_day": weekDay,
        "is_today": isToday,
        "day": day,
        "events": events == null
            ? null
            : List<dynamic>.from(events!.map((x) => x.toJson())),
        "BS_date": bsDate == null ? null : bsDate?.toJson(),
      };
}

class BsDate {
  DateTime? ad;
  String? bs;
  int? bsDay;
  int? bsYear;
  String? bsMonth;
  int? tithi;
  int? nsMonth;
  int? nsYear;
  int? chandrama;

  BsDate({
    this.ad,
    this.bs,
    this.bsDay,
    this.bsYear,
    this.bsMonth,
    this.tithi,
    this.nsMonth,
    this.nsYear,
    this.chandrama,
  });

  factory BsDate.fromJson(Map<String, dynamic> json) => BsDate(
        ad: json["ad"] == null ? null : DateTime.parse(json["ad"]),
        bs: json["bs"],
        bsDay: json["bs_day"],
        bsYear: json["bs_year"],
        bsMonth: json["bs_month"],
        tithi: json["tithi"],
        nsMonth: json["ns_month"],
        nsYear: json["ns_year"],
        chandrama: json["chandrama"],
      );

  Map<String, dynamic> toJson() => {
        "ad": ad == null
            ? null
            : "${ad!.year.toString().padLeft(4, '0')}-${ad!.month.toString().padLeft(2, '0')}-${ad?.day.toString().padLeft(2, '0')}",
        "bs": bs,
        "bs_day": bsDay,
        "bs_year": bsYear,
        "bs_month": bsMonth,
        "tithi": tithi,
        "ns_month": nsMonth,
        "ns_year": nsYear,
        "chandrama": chandrama,
      };
}

class Event {
  dynamic id;
  int? parentEventId;
  String? title;
  Description? description;
  DateTime? startDate;
  DateTime? endDate;
  int? isFullDayEvent;
  DateTime? recurringEndDate;
  int? isRecurring;
  CreatedBy? createdBy;
  int? hasReminder;
  String? location;
  List<dynamic>? guests;
  dynamic rsvp;
  String? note;
  List<EventPermission>? eventPermission;
  Visibility? visibility;
  Privacy? privacy;
  int? status;
  int? duration;
  String? rrule;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userCalendarId;
  BasedOn? basedOn;
  RsvpStats? rsvpStats;
  dynamic formattedRrule;
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
    this.rrule,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userCalendarId,
    this.basedOn,
    this.rsvpStats,
    this.formattedRrule,
    this.rsstart,
    this.origid,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        parentEventId: json["parent_event_id"],
        title: json["title"],
        description: json["description"] == null
            ? null
            : descriptionValues.map![json["description"]],
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
        createdBy: json["created_by"] == null
            ? null
            : createdByValues.map![json["created_by"]],
        hasReminder: json["has_reminder"],
        location: json["location"],
        guests: json["guests"] == null
            ? null
            : List<dynamic>.from(json["guests"].map((x) => x)),
        rsvp: json["rsvp"],
        note: json["note"],
        eventPermission: json["event_permission"] == null
            ? null
            : List<EventPermission>.from(json["event_permission"]
                .map((x) => eventPermissionValues.map![x])),
        visibility: json["visibility"] == null
            ? null
            : visibilityValues.map![json["visibility"]],
        privacy: json["privacy"] == null
            ? null
            : privacyValues.map![json["privacy"]],
        status: json["status"],
        duration: json["duration"],
        rrule: json["rrule"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]
                .toString()
                .replaceAll("Z", "")
                .replaceAll("T", " ")),
        userCalendarId: json["user_calendar_id"],
        basedOn: json["based_on"] == null
            ? null
            : basedOnValues.map![json["based_on"]],
        rsvpStats: json["rsvp_stats"] == null
            ? null
            : RsvpStats.fromJson(json["rsvp_stats"]),
        formattedRrule: json["formatted_rrule"],
        rsstart:
            json["rsstart"] == null ? null : DateTime.parse(json["rsstart"]),
        origid: json["origid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_event_id": parentEventId,
        "title": title,
        "description": description == null
            ? null
            : descriptionValues.reverse![description],
        "start_date": startDate == null ? null : startDate?.toIso8601String(),
        "end_date": endDate == null ? null : endDate?.toIso8601String(),
        "is_full_day_event": isFullDayEvent,
        "recurring_end_date": recurringEndDate == null
            ? null
            : recurringEndDate?.toIso8601String(),
        "is_recurring": isRecurring,
        "created_by":
            createdBy == null ? null : createdByValues.reverse![createdBy],
        "has_reminder": hasReminder,
        "location": location,
        "guests":
            guests == null ? null : List<dynamic>.from(guests!.map((x) => x)),
        "rsvp": rsvp,
        "note": note,
        "event_permission": eventPermission == null
            ? null
            : List<dynamic>.from(
                eventPermission!.map((x) => eventPermissionValues.reverse![x])),
        "visibility":
            visibility == null ? null : visibilityValues.reverse![visibility],
        "privacy": privacy == null ? null : privacyValues.reverse![privacy],
        "status": status,
        "duration": duration,
        "rrule": rrule,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "user_calendar_id": userCalendarId,
        "based_on": basedOn == null ? null : basedOnValues.reverse![basedOn],
        "rsvp_stats": rsvpStats == null ? null : rsvpStats?.toJson(),
        "formatted_rrule": formattedRrule,
        "rsstart": rsstart == null ? null : rsstart?.toIso8601String(),
        "origid": origid,
      };
}

enum BasedOn { AD, BS }

final basedOnValues = EnumValues({"AD": BasedOn.AD, "BS": BasedOn.BS});

enum CreatedBy { S_GMAIL_COM }

final createdByValues = EnumValues({"s@gmail.com": CreatedBy.S_GMAIL_COM});

enum Description { EMPTY }

final descriptionValues = EnumValues({" ": Description.EMPTY});

enum EventPermission { ALL }

final eventPermissionValues = EnumValues({"all": EventPermission.ALL});

class FormattedRruleClass {
  String? humanReadable;
  RecurringType? recurringType;
  int? recurringInterval;
  int? recurringCount;
  RecurringByUntil? recurringByUntil;
  List<int>? recurringByDay;
  String? recurringByMonthDay;
  String? recurringByMonth;

  FormattedRruleClass({
    this.humanReadable,
    this.recurringType,
    this.recurringInterval,
    this.recurringCount,
    this.recurringByUntil,
    this.recurringByDay,
    this.recurringByMonthDay,
    this.recurringByMonth,
  });

  factory FormattedRruleClass.fromJson(Map<String, dynamic> json) =>
      FormattedRruleClass(
        humanReadable: json["human_readable"],
        recurringType: json["recurring_type"] == null
            ? null
            : recurringTypeValues.map![json["recurring_type"]],
        recurringInterval: json["recurring_interval"],
        recurringCount: json["recurring_count"],
        recurringByUntil: json["recurring_by_until"] == null
            ? null
            : RecurringByUntil.fromJson(json["recurring_by_until"]),
        recurringByDay: json["recurring_by_day"] == null
            ? null
            : List<int>.from(json["recurring_by_day"].map((x) => x)),
        recurringByMonthDay: json["recurring_by_month_day"],
        recurringByMonth: json["recurring_by_month"],
      );

  Map<String, dynamic> toJson() => {
        "human_readable": humanReadable,
        "recurring_type": recurringType == null
            ? null
            : recurringTypeValues.reverse![recurringType],
        "recurring_interval": recurringInterval,
        "recurring_count": recurringCount,
        "recurring_by_until":
            recurringByUntil == null ? null : recurringByUntil!.toJson(),
        "recurring_by_day": recurringByDay == null
            ? null
            : List<dynamic>.from(recurringByDay!.map((x) => x)),
        "recurring_by_month_day": recurringByMonthDay,
        "recurring_by_month": recurringByMonth,
      };
}

class RecurringByUntil {
  DateTime? date;
  int? timezoneType;
  String? timezone;

  RecurringByUntil({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory RecurringByUntil.fromJson(Map<String, dynamic> json) =>
      RecurringByUntil(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date?.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

enum RecurringType { DAILY, WEEKLY, MONTHLY, YEARLY }

final recurringTypeValues = EnumValues({
  "daily": RecurringType.DAILY,
  "monthly": RecurringType.MONTHLY,
  "weekly": RecurringType.WEEKLY,
  "yearly": RecurringType.YEARLY
});

enum Privacy { PUBLIC }

final privacyValues = EnumValues({"public": Privacy.PUBLIC});

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
  CreatedBy? mail;
  dynamic rsvpStatus;

  Guest({
    this.mail,
    this.rsvpStatus,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        mail: json["mail"] == null ? null : createdByValues.map![json["mail"]],
        rsvpStatus: json["rsvp_status"],
      );

  Map<String, dynamic> toJson() => {
        "mail": mail == null ? null : createdByValues.reverse![mail],
        "rsvp_status": rsvpStatus,
      };
}

enum Visibility { FREE }

final visibilityValues = EnumValues({"free": Visibility.FREE});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
