import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:price_scrapper_app/list_of_categories.dart';
import 'package:price_scrapper_app/error_page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

String uniqueId = Uuid().v4();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

// Главный экран
class HomeState extends State<Home> {
  static String serverAddress = 'https://api.randomwordcombination.com';

  Future<bool> _createSession() async {
    // String uri = '$serverAddress/createSession?sessionId=$uniqueId';
    // var url = Uri.parse(uri);
    // debugPrint(uri);
    // final response = await http.post(url);
    // debugPrint(uri);
    // debugPrint('${response.statusCode}');
    // // log(
    // //   "Log Event",
    // //   name: "buttonLog",
    // //   error: uri,
    // // );
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }

    try {
      String uri = '$serverAddress/createSession?sessionId=$uniqueId';
      var url = Uri.parse(uri);

      debugPrint(uri);

      final response = await http
          .post(url)
          .timeout(Duration(seconds: 20));

      debugPrint("AFTER REQUEST");
      debugPrint('${response.statusCode}');

      return true;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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
          } else if (snapshot.data == false) {
            // return ErrorPage();
            return Container(
              color: Color(0xFF2A2A3C),
              child: Center(
                child: Text(
                  'Возникла ошибка, перезагрузите приложение'
                ),
              ),
            );
          } else {
            return Container(
              color: Color(0xFF2A2A3C),
              child: Center(
                child: CircularProgressIndicator()
              )
            );
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
