import 'package:equatable/equatable.dart';

import 'jsonable.dart';

abstract class Model extends Equatable with Jsonable {
  const Model({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
