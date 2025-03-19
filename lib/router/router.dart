import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:siri_ai/pages/home_page.dart';
import 'package:siri_ai/pages/splash_screen.dart';
import 'package:siri_ai/pages/tasks/linear_regression.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
      routes: <GoRoute>[
        GoRoute(
          path: "/home",
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        ),
        GoRoute(
          path: "/linear",
          builder: (BuildContext context, GoRouterState state) {
            return LinearRegression();
          },
        ),
      ],
    ),
  ],
);
