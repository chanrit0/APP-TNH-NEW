// To parse this JSON data, do
//
//     final modelArticle = modelArticleFromJson(jsonString);

import 'dart:convert';

ModelArticle modelArticleFromJson(String str) =>
    ModelArticle.fromJson(json.decode(str));

String modelArticleToJson(ModelArticle data) => json.encode(data.toJson());

class ModelArticle {
  ModelArticle({
    required this.resCode,
    required this.resText,
    required this.pagination,
    required this.resData,
  });

  String resCode;
  String resText;
  Pagination pagination;
  List<ResDatum> resData;

  factory ModelArticle.fromJson(Map<String, dynamic> json) => ModelArticle(
        resCode: json["res_code"],
        resText: json["res_text"],
        pagination: Pagination.fromJson(json["pagination"]),
        resData: List<ResDatum>.from(
            json["res_data"].map((x) => ResDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "pagination": pagination.toJson(),
        "res_data": List<dynamic>.from(resData.map((x) => x.toJson())),
      };
}

class Pagination {
  Pagination({
    required this.limit,
    required this.offset,
    this.cateId,
    this.tagId,
    this.search,
    required this.random,
  });

  String limit;
  String offset;
  dynamic cateId;
  dynamic tagId;
  dynamic search;
  String random;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        offset: json["offset"],
        cateId: json["cateID"],
        tagId: json["tagID"],
        search: json["search"],
        random: json["random"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "cateID": cateId,
        "tagID": tagId,
        "search": search,
        "random": random,
      };
}

class ResDatum {
  ResDatum({
    required this.articleId,
    required this.title,
    required this.img,
    required this.detail,
    required this.url,
    required this.cateId,
    required this.dateTime,
  });

  int articleId;
  String title;
  String img;
  String detail;
  String url;
  int cateId;
  DateTime dateTime;

  factory ResDatum.fromJson(Map<String, dynamic> json) => ResDatum(
        articleId: json["articleID"],
        title: json["title"] ?? '',
        img: json["img"] ?? '',
        detail: json["detail"] ?? '',
        url: json["url"] ?? '',
        cateId: json["cateID"],
        dateTime: DateTime.parse(json["dateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "articleID": articleId,
        "title": title,
        "img": img,
        "detail": detail,
        "url": url,
        "cateID": cateId,
        "dateTime": dateTime.toIso8601String(),
      };
}
