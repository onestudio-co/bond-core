## Basic usage:

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

