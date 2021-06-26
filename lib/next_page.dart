import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Picture'),
        ),
        body: Container(
          height: double.infinity,
          color: Colors.red,
        )
    );
  }

}