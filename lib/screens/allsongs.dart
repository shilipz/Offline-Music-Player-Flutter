import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/screens/functions.dart';
import 'package:tune_spot/screens/miniplayer.dart';
import 'package:tune_spot/screens/playscreeen.dart';
import 'package:tune_spot/screens/settings.dart';
import 'package:tune_spot/screens/splash-screen.dart';

import '../functions/add-t-fav.dart';

class AllSongs extends StatefulWidget {
  final int index;
  const AllSongs({super.key, required this.index});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      // -----------------------------stackimage----------------------------------------
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                            Positioned(
                                left: 30,
                                top: 40,
                                right: 30,
                                bottom: 40,
                                child: Image.network(
                                  'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
                                  width: 250,
                                ))
                          ],
                        ),

                        // -----------------------------stackimage ends----------------------------------------
                        const SizedBox(height: 20),
                        // ----------------------------listviewbuilder----------------------------------------
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ListOfSongs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await playMusic(index, ListOfSongs);

                                player.setLoopMode(LoopMode.playlist);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    playingList
                                        .add(Audio(ListOfSongs[index].songUrl));
                                    return PlayingScreen(
                                      index: index,
                                    );
                                  },
                                ));
                              },
                              child: ListTile(
                                // -----------------------------songimage----------------------------------------
                                leading: QueryArtworkWidget(
                                  id: ListOfSongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkFit: BoxFit.cover,
                                  artworkQuality: FilterQuality.high,
                                  size: 2000,
                                  quality: 100,
                                  artworkBorder: BorderRadius.circular(50),
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Image.asset(
                                      'assets/Image/StBrARCw_400x400.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // -----------------------------songname----------------------------------------
                                title: SizedBox(
                                    height: 35,
                                    width: 50,
                                    child: Marquee(
                                      text: ListOfSongs[index].name,
                                      style: TextStyle(fontSize: 18),
                                      blankSpace: 25,
                                      // numberOfRounds: 3,
                                      textDirection: TextDirection.ltr,
                                    )),
                                // -----------------------------artistname----------------------------------------
                                subtitle: SizedBox(
                                    height: 15,
                                    width: 50,
                                    child: Marquee(
                                      text: ListOfSongs[index].artist,
                                      blankSpace: 25,
                                      // numberOfRounds: 3,
                                      textDirection: TextDirection.rtl,
                                    )),

                                // -----------------------------dots icon----------------------------------------
                                trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 100,
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    AddToFav(index: index);
                                                  },
                                                  child:
                                                      Text('Add to favourites'),
                                                ),
                                                TextButton(
                                                    onPressed: () {},
                                                    child:
                                                        Text('Add to playlist'))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert)),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: MiniPlayer(),
      ),
    );
  }
}
