// To parse this JSON data, do
//
//     final forexModel = forexModelFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

ForexModel forexModelFromJson(String str) =>
    ForexModel.fromJson(json.decode(str));

String forexModelToJson(ForexModel data) => json.encode(data.toJson());

class ForexModel extends Equatable {
  String? date;
  String? source;
  String? sourceUrl;
  List<Datum>? data;

  ForexModel({
    this.date,
    this.source,
    this.sourceUrl,
    this.data,
  });

  factory ForexModel.fromJson(Map<String, dynamic> json) => ForexModel(
        date: json["date"],
        source: json["source"],
        sourceUrl: json["source_url"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "source": source,
        "source_url": sourceUrl,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [date, source, sourceUrl, data];
}

class Datum extends Equatable {
  String? type;
  String? code;
  String? currency;
  String? unit;
  String? buying;
  String? selling;

  Datum({
    this.type,
    this.code,
    this.currency,
    this.unit,
    this.buying,
    this.selling,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        code: json["code"],
        currency: json["currency"],
        unit: json["unit"],
        buying: json["buying"],
        selling: json["selling"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "currency": currency,
        "unit": unit,
        "buying": buying,
        "selling": selling,
      };

  @override
  List<Object?> get props => [type, code, currency, unit, buying, selling];
}
