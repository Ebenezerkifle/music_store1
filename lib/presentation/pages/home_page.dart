import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucic_store/presentation/pages/albums_list.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/pages/track_list_page.dart';
import 'package:mucic_store/presentation/widgets/custome_grid_list.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../logic/music/music_bloc.dart';
import '../../logic/play_controller/play_controller_bloc.dart';
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
  List<String> catagoryList = [
    "All",
    "Recent",
    "Favorite",
  ];

  // active Index is a variable that stores the index value of a catagoryList above
  // so that corresponding list of musics displayed.
  int activeIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Container(
          color: MyColors.primaryColor,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: <Widget>[
              (playing)
                  ? SliverAppBar(
                      leading: const Icon(Icons.menu),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                          color: Colors.white,
                        ),
                      ],
                      elevation: 3,
                      pinned: false,
                      snap: false,
                      floating: false,
                      expandedHeight: MediaQuery.of(context).size.height * 0.25,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.pin,
                        background: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/mic.jpg'),
                              fit: BoxFit.cover,
                              opacity: 0.3,
                            ),
                          ),
                          // Todo check the following line of code!
                          // child: PlayController(
                          //   songDetail: ,
                          //   iconSize: 40),
                        ),
                      ),
                    )
                  : SliverAppBar(
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AlbumListPage()));
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
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  customeGridWidget(
                                context: context,
                                title: "Album title",
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                smallDetails: ["artist name"],
                                playing: (index == 1) ? true : false,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AlbumTrackPage()));
                                },
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const TrackListPage(
                                                  title: "Tracks")),
                                        ),
                                      );
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(
                                        catagoryList.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8.0, bottom: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                activeIndex = index;
                                                // TODO block needed to handle this event.
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                  color: (activeIndex == index)
                                                      ? Colors.yellow
                                                      : Colors.white
                                                          .withOpacity(0),
                                                  border: Border.all(
                                                    width: 0.1,
                                                    color: Colors.white54,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Text(
                                                catagoryList[index],
                                                textScaleFactor:
                                                    (activeIndex == index)
                                                        ? 1.2
                                                        : 1.1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: (activeIndex == index)
                                                      ? Colors.black
                                                      : Colors.white54,
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
              BlocBuilder<MusicBloc, MusicState>(
                builder: (context, state) {
                  return (state is MusicLoadedState)
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return BlocBuilder<PlayControllerBloc,
                                  PlayControllerState>(
                                builder: (context, controllerState) {
                                  bool isPlaying =
                                      controllerState is PlayingState &&
                                          controllerState.currentSong.index ==
                                              index;
                                  return customeListTile(
                                    title: state.songList[index].title,
                                    context: context,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlayingPage(
                                                  song: state.songList[index],
                                                  isPlaying: isPlaying,
                                                )),
                                      );
                                    },
                                    onPlayTap: (() {
                                      BlocProvider.of<PlayControllerBloc>(
                                              context)
                                          .add((!isPlaying)
                                              ? PlayEvent(
                                                  song: state.songList[index],
                                                  index: index)
                                              : PauseEvent(
                                                  uri: state.songList[index]
                                                          .uri ??
                                                      '',
                                                ));
                                    }),
                                    smallDetails: [
                                      state.songList[index].displayNameWOExt,
                                    ],
                                    color: MyColors.primaryColor,
                                    playing: isPlaying,
                                    duration: state.songList[index].duration,
                                  );
                                },
                              );
                            },
                            childCount: state.songList.length,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return const CircularProgressIndicator();
                            },
                            childCount: 5,
                          ),
                        );
                },
              ),
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
      bottomNavigationBar: Visibility(
        visible: bottomNavVisibility,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.home_filled,
                    color: Colors.yellow,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.list,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
