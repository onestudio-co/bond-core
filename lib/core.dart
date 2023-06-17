library bond_core;

import 'package:bond_core/src/form/form_state.dart';

import 'src/form/form_fields/checkbox_field_state.dart';
import 'src/form/form_fields/text_field_state.dart';
import 'src/form/validation/rules/email.dart';
import 'src/form/validation/rules/required.dart';

export 'src/app.dart';
export 'src/app_analytics.dart';
export 'src/auth.dart';
export 'src/cache.dart';
export 'src/injection.dart';
export 'src/network.dart';
export 'src/notifications.dart';
export 'src/utils.dart';
export 'src/chat_bot.dart';

import 'package:flutter/material.dart' as material;

import 'src/form/validation/rules/same.dart';

class LoginFormStateNotifier extends FormStateNotifier {
  LoginFormStateNotifier()
      : super(
          stopOnFirstError: true,
          fields: {
            'email': TextFieldState(
              null,
              label: 'Email',
              rules: [
                Required(),
                Email(),
              ],
            ),
            'name': TextFieldState(
              null,
              label: 'Name',
              rules: [
                Required(),
              ],
            ),
            'password': TextFieldState(
              null,
              label: 'Password',
            ),
            'passwordConfirmation': TextFieldState(
              null,
              label: 'Password Confirmation',
              rules: [
                Required(),
                Same('password'),
              ],
            ),
            'privacyPolicy': CheckboxFieldState(
              false,
              label: 'Accept Privacy Policy',
            ),
          },
        );

  @override
  Future<void> submit() async {}
}

void main() {
  final formStateNotifier = LoginFormStateNotifier();
  material.TextField(
    onChanged: (value) => formStateNotifier.update('email', value),
    decoration: material.InputDecoration(
      labelText: formStateNotifier.label('email'),
      errorText: formStateNotifier.error('email'),
    ),
  );
}

//  form bond must be agnostic from state management solutions
