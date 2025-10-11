import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:price_scrapper_app/category.dart';

// import 'dart:developer' show log;
import 'package:material_symbols_icons/symbols.dart';

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

  final TextStyle TextStyle20 = TextStyle(
    fontSize: 20,
    color: Color(0xFFFFFFFF),
  );
  final TextStyle TextStyle18 = TextStyle(
    fontSize: 20,
    color: Color(0xFFFFFFFF),
  );

  final List<String> _options = ['Опция 1', 'Опция 2', 'Опция 3', 'Опция 4'];
  String? _selectedValue;

  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  // Функция что выполняет запрос и полученный json парсит в список
  static Future<List<Category>> getCategoryList() async {
    var url = Uri.parse('http://10.0.2.2:5000/getCategories');
    final response = await http.get(url);
    final List body = json.decode(response.body);
    // log(
    //   "Log Event",
    //   name: "buttonLog",
    //   error: body.map((e) => Category.fromJson(e)).toList(),
    // );
    return body.map((e) => Category.fromJson(e)).toList();
  }

  // Вызов функции, кэширование результата запроса
  Future<List<Category>> categoryFuture = getCategoryList();

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                child: ListView(
                  children: [
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedValue,
                      // текущее выбранное значение
                      hint: Text('Выберите опцию'),
                      // подсказка, если ничего не выбрано
                      onChanged: (String? newValue) {
                        // Вызывается при выборе нового значения
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items:
                          _options.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            // Создаём элементы списка
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),

              // Выпадающее меню
              Container(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // закрывает Drawer
                    // Здесь можно применить фильтры
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF), // фиолетовый цвет
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Применить',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
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
                      "http://10.0.2.2:5000/assets/${category.imagePath}",
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
                              style: TextStyle20,
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
                      style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                        style: TextStyle20,
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
                            style: TextStyle18,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            category.mediumPrice ?? 'No data',
                            style: TextStyle20,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    Container(
                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFFF7B54),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Список\nпредложений',
                          style: TextStyle18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
