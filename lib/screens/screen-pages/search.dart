import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_spot/screens/nav-screens/playscreeen.dart';
import 'package:tune_spot/screens/screen-pages/settings.dart';
import 'package:tune_spot/screens/splash-screen.dart';
import '../../model/songs_model.dart';

List<SongDetails> searchsongs = List.from(dbSongs);
List<SongDetails> dbSongs = ListOfSongs;
final TextEditingController searchcontroller = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer.withId('0');
  // var box = SongBox.getinstance();
  // List<SongDetails> searchsongs = List.from(dbSongs);
  // List<SongDetails> dbSongs = ListOfSongs;
  List<Audio> allsongs = [];

  @override
  void initState() {
    dbSongs = box.values.toList();
    for (var item in dbSongs) {
      allsongs.add(Audio.file(item.songUrl,
          metas: Metas(
              title: item.name, artist: item.artist, id: item.id.toString())));
    }
    super.initState();
  }

  late List<SongDetails> DBSongs = List.from(dbSongs);

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
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 182, 167),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: searchcontroller,
                          onChanged: (value) => searchList(value),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//---------------------(search History)-----------------------------------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: searchsongs.isEmpty
                    ? const Center(
                        child: Text(
                          'search song',
                          style: TextStyle(
                              color: Color.fromARGB(255, 239, 116, 81)),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (ctx, index) {
                          SongDetails songz = searchsongs[index];
                          return ListTile(
                              onTap: (() {
                                _audioplayer.open(
                                    Playlist(
                                        audios: allsongs, startIndex: index),
                                    showNotification: true,
                                    headPhoneStrategy:
                                        HeadPhoneStrategy.pauseOnUnplug,
                                    loopMode: LoopMode.playlist);
                                setState(() {});
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const PlayingScreen(
                                              index: 0,
                                            ))));
                              }),
                              title: Text(
                                songz.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              leading: QueryArtworkWidget(
                                id: songz.id,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(50),
                                nullArtworkWidget: ClipRRect(
                                  child: Image.asset(
                                    'assets/Image/StBrARCw_400x400.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ));
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: searchsongs.length),
              ),
            )
          ],
        ));
  }

  void searchList(String value) {
    log(ListOfSongs.length.toString());
    setState(() {
      searchsongs = ListOfSongs.where((element) =>
          element.name.toLowerCase().contains(value.toLowerCase())).toList();
      allsongs.clear();
      for (var item in searchsongs) {
        allsongs.add(
          Audio.file(
            item.songUrl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.name,
              id: item.id.toString(),
            ),
          ),
        );
      }
    });
  }
}
