import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depannagexpress/models/commande_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:depannagexpress/themes/theme_helper.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

class AddCommandeForm extends StatefulWidget {
  const AddCommandeForm({Key? key}) : super(key: key);

  @override
  _AddCommandeFormState createState() => _AddCommandeFormState();
}

class _AddCommandeFormState extends State<AddCommandeForm> {

  // FirebaseFirestore db = FirebaseFirestore.instance;
  // String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  // final bool useEmulator = true;

  TextEditingController _dateController = TextEditingController();
  //late final _clientController = TextEditingController();
  TextEditingController _clientController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double widgetSeparatorSize = 10.0;
  String todayString = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime today = DateTime.now();

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late DateTime factureDate;
   // Radio Button selected option


  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }


  // Add info to people box
  _addInfo() async {

  }


  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    //box = Hive.box('factureBox');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nouvelle Commande'),),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Form(
          key: _formKey,
          child: ListView(
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // InputDatePickerFormField(
              //
              //     firstDate: DateTime(1950),
              //     lastDate: DateTime.now()
              // ),



              TextFormField(
                controller: _dateController,
                validator: _fieldValidator,
                decoration: ThemeHelper().textInputDecoration("Date", "Choisir une date", Theme.of(context).primaryColor),
                readOnly: true,

                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now());
                  //DateTime.now() - not to allow to choose before today.
                  //lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      _dateController.text = formattedDate; //set output date to TextField value.
                      today = pickedDate;
                    });
                  } else {}
                },
              ),
              SizedBox(height: widgetSeparatorSize),
              TextFormField(
                controller: _clientController,
                validator: _fieldValidator,
                decoration: ThemeHelper().textInputDecoration("Client", "Entrez le nom du client", Theme.of(context).primaryColor),
              ),
              SizedBox(height: widgetSeparatorSize),
              TextFormField(
                controller: _adresseController,
                //keyboardType: TextInputType.number,
                validator: _fieldValidator,
                decoration: ThemeHelper().textInputDecoration("Adresse", "Entrez l'adresse du client", Theme.of(context).primaryColor),
              ),

              SizedBox(height: widgetSeparatorSize),
              TextFormField(
                controller: _detailController,
                //keyboardType: TextInputType.number,
                validator: _fieldValidator,
                decoration: ThemeHelper().textInputDecoration("Details", "Entrez les details", Theme.of(context).primaryColor),
              ),

              SizedBox(height: widgetSeparatorSize),
              //const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                child: Container(
                  width: double.maxFinite,
                  // height: 50,
                  decoration: ThemeHelper().buttonBoxDecoration(context, color: Theme.of(context).primaryColor),
                  child: ElevatedButton.icon(

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addInfo();
                        Navigator.of(context).pop();
                        //animatedListKeyDepense.currentState!.insertItem(0, duration: const Duration(seconds: 1));
                        //animatedListKeyDepense.currentState!.
                      }
                    },
                    icon: const Icon(Icons.save, color: Colors.white,),
                    label: const Text('AJOUTER', style: TextStyle(color: Colors.white),),
                    style: ThemeHelper().buttonStyle(),
                    //child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );


  }
}
