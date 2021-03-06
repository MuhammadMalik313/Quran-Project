import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quraanproject/HomePage/home_page.dart';
import 'package:quraanproject/screens/play_audio.dart';
import 'package:quran/quran.dart' as quran;

class AudioName extends StatefulWidget {
  const AudioName({Key? key}) : super(key: key);

  @override
  State<AudioName> createState() => _AudioNameState();
}


//*******************************************play audio button **********************************/

class _AudioNameState extends State<AudioName> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          primary:  Color.fromARGB(203, 11, 11, 11),
          elevation: 5,
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text(
        'PLAY AUDIO',
        style: TextStyle(fontSize: 23, fontFamily: "font1"),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SlideAnimation4()),
        );
      },
    );
  }
}

class SlideAnimation4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){return HomePage();})
           );
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.black,
          title: Text("Audio Index",style: TextStyle(fontFamily: "font4", fontSize: 30),),
          centerTitle: true,
          brightness: Brightness.dark,
           actions: [ IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Mysearch1());
              },
              icon: const Icon(Icons.search))],
        ),
        body: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: 114,
            itemBuilder: (BuildContext context, int index) {
              int surahno = index + 1;
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      child: ListTile(
                        title: Text(
                          quran.getSurahName(surahno),
                          style: TextStyle(fontSize: 20, fontFamily: "font3"),
                        ),
                        subtitle: Text(quran.getSurahNameEnglish(surahno)),
                        trailing: Icon(
                          Icons.play_circle_outline_rounded,
                          size: 35,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>PlayAudio(index: surahno,)));
                        },
                    
                      ),
                      margin: EdgeInsets.only(bottom: _w / 20),
                      height: _w / 5,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
}


class Mysearch1 extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }
  var quranList=[];
  
    
  
  @override
  Widget buildSuggestions(BuildContext context) {
    quranList.clear();
    for(var i=1;i<=114;i++){
      quranList.add(quran.getSurahName(i));
      
      
    }
    final List listItems;
    if (query.isEmpty) {
      listItems = quranList;
    } else {
      listItems = quranList
            .where((element) => element
                .toLowerCase()
                .contains(query.toLowerCase().toString()))
            .toList();

    }
           

    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
            

              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                     ListTile(
                      
                      title: Text(
                        listItems[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "font3",
                        ),
                      ),
                     
                      onTap: () {
                        var i=quranList.indexOf(listItems[index])+1;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ( PlayAudio(index:i))));
                      },
                    ),
                      
                    ],
                  ));
            });
  }
}
