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
  // bond create form widget -- PizzaOrderFormController

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
        'pizzaSize': RadioGroupFieldState<PizzaSize?>(
          value: null,
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
        'crustType': RadioGroupFieldState<CrustType?>(
          value: null,
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
        'toppings': CheckboxGroupFieldState<Toppings?>(
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
        'includeSides': RadioGroupFieldState<bool?>(
          value: null,
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
    // on summit called after the for validation is successful
    // so we can access the values through required helper methods.
    final customerName = state.required().textFieldValue('customerName');
    final phoneNumber = state.required().textFieldValue('phoneNumber');
    final pizzaSize = state.required().radioGroupValue<PizzaSize?>('pizzaSize');
    final crustType = state.required().radioGroupValue<CrustType?>('crustType');
    final toppings = state
        .checkboxValues<Toppings?>('toppings')
        .map((e) => e.toString())
        .join(', ');
    final includeSides =
        state.radioGroupValue<bool?>('includeSides') == true ? 'Yes' : 'No';
    final specialInstructions =
        state.textFieldValue('specialInstructions') ?? 'None';

    // Normally, you'd send these values to an API or a database here.
    // For demonstration, we'll just return a summary string.
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return '''
        Customer Name: $customerName
        Phone Number: $phoneNumber
        Pizza Size: $pizzaSize
        Crust Type: $crustType
        Toppings: $toppings
        Include Sides: $includeSides
        Special Instructions: $specialInstructions
      ''';
      },
    );
  }
}

final pizzaOrderProvider = NotifierProvider.autoDispose<
    PizzaOrderFormController, BondFormState<String, Error>>(
  PizzaOrderFormController.new,
);
