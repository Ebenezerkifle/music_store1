import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/play_list_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/widgets/current_song_widget.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';

import '../../controller/player_controller.dart';
import '../widgets/silver_presistent_widget.dart';

class TrackListPage extends StatefulWidget {
  final String title;
  const TrackListPage({required this.title, super.key});

  @override
  State<TrackListPage> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {
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

  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     //scroll listener

  //     double showoffset = 40.0;
  //     //Back to top botton will show on scroll offset 40.0
  //     if (_scrollController.offset > showoffset) {
  //       floatingButtonVisiblity = true;
  //       setState(() {});
  //     } else {
  //       floatingButtonVisiblity = false;
  //       setState(() {});
  //     }
  //   });
  //   super.initState();
  // }

  void scrollToTop() {
    // a method to bring the top element of a scrollable widget.
    setState(() {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        // maxScrollExtent - down most.
        // minScrollExtent - up most.
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
      );
      floatingButtonVisiblity = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        appBar: AppBar(
          title: Text(widget.title),
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
                        child: Obx(
                          () => Row(
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
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
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
                                        color:
                                            (playListController.index.value ==
                                                    index)
                                                ? Colors.black
                                                : Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => (playListController.currentSongs.isEmpty)
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
                            title: playListController.currentSongs[index].title,
                            context: context,
                            id: playListController.currentSongs[index].id,
                            onTap: () {
                              if (!playerController.playing.value &&
                                  playerController.songId.value ==
                                      playListController
                                          .currentSongs[index].id) {
                                playerController.play();
                              } else if (playerController.playing.value &&
                                  playerController.songId.value ==
                                      playListController
                                          .currentSongs[index].id) {
                                // playerController.pause();
                              } else {
                                playerController.generatePlayList(
                                    playListController.currentSongs, index);
                                playerController.play();
                              }
                              Get.to(
                                () => PlayingPage(
                                  isPlaying: playerController.isPlaying(
                                      playListController
                                          .currentSongs[index].id),
                                  index: index,
                                  id: playListController.currentSongs[index].id,
                                ),
                              );
                            },
                            onPlayTap: () {
                              if (!playerController.playing.value &&
                                  playerController.songId.value ==
                                      playListController
                                          .currentSongs[index].id) {
                                playerController.play();
                              } else if (playerController.playing.value &&
                                  playerController.songId.value ==
                                      playListController
                                          .currentSongs[index].id) {
                                playerController.pause();
                              } else {
                                playerController.generatePlayList(
                                    playListController.currentSongs, index);
                                playerController.play();
                              }
                            },
                            smallDetails: [
                              playListController.currentSongs[index].album,
                              playListController.currentSongs[index].artist,
                            ],
                            color: MyColors.primaryColor,
                            duration: Duration(
                                milliseconds: playListController
                                    .currentSongs[index].duration),
                          );
                        },
                        childCount: playListController.currentSongs.length,
                      ),
                    ),
            )
          ],
        ),
        floatingActionButton: Visibility(
          visible: floatingButtonVisiblity,
          child: FloatingActionButton(
            onPressed: () {
              scrollToTop();
            },
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.yellow,
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Visibility(
              visible: playerController.playing.value,
              child: currentSong(context: context)),
        ));
  }
}
