import 'package:flutter/material.dart';

// Первый экран, создание StatefulWidget
class FirstScreen extends StatefulWidget {
  @override
  // Прописываем обновление состояния
  _FirstScreenState createState() => _FirstScreenState();
}

// Как раз дефолтное состояние экрана
class _FirstScreenState extends State<FirstScreen> {
  @override

  final double textSize = 22;
  int _counter = 0;
  String _submittedText = '';

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  void _updateSubmittedText(String text) {
    setState(() {
      _submittedText = "$text";
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Каждое дитё в центер чтоб по-горизонтали по центру было
          Center(
            child: Text(
                'Счётчик: $_counter', style: TextStyle(fontSize: textSize)),
          ),

          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                  child: ElevatedButton(
                    child: SizedBox(
                        width: 120,
                        height: 60,
                        child: Center(child: Text(
                            'Жми', style: TextStyle(fontSize: textSize)))
                    ),
                    onPressed: () {
                      _incrementCounter();
                    },
                  ))),

          TextButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Text(
                  'Текстовая кнопка', style: TextStyle(fontSize: textSize))
          ),

          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: SizedBox(
              width: 250.0,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите что-нибудь',
                ),
                onSubmitted: (text) {
                  _updateSubmittedText("$text");
                },
              ),
            ),
          ),

          Center(
            child: Text('Вы ввели $_submittedText',
                style: TextStyle(fontSize: textSize)),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          _incrementCounter();
        }
      )
    );
  }
}