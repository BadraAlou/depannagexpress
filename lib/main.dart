import 'package:depannagexpress/data_handler/appData.dart';
import 'package:depannagexpress/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        //return MaterialApp(
        return ChangeNotifierProvider(
          create: (context) => AppData(),
          child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true,
            ),
            home: IntroScreen(),
            // home: FirebaseAuth.instance.currentUser != null
            //     ? const MainMenuPage() : const LoginPage()
            // ,
          ),
        );

      },
      //child: const MyHomePage(title: 'Arctec Archi'),
      //child: const ExpansionPanelTest(),
    );
  }
}

