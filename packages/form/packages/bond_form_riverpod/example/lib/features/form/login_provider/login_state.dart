import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';

class LoginFormNotifier extends FormStateNotifier {
  LoginFormNotifier()
      : super(
          fields: {
            'email': TextFieldState(
              '',
              label: 'Email',
              rules: [Rules.required(), Rules.email()],
            ),
            'password': TextFieldState(
              '',
              label: 'Password',
              rules: [
                Rules.required(),
                Rules.minLength(6),
                Rules.alphaNum(),
              ],
            ),
          },
        );

  @override
  Future<void> onSubmit() {
    // TODO: implement onSubmit
    throw UnimplementedError();
  }
}
