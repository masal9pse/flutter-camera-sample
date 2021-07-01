import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  // runAppが実行される前に、cameraプラグインを初期化
  WidgetsFlutterBinding.ensureInitialized();

// デバイスで使用可能なカメラの一覧を取得する
  final cameras = await availableCameras();

  print(cameras);
// 利用可能なカメラの一覧から、指定のカメラを取得する
  final firstCamera = cameras[0];
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home:  Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}