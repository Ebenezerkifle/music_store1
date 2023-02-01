import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingSong {
  late AudioPlayer audioPlayer;
  late SongModel song;
  late int index;
  PlayingSong({
    required this.audioPlayer,
    required this.song,
    required this.index,
  });
}
