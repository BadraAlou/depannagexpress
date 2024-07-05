class Commande {
  final int? id;
  final String? nom;
  final String? depart;
  final String? destination;
  final num? latitude;
  final num? longitude;
  final num? distanceValue;
  final String? distanceText;
  final String? details;

  Commande({
    this.id,
    this.nom,
    this.depart,
    this.destination,
    this.latitude,
    this.longitude,
    this.distanceValue,
    this.distanceText,
    this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'depart': depart,
      'destination': destination,
      'latitude': latitude,
      'longitude': longitude,
      'distance_value': distanceValue,
      'distance_text': distanceText,
      'details': details,
    };
  }

  Map<String, dynamic> toJsonLocale() {
    return {
      'id': id,
      'nom': nom,
      'depart': depart,
      'destination': destination,
      'latitude': latitude,
      'longitude': longitude,
      'distance_value': distanceValue,
      'distance_text': distanceText,
      'details': details,
    };
  }

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      nom: json['nom'],
      depart: json['depart'],
      destination: json['destination'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      distanceValue: json['distance_value'],
      distanceText: json['distance_text'],
      details: json['details'],
    );
  }
}