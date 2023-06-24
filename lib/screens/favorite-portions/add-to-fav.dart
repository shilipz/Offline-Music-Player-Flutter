import 'package:flutter/material.dart';

import '../../model/favoriteModel.dart';
import '../../model/songs_model.dart';

// ignore: must_be_immutable
class AddToFavo extends StatefulWidget {
  int index;
  AddToFavo({required this.index, super.key});

  @override
  State<AddToFavo> createState() => _AddToFavoState();
}

class _AddToFavoState extends State<AddToFavo> {
  List<Favorite> fav = [];
  bool favorited = false;
  final box = SongBox.getinstance();
  late List<SongDetails> dbSongs = box.values.toList();

  @override
  void initState() {
    dbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favSongsDB.values.toList();
    return fav
            .where((element) => element.songname == dbSongs[widget.index].name)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favSongsDB.add(Favorite(
                  songname: dbSongs[widget.index].name,
                  artist: dbSongs[widget.index].artist,
                  duration: dbSongs[widget.index].duration,
                  songurl: dbSongs[widget.index].songUrl,
                  id: dbSongs[widget.index].id));
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Added to Favorites",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color.fromARGB(255, 229, 115, 115),
              ));
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ))
        : IconButton(
            onPressed: () async {
              if (favSongsDB.length < 1) {
                favSongsDB.clear();
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere(
                    (element) => element.id == dbSongs[widget.index].id);
                await favSongsDB.deleteAt(currentIndex);
                setState(() {});
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "Removed From Favorites",
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.green,
                ));
              }
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ));
  }
}
