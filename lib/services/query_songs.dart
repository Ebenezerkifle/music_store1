import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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

  // TODO album list should work well!!
  Map<String, List<SongModel>> getAlbumList() {
    Map<String, List<SongModel>> albums = {};
    for (var song in songList) {
      String albumName = song.album ?? "Unknow";
      albums.addIf(!albums.containsKey(albumName), albumName, [song]);
    }
    return albums;
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
}
