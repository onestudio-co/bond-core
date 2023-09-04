# Form Bond

## Introduction

The `form_bond` package provides a robust and flexible solution to manage form state in Flutter applications. It introduces several classes and utilities that simplify the process of validation, submission, and error handling in forms.

This package is ideal for anyone looking to streamline their form management logic, whether it's for a simple login form or a complex, multi-step registration process.

## Features

- Easy to use API for form management
- Built-in validation logic
- Customizable form fields
- Reactive state management
- Support for async form submission
- Easily extensible

## Quick Start

To use `form_bond`, simply add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  form_bond: 0.0.1+3
```

Basic usage:

```dart
final loginForm = FormStateNotifier<String, Error>(
  fields: {
    'email': TextFieldState(null, label: 'Email'),
    'password': TextFieldState(null, label: 'Password'),
  },
);

// Updating a form field
loginForm.update('email', 'johndoe@gmail.com');

// Submitting the form
loginForm.submit();
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs` repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/onestudio-co/bond-docs/blob/main/forms.md)

