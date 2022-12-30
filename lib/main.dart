import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.primaryColor,
      ),
      home: const PlayingPage(),
      // home: const TrackListPage(
      //   title: 'Track List',
      // ),
    );
  }
}
