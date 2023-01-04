import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QuerySongs {
  late final OnAudioQuery audioQuery;
  late final AudioPlayer audioPlayer;

  QuerySongs() {
    audioQuery = OnAudioQuery();
    audioPlayer = AudioPlayer();
  }

  void requestStoragePermission() async {
    late bool permissionStatus;
    if (!kIsWeb) {
      permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
    }
  }

  Future<List<SongModel>> getListOfSongs() async {
    List<SongModel> songList;
    songList = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return songList;
  }

  Future<List<AlbumModel>> getListOfAlbums() async {
    List<AlbumModel> albumList;
    albumList = await audioQuery.queryAlbums(
      orderType: OrderType.DESC_OR_GREATER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return albumList;
  }

  void playSong(String? uri) {
    // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    audioPlayer.play();
    // audioPlayer.onPlayerStateChanged;
  }

  void pauseSong() {
    //audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    audioPlayer.pause();
  }
}
