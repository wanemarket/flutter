import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOpenWhatsapp {
  String? mobileNo;
  String? msg;

  static const MethodChannel _channel =
      const MethodChannel('open_whatsapp');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> sendSingleMessage(mobileNo, msg) async{
    await _channel.invokeMethod('sendSingleMessage', {'mobileNo': mobileNo, 'message': msg});
  }
}
