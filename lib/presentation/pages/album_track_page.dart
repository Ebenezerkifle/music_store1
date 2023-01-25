import 'package:flutter/material.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../my_colors/color.dart';
import '../widgets/custome_grid_list.dart';
import '../widgets/custome_list_tile.dart';
import '../widgets/silver_presistent_widget.dart';
import 'package:get/get.dart';

class AlbumTrackPage extends StatelessWidget {
  final AlbumModel album;
  AlbumTrackPage({Key? key, required this.album}) : super(key: key);

  final songController = Get.find<SongController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: Text(
          album.album,
          style: const TextStyle(
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
              height: MediaQuery.of(context).size.height * 0.33,
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
                        customeGridWidget(
                          id: album.id,
                          context: context,
                          title: album.album,
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: MediaQuery.of(context).size.width * 0.4,
                          smallDetails: [
                            album.artist ?? album.numOfSongs.toString(),
                          ],
                          playing: false,
                          onTap: () {
                            // Get.to(() =>
                            //     AlbumTrackPage(album: songController.albumList[index]));
                          },
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
                  id: 0,
                  duration: Duration.zero,
                  onTap: () {},
                  onPlayTap: () {},
                  smallDetails: ['subtitle of the song'],
                  color: MyColors.primaryColor,
                );
              },
              childCount: album.numOfSongs,
            ),
          ),
        ],
      ),
    );
  }
}
