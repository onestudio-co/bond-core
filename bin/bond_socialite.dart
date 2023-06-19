import 'package:args/args.dart';
import 'dart:io';
/*
  how execute this command bond_socialite:

  1-
    chmod +x  ./bin/bond_socialite.dart

  2-
    dart ./bin/bond_socialite.dart check
    dart ./bin/bond_socialite.dart generate

 */
void main(List<String> args) {
  final currentPath = Directory.current.path;

  final parser = ArgParser();
  parser.addFlag('help',
      abbr: 'h', negatable: false, help: 'Prints usage information.');

  try {
    final results = parser.parse(args);

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

void check() async {
  var currentPath = Directory.current.path;

  var pubspecFile = File('${currentPath}/pubspec.yaml');
  var configFile = File('${currentPath}/socialite_config.dart');

  bool isPubspecExists = await pubspecFile.exists();
  if (!isPubspecExists) {
    print("Your Project not configured well, not fluuter project");
    return;
  }
  bool isConfigExists = await configFile.exists();
  if (!isConfigExists) {
    print(
        "Your Project not configured well, socialite_config.dart is missing");
    return;
  }

  print("Everything working fine ... let's go ");
}

void generate() {
  print('Generating...');
  // Implement the logic for the "generate" command
}
