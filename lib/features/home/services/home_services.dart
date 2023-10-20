// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/error_handling.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/models/category.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchProducts({
    required BuildContext context,
    int? page,
    int? limit,
    int? categoryId,
    String? sortBy,
    String? sortDirection,
    String? q,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      String url = '$API_URL/products';
      if (page != null) {
        url += '?page=$page';
      }
      if (limit != null) {
        url += '&limit=$limit';
      }
      if (categoryId != null) {
        url += '&categoryId=$categoryId';
      }
      if (sortBy != null) {
        url += '&sortBy=$sortBy';
      }
      if (sortDirection != null) {
        url += '&sortDirection=$sortDirection';
      }
      if (q != null) {
        url += '&q=$q';
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
              productList.add(Product.fromJson(
                  jsonEncode(jsonDecode(res.body)['data']['contents'][i])));
              // print(
              //     Product.fromJson(
              //     jsonEncode(jsonDecode(res.body)['data']['contents'][i])).toJson());
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return productList;
  }

  Future<List<Category>> fetchCategories({
    required BuildContext context,
    int? page,
    int? limit,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Category> categoriesList = [];
    try {
      String url = '$API_URL/categories';
      if (page != null) {
        url += '?page=$page';
      }
      if (limit != null) {
        url += '&limit=$limit';
      }
      //print(url);

      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.user.token}',
      });

      //print(jsonEncode(res.body));
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['data'].length; i++) {
              categoriesList.add(Category.fromJson(
                  jsonEncode(jsonDecode(res.body)['data'][i])));
              // print(
              //     Product.fromJson(
              //     jsonEncode(jsonDecode(res.body)['data']['contents'][i])).toJson());
            }
          });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return categoriesList;
  }
}
