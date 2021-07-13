import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _incrementCounter() {
    // 2.呼び出されると状態が更新されて画面に反映される
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width - 10,
          height: MediaQuery
              .of(context)
              .size
              .height - 80,
          padding: EdgeInsets.all(20),
          color: Colors.blue,
          child: Column(
            children: [
              RaisedButton(
                  child: Text('Exitです'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red
              )
            ],
          )
      ),
    );
  }
}