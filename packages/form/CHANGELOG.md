### Changelog

## 0.0.5
### Breaking Changes
- Renamed `update` method to `updateField` in `GetxFormController` to avoid conflict with `GetxController`.
- This change requires updating all instances where the `update` method was used to `updateField`.

## 0.0.4+1
- Downgraded `intl` from `^0.20.2` to `^0.19.0` to fix compatibility issues with Flutter.

## 0.0.4

### Changed
- **meta:** Upgraded from `^1.8.0` to `^1.15.0`.
- **mime:** Upgraded from `^1.0.5` to `^2.0.0`.
- **intl:** Upgraded from `^0.19.0` to `^0.20.2`.
- **bond_core:** Upgraded from `^0.0.2` to `^0.0.3`.

## 0.0.3+1 
- Introduced BaseFormController mixin to handle common form state logic and provide reusable form management functions.

## 0.0.3+1
* add missing method `optional` on `rules.dart` file

## 0.0.3
### Added
- **Optional Rule**: Introduced the `Optional` validation rule that allows fields to be marked as optional. If the field is not present (null, empty string, or empty list), validation will pass, and all other rules will be skipped. If the field is present, other rules will be validated against the value.
- **Enhanced Validation Logic**: The `validate` method in `FormFieldState` now properly handles the `Optional` rule, ensuring that optional fields can skip validation when appropriate.

### Changed
- **General Validation Logic**: Updated the general validation logic to support the new `Optional` rule, improving flexibility and making form validation more intuitive for optional fields.

### Fixed
- **Bug Fixes**: Resolved issues related to handling `null` and empty values in form validation, ensuring that the new `Optional` rule operates smoothly within the validation pipeline.

## 0.0.2

* Automatic Body Generation with BodyConvertible Mixin
•	Introduced the BodyConvertible mixin, which allows automatic generation of a request body map from form state values. This simplifies the process of extracting and transforming form field values into a key-value map suitable for API requests.
•	The body() method automatically iterates over all form fields, applying registered transformers to generate the body map.

* Flexible Field Transformers with TransformersRegistry
  •	Added the TransformersRegistry class, which allows developers to register custom field transformers. These transformers can convert field values into any desired format, such as converting enum values to strings.
  •	The registry supports both single values and collections (e.g., Set, List), automatically handling the transformation of collection elements.

## 0.0.1+30
* update dependence

## 0.0.1+29

* add `setError` method to `FormController` mixin to set the error message of a specific field.
* add `updateError` method to `FormController` mixin to update the error message of a specific
  field.
* The `setError` method directly sets a provided error message for a field, while the `updateError`
  method appends the provided error message to any existing validation errors for the field.

## 0.0.1+28

* Fix isTrue & isFalse rules to deal with null value and now support bool, String & num types.

## 0.0.1+27

* Added date field support to form extensions.
    - `BondFormState` updated with methods to handle date fields.
        - `dateFieldValue`: Retrieves the value of a date field.
        - `dateField`: Retrieves the state of a date field using a simplified `get` method.

## 0.0.1+26

* Added `FileFieldState` class to manage the state of file form fields.
    - `FileFieldState` provides a way to manage file input fields within a form.

## 0.0.1+25

- **Refactor**: Separated field state and value retrieval methods into distinct files.
    - Moved field state retrieval methods to `bond_form_extensions.dart`.
    - Moved value retrieval methods to `bond_form_values.dart`.
- **Enhancement**: Updated `required_values.dart` to include the `RequiredValues` class for
  mandatory field checks.
- **Improvement**: Improved overall code organization and maintainability by dividing
  responsibilities into specific files.

## 0.0.1+24

* fix `valid` method logic.

## 0.0.1+23

* `valid` New method on `BondFormState` to check a specific field validate.

## 0.0.1+22

* Added `HiddenFieldState` class to manage the state of hidden form fields.
    - `HiddenFieldState` provides a way to manage hidden input fields within a form.
* Updated `BondFormState` with methods to handle hidden fields.
    - `hiddenFieldValue`: Retrieves the value of a hidden field.
    - `hiddenField`: Retrieves the state of a hidden field using a simplified `get` method.
