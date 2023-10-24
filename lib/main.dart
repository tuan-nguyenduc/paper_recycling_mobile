import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/persistent_nav_bar.dart';
import 'package:paper_recycling_shopper/features/auth/screens/auth_screen.dart';
import 'package:paper_recycling_shopper/providers/cart_quantity.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:paper_recycling_shopper/router.dart';
import 'package:provider/provider.dart';

void main() {
  //SharedPreferences.setMockInitialValues({});
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider()), ChangeNotifierProvider(create: (context) => CartQuantity())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      debugShowCheckedModeBanner: false,
      home: Provider.of<UserProvider>(context).user.token!.isNotEmpty
          ? const PersistentBottomBar()
          : const AuthScreen(),
      onGenerateRoute: (settings) => genereateRoute(settings),
    );
  }
}
