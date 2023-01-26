import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/track_catagory_controller.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/player_controller.dart';
import '../widgets/bottom_sheet_widget.dart';
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
  final catagoryController = Get.find<TrackCatagoryController>();
  final playerController = Get.find<PlayerController>();
  final querySongController = Get.find<QuerySongs>();

  final ScrollController _scrollController = ScrollController();
  late bool floatingButtonVisiblity = false;

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  void initState() {
    _scrollController.addListener(() {
      //scroll listener

      double showoffset = 40.0;
      //Back to top botton will show on scroll offset 40.0
      if (_scrollController.offset > showoffset) {
        floatingButtonVisiblity = true;
        setState(() {});
      } else {
        floatingButtonVisiblity = false;
        setState(() {});
      }
    });
    super.initState();
  }

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
                                  catagoryController.updateIndex(index);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color: (catagoryController.index.value ==
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
                                        (catagoryController.index.value ==
                                                index)
                                            ? 1.2
                                            : 1.1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: (catagoryController.index.value ==
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
            () => (catagoryController.currentSongs.isEmpty)
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        (catagoryController.index.value == 0)
                            ? "There is no Song in your device"
                            : (catagoryController.index.value == 1)
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
                          title: catagoryController.currentSongs[index].title,
                          context: context,
                          id: catagoryController.currentSongs[index].id,
                          onTap: () {
                            Get.to(
                              () => PlayingPage(
                                songList: catagoryController.currentSongs,
                                isPlaying: playerController.isPlaying(
                                    catagoryController.currentSongs[index].id),
                                index: index,
                                id: catagoryController.currentSongs[index].id,
                              ),
                            );
                          },
                          onPlayTap: () {
                            playerController.generatePlayList(
                                catagoryController.currentSongs, index);

                            playerController.playPauseHandler(
                                catagoryController.currentSongs[index].id);
                          },
                          smallDetails: [
                            catagoryController.currentSongs[index].album ?? '',
                            catagoryController.currentSongs[index].artist ?? ''
                          ],
                          color: MyColors.primaryColor,
                          duration: Duration(
                              milliseconds: catagoryController
                                      .currentSongs[index].duration ??
                                  0),
                        );
                      },
                      childCount: catagoryController.currentSongs.length,
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
          visible: playerController.songId.value != 0,
          child: GestureDetector(
            onTap: () => Get.to(PlayingPage(
              songList: catagoryController.currentSongs,
              isPlaying: true,
              id: playerController.songId.value,
            )),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          QueryArtworkWidget(
                            id: playerController.songId.value,
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
                                    playerController.songTitle.value,
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
                                    playerController.songSubtitle.value,
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
                            '${twoDigits(playerController.remaining.value.inMinutes)}:${twoDigits(playerController.remaining.value.inSeconds.remainder(60))}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          (playerController.playing.value)
                              ? IconButton(
                                  onPressed: playerController.pause,
                                  icon: const Icon(
                                    Icons.pause_circle_filled_outlined,
                                    color: Colors.yellow,
                                    size: 39,
                                  ),
                                )
                              : IconButton(
                                  onPressed: playerController.play,
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
                                  songList: catagoryController.currentSongs);
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
            ),
          ),
        ),
      ),
    );
  }
}