* Updated `RequiredValues` class to ensure hidden field values are not null.
    - `hiddenFieldValue`: Ensures the value of a hidden field is not null.
* Updated `FormController` with methods to update hidden field values.
    - `updateHiddenField`: Updates a `HiddenFieldState` with a given value.

## 0.0.1+21

* Added the `RequiredValues` class to ensure required form field values are not null.
    - Methods added to `RequiredValues` class:
        - `textFieldValue`: Ensures the value of a text field is not null.
        - `radioGroupValue`: Ensures the value of a radio group field is not null.
        - `checkboxGroupValue`: Ensures the first selected value of a checkbox group is not null.
        - `dropDownValue`: Ensures the value of a dropdown field is not null.
        - `asyncDropDownValue`: Ensures the value of an async dropdown field is not null.
* Added the `required` extension method to `BondFormState`.
    - Provides an instance of `RequiredValues` to ensure required field values are not null.
* Updated the Dartdoc comments for `XBondFormState` extension.
    - Provided clear and comprehensive documentation for all methods:
        - `textFieldValue`: Retrieves the value of a text field.
        - `radioGroupValue`: Retrieves the value of a radio group field.
        - `checkboxGroupValue`: Retrieves the first selected value of a checkbox group.
        - `dropDownValue`: Retrieves the value of a dropdown field.
        - `asyncDropDownValue`: Retrieves the value of an async dropdown field.
        - `required`: Returns an instance of `RequiredValues` to ensure required field values are
          not null.
* Updated the Dartdoc comments for `XFormController` extension.
    - Provided clear and comprehensive documentation for all methods:
        - `updateText`: Updates a `TextFieldState` with a given value.
        - `updateCheckbox`: Updates a `CheckboxFieldState` with a given value.
        - `updateCheckboxGroup`: Updates a `CheckboxGroupFieldState` with a given value.
        - `toggleCheckbox`: Toggles the value of a specific checkbox within a checkbox group.
        - `updateDate`: Updates a `DateFieldState` with a given value.
        - `updateDropDown`: Updates a `DropDownFieldState` with a given value.
        - `updateAsyncDropDown`: Updates a `AsyncDropDownFieldState` with a given value.
        - `updateRadioButton`: Updates a `RadioButtonFieldState` with a given value.
        - `updateRadioGroup`: Updates a `RadioGroupFieldState` with a given value.

## 0.0.1+20

* fix `IsTrue` and `IsFalse` rules to deal with null value.

## 0.0.1+19

* fix `Numeric` rule to deal with null value.

## 0.0.1+18

* new extension methods support dealing with single bool checkbox field.
* fix `AlphaNum` and `AlphaDash` rules to deal with null value.

## 0.0.1+17

* fix failure handling at the _onSubmit method.

## 0.0.1+16

* introduce `HasValidationErrors` mixin to update form fields state with the errors that comes from
  an api. services.

## 0.0.1+15

* add missing method 'updateAsyncDropDown' to `FormController` extension.

## 0.0.1+14

* introduced the async drop down menu field state `AsyncDropDownFieldState`.

## 0.0.1+13

* add more helpers methods inside `BondFormState` extension

## 0.0.1+12

* add clear method to `FormController` mixin

## 0.0.1+11

* add validate method to `FormController` mixin

## 0.0.1+10

* update readme.md file to mention the riverpod integration

## 0.0.1+9

* fix typo on readme.md file

## 0.0.1+8

* update readme.md files
* fix dart analysis issues

## 0.0.1+7

* update example.md and readme.md files

## 0.0.1+6

* fix validation localized message not rendered as excepted

## 0.0.1+5

* extract mixin FormController contains common form logic

## 0.0.1+4

* write public API has dartdoc comments
* fix dart analysis issues

## 0.0.1+3

* add necessary imports to bond form

## 0.0.1+2

* update bond_core dependency.

## 0.0.1+1

* add necessary imports to bond form

## 0.0.1

* initial release.