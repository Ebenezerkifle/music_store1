import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatToHomeScreen();
  }

  _navigatToHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        body: Center(
          child: Image(
              width: MediaQuery.of(context).size.width * 0.5,
              image: const AssetImage('assets/images/defaultpic.jpg')),
        ));
  }
}
