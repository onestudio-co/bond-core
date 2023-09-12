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
            children: [
              // Name TextField
              TextFormField(
                onChanged: (value) => controller.updateText('name', value),
                decoration: InputDecoration(
                  labelText: formState.label('name'),
                  errorText: formState.error('name'),
                ),
              ),
              const SizedBox(height: 16),

              // Size RadioButtons
              Text(formState.label('size')),
              for (var radioButton in formState.radioButtonsOf<String>('size'))
                ListTile(
                  title: Text(radioButton.label),
                  leading: Radio<String>.adaptive(
                    value: radioButton.value ?? '',
                    groupValue: formState.radioGroupValue<String>('size'),
                    onChanged: (value) =>
                        controller.updateRadioGroup('size', value),
                  ),
                ),

              // Toppings CheckBoxes
              Text(formState.label('toppings')),
              for (var checkbox
                  in formState.checkboxesOf<PizzaTopping>('toppings'))
                CheckboxListTile.adaptive(
                  title: Text(checkbox.label),
                  value: checkbox.value ==
                      formState.checkboxValue<PizzaTopping>('toppings'),
                  onChanged: (value) => controller.toggleCheckboxValue(
                      'toppings', checkbox.value, value),
                ),

              // Delivery RadioButtons
              Text(formState.label('delivery')),
              for (var radioButton
                  in formState.radioButtonsOf<bool>('delivery'))
                ListTile(
                  title: Text(radioButton.label),
                  leading: Radio<bool>.adaptive(
                    value: radioButton.value ?? false,
                    groupValue: formState.radioGroupValue<bool>('delivery'),
                    onChanged: (value) =>
                        controller.updateRadioGroup('delivery', value),
                  ),
                ),
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
