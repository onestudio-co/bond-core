library app_router;

import 'package:auto_route/auto_route.dart';
import 'package:bond_core/bond_core.dart';
import 'package:flutter/material.dart';

import '../features/form/login_form_page.dart';


part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginFormPage, initial: true ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super();
}

AppRouter get appRouter => sl<AppRouter>();
