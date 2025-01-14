// To parse this JSON data, do
//
//     final modelProfile = modelProfileFromJson(jsonString);

import 'dart:convert';

ModelProfile modelProfileFromJson(String str) =>
    ModelProfile.fromJson(json.decode(str));

String modelProfileToJson(ModelProfile data) => json.encode(data.toJson());

class ModelProfile {
  ModelProfile({
    this.resCode,
    this.resText,
    this.memberStatus,
    this.resData,
  });

  String? resCode;
  String? resText;
  String? memberStatus;
  ResData? resData;

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
        resCode: json["res_code"],
        resText: json["res_text"],
        memberStatus: json["member_status"],
        resData: json["res_data"] == null
            ? null
            : ResData.fromJson(json["res_data"]),
      );

  Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "member_status": memberStatus,
        "res_data": resData?.toJson(),
      };
}

class ResData {
  ResData({
    this.profile,
  });

  Profile? profile;

  factory ResData.fromJson(Map<String, dynamic> json) => ResData(
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
      };
}

class Profile {
  Profile({
    this.userId,
    this.fname,
    this.lname,
    this.hn,
    this.birthday,
    this.card,
    this.email,
    this.phone,
    this.img,
    this.comName,
    this.mbCode,
  });

  int? userId;
  String? fname;
  String? lname;
  dynamic hn;
  DateTime? birthday;
  String? card;
  String? email;
  String? phone;
  String? img;
  String? comName;
  String? mbCode;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json["user_id"],
        fname: json["fname"],
        lname: json["lname"],
        hn: json["hn"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        card: json["card"],
        email: json["email"],
        phone: json["phone"],
        img: json["img"],
        comName: json["com_name"],
        mbCode: json["mb_code"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "fname": fname,
        "lname": lname,
        "hn": hn,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "card": card,
        "email": email,
        "phone": phone,
        "img": img,
        "comName": comName,
        "mbCode": mbCode,
      };
}
