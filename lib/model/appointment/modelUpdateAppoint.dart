// To parse this JSON data, do
//
//     final modelUpdateAppoint = modelUpdateAppointFromJson(jsonString);

import 'dart:convert';

ModelUpdateAppoint modelUpdateAppointFromJson(String str) =>
    ModelUpdateAppoint.fromJson(json.decode(str));

String modelUpdateAppointToJson(ModelUpdateAppoint data) =>
    json.encode(data.toJson());

class ModelUpdateAppoint {
  ModelUpdateAppoint({
    required this.resCode,
    required this.resText,
    required this.resData,
  });

  String resCode;
  String resText;
  ResData resData;

  factory ModelUpdateAppoint.fromJson(Map<String, dynamic> json) =>
      ModelUpdateAppoint(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: ResData.fromJson(json["res_data"]) ,
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData.toJson(),
      };
}

class ResData {
  ResData({
    required this.date,
    required this.time,
    required this.apdoctorId,
    required this.doctorName,
    required this.workplace,
    required this.clinicNameth,
    required this.detail,
    required this.img,
  });

  DateTime date;
  String time;
  int apdoctorId;
  String doctorName;
  String workplace;
  String clinicNameth;
  String detail;
  String img;

  factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        apdoctorId: json["apdoctor_id"],
        doctorName: json["doctor_name"],
        workplace: json["workplace"],
        clinicNameth: json["clinic_nameth"],
        detail: json["detail"] ?? '',
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "apdoctor_id": apdoctorId,
        "doctor_name": doctorName,
        "workplace": workplace,
        "clinic_nameth": clinicNameth,
        "detail": detail,
        "img": img,
      };
}
