// @dart=2.9
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
// import 'package:ar_war/cam.dart';
import 'package:flutter/services.dart';
List<CameraDescription> cameras;
Future<void> main() async {
  // これを追加しないと動かない
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  print(3333);
  cameras = await availableCameras();
  // print(cameras);
  runApp(MaterialApp(
    home: Cam(),
  ));
}


class Cam extends StatefulWidget {
  // @override
  //   const MyApp({Key key, @required this.camera}) : super(key: key);

  _Cam createState() => _Cam();
}

class _Cam extends State<Cam> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: NativeDeviceOrientationReader(builder: (context) {
        NativeDeviceOrientation orientation =
        NativeDeviceOrientationReader.orientation(context);

        int turns;
        switch (orientation) {
          case NativeDeviceOrientation.landscapeLeft:
            turns = -1;
            break;
          case NativeDeviceOrientation.landscapeRight:
            turns = 1;
            break;
          case NativeDeviceOrientation.portraitDown:
            turns = 2;
            break;
          default:
            turns = 0;
            break;
        }

        // return RotatedBox(
        //   quarterTurns: turns,
        //   child: Transform.scale(
        //     scale: 1 / controller.value.aspectRatio,
        //     child: Center(
        //       child: AspectRatio(
        //         aspectRatio: controller.value.aspectRatio,
        //         child: CameraPreview(controller),
        //       ),
        //     ),
        //   ),
        // );
        return RotatedBox(
          quarterTurns: turns,
            child: Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
        );
        // return RotatedBox(
        //     child: AspectRatio(
        //       aspectRatio: controller.value.aspectRatio,
        //       child: CameraPreview(controller),
        //     ),
        // );
      }),
    );
  }
}