// To parse this JSON data, do
//
//     final singIn = singInFromJson(jsonString);

import 'dart:convert';

SingIn singInFromJson(String str) => SingIn.fromJson(json.decode(str));

String singInToJson(SingIn data) => json.encode(data.toJson());

class SingIn {
  SingIn({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.verifyStatus,
    this.error,
    this.errorDescription,
    this.message,
  });

  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;
  String? verifyStatus;
  String? error;
  String? errorDescription;
  String? message;

  factory SingIn.fromJson(Map<String, dynamic> json) => SingIn(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        verifyStatus: json["verify_status"],
        error: json["error"],
        errorDescription: json["error_description"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "verify_status": verifyStatus,
        "error": error,
        "error_description": errorDescription,
        "message": message,
      };
}
