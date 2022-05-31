import 'package:quraanproject/main.dart';
import 'package:quraanproject/model/data_model.dart';


Future<void> addPlaylist(PlayListModel value) async {
  final values = playlistDB.values.toList();
  var isExists = values.where((element) => element.name == value.name);//if already added playlist exist then use the if case
  if (isExists.isEmpty) {
    await playlistDB.add(value);

    print("Playlist Added ");
  } else {
    print("Playlist Exists");
  }


  print(value.toString());
}



deletePlaylist(String playSongId) async {
  final Map<dynamic, PlayListModel> deliveriesMap = playlistDB.toMap();
  dynamic desiredKey;
  deliveriesMap.forEach((key, value) {
    if (value.name == playSongId){
      desiredKey = key;
    } 
  });
  playlistDB.delete(desiredKey);
}

editPlaylist({
  required oldValue,
  required newValue,
  required index,
}) async {
  //change playlist name only
  final Map<dynamic, PlayListModel> deliveriesMap = playlistDB.toMap();
  dynamic desiredKey;
  deliveriesMap.forEach((key, value) {
    if (value.name == oldValue) desiredKey = key;
  });
  PlayListModel playModel = PlayListModel(name: newValue);
  playlistDB.put(desiredKey, playModel);

  //change song playlist name
  final Map<dynamic, PlaylistSongs> playSongMap = playSongBox.toMap();
  playSongMap.forEach((key, value) {
    if (value.playListName == oldValue) desiredKey = key;
    PlaylistSongs playSongsModel =
        PlaylistSongs(playListName: newValue, chapterNo: index, song: '');
    playSongBox.put(desiredKey, playSongsModel);
  });
}
