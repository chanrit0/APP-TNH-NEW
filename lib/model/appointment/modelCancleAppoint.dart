// To parse this JSON data, do
//
//     final modelCancleAppoint = modelCancleAppointFromJson(jsonString);

import 'dart:convert';

ModelCancleAppoint modelCancleAppointFromJson(String str) =>
    ModelCancleAppoint.fromJson(json.decode(str));

String modelCancleAppointToJson(ModelCancleAppoint data) =>
    json.encode(data.toJson());

class ModelCancleAppoint {
  ModelCancleAppoint({
    required this.resCode,
    required this.resText,
  });

  String resCode;
  String resText;

  factory ModelCancleAppoint.fromJson(Map<String, dynamic> json) =>
      ModelCancleAppoint(
        resCode: json["res_code"],
        resText: json["res_text"],
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
      };
}
