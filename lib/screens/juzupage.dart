import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class JuzuPage extends StatelessWidget {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
   JuzuPage({ Key? key, required this.juzno  }) : super(key: key);
  int? juzno;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
     title: Text('Juzu $juzno',style: TextStyle(fontFamily: "font4", fontSize: 30),),
   
  ),
  body: SfPdfViewer.network(
    'https://islamic1articleshome.files.wordpress.com/2020/05/13-line-tajwidi-quran-sipara-$juzno-pdf.pdf',
    key: _pdfViewerKey,
  ),
);
  }
}