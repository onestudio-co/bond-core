import 'package:flutter/widgets.dart';

/// Extension methods on [BuildContext] to provide easier access to localization-related properties.
extension LocalizationContext on BuildContext {
  /// Retrieves the current locale of the context.
  /// ```dart
  /// final locale = context.locale;
  /// ```
  Locale get locale => Localizations.localeOf(this);
}
