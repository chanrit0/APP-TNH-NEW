// To parse this JSON data, do
//
//     final modelHealthReport = modelHealthReportFromJson(jsonString);

import 'dart:convert';

ModelHealthReport modelHealthReportFromJson(String str) =>
    ModelHealthReport.fromJson(json.decode(str));

String modelHealthReportToJson(ModelHealthReport data) =>
    json.encode(data.toJson());

class ModelHealthReport {
  ModelHealthReport({
    this.resCode,
    required this.resData,
  });

  String? resCode;
  List<ResHealthReport> resData;

  factory ModelHealthReport.fromJson(Map<String, dynamic> json) =>
      ModelHealthReport(
        resCode: json["res_code"],
        resData: json["res_data"] == null
            ? []
            : List<ResHealthReport>.from(
                json["res_data"]!.map((x) => ResHealthReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_data": resData.isEmpty
            ? []
            : List<dynamic>.from(resData.map((x) => x.toJson())),
      };
}

class ResHealthReport {
  ResHealthReport({
    this.requestNo,
    this.name,
    this.genderTh,
    this.age,
    required this.visitDate,
    this.vn,
    this.time,
    this.requestDoctor,
    this.docterName,
    this.vitalsignStatus,
    this.labStatus,
    this.xrayStatus,
    this.summaryStatus,
  });

  String? requestNo;
  String? name;
  String? genderTh;
  int? age;
  DateTime visitDate;
  String? vn;
  String? time;
  String? requestDoctor;
  String? docterName;
  int? vitalsignStatus;
  int? labStatus;
  int? xrayStatus;
  int? summaryStatus;

  factory ResHealthReport.fromJson(Map<String, dynamic> json) =>
      ResHealthReport(
        requestNo: json["RequestNo"],
        name: json["name"],
        genderTh: json["GenderTH"],
        age: json["Age"],
        visitDate: DateTime.parse(json["VisitDate"]),
        vn: json["VN"],
        time: json["Time"],
        requestDoctor: json["RequestDoctor"],
        docterName: json["doctorName"],
        vitalsignStatus: json["vitalsignStatus"],
        labStatus: json["labStatus"],
        xrayStatus: json["xrayStatus"],
        summaryStatus: json["summaryStatus"],
      );

  Map<String, dynamic> toJson() => {
        "RequestNo": requestNo,
        "name": name,
        "GenderTH": genderTh,
        "age": age,
        "VisitDate": visitDate.toIso8601String(),
        "VN": vn,
        "Time": time,
        "RequestDoctor": requestDoctor,
        "docterName": docterName,
        "vitalsignStatus": vitalsignStatus,
        "labStatus": labStatus,
        "xrayStatus": xrayStatus,
        "summaryStatus": summaryStatus,
      };
}
