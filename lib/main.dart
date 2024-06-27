// En main.dart
import 'package:flutter/material.dart';
import 'cliente_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App de Clientes',
      home: ClienteListScreen(),
    );
  }
}