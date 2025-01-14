// To parse this JSON data, do
//
//     final modelAgreementCheck = modelAgreementCheckFromJson(jsonString);

import 'dart:convert';

ModelAgreementCheck modelAgreementCheckFromJson(String str) =>
    ModelAgreementCheck.fromJson(json.decode(str));

String modelAgreementCheckToJson(ModelAgreementCheck data) =>
    json.encode(data.toJson());

class ModelAgreementCheck {
  ModelAgreementCheck({
    this.resCode,
    this.resText,
    this.resData,
  });

  String? resCode;
  String? resText;
  ResData? resData;

  factory ModelAgreementCheck.fromJson(Map<String, dynamic> json) =>
      ModelAgreementCheck(
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
    this.termsOfUse,
    this.privacyPolicy,
    this.healthPolicy,
    this.marketingPolicy,
  });

  bool? termsOfUse;
  bool? privacyPolicy;
  bool? healthPolicy;
  bool? marketingPolicy;

  factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        termsOfUse: json["termsOfUse"],
        privacyPolicy: json["privacyPolicy"],
        healthPolicy: json["healthPolicy"],
        marketingPolicy: json["marketingPolicy"],
      );

  Map<String, dynamic> toJson() => {
        "termsOfUse": termsOfUse,
        "privacyPolicy": privacyPolicy,
        "healthPolicy": healthPolicy,
        "marketingPolicy": marketingPolicy,
      };
}
