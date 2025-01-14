// To parse this JSON data, do
//
//     final modelSuccess = modelSuccessFromJson(jsonString);

import 'dart:convert';

ModelSuccess modelSuccessFromJson(String str) => ModelSuccess.fromJson(json.decode(str));

String modelSuccessToJson(ModelSuccess data) => json.encode(data.toJson());

class ModelSuccess {
    ModelSuccess({
        this.resCode,
        this.resText,
    });

    String? resCode;
    String? resText;

    factory ModelSuccess.fromJson(Map<String, dynamic> json) => ModelSuccess(
        resCode: json["res_code"],
        resText: json["res_text"],
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
    };
}
