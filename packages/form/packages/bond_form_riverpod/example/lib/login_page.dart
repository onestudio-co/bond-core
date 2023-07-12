import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuccessResponse {}

class FailureResponse extends Error {}

typedef LoginFormState = BondFormState<SuccessResponse, FailureResponse>;

class LoginFormNotifier
    extends FormStateNotifier<SuccessResponse, FailureResponse> {
  LoginFormNotifier()
      : super(
          fields: {
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
                Rules.minLength(8),
              ],
            ),
          },
        );

  @override
  Future<void> onSubmit() async {
    // Your login logic here
    log('Email: ${this['email'].value}');
    log('Password: ${this['password'].value}');
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(loginFormProvider.notifier);
    ref.listen(loginFormProvider, _onFormChange);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Email field
            TextField(
              onChanged: (value) => form['email'].value = value,
              decoration: InputDecoration(
                labelText: form['email'].label,
                errorText: form['email'].error,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8.0),

            // Password field
            TextField(
              onChanged: (value) => form['password'].value = value,
              decoration: InputDecoration(
                labelText: form['password'].label,
                errorText: form['password'].error,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8.0),

            // Login button
            ElevatedButton(
              onPressed: form.submit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _onFormChange(LoginFormState? previous, LoginFormState next) {

  }
}

// Create a provider for the form state notifier
final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(
  () => LoginFormNotifier(),
);
