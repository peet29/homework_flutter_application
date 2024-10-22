import 'package:flutter/material.dart';
import 'package:homework_flutter_application/controller/main_controller.dart';
import 'package:homework_flutter_application/widgets/fibonacci_list.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final MainController controller = MainController()..generateItems(50);

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fibonacci List'),
        ),
        body: FibonacciList(
          controller: controller,
        ),
      ),
    );
  }
}
