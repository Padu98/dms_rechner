import 'package:flutter/material.dart';
import 'package:dms_rechner/menu/navigation.dart';
import 'package:dms_rechner/pages/stats_page.dart';
import 'package:dms_rechner/pages/swimmers_page.dart';
import 'package:dms_rechner/pages/teams_home_page.dart';
import 'package:dms_rechner/pages/first_team_page.dart';
import 'package:dms_rechner/Data/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:dms_rechner/state_management/schwimmerliste_bs.dart';

//global ServiceLocator
GetIt getSchwimmerListe = GetIt.instance;

void main() {
  getSchwimmerListe.registerSingleton<SchwimmerListeMarker>(SchwimmerListeMarker()); //Counter Variable, die sich die Liste mit den Schwimmern merkt
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

