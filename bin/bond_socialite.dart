import 'package:args/args.dart';
import 'dart:io';

import 'social/config.dart';
import 'social/providers/apple/apple_provider.dart';
import 'social/social_provider_manager.dart';
import 'social/providers/google/google_provider.dart';
import 'transaction/transaction_manager.dart';
import 'util/console.dart';

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

    if (parts.length == 1) {
      params[parts[0].replaceAll("--", "")] = "";
      continue;
    }
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

  parser.addFlag("last");
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
        printSuccess("Clear history successfully");
        break;
      case 'help':
        printSuccess('Usage: bond_socialite <command>');
        break;

      case 'rollback':
        var isLast = params.containsKey("last");

        if (isLast) {
          var sessionId = (await transactionManager.history()).last.title;
          await transactionManager.rollback(sessionId);
          printSuccess("Rollback successfully");
          break;
        }

        if (!params.containsKey('id') || params['id'] == '') {
          print("please pass transaction id into --id=12345 flag");
          return;
        }
        await transactionManager.rollback(params['id'] ?? "");
        printSuccess("Rollback successfully");
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
  } catch (e, stack) {
    printError("\n\nError on Execution: ${e}\n\n");
    printBlue("Rollback starting");

    try {
      await transactionManager.rollback(transactionManager.sessionId);
      await transactionManager.deleteSession(transactionManager.sessionId);
      printSuccess("Rollback successfully");
    } catch (e) {
      printError("Error on rollback: ${e}");
    }

    print(stack);
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

  var content = File("${Directory.current.path}/socialite_config.json")
      .readAsStringSync();

  Config config = Config.parse(content);

  await transactionManager.open();
  var manager = SocialDriverManager();
  if (config.google != null) {
    manager.addPlatform(GoogleProvider(config.google!));
  }

  if (config.apple != null) {
    manager.addPlatform(AppleProvider(config.apple!));
  }

  await manager.start();


  // await transactionManager.rollback(transactionManager.sessionId);
}
