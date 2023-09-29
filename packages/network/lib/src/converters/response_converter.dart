import 'package:json_annotation/json_annotation.dart';
import 'package:bond_core/bond_core.dart';

class ResponseConverter<T extends Jsonable>
    implements JsonConverter<T, Map<String, dynamic>> {
  const ResponseConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    for (final provider in appProviders.whereType<ResponseDecoding>()) {
      final model = provider.responseConvert<T>(json);
      if (model != null) return model;
    }
    return json as T;
  }

  @override
  Map<String, dynamic> toJson(T object) {
    return object.toJson();
  }
}
