import 'package:args/args.dart';
import 'package:file_based_transaction_manager/transaction_manager.dart';
import 'dart:io';

import 'social/config.dart';
import 'social/providers/apple/apple_provider.dart';
import 'social/social_provider_manager.dart';
import 'social/providers/google/google_provider.dart';
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
var session = transactionManager.beginSession();

void main(List<String> args) async {
  var isValidProject = await check();

  if (!isValidProject) {
    printError("Please, Check you are working on Flutter project");
    return;
  }

  final manager = SocialManager();
  final parser = ArgParser();

  parser.addFlag("last");
  parser.addFlag("debug");
  parser.addOption("id");

  parser.addCommand("help");
  parser.addCommand("check");
  parser.addCommand("generate");
  parser.addCommand("history");
  parser.addCommand("rollback");
  parser.addCommand("clear");

  final results = parser.parse(args);
  var params = getParams(results.command?.arguments ?? []);
  try {
    var command = results.command?.name ?? "";

    switch (command) {
      case 'clear':
        transactionManager.close(session);
        printSuccess("Clear history successfully");
        break;
      case 'help':
        printSuccess('Usage: bond_socialite <command>');
        break;

      case 'rollback':
        var isLast = params.containsKey("last");

        if (isLast) {
          var sessionId = (await transactionManager.history()).last.title;
          await transactionManager.rollbackById(sessionId);
          await manager.rollback();
          printSuccess("Rollback successfully");

          break;
        }

        if (!params.containsKey('id') || params['id'] == '') {
          print("please pass transaction id into --id=12345 flag");
          return;
        }
        await transactionManager.rollbackById(params['id'] ?? "");
        await manager.rollback();

        printSuccess("Rollback successfully");
        break;
      case 'generate':
        await generate(manager);
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
      transactionManager.rollback(session);
      transactionManager.close(session);
      printSuccess("Rollback successfully");
    } catch (e) {
      printError("Error on rollback: ${e}");
    }

    if (params.containsKey("debug")) {
      printError("\n\nBond Stacktrace: \n\n");
      print("$stack");
    }
  }
}

Future<bool> check() async {
  var currentPath = Directory.current.path;
  var pubspecFile = File('$currentPath/pubspec.yaml');
  var configFile = File('$currentPath/socialite_config.json');

  bool isPubspecExists = await pubspecFile.exists();
  if (!isPubspecExists) {
    printError("Your Project not configured well, not flutter project");
    return false;
  }
  bool isConfigExists = await configFile.exists();
  if (!isConfigExists) {
    printError(
        "Your Project not configured well, socialite_config.json is missing");
    return false;
  }
  return true;
}

Future<void> history() async {
  var historyList = await transactionManager.history();
  for (var value in historyList) {
    printWarning("ID: ${value.title}  Date: ${value.date}");
  }
}

Future<void> generate(SocialManager manager) async {
  if (!await check()) {
    return;
  }

  var content = File("${Directory.current.path}/socialite_config.json")
      .readAsStringSync();

  Config config = Config.parse(content);

  if (config.google != null) {
    manager.addPlatform(GoogleProvider(config.google!));
  }

  if (config.apple != null) {
    manager.addPlatform(AppleProvider(config.apple!));
  }

  await manager.start();
}
