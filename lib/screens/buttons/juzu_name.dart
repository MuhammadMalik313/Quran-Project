import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quraanproject/screens/juzupage.dart';

class JuzNameWidget extends StatefulWidget {
  @override
  _JuzNameState createState() => _JuzNameState();
}

class _JuzNameState extends State<JuzNameWidget> {
  @override
  Widget build(BuildContext c) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
           primary:   Color.fromARGB(203, 11, 11, 11),
          onPrimary: Colors.white,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text('JUZ INDEX',
          style: TextStyle(fontSize: 23, fontFamily: "font1")),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GridView1()),
        );
      },
    );
  }
}

class GridView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
          title: Text("Juz Index",style: TextStyle(fontFamily: "font4", fontSize: 32),),
          centerTitle: true,
          brightness: Brightness.dark),
      body: AnimationLimiter(
        child: GridView.count(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 60),
          crossAxisCount: columnCount,
          children: List.generate(
            30,
            (int index) {
              int juzno = index + 1;
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 500),
                columnCount: columnCount,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: Container(
                      
                      margin: EdgeInsets.only(
                          bottom: _w / 30, left: _w / 60, right: _w / 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                            '   ${juzno.toString()}\nJUZ',
                            style: TextStyle(
                              fontFamily: "font5",
                              fontSize: 20,
                            ),
                            
                       
                          ),
                         
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => JuzuPage(juzno:juzno)));
                          },
                      ),
                        ),
                      
                    ),
                  ),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
