import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:siri_ai/pages/splash_screen.dart';
import 'package:siri_ai/pages/linear_regression.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
      routes: <GoRoute>[
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
