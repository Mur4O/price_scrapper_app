import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:price_scrapper_app/category.dart';
import 'dart:developer';

// import 'dart:developer' show log;
import 'package:material_symbols_icons/symbols.dart';
import 'package:price_scrapper_app/main.dart';

// Первый экран, создание StatefulWidget
class ListOfProducts extends StatefulWidget {
  //Конструктор
  const ListOfProducts({super.key});

  @override
  // Прописываем обновление состояния
  State<ListOfProducts> createState() => _ListOfProducts();
}

// Описываем ListOfProducts
class _ListOfProducts extends State<ListOfProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Вызов функции, кэширование результата запроса
  Future<List<Category>> categoryFuture = getCategoryList();

  void refreshCategories() {
    setState(() {
      categoryFuture = getCategoryList();
    });
  }

  final List<List<String>> _options = [
    ['productName', 'Модель', ''],
    ['graphicsProcessor', 'Графический процессор', ''],
    ['memorySize', 'Объём видеопамяти', ''],
    ['memoryType', 'Тип видеопамяти', ''],
    ['busWidth', 'Ширина шины', ''],
    ['mediumPrice', 'Цена', ''],
  ];

  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  static TextStyle whiteText(double x) {
    return TextStyle(fontSize: x, color: Color(0xFFFFFFFF));
  }

  void nullFilters() {
    for (var elem in _options) {
      elem[2] = '';
    }
  }

  // Функция что выполняет запрос и полученный json парсит в список
  static Future<List<Category>> getCategoryList() async {
    var url = Uri.parse('http://192.168.57.80:8000/getCategories/$uniqueId');
    final response = await http.get(url);
    final List body = json.decode(response.body);
    // log(
    //   "Log Event",
    //   name: "buttonLog",
    //   error: body.map((e) => Category.fromJson(e)).toList(),
    // );
    return body.map((e) => Category.fromJson(e)).toList();
  }

  // По переданному имени фильтра выдаёт все уникальные значения
  static Future<List<String>> getUniqueValues(String column) async {
    var url = Uri.parse('http://192.168.57.80:8000/getUniqueValues/$uniqueId/$column');
    final response = await http.get(url);
    final List body = json.decode(response.body);
    // log(
    //   "Log Event",
    //   name: "buttonLog",
    //   error: body.map((e) => e.toString()).toList(),
    // );
    return body.map((e) => e.toString()).toList();
  }

  Future sendFilters() async {
    Map<String, String> queryBody = {};
    for (var elem in _options) {
      queryBody[elem[0]] = elem[2];
    }
    final url = Uri.parse('http://192.168.57.80:8000/filterCategories/$uniqueId');
    log(
      "http post data",
      error: queryBody
    );
    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(queryBody)
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      log("http post response", error: responseBody);
    } else {
      log("http post response", error: response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2A3C),
        toolbarHeight: 50,
        // automaticallyImplyLeading: false,
        actions: <Widget>[Container()], // Скрывает дефолтную кнопку endDrawer
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: _openDrawer,
              icon: Icon(Symbols.page_info, size: 20),
              label: Text('Фильтры', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF1E1E2E),
      body: Center(
        child: FutureBuilder(
          future: categoryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final categoryList = snapshot.data!;
              return buildCategory(categoryList);
            } else {
              return Center(child: const Text("No data available"));
            }
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFF2A2A3C),
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(_options[index][1], style: whiteText(25)),
                        ),
                        // SizedBox(height: 10),
                        FutureBuilder(
                          future: getUniqueValues(_options[index][0]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              return SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,

                                  // Означает, что виджет будет занимать только пространство внутри родителя
                                  initialValue: _options[index][2],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _options[index][2] =
                                          newValue!;
                                    });
                                  },
                                  items:
                                      snapshot.data!.map<
                                        DropdownMenuItem<String>
                                      >((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            // overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: whiteText(18),
                                          ),
                                        );
                                      }).toList(),

                                  selectedItemBuilder: (context) {
                                    return snapshot.data!.map<Widget>((
                                      String value,
                                    ) {
                                      return Text(
                                        value,
                                        style: whiteText(18),
                                        overflow: TextOverflow.ellipsis,
                                        // Обрезает текст ...
                                        maxLines: 1,
                                      );
                                    }).toList();
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: const Text("No data available"),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        sendFilters();
                        refreshCategories();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6C63FF), // фиолетовый цвет
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Применить', style: whiteText(20)),
                    ),
                  ),
                  // SizedBox(width: 15),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        nullFilters();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A3A4D), // фиолетовый цвет
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Сбросить', style: whiteText(20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // drawerEnableOpenDragGesture: false,
    );
  }

  Widget buildCategory(List<Category> categoryList) {
    return ListView.builder(
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Container(
            // width: 100,
            // height: 350,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF3A3A4D),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // width: 100,
                  // height: 350,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: SizedBox(
                    child: Image.network(
                      "http://192.168.57.80:8000/assets/${category.imagePath}",
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Center(
                            child: Text(
                              'Изображение недоступно',
                              style: whiteText(20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // Наименование
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1E1E2E),
                  ),
                  child: Center(
                    child: Text(
                      category.productName ?? 'No data',
                      style: whiteText(20),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // Строка 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.graphicsProcessor ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),

                    SizedBox(width: 8),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.memorySize ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),

                    SizedBox(width: 8),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.memoryType ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Строка 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.rops ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.tmus ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.cores ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1E1E2E),
                      ),
                      child: Text(
                        category.busWidth ?? 'No data',
                        style: whiteText(20),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Строка цена + список предложений
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF6C63FF),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Средняя цена:',
                            style: whiteText(18),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            category.mediumPrice ?? 'No data',
                            style: whiteText(20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFF7B54),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Список\nпредложений',
                            style: whiteText(20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
