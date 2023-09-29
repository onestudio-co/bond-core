# Bond Form Riverpod

Form Bond also comes with out-of-the-box integration with Riverpod, a popular state management solution for Flutter.
Riverpod allows for robust state management and combines well with Form Bond's strong form handling capabilities. With
this integration, Form Bond brings the simplicity of creating complex forms and the robustness of managing state
effectively in Flutter applications.

[![Pub Version](https://img.shields.io/pub/v/bond_form_riverpod)](https://pub.dev/packages/bond_form_riverpod)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Core Components](#core-components)
- [Documentation](#documentation)
- [License](#license)

## Features:

1. **Seamless Integration**: River Form Bond offers smooth integration with Riverpod, allowing you to focus more on
   building your app and less on boilerplate code.

2. **Strong Form Handling**: Utilizing Form Bond's strong form validation and management features, it provides a
   complete solution for form-based Flutter applications.

3. **Auto Resource Cleanup**: With the `AutoDisposeFormStateNotifier`, resources related to the form state are
   automatically cleaned up, making it more memory-efficient.

4. **Flexibility**: You have the ability to customize the form behavior and validation using the `FormStateNotifier`
   and `AutoDisposeFormStateNotifier`.

5. **Type-Safety**: Being strongly typed, it helps catch issues at compile-time rather than runtime.

## Installation

To use `bond_form_riverpod`, simply add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  bond_form_riverpod: ^0.0.1
```

## Usage:

```dart
import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:example/features/auth/data/errors/account_not_found_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormController extends FormStateNotifier<User, Error> {
  @override
  Map<String, FormFieldState> fields() =>
      {
        'email': TextFieldState(
          null,
          label: 'Email',
          rules: [
            Rules.required(),
            Rules.email(),
          ],
        ),
        'password': TextFieldState(
          null,
          label: 'Password',
          rules: [
            Rules.required(),
            Rules.minLength(6),
            Rules.alphaNum(),
          ],
        ),
      };

  @override
  Future<String> onSubmit() async {
    // Get the email and password from the form fields
    final email = state.textFieldValue('email');
    final password = state.textFieldValue('password');

    // Define the body of the POST request
    final body = {
      'email': email,
      'password': password,
    };

    // Make the POST request to login the user
    final response = await _bondFire
        .post<UserMApiResult>('/users/login')
        .body(body)
        .factory(UserMApiResult.fromJson)
        .errorFactory(ValidationError.fromJson)
        .cacheCustomKey('token', path: 'meta.token')
        .cacheCustomKey('user', path: 'data')
        .execute();

    return reponse.data;
  }
}

final loginProvider =
NotifierProvider<LoginFormController, BondFormState<String, Error>>(
  LoginFormController.new,
);
```

## Core Components:

### `FormStateNotifier`

An abstract class that helps you manage your form state, providing essential functionalities for form validation and
submission. It extends the Riverpod's `Notifier` class and mixes in `FormController` for added capabilities. The state
is represented as an instance of `BondFormState`, which encapsulates all the form fields and their statuses.

Example:

```dart
class MyFormStateNotifier extends FormStateNotifier<String, MyError> {
  // Implement required methods...
}
```

### `AutoDisposeFormStateNotifier`

Like `FormStateNotifier`, but it extends `AutoDisposeNotifier` for auto resource cleanup. It's perfect for forms that
need to be efficient with resource usage, especially when they are no longer in the user's view.

Example:

```dart
class MyAutoDisposeFormStateNotifier extends AutoDisposeFormStateNotifier<String, MyError> {
  // Implement required methods...
}
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs`
repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/onestudio-co/bond-docs/blob/main/forms.md)

## Contributing

Contributions are welcome! However, we currently do not have a set guideline for contributions. If you're interested in
contributing, please feel free to open a pull request or issue, and we'll be happy to discuss and review your changes.

## License

Bond Core is licensed under the [MIT License](LICENSE).
