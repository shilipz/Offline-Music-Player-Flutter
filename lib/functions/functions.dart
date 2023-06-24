import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:tune_spot/model/recentlyplayedModel.dart';
import 'package:tune_spot/model/songs_model.dart';

import '../model/mostlyplayed_model.dart';

final AssetsAudioPlayer player = AssetsAudioPlayer();
List<Audio> playingList = [];
playMusic(int index, List<SongDetails> songs) async {
  playingList.clear();

  for (var element in songs) {
    playingList.add(Audio.file(element.songUrl,
        metas: Metas(
            title: element.name,
            artist: element.artist,
            id: element.id.toString())));
  }
  await player.open(
      Playlist(
        audios: playingList,
        startIndex: index,
      ),
      showNotification: true);
}

// ----------------mostlyplayed------function-------------------------------
updatePlayedSongCount(MostlyPlayed value, int index) {
  int? count = value.count;
  value.count = (count! + 1);
  mostplayedBox.put(index, value);
}

// -----------------------recentlyplayed--function------------------------------

updateRecenltPlayed(RecentlyPlayed value, index) {
  List<RecentlyPlayed> list = recentlyplayedbox.values.toList();

  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;

  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}
