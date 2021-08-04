import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/main.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class ChangeFly extends StatefulWidget {
  const ChangeFly({Key key}) : super(key: key);


  @override
  _ChangeFlyState createState() => _ChangeFlyState();
}


class _ChangeFlyState extends State<ChangeFly> {
  final changeStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();

  TextEditingController _50s = TextEditingController();
  TextEditingController _100s = TextEditingController();
  TextEditingController _200s = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_50s = TextEditingController(text: globals.aktuellVeraenderterSchwimmer["50s"]);
    //_100s = TextEditingController(text: globals.aktuellVeraenderterSchwimmer["100s"]);
    //_200s = TextEditingController(text: globals.aktuellVeraenderterSchwimmer["200s"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Zeiten Schmetterling",
              style: TextStyle(
                  color: Colors.black
        ),
        ),

      ),
      body: StreamBuilder(
        stream: changeStrecken.changedSwimmerMarkerStream$,
        builder: (context, snapshot) {
          Map val = globals.aktuellVeraenderterSchwimmer;
          if(!snapshot.hasData){
            print('still waiting for data...');
          }
          else if(snapshot.hasData){
            val = snapshot.data;
          }

          return Form(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
           children: <Widget>[
             nameTextField(_50s, "50 Schmetterling", val["50s"]),
             SizedBox(
               height: 20,
             ),
             nameTextField(_100s, "100 Schmetterling", val["100s"]),
             SizedBox(
               height: 20,
             ),
             nameTextField(_200s, "200 Schmetterling", val["200s"]),
             SizedBox(
               height: 20,
             ),
             safeSwimmer(context)


           ],

            )
          );
        }
      ),

    );
  }

  Widget nameTextField(TextEditingController controller, String strecke, String n) {

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.timer_rounded,
          color: Colors.green,
        ),
        labelText: n,
        helperText: "Zeit "+ strecke+ " in Sekunden eintragen.",
        hintText: "Dev Stack",
      ),
    );
  }


Widget safeSwimmer(BuildContext context){
  return Row(
    children: [
      /*Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/singleSwimmer");
              // muss noch befüllt werden
            },
            child: Text(
              "verwerfen",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor, // Colors.red,
                fontSize: 19,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Theme.of(context).primaryColor,
              //minimumSize: Size(queryData.size.width / 4 - 6, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      )*/  //,
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: StreamBuilder(
            stream: changeStrecken.changedSwimmerMarkerStream$,
            builder: (context, snapshot) {

              Map val;
              if(!snapshot.hasData){
                val = null;
                print('still waiting for data...');
              }
              else if(snapshot.hasData){
                val = snapshot.data;
              }
              return ElevatedButton(
                onPressed: () {
                  if(_50s.text != "0")
                    val["50s"] = _50s.text;
                  if(_100s.text != "0")
                    val["100s"] = _100s.text;
                  if(_200s.text != "0")
                    val["200s"] = _200s.text;
                  changeStrecken.setSchwimmerStrecken(val);
                 // Navigator.pushNamed(context, "/singleSwimmer");
                },
                child: Text(
                  "speichern",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor, // Colors.red,
                    fontSize: 19,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Theme.of(context).primaryColor,
                  //minimumSize: Size(queryData.size.width / 4 - 6, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }
          ),
        ),
      ),

    ],
  );
}
}