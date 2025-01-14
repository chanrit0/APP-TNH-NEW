// To parse this JSON data, do
//
//     final modelContact = modelContactFromJson(jsonString);

import 'dart:convert';

ModelContact modelContactFromJson(String str) =>
    ModelContact.fromJson(json.decode(str));

String modelContactToJson(ModelContact data) => json.encode(data.toJson());

class ModelContact {
  ModelContact({
    this.resCode,
    this.resText,
    this.resData,
  });

  String? resCode;
  String? resText;
  Contct? resData;

  factory ModelContact.fromJson(Map<String, dynamic> json) => ModelContact(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData:
            json["res_data"] == null ? null : Contct.fromJson(json["res_data"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData?.toJson(),
      };
}

class Contct {
  Contct({
    this.hospital,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.facebook,
    this.ig,
    this.twitter,
    this.googlemap,
    this.youtube,
    this.line,
  });

  String? hospital;
  String? address;
  List<String>? phone;
  String? fax;
  String? email;
  String? facebook;
  String? ig;
  String? twitter;
  String? googlemap;
  String? youtube;
  String? line;

  factory Contct.fromJson(Map<String, dynamic> json) => Contct(
        hospital: json["hospital"],
        address: json["address"],
        phone: json["phone"] == null
            ? []
            : List<String>.from(json["phone"]!.map((x) => x)),
        fax: json["fax"],
        email: json["email"],
        facebook: json["facebook"],
        ig: json["ig"],
        twitter: json["twitter"],
        googlemap: json["googlemap"],
        youtube: json["youtube"],
        line: json['line'],
      );

  Map<String, dynamic> toJson() => {
        "hospital": hospital,
        "address": address,
        "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
        "fax": fax,
        "email": email,
        "facebook": facebook,
        "ig": ig,
        "twitter": twitter,
        "googlemap": googlemap,
        "youtube": youtube,
        "line": line,
      };
}
