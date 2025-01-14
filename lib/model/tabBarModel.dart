class TabBarModel {
  final int id;
  final String titel;

  const TabBarModel({
    required this.id,
    required this.titel,
  });

  static TabBarModel fromJson(json) => TabBarModel(
        id: json['id'],
        titel: json['titel'],
      );
}
