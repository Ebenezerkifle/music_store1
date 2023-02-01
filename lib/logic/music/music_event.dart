part of 'music_bloc.dart';

abstract class MusicEvent {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class MusicLoadEvent extends MusicEvent {}

class PermissionDenaiedEvent extends MusicEvent {}

class MusicPlayEvent extends MusicEvent {
  String uri;
  MusicPlayEvent({required this.uri});
}

class MusicPauseEvent extends MusicEvent {
  String uri;
  MusicPauseEvent({required this.uri});
}
