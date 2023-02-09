import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

import '../../controller/play_list_controller.dart';
import '../../controller/player_controller.dart';
import '../../services/query_songs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final permissionController = Get.find<SongController>();

  @override
  void initState() {
    super.initState();
    _navigatToHomeScreen();
  }

  _navigatToHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    (permissionController.permission.value) ? Get.offAllNamed('/home') : null;
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
