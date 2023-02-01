import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/track_catagory_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/home_page.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TrackCatagoryController());
    Get.put(SongController());
    Get.put(PlayerController([]));
    Get.put(QuerySongs());
    return RepositoryProvider(
      create: (context) => QuerySongs(),
      child: GetMaterialApp(
        title: 'Music Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MyColors.primaryColor,
        ),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: (() => const HomePage())),
        ],
      ),
    );
  }
}
