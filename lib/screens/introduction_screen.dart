import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:depannagexpress/screens/main_menu_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

// class IntroScreen extends StatefulWidget {
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//   // 1. Define a `GlobalKey` as part of the parent widget's state
//   final _introKey = GlobalKey<IntroductionScreenState>();
//   String _status = 'Waiting...';
//
//   @override
//   Widget build(BuildContext context) {
//     return IntroductionScreen(
//       // 2. Pass that key to the `IntroductionScreen` `key` param
//       key: _introKey,
//       pages: [
//         PageViewModel(
//             title: 'Page One',
//             bodyWidget: Column(
//               children: [
//                 Text(_status),
//                 ElevatedButton(
//                     onPressed: () {
//                       setState(() => _status = 'Going to the next page...');
//
//                       // 3. Use the `currentState` member to access functions defined in `IntroductionScreenState`
//                       Future.delayed(const Duration(seconds: 3),
//                               () => _introKey.currentState?.next());
//                     },
//                     child: const Text('Start'))
//               ],
//             )),
//         PageViewModel(
//             title: 'Page Two', bodyWidget: const Text('That\'s all folks'))
//       ],
//       showNextButton: false,
//       showDoneButton: false,
//     );
//   }
// }

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'DEPANNAGE X-PRESS',
              body: 'REMORQUAGE, REPARATION, ...',
              image: buildImage("assets/app_logo.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'DEPANNAGE X-PRESS',
              body: 'DEPANNAGE RAPIDE',
              image: buildImage("assets/image1.jpg"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'DEPANNAGE X-PRESS',
              body: 'UN SERVICE DE QUALITE',
              image: buildImage("assets/image2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            if (kDebugMode) {
              print("Done clicked");

            }

            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (builder) => MainMenuPage(),
            //   ),
            // );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (builder) => MainMenuPage(),
              ), (route) => false ,
            );
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          //isBottomSafeArea: true,
          skip:
          const Text("Passer", style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.forward),
          done:
          const Text("Menu", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );
  }

  //widget to add the image on screen
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
          imagePath,
          width: 450,
          height: 400,
        ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
