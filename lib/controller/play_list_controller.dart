import 'package:get/get.dart';
import 'package:mucic_store/models/music_model.dart';

class PlayListController extends GetxController {
  final index = 0.obs;
  final currentSongs = <Music>[].obs;
  final allSongs = <Music>[].obs;
  final recentsSongs = <Music>[].obs;
  final favoriteSongs = <Music>[].obs;

  loadAllSongs(List<Music> songs) {
    allSongs(songs);
  }

  loadRecentSongs(List<Music> songs) {
    recentsSongs(songs);
  }

  loadFavoriteSongs(List<Music> songs) {
    favoriteSongs(songs);
  }

  loadCurrentSongs(List<Music> songs) {
    currentSongs(songs);
  }

  updateIndex(int i) {
    index(i);
    List<Music> songs = (i == 0)
        ? allSongs
        : (i == 1)
            ? recentsSongs
            : favoriteSongs;

    currentSongs(songs);
  }

  void addToRecentPlayList(Music currentSong) {
    //Todo check if the song is already on recent play list.
    for (Music song in recentsSongs) {
      if (song.id == currentSong.id) {
        return;
      }
    }
    List<Music> list = [currentSong, ...recentsSongs];
    loadRecentSongs(list);
  }
}
