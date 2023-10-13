import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/home';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("This is cart page"),
    );
  }
}
