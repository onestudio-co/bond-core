import 'package:example/features/auth/login_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginFormPage(),
    ),
  ],
);
