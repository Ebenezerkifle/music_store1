import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mucic_store/controller/app_scroll_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/play_list_controller.dart';
import 'package:mucic_store/presentation/pages/albums_list.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/pages/track_list_page.dart';
import 'package:mucic_store/presentation/widgets/current_song_widget.dart';
import 'package:mucic_store/presentation/widgets/custome_grid_list.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';

import '../../controller/player_controller.dart';
import '../my_colors/color.dart';
import '../widgets/silver_presistent_widget.dart';
import 'album_track_page.dart';

// homepage is the landing page for this application. on which we have alot options
// to choose...hat ever we want to choose.

class HomePage extends StatelessWidget {
  //The app displays a list of musics which are catagorized on different possible
  //catagories. catagoryList is a variable to store those catagories.

  final playListController = Get.find<PlayListController>();
  final songListController = Get.find<SongController>();
  final playController = Get.find<PlayerController>();
  final querySongsController = Get.find<QuerySongs>();
  final scrollController = Get.find<AppScrollController>();

  List<String> catagoryList = [
    "All",
    "Recent",
    "Favorite",
  ];

  // active Index is a variable that stores the index value of a catagoryList above
  // so that corresponding list of musics displayed.

  //a variable to control the visisbility of a floating button.
  late bool floatingButtonVisiblity = false;
  //a variable to control the visibility of a bottom Navigation bar.
  late bool bottomNavVisibility = true;

  HomePage({Key? key}) : super(key: key);

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Container(
          color: MyColors.primaryColor,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController.scrollController,
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: Colors.black,
                pinned: true,
                title: Text(
                  "Music Store",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1.2,
                ),
                // actions: [
                //   IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.search,
                //       color: Colors.white,
                //     ),
                //   )
                // ],
              ),
              SliverPersistentHeader(
                pinned: false,
                floating: true,
                delegate: PersistentHeader(
                  height: MediaQuery.of(context).size.height * 0.43,
                  color: MyColors.primaryColor,
                  context: context,
                  widget: Container(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Albums',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textScaleFactor: 1.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const AlbumListPage());
                                },
                                child: const Text(
                                  'see all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white60,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: songListController.albums.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: customeGridWidget(
                                    id: songListController
                                        .albumList[index][0].id,
                                    context: context,
                                    title: songListController
                                        .albumList[index][0].album,
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    smallDetails: [
                                      songListController
                                          .albumList[index][0].artist,
                                    ],
                                    onTap: () {
                                      Get.to(() => AlbumTrackPage(
                                          album: songListController
                                              .albumList[index]));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tracks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textScaleFactor: 1.2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => TrackListPage(title: "Tracks"));
                                    },
                                    child: const Text(
                                      'see all',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white60,
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                          catagoryList.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                bottom: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                playListController
                                                    .updateIndex(index);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                decoration: BoxDecoration(
                                                  color: (playListController
                                                              .index.value ==
                                                          index)
                                                      ? Colors.yellow
                                                      : Colors.white
                                                          .withOpacity(0),
                                                  border: Border.all(
                                                    width: 0.1,
                                                    color: Colors.white54,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Text(
                                                  catagoryList[index],
                                                  textScaleFactor:
                                                      (playListController.index
                                                                  .value ==
                                                              index)
                                                          ? 1.2
                                                          : 1.1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: (playListController
                                                                .index.value ==
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
                            ],
                          ),
                        ),
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
                              music: playListController.currentSongs[index],
                              context: context,
                              onTap: () {
                                if (!playController.playing.value &&
                                    playController.songId.value ==
                                        playListController
                                            .currentSongs[index].id) {
                                  playController.play();
                                } else if (playController.playing.value &&
                                    playController.songId.value ==
                                        playListController
                                            .currentSongs[index].id) {
                                  // playController.pause();
                                } else {
                                  playController.loadPlayList(
                                      playListController.currentSongs, index);
                                  playController.play();
                                }
                                Get.to(
                                  () => PlayingPage(
                                    isPlaying: playController.isPlaying(
                                        playListController
                                            .currentSongs[index].id),
                                    index: index,
                                    id: playListController
                                        .currentSongs[index].id,
                                  ),
                                );
                              },
                              onPlayTap: () {
                                if (!playController.playing.value &&
                                    playController.songId.value ==
                                        playListController
                                            .currentSongs[index].id) {
                                  playController.play();
                                } else if (playController.playing.value &&
                                    playController.songId.value ==
                                        playListController
                                            .currentSongs[index].id) {
                                  playController.pause();
                                } else {
                                  playController.loadPlayList(
                                      playListController.currentSongs, index);
                                  playController.play();
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
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: floatingButtonVisiblity,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.scrollToTop();
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.yellow,
          ),
        ),
      ),
      bottomNavigationBar: Wrap(children: [
        Obx(
          () {
            //TODO work on obx
            // Future.delayed(Duration.zero,(){.......});
            return (playController.songId.value != 0)
                ? currentSong(context: context)
                : Container();
          },
        ),
        Container(
          height: 0.2,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow,
        ),
        Visibility(
          visible: bottomNavVisibility,
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_outlined), label: "Library"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "setting"),
            ],
          ),
        ),
      ]),
    );
  }
}
