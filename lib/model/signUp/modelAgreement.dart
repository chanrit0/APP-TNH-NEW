// To parse this JSON data, do
//
//     final modelAgreement = modelAgreementFromJson(jsonString);

import 'dart:convert';

ModelAgreement modelAgreementFromJson(String str) => ModelAgreement.fromJson(json.decode(str));

String modelAgreementToJson(ModelAgreement data) => json.encode(data.toJson());

class ModelAgreement {
    ModelAgreement({
        this.resCode,
        this.resText,
        this.resData,
    });

    String? resCode;
    String? resText;
    ResAgreement? resData;

    factory ModelAgreement.fromJson(Map<String, dynamic> json) => ModelAgreement(
        resCode: json["res_code"],
        resText: json["res_text"],
        resData: json["res_data"] == null ? null : ResAgreement.fromJson(json["res_data"]),
    );

    Map<String, dynamic> toJson() => {
        "res_code": resCode,
        "res_text": resText,
        "res_data": resData?.toJson(),
    };
}

class ResAgreement {
    ResAgreement({
        this.termsOfUse,
        this.privacyPolicy,
        this.healthPolicy,
        this.marketingPolicy,
    });

    String? termsOfUse;
    String? privacyPolicy;
    String? healthPolicy;
    String? marketingPolicy;

    factory ResAgreement.fromJson(Map<String, dynamic> json) => ResAgreement(
        termsOfUse: json["termsOfUse "],
        privacyPolicy: json["privacyPolicy"],
        healthPolicy: json["healthPolicy"],
        marketingPolicy: json["marketingPolicy "],
    );

    Map<String, dynamic> toJson() => {
        "termsOfUse ": termsOfUse,
        "privacyPolicy": privacyPolicy,
        "healthPolicy": healthPolicy,
        "marketingPolicy ": marketingPolicy,
    };
}
