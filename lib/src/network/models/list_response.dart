import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'links.dart';
import 'meta.dart';
import 'model.dart';
import 'response_converter.dart';

part 'list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ListResponse<T extends Model> extends Equatable {
  const ListResponse({
    required this.data,
    this.links,
    this.meta,
    this.message,
  });

  @ResponseConverter()
  final List<T> data;
  final Meta? meta;
  final String? message;

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListResponseToJson(this);

  @override
  List<Object?> get props => [data, meta, links, message];

  String toJsonString() => json.encode(toJson());

  ListResponse<T> copyWith({
    List<T>? data,
    Links? links,
    Meta? meta,
    String? message,
  }) {
    return ListResponse<T>(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
      message: message ?? this.message,
    );
  }
}
