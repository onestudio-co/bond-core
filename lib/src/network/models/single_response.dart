import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:one_studio_core/core.dart';

import 'response_converter.dart';

part 'single_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleResponse<T extends Model> extends Equatable {
  const SingleResponse({required this.data, this.meta});

  @ResponseConverter()
  final T data;
  @ResponseConverter()
  final Meta? meta;

  factory SingleResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleResponseToJson(this);

  @override
  List<Object?> get props => [data, meta];
}
