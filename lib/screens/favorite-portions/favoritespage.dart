import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/screens/miniplayer.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';

import '../../model/favoriteModel.dart';

// ignore: camel_case_types
class Favorite_page extends StatefulWidget {
  const Favorite_page({super.key});

  @override
  State<Favorite_page> createState() => _Favorite_pageState();
}

// ignore: camel_case_types
class _Favorite_pageState extends State<Favorite_page> {
  List<Audio> allsongs = [];

  AssetsAudioPlayer audioplyr = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    final favsongsdb = Hive.box<Favorite>(favBoxName).values.toList();
    for (var item in favsongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        'Favorite Songs',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 239, 116, 81),
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ValueListenableBuilder<Box<Favorite>>(
                      valueListenable:
                          Hive.box<Favorite>(favBoxName).listenable(),
                      builder: ((context, Box<Favorite> allDBFavSongs, child) {
                        List<Favorite> allDBsongs =
                            allDBFavSongs.values.toList();
                        //(If songs are not there)
                        if (favSongsDB.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Text(
                              'Empty',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 239, 116, 81)),
                            ),
                          );
                        }
                        //(If the list is null)
                        // ignore: unnecessary_null_comparison
                        if (favSongsDB == null) {}
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                onTap: () {
                                  audioplyr.open(
                                      Playlist(
                                          audios: allsongs, startIndex: index),
                                      showNotification: true,
                                      headPhoneStrategy:
                                          HeadPhoneStrategy.pauseOnUnplug,
                                      loopMode: LoopMode.playlist);
                                  setState(() {});
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const PlayingScreen(
                                      index: 0,
                                    );
                                  }));
                                },
                                title: Text(
                                  allDBsongs[index].songname!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 239, 116, 81),
                                      fontWeight: FontWeight.w500),
                                ),
                                leading: QueryArtworkWidget(
                                  id: allDBsongs[index].id!,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder: BorderRadius.circular(8),
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Image.network(
                                      'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/hostedimages/1554724448i/27331681._SX540_.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeFromFavorite(context, index);
                                    },
                                    icon: const Icon(Icons.more_vert)),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider();
                            },
                            itemCount: allDBsongs.length);
                      })))
            ],
          ),
        ),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }

//--------------------------(RemoveFromFavorite Function)-----------------------
  removeFromFavorite(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Remove from Favorites',
                style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
              ),
            ),
            content: const Text(
              'Are you sure?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style:
                          TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      allsongs.removeAt(index);
                      await favSongsDB.deleteAt(index);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: const Text(
                      'Yes',
                      style:
                          TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future showOptions(BuildContext ctx) async {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx1) {
        return Container(
          color: const Color.fromARGB(255, 45, 6, 94),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.purple.shade400,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//---------------------------------------------------------(Close Button)-------------------------------------------------------------------------
                IconButton(
                    onPressed: () {
                      Navigator.of(ctx1).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    )),
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(ctx1).pop();
                          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                            content: const Text('Removed from favorite'),
                            margin: const EdgeInsets.all(10),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red.shade300,
                            duration: const Duration(seconds: 2),
                          ));
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Remove from favorite',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
