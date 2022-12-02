import 'dart:io';

import 'package:one_studio_core/src/injection/injection_container.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Api {
  static Map<String, String> Function()? extraHeaders;

  static Map<String, String> headers({Map<String, String>? extra}) {
    Map<String, String> map = <String, String>{};
    map['content-type'] = 'application/json';
    map['Accept'] = 'application/json';
    if (Platform.isIOS || Platform.isAndroid) {
      map['app-versionName'] = sl<PackageInfo>().version;
      map['app-version'] = sl<PackageInfo>().buildNumber;
    }
    if (extraHeaders != null) {
      map.addAll(extraHeaders!());
    }
    if (extra != null) {
      map.addAll(extra);
    }
    return map;
  }
}
