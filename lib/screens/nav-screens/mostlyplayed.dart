import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/model/mostlyplayed_model.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';
import 'package:tune_spot/screens/screen-pages/settings.dart';

import '../../model/songs_model.dart';

//List<SongDetails> ListOfSongs = [];

class mostplayedscreen extends StatefulWidget {
  const mostplayedscreen({super.key});

  @override
  State<mostplayedscreen> createState() => _mostplayedscreenState();
}

class _mostplayedscreenState extends State<mostplayedscreen> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  List<Audio> songz = [];
  List<MostlyPlayed> mostlyplayeslist = [];
  @override
  void initState() {
    List<MostlyPlayed> songzlist = mostplayedBox.values.toList();

    int i = 0;
    for (var item in songzlist) {
      if (item.count! > 4) {
        mostlyplayeslist.remove(item);
        mostlyplayeslist.insert(i, item);
        i++;
      }
    }
    log(songzlist.toString());
    for (var items in mostlyplayeslist) {
      songz.add(Audio.file(items.songUrl!,
          metas: Metas(
              title: items.name,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TuneSpot',
          style: TextStyle(fontSize: 26),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Settings(),
                ));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: mostplayedBox.listenable(),
              builder: (context, Box<MostlyPlayed> mstsonbox, child) {
                if (mostlyplayeslist.isEmpty) {
                  return const Center(
                    child: Text(
                      'No songs played',
                      style:
                          TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mostlyplayeslist.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          onTap: (() {
                            player.open(
                                Playlist(audios: songz, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const PlayingScreen(index: 0))));
                          }),
                          leading: QueryArtworkWidget(
                            id: mostlyplayeslist[index].id!,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            artworkBorder: BorderRadius.circular(50),
                            nullArtworkWidget: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.network(
                                'https://www.hdwallpapers.in/download/music_headphones_4k_hd_music-HD.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            mostlyplayeslist[index].name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 239, 116, 81)),
                          ),
                        );
                      }));
                }
              }),
        ],
      ),
    );
  }
}
