// To parse this JSON data, do
//
//     final deletedEvents = deletedEventsFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, must_be_immutable, file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

DeletedEvents deletedEventsFromJson(String str) =>
    DeletedEvents.fromJson(json.decode(str));

String deletedEventsToJson(DeletedEvents data) => json.encode(data.toJson());

class DeletedEvents extends Equatable {
  int? id;
  String? eventId;
  String? calendarId;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeletedEvents({
    this.id,
    this.eventId,
    this.calendarId,
    this.createdAt,
    this.updatedAt,
  });

  factory DeletedEvents.fromJson(Map<String, dynamic> json) => DeletedEvents(
        id: json["id"],
        eventId: json["event_id"],
        calendarId: json["calendar_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "calendar_id": calendarId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, eventId, calendarId, createdAt, updatedAt];
}
