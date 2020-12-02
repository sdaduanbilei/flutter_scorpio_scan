import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginScan {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_scan');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get platformName async {
    final String name = await _channel.invokeMethod('getPlatformName');
    return name;
  }
}
