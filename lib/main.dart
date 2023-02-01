import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mucic_store/logic/play_controller/play_controller_bloc.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/pages/home_page.dart';
import 'package:mucic_store/services/query_songs.dart';

import 'logic/music/music_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => QuerySongs(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                MusicBloc(RepositoryProvider.of<QuerySongs>(context))
                  ..add(MusicLoadEvent()),
          ),
          BlocProvider(
            create: (context) =>
                PlayControllerBloc(RepositoryProvider.of<QuerySongs>(context))
                  ..add(PlayControllerInitialEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Music Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: MyColors.primaryColor,
          ),
          home: const HomePage(),
          // home: const TrackListPage(
          //   title: 'Track List',
          // ),
        ),
      ),
    );
  }
}
/*
=============
Author: Lucas Josino
Github: https://github.com/LucJosin
Website: https://www.lucasjosino.com/
=============
Plugin/Id: on_audio_query#0
Homepage: https://github.com/LucJosin/on_audio_query
Pub: https://pub.dev/packages/on_audio_query
License: https://github.com/LucJosin/on_audio_query/blob/main/on_audio_query/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       home: Songs(),
//     ),
//   );
// }

// class Songs extends StatefulWidget {
//   const Songs({Key? key}) : super(key: key);

//   @override
//   _SongsState createState() => _SongsState();
// }

// class _SongsState extends State<Songs> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   @override
//   void initState() {
//     super.initState();
//     requestPermission();
//   }

//   void requestPermission() {
//     Permission.storage.request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Music Store"),
//         elevation: 2,
//       ),
//       body: FutureBuilder<List<SongModel>>(
//         // Default values:
//         future: _audioQuery.querySongs(
//           sortType: null,
//           orderType: OrderType.ASC_OR_SMALLER,
//           uriType: UriType.EXTERNAL,
//           ignoreCase: true,
//         ),
//         builder: (context, item) {
//           // Loading content
//           if (item.data == null) return const CircularProgressIndicator();

//           // When you try "query" without asking for [READ] or [Library] permission
//           // the plugin will return a [Empty] list.
//           if (item.data!.isEmpty) return const Text("Nothing found!");

//           // You can use [item.data!] direct or you can create a:
//           // List<SongModel> songs = item.data!;

//           return ListView.builder(
//             itemCount: item.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 onTap: () async {
//                   AudioPlayer _audioPlayer = AudioPlayer();
//                   _audioPlayer = AudioPlayer();
//                   if (item.data![index].uri!.isNotEmpty) {
//                     await _audioPlayer.setUrl(item.data![index].uri ?? "");
//                     _audioPlayer.play();
//                   }
//                 },
//                 title: Text(item.data![index].title),
//                 subtitle: Text(item.data![index].artist ?? "No Artist"),
//                 trailing: const Icon(Icons.arrow_forward_rounded),
//                 // This Widget will query/load image. Just add the id and type.
//                 // You can use/create your own widget/method using [queryArtwork].
//                 leading: QueryArtworkWidget(
//                   id: item.data![index].id,
//                   type: ArtworkType.AUDIO,
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
