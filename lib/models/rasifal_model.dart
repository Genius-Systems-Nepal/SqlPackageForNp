// To parse this JSON data, do
//
//     final rashifalModel = rashifalModelFromJson(jsonString);

import 'dart:convert';

RashifalModel rashifalModelFromJson(String str) =>
    RashifalModel.fromJson(json.decode(str));

String rashifalModelToJson(RashifalModel data) => json.encode(data.toJson());

class RashifalModel {
  RashifalModel({
    required this.type,
    required this.title,
    required this.author,
    required this.lang,
    this.aries,
    this.taurus,
    this.gemini,
    this.cancer,
    this.leo,
    this.virgo,
    this.libra,
    this.scopio,
    this.sagittarius,
    this.capricorn,
    this.aquarius,
    this.pisces,
    this.todate,
  });

  String type;
  String title;
  String author;
  String lang;
  String? aries;
  String? taurus;
  String? gemini;
  String? cancer;
  String? leo;
  String? virgo;
  String? libra;
  String? scopio;
  String? sagittarius;
  String? capricorn;
  String? aquarius;
  String? pisces;
  String? todate;

  factory RashifalModel.fromJson(Map<String, dynamic> json) => RashifalModel(
        type: json["type"],
        title: json["title"],
        author: json["author"],
        lang: json["lang"],
        aries: json["aries"],
        taurus: json["taurus"],
        gemini: json["gemini"],
        cancer: json["cancer"],
        leo: json["leo"],
        virgo: json["virgo"],
        libra: json["libra"],
        scopio: json["scopio"],
        sagittarius: json["sagittarius"],
        capricorn: json["capricorn"],
        aquarius: json["aquarius"],
        pisces: json["pisces"],
        todate: json["todate"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "author": author,
        "lang": lang,
        "aries": aries,
        "taurus": taurus,
        "gemini": gemini,
        "cancer": cancer,
        "leo": leo,
        "virgo": virgo,
        "libra": libra,
        "scopio": scopio,
        "sagittarius": sagittarius,
        "capricorn": capricorn,
        "aquarius": aquarius,
        "pisces": pisces,
        "todate": todate,
      };
}
