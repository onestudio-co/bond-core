import 'package:args/args.dart';
import 'dart:io';

import 'social/SocialDriverManager.dart';
import 'social/providers/google/GoogleDriver.dart';
import 'transaction/transaction_manager.dart';
import 'util/console.dart';
import 'util/file.dart';

/*
  how execute this command bond_socialite:

  1-
    chmod +x  ./bin/bond_socialite.dart

  2-
    dart ./bin/bond_socialite.dart check
    dart ./bin/bond_socialite.dart generate

 */

Map<String, String> getParams(List<String> commandArgs) {
  Map<String, String> params = {};

  for (var arg in commandArgs) {
    var delimiter = arg.contains(" ") ? " " : "=";
    var parts = arg.split(delimiter);
    if (parts.length != 2) {
      continue;
    }
    if (parts[0] == '') {
      continue;
    }
    var key = parts[0].replaceAll("--", "");
    var value = parts[1];
    params[key] = value;
  }

  return params;
}

var transactionManager = TransactionManager();

void main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption("id");

  parser.addCommand("help");
  parser.addCommand("check");
  parser.addCommand("generate");
  parser.addCommand("history");
  parser.addCommand("rollback");
  parser.addCommand("clear");

  try {
    final results = parser.parse(args);
    var params = getParams(results.command?.arguments ?? []);
    var command = results.command?.name ?? "";

    switch (command) {
      case 'clear':
        await transactionManager.clear();
        break;
      case 'help':
        printSuccess('Usage: bond_socialite <command>');
        break;

      case 'rollback':
        if (!params.containsKey('id') || params['id'] == '') {
          print("please pass transaction id into --id=12345 flag");
          return;
        }
        await transactionManager.rollback(params['id'] ?? "");

        break;
      case 'generate':
        await generate();
        break;
      case 'history':
        await history();
        break;
      default:
        print(
            'No command provided. Use "bond_socialite help" to see available commands.');
        break;
    }
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

Future<bool> check() async {
  var currentPath = Directory.current.path;
  var pubspecFile = File('$currentPath/pubspec.yaml');
  var configFile = File('$currentPath/socialite_config.json');

  bool isPubspecExists = await pubspecFile.exists();
  if (!isPubspecExists) {
    print("Your Project not configured well, not flutter project");
    return false;
  }
  bool isConfigExists = await configFile.exists();
  if (!isConfigExists) {
    print("Your Project not configured well, socialite_config.json is missing");
    return false;
  }
  return true;
}

Future<void> history() async {
  var historyList = await transactionManager.history();
  for (var value in historyList) {
    print("ID: ${value.title}  Date: ${value.date}");
  }
}

Future<void> generate() async {
  if (!await check()) {
    return;
  }
  await transactionManager.open();
  var manager = SocialDriverManager();
  manager.addPlatform(GoogleDriver());

  manager.start();
}
