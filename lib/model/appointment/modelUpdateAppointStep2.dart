// To parse this JSON data, do
//
//     final modelUpdateAppointStep2 = modelUpdateAppointStep2FromJson(jsonString);

import 'dart:convert';

ModelUpdateAppointStep2 modelUpdateAppointStep2FromJson(String str) =>
    ModelUpdateAppointStep2.fromJson(json.decode(str));

String modelUpdateAppointStep2ToJson(ModelUpdateAppointStep2 data) =>
    json.encode(data.toJson());

class ModelUpdateAppointStep2 {
  ModelUpdateAppointStep2({
    this.resCode,
    this.resText,
    this.resMessage,
  });

  String? resCode;
  String? resText;
  String? resMessage;

  factory ModelUpdateAppointStep2.fromJson(Map<String, dynamic> json) =>
      ModelUpdateAppointStep2(
        resCode: json["res_code"],
        resText: json["res_text"],
        resMessage: json["res_message"],
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_message": resMessage,
      };
}
