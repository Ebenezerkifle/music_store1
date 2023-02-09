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
    QuerySongs querySongs = QuerySongs();
    querySongs.requestStoragePermission();
    bool permissionStatus = await querySongs.audioQuery.permissionsStatus();
    if (permissionStatus) {
      songsLoading(true);
      songList(await querySongs.getListOfSongs());
      albums(querySongs.getAlbumList());
      songMap(querySongs.getIdSongMap());
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
