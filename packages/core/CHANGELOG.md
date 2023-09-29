## Changelog

## 0.0.1+3

#### Breaking Changes:

- Refactored `ServiceProvider`.
    - Removed `responseConvert<T>` method.
    - Added `ResponseDecoding` mixin. Use its `convertResponse<T>` method for response conversion.

#### How to Migrate:

1. If you used `responseConvert<T>`, replace it with the `convertResponse<T>` method from the new `ResponseDecoding` mixin.

```dart
// Old:
class MyServiceProvider extends ServiceProvider {
  @override
  T? responseConvert<T>(Map<String, dynamic> json) { ... }
}

// New:
class MyServiceProvider extends ServiceProvider with ResponseDecoding {
  @override
  T? convertResponse<T>(Map<String, dynamic> json) { ... }
}
```

## 0.0.1+2

* remove device_info package.
* remove device_utils.dart file.
* remove string_extension.dart file.

## 0.0.1+1

* fix package description.

## 0.0.1

* initial release.