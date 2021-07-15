// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle
import 'package:image/image.dart' as imgLib; // <- Dart Image Library
import 'dart:typed_data'; // Uint8List

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,//縦固定
  ]);
  runApp(MyApp());
}

// MyApp ウィジェットクラス
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      // home: MyHomePage(title: 'Dart Image Library'),
      home: const RotatedBox(
        quarterTurns: 1,
        child: Text('Hello World!'),
      )
    );
  }
}

// MyHomePage ウィジェットクラス
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// MyHomePage ステートクラス
class _MyHomePageState extends State<MyHomePage> {
  imgLib.Image _image;
  List<int> _imageBytes;

  // アセットから画像を読み込む関数
  void loadAssetImage() async {
    ByteData imageData = await rootBundle.load('images/test.png');
    _image = imgLib.decodeImage(Uint8List.view(imageData.buffer));

    // imgLib.copyRotate(_image, 90);
    // _imageBytes = imgLib.encodeJpg(_image);
    var image = imgLib.copyRotate(_image,90);
    _imageBytes = imgLib.encodeJpg(image);
    // setState((){});
  }

  // 初期化
  @override
  void initState() {
    // 初期ダミー画像作成
    _image = imgLib.Image(250, 250);
    _imageBytes = imgLib.encodeJpg(_image);

    // アセットから画像を読み込む
    loadAssetImage();

    super.initState();
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
            Text('オリジナル画像'),
            SizedBox(width: 250, height:  100, child: Image.asset('images/test.png')),

            SizedBox(height: 30),

            Text('フィルター画像'),
            SizedBox(width: 250, height: 250, child: Image.memory(_imageBytes)),

            RaisedButton(
              child: Text('フィルター'),
              onPressed: () {
                // var image = _image.clone();
                // // 画像のクローンを作成
                // imgLib.Image cloneImage = image.clone();

// リサイズされたコピーを作成
//                 var image = imgLib.copyResize(_image, width: 200);
                var image = imgLib.copyRotate(_image,180);
                // ----- フィルター処理テスト
                // imgLib.vignette(image);
                // imgLib.gaussianBlur(image, 5);
                // imgLib.grayscale(image);
                // imgLib.copyRotate(image, 120);
                // imgLib.copyResize(image,width: 120);
                // -----
                _imageBytes = imgLib.encodeJpg(image);
                setState((){});
              },
            ),
          ],
        ),
      ),
    );
  }
}