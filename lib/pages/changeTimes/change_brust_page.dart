import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/main.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class ChangeBrust extends StatefulWidget {
  const ChangeBrust({Key key}) : super(key: key);


  @override
  _ChangeBrustState createState() => _ChangeBrustState();
}


class _ChangeBrustState extends State<ChangeBrust> {
  final changeStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();

  TextEditingController _50b = TextEditingController();
  TextEditingController _100b = TextEditingController();
  TextEditingController _200b = TextEditingController();

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
          "Zeiten Brust",
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
                    nameTextField(_50b, "50 Brust", val["50b"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_100b, "100 Brust", val["100b"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_200b, "200 Brust", val["200b"]),
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
                      if(_50b.text != "0")
                        val["50b"] = _50b.text;
                      if(_100b.text != "0")
                        val["100b"] = _100b.text;
                      if(_200b.text != "0")
                        val["200b"] = _200b.text;
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