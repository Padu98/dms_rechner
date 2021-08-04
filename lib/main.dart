import 'package:dms_rechner/Data/getData.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/menu/navigation.dart';
import 'package:dms_rechner/pages/stats_page.dart';
import 'package:dms_rechner/pages/swimmers_page.dart';
import 'package:dms_rechner/pages/teams_home_page.dart';
import 'package:dms_rechner/pages/first_team_page.dart';
import 'package:dms_rechner/Data/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:dms_rechner/state_management/schwimmerliste_bs.dart';
import 'package:dms_rechner/pages/single_swimmer_page.dart';
import 'package:dms_rechner/pages/changeTimes/change_schmett_page.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/pages/changeTimes/change_ruecken_page.dart';
import 'package:dms_rechner/pages/changeTimes/change_brust_page.dart';
import 'package:dms_rechner/pages/changeTimes/change_kraul_page.dart';
import 'package:dms_rechner/pages/changeTimes/change_lagen_page.dart';

//global ServiceLocator
GetIt getSchwimmerListe = GetIt.instance;
GetIt getVeraenderterSchwimmer = GetIt.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  getVeraenderterSchwimmer.registerSingleton<VeraenderterSchwimmerMarker>(VeraenderterSchwimmerMarker());
  final strecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();
  strecken.setZero(); //Zu begiin müssen alle Strecken auf 0 gesetzt werden

  await getData(); //in get Data wird SchwimmerListe initialisiert bevor das bs auf den entsprechenden Wert geseeded wird
  getSchwimmerListe.registerSingleton<SchwimmerListeMarker>(SchwimmerListeMarker()); //Counter Variable, die sich die Liste mit den Schwimmern merkt
  runApp(DmsRechner());
}

class DmsRechner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Effective geo" ,
      theme: cleanThemeData,
      initialRoute: '/singleSwimmer', //zum Debuggen später rausnehmen


      routes: {
        '/': (context) => Navigation(),//Loading(), //hoffe des funktioniert auch
        '/home': (context) => Home(), //Stern
        '/statistics': (context) => Stats(),
        '/firsTeam': (context) => FirstTeam(),
        '/swimmers': (context) => Swimmers(),
        '/singleSwimmer': (context) => SingleSwimmer(),
        '/Schmetterling': (context) => ChangeFly(),
        //'/statistics':(context) => Statistics(),
        '/Rücken': (context) => ChangeBack(),
        '/Brust': (context) => ChangeBrust(),
        '/Kraul': (context) => ChangeKraul(),
        '/Lagen': (context) => ChangeIM()
      },
    );
  }

}

