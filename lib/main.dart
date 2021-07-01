import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:camera/camera.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'after_take_picture_camera_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // runAppが実行される前に、cameraプラグインを初期化
  WidgetsFlutterBinding.ensureInitialized();

// デバイスで使用可能なカメラの一覧を取得する
  final cameras = await availableCameras();

  print(cameras);
// 利用可能なカメラの一覧から、指定のカメラを取得する
  final firstCamera = cameras[0];
  // runApp(MyApp());
  runApp(CameraHome(camera: firstCamera));
}

class CameraHome extends StatefulWidget {
  final CameraDescription camera;

  // CameraHome({required this.camera});
  const CameraHome({Key? key, required this.camera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CameraHomeState();
}

class CameraHomeState extends State<CameraHome> {
  // デバイスのカメラを制御するコントローラ
  late CameraController _cameraController;

  // コントローラーに設定されたカメラを初期化する関数
  late Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();

    // ②
    // コントローラを初期化
    _cameraController = CameraController(
        // 使用するカメラをコントローラに設定
        widget.camera,
        ResolutionPreset.max);
    // ③
    // コントローラーに設定されたカメラを初期化
    _initializeCameraController = _cameraController.initialize();
  }

  // ④
  @override
  void dispose() {
    // ウィジェットが破棄されたタイミングで、カメラのコントローラを破棄する
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('カメラ画面'),
        ),
        // FutureBuilderを実装
        body: FutureBuilder<void>(
          future: _initializeCameraController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // カメラの初期化が完了したら、プレビューを表示
              return CameraPreview(_cameraController);
            } else {
              // カメラの初期化中はインジケーターを表示
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera_alt),
          // ボタンが押下された際の処理
          onPressed: () async {
            try {
              // 画像を保存するパスを作成する
              final path = join(
                (await getApplicationDocumentsDirectory()).path,
                '${DateTime.now()}.png',
              );
              print(12345);
              print(path);
              // カメラで画像を撮影する
              await _cameraController.takePicture(path);

              // 画像を表示する画面に遷移
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraView(imgPath: path),
                ),
              );
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}
