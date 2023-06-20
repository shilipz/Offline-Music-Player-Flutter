import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:tune_spot/model/songs_model.dart';

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
