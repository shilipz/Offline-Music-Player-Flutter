import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tune_spot/screens/splash-screen.dart';
import '../model/favoriteModel.dart';
import '../model/songs_model.dart';

// ignore: must_be_immutable
class AddToFav extends StatefulWidget {
  int index;
  AddToFav({required this.index, super.key});

  @override
  State<AddToFav> createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  List<Favorite> fav = [];
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
        ? IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              favSongsDB.add(Favorite(
                  songname: ListOfSongs[widget.index].name,
                  artist: ListOfSongs[widget.index].artist,
                  duration: ListOfSongs[widget.index].duration,
                  songurl: ListOfSongs[widget.index].songUrl,
                  id: ListOfSongs[widget.index].id));
              log(favSongsDB.values.length.toString());
              setState(() {});
              // Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Added to favorite',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.green,
                ));
            },
            /*  child: const Text('Add To Favorites',
                style: TextStyle(color: Colors.black)) */
          )
        : IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
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
                // Navigator.pop(context);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Removed From Favorites',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
              }
            },
            /* child: const Text('Remove from favorite',
                style: TextStyle(color: Colors.red)) */
          );
  }
}
