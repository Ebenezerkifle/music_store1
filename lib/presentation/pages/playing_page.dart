import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/widgets/slider.dart';

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ]),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          alignment: AlignmentDirectional.center,
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.3,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  'assets/images/mic.jpg',
                ),
              ),
              Column(
                children: const [
                  Text(
                    "Song Title",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "subtitle of the song",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              // const SliderWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.loop),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded),
                    color: Colors.white,
                    iconSize: 45,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_circle_outline_sharp),
                    color: Colors.white,
                    iconSize: 55,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded),
                    color: Colors.white,
                    iconSize: 45,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.stop_circle_outlined),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
