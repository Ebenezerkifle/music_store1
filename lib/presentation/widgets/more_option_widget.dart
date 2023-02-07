import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mucic_store/controller/play_list_controller.dart';

import '../../models/music_model.dart';

final playListController = Get.find<PlayListController>();
Widget moreOptionWidget({
  required BuildContext context,
  required Music music,
}) {
  return Container(
    color: Colors.black,
    height: MediaQuery.of(context).size.height * 0.3,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(
      right: MediaQuery.of(context).size.width * 0.1,
      left: MediaQuery.of(context).size.width * 0.1,
    ),
    // color: Colors.black,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              listItem(
                  title: music.isFavorite == true
                      ? "Remove from Favorite"
                      : "Add to Favorite",
                  icon: Icon(
                      (music.isFavorite == true)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white),
                  onTap: () {
                    if (music.isFavorite == true) {
                      music.isFavorite = false;
                      playListController.removeFromFavorite(music);
                    } else {
                      music.isFavorite = true;
                      playListController.addToFavorite(music);
                    }
                  }),
              const SizedBox(height: 10),
              listItem(
                title: "Play Next",
                icon:
                    const Icon(Icons.playlist_play_sharp, color: Colors.white),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              listItem(
                title: "Add to Playlist",
                icon: const Icon(Icons.playlist_add, color: Colors.white),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              listItem(
                title: "Set sleep time",
                icon: const Icon(Icons.timer_sharp, color: Colors.white),
                onTap: () {},
              ),
            ]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Center(
            child: TextButton(
              onPressed: Get.back,
              child: const Text(
                "Close",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.3,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget listItem({
  required String title,
  required Icon icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.2,
          ),
          icon,
        ]),
  );
}
