import 'package:depannagexpress/controllers/map_controller.dart';
import 'package:depannagexpress/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/commande_model.dart';


class AddNewCommandeForm extends StatefulWidget {
  @override
  _AddNewCommandeFormState createState() => _AddNewCommandeFormState();
}

class _AddNewCommandeFormState extends State<AddNewCommandeForm> {
  final _formKey = GlobalKey<FormState>();
  MapController mapController = Get.put(MapController());

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _distanceValueController = TextEditingController();
  final TextEditingController _distanceTextController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _latitudeController.text = '${mapController.globalPickUpAdresse.value.latitude}';
    _longitudeController.text = '${mapController.globalPickUpAdresse.value.longitude}';
    _distanceValueController.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Ajouter Commande'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Veuillez entrer un nom';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: _departController,
                  decoration: InputDecoration(labelText: 'Téléphone'),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Veuillez entrer un départ';
                  //   }
                  //   return null;
                  // },
                ),
                // TextFormField(
                //   controller: _destinationController,
                //   decoration: InputDecoration(labelText: 'Destination'),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Veuillez entrer une destination';
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: _latitudeController,
                  decoration: InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Veuillez entrer une latitude';
                  //   }
                  //   if (double.tryParse(value) == null) {
                  //     return 'Veuillez entrer un nombre valide';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: _longitudeController,
                  decoration: InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Veuillez entrer une longitude';
                  //   }
                  //   if (double.tryParse(value) == null) {
                  //     return 'Veuillez entrer un nombre valide';
                  //   }
                  //   return null;
                  // },
                ),
                // TextFormField(
                //   controller: _distanceValueController,
                //   decoration: InputDecoration(labelText: 'Distance Value'),
                //   keyboardType: TextInputType.number,
                //   // validator: (value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return 'Veuillez entrer une valeur de distance';
                //   //   }
                //   //   if (double.tryParse(value) == null) {
                //   //     return 'Veuillez entrer un nombre valide';
                //   //   }
                //   //   return null;
                //   // },
                // ),
                // TextFormField(
                //   controller: _distanceTextController,
                //   decoration: InputDecoration(labelText: 'Distance Text'),
                //   // validator: (value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return 'Veuillez entrer un texte de distance';
                //   //   }
                //   //   return null;
                //   // },
                // ),
                // TextFormField(
                //   controller: _detailsController,
                //   decoration: InputDecoration(labelText: 'Details'),
                //   // validator: (value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return 'Veuillez entrer des détails';
                //   //   }
                //   //   return null;
                //   // },
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Commande newCommande = Commande(
                        nom: _nomController.text,
                        depart: _departController.text,
                        destination: _destinationController.text,
                        latitude:  double.parse(_latitudeController.text),
                        longitude: double.parse(_longitudeController.text),
                        distanceValue: double.parse(_distanceValueController.text),
                        distanceText: _distanceTextController.text,
                        details: _detailsController.text,
                      );

                      try {
                        //await ApiService().createCommande(newCommande);
                        ApiService().createCommande(newCommande);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Commande ajoutée avec succès')));


                      } catch (e) {
                        print('*** Yo erreur : ${e}');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Effectuer !')));
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
