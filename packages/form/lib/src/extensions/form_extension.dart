import 'package:bond_form/bond_form.dart';

extension XBondFormState<Success, Failed extends Error>
    on BondFormState<Success, Failed> {
  bool get loading => status == BondFormStateStatus.submitting;

  bool get canSubmit => status == BondFormStateStatus.valid;

  bool get submitted => status == BondFormStateStatus.submitted;

  bool get failed => status == BondFormStateStatus.failed;
}
