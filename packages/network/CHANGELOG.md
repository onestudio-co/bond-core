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