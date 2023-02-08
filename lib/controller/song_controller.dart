import 'package:get/get.dart';
import 'package:mucic_store/models/music_model.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongController extends GetxController {
  final songList = <Music>[].obs;
  final songMap = <int, Music>{}.obs;
  final songsLoading = true.obs;
  final songsLoaded = false.obs;
  final albumList = <List<Music>>[].obs;
  final albums = <String, List<Music>>{}.obs;
  final playList = <Music>[].obs; // recent playlist
  static late SharedPreferences pref;

  SongController() {
    fetchSongs();
  }

  fetchSongs() async {
    QuerySongs querysSongs = QuerySongs();
    querysSongs.requestStoragePermission();
    bool permissionStatus = await querysSongs.audioQuery.permissionsStatus();
    if (permissionStatus) {
      songsLoading(true);
      songList(await querysSongs.getListOfSongs());
      albums(querysSongs.getAlbumList());
      songMap(querysSongs.getIdSongMap());
      updateAlbumList();
      songsLoaded(true);
    } else {
      // TODO handle this case.
    }
  }

  // a method that creates an album list with songs on it.
  updateAlbumList() {
    List<String> keys = [...albums.keys];
    List<List<Music>> albumsList1 = [];
    for (var key in keys) {
      albumsList1.add(albums[key] ?? []);
    }
    albumList(albumsList1);
  }
}
