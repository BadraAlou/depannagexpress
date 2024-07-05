
class CommandeModel {
  int? id;
  String? nom;
  String? depart;
  String? destination;
  num? latitude;
  num? longitude;
  num? distanceValue;
  String? distanceText;
  String? details;

  CommandeModel({
    this.id, this.nom, this.depart, this.destination, this.latitude, this.longitude, this.distanceValue, this.distanceText, this.details
  });

}