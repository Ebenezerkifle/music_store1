import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mucic_store/controller/play_list_controller.dart';
import 'package:mucic_store/models/music_model.dart';

class PlayerController extends GetxController {
  final songId = 0.obs;
  final songTitle = ''.obs;
  final songSubtitle = ''.obs;
  final album = ''.obs;
  final playing = false.obs;
  final totalDuration = Duration.zero.obs;
  final bufferedDuration = Duration.zero.obs;
  final progress = Duration.zero.obs;
  final remaining = Duration.zero.obs;
  final showRemaining = true.obs;
  late final AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playList;
  final showList = false.obs;
  final currentPlayList = <Music>[].obs;
  final songUri = ''.obs;
  final artist = ''.obs;

  // var currentSong = Music.obs;

  PlayerController(List<Music> playList) {
    _audioPlayer = AudioPlayer();
    _playList = ConcatenatingAudioSource(children: []);
  }

  loadPlayList(List<Music> playList, int index) async {
    _playList = ConcatenatingAudioSource(
      children: List.generate(
        playList.length,
        (index) => AudioSource.uri(
          Uri.parse(playList[index].uri),
          tag: [
            playList[index].id,
            playList[index].title,
            playList[index].displayNameWOExt,
            playList[index].album,
            playList[index].uri,
            playList[index].artist,
          ],
        ),
      ),
    );

    _audioPlayer.setAudioSource(_playList, initialIndex: index);
    currentPlayList(playList);
    (_playList.length > 0) ? playerListner() : null;
  }

  playerListner() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        // buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playing(false);
      } else if (processingState != ProcessingState.completed) {
        playing(true);
      } else {
        // completed
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      progress(position);
      remaining(totalDuration.value - progress.value);
    });

    _audioPlayer.currentIndexStream.listen((event) {});

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      bufferedDuration(bufferedPosition);
    });

    _audioPlayer.durationStream.listen((total) {
      totalDuration(total);
    });
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      songId(sequenceState.currentSource!.tag[0]);
      songTitle(sequenceState.currentSource!.tag[1]);
      songSubtitle(sequenceState.currentSource!.tag[2]);
      album(sequenceState.currentSource!.tag[3]);
      songUri(sequenceState.currentSource!.tag[4]);
      artist(sequenceState.currentSource!.tag[5]);
      // TODO: update playlist
      // TODO: update shuffle mode
      // TODO: update previous and next buttons
    });
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void playPauseHandler(int id) {
    if (_audioPlayer.playing && songId.value == id) {
      pause();
    } else {
      play();
    }
  }

  void albumPlayPauseHandler(String albumName) {
    if (_audioPlayer.playing && album.value == albumName) {
      pause();
    } else {
      play();
    }
  }

  void pause() {
    _audioPlayer.pause();
  }

  final recentPlayList = Get.find<PlayListController>();
  void play() {
    _audioPlayer.play();
  }

  void onPreviousButtonclick() {
    _audioPlayer.seekToPrevious();
  }

  void onNextButtonClick() {
    _audioPlayer.seekToNext();
  }

  bool isPlaying(int id) {
    if (songId.value == id && playing.value) {
      return true;
    } else {
      return false;
    }
  }

  //a method to toggle between a progress time and remaining time.
  updateWhatToShow() {
    (showRemaining.value) ? showRemaining(false) : showRemaining(true);
  }

  toggleShowList() {
    showList(showList.value ? false : true);
  }

  // void generatePlayList(List<Music> songList, int index) {
  //   List<Music> newPlayList = [];
  //   if (index != 0) {
  //     for (int i = index; i < songList.length; i++) {
  //       newPlayList.add(songList[i]);
  //     }
  //     for (int j = 0; j < index; j++) {
  //       newPlayList.add(songList[j]);
  //     }
  //     loadPlayList(newPlayList);
  //   } else {
  //     loadPlayList(songList);
  //   }
  // }
}
