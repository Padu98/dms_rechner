import 'package:rxdart/rxdart.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class VeraenderterSchwimmerMarker {
  BehaviorSubject _changedSwimmerMarker = BehaviorSubject.seeded(globals.aktuellVeraenderterSchwimmer);
  Stream get changedSwimmerMarkerStream$ => _changedSwimmerMarker.stream;
  bool get currentTheme => _changedSwimmerMarker.value;

  setSchwimmerStrecken(var map){
    _changedSwimmerMarker.add(map);
    //Zeilen um Schwimmer auch der Datenbank hinzuzufügen fehlen noch!
  }

  setZero(){
    Map temp = {
    "50s":"0",
    "100s":"0",
    "200s":"0",
    "50r":"0",
    "100r":"0",
    "200r":"0",
    "50b":"0",
    "100b":"0",
    "200b":"0",
    "50k":"0",
    "100k":"0",
    "200k":"0",
    "400k":"0",
    "800k":"0",
    "1500k":"0",
    "100l":"0",
    "200l":"0",
    "400l":"0" };
    _changedSwimmerMarker.add(temp);
  }
}