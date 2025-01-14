// To parse this JSON data, do
//
//     final modelHealthReportDetail = modelHealthReportDetailFromJson(jsonString);

import 'dart:convert';

ModelHealthReportDetail modelHealthReportDetailFromJson(String str) =>
    ModelHealthReportDetail.fromJson(json.decode(str));

String modelHealthReportDetailToJson(ModelHealthReportDetail data) =>
    json.encode(data.toJson());

class ModelHealthReportDetail {
  String resCode;
  ResReportDetail resData;

  ModelHealthReportDetail({
    required this.resCode,
    required this.resData,
  });

  factory ModelHealthReportDetail.fromJson(Map<String, dynamic> json) =>
      ModelHealthReportDetail(
        resCode: json["res_code"],
        resData: ResReportDetail.fromJson(json["res_data"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_data": resData.toJson(),
      };
}

class ResReportDetail {
  List<Vitalsign> vitalsign;
  List<Lab> lab;
  List<Xray> xray;
  List<Summary> summary;

  ResReportDetail({
    required this.vitalsign,
    required this.lab,
    required this.xray,
    required this.summary,
  });

  factory ResReportDetail.fromJson(Map<String, dynamic> json) =>
      ResReportDetail(
        vitalsign: List<Vitalsign>.from(
            json["vitalsign"].map((x) => Vitalsign.fromJson(x))),
        lab: List<Lab>.from(json["lab"].map((x) => Lab.fromJson(x))),
        xray: List<Xray>.from(json["xray"].map((x) => Xray.fromJson(x))),
        summary:
            List<Summary>.from(json["summary"].map((x) => Summary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vitalsign": List<dynamic>.from(vitalsign.map((x) => x.toJson())),
        "lab": List<dynamic>.from(lab.map((x) => x.toJson())),
        "xray": List<dynamic>.from(xray.map((x) => x.toJson())),
        "summary": List<dynamic>.from(summary.map((x) => x.toJson())),
      };
}

class Lab {
  int id;
  String? labGroup;
  bool isExpanded;
  List<List<Body>> body;

  Lab({
    required this.id,
    required this.labGroup,
    required this.isExpanded,
    required this.body,
  });

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
        id: json["id"],
        labGroup: json["LabGroup"],
        isExpanded: json["isExpanded"],
        body: List<List<Body>>.from(json["body"]
            .map((x) => List<Body>.from(x.map((x) => Body.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "LabGroup": labGroup,
        "isExpanded": isExpanded,
        "body": List<dynamic>.from(
            body.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Body {
  String requestNo;
  String hn;
  int suffixSmall;
  String? labGroup;
  String labCode;
  String? labNameTh;
  String? labNameEn;
  String resultValue;
  DateTime resultDateTime;
  String previousResultValue;
  String normalResultValue;
  String labResultClassifiedName;
  String? unit;
  int status;
  String summary;
  String? labCommentTh;
  String labCommentEn;
  int facilityResultType;
  int labResultClassifiedType;

  Body({
    required this.requestNo,
    required this.hn,
    required this.suffixSmall,
    required this.labGroup,
    required this.labCode,
    required this.labNameTh,
    required this.labNameEn,
    required this.resultValue,
    required this.resultDateTime,
    required this.previousResultValue,
    required this.normalResultValue,
    required this.labResultClassifiedName,
    required this.unit,
    required this.status,
    required this.summary,
    required this.labCommentTh,
    required this.labCommentEn,
    required this.facilityResultType,
    required this.labResultClassifiedType,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        requestNo: json["RequestNo"],
        hn: json["HN"],
        suffixSmall: json["SuffixSmall"],
        labGroup: json["LabGroup"],
        labCode: json["LabCode"],
        labNameTh: json["labNameTH"],
        labNameEn: json["labNameEN"],
        resultValue: json["ResultValue"],
        resultDateTime: DateTime.parse(json["ResultDateTime"]),
        previousResultValue: json["PreviousResultValue"],
        normalResultValue: json["NormalResultValue"],
        labResultClassifiedName: json["LABResultClassifiedName"],
        unit: json["Unit"],
        status: json["status"],
        summary: json["summary"],
        labCommentTh: json["LabCommentTH"],
        labCommentEn: json["LabCommentEN"],
        facilityResultType: json["FacilityResultType"],
        labResultClassifiedType: json["LABResultClassifiedType"],
      );

  Map<String, dynamic> toJson() => {
        "RequestNo": requestNo,
        "HN": hn,
        "SuffixSmall": suffixSmall,
        "LabGroup": labGroup,
        "LabCode": labCode,
        "labNameTH": labNameTh,
        "labNameEN": labNameEn,
        "ResultValue": resultValue,
        "ResultDateTime": resultDateTime.toIso8601String(),
        "PreviousResultValue": previousResultValue,
        "NormalResultValue": normalResultValue,
        "LABResultClassifiedName": labResultClassifiedName,
        "Unit": unit,
        "status": status,
        "summary": summary,
        "LabCommentTH": labCommentTh,
        "LabCommentEN": labCommentEn,
        "FacilityResultType": facilityResultType,
        "LABResultClassifiedType": labResultClassifiedType,
      };
}

class Summary {
  String? summary;

  Summary({
    required this.summary,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "summary": summary,
      };
}

class Vitalsign {
  String requestNo;
  int age;
  DateTime entryDateTime;
  DateTime visitdate;
  dynamic bodyWeight;
  dynamic height;
  dynamic highpulserate;
  dynamic lowpulserate;
  dynamic temperature;
  dynamic pulseRate;
  String blood;
  dynamic bmiValue;
  dynamic respirationRate;
  String remarks;

  Vitalsign({
    required this.requestNo,
    required this.age,
    required this.entryDateTime,
    required this.visitdate,
    required this.bodyWeight,
    required this.height,
    required this.highpulserate,
    required this.lowpulserate,
    required this.temperature,
    required this.pulseRate,
    required this.blood,
    required this.bmiValue,
    required this.respirationRate,
    required this.remarks,
  });

  factory Vitalsign.fromJson(Map<String, dynamic> json) => Vitalsign(
        requestNo: json["RequestNo"],
        age: json["Age"],
        entryDateTime: DateTime.parse(json["EntryDateTime"]),
        visitdate: DateTime.parse(json["Visitdate"]),
        bodyWeight: json["BodyWeight"],
        height: json["Height"],
        highpulserate: json["Highpulserate"],
        lowpulserate: json["Lowpulserate"],
        temperature: json["Temperature"]?.toDouble(),
        pulseRate: json["PulseRate"],
        blood: json["Blood"],
        bmiValue: json["BMIValue"]?.toDouble(),
        respirationRate: json["RespirationRate"],
        remarks: json["Remarks"],
      );

  Map<String, dynamic> toJson() => {
        "RequestNo": requestNo,
        "Age": age,
        "EntryDateTime": entryDateTime.toIso8601String(),
        "Visitdate":
            "${visitdate.year.toString().padLeft(4, '0')}-${visitdate.month.toString().padLeft(2, '0')}-${visitdate.day.toString().padLeft(2, '0')}",
        "BodyWeight": bodyWeight,
        "Height": height,
        "Highpulserate": highpulserate,
        "Lowpulserate": lowpulserate,
        "Temperature": temperature,
        "PulseRate": pulseRate,
        "Blood": blood,
        "BMIValue": bmiValue,
        "RespirationRate": respirationRate,
        "Remarks": remarks,
      };
}

class Xray {
  String requestNo;
  int suffixSmall;
  String xrayGroup;
  String xrayNo;
  String codexray;
  String xrayNameTh;
  String xrayNameEn;
  DateTime resultDateTime;
  String result;
  String resultCode;
  String summary;

  Xray({
    required this.requestNo,
    required this.suffixSmall,
    required this.xrayGroup,
    required this.xrayNo,
    required this.codexray,
    required this.xrayNameTh,
    required this.xrayNameEn,
    required this.resultDateTime,
    required this.result,
    required this.resultCode,
    required this.summary,
  });

  factory Xray.fromJson(Map<String, dynamic> json) => Xray(
        requestNo: json["RequestNo"],
        suffixSmall: json["SuffixSmall"],
        xrayGroup: json["XrayGroup"],
        xrayNo: json["XrayNo"],
        codexray: json["Codexray"],
        xrayNameTh: json["XrayNameTH"],
        xrayNameEn: json["XrayNameEN"],
        resultDateTime: DateTime.parse(json["ResultDateTime"]),
        result: json["Result"],
        resultCode: json["ResultCode"],
        summary: json["Summary"],
      );

  Map<String, dynamic> toJson() => {
        "RequestNo": requestNo,
        "SuffixSmall": suffixSmall,
        "XrayGroup": xrayGroup,
        "XrayNo": xrayNo,
        "Codexray": codexray,
        "XrayNameTH": xrayNameTh,
        "XrayNameEN": xrayNameEn,
        "ResultDateTime": resultDateTime.toIso8601String(),
        "Result": result,
        "ResultCode": resultCode,
        "Summary": summary,
      };
}
