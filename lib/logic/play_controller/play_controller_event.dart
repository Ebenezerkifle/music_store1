part of 'play_controller_bloc.dart';

@immutable
abstract class PlayControllerEvent {}

class PlayControllerInitialEvent extends PlayControllerEvent {}

class PlayEvent extends PlayControllerEvent {
  final SongModel song;
  final int index;
  PlayEvent({required this.song, required this.index});
}

class PauseEvent extends PlayControllerEvent {
  final String uri;
  PauseEvent({required this.uri});
}

class StopEvent extends PlayControllerEvent {}
