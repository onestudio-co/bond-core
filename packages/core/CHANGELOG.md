## Changelog

## 0.0.1+7

* call WidgetsFlutterBinding.ensureInitialized method before init the service providers.

## 0.0.1+6

* take providers list as a method argument on run method.

## 0.0.1+5

* just format files using dart form command.

## 0.0.1+4

* add missing repository property at pubspec.yaml file.

## 0.0.1+3

#### Breaking Changes:

- Refactored `ServiceProvider`.
    - Removed `responseConvert<T>` method.
    - Added `ResponseDecoding` mixin. Use its `convertResponse<T>` method for response conversion.

#### How to Migrate:

1. If you used `responseConvert<T>`, replace it with the `convertResponse<T>` method from the
   new `ResponseDecoding`
   mixin.

```dart
// Old:
class MyServiceProvider extends ServiceProvider {
  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    ...
  }
}

// New:
class MyServiceProvider extends ServiceProvider with ResponseDecoding {
  @override
  T? convertResponse<T>(Map<String, dynamic> json) {
    ...
  }
}
```

#### Added

- **Utils Extensions**:
    - `ThemeContext`: Directly access `textTheme` and `colorScheme`.
    - `ScaffoldContext`: Convenient methods like `showSnackBar` added.
    - `KeyboardContext`: Methods to control and check the keyboard state.
    - `InsetsContext`: Access media padding, status bar height, and bottom inset.
    - `LocalizationContext`: Access the current locale of the context.
    - `MediaQueryContext`: Determine `screenHeight`, `screenWidth`, and if the device orientation is
      landscape.
    - `DeviceTypeContext`: Determine if the device is a phone, tablet, or desktop.
    - `TextScaleContext`: Access text scale factors for accessibility settings.
    - `BrightnessContext`: Check if the device is in dark mode or light mode.
    - `SafeAreaContext`: Access the safe area insets.

#### Updated

- **App Initialization**:
    - Introduced `RunTasks` class to streamline application start-up process. The usage has been
      refactored to use `run`
      with `RunTasks` for initialization logic, including registering service providers and other
      pre and post-run
      tasks.
        - Example:
          ```dart
          void main() => run(
            () => const ProviderScope(
              child: BondApp(),
            ),
            RunAppTasks(providers),
          );
          ```
    - The `RunTasks` class now initializes service providers through a callable method.
    - `beforeRun`, `afterRun`, and `onError` methods of `RunTasks` are now optional.

## 0.0.1+2

* remove device_info package.
* remove device_utils.dart file.
* remove string_extension.dart file.

## 0.0.1+1

* fix package description.

## 0.0.1

* initial release.