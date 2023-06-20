import 'package:hive_flutter/adapters.dart';

part 'songs_model.g.dart';

@HiveType(typeId: 0)
class SongDetails {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String artist;
  @HiveField(2)
  final int duration;
  @HiveField(3)
  final int id;
  @HiveField(4)
  final String songUrl;

  SongDetails({
    required this.name,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songUrl,
  });
}

String boxname = 'songz';

class SongBox {
  static Box<SongDetails>? _box;
  static Box<SongDetails> getinstance() {
    return _box ??= Hive.box(boxname);
  }
}
