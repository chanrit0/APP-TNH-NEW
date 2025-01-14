// To parse this JSON data, do
//
//     final modelDuedate = modelDuedateFromJson(jsonString);

import 'dart:convert';

ModelDuedate modelDuedateFromJson(String str) =>
    ModelDuedate.fromJson(json.decode(str));

String modelDuedateToJson(ModelDuedate data) => json.encode(data.toJson());

class ModelDuedate {
  ModelDuedate({
    required this.resCode,
    required this.resText,
    required this.resData,
  });

  String resCode;
  String resText;
  List<ResDatum> resData;

  factory ModelDuedate.fromJson(Map<String, dynamic> json) => ModelDuedate(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: List<ResDatum>.from(
            json["res_data"].map((x) => ResDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": List<dynamic>.from(resData.map((x) => x.toJson())),
      };
}

class ResDatum {
  ResDatum({
    required this.itemcode,
    required this.title,
    required this.department,
    required this.laststatus,
  });

  String itemcode;
  String title;
  String department;
  String laststatus;

  factory ResDatum.fromJson(Map<String, dynamic> json) => ResDatum(
        itemcode: json["Itemcode"],
        title: json["title"],
        department: json["department"],
        laststatus: json["Laststatus "],
      );

  Map<String, dynamic> toJson() => {
        "Itemcode": itemcode,
        "title": title,
        "department": department,
        "Laststatus ": laststatus,
      };
}
