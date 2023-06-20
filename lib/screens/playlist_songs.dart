import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/model/songs_model.dart';
import 'package:tune_spot/screens/playscreeen.dart';

import '../model/playlistmodel.dart';

// ignore: must_be_immutable
class PlaylistSongs extends StatefulWidget {
  List<SongDetails> allPlaylistSongs = [];
  int playlistIndex;
  String playlistName;
  PlaylistSongs(
      {required this.allPlaylistSongs,
      required this.playlistIndex,
      required this.playlistName,
      super.key});

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> plstsongs = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songUrl.toString(),
          metas: Metas(
              title: song.name, artist: song.artist, id: song.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 239, 116, 81),
        title: Text(
//-----------------------------(Appbar Title)-----------------------------------
          widget.playlistName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder<Box<Playlistsongz>>(
          valueListenable: playlistbox.listenable(),
          builder: (context, value, child) {
            List<Playlistsongz> playlistSongs = playlistbox.values.toList();
            List<SongDetails>? songz =
                playlistSongs[widget.playlistIndex].playlistsongs;
            if (songz.isEmpty) {
              return const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
                ),
              );
            }
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  return ListTile(
//--------------------------(Long Press)----------------------------------------
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(
                                'Remove From Playlist',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 239, 116, 81)),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'Are you sure?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 239, 116, 81)),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('cancel',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 239, 116, 81)))),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            plstsongs.removeAt(index);
                                            songz.removeWhere((element) =>
                                                element.id == songz[index].id);
                                            playlistbox.putAt(
                                                widget.playlistIndex,
                                                Playlistsongz(
                                                    playlistName:
                                                        widget.playlistName,
                                                    playlistsongs: songz));
                                          });
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 239, 116, 81))))
                                  ],
                                ),
                              ],
                            );
                          }));
                    },
//-------------------(On Tap[Navigating to Now Playing Screen])-----------------------------------------
                    onTap: () {
                      player.open(
                          Playlist(audios: plstsongs, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => PlayingScreen(index: index)));
                    },
//-----------------------------(Title)------------------------------------------
                    title: Text(
                      songz[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromARGB(255, 239, 116, 81),
                          fontWeight: FontWeight.w500),
                    ),
//--------------------------(leading part)--------------------------------------
                    leading: QueryArtworkWidget(
                      id: songz[index].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(50),
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: ClipRRect(
                        child: Image.asset(
                          'assets/Image/StBrARCw_400x400.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
//------------------------------------------------------------------------------
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider();
                },
                itemCount: songz.length);
          },
        ),
      ),
    );
  }
}
