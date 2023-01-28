import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/widgets/more_option_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

Widget customeListTile({
  required String title,
  required BuildContext context,
  required VoidCallback onTap,
  required List<String> smallDetails,
  Color? color,
  required Duration duration,
  required VoidCallback onPlayTap,
  required int id,
}) {
  final playerController = Get.find<PlayerController>();
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.11,
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        color: color ?? Colors.white,
        shadowColor: MyColors.bright2,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    QueryArtworkWidget(
                      id: id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.04,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(
                          'assets/images/mic.jpg',
                        ),
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: onPlayTap,
                        icon: Icon(playerController.playing.value &&
                                playerController.songId.value == id
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded),
                        color: playerController.songId.value == id
                            ? Colors.yellow
                            : Colors.white,
                        iconSize: 38,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            textScaleFactor: 1.2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (playerController.songId.value == id)
                                  ? Colors.yellow
                                  : (color != null)
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${smallDetails[0]} - ${smallDetails[1]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: (playerController.songId.value == id)
                                  ? Colors.yellow.shade100
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            (playerController.songId.value == id)
                                ? '${twoDigits(playerController.remaining.value.inMinutes)}:${twoDigits(playerController.remaining.value.inSeconds.remainder(60))}'
                                : '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}',
                            style: TextStyle(
                              color: (playerController.songId.value == id)
                                  ? Colors.yellow.shade100
                                  : Colors.grey,
                              fontWeight: FontWeight.normal,
                            )),
                        IconButton(
                          onPressed: () {
                            Get.bottomSheet(moreOptionWidget(context: context));
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
