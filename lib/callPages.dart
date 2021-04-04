import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'audios.dart';
import 'upload.dart';
import 'homePage.dart';

class CallPages extends StatefulWidget {
  @override
  _CallPagesState createState() => _CallPagesState();
}

class _CallPagesState extends State<CallPages> {
  final AudiosPage _audiosPage = AudiosPage();
  final UploadPage _uploadPage = UploadPage();
  final HomePage _homePage = HomePage();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homePage;
        break;
      case 1:
        return _uploadPage;
        break;
      case 2:
        return _audiosPage;
        break;
      default:
        return _homePage;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        color: Colors.amberAccent,
        buttonBackgroundColor: Colors.blue[300],
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 400),
        items: <Widget>[
          Icon(Icons.graphic_eq, size: 30),
          Icon(Icons.upload_rounded, size: 30),
          Icon(Icons.record_voice_over, size: 30),
        ],
        onTap: (index) {
          setState(
            () {
              _showPage = _pageChooser(index);
            },
          );
          debugPrint('Test $index');
        },
        letIndexChange: (index) => true,
      ),
      body: _showPage,
    );
  }
}
