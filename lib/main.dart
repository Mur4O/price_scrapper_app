import 'package:flutter/material.dart';
import 'package:price_scrapper_app/list_of_products.dart';
import 'package:price_scrapper_app/error_page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' show log;

String uniqueId = Uuid().v4();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Главный экран
class _HomeState extends State<Home> {
  Future<bool> _createSession() async {
    String uri = 'http://10.0.2.2:5000/createSession?sessionGUID=$uniqueId';
    var url = Uri.parse(uri);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  List<Widget> pages = [ListOfProducts(), ErrorPage()];

  int _pageindex = 0;

  // void _updatePage() {
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: _createSession(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return pages[_pageindex];
          } else {
            return ErrorPage();
          }
        },
      ),
    );
  }
}

// Точка входа
void main() async {
  runApp(Home());
}
