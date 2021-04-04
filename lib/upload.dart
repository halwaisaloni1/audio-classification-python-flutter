import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _imageUploaded = false, _audioUploaded = false;
  TextEditingController audioName = TextEditingController();
  FilePickerResult imagePicker, audioPicker;
  File image, audio;
  String imagePath, audioPath;
  Reference ref;
  var image_down_url, audio_down_url;
  final firestoreInstance = FirebaseFirestore.instance;

  void selectImage() async {
    imagePicker = await FilePicker.platform.pickFiles();

    if (imagePicker != null) {
      setState(
        () {
          imagePicker = imagePicker;
          image = File(imagePicker.files.single.path);
          imagePath = basename(image.path);
          uploadImageToFirebase(image.readAsBytesSync(), imagePath);
        },
      );
    }
  }

  Future<String> uploadImageToFirebase(
    List<int> image,
    String imagepath,
  ) async {
    ref = FirebaseStorage.instance.ref().child(imagepath);
    UploadTask uploadTask = ref.putData(image);

    image_down_url = await (await uploadTask).ref.getDownloadURL();
  }

  void selectAudio() async {
    audioPicker = await FilePicker.platform.pickFiles();

    if (audioPicker != null) {
      setState(
        () {
          audioPicker = audioPicker;
          audio = File(audioPicker.files.single.path);
          audioPath = basename(audio.path);
          uploadAudioToFirebase(audio.readAsBytesSync(), audioPath);
        },
      );
    }
  }

  Future<String> uploadAudioToFirebase(
    List<int> audio,
    String audiopath,
  ) async {
    ref = FirebaseStorage.instance.ref().child(audiopath);
    UploadTask uploadTask = ref.putData(audio);

    audio_down_url = await (await uploadTask).ref.getDownloadURL();
  }

  finalUpload(context) {
    if (audioName.text != '' &&
        audio_down_url != null &&
        image_down_url != null) {
      print(audioName.text);
      print(audio_down_url);
      print(image_down_url.toString());

      var data = {
        "audio_name": audioName.text,
        "audio_url": audio_down_url.toString(),
        "image_url": image_down_url.toString(),
      };
      firestoreInstance
          .collection('Audios')
          .doc()
          .set(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            _onTapButton(context, "Please Enter All Details :("),
      );
    }
  }

  _onTapButton(BuildContext context, data) {
    return AlertDialog(title: Text(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload an Audio',
          style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Material(
                            elevation: 7,
                            shadowColor: Colors.black,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: ClipOval(
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    selectAudio();
                                    setState(() {
                                      _audioUploaded = !_audioUploaded;
                                    });
                                  },
                                  splashColor: Colors.red, // inkwell color
                                  child: SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.music_note_rounded,
                                      size: 50,
                                      color: Colors.blueGrey[900],
                                    ),
                                  ),
                                ),
                                color: _audioUploaded
                                    ? Colors.green
                                    : Colors.blue[200], // button color
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Material(
                            elevation: 3,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 38,
                              width: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: RaisedButton(
                                shape: StadiumBorder(),
                                onPressed: () => {
                                  selectImage(),
                                  setState(() {
                                    _imageUploaded = !_imageUploaded;
                                  })
                                },
                                color: _imageUploaded
                                    ? Colors.green
                                    : Colors.blue[200],
                                child: Text(
                                  "Select Image for audio",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Georgia',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(25),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.all(
                                Radius.circular(120),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(60, 5, 60, 7),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.redAccent[700],
                                  ),
                                  controller: audioName,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.text_snippet_outlined,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Enter a name for the audio",
                                    hintStyle: TextStyle(
                                      color: Colors.blueGrey[700],
                                      fontFamily: 'Georgia',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            color: Colors.teal[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () => {
                              finalUpload(context),
                              setState(() {
                                if (_imageUploaded != false) {
                                  _imageUploaded = !_imageUploaded;
                                }
                                if (_audioUploaded != false) {
                                  _audioUploaded = !_audioUploaded;
                                }
                                audioName.text = '';
                              })
                            },
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
