import 'package:flutter/material.dart';

import 'miniplayer.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  Widget griditem({
    required String title,
    required Image plyimage,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color.fromARGB(255, 239, 116, 81),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.pexels.com/photos/209035/pexels-photo-209035.jpeg?cs=srgb&dl=pexels-pixabay-209035.jpg&fm=jpg',
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .7,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.white,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Library',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 239, 116, 81)),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 239, 116, 81),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: const Text(' Your Playlists')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return griditem(
                      title: 'title',
                      plyimage: Image.network(
                          'https://images.pexels.com/photos/209035/pexels-photo-209035.jpeg?cs=srgb&dl=pexels-pixabay-209035.jpg&fm=jpg'));
                },
              )
            ],
          ),
        ),
        bottomSheet: MiniPlayer(),
      ),
    );
  }
}
