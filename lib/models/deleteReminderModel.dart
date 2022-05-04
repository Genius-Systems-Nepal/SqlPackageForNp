// To parse this JSON data, do
//
//     final deleteReminderModel = deleteReminderModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, file_names, must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

DeleteReminderModel deleteReminderModelFromJson(String str) =>
    DeleteReminderModel.fromJson(json.decode(str));

String deleteReminderModelToJson(DeleteReminderModel data) =>
    json.encode(data.toJson());

class DeleteReminderModel extends Equatable {
  int? id;
  String? reminderId;
  String? eventId;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeleteReminderModel({
    this.id,
    this.reminderId,
    this.eventId,
    this.createdAt,
    this.updatedAt,
  });

  factory DeleteReminderModel.fromJson(Map<String, dynamic> json) =>
      DeleteReminderModel(
        id: json["id"],
        reminderId: json["reminder_id"],
        eventId: json["event_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reminder_id": reminderId,
        "event_id": eventId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, reminderId, eventId, createdAt, updatedAt];
}
