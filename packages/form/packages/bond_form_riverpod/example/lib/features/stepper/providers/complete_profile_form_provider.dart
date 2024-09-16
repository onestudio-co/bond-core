import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:example/features/stepper/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_information_form_provider.dart';
import 'vehicle_information_form_provider.dart';
//
//
// /// Controller for managing the complete profile stepper form.
// class CompleteProfileFormController extends FormStateNotifier<User, Error>
//     with StepperFormController {
//   CompleteProfileFormController() : super();
//
//   @override
//   List<FormController> get steps => [
//         ref.read(userInformationFormProvider.notifier),
//         ref.read(vehicleInformationFormProvider.notifier),
//       ];
//
//   @override
//   Future<User> onSubmit() {
//     // here you can access any field of all steps, or use body() helper method from BodyConvertible mixin
//   }
// }
//
// /// Provider for managing the complete profile form state.
// final completeProfileFormProvider = NotifierProvider.autoDispose<
//     CompleteProfileFormController, BondFormState<Map<String, dynamic>, Error>>(
//   CompleteProfileFormController.new,
// );
