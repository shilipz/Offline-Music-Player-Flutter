import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/model/recentlyplayedModel.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';

class Recentlyplayedscreen extends StatefulWidget {
  const Recentlyplayedscreen({super.key});

  @override
  State<Recentlyplayedscreen> createState() => _RecentlyplayedscreenState();
}

class _RecentlyplayedscreenState extends State<Recentlyplayedscreen> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> rsongsz = [];
  @override
  void initState() {
    List<RecentlyPlayed> rpsongs =
        recentlyplayedbox.values.toList().reversed.toList();

    for (var item in rpsongs) {
      rsongsz.add(Audio.file(item.songurl!,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          )));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TuneSpot'),
      ),
      body: Column(
        children: [
          const Text(
            'Your Recent Plays',
            style: TextStyle(fontSize: 32, color: Colors.red),
          ),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: recentlyplayedbox.listenable(),
                  builder: (context, Box<RecentlyPlayed> recentsongs, child) {
                    List<RecentlyPlayed> rsongs = recentsongs.values.toList();
                    if (rsongs.isEmpty) {
                      return const Center(
                        child: Text('No songs played yet'),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: rsongs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              player.open(
                                  Playlist(audios: rsongsz, startIndex: index),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplug,
                                  loopMode: LoopMode.playlist);
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PlayingScreen(index: 0),
                                  ));
                            },
                            leading: QueryArtworkWidget(
                              id: rsongs[index].id!,
                              type: ArtworkType.AUDIO,
                              artworkFit: BoxFit.cover,
                              artworkQuality: FilterQuality.high,
                              artworkBorder: BorderRadius.circular(50),
                              nullArtworkWidget: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.asset(
                                  'assets/Image/StBrARCw_400x400.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              rsongs[index].songname!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        });
                  }))
        ],
      ),
    );
  }
}
