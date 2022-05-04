// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:equatable/equatable.dart';

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
        copyright: json["copyright"],
        np: json["np"] == null
            ? null
            : List<Np>.from(json["np"].map((x) => Np.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "copyright": copyright,
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

  factory Np.fromJson(Map<String, dynamic> json) => Np(
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
        scorpio: json["scorpio"],
        sagittarius: json["sagittarius"],
        capricorn: json["capricorn"],
        aquarius: json["aquarius"],
        pisces: json["pisces"],
        todate: json["todate"] == null ? null : DateTime.parse(json["todate"]),
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
        "scorpio": scorpio,
        "sagittarius": sagittarius,
        "capricorn": capricorn,
        "aquarius": aquarius,
        "pisces": pisces,
        "todate": todate == null
            ? null
            : "${todate?.year.toString().padLeft(4, '0')}-${todate?.month.toString().padLeft(2, '0')}-${todate?.day.toString().padLeft(2, '0')}",
      };
  @override
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
