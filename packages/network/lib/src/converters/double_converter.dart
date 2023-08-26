import 'package:json_annotation/json_annotation.dart';

/// A custom [JsonConverter] that converts a JSON value to [double].
/// Supports [String], [int], and [double] types from JSON.
class DoubleConverter implements JsonConverter<double?, dynamic> {
  final double? defaultValue;

  /// Creates a [DoubleConverter] with an optional [defaultValue].
  /// The [defaultValue] is returned when the conversion fails.
  const DoubleConverter({this.defaultValue = 0.0});

  @override
  double? fromJson(dynamic value) {
    return double.tryParse(value.toString()) ?? defaultValue;
  }

  @override
  dynamic toJson(double? object) => object;
}
