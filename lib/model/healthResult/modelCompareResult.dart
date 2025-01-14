// To parse this JSON data, do
//
//     final compareResulTabtModel = compareResulTabtModelFromJson(jsonString);

import 'dart:convert';

CompareResulTabtModel compareResulTabtModelFromJson(String str) =>
    CompareResulTabtModel.fromJson(json.decode(str));

String compareResulTabtModelToJson(CompareResulTabtModel data) =>
    json.encode(data.toJson());

class CompareResulTabtModel {
  CompareResulTabtModel({
    this.titel,
    this.data,
  });

  String? titel;
  List<Datum>? data;

  factory CompareResulTabtModel.fromJson(Map<String, dynamic> json) =>
      CompareResulTabtModel(
        titel: json["titel"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "titel": titel,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.date,
    this.checkUp,
    this.weight,
    this.height,
    this.pulseRate,
    this.bloodPressure,
    this.bodyMass,
    this.waistline,
    this.glasses,
    this.colorBlindness,
  });

  String? date;
  String? checkUp;
  String? weight;
  String? height;
  String? pulseRate;
  String? bloodPressure;
  String? bodyMass;
  String? waistline;
  String? glasses;
  String? colorBlindness;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        checkUp: json["check_up"],
        weight: json["weight"],
        height: json["height"],
        pulseRate: json["pulse_rate"],
        bloodPressure: json["blood_pressure"],
        bodyMass: json["body_mass"],
        waistline: json["waistline"],
        glasses: json["glasses"],
        colorBlindness: json["color_blindness"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "check_up": checkUp,
        "weight": weight,
        "height": height,
        "pulse_rate": pulseRate,
        "blood_pressure": bloodPressure,
        "body_mass": bodyMass,
        "waistline": waistline,
        "glasses": glasses,
        "color_blindness": colorBlindness,
      };
}
