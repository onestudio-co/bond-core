import 'package:bond_form/bond_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/pizza_provider.dart';

class PizzaOrderPage extends ConsumerWidget {
  const PizzaOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(pizzaOrderProvider);
    ref.listen(
      pizzaOrderProvider,
      (previous, next) => _formStateListener(context, previous, next),
    );
    String? selectedOption;
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Order')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              onChanged: (value) =>
                  ref.read(pizzaOrderProvider.notifier).update<FormFieldState<String>, String>('name', value, '');
              decoration: InputDecoration(
                labelText: formState.label('name'),
                errorText: formState.error('name'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    formState
                        .get<RadioGroupFieldState<String?>, String?>('size')
                        .radioButtons[0]
                        .label,
                  ),
                  leading: Radio<String>(
                    value: formState
                            .get<RadioGroupFieldState<String?>, String?>('size')
                            .radioButtons[0]
                            .value ??
                        '',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      selectedOption = value;
                      print("Selected Option: $selectedOption");
                    },
                  ),
                ),
                ListTile(
                  title:  Text(
                formState
                    .get<RadioGroupFieldState<String?>, String?>('size')
                    .radioButtons[1]
                    .label,
                ),
                  leading: Radio<String>(
                    value: formState
                        .get<RadioGroupFieldState<String?>, String?>('size')
                        .radioButtons[1]
                        .value ??
                        '',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      selectedOption = value;
                      print("Selected Option: $selectedOption");
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    formState
                        .get<RadioGroupFieldState<String?>, String?>('size')
                        .radioButtons[3]
                        .label,
                  ),
                  leading: Radio<String>(
                    value: formState
                        .get<RadioGroupFieldState<String?>, String?>('size')
                        .radioButtons[2]
                        .value ??
                        '',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      selectedOption = value;
                      print("Selected Option: $selectedOption");
                    },
                  ),
                ),
              ],
            ),
          ],
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
