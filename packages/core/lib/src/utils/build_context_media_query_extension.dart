import 'package:flutter/widgets.dart';

/// An extension on `BuildContext` to provide more intuitive access to
/// properties and methods related to screen properties and media queries.
extension MediaQueryContext on BuildContext {
  /// Returns the current screen height in logical pixels.
  ///
  /// Usage:
  /// ```dart
  /// final height = context.screenHeight;
  /// ```
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the current screen width in logical pixels.
  ///
  /// Usage:
  /// ```dart
  /// final width = context.screenWidth;
  /// ```
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Checks if the current orientation is landscape.
  ///
  /// Usage:
  /// ```dart
  /// if (context.isLandscape) {
  ///   // Landscape mode specific logic
  /// }
  /// ```
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}
