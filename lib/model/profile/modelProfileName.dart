// To parse this JSON data, do
//
//     final modelProfileName = modelProfileNameFromJson(jsonString);

import 'dart:convert';

ModelProfileName modelProfileNameFromJson(String str) =>
    ModelProfileName.fromJson(json.decode(str));

String modelProfileNameToJson(ModelProfileName data) =>
    json.encode(data.toJson());

class ModelProfileName {
  ModelProfileName({
    this.resCode,
    this.resText,
    this.resData,
  });

  String? resCode;
  String? resText;
  ProfileName? resData;

  factory ModelProfileName.fromJson(Map<String, dynamic> json) =>
      ModelProfileName(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: json["res_data"] == null
            ? null
            : ProfileName.fromJson(json["res_data"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData?.toJson(),
      };
}

class ProfileName {
  ProfileName({
    this.fname,
    this.lname,
    this.hn,
  });

  String? fname;
  String? lname;
  String? hn;

  factory ProfileName.fromJson(Map<String, dynamic> json) => ProfileName(
        fname: json["fname"],
        lname: json["lname"],
        hn: json["hn"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "hn": hn,
      };
}
