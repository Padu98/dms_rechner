import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/widgets/profile_widget.dart';

//Seite auf der einzelne Schwimmer erstell bzw geupdated werden. Verändert werden können
//Strecken, Name, Geschlecht und ProfilBild.

class SingleSwimmer extends StatefulWidget {
  const SingleSwimmer({Key key}) : super(key: key);

  @override
  _SingleSwimmerState createState() => _SingleSwimmerState();
}

class _SingleSwimmerState extends State<SingleSwimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Schwimmer konfigurieren",
          style: TextStyle(
              color: Theme.of(context).primaryColor
          ),
        ),
      ),
      body: CreateProfile(),
    );
  }
}
