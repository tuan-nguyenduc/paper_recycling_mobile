import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/features/auth/screens/auth_screen.dart';

Route<dynamic> genereateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text("Screen is not found"),)
        ),
      );
  }
}
