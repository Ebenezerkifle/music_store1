import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/music_model.dart';

class QuerySongs {
  late final OnAudioQuery audioQuery;
  late List<Music> musicList;

  QuerySongs() {
    audioQuery = OnAudioQuery();
  }

  Future<bool> requestStoragePermission() async {
    late bool permissionStatus;
    if (!kIsWeb) {
      permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        permissionStatus = await audioQuery.permissionsRequest();
        print('--------------------------------');
        print(permissionStatus);
      }
    }
    return permissionStatus;
  }

  Future<List<Music>> getListOfSongs() async {
    List<SongModel> songList;
    songList = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    List<Music> musicList = [];
    for (SongModel song in songList) {
      musicList.add(
        Music(
          album: song.album ?? '',
          duration: song.duration ?? 0,
          title: song.title,
          uri: song.uri ?? '',
          id: song.id,
          artist: song.artist ?? '',
          displayNameWOExt: song.displayNameWOExt,
          isFavorite: false,
        ),
      );
    }
    this.musicList = musicList;
    return musicList;
  }

  Map<String, List<Music>> getAlbumList() {
    Map<String, List<Music>> albums = {};
    for (var song in musicList) {
      List<Music> songList = [];
      String albumName = song.album;
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

  Map<int, Music> getIdSongMap() {
    Map<int, Music> songMap = {};
    for (Music song in musicList) {
      songMap[song.id] = song;
    }
    return songMap;
  }
}
