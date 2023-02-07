import 'package:flutter/material.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/models/music_model.dart';
import 'package:mucic_store/presentation/pages/playing_page.dart';
import 'package:mucic_store/presentation/widgets/current_song_widget.dart';

import '../my_colors/color.dart';
import '../widgets/custome_grid_list.dart';
import '../widgets/custome_list_tile.dart';
import '../widgets/silver_presistent_widget.dart';
import 'package:get/get.dart';

class AlbumTrackPage extends StatelessWidget {
  final List<Music> album;
  AlbumTrackPage({Key? key, required this.album}) : super(key: key);

  final songController = Get.find<SongController>();
  final playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: Text(
          album[0].album.toString(),
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
                          id: album[0].id,
                          context: context,
                          title: album[0].album.toString(),
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: MediaQuery.of(context).size.width * 0.4,
                          smallDetails: [
                            album[0].artist,
                          ],
                          onTap: () {},
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
                  music: album[index],
                  context: context,
                  duration: Duration(milliseconds: album[index].duration),
                  onTap: () {
                    if (!playerController.playing.value &&
                        playerController.songId.value == album[index].id) {
                      playerController.play();
                    } else if (playerController.playing.value &&
                        playerController.songId.value == album[index].id) {
                      playerController.pause();
                    } else {
                      playerController.loadPlayList(album, index);
                      playerController.play();
                    }
                    Get.to(
                      () => PlayingPage(
                        isPlaying: playerController.isPlaying(album[index].id),
                        index: index,
                        id: album[index].id,
                      ),
                    );
                  },
                  onPlayTap: () {
                    if (!playerController.playing.value &&
                        playerController.songId.value == album[index].id) {
                      playerController.play();
                    } else if (playerController.playing.value &&
                        playerController.songId.value == album[index].id) {
                      playerController.pause();
                    } else {
                      playerController.loadPlayList(album, index);
                      playerController.play();
                    }
                  },
                  // color: Colors.grey.shade900,
                  color: Colors.black87,
                );
              },
              childCount: album.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => (playController.songId.value != 0)
            ? currentSong(context: context)
            : Container(),
      ),
    );
  }
}
