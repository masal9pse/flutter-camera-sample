// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'image_gallery_saver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  // 画像の読み込み
  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);//カメラ
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);//アルバム

    if(pickedFile != null) {
      setState((){
        _image = File(pickedFile.path);
      });
    }
  }

  // 画像の保存
  Future _saveImage() async {
    if(_image != null) {
      Uint8List _buffer = await _image.readAsBytes();
      final result = await ImageGallerySaver.saveImage(_buffer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image),
            RaisedButton(
              child: Text('Save'),
              onPressed: _saveImage,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}