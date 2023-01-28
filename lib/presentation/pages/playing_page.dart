import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mucic_store/presentation/widgets/play_controller_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

import '../my_colors/color.dart';

class PlayingPage extends StatelessWidget {
  final bool isPlaying;
  final int? index;
  final int id;
  PlayingPage({
    Key? key,
    required this.isPlaying,
    this.index,
    required this.id,
  }) : super(key: key);

  final playerController = Get.find<PlayerController>();
  final songListController = Get.find<SongController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
          title: const Center(
            child: Text("Now Playing"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  bottomSheetWidget(
                      context: context,
                      songList: playerController.currentPlayList);
                },
                icon: const Icon(Icons.list))
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
              opacity: 0,
            ),
          ),
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => SizedBox(
                  height: MediaQuery.of(context).size.width * 0.94,
                  width: MediaQuery.of(context).size.width * 0.94,
                  child: QueryArtworkWidget(
                    id: playerController.songId.value,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Container(
                      height: MediaQuery.of(context).size.width * 0.94,
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/mic.jpg'))),
                    ),
                  ),
                ),
              ),
              PlayController(
                songDetail: playerController.currentPlayList,
                isPlaying: isPlaying,
                iconSize: 50,
                index: index ?? 0,
                id: id,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Obx(
        () => Visibility(
          visible: playerController.showList.value,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02),
            // color: Colors.yellow,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(40, 40),
                topRight: Radius.elliptical(40, 40),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  songListController.songList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      playerController.generatePlayList(
                          songListController.songList, index);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            songListController.songList[index].title,
                            style: TextStyle(
                                color: songListController.songList[index].id ==
                                        playerController.songId.value
                                    ? Colors.yellow
                                    : Colors.white),
                            textScaleFactor: 1.1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.cancel,
                                color: songListController.songList[index].id ==
                                        playerController.songId.value
                                    ? Colors.yellow
                                    : Colors.white),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
