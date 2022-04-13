// To parse this JSON data, do
//
//     final eventDescriptionModel = eventDescriptionModelFromJson(jsonString);

import 'dart:convert';

EventDescriptionModel eventDescriptionModelFromJson(String str) =>
    EventDescriptionModel.fromJson(json.decode(str));
EventDescriptionModel eventDescriptionModelEncrypteFromJson(String str) =>
    EventDescriptionModel.fromEncryptedJson(json.decode(str));

String eventDescriptionModelToJson(EventDescriptionModel data) =>
    json.encode(data.toJson());

class EventDescriptionModel {
  String? npId;
  String? category;
  String? en;
  String? ne;
  String? imageUrl;
  String? imageSmallUrl;
  String? blogId;
  String? blogDescription;
  String? gh;
  String? importantEvent;

  EventDescriptionModel({
    this.npId,
    this.category,
    this.en,
    this.ne,
    this.imageUrl,
    this.imageSmallUrl,
    this.blogId,
    this.blogDescription,
    this.gh,
    this.importantEvent,
  });

  factory EventDescriptionModel.fromJson(Map<String, dynamic> json) =>
      EventDescriptionModel(
        npId: json["jnid"] == null ? null : json["jnid"],
        category: json["jct"] == null ? null : json["jct"],
        en: json["en"] == null ? null : json["en"],
        ne: json["ne"] == null ? null : json["ne"],
        imageUrl: json["jiu"] == null ? null : json["jiu"],
        imageSmallUrl: json["jis"] == null ? null : json["jis"],
        blogId: json["jbi"] == null ? null : json["jbi"],
        blogDescription: json["jbd"] == null ? null : json["jbd"],
        gh: json["gh"] == null ? null : json["gh"],
        importantEvent: json["jie"] == null ? null : json["jie"],
      );

  factory EventDescriptionModel.fromEncryptedJson(Map<String, dynamic> json) =>
      EventDescriptionModel(
        npId: json["np_id"] == null ? null : json["np_id"],
        category: json["category"] == null ? null : json["category"],
        en: json["en"] == null ? null : json["en"],
        ne: json["ne"] == null ? null : json["ne"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        imageSmallUrl:
            json["image_small_url"] == null ? null : json["image_small_url"],
        blogId: json["blog_id"] == null ? null : json["blog_id"],
        blogDescription:
            json["blog_description"] == null ? null : json["blog_description"],
        gh: json["gh"] == null ? null : json["gh"],
        importantEvent:
            json["important_event"] == null ? null : json["important_event"],
      );

  Map<String, dynamic> toJson() => {
        "np_id": npId == null ? null : npId,
        "category": category == null ? null : category,
        "en": en == null ? null : en,
        "ne": ne == null ? null : ne,
        "image_url": imageUrl == null ? null : imageUrl,
        "image_small_url": imageSmallUrl == null ? null : imageSmallUrl,
        "blog_id": blogId == null ? null : blogId,
        "blog_description": blogDescription == null ? null : blogDescription,
        "gh": gh == null ? null : gh,
        "important_event": importantEvent == null ? null : importantEvent,
      };
}
