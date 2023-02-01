part of 'music_bloc.dart';

abstract class MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoadingState extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoadedState extends MusicState {
  final List<SongModel> songList;
  MusicLoadedState({required this.songList});
  @override
  List<Object> get props => [songList];
}

class MusicPlayingState extends MusicState {
  final List<SongModel> songList;
  MusicPlayingState({required this.songList});
  @override
  List<Object> get props => [songList];
}

// ignore: must_be_immutable
class PermissionDeniedState extends MusicState {
  late String permission;
  PermissionDeniedState() {
    permission = "Allow Permission To Load a Music File";
  }
  @override
  List<Object> get props => [permission];
}
