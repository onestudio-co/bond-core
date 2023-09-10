import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PizzaOrderFormController
    extends AutoDisposeFormStateNotifier<String, Error> {
  @override
  Map<String, FormFieldState> fields() => {
        'name': TextFieldState(
          null,
          label: 'Name',
          rules: [
            Rules.required(),
          ],
        ),
        'size': RadioGroupFieldState<String>(
          [
            RadioButtonFieldState(
              'L',
              label: 'Large',
            ),
            RadioButtonFieldState(
              'M',
              label: 'Medium',
            ),
            RadioButtonFieldState(
              'S',
              label: 'Small',
            ),
          ],
          label: 'Size',
          rules: [
            Rules.required(),
          ],
        ),
        'toppings': CheckboxGroupFieldState(
          [
            CheckboxFieldState(PizzaTopping.mushrooms, label: 'Mushrooms'),
            CheckboxFieldState(PizzaTopping.pepperoni, label: 'Onions'),
            CheckboxFieldState(PizzaTopping.pepperoni, label: 'Tomatoes'),
            CheckboxFieldState(PizzaTopping.pepperoni, label: 'Salami'),
            CheckboxFieldState(PizzaTopping.pepperoni, label: 'Pepperoni'),
          ],
          label: 'Choose your toppings',
          rules: [
            // Rules.minSelected(1),
            // Rules.maxSelected(3),
            Rules.required(),
          ],
        ),
        'delivery': RadioGroupFieldState(
          [
            RadioButtonFieldState(
              true,
              label: 'Yes',
            ),
            RadioButtonFieldState(
              false,
              label: 'No',
            ),
          ],
          label: 'Delivery',
          rules: [
            Rules.required(),
          ],
        ),
      };

  @override
  Future<String> onSubmit() async {
    final name = state.get('name').value;
    final pizzaType = state.get('pizza_type').value;
    final toppings = state.get('toppings').value;
    final delivery = state.get('delivery').value;
    log('name: $name, pizzaType: $pizzaType,toppings: $toppings, delivery: $delivery');
    await Future.delayed(const Duration(seconds: 1));
    return 'Pizza Order Successful';
  }
}

final pizzaOrderProvider = NotifierProvider.autoDispose<
    PizzaOrderFormController, BondFormState<String, Error>>(
  PizzaOrderFormController.new,
);
