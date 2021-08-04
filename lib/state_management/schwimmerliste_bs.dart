import 'package:rxdart/rxdart.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class SchwimmerListeMarker {
  BehaviorSubject _swimmerMarker = BehaviorSubject.seeded(globals.schwimmerListe);  //shared prefs müssen beigefügt werden !
  Stream get swimmerMarkerStream$ => _swimmerMarker.stream;
  bool get currentTheme => _swimmerMarker.value;

  addSwimmer(var swimmerList){
    _swimmerMarker.add(swimmerList);
    //Zeilen um Schwimmer auch der Datenbank hinzuzufügen fehlen noch!
  }

  deleteSwimmer(var swimmer){
    if(globals.schwimmerListe.contains(swimmer))
      print(globals.schwimmerListe.remove(swimmer));
      //Zeilen um Schwimmer aus der Datenbank zu entfernen fehlen noch!
    print("no swimmer found");

  }


}