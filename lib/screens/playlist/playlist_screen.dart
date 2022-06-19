import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quraanproject/functions/db_functions.dart';
import 'package:quraanproject/main.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/playlist/playlist_videos.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    final _playListController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Playlist", style: TextStyle(fontFamily: "font4", fontSize: 33),),
          actions: [
          ],
        ),
        body: Column(
          children: [
            Padding(
              //#########################################
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _playListController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Add Your playlist"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final _playlist = _playListController.text;
                      if (_playlist.isEmpty) {
                        return;
                      }
                      print("$_playlist");
                      final _playlist1 = PlayListModel(name: _playlist);
                      addPlaylist(_playlist1);
                      final snackBar = SnackBar(
                        content: Container(
                            child: const Text(
                          'Added to playlist',
                          // style: TextStyle(color: Colors.white),
                        )),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              //#########################################
              child: ValueListenableBuilder(
                valueListenable: playlistDB.listenable(),
                builder: (BuildContext ctx, Box<PlayListModel> playlist,
                    Widget? child) {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        PlayListModel data = playlist.getAt(index)!;
                        final GlobalKey _menuKey = GlobalKey();

                        showAlertDialog(BuildContext context) {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Playlist()));
                            },
                          );
                          Widget continueButton = FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              deletePlaylist(data.name);
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Playlist()));
                            },
                          );
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            // title: Text("AlertDialog"),
                            content: Text("Do you want to delete?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );
                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }

                        return ListTile(
                          trailing: PopupMenuButton(
                              key: _menuKey,
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text("Remove"),
                                      onTap: () {
                                        Future.delayed(
                                            const Duration(seconds: 0),
                                            () => showAlertDialog(context));
                                      

                                        showAlertDialog(context);
                                        Navigator.pop(context, false);
                                      },
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      onTap: () {
                                        print("Clicked");
                                      },
                                      value: 2,
                                    ),
                                  ],
                              onSelected: (value) {
                                if (value == 2) {
                                  playlistPopup(
                                      context: context, oldName: data.name);
                                }
                              }),
                          onTap: () {
                            print("object"); //####go to play list song section
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaylistSong(
                                  playlistName: data.name,
                                ),
                              ),
                            );
                          },
                          title: Text(data.name),
                        );
                      }),
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          thickness: 1,
                        );
                      },
                      itemCount: playlist.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  playlistPopup({required context, required oldName}) {
    //popup items
    final GlobalKey<FormState> _formKey =
        GlobalKey(); //currentstate.validate not work without <FormState>
    TextEditingController _textController =
        TextEditingController(text: oldName);
    showDialog(
        context: context,
        builder: (context) => Form(
              key: _formKey,
              child: AlertDialog(
                title: Text("Add Playlist"),
                content: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: "Playlist"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Playlist Name";
                    } else if (checkPlaylistExists(value).isNotEmpty) {
                      return "Playlist already exists";
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        editPlayDB(
                            oldValue: oldName,
                            newValue: _textController.text.trim());
                        final snackBar =
                            SnackBar(content: Text("Playlist Added"));
                      }
                    },
                    child: Text(
                      "Add",
                    ),
                  ),
                ],
              ),
            ));
  }

//check playlist exists or not
  checkPlaylistExists(value) {
    List<PlayListModel> currentList = playlistDB.values.toList();
    var contains = currentList.where((element) => element.name == value);
    //no duplicaate items in the list of objects
    return contains;
  }

  editPlayDB({
    required String oldValue,
    required String newValue,
  }) {
    final Map<dynamic, PlayListModel> playlistNameMap = playlistDB.toMap();
    dynamic desiredKey;
    playlistNameMap.forEach((key, value) {
      if (value.name == oldValue) desiredKey = key;
    });
    final playlistObj = PlayListModel(name: newValue);
    playlistDB.put(
        desiredKey, playlistObj); //playlist name changed successfully

    PlaylistSongs playVideos;
    final Map<dynamic, PlaylistSongs> playlistVideoMap = playSongBox.toMap();
    playlistVideoMap.forEach((key, value) {
      if (value.playListName == oldValue) {
        PlaylistSongs playVideos = PlaylistSongs(
            playListName: newValue, chapterNo: value.chapterNo, song: "");
        playSongBox.put(key, playVideos);
      }
    });
    Navigator.pop(context);
  }
}
