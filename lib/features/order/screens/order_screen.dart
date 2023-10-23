import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/custom_appbar.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/models/order.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderServices = OrderServices();
  late Future<List<Order>> mineOrders;
  String chooseStatus = "SHIPPING";
  bool isChooseDeliverStatus = true;
  bool isChooseConfirmStatus = false;
  bool isChooseCancelStatus = false;
  @override
  void initState() {
    super.initState();
    mineOrders = orderServices.fetchMineOrders(
        context: context,
        page: 0,
        limit: 9999,
        sortBy: "createdAt",
        sortDirection: "DESC",
        status: ORDER_STATUS[chooseStatus]);
    //fetchOrderDetail();
  }

  // void fetchOrderDetail() async {
  //   try {
  //     // isLoading = true;
  //     List<Order> orders = await orderServices.fetchMineOrders(
  //       context: context,
  //       page: 0,
  //       limit: 10,
  //       status: ORDER_STATUS['SHIPPING'],
  //     );
  //     setState(() {
  //       mineOrders = orders;
  //     });
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   } finally {
  //     // isLoading = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(user: user),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Your Orders",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chooseStatus = "SHIPPING";
                          mineOrders = orderServices.fetchMineOrders(
                              context: context,
                              page: 0,
                              limit: 9999,
                              sortBy: "createdAt",
                              sortDirection: "DESC",
                              status: ORDER_STATUS[chooseStatus]);
                          isChooseConfirmStatus = false;
                          isChooseCancelStatus = false;
                          isChooseDeliverStatus = true;
                        });
                      },
                      child: Icon(Icons.local_shipping_outlined,
                          size: 25,
                          color: isChooseDeliverStatus
                              ? Colors.blue
                              : Colors.black),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(
                            side: BorderSide(
                          color: isChooseDeliverStatus
                              ? Colors.blue
                              : Colors.black,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Delivering",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chooseStatus = "COMPLETED";
                          mineOrders = orderServices.fetchMineOrders(
                              context: context,
                              page: 0,
                              limit: 9999,
                              sortBy: "createdAt",
                              sortDirection: "DESC",
                              status: ORDER_STATUS[chooseStatus]);
                          isChooseConfirmStatus = true;
                          isChooseCancelStatus = false;
                          isChooseDeliverStatus = false;
                        });
                      },
                      child: Icon(
                        Icons.done_all_outlined,
                        size: 25,
                        color: isChooseConfirmStatus
                            ? GlobalVariables.primaryColor.withOpacity(1)
                            : Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(
                            side: BorderSide(
                          color: isChooseConfirmStatus ? GlobalVariables.primaryColor.withOpacity(1) : Colors.black,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Confirmed",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chooseStatus = "CANCELLED";
                          mineOrders = orderServices.fetchMineOrders(
                              context: context,
                              page: 0,
                              limit: 9999,
                              sortBy: "createdAt",
                              sortDirection: "DESC",
                              status: ORDER_STATUS[chooseStatus]);
                          isChooseConfirmStatus = false;
                          isChooseCancelStatus = true;
                          isChooseDeliverStatus = false;
                        });
                      },
                      child: Icon(Icons.cancel_sharp,
                          size: 25,
                          color:
                              isChooseCancelStatus ? Colors.red : Colors.black),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(
                            side: BorderSide(
                          color: isChooseCancelStatus ? Colors.red : Colors.black,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Cancelled",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: mineOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: (isChooseDeliverStatus ? 250 : 120)+
                              90 *
                                  snapshot.data![index].orderDetails!.length
                                      .toDouble(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order code ${snapshot.data![index].id}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        "23/10/2023",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 80 *
                                      snapshot.data![index].orderDetails!.length
                                          .toDouble(),
                                  child: Column(
                                      // shrinkWrap: true,
                                      children: snapshot
                                          .data![index].orderDetails!
                                          .map((orderdetail) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.network(
                                              orderdetail.product!.images!
                                                  .split(',')[0],
                                              height: 60),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(orderdetail.product!.name!,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  )),
                                              Text(
                                                'x${orderdetail.quantity}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${snapshot.data![index].orderDetails!.length} products',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        '${snapshot.data![index].amount} PP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                isChooseDeliverStatus ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ElevatedButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          fixedSize: const Size(330, 60),
                                        ),
                                        child: const Text("Confirm Order",
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                ) : Text(""),
                                isChooseDeliverStatus ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ElevatedButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey.shade200,
                                          fixedSize: const Size(330, 60),
                                        ),
                                        child: const Text("Cancel Order",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ) : Text(""),
                              ],
                            ),
                          ),
                        ),
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
          )
        ],
      ),
    );
  }
}
