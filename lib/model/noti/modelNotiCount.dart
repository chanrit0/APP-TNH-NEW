// To parse this JSON data, do
//
//     final modelNotiCount = modelNotiCountFromJson(jsonString);

import 'dart:convert';

ModelNotiCount modelNotiCountFromJson(String str) => ModelNotiCount.fromJson(json.decode(str));

String modelNotiCountToJson(ModelNotiCount data) => json.encode(data.toJson());

class ModelNotiCount {
    ModelNotiCount({
        this.resCode,
        this.resText,
        this.resData,
    });

    String? resCode;
    String? resText;
    ResData? resData;

    factory ModelNotiCount.fromJson(Map<String, dynamic> json) => ModelNotiCount(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: json["res_data"] == null ? null : ResData.fromJson(json["res_data"]),
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData?.toJson(),
    };
}

class ResData {
    ResData({
        this.count,
    });

    int? count;

    factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}
