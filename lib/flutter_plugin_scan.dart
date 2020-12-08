import 'dart:async';

import 'package:flutter/services.dart';

typedef ScanEventListener = dynamic Function(dynamic codeString);

class FlutterPluginScan {
  ScanEventListener scanEventListener;
  StreamSubscription<dynamic> _eventSubscription;

  FlutterPluginScan() {
    initEvent();
  }

  setFlutterPluginScan(ScanEventListener scanEventListener) {
    this.scanEventListener = scanEventListener;
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

  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_scan');

  static Future<String> get startScan async {
    final String name = await _channel.invokeMethod('startScan');
    return name;
  }
}
