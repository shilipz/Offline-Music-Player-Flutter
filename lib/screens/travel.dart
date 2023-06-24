import 'dart:ui';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tune_spot/screens/screen-pages/homescreen.dart';
import 'package:tune_spot/screens/playlist-portions/library.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';
import 'package:tune_spot/screens/screen-pages/search.dart';

import 'screen-pages/shazam.dart';
import 'miniplayer.dart';

class travel extends StatefulWidget {
  const travel({super.key});

  @override
  State<travel> createState() => _travelState();
}

class _travelState extends State<travel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 239, 116, 81),
        ),
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: SizedBox(
            child: Column(
              children: [
                Stack(
                  // alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
                      fit: BoxFit.cover,
                      // width: double.infinity,
                      // height: double.infinity,
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 50),
                      child: Positioned(
                        child: Image.network(
                          'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
                          width: 250,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(children: [
                      const SizedBox(
                        child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 239, 116, 81),
                            radius: 25),
                      ),
                      Positioned(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            )),
                      ),
                    ]),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_rounded)),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) => PlayingScreen(index: 0),
                      )),
                  child: ListTile(
                    title: const Text(
                      'Song Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color.fromARGB(255, 239, 116, 81)),
                    ),
                    subtitle: const Text('Movie',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 239, 116, 81))),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ),
                ),
              ],
            ),
          ),
        ),
        //-------------------------bottomnav--------------------------------------
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.search),
              label: 'Search',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.folder),
              label: 'Library',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity),
              label: 'Artists',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    // ignore: prefer_const_constructors
                    MaterialPageRoute(builder: (context) => Homescreen()));
                break;
              case 1:
                Navigator.push(
                    // ignore: prefer_const_constructors
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                break;
              case 2:
                Navigator.push(
                    context,
                    // ignore: prefer_const_constructors
                    MaterialPageRoute(builder: (context) => Library()));
                break;
              case 3:
                Navigator.push(
                    context,
                    // ignore: prefer_const_constructors
                    MaterialPageRoute(builder: (context) => Artists()));
                break;
            }
          },
          // ----------------------------miniplayer-----------------------------
          // ignore: prefer_const_constructors
        ),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
