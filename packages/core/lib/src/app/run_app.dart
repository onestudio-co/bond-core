import 'dart:async';
import 'package:flutter/widgets.dart';

/// Runs the main Flutter application with additional pre and post tasks.
///
/// The [app] provides the main widget for the Flutter application.
/// [tasks] allows executing actions before and after the app is run.
void run(Widget Function() app, RunTasks tasks) {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      await tasks.beforeRun(widgetsBinding);

      runApp(app());

      await tasks.afterRun();
    },
    tasks.onError,
  );
}

/// Represents a set of tasks to run before and after the main Flutter application starts.
abstract class RunTasks {
  /// Executed before the Flutter app starts.
  Future<void> beforeRun(WidgetsBinding widgetsBinding);

  /// Executed after the Flutter app starts.
  Future<void> afterRun();

  /// Handles any errors that occur during the app run life time.
  void onError(Object error, StackTrace stack);
}
