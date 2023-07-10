import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: LoginForm(),
      ),
    ),
  );
}
