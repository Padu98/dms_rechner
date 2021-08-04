import 'dart:io';
import 'package:dms_rechner/Data/Datenbank/database_helper.dart';
import 'package:dms_rechner/state_management/schwimmerliste_bs.dart';
import 'package:dms_rechner/state_management/veraenderter_schwimmer_bs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:observable_pattern/observable_pattern.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

import '../main.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  List<Map> strecken = [];
  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String _value = "weiblich";
  MediaQueryData queryData;

  final schwimmerListeTemp = getSchwimmerListe.get<SchwimmerListeMarker>();
  final getStrecken = getVeraenderterSchwimmer.get<VeraenderterSchwimmerMarker>();



  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double space = queryData.size.width / 30;

    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            strokeButton("Schmetterling", space, context),
            SizedBox(
              height: 10,
            ),
            strokeButton("Rücken", space, context),
            SizedBox(
              height: 10,
            ),
            strokeButton("Brust", space, context),
            SizedBox(
              height: 10,
            ),
            strokeButton("Kraul", space, context),
            SizedBox(
              height: 10,
            ),
            strokeButton("Lagen", space, context),
            SizedBox(
              height: 10,
            ),
            chooseSex(),
            SizedBox(
              height: 5,
            ),
            safeSwimmer(context)
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/water_image.jpg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }



  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
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
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Name",
        helperText: "Name can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }


  Widget strokeButton(String text, double space, BuildContext context) {  //Button der Fenster öffnet um Strecken zu initialisieren
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(space, space, space, space),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      color: Theme
          .of(context)
          .buttonColor,
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    //Color(0xFF477902),// Theme.of(context).buttonColor,
                    fontSize: 18,
                    letterSpacing: 1.5
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,

              ))
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/"+text);
      },
    );
  }

  Widget chooseSex(){
    return Row(
      children: [
        Container(
          child: DropdownButton(
            items: [
              DropdownMenuItem(
                value: "weiblich",
                child: Text(
                    "weiblich"
                ),

              ),
              DropdownMenuItem(
                value: "männlich",
                child: Text(
                    "männlich"
                ),

              )
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            value: _value,
          ),
        )
      ],
    );
  }

  Widget safeSwimmer(BuildContext context){ //2 Button über die man den schwimmer speichern oder verwerfen kann
    queryData = MediaQuery.of(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ElevatedButton(
              onPressed: () {
                getStrecken.setZero();
                print("Es wurde nichts verändert.");
                Navigator.pushNamed(context, "/swimmers");
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
        ),
        Expanded(
          flex: 1,
          child: StreamBuilder(
            stream: schwimmerListeTemp.swimmerMarkerStream$,
            builder: (context, snapshot) {
              List<Map> val1 = [];

              if(!snapshot.hasData){
                val1 = null;
                print('still waiting for data...');
              }
              else if(snapshot.hasData){
                val1 = snapshot.data;
              }
              // soll in dem Fall nur setState ersetzen???

              return Padding(
                padding: const EdgeInsets.all(2),
                child: StreamBuilder(
                  stream: getStrecken.changedSwimmerMarkerStream$,
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
                      onPressed: () async {
                        bool contains = false;
                        for(int i = 0; i<val1.length; i++){
                          if(val1.elementAt(i)["name"] == _name.text){
                            contains = true;
                            break;  //Wenn Schwimmer schon erstellt
                          }
                        }

                        if(contains){
                          Fluttertoast.showToast(
                              msg: "Der Schwimmer existiert bereits.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          //Toast ausgeben oder so
                        }else {
                          //if(globals.schwimmerListe.contains(element))

                          int temp = await DatabaseHelper.instance.insert({
                            'id': _name.text,
                            'name': _name.text,
                            'sex': _value,
                            '_50s': val["50s"],
                            '_100s': val["100s"],
                            '_200s': val["200s"],
                            '_50r': val["50r"],
                            '_100r': val["100r"],
                            '_200r': val["200r"],
                            '_50b': val["50b"],
                            '_100b': val["100b"],
                            '_200b': val["200b"],
                            '_50f': val["50k"],
                            '_100f': val["100k"],
                            '_200f': val["200k"],
                            '_400f': val["400k"],
                            '_800f': val["800k"],
                            '_1500f': val["1500k"],
                            '_100l': val["100l"],
                            '_200l': val["200l"],
                            '_400l': val["400l"],
                            'userImg': "water_image.jpg"
                          });
                          getStrecken.setZero();
                          List<Map<String,
                              dynamic>> swimmerListNew = await DatabaseHelper
                              .instance.queryAll();
                          schwimmerListeTemp.addSwimmer(swimmerListNew);
                          Navigator.pushNamed(context, "/swimmers");
                          // muss noch befüllt werden
                        }
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
              );
            }
          ),
        ),

      ],
    );
  }


}


