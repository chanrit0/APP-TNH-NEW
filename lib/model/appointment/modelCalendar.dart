// To parse this JSON data, do
//
//     final modelCalendar = modelCalendarFromJson(jsonString);

import 'dart:convert';

ModelCalendar modelCalendarFromJson(String str) =>
    ModelCalendar.fromJson(json.decode(str));

String modelCalendarToJson(ModelCalendar data) => json.encode(data.toJson());

class ModelCalendar {
  ModelCalendar({
    required this.resCode,
    required this.resText,
    required this.resData,
  });

  String resCode;
  String resText;
  List<ResDatum> resData;

  factory ModelCalendar.fromJson(Map<String, dynamic> json) => ModelCalendar(
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
    required this.date,
    required this.times,
  });

  DateTime date;
  List<Time> times;

  factory ResDatum.fromJson(Map<String, dynamic> json) => ResDatum(
        date: DateTime.parse(json["date"]),
        times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "times": List<dynamic>.from(times.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    required this.time,
    required this.status,
  });

  String time;
  String status;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "status": status,
      };
}
