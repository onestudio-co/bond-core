# 📘 Bond API Request – Simple Example

This file demonstrates how to make basic API requests using the Bond API system. It includes examples for GET and POST requests with optional caching, body submission, and custom deserialization.

---

## ✅ GET Request with Caching

```dart
final response = await GetBondApiRequest<MyModel>(dio, '/products')
  .factory((json) => MyModel.fromJson(json))
  .cache(
    duration: const Duration(minutes: 5),
    cacheKey: 'product-list',
    cachePolicy: CachePolicy.cacheElseNetwork,
  )
  .execute();
```

---

## 📨 POST Request with JSON Body

```dart
final response = await BaseBondApiRequest<MyResponseModel>(dio, '/login', method: 'POST')
  .body({
    'email': 'user@example.com',
    'password': 'secret',
  })
  .header({'Accept-Language': 'en'})
  .factory((json) => MyResponseModel.fromJson(json))
  .errorFactory((json) => ApiError.fromJson(json))
  .execute();
```

---

## 💾 Caching Custom Values from Response

```dart
final response = await BaseBondApiRequest<MyResponseModel>(dio, '/login', method: 'POST')
  .body({'email': 'me@example.com', 'password': 'password'})
  .factory((json) => MyResponseModel.fromJson(json))
  .cacheCustomKey('access_token', path: 'accessToken')
  .execute();

// Retrieve later:
final token = await Cache.get<String>('access_token');
```

---

## 🪪 Streaming with `cacheThenNetwork`

```dart
final stream = GetBondApiRequest<MyModel>(dio, '/profile')
  .cache(
    duration: Duration(minutes: 10),
    cacheKey: 'profile-data',
    cachePolicy: CachePolicy.cacheThenNetwork,
  )
  .factory((json) => MyModel.fromJson(json))
  .streamExecute();

stream.listen((data) {
  print('Profile: \${data.name}');
});
```

---

## 🛠 Model Example

```dart
class MyModel {
  final int id;
  final String name;

  MyModel({required this.id, required this.name});

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      MyModel(id: json['id'], name: json['name']);
}
```

