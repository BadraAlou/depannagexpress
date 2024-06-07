import 'package:depannagexpress/screens/map_screen.dart';
import 'package:depannagexpress/screens/map_screen2.dart';
import 'package:depannagexpress/utils/add_commande_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:depannagexpress/widgets/header_widget.dart';
import 'package:depannagexpress/widgets/header_widget_new.dart';
import 'package:get/get.dart';
//import 'package:ikadjatebeta/screens/ventes_screen.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Acceuil'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        //padding: EdgeInsets.only(top: 10),
        children: [

          // Container(
          //   height: 100,
          //   child: HeaderWidgetNew(height: 100, showIcon: false, icon: Icons.home,
          //       primaryColor: Colors.blue, secondaryColor: Colors.red
          //   ), //let's create a common header widget
          // ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                //const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('DEPANNAGE XPRESS', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Bienvenue', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                   // backgroundImage: AssetImage('assets/images/user.JPG'),
                    backgroundImage: AssetImage('assets/app_logo.png'),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(200)
                      )
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => const AddCommandeForm(),
                            ),
                          );
                        },
                        child: itemDashboard('Remorquage Simple', CupertinoIcons.car, Colors.deepOrange),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(() => MapScreen2());
                        },
                        child : itemDashboard('Remorquage avec Reparation', CupertinoIcons.bus, Colors.green),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(() => MainMapScreen());
                        },
                        child: itemDashboard('Reparation Sur Place', CupertinoIcons.money_dollar_circle, Colors.purple),
                      ),

                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (builder) => FacturesScreen(),
                          //   ),
                          // );
                        },
                        child: itemDashboard(
                            'Plus',
                            CupertinoIcons.list_number, Colors.brown),
                      ),

                      // itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo),
                      // itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                      // itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                      // itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent),

                      // itemDashboard('Videos', CupertinoIcons.play_rectangle, Colors.deepOrange),
                      // itemDashboard('Analytics', CupertinoIcons.graph_circle, Colors.green),
                      // itemDashboard('Audience', CupertinoIcons.person_2, Colors.purple),
                      // itemDashboard('Comments', CupertinoIcons.chat_bubble_2, Colors.brown),
                      // itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo),
                      // itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                      // itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                      // itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20)
        ],
      ),
    );
  }


  itemDashboard(String title, IconData iconData, Color background) => Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white)
        ),
        const SizedBox(height: 8),
        Text(title.toUpperCase(),
            //style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        )
      ],
    ),
  );

}
