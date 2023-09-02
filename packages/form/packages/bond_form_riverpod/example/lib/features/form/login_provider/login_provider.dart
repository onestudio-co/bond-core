import 'package:bond_form/bond_form.dart';
import 'package:example/features/form/login_provider/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifierProvider = NotifierProvider<LoginFormNotifier, BondFormState>(
      () => LoginFormNotifier(),
);