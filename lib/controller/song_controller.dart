import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongController extends GetxController {
  final songList = <SongModel>[].obs;
  final songsLoading = true.obs;
  final songsLoaded = false.obs;
  final albumList = <List<SongModel>>[].obs;
  final albums = <String, List<SongModel>>{}.obs;

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
      //  albumList(await querysSongs.getListOfAlbums());
      albums(querysSongs.getAlbumList());
      updateAlbumList();
      songsLoaded(true);
    } else {}
  }

  updateAlbumList() {
    List<String> keys = [...albums.keys];
    List<List<SongModel>> albumsList1 = [];
    for (var key in keys) {
      albumsList1.add(albums[key] ?? []);
    }
    albumList(albumsList1);
  }
}
