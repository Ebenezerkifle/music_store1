import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';

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
  int activeIndex = 0;

  final ScrollController _scrollController = ScrollController();
  late bool floatingButtonVisiblity = false;

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          catagoryList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 4.0, bottom: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeIndex = index;
                                  // TODO block needed to handle this event.
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    color: (activeIndex == index)
                                        ? Colors.yellow
                                        : Colors.white.withOpacity(0),
                                    border: Border.all(
                                      width: 0.1,
                                      color: Colors.white54,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Text(
                                  catagoryList[index],
                                  textScaleFactor:
                                      (activeIndex == index) ? 1.2 : 1.1,
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
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return customeListTile(
                  title: "Song title",
                  context: context,
                  onPlayTap: () {},
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const PlayingPage()),
                    // );
                  },
                  smallDetails: ['subtitle of the song'],
                  color: MyColors.primaryColor,
                  playing: (index == 2) ? true : false,
                );
              },
              childCount: 22,
            ),
          ),
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
    );
  }
}
