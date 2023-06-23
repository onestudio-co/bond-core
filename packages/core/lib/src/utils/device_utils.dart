import 'dart:io';

import 'package:device_info/device_info.dart';

Future<String> deviceIdInfo() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var androidInfo = await deviceInfo.androidInfo;
    return androidInfo.androidId;
  } else if (Platform.isIOS) {
    var iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  } else {
    return 'unknown';
  }
}

String getDeviceType() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  } else {
    return 'unknown';
  }
}
