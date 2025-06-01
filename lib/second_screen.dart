import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final double textSize = 22;
  final double videocardTextSize = 20;

  final int itemCount = 50;

  String name = '';
  String price = '';
  List elems = [];

  Future fetchData(int index) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/text'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data[index]['description']);
      // return [data[index]['description'], data[index]['price']];
      name = data[index]['description'];
      price = data[index]['price'];
    } else {
      print("Ошибка загрузки данных");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return FutureBuilder (
                future: fetchData(index),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Если произошла ошибка, показываем сообщение об ошибке
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  } else if (snapshot.hasData) {

                  }

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                    child: Container(
                      width: 100,
                      height: 350,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image.asset('assets/vidyaha.png'),
                          SizedBox(
                            child: Image.network("http://10.0.2.2:5000/assets/$index"),
                          ),
                          Text(
                            name,
                            style: TextStyle(fontSize: videocardTextSize),
                          ),
                          Text(
                            price,
                            style: TextStyle(fontSize: textSize),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}