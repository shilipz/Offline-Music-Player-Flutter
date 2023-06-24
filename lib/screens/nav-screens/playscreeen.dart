import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/functions/add-t-fav.dart';
import 'package:tune_spot/screens/splash-screen.dart';

import '../../functions/functions.dart';

class PlayingScreen extends StatefulWidget {
  final int index;
  const PlayingScreen({super.key, required this.index});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 239, 116, 81),
        ),
        body: SingleChildScrollView(
          // ---------------------------------body-------------------
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(55),
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),

                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                              3, 3), // changes the shadow direction
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: QueryArtworkWidget(
                      id: ListOfSongs[widget.index].id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(50),
                      nullArtworkWidget: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.network(
                          'https://tunespot.files.wordpress.com/2013/03/keep-calm-and-listen-to-music-215.png?w=640',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                AddToFav(index: widget.index),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: size.width - 100,
                          child: Marquee(
                            text: ListOfSongs[widget.index].name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 239, 116, 81)),
                            blankSpace: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 250,
                              child: Marquee(
                                text: ListOfSongs[widget.index].artist,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 239, 116, 81)),
                                blankSpace: 40,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                player.builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos) {
                  return ProgressBar(
                      progressBarColor: Color.fromARGB(255, 239, 116, 81),
                      thumbColor: Color.fromARGB(255, 218, 62, 10),
                      bufferedBarColor: Colors.black,
                      baseBarColor: Colors.grey,
                      thumbGlowColor: Color.fromARGB(255, 218, 62, 10),
                      thumbGlowRadius: 15,
                      barCapShape: BarCapShape.square,
                      progress: RealtimePlayingInfos.currentPosition,
                      total: RealtimePlayingInfos.duration,
                      onSeek: (duration) {
                        player.seek(duration);
                      });
                }),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        color: const Color.fromARGB(255, 239, 116, 81),
                        iconSize: 35,
                        onPressed: () {
                          player.toggleLoop();
                        },
                        icon: const Icon(Icons.loop)),
                    // ------------------------previous starts------------------
                    IconButton(
                        color: const Color.fromARGB(255, 239, 116, 81),
                        iconSize: 35,
                        onPressed: () {
                          player.previous();
                        },
                        icon: const Icon(Icons.skip_previous)),
//-------------------previous ends--------
                    // ------------------------play or pause starts-------------------------------
                    PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                            color: const Color.fromARGB(255, 239, 116, 81),
                            iconSize: 55,
                            onPressed: () async {
                              isPlaying = !isPlaying;
                              await player.playOrPause();
                            },
                            icon: isPlaying
                                // ignore: prefer_const_constructors
                                ? Icon(Icons.pause)
                                // ignore: prefer_const_constructors
                                : Icon(Icons.play_arrow));
                      },
                    ),
                    // ------------------------play or pause ends-------------------------------
                    IconButton(
                        color: const Color.fromARGB(255, 239, 116, 81),
                        iconSize: 35,
                        onPressed: () {
                          player.next();
                        },
                        icon: const Icon(Icons.skip_next)),
                    IconButton(
                        color: const Color.fromARGB(255, 239, 116, 81),
                        iconSize: 35,
                        onPressed: () {
                          player.toggleShuffle();
                        },
                        icon: const Icon(Icons.shuffle))
                  ],
                ),
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward_rounded),
                ),
                const Text(
                  'Lyrics',
                  style: TextStyle(color: Color.fromARGB(255, 243, 68, 20)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
