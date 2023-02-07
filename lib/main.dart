import 'package:flutter/material.dart';
import 'package:mucic_store/controller/app_controllers.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music Store',
      initialBinding: AppControllers(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      theme: ThemeData(
        primarySwatch: MyColors.primaryColor,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: (() => HomePage())),
        //  GetPage(name: "/", page: (() => const HomePage())),
      ],
    );
  }
}
