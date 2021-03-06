import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_scan/flutter_plugin_scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result;

  @override
  void initState() {
    super.initState();
  }

  Future<void> startScan() async {
    FlutterPluginScan scan = FlutterPluginScan().setFlutterPluginScan((codeString) => {
      debugPrint("flutter $codeString"),
      setState((){
        if (codeString.toString().isNotEmpty){
          result = codeString ;
        }
      })
    });
    scan.startScan;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                  onPressed: () => startScan(), child: Text('onPressed')),
              Text('Scan result: $result\n'),
            ],
          ),
        ),
      ),
    );
  }
}
