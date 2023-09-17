## 0.0.3

- Introduced `XListResponse` extension for `ListResponse` objects.
  - New `merge` method to combine two `ListResponse` instances into a single instance.
    - Merges the `data` arrays.
    - Takes `meta` and `links` from the second `ListResponse`.
  - Use Cases:
    1. Combine paginated responses.
    2. Aggregate data from different sources.
    3. Update existing `ListResponse` with new data while preserving `meta` and `links`.

## 0.0.2+1

* Export `DoubleConverter` to `BondNetwork`'s `converters` list.

## 0.0.2

* Introduced `DoubleConverter` class to handle flexible JSON field types.
    - Converts incoming JSON values to `double`.
    - Supports `String`, `int`, and `double` as input types.
    - Provides a default value fallback in case of conversion failure.
    - Enhanced logging within `DoubleConverter` for better debugging.

## 0.0.1+5

* fix caching when select cacheThenNetwork policy

## 0.0.1+4

* update bond_cache dependency.
* update bond_core dependency.

## 0.0.1+3

* fix read api return status code 403.

## 0.0.1+2

* handle the case where error.response!.data is string

## 0.0.1+1

* update bond_network package.

## 0.0.1

* initial release.