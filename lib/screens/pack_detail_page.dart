import 'package:flutter/material.dart';

class PackDetailPage extends StatefulWidget {
  const PackDetailPage({super.key});

  @override
  State<PackDetailPage> createState() => _PackDetailPageState();
}

class _PackDetailPageState extends State<PackDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pack Detail'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: ListView(
            children: [
              Image(
                image: AssetImage("assets/image1.jpg"),
                //width: 200,
                height: 200,
                alignment: Alignment.center,
              ),
              ListTile(
                title: Text(
                    'Pack: Lafia',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Divider(height: 0.5,color: Colors.red,),
              ),
              ListTile(
                title: Text(
                  'Désignation: Un Mariage Parfait',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Divider(height: 0.5,color: Colors.red,),
              ),
              ListTile(
                title: Text(
                  'Prix: 2 000 000 fcfa',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Divider(height: 0.5,color: Colors.red,),
              ),
              ListTile(
                title: Text(
                  'Details: ',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60, left: 60),
                child: Divider(height: 0.5,color: Colors.red,),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      'Ce pack est conçu pour un mariage parfait. Payez Juste et Laissez nous organisé un mariage idéal pour vous.\n'
                          'Décoration, Dîner, Repas de Mariage, Gâteau,..., et plus encore',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
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
