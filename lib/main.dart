import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/new_splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    
    precacheImage(AssetImage("assets/34v1_ysvk_201215.jpg"), context);
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "THE HOLY QURAN",
       
       theme: ThemeData(brightness: Brightness.dark),
        home:  SplashScreen1());
  }
}
