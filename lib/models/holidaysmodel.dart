// To parse this JSON data, do
//
//     final holidaysModel = holidaysModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<HolidaysModel> holidaysModelFromJson(List<Map<String, dynamic>> data) =>
    data.map((c) => HolidaysModel.fromJsonView(c)).toList();

//List<HolidaysModel> holidaysModelFromJson(String str) => List<HolidaysModel>.from(json.decode(str).map((x) => HolidaysModel.fromJson(x)));

String holidaysModelToJson(List<HolidaysModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HolidaysModel extends Equatable {
  int? id;
  String? eventId;
  DateTime? eventDate;
  String? holidayType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  HolidaysModel({
    this.id,
    this.eventId,
    this.eventDate,
    this.holidayType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory HolidaysModel.fromJson(Map<String, dynamic> json) => HolidaysModel(
        id: json["id"],
        eventId: json["event_id"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        holidayType: json["holiday_type"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  factory HolidaysModel.fromJsonView(Map<String, dynamic> json) =>
      HolidaysModel(
        id: json["id"],
        eventId: json["eventId"],
        eventDate: json["eventDate"] == null
            ? null
            : DateTime.parse(json["eventDate"]),
        holidayType: json["holidayType"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "event_date": eventDate == null
            ? null
            : "${eventDate?.year.toString().padLeft(4, '0')}-${eventDate?.month.toString().padLeft(2, '0')}-${eventDate?.day.toString().padLeft(2, '0')}",
        "holiday_type": holidayType,
        "status": status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };

  @override
  List<Object?> get props => [
        id,
        eventId,
        eventDate,
        holidayType,
        status,
        createdAt,
        updatedAt,
        deletedAt
      ];
}

class HolidaysList extends Equatable {
  List<HolidaysModel>? holidaysList;

  HolidaysList({
    this.holidaysList,
  });

  factory HolidaysList.fromJson(List<dynamic> parsedJson) {
    List<HolidaysModel> holidays = <HolidaysModel>[];
    holidays = parsedJson.map((i) => HolidaysModel.fromJson(i)).toList();

    return HolidaysList(holidaysList: holidays);
  }

  @override
  List<Object?> get props => [holidaysList];
}
