// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginFormRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginFormPage(),
      );
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          LoginFormRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [LoginFormPage]
class LoginFormRoute extends PageRouteInfo<void> {
  const LoginFormRoute()
      : super(
          LoginFormRoute.name,
          path: '/',
        );

  static const String name = 'LoginFormRoute';
}
