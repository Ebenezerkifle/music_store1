import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

Widget customeGridWidget({
  required BuildContext context,
  required VoidCallback onTap,
  required double height,
  required double width,
  required String title,
  required List<String> smallDetails,
  required int id,
}) {
  final playerController = Get.find<PlayerController>();
  final songController = Get.find<SongController>();
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Card(
          color: MyColors.primaryColor,
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: QueryArtworkWidget(
                  id: id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.1)),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/mic.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        color: MyColors.primaryColor,
                        shape: BoxShape.rectangle),
                  ),
                ),
              ),
              Container(
                width: width * 0.6,
                height: height * 0.2,
                padding: EdgeInsets.only(left: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      smallDetails[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  )),
              IconButton(
                onPressed: () {
                  //Todo 1  when a play button on an album clicked. check if a list is loaded or not.
                  // should load a playlist if it was not loaded.
                  if (playerController.album.value == title &&
                      playerController.playing.value) {
                    playerController.pause();
                  } else if (playerController.currentPlayList.isNotEmpty &&
                      playerController.currentPlayList[0].album == title &&
                      !playerController.playing.value) {
                    // if a playlist is aready loaded!
                    playerController.play();
                  } else {
                    playerController.loadPlayList(
                        songController.albums[title] ?? [], 0);

                    playerController.play();
                  }
                  //Todo 2 when a pause button on an album clicked.
                },
                icon: Icon(
                  playerController.album.value == title &&
                          playerController.playing.value
                      ? Icons.pause_circle
                      : Icons.play_circle,
                ),
                color: playerController.album.value == title
                    ? Colors.yellow
                    : Colors.white,
                iconSize: 40,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
