// To parse this JSON data, do
//
//     final modelProfileImge = modelProfileImgeFromJson(jsonString);

import 'dart:convert';

ModelProfileImge modelProfileImgeFromJson(String str) => ModelProfileImge.fromJson(json.decode(str));

String modelProfileImgeToJson(ModelProfileImge data) => json.encode(data.toJson());

class ModelProfileImge {
    ModelProfileImge({
        this.resCode,
        this.resText,
        this.memberStatus,
        this.resData,
    });

    String? resCode;
    String? resText;
    String? memberStatus;
    ResData? resData;

    factory ModelProfileImge.fromJson(Map<String, dynamic> json) => ModelProfileImge(
        resCode: json["res_code"],
        resText: json["res_text"],
        memberStatus: json["member_status"],
        resData: json["res_data"] == null ? null : ResData.fromJson(json["res_data"]),
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "member_status": memberStatus,
        "res_data": resData?.toJson(),
    };
}

class ResData {
    ResData({
        this.img,
    });

    String? img;

    factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "img": img,
    };
}
