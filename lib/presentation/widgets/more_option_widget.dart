import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget moreOptionWidget({
  required BuildContext context,
}) {
  return Container(
    color: Colors.black,
    height: MediaQuery.of(context).size.height * 0.35,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(
      right: MediaQuery.of(context).size.width * 0.1,
      left: MediaQuery.of(context).size.width * 0.1,
    ),
    // color: Colors.black,
    child: Column(
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add to Favorite",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined,
                        color: Colors.white),
                  )
                ]),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Play Next",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.playlist_play_sharp,
                        color: Colors.white),
                  )
                ]),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add to Playlist",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.playlist_add, color: Colors.white),
                  )
                ]),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Set Timer",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.timer_sharp, color: Colors.white),
                  )
                ]),
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

Widget listItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: const [
      Icon(
        Icons.favorite_outline,
        color: Colors.white,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        "Add to Favorite",
        textScaleFactor: 1.2,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ],
  );
}
