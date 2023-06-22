import 'dart:convert';
import 'dart:io';

import 'transaction_history.dart';

extension FileExtention on FileSystemEntity {
  String get name {
    return path.split("/").last;
  }
}

class TransactionManager {
  final sessionId = '${DateTime.now().millisecondsSinceEpoch}';
  static final TransactionManager _singleton = TransactionManager._internal();
  final projectPath = Directory.current.path;
  final bondBuildPath = '${Directory.current.path}/.bond';

  String get currentSessionFolder =>
      '${Directory.current.path}/.bond/$sessionId';

  final Map<String, String> _files = {
    "main.dart": "lib/main.dart",
    "build.gradle": "android/build.gradle",
  };

  factory TransactionManager() {
    return _singleton;
  }

  TransactionManager._internal();

  Future<void> _check() async {
    var isDirectoryExists = await Directory(bondBuildPath).exists();
    if (!isDirectoryExists) {
      await Directory(bondBuildPath).create();
    }
    await Directory('$bondBuildPath/$sessionId').create();
  }

  Future<void> open() async {
    await _check();
    await saveInfoMetaData();
    await backupFiles();
  }

  Future<void> backupFiles() async {
    Directory backupFile = Directory('${bondBuildPath}/${sessionId}/files');
    if (!await backupFile.exists()) {
      await backupFile.create();
    }

    for (var file in _files.values) {
      var source = '$projectPath/$file';
      var to = '$bondBuildPath/$sessionId/files/${file.split('/').last}';
      await _copyFile(source, to);
    }
  }

  Future<Directory> createFolder(String name) async {
    return await Directory('$bondBuildPath/$name').create();
  }

  Future<void> saveInfoMetaData() async {
    var metadata = """
DATE:     ${DateTime.now()}
PROJECT:  ${Directory(bondBuildPath).name}
    """;

    var file = File('$bondBuildPath/$sessionId/metadata.txt');
    await file.create();
    await file.writeAsString(metadata);
  }

  Future<void> _copyFile(String source, String target) async {
    var file = File(source);

    if (await file.exists()) {
      var targetFile = File(target);
      if (!await targetFile.exists()) {
        await targetFile.create();
      }
      await file.copy(target);
    }
  }

  Future<List<TransactionHistory>> history() async {
    List<TransactionHistory> lst = [];

    var build = Directory(bondBuildPath);

    var transactions = build.list();

    for (var transaction in (await transactions.toList())) {
      var lines = await File('${transaction.path}/metadata.txt')
          .openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
          .toList();

      var date = "";
      for (var value in lines) {
        if (value.contains("DATE")) {
          date = value.replaceAll("DATE:     ", "");
        }
      }
      var transactionHistory = TransactionHistory(transaction.name, date);
      lst.add(transactionHistory);
    }
    lst.sort((i,d) => i.date.compareTo(d.title));
    return lst;
  }

  void rollback(String sessionId) async {
    for (var key in _files.keys) {
      var source = '$bondBuildPath/$sessionId/files/$key';
      var target = '$projectPath/${_files[key]}';
      await _copyFile(source, target);
    }
  }
}
