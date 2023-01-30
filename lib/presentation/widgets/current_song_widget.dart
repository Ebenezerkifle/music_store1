import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/player_controller.dart';
import '../pages/playing_page.dart';
import 'bottom_sheet_widget.dart';

Widget currentSong({
  required BuildContext context,
}) {
  final playController = Get.find<PlayerController>();

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  return Obx(
    () => Visibility(
      visible: playController.songId.value != 0,
      child: GestureDetector(
        onTap: () => Get.to(PlayingPage(
          isPlaying: true,
          id: playController.songId.value,
        )),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width *
                    (playController.progress.value.inSeconds /
                        playController.totalDuration.value.inSeconds),
                color: Colors.yellow,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          QueryArtworkWidget(
                            id: playController.songId.value,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.03,
                              backgroundImage:
                                  const AssetImage("assets/images/mic.jpg"),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.055,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    playController.songTitle.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textScaleFactor: 1.3,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    playController.songSubtitle.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                    textScaleFactor: 0.8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${twoDigits(playController.remaining.value.inMinutes)}:${twoDigits(playController.remaining.value.inSeconds.remainder(60))}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          (playController.playing.value)
                              ? IconButton(
                                  onPressed: playController.pause,
                                  icon: const Icon(
                                    Icons.pause_circle_filled_outlined,
                                    color: Colors.yellow,
                                    size: 39,
                                  ),
                                )
                              : IconButton(
                                  onPressed: playController.play,
                                  icon: const Icon(
                                    Icons.play_circle_fill_outlined,
                                    color: Colors.yellow,
                                    size: 39,
                                  ),
                                ),
                          IconButton(
                            onPressed: () {
                              bottomSheetWidget(
                                  context: context,
                                  songList: playController.currentPlayList);
                            },
                            icon: const Icon(
                              Icons.playlist_play_rounded,
                              color: Colors.white,
                              size: 39,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
