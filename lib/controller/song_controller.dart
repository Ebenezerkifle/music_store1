import 'package:get/get.dart';
import 'package:mucic_store/models/music_model.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongController extends GetxController {
  final songList = <Music>[].obs;
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
      updateAlbumList();
      // playList(await getPlayList("Recent"));
      songsLoaded(true);
    } else {}
  }

  updateAlbumList() {
    List<String> keys = [...albums.keys];
    List<List<Music>> albumsList1 = [];
    for (var key in keys) {
      albumsList1.add(albums[key] ?? []);
    }
    albumList(albumsList1);
  }

  // Future<List<Music>> getPlayList(String name) async {
  //   pref = await SharedPreferences.getInstance();
  //   final String? musicsString = pref.getString(name);
  //   print("-------------------------");
  //   print(musicsString);
  //   List<Music> playList =
  //       (musicsString != null) ? Music.decode(musicsString) : [];
  //   print(playList);
  //   return playList;
  // }

  // addToPlayList(String name, Music music) async {
  //   final catagory = Get.find<TrackCatagoryController>();
  //   pref = await SharedPreferences.getInstance();
  //   List<Music> previousList = [];
  //   previousList.add(music);
  //   final String? musicsString = pref.getString(name);
  //   previousList =
  //       (musicsString != null) ? Music.decode(musicsString) : previousList;
  //   print("**************************************");
  //   print(previousList.toList());
  //   final String encodeData = Music.encode(previousList);
  //   print(encodeData);
  //   await pref.setString(name, encodeData);
  // }
}
