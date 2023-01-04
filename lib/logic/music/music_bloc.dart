// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/query_songs.dart';
part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final QuerySongs _querySongs;

  MusicBloc(this._querySongs) : super(MusicLoadingState()) {
    on<MusicLoadEvent>((event, emit) async {
      emit(MusicLoadingState());
      _querySongs.requestStoragePermission();
      bool permissionStatus = await _querySongs.audioQuery.permissionsStatus();
      if (permissionStatus) {
        final List<SongModel> songList = await _querySongs.getListOfSongs();
        emit(MusicLoadedState(songList: songList));
      } else {
        add(PermissionDenaiedEvent());
      }
    });
    on<PermissionDenaiedEvent>(((event, emit) {
      emit(PermissionDeniedState());
    }));
  }
}
