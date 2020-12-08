import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef ScanEventListener = dynamic Function(dynamic codeString);

class FlutterPluginScan {


  StreamSubscription<dynamic> _eventSubscription;
  static const MethodChannel _channel = const MethodChannel('flutter_plugin_scan');

  ScanEventListener scanEventListener;

  FlutterPluginScan() {
    initEvent();
  }

  FlutterPluginScan setFlutterPluginScan(ScanEventListener scanEventListener) {
    this.scanEventListener = scanEventListener;
    debugPrint("==========${this.scanEventListener.toString()}");
    initEvent();
    return this;
  }

  void initEvent() {
    _eventSubscription = _eventChannelFor()
        .receiveBroadcastStream()
        .listen(scanEventListener, onError: scanErrorListener);
  }

  EventChannel _eventChannelFor() {
    return EventChannel('scan_event');
  }

  void scanErrorListener(Object object) {}

   Future<String> get startScan async {
    final String codeString = await _channel.invokeMethod('startScan');
    return codeString;
  }
}
