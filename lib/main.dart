import 'package:flutter/material.dart';
import 'package:price_scrapper_app/list_of_categories.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String uniqueId = Uuid().v4();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

// Главный экран
class HomeState extends State<Home> {
  static String serverAddress = 'https://api.randomwordcombination.com/a18600cc-13c0-40a2-9e48-81b7efc5854b';

  Future<bool> _createSession() async {
    try {
      String uri = '$serverAddress/createSession?sessionId=$uniqueId';
      var url = Uri.parse(uri);

      await http
          .post(url)
          .timeout(Duration(seconds: 10));

      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
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
