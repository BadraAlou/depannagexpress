import 'package:flutter/material.dart';
import 'package:depannagexpress/themes/app_theme.dart';
//import 'package:hexcolor/hexcolor.dart';

class ThemeHelper{

  //Color _primaryColor = HexColor('#011D8D');
  InputDecoration textInputDecoration([String lableText="", String hintText = "", Color? myColor, Icon? icon]){
    return InputDecoration(
      labelText: lableText,
      labelStyle: TextStyle(
          fontSize: 20.0,
          // color: _primaryColor
          color: myColor ?? MyTheme.myPrimaryColor
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 12.0,

          color: Colors.grey
      ),
      fillColor: Colors.white,
      filled: true,
      // Style du champ (lors de la saisie)

      //prefixIcon: icon ?? const Icon(Icons.add),
      prefixIcon: icon,

      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context, /*[String color1 = "", String color2 = ""]*/{Color? color }) {
    Color c1 = color ??  Theme.of(context).primaryColor;
    // Color c2 = Theme.of(context).accentColor;
    // if (color1.isEmpty == false) {
    //   c1 = HexColor(color1);
    // }
    // if (color2.isEmpty == false) {
    //   c2 = HexColor(color2);
    // }

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c1,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

}

class LoginFormStyle{

}
