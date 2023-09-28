import 'package:flutter/widgets.dart';

/// A global key used to reference the root [MaterialApp] widget.
///
/// This key allows bond_core and other bond packages to access the root-level
/// context of the application. This is particularly useful for functionalities
/// like accessing the current locale, theme data, or navigating without a local context.
///
/// Usage:
/// Assign this key to the `key` property of your root [MaterialApp] or [CupertinoApp]
/// widget to enable bond packages to perform root-level operations.
final GlobalKey appKey = GlobalKey();

/// Provides access to the global root-level context of the application.
///
/// This utility leverages the [appKey] to fetch the root-level context
/// of the Flutter application. This context can be immensely valuable
/// for operations that do not have local context access, such as:
///   - Fetching global theme data.
///   - Accessing current locale for localization.
///   - Root-level navigation without local context.
///
/// **Use Cases**:
///   - When you need context outside the widget tree, like in services or view models.
///   - When performing an operation at app start-up, where local context might not be available.
///   - For utilities that operate at a global level and require context, such as certain plugins.
///
/// **When to Avoid**:
///   - If a local context is readily available, prefer using that to ensure the most up-to-date widget tree information.
///   - Be cautious when accessing this context too early in the app's lifecycle. Ensure that the widget tree is built and the context is initialized.
///
BuildContext get appContext {
  final context = appKey.currentContext;

  assert(context != null, '''
    Failed to retrieve the app context using bond_core's appKey. 
    Possible reasons:
      1. The appKey hasn't been assigned to the root MaterialApp/CupertinoApp widget.
      2. The widget tree hasn't been built yet when trying to access the context.
    
    Solution:
      1. Ensure you've assigned bond_core's appKey to the key property of your root MaterialApp/CupertinoApp widget.
      2. If you're trying to access the context immediately upon app launch, ensure you're doing so after the widget tree is built. Delay your operation if necessary.
    ''');

  return context!;
}
