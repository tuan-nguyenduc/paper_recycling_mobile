// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paper_recycling_shopper/models/order_detail.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';

class CartItem extends StatelessWidget {
  final OrderDetail orderDetail;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  CartItem({
    Key? key,
    required this.orderDetail,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);


  final orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      orderDetail.product!.images!.split(',')[0],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(orderDetail.product!.name!,
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => onRemove(),
                              icon: const Icon(Icons.remove_circle_outline)),
                          Text(
                            orderDetail.quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                              onPressed: () => onAdd(),
                              icon: const Icon(Icons.add_circle_outline)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${orderDetail.price!*orderDetail.quantity!} PP',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
