import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tune_spot/model/songs_model.dart';

import '../../model/playlistmodel.dart';

// ignore: camel_case_types
class addtoplaylist extends StatefulWidget {
  final int songIndex;
  const addtoplaylist({required this.songIndex, super.key});

  @override
  State<addtoplaylist> createState() => _addtoplaylistState();
}

// ignore: camel_case_types
class _addtoplaylistState extends State<addtoplaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 239, 116, 81),
            title: const Text(
              'Tunespot',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
            )),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ValueListenableBuilder(
              valueListenable: playlistbox.listenable(),
              builder: (context, Box<Playlistsongz> playlistboxz, child) {
                List<Playlistsongz> playlistsz = playlistboxz.values.toList();

                if (playlistboxz.isEmpty) {
                  return Center(
                    child: Text(
                      'Empty',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: playlistsz.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.folder_open,
                            color: Colors.red[300],
                          ),
                          title: Text(playlistsz[index].playlistName.toString(),
                              style: TextStyle(color: Colors.red[300])),
                          onTap: () {
                            Playlistsongz? plsongs = playlistboxz.getAt(index);
                            List<SongDetails>? plNewSongs =
                                plsongs!.playlistsongs;
                            Box<SongDetails> box = Hive.box(boxname);
                            List<SongDetails> AllDBSongz = box.values.toList();
                            bool isAllreadyAdded = plNewSongs.any((element) =>
                                element.id == AllDBSongz[widget.songIndex].id);

                            if (!isAllreadyAdded) {
                              plNewSongs.add(SongDetails(
                                  name: AllDBSongz[widget.songIndex].name,
                                  artist: AllDBSongz[widget.songIndex].artist,
                                  duration:
                                      AllDBSongz[widget.songIndex].duration,
                                  songUrl: AllDBSongz[widget.songIndex].songUrl,
                                  id: AllDBSongz[widget.songIndex].id));

                              playlistboxz.putAt(
                                  index,
                                  Playlistsongz(
                                      playlistName:
                                          playlistsz[index].playlistName,
                                      playlistsongs:
                                          playlistsz[index].playlistsongs));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        '${AllDBSongz[widget.songIndex].name} Added To ${playlistsz[index].playlistName}',
                                        style:
                                            TextStyle(color: Colors.red[300]),
                                      )));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        '${AllDBSongz[widget.songIndex].name} is already added',
                                        style:
                                            TextStyle(color: Colors.red[300]),
                                      )));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                        );
                      }),
                );
              }),
        ));
  }
}
