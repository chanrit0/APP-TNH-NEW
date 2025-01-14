// To parse this JSON data, do
//
//     final modelSubcategory = modelSubcategoryFromJson(jsonString);

import 'dart:convert';

ModelSubcategory modelSubcategoryFromJson(String str) =>
    ModelSubcategory.fromJson(json.decode(str));

String modelSubcategoryToJson(ModelSubcategory data) =>
    json.encode(data.toJson());

class ModelSubcategory {
  ModelSubcategory({
    required this.resCode,
    required this.resText,
    required this.resData,
  });

  String resCode;
  String resText;
  List<ResDatum> resData;

  factory ModelSubcategory.fromJson(Map<String, dynamic> json) =>
      ModelSubcategory(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: List<ResDatum>.from(
            json["res_data"].map((x) => ResDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": List<dynamic>.from(resData.map((x) => x.toJson())),
      };
}

class ResDatum {
  ResDatum({
    required this.tagId,
    required this.tagName,
  });

  int tagId;
  String tagName;

  factory ResDatum.fromJson(Map<String, dynamic> json) => ResDatum(
        tagId: json["tagID"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tagID": tagId,
        "tag_name": tagName,
      };
}
