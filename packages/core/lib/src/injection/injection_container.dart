import 'package:get_it/get_it.dart';
import 'service_provider.dart';

/// A singleton instance of the `GetIt` service locator.
///
/// This provides a centralized access point to services and instances that have been registered
/// with `GetIt`.
///
/// Example of retrieving a service:
/// ```dart
/// final myService = sl<MyService>();
/// ```
///
/// It's recommended to use this within the app's startup logic or whenever a service needs to be retrieved.
final sl = GetIt.instance;

/// A list of [ServiceProvider]s used in the app.
///
/// Each [ServiceProvider] registers its own services, configurations, or
/// data providers into the `GetIt` service locator, serving as the foundation for the app's
/// dependency injection setup.
///
/// To setup your providers:
///
/// 1. Extend the [ServiceProvider] class.
/// 2. Add the provider's instance to this list.
/// 3. Ensure its services are registered in its `register()` method.
///
/// Usage example:
///
/// ```dart
/// final List<ServiceProvider> providers = [
///   // Framework Service Providers
///   FirebaseServiceProvider(),
///   AppServiceProvider(),
///   // ... other providers
/// ];
/// ```
List<ServiceProvider> appProviders = [];

/// Initializes and registers all the provided [ServiceProvider]s.
///
/// This function goes through each [ServiceProvider] provided and
/// registers their services with the `GetIt` instance. After successful registration,
/// the list of providers is assigned to the global [appProviders] list in the `bond_core` package.
///
/// It is crucial to call this function during the startup logic of the app to ensure all services
/// are registered and available for use.
///
/// Example usage:
///
/// ```dart
/// import 'package:bond_core/bond_core.dart' as core;
///
/// Future<void> main() async {
///   await core.init(providers);
///   runApp(MyApp());
/// }
/// ```
Future<void> init(List<ServiceProvider> incomingProviders) async {
  for (final provider in incomingProviders) {
    await provider.register(sl);
  }
  appProviders = incomingProviders;
}
