// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:mucic_store/models/playing_song_model.dart';
import 'package:mucic_store/services/query_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'play_controller_event.dart';
part 'play_controller_state.dart';

class PlayControllerBloc
    extends Bloc<PlayControllerEvent, PlayControllerState> {
  final QuerySongs _querySongs;
  PlayControllerBloc(this._querySongs) : super(PlayControllerInitial()) {
    on<PlayControllerInitialEvent>((event, emit) async {});
    on<PlayEvent>((event, emit) async {
      PlayingSong _playingSong;
      await _querySongs.audioPlayer.setUrl(event.song.uri ?? '');
      _querySongs.audioPlayer.play();
      _playingSong = PlayingSong(
          audioPlayer: _querySongs.audioPlayer,
          index: event.index,
          song: event.song);
      emit(PlayingState(currentSong: _playingSong));
    });
    on<PauseEvent>((event, emit) async {
      await _querySongs.audioPlayer.setUrl(event.uri);
      _querySongs.audioPlayer.pause();
      emit(PausedState(audioPlayer: _querySongs.audioPlayer));
    });
    on<StopEvent>((event, emit) {});
  }
}
