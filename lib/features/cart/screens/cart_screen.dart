import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/custom_appbar.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/features/cart/widgets/cart_item.dart';
import 'package:paper_recycling_shopper/models/order.dart';
import 'package:paper_recycling_shopper/models/order_detail.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final orderServices = OrderServices();
  late Future<List<Order>> mindeOrders;
  late Future<List<OrderDetail>> mindeOrderDetails;
  bool isChangedQuantity = false;
  @override
  void initState() {
    super.initState();
    mindeOrders = orderServices.fetchMineOrders(
      context: context,
      page: 0,
      limit: 10,
      status: ORDER_STATUS['CREATED'],
    );

    //orderdetail of created order (in cart) => one user has only one item => first item of orderlist
    mindeOrderDetails = mindeOrders.then((value) {
      return value.first.orderDetails!;
    });
    // print(mindeOrderDetails);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(user: user),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Cart",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: mindeOrderDetails,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(child: Text("Your cart is empty.")),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            orderDetail: snapshot.data![index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: Theme.of(context).textTheme.titleLarge),
                    FutureBuilder(
                      future: mindeOrderDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int total = 0;
                          for (int i = 0; i < snapshot.data!.length; i++) {
                            total += snapshot.data![i].price! *
                                snapshot.data![i].quantity!;
                          }
                          return Text('$total PP',
                              style: Theme.of(context).textTheme.headlineSmall);
                        } else {
                          return const Center(
                            child: Text(""),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(330, 60),
                ),
                child: const Text("Checkout", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
