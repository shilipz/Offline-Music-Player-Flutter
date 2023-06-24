//------------------------------(MiniPlayer)------------------------------------
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/functions/functions.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  // AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      log('playing');
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 239, 116, 81),
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
                //---------------------------(On tap)-------------------------------------------
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    // ignore: prefer_const_constructors
                    return PlayingScreen(index: 0);
                  }));
                },
                //---------------------------(Image)--------------------------------------------
                leading: QueryArtworkWidget(
                  id: int.parse(playing.audio.audio.metas.id!),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/Image/mostlyPlayed.jpeg'),
                  ),
                  artworkFit: BoxFit.fill,
                ),
                //---------------------------(Title)--------------------------------------------
                title: Marquee(
                  text: player.getCurrentAudioTitle,
                  blankSpace: 90,
                  style: const TextStyle(color: Colors.white),
                ),
                //---------------------------(Controls)-----------------------------------------
                trailing: PlayerBuilder.isPlaying(
                    player: player,
                    builder: (context, isPlaying) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await player.previous();
                                setState(() {});
                                if (isPlaying == false) {
                                  player.pause();
                                }
                              },
                              // ignore: prefer_const_constructors
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () async {
                                await player.playOrPause();
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () async {
                                await player.next();
                                setState(() {});
                                if (isPlaying == false) {
                                  player.pause();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              )),
                        ],
                      );
                    }))),
      );
    });
  }
}
