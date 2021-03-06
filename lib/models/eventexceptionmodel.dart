// To parse this JSON data, do
//
//     final eventExceptionModel = eventExceptionModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

EventExceptionModel eventExceptionModelFromJson(String str) =>
    EventExceptionModel.fromJson(json.decode(str));

String eventExceptionModelToJson(EventExceptionModel data) =>
    json.encode(data.toJson());

class EventExceptionModel extends Equatable {
  String? id;
  DateTime? exceptionDate;
  DateTime? newDate;
  String? eventId;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? calendarId;

  EventExceptionModel({
    this.id,
    this.exceptionDate,
    this.newDate,
    this.eventId,
    this.createdDate,
    this.updatedDate,
    this.calendarId,
  });

  factory EventExceptionModel.fromJson(Map<String, dynamic> json) =>
      EventExceptionModel(
        id: json["id"] == null ? null : json["id"].toString(),
        exceptionDate:
            json["ex_date"] == null ? null : DateTime.parse(json["ex_date"]),
        newDate:
            json["new_date"] == null ? null : DateTime.parse(json["new_date"]),
        eventId: json["event_id"],
        createdDate: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedDate: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]
                .toString()
                .replaceAll("Z", "")
                .replaceAll("T", " ")),
        calendarId: json["calendar_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "exception_date":
            exceptionDate == null ? null : exceptionDate?.toIso8601String(),
        "new_date": newDate == null ? null : newDate?.toIso8601String(),
        "event_id": eventId,
        "created_at":
            createdDate == null ? null : createdDate?.toIso8601String(),
        "updated_at":
            updatedDate == null ? null : updatedDate?.toIso8601String(),
        "calendar_id": calendarId,
      };

  @override
  List<Object?> get props => [
        id,
        exceptionDate,
        newDate,
        eventId,
        createdDate,
        updatedDate,
        calendarId
      ];
}
