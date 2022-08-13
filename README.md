# one-studio-core
Flutter package which contain the core file for one studio apps.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  flutter:
    sdk:
  one_studio_core:
    git:
      url: https://github.com/onestudio-co/one-studio-core.git
      ref: main
```

In your library add the following import:

```dart
  import 'package:one_studio_core/core.dart';
```

## Usage
Comming soon 

## Package Content
```
├── lib
|   ├── src
│   │   ├── auth
│   │   │   └── auth.dart
|   |   |   └── auth_store.dart
|   |   |   └── authenticable.dart
|   |   ├── cache
|   |   |   └── drivers  
|   |   |       └── cache_driver.dart
|   |   |       └── in_memory_cache_driver.dart
|   |   |       └── shared_preferences_cache_driver.dart
|   |   |   └── cache.dart
│   │   ├── injection
│   │   |   └── injection_container.dart
│   │   |   └── service_provider.dart
|   |   ├──  network
|   |   |    └── errors
|   |   |        └── exceptions.dart
|   |   |        └── failures.dart
|   |   |    └── factories
|   |   |        └── server_exception_factory.dart
|   |   |    └── models
|   |   |        └── jsonable.dart
|   |   |        └── model.dart
|   |   |        └── list_response.dart
|   |   |        └── list_response.g.dart
|   |   |        └── meta.dart
|   |   |        └── meta.g.dart
|   |   |        └── single_m_response.dart
|   |   |        └── single_response.dart
|   |   |        └── single_response.g.dart
|   |   |        └── success_response.dart
|   |   |        └── success_response.g.dart
|   |   |    └── api.dart
|   |   |    └── api_client.dart
|   |   |    └── data_source.dart
|   |   |    └── errors.dart
|   |   |    └── factories.dart
|   |   |    └── models.dart
│   │   ├──  utils
│   │   │    └── device_utils.dart
│   │   │    └── size_util.dart
│   │   │    └── string_extension.dart
│   │   ├── auth.dart
│   │   ├── cache.dart
│   │   ├── injection.dart
│   │   ├── network.dart
│   │   └── utils.dart
│   └── core.dart
├── pubspec.lock
├── pubspec.yaml
```
