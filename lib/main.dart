import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/animate_notch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimatedNotch(),
    );
  }
}
