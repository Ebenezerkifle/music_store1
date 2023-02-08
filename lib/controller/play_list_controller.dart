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

  // loadCurrentSongs(List<Music> songs) {
  //   currentSongs(songs);
  // }

  updateIndex(int i) {
    index(i);
    List<Music> songs = (i == 0)
        ? allSongs
        : (i == 1)
            ? recentsSongs
            : favoriteSongs;

    currentSongs(songs);
  }

  void addToFavorite(Music favSong) {
    loadFavoriteSongs([favSong, ...favoriteSongs]);
  }

  void addToRecentPlayList(Music currentSong) {
    for (Music song in recentsSongs) {
      if (song.id == currentSong.id) {
        return;
      }
    }
    List<Music> list = [currentSong, ...recentsSongs];
    loadRecentSongs(list);
  }

  void removeFromFavorite(Music music) {
    for (int i = 0; i < favoriteSongs.length; i++) {
      if (favoriteSongs[i].id == music.id) {
        favoriteSongs.removeAt(i);
        break;
      }
    }
  }
}
