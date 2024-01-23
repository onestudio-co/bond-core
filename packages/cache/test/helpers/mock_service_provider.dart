import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';

import 'registered_model.dart';

class MockServiceProvider extends Mock
    with ResponseDecoding
    implements ServiceProvider {
  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    if (T == RegisteredModel) {
      return RegisteredModel.fromJson(json) as T;
    }
    return null;
  }
}
