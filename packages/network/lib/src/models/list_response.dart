import 'package:bond_core/bond_core.dart';
import 'package:bond_network/src/converters.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'links.dart';
import 'meta.dart';
import 'model.dart';

part 'list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ListResponse<T extends Model> extends Equatable with Jsonable {
  const ListResponse({
    required this.data,
    this.links,
    this.meta,
  });

  @ResponseConverter()
  final List<T> data;
  final Meta? meta;
  final Links? links;

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ListResponseToJson(this);

  ListResponse<T> copyWith({
    List<T>? data,
    Meta? meta,
    Links? links,
  }) {
    return ListResponse<T>(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [data, meta, links];
}
