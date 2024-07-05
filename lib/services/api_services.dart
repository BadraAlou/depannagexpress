// services/api_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:depannagexpress/models/commande_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;


class ApiService {
  // //final String baseUrl = 'http://localhost:8000';
  // final String baseUrl = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000';
  final String baseUrl = 'https://depannage-xpress.com';

  // //Future<List<Pack>> fetchPacks() async {
  // Future<List<Pack>> fetchPacks() async {
  //   String url = '$baseUrl/api/packs/';
  //   var cacheManager = DefaultCacheManager(); // Créez un gestionnaire de cache par défaut
  //
  //   //FileInfo fileInfo = await cacheManager.getFileFromCache(url); // Vérifiez s'il y a une réponse mise en cache
  //   FileInfo? fileInfo = await cacheManager.getFileFromCache(url); // Vérifiez s'il y a une réponse mise en cache
  //
  //   if (fileInfo != null && !fileInfo.validTill.isBefore(DateTime.now())) {
  //     // Si la réponse est en cache et n'a pas expiré, utilisez-la
  //     var cachedData = await fileInfo.file.readAsString();
  //     List<dynamic> packsJson = json.decode(cachedData)['results'];
  //     return packsJson.map((pack) => Pack.fromJson(pack)).toList();
  //   } else {
  //     // Sinon, faites une requête HTTP pour récupérer les données et mettez-les en cache
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       print('*** yo response: ${response.body}');
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //       List<dynamic> packsJson = jsonResponse['results'];
  //
  //       // Mettez les données en cache pour une utilisation future
  //       cacheManager.putFile(url, utf8.encode(response.body));
  //
  //       return packsJson.map((pack) => Pack.fromJson(pack)).toList();
  //     } else {
  //       throw Exception('Failed to load packs');
  //     }
  //   }
  // }

  // Future<bool> createReservation(Reservation reservation) async {
  //   print('*** Reservation Création: ${reservation.firstName}');
  //   print('*** Reservation Création: ${json.encode(reservation.toJson())}');
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/api/reservations/'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(reservation.toJson()),
  //   );
  //
  //   return response.statusCode == 201;
  // }


  Future<Commande> createCommande(Commande commande) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/commandes/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commande.toJson()),
    );

    if (response.statusCode == 201) {
      return Commande.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create commande');
    }
  }


}
