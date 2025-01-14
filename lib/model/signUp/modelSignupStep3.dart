// To parse this JSON data, do
//
//     final modelSignupStep3 = modelSignupStep3FromJson(jsonString);

import 'dart:convert';

ModelSignupStep3 modelSignupStep3FromJson(String str) => ModelSignupStep3.fromJson(json.decode(str));

String modelSignupStep3ToJson(ModelSignupStep3 data) => json.encode(data.toJson());

class ModelSignupStep3 {
    ModelSignupStep3({
        this.resCode,
        this.resText,
    });

    String? resCode;
    String? resText;

    factory ModelSignupStep3.fromJson(Map<String, dynamic> json) => ModelSignupStep3(
        resCode: json["res_code"],
        resText: json["res_text"],
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
    };
}
