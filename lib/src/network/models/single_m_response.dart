import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:one_studio_core/core.dart';

import 'response_converter.dart';

part 'single_m_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleMResponse<T extends Model, G extends Jsonable> extends Equatable {
  const SingleMResponse(this.data, this.meta, {this.message});

  @ResponseConverter()
  final T data;
  @ResponseConverter()
  final G meta;
  final String? message;

  factory SingleMResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleMResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleMResponseToJson(this);

  @override
  List<Object?> get props => [data, meta, message];
}
