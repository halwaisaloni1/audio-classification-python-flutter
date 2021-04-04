import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';
import './global/shader.dart';
import 'package:styled_text/styled_text.dart';

class AudioDetailsPage extends StatefulWidget {
  String audio_name, audio_url, image_url;

  AudioDetailsPage({
    this.audio_name,
    this.audio_url,
    this.image_url,
  });
  @override
  _AudioDetailsPageState createState() => _AudioDetailsPageState();
}

class _AudioDetailsPageState extends State<AudioDetailsPage> {
  MusicPlayer musicPlayer;
  bool isPlaying = false, isPaused = false, isStopped = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Audio Track',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Container(
        // color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.audio_name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Image.network(
                        widget.image_url,
                        height: 350,
                      ),
                      elevation: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isPlaying = true;
                                isPaused = false;
                                isStopped = false;
                              });
                              musicPlayer.play(
                                MusicItem(
                                  trackName: '',
                                  albumName: '',
                                  artistName: '',
                                  url: widget.audio_url,
                                  coverUrl: '',
                                  duration: Duration(seconds: 255),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.play_circle_outline_outlined,
                              color: isPlaying ? Colors.blue : Colors.black,
                              size: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isPaused = true;
                                isPlaying = false;
                                isStopped = false;
                              });
                              musicPlayer.pause();
                            },
                            child: Icon(
                              Icons.pause_circle_outline_outlined,
                              color:
                                  isPaused ? Colors.amberAccent : Colors.black,
                              size: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isStopped = true;
                                isPlaying = false;
                                isPaused = false;
                              });
                              musicPlayer.stop();
                            },
                            child: Icon(
                              Icons.stop_circle_outlined,
                              color: isStopped ? Colors.red[400] : Colors.black,
                              size: 50,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Classification',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          foreground: Paint()..shader = linearGradient,
                          fontFamily: 'Georgia'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StyledText(
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                ),
                                text:
                                    '<bold>Air Conditioner</bold>    <para>65%</para>',
                                styles: {
                                  'bold': TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  'para': TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                },
                                textAlign: TextAlign.center,
                              ),
                            ),
                            elevation: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StyledText(
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                ),
                                text:
                                    '<bold>Dog Bark</bold>    <para>15%</para>',
                                styles: {
                                  'bold': TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  'para': TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                },
                                textAlign: TextAlign.center,
                              ),
                            ),
                            elevation: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StyledText(
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                ),
                                text:
                                    '<bold>Drilling</bold>    <para>11%</para>',
                                styles: {
                                  'bold': TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  'para': TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                },
                                textAlign: TextAlign.center,
                              ),
                            ),
                            elevation: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StyledText(
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                ),
                                text:
                                    '<bold>Jackhammer</bold>    <para>9%</para>',
                                styles: {
                                  'bold': TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  'para': TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                },
                                textAlign: TextAlign.center,
                              ),
                            ),
                            elevation: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
