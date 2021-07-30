import 'package:flutter/material.dart';

ThemeData cleanThemeData = ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Color(0xFF002752),
    bottomAppBarColor: Colors.white, //grey[800],  //Farbe für unteren Balken bei abfrage (hard/good/easy)
    brightness: Brightness.light,
    accentColor: Colors.grey,
    cardColor: Colors.white,
    buttonColor: Color(0xFF001D3D),  //wird für alle Texte verwendet
    indicatorColor: Colors.grey,//wird für Progress Balken in home verwendet
    focusColor: Colors.grey[900],  // Navigation bar icons


    textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
          letterSpacing: 1.5,
        ),
        headline2: TextStyle(
          fontSize: 15,
          color: Colors.grey[900],
          letterSpacing: 1.5,
        ),
        headline3: TextStyle(
          fontSize: 23,
          color: Colors.grey[900],
          letterSpacing: 1.5,

        ),
        headline4: TextStyle(
          fontSize: 20,
          color: Colors.grey[900],
          letterSpacing: 1.5,
        ),
        headline5: TextStyle(
          fontSize: 15,
          color: Colors.grey[900],
          letterSpacing: 1.5,
        )
    )
);