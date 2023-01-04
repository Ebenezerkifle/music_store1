import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';

import '../widgets/silver_presistent_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> catagoryList = [
    'All',
    'Electronics',
    'Food',
    'Company',
    'Bank',
    'Cloths',
    'Advertising',
    'Others',
  ];

  final ScrollController _scrollController = ScrollController();
  late bool floatingButtonVisiblity = false;
  // controlls the visiblity of floating button.

  int activeIndex = 0;
  // active index holds the value of active index of catagory lists.

  bool special = true;
  // a variable to hold the value a user picked from "Special" and "Big Sale"
  // initially we take special=true, so that the app desplays spcial products/services.

  @override
  void initState() {
    _scrollController.addListener(() {
      //scroll listener

      double showoffset = 20.0;
      //Back to top botton will show on scroll offset 20.0
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
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Music Store'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shop)),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: MyColors.primaryColor,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                pinned: false,
                snap: false,
                floating: false,
                leading: Container(),
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                flexibleSpace: const FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: Image(
                      image: AssetImage('assets/images/mic.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                floating: true,
                delegate: PersistentHeader(
                  height: MediaQuery.of(context).size.height * 0.52,
                  //minHeight: MediaQuery.of(context).size.height * 0.25,
                  color: MyColors.primaryColor,
                  context: context,
                  widget: Container(
                    color: MyColors.primaryColor,
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
                                onTap: () {},
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
                              itemBuilder: (context, index) => customeListTile(
                                context: context,
                                onTap: () {},
                                onPlayTap: () {},
                                smallDetails: [],
                                title: '',
                                playing: index == 2 ? true : false,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(
                              20,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: const AssetImage(
                                          'assets/images/mic.jpg',
                                        ),
                                      ),
                                      const Text(
                                        "Jordan",
                                        textScaleFactor: 0.8,
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onTap: () {},
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: List.generate(
                                  catagoryList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: (activeIndex == index)
                                                ? MyColors.bright
                                                : Colors.white.withOpacity(0),
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
                                                ? Colors.white
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
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return customeListTile(
                      context: context,
                      smallDetails: [],
                      onTap: () {},
                      title: "Song Title",
                      playing: index == 2 ? true : false,
                      onPlayTap: () {});
                }),
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
          backgroundColor: MyColors.primaryColor,
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.1,
      //  drawer: drawer(context: context),
    );
  }
}
