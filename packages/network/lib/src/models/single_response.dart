import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_network/src/converters.dart';

import 'meta.dart';
import 'model.dart';

part 'single_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleResponse<T extends Model> extends Equatable with Jsonable {
  const SingleResponse({required this.data, this.meta});

  @ResponseConverter()
  final T data;
  @ResponseConverter()
  final Meta? meta;

  factory SingleResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleResponseToJson(this);

  @override
  List<Object?> get props => [data, meta];
}
