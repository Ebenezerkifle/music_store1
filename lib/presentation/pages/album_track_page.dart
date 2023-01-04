import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';

import '../my_colors/color.dart';
import '../widgets/custome_list_tile.dart';
import '../widgets/silver_presistent_widget.dart';

class AlbumTrackPage extends StatelessWidget {
  AlbumTrackPage({Key? key}) : super(key: key);

  List<String> albumDetail = [
    "Album Title",
    "artist name",
    "12 tracks",
    "Dec 20, 2022",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: const Text(
          "Album Title",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: PersistentHeader(
              height: MediaQuery.of(context).size.height * 0.25,
              color: Colors.black,
              context: context,
              widget: Container(
                color: MyColors.primaryColor,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          // color: Colors.white,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/mic.jpg"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.13,
                              width: MediaQuery.of(context).size.width * 0.13,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_circle_fill_rounded,
                                color: Colors.white,
                                size: 38,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                        albumDetail.length,
                        (index) => Text(
                          albumDetail[index],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textScaleFactor: (5 - index) * 0.3,
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
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const PlayingPage()),
                    // );
                  },
                  onPlayTap: () {},
                  smallDetails: ['subtitle of the song'],
                  color: MyColors.primaryColor,
                  playing: (index == 2) ? true : false,
                );
              },
              childCount: 12,
            ),
          ),
        ],
      ),
    );
  }
}
