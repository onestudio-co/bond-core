
# Form Bond Riverpod

Form Bond also comes with out-of-the-box integration with Riverpod, a popular state management solution for Flutter. Riverpod allows for robust state management and combines well with Form Bond's strong form handling capabilities. With this integration, Form Bond brings the simplicity of creating complex forms and the robustness of managing state effectively in Flutter applications.

## Features:

1. **Seamless Integration**: River Form Bond offers smooth integration with Riverpod, allowing you to focus more on building your app and less on boilerplate code.

2. **Strong Form Handling**: Utilizing Form Bond's strong form validation and management features, it provides a complete solution for form-based Flutter applications.

3. **Auto Resource Cleanup**: With the `AutoDisposeFormStateNotifier`, resources related to the form state are automatically cleaned up, making it more memory-efficient.

4. **Flexibility**: You have the ability to customize the form behavior and validation using the `FormStateNotifier` and `AutoDisposeFormStateNotifier`.

5. **Type-Safety**: Being strongly typed, it helps catch issues at compile-time rather than runtime.

## Core Components:

### `FormStateNotifier`

An abstract class that helps you manage your form state, providing essential functionalities for form validation and submission. It extends the Riverpod's `Notifier` class and mixes in `FormController` for added capabilities. The state is represented as an instance of `BondFormState`, which encapsulates all the form fields and their statuses.

Example:

```dart
class MyFormStateNotifier extends FormStateNotifier<String, MyError> {
  // Implement required methods...
}
```

### `AutoDisposeFormStateNotifier`

Like `FormStateNotifier`, but it extends `AutoDisposeNotifier` for auto resource cleanup. It's perfect for forms that need to be efficient with resource usage, especially when they are no longer in the user's view.

Example:

```dart
class MyAutoDisposeFormStateNotifier extends AutoDisposeFormStateNotifier<String, MyError> {
  // Implement required methods...
}
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs` repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/onestudio-co/bond-docs/blob/main/forms.md)

