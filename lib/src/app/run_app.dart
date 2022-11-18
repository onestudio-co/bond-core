import 'dart:async';

import 'package:flutter/material.dart';

void run(Widget app, RunTasks tasks) {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      await tasks.beforeRun(widgetsBinding);

      runApp(app);

      await tasks.afterRun();
    },
    tasks.onError,
  );
}

abstract class RunTasks {
  Future<void> beforeRun(WidgetsBinding widgetsBinding);

  Future<void> afterRun();

  void onError(Object error, StackTrace stack);
}
