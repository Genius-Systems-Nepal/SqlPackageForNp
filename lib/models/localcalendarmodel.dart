// To parse this JSON data, do
//
//     final localCalendarModel = localCalendarModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<LocalCalendarModel> localCalendarModelFromJson(String str) =>
    List<LocalCalendarModel>.from(
        json.decode(str).map((x) => LocalCalendarModel.fromJson(x)));

String localCalendarModelToJson(List<LocalCalendarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocalCalendarModel {
  String? id;
  String? name;
  int? isPublic;
  int? createdBy;
  int? isDefault;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  LocalCalendarModel(
      {this.id,
      this.name,
      this.isPublic,
      this.createdBy,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.status});

  factory LocalCalendarModel.fromJson(Map<String, dynamic> json) =>
      LocalCalendarModel(
        id: json["id"],
        name: json["name"],
        isPublic: json["is_public"],
        createdBy: json["created_by"],
        isDefault: json["is_default"],
        status: json["status"] == null ? null : json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_public": isPublic,
        "created_by": createdBy,
        "is_default": isDefault,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
