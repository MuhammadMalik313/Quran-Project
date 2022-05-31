import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class Qurancontent extends StatefulWidget {
  Qurancontent({Key? key, required this.surahno}) : super(key: key);
  int surahno;

  @override
  State<Qurancontent> createState() => _QurancontentState();
}

class _QurancontentState extends State<Qurancontent> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool playing = true;

  dynamic count;
  void initState() {
    count = widget.surahno.toString().padLeft(3, "0");
  }

  void getAudio() async {
    var url = "https://server6.mp3quran.net/wdee3/$count.mp3";

    if (playing) {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        audioPlayer.stop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 60.0,
              width: 60.0,
              child: FittedBox(
                child: GestureDetector(
                  child: FloatingActionButton(
                     backgroundColor: Color.fromARGB(255, 14, 14, 14),
                    onPressed: () {
                      getAudio();
                    },
                    child: Icon(
                      playing == true
                          ? Icons.play_circle_fill_outlined
                                  : Icons.pause_circle,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
              backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 90,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${quran.getPlaceOfRevelation(widget.surahno)}',
                      style: TextStyle(fontSize: 15, fontFamily: "font2"),
                    ),
                    Text(
                      'سورة ${quran.getSurahNameArabic(widget.surahno)}',
                      style: TextStyle(
                        // color: Color.fromARGB(255, 0, 6, 8),
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Ayath No\n    ${quran.getVerseCount(widget.surahno).toString()}',
                      style: TextStyle(fontSize: 15, fontFamily: "font2"),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/newhead4 (1).jpg",),
                  fit: BoxFit.fill
                )),
              ),
            ),
          ),
          body: ListView(children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    quran.basmala,
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.white,
                    ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: quran.getVerseCount(widget.surahno),
                  itemBuilder: (context, index) {
                    int verseno = index + 1;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            quran.getVerse(widget.surahno, verseno,
                                verseEndSymbol: true),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Image.asset(
                            "assets/7262342_preview-removebg-preview.png",
                            fit: BoxFit.fitWidth,
                            height: 10,
                            width: 500)
                      ],
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
