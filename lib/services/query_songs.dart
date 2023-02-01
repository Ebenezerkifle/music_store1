import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QuerySongs {
  late final OnAudioQuery audioQuery;
  late List<SongModel> songList;

  QuerySongs() {
    audioQuery = OnAudioQuery();
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
    this.songList = songList;
    return songList;
  }

  Map<String, List<SongModel>> getAlbumList() {
    Map<String, List<SongModel>> albums = {};
    for (var song in songList) {
      List<SongModel> songList = [];
      String albumName = song.album ?? "Unknow";
      if (albums.containsKey(albumName)) {
        songList = albums[albumName] ?? [];
        songList.add(song);
        albums.update(albumName, (value) => songList);
      } else {
        albums[albumName] = [song];
      }
    }
    return albums;
  }
}
