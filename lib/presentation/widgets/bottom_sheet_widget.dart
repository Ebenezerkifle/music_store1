import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mucic_store/models/music_model.dart';

import 'package:mucic_store/controller/player_controller.dart';

Future<dynamic> bottomSheetWidget({
  required BuildContext context,
  required List<Music> songList,
}) {
  final playerController = Get.find<PlayerController>();
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.0),
        ),
      ),
      backgroundColor: Colors.black, // <-- SEE HERE
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.width * 0.03,
          ),
          // color: Colors.black,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Queue (${songList.length} songs)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(
                    () => Column(
                      children: List.generate(
                          songList.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  playerController.loadPlayList(
                                      songList, index);
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          songList[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: songList[index].id ==
                                                      playerController
                                                          .songId.value
                                                  ? Colors.yellow
                                                  : Colors.white),
                                          textScaleFactor: 1.1,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.cancel,
                                            color: songList[index].id ==
                                                    playerController
                                                        .songId.value
                                                ? Colors.yellow
                                                : Colors.white),
                                      )
                                    ]),
                              )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: TextButton(
                    onPressed: Get.back,
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
