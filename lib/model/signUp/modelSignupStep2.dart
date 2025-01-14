// To parse this JSON data, do
//
//     final modelSignupStep2 = modelSignupStep2FromJson(jsonString);

import 'dart:convert';

ModelSignupStep2 modelSignupStep2FromJson(String str) => ModelSignupStep2.fromJson(json.decode(str));

String modelSignupStep2ToJson(ModelSignupStep2 data) => json.encode(data.toJson());

class ModelSignupStep2 {
    ModelSignupStep2({
        this.resCode,
        this.resText,
        this.refNo,
        this.hideEmail,
    });

    String? resCode;
    String? resText;
    String? refNo;
    String? hideEmail;

    factory ModelSignupStep2.fromJson(Map<String, dynamic> json) => ModelSignupStep2(
        resCode: json["res_code"],
        resText: json["res_text"],
        refNo: json["ref_no"],
        hideEmail: json["hide_email"],
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "ref_no": refNo,
        "hide_email": hideEmail,
    };
}
