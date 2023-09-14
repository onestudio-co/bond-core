import 'package:example/features/auth/presentations/login_page.dart';
import 'package:example/features/pizza/presentations/pizza_order_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const PizzaOrderPage(),
    ),
  ],
);
