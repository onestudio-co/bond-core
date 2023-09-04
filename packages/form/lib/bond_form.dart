/// A library for working with forms and form validation.
library form;

import 'bond_form.dart';

export 'src/bond_form_state.dart';
export 'src/bond_form_controller.dart';
export 'src/form_fields.dart';
export 'src/form_fields/form_field_state.dart';
export 'src/validation/rules.dart';

/// Enumeration representing various pizza toppings.
enum PizzaTopping {
  /// Mushrooms pizza topping.
  mushrooms,

  /// Pepperoni pizza topping.
  pepperoni,

  /// Cheese pizza topping.
  cheese,

  // Add other toppings here...
}

/// A field representing a group of checkboxes for selecting pizza toppings.
final toppingsField = CheckboxGroupFieldState<PizzaTopping>(
  [
    CheckboxFieldState(PizzaTopping.mushrooms, label: 'Mushrooms'),
    CheckboxFieldState(PizzaTopping.pepperoni, label: 'Pepperoni'),
    CheckboxFieldState(PizzaTopping.cheese, label: 'Cheese'),
    // Add other toppings...
  ],
  label: 'Choose your toppings',
  // rules: [Rules.minSelected(3)],
);
