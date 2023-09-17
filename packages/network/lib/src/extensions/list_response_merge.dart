import 'package:bond_network/src/models.dart';

/// Extension to add a `merge` method to [ListResponse] instances.
///
/// The `merge` method allows you to combine two instances
/// of [ListResponse] and concatenate their `data` fields.
extension XListResponse<T extends Model> on ListResponse<T> {
  /// Merges the data of the current [ListResponse] instance with another.
  ///
  /// Takes another [ListResponse] instance as input and returns a new
  /// [ListResponse] instance whose `data` field is the concatenation of
  /// the `data` fields of both instances.
  ///
  /// The `meta` and `links` fields are populated from the input [ListResponse].
  ///
  /// ```
  /// var newListResponse = oldListResponse.merge(newData);
  /// ```
  ListResponse<T> merge(ListResponse<T> response) {
    return ListResponse<T>(
      data: [...data, ...response.data],
      meta: response.meta,
      links: response.links,
    );
  }
}
