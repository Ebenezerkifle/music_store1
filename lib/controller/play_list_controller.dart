import 'package:get/get.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/models/music_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayListController extends GetxController {
  final index = 0.obs;
  final currentSongs = <Music>[].obs;
  final allSongs = <Music>[].obs;
  final recentsSongs = <Music>[].obs;
  final favoriteSongs = <Music>[].obs;
  late SharedPreferences pref;
  final String _favorite = 'favorite';
  final String _recent = 'recent';
  final songController = Get.find<SongController>();

  PlayListController() {
    loadPlayLists();
    queryFromStorage();
  }
  void queryFromStorage() async {
    pref = await SharedPreferences.getInstance();
    // if the key exists it fatchs favorite songs.
    pref.containsKey(_favorite)
        ? favoriteSongs(Music.decode(pref.getString(_favorite) ?? ''))
        : null;

    pref.containsKey(_recent)
        ? recentsSongs(Music.decode(pref.getString(_recent) ?? ''))
        : null;
  }

  void loadPlayLists() {
    allSongs(songController.songList);
    currentSongs(allSongs);
  }

  loadAllSongs(List<Music> songs) {
    allSongs(songs);
  }

  loadRecentSongs(List<Music> songs) {
    recentsSongs(songs);
    storeOnDevice(_recent, recentsSongs);
  }

  loadFavoriteSongs(List<Music> songs) {
    favoriteSongs(songs);
    storeOnDevice(_favorite, favoriteSongs);
  }

  void removeFromFavorite(Music music) {
    for (int i = 0; i < favoriteSongs.length; i++) {
      if (favoriteSongs[i].id == music.id) {
        favoriteSongs.removeAt(i);
        break;
      }
    }
    storeOnDevice(_favorite, favoriteSongs);
  }

  void storeOnDevice(String key, List<Music> songList) async {
    pref = await SharedPreferences.getInstance();
    String json = Music.encode(songList);
    pref.setString(key, json).then((value) {
      //Todo do something here!
    });
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

  void addToFavorite(Music favSong) {
    loadFavoriteSongs([favSong, ...favoriteSongs]);
  }

  void addToRecentPlayList(Music currentSong) {
    for (int i = 0; i < recentsSongs.length; i++) {
      if (recentsSongs[i].id == currentSong.id) {
        recentsSongs.removeAt(i);
        break;
      }
    }
    List<Music> list = [currentSong, ...recentsSongs];
    loadRecentSongs(list);
  }
}
