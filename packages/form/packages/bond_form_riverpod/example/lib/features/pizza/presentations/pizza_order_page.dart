import 'package:bond_core/bond_core.dart';
import 'package:bond_form/bond_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/pizza_provider.dart';

class PizzaOrderPage extends ConsumerWidget {
  const PizzaOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(pizzaOrderProvider);
    final controller = ref.read(pizzaOrderProvider.notifier);
    ref.listen(
      pizzaOrderProvider,
      (previous, next) => _formStateListener(context, previous, next),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Name
              TextFormField(
                onChanged: (value) =>
                    controller.updateText('customerName', value),
                decoration: InputDecoration(
                  labelText: formState.label('customerName'),
                  errorText: formState.error('customerName'),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                onChanged: (value) =>
                    controller.updateText('phoneNumber', value),
                decoration: InputDecoration(
                  labelText: formState.label('phoneNumber'),
                  errorText: formState.error('phoneNumber'),
                ),
              ),
              const SizedBox(height: 16),

              // Branch
              DropdownButtonFormField<Branches>(
                value: formState.dropDownValue('branch'),
                items: formState
                    .dropDownItems('branch')
                    .map(
                      (branch) => DropdownMenuItem<Branches>(
                        value: branch.value,
                        child: Text(branch.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) => controller.updateDropDown(
                  'branch',
                  value,
                ),
                style: context.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: formState.label('branch'),
                  errorText: formState.error('branch'),
                ),
              ),
              const SizedBox(height: 16),

              // Pizza Size
              Text(
                formState.label('pizzaSize'),
                style: context.textTheme.titleSmall,
              ),
              for (final radioButton in formState.radioButtonsOf('pizzaSize'))
                ListTile(
                  title: Text(radioButton.label),
                  leading: Radio(
                    value: radioButton.value,
                    groupValue: formState.radioGroupValue('pizzaSize'),
                    onChanged: (value) =>
                        controller.updateRadioGroup('pizzaSize', value),
                  ),
                ),

              // Crust Type
              Text(
                formState.label('crustType'),
                style: context.textTheme.titleSmall,
              ),
              for (final radioButton in formState.radioButtonsOf('crustType'))
                ListTile(
                  title: Text(radioButton.label),
                  leading: Radio(
                    value: radioButton.value,
                    groupValue: formState.radioGroupValue('crustType'),
                    onChanged: (value) =>
                        controller.updateRadioGroup('crustType', value),
                  ),
                ),

              // Toppings
              Text(
                formState.label('toppings'),
                style: context.textTheme.titleSmall,
              ),
              for (final checkbox in formState.checkboxesOf('toppings'))
                CheckboxListTile(
                  title: Text(checkbox.label),
                  value: formState.checkboxSelected('toppings', checkbox.value),
                  onChanged: (selected) => controller.toggleCheckbox(
                    'toppings',
                    value: checkbox.value,
                    selected: selected,
                  ),
                ),

              // Include Sides
              Text(
                formState.label('includeSides'),
                style: context.textTheme.titleSmall,
              ),
              for (final radioButton
                  in formState.radioButtonsOf('includeSides'))
                ListTile(
                  title: Text(radioButton.label),
                  leading: Radio(
                    value: radioButton.value,
                    groupValue: formState.radioGroupValue('includeSides'),
                    onChanged: (value) =>
                        controller.updateRadioGroup('includeSides', value),
                  ),
                ),

              // Special Instructions
              TextFormField(
                onChanged: (value) =>
                    controller.updateText('specialInstructions', value),
                decoration: InputDecoration(
                  labelText: formState.label('specialInstructions'),
                  errorText: formState.error('specialInstructions'),
                ),
              ),

              const SizedBox(height: 16),
              if (formState.status == BondFormStateStatus.submitting)
                const CircularProgressIndicator()
              else
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: controller.submit,
                    height: 48,
                    color: formState.status == BondFormStateStatus.invalid
                        ? Colors.red
                        : Colors.blueAccent,
                    child: const Text(
                      'Create Order',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void _formStateListener(
    BuildContext context,
    BondFormState<String, Error>? previous,
    BondFormState<String, Error> next,
  ) {
    switch (next.status) {
      case BondFormStateStatus.submitted:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitted'),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case BondFormStateStatus.failed:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.toString()),
            backgroundColor: Colors.red,
          ),
        );
        break;
      default:
        break;
    }
  }
}
