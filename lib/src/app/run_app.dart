import 'package:flutter/material.dart';

void run(Widget app, RunTasks tasks) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  tasks.beforeRun(widgetsBinding);

  runApp(app);

  tasks.afterRun();
}

abstract class RunTasks {
  void beforeRun(WidgetsBinding widgetsBinding);

  void afterRun();
}
