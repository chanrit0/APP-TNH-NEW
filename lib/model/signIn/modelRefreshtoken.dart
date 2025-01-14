// To parse this JSON data, do
//
//     final modelRefreshToken = modelRefreshTokenFromJson(jsonString);

import 'dart:convert';

ModelRefreshToken modelRefreshTokenFromJson(String str) =>
    ModelRefreshToken.fromJson(json.decode(str));

String modelRefreshTokenToJson(ModelRefreshToken data) =>
    json.encode(data.toJson());

class ModelRefreshToken {
  ModelRefreshToken({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.verifyStatus,
  });

  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;
  String? verifyStatus;

  factory ModelRefreshToken.fromJson(Map<String, dynamic> json) =>
      ModelRefreshToken(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        verifyStatus: json["verify_status"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "verify_status": verifyStatus,
      };
}
