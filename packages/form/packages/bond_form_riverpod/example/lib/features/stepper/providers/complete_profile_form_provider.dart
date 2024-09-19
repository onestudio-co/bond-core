import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:example/features/stepper/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_information_form_provider.dart';
import 'vehicle_information_form_provider.dart';

/// Controller for managing the complete profile stepper form.
class CompleteProfileFormController
    extends AutoDisposeStepperFormStateNotifier<User, Error>
    with BodyConvertible {
  CompleteProfileFormController() : super();

  @override
  List<StepFormController> get steps => [
        ref.read(userInformationFormProvider.notifier),
        ref.read(vehicleInformationFormProvider.notifier),
      ];

  @override
  StepperFormState<User, Error> build() {
    ref.watch(userInformationFormProvider);
    ref.watch(vehicleInformationFormProvider);
    return super.build();
  }

  @override
  Future<User> onSubmit() async {
    log(
      'onSubmit  field ${body()}',
    );
    return User();
  }
}

/// Provider for managing the complete profile form state.
final completeProfileFormProvider = NotifierProvider.autoDispose<
    CompleteProfileFormController, StepperFormState<User, Error>>(
  CompleteProfileFormController.new,
);
