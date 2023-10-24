import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/persistent_nav_bar.dart';
import 'package:paper_recycling_shopper/features/auth/screens/auth_screen.dart';
import 'package:paper_recycling_shopper/features/cart/screens/cart_screen.dart';
import 'package:paper_recycling_shopper/features/home/screens/home_screen.dart';
import 'package:paper_recycling_shopper/features/product/screens/product_detail.dart';
import 'package:paper_recycling_shopper/models/product.dart';

Route<dynamic> genereateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );

    // case BottomBar.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const BottomBar(),
    //   );

    case PersistentBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PersistentBottomBar(),
      );

    case ProductDetail.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetail(product: product),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
            body: Center(
          child: Text("Screen is not found"),
        )),
      );
  }
}
