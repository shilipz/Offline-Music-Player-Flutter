import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tune_spot/model/favoriteModel.dart';
import 'package:tune_spot/model/songs_model.dart';
import 'package:tune_spot/screens/splash-screen.dart';

List<Favorite> fav = [];

// ignore: camel_case_types, must_be_immutable
class addfavtext extends StatefulWidget {
  int index;
  addfavtext({required this.index, super.key});

  @override
  State<addfavtext> createState() => _addfavtextState();
}

// ignore: camel_case_types
class _addfavtextState extends State<addfavtext> {
  bool favorited = false;
  final box = SongBox.getinstance();
  late List<SongDetails> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favSongsDB.values.toList();
    return fav
            .where(
                (element) => element.songname == ListOfSongs[widget.index].name)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favSongsDB.add(Favorite(
                  songname: ListOfSongs[widget.index].name,
                  artist: ListOfSongs[widget.index].artist,
                  duration: ListOfSongs[widget.index].duration,
                  songurl: ListOfSongs[widget.index].songUrl,
                  id: ListOfSongs[widget.index].id));
              log(favSongsDB.values.length.toString());
              setState(() {});
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Added to favorites',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color.fromARGB(255, 229, 115, 115),
                ));
            },
            child: const Text(
              'Add to favorites',
              style: TextStyle(color: Colors.black),
            ),
          )
        : TextButton(
            onPressed: () async {
              if (favSongsDB.length < 1) {
                favSongsDB.clear();
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere((element) =>
                    element.songname == ListOfSongs[widget.index].name);
                await favSongsDB.deleteAt(currentIndex);
                log(favSongsDB.values.length.toString());
                setState(() {});
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Removed from favorites',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
              }
            },
            child: const Text('Added to favorite'),
          );
  }
}
