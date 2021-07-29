import 'package:flutter/material.dart';
import 'package:dms_rechner/menu/navigatioin.dart';
import 'package:dms_rechner/pages/stats_page.dart';
import 'package:dms_rechner/pages/swimmers_page.dart';
import 'package:dms_rechner/pages/teams_home_page.dart';
import 'package:dms_rechner/pages/first_team_page.dart';
import 'package:dms_rechner/Data/thme.dart';

void main() {
  runApp(DmsRechner());
}

class DmsRechner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Effective geo" ,
      theme: cleanThemeData,
      //initialRoute: '/navigation',


      routes: {
        '/': (context) => Navigation(),//Loading(), //hoffe des funktioniert auch
        '/home': (context) => Home(), //Stern
        '/statistics': (context) => Stats(),
        '/firsTeam': (context) => FirstTeam(),
        '/swimmers': (context) => Swimmers(),
        //'/statistics':(context) => Statistics(),

      },
    );
  }

}

