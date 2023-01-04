part of 'play_controller_bloc.dart';

@immutable
abstract class PlayControllerState {}

class PlayControllerInitial extends PlayControllerState {}

class PausedState extends PlayControllerState {
  final AudioPlayer audioPlayer;
  PausedState({required this.audioPlayer});
}

class PlayingState extends PlayControllerState {
  final PlayingSong currentSong;
  PlayingState({required this.currentSong});
}

class StopedState extends PlayControllerState {}

class LoadingState extends PlayControllerState {}
