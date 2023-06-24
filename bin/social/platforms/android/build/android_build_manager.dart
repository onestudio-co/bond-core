import 'dart:io';

import '../../../../util/console.dart';
import '../../../../util/file.dart';
import 'android_build_interface.dart';

class AndroidBuildManager implements AndroidBuildInterface {
  @override
  Future<bool> build() async {
    var result =
        await Process.run('bash', ['-c', 'cd android && ./gradlew build']);

    if (result.exitCode != 0) {
      printError("android build: error    =>\n${result.stderr}");
    }
    return result.exitCode == 0;
  }

  @override
  Future<void> prepareEnv() async {
    var buildFile = File("${Directory.current.path}/android/app/build.gradle");

    if (!buildFile.existsSync()) {
      throw Exception(
          "Error on Configure android, missing file: /android/app/build.gradle");
    }

    var lines = await buildFile.linesIndexed();
    MapEntry minSdkVersion = const MapEntry(-1, "");
    MapEntry targetSdkVersion = const MapEntry(-1, "");
    MapEntry compileSdkVersion = const MapEntry(-1, "");

    lines.forEach((key, value) {
      if (value.contains("minSdkVersion")) {
        minSdkVersion = MapEntry(key, value);
      }

      if (value.contains("targetSdkVersion")) {
        targetSdkVersion = MapEntry(key, value);
      }
      if (value.contains("compileSdkVersion")) {
        compileSdkVersion = MapEntry(key, value);
      }
    });

    if (minSdkVersion.key == -1 ||
        targetSdkVersion.key == -1 ||
        compileSdkVersion.key == -1) {
      throw Exception(
          "Error on Configure android, invalid content of  /android/app/build.gradle missing one of the following: [minSdkVersion, targetSdkVersion, compileSdkVersion]");
    }

    lines[minSdkVersion.key] = "        minSdkVersion 22";
    lines[targetSdkVersion.key] = "        targetSdkVersion 30";
    lines[compileSdkVersion.key] = "    compileSdkVersion 33";

    buildFile.writeAsStringSync(lines.values.join("\n"));
  }
}
