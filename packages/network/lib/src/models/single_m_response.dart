import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bond_core/bond_core.dart';

import 'model.dart';
import 'response_converter.dart';

part 'single_m_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleMResponse<T extends Model, G extends Jsonable> extends Equatable
    with Jsonable {
  const SingleMResponse(this.data, this.meta);

  @ResponseConverter()
  final T data;
  @ResponseConverter()
  final G meta;

  factory SingleMResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleMResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleMResponseToJson(this);

  @override
  List<Object?> get props => [data, meta];
}
