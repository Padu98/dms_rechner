import 'package:dms_rechner/Data/Datenbank/database_helper.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

void getData() async{
  List<Map<String, dynamic>> swimmerList = await DatabaseHelper.instance.queryAll();
  globals.schwimmerListe = swimmerList;
}