### Changelog

## 0.0.8
### Added
- Introduced `_cacheStore` property to `GetBondApiRequest<T>` for selecting a custom cache store.
- Added full Dart documentation for all public methods and properties in `GetBondApiRequest`.
- Add Readme to the package.
- Add example to the package.

## 0.0.7
### Added
- **Cancel Token Support:** Added support for cancel tokens in API requests to allow for request cancellation.


## 0.0.6

### Changed
- **Dependencies Updated:**
    - **dio:** upgraded from `^5.2.1+1` to `^5.8.0+1`.
    - **equatable:** upgraded from `^2.0.5` to `^2.0.7`.
    - **json_annotation:** upgraded from `^4.8.1` to `^4.9.0`.
    - **json_serializable:** upgraded from `^6.7.1` to `^6.9.3`.
    - **package_info_plus:** upgraded from `^4.1.0` to `^8.2.1`.
    - **meta:** upgraded from `^1.8.0` to `^1.15.0`.
    - **faker:** upgraded from `^2.0.0` to `^2.2.0`.
- **Bond Dependencies Updated:**
    - **bond_core:** upgraded from `^0.0.1` to `^0.0.3`.
    - **bond_cache:** upgraded from `^0.0.1` to `^0.0.4+1`.

## 0.0.5

* support form data multipart request.


## 0.0.4

* add currentPage property to Meta class.

## 0.0.3+1

* Update `bond_core` dependency.

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