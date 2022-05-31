import 'dart:ffi';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quraanproject/screens/audio_name.dart';
import 'package:quraanproject/screens/buttons/favourite_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/buttons/chapter_name.dart';
import '../screens/buttons/juzu_name.dart';
import '../screens/buttons/settingsbutton.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future setData()async{
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("alreadyUsed", true);       
  }
  @override 
  Void? initState(){
    super.initState();
    setData();

  }
  @override
  Widget build(BuildContext context) {
    
    var _size = MediaQuery.of(context).size;
      
    var _arabiccalender = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat.yMMMMd('en_US');
    var formatted = format.format(day);
    String tdata = DateFormat("hh:mm  a").format(DateTime.now());
   

    return WillPopScope(
      onWillPop: () async{SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              
              children: [
                Stack(
                  children: [
                    Container(
                      height: _size.height * 0.50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: const DecorationImage(
                        image: AssetImage("assets/34v1_ysvk_201215.jpg",),
                        
                        
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    _arabiccalender.longMonthName.toString(),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 95, 94, 95),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "font2"),
                                  ),
                                )),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      _arabiccalender.hDay.toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(255, 76, 75, 76),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "font2"),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "${_arabiccalender.hYear} AH",
                                      style: const TextStyle(
                                          fontFamily: "font2",
                                          fontSize: 21,
                                          color:  Color.fromARGB(255, 76, 75, 76),)
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              formatted,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 76, 75, 76),
                                  fontFamily: "font2"),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              tdata,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color:  Color.fromARGB(255, 53, 7, 7),
                                  fontFamily: "font2"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              
                const ChapterButton(),
                const SizedBox(
                  height: 20,
                ),
                JuzNameWidget(),
                const SizedBox(
                  height: 20,
                ),
                const AudioName(),
                const SizedBox(
                  height: 20,
                ),
                const FavouritesButton(),
                const SettingsButton(),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}


