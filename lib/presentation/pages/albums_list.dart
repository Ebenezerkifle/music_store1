import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/album_track_page.dart';
import 'package:mucic_store/presentation/pages/track_list_page.dart';

import '../widgets/custome_grid_list.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: const Text('Albums'),
        elevation: 0,
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
        mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        children: List.generate(
          20,
          (index) => customeGridWidget(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumTrackPage(),
                  ));
            },
            context: context,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.5,
            title: 'Album Title',
            smallDetails: ["10 tracks"],
            playing: (index == 2) ? true : false,
          ),
        ),
      ),
    );
  }
}
