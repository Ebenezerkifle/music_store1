import 'package:get/get.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongController extends GetxController {
  final songList = <SongModel>[].obs;
  final songsLoading = true.obs;
  final songsLoaded = false.obs;
  final albumList = <AlbumModel>[].obs;

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
      albumList(await querysSongs.getListOfAlbums());
      songsLoaded(true);
    } else {}
  }
}
