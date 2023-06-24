import 'dart:developer';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/functions/add-t-fav-fromlist.dart';
import 'package:tune_spot/model/playlistmodel.dart';
import 'package:tune_spot/model/recentlyplayedModel.dart';
import 'package:tune_spot/screens/playlist-portions/add-t-playlist.dart';
import 'package:tune_spot/functions/functions.dart';
import 'package:tune_spot/screens/miniplayer.dart';
import 'package:tune_spot/screens/playlist-portions/playlist_songs.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';
import 'package:tune_spot/screens/screen-pages/settings.dart';
import 'package:tune_spot/screens/splash-screen.dart';

import '../../model/mostlyplayed_model.dart';

// List<SongDetails> ListOfSongs = [];

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
                            List<MostlyPlayed> mostPlayedSongz =
                                mostplayedBox.values.toList();
                            // ignore: non_constant_identifier_names
                            MostlyPlayed MPsongz = mostPlayedSongz[index];
                            return GestureDetector(
                              onTap: () async {
                                await playMusic(index, ListOfSongs);

                                player.setLoopMode(LoopMode.playlist);
                                updateRecenltPlayed(
                                    RecentlyPlayed(
                                        songname: ListOfSongs[index].name,
                                        artist: ListOfSongs[index].artist,
                                        duration: ListOfSongs[index].duration,
                                        songurl: ListOfSongs[index].songUrl,
                                        id: ListOfSongs[index].id),
                                    index);

                                updatePlayedSongCount(MPsongz, index);

                                log(recentlyplayedbox.length.toString());
                                // ignore: use_build_context_synchronously
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
                                    child: Image.network(
                                      'https://www.hdwallpapers.in/download/music_headphones_4k_hd_music-HD.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // -----------------------------songname----------------------------------------
                                title: SizedBox(
                                    height: 55,
                                    width: 50,
                                    child: Marquee(
                                      text: ListOfSongs[index].name,
                                      style: const TextStyle(fontSize: 18),
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
                                      textDirection: TextDirection.ltr,
                                    )),

                                // -----------------------------dots icon----------------------------------------
                                trailing: IconButton(
                                    onPressed: () {
                                      print(
                                          '.................${ListOfSongs.length}.......................');
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 160,
                                            child: Column(
                                              children: [
                                                addfavtext(index: index),
                                                TextButton(
                                                    onPressed: () {
                                                      // playlistbox.values
                                                      //     .toList()[0]
                                                      //     .playlistsongs
                                                      //     .add(ListOfSongs[
                                                      //         index]);
                                                      print(
                                                          '.................${ListOfSongs.length}.......................');
                                                      // Navigator.of(context)
                                                      //     .push(
                                                      //         MaterialPageRoute(
                                                      //   builder: (context) =>
                                                      //       const addtoplaylist(
                                                      //           songIndex: 0),
                                                      // ));
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (ctx1) {
                                                            return Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      45,
                                                                      6,
                                                                      94),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 300,
                                                                decoration: BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        topRight:
                                                                            Radius.circular(20))),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
//---------------------------------------------------------(Close Button)-------------------------------------------------------------------------
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(ctx1)
                                                                              .pop();
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                                                                    SizedBox(
                                                                      height:
                                                                          230,
                                                                      width:
                                                                          200,
                                                                      child: ListView
                                                                          .builder(
                                                                        itemCount:
                                                                            playlistbox.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                idx) {
                                                                          List<Playlistsongz>
                                                                              playlists =
                                                                              playlistbox.values.toList();
                                                                          return ListTile(
                                                                            onTap:
                                                                                () {
                                                                              playlists[idx].playlistsongs.add(ListOfSongs[index]);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(playlists[idx].playlistName!),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: const Text(
                                                      'Add to playlist',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Color.fromARGB(255, 229, 115, 115),
                                    )),
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
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
