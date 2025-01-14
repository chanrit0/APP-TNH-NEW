// To parse this JSON data, do
//
//     final modelNoti = modelNotiFromJson(jsonString);

import 'dart:convert';

ModelNoti modelNotiFromJson(String str) => ModelNoti.fromJson(json.decode(str));

String modelNotiToJson(ModelNoti data) => json.encode(data.toJson());

class ModelNoti {
    ModelNoti({
        this.resCode,
        this.resText,
        this.resData,
    });

    String? resCode;
    String? resText;
    List<NotiData>? resData;

    factory ModelNoti.fromJson(Map<String, dynamic> json) => ModelNoti(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: json["res_data"] == null ? [] : List<NotiData>.from(json["res_data"]!.map((x) => NotiData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData == null ? [] : List<dynamic>.from(resData!.map((x) => x.toJson())),
    };
}

class NotiData {
    NotiData({
        this.id,
        this.title,
        this.department,
        this.status,
        this.date,
        this.time,
    });

    int? id;
    String? title;
    String? department;
    int? status;
    DateTime? date;
    String? time;

    factory NotiData.fromJson(Map<String, dynamic> json) => NotiData(
        id: json["id"],
        title: json["title"],
        department: json["department"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "department": department,
        "status": status,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
    };
}
