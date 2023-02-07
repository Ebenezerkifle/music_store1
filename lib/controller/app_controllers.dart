import 'package:get/get.dart';
import 'package:mucic_store/controller/app_scroll_controller.dart';
import 'package:mucic_store/controller/play_list_controller.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:mucic_store/controller/song_controller.dart';
import 'package:mucic_store/services/query_songs.dart';

class AppControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuerySongs>(() => QuerySongs());
    Get.lazyPut<SongController>(() => SongController());
    Get.lazyPut<PlayListController>(() => PlayListController());
    Get.lazyPut<PlayerController>(() => PlayerController());
    Get.lazyPut<AppScrollController>(() => AppScrollController());
  }
}
