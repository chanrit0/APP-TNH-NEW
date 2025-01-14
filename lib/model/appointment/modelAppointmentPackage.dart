// To parse this JSON data, do
//
//     final modelPackage = modelPackageFromJson(jsonString);

import 'dart:convert';

ModelPackage modelPackageFromJson(String str) =>
    ModelPackage.fromJson(json.decode(str));

String modelPackageToJson(ModelPackage data) => json.encode(data.toJson());

class ModelPackage {
  ModelPackage({
    required this.resCode,
    required this.resText,
    this.packageAllow,
    this.packageId,
    this.packageName,
    this.companyName,
    required this.startDate,
    required this.endDate,
    this.list,
    this.condition,
  });

  String resCode;
  String resText;
  bool? packageAllow;
  String? packageId;
  String? packageName;
  String? companyName;
  DateTime startDate;
  DateTime endDate;
  dynamic list;
  String? condition;

  factory ModelPackage.fromJson(Map<String, dynamic> json) => ModelPackage(
        resCode: json["res_code"],
        resText: json["res_text"],
        packageAllow: json["package_allow"],
        packageId: json["packageID"],
        packageName: json["packageName"],
        companyName: json["companyName"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : DateTime.now(),
        endDate: json["endDate"] != null
            ? DateTime.parse(json["endDate"])
            : DateTime.now(),
        list: json["list"] ?? [],
        condition: json["condition"],
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "package_allow": packageAllow,
        "packageID": packageId,
        "packageName": packageName,
        "companyName": companyName,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "list": list,
        "condition": condition,
      };
}
