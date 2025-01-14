// To parse this JSON data, do
//
//     final modelForceUpdate = modelForceUpdateFromJson(jsonString);

import 'dart:convert';

ModelForceUpdate modelForceUpdateFromJson(String str) =>
    ModelForceUpdate.fromJson(json.decode(str));

String modelForceUpdateToJson(ModelForceUpdate data) =>
    json.encode(data.toJson());

class ModelForceUpdate {
  ModelForceUpdate({
    this.resCode,
    this.resText,
    this.resResult,
  });

  String? resCode;
  String? resText;
  ResResult? resResult;

  factory ModelForceUpdate.fromJson(Map<String, dynamic> json) =>
      ModelForceUpdate(
        resCode: json["res_code"],
        resText: json["res_text"],
        resResult: json["res_result"] == null || json["res_result"] == 'Close'
            ? null
            : ResResult.fromJson(json["res_result"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_result": resResult?.toJson(),
      };
}

class ResResult {
  ResResult({
    this.verId,
    this.verBundle,
    this.verNumber,
    this.verUpdateversion,
  });

  int? verId;
  String? verBundle;
  int? verNumber;
  int? verUpdateversion;

  factory ResResult.fromJson(Map<String, dynamic> json) => ResResult(
        verId: json["ver_id"],
        verBundle: json["ver_bundle"],
        verNumber: json["ver_number"],
        verUpdateversion: json["ver_updateversion"],
      );

  Map<String, dynamic> toJson() => {
        "ver_id": verId,
        "ver_bundle": verBundle,
        "ver_number": verNumber,
        "ver_updateversion": verUpdateversion,
      };
}
