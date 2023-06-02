library bond_core;

import 'dart:developer';

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

void main() {
  final formState = FormState(
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
      ),
      'privacyPolicy': CheckboxFieldState(
        false,
        label: 'Accept Privacy Policy',
      ),
    },
  );

  log('formState = $formState');
}
