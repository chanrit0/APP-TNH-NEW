class  HealthResultLatestModel {
  final String name;
  final String day;
  final String time;
  final String physician;
  final String statusHealth;
  final String checkUpNumber;
  final String vn;
  final bool statusVital_Sign;
  final bool statusLab;
  final bool statusX_ray;
  final bool statusConclusion;

  const HealthResultLatestModel({
    required this.name,
    required this.day,
    required this.time,
    required this.physician,
    required this.statusHealth,
    required this.checkUpNumber,
    required this.vn,
    required this.statusVital_Sign,
    required this.statusLab,
    required this.statusX_ray,
    required this.statusConclusion,
  });

  static HealthResultLatestModel fromJson(json) => HealthResultLatestModel(
        name: json['name'],
        day: json['day'],
        time: json['time'],
        physician: json['physician'],
        statusHealth: json['statusHealth'],
        checkUpNumber: json['checkUpNumber'],
        vn: json['vn'],
        statusVital_Sign: json['statusVital_Sign'],
        statusLab: json['statusLab'],
        statusX_ray: json['statusX_ray'],
        statusConclusion: json['statusConclusion'],
      );
}
