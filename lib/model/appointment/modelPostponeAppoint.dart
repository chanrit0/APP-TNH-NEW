// To parse this JSON data, do
//
//     final modelPostponeAppoint = modelPostponeAppointFromJson(jsonString);

import 'dart:convert';

ModelPostponeAppoint modelPostponeAppointFromJson(String str) =>
    ModelPostponeAppoint.fromJson(json.decode(str));

String modelPostponeAppointToJson(ModelPostponeAppoint data) =>
    json.encode(data.toJson());

class ModelPostponeAppoint {
  ModelPostponeAppoint({
    required this.resCode,
    required this.resText,
  });

  String resCode;
  String resText;

  factory ModelPostponeAppoint.fromJson(Map<String, dynamic> json) =>
      ModelPostponeAppoint(
        resCode: json["res_code"],
        resText: json["res_text"],
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
      };
}
