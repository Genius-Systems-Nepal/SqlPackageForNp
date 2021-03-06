// ignore_for_file: non_constant_identifier_names, prefer_null_aware_operators, must_be_immutable

import 'dart:convert';
import 'package:equatable/equatable.dart';

AMessageOption aMessageOptionFromJson(String str) =>
    AMessageOption.fromJson(json.decode(str));

String aMessageOptionToJson(AMessageOption data) => json.encode(data.toJson());

class AMessageOption extends Equatable {
  Title? title;
  Title? subtitle;
  String? thumbnail;
  String? footer_action_text;
  String? image;

  AMessageOption(
      {this.title,
      this.subtitle,
      this.thumbnail,
      this.footer_action_text,
      this.image});

  factory AMessageOption.fromJson(Map<String, dynamic> json) => AMessageOption(
      title: json["title"] == null ? null : Title.fromJson(json["title"]),
      subtitle:
          json["subtitle"] == null ? null : Title.fromJson(json["subtitle"]),
      thumbnail: json["thumbnail"],
      footer_action_text: json["footer_action_text"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title?.toJson(),
        "subtitle": subtitle == null ? null : subtitle?.toJson(),
        "thumbnail": thumbnail,
        "footer_action_text": footer_action_text,
        "image": image
      };
  @override
  List<Object?> get props =>
      [title, subtitle, thumbnail, footer_action_text, image];
}

class Title extends Equatable {
  String? en;
  String? np;

  Title({
    this.en,
    this.np,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"],
        np: json["np"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "np": np,
      };

  @override
  List<Object?> get props => [en, np];
}
