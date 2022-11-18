import 'dart:async';

import 'package:flutter/material.dart';

void run(Widget app, RunTasks tasks) {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      tasks.beforeRun(widgetsBinding);

      runApp(app);

      tasks.afterRun();
    },
    tasks.onError,
  );
}

abstract class RunTasks {
  void beforeRun(WidgetsBinding widgetsBinding);

  void afterRun();

  void onError(Object error, StackTrace stack);
}
