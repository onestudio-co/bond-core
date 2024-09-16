import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleInformationFormController
    extends FormStateNotifier<Map<String, dynamic>, Error>
    with BodyConvertible {
  VehicleInformationFormController() : super();

  @override
  Map<String, FormFieldState> fields() => {
        'vehicle_make': TextFieldState(
          null,
          label: 'Vehicle Make',
          rules: [
            Rules.required(),
          ],
        ),
        'vehicle_model': TextFieldState(
          null,
          label: 'Vehicle Model',
          rules: [
            Rules.required(),
          ],
        ),
        'vehicle_year': TextFieldState(
          null,
          label: 'Vehicle Year',
          rules: [
            Rules.required(),
            Rules.numeric(),
            Rules.size(4),
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

final vehicleInformationFormProvider = NotifierProvider.autoDispose<
    VehicleInformationFormController, BondFormState<void, Error>>(
  VehicleInformationFormController.new,
);
