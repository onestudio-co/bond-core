/// A mixin that provides a way to access validation errors.
/// used in [FormController] to handle validation errors.
mixin HasValidationErrors on Error {
  /// The map of field names to their corresponding errors.
  Map<String, List<String>> get errors;

  /// Returns the errors for the given field.
  List<String>? getFieldErrors(String field) => errors[field];
}
