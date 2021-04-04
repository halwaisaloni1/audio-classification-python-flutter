import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'audioDetails.dart';

class AudiosPage extends StatefulWidget {
  @override
  _AudiosPageState createState() => _AudiosPageState();
}

class _AudiosPageState extends State<AudiosPage> {
  Color _bgColor;
  var availableColors;

  @override
  void initState() {
    availableColors = <Color>[
      Colors.orange[200],
      Colors.teal[200],
      Colors.brown[200],
      Colors.purple[200],
      // Colors.amber.shade300,
      // Colors.blue[300],
      // Colors.red[300],
    ];
    _bgColor = availableColors[Random().nextInt(
        5)]; //You don't need setState here because init is called after every build anyway
    super.initState();
  }

  Future getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Audios').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Audios',
          style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        ),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LinearProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: availableColors[Random().nextInt(3)],
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioDetailsPage(
                              audio_name:
                                  snapshot.data[index].data()["audio_name"],
                              audio_url:
                                  snapshot.data[index].data()["audio_url"],
                              image_url:
                                  snapshot.data[index].data()["image_url"],
                            ),
                          ),
                        ),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          snapshot.data[index].data()["audio_name"],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Georgia',
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    elevation: 5,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
