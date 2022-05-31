import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/new_splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

late Box<PlaylistSongs> playSongBox;
late Box<Favourites> favSongsBox;
late Box<PlayListModel> playlistDB;

Future main(List<String> args) async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
    Hive.registerAdapter(PlaylistSongsAdapter());
    Hive.registerAdapter(FavouritesAdapter());
  }

  playSongBox = await Hive.openBox<PlaylistSongs>("playlist_songs");
  favSongsBox = await Hive.openBox<Favourites>("fav_songs");
  playlistDB = await Hive.openBox<PlayListModel>("playlist_name");

  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
     precacheImage( AssetImage('assets/34v1_ysvk_201215.jpg'),context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          //  accentColor: Colors.amber,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(255, 253, 251, 251),
          //  accentColor: Colors.amber,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          
          theme: theme,
          darkTheme: darkTheme,
           debugShowCheckedModeBanner: false,
          home: SplashScreen1(),
        ),
      ),
    );
  }
}
