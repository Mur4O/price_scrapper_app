import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFF2A2A3C),
      child: Center(
        child: Text(
          'Возникла ошибка, перезагрузите приложение'
        ),
      ),
    );
  }
}
