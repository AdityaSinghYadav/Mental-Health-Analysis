class Psychotherapist {
  final String name;
  final double latitude;
  final double longitude;

  Psychotherapist({required this.name, required this.latitude, required this.longitude});

  factory Psychotherapist.fromJson(Map<String, dynamic> json) {
    return Psychotherapist(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
