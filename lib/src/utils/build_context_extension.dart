import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
