import 'package:args/args.dart';
import 'dart:io';

import 'transaction/transaction_manager.dart';

/*
  how execute this command bond_socialite:

  1-
    chmod +x  ./bin/bond_socialite.dart

  2-
    dart ./bin/bond_socialite.dart check
    dart ./bin/bond_socialite.dart generate

 */
void main(List<String> args) {
  final parser = ArgParser();
  parser.addCommand("rollback");
  parser.addOption("id");
  parser.addFlag('help',
      abbr: 'h', negatable: false, help: 'Prints usage information.');
  // parser.addFlag('rollback', abbr: 'r', negatable: false, help: 'Rollback .');

  try {
    final results = parser.parse(args);

    var command = results.command?.name ?? "";

    if (command == "rollback") {
      var commandArgs = results.command?.arguments ?? [];
      var sessionId = "";
      for (var value in commandArgs) {
        if (value.contains("--id")) {
          sessionId = value.replaceAll("--id=", "");
          break;
        }
      }

      if (sessionId.trim() == '') {
        print("please pass transaction id into --id flag");
        return;
      }

      TransactionManager().rollback(sessionId);
      return;
    }

    if (results['help'] as bool) {
      print('Usage: bond_socialite <command>');
      // Print additional help information if needed
    } else {
      // Handle different commands and execute appropriate actions
      // Example: `bond_socialite generate`
      if (results.rest.isNotEmpty) {
        final command = results.rest[0];
        switch (command) {
          case 'check':
            check();
            break;
          case 'generate':
            generate();
            break;
          case 'history':
            history();
            break;
          default:
            print('Unknown command: $command');
        }
      } else {
        print(
            'No command provided. Use "bond_socialite help" to see available commands.');
      }
    }
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

Future<bool> check() async {
  var currentPath = Directory.current.path;

  var pubspecFile = File('${currentPath}/pubspec.yaml');
  var configFile = File('${currentPath}/socialite_config.dart');

  bool isPubspecExists = await pubspecFile.exists();
  if (!isPubspecExists) {
    print("Your Project not configured well, not fluuter project");
    return false;
  }
  bool isConfigExists = await configFile.exists();
  if (!isConfigExists) {
    print("Your Project not configured well, socialite_config.dart is missing");
    return false;
  }
  return true;
}

void history() async {
  var historyList = await TransactionManager().history();
  for (var value in historyList) {
    print("ID: ${value.title}  Date: ${value.date}");
  }
}

void generate() async {
  if (!await check()) {
    return;
  }

  await TransactionManager().open();
  print('Generating...');
  // Implement the logic for the "generate" command
}
