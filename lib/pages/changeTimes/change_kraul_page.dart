import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/main.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class ChangeKraul extends StatefulWidget {
  const ChangeKraul({Key key}) : super(key: key);


  @override
  _ChangeKraulState createState() => _ChangeKraulState();
}


class _ChangeKraulState extends State<ChangeKraul> {
  final changeStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();

  TextEditingController _50f = TextEditingController();
  TextEditingController _100f = TextEditingController();
  TextEditingController _200f = TextEditingController();
  TextEditingController _400f = TextEditingController();
  TextEditingController _800f = TextEditingController();
  TextEditingController _1500f = TextEditingController();

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
          "Zeiten Freistil",
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
                    nameTextField(_50f, "50 Freistil", val["50k"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_100f, "100 Freistil", val["100k"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_200f, "200 Freistil", val["200k"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_400f, "400 Freistil", val["400k"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_800f, "800 Freistil", val["800k"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_1500f, "1500 Freistil", val["1500k"]),
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
                      if(_50f.text != "0")
                        val["50k"] = _50f.text;
                      if(_100f.text != "0")
                        val["100k"] = _100f.text;
                      if(_200f.text != "0")
                        val["200k"] = _200f.text;
                      if(_400f.text != "0")
                        val["400k"] = _400f.text;
                      if(_800f.text != "0")
                        val["800k"] = _800f.text;
                      if(_1500f.text != "0")
                        val["1500k"] = _1500f.text;
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