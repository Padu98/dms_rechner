import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/main.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class ChangeBack extends StatefulWidget {
  const ChangeBack({Key key}) : super(key: key);


  @override
  _ChangeBackState createState() => _ChangeBackState();
}

class _ChangeBackState extends State<ChangeBack> {
  final changeStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();

  TextEditingController _50r = TextEditingController();
  TextEditingController _100r = TextEditingController();
  TextEditingController _200r = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Zeiten Rücken",
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
                    nameTextField(_50r, "50 Rücken", val["50r"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_100r, "100 Rücken", val["100r"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_200r, "200 Rücken", val["200r"]),
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
                      if(_50r.text!="0")
                        val["50r"] = _50r.text;
                      if(_100r.text!="0")
                        val["100r"] = _100r.text;
                      if(_200r.text!="0")
                        val["200r"] = _200r.text;
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