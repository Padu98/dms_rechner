import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:dms_rechner/main.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class ChangeIM extends StatefulWidget {
  const ChangeIM({Key key}) : super(key: key);


  @override
  _ChangeIMState createState() => _ChangeIMState();
}


class _ChangeIMState extends State<ChangeIM> {
  final changeStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();

  TextEditingController _100l = TextEditingController();
  TextEditingController _200l = TextEditingController();
  TextEditingController _400l = TextEditingController();

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
          "Zeiten Lagen",
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
                    nameTextField(_100l, "100 Lagen", val["100l"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_200l, "200 Lagen", val["200l"]),
                    SizedBox(
                      height: 20,
                    ),
                    nameTextField(_400l, "400 Lagen", val["400l"]),
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
                      if(_100l.text != "0")
                        val["100l"] = _100l.text;
                      if(_200l.text != "0")
                        val["200l"] = _200l.text;
                      if(_400l.text != "0")
                        val["400l"] = _400l.text;
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