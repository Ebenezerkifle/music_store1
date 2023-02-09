import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/play_list_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/widgets/current_song_widget.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';

import '../../controller/player_controller.dart';
import '../widgets/silver_presistent_widget.dart';

// ignore: must_be_immutable
class TrackListPage extends StatelessWidget {
  final String title;
  TrackListPage({Key? key, required this.title}) : super(key: key);

  List<String> catagoryList = [
    "All",
    "Recent",
    "Favorite",
  ];
  final playListController = Get.find<PlayListController>();
  final playerController = Get.find<PlayerController>();
  final querySongController = Get.find<QuerySongs>();

  final ScrollController _scrollController = ScrollController();
  late bool floatingButtonVisiblity = false;

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: PersistentHeader(
              height: MediaQuery.of(context).size.height * 0.04,
              color: MyColors.primaryColor,
              context: context,
              widget: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            catagoryList.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  playListController.updateIndex(index);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color: (playListController.index.value ==
                                            index)
                                        ? Colors.yellow
                                        : Colors.white.withOpacity(0),
                                    border: Border.all(
                                      width: 0.1,
                                      color: Colors.white54,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Text(
                                    catagoryList[index],
                                    textScaleFactor:
                                        (playListController.index.value ==
                                                index)
                                            ? 1.2
                                            : 1.1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: (playListController.index.value ==
                                              index)
                                          ? Colors.black
                                          : Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return (playListController.currentSongs.isEmpty)
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        (playListController.index.value == 0)
                            ? "There is no Song in your device"
                            : (playListController.index.value == 1)
                                ? "No Recent Songs"
                                : "No Favorite Songs",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return customeListTile(
                          music: playListController.currentSongs[index],
                          context: context,
                          onTap: () {
                            if (!playerController.playing.value &&
                                playerController.songId.value ==
                                    playListController.currentSongs[index].id) {
                              playerController.play();
                            } else if (playerController.playing.value &&
                                playerController.songId.value ==
                                    playListController.currentSongs[index].id) {
                              // playerController.pause();
                            } else {
                              playerController.loadPlayList(
                                  playListController.currentSongs, index);
                              playerController.play();
                            }
                            Get.to(
                              () => PlayingPage(
                                isPlaying: playerController.isPlaying(
                                    playListController.currentSongs[index].id),
                                index: index,
                                id: playListController.currentSongs[index].id,
                              ),
                            );
                          },
                          onPlayTap: () {
                            if (!playerController.playing.value &&
                                playerController.songId.value ==
                                    playListController.currentSongs[index].id) {
                              playerController.play();
                            } else if (playerController.playing.value &&
                                playerController.songId.value ==
                                    playListController.currentSongs[index].id) {
                              playerController.pause();
                            } else {
                              playerController.loadPlayList(
                                  playListController.currentSongs, index);
                              playerController.play();
                            }
                          },
                          color: MyColors.primaryColor,
                          duration: Duration(
                              milliseconds: playListController
                                  .currentSongs[index].duration),
                        );
                      },
                      childCount: playListController.currentSongs.length,
                    ),
                  );
          }),
        ],
      ),
      floatingActionButton: Visibility(
        visible: floatingButtonVisiblity,
        child: FloatingActionButton(
          onPressed: () {
            //  scrollToTop();
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.yellow,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => (playController.songId.value != 0)
            ? currentSong(context: context)
            : Container(),
      ),
    );
  }
}
