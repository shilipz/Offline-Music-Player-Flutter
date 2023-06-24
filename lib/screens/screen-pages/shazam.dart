import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:tune_spot/screens/miniplayer.dart';
import 'package:tune_spot/screens/screen-pages/settings.dart';

class Artists extends StatefulWidget {
  const Artists({super.key});

  @override
  State<Artists> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  @override
  void initState() {
    ACRCloud.setUp(const ACRCloudConfig(
        '9c6db6bfe4aa40e0300f03154b0968a7',
        'T8ExqY4IFj9pyLLiE5jejvgOtz4pUw1FszOobydb',
        'identify-ap-southeast-1.acrcloud.com'));
    super.initState();
  }

  ACRCloudResponseMusicItem? music;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    log('message');
                    setState(() {
                      music = null;
                    });

                    final session = ACRCloud.startSession();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text('Listening...'),
                        content: StreamBuilder(
                          stream: session.volumeStream,
                          initialData: 0,
                          builder: (_, snapshot) =>
                              Text(snapshot.data.toString()),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: session.cancel,
                          )
                        ],
                      ),
                    );

                    final result = await session.result;
                    Navigator.pop(context);

                    if (result == null) {
                      // Cancelled.
                      return;
                    } else if (result.metadata == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No result.'),
                      ));
                      return;
                    }

                    setState(() {
                      music = result.metadata!.music.first;
                    });
                    log(music?.title != null ? 'yes' : 'no');
                    log(music?.title ?? '');
                  },
                  child: Image.asset('assets/images/shazam.jpg'),
                ),
              ),
            )
          ],
        ),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
