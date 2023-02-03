import 'package:flutter/material.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/track_catagory_controller.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //The app displays a list of musics which are catagorized on different possible
  //catagories. catagoryList is a variable to store those catagories.

  final catagoryController = Get.find<TrackCatagoryController>();
  final songListController = Get.find<SongController>();
  final playController = Get.find<PlayerController>();
  final querySongsController = Get.find<QuerySongs>();

  List<String> catagoryList = [
    "All",
    "Recent",
    "Favorite",
  ];

  // active Index is a variable that stores the index value of a catagoryList above
  // so that corresponding list of musics displayed.

  // ToDo this logic is not working yet!
  bool playing = false;

  //a variable to control the visisbility of a floating button.
  late bool floatingButtonVisiblity = false;
  //a variable to control the visibility of a bottom Navigation bar.
  late bool bottomNavVisibility = true;

  // scroll controller is here to give us the information about our scrolling
  // we want this controller to help us decide if the floating button and bottom navigation bar
  // has to be hidden or not.
  final ScrollController _scrollController = ScrollController();
  // var controller = ScrollController.obs;

  //init state calls the listener as soon as the app starts, to get the information about
  // the scrolling.
  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     //scroll listener
  //     double showoffset = 40.0;
  //     //Back to top button(floating action button) will show on scroll offset 40.0
  //     //Bottom Navigation button will get hide on scroll offset 40.0.
  //     if (_scrollController.offset > showoffset) {
  //       floatingButtonVisiblity = true;
  //       bottomNavVisibility = false;
  //       setState(() {});
  //     } else {
  //       floatingButtonVisiblity = false;
  //       bottomNavVisibility = true;
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

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    catagoryController.loadAllSongs(songListController.songList);
    catagoryController.updateIndex(catagoryController.index.value);

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Container(
          color: MyColors.primaryColor,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
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
                  height: MediaQuery.of(context).size.height * 0.42,
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
                                            .albumList[index][0].album ??
                                        '',
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    smallDetails: [
                                      songListController
                                              .albumList[index][0].artist ??
                                          '',
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
                                      Get.to(() =>
                                          const TrackListPage(title: "Tracks"));
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
                                                catagoryController
                                                    .updateIndex(index);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                decoration: BoxDecoration(
                                                  color: (catagoryController
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
                                                      (catagoryController.index
                                                                  .value ==
                                                              index)
                                                          ? 1.2
                                                          : 1.1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: (catagoryController
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
                              title:
                                  catagoryController.currentSongs[index].title,
                              context: context,
                              id: catagoryController.currentSongs[index].id,
                              onTap: () {
                                if (!playController.playing.value &&
                                    playController.songId.value ==
                                        catagoryController
                                            .currentSongs[index].id) {
                                  playController.play();
                                } else if (playController.playing.value &&
                                    playController.songId.value ==
                                        catagoryController
                                            .currentSongs[index].id) {
                                  playController.pause();
                                } else {
                                  playController.generatePlayList(
                                      catagoryController.currentSongs, index);
                                  playController.play();
                                }
                                Get.to(
                                  () => PlayingPage(
                                    isPlaying: playController.isPlaying(
                                        catagoryController
                                            .currentSongs[index].id),
                                    index: index,
                                    id: catagoryController
                                        .currentSongs[index].id,
                                  ),
                                );
                              },
                              onPlayTap: () {
                                if (!playController.playing.value &&
                                    playController.songId.value ==
                                        catagoryController
                                            .currentSongs[index].id) {
                                  playController.play();
                                } else if (playController.playing.value &&
                                    playController.songId.value ==
                                        catagoryController
                                            .currentSongs[index].id) {
                                  playController.pause();
                                } else {
                                  playController.generatePlayList(
                                      catagoryController.currentSongs, index);
                                  playController.play();
                                }
                              },
                              smallDetails: [
                                catagoryController.currentSongs[index].album ??
                                    '',
                                catagoryController.currentSongs[index].artist ??
                                    ''
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
        ),
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
      bottomNavigationBar: Wrap(children: [
        Obx(
          () => Visibility(
              visible: playController.songId.value != 0,
              child: currentSong(context: context)),
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
          // child: Container(
          //   height: MediaQuery.of(context).size.height * 0.06,
          //   width: MediaQuery.of(context).size.width,
          //   color: Colors.black,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.home_filled,
          //             color: Colors.yellow,
          //           )),
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.favorite_rounded,
          //             color: Colors.white,
          //           )),
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.list,
          //             color: Colors.white,
          //           )),
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.settings,
          //             color: Colors.white,
          //           ))
          //     ],
          //   ),
          // ),
        ),
      ]),
    );
  }
}
