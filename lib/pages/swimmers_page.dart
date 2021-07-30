import 'package:dms_rechner/widgets/swimmercard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dms_rechner/Data/globals.dart' as globals;

class Swimmers extends StatefulWidget {
  @override
  _SwimmersState createState() => _SwimmersState();
}

class _SwimmersState extends State<Swimmers> {

  TextEditingController _textController = TextEditingController();
  List<Map> filterSwimmer = [];

  // List<dynamic> countriesEnglishCopy = List.from(countriesEnglish);
  // filteredCountriesEnglish = List.from(countriesEnglish);

  onItemChanged(String value) {
    setState(() {
      filterSwimmer = globals.schwimmerListe
          .where((string) => string["name"].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        brightness: Brightness.dark,
        title:  Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(

            children: [
              Expanded(
                flex: 5,
                child: TextField(
                controller: _textController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _textController.clear();
                      onItemChanged("");
                    },
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).buttonColor),
                  ),
                ),
                onChanged: onItemChanged,
            ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  color: Colors.grey[800],
                    icon: Icon(
                      Icons.group_add,
                      color: Colors.white,
                    ),
                    onPressed: (){

                    }
                    ),
              )
          ]
          ),
        ),
      ),

      body: SafeArea(
        child: ListView.builder(
          itemCount: globals.schwimmerListe.length,
          itemBuilder: (context, index){
            return SwimmerCard(index: index, swimmers: globals.schwimmerListe);
          },
        ),
      ),
    );
  }
}


