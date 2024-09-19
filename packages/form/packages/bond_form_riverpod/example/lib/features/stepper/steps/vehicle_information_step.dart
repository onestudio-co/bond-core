import 'package:example/features/stepper/providers/vehicle_information_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bond_form/bond_form.dart';

class VehicleInformationStep extends ConsumerWidget {
  const VehicleInformationStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formController = ref.watch(vehicleInformationFormProvider.notifier);
    final formState = ref.watch(vehicleInformationFormProvider);

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Vehicle Make',
            errorText: formState.error('vehicle_make'),
          ),
          onChanged: (value) =>
              formController.updateText('vehicle_make', value),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Vehicle Model',
            errorText: formState.error('vehicle_model'),
          ),
          onChanged: (value) =>
              formController.updateText('vehicle_model', value),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Vehicle Year',
            errorText: formState.error('vehicle_year'),
          ),
          onChanged: (value) =>
              formController.updateText('vehicle_year', value),
        ),
      ],
    );
  }
}
