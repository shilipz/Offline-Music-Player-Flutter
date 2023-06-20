import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tune_spot/screens/artist.dart';
import 'package:tune_spot/screens/playlist.dart';
import 'package:tune_spot/screens/search.dart';

import 'homescreen.dart';

class nav_bar extends StatefulWidget {
  const nav_bar({super.key});

  @override
  State<nav_bar> createState() => _nav_barState();
}

final screens = [
  const Homescreen(),
  const SearchScreen(),
  const PlayList(),
  const Artists(),
];

class _nav_barState extends State<nav_bar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final items = <CurvedNavigationBarItem>[
    const CurvedNavigationBarItem(
      child: Icon(Icons.home),
    ),
    const CurvedNavigationBarItem(
      child: Icon(Icons.search),
    ),
    const CurvedNavigationBarItem(
      child: Icon(Icons.library_music),
    ),
    const CurvedNavigationBarItem(
      child: Icon(Icons.person),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            color: Color.fromARGB(255, 239, 116, 81),
            key: navigationKey,
            height: 60,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Color.fromARGB(255, 239, 116, 81),
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ));
  }
}
