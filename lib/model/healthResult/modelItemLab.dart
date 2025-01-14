class ItemLabModel {
  ItemLabModel({
    required this.id,
    required this.glucose,
    required this.creatinine,
    required this.eGFR,
    required this.cholesterol,
    required this.triglyceride,
    required this.hdl_c,
    required this.ldl_c,
    required this.sgpt,
    this.isExpanded = false,
  });

  String id;
  String glucose;
  String creatinine;
  String eGFR;
  String cholesterol;
  String triglyceride;
  String hdl_c;
  String ldl_c;
  String sgpt;
  bool isExpanded;

  static ItemLabModel fromJson(json) => ItemLabModel(
        id: json['id'],
        glucose: json['glucose'],
        creatinine: json['creatinine'],
        eGFR: json['eGFR'],
        cholesterol: json['cholesterol'],
        triglyceride: json['triglyceride'],
        hdl_c: json['hdl_c'],
        ldl_c: json['ldl_c'],
        sgpt: json['sgpt'],
      );
}
