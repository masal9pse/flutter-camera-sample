// @dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// import 'package:ar_war/cam.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    home: Cam(),
  ));
}

class Cam extends StatefulWidget {
  @override
  _Cam createState() => _Cam();
}

class _Cam extends State<Cam> {
  final ImagePicker _picker = ImagePicker();
  String imageText = "";
  String statusText = "";
  File localImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タイトルです'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            statusText,
            style: TextStyle(fontSize: 16),
          ),
          Container(
            height: 100,
            child: localImageFile != null
                ? Image.file(localImageFile)
                : Text(imageText),
          ),
          RaisedButton(
              child: Text("Choose Image"),
              onPressed: () async {
                try {
                  final pickedFile =
                      await _picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    localImageFile = File(pickedFile.path);
                    statusText = "Image Chosen";
                  });
                } catch (e) {
                  setState(() {
                    imageText = "Error selecting image";
                  });
                }
              }),
        ],
      )),
    );
  }
}
