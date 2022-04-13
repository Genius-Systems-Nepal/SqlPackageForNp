// To parse this JSON data, do
//
//     final rashifalModel = rashifalModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

RashifalModel rashifalModelFromJson(Map<String, dynamic> body) =>
    RashifalModel.fromJson(body);

String rashifalModelToJson(RashifalModel data) => json.encode(data.toJson());

class RashifalModel {
  String? copyright;
  List<Np>? np;

  RashifalModel({
    this.copyright,
    this.np,
  });

  factory RashifalModel.fromJson(Map<String, dynamic> json) => RashifalModel(
        copyright: json["copyright"] == null ? null : json["copyright"],
        np: json["np"] == null
            ? null
            : List<Np>.from(json["np"].map((x) => Np.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "copyright": copyright == null ? null : copyright,
        "np":
            np == null ? null : List<dynamic>.from(np!.map((x) => x.toJson())),
      };
}

class Np extends Equatable {
  String? type;
  String? title;
  String? author;
  String? lang;
  String? aries;
  String? taurus;
  String? gemini;
  String? cancer;
  String? leo;
  String? virgo;
  String? libra;
  String? scorpio;
  String? sagittarius;
  String? capricorn;
  String? aquarius;
  String? pisces;
  DateTime? todate;

  Np({
    this.type,
    this.title,
    this.author,
    this.lang,
    this.aries,
    this.taurus,
    this.gemini,
    this.cancer,
    this.leo,
    this.virgo,
    this.libra,
    this.scorpio,
    this.sagittarius,
    this.capricorn,
    this.aquarius,
    this.pisces,
    this.todate,
  });

  // ignore: unnecessary_new
  factory Np.fromJson(Map<String, dynamic> json) => new Np(
        type: json["type"] == null ? null : json["type"],
        title: json["title"] == null ? null : json["title"],
        author: json["author"] == null ? null : json["author"],
        lang: json["lang"] == null ? null : json["lang"],
        aries: json["aries"] == null ? null : json["aries"],
        taurus: json["taurus"] == null ? null : json["taurus"],
        gemini: json["gemini"] == null ? null : json["gemini"],
        cancer: json["cancer"] == null ? null : json["cancer"],
        leo: json["leo"] == null ? null : json["leo"],
        virgo: json["virgo"] == null ? null : json["virgo"],
        libra: json["libra"] == null ? null : json["libra"],
        scorpio: json["scorpio"] == null ? null : json["scorpio"],
        sagittarius: json["sagittarius"] == null ? null : json["sagittarius"],
        capricorn: json["capricorn"] == null ? null : json["capricorn"],
        aquarius: json["aquarius"] == null ? null : json["aquarius"],
        pisces: json["pisces"] == null ? null : json["pisces"],
        todate: json["todate"] == null ? null : DateTime.parse(json["todate"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "title": title == null ? null : title,
        "author": author == null ? null : author,
        "lang": lang == null ? null : lang,
        "aries": aries == null ? null : aries,
        "taurus": taurus == null ? null : taurus,
        "gemini": gemini == null ? null : gemini,
        "cancer": cancer == null ? null : cancer,
        "leo": leo == null ? null : leo,
        "virgo": virgo == null ? null : virgo,
        "libra": libra == null ? null : libra,
        "scorpio": scorpio == null ? null : scorpio,
        "sagittarius": sagittarius == null ? null : sagittarius,
        "capricorn": capricorn == null ? null : capricorn,
        "aquarius": aquarius == null ? null : aquarius,
        "pisces": pisces == null ? null : pisces,
        "todate": todate == null
            ? null
            : "${todate?.year.toString().padLeft(4, '0')}-${todate?.month.toString().padLeft(2, '0')}-${todate?.day.toString().padLeft(2, '0')}",
      };
  @override
  // TODO: implement props
  List<Object?> get props => [
        type,
        title,
        author,
        lang,
        aries,
        taurus,
        gemini,
        cancer,
        leo,
        virgo,
        libra,
        scorpio,
        sagittarius,
        capricorn,
        aquarius,
        pisces,
        todate
      ];
}
