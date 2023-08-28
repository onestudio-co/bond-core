import 'dart:developer';

import 'package:bond_core/bond_core.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart';

class RunAppTasks extends RunTasks {
  @override
  Future<void> beforeRun(WidgetsBinding widgetsBinding) async {
    await init();
  }

  @override
  Future<void> afterRun() async {}

  @override
  void onError(Object error, StackTrace stack) {
    log('Error: $error', stackTrace: stack);
  }
}
