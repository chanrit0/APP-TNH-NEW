// To parse this JSON data, do
//
//     final modelBanner = modelBannerFromJson(jsonString);

import 'dart:convert';

ModelBanner modelBannerFromJson(String str) =>
    ModelBanner.fromJson(json.decode(str));

String modelBannerToJson(ModelBanner data) => json.encode(data.toJson());

class ModelBanner {
  ModelBanner({
    this.resCode,
    this.resText,
    this.resData,
  });

  String? resCode;
  String? resText;
  ResData? resData;

  factory ModelBanner.fromJson(Map<String, dynamic> json) => ModelBanner(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: json["res_data"] == null
            ? null
            : ResData.fromJson(json["res_data"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData?.toJson(),
      };
}

class ResData {
  ResData({
    this.banner,
    this.articleCategory,
  });

  List<DataBanner>? banner;
  List<ArticleCategory>? articleCategory;

  factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        banner: json["banner"] == null
            ? []
            : List<DataBanner>.from(
                json["banner"]!.map((x) => DataBanner.fromJson(x))),
        articleCategory: json["article_category"] == null
            ? []
            : List<ArticleCategory>.from(json["article_category"]!
                .map((x) => ArticleCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner == null
            ? []
            : List<dynamic>.from(banner!.map((x) => x.toJson())),
        "article_category": articleCategory == null
            ? []
            : List<dynamic>.from(articleCategory!.map((x) => x.toJson())),
      };
}

class ArticleCategory {
  ArticleCategory({
    this.cateId,
    this.icon,
    this.category,
  });

  int? cateId;
  String? icon;
  String? category;

  factory ArticleCategory.fromJson(Map<String, dynamic> json) =>
      ArticleCategory(
        cateId: json["cateID"],
        icon: json["icon"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "cateID": cateId,
        "icon": icon,
        "category": category,
      };
}

class DataBanner {
  DataBanner({
    this.img,
    this.url,
  });

  String? img;
  String? url;

  factory DataBanner.fromJson(Map<String, dynamic> json) => DataBanner(
        img: json["img"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "url": url,
      };
}

class Banner {
  Banner({
    this.img,
    this.url,
  });

  String? img;
  String? url;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        img: json["img"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "url": url,
      };
}
