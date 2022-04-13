// To parse this JSON data, do
//
//     final blogDetail = blogDetailFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

BlogModel blogDetailFromJson(Map<String, dynamic> json) =>
    BlogModel.fromJson(json);

String blogDetailToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel extends Equatable {
  String? status;
  int? count;
  int? countTotal;
  int? pages;
  List<Post>? posts;
  Query? query;

  BlogModel({
    this.status,
    this.count,
    this.countTotal,
    this.pages,
    this.posts,
    this.query,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        status: json["status"],
        count: json["count"],
        countTotal: json["count_total"],
        pages: json["pages"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        query: Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "count_total": countTotal,
        "pages": pages,
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "query": query?.toJson(),
      };
  @override
  bool operator ==(Object other) {
    if (other is BlogModel) {
      return (other.status == status &&
          other.count == count &&
          other.countTotal == countTotal &&
          other.pages == pages &&
          other.posts == posts &&
          other.query == query);
    }
    return false;
  }

  @override
  int get hashCode =>
      hashValues(status, count, countTotal, pages, posts, query);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Post extends Equatable {
  int? id;
  String? type;
  String? slug;
  String? url;
  String? status;
  String? title;
  String? titlePlain;
  String? content;
  String? excerpt;
  String? date;
  String? modified;
  List<Category>? categories;
  List<Category>? tags;
  Author? author;
  List<Comment>? comments;
  List<Attachment>? attachments;
  int? commentCount;
  String? commentStatus;
  String? thumbnail;
  CustomFields? customFields;
  String? thumbnailSize;
  Images? thumbnailImages;
  int? event;

  Post({
    this.id,
    this.type,
    this.slug,
    this.url,
    this.status,
    this.title,
    this.titlePlain,
    this.content,
    this.excerpt,
    this.date,
    this.modified,
    this.categories,
    this.tags,
    this.author,
    this.comments,
    this.attachments,
    this.commentCount,
    this.commentStatus,
    this.thumbnail,
    this.customFields,
    this.thumbnailSize,
    this.thumbnailImages,
    this.event,
  });

  static List<Post> postsFromJson(List<Map<String, dynamic>> results) =>
      results.map((Map model) => Post.fromDbJson(model.cast())).toList();

  factory Post.fromJson(Map<String, dynamic> data) {
    // try {
    return Post(
      id: data["id"],
      type: data["type"],
      slug: data["slug"],
      url: data["url"],
      status: data["status"],
      title: data["title"],
      titlePlain: data["title_plain"],
      content: data["content"],
      excerpt: data["excerpt"] == "" || data["excerpt"] == null
          ? null
          : data["excerpt"],
      date: data["date"],
      modified: data["modified"],
      categories: data["categories"] == "" || data["categories"] == null
          ? null
          : List<Category>.from(
              data["categories"].map((x) => Category.fromJson(x))),
      tags: data["tags"] == "" || data["tags"] == null
          ? null
          : List<Category>.from(data["tags"].map((x) => Category.fromJson(x))),
      author: data["author"] == "" || data["author"] == null
          ? null
          : Author.fromJson(data["author"]),
      comments: data["comments"] == "" || data["comments"] == null
          ? null
          : List<Comment>.from(
              data["comments"].map((x) => Comment.fromJson(x))),
      attachments: data["attachments"] == null
          ? null
          : List<Attachment>.from(
              data["attachments"].map((x) => Attachment.fromJson(x))),
      commentCount: data["comment_count"] ?? 0,
      commentStatus: data["comment_status"],
      thumbnail: data["thumbnail"],
      customFields: data["custom_fields"] == null
          ? null
          : CustomFields.fromJson(data["custom_fields"]),
      thumbnailSize: data["thumbnail_size"],
      thumbnailImages:
          data["thumbnail_images"] == "" || data["thumbnail_images"] == null
              ? null
              : Images.fromJson(data["thumbnail_images"]),
      event: data["event"],
    );
    // } catch (e) {
    // Print(e);
    // }
  }

  factory Post.fromDbJson(Map<String, dynamic> data) {
    // try {
    return Post(
      id: data["id"],
      type: data["type"],
      slug: data["slug"],
      url: data["url"],
      status: data["status"],
      title: data["title"],
      titlePlain: data["title_plain"],
      content: data["content"],
      excerpt: data["excerpt"] == "" || data["excerpt"] == null
          ? null
          : data["excerpt"],
      date: data["date"],
      modified: data["modified"],
      categories: data["categories"] == "" || data["categories"] == null
          ? null
          : List<Category>.from(
              jsonDecode(data["categories"]).map((x) => Category.fromJson(x))),
      tags: data["tags"] == "" || data["tags"] == null
          ? null
          : List<Category>.from(
              jsonDecode(data["tags"]).map((x) => Category.fromJson(x))),
      author: data["author"] == "" || data["author"] == null
          ? null
          : Author.fromJson(json.decode(data["author"])),
      comments: data["comments"] == "" || data["comments"] == null
          ? null
          : List<Comment>.from(
              jsonDecode(data["comments"]).map((x) => Comment.fromJson(x))),
      attachments: data["attachments"] == null
          ? null
          : List<Attachment>.from(
              data["attachments"].map((x) => Attachment.fromJson(x))),
      commentCount: data["comment_count"] == null ? 0 : (data["comment_count"]),
      commentStatus: data["comment_status"],
      thumbnail: data["thumbnail"],
      customFields: data["custom_fields"] == null
          ? null
          : CustomFields.fromJson(data["custom_fields"]),
      thumbnailSize: data["thumbnail_size"],
      thumbnailImages:
          data["thumbnail_images"] == null || data["thumbnail_images"] == "null"
              ? null
              : Images.fromJson(json.decode(data["thumbnail_images"])),
      event: data["event"],
    );
    // } catch (e) {
    //   print(e);
    // }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "slug": slug,
        "url": url,
        "status": status,
        "title": title,
        "title_plain": titlePlain,
        "content": content,
        "excerpt": excerpt,
        "date": date,
        "modified": modified,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
        "author": author?.toJson(),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "comment_count": commentCount,
        "comment_status": commentStatus,
        "thumbnail": thumbnail,
        "custom_fields": customFields?.toJson(),
        "thumbnail_size": thumbnailSize,
        "thumbnail_images": thumbnailImages?.toJson(),
        "event": event,
      };
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        type,
        slug,
        url,
        status,
        title,
        titlePlain,
        content,
        excerpt,
        date,
        modified,
        categories,
        tags,
        author,
        comments,
        attachments,
        commentCount,
        commentStatus,
        thumbnail,
        customFields,
        thumbnailSize,
        thumbnailImages,
        event
      ];
}

class Attachment extends Equatable {
  int? id;
  String? url;
  String? slug;
  String? title;
  String? description;
  String? caption;
  int? parent;
  String? mimeType;
  Images? images;

  Attachment({
    this.id,
    this.url,
    this.slug,
    this.title,
    this.description,
    this.caption,
    this.parent,
    this.mimeType,
    this.images,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        caption: json["caption"],
        parent: json["parent"],
        mimeType: json["mime_type"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "slug": slug,
        "title": title,
        "description": description,
        "caption": caption,
        "parent": parent,
        "mime_type": mimeType,
        "images": images?.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, url, slug, title, description, caption, parent, mimeType, images];
}

class Images extends Equatable {
  Full? full;
  Full? thumbnail;
  Full? medium;
  Full? mediumLarge;
  Full? large;
  Full? postThumbnail;

  Images({
    this.full,
    this.thumbnail,
    this.medium,
    this.mediumLarge,
    this.large,
    this.postThumbnail,
  });

  factory Images.fromJson(Map<String, dynamic> data) => Images(
        full: Full.fromJson(data["full"]),
        thumbnail: Full.fromJson(data["thumbnail"]),
        medium: Full.fromJson(data["medium"]),
        mediumLarge: Full.fromJson(data["medium_large"]),
        large: Full.fromJson(data["large"]),
        postThumbnail: Full.fromJson(data["post-thumbnail"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "full": full?.toJson(),
        "thumbnail": thumbnail?.toJson(),
        "medium": medium?.toJson(),
        "medium_large": mediumLarge?.toJson(),
        "large": large?.toJson(),
        "post-thumbnail": postThumbnail?.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [full, thumbnail, medium, mediumLarge, large, postThumbnail];
}

class Full extends Equatable {
  String? url;
  int? width;
  int? height;

  Full({
    this.url,
    this.width,
    this.height,
  });

  factory Full.fromJson(Map<String, dynamic>? json) => Full(
        url: json?["url"],
        width: json?["width"],
        height: json?["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
  @override
  bool operator ==(Object other) {
    if (other is Full) {
      return (other.url == url &&
          other.width == width &&
          other.height == height);
    }
    return false;
  }

  @override
  int get hashCode => hashValues(url, width, height);

  @override
  // TODO: implement props
  List<Object?> get props => [url, width, height];
}

class Author extends Equatable {
  int? id;
  String? slug;
  String? name;
  String? firstName;
  String? lastName;
  String? nickname;
  String? url;
  String? description;

  Author({
    this.id,
    this.slug,
    this.name,
    this.firstName,
    this.lastName,
    this.nickname,
    this.url,
    this.description,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nickname: json["nickname"],
        url: json["url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "nickname": nickname,
        "url": url,
        "description": description,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, slug, name, firstName, lastName, nickname, url, description];
}

class Category extends Equatable {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? parent;
  int? postCount;

  Category({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.parent,
    this.postCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        parent: json["parent"],
        postCount: json["post_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "parent": parent,
        "post_count": postCount,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, slug, title, description, parent, postCount];
}

class Comment extends Equatable {
  int? id;
  String? name;
  String? url;
  DateTime? date;
  String? content;
  int? parent;
  Author? author;

  Comment({
    this.id,
    this.name,
    this.url,
    this.date,
    this.content,
    this.parent,
    this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        content: json["content"],
        parent: json["parent"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "date": date?.toIso8601String(),
        "content": content,
        "parent": parent,
        "author": author == null ? null : author?.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, url, date, content, parent, author];
}

class CustomFields extends Equatable {
  CustomFields();

  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields();

  Map<String, dynamic> toJson() => {};

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Query extends Equatable {
  bool? ignoreStickyPosts;
  List<String>? postIn;
  String? count;
  String? exclude;
  String? postType;
  String? orderby;

  Query({
    this.ignoreStickyPosts,
    this.postIn,
    this.count,
    this.exclude,
    this.postType,
    this.orderby,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        ignoreStickyPosts: json["ignore_sticky_posts"],
        postIn: json["post__in"] == null
            ? null
            : List<String>.from(json["post__in"].map((x) => x)),
        count: json["count"],
        exclude: json["exclude"],
        postType: json["post_type"],
        orderby: json["orderby"],
      );

  Map<String, dynamic> toJson() => {
        "ignore_sticky_posts": ignoreStickyPosts,
        "post__in": List<dynamic>.from(postIn!.map((x) => x)),
        "count": count,
        "exclude": exclude,
        "post_type": postType,
        "orderby": orderby,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [ignoreStickyPosts, postIn, count, exclude, postType, orderby];
}
