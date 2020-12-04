import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginScan {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_scan');

  static Future<String> get startScan async {
    final String name = await _channel.invokeMethod('startScan');
    return name;
  }
}
