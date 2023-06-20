import 'package:hive_flutter/adapters.dart';
import 'package:tune_spot/model/songs_model.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 2)
class Playlistsongz {
  @HiveField(0)
  String? playlistName;
  @HiveField(1)
  List<SongDetails> playlistsongs;
  Playlistsongz({required this.playlistName, required this.playlistsongs});
}

late Box<Playlistsongz> playlistbox;
openPlaylistDB() async {
  playlistbox = await Hive.openBox<Playlistsongz>('playlistDB');
}
