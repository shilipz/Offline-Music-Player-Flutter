import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tune_spot/model/songs_model.dart';
import 'package:tune_spot/screens/playlist_songs.dart';
import 'package:tune_spot/screens/settings.dart';

import '../model/playlistmodel.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final TextEditingController _texteditingcontroller = TextEditingController();
  final TextEditingController _updateController = TextEditingController();

  List<Playlistsongz> playlist = [];
  final formGlobalKey = GlobalKey<FormState>();
  final updateformglobalkey = GlobalKey<FormState>();

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
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 239, 116, 81),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

// //--------------------------(Sizebox)-------------------------------------------
              const SizedBox(
                height: 20,
              ),
//---------------------(Custom Playlists)---------------------------------------
              ValueListenableBuilder<Box<Playlistsongz>>(
                  valueListenable: playlistbox.listenable(),
                  builder: ((context, Box<Playlistsongz> plylstBox, child) {
                    List<Playlistsongz> playList = plylstBox.values.toList();
                    if (playlistbox.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 100, left: 100),
                        child: Text(
                          "You have no playlist !",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 239, 116, 81),
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => PlaylistSongs(
                                          allPlaylistSongs:
                                              playList[index].playlistsongs,
                                          playlistIndex: index,
                                          playlistName:
                                              playList[index].playlistName!))));
                                },
                                title: Text(
                                  playList[index].playlistName.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 239, 116, 81),
                                      fontWeight: FontWeight.w500),
                                ),
                                leading: const Icon(
                                  Icons.folder_open,
                                  color: Color.fromARGB(255, 239, 116, 81),
                                  size: 50,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: const Color.fromARGB(
                                            255, 239, 116, 81),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: ((context) {
                                          return SizedBox(
                                            height: 130,
                                            child: Column(children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    List<SongDetails>?
                                                        existingSongz =
                                                        playList[index]
                                                            .playlistsongs;
                                                    editName(
                                                        context,
                                                        index,
                                                        playList[index]
                                                            .playlistName!,
                                                        existingSongz);
                                                  },
                                                  child: const Text(
                                                    'Update Name',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    deletePlaylist(
                                                        context, index);
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ]),
                                          );
                                        }));
                                  },
                                  icon: const Icon(Icons.more_vert),
                                  color:
                                      const Color.fromARGB(255, 239, 116, 81),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider();
                            },
                            itemCount: playList.length),
                      );
                    }
                  }))
            ],
          ),
        ),
      ),
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------(Floating Action Button)------------------------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 239, 116, 81),
        onPressed: () {
          addPlaylist(context);
        },
        child: const Icon(Icons.playlist_add, color: Colors.white),
      ),
    );
  }

//----------------------(Add_playlist)------------------------------------------
  Future<void> addPlaylist(BuildContext context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Add New Playlist',
                style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
              ),
            ),
            content:
//-----------------------(Add Playlist)-----------------------------------------
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: formGlobalKey,
                        child: TextFormField(
                          controller: _texteditingcontroller,
                          cursorHeight: 25,
                          decoration: const InputDecoration(
                              filled: true,
                              //fillColor: Color.fromARGB(199, 255, 255, 255),
                              hintText: 'Enter Name',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 239, 116, 81))),
                          validator: (value) {
                            List<Playlistsongz> values =
                                playlistbox.values.toList();
                            bool isAllreadyadded = values
                                .where((element) =>
                                    element.playlistName == value!.trim())
                                .isNotEmpty;
                            if (value!.trim() == '') {
                              return 'Name required';
                            }
                            if (isAllreadyadded) {
                              return 'Name already exists';
                            }
                            return null;
                          },
                        ))),
            actions: [
              TextButton(
                  onPressed: () {
                    final isValid = formGlobalKey.currentState!.validate();
                    if (isValid) {
                      playlistbox.add(Playlistsongz(
                          playlistName: _texteditingcontroller.text,
                          playlistsongs: []));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
                  ))
            ],
          );
        }));
  }

//-----------------------------(functions)--------------------------------------
//---------------------------------------------(Update_playlist)-------------------------------------------------------------------------------
  editName(BuildContext context, int index, String existingName,
      List<SongDetails> existSongs) async {
    showDialog(
        context: context,
        builder: ((context) {
          _updateController.text = existingName;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Enter New Name',
                style: TextStyle(color: Color.fromARGB(255, 239, 116, 81)),
              ),
            ),
            content:
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: updateformglobalkey,
                      child: TextFormField(
                          controller: _updateController,
                          cursorHeight: 25,
                          decoration: const InputDecoration(
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white)),
                          validator: (value) {
                            List<Playlistsongz> values =
                                playlistbox.values.toList();
                            // ignore: unused_local_variable
                            bool isAlreadyExist = values
                                .where((element) =>
                                    element.playlistName == value!.trim())
                                .isNotEmpty;
                            if (value!.trim() == '') {
                              return 'Name required';
                            }
                            return null;
                          }),
                    )),
            actions: [
              TextButton(
                  onPressed: () {
                    final isvalid =
                        updateformglobalkey.currentState!.validate();
                    if (isvalid) {
                      playlistbox.putAt(
                          index,
                          Playlistsongz(
                              playlistName: _updateController.text,
                              playlistsongs: existSongs));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        }));
  }

//---------------------------------------------(Delete conformation)------------------------------------------------------------------------
  Future<void> deletePlaylist(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Delete',
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
                    onPressed: () {
                      playlistbox.deleteAt(index);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
}
