import 'package:flutter/material.dart';
import 'package:tune_spot/model/favoriteModel.dart';
import 'package:tune_spot/screens/favorite-portions/favoritespage.dart';
import 'package:tune_spot/screens/nav-screens/mostlyplayed.dart';
import 'package:tune_spot/screens/nav-screens/recentlyplayedscreen.dart';
import 'package:tune_spot/screens/screen-pages/settings.dart';
import 'package:tune_spot/screens/splash-screen.dart';

import '../../model/songs_model.dart';
import '../nav-screens/allsongs.dart';
import '../miniplayer.dart';

//List<SongDetails> ListOfSongs1 = [];

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //-----------tilescode----------
  Widget hometiles({
    required IconData icon,
    required String tilename,
    required String songcount,
  }) {
    return ListTile(
      leading: IconButton(
          iconSize: 30,
          color: const Color.fromARGB(255, 239, 116, 81),
          onPressed: () {},
          icon: Icon(icon)),
      title: Text(
        tilename,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 239, 116, 81)),
      ),
      subtitle: Text(songcount,
          style: const TextStyle(
              fontSize: 16, color: Color.fromARGB(255, 239, 116, 81))),
    );
  } //-----------tilescode----------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        // ------------------------------------------------appbarstarts----------------------------------------
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
        // -------------------------------------------------------appbarends------------------------------------------------------
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ----------------------------------------------------sizedbox--------------------------------------------------------
              const SizedBox(height: 12),
// ----------------------------------------------------main image--------------------------------------------------------
              Image.network(
                'https://i.pinimg.com/736x/06/b8/79/06b8799badb3f7537e350590e480b7cb.jpg',
                width: double.infinity,
                height: 200,
              ),

              // ----------------------------------------------------sizedbox--------------------------------------------------------
              const SizedBox(height: 22),
// ----------------------------------------------------home page tiles--------------------------------------------------------
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      print(
                          '................${ListOfSongs.length}.................');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (
                              context,
                            ) =>
                                const AllSongs(index: 0),
                          ));
                    },
                    child: hometiles(
                        icon: Icons.playlist_play,
                        tilename: 'All songs',
                        songcount: ListOfSongs.length.toString()),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Favorite_page()));
                    },
                    child: hometiles(
                        icon: Icons.favorite_outline_rounded,
                        tilename: 'Favourites',
                        songcount: favSongsDB.length.toString()),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mostplayedscreen()));
                    },
                    child: hometiles(
                        icon: Icons.loop,
                        tilename: 'Mostly played',
                        songcount: ''),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Recentlyplayedscreen(),
                    )),
                    child: hometiles(
                        icon: Icons.recent_actors,
                        tilename: 'Recently played',
                        songcount: ' '),
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
