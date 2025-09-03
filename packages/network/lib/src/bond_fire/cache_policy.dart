part of 'base_bond_api_request.dart';

/// Caching strategy for GET requests.
///
/// These policies control how `GetBondApiRequest` reads/writes the cache and
/// whether it hits the network. Behavior is implemented in `execute()`
/// (or `streamExecute()` for `cacheThenNetwork`).
///
/// ### TL;DR
/// - `cacheElseNetwork`: Return cache **immediately** (if present), then **refresh in background**.
/// - `cacheThenNetwork`: **Stream** cache first (if present), then **emit fresh** result.
/// - `networkElseCache`: Try **network first**, fall back to **cache** on failure.
/// - `networkOnly`: Always **network**; ignore cache.
///
/// ### Notes
/// - Use `request.cache(duration: ..., cacheKey: ..., cachePolicy: ...)` to configure.
/// - `cacheThenNetwork` must be used with `streamExecute()`; `execute()` will throw.
///
/// Example:
/// ```dart
/// final req = _api.get<Product>('/catalog')
///            .cache(duration: const Duration(minutes: 10),
///                             cacheKey: 'catalog:list',
///                             cachePolicy: CachePolicy.cacheElseNetwork);
/// final data = await req.execute(); // returns cached immediately (if any), refreshes in background
/// ```
enum CachePolicy {
  /// **Cache-First, Background Refresh.**
  ///
  /// Behavior (in `execute()`):
  /// - If cache **exists**:
  ///   - Returns the cached value **immediately**.
  ///   - **Also** triggers a background network request to update the cache.
  /// - If cache **missing**:
  ///   - Fetches from network, stores in cache, and **returns** fresh data.
  ///
  /// Ideal for CMS/content where showing *something* fast matters, and a silent
  /// refresh keeps data warm for next time.
  cacheElseNetwork,

  /// **Cache, then Fresh — as a Stream.**
  ///
  /// Behavior (in `streamExecute()` only):
  /// - If cache **exists**: emits cached value **first**.
  /// - Then fetches from network, updates cache, and **emits** the fresh value.
  ///
  /// Notes:
  /// - Calling `execute()` with this policy throws `UnsupportedError`.
  /// - Use when the UI can react to **two emissions** (skeleton → cached → fresh).
  cacheThenNetwork,

  /// **Network-First, Fallback to Cache on Failure.**
  ///
  /// Behavior (in `execute()`):
  /// - Attempts network request and **returns** fresh data on success (and caches it).
  /// - On **network error**, if cache exists, **returns** cached data instead.
  /// - If both fail/missing, the error is **rethrown**.
  ///
  /// Good for “must be current” data but still resilient offline.
  networkElseCache,

  /// **Always Network.** Cache is ignored.
  ///
  /// Behavior (in `execute()`):
  /// - Always hits the network and **returns** fresh data.
  /// - Does **not** read cache; does **not** write cache (unless your request
  ///   code explicitly does so elsewhere).
  ///
  /// Use when caching is undesirable (e.g., highly dynamic or sensitive data).
  networkOnly,

  /// **Cache-First, No Silent Refresh.**
  ///
  /// Behavior:
  /// - If cache exists and is still valid:
  ///   - Returns the cached value immediately.
  ///   - **Skips** network call completely.
  /// - If cache missing or expired:
  ///   - Fetches from network, stores in cache, and returns fresh data.
  ///
  /// Ideal for data that rarely changes, or when you want to avoid unnecessary
  /// API calls while still leveraging cache.
  ///
  /// Use this when performance and minimizing requests are more important than
  /// always having the freshest data.
  cacheOnly,
}
