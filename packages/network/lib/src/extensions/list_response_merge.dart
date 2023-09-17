import 'package:bond_network/src/models.dart';

extension XListResponse<T extends Model> on ListResponse<T> {
  ListResponse<T> merge(ListResponse<T> response) {
    return ListResponse<T>(
      data: [...data, ...response.data],
      meta: response.meta,
      links: response.links,
    );
  }
}
