import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

/// A custom [JsonConverter] that converts a JSON value to [double].
/// Supports [String], [int], and [double] types from JSON.
class DoubleConverter implements JsonConverter<double, dynamic> {
  final double defaultValue;

  /// Creates a [DoubleConverter] with an optional [defaultValue].
  /// The [defaultValue] is returned when the conversion fails.
  const DoubleConverter({this.defaultValue = 0.0});

  @override
  double fromJson(dynamic value) {
    try {
      if (value == null) {
        return defaultValue;
      } else if (value is int) {
        return value.toDouble();
      } else if (value is double) {
        return value;
      } else if (value is String) {
        return double.parse(value);
      } else {
        throw Exception('Invalid value type. Supported types are String, int, and double.');
      }
    } catch (e) {
      log(
        'Warning: value $value of type ${value.runtimeType} could not be converted to double.',
        name: 'DoubleConverter',
      );
      return defaultValue;
    }
  }

  @override
  dynamic toJson(double object) => object;
}
