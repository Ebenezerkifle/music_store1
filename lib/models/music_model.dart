import 'dart:convert';

class Music {
  final String title;
  final String uri;
  final int id;
  final String album;
  final int duration;
  final String artist;
  Music({
    required this.album,
    required this.duration,
    required this.title,
    required this.uri,
    required this.id,
    required this.artist,
  });

  static Map<String, dynamic> toMap(Music music) {
    return <String, dynamic>{
      'title': music.title,
      'uri': music.uri,
      'id': music.id,
      'album': music.album,
      'duration': music.duration,
      'artist': music.artist,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      title: map['title'],
      uri: map['uri'],
      id: map['id'],
      album: map['album'],
      duration: map['duration'],
      artist: map['artst'],
    );
  }
  static String encode(List<Music> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => Music.toMap(music))
            .toList(),
      );

  //String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) =>
      Music.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Music> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Music>((item) => Music.fromJson(item))
          .toList();
}
