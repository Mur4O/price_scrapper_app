import 'package:flutter/material.dart';
import 'first_screen.dart';
import 'second_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Главный экран
class _HomeState extends State<Home> {
  @override

  List<Widget> pages = [
    FirstScreen(),
    SecondScreen()
  ];

  int _pageindex = 0;

  void _updatePage() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: pages.elementAt(_pageindex),
        bottomNavigationBar: BottomAppBar(
          // height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.ads_click), onPressed: () {_pageindex = 0; _updatePage();}),
              IconButton(icon: Icon(Icons.search), onPressed: () {_pageindex = 1; _updatePage();}),
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            ],
          ),
        )
      )
    );
  }
}

// Точка входа
void main() async {
  runApp(Home());
}