import 'package:flutter/material.dart';
import 'package:tune_spot/screens/miniplayer.dart';
import 'package:tune_spot/screens/settings.dart';

class Artists extends StatefulWidget {
  const Artists({super.key});

  @override
  State<Artists> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Artists',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 239, 116, 81))),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 239, 116, 81),
                        size: 36,
                      ))
                ],
              ),
              SizedBox(height: 25),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    GridTile(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Color.fromARGB(255, 239, 116, 81),
                        child: Image.network(
                            'https://c.saavncdn.com/editorial/Let_sPlayVineethSreenivasan_20221115192524.jpg'),
                      ),
                    ),
                    GridTile(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Color.fromARGB(255, 239, 116, 81),
                        child: Image.network(
                            'https://a10.gaanacdn.com/gn_pl_img/playlists/Dk9KN2KBx1/9KNnkArqKB/size_m_1585119235.webp'),
                      ),
                    ),
                    GridTile(
                      child: CircleAvatar(
                        radius: 100,
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Color.fromARGB(255, 239, 116, 81),
                          child: Image.network(
                              'https://tamil894fm.com/wp-content/uploads/2021/07/Dhanus.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: MiniPlayer(),
      ),
    );
  }
}
