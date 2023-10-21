// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paper_recycling_shopper/constants/error_handling.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/models/order.dart';
import 'package:paper_recycling_shopper/models/order_detail.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OrderServices {
  Future<List<Order>> fetchMineOrders({
    required BuildContext context,
    int? page,
    int? limit,
    int? status,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      String url = '$API_URL/orders/mine';
      if (page != null) {
        url += '?page=$page';
      }
      if (limit != null) {
        url += '&limit=$limit';
      }
      if (status != null) {
        url += '&status=$status';
      }

      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.user.token}',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0;
                i < jsonDecode(res.body)['data']['contents'].length;
                i++) {
              orderList.add(Order.fromJson(
                  jsonEncode(jsonDecode(res.body)['data']['contents'][i])));
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return orderList;
  }

  Future<String> createOrder({
    required BuildContext context,
    required productId,
    required quantity,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String createOrderData = "";
    try {
      String url = '$API_URL/orders';
      http.Response res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userProvider.user.token}',
        },
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
      );
      createOrderData = res.body;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return createOrderData;
  }
}
