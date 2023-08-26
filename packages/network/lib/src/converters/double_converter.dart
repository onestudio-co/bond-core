import 'package:json_annotation/json_annotation.dart';

/// A custom [JsonConverter] that converts a JSON value to [double].
/// Supports [String], [int], and [double] types from JSON.
class DoubleConverter implements JsonConverter<double?, dynamic> {
  final double? defaultValue;

  /// Creates a [DoubleConverter] with an optional [defaultValue].
  /// The [defaultValue] is returned when the conversion fails.
  const DoubleConverter({this.defaultValue = 0});

  @override
  double? fromJson(dynamic value) {
    if (defaultValue == null) {
      return NullableDoubleConverter().fromJson(value);
    }
    return RequiredDoubleConverter(defaultValue: defaultValue!).fromJson(value);
  }

  @override
  dynamic toJson(double? object) => object;
}

/// A custom [JsonConverter] that converts a JSON value to nullable [double].
/// Supports [String], [int], and nullable [double] types from JSON.
class NullableDoubleConverter implements JsonConverter<double?, dynamic> {
  /// Creates a [NullableDoubleConverter].
  const NullableDoubleConverter();

  @override
  double? fromJson(dynamic value) => double.tryParse(value.toString());

  @override
  dynamic toJson(double? object) => object;
}

/// A custom [JsonConverter] that converts a JSON value to [double].
/// Supports [String], [int], and [double] types from JSON.
class RequiredDoubleConverter implements JsonConverter<double, dynamic> {
  final double defaultValue;

  /// Creates a [RequiredDoubleConverter] with an optional [defaultValue].
  /// The [defaultValue] is returned when the conversion fails.
  const RequiredDoubleConverter({this.defaultValue = 0});

  @override
  double fromJson(dynamic value) =>
      double.tryParse(value.toString()) ?? defaultValue;

  @override
  dynamic toJson(double? object) => object;
}