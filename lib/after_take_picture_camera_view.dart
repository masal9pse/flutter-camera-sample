import 'dart:io';

import 'package:flutter/material.dart';
// dart2.9をつけて修正すると、カメラ撮影後に移動するかどうかのチェック
class CameraView extends StatelessWidget {
  // 表示する画像のパス
  final String imgPath;

  // 画面のコンストラクタ
  const CameraView({required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Picture'),
        ),
        body: Column(
          // Imageウィジェットで画像を表示する
          children: [Expanded(child: Image.file(File(imgPath)))],
        )
    );
  }
}