import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TrackCatagoryController extends GetxController {
  final index = 0.obs;
  final currentSongs = <SongModel>[].obs;
  final allSongs = <SongModel>[].obs;
  final recentsSongs = <SongModel>[].obs;
  final favoriteSongs = <SongModel>[].obs;

  loadAllSongs(List<SongModel> songs) {
    allSongs(songs);
  }

  loadRecentSongs(List<SongModel> songs) {
    recentsSongs(songs);
  }

  loadFavoriteSongs(List<SongModel> songs) {
    favoriteSongs(songs);
  }

  loadCurrentSongs(List<SongModel> songs) {
    currentSongs(songs);
  }

  updateIndex(int i) {
    index(i);
    List<SongModel> songs = (i == 0)
        ? allSongs
        : (i == 1)
            ? recentsSongs
            : favoriteSongs;

    currentSongs(songs);
  }
}
