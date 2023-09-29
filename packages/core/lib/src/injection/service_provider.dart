import 'package:get_it/get_it.dart';

/// An abstract class representing a service provider.
///
/// Service providers are central parts of the dependency injection system,
/// used to register and provide dependencies throughout the application.
/// Each service provider is responsible for registering one or multiple
/// services, utilities, or functionalities.
///
/// By implementing this class, developers can define custom logic to
/// initialize and register services, ensuring they are available for
/// injection elsewhere in the app using the [GetIt] instance.
///
/// To use a service provider, extend this class and override the [register]
/// method with the necessary registration logic.
///
/// Usage:
///
/// ```dart
/// class DatabaseServiceProvider extends ServiceProvider {
///   @override
///   Future<void> register(GetIt it) async {
///     it.registerLazySingleton(() => DatabaseService());
///   }
/// }
/// ```
///
/// After defining your service providers, use them in conjunction with
/// the injection container to initialize all dependencies at the start
/// of your application.
///
/// **Importance of Order**:
/// The order in which service providers are registered is critical. Providers
/// with dependencies on other services must be registered after their dependencies.
/// For example, a service that depends on Firebase should ensure that the Firebase
/// service provider is registered before it.
///
/// Developers should carefully manage the order, especially when adding new providers or
/// changing dependencies between services.
abstract class ServiceProvider {
  /// Registers services or dependencies within the provided [GetIt] instance.
  ///
  /// This method is called to initialize and make available various
  /// services or dependencies for the application. Override this method
  /// in your service provider implementations to specify custom
  /// registration logic.
  Future<void> register(GetIt it);
}
