import 'package:dms_rechner/pages/stats_page.dart';
import 'package:dms_rechner/pages/swimmers_page.dart';
import 'package:dms_rechner/pages/teams_home_page.dart';
import 'package:dms_rechner/pages/first_team_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 1;

  void _onItemClick(int idx) {
    setState(() {
      currentIndex = idx;
    });
  }

  List<Widget> routeList = <Widget>[
    FirstTeam(),
    Home(),
    Swimmers(),
    Stats()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: routeList[currentIndex],
        backgroundColor: Theme.of(context).bottomAppBarColor,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemClick,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          selectedItemColor: Theme.of(context).focusColor,
          unselectedItemColor: Colors.grey[500],

          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.star,
                color: Theme.of(context).focusColor,
                size: 25, //size rausnehmen
              ),
              icon: Icon(
                Icons.star,
                color: Colors.grey[500], //Theme.of(context).primaryColor,
                size: 16,
              ),
              label: "team",
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).focusColor,
                  size: 25, //size rausnehmen
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.grey[500], //Theme.of(context).primaryColor,
                  size: 16,
                ),
                label: "home"),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.group_add,
                  color: Theme.of(context).focusColor,
                  size: 25, //size rausnehmen
                ),
                icon: Icon(
                  Icons.group_add,
                  color: Colors.grey[500], //Theme.of(context).primaryColor,
                  size: 16,
                ),
                label: "swimmer"),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.bar_chart,
                  color: Theme.of(context).focusColor,
                  size: 25, //size rausnehmen
                ),
                icon: Icon(
                  Icons.bar_chart,
                  color: Colors.grey[500], //Theme.of(context).primaryColor,
                  size: 16,
                ),
                label: "stats")
          ],
        ));
  }
}