import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tune_spot/model/mostlyplayed_model.dart';
import 'package:tune_spot/model/songs_model.dart';
import 'package:tune_spot/screens/navigation_bar.dart';

// ignore: non_constant_identifier_names
List<SongDetails> ListOfSongs = [];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();
final box = SongBox.getinstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullsongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SongFetch fetch = SongFetch();
    fetch.fetching();
    Timer(
        // ignore: prefer_const_constructors
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            // ignore: prefer_const_constructors
            context,
            MaterialPageRoute(builder: (context) => const nav_bar())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 116, 81),
        body: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 76,
                color: Colors.white,
              ),
              Text(
                'TUNESPOT',
                style: TextStyle(
                    fontFamily: 'RussoOne', fontSize: 50, color: Colors.white),
              )
            ],
          ),
        ));
  }
}

class SongFetch {
  final OnAudioQuery audioQuery = OnAudioQuery();
  permissionRequest() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  fetching() async {
    bool status = await permissionRequest();
    if (status) {
      List<SongModel> fetchsong = await audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);
      for (SongModel element in fetchsong) {
        if (element.fileExtension == "mp3") {
          ListOfSongs.add(SongDetails(
            name: element.displayNameWOExt,
            artist: element.artist!,
            duration: element.duration!,
            id: element.id,
            songUrl: element.uri!,
          ));
          for (var elements in ListOfSongs) {
            mostplayedBox.add(MostlyPlayed(
                name: elements.name,
                artist: elements.artist,
                id: elements.id,
                duration: elements.duration,
                songUrl: elements.songUrl,
                count: 0));
          }
        }
      }
    }
  }
}
