/// Represents the different states a [BondFormState] can be in.
enum BondFormStateStatus {
  /// The form is in its initial pristine state, with no changes or validations.
  pristine,

  /// The form is valid and ready to be submitted.
  valid,

  /// The form has validation errors and is not ready for submission.
  invalid,

  /// The form is currently submitting its data.
  submitting,

  /// The form has been successfully submitted.
  submitted,

  /// The form submission has failed.
  failed,
}
