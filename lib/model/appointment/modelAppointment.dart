// To parse this JSON data, do
//
//     final modelAppointment = modelAppointmentFromJson(jsonString);

import 'dart:convert';

ModelAppointment modelAppointmentFromJson(String str) =>
    ModelAppointment.fromJson(json.decode(str));

String modelAppointmentToJson(ModelAppointment data) =>
    json.encode(data.toJson());

class ModelAppointment {
  ModelAppointment({
    required this.resCode,
    required this.resText,
    required this.resData,
  });

  String resCode;
  String resText;
  List<ResAppointment> resData;

  factory ModelAppointment.fromJson(Map<String, dynamic> json) =>
      ModelAppointment(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: List<ResAppointment>.from(
            json["res_data"].map((x) => ResAppointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": List<dynamic>.from(resData.map((x) => x.toJson())),
      };
}

class ResAppointment {
  ResAppointment({
    required this.apmbId,
    required this.date,
    required this.time,
    required this.workplace,
    required this.doctorName,
    required this.clinicNameth,
    required this.status,
    required this.detail,
    required this.img,
    required this.packageCode,
    required this.name,
  });

  int apmbId;
  DateTime date;
  String time;
  String workplace;
  String doctorName;
  String clinicNameth;
  String status;
  String detail;
  String img;
  String packageCode;
  String name;

  factory ResAppointment.fromJson(Map<String, dynamic> json) => ResAppointment(
        apmbId: json["apmb_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        workplace: json["workplace"],
        doctorName: json["doctor_name"],
        clinicNameth: json["clinic_nameth"],
        status: json["status"],
        detail: json["detail"],
        img: json["img"],
        packageCode: json["package_code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "apmb_id": apmbId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "workplace": workplace,
        "doctor_name": doctorName,
        "clinic_nameth": clinicNameth,
        "status": status,
        "detail": detail,
        "img": img,
        "package_code": packageCode,
        "name": name,
      };
}
