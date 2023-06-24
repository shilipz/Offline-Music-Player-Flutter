import 'package:hive_flutter/adapters.dart';
part 'recentlyplayedModel.g.dart';

@HiveType(typeId: 4)
class RecentlyPlayed {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songurl;

  @HiveField(4)
  int? id;

  RecentlyPlayed(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

late Box<RecentlyPlayed> recentlyplayedbox;
openRecenlyPlayedDb() async {
  recentlyplayedbox = await Hive.openBox('recenlyplayed');
}
