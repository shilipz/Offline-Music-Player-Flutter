import 'package:hive_flutter/adapters.dart';
part 'mostlyplayed_model.g.dart';

@HiveType(typeId: 3)
class MostlyPlayed {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? id;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  String? songUrl;
  @HiveField(5)
  int? count;

  MostlyPlayed(
      {required this.name,
      required this.artist,
      required this.id,
      required this.duration,
      required this.songUrl,
      required this.count});
}

late Box<MostlyPlayed> mostplayedBox;
openMostPlayedDb() async {
  mostplayedBox = await Hive.openBox('mostplayedsngz');
}

updatePlayedSongCount(MostlyPlayed value, int index) {
  int? count = value.count;
  value.count = (count! + 1);
  mostplayedBox.put(index, value);
}
