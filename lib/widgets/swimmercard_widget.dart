import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwimmerCard extends StatelessWidget {

  final int index;
  final List<Map> swimmers;
  SwimmerCard({this.index, this.swimmers});


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double spaceOne = queryData.size.height/5;
    Map singleSwimmer = swimmers[index];
    return GestureDetector(

      onTap: () {
       // Navigator.of(context).push(MaterialPageRoute(
       //     builder: (context){
       //       return  null;//Country(index: index, filteredCountriesEnglish: filteredCountriesEnglish,);
      //      }
       // )
       // );
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        //shadowColor: Colors.black,
        margin: EdgeInsets.fromLTRB(4, 4, 4, 4),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                  children: [
                    Expanded(
                      flex: 10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipOval(
                            child: Image.asset(singleSwimmer["userImg"]),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 10,
                      child: Center(
                        // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          singleSwimmer["name"],
                          style: TextStyle(
                              color: Theme.of(context).buttonColor,
                              fontSize: 17,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey[800],
                      ),
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
