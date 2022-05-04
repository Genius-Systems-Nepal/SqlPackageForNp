// ignore_for_file: file_names

import 'dart:convert';

class NsData {
  String? fdt;
  String? tdt;
  String? udt;
  String? b;
  dynamic data;

  NsData({
    this.fdt,
    this.tdt,
    this.udt,
    this.b,
    this.data,
  });

  factory NsData.fromJson(String str) => NsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NsData.fromMap(Map<String, dynamic> json) => NsData(
        fdt: json["fdt"],
        tdt: json["tdt"],
        udt: json["udt"],
        b: json["b"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "fdt": fdt,
        "tdt": tdt,
        "udt": udt,
        "b": b,
        "data": data,
      };
}
