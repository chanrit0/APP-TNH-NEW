// To parse this JSON data, do
//
//     final modelSignupStep1 = modelSignupStep1FromJson(jsonString);

import 'dart:convert';

ModelSignupStep1 modelSignupStep1FromJson(String str) => ModelSignupStep1.fromJson(json.decode(str));

String modelSignupStep1ToJson(ModelSignupStep1 data) => json.encode(data.toJson());

class ModelSignupStep1 {
    ModelSignupStep1({
        this.resCode,
        this.id,
        this.resText,
        this.refNo,
        this.hn,
        this.hidePhone,
    });

    String? resCode;
    int? id;
    String? resText;
    String? refNo;
    String? hn;
    String? hidePhone;

    factory ModelSignupStep1.fromJson(Map<String, dynamic> json) => ModelSignupStep1(
        resCode: json["res_code"],
        id: json["id"],
        resText: json["res_text"],
        refNo: json["ref_no"],
        hn: json["hn"],
        hidePhone: json["hide_phone"],
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "id": id,
        "res_text": resText,
        "ref_no": refNo,
        "hn": hn,
        "hide_phone": hidePhone,
    };
}
