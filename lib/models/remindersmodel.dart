// To parse this JSON data, do
//
//     final remindersModel = remindersModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

RemindersModel remindersModelFromJson(String str) =>
    RemindersModel.fromJson(json.decode(str));

String remindersModelToJson(RemindersModel data) => json.encode(data.toJson());

class RemindersModel extends Equatable {
  String? id;
  String? eventId;
  int? days;
  String? time;
  String? note;
  String? notificationType;
  DateTime? updatedAt;
  DateTime? createdAt;

  RemindersModel({
    this.id,
    this.eventId,
    this.days,
    this.time,
    this.note,
    this.notificationType,
    this.updatedAt,
    this.createdAt,
  });

  factory RemindersModel.fromJson(Map<String, dynamic> json) {
    var reminderModel = RemindersModel(
      id: json["id"] == null ? null : json["id"].toString(),
      eventId: json["event_id"] == null ? null : json["event_id"],
      days: json["days"] == null ? null : json["days"],
      time: json["time"] == null ? null : json["time"],
      note: json["note"] == null ? null : json["note"],
      notificationType:
          json["notification_type"] == null ? null : json["notification_type"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]
              .toString()
              .replaceAll("Z", "")
              .replaceAll("T", " ")),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
    );

    return reminderModel;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "event_id": eventId == null ? null : eventId,
        "days": days == null ? null : days,
        "time": time == null ? null : time,
        "note": note == null ? null : note,
        "notification_type": notificationType == null ? null : notificationType,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
      };

  @override
  List<Object?> get props =>
      [id, eventId, days, time, note, notificationType, updatedAt, createdAt];
}
