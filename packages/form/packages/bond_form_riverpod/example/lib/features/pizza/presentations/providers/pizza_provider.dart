import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PizzaSize { small, medium, large }

enum CrustType { thin, original, deepDish }

enum Toppings {
  mushrooms,
  pepperoni,
  onions,
  sausage,
  bacon,
  extraCheese,
  blackOlives
}

class PizzaOrderFormController
    extends AutoDisposeFormStateNotifier<String, Error> {
  @override
  Map<String, FormFieldState> fields() => {
        'customerName': TextFieldState(
          null,
          label: 'Your Name',
          rules: [
            Rules.required(),
          ],
        ),
        'phoneNumber': TextFieldState(
          null,
          label: 'Phone Number',
          rules: [
            Rules.required(),
            Rules.phoneNumber(),
          ],
        ),
        'pizzaSize': RadioGroupFieldState<PizzaSize>(
          [
            RadioButtonFieldState(PizzaSize.small, label: 'Small'),
            RadioButtonFieldState(PizzaSize.medium, label: 'Medium'),
            RadioButtonFieldState(PizzaSize.large, label: 'Large'),
          ],
          label: 'Pizza Size',
          rules: [
            Rules.required(),
          ],
        ),
        'crustType': RadioGroupFieldState<CrustType>(
          [
            RadioButtonFieldState(CrustType.thin, label: 'Thin Crust'),
            RadioButtonFieldState(CrustType.original, label: 'Original'),
            RadioButtonFieldState(CrustType.deepDish, label: 'Deep Dish'),
          ],
          label: 'Crust Type',
          rules: [
            Rules.required(),
          ],
        ),
        'toppings': CheckboxGroupFieldState<Toppings>(
          [
            CheckboxFieldState(Toppings.mushrooms, label: 'Mushrooms'),
            CheckboxFieldState(Toppings.pepperoni, label: 'Pepperoni'),
            CheckboxFieldState(Toppings.onions, label: 'Onions'),
            CheckboxFieldState(Toppings.sausage, label: 'Sausage'),
            CheckboxFieldState(Toppings.bacon, label: 'Bacon'),
            CheckboxFieldState(Toppings.extraCheese, label: 'Extra Cheese'),
            CheckboxFieldState(Toppings.blackOlives, label: 'Black Olives'),
          ],
          label: 'Select Toppings',
          rules: [
            Rules.minSelected(1),
            Rules.maxSelected(5),
          ],
        ),
        'includeSides': RadioGroupFieldState<bool>(
          [
            RadioButtonFieldState(true, label: 'Yes'),
            RadioButtonFieldState(false, label: 'No'),
          ],
          label: 'Include Sides?',
          rules: [
            Rules.required(),
          ],
        ),
        'specialInstructions': TextFieldState(
          null,
          label: 'Special Instructions',
          rules: [],
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
