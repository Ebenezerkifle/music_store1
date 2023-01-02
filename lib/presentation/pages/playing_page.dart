import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/widgets/play_controller.dart';

import '../my_colors/color.dart';

class PlayingPage extends StatelessWidget {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
          title: const Center(
            child: Text("Now Playing"),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.list))
          ]),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mic.jpg"),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.47,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  'assets/images/mic.jpg',
                ),
              ),
              PlayController(iconSize: 50),
            ],
          ),
        ),
      ),
    );
  }
}
