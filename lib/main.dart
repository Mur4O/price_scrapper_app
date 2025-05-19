import 'package:flutter/material.dart';
import 'dart:async';


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

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final double textSize = 22;
  final double videocardTextSize = 20;

  final int itemCount = 3;

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
                      Image.asset('assets/vidyaha.png'),
                      Text(
                        'Видеокарта MSI NVIDIA GeForce RTX 5070 RTX 5070 12G GAMING TRIO OC 12ГБ Gaming Trio, GDDR7, OC, Ret',
                        style: TextStyle(fontSize: videocardTextSize),
                      ),
                      Text(
                        '81 000₽',
                        style: TextStyle(fontSize: textSize),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Точка входа
void main() async {
  runApp(Home());
}