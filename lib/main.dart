// @dart=2.9
import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:camera/camera.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_testing/next_page.dart';
import 'package:flutter_camera_testing/zoom_able.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'after_take_picture_camera_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 追加

Future<void> main() async {
  // runAppが実行される前に、cameraプラグインを初期化
  WidgetsFlutterBinding.ensureInitialized();

// デバイスで使用可能なカメラの一覧を取得する
  final cameras = await availableCameras();

  print(cameras);
// 利用可能なカメラの一覧から、指定のカメラを取得する
  final firstCamera = cameras[0];
  // runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    // runApp(new MyApp());
    runApp(CameraHome(camera: firstCamera));
  });
  // runApp(CameraHome(camera: firstCamera));
}

class CameraHome extends StatefulWidget {
  final CameraDescription camera;

  // CameraHome({required this.camera});
  // const CameraHome({Key? key, required this.camera}) : super(key: key);
  const CameraHome({this.camera});

  @override
  State<StatefulWidget> createState() => CameraHomeState();
}

class CameraHomeState extends State<CameraHome> {
  // デバイスのカメラを制御するコントローラ
  CameraController _cameraController;

  // コントローラーに設定されたカメラを初期化する関数
  Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   // DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
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
        body: Stack(
          children: [
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeCameraController,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // カメラの初期化が完了したら、プレビューを表示
                    // return CameraPreview(_cameraController);
                    return RotatedBox(
                      quarterTurns: 3,
                      child: ZoomableWidget(
                          child: CameraPreview(_cameraController),
                          onTapUp: (scaledPoint) {
                            // controller.setPointOfInterest(scaledPoint);
                          },
                          onZoom: (zoom) {
                            print('zoom');
                            if (zoom < 11) {
                              _cameraController.zoom(zoom);
                            }
                          }),
                    );
                  } else {
                    // カメラの初期化中はインジケーターを表示
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            // TextField(),
            Container(
              margin: EdgeInsets.only(top: 100,left:0),
              child: const Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                height: 100,
                width: 200,
              ),
            ),
            ElevatedButton(
              child: const Text('Button'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
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

              // 画像を表示する画面に遷移しない......
              dispose();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     // builder: (context) => CameraView(imgPath: path),
              //     //   builder: (context) => dispose()
              //   ),
              // );
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}