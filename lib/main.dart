import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tune_spot/model/favoriteModel.dart';
import 'package:tune_spot/model/mostlyplayed_model.dart';
import 'package:tune_spot/screens/splash-screen.dart';
import 'model/playlistmodel.dart';
import 'model/songs_model.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(SongDetailsAdapter());

  await Hive.openBox<SongDetails>(boxname);

  Hive.registerAdapter(FavoriteAdapter());

  openFavoriteDatabase();

  Hive.registerAdapter(PlaylistsongzAdapter());
  openPlaylistDB();
  Hive.registerAdapter(MostlyPlayedAdapter());
  openMostPlayedDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Color.fromARGB(255, 239, 116, 81),
              titleTextStyle: TextStyle(color: Colors.white))),
      home: SplashScreen(),
    );
  }
}
