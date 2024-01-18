import 'package:adder_app/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adder App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}