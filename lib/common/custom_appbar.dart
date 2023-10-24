// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/models/order.dart';
import 'package:paper_recycling_shopper/models/user.dart';
import 'package:badges/badges.dart' as badges;
import 'package:paper_recycling_shopper/providers/cart_quantity.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final orderServices = OrderServices();
  late List<Order> mineOrders;
  @override
  void initState() {
    super.initState();
    mineOrders = [];
    fetchCart();
  }

  void fetchCart() async {
    mineOrders = await orderServices.fetchMineOrders(
        context: context, page: 0, limit: 10, status: ORDER_STATUS["CREATED"]);
    Provider.of<CartQuantity>(context, listen: false)
        .setQuantity(mineOrders[0].orderDetails!.length);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      backgroundColor: GlobalVariables.bgColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: widget.user.avatar == null
                    ? Image.network(
                        DEFAULT_AVATAR_IMG,
                        width: 30,
                      )
                    : Image.network(widget.user.avatar!, width: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      widget.user.email,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {
            //to search page
          },
        ),
        IconButton(
          icon: badges.Badge(
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeContent: Text(
                context.watch<CartQuantity>().quantity.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: const Icon(Icons.shopping_cart_outlined)),
          onPressed: () {
            //to cart page
          },
        ),
      ],
    );
  }
}
