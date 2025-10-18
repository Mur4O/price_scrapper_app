import 'package:flutter/material.dart';
import 'package:price_scrapper_app/list_of_categories.dart';
import 'package:price_scrapper_app/list_of_products.dart';
import 'package:price_scrapper_app/error_page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
// import 'dart:developer';

String uniqueId = Uuid().v4();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

// Главный экран
class HomeState extends State<Home> {
  static String serverAddress = '100.98.58.69';

  Future<bool> _createSession() async {
    String uri = 'http://$serverAddress:8000/createSession?sessionId=$uniqueId';
    var url = Uri.parse(uri);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

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
            return ListOfCategories();
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
