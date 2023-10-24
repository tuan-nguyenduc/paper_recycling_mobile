// ignore_for_file: unused_local_variable

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
  late List<Order> mineOrders;
  late List<OrderDetail> mineOrderDetails;
  bool isChangedQuantity = false;
  late int total = 0;
  bool isLoading = false;
  bool isCheckingOut = false;
  @override
  void initState() {
    super.initState();
    mineOrderDetails = [];
    total = 0;
    fetchOrderDetail();
  }

  void fetchOrderDetail() async {
    try {
      // isLoading = true;
      mineOrders = await orderServices.fetchMineOrders(
        context: context,
        page: 0,
        limit: 10,
        status: ORDER_STATUS['CREATED'],
      );
      if (mounted) {
        setState(() {
          mineOrderDetails = mineOrders[0].orderDetails!;
          for (int i = 0; i < mineOrderDetails.length; i++) {
            total += mineOrderDetails[i].price! * mineOrderDetails[i].quantity!;
          }
        });
      }
    } catch (e) {
      //throw Exception(e.toString());
    } finally {
      // isLoading = false;
    }
  }

  void decreaseQuantity(BuildContext context, int index, int orderId,
      int productId, int quantity) async {
    // print(
    //     'index: $index, orderId: $orderId productId: $productId, quantity: $quantity');
    total = 0;
    OrderDetail res = await orderServices.updateOrder(
        context: context,
        orderId: orderId,
        productId: productId,
        quantity: quantity - 1);
    if (mounted) {
      if (quantity == 1) {
        total = 0;
        setState(() {
          mineOrderDetails.removeAt(index);
          for (int i = 0; i < mineOrderDetails.length; i++) {
            total += mineOrderDetails[i].price! * mineOrderDetails[i].quantity!;
          }
        });
      } else {
        setState(() {
          mineOrderDetails[index].quantity = res.quantity;
          mineOrderDetails[index].price = res.price;
          mineOrderDetails[index].updatedAt = res.updatedAt;
          for (int i = 0; i < mineOrderDetails.length; i++) {
            total += mineOrderDetails[i].price! * mineOrderDetails[i].quantity!;
          }
        });
      }
    }
  }

  void increaseQuantity(BuildContext context, int index, int orderId,
      int productId, int quantity) async {
    OrderDetail res = await orderServices.updateOrder(
        context: context,
        orderId: orderId,
        productId: productId,
        quantity: quantity + 1);
    total = 0;
    if (mounted) {
      setState(() {
        mineOrderDetails[index].quantity = res.quantity;
        mineOrderDetails[index].price = res.price;
        mineOrderDetails[index].updatedAt = res.updatedAt;
        for (int i = 0; i < mineOrderDetails.length; i++) {
          total += mineOrderDetails[i].price! * mineOrderDetails[i].quantity!;
        }
      });
    }
  }

  void clearCart() async {
    for (int i = 0; i < mineOrderDetails.length; i++) {
      await orderServices.updateOrder(
          context: context,
          orderId: mineOrderDetails[i].orderId,
          productId: mineOrderDetails[i].productId,
          quantity: 0);
    }
    if (mounted) {
      setState(() {
        mineOrderDetails = [];
        total = 0;
      });
    }
  }

  void purchaseCart() async {
    try {
      setState(() {
        isCheckingOut = true;
      });
      String res = await orderServices.purchaseOrder(
          context: context, orderId: mineOrders[0].id!);
      if (mounted) {
        setState(() {
          mineOrderDetails = [];
          total = 0;
        });
      }
    } catch (e) {
       // ignore: use_build_context_synchronously
       ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Your cart is empty!")));
    } finally {
      setState(() {
        isCheckingOut = false;
      });
    }
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
                      onPressed: () => clearCart(),
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
              isLoading
                  ? const CircularProgressIndicator()
                  : mineOrderDetails.isEmpty
                      ? const Text("Your cart is empty!")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mineOrderDetails.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                              orderDetail: mineOrderDetails[index],
                              onAdd: () => increaseQuantity(
                                  context,
                                  index,
                                  mineOrderDetails[index].orderId!,
                                  mineOrderDetails[index].productId!,
                                  mineOrderDetails[index].quantity!),
                              onRemove: () => decreaseQuantity(
                                  context,
                                  index,
                                  mineOrderDetails[index].orderId!,
                                  mineOrderDetails[index].productId!,
                                  mineOrderDetails[index].quantity!),
                            );
                          }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('$total PP',
                        style: Theme.of(context).textTheme.headlineSmall),
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
                onPressed: () => isCheckingOut ? null : purchaseCart(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(330, 60),
                ),
                child: Text(isCheckingOut ? "Checking out..." : "Checkout", style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
