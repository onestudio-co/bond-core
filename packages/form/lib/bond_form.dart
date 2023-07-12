library form;

import 'bond_form.dart';

export 'src/bond_form_state.dart';
export 'src/form_fields.dart';
export 'src/form_fields/form_field_state.dart';
export 'src/validation/rules.dart';

enum PizzaTopping {
  mushrooms,
  pepperoni,
  cheese,
  // Other toppings...
}

final toppingsField = CheckboxGroupFieldState<PizzaTopping>(
  [
    CheckboxFieldState(PizzaTopping.mushrooms, label: 'Mushrooms'),
    CheckboxFieldState(PizzaTopping.pepperoni, label: 'Pepperoni'),
    CheckboxFieldState(PizzaTopping.cheese, label: 'Cheese'),
    // Other toppings...
  ],
  label: 'Choose your toppings',
  // rules: [Rules.minSelected(3)],
);
