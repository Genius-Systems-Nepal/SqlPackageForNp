// ignore_for_file: prefer_null_aware_operators, must_be_immutable

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:nepali_patro_sql_package/models/amessage_option_model.dart';

AMessage aMessageFromJson(String str) => AMessage.fromJson(json.decode(str));

String aMessageToJson(AMessage data) => json.encode(data.toJson());

class AMessage {
  String? copyright;
  String? refresh;
  String? clear;
  String? refetch;
  List<Content>? content;

  AMessage({
    this.copyright,
    this.refresh,
    this.clear,
    this.refetch,
    this.content,
  });

  factory AMessage.fromJson(Map<String, dynamic> json) => AMessage(
        copyright: json["copyright"],
        refresh: json["refresh"],
        clear: json["clear"],
        refetch: json["refetch"],
        content: json["content"] == null
            ? null
            : List<Content>.from(
                json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "copyright": copyright,
        "refresh": refresh,
        "clear": clear,
        "refetch": refetch,
        "content": content == null
            ? null
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content extends Equatable {
  String? id;
  String? messageNp;
  String? messageEn;
  String? linktype;
  String? link;
  DateTime? stdate;
  String? expiry;
  String? aflag;
  String? pin;
  String? enable;
  AMessageOption? options;
  String? dorder;
  int? cancelled;

  Content(
      {this.id,
      this.messageNp,
      this.messageEn,
      this.linktype,
      this.link,
      this.stdate,
      this.expiry,
      this.aflag,
      this.pin,
      this.enable,
      this.options,
      this.dorder,
      this.cancelled});

  factory Content.fromJson(Map<String, dynamic> data) => Content(
      id: data["id"] == null ? null : data["id"].toString(),
      messageNp: data["message_np"],
      messageEn: data["message_en"],
      linktype: data["linktype"],
      link: data["link"],
      stdate: data["stdate"] == null ? null : DateTime.parse(data["stdate"]),
      expiry: data["expiry"] == null ? null : data["expiry"].toString(),
      aflag: data["aflag"] == null ? null : data["aflag"].toString(),
      pin: data["pin"],
      enable: data["enable"],
      options: data["options"] == null
          ? null
          : AMessageOption.fromJson(json.decode(data["options"])),
      dorder: data["dorder"] == null ? null : data["dorder"].toString(),
      cancelled: data["canclled"] == null ? 0 : data["cancelled"]);

  factory Content.fromDbJson(Map<String, dynamic> data) => Content(
      id: data["id"],
      messageNp: data["message_np"],
      messageEn: data["message_en"],
      linktype: data["linktype"],
      link: data["link"],
      stdate: data["stdate"] == null ? null : DateTime.parse(data["stdate"]),
      expiry: data["expiry"],
      aflag: data["aflag"],
      pin: data["pin"],
      enable: data["enable"],
      options: data["options"] == null
          ? null
          : AMessageOption.fromJson(json.decode(data["options"])),
      dorder: data["dorder"],
      cancelled: data["canclled"] == null ? 0 : data["cancelled"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "message_np": messageNp,
        "message_en": messageEn,
        "linktype": linktype,
        "link": link,
        "stdate": stdate == null ? null : stdate.toString(),
        "expiry": expiry,
        "aflag": aflag,
        "pin": pin,
        "enable": enable,
        "options": options == null ? null : json.encode(options),
        "dorder": dorder,
        "cancelled": cancelled ?? 0
      };

  @override
  List<Object?> get props => [
        id,
        messageNp,
        messageEn,
        linktype,
        link,
        stdate,
        expiry,
        aflag,
        pin,
        enable,
        options,
        dorder,
        cancelled
      ];
}
