import 'package:flutter/material.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/controller/track_catagory_controller.dart';
import 'package:mucic_store/presentation/pages/albums_list.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/pages/track_list_page.dart';
import 'package:mucic_store/presentation/widgets/custome_grid_list.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:get/get.dart';
import 'package:mucic_store/presentation/widgets/custome_simple_list.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/player_controller.dart';
import '../my_colors/color.dart';
import '../widgets/play_controller_page.dart';
import '../widgets/silver_presistent_widget.dart';
import 'album_track_page.dart';

// homepage is the landing page for this application. on which we have a lote options
// to choose what ever we want to choose.

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

  //init state calls the listener as soon as the app starts, to get the information about
  // the scrolling.
  @override
  void initState() {
    _scrollController.addListener(() {
      //scroll listener
      double showoffset = 40.0;
      //Back to top button(floating action button) will show on scroll offset 40.0
      //Bottom Navigation button will get hide on scroll offset 40.0.
      if (_scrollController.offset > showoffset) {
        floatingButtonVisiblity = true;
        bottomNavVisibility = false;
        setState(() {});
      } else {
        floatingButtonVisiblity = false;
        bottomNavVisibility = true;
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

  // a function to format time in two digit form.
  //mostly we get trouble when we have a second value lessthan 10
  //so this function converts a single digit number to two digit if there is one.
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    //loading a default playlist.
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
              SliverAppBar(
                backgroundColor: Colors.black,
                pinned: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: (const Icon(Icons.menu)),
                ),
                title: const Text(
                  "Music Store",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
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
                                itemCount: songListController.albumList.length,
                                itemBuilder: (context, index) =>
                                    customeGridWidget(
                                  id: songListController.albumList[index].id,
                                  context: context,
                                  title:
                                      songListController.albumList[index].album,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  smallDetails: [
                                    songListController
                                            .albumList[index].artist ??
                                        songListController
                                            .albumList[index].numOfSongs
                                            .toString(),
                                  ],
                                  playing: (index == 1) ? true : false,
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
                                Get.to(
                                  () => PlayingPage(
                                    songList: catagoryController.currentSongs,
                                    isPlaying: playController.isPlaying(
                                        catagoryController
                                            .currentSongs[index].id),
                                    index: index,
                                    id: catagoryController
                                        .currentSongs[index].id,
                                  ),
                                );
                              },
                              // onPlayTap: () {},
                              onPlayTap: () {
                                playController.generatePlayList(
                                    catagoryController.currentSongs, index);

                                playController.playPauseHandler(
                                    catagoryController.currentSongs[index].id);
                              },
                              smallDetails: [
                                catagoryController
                                    .currentSongs[index].displayNameWOExt,
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
      bottomSheet: Obx(
        () => Visibility(
          visible: playController.showList.value,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02),
            // color: Colors.yellow,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(40, 40),
                topRight: Radius.elliptical(40, 40),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                    songListController.songList.length,
                    (index) => GestureDetector(
                          onTap: () {
                            playController.generatePlayList(
                                catagoryController.currentSongs, index);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  songListController.songList[index].title,
                                  style: TextStyle(
                                      color: songListController
                                                  .songList[index].id ==
                                              playController.songId.value
                                          ? Colors.yellow
                                          : Colors.white),
                                  textScaleFactor: 1.1,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.cancel,
                                      color: songListController
                                                  .songList[index].id ==
                                              playController.songId.value
                                          ? Colors.yellow
                                          : Colors.white),
                                )
                              ]),
                        )),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: playController.songId.value != 0,
          child: (playController.showList.value)
              ? GestureDetector(
                  onTap: playController.toggleShowList,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        width: 0.1,
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "close",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => Get.to(PlayingPage(
                    songList: songListController.songList,
                    isPlaying: true,
                    id: playController.songId.value,
                  )),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //  crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  playController.songTitle.value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textScaleFactor: 1.3,
                                ),
                                Text(
                                  playController.songSubtitle.value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                  textScaleFactor: 0.8,
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
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            Colors.amberAccent, // <-- SEE HERE
                                        builder: (context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text("Something Came")
                                              ],
                                            ),
                                          );
                                        });
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
      // bottomNavigationBar: Visibility(
      //   visible: bottomNavVisibility,
      //   child: Container(
      //     height: MediaQuery.of(context).size.height * 0.06,
      //     width: MediaQuery.of(context).size.width,
      //     color: Colors.black,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         IconButton(
      //             onPressed: () {},
      //             icon: const Icon(
      //               Icons.home_filled,
      //               color: Colors.yellow,
      //             )),
      //         IconButton(
      //             onPressed: () {},
      //             icon: const Icon(
      //               Icons.favorite_rounded,
      //               color: Colors.white,
      //             )),
      //         IconButton(
      //             onPressed: () {},
      //             icon: const Icon(
      //               Icons.list,
      //               color: Colors.white,
      //             )),
      //         IconButton(
      //             onPressed: () {},
      //             icon: const Icon(
      //               Icons.settings,
      //               color: Colors.white,
      //             ))
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
