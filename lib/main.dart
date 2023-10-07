import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/features/auth/screens/auth_screen.dart';
import 'package:paper_recycling_shopper/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      onGenerateRoute: (settings) => genereateRoute(settings),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthScreen()
    );
  }
}
