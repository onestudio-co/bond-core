import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationFormController
    extends FormStateNotifier<Map<String, dynamic>, Error>
    with BodyConvertible {
  UserInformationFormController() : super();

  @override
  Map<String, FormFieldState> fields() => {
        'name': TextFieldState(
          null,
          label: 'Name',
          rules: [
            Rules.required(),
          ],
        ),
        'email': TextFieldState(
          null,
          label: 'Email',
          rules: [
            Rules.required(),
            Rules.email(),
          ],
        ),
        'phone': TextFieldState(
          null,
          label: 'Phone Number',
          rules: [
            Rules.optional(),
            Rules.phoneNumber(),
          ],
        ),
      };

  @override
  void fieldTransformers(TransformersRegistry registry) {}

  @override
  Future<Map<String, dynamic>> onSubmit() async {
    return body();
  }
}

final userInformationFormProvider = NotifierProvider.autoDispose<
    UserInformationFormController, BondFormState<void, Error>>(
  UserInformationFormController.new,
);
